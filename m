Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCEDC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpJj-0003Bh-5D; Tue, 30 Jul 2024 12:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYpJh-00036M-Rw
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:03:13 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYpJf-0000Fz-5p
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:03:13 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42816ca782dso27078765e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722355390; x=1722960190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Br6CkeiTIKRILq+hj11nYdiPNIHIQx79eIryvbnx584=;
 b=Zfkf2PWxBj5Zc5l8WSoGGBnm+gujF0xs7dADb/SiBN866sMfknKR3VjxSQSeoYqACm
 6Apqndw1ZWsO/Y05UO0XmWw+vbpShC6Ru0g0NlHCnvjXW1KR0YKohLrUr/xz/7AtB3V8
 hoIJaIPS4uPXW5IRbJ7ENe184BnDj8p7Q5JrJ+QXI0HqkNEAVGkf9E7lH5/cj5sbksKq
 gDz+lKNoj8a2zHv1eRO4kQosgbKtn2IhQQ75Wlt5AV6Ioyq7jhKN1ayJib5Z+2nM2r7K
 CWGN795pszwNbVhgNyIJKSuUASNgBl9oFP9fFDIoMeo3XlaYiBMfzNNNM2zJP08yUaup
 V7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722355390; x=1722960190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Br6CkeiTIKRILq+hj11nYdiPNIHIQx79eIryvbnx584=;
 b=A9wP/s+Bvien1+IrqRF71nZ9yizHZOBUWQVfOhyGZkE3kV5l7yk4+oAaAESrw970OZ
 mb92UNH6FlxuSYyPyP/GTC2MRtitHkCd2ELWqvv7usTMHBkQpRtthzfdQBJ1v0yeUdjK
 ovAlUjO9+4SIYQcIQ62Xm22qM74I+V11WneoQlzSySxMU8OAebf7FmvDffmoqcMc4drf
 FYcCnONCxXu0XpV4l2KvgS21Pkv42ehrbPJM15pOY3zDSMZbtxr4QKxKuANEr8v1K2/Y
 EnK9vUx120xCQ3TGrF3+ebMYyffpSDMTG/0NzuEK9t6XrcuE2vN9J30vCdzEAGPJJxvK
 viIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV9Py6D1YYGHkAI3jq7YLTgkX4nrL1cDQWbXxXtmjy/Zgsi8y082XAoaRXJkiOzxvBdqzX0Xe+SPziM/5EkYlZwZtMFCM=
X-Gm-Message-State: AOJu0Yw/YT7M0bbQr+dDBMjEeFwVXPiXZG4WXcMwBon+O2T+EF+f/E6n
 2xEpEE5k1/lFDa2QOes+Gy5zRGc0jZhoQxpfh9Q0039AFPH+F1J5ORGt3UHV6eg=
X-Google-Smtp-Source: AGHT+IGKQh+gJQ4pTLxFA6qHayJeL+sbYxn/gWstLH+VvcbGEoEFUPrwBcFl4lJLBBOnP4SO7IQNng==
X-Received: by 2002:a05:600c:5492:b0:427:b995:5bd0 with SMTP id
 5b1f17b1804b1-42811dd08d3mr71927105e9.23.1722355389721; 
 Tue, 30 Jul 2024 09:03:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b3685810csm15001676f8f.71.2024.07.30.09.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:03:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/8] target/arm: Pass env pointer through to gvec_bfdot helper
Date: Tue, 30 Jul 2024 17:03:01 +0100
Message-Id: <20240730160306.2959745-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730160306.2959745-1-peter.maydell@linaro.org>
References: <20240730160306.2959745-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Pass the env pointer through to the gvec_bfdot helper,
so we can use it to add support for FEAT_EBF16.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             |  4 ++--
 target/arm/tcg/translate-a64.c  | 27 ++++++++++++++++++++++++-
 target/arm/tcg/translate-neon.c | 35 +++++++++++++++++++++++++++++++--
 target/arm/tcg/translate-sve.c  | 15 +++++++++++++-
 target/arm/tcg/vec_helper.c     |  3 ++-
 5 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 970d059dec5..aece9fd4aa7 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1027,8 +1027,8 @@ DEF_HELPER_FLAGS_5(gvec_ummla_b, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_usmmla_b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_5(gvec_bfdot, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(gvec_bfdot, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_bfdot_idx, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 148be2826ec..4aef8b9211a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -735,6 +735,22 @@ static void gen_gvec_op4_ool(DisasContext *s, bool is_q, int rd, int rn,
                        is_q ? 16 : 8, vec_full_reg_size(s), data, fn);
 }
 
+/*
+ * Expand a 4-operand operation using an out-of-line helper that takes
+ * a pointer to the CPU env.
+ */
+static void gen_gvec_op4_env(DisasContext *s, bool is_q, int rd, int rn,
+                             int rm, int ra, int data,
+                             gen_helper_gvec_4_ptr *fn)
+{
+    tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       vec_full_reg_offset(s, rm),
+                       vec_full_reg_offset(s, ra),
+                       tcg_env,
+                       is_q ? 16 : 8, vec_full_reg_size(s), data, fn);
+}
+
 /*
  * Expand a 4-operand + fpstatus pointer + simd data value operation using
  * an out-of-line helper.
@@ -5601,10 +5617,19 @@ static bool do_dot_vector(DisasContext *s, arg_qrrr_e *a,
     return true;
 }
 
+static bool do_dot_vector_env(DisasContext *s, arg_qrrr_e *a,
+                              gen_helper_gvec_4_ptr *fn)
+{
+    if (fp_access_check(s)) {
+        gen_gvec_op4_env(s, a->q, a->rd, a->rn, a->rm, a->rd, 0, fn);
+    }
+    return true;
+}
+
 TRANS_FEAT(SDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_sdot_b)
 TRANS_FEAT(UDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_udot_b)
 TRANS_FEAT(USDOT_v, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_usdot_b)
-TRANS_FEAT(BFDOT_v, aa64_bf16, do_dot_vector, a, gen_helper_gvec_bfdot)
+TRANS_FEAT(BFDOT_v, aa64_bf16, do_dot_vector_env, a, gen_helper_gvec_bfdot)
 TRANS_FEAT(BFMMLA, aa64_bf16, do_dot_vector, a, gen_helper_gvec_bfmmla)
 TRANS_FEAT(SMMLA, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_smmla_b)
 TRANS_FEAT(UMMLA, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_ummla_b)
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 915c9e56db5..454380f01d7 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -148,6 +148,37 @@ static bool do_neon_ddda(DisasContext *s, int q, int vd, int vn, int vm,
     return true;
 }
 
+static bool do_neon_ddda_env(DisasContext *s, int q, int vd, int vn, int vm,
+                             int data, gen_helper_gvec_4_ptr *fn_gvec)
+{
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (((vd | vn | vm) & 0x10) && !dc_isar_feature(aa32_simd_r32, s)) {
+        return false;
+    }
+
+    /*
+     * UNDEF accesses to odd registers for each bit of Q.
+     * Q will be 0b111 for all Q-reg instructions, otherwise
+     * when we have mixed Q- and D-reg inputs.
+     */
+    if (((vd & 1) * 4 | (vn & 1) * 2 | (vm & 1)) & q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    int opr_sz = q ? 16 : 8;
+    tcg_gen_gvec_4_ptr(vfp_reg_offset(1, vd),
+                       vfp_reg_offset(1, vn),
+                       vfp_reg_offset(1, vm),
+                       vfp_reg_offset(1, vd),
+                       tcg_env,
+                       opr_sz, opr_sz, data, fn_gvec);
+    return true;
+}
+
 static bool do_neon_ddda_fpst(DisasContext *s, int q, int vd, int vn, int vm,
                               int data, ARMFPStatusFlavour fp_flavour,
                               gen_helper_gvec_4_ptr *fn_gvec_ptr)
@@ -266,8 +297,8 @@ static bool trans_VDOT_b16(DisasContext *s, arg_VDOT_b16 *a)
     if (!dc_isar_feature(aa32_bf16, s)) {
         return false;
     }
-    return do_neon_ddda(s, a->q * 7, a->vd, a->vn, a->vm, 0,
-                        gen_helper_gvec_bfdot);
+    return do_neon_ddda_env(s, a->q * 7, a->vd, a->vn, a->vm, 0,
+                            gen_helper_gvec_bfdot);
 }
 
 static bool trans_VFML(DisasContext *s, arg_VFML *a)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 798ab2bfb13..4fb0bd077b4 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -238,6 +238,19 @@ static bool gen_gvec_fpst_zzzz(DisasContext *s, gen_helper_gvec_4_ptr *fn,
     return ret;
 }
 
+static bool gen_gvec_env_zzzz(DisasContext *s, gen_helper_gvec_4_ptr *fn,
+                              int rd, int rn, int rm, int ra,
+                              int data)
+{
+    return gen_gvec_ptr_zzzz(s, fn, rd, rn, rm, ra, data, tcg_env);
+}
+
+static bool gen_gvec_env_arg_zzzz(DisasContext *s, gen_helper_gvec_4_ptr *fn,
+                                  arg_rrrr_esz *a, int data)
+{
+    return gen_gvec_env_zzzz(s, fn, a->rd, a->rn, a->rm, a->ra, data);
+}
+
 /* Invoke an out-of-line helper on 4 Zregs, 1 Preg, plus fpst. */
 static bool gen_gvec_fpst_zzzzp(DisasContext *s, gen_helper_gvec_5_ptr *fn,
                                 int rd, int rn, int rm, int ra, int pg,
@@ -7099,7 +7112,7 @@ TRANS_FEAT_NONSTREAMING(USMMLA, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
 TRANS_FEAT_NONSTREAMING(UMMLA, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
                         gen_helper_gvec_ummla_b, a, 0)
 
-TRANS_FEAT(BFDOT_zzzz, aa64_sve_bf16, gen_gvec_ool_arg_zzzz,
+TRANS_FEAT(BFDOT_zzzz, aa64_sve_bf16, gen_gvec_env_arg_zzzz,
            gen_helper_gvec_bfdot, a, 0)
 TRANS_FEAT(BFDOT_zzxz, aa64_sve_bf16, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_bfdot_idx, a)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 98604d170fd..37aad4be4b0 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2814,7 +2814,8 @@ float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2)
     return t1;
 }
 
-void HELPER(gvec_bfdot)(void *vd, void *vn, void *vm, void *va, uint32_t desc)
+void HELPER(gvec_bfdot)(void *vd, void *vn, void *vm, void *va,
+                        void *envp, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
     float32 *d = vd, *a = va;
-- 
2.34.1


