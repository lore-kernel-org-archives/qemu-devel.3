Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF96F46C45
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9lVW-0002uv-NM; Mon, 06 Apr 2026 11:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVS-0002t4-6g
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:04:50 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVP-0003qY-HC
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:04:49 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ad4d639db3so17324665ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 08:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775487886; x=1776092686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTl6UdXPMq3a4SAQ816+q1nAoDgsRIfLxCudW7enz6A=;
 b=DIe1jiae6c7xsypEtYaZGBeatOhxvFQGrFNW1T8lOVQRyKsZ5D6eTr/Fc6ChcxXOnM
 5CujWMMN8b+tv5zLyadyWdFXUeOLXfZLhuWk1ifreqgHl3MBZ9rkoJxjssLWzP4GgTuh
 6z7a1DdNLBqDfb/RyeWfDdxDEJBjEDSD0cr5RsMmuj8NFwYl+/GLBWcUdpVu4Lz/6Fym
 DKjadZjtIyYXkyH4x9lcJWBEmzG//SvJ2JKCuQAaOyp8XCQrNuk+FYw66i+Knu4aL2DC
 Z7CnFh9gHdz8rEYVtOsztHEKu4j7F31mt/wQWkEp1n4T8Aqjl+VUZB3jpp4xlFLQnDDG
 biXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775487886; x=1776092686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eTl6UdXPMq3a4SAQ816+q1nAoDgsRIfLxCudW7enz6A=;
 b=bOxk2KtstX93OdTXpSFpYKUt2wkzMYVd/CHU8xyM1Epb7gbKIclYWMe4V4vDDrXXmm
 iHMZFA19mHME+5R/hpuk196fj3OjNCYZiA4P6BzRF0lROq8ZuuVh6rvJ69ee/nHW13yP
 DeB/r4jCwTzhP736uy+rGH3SO76xZ0bjv5Ck8mSBgxXOa0Q8YpzKNuvZa/sMTEB100rx
 6Ef+AtqdQFDBD9w7wRajKXOqgZTWnKeSl94xbLBbUVKG14IM/RsAahPLpWdcerR7ztMv
 8CQ9wg4XsNno6sLYlabVWhup70LR/pg1DsD8h1KZZ/l7xOB2QiDku1RJpw1z22ndEGsF
 HCeg==
X-Gm-Message-State: AOJu0Yy0JE8W648BQAZ6bao+49SseXZYfCTHUXl1KxwyYhmf5BMvUEnN
 HurLV8A/oIriJd31xnpHc6hnsJhapLLLtEyX4jRjwHpjhruQuugW+iDCXld2izz3cPU9etX2Z1e
 Tf4aPKlR2vA==
X-Gm-Gg: AeBDietmVfKYdjp06Z79CdFrRVdXVb2YZaCeIS0Evt0KcGUbA6IAQaWPkRggoxGtI8b
 dJa2U6NCJEi+enAdVA2TDO2gDbJf5WWAa4WkyWOEm7JzOIwLb3AvFLu2LUeYrzADyYbK4ngKGAd
 4IYziL/mWEjKFAx0y/wQpZz60AMfuV99JEMXlj0SB7pCy9MxEiD7drPSRTOwK60Wyo/oLRUmK4M
 n0lNB4YoKqmMKGjMbhIgtvEcRUhhF0BmKfckyP4xQ3hiCps7SuSVVNw2EBsfnL7fyZDpVt7vsLP
 +GbfuPbnsQP2zFbKm6cetbI8+R63K2qerL9fX1Lgf0UWHEld8fTrXwlfgw/AvhVgEE9FXryfbRu
 4BFcGAfGJASnssCFA4plYHg5/WKC8ATLBub4B+T+9OnYjy0BLwuoMWXn90i4Ku9IlgcS3Z4SUJJ
 592iVE4EkSPMDRjyUq4xTfvQv76on0tAI8/XpIaai6hCPDk2/KGvln/p6HHncWQmT3nKoUAYrF/
 un9
X-Received: by 2002:a17:902:cec6:b0:2b0:b290:f302 with SMTP id
 d9443c01a7336-2b2818de0femr158776545ad.35.1775487885870; 
 Mon, 06 Apr 2026 08:04:45 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d72sm137770075ad.51.2026.04.06.08.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 08:04:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 jim.macarthur@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 03/14] target/arm/tcg/translate.h: remove tcg-op-gvec.h
 include
Date: Mon,  6 Apr 2026 08:04:23 -0700
Message-ID: <20260406150434.407201-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
References: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Include tcg-op-gvec-common.h instead.
No target/arm code rely on target specifics for gvec ops.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 6d52606f9b7..e28eac54afb 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -3,7 +3,7 @@
 
 #include "cpu.h"
 #include "tcg/tcg-op-common.h"
-#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg-op-gvec-common.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
 #include "helper.h"
-- 
2.47.3


