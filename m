Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCF8C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 09:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiUKG-00050X-Cd; Sat, 11 Jul 2026 05:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry0911@gmail.com>)
 id 1wiUKF-0004zM-Fw
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 05:48:47 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rdmitry0911@gmail.com>)
 id 1wiUKD-0002wc-H9
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 05:48:47 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47362928f65so1653839f8f.2
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 02:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783763324; x=1784368124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gi7c1MfU7nbcJC21lIHFYt2wXJwMDStiiHNF/L/LY0E=;
 b=soSUgd0e99FeSlSdo/NsC8mWGGL/aardELi4P5YtWhINuJhdqTMt3h/wpR5U1a8ixU
 n+lsSh4dHdsI7CRgWlEeL2wes3xmzI7wAQ3eqmC3K8gBlnc4y0OPXgaj0fIorQo8xw8S
 0W/w8Ksgoa+XT9gP7xs9uL/YHsbGJBWnTtgxnOr5UcoxiaLG3uWYYfSzDvl1Nhe+/Mbl
 FXNG/hjQQLLr8hE2NXF5tghju05dJlzaHWDC43u7GxaBMl6Tklhe1OADSPZYC8p58wY6
 nq5F8mzYOgY8X8hv1w6SwUCT41p0DUx4kmSw1hMT+HOzhbCUCYk+2Gudn+UvzGSsb8Xs
 l7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783763324; x=1784368124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Gi7c1MfU7nbcJC21lIHFYt2wXJwMDStiiHNF/L/LY0E=;
 b=VoVZRQbH2rhfHAEjiZYZhFBLk9cGLIZiInoABtk5MTGq7SbCU41pz1x0lGN37IWQz3
 G6Z0DzMlltCTW9h6VkPoZzMLX2nYReM8TWy8LqGHTRoOE7Ax6dNZwZ9ROeJy+vAd059Q
 mdRL7SMtQQlhWYcIvYAI3bXmSugKjjMVyVs6S4gN1GBoiynOMchFolQmXmBy7iYBBn1p
 GH2+SZ1c98ih1CANpJROAifnxvFX9enOfzSPWbYbvK5iSIQkfqrIvlQg6dvDZnF1z2zx
 QKFWqrbQVDxCJMrpKy5JzQplJostlyLkcuMxFAhMfuorErpflkidGqj2Uaezafcf1TH5
 /91w==
X-Gm-Message-State: AOJu0YwOILlRjOik6T3NmN/wOlX7EV0nrVp04QwBH+O8Q8keMh5/vErb
 5dvqaGfy6pp0cbQHOydxyvVvAtFVaqEidH3FQtsPzWm2+E8HI5ec33fi2zewyenM
X-Gm-Gg: AfdE7cn7D4mGVNomG3qQNYRM8iXIDbz6JoDYIPTMRFY/gP/UaLEExFuCkEOr61biK8t
 yqFnpqDW4PLk16R0vI2PiTgbT0Hqa33vkoJ9mP3EubaVhWtJTu36ygHmFC9SmidbR4F7N2V4i2H
 5BRXOMGfI7PJC75JKoHZ7RONqtGVGHoldng81iTk080oPVGG4MvOrG7INGJ8sPQ79njcjIzVdAC
 ZhWJbe+oErJ5uTrfbaodNQHdb1emBQcGiCAM8roC+xmVo+JS7TQt9STNnZRJN/r/pdg7qLTdPNO
 1jlHZt/sl1AYVV7MWcs4NoqVBPFU2Tiphqlf3WLQ4nTxv4zpl3SSEXxvzygf6YwmKwr456JvDGh
 xxwIMz+XAsETeJcruRpWwClfBQloUvkYeEIACZu7nUZpDnGUgVnR0Mme0h6nF4SPSzbJGXEAZ0D
 uipZM84YiLjfXTwKtPfOPWKj/lRKB+ZS9VUcrrqstHSI7IWQM+wAJJeGt3u75+DlsrD0I/qAxCu
 +mAE5QIi+pTI9q896g=
X-Received: by 2002:a05:6000:2f86:b0:475:c578:b619 with SMTP id
 ffacd0b85a97d-47f2dcd71ccmr2111570f8f.30.1783763323810; 
 Sat, 11 Jul 2026 02:48:43 -0700 (PDT)
Received: from debian-for-building.localdomain
 (static.244.71.243.136.clients.your-server.de. [136.243.71.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ad21sm66558181f8f.20.2026.07.11.02.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2026 02:48:43 -0700 (PDT)
From: Dmitry R <rdmitry0911@gmail.com>
To: qemu-devel@nongnu.org
Cc: Dmitry R <rdmitry0911@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v2 5/5] docs: document Thunderbolt PCIe hotplug layer
Date: Sat, 11 Jul 2026 12:48:01 +0300
Message-ID: <20260711094803.3589239-6-rdmitry0911@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260711094803.3589239-1-rdmitry0911@gmail.com>
References: <20260710133440.2845828-1-rdmitry0911@gmail.com>
 <20260711094803.3589239-1-rdmitry0911@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=rdmitry0911@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add documentation and usage examples for the Thunderbolt PCIe hotplug
layer, including VGA, USB storage, and NVMe hotplug flows.

Add a MAINTAINERS entry for the Thunderbolt PCIe files with Dmitry R as
reviewer, while keeping the files under the existing PCI area through
their paths.

Signed-off-by: Dmitry R <rdmitry0911@gmail.com>
---
 MAINTAINERS                             |  7 ++
 README.md                               | 91 +++++++++++++++++++++++
 docs/specs/index.rst                    |  1 +
 docs/specs/thunderbolt-pcie-hotplug.rst | 99 +++++++++++++++++++++++++
 4 files changed, 198 insertions(+)
 create mode 100644 README.md
 create mode 100644 docs/specs/thunderbolt-pcie-hotplug.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 6171cc7494..0be88e77fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2223,6 +2223,13 @@ F: docs/pci*
 F: docs/specs/*pci*
 F: docs/system/sriov.rst
 
+Thunderbolt PCIe
+R: Dmitry R <rdmitry0911@gmail.com>
+S: Maintained
+F: docs/specs/thunderbolt-pcie-hotplug.rst
+F: hw/display/thunderbolt-vga.c
+F: hw/pci-bridge/thunderbolt*.c
+
 ARM PCI Hotplug
 M: Gustavo Romero <gustavo.romero@linaro.org>
 L: qemu-arm@nongnu.org
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
-- 
2.47.3


