Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7DFFF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzkI-0000SP-V2; Sun, 26 Apr 2026 09:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjt-0008QF-NW
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:38 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjs-0000JQ-5v
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:37 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso60062755ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210895; x=1777815695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2ikRVouriB7GIa9TEl517IjfNmkcqYdyy4JW83l2dw=;
 b=mbSuGjoGuEKmc1aUkvJegaPXCKAzAUGXu7pTJWJMR0Wf+dmD/dS+4axmgBP1Kb+rTF
 pVotZ1Nh4paI9OAsoSjKTK0XVsa8O9TWgv5NajAwtjJIpLpb1JKOGU5v9sB9ZEXclcXs
 Q3k+WtMe8dngeGyEHlr+FB6dHvyXoqqD77XmBpVEcV6ica1abWSYqA30/sWrf78uUbrp
 NzspjNVqee2arEblY2rypvc5DE3trd2v8stbabPRXpkRUQfo1So4PcGsicUaCO3r+f9C
 oMD2r/jkziigVYYxJKhnnQ+KxN5ITJZ0T0QJCVZRhvixZ+DsLLXynwrexrX56kNvZsls
 n0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210895; x=1777815695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k2ikRVouriB7GIa9TEl517IjfNmkcqYdyy4JW83l2dw=;
 b=OWBr7+cv0BAMwXLgRcPpXq+GL/BOh/ysPbaJGq7uiA1jjMd0ih/MSywPgWQSBmmDVP
 sVKoqOPTsnLFhhFkMpJrwEX/I24keLwTZETw8s/p31Hnh20SI9la7MiiGivX0f41jur7
 ViBDvlUSmqNdeAuo7GUcMSWnHHZ0+5mDA7g4rEVW9lz27O6Qv7u9OcZZrKzYN3LVmEGm
 rXM43x3AitGjW9rC0qVTi3x2TmEVWuEWpdLKhHrSnTuHtJu73wKZw6LdTVGx1ZKFYSeq
 FbnHiBiuYvUEiGLhZsUG3W3nzmkxDjrOB8c1R66ot7CgOwNYDaM9Rbog7jfkb1Bcch2u
 Ns/g==
X-Gm-Message-State: AOJu0YxMXF7UgQyeqtNcF+uGV9nGUOihJ6B690NtriN0+gX5TOnP0EiX
 0lkDOkCCDu8hFYl2vYR8bxC8lVD17PBCXlhv7sBhyy+haNUMjd72lsx21QhkxaWM6zvddlQp99e
 nTRltYVk=
X-Gm-Gg: AeBDievqv1WJkEsn8J/3AbxB5o1y5QAQliupB30BN5wn67QPyPt7eMf4mjzQpK1AHlf
 irQO1xTv+5qU+iw48KxMiCFpxUFLh2NOQj13jjnY0VeL5JJpRWvRKteJmVciHsuY+2fqK2HW/Wm
 pn6LM7s3QSeVvep9iTCIKXVIkeEL/KhqlQuKLaY1uQCYoNvirvDfoSc3/XQIW96SWy12fsdWM5Z
 WGRMF5zTbPqhA/3pEjBDlKlOP3Qq4oYg7I7IqpUdGhG1CJMMq8MOQhRc8WaTeoXk3w4jlwdnbCA
 pS/Nmn6XdNskGk8/+quu3qZWGjwR0LAYcybbF52Dp+Oh+WHW08OL+ugwWpdhdKkm98B9ZMUP1Kk
 kWaFY7+9kY351VuA9YT9qycsjSqDEMfKgHTtcnGD4E1qIYelNehrHI8Yz/TIUTq6ubBO4SK1gdf
 hX9DMfptD+FiF1FKrCORr4LkGEj6aYnF51cciYCguo
X-Received: by 2002:a17:902:7612:b0:2b0:5450:a910 with SMTP id
 d9443c01a7336-2b5f9e95060mr243977355ad.17.1777210894750; 
 Sun, 26 Apr 2026 06:41:34 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:41:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 33/84] fpu: Return struct from float4_e2m1_unpack_canonical
Date: Sun, 26 Apr 2026 23:39:10 +1000
Message-ID: <20260426134002.865628-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Inline float4_e2m1_unpack_raw at the same time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 99b1cce894..c1d0140484 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -646,11 +646,6 @@ static FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
     };
 }
 
-static void QEMU_FLATTEN float4_e2m1_unpack_raw(FloatParts64 *p, float4_e2m1 f)
-{
-    *p = unpack_raw64(&float4_e2m1_params, f);
-}
-
 static void QEMU_FLATTEN float8_e4m3_unpack_raw(FloatParts64 *p, float8_e4m3 f)
 {
     *p = unpack_raw64(&float8_e4m3_params, f);
@@ -1473,11 +1468,11 @@ static const uint16_t rsqrt_tab[128] = {
  * Pack/unpack routines with a specific FloatFmt.
  */
 
-static void float4_e2m1_unpack_canonical(FloatParts64 *p, float4_e2m1 f,
-                                         float_status *s)
+static FloatParts64 float4_e2m1_unpack_canonical(float4_e2m1 f, float_status *s)
 {
-    float4_e2m1_unpack_raw(p, f);
-    parts64_canonicalize(p, s, &float4_e2m1_params);
+    FloatParts64 p = unpack_raw64(&float4_e2m1_params, f);
+    parts64_canonicalize(&p, s, &float4_e2m1_params);
+    return p;
 }
 
 static void float8_e4m3_unpack_canonical(FloatParts64 *p, float8_e4m3 f,
@@ -2699,9 +2694,7 @@ static void parts_float_to_float_widen(FloatParts128 *a, FloatParts64 *b,
 
 float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1 a, float_status *s)
 {
-    FloatParts64 p;
-
-    float4_e2m1_unpack_canonical(&p, a, s);
+    FloatParts64 p = float4_e2m1_unpack_canonical(a, s);
     parts64_float_to_float(&p, s);
     return float8_e4m3_round_pack_canonical(&p, s, false);
 }
-- 
2.43.0


