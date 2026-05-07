Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2641CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11f-00041g-Mr; Thu, 07 May 2026 11:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11e-00040j-DV
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:34 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11c-0003wE-Pl
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:34 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so15305115e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169151; x=1778773951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4LLXc2AzW0iFxiRZ2Bd0TLDJJVzDJvcAwb4iYjjgrJ0=;
 b=OSBAxL6aXARslVB3zr6hZvNetblUDo+fREzS5RrnyPyZR6+7S0/IqtAgebq9XVVoCG
 Q0KrZgPcu0HvciVr+90+PSt6u3cQrNhmx5SXzs0Y72EUXrKuA1AwlgpgMBOGufCqJVOM
 xvXOE/kAuHHb8TWltC0Yv8N4OpUEj5RtTaIKKX0Ev2jIgEB11lnL4DMU22v6ket4zpf7
 B/jHiRNZ1sd2l/B7LlyvH503uEN7tsF/mwHt7bsodg9SwXqT9iy2jJQuThnU63p8J1Jf
 TP5QQvt8GdbYKbot0AFO34R9i/nH+MeQWHeEDX7Fg0wTS/Da/YDERVXrDhTUrCeEgY2q
 FxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169151; x=1778773951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4LLXc2AzW0iFxiRZ2Bd0TLDJJVzDJvcAwb4iYjjgrJ0=;
 b=ZCW0X9bvTIUXTa7zgFWcVWqCZyaEHo8VVmXsuBiVqaxZSDt5UlULnF7ToRZajE+wfE
 qKEAfxWKc3aMc6DNVZJ8MIkuCvtYQVsJpUSOZgCVczK+yp+Y8DaUN/oRA+OwF+cQ22c0
 y9/0myOJwtFiqnUdrf0tnSVVifqrZ6ZENwfd1PgfhLsCotU2Bv2yIrCo13jkjXgjWTGj
 Mo2n96ya9FZ6kALKdsmjnaGc1q7/Inte6cjVJZChDGNj1zFw2WpOPVKTt/pE68eMd84b
 mri9MhX54FhpTq2bIvs1YnirWBM0a91EyVf5xf/21vI9/kYAf+2jyiMpEooEK6cnKzhy
 tAaA==
X-Gm-Message-State: AOJu0YyDUWIOIJ7Ht0866yMw2aoNyzQRWDCfsuhG+xV6GJzcsI/QX730
 rsQIeNOnN5J+fOBAmztP2cAviBEY04s1qkggJYGw+yc4p5CTFgqyKeCM0qKQG0bHgdZf3YmpSmb
 Tqn1q
X-Gm-Gg: AeBDiev5n4OHsbGhGm3K37fbKKMX5ymOsUKQcZZ0pWQkig8HPMsJYYFdGtHzoOIG08f
 uGenv1vyBn8hSsT6Z4KDLkpbaiBTHp2F+8LM2sJwAXuBTF6jbrVETIh6DsviGPmglj7Aer72gH/
 WBta8NWZewowB6phzQ+k+IUClO4RHDT0WU8BQkf3H0gYFCzFlNMzYd7LsrlMs8eJ1O6WaGCSKBA
 6IxS4nNzP/hBgQLe7GJrUXWfKZDGOYzdwJzNEGfLq3JzVj6rIxP9ykNTpdqvbxpdPnbqIbHrTcb
 d/tkGrtDaDvSsSJ8DVpxP1N7841C6/sn6NCd3/0TZFDJ+YU0GEtRHYXyedMLhY0xvl+P4WqmJnP
 wrp8jqkB/47HjxeRe8sZD0qxGKWO40gT3rujR8lSEt1FJ/bnMkQi1bsuSc36jFLdgt73htZ3Pyr
 0tIOlGCfntCOsBaQXsNMzhVLZmTY4exDfppA/Sw9/nj2UV6/kHdWzKTvP4QhUuruAozKz2mkqi4
 dYe73IfnMWYIoC3f+ERXuRoJITVJQkshTZOr3bpcA==
X-Received: by 2002:a05:600c:3b17:b0:488:acbc:b2e with SMTP id
 5b1f17b1804b1-48e51f32c94mr141105685e9.17.1778169151346; 
 Thu, 07 May 2026 08:52:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/67] target/arm: GICv5 cpuif: Implement GICv5 PPI active
 set/clear registers
Date: Thu,  7 May 2026 16:51:23 +0100
Message-ID: <20260507155154.1886557-37-peter.maydell@linaro.org>
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

In the GICv5 PPI state and control lives in the CPU interface; this
is different from the GICv3 where this was all in the redistributor.

Implement the access system registers for the PPI active state; this
is a pair of registers, one of which has "write 1 to clear" behaviour
and the other of which has "write 1 to set".  In both cases, reads
return the current state.

We start here by implementing the accessors for the underlying state;
we don't yet attempt to do anything (e.g.  recalculating the highest
priority pending PPI) when the state changes.  That will come in
subsequent commits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-37-peter.maydell@linaro.org
---
 target/arm/cpu.h             |  5 +++++
 target/arm/tcg/gicv5-cpuif.c | 38 ++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c7c410bed7..ac0891d498 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -256,6 +256,9 @@ typedef enum ARMFPStatusFlavour {
 } ARMFPStatusFlavour;
 #define FPST_COUNT  10
 
+/* Architecturally there are 128 PPIs in a GICv5 */
+#define GICV5_NUM_PPIS 128
+
 typedef struct CPUArchState {
     /* Regs for current mode.  */
     uint32_t regs[16];
@@ -599,6 +602,8 @@ typedef struct CPUArchState {
     struct {
         /* GICv5 CPU interface data */
         uint64_t icc_icsr_el1;
+        /* Most PPI registers have 1 bit per PPI, so 64 PPIs to a register */
+        uint64_t ppi_active[GICV5_NUM_PPIS / 64];
     } gicv5_cpuif;
 
     struct {
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 497c09474b..6672cda37f 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -175,6 +175,20 @@ static void gic_cdhm_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gicv5_set_handling(gic, id, hm, domain, type, virtual);
 }
 
+static void gic_ppi_cactive_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    uint64_t old = raw_read(env, ri);
+    raw_write(env, ri, old & ~value);
+}
+
+static void gic_ppi_sactive_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    uint64_t old = raw_read(env, ri);
+    raw_write(env, ri, old | value);
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -254,6 +268,30 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
          */
         .resetfn = arm_cp_reset_ignore,
     },
+    {   .name = "ICC_PPI_CACTIVER0_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 0,
+        .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[0]),
+        .writefn = gic_ppi_cactive_write,
+    },
+    {   .name = "ICC_PPI_CACTIVER1_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 1,
+        .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[1]),
+        .writefn = gic_ppi_cactive_write,
+    },
+    {   .name = "ICC_PPI_SACTIVER0_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 2,
+        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[0]),
+        .writefn = gic_ppi_sactive_write,
+    },
+    {   .name = "ICC_PPI_SACTIVER1_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 3,
+        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[1]),
+        .writefn = gic_ppi_sactive_write,
+    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


