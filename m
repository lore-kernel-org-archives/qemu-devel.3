Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE13606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SoFRY/1b;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=srN62dZh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7EG-0004sB-DR; Wed, 28 Oct 2026 13:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Du-0004oC-Fd
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Ds-0003QY-1X
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=p8CQwOMwHTHaoxIZ9YhrXqTBJwfDSs2V0IMctXJljyc=;
 b=SoFRY/1bM7SbvflULsBCph1wtxKqv6etc98PHmPzffXpsdeRhQX8jDLsob0TkApJotZqFT
 eoCOZpRjGF3O7+Awn5TyxkXMW6W9jndD+Typ9VZi04bhUa5t30U9BJl1emsFmN4MRytQRt
 YyeaPq2s488+tNh0VsaX9cLHsYda1WI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-2qVBRdeeNPipu7R64kUS7w-1; Wed, 28 Oct 2026 13:13:57 -0400
X-MC-Unique: 2qVBRdeeNPipu7R64kUS7w-1
X-Mimecast-MFC-AGG-ID: 2qVBRdeeNPipu7R64kUS7w_1793207637
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a1d1f26a63so10962515e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207636; x=1793812436; darn=nongnu.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p8CQwOMwHTHaoxIZ9YhrXqTBJwfDSs2V0IMctXJljyc=;
 b=srN62dZh6CpQTEA72wj13AqiuBGlCtg1GkkoOrUfl63l9LnrYG1u8HocjHHa7FZGV1
 nAFmry6ry3YsNpHCpC9TZOcRJz4SwOAvodo+VbIenG+wIYeJ//YtHoHqPmrMKKw/IlQW
 9hvRmTYZz+sCZS0oxSiDAsyMPYVIHCF1uIVTUs6HKT3tGpBf8iSS2HIFCUYF7Q1QcmQJ
 bkfJ3QCfSnleJobum0kQUMzzyrpTlC3YcpVhcmHd6u4c1jmsDxBI/HDbk5ijJ0RJInS1
 9S56k3SlYlqH/zQHdikuee8RwfcWQUvEBZGj8utLCnEkJSW92vVOkwvWY+NaNFqmI4eK
 TgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207636; x=1793812436;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p8CQwOMwHTHaoxIZ9YhrXqTBJwfDSs2V0IMctXJljyc=;
 b=eRD7C/Z8QuQpAwu3AaXPdVmIFc7xAd13c+1HwfS4HMJTwT6xWdwpPk2o5g6sIYQWhU
 L4DDCkuTNdQ7g9p2YkTRqzlZCH5cY8H6uzX12tMwa6ncAg7NkiEVUzqCbQyzebBQrQGZ
 t8yMQGjAgf3tP1I+jLv+9LP/kfcoMAF+9JDDsE4McmCGogx3WTsltm3PNcOAuBqVWTIv
 T/kgd7yJuVMUNbg2mC6b2wU4EB1/k1XnKninEddjVZP3cTl662fJVfMtdrfB1m/IK7rw
 ilHOegry8ErlHEcDW1/UHS9hYbkkrrw5KS1j+KGjYnd4up/F1ebyEfqchvL7fIk+OM9j
 afOg==
X-Gm-Message-State: AFq9FYLeG0I6OhVqXCKU/+PTZYecFr0nIacxY9lLCJ2L8D7lm2lOMQEL
 vXlhH9R4b022Uj3tmEa3KW2zvXqymCxYa6A8ltVbx4oGpkTzyPK3i4FYDyYSfdtg4R3hER78MZD
 OsLNavRqVr9RUDNJQ8QvPYjcF5FfQ1MkDnBOlkC3krG635GF2YDLVkFSL8qI6i8Hm5J026jcmgh
 SVBzsf8IzE3KHwzZf3YbzyLUGp5HeAW1McoA==
X-Gm-Gg: AYBFou1aHKJrJas9B2bzMpy9gkHDJSIRJnuJrKN1a3Mokp2gOb1rAI2tLYgRatrMxpI
 ds0l9POCwtxztFefYWwJfyPhnM25Fi5i4JrD7GIXU+lj+gXKEYhMfH4OH8HkZ/sql3o2IHNaCLV
 DxKi+yvKpYi5dUtQ+LHIY8TkFPD5/2vLvioPsXI2vUXwU3tkeaIVHDluEtOZSn3lJfVAsWKwzOP
 rPhp9g6vva1H0+GiaIeYYMx60/ETuAMp/8NJKCwhaJma18w0ZKTaq93SckpehtCAvO7j9lfKB+c
 XgyLP04xfOO8HrjNVCpPwECEFdLJEsL/IeNfu1kN7EWWKa5DDn3dLJlAJwOUpg9Wn/Duumu962l
 z4WPGs54xcH1g9xeDMaCCWpIXVyjFLXUd7TRQlCeh
X-Received: by 2002:a05:600c:81c8:b0:4a1:cf60:dcc3 with SMTP id
 5b1f17b1804b1-4a9675dc5c4mr55287375e9.29.1793207636142; 
 Wed, 28 Oct 2026 10:13:56 -0700 (PDT)
X-Received: by 2002:a05:600c:81c8:b0:4a1:cf60:dcc3 with SMTP id
 5b1f17b1804b1-4a9675dc5c4mr55286305e9.29.1793207635436; 
 Wed, 28 Oct 2026 10:13:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd35c2sm28956034f8f.39.2026.10.28.10.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:13:54 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:13:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/78] pci, vhost, virtio, iommu, acpi: features, fixes
Message-ID: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-28.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 29b1dc631d6ac6bfc39464e0be8bf4cad556a591:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2026-10-27 20:02:57 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to c155e7e9e025b60ce17e26a7c382d86f3f9c9fee:

  virtio-net: add mtu-from-tap property for automatic MTU detection (2026-10-28 13:11:16 -0400)

----------------------------------------------------------------
pci, vhost, virtio, iommu, acpi: features, fixes

multiboot can again load 64 bit images
vdpa-dev now implements guest_notifier_mask/pending
pci bridge can now configure the negotiated bandwidth
tap can now auto-detect host mtu and expose to guest
amd iommu can now attach on non system bus
vhost-user spec now has its own mailing list

Fixes, cleanups all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alexander Mikhalitsyn (1):
      virtio-snd: don't use virtio_snd_pcm_get_stream() in virtio_snd_post_load()

Alexandr Moshkov (2):
      vhost-user: add missing stub for vhost_user_has_protocol_feature()
      vhost: move skip-drain feature check to vhost-user

Andrey Drobyshev (22):
      migration/cpr: forbid saving duplicate CprFds into hash table
      tests/unit: add test for duplicate keys in CPR FD table
      migration: forbid snapshots in CPR migration modes
      migration: forbid snapshots under Xen
      tests/qtest/migration: add test for snapshot rejection in CPR modes
      vhost-vsock: block CPR migration modes
      vhost: add vhost_reset_owner op
      vhost-vsock: don't reset connections during CPR
      vhost-vsock: fix FD leak in realize()
      vhost-vsock: preserve vhost FD during CPR
      vhost: factor out vhost_dev_init_backend()
      vhost: make vhost_dev_cleanup() safe on a partially initialized device
      vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
      vhost: add vhost_dev_is_initialized() helper
      vhost: release ownership in vhost_dev_cleanup()
      migration: add MIG_EVENT_INCOMING_FAILED
      vhost: release ownership when the incoming migration fails
      vhost: release ownership on exit
      vhost-vsock: hand off device ownership across CPR
      tests/qtest/migration: add vhost-vsock tests for cpr-transfer and cpr-exec
      tests/functional: add vhost-vsock CPR test with a live guest
      tests/functional: cover a cpr-transfer target going away with vhost-vsock

Connor Kite (1):
      hw/virtio/vhost-shadow-virtqueue: fix range boundary in SVQ translation

Daniel P. Berrangé (2):
      hw/arm: remove pci-bridge/pci_expander_bridge.h from virt.c
      hw/pci-bridge: split CXL PXB into separate file

Daniel Paziyski (1):
      pcie_sriov: register user created virtual function before realizing it

David Vrabel (4):
      hw/pci-bridge: Add generic PCIe switch upstream and downstream ports
      hw/pci-bridge: Make speed and width for PCIe ports non-experimental
      hw/pci-bridge: Default the generic PCIe root port as Gen6 capable
      hw/pci: Ensure PCIe link speed/width is consistent between both ends

Gavin Shan (1):
      hw/virtio/virtio-mem: Fix error message on invalid NUMA node

Junjie Cao (7):
      hw/cxl: destroy primary CCI before re-initialization on reset
      hw/cxl: convert cxl-type3 to three-phase reset
      hw/cxl: add cxl_destroy_mailbox_t3() as the mailbox teardown counterpart
      hw/cxl: discard in-flight sanitize state on mailbox teardown
      hw/cxl: clear event logs, scan media and interrupt policy on reset
      hw/cxl: clear poison lists and feature transfer state on reset
      MAINTAINERS: Update Junjie Cao's email address

Li RongQing (4):
      vhost: fix off-by-one in vhost_svq_next_desc with IN_ORDER
      pcie_sriov: fix wrong write width and off-by-one in pf_reset
      virtio-qmp: Fix out-of-bounds vqs index in vhost queue status
      pcie_aer: fix pci_set_long overflow into PCI_EXP_LNKCAP

Li Zhaoxin (1):
      vdpa-dev: implement guest_notifier_mask/pending

Michael S. Tsirkin (2):
      libvhost-user: protect against OOB memory table access
      vhost-user: fix SET_MEM_TABLE number of regions

Nariman Sayed (3):
      net/tap: add tap_fd_get_mtu() to query host tap MTU
      net: add generic get_mtu NetClientInfo callback
      virtio-net: add mtu-from-tap property for automatic MTU detection

Sairaj Kodilkar (8):
      amd_iommu: Assign ioapic_as only when interrupt remapping is supported.
      x86-iommu: Introduce x86_iommu_device_get() for x86-iommu retrieval
      amd_iommu: Add support for get_x86_iommu callback
      intel_iommu: Add support for get_x86_iommu callback
      i386/kvm: Use x86_iommu_device_get() for per-device IOMMU lookup
      amd_iommu: Introduce root bus
      acpi-build: Create PCI topology using amd iommu root bus
      amd_iommu: Allow IOMMU to attachment on non-system (pcie.0) bus

Samuel Thibault (1):
      Revert 9696846600ca ("multiboot: Prevent loading of x86_64 images")

Stefano Garzarella (1):
      vhost-user: add dedicated mailing list

Vladimir Sementsov-Ogievskiy (8):
      tests/functional: add test_tap_migration
      net/tap: tap_post_load(): poll only on success
      hw/net: finish backend initialization earler for local migration
      net/tap: move vmstate initialization to new_tap()
      net/tap: net_init_tap_one(): fix failure path
      qapi/virtio: Restore backend features in x-query-virtio-status
      qapi/monitor: Handle missing vhost-user protocol features
      util/event_notifier: more strict API

Yodel Eldar (2):
      contrib/vhost-user-bridge: Use stderr for debug output
      tests/functional/x86_64/test_vhost_user_bridge: Eliminate stdbuf usage

Yuho Choi (1):
      vhost-user: remove shared object entries during cleanup

Zhenzhong Duan (6):
      intel_iommu_accel: Guard VTDAccelPASIDCacheEntry definition
      backends/iommufd: Introduce iommufd_backend_alloc_faultq
      backends/iommufd: Extend iommufd_backend_alloc_hwpt() with fault_id
      intel_iommu_accel: Add PRQ injection for passthrough device
      intel_iommu_accel: Accept PRQ response for passthrough device
      intel_iommu_accel: Teardown FAULTQ resources in bottom half

 MAINTAINERS                                        |  14 +-
 docs/interop/vhost-user.rst                        |   8 +-
 docs/pcie.txt                                      |   6 +-
 docs/specs/pci-ids.rst                             |   4 +
 qapi/virtio.json                                   |   5 +-
 hw/i386/amd_iommu.h                                |   3 +
 hw/i386/intel_iommu_accel.h                        |  16 +-
 hw/i386/intel_iommu_internal.h                     |   3 +
 hw/pci-bridge/pci_expander_bridge_common.h         |  28 ++
 include/hw/cxl/cxl_device.h                        |   3 +
 include/hw/i386/intel_iommu.h                      |   6 +
 include/hw/i386/x86-iommu.h                        |   6 +
 ...expander_bridge.h => pci_expander_bridge_cxl.h} |   0
 include/hw/pci/pci.h                               |  14 +
 include/hw/vfio/vfio-cpr.h                         |   7 +-
 include/hw/virtio/vhost-backend.h                  |   2 +
 include/hw/virtio/vhost.h                          |  80 ++++
 include/hw/virtio/virtio-dmabuf.h                  |   8 +
 include/hw/virtio/virtio-net.h                     |   1 +
 include/migration/cpr.h                            |   2 +-
 include/migration/misc.h                           |   5 +
 include/net/net.h                                  |   3 +
 include/qemu/event_notifier.h                      |   1 +
 include/system/iommufd.h                           |   7 +-
 net/tap_int.h                                      |   1 +
 backends/hostmem-memfd.c                           |   5 +-
 backends/hostmem-shm.c                             |   5 +-
 backends/iommufd.c                                 |  32 +-
 contrib/vhost-user-bridge/vhost-user-bridge.c      |   2 +-
 hw/arm/smmuv3-accel.c                              |   6 +-
 hw/arm/virt.c                                      |   1 -
 hw/audio/virtio-snd.c                              |   3 +-
 hw/core/machine.c                                  |   1 +
 hw/cxl/cxl-host.c                                  |   2 +-
 hw/cxl/cxl-mailbox-utils.c                         |  22 +-
 hw/display/virtio-dmabuf.c                         |  18 +
 hw/i386/acpi-build.c                               | 152 ++++----
 hw/i386/amd_iommu.c                                |  75 +++-
 hw/i386/intel_iommu.c                              |  26 +-
 hw/i386/intel_iommu_accel.c                        | 309 ++++++++++++++-
 hw/i386/multiboot.c                                |   5 -
 hw/i386/x86-iommu-stub.c                           |   5 +
 hw/i386/x86-iommu.c                                |  16 +
 hw/intc/ioapic.c                                   |   3 +-
 hw/mem/cxl_type3.c                                 |  60 ++-
 hw/net/virtio-net.c                                |  50 +--
 hw/pci-bridge/gen_pcie_downstream_port.c           | 202 ++++++++++
 hw/pci-bridge/gen_pcie_root_port.c                 |   6 +-
 hw/pci-bridge/gen_pcie_upstream_port.c             | 177 +++++++++
 hw/pci-bridge/pci_expander_bridge.c                | 194 +---------
 hw/pci-bridge/pci_expander_bridge_cxl.c            | 201 ++++++++++
 hw/pci-bridge/pci_expander_bridge_stubs.c          |  14 -
 hw/pci/pci.c                                       |  42 +-
 hw/pci/pcie.c                                      |  26 +-
 hw/pci/pcie_aer.c                                  |   2 +-
 hw/pci/pcie_sriov.c                                |  16 +-
 hw/remote/iohub.c                                  |  11 +-
 hw/vfio/container-legacy.c                         |   7 +-
 hw/vfio/cpr-legacy.c                               |  31 +-
 hw/vfio/cpr.c                                      |   6 +-
 hw/vfio/iommufd.c                                  |   2 +-
 hw/vfio/pci.c                                      |   5 +-
 hw/virtio/vdpa-dev.c                               |  30 +-
 hw/virtio/vhost-kernel.c                           |   6 +
 hw/virtio/vhost-shadow-virtqueue.c                 |  44 ++-
 hw/virtio/vhost-user-stub.c                        |   5 +
 hw/virtio/vhost-user.c                             |   5 +-
 hw/virtio/vhost-vsock.c                            | 193 +++++++++-
 hw/virtio/vhost.c                                  | 141 ++++++-
 hw/virtio/virtio-hmp-cmds.c                        |   6 +-
 hw/virtio/virtio-mem.c                             |   2 +-
 hw/virtio/virtio-qmp.c                             |  21 +-
 migration/cpr.c                                    |  64 ++--
 migration/migration.c                              |  10 +
 migration/options.c                                |  13 +
 net/net.c                                          |   9 +
 net/tap-bsd.c                                      |   5 +
 net/tap-linux.c                                    |  30 ++
 net/tap-solaris.c                                  |   5 +
 net/tap-stub.c                                     |   5 +
 net/tap.c                                          |  19 +-
 subprojects/libvhost-user/libvhost-user.c          |   7 +
 system/physmem.c                                   |   5 +-
 target/i386/kvm/kvm.c                              |  15 +-
 tests/qtest/migration/cpr-tests.c                  | 133 ++++++-
 tests/unit/test-cpr.c                              |  98 +++++
 tests/unit/test-virtio-dmabuf.c                    |  43 +++
 util/event_notifier-posix.c                        |  10 +
 backends/trace-events                              |   3 +-
 hw/i386/trace-events                               |   2 +
 hw/pci-bridge/meson.build                          |   5 +-
 tests/functional/x86_64/meson.build                |   4 +
 tests/functional/x86_64/test_pcie_switch.py        |  98 +++++
 tests/functional/x86_64/test_tap_migration.py      | 425 +++++++++++++++++++++
 tests/functional/x86_64/test_vhost_user_bridge.py  |   6 -
 tests/functional/x86_64/test_vhost_vsock_cpr.py    | 347 +++++++++++++++++
 tests/unit/meson.build                             |   1 +
 97 files changed, 3256 insertions(+), 532 deletions(-)
 create mode 100644 hw/pci-bridge/pci_expander_bridge_common.h
 rename include/hw/pci-bridge/{pci_expander_bridge.h => pci_expander_bridge_cxl.h} (100%)
 create mode 100644 hw/pci-bridge/gen_pcie_downstream_port.c
 create mode 100644 hw/pci-bridge/gen_pcie_upstream_port.c
 create mode 100644 hw/pci-bridge/pci_expander_bridge_cxl.c
 delete mode 100644 hw/pci-bridge/pci_expander_bridge_stubs.c
 create mode 100644 tests/unit/test-cpr.c
 create mode 100755 tests/functional/x86_64/test_pcie_switch.py
 create mode 100755 tests/functional/x86_64/test_tap_migration.py
 create mode 100755 tests/functional/x86_64/test_vhost_vsock_cpr.py


