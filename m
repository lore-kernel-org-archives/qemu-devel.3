Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144ACEE49B3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOIs-0005u7-TD; Wed, 11 Sep 2024 10:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOIG-0005Th-Lb
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:26:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOID-0002Mo-NP
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726064760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Djqo6J3MxbHHYuNo/Fe5MbLiDLdsz4AL1lSbVDXBPpw=;
 b=jAzIPgQ1WFEa9vWRhJiHzTQUgYQxkXQIEbt2AHpJoTT0DoK9zp24k+Ezz8xlP93QXDXdXn
 Www3oEZFH1oh6JLH9gL5Jfd3dL8z02ZQpiDo3SVFqHPiYUXFvKVl+o/thzc+4SS4uvt8DO
 0CDCdq7sfDKRowtgvfTy1nMzFu1EAWw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-mMv7lFdJMje9xp_pQwXiYQ-1; Wed, 11 Sep 2024 09:51:28 -0400
X-MC-Unique: mMv7lFdJMje9xp_pQwXiYQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb940cd67so29196935e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062686; x=1726667486;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Djqo6J3MxbHHYuNo/Fe5MbLiDLdsz4AL1lSbVDXBPpw=;
 b=FFN3iGTzPMq5DfDCa40Eiv8ufOdhmfvvhN8jmS69pcUDVmbGE3f4ynPkPG8Text9+g
 WizmfzZSqlqdABWUehHnPoO1aNV2m/j1EyBcMlGQVI+wD1PFLdbx0zA8YBmedukbD4tf
 giu+PqM1+aCiH1rfg+eBjmvaFw6RAbiauq2SE4MZjjlPE2hBlA18m3Ow8SA/jmtQbh6Q
 cpLGzqnDfeQu3vaLQSRu2MUKaEGiO+rz3fX3HDiXjlMTPw38dIFtQ/Aw5it5C5PnxkFc
 9ebfJD+M+TwiS6M91xIXbkTQzNCSroc7kzWci/v86nS/vKzuspuN6X+H24JSqge5xcmx
 Bfgw==
X-Gm-Message-State: AOJu0Yxhhp1ROJ54Np4z3pwwoT13jbAKV/Ne2wUGPWozCWbu6jMwb8Sp
 CD7dXPaPm/xNJZZk6TfiPSCllNPhZw+Yj10PXDp8FkRseABYz/mMvaZdxZNx4EkewUe9e7WQCZT
 a4tPu/dNkFR01n0LUff1yLgaXQmtH3aE9dMBDqSmvVBDyTWUfnAUJlyZHkMHfgn4FbQCflbhL3D
 y/oxY3cEG/5p+SKkQICgIcUQMxbme+AA==
X-Received: by 2002:a05:600c:4f89:b0:42c:b802:47bc with SMTP id
 5b1f17b1804b1-42cb802498bmr105013935e9.34.1726062686346; 
 Wed, 11 Sep 2024 06:51:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRgSgouYIRe5f721RRXDKdrquAT6TzX12rXYEZTs9fbzXIKSFlKymk5NXmf435XuDHZvMkeQ==
X-Received: by 2002:a05:600c:4f89:b0:42c:b802:47bc with SMTP id
 5b1f17b1804b1-42cb802498bmr105013275e9.34.1726062685366; 
 Wed, 11 Sep 2024 06:51:25 -0700 (PDT)
Received: from redhat.com ([2.55.34.253]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb32639sm143281555e9.13.2024.09.11.06.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:51:24 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:51:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/18] virtio,pc,pci: features, fixes, cleanups
Message-ID: <cover.1726062663.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit a66f28df650166ae8b50c992eea45e7b247f4143:

  Merge tag 'migration-20240909-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-09-10 11:19:22 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 6e3c2d58e967cde3dadae298e81c5e8eb9fb9080:

  hw/acpi/ich9: Add periodic and swsmi timer (2024-09-11 09:46:14 -0400)

----------------------------------------------------------------
virtio,pc,pci: features, fixes, cleanups

i286 acpi speedup by precomputing _PRT by Ricardo Ribalda
vhost_net speedup by using MR transactions by Zuo Boqun
ich9 gained support for periodic and swsmi timer by Dominic Prinz

Fixes, cleanups all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
BALATON Zoltan (2):
      hw: Move declaration of IRQState to header and add init function
      hw/isa/vt82c686.c: Embed i8259 irq in device state instead of allocating

David Hildenbrand (1):
      virtio-mem: don't warn about THP sizes on a kernel without THP support

Dominic Prinz (1):
      hw/acpi/ich9: Add periodic and swsmi timer

Dongli Zhang (1):
      pci: don't skip function 0 occupancy verification for devfn auto assign

Gao Shiyuan (1):
      virtio-pci: Add lookup subregion of VirtIOPCIRegion MR

Hanna Czenczek (2):
      virtio: Allow .get_vhost() without vhost_started
      virtio: Always reset vhost devices

Philippe Mathieu-Daudé (1):
      hw/pci/pci-hmp-cmds: Avoid displaying bogus size in 'info pci'

Ricardo Ribalda (3):
      tests/acpi: pc: allow DSDT acpi table changes
      hw/i386/acpi-build: Return a pre-computed _PRT table
      tests/acpi: pc: update golden masters for DSDT

Volker Rümelin (1):
      hw/audio/virtio-sound: fix heap buffer overflow

Wenyu Huang (1):
      virtio: rename virtio_split_packed_update_used_idx

Zhenzhong Duan (2):
      intel_iommu: Fix invalidation descriptor type field
      intel_iommu: Make PASID-cache and PIOTLB type invalid in legacy mode

peng guo (1):
      hw/cxl: fix physical address field in get scan media results output

zuoboqun (1):
      vhost_net: configure all host notifiers in a single MR transaction

 hw/i386/intel_iommu_internal.h       |  11 +--
 include/hw/acpi/ich9.h               |   6 ++
 include/hw/acpi/ich9_timer.h         |  23 ++++++
 include/hw/irq.h                     |  18 ++++
 include/hw/southbridge/ich9.h        |   4 +
 include/hw/virtio/vhost.h            |   4 +
 include/hw/virtio/virtio.h           |   1 +
 hw/acpi/ich9.c                       |  23 ++++++
 hw/acpi/ich9_timer.c                 |  93 +++++++++++++++++++++
 hw/audio/virtio-snd.c                |  24 ------
 hw/core/irq.c                        |  25 +++---
 hw/cxl/cxl-mailbox-utils.c           |   2 +-
 hw/display/vhost-user-gpu.c          |   2 +-
 hw/i386/acpi-build.c                 | 118 +++++---------------------
 hw/i386/intel_iommu.c                |  24 +++---
 hw/i386/pc.c                         |   5 +-
 hw/isa/lpc_ich9.c                    |  14 ++++
 hw/isa/vt82c686.c                    |   7 +-
 hw/net/vhost_net.c                   | 155 ++++++++++++++++++++++++++++++++---
 hw/net/virtio-net.c                  |  19 ++++-
 hw/pci/pci-hmp-cmds.c                |  26 ++++--
 hw/pci/pci.c                         |  17 ++--
 hw/virtio/vhost.c                    |   6 +-
 hw/virtio/virtio-crypto.c            |  18 +++-
 hw/virtio/virtio-mem.c               |   7 ++
 hw/virtio/virtio-pci.c               |   8 +-
 hw/virtio/virtio.c                   |  12 ++-
 hw/acpi/meson.build                  |   2 +-
 hw/audio/trace-events                |   1 -
 tests/data/acpi/x86/pc/DSDT          | Bin 6830 -> 8527 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst | Bin 6741 -> 8438 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat | Bin 8155 -> 9852 bytes
 tests/data/acpi/x86/pc/DSDT.bridge   | Bin 13701 -> 15398 bytes
 tests/data/acpi/x86/pc/DSDT.cphp     | Bin 7294 -> 8991 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm  | Bin 8484 -> 10181 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge | Bin 6781 -> 8478 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot | Bin 3337 -> 5034 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs  | Bin 6902 -> 8599 bytes
 tests/data/acpi/x86/pc/DSDT.memhp    | Bin 8189 -> 9886 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet   | Bin 6688 -> 8385 bytes
 tests/data/acpi/x86/pc/DSDT.numamem  | Bin 6836 -> 8533 bytes
 tests/data/acpi/x86/pc/DSDT.roothp   | Bin 10623 -> 12320 bytes
 tests/data/acpi/x86/q35/DSDT.cxl     | Bin 9714 -> 13148 bytes
 tests/data/acpi/x86/q35/DSDT.viot    | Bin 9464 -> 14615 bytes
 44 files changed, 473 insertions(+), 202 deletions(-)
 create mode 100644 include/hw/acpi/ich9_timer.h
 create mode 100644 hw/acpi/ich9_timer.c


