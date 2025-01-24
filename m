Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3B9C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMZ7-0005aR-Ri; Fri, 24 Jan 2025 11:30:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYG-0003m3-Ik
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:01 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYB-0005Nl-3T
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:28:58 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso25526475e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736127; x=1738340927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4jWmHkLkE0PYmSdvm4vatXKXqnaGihoCx12P90WWE9A=;
 b=dF002bzsfqv2LkDtcFRWO5X806u1sptlVisz2GLzFEliJ3YFXH83JRC0mLt67tNa9B
 5x3Ag+ReoWVzr1uuAvAxD2v097JE8p5CJ0xvuiFgH+/wzYhsjz8pwhLbSSIeQ/ZbpRbm
 g3luSMxy5kzAVkE5hev6v2QFDfLdy/OoF0psaw4T2DBttmNi6jBPkxcI8iVNkf6T/jSP
 MQLubhupNVK6PTaW1S/3sHF/d+nIaTrXdnIiLw4SIZoba5mDOTDAo19CvuZ2dCysJkvy
 5TFNPBTp0Vaq/gD4bCxNzSt6vsognTi41a58plMLcMqUfM+iwfp5QXBOALGRFpTRsX7k
 D34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736127; x=1738340927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4jWmHkLkE0PYmSdvm4vatXKXqnaGihoCx12P90WWE9A=;
 b=alJXm5bkt16KIVfe8cpcY60HWQ+Y2PkKBG0cIQJPAl2PqULKWfiTtWIbFGMFWd/kBa
 u+oV+EhGuRmQrUFlHYFOwM9G/iJtaGNwJJAh96YbckwpH3/XwcHBqXULs7FH0zyzJ3b3
 toZ87yvLklntLMrd0k/S1JAoTdWsmgulfucq/rU7w8NoZvrHOm7+PrTTPpvCxsSRZ0TG
 QQol5oonN/GTm1MJrfyvqKjoYpQvBhgp3sh/90CN+H4Al63ji4vZvBxuWc+Kiyek+csn
 YrrPUfG4xe/UPBgwG0jKjkZYciUeVFO7HggQddXwB/jsPLBm91oMvnq5xAZNNDyXJaBa
 9lvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7FRAcrVdJfOCKN4Z5W5wvZdxc4v13TbSdBHxNiieWg/Jnr9FgdidEnvvQfAf2nOVz/CBf5EuLnzbe@nongnu.org
X-Gm-Message-State: AOJu0Yx9Z5o2fGerW4vxpm53eb5RwQqRtDpHibN7U6lLkMx93idKPCvV
 TGfWQt0VUCSzqvXEYPk8Gwfz5LM3WXklUQ6jL+CsLhCqzc+hBmfQAa/tamWY9rYBDadvPdwYkLv
 3
X-Gm-Gg: ASbGncv/S0VbNfcruAdG31N1FBXlh0jS9Aef8Jp8hvgPBMIimlRj5ZUG9EqGn+RR6wl
 dEkzqNAOReJv/GUnofJXohWIfuQljpdfhsDXZ2RH/5IZ1mRNNxsaSRZB7/yofIppR+EwIN4bXnE
 1oHS25SVkgMoWInGEpz4jx9mQ1NqSW4zSTuf87hIY5MsZ1cHpoTOp1Oo8KSCxJposRVW9nW5Q2t
 PxYWRUX1KSzZmX+lu+PE8z24Lg+cmFZqORarSk7yLKzUHAnGDsbb/vULnn34p6PsGd8hFc350qA
 NxAWgIcN+NY=
X-Google-Smtp-Source: AGHT+IHc49pUDErnnXFyMUHUs9WGkdyZTvYYnDkN5Y6pbTs2LVF9qwD3/rUmGs35kOW6soFzhm0PiA==
X-Received: by 2002:a05:600c:1d1d:b0:434:a815:2b5d with SMTP id
 5b1f17b1804b1-4389141c211mr253290065e9.24.1737736127353; 
 Fri, 24 Jan 2025 08:28:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:28:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 07/76] target/arm: Use vfp.fp_status_a64 in A64-only helper
 functions
Date: Fri, 24 Jan 2025 16:27:27 +0000
Message-Id: <20250124162836.2332150-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Switch from vfp.fp_status to vfp.fp_status_a64 for helpers which:
 * directly reference an fp_status field
 * are called only from the A64 decoder
 * are not called inside a set_rmode/restore_rmode sequence

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme_helper.c |  2 +-
 target/arm/tcg/vec_helper.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index a0e6b4a41ea..2aad00d3ad9 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1044,7 +1044,7 @@ void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
      * round-to-odd -- see above.
      */
     fpst_f16 = env->vfp.fp_status_f16;
-    fpst_std = env->vfp.fp_status;
+    fpst_std = env->vfp.fp_status_a64;
     set_default_nan_mode(true, &fpst_std);
     set_default_nan_mode(true, &fpst_f16);
     fpst_odd = fpst_std;
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index e3083c6e84e..44ee2c81fad 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2066,7 +2066,7 @@ void HELPER(gvec_fmlal_a32)(void *vd, void *vn, void *vm,
 void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
                             CPUARMState *env, uint32_t desc)
 {
-    do_fmlal(vd, vn, vm, &env->vfp.fp_status, desc,
+    do_fmlal(vd, vn, vm, &env->vfp.fp_status_a64, desc,
              get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
 }
 
@@ -2076,7 +2076,7 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
     intptr_t i, oprsz = simd_oprsz(desc);
     uint16_t negn = extract32(desc, SIMD_DATA_SHIFT, 1) << 15;
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
-    float_status *status = &env->vfp.fp_status;
+    float_status *status = &env->vfp.fp_status_a64;
     bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16);
 
     for (i = 0; i < oprsz; i += sizeof(float32)) {
@@ -2128,7 +2128,7 @@ void HELPER(gvec_fmlal_idx_a32)(void *vd, void *vn, void *vm,
 void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
                                 CPUARMState *env, uint32_t desc)
 {
-    do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status, desc,
+    do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status_a64, desc,
                  get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
 }
 
@@ -2139,7 +2139,7 @@ void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
     uint16_t negn = extract32(desc, SIMD_DATA_SHIFT, 1) << 15;
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 3) * sizeof(float16);
-    float_status *status = &env->vfp.fp_status;
+    float_status *status = &env->vfp.fp_status_a64;
     bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16);
 
     for (i = 0; i < oprsz; i += 16) {
@@ -2808,7 +2808,7 @@ bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp)
      */
     bool ebf = is_a64(env) && env->vfp.fpcr & FPCR_EBF;
 
-    *statusp = env->vfp.fp_status;
+    *statusp = env->vfp.fp_status_a64;
     set_default_nan_mode(true, statusp);
 
     if (ebf) {
-- 
2.34.1


