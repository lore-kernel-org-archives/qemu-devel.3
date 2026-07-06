Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7E0C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggik-0007JT-Tj; Mon, 06 Jul 2026 06:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggii-0007Gz-4E
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:36 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggig-0003V9-9k
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:35 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-493c7902f47so16733325e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334313; x=1783939113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PTSki4fFjjWR5YtJRjEnLPihB0lD5gKYOdHO4vCIWUk=;
 b=Ott/F7XYSjuPXiEbgNscseL/KKJCLO+E+NEq6cAi/Mqexkz+zWOAY+LrYuXwyBnHMK
 spB2uhlXVAjTuRh0UGnDI3DQwaPmHPNm9eJ2hKkYsPLE+y+WGtxx1dPywIZ7y26twY6s
 gpZmUidulbalHJRvsx9TWKAEPC2aj8WSFl9MQsLH65de3D96ybh8FbPs1YKoy+Fha2BW
 v1lu/j/l6D93RKq9GujXRaaRy8FEeAMMchIHOs6D7XArIoharZ/VIoeYepQ8i+oBoJW4
 2TRMqcdOa4+QVQYakFlehLFihv4dVjYSMCx8rjkTd4ZPgx2/vVDMhHAoA6B68lYn8bjp
 Xi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334313; x=1783939113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PTSki4fFjjWR5YtJRjEnLPihB0lD5gKYOdHO4vCIWUk=;
 b=I5+d8e7gfvnFnfsni3dgO5cbh9MGKVBTRoGfa6oqg5Yn9cyYsq55tE92fdE86qqzcp
 fCWcb0D4+LjqJ+0CZ4g/gU1EIz3T0Mk1hkwl0B6Xs1ZLlFJqD+LIaK7QncyPkhcp0KnR
 aaCBG48G7gnXrvXF/HcojDmmiRgUsWUhlxX54UMOAe9eBxSlztARFpZpVRLHw9LA0OIb
 UwsQhN7ZJ/9lCZbxLGCPjB2vzt11KDYcO9dMUTNsKRuDZB69KbLAD033c3fhux6TbpPq
 CsCCs93FyJ6F8MjLekID6wt01SrWC6Sui1zVvwC/x/3aW9GXjyHRkealS0cO14GW1SdJ
 27GA==
X-Gm-Message-State: AOJu0YwoY/bYpqjRDM1Wh6EOlvg3mq90Z+8DLtNcAYO7dB4Q3Nu+D3ue
 kfdPZu6pxWJpdnhAGUF+RsI40ydDOB21Ex7pZhJIj410GixY4+ze2OUv4VOiREmP3PRXL5EkLP8
 4FB2m/x9yMw==
X-Gm-Gg: AfdE7clwklpM6Lh9G02dMZfEkoJLxeBnoVzp5P6A8DyQItKc1bffyUgbDiBCRFBRmUm
 gIi1vWErJYQtdLgz4txW3S6YMDrzfruScRW/HRakNY5fN6HkHdsCzXv0/yy2+fVy1gzkOnzI/MC
 WwChh+mddENwfzC+3JFmQZNtGLoY75t/rWJTTFtxToD3wUelirF8Sbwx6znhLumq3lwDvCwbXv8
 5mvl7XcixyKq/T/5IeZJm8hZEsorsuiqD6Wqz6goFprmiNXthrh4A+HJ8Zgizep2PlX8Lj/wZzd
 xeZRDd14Awn8iHqlz8kskK/BDkPuQiV2HuB9D0EILa8dlKypeZZdwmU6nSnYvZAwEoUQnRpFTsL
 RkzMya23tvNdCrpuym7yzQC0FvKHTG/xK3yQGh5aJD9Pl9CsYS4COm0E92Oq+swNPFOoY6gRx/V
 vPs3kfNIJTtUDLb74LPXFiokD8x4f9dJ5/28K+O3OIgSdJ3qyK76udf2LW7Nt/bhQdTV83+qF3a
 b0aNbRoDC7w7J0hmJLoiCl52Trkqbn8
X-Received: by 2002:a05:600c:8b66:b0:493:bc4a:d5f5 with SMTP id
 5b1f17b1804b1-493d11fdb52mr109037635e9.39.1783334312869; 
 Mon, 06 Jul 2026 03:38:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/49] target/arm: Implement FMOP4 (widening,
 2-way fp16 to fp32)
Date: Mon,  6 Jul 2026 11:37:39 +0100
Message-ID: <20260706103752.320511-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260702204314.79224-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme-defs.h |  4 +++
 target/arm/tcg/sme.decode        |  1 +
 target/arm/tcg/sme_helper.c      | 51 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  7 +++++
 4 files changed, 63 insertions(+)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 0e4bb12b38..780b8f162a 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -375,3 +375,7 @@ DEF_HELPER_FLAGS_5(sme_ah_bfmop4s_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst
 DEF_HELPER_FLAGS_5(sme_bfmop4a_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(sme_bfmop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(sme_ah_bfmop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(sme_fmop4a_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(sme_fmop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(sme_ah_fmop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 12a3a61432..ea9f459e38 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1107,3 +1107,4 @@ FMOP4_ss        1000 0000 000. ...0 0000 00.. ..0. 00..         @mop4_o2
 FMOP4_dd        1000 0000 110. ...0 0000 00.. ..0. 1...         @mop4_o3
 
 BFMOP4_sh       1000 0001 000. ...0 0000 00.. ..0. 00..         @mop4_o2
+FMOP4_sh        1000 0001 001. ...0 0000 00.. ..0. 00..         @mop4_o2
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 5a661ca616..123f459342 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2887,3 +2887,54 @@ void HELPER(sme_ah_bfmop4s_sh)(void *vza, void *vzn, void *vzm,
              is_ebf(env, &fpst) ? inner_ebf_ah_bfmop4s_sh
                                 : inner_ah_bfmop4s_sh);
 }
+
+static void inner_fmop4a_sh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd;
+    uint32_t *n = vn, *m = vm;
+    CPUArchState *env = vinfo;
+
+    *d = f16_dotadd(*d, *n, *m,
+                    &env->vfp.fp_status[FPST_ZA_F16],
+                    &env->vfp.fp_status[FPST_ZA]);
+}
+
+void HELPER(sme_fmop4a_sh)(void *vza, void *vzn, void *vzm,
+                           CPUArchState *env, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, env, desc, sizeof(float32), inner_fmop4a_sh);
+}
+
+static void inner_fmop4s_sh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd;
+    uint32_t *n = vn, *m = vm;
+    CPUArchState *env = vinfo;
+
+    *d = f16_dotadd(*d, *n ^ 0x80008000u, *m,
+                    &env->vfp.fp_status[FPST_ZA_F16],
+                    &env->vfp.fp_status[FPST_ZA]);
+}
+
+void HELPER(sme_fmop4s_sh)(void *vza, void *vzn, void *vzm,
+                           CPUArchState *env, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, env, desc, sizeof(float32), inner_fmop4s_sh);
+}
+
+static void inner_ah_fmop4s_sh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd;
+    uint32_t *n = vn, *m = vm;
+    CPUArchState *env = vinfo;
+
+    *d = f16_dotadd(*d, f16mop_ah_neg_adj_pair(*n, -1), *m,
+                    &env->vfp.fp_status[FPST_ZA_F16],
+                    &env->vfp.fp_status[FPST_ZA]);
+}
+
+void HELPER(sme_ah_fmop4s_sh)(void *vza, void *vzn, void *vzm,
+                              CPUArchState *env, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, env, desc, sizeof(float32), inner_ah_fmop4s_sh);
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index df4a5c2125..544a825595 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2065,3 +2065,10 @@ static gen_helper_gvec_3_ptr * const bfmop4_sh[3] = {
     gen_helper_sme_ah_bfmop4s_sh
 };
 TRANS_FEAT(BFMOP4_sh, aa64_sme_mop4, do_mop4_fp, a, MO_32, FPST_ENV, bfmop4_sh)
+
+static gen_helper_gvec_3_ptr * const fmop4_sh[3] = {
+    gen_helper_sme_fmop4a_sh,
+    gen_helper_sme_fmop4s_sh,
+    gen_helper_sme_ah_fmop4s_sh
+};
+TRANS_FEAT(FMOP4_sh, aa64_sme_mop4, do_mop4_fp, a, MO_32, FPST_ENV, fmop4_sh)
-- 
2.43.0


