Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4163DC3600C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 12:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txPzX-0001VC-9D; Wed, 26 Mar 2025 08:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1txPzO-0001UN-LW
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:36:10 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1txPzK-0007ws-6g
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:36:09 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e5e34f4e89so12419689a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 05:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742992562; x=1743597362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwEfkNTlu12efVeJwJERkXNRxbeXXzC5duSZWiytiIU=;
 b=lONKifuhnaXLcVh0y5nN9WdHJwovKBfnYf9NmlZTpknytl0TUUkJMd6HymWn0euPrw
 Ui86VbFnf3P7BVJtUk9Vyaq55kSJslzlCUouWO14WdhunOCwDN0UtkUR/HFrdxEysWBq
 4FXnzFYfTzZT/QRp1kfRfJ4C3MKL1+Bnac1pBbEcn27/zjRAPJsAhnlmlCCwzcmAL/rp
 iBuKFN39puG4cA4rVNQBiBLBAAW5SHDiH39QHNjKBh8Hf0jTa+9iNlEPP2C18eY/xJVq
 rKR78NUpw6CJ8y+zfGv65bGwPMrEOUOecBXBML+8znHmPkAnHm2nm0xALcl3cn0ATCeo
 Ow+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742992562; x=1743597362;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uwEfkNTlu12efVeJwJERkXNRxbeXXzC5duSZWiytiIU=;
 b=q+JCpjcIF67OKotPzjEFaNxxIv8aXyFLVpWgFJAsYDLA8oTgRUCboWVJjzBEEdY4Xb
 9Mra/bhZzx5ReUYCeAOuSLaVpX4r9CEXFocuODui1TV1HY7y5GV2qDHsUbcOzmiHN3q+
 YuNO38TbpoPSMZ1NO6/55qnvJVMtou95FvGF10OE2xRu7jku2ZvlIuN4HsoEZAVtdbkO
 BzVSjF/1JAVFqYff5gAcJK4dRHrHA5hzIQ3FNOdzfU0b+UdCyCimfMDrESLgw6xTGrhq
 I8DiqDXz7t6KsmkDmC4ZMlE5ha0A32mCAEkWL+zgQzXPG4B1GV0Qo+NoNI2Bb3Ixdvyn
 TTZw==
X-Gm-Message-State: AOJu0Yz55TB/WxKJjU6T8+9MY4pk3FgGARc2Pj6D7N6ACoON3WLTQc7Q
 /osqN9Tx/+3Hp8o25HyVM7Nz7TjraleGirxPDrjIKQKaV6GmB/2ZYzrx9w==
X-Gm-Gg: ASbGnctemP/Ym4V/j2S5Ki/Z59jQN5hd0AdQafMtivq2ZJstAr6/JfWE0CwTHU94xHV
 OPNe8BnvE/e9CA9gjjAkTyvKm2ZxuhDj0RgT6nov+2WxC7ZA2rJDKBG4aIV5bzA9Tre8k2iaFqq
 kYYaHwztS06EByWkluz90osbmbepZzVY0jGV8XgNEzOSCSv/oZm7fThHO4SDEqfbM2BuGVss1bl
 OSYXM2M/YVNQtMBLe03hNRdJVOZIA97L5UzcacOQr6Rzp++SlJUkfI48YKdAISo43qngMWI9PmP
 ng12JH1pT7dxC9LDrmFQowLnig4MfTrYmzLHTSZ2
X-Google-Smtp-Source: AGHT+IF/M5rGDICowG9q8O7jPourU9wfPC+mt6p4NCp/6vffsT7vHSm5OFbPNOyXLbHGURjkLnN5fQ==
X-Received: by 2002:a17:907:3eaa:b0:abf:749f:f719 with SMTP id
 a640c23a62f3a-ac3f20b8934mr2127261566b.7.1742992562089; 
 Wed, 26 Mar 2025 05:36:02 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3efbde51dsm1020799366b.136.2025.03.26.05.36.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 05:36:01 -0700 (PDT)
Date: Wed, 26 Mar 2025 10:51:14 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Ilya Chichkov <i.chichkov@yadro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
CC: nikita.shubin@maquefel.me
Subject: Re: [PATCH v2] tests/qtest: Unit test for pcf8563_rtc
In-Reply-To: <20250310113635.349822-2-i.chichkov@yadro.com>
References: <20250310113635.349822-1-i.chichkov@yadro.com>
 <20250310113635.349822-2-i.chichkov@yadro.com>
Message-ID: <0C63718C-D9B8-40B6-84D8-037019B1B84A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 10=2E M=C3=A4rz 2025 11:36:35 UTC schrieb Ilya Chichkov <i=2Echichkov@y=
adro=2Ecom>:
>Add a unit test for pcf8563_rtc module
>
>- Check default value after initialization
>- Check set/get time
>- Check minute alarm
>- Check hour alarm
>- Check day alarm
>- Check wday alarm
>- Check minute & hour alarm
>- Check minute & day alarm
>- Check day & wday alarm
>- Check timer

Impressive!

>---
>v1->v2
>Phil:
>- Add hot reset
>- Fix trace message
>- Add testing coverage with qtest
>
>Bernhard:
>- Move datasheet link to source code top comment section
>- Fix typos
>- Update licence identifier to SPDX
>- Remove unused import libraries
>- Change OBJECT_CHECK to OBJECT_DECLARE_SIMPLE_TYPE
>- Remove outdated comment
>- Rename i2c to parent_obj
>- Moved get_time inside capture_time function that is
>  called only when I2C request starts
>- Add fields inside VMStateDescription
>- Removed pcf8563_realize
>- Change type_init to DEFINE_TYPES
>---
> tests/qtest/meson=2Ebuild    |   1 +
> tests/qtest/pcf8563-test=2Ec | 508 +++++++++++++++++++++++++++++++++++++
> 2 files changed, 509 insertions(+)
> create mode 100644 tests/qtest/pcf8563-test=2Ec
>
>diff --git a/tests/qtest/meson=2Ebuild b/tests/qtest/meson=2Ebuild
>index bd41c9da5f=2E=2Ea10843dd49 100644
>--- a/tests/qtest/meson=2Ebuild
>+++ b/tests/qtest/meson=2Ebuild
>@@ -293,6 +293,7 @@ qos_test_ss=2Eadd(
>   'tulip-test=2Ec',
>   'nvme-test=2Ec',
>   'pca9552-test=2Ec',
>+  'pcf8563-test=2Ec',
>   'pci-test=2Ec',
>   'pcnet-test=2Ec',
>   'sdhci-test=2Ec',
>diff --git a/tests/qtest/pcf8563-test=2Ec b/tests/qtest/pcf8563-test=2Ec
>new file mode 100644
>index 0000000000=2E=2E42aded2e42
>--- /dev/null
>+++ b/tests/qtest/pcf8563-test=2Ec
>@@ -0,0 +1,508 @@
>+/*
>+ * QTests for the PCF8563 RTC
>+ *
>+ * Copyright 2021 Google LLC

Why Google? Why 2021?

For simplicity I suggest to merge this patch with your other one=2E Altern=
atively you could create a series using e=2Eg=2E git-publish <https://githu=
b=2Ecom/stefanha/git-publish> to keep the patches logically together=2E

>+ *
>+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>+ */
>+
>+#include "qemu/osdep=2Eh"
>+
>+#include "libqtest-single=2Eh"
>+#include "libqos/qgraph=2Eh"
>+#include "libqos/i2c=2Eh"
>+#include "sysemu/rtc=2Eh"
>+#include "qapi/qmp/qdict=2Eh"
>+#include "qapi/qmp/qnum=2Eh"
>+#include "qemu/bitops=2Eh"
>+#include "qemu/bcd=2Eh"
>+
>+#define TEST_ID "pcf8563-test"

>+#define NANOSECONDS_PER_SECOND 1000000000LL

Looks like there should exist such a define already=2E If that's the case =
then it should be reused=2E

>+
>+#define  PCF8563_CS1            0x00
>+#define  PCF8563_CS2            0x01
>+#define  PCF8563_VLS            0x02
>+#define  PCF8563_MINUTES        0x03
>+#define  PCF8563_HOURS          0x04
>+#define  PCF8563_DAYS           0x05
>+#define  PCF8563_WEEKDAYS       0x06
>+#define  PCF8563_CENTURY_MONTHS 0x07
>+#define  PCF8563_YEARS          0x08
>+#define  PCF8563_MINUTE_A       0x09
>+#define  PCF8563_HOUR_A         0x0A
>+#define  PCF8563_DAY_A          0x0B
>+#define  PCF8563_WEEKDAY_A      0x0C
>+#define  PCF8563_CLKOUT_CTL     0x0D
>+#define  PCF8563_TIMER_CTL      0x0E
>+#define  PCF8563_TIMER          0x0F

I'd rather have a common header for test and production code for these def=
ines (which would also motivate merging this patch with your other one)=2E

By briefly skimming through the rest of the test the patch LGTM=2E

Best regards,
Bernhard

>+
>+static void set_time(QI2CDevice *i2cdev, struct tm *tm)
>+{
>+    tm->tm_sec =3D 30;
>+    tm->tm_min =3D 45;
>+    tm->tm_hour =3D 14;
>+    tm->tm_mday =3D 25;
>+    tm->tm_mon =3D 11;
>+    tm->tm_year =3D 125;
>+    tm->tm_wday =3D 1;
>+
>+    i2c_set8(i2cdev, PCF8563_VLS, to_bcd(tm->tm_sec));
>+    i2c_set8(i2cdev, PCF8563_MINUTES, to_bcd(tm->tm_min));
>+    i2c_set8(i2cdev, PCF8563_HOURS, to_bcd(tm->tm_hour));
>+    i2c_set8(i2cdev, PCF8563_DAYS, to_bcd(tm->tm_mday));
>+    i2c_set8(i2cdev, PCF8563_CENTURY_MONTHS, to_bcd(tm->tm_mon));
>+    i2c_set8(i2cdev, PCF8563_YEARS, to_bcd(tm->tm_year));
>+    i2c_set8(i2cdev, PCF8563_WEEKDAYS, to_bcd(tm->tm_wday));
>+}
>+
>+static void test_defaults(void *obj, void *data, QGuestAllocator *alloc)
>+{
>+    uint16_t i2c_value =3D 0;
>+    QI2CDevice *i2cdev =3D (QI2CDevice *)obj;
>+
>+    /* CS1 */
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_CS1);
>+    g_assert_cmphex(i2c_value, =3D=3D, 0x8);
>+
>+    /* CS2 */
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_CS2);
>+    g_assert_cmphex(from_bcd(i2c_value), =3D=3D, 0x0);
>+
>+    /* Minute alarm */
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_MINUTE_A);
>+    g_assert_cmphex(i2c_value, =3D=3D, 0x80);
>+
>+    /* Hour alarm */
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_HOUR_A);
>+    g_assert_cmphex(i2c_value, =3D=3D, 0x80);
>+
>+    /* Day alarm */
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_DAY_A);
>+    g_assert_cmphex(i2c_value, =3D=3D, 0x80);
>+
>+    /* Weekend alarm */
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_WEEKDAY_A);
>+    g_assert_cmphex(i2c_value, =3D=3D, 0x80);
>+
>+    /* Clkout CTL */
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_CLKOUT_CTL);
>+    g_assert_cmphex(i2c_value, =3D=3D, 0x80);
>+
>+    /* Timer CTL */
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_TIMER_CTL);
>+    g_assert_cmphex(i2c_value, =3D=3D, 0x3);
>+
>+    /* Timer CNT */
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_TIMER);
>+    g_assert_cmphex(i2c_value, =3D=3D, 0x0);
>+}
>+
>+static void test_check_time(void *obj, void *data, QGuestAllocator *allo=
c)
>+{
>+    uint16_t i2c_value =3D 0;
>+    QI2CDevice *i2cdev =3D (QI2CDevice *)obj;
>+    struct tm tm;
>+
>+    tm=2Etm_sec =3D 20;
>+    tm=2Etm_min =3D 48;
>+    tm=2Etm_hour =3D 8;
>+    tm=2Etm_mday =3D 24;
>+    tm=2Etm_mon =3D 11;
>+    tm=2Etm_year =3D (2024 - 1900) % 100;
>+    tm=2Etm_wday =3D 2;
>+
>+    i2c_set8(i2cdev, PCF8563_VLS, to_bcd(tm=2Etm_sec));
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_VLS);
>+    i2c_value =3D extract32(i2c_value, 0, 7);
>+    g_assert_cmphex(from_bcd(i2c_value), =3D=3D, tm=2Etm_sec);
>+
>+    i2c_set8(i2cdev, PCF8563_MINUTES, to_bcd(tm=2Etm_min));
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_MINUTES);
>+    i2c_value =3D extract32(i2c_value, 0, 7);
>+    g_assert_cmphex(from_bcd(i2c_value), =3D=3D, tm=2Etm_min);
>+
>+    i2c_set8(i2cdev, PCF8563_HOURS, to_bcd(tm=2Etm_hour));
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_HOURS);
>+    i2c_value =3D extract32(i2c_value, 0, 6);
>+    g_assert_cmphex(from_bcd(i2c_value), =3D=3D, tm=2Etm_hour);
>+
>+    i2c_set8(i2cdev, PCF8563_DAYS, to_bcd(tm=2Etm_mday));
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_DAYS);
>+    i2c_value =3D extract32(i2c_value, 0, 6);
>+    g_assert_cmphex(from_bcd(i2c_value), =3D=3D, tm=2Etm_mday);
>+
>+    i2c_set8(i2cdev, PCF8563_CENTURY_MONTHS, to_bcd(tm=2Etm_mon));
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_CENTURY_MONTHS);
>+    i2c_value =3D extract32(i2c_value, 0, 5);
>+    g_assert_cmphex(from_bcd(i2c_value), =3D=3D, tm=2Etm_mon + 1);
>+
>+    i2c_set8(i2cdev, PCF8563_YEARS, to_bcd(tm=2Etm_year));
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_YEARS);
>+    i2c_value =3D extract32(i2c_value, 0, 8);
>+    g_assert_cmphex(from_bcd(i2c_value), =3D=3D, tm=2Etm_year);
>+
>+    i2c_set8(i2cdev, PCF8563_WEEKDAYS, to_bcd(tm=2Etm_wday));
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_WEEKDAYS);
>+    i2c_value =3D extract32(i2c_value, 0, 3);
>+    g_assert_cmphex(from_bcd(i2c_value), =3D=3D, tm=2Etm_wday);
>+}
>+
>+static void test_set_minute_alarm(void *obj, void *data, QGuestAllocator=
 *alloc)
>+{
>+    QTestState *qts =3D global_qtest;
>+    uint16_t i2c_value =3D 0;
>+    QI2CDevice *i2cdev =3D (QI2CDevice *)obj;
>+    uint8_t irq_line =3D 0;
>+    uint64_t alarm_min =3D 1;
>+    uint64_t alarm_sec =3D alarm_min * 60;
>+    uint8_t reg_min_a =3D 0x0;
>+    struct tm tm;
>+
>+    qtest_irq_intercept_out(qts, "/machine/peripheral/pcf8563-test/");
>+    set_time(i2cdev, &tm);
>+
>+    /* Enable alarm interrupt */
>+    i2c_set8(i2cdev, PCF8563_CS2, 0x2);
>+
>+    /* Set minute alarm & enable it */
>+    alarm_min =3D tm=2Etm_min + alarm_min;
>+    reg_min_a =3D to_bcd(alarm_min) & ~0x80;
>+    i2c_set8(i2cdev, PCF8563_MINUTE_A, reg_min_a);
>+
>+    /* Check when half of supposed alarm time passed */
>+    clock_step((alarm_sec - 1) * NANOSECONDS_PER_SECOND);
>+
>+    g_assert_false(qtest_get_irq(global_qtest, irq_line));
>+
>+    /* Check when alarm time passed */
>+    clock_step((2) * NANOSECONDS_PER_SECOND);
>+
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_MINUTE_A);
>+    g_assert_cmphex(i2c_value, =3D=3D, reg_min_a);
>+    g_assert_true(qtest_get_irq(global_qtest, irq_line));
>+}
>+
>+static void test_set_hour_alarm(void *obj, void *data, QGuestAllocator *=
alloc)
>+{
>+    QTestState *qts =3D global_qtest;
>+    uint16_t i2c_value =3D 0;
>+    QI2CDevice *i2cdev =3D (QI2CDevice *)obj;
>+    uint8_t irq_line =3D 0;
>+    uint64_t alarm_hour =3D 3;
>+    uint64_t alarm_sec =3D alarm_hour * 60 * 60;
>+    uint8_t reg_hour_a =3D 0x0;
>+    struct tm tm;
>+
>+    qtest_irq_intercept_out(qts, "/machine/peripheral/pcf8563-test/");
>+    set_time(i2cdev, &tm);
>+
>+    /* Enable alarm interrupt */
>+    i2c_set8(i2cdev, PCF8563_CS2, 0x2);
>+
>+    /* Set hour alarm & enable it */
>+    alarm_hour =3D tm=2Etm_hour + alarm_hour;
>+    reg_hour_a =3D to_bcd(alarm_hour) & ~0x80;
>+    i2c_set8(i2cdev, PCF8563_HOUR_A, reg_hour_a);
>+
>+    /* Check when half of supposed alarm time passed */
>+    clock_step((alarm_sec - 1) * NANOSECONDS_PER_SECOND);
>+
>+    g_assert_false(qtest_get_irq(qts, irq_line));
>+
>+    /* Check when alarm time passed */
>+    clock_step((2) * NANOSECONDS_PER_SECOND);
>+
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_HOUR_A);
>+    g_assert_cmphex(i2c_value, =3D=3D, reg_hour_a);
>+    g_assert_true(qtest_get_irq(qts, irq_line));
>+}
>+
>+static void test_set_day_alarm(void *obj, void *data, QGuestAllocator *a=
lloc)
>+{
>+    QTestState *qts =3D global_qtest;
>+    uint16_t i2c_value =3D 0;
>+    QI2CDevice *i2cdev =3D (QI2CDevice *)obj;
>+    uint8_t irq_line =3D 0;
>+    uint64_t alarm_day =3D 1;
>+    uint64_t alarm_sec =3D alarm_day * 24 * 60 * 60;
>+    uint8_t reg_day_a =3D 0x0;
>+    struct tm tm;
>+
>+    qtest_irq_intercept_out(qts, "/machine/peripheral/pcf8563-test/");
>+    set_time(i2cdev, &tm);
>+
>+    /* Enable alarm interrupt */
>+    i2c_set8(i2cdev, PCF8563_CS2, 0x2);
>+
>+    /* Set hour alarm & enable it */
>+    alarm_day =3D tm=2Etm_mday + alarm_day;
>+    reg_day_a =3D to_bcd(alarm_day) & ~0x80;
>+    i2c_set8(i2cdev, PCF8563_DAY_A, reg_day_a);
>+
>+    /* Check when half of supposed alarm time passed */
>+    clock_step((alarm_sec - 1) * NANOSECONDS_PER_SECOND);
>+
>+    g_assert_false(qtest_get_irq(qts, irq_line));
>+
>+    /* Check when alarm time passed */
>+    clock_step((2) * NANOSECONDS_PER_SECOND);
>+
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_DAY_A);
>+    g_assert_cmphex(i2c_value, =3D=3D, reg_day_a);
>+    g_assert_true(qtest_get_irq(qts, irq_line));
>+}
>+
>+static void test_set_wday_alarm(void *obj, void *data, QGuestAllocator *=
alloc)
>+{
>+    QTestState *qts =3D global_qtest;
>+    uint16_t i2c_value =3D 0;
>+    QI2CDevice *i2cdev =3D (QI2CDevice *)obj;
>+    uint8_t irq_line =3D 0;
>+    uint64_t alarm_wday =3D 1;
>+    uint64_t alarm_sec =3D alarm_wday * 24 * 60 * 60;
>+    uint8_t reg_wday_a =3D 0x0;
>+    struct tm tm;
>+
>+    qtest_irq_intercept_out(qts, "/machine/peripheral/pcf8563-test/");
>+    set_time(i2cdev, &tm);
>+
>+    /* Enable alarm interrupt */
>+    i2c_set8(i2cdev, PCF8563_CS2, 0x2);
>+
>+    /* Set hour alarm & enable it */
>+    alarm_wday =3D tm=2Etm_wday + alarm_wday;
>+    reg_wday_a =3D to_bcd(alarm_wday) & ~0x80;
>+    i2c_set8(i2cdev, PCF8563_WEEKDAY_A, reg_wday_a);
>+
>+    /* Check when half of supposed alarm time passed */
>+    clock_step((alarm_sec - 1) * NANOSECONDS_PER_SECOND);
>+
>+    g_assert_false(qtest_get_irq(qts, irq_line));
>+
>+    /* Check when alarm time passed */
>+    clock_step((2) * NANOSECONDS_PER_SECOND);
>+
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_WEEKDAY_A);
>+    g_assert_cmphex(i2c_value, =3D=3D, reg_wday_a);
>+    g_assert_true(qtest_get_irq(qts, irq_line));
>+}
>+
>+static void test_set_min_and_hour_alarm(void *obj,
>+                                        void *data,
>+                                        QGuestAllocator *alloc)
>+{
>+    QTestState *qts =3D global_qtest;
>+    uint16_t i2c_value =3D 0;
>+    QI2CDevice *i2cdev =3D (QI2CDevice *)obj;
>+    uint8_t irq_line =3D 0;
>+    uint64_t alarm_min =3D 1;
>+    uint8_t reg_min_a =3D 0x0;
>+    uint64_t alarm_hour =3D 3;
>+    uint8_t reg_hour_a =3D 0x0;
>+    uint64_t alarm_sec =3D (alarm_hour * 60 * 60) + (alarm_min * 60);
>+    struct tm tm;
>+
>+    qtest_irq_intercept_out(qts, "/machine/peripheral/pcf8563-test/");
>+    set_time(i2cdev, &tm);
>+
>+    /* Enable alarm interrupt */
>+    i2c_set8(i2cdev, PCF8563_CS2, 0x2);
>+
>+    /* Set hour alarm & enable it */
>+    alarm_hour =3D tm=2Etm_hour + alarm_hour;
>+    reg_hour_a =3D to_bcd(alarm_hour) & ~0x80;
>+    i2c_set8(i2cdev, PCF8563_HOUR_A, reg_hour_a);
>+
>+    /* Set minute alarm & enable it */
>+    alarm_min =3D tm=2Etm_min + alarm_min;
>+    reg_min_a =3D to_bcd(alarm_min) & ~0x80;
>+    i2c_set8(i2cdev, PCF8563_MINUTE_A, reg_min_a);
>+
>+    /* Check when half of supposed alarm time passed */
>+    clock_step((alarm_sec - 1) * NANOSECONDS_PER_SECOND);
>+
>+    g_assert_false(qtest_get_irq(global_qtest, irq_line));
>+
>+    /* Check when alarm time passed */
>+    clock_step((2) * NANOSECONDS_PER_SECOND);
>+
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_MINUTE_A);
>+    g_assert_cmphex(i2c_value, =3D=3D, reg_min_a);
>+    g_assert_true(qtest_get_irq(global_qtest, irq_line));
>+}
>+
>+static void test_set_min_and_day_alarm(void *obj,
>+                                       void *data,
>+                                       QGuestAllocator *alloc)
>+{
>+    QTestState *qts =3D global_qtest;
>+    uint16_t i2c_value =3D 0;
>+    QI2CDevice *i2cdev =3D (QI2CDevice *)obj;
>+    uint8_t irq_line =3D 0;
>+    uint64_t alarm_min =3D 1;
>+    uint8_t reg_min_a =3D 0x0;
>+    uint64_t alarm_day =3D 2;
>+    uint8_t reg_day_a =3D 0x0;
>+    uint64_t alarm_sec =3D (alarm_day * 24 * 60 * 60) + (alarm_min * 60)=
;
>+    struct tm tm;
>+
>+    qtest_irq_intercept_out(qts, "/machine/peripheral/pcf8563-test/");
>+    set_time(i2cdev, &tm);
>+
>+    /* Enable alarm interrupt */
>+    i2c_set8(i2cdev, PCF8563_CS2, 0x2);
>+
>+    /* Set day alarm & enable it */
>+    alarm_day =3D tm=2Etm_mday + alarm_day;
>+    reg_day_a =3D to_bcd(alarm_day) & ~0x80;
>+    i2c_set8(i2cdev, PCF8563_DAY_A, reg_day_a);
>+
>+    /* Set minute alarm & enable it */
>+    alarm_min =3D tm=2Etm_min + alarm_min;
>+    reg_min_a =3D to_bcd(alarm_min) & ~0x80;
>+    i2c_set8(i2cdev, PCF8563_MINUTE_A, reg_min_a);
>+
>+    /* Check when half of supposed alarm time passed */
>+    clock_step((alarm_sec - 1) * NANOSECONDS_PER_SECOND);
>+
>+    g_assert_false(qtest_get_irq(global_qtest, irq_line));
>+
>+    /* Check when alarm time passed */
>+    clock_step((2) * NANOSECONDS_PER_SECOND);
>+
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_MINUTE_A);
>+    g_assert_cmphex(i2c_value, =3D=3D, reg_min_a);
>+    g_assert_true(qtest_get_irq(global_qtest, irq_line));
>+}
>+
>+static void test_set_day_and_wday_alarm(void *obj,
>+                                        void *data,
>+                                        QGuestAllocator *alloc)
>+{
>+    QTestState *qts =3D global_qtest;
>+    uint16_t i2c_value =3D 0;
>+    QI2CDevice *i2cdev =3D (QI2CDevice *)obj;
>+    uint8_t irq_line =3D 0;
>+    uint64_t alarm_day =3D 1;
>+    uint8_t reg_day_a =3D 0x0;
>+    uint64_t alarm_wday =3D 2;
>+    uint8_t reg_wday_a =3D 0x0;
>+    uint64_t alarm_sec =3D (alarm_day * 24 * 60 * 60) +
>+                         (alarm_wday * 24 * 60 * 60);
>+    struct tm tm;
>+
>+    qtest_irq_intercept_out(qts, "/machine/peripheral/pcf8563-test/");
>+    set_time(i2cdev, &tm);
>+
>+    /* Enable alarm interrupt */
>+    i2c_set8(i2cdev, PCF8563_CS2, 0x2);
>+
>+    /* Set day alarm & enable it */
>+    alarm_day =3D tm=2Etm_mday + alarm_day;
>+    reg_day_a =3D to_bcd(alarm_day) & ~0x80;
>+    i2c_set8(i2cdev, PCF8563_DAY_A, reg_day_a);
>+
>+    /* Set wday alarm & enable it */
>+    alarm_wday =3D tm=2Etm_wday + alarm_wday;
>+    reg_wday_a =3D to_bcd(alarm_wday) & ~0x80;
>+    i2c_set8(i2cdev, PCF8563_WEEKDAY_A, reg_wday_a);
>+
>+    /* Check when half of supposed alarm time passed */
>+    clock_step((alarm_sec - 1) * NANOSECONDS_PER_SECOND);
>+
>+    g_assert_false(qtest_get_irq(global_qtest, irq_line));
>+
>+    /* Check when alarm time passed */
>+    clock_step((2) * NANOSECONDS_PER_SECOND);
>+
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_WEEKDAY_A);
>+    g_assert_cmphex(i2c_value, =3D=3D, reg_wday_a);
>+    g_assert_true(qtest_get_irq(global_qtest, irq_line));
>+}
>+
>+static void test_set_timer(void *obj, void *data, QGuestAllocator *alloc=
)
>+{
>+    QTestState *qts =3D global_qtest;
>+    uint16_t i2c_value =3D 0;
>+    QI2CDevice *i2cdev =3D (QI2CDevice *)obj;
>+    uint8_t irq_line =3D 0;
>+    uint64_t src_clk_freq =3D 64;
>+    uint8_t reg_timer_ctl =3D 0x81;
>+    uint8_t reg_timer =3D 0xff;
>+    uint64_t countdown_period =3D reg_timer / src_clk_freq;
>+
>+    qtest_irq_intercept_out(qts, "/machine/peripheral/pcf8563-test/");
>+    g_assert_false(qtest_get_irq(global_qtest, irq_line));
>+
>+    i2c_set8(i2cdev, PCF8563_CS2, 0x1);
>+    i2c_set8(i2cdev, PCF8563_TIMER_CTL, reg_timer_ctl);
>+    i2c_set8(i2cdev, PCF8563_TIMER, reg_timer);
>+
>+    clock_step((countdown_period - 1) * NANOSECONDS_PER_SECOND);
>+
>+    g_assert_false(qtest_get_irq(global_qtest, irq_line));
>+
>+    clock_step((2) * NANOSECONDS_PER_SECOND);
>+
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_TIMER_CTL);
>+    g_assert_cmphex(i2c_value, =3D=3D, reg_timer_ctl);
>+    i2c_value =3D i2c_get8(i2cdev, PCF8563_TIMER);
>+    g_assert_cmphex(i2c_value, =3D=3D, 0);
>+    g_assert_true(qtest_get_irq(global_qtest, irq_line));
>+}
>+
>+static void pcf8563_register_nodes(void)
>+{
>+    QOSGraphEdgeOptions opts =3D {
>+        =2Eextra_device_opts =3D "id=3D" TEST_ID ",address=3D0x10",
>+        =2Ebefore_cmd_line =3D "-rtc clock=3Dvm"
>+    };
>+    add_qi2c_address(&opts, &(QI2CAddress) { 0x10 });
>+
>+    qos_node_create_driver("pcf8563", i2c_device_create);
>+
>+    qos_node_consumes("pcf8563", "i2c-bus", &opts);
>+
>+    qos_add_test("test_defaults",
>+                 "pcf8563",
>+                 test_defaults,
>+                 NULL);
>+    qos_add_test("test_check_time",
>+                 "pcf8563",
>+                 test_check_time,
>+                 NULL);
>+    qos_add_test("test_set_minute_alarm",
>+                 "pcf8563",
>+                 test_set_minute_alarm,
>+                 NULL);
>+    qos_add_test("test_set_hour_alarm",
>+                 "pcf8563",
>+                 test_set_hour_alarm,
>+                 NULL);
>+    qos_add_test("test_set_day_alarm",
>+                 "pcf8563",
>+                 test_set_day_alarm,
>+                 NULL);
>+    qos_add_test("test_set_wday_alarm",
>+                 "pcf8563",
>+                 test_set_wday_alarm,
>+                 NULL);
>+    qos_add_test("test_set_min_and_hour_alarm",
>+                 "pcf8563",
>+                 test_set_min_and_hour_alarm,
>+                 NULL);
>+    qos_add_test("test_set_min_and_day_alarm",
>+                 "pcf8563",
>+                 test_set_min_and_day_alarm,
>+                 NULL);
>+    qos_add_test("test_set_day_and_wday_alarm",
>+                 "pcf8563",
>+                 test_set_day_and_wday_alarm,
>+                 NULL);
>+    qos_add_test("test_set_timer",
>+                 "pcf8563",
>+                 test_set_timer,
>+                 NULL);
>+}
>+libqos_init(pcf8563_register_nodes);

