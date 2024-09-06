Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC69CE7AA3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 12:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smY2i-0002Ng-HP; Fri, 06 Sep 2024 08:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1smY2L-0000vJ-P7; Fri, 06 Sep 2024 08:26:01 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1smY2J-00023z-UR; Fri, 06 Sep 2024 08:26:01 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-205659dc63aso19560465ad.1; 
 Fri, 06 Sep 2024 05:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725625557; x=1726230357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QEZSNiMltBd9mK+kQBlirKk2ymnhJmgw43ZBARc5nKQ=;
 b=R3VVVlX8St562LhYuMYLArze3kicEFbq7hD1tmVi16bzmsuDOYxJkVHGRRNo5Bnbk4
 ZVcPVlSbhMEKzpjznITszmVoDxtV53Rw2aNtvkmGVUosyH1BI1AmPEKkC/Nqi6DeDbJg
 Jtkz2BV08fB75sZwsRAnqS3DtIy5co+dzTbBK1P9oiU9IBSSl4n9HL0ezvDSSj8kQAcl
 U08ZAbJJXKtatTv6TTevSNv5faY0hPgRlqHiOnwMySYfMHXYxonsjxwzGcK9DL3Q700c
 yR7FmBqZ27IYV2fPbpm0QzBGM0J6GyAN39ePa1ZAlZn5WpFRl8lxAw7VB4GAonoupbv+
 Hk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725625557; x=1726230357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QEZSNiMltBd9mK+kQBlirKk2ymnhJmgw43ZBARc5nKQ=;
 b=dD+iylvhS5s1JJ7dUXjcKq7kfCwmC1NcEd2Uh8nKzpk91ZIwUw/xD1HmiiYDqbsJ1F
 0OKM8DaqSR5nhAYZbMf/2Blm64l4NvkS30qaECtEH5f1ebhl1NF7Q+x6kqBZvx2WQJ9b
 A1EyKPCm1eHdYK1AXjsjEL7GsWk5w0Ax/lHxeTNZ2KX2qfuwR2f5kujJljZ8U4+29duj
 80vo0ihcuIjD83KjJaaECEipFL/vCdzdTDf6+5T63SywU61V5h5SBkSVHsAkxQUvD395
 WOL/MxHDPxTrmhCmdzftzS1+Km1WDxGUrm+Fsuv4N6fktD3Cft/8VeJQPf2ijcnG6sV7
 S8Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc5aFiMrC3i+XYCltxXl19BInTphD+fHR9yXqzA8Db/vRUwGhni2sFV3OxO5aKwPI7K98PH9sChQ==@nongnu.org
X-Gm-Message-State: AOJu0YyIQEeUNXlccgLGHn5LCoK+5Ao8LBmlh4yEQqOZHs9fdFeg9G98
 F8E4PFWMBkcie1Pu118x2Xi6Hj4jXFDWHk+eefO/oTx2WO4E0lVXrGZXpQ==
X-Google-Smtp-Source: AGHT+IFfP4bBiK0JP5nk8DdXh+75JeYuZp+F1Vq7f0MiaSOxRvHQI9s3wMXqyHbrz+10XDEqX1mt9Q==
X-Received: by 2002:a17:903:22c1:b0:1fd:5eab:8c76 with SMTP id
 d9443c01a7336-206f05e7881mr22132985ad.41.1725625556946; 
 Fri, 06 Sep 2024 05:25:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206aea351a3sm42738875ad.162.2024.09.06.05.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:25:56 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, BALATON Zoltan <balaton@eik.bme.hu>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 6/8] usb/uhci: Add aspeed specific read and write functions
Date: Fri,  6 Sep 2024 05:25:40 -0700
Message-ID: <20240906122542.3808997-7-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906122542.3808997-1-linux@roeck-us.net>
References: <20240906122542.3808997-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Aspeed uses non-standard UHCI register addresses. On top of that,
registers are 32 bit wide instead of 16 bit.

Map Aspeed UHCI addresses to standard UHCI addresses and where needed
combine/split 32 bit accesses to solve the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/usb/hcd-uhci-sysbus.c | 101 +++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-uhci-sysbus.h |  11 +++++
 2 files changed, 112 insertions(+)

diff --git a/hw/usb/hcd-uhci-sysbus.c b/hw/usb/hcd-uhci-sysbus.c
index 6f2428cc15..ba5398beeb 100644
--- a/hw/usb/hcd-uhci-sysbus.c
+++ b/hw/usb/hcd-uhci-sysbus.c
@@ -20,7 +20,9 @@
 
 #include "qemu/osdep.h"
 #include "hw/irq.h"
+#include "hw/usb/uhci-regs.h"
 #include "qapi/error.h"
+#include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
@@ -88,6 +90,99 @@ static void uhci_sysbus_class_init(ObjectClass *klass, void *data)
     dc->reset = uhci_sysbus_reset_sysbus;
 }
 
+static hwaddr aspeed_uhci_chip_to_uhci(hwaddr addr)
+{
+    switch (addr) {
+    case 0x00:
+        return UHCI_USBCMD;
+    case 0x04:
+        return UHCI_USBSTS;
+    case 0x08:
+        return UHCI_USBINTR;
+    case 0x0c:
+        return UHCI_USBFLBASEADD;
+    case 0x80:
+        return UHCI_USBFRNUM;
+    case 0x84:
+        return UHCI_USBSOF;
+    case 0x88:
+        return UHCI_USBPORTSC1;
+    case 0x8c:
+        return UHCI_USBPORTSC2;
+    case 0x90:
+        return UHCI_USBPORTSC3;
+    case 0x94:
+        return UHCI_USBPORTSC4;
+    default:        /* unimplemented */
+        qemu_log_mask(LOG_UNIMP, "Unimplemented Aspeed UHCI register 0x%lx\n",
+                      addr);
+        return 0x20;
+    }
+}
+
+/*
+ * Aspeed UHCI registers are 32 bit wide.
+ * Convert to 16 bit to access standard UHCI code.
+ */
+static uint64_t aspeed_uhci_port_read(void *opaque, hwaddr addr, unsigned size)
+{
+    UHCIState *uhci = opaque;
+    MemoryRegion *mr = &uhci->mem;
+    hwaddr uaddr = aspeed_uhci_chip_to_uhci(addr);
+
+    if (uaddr == UHCI_USBFLBASEADD) {
+        return mr->ops->read(opaque, uaddr, 2) |
+               mr->ops->read(opaque, uaddr + 2, 2) << 16;
+    }
+    return mr->ops->read(opaque, uaddr, 2);
+}
+
+static void aspeed_uhci_port_write(void *opaque, hwaddr addr, uint64_t val,
+                                   unsigned size)
+{
+    UHCIState *uhci = opaque;
+    MemoryRegion *mr = &uhci->mem;
+    hwaddr uaddr = aspeed_uhci_chip_to_uhci(addr);
+
+    if (uaddr == UHCI_USBFLBASEADD) {
+        mr->ops->write(opaque, uaddr, val & 0xffff, 2);
+        mr->ops->write(opaque, uaddr + 2, val >> 16, 2);
+    } else {
+        mr->ops->write(opaque, uaddr, val, 2);
+    }
+}
+
+static const MemoryRegionOps aspeed_uhci_mmio_ops = {
+    .read = aspeed_uhci_port_read,
+    .write = aspeed_uhci_port_write,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void uhci_sysbus_aspeed_realize(DeviceState *dev, Error **errp)
+{
+    UHCISysBusState *s = SYSBUS_UHCI(dev);
+    ASPEEDUHCIState *f = ASPEED_UHCI(dev);
+    UHCIState *uhci = &s->uhci;
+
+    uhci_sysbus_realize(dev, errp);
+
+    memory_region_init_io(&f->mem_aspeed, OBJECT(f), &aspeed_uhci_mmio_ops,
+                          uhci, "aspeed", 0x100);
+    memory_region_add_subregion(&uhci->mem, 0, &f->mem_aspeed);
+}
+
+static void uhci_sysbus_aspeed_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = uhci_sysbus_aspeed_realize;
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);
+    dc->desc = "ASPEED UHCI USB Controller";
+    dc->reset = uhci_sysbus_reset_sysbus;
+}
+
 static const TypeInfo uhci_sysbus_types[] = {
     {
         .name          = TYPE_SYSBUS_UHCI,
@@ -95,6 +190,12 @@ static const TypeInfo uhci_sysbus_types[] = {
         .instance_size = sizeof(UHCISysBusState),
         .class_init    = uhci_sysbus_class_init,
     },
+    {
+        .name          = TYPE_ASPEED_UHCI,
+        .parent        = TYPE_SYSBUS_UHCI,
+        .instance_size = sizeof(ASPEEDUHCIState),
+        .class_init    = uhci_sysbus_aspeed_class_init,
+    },
 };
 
 DEFINE_TYPES(uhci_sysbus_types);
diff --git a/hw/usb/hcd-uhci-sysbus.h b/hw/usb/hcd-uhci-sysbus.h
index c491b9fc92..75c4716c40 100644
--- a/hw/usb/hcd-uhci-sysbus.h
+++ b/hw/usb/hcd-uhci-sysbus.h
@@ -4,6 +4,7 @@
 #include "hcd-uhci.h"
 
 #define TYPE_SYSBUS_UHCI "sysbus-uhci"
+#define TYPE_ASPEED_UHCI "aspeed-uhci"
 
 OBJECT_DECLARE_SIMPLE_TYPE(UHCISysBusState, SYSBUS_UHCI)
 
@@ -20,4 +21,14 @@ struct UHCISysBusState {
     uint32_t num_ports;
 };
 
+OBJECT_DECLARE_SIMPLE_TYPE(ASPEEDUHCIState, ASPEED_UHCI)
+
+struct ASPEEDUHCIState {
+    /*< private >*/
+    UHCISysBusState parent_obj;
+    /*< public >*/
+
+    MemoryRegion mem_aspeed;
+};
+
 #endif /* HW_USB_HCD_UHCI_SYSBUS_H */
-- 
2.45.2


