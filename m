Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60028F364DB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 11:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB9k3-00079W-8Y; Fri, 10 Apr 2026 07:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bruno.vilaca.sa@gmail.com>)
 id 1wB9k2-000797-0d
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 07:09:38 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bruno.vilaca.sa@gmail.com>)
 id 1wB9k0-0003Tt-18
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 07:09:37 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488a4bc360bso10696925e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 04:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775819374; x=1776424174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wL2RjIiakxvUiKqLallUtvD80SyqMUagJMAW4JWo6rY=;
 b=oG8uh/8O41McF7zJS5zlKIGuxIvm8Hr5gM41BQWyLqgE2cfPXDHTCBv4iFv/mmWSZ1
 Fr1o/adNHC6U+++fEaK0reZmsefDLR+edZ59ZEcCVbxQOBuB4C7iRfoEjKf9guGXGj3e
 m1pC4b1dexAMlOPGfls1O/y9UL3qRY8Hp1lE5KKbNV/EoN44ZsSv3/MFWZsaN50y9cKL
 l15dZ/Mb8drtWWsrikwLeclzlCnvVyAsmzdHH1lwzsQq+YUksMlhfVa5KXj1lYdLeLWD
 c9t5rXragZM7M8stZECCUjyRkD4fRLHUOYcVyC2EW+HQDeKT1ttzNcOPHHXw27H+XoL9
 J5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775819374; x=1776424174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wL2RjIiakxvUiKqLallUtvD80SyqMUagJMAW4JWo6rY=;
 b=BdHDzQkUFyTk8ZXbkig2Y9tSjPECWHEQhFGGxD6BMhMLT9ziAEZTX0pkZSB6ndj9OV
 hOGj0395IqnZsoAIa6tVSiifrCEdYI9pOehwhGdDq9oEruzOMsUtTrwQDWuwx7x+13Gu
 PBCHB02xbRg/hULN/kp9HUoAaOsQKgY6QYCy0DMT5SAzknwXid2qmtQoritmoZf8VaYH
 3PV1o3jsy/9pRdZIx6qjXZKin+w+HGuHtwk+xMCmPuv6jMCzba9cQDHkuOCmxPkiI6UI
 ePZgejcxVi+pRaCgIiklG/lsoXHBSNoSi23SyusyQ0XxeJMHzAecLc0eTYNTLTPdFv3x
 7aAA==
X-Gm-Message-State: AOJu0YxhjVawLmtFic7hfX23rFunaQWqHVHnJZrqfJxU9R1ABqxhL4cs
 JfYHQm/t32pmj47xju19zSMlrfBWWduPPWok0IUdr3YWyxOU6xseNt9zfV66Gl/h
X-Gm-Gg: AeBDievC7RZmsyvPXF08qAVe/XToBJZb16HO4xQ02K7w4aZirfadBl9JhXySwWIGfWG
 7A7uEl4THBlaCPP66qieL7dRSL/3h64oT+a+I1Ea6BFteB3Ye2xF+yduRaBTQzn7VvzJ1EFAzPc
 mDp3T6EJIck6z0qMdFGSf9aQSpRww6wPsgIQMQXgo+joLgPsatDZcIJle5/cxK5s6G6Yh0OcNLr
 NpWMAglKRBs7xzKvds1fMrbbmGSEhOM4pxmn2rnDdLX3V37eVfCG+busCWU78HNgtM10NFUW/FV
 W8xFzwFTqDN0nIPMaD4oyCTD2gGlN0iUCwaHiuPVi6ckE1pbqVKZJLtItXVloxCLoR/hYf33x++
 avbyV1kzBQ8H+umwasshBjPm0pMv5P67SeOvwiaRR5Xprjs4MVOt0FSoqxBPo4ALAkn1P01xmX5
 v7GijperKH+yRn1FsBWv4HEBeOBh5w2KfPl7kQZulgH/VQsfXWPh57y26iyEk98s3AnarQ
X-Received: by 2002:a05:600c:a105:b0:485:3af5:7e53 with SMTP id
 5b1f17b1804b1-488d6839821mr23465265e9.19.1775819373838; 
 Fri, 10 Apr 2026 04:09:33 -0700 (PDT)
Received: from ninolomata-AERO-15-KC.. (89-181-36-85.net.novis.pt.
 [89.181.36.85]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5dc7070sm19311605e9.10.2026.04.10.04.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 04:09:33 -0700 (PDT)
From: Bruno Sa <bruno.vilaca.sa@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Bruno Sa <bruno.vilaca.sa@gmail.com>
Subject: [PATCH v2] target/riscv: fix RV32 stateen CSR handling
Date: Fri, 10 Apr 2026 12:08:42 +0100
Message-ID: <20260410110928.1014170-1-bruno.vilaca.sa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409155344.2849233-1-bruno.vilaca.sa@gmail.com>
References: <20260409155344.2849233-1-bruno.vilaca.sa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=bruno.vilaca.sa@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The RV32 stateen CSRs are split between the low-half CSR and the
corresponding xH CSR, but the current implementation still handles some
upper-half bits through the low-half write paths and also accepts the
xH CSRs on RV64.

Fix this by:
- rejecting mstateen*h and hstateen*h accesses on RV64
- keeping the RV64-only writable bits in the low-half write paths
- handling the RV32 upper-half writable bits in write_mstateen0h() and
  write_hstateen0h()
- dropping unsupported writable bits from write_sstateen0()

Signed-off-by: Bruno Sa <bruno.vilaca.sa@gmail.com>
---
v2:
- rebase on riscv-to-apply.next
- resend only patch 2 after patch 1 was applied
- wrap the AIA comment text to keep checkpatch clean

 target/riscv/csr.c | 117 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 83 insertions(+), 34 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index cfd076b368..80727aa81e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -502,6 +502,15 @@ static RISCVException mstateen(CPURISCVState *env, int csrno)
     return any(env, csrno);
 }
 
+static RISCVException mstateen_32(CPURISCVState *env, int csrno)
+{
+    if (riscv_cpu_mxl(env) != MXL_RV32) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return mstateen(env, csrno);
+}
+
 static RISCVException hstateen_pred(CPURISCVState *env, int csrno, int base)
 {
     if (!riscv_cpu_cfg(env)->ext_smstateen) {
@@ -533,6 +542,10 @@ static RISCVException hstateen(CPURISCVState *env, int csrno)
 
 static RISCVException hstateenh(CPURISCVState *env, int csrno)
 {
+    if (riscv_cpu_mxl(env) != MXL_RV32) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
     return hstateen_pred(env, csrno, CSR_HSTATEEN0H);
 }
 
@@ -3447,25 +3460,29 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_FCSR;
     }
 
-    if (env->priv_ver >= PRIV_VERSION_1_13_0) {
-        wr_mask |= SMSTATEEN0_P1P13;
-    }
+    if (riscv_cpu_mxl(env) == MXL_RV64) {
+        if (env->priv_ver >= PRIV_VERSION_1_13_0) {
+            wr_mask |= SMSTATEEN0_P1P13;
+        }
 
-    if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrind) {
-        wr_mask |= SMSTATEEN0_SVSLCT;
-    }
+        if (riscv_cpu_cfg(env)->ext_smaia ||
+            riscv_cpu_cfg(env)->ext_smcsrind) {
+            wr_mask |= SMSTATEEN0_SVSLCT;
+        }
 
-    /*
-     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if IMSIC is
-     * implemented. However, that information is with MachineState and we can't
-     * figure that out in csr.c. Just enable if Smaia is available.
-     */
-    if (riscv_cpu_cfg(env)->ext_smaia) {
-        wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
-    }
+        /*
+         * As per the AIA specification, SMSTATEEN0_IMSIC is valid
+         * only if IMSIC is implemented. However, that information is
+         * with MachineState and we can't figure that out in csr.c.
+         * Just enable if Smaia is available.
+         */
+        if (riscv_cpu_cfg(env)->ext_smaia) {
+            wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
+        }
 
-    if (riscv_cpu_cfg(env)->ext_ssctr) {
-        wr_mask |= SMSTATEEN0_CTR;
+        if (riscv_cpu_cfg(env)->ext_ssctr) {
+            wr_mask |= SMSTATEEN0_CTR;
+        }
     }
 
     return write_mstateen(env, csrno, wr_mask, new_val);
@@ -3507,6 +3524,20 @@ static RISCVException write_mstateen0h(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_P1P13;
     }
 
+    if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrind) {
+        wr_mask |= SMSTATEEN0_SVSLCT;
+    }
+
+    /*
+     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if
+     * IMSIC is implemented. However, that information is with
+     * MachineState and we can't figure that out in csr.c. Just enable
+     * if Smaia is available.
+     */
+    if (riscv_cpu_cfg(env)->ext_smaia) {
+        wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
+    }
+
     if (riscv_cpu_cfg(env)->ext_ssctr) {
         wr_mask |= SMSTATEEN0_CTR;
     }
@@ -3552,21 +3583,25 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_FCSR;
     }
 
-    if (riscv_cpu_cfg(env)->ext_ssaia || riscv_cpu_cfg(env)->ext_sscsrind) {
-        wr_mask |= SMSTATEEN0_SVSLCT;
-    }
+    if (riscv_cpu_mxl(env) == MXL_RV64) {
+        if (riscv_cpu_cfg(env)->ext_ssaia ||
+            riscv_cpu_cfg(env)->ext_sscsrind) {
+            wr_mask |= SMSTATEEN0_SVSLCT;
+        }
 
-    /*
-     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if IMSIC is
-     * implemented. However, that information is with MachineState and we can't
-     * figure that out in csr.c. Just enable if Ssaia is available.
-     */
-    if (riscv_cpu_cfg(env)->ext_ssaia) {
-        wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
-    }
+        /*
+         * As per the AIA specification, SMSTATEEN0_IMSIC is valid
+         * only if IMSIC is implemented. However, that information is
+         * with MachineState and we can't figure that out in csr.c.
+         * Just enable if Ssaia is available.
+         */
+        if (riscv_cpu_cfg(env)->ext_ssaia) {
+            wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
+        }
 
-    if (riscv_cpu_cfg(env)->ext_ssctr) {
-        wr_mask |= SMSTATEEN0_CTR;
+        if (riscv_cpu_cfg(env)->ext_ssctr) {
+            wr_mask |= SMSTATEEN0_CTR;
+        }
     }
 
     return write_hstateen(env, csrno, wr_mask, new_val);
@@ -3608,6 +3643,20 @@ static RISCVException write_hstateen0h(CPURISCVState *env, int csrno,
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
+    if (riscv_cpu_cfg(env)->ext_ssaia || riscv_cpu_cfg(env)->ext_sscsrind) {
+        wr_mask |= SMSTATEEN0_SVSLCT;
+    }
+
+    /*
+     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if
+     * IMSIC is implemented. However, that information is with
+     * MachineState and we can't figure that out in csr.c. Just enable
+     * if Ssaia is available.
+     */
+    if (riscv_cpu_cfg(env)->ext_ssaia) {
+        wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
+    }
+
     if (riscv_cpu_cfg(env)->ext_ssctr) {
         wr_mask |= SMSTATEEN0_CTR;
     }
@@ -3657,7 +3706,7 @@ static RISCVException write_sstateen(CPURISCVState *env, int csrno,
 static RISCVException write_sstateen0(CPURISCVState *env, int csrno,
                                       target_ulong new_val, uintptr_t ra)
 {
-    uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
+    uint64_t wr_mask = 0;
 
     if (!riscv_has_ext(env, RVF)) {
         wr_mask |= SMSTATEEN0_FCSR;
@@ -5937,25 +5986,25 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /* Smstateen extension CSRs */
     [CSR_MSTATEEN0] = { "mstateen0", mstateen, read_mstateen, write_mstateen0,
                         .min_priv_ver = PRIV_VERSION_1_12_0 },
-    [CSR_MSTATEEN0H] = { "mstateen0h", mstateen, read_mstateenh,
+    [CSR_MSTATEEN0H] = { "mstateen0h", mstateen_32, read_mstateenh,
                           write_mstateen0h,
                          .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MSTATEEN1] = { "mstateen1", mstateen, read_mstateen,
                         write_mstateen_1_3,
                         .min_priv_ver = PRIV_VERSION_1_12_0 },
-    [CSR_MSTATEEN1H] = { "mstateen1h", mstateen, read_mstateenh,
+    [CSR_MSTATEEN1H] = { "mstateen1h", mstateen_32, read_mstateenh,
                          write_mstateenh_1_3,
                          .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MSTATEEN2] = { "mstateen2", mstateen, read_mstateen,
                         write_mstateen_1_3,
                         .min_priv_ver = PRIV_VERSION_1_12_0 },
-    [CSR_MSTATEEN2H] = { "mstateen2h", mstateen, read_mstateenh,
+    [CSR_MSTATEEN2H] = { "mstateen2h", mstateen_32, read_mstateenh,
                          write_mstateenh_1_3,
                          .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MSTATEEN3] = { "mstateen3", mstateen, read_mstateen,
                         write_mstateen_1_3,
                         .min_priv_ver = PRIV_VERSION_1_12_0 },
-    [CSR_MSTATEEN3H] = { "mstateen3h", mstateen, read_mstateenh,
+    [CSR_MSTATEEN3H] = { "mstateen3h", mstateen_32, read_mstateenh,
                          write_mstateenh_1_3,
                          .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_HSTATEEN0] = { "hstateen0", hstateen, read_hstateen, write_hstateen0,
-- 
2.43.0
Rebased on riscv-to-apply.next as requested.

Patch 1 was already applied, so this v2 resends only patch 2.

Thanks,
Bruno

