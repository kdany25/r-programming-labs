# HW1: Importing Data into R

Importing data into R from every source we covered in class: CSV and text
files, Excel, statistical packages (SPSS, Stata, SAS), a MySQL database, a web
API, XML, a web page, and R's own built-in datasets.

```
hw1-importing-data/
├── HW1_Importing_Data.Rmd   the homework
├── data/                     sample files the homework reads
└── sql/                      script that creates the MySQL database
```

## How to run it

Open `HW1_Importing_Data.Rmd` in RStudio and click **Knit**. The first knit
installs any missing packages, so stay online.

The `data/` files are committed here so the repository is complete, but the
homework recreates them anyway in its first chunk. Delete the folder and knit
again if you want to see that happen.

## The MySQL part

The homework reads from a MySQL database called `simba`. That database lives on
my machine, so `sql/01_create_simba_sample.sql` recreates a small version of it
with the same tables. Run it once:

```bash
mysql -u root -p < sql/01_create_simba_sample.sql
```

Or open the file in MySQL Workbench and click the lightning bolt.

**If you skip this step the document still knits.** The connection is wrapped in
`try()`, and the database chunks are switched off when the connection fails, so
you get every other section without errors.

### Connection settings

No password is written in the code. R reads these environment variables and
falls back to the defaults when they are not set:

| Variable | Default |
|----------|---------|
| `SIMBA_HOST` | `127.0.0.1` |
| `SIMBA_USER` | `root` |
| `SIMBA_PASSWORD` | empty |
| `SIMBA_DB` | `simba` |

To use your own, create a file named `.Renviron` in this folder and put the
values in it, one per line:

```
SIMBA_USER=myuser
SIMBA_PASSWORD=mypassword
```

Then restart R. `.Renviron` is in `.gitignore`, so it never gets committed.
