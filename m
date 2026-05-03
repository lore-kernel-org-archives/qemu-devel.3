Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA482CD342F
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2026 05:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJPrJ-0001Fx-QB; Sun, 03 May 2026 01:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wJM6F-0004wp-MN
 for qemu-devel@nongnu.org; Sat, 02 May 2026 21:58:27 -0400
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wJM6D-0000Yq-AS
 for qemu-devel@nongnu.org; Sat, 02 May 2026 21:58:26 -0400
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso5331549eec.1
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 18:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777773503; x=1778378303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gcpjqh/XTVHiUj0x51nDVg2xWlGOek5lFSsj05b9g04=;
 b=hVpR3a24Fj+MkB5c9344FlmbpP1EGO8rOBf1K8RXLZKkjb8AMLSklzU7EwLu+Nc4AC
 /6mhF5OK1GqDVLQPsEZvZOE6C5yI73fcjh00o1KnA+bAtxlv8KKgynpXNHhXey+19suv
 l8AUtPq/lpntqLtcgu5LK761qjdt1Q5wDZbuH4LioRtL+qOHxGF2ajpByFUeT62jNCVn
 m7NsOrB0wlRkK8ez3VTraaSYx4ZKpTWlc0/2HKM6kJ8RHGbm4UUy5dhOjzCZ/B5636ZY
 hywUEBkvIpcZr9oCXcJYzk4Jqxbo7QNixTguofBOIIQ5Ww5ja3z6TwwQV+kplnDgonCq
 BmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777773503; x=1778378303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gcpjqh/XTVHiUj0x51nDVg2xWlGOek5lFSsj05b9g04=;
 b=mp+ZHqS/PJVcI1lsVbC+5bG7TVfiokm96Erf2NzG0EDlXy2zrTmNJIsGlyo1rBn+fE
 oGIgXEDBplRgC98vsism6do3SS0nKz6VZZ9ieTBC2io57FneNZ5f16ZieBXsHkq3o9OI
 oWlW+I8WSu5LBR0Yp05+H4FVISwFkTLqFUH4Ml4lwOG/QrvZaSHWeRHIjSN1UM+X1GC1
 AM3l43sSupuVhmt3BexJ8NOLzU7htdJJtQisjz17aRxUiJ1wy5aVxXRkyy5JDNlgTdi3
 TLIzWY5uMw3eexyW2z79YDnpG5tDabGJu/CAVX4ww0HpQ92ieSDzgVcmnqCPTzy/PlqJ
 STMQ==
X-Gm-Message-State: AOJu0YzpVleDubkoDprhh1GImd/GSC094m3qXcU4n74BiGfyqGbTHoWC
 SvzsbFZGBICOh4XU8AcFMRqeT9RwRhTmrNgvf82JUehmTGCT6i32FHMMBn2Ogw==
X-Gm-Gg: AeBDietV4ja3vp14c3z3x8CHJsxsgv44zz6G7jFoWCh7LEEj9lUOTzv3WQVU6XAcGRJ
 9aZ3NFsn8co/sIsl5GeIlmATUdE2TkSDoMTn+Dp+i5j9IcdlIFugyHVPmB/kzpCD4G8lL6kr2Bf
 zvkDBtEqncTa7P+olD9NJtgpNzWSQt/RZTJ59QGR2Q/a5K9AZ4DC5igM0/kbv6acxoJeKae7L8T
 ec7jgu0ETeT4e74M9S5RcdIZ5cbZ02Pq0oyWnxeZUwsbKAtsi8YPeiorpDrGyG4kTgQ83qsBvQu
 TomN9w3r9oJYqkXexdQUXEHd9YYKQ3Lu1x20IDDtbP7DNuWeUxkB43WlBuAUrGJN4uwBD/cbRcb
 X0mQ4f+z3e/4YuFPs1ZeFKi6rQ9RLE6zv4y865Aqr6yyS8qq2CMSJdq7kAUSG1fm773zwGUNlWU
 vilEirJr9NbftFm+Jj7zhBoTH/othN8rbUoSGbxJiOVoZXRkSNyg==
X-Received: by 2002:a05:7301:9f06:b0:2d8:df01:d9f6 with SMTP id
 5a478bee46e88-2efba17c714mr1929349eec.23.1777773503474; 
 Sat, 02 May 2026 18:58:23 -0700 (PDT)
Received: from newsled.lan ([76.133.142.170]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee38d79eb9sm14361735eec.8.2026.05.02.18.58.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 02 May 2026 18:58:23 -0700 (PDT)
From: 54weasels <54weasels@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	thuth@redhat.com,
	54weasels <54weasels@gmail.com>
Subject: [PATCH 6/7] tests/qtest: Add Sun-3 hardware interaction tests
Date: Sat,  2 May 2026 18:57:55 -0700
Message-ID: <20260503015756.99176-7-54weasels@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260503015756.99176-1-54weasels@gmail.com>
References: <20260503015756.99176-1-54weasels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1331;
 envelope-from=54weasels@gmail.com; helo=mail-dy1-x1331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 03 May 2026 01:59:14 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This adds basic architectural and register validation for the newly assembled Sun-3 machine.

Signed-off-by: 54weasels <54weasels@gmail.com>
---
 tests/qtest/meson.build |  1 +
 tests/qtest/sun3-test.c | 67 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 tests/qtest/sun3-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index be4fa627b5..184d1a3f8c 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -154,6 +154,7 @@ qtests_loongarch64 = qtests_filter + \
    'cpu-plug-test']
 
 qtests_m68k = ['boot-serial-test'] + \
+  ['sun3-test'] + \
   qtests_filter
 
 qtests_microblaze = ['boot-serial-test'] + \
diff --git a/tests/qtest/sun3-test.c b/tests/qtest/sun3-test.c
new file mode 100644
index 0000000000..50f6c166d1
--- /dev/null
+++ b/tests/qtest/sun3-test.c
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QTest device validation for the Sun-3 Machine
+ *
+ * Copyright (c) 2026
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+/* OBIO Memory Map Addresses */
+#define SUN3_INTREG_BASE 0x0FEA0000
+#define SUN3_MEMERR_BASE 0x0FE80000
+
+static void test_intreg(void)
+{
+    QTestState *s;
+    uint8_t val;
+
+    s = qtest_init("-machine sun3 -nographic");
+
+    /* Default state should be 0 */
+    val = qtest_readb(s, SUN3_INTREG_BASE);
+    g_assert_cmphex(val, ==, 0x00);
+
+    /* Write and verify */
+    qtest_writeb(s, SUN3_INTREG_BASE, 0x0f);
+    val = qtest_readb(s, SUN3_INTREG_BASE);
+    g_assert_cmphex(val, ==, 0x0f);
+
+    qtest_quit(s);
+}
+
+static void test_memerr(void)
+{
+    QTestState *s;
+    uint8_t val;
+
+    s = qtest_init("-machine sun3 -nographic");
+
+    /* Default state should be 0x40 (default no-error) */
+    val = qtest_readb(s, SUN3_MEMERR_BASE);
+    g_assert_cmphex(val, ==, 0x40);
+
+    /* Test parity error spoof sequence */
+    qtest_writeb(s, SUN3_MEMERR_BASE, 0x20); /* Set test_parity_written */
+    qtest_writeb(s, SUN3_MEMERR_BASE, 0x50); /* Trigger spoof */
+    val = qtest_readb(s, SUN3_MEMERR_BASE);
+
+    /*
+     * Since we didn't clock enough parity lanes, high bit and lane 8 should
+     * be set (0x50 | 0x80 | 0x08 = 0xd8)
+     */
+    g_assert_cmphex(val, ==, 0xd8);
+
+    qtest_quit(s);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/m68k/sun3/intreg", test_intreg);
+    qtest_add_func("/m68k/sun3/memerr", test_memerr);
+
+    return g_test_run();
+}
-- 
2.50.1 (Apple Git-155)


