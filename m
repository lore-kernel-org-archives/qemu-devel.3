Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E876CC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAd8-0005pH-Kw; Wed, 14 May 2025 07:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAd5-0005om-GO
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAcx-00060u-M2
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=mX0Nnf0lDRk2OYH8/tWIOZoLrV38hAVNYeqF10JWYVc=;
 b=DQU27jZWp2R8bleiriEgZU3KtRlBD9dlyJC94ed2PstuW9tgOnivr+TE4EZ9OZJmS5HwxB
 6KxZWQnbxcLBN/YU3ZHzFqgjWTALHdFcSlJ+cMq1FWNEwsSvq9t1V563iBw3jM9yzgdWUq
 qNAyAfi91tmeNSeHqPL1hZpk83pAg/U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-NOF4NzrSOu6L1OhXMQ7Tcg-1; Wed, 14 May 2025 07:50:20 -0400
X-MC-Unique: NOF4NzrSOu6L1OhXMQ7Tcg-1
X-Mimecast-MFC-AGG-ID: NOF4NzrSOu6L1OhXMQ7Tcg_1747223419
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-442dc702850so27685075e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223419; x=1747828219;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mX0Nnf0lDRk2OYH8/tWIOZoLrV38hAVNYeqF10JWYVc=;
 b=S5POTBIxSn/nX+JU63vj3+/F9fgB++X3O8r5YM26pQxuqGYPaNWtYK7SfGZJD139qV
 EjFFOWQ+Ba6IgtGGJxQL2FoiiApm7O1XReen55AETXaOQibnjcJaB6flY4AWqb0E1rRp
 YlKWckFNL98I7uxEaJB1Q9WmuO2dlzKKRZ0V8YbbIjGsMtdsO1ALkzvgLSscqiF+K8fO
 UeG1pm25fHN5Fmq31GVPD1gGI+EhbzSu8zPAdS0DwZDwHefLncZB15HDfj3r97u8+4J5
 xyATXGPwQ/+NlmjP4TcAvQ7hzF6Sh41rFV6KRhlC1g+jTR9WNhWc3h+XO+IzyIxJVu9Q
 SbzA==
X-Gm-Message-State: AOJu0YzyG6fP6tva5Ew0Mcyrg7IgysVL/9JOJ8FztFC2ifXJS/xn2iqZ
 ntN8cRrdxJMY0s8dSXC/MPbYy0DEeC+WQRWu9tPOZEISxO8sAzrLO4+Ij738mipqh1QWuj/coXP
 kh6wWTFBDJrzL9Yc8rTMZC2heXAVVoveXaX1nPWQcESPEQh50PiULdUd3Zbf4jw1a/kzSWfDsNS
 P6l06r31GBtonQSGe0y1zimQQJzlcSdg==
X-Gm-Gg: ASbGncvdUnVzfbwxaPy8XdzjGSlC6XDwUIFeejet+xBPaesXVBk+/bVby5tgoZCtahz
 uEao6uJWP1ieYfHccQ0nKvMzc2wbHif2E+cyy67s4p8IjxWVZB7UB8y9Uo3G+Yc2Jeb5LPiJj9Y
 V4Y+taidG2KPlMn4xeLlnGlGHkLEDf/RlaSmk3Md5rz6BknihvncSXw8LOZZ21b0bdBGuXNaaJ4
 CVgVnoHYyvzDEXDhDs12jwryT8+JmhJsp6M5by2sFVvq12ZD6DwPlJBbt3URDFhuJ2S5i/NRr7l
 XPZqBQ==
X-Received: by 2002:a05:600c:1c88:b0:43c:e70d:44f0 with SMTP id
 5b1f17b1804b1-442f210d5d0mr27757765e9.19.1747223418755; 
 Wed, 14 May 2025 04:50:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwj8vtAu1ZFVVfzI6t6nFdu5XWT1NJ8Zif7m1GG922Qjp2Z3DgAlnb7RWU2E6TdvOJd0tUlA==
X-Received: by 2002:a05:600c:1c88:b0:43c:e70d:44f0 with SMTP id
 5b1f17b1804b1-442f210d5d0mr27757405e9.19.1747223418255; 
 Wed, 14 May 2025 04:50:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f395150bsm27953455e9.20.2025.05.14.04.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:50:17 -0700 (PDT)
Date: Wed, 14 May 2025 07:50:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/27] virtio,pci,pc: fixes, features
Message-ID: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 7be29f2f1a3f5b037d27eedbd5df9f441e8c8c16:

  Merge tag 'pull-vfio-20250509' of https://github.com/legoater/qemu into staging (2025-05-09 12:04:35 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 28931c2e1591deb4bfaaf744fdc8813e96c230f1:

  hw/i386/amd_iommu: Allow migration when explicitly create the AMDVI-PCI device (2025-05-14 07:45:58 -0400)

----------------------------------------------------------------
virtio,pci,pc: fixes, features

vhost-scsi now supports scsi hotplug
cxl gained a bag of new operations, motably media operations
virtio-net now supports SR-IOV emulation
pci-testdev now supports backing memory bar with host memory
amd iommu now supports migration

fixes all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (11):
      hw/pci: Do not add ROM BAR for SR-IOV VF
      hw/pci: Fix SR-IOV VF number calculation
      pcie_sriov: Ensure PF and VF are mutually exclusive
      pcie_sriov: Check PCI Express for SR-IOV PF
      pcie_sriov: Allow user to create SR-IOV device
      virtio-pci: Implement SR-IOV PF
      virtio-net: Implement SR-IOV VF
      docs: Document composable SR-IOV device
      pcie_sriov: Make a PCI device with user-created VF ARI-capable
      virtio: Call set_features during reset
      virtio: Move virtio_reset()

CLEMENT MATHIEU--DRIF (2):
      intel_iommu: Use BQL_LOCK_GUARD to manage cleanup automatically
      intel_iommu: Take locks when looking for and creating address spaces

Davidlohr Bueso (2):
      hw/cxl: Support aborting background commands
      hw/cxl: Support get/set mctp response payload size

Dongli Zhang (1):
      vhost-scsi: support VIRTIO_SCSI_F_HOTPLUG

Haoqian He (3):
      system/runstate: add VM state change cb with return value
      vhost: return failure if stop virtqueue failed in vhost_dev_stop
      vhost-user: return failure if backend crash when live migration

Stephen Bates (1):
      pci-testdev.c: Add membar-backed option for backing membar

Suravee Suthikulpanit (2):
      hw/i386/amd_iommu: Isolate AMDVI-PCI from amd-iommu device to allow full control over the PCI device creation
      hw/i386/amd_iommu: Allow migration when explicitly create the AMDVI-PCI device

Sweta Kumari (1):
      hw/cxl/cxl-mailbox-utils: CXL CCI Get/Set alert config commands

Vinayak Holikatti (3):
      hw/cxl/cxl-mailbox-utils: Add support for Media operations discovery commands cxl r3.2 (8.2.10.9.5.3)
      hw/cxl: factor out calculation of sanitize duration from cmd_santize_overwrite
      hw/cxl/cxl-mailbox-utils: Media operations Sanitize and Write Zeros commands CXL r3.2(8.2.10.9.5.3)

Yuquan Wang (1):
      docs/cxl: Add serial number for persistent-memdev

 hw/i386/amd_iommu.h                    |   5 +-
 include/hw/cxl/cxl_device.h            |  23 ++
 include/hw/cxl/cxl_mailbox.h           |   1 +
 include/hw/pci/pci_device.h            |   6 +-
 include/hw/pci/pcie_sriov.h            |  21 ++
 include/hw/virtio/vhost-scsi-common.h  |   2 +-
 include/hw/virtio/vhost-vsock-common.h |   2 +-
 include/hw/virtio/vhost.h              |   8 +-
 include/hw/virtio/virtio-pci.h         |   1 +
 include/hw/virtio/virtio.h             |   2 +-
 include/system/runstate.h              |  13 +-
 include/system/vhost-user-backend.h    |   2 +-
 backends/vhost-user.c                  |  20 +-
 hw/block/vhost-user-blk.c              |  27 +-
 hw/block/virtio-blk.c                  |   7 +-
 hw/char/virtio-serial-bus.c            |   3 +-
 hw/core/vm-change-state-handler.c      |  18 +-
 hw/cxl/cxl-device-utils.c              |  14 +-
 hw/cxl/cxl-mailbox-utils.c             | 623 +++++++++++++++++++++++++++++++--
 hw/display/vhost-user-gpu.c            |  12 +-
 hw/i386/acpi-build.c                   |   8 +-
 hw/i386/amd_iommu.c                    | 101 ++++--
 hw/i386/intel_iommu.c                  |  35 +-
 hw/input/virtio-input.c                |   3 +-
 hw/mem/cxl_type3.c                     |  22 +-
 hw/misc/pci-testdev.c                  |  12 +-
 hw/net/virtio-net.c                    |   3 +-
 hw/pci/pci.c                           |  76 ++--
 hw/pci/pcie_sriov.c                    | 304 +++++++++++++---
 hw/scsi/scsi-bus.c                     |   2 +-
 hw/scsi/vhost-scsi-common.c            |  13 +-
 hw/scsi/vhost-scsi.c                   |   8 +-
 hw/scsi/vhost-user-scsi.c              |  18 +-
 hw/vfio/migration.c                    |   2 +-
 hw/virtio/vdpa-dev.c                   |   5 +-
 hw/virtio/vhost-user-base.c            |  23 +-
 hw/virtio/vhost-user-fs.c              |  23 +-
 hw/virtio/vhost-user-scmi.c            |  27 +-
 hw/virtio/vhost-user-vsock.c           |  15 +-
 hw/virtio/vhost-vsock-common.c         |  12 +-
 hw/virtio/vhost-vsock.c                |  11 +-
 hw/virtio/vhost.c                      |  23 +-
 hw/virtio/virtio-balloon.c             |   3 +-
 hw/virtio/virtio-crypto.c              |   3 +-
 hw/virtio/virtio-iommu.c               |   3 +-
 hw/virtio/virtio-net-pci.c             |   1 +
 hw/virtio/virtio-pci.c                 |  24 +-
 hw/virtio/virtio-rng.c                 |   5 +-
 hw/virtio/virtio.c                     | 108 +++---
 system/cpus.c                          |   8 +-
 system/runstate.c                      |  35 +-
 MAINTAINERS                            |   1 +
 docs/system/devices/cxl.rst            |  18 +-
 docs/system/index.rst                  |   1 +
 docs/system/sriov.rst                  |  37 ++
 55 files changed, 1442 insertions(+), 361 deletions(-)
 create mode 100644 docs/system/sriov.rst


