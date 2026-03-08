Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978ADF5513A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8PP-0006ab-M9; Sun, 08 Mar 2026 03:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8PO-0006Zr-21
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:18:38 -0400
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8PM-0001Em-AB
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:18:37 -0400
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2be3bdfda8eso3686710eec.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954315; x=1773559115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xp85ow5kpVEIh7GcBSWk2I9/oWDLBJKDiTKs7ARoRw=;
 b=SWQrwajeQgQrO3U8qG73hYzhoxIIWO1JKgckolTj2Gp3wqyovDm2l0U76AOxhVhNNC
 oW6Msz42nPERA30TDY48ELGbsf7JoaN1r9Gb1f+HBirHHWjKq838/9hFk90wfZ2zW0qp
 t/X5ox/cn8+3dpFjY+yA9DBQ1Q37XPdc4xfH9/Ah811KpCAJkk4agkb5QW25B/ZBloT8
 AXzNDwGOsVDWa3oakV6iR04m3uvtd5mXyWsuYMwbQe3BYfi3vEIJeH9T/2/A0kt2/Iv/
 Rh5pkIEMGZ1CufHFPdsc9SsMq7Otu8kgrJNak+i4dTit9R0JSArnzSspkMF1bIvcwxHe
 1xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954315; x=1773559115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+xp85ow5kpVEIh7GcBSWk2I9/oWDLBJKDiTKs7ARoRw=;
 b=TSuvTLEjDPXEgPO8zEAao+furBiqvn1QQG/7lz+9gA6p4AS0WZhlTALdjs63Fq6nvV
 FIcaQI/IkUgsxZqfduKzTYZrRpLPM2n03JwX14edPWz5LCdTt/vOmoC8e63iujBlS/mC
 JtAkPUCuyQLd1+lyPQt/B99hBFbW3+W4ypQ2Y1opYo3Kx0qHSI8AG80jV7pXgCsiLj/c
 0ny06bTsK4Z/R0Wr/JkaGBKlzCJhM2uoIqrpLVGUfCVo+zG2/TXN6D/QcXCeL16i5Hd9
 o2rpT2G3Xu4YV3djxoTX/0ZSsWxMTR8TvUXUDivZnravOwqJOEq67G8uW/cqx1uj9S0X
 XF+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvTWKNKnIskGRjyh8OEsN14wrIQdlCja6Lm/FdKTnZGX4y2xgWOmKe0msD1KLpd7h4xLGGUO4vR3d4@nongnu.org
X-Gm-Message-State: AOJu0YxZg2iPdAwLK9lHey1ppOjOYNGUzjwNN6/jGGUrcJF4s2wD3Grf
 mWJxoCemJG+pPpLYTBafRMSQlcVp+aPfftUPf3cSfdtZFLm85/0+ZwqV
X-Gm-Gg: ATEYQzx6DsjIAdEaqayk5nexYvNmpQOMUTWEHan479j7/jX0nHvBX10ihlnuBVIHHiN
 S3UQENscmI4cAT9m+YcIi23KNcy0kosoOntrs3Z3+AovfjnJbYX7OaofRtPoszxOH/MixgzmEUc
 BbG5zMZLrGrE571yHEOSuNQgeCLBCtJUNEiaIwUr/L3/M01s94s0pwa2Hy7AojtRuU+vzfbqqeg
 nbD8dw7qs85LBSm2lf1cQBwn8CtjTw0fgazMYTKRa4vjeG0bI0cVocaXBw1jHmaQAE/jBVjsipY
 282HQ9vFgn8LHUVkbRDlndLEP/KupVz+79fOLZKQL36eUPYhDg1DXcLfGkAkYtsuX1+aJrkCsBL
 YEm2yzQLztGIJ3l7kAO1QrIPrl3seIpfPTBbdPm4zLq7IqCE6ZKpmXOdZWxXsxhsKeA+V14xqpk
 U734p0M+HpXRAxfVkvjBIBcpCwaf/CITpzK0fLsMlyKcfUFW/Bi2fzDBV+yWwcOEltEDWXRp3ih
 VCfLhl6KtsUKnDuSrBgQlZR4i0=
X-Received: by 2002:a05:7300:5711:b0:2be:1946:857e with SMTP id
 5a478bee46e88-2be4de8fc67mr2577367eec.12.1772954314717; 
 Sat, 07 Mar 2026 23:18:34 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:18:33 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 01/28] target/riscv: track pending Debug Module halt
 requests
Date: Sun,  8 Mar 2026 15:17:04 +0800
Message-ID: <4baa12f9284a5a4fc543ae7c82cc26814a10c973.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1344.google.com
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

Track a pending board-level Debug Module halt request in the CPU
state so machine code can queue haltreq and reset-haltreq before
the hart reaches the normal debug entry path.

Add the CPU-side helper, the GPIO input, and the migration state
needed to preserve the pending request and its debug cause across
machine resets and VM state transfers. Later patches will route
this state through the regular interrupt and Debug Mode entry
flow.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/cpu.c      | 68 +++++++++++++++++++++++++++++++++++++++++
 target/riscv/cpu.h      |  5 +++
 target/riscv/cpu_bits.h |  1 +
 target/riscv/machine.c  |  2 ++
 4 files changed, 76 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 470c2d5b39..fce778a67d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -784,6 +784,8 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 
 #ifndef CONFIG_USER_ONLY
     env->debug_mode = false;
+    env->dm_halt_request = false;
+    env->dm_halt_cause = DCSR_CAUSE_HALTREQ;
     env->dcsr = DCSR_DEBUGVER(4);
     env->dpc = 0;
     env->dscratch[0] = 0;
@@ -1086,6 +1088,70 @@ static void riscv_cpu_set_nmi(void *opaque, int irq, int level)
 {
     riscv_cpu_set_rnmi(RISCV_CPU(opaque), irq, level);
 }
+
+/*
+ * Debug cause priority (higher to lower), per Debug Spec v1.0 Table 4.2:
+ * reset-haltreq, halt-group, haltreq, trigger, ebreak, step.
+ */
+static int riscv_debug_cause_priority(uint32_t cause)
+{
+    switch (cause & 0x7) {
+    case DCSR_CAUSE_RESET:
+        return 0;
+    case DCSR_CAUSE_GROUP:
+        return 1;
+    case DCSR_CAUSE_HALTREQ:
+        return 2;
+    case DCSR_CAUSE_TRIGGER:
+        return 3;
+    case DCSR_CAUSE_EBREAK:
+        return 4;
+    case DCSR_CAUSE_STEP:
+        return 5;
+    case DCSR_CAUSE_OTHER:
+        return 6;
+    default:
+        return 7;
+    }
+}
+
+static bool riscv_debug_cause_is_higher(uint32_t new_cause,
+                                        uint32_t current_cause)
+{
+    return riscv_debug_cause_priority(new_cause) <
+           riscv_debug_cause_priority(current_cause);
+}
+
+void riscv_cpu_request_dm_halt(RISCVCPU *cpu, uint32_t cause)
+{
+    CPURISCVState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+
+    if (!riscv_cpu_cfg(env)->ext_sdext) {
+        return;
+    }
+
+    if (env->dm_halt_request &&
+        !riscv_debug_cause_is_higher(cause, env->dm_halt_cause)) {
+        return;
+    }
+
+    env->dm_halt_request = true;
+    env->dm_halt_cause = cause & 0x7;
+    cpu_interrupt(cs, CPU_INTERRUPT_DM_HALT);
+}
+
+static void riscv_cpu_dm_halt_req(void *opaque, int irq, int level)
+{
+    RISCVCPU *cpu = RISCV_CPU(opaque);
+    CPURISCVState *env = &cpu->env;
+
+    qemu_log_mask(CPU_LOG_INT, "dm_halt_req: level=%d ext_sdext=%d\n",
+                  level, riscv_cpu_cfg(env)->ext_sdext);
+    if (level) {
+        riscv_cpu_request_dm_halt(cpu, DCSR_CAUSE_HALTREQ);
+    }
+}
 #endif /* CONFIG_USER_ONLY */
 
 static bool riscv_cpu_is_dynamic(Object *cpu_obj)
@@ -1106,6 +1172,8 @@ static void riscv_cpu_init(Object *obj)
                       IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
     qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
                             "riscv.cpu.rnmi", RNMI_MAX);
+    qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_dm_halt_req,
+                            "dm-halt-req", 1);
 #endif /* CONFIG_USER_ONLY */
 
     general_user_opts = g_hash_table_new(g_str_hash, g_str_equal);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0d6b70c9f0..6fb255c7c3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -481,6 +481,10 @@ struct CPUArchState {
     target_ulong dpc;
     target_ulong dscratch[2];
 
+    /* Pending Debug Module halt request from the board-level controller. */
+    bool dm_halt_request;
+    uint8_t dm_halt_cause;
+
     uint64_t mstateen[SMSTATEEN_MAX_COUNT];
     uint64_t hstateen[SMSTATEEN_MAX_COUNT];
     uint64_t sstateen[SMSTATEEN_MAX_COUNT];
@@ -642,6 +646,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
 uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
                               uint64_t value);
+void riscv_cpu_request_dm_halt(RISCVCPU *cpu, uint32_t cause);
 void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
 void riscv_cpu_interrupt(CPURISCVState *env);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index bb59f7ff56..01ec2a69c4 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -1177,6 +1177,7 @@ typedef enum CTRType {
 
 /* RISC-V-specific interrupt pending bits. */
 #define CPU_INTERRUPT_RNMI                 CPU_INTERRUPT_TGT_EXT_0
+#define CPU_INTERRUPT_DM_HALT              CPU_INTERRUPT_TGT_INT_0
 
 /* JVT CSR bits */
 #define JVT_MODE                           0x3F
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index ddd0569d9e..e811abc868 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -263,6 +263,8 @@ static const VMStateDescription vmstate_sdext = {
         VMSTATE_UINTTL(env.dcsr, RISCVCPU),
         VMSTATE_UINTTL(env.dpc, RISCVCPU),
         VMSTATE_UINTTL_ARRAY(env.dscratch, RISCVCPU, 2),
+        VMSTATE_BOOL(env.dm_halt_request, RISCVCPU),
+        VMSTATE_UINT8(env.dm_halt_cause, RISCVCPU),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.53.0


