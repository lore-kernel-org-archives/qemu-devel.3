Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45380E64002
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 07:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9HvW-0003zm-AO; Sun, 05 Apr 2026 03:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvU-0003yu-Ni
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:44 -0400
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvS-0007QM-1W
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:44 -0400
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-2cea94c06e4so160414eec.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 00:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775374180; x=1775978980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E5HDXr0HjZKWX3A8XRFgsqoTXAEWhIhEwLxgd+5/kSA=;
 b=TbknRV7n4h4VurYz7hTgPUgn/ZBB6fGxW0VhvXbRArLBEyBSbgSAz4XDvZTsttTN9p
 tW7aY02hXhqatv1+wT7xtkyHrJcYcV4m5oWLpJNdhaFTrzglaXXOeENdCOHR7DepNQi3
 GypUaL7dkEwnt3tknvs+ueyATLjytlQaPdOT5Z74LsKniqEsyI7JD+ElOLXkDV6ka9CL
 fapThuevFxZuzRECfbdMHlsTARm9F1boMPWCxncN82gTMW1HbEFMhAlai6bCVOuysK2Q
 6coqLG8kcY4Pmrh4NPqa4z2xGZcIzN9Kor+Ezp/lYSMl7pjNHJwMpu1npMJ2y/iTVY7V
 /68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775374180; x=1775978980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E5HDXr0HjZKWX3A8XRFgsqoTXAEWhIhEwLxgd+5/kSA=;
 b=m06MIamkczz2M5loMJ/Vl8hUn1caGN5MJOXE4b0sAjoXMvS68bXw3qyUsxlwMdg2Kw
 3QLOyLq/K7EKccvWPnpxfifunnWFpOpsEiLgmtlQoWgXjLD48qqUmTDBw3TJ19swZvkl
 OB12KQvmBaGuybr+h2/UcmE/n6QS8+QYJjbD1kRrvLPmyX8bMA9M2hly1Nb9AflEKrDu
 rgiJNxBIx2pTBmnT42Z0Bl3i+KiME7/k9BPg4M2JCQMTl6eGKa2IBaF2LzjPqB5czg75
 z08YWnIEaRmPLhZGv7UG3RJVAB72+FidbKG9fzzgYGzdfBZcqARJnNRmv1SJEPgs2S0Y
 32NQ==
X-Gm-Message-State: AOJu0YzJXKFRB/RJ2I58j+nSxywDvxUWNW7yM8yPRs1yB+GCGEU/uPMd
 pHS7vBYbrQjPXYyAdvpfXRHO4muRIjYDBrPBzta30IEg5q2g4jZcFzwX0Rpq40AwmFs=
X-Gm-Gg: AeBDievtIJAJNVMHp53WA6A9VZOrW9B/R1PdvA6yyDE6orKr92Wegztz/xUacczAZ0J
 0RhEhLWBCya9xTHWo6BZdoALKgixVDMy8P+RN+L5reDUl3TFOT3JOYhGjndcLPXb03heWRU/GRZ
 FzdhgQGvPcqOKrlUgsqCx/YENM4Ttq399sbxv4DLyGo1biNxRndzGJ514Sjk37b9nfLkT0yGdWL
 H1zAzram1nIcBbhR/cHLLHou2RNeio1AVHI9S9fbgxX9Ej45kXeyUaouW+rRpaDJTJnaffzgG2H
 Foch7wib9HTPh4SOSA8Dphe1DfCowweJE8TmKPsqgOuSTZpoAl3AvewsNnCZJqIhplAthTbiwI2
 Nx6hMlb8W3TD9CsG9mIhay/riATx+9zfgXKB4K403D2lwu3t2KWoYOeDhIWns7kCCfF1n2MSLop
 u3/+qcpeH2syht417svkCgK8oz+VL4vmlklB9FawbtTuLKIh2aq7sjBOFVzQEvpo/ANonsKeadE
 cBPWBROmBlxubdsiD6Mhsd6mwU=
X-Received: by 2002:a05:7301:3f09:b0:2c0:df3b:ec1e with SMTP id
 5a478bee46e88-2cad7e3729fmr4300085eec.11.1775374180189; 
 Sun, 05 Apr 2026 00:29:40 -0700 (PDT)
Received: from localhost.localdomain ([2601:645:8200:47:41e4:ff2b:ff70:4d75])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2cb92ea0ef1sm7636502eec.21.2026.04.05.00.29.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Apr 2026 00:29:39 -0700 (PDT)
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, pbonzini@redhat.com, rbolshakov@ddn.com,
 phil@philjordan.eu, mst@redhat.com, john.levon@nutanix.com,
 thanos.makatos@nutanix.com, qemu-s390x@nongnu.org,
 "Scott J. Goldman" <scottjg@umich.edu>,
 "Scott J. Goldman" <scottjgo@gmail.com>
Subject: [RFC PATCH 10/10] docs: Add vfio-apple documentation and MAINTAINERS
 entry
Date: Sun,  5 Apr 2026 00:28:54 -0700
Message-ID: <20260405072857.66484-11-scottjgo@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260405072857.66484-1-scottjgo@gmail.com>
References: <20260405072857.66484-1-scottjgo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132a;
 envelope-from=scottjgo@gmail.com; helo=mail-dy1-x132a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: "Scott J. Goldman" <scottjg@umich.edu>

Add documentation for the Apple VFIO passthrough backend covering
requirements, usage, the DMA companion device protocol, and known
limitations.  Register the vfio-apple files in MAINTAINERS.

Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
---
 MAINTAINERS                        |  11 ++
 docs/system/device-emulation.rst   |   1 +
 docs/system/devices/vfio-apple.rst | 160 +++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+)
 create mode 100644 docs/system/devices/vfio-apple.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index ad215eced8..baed89cbf7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2338,6 +2338,17 @@ F: qapi/vfio.json
 F: migration/vfio-stub.c
 F: tests/functional/aarch64/test_device_passthrough.py
 
+vfio-apple
+M: Scott J. Goldman <scottjgo@gmail.com>
+S: Maintained
+F: hw/vfio/apple-device.c
+F: hw/vfio/apple-dext-client.c
+F: hw/vfio/apple-dext-client.h
+F: hw/vfio/apple-dma.c
+F: hw/vfio/apple.h
+F: hw/vfio/container-apple.c
+F: include/compat/linux/
+
 vfio-igd
 M: Alex Williamson <alex@shazbot.org>
 M: Cédric Le Goater <clg@redhat.com>
diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index 40054bb7df..aa3dbfa1e0 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -98,4 +98,5 @@ Emulated Devices
    devices/scsi/index.rst
    devices/usb-u2f.rst
    devices/usb.rst
+   devices/vfio-apple.rst
    devices/vfio-user.rst
diff --git a/docs/system/devices/vfio-apple.rst b/docs/system/devices/vfio-apple.rst
new file mode 100644
index 0000000000..b0e92f3b96
--- /dev/null
+++ b/docs/system/devices/vfio-apple.rst
@@ -0,0 +1,160 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. _vfio-apple:
+
+======================
+vfio-apple (macOS/ARM)
+======================
+
+QEMU supports PCI device passthrough on Apple Silicon Macs using a macOS
+DriverKit extension (dext) as the host backend.  Unlike Linux VFIO, which
+relies on kernel-managed IOMMU groups and ``/dev/vfio``, the Apple backend
+communicates with a userspace driver extension through IOKit's
+``IOUserClient`` interface.
+
+Requirements
+============
+
+- Apple Silicon Mac running macOS
+- A DriverKit extension (``VFIOUserPCIDriver``) installed and running for
+  the target PCI device
+- QEMU built with ``--enable-hvf`` on a Darwin host
+- A guest kernel module that speaks the ``apple-dma-pci`` protocol (see
+  below)
+
+Usage
+=====
+
+Specify the host PCI device by its bus/device/function address:
+
+.. code-block:: console
+
+  -device vfio-apple-pci,host=01:00.0
+
+This creates a ``vfio-apple-pci`` device that connects to the dext instance
+managing the given host PCI BDF.  A companion ``apple-dma-pci`` device is
+automatically created on the same bus.
+
+Architecture
+============
+
+The implementation consists of several components:
+
+``vfio-apple-pci``
+  A QOM subclass of ``vfio-pci`` that overrides realize/exit to set up the
+  Apple-specific IOMMU container and interrupt delivery.
+
+``vfio-iommu-apple``
+  An IOMMU container backend.  DMA map/unmap through the container are
+  no-ops because DMA is managed separately through the companion device
+  (see below).
+
+``apple-dma-pci``
+  A paravirtualized PCI device that provides batched DMA map/unmap
+  operations between the guest and the dext.  The guest driver writes a
+  command page GPA to BAR0 registers, fills request/response buffers in
+  RAM, then triggers processing with a single doorbell write (one VMEXIT
+  per batch).
+
+``Dext communication``
+  All host device access (config space, BAR MMIO, DMA registration,
+  interrupt notification) goes through IOKit ``IOConnectCallMethod`` calls to
+  the dext's ``IOUserClient``.
+
+DMA mapping
+-----------
+
+On Linux, VFIO programs the hardware IOMMU directly via kernel ioctls.
+QEMU chooses IOVAs and the kernel maps them through the IOMMU.
+
+On macOS, the DART (Apple's IOMMU) is managed entirely by the DriverKit
+extension.  QEMU cannot choose IOVAs — it can only request that a host
+virtual address be mapped for DMA, and the platform assigns the resulting
+IOVA.  This means the guest cannot assume any particular IOVA layout;
+the ``apple-dma-pci`` companion device returns the platform-assigned IOVA
+and bus address in its response entries.
+
+Because of this architecture, a **guest kernel module** is required to
+drive the ``apple-dma-pci`` device.  The module discovers the companion
+device, submits map/unmap batches, and translates between guest physical
+addresses and the platform-assigned DMA addresses that the passthrough
+device will use.
+
+Platform constraints
+--------------------
+
+The macOS DART imposes limits that do not exist with Linux VFIO:
+
+- **No IOVA alignment guarantees**: the platform may return any address.
+  Guest drivers that assume page-aligned or naturally-aligned DMA
+  addresses must account for this.
+- **Total DMA memory limit**: approximately 1.5 GB of guest memory can be
+  registered for DMA at any time.
+- **Mapping count limit**: approximately 64k concurrent DMA mappings.
+
+These limits are enforced by the DART hardware and DriverKit, not by QEMU.
+Exceeding them will cause map requests to fail.
+
+``apple-dma-pci`` register interface
+-------------------------------------
+
+.. list-table::
+   :header-rows: 1
+
+   * - Offset
+     - Name
+     - Access
+     - Description
+   * - 0x00
+     - VERSION
+     - R
+     - Protocol version
+   * - 0x04
+     - MANAGED_BDF
+     - R
+     - Guest BDF this device maps for
+   * - 0x08
+     - MAX_ENTRIES
+     - R
+     - Maximum entries per batch
+   * - 0x0C
+     - STATUS
+     - R
+     - Result of last doorbell
+   * - 0x10
+     - CMD_GPA_LO
+     - W
+     - Command page GPA [31:0]
+   * - 0x14
+     - CMD_GPA_HI
+     - W
+     - Command page GPA [63:32]
+   * - 0x18
+     - DOORBELL
+     - W
+     - Any write triggers batch processing
+
+Interrupts
+----------
+
+The dext tracks pending hardware interrupts (MSI/MSI-X) in a bitfield
+(one bit per vector, up to 256 vectors).  When a hardware interrupt fires,
+the dext sets the corresponding bit and completes an asynchronous
+notification to QEMU via ``IOConnectCallAsyncMethod``.  The notification
+is dispatched through a GCD queue, which wakes the QEMU main loop via an
+``EventNotifier`` pipe.  QEMU then atomically reads and clears the pending
+bits and delivers each flagged vector to the guest.
+
+Limitations
+===========
+
+- **Guest kernel module required**: the ``apple-dma-pci`` protocol is not
+  handled by standard guest drivers.
+- **No migration support**: the Apple container does not support dirty page
+  tracking.
+- **Interrupt delivery**: interrupts are delivered asynchronously via IOKit
+  rather than directly by the kernel, adding some overhead compared to
+  Linux VFIO.
+- **No hot-plug**: devices must be configured at VM startup.
+- **DMA constraints**: see `Platform constraints`_ above.
+- **Darwin only**: the base ``vfio-pci`` device type is not user-creatable
+  on Darwin; use ``vfio-apple-pci`` instead.
-- 
2.50.1 (Apple Git-155)


