
DESTDIR = $$OUT_PWD/..

include($$PWD/../klayout.pri)

TEMPLATE = app

TARGET = klayout

HEADERS = \

FORMS = \

SOURCES = \
  klayout.cc \

RESOURCES = \

INCLUDEPATH += ../tl ../gsi ../db ../rdb ../laybasic ../lay ../ext ../img ../ant ../lib
DEPENDPATH += ../tl ../gsi ../db ../rdb ../laybasic ../lay ../ext ../img ../ant ../lib
LIBS += $$PYTHONLIBFILE $$RUBYLIBFILE -L$$DESTDIR -lklayout_tl -lklayout_gsi -lklayout_db -lklayout_rdb -lklayout_laybasic -lklayout_lay -lklayout_ant -lklayout_img -lklayout_edt -lklayout_ext -lklayout_lib

# Note: this accounts for UI-generated headers placed into the output folders in
# shadow builds:
INCLUDEPATH += $$DESTDIR/laybasic $$OUT_PWD/../lay
DEPENDPATH += $$DESTDIR/laybasic $$OUT_PWD/../lay

equals(HAVE_QTBINDINGS, "1") {
  INCLUDEPATH += ../gsiqt
  DEPENDPATH += ../gsiqt
  LIBS += -lklayout_gsiqt
}

equals(HAVE_RUBY, "1") {
  INCLUDEPATH += ../rba
  DEPENDPATH += ../rba
  LIBS += -lklayout_rba
} else {
  INCLUDEPATH += ../rbastub
  DEPENDPATH += ../rbastub
  LIBS += -lklayout_rbastub
}

equals(HAVE_PYTHON, "1") {
  INCLUDEPATH += ../pya
  DEPENDPATH += ../pya
  LIBS += -lklayout_pya
} else {
  INCLUDEPATH += ../pyastub
  DEPENDPATH += ../pyastub
  LIBS += -lklayout_pyastub
}
