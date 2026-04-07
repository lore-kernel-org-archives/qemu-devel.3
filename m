Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C540910F9973
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYIt-0006z5-Eh; Wed, 08 Apr 2026 15:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAYGd-00047p-NB
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:08:47 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAEoc-0000rq-Hu
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 18:22:35 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2addb31945aso39459545ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 15:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775600553; x=1776205353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lxr7S5ejvt661ybvSTot+9Xez0DhgnskIyrzMc+2BIE=;
 b=glAr1zBkzObO1hlm5Qwy2ZJDshZCb/luxIU3J12yDSgkBKHS+9cHdrCws8E7CEKwxF
 DRRSGb6+MTEYhRepOUYJWOisjH6J5tGGnoa+2hjgzGMB3kdKlnM5rNaWC5OOxscCwhfc
 gCuOyS2OtiltTVzDsGbl7QNmnj3tlzje9iaVZi+kW2IeIhJXResHHzkMomAM8XQPUzFK
 a8lkC3B1i8GdyM/B32kMKAG4g042nVTokT624Lx/1Y8yj3w0fBx3C/WGv7m/Hox7J/Co
 vI8s2+k7f1Y3PEjRdwqE03ALKgKhMB7l813ApEgAm7u4jylqiNCus7gbvaKNDBTXJhaB
 uBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775600553; x=1776205353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lxr7S5ejvt661ybvSTot+9Xez0DhgnskIyrzMc+2BIE=;
 b=H6/6wwTwlHF5mrS3m+lKlAtZjn2aK4ZUO54xZ/spgWklvrwvP+q1r12d/WIfW+Dxna
 3bqRJM0jP1kQvkHwI9BuKlRSEx/SoK58Rdm7eukmVRzVgPXVGbuArdeiBRuEM7q2kfTO
 RV5zEfn9+maQUfp9nPZoFnofUSfR0ZM9UYBkwxH42pkcmVyehoTYsYdEXiSuFiMMrsRT
 lG5kLNYX51r2t9AQw85J/y5kxuuuZyriwOWuACPRvC3CRm7lc/es6yPKCYOqZaBYZWZ9
 Gsr+KRwexVlkyW51jEsAOvJ/bWyrmLVAnfbPWwDRoxwNydHBcf8ycLmP6qxunRtn9Mx6
 gRXA==
X-Gm-Message-State: AOJu0YwWl7nLejNVhowJhNLj5xYZdVBcSRvc7gwWHcWhbAsRys6QCyvF
 oVRcAuedcGxM25RuOk+Yj0Bgj4ewR11VeXSMcW7RS8tllaryx15AYlysRQAq3ADR2j9UGi8toWm
 hYwr0p/4=
X-Gm-Gg: AeBDieuTDYb+0uOAfjcyDjxeRxOWNtusozMbf/TtXh7Adh5bsoyABRepONN43KfvCHi
 BeJDZWTBHGhKYmxVIXQKuDyO8LFZFqFOeyISYab9yrNqyE/gl18D7+zyuO60D44gp/FLGV0OFpp
 yTxLfmAyoj/6xjX7Mrazx9YMWZRm+Hd9w2hCCYjqWYDk0qmJPOI00YDA87eUpp3rATO1FZ192Gm
 DLdEruwUrw0pI/HK7STv44OmoEW0PKeQFUBOo/buIJQ5CKYKMol8jGN4thMASRPbeEYhXrUtYnB
 Q/TIZ66NuHHhDSTJe6LikjZvQIL5gndS5lRhJwcaLvSJccVopEKC87+LCKkCVtalRqIXIhSpxWW
 Fgc83uA0JyI/h2Et0bf2uwC32V3iQeDbjZLVp4e2HWGYZQDCQ/j5mdar7c/YDoZPODsUS/PplpC
 Fy2KiOFy3zMokzhYgBFBTiFLarayFZuvgpEW0tm9XvJE6fH6A5NANJgw+/U3d1g0bACu3FxYnC4
 Dva
X-Received: by 2002:a17:902:e845:b0:2b2:6df1:1108 with SMTP id
 d9443c01a7336-2b281867961mr197990875ad.15.1775600552961; 
 Tue, 07 Apr 2026 15:22:32 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d5csm180412065ad.38.2026.04.07.15.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 15:22:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v11 16/21] target/arm/tcg/translate-a64.c: use
 translator_ldl_end instead of arm_ldl_code
Date: Tue,  7 Apr 2026 15:22:03 -0700
Message-ID: <20260407222208.271838-17-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
References: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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


