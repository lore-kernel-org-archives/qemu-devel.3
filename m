Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C36CC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS3E-0004PK-RZ; Fri, 21 Feb 2025 07:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS39-0004Ou-Ms
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:22:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS37-0006yi-Lp
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OX+0VDZt+7Si5uzy6Q/j53hodSniUvH8WhlfBlxLdJM=;
 b=QvFbbTQGHe5WOoImYCSplgypeGW8+ZBwfQll5GFWwsQU4pBxMdLWyp8p74mkSPJuM88OdU
 XP2WJAa+7HOG0pFA3VaXkex4Gic8f3wmxjOYaP97OOYxODRkG4DzigjWV0DjYJbskoofOT
 Msp7tZ8u8RXtilMhAuXjUq3HeH45d10=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-RlU6xmV8MtOuXoBRuEWEoA-1; Fri, 21 Feb 2025 07:22:30 -0500
X-MC-Unique: RlU6xmV8MtOuXoBRuEWEoA-1
X-Mimecast-MFC-AGG-ID: RlU6xmV8MtOuXoBRuEWEoA_1740140549
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43945f32e2dso18588225e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:22:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140548; x=1740745348;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OX+0VDZt+7Si5uzy6Q/j53hodSniUvH8WhlfBlxLdJM=;
 b=TiXnUQp2JjUImZft/uKuKbBJVI67UwJUFnPy9K0YiuVXBNpa4wQrAk0Mm2sZ9ffubC
 qeZ8ZP/HmPvCQJtVWey/bT36acSZePUUmZ3Nh0wrueKXgk5nh91SRG+S9qlAV30PIJuL
 DgXvvZuCVxJHrR88vKA8OQ+g1ujoNBcwWplWn3ZUK2A9D4mokU5N5iVu3zz4t1Gab5pb
 Dmd5GfEnyd533AL5GAabPwIsiwx5ETqo0Oc+nAwK23AUaOYcFGvn2rJV2nscvcLd5Ppl
 mfOok20Z+xudoJRjLxBNFS2NKSPThcNAVy9MMLsIAz+wIeRcEiKHFCXs2If5m4ggrVz0
 fBBg==
X-Gm-Message-State: AOJu0YxWrnXI0jKkBGZUeGvBO6fFdpB8Vuv4UksM5GAXVfbOLwfRMROk
 edrii69HCKjOhdqmYAseqZieQwbsrx5L8az19RxNkOyPkoWTY4oGyJQeQj57/TB1D+ROarcDx71
 rS/+277ijRcPSdPz+yWLr2JY0oHARZYPW8LHzlkhHXohtU+ugyR83rfKMvYS0FZeAsjLXZgL8v1
 PRYMMh7DY7Nn7ouvD1NXcX6mvP0yV+ww==
X-Gm-Gg: ASbGncsZB/RCXGfshnJ1oUTQCbdv+jNEq3yno6A4qIH4LTwmXoXcJwrZ+UMmJyJTWkq
 OTYeVDL0fOOzCdnrc/asQMR43DUvZrNsXLOShb8gRWMzTlNEQN0woojhzqZdhYVloYOScgzWa1E
 cnIsGsPoVcIs6mOy9cPRCDRr0vjhuFAfOu6EAtr+VfohMoI3Cgifx9pmfz3j0FrwTkRJDov8aW/
 nxtJLK4p8szz0hruFZ/9WYHakQdqiBwrW5tzg2xU57+LvY8/3kxg2VWYEd5hSaBIoNHckO4Tjqe
 PigopQ==
X-Received: by 2002:a05:600c:46c9:b0:439:93d2:72b4 with SMTP id
 5b1f17b1804b1-439ae1f159fmr34197775e9.16.1740140548192; 
 Fri, 21 Feb 2025 04:22:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlDOYXEsGHcE63Lf93Zi72b9FERKuBdC7b5FGGUemVa0khe17dlUdiueMXzfAt9iyLGFWynw==
X-Received: by 2002:a05:600c:46c9:b0:439:93d2:72b4 with SMTP id
 5b1f17b1804b1-439ae1f159fmr34197225e9.16.1740140547567; 
 Fri, 21 Feb 2025 04:22:27 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258f5fabsm22968492f8f.45.2025.02.21.04.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:22:26 -0800 (PST)
Date: Fri, 21 Feb 2025 07:22:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/41] virtio,pc,pci: features, fixes, cleanups
Message-ID: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

The following changes since commit 4d5d933bbc7cc52f6cc6b9021f91fa06266222d5:

  Merge tag 'pull-xenfv-20250116' of git://git.infradead.org/users/dwmw2/qemu into staging (2025-01-16 09:03:43 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to dd6d545e8f2d9a0e8a8c287ec16469f03ef5c198:

  docs/devel/reset: Document reset expectations for DMA and IOMMU (2025-02-21 07:21:25 -0500)

----------------------------------------------------------------
virtio,pc,pci: features, fixes, cleanups

Features:

SR-IOV emulation for pci
virtio-mem-pci support for s390
interleave support for cxl
big endian support for vdpa svq
new QAPI events for vhost-user

Also vIOMMU reset order fixups are in.
Fixes, cleanups all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (12):
      hw/net: Fix NULL dereference with software RSS
      hw/ppc/spapr_pci: Do not create DT for disabled PCI device
      hw/ppc/spapr_pci: Do not reject VFs created after a PF
      s390x/pci: Avoid creating zpci for VFs
      s390x/pci: Allow plugging SR-IOV devices
      s390x/pci: Check for multifunction after device realization
      pcie_sriov: Do not manually unrealize
      pcie_sriov: Ensure VF addr does not overflow
      pcie_sriov: Reuse SR-IOV VF device instances
      pcie_sriov: Release VFs failed to realize
      pcie_sriov: Remove num_vfs from PCIESriovPF
      pcie_sriov: Register VFs after migration

Alexander Graf (1):
      hw/virtio/virtio-nsm: Respond with correct length

Daniel P. Berrangé (1):
      hw/virtio: reset virtio balloon stats on machine reset

Eric Auger (5):
      hw/virtio/virtio-iommu: Migrate to 3-phase reset
      hw/i386/intel-iommu: Migrate to 3-phase reset
      hw/arm/smmuv3: Move reset to exit phase
      hw/vfio/common: Add a trace point in vfio_reset_handler
      docs/devel/reset: Document reset expectations for DMA and IOMMU

Jonah Palmer (3):
      vhost-iova-tree: Implement an IOVA-only tree
      vhost-iova-tree, svq: Implement GPA->IOVA & partial IOVA->HVA trees
      vhost-iova-tree: Update documentation

Konstantin Shkolnyy (1):
      vdpa: Fix endian bugs in shadow virtqueue

Laurent Vivier (1):
      net: vhost-user: add QAPI events to report connection state

Li Zhijian (4):
      hw/cxl: Introduce CXL_T3_MSIX_VECTOR enumeration
      hw/mem/cxl_type3: Add paired msix_uninit_exclusive_bar() call
      hw/mem/cxl_type3: Fix special_ops memory leak on msix_init_exclusive_bar() failure
      hw/mem/cxl_type3: Ensure errp is set on realization failure

Matias Ezequiel Vara Larsen (1):
      vhost-user-snd: correct the calculation of config_size

Nicholas Piggin (3):
      qtest/libqos/pci: Do not write to PBA memory
      hw/pci/msix: Warn on PBA writes
      hw/pci: Assert a bar is not registered multiple times

Sairaj Kodilkar (2):
      amd_iommu: Use correct DTE field for interrupt passthrough
      amd_iommu: Use correct bitmask to set capability BAR

Stefano Garzarella (2):
      cryptodev/vhost: allocate CryptoDevBackendVhost using g_mem0()
      MAINTAINERS: add more files to `vhost`

Thomas Huth (4):
      docs/about: Change notes on x86 machine type deprecation into a general one
      hw/i386/pc: Fix crash that occurs when introspecting TYPE_PC_MACHINE machines
      hw/i386/microvm: Fix crash that occurs when introspecting the microvm machine
      tests/qtest/vhost-user-test: Use modern virtio for vhost-user tests

Yao Xingtao (1):
      mem/cxl_type3: support 3, 6, 12 and 16 interleave ways

 docs/pcie_sriov.txt                     |   8 +-
 qapi/net.json                           |  40 ++++++++
 hw/i386/amd_iommu.h                     |   2 +-
 hw/virtio/vhost-iova-tree.h             |   8 +-
 hw/virtio/vhost-shadow-virtqueue.h      |   5 +-
 include/hw/cxl/cxl_device.h             |   4 +-
 include/hw/pci/pcie_sriov.h             |   9 +-
 include/hw/virtio/virtio-balloon.h      |   4 +
 include/qemu/iova-tree.h                |  22 +++++
 backends/cryptodev-vhost.c              |   2 +-
 hw/arm/smmu-common.c                    |   9 +-
 hw/arm/smmuv3.c                         |  14 ++-
 hw/cxl/cxl-component-utils.c            |   9 +-
 hw/cxl/cxl-device-utils.c               |  12 +--
 hw/cxl/switch-mailbox-cci.c             |   4 +-
 hw/i386/amd_iommu.c                     |  10 +-
 hw/i386/intel_iommu.c                   |  12 ++-
 hw/i386/microvm.c                       |  66 ++++++-------
 hw/i386/pc.c                            |   6 +-
 hw/mem/cxl_type3.c                      |  45 ++++++---
 hw/net/igb.c                            |  10 +-
 hw/net/virtio-net.c                     |  45 ++++-----
 hw/nvme/ctrl.c                          |  22 +++--
 hw/pci/msix.c                           |   9 ++
 hw/pci/pci.c                            |  22 ++++-
 hw/pci/pcie_sriov.c                     | 159 +++++++++++++++++--------------
 hw/ppc/spapr_pci.c                      |  20 +++-
 hw/s390x/s390-pci-bus.c                 |  42 +++++++--
 hw/vfio/common.c                        |   1 +
 hw/virtio/vhost-iova-tree.c             | 115 +++++++++++++++++++----
 hw/virtio/vhost-shadow-virtqueue.c      |  73 ++++++++++-----
 hw/virtio/vhost-user-snd.c              |  18 +++-
 hw/virtio/vhost-vdpa.c                  |  40 +++++---
 hw/virtio/virtio-balloon.c              |  30 +++++-
 hw/virtio/virtio-iommu.c                |  14 ++-
 hw/virtio/virtio-nsm.c                  |   2 +-
 net/vhost-user.c                        |   3 +
 net/vhost-vdpa.c                        |  12 ++-
 tests/qtest/libqos/pci.c                |   2 -
 tests/qtest/vhost-user-test.c           |   3 +-
 util/iova-tree.c                        |  46 +++++++++
 MAINTAINERS                             |  11 ++-
 docs/about/deprecated.rst               |   7 --
 docs/about/removed-features.rst         |  11 +--
 docs/devel/reset.rst                    |   5 +
 hw/arm/trace-events                     |   1 +
 hw/i386/trace-events                    |   1 +
 hw/pci/trace-events                     |   2 +-
 hw/vfio/trace-events                    |   1 +
 hw/virtio/trace-events                  |   2 +-
 tests/functional/meson.build            |   2 +
 tests/functional/test_virtio_balloon.py | 161 ++++++++++++++++++++++++++++++++
 52 files changed, 882 insertions(+), 301 deletions(-)
 create mode 100755 tests/functional/test_virtio_balloon.py


