Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A92EE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 22:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMEKk-0003ie-Dt; Fri, 13 Dec 2024 17:40:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <32LdcZwwKCvsqdelkhvwhidqjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--nabihestefan.bounces.google.com>)
 id 1tMEKi-0003iC-CA
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 17:40:28 -0500
Received: from mail-oa1-x49.google.com ([2001:4860:4864:20::49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <32LdcZwwKCvsqdelkhvwhidqjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--nabihestefan.bounces.google.com>)
 id 1tMEKg-0006he-MI
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 17:40:28 -0500
Received: by mail-oa1-x49.google.com with SMTP id
 586e51a60fabf-29fb4d3c3f3so1871721fac.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 14:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1734129624; x=1734734424; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Y5tnX/+CjFCQneIvFaXnx9LjKWIK0Im3pRzlQnaPJs4=;
 b=wD/QNp+SaO+QsGD3OSuqQ9rMQNEH979MNAKZdSO3gkhCmIEj6fahBkAEajVp5EJ/y8
 YjnQ3X4dLaRsmITbQDMiMXBENTrFdqqP9/KLlKf9Kz8XBhNtW6DEIxAOzctBEhmHn4do
 YFFR4VnfaRdv5pyCSV8zAQRS7GREgoyvXWP4w7XIK4PR3lOblRFueFQ7m9uQKEK0p4In
 MrBwcrjam4skkp1AMhdjuj6sdRNZbSFs3hj43vkYHv0ed3KvVcFxlow5XObnKXuvsil1
 OTpuRCvwpTm2VP6tuRvPvz5/hIvs0aswk/26uqtooH/wjC5jzRRxsftMYmkWxAUVy8xA
 CCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734129624; x=1734734424;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y5tnX/+CjFCQneIvFaXnx9LjKWIK0Im3pRzlQnaPJs4=;
 b=wDWTcT9ymaBg9gE/gYpQX6YYBZBx/9x34ymbBHtIEGlqx3JMNOMtQ1/+lk33+Zc7pi
 7qnvTnU7tqL3tlwBjdR25vU84ejOlgjC3VGkFHh7+HMuvXtmRoutVYXI/g7HXBGrFdvN
 3N19BUl1wqYOKLMs90Op/D6Hnb8liolfuCeGoe9l56Ihiah4J9dKDLo+VtJJQ+uONwT6
 PMyu5tqEa2eP0Pa9B1tw1tjywLncSA4r16O5ocTWxMbo7VORCn3J6xalVALht9omy2/6
 09Jr4EhNw1ixt7FsINWJIIrfIIegc4n6HH/rJIabSXmIdLPNc5xjazOCIyq5UMKxzvZm
 gMsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWuL235/nG3suEoKATwuDVwsoM/+i9RLf3Li80BzR9EESKpJZq3F6vaHOEFx5q/MhlXjOgL/lTbH8S@nongnu.org
X-Gm-Message-State: AOJu0Ywu0KhSUBVqp3qU8qzg/j3oQiZ+XFjLA80aDQneFx9ue0NWbkiu
 VR0BxxGzECWDSbVE5KhtzjtXc89EvwiDPzoJqkEP2iTAN95lgfXerA+6/JhLAhRIpaenVbG7x4B
 yB0DWNuFhScDqtuE/r9hKUafbOA==
X-Google-Smtp-Source: AGHT+IFBIUHKvDkW7LU0hb6ZxX00ZUD7KVYc5jLvZ6CkJHGICHByFFMTmyCalOePjhGhENec1fALYSN3Ad4VbJqweT0=
X-Received: from oabrl15.prod.google.com
 ([2002:a05:6871:650f:b0:289:3039:6009])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:8450:b0:29e:18cc:276f with SMTP id
 586e51a60fabf-2a3ac6f2c10mr1995517fac.11.1734129624146; 
 Fri, 13 Dec 2024 14:40:24 -0800 (PST)
Date: Fri, 13 Dec 2024 22:40:20 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241213224020.2982578-1-nabihestefan@google.com>
Subject: [PATCH v2] tests/qtest/sse-timer-test: Add watchdog reset to
 sse-timer test
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, farosas@suse.de, 
 lvivier@redhat.com, pbonzini@redhat.com, roqueh@google.com, 
 Nabih Estefan <nabihestefan@google.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::49;
 envelope-from=32LdcZwwKCvsqdelkhvwhidqjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--nabihestefan.bounces.google.com;
 helo=mail-oa1-x49.google.com
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

V2: Removed scripts/meson-buildoptions.sh.tmp Extra file that slipped
through the cracks and shouldn't be in this patch

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
Tested-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/sse-timer-test.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

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


