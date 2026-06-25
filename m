Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48288CDE012
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcsfF-0004bH-VL; Thu, 25 Jun 2026 18:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcsed-0004Vo-Q6
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:34:40 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcseY-0002K7-MH
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:34:36 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-845438a46d4so130857b3a.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 15:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782426725; x=1783031525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ccxd1+lNvbzcZiCchkXOq85BfqNMWQBzMgKBQRJxBZY=;
 b=dF1HHutl/Z5KggtFa7NH++2s9KVgyAhlj5afpn9ThxaqJ45XdJAAA+7YH/5ZFqRBTR
 5ChIgmMGXPirMfxJwWorcCfAB4bF7nQKQKcR8UXSwEGa4Xz2n8fkgazToS8AnpRHoUFy
 Weksg7L9SO61rf7oD+cJM4BPhIlW9t/MzEzU0ue3ap7bw06KaxF+F9Mp4rRwnlCYJtUD
 tOZLMx250VoqMRYK4fnwJBTUg5JdnpIY9nyWFizk1U1EygCdNGdzqxkPTHiMLRKBs9Oz
 j0gzGb8k3bMyczSB2V8ojaFHNyLY7dmNriVclEB8jE9ElGqQ6Dbdb5RZNgtUguZAPO0s
 w7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426725; x=1783031525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ccxd1+lNvbzcZiCchkXOq85BfqNMWQBzMgKBQRJxBZY=;
 b=U66wuubeLQBWWTTKwMLAWfYWBVBGScdbMTN/m/tbph4U488UQVVmYbBwqX265OnfT+
 wCP7WoC6HQTO//PjT6xNrbb2kDvfWlT9OP8uYnZWcHWvxUtVkavuS8On49aIWUkj5euo
 thTiz7S/H0EdrwS6JHV4NF4CBoqmw0CTt4DKyocLQvZETY1jeE746iBsG+AwIcst7rK8
 tR5koZPdY1b9p29A7LaCjx+vWnWV5Ue0c73Ckb8qWKImIacRpYUNoqn00MSiwpQZY3wP
 14DnG6p3VwvrXRR8VDTNivzGFBGFlU3yAYcKeZyuTKGMblt7mZgFXnaB89+/UqGaPKzS
 96oQ==
X-Gm-Message-State: AOJu0YwlJYy3Y4hc4S+FsoM0Vr7G3dGZRP9FwGJRlqFs1ieqBNdVqQ8I
 AfMbp8PsReJInvTC9+2HfPbwvRxWQAOm/h1ZBv8k0gmiIh7ZHK7P6QFQaTKuJNgJcx1iLa63Pmz
 WAZTq
X-Gm-Gg: AfdE7clekI+/4KP8WfVXd6ugZjRCyLCMLG7GYwHWaURn+9ggacLDK8YO3ce90hNaLVG
 i/wUKx20Uk5V0fAcm9HwfbIoxETgFstWqgdfbuj1BpIS+PEdgtUDS3+A0gYkEDeSeWNkjOsfrX0
 yWWOY4FlDwBdpas/xZGLnxR/LDzSjyMYJiNg4ZkMV6Oz2ZhR4gAo/yVlHp2wk4M9lECcn+JqNjN
 0SUIxhceJ3mEEIWIA/uGg0QpobQl3L7kkFcnNpVhwr5h1wTvLTuD15fL+wWl87f1b5AqAm3vOnn
 RUleTkVPtSQzn5xQXM5wnoUtlFg2d6omqHMyM8b6KuQcQcrYUhKCzxEx0H3ovXXJf9wJI2pknT8
 gZOcA9w4QO/gzszVgFGf4lFIpy1775gbWzY25wteCPzGjF1ybcpADHARR7ZaukzBeg9CIAcwPKl
 9CsJyB5BWZaatoQ0RAJx4Yq3vEvT1C30WAADzBhoCqco5FKI0dBQ==
X-Received: by 2002:a05:6a00:230a:b0:842:6ec3:2359 with SMTP id
 d2e1a72fcca58-845b3af0ebfmr4487529b3a.45.1782426725132; 
 Thu, 25 Jun 2026 15:32:05 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a412e5e9sm5450139b3a.54.2026.06.25.15.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:32:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 05/15] target/arm: Implement BFMOP4 (widening)
Date: Thu, 25 Jun 2026 15:31:50 -0700
Message-ID: <20260625223200.763198-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625223200.763198-1-richard.henderson@linaro.org>
References: <20260625223200.763198-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme-defs.h |  4 ++
 target/arm/tcg/sme_helper.c      | 84 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   | 16 ++++--
 target/arm/tcg/sme.decode        |  2 +
 4 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 05ccb0d1e2..0e4bb12b38 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -371,3 +371,7 @@ DEF_HELPER_FLAGS_5(sme_ah_fmop4s_dd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst,
 DEF_HELPER_FLAGS_5(sme_bfmop4a_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme_bfmop4s_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme_ah_bfmop4s_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sme_bfmop4a_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(sme_bfmop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(sme_ah_bfmop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 0de7dd84e5..5a661ca616 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2803,3 +2803,87 @@ void HELPER(sme_ah_bfmop4s_hh)(void *vza, void *vzn, void *vzm,
 {
     sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(bfloat16), inner_ah_bfmop4s_hh);
 }
+
+static void inner_bfmop4a_sh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd;
+    uint32_t *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = bfdotadd(*d, *n, *m, fpst);
+}
+
+static void inner_ebf_bfmop4a_sh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd;
+    uint32_t *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = bfdotadd_ebf(*d, *n, *m, fpst);
+}
+
+void HELPER(sme_bfmop4a_sh)(void *vza, void *vzn, void *vzm,
+                            CPUArchState *env, uint32_t desc)
+{
+    float_status fpst;
+
+    sme_mop4(vza, vzn, vzm, &fpst, desc, sizeof(float32),
+             is_ebf(env, &fpst) ? inner_ebf_bfmop4a_sh
+                                : inner_bfmop4a_sh);
+}
+
+static void inner_bfmop4s_sh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd;
+    uint32_t *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = bfdotadd(*d, *n ^ 0x80008000u, *m, fpst);
+}
+
+static void inner_ebf_bfmop4s_sh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd;
+    uint32_t *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = bfdotadd_ebf(*d, *n ^ 0x80008000u, *m, fpst);
+}
+
+void HELPER(sme_bfmop4s_sh)(void *vza, void *vzn, void *vzm,
+                            CPUArchState *env, uint32_t desc)
+{
+    float_status fpst;
+
+    sme_mop4(vza, vzn, vzm, &fpst, desc, sizeof(float32),
+             is_ebf(env, &fpst) ? inner_ebf_bfmop4s_sh
+                                : inner_bfmop4s_sh);
+}
+
+static void inner_ah_bfmop4s_sh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd;
+    uint32_t *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = bfdotadd(*d, bf16mop_ah_neg_adj_pair(*n, -1), *m, fpst);
+}
+
+static void inner_ebf_ah_bfmop4s_sh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd;
+    uint32_t *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = bfdotadd_ebf(*d, bf16mop_ah_neg_adj_pair(*n, -1), *m, fpst);
+}
+
+void HELPER(sme_ah_bfmop4s_sh)(void *vza, void *vzn, void *vzm,
+                               CPUArchState *env, uint32_t desc)
+{
+    float_status fpst;
+
+    sme_mop4(vza, vzn, vzm, &fpst, desc, sizeof(float32),
+             is_ebf(env, &fpst) ? inner_ebf_ah_bfmop4s_sh
+                                : inner_ah_bfmop4s_sh);
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index f833975875..df4a5c2125 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2004,8 +2004,7 @@ TRANS_FEAT(LUTI4_s_4b, aa64_sme2p1_lutv2, do_lut_s4, a,
            gen_helper_sme2_luti4_4b)
 
 static bool do_mop4_fp(DisasContext *s, arg_mop4 *a, MemOp esz,
-                       ARMFPStatusFlavour e_fpst,
-                       gen_helper_gvec_3_ptr * const fns[3])
+                       int e_fpst, gen_helper_gvec_3_ptr * const fns[3])
 {
     int svl = streaming_vec_reg_size(s);
     uint32_t desc = simd_desc(svl, svl, (a->m << 1) | a->n);
@@ -2019,7 +2018,11 @@ static bool do_mop4_fp(DisasContext *s, arg_mop4 *a, MemOp esz,
     za = get_tile(s, esz, a->zad);
     zn = vec_full_reg_ptr(s, a->zn);
     zm = vec_full_reg_ptr(s, a->zm);
-    fpst = fpstatus_ptr(e_fpst);
+    if (e_fpst >= 0) {
+        fpst = fpstatus_ptr(e_fpst);
+    } else {
+        fpst = tcg_env;
+    }
 
     fns[fns_idx](za, zn, zm, fpst, tcg_constant_i32(desc));
     return true;
@@ -2055,3 +2058,10 @@ static gen_helper_gvec_3_ptr * const fmop4_dd[3] = {
 };
 TRANS_FEAT(FMOP4_dd, aa64_sme_mop4_f64f64,
            do_mop4_fp, a, MO_64, FPST_ZA, fmop4_dd)
+
+static gen_helper_gvec_3_ptr * const bfmop4_sh[3] = {
+    gen_helper_sme_bfmop4a_sh,
+    gen_helper_sme_bfmop4s_sh,
+    gen_helper_sme_ah_bfmop4s_sh
+};
+TRANS_FEAT(BFMOP4_sh, aa64_sme_mop4, do_mop4_fp, a, MO_32, FPST_ENV, bfmop4_sh)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 6021803ca0..12a3a61432 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1105,3 +1105,5 @@ BFMOP4_hh       1000 0001 001. ...0 0000 00.. ..0. 100.         @mop4_o1
 FMOP4_hh        1000 0001 000. ...0 0000 00.. ..0. 100.         @mop4_o1
 FMOP4_ss        1000 0000 000. ...0 0000 00.. ..0. 00..         @mop4_o2
 FMOP4_dd        1000 0000 110. ...0 0000 00.. ..0. 1...         @mop4_o3
+
+BFMOP4_sh       1000 0001 000. ...0 0000 00.. ..0. 00..         @mop4_o2
-- 
2.43.0


