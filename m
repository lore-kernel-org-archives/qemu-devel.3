Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D37DD64078
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 19:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9UNa-0000hW-7O; Fri, 08 Nov 2024 14:10:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3LmIuZwYKCusebdhRUTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--roqueh.bounces.google.com>)
 id 1t9UNW-0000gM-Km
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 14:10:42 -0500
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3LmIuZwYKCusebdhRUTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--roqueh.bounces.google.com>)
 id 1t9UNU-0002S4-9w
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 14:10:42 -0500
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6ea8a5e862eso30725007b3.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 11:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731093039; x=1731697839; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=+NV5//ThRna2CtY9uHfwaiardKdw5HuyQhs3lsyyceg=;
 b=r4Ime0udvllldiQcebZn14lYD8IJgNVOJ3ow0jedlttrNbEg2PBqxkpJCRHi9M75Rn
 FlUG4fTuDyGk/yde/7fU5JrD2uVYnCQTcDgStF9WO0cXkFUMHy+OVXehzVsCeJ8pgQRp
 TXfKaApQItXkpBnsHxlGEDcdF8UR84hZ23Dvdn9/Eq59FxhwyMoYXnHrxc5bVPPEv/NG
 Ai5xQRn/kh/lePXPHVh8n1FFxUJUlN9ktZZKAUEp41TeFKpZp6iFa0GfzZhPoTtm/hx6
 ACl/kdPc0uJ00jUZhO3u21kjcs5pHPXHr+hTUuzZ8zk0Hdfj1g7SfAa2mt2sZpMcw/+g
 TbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731093039; x=1731697839;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+NV5//ThRna2CtY9uHfwaiardKdw5HuyQhs3lsyyceg=;
 b=GgYiM2wD2Ew2neYAFygsQNFLQuPN9hqZnbe8v0QkgaEEozVLyOe7jE7RAd78cMhA0H
 1ybGlo8kCrDBqB42+ANVPi/cJJUw18PlpKAqh55Ma6QewHNIKU4LyXwH1gK+ZKQMNXTH
 xvCChnrz7ZJQXt0dRF753ZdfLWwmBciXJRWf9y7jh6RkiyvNIiFtTPE3lUxBAzDPOd6R
 vHAzJdxxo6JqbtZbVsDVb2YGqEqrVGoJZeEIX9qtRrQi+qSi+4PBnU2vJTt+b72Hea46
 fjc33XJzOjIkWKIPbiF/r2UNb4YDtKJtuf2Rk6Qo47XtZNdoEmP0KjM2lnO8rrL1vsbn
 eing==
X-Gm-Message-State: AOJu0YxngUYZH0Dv/T+8l3gvDbtjBKsBgPSWbQuum6dygLRmJk5q0Ch0
 vcyBaN4290Fnq80ZiA/Va7drp1qN1nrZK0lJkUAK8FnIoUxHAAQ0gApslr8lXVtbY5gT/Ih3+WH
 WGw==
X-Google-Smtp-Source: AGHT+IHVxHJZusILiT8LHB7qHHgJyuiE74ccPgdhqtfEoxQY3Nqw4Ua6PQqDeTH1Eu1MLZYshH+EclRU2po=
X-Received: from roqueh.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:1ab])
 (user=roqueh job=sendgmr) by 2002:a0d:ef05:0:b0:6ea:881b:b545 with
 SMTP id
 00721157ae682-6eade535166mr674767b3.4.1731093038762; Fri, 08 Nov 2024
 11:10:38 -0800 (PST)
Date: Fri,  8 Nov 2024 19:10:24 +0000
In-Reply-To: <20241108191024.2931097-1-roqueh@google.com>
Mime-Version: 1.0
References: <20241108191024.2931097-1-roqueh@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108191024.2931097-4-roqueh@google.com>
Subject: [PATCH 3/3] tests/qtest/cmsdk-apb-watchdog-test: Test INTEN as
 counter enable
From: Roque Arcudia Hernandez <roqueh@google.com>
To: peter.maydell@linaro.org, farosas@suse.de, lvivier@redhat.com, 
 slongfield@google.com, komlodi@google.com, pbonzini@redhat.com, 
 venture@google.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3LmIuZwYKCusebdhRUTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--roqueh.bounces.google.com;
 helo=mail-yw1-x1149.google.com
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

The following tests focus on making sure the counter is not running
out of reset and the proper use of INTEN as the counter enable. As
described in:

https://developer.arm.com/documentation/ddi0479/d/apb-components/apb-watchdog/programmers-model

The new tests have to target an MPS2 machine because the original
machine used by the test (stellaris) has a variation of the
cmsdk_apb_watchdog that locks INTEN when it is programmed to 1. The
stellaris machine also does not reproduce the problem of the counter
running out of cold reset due to the way the clocks are initialized.

Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
Reviewed-by: Stephen Longfield <slongfield@google.com>
---
 tests/qtest/cmsdk-apb-watchdog-test.c | 214 ++++++++++++++++++++++++++
 1 file changed, 214 insertions(+)

diff --git a/tests/qtest/cmsdk-apb-watchdog-test.c b/tests/qtest/cmsdk-apb-watchdog-test.c
index fe535a553c..3777b7bd59 100644
--- a/tests/qtest/cmsdk-apb-watchdog-test.c
+++ b/tests/qtest/cmsdk-apb-watchdog-test.c
@@ -68,6 +68,15 @@ static const CMSDKAPBWatchdogTestArgs machine_info[] = {
     },
 };
 
+static void system_reset(QTestState *qtest)
+{
+    QDict *resp;
+
+    resp = qtest_qmp(qtest, "{'execute': 'system_reset'}");
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+}
+
 static void test_watchdog(const void *ptr)
 {
     const CMSDKAPBWatchdogTestArgs *args = ptr;
@@ -159,6 +168,199 @@ static void test_clock_change(const void *ptr)
     qtest_end();
 }
 
+/* Tests the counter is not running after reset. */
+static void test_watchdog_reset(const void *ptr)
+{
+    const CMSDKAPBWatchdogTestArgs *args = ptr;
+    hwaddr wdog_base = args->wdog_base;
+    int64_t tick = args->tick;
+    g_autofree gchar *cmdline = g_strdup_printf("-machine %s", args->machine);
+    qtest_start(cmdline);
+    g_assert_cmpuint(readl(wdog_base + WDOGRIS), ==, 0);
+
+    g_assert_cmphex(readl(wdog_base + WDOGLOAD), ==, WDOGLOAD_DEFAULT);
+    g_assert_cmphex(readl(wdog_base + WDOGVALUE), ==, WDOGVALUE_DEFAULT);
+
+    g_assert_cmphex(readl(wdog_base + WDOGCONTROL), ==, 0);
+
+    /*
+     * The counter should not be running if WDOGCONTROL.INTEN has not been set,
+     * as it is the case after a cold reset.
+     */
+    clock_step(15 * tick + 1);
+    g_assert_cmphex(readl(wdog_base + WDOGLOAD), ==, WDOGLOAD_DEFAULT);
+    g_assert_cmphex(readl(wdog_base + WDOGVALUE), ==, WDOGVALUE_DEFAULT);
+
+    /* Let the counter run before reset */
+    writel(wdog_base + WDOGLOAD, 3000);
+    writel(wdog_base + WDOGCONTROL, 1);
+
+    /* Verify it is running */
+    clock_step(1000 * tick + 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 3000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 2000);
+
+    system_reset(global_qtest);
+
+    /* Check defaults after reset */
+    g_assert_cmphex(readl(wdog_base + WDOGLOAD), ==, WDOGLOAD_DEFAULT);
+    g_assert_cmphex(readl(wdog_base + WDOGVALUE), ==, WDOGVALUE_DEFAULT);
+
+    /* The counter should not be running after reset. */
+    clock_step(1000 * tick + 1);
+    g_assert_cmphex(readl(wdog_base + WDOGLOAD), ==, WDOGLOAD_DEFAULT);
+    g_assert_cmphex(readl(wdog_base + WDOGVALUE), ==, WDOGVALUE_DEFAULT);
+
+    qtest_end();
+}
+
+/*
+ * Tests inten works as the counter enable based on this description:
+ *
+ * Enable the interrupt event, WDOGINT. Set HIGH to enable the counter and the
+ * interrupt, or LOW to disable the counter and interrupt. Reloads the counter
+ * from the value in WDOGLOAD when the interrupt is enabled, after previously
+ * being disabled.
+ */
+static void test_watchdog_inten(const void *ptr)
+{
+    const CMSDKAPBWatchdogTestArgs *args = ptr;
+    hwaddr wdog_base = args->wdog_base;
+    int64_t tick = args->tick;
+    g_autofree gchar *cmdline = g_strdup_printf("-machine %s", args->machine);
+    qtest_start(cmdline);
+    g_assert_cmpuint(readl(wdog_base + WDOGRIS), ==, 0);
+
+    g_assert_cmphex(readl(wdog_base + WDOGLOAD), ==, WDOGLOAD_DEFAULT);
+    g_assert_cmphex(readl(wdog_base + WDOGVALUE), ==, WDOGVALUE_DEFAULT);
+
+    /*
+     * When WDOGLOAD is written to, the count is immediately restarted from the
+     * new value.
+     *
+     * Note: the counter should not be running as long as WDOGCONTROL.INTEN is
+     * not set
+     */
+    writel(wdog_base + WDOGLOAD, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 4000);
+    clock_step(500 * tick + 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 4000);
+
+    /* Set HIGH WDOGCONTROL.INTEN to enable the counter and the interrupt */
+    writel(wdog_base + WDOGCONTROL, 1);
+    clock_step(500 * tick + 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 3500);
+
+    /* or LOW to disable the counter and interrupt. */
+    writel(wdog_base + WDOGCONTROL, 0);
+    clock_step(100 * tick);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 3500);
+
+    /*
+     * Reloads the counter from the value in WDOGLOAD when the interrupt is
+     * enabled, after previously being disabled.
+     */
+    writel(wdog_base + WDOGCONTROL, 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 4000);
+
+    /* Test counter is still on */
+    clock_step(50 * tick + 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 3950);
+
+    /*
+     * When WDOGLOAD is written to, the count is immediately restarted from the
+     * new value.
+     *
+     * Note: the counter should be running since WDOGCONTROL.INTEN is set
+     */
+    writel(wdog_base + WDOGLOAD, 5000);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 5000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 5000);
+    clock_step(4999 * tick + 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 5000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGRIS), ==, 0);
+
+    /* Finally disable and check the conditions don't change */
+    writel(wdog_base + WDOGCONTROL, 0);
+    clock_step(10 * tick);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 5000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGRIS), ==, 0);
+
+    qtest_end();
+}
+
+/*
+ * Tests the following custom behavior:
+ *
+ * The Luminary version of this device ignores writes to this register after the
+ * guest has enabled interrupts (so they can only be disabled again via reset).
+ */
+static void test_watchdog_inten_luminary(const void *ptr)
+{
+    const CMSDKAPBWatchdogTestArgs *args = ptr;
+    hwaddr wdog_base = args->wdog_base;
+    int64_t tick = args->tick;
+    g_autofree gchar *cmdline = g_strdup_printf("-machine %s", args->machine);
+    qtest_start(cmdline);
+    g_assert_cmpuint(readl(wdog_base + WDOGRIS), ==, 0);
+
+    g_assert_cmphex(readl(wdog_base + WDOGLOAD), ==, WDOGLOAD_DEFAULT);
+    g_assert_cmphex(readl(wdog_base + WDOGVALUE), ==, WDOGVALUE_DEFAULT);
+
+    /*
+     * When WDOGLOAD is written to, the count is immediately restarted from the
+     * new value.
+     *
+     * Note: the counter should not be running as long as WDOGCONTROL.INTEN is
+     * not set
+     */
+    writel(wdog_base + WDOGLOAD, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 4000);
+    clock_step(500 * tick + 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 4000);
+
+    /* Set HIGH WDOGCONTROL.INTEN to enable the counter and the interrupt */
+    writel(wdog_base + WDOGCONTROL, 1);
+    clock_step(500 * tick + 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 3500);
+
+    /*
+     * The Luminary version of this device ignores writes to this register after
+     * the guest has enabled interrupts
+     */
+    writel(wdog_base + WDOGCONTROL, 0);
+    clock_step(100 * tick);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 3400);
+    g_assert_cmphex(readl(wdog_base + WDOGCONTROL), ==, 0x1);
+
+    /* They can only be disabled again via reset */
+    system_reset(global_qtest);
+
+    /* Check defaults after reset */
+    g_assert_cmphex(readl(wdog_base + WDOGLOAD), ==, WDOGLOAD_DEFAULT);
+    g_assert_cmphex(readl(wdog_base + WDOGVALUE), ==, WDOGVALUE_DEFAULT);
+    g_assert_cmphex(readl(wdog_base + WDOGCONTROL), ==, 0);
+
+    /* The counter should not be running after reset. */
+    clock_step(1000 * tick + 1);
+    g_assert_cmphex(readl(wdog_base + WDOGLOAD), ==, WDOGLOAD_DEFAULT);
+    g_assert_cmphex(readl(wdog_base + WDOGVALUE), ==, WDOGVALUE_DEFAULT);
+
+    qtest_end();
+}
+
 int main(int argc, char **argv)
 {
     int r;
@@ -172,10 +374,22 @@ int main(int argc, char **argv)
         qtest_add_data_func("/cmsdk-apb-watchdog/watchdog_clock_change",
                             &machine_info[MACHINE_LM3S811EVB],
                             test_clock_change);
+        qtest_add_data_func("/cmsdk-apb-watchdog/watchdog_reset",
+                            &machine_info[MACHINE_LM3S811EVB],
+                            test_watchdog_reset);
+        qtest_add_data_func("/cmsdk-apb-watchdog/watchdog_inten_luminary",
+                            &machine_info[MACHINE_LM3S811EVB],
+                            test_watchdog_inten_luminary);
     }
     if (qtest_has_machine(machine_info[MACHINE_MPS2_AN385].machine)) {
         qtest_add_data_func("/cmsdk-apb-watchdog/watchdog_mps2",
                             &machine_info[MACHINE_MPS2_AN385], test_watchdog);
+        qtest_add_data_func("/cmsdk-apb-watchdog/watchdog_reset_mps2",
+                            &machine_info[MACHINE_MPS2_AN385],
+                            test_watchdog_reset);
+        qtest_add_data_func("/cmsdk-apb-watchdog/watchdog_inten",
+                            &machine_info[MACHINE_MPS2_AN385],
+                            test_watchdog_inten);
     }
 
     r = g_test_run();
-- 
2.47.0.277.g8800431eea-goog


