'''
Created on Aug 16, 2014

@author: Dallas Fraser
@contact: fras2560@mylaurier.ca
@summary: This module helps generate a html report for all github issues
@requires: requests
@requires: mako
'''
import unittest
import requests
from mako.template import Template
from config import Settings
from pprint import PrettyPrinter
class Github():
    '''
    @param user: The user's github name
    @param password: The user's github passwor
    '''
    def __init__(self,user, password):
        self.user = user
        self.password = password
        self.base = 'https://api.github.com/'
        self.pp = PrettyPrinter(indent=4)


    ''''
    @summary: This function generate a html report for each repos
              the output file is called output.html
    @param repos: a python list of repos to pull 
                  each a dictionary with name and owner
    '''
    def generate_html_report(self,repos):
        output_results = []
        for repo in repos:
            issues = self.pull_issues(repo['name'], repo['owner'])
            for issue in issues:
                output_results.append(self.parse_issue(issue))
        self.pp.pprint(output_results)
        mytemplate = Template(filename='template.mako')
        with open('output.html', 'w+') as doc:
            print(mytemplate.render(issues=output_results))
            doc.write(mytemplate.render(issues=output_results))


    '''
    @summary:  the file process the url request and returns the json data
    @param url: the url for the request
    @param payload: the paramaters for the request (dictionary)  
    '''
    def request(self, url, payload={}):
        r = requests.get(url, auth=(self.user, self.password),params=payload)
        data = None
        if r.status_code == 200:
            data = r.json()
        return data


    '''
    @summary: a function that pulls the issue for that repo
    @param repo: The repo name on github
    @param owner: The owner of the repo on github  
    '''
    def pull_issues(self, repo, owner):
        url = self.base + ('repos/%s/%s/issues' % (owner, repo))
        print(url)
        return self.request(url, {'state':'closed', 'per_page':100})


    '''
    @summary: pulls the wanted information from the issue
    @param issue: the github issues from their APIs
    @see:  https://developer.github.com/v3/issues/
    '''
    def parse_issue(self, issue):
        description = issue['body']
        if issue['comments'] > 0:
            comments = self.pull_comments(issue['comments_url'])
        else:
            comments = []
        title = issue['title']
        url = issue['url']
        sqa = issue['user']['login']
        lables = []
        opened = issue['created_at']
        closed = issue['closed_at']
        if issue['assignee'] is not None:
            solved = issue['assignee']['login']
        else:
            solved = ''
        for label in issue['labels']:
            lables.append(label['name'])
        lables = ", ".join(lables)
        result = {'description':description,'comments':comments, 'title':title,
                  'url':url, 'sqa':sqa, 'opened':opened,
                  'closed':closed, 'solved':solved, 'lables':lables}
        return result


    '''
    @summary: a function that pulls all the comments for a specific github issue
    @param: the github url for the issue's comments
    '''
    def pull_comments(self, url):
        comments = self.request(url)
        result = []
        for comment in comments:
            result.append(self.parse_comments(comment))
        return result


    '''
    @summary: a function to parse the comment and pull the important info
    @param comment: The github comment
    @see: https://developer.github.com/v3/repos/comments/ 
    '''
    def parse_comments(self, comment):
        description = comment['body']
        date = comment['created_at']
        user = comment['user']['login']
        result = {'description':description,
                  'date':date, 'user':user}
        return result


class Test(unittest.TestCase):


    def setUp(self):
        self.settings = Settings()
        self.user = self.settings.USER
        self.pw = self.settings.PASSWORD
        self.git = Github(self.user, self.pw)
        self.pp = PrettyPrinter(indent=4)
        self.docs = {'owner':'jmuia','name':'dj-web-app-docs'}
        self.partyAllService = {'owner':'robinsharma', 'name':'partyall-service'}
        self.partyAllApp = {'owner':'robinsharma', 'name':'partyall'}


    def testPullIssues(self):
        d = self.git.pull_issues(self.docs['name'], self.docs['owner'])
        self.pp.pprint(d)
        self.pp.pprint(len(d))


    def testGenReport(self):
        repos = [self.docs,self.partyAllService, self.partyAllApp]
        self.git.generate_html_report(repos)


if __name__ == "__main__":
    #import sys;sys.argv = ['', 'Test.testName']
    unittest.main()