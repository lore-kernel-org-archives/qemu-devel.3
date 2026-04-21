Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8A6F8FA80
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 14:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFBzx-0006CT-OX; Tue, 21 Apr 2026 10:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wFBzv-0006Ak-Uv
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 10:22:43 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wFBzt-0007Oe-7c
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 10:22:43 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso36851935e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776781359; x=1777386159; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n/V3BixVWfmT0cZRmnp46kdvUv9OHHl1mdE1sGsEbnI=;
 b=Lqa5in1B2SzBzv5XIi9yjKGIG07pYzhDsn4Dsn/6S2zawMw5RCbOzIf7kSGAK+2xnm
 Lv/bLEU6BnvUUnXalIlhZzgJv9N7o91MLr6PBI98vdLaLDeeCpsxp7+hrcFh2VeUZppk
 F5gWZV5ofK4k1A4Kr0IL2rnLTTN3OEyWzEFaVRTwIy2RZOScRpDVlAYUlzNmx57wU8ZW
 7hkWWRRe2iBqfmhdkMaC4RbqwPS9qOO20PIg4lDW+Fkro4It1+v/Jj4EoKmTnfKVermO
 lFbrywCWdaeHxHjLQgLcdCu04FO4ihD5jtGJtuFuxgWrMtuxk8BHrZYU+eGcU0PrNLLl
 irGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776781359; x=1777386159;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n/V3BixVWfmT0cZRmnp46kdvUv9OHHl1mdE1sGsEbnI=;
 b=qXaDwngVELQ143oqmIQl+nYwgkvmgTDUuuBjjdqzsYdn6bqZ0USCfjKbG1UvWJbrKE
 0L//mBhAt3oZDd03Wlgb2FxvW8v2rdycwMcMYCBLtXho4sAmzV++Ac54zrSctG3NisBh
 bK+LJybFC2QXcSA0T51mMWrdVVBPwEw6uuO2VWohB1x8J2svdoCgwifI6ewy0xpynp1d
 8BfQuwSen8Nt+emnyVqdryZJQuLcS7PpuHiE+rN0rIws2j01URFCgowCWQflrz5MTBbE
 FG4ZLPvYavcOiPh77k3BtS4PbE5cvsFUmuL/EUom/wwtx2Yyt5x8Id5GlgJ3iRK2+02E
 QIvQ==
X-Gm-Message-State: AOJu0YxQqgJMbdC+B7hA64/6YyGufY5QXjGPydjuNQNCkeEu6Tqs9hIP
 9VxWIjstlRhG13PcqXrJUSIVh0m8Bznjpe89v+ikzKDjn3/J9Pm7FH7W/L9i2IqOAER85927npt
 89eyL
X-Gm-Gg: AeBDiesPXYNobi8nwN9YJ7Ps3ZgpuN7GpHfejh1PoeegvnBbCQf0kp8b24hMqcr5P+7
 fYXSBNGP2NouHFySjUPr/6VWNCb72DHBWIooz9K4n5UcdCm5kwHVH6YqON5AB0Mal7vzfRjrbJL
 c0FSQDMY1vxG6QmhKEVJcVvAlaop3R+aTrQBIsow2pbuAzL0IMycsaXrwqalerTIOBYZKeMchQg
 AsIkU2aNhpOJzGxEX+2IVgocKe3Sg5qvAPjYRFft6yOyzToOmtqDFHUbogVEFRe8UwG/Iuzurzy
 j7ksP+3cNX5EO+AZDmTMc0YZCuks8Y8igT4KIAVKBgxGO+nouOdkGg1Y7562CJ9bW5+mc/uZcEd
 Hr2JPme6tRcPs8jXCZv3uwZyVVPnQmyX6HOAx1debACBEyYPMjkx7rpxeQwLLve5TjET6RUCgGw
 H7JyTBtDBvSGimUGrlZIoerbyznvgS4JbjZ4rMXw==
X-Received: by 2002:a05:600c:c085:b0:488:c530:48a0 with SMTP id
 5b1f17b1804b1-488fb784843mr196697305e9.24.1776781358997; 
 Tue, 21 Apr 2026 07:22:38 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:5364:f814:f749:9bf5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891cca5743sm164250465e9.9.2026.04.21.07.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 07:22:38 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Tue, 21 Apr 2026 15:22:35 +0100
Subject: [PATCH v3 2/4] target/arm/cpu.h: New GPCCR fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-jmac-feat_rme_gdi-v3-2-ecd20c77eae1@linaro.org>
References: <20260421-jmac-feat_rme_gdi-v3-0-ecd20c77eae1@linaro.org>
In-Reply-To: <20260421-jmac-feat_rme_gdi-v3-0-ecd20c77eae1@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x333.google.com
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

Add SA, NSP, NA6, NA7 for GDI and GPCBW for good measure.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/cpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 657ff4ab20..1cfef02dc0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2089,6 +2089,11 @@ FIELD(GPCCR, TBGPCD, 18, 1)
 FIELD(GPCCR, NSO, 19, 1)
 FIELD(GPCCR, L0GPTSZ, 20, 4)
 FIELD(GPCCR, APPSAA, 24, 1)
+FIELD(GPCCR, SA, 25, 1)
+FIELD(GPCCR, NSP, 26, 1)
+FIELD(GPCCR, NA6, 27, 1)
+FIELD(GPCCR, NA7, 28, 1)
+FIELD(GPCCR, GPCBW, 29, 1)
 
 FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)

-- 
2.43.0


