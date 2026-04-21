Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4896EA7184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3Rs-0008DF-UC; Tue, 21 Apr 2026 01:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3Qx-0007vm-JV
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:04 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3Qu-0006KV-Ke
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:02 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2b788a98557so1537625ad.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748439; x=1777353239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qdQBWzWrlCQOyL6REc2mM0GoH8jWUoG58/2k/M4dy88=;
 b=fE1medAYgFDAA2CglfSu7jqjxeeaROtwXGyI/iee/ORo8LvGkrwjCLe5ox3S6oI/Zz
 ey6X/2Dan/+Iu6pgFq+Rkza4jbXlheUyp4Fyug+44gPq84WuT/rPRBGelIeaAVJJa5fX
 6Zj8FMA4Zuev4QsTtoqQX91RnPhMQydyCbkECv84Fa9cZJgfDN99V1+ayYPd1jVuimS5
 6CWIwfLJjX/L84hTyCDzDVpDizWG5ras06P0SoDJELTeQX1rVUI3T4O028TD9zFXYIHl
 hkCLllHk1AzMyAQfk9blOPe6u80/6m2jOoPdRUE836E26TYFPxu0YPJfr4KvrKL0vbMt
 pfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748439; x=1777353239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qdQBWzWrlCQOyL6REc2mM0GoH8jWUoG58/2k/M4dy88=;
 b=JhPz+Ga8hBXZ+ZBlYBZ8hI5paFNzfrrooR850Lt+BPbDm9y4cyl4KJS0QgGXcpwQyM
 Tkt+LHHf6U9i6CRfPBpkzMnr6b8tPoE6c1w6oaWMKlMSQdKyhKcTFlntMi/mdHunKcll
 wxLZaeNK2cFmLs/2rnEXWRDVksWAdqzoJ/wuuUTH9W4Gmmm3DQDFAgGNLkVe/nSAxwKH
 w6g4ZwASk4mdbAeKybpr9UhAnhRT5I6kGAgcUpRSrP8qhDTdFfO+q5Jq52+JHWfZaRa2
 qNox1x+3QqvHWucT92ItdY0A2lU8HWvGfel9xh3o5XtKbNV9f566uzegNem1/0rl0qM3
 hang==
X-Gm-Message-State: AOJu0YzSRdiNwH47+TRf8hp2Ww6AjC14dV6oAoVKR0cJTTM9Gh8UKbG1
 T95yvFJwMLyYjO0yPqeAriP/FpzBO7m48k2aD0pEWgPSRAjoHEu/cVx0ciVeRVT8VGbvnBFZxmD
 Zfuw4mO8=
X-Gm-Gg: AeBDieuyVIE6nZweXkoJJo95kFYd5i7sUHnnsThMFnSfVpFo51k6Loc3iT3duhIvGN/
 pj68JgNRaDyCWSzeePmgi4ghSVhyLdSxFED9nGHhHe0V5dl4LY8+AtS6EgAJh0Yt5TJ9O0SK030
 Hi1oIMZXAxbrS1drhyX8ROshCK2i5n1C85q9GNU+EnJd/EuUIfMruFj8snop75TmTxL60vzTP7f
 4+Zxgmrxg7jwYwIoPkwUYMIsehMnc2XJhYLaTYDAO7HV/krdQCq8BAguv9dvU0lZk985ZUJIqj2
 MsgEYgxXtszwNELdunuVUJTRgGfdt4YMtq+ffnha3bc2ml5PN2Mw5UykQyW2YcYoggwhbvr96gJ
 we2uxoxsTa9JiOXllGAtorMY0DABxWW7gU7O1cX9eqbzY5PQqWiG4YMcLO5WXg7qkJVTU/9TkQ/
 Qlr6Kvyw1BvwDUK0QtfTFsrx7zTDMCm6Wa6Mh9iAefXsiWK1OmJHU=
X-Received: by 2002:a17:903:166e:b0:2b0:a957:304 with SMTP id
 d9443c01a7336-2b5f9e85b42mr178861405ad.6.1776748439179; 
 Mon, 20 Apr 2026 22:13:59 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:13:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 03/37] target/arm: Implement FEAT_FAMINMAX for SME
Date: Tue, 21 Apr 2026 15:13:12 +1000
Message-ID: <20260421051346.41106-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Since there is no bfloat16 variant of FAMINMAX,
check for missing function pointer in do_z2z_nn_fpst.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/translate-sme.c | 23 +++++++++++++++++++++--
 target/arm/tcg/sme.decode      |  5 +++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 7c96b26788..a2ce38faa3 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1574,6 +1574,11 @@ static inline bool isar_feature_aa64_sme2_f64f64(const ARMISARegisters *id)
     return isar_feature_aa64_sme2(id) && isar_feature_aa64_sme_f64f64(id);
 }
 
+static inline bool isar_feature_aa64_sme2_faminmax(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) && isar_feature_aa64_faminmax(id);
+}
+
 static inline bool isar_feature_aa64_sve_i8mm(const ARMISARegisters *id)
 {
     return isar_feature_aa64_sve(id) && isar_feature_aa64_sme_sve_i8mm(id);
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 7d25ac5a51..ca6b130cfe 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper-a64.h"
 #include "helper-sme.h"
 #include "helper-sve.h"
 #include "translate.h"
@@ -741,9 +742,12 @@ static bool do_z2z_nn_fpst(DisasContext *s, arg_z2z_en *a,
                            gen_helper_gvec_3_ptr * const fns[4])
 {
     int esz = a->esz, n, dn, dm, vsz;
-    gen_helper_gvec_3_ptr *fn;
+    gen_helper_gvec_3_ptr *fn = fns[esz];
     TCGv_ptr fpst;
 
+    if (fn == NULL) {
+        return false;
+    }
     if (esz == MO_8 && !dc_isar_feature(aa64_sme_b16b16, s)) {
         return false;
     }
@@ -752,7 +756,6 @@ static bool do_z2z_nn_fpst(DisasContext *s, arg_z2z_en *a,
     }
 
     fpst = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
-    fn = fns[esz];
     n = a->n;
     dn = a->zdn;
     dm = a->zm;
@@ -811,6 +814,22 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
 TRANS_FEAT(FMINNM_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fminnm)
 TRANS_FEAT(FMINNM_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fminnm)
 
+static gen_helper_gvec_3_ptr * const f_vector_famax[4] = {
+    NULL,
+    gen_helper_gvec_famax_h,
+    gen_helper_gvec_famax_s,
+    gen_helper_gvec_famax_d,
+};
+TRANS_FEAT(FAMAX_nn, aa64_sme2_faminmax, do_z2z_nn_fpst, a, f_vector_famax)
+
+static gen_helper_gvec_3_ptr * const f_vector_famin[4] = {
+    NULL,
+    gen_helper_gvec_famin_h,
+    gen_helper_gvec_famin_s,
+    gen_helper_gvec_famin_d,
+};
+TRANS_FEAT(FAMIN_nn, aa64_sme2_faminmax, do_z2z_nn_fpst, a, f_vector_famin)
+
 /* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
 static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
                       GVecGen3FnVar *fn)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 6bb9aa2a90..9dec7318a4 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -286,6 +286,11 @@ URSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 1    @z2z_4x4
 SQDMULH_nn     1100000 1 .. 1 ..... 1011.1 00000 .... 0    @z2z_2x2
 SQDMULH_nn     1100000 1 .. 1 ..... 1011.1 00000 .... 0    @z2z_4x4
 
+FAMAX_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 0    @z2z_2x2
+FAMAX_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 0    @z2z_4x4
+FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_2x2
+FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_4x4
+
 ### SME2 Multi-vector Multiple and Single Array Vectors
 
 &azz_n          n off rv zn zm
-- 
2.43.0


