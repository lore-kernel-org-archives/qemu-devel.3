Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A60D5E120
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 03:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Fhp-00005T-3B; Thu, 07 Nov 2024 22:30:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1t9Fhm-0008WH-PG
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 22:30:38 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1t9Fhg-0001J6-Gz
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 22:30:35 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7180d9d0dcbso901713a34.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 19:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1731036631; x=1731641431;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NW3qUuN/ZEbkTtnS3AnRT5VtM+vaDuzUn4gq1rgzlJE=;
 b=rapyV/Ji03xM0sFVHtnwOwoQ8jtFzovDlG+65MIXXRm+YmPfKrPy/JK0onB56g1gvw
 18eZG6IrFP9cyZ0lTatzE5etBNVnheoCi3ydLMjzFCKjHW2sRKoWlKnxduT0/QS0XVjt
 IqGvpxXgJZ0LHz8mpFLACfli6yyZNZuFsAwK/7J0GaTfZ51Sn5UBw4O+WO7SVA8/7wTw
 UO8J1rIOFnVJNJqH4P1XSOYc/7g+MDH+Esy/x4Nbs0dyUHcx2Co30QAqwtNRvRlzELXv
 Q7L8+Y+976lUpDCKOX2rWXzeVsTTB/UdBSPIt9hdUuqeOQ45s9piVYrQikYRWbzVgXan
 uqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731036631; x=1731641431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NW3qUuN/ZEbkTtnS3AnRT5VtM+vaDuzUn4gq1rgzlJE=;
 b=OTRHgKZzXywxABhGeMwg/QDnEeCJ4Gb086NVeWxgcOrIMu9pFtcjiCW9Vkzhuy5Hj6
 kiOApWuBYFmanqvdk/6NJmNW1R+CvxpYl0iT5VHWiBxP43n3DEsSUUcP1MFwKcN+d9YG
 Kq3xONlRgWdvuG+kwJN/cDUi9FXDbIPVmMsZj57x6l1VF2JjRMvkoj+3aYzczDu/UqN3
 7bzqmc2dCla1xLujplWM8vPvjlQqBv7KTfCxiZ61hH3dt6WSy39ZfmYrMG2LM05aNtdN
 cYCACHseBt/9RltxZ/I2tObb/W08fh19B2lnDQ6YqKDBNX7RYqz1axaUWVMVidCCtcrp
 c7Pw==
X-Gm-Message-State: AOJu0YyvU9wKX8wTbbSsrNLSYleMdSe48E7ZZLUbTZjZaT3E0dLeC6I5
 ZJr2i16eCFnCAtrQxecDP9GORTN6zeqQqFh3GR1M9DdZuh2T7bSriF/+ZQR9XGK4ebFjFu7RDNI
 d3Sw=
X-Google-Smtp-Source: AGHT+IEEc1DUsp6lqRBelrJxhRCMbdHqGOx9W3J7PvOplJedSGPpJ9qQd7zNOJvm0F7JPC+bjxiUDg==
X-Received: by 2002:a05:6871:6a6:b0:277:e1bc:7da7 with SMTP id
 586e51a60fabf-2956010ad93mr1330812fac.22.1731036631169; 
 Thu, 07 Nov 2024 19:30:31 -0800 (PST)
Received: from ThinkPad-T14-hirose.hq.igel.co.jp (napt.igel.co.jp.
 [219.106.231.132]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f65d358sm2326435a12.84.2024.11.07.19.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 19:30:30 -0800 (PST)
From: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
To: qemu-devel@nongnu.org
Cc: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 4/5] tests/qtest: add test for memory region access
Date: Fri,  8 Nov 2024 12:29:48 +0900
Message-ID: <20241108032952.56692-5-tomoyuki.hirose@igel.co.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
References: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-ot1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This commit adds a qtest for accessing various memory regions.  The
qtest checks the correctness of handling the access to memory regions
by using 'memaccess-testdev'.

Signed-off-by: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
---
 tests/qtest/memaccess-test.c | 598 +++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build      |   9 +
 2 files changed, 607 insertions(+)
 create mode 100644 tests/qtest/memaccess-test.c

diff --git a/tests/qtest/memaccess-test.c b/tests/qtest/memaccess-test.c
new file mode 100644
index 0000000000..4a6d2089ad
--- /dev/null
+++ b/tests/qtest/memaccess-test.c
@@ -0,0 +1,598 @@
+/*
+ * QEMU memory region access test
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2024 IGEL Co., Ltd.
+ * Author: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#include "hw/misc/memaccess-testdev.h"
+
+static const char *arch = "";
+static const hwaddr base = 0x200000000;
+
+struct arch2cpu {
+    const char *arch;
+    const char *cpu_model;
+};
+
+static struct arch2cpu cpus_map[] = {
+    /* tested targets list */
+    { "arm", "cortex-a15" },
+    { "aarch64", "cortex-a57" },
+    { "avr", "avr6-avr-cpu" },
+    { "x86_64", "qemu64,apic-id=0" },
+    { "i386", "qemu32,apic-id=0" },
+    { "alpha", "ev67" },
+    { "cris", "crisv32" },
+    { "m68k", "m5206" },
+    { "microblaze", "any" },
+    { "microblazeel", "any" },
+    { "mips", "4Kc" },
+    { "mipsel", "I7200" },
+    { "mips64", "20Kc" },
+    { "mips64el", "I6500" },
+    { "or1k", "or1200" },
+    { "ppc", "604" },
+    { "ppc64", "power8e_v2.1" },
+    { "s390x", "qemu" },
+    { "sh4", "sh7750r" },
+    { "sh4eb", "sh7751r" },
+    { "sparc", "LEON2" },
+    { "sparc64", "Fujitsu Sparc64" },
+    { "tricore", "tc1796" },
+    { "xtensa", "dc233c" },
+    { "xtensaeb", "fsf" },
+    { "hppa", "hppa" },
+    { "riscv64", "rv64" },
+    { "riscv32", "rv32" },
+    { "rx", "rx62n" },
+    { "loongarch64", "la464" },
+};
+
+static const char *get_cpu_model_by_arch(const char *arch)
+{
+    for (int i = 0; i < ARRAY_SIZE(cpus_map); i++) {
+        if (!strcmp(arch, cpus_map[i].arch)) {
+            return cpus_map[i].cpu_model;
+        }
+    }
+    return NULL;
+}
+
+static QTestState *create_memaccess_qtest(void)
+{
+    QTestState *qts;
+
+    qts = qtest_initf("-machine none -cpu \"%s\" "
+                      "-device memaccess-testdev,address=0x%" PRIx64,
+                      get_cpu_model_by_arch(arch), base);
+    return qts;
+}
+
+static void little_b_valid(QTestState *qts, uint64_t offset)
+{
+    qtest_writeb(qts, base + offset + 0, 0x00);
+    qtest_writeb(qts, base + offset + 1, 0x11);
+    qtest_writeb(qts, base + offset + 2, 0x22);
+    qtest_writeb(qts, base + offset + 3, 0x33);
+    qtest_writeb(qts, base + offset + 4, 0x44);
+    qtest_writeb(qts, base + offset + 5, 0x55);
+    qtest_writeb(qts, base + offset + 6, 0x66);
+    qtest_writeb(qts, base + offset + 7, 0x77);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 0), ==, 0x00);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 1), ==, 0x11);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 2), ==, 0x22);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 3), ==, 0x33);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 4), ==, 0x44);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 5), ==, 0x55);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 6), ==, 0x66);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 7), ==, 0x77);
+}
+
+static void little_b_invalid(QTestState *qts, uint64_t offset)
+{
+    qtest_writeb(qts, base + offset + 0, 0x00);
+    qtest_writeb(qts, base + offset + 1, 0x11);
+    qtest_writeb(qts, base + offset + 2, 0x22);
+    qtest_writeb(qts, base + offset + 3, 0x33);
+    qtest_writeb(qts, base + offset + 4, 0x44);
+    qtest_writeb(qts, base + offset + 5, 0x55);
+    qtest_writeb(qts, base + offset + 6, 0x66);
+    qtest_writeb(qts, base + offset + 7, 0x77);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 0), ==, 0x00);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 1), ==, 0x11);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 2), ==, 0x22);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 3), ==, 0x33);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 4), ==, 0x44);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 5), ==, 0x55);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 6), ==, 0x66);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 7), ==, 0x77);
+}
+
+static void little_w_valid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writew(qts, base + offset + 0, 0x1100);
+        qtest_writew(qts, base + offset + 1, 0x3322);
+        qtest_writew(qts, base + offset + 2, 0x5544);
+        qtest_writew(qts, base + offset + 3, 0x7766);
+        qtest_writew(qts, base + offset + 4, 0x9988);
+        qtest_writew(qts, base + offset + 5, 0xbbaa);
+        qtest_writew(qts, base + offset + 6, 0xddcc);
+        qtest_writew(qts, base + offset + 7, 0xffee);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 0), ==, 0x1133);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 1), ==, 0x3355);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 2), ==, 0x5577);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 3), ==, 0x7799);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 4), ==, 0x99bb);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 5), ==, 0xbbdd);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 6), ==, 0xddff);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 7), ==, 0xffee);
+    } else {
+        qtest_writew(qts, base + offset + 0, 0x1100);
+        qtest_writew(qts, base + offset + 1, 0x3322);
+        qtest_writew(qts, base + offset + 2, 0x5544);
+        qtest_writew(qts, base + offset + 3, 0x7766);
+        qtest_writew(qts, base + offset + 4, 0x9988);
+        qtest_writew(qts, base + offset + 5, 0xbbaa);
+        qtest_writew(qts, base + offset + 6, 0xddcc);
+        qtest_writew(qts, base + offset + 7, 0xffee);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 0), ==, 0x2200);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 1), ==, 0x4422);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 2), ==, 0x6644);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 3), ==, 0x8866);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 4), ==, 0xaa88);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 5), ==, 0xccaa);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 6), ==, 0xeecc);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 7), ==, 0xffee);
+    }
+}
+
+static void little_w_invalid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writew(qts, base + offset + 0, 0x1100);
+        qtest_writew(qts, base + offset + 2, 0x3322);
+        qtest_writew(qts, base + offset + 4, 0x5544);
+        qtest_writew(qts, base + offset + 6, 0x7766);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 0), ==, 0x1100);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 2), ==, 0x3322);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 4), ==, 0x5544);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 6), ==, 0x7766);
+    } else {
+        qtest_writew(qts, base + offset + 0, 0x1100);
+        qtest_writew(qts, base + offset + 2, 0x3322);
+        qtest_writew(qts, base + offset + 4, 0x5544);
+        qtest_writew(qts, base + offset + 6, 0x7766);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 0), ==, 0x1100);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 2), ==, 0x3322);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 4), ==, 0x5544);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 6), ==, 0x7766);
+    }
+}
+
+static void little_l_valid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writel(qts, base + offset + 0, 0x33221100);
+        qtest_writel(qts, base + offset + 1, 0x77665544);
+        qtest_writel(qts, base + offset + 2, 0xbbaa9988);
+        qtest_writel(qts, base + offset + 3, 0xffeeddcc);
+        qtest_writel(qts, base + offset + 4, 0x01234567);
+        qtest_writel(qts, base + offset + 5, 0x89abcdef);
+        qtest_writel(qts, base + offset + 6, 0xfedcba98);
+        qtest_writel(qts, base + offset + 7, 0x76543210);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 0), ==, 0x3377bbff);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 1), ==, 0x77bbff01);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 2), ==, 0xbbff0189);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 3), ==, 0xff0189fe);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 4), ==, 0x0189fe76);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 5), ==, 0x89fe7654);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 6), ==, 0xfe765432);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 7), ==, 0x76543210);
+    } else {
+        qtest_writel(qts, base + offset + 0, 0x33221100);
+        qtest_writel(qts, base + offset + 1, 0x77665544);
+        qtest_writel(qts, base + offset + 2, 0xbbaa9988);
+        qtest_writel(qts, base + offset + 3, 0xffeeddcc);
+        qtest_writel(qts, base + offset + 4, 0x01234567);
+        qtest_writel(qts, base + offset + 5, 0x89abcdef);
+        qtest_writel(qts, base + offset + 6, 0xfedcba98);
+        qtest_writel(qts, base + offset + 7, 0x76543210);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 0), ==, 0xcc884400);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 1), ==, 0x67cc8844);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 2), ==, 0xef67cc88);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 3), ==, 0x98ef67cc);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 4), ==, 0x1098ef67);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 5), ==, 0x321098ef);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 6), ==, 0x54321098);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 7), ==, 0x76543210);
+    }
+}
+
+static void little_l_invalid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writel(qts, base + offset + 0, 0x33221100);
+        qtest_writel(qts, base + offset + 4, 0x77665544);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 0), ==, 0x33221100);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 4), ==, 0x77665544);
+    } else {
+        qtest_writel(qts, base + offset + 0, 0x33221100);
+        qtest_writel(qts, base + offset + 4, 0x77665544);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 0), ==, 0x33221100);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 4), ==, 0x77665544);
+    }
+}
+
+static void little_q_valid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writeq(qts, base + offset + 0, 0x7766554433221100);
+        qtest_writeq(qts, base + offset + 1, 0xffeeddccbbaa9988);
+        qtest_writeq(qts, base + offset + 2, 0xfedcba9876543210);
+        qtest_writeq(qts, base + offset + 3, 0x0123456789abcdef);
+        qtest_writeq(qts, base + offset + 4, 0xdeadbeefdeadbeef);
+        qtest_writeq(qts, base + offset + 5, 0xcafebabecafebabe);
+        qtest_writeq(qts, base + offset + 6, 0xbeefcafebeefcafe);
+        qtest_writeq(qts, base + offset + 7, 0xfacefeedfacefeed);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 0), ==,
+                        0x77fffe01decabefa);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 1), ==,
+                        0xfffe01decabeface);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 2), ==,
+                        0xfe01decabefacefe);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 3), ==,
+                        0x01decabefacefeed);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 4), ==,
+                        0xdecabefacefeedfa);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 5), ==,
+                        0xcabefacefeedface);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 6), ==,
+                        0xbefacefeedfacefe);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 7), ==,
+                        0xfacefeedfacefeed);
+    } else {
+        qtest_writeq(qts, base + offset + 0, 0x7766554433221100);
+        qtest_writeq(qts, base + offset + 1, 0xffeeddccbbaa9988);
+        qtest_writeq(qts, base + offset + 2, 0xfedcba9876543210);
+        qtest_writeq(qts, base + offset + 3, 0x0123456789abcdef);
+        qtest_writeq(qts, base + offset + 4, 0xdeadbeefdeadbeef);
+        qtest_writeq(qts, base + offset + 5, 0xcafebabecafebabe);
+        qtest_writeq(qts, base + offset + 6, 0xbeefcafebeefcafe);
+        qtest_writeq(qts, base + offset + 7, 0xfacefeedfacefeed);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 0), ==,
+                        0xedfebeefef108800);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 1), ==,
+                        0xfeedfebeefef1088);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 2), ==,
+                        0xcefeedfebeefef10);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 3), ==,
+                        0xfacefeedfebeefef);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 4), ==,
+                        0xedfacefeedfebeef);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 5), ==,
+                        0xfeedfacefeedfebe);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 6), ==,
+                        0xcefeedfacefeedfe);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 7), ==,
+                        0xfacefeedfacefeed);
+    }
+}
+
+static void little_q_invalid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writeq(qts, base + offset + 0, 0x7766554433221100);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 0), ==,
+                        0x7766554433221100);
+    } else {
+        qtest_writeq(qts, base + offset + 0, 0x7766554433221100);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 0), ==,
+                        0x7766554433221100);
+    }
+}
+
+static void big_b_valid(QTestState *qts, uint64_t offset)
+{
+    qtest_writeb(qts, base + offset + 0, 0x00);
+    qtest_writeb(qts, base + offset + 1, 0x11);
+    qtest_writeb(qts, base + offset + 2, 0x22);
+    qtest_writeb(qts, base + offset + 3, 0x33);
+    qtest_writeb(qts, base + offset + 4, 0x44);
+    qtest_writeb(qts, base + offset + 5, 0x55);
+    qtest_writeb(qts, base + offset + 6, 0x66);
+    qtest_writeb(qts, base + offset + 7, 0x77);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 0), ==, 0x00);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 1), ==, 0x11);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 2), ==, 0x22);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 3), ==, 0x33);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 4), ==, 0x44);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 5), ==, 0x55);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 6), ==, 0x66);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 7), ==, 0x77);
+}
+
+static void big_b_invalid(QTestState *qts, uint64_t offset)
+{
+    qtest_writeb(qts, base + offset + 0, 0x00);
+    qtest_writeb(qts, base + offset + 1, 0x11);
+    qtest_writeb(qts, base + offset + 2, 0x22);
+    qtest_writeb(qts, base + offset + 3, 0x33);
+    qtest_writeb(qts, base + offset + 4, 0x44);
+    qtest_writeb(qts, base + offset + 5, 0x55);
+    qtest_writeb(qts, base + offset + 6, 0x66);
+    qtest_writeb(qts, base + offset + 7, 0x77);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 0), ==, 0x00);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 1), ==, 0x11);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 2), ==, 0x22);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 3), ==, 0x33);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 4), ==, 0x44);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 5), ==, 0x55);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 6), ==, 0x66);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 7), ==, 0x77);
+}
+
+static void big_w_valid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writew(qts, base + offset + 0, 0x1100);
+        qtest_writew(qts, base + offset + 1, 0x3322);
+        qtest_writew(qts, base + offset + 2, 0x5544);
+        qtest_writew(qts, base + offset + 3, 0x7766);
+        qtest_writew(qts, base + offset + 4, 0x9988);
+        qtest_writew(qts, base + offset + 5, 0xbbaa);
+        qtest_writew(qts, base + offset + 6, 0xddcc);
+        qtest_writew(qts, base + offset + 7, 0xffee);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 0), ==, 0x1133);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 1), ==, 0x3355);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 2), ==, 0x5577);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 3), ==, 0x7799);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 4), ==, 0x99bb);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 5), ==, 0xbbdd);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 6), ==, 0xddff);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 7), ==, 0xffee);
+    } else {
+        qtest_writew(qts, base + offset + 0, 0x1100);
+        qtest_writew(qts, base + offset + 1, 0x3322);
+        qtest_writew(qts, base + offset + 2, 0x5544);
+        qtest_writew(qts, base + offset + 3, 0x7766);
+        qtest_writew(qts, base + offset + 4, 0x9988);
+        qtest_writew(qts, base + offset + 5, 0xbbaa);
+        qtest_writew(qts, base + offset + 6, 0xddcc);
+        qtest_writew(qts, base + offset + 7, 0xffee);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 0), ==, 0x2200);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 1), ==, 0x4422);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 2), ==, 0x6644);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 3), ==, 0x8866);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 4), ==, 0xaa88);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 5), ==, 0xccaa);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 6), ==, 0xeecc);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 7), ==, 0xffee);
+    }
+}
+
+static void big_w_invalid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writew(qts, base + offset + 0, 0x1100);
+        qtest_writew(qts, base + offset + 2, 0x3322);
+        qtest_writew(qts, base + offset + 4, 0x5544);
+        qtest_writew(qts, base + offset + 6, 0x7766);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 0), ==, 0x1100);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 2), ==, 0x3322);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 4), ==, 0x5544);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 6), ==, 0x7766);
+    } else {
+        qtest_writew(qts, base + offset + 0, 0x1100);
+        qtest_writew(qts, base + offset + 2, 0x3322);
+        qtest_writew(qts, base + offset + 4, 0x5544);
+        qtest_writew(qts, base + offset + 6, 0x7766);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 0), ==, 0x1100);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 2), ==, 0x3322);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 4), ==, 0x5544);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 6), ==, 0x7766);
+    }
+}
+
+static void big_l_valid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writel(qts, base + offset + 0, 0x33221100);
+        qtest_writel(qts, base + offset + 1, 0x77665544);
+        qtest_writel(qts, base + offset + 2, 0xbbaa9988);
+        qtest_writel(qts, base + offset + 3, 0xffeeddcc);
+        qtest_writel(qts, base + offset + 4, 0x01234567);
+        qtest_writel(qts, base + offset + 5, 0x89abcdef);
+        qtest_writel(qts, base + offset + 6, 0xfedcba98);
+        qtest_writel(qts, base + offset + 7, 0x76543210);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 0), ==, 0x3377bbff);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 1), ==, 0x77bbff01);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 2), ==, 0xbbff0189);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 3), ==, 0xff0189fe);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 4), ==, 0x0189fe76);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 5), ==, 0x89fe7654);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 6), ==, 0xfe765432);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 7), ==, 0x76543210);
+    } else {
+        qtest_writel(qts, base + offset + 0, 0x33221100);
+        qtest_writel(qts, base + offset + 1, 0x77665544);
+        qtest_writel(qts, base + offset + 2, 0xbbaa9988);
+        qtest_writel(qts, base + offset + 3, 0xffeeddcc);
+        qtest_writel(qts, base + offset + 4, 0x01234567);
+        qtest_writel(qts, base + offset + 5, 0x89abcdef);
+        qtest_writel(qts, base + offset + 6, 0xfedcba98);
+        qtest_writel(qts, base + offset + 7, 0x76543210);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 0), ==, 0xcc884400);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 1), ==, 0x67cc8844);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 2), ==, 0xef67cc88);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 3), ==, 0x98ef67cc);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 4), ==, 0x1098ef67);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 5), ==, 0x321098ef);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 6), ==, 0x54321098);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 7), ==, 0x76543210);
+    }
+}
+
+static void big_l_invalid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writel(qts, base + offset + 0, 0x33221100);
+        qtest_writel(qts, base + offset + 4, 0x77665544);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 0), ==, 0x33221100);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 4), ==, 0x77665544);
+    } else {
+        qtest_writel(qts, base + offset + 0, 0x33221100);
+        qtest_writel(qts, base + offset + 4, 0x77665544);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 0), ==, 0x33221100);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 4), ==, 0x77665544);
+    }
+}
+
+static void big_q_valid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writeq(qts, base + offset + 0, 0x7766554433221100);
+        qtest_writeq(qts, base + offset + 1, 0xffeeddccbbaa9988);
+        qtest_writeq(qts, base + offset + 2, 0xfedcba9876543210);
+        qtest_writeq(qts, base + offset + 3, 0x0123456789abcdef);
+        qtest_writeq(qts, base + offset + 4, 0xdeadbeefdeadbeef);
+        qtest_writeq(qts, base + offset + 5, 0xcafebabecafebabe);
+        qtest_writeq(qts, base + offset + 6, 0xbeefcafebeefcafe);
+        qtest_writeq(qts, base + offset + 7, 0xfacefeedfacefeed);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 0), ==,
+                        0x77fffe01decabefa);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 1), ==,
+                        0xfffe01decabeface);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 2), ==,
+                        0xfe01decabefacefe);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 3), ==,
+                        0x01decabefacefeed);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 4), ==,
+                        0xdecabefacefeedfa);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 5), ==,
+                        0xcabefacefeedface);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 6), ==,
+                        0xbefacefeedfacefe);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 7), ==,
+                        0xfacefeedfacefeed);
+    } else {
+        qtest_writeq(qts, base + offset + 0, 0x7766554433221100);
+        qtest_writeq(qts, base + offset + 1, 0xffeeddccbbaa9988);
+        qtest_writeq(qts, base + offset + 2, 0xfedcba9876543210);
+        qtest_writeq(qts, base + offset + 3, 0x0123456789abcdef);
+        qtest_writeq(qts, base + offset + 4, 0xdeadbeefdeadbeef);
+        qtest_writeq(qts, base + offset + 5, 0xcafebabecafebabe);
+        qtest_writeq(qts, base + offset + 6, 0xbeefcafebeefcafe);
+        qtest_writeq(qts, base + offset + 7, 0xfacefeedfacefeed);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 0), ==,
+                        0xedfebeefef108800);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 1), ==,
+                        0xfeedfebeefef1088);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 2), ==,
+                        0xcefeedfebeefef10);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 3), ==,
+                        0xfacefeedfebeefef);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 4), ==,
+                        0xedfacefeedfebeef);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 5), ==,
+                        0xfeedfacefeedfebe);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 6), ==,
+                        0xcefeedfacefeedfe);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 7), ==,
+                        0xfacefeedfacefeed);
+    }
+}
+
+static void big_q_invalid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writeq(qts, base + offset + 0, 0x7766554433221100);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 0), ==,
+                        0x7766554433221100);
+    } else {
+        qtest_writeq(qts, base + offset + 0, 0x7766554433221100);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 0), ==,
+                        0x7766554433221100);
+    }
+}
+
+#define DEFINE_test_memaccess(e, e_u, w, w_u, v, v_u)                   \
+    static void                                                         \
+    test_memaccess_##e##_##w##_##v(void)                                \
+    {                                                                   \
+        QTestState *qts;                                                \
+        qts = create_memaccess_qtest();                                 \
+        if (!qts) {                                                     \
+            return;                                                     \
+        }                                                               \
+                                                                        \
+        for (size_t i = OFF_IDX_OPS_LIST_##e_u##_##w_u##_##v_u;         \
+             i < OFF_IDX_OPS_LIST_##e_u##_##w_u##_##v_u +               \
+                 N_OPS_LIST_##e_u##_##w_u##_##v_u;                      \
+             i++) {                                                     \
+            e##_##w##_##v(qts, MEMACCESS_TESTDEV_REGION_SIZE * i);      \
+        }                                                               \
+                                                                        \
+        qtest_quit(qts);                                                \
+    }
+
+DEFINE_test_memaccess(little, LITTLE, b, B, valid, VALID)
+DEFINE_test_memaccess(little, LITTLE, w, W, valid, VALID)
+DEFINE_test_memaccess(little, LITTLE, l, L, valid, VALID)
+DEFINE_test_memaccess(little, LITTLE, q, Q, valid, VALID)
+DEFINE_test_memaccess(little, LITTLE, b, B, invalid, INVALID)
+DEFINE_test_memaccess(little, LITTLE, w, W, invalid, INVALID)
+DEFINE_test_memaccess(little, LITTLE, l, L, invalid, INVALID)
+DEFINE_test_memaccess(little, LITTLE, q, Q, invalid, INVALID)
+DEFINE_test_memaccess(big, BIG, b, B, valid, VALID)
+DEFINE_test_memaccess(big, BIG, w, W, valid, VALID)
+DEFINE_test_memaccess(big, BIG, l, L, valid, VALID)
+DEFINE_test_memaccess(big, BIG, q, Q, valid, VALID)
+DEFINE_test_memaccess(big, BIG, b, B, invalid, INVALID)
+DEFINE_test_memaccess(big, BIG, w, W, invalid, INVALID)
+DEFINE_test_memaccess(big, BIG, l, L, invalid, INVALID)
+DEFINE_test_memaccess(big, BIG, q, Q, invalid, INVALID)
+
+#undef DEFINE_test_memaccess
+
+static struct {
+    const char *name;
+    void (*test)(void);
+} tests[] = {
+    {"little_b_valid", test_memaccess_little_b_valid},
+    {"little_w_valid", test_memaccess_little_w_valid},
+    {"little_l_valid", test_memaccess_little_l_valid},
+    {"little_q_valid", test_memaccess_little_q_valid},
+    {"little_b_invalid", test_memaccess_little_b_invalid},
+    {"little_w_invalid", test_memaccess_little_w_invalid},
+    {"little_l_invalid", test_memaccess_little_l_invalid},
+    {"little_q_invalid", test_memaccess_little_q_invalid},
+    {"big_b_valid", test_memaccess_big_b_valid},
+    {"big_w_valid", test_memaccess_big_w_valid},
+    {"big_l_valid", test_memaccess_big_l_valid},
+    {"big_q_valid", test_memaccess_big_q_valid},
+    {"big_b_invalid", test_memaccess_big_b_invalid},
+    {"big_w_invalid", test_memaccess_big_w_invalid},
+    {"big_l_invalid", test_memaccess_big_l_invalid},
+    {"big_q_invalid", test_memaccess_big_q_invalid},
+};
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    arch = qtest_get_arch();
+
+    for (int i = 0; i < ARRAY_SIZE(tests); i++) {
+        g_autofree gchar *path = g_strdup_printf("memaccess/%s", tests[i].name);
+        qtest_add_func(path, tests[i].test);
+    }
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index aa93e98418..49271cbc3f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -93,6 +93,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_SB16') ? ['fuzz-sb16-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_ESP_PCI') ? ['am53c974-test'] : []) +                 \
+  (config_all_devices.has_key('CONFIG_MEMACCESS_TESTDEV') ? ['memaccess-test'] : []) +      \
   (host_os != 'windows' and                                                                \
    config_all_devices.has_key('CONFIG_ACPI_ERST') ? ['erst-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_PCIE_PORT') and                                       \
@@ -136,6 +137,7 @@ qtests_x86_64 = qtests_i386
 
 qtests_alpha = ['boot-serial-test'] + \
   qtests_filter + \
+  (config_all_devices.has_key('CONFIG_MEMACCESS_TESTDEV') ? ['memaccess-test'] : []) +       \
   (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : [])
 
 qtests_avr = [ 'boot-serial-test' ]
@@ -158,6 +160,7 @@ qtests_microblazeel = qtests_microblaze
 
 qtests_mips = \
   qtests_filter + \
+  (config_all_devices.has_key('CONFIG_MEMACCESS_TESTDEV') ? ['memaccess-test'] : []) +       \
   (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : [])
 
@@ -169,6 +172,7 @@ qtests_ppc = \
   qtests_filter + \
   (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_M48T59') ? ['m48t59-test'] : []) +                     \
+  (config_all_devices.has_key('CONFIG_MEMACCESS_TESTDEV') ? ['memaccess-test'] : []) +       \
   (config_all_accel.has_key('CONFIG_TCG') ? ['prom-env-test'] : []) +                              \
   (config_all_accel.has_key('CONFIG_TCG') ? ['boot-serial-test'] : []) +                           \
   ['boot-order-test']
@@ -195,6 +199,7 @@ qtests_sparc = ['prom-env-test', 'm48t59-test', 'boot-serial-test'] + \
 
 qtests_sparc64 = \
   (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \
+  (config_all_devices.has_key('CONFIG_MEMACCESS_TESTDEV') ? ['memaccess-test'] : []) +       \
   qtests_filter + \
   ['prom-env-test', 'boot-serial-test']
 
@@ -240,6 +245,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
    config_all_devices.has_key('CONFIG_DM163')? ['dm163-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_MEMACCESS_TESTDEV') ? ['memaccess-test'] : []) + \
   ['arm-cpu-features',
    'boot-serial-test']
 
@@ -254,6 +260,7 @@ qtests_aarch64 = \
   (config_all_accel.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
+  (config_all_devices.has_key('CONFIG_MEMACCESS_TESTDEV') ? ['memaccess-test'] : []) + \
   ['arm-cpu-features',
    'numa-test',
    'boot-serial-test',
@@ -269,9 +276,11 @@ qtests_s390x = \
    'migration-test']
 
 qtests_riscv32 = \
+  (config_all_devices.has_key('CONFIG_MEMACCESS_TESTDEV') ? ['memaccess-test'] : []) + \
   (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
 
 qtests_riscv64 = \
+  (config_all_devices.has_key('CONFIG_MEMACCESS_TESTDEV') ? ['memaccess-test'] : []) + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : [])
 
 qos_test_ss = ss.source_set()
-- 
2.43.0


