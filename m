Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4D1C79FA7
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cU9-0005ee-CF; Mon, 07 Sep 2026 12:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cTg-0005Ma-Jk
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:45:55 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cTe-0003Xc-Dv
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:45:52 -0400
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48586861639so2633663f8f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799549; x=1789404349;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gTQyBGjiyIwy9r2vZspazLrSMojxjIw2ELy8e30WQmA=;
 b=XGRVDvaVhv8DHDsmIkiH0flI5+oPmOsPizyIWOFVeK9FDLPPLCa9vWA/s3IfLZNStZ
 YQr5yCZURQ/4sDQ46XNcWHvCaSmYQYsOGXpHcYEUMVtHkQmmmHOy8EQABn/58lg5EmM6
 flZhInCy+fQvsXHpHcBrOd7SJd84Tq+ZgNhqmrIvegGOWXtRK2AURxPWBDmg4pq2c3Mk
 VG0F2lVXRyq2jzvqHx3Ks/iUV5aAn+llFJtKweA9AQPd9BYXrulPQGka8uuUxNmec/mT
 ykVf9SHXqNSmFFZd8FH98B2C9mORVb3dKqiFKws6Y2M8b9rODiSve14BKP+mh9uypnuU
 j8qQ==
X-Gm-Message-State: AFuF++nACkuoytZvnb2hQQUrw83ObjfCIBPbTZfnIHZg+ujPI/c1vBFD
 RTAVwM/x1fTP07JnCcltj4SW1X/vh2Db2Pz1F2m4R4Zpur709zvFlarBrfOw4Gut
X-Gm-Gg: AYBFou3EckoRV+nmFqR1C8mbL8OnpP25SSKrAqxSI2H680+b3JJ0gFDx/aN8ePsA0uf
 FooI+r4oBYVkXwg2RvGO4XgURJuevJ2AdHm69lPqIMWd61DzivCZ/RUMWPF62E9GArY7d8CF+AE
 dP116/adtFYQlxtEOVJj59Of28bRS9BXV/nXLwJpHSTQHng1sWIw8guIbjKb1quoIsloI2XDAc9
 AgTCzvAPTxf9usehhaSxwA6C8H/tY8hYoOzCKNd5dqmtHd9ZcgFf14cdmtBGEjI8m1qwVq3lvJN
 x5e0k7zSOJqIl9WI4rgyL5tUHOvBV4kBVN21Yn5VyHfUKcsebP2NDbOSD/UhSR3M3NrdF8Et0Hy
 pjKJBlrZqAsz5trQlGJYrvhOUKR9Oc4+bY8fnU4azP7M3xWzndPtEK4RqZTkPYtqSdYGP1Lx68Y
 LIECRtbBkSHLOkFkIo7v5HYt8joht5mmgHX1TuE27tXogWtWwi+e2r8xod0KQEtyILtNXKam9V8
 i2e8xs7ETXWXdw8HiFxkta6FcoqdrcPnR1szrZ7/fZ99Q==
X-Received: by 2002:a05:6000:4106:b0:485:8a07:3f0b with SMTP id
 ffacd0b85a97d-4858a074201mr24972267f8f.0.1788799548796; 
 Mon, 07 Sep 2026 09:45:48 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48591eb3d3bsm17614891f8f.0.2026.09.07.09.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:45:48 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:42:07 +0200
Subject: [PATCH 17/50] tests/qtest: ds1338: cover the DS1338-specific
 register map
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-17-0d83ad610c3b@free.fr>
References: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
In-Reply-To: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799320; l=4127;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=tY7PIo0ZcZsHwpCofZ6bxj/PZeu4Aq9JxFvHO76x8I4=;
 b=NK8fxKE3xybO+5plmlCcVSOFJBNu0zuvUYFm7WQt1bB1NI6cdGtWPlwGOmS4MnDOfOUUICUdS
 AYBlvegyZmxBt5M7OjVFb/TmxHJ19lg6yAhLPDXmxXTVP21YTRJGT5V
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.54; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f54.google.com
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

The register map is a set of per-model class properties. Pin the
values it holds for this part, so a later change cannot alter them
unnoticed.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ds1338-test.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/ds1338-test.c b/tests/qtest/ds1338-test.c
index b8d0e65ec44..6066a348465 100644
--- a/tests/qtest/ds1338-test.c
+++ b/tests/qtest/ds1338-test.c
@@ -24,6 +24,15 @@
 
 #define DS1338_ADDR 0x68
 
+/* DS1338 register map */
+#define DS1338_SECONDS   0x00
+#define DS1338_CONTROL   0x07
+#define DS1338_NVRAM     0x08
+#define DS1338_NUM_REGS  0x40
+
+#define DS1338_CTRL_OSF  0x20
+
+/* The clock and calendar come up on the host time. */
 static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
 {
     QI2CDevice *i2cdev = (QI2CDevice *)obj;
@@ -32,7 +41,7 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
     time_t now = time(NULL);
     struct tm *tm_ptr = gmtime(&now);
 
-    i2c_read_block(i2cdev, 0, resp, sizeof(resp));
+    i2c_read_block(i2cdev, DS1338_SECONDS, resp, sizeof(resp));
 
     /* check retrieved time against local time */
     g_assert_cmpuint(from_bcd(resp[4]), == , tm_ptr->tm_mday);
@@ -40,6 +49,56 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmpuint(2000 + from_bcd(resp[6]), == , 1900 + tm_ptr->tm_year);
 }
 
+/* Writable control bits round-trip; the reserved ones read back zero. */
+static void test_control_register(void *obj, void *data,
+                                  QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    i2c_set8(i2cdev, DS1338_CONTROL, 0x93);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_CONTROL), ==, 0x93);
+
+    i2c_set8(i2cdev, DS1338_CONTROL, 0x4c);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_CONTROL), ==, 0x00);
+}
+
+/* The oscillator-stop flag can only be cleared by a write, never set. */
+static void test_osf_write_protect(void *obj, void *data,
+                                   QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_CONTROL) & DS1338_CTRL_OSF,
+                    ==, DS1338_CTRL_OSF);
+    i2c_set8(i2cdev, DS1338_CONTROL, 0x00);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_CONTROL) & DS1338_CTRL_OSF, ==, 0);
+    i2c_set8(i2cdev, DS1338_CONTROL, DS1338_CTRL_OSF);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_CONTROL) & DS1338_CTRL_OSF, ==, 0);
+}
+
+/* The user RAM returns what the guest wrote to it. */
+static void test_nvram(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    i2c_set8(i2cdev, 0x08, 0xaa);
+    i2c_set8(i2cdev, 0x20, 0x55);
+    i2c_set8(i2cdev, 0x3f, 0xc3);
+
+    g_assert_cmphex(i2c_get8(i2cdev, 0x08), ==, 0xaa);
+    g_assert_cmphex(i2c_get8(i2cdev, 0x20), ==, 0x55);
+    g_assert_cmphex(i2c_get8(i2cdev, 0x3f), ==, 0xc3);
+}
+
+/* The register pointer wraps at the end of the map. */
+static void test_address_wrap(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    i2c_set8(i2cdev, DS1338_NVRAM, 0x5a);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_NVRAM + DS1338_NUM_REGS), ==, 0x5a);
+}
+
 static void ds1338_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -49,6 +108,12 @@ static void ds1338_register_nodes(void)
 
     qos_node_create_driver("ds1338", i2c_device_create);
     qos_node_consumes("ds1338", "i2c-bus", &opts);
+
     qos_add_test("tx-rx", "ds1338", send_and_receive, NULL);
+    qos_add_test("control-register", "ds1338", test_control_register, NULL);
+    qos_add_test("osf-write-protect", "ds1338", test_osf_write_protect, NULL);
+    qos_add_test("nvram", "ds1338", test_nvram, NULL);
+    qos_add_test("address-wrap", "ds1338", test_address_wrap, NULL);
 }
+
 libqos_init(ds1338_register_nodes);

-- 
2.50.1


