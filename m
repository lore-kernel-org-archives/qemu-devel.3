Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A42E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 00:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLtVl-0007FS-Jz; Thu, 12 Dec 2024 19:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3LX9bZwwKCtoJ67EDAOPAB6JCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--nabihestefan.bounces.google.com>)
 id 1tLtVj-0007F4-Ii
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 19:26:27 -0500
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3LX9bZwwKCtoJ67EDAOPAB6JCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--nabihestefan.bounces.google.com>)
 id 1tLtVh-0003ts-EH
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 19:26:27 -0500
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2f129f7717fso1175878a91.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 16:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1734049581; x=1734654381; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OnTkKmI98HLqjCoEGGsWWLjffxSTToPbCN+awUwxOzs=;
 b=SB3hc7JogvkXnoICARTEV250nSBA7intKbisWHnGSfXbpMYUaVdcYIBjqWxSvKjfeb
 ixScYbVRxgYgetjlq0sblDh4tAPjLPr1bzaj3OHHuW8Ap1p0UnajU9iDzXFAM9Otolb0
 zQ2gy3NCba52HBWYVk2w5svQnidoDDSdtrFecSUfZCRxoIAq9pYQf8PH/cL3P1T+gQ++
 sOGnEm/aYskTsYkknYQet/U2lcIOXLuEO2Y0KFJTnMS6hMLoL4OGqB+YkpbXS3aOH3Af
 YQvPZ5X/oZKav6J8n5+od4I+H4pqgbWPgUZlGkKsMPYnAfZuJIZGe8UjhdWYwjxAAa8M
 Gobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734049581; x=1734654381;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OnTkKmI98HLqjCoEGGsWWLjffxSTToPbCN+awUwxOzs=;
 b=gMydZt/X/0q0Sv4ooFZKwWzFVazIKCpi1AzODyYmlzYSCJnpVlVrvXor6enhuGV6sA
 L4l9bSFFPkNZx72m1QPoLN/JNXE2sMDKad4iNZe0X3Xy9p3YLS+GSXSnh6dd5SAQtZHi
 tA7raTNtnF/Jh6Ym7p4VhKTVTQVi8DeQqDuTh1aW2DPwbCK117mSkVeA5wKQ/fEUD8vG
 54t12iL64+Eb5J/ryazPDPwNjDWVWZXxfJpU/eBPxEpVYg7jm9PHWHU4/nwVr2W+d1vV
 qnkYRFTS0K6uWYE2C4iW+qLwf3jwlqkIGN7lkW1+62DCY+7PZGe6p0d9+X/uVjW1xBjw
 vuew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvZtfTgO1Nf/LDfISlIeyonD8xQr2wfzowPAx8QHpPE6rPqgtwMvzUrGzxy/M2qgbupxZ8lHw7ad6j@nongnu.org
X-Gm-Message-State: AOJu0YypGQsClDL96ddfypg/Tnp5bURZ982mOdWp2wvQg7sHEKrM3QP+
 DyYEYKtJr5o7azsc/vB7Pkm8qKFEHqQp8h8AhhT8o3y/3PjzcImTrrEVQB3QTKHwvxbF4kJ9BpH
 iGdwBkdktnP2b2FFY2nGm0ZZSKw==
X-Google-Smtp-Source: AGHT+IEH2BncTD1qRBhSrAZjGx2pwSMNI4hF5i17htlyuiIaymrr7nBuRR4jK3Nsz+vIyVUZsqHc3AdTDgtkszpOvsM=
X-Received: from pjbsc8.prod.google.com ([2002:a17:90b:5108:b0:2ef:85ba:108f])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3e8e:b0:2ea:2a8d:dd2a with SMTP id
 98e67ed59e1d1-2f2900a98b4mr1055155a91.27.1734049581571; 
 Thu, 12 Dec 2024 16:26:21 -0800 (PST)
Date: Fri, 13 Dec 2024 00:26:02 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241213002602.4181289-1-nabihestefan@google.com>
Subject: [PATCH] tests/qtest/sse-timer-test: Add watchdog reset to sse-timer
 test
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, farosas@suse.de, 
 lvivier@redhat.com, pbonzini@redhat.com, roqueh@google.com, 
 venture@google.com, Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3LX9bZwwKCtoJ67EDAOPAB6JCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--nabihestefan.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Recent CDMSK Watchdog changes (eff9dc5660fad3a610171c56a5ec3fada245e519)
updated the CDMSK APB Watchdog to not free run out of reset. That led to
this test failing since it never triggers the watchdog to start running.
No watchdog running means that the timer and counter in the test cannot
start, leading to failures in the assert statements throughout the test.
Adding a reset and enable of the watchdog to the reset function solves
this problem by enabling the watchdog and thus letting the timer and
counter run as expected

Also renaming the reset_counter_and_timer function since it now also
affects the watchdog.

To reproduce the failure at HEAD:
./configure --target-list=arm-softmmu
make -j check-report-qtest-arm.junit.xml

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 scripts/meson-buildoptions.sh.tmp |  0
 tests/qtest/sse-timer-test.c      | 19 ++++++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)
 create mode 100644 scripts/meson-buildoptions.sh.tmp

diff --git a/scripts/meson-buildoptions.sh.tmp b/scripts/meson-buildoptions.sh.tmp
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qtest/sse-timer-test.c b/tests/qtest/sse-timer-test.c
index fd5635d4c9..d7a53ac23a 100644
--- a/tests/qtest/sse-timer-test.c
+++ b/tests/qtest/sse-timer-test.c
@@ -29,6 +29,13 @@
 /* Base of the System Counter control frame */
 #define COUNTER_BASE 0x58100000
 
+/* Base of the MSSDK APB Watchdog Device */
+#define WDOG_BASE 0x4802e000
+
+/* CMSDK Watchdog offsets */
+#define WDOGLOAD 0
+#define WDOGCONTROL 8
+
 /* SSE counter register offsets in the control frame */
 #define CNTCR 0
 #define CNTSR 0x4
@@ -63,24 +70,26 @@ static void clock_step_ticks(uint64_t ticks)
     clock_step(FOUR_TICKS * (ticks >> 2));
 }
 
-static void reset_counter_and_timer(void)
+static void reset_watchdog_counter_and_timer(void)
 {
     /*
-     * Reset the system counter and the timer between tests. This
+     * Reset the system watchdog, counter and the timer between tests. This
      * isn't a full reset, but it's sufficient for what the tests check.
      */
+    writel(WDOG_BASE + WDOGCONTROL, 0);
     writel(COUNTER_BASE + CNTCR, 0);
     writel(TIMER_BASE + CNTP_CTL, 0);
     writel(TIMER_BASE + CNTP_AIVAL_CTL, 0);
     writel(COUNTER_BASE + CNTCV_LO, 0);
     writel(COUNTER_BASE + CNTCV_HI, 0);
+    writel(WDOG_BASE + WDOGCONTROL, 1);
 }
 
 static void test_counter(void)
 {
     /* Basic counter functionality test */
 
-    reset_counter_and_timer();
+    reset_watchdog_counter_and_timer();
     /* The counter should start disabled: check that it doesn't move */
     clock_step_ticks(100);
     g_assert_cmpuint(readl(COUNTER_BASE + CNTCV_LO), ==, 0);
@@ -103,7 +112,7 @@ static void test_timer(void)
 {
     /* Basic timer functionality test */
 
-    reset_counter_and_timer();
+    reset_watchdog_counter_and_timer();
     /*
      * The timer is behind a Peripheral Protection Controller, and
      * qtest accesses are always non-secure (no memory attributes),
@@ -195,7 +204,7 @@ static void test_timer_scale_change(void)
      * Test that the timer responds correctly to counter
      * scaling changes while it has an active timer.
      */
-    reset_counter_and_timer();
+    reset_watchdog_counter_and_timer();
     /* Give ourselves access to the timer, and enable the counter and timer */
     writel(PERIPHNSPPC0, 1);
     writel(COUNTER_BASE + CNTCR, 1);
-- 
2.47.1.613.gc27f4b7a9f-goog


