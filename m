Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB903CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1ET-0004at-59; Thu, 07 May 2026 12:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1ER-0004a4-1S
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:47 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EP-0006xG-32
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:46 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dd73b7c757so588410a34.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169944; x=1778774744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ackMbwyAPdCjYy8OyXqx3EFnvvl4/Re4rU80RDGR280=;
 b=Qbh3v+EbGoVJE35SP87zPmfR06rgqnnK+7c6RK/u9rIUtcrZK4FRIVWUJJCHozJu+6
 y+gvogT4g+MSu5BoWc3VrQ/pT1dhMj/Oab56dm6wW/VE3W6DHu9Z/5C6cPBn5dM7XPKX
 H+Jbgzrg1kq0MgtzqQm07+tSgjpHARjx0qrKBoyXW2XwmzYQWfpwSOZEqN+OiirjBXtN
 D4UXwMWwd488b2LB3Ushvdz5EjECk6ndoVfPo5gFbthejg18W7NXfmUloBJotFJl0A1H
 9tyBWNbnx7Ymklvpvq7bnYN8qTS8FzkQLtNJj1yYsqXI8CKTUv2MXTmjvKZ+Av/0/rq8
 Hrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169944; x=1778774744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ackMbwyAPdCjYy8OyXqx3EFnvvl4/Re4rU80RDGR280=;
 b=cyrPiOSPrMA6pckm0y+vieqTzQ7YLLoFzrBf+TSWFwB3+GOO54YohTsz6Vfh4r1HlP
 +AV9MsVLMIEBooSxaUQGVUJ37qWj3HRPUjSjBjMxTiRWApdDOVLPFxamlwW+nDWcCt6y
 GvFYbKH0rEihrIWASRrIAjI+uuHBRFqHqmViJPJ1/kiXBJhlyjLMAh/HRxYoIv+sYkVA
 4Axhc/UreNR+ya/q39zQpON/Iewq/La61FZ6GnkIhep+w71fiyEN9Nx3x1PDm45aNvxK
 jqam5wyRGrtnbjlrjkEXFpznCx5toorKvCSsMqtEizFHBGGbwO9CgfsZ62In/anWGeiy
 qH5w==
X-Gm-Message-State: AOJu0YzNUDKuKuOaPWEc+ktt5p3tb6xbOaf+lx2S2kIqv6BhnNJqeWyh
 uMcvj3+RozVQDsT9a1vMpGoyni8+eE5GtyiOYPCgMHtC/O4ceKC8YviiRHsWNx4GJIHVuIJrQ9Y
 s8Ohc
X-Gm-Gg: AeBDies42VH1jwZGoggYmn1yK4HO010HmrwqB1fLZhcwYiMXwqQMrRpdyGzxJNMNJBY
 gcd+f9pdTwMGULI+yB43mvNz6KptQ+mps1oA9VglQJA2vqw5NWn0JnqjdsLz13jThg+622GFkyM
 aZK8kjrUtbDIKt6jJ1GuXiZQhSDL/KmNl9df7lY693QRECBCkhraPCPiPCio9eapWSbcaln9Qk2
 j0CJX4uixEpFo8zXl5S2YZmkUVJ4+c12m2y/I5FlfRpM2aZdrtTyYKkvY9rxdjmgL1uKg9MIi45
 sa2i9z/S0LnCZux8FI8M8zTbsUuQtt96Sz5f/lj67wPpA1V4FuiHiNljb31eeppfUiZybQPYkjS
 BI+AHS/hN8eNcR1kBJ+9VPQjQW7/mqexIPJH/C67jsrw85mrMaKFXZwG0F6AR8+df5kaHOn53wm
 FjZtLpYG8ivEIDzUh8rMD03i+u35+311Karz+GUl/PNgy2/3k4KTos+qG1
X-Received: by 2002:a05:6830:a90:b0:7dc:cc70:7788 with SMTP id
 46e09a7af769-7e1def32d7amr5150654a34.7.1778169943595; 
 Thu, 07 May 2026 09:05:43 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/29] fpu: Introduce parts64_round_to_fmt
Date: Thu,  7 May 2026 11:05:08 -0500
Message-ID: <20260507160518.444797-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h |  3 +++
 fpu/softfloat.c               | 22 +++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index 8c3a94bbbc..1876264d43 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -196,4 +196,7 @@ FloatParts128 parts128_round_to_int(const FloatParts128 *a,
                                     int scale, float_status *s,
                                     const FloatFmt *fmt);
 
+FloatParts64 parts64_round_to_fmt(const FloatParts64 *p, float_status *s,
+                                  const FloatFmt *fmt);
+
 #endif
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b71bd49483..b6cf0c8188 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1396,6 +1396,24 @@ float64 float64_round_pack_canonical(FloatParts64 *p, float_status *s)
     return pack_raw64(p, &float64_params);
 }
 
+/*
+ * Round to Fmt while remaining canonicalized.
+ */
+FloatParts64 parts64_round_to_fmt(const FloatParts64 *p, float_status *s,
+                                  const FloatFmt *fmt)
+{
+    FloatParts64 r = *p;
+
+    parts64_uncanon(&r, s, fmt, false);
+    /*
+     * We normally expect uncanon to be followed by pack_raw,
+     * so we don't actually crop the bits.  Do so now.
+     */
+    r.frac &= MAKE_64BIT_MASK(0, fmt->frac_size);
+    parts64_canonicalize(&r, s, fmt);
+    return r;
+}
+
 static float64 float64r32_pack_raw(FloatParts64 *p)
 {
     /*
@@ -5176,10 +5194,8 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
         /* Round remainder to the target format */
         *r = *r_precise;
         status->float_exception_flags = 0;
-        parts64_uncanon(r, status, fmt, false);
+        *r = parts64_round_to_fmt(r, status, fmt);
         r_flags = status->float_exception_flags;
-        r->frac &= (1ULL << fmt->frac_size) - 1;
-        parts64_canonicalize(r, status, fmt);
 
         /* POp table "Results: DIVIDE TO INTEGER (Part 2 of 2)" */
         if (is_q_smallish) {
-- 
2.43.0


