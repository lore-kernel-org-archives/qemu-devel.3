Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D064DF99367
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqu6-0006Ui-B6; Thu, 23 Apr 2026 06:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqti-0006Sl-9r
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:02 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtg-00027A-OD
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:02 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d77f60944so5190573f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938579; x=1777543379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VXoj8K/1FLMjguol00rR4xSVo1FA7fFJ10qYf85eI6k=;
 b=UYs9zrx0rl+bqwZ0/qHeDcGqZ6xS14Y0RFnt/TxW4ihMcMdQHJOgDxqD1i6A4Vc256
 xMGGoRGagdnsrVxs2Wp1SlExJnW7ymVyR2hLXS74GGMyQkAtwYl5dhBUor4EWl3gpYo5
 8QsQj2+/1oe6aNnxbS+y8KDS6PuSFc6f8jbDGJgdfCxZc443VeS8QokfKicyd/E3yWPe
 FPps+S2I369chcfcTc6HRRJaWKNhxcS7r6lmpel2Sfq0phXZnWGfhUH61g3D7E4hXNW7
 PT0BY9sF5kLjGdSnJ9y1uAvFlCiwlQaQgJN+HUQkSEb/5RHrFB4o4dUdsYX2P7hhcBGe
 84vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938579; x=1777543379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VXoj8K/1FLMjguol00rR4xSVo1FA7fFJ10qYf85eI6k=;
 b=SEdht5HHA9X16YaRSXcT2UtvkyvD7vckIFv2GEdaOE7UXehXLHi8L8lXVxqOKxiFSc
 RhWP3V6DwaEFFKW6xHBLxVxxgB+RgIKOGvpwIjKo8UVjkjNPRtLMyp7t/PG1dRnNldYZ
 gjcidiF8IVnDxdU2VoxlpGmaxYyB8DYyNOT7TiJ4Iz9ei6NpyQBykSYLoHot49LURBi8
 ybpxgpTFubK0aFP6RnFDxyaVfzxDnXemB1Pg8l5jyTGtt+zybDC3ZaIlAiPDWYOun4Mg
 dInDTsyVxjiF426Y/glIjO/K8B9F4G4tcAbwxtfv+/w4C3zchN6Yk07yHmzFGLXpXgV8
 nd3w==
X-Gm-Message-State: AOJu0YywASQ7/HeaMr2tHAoSGtuErGPBTKVLOGlz5Wy6jRSPineeQdJj
 Q05rbjpSAaHR3OX5qdWIZyUwK67YROrIaqgTRaBIE7Kd3SfYqlgSrPDI/kB6cvRjh02ZqXQqQep
 /rejk
X-Gm-Gg: AeBDievAbv/9YnnETAdGW+bunMoGL7dfy6j6ruQUzebHkPlXVTMFVVtM7BTzQodjao5
 RILOxtbDDjsA8f8Qs0Y9nQOd6Ifs3h+jfBG1RXIwRGl0hqgxWZWreEpDpO9tda+HSn2GaRNF2oL
 BJh34M7Bp8QA2/SYccjPudVxyedA6Jxpe/TtcFHeGAdwfoHd4Uo3riFw914Unt9qgkKxPLX7Os8
 4lVmEQ+sEPtJgU2z5DVPkIVTxU+U6AsmlHiwuK5pJG8VSm93ExGSgzq1rV8xv+GE0jxvYSK/KjS
 nPvqduv9BOXx9lKYmC8EMKFiqIqhQ2KgFqmXP23ppp3Kxa/mAMg4ejwxIHB7mEu5gpNOqgQ4zUQ
 Waf23wtmNcKdHKGpuqJO4AshF7x1VZcUmRBDSkqBgPfDHqkCd0gTnAn/3UlYlKIJUFTXA7pdcT9
 BMFulbPj2vBx14IUAWWpS3P5fo3tyarDiyqxAWIdUmQAg4CGaWlfP/VgA/ANs4cWoqMT+eFxYCC
 4olvxKXz+0iBhF7++LJBzCiZLLBwvrK+OJOmN+45w==
X-Received: by 2002:a5d:584d:0:b0:43f:e263:c02 with SMTP id
 ffacd0b85a97d-43fe3dc8824mr39520135f8f.1.1776938578911; 
 Thu, 23 Apr 2026 03:02:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/59] target/arm/tcg/translate-a64.c: use translator_ldl_end
 instead of arm_ldl_code
Date: Thu, 23 Apr 2026 11:01:55 +0100
Message-ID: <20260423100229.2941820-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Allows to reduce scope of target/arm/tcg/arm_ldst.h to aarch32 only.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260407222208.271838-17-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index df2cbd66b3..48b5c57255 100644
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
2.43.0


