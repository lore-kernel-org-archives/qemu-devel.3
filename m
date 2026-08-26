Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDBDC61DC4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHdt-0008Ut-0l; Wed, 26 Aug 2026 13:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdo-0008QM-JB
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:24 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdl-0004kJ-Ti
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:24 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cc149372c14so957551a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787766140; x=1788370940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eacrHo9Y3lmkTm8JFf4RKHpF6JxecOscKoMmlksHtLM=;
 b=I/Xdd222YHFlfWHFngUpAK6dZax1tnzLd9JKVDfsmM/vKD2ws6h+n0csQ5DbhL6wY/
 SNZSlUJJ4QDHlyj+5Ela9Sfrh1Bv3EwL9m/aSTq4P9NRghY+PdjhnUkd32jn7/93tw26
 aKos2QLX/+XFID7UR5z4wUdGrEmj0aKpa3c8Ex/+hVUqwCLW8NRwsudPtdspxvfPwjvd
 lt3LkzdVEOE3A8Y09G5YBLFuX1c5p8MwNPeFckIa9pVx44rQD7Vse2M3jG/Bu2qPXAV3
 VhTPdKckmmNvyCTgioADraNUUAXnnYy1vYj6IBlYbApKyU00hLbiI8mDTCU4er4+zez4
 kw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766140; x=1788370940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eacrHo9Y3lmkTm8JFf4RKHpF6JxecOscKoMmlksHtLM=;
 b=AhJdDfLWNuZu4mMu+YDgzwJqdULlGiiPFAXqfgAMNf05CkKbDavwJWPsqJyLoRNT3I
 VPL3+l0SJwsCJzynPjyNOYDr8YgcDhajPbKHrPN3AoDBV9b1K1ZPIiaLgquMx+YA4Ci1
 Y8U/6m5lgGgL9CqjOhFXRFTvnvLaOQaDj2kKKYR7G78YJ/EykDPR5PFD5WuqwlpyzW9S
 1DxIK4L6fwe+JEoXrJgRIDZ1SUREX66tvKLm4UGx6alIB50D1SuVtS2h6Kngbt5Y+LhV
 9TfuNfGasV0NhcU13QMI7JxLiRvZvdMqOPcBKP5tGLKJci+0MOjDsbw6jZxc6hj0FGs6
 g3hQ==
X-Gm-Message-State: AFuF++kZ62CKhySeVrETkQm8OQYO5rmTnaWAryQCoA767teMEqCnZvcP
 gO7aO5H6vizF1ahNjprWtugqyZ+twGtnZqb9RGoP0jtRW9+WlFb5VF5CxUYSpxVxkJwNOqNmyWA
 cwXUNU20=
X-Gm-Gg: AR+sD10uQ77TIgDtJ53V9nvj4QkzKcSZDD+Qvt0KB3Y5dW5/7AD4NTCB8ut3wUZVJSD
 qoWj8X3drQ3Ll9zqm6jrepcpqGUlzYkfaU2hPPoDQ+AR01EXaa6Pmq1uHogbH3/FTrY5llnHK03
 z9aJBRJT6UaDTXvcapDepVgumrtQ6CBAcCBiZK5OrniaNjOQ3tSOzOXOwubIbyzDDLgER7tLMHn
 xwFuMOldaafJf/IKLr+a5kUPOe16ua/XGkPFnOIzi0PCM7qIEM3m1HhWemyRkO6/CKTvaJweudR
 oEpO94QbGTK0jc6TREEeqWuWOR6trl7Bxf+kAsq7vCDDmymUa/+vcbRco97dUbXlBowfLTRbXH1
 sGIior80Z+Fy38klQed71hvvux21yXvrl4lg2Pa5aPIbUQyJORpuui4v8vqQzEyxM6VyicC5hjt
 G4MlyQsCoJN5Pi7rDx8LBrnT+G9mWXb8C6SNYBo7LzXCl2/sHA07B3eqIxRr829s3re9B+Hz6QK
 5Oy12+Y7TgrBTxwdg==
X-Received: by 2002:a05:6a21:7008:b0:3bf:7bf7:7913 with SMTP id
 adf61e73a8af0-3cf8445170emr18217181637.14.1787766139993; 
 Wed, 26 Aug 2026 10:42:19 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1bec66020sm1260072a12.21.2026.08.26.10.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:42:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 03/25] target/arm: Split decode of BFloat SME FMAX/FMIN
Date: Wed, 26 Aug 2026 10:41:50 -0700
Message-ID: <20260826174213.614571-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174213.614571-1-richard.henderson@linaro.org>
References: <20260826174213.614571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Split decode so that feature detection can be handled
external to do_zzz_{n1,nn}_fpst.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  5 ++
 target/arm/tcg/translate-sme.c | 65 +++++++++++++-----------
 target/arm/tcg/sme.decode      | 90 ++++++++++++++++++++++++++++------
 3 files changed, 115 insertions(+), 45 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 280ead6f9cb..e444397a478 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1743,6 +1743,11 @@ static inline bool isar_feature_aa64_sme2p2_or_sve2p2(const ARMISARegisters *id)
     return isar_feature_aa64_sme2p2(id) || isar_feature_aa64_sve2p2(id);
 }
 
+static inline bool isar_feature_aa64_sme2_sve_b16b16(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) && isar_feature_aa64_sve_b16b16(id);
+}
+
 static inline bool isar_feature_aa64_sme2_i16i64(const ARMISARegisters *id)
 {
     return isar_feature_aa64_sme2(id) && isar_feature_aa64_sme_i16i64(id);
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index ca88b3cdcc7..db1950f407b 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -747,20 +747,15 @@ TRANS_FEAT(URSHL_nn, aa64_sme2, do_zzz_nn, a, gen_sme2_urshl)
 TRANS_FEAT(SQDMULH_nn, aa64_sme2, do_zzz_nn, a, gen_gvec_sve2_sqdmulh)
 
 static bool do_zzz_n1_fpst(DisasContext *s, arg_zzz_en *a,
-                           gen_helper_gvec_3_ptr * const fns[4])
+                           gen_helper_gvec_3_ptr *fn)
 {
     int esz = a->esz, vsz, mofs;
     int overlap = -1;
-    gen_helper_gvec_3_ptr *fn = fns[esz];
     TCGv_ptr fpst;
 
     if (fn == NULL) {
         return false;
     }
-    /* These insns use MO_8 to encode BFloat16. */
-    if (esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
-        return false;
-    }
     if (!sme_sm_enabled_check(s)) {
         return true;
     }
@@ -786,18 +781,14 @@ static bool do_zzz_n1_fpst(DisasContext *s, arg_zzz_en *a,
 }
 
 static bool do_zzz_nn_fpst(DisasContext *s, arg_zzz_en *a,
-                           gen_helper_gvec_3_ptr * const fns[4])
+                           gen_helper_gvec_3_ptr *fn)
 {
     int esz = a->esz, vsz;
-    gen_helper_gvec_3_ptr *fn = fns[esz];
     TCGv_ptr fpst;
 
     if (fn == NULL) {
         return false;
     }
-    if (esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
-        return false;
-    }
     if (!sme_sm_enabled_check(s)) {
         return true;
     }
@@ -816,48 +807,64 @@ static bool do_zzz_nn_fpst(DisasContext *s, arg_zzz_en *a,
 }
 
 static gen_helper_gvec_3_ptr * const f_vector_fmax[2][4] = {
-    { gen_helper_gvec_fmax_b16,
+    { NULL,
       gen_helper_gvec_fmax_h,
       gen_helper_gvec_fmax_s,
       gen_helper_gvec_fmax_d },
-    { gen_helper_gvec_ah_fmax_b16,
+    { NULL,
       gen_helper_gvec_ah_fmax_h,
       gen_helper_gvec_ah_fmax_s,
       gen_helper_gvec_ah_fmax_d },
 };
-TRANS_FEAT(FMAX_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmax[s->fpcr_ah])
-TRANS_FEAT(FMAX_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fmax[s->fpcr_ah])
+TRANS_FEAT(FMAX_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmax[s->fpcr_ah][a->esz])
+TRANS_FEAT(FMAX_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fmax[s->fpcr_ah][a->esz])
+TRANS_FEAT(BFMAX_n1, aa64_sme2_sve_b16b16, do_zzz_n1_fpst, a,
+           s->fpcr_ah ? gen_helper_gvec_ah_fmax_b16 : gen_helper_gvec_fmax_b16)
+TRANS_FEAT(BFMAX_nn, aa64_sme2_sve_b16b16, do_zzz_nn_fpst, a,
+           s->fpcr_ah ? gen_helper_gvec_ah_fmax_b16 : gen_helper_gvec_fmax_b16)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmin[2][4] = {
-    { gen_helper_gvec_fmin_b16,
+    { NULL,
       gen_helper_gvec_fmin_h,
       gen_helper_gvec_fmin_s,
       gen_helper_gvec_fmin_d },
-    { gen_helper_gvec_ah_fmin_b16,
+    { NULL,
       gen_helper_gvec_ah_fmin_h,
       gen_helper_gvec_ah_fmin_s,
       gen_helper_gvec_ah_fmin_d },
 };
-TRANS_FEAT(FMIN_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmin[s->fpcr_ah])
-TRANS_FEAT(FMIN_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fmin[s->fpcr_ah])
+TRANS_FEAT(FMIN_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmin[s->fpcr_ah][a->esz])
+TRANS_FEAT(FMIN_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fmin[s->fpcr_ah][a->esz])
+TRANS_FEAT(BFMIN_n1, aa64_sme2_sve_b16b16, do_zzz_n1_fpst, a,
+           s->fpcr_ah ? gen_helper_gvec_ah_fmin_b16 : gen_helper_gvec_fmin_b16)
+TRANS_FEAT(BFMIN_nn, aa64_sme2_sve_b16b16, do_zzz_nn_fpst, a,
+           s->fpcr_ah ? gen_helper_gvec_ah_fmin_b16 : gen_helper_gvec_fmin_b16)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmaxnm[4] = {
-    gen_helper_gvec_fmaxnum_b16,
+    NULL,
     gen_helper_gvec_fmaxnum_h,
     gen_helper_gvec_fmaxnum_s,
     gen_helper_gvec_fmaxnum_d,
 };
-TRANS_FEAT(FMAXNM_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmaxnm)
-TRANS_FEAT(FMAXNM_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fmaxnm)
+TRANS_FEAT(FMAXNM_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmaxnm[a->esz])
+TRANS_FEAT(FMAXNM_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fmaxnm[a->esz])
+TRANS_FEAT(BFMAXNM_n1, aa64_sme2_sve_b16b16, do_zzz_n1_fpst, a,
+           gen_helper_gvec_fmaxnum_b16)
+TRANS_FEAT(BFMAXNM_nn, aa64_sme2_sve_b16b16, do_zzz_nn_fpst, a,
+           gen_helper_gvec_fmaxnum_b16)
 
 static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
-    gen_helper_gvec_fminnum_b16,
+    NULL,
     gen_helper_gvec_fminnum_h,
     gen_helper_gvec_fminnum_s,
     gen_helper_gvec_fminnum_d,
 };
-TRANS_FEAT(FMINNM_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fminnm)
-TRANS_FEAT(FMINNM_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fminnm)
+TRANS_FEAT(FMINNM_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fminnm[a->esz])
+TRANS_FEAT(FMINNM_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fminnm[a->esz])
+TRANS_FEAT(BFMINNM_n1, aa64_sme2_sve_b16b16, do_zzz_n1_fpst, a,
+           gen_helper_gvec_fminnum_b16)
+TRANS_FEAT(BFMINNM_nn, aa64_sme2_sve_b16b16, do_zzz_nn_fpst, a,
+           gen_helper_gvec_fminnum_b16)
 
 static gen_helper_gvec_3_ptr * const f_vector_famax[4] = {
     NULL,
@@ -865,7 +872,7 @@ static gen_helper_gvec_3_ptr * const f_vector_famax[4] = {
     gen_helper_gvec_famax_s,
     gen_helper_gvec_famax_d,
 };
-TRANS_FEAT(FAMAX_nn, aa64_sme2_faminmax, do_zzz_nn_fpst, a, f_vector_famax)
+TRANS_FEAT(FAMAX_nn, aa64_sme2_faminmax, do_zzz_nn_fpst, a, f_vector_famax[a->esz])
 
 static gen_helper_gvec_3_ptr * const f_vector_famin[4] = {
     NULL,
@@ -873,7 +880,7 @@ static gen_helper_gvec_3_ptr * const f_vector_famin[4] = {
     gen_helper_gvec_famin_s,
     gen_helper_gvec_famin_d,
 };
-TRANS_FEAT(FAMIN_nn, aa64_sme2_faminmax, do_zzz_nn_fpst, a, f_vector_famin)
+TRANS_FEAT(FAMIN_nn, aa64_sme2_faminmax, do_zzz_nn_fpst, a, f_vector_famin[a->esz])
 
 static gen_helper_gvec_3_ptr * const f_vector_fscale[4] = {
     NULL,
@@ -881,8 +888,8 @@ static gen_helper_gvec_3_ptr * const f_vector_fscale[4] = {
     gen_helper_gvec_fscale_s,
     gen_helper_gvec_fscale_d,
 };
-TRANS_FEAT(FSCALE_n1, aa64_sme2_f8cvt, do_zzz_n1_fpst, a, f_vector_fscale)
-TRANS_FEAT(FSCALE_nn, aa64_sme2_f8cvt, do_zzz_nn_fpst, a, f_vector_fscale)
+TRANS_FEAT(FSCALE_n1, aa64_sme2_f8cvt, do_zzz_n1_fpst, a, f_vector_fscale[a->esz])
+TRANS_FEAT(FSCALE_nn, aa64_sme2_f8cvt, do_zzz_nn_fpst, a, f_vector_fscale[a->esz])
 
 /* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
 static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 36fbe24faf8..e1bef9987b0 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -227,6 +227,11 @@ UMOPA2_s        1010000 1 10 0 ..... ... ... ..... . 10 ..      @op_32
 @z2z_4x1        ....... . esz:2 .. zm:4 ....1. ..... ...0 . \
                 &zzz_en n=4 zd=%zd_ax4 zn=%zd_ax4
 
+@z2z_2x1_e0     ....... . .. .. zm:4 ....0. ..... .... . \
+                &zzz_en esz=0 n=2 zd=%zd_ax2 zn=%zd_ax2
+@z2z_4x1_e0     ....... . .. .. zm:4 ....1. ..... ...0 . \
+                &zzz_en esz=0 n=4 zd=%zd_ax4 zn=%zd_ax4
+
 SMAX_n1        1100000 1 .. 10 .... 1010.0 00000 .... 0    @z2z_2x1
 SMAX_n1        1100000 1 .. 10 .... 1010.0 00000 .... 0    @z2z_4x1
 UMAX_n1        1100000 1 .. 10 .... 1010.0 00000 .... 1    @z2z_2x1
@@ -236,14 +241,38 @@ SMIN_n1        1100000 1 .. 10 .... 1010.0 00001 .... 0    @z2z_4x1
 UMIN_n1        1100000 1 .. 10 .... 1010.0 00001 .... 1    @z2z_2x1
 UMIN_n1        1100000 1 .. 10 .... 1010.0 00001 .... 1    @z2z_4x1
 
-FMAX_n1        1100000 1 .. 10 .... 1010.0 01000 .... 0    @z2z_2x1
-FMAX_n1        1100000 1 .. 10 .... 1010.0 01000 .... 0    @z2z_4x1
-FMIN_n1        1100000 1 .. 10 .... 1010.0 01000 .... 1    @z2z_2x1
-FMIN_n1        1100000 1 .. 10 .... 1010.0 01000 .... 1    @z2z_4x1
-FMAXNM_n1      1100000 1 .. 10 .... 1010.0 01001 .... 0    @z2z_2x1
-FMAXNM_n1      1100000 1 .. 10 .... 1010.0 01001 .... 0    @z2z_4x1
-FMINNM_n1      1100000 1 .. 10 .... 1010.0 01001 .... 1    @z2z_2x1
-FMINNM_n1      1100000 1 .. 10 .... 1010.0 01001 .... 1    @z2z_4x1
+{
+  BFMAX_n1     1100000 1 00 10 .... 1010.0 01000 .... 0    @z2z_2x1_e0
+  FMAX_n1      1100000 1 .. 10 .... 1010.0 01000 .... 0    @z2z_2x1
+}
+{
+  BFMAX_n1     1100000 1 00 10 .... 1010.0 01000 .... 0    @z2z_4x1_e0
+  FMAX_n1      1100000 1 .. 10 .... 1010.0 01000 .... 0    @z2z_4x1
+}
+{
+  BFMIN_n1     1100000 1 00 10 .... 1010.0 01000 .... 1    @z2z_2x1_e0
+  FMIN_n1      1100000 1 .. 10 .... 1010.0 01000 .... 1    @z2z_2x1
+}
+{
+  BFMIN_n1     1100000 1 00 10 .... 1010.0 01000 .... 1    @z2z_4x1_e0
+  FMIN_n1      1100000 1 .. 10 .... 1010.0 01000 .... 1    @z2z_4x1
+}
+{
+  BFMAXNM_n1   1100000 1 00 10 .... 1010.0 01001 .... 0    @z2z_2x1_e0
+  FMAXNM_n1    1100000 1 .. 10 .... 1010.0 01001 .... 0    @z2z_2x1
+}
+{
+  BFMAXNM_n1   1100000 1 00 10 .... 1010.0 01001 .... 0    @z2z_4x1_e0
+  FMAXNM_n1    1100000 1 .. 10 .... 1010.0 01001 .... 0    @z2z_4x1
+}
+{
+  BFMINNM_n1   1100000 1 00 10 .... 1010.0 01001 .... 1    @z2z_2x1_e0
+  FMINNM_n1    1100000 1 .. 10 .... 1010.0 01001 .... 1    @z2z_2x1
+}
+{
+  BFMINNM_n1   1100000 1 00 10 .... 1010.0 01001 .... 1    @z2z_4x1_e0
+  FMINNM_n1    1100000 1 .. 10 .... 1010.0 01001 .... 1    @z2z_4x1
+}
 
 SRSHL_n1       1100000 1 .. 10 .... 1010.0 10001 .... 0    @z2z_2x1
 SRSHL_n1       1100000 1 .. 10 .... 1010.0 10001 .... 0    @z2z_4x1
@@ -269,6 +298,11 @@ FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_4x1
 @z2z_4x4        ....... . esz:2 . ...00 ....1. ..... ...0 . \
                 &zzz_en n=4 zd=%zd_ax4 zn=%zd_ax4 zm=%zm_ax4
 
+@z2z_2x2_e0     ....... . .. . ....0 ....0. ..... .... . \
+                &zzz_en esz=0 n=2 zd=%zd_ax2 zn=%zd_ax2 zm=%zm_ax2
+@z2z_4x4_e0     ....... . .. . ...00 ....1. ..... ...0 . \
+                &zzz_en esz=0 n=4 zd=%zd_ax4 zn=%zd_ax4 zm=%zm_ax4
+
 SMAX_nn        1100000 1 .. 1 ..... 1011.0 00000 .... 0    @z2z_2x2
 SMAX_nn        1100000 1 .. 1 ..... 1011.0 00000 .... 0    @z2z_4x4
 UMAX_nn        1100000 1 .. 1 ..... 1011.0 00000 .... 1    @z2z_2x2
@@ -278,14 +312,38 @@ SMIN_nn        1100000 1 .. 1 ..... 1011.0 00001 .... 0    @z2z_4x4
 UMIN_nn        1100000 1 .. 1 ..... 1011.0 00001 .... 1    @z2z_2x2
 UMIN_nn        1100000 1 .. 1 ..... 1011.0 00001 .... 1    @z2z_4x4
 
-FMAX_nn        1100000 1 .. 1 ..... 1011.0 01000 .... 0    @z2z_2x2
-FMAX_nn        1100000 1 .. 1 ..... 1011.0 01000 .... 0    @z2z_4x4
-FMIN_nn        1100000 1 .. 1 ..... 1011.0 01000 .... 1    @z2z_2x2
-FMIN_nn        1100000 1 .. 1 ..... 1011.0 01000 .... 1    @z2z_4x4
-FMAXNM_nn      1100000 1 .. 1 ..... 1011.0 01001 .... 0    @z2z_2x2
-FMAXNM_nn      1100000 1 .. 1 ..... 1011.0 01001 .... 0    @z2z_4x4
-FMINNM_nn      1100000 1 .. 1 ..... 1011.0 01001 .... 1    @z2z_2x2
-FMINNM_nn      1100000 1 .. 1 ..... 1011.0 01001 .... 1    @z2z_4x4
+{
+  BFMAX_nn     1100000 1 00 1 ..... 1011.0 01000 .... 0    @z2z_2x2_e0
+  FMAX_nn      1100000 1 .. 1 ..... 1011.0 01000 .... 0    @z2z_2x2
+}
+{
+  BFMAX_nn     1100000 1 00 1 ..... 1011.0 01000 .... 0    @z2z_4x4_e0
+  FMAX_nn      1100000 1 .. 1 ..... 1011.0 01000 .... 0    @z2z_4x4
+}
+{
+  BFMIN_nn     1100000 1 00 1 ..... 1011.0 01000 .... 1    @z2z_2x2_e0
+  FMIN_nn      1100000 1 .. 1 ..... 1011.0 01000 .... 1    @z2z_2x2
+}
+{
+  BFMIN_nn     1100000 1 00 1 ..... 1011.0 01000 .... 1    @z2z_4x4_e0
+  FMIN_nn      1100000 1 .. 1 ..... 1011.0 01000 .... 1    @z2z_4x4
+}
+{
+  BFMAXNM_nn   1100000 1 00 1 ..... 1011.0 01001 .... 0    @z2z_2x2_e0
+  FMAXNM_nn    1100000 1 .. 1 ..... 1011.0 01001 .... 0    @z2z_2x2
+}
+{
+  BFMAXNM_nn   1100000 1 00 1 ..... 1011.0 01001 .... 0    @z2z_4x4_e0
+  FMAXNM_nn    1100000 1 .. 1 ..... 1011.0 01001 .... 0    @z2z_4x4
+}
+{
+  BFMINNM_nn   1100000 1 00 1 ..... 1011.0 01001 .... 1    @z2z_2x2_e0
+  FMINNM_nn    1100000 1 .. 1 ..... 1011.0 01001 .... 1    @z2z_2x2
+}
+{
+  BFMINNM_nn   1100000 1 00 1 ..... 1011.0 01001 .... 1    @z2z_4x4_e0
+  FMINNM_nn    1100000 1 .. 1 ..... 1011.0 01001 .... 1    @z2z_4x4
+}
 
 SRSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 0    @z2z_2x2
 SRSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 0    @z2z_4x4
-- 
2.53.0


