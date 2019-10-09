from funniest.funniest_app import joke

def test_joke():
    funniest_joke = joke()
    assert funniest_joke == (u'Wenn ist das Nunst\u00fcck git und Slotermeyer? Ja! ... '
            u'Beiherhund das Oder die Flipperwaldt gersput.')