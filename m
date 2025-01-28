Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F50C02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcryt-0003Ev-B4; Tue, 28 Jan 2025 15:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcry3-0002MI-6u
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:51 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxy-0001e3-BN
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:50 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so62161155e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095225; x=1738700025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xFj+2/dmQiz2Y+j8tcsctTOJsa9mPEKYwsoxwSbEAh0=;
 b=LfmN3Tc8/iLZUE2qLgzwcJiS3uYyDLUGcqV2peN9B4+7n0XOuvqji6wSAkAQv29NbO
 Eef5ZSotR7z6/WPESk8a1bjRRRomNOjnVqJXKwlbydBvolu/eiN/PZErob8wNwxCKyT3
 Udaz8D77jHHFxE6bh2C2n9bNAGZ4zMKrbI7E4qVdMJLpItFv/o+T/G2PEhe2DK8ifH12
 +K6GsGJ00D8TnZzARUn53S/DcyUDru3c63Uz8RgxeBHYiSOp9myYnFiVp7qF3StNkYeE
 1V77duWA7DnLuFtKdMEU5wXrxBNeiwjyyMO5wqN5o3UR4yC8ycUaoZ1rj48g/El6hARE
 rIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095225; x=1738700025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xFj+2/dmQiz2Y+j8tcsctTOJsa9mPEKYwsoxwSbEAh0=;
 b=lBcqbQuWIv2gOhaF7vroQa3X07apYjGhVSJOwc1VriaywNoy9KXx32GlwLCXTWEoSe
 TROSScI91b5iJPBueBJwxq62sze83xC1IZF7UQaxCsm+1UtZqcrnFx7gBfUcc4tgAqC4
 UXhYvI8Iv7jwDksDEe5NTljFuvxSeqQDRzFctMiKARJmA+/jlLBH5tSiO1o7wjYPb+/L
 HrQvJjVisfImHn/R9FpAj+QNCzMbRUkEIYRKW6nk0DXbQFrx6aEcvFpG1etyHTn+H6ad
 IHr25Hj06vGcVkDHIi4hw0oMHNC5sfS6yE7J3SV5z6t7Y3y7aNhmyezUqv4NAwFs1D9d
 Uwxg==
X-Gm-Message-State: AOJu0Yzr/q5XmHrLo0x8TBu6Mp259bb/Y95kRFl0eUHoJo6CSjqr+VUa
 qEfBuF8uBN5qmSwr3TBxew1zdRUJQSj3QGcEBSlY4QQfCMkWN82sex0/JKLErwo0YaTcAgTknvS
 Z
X-Gm-Gg: ASbGncsxkfkOq2TmZ8i766QRR3nL7iaYRfbeocm84hBJb3O4WevKKn+IRyPjsBDLcPt
 cf7BDlYXLaGqaFpGEeArtgrepfToE17QTsVlYEl7H3j6LdTVbGzKON0vGhmted04hHoWnDrN0lL
 0xqTofzC5naWHbGvuNEvLT6ONUY8LVfFpG5cpe9VzcAV5hUbBEnyz76Ze3thnCkiu4ocbeYEJp5
 e8+mHxpXnt+YfxKASula/QzkDynl3BM99OYdUnwvsDpNpQeV2fpG+GnZ+7VoiH8e7tnMVvXE6yH
 eTwtHMZAxDjTzdZl1bXGCg==
X-Google-Smtp-Source: AGHT+IEYAwSnoNcI0Mm/yDW+cakIt6t5xSQ4PF5HvkYQd/Pl9JyA9yo/0uo8QYvf8Hb/OmzVqKIGfQ==
X-Received: by 2002:a05:600c:1d1c:b0:436:469f:2210 with SMTP id
 5b1f17b1804b1-438dc3a90f2mr2318265e9.1.1738095224848; 
 Tue, 28 Jan 2025 12:13:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/36] target/arm: Use fp_status_f16_a64 in AArch64-only helpers
Date: Tue, 28 Jan 2025 20:13:05 +0000
Message-Id: <20250128201314.44038-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

We directly use fp_status_f16 in a handful of helpers that are
AArch64-specific; switch to fp_status_f16_a64 for these.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250124162836.2332150-16-peter.maydell@linaro.org
---
 target/arm/tcg/sme_helper.c | 4 ++--
 target/arm/tcg/vec_helper.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 2aad00d3ad9..727c085f374 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1038,12 +1038,12 @@ void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
     float_status fpst_odd, fpst_std, fpst_f16;
 
     /*
-     * Make copies of fp_status and fp_status_f16, because this operation
+     * Make copies of the fp status fields we use, because this operation
      * does not update the cumulative fp exception status.  It also
      * produces default NaNs. We also need a second copy of fp_status with
      * round-to-odd -- see above.
      */
-    fpst_f16 = env->vfp.fp_status_f16;
+    fpst_f16 = env->vfp.fp_status_f16_a64;
     fpst_std = env->vfp.fp_status_a64;
     set_default_nan_mode(true, &fpst_std);
     set_default_nan_mode(true, &fpst_f16);
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 1b1deda9422..7330b373c38 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2067,7 +2067,7 @@ void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
                             CPUARMState *env, uint32_t desc)
 {
     do_fmlal(vd, vn, vm, &env->vfp.fp_status_a64, desc,
-             get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
+             get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64));
 }
 
 void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
@@ -2077,7 +2077,7 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
     uint16_t negn = extract32(desc, SIMD_DATA_SHIFT, 1) << 15;
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     float_status *status = &env->vfp.fp_status_a64;
-    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16);
+    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64);
 
     for (i = 0; i < oprsz; i += sizeof(float32)) {
         float16 nn_16 = *(float16 *)(vn + H1_2(i + sel)) ^ negn;
@@ -2129,7 +2129,7 @@ void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
                                 CPUARMState *env, uint32_t desc)
 {
     do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status_a64, desc,
-                 get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
+                 get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64));
 }
 
 void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
@@ -2140,7 +2140,7 @@ void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 3) * sizeof(float16);
     float_status *status = &env->vfp.fp_status_a64;
-    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16);
+    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64);
 
     for (i = 0; i < oprsz; i += 16) {
         float16 mm_16 = *(float16 *)(vm + i + idx);
-- 
2.34.1


