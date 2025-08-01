Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D448C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqns-0008ID-He; Fri, 01 Aug 2025 10:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqh5-0005Fv-LT
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqh2-0002ai-JZ
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754058305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=QuL0JTKEBhSFp/6lwOdYxS7QOmZe0a+bp9gretjYRbo=;
 b=WPH+Tk4fSCjJC8cssXO0ubVUL1MCC+yK3dHx0RZ3jRWwru/i2Pg9diF3KVlPkYdN9vudis
 GJn0wTdAes5+UN1yfoyU/1J3FYgHo6EjZ3kwPN0qdoONbo2WJDS19rirp9aoronJavmJcG
 LteHZOtM73OPY8CXi6RIWRy4ajOqt3Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-DBBx0w5yNG2_n-ZSwKzU4g-1; Fri, 01 Aug 2025 10:25:04 -0400
X-MC-Unique: DBBx0w5yNG2_n-ZSwKzU4g-1
X-Mimecast-MFC-AGG-ID: DBBx0w5yNG2_n-ZSwKzU4g_1754058303
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b7931d3d76so208487f8f.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754058303; x=1754663103;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QuL0JTKEBhSFp/6lwOdYxS7QOmZe0a+bp9gretjYRbo=;
 b=QA504zMkbl79rKThD+TMPDWfDyv+D2QfxZc9V6kncSbhfIkhlkma4rNLVnK4xLs7Bd
 Jf9s5EbVHQ3elk8xgFpsvHuFI7MkjVAULi+xsCjfYCAA6kpYWWRdI0AYSc1Ux9knPHnH
 J9zAccvcve8EdKwdSnJj8xa8TLG8eM9ogDfKwREEhHqWjOHMT5T8VnTA5UuYo+Sri9Li
 UQkGRHBrKHv7Ql0D7w1klWG06f5SaouKWb6xr30X8MFfOZquJyAZtF96vLEcFDL+3Yxi
 mfldoBIAGYFW7mlXTG9lZPX4O20RQ6OHqCURBafdMwGjGK4ScE7/yOaN6g0ezd7YKGp1
 Un2A==
X-Gm-Message-State: AOJu0YyfgoxIV+cRfeZFF73fphycLEZCF0AcE8z9DwDSneVkOGnJuEAg
 zTkeKn7HDrFFQLTJf9IzWGGKLtcb6K/R8JA73bNxC2UCOqZpWImE57fqxdpTt1tfqKQ7csnhwm4
 4e4dIkdTrY7gljELl+ZgpoaEX7UrwDcicqaLq8AH9dRQUUBzqhIWHdIL2Rfxh9ixUiGCXV59p6X
 O3F6iHmNDEa8pcCL1N5PBRPP0osqvbypPVtQ==
X-Gm-Gg: ASbGncsHkLLSOPjWzyE7qUE8fYjMSRVPxYbNf5MYXu/pdmpahKIR5XV0BKXO4uX3PzB
 LSyBoA0IE/IMxmHWc822JfXOqetOvdjinOQ7MPE/V2yvhsHIYzAgL4gEUS+1l8BSw5aFnEMSqpq
 7Bk3Z6NH70CtCtT6ggoqW4e8GtA1nzIE5JvWlrHXv4Z0yyFun2XgYnJxP5LUpra2iz5swIZz7V+
 We+4IvYZ8jXi0jp3/4gH6LHgWc/3jneOOZ4NJbAf7dg8rcTZCsEVqg1TI/5z9o3MMm09Z3ASLKY
 +M95I7XLdCIaBmgqw1Ad+BEVmwsb0hCj
X-Received: by 2002:a5d:5f51:0:b0:3b7:8da6:1baf with SMTP id
 ffacd0b85a97d-3b794fd5940mr9230774f8f.16.1754058302647; 
 Fri, 01 Aug 2025 07:25:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrsRekZ680qyPDfDU4NlWzGbIhrSAgAnvhJbQla/nOhinkJ97o1DzUxTddadGhc0qw/N3Svg==
X-Received: by 2002:a5d:5f51:0:b0:3b7:8da6:1baf with SMTP id
 ffacd0b85a97d-3b794fd5940mr9230741f8f.16.1754058301894; 
 Fri, 01 Aug 2025 07:25:01 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453d6esm6114814f8f.37.2025.08.01.07.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 07:25:01 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:24:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/17] virtio,pci,pc: bugfixes
Message-ID: <cover.1754058276.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 4e06566dbd1b1251c2788af26a30bd148d4eb6c1:

  Merge tag 'pull-riscv-to-apply-20250730-2' of https://github.com/alistair23/qemu into staging (2025-07-30 09:59:30 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 4caf74916d09019e61c91f8cb1166510836d35e8:

  net/vdpa: fix potential fd leak in net_init_vhost_vdpa() (2025-08-01 10:23:50 -0400)

----------------------------------------------------------------
virtio,pci,pc: bugfixes

small fixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (2):
      virtio-net: Fix VLAN filter table reset timing
      pcie_sriov: Fix configuration and state synchronization

David Woodhouse (1):
      intel_iommu: Allow both Status Write and Interrupt Flag in QI wait

Hanna Czenczek (2):
      vhost: Do not abort on log-start error
      vhost: Do not abort on log-stop error

Jonah Palmer (1):
      virtio: fix off-by-one and invalid access in virtqueue_ordered_fill

Mauro Carvalho Chehab (3):
      tests/acpi: virt: add an empty HEST file
      tests/qtest/bios-tables-test: extend to also check HEST table
      tests/acpi: virt: update HEST file with its current data

Sairaj Kodilkar (6):
      hw/i386/amd_iommu: Fix MMIO register write tracing
      hw/i386/amd_iommu: Remove unused and wrongly set ats_enabled field
      hw/i386/amd_iommu: Move IOAPIC memory region initialization to the end
      hw/i386/amd_iommu: Fix amdvi_write*()
      hw/i386/amd_iommu: Support MMIO writes to the status register
      hw/i386/amd_iommu: Fix event log generation

Stefano Garzarella (2):
      MAINTAINERS: add net/vhost* files under `vhost`
      net/vdpa: fix potential fd leak in net_init_vhost_vdpa()

 hw/i386/amd_iommu.h               |   2 +-
 hw/i386/amd_iommu.c               | 102 +++++++++++++++++++++++++++++---------
 hw/i386/intel_iommu.c             |  15 +++---
 hw/net/virtio-net.c               |   7 +--
 hw/pci/pcie_sriov.c               |  42 +++++++++-------
 hw/virtio/vhost.c                 |   6 ++-
 hw/virtio/virtio.c                |  22 +++++---
 net/vhost-vdpa.c                  |   5 +-
 tests/qtest/bios-tables-test.c    |   2 +-
 MAINTAINERS                       |   1 +
 tests/data/acpi/aarch64/virt/HEST | Bin 0 -> 132 bytes
 11 files changed, 140 insertions(+), 64 deletions(-)
 create mode 100644 tests/data/acpi/aarch64/virt/HEST


