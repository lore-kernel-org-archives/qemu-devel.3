Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A3210ED662
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65CD-00071s-8W; Fri, 27 Mar 2026 07:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CC-00070f-21
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:44 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CA-0008FE-07
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:43 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48557c8ad47so14776045e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610260; x=1775215060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zO8+icgVC1WFthhuPn3fXGZ2vtbwSvDSsbRmXizchEg=;
 b=K0GALIVUDmPhEb5XC8jfilPkeXQOC787b12Aufx4QcU1urwnyknIRuqU40HlPvJ4OP
 wM3x6A0HMSsf9heH1zTmAqLnjN5QEiRUTfvIGpTWmPSeD9bMsIcwDcWOFrHX+f8cvHP4
 JGf9S0UPkjBPcBP693XaZqIom4roLBoGzT0+zBBPxAHuhDrqTfVQ1Sn+ttBpHBFgiRZh
 TAC28VEQ66ZCFM74Pu7J73zMZZGe0Qb2++Ka2Q0h4S7ZrljVVAKw0iLtzsjAIoLXOJUm
 YcAny0oRZzhUfJmQVN8BfSBr+x5mctD1jXmX0lDHEaRHv3E2mdTqrp3KEmHh8Cm0klbK
 1cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610260; x=1775215060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zO8+icgVC1WFthhuPn3fXGZ2vtbwSvDSsbRmXizchEg=;
 b=JR0Mx11R4ybtaqqijvBJEUpVUPl5zz9dvdPTpegeZaSAgf/95e6WuwfCBSGFJci6sH
 XG+BNZl0C20JSusyAQ1cljlpr/8b+1ODXrslbUoVuPjivscp0BQqW328yrUlgahpbHsu
 UXohFXgQNia0GByqhFbrwo4UB/L3Ia58Q0t1cg8LiWcD3h/DjbC+zCh4dTIivAqsWuBy
 oAyhdkERhdaXqpv3jom4xzaZVRgs+ThIos72DiNkbn+ngpdaeNKmiJb+LyJpTvvh5MQH
 CbpExp9ziWQ8logbq8LpZAvXvzKm9Zaeew83EduqDFLwWyUdvDT2+rooLCVILm8yOpVx
 KAqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcHFvWjGtpyAVnjbUyfukv96u8n6z+r1kakOyDg/uQrUHnFJbgQ/PVZtlqSU7Eh/tXPHZhhxK80OMK@nongnu.org
X-Gm-Message-State: AOJu0YyGxy1Dcs/egOEtTwQYRRjA/tqlb/icCAuBdbP3FyowzmqNN1cP
 KfmHTbB5TT/z4bUs+n/UvN+ghBJl8sDB/DWWaDEq3GzNrS4/l0Nde5gz2PODWGAYAGo=
X-Gm-Gg: ATEYQzxfl0ubSeI3upbP53ZZFuC7URzHNYzJbHY/vtYdeNI4bpWIWOxuxfwOXjH/GpR
 cNa1F7h2pUg3144ypv9CgvzikvQsoqOkNqCO/Sh6Wvx21CkeaRLWleZvz/BiJnKUK8OYJQ2gnJQ
 Lmg82CtkZU1DvzPQMu1Lh1IIdKIq/1H9TOWB481ck6EVZQ+Tja32FE7GkFgHklalG46wvbxJa8+
 KypzqNUG8g3WUp2Wjmkqbh8zCgPvHJJXvsKBAFL0M6SLSMk7KloHdTZNZL9+0+2HuFNxcWSJtmB
 pVgC6yar1ZJ0KHEckQ0OpYMhFVfIwkIjPAIVHcbFZPBhITWycEknjUrJEzqC5bLmrjZawXyQW73
 1vnScfSRch22oBXI24lxHdc68itt9RFpzJ3gHGVpOY4UWi7jdZIiBrUZM7slIPkgpm9uToUVs4s
 g5CpsZ+PshOVyMKavxwqaVOJETe/nxNgPDGfsy1QrFBAMkN57DoNClRLz42NQrluh70w40wgcqC
 vPt6+JrN8l86R8Ggm/3YedvmMtjmI0=
X-Received: by 2002:a05:600c:4e55:b0:485:4533:9c47 with SMTP id
 5b1f17b1804b1-48727ec77a9mr37014825e9.22.1774610260204; 
 Fri, 27 Mar 2026 04:17:40 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 40/65] target/arm: GICv5 cpuif: Implement PPI priority
 registers
Date: Fri, 27 Mar 2026 11:16:35 +0000
Message-ID: <20260327111700.795099-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

Implement the GICv5 registers which hold the priority of the PPIs.
Each 64-bit register has the priority fields for 8 PPIs, so there are
16 registers in total.  This would be a lot of duplication if we
wrote it out statically in the array, so instead create each register
via a loop in define_gicv5_cpuif_regs().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 target/arm/cpu.h             |  2 ++
 target/arm/tcg/gicv5-cpuif.c | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 915a225f8e..b97f659352 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -608,6 +608,8 @@ typedef struct CPUArchState {
         uint64_t ppi_hm[GICV5_NUM_PPIS / 64];
         uint64_t ppi_pend[GICV5_NUM_PPIS / 64];
         uint64_t ppi_enable[GICV5_NUM_PPIS / 64];
+        /* The PRIO regs have 1 byte per PPI, so 8 PPIs to a register */
+        uint64_t ppi_priority[GICV5_NUM_PPIS / 8];
     } gicv5_cpuif;
 
     struct {
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 09cd56cbfa..74132ca097 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -225,6 +225,12 @@ static void gic_ppi_enable_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
+static void gic_ppi_priority_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   uint64_t value)
+{
+    raw_write(env, ri, value);
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -382,5 +388,22 @@ void define_gicv5_cpuif_regs(ARMCPU *cpu)
 {
     if (cpu_isar_feature(aa64_gcie, cpu)) {
         define_arm_cp_regs(cpu, gicv5_cpuif_reginfo);
+
+        /*
+         * There are 16 ICC_PPI_PRIORITYR<n>_EL1 regs, so define them
+         * programmatically rather than listing them all statically.
+         */
+        for (int i = 0; i < 16; i++) {
+            g_autofree char *name = g_strdup_printf("ICC_PPI_PRIORITYR%d_EL1", i);
+            ARMCPRegInfo ppi_prio = {
+                .name = name, .state = ARM_CP_STATE_AA64,
+                .opc0 = 3, .opc1 = 0, .crn = 12,
+                .crm = 14 + (i >> 3), .opc2 = i & 7,
+                .access = PL1_RW, .type = ARM_CP_IO,
+                .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_priority[i]),
+                .writefn = gic_ppi_priority_write, .raw_writefn = raw_write,
+            };
+            define_one_arm_cp_reg(cpu, &ppi_prio);
+        }
     }
 }
-- 
2.43.0


