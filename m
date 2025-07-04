Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2B2C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjE9-0008Pa-BC; Fri, 04 Jul 2025 12:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE5-0008N7-Q6
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:25 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE3-00068q-UB
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:25 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so926873f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646322; x=1752251122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=njexzeEwTl1IgweqmLo6Yd5YtbXtihlIHLkI1jD0mCQ=;
 b=z6nwQnHeyu0VjEKAk6XgF5GydpyFXA8lkgomsd9KstVy4/Gr0a3NhuaaoMx3RFo2/I
 8MYc1+3LdMmS+EYG256PwoTuhle17Q+VoWwmKZNRxmBKp9Kf+wpaW6ei94FnH+hzZzWn
 H+WjQA3GZ6on4DaJ6T3EB8nkQ2CrlTkpD1lkYbWp+5L/Do1eU6mgatuL1gk6xT7JGcu7
 mLbNB5e3C2+gM/6PkpPtJC1KFdHGfcppZhgTAQY6I5R5uYugndULDxqwF1ZoSFS8H+rQ
 B3Q6m1D1QoYIZx+3oEJtDj93csNHODarpyT8TkP0advKhEzRUEVWq6TAyvlBtdsrcDX9
 +6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646322; x=1752251122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=njexzeEwTl1IgweqmLo6Yd5YtbXtihlIHLkI1jD0mCQ=;
 b=Ec7X6hXUorPsvvmbzgJx92UmQ+2+bHbKdHgOeswYWWNp/41KdBK7mAkKnxMzHwp3e6
 bf+4xLDlMDmyVagm/bmdckNzM5pX6Hy/Jzv3z4Tkc/m5IPT67SbdGLvSkj0rqA2N5oZR
 ttoGzoW+3Z3NZdMIpn8dL7KIQe7q9n4wtxiM2dkhH3HYVG6kWRY1K8qvcWJVgI6Sa+qb
 DujWSas5N8phIDOtgRo4QGjaqFcRqjFuBEPqTFByxG+J8H/FLEYUhCiF+CHwyRUOBGDN
 S/go291iCXroFZcPPSHHp+Fb+7X8yF2/VcP9f02DU/vObaCiRy/a+CvwUIezHayDrXg4
 tQRA==
X-Gm-Message-State: AOJu0Yyz9coRtoaY2uZLCCanxrFlVobEKACqPY52f6XQ0gOE5m0rT0YY
 ts3uajXHsxXp4tIrwG3dl0VQUlXmlKSsHCsBFXPFV7bX100MjaYlSo7gXFVT2y1cjAEs5dADg9w
 NUKVD
X-Gm-Gg: ASbGncua5Uib9BPHToB/WlWsJpMnU64wefclczF0jpI+Ut6pZqrHG20sHDOpwxZRYJO
 QYjrVXDYRSCimsW9aJD4R1GsnVPJLQna6pdAjyec8rJuyQmmYGckBIJoD87d9JgMojNMXqADEIg
 xk56144dlBzixaS2WXig7n44cwHaiO9t/3ykNBNLZwmf8IJijJJuGRR/BzIW1R52wwIPzmDAylV
 T9S4mLlYgp+oE5mpaBn3rFtD1lXmniR+rUO8TSrqnssu+Kn+F6m8//435PQMEBd222S6N30VCyo
 h4CgGzv6uRgrpcIh+BvXYZ3EqhUbDcTB7XwvqMBhh0PeW0V2knNgKJB5oql/xTR1jTeO
X-Google-Smtp-Source: AGHT+IG3F6pFHHD3TMwlTmFsxdp0NvLZqACDN7HXLBq9tguwQdXn89iBGuD8ylqjay3Jd34Woe9TdQ==
X-Received: by 2002:adf:9d8c:0:b0:3b3:1e2e:ee07 with SMTP id
 ffacd0b85a97d-3b496626856mr2377504f8f.56.1751646322420; 
 Fri, 04 Jul 2025 09:25:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 021/119] target/arm: Fix bfdotadd_ebf vs nan selection
Date: Fri,  4 Jul 2025 17:23:21 +0100
Message-ID: <20250704162501.249138-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Implement FPProcessNaNs4 within bfdotadd_ebf, rather than
simply letting NaNs propagate through the function.

Cc: qemu-stable@nongnu.org
Fixes: 0e1850182a1 ("target/arm: Implement FPCR.EBF=1 semantics for bfdotadd()")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250704142112.1018902-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/vec_helper.c | 75 ++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 22 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 986eaf8ffa4..3b7f3088033 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2989,31 +2989,62 @@ float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2, float_status *fpst)
 float32 bfdotadd_ebf(float32 sum, uint32_t e1, uint32_t e2,
                      float_status *fpst, float_status *fpst_odd)
 {
-    /*
-     * Compare f16_dotadd() in sme_helper.c, but here we have
-     * bfloat16 inputs. In particular that means that we do not
-     * want the FPCR.FZ16 flush semantics, so we use the normal
-     * float_status for the input handling here.
-     */
-    float64 e1r = float32_to_float64(e1 << 16, fpst);
-    float64 e1c = float32_to_float64(e1 & 0xffff0000u, fpst);
-    float64 e2r = float32_to_float64(e2 << 16, fpst);
-    float64 e2c = float32_to_float64(e2 & 0xffff0000u, fpst);
-    float64 t64;
+    float32 s1r = e1 << 16;
+    float32 s1c = e1 & 0xffff0000u;
+    float32 s2r = e2 << 16;
+    float32 s2c = e2 & 0xffff0000u;
     float32 t32;
 
-    /*
-     * The ARM pseudocode function FPDot performs both multiplies
-     * and the add with a single rounding operation.  Emulate this
-     * by performing the first multiply in round-to-odd, then doing
-     * the second multiply as fused multiply-add, and rounding to
-     * float32 all in one step.
-     */
-    t64 = float64_mul(e1r, e2r, fpst_odd);
-    t64 = float64r32_muladd(e1c, e2c, t64, 0, fpst);
+    /* C.f. FPProcessNaNs4 */
+    if (float32_is_any_nan(s1r) || float32_is_any_nan(s1c) ||
+        float32_is_any_nan(s2r) || float32_is_any_nan(s2c)) {
+        if (float32_is_signaling_nan(s1r, fpst)) {
+            t32 = s1r;
+        } else if (float32_is_signaling_nan(s1c, fpst)) {
+            t32 = s1c;
+        } else if (float32_is_signaling_nan(s2r, fpst)) {
+            t32 = s2r;
+        } else if (float32_is_signaling_nan(s2c, fpst)) {
+            t32 = s2c;
+        } else if (float32_is_any_nan(s1r)) {
+            t32 = s1r;
+        } else if (float32_is_any_nan(s1c)) {
+            t32 = s1c;
+        } else if (float32_is_any_nan(s2r)) {
+            t32 = s2r;
+        } else {
+            t32 = s2c;
+        }
+        /*
+         * FPConvertNaN(FPProcessNaN(t32)) will be done as part
+         * of the final addition below.
+         */
+    } else {
+        /*
+         * Compare f16_dotadd() in sme_helper.c, but here we have
+         * bfloat16 inputs. In particular that means that we do not
+         * want the FPCR.FZ16 flush semantics, so we use the normal
+         * float_status for the input handling here.
+         */
+        float64 e1r = float32_to_float64(s1r, fpst);
+        float64 e1c = float32_to_float64(s1c, fpst);
+        float64 e2r = float32_to_float64(s2r, fpst);
+        float64 e2c = float32_to_float64(s2c, fpst);
+        float64 t64;
 
-    /* This conversion is exact, because we've already rounded. */
-    t32 = float64_to_float32(t64, fpst);
+        /*
+         * The ARM pseudocode function FPDot performs both multiplies
+         * and the add with a single rounding operation.  Emulate this
+         * by performing the first multiply in round-to-odd, then doing
+         * the second multiply as fused multiply-add, and rounding to
+         * float32 all in one step.
+         */
+        t64 = float64_mul(e1r, e2r, fpst_odd);
+        t64 = float64r32_muladd(e1c, e2c, t64, 0, fpst);
+
+        /* This conversion is exact, because we've already rounded. */
+        t32 = float64_to_float32(t64, fpst);
+    }
 
     /* The final accumulation step is not fused. */
     return float32_add(sum, t32, fpst);
-- 
2.43.0


