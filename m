Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC37C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 09:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiUKD-0004uF-8V; Sat, 11 Jul 2026 05:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry0911@gmail.com>)
 id 1wiUKB-0004no-Nx
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 05:48:43 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rdmitry0911@gmail.com>)
 id 1wiUK9-0002wN-MJ
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 05:48:43 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47df440fcd5so871909f8f.3
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 02:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783763320; x=1784368120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SNHcGwJ06U40ohD8RRx3DMWn3a5is/gzXjjKrhzRpmk=;
 b=VSqHkRRPwyiKWXxjLIlFbrlxnLXeR+EnexMANOxbbEk0T4+Dg6NHJ6bufUxFogjLxF
 293hKCrGONyeLDU+KHgcysyyjKcWjoSbphcrNCIrxuu/cX4lNEvBsRNaFxEi3bZZ05HR
 AcgbdVXWHKZHrEDe7BOdxK40XG2d/Gui/RZvy/oG6P/UaX+nQKW+eGo9kK8Sw31cNUwC
 DhPrqt9ykQZn2IdvuNdCswXmiS6jTT2SJDUzeCnuAuxxQ0stNkY2qSZLqdAqG29tdEF9
 xcDIA7Ry7eURBQMLKfal7gajXIPAe2VkMvDOeugkWzIGQXqmleLgGC8/Wo47FcI03CNg
 NJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783763320; x=1784368120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SNHcGwJ06U40ohD8RRx3DMWn3a5is/gzXjjKrhzRpmk=;
 b=gqQ/fmjT3FBR/vNxJr5BzjsaDI93afZA4IlUT6FivK66KdEY3t88NPR9viHU0nx2ap
 iE5CaiAvKpZUZD34O/rguyJC4Qhe9vfK8Ief6JKCVD7YWi+Id4R9FBgAScpAz5JJ/Jsh
 REZtI9ynNDJBfxg3dyDUcvlvVkhnZo7A8E8dnrwQonSAm8N6yZGjgzqrhfG3qGcvvhoW
 Od4/L14sYFOdG43AlrSYudzJs7VmiCr2gW4Tw8/TcefxWD4CIcifNb0oXLwH5legZZAY
 aGiPl4f15fugq7Rb5FWyde6HQhzXGwiWwper9KBmnotOG7gO9ZNm08TtJWysmjD9bgTb
 /HQQ==
X-Gm-Message-State: AOJu0Yw2zAGtFQ1Vm4BWwvVcZsmZaoRwuAoJFQmWUn4w8Yrczl+cza3a
 kpHtnV49Tcd5ya3eLJUBEwpsNRU3+uosIasrUaNEGAXwIFAu0AFUHb8WlWwVwP7e
X-Gm-Gg: AfdE7ck5sdCQlOB2dskRIgKco8OQJwresb0h7SYIZbrPxHAGOOHNgWUHZt7G+XM2ull
 I6bHxbt1tCx8o13rC/lVAGRPm4WYsJeX4rPso+P2mrHZE9d5RkauVz9RSF1mexIgQRQMC7X3ytR
 1++BhZ/N0RDStVO9Z80STj/8NxpUX9cuMEuBuEYRPR3eTHJLFMiHqiEWBtRUuMrh2HMqD3Mk/+n
 MBKt0pEY5EQmADW+QSnnbAwFF1V4KMnKhYMbn5JFhnvhsLpo+TCAS/hhdIiSrZg4ez6drYw4+W7
 AqOUpHtYAF7kBI8UmKanPuQD9RC74aqzsct77oW76UNnpXC+fbJ6k960pHX7aeN6Oju3CqIm5eC
 4M4Oyjv82nEazefqc48IKOkjzcxM1LzU2ntrZ2Y47QyaiimDoMOTEPhoE11Du7dpuLcuLqJa/eP
 +qoI9ID6I4ofwWrrKGRPP4GJw20uc84o/vrLh3Ezd8CuZ59SgzInAxfEJnw4c5dUu2DpMytkEk1
 a9whZOC1mR9mD31ALE=
X-Received: by 2002:a5d:5887:0:b0:474:b860:b7b1 with SMTP id
 ffacd0b85a97d-47f2dca82dcmr2071327f8f.9.1783763319929; 
 Sat, 11 Jul 2026 02:48:39 -0700 (PDT)
Received: from debian-for-building.localdomain
 (static.244.71.243.136.clients.your-server.de. [136.243.71.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ad21sm66558181f8f.20.2026.07.11.02.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2026 02:48:39 -0700 (PDT)
From: Dmitry R <rdmitry0911@gmail.com>
To: qemu-devel@nongnu.org
Cc: Dmitry R <rdmitry0911@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v2 3/5] hw/display: add Thunderbolt VGA endpoint
Date: Sat, 11 Jul 2026 12:47:59 +0300
Message-ID: <20260711094803.3589239-4-rdmitry0911@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260711094803.3589239-1-rdmitry0911@gmail.com>
References: <20260710133440.2845828-1-rdmitry0911@gmail.com>
 <20260711094803.3589239-1-rdmitry0911@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=rdmitry0911@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add thunderbolt-vga as a separate stdvga-compatible hotpluggable endpoint
for Thunderbolt display hotplug tests.

The regular QEMU VGA device is intentionally left untouched and remains
non-hotpluggable. thunderbolt-vga.c keeps the MIT license because it is
derived from the existing stdvga implementation in hw/display/vga-pci.c,
which carries the same license.

Signed-off-by: Dmitry R <rdmitry0911@gmail.com>
---
 hw/display/meson.build       |   1 +
 hw/display/thunderbolt-vga.c | 275 +++++++++++++++++++++++++++++++++++
 2 files changed, 276 insertions(+)
 create mode 100644 hw/display/thunderbolt-vga.c

diff --git a/hw/display/meson.build b/hw/display/meson.build
index ffecedbf70..7074d2b5f9 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -19,6 +19,7 @@ system_ss.add(when: 'CONFIG_SSD0323', if_true: files('ssd0323.c'))
 system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xenfb.c'))
 
 system_ss.add(when: 'CONFIG_VGA_PCI', if_true: files('vga-pci.c'))
+system_ss.add(when: 'CONFIG_VGA_PCI', if_true: files('thunderbolt-vga.c'))
 system_ss.add(when: 'CONFIG_VGA_ISA', if_true: files('vga-isa.c'))
 system_ss.add(when: 'CONFIG_VGA_MMIO', if_true: files('vga-mmio.c'))
 system_ss.add(when: 'CONFIG_VMWARE_VGA', if_true: files('vmware_vga.c'))
diff --git a/hw/display/thunderbolt-vga.c b/hw/display/thunderbolt-vga.c
new file mode 100644
index 0000000000..4eabe357c2
--- /dev/null
+++ b/hw/display/thunderbolt-vga.c
@@ -0,0 +1,275 @@
+/*
+ * Thunderbolt hotpluggable PCI VGA device.
+ *
+ * This is a stdvga-compatible endpoint with a separate QOM type for
+ * Thunderbolt hotplug experiments.  The regular "VGA" type remains unchanged.
+ *
+ * Copyright (c) 2003 Fabrice Bellard
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/loader.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/display/edid.h"
+#include "hw/pci/pci_device.h"
+#include "qemu/module.h"
+#include "qom/object.h"
+#include "ui/console.h"
+#include "ui/pixel_ops.h"
+#include "vga_int.h"
+
+#define TYPE_PCI_VGA "pci-vga"
+#define TYPE_THUNDERBOLT_VGA "thunderbolt-vga"
+
+OBJECT_DECLARE_SIMPLE_TYPE(ThunderboltVGAState, THUNDERBOLT_VGA)
+
+enum thunderbolt_vga_pci_flags {
+    THUNDERBOLT_VGA_FLAG_ENABLE_MMIO = 1,
+    THUNDERBOLT_VGA_FLAG_ENABLE_QEXT = 2,
+    THUNDERBOLT_VGA_FLAG_ENABLE_EDID = 3,
+};
+
+struct ThunderboltVGAState {
+    PCIDevice dev;
+    VGACommonState vga;
+    uint32_t flags;
+    qemu_edid_info edid_info;
+    MemoryRegion mmio;
+    MemoryRegion mrs[4];
+    uint8_t edid[384];
+};
+
+static uint64_t thunderbolt_vga_ioport_read(void *ptr, hwaddr addr,
+                                            unsigned size)
+{
+    VGACommonState *s = ptr;
+    uint64_t ret = 0;
+
+    switch (size) {
+    case 1:
+        ret = vga_ioport_read(s, addr + 0x3c0);
+        break;
+    case 2:
+        ret  = vga_ioport_read(s, addr + 0x3c0);
+        ret |= vga_ioport_read(s, addr + 0x3c1) << 8;
+        break;
+    }
+    return ret;
+}
+
+static void thunderbolt_vga_ioport_write(void *ptr, hwaddr addr,
+                                         uint64_t val, unsigned size)
+{
+    VGACommonState *s = ptr;
+
+    switch (size) {
+    case 1:
+        vga_ioport_write(s, addr + 0x3c0, val);
+        break;
+    case 2:
+        vga_ioport_write(s, addr + 0x3c0, val & 0xff);
+        vga_ioport_write(s, addr + 0x3c1, (val >> 8) & 0xff);
+        break;
+    }
+}
+
+static const MemoryRegionOps thunderbolt_vga_ioport_ops = {
+    .read = thunderbolt_vga_ioport_read,
+    .write = thunderbolt_vga_ioport_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 2,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static uint64_t thunderbolt_vga_bochs_read(void *ptr, hwaddr addr,
+                                           unsigned size)
+{
+    VGACommonState *s = ptr;
+    int index = addr >> 1;
+
+    vbe_ioport_write_index(s, 0, index);
+    return vbe_ioport_read_data(s, 0);
+}
+
+static void thunderbolt_vga_bochs_write(void *ptr, hwaddr addr,
+                                        uint64_t val, unsigned size)
+{
+    VGACommonState *s = ptr;
+    int index = addr >> 1;
+
+    vbe_ioport_write_index(s, 0, index);
+    vbe_ioport_write_data(s, 0, val);
+}
+
+static const MemoryRegionOps thunderbolt_vga_bochs_ops = {
+    .read = thunderbolt_vga_bochs_read,
+    .write = thunderbolt_vga_bochs_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .impl.min_access_size = 2,
+    .impl.max_access_size = 2,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static uint64_t thunderbolt_vga_qext_read(void *ptr, hwaddr addr,
+                                          unsigned size)
+{
+    VGACommonState *s = ptr;
+
+    switch (addr) {
+    case PCI_VGA_QEXT_REG_SIZE:
+        return PCI_VGA_QEXT_SIZE;
+    case PCI_VGA_QEXT_REG_BYTEORDER:
+        return s->big_endian_fb ?
+            PCI_VGA_QEXT_BIG_ENDIAN : PCI_VGA_QEXT_LITTLE_ENDIAN;
+    default:
+        return 0;
+    }
+}
+
+static void thunderbolt_vga_qext_write(void *ptr, hwaddr addr,
+                                       uint64_t val, unsigned size)
+{
+    VGACommonState *s = ptr;
+
+    switch (addr) {
+    case PCI_VGA_QEXT_REG_BYTEORDER:
+        if (val == PCI_VGA_QEXT_BIG_ENDIAN) {
+            s->big_endian_fb = true;
+        }
+        if (val == PCI_VGA_QEXT_LITTLE_ENDIAN) {
+            s->big_endian_fb = false;
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps thunderbolt_vga_qext_ops = {
+    .read = thunderbolt_vga_qext_read,
+    .write = thunderbolt_vga_qext_write,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static bool thunderbolt_vga_get_big_endian_fb(Object *obj, Error **errp)
+{
+    ThunderboltVGAState *d = THUNDERBOLT_VGA(obj);
+
+    return d->vga.big_endian_fb;
+}
+
+static void thunderbolt_vga_set_big_endian_fb(Object *obj, bool value,
+                                              Error **errp)
+{
+    ThunderboltVGAState *d = THUNDERBOLT_VGA(obj);
+
+    d->vga.big_endian_fb = value;
+}
+
+static void thunderbolt_vga_mmio_region_init(ThunderboltVGAState *d,
+                                             Object *owner,
+                                             MemoryRegion *parent)
+{
+    VGACommonState *s = &d->vga;
+
+    memory_region_init_io(&d->mrs[0], owner, &thunderbolt_vga_ioport_ops, s,
+                          "vga ioports remapped", PCI_VGA_IOPORT_SIZE);
+    memory_region_add_subregion(parent, PCI_VGA_IOPORT_OFFSET, &d->mrs[0]);
+
+    memory_region_init_io(&d->mrs[1], owner, &thunderbolt_vga_bochs_ops, s,
+                          "bochs dispi interface", PCI_VGA_BOCHS_SIZE);
+    memory_region_add_subregion(parent, PCI_VGA_BOCHS_OFFSET, &d->mrs[1]);
+
+    if (d->flags & (1 << THUNDERBOLT_VGA_FLAG_ENABLE_QEXT)) {
+        memory_region_init_io(&d->mrs[2], owner, &thunderbolt_vga_qext_ops, s,
+                              "qemu extended regs", PCI_VGA_QEXT_SIZE);
+        memory_region_add_subregion(parent, PCI_VGA_QEXT_OFFSET, &d->mrs[2]);
+    }
+
+    if (d->flags & (1 << THUNDERBOLT_VGA_FLAG_ENABLE_EDID)) {
+        qemu_edid_generate(d->edid, sizeof(d->edid), &d->edid_info);
+        qemu_edid_region_io(&d->mrs[3], owner, d->edid, sizeof(d->edid));
+        memory_region_add_subregion(parent, 0, &d->mrs[3]);
+    }
+}
+
+static void thunderbolt_vga_realize(PCIDevice *dev, Error **errp)
+{
+    ThunderboltVGAState *d = THUNDERBOLT_VGA(dev);
+    VGACommonState *s = &d->vga;
+
+    if (!vga_common_init(s, OBJECT(dev), errp)) {
+        return;
+    }
+    vga_init(s, OBJECT(dev), pci_address_space(dev), pci_address_space_io(dev),
+             true);
+
+    s->con = qemu_graphic_console_create(DEVICE(dev), 0, s->hw_ops, s);
+
+    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->vram);
+
+    if (d->flags & (1 << THUNDERBOLT_VGA_FLAG_ENABLE_MMIO)) {
+        memory_region_init_io(&d->mmio, OBJECT(dev), &unassigned_io_ops, NULL,
+                              "vga.mmio", PCI_VGA_MMIO_SIZE);
+
+        if (d->flags & (1 << THUNDERBOLT_VGA_FLAG_ENABLE_QEXT)) {
+            pci_set_byte(&dev->config[PCI_REVISION_ID], 2);
+        }
+
+        thunderbolt_vga_mmio_region_init(d, OBJECT(dev), &d->mmio);
+        pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->mmio);
+    }
+}
+
+static const Property thunderbolt_vga_properties[] = {
+    DEFINE_PROP_UINT32("vgamem_mb", ThunderboltVGAState, vga.vram_size_mb, 4),
+    DEFINE_PROP_BIT("mmio", ThunderboltVGAState, flags,
+                    THUNDERBOLT_VGA_FLAG_ENABLE_MMIO, true),
+    DEFINE_PROP_BIT("qemu-extended-regs", ThunderboltVGAState, flags,
+                    THUNDERBOLT_VGA_FLAG_ENABLE_QEXT, true),
+    DEFINE_PROP_BIT("edid", ThunderboltVGAState, flags,
+                    THUNDERBOLT_VGA_FLAG_ENABLE_EDID, true),
+    DEFINE_PROP_UINT32("xres", ThunderboltVGAState, edid_info.prefx, 1280),
+    DEFINE_PROP_UINT32("yres", ThunderboltVGAState, edid_info.prefy, 800),
+    DEFINE_PROP_UINT32("xmax", ThunderboltVGAState, edid_info.maxx, 1280),
+    DEFINE_PROP_UINT32("ymax", ThunderboltVGAState, edid_info.maxy, 800),
+    DEFINE_PROP_UINT32("refresh_rate", ThunderboltVGAState,
+                       edid_info.refresh_rate, 60000),
+    DEFINE_PROP_BOOL("global-vmstate", ThunderboltVGAState,
+                     vga.global_vmstate, false),
+};
+
+static void thunderbolt_vga_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = thunderbolt_vga_realize;
+    k->romfile = "vgabios-stdvga.bin";
+    k->class_id = PCI_CLASS_DISPLAY_VGA;
+    device_class_set_props(dc, thunderbolt_vga_properties);
+    dc->desc = "Thunderbolt hotpluggable VGA";
+    dc->hotpluggable = true;
+
+    object_class_property_add_bool(klass, "big-endian-framebuffer",
+                                   thunderbolt_vga_get_big_endian_fb,
+                                   thunderbolt_vga_set_big_endian_fb);
+}
+
+static const TypeInfo thunderbolt_vga_info = {
+    .name = TYPE_THUNDERBOLT_VGA,
+    .parent = TYPE_PCI_VGA,
+    .instance_size = sizeof(ThunderboltVGAState),
+    .class_init = thunderbolt_vga_class_init,
+};
+
+static void thunderbolt_vga_register_types(void)
+{
+    type_register_static(&thunderbolt_vga_info);
+}
+
+type_init(thunderbolt_vga_register_types)
-- 
2.47.3


