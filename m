Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501E1E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 08:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWAHE-0000Ma-9t; Fri, 10 Jan 2025 03:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tWAHC-0000Kq-4D
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:21:54 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tWAH9-0008KY-0c
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:21:53 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-216395e151bso21697885ad.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 00:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736497309; x=1737102109;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kOQvUst6uGdjKbvxgkmpC7kcjWnTp/3ciuQrZ8k5/rc=;
 b=OIvF3c9NdWUq0ESs+CKofGjsDmXWEGtMPbgoArcEXr0z+BCuu057MlJKGasjttPER3
 NC+i4LpFvBn0wLjexImd5sMd0lAGOsk1HJwYjHE2rcmpL9Vj4sNtcYZoP7UPL7MlNYsk
 L6azvkivfrEiM/brX1/Qni5b8gxjnzXOeJce57djfVj/sAnQ+b11DFJadq4xT7BF1Zz+
 nQxcdRb3CnL/jaISTe+P8Yx1lsfYylpvVxROejq+maV2NO7UGAF/zFvY4La0A/za2Ec8
 Bu3ZOyKieDqqlID9wL21XxR5JpEaiAx+D45i4CW3lXtITmugRTVP8C/MonSS8NEiDAXf
 VmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736497309; x=1737102109;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kOQvUst6uGdjKbvxgkmpC7kcjWnTp/3ciuQrZ8k5/rc=;
 b=BPp/f+5rf/dBxYURd4HZrxhG6LEyjfSAVUT7kjJDQcGMtwi0NTeL/vXzjJLZvG6SIS
 PmtjuATUowijb6oD+Pwp9eNfDC7TG5HmpYnAacCzeqYYRgccbVLu6cVGn7oe1AUKtGph
 k6BtKBJ/oCKuhEzkfq7Zg/tIwwEbjQw0karVpFqti31LlBEhlOIQvqZrG7uEKYu9MfJi
 lWCXhY9woJxyQ7G74Xnxbv93jxSyKYdQt2enIceMHGoJAW4cVJucF0DipoGpD7TPyIgw
 SQwTLBWn2k6YwW26LuBtSw+4vLeSI9eFvqw9SzPhZKUqmgUopK/K6ICVs5LL5hC/b/U+
 tDBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUagJk9S4u7EGVz5gdbO4zhefCuCUaF9TS8pWxI8KFdWgvUVxS1dXNtPhLDxUPk7uxH9WvP7f8uDh8z@nongnu.org
X-Gm-Message-State: AOJu0YzFMYlKVlaXE8ye5fWKt3hW74wKzEPAXmMIzFdKVPeIqtE0IJ1H
 q9AnGXLg7ya307ncy9DBn2NHS1xljpdg0p109/VrSvJ9M6ONDfZGpiqPGV0XItc=
X-Gm-Gg: ASbGncvp7W3QiqfKx7gnyHAknPxVWPSX3mdL8ZlvArAzdqtQ30GFfN+BLxkq/pZWJWz
 YO8qa5EQ7R7UlP0Z7TPYND7fTSAM8d0mgg7ONV+/Vo4gXR7vU098mL4O4Q1tH/YFqir7zb5Q6jA
 yPSQEj8yUBrTyqUpXVj9ghHZf7Jv7m1yD/eITBeWXgftoUrr1aki94w6ZjQA5Yu9tHJOXZ4BkUa
 LpnHtIKkcK/gLMM4+PlLgU15PbmCwsJtI+V0aUeIRRrkXC9aI2GIJSxXNP69Ktu1IaU1Q==
X-Google-Smtp-Source: AGHT+IGPo2zeDijoyVrpye8Q6lnBa/rfqa+HGCT/e/ZbbS/PW9siIwnUUVUlyFa6COpTmavrwY0Gvw==
X-Received: by 2002:a17:902:d4c8:b0:215:6c5f:d142 with SMTP id
 d9443c01a7336-21a8d6b3917mr101366315ad.20.1736497309584; 
 Fri, 10 Jan 2025 00:21:49 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f22ee09sm9278715ad.200.2025.01.10.00.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 00:21:49 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Fri, 10 Jan 2025 00:21:30 -0800
Subject: [PATCH v5 02/11] target/riscv: Decouple AIA processing from
 xiselect and xireg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-counter_delegation-v5-2-e83d797ae294@rivosinc.com>
References: <20250110-counter_delegation-v5-0-e83d797ae294@rivosinc.com>
In-Reply-To: <20250110-counter_delegation-v5-0-e83d797ae294@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x629.google.com
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

Since xiselect and xireg also will be of use in sxcsrind, AIA should
have its own separated interface when those CSRs are accessed.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/csr.c | 165 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 139 insertions(+), 26 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index af9766759a35..123e9fd2bd7b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -29,6 +29,7 @@
 #include "system/cpu-timers.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
+#include <stdbool.h>
 
 /* CSR function table public API */
 void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
@@ -305,6 +306,15 @@ static RISCVException aia_any32(CPURISCVState *env, int csrno)
     return any32(env, csrno);
 }
 
+static RISCVException csrind_or_aia_any(CPURISCVState *env, int csrno)
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
@@ -341,6 +351,30 @@ static RISCVException aia_smode32(CPURISCVState *env, int csrno)
     return smode32(env, csrno);
 }
 
+static bool csrind_extensions_present(CPURISCVState *env)
+{
+    return riscv_cpu_cfg(env)->ext_smcsrind || riscv_cpu_cfg(env)->ext_sscsrind;
+}
+
+static bool aia_extensions_present(CPURISCVState *env)
+{
+    return riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_ssaia;
+}
+
+static bool csrind_or_aia_extensions_present(CPURISCVState *env)
+{
+    return csrind_extensions_present(env) || aia_extensions_present(env);
+}
+
+static RISCVException csrind_or_aia_smode(CPURISCVState *env, int csrno)
+{
+    if (!csrind_or_aia_extensions_present(env)) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return smode(env, csrno);
+}
+
 static RISCVException hmode(CPURISCVState *env, int csrno)
 {
     if (riscv_has_ext(env, RVH)) {
@@ -360,6 +394,15 @@ static RISCVException hmode32(CPURISCVState *env, int csrno)
 
 }
 
+static RISCVException csrind_or_aia_hmode(CPURISCVState *env, int csrno)
+{
+    if (!csrind_or_aia_extensions_present(env)) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return hmode(env, csrno);
+}
+
 static RISCVException umode(CPURISCVState *env, int csrno)
 {
     if (riscv_has_ext(env, RVU)) {
@@ -1969,6 +2012,22 @@ static int aia_xlate_vs_csrno(CPURISCVState *env, int csrno)
     };
 }
 
+static int csrind_xlate_vs_csrno(CPURISCVState *env, int csrno)
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
 static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
                                    target_ulong *val, target_ulong new_val,
                                    target_ulong wr_mask)
@@ -1976,7 +2035,7 @@ static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
     target_ulong *iselect;
 
     /* Translate CSR number for VS-mode */
-    csrno = aia_xlate_vs_csrno(env, csrno);
+    csrno = csrind_xlate_vs_csrno(env, csrno);
 
     /* Find the iselect CSR based on CSR number */
     switch (csrno) {
@@ -2005,6 +2064,12 @@ static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
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
@@ -2050,45 +2115,44 @@ static int rmw_iprio(target_ulong xlen,
     return 0;
 }
 
-static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
-                                target_ulong *val, target_ulong new_val,
-                                target_ulong wr_mask)
+static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
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
@@ -2119,10 +2183,54 @@ static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
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
+static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
+                                target_ulong *val, target_ulong new_val,
+                                target_ulong wr_mask)
+{
+    bool virt = false;
+    int ret = -EINVAL;
+    target_ulong isel;
+
+    /* Translate CSR number for VS-mode */
+    csrno = csrind_xlate_vs_csrno(env, csrno);
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
 
@@ -4866,8 +4974,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MIP]      = { "mip",      any,  NULL,    NULL, rmw_mip        },
 
     /* Machine-Level Window to Indirectly Accessed Registers (AIA) */
-    [CSR_MISELECT] = { "miselect", aia_any,   NULL, NULL,    rmw_xiselect },
-    [CSR_MIREG]    = { "mireg",    aia_any,   NULL, NULL,    rmw_xireg },
+    [CSR_MISELECT] = { "miselect", csrind_or_aia_any,   NULL, NULL,
+                       rmw_xiselect                                    },
+    [CSR_MIREG]    = { "mireg",    csrind_or_aia_any,   NULL, NULL,
+                       rmw_xireg                                       },
 
     /* Machine-Level Interrupts (AIA) */
     [CSR_MTOPEI]   = { "mtopei",   aia_any, NULL, NULL, rmw_xtopei },
@@ -4995,8 +5105,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_SATP]     = { "satp",     satp, read_satp,     write_satp     },
 
     /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
-    [CSR_SISELECT]   = { "siselect",   aia_smode, NULL, NULL, rmw_xiselect },
-    [CSR_SIREG]      = { "sireg",      aia_smode, NULL, NULL, rmw_xireg },
+    [CSR_SISELECT]   = { "siselect",   csrind_or_aia_smode, NULL, NULL,
+                         rmw_xiselect                                       },
+    [CSR_SIREG]      = { "sireg",      csrind_or_aia_smode, NULL, NULL,
+                         rmw_xireg                                          },
 
     /* Supervisor-Level Interrupts (AIA) */
     [CSR_STOPEI]     = { "stopei",     aia_smode, NULL, NULL, rmw_xtopei },
@@ -5075,9 +5187,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /*
      * VS-Level Window to Indirectly Accessed Registers (H-extension with AIA)
      */
-    [CSR_VSISELECT]   = { "vsiselect",   aia_hmode, NULL, NULL,
-                          rmw_xiselect                                     },
-    [CSR_VSIREG]      = { "vsireg",      aia_hmode, NULL, NULL, rmw_xireg  },
+    [CSR_VSISELECT]   = { "vsiselect",   csrind_or_aia_hmode, NULL, NULL,
+                          rmw_xiselect                                      },
+    [CSR_VSIREG]      = { "vsireg",      csrind_or_aia_hmode, NULL, NULL,
+                          rmw_xireg                                         },
 
     /* VS-Level Interrupts (H-extension with AIA) */
     [CSR_VSTOPEI]     = { "vstopei",     aia_hmode, NULL, NULL, rmw_xtopei },

-- 
2.34.1


