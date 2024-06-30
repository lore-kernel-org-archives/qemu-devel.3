Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3034BC3065A
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNzoA-0005Vu-To; Sun, 30 Jun 2024 15:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznS-0004vI-Nm
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:10 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznM-0007YP-Af
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:10 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5b97a071c92so1085571eaf.1
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 12:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719774063; x=1720378863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RVOFvPwsyl4QfxgYtVSSFj0skJQCOvZiNxR84pYswu0=;
 b=Akqf+zbC/mCYhJHZ/IYzpXhBzF4xKDKxcFh9JmFTV/uykanKQSajOoo6O+c9XkbjD6
 AUI4PISNR6ogigq/Vi60YCqde3qCltTaqPHvYSm5Wj3T7NnoPvipZrVDNovO8ew7wgnB
 MEkPY2BI5YSOOv/X4dj0fxEBO1uZjdld9veUEOW/fcfbYfZv7h8myTTuT1J/gtodn182
 LHcDuWLCyVK5F9mc81asMPcAZ3TzxVjn3xJaaa0Ou9dB+gHYy2X7whV2i7oXqjVJt0c6
 aCJjKdF/mxKnms4op2lQKeVFolsbK4dgmYgL5cc2qSth2Izuy7TbB+itPpi0+p3OpyTB
 PoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719774063; x=1720378863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RVOFvPwsyl4QfxgYtVSSFj0skJQCOvZiNxR84pYswu0=;
 b=tbkWHTtJNQ3gg5AL+p+FQo9WiglSW3zEzfhCN9hiHSdHBciI0694yDkh0pJarpFSNG
 7JAgjz5lb8w+ToIu5o0Vi3j9uhz9ucvujuUeX9Rtfjbn+ePWDRRAdOE3xQduSOEXpJ+Q
 JS0qRwrkt26aaEoascAyiCYdoFL8NNkKQbUp2Vf4thavrRh1An48f7OrFDsTp+f7O9cG
 P5aW4P/4yyfuVWhmPV4a0QmLg0nH72w49vI6VtrVC/IiCHaxYisgcPsAN7eFROTDxCCA
 BVUlqXp0wFLimzSiHFQl2SljVYFYelCCp8w/bT8aJn7rF8ytvKPcVBRBrgdaLonq2Sr4
 cr0g==
X-Gm-Message-State: AOJu0Ywc9MqEDa8s1Rq92olKWfEe0i4Q6/GMntZRu62WbEy9O1eanaSv
 gj+2HH0IP8GtXbeuPMCUKsrkP+lCWLCjXj2vTzYyuo7qqzZM1wKZPrPsSBrRQzWGLN8x9cWA4AL
 Z
X-Google-Smtp-Source: AGHT+IHA7EAD2BcPbLOszhLP6OoRn2JyUpvo96A5Uk5LyADv0Efa7Q+vf8tGolXYGn9c94tdtTdkyQ==
X-Received: by 2002:a05:6358:9486:b0:1a6:84aa:13f with SMTP id
 e5c5f4694b2df-1a6acf39bafmr430163455d.24.1719774062730; 
 Sun, 30 Jun 2024 12:01:02 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e7e4bsm5115641a91.52.2024.06.30.12.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 12:01:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com,
	alex.bennee@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH v4 11/14] tests/tcg/arm: Manually register allocate
 half-precision numbers
Date: Sun, 30 Jun 2024 12:00:47 -0700
Message-Id: <20240630190050.160642-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240630190050.160642-1-richard.henderson@linaro.org>
References: <20240630190050.160642-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Clang does not allow specifying an integer as the value of a single
precision register.  Explicitly move value from a general register.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
[rth: Use one single inline asm block.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/arm/fcvt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/arm/fcvt.c b/tests/tcg/arm/fcvt.c
index 157790e679..d8c61cd29f 100644
--- a/tests/tcg/arm/fcvt.c
+++ b/tests/tcg/arm/fcvt.c
@@ -355,7 +355,12 @@ static void convert_half_to_single(void)
 
         print_half_number(i, input);
 #if defined(__arm__)
-        asm("vcvtb.f32.f16 %0, %1" : "=w" (output) : "x" ((uint32_t)input));
+        /*
+         * Clang refuses to allocate an integer to a fp register.
+         * Perform the move from a general register by hand.
+         */
+        asm("vmov %0, %1\n\t"
+            "vcvtb.f32.f16 %0, %0" : "=w" (output) : "r" (input));
 #else
         asm("fcvt %s0, %h1" : "=w" (output) : "w" (input));
 #endif
-- 
2.34.1


