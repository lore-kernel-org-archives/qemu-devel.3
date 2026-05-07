Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201E6CD37AA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 22:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL72G-0000qk-7I; Thu, 07 May 2026 18:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72F-0000qZ-9q
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:35 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72D-0003DS-Jn
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:34 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7df05fc49e5so1408350a34.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 15:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778192252; x=1778797052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UH45RYPjBMezm0+7sjNDgFLgzbFhfUGKizw3De6+epY=;
 b=nu5kkEO5bf+O4ke2667mvnybegSJCU29KF9AWoyQeYQLC6GRyRoZrKgRxSMjwEUVR+
 yVJjp79lg61wPgSuWM9g+SDqEqWz8dW+9TBquKN1RXraaS/4iT+ZlgPlgkHUrAAfH3WU
 xo7iwx6Fx+K1VZweJs3o3zdihcYeLmzlMDWELzs9EP6Nmoc4Ng5DR5NFi3nCGl0msh5e
 iEmVyxsqUmrlYennuD3dSuIk4yrFhZTqYqbtEhMZDMqCnQVRo5xkQRp6MtKnqoO0sToO
 TlBQHNTmtcK0CnGUE3BKNAMVWnZLoi/NPptvtz3jxDTI5/vB1aI4AwlR0tE4C9C6+Lz5
 N+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778192252; x=1778797052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UH45RYPjBMezm0+7sjNDgFLgzbFhfUGKizw3De6+epY=;
 b=c313OkM0gtJR1dymEF5S5Agt+sRJP4Rxagyz0KmO+zz+CrAMKYtERxXWsU/mgPwkI2
 NSer/T+z9zbNgYfpOCTf97VYao/ZvLtgtbWNXk+RV/PG7albs9yRSKeSspek+LUEpYoL
 2lgk9dtBXuN/pUcir9TKE/Jds88Gh5n9MvB0RL8OJLiD6hBfdFYQjsMngU+clB0yOyg2
 MGLhnit/ktVBlzVUMxCmn22OhmHt9Ynb+OTP4TwTt7ro4eH5TsFYQGvglXVarIWM5Kw3
 sxm04MEUFpOh90IwXIN5pceyGn8bzonlIhrm6adDaPzTYBvvMAn40EY8QaLnrZwPhnwm
 2UfQ==
X-Gm-Message-State: AOJu0YzPxkuYN2Vbuy7GEWmQTiK+bsmlXQXNf73Nwo704kkqG7AM5bA7
 87kHHF22/+cfqu7XKwIn6Jxbc9VTgZUaG6jNwLh4GUp/8ECHOCCzIu7t7oB3nCHxkEdlqQuuRvK
 QiqD4
X-Gm-Gg: AeBDieuf3IynE7M/iRUuWddv/w+3Dn5dEPa28Ip0LGlu++r82Ln+84MhIs9z8f8PtOM
 CY3pAdGOaLouNHSz0bmHDOg8Znm/C7dgFxb/hn26ucG+Cm4dA1QkzGxziJjcw70hl3a5O8DG7Tg
 KGfB7qQx/0/orelm8nGC1oYCiY/ZwZ13vZTd+z96lHtMnjpSM+qFDbZvzMDaN2DFP2GdriJcUnm
 wSegcDAROs1YjRseOd/xEYXHAP08xeOl7CviuRX3Ug9g8WqztFiz87qXbksPtqEgTvuZQrK64u6
 fhNdp9gVn+yPJrYMYW0jIuuXW/RrSraXMcSVR7JcoQLNsHQnBdVv+fsCcd7l8gyL7ylASfmj5mG
 EjDFeVMUMU9j+myvrAAJs/aW4CxJhgIe9/oqssrytmNup0haQbN2fTvxh5bIR69ddIJXm27TsrU
 8kCFVjTKpOD/siGrNks3UvURjlkYy2Xhu3XW2hobCWj4KjMw==
X-Received: by 2002:a05:6820:f026:b0:696:1a25:fdda with SMTP id
 006d021491bc7-69998cf6a75mr5446611eaf.26.1778192251822; 
 Thu, 07 May 2026 15:17:31 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435573e7254sm45037fac.14.2026.05.07.15.17.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 15:17:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/18] fpu: Use get_float_3nan_prop_rule in
 partsN_pick_nan_muladd
Date: Thu,  7 May 2026 17:17:08 -0500
Message-ID: <20260507221717.486023-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507221717.486023-1-richard.henderson@linaro.org>
References: <20260507221717.486023-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index ed28262aba..1d8a98358c 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -163,7 +163,7 @@ static FloatPartsN partsN(pick_nan_muladd)(const FloatPartsN *a,
         ret = c;
     } else {
         const FloatPartsN *val[R_3NAN_1ST_MASK + 1] = { a, b, c };
-        Float3NaNPropRule rule = s->float_3nan_prop_rule;
+        Float3NaNPropRule rule = get_float_3nan_prop_rule(s);
 
         assert(rule != float_3nan_prop_none);
         if (have_snan && (rule & R_3NAN_SNAN_MASK)) {
-- 
2.43.0


