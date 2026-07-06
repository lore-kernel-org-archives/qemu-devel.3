Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC911C44501
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggio-0007Rm-Ks; Mon, 06 Jul 2026 06:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiB-0006zR-In
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:05 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggi8-0003FU-N4
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:02 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493ba701891so22638225e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334279; x=1783939079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iclwxfzEgrD+jvUMgxN+U2TLgEtviJ2+kKpQnsZMhoo=;
 b=iPKKrJCiaKCpNWNANq2mvYXHgs4cuD/l7Z7cqq6/7GtReCG03hMDq/vDua2O04902I
 xj3Zqe+6pKkBEfI7dr68bR4LPMunZ3CKLtROV9kcsXq2SUCysrFwyqXc0odYdbFIg2uu
 URe3TVYnpvg5vtfXPPRGsyWz6YxJF47pAwTbqX/N0xq9/ytt9bU3Fn+KMb8xNKUEUb1t
 E/pBkIiLatMUcalp7eGlczoIL0ezxG3F2vd/Fj/kPtvimc7YYmE+UPiUQ5XhMzo091Y+
 2cJK1forOK/o/0d3ey9f5txossT6qOnYsT6ZpntjBTK6eAqsKpJQnpKY8XmVWhhVllzT
 msJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334279; x=1783939079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iclwxfzEgrD+jvUMgxN+U2TLgEtviJ2+kKpQnsZMhoo=;
 b=hfzpVnawjsDw/DJyRm+o6XuhNAUBxkArMXHaUSH3KCFo5pTC+QYxmt8DX3u8nO1Ni+
 M+JJ5ZVPQ+fc6gvP6aBmEa7BkMFS2ZtGbmwL6WTcNhltVUUkWZHtz91H1Q5oVbhUDqVw
 CY7gddqQ1WKY2w+sy43RUznZdp4mUsWrNruNcGd16aS5NtridoZJCoHJbjBD/MRejMU4
 UmAwSX7ZhKiKBLyuDB3cewmV0ffWJt0lzhHSYhPpyphYFuMB0KrVDc9XfCrV8qUPCn6i
 aM/fmOV5lYk9wmyziV9+Ub6NnbBeY9AbmqSk3bgIq72C4cJuOvzzlT+0sUbsSHC+qQ39
 UsfQ==
X-Gm-Message-State: AOJu0Ywj2qRtl5E1h4eDYQ+n8XzLJ+3wJrVkblQR90E1aR/VgxPVjQg9
 ZSmg/pDVw5qc8p/jQZAX+wIh9xytuYMHgRtqlYT77sugk46AtUbD3WXpfh+1yw4u1SEJ3YkGyR3
 /zHRNZrva5Q==
X-Gm-Gg: AfdE7ck4o7dDjbYCpCGD8htWhXbw8FFe3JKdgLqTkHSaB9p3sZHkWlfkeKlUMIRVXnD
 lreyEBY1Eq05whZZK7jO0EPPFLTsDzu/xxPd0CjYFwnZjL37QnxoV3DqjTmpeQCgassmiKPfWiE
 eby2orVRhTTkLu+wQPppJe99i9Q6InFpDbSyhX/vs+sLJIal56yF+DxxgGE6kosUzi8bavBviTB
 IZBCymAybtgLW6593LVw/p1ME7o0f5zfdGiqvWcmbtceEtlD7QU/2/2TC4EzwCX0S48Jkx2fe8c
 UytDnIsDa/cSM71yP3nyht/CbrjCNMvZPirtfbC5FWxkxgQdEbqDPrzD8KTlUIfNMrN7I2Vmbbf
 8XRwls8M7Lhon0p8gimbVOVe7vJB6PTYTq87yLUnINt8NN7W567ZXrcSXu9rKR+R09rpZveBrak
 ZK3zaQJUK4yRr4DRDbqdDdc+f/TWYuOCSbFD5h801fJ3ntWeUI2FnULoyu4TmLBTI90QRVidmTL
 xhPXjrMemAucRwqNMds6g05y0bX5RBV
X-Received: by 2002:a05:600c:34d3:b0:493:c062:a533 with SMTP id
 5b1f17b1804b1-493d11dd0ffmr117212255e9.17.1783334279177; 
 Mon, 06 Jul 2026 03:37:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.37.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:37:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/49] target/arm/tcg: Implement new instructions for FPRCVT
Date: Mon,  6 Jul 2026 11:37:07 +0100
Message-ID: <20260706103752.320511-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Jim MacArthur <jim.macarthur@linaro.org>

Adds the opcode format for the SIMD versions of FCVTXX and [US]CVTF.
These use very similar logic to the FP-to-general and general-to-FP
register versions which exist, but use another SIMD/FP register
as source or destination. The source and destination size rules are
slightly different.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260630-jmac-fprcvt-v3-1-f4840d5e0a7f@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++
 target/arm/tcg/a64.decode      | 15 +++++++
 target/arm/tcg/translate-a64.c | 77 +++++++++++++++++++++++-----------
 3 files changed, 73 insertions(+), 24 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 98102d75bf..e1d9259d30 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1685,6 +1685,11 @@ static inline bool isar_feature_aa64_f8mm4(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM4);
 }
 
+static inline bool isar_feature_aa64_fprcvt(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR3, FPRCVT);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 28cd1faf61..5b6f156d08 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1456,6 +1456,21 @@ FCVTZU_g        . 0011110 .. 111001 000000 ..... .....  @icvt
 FCVTAS_g        . 0011110 .. 100100 000000 ..... .....  @icvt
 FCVTAU_g        . 0011110 .. 100101 000000 ..... .....  @icvt
 
+# Conversion between floating-point and integer (SIMD & FP)
+SCVTF_simd      . 0011110 .. 111100 000000 ..... .....  @icvt
+UCVTF_simd      . 0011110 .. 111101 000000 ..... .....  @icvt
+
+FCVTAS_g_simd   . 0011110 .. 111010 000000 ..... .....  @icvt
+FCVTAU_g_simd   . 0011110 .. 111011 000000 ..... .....  @icvt
+FCVTMS_g_simd   . 0011110 .. 110100 000000 ..... .....  @icvt
+FCVTMU_g_simd   . 0011110 .. 110101 000000 ..... .....  @icvt
+FCVTNS_g_simd   . 0011110 .. 101010 000000 ..... .....  @icvt
+FCVTNU_g_simd   . 0011110 .. 101011 000000 ..... .....  @icvt
+FCVTPS_g_simd   . 0011110 .. 110010 000000 ..... .....  @icvt
+FCVTPU_g_simd   . 0011110 .. 110011 000000 ..... .....  @icvt
+FCVTZS_g_simd   . 0011110 .. 110110 000000 ..... .....  @icvt
+FCVTZU_g_simd   . 0011110 .. 110111 000000 ..... .....  @icvt
+
 FJCVTZS         0 0011110 01 111110 000000 ..... .....  @rr
 
 FMOV_ws         0 0011110 00 100110 000000 ..... .....  @rr
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 227719ef25..0da365e345 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9905,12 +9905,14 @@ TRANS(SCVTF_g, do_cvtf_g, a, true)
 TRANS(UCVTF_g, do_cvtf_g, a, false)
 
 /*
- * [US]CVTF (vector), scalar version.
- * Which sounds weird, but really just means input from fp register
+ * [US]CVTF (vector), scalar or SIMD version.
+ * Which sounds weird, but really just means input from FP/SIMD register
  * instead of input from general register.  Input and output element
- * size are always equal.
+ * size are always equal for the scalar version and different for the
+ * SIMD version.
  */
-static bool do_cvtf_f(DisasContext *s, arg_fcvt *a, bool is_signed)
+static bool do_cvtf_f(DisasContext *s, arg_fcvt *a, MemOp src_mop_int,
+                      bool is_signed)
 {
     TCGv_i64 tcg_int;
     int check = fp_access_check_scalar_hsd(s, a->esz);
@@ -9918,14 +9920,18 @@ static bool do_cvtf_f(DisasContext *s, arg_fcvt *a, bool is_signed)
     if (check <= 0) {
         return check == 0;
     }
-
     tcg_int = tcg_temp_new_i64();
-    read_vec_element(s, tcg_int, a->rn, 0, a->esz | (is_signed ? MO_SIGN : 0));
+    read_vec_element(s, tcg_int, a->rn, 0,
+                     src_mop_int | (is_signed ? MO_SIGN : 0));
     return do_cvtf_scalar(s, a->esz, a->rd, a->shift, tcg_int, is_signed);
 }
 
-TRANS(SCVTF_f, do_cvtf_f, a, true)
-TRANS(UCVTF_f, do_cvtf_f, a, false)
+TRANS(SCVTF_f, do_cvtf_f, a, a->esz, true)
+TRANS(UCVTF_f, do_cvtf_f, a, a->esz, false)
+TRANS_FEAT(SCVTF_simd, aa64_fprcvt, do_cvtf_f, a,
+           a->sf ? MO_64 : MO_32, true)
+TRANS_FEAT(UCVTF_simd, aa64_fprcvt, do_cvtf_f, a,
+           a->sf ? MO_64 : MO_32, false)
 
 static void do_fcvt_scalar(DisasContext *s, MemOp out, MemOp esz,
                            TCGv_i64 tcg_out, int shift, int rn,
@@ -10044,6 +10050,7 @@ static bool do_fcvt_g(DisasContext *s, arg_fcvt *a,
     return true;
 }
 
+
 TRANS(FCVTNS_g, do_fcvt_g, a, FPROUNDING_TIEEVEN, true)
 TRANS(FCVTNU_g, do_fcvt_g, a, FPROUNDING_TIEEVEN, false)
 TRANS(FCVTPS_g, do_fcvt_g, a, FPROUNDING_POSINF, true)
@@ -10056,13 +10063,14 @@ TRANS(FCVTAS_g, do_fcvt_g, a, FPROUNDING_TIEAWAY, true)
 TRANS(FCVTAU_g, do_fcvt_g, a, FPROUNDING_TIEAWAY, false)
 
 /*
- * FCVT* (vector), scalar version.
- * Which sounds weird, but really just means output to fp register
+ * FCVT* (vector), scalar or SIMD/FP version.
+ * Which sounds weird, but really just means output to fp or SIMD register
  * instead of output to general register.  Input and output element
- * size are always equal.
+ * size are always equal for the scalar version and different for the
+ * SIMD version.
  */
 static bool do_fcvt_f(DisasContext *s, arg_fcvt *a,
-                      ARMFPRounding rmode, bool is_signed)
+                      ARMFPRounding rmode, MemOp dst_mop_int, bool is_signed)
 {
     TCGv_i64 tcg_int;
     int check = fp_access_check_scalar_hsd(s, a->esz);
@@ -10072,26 +10080,47 @@ static bool do_fcvt_f(DisasContext *s, arg_fcvt *a,
     }
 
     tcg_int = tcg_temp_new_i64();
-    do_fcvt_scalar(s, a->esz | (is_signed ? MO_SIGN : 0),
+    do_fcvt_scalar(s, dst_mop_int | (is_signed ? MO_SIGN : 0),
                    a->esz, tcg_int, a->shift, a->rn, rmode);
 
     if (!s->fpcr_nep) {
         clear_vec(s, a->rd);
     }
-    write_vec_element(s, tcg_int, a->rd, 0, a->esz);
+    write_vec_element(s, tcg_int, a->rd, 0, dst_mop_int);
     return true;
 }
 
-TRANS(FCVTNS_f, do_fcvt_f, a, FPROUNDING_TIEEVEN, true)
-TRANS(FCVTNU_f, do_fcvt_f, a, FPROUNDING_TIEEVEN, false)
-TRANS(FCVTPS_f, do_fcvt_f, a, FPROUNDING_POSINF, true)
-TRANS(FCVTPU_f, do_fcvt_f, a, FPROUNDING_POSINF, false)
-TRANS(FCVTMS_f, do_fcvt_f, a, FPROUNDING_NEGINF, true)
-TRANS(FCVTMU_f, do_fcvt_f, a, FPROUNDING_NEGINF, false)
-TRANS(FCVTZS_f, do_fcvt_f, a, FPROUNDING_ZERO, true)
-TRANS(FCVTZU_f, do_fcvt_f, a, FPROUNDING_ZERO, false)
-TRANS(FCVTAS_f, do_fcvt_f, a, FPROUNDING_TIEAWAY, true)
-TRANS(FCVTAU_f, do_fcvt_f, a, FPROUNDING_TIEAWAY, false)
+TRANS(FCVTNS_f, do_fcvt_f, a, FPROUNDING_TIEEVEN, a->esz, true)
+TRANS(FCVTNU_f, do_fcvt_f, a, FPROUNDING_TIEEVEN, a->esz, false)
+TRANS(FCVTPS_f, do_fcvt_f, a, FPROUNDING_POSINF, a->esz, true)
+TRANS(FCVTPU_f, do_fcvt_f, a, FPROUNDING_POSINF, a->esz, false)
+TRANS(FCVTMS_f, do_fcvt_f, a, FPROUNDING_NEGINF, a->esz, true)
+TRANS(FCVTMU_f, do_fcvt_f, a, FPROUNDING_NEGINF, a->esz, false)
+TRANS(FCVTZS_f, do_fcvt_f, a, FPROUNDING_ZERO, a->esz, true)
+TRANS(FCVTZU_f, do_fcvt_f, a, FPROUNDING_ZERO, a->esz, false)
+TRANS(FCVTAS_f, do_fcvt_f, a, FPROUNDING_TIEAWAY, a->esz, true)
+TRANS(FCVTAU_f, do_fcvt_f, a, FPROUNDING_TIEAWAY, a->esz, false)
+
+TRANS_FEAT(FCVTNS_g_simd, aa64_fprcvt, do_fcvt_f, a,
+           FPROUNDING_TIEEVEN, a->sf ? MO_64 : MO_32, true)
+TRANS_FEAT(FCVTNU_g_simd, aa64_fprcvt, do_fcvt_f, a,
+           FPROUNDING_TIEEVEN, a->sf ? MO_64 : MO_32, false)
+TRANS_FEAT(FCVTPS_g_simd, aa64_fprcvt, do_fcvt_f, a,
+           FPROUNDING_POSINF, a->sf ? MO_64 : MO_32, true)
+TRANS_FEAT(FCVTPU_g_simd, aa64_fprcvt, do_fcvt_f, a,
+           FPROUNDING_POSINF, a->sf ? MO_64 : MO_32, false)
+TRANS_FEAT(FCVTMS_g_simd, aa64_fprcvt, do_fcvt_f, a,
+           FPROUNDING_NEGINF, a->sf ? MO_64 : MO_32, true)
+TRANS_FEAT(FCVTMU_g_simd, aa64_fprcvt, do_fcvt_f, a,
+           FPROUNDING_NEGINF, a->sf ? MO_64 : MO_32, false)
+TRANS_FEAT(FCVTZS_g_simd, aa64_fprcvt, do_fcvt_f, a,
+           FPROUNDING_ZERO, a->sf ? MO_64 : MO_32, true)
+TRANS_FEAT(FCVTZU_g_simd, aa64_fprcvt, do_fcvt_f, a,
+           FPROUNDING_ZERO, a->sf ? MO_64 : MO_32, false)
+TRANS_FEAT(FCVTAS_g_simd, aa64_fprcvt, do_fcvt_f, a,
+           FPROUNDING_TIEAWAY, a->sf ? MO_64 : MO_32, true)
+TRANS_FEAT(FCVTAU_g_simd, aa64_fprcvt, do_fcvt_f, a,
+           FPROUNDING_TIEAWAY, a->sf ? MO_64 : MO_32, false)
 
 static bool trans_FJCVTZS(DisasContext *s, arg_FJCVTZS *a)
 {
-- 
2.43.0


