#include "mainwindow.h"



int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    //QWidget window;
    QString title;
    QTextStream(&title) << "Database connector";
    w.setWindowTitle(title);
    w.show();



    return a.exec();
}





