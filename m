Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B926CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUbB-0005H7-RN; Fri, 22 May 2026 14:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUb8-00058A-RF
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:50 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUb6-0005TK-QB
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:50 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3695bf7d082so6930505a91.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474467; x=1780079267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ZFTPhW7lBRWobOEojdZOQ5DeeuW/EtkwycnvXNWaFs=;
 b=YhuNDrjDIqtnefecb3nPQQBKdEjiqxnhoOrrfa1eyhv2/0h9NvLMvHYSCxBubI244Q
 O4KfDwaevHEUd34ZRkokg2pQEvBpcDCm2/aEDLHlvHlidVuLKdkH6NOlfJ3ImY2IbHUn
 E4V9BZYx1ROVK6KtP/WzcgizWN3q8KsA8LI517zEIRhVfr2Ohz1d5Bst3gQM21wWhu3B
 CYYnLfWGfQhSa4Xjv0myHqSbd4OE6CuV6Gfp8XQUsJhkIN1Vo38xDKA06SegNcEjhFtg
 39rvaQl2NxogF6GR1FovGz1eSEIvssViLjW6SWsghbaripeGxpzKyX32NKWiv81C7ZbZ
 hbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474467; x=1780079267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5ZFTPhW7lBRWobOEojdZOQ5DeeuW/EtkwycnvXNWaFs=;
 b=GzNeLL2FQvDZoBXQPmGH94PA+k6yWftJdJ6L19WZtXK81ryhXpFxlWNP0NNGH/jd98
 s+NlId12YvqcPj3gWpXDV3XZmcAB0du82s78DlZ9ui0F1lxv1Oui6tDNoG+pnO7RJ8G8
 tOWyNWiHFIU5mI4Qms0fmVkO4A4uCxo6lvHoYIVQUdu5xTxewDBn7Mt0YitQWMME/Sz8
 Ibs5RWiKUasIjyuID8z9qFJCa80Z4OdDIkF+YU4b6vsp1KYBb2ZkRK5xlfZfZIH7mUES
 TNMyG2M/1gl8u1NyMrUz8btMF+exG+kdAQSedq1+8afneWL4RmpbpEhfs5or3x4MuZ5Q
 uKUg==
X-Gm-Message-State: AOJu0YxZbyhWVaF5n72r2hixPNiHrr+2PtpuA754mZPN0NPFGKdCT6rO
 RFUGSxlA6nkrka+LIcZcs3tyLEfZd68CFQGa94jE4bq1BJBsKakg2Vdupup+RIh/Xkyqk6H2HrZ
 9gyu0
X-Gm-Gg: Acq92OGciAeMdos+GPU5HRp/kyhy5E5TCOWq0FyMLz75wsNjKR6Puhrx+3Yr6Q5mNVl
 C5ate+Zr1u0VglSaXalPBG9S6uSpWJwZyR6rQpDZO42ew80++j93/hNQDBm14oTD5qItVQFPxUW
 mG5KMerZrQQ/AlaI+wB+jQN4DN8FmqQ5UGy2Wwq3riomjzRghMJqBrzV5UdyUoMV9V2bLj3w1z3
 J9Rq11YMD+H4k/zjrUOxV4UBwpJKka1+rC3eVBwCZWnhIqy1vAUaC+FlUd1fUaM83IiN7WaNkVD
 ZVhZjLf4lIbCNpwRt8s1rqahkNSPxWe1d2SxHrLz8Hcxj5sp8stYb1ynx4GnvSLvXCM1ASfpmps
 BW4d+ahGtBLZrS1CGWuayQbqzuZ9IY9mgMBLUOtQnidmN//z9awLN3cbG8EZn1N7CQF+jWNezn7
 xnVpZzLNNHsEtG0RRCYXUMhdJUE8bbuq9mJKPW+I8=
X-Received: by 2002:a17:903:41cf:b0:2be:39bd:8dd8 with SMTP id
 d9443c01a7336-2beb063f20emr54145665ad.33.1779474467202; 
 Fri, 22 May 2026 11:27:47 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/30] fpu: Use accessors for ftz_before_rounding
Date: Fri, 22 May 2026 11:26:50 -0700
Message-ID: <20260522182658.184604-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Drop FloatFTZDetection and use #defines, like we do for
tininess_before_rounding.  Rename get_float_ftz_detection
to get_ftz_before_rounding and move to softfloat.c, as
there are no external users.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-helpers.h | 10 ++--------
 include/fpu/softfloat-types.h   |  8 +++-----
 fpu/softfloat-parts.c.inc       |  5 ++---
 fpu/softfloat-specialize.c.inc  |  5 +++++
 4 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 395ce67abf..d36e3a24b1 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -116,10 +116,9 @@ static inline void set_flush_inputs_to_zero(bool val, float_status *status)
     status->flush_inputs_to_zero = val;
 }
 
-static inline void set_float_ftz_detection(FloatFTZDetection d,
-                                           float_status *status)
+static inline void set_float_ftz_detection(bool val, float_status *status)
 {
-    status->ftz_detection = d;
+    status->ftz_before_rounding = val;
 }
 
 static inline void set_default_nan_mode(bool val, float_status *status)
@@ -198,9 +197,4 @@ static inline FloatSNaNRule get_snan_rule(float_status *status)
     return status->float_snan_rule;
 }
 
-static inline FloatFTZDetection get_float_ftz_detection(const float_status *status)
-{
-    return status->ftz_detection;
-}
-
 #endif /* SOFTFLOAT_HELPERS_H */
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index cf7093fa86..67b7f38aef 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -341,10 +341,8 @@ typedef enum __attribute__((__packed__)) {
  * configure it matches the default for tininess_before_rounding
  * (i.e. "after rounding").
  */
-typedef enum __attribute__((__packed__)) {
-    float_ftz_after_rounding = 0,
-    float_ftz_before_rounding = 1,
-} FloatFTZDetection;
+#define float_ftz_after_rounding   false
+#define float_ftz_before_rounding  true
 
 /*
  * floatx80 is primarily used by x86 and m68k, and there are
@@ -416,7 +414,7 @@ typedef struct float_status {
     /* should denormalised results go to zero and set output_denormal_flushed? */
     bool flush_to_zero;
     /* do we detect and flush denormal results before or after rounding? */
-    FloatFTZDetection ftz_detection;
+    bool ftz_before_rounding;
     /* should denormalised inputs go to zero and set input_denormal_flushed? */
     bool flush_inputs_to_zero;
     bool default_nan_mode;
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 9e823a3ee9..0e5311b50f 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -411,8 +411,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             p->frac_lo &= ~round_mask;
         }
         fracN(shr)(p, frac_shift);
-    } else if (get_flush_to_zero(s) &&
-               s->ftz_detection == float_ftz_before_rounding) {
+    } else if (get_flush_to_zero(s) && get_ftz_before_rounding(s)) {
         flags |= float_flag_output_denormal_flushed;
         p->cls = float_class_zero;
         exp = 0;
@@ -463,7 +462,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
 
         if (is_tiny) {
             if (get_flush_to_zero(s)) {
-                assert(s->ftz_detection == float_ftz_after_rounding);
+                assert(!get_ftz_before_rounding(s));
                 flags |= float_flag_output_denormal_flushed;
                 p->cls = float_class_zero;
                 exp = 0;
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 0b62b0e907..bd6984282f 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -84,6 +84,11 @@ static inline bool get_tininess_before_rounding(const float_status *status)
     return status->tininess_before_rounding;
 }
 
+static inline bool get_ftz_before_rounding(const float_status *status)
+{
+    return status->ftz_before_rounding;
+}
+
 /*----------------------------------------------------------------------------
 | For the deconstructed floating-point with fraction FRAC, return true
 | if the fraction represents a signalling NaN; otherwise false.
-- 
2.43.0


