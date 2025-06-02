Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26739C5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 21:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMDB8-0008PE-Aj; Mon, 02 Jun 2025 17:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uMDB6-0008Oh-56
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 17:58:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uMDB3-0001OV-Kv
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 17:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748901518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PWH6vQN/SEPfYWhKagLIW3DEQIsTcxJ72LlaHbc7hL0=;
 b=jN9AfAD/OX1kT0iyNp5wKR1L5n2bX8V1XKZ8cQalrZ33Wb21A8dCiJc2TjRioaZnnrerCv
 sHpdzqJ7d9tpbpSzGvHESCLHk3LgAbrOzdbY46aEJc97VJDtp+cL6cS6Bh+RHMPX4/CPzz
 enhm0nBo90uMQRfmlZ5KdQFH4KmsUqI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-xapWDBZnN3y7hamGXievnw-1; Mon, 02 Jun 2025 17:58:37 -0400
X-MC-Unique: xapWDBZnN3y7hamGXievnw-1
X-Mimecast-MFC-AGG-ID: xapWDBZnN3y7hamGXievnw_1748901516
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450d244bfabso35161505e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 14:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748901516; x=1749506316;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PWH6vQN/SEPfYWhKagLIW3DEQIsTcxJ72LlaHbc7hL0=;
 b=PxNbrIjJZ7KNfUAMQfZTHS1N2Y7B6DjnHt9S8I20tSlJivHaRPEwpB89iBa0dCX74g
 IkroFg5Rc3Bj9SGt2wAOsNxzicX1cLUPQzJOnnptpBruOxnnc57WSqhKFeqzwyCbWFZz
 2r99jzFN4JBOW/07iyWt1iFRa61QeuRF0S+NWNpe0xxv2YdbPn/gO9z3dP3dbruzfjYq
 CfX/6gwo/2NE8BpmLI9iVXQStd7+hkWX02z+5t6R31InPLAuNCzQUSvOmA7/uznatqsU
 QryY+zFigy+jbqCAxIsCmAolSskE3RWVi96a2fz0RkBuuop02jxJDXt+olBrTFZ55W51
 ccxw==
X-Gm-Message-State: AOJu0YxsnMlJPzSK7lLCWtOitogCc9z2kmW9kYGh4tvN7xebO5DakI2S
 DaJ+T0QT472TpgDNmbrI5JU+tlLIr7UmsF+7ZO6xTo1Qb4ci/TuTb1CTNbaeBtKactMm421cU6/
 a1cr1fU6vi5l89/NyruRv/dRZcEZiKMrQXjbl6qNVYR2Tsm78JNU7kICW
X-Gm-Gg: ASbGnct4jnyhFNBngtlJ5f/icgXJKzdraRp5cQDl71FqZMgMjo1RQq3r0UKJ6z1aMWz
 w3v4oNMeZfPHVlbaCoTrGbSwbT1EPTkaeuSeAzFpIQKHyJS8qdsjABWBEF4RIsvvbm1Pg7g1vsV
 3hrNHC5TqnveOgAl3+oQsLY3tB1BUcljIcmEO2/SLxoTSOJ80t7y3gxzyKVzW/J/iagFFRdmQf5
 8tyLcpD+uCSfgXQPN9S21/8L7HWo/5vxC8u/D1oJeJiLe9XOTJIUQBgWyTKaKLNNoRjpyPBygOA
 BK8EXQ==
X-Received: by 2002:a5d:5f8c:0:b0:3a4:dfaa:df8c with SMTP id
 ffacd0b85a97d-3a4fe154a5amr7696672f8f.11.1748901516293; 
 Mon, 02 Jun 2025 14:58:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX99Nu6ROJ4IbaBjkGVsV7/Qg0w+L/KU1X8vEW9MRVGIQWPIIXnuV7vBhimVCUwBEGLHc5vA==
X-Received: by 2002:a5d:5f8c:0:b0:3a4:dfaa:df8c with SMTP id
 ffacd0b85a97d-3a4fe154a5amr7696662f8f.11.1748901515881; 
 Mon, 02 Jun 2025 14:58:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f22sm15981047f8f.43.2025.06.02.14.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 14:58:35 -0700 (PDT)
Date: Mon, 2 Jun 2025 17:58:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>
Subject: Re: [PULL 00/31] virtio,pci,pc: features, fixes, tests
Message-ID: <20250602175809-mutt-send-email-mst@kernel.org>
References: <cover.1748791463.git.mst@redhat.com>
 <CAJSP0QUCipXvUWQ7uOm4Ct2a0O7=SFF9XZAozTFtAZfak8-EGg@mail.gmail.com>
 <20250602135333-mutt-send-email-mst@kernel.org>
 <CAJSP0QWvkMMcuy=5hU=4Ps4DtoE2TQ8Up4fDSLZZ8ia_+9jjEA@mail.gmail.com>
 <20250602142634-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250602142634-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
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

On Mon, Jun 02, 2025 at 02:31:19PM -0400, Michael S. Tsirkin wrote:
> On Mon, Jun 02, 2025 at 02:25:48PM -0400, Stefan Hajnoczi wrote:
> > On Mon, Jun 2, 2025 at 1:54 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Jun 02, 2025 at 12:39:17PM -0400, Stefan Hajnoczi wrote:
> > > > On Sun, Jun 1, 2025 at 11:34 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > The following changes since commit d2e9b78162e31b1eaf20f3a4f563da82da56908d:
> > > > >
> > > > >   Merge tag 'pull-qapi-2025-05-28' of https://repo.or.cz/qemu/armbru into staging (2025-05-29 08:36:01 -0400)
> > > > >
> > > > > are available in the Git repository at:
> > > > >
> > > > >   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> > > > >
> > > > > for you to fetch changes up to 1c5771c092742b729e2a640be184a0f48c0b2cdb:
> > > > >
> > > > >   hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine (2025-06-01 08:30:09 -0400)
> > > > >
> > > > > ----------------------------------------------------------------
> > > > > virtio,pci,pc: features, fixes, tests
> > > > >
> > > > > vhost will now no longer set a call notifier if unused
> > > > > loongarch gained acpi tests based on bios-tables-test
> > > > > some core pci work for SVM support in vtd
> > > > > vhost vdpa init has been optimized for response time to QMP
> > > > > A couple more fixes
> > > > >
> > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > >
> > > > Please take a look at this CI failure:
> > > > https://gitlab.com/qemu-project/qemu/-/jobs/10225580735#L4750
> > >
> > > Hmm must be how it interacts with something in your tree.
> > > Which commit are you merging with?
> > > Let me know, I'll try to rebase.
> > 
> > commit 25de0b9aa129b2b014a0595befef05f04511868d (HEAD -> staging)
> > Merge: 3e82ddaa8d 6e672b2a08
> > Author: Stefan Hajnoczi <stefanha@redhat.com>
> > Date:   Mon Jun 2 09:56:12 2025 -0400
> > 
> >     Merge tag 'for_upstream' of
> > https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging
> > 
> >     virtio,pci,pc: features, fixes, tests
> > 
> > Commit 6e672b2a08 is the one you published and 3e82ddaa8d is the
> > qemu.git/master.
> 
> I could not figure it out. Must be a loongarch bug dealing
> with s390 hosts. I dropped them from the tag for now.
> Cc contributor to figure it out.
> Bibo Mao pls take a look.
> 
> New tag:
> 0b006153b7ec66505cb2d231235aa19ca5d2ce37
> 
> 
> Thanks!


hope this is ok now. going offline for vacation. see you after the 10th!

> 
> > >
> > > > >
> > > > > ----------------------------------------------------------------
> > > > > Bernhard Beschow (1):
> > > > >       hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine
> > > > >
> > > > > Bibo Mao (8):
> > > > >       uefi-test-tools:: Add LoongArch64 support
> > > > >       tests/data/uefi-boot-images: Add ISO image for LoongArch system
> > > > >       tests/qtest/bios-tables-test: Use MiB macro rather hardcode value
> > > > >       tests/acpi: Add empty ACPI data files for LoongArch
> > > > >       tests/qtest/bios-tables-test: Add basic testing for LoongArch
> > > > >       rebuild-expected-aml.sh: Add support for LoongArch
> > > > >       tests/acpi: Fill acpi table data for LoongArch
> > > > >       tests/acpi: Remove stale allowed tables
> > > > >
> > > > > CLEMENT MATHIEU--DRIF (11):
> > > > >       pcie: Add helper to declare PASID capability for a pcie device
> > > > >       pcie: Helper functions to check if PASID is enabled
> > > > >       pcie: Helper function to check if ATS is enabled
> > > > >       pcie: Add a helper to declare the PRI capability for a pcie device
> > > > >       pcie: Helper functions to check to check if PRI is enabled
> > > > >       pci: Cache the bus mastering status in the device
> > > > >       pci: Add an API to get IOMMU's min page size and virtual address width
> > > > >       memory: Store user data pointer in the IOMMU notifiers
> > > > >       pci: Add a pci-level initialization function for IOMMU notifiers
> > > > >       pci: Add a pci-level API for ATS
> > > > >       pci: Add a PCI-level API for PRI
> > > > >
> > > > > Eugenio Pérez (7):
> > > > >       vdpa: check for iova tree initialized at net_client_start
> > > > >       vdpa: reorder vhost_vdpa_set_backend_cap
> > > > >       vdpa: set backend capabilities at vhost_vdpa_init
> > > > >       vdpa: add listener_registered
> > > > >       vdpa: reorder listener assignment
> > > > >       vdpa: move iova_tree allocation to net_vhost_vdpa_init
> > > > >       vdpa: move memory listener register to vhost_vdpa_init
> > > > >
> > > > > Huaitong Han (1):
> > > > >       vhost: Don't set vring call if guest notifier is unused
> > > > >
> > > > > Sairaj Kodilkar (1):
> > > > >       hw/i386/amd_iommu: Fix device setup failure when PT is on.
> > > > >
> > > > > Vasant Hegde (1):
> > > > >       hw/i386/amd_iommu: Fix xtsup when vcpus < 255
> > > > >
> > > > > Yuri Benditovich (1):
> > > > >       virtio: check for validity of indirect descriptors
> > > > >
> > > > >  include/hw/pci/pci.h                               | 316 +++++++++++++++++++++
> > > > >  include/hw/pci/pci_device.h                        |   1 +
> > > > >  include/hw/pci/pcie.h                              |  13 +-
> > > > >  include/hw/pci/pcie_regs.h                         |   8 +
> > > > >  include/hw/virtio/vhost-vdpa.h                     |  22 +-
> > > > >  include/system/memory.h                            |   1 +
> > > > >  hw/i386/amd_iommu.c                                |  20 +-
> > > > >  hw/i386/pc_piix.c                                  |   5 +
> > > > >  hw/pci/pci.c                                       | 206 +++++++++++++-
> > > > >  hw/pci/pcie.c                                      |  78 +++++
> > > > >  hw/virtio/vhost-vdpa.c                             | 107 ++++---
> > > > >  hw/virtio/virtio-pci.c                             |   7 +-
> > > > >  hw/virtio/virtio.c                                 |  11 +
> > > > >  net/vhost-vdpa.c                                   |  34 +--
> > > > >  tests/qtest/bios-tables-test.c                     |  99 ++++++-
> > > > >  tests/data/acpi/loongarch64/virt/APIC              | Bin 0 -> 108 bytes
> > > > >  tests/data/acpi/loongarch64/virt/APIC.topology     | Bin 0 -> 213 bytes
> > > > >  tests/data/acpi/loongarch64/virt/DSDT              | Bin 0 -> 4641 bytes
> > > > >  tests/data/acpi/loongarch64/virt/DSDT.memhp        | Bin 0 -> 5862 bytes
> > > > >  tests/data/acpi/loongarch64/virt/DSDT.numamem      | Bin 0 -> 4647 bytes
> > > > >  tests/data/acpi/loongarch64/virt/DSDT.topology     | Bin 0 -> 5352 bytes
> > > > >  tests/data/acpi/loongarch64/virt/FACP              | Bin 0 -> 268 bytes
> > > > >  tests/data/acpi/loongarch64/virt/MCFG              | Bin 0 -> 60 bytes
> > > > >  tests/data/acpi/loongarch64/virt/PPTT              | Bin 0 -> 76 bytes
> > > > >  tests/data/acpi/loongarch64/virt/PPTT.topology     | Bin 0 -> 296 bytes
> > > > >  tests/data/acpi/loongarch64/virt/SLIT              |   0
> > > > >  tests/data/acpi/loongarch64/virt/SLIT.numamem      | Bin 0 -> 48 bytes
> > > > >  tests/data/acpi/loongarch64/virt/SPCR              | Bin 0 -> 80 bytes
> > > > >  tests/data/acpi/loongarch64/virt/SRAT              | Bin 0 -> 104 bytes
> > > > >  tests/data/acpi/loongarch64/virt/SRAT.memhp        | Bin 0 -> 144 bytes
> > > > >  tests/data/acpi/loongarch64/virt/SRAT.numamem      | Bin 0 -> 144 bytes
> > > > >  tests/data/acpi/loongarch64/virt/SRAT.topology     | Bin 0 -> 216 bytes
> > > > >  tests/data/acpi/rebuild-expected-aml.sh            |   4 +-
> > > > >  .../bios-tables-test.loongarch64.iso.qcow2         | Bin 0 -> 12800 bytes
> > > > >  tests/qtest/meson.build                            |   1 +
> > > > >  tests/uefi-test-tools/Makefile                     |   5 +-
> > > > >  .../UefiTestToolsPkg/UefiTestToolsPkg.dsc          |   6 +-
> > > > >  tests/uefi-test-tools/uefi-test-build.config       |  10 +
> > > > >  38 files changed, 846 insertions(+), 108 deletions(-)
> > > > >  create mode 100644 tests/data/acpi/loongarch64/virt/APIC
> > > > >  create mode 100644 tests/data/acpi/loongarch64/virt/APIC.topology
> > > > >  create mode 100644 tests/data/acpi/loongarch64/virt/DSDT
> > > > >  create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.memhp
> > > > >  create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.numamem
> > > > >  create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.topology
> > > > >  create mode 100644 tests/data/acpi/loongarch64/virt/FACP
> > > > >  create mode 100644 tests/data/acpi/loongarch64/virt/MCFG
> > > > >  create mode 100644 tests/data/acpi/loongarch64/virt/PPTT
> > > > >  create mode 100644 tests/data/acpi/loongarch64/virt/PPTT.topology
> > > > >  create mode 100644 tests/data/acpi/loongarch64/virt/SLIT
> > > > >  create mode 100644 tests/data/acpi/loongarch64/virt/SLIT.numamem
> > > > >  create mode 100644 tests/data/acpi/loongarch64/virt/SPCR
> > > > >  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT
> > > > >  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.memhp
> > > > >  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.numamem
> > > > >  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.topology
> > > > >  create mode 100644 tests/data/uefi-boot-images/bios-tables-test.loongarch64.iso.qcow2
> > > > >
> > > > >
> > >


