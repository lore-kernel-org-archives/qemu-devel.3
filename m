Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71979C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQny-0002WS-8K; Wed, 26 Jun 2024 07:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQno-0002EJ-Kv
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:27:05 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQnm-0001sp-Up
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:27:04 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-25d10a838f3so1497011fac.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719401221; x=1720006021;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xfjEm1QZECbrFVCphMYb79ZHnIFQxwHobg0g4KA/LWs=;
 b=lCGJRS+/rX7W/BaJjOmzorI4qcff9MofydInZe9+Gc4eqVXp8D9dXOQE0TJUIdTIz/
 2W6RpYR4R8uczsxoIWHwZD+QhyQloR1L0qvQxZ3spKrehFmvx5nEiE4XTc3OKFp4DrYm
 M74eGjzGUP8FZqW7nRB+S/EWNOolmcuZpTCT/nNnJcy4ISpPHNpnFtvyP1XvOaNr8vcQ
 4Rv/+4FlW00eTOFcnWahB8LaH5L3dloQA1Yy4+NYIN2346RhEYUF0Mt5ve+Q+LwErYjk
 dvNjh0TbnTmyP6NFMYLsrqQXIzJzQg1VsY3no+YAtRaW5IClhZofWmNgUoI4F7sz+6Nn
 UbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719401221; x=1720006021;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xfjEm1QZECbrFVCphMYb79ZHnIFQxwHobg0g4KA/LWs=;
 b=KjNBSL28IrleykzYz86wLfhenrb05V3cc/pvds3ug6V8MuBsNmeCEB0CAg2jSmjgPS
 tTCJXvAQrBZaFOZxMxKWp4luGz6BR43aQFVNy6QAtUGcNFusRjUzAWBW1Qsldf+SZXpy
 iHec7ATn8XSP2eIbeWJhVjbu4QULlspSJCahAMZ62/BbyseyKrXzYeow5J6CrrRi9Use
 luxmWlfoLZShTEI/9heUa9UsY1Uh+F9vCET6esmt/IWWXU1pEyDTJtQxB+GaQgSgvt91
 6SmVUOSJIlaJfubdz60O12486VdPr+1IDdhndFJwdV9jPgQJOTofTk/9DrRy6YzYEBDT
 0ojg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX51RoLGzOnoZXIYcI1Xg6cyS2JJ9Tz495CQtdVlvaHsSWlON+81RcqqIGNGd88YC6K0/4Fbiw+qCdtOD2g+n5H/lO+JUo=
X-Gm-Message-State: AOJu0YzPyRdd80NoEDbq9AGOTYhZbpCbewaX2aiqN6ERXWg9EzkoAmXI
 ULeT4YL88zQGruvwQz9Dl+wLoP//8Vexdow4p2F32cQpXxS0luoGBYtdfevn+ic=
X-Google-Smtp-Source: AGHT+IHCTWGhid60BmDoQXaWM5yEVeNFcG8uup6veBIcsTs7QXA4WaEYzeRPZ+8Tlgb7/CPIM5t46A==
X-Received: by 2002:a05:6870:4208:b0:254:c08d:cb55 with SMTP id
 586e51a60fabf-25d06bc8191mr11281742fac.5.1719401221565; 
 Wed, 26 Jun 2024 04:27:01 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-706513141ddsm9740402b3a.216.2024.06.26.04.27.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:27:01 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 26 Jun 2024 20:26:26 +0900
Subject: [PATCH 5/6] tests/tcg/aarch64: Do not use x constraint
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-tcg-v1-5-0bad656307d8@daynix.com>
References: <20240626-tcg-v1-0-0bad656307d8@daynix.com>
In-Reply-To: <20240626-tcg-v1-0-0bad656307d8@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2001:4860:4864:20::31;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x31.google.com
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


