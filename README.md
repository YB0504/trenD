# TrenD
> 한 줄 설명
## 프로젝트 링크
## 소개
본 프로젝트는 실시간 트랜드에 관심 있는 사용자들을 위한 댓글형 스레드 커뮤니티로 자유롭게 의견을 나눌 수 있는 새로운 소셜 경험을 제공하고자 합니다.  
Google Trends를 활용하여 오늘의 실시간 트랜드와 그와 관련된 뉴스링크를 제공하며, 댓글로 커뮤니티에 참여하는 사용자들의 성별 및 연령대, 지역별 통계를 통해 어떤 사용자들이 주로 관심을 갖는지 파악할 수 있습니다.  

## 개발 환경 및 tool
#JAVA #MySQL #Spring boot #HTML #CSS #JavaScript #JPA #Gradle #GitHub  #JQuery #Ajax #REST API #OpenAI API 
 #Tomcat #intelliJ #AWS #Linux

## DB 설계
![TrenD-Database](https://github.com/JunHyeokSeo/trenD/assets/55777781/d6d4da99-90f7-4e04-88e0-f8dcd3d51233)

## 주요기능 설명
| 기능 | 담당자 | 상세설명 |
| --- | --- | --- |
| 실시간 검색어 크롤링 | 함혜선 | -Rest API 형태로 Serp api를 사용하여 Google Trends 페이지 크롤링 </br> -openAI Api 연결하여 챗봇 구현</br>(답변 내용을 반응형 stream 구현/server side event 기술 사용)  |
| OAuth2.0 기반 소셜로그인 | 백대현 |  |
| 마이페이지 | 정소옥 |  |
| 목록 페이지 및 게시판 내부 검색 | 여인범 | REST API형태로 게시판별 데이터 목록 및 조건에 해당하는 데이터 조회 구현</br>JPA Repository에서 제공하는 Page Interface를 활용한 게시판 목록 페이징 구현 |
| 게시글 CRUD 및 통합 검색 | 김선홍 | Google Trends 리스트 조회 시 글 자동 등록</br>RestAPI 적용하여 검색결과를 한 페이지 내에서 트렌드/커뮤니티 개별 페이징 구현 |
| 통계 페이지 | 빈상욱 |  |
| 댓글 CRUD | 서준혁 | REST API 형태로 댓글 CRUD 구현</br>댓글 목록 페이징 구현|

## 담당작업
