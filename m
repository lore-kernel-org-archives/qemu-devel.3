Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CA4C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfM5-0006WY-1n; Fri, 17 Jan 2025 00:57:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfM3-0006Sg-PM
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:15 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfM2-000617-2u
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:15 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2156e078563so22185075ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093432; x=1737698232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fcr1IoIcy6NWwnOfv41+tMI4VaW9SB+1Bq+lz34Vqmo=;
 b=Vh1hSmbNJmF5/9zGNyY//Cw60A8BlHJ8lWqQ9ZOUm1YWpVqlw+zjFgFz1yZdVGcr1V
 mxGdZICWlEJazc2VgOnIdziC1a6anxV48cVLhAUXhGWs5bgj1A490mJOPwspKtdzB0Qm
 3LTaiocpEcQGGMJkBilhmqNs5HRJEIZslVl2WgYGlbGF+ux8s1UEQ0VyVO6IE18c2ZYw
 aKvvOWltEbHNQML/g2noKI2nuk60BjiAtbILHPQIB97VPfw6oFo7ijQ0YfHZtafwBFKQ
 /8UhwmMV0y1SiEzwqikWqWBtuWXegMB58I/CWL4hpZfoLYicoIvrMEjrcxwWOQPvioIA
 NZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093432; x=1737698232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fcr1IoIcy6NWwnOfv41+tMI4VaW9SB+1Bq+lz34Vqmo=;
 b=SEyHCOPIp6VrW3DVcGYgDMmuL4OhUPsOUS9oZOiA45ALRKxqfkS7QfEK6u2r+JCDSh
 ocXIozyoKvTeyL0z1oXfxGvH9JqP6XFsQ/Tl7lnkBWjcK3aZkv/WFegrdtcohV1+AWoS
 rJa85idkR+OEuDgIy0nLvuggqPR9W/mCulKF+th5kAbGy2T2ahgZrBeatIczzM8H/1+4
 0Zlhwezy/eCutJ5mHOjeCOjM4/azCK4f1gjPhfzIHvSijKAXjDvxbp197drQCgzClb2u
 M/PivW+q78Y3TtHhaE9NBw+YW+jFNWaxCcJIRLVRfqEaPJDPbdSx28HJ74+D2BQgSlnQ
 ZFww==
X-Gm-Message-State: AOJu0YyMHZaFM7WSmbSBmdQr4Jy/x3Slf18NbkI0aE8mt56u+GXnhuqv
 Zn0p+upcWeemrG0asJOOYRiqOu1PNOuRckCdkVyE7dTa5kNZo+DRHxjnRg==
X-Gm-Gg: ASbGnctX8IbPC/7T+dQmVwvyIbvUwMdTBrVSE1NqqjXkCs8LiPKZSGuZa7Cmu4smgxM
 eaQkdXwUECl7bK8YTnSTyEJuJswPJOG7Ra5Ggsjn3n9pT2hUsiVUmG4KfWettdhDHtH8nE+C6LT
 KxgVL3K3fugIgwNkgVGqWiXDq7sVODwoiP2znnctqp3lvhI40jPtsG2lYLRrz6cZFsYNGzpN9hz
 vo8iPjaXE9X3Y4lITEBaH7LY9/WLX32O9B1sdfbNzwMaoFEPrS9vhBISb7cJ7dkm9FAz9aAoimN
 0JhTdDAmqz8N403GDcN0u+HITQUqB+b4rzERe0vXJ+nrUWfqUI35zAS/1DDw
X-Google-Smtp-Source: AGHT+IFrlyBzij6fMvcbeUA/kHJfYCL+Jv2SrnB4VTy8fDHbz9reUszwJ+3yx4fywcZ5bEnLvjKNrg==
X-Received: by 2002:a17:903:2b05:b0:215:4757:9ef3 with SMTP id
 d9443c01a7336-21c352c7b68mr22577865ad.9.1737093432533; 
 Thu, 16 Jan 2025 21:57:12 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:57:12 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tommy Wu <tommy.wu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/50] target/riscv: Add Smrnmi CSRs
Date: Fri, 17 Jan 2025 15:55:23 +1000
Message-ID: <20250117055552.108376-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Message-ID: <20250106054336.1878291-3-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h      |  7 ++++
 target/riscv/cpu_bits.h | 11 ++++++
 target/riscv/cpu.c      |  5 +++
 target/riscv/csr.c      | 82 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 105 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5e7152200f..5eaf9da1f7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -480,6 +480,13 @@ struct CPUArchState {
     uint64_t kvm_timer_state;
     uint64_t kvm_timer_frequency;
 #endif /* CONFIG_KVM */
+
+    /* RNMI */
+    target_ulong mnscratch;
+    target_ulong mnepc;
+    target_ulong mncause; /* mncause without bit XLEN-1 set to 1 */
+    target_ulong mnstatus;
+    target_ulong rnmip;
 };
 
 /*
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 797dd6985b..ba6fc546c4 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -353,6 +353,12 @@
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
@@ -604,6 +610,11 @@ typedef enum {
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
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d9eb2c04c3..66193cd2f6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1127,6 +1127,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
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
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 6b8cef52fe..af9766759a 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -590,6 +590,17 @@ static RISCVException debug(CPURISCVState *env, int csrno)
 
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
@@ -4376,6 +4387,67 @@ static RISCVException write_mcontext(CPURISCVState *env, int csrno,
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
@@ -4883,6 +4955,16 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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
2.47.1


