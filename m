Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4DCC52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJjz-0001Jv-E8; Tue, 06 Aug 2024 08:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJi0-0001fi-7B
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:54:38 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJhy-0000P5-BN
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:54:35 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7a9cf7d3f3so77308166b.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948872; x=1723553672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypdbeuI3/3zkqxrrQlfqtvt5UnR+ONpIVnv+X7Sc7F4=;
 b=UOwVR5EUu5a2N+T0yWbOTY3Z1t0/daSYxvlHH6vbtNMi24zwRz1UrQYquzrRCv2zi1
 TjZicPov6itbsZ1JowtklgUZnDVuMeMw7S5cYQMIMcUpa8RHpiRACxpRhVuoBgZicRza
 Mzxkno0EKv48aTBXyo5iCXvQVruEOawD1RYsHWLshOmnSaZO+ObM+KeZn2No3FfnE6g9
 pHiVFo6WuI9y5+9ZOghfkZHqQsi01SPoeJgmdiV7TqZG8NabflJsrcJVSdNRr+vnP56P
 DumRxeP5jBaBW8b2dm5YGNnVDbFiP2tEbkqY1kG2dBKmp1HQfjFA6JRkEyfRZZ1qeB9B
 MFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948872; x=1723553672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ypdbeuI3/3zkqxrrQlfqtvt5UnR+ONpIVnv+X7Sc7F4=;
 b=EOnVbjSfbHEEhqOm/6g6OFK5FANXzKi41e/M9vcTHiREygpmd3VB09Qfq/OHSAHJai
 NtJGQ6Hv+Wtd4PpZyyWhtcoW1tdxTinDRfAtJesmeiFzsko/WHgtk8wuIykmEFWEqMnj
 qfT3UlcHf/3JLuyisrXaktcMIO8K3TnV7cHdZO/MM+tF0UmBs0h9BtgEskwrKHavJsAY
 3XVClVEoNwqBvDWmGot9+1aBkXpooj6RW0A0My/1EDqCAf8FEEOGq0tfv9qfIMl/3dyk
 mFhqZgV25s/mICdFgvR/yk18rEZuwdhF7vdPSUw7vaLgvAhDmdEnS3Btes+WOhR92QXs
 mhuQ==
X-Gm-Message-State: AOJu0Yxieg7tgF1zqp6nLX2cyaWIoN6q4PDgw4G70hv7IEF75a38pgKA
 5Zpr36Fid7Xf42H8dGUUO7AC9K82/lIdCTV5J4ElE7XXAOim90CxvSzfddc1ZtsflHME67qkWUK
 V
X-Google-Smtp-Source: AGHT+IGL/4huUwzcaLaq6PgwpIBAIzK6jpN8ZZXtAH1L3lKCQWPQ2lA7CiO9A/Y6o0KABCklX7vuug==
X-Received: by 2002:a17:907:3e1a:b0:a75:2781:a5c4 with SMTP id
 a640c23a62f3a-a7dc4ea9ebdmr1048774766b.29.1722948872256; 
 Tue, 06 Aug 2024 05:54:32 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0c0d5sm545644666b.48.2024.08.06.05.54.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:54:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 25/28] hw/pci-host/gt64120: Set PCI base address register write
 mask
Date: Tue,  6 Aug 2024 14:51:53 +0200
Message-ID: <20240806125157.91185-26-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

When booting Linux we see:

  PCI host bridge to bus 0000:00
  pci_bus 0000:00: root bus resource [mem 0x10000000-0x17ffffff]
  pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
  pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
  pci 0000:00:00.0: [11ab:4620] type 00 class 0x060000
  pci 0000:00:00.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
  pci 0000:00:00.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
  pci 0000:00:00.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
  pci 0000:00:00.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
  pci 0000:00:00.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)

This is due to missing base address register write mask.
Add it to get:

  PCI host bridge to bus 0000:00
  pci_bus 0000:00: root bus resource [mem 0x10000000-0x17ffffff]
  pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
  pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
  pci 0000:00:00.0: [11ab:4620] type 00 class 0x060000
  pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00000fff pref]
  pci 0000:00:00.0: reg 0x14: [mem 0x01000000-0x01000fff pref]
  pci 0000:00:00.0: reg 0x18: [mem 0x1c000000-0x1c000fff]
  pci 0000:00:00.0: reg 0x1c: [mem 0x1f000000-0x1f000fff]
  pci 0000:00:00.0: reg 0x20: [mem 0x1be00000-0x1be00fff]
  pci 0000:00:00.0: reg 0x24: [io  0x14000000-0x14000fff]

Since this device is only used by MIPS machines which aren't
versioned, we don't need to update migration compat machinery.

Mention the datasheet referenced. Remove the "Malta assumptions
ahead" comment since the reset values from the datasheet are used.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20240802213122.86852-2-philmd@linaro.org>
---
 hw/pci-host/gt64120.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index e02efc9e2e..573d2619ee 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -1,6 +1,8 @@
 /*
  * QEMU GT64120 PCI host
  *
+ * (Datasheet GT-64120 Rev 1.4 from Sep 14, 1999)
+ *
  * Copyright (c) 2006,2007 Aurelien Jarno
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
@@ -1213,17 +1215,27 @@ static void gt64120_realize(DeviceState *dev, Error **errp)
 
 static void gt64120_pci_realize(PCIDevice *d, Error **errp)
 {
-    /* FIXME: Malta specific hw assumptions ahead */
+    /* Values from chapter 17.16 "PCI Configuration" */
+
     pci_set_word(d->config + PCI_COMMAND, 0);
     pci_set_word(d->config + PCI_STATUS,
                  PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MEDIUM);
     pci_config_set_prog_interface(d->config, 0);
+
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_0, 0xfffff008); /* SCS[1:0] */
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_1, 0xfffff008); /* SCS[3:2] */
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_2, 0xfffff008); /* CS[2:0] */
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_3, 0xfffff008); /* CS[3], BootCS */
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_4, 0xfffff000); /* ISD MMIO */
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_5, 0xfffff001); /* ISD I/O */
+
     pci_set_long(d->config + PCI_BASE_ADDRESS_0, 0x00000008);
     pci_set_long(d->config + PCI_BASE_ADDRESS_1, 0x01000008);
     pci_set_long(d->config + PCI_BASE_ADDRESS_2, 0x1c000000);
     pci_set_long(d->config + PCI_BASE_ADDRESS_3, 0x1f000000);
     pci_set_long(d->config + PCI_BASE_ADDRESS_4, 0x14000000);
     pci_set_long(d->config + PCI_BASE_ADDRESS_5, 0x14000001);
+
     pci_set_byte(d->config + 0x3d, 0x01);
 }
 
-- 
2.45.2


