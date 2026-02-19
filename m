Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE22CE9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mk-0007Mg-Tv; Thu, 19 Feb 2026 05:34:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MZ-0007BF-G2
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:27 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MT-00064c-C1
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:27 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4836f4cbe0bso6186185e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497257; x=1772102057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QXOLjZ4U5U2q3Qg6rXDRueepoZ5qW603viTnzSgRj7s=;
 b=ukvVFnaVJ6lMAfk84fKtmziB66Cp/bXXiQt2jyD1/edXzu4s3NJoBI5f2ahcRo36Q2
 FSF6c5HkjUjDih4v5bAYd8uRZZ30AlAiAOZ7RzVi/AsJgqLFAAMaKCMhTNYBJA0/G1MI
 0AzCt9oXj51OSYdskh3i18CQTKrIe+ujaFynN8o8/FtC8jDNWfslucI5ddCPOGsmDQ/8
 H7xSsza+tm8WRasVg2ENAxKkWMUSnFdn11cqTNQeYoP1ScZxHraFU4MHXOzOXrD9GbNV
 x2XH1BzfAcQvzgbyCCJqUXjYCDHYUhFkdTYCkKCTRS2yZ8iqlfdsMBpWZIS4Wgvgb/Ny
 kWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497257; x=1772102057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QXOLjZ4U5U2q3Qg6rXDRueepoZ5qW603viTnzSgRj7s=;
 b=YLnMlwZ5D3tOohQPBL0CbQbnWpXQ0xk6sCV1qtN4w+cqZaKUBWc88myplle+JpWXVA
 w2X0ADSk+ftPo6F7Vj7EK9MxsTzHbc8w/1TCf7fVhDzIVvf73/dj3f7fBTVtVptnSQ/o
 /iKlr3XgVwLFnWoUxsAJTUSVC1HuM4+nnnVxJ56uspuSSk3O8vQKEXscg2vgt2UYAj7k
 2/cFLaWSFbzIzPK716k7YKbo0SEHqkIKbDETj3IG+LFxq2yg+PyFyOcCBpfZNpJbgN1s
 X+zjXQSZst6rEPuiclmZakoRbbMZWEYZvy7yjXoUPeJVYAbBRyy7pJ/SlrVb2tYGUHis
 I3zA==
X-Gm-Message-State: AOJu0Yyry43PJUlEfzjw5PH+KhcmkYqS0byWqlUBeXoKmfe3NkyZA9Yg
 oEheC5RNfa+dY3uzahUSNppV3nnzrjFN/TD6+kUgy+hU9ZrRMtbfGnvcz3cl/hV5NlO9C3lmqf+
 k2nCt
X-Gm-Gg: AZuq6aLZqG3sB6jCyf9t9CesbvqYixP2r5yy/ZMfwYOtV/enExaatbMIUZ9mX3r/pY1
 ypgzhXPgZAWGJIkWEVAj00wUR84hpdYIhhksxBai+wa6yVlUinMA3Z6g28PVV/pdkprPwU+1L1X
 BWQCdK0v2P0b3BuJ8QRZmD+uOLiPyKjpKxXlDNYufpahtJP/cJD7BvtMUkmOAF0UOVo8Sv+UDQh
 ePRqwnJV2nGlqJpSPL9eY8JnMW6S8NqlZb5/5GSMp0qjvDnIaAVw59qr+dTVEB6c7UbbLSHs4vC
 w/FMfs2wLea/4/k6Ughs1/KdjAl23nTyKYnxpzGDPGeMg+uz8Lsq2hS5NuJuiIWkPTVBfHtjDyh
 PtPUwdJfxWC+rdEM7IKCIo9DO0HW4HCulwgqAVpLRAuSkFhcp3e8TQaqAO4KSPIMzRoE0S7F2Kc
 6V1dADPC2iAl8eSd4DZ8/Lbljo6hbOO2HoEJKIPt00ywcVF+YbIz+5LkXD24yyqobNaKQl+NC6F
 RRYf+4FLW1egblgBZy83MIkVIvlRO4=
X-Received: by 2002:a05:600c:528d:b0:45d:d97c:236c with SMTP id
 5b1f17b1804b1-48398ad2f39mr82140935e9.21.1771497256686; 
 Thu, 19 Feb 2026 02:34:16 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/32] target/arm/tcg: Use "or SME" feature checks where needed
Date: Thu, 19 Feb 2026 10:33:43 +0000
Message-ID: <20260219103405.3793357-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Many SVE instructions should be provided where the CPU implements
either SVE or SME. Currently we largely check only for features
aa64_sve or aa64_sve2. This happens to work because we forbid
creation of a CPU with SME but not SVE. To allow users to create
SME-only CPUs we need to update the conditions to use the "or SME"
versions of the feature tests instead.

This commit was created by going through translate-sve.c from
top to bottom looking for aa64_sve feature tests and cross
checking those against the instruction descriptions in the Arm ARM,
which will say "(FEAT_SVE || FEAT_SME)" for instructions that
are provided for both features, and "(FEAT_SME)" for the rarer
instructions that are SME only.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260202133353.2231685-11-peter.maydell@linaro.org
---
 target/arm/tcg/translate-sve.c | 854 ++++++++++++++++-----------------
 1 file changed, 427 insertions(+), 427 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index fe59126d2b..44eda7b07d 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -570,14 +570,14 @@ static bool trans_INVALID(DisasContext *s, arg_INVALID *a)
  *** SVE Logical - Unpredicated Group
  */
 
-TRANS_FEAT(AND_zzz, aa64_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_and, a)
-TRANS_FEAT(ORR_zzz, aa64_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_or, a)
-TRANS_FEAT(EOR_zzz, aa64_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_xor, a)
-TRANS_FEAT(BIC_zzz, aa64_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_andc, a)
+TRANS_FEAT(AND_zzz, aa64_sme_or_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_and, a)
+TRANS_FEAT(ORR_zzz, aa64_sme_or_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_or, a)
+TRANS_FEAT(EOR_zzz, aa64_sme_or_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_xor, a)
+TRANS_FEAT(BIC_zzz, aa64_sme_or_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_andc, a)
 
 static bool trans_XAR(DisasContext *s, arg_rrri_esz *a)
 {
-    if (a->esz < 0 || !dc_isar_feature(aa64_sve2, s)) {
+    if (a->esz < 0 || !dc_isar_feature(aa64_sme_or_sve2, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -589,8 +589,8 @@ static bool trans_XAR(DisasContext *s, arg_rrri_esz *a)
     return true;
 }
 
-TRANS_FEAT(EOR3, aa64_sve2, gen_gvec_fn_arg_zzzz, gen_gvec_eor3, a)
-TRANS_FEAT(BCAX, aa64_sve2, gen_gvec_fn_arg_zzzz, gen_gvec_bcax, a)
+TRANS_FEAT(EOR3, aa64_sme_or_sve2, gen_gvec_fn_arg_zzzz, gen_gvec_eor3, a)
+TRANS_FEAT(BCAX, aa64_sme_or_sve2, gen_gvec_fn_arg_zzzz, gen_gvec_bcax, a)
 
 static void gen_bsl(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
                     uint32_t a, uint32_t oprsz, uint32_t maxsz)
@@ -599,7 +599,7 @@ static void gen_bsl(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
     tcg_gen_gvec_bitsel(vece, d, a, n, m, oprsz, maxsz);
 }
 
-TRANS_FEAT(BSL, aa64_sve2, gen_gvec_fn_arg_zzzz, gen_bsl, a)
+TRANS_FEAT(BSL, aa64_sme_or_sve2, gen_gvec_fn_arg_zzzz, gen_bsl, a)
 
 static void gen_bsl1n_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
 {
@@ -628,7 +628,7 @@ static void gen_bsl1n(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
     tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &op);
 }
 
-TRANS_FEAT(BSL1N, aa64_sve2, gen_gvec_fn_arg_zzzz, gen_bsl1n, a)
+TRANS_FEAT(BSL1N, aa64_sme_or_sve2, gen_gvec_fn_arg_zzzz, gen_bsl1n, a)
 
 static void gen_bsl2n_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
 {
@@ -666,7 +666,7 @@ static void gen_bsl2n(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
     tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &op);
 }
 
-TRANS_FEAT(BSL2N, aa64_sve2, gen_gvec_fn_arg_zzzz, gen_bsl2n, a)
+TRANS_FEAT(BSL2N, aa64_sme_or_sve2, gen_gvec_fn_arg_zzzz, gen_bsl2n, a)
 
 static void gen_nbsl_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
 {
@@ -695,18 +695,18 @@ static void gen_nbsl(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
     tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &op);
 }
 
-TRANS_FEAT(NBSL, aa64_sve2, gen_gvec_fn_arg_zzzz, gen_nbsl, a)
+TRANS_FEAT(NBSL, aa64_sme_or_sve2, gen_gvec_fn_arg_zzzz, gen_nbsl, a)
 
 /*
  *** SVE Integer Arithmetic - Unpredicated Group
  */
 
-TRANS_FEAT(ADD_zzz, aa64_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_add, a)
-TRANS_FEAT(SUB_zzz, aa64_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_sub, a)
-TRANS_FEAT(SQADD_zzz, aa64_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_ssadd, a)
-TRANS_FEAT(SQSUB_zzz, aa64_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_sssub, a)
-TRANS_FEAT(UQADD_zzz, aa64_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_usadd, a)
-TRANS_FEAT(UQSUB_zzz, aa64_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_ussub, a)
+TRANS_FEAT(ADD_zzz, aa64_sme_or_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_add, a)
+TRANS_FEAT(SUB_zzz, aa64_sme_or_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_sub, a)
+TRANS_FEAT(SQADD_zzz, aa64_sme_or_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_ssadd, a)
+TRANS_FEAT(SQSUB_zzz, aa64_sme_or_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_sssub, a)
+TRANS_FEAT(UQADD_zzz, aa64_sme_or_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_usadd, a)
+TRANS_FEAT(UQSUB_zzz, aa64_sme_or_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_ussub, a)
 
 /*
  *** SVE Integer Arithmetic - Binary Predicated Group
@@ -732,40 +732,40 @@ static bool do_sel_z(DisasContext *s, int rd, int rn, int rm, int pg, int esz)
     TRANS_FEAT(NAME, FEAT, gen_gvec_ool_arg_zpzz,                         \
                name##_zpzz_fns[a->esz], a, 0)
 
-DO_ZPZZ(AND_zpzz, aa64_sve, sve_and)
-DO_ZPZZ(EOR_zpzz, aa64_sve, sve_eor)
-DO_ZPZZ(ORR_zpzz, aa64_sve, sve_orr)
-DO_ZPZZ(BIC_zpzz, aa64_sve, sve_bic)
+DO_ZPZZ(AND_zpzz, aa64_sme_or_sve, sve_and)
+DO_ZPZZ(EOR_zpzz, aa64_sme_or_sve, sve_eor)
+DO_ZPZZ(ORR_zpzz, aa64_sme_or_sve, sve_orr)
+DO_ZPZZ(BIC_zpzz, aa64_sme_or_sve, sve_bic)
 
-DO_ZPZZ(ADD_zpzz, aa64_sve, sve_add)
-DO_ZPZZ(SUB_zpzz, aa64_sve, sve_sub)
+DO_ZPZZ(ADD_zpzz, aa64_sme_or_sve, sve_add)
+DO_ZPZZ(SUB_zpzz, aa64_sme_or_sve, sve_sub)
 
-DO_ZPZZ(SMAX_zpzz, aa64_sve, sve_smax)
-DO_ZPZZ(UMAX_zpzz, aa64_sve, sve_umax)
-DO_ZPZZ(SMIN_zpzz, aa64_sve, sve_smin)
-DO_ZPZZ(UMIN_zpzz, aa64_sve, sve_umin)
-DO_ZPZZ(SABD_zpzz, aa64_sve, sve_sabd)
-DO_ZPZZ(UABD_zpzz, aa64_sve, sve_uabd)
+DO_ZPZZ(SMAX_zpzz, aa64_sme_or_sve, sve_smax)
+DO_ZPZZ(UMAX_zpzz, aa64_sme_or_sve, sve_umax)
+DO_ZPZZ(SMIN_zpzz, aa64_sme_or_sve, sve_smin)
+DO_ZPZZ(UMIN_zpzz, aa64_sme_or_sve, sve_umin)
+DO_ZPZZ(SABD_zpzz, aa64_sme_or_sve, sve_sabd)
+DO_ZPZZ(UABD_zpzz, aa64_sme_or_sve, sve_uabd)
 
-DO_ZPZZ(MUL_zpzz, aa64_sve, sve_mul)
-DO_ZPZZ(SMULH_zpzz, aa64_sve, sve_smulh)
-DO_ZPZZ(UMULH_zpzz, aa64_sve, sve_umulh)
+DO_ZPZZ(MUL_zpzz, aa64_sme_or_sve, sve_mul)
+DO_ZPZZ(SMULH_zpzz, aa64_sme_or_sve, sve_smulh)
+DO_ZPZZ(UMULH_zpzz, aa64_sme_or_sve, sve_umulh)
 
-DO_ZPZZ(ASR_zpzz, aa64_sve, sve_asr)
-DO_ZPZZ(LSR_zpzz, aa64_sve, sve_lsr)
-DO_ZPZZ(LSL_zpzz, aa64_sve, sve_lsl)
+DO_ZPZZ(ASR_zpzz, aa64_sme_or_sve, sve_asr)
+DO_ZPZZ(LSR_zpzz, aa64_sme_or_sve, sve_lsr)
+DO_ZPZZ(LSL_zpzz, aa64_sme_or_sve, sve_lsl)
 
 static gen_helper_gvec_4 * const sdiv_fns[4] = {
     NULL, NULL, gen_helper_sve_sdiv_zpzz_s, gen_helper_sve_sdiv_zpzz_d
 };
-TRANS_FEAT(SDIV_zpzz, aa64_sve, gen_gvec_ool_arg_zpzz, sdiv_fns[a->esz], a, 0)
+TRANS_FEAT(SDIV_zpzz, aa64_sme_or_sve, gen_gvec_ool_arg_zpzz, sdiv_fns[a->esz], a, 0)
 
 static gen_helper_gvec_4 * const udiv_fns[4] = {
     NULL, NULL, gen_helper_sve_udiv_zpzz_s, gen_helper_sve_udiv_zpzz_d
 };
-TRANS_FEAT(UDIV_zpzz, aa64_sve, gen_gvec_ool_arg_zpzz, udiv_fns[a->esz], a, 0)
+TRANS_FEAT(UDIV_zpzz, aa64_sme_or_sve, gen_gvec_ool_arg_zpzz, udiv_fns[a->esz], a, 0)
 
-TRANS_FEAT(SEL_zpzz, aa64_sve, do_sel_z, a->rd, a->rn, a->rm, a->pg, a->esz)
+TRANS_FEAT(SEL_zpzz, aa64_sme_or_sve, do_sel_z, a->rd, a->rn, a->rm, a->pg, a->esz)
 
 /*
  *** SVE Integer Arithmetic - Unary Predicated Group
@@ -778,14 +778,14 @@ TRANS_FEAT(SEL_zpzz, aa64_sve, do_sel_z, a->rd, a->rn, a->rm, a->pg, a->esz)
     };                                                              \
     TRANS_FEAT(NAME, FEAT, gen_gvec_ool_arg_zpz, name##_fns[a->esz], a, 0)
 
-DO_ZPZ(CLS, aa64_sve, sve_cls)
-DO_ZPZ(CLZ, aa64_sve, sve_clz)
-DO_ZPZ(CNT_zpz, aa64_sve, sve_cnt_zpz)
-DO_ZPZ(CNOT, aa64_sve, sve_cnot)
-DO_ZPZ(NOT_zpz, aa64_sve, sve_not_zpz)
-DO_ZPZ(ABS, aa64_sve, sve_abs)
-DO_ZPZ(NEG, aa64_sve, sve_neg)
-DO_ZPZ(RBIT, aa64_sve, sve_rbit)
+DO_ZPZ(CLS, aa64_sme_or_sve, sve_cls)
+DO_ZPZ(CLZ, aa64_sme_or_sve, sve_clz)
+DO_ZPZ(CNT_zpz, aa64_sme_or_sve, sve_cnt_zpz)
+DO_ZPZ(CNOT, aa64_sme_or_sve, sve_cnot)
+DO_ZPZ(NOT_zpz, aa64_sme_or_sve, sve_not_zpz)
+DO_ZPZ(ABS, aa64_sme_or_sve, sve_abs)
+DO_ZPZ(NEG, aa64_sme_or_sve, sve_neg)
+DO_ZPZ(RBIT, aa64_sme_or_sve, sve_rbit)
 DO_ZPZ(ORQV, aa64_sme2p1_or_sve2p1, sve2p1_orqv)
 DO_ZPZ(EORQV, aa64_sme2p1_or_sve2p1, sve2p1_eorqv)
 DO_ZPZ(ANDQV, aa64_sme2p1_or_sve2p1, sve2p1_andqv)
@@ -798,7 +798,7 @@ static gen_helper_gvec_3 * const fabs_ah_fns[4] = {
     NULL,                  gen_helper_sve_ah_fabs_h,
     gen_helper_sve_ah_fabs_s, gen_helper_sve_ah_fabs_d,
 };
-TRANS_FEAT(FABS, aa64_sve, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(FABS, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            s->fpcr_ah ? fabs_ah_fns[a->esz] : fabs_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const fneg_fns[4] = {
@@ -809,34 +809,34 @@ static gen_helper_gvec_3 * const fneg_ah_fns[4] = {
     NULL,                  gen_helper_sve_ah_fneg_h,
     gen_helper_sve_ah_fneg_s, gen_helper_sve_ah_fneg_d,
 };
-TRANS_FEAT(FNEG, aa64_sve, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(FNEG, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            s->fpcr_ah ? fneg_ah_fns[a->esz] : fneg_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const sxtb_fns[4] = {
     NULL,                  gen_helper_sve_sxtb_h,
     gen_helper_sve_sxtb_s, gen_helper_sve_sxtb_d,
 };
-TRANS_FEAT(SXTB, aa64_sve, gen_gvec_ool_arg_zpz, sxtb_fns[a->esz], a, 0)
+TRANS_FEAT(SXTB, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sxtb_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const uxtb_fns[4] = {
     NULL,                  gen_helper_sve_uxtb_h,
     gen_helper_sve_uxtb_s, gen_helper_sve_uxtb_d,
 };
-TRANS_FEAT(UXTB, aa64_sve, gen_gvec_ool_arg_zpz, uxtb_fns[a->esz], a, 0)
+TRANS_FEAT(UXTB, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, uxtb_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const sxth_fns[4] = {
     NULL, NULL, gen_helper_sve_sxth_s, gen_helper_sve_sxth_d
 };
-TRANS_FEAT(SXTH, aa64_sve, gen_gvec_ool_arg_zpz, sxth_fns[a->esz], a, 0)
+TRANS_FEAT(SXTH, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sxth_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const uxth_fns[4] = {
     NULL, NULL, gen_helper_sve_uxth_s, gen_helper_sve_uxth_d
 };
-TRANS_FEAT(UXTH, aa64_sve, gen_gvec_ool_arg_zpz, uxth_fns[a->esz], a, 0)
+TRANS_FEAT(UXTH, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, uxth_fns[a->esz], a, 0)
 
-TRANS_FEAT(SXTW, aa64_sve, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(SXTW, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            a->esz == 3 ? gen_helper_sve_sxtw_d : NULL, a, 0)
-TRANS_FEAT(UXTW, aa64_sve, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(UXTW, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            a->esz == 3 ? gen_helper_sve_uxtw_d : NULL, a, 0)
 
 static gen_helper_gvec_3 * const addqv_fns[4] = {
@@ -912,7 +912,7 @@ static bool do_vpz_ool(DisasContext *s, arg_rpr_esz *a,
         gen_helper_sve_##name##_b, gen_helper_sve_##name##_h,            \
         gen_helper_sve_##name##_s, gen_helper_sve_##name##_d,            \
     };                                                                   \
-    TRANS_FEAT(NAME, aa64_sve, do_vpz_ool, a, name##_fns[a->esz])
+    TRANS_FEAT(NAME, aa64_sme_or_sve, do_vpz_ool, a, name##_fns[a->esz])
 
 DO_VPZ(ORV, orv)
 DO_VPZ(ANDV, andv)
@@ -928,7 +928,7 @@ static gen_helper_gvec_reduc * const saddv_fns[4] = {
     gen_helper_sve_saddv_b, gen_helper_sve_saddv_h,
     gen_helper_sve_saddv_s, NULL
 };
-TRANS_FEAT(SADDV, aa64_sve, do_vpz_ool, a, saddv_fns[a->esz])
+TRANS_FEAT(SADDV, aa64_sme_or_sve, do_vpz_ool, a, saddv_fns[a->esz])
 
 #undef DO_VPZ
 
@@ -980,59 +980,59 @@ static gen_helper_gvec_3 * const asr_zpzi_fns[4] = {
     gen_helper_sve_asr_zpzi_b, gen_helper_sve_asr_zpzi_h,
     gen_helper_sve_asr_zpzi_s, gen_helper_sve_asr_zpzi_d,
 };
-TRANS_FEAT(ASR_zpzi, aa64_sve, do_shift_zpzi, a, true, asr_zpzi_fns)
+TRANS_FEAT(ASR_zpzi, aa64_sme_or_sve, do_shift_zpzi, a, true, asr_zpzi_fns)
 
 static gen_helper_gvec_3 * const lsr_zpzi_fns[4] = {
     gen_helper_sve_lsr_zpzi_b, gen_helper_sve_lsr_zpzi_h,
     gen_helper_sve_lsr_zpzi_s, gen_helper_sve_lsr_zpzi_d,
 };
-TRANS_FEAT(LSR_zpzi, aa64_sve, do_shift_zpzi, a, false, lsr_zpzi_fns)
+TRANS_FEAT(LSR_zpzi, aa64_sme_or_sve, do_shift_zpzi, a, false, lsr_zpzi_fns)
 
 static gen_helper_gvec_3 * const lsl_zpzi_fns[4] = {
     gen_helper_sve_lsl_zpzi_b, gen_helper_sve_lsl_zpzi_h,
     gen_helper_sve_lsl_zpzi_s, gen_helper_sve_lsl_zpzi_d,
 };
-TRANS_FEAT(LSL_zpzi, aa64_sve, do_shift_zpzi, a, false, lsl_zpzi_fns)
+TRANS_FEAT(LSL_zpzi, aa64_sme_or_sve, do_shift_zpzi, a, false, lsl_zpzi_fns)
 
 static gen_helper_gvec_3 * const asrd_fns[4] = {
     gen_helper_sve_asrd_b, gen_helper_sve_asrd_h,
     gen_helper_sve_asrd_s, gen_helper_sve_asrd_d,
 };
-TRANS_FEAT(ASRD, aa64_sve, do_shift_zpzi, a, false, asrd_fns)
+TRANS_FEAT(ASRD, aa64_sme_or_sve, do_shift_zpzi, a, false, asrd_fns)
 
 static gen_helper_gvec_3 * const sqshl_zpzi_fns[4] = {
     gen_helper_sve2_sqshl_zpzi_b, gen_helper_sve2_sqshl_zpzi_h,
     gen_helper_sve2_sqshl_zpzi_s, gen_helper_sve2_sqshl_zpzi_d,
 };
-TRANS_FEAT(SQSHL_zpzi, aa64_sve2, gen_gvec_ool_arg_zpzi,
+TRANS_FEAT(SQSHL_zpzi, aa64_sme_or_sve2, gen_gvec_ool_arg_zpzi,
            a->esz < 0 ? NULL : sqshl_zpzi_fns[a->esz], a)
 
 static gen_helper_gvec_3 * const uqshl_zpzi_fns[4] = {
     gen_helper_sve2_uqshl_zpzi_b, gen_helper_sve2_uqshl_zpzi_h,
     gen_helper_sve2_uqshl_zpzi_s, gen_helper_sve2_uqshl_zpzi_d,
 };
-TRANS_FEAT(UQSHL_zpzi, aa64_sve2, gen_gvec_ool_arg_zpzi,
+TRANS_FEAT(UQSHL_zpzi, aa64_sme_or_sve2, gen_gvec_ool_arg_zpzi,
            a->esz < 0 ? NULL : uqshl_zpzi_fns[a->esz], a)
 
 static gen_helper_gvec_3 * const srshr_fns[4] = {
     gen_helper_sve2_srshr_b, gen_helper_sve2_srshr_h,
     gen_helper_sve2_srshr_s, gen_helper_sve2_srshr_d,
 };
-TRANS_FEAT(SRSHR, aa64_sve2, gen_gvec_ool_arg_zpzi,
+TRANS_FEAT(SRSHR, aa64_sme_or_sve2, gen_gvec_ool_arg_zpzi,
            a->esz < 0 ? NULL : srshr_fns[a->esz], a)
 
 static gen_helper_gvec_3 * const urshr_fns[4] = {
     gen_helper_sve2_urshr_b, gen_helper_sve2_urshr_h,
     gen_helper_sve2_urshr_s, gen_helper_sve2_urshr_d,
 };
-TRANS_FEAT(URSHR, aa64_sve2, gen_gvec_ool_arg_zpzi,
+TRANS_FEAT(URSHR, aa64_sme_or_sve2, gen_gvec_ool_arg_zpzi,
            a->esz < 0 ? NULL : urshr_fns[a->esz], a)
 
 static gen_helper_gvec_3 * const sqshlu_fns[4] = {
     gen_helper_sve2_sqshlu_b, gen_helper_sve2_sqshlu_h,
     gen_helper_sve2_sqshlu_s, gen_helper_sve2_sqshlu_d,
 };
-TRANS_FEAT(SQSHLU, aa64_sve2, gen_gvec_ool_arg_zpzi,
+TRANS_FEAT(SQSHLU, aa64_sme_or_sve2, gen_gvec_ool_arg_zpzi,
            a->esz < 0 ? NULL : sqshlu_fns[a->esz], a)
 
 /*
@@ -1044,7 +1044,7 @@ TRANS_FEAT(SQSHLU, aa64_sve2, gen_gvec_ool_arg_zpzi,
         gen_helper_sve_##name##_zpzw_b, gen_helper_sve_##name##_zpzw_h,   \
         gen_helper_sve_##name##_zpzw_s, NULL                              \
     };                                                                    \
-    TRANS_FEAT(NAME##_zpzw, aa64_sve, gen_gvec_ool_arg_zpzz,              \
+    TRANS_FEAT(NAME##_zpzw, aa64_sme_or_sve, gen_gvec_ool_arg_zpzz,              \
                a->esz < 0 ? NULL : name##_zpzw_fns[a->esz], a, 0)
 
 DO_ZPZW(ASR, asr)
@@ -1084,16 +1084,16 @@ static bool do_shift_imm(DisasContext *s, arg_rri_esz *a, bool asr,
     return true;
 }
 
-TRANS_FEAT(ASR_zzi, aa64_sve, do_shift_imm, a, true, tcg_gen_gvec_sari)
-TRANS_FEAT(LSR_zzi, aa64_sve, do_shift_imm, a, false, tcg_gen_gvec_shri)
-TRANS_FEAT(LSL_zzi, aa64_sve, do_shift_imm, a, false, tcg_gen_gvec_shli)
+TRANS_FEAT(ASR_zzi, aa64_sme_or_sve, do_shift_imm, a, true, tcg_gen_gvec_sari)
+TRANS_FEAT(LSR_zzi, aa64_sme_or_sve, do_shift_imm, a, false, tcg_gen_gvec_shri)
+TRANS_FEAT(LSL_zzi, aa64_sme_or_sve, do_shift_imm, a, false, tcg_gen_gvec_shli)
 
 #define DO_ZZW(NAME, name) \
     static gen_helper_gvec_3 * const name##_zzw_fns[4] = {                \
         gen_helper_sve_##name##_zzw_b, gen_helper_sve_##name##_zzw_h,     \
         gen_helper_sve_##name##_zzw_s, NULL                               \
     };                                                                    \
-    TRANS_FEAT(NAME, aa64_sve, gen_gvec_ool_arg_zzz,                      \
+    TRANS_FEAT(NAME, aa64_sme_or_sve, gen_gvec_ool_arg_zzz,                      \
                name##_zzw_fns[a->esz], a, 0)
 
 DO_ZZW(ASR_zzw, asr)
@@ -1125,13 +1125,13 @@ static gen_helper_gvec_5 * const mla_fns[4] = {
     gen_helper_sve_mla_b, gen_helper_sve_mla_h,
     gen_helper_sve_mla_s, gen_helper_sve_mla_d,
 };
-TRANS_FEAT(MLA, aa64_sve, do_zpzzz_ool, a, mla_fns[a->esz])
+TRANS_FEAT(MLA, aa64_sme_or_sve, do_zpzzz_ool, a, mla_fns[a->esz])
 
 static gen_helper_gvec_5 * const mls_fns[4] = {
     gen_helper_sve_mls_b, gen_helper_sve_mls_h,
     gen_helper_sve_mls_s, gen_helper_sve_mls_d,
 };
-TRANS_FEAT(MLS, aa64_sve, do_zpzzz_ool, a, mls_fns[a->esz])
+TRANS_FEAT(MLS, aa64_sme_or_sve, do_zpzzz_ool, a, mls_fns[a->esz])
 
 /*
  *** SVE Index Generation Group
@@ -1172,13 +1172,13 @@ static bool do_index(DisasContext *s, int esz, int rd,
     return true;
 }
 
-TRANS_FEAT(INDEX_ii, aa64_sve, do_index, a->esz, a->rd,
+TRANS_FEAT(INDEX_ii, aa64_sme_or_sve, do_index, a->esz, a->rd,
            tcg_constant_i64(a->imm1), tcg_constant_i64(a->imm2))
-TRANS_FEAT(INDEX_ir, aa64_sve, do_index, a->esz, a->rd,
+TRANS_FEAT(INDEX_ir, aa64_sme_or_sve, do_index, a->esz, a->rd,
            tcg_constant_i64(a->imm), cpu_reg(s, a->rm))
-TRANS_FEAT(INDEX_ri, aa64_sve, do_index, a->esz, a->rd,
+TRANS_FEAT(INDEX_ri, aa64_sme_or_sve, do_index, a->esz, a->rd,
            cpu_reg(s, a->rn), tcg_constant_i64(a->imm))
-TRANS_FEAT(INDEX_rr, aa64_sve, do_index, a->esz, a->rd,
+TRANS_FEAT(INDEX_rr, aa64_sme_or_sve, do_index, a->esz, a->rd,
            cpu_reg(s, a->rn), cpu_reg(s, a->rm))
 
 /*
@@ -1187,7 +1187,7 @@ TRANS_FEAT(INDEX_rr, aa64_sve, do_index, a->esz, a->rd,
 
 static bool trans_ADDVL(DisasContext *s, arg_ADDVL *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -1213,7 +1213,7 @@ static bool trans_ADDSVL(DisasContext *s, arg_ADDSVL *a)
 
 static bool trans_ADDPL(DisasContext *s, arg_ADDPL *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -1239,7 +1239,7 @@ static bool trans_ADDSPL(DisasContext *s, arg_ADDSPL *a)
 
 static bool trans_RDVL(DisasContext *s, arg_RDVL *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -1370,7 +1370,7 @@ static bool trans_AND_pppp(DisasContext *s, arg_rprr_s *a)
         .prefer_i64 = true,
     };
 
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (!a->s) {
@@ -1408,7 +1408,7 @@ static bool trans_BIC_pppp(DisasContext *s, arg_rprr_s *a)
         .prefer_i64 = true,
     };
 
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (!a->s && a->pg == a->rn) {
@@ -1439,7 +1439,7 @@ static bool trans_EOR_pppp(DisasContext *s, arg_rprr_s *a)
         .prefer_i64 = true,
     };
 
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     /* Alias NOT (predicate) is EOR Pd.B, Pg/Z, Pn.B, Pg.B */
@@ -1451,7 +1451,7 @@ static bool trans_EOR_pppp(DisasContext *s, arg_rprr_s *a)
 
 static bool trans_SEL_pppp(DisasContext *s, arg_rprr_s *a)
 {
-    if (a->s || !dc_isar_feature(aa64_sve, s)) {
+    if (a->s || !dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -1486,7 +1486,7 @@ static bool trans_ORR_pppp(DisasContext *s, arg_rprr_s *a)
         .prefer_i64 = true,
     };
 
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (!a->s && a->pg == a->rn && a->rn == a->rm) {
@@ -1517,7 +1517,7 @@ static bool trans_ORN_pppp(DisasContext *s, arg_rprr_s *a)
         .prefer_i64 = true,
     };
 
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     return do_pppp_flags(s, a, &op);
@@ -1545,7 +1545,7 @@ static bool trans_NOR_pppp(DisasContext *s, arg_rprr_s *a)
         .prefer_i64 = true,
     };
 
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     return do_pppp_flags(s, a, &op);
@@ -1573,7 +1573,7 @@ static bool trans_NAND_pppp(DisasContext *s, arg_rprr_s *a)
         .prefer_i64 = true,
     };
 
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     return do_pppp_flags(s, a, &op);
@@ -1585,7 +1585,7 @@ static bool trans_NAND_pppp(DisasContext *s, arg_rprr_s *a)
 
 static bool trans_PTEST(DisasContext *s, arg_PTEST *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -1723,7 +1723,7 @@ static bool do_predset(DisasContext *s, int esz, int rd, int pat, bool setflag)
     return true;
 }
 
-TRANS_FEAT(PTRUE, aa64_sve, do_predset, a->esz, a->rd, a->pat, a->s)
+TRANS_FEAT(PTRUE, aa64_sme_or_sve, do_predset, a->esz, a->rd, a->pat, a->s)
 
 static bool trans_PTRUE_cnt(DisasContext *s, arg_PTRUE_cnt *a)
 {
@@ -1746,7 +1746,7 @@ TRANS_FEAT_NONSTREAMING(SETFFR, aa64_sve,
                         do_predset, 0, FFR_PRED_NUM, 31, false)
 
 /* Note pat == 32 is #unimp, to set no elements.  */
-TRANS_FEAT(PFALSE, aa64_sve, do_predset, 0, a->rd, 32, false)
+TRANS_FEAT(PFALSE, aa64_sme_or_sve, do_predset, 0, a->rd, 32, false)
 
 static bool trans_RDFFR_p(DisasContext *s, arg_RDFFR_p *a)
 {
@@ -1791,8 +1791,8 @@ static bool do_pfirst_pnext(DisasContext *s, arg_rr_esz *a,
     return true;
 }
 
-TRANS_FEAT(PFIRST, aa64_sve, do_pfirst_pnext, a, gen_helper_sve_pfirst)
-TRANS_FEAT(PNEXT, aa64_sve, do_pfirst_pnext, a, gen_helper_sve_pnext)
+TRANS_FEAT(PFIRST, aa64_sme_or_sve, do_pfirst_pnext, a, gen_helper_sve_pfirst)
+TRANS_FEAT(PNEXT, aa64_sme_or_sve, do_pfirst_pnext, a, gen_helper_sve_pnext)
 
 /*
  *** SVE Element Count Group
@@ -1946,7 +1946,7 @@ static void do_sat_addsub_vec(DisasContext *s, int esz, int rd, int rn,
 
 static bool trans_CNT_r(DisasContext *s, arg_CNT_r *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -1959,7 +1959,7 @@ static bool trans_CNT_r(DisasContext *s, arg_CNT_r *a)
 
 static bool trans_INCDEC_r(DisasContext *s, arg_incdec_cnt *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -1975,7 +1975,7 @@ static bool trans_INCDEC_r(DisasContext *s, arg_incdec_cnt *a)
 
 static bool trans_SINCDEC_r_32(DisasContext *s, arg_incdec_cnt *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (!sve_access_check(s)) {
@@ -2002,7 +2002,7 @@ static bool trans_SINCDEC_r_32(DisasContext *s, arg_incdec_cnt *a)
 
 static bool trans_SINCDEC_r_64(DisasContext *s, arg_incdec_cnt *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (!sve_access_check(s)) {
@@ -2022,7 +2022,7 @@ static bool trans_SINCDEC_r_64(DisasContext *s, arg_incdec_cnt *a)
 
 static bool trans_INCDEC_v(DisasContext *s, arg_incdec2_cnt *a)
 {
-    if (a->esz == 0 || !dc_isar_feature(aa64_sve, s)) {
+    if (a->esz == 0 || !dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
 
@@ -2045,7 +2045,7 @@ static bool trans_INCDEC_v(DisasContext *s, arg_incdec2_cnt *a)
 
 static bool trans_SINCDEC_v(DisasContext *s, arg_incdec2_cnt *a)
 {
-    if (a->esz == 0 || !dc_isar_feature(aa64_sve, s)) {
+    if (a->esz == 0 || !dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
 
@@ -2079,15 +2079,15 @@ static bool do_zz_dbm(DisasContext *s, arg_rr_dbm *a, GVecGen2iFn *gvec_fn)
     return gen_gvec_fn_zzi(s, gvec_fn, MO_64, a->rd, a->rn, imm);
 }
 
-TRANS_FEAT(AND_zzi, aa64_sve, do_zz_dbm, a, tcg_gen_gvec_andi)
-TRANS_FEAT(ORR_zzi, aa64_sve, do_zz_dbm, a, tcg_gen_gvec_ori)
-TRANS_FEAT(EOR_zzi, aa64_sve, do_zz_dbm, a, tcg_gen_gvec_xori)
+TRANS_FEAT(AND_zzi, aa64_sme_or_sve, do_zz_dbm, a, tcg_gen_gvec_andi)
+TRANS_FEAT(ORR_zzi, aa64_sme_or_sve, do_zz_dbm, a, tcg_gen_gvec_ori)
+TRANS_FEAT(EOR_zzi, aa64_sme_or_sve, do_zz_dbm, a, tcg_gen_gvec_xori)
 
 static bool trans_DUPM(DisasContext *s, arg_DUPM *a)
 {
     uint64_t imm;
 
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (!logic_imm_decode_wmask(&imm, extract32(a->dbm, 12, 1),
@@ -2131,7 +2131,7 @@ static void do_cpy_m(DisasContext *s, int esz, int rd, int rn, int pg,
 
 static bool trans_FCPY(DisasContext *s, arg_FCPY *a)
 {
-    if (a->esz == 0 || !dc_isar_feature(aa64_sve, s)) {
+    if (a->esz == 0 || !dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -2144,7 +2144,7 @@ static bool trans_FCPY(DisasContext *s, arg_FCPY *a)
 
 static bool trans_CPY_m_i(DisasContext *s, arg_rpri_esz *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -2160,7 +2160,7 @@ static bool trans_CPY_z_i(DisasContext *s, arg_CPY_z_i *a)
         gen_helper_sve_cpy_z_s, gen_helper_sve_cpy_z_d,
     };
 
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -2207,8 +2207,8 @@ static bool do_EXT(DisasContext *s, int rd, int rn, int rm, int imm)
     return true;
 }
 
-TRANS_FEAT(EXT, aa64_sve, do_EXT, a->rd, a->rn, a->rm, a->imm)
-TRANS_FEAT(EXT_sve2, aa64_sve2, do_EXT, a->rd, a->rn, (a->rn + 1) % 32, a->imm)
+TRANS_FEAT(EXT, aa64_sme_or_sve, do_EXT, a->rd, a->rn, a->rm, a->imm)
+TRANS_FEAT(EXT_sve2, aa64_sme_or_sve2, do_EXT, a->rd, a->rn, (a->rn + 1) % 32, a->imm)
 
 static bool trans_EXTQ(DisasContext *s, arg_EXTQ *a)
 {
@@ -2265,7 +2265,7 @@ static bool trans_EXTQ(DisasContext *s, arg_EXTQ *a)
 
 static bool trans_DUP_s(DisasContext *s, arg_DUP_s *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -2278,7 +2278,7 @@ static bool trans_DUP_s(DisasContext *s, arg_DUP_s *a)
 
 static bool trans_DUP_x(DisasContext *s, arg_DUP_x *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if ((a->imm & 0x1f) == 0) {
@@ -2347,7 +2347,7 @@ static void do_insr_i64(DisasContext *s, arg_rrr_esz *a, TCGv_i64 val)
 
 static bool trans_INSR_f(DisasContext *s, arg_rrr_esz *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -2360,7 +2360,7 @@ static bool trans_INSR_f(DisasContext *s, arg_rrr_esz *a)
 
 static bool trans_INSR_r(DisasContext *s, arg_rrr_esz *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -2373,19 +2373,19 @@ static gen_helper_gvec_2 * const rev_fns[4] = {
     gen_helper_sve_rev_b, gen_helper_sve_rev_h,
     gen_helper_sve_rev_s, gen_helper_sve_rev_d
 };
-TRANS_FEAT(REV_v, aa64_sve, gen_gvec_ool_zz, rev_fns[a->esz], a->rd, a->rn, 0)
+TRANS_FEAT(REV_v, aa64_sme_or_sve, gen_gvec_ool_zz, rev_fns[a->esz], a->rd, a->rn, 0)
 
 static gen_helper_gvec_3 * const sve_tbl_fns[4] = {
     gen_helper_sve_tbl_b, gen_helper_sve_tbl_h,
     gen_helper_sve_tbl_s, gen_helper_sve_tbl_d
 };
-TRANS_FEAT(TBL, aa64_sve, gen_gvec_ool_arg_zzz, sve_tbl_fns[a->esz], a, 0)
+TRANS_FEAT(TBL, aa64_sme_or_sve, gen_gvec_ool_arg_zzz, sve_tbl_fns[a->esz], a, 0)
 
 static gen_helper_gvec_4 * const sve2_tbl_fns[4] = {
     gen_helper_sve2_tbl_b, gen_helper_sve2_tbl_h,
     gen_helper_sve2_tbl_s, gen_helper_sve2_tbl_d
 };
-TRANS_FEAT(TBL_sve2, aa64_sve2, gen_gvec_ool_zzzz, sve2_tbl_fns[a->esz],
+TRANS_FEAT(TBL_sve2, aa64_sme_or_sve2, gen_gvec_ool_zzzz, sve2_tbl_fns[a->esz],
            a->rd, a->rn, (a->rn + 1) % 32, a->rm, 0)
 
 static gen_helper_gvec_3 * const tblq_fns[4] = {
@@ -2399,7 +2399,7 @@ static gen_helper_gvec_3 * const tbx_fns[4] = {
     gen_helper_sve2_tbx_b, gen_helper_sve2_tbx_h,
     gen_helper_sve2_tbx_s, gen_helper_sve2_tbx_d
 };
-TRANS_FEAT(TBX, aa64_sve2, gen_gvec_ool_arg_zzz, tbx_fns[a->esz], a, 0)
+TRANS_FEAT(TBX, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz, tbx_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const tbxq_fns[4] = {
     gen_helper_sve2p1_tbxq_b, gen_helper_sve2p1_tbxq_h,
@@ -2515,7 +2515,7 @@ static bool trans_UNPK(DisasContext *s, arg_UNPK *a)
         { gen_helper_sve_sunpk_d, gen_helper_sve_uunpk_d },
     };
 
-    if (a->esz == 0 || !dc_isar_feature(aa64_sve, s)) {
+    if (a->esz == 0 || !dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -2581,16 +2581,16 @@ static bool do_perm_pred2(DisasContext *s, arg_rr_esz *a, bool high_odd,
     return true;
 }
 
-TRANS_FEAT(ZIP1_p, aa64_sve, do_perm_pred3, a, 0, gen_helper_sve_zip_p)
-TRANS_FEAT(ZIP2_p, aa64_sve, do_perm_pred3, a, 1, gen_helper_sve_zip_p)
-TRANS_FEAT(UZP1_p, aa64_sve, do_perm_pred3, a, 0, gen_helper_sve_uzp_p)
-TRANS_FEAT(UZP2_p, aa64_sve, do_perm_pred3, a, 1, gen_helper_sve_uzp_p)
-TRANS_FEAT(TRN1_p, aa64_sve, do_perm_pred3, a, 0, gen_helper_sve_trn_p)
-TRANS_FEAT(TRN2_p, aa64_sve, do_perm_pred3, a, 1, gen_helper_sve_trn_p)
+TRANS_FEAT(ZIP1_p, aa64_sme_or_sve, do_perm_pred3, a, 0, gen_helper_sve_zip_p)
+TRANS_FEAT(ZIP2_p, aa64_sme_or_sve, do_perm_pred3, a, 1, gen_helper_sve_zip_p)
+TRANS_FEAT(UZP1_p, aa64_sme_or_sve, do_perm_pred3, a, 0, gen_helper_sve_uzp_p)
+TRANS_FEAT(UZP2_p, aa64_sme_or_sve, do_perm_pred3, a, 1, gen_helper_sve_uzp_p)
+TRANS_FEAT(TRN1_p, aa64_sme_or_sve, do_perm_pred3, a, 0, gen_helper_sve_trn_p)
+TRANS_FEAT(TRN2_p, aa64_sme_or_sve, do_perm_pred3, a, 1, gen_helper_sve_trn_p)
 
-TRANS_FEAT(REV_p, aa64_sve, do_perm_pred2, a, 0, gen_helper_sve_rev_p)
-TRANS_FEAT(PUNPKLO, aa64_sve, do_perm_pred2, a, 0, gen_helper_sve_punpk_p)
-TRANS_FEAT(PUNPKHI, aa64_sve, do_perm_pred2, a, 1, gen_helper_sve_punpk_p)
+TRANS_FEAT(REV_p, aa64_sme_or_sve, do_perm_pred2, a, 0, gen_helper_sve_rev_p)
+TRANS_FEAT(PUNPKLO, aa64_sme_or_sve, do_perm_pred2, a, 0, gen_helper_sve_punpk_p)
+TRANS_FEAT(PUNPKHI, aa64_sme_or_sve, do_perm_pred2, a, 1, gen_helper_sve_punpk_p)
 
 /*
  *** SVE Permute - Interleaving Group
@@ -2617,9 +2617,9 @@ static gen_helper_gvec_3 * const zip_fns[4] = {
     gen_helper_sve_zip_b, gen_helper_sve_zip_h,
     gen_helper_sve_zip_s, gen_helper_sve_zip_d,
 };
-TRANS_FEAT(ZIP1_z, aa64_sve, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(ZIP1_z, aa64_sme_or_sve, gen_gvec_ool_arg_zzz,
            zip_fns[a->esz], a, 0)
-TRANS_FEAT(ZIP2_z, aa64_sve, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(ZIP2_z, aa64_sme_or_sve, gen_gvec_ool_arg_zzz,
            zip_fns[a->esz], a, vec_full_reg_size(s) / 2)
 
 TRANS_FEAT_NONSTREAMING(ZIP1_q, aa64_sve_f64mm, do_interleave_q,
@@ -2641,9 +2641,9 @@ static gen_helper_gvec_3 * const uzp_fns[4] = {
     gen_helper_sve_uzp_b, gen_helper_sve_uzp_h,
     gen_helper_sve_uzp_s, gen_helper_sve_uzp_d,
 };
-TRANS_FEAT(UZP1_z, aa64_sve, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(UZP1_z, aa64_sme_or_sve, gen_gvec_ool_arg_zzz,
            uzp_fns[a->esz], a, 0)
-TRANS_FEAT(UZP2_z, aa64_sve, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(UZP2_z, aa64_sme_or_sve, gen_gvec_ool_arg_zzz,
            uzp_fns[a->esz], a, 1 << a->esz)
 
 TRANS_FEAT_NONSTREAMING(UZP1_q, aa64_sve_f64mm, do_interleave_q,
@@ -2665,9 +2665,9 @@ static gen_helper_gvec_3 * const trn_fns[4] = {
     gen_helper_sve_trn_s, gen_helper_sve_trn_d,
 };
 
-TRANS_FEAT(TRN1_z, aa64_sve, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(TRN1_z, aa64_sme_or_sve, gen_gvec_ool_arg_zzz,
            trn_fns[a->esz], a, 0)
-TRANS_FEAT(TRN2_z, aa64_sve, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(TRN2_z, aa64_sme_or_sve, gen_gvec_ool_arg_zzz,
            trn_fns[a->esz], a, 1 << a->esz)
 
 TRANS_FEAT_NONSTREAMING(TRN1_q, aa64_sve_f64mm, do_interleave_q,
@@ -2828,8 +2828,8 @@ static bool do_clast_vector(DisasContext *s, arg_rprr_esz *a, bool before)
     return true;
 }
 
-TRANS_FEAT(CLASTA_z, aa64_sve, do_clast_vector, a, false)
-TRANS_FEAT(CLASTB_z, aa64_sve, do_clast_vector, a, true)
+TRANS_FEAT(CLASTA_z, aa64_sme_or_sve, do_clast_vector, a, false)
+TRANS_FEAT(CLASTB_z, aa64_sme_or_sve, do_clast_vector, a, true)
 
 /* Compute CLAST for a scalar.  */
 static void do_clast_scalar(DisasContext *s, int esz, int pg, int rm,
@@ -2873,8 +2873,8 @@ static bool do_clast_fp(DisasContext *s, arg_rpr_esz *a, bool before)
     return true;
 }
 
-TRANS_FEAT(CLASTA_v, aa64_sve, do_clast_fp, a, false)
-TRANS_FEAT(CLASTB_v, aa64_sve, do_clast_fp, a, true)
+TRANS_FEAT(CLASTA_v, aa64_sme_or_sve, do_clast_fp, a, false)
+TRANS_FEAT(CLASTB_v, aa64_sme_or_sve, do_clast_fp, a, true)
 
 /* Compute CLAST for a Xreg.  */
 static bool do_clast_general(DisasContext *s, arg_rpr_esz *a, bool before)
@@ -2906,8 +2906,8 @@ static bool do_clast_general(DisasContext *s, arg_rpr_esz *a, bool before)
     return true;
 }
 
-TRANS_FEAT(CLASTA_r, aa64_sve, do_clast_general, a, false)
-TRANS_FEAT(CLASTB_r, aa64_sve, do_clast_general, a, true)
+TRANS_FEAT(CLASTA_r, aa64_sme_or_sve, do_clast_general, a, false)
+TRANS_FEAT(CLASTB_r, aa64_sme_or_sve, do_clast_general, a, true)
 
 /* Compute LAST for a scalar.  */
 static TCGv_i64 do_last_scalar(DisasContext *s, int esz,
@@ -2935,8 +2935,8 @@ static bool do_last_fp(DisasContext *s, arg_rpr_esz *a, bool before)
     return true;
 }
 
-TRANS_FEAT(LASTA_v, aa64_sve, do_last_fp, a, false)
-TRANS_FEAT(LASTB_v, aa64_sve, do_last_fp, a, true)
+TRANS_FEAT(LASTA_v, aa64_sme_or_sve, do_last_fp, a, false)
+TRANS_FEAT(LASTB_v, aa64_sme_or_sve, do_last_fp, a, true)
 
 /* Compute LAST for a Xreg.  */
 static bool do_last_general(DisasContext *s, arg_rpr_esz *a, bool before)
@@ -2948,12 +2948,12 @@ static bool do_last_general(DisasContext *s, arg_rpr_esz *a, bool before)
     return true;
 }
 
-TRANS_FEAT(LASTA_r, aa64_sve, do_last_general, a, false)
-TRANS_FEAT(LASTB_r, aa64_sve, do_last_general, a, true)
+TRANS_FEAT(LASTA_r, aa64_sme_or_sve, do_last_general, a, false)
+TRANS_FEAT(LASTB_r, aa64_sme_or_sve, do_last_general, a, true)
 
 static bool trans_CPY_m_r(DisasContext *s, arg_rpr_esz *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -2964,7 +2964,7 @@ static bool trans_CPY_m_r(DisasContext *s, arg_rpr_esz *a)
 
 static bool trans_CPY_m_v(DisasContext *s, arg_rpr_esz *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -2979,22 +2979,22 @@ static gen_helper_gvec_3 * const revb_fns[4] = {
     NULL,                  gen_helper_sve_revb_h,
     gen_helper_sve_revb_s, gen_helper_sve_revb_d,
 };
-TRANS_FEAT(REVB, aa64_sve, gen_gvec_ool_arg_zpz, revb_fns[a->esz], a, 0)
+TRANS_FEAT(REVB, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, revb_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const revh_fns[4] = {
     NULL, NULL, gen_helper_sve_revh_s, gen_helper_sve_revh_d,
 };
-TRANS_FEAT(REVH, aa64_sve, gen_gvec_ool_arg_zpz, revh_fns[a->esz], a, 0)
+TRANS_FEAT(REVH, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, revh_fns[a->esz], a, 0)
 
-TRANS_FEAT(REVW, aa64_sve, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(REVW, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            a->esz == 3 ? gen_helper_sve_revw_d : NULL, a, 0)
 
 TRANS_FEAT(REVD, aa64_sme, gen_gvec_ool_arg_zpz, gen_helper_sme_revd_q, a, 0)
 
-TRANS_FEAT(SPLICE, aa64_sve, gen_gvec_ool_arg_zpzz,
+TRANS_FEAT(SPLICE, aa64_sme_or_sve, gen_gvec_ool_arg_zpzz,
            gen_helper_sve_splice, a, a->esz)
 
-TRANS_FEAT(SPLICE_sve2, aa64_sve2, gen_gvec_ool_zzzp, gen_helper_sve_splice,
+TRANS_FEAT(SPLICE_sve2, aa64_sme_or_sve2, gen_gvec_ool_zzzp, gen_helper_sve_splice,
            a->rd, a->rn, (a->rn + 1) % 32, a->pg, a->esz)
 
 /*
@@ -3038,7 +3038,7 @@ static bool do_ppzz_flags(DisasContext *s, arg_rprr_esz *a,
         gen_helper_sve_##name##_ppzz_b, gen_helper_sve_##name##_ppzz_h, \
         gen_helper_sve_##name##_ppzz_s, gen_helper_sve_##name##_ppzz_d, \
     };                                                                  \
-    TRANS_FEAT(NAME##_ppzz, aa64_sve, do_ppzz_flags,                    \
+    TRANS_FEAT(NAME##_ppzz, aa64_sme_or_sve, do_ppzz_flags,                    \
                a, name##_ppzz_fns[a->esz])
 
 DO_PPZZ(CMPEQ, cmpeq)
@@ -3055,7 +3055,7 @@ DO_PPZZ(CMPHS, cmphs)
         gen_helper_sve_##name##_ppzw_b, gen_helper_sve_##name##_ppzw_h, \
         gen_helper_sve_##name##_ppzw_s, NULL                            \
     };                                                                  \
-    TRANS_FEAT(NAME##_ppzw, aa64_sve, do_ppzz_flags,                    \
+    TRANS_FEAT(NAME##_ppzw, aa64_sme_or_sve, do_ppzz_flags,                    \
                a, name##_ppzw_fns[a->esz])
 
 DO_PPZW(CMPEQ, cmpeq)
@@ -3110,7 +3110,7 @@ static bool do_ppzi_flags(DisasContext *s, arg_rpri_esz *a,
         gen_helper_sve_##name##_ppzi_b, gen_helper_sve_##name##_ppzi_h,   \
         gen_helper_sve_##name##_ppzi_s, gen_helper_sve_##name##_ppzi_d,   \
     };                                                                    \
-    TRANS_FEAT(NAME##_ppzi, aa64_sve, do_ppzi_flags, a,                   \
+    TRANS_FEAT(NAME##_ppzi, aa64_sme_or_sve, do_ppzi_flags, a,                   \
                name##_ppzi_fns[a->esz])
 
 DO_PPZI(CMPEQ, cmpeq)
@@ -3190,22 +3190,22 @@ static bool do_brk2(DisasContext *s, arg_rpr_s *a,
     return true;
 }
 
-TRANS_FEAT(BRKPA, aa64_sve, do_brk3, a,
+TRANS_FEAT(BRKPA, aa64_sme_or_sve, do_brk3, a,
            gen_helper_sve_brkpa, gen_helper_sve_brkpas)
-TRANS_FEAT(BRKPB, aa64_sve, do_brk3, a,
+TRANS_FEAT(BRKPB, aa64_sme_or_sve, do_brk3, a,
            gen_helper_sve_brkpb, gen_helper_sve_brkpbs)
 
-TRANS_FEAT(BRKA_m, aa64_sve, do_brk2, a,
+TRANS_FEAT(BRKA_m, aa64_sme_or_sve, do_brk2, a,
            gen_helper_sve_brka_m, gen_helper_sve_brkas_m)
-TRANS_FEAT(BRKB_m, aa64_sve, do_brk2, a,
+TRANS_FEAT(BRKB_m, aa64_sme_or_sve, do_brk2, a,
            gen_helper_sve_brkb_m, gen_helper_sve_brkbs_m)
 
-TRANS_FEAT(BRKA_z, aa64_sve, do_brk2, a,
+TRANS_FEAT(BRKA_z, aa64_sme_or_sve, do_brk2, a,
            gen_helper_sve_brka_z, gen_helper_sve_brkas_z)
-TRANS_FEAT(BRKB_z, aa64_sve, do_brk2, a,
+TRANS_FEAT(BRKB_z, aa64_sme_or_sve, do_brk2, a,
            gen_helper_sve_brkb_z, gen_helper_sve_brkbs_z)
 
-TRANS_FEAT(BRKN, aa64_sve, do_brk2, a,
+TRANS_FEAT(BRKN, aa64_sme_or_sve, do_brk2, a,
            gen_helper_sve_brkn, gen_helper_sve_brkns)
 
 /*
@@ -3250,7 +3250,7 @@ static void do_cntp(DisasContext *s, TCGv_i64 val, int esz, int pn, int pg)
 
 static bool trans_CNTP(DisasContext *s, arg_CNTP *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -3291,7 +3291,7 @@ static bool trans_CNTP_c(DisasContext *s, arg_CNTP_c *a)
 
 static bool trans_INCDECP_r(DisasContext *s, arg_incdec_pred *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -3310,7 +3310,7 @@ static bool trans_INCDECP_r(DisasContext *s, arg_incdec_pred *a)
 
 static bool trans_INCDECP_z(DisasContext *s, arg_incdec2_pred *a)
 {
-    if (a->esz == 0 || !dc_isar_feature(aa64_sve, s)) {
+    if (a->esz == 0 || !dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -3327,7 +3327,7 @@ static bool trans_INCDECP_z(DisasContext *s, arg_incdec2_pred *a)
 
 static bool trans_SINCDECP_r_32(DisasContext *s, arg_incdec_pred *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -3342,7 +3342,7 @@ static bool trans_SINCDECP_r_32(DisasContext *s, arg_incdec_pred *a)
 
 static bool trans_SINCDECP_r_64(DisasContext *s, arg_incdec_pred *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -3357,7 +3357,7 @@ static bool trans_SINCDECP_r_64(DisasContext *s, arg_incdec_pred *a)
 
 static bool trans_SINCDECP_z(DisasContext *s, arg_incdec2_pred *a)
 {
-    if (a->esz == 0 || !dc_isar_feature(aa64_sve, s)) {
+    if (a->esz == 0 || !dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -3374,7 +3374,7 @@ static bool trans_SINCDECP_z(DisasContext *s, arg_incdec2_pred *a)
 
 static bool trans_CTERM(DisasContext *s, arg_CTERM *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (!sve_access_check(s)) {
@@ -3498,9 +3498,9 @@ static bool do_WHILE(DisasContext *s, arg_while *a,
     return true;
 }
 
-TRANS_FEAT(WHILE_lt, aa64_sve, do_WHILE,
+TRANS_FEAT(WHILE_lt, aa64_sme_or_sve, do_WHILE,
            a, true, 0, 0, gen_helper_sve_whilel)
-TRANS_FEAT(WHILE_gt, aa64_sve2, do_WHILE,
+TRANS_FEAT(WHILE_gt, aa64_sme_or_sve2, do_WHILE,
            a, false, 0, 0, gen_helper_sve_whileg)
 
 TRANS_FEAT(WHILE_lt_pair, aa64_sme2_or_sve2p1, do_WHILE,
@@ -3525,7 +3525,7 @@ static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
     unsigned vsz = vec_full_reg_size(s);
     unsigned desc = 0;
 
-    if (!dc_isar_feature(aa64_sve2, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve2, s)) {
         return false;
     }
     if (!sve_access_check(s)) {
@@ -3618,7 +3618,7 @@ TRANS_FEAT(PEXT_2, aa64_sme2_or_sve2p1, do_pext, a, 2)
 
 static bool trans_FDUP(DisasContext *s, arg_FDUP *a)
 {
-    if (a->esz == 0 || !dc_isar_feature(aa64_sve, s)) {
+    if (a->esz == 0 || !dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -3635,7 +3635,7 @@ static bool trans_FDUP(DisasContext *s, arg_FDUP *a)
 
 static bool trans_DUP_i(DisasContext *s, arg_DUP_i *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -3646,7 +3646,7 @@ static bool trans_DUP_i(DisasContext *s, arg_DUP_i *a)
     return true;
 }
 
-TRANS_FEAT(ADD_zzi, aa64_sve, gen_gvec_fn_arg_zzi, tcg_gen_gvec_addi, a)
+TRANS_FEAT(ADD_zzi, aa64_sme_or_sve, gen_gvec_fn_arg_zzi, tcg_gen_gvec_addi, a)
 
 static bool trans_SUB_zzi(DisasContext *s, arg_rri_esz *a)
 {
@@ -3685,7 +3685,7 @@ static bool trans_SUBR_zzi(DisasContext *s, arg_rri_esz *a)
           .scalar_first = true }
     };
 
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -3697,7 +3697,7 @@ static bool trans_SUBR_zzi(DisasContext *s, arg_rri_esz *a)
     return true;
 }
 
-TRANS_FEAT(MUL_zzi, aa64_sve, gen_gvec_fn_arg_zzi, tcg_gen_gvec_muli, a)
+TRANS_FEAT(MUL_zzi, aa64_sme_or_sve, gen_gvec_fn_arg_zzi, tcg_gen_gvec_muli, a)
 
 static bool do_zzi_sat(DisasContext *s, arg_rri_esz *a, bool u, bool d)
 {
@@ -3708,10 +3708,10 @@ static bool do_zzi_sat(DisasContext *s, arg_rri_esz *a, bool u, bool d)
     return true;
 }
 
-TRANS_FEAT(SQADD_zzi, aa64_sve, do_zzi_sat, a, false, false)
-TRANS_FEAT(UQADD_zzi, aa64_sve, do_zzi_sat, a, true, false)
-TRANS_FEAT(SQSUB_zzi, aa64_sve, do_zzi_sat, a, false, true)
-TRANS_FEAT(UQSUB_zzi, aa64_sve, do_zzi_sat, a, true, true)
+TRANS_FEAT(SQADD_zzi, aa64_sme_or_sve, do_zzi_sat, a, false, false)
+TRANS_FEAT(UQADD_zzi, aa64_sme_or_sve, do_zzi_sat, a, true, false)
+TRANS_FEAT(SQSUB_zzi, aa64_sme_or_sve, do_zzi_sat, a, false, true)
+TRANS_FEAT(UQSUB_zzi, aa64_sme_or_sve, do_zzi_sat, a, true, true)
 
 static bool do_zzi_ool(DisasContext *s, arg_rri_esz *a, gen_helper_gvec_2i *fn)
 {
@@ -3729,7 +3729,7 @@ static bool do_zzi_ool(DisasContext *s, arg_rri_esz *a, gen_helper_gvec_2i *fn)
         gen_helper_sve_##name##i_b, gen_helper_sve_##name##i_h,         \
         gen_helper_sve_##name##i_s, gen_helper_sve_##name##i_d,         \
     };                                                                  \
-    TRANS_FEAT(NAME##_zzi, aa64_sve, do_zzi_ool, a, name##i_fns[a->esz])
+    TRANS_FEAT(NAME##_zzi, aa64_sme_or_sve, do_zzi_ool, a, name##i_fns[a->esz])
 
 DO_ZZI(SMAX, smax)
 DO_ZZI(UMAX, umax)
@@ -3742,20 +3742,20 @@ static gen_helper_gvec_4 * const dot_fns[2][2] = {
     { gen_helper_gvec_sdot_4b, gen_helper_gvec_sdot_4h },
     { gen_helper_gvec_udot_4b, gen_helper_gvec_udot_4h }
 };
-TRANS_FEAT(DOT_zzzz, aa64_sve, gen_gvec_ool_zzzz,
+TRANS_FEAT(DOT_zzzz, aa64_sme_or_sve, gen_gvec_ool_zzzz,
            dot_fns[a->u][a->sz], a->rd, a->rn, a->rm, a->ra, 0)
 
 /*
  * SVE Multiply - Indexed
  */
 
-TRANS_FEAT(SDOT_zzxw_4s, aa64_sve, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(SDOT_zzxw_4s, aa64_sme_or_sve, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_sdot_idx_4b, a)
-TRANS_FEAT(SDOT_zzxw_4d, aa64_sve, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(SDOT_zzxw_4d, aa64_sme_or_sve, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_sdot_idx_4h, a)
-TRANS_FEAT(UDOT_zzxw_4s, aa64_sve, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(UDOT_zzxw_4s, aa64_sme_or_sve, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_udot_idx_4b, a)
-TRANS_FEAT(UDOT_zzxw_4d, aa64_sve, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(UDOT_zzxw_4d, aa64_sme_or_sve, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_udot_idx_4h, a)
 
 TRANS_FEAT(SUDOT_zzxw_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
@@ -3769,7 +3769,7 @@ TRANS_FEAT(UDOT_zzxw_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_udot_idx_2h, a)
 
 #define DO_SVE2_RRX(NAME, FUNC) \
-    TRANS_FEAT(NAME, aa64_sve2, gen_gvec_ool_zzz, FUNC,          \
+    TRANS_FEAT(NAME, aa64_sme_or_sve2, gen_gvec_ool_zzz, FUNC,          \
                a->rd, a->rn, a->rm, a->index)
 
 DO_SVE2_RRX(MUL_zzx_h, gen_helper_gvec_mul_idx_h)
@@ -3787,7 +3787,7 @@ DO_SVE2_RRX(SQRDMULH_zzx_d, gen_helper_sve2_sqrdmulh_idx_d)
 #undef DO_SVE2_RRX
 
 #define DO_SVE2_RRX_TB(NAME, FUNC, TOP) \
-    TRANS_FEAT(NAME, aa64_sve2, gen_gvec_ool_zzz, FUNC,          \
+    TRANS_FEAT(NAME, aa64_sme_or_sve2, gen_gvec_ool_zzz, FUNC,          \
                a->rd, a->rn, a->rm, (a->index << 1) | TOP)
 
 DO_SVE2_RRX_TB(SQDMULLB_zzx_s, gen_helper_sve2_sqdmull_idx_s, false)
@@ -3808,7 +3808,7 @@ DO_SVE2_RRX_TB(UMULLT_zzx_d, gen_helper_sve2_umull_idx_d, true)
 #undef DO_SVE2_RRX_TB
 
 #define DO_SVE2_RRXR(NAME, FUNC) \
-    TRANS_FEAT(NAME, aa64_sve2, gen_gvec_ool_arg_zzxz, FUNC, a)
+    TRANS_FEAT(NAME, aa64_sme_or_sve2, gen_gvec_ool_arg_zzxz, FUNC, a)
 
 DO_SVE2_RRXR(MLA_zzxz_h, gen_helper_gvec_mla_idx_h)
 DO_SVE2_RRXR(MLA_zzxz_s, gen_helper_gvec_mla_idx_s)
@@ -3829,7 +3829,7 @@ DO_SVE2_RRXR(SQRDMLSH_zzxz_d, gen_helper_sve2_sqrdmlsh_idx_d)
 #undef DO_SVE2_RRXR
 
 #define DO_SVE2_RRXR_TB(NAME, FUNC, TOP) \
-    TRANS_FEAT(NAME, aa64_sve2, gen_gvec_ool_zzzz, FUNC,        \
+    TRANS_FEAT(NAME, aa64_sme_or_sve2, gen_gvec_ool_zzzz, FUNC,         \
                a->rd, a->rn, a->rm, a->ra, (a->index << 1) | TOP)
 
 DO_SVE2_RRXR_TB(SQDMLALB_zzxw_s, gen_helper_sve2_sqdmlal_idx_s, false)
@@ -3865,7 +3865,7 @@ DO_SVE2_RRXR_TB(UMLSLT_zzxw_d, gen_helper_sve2_umlsl_idx_d, true)
 #undef DO_SVE2_RRXR_TB
 
 #define DO_SVE2_RRXR_ROT(NAME, FUNC) \
-    TRANS_FEAT(NAME, aa64_sve2, gen_gvec_ool_zzzz, FUNC,           \
+    TRANS_FEAT(NAME, aa64_sme_or_sve2, gen_gvec_ool_zzzz, FUNC,         \
                a->rd, a->rn, a->rm, a->ra, (a->index << 2) | a->rot)
 
 DO_SVE2_RRXR_ROT(CMLA_zzxz_h, gen_helper_sve2_cmla_idx_h)
@@ -3898,7 +3898,7 @@ static gen_helper_gvec_4_ptr * const fmla_idx_fns[4] = {
     gen_helper_gvec_bfmla_idx, gen_helper_gvec_fmla_idx_h,
     gen_helper_gvec_fmla_idx_s, gen_helper_gvec_fmla_idx_d
 };
-TRANS_FEAT(FMLA_zzxz, aa64_sve, do_fmla_zzxz, a, fmla_idx_fns[a->esz])
+TRANS_FEAT(FMLA_zzxz, aa64_sme_or_sve, do_fmla_zzxz, a, fmla_idx_fns[a->esz])
 
 static gen_helper_gvec_4_ptr * const fmls_idx_fns[4][2] = {
     { gen_helper_gvec_bfmls_idx, gen_helper_gvec_ah_bfmls_idx },
@@ -3906,7 +3906,7 @@ static gen_helper_gvec_4_ptr * const fmls_idx_fns[4][2] = {
     { gen_helper_gvec_fmls_idx_s, gen_helper_gvec_ah_fmls_idx_s },
     { gen_helper_gvec_fmls_idx_d, gen_helper_gvec_ah_fmls_idx_d },
 };
-TRANS_FEAT(FMLS_zzxz, aa64_sve, do_fmla_zzxz, a,
+TRANS_FEAT(FMLS_zzxz, aa64_sme_or_sve, do_fmla_zzxz, a,
            fmls_idx_fns[a->esz][s->fpcr_ah])
 
 /*
@@ -3917,7 +3917,7 @@ static gen_helper_gvec_3_ptr * const fmul_idx_fns[4] = {
     gen_helper_gvec_fmul_idx_b16, gen_helper_gvec_fmul_idx_h,
     gen_helper_gvec_fmul_idx_s, gen_helper_gvec_fmul_idx_d,
 };
-TRANS_FEAT(FMUL_zzx, aa64_sve, gen_gvec_fpst_zzz,
+TRANS_FEAT(FMUL_zzx, aa64_sme_or_sve, gen_gvec_fpst_zzz,
            fmul_idx_fns[a->esz], a->rd, a->rn, a->rm, a->index,
            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
@@ -3965,7 +3965,7 @@ static bool do_reduce(DisasContext *s, arg_rpr_esz *a,
         NULL,                      gen_helper_sve_##name##_h,            \
         gen_helper_sve_##name##_s, gen_helper_sve_##name##_d,            \
     };                                                                   \
-    TRANS_FEAT(NAME, aa64_sve, do_reduce, a, name##_fns[a->esz])
+    TRANS_FEAT(NAME, aa64_sme_or_sve, do_reduce, a, name##_fns[a->esz])
 
 #define DO_VPZ_AH(NAME, name)                                            \
     static gen_helper_fp_reduce * const name##_fns[4] = {                \
@@ -3976,7 +3976,7 @@ static bool do_reduce(DisasContext *s, arg_rpr_esz *a,
         NULL,                      gen_helper_sve_ah_##name##_h,         \
         gen_helper_sve_ah_##name##_s, gen_helper_sve_ah_##name##_d,      \
     };                                                                   \
-    TRANS_FEAT(NAME, aa64_sve, do_reduce, a,                             \
+    TRANS_FEAT(NAME, aa64_sme_or_sve, do_reduce, a,                             \
                s->fpcr_ah ? name##_ah_fns[a->esz] : name##_fns[a->esz])
 
 DO_VPZ(FADDV, faddv)
@@ -4047,7 +4047,7 @@ static gen_helper_gvec_2_ptr * const frecpe_rpres_fns[] = {
     NULL,                           gen_helper_gvec_frecpe_h,
     gen_helper_gvec_frecpe_rpres_s, gen_helper_gvec_frecpe_d,
 };
-TRANS_FEAT(FRECPE, aa64_sve, gen_gvec_fpst_ah_arg_zz,
+TRANS_FEAT(FRECPE, aa64_sme_or_sve, gen_gvec_fpst_ah_arg_zz,
            s->fpcr_ah && dc_isar_feature(aa64_rpres, s) ?
            frecpe_rpres_fns[a->esz] : frecpe_fns[a->esz], a, 0)
 
@@ -4059,7 +4059,7 @@ static gen_helper_gvec_2_ptr * const frsqrte_rpres_fns[] = {
     NULL,                            gen_helper_gvec_frsqrte_h,
     gen_helper_gvec_frsqrte_rpres_s, gen_helper_gvec_frsqrte_d,
 };
-TRANS_FEAT(FRSQRTE, aa64_sve, gen_gvec_fpst_ah_arg_zz,
+TRANS_FEAT(FRSQRTE, aa64_sme_or_sve, gen_gvec_fpst_ah_arg_zz,
            s->fpcr_ah && dc_isar_feature(aa64_rpres, s) ?
            frsqrte_rpres_fns[a->esz] : frsqrte_fns[a->esz], a, 0)
 
@@ -4091,7 +4091,7 @@ static bool do_ppz_fp(DisasContext *s, arg_rpr_esz *a,
         NULL,                      gen_helper_sve_##name##_h,     \
         gen_helper_sve_##name##_s, gen_helper_sve_##name##_d,     \
     };                                                            \
-    TRANS_FEAT(NAME, aa64_sve, do_ppz_fp, a, name##_fns[a->esz])
+    TRANS_FEAT(NAME, aa64_sme_or_sve, do_ppz_fp, a, name##_fns[a->esz])
 
 DO_PPZ(FCMGE_ppz0, fcmge0)
 DO_PPZ(FCMGT_ppz0, fcmgt0)
@@ -4164,7 +4164,7 @@ static bool trans_FADDA(DisasContext *s, arg_rprr_esz *a)
         gen_helper_gvec_##name##_b16, gen_helper_gvec_##name##_h,   \
         gen_helper_gvec_##name##_s, gen_helper_gvec_##name##_d      \
     };                                                              \
-    TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_arg_zzz, name##_fns[a->esz], a, 0)
+    TRANS_FEAT(NAME, aa64_sme_or_sve, gen_gvec_fpst_arg_zzz, name##_fns[a->esz], a, 0)
 
 #define DO_FP3_AH(NAME, name) \
     static gen_helper_gvec_3_ptr * const name##_fns[4] = {          \
@@ -4175,7 +4175,7 @@ static bool trans_FADDA(DisasContext *s, arg_rprr_esz *a)
         NULL, gen_helper_gvec_ah_##name##_h,                        \
         gen_helper_gvec_ah_##name##_s, gen_helper_gvec_ah_##name##_d    \
     };                                                              \
-    TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_ah_arg_zzz,            \
+    TRANS_FEAT(NAME, aa64_sme_or_sve, gen_gvec_fpst_ah_arg_zzz,     \
                s->fpcr_ah ? name##_ah_fns[a->esz] : name##_fns[a->esz], a, 0)
 
 DO_FP3(FADD_zzz, fadd)
@@ -4238,17 +4238,17 @@ TRANS_FEAT_NONSTREAMING(FTSMUL, aa64_sve, gen_gvec_fpst_arg_zzz,
                s->fpcr_ah ? name##_ah_zpzz_fns[a->esz] :                \
                name##_zpzz_fns[a->esz], a)
 
-DO_ZPZZ_FP_B16(FADD_zpzz, aa64_sve, sve_fadd)
-DO_ZPZZ_FP_B16(FSUB_zpzz, aa64_sve, sve_fsub)
-DO_ZPZZ_FP_B16(FMUL_zpzz, aa64_sve, sve_fmul)
-DO_ZPZZ_AH_FP_B16(FMIN_zpzz, aa64_sve, sve_fmin, sve_ah_fmin)
-DO_ZPZZ_AH_FP_B16(FMAX_zpzz, aa64_sve, sve_fmax, sve_ah_fmax)
-DO_ZPZZ_FP_B16(FMINNM_zpzz, aa64_sve, sve_fminnum)
-DO_ZPZZ_FP_B16(FMAXNM_zpzz, aa64_sve, sve_fmaxnum)
-DO_ZPZZ_AH_FP(FABD, aa64_sve, sve_fabd, sve_ah_fabd)
-DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
-DO_ZPZZ_FP(FDIV, aa64_sve, sve_fdiv)
-DO_ZPZZ_FP(FMULX, aa64_sve, sve_fmulx)
+DO_ZPZZ_FP_B16(FADD_zpzz, aa64_sme_or_sve, sve_fadd)
+DO_ZPZZ_FP_B16(FSUB_zpzz, aa64_sme_or_sve, sve_fsub)
+DO_ZPZZ_FP_B16(FMUL_zpzz, aa64_sme_or_sve, sve_fmul)
+DO_ZPZZ_AH_FP_B16(FMIN_zpzz, aa64_sme_or_sve, sve_fmin, sve_ah_fmin)
+DO_ZPZZ_AH_FP_B16(FMAX_zpzz, aa64_sme_or_sve, sve_fmax, sve_ah_fmax)
+DO_ZPZZ_FP_B16(FMINNM_zpzz, aa64_sme_or_sve, sve_fminnum)
+DO_ZPZZ_FP_B16(FMAXNM_zpzz, aa64_sme_or_sve, sve_fmaxnum)
+DO_ZPZZ_AH_FP(FABD, aa64_sme_or_sve, sve_fabd, sve_ah_fabd)
+DO_ZPZZ_FP(FSCALE, aa64_sme_or_sve, sve_fscalbn)
+DO_ZPZZ_FP(FDIV, aa64_sme_or_sve, sve_fdiv)
+DO_ZPZZ_FP(FMULX, aa64_sme_or_sve, sve_fmulx)
 
 typedef void gen_helper_sve_fp2scalar(TCGv_ptr, TCGv_ptr, TCGv_ptr,
                                       TCGv_i64, TCGv_ptr, TCGv_i32);
@@ -4297,7 +4297,7 @@ static bool do_fp_imm(DisasContext *s, arg_rpri_esz *a, uint64_t imm,
         { float32_##const0, float32_##const1 },                         \
         { float64_##const0, float64_##const1 },                         \
     };                                                                  \
-    TRANS_FEAT(NAME##_zpzi, aa64_sve, do_fp_imm, a,                     \
+    TRANS_FEAT(NAME##_zpzi, aa64_sme_or_sve, do_fp_imm, a,                     \
                name##_const[a->esz][a->imm], name##_fns[a->esz])
 
 #define DO_FP_AH_IMM(NAME, name, const0, const1)                        \
@@ -4317,7 +4317,7 @@ static bool do_fp_imm(DisasContext *s, arg_rpri_esz *a, uint64_t imm,
         { float32_##const0, float32_##const1 },                         \
         { float64_##const0, float64_##const1 },                         \
     };                                                                  \
-    TRANS_FEAT(NAME##_zpzi, aa64_sve, do_fp_imm, a,                     \
+    TRANS_FEAT(NAME##_zpzi, aa64_sme_or_sve, do_fp_imm, a,                     \
                name##_const[a->esz][a->imm],                            \
                s->fpcr_ah ? name##_ah_fns[a->esz] : name##_fns[a->esz])
 
@@ -4355,7 +4355,7 @@ static bool do_fp_cmp(DisasContext *s, arg_rprr_esz *a,
         NULL, gen_helper_sve_##name##_h,                              \
         gen_helper_sve_##name##_s, gen_helper_sve_##name##_d          \
     };                                                                \
-    TRANS_FEAT(NAME##_ppzz, aa64_sve, do_fp_cmp, a, name##_fns[a->esz])
+    TRANS_FEAT(NAME##_ppzz, aa64_sme_or_sve, do_fp_cmp, a, name##_fns[a->esz])
 
 DO_FPCMP(FCMGE, fcmge)
 DO_FPCMP(FCMGT, fcmgt)
@@ -4371,7 +4371,7 @@ static gen_helper_gvec_4_ptr * const fcadd_fns[] = {
     NULL,                   gen_helper_sve_fcadd_h,
     gen_helper_sve_fcadd_s, gen_helper_sve_fcadd_d,
 };
-TRANS_FEAT(FCADD, aa64_sve, gen_gvec_fpst_zzzp, fcadd_fns[a->esz],
+TRANS_FEAT(FCADD, aa64_sme_or_sve, gen_gvec_fpst_zzzp, fcadd_fns[a->esz],
            a->rd, a->rn, a->rm, a->pg, a->rot | (s->fpcr_ah << 1),
            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
@@ -4395,7 +4395,7 @@ static bool do_fmla_zpzzz(DisasContext *s, arg_rprrr_esz *a,
         gen_helper_sve_##ah_name##_b16, gen_helper_sve_##ah_name##_h,   \
         gen_helper_sve_##ah_name##_s, gen_helper_sve_##ah_name##_d      \
     };                                                                  \
-    TRANS_FEAT(NAME, aa64_sve, do_fmla_zpzzz, a,                        \
+    TRANS_FEAT(NAME, aa64_sme_or_sve, do_fmla_zpzzz, a,                        \
                s->fpcr_ah ? name##_ah_fns[a->esz] : name##_fns[a->esz])
 
 /* We don't need an ah_fmla_zpzzz because fmla doesn't negate anything */
@@ -4410,14 +4410,14 @@ static gen_helper_gvec_5_ptr * const fcmla_fns[4] = {
     NULL,                         gen_helper_sve_fcmla_zpzzz_h,
     gen_helper_sve_fcmla_zpzzz_s, gen_helper_sve_fcmla_zpzzz_d,
 };
-TRANS_FEAT(FCMLA_zpzzz, aa64_sve, gen_gvec_fpst_zzzzp, fcmla_fns[a->esz],
+TRANS_FEAT(FCMLA_zpzzz, aa64_sme_or_sve, gen_gvec_fpst_zzzzp, fcmla_fns[a->esz],
            a->rd, a->rn, a->rm, a->ra, a->pg, a->rot | (s->fpcr_ah << 2),
            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 static gen_helper_gvec_4_ptr * const fcmla_idx_fns[4] = {
     NULL, gen_helper_gvec_fcmlah_idx, gen_helper_gvec_fcmlas_idx, NULL
 };
-TRANS_FEAT(FCMLA_zzxz, aa64_sve, gen_gvec_fpst_zzzz, fcmla_idx_fns[a->esz],
+TRANS_FEAT(FCMLA_zzxz, aa64_sme_or_sve, gen_gvec_fpst_zzzz, fcmla_idx_fns[a->esz],
            a->rd, a->rn, a->rm, a->ra, a->index * 4 + a->rot,
            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
@@ -4425,53 +4425,53 @@ TRANS_FEAT(FCMLA_zzxz, aa64_sve, gen_gvec_fpst_zzzz, fcmla_idx_fns[a->esz],
  *** SVE Floating Point Unary Operations Predicated Group
  */
 
-TRANS_FEAT(FCVT_sh, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVT_sh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_sh, a, 0, FPST_A64)
-TRANS_FEAT(FCVT_hs, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVT_hs, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_hs, a, 0, FPST_A64_F16)
 
 TRANS_FEAT(BFCVT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_bfcvt, a, 0,
            s->fpcr_ah ? FPST_AH : FPST_A64)
 
-TRANS_FEAT(FCVT_dh, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVT_dh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_dh, a, 0, FPST_A64)
-TRANS_FEAT(FCVT_hd, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVT_hd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_hd, a, 0, FPST_A64_F16)
-TRANS_FEAT(FCVT_ds, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVT_ds, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_ds, a, 0, FPST_A64)
-TRANS_FEAT(FCVT_sd, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVT_sd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_sd, a, 0, FPST_A64)
 
-TRANS_FEAT(FCVTZS_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZS_hh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_hh, a, 0, FPST_A64_F16)
-TRANS_FEAT(FCVTZU_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZU_hh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_hh, a, 0, FPST_A64_F16)
-TRANS_FEAT(FCVTZS_hs, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZS_hs, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_hs, a, 0, FPST_A64_F16)
-TRANS_FEAT(FCVTZU_hs, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZU_hs, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_hs, a, 0, FPST_A64_F16)
-TRANS_FEAT(FCVTZS_hd, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZS_hd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_hd, a, 0, FPST_A64_F16)
-TRANS_FEAT(FCVTZU_hd, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZU_hd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_hd, a, 0, FPST_A64_F16)
 
-TRANS_FEAT(FCVTZS_ss, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZS_ss, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_ss, a, 0, FPST_A64)
-TRANS_FEAT(FCVTZU_ss, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZU_ss, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_ss, a, 0, FPST_A64)
-TRANS_FEAT(FCVTZS_sd, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZS_sd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_sd, a, 0, FPST_A64)
-TRANS_FEAT(FCVTZU_sd, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZU_sd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_sd, a, 0, FPST_A64)
-TRANS_FEAT(FCVTZS_ds, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZS_ds, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_ds, a, 0, FPST_A64)
-TRANS_FEAT(FCVTZU_ds, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZU_ds, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_ds, a, 0, FPST_A64)
 
-TRANS_FEAT(FCVTZS_dd, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZS_dd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_dd, a, 0, FPST_A64)
-TRANS_FEAT(FCVTZU_dd, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZU_dd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_dd, a, 0, FPST_A64)
 
 static gen_helper_gvec_3_ptr * const frint_fns[] = {
@@ -4480,7 +4480,7 @@ static gen_helper_gvec_3_ptr * const frint_fns[] = {
     gen_helper_sve_frint_s,
     gen_helper_sve_frint_d
 };
-TRANS_FEAT(FRINTI, aa64_sve, gen_gvec_fpst_arg_zpz, frint_fns[a->esz],
+TRANS_FEAT(FRINTI, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz, frint_fns[a->esz],
            a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 static gen_helper_gvec_3_ptr * const frintx_fns[] = {
@@ -4489,7 +4489,7 @@ static gen_helper_gvec_3_ptr * const frintx_fns[] = {
     gen_helper_sve_frintx_s,
     gen_helper_sve_frintx_d
 };
-TRANS_FEAT(FRINTX, aa64_sve, gen_gvec_fpst_arg_zpz, frintx_fns[a->esz],
+TRANS_FEAT(FRINTX, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz, frintx_fns[a->esz],
            a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 
 static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
@@ -4519,63 +4519,63 @@ static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
     return true;
 }
 
-TRANS_FEAT(FRINTN, aa64_sve, do_frint_mode, a,
+TRANS_FEAT(FRINTN, aa64_sme_or_sve, do_frint_mode, a,
            FPROUNDING_TIEEVEN, frint_fns[a->esz])
-TRANS_FEAT(FRINTP, aa64_sve, do_frint_mode, a,
+TRANS_FEAT(FRINTP, aa64_sme_or_sve, do_frint_mode, a,
            FPROUNDING_POSINF, frint_fns[a->esz])
-TRANS_FEAT(FRINTM, aa64_sve, do_frint_mode, a,
+TRANS_FEAT(FRINTM, aa64_sme_or_sve, do_frint_mode, a,
            FPROUNDING_NEGINF, frint_fns[a->esz])
-TRANS_FEAT(FRINTZ, aa64_sve, do_frint_mode, a,
+TRANS_FEAT(FRINTZ, aa64_sme_or_sve, do_frint_mode, a,
            FPROUNDING_ZERO, frint_fns[a->esz])
-TRANS_FEAT(FRINTA, aa64_sve, do_frint_mode, a,
+TRANS_FEAT(FRINTA, aa64_sme_or_sve, do_frint_mode, a,
            FPROUNDING_TIEAWAY, frint_fns[a->esz])
 
 static gen_helper_gvec_3_ptr * const frecpx_fns[] = {
     NULL,                    gen_helper_sve_frecpx_h,
     gen_helper_sve_frecpx_s, gen_helper_sve_frecpx_d,
 };
-TRANS_FEAT(FRECPX, aa64_sve, gen_gvec_fpst_arg_zpz, frecpx_fns[a->esz],
+TRANS_FEAT(FRECPX, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz, frecpx_fns[a->esz],
            a, 0, select_ah_fpst(s, a->esz))
 
 static gen_helper_gvec_3_ptr * const fsqrt_fns[] = {
     NULL,                   gen_helper_sve_fsqrt_h,
     gen_helper_sve_fsqrt_s, gen_helper_sve_fsqrt_d,
 };
-TRANS_FEAT(FSQRT, aa64_sve, gen_gvec_fpst_arg_zpz, fsqrt_fns[a->esz],
+TRANS_FEAT(FSQRT, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz, fsqrt_fns[a->esz],
            a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
-TRANS_FEAT(SCVTF_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(SCVTF_hh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_hh, a, 0, FPST_A64_F16)
-TRANS_FEAT(SCVTF_sh, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(SCVTF_sh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_sh, a, 0, FPST_A64_F16)
-TRANS_FEAT(SCVTF_dh, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(SCVTF_dh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_dh, a, 0, FPST_A64_F16)
 
-TRANS_FEAT(SCVTF_ss, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(SCVTF_ss, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_ss, a, 0, FPST_A64)
-TRANS_FEAT(SCVTF_ds, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(SCVTF_ds, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_ds, a, 0, FPST_A64)
 
-TRANS_FEAT(SCVTF_sd, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(SCVTF_sd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_sd, a, 0, FPST_A64)
-TRANS_FEAT(SCVTF_dd, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(SCVTF_dd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_dd, a, 0, FPST_A64)
 
-TRANS_FEAT(UCVTF_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(UCVTF_hh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_hh, a, 0, FPST_A64_F16)
-TRANS_FEAT(UCVTF_sh, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(UCVTF_sh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_sh, a, 0, FPST_A64_F16)
-TRANS_FEAT(UCVTF_dh, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(UCVTF_dh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_dh, a, 0, FPST_A64_F16)
 
-TRANS_FEAT(UCVTF_ss, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(UCVTF_ss, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_ss, a, 0, FPST_A64)
-TRANS_FEAT(UCVTF_ds, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(UCVTF_ds, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_ds, a, 0, FPST_A64)
-TRANS_FEAT(UCVTF_sd, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(UCVTF_sd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_sd, a, 0, FPST_A64)
 
-TRANS_FEAT(UCVTF_dd, aa64_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(UCVTF_dd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_dd, a, 0, FPST_A64)
 
 /*
@@ -4803,7 +4803,7 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
 
 static bool trans_LDR_zri(DisasContext *s, arg_rri *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -4817,7 +4817,7 @@ static bool trans_LDR_zri(DisasContext *s, arg_rri *a)
 
 static bool trans_LDR_pri(DisasContext *s, arg_rri *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -4831,7 +4831,7 @@ static bool trans_LDR_pri(DisasContext *s, arg_rri *a)
 
 static bool trans_STR_zri(DisasContext *s, arg_rri *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -4845,7 +4845,7 @@ static bool trans_STR_zri(DisasContext *s, arg_rri *a)
 
 static bool trans_STR_pri(DisasContext *s, arg_rri *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -5101,7 +5101,7 @@ static bool trans_LD_zprr(DisasContext *s, arg_rprr_load *a)
     /* dtypes 16-18 are artificial, representing 128-bit element */
     switch (a->dtype) {
     case 0 ... 15:
-        if (!dc_isar_feature(aa64_sve, s)) {
+        if (!dc_isar_feature(aa64_sme_or_sve, s)) {
             return false;
         }
         break;
@@ -5134,7 +5134,7 @@ static bool trans_LD_zpri(DisasContext *s, arg_rpri_load *a)
     /* dtypes 16-18 are artificial, representing 128-bit element */
     switch (a->dtype) {
     case 0 ... 15:
-        if (!dc_isar_feature(aa64_sve, s)) {
+        if (!dc_isar_feature(aa64_sme_or_sve, s)) {
             return false;
         }
         break;
@@ -5420,7 +5420,7 @@ static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int dtype)
 
 static bool trans_LD1RQ_zprr(DisasContext *s, arg_rprr_load *a)
 {
-    if (a->rm == 31 || !dc_isar_feature(aa64_sve, s)) {
+    if (a->rm == 31 || !dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -5435,7 +5435,7 @@ static bool trans_LD1RQ_zprr(DisasContext *s, arg_rprr_load *a)
 
 static bool trans_LD1RQ_zpri(DisasContext *s, arg_rpri_load *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (sve_access_check(s)) {
@@ -5554,7 +5554,7 @@ static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a)
     TCGv_i64 temp, clean_addr;
     MemOp memop;
 
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     if (!sve_access_check(s)) {
@@ -5746,7 +5746,7 @@ static bool trans_ST_zprr(DisasContext *s, arg_rprr_store *a)
     }
     switch (a->esz) {
     case MO_8 ... MO_64:
-        if (!dc_isar_feature(aa64_sve, s)) {
+        if (!dc_isar_feature(aa64_sme_or_sve, s)) {
             return false;
         }
         break;
@@ -5783,7 +5783,7 @@ static bool trans_ST_zpri(DisasContext *s, arg_rpri_store *a)
     }
     switch (a->esz) {
     case MO_8 ... MO_64:
-        if (!dc_isar_feature(aa64_sve, s)) {
+        if (!dc_isar_feature(aa64_sme_or_sve, s)) {
             return false;
         }
         break;
@@ -6525,7 +6525,7 @@ static bool trans_STNT1_zprz(DisasContext *s, arg_ST1_zprz *a)
 
 static bool trans_PRF(DisasContext *s, arg_PRF *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     /* Prefetch is a nop within QEMU.  */
@@ -6535,7 +6535,7 @@ static bool trans_PRF(DisasContext *s, arg_PRF *a)
 
 static bool trans_PRF_rr(DisasContext *s, arg_PRF_rr *a)
 {
-    if (a->rm == 31 || !dc_isar_feature(aa64_sve, s)) {
+    if (a->rm == 31 || !dc_isar_feature(aa64_sme_or_sve, s)) {
         return false;
     }
     /* Prefetch is a nop within QEMU.  */
@@ -6568,39 +6568,39 @@ static bool trans_PRF_ns(DisasContext *s, arg_PRF_ns *a)
  * In the meantime, just emit the moves.
  */
 
-TRANS_FEAT(MOVPRFX, aa64_sve, do_mov_z, a->rd, a->rn)
-TRANS_FEAT(MOVPRFX_m, aa64_sve, do_sel_z, a->rd, a->rn, a->rd, a->pg, a->esz)
-TRANS_FEAT(MOVPRFX_z, aa64_sve, do_movz_zpz, a->rd, a->rn, a->pg, a->esz, false)
+TRANS_FEAT(MOVPRFX, aa64_sme_or_sve, do_mov_z, a->rd, a->rn)
+TRANS_FEAT(MOVPRFX_m, aa64_sme_or_sve, do_sel_z, a->rd, a->rn, a->rd, a->pg, a->esz)
+TRANS_FEAT(MOVPRFX_z, aa64_sme_or_sve, do_movz_zpz, a->rd, a->rn, a->pg, a->esz, false)
 
 /*
  * SVE2 Integer Multiply - Unpredicated
  */
 
-TRANS_FEAT(MUL_zzz, aa64_sve2, gen_gvec_fn_arg_zzz, tcg_gen_gvec_mul, a)
-TRANS_FEAT(SQDMULH_zzz, aa64_sve2, gen_gvec_fn_arg_zzz, gen_gvec_sve2_sqdmulh, a)
+TRANS_FEAT(MUL_zzz, aa64_sme_or_sve2, gen_gvec_fn_arg_zzz, tcg_gen_gvec_mul, a)
+TRANS_FEAT(SQDMULH_zzz, aa64_sme_or_sve2, gen_gvec_fn_arg_zzz, gen_gvec_sve2_sqdmulh, a)
 
 static gen_helper_gvec_3 * const smulh_zzz_fns[4] = {
     gen_helper_gvec_smulh_b, gen_helper_gvec_smulh_h,
     gen_helper_gvec_smulh_s, gen_helper_gvec_smulh_d,
 };
-TRANS_FEAT(SMULH_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(SMULH_zzz, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            smulh_zzz_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const umulh_zzz_fns[4] = {
     gen_helper_gvec_umulh_b, gen_helper_gvec_umulh_h,
     gen_helper_gvec_umulh_s, gen_helper_gvec_umulh_d,
 };
-TRANS_FEAT(UMULH_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(UMULH_zzz, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            umulh_zzz_fns[a->esz], a, 0)
 
-TRANS_FEAT(PMUL_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(PMUL_zzz, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            gen_helper_gvec_pmul_b, a, 0)
 
 static gen_helper_gvec_3 * const sqrdmulh_zzz_fns[4] = {
     gen_helper_sve2_sqrdmulh_b, gen_helper_sve2_sqrdmulh_h,
     gen_helper_sve2_sqrdmulh_s, gen_helper_sve2_sqrdmulh_d,
 };
-TRANS_FEAT(SQRDMULH_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(SQRDMULH_zzz, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            sqrdmulh_zzz_fns[a->esz], a, 0)
 
 /*
@@ -6611,66 +6611,66 @@ static gen_helper_gvec_4 * const sadlp_fns[4] = {
     NULL,                          gen_helper_sve2_sadalp_zpzz_h,
     gen_helper_sve2_sadalp_zpzz_s, gen_helper_sve2_sadalp_zpzz_d,
 };
-TRANS_FEAT(SADALP_zpzz, aa64_sve2, gen_gvec_ool_arg_zpzz,
+TRANS_FEAT(SADALP_zpzz, aa64_sme_or_sve2, gen_gvec_ool_arg_zpzz,
            sadlp_fns[a->esz], a, 0)
 
 static gen_helper_gvec_4 * const uadlp_fns[4] = {
     NULL,                          gen_helper_sve2_uadalp_zpzz_h,
     gen_helper_sve2_uadalp_zpzz_s, gen_helper_sve2_uadalp_zpzz_d,
 };
-TRANS_FEAT(UADALP_zpzz, aa64_sve2, gen_gvec_ool_arg_zpzz,
+TRANS_FEAT(UADALP_zpzz, aa64_sme_or_sve2, gen_gvec_ool_arg_zpzz,
            uadlp_fns[a->esz], a, 0)
 
 /*
  * SVE2 integer unary operations (predicated)
  */
 
-TRANS_FEAT(URECPE, aa64_sve2, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(URECPE, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz,
            a->esz == 2 ? gen_helper_sve2_urecpe_s : NULL, a, 0)
 
-TRANS_FEAT(URSQRTE, aa64_sve2, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(URSQRTE, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz,
            a->esz == 2 ? gen_helper_sve2_ursqrte_s : NULL, a, 0)
 
 static gen_helper_gvec_3 * const sqabs_fns[4] = {
     gen_helper_sve2_sqabs_b, gen_helper_sve2_sqabs_h,
     gen_helper_sve2_sqabs_s, gen_helper_sve2_sqabs_d,
 };
-TRANS_FEAT(SQABS, aa64_sve2, gen_gvec_ool_arg_zpz, sqabs_fns[a->esz], a, 0)
+TRANS_FEAT(SQABS, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz, sqabs_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const sqneg_fns[4] = {
     gen_helper_sve2_sqneg_b, gen_helper_sve2_sqneg_h,
     gen_helper_sve2_sqneg_s, gen_helper_sve2_sqneg_d,
 };
-TRANS_FEAT(SQNEG, aa64_sve2, gen_gvec_ool_arg_zpz, sqneg_fns[a->esz], a, 0)
+TRANS_FEAT(SQNEG, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz, sqneg_fns[a->esz], a, 0)
 
-DO_ZPZZ(SQSHL, aa64_sve2, sve2_sqshl)
-DO_ZPZZ(SQRSHL, aa64_sve2, sve2_sqrshl)
-DO_ZPZZ(SRSHL, aa64_sve2, sve2_srshl)
+DO_ZPZZ(SQSHL, aa64_sme_or_sve2, sve2_sqshl)
+DO_ZPZZ(SQRSHL, aa64_sme_or_sve2, sve2_sqrshl)
+DO_ZPZZ(SRSHL, aa64_sme_or_sve2, sve2_srshl)
 
-DO_ZPZZ(UQSHL, aa64_sve2, sve2_uqshl)
-DO_ZPZZ(UQRSHL, aa64_sve2, sve2_uqrshl)
-DO_ZPZZ(URSHL, aa64_sve2, sve2_urshl)
+DO_ZPZZ(UQSHL, aa64_sme_or_sve2, sve2_uqshl)
+DO_ZPZZ(UQRSHL, aa64_sme_or_sve2, sve2_uqrshl)
+DO_ZPZZ(URSHL, aa64_sme_or_sve2, sve2_urshl)
 
-DO_ZPZZ(SHADD, aa64_sve2, sve2_shadd)
-DO_ZPZZ(SRHADD, aa64_sve2, sve2_srhadd)
-DO_ZPZZ(SHSUB, aa64_sve2, sve2_shsub)
+DO_ZPZZ(SHADD, aa64_sme_or_sve2, sve2_shadd)
+DO_ZPZZ(SRHADD, aa64_sme_or_sve2, sve2_srhadd)
+DO_ZPZZ(SHSUB, aa64_sme_or_sve2, sve2_shsub)
 
-DO_ZPZZ(UHADD, aa64_sve2, sve2_uhadd)
-DO_ZPZZ(URHADD, aa64_sve2, sve2_urhadd)
-DO_ZPZZ(UHSUB, aa64_sve2, sve2_uhsub)
+DO_ZPZZ(UHADD, aa64_sme_or_sve2, sve2_uhadd)
+DO_ZPZZ(URHADD, aa64_sme_or_sve2, sve2_urhadd)
+DO_ZPZZ(UHSUB, aa64_sme_or_sve2, sve2_uhsub)
 
-DO_ZPZZ(ADDP, aa64_sve2, sve2_addp)
-DO_ZPZZ(SMAXP, aa64_sve2, sve2_smaxp)
-DO_ZPZZ(UMAXP, aa64_sve2, sve2_umaxp)
-DO_ZPZZ(SMINP, aa64_sve2, sve2_sminp)
-DO_ZPZZ(UMINP, aa64_sve2, sve2_uminp)
+DO_ZPZZ(ADDP, aa64_sme_or_sve2, sve2_addp)
+DO_ZPZZ(SMAXP, aa64_sme_or_sve2, sve2_smaxp)
+DO_ZPZZ(UMAXP, aa64_sme_or_sve2, sve2_umaxp)
+DO_ZPZZ(SMINP, aa64_sme_or_sve2, sve2_sminp)
+DO_ZPZZ(UMINP, aa64_sme_or_sve2, sve2_uminp)
 
-DO_ZPZZ(SQADD_zpzz, aa64_sve2, sve2_sqadd)
-DO_ZPZZ(UQADD_zpzz, aa64_sve2, sve2_uqadd)
-DO_ZPZZ(SQSUB_zpzz, aa64_sve2, sve2_sqsub)
-DO_ZPZZ(UQSUB_zpzz, aa64_sve2, sve2_uqsub)
-DO_ZPZZ(SUQADD, aa64_sve2, sve2_suqadd)
-DO_ZPZZ(USQADD, aa64_sve2, sve2_usqadd)
+DO_ZPZZ(SQADD_zpzz, aa64_sme_or_sve2, sve2_sqadd)
+DO_ZPZZ(UQADD_zpzz, aa64_sme_or_sve2, sve2_uqadd)
+DO_ZPZZ(SQSUB_zpzz, aa64_sme_or_sve2, sve2_sqsub)
+DO_ZPZZ(UQSUB_zpzz, aa64_sme_or_sve2, sve2_uqsub)
+DO_ZPZZ(SUQADD, aa64_sme_or_sve2, sve2_suqadd)
+DO_ZPZZ(USQADD, aa64_sme_or_sve2, sve2_usqadd)
 
 /*
  * SVE2 Widening Integer Arithmetic
@@ -6680,95 +6680,95 @@ static gen_helper_gvec_3 * const saddl_fns[4] = {
     NULL,                    gen_helper_sve2_saddl_h,
     gen_helper_sve2_saddl_s, gen_helper_sve2_saddl_d,
 };
-TRANS_FEAT(SADDLB, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(SADDLB, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            saddl_fns[a->esz], a, 0)
-TRANS_FEAT(SADDLT, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(SADDLT, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            saddl_fns[a->esz], a, 3)
-TRANS_FEAT(SADDLBT, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(SADDLBT, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            saddl_fns[a->esz], a, 2)
 
 static gen_helper_gvec_3 * const ssubl_fns[4] = {
     NULL,                    gen_helper_sve2_ssubl_h,
     gen_helper_sve2_ssubl_s, gen_helper_sve2_ssubl_d,
 };
-TRANS_FEAT(SSUBLB, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(SSUBLB, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            ssubl_fns[a->esz], a, 0)
-TRANS_FEAT(SSUBLT, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(SSUBLT, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            ssubl_fns[a->esz], a, 3)
-TRANS_FEAT(SSUBLBT, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(SSUBLBT, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            ssubl_fns[a->esz], a, 2)
-TRANS_FEAT(SSUBLTB, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(SSUBLTB, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            ssubl_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const sabdl_fns[4] = {
     NULL,                    gen_helper_sve2_sabdl_h,
     gen_helper_sve2_sabdl_s, gen_helper_sve2_sabdl_d,
 };
-TRANS_FEAT(SABDLB, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(SABDLB, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            sabdl_fns[a->esz], a, 0)
-TRANS_FEAT(SABDLT, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(SABDLT, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            sabdl_fns[a->esz], a, 3)
 
 static gen_helper_gvec_3 * const uaddl_fns[4] = {
     NULL,                    gen_helper_sve2_uaddl_h,
     gen_helper_sve2_uaddl_s, gen_helper_sve2_uaddl_d,
 };
-TRANS_FEAT(UADDLB, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(UADDLB, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            uaddl_fns[a->esz], a, 0)
-TRANS_FEAT(UADDLT, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(UADDLT, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            uaddl_fns[a->esz], a, 3)
 
 static gen_helper_gvec_3 * const usubl_fns[4] = {
     NULL,                    gen_helper_sve2_usubl_h,
     gen_helper_sve2_usubl_s, gen_helper_sve2_usubl_d,
 };
-TRANS_FEAT(USUBLB, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(USUBLB, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            usubl_fns[a->esz], a, 0)
-TRANS_FEAT(USUBLT, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(USUBLT, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            usubl_fns[a->esz], a, 3)
 
 static gen_helper_gvec_3 * const uabdl_fns[4] = {
     NULL,                    gen_helper_sve2_uabdl_h,
     gen_helper_sve2_uabdl_s, gen_helper_sve2_uabdl_d,
 };
-TRANS_FEAT(UABDLB, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(UABDLB, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            uabdl_fns[a->esz], a, 0)
-TRANS_FEAT(UABDLT, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(UABDLT, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            uabdl_fns[a->esz], a, 3)
 
 static gen_helper_gvec_3 * const sqdmull_fns[4] = {
     NULL,                          gen_helper_sve2_sqdmull_zzz_h,
     gen_helper_sve2_sqdmull_zzz_s, gen_helper_sve2_sqdmull_zzz_d,
 };
-TRANS_FEAT(SQDMULLB_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(SQDMULLB_zzz, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            sqdmull_fns[a->esz], a, 0)
-TRANS_FEAT(SQDMULLT_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(SQDMULLT_zzz, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            sqdmull_fns[a->esz], a, 3)
 
 static gen_helper_gvec_3 * const smull_fns[4] = {
     NULL,                        gen_helper_sve2_smull_zzz_h,
     gen_helper_sve2_smull_zzz_s, gen_helper_sve2_smull_zzz_d,
 };
-TRANS_FEAT(SMULLB_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(SMULLB_zzz, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            smull_fns[a->esz], a, 0)
-TRANS_FEAT(SMULLT_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(SMULLT_zzz, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            smull_fns[a->esz], a, 3)
 
 static gen_helper_gvec_3 * const umull_fns[4] = {
     NULL,                        gen_helper_sve2_umull_zzz_h,
     gen_helper_sve2_umull_zzz_s, gen_helper_sve2_umull_zzz_d,
 };
-TRANS_FEAT(UMULLB_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(UMULLB_zzz, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            umull_fns[a->esz], a, 0)
-TRANS_FEAT(UMULLT_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(UMULLT_zzz, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            umull_fns[a->esz], a, 3)
 
 static gen_helper_gvec_3 * const eoril_fns[4] = {
     gen_helper_sve2_eoril_b, gen_helper_sve2_eoril_h,
     gen_helper_sve2_eoril_s, gen_helper_sve2_eoril_d,
 };
-TRANS_FEAT(EORBT, aa64_sve2, gen_gvec_ool_arg_zzz, eoril_fns[a->esz], a, 2)
-TRANS_FEAT(EORTB, aa64_sve2, gen_gvec_ool_arg_zzz, eoril_fns[a->esz], a, 1)
+TRANS_FEAT(EORBT, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz, eoril_fns[a->esz], a, 2)
+TRANS_FEAT(EORTB, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz, eoril_fns[a->esz], a, 1)
 
 static bool do_trans_pmull(DisasContext *s, arg_rrr_esz *a, bool sel)
 {
@@ -6786,36 +6786,36 @@ static bool do_trans_pmull(DisasContext *s, arg_rrr_esz *a, bool sel)
     return gen_gvec_ool_arg_zzz(s, fns[a->esz], a, sel);
 }
 
-TRANS_FEAT(PMULLB, aa64_sve2, do_trans_pmull, a, false)
-TRANS_FEAT(PMULLT, aa64_sve2, do_trans_pmull, a, true)
+TRANS_FEAT(PMULLB, aa64_sme_or_sve2, do_trans_pmull, a, false)
+TRANS_FEAT(PMULLT, aa64_sme_or_sve2, do_trans_pmull, a, true)
 
 static gen_helper_gvec_3 * const saddw_fns[4] = {
     NULL,                    gen_helper_sve2_saddw_h,
     gen_helper_sve2_saddw_s, gen_helper_sve2_saddw_d,
 };
-TRANS_FEAT(SADDWB, aa64_sve2, gen_gvec_ool_arg_zzz, saddw_fns[a->esz], a, 0)
-TRANS_FEAT(SADDWT, aa64_sve2, gen_gvec_ool_arg_zzz, saddw_fns[a->esz], a, 1)
+TRANS_FEAT(SADDWB, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz, saddw_fns[a->esz], a, 0)
+TRANS_FEAT(SADDWT, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz, saddw_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const ssubw_fns[4] = {
     NULL,                    gen_helper_sve2_ssubw_h,
     gen_helper_sve2_ssubw_s, gen_helper_sve2_ssubw_d,
 };
-TRANS_FEAT(SSUBWB, aa64_sve2, gen_gvec_ool_arg_zzz, ssubw_fns[a->esz], a, 0)
-TRANS_FEAT(SSUBWT, aa64_sve2, gen_gvec_ool_arg_zzz, ssubw_fns[a->esz], a, 1)
+TRANS_FEAT(SSUBWB, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz, ssubw_fns[a->esz], a, 0)
+TRANS_FEAT(SSUBWT, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz, ssubw_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const uaddw_fns[4] = {
     NULL,                    gen_helper_sve2_uaddw_h,
     gen_helper_sve2_uaddw_s, gen_helper_sve2_uaddw_d,
 };
-TRANS_FEAT(UADDWB, aa64_sve2, gen_gvec_ool_arg_zzz, uaddw_fns[a->esz], a, 0)
-TRANS_FEAT(UADDWT, aa64_sve2, gen_gvec_ool_arg_zzz, uaddw_fns[a->esz], a, 1)
+TRANS_FEAT(UADDWB, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz, uaddw_fns[a->esz], a, 0)
+TRANS_FEAT(UADDWT, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz, uaddw_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const usubw_fns[4] = {
     NULL,                    gen_helper_sve2_usubw_h,
     gen_helper_sve2_usubw_s, gen_helper_sve2_usubw_d,
 };
-TRANS_FEAT(USUBWB, aa64_sve2, gen_gvec_ool_arg_zzz, usubw_fns[a->esz], a, 0)
-TRANS_FEAT(USUBWT, aa64_sve2, gen_gvec_ool_arg_zzz, usubw_fns[a->esz], a, 1)
+TRANS_FEAT(USUBWB, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz, usubw_fns[a->esz], a, 0)
+TRANS_FEAT(USUBWT, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz, usubw_fns[a->esz], a, 1)
 
 static void gen_sshll_vec(unsigned vece, TCGv_vec d, TCGv_vec n, int64_t imm)
 {
@@ -6935,8 +6935,8 @@ static const GVecGen2i sshll_ops[3] = {
       .fno = gen_helper_sve2_sshll_d,
       .vece = MO_64 }
 };
-TRANS_FEAT(SSHLLB, aa64_sve2, do_shll_tb, a, sshll_ops, false)
-TRANS_FEAT(SSHLLT, aa64_sve2, do_shll_tb, a, sshll_ops, true)
+TRANS_FEAT(SSHLLB, aa64_sme_or_sve2, do_shll_tb, a, sshll_ops, false)
+TRANS_FEAT(SSHLLT, aa64_sme_or_sve2, do_shll_tb, a, sshll_ops, true)
 
 static const TCGOpcode ushll_list[] = {
     INDEX_op_shli_vec, INDEX_op_shri_vec, 0
@@ -6958,8 +6958,8 @@ static const GVecGen2i ushll_ops[3] = {
       .fno = gen_helper_sve2_ushll_d,
       .vece = MO_64 },
 };
-TRANS_FEAT(USHLLB, aa64_sve2, do_shll_tb, a, ushll_ops, false)
-TRANS_FEAT(USHLLT, aa64_sve2, do_shll_tb, a, ushll_ops, true)
+TRANS_FEAT(USHLLB, aa64_sme_or_sve2, do_shll_tb, a, ushll_ops, false)
+TRANS_FEAT(USHLLT, aa64_sme_or_sve2, do_shll_tb, a, ushll_ops, true)
 
 static gen_helper_gvec_3 * const bext_fns[4] = {
     gen_helper_sve2_bext_b, gen_helper_sve2_bext_h,
@@ -6986,33 +6986,33 @@ static gen_helper_gvec_3 * const cadd_fns[4] = {
     gen_helper_sve2_cadd_b, gen_helper_sve2_cadd_h,
     gen_helper_sve2_cadd_s, gen_helper_sve2_cadd_d,
 };
-TRANS_FEAT(CADD_rot90, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(CADD_rot90, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            cadd_fns[a->esz], a, 0)
-TRANS_FEAT(CADD_rot270, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(CADD_rot270, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            cadd_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const sqcadd_fns[4] = {
     gen_helper_sve2_sqcadd_b, gen_helper_sve2_sqcadd_h,
     gen_helper_sve2_sqcadd_s, gen_helper_sve2_sqcadd_d,
 };
-TRANS_FEAT(SQCADD_rot90, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(SQCADD_rot90, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            sqcadd_fns[a->esz], a, 0)
-TRANS_FEAT(SQCADD_rot270, aa64_sve2, gen_gvec_ool_arg_zzz,
+TRANS_FEAT(SQCADD_rot270, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,
            sqcadd_fns[a->esz], a, 1)
 
 static gen_helper_gvec_4 * const sabal_fns[4] = {
     NULL,                    gen_helper_sve2_sabal_h,
     gen_helper_sve2_sabal_s, gen_helper_sve2_sabal_d,
 };
-TRANS_FEAT(SABALB, aa64_sve2, gen_gvec_ool_arg_zzzz, sabal_fns[a->esz], a, 0)
-TRANS_FEAT(SABALT, aa64_sve2, gen_gvec_ool_arg_zzzz, sabal_fns[a->esz], a, 1)
+TRANS_FEAT(SABALB, aa64_sme_or_sve2, gen_gvec_ool_arg_zzzz, sabal_fns[a->esz], a, 0)
+TRANS_FEAT(SABALT, aa64_sme_or_sve2, gen_gvec_ool_arg_zzzz, sabal_fns[a->esz], a, 1)
 
 static gen_helper_gvec_4 * const uabal_fns[4] = {
     NULL,                    gen_helper_sve2_uabal_h,
     gen_helper_sve2_uabal_s, gen_helper_sve2_uabal_d,
 };
-TRANS_FEAT(UABALB, aa64_sve2, gen_gvec_ool_arg_zzzz, uabal_fns[a->esz], a, 0)
-TRANS_FEAT(UABALT, aa64_sve2, gen_gvec_ool_arg_zzzz, uabal_fns[a->esz], a, 1)
+TRANS_FEAT(UABALB, aa64_sme_or_sve2, gen_gvec_ool_arg_zzzz, uabal_fns[a->esz], a, 0)
+TRANS_FEAT(UABALT, aa64_sme_or_sve2, gen_gvec_ool_arg_zzzz, uabal_fns[a->esz], a, 1)
 
 static bool do_adcl(DisasContext *s, arg_rrrr_esz *a, bool sel)
 {
@@ -7027,18 +7027,18 @@ static bool do_adcl(DisasContext *s, arg_rrrr_esz *a, bool sel)
     return gen_gvec_ool_arg_zzzz(s, fns[a->esz & 1], a, (a->esz & 2) | sel);
 }
 
-TRANS_FEAT(ADCLB, aa64_sve2, do_adcl, a, false)
-TRANS_FEAT(ADCLT, aa64_sve2, do_adcl, a, true)
+TRANS_FEAT(ADCLB, aa64_sme_or_sve2, do_adcl, a, false)
+TRANS_FEAT(ADCLT, aa64_sme_or_sve2, do_adcl, a, true)
 
-TRANS_FEAT(SSRA, aa64_sve2, gen_gvec_fn_arg_zzi, gen_gvec_ssra, a)
-TRANS_FEAT(USRA, aa64_sve2, gen_gvec_fn_arg_zzi, gen_gvec_usra, a)
-TRANS_FEAT(SRSRA, aa64_sve2, gen_gvec_fn_arg_zzi, gen_gvec_srsra, a)
-TRANS_FEAT(URSRA, aa64_sve2, gen_gvec_fn_arg_zzi, gen_gvec_ursra, a)
-TRANS_FEAT(SRI, aa64_sve2, gen_gvec_fn_arg_zzi, gen_gvec_sri, a)
-TRANS_FEAT(SLI, aa64_sve2, gen_gvec_fn_arg_zzi, gen_gvec_sli, a)
+TRANS_FEAT(SSRA, aa64_sme_or_sve2, gen_gvec_fn_arg_zzi, gen_gvec_ssra, a)
+TRANS_FEAT(USRA, aa64_sme_or_sve2, gen_gvec_fn_arg_zzi, gen_gvec_usra, a)
+TRANS_FEAT(SRSRA, aa64_sme_or_sve2, gen_gvec_fn_arg_zzi, gen_gvec_srsra, a)
+TRANS_FEAT(URSRA, aa64_sme_or_sve2, gen_gvec_fn_arg_zzi, gen_gvec_ursra, a)
+TRANS_FEAT(SRI, aa64_sme_or_sve2, gen_gvec_fn_arg_zzi, gen_gvec_sri, a)
+TRANS_FEAT(SLI, aa64_sme_or_sve2, gen_gvec_fn_arg_zzi, gen_gvec_sli, a)
 
-TRANS_FEAT(SABA, aa64_sve2, gen_gvec_fn_arg_zzz, gen_gvec_saba, a)
-TRANS_FEAT(UABA, aa64_sve2, gen_gvec_fn_arg_zzz, gen_gvec_uaba, a)
+TRANS_FEAT(SABA, aa64_sme_or_sve2, gen_gvec_fn_arg_zzz, gen_gvec_saba, a)
+TRANS_FEAT(UABA, aa64_sme_or_sve2, gen_gvec_fn_arg_zzz, gen_gvec_uaba, a)
 
 static bool do_narrow_extract(DisasContext *s, arg_rri_esz *a,
                               const GVecGen2 ops[3])
@@ -7085,7 +7085,7 @@ static const GVecGen2 sqxtnb_ops[3] = {
       .fno = gen_helper_sve2_sqxtnb_d,
       .vece = MO_64 },
 };
-TRANS_FEAT(SQXTNB, aa64_sve2, do_narrow_extract, a, sqxtnb_ops)
+TRANS_FEAT(SQXTNB, aa64_sme_or_sve2, do_narrow_extract, a, sqxtnb_ops)
 
 static void gen_sqxtnt_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
 {
@@ -7117,7 +7117,7 @@ static const GVecGen2 sqxtnt_ops[3] = {
       .fno = gen_helper_sve2_sqxtnt_d,
       .vece = MO_64 },
 };
-TRANS_FEAT(SQXTNT, aa64_sve2, do_narrow_extract, a, sqxtnt_ops)
+TRANS_FEAT(SQXTNT, aa64_sme_or_sve2, do_narrow_extract, a, sqxtnt_ops)
 
 static const TCGOpcode uqxtn_list[] = {
     INDEX_op_shli_vec, INDEX_op_umin_vec, 0
@@ -7145,7 +7145,7 @@ static const GVecGen2 uqxtnb_ops[3] = {
       .fno = gen_helper_sve2_uqxtnb_d,
       .vece = MO_64 },
 };
-TRANS_FEAT(UQXTNB, aa64_sve2, do_narrow_extract, a, uqxtnb_ops)
+TRANS_FEAT(UQXTNB, aa64_sme_or_sve2, do_narrow_extract, a, uqxtnb_ops)
 
 static void gen_uqxtnt_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
 {
@@ -7175,7 +7175,7 @@ static const GVecGen2 uqxtnt_ops[3] = {
       .fno = gen_helper_sve2_uqxtnt_d,
       .vece = MO_64 },
 };
-TRANS_FEAT(UQXTNT, aa64_sve2, do_narrow_extract, a, uqxtnt_ops)
+TRANS_FEAT(UQXTNT, aa64_sme_or_sve2, do_narrow_extract, a, uqxtnt_ops)
 
 static const TCGOpcode sqxtun_list[] = {
     INDEX_op_shli_vec, INDEX_op_umin_vec, INDEX_op_smax_vec, 0
@@ -7204,7 +7204,7 @@ static const GVecGen2 sqxtunb_ops[3] = {
       .fno = gen_helper_sve2_sqxtunb_d,
       .vece = MO_64 },
 };
-TRANS_FEAT(SQXTUNB, aa64_sve2, do_narrow_extract, a, sqxtunb_ops)
+TRANS_FEAT(SQXTUNB, aa64_sme_or_sve2, do_narrow_extract, a, sqxtunb_ops)
 
 static void gen_sqxtunt_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
 {
@@ -7235,7 +7235,7 @@ static const GVecGen2 sqxtunt_ops[3] = {
       .fno = gen_helper_sve2_sqxtunt_d,
       .vece = MO_64 },
 };
-TRANS_FEAT(SQXTUNT, aa64_sve2, do_narrow_extract, a, sqxtunt_ops)
+TRANS_FEAT(SQXTUNT, aa64_sme_or_sve2, do_narrow_extract, a, sqxtunt_ops)
 
 static bool do_shr_narrow(DisasContext *s, arg_rri_esz *a,
                           const GVecGen2i ops[3])
@@ -7304,7 +7304,7 @@ static const GVecGen2i shrnb_ops[3] = {
       .fno = gen_helper_sve2_shrnb_d,
       .vece = MO_64 },
 };
-TRANS_FEAT(SHRNB, aa64_sve2, do_shr_narrow, a, shrnb_ops)
+TRANS_FEAT(SHRNB, aa64_sme_or_sve2, do_shr_narrow, a, shrnb_ops)
 
 static void gen_shrnt_i64(unsigned vece, TCGv_i64 d, TCGv_i64 n, int shr)
 {
@@ -7363,21 +7363,21 @@ static const GVecGen2i shrnt_ops[3] = {
       .fno = gen_helper_sve2_shrnt_d,
       .vece = MO_64 },
 };
-TRANS_FEAT(SHRNT, aa64_sve2, do_shr_narrow, a, shrnt_ops)
+TRANS_FEAT(SHRNT, aa64_sme_or_sve2, do_shr_narrow, a, shrnt_ops)
 
 static const GVecGen2i rshrnb_ops[3] = {
     { .fno = gen_helper_sve2_rshrnb_h },
     { .fno = gen_helper_sve2_rshrnb_s },
     { .fno = gen_helper_sve2_rshrnb_d },
 };
-TRANS_FEAT(RSHRNB, aa64_sve2, do_shr_narrow, a, rshrnb_ops)
+TRANS_FEAT(RSHRNB, aa64_sme_or_sve2, do_shr_narrow, a, rshrnb_ops)
 
 static const GVecGen2i rshrnt_ops[3] = {
     { .fno = gen_helper_sve2_rshrnt_h },
     { .fno = gen_helper_sve2_rshrnt_s },
     { .fno = gen_helper_sve2_rshrnt_d },
 };
-TRANS_FEAT(RSHRNT, aa64_sve2, do_shr_narrow, a, rshrnt_ops)
+TRANS_FEAT(RSHRNT, aa64_sme_or_sve2, do_shr_narrow, a, rshrnt_ops)
 
 static void gen_sqshrunb_vec(unsigned vece, TCGv_vec d,
                              TCGv_vec n, int64_t shr)
@@ -7407,7 +7407,7 @@ static const GVecGen2i sqshrunb_ops[3] = {
       .fno = gen_helper_sve2_sqshrunb_d,
       .vece = MO_64 },
 };
-TRANS_FEAT(SQSHRUNB, aa64_sve2, do_shr_narrow, a, sqshrunb_ops)
+TRANS_FEAT(SQSHRUNB, aa64_sme_or_sve2, do_shr_narrow, a, sqshrunb_ops)
 
 static void gen_sqshrunt_vec(unsigned vece, TCGv_vec d,
                              TCGv_vec n, int64_t shr)
@@ -7444,21 +7444,21 @@ static const GVecGen2i sqshrunt_ops[3] = {
       .fno = gen_helper_sve2_sqshrunt_d,
       .vece = MO_64 },
 };
-TRANS_FEAT(SQSHRUNT, aa64_sve2, do_shr_narrow, a, sqshrunt_ops)
+TRANS_FEAT(SQSHRUNT, aa64_sme_or_sve2, do_shr_narrow, a, sqshrunt_ops)
 
 static const GVecGen2i sqrshrunb_ops[3] = {
     { .fno = gen_helper_sve2_sqrshrunb_h },
     { .fno = gen_helper_sve2_sqrshrunb_s },
     { .fno = gen_helper_sve2_sqrshrunb_d },
 };
-TRANS_FEAT(SQRSHRUNB, aa64_sve2, do_shr_narrow, a, sqrshrunb_ops)
+TRANS_FEAT(SQRSHRUNB, aa64_sme_or_sve2, do_shr_narrow, a, sqrshrunb_ops)
 
 static const GVecGen2i sqrshrunt_ops[3] = {
     { .fno = gen_helper_sve2_sqrshrunt_h },
     { .fno = gen_helper_sve2_sqrshrunt_s },
     { .fno = gen_helper_sve2_sqrshrunt_d },
 };
-TRANS_FEAT(SQRSHRUNT, aa64_sve2, do_shr_narrow, a, sqrshrunt_ops)
+TRANS_FEAT(SQRSHRUNT, aa64_sme_or_sve2, do_shr_narrow, a, sqrshrunt_ops)
 
 static void gen_sqshrnb_vec(unsigned vece, TCGv_vec d,
                             TCGv_vec n, int64_t shr)
@@ -7491,7 +7491,7 @@ static const GVecGen2i sqshrnb_ops[3] = {
       .fno = gen_helper_sve2_sqshrnb_d,
       .vece = MO_64 },
 };
-TRANS_FEAT(SQSHRNB, aa64_sve2, do_shr_narrow, a, sqshrnb_ops)
+TRANS_FEAT(SQSHRNB, aa64_sme_or_sve2, do_shr_narrow, a, sqshrnb_ops)
 
 static void gen_sqshrnt_vec(unsigned vece, TCGv_vec d,
                              TCGv_vec n, int64_t shr)
@@ -7529,21 +7529,21 @@ static const GVecGen2i sqshrnt_ops[3] = {
       .fno = gen_helper_sve2_sqshrnt_d,
       .vece = MO_64 },
 };
-TRANS_FEAT(SQSHRNT, aa64_sve2, do_shr_narrow, a, sqshrnt_ops)
+TRANS_FEAT(SQSHRNT, aa64_sme_or_sve2, do_shr_narrow, a, sqshrnt_ops)
 
 static const GVecGen2i sqrshrnb_ops[3] = {
     { .fno = gen_helper_sve2_sqrshrnb_h },
     { .fno = gen_helper_sve2_sqrshrnb_s },
     { .fno = gen_helper_sve2_sqrshrnb_d },
 };
-TRANS_FEAT(SQRSHRNB, aa64_sve2, do_shr_narrow, a, sqrshrnb_ops)
+TRANS_FEAT(SQRSHRNB, aa64_sme_or_sve2, do_shr_narrow, a, sqrshrnb_ops)
 
 static const GVecGen2i sqrshrnt_ops[3] = {
     { .fno = gen_helper_sve2_sqrshrnt_h },
     { .fno = gen_helper_sve2_sqrshrnt_s },
     { .fno = gen_helper_sve2_sqrshrnt_d },
 };
-TRANS_FEAT(SQRSHRNT, aa64_sve2, do_shr_narrow, a, sqrshrnt_ops)
+TRANS_FEAT(SQRSHRNT, aa64_sme_or_sve2, do_shr_narrow, a, sqrshrnt_ops)
 
 static void gen_uqshrnb_vec(unsigned vece, TCGv_vec d,
                             TCGv_vec n, int64_t shr)
@@ -7572,7 +7572,7 @@ static const GVecGen2i uqshrnb_ops[3] = {
       .fno = gen_helper_sve2_uqshrnb_d,
       .vece = MO_64 },
 };
-TRANS_FEAT(UQSHRNB, aa64_sve2, do_shr_narrow, a, uqshrnb_ops)
+TRANS_FEAT(UQSHRNB, aa64_sme_or_sve2, do_shr_narrow, a, uqshrnb_ops)
 
 static void gen_uqshrnt_vec(unsigned vece, TCGv_vec d,
                             TCGv_vec n, int64_t shr)
@@ -7607,28 +7607,28 @@ static const GVecGen2i uqshrnt_ops[3] = {
       .fno = gen_helper_sve2_uqshrnt_d,
       .vece = MO_64 },
 };
-TRANS_FEAT(UQSHRNT, aa64_sve2, do_shr_narrow, a, uqshrnt_ops)
+TRANS_FEAT(UQSHRNT, aa64_sme_or_sve2, do_shr_narrow, a, uqshrnt_ops)
 
 static const GVecGen2i uqrshrnb_ops[3] = {
     { .fno = gen_helper_sve2_uqrshrnb_h },
     { .fno = gen_helper_sve2_uqrshrnb_s },
     { .fno = gen_helper_sve2_uqrshrnb_d },
 };
-TRANS_FEAT(UQRSHRNB, aa64_sve2, do_shr_narrow, a, uqrshrnb_ops)
+TRANS_FEAT(UQRSHRNB, aa64_sme_or_sve2, do_shr_narrow, a, uqrshrnb_ops)
 
 static const GVecGen2i uqrshrnt_ops[3] = {
     { .fno = gen_helper_sve2_uqrshrnt_h },
     { .fno = gen_helper_sve2_uqrshrnt_s },
     { .fno = gen_helper_sve2_uqrshrnt_d },
 };
-TRANS_FEAT(UQRSHRNT, aa64_sve2, do_shr_narrow, a, uqrshrnt_ops)
+TRANS_FEAT(UQRSHRNT, aa64_sme_or_sve2, do_shr_narrow, a, uqrshrnt_ops)
 
 #define DO_SVE2_ZZZ_NARROW(NAME, name)                                    \
     static gen_helper_gvec_3 * const name##_fns[4] = {                    \
         NULL,                       gen_helper_sve2_##name##_h,           \
         gen_helper_sve2_##name##_s, gen_helper_sve2_##name##_d,           \
     };                                                                    \
-    TRANS_FEAT(NAME, aa64_sve2, gen_gvec_ool_arg_zzz,                     \
+    TRANS_FEAT(NAME, aa64_sme_or_sve2, gen_gvec_ool_arg_zzz,                     \
                name##_fns[a->esz], a, 0)
 
 DO_SVE2_ZZZ_NARROW(ADDHNB, addhnb)
@@ -7660,11 +7660,11 @@ TRANS_FEAT_NONSTREAMING(HISTCNT, aa64_sve2, gen_gvec_ool_arg_zpzz,
 TRANS_FEAT_NONSTREAMING(HISTSEG, aa64_sve2, gen_gvec_ool_arg_zzz,
                         a->esz == 0 ? gen_helper_sve2_histseg : NULL, a, 0)
 
-DO_ZPZZ_FP(FADDP, aa64_sve2, sve2_faddp_zpzz)
-DO_ZPZZ_FP(FMAXNMP, aa64_sve2, sve2_fmaxnmp_zpzz)
-DO_ZPZZ_FP(FMINNMP, aa64_sve2, sve2_fminnmp_zpzz)
-DO_ZPZZ_FP(FMAXP, aa64_sve2, sve2_fmaxp_zpzz)
-DO_ZPZZ_FP(FMINP, aa64_sve2, sve2_fminp_zpzz)
+DO_ZPZZ_FP(FADDP, aa64_sme_or_sve2, sve2_faddp_zpzz)
+DO_ZPZZ_FP(FMAXNMP, aa64_sme_or_sve2, sve2_fmaxnmp_zpzz)
+DO_ZPZZ_FP(FMINNMP, aa64_sme_or_sve2, sve2_fminnmp_zpzz)
+DO_ZPZZ_FP(FMAXP, aa64_sme_or_sve2, sve2_fmaxp_zpzz)
+DO_ZPZZ_FP(FMINP, aa64_sme_or_sve2, sve2_fminp_zpzz)
 
 static bool do_fmmla(DisasContext *s, arg_rrrr_esz *a,
                      gen_helper_gvec_4_ptr *fn)
@@ -7690,92 +7690,92 @@ static gen_helper_gvec_4 * const sqdmlal_zzzw_fns[] = {
     NULL,                           gen_helper_sve2_sqdmlal_zzzw_h,
     gen_helper_sve2_sqdmlal_zzzw_s, gen_helper_sve2_sqdmlal_zzzw_d,
 };
-TRANS_FEAT(SQDMLALB_zzzw, aa64_sve2, gen_gvec_ool_arg_zzzz,
+TRANS_FEAT(SQDMLALB_zzzw, aa64_sme_or_sve2, gen_gvec_ool_arg_zzzz,
            sqdmlal_zzzw_fns[a->esz], a, 0)
-TRANS_FEAT(SQDMLALT_zzzw, aa64_sve2, gen_gvec_ool_arg_zzzz,
+TRANS_FEAT(SQDMLALT_zzzw, aa64_sme_or_sve2, gen_gvec_ool_arg_zzzz,
            sqdmlal_zzzw_fns[a->esz], a, 3)
-TRANS_FEAT(SQDMLALBT, aa64_sve2, gen_gvec_ool_arg_zzzz,
+TRANS_FEAT(SQDMLALBT, aa64_sme_or_sve2, gen_gvec_ool_arg_zzzz,
            sqdmlal_zzzw_fns[a->esz], a, 2)
 
 static gen_helper_gvec_4 * const sqdmlsl_zzzw_fns[] = {
     NULL,                           gen_helper_sve2_sqdmlsl_zzzw_h,
     gen_helper_sve2_sqdmlsl_zzzw_s, gen_helper_sve2_sqdmlsl_zzzw_d,
 };
-TRANS_FEAT(SQDMLSLB_zzzw, aa64_sve2, gen_gvec_ool_arg_zzzz,
+TRANS_FEAT(SQDMLSLB_zzzw, aa64_sme_or_sve2, gen_gvec_ool_arg_zzzz,
            sqdmlsl_zzzw_fns[a->esz], a, 0)
-TRANS_FEAT(SQDMLSLT_zzzw, aa64_sve2, gen_gvec_ool_arg_zzzz,
+TRANS_FEAT(SQDMLSLT_zzzw, aa64_sme_or_sve2, gen_gvec_ool_arg_zzzz,
            sqdmlsl_zzzw_fns[a->esz], a, 3)
-TRANS_FEAT(SQDMLSLBT, aa64_sve2, gen_gvec_ool_arg_zzzz,
+TRANS_FEAT(SQDMLSLBT, aa64_sme_or_sve2, gen_gvec_ool_arg_zzzz,
            sqdmlsl_zzzw_fns[a->esz], a, 2)
 
 static gen_helper_gvec_4 * const sqrdmlah_fns[] = {
     gen_helper_sve2_sqrdmlah_b, gen_helper_sve2_sqrdmlah_h,
     gen_helper_sve2_sqrdmlah_s, gen_helper_sve2_sqrdmlah_d,
 };
-TRANS_FEAT(SQRDMLAH_zzzz, aa64_sve2, gen_gvec_ool_arg_zzzz,
+TRANS_FEAT(SQRDMLAH_zzzz, aa64_sme_or_sve2, gen_gvec_ool_arg_zzzz,
            sqrdmlah_fns[a->esz], a, 0)
 
 static gen_helper_gvec_4 * const sqrdmlsh_fns[] = {
     gen_helper_sve2_sqrdmlsh_b, gen_helper_sve2_sqrdmlsh_h,
     gen_helper_sve2_sqrdmlsh_s, gen_helper_sve2_sqrdmlsh_d,
 };
-TRANS_FEAT(SQRDMLSH_zzzz, aa64_sve2, gen_gvec_ool_arg_zzzz,
+TRANS_FEAT(SQRDMLSH_zzzz, aa64_sme_or_sve2, gen_gvec_ool_arg_zzzz,
            sqrdmlsh_fns[a->esz], a, 0)
 
 static gen_helper_gvec_4 * const smlal_zzzw_fns[] = {
     NULL,                         gen_helper_sve2_smlal_zzzw_h,
     gen_helper_sve2_smlal_zzzw_s, gen_helper_sve2_smlal_zzzw_d,
 };
-TRANS_FEAT(SMLALB_zzzw, aa64_sve2, gen_gvec_ool_arg_zzzz,
+TRANS_FEAT(SMLALB_zzzw, aa64_sme_or_sve2, gen_gvec_ool_arg_zzzz,
            smlal_zzzw_fns[a->esz], a, 0)
-TRANS_FEAT(SMLALT_zzzw, aa64_sve2, gen_gvec_ool_arg_zzzz,
+TRANS_FEAT(SMLALT_zzzw, aa64_sme_or_sve2, gen_gvec_ool_arg_zzzz,
            smlal_zzzw_fns[a->esz], a, 1)
 
 static gen_helper_gvec_4 * const umlal_zzzw_fns[] = {
     NULL,                         gen_helper_sve2_umlal_zzzw_h,
     gen_helper_sve2_umlal_zzzw_s, gen_helper_sve2_umlal_zzzw_d,
 };
-TRANS_FEAT(UMLALB_zzzw, aa64_sve2, gen_gvec_ool_arg_zzzz,
+TRANS_FEAT(UMLALB_zzzw, aa64_sme_or_sve2, gen_gvec_ool_arg_zzzz,
            umlal_zzzw_fns[a->esz], a, 0)
-TRANS_FEAT(UMLALT_zzzw, aa64_sve2, gen_gvec_ool_arg_zzzz,
+TRANS_FEAT(UMLALT_zzzw, aa64_sme_or_sve2, gen_gvec_ool_arg_zzzz,
            umlal_zzzw_fns[a->esz], a, 1)
 
 static gen_helper_gvec_4 * const smlsl_zzzw_fns[] = {
     NULL,                         gen_helper_sve2_smlsl_zzzw_h,
     gen_helper_sve2_smlsl_zzzw_s, gen_helper_sve2_smlsl_zzzw_d,
 };
-TRANS_FEAT(SMLSLB_zzzw, aa64_sve2, gen_gvec_ool_arg_zzzz,
+TRANS_FEAT(SMLSLB_zzzw, aa64_sme_or_sve2, gen_gvec_ool_arg_zzzz,
            smlsl_zzzw_fns[a->esz], a, 0)
-TRANS_FEAT(SMLSLT_zzzw, aa64_sve2, gen_gvec_ool_arg_zzzz,
+TRANS_FEAT(SMLSLT_zzzw, aa64_sme_or_sve2, gen_gvec_ool_arg_zzzz,
            smlsl_zzzw_fns[a->esz], a, 1)
 
 static gen_helper_gvec_4 * const umlsl_zzzw_fns[] = {
     NULL,                         gen_helper_sve2_umlsl_zzzw_h,
     gen_helper_sve2_umlsl_zzzw_s, gen_helper_sve2_umlsl_zzzw_d,
 };
-TRANS_FEAT(UMLSLB_zzzw, aa64_sve2, gen_gvec_ool_arg_zzzz,
+TRANS_FEAT(UMLSLB_zzzw, aa64_sme_or_sve2, gen_gvec_ool_arg_zzzz,
            umlsl_zzzw_fns[a->esz], a, 0)
-TRANS_FEAT(UMLSLT_zzzw, aa64_sve2, gen_gvec_ool_arg_zzzz,
+TRANS_FEAT(UMLSLT_zzzw, aa64_sme_or_sve2, gen_gvec_ool_arg_zzzz,
            umlsl_zzzw_fns[a->esz], a, 1)
 
 static gen_helper_gvec_4 * const cmla_fns[] = {
     gen_helper_sve2_cmla_zzzz_b, gen_helper_sve2_cmla_zzzz_h,
     gen_helper_sve2_cmla_zzzz_s, gen_helper_sve2_cmla_zzzz_d,
 };
-TRANS_FEAT(CMLA_zzzz, aa64_sve2, gen_gvec_ool_zzzz,
+TRANS_FEAT(CMLA_zzzz, aa64_sme_or_sve2, gen_gvec_ool_zzzz,
            cmla_fns[a->esz], a->rd, a->rn, a->rm, a->ra, a->rot)
 
 static gen_helper_gvec_4 * const cdot_fns[] = {
     NULL, NULL, gen_helper_sve2_cdot_zzzz_s, gen_helper_sve2_cdot_zzzz_d
 };
-TRANS_FEAT(CDOT_zzzz, aa64_sve2, gen_gvec_ool_zzzz,
+TRANS_FEAT(CDOT_zzzz, aa64_sme_or_sve2, gen_gvec_ool_zzzz,
            cdot_fns[a->esz], a->rd, a->rn, a->rm, a->ra, a->rot)
 
 static gen_helper_gvec_4 * const sqrdcmlah_fns[] = {
     gen_helper_sve2_sqrdcmlah_zzzz_b, gen_helper_sve2_sqrdcmlah_zzzz_h,
     gen_helper_sve2_sqrdcmlah_zzzz_s, gen_helper_sve2_sqrdcmlah_zzzz_d,
 };
-TRANS_FEAT(SQRDCMLAH_zzzz, aa64_sve2, gen_gvec_ool_zzzz,
+TRANS_FEAT(SQRDCMLAH_zzzz, aa64_sme_or_sve2, gen_gvec_ool_zzzz,
            sqrdcmlah_fns[a->esz], a->rd, a->rn, a->rm, a->ra, a->rot)
 
 TRANS_FEAT(USDOT_zzzz_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
@@ -7813,30 +7813,30 @@ static bool trans_RAX1(DisasContext *s, arg_RAX1 *a)
     return gen_gvec_fn_arg_zzz(s, gen_gvec_rax1, a);
 }
 
-TRANS_FEAT(FCVTNT_sh, aa64_sve2, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTNT_sh, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)
-TRANS_FEAT(FCVTNT_ds, aa64_sve2, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTNT_ds, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_ds, a, 0, FPST_A64)
 
 TRANS_FEAT(BFCVTNT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_bfcvtnt, a, 0,
            s->fpcr_ah ? FPST_AH : FPST_A64)
 
-TRANS_FEAT(FCVTLT_hs, aa64_sve2, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTLT_hs, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtlt_hs, a, 0, FPST_A64)
-TRANS_FEAT(FCVTLT_sd, aa64_sve2, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTLT_sd, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtlt_sd, a, 0, FPST_A64)
 
-TRANS_FEAT(FCVTX_ds, aa64_sve2, do_frint_mode, a,
+TRANS_FEAT(FCVTX_ds, aa64_sme_or_sve2, do_frint_mode, a,
            FPROUNDING_ODD, gen_helper_sve_fcvt_ds)
-TRANS_FEAT(FCVTXNT_ds, aa64_sve2, do_frint_mode, a,
+TRANS_FEAT(FCVTXNT_ds, aa64_sme_or_sve2, do_frint_mode, a,
            FPROUNDING_ODD, gen_helper_sve2_fcvtnt_ds)
 
 static gen_helper_gvec_3_ptr * const flogb_fns[] = {
     NULL,               gen_helper_flogb_h,
     gen_helper_flogb_s, gen_helper_flogb_d
 };
-TRANS_FEAT(FLOGB, aa64_sve2, gen_gvec_fpst_arg_zpz, flogb_fns[a->esz],
+TRANS_FEAT(FLOGB, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz, flogb_fns[a->esz],
            a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 static bool do_FMLAL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sub, bool sel)
@@ -7846,10 +7846,10 @@ static bool do_FMLAL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sub, bool sel)
                              (sel << 1) | sub, tcg_env);
 }
 
-TRANS_FEAT(FMLALB_zzzw, aa64_sve2, do_FMLAL_zzzw, a, false, false)
-TRANS_FEAT(FMLALT_zzzw, aa64_sve2, do_FMLAL_zzzw, a, false, true)
-TRANS_FEAT(FMLSLB_zzzw, aa64_sve2, do_FMLAL_zzzw, a, true, false)
-TRANS_FEAT(FMLSLT_zzzw, aa64_sve2, do_FMLAL_zzzw, a, true, true)
+TRANS_FEAT(FMLALB_zzzw, aa64_sme_or_sve2, do_FMLAL_zzzw, a, false, false)
+TRANS_FEAT(FMLALT_zzzw, aa64_sme_or_sve2, do_FMLAL_zzzw, a, false, true)
+TRANS_FEAT(FMLSLB_zzzw, aa64_sme_or_sve2, do_FMLAL_zzzw, a, true, false)
+TRANS_FEAT(FMLSLT_zzzw, aa64_sme_or_sve2, do_FMLAL_zzzw, a, true, true)
 
 static bool do_FMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sub, bool sel)
 {
@@ -7858,10 +7858,10 @@ static bool do_FMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sub, bool sel)
                              (a->index << 3) | (sel << 1) | sub, tcg_env);
 }
 
-TRANS_FEAT(FMLALB_zzxw, aa64_sve2, do_FMLAL_zzxw, a, false, false)
-TRANS_FEAT(FMLALT_zzxw, aa64_sve2, do_FMLAL_zzxw, a, false, true)
-TRANS_FEAT(FMLSLB_zzxw, aa64_sve2, do_FMLAL_zzxw, a, true, false)
-TRANS_FEAT(FMLSLT_zzxw, aa64_sve2, do_FMLAL_zzxw, a, true, true)
+TRANS_FEAT(FMLALB_zzxw, aa64_sme_or_sve2, do_FMLAL_zzxw, a, false, false)
+TRANS_FEAT(FMLALT_zzxw, aa64_sme_or_sve2, do_FMLAL_zzxw, a, false, true)
+TRANS_FEAT(FMLSLB_zzxw, aa64_sme_or_sve2, do_FMLAL_zzxw, a, true, false)
+TRANS_FEAT(FMLSLT_zzxw, aa64_sme_or_sve2, do_FMLAL_zzxw, a, true, true)
 
 TRANS_FEAT_NONSTREAMING(SMMLA, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
                         gen_helper_gvec_smmla_b, a, 0)
-- 
2.43.0


