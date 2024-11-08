Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F17D64079
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 19:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9UNV-0000fh-IC; Fri, 08 Nov 2024 14:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3KmIuZwYKCucaXZdNQPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--roqueh.bounces.google.com>)
 id 1t9UNS-0000eQ-I4
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 14:10:39 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3KmIuZwYKCucaXZdNQPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--roqueh.bounces.google.com>)
 id 1t9UNQ-0002RP-Mh
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 14:10:38 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6e6101877abso51134607b3.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 11:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731093034; x=1731697834; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Es1ZOsUkh5a26ERSNoZBbj4rwDM4JoIl2SBvc0JCEas=;
 b=SL8VL1rPsnySYc+BrSa6kfK/xEcK30VHYeZtxPDVjzf7T1HtHNJjRl1m6IbPrEOpCx
 8LuGNnWnJAeH0EcMXhvQltjr/x5Q6DkIFsnJKWcf0ZYwBRgQKWrbntzQLJiTpvlNtBut
 cLyj5N17+gOLbjjMPXbkbNy9hfa1JPN3x4lH0BgEFZeOdcpcqgBhvwwQSbW17VMDU1Gj
 TiVJve33Vyd/KpjAXJkOT4vhpvTJmKXvEgOEz7Cozsj3+FrdzN1qAio5JOkwzCaLEReg
 vKOAeEvcW3J/bu+VtugzAZR6ltsZiwcnOgLsOq+8wBb8I9UPWXw7MbrsMeBqJ05hd+zd
 AxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731093034; x=1731697834;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Es1ZOsUkh5a26ERSNoZBbj4rwDM4JoIl2SBvc0JCEas=;
 b=HXegU2a8zpLJmeIRMqRvqKyfhKhqmNegIr043MLybEOCdt2+TbmsLXKV9AcecrIvUI
 8xncR3agdOolcKzfHsV7hd0gHx13evDKel4IQU9nV7JauXO+9+RSkM7uCghoAvpXOxC3
 DpjhvpP+RFerYIEwy8J/Hm12ghpn4vOkI3Ao7HzflIC3uYjrOaDQ4U+gomVCLSaFkPPx
 anR3KMpWtEnlbMDZ3+1XF8XPqnsYKz1dMCwF52quWHTpHCs+wyhKOrnrWMC3laHw1q21
 eAXK2zMvu4T/re0UTX3LKjr7H+S98O7nS7fyVgntrDU0CzUkl/BKdPWUzGXeBAvb1pN2
 o02g==
X-Gm-Message-State: AOJu0YwW/Gd8TtcN8wjdOBxbQuMQpAje2jsP1HffhdsWWSD3ZwKDArUz
 zBUUBWRpMq2Fa28XTxA0i1HpZ4ewIzexafRWM59/wistc8ZcJguLTwsS54P0CdyGCFFK73KIwDF
 aDA==
X-Google-Smtp-Source: AGHT+IHD3ocmcpzkEtnkFfHCUDQqyerrA/YIhYIFeaB+GSvnPc9m3MOM8UYNW1tqHpZZXCo+E/Zsfs8m67E=
X-Received: from roqueh.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:1ab])
 (user=roqueh job=sendgmr) by 2002:a0d:f4c3:0:b0:6e3:ce76:103f with
 SMTP id
 00721157ae682-6eaddfb8e66mr496267b3.6.1731093034670; Fri, 08 Nov 2024
 11:10:34 -0800 (PST)
Date: Fri,  8 Nov 2024 19:10:23 +0000
In-Reply-To: <20241108191024.2931097-1-roqueh@google.com>
Mime-Version: 1.0
References: <20241108191024.2931097-1-roqueh@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108191024.2931097-3-roqueh@google.com>
Subject: [PATCH 2/3] tests/qtest/cmsdk-apb-watchdog-test: Parameterize tests
From: Roque Arcudia Hernandez <roqueh@google.com>
To: peter.maydell@linaro.org, farosas@suse.de, lvivier@redhat.com, 
 slongfield@google.com, komlodi@google.com, pbonzini@redhat.com, 
 venture@google.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3KmIuZwYKCucaXZdNQPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--roqueh.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Currently the CMSDK APB watchdog tests target an specialized version
of the device (luminaris using the lm3s811evb machine) that prevents
the development of tests for the more generic device documented in:

https://developer.arm.com/documentation/ddi0479/d/apb-components/apb-watchdog/programmers-model

This patch allows the execution of the watchdog tests in an MPS2
machine (when applicable) which uses the generic version of the CMSDK
APB watchdog.

Finally the rules for compiling the test have to change because it is
possible not to have CONFIG_STELLARIS (required for the lm3s811evb
machine) while still having CONFIG_CMSDK_APB_WATCHDOG and the test
will fail. Due to the addition of the MPS2 machine CONFIG_MPS2
becomes also a dependency for the test compilation.

Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
Reviewed-by: Stephen Longfield <slongfield@google.com>
---
 tests/qtest/cmsdk-apb-watchdog-test.c | 115 +++++++++++++++++++-------
 tests/qtest/meson.build               |   3 +-
 2 files changed, 86 insertions(+), 32 deletions(-)

diff --git a/tests/qtest/cmsdk-apb-watchdog-test.c b/tests/qtest/cmsdk-apb-watchdog-test.c
index 00b5dbbc81..fe535a553c 100644
--- a/tests/qtest/cmsdk-apb-watchdog-test.c
+++ b/tests/qtest/cmsdk-apb-watchdog-test.c
@@ -15,14 +15,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/hwaddr.h"
 #include "qemu/bitops.h"
 #include "libqtest-single.h"
 
-/*
- * lm3s811evb watchdog; at board startup this runs at 200MHz / 16 == 12.5MHz,
- * which is 80ns per tick.
- */
 #define WDOG_BASE 0x40000000
+#define WDOG_BASE_MPS2 0x40008000
 
 #define WDOGLOAD 0
 #define WDOGVALUE 4
@@ -37,39 +35,87 @@
 #define SYSDIV_SHIFT 23
 #define SYSDIV_LENGTH 4
 
-static void test_watchdog(void)
+#define WDOGLOAD_DEFAULT 0xFFFFFFFF
+#define WDOGVALUE_DEFAULT 0xFFFFFFFF
+
+typedef struct CMSDKAPBWatchdogTestArgs {
+    int64_t tick;
+    hwaddr wdog_base;
+    const char *machine;
+} CMSDKAPBWatchdogTestArgs;
+
+enum {
+    MACHINE_LM3S811EVB,
+    MACHINE_MPS2_AN385,
+};
+
+/*
+ * lm3s811evb watchdog; at board startup this runs at 200MHz / 16 == 12.5MHz,
+ * which is 80ns per tick.
+ *
+ * IoTKit/ARMSSE dualtimer; driven at 25MHz in mps2-an385, so 40ns per tick
+ */
+static const CMSDKAPBWatchdogTestArgs machine_info[] = {
+    [MACHINE_LM3S811EVB] = {
+        .tick = 80,
+        .wdog_base = WDOG_BASE,
+        .machine = "lm3s811evb",
+    },
+    [MACHINE_MPS2_AN385] = {
+        .tick = 40,
+        .wdog_base = WDOG_BASE_MPS2,
+        .machine = "mps2-an385",
+    },
+};
+
+static void test_watchdog(const void *ptr)
 {
-    g_assert_cmpuint(readl(WDOG_BASE + WDOGRIS), ==, 0);
+    const CMSDKAPBWatchdogTestArgs *args = ptr;
+    hwaddr wdog_base = args->wdog_base;
+    int64_t tick = args->tick;
+    g_autofree gchar *cmdline = g_strdup_printf("-machine %s", args->machine);
+    qtest_start(cmdline);
 
-    writel(WDOG_BASE + WDOGCONTROL, 1);
-    writel(WDOG_BASE + WDOGLOAD, 1000);
+    g_assert_cmpuint(readl(wdog_base + WDOGRIS), ==, 0);
+
+    writel(wdog_base + WDOGCONTROL, 1);
+    writel(wdog_base + WDOGLOAD, 1000);
 
     /* Step to just past the 500th tick */
-    clock_step(500 * 80 + 1);
-    g_assert_cmpuint(readl(WDOG_BASE + WDOGRIS), ==, 0);
-    g_assert_cmpuint(readl(WDOG_BASE + WDOGVALUE), ==, 500);
+    clock_step(500 * tick + 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGRIS), ==, 0);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 500);
 
     /* Just past the 1000th tick: timer should have fired */
-    clock_step(500 * 80);
-    g_assert_cmpuint(readl(WDOG_BASE + WDOGRIS), ==, 1);
-    g_assert_cmpuint(readl(WDOG_BASE + WDOGVALUE), ==, 0);
+    clock_step(500 * tick);
+    g_assert_cmpuint(readl(wdog_base + WDOGRIS), ==, 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 0);
 
     /* VALUE reloads at following tick */
-    clock_step(80);
-    g_assert_cmpuint(readl(WDOG_BASE + WDOGVALUE), ==, 1000);
+    clock_step(tick);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 1000);
 
     /* Writing any value to WDOGINTCLR clears the interrupt and reloads */
-    clock_step(500 * 80);
-    g_assert_cmpuint(readl(WDOG_BASE + WDOGVALUE), ==, 500);
-    g_assert_cmpuint(readl(WDOG_BASE + WDOGRIS), ==, 1);
-    writel(WDOG_BASE + WDOGINTCLR, 0);
-    g_assert_cmpuint(readl(WDOG_BASE + WDOGVALUE), ==, 1000);
-    g_assert_cmpuint(readl(WDOG_BASE + WDOGRIS), ==, 0);
+    clock_step(500 * tick);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 500);
+    g_assert_cmpuint(readl(wdog_base + WDOGRIS), ==, 1);
+    writel(wdog_base + WDOGINTCLR, 0);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 1000);
+    g_assert_cmpuint(readl(wdog_base + WDOGRIS), ==, 0);
+
+    qtest_end();
 }
 
-static void test_clock_change(void)
+/*
+ * This test can only be executed in the stellaris board since it relies on a
+ * component of the board to change the clocking parameters of the watchdog.
+ */
+static void test_clock_change(const void *ptr)
 {
     uint32_t rcc;
+    const CMSDKAPBWatchdogTestArgs *args = ptr;
+    g_autofree gchar *cmdline = g_strdup_printf("-machine %s", args->machine);
+    qtest_start(cmdline);
 
     /*
      * Test that writing to the stellaris board's RCC register to
@@ -109,6 +155,8 @@ static void test_clock_change(void)
     writel(WDOG_BASE + WDOGINTCLR, 0);
     g_assert_cmpuint(readl(WDOG_BASE + WDOGVALUE), ==, 1000);
     g_assert_cmpuint(readl(WDOG_BASE + WDOGRIS), ==, 0);
+
+    qtest_end();
 }
 
 int main(int argc, char **argv)
@@ -116,16 +164,21 @@ int main(int argc, char **argv)
     int r;
 
     g_test_init(&argc, &argv, NULL);
-
-    qtest_start("-machine lm3s811evb");
-
-    qtest_add_func("/cmsdk-apb-watchdog/watchdog", test_watchdog);
-    qtest_add_func("/cmsdk-apb-watchdog/watchdog_clock_change",
-                   test_clock_change);
+    g_test_set_nonfatal_assertions();
+
+    if (qtest_has_machine(machine_info[MACHINE_LM3S811EVB].machine)) {
+        qtest_add_data_func("/cmsdk-apb-watchdog/watchdog",
+                            &machine_info[MACHINE_LM3S811EVB], test_watchdog);
+        qtest_add_data_func("/cmsdk-apb-watchdog/watchdog_clock_change",
+                            &machine_info[MACHINE_LM3S811EVB],
+                            test_clock_change);
+    }
+    if (qtest_has_machine(machine_info[MACHINE_MPS2_AN385].machine)) {
+        qtest_add_data_func("/cmsdk-apb-watchdog/watchdog_mps2",
+                            &machine_info[MACHINE_MPS2_AN385], test_watchdog);
+    }
 
     r = g_test_run();
 
-    qtest_end();
-
     return r;
 }
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index aa93e98418..f2f35367ae 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -227,7 +227,8 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cmsdk-apb-timer-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_CMSDK_APB_WATCHDOG') ? ['cmsdk-apb-watchdog-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_STELLARIS') or
+   config_all_devices.has_key('CONFIG_MPS2') ? ['cmsdk-apb-watchdog-test'] : []) + \
   (config_all_devices.has_key('CONFIG_PFLASH_CFI02') and
    config_all_devices.has_key('CONFIG_MUSICPAL') ? ['pflash-cfi02-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed : []) + \
-- 
2.47.0.277.g8800431eea-goog


