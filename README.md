# GPM Profile Language Switcher

Công cụ PowerShell script giúp chuyển đổi ngôn ngữ mặc định của profile GPM sang tiếng Anh (en-US).

[English version below](#english)

## Tính năng

- Chuyển đổi ngôn ngữ mặc định của profile GPM sang tiếng Anh (en-US)
- Hỗ trợ chuyển đổi một profile hoặc tất cả profile cùng lúc
- Tự động tạo file backup trước khi thực hiện thay đổi
- Ghi log đầy đủ quá trình thực hiện
- Giao diện dòng lệnh thân thiện với người dùng

## Yêu cầu hệ thống

- Windows với PowerShell
- GPM đã được cài đặt
- Quyền truy cập vào thư mục chứa profile GPM

## Hướng dẫn sử dụng

1. Tải file `change-profiles-lang-ENG-v2.ps1` về máy

2. Mở PowerShell với quyền Administrator

3. Di chuyển đến thư mục chứa script:
```powershell
cd đường-dẫn-tới-thư-mục-chứa-script
```

4. Chạy script:
```powershell
.\change-profiles-lang-ENG-v2.ps1
```

5. Làm theo các bước trên màn hình:
   - Chọn chế độ chuyển đổi (một profile hoặc tất cả profile)
   - Nhập đường dẫn thư mục profile GPM hoặc profile cụ thể
   - Xác nhận tạo backup (và nén ZIP nếu cần)
   - Đợi quá trình hoàn tất

Script sẽ tạo file log với định dạng `change_language_log_DDMMYYYY_HHMMSS.txt` trong thư mục hiện tại.

## Ví dụ đường dẫn

- Thư mục chứa tất cả profile: `C:\GPM-data`
- Profile cụ thể: `C:\GPM-data\6e513aa9-0a9e-4812-aca9-c794d352c7ac-7954`

## Lưu ý

- Nên tạo backup trước khi thực hiện chuyển đổi
- Đảm bảo đã đóng tất cả các profile GPM đang chạy
- Kiểm tra file log để xem chi tiết quá trình thực hiện
- Nếu gặp lỗi, vui lòng kiểm tra log và báo cáo issue

## Đóng góp

Mọi đóng góp đều được chào đón! Nếu bạn có ý tưởng cải thiện, hãy:

1. Fork repository
2. Tạo branch mới (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Mở Pull Request

## Giấy phép

Distributed under the MIT License. Xem `LICENSE` để biết thêm thông tin.

## Liên hệ

Twitter - [@nauthnael](https://twitter.com/nauthnael)

GitHub - [@nauthnael](https://github.com/nauthnael)

Project Link: [https://github.com/nauthnael/gpm-profile-language-switcher](https://github.com/nauthnael/gpm-profile-language-switcher)

---

<a name="english"></a>
# GPM Profile Language Switcher

A PowerShell script tool to change the default language of GPM profiles to English (en-US).

## Features

- Changes default profile language to English (en-US)
- Supports converting single profile or all profiles at once
- Automatic backup creation before making changes
- Detailed logging of the entire process
- User-friendly command-line interface

## System Requirements

- Windows with PowerShell
- GPM installed
- Access to GPM profiles directory

## Usage

1. Download `change-profiles-lang-ENG-v2.ps1`

2. Open PowerShell as Administrator

3. Navigate to script directory:
```powershell
cd path-to-script-directory
```

4. Run the script:
```powershell
.\change-profiles-lang-ENG-v2.ps1
```

5. Follow the on-screen instructions:
   - Choose conversion mode (single profile or all profiles)
   - Enter GPM profiles directory path or specific profile path
   - Confirm backup creation (and ZIP compression if needed)
   - Wait for the process to complete

The script will create a log file named `change_language_log_DDMMYYYY_HHMMSS.txt` in the current directory.

## Path Examples

- All profiles directory: `C:\GPM-data`
- Specific profile: `C:\GPM-data\6e513aa9-0a9e-4812-aca9-c794d352c7ac-7954`

## Notes

- Creating a backup is recommended before conversion
- Ensure all GPM profiles are closed before running
- Check the log file for detailed execution information
- If you encounter issues, check logs and report issues

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Contact

Twitter - [@nauthnael](https://twitter.com/nauthnael)

GitHub - [@nauthnael](https://github.com/nauthnael)

Project Link: [https://github.com/nauthnael/gpm-profile-language-switcher](https://github.com/nauthnael/gpm-profile-language-switcher)
