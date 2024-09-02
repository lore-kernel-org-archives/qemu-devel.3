Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCA9CD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 07:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl1Gb-00005e-W0; Mon, 02 Sep 2024 03:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1sl1GZ-0008Ne-2t
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 03:14:23 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1sl1GX-0003il-7I
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 03:14:22 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3df13906bcdso1554487b6e.0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 00:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1725261260; x=1725866060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1oI6nGeEdG0xhvDYynLlNJXm9hUsd9zbhDLS15UCJSI=;
 b=m1nHOFLTYiSfN+EKbsGMK0zHek6c+isX39zy1shDluu20WycvFieoNgZGBuA7RigQB
 K9fwo3SGOzP269NcI3+eLQUUW20Klg+Rj+I4iAizl+xJPZ++xPP6G27FLnuVIk/pPsWL
 5D+PBzFqI3Ulu89ccO7R27MScUPTt/PCHBEfPuGePzB5VeembHLlyZ/gyZyZ6fWuycSi
 cWs0UgOn88YtG8Jf4dotEZpbd6w9CCUBTyTOoTr2Y9l2n9VQtCEjKxjtvLQclbQU7HBk
 kA9vrHvWmCQZbKGVubayR7bDtl2iVlOlm/zZGFhfXgiKJSZHnWexpjhZ9S33LBON4LGZ
 /NJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725261260; x=1725866060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1oI6nGeEdG0xhvDYynLlNJXm9hUsd9zbhDLS15UCJSI=;
 b=aKdNg8ZSRgaTTtMxsvm/uoKDXr/tmPhczb8NTiGiKbKkZLnrWJsBFT8N7OErxiYQzI
 WpeNYao7JqC1dHZx+He7Qhc73oArcfYFxWRbK1/vd6CUkNO8NoC42DwW2HtPTapFLLvf
 4majppzQNLUH1rtKkPQIsc/cs+97oSwo/pkSP/i3Q9mIOgHHAwnC2DfTZDCUWAtyweWD
 36ryPjvr/wu7zsQf9d6dMxM8A7srFlvaSkBiGMPbBLT/3hyWmptYnyHQYbiPxstGhBNU
 LcgCNrjiTas3WvcuG+VfjyZ4+blREEumfH3oFUcx39rqUHwxBk3KCphgpwXHhjSUb9QS
 oGCQ==
X-Gm-Message-State: AOJu0YwTNgjEk37M3bK3/JzHutdPej8fAU/CPP3LpouJADj/rJ/yhdMi
 v7UwZYQis847N2PbFsZ0tUsp9BxXLMjugiZgLEJibjH5zN0BycCgkH2gs2RLd2HkAIS03OpGM8K
 5yLiZf2BBPkqAoC2RflD+OIJCR1x8UHfDn5XLXVEtHgGHcxZyNJuqz+lfMWMVWOYD+2ParVlgAz
 /yB8Ud4lzh9EOmJBp2Kf+vKCLdzcDN6W1e11nnpw==
X-Google-Smtp-Source: AGHT+IHbLe+Tyxmoyf/TOS2s+p/qYkWCK8X9IEp27gwNP5h5aq8imhVpkPM99N3C8hj8mY5g7WgiuQ==
X-Received: by 2002:a05:6808:2287:b0:3dc:4223:898a with SMTP id
 5614622812f47-3df1b72c270mr7419478b6e.14.1725261259450; 
 Mon, 02 Sep 2024 00:14:19 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d22e743252sm6793331a12.15.2024.09.02.00.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 00:14:19 -0700 (PDT)
From: Tommy Wu <tommy.wu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: frank.chang@sifive.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 alistair23@gmail.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, ajones@ventanamicro.com,
 Tommy Wu <tommy.wu@sifive.com>
Subject: [PATCH v6 3/5] target/riscv: Add Smrnmi CSRs.
Date: Mon,  2 Sep 2024 00:13:56 -0700
Message-Id: <20240902071358.1061693-4-tommy.wu@sifive.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240902071358.1061693-1-tommy.wu@sifive.com>
References: <20240902071358.1061693-1-tommy.wu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=tommy.wu@sifive.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The Smrnmi extension adds the `MNSCRATCH`, `MNEPC`, `MNCAUSE`,
`MNSTATUS` CSRs.

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
index 2f64b3df22..98e6940e93 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1024,6 +1024,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
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
index d8ad04ec31..a84e719d3f 100644
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
index e14b654c35..da1723496c 100644
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
index ea3560342c..e5de72453c 100644
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
2.39.3


