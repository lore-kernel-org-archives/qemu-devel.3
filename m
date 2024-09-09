Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12305ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 16:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snhAC-0002O4-Pw; Mon, 09 Sep 2024 12:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhA8-000274-Mo
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:22:49 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhA5-0007fv-7Q
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:22:48 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-70b2421471aso2984219a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 09:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725898962; x=1726503762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b76wfqWpuwoFDlLIxKLPUFdGu7bZu4H9hMXKBVkHcrw=;
 b=pfz1fKITTjZrcVCB5zP6nmyZ8yeQoOENw0Zx38+ZeI9goRlICLf41d3QqA5B6bUyoI
 DLl8IhQkoVUVDMcNEFyhiKGEDc49n4N9z9H/MubPGbZFPi1EV5s8e5dn0VDU6kWRCIIi
 /AgKE7V/bcEbp7k8wk2Sl/Qd2Qx08WqoxtYPW5NJ9CJIOa7HSAKHrHKWnffZuv2AUMlm
 iXVVYSZUoxOHcOt+EySfS0sDELn1neu5QDfE11V1OryM/CZUPYrAPr/YRt843g3DCswe
 uDqK7vUOGe8LTVcnCDCYAg7/U5umrsCf90DU9LDZmisFWH7BTVXtIETeGWex4PkcajYw
 j0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725898962; x=1726503762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b76wfqWpuwoFDlLIxKLPUFdGu7bZu4H9hMXKBVkHcrw=;
 b=PwRK+lNZVnKUc6cyumJN23K2jB+Nt2cQPVv/L3aU3F5MkHKEfRbjN8vFlrPHee6YcZ
 IjcsuN4EZAEU2LvlUffl1NUBXZyR+HZKC33RtjV58kF5LI64qjX9GjQwuYoOwh0X3yVW
 vRp+efr4M1R7gBOx16kskXRz/M6Yu/GsdyxVFH/TVRFbWH4HcEGjdYJPj5ZWDDUxucqX
 Xv8vN0yVu8MYtGpL1TdkQbCIwtupV3/RarPyrxsNMmDsZ5xwcBuJQ62J2GN8rb051v9C
 uzmH/oJdVz9PIZO4Bmvpj6H2sml8R6ChyEo4+rky26uYGMnCEJCMLrwrLMS60RvG82NV
 daoQ==
X-Gm-Message-State: AOJu0YyYQUstyFdFXRp3MCjWsS4n6ygABomrHcvUR6uzVm3g2lZC96hv
 VZ2npsfe4PfE9Zy5/bnhWipPMs+JbzaRUjOoR9meNtANU3H2z4bVGkFN3I3r4N2SRsRij2fDtRx
 D
X-Google-Smtp-Source: AGHT+IE/+rjZDzA6sRPA0UNB3VJntWVWBReW2YF2+Ze+yJEQnrU9vYz6VqSVv60iTqeQogAemokFEA==
X-Received: by 2002:a05:6a21:6f01:b0:1cf:38a2:c4a9 with SMTP id
 adf61e73a8af0-1cf38a2c71dmr4545375637.20.1725898962367; 
 Mon, 09 Sep 2024 09:22:42 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f35d79sm35753305ad.288.2024.09.09.09.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 09:22:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 01/29] target/arm: Replace tcg_gen_dupi_vec with constants
 in gengvec.c
Date: Mon,  9 Sep 2024 09:22:11 -0700
Message-ID: <20240909162240.647173-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909162240.647173-1-richard.henderson@linaro.org>
References: <20240909162240.647173-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Instead of copying a constant into a temporary with dupi,
use a vector constant directly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/gengvec.c | 43 ++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 56a1dc1f75..726a1383ae 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -297,10 +297,9 @@ void gen_srshr32_i32(TCGv_i32 d, TCGv_i32 a, int32_t sh)
 static void gen_srshr_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
 {
     TCGv_vec t = tcg_temp_new_vec_matching(d);
-    TCGv_vec ones = tcg_temp_new_vec_matching(d);
+    TCGv_vec ones = tcg_constant_vec_matching(d, vece, 1);
 
     tcg_gen_shri_vec(vece, t, a, sh - 1);
-    tcg_gen_dupi_vec(vece, ones, 1);
     tcg_gen_and_vec(vece, t, t, ones);
     tcg_gen_sari_vec(vece, d, a, sh);
     tcg_gen_add_vec(vece, d, d, t);
@@ -492,10 +491,9 @@ void gen_urshr64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
 static void gen_urshr_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t shift)
 {
     TCGv_vec t = tcg_temp_new_vec_matching(d);
-    TCGv_vec ones = tcg_temp_new_vec_matching(d);
+    TCGv_vec ones = tcg_constant_vec_matching(d, vece, 1);
 
     tcg_gen_shri_vec(vece, t, a, shift - 1);
-    tcg_gen_dupi_vec(vece, ones, 1);
     tcg_gen_and_vec(vece, t, t, ones);
     tcg_gen_shri_vec(vece, d, a, shift);
     tcg_gen_add_vec(vece, d, d, t);
@@ -685,9 +683,9 @@ static void gen_shr64_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 static void gen_shr_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
 {
     TCGv_vec t = tcg_temp_new_vec_matching(d);
-    TCGv_vec m = tcg_temp_new_vec_matching(d);
+    int64_t mi = MAKE_64BIT_MASK((8 << vece) - sh, sh);
+    TCGv_vec m = tcg_constant_vec_matching(d, vece, mi);
 
-    tcg_gen_dupi_vec(vece, m, MAKE_64BIT_MASK((8 << vece) - sh, sh));
     tcg_gen_shri_vec(vece, t, a, sh);
     tcg_gen_and_vec(vece, d, d, m);
     tcg_gen_or_vec(vece, d, d, t);
@@ -773,10 +771,9 @@ static void gen_shl64_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 static void gen_shl_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
 {
     TCGv_vec t = tcg_temp_new_vec_matching(d);
-    TCGv_vec m = tcg_temp_new_vec_matching(d);
+    TCGv_vec m = tcg_constant_vec_matching(d, vece, MAKE_64BIT_MASK(0, sh));
 
     tcg_gen_shli_vec(vece, t, a, sh);
-    tcg_gen_dupi_vec(vece, m, MAKE_64BIT_MASK(0, sh));
     tcg_gen_and_vec(vece, d, d, m);
     tcg_gen_or_vec(vece, d, d, t);
 }
@@ -1044,14 +1041,13 @@ static void gen_ushl_vec(unsigned vece, TCGv_vec dst,
     TCGv_vec rval = tcg_temp_new_vec_matching(dst);
     TCGv_vec lsh = tcg_temp_new_vec_matching(dst);
     TCGv_vec rsh = tcg_temp_new_vec_matching(dst);
-    TCGv_vec msk, max;
+    TCGv_vec max;
 
     tcg_gen_neg_vec(vece, rsh, shift);
     if (vece == MO_8) {
         tcg_gen_mov_vec(lsh, shift);
     } else {
-        msk = tcg_temp_new_vec_matching(dst);
-        tcg_gen_dupi_vec(vece, msk, 0xff);
+        TCGv_vec msk = tcg_constant_vec_matching(dst, vece, 0xff);
         tcg_gen_and_vec(vece, lsh, shift, msk);
         tcg_gen_and_vec(vece, rsh, rsh, msk);
     }
@@ -1064,9 +1060,6 @@ static void gen_ushl_vec(unsigned vece, TCGv_vec dst,
     tcg_gen_shlv_vec(vece, lval, src, lsh);
     tcg_gen_shrv_vec(vece, rval, src, rsh);
 
-    max = tcg_temp_new_vec_matching(dst);
-    tcg_gen_dupi_vec(vece, max, 8 << vece);
-
     /*
      * The choice of LT (signed) and GEU (unsigned) are biased toward
      * the instructions of the x86_64 host.  For MO_8, the whole byte
@@ -1074,6 +1067,7 @@ static void gen_ushl_vec(unsigned vece, TCGv_vec dst,
      * have already masked to a byte and so a signed compare works.
      * Other tcg hosts have a full set of comparisons and do not care.
      */
+    max = tcg_constant_vec_matching(dst, vece, 8 << vece);
     if (vece == MO_8) {
         tcg_gen_cmp_vec(TCG_COND_GEU, vece, lsh, lsh, max);
         tcg_gen_cmp_vec(TCG_COND_GEU, vece, rsh, rsh, max);
@@ -1170,6 +1164,7 @@ static void gen_sshl_vec(unsigned vece, TCGv_vec dst,
     TCGv_vec lsh = tcg_temp_new_vec_matching(dst);
     TCGv_vec rsh = tcg_temp_new_vec_matching(dst);
     TCGv_vec tmp = tcg_temp_new_vec_matching(dst);
+    TCGv_vec max, zero;
 
     /*
      * Rely on the TCG guarantee that out of range shifts produce
@@ -1180,15 +1175,15 @@ static void gen_sshl_vec(unsigned vece, TCGv_vec dst,
     if (vece == MO_8) {
         tcg_gen_mov_vec(lsh, shift);
     } else {
-        tcg_gen_dupi_vec(vece, tmp, 0xff);
-        tcg_gen_and_vec(vece, lsh, shift, tmp);
-        tcg_gen_and_vec(vece, rsh, rsh, tmp);
+        TCGv_vec msk = tcg_constant_vec_matching(dst, vece, 0xff);
+        tcg_gen_and_vec(vece, lsh, shift, msk);
+        tcg_gen_and_vec(vece, rsh, rsh, msk);
     }
 
     /* Bound rsh so out of bound right shift gets -1.  */
-    tcg_gen_dupi_vec(vece, tmp, (8 << vece) - 1);
-    tcg_gen_umin_vec(vece, rsh, rsh, tmp);
-    tcg_gen_cmp_vec(TCG_COND_GT, vece, tmp, lsh, tmp);
+    max = tcg_constant_vec_matching(dst, vece, (8 << vece) - 1);
+    tcg_gen_umin_vec(vece, rsh, rsh, max);
+    tcg_gen_cmp_vec(TCG_COND_GT, vece, tmp, lsh, max);
 
     tcg_gen_shlv_vec(vece, lval, src, lsh);
     tcg_gen_sarv_vec(vece, rval, src, rsh);
@@ -1197,12 +1192,12 @@ static void gen_sshl_vec(unsigned vece, TCGv_vec dst,
     tcg_gen_andc_vec(vece, lval, lval, tmp);
 
     /* Select between left and right shift.  */
+    zero = tcg_constant_vec_matching(dst, vece, 0);
     if (vece == MO_8) {
-        tcg_gen_dupi_vec(vece, tmp, 0);
-        tcg_gen_cmpsel_vec(TCG_COND_LT, vece, dst, lsh, tmp, rval, lval);
+        tcg_gen_cmpsel_vec(TCG_COND_LT, vece, dst, lsh, zero, rval, lval);
     } else {
-        tcg_gen_dupi_vec(vece, tmp, 0x80);
-        tcg_gen_cmpsel_vec(TCG_COND_LT, vece, dst, lsh, tmp, lval, rval);
+        TCGv_vec sgn = tcg_constant_vec_matching(dst, vece, 0x80);
+        tcg_gen_cmpsel_vec(TCG_COND_LT, vece, dst, lsh, sgn, lval, rval);
     }
 }
 
-- 
2.43.0


