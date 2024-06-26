Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEB4C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQnz-0002Yp-Uu; Wed, 26 Jun 2024 07:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQnx-0002SM-3z
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:27:13 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQnv-0001tt-5F
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:27:12 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5c2201ffb1bso368274eaf.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719401224; x=1720006024;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BSj5UfHR8CwIYmczT5ogPQso3k+OuOQGUbx+sqgpj6I=;
 b=s629ktp9EQqkEQ6LSBi7/ErphD1Ojr4Mv0wV6yY03EplYc944gdn4ftFFusDsUFaf4
 S5HMKFztC7lEq1vnkd/lqCxQesEPZN/XccmLrLcO2ilVfKfF1drLbBEt/PHHclUDIdLN
 UumQonkaI4nDy2YUFU7CX/na3z6MhVbpe9RSulICG3+CeJGcB6oxftqkQucJ+3gyNrCQ
 2vr98ufYuDDBJ17kft2Cz92igtK3IJIhOaI45ys0PAibOIugR+hR6o6SHxCJsOVYqKwi
 UaVJoYkMbEZ0AkWWYyjFEhO7KrB2efw2wG4MuDzL77NHi+yOD/trbSBP68d8k7Hz5Bc5
 jLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719401224; x=1720006024;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BSj5UfHR8CwIYmczT5ogPQso3k+OuOQGUbx+sqgpj6I=;
 b=WyvRRySQHqm7lMaGqHJ1qKX59U+kheq2RsoUf7KpfeHmAN9tyBgP88nSMmTSi5iTp4
 HIBkh4+OCiwkVLxZFUXWT3EXq9mf8IlZp0cmdmbL1xWw/0NEzgGEKX7X0ek5JdjWQpBO
 flsobDLvoSUUssNf8mEhjEFArqr5btgHgszH70ip+FtKlLxFR0IFXNWOXglloKSFDTcm
 UyX2BruyaLcEoYKYkIcILecSRss77svwAgOK9prxO4OElrv3BuX8kcwqr/3Q7VbdnGKU
 /YfpEjr5svGq1ZVFX5m77JMTHxXm741n+7z+gnB7jnAvwQbD/AlKl+MYJbhc6DrtXv1v
 Z6fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+RIbKe1/GjHf1NzhchWG6MkfieDh+EUPUGsZqo59R/jvgze+UaHUT7LXcp46J0Xvco+NiNAnhPGpWL3g7K71fAVmWGGQ=
X-Gm-Message-State: AOJu0YxEFxyNAJHITFaEOUhezn0CjMCVLRmLQJI+fYAU3lPDXwwVh6fZ
 WSMqxsDql2aCgtdBnWC4ugEVD5RLQ4CpLnd2LKjcyOo8d8MfDC15SsWLNkf1ffpWD+mMb8AfIag
 qb7E=
X-Google-Smtp-Source: AGHT+IG+FC24q1AF6D7gnESB8/FtnthpDKghgR8dR0bxYc/YVumjlK4PYIei3thRdqHzl6oUAPrNCg==
X-Received: by 2002:a05:6358:7e88:b0:1a4:617d:6fea with SMTP id
 e5c5f4694b2df-1a4617d7377mr491649455d.6.1719401224319; 
 Wed, 26 Jun 2024 04:27:04 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7183c48e59esm7745940a12.3.2024.06.26.04.27.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:27:04 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 26 Jun 2024 20:26:27 +0900
Subject: [PATCH 6/6] tests/tcg/arm: Manually bit-cast half-precision
 numbers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-tcg-v1-6-0bad656307d8@daynix.com>
References: <20240626-tcg-v1-0-0bad656307d8@daynix.com>
In-Reply-To: <20240626-tcg-v1-0-0bad656307d8@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2f.google.com
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


