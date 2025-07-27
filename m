Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D18C87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwRi-0004gc-Nv; Sun, 27 Jul 2025 04:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPi-0003bG-4c
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:23 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPg-0004rG-FD
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:21 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-24003ed822cso1924815ad.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603639; x=1754208439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rpfne0/mZ4p8IHBae8X7Y2QjbioW2/Mtp7IWsAwdNTY=;
 b=VoKk40uISNZitzhzJoLShp/1IGfYp9P1NSXG2/asm1j560/GSHTnqrOwRYGG3FXLUF
 V0UwaZELncfZFQ00X4dDfbjyI1L29k0m0QUjb+178FJh2s/Qr/TeMdtFHYeXnUd6MQnS
 nilJidzCO3rLpNQM/+9SEkOYf/AVd5S/hd9VayQWkTBfaXhtXS4bWOrT6KCLYmcbxYAf
 Ds1sPFP1TkCFuD/x/hdQ0VB0Jmu0U3OO5bGJ+/WpMIRoIlhlWxK1RIjqM7cXxGRZpG0L
 9mpL+IYr6qNTy1MGp/G2tTqiPOUfeqraNsZfd6JK0w+hpOBPReph1Zr9+3wtDi3jCnzX
 B2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603639; x=1754208439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rpfne0/mZ4p8IHBae8X7Y2QjbioW2/Mtp7IWsAwdNTY=;
 b=vva5vLX9FndO5uzwpgT5bDbCmv8CeMBkCDGWOR/01scspXc9lMWsBYrQQyLKGE9Liv
 mW/b8HYL8BXh5/TGf7idF1pr4SesZsN0RVPB1kBSt3vVVIYb5YuGGkXWC3lDvRKrnyOQ
 HL4qfjZ6UVbcnAlWDe+9ZWgaZUV1exC8Ynf1LCSZQNCBF9eNWjkwoxIw6fI7tx6/i6yx
 NU8bWVoBiKkZsYjcH1eBdOA0KOlDcnQADnlqV5FbPCBifshkfFY/ldvuOaBAjWwRH269
 C7wKx41gExtcWDk4X854hUTULc0hn9kH2XR3t98lzzGPAovD5qEELtA9cYy3ZmUkwQcw
 XMzg==
X-Gm-Message-State: AOJu0YzkXJhgMEQKzk8cVvIrwX34PFZScmcOcWv3s2xRdKMCQ/ZKGI4X
 /Kbha5JqHWVT31rjcFESO5aaR9v4lpum4gICRzV7waXVoQZcXgjY61+Mb+e11xUgtSpRrmVEAop
 RbKGW
X-Gm-Gg: ASbGncsnAGQ1cac7obSx2IFr97e9lkSL9VQy3ia4be6u1WHPcBIuR4BMjRTmxw3W+eG
 ZlW/QF4WNSx/g2a/wUCqSZRgK7iYBmcvSF8+Lq/7chxPmpHBZ4JH238550RV6yYqsZEGrdDijqz
 r5R6tdw0FCsjl5rEPwCiIyD+VlWeYaoa1g0eWqh45Nj1RuISOrh838N81q47tH5G+Oliv5mUrTl
 hNlWFegzrRws8Q/KJSSGxOgcYoXG8+LDU6OslWpHjigN9d0uXQkYalwArBP7RZv7uVAQT4ZlrfC
 ZL45+f9GLU2VGQNgatDLMVX4b3aU/XaevwR6ncBE/tdPDUjXQwmAH434mEWLrUYlb0d/Wvfxseg
 14j2SExRqbQ2+VsO7QM35SJS+5b7lqSAQiXMp5OY/0YU+TXHHkxL0lvyd8Im5XiHwhvwegxot1s
 LtE3QgSMn4TQ==
X-Google-Smtp-Source: AGHT+IG56sQfgqz33anShEeaMUmb3hh55vlGCIqobz69R8Xdox0GURjgL5UdJ029qX9g7AxqfaS+LQ==
X-Received: by 2002:a17:903:2346:b0:240:2145:e526 with SMTP id
 d9443c01a7336-2402145e8d5mr540885ad.6.1753603639052; 
 Sun, 27 Jul 2025 01:07:19 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:07:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 68/82] target/arm: Copy EXLOCKEn to EXLOCK on exception to the
 same EL
Date: Sat, 26 Jul 2025 22:02:40 -1000
Message-ID: <20250727080254.83840-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Per R_WTXBY, PSTATE.EXLOCK is 0 on an exception to a higher EL,
and copied from EXLOCKEn otherwise.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2514a03c0e..23e54684c4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9300,8 +9300,13 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
         } else {
             addr += 0x600;
         }
-    } else if (pstate_read(env) & PSTATE_SP) {
-        addr += 0x200;
+    } else {
+        if (pstate_read(env) & PSTATE_SP) {
+            addr += 0x200;
+        }
+        if (is_a64(env) && (env->cp15.gcscr_el[new_el] & GCSCR_EXLOCKEN)) {
+            new_mode |= PSTATE_EXLOCK;
+        }
     }
 
     switch (cs->exception_index) {
-- 
2.43.0


