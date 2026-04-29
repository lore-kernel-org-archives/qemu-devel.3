Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD53FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDMI-0002dT-Bx; Wed, 29 Apr 2026 18:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDMG-0002LB-JD
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:16 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDME-0005Es-S7
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:16 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-35da1af3e10so200300a91.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501573; x=1778106373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1EDICl4zi0jKkBOag4nGdDAB1IPyCIs8h1kJ1Hhds8k=;
 b=ZrtkvfbwqPxs4glDMZtT+I6aLQWIRBxKgOGk0rwV0rNhp5l3FdJNE+2UHDdyACMOLn
 RiX9TSVdCZGO0EOPSfodxo4LCAUw3Un9I1QJ4B0x37i9qnIpdgYiv/BlD/sjJjNLyFi/
 b4x4bAh6Urku5DP9rmDZat4vVgxAtzQhLs0NuC6p3c8FQEM3Dl3tpP/nvEemZ8oT1UCr
 ML2Fwn+LH99OLQ9wl5o16hmoCmQOtwdCd+csqfI8QuR9uSaCPVIq8AhY8c5IGLvKgkSu
 hMmATOQkAp/eti63NCf62GYq11+8qOX5qPYjEAbAx//AouyhZTvfRPwjhlEyrOn0hPxq
 pcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501573; x=1778106373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1EDICl4zi0jKkBOag4nGdDAB1IPyCIs8h1kJ1Hhds8k=;
 b=ADsAvOgK2nSAXLEXDrj3ANz4zgeUsjn2putcn/nznBxZA+6rJ7wNIdcYsk6mKj7Q7A
 oCGRvpQjUKTt6xb1RIpsYEjtzSVMzni1ox4gpKOxXJKva7hljpHFmyamY+40+anYCmgt
 6UDoyfu6m3osFi3ONzpKviwTZe/nRzTcoBTvr+7zWMv8ElrqUQKC63H31h4PpcQQtuUN
 C9l+BX8huTmbsqVwZDWCQnDbjO7YFbdAv32DxQU9XBft31AePNQEWD2m81cleYrbY/bj
 ka61NE22A9C7sSuEI+sZ+I4Qcw9fChM0KoejHOpAOcUOPjX5EOXNUNmf+kOXsozrW6rl
 TjwA==
X-Gm-Message-State: AOJu0Yx2Mn+JwQ3mn1ICYDb7UfrysW5s3QKnyHdWezFghREvnzIr2gMm
 1oAZTG6+bF1qk1BxtEcReVKeG/htAPMR/eavZCXmoYjpiUk28CXiYq1DGjQ4SBH9VcZWgomuiV4
 oMPXFWxY=
X-Gm-Gg: AeBDietETEF7epkJLQVadugQstmLHApxKBWwOEgrxdMO7oi8a4qo30WfHAUgbwrnvS0
 kLi/wnLMK6JiLyqglAy4H4ScjBZ9qFcdvXZAKGfUq28Gv89AFKVAYrnki1hTIaXk9PijXy03cOq
 893Vlmt2TX4+nCEAdnfI4/f0DVjPXUVbQtuLk3vFiWrY8RGtmgymw1ossP810yMgzrnIsvJM+sW
 BPp99WUY+wWH84c1MaahkTO5t8eRW6hgxJ/EolT68YxgOWcHu/qS7u58aMOz/b7b2NqA/zGmrb0
 D7iJnqr6TFkoGcx3SdwyAanGkct40a/XBt0fiS2/LOkMlM9runTdNtLE68wqN2pXJoOpsa7aPFg
 iyLt9BzNmZa3nz4Zk7xFbxuMlLenzEGBcU+j4ptes3FRj+jj3xO/eCht4t5pYqeAW8FMHCR1FlK
 UcJgvHLEAviyhtvUWNByDxI8qScpzbzVT+MKxq+9gw
X-Received: by 2002:a17:90b:4a51:b0:35f:ba8e:150d with SMTP id
 98e67ed59e1d1-364c312dcc8mr159451a91.14.1777501572952; 
 Wed, 29 Apr 2026 15:26:12 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:26:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/48] fpu: Return structure from unpack_raw64
Date: Thu, 30 Apr 2026 08:24:29 +1000
Message-ID: <20260429222445.26301-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
 fpu/softfloat.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6cca31af30..99b1cce894 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -633,12 +633,12 @@ static const FloatFmt floatx80_params[3] = {
 };
 
 /* Unpack a float to parts, but do not canonicalize.  */
-static void unpack_raw64(FloatParts64 *r, const FloatFmt *fmt, uint64_t raw)
+static FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
 {
     const int f_size = fmt->frac_size;
     const int e_size = fmt->exp_size;
 
-    *r = (FloatParts64) {
+    return (FloatParts64) {
         .cls = float_class_unclassified,
         .sign = extract64(raw, f_size + e_size, 1),
         .exp = extract64(raw, f_size, e_size),
@@ -648,37 +648,37 @@ static void unpack_raw64(FloatParts64 *r, const FloatFmt *fmt, uint64_t raw)
 
 static void QEMU_FLATTEN float4_e2m1_unpack_raw(FloatParts64 *p, float4_e2m1 f)
 {
-    unpack_raw64(p, &float4_e2m1_params, f);
+    *p = unpack_raw64(&float4_e2m1_params, f);
 }
 
 static void QEMU_FLATTEN float8_e4m3_unpack_raw(FloatParts64 *p, float8_e4m3 f)
 {
-    unpack_raw64(p, &float8_e4m3_params, f);
+    *p = unpack_raw64(&float8_e4m3_params, f);
 }
 
 static void QEMU_FLATTEN float8_e5m2_unpack_raw(FloatParts64 *p, float8_e5m2 f)
 {
-    unpack_raw64(p, &float8_e5m2_params, f);
+    *p = unpack_raw64(&float8_e5m2_params, f);
 }
 
 static void QEMU_FLATTEN float16_unpack_raw(FloatParts64 *p, float16 f)
 {
-    unpack_raw64(p, &float16_params, f);
+    *p = unpack_raw64(&float16_params, f);
 }
 
 static void QEMU_FLATTEN bfloat16_unpack_raw(FloatParts64 *p, bfloat16 f)
 {
-    unpack_raw64(p, &bfloat16_params, f);
+    *p = unpack_raw64(&bfloat16_params, f);
 }
 
 static void QEMU_FLATTEN float32_unpack_raw(FloatParts64 *p, float32 f)
 {
-    unpack_raw64(p, &float32_params, f);
+    *p = unpack_raw64(&float32_params, f);
 }
 
 static void QEMU_FLATTEN float64_unpack_raw(FloatParts64 *p, float64 f)
 {
-    unpack_raw64(p, &float64_params, f);
+    *p = unpack_raw64(&float64_params, f);
 }
 
 static void QEMU_FLATTEN floatx80_unpack_raw(FloatParts128 *p, floatx80 f)
-- 
2.43.0


