'''
Created on Aug 15, 2014

@author: Dallas
'''
import unittest
import requests
from mako.template import Template
class Github():
    def __init__(self,user, password):
        self.user = user
        self.password = password
        self.base = 'https://api.github.com/'
        self.pp = PrettyPrinter(indent=4)

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


    def request(self, url, payload={}):
        r = requests.get(url, auth=(self.user, self.password),params=payload)
        data = None
        if r.status_code == 200:
            data = r.json()
        return data
    
    def pull_issues(self, repo, owner):
        url = self.base + ('repos/%s/%s/issues' % (owner, repo))
        print(url)
        return self.request(url, {'state':'closed'})
    
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
        result = {'description':description,'comments':comments, 'title':title,
                  'url':url, 'sqa':sqa, 'opened':opened,
                  'closed':closed, 'solved':solved}
        return result

    def pull_comments(self, url):
        comments = self.request(url)
        result = []
        for comment in comments:
            result.append(self.parse_comments(comment))
        return result


    def parse_comments(self, comment):
        description = comment['body']
        date = comment['created_at']
        user = comment['user']['login']
        result = {'description':description,
                  'date':date, 'user':user}
        return result


from pprint import PrettyPrinter
class Test(unittest.TestCase):


    def setUp(self):
        self.user = 'fras2560'
        self.pw = 'Lcc17pet'
        self.git = Github(self.user, self.pw)
        self.pp = PrettyPrinter(indent=4)


    def tearDown(self):
        pass


    def testGenReport(self):
        docs = {'owner':'jmuia','name':'dj-web-app-docs'}
        partyAllService = {'owner':'robinsharma', 'name':'partyall-service'}
        partyAllApp = {'owner':'robinsharma', 'name':'partyall'}
        repos = [docs,partyAllService, partyAllApp]
        self.git.generate_html_report(repos)

if __name__ == "__main__":
    #import sys;sys.argv = ['', 'Test.testName']
    unittest.main()