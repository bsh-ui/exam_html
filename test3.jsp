<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>사원 테이블 조회</title>
</head>
<body>
    <h1>사원 테이블 조회 결과</h1>

    <table border="1">
        <thead>
            <tr>
                <th>사원 번호</th>
                <th>사원 이름</th>
                <th>직무</th>
                <th>관리자 번호</th>
                <th>입사일</th>
                <th>급여</th>
                <th>상여금</th>
                <th>부서 번호</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Oracle DB 연결 정보
                String url = "jdbc:oracle:thin:@localhost:1521:xe";  // Oracle DB URL
                String username = "scott";  // DB 사용자 이름
                String password = "tiger"; // DB 비밀번호

                // JDBC 연결
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    // JDBC 드라이버 로드
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    
                    // DB 연결
                    conn = DriverManager.getConnection(url, username, password);
                    
                    // SQL 쿼리
                    String sql = "SELECT * FROM EMP";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(sql);

                    // 데이터 출력
                    while (rs.next()) {
            %>
                        <tr>
                            <td><%= rs.getInt("EMPNO") %></td>
                            <td><%= rs.getString("ENAME") %></td>
                            <td><%= rs.getString("JOB") %></td>
                            <td><%= rs.getInt("MGR") %></td>
                            <td><%= rs.getDate("HIREDATE") %></td>
                            <td><%= rs.getInt("SAL") %></td>
                            <td><%= rs.getInt("COMM") %></td>
                            <td><%= rs.getInt("DEPTNO") %></td>
                        </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("오류 발생: " + e.getMessage());
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException se) {
                        se.printStackTrace();
                    }
                }
            %>
        </tbody>
    </table>
</body>
</html>
