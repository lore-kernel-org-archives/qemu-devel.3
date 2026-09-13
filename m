Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8587C88E65
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 17:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5nxF-0003Tr-IC; Sun, 13 Sep 2026 13:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mani@kernel.org>)
 id 1x5nUK-000091-CN; Sun, 13 Sep 2026 12:55:32 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mani@kernel.org>)
 id 1x5nTz-0004yi-KQ; Sun, 13 Sep 2026 12:55:32 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 31DC460E81;
 Sun, 13 Sep 2026 16:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39AF1F000FF;
 Sun, 13 Sep 2026 16:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789318502;
 bh=o7utxavKpIFUW01FDjLkzTq/r3iL9g9em50W9YCGwG0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BmKnMCUk95qG+c2MZk26tdmfh80tl7Iopt9rOaxwHPHSg6/ahdwK/mY0Iupprtk2a
 OJ1Vjk1uDrTt2D1fHa4sejgfab609cKjnv+UZiplf3mCVBq+AJMC41oIx7ES9DO4e+
 MDF8YyVN5usqagkGwnQqXZyrEI1+ryhcouU3mIsqIvJgNAMWu24bWZiaQUMxVXGH72
 E+A7E+M+7fvp/UtO4Qft9vL88Gs74PLK8PBmnmvyjKc6+onxW1l7+8X78BCf3V7ZEa
 VLC+KZOlXSZnvOgoSBY00IVKWtPoFh+LTcgINx2wjD/m4HSWH5D+iYC8Hyrh2/T1v8
 lHnZ1RLGlXZjg==
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Sun, 13 Sep 2026 18:54:51 +0200
Subject: [PATCH 1/4] docs/system/devices: Add PCIe Endpoint emulation
 documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-pcie-ep-emulation-v1-1-b8e8f74a5842@kernel.org>
References: <20260913-pcie-ep-emulation-v1-0-b8e8f74a5842@kernel.org>
In-Reply-To: <20260913-pcie-ep-emulation-v1-0-b8e8f74a5842@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8557; i=mani@kernel.org;
 h=from:subject:message-id; bh=+znO2n9Ef03QY6xyCPLProxiqj8u4AxSMuiMlvR8VEo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqptVgM4/tN7FFgayu6SXIvmzh06q0b6xcKZ4SV
 qS/GvMZriCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaqbVYAAKCRBVnxHm/pHO
 9d+QB/9b3wiIo/WnAZG2mK7LhCuj3OTsyosRrOuPkz7tdmwImLlBO0mRyBXnAJXEjkYlxUIhZfO
 7L0wAPW1WsbDd8iTE5U08ivD2HcnhbJKksA+hvmw6l5n9vDO40tkhOGm540VqWFvmiQEhsedMcp
 FvTDo/FaJWyz8OCXsVm94/NATE0ZUcGGHk7oOWM92CkgmvdzU8UxpuDtE80QakJ3SG1/StdNvH5
 S4FFsZJQeNi/jEKffKbgPFSpEIDIzO6Yq1qxI5TXad9jSGQa0+j67ouO7wE9MUZHlmPSt5X6c1z
 Lr6gwP1PcxBQuO3oMr0K/fPzSzigzjqW+qglphHyALn4ZqHm
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
Received-SPF: pass client-ip=172.105.4.254; envelope-from=mani@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 13 Sep 2026 13:24:48 -0400
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

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Document the PCIe Endpoint Controller (pcie-ep-ctrl) and the Endpoint
Function (pcie-ep-generic), including how they share a single guest
address space.

The documentation walks through the QEMU invocation and the configfs
bring-up of an Endpoint Function. It also covers the kernel
configuration needed for a single guest to act as both the Endpoint
Controller and the PCI host that enumerates the Function. The current
limitations are listed at the end.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 MAINTAINERS                      |   5 ++
 docs/system/device-emulation.rst |   1 +
 docs/system/devices/pcie-ep.rst  | 140 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b5b581e17..e241f206bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2170,6 +2170,11 @@ F: docs/pci*
 F: docs/specs/*pci*
 F: docs/system/sriov.rst
 
+PCIe Endpoint Emulation
+M: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
+S: Maintained
+F: docs/system/devices/pcie-ep.rst
+
 ARM PCI Hotplug
 M: Gustavo Romero <gustavo.romero@linaro.org>
 L: qemu-arm@nongnu.org
diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index 40054bb7df..841ce35511 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -95,6 +95,7 @@ Emulated Devices
    devices/keyboard.rst
    devices/net.rst
    devices/nvme.rst
+   devices/pcie-ep.rst
    devices/scsi/index.rst
    devices/usb-u2f.rst
    devices/usb.rst
diff --git a/docs/system/devices/pcie-ep.rst b/docs/system/devices/pcie-ep.rst
new file mode 100644
index 0000000000..0e661234f7
--- /dev/null
+++ b/docs/system/devices/pcie-ep.rst
@@ -0,0 +1,140 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+PCIe Endpoint Emulation
+-----------------------
+
+QEMU can emulate a PCIe Endpoint Controller (EPC) that works with the
+Linux PCI Endpoint framework (``drivers/pci/endpoint/``). This allows
+running a Linux Endpoint Function driver, such as ``pci-epf-test``, and
+exercising it against the matching host-side PCI driver.
+
+Everything runs inside a single QEMU instance. One guest kernel acts as
+both sides. It drives the Endpoint Controller through the
+``pci-ep-generic`` platform driver and, when the Link comes up, it
+enumerates the resulting Function as a PCI host. Because there is only
+one guest, both sides share a single physical address space, so the
+Endpoint BARs and the outbound DMA window are plain aliases of guest RAM
+with no copying and no inter-process communication.
+
+Two devices cooperate:
+
+``pcie-ep-ctrl``
+   A SysBus device on the ``virt`` machine's platform bus that exposes an
+   MMIO based Endpoint Controller (EPC) controlled by the ``pci-ep-generic``
+   Linux EPC driver. The guest configures Endpoint Functions via configfs
+   and triggers operations (set_bar, raise_irq, map_addr, and so on)
+   through register writes. When the Link is brought up, the controller
+   creates a ``pcie-ep-generic`` Function and hotplugs it onto a Root Port.
+
+``pcie-ep-generic``
+   The PCI Endpoint Function. It is created programmatically by
+   ``pcie-ep-ctrl`` and cannot be instantiated with ``-device``. Its PCI
+   identity, BAR layout and interrupt capabilities come from the register
+   file the EPC driver programmed. Each BAR aliases guest RAM at the
+   address the controller was told to use, so the host and the Function
+   share the same memory.
+
+Architecture
+^^^^^^^^^^^^
+
+::
+
+   +------------------------- one QEMU / one kernel -------------------------+
+   |                                                                         |
+   |   EPF driver (pci-epf-test)              Host driver (pci-endpoint-test)|
+   |          |                                        ^                     |
+   |          | configfs                               | /dev/              |
+   |          v                                        |                     |
+   |   EPC driver (pci-ep-generic)              PCIe subsystem (pciehp)      |
+   |          |                                        ^                     |
+   |          | MMIO                                   | enumerate/hotplug   |
+   |          v                                        |                     |
+   |   +----------------+   create + hotplug   +---------------------+       |
+   |   |  pcie-ep-ctrl  |--------------------->|   pcie-ep-generic   |       |
+   |   +----------------+                      |   (on Root Port)    |       |
+   |          |                                +---------------------+       |
+   |          | alias                                   | alias              |
+   |          v                                         v                    |
+   |   +-------------------------------------------------------------+       |
+   |   |               guest RAM (single address space)              |       |
+   |   |   outbound DMA window aliases  +  Endpoint BAR backing       |      |
+   |   +-------------------------------------------------------------+       |
+   +-------------------------------------------------------------------------+
+
+Outbound maps add an alias of the target RAM into the controller's
+outbound window at the offset the driver chose, and unmaps remove it.
+Endpoint BAR accesses reach the same RAM the Function was given for its
+BAR backing buffers. No data is copied and no synchronization points are
+needed, because both sides address the same memory.
+
+Usage
+^^^^^
+
+A single invocation instantiates a Root Port and the Endpoint
+Controller, pointing the controller at the Root Port with ``target-bus``:
+
+.. parsed-literal::
+
+   |qemu_system_aarch64| -machine virt -cpu cortex-a57 -m 1G \\
+       -kernel Image -initrd rootfs.cpio.gz \\
+       -device pcie-root-port,id=rp0,bus=pcie.0,chassis=1,slot=1,hotplug=on \\
+       -device pcie-ep-ctrl,target-bus=rp0 \\
+       -append "console=ttyAMA0"
+
+pcie-ep-ctrl properties
+^^^^^^^^^^^^^^^^^^^^^^^^
+
+``target-bus=ID``
+   Device ID of the PCIe Root Port the Endpoint Function is hotplugged
+   onto when the Link comes up. Required.
+
+``outbound-size=SIZE``
+   Size of the outbound DMA window (default 16 MiB).
+
+Guest configuration
+^^^^^^^^^^^^^^^^^^^^
+
+Configure the Endpoint Function via configfs (using ``pci-epf-test`` as an
+example):
+
+.. code-block:: sh
+
+   mount -t configfs configfs /sys/kernel/config
+   # The controller directory is named after the address the platform bus
+   # assigned to the device; discover it rather than hardcoding:
+   ctrl=$(ls /sys/kernel/config/pci_ep/controllers/ | head -n 1)
+   mkdir /sys/kernel/config/pci_ep/functions/pci_epf_test/func0
+   echo 0x104c > /sys/kernel/config/pci_ep/functions/pci_epf_test/func0/vendorid
+   echo 0xb00d > /sys/kernel/config/pci_ep/functions/pci_epf_test/func0/deviceid
+   echo 1 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func0/msi_interrupts
+   echo 1 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func0/msix_interrupts
+   ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/func0 \
+       /sys/kernel/config/pci_ep/controllers/$ctrl/
+   echo 1 > /sys/kernel/config/pci_ep/controllers/$ctrl/start
+
+The ``start`` write brings the Link up and triggers the hotplug. The same
+kernel then enumerates the Endpoint on the Root Port as a standard PCI
+device, which the host driver binds to.
+
+Kernel requirements
+^^^^^^^^^^^^^^^^^^^^
+
+The single guest kernel needs both the Endpoint and the host support:
+
+- ``CONFIG_PCI_ENDPOINT=y``
+- ``CONFIG_PCI_EP_GENERIC=y`` (the ``pci-ep-generic`` platform driver)
+- EPF driver for your use case (e.g. ``CONFIG_PCI_EPF_TEST=y``)
+- Host driver matching the EPF's vendor/device ID (e.g.
+  ``CONFIG_PCI_ENDPOINT_TEST=y`` for ``pci-epf-test``)
+- PCIe hotplug (``pciehp``) so the enumerated Endpoint appears at runtime
+
+Limitations
+^^^^^^^^^^^
+
+- No DMA engine emulation. Transfers use the CPU, so the Endpoint
+  framework's DMA-backed tests do not complete.
+- Legacy INTx delivery is not routed on ARM ``virt``. Use MSI or MSI-X.
+- The doorbell path is not implemented.
+- Migration is not supported, as the controller mirrors Endpoint state
+  built at runtime.
+- Currently wired only for the ARM ``virt`` machine.

-- 
2.43.0


