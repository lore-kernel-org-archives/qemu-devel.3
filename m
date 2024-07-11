Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25361C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 22:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS2KK-0000dy-M2; Thu, 11 Jul 2024 18:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sS2KH-0000Uk-3T
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:31:45 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sS2KE-0001cF-0Q
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:31:44 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fbda48631cso12444185ad.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 15:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720737101; x=1721341901;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c2aUGiaMNRO1teaIsDzXQAbFpXYW8NxpBsGk4ccdXZs=;
 b=MEmM8FkTzOQ9MTpI2IAGXPiZ5d0omJ5V6lAb2e0JrhxsHdBWnChQMiTYKKmPBtZX3/
 QOVxaktwvH1X7kD7yK05F6D1d4ds9EnO4/jV82z3AxAquDf2OnvvTtdFvQKFeWJyxuxZ
 WQeZ5nZpibnWv8MxExAFTR+oHt0S4o3NLwTv1FvS3VejOY/Aasub35PxXLMRgv7ymYqt
 OOt21LCzoiMAkhyrXKKDSZWAQFq8eybRhD5yvuxepmZRpzdfhcrONRFIJQgpcwTsJ/75
 zzC0QTf/iQaoEAqTJIYNjVFfaKh6mKRkzTkdPDZnavUJEY+ULRPSUumPLOba3+TcO13w
 SXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720737101; x=1721341901;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c2aUGiaMNRO1teaIsDzXQAbFpXYW8NxpBsGk4ccdXZs=;
 b=JimITFeAxhviXus3oTpEYkl4gKIZXsKf8BHPxskGr7zVM8MMA+qY05IAZE6Y5URIym
 PyrO4U7aJrR/dexSR6MVObKkaxqMqFXsTnHfm7zrWuE+ahyZfavlUbJ7FC1sSB8NSX+d
 LzRiCN8iRTDO/zhLHBJfsuhOSaEHaKaFZPucO7wvf3q6JXrhGHnSHCwJaIlEgLWEnrTY
 UzT+JmjtMyJZrrRAa3GGWCnY9VXcrgxTeJhwHvX/Z8FQbQdjDlrBOboYmgdFTbMHfWkF
 s1JyuViM3/bUR5/E/G6tmKdgxWHcVzv7a6GJb13RT84nygFlH8nPnxcGLwWhAYuw5v2Q
 4iFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU7HW9r8PUgNENVeZpZUQSnAuptfohDHqv+C5sw+9BeW4Ekp3YPlfmSwsreQ3Hc6Z2GX7oaNE76vqgc+ZhxOmBMMzGjBg=
X-Gm-Message-State: AOJu0Yw8+rELb1XWAZqnHEman9RolqJTtr71jgmw793gsU2sHSOeiuL7
 QcKg55MTu7vlkNie07jtIKxivLVKRi5Y6Rs7EcCdKSO10xLedrb8cF/iVGwvbS4=
X-Google-Smtp-Source: AGHT+IF9hmjCau+XFnWg/jUWbU6eSAYnpg24cxANZmH7vQxOEe9iHYv9uzCG87e0VALLF8ZYa2xhmQ==
X-Received: by 2002:a17:903:2342:b0:1f4:a04e:8713 with SMTP id
 d9443c01a7336-1fbf0d843d7mr13633215ad.28.1720737097164; 
 Thu, 11 Jul 2024 15:31:37 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6b34ca2sm55161565ad.53.2024.07.11.15.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 15:31:35 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 11 Jul 2024 15:31:08 -0700
Subject: [PATCH v8 05/13] target/riscv: Add cycle & instret privilege mode
 filtering support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-smcntrpmf_v7-v8-5-b7c38ae7b263@rivosinc.com>
References: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
In-Reply-To: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

QEMU only calculates dummy cycles and instructions, so there is no
actual means to stop the icount in QEMU. Hence this patch merely adds
the functionality of accessing the cfg registers, and cause no actual
effects on the counting of cycle and instret counters.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
---
 target/riscv/cpu_bits.h |  12 +++++
 target/riscv/csr.c      | 138 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 5faa817453bb..32b068f18aa5 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -926,6 +926,18 @@ typedef enum RISCVException {
 #define MHPMEVENT_BIT_VUINH                BIT_ULL(58)
 #define MHPMEVENTH_BIT_VUINH               BIT(26)
 
+#define MHPMEVENT_FILTER_MASK              (MHPMEVENT_BIT_MINH  | \
+                                            MHPMEVENT_BIT_SINH  | \
+                                            MHPMEVENT_BIT_UINH  | \
+                                            MHPMEVENT_BIT_VSINH | \
+                                            MHPMEVENT_BIT_VUINH)
+
+#define MHPMEVENTH_FILTER_MASK              (MHPMEVENTH_BIT_MINH  | \
+                                            MHPMEVENTH_BIT_SINH  | \
+                                            MHPMEVENTH_BIT_UINH  | \
+                                            MHPMEVENTH_BIT_VSINH | \
+                                            MHPMEVENTH_BIT_VUINH)
+
 #define MHPMEVENT_SSCOF_MASK               _ULL(0xFFFF000000000000)
 #define MHPMEVENT_IDX_MASK                 0xFFFFF
 #define MHPMEVENT_SSCOF_RESVD              16
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 3ad851707e5c..b814d176cbb8 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -30,7 +30,6 @@
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
 
-
 /* CSR function table public API */
 void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
 {
@@ -236,6 +235,24 @@ static RISCVException sscofpmf_32(CPURISCVState *env, int csrno)
     return sscofpmf(env, csrno);
 }
 
+static RISCVException smcntrpmf(CPURISCVState *env, int csrno)
+{
+    if (!riscv_cpu_cfg(env)->ext_smcntrpmf) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException smcntrpmf_32(CPURISCVState *env, int csrno)
+{
+    if (riscv_cpu_mxl(env) != MXL_RV32) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return smcntrpmf(env, csrno);
+}
+
 static RISCVException any(CPURISCVState *env, int csrno)
 {
     return RISCV_EXCP_NONE;
@@ -830,6 +847,111 @@ static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
 
 #else /* CONFIG_USER_ONLY */
 
+static RISCVException read_mcyclecfg(CPURISCVState *env, int csrno,
+                                     target_ulong *val)
+{
+    *val = env->mcyclecfg;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
+                                      target_ulong val)
+{
+    uint64_t inh_avail_mask;
+
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        env->mcyclecfg = val;
+    } else {
+        /* Set xINH fields if priv mode supported */
+        inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MCYCLECFG_BIT_MINH;
+        inh_avail_mask |= riscv_has_ext(env, RVU) ? MCYCLECFG_BIT_UINH : 0;
+        inh_avail_mask |= riscv_has_ext(env, RVS) ? MCYCLECFG_BIT_SINH : 0;
+        inh_avail_mask |= (riscv_has_ext(env, RVH) &&
+                           riscv_has_ext(env, RVU)) ? MCYCLECFG_BIT_VUINH : 0;
+        inh_avail_mask |= (riscv_has_ext(env, RVH) &&
+                           riscv_has_ext(env, RVS)) ? MCYCLECFG_BIT_VSINH : 0;
+        env->mcyclecfg = val & inh_avail_mask;
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mcyclecfgh(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val = env->mcyclecfgh;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mcyclecfgh(CPURISCVState *env, int csrno,
+                                       target_ulong val)
+{
+    target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
+                                                 MCYCLECFGH_BIT_MINH);
+
+    /* Set xINH fields if priv mode supported */
+    inh_avail_mask |= riscv_has_ext(env, RVU) ? MCYCLECFGH_BIT_UINH : 0;
+    inh_avail_mask |= riscv_has_ext(env, RVS) ? MCYCLECFGH_BIT_SINH : 0;
+    inh_avail_mask |= (riscv_has_ext(env, RVH) &&
+                       riscv_has_ext(env, RVU)) ? MCYCLECFGH_BIT_VUINH : 0;
+    inh_avail_mask |= (riscv_has_ext(env, RVH) &&
+                       riscv_has_ext(env, RVS)) ? MCYCLECFGH_BIT_VSINH : 0;
+
+    env->mcyclecfgh = val & inh_avail_mask;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_minstretcfg(CPURISCVState *env, int csrno,
+                                       target_ulong *val)
+{
+    *val = env->minstretcfg;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_minstretcfg(CPURISCVState *env, int csrno,
+                                        target_ulong val)
+{
+    uint64_t inh_avail_mask;
+
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        env->minstretcfg = val;
+    } else {
+        inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MINSTRETCFG_BIT_MINH;
+        inh_avail_mask |= riscv_has_ext(env, RVU) ? MINSTRETCFG_BIT_UINH : 0;
+        inh_avail_mask |= riscv_has_ext(env, RVS) ? MINSTRETCFG_BIT_SINH : 0;
+        inh_avail_mask |= (riscv_has_ext(env, RVH) &&
+                           riscv_has_ext(env, RVU)) ? MINSTRETCFG_BIT_VUINH : 0;
+        inh_avail_mask |= (riscv_has_ext(env, RVH) &&
+                           riscv_has_ext(env, RVS)) ? MINSTRETCFG_BIT_VSINH : 0;
+        env->minstretcfg = val & inh_avail_mask;
+    }
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_minstretcfgh(CPURISCVState *env, int csrno,
+                                        target_ulong *val)
+{
+    *val = env->minstretcfgh;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_minstretcfgh(CPURISCVState *env, int csrno,
+                                         target_ulong val)
+{
+    target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
+                                                 MINSTRETCFGH_BIT_MINH);
+
+    inh_avail_mask |= riscv_has_ext(env, RVU) ? MINSTRETCFGH_BIT_UINH : 0;
+    inh_avail_mask |= riscv_has_ext(env, RVS) ? MINSTRETCFGH_BIT_SINH : 0;
+    inh_avail_mask |= (riscv_has_ext(env, RVH) &&
+                       riscv_has_ext(env, RVU)) ? MINSTRETCFGH_BIT_VUINH : 0;
+    inh_avail_mask |= (riscv_has_ext(env, RVH) &&
+                       riscv_has_ext(env, RVS)) ? MINSTRETCFGH_BIT_VSINH : 0;
+
+    env->minstretcfgh = val & inh_avail_mask;
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
                                      target_ulong *val)
 {
@@ -5051,6 +5173,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
                              write_mcountinhibit,
                              .min_priv_ver = PRIV_VERSION_1_11_0       },
 
+    [CSR_MCYCLECFG]      = { "mcyclecfg",   smcntrpmf, read_mcyclecfg,
+                             write_mcyclecfg,
+                             .min_priv_ver = PRIV_VERSION_1_12_0       },
+    [CSR_MINSTRETCFG]    = { "minstretcfg", smcntrpmf, read_minstretcfg,
+                             write_minstretcfg,
+                             .min_priv_ver = PRIV_VERSION_1_12_0       },
+
     [CSR_MHPMEVENT3]     = { "mhpmevent3",     any,    read_mhpmevent,
                              write_mhpmevent                           },
     [CSR_MHPMEVENT4]     = { "mhpmevent4",     any,    read_mhpmevent,
@@ -5110,6 +5239,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MHPMEVENT31]    = { "mhpmevent31",    any,    read_mhpmevent,
                              write_mhpmevent                           },
 
+    [CSR_MCYCLECFGH]     = { "mcyclecfgh",   smcntrpmf_32, read_mcyclecfgh,
+                             write_mcyclecfgh,
+                             .min_priv_ver = PRIV_VERSION_1_12_0        },
+    [CSR_MINSTRETCFGH]   = { "minstretcfgh", smcntrpmf_32, read_minstretcfgh,
+                             write_minstretcfgh,
+                             .min_priv_ver = PRIV_VERSION_1_12_0        },
+
     [CSR_MHPMEVENT3H]    = { "mhpmevent3h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },

-- 
2.34.1


