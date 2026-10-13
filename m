Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553A0CC6B10
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY3s-0008Dy-Aj; Tue, 13 Oct 2026 04:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3d-0007Zr-VF
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3b-0007uf-0p
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:24 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a16c399641so26911355e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880818; x=1792485618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lh+2T2GNGXypbGBZ7mOAEqbcBqzSK4Ir0IjdWPDly0g=;
 b=bIqJF2MRLaT/C6yyIqlnFSgkfiyBeHP2oj04JosMeYMn6gIohD5Sdz8SyK4y7ICtcx
 p1KvsAioL505nOVndastoA8RaP5zd1hxxuuO+5RvoDWbYaPJlwa4F565C9Ol98tXNvoG
 Ijvj2bhImqhKKi7S0DCDX0753mOWRZtYlE8igwMEXDVCefVqYG9FL5nT00MulkKN/DQ5
 BomdZvpO5oo8kHmNvmKlPpBW1qeDfJmunbxAd+LxqfKPeLcD6urE7Nlh+X+4CZPyTX1P
 KHVswpBWrs/XZF65lvceneSK+qryXqGub3dHrzjldM1X9VNiAqBQgYPpiSAOm2eZziwF
 LY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880818; x=1792485618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lh+2T2GNGXypbGBZ7mOAEqbcBqzSK4Ir0IjdWPDly0g=;
 b=1U4O/49aY9HP4jBl45gbXrc+mOVpz8WXao5gSDoZEmg9q+BLyaeqFcFpH7y9u8fa1X
 8bGnLMoF5k8s6sXUttAzM9nLvBXLlH2sECvytFtIqyRY67OwuwW1/JZbiliuNDhvueCz
 6msaR6123BkjD8ZcFuQ0/t0NW1m2Q3KZ+GTz3fuj8hLohxUWJJVgmz92oHPPaYW6P4T8
 XeA6PjhXPzSxKGxm36GYRHYTQPoInHVs2egcRzCJHC2PsVfkFhXo7jlN0WozQipBu9DC
 NTVJq33ikpnW7KeiTnkXT0C9j2XSZq68vYs3RIhPUO/H2kkTrd0IsV7S4GsqHMBZttJ0
 8/rQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUwh2DfAZ/nwq3C7wdC+JhxbrYlNKzF4XhiNUUJV6Q+E/N2DgY0U50If2Ycd0n+nghDCN5FZ2v1nAG@nongnu.org
X-Gm-Message-State: AFq9FYIhPfhWCo4nY61U5T6L62Q1eogltGgITVeyMpM2Grx9QqETOIlL
 tDSC0vMccKMSWtrcRAEPc0V8H/DDMwriheJXc+MmHdl1gYRTVEo2/bfWuIYpQjSrEQs=
X-Gm-Gg: AYBFou2RN3ZzpvjMRZ2Tm2CcZ593b0tn4vnD0bfbyrJ9G2zdQ5/azlw1tTyf0DwskZx
 lfwMhxmArb2Ft0JbFxbidVmsCDv5w/ceAiAPmnEJKBBf9gEABGFHJ7fLj7WIlRAelFrRPedBGXG
 T3PVqYmL4jKZYQ8ZybsDeA2Y9z/V5NEUoLTX6vwEWuiFrjDdgwB6kMEAVYfKTylmmTY84MfrpD5
 nL8s2pQpUneGkDXyy58rox2MCgGF67r1dWkxhEGpC5AI7vPtxB7CtVpaz2968Z8Hqu/33Mk/sjU
 QZYjLHnJf4bzOIomj+2a8K/+nfSmJm03zpev8ZcgJzDJmhCP4yUt3/Tj4shBVz8oxiokwz59EfW
 ERB1WKQgQEJKAoZMngg2FmzCgoJnLWA0x1CZJx4iV3GmlayFYW5KfepcIbrTXyj82rPlu/dO02Z
 EZmlmk9Zst6UZ2dNlr1+dlloXmxtgM2jQ3mI863vy3Etyiokk9kcBZ0P+Fq/SB0E05qua2fxVz7
 6dqHICTMAcboJRXc80QRNslUfB63FMkLJYdUx2065hfOJ82JTjncC5qPLhMrQeigp051j5EFFk6
 P4I=
X-Received: by 2002:a05:600c:138a:b0:4a1:7bd4:d07d with SMTP id
 5b1f17b1804b1-4a18e4c85fdmr249944985e9.34.1791880818246; 
 Tue, 13 Oct 2026 01:40:18 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 31/86] target/arm: GICv5 cpuif: Calculate current virtual PPI
 HPPI
Date: Tue, 13 Oct 2026 09:38:38 +0100
Message-ID: <20261013083933.1024405-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
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

Implement gic_recalc_virt_ppi_hppi(), which calculates the current
HPPI PPI for the virtual interrupt domain, using similar logic to
gic_recalc_ppi_hppi().  We call this from everywhere where we update
the state of the virtual PPIs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h             |  2 ++
 target/arm/tcg/gicv5-cpuif.c | 51 ++++++++++++++++++++++++++++++++++++
 target/arm/tcg/trace-events  |  1 +
 3 files changed, 54 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 81fb68facb9..abaee5fc3a0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -596,6 +596,8 @@ typedef struct CPUArchState {
 
         /* Cached highest-priority pending PPI for each domain */
         GICv5PendingIrq ppi_hppi[NUM_GICV5_DOMAINS];
+        /* And for the virtual interrupt domain */
+        GICv5PendingIrq virt_ppi_hppi;
 
         uint64_t ich_apr_el2;
         uint64_t ich_vctlr_el2;
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 96384c58726..0d38ed7b15b 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -298,6 +298,45 @@ static void gic_recalc_ppi_hppi(CPUARMState *env)
     gicv5_update_irq_fiq(env);
 }
 
+static void gic_recalc_virt_ppi_hppi(CPUARMState *env)
+{
+    /*
+     * Recalculate the HPPI PPI for the virtual interrupt domain: this is
+     * the best PPI which is enabled, pending and not active.
+     */
+    env->gicv5_cpuif.virt_ppi_hppi = GICV5_PENDING_IRQ_NONE;
+
+    for (int i = 0; i < ARRAY_SIZE(env->gicv5_cpuif.ich_ppi_active); i++) {
+        uint64_t en_pend_nact = env->gicv5_cpuif.ich_ppi_enable[i] &
+            env->gicv5_cpuif.ich_ppi_pend[i] &
+            ~env->gicv5_cpuif.ich_ppi_active[i];
+
+        while (en_pend_nact) {
+            uint8_t prio;
+            int ppi;
+            int bit = ctz64(en_pend_nact);
+
+            en_pend_nact &= ~(1ULL << bit);
+
+            ppi = i * 64 + bit;
+            prio = extract64(env->gicv5_cpuif.ich_ppi_priority[ppi / 8],
+                             (ppi & 7) * 8, 5);
+
+            if (prio < env->gicv5_cpuif.virt_ppi_hppi.prio) {
+                uint32_t intid = 0;
+
+                intid = FIELD_DP32(intid, INTID, ID, ppi);
+                intid = FIELD_DP32(intid, INTID, TYPE, GICV5_PPI);
+                env->gicv5_cpuif.virt_ppi_hppi.intid = intid;
+                env->gicv5_cpuif.virt_ppi_hppi.prio = prio;
+            }
+        }
+    }
+
+    trace_gicv5_recalc_virt_ppi_hppi(env->gicv5_cpuif.virt_ppi_hppi.intid,
+                                     env->gicv5_cpuif.virt_ppi_hppi.prio);
+}
+
 void gicv5_forward_interrupt(ARMCPU *cpu, GICv5Domain domain)
 {
     /*
@@ -460,6 +499,7 @@ static void gic_ppi_cactive_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (gicv5_icv_access(env)) {
         value &= ~env->gicv5_cpuif.ich_ppi_hvi[ri->opc2 & 1];
         env->gicv5_cpuif.ich_ppi_active[ri->opc2 & 1] &= ~value;
+        gic_recalc_virt_ppi_hppi(env);
     } else {
         uint64_t old = raw_read(env, ri);
         raw_write(env, ri, old & ~value);
@@ -473,6 +513,7 @@ static void gic_ppi_sactive_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (gicv5_icv_access(env)) {
         value &= ~env->gicv5_cpuif.ich_ppi_hvi[ri->opc2 & 1];
         env->gicv5_cpuif.ich_ppi_active[ri->opc2 & 1] |= value;
+        gic_recalc_virt_ppi_hppi(env);
     } else {
         uint64_t old = raw_read(env, ri);
         raw_write(env, ri, old | value);
@@ -502,6 +543,7 @@ static void gic_ppi_cpend_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (gicv5_icv_access(env)) {
         value &= ~env->gicv5_cpuif.ich_ppi_hvi[ri->opc2 & 1];
         env->gicv5_cpuif.ich_ppi_pend[ri->opc2 & 1] &= ~value;
+        gic_recalc_virt_ppi_hppi(env);
     } else {
         uint64_t old = raw_read(env, ri);
         raw_write(env, ri, old & ~value);
@@ -519,6 +561,7 @@ static void gic_ppi_spend_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (gicv5_icv_access(env)) {
         value &= ~env->gicv5_cpuif.ich_ppi_hvi[ri->opc2 & 1];
         env->gicv5_cpuif.ich_ppi_pend[ri->opc2 & 1] |= value;
+        gic_recalc_virt_ppi_hppi(env);
     } else {
         uint64_t old = raw_read(env, ri);
         raw_write(env, ri, old | value);
@@ -544,6 +587,7 @@ static void gic_ppi_enable_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (gicv5_icv_access(env)) {
         value &= ~env->gicv5_cpuif.ich_ppi_hvi[ri->opc2 & 1];
         env->gicv5_cpuif.ich_ppi_enable[ri->opc2 & 1] = value;
+        gic_recalc_virt_ppi_hppi(env);
     } else {
         raw_write(env, ri, value);
         gic_recalc_ppi_hppi(env);
@@ -610,6 +654,7 @@ static void gic_ppi_priority_write(CPUARMState *env, const ARMCPRegInfo *ri,
         uint64_t hvi_mask = gic_ppi_prio_hvi_mask(env, idx);
 
         env->gicv5_cpuif.ich_ppi_priority[idx] = value & ~hvi_mask;
+        gic_recalc_virt_ppi_hppi(env);
     } else {
         raw_write(env, ri, value);
         gic_recalc_ppi_hppi(env);
@@ -620,36 +665,42 @@ static void gic_ich_ppi_enable_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                      uint64_t value)
 {
     raw_write(env, ri, value);
+    gic_recalc_virt_ppi_hppi(env);
 }
 
 static void gic_ich_ppi_pend_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                    uint64_t value)
 {
     raw_write(env, ri, value);
+    gic_recalc_virt_ppi_hppi(env);
 }
 
 static void gic_ich_ppi_active_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                      uint64_t value)
 {
     raw_write(env, ri, value);
+    gic_recalc_virt_ppi_hppi(env);
 }
 
 static void gic_ich_ppi_priority_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                        uint64_t value)
 {
     raw_write(env, ri, value);
+    gic_recalc_virt_ppi_hppi(env);
 }
 
 static void gic_ich_ppi_dvi_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                   uint64_t value)
 {
     raw_write(env, ri, value);
+    gic_recalc_virt_ppi_hppi(env);
 }
 
 static void gic_ich_ppi_hvi_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                   uint64_t value)
 {
     raw_write(env, ri, value);
+    gic_recalc_virt_ppi_hppi(env);
 }
 
 static void gic_ich_vctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
diff --git a/target/arm/tcg/trace-events b/target/arm/tcg/trace-events
index bf1803c8722..da25ec994cc 100644
--- a/target/arm/tcg/trace-events
+++ b/target/arm/tcg/trace-events
@@ -3,6 +3,7 @@
 
 # gicv5-cpuif.c
 gicv5_recalc_ppi_hppi(int domain, uint32_t id, uint8_t prio) "domain %d new PPI HPPI id 0x%x prio %u"
+gicv5_recalc_virt_ppi_hppi(uint32_t id, uint8_t prio) "virtual domain new PPI HPPI id 0x%x prio %u"
 gicv5_gicr_cdia_fail(int domain, const char *reason) "domain %d CDIA attempt failed: %s"
 gicv5_gicr_cdia(int domain, uint32_t id) "domain %d CDIA acknowledge of interrupt 0x%x"
 gicv5_cdeoi(int domain) "domain %d CDEOI performing priority drop"
-- 
2.43.0


