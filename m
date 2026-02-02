Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F4FE7FDD8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn1Ln-0004Tw-EP; Mon, 02 Feb 2026 16:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1Ll-0004Ti-RE
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:20:49 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1Le-0007KP-QE
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:20:44 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so39897395e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770067241; x=1770672041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dAg43hDJKLeJM0wu3Qk21qDtHG5d3oy3Ln1thTA7p9g=;
 b=w4E9QeKvcQDOYnLpagzEosCedLlVzcgfQxR82P6VZ8ZpKh1IcnM6AwhQktrjPkHxIU
 rp2hN2wLM/7Ku1NPgMl0E2CASLEaF1X4KJtcGCGheiEyjlODvJtn7kR0pMpbRg+Ffdk7
 I40Y7ZgTom3QTnZFtG85zvdPSTC1CBRC5c6qlLH0BSyjf0nl9BOPCDPwEGg5C3wSCMWN
 CwtolAHrBTy5NGUweZAFl8RQYFOliKeyk0XbezDS7+PKdlk5pccH6QKlGCf297X9yp00
 /mKoDScnlK1VquakYB1Zs2Gckqj+T5lAJPq/ncu7IEjwgUSWJ3ZHgjZpL20+slX2I9fw
 qkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770067241; x=1770672041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dAg43hDJKLeJM0wu3Qk21qDtHG5d3oy3Ln1thTA7p9g=;
 b=cx+z9vdpj8Ma5NFnIeFR6UYpYNrM23p8qZy6iQiawVUWniVQTPop0eshVRX1Rt6H3Q
 G4JouxxhywmfUQa4sToc+bQtSNEp3IC8JJFn6oUAk7yy7uX32JJF4sLR1hD9P8hds0VO
 tNy+IkdExnltpjkbsQBfDCu3XPBuLV1DJaKRl2NxoXGsyEjwAVrpq+X7HyN/gvHXT/HD
 Fsaj/DgnkkV8yJ+kgynA1zfOR4ngZFB8xKXWAAQ9I/JBx4UETAZl9brCXcxgUApvRA88
 yORzZBS6RuMUbSgfrLphyJeheaUszVLkOXzf9iTgOMnadLsa1kmB7/mlIzxBWMamdb7E
 LwoA==
X-Gm-Message-State: AOJu0YyOBCHkd/gMneNzw8aMabDot1JpEo7oekNESZFfjq0RfPacxU1O
 VfeG0i+tZGFgWJdGr7thXMAHy3QeCytWw31eQqSb47BBIUzKxZYrMpP4wHoqk041G3K0/h1J0DV
 M0yTdOtI=
X-Gm-Gg: AZuq6aK25hvbN2qQJbiRHetTBKeaD+WydRK0nG+VMbeNI/ijTRnpudofAbr4WDIJevd
 KcMqt0k4CfK2+RsoX4uwDvS2AR+zCKFML5H9X1YDC7fBdrjJQbOLCo0uM5RKfn98R9+ZcAE8vtr
 aM109x7vI/4H5rctS6aowJG11OjySJ8x6tPYHUgwEVMIRxZZCSD7vMb68eXRnTnKT3UAaTdk90B
 FeLLlagaNsBOPLBxn606ONdirgPqVU2V2IbUyN/4W9/jAjxdXbuxRIdLuGjzi4ZKhECQ1TcIyke
 hKGMmZSstgLY3u+LQOiKoreG9V/OIltTd6wc/JGl0vQjUCcAr5tdMdaDori83BlRGTY9npVkPc9
 HX4ggZuKSWrhG4soK8sErPBw2ac+LEValSuiWoVimp+ZCmXZOlbVfmavK+1IOeR3m2+mohdXLGX
 nr2mvO5U1pCM2bc/0hzRBri2EYVs3+w4KS7nHOlX4rZ/skTs+ROz8+6J/4PjiV
X-Received: by 2002:a05:600c:4443:b0:475:dd8d:2f52 with SMTP id
 5b1f17b1804b1-482db4a317bmr178741595e9.32.1770067240787; 
 Mon, 02 Feb 2026 13:20:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830516a0a0sm13677965e9.15.2026.02.02.13.20.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:20:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/16] target/alpha: Inline translator_ldl()
Date: Mon,  2 Feb 2026 22:20:06 +0100
Message-ID: <20260202212019.94205-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202212019.94205-1-philmd@linaro.org>
References: <20260202212019.94205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

translator_ldl() is defined in "exec/translator.h" as:

  198 static inline uint32_t
  199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
  200 {
  201     return translator_ldl_end(env, db, pc, MO_TE);
  202 }

Directly use the inlined form, expanding MO_TE -> MO_LE
since Alpha use little-endian order.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251224160040.88612-5-philmd@linaro.org>
---
 target/alpha/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 3be97057465..48ac50a7cdf 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2905,7 +2905,7 @@ static void alpha_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     uint32_t insn = translator_ldl_end(cpu_env(cpu), &ctx->base,
-                                       ctx->base.pc_next, MO_TE);
+                                       ctx->base.pc_next, MO_LE);
 
     ctx->base.pc_next += 4;
     ctx->base.is_jmp = translate_one(ctx, insn);
-- 
2.52.0


