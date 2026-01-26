Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621ACD1950F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQd6-0001bL-70; Mon, 26 Jan 2026 12:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcv-0001Sv-Mp
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:50 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcu-0000BM-4N
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:49 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so36332915e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449426; x=1770054226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0HThoZ4BzoXW1z+LSYKEUiv5+qqmWVhCSi3lu7EloCo=;
 b=ciG/geELFPSVC+YhrtsHNCbdcFw4XKBqBd1hGHw67vYpo7RbbubdB+GdOU0FKTP0RL
 8c0bnApAq+65K9iv+pVW6PY3xvikk5RJQeGl/T8tqxkygzQrSgufFgfxrg8qiOw9k9tK
 G5wqUK1TSy5v1kM673oeEPq5fvewCL7YlnB1VZGxLhp6Fi1+ro1Xio0sMEilYoeTFe2g
 egV0Kt5cvMyGSGjTTl01yYUjuzRT0HTskAyeNNgXKSF9ogVGT353DcGLiNmMYpT69qlK
 jbCt9dAR/O5ljNR+i1QayEPzXvF+5QpLdkBc4d2bSDBASbY/9d0gMkgvftUvIJQmkG0x
 UhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449426; x=1770054226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0HThoZ4BzoXW1z+LSYKEUiv5+qqmWVhCSi3lu7EloCo=;
 b=W96G8YZF/vAJjqq5DoWdHklpyGzww5Urlk/QapuWAuYBd7VOATeSBcPsfczL+hU/wz
 WC6imWp8t4Ee6ltcQptazYgdxOtW1n/ksVh3yoKHMwzG1KlYe3xFO2G+wdY5gwcMNV13
 bbABoM0mYS1xjT+X8JqSDBqeIwPIZdUqV0tUrKwjUU558ta++BPmS3t9lUxz5tz6ZRaH
 A1+fI4bCgqQasGO7ecmpXyULJpzLhOnAh3hHGRIyLqiNchqibftn6WzaxrDG++UTuy2i
 xpN4mJg9HnLl1fWulu2/DFlKTUegA1a5OgSEmIPOASx8iMHMgaupLc12LhMyQuE7RH/S
 DjFQ==
X-Gm-Message-State: AOJu0Yw76I8sJIblOb864495oa7Pbrons3a/8/XLc5U5cbzFqV0nVw/O
 I9ktiarxierjBYJc3HKdutEKpn01JsFUmCCCd80AjMxwD3BdDCO+EahUNIWVcZZQ
X-Gm-Gg: AZuq6aKmrEUt0hUT7iWXOP/c+2cDTeP6eihC0aaNtr56ADweUCg/0eiCfqOlRyQJOhU
 cY/THohyKH9aq4/ymgyv7PUrLYLQXyuSeIkPANTQXLSHv8lcL4lsFVLUIe7PCUQoHFhboCN2Wct
 jh0368cEi7sv/kaT9iuwTCur6TAoyDFtPzSiUpEt+UOWdU93pyVDWQJ2Nsxy1LcPBX883XfBoz0
 c9RBBTvpo2GJMDQ3bsuX3VxTzfUnTX8HDF2Q4qQ9tVfa8fEtZXH0sd2lxOVzIMZHyP0Gq1TTm28
 hhEJgFQeWKk3EPTXWln/eOvi7gy2qctW9QklU7qWBGCGhP92Y55QYo8zkXr9tkQw8hbfVQD7cTa
 YLPEyOIEpEoEDJ1HDjYfM1BbyLIzVNhKsFVj5CTdMfEQ/6g6nBFwPF0qPxidx4c7ZIHOG3V3EE6
 p898o6sNZG9VtHiHIH8ad7Iippyyhsxnl8VxPX+ocYZwzCph9qtVg6jQ==
X-Received: by 2002:a05:600c:3b93:b0:477:af8d:203a with SMTP id
 5b1f17b1804b1-4805d064549mr82656675e9.27.1769449426465; 
 Mon, 26 Jan 2026 09:43:46 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:46 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com
Subject: [PATCH 22/27] target/arm/cpu: add fdt support for armv8-timer
Date: Mon, 26 Jan 2026 18:43:08 +0100
Message-ID: <20260126174313.1418150-23-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Implement FDT compatibility, so that timer can initilize
and wire irqs based on device tree information.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 target/arm/cpu.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6e1cbf3d61..96696ed4f1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -53,6 +53,8 @@
 #include "target/arm/gtimer.h"
 
 #include "trace.h"
+#include "hw/core/fdt_generic_util.h"
+
 
 static void arm_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -2446,3 +2448,116 @@ static void arm_cpu_register_types(void)
 }
 
 type_init(arm_cpu_register_types)
+
+#ifndef CONFIG_USER_ONLY
+
+static Object *fdt_armv8_timer_get_intc(FDTMachineInfo *fdti, char *node_path)
+{
+    char intc_node_path[DT_PATH_LENGTH];
+    uint32_t intc_phandle;
+    Error *errp = NULL;
+    DeviceState *intc;
+
+    intc_phandle = qemu_fdt_getprop_cell(fdti->fdt, node_path,
+                                         "interrupt-parent",
+                                         0, true, &errp);
+
+    /* There must be an interrupt-parent */
+    if (errp ||
+        qemu_devtree_get_node_by_phandle(fdti->fdt,
+                                         intc_node_path, intc_phandle)) {
+        g_assert_not_reached();
+    }
+
+    while (!fdt_init_has_opaque(fdti, intc_node_path)) {
+        fdt_init_yield(fdti);
+    }
+
+    intc = DEVICE(fdt_init_get_opaque(fdti, intc_node_path));
+
+    while (!intc->realized) {
+        fdt_init_yield(fdti);
+    }
+
+    return OBJECT(intc);
+}
+
+static int armv8_timer_fdt_init(char *node_path, FDTMachineInfo *fdti,
+                                void *priv)
+{
+    Object *intc = fdt_armv8_timer_get_intc(fdti, node_path);
+    CPUState *cpu;
+    bool map_mode = false;
+    qemu_irq *sec_irqs = NULL;
+    qemu_irq *ns_irqs;
+    qemu_irq *v_irqs;
+    qemu_irq *h_irqs;
+    uint32_t first_cpu_idx;
+    uint32_t num_cpu;
+    bool has_sec_ext;
+    Error *err = NULL;
+
+    first_cpu_idx = object_property_get_uint(intc, "first-cpu-idx", &err);
+    if (!err) {
+        num_cpu = object_property_get_uint(intc, "num-cpu", &err);
+        assert(!err);
+        has_sec_ext = object_property_get_bool(intc, "has-security-extensions",
+                                               &err);
+        assert(!err);
+    } else {
+        /*
+         * Connect all CPUs with the ARM_FEATURE_GENERIC_TIMER set for
+         * backwards compatibility when the 'first-cpu-idx' property does not
+         * exist.
+         */
+        num_cpu = 0;
+        has_sec_ext = true;
+    }
+
+    if (has_sec_ext) {
+        sec_irqs = fdt_get_irq(fdti, node_path, 0, &map_mode);
+        ns_irqs = fdt_get_irq(fdti, node_path, 1, &map_mode);
+        v_irqs = fdt_get_irq(fdti, node_path, 2, &map_mode);
+        h_irqs = fdt_get_irq(fdti, node_path, 3, &map_mode);
+    } else {
+        ns_irqs = fdt_get_irq(fdti, node_path, 0, &map_mode);
+        v_irqs = fdt_get_irq(fdti, node_path, 1, &map_mode);
+        h_irqs = fdt_get_irq(fdti, node_path, 2, &map_mode);
+    }
+
+    assert(!map_mode); /* not supported for PPI */
+
+    for (cpu = first_cpu; cpu; cpu = CPU_NEXT(cpu)) {
+        ARMCPU *acpu = ARM_CPU(cpu);
+        bool is_gic_cpu;
+
+        if (!arm_feature(&acpu->env, ARM_FEATURE_GENERIC_TIMER)) {
+            continue;
+        }
+
+        is_gic_cpu = cpu->cpu_index >= first_cpu_idx &&
+                     cpu->cpu_index < (first_cpu_idx + num_cpu);
+
+        if (!num_cpu || is_gic_cpu) {
+
+            assert(*ns_irqs);
+            assert(*v_irqs);
+            assert(*h_irqs);
+            qdev_connect_gpio_out(DEVICE(acpu), 0, *ns_irqs++);
+            qdev_connect_gpio_out(DEVICE(acpu), 1, *v_irqs++);
+            qdev_connect_gpio_out(DEVICE(acpu), 2, *h_irqs++);
+
+            if (has_sec_ext) {
+                assert(*sec_irqs);
+                qdev_connect_gpio_out(DEVICE(acpu), 3, *sec_irqs++);
+            }
+        }
+    }
+
+    return 0;
+}
+
+fdt_register_compatibility(armv8_timer_fdt_init,
+                           "compatible:arm,armv8-timer");
+
+#endif
-- 
2.43.0


