Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0245C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mmj-0007wM-8M; Sun, 05 May 2024 21:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmQ-0007l6-A5
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:35 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmA-0002Sl-E5
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:32 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2b4aa87e01aso924054a91.3
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957457; x=1715562257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EzbO14aaGLyRdDUDUotLcmhISWFi9tBolxCiVNWY9HI=;
 b=pzecBd4IgWTKpRjxrvXeVlrXSPwJqSFElCU6TvWvV9Hbgv1A6vsCG6ePxE6Xhz4ZUr
 5ZErd94QhaVGwJpNXU1To5lunykcTRJkcxyZ617SA8MbbHXC7/ezh70NkKSoPP7lFh/9
 /v9NjnD/JtEBCFxfjxBjzCZamD8JCoZ/B2sMTRffskYmborby4tJUROK6nPdoF44nww3
 aI7SIIxHwqfxSk19IhAMFLcpZACnV9RG99bTrP5inBMq9yrqh6RIv+C2Y53RLdx7M590
 ONan5XxfGOPkf8XwapVu2MNSoQe6VW0y/504xarmC+uEvqg037zgGXgpo8qHqvrvYMpd
 5mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957457; x=1715562257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EzbO14aaGLyRdDUDUotLcmhISWFi9tBolxCiVNWY9HI=;
 b=Qj19Zg8/Lnl3xWlYFdCng9nrFmGAfL55/4seqx9CCEAP3UZ+2axsUgs0UF238Ims3G
 oF1QwzUoClTBpSmQRldoeIrazHXBXeP+xRGbs+GSYpDzfIuV/U4Ns7Th+cjbnlkSiYvD
 R/XNUVYJDGZJ/8zoZ8NIEsNl0O6+CQ9Wuq4FEtlB+j5t33ysY76+8yC0xmAtKOHwDi/s
 TgT8lY5FswkXQGAeX19YVc6t9D+XigAUwWh3OkSQKl1IGaS9mbtvhNLLvhavJfY4X+YS
 nrrgEqVKhWa/OAd4BUP3no0qy5x6kW5x/J/W4xPcJVY2K1Nb2VaE+F1U2ciBW0VoJKDa
 Z4fQ==
X-Gm-Message-State: AOJu0Yz05SwGpiYlFIQtFJJ++BQLdGIFx+lMLCrvPTci8Z9jVuhFF1Zf
 lXbnKXjelY5A5Jw8ZzOXvnF0BER6S1vg0QZ47OkTl4olZ1LhDKnIWcEl3ZyCSRG5jdYoGY2sWK3
 z
X-Google-Smtp-Source: AGHT+IHZpkNDiPr+KXgrTSpUiEk3q4tPvYuqMT6Em6kwpCDieuXZ86QKtNv0fjmf0utpRUi1wDdFIA==
X-Received: by 2002:a17:90a:ea91:b0:2af:ff3:e14a with SMTP id
 h17-20020a17090aea9100b002af0ff3e14amr6818010pjz.16.1714957456794; 
 Sun, 05 May 2024 18:04:16 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 13/57] target/arm: Convert FADD, FSUB, FDIV, FMUL to decodetree
Date: Sun,  5 May 2024 18:03:19 -0700
Message-Id: <20240506010403.6204-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.h    |   4 +
 target/arm/tcg/translate.h     |   5 +
 target/arm/tcg/a64.decode      |  27 +++++
 target/arm/tcg/translate-a64.c | 205 +++++++++++++++++----------------
 target/arm/tcg/vec_helper.c    |   4 +
 5 files changed, 143 insertions(+), 102 deletions(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index b79751a717..371388f61b 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -133,6 +133,10 @@ DEF_HELPER_4(cpyfp, void, env, i32, i32, i32)
 DEF_HELPER_4(cpyfm, void, env, i32, i32, i32)
 DEF_HELPER_4(cpyfe, void, env, i32, i32, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fdiv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fdiv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fdiv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(gvec_fmulx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fmulx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fmulx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 80e85096a8..ecfa242eef 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -252,6 +252,11 @@ static inline int shl_12(DisasContext *s, int x)
     return x << 12;
 }
 
+static inline int xor_2(DisasContext *s, int x)
+{
+    return x ^ 2;
+}
+
 static inline int neon_3same_fp_size(DisasContext *s, int x)
 {
     /* Convert 0==fp32, 1==fp16 into a MO_* value */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index e28f58bd9a..828ea2d62a 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -21,6 +21,7 @@
 
 %rd             0:5
 %esz_sd         22:1 !function=plus_2
+%esz_hsd        22:2 !function=xor_2
 %hl             11:1 21:1
 %hlm            11:1 20:2
 
@@ -37,6 +38,7 @@
 
 @rrr_h          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=1
 @rrr_sd         ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_sd
+@rrr_hsd        ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_hsd
 
 @rrx_h          ........ .. .. rm:4 .... . . rn:5 rd:5  &rrx_e esz=1 idx=%hlm
 @rrx_s          ........ .. . rm:5  .... . . rn:5 rd:5  &rrx_e esz=2 idx=%hl
@@ -697,22 +699,47 @@ INS_element     0 1   10 1110 000 di:5  0 si:4 1 rn:5 rd:5
 
 ### Advanced SIMD scalar three same
 
+FADD_s          0001 1110 ..1 ..... 0010 10 ..... ..... @rrr_hsd
+FSUB_s          0001 1110 ..1 ..... 0011 10 ..... ..... @rrr_hsd
+FDIV_s          0001 1110 ..1 ..... 0001 10 ..... ..... @rrr_hsd
+FMUL_s          0001 1110 ..1 ..... 0000 10 ..... ..... @rrr_hsd
+
 FMULX_s         0101 1110 010 ..... 00011 1 ..... ..... @rrr_h
 FMULX_s         0101 1110 0.1 ..... 11011 1 ..... ..... @rrr_sd
 
 ### Advanced SIMD three same
 
+FADD_v          0.00 1110 010 ..... 00010 1 ..... ..... @qrrr_h
+FADD_v          0.00 1110 0.1 ..... 11010 1 ..... ..... @qrrr_sd
+
+FSUB_v          0.00 1110 110 ..... 00010 1 ..... ..... @qrrr_h
+FSUB_v          0.00 1110 1.1 ..... 11010 1 ..... ..... @qrrr_sd
+
+FDIV_v          0.10 1110 010 ..... 00111 1 ..... ..... @qrrr_h
+FDIV_v          0.10 1110 0.1 ..... 11111 1 ..... ..... @qrrr_sd
+
+FMUL_v          0.10 1110 010 ..... 00011 1 ..... ..... @qrrr_h
+FMUL_v          0.10 1110 0.1 ..... 11011 1 ..... ..... @qrrr_sd
+
 FMULX_v         0.00 0111 010 ..... 00011 1 ..... ..... @qrrr_h
 FMULX_v         0.00 1110 0.1 ..... 11011 1 ..... ..... @qrrr_sd
 
 ### Advanced SIMD scalar x indexed element
 
+FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
+FMUL_si         0101 1111 10 . ..... 1001 . 0 ..... .....   @rrx_s
+FMUL_si         0101 1111 11 0 ..... 1001 . 0 ..... .....   @rrx_d
+
 FMULX_si        0111 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
 FMULX_si        0111 1111 10 . ..... 1001 . 0 ..... .....   @rrx_s
 FMULX_si        0111 1111 11 0 ..... 1001 . 0 ..... .....   @rrx_d
 
 ### Advanced SIMD vector x indexed element
 
+FMUL_vi         0.00 1111 00 .. .... 1001 . 0 ..... .....   @qrrx_h
+FMUL_vi         0.00 1111 10 . ..... 1001 . 0 ..... .....   @qrrx_s
+FMUL_vi         0.00 1111 11 0 ..... 1001 . 0 ..... .....   @qrrx_d
+
 FMULX_vi        0.10 1111 00 .. .... 1001 . 0 ..... .....   @qrrx_h
 FMULX_vi        0.10 1111 10 . ..... 1001 . 0 ..... .....   @qrrx_s
 FMULX_vi        0.10 1111 11 0 ..... 1001 . 0 ..... .....   @qrrx_d
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 33da0c5f0f..f3b037a7c6 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4888,6 +4888,34 @@ static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f)
     return true;
 }
 
+static const FPScalar f_scalar_fadd = {
+    gen_helper_vfp_addh,
+    gen_helper_vfp_adds,
+    gen_helper_vfp_addd,
+};
+TRANS(FADD_s, do_fp3_scalar, a, &f_scalar_fadd)
+
+static const FPScalar f_scalar_fsub = {
+    gen_helper_vfp_subh,
+    gen_helper_vfp_subs,
+    gen_helper_vfp_subd,
+};
+TRANS(FSUB_s, do_fp3_scalar, a, &f_scalar_fsub)
+
+static const FPScalar f_scalar_fdiv = {
+    gen_helper_vfp_divh,
+    gen_helper_vfp_divs,
+    gen_helper_vfp_divd,
+};
+TRANS(FDIV_s, do_fp3_scalar, a, &f_scalar_fdiv)
+
+static const FPScalar f_scalar_fmul = {
+    gen_helper_vfp_mulh,
+    gen_helper_vfp_muls,
+    gen_helper_vfp_muld,
+};
+TRANS(FMUL_s, do_fp3_scalar, a, &f_scalar_fmul)
+
 static const FPScalar f_scalar_fmulx = {
     gen_helper_advsimd_mulxh,
     gen_helper_vfp_mulxs,
@@ -4923,6 +4951,34 @@ static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
     return true;
 }
 
+static gen_helper_gvec_3_ptr * const f_vector_fadd[3] = {
+    gen_helper_gvec_fadd_h,
+    gen_helper_gvec_fadd_s,
+    gen_helper_gvec_fadd_d,
+};
+TRANS(FADD_v, do_fp3_vector, a, f_vector_fadd)
+
+static gen_helper_gvec_3_ptr * const f_vector_fsub[3] = {
+    gen_helper_gvec_fsub_h,
+    gen_helper_gvec_fsub_s,
+    gen_helper_gvec_fsub_d,
+};
+TRANS(FSUB_v, do_fp3_vector, a, f_vector_fsub)
+
+static gen_helper_gvec_3_ptr * const f_vector_fdiv[3] = {
+    gen_helper_gvec_fdiv_h,
+    gen_helper_gvec_fdiv_s,
+    gen_helper_gvec_fdiv_d,
+};
+TRANS(FDIV_v, do_fp3_vector, a, f_vector_fdiv)
+
+static gen_helper_gvec_3_ptr * const f_vector_fmul[3] = {
+    gen_helper_gvec_fmul_h,
+    gen_helper_gvec_fmul_s,
+    gen_helper_gvec_fmul_d,
+};
+TRANS(FMUL_v, do_fp3_vector, a, f_vector_fmul)
+
 static gen_helper_gvec_3_ptr * const f_vector_fmulx[3] = {
     gen_helper_gvec_fmulx_h,
     gen_helper_gvec_fmulx_s,
@@ -4976,6 +5032,7 @@ static bool do_fp3_scalar_idx(DisasContext *s, arg_rrx_e *a, const FPScalar *f)
     return true;
 }
 
+TRANS(FMUL_si, do_fp3_scalar_idx, a, &f_scalar_fmul)
 TRANS(FMULX_si, do_fp3_scalar_idx, a, &f_scalar_fmulx)
 
 static bool do_fp3_vector_idx(DisasContext *s, arg_qrrx_e *a,
@@ -5006,6 +5063,13 @@ static bool do_fp3_vector_idx(DisasContext *s, arg_qrrx_e *a,
     return true;
 }
 
+static gen_helper_gvec_3_ptr * const f_vector_idx_fmul[3] = {
+    gen_helper_gvec_fmul_idx_h,
+    gen_helper_gvec_fmul_idx_s,
+    gen_helper_gvec_fmul_idx_d,
+};
+TRANS(FMUL_vi, do_fp3_vector_idx, a, f_vector_idx_fmul)
+
 static gen_helper_gvec_3_ptr * const f_vector_idx_fmulx[3] = {
     gen_helper_gvec_fmulx_idx_h,
     gen_helper_gvec_fmulx_idx_s,
@@ -6828,18 +6892,6 @@ static void handle_fp_2src_single(DisasContext *s, int opcode,
     tcg_op2 = read_fp_sreg(s, rm);
 
     switch (opcode) {
-    case 0x0: /* FMUL */
-        gen_helper_vfp_muls(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x1: /* FDIV */
-        gen_helper_vfp_divs(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x2: /* FADD */
-        gen_helper_vfp_adds(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x3: /* FSUB */
-        gen_helper_vfp_subs(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
     case 0x4: /* FMAX */
         gen_helper_vfp_maxs(tcg_res, tcg_op1, tcg_op2, fpst);
         break;
@@ -6856,6 +6908,12 @@ static void handle_fp_2src_single(DisasContext *s, int opcode,
         gen_helper_vfp_muls(tcg_res, tcg_op1, tcg_op2, fpst);
         gen_helper_vfp_negs(tcg_res, tcg_res);
         break;
+    default:
+    case 0x0: /* FMUL */
+    case 0x1: /* FDIV */
+    case 0x2: /* FADD */
+    case 0x3: /* FSUB */
+        g_assert_not_reached();
     }
 
     write_fp_sreg(s, rd, tcg_res);
@@ -6876,18 +6934,6 @@ static void handle_fp_2src_double(DisasContext *s, int opcode,
     tcg_op2 = read_fp_dreg(s, rm);
 
     switch (opcode) {
-    case 0x0: /* FMUL */
-        gen_helper_vfp_muld(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x1: /* FDIV */
-        gen_helper_vfp_divd(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x2: /* FADD */
-        gen_helper_vfp_addd(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x3: /* FSUB */
-        gen_helper_vfp_subd(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
     case 0x4: /* FMAX */
         gen_helper_vfp_maxd(tcg_res, tcg_op1, tcg_op2, fpst);
         break;
@@ -6904,6 +6950,12 @@ static void handle_fp_2src_double(DisasContext *s, int opcode,
         gen_helper_vfp_muld(tcg_res, tcg_op1, tcg_op2, fpst);
         gen_helper_vfp_negd(tcg_res, tcg_res);
         break;
+    default:
+    case 0x0: /* FMUL */
+    case 0x1: /* FDIV */
+    case 0x2: /* FADD */
+    case 0x3: /* FSUB */
+        g_assert_not_reached();
     }
 
     write_fp_dreg(s, rd, tcg_res);
@@ -6924,18 +6976,6 @@ static void handle_fp_2src_half(DisasContext *s, int opcode,
     tcg_op2 = read_fp_hreg(s, rm);
 
     switch (opcode) {
-    case 0x0: /* FMUL */
-        gen_helper_advsimd_mulh(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x1: /* FDIV */
-        gen_helper_advsimd_divh(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x2: /* FADD */
-        gen_helper_advsimd_addh(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x3: /* FSUB */
-        gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
     case 0x4: /* FMAX */
         gen_helper_advsimd_maxh(tcg_res, tcg_op1, tcg_op2, fpst);
         break;
@@ -6953,6 +6993,10 @@ static void handle_fp_2src_half(DisasContext *s, int opcode,
         tcg_gen_xori_i32(tcg_res, tcg_res, 0x8000);
         break;
     default:
+    case 0x0: /* FMUL */
+    case 0x1: /* FDIV */
+    case 0x2: /* FADD */
+    case 0x3: /* FSUB */
         g_assert_not_reached();
     }
 
@@ -9174,9 +9218,6 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             case 0x18: /* FMAXNM */
                 gen_helper_vfp_maxnumd(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x1a: /* FADD */
-                gen_helper_vfp_addd(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x1c: /* FCMEQ */
                 gen_helper_neon_ceq_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
@@ -9189,27 +9230,18 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             case 0x38: /* FMINNM */
                 gen_helper_vfp_minnumd(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x3a: /* FSUB */
-                gen_helper_vfp_subd(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x3e: /* FMIN */
                 gen_helper_vfp_mind(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x3f: /* FRSQRTS */
                 gen_helper_rsqrtsf_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x5b: /* FMUL */
-                gen_helper_vfp_muld(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x5c: /* FCMGE */
                 gen_helper_neon_cge_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x5d: /* FACGE */
                 gen_helper_neon_acge_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x5f: /* FDIV */
-                gen_helper_vfp_divd(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x7a: /* FABD */
                 gen_helper_vfp_subd(tcg_res, tcg_op1, tcg_op2, fpst);
                 gen_helper_vfp_absd(tcg_res, tcg_res);
@@ -9221,7 +9253,11 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
                 gen_helper_neon_acgt_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             default:
+            case 0x1a: /* FADD */
             case 0x1b: /* FMULX */
+            case 0x3a: /* FSUB */
+            case 0x5b: /* FMUL */
+            case 0x5f: /* FDIV */
                 g_assert_not_reached();
             }
 
@@ -9245,9 +9281,6 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
                 gen_helper_vfp_muladds(tcg_res, tcg_op1, tcg_op2,
                                        tcg_res, fpst);
                 break;
-            case 0x1a: /* FADD */
-                gen_helper_vfp_adds(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x1c: /* FCMEQ */
                 gen_helper_neon_ceq_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
@@ -9263,27 +9296,18 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             case 0x38: /* FMINNM */
                 gen_helper_vfp_minnums(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x3a: /* FSUB */
-                gen_helper_vfp_subs(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x3e: /* FMIN */
                 gen_helper_vfp_mins(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x3f: /* FRSQRTS */
                 gen_helper_rsqrtsf_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x5b: /* FMUL */
-                gen_helper_vfp_muls(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x5c: /* FCMGE */
                 gen_helper_neon_cge_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x5d: /* FACGE */
                 gen_helper_neon_acge_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x5f: /* FDIV */
-                gen_helper_vfp_divs(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x7a: /* FABD */
                 gen_helper_vfp_subs(tcg_res, tcg_op1, tcg_op2, fpst);
                 gen_helper_vfp_abss(tcg_res, tcg_res);
@@ -9295,7 +9319,11 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
                 gen_helper_neon_acgt_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             default:
+            case 0x1a: /* FADD */
             case 0x1b: /* FMULX */
+            case 0x3a: /* FSUB */
+            case 0x5b: /* FMUL */
+            case 0x5f: /* FDIV */
                 g_assert_not_reached();
             }
 
@@ -11218,15 +11246,11 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
     case 0x19: /* FMLA */
     case 0x39: /* FMLS */
     case 0x18: /* FMAXNM */
-    case 0x1a: /* FADD */
     case 0x1c: /* FCMEQ */
     case 0x1e: /* FMAX */
     case 0x38: /* FMINNM */
-    case 0x3a: /* FSUB */
     case 0x3e: /* FMIN */
-    case 0x5b: /* FMUL */
     case 0x5c: /* FCMGE */
-    case 0x5f: /* FDIV */
     case 0x7a: /* FABD */
     case 0x7c: /* FCMGT */
         if (!fp_access_check(s)) {
@@ -11256,7 +11280,11 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
         return;
 
     default:
+    case 0x1a: /* FADD */
     case 0x1b: /* FMULX */
+    case 0x3a: /* FSUB */
+    case 0x5b: /* FMUL */
+    case 0x5f: /* FDIV */
         unallocated_encoding(s);
         return;
     }
@@ -11600,19 +11628,15 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
     switch (fpopcode) {
     case 0x0: /* FMAXNM */
     case 0x1: /* FMLA */
-    case 0x2: /* FADD */
     case 0x4: /* FCMEQ */
     case 0x6: /* FMAX */
     case 0x7: /* FRECPS */
     case 0x8: /* FMINNM */
     case 0x9: /* FMLS */
-    case 0xa: /* FSUB */
     case 0xe: /* FMIN */
     case 0xf: /* FRSQRTS */
-    case 0x13: /* FMUL */
     case 0x14: /* FCMGE */
     case 0x15: /* FACGE */
-    case 0x17: /* FDIV */
     case 0x1a: /* FABD */
     case 0x1c: /* FCMGT */
     case 0x1d: /* FACGT */
@@ -11626,7 +11650,11 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
         pairwise = true;
         break;
     default:
+    case 0x2: /* FADD */
     case 0x3: /* FMULX */
+    case 0xa: /* FSUB */
+    case 0x13: /* FMUL */
+    case 0x17: /* FDIV */
         unallocated_encoding(s);
         return;
     }
@@ -11700,9 +11728,6 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
                 gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_res,
                                            fpst);
                 break;
-            case 0x2: /* FADD */
-                gen_helper_advsimd_addh(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x4: /* FCMEQ */
                 gen_helper_advsimd_ceq_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
@@ -11722,27 +11747,18 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
                 gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_res,
                                            fpst);
                 break;
-            case 0xa: /* FSUB */
-                gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0xe: /* FMIN */
                 gen_helper_advsimd_minh(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0xf: /* FRSQRTS */
                 gen_helper_rsqrtsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x13: /* FMUL */
-                gen_helper_advsimd_mulh(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x14: /* FCMGE */
                 gen_helper_advsimd_cge_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x15: /* FACGE */
                 gen_helper_advsimd_acge_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x17: /* FDIV */
-                gen_helper_advsimd_divh(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x1a: /* FABD */
                 gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
                 tcg_gen_andi_i32(tcg_res, tcg_res, 0x7fff);
@@ -11754,7 +11770,11 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
                 gen_helper_advsimd_acgt_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             default:
+            case 0x2: /* FADD */
             case 0x3: /* FMULX */
+            case 0xa: /* FSUB */
+            case 0x13: /* FMUL */
+            case 0x17: /* FDIV */
                 g_assert_not_reached();
             }
 
@@ -12973,7 +12993,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         break;
     case 0x01: /* FMLA */
     case 0x05: /* FMLS */
-    case 0x09: /* FMUL */
         is_fp = 1;
         break;
     case 0x1d: /* SQRDMLAH */
@@ -13042,6 +13061,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         /* is_fp, but we pass tcg_env not fp_status.  */
         break;
     default:
+    case 0x09: /* FMUL */
     case 0x19: /* FMULX */
         unallocated_encoding(s);
         return;
@@ -13263,10 +13283,8 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                 read_vec_element(s, tcg_res, rd, pass, MO_64);
                 gen_helper_vfp_muladdd(tcg_res, tcg_op, tcg_idx, tcg_res, fpst);
                 break;
-            case 0x09: /* FMUL */
-                gen_helper_vfp_muld(tcg_res, tcg_op, tcg_idx, fpst);
-                break;
             default:
+            case 0x09: /* FMUL */
             case 0x19: /* FMULX */
                 g_assert_not_reached();
             }
@@ -13362,24 +13380,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                     g_assert_not_reached();
                 }
                 break;
-            case 0x09: /* FMUL */
-                switch (size) {
-                case 1:
-                    if (is_scalar) {
-                        gen_helper_advsimd_mulh(tcg_res, tcg_op,
-                                                tcg_idx, fpst);
-                    } else {
-                        gen_helper_advsimd_mul2h(tcg_res, tcg_op,
-                                                 tcg_idx, fpst);
-                    }
-                    break;
-                case 2:
-                    gen_helper_vfp_muls(tcg_res, tcg_op, tcg_idx, fpst);
-                    break;
-                default:
-                    g_assert_not_reached();
-                }
-                break;
             case 0x0c: /* SQDMULH */
                 if (size == 1) {
                     gen_helper_neon_qdmulh_s16(tcg_res, tcg_env,
@@ -13421,6 +13421,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                 }
                 break;
             default:
+            case 0x09: /* FMUL */
             case 0x19: /* FMULX */
                 g_assert_not_reached();
             }
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 8684581923..4106536371 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1248,6 +1248,10 @@ DO_3OP(gvec_rsqrts_nf_h, float16_rsqrts_nf, float16)
 DO_3OP(gvec_rsqrts_nf_s, float32_rsqrts_nf, float32)
 
 #ifdef TARGET_AARCH64
+DO_3OP(gvec_fdiv_h, float16_div, float16)
+DO_3OP(gvec_fdiv_s, float32_div, float32)
+DO_3OP(gvec_fdiv_d, float64_div, float64)
+
 DO_3OP(gvec_fmulx_h, helper_advsimd_mulxh, float16)
 DO_3OP(gvec_fmulx_s, helper_vfp_mulxs, float32)
 DO_3OP(gvec_fmulx_d, helper_vfp_mulxd, float64)
-- 
2.34.1


