*** Settings ***
Documentation     UC-03 : ตรวจสอบคำผิด (Robot Framework + SeleniumLibrary)
Resource          ../resources/Helpers.resource
Test Teardown     Close All Browsers

*** Variables ***
${TEXT_WITH_MISTAKES}    กาลครั้งหนึ่ง ณ หมู่บ้านอักษรสมบูรณ์ มีชายน้อยคนหนึ่งชื่อ "โต้ง" เขาเป็นคนที่ชอบกิน สัปปะรด และฝันอยากเปิดร้านขาย เบเกอร์รี่ เล็ก ๆ ที่มีขนม เค๊ก อร่อย ๆ ไว้คอยบริการผู้คน\n\nเช้าวันหนึ่ง โต้งตื่นขึ้นมาด้วยความสดใส เขาเดินไป กระพริบ ตาถี่ ๆ มองดูฟ้าที่ช่างสดใส จากนั้นจึงรีบแต่งตัวเพื่อเดินทางไป สังเกตุ ดูทำเลเปิดร้านในเมืองใหญ่ ระหว่างทาง เขาเห็นน้ำตกสายใหญ่ที่กำลังไหลผ่านก้อนหินอย่างสวยงาม ทำให้เขาเคลิบเคลิ้มและ หลงไหล ในบรรยากาศธรรมชาติจนแทบจะเดินหลงทาง\n\nเมื่อเดินทางมาถึงตัวเมือง โต้งก็มุ่งหน้าไปยัง คลินิค สัตว์เพื่อเยี่ยมลูกแมวของเพื่อนรัก จากนั้นจึงข้ามถนนไปติดต่อเจ้าหน้าที่ ณ เคาเตอร์ เอกสารของสำนักงานเขต เพื่อยื่นเรื่องขอ อนุญาติ เปิดร้านค้า โต้งตั้งใจทำตามขั้นตอนอย่างถูกต้อง เพราะเขาไม่อยากทำอะไร กระทันหัน จนเกิดความผิดพลาด\n\nหลังจากยื่นเอกสารเสร็จเรียบร้อย เจ้าหน้าที่ได้มอบใบอนุมัติพร้อมกับ ลายเซ็นต์ ของนายทะเบียน โต้งรู้สึก ผูกพันธ์ และขอบคุณเจ้าหน้าที่ทุกคนเป็นอย่างมาก เขารีบยกมือไหว้แล้วพูดอย่างสุภาพว่า "ขอบคุณมาก ๆ นะค่ะ ที่ช่วยอำนวยความสะดวกให้"\n\nก่อนเดินทางกลับบ้าน โต้งได้แวะซื้อ ซ๊อส และวัตถุดิบต่าง ๆ กลับไปเตรียมทำขนม เขานั่งมองแบบแปลนร้านที่เขียนขึ้นด้วยความตั้งใจ แม้การจัดวางตำแหน่งร้านจะดู เอนกประสงค์ ไปสักนิด แต่โต้งก็เชื่อมั่นว่า ความพยายามและความตั้งใจจริง จะนำพาความสำเร็จมาสู่ร้านขนมเล็ก ๆ ของเขาได้อย่างแน่นอน

@{MISSPELLED_WORDS}
...    สัปปะรด    เบเกอร์รี่    เค๊ก    กระพริบ    สังเกตุ
...    หลงไหล    คลินิค    เคาเตอร์    อนุญาติ    กระทันหัน
...    ลายเซ็นต์    ผูกพันธ์    นะค่ะ    ซ๊อส    เอนกประสงค์

${CORRECT_TEXT}    กาลครั้งหนึ่งนานมาแล้ว ในป่าใหญ่ที่แสนอบอุ่น มีกระรอกน้อยตัวหนึ่งชื่อ "เจ้าปุกปุย" มันเป็นสัตว์ที่มีความน่ารักและมีความผูกพันกับเพื่อนๆ สัตว์ป่าทุกตัวในบริเวณนั้น เจ้าปุกปุยมีความฝันว่าอยากจะจัดงานเลี้ยงสังสรรค์กลางป่าสักครั้ง มันจึงเดินทางไปพบสิงโตเจ้าป่าเพื่อขออนุญาตจัดงาน สิงโตเจ้าป่าสังเกตเห็นความมุ่งมั่นและความตั้งใจจริงของกระรอกน้อย จึงมอบโอกาสให้มันเป็นผู้ดูแลงานทั้งหมด เจ้าปุกปุยดีใจมาก มันเริ่มตระเตรียมงานอย่างประณีต ทั้งการประดับตกแต่งด้วยดอกไม้สีสันสดใส และปรุงอาหารจานเด็ดอย่างผัดไทยผลไม้สำหรับเพื่อนสัตว์ทุกตัว เมื่อถึงวันงาน เพื่อนสัตว์ป่าต่างมาร่วมงานกันอย่างคึกคัก ทุกคนต่างชมว่าอาหารมีรสชาติอร่อยเลิศ เจ้าลิงน้อยตัวป่วนหัวเราะจนสั่นไปทั้งศีรษะ เมื่อได้ฟังมุกตลกที่เจ้าปุกปุยเล่าให้ฟัง บรรยากาศในงานเต็มไปด้วยความสุข สนุกสนาน จนทำให้เพื่อนสัตว์ทุกตัวรู้สึกหลงใหลในค่ำคืนอันแสนพิเศษนี้ และจดจำงานเลี้ยงของเจ้าปุกปุยไปอีกนานแสนนาน

${SHORT_TEXT}    กาลครั้งหนึ่ง ณ หมู่บ้านอักษรสมบูรณ์ มีชายน้อยคนหนึ่งชื่อ "โต้ง" เขาเป็นคนที่ชอบกิน สัปปะรด และฝันอยากเปิดร้านขาย เบเกอร์รี่ เล็ก ๆ ที่มีขนม เค๊ก อร่อย ๆ ไว้คอยบริการผู้คน

*** Test Cases ***
TC-0301 ตรวจสอบคำผิดเมื่อมีข้อความและพบคำผิด
    [Tags]    UC-03    smoke
    Login And Open Editor    ${USER_PRO}
    Type In Editor    ${TEXT_WITH_MISTAKES}
    Click Check
    Sleep    ${AI_WAIT}
    # ต้องพบคำผิดครบทั้ง 15 คำ
    FOR    ${word}    IN    @{MISSPELLED_WORDS}
        Element Should Contain    ${ROOT} ${word}
    END

TC-0302 ตรวจสอบการทำงานเมื่อข้อความถูกต้องสมบูรณ์
    [Tags]    UC-03
    Login And Open Editor    ${USER_PRO}
    Type In Editor    ${CORRECT_TEXT}
    Click Check

    Wait Until Page Contains    ไม่พบจุดที่ต้องแก้ไข    timeout=60s
    Page Should Contain    ตรวจเสร็จสิ้น
    Page Should Not Contain Element   ${HIGHLIGHT}

TC-0303 ตรวจสอบโดยไม่ได้ใส่ข้อความ ต้องกดตรวจสอบไม่ได้
    [Tags]    UC-03
    Login And Open Editor    ${USER_PRO}
    Element Should Be Disabled    ${BTN_CHECK}

TC-0304 ตรวจสอบใส่ข้อความได้ไม่จำกัด
    [Documentation]    ทดสอบตาม Objective: ใส่ข้อความยาวมาก (~50,000 ตัวอักษร) ได้
    [Tags]    UC-03
    Login And Open Editor    ${USER_PRO}
    ${long_text}=    Evaluate    "สวัสดีครับวันนี้อากาศดีมาก " * 2000
    ${expected}=     Get Length    ${long_text}
    Type Long Text In Editor    ${long_text}
    ${actual}=       Get Editor Length
    ${min}=          Evaluate    ${expected} - 100
    Should Be True    ${actual} >= ${min}
    Element Should Be Enabled    ${BTN_CHECK}

TC-0305 ตรวจสอบโควต้าโทเค็นหมด (สมาชิกธรรมดา)
    [Documentation]    ต้องตั้ง environment variable NO_QUOTA_USER / NO_QUOTA_PASS ก่อนรัน
    [Tags]    UC-03
    ${u}=    Set Variable    %{NO_QUOTA_USER=UserBasic57}
    ${p}=    Set Variable    %{NO_QUOTA_PASS=UserBasic57}
    Skip If    '${u}' == 'UserBasic57' or '${p}' == 'UserBasic57'   
    &{no_quota}=    Create Dictionary    username=${u}    password=${p}
    Login And Open Editor    ${no_quota}
    Type In Editor    ${SHORT_TEXT}
    Click Check
    Wait Until Page Contains
    ...    จำนวนโทเค็นของคุณไม่เพียงพอ กรุณาสะสมเพิ่มหรืออัปเกรดแพ็กเกจ    timeout=60s

TC-0306 ตรวจสอบการหักโควต้าหลังตรวจสอบสำเร็จ
    [Tags]    UC-03
    Login And Open Editor    ${USER_PRO}
    ${before}=    Read Quota
    Type In Editor    ${SHORT_TEXT}
    Click Check
    # รอจนโควต้าลดลง (ลองซ้ำทุก 2 วินาที สูงสุด 60 วินาที)
    Wait Until Keyword Succeeds    60s    2s    Quota Should Be Less Than    ${before}
    ${after}=    Read Quota
    ${used}=     Evaluate    ${before} - ${after}
    Log To Console    โควต้าก่อน=${before} หลัง=${after} (ถูกหัก ${used} โทเค็น)

TC-0307 ป้องกันการกดปุ่มตรวจสอบซ้ำซ้อน (Spam Click)
    [Tags]    UC-03
    Login And Open Editor    ${USER_PRO}
    Type In Editor    ${SHORT_TEXT}
    # กดรัว 5 ครั้งติดกัน
    FOR    ${i}    IN RANGE    5
        Click Element    ${BTN_CHECK}
        Sleep    50ms
    END
    Element Should Be Disabled    ${BTN_CHECK}


TC-0308 ตรวจสอบเมื่อระบบ AI ตอบสนองช้าเกินกำหนด (Timeout)
    [Documentation]    ปิดไว้เหมือนใน Playwright (ต้องจำลอง response ช้า 65 วินาที)
    [Tags]    UC-03    skip
    Skip    ปิดไว้เหมือนสคริปต์ Playwright

