Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C821C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 18:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM9rO-0004Av-1d; Mon, 02 Jun 2025 14:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uM9rK-0004Ah-V6
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 14:26:06 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uM9rI-0003hw-JO
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 14:26:06 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ad8a8da2376so772749366b.3
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 11:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748888762; x=1749493562; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3M7twMFtDvV8kRZ0Bp7tD+PlN7nPWQqTkWIt4WpIo0=;
 b=FcJpVsqtOI5k0Qb1c/l/ORJfaxNhEqYq2k9cxg5TYDOn2JRwpuUuTqalkpQ+1f1TL5
 YubFpyYslmp1/8zfo4Wtf7ykca9L4/74vmBe4VxX67OpnKj05lFa8njQ6TsF0rCgdPk4
 VSeAZenghjSiyq0Scm6b69V5h87PlmX8FA2ovB/tYLXd3AJmM+8UPlBpDYCNWv43bs+2
 ZeOgukQcViM57d6lhjeUbgHtigX051sdQpa66qCo2Yl7Bbf5ICTQ+JqsJvuyPZy95Ha5
 MhR5NBxNhFIW8z7yQyQ2sfsVmhq0v6ZLofNYO9fceboLwLgntD94SNwOqzo3NvlB8/K6
 M0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748888762; x=1749493562;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f3M7twMFtDvV8kRZ0Bp7tD+PlN7nPWQqTkWIt4WpIo0=;
 b=lwl49z6YrwN4hVO78ls9fMIVrfSvsYnsj9qhlluv72prI0LbUTcZndt7Yfddj46ASy
 Lw30WFoDANbUZBHetiE5wShah9uvhdIqTphbsxwKiyy5M8gzb50/GLk3+rGKepAc5+tm
 j1KQ4KXleuqnwet0rLCJuaRVTIihuM0c0FnsrK0PRrKZrT0hohpd0GhBlud3GzBVAhIM
 mSstb2ZnOW4FqGkdjkQGKRXtXRYE8y54xCZtaESJJANSH9tIC9pLLPN7Qc21mB5gvd4w
 qhkziGTXPK8EpyLc8AmPRcsDd+JvQoI7EXup3qnVvbeMCsxk/Z3aw95Ix1GIoTqX69Jk
 Ztyg==
X-Gm-Message-State: AOJu0YwxMF8YTHuR2KIte96TyEAr+DWicIzy+0MptGwJEKhG7IygZgSe
 QoTA9gD2YhXlZ0DFEQbwE6sKFTcDE6EWUfNwsI/9fUj6oUiYqd23c5yQx6SKP+bWjrV2YLKJWmd
 WvuhffeBNvC93cv1p/fAnFTPELC4ViAE=
X-Gm-Gg: ASbGncsGklZ6BFmolNEfD03PY5zNc+w5RDgXMt5/nZUKuiTdyqsN6U1Rv73MKwOiEYX
 tfoJ4isF6KO1fpakpekH4avfdHyvsCHuQ9IGwEeWQBh7jaLdgBXZem8VnxBG9a5PNlSwlx5gL79
 ODjBKPJezs2phKdmNdbL6hYiK58+gO0ZQzNXXtcUUkEw==
X-Google-Smtp-Source: AGHT+IG8arIsL0hM2iQ8MwGOYON7nRogDbZ0eom2b+3i0Z++IufC3NL6nx+J8p6mrsvoku1URJbPxK5vug/+96gNUmw=
X-Received: by 2002:a17:907:7b9f:b0:ad8:a9fc:8127 with SMTP id
 a640c23a62f3a-adb495114d3mr901401066b.41.1748888761742; Mon, 02 Jun 2025
 11:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1748791463.git.mst@redhat.com>
 <CAJSP0QUCipXvUWQ7uOm4Ct2a0O7=SFF9XZAozTFtAZfak8-EGg@mail.gmail.com>
 <20250602135333-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250602135333-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 2 Jun 2025 14:25:48 -0400
X-Gm-Features: AX0GCFtcg_BGvqzf44v3DXJalhujir8ClYo3XHB2lVpHn-Du5cOWBPkhgxwneYk
Message-ID: <CAJSP0QWvkMMcuy=5hU=4Ps4DtoE2TQ8Up4fDSLZZ8ia_+9jjEA@mail.gmail.com>
Subject: Re: [PULL 00/31] virtio,pci,pc: features, fixes, tests
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x634.google.com
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

On Mon, Jun 2, 2025 at 1:54=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Jun 02, 2025 at 12:39:17PM -0400, Stefan Hajnoczi wrote:
> > On Sun, Jun 1, 2025 at 11:34=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > The following changes since commit d2e9b78162e31b1eaf20f3a4f563da82da=
56908d:
> > >
> > >   Merge tag 'pull-qapi-2025-05-28' of https://repo.or.cz/qemu/armbru =
into staging (2025-05-29 08:36:01 -0400)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstr=
eam
> > >
> > > for you to fetch changes up to 1c5771c092742b729e2a640be184a0f48c0b2c=
db:
> > >
> > >   hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine (2025-06-0=
1 08:30:09 -0400)
> > >
> > > ----------------------------------------------------------------
> > > virtio,pci,pc: features, fixes, tests
> > >
> > > vhost will now no longer set a call notifier if unused
> > > loongarch gained acpi tests based on bios-tables-test
> > > some core pci work for SVM support in vtd
> > > vhost vdpa init has been optimized for response time to QMP
> > > A couple more fixes
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > Please take a look at this CI failure:
> > https://gitlab.com/qemu-project/qemu/-/jobs/10225580735#L4750
>
> Hmm must be how it interacts with something in your tree.
> Which commit are you merging with?
> Let me know, I'll try to rebase.

commit 25de0b9aa129b2b014a0595befef05f04511868d (HEAD -> staging)
Merge: 3e82ddaa8d 6e672b2a08
Author: Stefan Hajnoczi <stefanha@redhat.com>
Date:   Mon Jun 2 09:56:12 2025 -0400

    Merge tag 'for_upstream' of
https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging

    virtio,pci,pc: features, fixes, tests

Commit 6e672b2a08 is the one you published and 3e82ddaa8d is the
qemu.git/master.

>
> > >
> > > ----------------------------------------------------------------
> > > Bernhard Beschow (1):
> > >       hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine
> > >
> > > Bibo Mao (8):
> > >       uefi-test-tools:: Add LoongArch64 support
> > >       tests/data/uefi-boot-images: Add ISO image for LoongArch system
> > >       tests/qtest/bios-tables-test: Use MiB macro rather hardcode val=
ue
> > >       tests/acpi: Add empty ACPI data files for LoongArch
> > >       tests/qtest/bios-tables-test: Add basic testing for LoongArch
> > >       rebuild-expected-aml.sh: Add support for LoongArch
> > >       tests/acpi: Fill acpi table data for LoongArch
> > >       tests/acpi: Remove stale allowed tables
> > >
> > > CLEMENT MATHIEU--DRIF (11):
> > >       pcie: Add helper to declare PASID capability for a pcie device
> > >       pcie: Helper functions to check if PASID is enabled
> > >       pcie: Helper function to check if ATS is enabled
> > >       pcie: Add a helper to declare the PRI capability for a pcie dev=
ice
> > >       pcie: Helper functions to check to check if PRI is enabled
> > >       pci: Cache the bus mastering status in the device
> > >       pci: Add an API to get IOMMU's min page size and virtual addres=
s width
> > >       memory: Store user data pointer in the IOMMU notifiers
> > >       pci: Add a pci-level initialization function for IOMMU notifier=
s
> > >       pci: Add a pci-level API for ATS
> > >       pci: Add a PCI-level API for PRI
> > >
> > > Eugenio P=C3=A9rez (7):
> > >       vdpa: check for iova tree initialized at net_client_start
> > >       vdpa: reorder vhost_vdpa_set_backend_cap
> > >       vdpa: set backend capabilities at vhost_vdpa_init
> > >       vdpa: add listener_registered
> > >       vdpa: reorder listener assignment
> > >       vdpa: move iova_tree allocation to net_vhost_vdpa_init
> > >       vdpa: move memory listener register to vhost_vdpa_init
> > >
> > > Huaitong Han (1):
> > >       vhost: Don't set vring call if guest notifier is unused
> > >
> > > Sairaj Kodilkar (1):
> > >       hw/i386/amd_iommu: Fix device setup failure when PT is on.
> > >
> > > Vasant Hegde (1):
> > >       hw/i386/amd_iommu: Fix xtsup when vcpus < 255
> > >
> > > Yuri Benditovich (1):
> > >       virtio: check for validity of indirect descriptors
> > >
> > >  include/hw/pci/pci.h                               | 316 +++++++++++=
++++++++++
> > >  include/hw/pci/pci_device.h                        |   1 +
> > >  include/hw/pci/pcie.h                              |  13 +-
> > >  include/hw/pci/pcie_regs.h                         |   8 +
> > >  include/hw/virtio/vhost-vdpa.h                     |  22 +-
> > >  include/system/memory.h                            |   1 +
> > >  hw/i386/amd_iommu.c                                |  20 +-
> > >  hw/i386/pc_piix.c                                  |   5 +
> > >  hw/pci/pci.c                                       | 206 +++++++++++=
++-
> > >  hw/pci/pcie.c                                      |  78 +++++
> > >  hw/virtio/vhost-vdpa.c                             | 107 ++++---
> > >  hw/virtio/virtio-pci.c                             |   7 +-
> > >  hw/virtio/virtio.c                                 |  11 +
> > >  net/vhost-vdpa.c                                   |  34 +--
> > >  tests/qtest/bios-tables-test.c                     |  99 ++++++-
> > >  tests/data/acpi/loongarch64/virt/APIC              | Bin 0 -> 108 by=
tes
> > >  tests/data/acpi/loongarch64/virt/APIC.topology     | Bin 0 -> 213 by=
tes
> > >  tests/data/acpi/loongarch64/virt/DSDT              | Bin 0 -> 4641 b=
ytes
> > >  tests/data/acpi/loongarch64/virt/DSDT.memhp        | Bin 0 -> 5862 b=
ytes
> > >  tests/data/acpi/loongarch64/virt/DSDT.numamem      | Bin 0 -> 4647 b=
ytes
> > >  tests/data/acpi/loongarch64/virt/DSDT.topology     | Bin 0 -> 5352 b=
ytes
> > >  tests/data/acpi/loongarch64/virt/FACP              | Bin 0 -> 268 by=
tes
> > >  tests/data/acpi/loongarch64/virt/MCFG              | Bin 0 -> 60 byt=
es
> > >  tests/data/acpi/loongarch64/virt/PPTT              | Bin 0 -> 76 byt=
es
> > >  tests/data/acpi/loongarch64/virt/PPTT.topology     | Bin 0 -> 296 by=
tes
> > >  tests/data/acpi/loongarch64/virt/SLIT              |   0
> > >  tests/data/acpi/loongarch64/virt/SLIT.numamem      | Bin 0 -> 48 byt=
es
> > >  tests/data/acpi/loongarch64/virt/SPCR              | Bin 0 -> 80 byt=
es
> > >  tests/data/acpi/loongarch64/virt/SRAT              | Bin 0 -> 104 by=
tes
> > >  tests/data/acpi/loongarch64/virt/SRAT.memhp        | Bin 0 -> 144 by=
tes
> > >  tests/data/acpi/loongarch64/virt/SRAT.numamem      | Bin 0 -> 144 by=
tes
> > >  tests/data/acpi/loongarch64/virt/SRAT.topology     | Bin 0 -> 216 by=
tes
> > >  tests/data/acpi/rebuild-expected-aml.sh            |   4 +-
> > >  .../bios-tables-test.loongarch64.iso.qcow2         | Bin 0 -> 12800 =
bytes
> > >  tests/qtest/meson.build                            |   1 +
> > >  tests/uefi-test-tools/Makefile                     |   5 +-
> > >  .../UefiTestToolsPkg/UefiTestToolsPkg.dsc          |   6 +-
> > >  tests/uefi-test-tools/uefi-test-build.config       |  10 +
> > >  38 files changed, 846 insertions(+), 108 deletions(-)
> > >  create mode 100644 tests/data/acpi/loongarch64/virt/APIC
> > >  create mode 100644 tests/data/acpi/loongarch64/virt/APIC.topology
> > >  create mode 100644 tests/data/acpi/loongarch64/virt/DSDT
> > >  create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.memhp
> > >  create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.numamem
> > >  create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.topology
> > >  create mode 100644 tests/data/acpi/loongarch64/virt/FACP
> > >  create mode 100644 tests/data/acpi/loongarch64/virt/MCFG
> > >  create mode 100644 tests/data/acpi/loongarch64/virt/PPTT
> > >  create mode 100644 tests/data/acpi/loongarch64/virt/PPTT.topology
> > >  create mode 100644 tests/data/acpi/loongarch64/virt/SLIT
> > >  create mode 100644 tests/data/acpi/loongarch64/virt/SLIT.numamem
> > >  create mode 100644 tests/data/acpi/loongarch64/virt/SPCR
> > >  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT
> > >  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.memhp
> > >  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.numamem
> > >  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.topology
> > >  create mode 100644 tests/data/uefi-boot-images/bios-tables-test.loon=
garch64.iso.qcow2
> > >
> > >
>

