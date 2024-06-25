Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD1EC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLyPu-0001Bc-M7; Tue, 25 Jun 2024 01:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLyPs-00018a-Fs
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:08:28 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLyPo-0001YH-7Y
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:08:28 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f9de13d6baso34278565ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719292102; x=1719896902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fBS3awWlke5rOhwxZuN7iRtQwvkRtjx0DwumJDSTopQ=;
 b=UcD1uonpspjPAoO2g4YXQZP6KXybbSV8IB15VnnqwAwCmNiNYH5OgUDgDdwKTw4XPm
 2r7fz2CHXw06nICDkk9MWTI1orcUi07XYc4xkexjPWdXfhoV1QE7Yz0DS3PaEvoXmDnf
 rrqpV0v8bYcNKUr0wW9bYrV2w08ImCWzh98wat37KNHzJpC1NjA1F+3TV3wSNi9OCMxY
 Or/Nn2ymqCzDVTpL600uvoSjb0APx4N+yMlkA0v1lntMj9w7ilONn6cVG4r1fNilaFH7
 JOqBRKWNPPWD0lGYK7OJD9vcvcIYy3YWdVecH0jIggxfl9gO+tHmYY/kbczuK8KuYvwx
 HK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719292102; x=1719896902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fBS3awWlke5rOhwxZuN7iRtQwvkRtjx0DwumJDSTopQ=;
 b=Eco1PVdyJkeroZRoT4mtw+v/00tbqCohLqbeLkJGbWjHiDoKFUeN3GzD2dWqIQmOIs
 8/jQiELIt3Fa+oX1rgtAWS7zWe7Z1HvU0f+uX+7Tre1DgpaWsISni8xabatbaSbqbqV1
 sBLqYQea9Xd+K6iWIocefxSWqXtDa0KdMKvW0VMqiaiqKQZIffCHJ3u0pyCFHrFECq1/
 StjXnk8DSVoaakNYKskaEp7jk0WpB2T49tVbBgz0KsbZDq331bU3MrxC7kUQ1RFpFwUj
 BVhRFgx3pgla7YlX41MR91O5XIjHGT1gTyhLaQKWpJNDlZgbx+S/9R2J2lDoNc1tMWHY
 04sA==
X-Gm-Message-State: AOJu0YwFUaTLUSxToqDs0YfHspqOfGyIUQ/IzUA48Yq9F2rCO+Oj6AcJ
 HLEgKHHtotc4hwLobHav+4U7CYKVBgeqSoWVTc2Ki/zYnA85CenlnHeds02ViJDoSXNgcPHMf5i
 R
X-Google-Smtp-Source: AGHT+IHNCZdFeID90EBZE+HI7VdAyUlyFtjwIOej6vZIX1CFZb6ywmdws4PunGYO9qzNhh7+gS8B2A==
X-Received: by 2002:a17:902:e542:b0:1f6:fcd9:5b8d with SMTP id
 d9443c01a7336-1fa23f22890mr65764625ad.9.1719292102406; 
 Mon, 24 Jun 2024 22:08:22 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebbc72e9sm70843865ad.296.2024.06.24.22.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 22:08:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 10/13] target/arm: Add data argument to do_fp3_vector
Date: Mon, 24 Jun 2024 22:08:07 -0700
Message-Id: <20240625050810.1475643-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625050810.1475643-1-richard.henderson@linaro.org>
References: <20240625050810.1475643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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


