Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F47C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 09:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZRsT-0005uz-2G; Thu, 01 Aug 2024 05:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZRsR-0005h8-2y
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 05:13:39 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZRsP-0007lX-E9
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 05:13:38 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a7d26c2297eso825197066b.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 02:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722503615; x=1723108415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VBO+j2SR1ZsWcanf9TAJdGUloHo2mhXLXHkhbDgN34A=;
 b=TLbQoLqMq3J9BMfps2Qx5V7khyiN2OT7u8vPRD/Nzv61UexWXj1/crb5RYa/D9AL8l
 v0AvrbkkFUTrLec7Llmp/8FHHvIp2N/uQF0/V6X4K9nSI7iAVtwQwOD4KxjQK97sQt6U
 Kk4lgMDJjeQbbgVyW0B2ytvqzVL/mwMGbuqAfEMJ4N3CTHNOD8jxb5mA9DUitG5MSHXT
 hbEbkSEHZgbs40dn7SQEa00bun1h2mI4KkH9ej7WNf2ztZOPLAz6abyxdrzyk0o/CQea
 EMF7+HsuuzLtI/XTho6h2zz9RsVuYpdejuMzzr0U2ixxCw7mA5ZZwltWOcZN8iNUdmAo
 +rVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722503615; x=1723108415;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VBO+j2SR1ZsWcanf9TAJdGUloHo2mhXLXHkhbDgN34A=;
 b=Pm6+npM4GCdFgzWjbHLTBn+v4R/h8ScbUsaDsuVjUHdRRxRUXGEQM1v/N2yN/mfXbB
 RwtfLZrOtgkGdfk/8QR02a4nhaMknLh7lyeMfPEKF16kbii+o5cqijPycadQVnD/HZ+D
 /JlmnBzBvAoa+FIwJXqq9klSPtxAFW2GQM1Mn8ow12bew6rLgfruQhwctlEIHlVW6NON
 hJr1HSXX84HEPmNLxV0X5anmdxRJM0B8OfJOFE/P/FMP9NbrDZFAVot81+vQu6tHAq9z
 2Ppc3CsyvbTRmJ0mEGR7OcIXLwvYeo7XkFjqD9zm8mI+YlLmArUeHxdu0ov5F8lVdZrJ
 ZrnA==
X-Gm-Message-State: AOJu0YxhBLnimNrONAO5j126nfSOv4U7IpGjW2g2fnj9nvbtqmyQrsrn
 ZPaqr0CWvGfuEjA1iu5AUhlD0nSOSmIxwQhaYhpmp/vRxrdMXbRuudBorOF2QhdA+9PJrbMpneb
 r
X-Google-Smtp-Source: AGHT+IHZOLuUEEVD8hmVkDnqMkO+nOEe/PCGDOaov3V4i0fjiLcwRun9oxQyK0l1ilmN/+SaP7StJg==
X-Received: by 2002:a17:907:8dcf:b0:a7a:a5ae:11bd with SMTP id
 a640c23a62f3a-a7daf9c9045mr129556266b.67.1722503615301; 
 Thu, 01 Aug 2024 02:13:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab23f21sm869694266b.37.2024.08.01.02.13.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Aug 2024 02:13:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1] hw/pci-host/gt64120: Set PCI base address register
 write mask
Date: Thu,  1 Aug 2024 11:13:32 +0200
Message-ID: <20240801091332.49256-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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
  pci 0000:00:00.0: reg 0x24: [io  0x14000000-0x14000007]

Mention the datasheet referenced. Remove the "Malta assumptions ahead"
comment since the reset values from the datasheet are used.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/gt64120.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index e02efc9e2e..0b00e98e0a 100644
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
@@ -1213,17 +1215,28 @@ static void gt64120_realize(DeviceState *dev, Error **errp)
 
 static void gt64120_pci_realize(PCIDevice *d, Error **errp)
 {
-    /* FIXME: Malta specific hw assumptions ahead */
+
+    /* Values from chapter 17.16 "PCI Configuration" */
+
     pci_set_word(d->config + PCI_COMMAND, 0);
     pci_set_word(d->config + PCI_STATUS,
                  PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MEDIUM);
     pci_config_set_prog_interface(d->config, 0);
+
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_0, 0xfffff009);
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_1, 0xfffff009);
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_2, 0xfffff009);
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_3, 0xfffff009);
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_4, 0xfffff009);
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_5, 0xfffff009);
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


