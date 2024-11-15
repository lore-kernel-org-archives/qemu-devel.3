Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2C1D68BC8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tByna-0004CV-Am; Fri, 15 Nov 2024 11:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <34HA3ZwYKCt8SPRVFIHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--roqueh.bounces.google.com>)
 id 1tBynV-0004B4-Pp
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:03:49 -0500
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <34HA3ZwYKCt8SPRVFIHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--roqueh.bounces.google.com>)
 id 1tBynT-00042g-Ol
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:03:49 -0500
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6ee433bd48dso32867447b3.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731686625; x=1732291425; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=xdTDE/ogJexYXwONpxsosZC8K7XuyEiJo0szMh6XTpA=;
 b=PCUf8yTghT9mySCsEhWv+S4qAJSGNLCmDYT5EjCANN5iiB9sd59pZf97Z821+WTPml
 0KAdi9HXt9nwIMV1h2erMdw0eIVmkaTwyJONSHwwm8UauXGBPsd0HrrBLfSstrHneu9q
 fc5pDLOykAddlj74FQWEvPp+8gwLgow20rSgbGjYXBxployK3G4Y3hfAsdkZJIvZu354
 dlrWuU9SWLdobi2enOM8Z3SrNMYL+ZsGRssFDQlqWB2i8149ANk/hkoH620kdYiXKFcq
 kjDGhvobIscbzxEaa8ccTOi2meLQqkOA3fyV6V8LCMO1GHVOGjzKpOmRZiPW0C89F2nO
 ctcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731686625; x=1732291425;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xdTDE/ogJexYXwONpxsosZC8K7XuyEiJo0szMh6XTpA=;
 b=qdj3nf4h86hrh8mHu0qP5We0lMPo+QBXycfeTYFyLBQ1ZvRu6cpwJaDh9TprEHvmn3
 smrDBQVLTQ8YYVzygwxjrnvi95v6GXzaGrXMRajlkO0wi4ubCoJt+9bvqEYeeRn8dQ2t
 EyH7TZBgeUIvXimgaPv/jX9UJ2qlxbQyE+DlP5sJCka68mDXrxzXp8vLDNhTxvHVErD/
 EVMjoLCsPFiW60t1tzTSvpNQbzlHFEPIqA8XKTOOW72gVIc225lHKy+4qKW+QVeQSrI+
 miZEHxaE1uxpB9AtjrcOdvqOdYPocfZc0M7Is4hYZxX1m/SY1/nJpKXkwHuSoagl6CE2
 9sbg==
X-Gm-Message-State: AOJu0Yw4ok474nHgbZ1tvXe51OG/rfeObHlwqtNxyBxjvHcuFIjGLew+
 6hXVFCmKv6oVbHW0WXzpCqZOwJu7p8kbGyQ1WEN6nXgcziu9NJUbXweW4zDX7E1i3mkuF173bCM
 rNA==
X-Google-Smtp-Source: AGHT+IEdX55NPz+ERTCDs/jlDiGv8mgKd5FFrG0QKvViXjvac96+k673yjxxXEJUV+jTXZ8WkTY6JJxtuPA=
X-Received: from roqueh.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:1ab])
 (user=roqueh job=sendgmr) by 2002:a05:690c:6893:b0:6ee:4d97:9091
 with SMTP id
 00721157ae682-6ee55f02ed8mr2691707b3.7.1731686624774; Fri, 15 Nov 2024
 08:03:44 -0800 (PST)
Date: Fri, 15 Nov 2024 16:03:26 +0000
In-Reply-To: <20241115160328.1650269-1-roqueh@google.com>
Mime-Version: 1.0
References: <20241115160328.1650269-1-roqueh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115160328.1650269-4-roqueh@google.com>
Subject: [PATCH 3/5] tests/qtest/cmsdk-apb-watchdog-test: Parameterize tests
From: Roque Arcudia Hernandez <roqueh@google.com>
To: peter.maydell@linaro.org, farosas@suse.de, lvivier@redhat.com, 
 slongfield@google.com, komlodi@google.com, pbonzini@redhat.com, 
 venture@google.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=34HA3ZwYKCt8SPRVFIHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--roqueh.bounces.google.com;
 helo=mail-yw1-x1149.google.com
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
 tests/qtest/cmsdk-apb-watchdog-test.c | 112 +++++++++++++++++++-------
 tests/qtest/meson.build               |   3 +-
 2 files changed, 84 insertions(+), 31 deletions(-)

diff --git a/tests/qtest/cmsdk-apb-watchdog-test.c b/tests/qtest/cmsdk-apb-watchdog-test.c
index 00b5dbbc81..bdf6cfa256 100644
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
@@ -117,15 +165,19 @@ int main(int argc, char **argv)
 
     g_test_init(&argc, &argv, NULL);
 
-    qtest_start("-machine lm3s811evb");
-
-    qtest_add_func("/cmsdk-apb-watchdog/watchdog", test_watchdog);
-    qtest_add_func("/cmsdk-apb-watchdog/watchdog_clock_change",
-                   test_clock_change);
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
2.47.0.338.g60cca15819-goog


