Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1359D2F027
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 13:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkiwG-0007GA-1g; Tue, 27 Jan 2026 08:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vkiw5-00079J-Aw
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:16:50 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vkivz-0004al-TQ
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:16:45 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2a0fe77d141so32778845ad.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 05:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769519802; x=1770124602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dAKoSN7mWcRNGhupTzLMUZwEFuXsEho0xzWOYUXHY/Q=;
 b=GtQuj7ue9C6mo/lWayyY/yFPr4rTYoz2bWbRN6vxJFDHfHn3Nbd64XRRBmeOk971vh
 v0Ot6209g09dtBiW29Vvr+7iTQ3NwXUVqAoVywNBFFUvLFQJ/Y2xW8a5UxYhTPn5AHsG
 BD0nt7/7WUn7F77cEDDKkSM+sJfypoIIROJnhz7/Kv2nUjdDDZ6vVTuY9ICl9Asda9hb
 hjBE8mrL2PHGQrpMn27Cj7p3KP9fGzmcfTCXcj+J7R+p8Ink7sCVMGPDcAZJ0HrGpuax
 Q2oYkKe67Lpr+KTfoHCdrtFMdl4fy4OhFEQmK8iAue+caf5YiWkw+L0o7mh/y0Im2KeA
 SC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769519802; x=1770124602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dAKoSN7mWcRNGhupTzLMUZwEFuXsEho0xzWOYUXHY/Q=;
 b=kAoxe6Klq5YpGtYLpwXvGuS0CFVwR9lg+0MsjU+rnklL1WsQIo4GqXq9ed24tXyCsO
 59fMFN0MkzE+yxTZ3EDzBNG3fTRe8WISH2dJbvNbjYTti7q0M3i+4nfdzXvv8DO3nNJa
 /0oFkdR68cxkRkobU3E7MalSxX+N7IaW/CBayHmhUTuMSq87LSTinlTwYGFkKL4SXbfV
 w6J+l5x/NXOjkijQxOXIdf0xhDPUhSxXLViw7tETSoxTQi2KYgc9Jb83qrGL94BY6cyS
 PoMz2/vrO8/phHYGx7r28utPUVt5l4OKD/S+vBt1vecJoAP5qvzbcxxscCJA6KzcmfVI
 Gyig==
X-Gm-Message-State: AOJu0YxoKu3Z0A/SNm/wFjtTkYUGlYdF4EF6XbHAAuCGzAAn1t5M+shw
 A+5MlDbwpYbT0oPeyZ+ZVmDckp3HLoJJlHb1pzTXaOHgnZYbnSQAenQY
X-Gm-Gg: AZuq6aLqITP/aMV5vOIRMs3DsuB6uKX6R2SiONyoLq62U2CFdRjQA+iQYiMj2jLh2BU
 DEElCBXKvty/WVLkRR6BoO6uWUQjNZp4dcVcBaK/HeUcH/FiCWh0YQAArbN3XJkX9U8CjOQq20J
 9x6JAYZg59fHa1jxUZgZpea+4ijjhM66KWRzaW6tb1O8N6MSoYUd/W/tRUESrIm8a5rMLfQgQfc
 IuhjUy0Dz2xT6ujs3NaDDuSfU1Xman3h3f0hYVvVngukGB3YAEH4yKpm6ouXvnN/R4jlab38VuX
 lorvKDoGOzuhdWIJb83D/ralDE63aXw5onDwZaFSgw9bu4nKwDTBpt5+vQF+Cm/NBpD9+zWYZfS
 Yp0r6d5Cdj6tCD/vtmXgGD2Hj306lfoRmfUuQXcmjqM1w7fbkxKcqGuTRYLQERFvx0yXUlhT7tg
 VSXSMWtjKpmvh4SCwDEft0P2uwR6h65pPUQWd1b9BISor3WHlNcgDCC+WoF8+8nRx3rNphKw==
X-Received: by 2002:a17:902:d552:b0:29f:2b9:6cca with SMTP id
 d9443c01a7336-2a870ddd6b3mr17142255ad.44.1769519802264; 
 Tue, 27 Jan 2026 05:16:42 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.23.113])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802fb03b4sm117164345ad.82.2026.01.27.05.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 05:16:41 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 hust-os-kernel-patches@googlegroups.com,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v3 3/7] target/riscv: add sdext Debug Mode helpers
Date: Tue, 27 Jan 2026 21:15:47 +0800
Message-ID: <7efc36a07cf762a62d151cd257f3e3d83442abad.1769517768.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769517768.git.chao.liu.zevorn@gmail.com>
References: <cover.1769517768.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x644.google.com
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

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Add helpers to enter/leave Debug Mode and to update dpc/dcsr.
Model resume without a Debug Module by leaving Debug Mode at
cpu_exec_enter and continuing from dpc.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/cpu.h         |  3 ++
 target/riscv/cpu_helper.c  | 87 ++++++++++++++++++++++++++++++++++++++
 target/riscv/debug.c       |  5 +++
 target/riscv/tcg/tcg-cpu.c | 14 ++++++
 4 files changed, 109 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a474494dff..4a2509e002 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -624,6 +624,9 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 char *riscv_isa_string(RISCVCPU *cpu);
 int riscv_cpu_max_xlen(RISCVCPUClass *mcc);
 bool riscv_cpu_option_set(const char *optname);
+void riscv_cpu_enter_debug_mode(CPURISCVState *env, target_ulong pc,
+                                uint32_t cause);
+void riscv_cpu_leave_debug_mode(CPURISCVState *env);
 
 #ifndef CONFIG_USER_ONLY
 void riscv_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index dd6c861a90..05a991fccc 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -136,6 +136,93 @@ bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
 #endif
 }
 
+#ifndef CONFIG_USER_ONLY
+static bool riscv_sdext_enabled(CPURISCVState *env)
+{
+    return riscv_cpu_cfg(env)->ext_sdext;
+}
+#endif
+
+void riscv_cpu_enter_debug_mode(CPURISCVState *env, target_ulong pc,
+                                uint32_t cause)
+{
+#ifndef CONFIG_USER_ONLY
+    if (!riscv_sdext_enabled(env)) {
+        return;
+    }
+#endif
+    env->debug_mode = true;
+    env->dpc = pc & get_xepc_mask(env);
+    env->dcsr &= ~(DCSR_CAUSE_MASK | DCSR_PRV_MASK | DCSR_V);
+    env->dcsr |= ((target_ulong)(cause & 0x7)) << DCSR_CAUSE_SHIFT;
+    env->dcsr |= env->priv & DCSR_PRV_MASK;
+    if (env->virt_enabled && riscv_has_ext(env, RVH)) {
+        env->dcsr |= DCSR_V;
+    }
+#ifndef CONFIG_USER_ONLY
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        if (env->elp) {
+            env->dcsr |= DCSR_PELP;
+        } else {
+            env->dcsr &= ~DCSR_PELP;
+        }
+        env->elp = false;
+    }
+#endif
+}
+
+void riscv_cpu_leave_debug_mode(CPURISCVState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    if (!riscv_sdext_enabled(env)) {
+        return;
+    }
+#endif
+    target_ulong new_priv = env->dcsr & DCSR_PRV_MASK;
+    bool new_virt = riscv_has_ext(env, RVH) && (env->dcsr & DCSR_V);
+
+    if (new_priv > PRV_M) {
+        new_priv = PRV_M;
+    }
+    if (new_priv == PRV_M) {
+        new_virt = false;
+    }
+#ifndef CONFIG_USER_ONLY
+    if (new_priv == PRV_S && !riscv_has_ext(env, RVS)) {
+        new_priv = PRV_M;
+        new_virt = false;
+    } else if (new_priv == PRV_U && !riscv_has_ext(env, RVU)) {
+        new_priv = riscv_has_ext(env, RVS) ? PRV_S : PRV_M;
+        new_virt = false;
+    }
+#endif
+
+    env->debug_mode = false;
+    riscv_cpu_set_mode(env, new_priv, new_virt);
+
+#ifndef CONFIG_USER_ONLY
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        env->elp = cpu_get_fcfien(env) && (env->dcsr & DCSR_PELP);
+        env->dcsr &= ~DCSR_PELP;
+    }
+#endif
+
+    if (new_priv != PRV_M) {
+        env->mstatus = set_field(env->mstatus, MSTATUS_MPRV, 0);
+    }
+#ifndef CONFIG_USER_ONLY
+    if (env_archcpu(env)->cfg.ext_smdbltrp && new_priv != PRV_M) {
+        env->mstatus = set_field(env->mstatus, MSTATUS_MDT, 0);
+    }
+    if (env_archcpu(env)->cfg.ext_ssdbltrp && (new_priv == PRV_U || new_virt)) {
+        env->mstatus = set_field(env->mstatus, MSTATUS_SDT, 0);
+        if (new_virt && new_priv == PRV_U) {
+            env->vsstatus = set_field(env->vsstatus, MSTATUS_SDT, 0);
+        }
+    }
+#endif
+}
+
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
 {
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 5664466749..5877a60c50 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -927,6 +927,11 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
 
+    /* Triggers must not match or fire while in Debug Mode. */
+    if (env->debug_mode) {
+        return;
+    }
+
     if (cs->watchpoint_hit) {
         if (cs->watchpoint_hit->flags & BP_CPU) {
             do_trigger_action(env, DBG_ACTION_BP);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 799e907991..1bdef55d9a 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -266,6 +266,19 @@ static vaddr riscv_pointer_wrap(CPUState *cs, int mmu_idx,
     }
     return extract64(result, 0, 64 - pm_len);
 }
+
+static void riscv_cpu_exec_enter(CPUState *cs)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+
+    if (!cpu->cfg.ext_sdext || !env->debug_mode) {
+        return;
+    }
+    target_ulong pc = env->dpc;
+    riscv_cpu_leave_debug_mode(env);
+    env->pc = pc;
+}
 #endif
 
 const TCGCPUOps riscv_tcg_ops = {
@@ -282,6 +295,7 @@ const TCGCPUOps riscv_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = riscv_cpu_tlb_fill,
     .pointer_wrap = riscv_pointer_wrap,
+    .cpu_exec_enter = riscv_cpu_exec_enter,
     .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
     .cpu_exec_halt = riscv_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-- 
2.52.0


