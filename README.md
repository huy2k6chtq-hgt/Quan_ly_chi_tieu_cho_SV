# Quản lý thu chi sinh viên

Ứng dụng giúp sinh viên ghi nhận các khoản thu, chi theo ví và danh mục, theo dõi số dư và quản lý chi tiêu cá nhân. Tiền được lưu bằng số nguyên VND.

## Thiết kế dữ liệu

Schema hiện nằm tại [db/schema.sql](db/schema.sql). Repo chưa có đường dẫn `database/schema.sql`.

| Bảng | Vai trò |
| --- | --- |
| `users` | Lưu tài khoản người dùng và mật khẩu đã hash. |
| `wallets` | Lưu các ví của người dùng và số dư ban đầu không âm. |
| `categories` | Phân loại thu (`income`) hoặc chi (`expense`) cho từng người dùng. |
| `transactions` | Ghi nhận giao dịch, số tiền dương, loại thu/chi, ví, danh mục và thời gian. |

Một người dùng có nhiều ví, danh mục và giao dịch. Mỗi giao dịch thuộc một người dùng, một ví và một danh mục. Khóa ngoại ghép bảo đảm ví và danh mục thuộc đúng người dùng, đồng thời loại giao dịch khớp loại danh mục.

## Công nghệ dự kiến

- **Flask:** xử lý backend và kết nối cơ sở dữ liệu.
- **HTML/CSS/JavaScript:** xây dựng giao diện và tương tác.
- **PostgreSQL:** lưu trữ dữ liệu và kiểm tra các ràng buộc.

## Tiến độ và triển khai

Đã thiết kế schema 4 bảng; chưa chạy thử database.

Neon (PostgreSQL) và Vercel (ứng dụng web) sẽ được cấu hình và triển khai vào ngày cuối của dự án.
