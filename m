Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29583606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtIL-0003qu-Jo; Thu, 05 Nov 2026 03:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtIA-0003WI-Hc
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:57:54 -0500
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtI6-0003jz-TK
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:57:52 -0500
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3b0b3438540so404191a91.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869069; x=1794473869;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dMwnpBYmBX5DRYiAUaLE3vWJxcd/Dwa3k0x3lhQO1fU=;
 b=m98kM3F+Mt7CRyZUP33YMRCzA0Kw5zxJp+LXxB/4uxkl5dYv7BovrJ+DGMY7n1GtrH
 kVjL6iiZY8P8w9DDai5Dv0+3YkBOD54HbuQt4g0KvRM4XIT26PLxbuxWM/SnBjMMTKuZ
 IHElFuAEC84p7EA+CQm4unW53sPUPCCY3/xgDo2RiGf0cB1/aMJgLpdwvZggU8n90CDK
 0tontevUgUxlnSUcd1dLO3E7UHEfFk57INXgwiPBaEIrVNx98gXEGbrSIKltLDlTZEAt
 kuIyalqwN4wSscSCcRu0zw5830z7GYdgK+OOiyXSPg0gIJoKIch0oGtM+dr8M8FOW0N+
 JS+Q==
X-Gm-Message-State: APuU4Z/gTGOUBTuvh/qzOOzVDy6xjfoDZZe6lyC0brL0dTSHNyihcgMA
 rOk1KnyM3I9obFhG8ZiD3+H+NBQ/447KZbBb/XNbrbUel3ILliupJBgX6GYky612cTI=
X-Gm-Gg: AYBFou1TLTWqFWuhBiNdwaDzKfe5rs1BD2tzyREqZTUab9CGqy6+SdClFBda0uPWx5i
 Ffj+ku+2BcN/SVtgTZJf401jw6ypwYX/LKS3BOpq7EXAsKB8acuw2ZeudBaKWDH+B6zBETD/ejt
 GKhQN0UYfwPb7f0p/g/x6orxwdaatownVn3oTWsuVvzLr1TEYTTWwrQ66orZmFNg1z0vUL+K1Qi
 39SkkznB5ATW6F9wTVw0n+2kqciK8KsQ4REwbQrsEx7XvkuAn8ky4YZ2Hx7TNI/78LGZmOscvdq
 jzhyV46ETJS4SI1t/mOgCmpqECh+WhPAg7tX1hHtL0Na0VrGzP3ITzG6LNzC+CaeIXdYQ6DD/c2
 I5A/34IH6NI9++19FxP0WojFpxRCTPhNLM3wkMvg2Jr8R/ETQ7NcyxSgDWoXLq96ARezKe3wtSN
 HudEiqVKTKcHoU/P1kA+eA9pPBCWr0eu4CIOGIUK48tDBf6GeRdr44GsIqmEEuZvBuBkZ9Swvnm
 ON4m11dFwacVF6ywficCAVnuy2BS9omBxxDSGk03HW7Jza2rdrJKPQHeXQ/qCQ6AU58peyyribd
 OkUCHbiAYVxa/cYkSrAa+Q1G7h8jVRWrQw3QNysJi5gEqTrUd5t1OuWxlJxWWJC2/tONVMD9Db1
 NTtiZounL54jjhUBG4M1o2+gt4cU=
X-Received: by 2002:a17:90b:5485:b0:3ad:c482:ae9a with SMTP id
 98e67ed59e1d1-3ae8957cc71mr15395829a91.1.1793869069256; 
 Thu, 05 Nov 2026 00:57:49 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb467f8355sm1917049a12.6.2026.11.05.00.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:57:48 -0800 (PST)
Date: Thu, 05 Nov 2026 16:50:44 +0800
Subject: [PATCH 08/19] tests/qtest: ds1338: cover persist-on-reset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rtc-ds1339-v1-8-50a8dc463ee8@free.fr>
References: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
In-Reply-To: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, eblot@meta.com, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793868640; l=3613;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=C9yegjbOQTpe/jjT1t7Ut7zcw5lIqG8k17Dnwvy8ngI=;
 b=mBI9QuIER9uA3mdSNfD/JTx/9gJI2qSEhcohXl17PL18qmGtgbBrWU40rOLuSRexA3WEDONPQ
 a0xTpN86corBKXyPd9ErXz7g4aeQaiVPdrj5PEz6kLn7h+erXCHKi8W
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.216.47; envelope-from=eblot.ml@gmail.com;
 helo=mail-pj1-f47.google.com
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

The property had no coverage in either of its two settings.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ds1338-test.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tests/qtest/ds1338-test.c b/tests/qtest/ds1338-test.c
index 1b73dca98d..1b9c02d931 100644
--- a/tests/qtest/ds1338-test.c
+++ b/tests/qtest/ds1338-test.c
@@ -20,12 +20,15 @@
 #include "qemu/osdep.h"
 #include "qemu/bcd.h"
 #include "libqtest.h"
+#include "libqtest-single.h"
 #include "libqos/i2c.h"
+#include "qobject/qdict.h"
 
 #define DS1338_ADDR 0x68
 
 /* DS1338 register map */
 #define DS1338_SECONDS   0x00
+#define DS1338_YEAR      0x06
 #define DS1338_CONTROL   0x07
 #define DS1338_NVRAM     0x08
 #define DS1338_NUM_REGS  0x40
@@ -136,6 +139,50 @@ static void test_nvram(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get8(i2cdev, 0x3f), ==, 0xc3);
 }
 
+/* A reset restores the power-on state, unless persist-on-reset is set. */
+static void check_reset(QI2CDevice *i2cdev, bool persists)
+{
+    uint8_t year = i2c_get8(i2cdev, DS1338_YEAR);
+    /* A year the clock is not already showing, so the check discriminates. */
+    uint8_t marker = year == 0x42 ? 0x77 : 0x42;
+    QDict *rsp;
+
+    i2c_set8(i2cdev, DS1338_NVRAM, 0xa5);
+    i2c_set8(i2cdev, DS1338_CONTROL, 0x00);
+    i2c_set8(i2cdev, DS1338_YEAR, marker);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_NVRAM), ==, 0xa5);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_CONTROL), ==, 0x00);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_YEAR), ==, marker);
+
+    rsp = qmp("{ 'execute': 'system_reset' }");
+    g_assert(qdict_haskey(rsp, "return"));
+    qobject_unref(rsp);
+    qmp_eventwait("RESET");
+
+    if (persists) {
+        g_assert_cmphex(i2c_get8(i2cdev, DS1338_NVRAM), ==, 0xa5);
+        g_assert_cmphex(i2c_get8(i2cdev, DS1338_CONTROL), ==, 0x00);
+        g_assert_cmphex(i2c_get8(i2cdev, DS1338_YEAR), ==, marker);
+    } else {
+        g_assert_cmphex(i2c_get8(i2cdev, DS1338_NVRAM), ==, 0x00);
+        g_assert_cmphex(i2c_get8(i2cdev, DS1338_CONTROL), ==, DS1338_CTRL_POR);
+        /* Back on host time, which is where the year came from. */
+        g_assert_cmphex(i2c_get8(i2cdev, DS1338_YEAR), ==, year);
+    }
+}
+
+/* Without persist-on-reset, a reset takes the part back to power-on. */
+static void test_reset_clears(void *obj, void *data, QGuestAllocator *alloc)
+{
+    check_reset((QI2CDevice *)obj, false);
+}
+
+/* With persist-on-reset, the registers and the clock survive a reset. */
+static void test_reset_persists(void *obj, void *data, QGuestAllocator *alloc)
+{
+    check_reset((QI2CDevice *)obj, true);
+}
+
 /* The register pointer wraps at the end of the map. */
 static void test_address_wrap(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -162,6 +209,13 @@ static void ds1338_register_nodes(void)
     qos_add_test("clock-halt", "ds1338", test_clock_halt, NULL);
     qos_add_test("nvram", "ds1338", test_nvram, NULL);
     qos_add_test("address-wrap", "ds1338", test_address_wrap, NULL);
+    qos_add_test("reset-clears", "ds1338", test_reset_clears, NULL);
+
+    opts.extra_device_opts = "address=0x68,persist-on-reset=on";
+    qos_node_create_driver_named("ds1338-persist", "ds1338", i2c_device_create);
+    qos_node_consumes("ds1338-persist", "i2c-bus", &opts);
+
+    qos_add_test("reset-persists", "ds1338-persist", test_reset_persists, NULL);
 }
 
 libqos_init(ds1338_register_nodes);

-- 
2.53.0-Meta


