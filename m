Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E87C27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 08:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNTti-0007dI-Ay; Sat, 29 Jun 2024 04:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNTtJ-0007Ag-N1
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:57:08 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNTt8-0008Hw-SE
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:57:05 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-24c9f892aeaso676157fac.2
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 01:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719651413; x=1720256213;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z8HgGEOBQa+ts6D6zeqb5tjF5rvOazu3EqyYr1aPQyY=;
 b=NFkf5I5hBqFqdse84FHgzsUrSN0Hp2UzdxfOrCsOEBmthlNoVaC1+VqWnHgXkRF3aA
 xr/eT1AO7TWAlSO+Ske7JiOd7fdUqQZ43/SewQ0AD3A/JMKq8R7Gty+YEb4Y3wLP2p0w
 YAcht11CigDpps4rbB+rIjSk1vBdHlRcEnBxKElTF8XrTG+ZAs55Ar0+PGhDm4CuvBxl
 wUgrtsndj4lkINoYfI/VgXxxMxYlcTM7wm0ikds3LiSjphXlLCHk+/YZKEhyyzMz+PSE
 mEIdtkOPqK+bPCJFQiD53u6G9+FwVXxMpkeIal8KqfCYN23MrsdZjKTH+IScHOy5FRXZ
 ot+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719651413; x=1720256213;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z8HgGEOBQa+ts6D6zeqb5tjF5rvOazu3EqyYr1aPQyY=;
 b=jWjuUhFfyn+1r9m3vmueYTAxPDSIzbSdDJwKGeFUrjs88taphubtjw0RTmr0QnDlcT
 G+FPhQg2WC5iFZH5CnY11Hxz7+kF3nB+NE90CjOdrJ1vuNpGVufcsaI8geBVJTt25ce1
 zfYLE9+fL+lbgbbjYij6EgVGn7+BnFIKyQLLWMIogz7/lgiV5/hek8CR+FJScymc/p0X
 dbqV67cvxG1Yw4doG+aMPW/w6kJpvYHWmzACvgWDWIYUYCHjuunrnOpdP4qb2aQNcA0W
 S+JkqrgPMiWsdeEyRuvFYKAL+qZYCzhuejA4Cb0/4WVULxnJIXABhqupIe5iX3/ManO6
 rXmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwvq78nr+8jy8wSH1/p7vppa92Mf/JLBWJ0g8Uiu6PBdx0/HFKKZ9w2bCW6mxwt+ceTCjiK8gPCnellppNTtroTsgum1E=
X-Gm-Message-State: AOJu0YzVhCp6LHh+Uc6/F71cQXhzC8N0tKmCYB0TYonICifeXPTgYJnI
 Zjfn7SCpN6YvGNCMRQzRJnQD5d8qgNTi1RWrKawqB176JfhsU+vg+CbkHliYLUjYcQR6hqDjifG
 /V+M=
X-Google-Smtp-Source: AGHT+IG8ZwO6MrrDO7Z72RbL3yoQXd7KyuMYXHm1G0w3fOjKBz5jjYNFdokqBupgz4xk2mjkg/x+YQ==
X-Received: by 2002:a05:6870:1654:b0:25c:b7f4:39ad with SMTP id
 586e51a60fabf-25db362fdc4mr361788fac.58.1719651413378; 
 Sat, 29 Jun 2024 01:56:53 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70802567926sm2864444b3a.54.2024.06.29.01.56.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jun 2024 01:56:53 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 29 Jun 2024 17:56:32 +0900
Subject: [PATCH v3 6/7] tests/tcg/aarch64: Do not use x constraint
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240629-tcg-v3-6-fa57918bdf09@daynix.com>
References: <20240629-tcg-v3-0-fa57918bdf09@daynix.com>
In-Reply-To: <20240629-tcg-v3-0-fa57918bdf09@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2001:4860:4864:20::2e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/arm/fcvt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/tcg/arm/fcvt.c b/tests/tcg/arm/fcvt.c
index 7ac47b564e24..f631197287a1 100644
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


