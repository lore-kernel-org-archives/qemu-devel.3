Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8147CCA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHnU-0004qY-CZ; Mon, 12 Oct 2026 11:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHmt-0004Vh-Hl
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:18:06 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHmr-0000GT-VY
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:18:03 -0400
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a172eb31f0so14810915e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791818280; x=1792423080;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9Z7GCM1tL+WVU4df/9TtqoR10rm4Dif9ExOLVyo6FeE=;
 b=PFRIeW7V2F8fRYAjxb2w7zrasDqLLZ/E2TG+8xD5MFwsd2fpJ0uuknOg0CoMUU4ud0
 6lkRzPNn3tYLMF4fgc5OvFDVYogt788XzymC9mcwvLWOGo/dAuHWdFGZooZcAUV2wrlY
 rO9XIjzuA61Vt090Pr+06PwjtNCUnvSLTpv97Cp38J3sZhZdZz6c7c7DpcnIsRXloBmQ
 cZApl7Gsgcsth3zaTD9PfeSFtQEOpCwHIQO24GmTkisCnJNhTVBu8ulrjPoIiK/LYTa5
 o74iHeeC9IOkwYTBhU21KQ2Bego6+BKTeBHT6kwpJwu2T6BqPWkqnvDhc7snTZwmeBAI
 WwHQ==
X-Gm-Message-State: AFq9FYLzCQis7QtiVIX6ILwRI6VSpiN7lM3B4oK6dNE0o48eVmyCKOCL
 n0utfaav49wrHoaosQpauIhlemX+bITbyLWAigQ01V6BTFOJyjbG3gcQCScflAlc
X-Gm-Gg: AYBFou22MUCekcrJV/WZy+vS3X9vjay+n878R0T8sUXqWnsFjQYn2pPWJt5GSqYZjgj
 5JxuxQEAGh3AeSQHrHF6SFsoLtoQioGgzMmZ9lWhEaKt5L719MkMMiSp/j+zLElnsDWtbeVYyjs
 8DYG1vl8Uja9nXBn7Lh2L9mO5AbfmHv6sgtUaRZ2ks5GRZUI+LKlVQ7UZ+T2Hy65GEHEVJZiTpK
 llL/D3IGDFBm3P77isPqd4tl/3e9ExeyA0Moy07hw8XKIQdKVUr6epdXQX45PiuwWz5kqoUKEGF
 hOj8SDDJ5p3DmZGwoIZbyy2h6WIN9FONrAHY7cCEGjDEL73xJvEY9JukB5X2N3jsLbAoPeRKWz1
 TPWvVfW343xiOUmNVmkiPQVs3D/Q6Vszp90xZCPpIopHMFiTxjQ0wim1lVku2si0Ju7kYY/B0mA
 mzywmvQqkEfNUCGFTxs8ffy8FMrPPt77mDN09Td5oCcYej3TlqUzwRny+aRDIoBqSt/7UdhOvZR
 wKyzr8Qdi4KcNAthDCK9HtrMhO1vMtqibweUYWT3r0RtA==
X-Received: by 2002:a05:600c:1908:b0:49f:ce73:5e94 with SMTP id
 5b1f17b1804b1-4a18e4dd018mr188370435e9.34.1791818279914; 
 Mon, 12 Oct 2026 08:17:59 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18c198134sm295148385e9.15.2026.10.12.08.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:17:59 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:18 +0200
Subject: [PATCH v2 25/50] tests/qtest: ds1339: cover oscillator
 stop/restart and time programming
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-25-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
In-Reply-To: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815520; l=3342;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=esijdRHOnlyhX21Z9j9OPDDssjLY1EB+c0uBQYJ2KSk=;
 b=MOw9N0s++3yN+hGM84UByGLThnpwrDptXO0NVpuP8imLKb9i9JGfkbB2+yFmtD/IakBybU0eD
 x/zpIsCjoc1AESXcxuUaKya2XFIs8q9A2Gt+kM8DgPDo/b2aoGY9uf4
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.41; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f41.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Stopping and restarting the oscillator had no coverage, nor did the
time the clock resumes from.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ds1339-test.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tests/qtest/ds1339-test.c b/tests/qtest/ds1339-test.c
index e9dcdc36da..ac19ebd71d 100644
--- a/tests/qtest/ds1339-test.c
+++ b/tests/qtest/ds1339-test.c
@@ -121,6 +121,54 @@ static void test_stopped_reserved_bits(void *obj, void *data,
     g_assert_cmphex(resp[6], ==, 0xff);
 }
 
+/* Setting EOSC stops the oscillator and sets OSF; OSF outlives the restart. */
+static void test_eosc(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    i2c_set8(i2cdev, DS1339_STATUS, 0x00);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS) & DS1339_STATUS_OSF, ==, 0);
+
+    i2c_set8(i2cdev, DS1339_CONTROL, 0x18 | 0x80);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS) & DS1339_STATUS_OSF,
+                    ==, DS1339_STATUS_OSF);
+
+    i2c_set8(i2cdev, DS1339_CONTROL, 0x18);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS) & DS1339_STATUS_OSF,
+                    ==, DS1339_STATUS_OSF);
+    i2c_set8(i2cdev, DS1339_STATUS, 0x00);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS) & DS1339_STATUS_OSF, ==, 0);
+}
+
+/* A stopped clock resumes from the time it was programmed with. */
+static void test_eosc_restart(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    /* 10:20:30 on the 12th of July 2031, the day counter reading 2. */
+    const uint8_t tod[7] = { 0x30, 0x20, 0x10, 0x02, 0x12, 0x07, 0x31 };
+    uint8_t resp[7];
+    unsigned idx;
+
+    i2c_set8(i2cdev, DS1339_CONTROL, 0x18 | 0x80);
+    i2c_write_block(i2cdev, DS1339_SECONDS, tod, sizeof(tod));
+
+    i2c_read_block(i2cdev, DS1339_SECONDS, resp, sizeof(resp));
+    g_assert_cmpmem(resp, sizeof(resp), tod, sizeof(tod));
+
+    i2c_set8(i2cdev, DS1339_CONTROL, 0x18);
+    /* The seconds counter steps within a second of the restart. */
+    for (idx = 0; idx < 15 && i2c_get8(i2cdev, DS1339_SECONDS) == 0x30; idx++) {
+        g_usleep(100 * 1000);
+    }
+
+    i2c_read_block(i2cdev, DS1339_SECONDS, resp, sizeof(resp));
+    g_assert_cmpuint(from_bcd(resp[0]), >, 30);
+    g_assert_cmphex(resp[2], ==, 0x10);
+    g_assert_cmphex(resp[4], ==, 0x12);
+    g_assert_cmphex(resp[5] & 0x1f, ==, 0x07);
+    g_assert_cmphex(resp[6], ==, 0x31);
+}
+
 /* The register pointer wraps at the end of the map. */
 static void test_address_wrap(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -206,6 +254,8 @@ static void ds1339_register_nodes(void)
     qos_add_test("control-register", "ds1339", test_control_register, NULL);
     qos_add_test("status-register", "ds1339", test_status_register, NULL);
     qos_add_test("osf-write-protect", "ds1339", test_osf_write_protect, NULL);
+    qos_add_test("eosc", "ds1339", test_eosc, NULL);
+    qos_add_test("eosc-restart", "ds1339", test_eosc_restart, NULL);
     qos_add_test("stopped-reserved-bits", "ds1339",
                  test_stopped_reserved_bits, NULL);
     qos_add_test("address-wrap", "ds1339", test_address_wrap, NULL);

-- 
2.50.1


