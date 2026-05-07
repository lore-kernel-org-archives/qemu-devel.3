Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6A3CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11f-00041S-9C; Thu, 07 May 2026 11:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11d-0003zL-0E
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:33 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11b-0003vk-8j
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:32 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso9856665e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169150; x=1778773950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aWyOb2Ci72/c/DPPe8R7R972eeRddihClu5NChd3Q54=;
 b=bexv15/JbUTOvDVInyNKMv+bfXs+5rr+1FxYey+ppyxnt90cAqiwk+u9J1hH96kTLc
 338QSPqkvCvJQnX971m7GFHK3awcvqLHuxlcxk1ZJ7CR12V341DCcZ+YCQljUtoAonzE
 3YrtOQI3kMEo1acPL0Eih0QypwpkEZAm6RPQK2rfoA0ey+9IBLq2pYL8il+K29TWFdj1
 xtnn0ie/+4JfDqVfv5UoNRr8DD+FZ/5rRvXv7BtJ4TTRPg/3N1BIy3rv99wpB1UGyobn
 nEQgxiU5bEeVw7p5FVYDGjyHEgbE70/VYOA0YLLfPsuADPotLI+1vzVn6Qpr3CS2PBzO
 AZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169150; x=1778773950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aWyOb2Ci72/c/DPPe8R7R972eeRddihClu5NChd3Q54=;
 b=gmfSteBjy4n4q0P9JZrg86+r6Tf06FtDwSq7CC+MyYb7RgJYeNHOpIMwZXhoZPuiPq
 tIWSZ0u3etyKGAJ6IGz2z58FNP5vlDjIpQ8/TyOzdA8+qByFOBUeXPiLq7a7M8Kn5t+0
 Fr6Nlq3cY01d3zgk7HOLG70r6/gCLtH9heC86LHj8siAEzTPzGSKWbWsIsmCel4oyrHC
 yNcqHKM1Z573mtN41JK0XE4204ruYsAhNiRX7JIfZdU+VKT8uoAIfX7R0FQzWWbYq+j5
 mLbJ4CDOsbz7uMACQqrq9b9aWDM+D4JudssYOLsPK/cCujYFBMCct8aiVTNp/kGSUmH3
 MIFA==
X-Gm-Message-State: AOJu0YxHXYPhlbf8xGaOnjpvUAmikigJGsQQ0ySXs8BKLIfbdH1alJzR
 gi2IF0uHWPRhuncyJahTL14Q1FsPa9LLjq+io2FOD3ne88O1EoZvH/GtM99WjSHGPNkjWcxSZGt
 Z4/VM
X-Gm-Gg: AeBDievD+zqiOuk6A6nzqxxOPhsq4U0aqJnbd+3thZAvAbZ+MZW6V5BVyiBRMFw+/rt
 Zd5Y48Asts7wcqNMro3MM0bJPfO0kUjv8swFBXBSSnRUOLH6IKtDH60Sk4O2yODOP3OPf/lzEGt
 xoJ8wuf2PRfbVBo0gAT2yhth96DNk2/5SrW80tbvxvvveoo7jPNdcIyP8X9pNXac8h6whmj2jjH
 8n5WiAwJNZd43ygyCIyoV0A0Xqrh0WeJ8MkyGdnUMb6dAZK+v+DrRXqLm+rFBh/N6y923V+WyJd
 dah8xpRID7j5VXZbc2KkVWWIA1DU8DAsWyBiwXUsigRhRvwbqmvT9JPf8mav/yhIhpCsb0edqRF
 vbBv/8pUKWV88T7L0u+dD5qeZSZIcRVmUFEuaZQTq8fXRWHfqZzbxySlcdVDVQsu/WfI3A2IHw4
 2a9UQgSN3c2Lfjw7VDHp8cH0dbFUFT3Z9pujgnB0MGXHmvNDW7BPyB1j93O6NDevXAFwWjv+Gf0
 Xyzf/mHZ0wQM2nxcPckISzAPZmrKFaO5hhQ49xgWQ==
X-Received: by 2002:a05:600c:a111:b0:48a:7b7b:c2b9 with SMTP id
 5b1f17b1804b1-48e51e0bb44mr110786115e9.4.1778169149417; 
 Thu, 07 May 2026 08:52:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/67] target/arm: GICv5 cpuif: Implement ICC_IAFFIDR_EL1
Date: Thu,  7 May 2026 16:51:21 +0100
Message-ID: <20260507155154.1886557-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

The CPU system register ICC_IAFFIDR_EL1 is a read-only register that
tells the guest what the affinity ID of that CPU is.

Implement this register.  In real hardware using the stream protocol,
the IRS tells the CPU its IAFFID using a DownstreamControl command as
part of the handshake process when the IRS-CPU link is brought
online.  Our analogue of this is to pass the IAFFID as an extra
argument to gicv5_set_gicv5state().  (We could have the CPU call into
the GIC every time to ask for the value, but this would mean we had
to search the cpus[] array for the right CPU to return its IAFFID.)

Note that we don't put the IAFFID into the gicv5_cpuif sub-struct,
because that part of the CPU struct is zeroed on reset, and we must
keep the IAFFID across reset (we only set it up when the GIC device
is created).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-35-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5_common.c         |  5 +++--
 include/hw/intc/arm_gicv5_stream.h |  3 ++-
 target/arm/cpu.c                   |  5 +++--
 target/arm/cpu.h                   |  2 ++
 target/arm/tcg/gicv5-cpuif.c       | 11 +++++++++++
 5 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 180fe338a4..b155486af6 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -173,9 +173,10 @@ static void gicv5_common_realize(DeviceState *dev, Error **errp)
     }
 
     for (int i = 0; i < cs->num_cpus; i++) {
-        if (!gicv5_set_gicv5state(cs->cpus[i], cs)) {
+        if (!gicv5_set_gicv5state(cs->cpus[i], cs, cs->cpu_iaffids[i])) {
             error_setg(errp,
-                       "CPU %d does not implement GICv5 CPU interface", i);
+                       "CPU %d (IAFFID 0x%x) does not implement GICv5 CPU interface",
+                       i, cs->cpu_iaffids[i]);
             return;
         }
     }
diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
index 670423fdad..136b6339ee 100644
--- a/include/hw/intc/arm_gicv5_stream.h
+++ b/include/hw/intc/arm_gicv5_stream.h
@@ -20,6 +20,7 @@ typedef struct GICv5Common GICv5Common;
  * gicv5_set_gicv5state
  * @cpu: CPU object to tell about its IRS
  * @cs: the GIC IRS it is connected to
+ * @iaffid: the IAFFID of this CPU
  *
  * Set the CPU object's GICv5 pointer to point to this GIC IRS.  The
  * IRS must call this when it is realized, for each CPU it is
@@ -28,7 +29,7 @@ typedef struct GICv5Common GICv5Common;
  * Returns true on success, false if the CPU doesn't implement the
  * GICv5 CPU interface.
  */
-bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs);
+bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs, uint32_t iaffid);
 
 /*
  * The architected Stream Protocol is asynchronous; commands can be
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index de9ba141bd..29346609e4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1159,16 +1159,17 @@ static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 }
 
 #ifndef CONFIG_USER_ONLY
-bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs)
+bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs, uint32_t iaffid)
 {
     /*
      * Set this CPU's gicv5state pointer to point to the GIC that we are
-     * connected to.
+     * connected to, and record our IAFFID.
      */
     if (!cpu_isar_feature(aa64_gcie, cpu)) {
         return false;
     }
     cpu->env.gicv5state = cs;
+    cpu->env.gicv5_iaffid = iaffid;
     return true;
 }
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index aa89b457b9..c7c410bed7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -818,6 +818,8 @@ typedef struct CPUArchState {
     void *gicv3state;
     /* Similarly, for a GICv5Common */
     void *gicv5state;
+    /* For GICv5, this CPU's IAFFID */
+    uint64_t gicv5_iaffid;
 #else /* CONFIG_USER_ONLY */
     /* For usermode syscall translation.  */
     bool eabi;
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 8cf09791c1..005e2fa8d2 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -226,6 +226,17 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.icc_icsr_el1),
         .resetvalue = 0,
     },
+    {   .name = "ICC_IAFFIDR_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 5,
+        .access = PL1_R, .type = ARM_CP_NO_RAW,
+        /* ICC_IAFFIDR_EL1 holds the IAFFID only, in its low bits */
+        .fieldoffset = offsetof(CPUARMState, gicv5_iaffid),
+        /*
+         * The field is a constant value set in gicv5_set_gicv5state(),
+         * so don't allow it to be overwritten by reset.
+         */
+        .resetfn = arm_cp_reset_ignore,
+    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


