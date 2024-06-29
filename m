Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A14C27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 08:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNTtf-0007Kr-JE; Sat, 29 Jun 2024 04:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNTtF-00079n-Ka
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:57:03 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNTtC-0008IS-Fc
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:57:00 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-702052976f7so198503a34.1
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 01:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719651417; x=1720256217;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=97jsLhmY2R6dVuT9X3mKtbkZTIY+9tQnPelHksLdIPM=;
 b=1timoStRytgspliiOjDne/QoOgM+S9QFE6KcZQloZqSBf0UBLfdZOuC33mz3Er5D/4
 VLd/AYA0gciOT0QybKR8yXbno6UeQ7A7GdsL5zyclFb+W6fQrqy9Af/sPXZvrH8vdjau
 CRtir3luzfDsQpUpq9URRarHlg/yG6LsEiIU+8GUIsdkox6S3Gr+sWyb8+RyvJS2cMiU
 X3TTWkdr9dDVmaW50SataUeF9H2mnyAbHVFOFmQac1Af75MLWeiaHQxgp6hCmZ8EYBFm
 g44NipDLic2ZyUqj1HXz+a/UEDbSSNqOMozfaTjW4+N3r/wfX+hWtSV9mUnhEoRkkFhs
 rPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719651417; x=1720256217;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=97jsLhmY2R6dVuT9X3mKtbkZTIY+9tQnPelHksLdIPM=;
 b=pkr5htPCi621THEboyv8ZRRtSxY5xEZH+ttGt+dl4QZBV9umAYxgyB3GjbaGAmBAtJ
 G6X6qPeawXyiC1i4v/yIaj6R0TD9+kqlg6yjxgLbreJPKI/KYpxDBSDwmYMRCMoFSmej
 NMh2BtMjqIjuKqPNHH+KcHaXlAP4TeVNY6QNsSt7sW9Kuj9LnIsSKD6VXrwQnhflWJL4
 S3pOffgzz+ZeYUdd2+V0GtPp0JoWLSSEj7LeD+gVDbsmrPjztBaYX+hDv2uiBLGAjdp4
 z+ZxwzcVzBDLBu8WX9Fdr90CXU9wACpSrH6n6whL+oNqnDvikSkQTAge9U64X9jf7gJw
 bikA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+lWvCG6kAzLA+aHQ6JESNfA/oVVSE3WHfxCqvXD/ajTt+r1R+6C03JDJsRTyssWodpDDnGCyZNnR+E4VbNjIv0mcrvAI=
X-Gm-Message-State: AOJu0YwfRKW5q+3IRHKd3qxlPPY0WaAVM38csS87JNdFHojUYuV4s6Sq
 nQFDzPzOsLYTDiL0ILJUG5CrLB2PIXAcS756XyAvW8M2Uik5A9OcVWfXBNumymYHTG+WgQy8Ue5
 4P8c=
X-Google-Smtp-Source: AGHT+IFUK5Ft5geL5LSQlYzYQXX94NSA6wv+C23mYJ4J9rBGh2QyE8cwS4D5yI/1RyWhIHqRBZRaPQ==
X-Received: by 2002:a05:6358:50c7:b0:1a4:558c:e135 with SMTP id
 e5c5f4694b2df-1a6acf43ec9mr41934655d.30.1719651417166; 
 Sat, 29 Jun 2024 01:56:57 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2c91ce17cc1sm2916847a91.5.2024.06.29.01.56.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jun 2024 01:56:56 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 29 Jun 2024 17:56:33 +0900
Subject: [PATCH v3 7/7] tests/tcg/arm: Manually bit-cast half-precision numbers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240629-tcg-v3-7-fa57918bdf09@daynix.com>
References: <20240629-tcg-v3-0-fa57918bdf09@daynix.com>
In-Reply-To: <20240629-tcg-v3-0-fa57918bdf09@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::32f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

clang version 18.1.6 does not allow specifying an integer as the value
of a single-precision register. Manually bit-cast into float with vmov
first.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/tcg/arm/fcvt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/arm/fcvt.c b/tests/tcg/arm/fcvt.c
index f631197287a1..5263f607b59c 100644
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


