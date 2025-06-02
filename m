Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585F8C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 16:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM8CG-0000xA-8n; Mon, 02 Jun 2025 12:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uM8CF-0000wv-7Q
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 12:39:35 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uM8CC-0001Iy-Um
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 12:39:34 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6045a3a2c5eso6343696a12.2
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 09:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748882370; x=1749487170; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yB/pu1riY2qvCr+/tRPeYKU01gSr8TNGaiJ9Q/veKqk=;
 b=nqdxJp3/naWQbyWXiGPyWK6oJwLzApr5k1BE/dCMPH/cSIGNgTAZIRjIZIc54r2HHl
 sjvto1wYj+ry0e74kcn0EFhFKCw6UY57OxXjAPKoOOODtGT5fLJFtDglxEZV3nLs9uK4
 N3annVbo+SMH+2FRKNxXn1SJiPDz670RUNC+eSLkwOGK34AaQjgk1V+l/mwI89AFpBuv
 IVbeOnQViKUDMbPRwiBJWxLWMAltUPsc6f9gARGlfzMwbprgAiNctxNuhElmaXinNZU0
 jp4U2PAl0Ls/mA6+zxTGjeOOc67EDx13YlDesLY+8w68sq6U9HWDxl667KCyeK/+zxda
 pKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748882370; x=1749487170;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yB/pu1riY2qvCr+/tRPeYKU01gSr8TNGaiJ9Q/veKqk=;
 b=KzIshJEWWR0etm+vNY597SWp0f14/obQWnnEHkNUTG0J5V9B4JBby4IiwCFIFUwMxB
 utIHEgmQzw9A8YW0uKiI/2/dUBHsM4CmGoXLzkEnxhKTRtoJUoK7sF5lysIjs6KyohOm
 Gec6Bi4YgTMZfAzPfWQpuX6HnT/fzmGPPkE2HB9YSYQsaclhRv3OOjEp4ROPOvRLj8kL
 ledPBYjWPt/OK0xKFJYIFKl85BG2DNiCiUxrMfpPRy4TbQzMjdJ1rGwEYnMJOcCQ8GXt
 7Zy9k75LIMQ9+Tdg3Um3AGsQAr9/D7ayeMchDzQUVx8rP8T+1vxx90B9NKrVr5/Lm49F
 G69Q==
X-Gm-Message-State: AOJu0Yw2Yz5DqE4TRVPdo5qxZYY/CB+oQZdk2ZE0m1n+eVGzV21ttGdr
 omUfHBX60fKot+LiHuxUO3JnfVNSEnvxD+D7ED5cdmJrK/VjBtMu5PNnJr9knGVE9rd8D7bRMEj
 qb7mg5STZgadjoRxjY1MRSIAt/tmd0cU=
X-Gm-Gg: ASbGncuUzak6Nc/27Y0R8nilpNDrsyc2uyatj3aPKQerhpb1JpWxLJ0gKXhsY/qBzrz
 Fty+ltCkfzU/OpB+5DzPdxC6HLNzVcOhwU0qzckitLEG7bWt5kNb8DdDFYzjc2dfl+vEcXghWZz
 3fy99CXIlDsliXxpu4TNS6ZjK+nz4MPIk=
X-Google-Smtp-Source: AGHT+IHNHwgw6fgyvwa6QdSZxcrE4EIo56Y5gZkT75B8xaUPN7CzjL7cNBSJzUNVAsMdd/8CKYfTSNegcxRjQZ3g45w=
X-Received: by 2002:a17:907:2d08:b0:adb:2751:1979 with SMTP id
 a640c23a62f3a-adb493db8a0mr1005521166b.20.1748882369790; Mon, 02 Jun 2025
 09:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1748791463.git.mst@redhat.com>
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 2 Jun 2025 12:39:17 -0400
X-Gm-Features: AX0GCFu_sznnRTvXqsNaYdEFx-RKTuqio_sY2Ul548bmVrMNCeKj8BAjJHyPnhI
Message-ID: <CAJSP0QUCipXvUWQ7uOm4Ct2a0O7=SFF9XZAozTFtAZfak8-EGg@mail.gmail.com>
Subject: Re: [PULL 00/31] virtio,pci,pc: features, fixes, tests
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x536.google.com
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

On Sun, Jun 1, 2025 at 11:34=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> The following changes since commit d2e9b78162e31b1eaf20f3a4f563da82da5690=
8d:
>
>   Merge tag 'pull-qapi-2025-05-28' of https://repo.or.cz/qemu/armbru into=
 staging (2025-05-29 08:36:01 -0400)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 1c5771c092742b729e2a640be184a0f48c0b2cdb:
>
>   hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine (2025-06-01 08=
:30:09 -0400)
>
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

Please take a look at this CI failure:
https://gitlab.com/qemu-project/qemu/-/jobs/10225580735#L4750

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
>       pci: Add an API to get IOMMU's min page size and virtual address wi=
dth
>       memory: Store user data pointer in the IOMMU notifiers
>       pci: Add a pci-level initialization function for IOMMU notifiers
>       pci: Add a pci-level API for ATS
>       pci: Add a PCI-level API for PRI
>
> Eugenio P=C3=A9rez (7):
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
>  include/hw/pci/pci.h                               | 316 +++++++++++++++=
++++++
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
>  .../bios-tables-test.loongarch64.iso.qcow2         | Bin 0 -> 12800 byte=
s
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
>  create mode 100644 tests/data/uefi-boot-images/bios-tables-test.loongarc=
h64.iso.qcow2
>
>

