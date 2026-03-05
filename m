Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F73CF30930
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6Jf-0001Ey-OR; Thu, 05 Mar 2026 05:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6Jd-0001Ea-Hl
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:52:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6Jc-0005SW-0S
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772707942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KqKVH80w4KUxouuWyMseVHGorIZnS7oeAJzKGtiHB4E=;
 b=ILBsLQSCoBUcvOVBQ1vrRT12DOMbDWtmSbIbquH7P6zlB5HyGWNwBD5hiaCHS9hLNZ8Xw+
 xJsvNaA5+B9i6R4gyhqppn+fqJwsGzdDjD8HH+QpMXSB0/TSNXtwfVBwOOMtRohn1WyKWJ
 opeVEa63rhirTvpENhDc9rYK+pculN0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-0vqKJ260Ms6WoWKCUeBz3A-1; Thu,
 05 Mar 2026 05:52:20 -0500
X-MC-Unique: 0vqKJ260Ms6WoWKCUeBz3A-1
X-Mimecast-MFC-AGG-ID: 0vqKJ260Ms6WoWKCUeBz3A_1772707940
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAF261800283; Thu,  5 Mar 2026 10:52:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.75])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B9B03003E98; Thu,  5 Mar 2026 10:52:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PULL 00/28] Remove deprecated pc machine types -2.8 up to -2.12
Date: Thu,  5 Mar 2026 11:51:47 +0100
Message-ID: <20260305105215.302571-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

 Hi Peter!

The following changes since commit 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9:

  Merge tag 'pull-request-2026-03-02' of https://gitlab.com/thuth/qemu into staging (2026-03-02 14:01:46 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2026-03-05

for you to fetch changes up to 711de639d571b6ac6981020536ff816130768f58:

  hw/display/vga-pci: Do not expose the 'global-vmstate' property (2026-03-05 10:33:25 +0100)

----------------------------------------------------------------
* Remove deprecated i440fx and q35 machine types -2.8 up to -2.12
* Remove the related hw_compat handling in various devices

----------------------------------------------------------------
Philippe Mathieu-Daudé (27):
      hw/i386/pc: Remove deprecated pc-q35-2.8 and pc-i440fx-2.8 machines
      hw/i386/pc: Remove pc_compat_2_8[] array
      hw/i386/kvm: Remove KVMClockState::mach_use_reliable_get_clock field
      hw/core/machine: Remove hw_compat_2_8[] array
      hw/block/pflash: Remove PFlashCFI01::old_multiple_chip_handling field
      hw/pci/pcie: Remove QEMU_PCIE_EXTCAP_INIT definition
      hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_INIT_DEVERR definition
      hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_INIT_LNKCTL definition
      hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_INIT_PM definition
      hw/i386/pc: Remove deprecated pc-q35-2.9 and pc-i440fx-2.9 machines
      hw/i386/pc: Remove pc_compat_2_9[] array
      hw/core/machine: Remove hw_compat_2_9[] array
      hw/net/virtio-net: Remove VirtIONet::mtu_bypass_backend field
      hw/pci-bridge/gen_pcie_rp: Remove GenPCIERootPort::migrate_msix field
      hw/i386/x86-iommu: Remove X86IOMMUState::pt_supported field
      hw/i386/pc: Remove deprecated pc-q35-2.10 and pc-i440fx-2.10 machines
      hw/i386/pc: Remove pc_compat_2_10[] array
      hw/i386/pc: Remove deprecated pc-q35-2.11 and pc-i440fx-2.11 machines
      hw/i386/pc: Remove pc_compat_2_11[] array
      hw/i386/pc: Remove deprecated pc-q35-2.12 and pc-i440fx-2.12 machines
      hw/i386/pc: Remove pc_compat_2_12[] array
      hw/core/machine: Remove hw_compat_2_10[] array
      hw/input/virtio-input: Remove VirtIOInputHID::wheel_axis field
      hw/core/machine: Remove hw_compat_2_11[] array
      hw/core/machine: Remove hw_compat_2_12[] array
      hw/audio/hda-codec: Remove HDAAudioState::use_timer field
      hw/display/vga-pci: Do not expose the 'global-vmstate' property

Thomas Huth (1):
      tests/qtest/test-x86-cpuid-compat: Remove the test with the i440fx-2.9 machine

 include/hw/core/boards.h            |  15 ------
 include/hw/i386/pc.h                |  15 ------
 include/hw/i386/x86-iommu.h         |   1 -
 include/hw/pci/pci.h                |   2 -
 include/hw/virtio/virtio-input.h    |   1 -
 include/hw/virtio/virtio-net.h      |   1 -
 include/hw/virtio/virtio-pci.h      |  12 -----
 hw/audio/hda-codec.c                |  93 +++++---------------------------
 hw/block/pflash_cfi01.c             |  14 ++---
 hw/core/machine.c                   |  45 ----------------
 hw/display/cirrus_vga.c             |   2 -
 hw/display/qxl.c                    |   1 -
 hw/display/vga-pci.c                |   1 -
 hw/display/vmware_vga.c             |   2 -
 hw/i386/intel_iommu.c               |  13 +----
 hw/i386/kvm/clock.c                 |  18 -------
 hw/i386/pc.c                        |  35 -------------
 hw/i386/pc_piix.c                   |  46 ----------------
 hw/i386/pc_q35.c                    |  47 -----------------
 hw/i386/x86-iommu.c                 |   1 -
 hw/input/virtio-input-hid.c         | 102 ++----------------------------------
 hw/net/virtio-net.c                 |   8 +--
 hw/pci-bridge/gen_pcie_root_port.c  |  16 +-----
 hw/pci/pci.c                        |   2 -
 hw/pci/pcie.c                       |   6 +--
 hw/virtio/virtio-pci.c              |  35 ++++---------
 tests/qtest/test-x86-cpuid-compat.c |  11 ----
 27 files changed, 38 insertions(+), 507 deletions(-)


