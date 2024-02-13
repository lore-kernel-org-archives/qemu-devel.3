Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB23C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZsSN-0001lp-3f; Tue, 13 Feb 2024 08:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsSK-0001j3-D6
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:04:13 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsSG-00062o-0l
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:04:10 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33cdeee752aso208845f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 05:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707829445; x=1708434245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KuZWfpmBZUkGwZKw0Sk+TM4GOlyjT2THjQVZz4qS8UI=;
 b=ll17lamiTmRm8gBcmVtw/y8CRF2ZcCn+h/OAt6PtBuT67WNHR1ZA79CkFd+jkNGHVG
 orbMAZcdvH/cJAlr2tzyadzPtxJ75uRM4eg8wFSuWzvulmYOR+DzAS/j2MrCJPCiZEqN
 iQ2nZEtj7CCj7tFy9okw2trCkNOqX05o0CMv/BSuZ+eL/t2F8UxHtUi3sDeXDC1RmLHQ
 vCCrSmZs9a9M+1CObt+zAvfwbZPv8DW6QF/G7jEinH8Tat0TOV2v8mksanNYDQNYa+2H
 3QY7+GolqI74IqqTlFn/O2HrtqAhuDVWXVp7b8Mxu5rBqFXXC2IhHNjF4K/3kgAIgaiU
 5abQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707829445; x=1708434245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KuZWfpmBZUkGwZKw0Sk+TM4GOlyjT2THjQVZz4qS8UI=;
 b=ldBBjK9oNeUaCSRAZk2O2iH6JDIxAZyJIZ9sTCkOnO93c9qcjaFj6uYeOxDtvHeRpR
 bs3yRNxH2SynVVzZOQldwiOs66bbOs6J+iQWPZUbDBL6T/G0HqwiTklVd6e0lMwiC1Rj
 fGZfiV+K20Vubnv3juZp870wKcEl3K+jNd2dbcI8C4CMMNeMCvYYf59WZnMVyD6Wy/Zl
 hlMApVhVfZzkjr/VyNlLmYVaCMqZpxeaXrcHydOCCTaHNTX8ytMaSeRIldoL3mBz9Kr2
 LtgIXnIges2EcAm8zKVTu9DaIN7KhShVUpI5fbvHBaNV/C7ykcCDIw2MJU33G+tz7WZL
 qwzA==
X-Gm-Message-State: AOJu0Yw4wJpg0ygJlcLc2FCUKaBMzuGShaK1OiAilCvZKsoPVr9/qa5x
 ZTfzga26KmJpuDIDPEdqbZKbVR7zPt9cFgcSpAw9HNShkvFUJ8ETmigNtiMOWkxXD6q0SgHCZ9T
 n
X-Google-Smtp-Source: AGHT+IHHCfSP4vXF0xLTyjaOeG5kPZ7T9OvK5oydQWDqmZEObru9fJCsLKqR89XRp9yi6Jo+zxEG3A==
X-Received: by 2002:adf:fac2:0:b0:33c:d57e:e7be with SMTP id
 a2-20020adffac2000000b0033cd57ee7bemr1210769wrs.44.1707829445571; 
 Tue, 13 Feb 2024 05:04:05 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVrTdSGKpiCYf/g9xwm0f9az/F+EUZ/F2AgDRrJtltrJXIYh1HW9FGxApSvV/zH+eyL1QXzBH/GARQtBkxbX7MS0LUhnqgVgbofYX/AilLU+Ho9CzK4naTT9QwMH7WYRhJAqhxt75WHRZW2tLNrdbwDl8ipBdeuMFe5tamZRyBU6rmImPT3wb5VyN3Ev/tui7QBeRhjBJZun/PnNLCWBAhXQjdkwxeukUchfiYIuVoN1tJGGaw2fKegzNeGUQ5+w+pItmvL8f3vvLorWbEH7K2CUlZKqxnWQlU9Y41uA5nIMbTzbKvevzuxl3hvwOMHWmTue0b7qAvDEh50BWnI3GDJN2nYl4BWW0WvKe1PYfX58gjkHoag4CyoZzdcNC0XNfszGniWb0I+KMUDroU=
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a5d61d1000000b0033940016d6esm9459437wrv.93.2024.02.13.05.04.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 05:04:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Bernhard Beschow <shentey@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v4 03/12] hw/rx/rx62n: Only call qdev_get_gpio_in() when
 necessary
Date: Tue, 13 Feb 2024 14:03:32 +0100
Message-ID: <20240213130341.1793-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213130341.1793-1-philmd@linaro.org>
References: <20240213130341.1793-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
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


