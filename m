Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E62C02187
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJtQ-00061V-Fv; Sat, 18 Jan 2025 20:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtO-0005uO-MZ
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:22 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtM-0003Lj-KI
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:22 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ee8e8e29f6so4529506a91.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249259; x=1737854059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/3TWfxPzbk8GdOAObMqIQTqu44K3ivAZE5SsqB8jMNE=;
 b=Iq6bb45nS23inKZBxWHAfGrDL3nO71oOWB2hF2IlK9JlTxGtzi+2rocjHMaeXqedZK
 atbHzUpsHXd/vrt7auJHKJ0GrJ6kV3bbdaE3L5f2LF80zqGo9mk7Gg1QGLPWAPppmNjg
 TYwlCP7cEalrMVCt11bE/ou6MmTSMwBxdzonyYwl+RDvPOdVA/sLlVfnaAPjH0rALXx1
 wins+/GejjJXD1tjIAAAwpRsyuQt8VmP8MQHt59DBwKmrSI63/QP0K+jGm5ZKo6Li6+6
 ln3JTZazUHv4e8VKesehZGUnhRNQ0brPZiGvJGQulWiCKCWEI95QyDpw1Q86q8B9lDzz
 wxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249259; x=1737854059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/3TWfxPzbk8GdOAObMqIQTqu44K3ivAZE5SsqB8jMNE=;
 b=uHAc9KWmaalSqgwaliiAlal8wQ88Lr24xKDLaYqVQe27/DRFaORWHVBh04XOCGI9uB
 zBn5oChrNORvSQakhQuNpmVybFOY3b+nK6Eq1nMMOur03pziF3DJ/UkYgkNJ/YXVcJ3f
 jyojkAw1FaeKTEuUAU+y5we+lzZMGcWNSfCOo/qUB3blWkhEriDzNvWtqcL+sI34nqF7
 gbnzLUGi2L7UTOIiSYqJzzawPiIBzen/uEpnCGSKZKYTBfohEbJRUhZ2zHqlAn+0W4pe
 s5SrG2iLR6wjXHvM7qZodhjzuqwvpaYTwrAIy1tuKw0PLl8SorugShIEjtgAaKHfRB2z
 0Qyw==
X-Gm-Message-State: AOJu0YyEnntMGfANQCYJX/wM7wMjMUwPd6wAtxYb4JorB7q63TC49C6l
 RgB/FIhJTzsttPIEtEm4vySZOl5Ya+beRPZ4h2djC2kh3MQvIUVa78OQ7Loi
X-Gm-Gg: ASbGnctUPzV8hVzuKwH6ENWnWBfD1QpTAT3g8wOvYvb5QlbX882hOcnV0d/Nj9D51Ib
 r7Cu4QnxenyuwFbu3MU3lIRDVP/GIJ3hdon1YeytRXk/TXrMfbb/TY0UdwUDd9kV4mjsT7IMDSJ
 h8YGG4SjKEt4nuK4x7hKKFZvnEGbinl1wlC4xmRd2o72UiMbdpediMSS/uB88ZopbcW6ebXtFfG
 nW5mUgjAl1rTZAoZMVJc1Dz/mjpdqxuT1Y/g7LLLjfvreV2XuhXLYQXSGO73lMxIZd9r4Zzr9Cm
 PGWF8RZqa/rQONx35FSpsGh5ya0G2ouPi+0mvSVwLFxvfBChsiPbOnr5fE3bSg/2owvenJUKqA=
 =
X-Google-Smtp-Source: AGHT+IHIFb6dutPQBjjku5VPR5fGuVztIMgf3o8kyHu7UDu7d7mUcK0lyFEAmG0LgSGPABdrVMgpFg==
X-Received: by 2002:a17:90b:1f91:b0:2f1:4715:5987 with SMTP id
 98e67ed59e1d1-2f782c92749mr11945192a91.9.1737249258887; 
 Sat, 18 Jan 2025 17:14:18 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:14:18 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Kaiwen Xue <kaiwenx@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Atish Patra <atishp@rivosinc.com>
Subject: [PULL v2 29/50] target/riscv: Decouple AIA processing from xiselect
 and xireg
Date: Sun, 19 Jan 2025 11:12:04 +1000
Message-ID: <20250119011225.11452-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1029.google.com
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

Since xiselect and xireg also will be of use in sxcsrind, AIA should
have its own separated interface when those CSRs are accessed.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20250110-counter_delegation-v5-2-e83d797ae294@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 165 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 139 insertions(+), 26 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index af9766759a..123e9fd2bd 100644
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
2.48.1


