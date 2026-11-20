# LAGRO NFC-ID

> An alternative NFC-based school ID system for **Lagro High School** (S.M.A.R.T. Lagronians). Students register once, and tapping their NFC card instantly shows their digital ID.

*School capstone project.*

---

## What is it?

LAGRO NFC-ID is a web application that links a student's NFC card to their school record. A scanner reads the card, the server looks up the student, and the page displays a digital ID with the student's photo, name, LRN, grade and section, and adviser.

## Purpose

Paper and plastic school IDs are easy to forget, lose, or fake, and checking them by hand is slow. This project replaces manual checking with a quick tap that pulls verified information straight from the school database.

## Goals

- Give every student a **fast, contactless ID check** (tap instead of showing a card to a guard).
- Keep all student records in **one central database** that the school controls.
- Make registration simple: one form, one NFC card.
- Give administrators a **dashboard** to view and manage student records.
- Lay the groundwork for future features such as attendance and gate logging.

## Who benefits?

| Who | How |
|---|---|
| **Students** | Quick entry and identity checks, no more waiting for manual ID inspection, and a digital ID tied to their card. A welcome email is sent after registration. |
| **Teachers and advisers** | Can verify a student's grade, section, and adviser instantly. |
| **School staff and guards** | Faster, more reliable verification than reading printed IDs. |
| **School administrators** | One searchable database of students and NFC cards, managed from a dashboard. |

## How it works

```
 Student registers             Student taps card            Server looks up card
┌─────────────────┐          ┌──────────────────┐          ┌──────────────────────┐
│ Register form   │          │ NFC reader sends │          │ E-ID config (PHP)    │
│ name, LRN, grade│  ─────►  │ the card key to  │  ─────►  │ finds the matching   │
│ photo, NFC key  │  saved   │ the E-ID page    │  fetch   │ student in MySQL     │
└─────────────────┘  in DB   └──────────────────┘          └──────────┬───────────┘
                                                                      │ JSON
                                                            ┌─────────▼───────────┐
                                                            │ Digital ID is shown │
                                                            │ photo + student info│
                                                            └─────────────────────┘
```

1. **Registration** (`pages/Register/register.php`): the student fills in email, name, LRN, grade and section, adviser, profile photo, and their NFC card key. The form sends the data as JSON to `database/db.php`, which stores it in the `nfcdata` table. A welcome email is then sent through EmailJS.
2. **Scanning** (`pages/E-ID/E-ID.php`): a USB NFC reader acts like a keyboard. When a card is tapped, it types the card key into the page's input and presses Enter. `Scan.js` sends the key to the server.
3. **Lookup** (`E-ID.config.php`): the server runs a prepared SQL query (`WHERE nfcCardKey = ?`) and returns the student's details and photo as JSON.
4. **Display**: `Scan.js` fills in the ID card on screen with the student's information.
5. **Mobile scanner** (`mobileScanner.html` + `mobile_nfc_read.js`): an experimental page that uses the browser's Web NFC API to read a card's serial number on supported Android phones.
6. **Admin dashboard** (`dashboard.php`): lists all registered students with View, Edit, and Delete actions.

## Tech stack

| Layer | Technology |
|---|---|
| Front end | HTML5, CSS3, vanilla JavaScript (ES6 classes, `fetch`) |
| UI libraries | [AOS](https://michalsnik.github.io/aos/) (scroll animations), Bootstrap 5.3 and Bootstrap Icons (dashboard), Lineicons, Fontshare "Satoshi" font |
| Back end | PHP 8.2 (`mysqli`, prepared statements) |
| Database | MySQL / MariaDB 10.4 (`nfc_data` database, `nfcdata` table) |
| Email | [EmailJS](https://www.emailjs.com/) (welcome email and contact form) |
| NFC | USB NFC reader (keyboard-emulation mode) and the Web NFC API (`NDEFReader`) for mobile |
| Local environment | XAMPP and phpMyAdmin |

## Database

Table `nfcdata`:

| Column | Type | Notes |
|---|---|---|
| `email` | varchar(60) | Primary key |
| `lastname`, `firstname` | text | |
| `lrn` | bigint | Learner Reference Number (12 digits) |
| `gradeSection` | varchar(20) | e.g. `12 - Babbage` |
| `adviser` | text | |
| `nfcCardKey` | bigint | The key the NFC card sends |
| `date_upload` | timestamp | Defaults to the current time |
| `user_img` | blob | Profile photo |

## Project structure

*(Based on the paths used in the code; adjust to match your repository.)*

```
nfc-id-v2/
├── index.html                  # Landing page (Home, About, Team, Contact, Admin login modal)
├── config/
│   ├── createAcc.config.js     # Registration + Admin classes
│   ├── Scan.js                 # Reads the NFC key and shows the ID
│   └── mobile_nfc_read.js      # Web NFC reader for mobile
├── database/
│   ├── db.php                  # DB connection + student registration
│   └── nfcdata.sql             # Database dump
├── pages/
│   ├── Register/register.php   # Student registration form
│   ├── E-ID/E-ID.php          # Digital ID display page
│   └── E-ID/E-ID.config.php   # NFC key lookup (JSON API)
├── dashboard/dashboard.php     # Admin dashboard
├── styles/                     # styles.css, register.css, E-ID.css, dashboard.css
└── image/                      # Logo, backgrounds, team photos
```

## Getting started

1. Install [XAMPP](https://www.apachefriends.org/) and start **Apache** and **MySQL**.
2. Copy the project folder into `htdocs/`.
3. Open phpMyAdmin, create a database named `nfc_data`, and import `nfcdata.sql`.
4. Check the database credentials in `database/db.php` (the XAMPP defaults are user `root` with no password).
5. Open `http://localhost/nfc-id-v2/` in your browser.
6. Register a student, then open the E-ID page, tap the NFC card on the reader (or type the key and press Enter), and the ID appears.

## Current status and known limitations

This is a work in progress. Registering a student, scanning a card, and showing the student's ID are implemented. Still to be finished:

- [ ] Profile photo upload and display on the ID
- [ ] Admin login (the form is in place, but the logic is not connected yet)
- [ ] Admin access control for the dashboard
- [ ] Working Edit and Delete in the dashboard
- [ ] Mobile scanner: map the card serial number to the stored NFC key
- [ ] Attendance and gate-entry logs

## Team

| Name | Role |
|---|---|
| Ivan Agaloos | Team Leader |
| Mandie Limbaga | Programmer |
| Gale Refe | Researcher |
| Nelgie Sedayon | Researcher / UI |
| Carl Somera | Researcher |

## License
