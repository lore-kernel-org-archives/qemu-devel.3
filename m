Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAB4E7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYROl-0004sY-GA; Wed, 24 Dec 2025 11:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYROY-0004r1-5u
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:07:27 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYROU-0007qK-1m
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:07:24 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47d3ba3a4deso5918685e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592440; x=1767197240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytV7sRjMhiZ+N36QlRegSL9F2KH4Bl+JY5tBc1NaTPk=;
 b=h0xZG8ZwdKDdZa/tnEfzv1o4K3ukG/O4h9IZsVATiMDwJRYTYWczVstIk3SFZ4QXuA
 de1iq3pqyIm2I5MxpIwr8Y2ocBkoUy2PoDOpx7xhssD8jrMWOKMja0ms1PQIF6v1JcAA
 GEmvjbj3e+donmWVqAVfkwDOSgVB7rBcE9rGTomcdNR/NlG04JFcZU+oPkdru9t4D+NF
 eQB/jwTESFWafiCO/KY/OkbOclL6FnLNdp9QxgDd5cTegaLSs06vrpDLpdOjkjTI1i+V
 4MX9YZ7u3zsxV4uSyZUGxPP16boyR0jGn4HT0atx/pLwMHtO2WpOO/dDHbjvBkcB8jMK
 pDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592440; x=1767197240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ytV7sRjMhiZ+N36QlRegSL9F2KH4Bl+JY5tBc1NaTPk=;
 b=PK/7dOuvqGskTDxQsnFC5OhmYOIVQuaAhzn/Ug8OaslJA6XvYn6QJlinEGcyJz3/a/
 uMxE8VOtfWRiAItLjGMzOIfiwV7ITbJ4pJ/SuJW9VAKj3vsZCoSCoz4pdu0X16IRrVYl
 +MooRcKIQOD3kj2lCqXzw83l3OI3/QqKfuoNLrDUvGTCGfv4zwJIuiceYRbjjy+EDeZy
 RO0dWryALAobRhVUEmbW7BNZZr0OB8uamEImfJmEjQ6J/nAqYuZ9OonimHPySdm00W80
 Nttb/AapMWXD0FRrRi5uYVc/NBBWNmUkZt9WUnjDtuquqO7amS9CoJMz0e3fZ3MoYh1Z
 VGDg==
X-Gm-Message-State: AOJu0YxPvzg3e/BridlKkvg7rRRqpxI9M87ZJZHrC1V0r7Cvu2+NMGm0
 8a/EQ/Ndwe1fjqLjTHPXRG7sOwXKEX/98QQpw2rgdJ8ljYeu4kLrE1BUJ/+0HAhHI777DO07F4Z
 wz42jnik=
X-Gm-Gg: AY/fxX5kM9uuGaSAltRQFg94cLufhZg1kKGOm8r7ZVlBHcpjYaMW4iX7TBSEOAwHlw4
 Z7r30DfoqN2w/jT/xH/KoAnY2geF7WtU17I5wZ6MjhKTp/64eSkeX9XG29PXp1p3RrJ9itwO+fI
 ytsPuXTFkVkGBNS4oijinSCI9fSZ/iZYLaL31H+xD4uJgHtrJAkOYpZyW2ty175sH89nuYbdqNW
 /PPIr+GQCBbRSYcotxTANg0Yini1MwUYAIGgau1ucRcZ2rJNzFIP/xx/z3xVIxzfCgPuf1zq/eC
 7xPL0t7cucaCVO/lHR84mlvj1O/QPGwALQEAChX9O8+qs+JffVwytyP7MN5/+HnIAi9LwuH1bPB
 fYVXtGpv/X2HwdSwhcz9Kjvt9A0oPpAHt1InpjsQz1MeBQYGLTTLMN9euARgYkoUOfZkdtpPmRv
 x2cs96ttvb9opmJoerbyz1NaeDizwHQqg2vwndS8E9MyDt6EZTc/Do/dpECt9eeC348g==
X-Google-Smtp-Source: AGHT+IHvUfAVfJ6SEXf71XrOGsl1X60fJzbK5i6lX/FwO16WCyigbpNyeN8aCbYug9Gf/ytPf+Kl2Q==
X-Received: by 2002:a05:600c:c08d:b0:47d:403e:9b41 with SMTP id
 5b1f17b1804b1-47d403e9d5amr16454975e9.15.1766592440021; 
 Wed, 24 Dec 2025 08:07:20 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d192e88f5sm295258065e9.0.2025.12.24.08.07.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:07:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/3] target/hexagon: Inline translator_ldl()
Date: Wed, 24 Dec 2025 17:07:06 +0100
Message-ID: <20251224160708.89085-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224160708.89085-1-philmd@linaro.org>
References: <20251224160708.89085-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
since Hexagon use little-endian order.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hexagon/translate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 8fce219c0de..c37035c4774 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -203,8 +203,9 @@ static int read_packet_words(CPUHexagonState *env, DisasContext *ctx,
     memset(words, 0, PACKET_WORDS_MAX * sizeof(uint32_t));
     for (nwords = 0; !found_end && nwords < PACKET_WORDS_MAX; nwords++) {
         words[nwords] =
-            translator_ldl(env, &ctx->base,
-                           ctx->base.pc_next + nwords * sizeof(uint32_t));
+            translator_ldl_end(env, &ctx->base,
+                               ctx->base.pc_next + nwords * sizeof(uint32_t),
+                               MO_LE);
         found_end = is_packet_end(words[nwords]);
     }
     if (!found_end) {
@@ -966,8 +967,10 @@ static bool pkt_crosses_page(CPUHexagonState *env, DisasContext *ctx)
     int nwords;
 
     for (nwords = 0; !found_end && nwords < PACKET_WORDS_MAX; nwords++) {
-        uint32_t word = translator_ldl(env, &ctx->base,
-                            ctx->base.pc_next + nwords * sizeof(uint32_t));
+        uint32_t word = translator_ldl_end(env, &ctx->base,
+                                           ctx->base.pc_next
+                                           + nwords * sizeof(uint32_t),
+                                           MO_LE);
         found_end = is_packet_end(word);
     }
     uint32_t next_ptr =  ctx->base.pc_next + nwords * sizeof(uint32_t);
-- 
2.52.0


