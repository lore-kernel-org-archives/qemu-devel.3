Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0D9CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11m-0004Xt-Rh; Thu, 07 May 2026 11:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11k-0004Nw-M6
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:40 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11i-0003y5-8b
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:40 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso9857585e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169157; x=1778773957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eJtMnPBYtkfA68rC6IgUqGua6khlh7OyNCqY+9Ynqxs=;
 b=gxchTLTeleUql+5troXJCe1/tJKJoH2alJTM00Bl9N1oEXBK5K6OgOuVO398yhaAC2
 B42NLWNB3vqmSZQagb6ZcjP8vjv/twRYy2fWIIs6/sYr+DVcl3SDRzsy09Da16GJlVim
 a0ATWGnaPG54ow5r74U/Cr6rgPnqZXWHfl3HuHEh9EfwxwEt7czMbIRfujFHnW0RiSWl
 yKZouwBHgYfuPRm4nYlpRPOMCSc3BNXukmriLnIJjaMSe5RNSan2FI18yCj6lg8oO2KE
 dNUmOfF80RKAb31+7hWAJLECww8Smr2wfxF51lJB0fFC73N8+Gk0F/YXsf1gO7VyjRaa
 9xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169157; x=1778773957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eJtMnPBYtkfA68rC6IgUqGua6khlh7OyNCqY+9Ynqxs=;
 b=B8lLlCjWVxv2ICks92lVMHR/IawUHvNI/aB5ESpvqffxjVbBZX3FZodYqZ4u1B0iUg
 n20iE73bxeXR5jKdjIMcpbg8DSAKI81LcgzZfEwg2QVjkjVkrhirZChpiyPj1ATY6Tnb
 YLmQB8RVcMYkY0LpDivuozNz2cvRmlmx73d8e3lqiYgHD1ncvBsIkNh3pQh7c6lensiE
 Z5YEl4OqjTQSETySFrZA0De9jr4/0vgLv3vN0UD/J7hVzt87rfrEajg9YGxia7ARsAmE
 K4QDn6ynsamhN1B8QIDU05HLL7MuC4Oi+W8ZOBiwIpsBZNRETwlpyZ2cvFy2CEO4lnS4
 /Zvw==
X-Gm-Message-State: AOJu0YyiXQXOVLnbYcqduVN7BGXo1/cCnN2AfVO9mynH1Au6tg3O2UEO
 CZJ0uGmuMxgwdkOx6CJU8j5FwyfBwG6xkWdrfUyPbzFGt7QsXg2oLDRnhqjMOiI7n8LBfHpHR+B
 qR2sQ
X-Gm-Gg: AeBDievVhItstoqaqFo/34xQ/V+Z0tTZqS8vvANDhFwTcRtOCPbnHgIfJ4d+qKR6ag9
 AVITXk3plFVgL5WmgZmip4GBNvy3KISy1WFPI01tq6BjujXuAffF6Hm9c9wc3vDLEERkZonRWdo
 Y+n4kaZ7LTX3hgl2Pfe3/boBrIoFCK3knpm5XhH54aZ/lR+xc8MDNVO7uBisZDWWP/A36Gee/sB
 164tlQAvPMjKugIHlsg0wlReAkCdYM0uQWgLLUuNbBfOmIhqk2ikaFWuU91ImDbzQ3cKu3H5/Ep
 T2aVu1jN4zJffWIOd5R8OIlWBdIjVSnjykFizsbFRC4Rv9nfvsSTXxGpz4X2J7YVdqMrJlmExFQ
 CmtIpeEiBHQVgGnbqPeP17qdJ6vrrnCEDZ7ns0d1TWBxtT/L+ekcUOLO537y/o/aWa3UBvW4EIN
 GlqgckSNUH/EhqBWrk9/nGsRZOyPWwpK+0DohB0YWaLyPlr2/fUsXTzLqqVnfDrIWFD/YYvbCCS
 qq86Z3sFCIEaI7eLmhodKybFJcryYrGx0weO+QNkg==
X-Received: by 2002:a05:600c:8b06:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-48e51e223ccmr139253455e9.11.1778169156619; 
 Thu, 07 May 2026 08:52:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/67] target/arm: GICv5 cpuif: Calculate the highest priority
 PPI
Date: Thu,  7 May 2026 16:51:29 +0100
Message-ID: <20260507155154.1886557-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

When the state of PPIs changes, recalculate the highest priority PPI.
In subsequent commits we will use this cached value to provide the
HPPI info to the guest, decide whether to signal IRQ or FIQ, handle
interrupt acknowldge from the guest, and so on.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-43-peter.maydell@linaro.org
---
 include/hw/intc/arm_gicv5_types.h | 21 +++++++++++
 meson.build                       |  1 +
 target/arm/cpu.h                  |  3 ++
 target/arm/tcg/gicv5-cpuif.c      | 58 +++++++++++++++++++++++++++++++
 target/arm/tcg/trace-events       |  5 +++
 target/arm/tcg/trace.h            |  1 +
 6 files changed, 89 insertions(+)
 create mode 100644 target/arm/tcg/trace-events
 create mode 100644 target/arm/tcg/trace.h

diff --git a/include/hw/intc/arm_gicv5_types.h b/include/hw/intc/arm_gicv5_types.h
index 5966ebde05..eaed42f49f 100644
--- a/include/hw/intc/arm_gicv5_types.h
+++ b/include/hw/intc/arm_gicv5_types.h
@@ -12,6 +12,8 @@
 #ifndef HW_INTC_ARM_GICv5_TYPES_H
 #define HW_INTC_ARM_GICv5_TYPES_H
 
+#include "hw/core/registerfields.h"
+
 /*
  * The GICv5 has four physical Interrupt Domains. This numbering must
  * match the encoding used in IRS_IDR0.INT_DOM.
@@ -86,4 +88,23 @@ typedef enum GICv5TriggerMode {
 
 #define PRIO_IDLE 0xff
 
+/*
+ * We keep track of candidate highest possible pending interrupts
+ * using this struct.
+ *
+ * Unlike GICv3, we don't need a separate NMI bool, because for GICv5
+ * superpriority is signaled by @prio == 0.
+ *
+ * In this struct the intid includes the interrupt type in bits
+ * [31:29] (i.e. it is in the form defined by R_TJPHS).
+ */
+typedef struct GICv5PendingIrq {
+    uint32_t intid;
+    uint8_t prio;
+} GICv5PendingIrq;
+
+/* Fields in a generic 32-bit INTID, per R_TJPHS */
+FIELD(INTID, ID, 0, 24)
+FIELD(INTID, TYPE, 29, 3)
+
 #endif
diff --git a/meson.build b/meson.build
index 5fbdc75a0f..2c95d6995a 100644
--- a/meson.build
+++ b/meson.build
@@ -3688,6 +3688,7 @@ if have_system or have_user
     'hw/core',
     'target/arm',
     'target/arm/hvf',
+    'target/arm/tcg',
     'target/hppa',
     'target/i386',
     'target/i386/kvm',
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 76db5a9197..f27f2e6bcc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -611,6 +611,9 @@ typedef struct CPUArchState {
         uint64_t ppi_enable[GICV5_NUM_PPIS / 64];
         /* The PRIO regs have 1 byte per PPI, so 8 PPIs to a register */
         uint64_t ppi_priority[GICV5_NUM_PPIS / 8];
+
+        /* Cached highest-priority pending PPI for each domain */
+        GICv5PendingIrq ppi_hppi[NUM_GICV5_DOMAINS];
     } gicv5_cpuif;
 
     struct {
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 33e4762ef4..80bb1cd391 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -11,6 +11,7 @@
 #include "internals.h"
 #include "cpregs.h"
 #include "hw/intc/arm_gicv5_stream.h"
+#include "trace.h"
 
 FIELD(GIC_CDPRI, ID, 0, 24)
 FIELD(GIC_CDPRI, TYPE, 29, 3)
@@ -105,6 +106,57 @@ static uint64_t gic_running_prio(CPUARMState *env, GICv5Domain domain)
     return hap < 32 ? hap : PRIO_IDLE;
 }
 
+static void gic_recalc_ppi_hppi(CPUARMState *env)
+{
+    /*
+     * Recalculate the HPPI PPI: this is the best PPI which is
+     * enabled, pending and not active.
+     */
+    for (int i = 0; i < ARRAY_SIZE(env->gicv5_cpuif.ppi_hppi); i++) {
+        env->gicv5_cpuif.ppi_hppi[i].intid = 0;
+        env->gicv5_cpuif.ppi_hppi[i].prio = PRIO_IDLE;
+    };
+
+    for (int i = 0; i < ARRAY_SIZE(env->gicv5_cpuif.ppi_active); i++) {
+        uint64_t en_pend_nact = env->gicv5_cpuif.ppi_enable[i] &
+            env->gicv5_cpuif.ppi_pend[i] &
+            ~env->gicv5_cpuif.ppi_active[i];
+
+        while (en_pend_nact) {
+            /*
+             * When EL3 is supported ICC_PPI_DOMAINR<n>_EL3 tells us
+             * the domain of each PPI. While we only support EL1, the
+             * domain is always NS.
+             */
+            GICv5Domain ppi_domain = GICV5_ID_NS;
+            uint8_t prio;
+            int ppi;
+            int bit = ctz64(en_pend_nact);
+
+            en_pend_nact &= ~(1 << bit);
+
+            ppi = i * 64 + bit;
+            prio = extract64(env->gicv5_cpuif.ppi_priority[ppi / 8],
+                             (ppi & 7) * 8, 5);
+
+            if (prio < env->gicv5_cpuif.ppi_hppi[ppi_domain].prio) {
+                uint32_t intid = 0;
+
+                intid = FIELD_DP32(intid, INTID, ID, ppi);
+                intid = FIELD_DP32(intid, INTID, TYPE, GICV5_PPI);
+                env->gicv5_cpuif.ppi_hppi[ppi_domain].intid = intid;
+                env->gicv5_cpuif.ppi_hppi[ppi_domain].prio = prio;
+            }
+        }
+    }
+
+    for (int i = 0; i < ARRAY_SIZE(env->gicv5_cpuif.ppi_hppi); i++) {
+        trace_gicv5_recalc_ppi_hppi(i,
+                                    env->gicv5_cpuif.ppi_hppi[i].intid,
+                                    env->gicv5_cpuif.ppi_hppi[i].prio);
+    }
+}
+
 static void gic_cddis_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
@@ -200,6 +252,7 @@ static void gic_ppi_cactive_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     uint64_t old = raw_read(env, ri);
     raw_write(env, ri, old & ~value);
+    gic_recalc_ppi_hppi(env);
 }
 
 static void gic_ppi_sactive_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -207,6 +260,7 @@ static void gic_ppi_sactive_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     uint64_t old = raw_read(env, ri);
     raw_write(env, ri, old | value);
+    gic_recalc_ppi_hppi(env);
 }
 
 static void gic_ppi_cpend_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -217,6 +271,7 @@ static void gic_ppi_cpend_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t hm = env->gicv5_cpuif.ppi_hm[ri->opc2 & 1];
     value &= ~hm;
     raw_write(env, ri, old & ~value);
+    gic_recalc_ppi_hppi(env);
 }
 
 static void gic_ppi_spend_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -227,18 +282,21 @@ static void gic_ppi_spend_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t hm = env->gicv5_cpuif.ppi_hm[ri->opc2 & 1];
     value &= ~hm;
     raw_write(env, ri, old | value);
+    gic_recalc_ppi_hppi(env);
 }
 
 static void gic_ppi_enable_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                  uint64_t value)
 {
     raw_write(env, ri, value);
+    gic_recalc_ppi_hppi(env);
 }
 
 static void gic_ppi_priority_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                    uint64_t value)
 {
     raw_write(env, ri, value);
+    gic_recalc_ppi_hppi(env);
 }
 
 /*
diff --git a/target/arm/tcg/trace-events b/target/arm/tcg/trace-events
new file mode 100644
index 0000000000..7dc5f781c5
--- /dev/null
+++ b/target/arm/tcg/trace-events
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# See docs/devel/tracing.rst for syntax documentation.
+
+# gicv5-cpuif.c
+gicv5_recalc_ppi_hppi(int domain, uint32_t id, uint8_t prio) "domain %d new PPI HPPI id 0x%x prio %u"
diff --git a/target/arm/tcg/trace.h b/target/arm/tcg/trace.h
new file mode 100644
index 0000000000..c6e89d018b
--- /dev/null
+++ b/target/arm/tcg/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_arm_tcg.h"
-- 
2.43.0


