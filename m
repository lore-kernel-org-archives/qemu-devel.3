Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D9606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtJi-0007xA-2r; Thu, 05 Nov 2026 03:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtJP-0007k1-FD
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:59:11 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtJN-0003sQ-Ee
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:59:10 -0500
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cc4c02ddd62so1059352a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:59:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869147; x=1794473947;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UoANilWHPQU+jFLM2oOvVUgxMcTpl1I7pWBnWHE9eEg=;
 b=Xl/0372U+kGBrytQTgxfzfldU4M4gSW74wiwY57DeXGASBRjednsfLfHliys2Ai7Qr
 lyvUmaMWmURsRkBYNOJkspmDATWjpJAuNJG4YhLoy+TDorRaV9+igMj5S44b/sGqh34e
 sI5sJNWdpyUI0/MOcplBe6+CmG5Sri8v1tvHzIIN3FS1zOXA3BarWX3Yh2Z/8zOCXaYB
 CD7aCU/ZK3diKKsR16jzhZMVcBC5NopMO6qx/KqtYAf1mNygyn9zZ3Qm2Gcu7v2VXIc8
 uTalBsOu6NYx+U8bvTMx2Nu6zizIy/2BW9NaFaQt5A3kLJHO3dGTB34eFO0EBfUA9Hhc
 NRdQ==
X-Gm-Message-State: APuU4Z+tTCHnvR0uHAlrN70Qt1z9g2NWQ4pL7Ifrz5tBLDCsnz1gWX50
 3A8SYm8O2YikbcWCOL1HumcFH3pYeA8cAG2R+9cTIAHxOI+hQpATaoacYYOh/kWQlrU=
X-Gm-Gg: AYBFou2ZtTURGohCS2JVgz4rjwoJ3L8rwUKlj8/rWpcrLCc32lT7015bBvWlhj1Zghe
 ooRuF8xqZj9KdisqbC8GO8CRKm6oVLYhLdX5gRdGG3+DfwV3vj3A2Db8VokiMmZTTvDXrG2EaO9
 QXx7Jb0r0I7X33PnNU9xCLeyG0yy47oZbqTt3NFZR9QG1HuVQ5TWowS86Eqq1KhJOI3bUU10FV8
 WS56wGDTsCksuqjaaFmDmm3gXSjJ0ajncETpStNwXXrp8v6KiDpxCMWrwHAJqdqqWp9RGC4Z8gW
 4cJjUznMpylq+IONKirnasrgmCRe6mMS51iiTJQRlrmWIEcbwEHXqEGeB/5bE5PbDbD0/c3qGK8
 NWZHD9AvxAAapA6quQIrtlAEn3Cfod7sW6dRJWPXsJA3rKlttiQYuKCK8CrGOxtIe/ME+SgLDU0
 5k9leSOdotQ+A9ckFBiAfRlywBE4T+GPWPMp0BWvIy1XY1P9+vFrgMJOthvHoQ1Ls5eMZxehsGJ
 /XhmREigiKDOlTDRp5w73Pnt+SFdN287IVPROSDlr8Xe2sTwkT8Rem/5HJ52b+AtHW6SV2J0ooM
 3KJZQ1nBTPFtKTSSxYS7F6a3Mmp1Na6lyw8qYKFcAtpB5mwlYX0yQEGswDtbjhLzWb7sdGFH1rN
 XXv6nWg==
X-Received: by 2002:a05:6a21:a88:b0:3e2:b400:2b04 with SMTP id
 adf61e73a8af0-3e929010560mr16241243637.45.1793869147203; 
 Thu, 05 Nov 2026 00:59:07 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b09a7cc077sm1775988b3a.15.2026.11.05.00.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:59:06 -0800 (PST)
Date: Thu, 05 Nov 2026 16:50:54 +0800
Subject: [PATCH 18/19] tests/qtest: ds1339: cover persist-on-reset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rtc-ds1339-v1-18-50a8dc463ee8@free.fr>
References: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
In-Reply-To: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, eblot@meta.com, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793868641; l=3352;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=KvLAOs8b9crRgRWHo/H40bGm4hfaQpkysjJaNXTXaqY=;
 b=eimiYI3Mtrfb0xV5ZD9t6RuK3n2eMBsxlUne/S4uRRy0BK8L3f3wy4X+rbbKm4qXscmkgv45B
 WSc04NHtrKYB7gT6NincvNPGuzvyVH2I5JJw+ad2RDiUeu4/zMFHB1H
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.215.169; envelope-from=eblot.ml@gmail.com;
 helo=mail-pg1-f169.google.com
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

The property was untested on this variant.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ds1339-test.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tests/qtest/ds1339-test.c b/tests/qtest/ds1339-test.c
index 12562eff5f..a1b5afb331 100644
--- a/tests/qtest/ds1339-test.c
+++ b/tests/qtest/ds1339-test.c
@@ -8,7 +8,10 @@
 
 #include "qemu/osdep.h"
 #include "qemu/bcd.h"
+#include "libqtest.h"
+#include "libqtest-single.h"
 #include "libqos/i2c.h"
+#include "qobject/qdict.h"
 
 #define DS1339_ADDR 0x68
 
@@ -426,6 +429,52 @@ static void test_alarm_registers(void *obj, void *data,
     }
 }
 
+/* A reset restores the power-on state, unless persist-on-reset is set. */
+static void check_reset(QI2CDevice *i2cdev, bool persists)
+{
+    uint8_t year = i2c_get8(i2cdev, DS1339_YEAR);
+    /* A year the clock is not already showing, so the check discriminates. */
+    uint8_t marker = year == 0x42 ? 0x77 : 0x42;
+    QDict *rsp;
+
+    i2c_set8(i2cdev, DS1339_ALARM1, 0xa5);
+    i2c_set8(i2cdev, DS1339_STATUS, 0x00);
+    i2c_set8(i2cdev, DS1339_YEAR, marker);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_ALARM1), ==, 0xa5);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS), ==, 0x00);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_YEAR), ==, marker);
+
+    rsp = qmp("{ 'execute': 'system_reset' }");
+    g_assert(qdict_haskey(rsp, "return"));
+    qobject_unref(rsp);
+    qmp_eventwait("RESET");
+
+    if (persists) {
+        g_assert_cmphex(i2c_get8(i2cdev, DS1339_ALARM1), ==, 0xa5);
+        g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS), ==, 0x00);
+        g_assert_cmphex(i2c_get8(i2cdev, DS1339_YEAR), ==, marker);
+    } else {
+        g_assert_cmphex(i2c_get8(i2cdev, DS1339_ALARM1), ==, 0x00);
+        g_assert_cmphex(i2c_get8(i2cdev, DS1339_CONTROL), ==, 0x18);
+        g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS), ==,
+                        DS1339_STATUS_OSF);
+        /* Back on host time, which is where the year came from. */
+        g_assert_cmphex(i2c_get8(i2cdev, DS1339_YEAR), ==, year);
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
 static void ds1339_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -459,6 +508,13 @@ static void ds1339_register_nodes(void)
     qos_add_test("block-wrap", "ds1339", test_block_wrap, NULL);
     qos_add_test("alarm-registers", "ds1339", test_alarm_registers,
                  NULL);
+    qos_add_test("reset-clears", "ds1339", test_reset_clears, NULL);
+
+    opts.extra_device_opts = "address=0x68,persist-on-reset=on";
+    qos_node_create_driver_named("ds1339-persist", "ds1339", i2c_device_create);
+    qos_node_consumes("ds1339-persist", "i2c-bus", &opts);
+
+    qos_add_test("reset-persists", "ds1339-persist", test_reset_persists, NULL);
 }
 
 libqos_init(ds1339_register_nodes);

-- 
2.53.0-Meta


