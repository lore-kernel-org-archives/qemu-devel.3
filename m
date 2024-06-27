Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A07CC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpe0-0002Vg-G2; Thu, 27 Jun 2024 09:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpdx-0002SE-I4
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:58:33 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpdv-0007t3-Jc
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:58:33 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f6fabe9da3so64200245ad.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719496710; x=1720101510;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xfjEm1QZECbrFVCphMYb79ZHnIFQxwHobg0g4KA/LWs=;
 b=u0MbdRyUb004QphMSZ0rwKlWYM6ScPEa7JodAGpxqEEVIsjrDWvLR1mmxDS0YaJXAB
 oP4GMgld6mRq8JnteO6z/u06ZZ81GwFcvAoGSjIf664NjQWOaO4ia93zYJrex2Owv+4A
 vAx72GFbgufIAn3OwxRtNmAa0Yhlq6lTXgaNjxZg9b4VZgORNiNfwq+u6d6QB3OayOCd
 eqbkJiI/IoRuDMPai+7SQAPJCd5PKLoWYAwfk3RDeY6fFjkGhrW1GJmmN+mG3V46IsR2
 eB9zcZmhmDhPksu0us3NjAZuOq7h+s8F85XBTIT7pziHxuFDkLReZPFNxIQTwswUWQbv
 5UgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719496710; x=1720101510;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xfjEm1QZECbrFVCphMYb79ZHnIFQxwHobg0g4KA/LWs=;
 b=JkvIY6XSP6rBCFjKk3zDKI9zs2M81X/AvQfOQGeV9SpTWaEicdsZbI7Hf9145eXGDO
 30MHawF9RjvHfsJhSiqhyJAmeP5Ms6zLGniHseNET+BOHhuhGtVZ4rvzON0vRyeqFV+v
 26r2mqXSmQfMCNeCzxbah46QU7LOiKxbvl6OWQhimeK2Vso4LtsV4y4RJmFrsGNVVOpJ
 /X07r0kA+MEYsUxABUph9Ac8LE58ZzWEC73WseDcxrNTR9LalLa//LtekmNsqF7jligt
 mnXHvn4YVH8HClV/QYBM6dxn3FVHD1IqQyWUxfwmaWlV1mM8cKa+9ae9oIBYH31coInj
 8lWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaMjAFbO9Hh3524I2Wy8DgZNx1v6F1RBqbEcXKuDCaWgyxnU5MivqjaFTNskQI8r+fP2FbGh5uf4qakUYioFAQjg9mHC8=
X-Gm-Message-State: AOJu0YzuJ2zV8HyKZWXL/7hwQx2ALvUia7je5I7q4PKAAOfqgoFfex18
 KOg4pgCaduiH1+nC01HSeZOniR5yYrFIS+zWp/OMGxraGX1jwDrFnXAU+fQCS7Q=
X-Google-Smtp-Source: AGHT+IFqsrJNhhU+ItZ1RtuSfKHh3Oqhi7BuzNUGYuUMcdRiFhYGaJCECMYQ9rOAyZURrOQKDlKCiw==
X-Received: by 2002:a17:903:2342:b0:1fa:7e0:d69a with SMTP id
 d9443c01a7336-1fa23f15bf5mr149519925ad.46.1719496710476; 
 Thu, 27 Jun 2024 06:58:30 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1faac8f5a71sm13506705ad.109.2024.06.27.06.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:58:30 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 22:58:06 +0900
Subject: [PATCH v2 5/6] tests/tcg/aarch64: Do not use x constraint
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-tcg-v2-5-1690a813348e@daynix.com>
References: <20240627-tcg-v2-0-1690a813348e@daynix.com>
In-Reply-To: <20240627-tcg-v2-0-1690a813348e@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

clang version 18.1.6 does not support x constraint for AArch64.
Use w instead.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/tcg/arm/fcvt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/tcg/arm/fcvt.c b/tests/tcg/arm/fcvt.c
index 05a27b2d0710..157790e67961 100644
--- a/tests/tcg/arm/fcvt.c
+++ b/tests/tcg/arm/fcvt.c
@@ -126,7 +126,7 @@ static void convert_single_to_half(void)
         asm("vcvtb.f16.f32 %0, %1" : "=t" (output) : "x" (input));
 #else
         uint16_t output;
-        asm("fcvt %h0, %s1" : "=w" (output) : "x" (input));
+        asm("fcvt %h0, %s1" : "=w" (output) : "w" (input));
 #endif
         print_half_number(i, output);
     }
@@ -149,7 +149,7 @@ static void convert_single_to_double(void)
 #if defined(__arm__)
         asm("vcvt.f64.f32 %P0, %1" : "=w" (output) : "t" (input));
 #else
-        asm("fcvt %d0, %s1" : "=w" (output) : "x" (input));
+        asm("fcvt %d0, %s1" : "=w" (output) : "w" (input));
 #endif
         print_double_number(i, output);
     }
@@ -244,7 +244,7 @@ static void convert_double_to_half(void)
         /* asm("vcvtb.f16.f64 %0, %P1" : "=t" (output) : "x" (input)); */
         output = input;
 #else
-        asm("fcvt %h0, %d1" : "=w" (output) : "x" (input));
+        asm("fcvt %h0, %d1" : "=w" (output) : "w" (input));
 #endif
         print_half_number(i, output);
     }
@@ -267,7 +267,7 @@ static void convert_double_to_single(void)
 #if defined(__arm__)
         asm("vcvt.f32.f64 %0, %P1" : "=w" (output) : "x" (input));
 #else
-        asm("fcvt %s0, %d1" : "=w" (output) : "x" (input));
+        asm("fcvt %s0, %d1" : "=w" (output) : "w" (input));
 #endif
 
         print_single_number(i, output);
@@ -335,7 +335,7 @@ static void convert_half_to_double(void)
         /* asm("vcvtb.f64.f16 %P0, %1" : "=w" (output) : "t" (input)); */
         output = input;
 #else
-        asm("fcvt %d0, %h1" : "=w" (output) : "x" (input));
+        asm("fcvt %d0, %h1" : "=w" (output) : "w" (input));
 #endif
         print_double_number(i, output);
     }
@@ -357,7 +357,7 @@ static void convert_half_to_single(void)
 #if defined(__arm__)
         asm("vcvtb.f32.f16 %0, %1" : "=w" (output) : "x" ((uint32_t)input));
 #else
-        asm("fcvt %s0, %h1" : "=w" (output) : "x" (input));
+        asm("fcvt %s0, %h1" : "=w" (output) : "w" (input));
 #endif
         print_single_number(i, output);
     }
@@ -380,7 +380,7 @@ static void convert_half_to_integer(void)
         /* asm("vcvt.s32.f16 %0, %1" : "=t" (output) : "t" (input)); v8.2*/
         output = input;
 #else
-        asm("fcvt %s0, %h1" : "=w" (output) : "x" (input));
+        asm("fcvt %s0, %h1" : "=w" (output) : "w" (input));
 #endif
         print_int64(i, output);
     }

-- 
2.45.2


