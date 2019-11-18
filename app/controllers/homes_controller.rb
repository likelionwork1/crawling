class HomesController < ApplicationController
  def index
  end
  
  def daumcafe
    Selenium::WebDriver::Chrome.driver_path = `which chromedriver-helper`.chomp # Selenium이 크롬으로 동작하도록 선언
    options = Selenium::WebDriver::Chrome::Options.new # Selenium 동작 시 필요한 설정을 위하여
    options.add_argument('--disable-gpu') # 크롬 헤드리스 모드 사용 위해 disable-gpu setting
    options.add_argument('--headless') # 크롬 헤드리스 모드 사용 위해 headless setting
    browser = Selenium::WebDriver.for :chrome, options: options # 위 조건들을 만족하는 셀레니움 객체 생성
    
    browser.get 'http://m.cafe.daum.net/ASMONACOFC/gAWF?boardType=' # 목표 URL 로드
    content = browser.find_elements(xpath: "/html/body/div[1]/div[1]/article/div[1]/div/ul/li") # 찾고자하는 대상 xpath방식으로 찾기
    @size = content.size
    
    @entry = Array.new # 데이터를 저장할 배열 선언
    content.each do |c| # 찾은 대상 순회
        title = c.find_element(class: "txt_detail").text # 대상 중 추출하고자 하는 부분을 class이름으로 찾기
        link = c.find_element(tag_name: "a").attribute("href") # 대상 중 추출하고자 하는 부분을 tag_name으로 찾기
        @entry += [[title, link]] # 찾은 제목과 링크 배열에 추가
    end
    
    browser.quit # Selenium 객체 종료
  end

  def navertv
    Selenium::WebDriver::Chrome.driver_path = `which chromedriver-helper`.chomp # Selenium이 크롬으로 동작하도록 선언
    options = Selenium::WebDriver::Chrome::Options.new # Selenium 동작 시 필요한 설정을 위하여
    options.add_argument('--disable-gpu') # 크롬 헤드리스 모드 사용 위해 disable-gpu setting
    options.add_argument('--headless') # 크롬 헤드리스 모드 사용 위해 headless setting
    browser = Selenium::WebDriver.for :chrome, options: options # 위 조건들을 만족하는 셀레니움 객체 생성
    
    browser.get 'https://tv.naver.com/' # 목표 URL 로드
    
    #######################################
    # 방법 1
    #######################################
    content = browser.find_elements(xpath: "/html/body/div[2]/div[3]/div[2]/div[1]/div/div/ul/li") # 찾고자하는 대상 xpath방식으로 찾기
    
    @entry = Array.new
    rank = 1
    content.each do |c|
      title = c.find_element(tag_name: "tooltip").attribute("title")
      link = c.find_element(tag_name: "a").attribute("href")
      
      @entry += [[rank, title, link]]
      rank += 1
    end
    
    browser.quit # browser 종료시키기
    
    ########################################
    # # 방법 2
    ########################################
    # content = browser.find_elements(xpath: "/html/body/div[2]/div[3]/div[2]/div[1]/div/div/ul/li") # 찾고자하는 대상 xpath방식으로 찾기
    # next_btn = browser.find_element(xpath: "/html/body/div[2]/div[3]/div[2]/div[1]/div/a[2]")
    
    # @entry = Array.new
    # content.each_with_index do |item, key|
    #     rank = key + 1 # 순위 뽑기
        
    #     if rank%5 == 0 # 5개 넘을 때마다 다음 랭크 버튼 누르게 하기
    #       next_btn.click
    #       sleep 0.2 # 로드 시간 sleep 하기
    #     end
        
    #     title = item.find_element(tag_name: "tooltip").text # 순위 title 출력
    #     link = item.find_element(tag_name: "a").attribute("href")
        
    #     @entry += [[rank, title, link]]
    # end
    
    # browser.quit # browser 종료시키기
  end
  
  def navercafe
    Selenium::WebDriver::Chrome.driver_path = `which chromedriver-helper`.chomp # Selenium이 크롬으로 동작하도록 선언
    options = Selenium::WebDriver::Chrome::Options.new # Selenium 동작 시 필요한 설정을 위하여
    options.add_argument('--disable-gpu') # 크롬 헤드리스 모드 사용 위해 disable-gpu setting
    options.add_argument('--headless') # 크롬 헤드리스 모드 사용 위해 headless setting
    browser = Selenium::WebDriver.for :chrome, options: options # 위 조건들을 만족하는 셀레니움 객체 생성
    
    browser = browser.get 'https://nid.naver.com/nidlogin.login' # 로그인 페이지 가기

    userID = browser.find_element(id: "id")
    userID.send_keys "#{ENV["NAVER_ID"]}" # 입력
    
    userPW = browser.find_element(id: "pw")
    userPW.send_keys "#{ENV["NAVER_PW"]}" # 입력
    
    browser.find_element(class: "btn_global").click # 로그인 버튼 제출
    
    browser.navigate().to "https://m.cafe.naver.com/ArticleList.nhn?search.clubid=10050146&search.menuid=1327&search.boardtype=L" # 페이지 이동
    
    content = browser.find_elements(css: "strong.tit") # 원하는 데이터 css 기반으로 찾기
    
    content.each do |t|
        puts t.text
        puts "--------"
    end
    
    @browser.quit
  end

end
