Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0956CCD19A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mvn-0000mH-Vm; Thu, 16 Oct 2025 08:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MvC-0007aH-Dv
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:33 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mv4-0008K1-6g
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:28 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ecde0be34eso1127441f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617038; x=1761221838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vBiPH5q/yhS5xpe2Nar9obJeLKIx8MXvNJzNCy9FzDE=;
 b=kOWO2DcB250WG/tDqSdkz8GFft4BfhTLaTJYVcAcwu+yqd6dQ5DUZqMZGtd8L74uhb
 7wNycIvwLjcO+4PYVa3Fxv/z0+eS4FQNlpr9/DwgXAPvkMo+NOQ5l17ejGowbP6e/P2l
 3r9R+z1Iaa5hZFaEYtk9iNiuPxmYK2/7wXw3uFRUfdr13rNWp+eprQc8Eu4gAJCCC3cD
 ogzNlOnuWG8U9EZn9uYEBK+C4PJQTdf++YGjItTQxC57Uhmb41bydV3tGVBdk/AImbad
 mrzRiUK5+qZJjwn9NPCXiG+rWYyN3yPPEm9n9YGq7yrfiVCNYsJIJjXM2jiYPXJ4dAOd
 kBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617038; x=1761221838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vBiPH5q/yhS5xpe2Nar9obJeLKIx8MXvNJzNCy9FzDE=;
 b=dpNoGtbr3nhbdXnrcPaiGchqdmgzf37jyjvIeDEuTfrAu7OEJXeXumwxXGUU7JtN6k
 n5HO7Vja5BS9VW7jeZ5lJETBnrMrocCNZp2pmueWqdaLg0Z06FwQkfBMSPzOFY1Fp4Ud
 /Dpm23Ggf1WHoauDYeauG3a7S5TEtbFce81eD0iAUJuULxwc+7thFuvJfzQyKnPCfkvs
 JMEDgCkeqx/Vj0n1h+a1G2mCeY4iVdYps9Jb+53VFjmO14crQiEyeYYM4AKCtqYmlxjx
 vRuzrqn+ADZjjGfMH0gZTtGZXxNTT2xNsoGAHPUZ4lWsp1gDZFL0pbKLRZR4jm1i8K2s
 McPA==
X-Gm-Message-State: AOJu0Yx7okIJVfzq5i4TcqdAtrbbp50eixwAH6gxaOFrwkKwsUZtMtAj
 iB1X4UoZv9ZHL1l8UqCfmaGPKDDjfRcK7sVHNbJ8XL642coWDlK50+JOt/2q4MMzw9WOgEyrpKU
 wYyucadM=
X-Gm-Gg: ASbGncvT7Tmx/BFfD3zr1U8kaMT3HZAUSUUPeSFEDdqTOm4Y02/q7sLyoWtvTc5l8ys
 i46UbV215KEQIsG7b2MRgVPMPpT5M9qiA11ZkDu1UM5or1WZySNjyk9vRtnC3jpBFsDNavG7OPu
 T405O5A2pMm2I7PB1sqwHw0rjGBcr5E8eo1KQo7jBqLKkQsz8z0x3loMm+9gkUfGK8b0bNiF+Ll
 9gkM7Uy9crgk8xa4ibextZDmGNyKyj/wtAnpwYnRuulWTq6sizp43HW4wbo+AH2h47ykZf3tn7T
 tIWev8E2Bykc0XiBSNlgrLZgYVp5JhQONcAIV+sEEldZNJO2XUjH77YXTNYH07ATBmdXDqXoJI5
 ONqxLbQLmQRQ3fZuu+y9GWUP9l+DDACM3KnWPDbG0nzHkl/MC+eFPKdhUIcLdjWdFytUhdhRB6q
 hTH9ZeQcpi+/D+rNRyGv+sFnFe2O148JkseeGffX2AISZ+2idj4EQwY0G4VhdZZ1IX
X-Google-Smtp-Source: AGHT+IH3wZRLt3xw2HuLYSuMj0U73kQh8omu0A03jnZjHg3gmhrNcfre5HWpnEs2ginhFizHbbE8vQ==
X-Received: by 2002:a05:6000:26cb:b0:415:24ee:60ac with SMTP id
 ffacd0b85a97d-426fb6a19f9mr2729803f8f.5.1760617037884; 
 Thu, 16 Oct 2025 05:17:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711442d6c6sm23113815e9.6.2025.10.16.05.17.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:17:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/75] target/microblaze: Remove target_ulong use in
 gen_goto_tb()
Date: Thu, 16 Oct 2025 14:14:38 +0200
Message-ID: <20251016121532.14042-23-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

translator_use_goto_tb() expects a vaddr type since commit
b1c09220b4c ("accel/tcg: Replace target_ulong with vaddr in
translator_*()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251015180115.97493-4-philmd@linaro.org>
---
 target/microblaze/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 3dd74b021e8..b93a40fedbc 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -116,8 +116,7 @@ static void gen_raise_hw_excp(DisasContext *dc, uint32_t esr_ec)
     gen_raise_exception_sync(dc, EXCP_HW_EXCP);
 }
 
-static void gen_goto_tb(DisasContext *dc, unsigned tb_slot_idx,
-                        target_ulong dest)
+static void gen_goto_tb(DisasContext *dc, unsigned tb_slot_idx, vaddr dest)
 {
     if (translator_use_goto_tb(&dc->base, dest)) {
         tcg_gen_goto_tb(tb_slot_idx);
-- 
2.51.0


