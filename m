Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18264C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 23:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWOy0-0002YD-Up; Tue, 23 Jul 2024 19:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sWOxg-00021Z-6N
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:30:30 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sWOxd-0007pf-2x
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:30:27 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2cb566d528aso3858713a91.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 16:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721777422; x=1722382222;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t3IUQ3lWMCE317aXyY0qnJM5cCIYZlieRf6PY9LMv1g=;
 b=bDvKR4coaNpXOHnhbYanwCzYujKYJi3IuwQ7R3xVhvU06je1cNF0jxMtRLuggHSMBI
 +T6Dy4XGmzdB2C0D5LFeqS574VI2VFuxVwhW+qCPRo8fUGhwjW8DDr8lnHH1I8/PgpLR
 5t+zdoY+elSmACkFBl4Qs6XIjN61iOoESr6hnFLDl3ZMmFos865yckXFQ+iL/cPWe+E9
 RaLTGP9DRbOHbIn4WTFz9KoCkY9wfUZJHePp133vfMLVZJmiRbuguVKAjX8yOCdwdztg
 xYbFmMwoMSOdR0aNcdhoGOJjFQHM44uk1ywmY9xFw1AzDFujESlcU1NdfHrjbv9mK2Hj
 W39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721777422; x=1722382222;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t3IUQ3lWMCE317aXyY0qnJM5cCIYZlieRf6PY9LMv1g=;
 b=ligiuGSDrPhjDmBCUiCPNrAEQ7wk9yWes3WmPPGdy5v8oNBNW7b5rTnsJAuTbb3sRp
 6DIhctyIlmJhAUAtLF5sE4QLK1quzrhNg7Hg/NaHtyfZT8NFTd7Mc0ewFpfFWgo0Op8t
 TY/eOg88Mz09P641J57kz3CvgkKu/a9FMDJn9BOkOrzdjSU3qHgtzeFArlhFp0lfbkFZ
 NFe6qHodP9ZaSpHwx1hQT0pBOYn2Oz0/33FU9aX97X7P5pvw4Vv4z4ilGPCshLG+ueSW
 aCK2jLgYecggP8u116/xkOQWrPvRs04nu7qGdoMaGwGtt8i8EU2EW/RXPnXCK/Dza1Hm
 7rcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEkpJGLIyIT8VAQU1QZZMG9lTlnHMmzVAG5j/oScgbmT7ZoeGtr1mBZKTEAXlFTF9QmiPbHLn/YAsfSXdtgXcy6z8eGus=
X-Gm-Message-State: AOJu0Yz6+dYle/Nr3Axf6ixbobxvL1UNPOxfBgEgGQHiW5ZYbSz+7aQr
 4lubyzpFYO9/N+kcmZy975mV2RHAFHYeLD15kz2SVB7+9pp2y/gnIQGAN1zyKDc=
X-Google-Smtp-Source: AGHT+IE+XH9QdlCHWOL+Xm5HwmCPmNIQ6adqK3WyoKqyB/gmR8pUNJwXfVbScDKbJm6QdfB5gG9vHg==
X-Received: by 2002:a17:90b:4d8d:b0:2cb:3748:f5ce with SMTP id
 98e67ed59e1d1-2cdae3143a0mr1408416a91.10.1721777422348; 
 Tue, 23 Jul 2024 16:30:22 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cdb74e894csm179217a91.41.2024.07.23.16.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 16:30:21 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 23 Jul 2024 16:30:01 -0700
Subject: [PATCH v2 04/13] target/riscv: Support generic CSR indirect access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-counter_delegation-v2-4-c4170a5348ca@rivosinc.com>
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
In-Reply-To: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=atishp@rivosinc.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds the indirect access registers required by sscsrind/smcsrind
and the operations on them. Note that xiselect and xireg are used for
both AIA and sxcsrind, and the behavior of accessing them depends on
whether each extension is enabled and the value stored in xiselect.

Co-developed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
---
 target/riscv/cpu.c      |   2 +
 target/riscv/cpu_bits.h |  28 ++++++++-
 target/riscv/cpu_cfg.h  |   2 +
 target/riscv/csr.c      | 149 ++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 175 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ebc19090b40d..ac2dce734d80 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -182,12 +182,14 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
+    ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_12_0, ext_smcdeleg),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_12_0, ext_smcsrind),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_12_0, ext_ssccfg),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 32b068f18aa5..2a8b53a6622e 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -170,6 +170,13 @@
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
@@ -219,6 +226,13 @@
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
@@ -285,6 +299,13 @@
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
@@ -846,10 +867,13 @@ typedef enum RISCVException {
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
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index b8a5174bc871..b2be3d47c7a3 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -79,6 +79,8 @@ struct RISCVCPUConfig {
     bool ext_smcntrpmf;
     bool ext_smcsrind;
     bool ext_sscsrind;
+    bool ext_smcdeleg;
+    bool ext_ssccfg;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 18b9ae802b15..4ae3931f0ada 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -287,6 +287,17 @@ static RISCVException aia_any32(CPURISCVState *env, int csrno)
     return any32(env, csrno);
 }
 
+static RISCVException csrind_any(CPURISCVState *env, int csrno)
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
 static RISCVException csrind_or_aia_any(CPURISCVState *env, int csrno)
 {
     if (!riscv_cpu_cfg(env)->ext_smaia && !riscv_cpu_cfg(env)->ext_smcsrind) {
@@ -370,6 +381,15 @@ static bool csrind_or_aia_extensions_present(CPURISCVState *env)
     return csrind_extensions_present(env) || aia_extensions_present(env);
 }
 
+static RISCVException csrind_smode(CPURISCVState *env, int csrno)
+{
+    if (!csrind_extensions_present(env)) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return smode(env, csrno);
+}
+
 static RISCVException csrind_or_aia_smode(CPURISCVState *env, int csrno)
 {
     if (!csrind_or_aia_extensions_present(env)) {
@@ -398,6 +418,15 @@ static RISCVException hmode32(CPURISCVState *env, int csrno)
 
 }
 
+static RISCVException csrind_hmode(CPURISCVState *env, int csrno)
+{
+    if (!csrind_extensions_present(env)) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return hmode(env, csrno);
+}
+
 static RISCVException csrind_or_aia_hmode(CPURISCVState *env, int csrno)
 {
     if (!csrind_or_aia_extensions_present(env)) {
@@ -2027,7 +2056,12 @@ static int csrind_xlate_vs_csrno(CPURISCVState *env, int csrno)
     case CSR_SISELECT:
         return CSR_VSISELECT;
     case CSR_SIREG:
-        return CSR_VSIREG;
+    case CSR_SIREG2:
+    case CSR_SIREG3:
+    case CSR_SIREG4:
+    case CSR_SIREG5:
+    case CSR_SIREG6:
+        return CSR_VSIREG + (csrno - CSR_SIREG);
     default:
         return csrno;
     };
@@ -2067,7 +2101,12 @@ static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
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
@@ -2206,6 +2245,59 @@ done:
     return RISCV_EXCP_NONE;
 }
 
+/*
+ * rmw_xireg_csrind: Perform indirect access to xireg and xireg2-xireg6
+ *
+ * Perform indirect access to xireg and xireg2-xireg6.
+ * This is a generic interface for all xireg CSRs. Apart from AIA, all other
+ * extension using csrind should be implemented here.
+ */
+static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
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
+    csrno = csrind_xlate_vs_csrno(env, csrno);
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
+    return rmw_xireg_csrind(env, csrno, isel, val, new_val, wr_mask);
+
+done:
+    if (ret) {
+        return (env->virt_enabled && virt) ?
+               RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
+    }
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
                                 target_ulong *val, target_ulong new_val,
                                 target_ulong wr_mask)
@@ -2238,8 +2330,21 @@ static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
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
+        return rmw_xireg_csrind(env, csrno, isel, val, new_val, wr_mask);
+    } else {
+        return RISCV_EXCP_ILLEGAL_INST;
     }
 
 done:
@@ -2671,7 +2776,7 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
      * TODO: Do we need to check ssaia as well ? Can we enable ssaia without
      * smaia ?
      */
-    if (riscv_cpu_cfg(env)->ext_smaia) {
+    if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrind) {
         wr_mask |= SMSTATEEN0_SVSLCT;
     }
 
@@ -2764,7 +2869,7 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_FCSR;
     }
 
-    if (riscv_cpu_cfg(env)->ext_ssaia) {
+    if (riscv_cpu_cfg(env)->ext_ssaia || riscv_cpu_cfg(env)->ext_sscsrind) {
         wr_mask |= SMSTATEEN0_SVSLCT;
     }
 
@@ -5180,6 +5285,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MIREG]    = { "mireg",    csrind_or_aia_any,   NULL, NULL,
                        rmw_xireg                                       },
 
+    /* Machine Indirect Register Alias */
+    [CSR_MIREG2]   = { "mireg2", csrind_any, NULL, NULL, rmw_xiregi,
+                       .min_priv_ver = PRIV_VERSION_1_12_0          },
+    [CSR_MIREG3]   = { "mireg3", csrind_any, NULL, NULL, rmw_xiregi,
+                       .min_priv_ver = PRIV_VERSION_1_12_0          },
+    [CSR_MIREG4]   = { "mireg4", csrind_any, NULL, NULL, rmw_xiregi,
+                       .min_priv_ver = PRIV_VERSION_1_12_0          },
+    [CSR_MIREG5]   = { "mireg5", csrind_any, NULL, NULL, rmw_xiregi,
+                       .min_priv_ver = PRIV_VERSION_1_12_0          },
+    [CSR_MIREG6]   = { "mireg6", csrind_any, NULL, NULL, rmw_xiregi,
+                       .min_priv_ver = PRIV_VERSION_1_12_0          },
+
     /* Machine-Level Interrupts (AIA) */
     [CSR_MTOPEI]   = { "mtopei",   aia_any, NULL, NULL, rmw_xtopei },
     [CSR_MTOPI]    = { "mtopi",    aia_any, read_mtopi },
@@ -5301,6 +5418,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_SIREG]      = { "sireg",      csrind_or_aia_smode, NULL, NULL,
                          rmw_xireg                                          },
 
+    /* Supervisor Indirect Register Alias */
+    [CSR_SIREG2]      = { "sireg2", csrind_smode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_SIREG3]      = { "sireg3", csrind_smode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_SIREG4]      = { "sireg4", csrind_smode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_SIREG5]      = { "sireg5", csrind_smode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_SIREG6]      = { "sireg6", csrind_smode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+
     /* Supervisor-Level Interrupts (AIA) */
     [CSR_STOPEI]     = { "stopei",     aia_smode, NULL, NULL, rmw_xtopei },
     [CSR_STOPI]      = { "stopi",      aia_smode, read_stopi },
@@ -5383,6 +5512,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VSIREG]      = { "vsireg",      csrind_or_aia_hmode, NULL, NULL,
                           rmw_xireg                                         },
 
+    /* Virtual Supervisor Indirect Alias */
+    [CSR_VSIREG2]     = { "vsireg2", csrind_hmode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_VSIREG3]     = { "vsireg3", csrind_hmode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_VSIREG4]     = { "vsireg4", csrind_hmode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_VSIREG5]     = { "vsireg5", csrind_hmode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_VSIREG6]     = { "vsireg6", csrind_hmode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+
     /* VS-Level Interrupts (H-extension with AIA) */
     [CSR_VSTOPEI]     = { "vstopei",     aia_hmode, NULL, NULL, rmw_xtopei },
     [CSR_VSTOPI]      = { "vstopi",      aia_hmode, read_vstopi },

-- 
2.34.1


