Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4555FC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpe2-0002Z9-Cu; Thu, 27 Jun 2024 09:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpe0-0002Vv-Oo
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:58:36 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpdz-0007tw-3G
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:58:36 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2c7b3c513f9so6037203a91.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719496713; x=1720101513;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BSj5UfHR8CwIYmczT5ogPQso3k+OuOQGUbx+sqgpj6I=;
 b=SLNyWkL6OlQRyWGY+ng8glzyFIEzQ6pIxmWo7p7mJqs1TGdfVxDeq5NpTaT4tVVtE6
 cM6N6Kdwkr72esBiUh7c/4iFodHKl4htybP61V9Sjm2cVVYqjGpjVEyJOSX0PDOXjJYy
 eFM7nwAkjnwT4VR0TFhK/y/N6V9/YQoDgQ6PDZfr3zEl86NNtIxUEFNlWXZYyceCuZOF
 j0f8Hb64aO/WCupW4/hoMEinb/F0TMELG1iZLIMnLGZrlSacanqCetWzne72HSfFxvy6
 iICSPOZvIfbdQaJseefICarA0+SRrxJr+clsYC50783Gxyw+R7+V+vaeFvQXJVLvO+vl
 N1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719496713; x=1720101513;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BSj5UfHR8CwIYmczT5ogPQso3k+OuOQGUbx+sqgpj6I=;
 b=BwZ+cJSyLD9eiG0Prw7IefMi+f5OXTMpfGL2MIcZURDf5ER6wu1W6sDiODy4Ead5iE
 ruUpqb1x+ZivEQB6dq1XjN0FCexEGPECSKjwoxpZ7ownAomQdmoKIFGFszJGL6XwTJsL
 TNUzPjE6GrzbNlypaFlLcfCUBbot8ZRSLfO5Fb2Uste8RaRRz8A+aYVx/YDWDtSoXeSi
 juE3Z1aCkxq34rEQIjDtDvhedQQIu5LrsFqIJsbp6qqZjkZ3d8KsRTFkfTUfWRUKkTdr
 MEPRiHp6LP6QvsHAcJAdKYLvX6Qo+FEN/xl7a1C/iMCERIL/84/oKxLZ6CXCfKsL3UeN
 ifZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXroZTUGEf0oyyFTw4oAW171q0eyx4Hzd2Q3LJLoNS+HcayPQYCYmPZZJ+WsCCnVDecB9HM7qQrcmoSw/8M0/OEtM4PMLg=
X-Gm-Message-State: AOJu0YzXXSkcObQSGTxqgk3kUMU8eFihEz7zw3kN8Rp/lc7YYzmeK4jW
 Vhr2sbBB/acd5e6MdcE0+nYDy2swqmdpyJsgccpImQsLiQ6rJry0ipOeT02zTek=
X-Google-Smtp-Source: AGHT+IEf4dsZHvExAcW6pneOlMn11MrDMqgHOtHTcuA5J99ZmovY/grAUEHy5xK7aX7my2rfIvTWpg==
X-Received: by 2002:a17:90a:ba83:b0:2c7:c6a1:42d9 with SMTP id
 98e67ed59e1d1-2c85067fd85mr10909047a91.49.1719496713609; 
 Thu, 27 Jun 2024 06:58:33 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2c8d81d29desm3636081a91.53.2024.06.27.06.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:58:33 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 22:58:07 +0900
Subject: [PATCH v2 6/6] tests/tcg/arm: Manually bit-cast half-precision numbers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-tcg-v2-6-1690a813348e@daynix.com>
References: <20240627-tcg-v2-0-1690a813348e@daynix.com>
In-Reply-To: <20240627-tcg-v2-0-1690a813348e@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1030.google.com
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

clang version 18.1.6 does not allow specifying an integer as the value
of a single-precision register. Manually bit-cast into float with vmov
first.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/tcg/arm/fcvt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/arm/fcvt.c b/tests/tcg/arm/fcvt.c
index 157790e67961..14c9bb669c91 100644
--- a/tests/tcg/arm/fcvt.c
+++ b/tests/tcg/arm/fcvt.c
@@ -355,7 +355,9 @@ static void convert_half_to_single(void)
 
         print_half_number(i, input);
 #if defined(__arm__)
-        asm("vcvtb.f32.f16 %0, %1" : "=w" (output) : "x" ((uint32_t)input));
+        float tmp;
+        asm("vmov %0, %1" : "=w" (tmp) : "r" (input));
+        asm("vcvtb.f32.f16 %0, %1" : "=w" (output) : "x" (tmp));
 #else
         asm("fcvt %s0, %h1" : "=w" (output) : "w" (input));
 #endif

-- 
2.45.2


