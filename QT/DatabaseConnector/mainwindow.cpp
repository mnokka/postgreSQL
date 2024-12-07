#include "mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
{
    createMenus();
}

MainWindow::~MainWindow() {}


void MainWindow::createMenus()
{
    aboutMenu = menuBar()->addMenu(tr("&About"));
    aboutAct = new QAction(tr("&Info"), this);
    connect(aboutAct, &QAction::triggered, this, &MainWindow::about);
    aboutMenu->addAction(aboutAct);

    aboutMenu = menuBar()->addMenu(tr("&Database"));
    aboutAct = new QAction(tr("&Info"), this);
    connect(aboutAct, &QAction::triggered, this, &MainWindow::showDatabaseInfo);
    aboutMenu->addAction(aboutAct);
}




void MainWindow::about()
{
    QMessageBox::about(this, tr("About"),
                       tr("Connecting to PostgreSQL database running in Docker "
                          "and showing content of one of the tables"
                          "<br><br>mika.nokka1@gmail.com 2024"
                          ));
}

void MainWindow::showDatabaseInfo()
{
    // Connect to the database
    QSqlDatabase db = QSqlDatabase::addDatabase("QPSQL"); // PostgreSQL
    db.setHostName("localhost"); //port 5432 must be opened in docker compose file
    db.setDatabaseName("cars");
    db.setUserName("mika");
    db.setPassword("passu");

    if (db.open()) {
        QSqlQuery query;
        if (query.exec("SELECT * FROM cars")) {
            QString data;
            while (query.next()) {
                data += QString("Model: %1\nColor: %2\nMotor: %3\nYear: %4\n\n")
                            .arg(query.value("model").toString())
                            .arg(query.value("color").toString())
                            .arg(query.value("motor").toString())
                            .arg(query.value("year").toInt());
            }
            QMessageBox::information(this, tr("Cars Information"), data);
        } else {
            QMessageBox::critical(this, tr("Database Error"), query.lastError().text());
        }
    } else {
        QMessageBox::critical(this, tr("Database Error"), db.lastError().text());
    }
}
