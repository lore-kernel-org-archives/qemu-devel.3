Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D3AC02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrxv-0002C2-P0; Tue, 28 Jan 2025 15:13:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxr-0002BM-DN
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:39 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxp-0001c7-Py
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:39 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so67929975e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095216; x=1738700016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JJvh2CDQArR7n30M4Ch/ehHj9L0Hi+xY8HqxWv+z5B4=;
 b=aPge2dHVoeC2k+q6426pEUGWroi+4aKsGjXKDgRbqafvkQZRc6ME0qvBW74W+0n4F7
 Ls5FQHGsEg2bWZsdejKDsCIu424B97kxRbH1h9euN4mNufYVvCb54lGX6AK54/tEvnNz
 1u0oZuRYD+NQd1xh0vN5HO7pQotFH7jZqhEXlaqJpN0l1r/WDVwXdRk2LBZ3lXvW9Geg
 TwHD5poEt69xXsWhBymPxmNNL3WokK66M2F/Cjkv3yHVMvefjV2YoaamDWECFcJKiDMi
 ainqzTeafNGPm/nRF2lBl1rJfug0mzciQuV8ora1XdFRkJiuPpeuUfGxzaypJTdgBPOu
 gqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095216; x=1738700016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJvh2CDQArR7n30M4Ch/ehHj9L0Hi+xY8HqxWv+z5B4=;
 b=A1oFwZavqRIGF+YIspmkkRyk993bT4rHTJ//0Kl/DDJej8r3RHsua8uH6eeEtUhn8q
 9Fdnt0WQvitwr79obKpNGbCIDCnYDSu8biQtCKXFPwoSdjjzAPQ/ExrEfGLqzIb+CpWx
 cI2Wwg4dEE/DGTR1oIoDtXSG+wKIemWIKs7w97LZsgDvrZqBXmMBC/Yd5EzPi5z9ZfQq
 9QbGDWbbf5bGxouk9tJEbXwl9IsT1/JXI9W/hil+hCxvbAWdl9XJv6lXxBTphqOA/sZ0
 Z0IT8VPzXBgd+yGuM31pmKnbbNO/s4Pq3XiWQf7SxEYZiVY3dt6yCk+kjxTgt/Mq8hbS
 sung==
X-Gm-Message-State: AOJu0Yy/AVWVZYszUwJ3+fuasTbWLBRc6lVH+m1DQ53FWiT/NA55MfbB
 NRnHJuswfB/Rv2POfz7BQQC6HPLM5A3RxEg4uMj9HfFuOWjsk4uyEmUJDQkNEBPmi4n9fMNyJW7
 Q
X-Gm-Gg: ASbGncseN+stJG7uPTSTMpyWuys5RDTh4SVBKZSL/LpoHWquhmL6hGDgXNOzkOXRvc0
 tt4pYY2h2nyzsY4msOa80aWT7PIboRm2e0uUOuyEpGcN707HEeBGpusvFtpQVWoiee9NX84GJd0
 aPnVmUmAK7SZ01fQ0k56uOpH5v95XG7+fUi6VKRbLyF/FHN0cK6UMMTiIFnTSz58ngXM8HvlWQ1
 ZWJ4L5N1AFZvrGmlMO/KbHaKh9RohCreUUevQE8CKDp/7uSo8u6IUUff+Wj1Drn3kYS01uRRvWL
 a12FWc1zT8588anee0HfTw==
X-Google-Smtp-Source: AGHT+IGGs3e/0c4/jbYtHY0tY1bByyzhif2n9gADUnQKKyO6rukOAccVkre9OuPiygBRnPWDRgJZNg==
X-Received: by 2002:a05:600c:5486:b0:431:5c3d:1700 with SMTP id
 5b1f17b1804b1-438dc40d3fdmr2290895e9.21.1738095215811; 
 Tue, 28 Jan 2025 12:13:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/36] target/arm: Use vfp.fp_status_a64 in A64-only helper
 functions
Date: Tue, 28 Jan 2025 20:12:56 +0000
Message-Id: <20250128201314.44038-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Message-id: 20250124162836.2332150-8-peter.maydell@linaro.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sme_helper.c | 2 +-
 target/arm/tcg/vec_helper.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

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
index e3083c6e84e..011726a72d4 100644
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
-- 
2.34.1


