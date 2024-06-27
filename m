Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB8FC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpKt-0001Am-OU; Thu, 27 Jun 2024 09:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpKh-00016p-Pc
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:38:40 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpKd-0006Mw-Ot
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:38:37 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3c9d70d93dbso5277945b6e.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719495513; x=1720100313;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ttjpe0Zy78QRlVICf1w8g9FNolQGU7Fei8nrc5VuhDU=;
 b=KZ3u8CeLG3wv+E4DOhDghvmofyc5dHvZx+zctdB75dA3iRSS7P9F6EEJl0jF+Sy3Ow
 su8DGKXcHu7eS7bBb77dScPdNAp+fmOajodGE3VNJfG+q5Wm+q4sOIf+HHEHS7F8sb7V
 NjU/KsKkR6Ga+VrG+fd0YoKfYzgRB7QitKVlP93pIyQxVag6cwBX8DIgapo/tZypxj3r
 83IhFfz95Erxwnvf6wUVhhMyeVGcPr5oMlNtcn89Yw/qihzSy9m81DpwyDTWKaM1Ag6L
 ouWHKSAsgmGZMjdgMbnwzJJhdhK97RhW8RdiIjQ8NwuhFnmR5OXDgYrWpbp415UIMk2X
 FlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719495513; x=1720100313;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ttjpe0Zy78QRlVICf1w8g9FNolQGU7Fei8nrc5VuhDU=;
 b=LsbFjIA/CBkH9CHpbLv0a60z67YsNbeNxkOtdvtBPmdCRGCmnPTou2001QUwH2kIAi
 P0QKzLGnbyGlOQqYYrtxkzfSG+ShiLA3UdN0pTSGDaLxisomIzekiGww/G2WR3gkLklD
 8nGH2x6+OhJLuBRtTrSuRYp3ZGygLEssY1ea9msrsnwpxAL/cFCoUAMcmgGXR0i1YX4t
 VGFuR4yEBuKav5GQd+Efi0H2RH6rYFBvZcYnvXzWPiV846GEjKz+/KUIDwh3Yyp2UJ7/
 +57mRLjYdcWwCfc85gCVWXFaj2MXf/P4lhFPCsKwy0+3zWCLkem3tRCHnGmIcDuhye4R
 wH7w==
X-Gm-Message-State: AOJu0YwIvWD9oUlDKIvPuHuIKPa7m8RRbx1RZCzPFeNAm990kW4ettOj
 r1KNNniGXgGwbQKBLSmRBYyfdmo21gJPhwaVd9BeoDvIIMk1/NmN8sA+c4If8sc=
X-Google-Smtp-Source: AGHT+IFN/aBIDxZnjlWX25a4chKiYG8RrkIkEkci/W6w41POb8g9HB7cE1bIk127xZ5DG/n29PtxHA==
X-Received: by 2002:a05:6808:1813:b0:3d5:d7f8:a3e0 with SMTP id
 5614622812f47-3d5d7f8a7f5mr1927401b6e.32.1719495513016; 
 Thu, 27 Jun 2024 06:38:33 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-706b48cae37sm1337617b3a.3.2024.06.27.06.38.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:38:32 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 22:37:47 +0900
Subject: [PATCH v2 04/15] hw/isa/vt82c686: Define a GPIO line between
 vt82c686 and i8259
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-san-v2-4-750bb0946dbd@daynix.com>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
In-Reply-To: <20240627-san-v2-0-750bb0946dbd@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::22a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This fixes qemu_irq array leak.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/isa/vt82c686.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 8582ac0322eb..629d2d568137 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -715,13 +715,14 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
     ViaISAState *s = VIA_ISA(d);
     DeviceState *dev = DEVICE(d);
     PCIBus *pci_bus = pci_get_bus(d);
-    qemu_irq *isa_irq;
+    qemu_irq isa_irq;
     ISABus *isa_bus;
     int i;
 
     qdev_init_gpio_out(dev, &s->cpu_intr, 1);
     qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
-    isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
+    qdev_init_gpio_in_named(dev, via_isa_request_i8259_irq, "i8259", 1);
+    isa_irq = qdev_get_gpio_in_named(dev, "i8259", 0);
     isa_bus = isa_bus_new(dev, pci_address_space(d), pci_address_space_io(d),
                           errp);
 
@@ -729,7 +730,7 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
         return;
     }
 
-    s->isa_irqs_in = i8259_init(isa_bus, *isa_irq);
+    s->isa_irqs_in = i8259_init(isa_bus, isa_irq);
     isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
     i8254_pit_init(isa_bus, 0x40, 0, NULL);
     i8257_dma_init(OBJECT(d), isa_bus, 0);

-- 
2.45.2


