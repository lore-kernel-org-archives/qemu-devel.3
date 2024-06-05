Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC93C27C5E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF09c-0002oI-Cy; Wed, 05 Jun 2024 19:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF09a-0002nx-Jf
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF09Y-0004lF-J5
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717630486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9FT0efaYSrBLlFjmrniKct7+AXD36CTynTe6pFVstwI=;
 b=i+uHoqwl90fqNnxyCz54Z0hGQlFfcCKam75RCzhoUzIRV2jlOSCg54feWVTpGeboFKvX2a
 rPKcdqtoEbZPSEgXnV35E+fThPFyZbrkf/h+HDKX8aLMYnJYEIH9KQ4RZ1tK2KaOBgezTT
 0a8CcWIHEaXOkbSCjqS1Jv0pOQYbU3Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-Fd5plBB1MfyMibT6hXVyBg-1; Wed, 05 Jun 2024 19:34:45 -0400
X-MC-Unique: Fd5plBB1MfyMibT6hXVyBg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a68ee264225so11185566b.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630483; x=1718235283;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9FT0efaYSrBLlFjmrniKct7+AXD36CTynTe6pFVstwI=;
 b=Pz0JT3CxZYS0HAmQGbdXdCo6e5ORwCcWeE3jDBDjo/npvKOu7agxXMaz0A6GNP7CII
 W40dzkYiNLNMaeOaQ6M8m7fMgJUEMUMsJLeakIZsPV/OjrYU8q0sInAMnqsHu4F2tWPf
 M3nLQPtpYJE0pJqE027ihwYAU+3LRBBKdsxbVtHbuc/SDAN5A1GFJVPIvI3hBEYalkQd
 gBkaKypcx4vZHTRNhekZ5WWcU3qiopEyibgEG0roCcVMT6ln/yrc8CJdZbbfbh6GtL5A
 Ba6X2TBtH2ho3ruFdqkBix9GGbEGrK3834FaznXzucUvKs3rFRGzSsS3r+Cws68HKkG7
 9cwg==
X-Gm-Message-State: AOJu0YxVRt2HdaHVDncbEJ0gTQnQ8TC2TuUQhAAc1YnzJs+ypggXybep
 CEQRAJS4Ho9VZAdGOBaBCLkhPVSR58jpHqBqoDQPjyyrjQfa16j1PeuK1QqDSRScevsEHz4d6ye
 /5zCos34Yp6udwTz1/KqSZcNP/9lresh3d5h2YYK4EEMd/V6uMk15XrSOLTP4GAaJweFV7Ldehe
 DaXsmTLeA980uKhjuhInXb7N2yh6iJNg==
X-Received: by 2002:a17:906:a457:b0:a59:b590:5d71 with SMTP id
 a640c23a62f3a-a699e9b1215mr232042666b.0.1717630483349; 
 Wed, 05 Jun 2024 16:34:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqZE7ECFsjR9+eQcIq2mRaBwbiX+MCKAuZLJsoetcJ2w3i+NMT3vBYow7KznvbPllWGdfuIQ==
X-Received: by 2002:a17:906:a457:b0:a59:b590:5d71 with SMTP id
 a640c23a62f3a-a699e9b1215mr232041466b.0.1717630482724; 
 Wed, 05 Jun 2024 16:34:42 -0700 (PDT)
Received: from redhat.com ([2.55.56.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c802e62a5sm7997966b.0.2024.06.05.16.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:34:41 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:34:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v3 00/41] virtio: features,fixes
Message-ID: <cover.1717630437.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Dropped acpi patches that had endian-ness issues.

The following changes since commit 60b54b67c63d8f076152e0f7dccf39854dfc6a77:

  Merge tag 'pull-lu-20240526' of https://gitlab.com/rth7680/qemu into staging (2024-05-26 17:51:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to d23bc95d390a1800198c92a0177240d9e1a1eb66:

  hw/cxl: Fix read from bogus memory (2024-06-05 19:33:01 -0400)

----------------------------------------------------------------
virtio: features,fixes

A bunch of improvements:
- vhost dirty log is now only scanned once, not once per device
- virtio and vhost now support VIRTIO_F_NOTIFICATION_DATA
- cxl gained DCD emulation support
- pvpanic gained shutdown support
- beginning of patchset for Generic Port Affinity Structure
- new tests
- bugfixes

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alejandro Jimenez (1):
      pvpanic: Emit GUEST_PVSHUTDOWN QMP event on pvpanic shutdown signal

Christian Pötzsch (1):
      Fix vhost user assertion when sending more than one fd

Cindy Lu (1):
      virtio-pci: Fix the failure process in kvm_virtio_pci_vector_use_one()

Fan Ni (12):
      hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output payload of identify memory device command
      hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative and mailbox command support
      include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for type3 memory devices
      hw/mem/cxl_type3: Add support to create DC regions to type3 memory devices
      hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr size instead of mr as argument
      hw/mem/cxl_type3: Add host backend and address space handling for DC regions
      hw/mem/cxl_type3: Add DC extent list representative and get DC extent list mailbox support
      hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release dynamic capacity response
      hw/cxl/events: Add qmp interfaces to add/release dynamic capacity extents
      hw/mem/cxl_type3: Add DPA range validation for accesses to DC regions
      hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox support
      hw/mem/cxl_type3: Allow to release extent superset in QMP interface

Gregory Price (2):
      hw/cxl/mailbox: change CCI cmd set structure to be a member, not a reference
      hw/cxl/mailbox: interface to add CCI commands to an existing CCI

Halil Pasic (1):
      vhost-vsock: add VIRTIO_F_RING_PACKED to feature_bits

Ira Weiny (1):
      hw/cxl: Fix read from bogus memory

Jiqian Chen (1):
      virtio-pci: only reset pm state during resetting

Jonah Palmer (5):
      virtio/virtio-pci: Handle extra notification data
      virtio: Prevent creation of device using notification-data with ioeventfd
      virtio-mmio: Handle extra notification data
      virtio-ccw: Handle extra notification data
      vhost/vhost-user: Add VIRTIO_F_NOTIFICATION_DATA to vhost feature bits

Jonathan Cameron (2):
      hw/acpi/GI: Fix trivial parameter alignment issue.
      hw/acpi: Insert an acpi-generic-node base under acpi-generic-initiator

Li Feng (2):
      Revert "vhost-user: fix lost reconnect"
      vhost-user: fix lost reconnect again

Marc-André Lureau (1):
      vhost-user-gpu: fix import of DMABUF

Si-Wei Liu (2):
      vhost: dirty log should be per backend type
      vhost: Perform memory section dirty scans once per iteration

Stefano Garzarella (1):
      vhost-vdpa: check vhost_vdpa_set_vring_ready() return value

Thomas Weißschuh (7):
      scripts/update-linux-headers: Copy setup_data.h to correct directory
      linux-headers: update to 6.10-rc1
      hw/misc/pvpanic: centralize definition of supported events
      tests/qtest/pvpanic: use centralized definition of supported events
      hw/misc/pvpanic: add support for normal shutdowns
      tests/qtest/pvpanic: add tests for pvshutdown event
      Revert "docs/specs/pvpanic: mark shutdown event as not implemented"

Wafer (1):
      hw/virtio: Fix obtain the buffer id from the last descriptor

 qapi/cxl.json                               | 143 ++++++
 qapi/run-state.json                         |  14 +
 include/hw/acpi/acpi_generic_initiator.h    |  15 +-
 include/hw/cxl/cxl_device.h                 |  85 +++-
 include/hw/cxl/cxl_events.h                 |  18 +
 include/hw/misc/pvpanic.h                   |   6 +
 include/hw/virtio/vhost-user.h              |   3 +-
 include/hw/virtio/vhost.h                   |   1 +
 include/hw/virtio/virtio.h                  |   2 +
 include/standard-headers/linux/ethtool.h    |  55 +++
 include/standard-headers/linux/pci_regs.h   |   6 +
 include/standard-headers/linux/pvpanic.h    |   7 +-
 include/standard-headers/linux/virtio_bt.h  |   1 -
 include/standard-headers/linux/virtio_mem.h |   2 +
 include/standard-headers/linux/virtio_net.h | 143 ++++++
 include/sysemu/runstate.h                   |   1 +
 linux-headers/asm-generic/unistd.h          |   5 +-
 linux-headers/asm-loongarch/kvm.h           |   4 +
 linux-headers/asm-mips/unistd_n32.h         |   1 +
 linux-headers/asm-mips/unistd_n64.h         |   1 +
 linux-headers/asm-mips/unistd_o32.h         |   1 +
 linux-headers/asm-powerpc/unistd_32.h       |   1 +
 linux-headers/asm-powerpc/unistd_64.h       |   1 +
 linux-headers/asm-riscv/kvm.h               |   1 +
 linux-headers/asm-s390/unistd_32.h          |   1 +
 linux-headers/asm-s390/unistd_64.h          |   1 +
 linux-headers/asm-x86/kvm.h                 |   4 +-
 linux-headers/asm-x86/unistd_32.h           |   1 +
 linux-headers/asm-x86/unistd_64.h           |   1 +
 linux-headers/asm-x86/unistd_x32.h          |   2 +
 linux-headers/linux/kvm.h                   |   4 +-
 linux-headers/linux/stddef.h                |   8 +
 linux-headers/linux/vhost.h                 |  15 +-
 hw/acpi/acpi_generic_initiator.c            |  82 ++--
 hw/block/vhost-user-blk.c                   |   6 +-
 hw/cxl/cxl-mailbox-utils.c                  | 658 +++++++++++++++++++++++++++-
 hw/display/vhost-user-gpu.c                 |   5 +-
 hw/mem/cxl_type3.c                          | 637 +++++++++++++++++++++++++--
 hw/mem/cxl_type3_stubs.c                    |  25 ++
 hw/misc/pvpanic-isa.c                       |   3 +-
 hw/misc/pvpanic-pci.c                       |   3 +-
 hw/misc/pvpanic.c                           |   8 +-
 hw/net/vhost_net.c                          |   2 +
 hw/s390x/s390-virtio-ccw.c                  |  17 +-
 hw/scsi/vhost-scsi.c                        |   1 +
 hw/scsi/vhost-user-scsi.c                   |   7 +-
 hw/virtio/vhost-user-base.c                 |   5 +-
 hw/virtio/vhost-user-fs.c                   |   2 +-
 hw/virtio/vhost-user-vsock.c                |   1 +
 hw/virtio/vhost-user.c                      |  18 +-
 hw/virtio/vhost-vsock-common.c              |   1 +
 hw/virtio/vhost.c                           | 112 ++++-
 hw/virtio/virtio-mmio.c                     |  11 +-
 hw/virtio/virtio-pci.c                      |  38 +-
 hw/virtio/virtio.c                          |  45 ++
 net/vhost-vdpa.c                            |  16 +-
 subprojects/libvhost-user/libvhost-user.c   |   2 +-
 system/runstate.c                           |   6 +
 tests/qtest/pvpanic-pci-test.c              |  44 +-
 tests/qtest/pvpanic-test.c                  |  34 +-
 docs/specs/pvpanic.rst                      |   2 +-
 scripts/update-linux-headers.sh             |   2 +-
 62 files changed, 2159 insertions(+), 188 deletions(-)


