Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E370C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht7Z-0002r7-42; Tue, 11 Feb 2025 11:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6L-00075R-MC
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:12 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6G-0003h1-MI
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:07 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-439350f1a0bso19853795e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291222; x=1739896022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mtFos81iXvPrcEy5eIpiIHcH+cS65uHVFuDoQxrR9Fo=;
 b=yjZ4PJsH90l9o08b0YgByHWjIXw7p3T/pcIa4+DUiN7CYNeTFrAYZFN2o+KvV6XYic
 QEthD1kzbMhqO9v40cvblHnPTa8ILR2jlehLVo0kFZqk9gLV4BfQdJY/3w566XVX35Zy
 CIozhPjg2z+cBZepoj/OEzQ7y7IRLE/gNX6/+wUa+ZS8YVJtxda6AU7Z7jmRlczElRE1
 NLmbqVskuQVO2VjE6++HCzhlxZxgrjEL4p4U2XfgInx2g37d3aJ/WR1nlMKC+1ME3fYO
 aB4hvVmgqgyqSpk/8iXCIff69EqhPFks8fPK57jMtYXq5ZTzLkXUiARM5i9W5UXbzIig
 X+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291222; x=1739896022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mtFos81iXvPrcEy5eIpiIHcH+cS65uHVFuDoQxrR9Fo=;
 b=HCZQcYL7+x2Qqf277FZ9+8CQ/tIpk0Lyp4FVwfY31H4JZNuP9L/qez+wf8LRnXtxz7
 322sOXjCqacs7UCmgmOobsyLndtXKH2p1kT3RrmOGXNCCJrX17sD2GbtBsFkFkjpTNjW
 1uJV6T7dRcTU5xIt0R2Ta8Ta7AYc/u/9sed2lDTEbh5uwKEAC/vEuI4bxK5puLe/2wz+
 DJ/XwbAJJEH0Av36KA2UGBvuvOQZgADgj1uUfNWDeSC8ybDVB7jB+Qh8/cD0bvf64m3N
 BtPF2d4sogMuutveeND1f35o5jbCAe7E0xdTB1AsAaHyi7MuN2Du9I/M5XaxCpMVkCYx
 H/Xw==
X-Gm-Message-State: AOJu0YzY2uG76FXgOKvkbMmqaK9u9yIY2L5gOHsNpxuYX4GszWehlsV9
 LZylFT5dYEAukW/+CI2X9CL0rND1itCLfB/xnnbakUSfg1h75acwzPFFTb2jIf9g//TqZkGiEAc
 T
X-Gm-Gg: ASbGncs7D8SFjKdWfZWgy4Mj12UIa4IwKn2E7O9VQ9VnOTtOHikR8ZwyVkMzsAtdVdB
 Dn9xt34da8TLuzPuto/abJpHBHSZGll7VtbIfYoUQdwCk0SJct+qs6w8PLjHgWkOccH6thkfG4M
 ZXyWxm/5zaXk8ejg5c75FZzaa3dMShqLoKmD0lLZrPwZbdrgJ5QY+LTG8hClGj6b9RE0XK2F7yP
 v9QeFu56DI5ZJDSPbSbPFygt45kpqZ9skr35FI/cxzrYY6HL78ojihSSVU22neRtL82SDaFS1yJ
 M37I/vwkgXQ+bWDDDR1p
X-Google-Smtp-Source: AGHT+IE5mVe14u7Oq7sPPmfya6VcGtdbDO1mK9+/G2UiseDhhvpDzur00LUrYwZ31jWgzrdQYo4NXg==
X-Received: by 2002:a05:600c:1c85:b0:434:ea1a:e30c with SMTP id
 5b1f17b1804b1-4394cf08108mr39812555e9.13.1739291222464; 
 Tue, 11 Feb 2025 08:27:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.27.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:27:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 64/68] target/arm: Remove fp_status_a32
Date: Tue, 11 Feb 2025 16:25:50 +0000
Message-Id: <20250211162554.4135349-65-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Richard Henderson <richard.henderson@linaro.org>

Replace with fp_status[FPST_A32].  As this was the last of the
old structures, we can remove the anonymous union and struct.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250129013857.135256-15-richard.henderson@linaro.org
[PMM: tweak to account for change to is_ebf()]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h            |  7 +------
 target/arm/cpu.c            |  2 +-
 target/arm/tcg/vec_helper.c |  2 +-
 target/arm/vfp_helper.c     | 18 +++++++++---------
 4 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0d8b99bd8af..6f6cf5c888b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -687,12 +687,7 @@ typedef struct CPUArchState {
         uint32_t scratch[8];
 
         /* There are a number of distinct float control structures. */
-        union {
-            float_status fp_status[FPST_COUNT];
-            struct {
-                float_status fp_status_a32;
-            };
-        };
+        float_status fp_status[FPST_COUNT];
 
         uint64_t zcr_el[4];   /* ZCR_EL[1-3] */
         uint64_t smcr_el[4];  /* SMCR_EL[1-3] */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f04f28b681a..656070afb59 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -550,7 +550,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status_a32);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32_F16]);
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 215affc2711..2da44ae7102 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2951,7 +2951,7 @@ bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp)
      */
     bool ebf = is_a64(env) && env->vfp.fpcr & FPCR_EBF;
 
-    *statusp = is_a64(env) ? env->vfp.fp_status[FPST_A64] : env->vfp.fp_status_a32;
+    *statusp = env->vfp.fp_status[is_a64(env) ? FPST_A64 : FPST_A32];
     set_default_nan_mode(true, statusp);
 
     if (ebf) {
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index e6b4f63401b..4d1b697a665 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -117,7 +117,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
 {
     uint32_t a32_flags = 0, a64_flags = 0;
 
-    a32_flags |= get_float_exception_flags(&env->vfp.fp_status_a32);
+    a32_flags |= get_float_exception_flags(&env->vfp.fp_status[FPST_A32]);
     a32_flags |= get_float_exception_flags(&env->vfp.fp_status[FPST_STD]);
     /* FZ16 does not generate an input denormal exception.  */
     a32_flags |= (get_float_exception_flags(&env->vfp.fp_status[FPST_A32_F16])
@@ -155,7 +155,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
      * values. The caller should have arranged for env->vfp.fpsr to
      * be the architecturally up-to-date exception flag information first.
      */
-    set_float_exception_flags(0, &env->vfp.fp_status_a32);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_A32]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_A32_F16]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64_F16]);
@@ -198,7 +198,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
             i = float_round_to_zero;
             break;
         }
-        set_float_rounding_mode(i, &env->vfp.fp_status_a32);
+        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A32]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A32_F16]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64_F16]);
@@ -216,10 +216,10 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
     }
     if (changed & FPCR_FZ) {
         bool ftz_enabled = val & FPCR_FZ;
-        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32]);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64]);
         /* FIZ is A64 only so FZ always makes A32 code flush inputs to zero */
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32]);
     }
     if (changed & (FPCR_FZ | FPCR_AH | FPCR_FIZ)) {
         /*
@@ -232,7 +232,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
     }
     if (changed & FPCR_DN) {
         bool dnan_enabled = val & FPCR_DN;
-        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a32);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A32]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A64]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A32_F16]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A64_F16]);
@@ -497,8 +497,8 @@ void VFP_HELPER(cmpe, P)(ARGTYPE a, ARGTYPE b, CPUARMState *env) \
         FLOATTYPE ## _compare(a, b, &env->vfp.FPST)); \
 }
 DO_VFP_cmp(h, float16, dh_ctype_f16, fp_status[FPST_A32_F16])
-DO_VFP_cmp(s, float32, float32, fp_status_a32)
-DO_VFP_cmp(d, float64, float64, fp_status_a32)
+DO_VFP_cmp(s, float32, float32, fp_status[FPST_A32])
+DO_VFP_cmp(d, float64, float64, fp_status[FPST_A32])
 #undef DO_VFP_cmp
 
 /* Integer to float and float to integer conversions */
@@ -1385,7 +1385,7 @@ uint64_t HELPER(fjcvtzs)(float64 value, float_status *status)
 
 uint32_t HELPER(vjcvt)(float64 value, CPUARMState *env)
 {
-    uint64_t pair = HELPER(fjcvtzs)(value, &env->vfp.fp_status_a32);
+    uint64_t pair = HELPER(fjcvtzs)(value, &env->vfp.fp_status[FPST_A32]);
     uint32_t result = pair;
     uint32_t z = (pair >> 32) == 0;
 
-- 
2.34.1


