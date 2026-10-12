*** Settings ***
Documentation     Keyword/ตัวแปรที่ใช้ร่วมกัน (เทียบเท่า Helpers.js ของ Playwright) ใช้ SeleniumLibrary
Library           SeleniumLibrary    timeout=30s

*** Variables ***
${BASE_URL}           https://t-check-two.vercel.app/
${BROWSER}            chrome
${HEADLESS}           ${False}
${AI_WAIT}            20s

&{USER_NORMAL}        username=UserBasic67    password=UserBasic67
&{USER_PRO}           username=UserPro67      password=UserPro67
&{NO_QUOTA_USER}      username=UserBasic57    password=UserBasic57

# ---------- Locator (XPath/CSS) ----------
${LINK_LOGIN}         xpath://a[normalize-space(.)='ลงชื่อเข้าใช้']
${LINK_DOCS}          xpath://a[contains(normalize-space(.),'จัดการเอกสาร')]
${BTN_NEW_DOC}        xpath://button[contains(normalize-space(.),'สร้างเอกสารใหม่')]
${INPUT_USER}         xpath://input[@placeholder='ชื่อผู้ใช้ หรือ อีเมล' or @aria-label='ชื่อผู้ใช้ หรือ อีเมล' or @id=//label[contains(.,'ชื่อผู้ใช้')]/@for]
${INPUT_PASS}         xpath://input[@type='password']
${BTN_LOGIN}          xpath://button[normalize-space(.)='เข้าสู่ระบบ']
${BTN_OK}             xpath://button[normalize-space(.)='ตกลง']
${BTN_CHECK}          xpath:(//button[contains(normalize-space(.),'ตรวจสอบ')])[1]
# ช่องพิมพ์เอกสาร: keyword "Mark Editor" จะหาช่องที่ใหญ่ที่สุดในหน้าแล้วติดป้าย data-robot-editor ให้
${EDITOR}             css:[data-robot-editor="1"]
${HIGHLIGHT}          css:mark
${ROOT}               id:root

*** Keywords ***
Open Browser Session
    [Documentation]    เปิด Chrome (Selenium Manager โหลด driver ให้อัตโนมัติ)
    ${options}=    Set Variable    add_argument("--lang=th-TH");add_argument("--window-size=1366,768")
    IF    ${HEADLESS}
        ${options}=    Set Variable    ${options};add_argument("--headless=new")
    END
    Open Browser    ${BASE_URL}    ${BROWSER}    options=${options}

Click When Visible
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    Click Element    ${locator}

Login
    [Arguments]    ${user}
    Click When Visible    ${LINK_LOGIN}
    Wait Until Element Is Visible    ${INPUT_USER}
    Input Text        ${INPUT_USER}    ${user}[username]
    Input Password    ${INPUT_PASS}    ${user}[password]
    Click When Visible    ${BTN_LOGIN}
    Click When Visible    ${BTN_OK}

Mark Editor
    [Documentation]    หาช่องพิมพ์เอกสาร (textarea / contenteditable ที่ใหญ่ที่สุดและมองเห็นอยู่)
    ...                แล้วติดป้าย data-robot-editor="1" เพื่อให้ locator หาเจอ ไม่ต้องเดา placeholder/class
    ${found}=    Execute Javascript
    ...    var old = document.querySelectorAll('[data-robot-editor]');
    ...    for (var i = 0; i < old.length; i++) { old[i].removeAttribute('data-robot-editor'); }
    ...    var els = document.querySelectorAll('textarea, [contenteditable="true"], [contenteditable=""], [role="textbox"]');
    ...    var best = null;
    ...    var bestArea = 0;
    ...    for (var j = 0; j < els.length; j++) { var r = els[j].getBoundingClientRect(); var a = r.width * r.height; if (a > bestArea) { best = els[j]; bestArea = a; } }
    ...    if (!best) { return 'none'; }
    ...    best.setAttribute('data-robot-editor', '1');
    ...    return best.tagName + ' class=' + best.className;
    Should Not Be Equal    ${found}    none    หาช่องพิมพ์เอกสารไม่เจอ
    Log    Editor element: ${found}

Open New Document
    Click When Visible    ${LINK_DOCS}
    Click When Visible    ${BTN_NEW_DOC}
    Wait Until Keyword Succeeds    30s    1s    Mark Editor

Login And Open Editor
    [Arguments]    ${user}
    Open Browser Session
    Login    ${user}
    Open New Document

Type In Editor
    [Documentation]    พิมพ์ข้อความปกติ (ส่งคีย์จริงเหมือนผู้ใช้พิมพ์)
    [Arguments]    ${text}
    Mark Editor
    Click Element    ${EDITOR}
    Input Text       ${EDITOR}    ${text}

Type Long Text In Editor
    [Documentation]    ใช้สำหรับข้อความยาวมาก (~50,000 ตัวอักษร) เพราะส่งคีย์ทีละตัวจะช้ามาก
    [Arguments]    ${text}
    Mark Editor
    ${js_text}=    Evaluate    json.dumps($text)    modules=json
    Execute Javascript
    ...    var TEXT = ${js_text};
    ...    var el = document.querySelector('[data-robot-editor="1"]');
    ...    el.focus();
    ...    if (el.tagName === 'TEXTAREA') {
    ...    var setter = Object.getOwnPropertyDescriptor(HTMLTextAreaElement.prototype, 'value').set;
    ...    setter.call(el, TEXT);
    ...    el.dispatchEvent(new Event('input', {bubbles: true}));
    ...    } else {
    ...    document.execCommand('selectAll', false, null);
    ...    document.execCommand('insertText', false, TEXT);
    ...    }

Get Editor Length
    [Documentation]    นับจำนวนตัวอักษรใน Editor (รองรับทั้ง textarea และ contenteditable)
    Mark Editor
    ${len}=    Execute Javascript
    ...    var el = document.querySelector('[data-robot-editor="1"]');
    ...    return (el.value !== undefined ? el.value : el.innerText).length;
    RETURN    ${len}

Click Check
    Click When Visible    ${BTN_CHECK}

Read Quota Once
    [Documentation]    อ่านโควต้าคงเหลือจากรูปแบบ "4,000 / 4,000" (อ่านครั้งเดียว ล้มถ้ายังไม่เจอ)
    ...                หา element ที่เล็กที่สุดที่ข้อความมีรูปแบบ ตัวเลข / ตัวเลข (รองรับเลขไทยด้วย)
    ${text}=    Execute Javascript
    ...    var all = document.querySelectorAll('body *');
    ...    var re = new RegExp('([0-9๐-๙,]+)[^0-9๐-๙,/]*/[^0-9๐-๙,/]*([0-9๐-๙,]+)');
    ...    var best = '';
    ...    for (var i = 0; i < all.length; i++) {
    ...    var t = (all[i].textContent || '').trim();
    ...    if (t.length > 0 && t.length < 30 && re.test(t)) { if (best === '' || t.length < best.length) { best = t; } }
    ...    }
    ...    return best;
    IF    $text == ''
        ${body}=    Get Text    tag:body
        Log    ข้อความบนหน้าเว็บตอนนี้: ${body}
        Fail    หาแถบโควต้าไม่เจอ
    END
    ${num}=    Evaluate    int($text.split('/')[0].strip().translate(str.maketrans('๐๑๒๓๔๕๖๗๘๙', '0123456789')).replace(',', ''))
    RETURN    ${num}

Read Quota
    [Documentation]    รอให้แถบโควต้าโหลดเสร็จ (ลองซ้ำทุก 1 วินาที สูงสุด 30 วินาที) แล้วคืนค่าโควต้าคงเหลือ
    ${num}=    Wait Until Keyword Succeeds    30s    1s    Read Quota Once
    RETURN    ${num}

Quota Should Be Less Than
    [Arguments]    ${before}
    ${now}=    Read Quota
    Should Be True    ${now} < ${before}    โควต้ายังไม่ลดลง (ก่อน=${before}, ตอนนี้=${now})
