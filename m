Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523E8FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDL6-0008Na-4P; Wed, 29 Apr 2026 18:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDL4-0008NG-OM
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:02 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDL2-0004VW-Ny
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:02 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c797d5ad36bso79736a12.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501499; x=1778106299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JD52jOp5bj6jLEZLLXiumubTs9BogKD12LDRdezT9k=;
 b=n++NIwSgVh2wETazxQeTqBpnKH/eNpzFubSVSXA71w6XgwVK4QsWSTk7HG9wBpJDkH
 6H1rFGEMRbtFggyX8TcDqkl2bK8SHVkY1N9eEuO9U2gsTFaSLkyrs2DC62bvHNlJSj8f
 IA8rH13s5Vdfz3YXIG4n2bORLua4TucvZI/0iHUvavESqN2Fth5Aqj7PKNCbujgCigJO
 bxg6tnLq9VSl6e6qVXTKhy+b/r+rExIv8o8iq6nwhdXwBhwuXJWauLuxPM4yxB+70Rn6
 t+sfVYYR0y929SYXS1aIrx/UAJitEpN2g0vNWU+MXT01A69fY7IBqnbg0VIGWXUz9ugP
 jqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501499; x=1778106299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3JD52jOp5bj6jLEZLLXiumubTs9BogKD12LDRdezT9k=;
 b=bmfxyJquCAP7pqcCuJbPeJjmEuht4DN8jCww9A4JxLcPlZh57EqUjWXyOiYitYugTd
 CVtgfT2OoO+DQStDsWScsMuog1nXcpAp0S9Kfk2eSu7MZmFjaZL2ASjGK+H3zEU3r3ir
 DCTc0nGkTIhfr4ZXvqqwYH4Q3SRNeFG8JmZLzO1TZMVzqauWvk8rt58aYoZlsfY1BZQt
 6wxAfkWZWQPWRzGzDNgP6pyWHoD8rd5S9wMbkEpM+84MfLGpUaHG3G8QKWOaGEYNOwdU
 m97SZ5fnrsSI4CBz98EqmoVCX1RTJBlwQD8MChGbQYN17oGVqz5z33pBNhhT2kNm2/Jq
 GcIA==
X-Gm-Message-State: AOJu0Ywi7//s4+QJ3gsc+TysIhpU1WfTEmY0lQSlokZ0ioDE49sr/uJt
 PWAsHLUoU44iAODVldyPCNLjxE4ho4aVyUc9OslF6jRj50DjhLNCRwdWR+/pvm6hbn6p57ggN/d
 w2BmP/nI=
X-Gm-Gg: AeBDiesVvfCNBNTUuK/n4X0S9/413OHUbox08UKeS5+ysYRhtbngCygrLTggAc8rR3j
 wqM+PwCuDIJIn9tn/uS+gGZ4n1qx3bXgHbMJqd4KACgseRKf6qQBzGhKpXh5XBJZ69ZcrSCFod+
 QWciUp7mF/kWMtyA/beK357Yk7ONvzpw34HIaEthkjUJl1fGQsRZeDvqavoCPKIFqh6A6kqRjz7
 5clYTSdSHSaI9jVp4h/AsfRB2rddDnOTCvmma/1enMuSU9hUq4ZtpieW6sAlIEZWzQkSe72ge3w
 X40N4QhG8eFSGtt1IZLAjmRnGBeeQbn+BcW8J+cXBllG/HXJmJubuk6wcYa+Kwklu4WqqzvFZCk
 C3VQyCMwVfM7Tl97kZTtfRuacZufVw2rARNcjIEq1aC27rAaL9CKJQz0btx33GIkOYQchFSlnjb
 BX05dLDF7q8hblSvFy6QYLe4vCsprQzBuXbQzwMOoV
X-Received: by 2002:a17:90b:2e42:b0:35f:b9ea:8fa5 with SMTP id
 98e67ed59e1d1-364c30e2dc9mr158307a91.20.1777501499027; 
 Wed, 29 Apr 2026 15:24:59 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:24:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/48] fpu: Drop parts_uncanon_normal
Date: Thu, 30 Apr 2026 08:24:00 +1000
Message-ID: <20260429222445.26301-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Use partsN(uncanon_normal) at the single call site.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 8 --------
 fpu/softfloat-parts.c.inc | 2 +-
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 7c13a7848e..4876a8bb27 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -806,14 +806,6 @@ static FloatParts128 *parts128_pick_nan_muladd(FloatParts128 *a,
 #define parts_pick_nan_muladd(A, B, C, S, ABM, ABCM) \
     PARTS_GENERIC_64_128(pick_nan_muladd, A)(A, B, C, S, ABM, ABCM)
 
-static void parts64_uncanon_normal(FloatParts64 *p, float_status *status,
-                                   const FloatFmt *fmt, bool saturate);
-static void parts128_uncanon_normal(FloatParts128 *p, float_status *status,
-                                    const FloatFmt *fmt, bool saturate);
-
-#define parts_uncanon_normal(A, S, F, X) \
-    PARTS_GENERIC_64_128(uncanon_normal, A)(A, S, F, X)
-
 static void parts64_add_normal(FloatParts64 *a, FloatParts64 *b);
 static void parts128_add_normal(FloatParts128 *a, FloatParts128 *b);
 static void parts256_add_normal(FloatParts256 *a, FloatParts256 *b);
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 3c323c0cec..948eb7bd6a 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -482,7 +482,7 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
                             const FloatFmt *fmt, bool saturate)
 {
     if (likely(is_anynorm(p->cls))) {
-        parts_uncanon_normal(p, s, fmt, saturate);
+        partsN(uncanon_normal)(p, s, fmt, saturate);
     } else {
         switch (p->cls) {
         case float_class_zero:
-- 
2.43.0


