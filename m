Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A2DCD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11p-0004pm-B2; Thu, 07 May 2026 11:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11m-0004YT-SF
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:42 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11k-0003ye-EJ
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:42 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so6672655e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169159; x=1778773959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/LAMedYRFDy6rCDw1/38CGkQbibECB3iBhdeGcNo77s=;
 b=JHb15rl2Zl8E69QHInD1o/Ewk+kQ+Lf5n7o5tpRdXOV3Y1ILszqnC//D5RPZCF8oPb
 iXP+1fcdQ+M8TdieXYj4NxSeaTrcv7iF9Zd6s/lQSWp6RbCBQZQvQOQdQFvH3v9ss2PQ
 OpV3bbmvWV5GPdJy+Bly+3tuGVwqc8GguuSvqPv6q0omZAbvx1J0rZbCl5z1XsGZlbNw
 tcNmubr7oPght/pHFC3e1Fvy/3M9OGchmUL5IhkpPJKECtxB+nrx0SziQXUNqmxv8+9w
 wNZ2hV4pJ7ny0FfLdIekbG3XhLVotEnjaxr+3MH88GLxWBmhCCo3uBOUDgWhmnMvXxbt
 uP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169159; x=1778773959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/LAMedYRFDy6rCDw1/38CGkQbibECB3iBhdeGcNo77s=;
 b=k/3h2X44pz3RZH6Y9tWyy0/WwXMNzjx9h8EBKN/yyRIbCpJ37HLyiO7VxRKWTZwInd
 UXJppzoD7fpGndmox9y5Na6mHtcydCFlNzkv6R9tcSmd4s+/tD4+eN4DyOwXc5TGvoM4
 wW/snLq3lhHktoIgIDYPksVYSzg2qN2Mm8KCjDPv1cEuPJOdteUUMOgC/+gg1x/g1/DW
 RVnNLXsOZ5DXPZTFOoH2DEJ148dZwTYeNGD/7A2fKeaaluAME9KkeaDYp+8DqI/WE10Q
 vFT5KE/TsfgtbnyP2u7ny8+dqLK8t8EiXXDU0mmzKid8OJkg81pYBZqeK1TP0GSdpL3A
 5GMQ==
X-Gm-Message-State: AOJu0Ywl/wI/l2+BOwp5rPwd2ggHLsiwtr8174+X4qrMykY1JtV6elOV
 jn8XUktsyCykLUgQsz/V/0cjqT8Lbrnmv6BVW5HcOzDioIK0hFNne7qBbWjAH+9qybYT1Xsi0LV
 7gQ8J
X-Gm-Gg: AeBDieunyfTOa4iWi54UnCYsfvRhB99ORqWjnKm6zXRvy0O7XoRt7KGgLvNwt6PcG76
 /dnYYPR8lKWaejjDXm1+iswyyEFv6q71xz98z2pzdUVGBQ0U+pozKKMKav0SPPstzvrdgTwzJ1C
 nt5uzd2r0TseblBBlIArU3G5k5ccxLIVun41nBcLgUYp+w12qNXTu+KfFBX1i+4eAvixokWeGmA
 GVP3hJ2YZr8dOTr0MIjOPyo3F8iaT4yTbXSsZ6VKhW1u8NAqo5WX1F+o+BwLNY/SG6pIkXZKTwk
 LlFWk0HpBMgdYPJjmIRF00XI9j1EwUa7KC6dN5iIe35bA1QEbjYPEOinjuD03bR1fZN6PFDJA9y
 SZVYmK6BCezR2/BM752aTJWj590YC3pRSSzd28rvdpZNWAppIX6P8iKDwEGPGLnyBhLNb/u4gzg
 cNrde4MTekp4IT4IP+AZAwrFACRlno+zYPpHKblAfNeiZhe25GMUgKJ4QCU3o4Z2jqulXJOIz8R
 p8kAxtFVSCOG8QJ
X-Received: by 2002:a05:600c:a10d:b0:487:12c:e7e1 with SMTP id
 5b1f17b1804b1-48e51e1f013mr107824275e9.11.1778169158380; 
 Thu, 07 May 2026 08:52:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/67] target/arm: GICv5 cpuif: Implement ICC_CR0_EL1
Date: Thu,  7 May 2026 16:51:31 +0100
Message-ID: <20260507155154.1886557-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Implement ICC_CR0_EL1, which is the main control register.  This is
banked between interrupt domains in the same way as ICC_APR_*.

The GICv5 spec assumes that typically there will need to be a
hardware handshake between the CPU and the IRS, which is kicked off
by guest software setting a LINK bit in this register to bring the
link between the two online.  However it is permitted to have an
implementation where the link is permanently up.  We take advantage
of this, so our LINK and LINK_IDLE bits are read-only and always 1.

This means the only interesting bit in this register for us is the
main enable bit: when disabled for a domain, the cpuif considers that
there is never an available highest priority interrupt.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-45-peter.maydell@linaro.org
---
 target/arm/cpu.h             |  1 +
 target/arm/tcg/gicv5-cpuif.c | 44 ++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f27f2e6bcc..afe7f71a04 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -604,6 +604,7 @@ typedef struct CPUArchState {
         /* GICv5 CPU interface data */
         uint64_t icc_icsr_el1;
         uint64_t icc_apr[NUM_GICV5_DOMAINS];
+        uint64_t icc_cr0[NUM_GICV5_DOMAINS];
         /* Most PPI registers have 1 bit per PPI, so 64 PPIs to a register */
         uint64_t ppi_active[GICV5_NUM_PPIS / 64];
         uint64_t ppi_hm[GICV5_NUM_PPIS / 64];
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index e6f21d53b6..23d51bd798 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -43,6 +43,12 @@ FIELD(ICC_IDR0_EL1, ID_BITS, 0, 4)
 FIELD(ICC_IDR0_EL1, PRI_BITS, 4, 4)
 FIELD(ICC_IDR0_EL1, GCIE_LEGACY, 8, 4)
 
+FIELD(ICC_CR0, EN, 0, 1)
+FIELD(ICC_CR0, LINK, 1, 1)
+FIELD(ICC_CR0, LINK_IDLE, 2, 1)
+FIELD(ICC_CR0, IPPT, 32, 6)
+FIELD(ICC_CR0, PID, 38, 1)
+
 /*
  * We implement 24 bits of interrupt ID, the mandated 5 bits of priority,
  * and no legacy GICv3.3 vcpu interface (yet)
@@ -346,6 +352,37 @@ static uint64_t gic_icc_hapr_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return gic_running_prio(env, gicv5_current_phys_domain(env));
 }
 
+/* ICC_CR0_EL1 is also banked */
+static uint64_t gic_icc_cr0_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv5Domain domain = gicv5_logical_domain(env);
+    return env->gicv5_cpuif.icc_cr0[domain];
+}
+
+static void gic_icc_cr0_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    /*
+     * For our implementation the link to the IRI is always connected,
+     * so LINK and LINK_IDLE are always 1. Without EL3, PID and IPPT
+     * are RAZ/WI, so the only writeable bit is the main enable bit EN.
+     */
+    GICv5Domain domain = gicv5_logical_domain(env);
+    value &= R_ICC_CR0_EN_MASK;
+    value |= R_ICC_CR0_LINK_MASK | R_ICC_CR0_LINK_IDLE_MASK;
+
+    env->gicv5_cpuif.icc_cr0[domain] = value;
+}
+
+static void gic_icc_cr0_el1_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /* The link is always connected so we reset with LINK and LINK_IDLE set */
+    for (int i = 0; i < ARRAY_SIZE(env->gicv5_cpuif.icc_cr0); i++) {
+        env->gicv5_cpuif.icc_cr0[i] =
+            R_ICC_CR0_LINK_MASK | R_ICC_CR0_LINK_IDLE_MASK;
+    }
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -504,6 +541,13 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .writefn = gic_icc_apr_el1_write,
         .resetfn = gic_icc_apr_el1_reset,
     },
+    {   .name = "ICC_CR0_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 1, .crn = 12, .crm = 0, .opc2 = 1,
+        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .readfn = gic_icc_cr0_el1_read,
+        .writefn = gic_icc_cr0_el1_write,
+        .resetfn = gic_icc_cr0_el1_reset,
+    },
     {   .name = "ICC_HAPR_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 1, .crn = 12, .crm = 0, .opc2 = 3,
         .access = PL1_R, .type = ARM_CP_IO | ARM_CP_NO_RAW,
-- 
2.43.0


