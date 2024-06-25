Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBCDC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 19:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMBTT-0007VV-EN; Tue, 25 Jun 2024 15:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMBBt-0002th-Pc
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 14:47:18 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMBBB-0007Bm-30
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 14:46:41 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70656b43fd4so3399723b3a.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719341069; x=1719945869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u70FGhdj6+SDi8C75S6LZSmiHm3Th47xqHQlbQAfOcI=;
 b=Jodi/6k7s3Ih+jiSPmaaz8zmC7y9UxJbJ+6xOTPm37cToQHFbjJcIhegVHMprDiGR7
 hd4ZSK7SmnOv9cGfZCQf0s3HFU0L9A3OnyWGjAaFvhCOvZxEcWC90sbCNrzkrCkH3fgD
 0kittIlkMqFr3H9ueaaGRH+WVeI3OV2cjNDyjwCbn5rBONjJ+ljDY5H/YXhgw0uf/CdS
 c3awaLgB69u6ZxVeZPPz0zN+mw4jSBexGrvQNONxvVWcLxpammV78DBtLwBeFx7Qzd1h
 Qn5QAZops9cLhaXNHIVkw0L1Hq2yXzTkWp5CkTAOrX4mTSNh3zl+5KzLDP9g9hU2Oezi
 FN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719341069; x=1719945869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u70FGhdj6+SDi8C75S6LZSmiHm3Th47xqHQlbQAfOcI=;
 b=gUWVr/jUFOS4ZdhFMwak+/DsW2vfsWrMglPQnbCUoqiBNjg/x/MX/gRtX+J1vIbDMn
 YCE8KGEd1BZSQ1I0duMxAfW6olgJmOibBnk7xcvu31woVzkhoHDJ9Mw/HrPvKb+Nlqrt
 KBE/0BQWru70eYnc6bag6yV1UVPlWyhlTPOtT4FMg5scnpHjQ7N6CVJRV2LyJ9x1Ocih
 plRFgdf5xGhSQBXx5d/mRHxBC0mziT45bR6iyMd2A8WjxkPHm/SZrAtfW356Q5BPc6jD
 XnTqplR++J7oidTrLy4nNU3te20b645hdiTFALXtGWZOqVGhhNt0dU/4XaRCMMaYQzc1
 6Wsg==
X-Gm-Message-State: AOJu0YyRBVqsiJjzRtWmRYZiUIaHAzhySfQb3YC07FyVnoy5lb6VnMbg
 mRT811rLRcQaHF/ZJJkqPEciLWlO0ZJOZ1UcBIp2X7hI50VasFbQqJv0dssFJo2cs0QjTCxB19C
 l
X-Google-Smtp-Source: AGHT+IExR7US1/HehZRxiSXpfdKHm0AYigFlSgCTddaoCmbwZwMcvf+HaoeSRclDw4L0pW3MMJxikQ==
X-Received: by 2002:a17:903:41cd:b0:1f9:bb35:f313 with SMTP id
 d9443c01a7336-1fa23edc8c2mr80059025ad.30.1719340546997; 
 Tue, 25 Jun 2024 11:35:46 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3c6027sm84693235ad.133.2024.06.25.11.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 11:35:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 10/13] target/arm: Add data argument to do_fp3_vector
Date: Tue, 25 Jun 2024 11:35:33 -0700
Message-Id: <20240625183536.1672454-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625183536.1672454-1-richard.henderson@linaro.org>
References: <20240625183536.1672454-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 52 +++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2697c4b305..57cdde008e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5290,7 +5290,7 @@ TRANS(CMHS_s, do_cmop_d, a, TCG_COND_GEU)
 TRANS(CMEQ_s, do_cmop_d, a, TCG_COND_EQ)
 TRANS(CMTST_s, do_cmop_d, a, TCG_COND_TSTNE)
 
-static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
+static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a, int data,
                           gen_helper_gvec_3_ptr * const fns[3])
 {
     MemOp esz = a->esz;
@@ -5313,7 +5313,7 @@ static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
     }
     if (fp_access_check(s)) {
         gen_gvec_op3_fpst(s, a->q, a->rd, a->rn, a->rm,
-                          esz == MO_16, 0, fns[esz - 1]);
+                          esz == MO_16, data, fns[esz - 1]);
     }
     return true;
 }
@@ -5323,168 +5323,168 @@ static gen_helper_gvec_3_ptr * const f_vector_fadd[3] = {
     gen_helper_gvec_fadd_s,
     gen_helper_gvec_fadd_d,
 };
-TRANS(FADD_v, do_fp3_vector, a, f_vector_fadd)
+TRANS(FADD_v, do_fp3_vector, a, 0, f_vector_fadd)
 
 static gen_helper_gvec_3_ptr * const f_vector_fsub[3] = {
     gen_helper_gvec_fsub_h,
     gen_helper_gvec_fsub_s,
     gen_helper_gvec_fsub_d,
 };
-TRANS(FSUB_v, do_fp3_vector, a, f_vector_fsub)
+TRANS(FSUB_v, do_fp3_vector, a, 0, f_vector_fsub)
 
 static gen_helper_gvec_3_ptr * const f_vector_fdiv[3] = {
     gen_helper_gvec_fdiv_h,
     gen_helper_gvec_fdiv_s,
     gen_helper_gvec_fdiv_d,
 };
-TRANS(FDIV_v, do_fp3_vector, a, f_vector_fdiv)
+TRANS(FDIV_v, do_fp3_vector, a, 0, f_vector_fdiv)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmul[3] = {
     gen_helper_gvec_fmul_h,
     gen_helper_gvec_fmul_s,
     gen_helper_gvec_fmul_d,
 };
-TRANS(FMUL_v, do_fp3_vector, a, f_vector_fmul)
+TRANS(FMUL_v, do_fp3_vector, a, 0, f_vector_fmul)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmax[3] = {
     gen_helper_gvec_fmax_h,
     gen_helper_gvec_fmax_s,
     gen_helper_gvec_fmax_d,
 };
-TRANS(FMAX_v, do_fp3_vector, a, f_vector_fmax)
+TRANS(FMAX_v, do_fp3_vector, a, 0, f_vector_fmax)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmin[3] = {
     gen_helper_gvec_fmin_h,
     gen_helper_gvec_fmin_s,
     gen_helper_gvec_fmin_d,
 };
-TRANS(FMIN_v, do_fp3_vector, a, f_vector_fmin)
+TRANS(FMIN_v, do_fp3_vector, a, 0, f_vector_fmin)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmaxnm[3] = {
     gen_helper_gvec_fmaxnum_h,
     gen_helper_gvec_fmaxnum_s,
     gen_helper_gvec_fmaxnum_d,
 };
-TRANS(FMAXNM_v, do_fp3_vector, a, f_vector_fmaxnm)
+TRANS(FMAXNM_v, do_fp3_vector, a, 0, f_vector_fmaxnm)
 
 static gen_helper_gvec_3_ptr * const f_vector_fminnm[3] = {
     gen_helper_gvec_fminnum_h,
     gen_helper_gvec_fminnum_s,
     gen_helper_gvec_fminnum_d,
 };
-TRANS(FMINNM_v, do_fp3_vector, a, f_vector_fminnm)
+TRANS(FMINNM_v, do_fp3_vector, a, 0, f_vector_fminnm)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmulx[3] = {
     gen_helper_gvec_fmulx_h,
     gen_helper_gvec_fmulx_s,
     gen_helper_gvec_fmulx_d,
 };
-TRANS(FMULX_v, do_fp3_vector, a, f_vector_fmulx)
+TRANS(FMULX_v, do_fp3_vector, a, 0, f_vector_fmulx)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmla[3] = {
     gen_helper_gvec_vfma_h,
     gen_helper_gvec_vfma_s,
     gen_helper_gvec_vfma_d,
 };
-TRANS(FMLA_v, do_fp3_vector, a, f_vector_fmla)
+TRANS(FMLA_v, do_fp3_vector, a, 0, f_vector_fmla)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmls[3] = {
     gen_helper_gvec_vfms_h,
     gen_helper_gvec_vfms_s,
     gen_helper_gvec_vfms_d,
 };
-TRANS(FMLS_v, do_fp3_vector, a, f_vector_fmls)
+TRANS(FMLS_v, do_fp3_vector, a, 0, f_vector_fmls)
 
 static gen_helper_gvec_3_ptr * const f_vector_fcmeq[3] = {
     gen_helper_gvec_fceq_h,
     gen_helper_gvec_fceq_s,
     gen_helper_gvec_fceq_d,
 };
-TRANS(FCMEQ_v, do_fp3_vector, a, f_vector_fcmeq)
+TRANS(FCMEQ_v, do_fp3_vector, a, 0, f_vector_fcmeq)
 
 static gen_helper_gvec_3_ptr * const f_vector_fcmge[3] = {
     gen_helper_gvec_fcge_h,
     gen_helper_gvec_fcge_s,
     gen_helper_gvec_fcge_d,
 };
-TRANS(FCMGE_v, do_fp3_vector, a, f_vector_fcmge)
+TRANS(FCMGE_v, do_fp3_vector, a, 0, f_vector_fcmge)
 
 static gen_helper_gvec_3_ptr * const f_vector_fcmgt[3] = {
     gen_helper_gvec_fcgt_h,
     gen_helper_gvec_fcgt_s,
     gen_helper_gvec_fcgt_d,
 };
-TRANS(FCMGT_v, do_fp3_vector, a, f_vector_fcmgt)
+TRANS(FCMGT_v, do_fp3_vector, a, 0, f_vector_fcmgt)
 
 static gen_helper_gvec_3_ptr * const f_vector_facge[3] = {
     gen_helper_gvec_facge_h,
     gen_helper_gvec_facge_s,
     gen_helper_gvec_facge_d,
 };
-TRANS(FACGE_v, do_fp3_vector, a, f_vector_facge)
+TRANS(FACGE_v, do_fp3_vector, a, 0, f_vector_facge)
 
 static gen_helper_gvec_3_ptr * const f_vector_facgt[3] = {
     gen_helper_gvec_facgt_h,
     gen_helper_gvec_facgt_s,
     gen_helper_gvec_facgt_d,
 };
-TRANS(FACGT_v, do_fp3_vector, a, f_vector_facgt)
+TRANS(FACGT_v, do_fp3_vector, a, 0, f_vector_facgt)
 
 static gen_helper_gvec_3_ptr * const f_vector_fabd[3] = {
     gen_helper_gvec_fabd_h,
     gen_helper_gvec_fabd_s,
     gen_helper_gvec_fabd_d,
 };
-TRANS(FABD_v, do_fp3_vector, a, f_vector_fabd)
+TRANS(FABD_v, do_fp3_vector, a, 0, f_vector_fabd)
 
 static gen_helper_gvec_3_ptr * const f_vector_frecps[3] = {
     gen_helper_gvec_recps_h,
     gen_helper_gvec_recps_s,
     gen_helper_gvec_recps_d,
 };
-TRANS(FRECPS_v, do_fp3_vector, a, f_vector_frecps)
+TRANS(FRECPS_v, do_fp3_vector, a, 0, f_vector_frecps)
 
 static gen_helper_gvec_3_ptr * const f_vector_frsqrts[3] = {
     gen_helper_gvec_rsqrts_h,
     gen_helper_gvec_rsqrts_s,
     gen_helper_gvec_rsqrts_d,
 };
-TRANS(FRSQRTS_v, do_fp3_vector, a, f_vector_frsqrts)
+TRANS(FRSQRTS_v, do_fp3_vector, a, 0, f_vector_frsqrts)
 
 static gen_helper_gvec_3_ptr * const f_vector_faddp[3] = {
     gen_helper_gvec_faddp_h,
     gen_helper_gvec_faddp_s,
     gen_helper_gvec_faddp_d,
 };
-TRANS(FADDP_v, do_fp3_vector, a, f_vector_faddp)
+TRANS(FADDP_v, do_fp3_vector, a, 0, f_vector_faddp)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmaxp[3] = {
     gen_helper_gvec_fmaxp_h,
     gen_helper_gvec_fmaxp_s,
     gen_helper_gvec_fmaxp_d,
 };
-TRANS(FMAXP_v, do_fp3_vector, a, f_vector_fmaxp)
+TRANS(FMAXP_v, do_fp3_vector, a, 0, f_vector_fmaxp)
 
 static gen_helper_gvec_3_ptr * const f_vector_fminp[3] = {
     gen_helper_gvec_fminp_h,
     gen_helper_gvec_fminp_s,
     gen_helper_gvec_fminp_d,
 };
-TRANS(FMINP_v, do_fp3_vector, a, f_vector_fminp)
+TRANS(FMINP_v, do_fp3_vector, a, 0, f_vector_fminp)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmaxnmp[3] = {
     gen_helper_gvec_fmaxnump_h,
     gen_helper_gvec_fmaxnump_s,
     gen_helper_gvec_fmaxnump_d,
 };
-TRANS(FMAXNMP_v, do_fp3_vector, a, f_vector_fmaxnmp)
+TRANS(FMAXNMP_v, do_fp3_vector, a, 0, f_vector_fmaxnmp)
 
 static gen_helper_gvec_3_ptr * const f_vector_fminnmp[3] = {
     gen_helper_gvec_fminnump_h,
     gen_helper_gvec_fminnump_s,
     gen_helper_gvec_fminnump_d,
 };
-TRANS(FMINNMP_v, do_fp3_vector, a, f_vector_fminnmp)
+TRANS(FMINNMP_v, do_fp3_vector, a, 0, f_vector_fminnmp)
 
 static bool do_fmlal(DisasContext *s, arg_qrrr_e *a, bool is_s, bool is_2)
 {
-- 
2.34.1


