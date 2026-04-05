Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD21E64014
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 07:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9HvH-0003tr-CR; Sun, 05 Apr 2026 03:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvF-0003tA-2B
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:29 -0400
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvD-0007EN-2G
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:28 -0400
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-2cc4c693d59so4544047eec.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 00:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775374164; x=1775978964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vACLg16/EFfu3BZP15AOnO+ZvPMtlxDVglLIgvx0zIE=;
 b=I98jHri6BAua5+B93P00vhTFfCMge3TK3UBkUN6JOVR/ypFSoVVMS0hYO0zirh0kIU
 oEeE061qRlFGwtGC4RYbJ+gBbTrxJYBVcPTVdbv6pu+afLaq7NrgcL3XO67JwaEf+orc
 4HEG+Kc+4mW9gzhaAbb5W/5B5fNQX4CBcw6mmNkPLWHcnTUVZ7YwY6QX2Y4y484wBEgW
 tipyzklWiDxmmf4samfMgRi6+Fg37gfZM3hVPmP5NBVGk6OKnEi/WkBQEVNVEIbLkZ1o
 EOXM4vM6yTAyNfjiY5RTPRmOHqcgSEd4nM0TwrNVOrB0mIj/1gOoMnlCWyaxAVknYz5I
 Ap2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775374164; x=1775978964;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vACLg16/EFfu3BZP15AOnO+ZvPMtlxDVglLIgvx0zIE=;
 b=LVf5m0zMKmXJetZX66lUpmQlp1aeyc6+213E3MH5PvF9uiqh6XaSQg+r7qjYInhPry
 r/kYZc1BQsuP4Aj7VSEWob1eXScybNnpsGglJWZHZMd2k3gsub7w+tFFTvDKkyBxIh48
 4k04qzytvCs8SUiQrVI33cC+vzvj0hLfb/BOcfg8lGBSxoA7XISmmYnljrG9cA11JjfG
 /PrlVM2fprXl5FBIuNuRV6zXT39iqcYVpT1L9j6xdXAFSh7evobKW4+DE8bOp9tkXeCO
 cG2bmWOrply/LJ5ViZaCXG9Bz4LBjpVhOlOUgnVHGZA/7tVTOyD8m90EQOhcpebzgPJ3
 8RvA==
X-Gm-Message-State: AOJu0YzXYZjb9V+f8Jjgw+eyEOtcsoGrTMIx2FNLbfquT4CRcfCDN+sj
 3t0XQBRlQ4FvI5GIyU5DR6Ouau1ECJSY+3XYmgHgTMZOR1QguGSqJgwpKhqw4v6/uA4=
X-Gm-Gg: AeBDiesQXPyJBlYIfox8JzmbOSL+nz7Vx/cc7JwtATN8DMvjpf6SGAmWNhAMeKPeuBk
 Do2exulUxkLS6keMshFU/8xv3hbF4ZUssYeYx7trFl3tixFmVjMVomLJtZw3bATk9x/iQ5532TH
 A14xuPZzPEGS3Vg1qqo1HjQiBC1cpL360B0GA4rMc+eIpjYgJ3QAL8fcf6guTFsrkns27Xe6x0Z
 t9P27PiMTWGSrauF9MuKQW+VsyXk/usASdbEWcbNzF3+QwU+EHMguJ/knmbPn6ebEvscQnLyhuM
 3M6bTo/GoOlpQFU8CE+RklThrremP3iOqR8wmi+afICq3IrCn3ap9LLlOUFzGFImrmNhDPjwK2S
 SYEE4SX27c6SuUyIqE1/yKTPTSK0fHMC9zH1lwYBLoFt4lzgIrqw+H0LRRckN6xpLjtrgpsd+BR
 M6GX+IhCRJMrxKurdJ3C+lw2HBQrep+GZTj7xrY/tai+cdHeqrszkZiQkG8bJVj1NVM1y9wnRox
 vdiDnRvvDhMhcXk0OyMdBmu9gI=
X-Received: by 2002:a05:7300:a944:b0:2c0:e404:8b08 with SMTP id
 5a478bee46e88-2cbfc764974mr4685621eec.29.1775374164412; 
 Sun, 05 Apr 2026 00:29:24 -0700 (PDT)
Received: from localhost.localdomain ([2601:645:8200:47:41e4:ff2b:ff70:4d75])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2cb92ea0ef1sm7636502eec.21.2026.04.05.00.29.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Apr 2026 00:29:22 -0700 (PDT)
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, pbonzini@redhat.com, rbolshakov@ddn.com,
 phil@philjordan.eu, mst@redhat.com, john.levon@nutanix.com,
 thanos.makatos@nutanix.com, qemu-s390x@nongnu.org,
 "Scott J. Goldman" <scottjgo@gmail.com>
Subject: [RFC PATCH 00/10] vfio: PCI device passthrough on Apple Silicon Macs
Date: Sun,  5 Apr 2026 00:28:44 -0700
Message-ID: <20260405072857.66484-1-scottjgo@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=scottjgo@gmail.com; helo=mail-dy1-x1334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This series adds VFIO PCI device passthrough support for Apple Silicon
Macs running macOS, using a DriverKit extension (dext) as the host
backend instead of the Linux VFIO kernel driver.

I'm sending this as an RFC because I'd like feedback before investing
further in upstreaming.  The code is functional.  I've tested it with
an NVIDIA RTX 5090 in a Thunderbolt dock on an M4 MacBook Air.  GPU
gaming works but is slow (~30 fps on high settings in Cyberpunk 2077
[1]), likely due to the BAR access penalty described below.  AI
inference workloads appear less affected.  Ollama with Qwen 3.5
generates around 140 tok/sec on the same setup [2].

How it works:

On Linux, VFIO relies on kernel-managed IOMMU groups and /dev/vfio
for device access and DMA mapping.  On macOS, there is no equivalent
kernel interface.  Instead, a userspace DriverKit extension
(VFIOUserPCIDriver) mediates access to the physical PCI device through
IOKit's IOUserClient and PCIDriverKit APIs.

The series keeps the existing VFIOPCIDevice model and reuses QEMU's
passthrough infrastructure.  A few ioctl callsites are refactored into
io_ops callbacks, the build system is extended for Darwin, and the
Apple-specific backend plugs in behind those abstractions.

The guest sees two PCI devices: the passthrough device itself
(vfio-apple-pci, which subclasses VFIOPCIDevice) and a companion
DMA mapping device (apple-dma-pci).  On the QEMU side, an
AppleVFIOContainer implements the IOMMU backend, and a C client
library wraps the IOUserClient calls to the dext for config space,
BAR MMIO, interrupts, reset, and DMA.

DMA limitations:

This is the biggest platform constraint.  Unlike a typical IOMMU
mapping operation where the caller specifies the IOVA, the
PCIDriverKit API (IODMACommand::PrepareForDMA) returns a
system-assigned IOVA.  There is no way to request a specific address.
This means the guest's requested DMA addresses cannot be used
directly.  The guest kernel module must intercept DMA mapping calls
and forward them through the companion device to get the actual
hardware IOVA.

There are also hard platform limits: approximately 1.5 GB total
mapped memory and roughly 64k concurrent mappings.  Not all
workloads will fit within these limits, though GPU gaming and LLM
inference have worked in practice.

BAR access has performance issues as well.  HVF does not expose
controls to map device memory as cacheable in the guest, creating a
significant performance penalty on BAR MMIO.  Uncached mappings work
correctly but slowly compared to what the hardware could do.

What works:
- PCI config space passthrough
- BAR MMIO via direct-mapped device memory
- MSI/MSI-X interrupts via async notification from the dext
- Device reset (FLR with hot-reset fallback)
- DMA mapping for guest device drivers

What doesn't work:
- Expansion ROM / VBIOS passthrough
- PCI BAR quirks
- VGA region passthrough
- Migration and dirty page tracking
- Hot-unplug

Questions for reviewers:

1. Is this something the VFIO maintainers would consider carrying
   upstream?  The refactoring patches (3-6) are benign, but the Apple
   backend is a new platform with real limitations.  That said, if Apple
   lifts some of the DART/HVF restrictions in a future macOS release, the
   code changes to take advantage would likely be minor.  I'd like to
   understand whether this is in scope before doing the work to
   address review feedback on the full series.

2. The apple-dma-pci companion device: should this be a virtio device
   instead?  I went with a simple custom PCI device because the virtio
   infrastructure didn't buy much for what is essentially a {map, unmap}
   register interface, but if virtio is preferred, what is the process
   for allocating a device ID?  If a custom PCI device is the right
   approach, I've tentatively allocated 1b36:0015.  Is there a process
   for reserving a device ID under the Red Hat PCI vendor, or is
   claiming it in pci-ids.rst sufficient?  The guest-side kernel module
   hooks all DMA mapping functions for passed-through devices, which is
   unusual enough that I'm not sure it's upstreamable in the Linux
   kernel.  I can maintain it out of tree if needed.

3. Should the macOS host-side DriverKit extension live in the QEMU
   tree?  It's not included in this series and requires Apple code
   signing.  I'm happy to keep it out of tree if that's preferred,
   or include the source if reviewers want it co-located.

4. The existing VFIO code includes <linux/vfio.h> from the
   linux-headers/ tree, which is intended to track upstream Linux
   UAPI headers.  To make this compile on macOS, I added minimal
   stub headers (include/compat/linux/types.h and linux/ioctl.h)
   so the existing vfio.h parses on macOS without modification.  An
   alternative would be to move an approximation of vfio.h into
   standard-headers/, but that felt against the spirit of tracking
   the latest upstream headers, and the standard-headers import
   process strips ioctls which the VFIO code relies on.  I felt
   the stub approach was the least invasive, but I'm open to
   changing it if there's a preferred way to handle this.

[1] https://imgur.com/a/xoRS9kT
[2] https://imgur.com/a/ui4pYF0

Scott J. Goldman (10):
  vfio/pci: Use the write side of EventNotifier for IRQ signaling
  accel/hvf: avoid executable mappings for RAM-device memory
  vfio: Allow building on Darwin hosts
  vfio: Prepare existing code for Apple VFIO backend
  vfio: Add region_map and region_unmap callbacks to VFIODeviceIOOps
  vfio: Add device_reset callback to VFIODeviceIOOps
  vfio/apple: Add DriverKit dext client library
  vfio/apple: Add IOMMU container and PCI device
  vfio/apple: Add apple-dma-pci companion device
  docs: Add vfio-apple documentation and MAINTAINERS entry

 Kconfig.host                       |   3 +
 MAINTAINERS                        |  11 +
 accel/hvf/hvf-all.c                |  10 +-
 backends/Kconfig                   |   2 +-
 docs/specs/pci-ids.rst             |   3 +
 docs/system/device-emulation.rst   |   1 +
 docs/system/devices/vfio-apple.rst | 160 +++++
 hw/vfio-user/device.c              |  16 +-
 hw/vfio/Kconfig                    |   4 +-
 hw/vfio/ap.c                       |   4 +-
 hw/vfio/apple-device.c             | 945 +++++++++++++++++++++++++++++
 hw/vfio/apple-dext-client.c        | 681 +++++++++++++++++++++
 hw/vfio/apple-dext-client.h        | 253 ++++++++
 hw/vfio/apple-dma.c                | 540 +++++++++++++++++
 hw/vfio/apple.h                    |  74 +++
 hw/vfio/ccw.c                      |   2 +-
 hw/vfio/container-apple.c          | 241 ++++++++
 hw/vfio/device.c                   |  42 ++
 hw/vfio/meson.build                |  12 +-
 hw/vfio/migration.c                |   5 +-
 hw/vfio/pci.c                      |  50 +-
 hw/vfio/pci.h                      |   1 +
 hw/vfio/region.c                   | 108 ++--
 hw/vfio/types.h                    |   2 +
 hw/vfio/vfio-helpers.h             |   2 +-
 hw/vfio/vfio-migration-internal.h  |   4 +-
 hw/vfio/vfio-region.h              |   4 +
 include/compat/linux/ioctl.h       |   2 +
 include/compat/linux/types.h       |  26 +
 include/hw/pci/pci.h               |   1 +
 include/hw/vfio/vfio-container.h   |   1 +
 include/hw/vfio/vfio-device.h      |  40 +-
 meson.build                        |  10 +-
 util/event_notifier-posix.c        |   5 +-
 34 files changed, 3197 insertions(+), 68 deletions(-)
 create mode 100644 docs/system/devices/vfio-apple.rst
 create mode 100644 hw/vfio/apple-device.c
 create mode 100644 hw/vfio/apple-dext-client.c
 create mode 100644 hw/vfio/apple-dext-client.h
 create mode 100644 hw/vfio/apple-dma.c
 create mode 100644 hw/vfio/apple.h
 create mode 100644 hw/vfio/container-apple.c
 create mode 100644 include/compat/linux/ioctl.h
 create mode 100644 include/compat/linux/types.h

-- 
2.50.1 (Apple Git-155)


