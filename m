Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6C1C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiCIA-0006ot-4Y; Fri, 10 Jul 2026 10:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry0911@gmail.com>)
 id 1wiBO6-0003kI-Oy
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:35:32 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rdmitry0911@gmail.com>)
 id 1wiBO0-0004wT-9w
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:35:28 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-474560436c3so883768f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783690523; x=1784295323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t1qzZjKhgO7dW7CG5cEqQbp4NZ8ciCe32QXZGVumo7M=;
 b=YRwgl/BlewaQ/g3Nj9Gj09yapMV011x0pNc9T+jygLblvXB9sqyiF23NoCK23gglSz
 phDkQE0iEoZaltnerOyJFv540fPa0adhwcSzjlOwPwtEws0ADK9vMIHkuTqyiHYAWEHq
 Imew18bi/nDh3EBwZU3Qmf+fA9YMWxEd5DkWEiJWCnClXqmk2K4Dvxhdk16PGJ8JK+BW
 95dNoNj0iF6P7jFL3Ou39N3E2/yBIqU9Yn7H2PQk/zp/Y/OURtU/q8NEBZT7Mhoa/FRt
 mKb0lfjcMM9+VZqH4H/sSsxySk6/g0mmE/KPFy7XgWNils7jWAXWPv9uy2NtQ+H4z4dC
 iMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783690523; x=1784295323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=t1qzZjKhgO7dW7CG5cEqQbp4NZ8ciCe32QXZGVumo7M=;
 b=Ug2+MX1n86Q7SwOgKTEoXnGcuZqsbIPgjYbzFgRWlyxg4dYb5jsQEXqJPROikFd/Dh
 Kbavd5t5yHPoMIYUB8wjz5MuwrhxMLoRmFMNOzkBPuIX8BQ+gFTUyoATZfVXQldReu0M
 paiNvUe0UE3BNCgD6+A0zY7Gvfowmj04ncaSLK8w2cvu3Vr6ux/+EZ6k2QmWFkhHfk70
 yE9lC11uOulJB+jQkqakNGKCq+FUn4PcoZkkHigSVxX9d4TE4nJgS8e6dS1LfdqNdE3g
 DJgP0lFfh7YxVUcKn+dBZssWRaqn6mEryXNJv+B7AF5SP+0c0ILYeiI7gSD+lqXLAtzS
 3I5w==
X-Gm-Message-State: AOJu0YzbD40HE6TnXNBPm9Qykcl5w9GglU5G0PYEzvMRK+jV0hPKpUVY
 IEZoxSMEni//tp7jxkn3BNjVZVyEykWke5OkLctkXdSros610ehHsQzTCzJxTZgnnzA=
X-Gm-Gg: AfdE7ckp/RiQKfFVZ9apCgA494xGQ6Ho9W5Ydn3K4xG9/QqA1BuODO6JF9I+Vb1BGcU
 8coN6x/V2pmJYpxq9OIFx1HQTBeRORqXl1/iZMtN3jeYeUNhykJJL9PoVXWVDiA1FEKd5Oz9cD8
 buXCWYxYiYxpo+REZqGpvg3KgfhFLw3Dkl+mp/XqAx4rww0WhDyf+VBIkgAqM9GaC2jRgbNmRiu
 5RyjzPowBp6mzVwHkvcJ1VRV9Tk5Imj4EgzmqDc9pzcO2JnGrHvUmfYWxtyBIbfT0BhWVWwq4U2
 8bGVhc+RciIBXu2ISXTfvVe6sjWyVEX4o/WrgdsUfdsgZrESn/703re973cUR9Ma8kW68oMfx7X
 bOIWUZNyxnGuUp8i92BcZ1lE2eRxwN0hgdSIHIq0//0p3YvfBlRNFZ8s4E3OhpR4OAOXWKQMELh
 IGMcGeG+1ePV6XE1f4BvkDs3yiiusMmV3SrTG57HRTtI+8mSd69NN9khWiWnngxQdGJ3lSRZ1Mo
 IFam7WcqHtRCzaxAo0=
X-Received: by 2002:a05:6000:25c2:b0:47d:e121:1dd1 with SMTP id
 ffacd0b85a97d-47df07554bamr13639088f8f.17.1783690522172; 
 Fri, 10 Jul 2026 06:35:22 -0700 (PDT)
Received: from debian-for-building.localdomain
 (static.244.71.243.136.clients.your-server.de. [136.243.71.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9b4d850dsm61405779f8f.0.2026.07.10.06.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 06:35:21 -0700 (PDT)
From: Dmitry R <rdmitry0911@gmail.com>
To: qemu-devel@nongnu.org
Cc: Dmitry R <rdmitry0911@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v1 1/1] hw/pci-bridge: add Thunderbolt PCIe hotplug layer
Date: Fri, 10 Jul 2026 16:34:38 +0300
Message-ID: <20260710133440.2845828-2-rdmitry0911@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710133440.2845828-1-rdmitry0911@gmail.com>
References: <20260710133440.2845828-1-rdmitry0911@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=rdmitry0911@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2026 10:33:24 -0400
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

Add a Thunderbolt-flavoured PCIe root port and bus for guest-visible PCIe tunnelling experiments.  Devices behind the new bus remain normal QEMU PCI devices; the Thunderbolt root port controls link presence through a connected QOM property and emits the usual PCIe hotplug notifications.

Add a Thunderbolt PCIe-to-PCI bridge for tunnelled PCI endpoints and a separate thunderbolt-vga device type for stdvga-compatible display hotplug tests.  The regular VGA device implementation is not touched and remains non-hotpluggable.

Add qtest coverage for the Thunderbolt VGA hotplug path and documentation with HMP examples for VGA, USB storage, and NVMe hotplug.

thunderbolt-vga.c keeps the MIT license because it is derived from the existing stdvga implementation in hw/display/vga-pci.c, which carries the same license.

Signed-off-by: Dmitry R <rdmitry0911@gmail.com>
---
 README.md                                   |  91 ++++
 docs/specs/index.rst                        |   1 +
 docs/specs/thunderbolt-pcie-hotplug.rst     |  99 ++++
 hw/display/meson.build                      |   1 +
 hw/display/thunderbolt-vga.c                | 275 ++++++++++
 hw/pci-bridge/meson.build                   |   2 +
 hw/pci-bridge/thunderbolt_pcie_pci_bridge.c | 156 ++++++
 hw/pci-bridge/thunderbolt_root_port.c       | 565 ++++++++++++++++++++
 tests/qtest/display-vga-test.c              |  68 +++
 9 files changed, 1258 insertions(+)
 create mode 100644 README.md
 create mode 100644 docs/specs/thunderbolt-pcie-hotplug.rst
 create mode 100644 hw/display/thunderbolt-vga.c
 create mode 100644 hw/pci-bridge/thunderbolt_pcie_pci_bridge.c
 create mode 100644 hw/pci-bridge/thunderbolt_root_port.c

diff --git a/README.md b/README.md
new file mode 100644
index 0000000000..1115c9db82
--- /dev/null
+++ b/README.md
@@ -0,0 +1,91 @@
+SPDX-License-Identifier: GPL-2.0-or-later
+
+# QEMU Thunderbolt PCIe hotplug layer
+
+This branch adds a Thunderbolt-flavoured PCIe hotplug layer for QEMU
+experiments.  The implementation keeps normal QEMU PCI devices intact and
+adds a new Thunderbolt bus/root-port layer around them.
+
+The primary goal is to provide hotplug and hot-unplug for real and virtual
+devices in guests that do not support those devices being added or removed
+directly.  macOS is the main validation target for this path: devices can be
+tunnelled through a guest-visible Thunderbolt layer even when direct PCIe
+hotplug for the same endpoint is not usable.
+
+The regular QEMU `VGA` device is not changed and is not made hotpluggable.
+Thunderbolt display experiments use a separate `thunderbolt-vga` device type.
+
+## Added device types
+
+- `thunderbolt-root-port`: a PCIe root port that creates a `thunderbolt-bus`.
+  Its `connected` QOM property controls guest-visible link presence.
+- `thunderbolt-pcie-pci-bridge`: a PCIe-to-PCI bridge for tunnelled PCI
+  endpoints with Thunderbolt-related ACPI properties.
+- `thunderbolt-vga`: a hotpluggable stdvga-compatible endpoint with constrained
+  default EDID settings for guest hotplug tests.
+
+## Basic boot example
+
+Start the guest with its normal boot display and an empty Thunderbolt root
+port:
+
+```sh
+qemu-system-x86_64 \
+  -machine q35 \
+  -device VGA,id=bootvga,bus=pcie.0,addr=0x06,vgamem_mb=4,xres=1280,yres=800,xmax=1280,ymax=800,refresh_rate=60000 \
+  -device thunderbolt-root-port,id=tbrp0,bus=pcie.0,chassis=1,slot=1,addr=0x05 \
+  ...
+```
+
+Hotplug and remove a Thunderbolt VGA endpoint through the QEMU monitor:
+
+```text
+(qemu) device_add thunderbolt-vga,id=tbvga0,bus=tbrp0,addr=0x00
+(qemu) device_del tbvga0
+```
+
+Disconnect or reconnect the whole Thunderbolt root port:
+
+```text
+(qemu) qom-set /machine/peripheral/tbrp0 connected false
+(qemu) qom-set /machine/peripheral/tbrp0 connected true
+```
+
+## USB storage example
+
+Attach a USB controller behind the Thunderbolt root port, then attach USB mass
+storage to that controller:
+
+```text
+(qemu) device_add qemu-xhci,id=tbxhci0,bus=tbrp0,addr=0x00
+(qemu) drive_add 0 if=none,id=TBUSB,file=TBUSB.raw,format=raw,cache=writeback,aio=threads
+(qemu) device_add usb-storage,id=tbusb0,bus=tbxhci0.0,drive=TBUSB,serial=tb-usb-stick0
+```
+
+After the guest ejects or unmounts the disk, remove the device and controller:
+
+```text
+(qemu) device_del tbusb0
+(qemu) device_del tbxhci0
+```
+
+## NVMe example
+
+```text
+(qemu) drive_add 0 if=none,id=TBNVME,file=TBNVME.qcow2,format=qcow2
+(qemu) device_add nvme,id=tbnvme0,bus=tbrp0,addr=0x00,serial=tb-nvme0,drive=TBNVME
+(qemu) device_del tbnvme0
+```
+
+## Validation status
+
+The development validation used macOS guests booted from overlay disk images so
+the base images stayed immutable.  The tested hotplug flows covered:
+
+- `thunderbolt-vga` detection and removal while the standard boot VGA remained.
+- NVMe controller hotplug and driver instance disappearance after unplug.
+- USB controller hotplug, USB storage mount/write/eject, controller removal,
+  replug, and data persistence verification.
+
+The qtest coverage checks that regular `VGA` hotplug still fails while
+`thunderbolt-vga` can be hotplugged behind `thunderbolt-root-port`.
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index b7909a108a..1f0d3e4b4a 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -31,6 +31,7 @@ guest hardware that is specific to QEMU.
    pvpanic
    spdm
    standard-vga
+   thunderbolt-pcie-hotplug
    virt-ctlr
    vmcoreinfo
    vmgenid
diff --git a/docs/specs/thunderbolt-pcie-hotplug.rst b/docs/specs/thunderbolt-pcie-hotplug.rst
new file mode 100644
index 0000000000..f14c64b181
--- /dev/null
+++ b/docs/specs/thunderbolt-pcie-hotplug.rst
@@ -0,0 +1,99 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Thunderbolt PCIe hotplug layer
+==============================
+
+This series adds a Thunderbolt-flavoured PCIe layer for experiments with
+guest-visible PCIe tunnelling.  Devices behind the layer remain normal QEMU
+PCI devices; the Thunderbolt root port provides the guest-visible connection
+state, ACPI properties, and PCIe hotplug notifications.
+
+The main use case is hotplug and hot-unplug of real and virtual devices in
+guests that cannot use direct hotplug for those devices.  For example, a macOS
+guest can observe the endpoint through a guest-visible Thunderbolt layer when
+direct PCIe hotplug for the same endpoint is not supported or not usable.
+
+The implementation adds three user-visible device types:
+
+``thunderbolt-root-port``
+  PCIe root port that creates a ``thunderbolt-bus`` secondary bus.  The
+  ``connected`` QOM property controls whether devices behind the port are
+  reported as present to the guest.
+
+``thunderbolt-pcie-pci-bridge``
+  PCIe-to-PCI bridge for tunnelled PCI endpoints.  It adds Thunderbolt-related
+  ACPI properties while leaving downstream PCI devices otherwise normal.
+
+``thunderbolt-vga``
+  Hotpluggable stdvga-compatible device for Thunderbolt experiments.  The
+  regular ``VGA`` device is not made hotpluggable and its defaults are not
+  changed.
+
+Basic launch example
+--------------------
+
+Start the guest with its normal boot display and an empty Thunderbolt root
+port:
+
+::
+
+  qemu-system-x86_64 \
+      -machine q35 \
+      -device VGA,id=bootvga,bus=pcie.0,addr=0x06,vgamem_mb=4,xres=1280,yres=800,xmax=1280,ymax=800,refresh_rate=60000 \
+      -device thunderbolt-root-port,id=tbrp0,bus=pcie.0,chassis=1,slot=1,addr=0x05 \
+      ...
+
+Hotplug a Thunderbolt VGA endpoint after the guest has booted:
+
+::
+
+  (qemu) device_add thunderbolt-vga,id=tbvga0,bus=tbrp0,addr=0x00
+  (qemu) device_del tbvga0
+
+Temporarily disconnect and reconnect the whole Thunderbolt port:
+
+::
+
+  (qemu) qom-set /machine/peripheral/tbrp0 connected false
+  (qemu) qom-set /machine/peripheral/tbrp0 connected true
+
+USB storage example
+-------------------
+
+Attach a USB controller to the Thunderbolt root port, then attach USB mass
+storage to that controller:
+
+::
+
+  (qemu) device_add qemu-xhci,id=tbxhci0,bus=tbrp0,addr=0x00
+  (qemu) drive_add 0 if=none,id=TBUSB,file=TBUSB.raw,format=raw,cache=writeback,aio=threads
+  (qemu) device_add usb-storage,id=tbusb0,bus=tbxhci0.0,drive=TBUSB,serial=tb-usb-stick0
+
+After the guest ejects or unmounts the disk, remove the USB device and the
+controller:
+
+::
+
+  (qemu) device_del tbusb0
+  (qemu) device_del tbxhci0
+
+NVMe example
+------------
+
+Attach an NVMe controller behind the Thunderbolt root port:
+
+::
+
+  (qemu) drive_add 0 if=none,id=TBNVME,file=TBNVME.qcow2,format=qcow2
+  (qemu) device_add nvme,id=tbnvme0,bus=tbrp0,addr=0x00,serial=tb-nvme0,drive=TBNVME
+  (qemu) device_del tbnvme0
+
+Notes for review
+----------------
+
+The regular QEMU ``VGA`` type is intentionally left non-hotpluggable.  Tests
+check that hotplugging ``VGA`` behind a Thunderbolt root port still fails, and
+that ``thunderbolt-vga`` can be hotplugged with constrained display defaults.
+
+The macOS validation flow used QCOW2 overlays for all mutable disks so the base
+guest images remained unchanged.
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
diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
index 2e0eb0d233..8bb58ec84c 100644
--- a/hw/pci-bridge/meson.build
+++ b/hw/pci-bridge/meson.build
@@ -3,7 +3,9 @@ pci_ss.add(when: 'CONFIG_PCI_BRIDGE', if_true: files('pci_bridge_dev.c'))
 pci_ss.add(when: 'CONFIG_I82801B11', if_true: files('i82801b11.c'))
 pci_ss.add(when: 'CONFIG_IOH3420', if_true: files('ioh3420.c'))
 pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'gen_pcie_root_port.c'))
+pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('thunderbolt_root_port.c'))
 pci_ss.add(when: 'CONFIG_PCIE_PCI_BRIDGE', if_true: files('pcie_pci_bridge.c'))
+pci_ss.add(when: 'CONFIG_PCIE_PCI_BRIDGE', if_true: files('thunderbolt_pcie_pci_bridge.c'))
 pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'),
                                if_false: files('pci_expander_bridge_stubs.c'))
 pci_ss.add(when: 'CONFIG_XIO3130', if_true: files('xio3130_upstream.c', 'xio3130_downstream.c'))
diff --git a/hw/pci-bridge/thunderbolt_pcie_pci_bridge.c b/hw/pci-bridge/thunderbolt_pcie_pci_bridge.c
new file mode 100644
index 0000000000..afbf4871f4
--- /dev/null
+++ b/hw/pci-bridge/thunderbolt_pcie_pci_bridge.c
@@ -0,0 +1,156 @@
+/*
+ * Thunderbolt PCI Express to PCI Bridge
+ *
+ * This is the regular generic PCIe-to-PCI bridge used as a Thunderbolt PCIe
+ * tunnel endpoint. Downstream PCI devices are described normally so existing
+ * macOS drivers that are not IOPCITunnelCompatible can still bind to them.
+ *
+ * Copyright (C) 2026
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/pcihp.h"
+#include "hw/acpi/acpi_aml_interface.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bridge.h"
+#include "qom/object.h"
+
+#define TYPE_THUNDERBOLT_PCIE_PCI_BRIDGE "thunderbolt-pcie-pci-bridge"
+
+static Aml *build_device_properties_dsd(Aml *properties)
+{
+    Aml *dsd;
+
+    dsd = aml_package(2);
+    aml_append(dsd, aml_touuid("DAFFD814-6EBA-4D8C-8A91-BC9BBF4AA301"));
+    aml_append(dsd, properties);
+
+    return aml_name_decl("_DSD", dsd);
+}
+
+static void append_bool_property(Aml *properties, const char *name)
+{
+    Aml *property = aml_package(2);
+
+    aml_append(property, aml_string("%s", name));
+    aml_append(property, aml_int(1));
+    aml_append(properties, property);
+}
+
+static void build_tunnelled_device_dsd(Aml *scope)
+{
+    Aml *properties = aml_package(1);
+
+    append_bool_property(properties, "IOPCITunnelled");
+
+    aml_append(scope, build_device_properties_dsd(properties));
+}
+
+static void build_tunnelled_device_acpi_properties(Aml *scope)
+{
+    build_tunnelled_device_dsd(scope);
+}
+
+static Aml *build_pci_static_endpoint_dsm(PCIDevice *pdev)
+{
+    Aml *method;
+    Aml *params;
+    Aml *pkg;
+
+    g_assert(pdev->acpi_index != 0);
+
+    method = aml_method("_DSM", 4, AML_SERIALIZED);
+    params = aml_local(0);
+    pkg = aml_package(1);
+    aml_append(pkg, aml_int(pdev->acpi_index));
+    aml_append(method, aml_store(pkg, params));
+    aml_append(method,
+        aml_return(aml_call5("EDSM", aml_arg(0), aml_arg(1), aml_arg(2),
+                             aml_arg(3), params)));
+
+    return method;
+}
+
+static bool thunderbolt_bridge_devfn_ignored(int devfn, const PCIBus *bus)
+{
+    const PCIDevice *pdev = bus->devices[devfn];
+
+    if (PCI_FUNC(devfn) && IS_PCI_BRIDGE(pdev) && DEVICE(pdev)->hotplugged) {
+        return true;
+    }
+
+    return false;
+}
+
+static void build_tunnelled_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
+{
+    int devfn;
+
+    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
+        PCIDevice *pdev = bus->devices[devfn];
+        int adr = PCI_SLOT(devfn) << 16 | PCI_FUNC(devfn);
+        Aml *dev;
+
+        if (!pdev || thunderbolt_bridge_devfn_ignored(devfn, bus)) {
+            continue;
+        }
+
+        dev = aml_device("S%.02X", devfn);
+        aml_append(dev, aml_name_decl("_ADR", aml_int(adr)));
+
+        call_dev_aml_func(DEVICE(pdev), dev);
+
+        if (pdev->acpi_index &&
+            !object_property_get_bool(OBJECT(pdev), "hotpluggable",
+                                      &error_abort)) {
+            aml_append(dev, build_pci_static_endpoint_dsm(pdev));
+        }
+
+        aml_append(parent_scope, dev);
+    }
+}
+
+static void build_thunderbolt_pcie_pci_bridge_aml(AcpiDevAmlIf *adev,
+                                                  Aml *scope)
+{
+    PCIBridge *br = PCI_BRIDGE(adev);
+
+    build_tunnelled_device_acpi_properties(scope);
+
+    if (!DEVICE(br)->hotplugged) {
+        PCIBus *sec_bus = pci_bridge_get_sec_bus(br);
+
+        build_tunnelled_pci_bus_devices(scope, sec_bus);
+
+        if (object_property_find(OBJECT(sec_bus), ACPI_PCIHP_PROP_BSEL)) {
+            build_append_pcihp_slots(scope, sec_bus);
+        }
+    }
+}
+
+static void thunderbolt_pcie_pci_bridge_class_init(ObjectClass *klass,
+                                                   const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
+
+    dc->desc = "Thunderbolt PCI Express to PCI Bridge";
+    adevc->build_dev_aml = build_thunderbolt_pcie_pci_bridge_aml;
+}
+
+static const TypeInfo thunderbolt_pcie_pci_bridge_info = {
+    .name       = TYPE_THUNDERBOLT_PCIE_PCI_BRIDGE,
+    .parent     = "pcie-pci-bridge",
+    .class_init = thunderbolt_pcie_pci_bridge_class_init,
+};
+
+static void thunderbolt_pcie_pci_bridge_register_types(void)
+{
+    type_register_static(&thunderbolt_pcie_pci_bridge_info);
+}
+
+type_init(thunderbolt_pcie_pci_bridge_register_types)
diff --git a/hw/pci-bridge/thunderbolt_root_port.c b/hw/pci-bridge/thunderbolt_root_port.c
new file mode 100644
index 0000000000..625a5dba7e
--- /dev/null
+++ b/hw/pci-bridge/thunderbolt_root_port.c
@@ -0,0 +1,565 @@
+/*
+ * Thunderbolt PCI Express Root Port
+ *
+ * This root port creates a Thunderbolt-flavoured PCIe bus. Devices on that
+ * bus remain regular QEMU PCI devices; the Thunderbolt layer controls their
+ * guest-visible connection state.
+ *
+ * Copyright (C) 2026
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/pci.h"
+#include "hw/acpi/acpi_aml_interface.h"
+#include "hw/core/hotplug.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "hw/pci/msix.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pcie_port.h"
+#include "migration/vmstate.h"
+#include "system/system.h"
+#include "qom/object.h"
+
+#define TYPE_THUNDERBOLT_ROOT_PORT "thunderbolt-root-port"
+#define TYPE_THUNDERBOLT_BUS "thunderbolt-bus"
+
+OBJECT_DECLARE_SIMPLE_TYPE(ThunderboltRootPort, THUNDERBOLT_ROOT_PORT)
+
+#define THUNDERBOLT_ROOT_PORT_AER_OFFSET 0x100
+#define THUNDERBOLT_ROOT_PORT_ACS_OFFSET \
+    (THUNDERBOLT_ROOT_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
+#define THUNDERBOLT_ROOT_PORT_MSIX_NR_VECTOR 1
+#define THUNDERBOLT_ROOT_DEFAULT_IO_RANGE 4096
+
+struct ThunderboltRootPort {
+    PCIESlot parent_obj;
+
+    bool migrate_msix;
+    PCIResReserve res_reserve;
+    bool connected;
+    DeviceListener listener;
+    Notifier machine_done;
+};
+
+static void thunderbolt_root_port_set_presence(PCIDevice *dev, bool present,
+                                               bool notify);
+static void thunderbolt_root_port_sync_connected(ThunderboltRootPort *trp,
+                                                 bool notify);
+
+static Aml *build_device_properties_dsd(Aml *properties)
+{
+    Aml *dsd;
+
+    dsd = aml_package(2);
+    aml_append(dsd, aml_touuid("DAFFD814-6EBA-4D8C-8A91-BC9BBF4AA301"));
+    aml_append(dsd, properties);
+
+    return aml_name_decl("_DSD", dsd);
+}
+
+static void append_bool_property(Aml *properties, const char *name)
+{
+    Aml *property = aml_package(2);
+
+    aml_append(property, aml_string("%s", name));
+    aml_append(property, aml_int(1));
+    aml_append(properties, property);
+}
+
+static void build_thunderbolt_root_port_dsd(Aml *scope)
+{
+    Aml *properties;
+
+    properties = aml_package(2);
+    append_bool_property(properties, "PCI-Thunderbolt");
+    append_bool_property(properties, "pci-supports-link-change");
+
+    aml_append(scope, build_device_properties_dsd(properties));
+}
+
+static void build_thunderbolt_root_port_aml(AcpiDevAmlIf *adev, Aml *scope)
+{
+    build_thunderbolt_root_port_dsd(scope);
+    build_pci_bridge_aml(adev, scope);
+}
+
+static bool thunderbolt_root_port_get_connected(Object *obj, Error **errp)
+{
+    return THUNDERBOLT_ROOT_PORT(obj)->connected;
+}
+
+static void thunderbolt_root_port_set_connected(Object *obj, bool value,
+                                                Error **errp)
+{
+    ThunderboltRootPort *trp = THUNDERBOLT_ROOT_PORT(obj);
+
+    if (trp->connected == value) {
+        return;
+    }
+
+    trp->connected = value;
+
+    if (!qdev_is_realized(DEVICE(obj))) {
+        return;
+    }
+
+    thunderbolt_root_port_sync_connected(trp, true);
+}
+
+static void thunderbolt_root_port_sync_connected(ThunderboltRootPort *trp,
+                                                 bool notify)
+{
+    PCIDevice *rp = PCI_DEVICE(trp);
+    PCIBus *bus = pci_bridge_get_sec_bus(PCI_BRIDGE(rp));
+    bool present = false;
+    int devfn;
+
+    for (devfn = 0; devfn < PCI_DEVFN_MAX; devfn++) {
+        PCIDevice *child = bus->devices[devfn];
+
+        if (!child) {
+            continue;
+        }
+
+        present = true;
+        if (trp->connected) {
+            pci_set_enabled(child, true);
+        }
+    }
+
+    if (trp->connected && present) {
+        thunderbolt_root_port_set_presence(rp, true, notify);
+    } else {
+        thunderbolt_root_port_set_presence(rp, false, notify);
+        for (devfn = 0; devfn < PCI_DEVFN_MAX; devfn++) {
+            PCIDevice *child = bus->devices[devfn];
+
+            if (child) {
+                pci_set_enabled(child, false);
+            }
+        }
+    }
+}
+
+static void thunderbolt_root_port_machine_done(Notifier *notifier, void *data)
+{
+    ThunderboltRootPort *trp = container_of(notifier, ThunderboltRootPort,
+                                            machine_done);
+
+    thunderbolt_root_port_sync_connected(trp, false);
+}
+
+static void thunderbolt_root_port_device_realize(DeviceListener *listener,
+                                                 DeviceState *dev)
+{
+    ThunderboltRootPort *trp = container_of(listener, ThunderboltRootPort,
+                                           listener);
+    PCIBus *bus;
+
+    if (!dev->parent_bus ||
+        !object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE) ||
+        !object_dynamic_cast(OBJECT(dev->parent_bus), TYPE_THUNDERBOLT_BUS)) {
+        return;
+    }
+
+    bus = PCI_BUS(dev->parent_bus);
+    if (bus->parent_dev != PCI_DEVICE(trp)) {
+        return;
+    }
+
+    thunderbolt_root_port_sync_connected(trp, false);
+}
+
+static void thunderbolt_root_port_instance_init(Object *obj)
+{
+    ThunderboltRootPort *trp = THUNDERBOLT_ROOT_PORT(obj);
+
+    trp->connected = true;
+    object_property_add_bool(obj, "connected",
+                             thunderbolt_root_port_get_connected,
+                             thunderbolt_root_port_set_connected);
+}
+
+static void thunderbolt_root_port_set_presence(PCIDevice *dev, bool present,
+                                               bool notify)
+{
+    uint8_t *exp_cap = dev->config + dev->exp.exp_cap;
+    uint32_t lnkcap = pci_get_long(exp_cap + PCI_EXP_LNKCAP);
+
+    if (present) {
+        pcie_cap_slot_enable_power(dev);
+        pci_word_test_and_set_mask(exp_cap + PCI_EXP_SLTSTA,
+                                   PCI_EXP_SLTSTA_PDS);
+        if (dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA ||
+            (lnkcap & PCI_EXP_LNKCAP_DLLLARC)) {
+            pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
+                                       PCI_EXP_LNKSTA_DLLLA);
+        }
+    } else {
+        pci_word_test_and_clear_mask(exp_cap + PCI_EXP_SLTSTA,
+                                     PCI_EXP_SLTSTA_PDS);
+        if (dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA ||
+            (lnkcap & PCI_EXP_LNKCAP_DLLLARC)) {
+            pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
+                                         PCI_EXP_LNKSTA_DLLLA);
+        }
+    }
+
+    if (notify) {
+        pci_word_test_and_set_mask(exp_cap + PCI_EXP_SLTSTA,
+                                   PCI_EXP_SLTSTA_PDC);
+        pcie_cap_slot_push_attention_button(dev);
+    }
+}
+
+static void thunderbolt_root_port_pre_plug(HotplugHandler *hotplug_dev,
+                                           DeviceState *dev, Error **errp)
+{
+    pcie_cap_slot_pre_plug_cb(hotplug_dev, dev, errp);
+}
+
+static void thunderbolt_root_port_plug(HotplugHandler *hotplug_dev,
+                                       DeviceState *dev, Error **errp)
+{
+    ThunderboltRootPort *trp = THUNDERBOLT_ROOT_PORT(hotplug_dev);
+
+    if (trp->connected) {
+        pcie_cap_slot_plug_cb(hotplug_dev, dev, errp);
+        return;
+    }
+
+    pci_set_enabled(PCI_DEVICE(dev), false);
+    thunderbolt_root_port_set_presence(PCI_DEVICE(hotplug_dev), false, false);
+}
+
+static void thunderbolt_root_port_unplug_request(HotplugHandler *hotplug_dev,
+                                                 DeviceState *dev,
+                                                 Error **errp)
+{
+    pcie_cap_slot_unplug_request_cb(hotplug_dev, dev, errp);
+}
+
+static void thunderbolt_root_port_unplug(HotplugHandler *hotplug_dev,
+                                         DeviceState *dev, Error **errp)
+{
+    pcie_cap_slot_unplug_cb(hotplug_dev, dev, errp);
+}
+
+static uint8_t thunderbolt_root_port_aer_vector(const PCIDevice *dev)
+{
+    return 0;
+}
+
+static void thunderbolt_root_port_aer_vector_update(PCIDevice *dev)
+{
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(dev);
+
+    if (rpc->aer_vector) {
+        pcie_aer_root_set_vector(dev, rpc->aer_vector(dev));
+    }
+}
+
+static int thunderbolt_root_port_interrupts_init(PCIDevice *dev, Error **errp)
+{
+    int rc;
+
+    rc = msix_init_exclusive_bar(dev, THUNDERBOLT_ROOT_PORT_MSIX_NR_VECTOR,
+                                 0, errp);
+    if (rc < 0) {
+        assert(rc == -ENOTSUP);
+    } else {
+        msix_vector_use(dev, 0);
+    }
+
+    return rc;
+}
+
+static void thunderbolt_root_port_interrupts_uninit(PCIDevice *dev)
+{
+    msix_uninit_exclusive_bar(dev);
+}
+
+static void thunderbolt_root_port_write_config(PCIDevice *dev,
+                                               uint32_t address,
+                                               uint32_t val, int len)
+{
+    uint32_t root_cmd =
+        pci_get_long(dev->config + dev->exp.aer_cap + PCI_ERR_ROOT_COMMAND);
+    uint16_t slt_ctl;
+    uint16_t slt_sta;
+
+    pcie_cap_slot_get(dev, &slt_ctl, &slt_sta);
+
+    pci_bridge_write_config(dev, address, val, len);
+    thunderbolt_root_port_aer_vector_update(dev);
+    pcie_cap_slot_write_config(dev, slt_ctl, slt_sta, address, val, len);
+    pcie_aer_write_config(dev, address, val, len);
+    pcie_aer_root_write_config(dev, address, val, len, root_cmd);
+}
+
+static void thunderbolt_root_port_reset_hold(Object *obj, ResetType type)
+{
+    ThunderboltRootPort *trp = THUNDERBOLT_ROOT_PORT(obj);
+    PCIDevice *dev = PCI_DEVICE(obj);
+    DeviceState *qdev = DEVICE(obj);
+
+    thunderbolt_root_port_aer_vector_update(dev);
+    pcie_cap_root_reset(dev);
+    pcie_cap_deverr_reset(dev);
+    pcie_cap_slot_reset(dev);
+    pcie_cap_arifwd_reset(dev);
+    pcie_acs_reset(dev);
+    pcie_aer_root_reset(dev);
+    pci_bridge_reset(qdev);
+    pci_bridge_disable_base_limit(dev);
+    thunderbolt_root_port_sync_connected(trp, false);
+}
+
+static void thunderbolt_root_port_realize_pci(PCIDevice *dev, Error **errp)
+{
+    PCIEPort *p = PCIE_PORT(dev);
+    PCIESlot *s = PCIE_SLOT(dev);
+    PCIDeviceClass *dc = PCI_DEVICE_GET_CLASS(dev);
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(dev);
+    int rc;
+
+    pci_config_set_interrupt_pin(dev->config, 1);
+    pci_bridge_initfn(dev, TYPE_THUNDERBOLT_BUS);
+    pcie_port_init_reg(dev);
+
+    rc = pci_bridge_ssvid_init(dev, rpc->ssvid_offset, dc->vendor_id,
+                               rpc->ssid, errp);
+    if (rc < 0) {
+        error_append_hint(errp, "Can't init SSV ID, error %d\n", rc);
+        goto err_bridge;
+    }
+
+    if (rpc->interrupts_init) {
+        rc = rpc->interrupts_init(dev, errp);
+        if (rc < 0) {
+            goto err_bridge;
+        }
+    }
+
+    rc = pcie_cap_init(dev, rpc->exp_offset, PCI_EXP_TYPE_ROOT_PORT,
+                       p->port, errp);
+    if (rc < 0) {
+        error_append_hint(errp, "Can't add Root Port capability, "
+                          "error %d\n", rc);
+        goto err_int;
+    }
+
+    pcie_cap_arifwd_init(dev);
+    pcie_cap_deverr_init(dev);
+    pcie_cap_slot_init(dev, s);
+    qbus_set_hotplug_handler(BUS(pci_bridge_get_sec_bus(PCI_BRIDGE(dev))),
+                             OBJECT(dev));
+    pcie_cap_root_init(dev);
+
+    pcie_chassis_create(s->chassis);
+    rc = pcie_chassis_add_slot(s);
+    if (rc < 0) {
+        error_setg(errp, "Can't add chassis slot, error %d", rc);
+        goto err_pcie_cap;
+    }
+
+    rc = pcie_aer_init(dev, PCI_ERR_VER, rpc->aer_offset,
+                       PCI_ERR_SIZEOF, errp);
+    if (rc < 0) {
+        goto err;
+    }
+    pcie_aer_root_init(dev);
+    thunderbolt_root_port_aer_vector_update(dev);
+
+    if (rpc->acs_offset) {
+        pcie_acs_init(dev, rpc->acs_offset);
+    }
+
+    THUNDERBOLT_ROOT_PORT(dev)->listener.realize =
+        thunderbolt_root_port_device_realize;
+    device_listener_register(&THUNDERBOLT_ROOT_PORT(dev)->listener);
+
+    THUNDERBOLT_ROOT_PORT(dev)->machine_done.notify =
+        thunderbolt_root_port_machine_done;
+    qemu_add_machine_init_done_notifier(
+        &THUNDERBOLT_ROOT_PORT(dev)->machine_done);
+
+    return;
+
+err:
+    pcie_chassis_del_slot(s);
+err_pcie_cap:
+    pcie_cap_exit(dev);
+err_int:
+    if (rpc->interrupts_uninit) {
+        rpc->interrupts_uninit(dev);
+    }
+err_bridge:
+    pci_bridge_exitfn(dev);
+}
+
+static void thunderbolt_root_port_exit(PCIDevice *dev)
+{
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(dev);
+    PCIESlot *s = PCIE_SLOT(dev);
+
+    pcie_aer_exit(dev);
+    pcie_chassis_del_slot(s);
+    pcie_cap_exit(dev);
+    if (rpc->interrupts_uninit) {
+        rpc->interrupts_uninit(dev);
+    }
+    device_listener_unregister(&THUNDERBOLT_ROOT_PORT(dev)->listener);
+    qemu_remove_machine_init_done_notifier(
+        &THUNDERBOLT_ROOT_PORT(dev)->machine_done);
+    pci_bridge_exitfn(dev);
+}
+
+static void thunderbolt_root_port_realize(DeviceState *dev, Error **errp)
+{
+    ThunderboltRootPort *trp = THUNDERBOLT_ROOT_PORT(dev);
+    PCIESlot *slot = PCIE_SLOT(dev);
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(dev);
+    Error *local_err = NULL;
+    int rc;
+
+    rpc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (slot->hide_native_hotplug_cap &&
+        trp->res_reserve.io == (uint64_t)-1 && slot->hotplug) {
+        trp->res_reserve.io = THUNDERBOLT_ROOT_DEFAULT_IO_RANGE;
+    }
+
+    rc = pci_bridge_qemu_reserve_cap_init(PCI_DEVICE(dev), 0,
+                                          trp->res_reserve, errp);
+    if (rc < 0) {
+        rpc->parent_class.exit(PCI_DEVICE(dev));
+        return;
+    }
+
+    if (!trp->res_reserve.io) {
+        PCIDevice *pdev = PCI_DEVICE(dev);
+
+        pci_word_test_and_clear_mask(pdev->wmask + PCI_COMMAND,
+                                     PCI_COMMAND_IO);
+        pdev->wmask[PCI_IO_BASE] = 0;
+        pdev->wmask[PCI_IO_LIMIT] = 0;
+    }
+}
+
+static bool thunderbolt_root_port_test_migrate_msix(void *opaque,
+                                                    int version_id)
+{
+    ThunderboltRootPort *trp = opaque;
+
+    return trp->migrate_msix;
+}
+
+static const VMStateDescription vmstate_thunderbolt_root_port = {
+    .name = "thunderbolt-root-port",
+    .priority = MIG_PRI_PCI_BUS,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = pcie_cap_slot_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj.parent_obj,
+                           ThunderboltRootPort),
+        VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.parent_obj.exp.aer_log,
+                       ThunderboltRootPort, 0, vmstate_pcie_aer_log,
+                       PCIEAERLog),
+        VMSTATE_MSIX_TEST(parent_obj.parent_obj.parent_obj.parent_obj,
+                          ThunderboltRootPort,
+                          thunderbolt_root_port_test_migrate_msix),
+        VMSTATE_BOOL(connected, ThunderboltRootPort),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property thunderbolt_root_port_props[] = {
+    DEFINE_PROP_BOOL("x-migrate-msix", ThunderboltRootPort,
+                     migrate_msix, true),
+    DEFINE_PROP_UINT32("bus-reserve", ThunderboltRootPort,
+                       res_reserve.bus, -1),
+    DEFINE_PROP_SIZE("io-reserve", ThunderboltRootPort,
+                     res_reserve.io, -1),
+    DEFINE_PROP_SIZE("mem-reserve", ThunderboltRootPort,
+                     res_reserve.mem_non_pref, -1),
+    DEFINE_PROP_SIZE("pref32-reserve", ThunderboltRootPort,
+                     res_reserve.mem_pref_32, -1),
+    DEFINE_PROP_SIZE("pref64-reserve", ThunderboltRootPort,
+                     res_reserve.mem_pref_64, -1),
+    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
+                                speed, PCIE_LINK_SPEED_16),
+    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
+                                width, PCIE_LINK_WIDTH_32),
+};
+
+static void thunderbolt_root_port_class_init(ObjectClass *klass,
+                                             const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_CLASS(klass);
+    AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
+
+    k->vendor_id = PCI_VENDOR_ID_REDHAT;
+    k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_RP;
+    k->config_write = thunderbolt_root_port_write_config;
+    k->realize = thunderbolt_root_port_realize_pci;
+    k->exit = thunderbolt_root_port_exit;
+    dc->desc = "Thunderbolt PCI Express Root Port";
+    dc->vmsd = &vmstate_thunderbolt_root_port;
+    device_class_set_props(dc, thunderbolt_root_port_props);
+    device_class_set_parent_realize(dc, thunderbolt_root_port_realize,
+                                    &rpc->parent_realize);
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    rc->phases.hold = thunderbolt_root_port_reset_hold;
+
+    hc->pre_plug = thunderbolt_root_port_pre_plug;
+    hc->plug = thunderbolt_root_port_plug;
+    hc->unplug = thunderbolt_root_port_unplug;
+    hc->unplug_request = thunderbolt_root_port_unplug_request;
+
+    rpc->aer_vector = thunderbolt_root_port_aer_vector;
+    rpc->interrupts_init = thunderbolt_root_port_interrupts_init;
+    rpc->interrupts_uninit = thunderbolt_root_port_interrupts_uninit;
+    rpc->aer_offset = THUNDERBOLT_ROOT_PORT_AER_OFFSET;
+    rpc->acs_offset = THUNDERBOLT_ROOT_PORT_ACS_OFFSET;
+    adevc->build_dev_aml = build_thunderbolt_root_port_aml;
+}
+
+static const TypeInfo thunderbolt_root_port_info = {
+    .name          = TYPE_THUNDERBOLT_ROOT_PORT,
+    .parent        = TYPE_PCIE_ROOT_PORT,
+    .instance_size = sizeof(ThunderboltRootPort),
+    .instance_init = thunderbolt_root_port_instance_init,
+    .class_init    = thunderbolt_root_port_class_init,
+    .interfaces = (const InterfaceInfo[]) {
+        { TYPE_ACPI_DEV_AML_IF },
+        { },
+    },
+};
+
+static const TypeInfo thunderbolt_bus_info = {
+    .name   = TYPE_THUNDERBOLT_BUS,
+    .parent = TYPE_PCIE_BUS,
+};
+
+static void thunderbolt_root_port_register_types(void)
+{
+    type_register_static(&thunderbolt_bus_info);
+    type_register_static(&thunderbolt_root_port_info);
+}
+
+type_init(thunderbolt_root_port_register_types)
diff --git a/tests/qtest/display-vga-test.c b/tests/qtest/display-vga-test.c
index 75b341a9c6..c5f526a56e 100644
--- a/tests/qtest/display-vga-test.c
+++ b/tests/qtest/display-vga-test.c
@@ -9,6 +9,21 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qobject/qdict.h"
+
+static void assert_qom_uint(QTestState *qts, const char *path,
+                            const char *property, uint64_t expected)
+{
+    QDict *rsp;
+
+    rsp = qtest_qmp(qts, "{ 'execute': 'qom-get', 'arguments': {"
+                          "'path': %s,"
+                          "'property': %s"
+                          "} }", path, property);
+    g_assert(qdict_haskey(rsp, "return"));
+    g_assert_cmpuint(qdict_get_uint(rsp, "return"), ==, expected);
+    qobject_unref(rsp);
+}
 
 static void pci_multihead(void)
 {
@@ -18,6 +33,51 @@ static void pci_multihead(void)
     qtest_quit(qts);
 }
 
+static void thunderbolt_vga_hotplug(void)
+{
+    QTestState *qts;
+    QDict *rsp;
+    QDict *err;
+
+    qts = qtest_init("-machine q35 -display none -nodefaults -vga none "
+                     "-device VGA,id=bootvga,bus=pcie.0,addr=0x02 "
+                     "-device thunderbolt-root-port,id=tbrp0,bus=pcie.0,"
+                     "chassis=1,slot=1,addr=0x05");
+
+    rsp = qtest_qmp(qts, "{ 'execute': 'device_add', "
+                          "'arguments': {"
+                          "'driver': 'VGA',"
+                          "'id': 'badstd',"
+                          "'bus': 'tbrp0',"
+                          "'addr': '0x01'"
+                          "} }");
+    g_assert(qdict_haskey(rsp, "error"));
+    err = qdict_get_qdict(rsp, "error");
+    g_assert_cmpstr(qdict_get_str(err, "desc"), ==,
+                    "Device 'VGA' does not support hotplugging");
+    qobject_unref(rsp);
+
+    rsp = qtest_qmp(qts, "{ 'execute': 'device_add', "
+                          "'arguments': {"
+                          "'driver': 'thunderbolt-vga',"
+                          "'id': 'tbvga0',"
+                          "'bus': 'tbrp0',"
+                          "'addr': '0x00'"
+                          "} }");
+    g_assert(qdict_haskey(rsp, "return"));
+    g_assert(!qdict_haskey(rsp, "error"));
+    qobject_unref(rsp);
+
+    assert_qom_uint(qts, "/machine/peripheral/tbvga0", "vgamem_mb", 4);
+    assert_qom_uint(qts, "/machine/peripheral/tbvga0", "xres", 1280);
+    assert_qom_uint(qts, "/machine/peripheral/tbvga0", "yres", 800);
+    assert_qom_uint(qts, "/machine/peripheral/tbvga0", "xmax", 1280);
+    assert_qom_uint(qts, "/machine/peripheral/tbvga0", "ymax", 800);
+    assert_qom_uint(qts, "/machine/peripheral/tbvga0", "refresh_rate", 60000);
+
+    qtest_quit(qts);
+}
+
 static void test_vga(gconstpointer data)
 {
     QTestState *qts;
@@ -31,6 +91,7 @@ int main(int argc, char **argv)
     static const char *devices[] = {
         "cirrus-vga",
         "VGA",
+        "thunderbolt-vga",
         "secondary-vga",
         "virtio-gpu-pci",
         "virtio-vga"
@@ -50,5 +111,12 @@ int main(int argc, char **argv)
         qtest_add_func("/display/pci/multihead", pci_multihead);
     }
 
+    if (qtest_has_machine("q35") &&
+        qtest_has_device("thunderbolt-root-port") &&
+        qtest_has_device("thunderbolt-vga")) {
+        qtest_add_func("/display/pci/thunderbolt-vga-hotplug",
+                       thunderbolt_vga_hotplug);
+    }
+
     return g_test_run();
 }
-- 
2.47.3


