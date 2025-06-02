Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D80C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 08:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM0hT-0006aZ-1e; Mon, 02 Jun 2025 04:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uM0hP-0006aI-Fp
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:39:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uM0hN-0002gW-Ec
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748853551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nNEKmfgSpcXXR0o+h2+nHv3wfqhbFdkZQfD9wtzQH8g=;
 b=hERN4RmgObtR/PGtqW9Yp2a0aqtL3nnv1J5ZlUEl7SWYBk9wtPI56BtKZ6SkuyIZzUCOcI
 kZUpbj3JrohrHkbGROMHPUwPGthdPV5wHaX6UdnPrbRcLDQXFCtiOVmlXxaVCd22XoAKIR
 LtU9F1FtwcJ4Ag7WmZRdNa+/T2diPnk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-UmASHx3aNVCBmgAHAUcykg-1; Mon, 02 Jun 2025 04:39:09 -0400
X-MC-Unique: UmASHx3aNVCBmgAHAUcykg-1
X-Mimecast-MFC-AGG-ID: UmASHx3aNVCBmgAHAUcykg_1748853549
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a50049f8eeso538760f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 01:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748853548; x=1749458348;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nNEKmfgSpcXXR0o+h2+nHv3wfqhbFdkZQfD9wtzQH8g=;
 b=MXxe9w8el7MJWia9Vy+kDIc58qCLKBOUP7C7qH/RvUO8/8WUs3vqsZPLqATyPeTKOh
 iqxua0D37+kapOQmM/0uij/FPWscRVxacf5QoBBg4TeFyrZ9h7PmGh5f8s79p/z2JAra
 G3dV6AC6uugQJNVV1byVxOftgvAwmOdGNNK1zhtCEXfBwfz03iV+i+MGrLuocRj1sxKG
 M93OQnpKwAbGa1dywu6gbJYdBxw2TsUAHYvQAip1PQOGn9JmiL1lsoiRZrpd2X2CjU8+
 blqAjP7AE+qRZFXJm5pShOadwKA9dE9hOsVXe72V1vhoej6f0uf4sPffxXa3i/aJa6ZI
 TlFQ==
X-Gm-Message-State: AOJu0YyTzSrdPOu7M+k/u7MIY/u0a+KZr50QXdcsMtLhZof4B95AmAiB
 XHG96LpHLqYFRE9HooKH88k9FnYhY8IraJwxTtlVq+1lopvmEgrxwpQJzOj35uH9unfmeO/Dabw
 qpR/gPqcTxGcQhkMx7UTethPLDJRKT+wxiL38vJ9Qe2ecI4Mm5M1df7sVXQ7Jzm+vDO5RxVqY7F
 jhVSHykkmurPJD9B2Fj7OCp3eK6IUfVgFyig==
X-Gm-Gg: ASbGncuDSmtUOujJ9rjHd2FtOVtfeR6dooHhBWJRwONXi5vtPVLpRO5i0W/JHAMzyqg
 9oCW3qKxUWdshaATZgJrwabgULZMhbK+cjTP3dgQBvttNxK0TgPDBWXe+KmOxa2BHJfal+76wAJ
 5ooHyLKZnvWXXkkxDaA/NC1fd4YpEZ8+dn+jB5v6DPbfaUooZ4AblrSVvps3FzVb0HNDvQcXP8B
 /xAqMIqsEXvEaUzwotJ13zOtoxfE9f7lYI/4oWv9QTh9U2zJZFTyyNURYsZHmnrb8vznY9u4akX
 rFAkJg==
X-Received: by 2002:a05:6000:2c10:b0:3a4:d975:7d6f with SMTP id
 ffacd0b85a97d-3a4f89e2c0emr9280947f8f.39.1748853548225; 
 Mon, 02 Jun 2025 01:39:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnvNt1kmvQKqcmd8y2gmSWNeJlErm+Vl3u3odcRlLIH6WLKJWm39CLuIW/yZGoUtJ9ZXf6tw==
X-Received: by 2002:a05:6000:2c10:b0:3a4:d975:7d6f with SMTP id
 ffacd0b85a97d-3a4f89e2c0emr9280914f8f.39.1748853547715; 
 Mon, 02 Jun 2025 01:39:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb0654sm113407875e9.21.2025.06.02.01.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 01:39:06 -0700 (PDT)
Date: Mon, 2 Jun 2025 04:39:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/31] virtio,pci,pc: features, fixes, tests
Message-ID: <20250602043846-mutt-send-email-mst@kernel.org>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Jun 01, 2025 at 11:24:45AM -0400, Michael S. Tsirkin wrote:
> The following changes since commit d2e9b78162e31b1eaf20f3a4f563da82da56908d:
> 
>   Merge tag 'pull-qapi-2025-05-28' of https://repo.or.cz/qemu/armbru into staging (2025-05-29 08:36:01 -0400)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to 1c5771c092742b729e2a640be184a0f48c0b2cdb:
> 
>   hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine (2025-06-01 08:30:09 -0400)



6e672b2a088ad56beb076d8d19ff86502815d6a8 now - I fixed two commit logs


> ----------------------------------------------------------------
> virtio,pci,pc: features, fixes, tests
> 
> vhost will now no longer set a call notifier if unused
> loongarch gained acpi tests based on bios-tables-test
> some core pci work for SVM support in vtd
> vhost vdpa init has been optimized for response time to QMP
> A couple more fixes
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Bernhard Beschow (1):
>       hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine
> 
> Bibo Mao (8):
>       uefi-test-tools:: Add LoongArch64 support
>       tests/data/uefi-boot-images: Add ISO image for LoongArch system
>       tests/qtest/bios-tables-test: Use MiB macro rather hardcode value
>       tests/acpi: Add empty ACPI data files for LoongArch
>       tests/qtest/bios-tables-test: Add basic testing for LoongArch
>       rebuild-expected-aml.sh: Add support for LoongArch
>       tests/acpi: Fill acpi table data for LoongArch
>       tests/acpi: Remove stale allowed tables
> 
> CLEMENT MATHIEU--DRIF (11):
>       pcie: Add helper to declare PASID capability for a pcie device
>       pcie: Helper functions to check if PASID is enabled
>       pcie: Helper function to check if ATS is enabled
>       pcie: Add a helper to declare the PRI capability for a pcie device
>       pcie: Helper functions to check to check if PRI is enabled
>       pci: Cache the bus mastering status in the device
>       pci: Add an API to get IOMMU's min page size and virtual address width
>       memory: Store user data pointer in the IOMMU notifiers
>       pci: Add a pci-level initialization function for IOMMU notifiers
>       pci: Add a pci-level API for ATS
>       pci: Add a PCI-level API for PRI
> 
> Eugenio Pérez (7):
>       vdpa: check for iova tree initialized at net_client_start
>       vdpa: reorder vhost_vdpa_set_backend_cap
>       vdpa: set backend capabilities at vhost_vdpa_init
>       vdpa: add listener_registered
>       vdpa: reorder listener assignment
>       vdpa: move iova_tree allocation to net_vhost_vdpa_init
>       vdpa: move memory listener register to vhost_vdpa_init
> 
> Huaitong Han (1):
>       vhost: Don't set vring call if guest notifier is unused
> 
> Sairaj Kodilkar (1):
>       hw/i386/amd_iommu: Fix device setup failure when PT is on.
> 
> Vasant Hegde (1):
>       hw/i386/amd_iommu: Fix xtsup when vcpus < 255
> 
> Yuri Benditovich (1):
>       virtio: check for validity of indirect descriptors
> 
>  include/hw/pci/pci.h                               | 316 +++++++++++++++++++++
>  include/hw/pci/pci_device.h                        |   1 +
>  include/hw/pci/pcie.h                              |  13 +-
>  include/hw/pci/pcie_regs.h                         |   8 +
>  include/hw/virtio/vhost-vdpa.h                     |  22 +-
>  include/system/memory.h                            |   1 +
>  hw/i386/amd_iommu.c                                |  20 +-
>  hw/i386/pc_piix.c                                  |   5 +
>  hw/pci/pci.c                                       | 206 +++++++++++++-
>  hw/pci/pcie.c                                      |  78 +++++
>  hw/virtio/vhost-vdpa.c                             | 107 ++++---
>  hw/virtio/virtio-pci.c                             |   7 +-
>  hw/virtio/virtio.c                                 |  11 +
>  net/vhost-vdpa.c                                   |  34 +--
>  tests/qtest/bios-tables-test.c                     |  99 ++++++-
>  tests/data/acpi/loongarch64/virt/APIC              | Bin 0 -> 108 bytes
>  tests/data/acpi/loongarch64/virt/APIC.topology     | Bin 0 -> 213 bytes
>  tests/data/acpi/loongarch64/virt/DSDT              | Bin 0 -> 4641 bytes
>  tests/data/acpi/loongarch64/virt/DSDT.memhp        | Bin 0 -> 5862 bytes
>  tests/data/acpi/loongarch64/virt/DSDT.numamem      | Bin 0 -> 4647 bytes
>  tests/data/acpi/loongarch64/virt/DSDT.topology     | Bin 0 -> 5352 bytes
>  tests/data/acpi/loongarch64/virt/FACP              | Bin 0 -> 268 bytes
>  tests/data/acpi/loongarch64/virt/MCFG              | Bin 0 -> 60 bytes
>  tests/data/acpi/loongarch64/virt/PPTT              | Bin 0 -> 76 bytes
>  tests/data/acpi/loongarch64/virt/PPTT.topology     | Bin 0 -> 296 bytes
>  tests/data/acpi/loongarch64/virt/SLIT              |   0
>  tests/data/acpi/loongarch64/virt/SLIT.numamem      | Bin 0 -> 48 bytes
>  tests/data/acpi/loongarch64/virt/SPCR              | Bin 0 -> 80 bytes
>  tests/data/acpi/loongarch64/virt/SRAT              | Bin 0 -> 104 bytes
>  tests/data/acpi/loongarch64/virt/SRAT.memhp        | Bin 0 -> 144 bytes
>  tests/data/acpi/loongarch64/virt/SRAT.numamem      | Bin 0 -> 144 bytes
>  tests/data/acpi/loongarch64/virt/SRAT.topology     | Bin 0 -> 216 bytes
>  tests/data/acpi/rebuild-expected-aml.sh            |   4 +-
>  .../bios-tables-test.loongarch64.iso.qcow2         | Bin 0 -> 12800 bytes
>  tests/qtest/meson.build                            |   1 +
>  tests/uefi-test-tools/Makefile                     |   5 +-
>  .../UefiTestToolsPkg/UefiTestToolsPkg.dsc          |   6 +-
>  tests/uefi-test-tools/uefi-test-build.config       |  10 +
>  38 files changed, 846 insertions(+), 108 deletions(-)
>  create mode 100644 tests/data/acpi/loongarch64/virt/APIC
>  create mode 100644 tests/data/acpi/loongarch64/virt/APIC.topology
>  create mode 100644 tests/data/acpi/loongarch64/virt/DSDT
>  create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.memhp
>  create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.numamem
>  create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.topology
>  create mode 100644 tests/data/acpi/loongarch64/virt/FACP
>  create mode 100644 tests/data/acpi/loongarch64/virt/MCFG
>  create mode 100644 tests/data/acpi/loongarch64/virt/PPTT
>  create mode 100644 tests/data/acpi/loongarch64/virt/PPTT.topology
>  create mode 100644 tests/data/acpi/loongarch64/virt/SLIT
>  create mode 100644 tests/data/acpi/loongarch64/virt/SLIT.numamem
>  create mode 100644 tests/data/acpi/loongarch64/virt/SPCR
>  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT
>  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.memhp
>  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.numamem
>  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.topology
>  create mode 100644 tests/data/uefi-boot-images/bios-tables-test.loongarch64.iso.qcow2
> 


