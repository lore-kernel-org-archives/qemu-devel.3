Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13517E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1MZ-0007B7-Jr; Thu, 19 Feb 2026 05:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MO-00074E-SD
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:18 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1ML-00062W-73
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:16 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-483a233819aso2430625e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497250; x=1772102050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z+HsSXvuuArtw7MqtuqE1Qn/nOwCvrNl8C8HwnH0cuo=;
 b=lmk9AauWKIFe1i4wtVIKq3hu/vmBPLTWWsjNFlzVx+rCfFz+ueKvUfLtvVrIX6JBZf
 no3c2WfZToQtQHy7rUtLaaSvfqfLbgIN3PPRLn+6EUPvYkpfptjNaBm9ILdRX+5O69/a
 66pyuJ3CN+z/TDmHuX8YqrlMAaufY0sXRJZlqAZUbAIL1S/JB9TOTzDfbbidtL1czkP3
 XtEIiQkZmyVqxy+53FiS3AkFGGtrunSyYEdW3Sf6mMSU3uQ3qWSvflacvH1nzU9eO1AW
 xU/QUpgmEUgTCA5fcrySU1GcZEp0A0DaInyUn1tDlYHh1XyUIKsEFViVZB1EnHs8D2GJ
 TXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497250; x=1772102050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z+HsSXvuuArtw7MqtuqE1Qn/nOwCvrNl8C8HwnH0cuo=;
 b=lzClccr9I09ZEXQVGdOZg9MhYrKlmBq2+/621cTfAmZa7mnIfTS602mSgfWDzzBkcr
 k7b/RBMMTIg6lY/vQbU+pt1qEwb5VVQejvnQQBX/9bYusOIr097EkGU0AWRZ+14hs06Y
 LjF9Moa/LmjVqAhEQJUm+NGol2uUkX309BDFCsXexneQbH6W6UM74tKYz3W8RLqynrWi
 jGh/v/rZpCzlRjjmuJOG40hgDztMkIGvM+HXPfb7liHG5D5nDtzS+fDLA8QrNUWB7ze8
 K5CQ8niRaXTtHiG7bFzoKH/uJKX99mT7YZQlh36Ou9Dk5jM5bADL8z8wJxouaTty4nXW
 4MfQ==
X-Gm-Message-State: AOJu0YyFGmtjvsG5ZeFD21g/T73hGVU8ahJeHf22Md0fSPm7L7S5fKY9
 20TJNrQjtOpNkeIrnP8W7PXmXmUlZDjHsT9/eF+3zGxG+XyGzk8t5OAD8aW9l8RPnWSeiQXombT
 5YyBJ
X-Gm-Gg: AZuq6aI4SmbJckEPiRBtsiioz245e71yTnsF/7KMOO9aeDtwSUTvrfVLrJCfGq434AX
 hl+Dc+K77li1WrQRNu8FwFeY16XrdJhFg9OprHKj4VG3Z52K6aizVTgKHjedWl6okl6B7QRHBdO
 xJ8MCS9og+Nvd+lLa3jINSy1yCndGGUyiZaqTRCc38utmzgI7Z5nN9/VAGWwgQ5XvwyosY7hLB3
 /p5G/Zc29ZFOjOlZj18uTpyk5dNyDmkJhU0AapNsl2vLsjDyXlL0l1oL0f6YBR5j5hZ2rpSAh6z
 ptDsZKsNaWqmdgeCO/YzCnOoaxEzQJMCfjc0DrA6vZBYP7ffyqyK91W0TDMFaNJiffcbmTO3VOc
 P3m6HX/eG1+kqVLSaf4KM/30atXGdT88UnUs18D2tChxzsQdLLSEV1ou2Fy0TLkEk54IEr0aHSU
 fIKzoTnKJiDM2a/9tEfyBmp7BKJoPcyCsNg7hqMmkSGZeY1LWYX5fiA6qLtetuB5hQRURz/aRgd
 fVtofSW4RN0szx72adlfk0dXRPLKHo=
X-Received: by 2002:a05:600c:c492:b0:483:8e43:6dce with SMTP id
 5b1f17b1804b1-48398b6e014mr75039185e9.29.1771497250500; 
 Thu, 19 Feb 2026 02:34:10 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/32] target/arm: Fix feature check in DO_SVE2_RRX,
 DO_SVE2_RRX_TB
Date: Thu, 19 Feb 2026 10:33:36 +0000
Message-ID: <20260219103405.3793357-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

In the macros DO_SVE2_RRX and DO_SVE2_RRX_TB we use the
feature check aa64_sve, thus exposing this set of instructions
in SVE as well as SVE2. Use aa64_sve2 instead, so they UNDEF
on an SVE1-only CPU as they should.

Strictly, the condition here should be "SVE2 or SME"; but we
will correct that in a following commit with all the other
missing "or SME" checks.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-id: 20260202133353.2231685-4-peter.maydell@linaro.org
---
 target/arm/tcg/translate-sve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 64adb5c1ce..81f487152c 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3769,7 +3769,7 @@ TRANS_FEAT(UDOT_zzxw_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_udot_idx_2h, a)
 
 #define DO_SVE2_RRX(NAME, FUNC) \
-    TRANS_FEAT(NAME, aa64_sve, gen_gvec_ool_zzz, FUNC,          \
+    TRANS_FEAT(NAME, aa64_sve2, gen_gvec_ool_zzz, FUNC,          \
                a->rd, a->rn, a->rm, a->index)
 
 DO_SVE2_RRX(MUL_zzx_h, gen_helper_gvec_mul_idx_h)
@@ -3787,7 +3787,7 @@ DO_SVE2_RRX(SQRDMULH_zzx_d, gen_helper_sve2_sqrdmulh_idx_d)
 #undef DO_SVE2_RRX
 
 #define DO_SVE2_RRX_TB(NAME, FUNC, TOP) \
-    TRANS_FEAT(NAME, aa64_sve, gen_gvec_ool_zzz, FUNC,          \
+    TRANS_FEAT(NAME, aa64_sve2, gen_gvec_ool_zzz, FUNC,          \
                a->rd, a->rn, a->rm, (a->index << 1) | TOP)
 
 DO_SVE2_RRX_TB(SQDMULLB_zzx_s, gen_helper_sve2_sqdmull_idx_s, false)
-- 
2.43.0


