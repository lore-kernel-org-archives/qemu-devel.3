Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E766A606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtHm-0003NF-Ad; Thu, 05 Nov 2026 03:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtHl-0003Mj-9u
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:57:29 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtHj-0003iB-JQ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:57:29 -0500
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cd60c5da24cso1029750a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869046; x=1794473846;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xmNroMpGWl2lemJA5PX/kG1o2rPRZcL22w1qYRUbH5U=;
 b=z1vN2rQtDI6j8WlNpYi0yDKahmLRTLMiuQEuKOJtO7dOOX8hIFB61HZLcSdWgrPZTr
 Ek2+IwRYYv3+jEkaQgLA83pYMouwTq+rPPVgQyfDEtxt2u30B8P3kvi08G87iwUap4ex
 0FZDwwMDoqCMVmcXcc5XBY8ePSOo1JCeh/eiS4PukCPJtepYKXezmxhTZVXnREyPAi3/
 LZ62lYfOHfYCsogaQFEA9OZTW3SCkJ/ALOlMaVZ88oLpka6+XeoHbVskZud7OP+IhTpE
 x7FqeOi2eSTrQCUg6VOMiDH24x0VbcK0RcC97MAraqTG9B3yJcv8XWhD2JkgQ3U64U/V
 MveA==
X-Gm-Message-State: APuU4Z+XukAGdC7ykQKE9uHqhnNLiMbJ9oyKUrisaMtyecbXy5cTQaW3
 HZPhN9Wl64d9hEimZyOGHbSN8LulvH6a7bwhTYW8vQHuylcrfyVdY2JqNiTBbjYwXLs=
X-Gm-Gg: AYBFou03ynJYjGL1/zFaUiIiU7NTGPZkMavoZm4pn3XSMWGON/kQ4xIIegxGxgoRzAi
 u6f6AoPYdbrtiCodkQO9U0iPAt4i+QSgMMMhg+7IFuaVCBMszLRkhSPVT07TDf4kaTs5WhcpS+5
 bO2umi1scz82BMaUpR54jx6kyzRhGQF17sCtF5iCSmNYRcoOebpWX1NYz6HwDfKHaAs4GeNR0FV
 wrsObj02huJPEgejEazNtsUJbHrYE8HFdJle351NpFgUsiSEWb8DgugaxF/yTgsaFASf+1P2uzL
 9AB4W1bKkmUUyeFDZiqBsOusHGj5lq9M3U8hZurkUgjlf0NftjTEfligkebTrOoJ47kzqRp0kxH
 9nowguOvixbY/u1QN9+wAHd8Vb0FOnK9TbrxSi2TFVMvWNhVYgoG46/mBbY/rkMJ9XX7UlBWrru
 4FRkHNEJ+yLYx/5CS/UpJMIIw0sdCn5BONNTUkqQEbU2MZgERWPuxbJ/uGTTTCDb/03ih57VTe/
 WCFouGrDpRHE7Ma3XrAxhx89ao7EvAhSuqJgWH7VUeRan0aCKNw8yT3ga1TLk6/ZmuCllPcYDqx
 wThsPAUM6eNdWoGecrtP5dWa/Nk/hZBVdlIkbZTklLTfJyXvE5dWGfW1KqBxAEzlm2M5XPgcfkP
 uiczeag==
X-Received: by 2002:a17:90b:4cd2:b0:3a7:3474:b1ee with SMTP id
 98e67ed59e1d1-3ae897f8a0dmr16693420a91.60.1793869045936; 
 Thu, 05 Nov 2026 00:57:25 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b3265a52sm2711139a91.10.2026.11.05.00.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:57:25 -0800 (PST)
Date: Thu, 05 Nov 2026 16:50:41 +0800
Subject: [PATCH 05/19] tests/qtest: ds1338: cover the DS1338-specific
 register map
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rtc-ds1339-v1-5-50a8dc463ee8@free.fr>
References: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
In-Reply-To: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, eblot@meta.com, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793868640; l=4130;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=rUA8d+d6nAk/JSdhMcKg9/bMZjbXLM8xkCDgafupUKA=;
 b=nTMmZs6Crxs8ZDQv8VLlrJVHmH0Kj+LaeCaWAudgJBseGIZMLQOsdy+KN/Xxgp4qabm4YB8bX
 lja3LeP5iT5DOb46nZ1awNaenhBfgr0PB6AkVeb/mN81E8h5eIay1ap
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.215.182; envelope-from=eblot.ml@gmail.com;
 helo=mail-pg1-f182.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The register map is a set of per-model class properties. Pin the
values it holds for this part, so a later change cannot alter them
unnoticed.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ds1338-test.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/ds1338-test.c b/tests/qtest/ds1338-test.c
index b8d0e65ec4..6066a34846 100644
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
2.53.0-Meta


