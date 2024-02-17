Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79872C48BF8
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 00:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb89j-0003RV-BE; Fri, 16 Feb 2024 19:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rb89g-0003Pm-JD
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:02:08 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rb89Q-0007w3-95
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:02:08 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e11a779334so1703518b3a.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 16:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708128110; x=1708732910;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qs4/5s/0Lq9OL8A9BgObbv04EylJgBGSxtSlF1aloGo=;
 b=mfKL6D4Riv6B1KiwpYd8VNpPsrgThhifjOAuj93wKBbgRTcn3ZW5OF1Khlv9KD5mj+
 a6HPIh9S4qYqjt4vGVfvm2/LoMzE1X5ALbc8PXaXFJ6b+9tBaOVwu4Kllj7mfeacdEPN
 kzOQw32bDHTuJaa76HIRyJq/Po04manCgPsfsTGRiA4vzXE6KyBVcYruePW855zihCNm
 /c6LdYUIbc9FN/tYAWttiMZOeK33xPST4YDQV5IwIaTNblOTA/XFGR93imVyUoNYiW7Q
 nbZOanWWagwwplW7vhxWT2ZmSLe3roSJIOc5IcRYvxQZ8HWf8Yvif000644eTL3mO20C
 h0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708128110; x=1708732910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qs4/5s/0Lq9OL8A9BgObbv04EylJgBGSxtSlF1aloGo=;
 b=SpNLG4S7TD8m6Gy1XK37OTuVpGq2VDL7plX1lKSJE7LZ+KbNcXcvw+OOZi+2HKXJWy
 vO7RkEoJi9bG1s9SKUlHvFHmf+wQnPniXRKjeU9Ekys0U97oV+lAPNpaOySA9o532YQ/
 AUOuTQZLGnyemsHBQ6fH3rmcqgWkkxnkRbeHhvZ++zzRXPXHMCJKbjdLvxzyeRRqPckz
 jHej+WEPct7IXi3d08M2LhNj4/p1JnDvfYOKYxyQgyn2aRW0EEilGsgH8hH8vu/ywQ2f
 wZBcFB96b2DGZtq2dGYhKCK6fyWdU2tbfn5JTB49Em77HF4fqZn4MoNPGIYdZAL8oV2E
 Or8Q==
X-Gm-Message-State: AOJu0Yxnp8Bh5zjA1RwhaJdOrC2O4ntsYZ/wnw5KQe+glr0VgnWI4Rv7
 TyP8f61YxjDxuZ7aYT1LA8V/Xsf4LkNffBETADU8olBG49CqFqqhl0edDEHNHNwqKY/iWspOIv0
 x
X-Google-Smtp-Source: AGHT+IGORzD9hpwHatls7LztIet646hL3Xz0vLGT81Wl4wUhqvA776rD7v+PhUpjM0LE/jbXME/ivw==
X-Received: by 2002:a05:6a00:1ad2:b0:6e1:25c9:bb29 with SMTP id
 f18-20020a056a001ad200b006e125c9bb29mr7848353pfv.1.1708128110045; 
 Fri, 16 Feb 2024 16:01:50 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a635b0d000000b005d66caee3d0sm464015pgb.22.2024.02.16.16.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 16:01:49 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
Subject: [PATCH RFC 4/8] target/riscv: Support generic CSR indirect access
Date: Fri, 16 Feb 2024 16:01:30 -0800
Message-Id: <20240217000134.3634191-5-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217000134.3634191-1-atishp@rivosinc.com>
References: <20240217000134.3634191-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds the indirect access registers required by sscsrind/smcsrind
and the operations on them. Note that xiselect and xireg are used for
both AIA and sxcsrind, and the behavior of accessing them depends on
whether each extension is enabled and the value stored in xiselect.

Co-developed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
---
 target/riscv/cpu_bits.h |  28 +++++++-
 target/riscv/csr.c      | 146 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 169 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 0ee91e502e8f..3a66f83009b5 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -176,6 +176,13 @@
 #define CSR_MISELECT        0x350
 #define CSR_MIREG           0x351
 
+/* Machine Indirect Register Alias */
+#define CSR_MIREG2          0x352
+#define CSR_MIREG3          0x353
+#define CSR_MIREG4          0x355
+#define CSR_MIREG5          0x356
+#define CSR_MIREG6          0x357
+
 /* Machine-Level Interrupts (AIA) */
 #define CSR_MTOPEI          0x35c
 #define CSR_MTOPI           0xfb0
@@ -225,6 +232,13 @@
 #define CSR_SISELECT        0x150
 #define CSR_SIREG           0x151
 
+/* Supervisor Indirect Register Alias */
+#define CSR_SIREG2          0x152
+#define CSR_SIREG3          0x153
+#define CSR_SIREG4          0x155
+#define CSR_SIREG5          0x156
+#define CSR_SIREG6          0x157
+
 /* Supervisor-Level Interrupts (AIA) */
 #define CSR_STOPEI          0x15c
 #define CSR_STOPI           0xdb0
@@ -291,6 +305,13 @@
 #define CSR_VSISELECT       0x250
 #define CSR_VSIREG          0x251
 
+/* Virtual Supervisor Indirect Alias */
+#define CSR_VSIREG2         0x252
+#define CSR_VSIREG3         0x253
+#define CSR_VSIREG4         0x255
+#define CSR_VSIREG5         0x256
+#define CSR_VSIREG6         0x257
+
 /* VS-Level Interrupts (H-extension with AIA) */
 #define CSR_VSTOPEI         0x25c
 #define CSR_VSTOPI          0xeb0
@@ -847,10 +868,13 @@ typedef enum RISCVException {
 #define ISELECT_IMSIC_EIE63                0xff
 #define ISELECT_IMSIC_FIRST                ISELECT_IMSIC_EIDELIVERY
 #define ISELECT_IMSIC_LAST                 ISELECT_IMSIC_EIE63
-#define ISELECT_MASK                       0x1ff
+#define ISELECT_MASK_AIA                   0x1ff
+
+/* MISELECT, SISELECT, and VSISELECT bits (AIA) */
+#define ISELECT_MASK_SXCSRIND              0xfff
 
 /* Dummy [M|S|VS]ISELECT value for emulating [M|S|VS]TOPEI CSRs */
-#define ISELECT_IMSIC_TOPEI                (ISELECT_MASK + 1)
+#define ISELECT_IMSIC_TOPEI                (ISELECT_MASK_AIA + 1)
 
 /* IMSIC bits (AIA) */
 #define IMSIC_TOPEI_IID_SHIFT              16
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 89a1325a02a5..a1c10f1d010a 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -287,6 +287,17 @@ static int aia_any32(CPURISCVState *env, int csrno)
     return any32(env, csrno);
 }
 
+static RISCVException sxcsrind_any(CPURISCVState *env, int csrno)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+
+    if (!cpu->cfg.ext_smcsrind) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
 static int sxcsrind_or_aia_any(CPURISCVState *env, int csrno)
 {
     if (!riscv_cpu_cfg(env)->ext_smaia && !riscv_cpu_cfg(env)->ext_smcsrind) {
@@ -355,6 +366,17 @@ static int aia_smode32(CPURISCVState *env, int csrno)
     return smode32(env, csrno);
 }
 
+static RISCVException sxcsrind_smode(CPURISCVState *env, int csrno)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+
+    if (!cpu->cfg.ext_sscsrind) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return smode(env, csrno);
+}
+
 static int sxcsrind_or_aia_smode(CPURISCVState *env, int csrno)
 {
     if (!riscv_cpu_cfg(env)->ext_ssaia && !riscv_cpu_cfg(env)->ext_sscsrind) {
@@ -383,6 +405,17 @@ static RISCVException hmode32(CPURISCVState *env, int csrno)
 
 }
 
+static RISCVException sxcsrind_hmode(CPURISCVState *env, int csrno)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+
+    if (!cpu->cfg.ext_sscsrind) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return hmode(env, csrno);
+}
+
 static int sxcsrind_or_aia_hmode(CPURISCVState *env, int csrno)
 {
     if (!riscv_cpu_cfg(env)->ext_ssaia && !riscv_cpu_cfg(env)->ext_sscsrind) {
@@ -1926,7 +1959,12 @@ static int rmw_xiselect(CPURISCVState *env, int csrno, target_ulong *val,
         *val = *iselect;
     }
 
-    wr_mask &= ISELECT_MASK;
+    if (riscv_cpu_cfg(env)->ext_smcsrind || riscv_cpu_cfg(env)->ext_sscsrind) {
+        wr_mask &= ISELECT_MASK_SXCSRIND;
+    } else {
+        wr_mask &= ISELECT_MASK_AIA;
+    }
+
     if (wr_mask) {
         *iselect = (*iselect & ~wr_mask) | (new_val & wr_mask);
     }
@@ -2065,6 +2103,59 @@ done:
     return RISCV_EXCP_NONE;
 }
 
+/*
+ * rmw_xireg_sxcsrind: Perform indirect access to xireg and xireg2-xireg6
+ *
+ * Perform indirect access to xireg and xireg2-xireg6.
+ * This is a generic interface for all xireg CSRs. Apart from AIA, all other
+ * extension using sxcsrind should be implemented here.
+ */
+static int rmw_xireg_sxcsrind(CPURISCVState *env, int csrno,
+                              target_ulong isel, target_ulong *val,
+                              target_ulong new_val, target_ulong wr_mask)
+{
+    return -EINVAL;
+}
+
+static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val,
+                      target_ulong new_val, target_ulong wr_mask)
+{
+    bool virt = false;
+    int ret = -EINVAL;
+    target_ulong isel;
+
+    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    /* Translate CSR number for VS-mode */
+    csrno = sxcsrind_xlate_vs_csrno(env, csrno);
+
+    if (CSR_MIREG <= csrno && csrno <= CSR_MIREG6 &&
+        csrno != CSR_MIREG4 - 1) {
+        isel = env->miselect;
+    } else if (CSR_SIREG <= csrno && csrno <= CSR_SIREG6 &&
+               csrno != CSR_SIREG4 - 1) {
+        isel = env->siselect;
+    } else if (CSR_VSIREG <= csrno && csrno <= CSR_VSIREG6 &&
+               csrno != CSR_VSIREG4 - 1) {
+        isel = env->vsiselect;
+        virt = true;
+    } else {
+        goto done;
+    }
+
+    return rmw_xireg_sxcsrind(env, csrno, isel, val, new_val, wr_mask);
+
+done:
+    if (ret) {
+        return (env->virt_enabled && virt) ?
+               RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
+    }
+    return RISCV_EXCP_NONE;
+}
+
 static int rmw_xireg(CPURISCVState *env, int csrno, target_ulong *val,
                      target_ulong new_val, target_ulong wr_mask)
 {
@@ -2096,8 +2187,21 @@ static int rmw_xireg(CPURISCVState *env, int csrno, target_ulong *val,
          goto done;
     };
 
+    /*
+     * Use the xiselect range to determine actual op on xireg.
+     *
+     * Since we only checked the existence of AIA or Indirect Access in the
+     * predicate, we should check the existence of the exact extension when
+     * we get to a specific range and return illegal instruction exception even
+     * in VS-mode.
+     */
     if (xiselect_aia_range(isel)) {
         return rmw_xireg_aia(env, csrno, isel, val, new_val, wr_mask);
+    } else if (riscv_cpu_cfg(env)->ext_smcsrind ||
+               riscv_cpu_cfg(env)->ext_sscsrind) {
+        return rmw_xireg_sxcsrind(env, csrno, isel, val, new_val, wr_mask);
+    } else {
+        return RISCV_EXCP_ILLEGAL_INST;
     }
 
 done:
@@ -2480,7 +2584,7 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
      * TODO: Do we need to check ssaia as well ? Can we enable ssaia without
      * smaia ?
      */
-    if (riscv_cpu_cfg(env)->ext_smaia) {
+    if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrind) {
         wr_mask |= SMSTATEEN0_SVSLCT;
     }
 
@@ -2569,7 +2673,7 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_FCSR;
     }
 
-    if (riscv_cpu_cfg(env)->ext_ssaia) {
+    if (riscv_cpu_cfg(env)->ext_ssaia || riscv_cpu_cfg(env)->ext_sscsrind) {
         wr_mask |= SMSTATEEN0_SVSLCT;
     }
 
@@ -4866,6 +4970,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MIREG]    = { "mireg",    sxcsrind_or_aia_any,   NULL, NULL,
                        rmw_xireg                                       },
 
+    /* Machine Indirect Register Alias */
+    [CSR_MIREG2]   = { "mireg2", sxcsrind_any, NULL, NULL, rmw_xiregi,
+                       .min_priv_ver = PRIV_VERSION_1_12_0          },
+    [CSR_MIREG3]   = { "mireg3", sxcsrind_any, NULL, NULL, rmw_xiregi,
+                       .min_priv_ver = PRIV_VERSION_1_12_0          },
+    [CSR_MIREG4]   = { "mireg4", sxcsrind_any, NULL, NULL, rmw_xiregi,
+                       .min_priv_ver = PRIV_VERSION_1_12_0          },
+    [CSR_MIREG5]   = { "mireg5", sxcsrind_any, NULL, NULL, rmw_xiregi,
+                       .min_priv_ver = PRIV_VERSION_1_12_0          },
+    [CSR_MIREG6]   = { "mireg6", sxcsrind_any, NULL, NULL, rmw_xiregi,
+                       .min_priv_ver = PRIV_VERSION_1_12_0          },
+
     /* Machine-Level Interrupts (AIA) */
     [CSR_MTOPEI]   = { "mtopei",   aia_any, NULL, NULL, rmw_xtopei },
     [CSR_MTOPI]    = { "mtopi",    aia_any, read_mtopi },
@@ -4987,6 +5103,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_SIREG]      = { "sireg",      sxcsrind_or_aia_smode, NULL, NULL,
                          rmw_xireg                                          },
 
+    /* Supervisor Indirect Register Alias */
+    [CSR_SIREG2]      = { "sireg2", sxcsrind_smode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_SIREG3]      = { "sireg3", sxcsrind_smode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_SIREG4]      = { "sireg4", sxcsrind_smode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_SIREG5]      = { "sireg5", sxcsrind_smode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_SIREG6]      = { "sireg6", sxcsrind_smode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+
     /* Supervisor-Level Interrupts (AIA) */
     [CSR_STOPEI]     = { "stopei",     aia_smode, NULL, NULL, rmw_xtopei },
     [CSR_STOPI]      = { "stopi",      aia_smode, read_stopi },
@@ -5069,6 +5197,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VSIREG]      = { "vsireg",      sxcsrind_or_aia_hmode, NULL, NULL,
                           rmw_xireg                                         },
 
+    /* Virtual Supervisor Indirect Alias */
+    [CSR_VSIREG2]     = { "vsireg2", sxcsrind_hmode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_VSIREG3]     = { "vsireg3", sxcsrind_hmode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_VSIREG4]     = { "vsireg4", sxcsrind_hmode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_VSIREG5]     = { "vsireg5", sxcsrind_hmode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_VSIREG6]     = { "vsireg6", sxcsrind_hmode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+
     /* VS-Level Interrupts (H-extension with AIA) */
     [CSR_VSTOPEI]     = { "vstopei",     aia_hmode, NULL, NULL, rmw_xtopei },
     [CSR_VSTOPI]      = { "vstopi",      aia_hmode, read_vstopi },
-- 
2.34.1


