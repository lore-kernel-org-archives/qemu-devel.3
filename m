Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340F3C02192
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGZG-00019Q-7e; Sat, 01 Feb 2025 11:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYv-0007b6-22
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:41 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYs-0001OY-VB
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:40 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso22549315e9.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428097; x=1739032897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0HZn+lA/3QK6V9nAt4Z7tzwLTmDhEfAS7cpqC5pJp9g=;
 b=VUP6HWRymnYIEnXF9hAfxggbyE7YeV1FbucPtOPcvWPWWbQiTXendErF0IYwynExr7
 lNSMuYB6fLobAs+OSC9MZ7agXDDlO1mDYPrvnW580F7ZVHV2mtSV2NzOei92q+ac1yae
 YVSIWGqG1ohfmjwd1MLTM/dS7kR5GDQnUuCWaHqPdWCM1d5DINM1vQRukw6M2SufmTDN
 oUtNxysTWrs1kjk/yl/icix5mNfVfO3aI/CDtuKSSbV1QoVTfIEw8QaMbKiVNKEZPmLH
 xnllM73TYyZiXexRXdgq9zrwezC/MfYc4dd/XARCUk4jx/17wq/GJf/tw7oU5gh3cR0z
 9i2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428097; x=1739032897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0HZn+lA/3QK6V9nAt4Z7tzwLTmDhEfAS7cpqC5pJp9g=;
 b=RicaTevek9wv5l5tbLiIHx+uSnV3Bt2P0evV/yTUDrrIEtryDKw1ozJuS0lafm+WxT
 T75U+S/3vo5p9PjV6W1zxKCCwfNYrK1YnEH5J2FHXzcj5VaLgkO0Wt0dKglZnSYiVT8s
 6AFrnFnNtqiv2VOUChMO11TlGZ/8IKr+uCShoqoaDn9Xvb6hA6q8q8wYs2bmD3E6+AtB
 AXSsa1OtyLFqaQJXj8edES4V6Iz+cc8QpHmuGb2W+Lr/urOrPocN6IEB6lbODp9APx7R
 fcrTAVVn3Y4FmXECRfyaYfQwXtgtFOgTvGrgIrwgYgirm0TQyd3RCebHdcaXUDQ514+y
 daXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8egXzvCiVJosvs7Bk8eGpAEZCQx94ydalCQHY3rVxxlllunvUrWdahgbVa24HpqfjtfmwwRssAvVS@nongnu.org
X-Gm-Message-State: AOJu0Yx5a5FzDvonoZvpZ4qBhWobT/oK/gTLHLei6Ch4NdQ0PAdzDWFh
 y1HTO6bSKCMvStPCeE3uBbxTtsNHfb7KMkmvN2euV8rIzFofTfe7yqWbOjD66ZQ=
X-Gm-Gg: ASbGncs2+3msnvEj6xYMkUIMqFm0Ei+anO0J6WSkc8GV1no+jtpISagasCxv+Q9G+gU
 L7L5cPNVdkpG/bPwb3MKm/LcdIoqy/wytukItMSorvhEHBap7duARMlhuCKwYnSC6QnUAFlt7hJ
 TQZi3zbOYbsA695v3jMu/rLQS8qTfq7jyDNh1ZMMRc+W8tazfhcIMaYaD9GGNGQe0w7clwkkuDI
 KRdWwtWwT1lfoBa99PEPcKK+wRSeOnNBrE8rX9Mn7fqfmyqqeAAAWTt2S+eSyeTA9YQcZ50Uw/A
 6IXvrNP1Ol+lPDILovs1
X-Google-Smtp-Source: AGHT+IGbW8wNC8seUIolTMAmlq++D1msXTO1oG/BPaL9NeSB0CUqoE67iUB3VL1H41xPe7GSL6FGtw==
X-Received: by 2002:a05:600c:3c86:b0:434:a529:3b87 with SMTP id
 5b1f17b1804b1-438dc3c2413mr155858565e9.10.1738428097520; 
 Sat, 01 Feb 2025 08:41:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 66/69] target/arm: Simplify fp_status indexing in
 mve_helper.c
Date: Sat,  1 Feb 2025 16:40:09 +0000
Message-Id: <20250201164012.1660228-67-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Select on index instead of pointer.
No functional change.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250129013857.135256-16-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/mve_helper.c | 40 +++++++++++++------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 3763d71e20b..274003e2e5b 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -2814,8 +2814,7 @@ DO_VMAXMINA(vminaw, 4, int32_t, uint32_t, DO_MIN)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -2888,8 +2887,7 @@ DO_2OP_FP_ALL(vminnma, minnuma)
                 r[e] = 0;                                               \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(tm & 1)) {                                            \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -2926,8 +2924,7 @@ DO_VCADD_FP(vfcadd270s, 4, float32, float32_add, float32_sub)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -2964,8 +2961,7 @@ DO_VFMA(vfmss, 4, float32, true)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE * 2)) == 0) {          \
                 continue;                                               \
             }                                                           \
-            fpst0 = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :  \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst0 = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             fpst1 = fpst0;                                              \
             if (!(mask & 1)) {                                          \
                 scratch_fpst = *fpst0;                                  \
@@ -3049,8 +3045,7 @@ DO_VCMLA(vcmla270s, 4, float32, 3, DO_VCMLAS)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3084,8 +3079,7 @@ DO_2OP_FP_SCALAR_ALL(vfmul_scalar, mul)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3116,9 +3110,8 @@ DO_2OP_FP_ACC_SCALAR(vfmas_scalars, 4, float32, DO_VFMAS_SCALARS)
         unsigned e;                                             \
         TYPE *m = vm;                                           \
         TYPE ra = (TYPE)ra_in;                                  \
-        float_status *fpst = (ESIZE == 2) ?                     \
-            &env->vfp.fp_status[FPST_STD_F16] :                 \
-            &env->vfp.fp_status[FPST_STD];                       \
+        float_status *fpst =                                    \
+            &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE) {      \
             if (mask & 1) {                                     \
                 TYPE v = m[H##ESIZE(e)];                        \
@@ -3168,8 +3161,7 @@ DO_FP_VMAXMINV(vminnmavs, 4, float32, true, float32_minnum)
             if ((mask & emask) == 0) {                                  \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & (1 << (e * ESIZE)))) {                         \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3202,8 +3194,7 @@ DO_FP_VMAXMINV(vminnmavs, 4, float32, true, float32_minnum)
             if ((mask & emask) == 0) {                                  \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & (1 << (e * ESIZE)))) {                         \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3267,8 +3258,7 @@ DO_VCMP_FP_BOTH(vfcmples, vfcmple_scalars, 4, float32, !DO_GT32)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3300,9 +3290,8 @@ DO_VCVT_FIXED(vcvt_fu, 4, uint32_t, helper_vfp_touls_round_to_zero)
         unsigned e;                                                     \
         float_status *fpst;                                             \
         float_status scratch_fpst;                                      \
-        float_status *base_fpst = (ESIZE == 2) ?                        \
-            &env->vfp.fp_status[FPST_STD_F16] :                         \
-            &env->vfp.fp_status[FPST_STD];                               \
+        float_status *base_fpst =                                       \
+            &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD];  \
         uint32_t prev_rmode = get_float_rounding_mode(base_fpst);       \
         set_float_rounding_mode(rmode, base_fpst);                      \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE) {              \
@@ -3427,8 +3416,7 @@ void HELPER(mve_vcvtt_hs)(CPUARMState *env, void *vd, void *vm)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
-- 
2.34.1


