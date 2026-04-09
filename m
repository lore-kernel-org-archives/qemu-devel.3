Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F59F364A3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAt9G-0008SU-7D; Thu, 09 Apr 2026 13:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bruno.vilaca.sa@gmail.com>)
 id 1wArhv-0000Pe-OV
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 11:54:15 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bruno.vilaca.sa@gmail.com>)
 id 1wArht-0001af-Kj
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 11:54:15 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d5e87a507so698537f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 08:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775750052; x=1776354852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+bS3oBPOM67AM47UVT5gqwWd2ValwtF8fgOSXa4buU=;
 b=Q+2bvs1UqDh19ZjV+VmAo5GuH11OT5+lu3iMumcX4u3u4R0bdnOMJvVtYqK2MH7AQL
 Fk3zHXW4RIlg1Csmqvi60K2eYzl6yQis7a4eXb1xCxQlJwwDHk0Eyok0B+019Hewnmxy
 1mSP0+FXUdnvCwN/2gG2uD04sZRyGxrfP2/XUWjDQ4FfWPodE2Jijqbv/Qhuef5quOFu
 doQMXjkJHjDRI8O3Hh7kyKLsnaA5yalQU0/9i1c9bp9oi8Cb0VZRz9Cr1dayDII4bZrO
 EUuwLFUbQ01b342paol5gpA+iFy6tt7E8PUCh/45fvAmO0iruoqzoCJ38c6o8dzZBU3O
 Txww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775750052; x=1776354852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G+bS3oBPOM67AM47UVT5gqwWd2ValwtF8fgOSXa4buU=;
 b=SYei9RTqxATRfWjBDiM8h1/gHuoh87+WFslQKv1PyM3BrSM0Oa6CIwoY+7X7c1z2x7
 XVZRkDcu5YG4PJREh2/gW9WgtpzMFfZnImxK/1HMeIiepkk1zyl3XFCfUb9E8HO7oiqN
 vn4MRqr1EQ5+1JXgd2kmUyqUsOgmvAtYEtnxtUDAwGDHaxJ9kzcnQYQXBbSKDD3Uy78p
 gAi6JddSV2CahqXLBddtxEobEZWS8/OuPhhYUnyFxGEtsW0BsvFmf4cJEMs3KHGVYxGH
 0sVQBp6rW+MRGL15Y/c0+juYwr3Rq3TcoSbFk6PmP52iydBZwOdD1UjySs7yFbmPVD2e
 ikaw==
X-Gm-Message-State: AOJu0Yy05ay5OSypnNuNHYb+oouyqJMNRQCGVt5R/IL5RnhMm/6+5mmT
 H9AxVTt7sdTwKNlMzMRwEt2bwIA9BpTZbp9K4e7qsKvKBP6mMp3/j3x4RmlS3L83Dt/7sw==
X-Gm-Gg: AeBDies7tOzkyc/gIxb+hGkWXvDqAJI0eP0lpcse6LVHF8jB0t2lKV+mm/m1oKRUtM4
 UiBPDrusVuCi3HQOSEyppnoySU/iz/pIuxCETHI7vEw0GHMLOhHvwh5KhL2ievNm5g0mCC4mRbb
 tLx8Z6tgw+BrC40JZ+Oc8pN6CrB4r2EKQMnuHTm0noy/FRWtXdrzv5mCL8idHlLJ8Gub2K4hYQ6
 SSywsHKbIliibzXCulrYN33lA5FtiwtxKTuYxTkG1rZR+9KxEKCp5dr5HyE/A3Xkzu0GYtVjemI
 5hK6rg+3UqT5qF8sacCP1dwMb6EBO6EyuNjIly0kOlTJbGgH1UKCqWK5gRP6FfbUw6eXVl5NWh3
 wAldD+VJlOoYoSBjiKGBjPjiCQmKh+r61YI1RFeaZJ74C4YZpSy+YjOXW8bJghaGFqZLSKrT7oj
 uiBgfazL+Sf3GQDtGyvcpu2zkheZPBdFkF2X33IBQxV2mIvAySMHU0EVzhOWtrnA9mcjTH
X-Received: by 2002:a05:6000:290b:b0:43b:3d4f:e17a with SMTP id
 ffacd0b85a97d-43d292ebf23mr38967109f8f.37.1775750051736; 
 Thu, 09 Apr 2026 08:54:11 -0700 (PDT)
Received: from ninolomata-AERO-15-KC.. (89-181-36-85.net.novis.pt.
 [89.181.36.85]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2c5468sm67259292f8f.13.2026.04.09.08.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 08:54:11 -0700 (PDT)
From: Bruno Sa <bruno.vilaca.sa@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Bruno Sa <bruno.vilaca.sa@gmail.com>
Subject: [PATCH 2/2] target/riscv: fix RV32 stateen CSR handling
Date: Thu,  9 Apr 2026 16:53:43 +0100
Message-ID: <20260409155344.2849233-3-bruno.vilaca.sa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409155344.2849233-1-bruno.vilaca.sa@gmail.com>
References: <20260409155344.2849233-1-bruno.vilaca.sa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=bruno.vilaca.sa@gmail.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Apr 2026 13:26:29 -0400
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
 target/riscv/csr.c | 112 +++++++++++++++++++++++++++++++--------------
 1 file changed, 77 insertions(+), 35 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d322bdbd47..015deca6dc 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -497,6 +497,15 @@ static RISCVException mstateen(CPURISCVState *env, int csrno)
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
@@ -528,6 +537,10 @@ static RISCVException hstateen(CPURISCVState *env, int csrno)
 
 static RISCVException hstateenh(CPURISCVState *env, int csrno)
 {
+    if (riscv_cpu_mxl(env) != MXL_RV32) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
     return hstateen_pred(env, csrno, CSR_HSTATEEN0H);
 }
 
@@ -3403,25 +3416,27 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
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
+        if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrind) {
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
+         * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if IMSIC is
+         * implemented. However, that information is with MachineState and we can't
+         * figure that out in csr.c. Just enable if Smaia is available.
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
@@ -3463,6 +3478,19 @@ static RISCVException write_mstateen0h(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_P1P13;
     }
 
+    if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrind) {
+        wr_mask |= SMSTATEEN0_SVSLCT;
+    }
+
+    /*
+     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if IMSIC is
+     * implemented. However, that information is with MachineState and we can't
+     * figure that out in csr.c. Just enable if Smaia is available.
+     */
+    if (riscv_cpu_cfg(env)->ext_smaia) {
+        wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
+    }
+
     if (riscv_cpu_cfg(env)->ext_ssctr) {
         wr_mask |= SMSTATEEN0_CTR;
     }
@@ -3507,22 +3535,23 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
     if (!riscv_has_ext(env, RVF)) {
         wr_mask |= SMSTATEEN0_FCSR;
     }
+    if (riscv_cpu_mxl(env) == MXL_RV64) {
+        if (riscv_cpu_cfg(env)->ext_ssaia || riscv_cpu_cfg(env)->ext_sscsrind) {
+            wr_mask |= SMSTATEEN0_SVSLCT;
+        }
 
-    if (riscv_cpu_cfg(env)->ext_ssaia || riscv_cpu_cfg(env)->ext_sscsrind) {
-        wr_mask |= SMSTATEEN0_SVSLCT;
-    }
-
-    /*
-     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if IMSIC is
-     * implemented. However, that information is with MachineState and we can't
-     * figure that out in csr.c. Just enable if Ssaia is available.
-     */
-    if (riscv_cpu_cfg(env)->ext_ssaia) {
-        wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
-    }
+        /*
+         * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if IMSIC is
+         * implemented. However, that information is with MachineState and we can't
+         * figure that out in csr.c. Just enable if Ssaia is available.
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
@@ -3564,6 +3593,19 @@ static RISCVException write_hstateen0h(CPURISCVState *env, int csrno,
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
+    if (riscv_cpu_cfg(env)->ext_ssaia || riscv_cpu_cfg(env)->ext_sscsrind) {
+        wr_mask |= SMSTATEEN0_SVSLCT;
+    }
+
+    /*
+     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if IMSIC is
+     * implemented. However, that information is with MachineState and we can't
+     * figure that out in csr.c. Just enable if Ssaia is available.
+     */
+    if (riscv_cpu_cfg(env)->ext_ssaia) {
+        wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
+    }
+
     if (riscv_cpu_cfg(env)->ext_ssctr) {
         wr_mask |= SMSTATEEN0_CTR;
     }
@@ -3613,7 +3655,7 @@ static RISCVException write_sstateen(CPURISCVState *env, int csrno,
 static RISCVException write_sstateen0(CPURISCVState *env, int csrno,
                                       target_ulong new_val)
 {
-    uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
+    uint64_t wr_mask = 0;
 
     if (!riscv_has_ext(env, RVF)) {
         wr_mask |= SMSTATEEN0_FCSR;
@@ -5861,25 +5903,25 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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


