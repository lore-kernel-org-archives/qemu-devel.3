Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93BBCF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQmV-0004R8-MQ; Mon, 12 Jan 2026 17:53:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQm4-0003X9-15
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:52:36 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQm2-0003Ko-JU
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:52:35 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fb03c3cf2so3688880f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258353; x=1768863153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rAXOytHhr00CERHS/TQPRTwfQMcs3RCYTklLAIVGfM4=;
 b=IS0rMBK4Li3dIUbY3GuZom2p6LYBK7kKxD/jnija+2XvQ9eEnDiXCCxVr9L1aFH+3K
 vjQGNbRIb7PF5E7hNyrSPyMULJWioqVD249vV3ftugw9RCAdm6S/LvfhlTQJTtFfVWkT
 xERh2peWuWy+UjeTFyytM39lN9+FE49+uvRxtWvPM9Vb1qzQ8IAOdXaKie5xcczojUSB
 +JIijSGR/DL+FAp17oF4/l8EAvNveu+E9UJ7ZqatQows9Rzd+/9BdabLW815G3qjC3MB
 kP88fx6sXnn4yFgc8eJkhS1pKVx6aI7e2dNV68nDUBGBaVPavH04Dulo2hJWtneKkob8
 aCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258353; x=1768863153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rAXOytHhr00CERHS/TQPRTwfQMcs3RCYTklLAIVGfM4=;
 b=wRjZLzQjNv78OGOK4fvU593Ht/xE0YCuRbXaICH0GZj3R4TUWPllwfR5RAzYARLhed
 1c6j5CbWnDohCxcTWniFbKPiWgCSjFemAO6ITEAHd3zs8PbDDT5j4kn159bJkuq1O5xR
 BzwLi7JKPF8WqaiFnt6uHktgqlVDhM0BEsK6UOAWKbI1BH7F+NWZ2WCQ1YWcRAAZUH+u
 pDt5e/Lj8j4zyZlfU/4cSIv3+eQ2y6Yuqd1E5a57Ywffjh3AGUuPcF1h6aDQvaLtQ84Y
 CnnaWZ8xxStfiXm+PbhfU+Dd/MjiGnPXTHBMTTt9B7L8nN9iOzZ35gInXX9Lnp0+d9V+
 2CRQ==
X-Gm-Message-State: AOJu0Yzm13OpyML0qwE99qGxjejHoAzQI5ur6ysbGUViCBc1cixKCHmz
 NRZv2Xr7sU12Hv1UKnn8D7ZLFiqNIkjL8e8+lSTgo9YuvdqmcCs9lxiK5ry20Hd0rbat7GprJrn
 X9nBQnuY=
X-Gm-Gg: AY/fxX7fiE/J6I55AOSA1z3D3fqW45oG9N0FGuhnoG4cqskbFYpOxuvXotxtzrgNDvM
 kXR224qEs0NkTqapbxuky72m0dXv7XL/pf/4RHlXEFkEkOzJFrilxfRaPw/hl3MXjMi/bofI+9l
 TOwj0xg8qkm7YCkR9Bwj5QiRXz7tCMjLOJ9avMP6CRKjNXgJSoxPXM7VJqpNEZTvjAVeiZlyTlO
 2THYe/UOgHkIPK1VPenrrBXOVBNHgsNINZkqnyJWb5n/TdkDvYz1Ss68BzAxXsMAHaoqLMPbOhv
 NI1APW+xhSyMuKRPe3XicKaRFIN/rlkXp1aRfkDS/MAl7sLmb5PmPp8tkSBnYoBKEN6bOgZdOCR
 2QVA+cUDVEEv4/2OJmZCIZ1SaSFZx1MGfGHWmGymhaLRkDAe41x0KsOHLugxf+KEB6WEj6Hqghe
 MKEqIVrQ0onqceVjoIpDCcolkxY7szrjuzgg/RmA+jh3NX7+//6L5mbh93N2Z9
X-Google-Smtp-Source: AGHT+IFpUhNxgPiBjiQ6aZtQLJiKtk1CnZ09rLH2uqoe8YAYk8Ok5vh5cbDE5VQFWRroSEz90yteUQ==
X-Received: by 2002:a05:6000:420c:b0:430:f7c9:94c3 with SMTP id
 ffacd0b85a97d-432c3634253mr23744956f8f.25.1768258352946; 
 Mon, 12 Jan 2026 14:52:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee870sm41083814f8f.36.2026.01.12.14.52.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:52:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/61] target/loongarch: Inline translator_ldl()
Date: Mon, 12 Jan 2026 23:48:26 +0100
Message-ID: <20260112224857.42068-32-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
since LoongArch use little-endian order.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20251224161456.89707-8-philmd@linaro.org>
---
 target/loongarch/tcg/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 055f6fb6046..c23d2a614ae 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -286,7 +286,8 @@ static void loongarch_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    ctx->opcode = translator_ldl(cpu_env(cs), &ctx->base, ctx->base.pc_next);
+    ctx->opcode = translator_ldl_end(cpu_env(cs), &ctx->base,
+                                     ctx->base.pc_next, MO_LE);
 
     if (!decode(ctx, ctx->opcode)) {
         qemu_log_mask(LOG_UNIMP, "Error: unknown opcode. "
-- 
2.52.0


