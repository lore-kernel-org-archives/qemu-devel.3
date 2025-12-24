Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD32E7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRJ4-0006i0-CD; Wed, 24 Dec 2025 11:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRIi-0006b2-Jx
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:01:38 -0500
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRIe-0006NB-3y
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:01:21 -0500
Received: by mail-ed1-x541.google.com with SMTP id
 4fb4d7f45d1cf-64d0d41404cso5887434a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592078; x=1767196878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1emzPSC3gusnZjhr/h3A8H4qzJRX881GxPIgVK4nvpA=;
 b=vy3+LJDzz1Sm6vazUeYigjV/fDgxJlMt7FE/zeWyTZbFDsuaWadrhEPZ608qIXxulH
 +c+8ij9MVka9YwXHTNdoFg8eTzTvAeXPWIksQ/7G1jxKIna8hZWPDTeYgEfZbR0tb4/0
 KuDS360CxvOxkWYK3oAHkjCDziDelKRaE68ydsJE2OGmSJYWEqiNd2WbCbyhOFCcrpYM
 dX6+ldCRAZzUcQF0a0FOJxtnVxI8wCVNGJqEeJ0Z1Gfa8BHu0yvlEsHr6EmZjwLopSDr
 pighFvdEKU+MtUa9fXdk8qjvtO6mnfte0mPIElX1o/9pKvLMZ3HWowR9kq007QJkpk1f
 fWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592078; x=1767196878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1emzPSC3gusnZjhr/h3A8H4qzJRX881GxPIgVK4nvpA=;
 b=caWi9thmTvykjJxMdf5V4YOQnd1nh9DuWgKLvD6hIC3vYTgprkSKwL4EezwfQSEjkP
 hxxHAVRezPCQiUIEPTXtWKOAn5OKqT3h1dH1oEKyhB18gGS1/FkklJCqFsHvnGA00ZrG
 WbmgqBUWfjCHiU6hZ1JWNaObapiDDov0G9HCYouAgz4gf0n+YMiRo8DQD3GmEuPGx3cb
 MDxHK+dPVLK0k+Cb/zrFS+k/GRaDYn+oRzglwi0JsJiZ0jFuGMTEYq9rqzBXcGcSyS56
 meMLxRuCE5ZmOG2CxzYBvzscFdzdyRpqpSFbz7BokDtKuE7eK+vDaWzvX3glVcaFGVHr
 yLAQ==
X-Gm-Message-State: AOJu0YxFVf+wWuLEXPnuE94Wte0D/Z5dIw9sqGd268d4p2uz++ss7zQi
 w59A58E63SUU1EMLDUW5gsR3OKn/cDKOVt5sqw2NPja1iOjwoI2fG8ZqUoWKUEW7fbnTAhEVfzU
 gUxTIw2Q=
X-Gm-Gg: AY/fxX5k2v11XkQq39t9yTTNMEmB++I7U7w4HyKA9if0Z1XtMbo/LAiWOC/4+qduHyx
 lom7ZZfKK6hqLeNkIZIeQUW2jLu7DFpp8P0rVFrFZ/W+eKhDXmzWiraNjC+E5J69loTAGcVi+ao
 osmKAxW/YLie5/dweRogmQR5WTtoRQbk1a9KItJd8bD8F8oifT3qbYw4qnWjQyem+2ERXudwO1Y
 wBfwhG+Zv3mRyU3fmoHuSY2/a7rj18D5z+JiIvJKU0hsMuNRkSnYVrYinAwG1Lo6tHE1ZsJknLo
 5HbCzvWvQTFyLPvZaKTPfVLB/1UpVVJVwJH7rQHE036m1aqSJLRL/ZOIJ03vSK0kQATzVwqGhH6
 whAMFn6nEBGkCHYIhgKQQ0AepVkOXMKmS1VexvJI/hRZdOFI91Msr9aZxhEoAIEPL8wWcBDwthI
 KmAoKOcS9h+gK0EXsIFMiuXPt6qEvohhoCi/LOJkCkDZS1ci5IFvtf+a0=
X-Google-Smtp-Source: AGHT+IGrmT47y0Tgu3x29eGCCLLf68kqVtHqncd25SuAU86IXXHvsZ2PvybVFWXBH7Rqa3Ry9PxR4Q==
X-Received: by 2002:a05:6402:51cb:b0:64b:3eeb:80b1 with SMTP id
 4fb4d7f45d1cf-64b8ec6cb05mr15828835a12.22.1766592077771; 
 Wed, 24 Dec 2025 08:01:17 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91056731sm17083232a12.8.2025.12.24.08.01.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:01:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/6] target/alpha: Inline translator_ldl()
Date: Wed, 24 Dec 2025 17:00:37 +0100
Message-ID: <20251224160040.88612-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224160040.88612-1-philmd@linaro.org>
References: <20251224160040.88612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x541.google.com
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

translator_ldl() is defined in "exec/translator.h" as:

  198 static inline uint32_t
  199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
  200 {
  201     return translator_ldl_end(env, db, pc, MO_TE);
  202 }

Directly use the inlined form, expanding MO_TE -> MO_LE
since Alpha use little-endian order.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index b1d8a4eb80a..48ac50a7cdf 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2904,8 +2904,8 @@ static void alpha_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 static void alpha_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    uint32_t insn = translator_ldl(cpu_env(cpu), &ctx->base,
-                                   ctx->base.pc_next);
+    uint32_t insn = translator_ldl_end(cpu_env(cpu), &ctx->base,
+                                       ctx->base.pc_next, MO_LE);
 
     ctx->base.pc_next += 4;
     ctx->base.is_jmp = translate_one(ctx, insn);
-- 
2.52.0


