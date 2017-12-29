//////////////////////////////////////////////////////////////////
// Code snippet taken from:
// http://developer.nokia.com/community/wiki/Reading_and_writing_files_in_QML

#include "fileio.h"
#include <QFile>
#include <QTextStream>

FileIO::FileIO(QObject *parent) :
    QObject(parent)
{
}

/*
 * Read the specified text file and return its contents.
 */
QString FileIO::read()
{
    QString fileContent;
    if (mSource.isEmpty()) {
        emit error("source is empty");
    }
    else {
        QFile file(mSource);
        if (file.open(QIODevice::ReadOnly | QIODevice::Text) ) {
            QTextStream t(&file);

            // Read the entire file and close it
            fileContent = t.readAll();
            file.close();
        } else {
            emit error("Unable to open the file");
        }
    }
    return fileContent;
}

/*
 * Write the provided daya to the specified text file.
 */
bool FileIO::write(const QString& data)
{
    if (mSource.isEmpty())
        return false;

    QFile file(mSource);
    if (!file.open(QFile::WriteOnly | QFile::Truncate))
        return false;

    QTextStream out(&file);
    out << data;

    file.close();
    return true;
}
