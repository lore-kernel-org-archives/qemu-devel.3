Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A081AC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wevkE-0005mR-9p; Wed, 01 Jul 2026 10:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wevju-0005a4-N4
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 10:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wevjr-0000Nl-Gm
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 10:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782915390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1E586opbSMK99s73IKeOpRcaRb1mqhJgla8yeFcph98=;
 b=RlsrvUksGW8MRvQjlZOhRmAf6JHhDYjEQJca5tVMx3Obgkr4PDO+quWnY1/YLXmb3mc41S
 p5MzgOH7WcXnb+s+8ABt5qauIoF3F4jZAmwmECX6D/Y+IXTv1lf8DGqbrpKIP0qLmXC1z/
 zT7cSSzied/DJjZG66LTrebNst7vdhA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-tZ4NKfnmMzKSYnsTpLu3aA-1; Wed, 01 Jul 2026 10:16:27 -0400
X-MC-Unique: tZ4NKfnmMzKSYnsTpLu3aA-1
X-Mimecast-MFC-AGG-ID: tZ4NKfnmMzKSYnsTpLu3aA_1782915386
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4926596eebcso7000865e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 07:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782915386; x=1783520186; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1E586opbSMK99s73IKeOpRcaRb1mqhJgla8yeFcph98=;
 b=gmOQmolvakp/ZIwa4DHSB7W+fvWPgdvSAOUB3P+cpN5SHp0Zjjczu7NXRjEbJ5NTrL
 OihYfVk9G+BO513+R/tB9GC9Gh2XGStwMf3tFwWbUZ8i90WkrJp7UX7TeTh10hnhZTst
 Ebn+SfnI8d+ZbipE15O9bPKpLTTZ/LciP07AHIsroCw2tmF0ZWbIuVUm1H5xPbgIXAF3
 WDCPHI2SSiRvxdbc+8yMM5V/Nw9AeV89Bzz3bMLuNLg2T/A8u+v0fe+kmxbC8juyCEOc
 SmfOKpNhxVBpS9yGkwD3cmYk517Hs1lF67BFN20u/3dHs31E7t7SvxOZ9VxlTo8OOPks
 serw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782915386; x=1783520186;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1E586opbSMK99s73IKeOpRcaRb1mqhJgla8yeFcph98=;
 b=PJInChahOLPh87zqCs8Gbnz+PafnJDTIm1UhrbmuqH/9jzosLpG3BJ/I2t8PN5NOzd
 xdDUKu8Aq0qFvsY9sGjGx1hXQEiU0xCy3Fl0J/iw8yS0N/meWp1c53UcTa1PWUpmreCS
 cZNqGgWDgD/7CfwbQ493+quP/NJ6hnmC2fZAlF8pOtHK1VRkomx9n57HTtbpJjXsZXLu
 geTY0itKCX+C1/xX0XV9KGAq5/G/Gsd+zbTztJjJMrwzj5lXy9NXjnmGdGz9WgLtXZGO
 U6Ddzekyw/gGU04Rpr9Y8Asm+Rb879kNSPRPJ9QZq2cSTfWQTZyGds5KWR9CqC6aQJw1
 sR8w==
X-Gm-Message-State: AOJu0YyfIj9L3wR+/WdzvNLijBi8YDBxt2SmtRwIoeGhRhrPJSOQPgrg
 ARXfWOhb5C9RWkUvy4y0LrLDUN6VtzfrrJmbOOIsHXBNybJauzVACSmXHYPMn52LvBHCQt2n+Gr
 9niS1D2ItaFruG/SR3kwfkEhBo864v5tIy5QDngxcSzTWvRbF+ZLu/efY
X-Gm-Gg: AfdE7ck1vj1sJ7llMFahddux9i81g8GXIsDzKdqxuo7n6Vx5BLkCq4BOD+h2g0pNW4K
 uBFQcCbcxibhr7PRzVv0ktAAlgUUDmOeeZdcXuj2PeExgqjPsy95f87qVX4bHgG/WirTxOav4OG
 REAl+U2JY0nyw/cpYb9aGgx/Io6+CeLxy4+Js1xXJDORv+ryOey5VR3/+n+iWUC5NO7CTe7OLC2
 1nFhHBJuzrgEcoP6u8O4epvMC5KKqSkUwRM9lcqR/BxGD7TzRcvGVZ8bGShMXwPAo5cyQUzC4du
 6jm035Zhbq2HQHZs6WRRWQOp8fzwiphk2D3hlkT/vt5HqQkloz6THUrlRIAypORCi9gzHeX/xKp
 JlhsQiiEZUEee9L475ro+g/7Ww1vHszoxZ2wUmseUJ37+FVm6SSjWX3515UK04xwi4587beC+AO
 ZkivJA
X-Received: by 2002:a05:600c:8183:b0:492:1e36:1fe9 with SMTP id
 5b1f17b1804b1-493c3df34d3mr11294735e9.37.1782915386219; 
 Wed, 01 Jul 2026 07:16:26 -0700 (PDT)
X-Received: by 2002:a05:600c:8183:b0:492:1e36:1fe9 with SMTP id
 5b1f17b1804b1-493c3df34d3mr11294185e9.37.1782915385691; 
 Wed, 01 Jul 2026 07:16:25 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be493c24sm53283795e9.0.2026.07.01.07.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 07:16:24 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 01 Jul 2026 16:16:18 +0200
Subject: [PATCH 2/3] hw/i386/microvm: add platform bus support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-microvm_uefi_var-v1-2-0652cae6a152@redhat.com>
References: <20260701-microvm_uefi_var-v1-0-0652cae6a152@redhat.com>
In-Reply-To: <20260701-microvm_uefi_var-v1-0-0652cae6a152@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a platform bus to microvm to support dynamic sysbus devices with
automatic MMIO address allocation. The bus is mapped at 0xfec20000
with a 1 MB window, placed after the IOAPICs.

This is necessary to support the uefi-vars-sysbus device, which
will be attached to microvm using the platform bus.

The platform bus is created without IRQ lines for now; IRQ support can
be added later as needed.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 hw/i386/Kconfig           |  1 +
 hw/i386/microvm-dt.c      |  9 +++++++++
 hw/i386/microvm.c         | 36 ++++++++++++++++++++++++++++++++++++
 include/hw/i386/microvm.h |  4 ++++
 4 files changed, 50 insertions(+)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 12473acaa7..e5f5e11980 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -133,6 +133,7 @@ config MICROVM
     select PCI_EXPRESS_GENERIC_BRIDGE
     select USB_XHCI_SYSBUS
     select I8254
+    select PLATFORM_BUS
 
 config NITRO_ENCLAVE
     default y
diff --git a/hw/i386/microvm-dt.c b/hw/i386/microvm-dt.c
index 45fbb5bbd1..69feddc715 100644
--- a/hw/i386/microvm-dt.c
+++ b/hw/i386/microvm-dt.c
@@ -38,6 +38,7 @@
 #include "hw/i386/fw_cfg.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/core/sysbus.h"
+#include "hw/core/sysbus-fdt.h"
 #include "hw/virtio/virtio-mmio.h"
 #include "hw/usb/xhci.h"
 
@@ -337,6 +338,14 @@ void dt_setup_microvm(MicrovmMachineState *mms)
     qemu_fdt_add_subnode(ms->fdt, "/chosen");
     dt_setup_sys_bus(mms);
 
+    if (mms->platform_bus_dev) {
+        /* Platform bus IRQs are not supported, intc is required but unused */
+        platform_bus_add_all_fdt_nodes(ms->fdt, "/ioapic1",
+                                       MICROVM_PLATFORM_BUS_BASE,
+                                       MICROVM_PLATFORM_BUS_SIZE,
+                                       0);
+    }
+
     /* add to fw_cfg */
     if (debug) {
         fprintf(stderr, "%s: add etc/fdt to fw_cfg\n", __func__);
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 779741ec76..d4836b5e12 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -47,6 +47,7 @@
 #include "hw/virtio/virtio-mmio.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/generic_event_device.h"
+#include "hw/core/platform-bus.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/usb/xhci.h"
 #include "hw/vfio/types.h"
@@ -146,6 +147,24 @@ static void create_gpex(MicrovmMachineState *mms)
     }
 }
 
+static void create_platform_bus(MicrovmMachineState *mms)
+{
+    DeviceState *dev;
+    SysBusDevice *s;
+
+    dev = qdev_new(TYPE_PLATFORM_BUS_DEVICE);
+    dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
+    qdev_prop_set_uint32(dev, "num_irqs", 0);
+    qdev_prop_set_uint32(dev, "mmio_size", MICROVM_PLATFORM_BUS_SIZE);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    mms->platform_bus_dev = dev;
+
+    s = SYS_BUS_DEVICE(dev);
+    memory_region_add_subregion(get_system_memory(),
+                                MICROVM_PLATFORM_BUS_BASE,
+                                sysbus_mmio_get_region(s, 0));
+}
+
 static int microvm_ioapics(MicrovmMachineState *mms)
 {
     if (!x86_machine_is_acpi_enabled(X86_MACHINE(mms))) {
@@ -248,6 +267,8 @@ static void microvm_devices_init(MicrovmMachineState *mms)
         x86ms->pci_irq_mask = 0;
     }
 
+    create_platform_bus(mms);
+
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
         qemu_irq *i8259;
 
@@ -453,12 +474,27 @@ static HotplugHandler *microvm_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
+static void link_one_device(SysBusDevice *sbdev, void *opaque)
+{
+    platform_bus_link_device(PLATFORM_BUS_DEVICE(opaque), sbdev);
+}
+
+static void microvm_link_platform_bus_devices(MicrovmMachineState *mms)
+{
+    if (!mms->platform_bus_dev) {
+        return;
+    }
+
+    foreach_dynamic_sysbus_device(link_one_device, mms->platform_bus_dev);
+}
+
 static void microvm_machine_done(Notifier *notifier, void *data)
 {
     MicrovmMachineState *mms = container_of(notifier, MicrovmMachineState,
                                             machine_done);
     X86MachineState *x86ms = X86_MACHINE(mms);
 
+    microvm_link_platform_bus_devices(mms);
     acpi_setup_microvm(mms);
     dt_setup_microvm(mms);
     fw_cfg_add_e820(x86ms->fw_cfg);
diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index 184b7a8c09..bd2897aa78 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -61,6 +61,9 @@
 #define MICROVM_XHCI_BASE     0xfe900000
 #define MICROVM_XHCI_IRQ      10
 
+#define MICROVM_PLATFORM_BUS_BASE 0xfec20000
+#define MICROVM_PLATFORM_BUS_SIZE 0x00100000
+
 #define PCIE_MMIO_BASE        0xc0000000
 #define PCIE_MMIO_SIZE        0x20000000
 #define PCIE_ECAM_BASE        0xe0000000
@@ -101,6 +104,7 @@ struct MicrovmMachineState {
     Notifier machine_done;
     Notifier powerdown_req;
     struct GPEXConfig gpex;
+    DeviceState *platform_bus_dev;
 
     uint32_t ioapic_phandle[2];
 };

-- 
2.54.0


