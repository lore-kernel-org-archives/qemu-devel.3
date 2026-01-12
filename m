Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFFDCF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQkU-00074l-6H; Mon, 12 Jan 2026 17:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQkT-0006ur-4O
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:50:57 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQkR-0002yZ-Gb
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:50:56 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so42728515e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258253; x=1768863053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dIcnQlZCKCf6Mua+nsFC8JwK3c5WcbkZ3kOdiZ1laGY=;
 b=ZOns9aLqotlVlNOIwwsfsz7nnacFwomPFWX+fLewuKZ2u1y+hf4l2aD/JgksXjaCq7
 Bs8P6CEFTl3/f4SUinhEUL3Ur77ZB7MJ0fL6onPNwPLdkdFWLrcJQmu20dv5JyPKOXLW
 iyQI09vbfl25ArcPrcVOM6b/UIVQBJg1mluBHVLpinDt4t0/IJhlxkjC4bes3ASoxOaI
 Qrg6rGgRDaSmwm7hmQBHT7xy/Pm3eFGbw1zvKHlEAQshRx7rBPSv3iPye8JtcoXL007B
 AZjNwh+E93ciUdkpEzSXRngQLjfJNAsvCiWpBgpjn/fq9jo+QU9opy2Z5bKHgbbYtFPU
 fCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258253; x=1768863053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dIcnQlZCKCf6Mua+nsFC8JwK3c5WcbkZ3kOdiZ1laGY=;
 b=N+y8oBMYhB4YREK+vnH0PA3OAJukmKuB7P6TPHAQ46f6soBq8OJmMU8EtD/9O22JU2
 hEQqkANLVDN/m3Ucd5jpqoJ+X5+tt91pzSwUXP9b0atbLaNon5ElM7GKw7yi+otoogrI
 53/mWKUIFgdFe/rESVJBB0T2SoNIa1sI2JrmbhSaLHV/lBn1ClVXqUX34VAM5mO/7kLH
 rH2VSJwEozlCt5z4qVI6dAJWLM8+u5a+h8IEwj4Fcm4R5yk825gnnd9L9STqnQd7bPdL
 ZPUEk3SVwZ5QqrjMzqUxeOc85xBUQuGItV09fJbDsgSvEbq2eWzpTeL6ZpYwSWVxnW+Y
 Kwfg==
X-Gm-Message-State: AOJu0Yw4x8R5KC1SWlOZDz1YtOqhEVqkAjMHeSNCkCB4K9L41ooxwOK9
 qJcCHaibV6lStkThT+nOIAV1s7RAWjwCWvpvLRXXtb76q6Zc2c0ywbFgjpqqIgKlVUIZsd7U/7b
 EEtAUaM4=
X-Gm-Gg: AY/fxX7gaUS/N9GQRUph2FVFFt4czzjXvIWtnP4Z5W9dwpIzMTmY1zesGzf54Xvib4z
 0yAwRIdRhXAorOxazDGS0kTJLfsW1TS+crBio9PooMpXaoghPNmnM8ax612kkPQHWaQg4qJ1sJr
 c+yRH9Z3HKWrydUu2L7FCB4D3dKq8Hu3LhMcdjpIEylnspG4KeM5/CvKa7MmWer1SgeYVu8Q/7c
 Xds36qu0kLtvEAzMn4jFp+j1ckgWoPEN7msw+WyAuvp9Hk3bxJlsp5YpIrw39A8JUv4ksEq0tJA
 rzlnWwXJDOfFNU7acMbuSrRa3y3yY2A9BGNJKBH96U7ljaRo20nzTmpS00JaYNzKNpCrW0+ra6V
 NL7T4zfQQLlD2TkoSAdCUES5/d/x6hkaO2LcLGGOKyp8TKgSIEylonUC9PDKQUVrdtvuyUBlsqg
 I/PfTnoxIhhTs7dQxoGamPbWJArAXEdICuD/fGqdtLuiiXUDZuUE76vQT5Aers
X-Google-Smtp-Source: AGHT+IEaUecsoqsjy3vTxcRHTdLQ/R9mWEElxmPkVuXPBNlei8Zlh7a7VgEL2GAmB8WdiRTYbY7h8A==
X-Received: by 2002:a05:600c:45c7:b0:477:994b:dbb8 with SMTP id
 5b1f17b1804b1-47d84b2cf22mr228389335e9.11.1768258253505; 
 Mon, 12 Jan 2026 14:50:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f661a03sm390306615e9.13.2026.01.12.14.50.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:50:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/61] target/hexagon: Inline translator_ldl()
Date: Mon, 12 Jan 2026 23:48:12 +0100
Message-ID: <20260112224857.42068-18-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
since Hexagon use little-endian order.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20251224160708.89085-2-philmd@linaro.org>
---
 target/hexagon/translate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 3762faec4d8..e88e19cc1af 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -207,8 +207,9 @@ static int read_packet_words(CPUHexagonState *env, DisasContext *ctx,
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
@@ -987,8 +988,10 @@ static bool pkt_crosses_page(CPUHexagonState *env, DisasContext *ctx)
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


