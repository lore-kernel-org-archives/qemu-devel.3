Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB6DFB5187
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9wAz-0007j9-3w; Mon, 06 Apr 2026 22:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAp-0007ct-CS
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:15 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAl-00070q-A7
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:14 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a871daa98fso35237685ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 19:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775528890; x=1776133690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6gG6PBIjNyyRHRNZFFmOCXFmvndww7AFyaXSO9hngxg=;
 b=raM3jJRjhpzGNyvPZ5NBfqzxYFhy45DJ7raEUVO30L5sOBo3yOoLz38JfUXsl/ERrU
 DJs2L5kvtK0MLR/nbgnbtn/cmR+Hh4OzcWNAAP5OIkr4EVFomGIYqy/7ZlsypfI8OxKs
 sTSehp1UU8PrC3OsNWltP55h3coaZ7cJPK1yvNhRaUWAMUXinjd3i9S355Zd2KhGMVjc
 raLH7HwTgde/UQq9xDp+/OZrDup+7SnhO27J4I5ptqFoqa6DCFnXSyZXo/IAp6jwa93H
 NbKRnZIDDyZhSv52x+tXVwaqvIEWaogCURcjF8VRZZgzC2x6G14j7UgDnJTClYqyIlA8
 ULxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775528890; x=1776133690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6gG6PBIjNyyRHRNZFFmOCXFmvndww7AFyaXSO9hngxg=;
 b=aNgdpSvNlEg9tFWqKpe7vWN0M6l75G2Zkh8wWzhSf9Wdhxu7RcnMmDvnrbQZw85qSW
 Cksb5Hf6Lvx80FZJ0F2bl5JSAfITM7KsdCKOD7HZUUJJ89D6A26XPnDAwnhlQFcuaG3N
 trVh8+tQWlHGNWGWcq+amTqQH8R0Sl9VeSu2s0x4MX6yugvIVbszenqL7pFT/kjbnK5V
 EVjKkWyMzbXYwOfGmEeHv80A4WuNA2YaDXBIFgylKaSYmJIfY6/rtsard4mf0oGoRNkO
 T9+X+tlOnwO46WaIS24C13mPePqC5eb8iN7vNrM3RRMBpKHtCjLcX4nzs0ti/9e3Utni
 gaiA==
X-Gm-Message-State: AOJu0YyJVjpGuF+gH9KdNBkf+8AVfMAR1FcWzwNVyMXd00E4mgm/BPC3
 0tludwixng98foGyk9/BAkepkzQBLexAQq80XRCUmDo04LFwUpM2CDNxiej8dHizPNDpwULilSE
 c6qnmxTqW1A==
X-Gm-Gg: AeBDiet5c6StpjB+YY0oEYZ9bRzw9Dqi2aRaj5lXfNLsQtwSBXgSepRHE6vZPC1D8U0
 RaKAFvSlzAiE8j/7FvMSxWFdeO3UB8K1ww46RCCOEI9XA9FTSC/Po6WMjrm+Kz7Y6gbWoSKI8Ew
 pcSF0jxkW5zIfV9pYWxDWta93xw8klkuLYXBI6/dJABzQF1s3RarPxw/vsq9gUyrjrkS8Xl5Vw9
 SXDapy+5nP1zk3jhCefRw2LUpYIhbIf4vbr3+ogBUPG1nni4XqW76B1hiowXaeYDFFrxAfsb/Ci
 c6PhoUnLoWPcAAYQGFksoXAvbrIE6cRUSN2OoY93bevTV1vft1l+xdUZ2O6xxKwJxBKOznC29Ii
 lIjzZBAwKDHAdDqDtk6xGcA/nW3JxGFYRMKIi/FJ006tYOeXtxCuoKOH2qUWnyN8XYiZFS0HaxF
 kQzhk5yR3B1p9oJQyZjuK5s9/ldj2QRl13lOAVHtmFgLUCtNgma3teNE7DF3SaryWQg0SvBcvjE
 Vn0
X-Received: by 2002:a17:903:1c6:b0:2b2:6237:b0a with SMTP id
 d9443c01a7336-2b28188a924mr150022445ad.43.1775528889863; 
 Mon, 06 Apr 2026 19:28:09 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749794e8sm161423685ad.53.2026.04.06.19.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 19:28:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
Subject: [PATCH v9 16/20] target/arm/tcg/translate-a64.c: use
 translator_ldl_end instead of arm_ldl_code
Date: Mon,  6 Apr 2026 19:27:44 -0700
Message-ID: <20260407022748.57629-17-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Allows to reduce scope of target/arm/tcg/arm_ldst.h to aarch32 only.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate-a64.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f446c269dfc..567337fb40f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -25,7 +25,6 @@
 #include "translate-a64.h"
 #include "tcg/tcg-op.h"
 #include "qemu/log.h"
-#include "arm_ldst.h"
 #include "semihosting/semihost.h"
 #include "cpregs.h"
 
@@ -10800,7 +10799,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     if (pc & 3) {
         /*
          * PC alignment fault.  This has priority over the instruction abort
-         * that we would receive from a translation fault via arm_ldl_code.
+         * that we would receive from a translation fault via translator_ldl_end.
          * This should only be possible after an indirect branch, at the
          * start of the TB.
          */
@@ -10812,7 +10811,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     }
 
     s->pc_curr = pc;
-    insn = arm_ldl_code(env, &s->base, pc, s->sctlr_b);
+    insn = translator_ldl_end(env, &s->base, pc, MO_LE);
     s->insn = insn;
     s->base.pc_next = pc + 4;
 
-- 
2.47.3


