Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4C8C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 00:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb89g-0003PQ-Mu; Fri, 16 Feb 2024 19:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rb89b-0003OZ-E9
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:02:04 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rb89N-0007vN-EG
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:02:03 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e09143c7bdso1709998b3a.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 16:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708128107; x=1708732907;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Znixe6dXR2BFlfMVD0apwVpdd9139jR5123rhJJMt7E=;
 b=Bcy/jO7q1nd58Me9c6bxsS0TT5ZJ5DtKPL3g1Qc3/BuH/BNO447exLP1Qc94w2srMH
 IwlC+hDFShMHfR/hj0aKrktYvWjS7iHZtp5Z9Cjq3Sz0fBB/DcGPp8K+mn5mZ1MpoAGp
 ZmpytkAC5gYzbCnfFIQRN3KPJOzvYJfScDr68urqNxeKnAzRZ1dOT5jq8W9W9Xu0Yiq4
 /JpkWID1qWJ38Q23Eg7A1yG8OUT6NUoNt6+4YLHNue987kGiCCZOATG4cyXAMuZALeiI
 ytyvfKOLRXrdLQnjLMp9yZpvebAU7uU8sczubXC8zp5t6QFe85w6ZBTmorChKi6WnSu6
 64ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708128107; x=1708732907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Znixe6dXR2BFlfMVD0apwVpdd9139jR5123rhJJMt7E=;
 b=oEv9cf5J61XItBknzT3wx/bl2GmvxDvThR7nw73joPKNKs3ryL+t+FiHBzkxwBQdfG
 8QmZHvfg8WKQnrwdyc2UovceSXMfvkWt+izkGSV1UVxvQpMKkjOVjMMAoCIwTRoIIo0g
 5Rj5U12trDUYpoancGNNIRB/+JLSQ3I2cmcrdlp3exgtxEc0TDJ+kx4o/+oEOM3QHXxw
 XPLAFlsJlm2xWq6cU8ExMrNdCIesfP971341AUhJavjOst3j1X5VLXIS3gDGQ/EIIXOL
 wIHtAtivP7I6Mv9CuVb4steGh2Up33r1/CEUWpXG9Ystrm7j/HK8DeFemgkhJpH3liMe
 i96A==
X-Gm-Message-State: AOJu0Yw2IGfK/HElf/4luddD3fjeWM+ValPLD106CKtJZnfeqZAVVFCl
 8ciDGyaiqNS1LrANAmm6k7iNJT9nyfkxUHlqsQEADyDk28S0/cScWoYJXWta/vDIIFuW8tHwIBn
 D
X-Google-Smtp-Source: AGHT+IEeJQfda2ruAtsclJSP7u8kSHO7tyK5NQ4gK/G2JGrJPMgO+9ew0VRjLHR5vKhRCDunB/So4Q==
X-Received: by 2002:a05:6a00:6c9f:b0:6e0:a30c:8c84 with SMTP id
 jc31-20020a056a006c9f00b006e0a30c8c84mr7837245pfb.1.1708128107107; 
 Fri, 16 Feb 2024 16:01:47 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a635b0d000000b005d66caee3d0sm464015pgb.22.2024.02.16.16.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 16:01:46 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
Subject: [PATCH RFC 2/8] target/riscv: Decouple AIA processing from xiselect
 and xireg
Date: Fri, 16 Feb 2024 16:01:28 -0800
Message-Id: <20240217000134.3634191-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217000134.3634191-1-atishp@rivosinc.com>
References: <20240217000134.3634191-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Since xiselect and xireg also will be of use in sxcsrind, AIA should
have its own separated interface when those CSRs are accessed.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
---
 target/riscv/csr.c | 147 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 122 insertions(+), 25 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 8829dee7bc75..1af0c8890a2b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -287,6 +287,15 @@ static int aia_any32(CPURISCVState *env, int csrno)
     return any32(env, csrno);
 }
 
+static int sxcsrind_or_aia_any(CPURISCVState *env, int csrno)
+{
+    if (!riscv_cpu_cfg(env)->ext_smaia && !riscv_cpu_cfg(env)->ext_smcsrind) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return any(env, csrno);
+}
+
 static RISCVException smode(CPURISCVState *env, int csrno)
 {
     if (riscv_has_ext(env, RVS)) {
@@ -323,6 +332,15 @@ static int aia_smode32(CPURISCVState *env, int csrno)
     return smode32(env, csrno);
 }
 
+static int sxcsrind_or_aia_smode(CPURISCVState *env, int csrno)
+{
+    if (!riscv_cpu_cfg(env)->ext_ssaia && !riscv_cpu_cfg(env)->ext_sscsrind) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return smode(env, csrno);
+}
+
 static RISCVException hmode(CPURISCVState *env, int csrno)
 {
     if (riscv_has_ext(env, RVH)) {
@@ -342,6 +360,15 @@ static RISCVException hmode32(CPURISCVState *env, int csrno)
 
 }
 
+static int sxcsrind_or_aia_hmode(CPURISCVState *env, int csrno)
+{
+    if (!riscv_cpu_cfg(env)->ext_ssaia && !riscv_cpu_cfg(env)->ext_sscsrind) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return hmode(env, csrno);
+}
+
 static RISCVException umode(CPURISCVState *env, int csrno)
 {
     if (riscv_has_ext(env, RVU)) {
@@ -1804,13 +1831,29 @@ static int aia_xlate_vs_csrno(CPURISCVState *env, int csrno)
     };
 }
 
+static int sxcsrind_xlate_vs_csrno(CPURISCVState *env, int csrno)
+{
+    if (!env->virt_enabled) {
+        return csrno;
+    }
+
+    switch (csrno) {
+    case CSR_SISELECT:
+        return CSR_VSISELECT;
+    case CSR_SIREG:
+        return CSR_VSIREG;
+    default:
+        return csrno;
+    };
+}
+
 static int rmw_xiselect(CPURISCVState *env, int csrno, target_ulong *val,
                         target_ulong new_val, target_ulong wr_mask)
 {
     target_ulong *iselect;
 
     /* Translate CSR number for VS-mode */
-    csrno = aia_xlate_vs_csrno(env, csrno);
+    csrno = sxcsrind_xlate_vs_csrno(env, csrno);
 
     /* Find the iselect CSR based on CSR number */
     switch (csrno) {
@@ -1839,6 +1882,12 @@ static int rmw_xiselect(CPURISCVState *env, int csrno, target_ulong *val,
     return RISCV_EXCP_NONE;
 }
 
+static bool xiselect_aia_range(target_ulong isel)
+{
+    return (ISELECT_IPRIO0 <= isel && isel <= ISELECT_IPRIO15) ||
+           (ISELECT_IMSIC_FIRST <= isel && isel <= ISELECT_IMSIC_LAST);
+}
+
 static int rmw_iprio(target_ulong xlen,
                      target_ulong iselect, uint8_t *iprio,
                      target_ulong *val, target_ulong new_val,
@@ -1884,44 +1933,44 @@ static int rmw_iprio(target_ulong xlen,
     return 0;
 }
 
-static int rmw_xireg(CPURISCVState *env, int csrno, target_ulong *val,
-                     target_ulong new_val, target_ulong wr_mask)
+static int rmw_xireg_aia(CPURISCVState *env, int csrno,
+                         target_ulong isel, target_ulong *val,
+                         target_ulong new_val, target_ulong wr_mask)
 {
-    bool virt, isel_reserved;
-    uint8_t *iprio;
+    bool virt = false, isel_reserved = false;
     int ret = -EINVAL;
-    target_ulong priv, isel, vgein;
-
-    /* Translate CSR number for VS-mode */
-    csrno = aia_xlate_vs_csrno(env, csrno);
+    uint8_t *iprio;
+    target_ulong priv, vgein;
 
-    /* Decode register details from CSR number */
-    virt = false;
-    isel_reserved = false;
+    /* VS-mode CSR number passed in has already been translated */
     switch (csrno) {
     case CSR_MIREG:
+        if (!riscv_cpu_cfg(env)->ext_smaia) {
+            goto done;
+        }
         iprio = env->miprio;
-        isel = env->miselect;
         priv = PRV_M;
         break;
     case CSR_SIREG:
-        if (env->priv == PRV_S && env->mvien & MIP_SEIP &&
+        if (!riscv_cpu_cfg(env)->ext_ssaia ||
+            (env->priv == PRV_S && env->mvien & MIP_SEIP &&
             env->siselect >= ISELECT_IMSIC_EIDELIVERY &&
-            env->siselect <= ISELECT_IMSIC_EIE63) {
+            env->siselect <= ISELECT_IMSIC_EIE63)) {
             goto done;
         }
         iprio = env->siprio;
-        isel = env->siselect;
         priv = PRV_S;
         break;
     case CSR_VSIREG:
+        if (!riscv_cpu_cfg(env)->ext_ssaia) {
+            goto done;
+        }
         iprio = env->hviprio;
-        isel = env->vsiselect;
         priv = PRV_S;
         virt = true;
         break;
     default:
-         goto done;
+        goto done;
     };
 
     /* Find the selected guest interrupt file */
@@ -1952,10 +2001,53 @@ static int rmw_xireg(CPURISCVState *env, int csrno, target_ulong *val,
     }
 
 done:
+    /*
+     * If AIA is not enabled, illegal instruction exception is always
+     * returned regardless of whether we are in VS-mode or not
+     */
     if (ret) {
         return (env->virt_enabled && virt && !isel_reserved) ?
                RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
     }
+
+    return RISCV_EXCP_NONE;
+}
+
+static int rmw_xireg(CPURISCVState *env, int csrno, target_ulong *val,
+                     target_ulong new_val, target_ulong wr_mask)
+{
+    bool virt = false;
+    int ret = -EINVAL;
+    target_ulong isel;
+
+    /* Translate CSR number for VS-mode */
+    csrno = sxcsrind_xlate_vs_csrno(env, csrno);
+
+    /* Decode register details from CSR number */
+    switch (csrno) {
+    case CSR_MIREG:
+        isel = env->miselect;
+        break;
+    case CSR_SIREG:
+        isel = env->siselect;
+        break;
+    case CSR_VSIREG:
+        isel = env->vsiselect;
+        virt = true;
+        break;
+    default:
+         goto done;
+    };
+
+    if (xiselect_aia_range(isel)) {
+        return rmw_xireg_aia(env, csrno, isel, val, new_val, wr_mask);
+    }
+
+done:
+    if (ret) {
+        return (env->virt_enabled && virt) ?
+               RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
+    }
     return RISCV_EXCP_NONE;
 }
 
@@ -4682,8 +4774,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MIP]      = { "mip",      any,  NULL,    NULL, rmw_mip        },
 
     /* Machine-Level Window to Indirectly Accessed Registers (AIA) */
-    [CSR_MISELECT] = { "miselect", aia_any,   NULL, NULL,    rmw_xiselect },
-    [CSR_MIREG]    = { "mireg",    aia_any,   NULL, NULL,    rmw_xireg },
+    [CSR_MISELECT] = { "miselect", sxcsrind_or_aia_any,   NULL, NULL,
+                       rmw_xiselect                                    },
+    [CSR_MIREG]    = { "mireg",    sxcsrind_or_aia_any,   NULL, NULL,
+                       rmw_xireg                                       },
 
     /* Machine-Level Interrupts (AIA) */
     [CSR_MTOPEI]   = { "mtopei",   aia_any, NULL, NULL, rmw_xtopei },
@@ -4801,8 +4895,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_SATP]     = { "satp",     satp, read_satp,     write_satp     },
 
     /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
-    [CSR_SISELECT]   = { "siselect",   aia_smode, NULL, NULL, rmw_xiselect },
-    [CSR_SIREG]      = { "sireg",      aia_smode, NULL, NULL, rmw_xireg },
+    [CSR_SISELECT]   = { "siselect",   sxcsrind_or_aia_smode, NULL, NULL,
+                         rmw_xiselect                                       },
+    [CSR_SIREG]      = { "sireg",      sxcsrind_or_aia_smode, NULL, NULL,
+                         rmw_xireg                                          },
 
     /* Supervisor-Level Interrupts (AIA) */
     [CSR_STOPEI]     = { "stopei",     aia_smode, NULL, NULL, rmw_xtopei },
@@ -4881,9 +4977,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /*
      * VS-Level Window to Indirectly Accessed Registers (H-extension with AIA)
      */
-    [CSR_VSISELECT]   = { "vsiselect",   aia_hmode, NULL, NULL,
-                          rmw_xiselect                                     },
-    [CSR_VSIREG]      = { "vsireg",      aia_hmode, NULL, NULL, rmw_xireg  },
+    [CSR_VSISELECT]   = { "vsiselect",   sxcsrind_or_aia_hmode, NULL, NULL,
+                          rmw_xiselect                                      },
+    [CSR_VSIREG]      = { "vsireg",      sxcsrind_or_aia_hmode, NULL, NULL,
+                          rmw_xireg                                         },
 
     /* VS-Level Interrupts (H-extension with AIA) */
     [CSR_VSTOPEI]     = { "vstopei",     aia_hmode, NULL, NULL, rmw_xtopei },
-- 
2.34.1


