Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EFAC48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY8tj-0004dB-TL; Thu, 08 Feb 2024 13:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8tb-0004IW-Gs
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:13:14 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8tY-0006lP-Qr
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:13:11 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a30f7c9574eso9509166b.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 10:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707415987; x=1708020787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0ogzzUtX0pA4ogtPPYPzAFnKo2sHz3gs+YB0BMu1oo=;
 b=MNaP1E22rrBn2bXQkGF3n0cl51UKSFaGT9lmlFuI0mjYDoY7/Eb2l2QTCWkY6YFe8a
 Ts/MAVviCTFhBwvhWE4YuAABTpYHpOBuW//GikOQBp+52itomLOnMQrKy/6JJth4VIxc
 +YFLk+ntc7fakgIEh2/Mzd73ObaMN4yjXx5SDgsRZfFkD/VBVdOw7gm4+kOL5EHgUWtD
 W6oA9SkHvMb1iadMTrrZz4ImXab/uthPNAJJX5lUflp/+KQn+by35Meu4BOzhL2jybU1
 sZd4TPC5RrtJPKlJTVvYwAus3Avc2MWRmWHKW6Owf3U96lrUYvt2DAN03WYSmOewRH8k
 k0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707415987; x=1708020787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L0ogzzUtX0pA4ogtPPYPzAFnKo2sHz3gs+YB0BMu1oo=;
 b=RkVJL6CgP9vbYOnfvM0PnDDaYtRr33g7HvkvteZoYNr9l4Sf2tPqngp8aPd7jhZBek
 JNVzmbfilul7nEHpeEFaEvtmaiDL3Ypa6cz7IDCzyS/xV/sH6FKPmoLjHgXKtNP13qDO
 JtzoLiXd/DkoH88FL3NbPR40oTjt9E8SJKCGiHhT//mpsbD9MDOEPaN8sDE7Z5en84fJ
 CkAKWsMYPS8DYC1FeqI0lfeZ+3KcHqCZwWq/7xAaPdPpR0+Ej37h9xnEwsNI4+HMJbrL
 ZA8iArbiqPWy/POyUCfZ8lmbcYT8gE6CKhyyMyPCVbB45luBEf448co/oKVfUsLhaOXm
 3+wA==
X-Gm-Message-State: AOJu0YxcOVj2gpOR+k1TrxI4z4tMK+9DJE/04+uiKC8jLtVmJX15qfoU
 piZVyCzS+/ITjImvlx8p5cNRPw/fScLwUvBXPTJfAi9j/Mdhy2U18E9hrd7A/iFi2Rdp88VyGPx
 jFEo=
X-Google-Smtp-Source: AGHT+IHyu/cESW6qice2GNeILv1kJM/2jk2Swiu+ja3faVKE6PfaZkcLe5hD06+8ZqvV3Y//7KfclQ==
X-Received: by 2002:a17:906:5794:b0:a38:8d35:c8b4 with SMTP id
 k20-20020a170906579400b00a388d35c8b4mr75914ejq.46.1707415987030; 
 Thu, 08 Feb 2024 10:13:07 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWjPzvlEHE4oYPpySgAkE7/zjy3goOzi3NwSHkTTSWlgD0P6yoQ7k0sJB/Q+d4MdKul1AdEsOjJ0yOyR5lATAxU26+mLETi+tasJrtjM4E0kNlJUWJallVGABAm/WxVLT0rdhX8OxFjS976Yrati9OfnDRZ8n3oA8FM4o17D40f5o8yahIwdA7uc9KjVQCyKqv5CBpzdpIZAXfveZ9LXPnJoyjMR1iKzNKzYh9orktB+3cJEMhQAnmhP28LE4N/2xVV48MCHrB6hhWyNgPQLP4cqAFjwJWXkj+AJ8D6NNxO8xQbLB7rkutceBzmeQwAKRTRywrejh6Tt7O4XguPzLl99oH/sCNH1dCB/jweM3JeDjA=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 s18-20020a17090699d200b00a3ba3d8af9bsm296233ejn.136.2024.02.08.10.13.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Feb 2024 10:13:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v3 03/11] hw/rx/rx62n: Only call qdev_get_gpio_in() when
 necessary
Date: Thu,  8 Feb 2024 19:12:36 +0100
Message-ID: <20240208181245.96617-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240208181245.96617-1-philmd@linaro.org>
References: <20240208181245.96617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Instead of filling an array of all the possible IRQs, only call
qdev_get_gpio_in() when an IRQ is used. Remove the array from
RX62NState. Doing so we avoid calling qdev_get_gpio_in() on an
unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/rx/rx62n.h |  1 -
 hw/rx/rx62n.c         | 16 ++++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
index bcda583ab3..766fe0e435 100644
--- a/include/hw/rx/rx62n.h
+++ b/include/hw/rx/rx62n.h
@@ -67,7 +67,6 @@ struct RX62NState {
     MemoryRegion iomem2;
     MemoryRegion iomem3;
     MemoryRegion c_flash;
-    qemu_irq irq[NR_IRQS];
 
     /* Input Clock (XTAL) frequency */
     uint32_t xtal_freq_hz;
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index d3f61a6837..560f53a58a 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -148,14 +148,11 @@ static void register_icu(RX62NState *s)
         qlist_append_int(trigger_level, levelirq[i]);
     }
     qdev_prop_set_array(DEVICE(icu), "trigger-level", trigger_level);
-
-    for (i = 0; i < NR_IRQS; i++) {
-        s->irq[i] = qdev_get_gpio_in(DEVICE(icu), i);
-    }
     sysbus_realize(icu, &error_abort);
+
     sysbus_connect_irq(icu, 0, qdev_get_gpio_in(DEVICE(&s->cpu), RX_CPU_IRQ));
     sysbus_connect_irq(icu, 1, qdev_get_gpio_in(DEVICE(&s->cpu), RX_CPU_FIR));
-    sysbus_connect_irq(icu, 2, s->irq[SWI]);
+    sysbus_connect_irq(icu, 2, qdev_get_gpio_in(DEVICE(&s->icu), SWI));
     sysbus_mmio_map(icu, 0, RX62N_ICU_BASE);
 }
 
@@ -172,7 +169,8 @@ static void register_tmr(RX62NState *s, int unit)
 
     irqbase = RX62N_TMR_IRQ + TMR_NR_IRQ * unit;
     for (i = 0; i < TMR_NR_IRQ; i++) {
-        sysbus_connect_irq(tmr, i, s->irq[irqbase + i]);
+        sysbus_connect_irq(tmr, i,
+                           qdev_get_gpio_in(DEVICE(&s->icu), irqbase + i));
     }
     sysbus_mmio_map(tmr, 0, RX62N_TMR_BASE + unit * 0x10);
 }
@@ -190,7 +188,8 @@ static void register_cmt(RX62NState *s, int unit)
 
     irqbase = RX62N_CMT_IRQ + CMT_NR_IRQ * unit;
     for (i = 0; i < CMT_NR_IRQ; i++) {
-        sysbus_connect_irq(cmt, i, s->irq[irqbase + i]);
+        sysbus_connect_irq(cmt, i,
+                           qdev_get_gpio_in(DEVICE(&s->icu), irqbase + i));
     }
     sysbus_mmio_map(cmt, 0, RX62N_CMT_BASE + unit * 0x10);
 }
@@ -209,7 +208,8 @@ static void register_sci(RX62NState *s, int unit)
 
     irqbase = RX62N_SCI_IRQ + SCI_NR_IRQ * unit;
     for (i = 0; i < SCI_NR_IRQ; i++) {
-        sysbus_connect_irq(sci, i, s->irq[irqbase + i]);
+        sysbus_connect_irq(sci, i,
+                           qdev_get_gpio_in(DEVICE(&s->icu), irqbase + i));
     }
     sysbus_mmio_map(sci, 0, RX62N_SCI_BASE + unit * 0x08);
 }
-- 
2.41.0


