Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F80CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeVc-0003JE-Dk; Tue, 28 Oct 2025 03:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeVK-00037J-GZ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:52:33 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeVF-0007dH-KE
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:52:29 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47109187c32so30371725e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761637941; x=1762242741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SAxBBkCqgLgCPIEwX8+ZvguN0WfFyZlBComHTDd1AJ4=;
 b=IeQg5tigF53PKhDh2ZX4NsjjeWo8My83sUkHf9FyGQ//EwoDqZDLPX5jaMCeJIimrE
 9nlc1iyTNt6O9BA6p6s9xiBdpbJLAvPni0mecnHJa3l6j+Y2cby1fkZn/OR+vh3psRKU
 C0bPp98EDXhL/h/8AjVYg+XKXtdw2X1AKiwjYpji0RosomLiEwG9Y+r8x3S6SN+EdmBf
 IZdOGB7o+BCt3OUxDKEuEu+YKmdsONY4QpzY7toSdQCJYfj3zw2YNEVqsjlnM9ZAVx1F
 RSvL4KMhSY2GsfIvJpj8v6GxZx+V55h9CJOqi2Di2pCYtxfzP+Cd+2/T0afJlWfx6GD/
 uBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761637941; x=1762242741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SAxBBkCqgLgCPIEwX8+ZvguN0WfFyZlBComHTDd1AJ4=;
 b=NSwkwPlrmZVhNwdRnNgJRRwGZ1J+Ej7xsv64yQySaldQP6QcbaQ/9G8dMZZpSVPtMS
 BWu6j37ZqllP0BRDx3Imno0oBnNmSBIzr4qiFMUXSFrpRPFHnnoLhRHCRz+t6Vvvin+N
 YphC25kg6BpPt/gqMtae59mvrBrSGNs8amK2sHr7M4aXxvLKRio8scWvVibx3yE7JgLs
 2Dqrf9eQ7ANn3WqDGmKzHEGhULHN5/QQjc9AmIM2BmWyLXOcu+JOFtL0LSNOdlaxnxrR
 F4IC6WW8GWW30f7OP+hBHiQIWL8lYjg0TrJrJxzqfIJMswQMFYyWFp7EScd/+iOLZOEl
 74wg==
X-Gm-Message-State: AOJu0YxXP2oG7xTMVsjeM85dnv222zxAWnKYYg15VKtlgL8C+fM8HEIa
 zX0yhP0U8lW3PlKXUDzN0e5I6cKXLnAP91vxiLrqVa7IFPc/tnrSY/LRGyytfe73Zi4QofN7Lef
 0lu9si60=
X-Gm-Gg: ASbGncsh5JtNaM6ykz/jsEIFBOCjzHs8ncuytElCzjKJ72Yz+o04CGjuNexXgQfpAv4
 6hvPwKjtUtwjp2+zpb2sOXLvEXmdAnVGju3m6sIR/Exnfg216RyAjtk3OUKl+QadpcTgpBtYfjy
 RZ1RYiVNxX/4CjNKLuZwDOfbhnxjviZW3ZkMucN548+trYBEoTbVLk5dHyj3W7IDamynL98WVHj
 XNDCmMaIdMq1iqIR8AuJEroBxs3/PzRSr4g9BLXRyHX+LDoxfr+zNYIF6wlJV08VcuurDCl/n/W
 ZdTQtnWb6RD15/Kml+aaP35izDj4f28qgOP9FTZ2D8PZdIROMSxJVvZtQ5v0ILoAhukjCVsQDXf
 4wL4QMjoJ/2s6hcuWkpGIBR7sCHcx9NXnGTprnYsH8tAo2rMUYVO3dO+OURcleBPbJJBctoHZj+
 UWIcgzqW0mF5mkyjI7K+Pw6eJMvtv6nccw+Jb0GU4aGD0EWO9AqGWHQx4TY/hAbR2rHw==
X-Google-Smtp-Source: AGHT+IHpTH7QbxftT9yhLQutctgheaKO8pmj3YHLjGTEzCOccAqpF3T115V5616yoz7VMlDSp1tw/w==
X-Received: by 2002:a05:600c:4588:b0:459:db7b:988e with SMTP id
 5b1f17b1804b1-47717dfe6a0mr15197675e9.13.1761637941117; 
 Tue, 28 Oct 2025 00:52:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4924e2sm181072405e9.8.2025.10.28.00.52.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:52:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org
Subject: [PULL 09/23] hw/pci-host/raven: Simplify PCI bus creation
Date: Tue, 28 Oct 2025 08:48:45 +0100
Message-ID: <20251028074901.22062-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Instead of doing it manually use pci_register_root_bus() to create and
register the PCI bus. Also drop pci_bus from PREPPCIState and use the
existing bus field in the parent PCIHostState.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <4ffa168d68947d95a16c51d73cedd141b0df0ea0.1761232472.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/raven.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 1d09a28bff2..22ad244eb6e 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -46,7 +46,6 @@ struct PREPPCIState {
 
     OrIRQState *or_irq;
     qemu_irq pci_irqs[PCI_NUM_PINS];
-    PCIBus pci_bus;
     AddressSpace pci_io_as;
     MemoryRegion pci_io;
     MemoryRegion pci_io_non_contiguous;
@@ -231,8 +230,9 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
 
     qdev_init_gpio_in(d, raven_change_gpio, 1);
 
-    pci_bus_irqs(&s->pci_bus, raven_set_irq, s, PCI_NUM_PINS);
-    pci_bus_map_irqs(&s->pci_bus, raven_map_irq);
+    h->bus = pci_register_root_bus(d, NULL, raven_set_irq, raven_map_irq,
+                                   s, &s->pci_memory, &s->pci_io, 0, 4,
+                                   TYPE_PCI_BUS);
 
     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops, s,
                           "pci-conf-idx", 4);
@@ -250,12 +250,14 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
                           "pci-intack", 1);
     memory_region_add_subregion(address_space_mem, 0xbffffff0, &s->pci_intack);
 
-    pci_create_simple(&s->pci_bus, PCI_DEVFN(0, 0), TYPE_RAVEN_PCI_DEVICE);
+    pci_create_simple(h->bus, PCI_DEVFN(0, 0), TYPE_RAVEN_PCI_DEVICE);
+
+    address_space_init(&s->bm_as, &s->bm, "raven-bm");
+    pci_setup_iommu(h->bus, &raven_iommu_ops, s);
 }
 
 static void raven_pcihost_initfn(Object *obj)
 {
-    PCIHostState *h = PCI_HOST_BRIDGE(obj);
     PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(obj);
     MemoryRegion *address_space_mem = get_system_memory();
 
@@ -278,8 +280,6 @@ static void raven_pcihost_initfn(Object *obj)
     memory_region_add_subregion_overlap(address_space_mem, PCI_IO_BASE_ADDR,
                                         &s->pci_io_non_contiguous, 1);
     memory_region_add_subregion(address_space_mem, 0xc0000000, &s->pci_memory);
-    pci_root_bus_init(&s->pci_bus, sizeof(s->pci_bus), DEVICE(obj), NULL,
-                      &s->pci_memory, &s->pci_io, 0, TYPE_PCI_BUS);
 
     /* Bus master address space */
     memory_region_init(&s->bm, obj, "bm-raven", 4 * GiB);
@@ -290,10 +290,6 @@ static void raven_pcihost_initfn(Object *obj)
                              get_system_memory(), 0, 0x80000000);
     memory_region_add_subregion(&s->bm, 0         , &s->bm_pci_memory_alias);
     memory_region_add_subregion(&s->bm, 0x80000000, &s->bm_ram_alias);
-    address_space_init(&s->bm_as, &s->bm, "raven-bm");
-    pci_setup_iommu(&s->pci_bus, &raven_iommu_ops, s);
-
-    h->bus = &s->pci_bus;
 }
 
 static void raven_pcihost_class_init(ObjectClass *klass, const void *data)
-- 
2.51.0


