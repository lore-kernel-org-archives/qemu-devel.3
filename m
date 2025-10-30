Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE22CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEThj-0004CZ-QZ; Thu, 30 Oct 2025 10:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vETha-0004BE-KL
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:32:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vEThT-0007Uh-5h
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761834741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rC1gtBhPxjo8DZRWrfzXeVII/42/8Zz3HaTiFOTHKjU=;
 b=K7kwEsyuSrvrCM7WufnWY+NVcgNu9uBUsy9SxVb1RDFNWEdAMYOK1kIAthvh5LdOtUACE1
 pgkfVTz7B2o3OVjWIhsXVpIWcovfosFixSO/x/1gTltcCDrQy2bVKZ81xpe9IpkEffMvFx
 7mlXQ2zHSl8rm6hBZpvM3VE80oNi3J0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-65oU6sNePG2sNSgn1y0Uxg-1; Thu, 30 Oct 2025 10:32:16 -0400
X-MC-Unique: 65oU6sNePG2sNSgn1y0Uxg-1
X-Mimecast-MFC-AGG-ID: 65oU6sNePG2sNSgn1y0Uxg_1761834736
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8a2594fa114so327517785a.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 07:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761834736; x=1762439536;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rC1gtBhPxjo8DZRWrfzXeVII/42/8Zz3HaTiFOTHKjU=;
 b=bzpt2cVUoNGj7tjRSdL2a5ozpnnpEftVt3FgqPXIrf4OpXyUul+Y0QQNNCco2nVGQE
 25FJLFdwUjyTGxy7w/+2PtAceV7oR8XpkDJcRdiOyLwfTSjyQUTCA4EjMY0S+3TC08C5
 svkQZMNT/Y/nvJQzdB+4HjMXU14KT1PW5XmEqmGXu8LFVsQSD8M6zjx20pOV4qiiDV9H
 KkpNW/ewUsBCoy19qNjJ8OkwXXv/jFd4CBzGG5BdUwwnHQ41kNAtCPMKgjZgStX6nCGW
 G8Hjf9j8t/CjPasr0UlrOtVMzPr1jYxBBCZwRZm98+BZCx304mSv7OhQF5Myr8jxGTiS
 sUag==
X-Gm-Message-State: AOJu0YwbdvD/oTtYZ3Pbc38aae+fKn+TQXjwwdhgUBY/csy5hHsVI5+2
 wJi7fJkDiFtONvtXNjht8gYlevlw2bGj94kmCzah9qKFzAYmc1mmjeaRfGvVQxf2ZL/l2eCeLz8
 e45yEvtg7doJwJ3UFf8/xpO2WAE+B4wh15igALyOaD9sc+jzZuQ8v+giE
X-Gm-Gg: ASbGnctHdBmt+d7F7Ax0DT52UTvWjRH8AT1xpCYqqP38UAtmjRfrZf+ZOseG556q751
 lbjL5rpgXGBDDs9sCK85Eeqhvm6K8yx961g4n2hvonknykTp1zMfc5y5FbLoFcYu3ogRf3vVonr
 sCC/Mhkgikfd4ZNSKsCUwsxn8W/pSZJUa2vGIbcl2FiB0TW2JZkQt1ZZYPizoYywf5B4lXTRm1w
 jJXO2s1DaCdLEY858R5isyZkt5oHm/uNdT1oZxxte/gNTVpbiJcDroK5hvln51sJxZc2JyNgEgK
 KrLjZdFubWlqZrfQgYNI/4H9l1m6oYy+R537EDvSES0mi7X3nAVTyrVQ92cKCSKQ95MYcyUs09v
 DXlcaIhMjJYc4Hon6Z3Y2CjloL6UqKg==
X-Received: by 2002:a05:620a:701c:b0:8a1:649b:93d0 with SMTP id
 af79cd13be357-8aa29d9a8cemr438615385a.1.1761834735729; 
 Thu, 30 Oct 2025 07:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIelJLa4crANhww/S5P6ZSxKfdV8GafzgRMDetEY0QXT1D7INDtjOolfI9Arli9eAj6USXcg==
X-Received: by 2002:a05:620a:701c:b0:8a1:649b:93d0 with SMTP id
 af79cd13be357-8aa29d9a8cemr438611385a.1.1761834735312; 
 Thu, 30 Oct 2025 07:32:15 -0700 (PDT)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([151.29.89.118])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f254a297dsm1309014285a.28.2025.10.30.07.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 07:32:14 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Thu, 30 Oct 2025 15:32:04 +0100
Subject: [PATCH] hw/i386/microvm: Use fdt field from MachineState
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-fix_microvm-v1-1-f89544a04be3@redhat.com>
X-B4-Tracking: v=1; b=H4sIAON2A2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA2MD3bTMivjczOSi/LJc3eRkS8MkAzOzpGRDEyWgjoKiVKA02LTo2Np
 aACUeDLJdAAAA
X-Change-ID: 20251030-fix_microvm-cc91b066bc14
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

MachineState already provides an fdt field, remove it from
MicrovmMachineState and use that instead.

This is useful when using the `dumpdtb` option, as QEMU expects the
device tree to be stored in the MachineState struct, othwise it will
return this error:

qemu-system-x86_64: This machine doesn't have an FDT

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
`fdt` field is already available in `MachineState` but 
`MicrovmMachineState` uses its own.

This prevents the "dumpdtb" option from working.
---
 hw/i386/microvm-dt.c      | 96 +++++++++++++++++++++++++----------------------
 include/hw/i386/microvm.h |  2 -
 2 files changed, 52 insertions(+), 46 deletions(-)

diff --git a/hw/i386/microvm-dt.c b/hw/i386/microvm-dt.c
index cb27dfd732ea87afa56de3d1a7c5cdaf2a5c85a1..81eaddafc8ba9bea13d6b1b3df9881308dfc1e5a 100644
--- a/hw/i386/microvm-dt.c
+++ b/hw/i386/microvm-dt.c
@@ -48,6 +48,7 @@ static bool debug;
 static void dt_add_microvm_irq(MicrovmMachineState *mms,
                                const char *nodename, uint32_t irq)
 {
+    MachineState *ms = MACHINE(mms);
     int index = 0;
 
     if (irq >= IO_APIC_SECONDARY_IRQBASE) {
@@ -55,13 +56,14 @@ static void dt_add_microvm_irq(MicrovmMachineState *mms,
         index++;
     }
 
-    qemu_fdt_setprop_cell(mms->fdt, nodename, "interrupt-parent",
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
                           mms->ioapic_phandle[index]);
-    qemu_fdt_setprop_cells(mms->fdt, nodename, "interrupts", irq, 0);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq, 0);
 }
 
 static void dt_add_virtio(MicrovmMachineState *mms, VirtIOMMIOProxy *mmio)
 {
+    MachineState *ms = MACHINE(mms);
     SysBusDevice *dev = SYS_BUS_DEVICE(mmio);
     VirtioBusState *mmio_virtio_bus = &mmio->bus;
     BusState *mmio_bus = &mmio_virtio_bus->parent_obj;
@@ -77,10 +79,10 @@ static void dt_add_virtio(MicrovmMachineState *mms, VirtIOMMIOProxy *mmio)
     uint32_t irq = mms->virtio_irq_base + index;
 
     nodename = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
-    qemu_fdt_add_subnode(mms->fdt, nodename);
-    qemu_fdt_setprop_string(mms->fdt, nodename, "compatible", "virtio,mmio");
-    qemu_fdt_setprop_sized_cells(mms->fdt, nodename, "reg", 2, base, 2, size);
-    qemu_fdt_setprop(mms->fdt, nodename, "dma-coherent", NULL, 0);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible", "virtio,mmio");
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
+    qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
     dt_add_microvm_irq(mms, nodename, irq);
     g_free(nodename);
 }
@@ -88,40 +90,42 @@ static void dt_add_virtio(MicrovmMachineState *mms, VirtIOMMIOProxy *mmio)
 static void dt_add_xhci(MicrovmMachineState *mms)
 {
     const char compat[] = "generic-xhci";
+    MachineState *ms = MACHINE(mms);
     uint32_t irq = MICROVM_XHCI_IRQ;
     hwaddr base = MICROVM_XHCI_BASE;
     hwaddr size = XHCI_LEN_REGS;
     char *nodename;
 
     nodename = g_strdup_printf("/usb@%" PRIx64, base);
-    qemu_fdt_add_subnode(mms->fdt, nodename);
-    qemu_fdt_setprop(mms->fdt, nodename, "compatible", compat, sizeof(compat));
-    qemu_fdt_setprop_sized_cells(mms->fdt, nodename, "reg", 2, base, 2, size);
-    qemu_fdt_setprop(mms->fdt, nodename, "dma-coherent", NULL, 0);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop(ms->fdt, nodename, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
+    qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
     dt_add_microvm_irq(mms, nodename, irq);
     g_free(nodename);
 }
 
 static void dt_add_pcie(MicrovmMachineState *mms)
 {
+    MachineState *ms = MACHINE(mms);
     hwaddr base = PCIE_MMIO_BASE;
     int nr_pcie_buses;
     char *nodename;
 
     nodename = g_strdup_printf("/pcie@%" PRIx64, base);
-    qemu_fdt_add_subnode(mms->fdt, nodename);
-    qemu_fdt_setprop_string(mms->fdt, nodename,
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_string(ms->fdt, nodename,
                             "compatible", "pci-host-ecam-generic");
-    qemu_fdt_setprop_string(mms->fdt, nodename, "device_type", "pci");
-    qemu_fdt_setprop_cell(mms->fdt, nodename, "#address-cells", 3);
-    qemu_fdt_setprop_cell(mms->fdt, nodename, "#size-cells", 2);
-    qemu_fdt_setprop_cell(mms->fdt, nodename, "linux,pci-domain", 0);
-    qemu_fdt_setprop(mms->fdt, nodename, "dma-coherent", NULL, 0);
+    qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "pci");
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#address-cells", 3);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#size-cells", 2);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "linux,pci-domain", 0);
+    qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
 
-    qemu_fdt_setprop_sized_cells(mms->fdt, nodename, "reg",
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                  2, PCIE_ECAM_BASE, 2, PCIE_ECAM_SIZE);
     if (mms->gpex.mmio64.size) {
-        qemu_fdt_setprop_sized_cells(mms->fdt, nodename, "ranges",
+        qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "ranges",
 
                                      1, FDT_PCI_RANGE_MMIO,
                                      2, mms->gpex.mmio32.base,
@@ -133,7 +137,7 @@ static void dt_add_pcie(MicrovmMachineState *mms)
                                      2, mms->gpex.mmio64.base,
                                      2, mms->gpex.mmio64.size);
     } else {
-        qemu_fdt_setprop_sized_cells(mms->fdt, nodename, "ranges",
+        qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "ranges",
 
                                      1, FDT_PCI_RANGE_MMIO,
                                      2, mms->gpex.mmio32.base,
@@ -142,7 +146,7 @@ static void dt_add_pcie(MicrovmMachineState *mms)
     }
 
     nr_pcie_buses = PCIE_ECAM_SIZE / PCIE_MMCFG_SIZE_MIN;
-    qemu_fdt_setprop_cells(mms->fdt, nodename, "bus-range", 0,
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "bus-range", 0,
                            nr_pcie_buses - 1);
 
     g_free(nodename);
@@ -150,6 +154,7 @@ static void dt_add_pcie(MicrovmMachineState *mms)
 
 static void dt_add_ioapic(MicrovmMachineState *mms, SysBusDevice *dev)
 {
+    MachineState *ms = MACHINE(mms);
     hwaddr base = dev->mmio[0].addr;
     char *nodename;
     uint32_t ph;
@@ -168,18 +173,18 @@ static void dt_add_ioapic(MicrovmMachineState *mms, SysBusDevice *dev)
     }
 
     nodename = g_strdup_printf("/ioapic%d@%" PRIx64, index + 1, base);
-    qemu_fdt_add_subnode(mms->fdt, nodename);
-    qemu_fdt_setprop_string(mms->fdt, nodename,
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_string(ms->fdt, nodename,
                             "compatible", "intel,ce4100-ioapic");
-    qemu_fdt_setprop(mms->fdt, nodename, "interrupt-controller", NULL, 0);
-    qemu_fdt_setprop_cell(mms->fdt, nodename, "#interrupt-cells", 0x2);
-    qemu_fdt_setprop_cell(mms->fdt, nodename, "#address-cells", 0x2);
-    qemu_fdt_setprop_sized_cells(mms->fdt, nodename, "reg",
+    qemu_fdt_setprop(ms->fdt, nodename, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 0x2);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#address-cells", 0x2);
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                  2, base, 2, 0x1000);
 
-    ph = qemu_fdt_alloc_phandle(mms->fdt);
-    qemu_fdt_setprop_cell(mms->fdt, nodename, "phandle", ph);
-    qemu_fdt_setprop_cell(mms->fdt, nodename, "linux,phandle", ph);
+    ph = qemu_fdt_alloc_phandle(ms->fdt);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", ph);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "linux,phandle", ph);
     mms->ioapic_phandle[index] = ph;
 
     g_free(nodename);
@@ -190,17 +195,18 @@ static void dt_add_isa_serial(MicrovmMachineState *mms, ISADevice *dev)
     const char compat[] = "ns16550";
     uint32_t irq = object_property_get_int(OBJECT(dev), "irq", &error_fatal);
     hwaddr base = object_property_get_int(OBJECT(dev), "iobase", &error_fatal);
+    MachineState *ms = MACHINE(mms);
     hwaddr size = 8;
     char *nodename;
 
     nodename = g_strdup_printf("/serial@%" PRIx64, base);
-    qemu_fdt_add_subnode(mms->fdt, nodename);
-    qemu_fdt_setprop(mms->fdt, nodename, "compatible", compat, sizeof(compat));
-    qemu_fdt_setprop_sized_cells(mms->fdt, nodename, "reg", 2, base, 2, size);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop(ms->fdt, nodename, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
     dt_add_microvm_irq(mms, nodename, irq);
 
     if (base == 0x3f8 /* com1 */) {
-        qemu_fdt_setprop_string(mms->fdt, "/chosen", "stdout-path", nodename);
+        qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
     }
 
     g_free(nodename);
@@ -211,13 +217,14 @@ static void dt_add_isa_rtc(MicrovmMachineState *mms, ISADevice *dev)
     const char compat[] = "motorola,mc146818";
     uint32_t irq = object_property_get_uint(OBJECT(dev), "irq", &error_fatal);
     hwaddr base = object_property_get_uint(OBJECT(dev), "iobase", &error_fatal);
+    MachineState *ms = MACHINE(mms);
     hwaddr size = 8;
     char *nodename;
 
     nodename = g_strdup_printf("/rtc@%" PRIx64, base);
-    qemu_fdt_add_subnode(mms->fdt, nodename);
-    qemu_fdt_setprop(mms->fdt, nodename, "compatible", compat, sizeof(compat));
-    qemu_fdt_setprop_sized_cells(mms->fdt, nodename, "reg", 2, base, 2, size);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop(ms->fdt, nodename, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
     dt_add_microvm_irq(mms, nodename, irq);
     g_free(nodename);
 }
@@ -317,27 +324,28 @@ static void dt_setup_sys_bus(MicrovmMachineState *mms)
 void dt_setup_microvm(MicrovmMachineState *mms)
 {
     X86MachineState *x86ms = X86_MACHINE(mms);
+    MachineState *ms = MACHINE(mms);
     int size = 0;
 
-    mms->fdt = create_device_tree(&size);
+    ms->fdt = create_device_tree(&size);
 
     /* root node */
-    qemu_fdt_setprop_string(mms->fdt, "/", "compatible", "linux,microvm");
-    qemu_fdt_setprop_cell(mms->fdt, "/", "#address-cells", 0x2);
-    qemu_fdt_setprop_cell(mms->fdt, "/", "#size-cells", 0x2);
+    qemu_fdt_setprop_string(ms->fdt, "/", "compatible", "linux,microvm");
+    qemu_fdt_setprop_cell(ms->fdt, "/", "#address-cells", 0x2);
+    qemu_fdt_setprop_cell(ms->fdt, "/", "#size-cells", 0x2);
 
-    qemu_fdt_add_subnode(mms->fdt, "/chosen");
+    qemu_fdt_add_subnode(ms->fdt, "/chosen");
     dt_setup_sys_bus(mms);
 
     /* add to fw_cfg */
     if (debug) {
         fprintf(stderr, "%s: add etc/fdt to fw_cfg\n", __func__);
     }
-    fw_cfg_add_file(x86ms->fw_cfg, "etc/fdt", mms->fdt, size);
+    fw_cfg_add_file(x86ms->fw_cfg, "etc/fdt", ms->fdt, size);
 
     if (debug) {
         fprintf(stderr, "%s: writing microvm.fdt\n", __func__);
-        if (!g_file_set_contents("microvm.fdt", mms->fdt, size, NULL)) {
+        if (!g_file_set_contents("microvm.fdt", ms->fdt, size, NULL)) {
             fprintf(stderr, "%s: writing microvm.fdt failed\n", __func__);
             return;
         }
diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index b9ac34a3ef14027eace91fd6d627ed9e8df3d435..e73d1e65de8ce03133c2796aac72a254e74d9d2c 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -102,8 +102,6 @@ struct MicrovmMachineState {
     Notifier powerdown_req;
     struct GPEXConfig gpex;
 
-    /* device tree */
-    void *fdt;
     uint32_t ioapic_phandle[2];
 };
 

---
base-commit: e090e0312dc9030d94e38e3d98a88718d3561e4e
change-id: 20251030-fix_microvm-cc91b066bc14

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


