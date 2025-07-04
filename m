Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B93C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEV-0000gz-1E; Fri, 04 Jul 2025 12:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEQ-0000Yn-Pg
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:46 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEO-0006Go-Sq
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:46 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso967170f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646343; x=1752251143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eJvUp9STOUAnZKNra59IO+xkJWbIoLoNC6yS5tutuiA=;
 b=vcA8EQ/pVIAey2KGN08LvvG92ET4BoRKUECxSU0bhKWdv+GGLMOxjHQZTHFPD3SJgj
 cEpntE5Mv5z9D2wOo/wfQfKGKeXrSvCB5p5MQuGZVxVUm5XXxS27uvG+/N+C7683bRHa
 vYVXDyWbaWvgiiQBo88nLRcaTNjrmiE/hvqGHLagqUauM2oVy8O+aFwO6FYk8uF5ZbMO
 LT2G3KeiQNgUX+nMNFno1B6s7T3iRc7ytv4EQHSl/H3XtH6/H4mgkdpxnZiCMs8XEdn9
 qJzF3mxR5ivosqifQxNMulsfnkDA7X/AE/HJAHvFcsxOYd5pexjA+TFyvv330yraubpz
 OlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646343; x=1752251143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eJvUp9STOUAnZKNra59IO+xkJWbIoLoNC6yS5tutuiA=;
 b=bH91S1o81oBIvoPDLzJkEz9n93ap7uAgPgAABpBQXRjlZRQUB9ZtGPtrD933izxMho
 dV2XhRLl9kJmD7v6NSJ8D4pS1v8Vq0Se0quOxd8WzB0+GTN8v3H+ZC6PoydEB4UhK6qn
 xealMmZouUf1q98yYFnmuxyew5bs653955koOi7xXLeELIxHPEvsYIOYIhrxlXR3G0H/
 gggy+NPhp2SQGeGiEcYpOovC/WMK9qkgBZqi+wKdmrilYvYWZ6kGsKCMT5mnuhqBEPwK
 aTP4aMX99KmJiAsP2JctM1QV3RTjEuy2KWYDECQhbkG6kcahKCDUA2ThITlsFwzeidU1
 t8Sw==
X-Gm-Message-State: AOJu0YzzzIFTK3SkGepa5lG4hVJS0HqvW/tUp7AV+FS0cUcqlk3Yh93j
 f7C793FHefs635smvmsSgN4YLGTkZa2BrBvWWfDVl9xim2cdu6rXKFmIIux4IWdKyvYrcQDtPix
 1e6qo
X-Gm-Gg: ASbGnctar0bPMg4phEdfnFqG4V9Ih9qosyFY3lP78dZory4e+HcCsjpTBUYdFu1vmmp
 iexuM8jSbIB5uarOARlHj+H/GHht+xVqqz7pkbNVXytS6WbiqNim6rJN2xFV2mvjotuK00FovJO
 sVI/8Supo7vld+JSMYIFAPycHj4XHdK8bY8ykG01GZT315l+gVT8FHqpakcf+Chb5wL3+T8BH3T
 ioyz0q1xGkDIrJNVFH7Xgx/ifNyIs9o7+l8kiAuO/XVxxxnz/6+kAGxQ4jjDCMie0uyFn2vnXxQ
 ZXhnaY8OxiLhxfVQ7uW9+Ja8EeVV79jMOBBDQZ+O4QFzrjK4TO+TjcvVyEUndy/Ov2J6
X-Google-Smtp-Source: AGHT+IFYAA1FLhVWq3Qz64gRAmenh1trDJYZbOeX9u3Rz4gt03Wj1uv8RXF/+iF8dinQpm1bG5Glhw==
X-Received: by 2002:a05:6000:420d:b0:3a3:7baf:f06a with SMTP id
 ffacd0b85a97d-3b497029578mr2369771f8f.37.1751646343363; 
 Fri, 04 Jul 2025 09:25:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 044/119] target/arm: Implement SME2 ADD/SUB (array results,
 multiple and single vector)
Date: Fri,  4 Jul 2025 17:23:44 +0100
Message-ID: <20250704162501.249138-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-33-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.h     |  2 ++
 target/arm/tcg/sme.decode      | 15 +++++++++++++++
 target/arm/tcg/translate-sme.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index a18d07540e6..f974996f3f8 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -643,6 +643,8 @@ typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
                         uint32_t, uint32_t, uint32_t);
 typedef void GVecGen4Fn(unsigned, uint32_t, uint32_t, uint32_t,
                         uint32_t, uint32_t, uint32_t);
+typedef void GVecGen3FnVar(unsigned, TCGv_ptr, uint32_t, TCGv_ptr, uint32_t,
+                           TCGv_ptr, uint32_t, uint32_t, uint32_t);
 
 /* Function prototype for gen_ functions for calling Neon helpers */
 typedef void NeonGenOneOpFn(TCGv_i32, TCGv_i32);
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 470592f4c09..8b81c0a0ced 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -245,3 +245,18 @@ URSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 1    @z2z_4x4
 
 SQDMULH_nn     1100000 1 .. 1 ..... 1011.1 00000 .... 0    @z2z_2x2
 SQDMULH_nn     1100000 1 .. 1 ..... 1011.1 00000 .... 0    @z2z_4x4
+
+### SME2 Multi-vector Multiple and Single Array Vectors
+
+&azz_n          n off rv zn zm
+@azz_nx1_o3     ........ .... zm:4 ...... zn:5 .. off:3     &azz_n rv=%mova_rv
+
+ADD_azz_n1_s    11000001 0010 .... 0 .. 110 ..... 10 ...    @azz_nx1_o3 n=2
+ADD_azz_n1_s    11000001 0011 .... 0 .. 110 ..... 10 ...    @azz_nx1_o3 n=4
+ADD_azz_n1_d    11000001 0110 .... 0 .. 110 ..... 10 ...    @azz_nx1_o3 n=2
+ADD_azz_n1_d    11000001 0111 .... 0 .. 110 ..... 10 ...    @azz_nx1_o3 n=4
+
+SUB_azz_n1_s    11000001 0010 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=2
+SUB_azz_n1_s    11000001 0011 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=4
+SUB_azz_n1_d    11000001 0110 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=2
+SUB_azz_n1_d    11000001 0111 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=4
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 0a6a10b63d1..4bb880d9ef8 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -745,3 +745,33 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
 };
 TRANS_FEAT(FMINNM_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fminnm)
 TRANS_FEAT(FMINNM_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fminnm)
+
+/* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
+static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
+                      GVecGen3FnVar *fn)
+{
+    TCGv_ptr t_za;
+    int svl, n, o_zm;
+
+    if (!sme_smza_enabled_check(s)) {
+        return true;
+    }
+
+    n = a->n;
+    t_za = get_zarray(s, a->rv, a->off, n, 0);
+    o_zm = vec_full_reg_offset(s, a->zm);
+    svl = streaming_vec_reg_size(s);
+
+    for (int i = 0; i < n; ++i) {
+        int o_za = (svl / n * sizeof(ARMVectorReg)) * i;
+        int o_zn = vec_full_reg_offset(s, (a->zn + i) % 32);
+
+        fn(esz, t_za, o_za, tcg_env, o_zn, tcg_env, o_zm, svl, svl);
+    }
+    return true;
+}
+
+TRANS_FEAT(ADD_azz_n1_s, aa64_sme2, do_azz_n1, a, MO_32, tcg_gen_gvec_add_var)
+TRANS_FEAT(SUB_azz_n1_s, aa64_sme2, do_azz_n1, a, MO_32, tcg_gen_gvec_sub_var)
+TRANS_FEAT(ADD_azz_n1_d, aa64_sme2_i16i64, do_azz_n1, a, MO_64, tcg_gen_gvec_add_var)
+TRANS_FEAT(SUB_azz_n1_d, aa64_sme2_i16i64, do_azz_n1, a, MO_64, tcg_gen_gvec_sub_var)
-- 
2.43.0


