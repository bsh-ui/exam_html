import requests
from bs4 import BeautifulSoup
import csv
import time

# 저장 파일 이름
FILENAME = 'Crawler&Scraping교과목테스트.csv'

# 네이버 금융 코스피 시가총액 순위 페이지 (1~2페이지 = 50개)
BASE_URL = 'https://finance.naver.com/sise/sise_market_sum.naver?sosok=0&page={}'

# 컬럼명 정의
COLUMNS = ['종목명', '현재가', '전일비', '등락률', '시가총액', 'PER', 'ROE']

def get_kospi_top50():
    results = []

    for page in range(1, 3):  # 1~2 페이지 (50위까지)
        url = BASE_URL.format(page)
        headers = {'User-Agent': 'Mozilla/5.0'}
        res = requests.get(url, headers=headers)
        soup = BeautifulSoup(res.text, 'html.parser')

        table = soup.select_one('table.type_2')
        rows = table.select('tbody tr')

        for row in rows:
            cols = row.find_all('td')
            if len(cols) < 2:
                continue

            try:
                name = cols[1].get_text(strip=True)
                price = cols[2].get_text(strip=True)
                diff = cols[3].get_text(strip=True)
                rate = cols[4].get_text(strip=True)
                market_cap = cols[6].get_text(strip=True)
                per = cols[10].get_text(strip=True)
                roe = cols[11].get_text(strip=True)

                results.append([name, price, diff, rate, market_cap, per, roe])
            except Exception as e:
                print("파싱 중 오류 발생:", e)
                continue

        time.sleep(1)  # 서버에 부담 주지 않도록 대기

    return results

def save_to_csv(data):
    with open(FILENAME, 'w', newline='', encoding='utf-8-sig') as f:
        writer = csv.writer(f)
        writer.writerow(COLUMNS)
        writer.writerows(data)
    print(f'CSV 저장 완료: {FILENAME}')

if __name__ == '__main__':
    data = get_kospi_top50()
    save_to_csv(data)


