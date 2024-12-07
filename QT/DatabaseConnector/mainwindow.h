#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QApplication>
#include <QtWidgets>
#include <QMenuBar>
#include <QMenu>

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private:
    QMenu *aboutMenu;
    QAction *aboutAct;
    void createMenus();

private slots:
    void about();

};
#endif // MAINWINDOW_H
