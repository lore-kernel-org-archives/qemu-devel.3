Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01330FF5138
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 20:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wACaZ-0004OL-LM; Tue, 07 Apr 2026 15:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaT-0004Ct-N8
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:49 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaR-0007Ou-3T
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:49 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-35d99031e4eso3131110a91.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775591986; x=1776196786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lxr7S5ejvt661ybvSTot+9Xez0DhgnskIyrzMc+2BIE=;
 b=avSdpgUKxx36sYPyRuFTfwOquYkgSeNi4r32xwCl+WszeH7jGDRK6PGBtWrYH3EW01
 HxpNE4YejEuaOxnjX5rjWIZuEyQDDBF8V3fvN6KercmxPhBUyCsHD0OAoUjHMOcMG1TP
 7Vk0kt801ohO+E7vps5rYHxdv6x6GuOMsuwCqTObGhdJgO1K344uy+zATjAapV7MzyZG
 FXBV+ngosHTU55nroEyquh1B32mwMKUKYsAxe7eEIlBNgFQUAP//k1xPIY3xD/GOf2k/
 KO6wb9OEsddbSBkkvsBN4wWnq8EClCZjWO54TqPsqxngzC4X752eqdtAXSivg8MLNKmS
 J9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591986; x=1776196786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lxr7S5ejvt661ybvSTot+9Xez0DhgnskIyrzMc+2BIE=;
 b=ZmBvV/EeqXP98ppqt6/XdHrVh/uDLMZoPesQwjCWMFF+5MTjeVkF2hkF+USd6GEuJq
 X7QzYzeZC4+hFnkZA02tqN2+M4GdY7jpEZjb0uZTODSFzIyhzOuj1+CICo3CQ/bwJKf7
 P63cKrRxLayr7P0c/CvSQRVhIAqRigazz4dOvrQ8zSxPbYa2oBq1xojdZXgSPYMBzWVJ
 Hm4ySoaYnCj6jmT3nvLtJsE98AhnHZktGE8GTSCq8p8eQy6nWoOz1GMH8rvc2jFTTcQC
 YWU9XQM0BJDcMyVcMLWauszWotaUm9fXj7cAhMBQbe6kbFW5JSBmKmXRhiJwURTSp9br
 /uQA==
X-Gm-Message-State: AOJu0YxIJatMQCZOBgp6GafUKGsm+yy+2q7G/w3U//tW0MzY2q75Cfpv
 42v9V0AEPUSiJcmUW9b6LPvldtMFoR7E7o+SyehHWRDUpXY1DpzYxO1sQFB+TLZlMw7dyBi83Kq
 g0cLqIMc=
X-Gm-Gg: AeBDievz82ONmyWTH408ZJ9JPIz2tHlSNeDJU7iRvzFIPd9HiiENZ+ffqHRAYaBKn6K
 sho2CkI/nBWt56yPRwftURMCfOWiFSl3ZuuwziF+YyuAeA3HIeKo5pMxOOdSmo4fSDw4BlJxVRT
 xwhuu/uwvfDbS2ulkmw9LL7GDmK/8fni6l3KsVDv+QSIkJZDKw6BDk6daREhB5sxxDxYpOTG44x
 c7xO1binEibS0mfiWLa1VqWbQXzmBYpxrSclUXm022n2f25qNBXkycVJ8UZLkqRjiMtA30/xn9q
 VQyvnPphhafMc2ktaNg0fUuQJnZUrdLZb63xJgZ69SqU/JVK46a28jrqnYEzU6neUy/OW9cBgwF
 p8dTLfzpxgrAAsF5Gc6ICcpH1uWYdhh7fFaVaJoMO+Fs8SmdjndjN/HwZ4oCeI4sxmmRs12wxna
 xZXXulcEwxpuw+q2I/sbcjx2TgAV4FtMY+OqVdZ/C4dKIxiWxM85TsMPIH+xzpmoV3t6skfEqsU
 jQk
X-Received: by 2002:a17:90b:3d8b:b0:359:f2e1:5906 with SMTP id
 98e67ed59e1d1-35de678f026mr17426127a91.4.1775591985551; 
 Tue, 07 Apr 2026 12:59:45 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e27c9855csm126911a91.3.2026.04.07.12.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:59:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v10 16/21] target/arm/tcg/translate-a64.c: use
 translator_ldl_end instead of arm_ldl_code
Date: Tue,  7 Apr 2026 12:59:17 -0700
Message-ID: <20260407195922.196410-17-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

Allows to reduce scope of target/arm/tcg/arm_ldst.h to aarch32 only.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate-a64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index df2cbd66b38..48b5c572555 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -26,7 +26,6 @@
 #include "translate-a64.h"
 #include "tcg/tcg-op.h"
 #include "qemu/log.h"
-#include "arm_ldst.h"
 #include "semihosting/semihost.h"
 #include "cpregs.h"
 
@@ -10801,7 +10800,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     if (pc & 3) {
         /*
          * PC alignment fault.  This has priority over the instruction abort
-         * that we would receive from a translation fault via arm_ldl_code.
+         * that we would receive from a translation fault via translator_ldl_end.
          * This should only be possible after an indirect branch, at the
          * start of the TB.
          */
@@ -10813,7 +10812,8 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     }
 
     s->pc_curr = pc;
-    insn = arm_ldl_code(env, &s->base, pc, s->sctlr_b);
+    /* Code is always little-endian on Aarch64 */
+    insn = translator_ldl_end(env, &s->base, pc, MO_LE);
     s->insn = insn;
     s->base.pc_next = pc + 4;
 
-- 
2.47.3


