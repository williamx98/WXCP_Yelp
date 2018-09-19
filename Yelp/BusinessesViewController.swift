//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate {
    @IBOutlet weak var priceFilter: UISegmentedControl!
    
    var businesses: [Business]!
    var businessesCache: [Business]!
    var isMoreDataLoading = false
    var offset = 20
    var loadingMoreView:InfiniteScrollActivityView?
    @IBOutlet weak var tableView: UITableView!
    
    var searchBar: UISearchBar!
    var searchTerm = "Thai"
    var searching = false
    var selectedCell: Business!
    override func viewDidLoad() {
        super.viewDidLoad()
        let menu_button_ = UIBarButtonItem(title: "Settings", style: UIBarButtonItemStyle.plain, target: self, action: #selector(BusinessesViewController.showSettings))
        menu_button_.tintColor = UIColor.white
        searchBar = UISearchBar()
        searchBar.placeholder = "Search WXCP_Yelp..."
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = false;
        
        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = menu_button_
        priceFilter.addTarget( self, action: #selector(BusinessesViewController.loadData), for: UIControlEvents.valueChanged )
        let attributes = [NSForegroundColorAttributeName : UIColor.white]
        if #available(iOS 9.0, *) {
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        } else {
            // Fallback on earlier versions
            print("Ideally, this shouldnt happen. If it does, sorry.")
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        tableView.addSubview(loadingMoreView!)
        self.loadData()
        var insets = tableView.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        tableView.contentInset = insets
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessViewCell", for: indexPath) as! BusinessViewCell
        cell.business = businesses[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = businesses[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: Any?)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetails") {
            let detailsViewController = segue.destination as! DetailsViewController
            print(selectedCell.name)
            detailsViewController.business = selectedCell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            if(tableView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                self.isMoreDataLoading = true
                let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                if (searchTerm == "") {
                    self.loadingMoreView!.stopAnimating()
                }
                loadMoreData()
            }
        }
    }
    
    func loadData() {
        self.offset = 20
        if (self.searching == false && searchTerm.count != 0) {
            self.searching = true
            Business.searchWithTerm(term: self.searchTerm, price: priceFilter.selectedSegmentIndex, completion: { (businesses: [Business]?, error: Error?) -> Void in
                self.businesses = businesses
                self.businessesCache = businesses
                if (businesses?.count == 0) {
                    let alert = UIAlertController(title: "No Results Found", message: "Try a different search term", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                self.tableView.reloadData()
                self.searching = false;
            })
        }
    }
    
    func loadMoreData () {
        if (searchTerm != "") {
            Business.searchWithTerm(term: searchTerm, price: priceFilter.selectedSegmentIndex, offset: self.offset, completion: { (businesses: [Business]?, error: Error?) -> Void in
                if (businesses == nil) {
                    self.isMoreDataLoading = false
                    self.loadingMoreView!.stopAnimating()
                    return
                }
                self.businesses = self.businesses + businesses!
                self.businessesCache = self.businesses
                self.offset += 20
                self.tableView.reloadData()
                
                self.isMoreDataLoading = false
                self.loadingMoreView!.stopAnimating()
            }
            )
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showSettings() {
        performSegue(withIdentifier: "showSettings", sender: self)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        navigationItem.leftBarButtonItem = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text!
        self.loadData()
        searchBar.showsCancelButton = false
        let menu_button_ = UIBarButtonItem(title: "Filter", style: UIBarButtonItemStyle.plain, target: self, action: #selector(BusinessesViewController.showSettings))
        menu_button_.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = menu_button_
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        let menu_button_ = UIBarButtonItem(title: "Filter", style: UIBarButtonItemStyle.plain, target: self, action: #selector(BusinessesViewController.showSettings))
        menu_button_.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = menu_button_
        searchBar.endEditing(true)
    }
}

class InfiniteScrollActivityView: UIView {
    var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    static let defaultHeight:CGFloat = 60.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupActivityIndicator()
    }
    
    override init(frame aRect: CGRect) {
        super.init(frame: aRect)
        setupActivityIndicator()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicatorView.center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
    }
    
    func setupActivityIndicator() {
        activityIndicatorView.activityIndicatorViewStyle = .gray
        activityIndicatorView.hidesWhenStopped = true
        self.addSubview(activityIndicatorView)
    }
    
    func stopAnimating() {
        self.activityIndicatorView.stopAnimating()
        self.isHidden = true
    }
    
    func startAnimating() {
        self.isHidden = false
        self.activityIndicatorView.startAnimating()
    }
}
