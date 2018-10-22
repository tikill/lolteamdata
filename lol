from selenium import webdriver
from bs4 import BeautifulSoup
import time
from prettytable import PrettyTable
teamlist = []
datalist = []
thlist = []
driver = webdriver.Chrome()
driver.get("http://www.famulei.com/data/team")
time.sleep(3)
html = driver.page_source
soup = BeautifulSoup(html,"html.parser")
teams = soup.find_all("p",class_ = "team_name")
for team in teams:
    teamlist.append(team.text)
table = soup.find("table",class_ = "data-table main")
teamdata_all = table.find_all("tr")
data_table = soup.find("table",class_ = "data-table main")
ths = data_table.find_all("th")
for th in ths:
    thlist.append(th.text)
for teamdata in teamdata_all:
    datas = teamdata.find_all("td")
    data_list = []
    for data in datas:
        data_list.append(data.text.replace(" ",""))
    datalist.append(data_list)
datalist = [x for x in datalist if x]
for i in range(len(teamlist)):
    datalist[i].insert(0,str(teamlist[i]))
thlist.insert(0,"战队")
table = PrettyTable(thlist)
for i in datalist:
    table.add_row(i)
print(table)
driver.quit()
