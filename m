Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB33D148A1
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdic8-0007A6-JK; Thu, 08 Jan 2026 00:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdic5-0006se-Em
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:13 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdic3-0005Rp-TN
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:13 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-bcfd82f55ebso670990a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850270; x=1768455070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WENbCwQhzHJF4JDRsXNXWIq6TYGo1+EheHqXE7oC1LM=;
 b=xMVt/WdhhNhDVBxqUnkwhwa/ROQRZ4fD2jJkdHbA5A9bPj4VCQLKoAEn7kXi1X/PCg
 UOjy4QUO0bGlCBDj6G+iAMF4kAm0tqi1qEAsfRPiW4eUlYUAZzVhwrzaPthiFdXRK+mS
 M3cEcbyJM6M/g4eyRQ/9k2GEEikMvFCKIfWherBHwN7Zp7hW2wB7WEy2CP/guhWV8vdH
 D+g81V/7uoIc1+aBTOnlH0X06A0wtdALsk3rjv0Z1ronIoy6l3bquAtIFje3ZQYs3rFc
 d3rPSeo36Vso0ti6bQ1FrHqBWPguq1m+5dXfuaEdLRWAxqK15t3K4x69H6kOBoTwqV9V
 RUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850270; x=1768455070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WENbCwQhzHJF4JDRsXNXWIq6TYGo1+EheHqXE7oC1LM=;
 b=rsYaDjM3B3l+cf5rdiNC55VTGYQZujGE8cBNMJc5kRf11YcAviLzHvT5WwOmE1Sr4M
 x4wmq3KK1RyVgg7wjOpAB09wYagbi+egDJjspgTr54JD0EZMU8Pgk+AZA8apQs+ZncUr
 pvmg/2dlnjjia20hsiSdrN9pNW94vH5M3JTogfPb8x7EjhGuMXF33uVlGMUugUj3ZORm
 PFkH7ELY86RGtOs/XH1+bGl8qi0qWB78bDXjCGyCS/g+ysujGkCpmyjHMhpYcQEbH/VY
 ZeMwvlOVckXRSPazrJ5OI3qHiMa9C2yrdCPraSaAhm6Tf+d99KxVaZXy2VmJVf0gt/Z3
 +mmg==
X-Gm-Message-State: AOJu0YwX6EeuIjnLuBWZJR1Df1eTMgbyj076mu2XkuBpUv287PPEqu2m
 6s1UFxGfsavIOYmUJQHj1cuiKEhrAEnkHUZO5GVxQz6LzC0RxGAwSN8SbwHIyFLCFrEGrejrm96
 0orng0Io=
X-Gm-Gg: AY/fxX5pFmVeJbeOcPnVWAGs+jbeACMYIxWKC9g1cQcOiXJJauuYiF3q7T8SeAn8QUq
 +d8sl0tZIKQINu1jONt8sgdkw9JCS1MH4zXWJxsiGbCRQwMgVGC6QtoGVXalXcHs3SkIVNIaYUg
 NT/6kOL6sSVwy50BE8Tzck7h6SWzpFRI8lWZNdAH/HfylRxcejb2MjwnX/dQU2aOlmb0KzlJUHK
 RhSFWYEz7Bm5BelyPLbng0PZ+Z3IOkLUqHdNSS8qqXhSypgSVMX3EjoIXiQByvnUO+faCPw+wV2
 oGo1GWZzo2qnUNvFh/UepxKkEESWCBO8D19g4q49AGv7awXfsTBfTwXc62vSQJs7Xw7fULsuu7T
 DSTzBakss9LEk8p7zwu1qw+4ul+HBmQDh6x99YMHK/Kvon5dhOAWWEUw2T4btmeVAiXlIfQxYfT
 fGGR2cx1uUwW6JNvRdNceTU9dUsSj9
X-Google-Smtp-Source: AGHT+IHGbluLjtWRM0Vk7Fb1+Fc3RonZpaJi/4rIcy/+bZn5Syb07uh+dMWlty2UaisNUp/8SDEhHA==
X-Received: by 2002:a05:6a21:6f89:b0:371:8e6d:27f9 with SMTP id
 adf61e73a8af0-38982b4205bmr9079720637.33.1767850270206; 
 Wed, 07 Jan 2026 21:31:10 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.31.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:31:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/50] tcg: Drop TCG_TARGET_REG_BITS test in region.c
Date: Thu,  8 Jan 2026 16:29:52 +1100
Message-ID: <20260108053018.626690-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/region.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tcg/region.c b/tcg/region.c
index 2181267e48..5d4be1453b 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -464,17 +464,6 @@ static size_t tcg_n_regions(size_t tb_size, unsigned max_threads)
  */
 #define MIN_CODE_GEN_BUFFER_SIZE     (1 * MiB)
 
-#if TCG_TARGET_REG_BITS == 32
-#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32 * MiB)
-#ifdef CONFIG_USER_ONLY
-/*
- * For user mode on smaller 32 bit systems we may run into trouble
- * allocating big chunks of data in the right place. On these systems
- * we utilise a static code generation buffer directly in the binary.
- */
-#define USE_STATIC_CODE_GEN_BUFFER
-#endif
-#else /* TCG_TARGET_REG_BITS == 64 */
 #ifdef CONFIG_USER_ONLY
 /*
  * As user-mode emulation typically means running multiple instances
@@ -490,7 +479,6 @@ static size_t tcg_n_regions(size_t tb_size, unsigned max_threads)
  */
 #define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (1 * GiB)
 #endif
-#endif
 
 #define DEFAULT_CODE_GEN_BUFFER_SIZE \
   (DEFAULT_CODE_GEN_BUFFER_SIZE_1 < MAX_CODE_GEN_BUFFER_SIZE \
-- 
2.43.0


