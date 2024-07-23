Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D64C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 23:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWOxz-0002Sw-Um; Tue, 23 Jul 2024 19:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sWOxb-00021N-SH
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:30:30 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sWOxY-0007nj-Rd
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:30:23 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2cb55418470so3136273a91.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 16:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721777419; x=1722382219;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZgJi5SQCSbMcc3JoLYiq60wkxC/rvzt57z6OyFhCuXg=;
 b=KACedaErwKC0sgOzESimiqM0prM8urh4rQEMH8LtUsRbKZySjvysEq/1FbXIgiMbq3
 Ut57Zv4Itvi1cZSFM3d3VSKLbbbSbnFRzGyQRiYK/XHRrEdE64/tpwPjY+GvPD7CMrxs
 S1HFediU6JgEDrtnzU94askZ0C4FmlLKx2lo6eJdLz1GvoDnDv0iCXyfw11kQA76yFOw
 +G0IY2EkMGUfEMh/6nTCQ+aIZz52peqJNm78RaXI8Feq1Uj89iTJnTaY+dBSp91MUWoG
 wjH0BdiayIMHqNV2w6GIQHU+NYwVMqoM8D23jUAvYkhDrmoN+W1Z77HmiYNwOq/Ymzwi
 xkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721777419; x=1722382219;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZgJi5SQCSbMcc3JoLYiq60wkxC/rvzt57z6OyFhCuXg=;
 b=jEhTAP1+oGcpU5W9OX2Svf/JnlDtI4eMcXaegoFXZ7gWBHDsJ9XN/Qn+cwsMvzYe5o
 Xz6VqBtOf61VtvEYZ1wGeZybDdqQj48CRWNt14VaGvmu/seldRazBXEsfVPnZfgH1mA2
 LQKngm9dtaqZC6p5wObno73MhJpBoCUKA3r+inj0hCt8dIKxLEe8wNL8r0sptkuyHnsp
 sylAAp3giemEJFLD6S0VyUdZ1UrlDFzg1tbZHEJVRjRXgZgTUU3pbw8OUQAwS8DP7zTF
 HBsO5zr3HksEK+a1NzYBDCV6T/1fVQrJxy5umWxuODDwdtwxU47c8uAcKlgrmMCZWUlZ
 kjTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKsHpCzfjVAizpipp/vgFQBrJS7bamSlxQPPLgQcbA1ADt4I7fKDpnVjB8cxuLpZUR9abNmbMJcytEbbiVLDXR05yXXXM=
X-Gm-Message-State: AOJu0YyW3XYzAcXft5MaxzOkQfcgpa1wGWruHk3Gajq+Pw3ys7i9YidE
 RXqofnj0eQeMl27NFqYThjnN6kffESkAX44FFj388akdsfOqSpMUeAnxaVNfQFo=
X-Google-Smtp-Source: AGHT+IH9mMKm7G+VL4TF6/KVmF34yzCRT45M12U+7GwjiBVgJ5/6n8D+tV0UJaSd5ggsmRVTUMpitw==
X-Received: by 2002:a17:90b:1090:b0:2c9:5f1e:1a62 with SMTP id
 98e67ed59e1d1-2cdaf779b22mr1373930a91.36.1721777419203; 
 Tue, 23 Jul 2024 16:30:19 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cdb74e894csm179217a91.41.2024.07.23.16.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 16:30:18 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 23 Jul 2024 16:29:59 -0700
Subject: [PATCH v2 02/13] target/riscv: Decouple AIA processing from
 xiselect and xireg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-counter_delegation-v2-2-c4170a5348ca@rivosinc.com>
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
In-Reply-To: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=atishp@rivosinc.com; helo=mail-pj1-x1029.google.com
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

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
---
 target/riscv/csr.c | 165 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 139 insertions(+), 26 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ea3560342c4f..58be8bc3cc8c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -29,6 +29,7 @@
 #include "sysemu/cpu-timers.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
+#include <stdbool.h>
 
 /* CSR function table public API */
 void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
@@ -286,6 +287,15 @@ static RISCVException aia_any32(CPURISCVState *env, int csrno)
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
@@ -322,6 +332,30 @@ static RISCVException aia_smode32(CPURISCVState *env, int csrno)
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
@@ -341,6 +375,15 @@ static RISCVException hmode32(CPURISCVState *env, int csrno)
 
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
@@ -1928,6 +1971,22 @@ static int aia_xlate_vs_csrno(CPURISCVState *env, int csrno)
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
@@ -1935,7 +1994,7 @@ static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
     target_ulong *iselect;
 
     /* Translate CSR number for VS-mode */
-    csrno = aia_xlate_vs_csrno(env, csrno);
+    csrno = csrind_xlate_vs_csrno(env, csrno);
 
     /* Find the iselect CSR based on CSR number */
     switch (csrno) {
@@ -1964,6 +2023,12 @@ static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
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
@@ -2009,45 +2074,44 @@ static int rmw_iprio(target_ulong xlen,
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
@@ -2078,10 +2142,54 @@ static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
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
 
@@ -4981,8 +5089,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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
@@ -5100,8 +5210,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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
@@ -5180,9 +5292,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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


