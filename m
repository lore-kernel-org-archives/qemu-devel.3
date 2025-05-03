Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EB1C369D9
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 08:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uB7md-00089N-Le; Sat, 03 May 2025 03:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mc-00089B-56
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mY-0006hM-SN
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746259173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VuFrzB+x2Fw/uMdbdxESZXpgU/xX6NGKzdHSeZxnBg=;
 b=MyO6sYgXBrZ/PfDFEDJIMZ3iLuTBqV7IdHHSiQvPH00pT0FExXA+j4X6qfCV2s9iP6ZKhk
 50v2H+ADJMfnPbY+tYIymEfNVG4hYp4IkT6LIRPPcaZ32AohuRaIdr3d4kv02mlwcI/8jP
 Ym0r7GmPFIq8FECAw4Hh4gWnMGctMHY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-LBBFJ-1lOLyb_Ho-TuP-jw-1; Sat, 03 May 2025 03:59:32 -0400
X-MC-Unique: LBBFJ-1lOLyb_Ho-TuP-jw-1
X-Mimecast-MFC-AGG-ID: LBBFJ-1lOLyb_Ho-TuP-jw_1746259171
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43ceb011ea5so14463145e9.2
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 00:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746259170; x=1746863970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7VuFrzB+x2Fw/uMdbdxESZXpgU/xX6NGKzdHSeZxnBg=;
 b=W5+EqNy978f8qClsw/jUaULdAVoisTR0UXglmLtAFOGXnzxn0nbrRnmlFeADNkZHFY
 /M6YOrX8uEwuhKVchM+BkcrKQ9XpIvOnZAZYeChRAnlObGkCBFAR7YToD+cXUxGHRDD2
 I7EycPR9zG+kLWA669rxf93y+KIkzqr2PEwKXmp5Nsu3fdmZCn7H5GRvgxU5hBmi6hDV
 OJmDaljo0Q8jkbQcFUckjDm+haOHLdCJQuu2aFZBpMBEamIBA4OL7/s5EgKQNJzgVojS
 jsLPfhay/zt4h2KZyqsVLPi5oWoZcCPvZuVzeEIn3Bhl77PZG8qPWd+kaJp+g2yPI774
 pIWA==
X-Gm-Message-State: AOJu0YzZuh5hH6n+QUbqRn3GdyEknirNR9dD2W+ePEADgHnZJdB/LrdS
 /drdi2zSwyiEamcLioWXbh1ULL65QeijKd/eQ1YnDtzEcYllz8OEb36USR56Mx3LoWxoyjF2D4I
 iaA6VLEG+2rsryXdpNSPiBuIcSw3TKumESXAEP7ENJ3B+3Deydiscoi2P/xeSyFdqNt1ujrZif0
 xHhA1im5xRlvd5HmOnX6IJ2Bu2+xG3DZVT1mFt
X-Gm-Gg: ASbGncupSAYLha5RPgKLlWiTeCdRGio/EXc78Jta8Kmd/VZYjfHr0uG29AAPFe2p5gH
 1Crl/zr9afr0K0EkWRnp6mzGo+Yh6MkReA+U5CpEHVQzkaIgwdjZPAsswzrAELjYjTXQDG5PJpf
 B2+qOGRhVpMXFkb9Y4NqofHLKS2fJiCDAanZ24thCI8PVqZHMQRwu2TMRAme2VwXhadr7Na27OC
 A4Acck5yPUOo/xRHGXAe5OhI8Ub1//LynHC3XFJD6Oqsx7abynnzV6Gh1rYnmRuCDt6IPRH0r3O
 WxenCTDB4ib4O0E=
X-Received: by 2002:a5d:5985:0:b0:3a0:8298:143d with SMTP id
 ffacd0b85a97d-3a09fd77692mr233942f8f.13.1746259170549; 
 Sat, 03 May 2025 00:59:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjrp3cr7uAxwn22S4hObkqrzoxkVGxKqBFnaykHWlAtmZjwwwp30M/xCQ1gp3ZWlbWuGiGJA==
X-Received: by 2002:a5d:5985:0:b0:3a0:8298:143d with SMTP id
 ffacd0b85a97d-3a09fd77692mr233930f8f.13.1746259170162; 
 Sat, 03 May 2025 00:59:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0cd6sm4146454f8f.5.2025.05.03.00.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 00:59:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 11/13] hw/char/serial: Remove unused prog_if compat property
Date: Sat,  3 May 2025 09:58:56 +0200
Message-ID: <20250503075858.277375-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503075858.277375-1-pbonzini@redhat.com>
References: <20250503075858.277375-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

This property was added to preserve previous value when this was fixed
in version 2.1 but the last machine using it was already removed when
adding diva-gsp leaving this property unused and unnecessary.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Link: https://lore.kernel.org/r/20250502095524.DE1F355D264@zero.eik.bme.hu
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/diva-gsp.c         |  6 ++----
 hw/char/serial-pci-multi.c |  7 ++-----
 hw/char/serial-pci.c       | 10 ++--------
 3 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/hw/char/diva-gsp.c b/hw/char/diva-gsp.c
index 60f933191d2..e1f0713cb79 100644
--- a/hw/char/diva-gsp.c
+++ b/hw/char/diva-gsp.c
@@ -51,7 +51,6 @@ typedef struct PCIDivaSerialState {
     SerialState  state[PCI_SERIAL_MAX_PORTS];
     uint32_t     level[PCI_SERIAL_MAX_PORTS];
     qemu_irq     *irqs;
-    uint8_t      prog_if;
     bool         disable;
 } PCIDivaSerialState;
 
@@ -124,8 +123,8 @@ static void diva_pci_realize(PCIDevice *dev, Error **errp)
     size_t i, offset = 0;
     size_t portmask = di.omask;
 
-    pci->dev.config[PCI_CLASS_PROG] = pci->prog_if;
-    pci->dev.config[PCI_INTERRUPT_PIN] = 0x01;
+    pci->dev.config[PCI_CLASS_PROG] = 2; /* 16550 compatible */
+    pci->dev.config[PCI_INTERRUPT_PIN] = 1;
     memory_region_init(&pci->membar, OBJECT(pci), "serial_ports", 4096);
     pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &pci->membar);
     pci->irqs = qemu_allocate_irqs(multi_serial_irq_mux, pci, di.nports);
@@ -178,7 +177,6 @@ static const Property diva_serial_properties[] = {
     DEFINE_PROP_CHR("chardev2",  PCIDivaSerialState, state[1].chr),
     DEFINE_PROP_CHR("chardev3",  PCIDivaSerialState, state[2].chr),
     DEFINE_PROP_CHR("chardev4",  PCIDivaSerialState, state[3].chr),
-    DEFINE_PROP_UINT8("prog_if",  PCIDivaSerialState, prog_if, 0x02),
     DEFINE_PROP_UINT32("subvendor", PCIDivaSerialState, subvendor,
                                     PCI_DEVICE_ID_HP_DIVA_TOSCA1),
 };
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index fb184c2e6dc..13df272691a 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -46,7 +46,6 @@ typedef struct PCIMultiSerialState {
     SerialState  state[PCI_SERIAL_MAX_PORTS];
     uint32_t     level[PCI_SERIAL_MAX_PORTS];
     IRQState     irqs[PCI_SERIAL_MAX_PORTS];
-    uint8_t      prog_if;
 } PCIMultiSerialState;
 
 static void multi_serial_pci_exit(PCIDevice *dev)
@@ -97,8 +96,8 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
     SerialState *s;
     size_t i, nports = multi_serial_get_port_count(pc);
 
-    pci->dev.config[PCI_CLASS_PROG] = pci->prog_if;
-    pci->dev.config[PCI_INTERRUPT_PIN] = 0x01;
+    pci->dev.config[PCI_CLASS_PROG] = 2; /* 16550 compatible */
+    pci->dev.config[PCI_INTERRUPT_PIN] = 1;
     memory_region_init(&pci->iobar, OBJECT(pci), "multiserial", 8 * nports);
     pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &pci->iobar);
 
@@ -133,7 +132,6 @@ static const VMStateDescription vmstate_pci_multi_serial = {
 static const Property multi_2x_serial_pci_properties[] = {
     DEFINE_PROP_CHR("chardev1",  PCIMultiSerialState, state[0].chr),
     DEFINE_PROP_CHR("chardev2",  PCIMultiSerialState, state[1].chr),
-    DEFINE_PROP_UINT8("prog_if",  PCIMultiSerialState, prog_if, 0x02),
 };
 
 static const Property multi_4x_serial_pci_properties[] = {
@@ -141,7 +139,6 @@ static const Property multi_4x_serial_pci_properties[] = {
     DEFINE_PROP_CHR("chardev2",  PCIMultiSerialState, state[1].chr),
     DEFINE_PROP_CHR("chardev3",  PCIMultiSerialState, state[2].chr),
     DEFINE_PROP_CHR("chardev4",  PCIMultiSerialState, state[3].chr),
-    DEFINE_PROP_UINT8("prog_if",  PCIMultiSerialState, prog_if, 0x02),
 };
 
 static void multi_2x_serial_pci_class_initfn(ObjectClass *klass,
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 8707e819144..46efabc4cbe 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -38,7 +38,6 @@
 struct PCISerialState {
     PCIDevice dev;
     SerialState state;
-    uint8_t prog_if;
 };
 
 #define TYPE_PCI_SERIAL "pci-serial"
@@ -53,8 +52,8 @@ static void serial_pci_realize(PCIDevice *dev, Error **errp)
         return;
     }
 
-    pci->dev.config[PCI_CLASS_PROG] = pci->prog_if;
-    pci->dev.config[PCI_INTERRUPT_PIN] = 0x01;
+    pci->dev.config[PCI_CLASS_PROG] = 2; /* 16550 compatible */
+    pci->dev.config[PCI_INTERRUPT_PIN] = 1;
     s->irq = pci_allocate_irq(&pci->dev);
 
     memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s, "serial", 8);
@@ -81,10 +80,6 @@ static const VMStateDescription vmstate_pci_serial = {
     }
 };
 
-static const Property serial_pci_properties[] = {
-    DEFINE_PROP_UINT8("prog_if",  PCISerialState, prog_if, 0x02),
-};
-
 static void serial_pci_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -96,7 +91,6 @@ static void serial_pci_class_initfn(ObjectClass *klass, const void *data)
     pc->revision = 1;
     pc->class_id = PCI_CLASS_COMMUNICATION_SERIAL;
     dc->vmsd = &vmstate_pci_serial;
-    device_class_set_props(dc, serial_pci_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
-- 
2.49.0


