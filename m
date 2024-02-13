Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEBCC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 11:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZrDH-0002Wz-9P; Tue, 13 Feb 2024 06:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZrDF-0002WQ-MG
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:44:33 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZrDD-0005jn-0o
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:44:33 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-410ee8ed659so11953675e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 03:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707824669; x=1708429469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G783pUtF6PYcylGtlwwKm9w5JZFbsrO0otjVXSR7Tcw=;
 b=N4RRqXNfY5drqQupJcFCyuj/kZFjVpLtbjxqr0XnH3h1grQWL+lcdOyPZDZZxrEUoF
 vWPcthhQvJt98mANevEs+7hvkoBGEliTcw4OU8b0LRNMq/x+cLS2vArHGLKOeX4tM1HM
 mM0dDvWCySWYffVpGVT4MLM7WU5t7Tj+BAgwEwjhkZFdma3UE0HV2IupXbe4vhgE4ZHy
 mJ6p8V+MF0tqCK3qDU8jba3bcJ0rXm7WrwQnvzk2bCAgz4lPtvgnX6sN8tOcR6Wyzgjk
 xaNKnjGwMYdofh7pOyrKLvdkoCgL2iXTOcSKDR7MzPlY8yfBn8kgqegUzNBt7mOpG5lE
 6vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707824669; x=1708429469;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G783pUtF6PYcylGtlwwKm9w5JZFbsrO0otjVXSR7Tcw=;
 b=l//qsZJWc7AC+YzObghb/04sTLu+F4dNzKr6gp+xB4Z57i9V9Ld+AfJwjvdei9eG6n
 aBtcw1r3GYDi7zYKtAtAWumsgY9JAPALDMrMf3F4R7FuusbcqxqT8hP6gPXzGCVs0rId
 z3PzrfhKtq9ZV0kLmIpbUvN3O7j7RGcqgFpAH5LOo3QRi4wsvJqHbjOpp4zgiSmQKohn
 NOyzSVqY8Ur1dG3nJvoEexErNQjId1GjYuxda7Z4EEOYuS28bXp2ba4Wr105Y9lOv3V3
 V/0YoMf6aYRhxakg2QBaE+QbMZ3BYkbCllODrKgeCKMlMemKlnhOz+k93kMdwiESXWz6
 aSNQ==
X-Gm-Message-State: AOJu0YzrYKR4f4tWRAaimCwDmoeQu/zPplMWiBPzIDt8qJWqB2FaDna5
 ABwNwB3V0eaaUlLot4GSHDsyR0fgGTJ7qrpLt2DFle89mn23aRj/4f/jqkMZFc+oN5vM5WPWy5Y
 4
X-Google-Smtp-Source: AGHT+IHs5RqWxEJz/+jl2sbK1985goHPPVnxZL9npjAR2jtrcQ9dFlkQicXKXZKAtN1Hi/3WItxn7g==
X-Received: by 2002:a05:600c:a4b:b0:410:6591:3d5d with SMTP id
 c11-20020a05600c0a4b00b0041065913d5dmr7219075wmq.14.1707824668980; 
 Tue, 13 Feb 2024 03:44:28 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU/T1mhVIRRFGdTce3pcwvCX+fsTmbdvty3gboMDFlX8yLGC+fmUuKZUG7nbFO1KDJGVQb+1PsIdPDtvQ8agOXPjoOKRojVXDtszONFVJlMT7pn1ZxS7E/GW6ICQdoajQe9b2UpUHyRpjTborcw160cuTvSQzAkAhHJ0iiSPb9LtHid8cfz7wW2dBbmB17aRtC7Zd5ZpOGsgglcysWfSq2Yp9rEDNjlb7nRdqDzhutEn2BPHynmu4WtXTgGrfzhhYGeclT99fjaz/jTgGxGz8QW6HKjcj/8dTtvvsbm1PZeemR/xd5cBp8cZX8eVAWJGbz1bI+4KTghxNkGszz9afj9LqIcWZvFhV4SUf7AhY7PqYqnQz8uSvPN3YczOw8uNTOPh2YOQ577Ie6ztzEvBV+Fk/uvPhB1JFEihA+GgycjE9ivjowXbZM=
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 fs20-20020a05600c3f9400b00410232ffb2csm11538718wmb.25.2024.02.13.03.44.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 03:44:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] hw/dma: Pass parent object to i8257_dma_init()
Date: Tue, 13 Feb 2024 12:44:25 +0100
Message-ID: <20240213114426.87836-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Set I8257 instances parent (migration isn't affected).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/dma/i8257.h | 2 +-
 hw/dma/i82374.c        | 2 +-
 hw/dma/i8257.c         | 4 +++-
 hw/i386/pc_piix.c      | 2 +-
 hw/isa/lpc_ich9.c      | 2 +-
 hw/isa/piix.c          | 2 +-
 hw/isa/vt82c686.c      | 2 +-
 hw/mips/jazz.c         | 2 +-
 8 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/hw/dma/i8257.h b/include/hw/dma/i8257.h
index f652345d65..4342e4a91e 100644
--- a/include/hw/dma/i8257.h
+++ b/include/hw/dma/i8257.h
@@ -45,6 +45,6 @@ struct I8257State {
     PortioList portio_pageh;
 };
 
-void i8257_dma_init(ISABus *bus, bool high_page_enable);
+void i8257_dma_init(Object *parent, ISABus *bus, bool high_page_enable);
 
 #endif
diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index f6ddfc51c5..e72aa2e1ce 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -129,7 +129,7 @@ static void i82374_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "DMA already initialized on ISA bus");
         return;
     }
-    i8257_dma_init(isa_bus, true);
+    i8257_dma_init(OBJECT(dev), isa_bus, true);
 
     portio_list_init(&s->port_list, OBJECT(s), i82374_portio_list, s,
                      "i82374");
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index de1d5b110c..24a54ca272 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -632,12 +632,13 @@ static void i8257_register_types(void)
 
 type_init(i8257_register_types)
 
-void i8257_dma_init(ISABus *bus, bool high_page_enable)
+void i8257_dma_init(Object *parent, ISABus *bus, bool high_page_enable)
 {
     ISADevice *isa1, *isa2;
     DeviceState *d;
 
     isa1 = isa_new(TYPE_I8257);
+    object_property_add_child(parent, "dma[*]", OBJECT(isa1));
     d = DEVICE(isa1);
     qdev_prop_set_int32(d, "base", 0x00);
     qdev_prop_set_int32(d, "page-base", 0x80);
@@ -646,6 +647,7 @@ void i8257_dma_init(ISABus *bus, bool high_page_enable)
     isa_realize_and_unref(isa1, bus, &error_fatal);
 
     isa2 = isa_new(TYPE_I8257);
+    object_property_add_child(parent, "dma[*]", OBJECT(isa2));
     d = DEVICE(isa2);
     qdev_prop_set_int32(d, "base", 0xc0);
     qdev_prop_set_int32(d, "page-base", 0x88);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 70d12bb1b5..999b7b806c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -310,7 +310,7 @@ static void pc_init1(MachineState *machine,
         qdev_prop_set_int32(DEVICE(rtc_state), "base_year", 2000);
         isa_realize_and_unref(rtc_state, isa_bus, &error_fatal);
 
-        i8257_dma_init(isa_bus, 0);
+        i8257_dma_init(OBJECT(machine), isa_bus, 0);
         pcms->hpet_enabled = false;
         idebus[0] = NULL;
         idebus[1] = NULL;
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 3924eec483..70c6e8a093 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -739,7 +739,7 @@ static void ich9_lpc_realize(PCIDevice *d, Error **errp)
 
     isa_bus_register_input_irqs(isa_bus, lpc->gsi);
 
-    i8257_dma_init(isa_bus, 0);
+    i8257_dma_init(OBJECT(d), isa_bus, 0);
 
     /* RTC */
     qdev_prop_set_int32(DEVICE(&lpc->rtc), "base_year", 2000);
diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 344bf32e54..2d30711b17 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -336,7 +336,7 @@ static void pci_piix_realize(PCIDevice *dev, const char *uhci_type,
         i8254_pit_init(isa_bus, 0x40, 0, NULL);
     }
 
-    i8257_dma_init(isa_bus, 0);
+    i8257_dma_init(OBJECT(dev), isa_bus, 0);
 
     /* RTC */
     qdev_prop_set_int32(DEVICE(&d->rtc), "base_year", 2000);
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index d3e0f6d01f..3622a530d2 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -686,7 +686,7 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
     s->isa_irqs_in = i8259_init(isa_bus, *isa_irq);
     isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
     i8254_pit_init(isa_bus, 0x40, 0, NULL);
-    i8257_dma_init(isa_bus, 0);
+    i8257_dma_init(OBJECT(d), isa_bus, 0);
 
     /* RTC */
     qdev_prop_set_int32(DEVICE(&s->rtc), "base_year", 2000);
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 5bf3e328db..1bc17e69d3 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -289,7 +289,7 @@ static void mips_jazz_init(MachineState *machine,
     /* ISA devices */
     i8259 = i8259_init(isa_bus, env->irq[4]);
     isa_bus_register_input_irqs(isa_bus, i8259);
-    i8257_dma_init(isa_bus, 0);
+    i8257_dma_init(OBJECT(rc4030), isa_bus, 0);
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
     pcspk = isa_new(TYPE_PC_SPEAKER);
     object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), &error_fatal);
-- 
2.41.0


