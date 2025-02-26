Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66420C021BF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 02:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn7R8-00067y-Oa; Tue, 25 Feb 2025 21:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3boC-ZwcKCq0iRagheRTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--venture.bounces.google.com>)
 id 1tn7R5-00067Z-Dc
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 21:46:11 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3boC-ZwcKCq0iRagheRTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--venture.bounces.google.com>)
 id 1tn7R3-0004XA-MY
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 21:46:11 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2fc17c3eeb5so12962462a91.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 18:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740537966; x=1741142766; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BDD10EWIJr8w7Wgp7k6xLR05vs09N/QbkM7e/fBevr8=;
 b=svFjc/2A5rmonqrgYNvvcazorgf+aNhdHH9DePdimgIYQLn0cMCZzfpcBuRtm37cnR
 NjjSnwe3kDH/MVGmLmiGDlqnJekj0h1tbfb659jmkeNmWZNElik1A6VEqNd5srM0Awo3
 9+O/tJRQz9UoDvUj5h4IfvsNZ9WABJrAQSDSPFfwhZL1wXpUBLMXMZ2Q2/+MASSvYSnI
 nM29MVOymiZY9jMPUktrHpoU9U36eGrhByjb0l8B6OgeOsMVYD9iODbh8znjV/YUiVXF
 8U6fSw4ufaad1SD48fxsugVmh4vY+4LUv23HHkSvr87YyFtRD5iiJ5f1IRU/P/1N3uEF
 YQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740537966; x=1741142766;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BDD10EWIJr8w7Wgp7k6xLR05vs09N/QbkM7e/fBevr8=;
 b=qo8LDTBMac7ESEwHxeDNqJrd36Dd8rJ3bV130AvvZIMJV9EAsVpsgqVB6xRUTIikTh
 modHfX2tkaGINA1rOkqnvZHVwGsMBgHl9/7U0lBQ9gbY0FAUXH4ftPlB9cmz1ORE+y49
 pLdvHLa7dd1FJsT0xcHXef+NvlfysEtZyS1SapMoxsbQ93PEo4DorGhXgM0AoH46sn1d
 PR+yUwcF02ggewIot38IL8eT1kS+OfXcdyx/9QFMNzVA6CNOFRuMxhQ6o+aqvXu2pYIH
 8MJgdscefng5RzpyzhC61FeN1wHd3BSl1JYNUSReRJRI4F6bVO6nOTYSBhJ5uzRVH9OE
 Q+Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbi5uobCQ03/+j8eTDUTVxzndUfLiI3ERGY7yNQm2ZBSpmuEsmOKyo+Cz3hddkP4U8y/i/ryA4/dl6@nongnu.org
X-Gm-Message-State: AOJu0YxKO/dqrXEVBCv0nxUoynItnIaWGjXJag+O8/h9V5dI/B4T8Kyq
 5O6eu9/6x4p2hSWkhH0rFy5o9xmrCP6FOL+FEkq0aKn910XN5aYDU7gxhJ6BO09Fxg8g+GyAif4
 G7QJcgg==
X-Google-Smtp-Source: AGHT+IEZ5lvIkriQq36sbQPJEErjMrmjiyi2Vim+XgfWwaPakqLtF/eyqlKMwG1jEMcihmJHRVLU/CxNuTKR
X-Received: from pjz6.prod.google.com ([2002:a17:90b:56c6:b0:2fc:3022:36b8])
 (user=venture job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1643:b0:2ea:a9ac:eee1
 with SMTP id 98e67ed59e1d1-2fce86ae28amr32848930a91.10.1740537966579; Tue, 25
 Feb 2025 18:46:06 -0800 (PST)
Date: Wed, 26 Feb 2025 02:46:03 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226024603.493148-1-venture@google.com>
Subject: [PATCH] hw/gpio: npcm7xx: fixup out-of-bounds access
From: Patrick Venture <venture@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, Patrick Venture <venture@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3boC-ZwcKCq0iRagheRTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--venture.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The reg isn't validated to be a possible register before
it's dereferenced for one case.  The mmio space registered
for the gpio device is 4KiB but there aren't that many
registers in the struct.

Google-Bug-Id: 397469048
Change-Id: I2fb8d0d3d41422baab22e8fc7e9fadd0f2ee7068
Signed-off-by: Patrick Venture <venture@google.com>
---
 hw/gpio/npcm7xx_gpio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/gpio/npcm7xx_gpio.c b/hw/gpio/npcm7xx_gpio.c
index 23e67424c9..2916056fae 100644
--- a/hw/gpio/npcm7xx_gpio.c
+++ b/hw/gpio/npcm7xx_gpio.c
@@ -220,8 +220,6 @@ static void npcm7xx_gpio_regs_write(void *opaque, hwaddr addr, uint64_t v,
         return;
     }
 
-    diff = s->regs[reg] ^ value;
-
     switch (reg) {
     case NPCM7XX_GPIO_TLOCK1:
     case NPCM7XX_GPIO_TLOCK2:
@@ -242,6 +240,7 @@ static void npcm7xx_gpio_regs_write(void *opaque, hwaddr addr, uint64_t v,
     case NPCM7XX_GPIO_PU:
     case NPCM7XX_GPIO_PD:
     case NPCM7XX_GPIO_IEM:
+        diff = s->regs[reg] ^ value;
         s->regs[reg] = value;
         npcm7xx_gpio_update_pins(s, diff);
         break;
-- 
2.48.1.658.g4767266eb4-goog


