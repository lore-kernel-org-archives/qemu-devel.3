Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02FDD1813A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 18:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Pg2-0002ZB-Pz; Mon, 14 Oct 2024 14:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t0Pfw-0002Tk-Qf
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 14:20:12 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t0Pfu-0005RC-Kd
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 14:20:12 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20cb47387ceso21665795ad.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 11:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1728930007; x=1729534807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UPPXSTR3wOX2d3Kap4JswHpnskhQCveCENPklejE6/4=;
 b=Wswh/3bmfadh5/H9iIA5YbK3+fPcJjQQ+ER/KHXxp+XuqoHOI1I73GabZkl5RmmzS3
 T9mhNegtZUmKpOki/mkkg9E63XUc+iQsVZsHaQ8sfGiSgN3Bnc0xRqiQWnvlj3m2dFlR
 W8RCLAmwBwprx8L8ctJ/wJZ3B6qsXPpLe2/j3pXjF3iEKy8c9B5p92XAfJfn/iBg6uqg
 P5zOLlgrmpxUX6Bpxo3F28kccJZokAkqA+Fydak+J7X183rV5SKjMqcBosV2KkzVaBVm
 JMpkP2v97kLeGxf1XQSBParbOhYRlunxDZGD3wT7B+kY13SCVCD0eaLJNBKozTubKPE4
 mUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728930007; x=1729534807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UPPXSTR3wOX2d3Kap4JswHpnskhQCveCENPklejE6/4=;
 b=N6bmJ88DshvfORBrAB/k8kXrnw/KfYThr6riiCcaVRnJKdUWqacShQsLSSjVwA6f+2
 XWwpZbNB7iNCBlGdTt7NuHZFstkiAPtKT1LmlmCzt5st7U7vZKYzklTvbA+TFw/MTvZU
 vqldUsIs8K94wMjR3TX79xgI1jt7/bp24aymfYAZm7ONlrtMlHakVzdB7JR5ap0ofXxC
 i9XuldT8Jx/uB0OVsgSd7kp5AnQrV5Z/nad49kHkp6ks2MJjYLUP5uDHc7bMAeV0LLq3
 Z1OUFg+sMK0Z6qs3PGRqXDHTJ3Ex8okxA5+qP8N3jUHZzkeHrPR0rRn5ZrAOMTJg5rEQ
 zXbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGvmaQf4MEjY7DFaCRWy+XTdo6zTz9baoMNkPw5Ris9PP/UXRWjFUFFdXhzRFewMs71RrKRPHZr70n@nongnu.org
X-Gm-Message-State: AOJu0YxeAm6J+VgnrnDvToZVDN2RbuErUbOndMAdskWBYXV3Vy/Dt9Ag
 BBedID8a8zN0BSqDTz5Uac7/WpdvykVMwV8mqsNqfDwYa/yXKbkVjSG4IY3rHkRb6qd8/TjVS1/
 Ofst4Zg==
X-Google-Smtp-Source: AGHT+IGN772N0NBSM4UDZ1/88GTShc2NPnSWloEM153vVYpfe78NOhjOKKfOFst99yIoulbBX7AS3A==
X-Received: by 2002:a17:902:d4cf:b0:20c:f39e:4c15 with SMTP id
 d9443c01a7336-20cf39e4eb3mr54101405ad.22.1728930007498; 
 Mon, 14 Oct 2024 11:20:07 -0700 (PDT)
Received: from fchang-1826.. (1-169-245-242.dynamic-ip.hinet.net.
 [1.169.245.242]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c375d0csm68964525ad.304.2024.10.14.11.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 11:20:06 -0700 (PDT)
From: frank.chang@sifive.com
To: 
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 qemu-devel@nongnu.org (open list:All patches CC here),
 Tommy Wu <tommy.wu@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v7 3/5] target/riscv: Add Smrnmi CSRs
Date: Tue, 15 Oct 2024 02:19:46 +0800
Message-Id: <20241014181948.1974405-4-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014181948.1974405-1-frank.chang@sifive.com>
References: <20241014181948.1974405-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Tommy Wu <tommy.wu@sifive.com>

The Smrnmi extension adds the 'mnscratch', 'mnepc', 'mncause',
'mnstatus' CSRs.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c      |  5 +++
 target/riscv/cpu.h      |  4 ++
 target/riscv/cpu_bits.h | 11 ++++++
 target/riscv/csr.c      | 82 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5ce6ed31ec..b3195da512 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1017,6 +1017,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
         riscv_trigger_reset_hold(env);
     }
 
+    if (cpu->cfg.ext_smrnmi) {
+        env->rnmip = 0;
+        env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, false);
+    }
+
     if (kvm_enabled()) {
         kvm_riscv_reset_vcpu(cpu);
     }
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8b2a863c50..832556cc34 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -474,6 +474,10 @@ struct CPUArchState {
 #endif /* CONFIG_KVM */
 
     /* RNMI */
+    target_ulong mnscratch;
+    target_ulong mnepc;
+    target_ulong mncause; /* mncause without bit XLEN-1 set to 1 */
+    target_ulong mnstatus;
     target_ulong rnmip;
     uint64_t rnmi_irqvec;
     uint64_t rnmi_excpvec;
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 6df2cbc2be..1a5200d1d5 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -350,6 +350,12 @@
 #define CSR_PMPADDR14       0x3be
 #define CSR_PMPADDR15       0x3bf
 
+/* RNMI */
+#define CSR_MNSCRATCH       0x740
+#define CSR_MNEPC           0x741
+#define CSR_MNCAUSE         0x742
+#define CSR_MNSTATUS        0x744
+
 /* Debug/Trace Registers (shared with Debug Mode) */
 #define CSR_TSELECT         0x7a0
 #define CSR_TDATA1          0x7a1
@@ -627,6 +633,11 @@ typedef enum {
 #define SATP64_ASID         0x0FFFF00000000000ULL
 #define SATP64_PPN          0x00000FFFFFFFFFFFULL
 
+/* RNMI mnstatus CSR mask */
+#define MNSTATUS_NMIE       0x00000008
+#define MNSTATUS_MNPV       0x00000080
+#define MNSTATUS_MNPP       0x00001800
+
 /* VM modes (satp.mode) privileged ISA 1.10 */
 #define VM_1_10_MBARE       0
 #define VM_1_10_SV32        1
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c88ee1265e..b84b436151 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -578,6 +578,17 @@ static RISCVException debug(CPURISCVState *env, int csrno)
 
     return RISCV_EXCP_ILLEGAL_INST;
 }
+
+static RISCVException rnmi(CPURISCVState *env, int csrno)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+
+    if (cpu->cfg.ext_smrnmi) {
+        return RISCV_EXCP_NONE;
+    }
+
+    return RISCV_EXCP_ILLEGAL_INST;
+}
 #endif
 
 static RISCVException seed(CPURISCVState *env, int csrno)
@@ -4566,6 +4577,67 @@ static RISCVException write_upmbase(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException read_mnscratch(CPURISCVState *env, int csrno,
+                                     target_ulong *val)
+{
+    *val = env->mnscratch;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_mnscratch(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mnscratch = val;
+    return RISCV_EXCP_NONE;
+}
+
+static int read_mnepc(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mnepc;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_mnepc(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mnepc = val;
+    return RISCV_EXCP_NONE;
+}
+
+static int read_mncause(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mncause;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_mncause(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mncause = val;
+    return RISCV_EXCP_NONE;
+}
+
+static int read_mnstatus(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mnstatus;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_mnstatus(CPURISCVState *env, int csrno, target_ulong val)
+{
+    target_ulong mask = (MNSTATUS_NMIE | MNSTATUS_MNPP);
+
+    if (riscv_has_ext(env, RVH)) {
+        /* Flush tlb on mnstatus fields that affect VM. */
+        if ((val ^ env->mnstatus) & MNSTATUS_MNPV) {
+            tlb_flush(env_cpu(env));
+        }
+
+        mask |= MNSTATUS_MNPV;
+    }
+
+    /* mnstatus.mnie can only be cleared by hardware. */
+    env->mnstatus = (env->mnstatus & MNSTATUS_NMIE) | (val & mask);
+    return RISCV_EXCP_NONE;
+}
+
 #endif
 
 /* Crypto Extension */
@@ -5070,6 +5142,16 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
                         write_sstateen_1_3,
                         .min_priv_ver = PRIV_VERSION_1_12_0 },
 
+    /* RNMI */
+    [CSR_MNSCRATCH] = { "mnscratch", rnmi, read_mnscratch, write_mnscratch,
+                        .min_priv_ver = PRIV_VERSION_1_12_0               },
+    [CSR_MNEPC]     = { "mnepc",     rnmi, read_mnepc,     write_mnepc,
+                        .min_priv_ver = PRIV_VERSION_1_12_0               },
+    [CSR_MNCAUSE]   = { "mncause",   rnmi, read_mncause,   write_mncause,
+                        .min_priv_ver = PRIV_VERSION_1_12_0               },
+    [CSR_MNSTATUS]  = { "mnstatus",  rnmi, read_mnstatus,  write_mnstatus,
+                        .min_priv_ver = PRIV_VERSION_1_12_0               },
+
     /* Supervisor Trap Setup */
     [CSR_SSTATUS]    = { "sstatus",    smode, read_sstatus,    write_sstatus,
                          NULL,                read_sstatus_i128              },
-- 
2.34.1


