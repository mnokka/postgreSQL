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
}

void MainWindow::about()
{
    QMessageBox::about(this, tr("About"),
                       tr("Connecting to PostgreSQL database running in Docker "
                          "and showing content of one of the tables"
                          "<br><br>mika.nokka1@gmail.com 2024"
                          ));
}
