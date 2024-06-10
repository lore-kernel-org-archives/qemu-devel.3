Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925A9C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 00:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGT0X-00039E-6F; Sun, 09 Jun 2024 20:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sGT0V-00038k-0d; Sun, 09 Jun 2024 20:35:31 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sGT0S-0003J7-RT; Sun, 09 Jun 2024 20:35:30 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4eb39c45a9aso996098e0c.1; 
 Sun, 09 Jun 2024 17:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717979727; x=1718584527; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yG4RTiukvfATmSmu94FRby5JUphXqXxepItYfyr8T5c=;
 b=aadsIZGGh7S4LD9z1kMZqL53QXYZh2RO4bc2BVYkOIml5QQExcHVWB6d5bDGfDB4vy
 CqduarnidpxOMEE0/x0ctgUNFSNKJSctn0goTBDSbwC2avb1L0F5r+lEhlS6G/sb0jgz
 gxAxpZuKgkMvPdcv6BSBiUhEG19A4IOGvT2ryU7lwP18nK0yJxowvLgqe+BUygyTLHef
 SKcHmqldoWArCTZS3F98hU0R6AJ0fLgLnSZV3/PSKkfJk8GRm9KofRHC1yE6wcj2MXUw
 598eEjJHRCt2HdSOStrX/e6oOxEj8fQVDV7vMrkecS0X+zCt27EiyM8xHJLtJyDbs5FG
 pO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717979727; x=1718584527;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yG4RTiukvfATmSmu94FRby5JUphXqXxepItYfyr8T5c=;
 b=r3SG5s/lHwGJa2vetVxcq+JDFlKkUlysXEVd+WGg5YcTdHHUfwqsKKPHxuznsoMnaQ
 z6NUoWUM9mx196RIgdxggtYALuF41YTtfxkDqz9Q2cCQcHtbR9zOGRaKdKXAVVz0iADW
 8ACKJ5pStDmQpd2uNu9qi6wT9vhKo5DKoVg4Gd5gD9an6ZO5BWyCaITbvPVGBrJsVqXa
 o3VJVYKFDzdn2JSPCSYOduV6D25XE1XSPa8MmSF1JehbEKf5+tisbQQQKfAy23hvA+pw
 J7RAnRHsKsuXrFDeWrhjfxXKAemZuwa5C80xMuWs5KK3TqcJwSSz9sjd00Q+4fmoq6+a
 d47w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWii8Ts9RacLa1+whPFcCfEVpqUp3ar+noFN7yNdfISukvNWhe/JTTTn4SUTnVodkKykKZZ8kbPk2lV6w/Mictnuz7GYE=
X-Gm-Message-State: AOJu0YzP+BedK9aBXakSYgVwpcCB6o5mmOfcn8cuZIOIOTRa/meroVXT
 fo/VxDzyzBLIIi2TtTZcqR/hFBkXOjKCZ5tGua7QENeDcByQy0YA7zmpNmQBx0azmIwcbULcPwz
 6RpOs/E43bnJZaD2/v7t8PXaP4zk=
X-Google-Smtp-Source: AGHT+IESe4FoaMR54hKw1YVVpGZpaAizYfhKxoqY9UlJnPEPCetJ3PO++iGw5DtzYxHz2yDMLWBKZ2KuS0Ur3jCa4EE=
X-Received: by 2002:ac5:cdb4:0:b0:4ea:f128:7adb with SMTP id
 71dfb90a1353d-4eb562bba21mr5490934e0c.10.1717979724746; Sun, 09 Jun 2024
 17:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Jun 2024 10:34:58 +1000
Message-ID: <CAKmqyKNd2BL-B12RnXu6ZRC0ApqgFXeZSTxggSxJSnbvcN=aSA@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] riscv: QEMU RISC-V IOMMU Support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, tjeznach@rivosinc.com, ajones@ventanamicro.com, 
 frank.chang@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, May 24, 2024 at 3:43=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> In this new version a lot of changes were made throughout all the code,
> most notably on patch 3. Link for the previous version is [1].
>
> * How it was tested *
>
> This series was tested using an emulated QEMU RISC-V host booting a QEMU
> KVM guest, passing through an emulated e1000 network card from the host
> to the guest. I can provide more details (e.g. QEMU command lines) if
> required, just let me know. For now this cover-letter is too much of an
> essay as is.

It would probably be helpful to document these somewhere, so others
can use them as a starting point for running this

Alistair

>
> The Linux kernel used for tests can be found here:
>
> https://github.com/tjeznach/linux/tree/riscv_iommu_v6-rc3
>
> This is a newer version of the following work from Tomasz:
>
> https://lore.kernel.org/linux-riscv/cover.1715708679.git.tjeznach@rivosin=
c.com/
> ("[PATCH v5 0/7] Linux RISC-V IOMMU Support")
>
> The v5 wasn't enough for the testing being done. v6-rc3 did the trick.
>
> Note that to test this work using riscv-iommu-pci we'll need to provide
> the Rivos PCI ID in the command line. More details down below.
>
> * Highlights of this version *
>
> - patches removed from v2: platform driver (riscv-iommu-sys, former
> patch 05) and the EDU changes (patches 14 and 15). The platform driver
> will be sent later with a working example on the 'virt' machine,
> either on a newer version of this series or via a follow-up series. We
> already have a PoC on [2] created by Sunil. More tests are needed, so
> it'll be left behind for now. The EDU changes will be sent in separate
> after I finish the doc changes that Frank cited in v2.
>
> - patch 3 contains the bulk of changes made from v2. Please give special
> attention to the following functions since this is entirely new code I
> ended up adding:
>
>  - riscv_iommu_report_fault()
>  - riscv_iommu_validate_device_ctx()
>  - riscv_iommu_update_ipsr()
>
>   Aside from these helpers most of the changes made in this patch 3 were
> punctual.
>
> - Red HAT PCI ID related changes. A new patch (4) that introduces a
> generic RISC-V IOMMU PCI ID was added. This PCI ID was gracefully given
> to us by Red Hat and Gerd Hoffman from their ID space. The
> riscv-iommu-pci device now defaults to this PCI ID instead of Rivos PCI
> ID. The device was changed slightly to allow vendor-id and device-id to
> be set in the command-line, so it's now possible to use this reference
> device as another RISC-V IOMMU PCI device to ease the burden of
> testing/development.
>
>   To instantiate the riscv-iommu-pci device using the previous Rivos PCI
> ID, use the following cmd line:
>
>   -device riscv-iommu-pci,vendor-id=3D0x1efd,device-id=3D0xedf1
>
>   I'm using these options to test the series with the existing Linux RISC=
-V
> IOMMU support that uses just a Rivos ID to identify the device.
>
>
> Series based on alistair/riscv-to-apply.next. It's also applicable on
> current QEMU master. It can also be fetched from:
>
> https://gitlab.com/danielhb/qemu/-/tree/riscv_iommu_v3
>
>
> Patches missing reviews/acks: 3, 5, 9, 10, 11.
>
> Changes from v2 [1]:
> - patch 05 (hw/riscv: add riscv-iommu-sys platform device): dropped
>   - will be reintroduced in a later review or as a follow-up series
>
> - patches 14 and 15: dropped
>   - will be sent in separate
>
> - patches 2, 3, 4 and 5:
>   - removed all 'Ziommu' references
>
> - patch 2:
>   - added extra bits that patch 3 ended up using
>
> - patch 3:
>   - fixed blank line at EOF in hw/riscv/trace.h
>   - added a riscv_iommu_report_fault() helper to report faults. The helpe=
r checks if
>     a given fault is eligible to be reported if DTF is 1
>   - Use riscv_iommu_report_fault() in riscv_iommu_ctx() and riscv_iommu_t=
ranslate()
>     to avoid code repetition
>   - added a riscv_iommu_validate_device_ctx() helper to validate the devi=
ce context
>     as specified in "Device configuration checks" section. This helper is=
 being used
>     in riscv_iommu_ctx_fetch()
>   - added a new riscv_iommu_update_ipsr() helper to handle IPSR updates
>     in riscv_iommu_mmio_write()
>   - riscv_iommmu_msi_write() now reports a fault in all error paths
>   - check for fctl.WSI before issuing a MSI interrupt in riscv_iommu_noti=
fy()
>   - change riscv-iommu region name to 'riscv-iommu'
>   - change address_space_init() name for PCI devices to 'name' instead of=
 using TYPE_RISCV_IOMMU_PCI
>   - changed riscv_iommu_mmio_ops min_access_size to 4
>   - do not check for min and max sizes on riscv_iommu_mmio_write()
>   - changed riscv_iommu_trap_ops  min_access_size to 4
>   - removed IOMMU qemu_thread thread:
>     - riscv_iommu_mmio_write() will now execute a riscv_iommu_process_fn =
by holding
>       'core_lock'
>   - init FSCR as zero explicitly
>   - check for bus->iommu_opaque =3D=3D NULL before calling pci_setup_iomm=
u()
>
> - patch 4 (new):
>   - add Red-Hat PCI RISC-V IOMMU ID
>
> - patch 5 (former 4):
>   - create vendor-id and device-id properties
>   - set Red-hat PCI RISC-V IOMMU ID as default ID
>
> - patch 8:
>   - use IOMMU_NONE instead of '0' in relevant 'iot->perm =3D 0' instances
>
> - patch 9:
>   - add s-stage and g-stage steps in riscv_iommu_validate_device_ctx()
>   - removed 'gpa' boolean from riscv_iommu_spa_fetch()
>   - 'en_s' is no longer used for early MSI address match
>
> - patch 10:
>   - add ATS steps in riscv_iommu_validate_device_ctx()
>   - check for 's->enable_ats' before adding RISCV_IOMMU_DC_TC_EN_ATS in d=
evice context
>   - check for 's->enable_ats' before processing ATS commands in riscv_iom=
mu_process_cq_tail()
>   - remove ambiguous trace_riscv_iommu_ats() from riscv_iommu_translate()
>
> - patch 11:
>   - removed unused bits
>   - added RISCV_IOMMU_TR_REQ_CTL_NW and RISCV_IOMMU_TR_RESPONSE_S
>     bits
>   - set IOMMUTLBEntry 'perm' using RISCV_IOMMU_TR_REQ_CTL_NW in riscv_iom=
mu_process_dbg()
>   - clear RISCV_IOMMU_TR_RESPONSE_S in riscv_iommu_process_dbg(). Added a=
 comment talking about the (lack of) superpage support
>
> [1] https://lore.kernel.org/qemu-riscv/20240307160319.675044-1-dbarboza@v=
entanamicro.com/
> [2] https://github.com/vlsunil/qemu/commits/acpi_rimt_poc_v1/
>
> Andrew Jones (1):
>   hw/riscv/riscv-iommu: Add another irq for mrif notifications
>
> Daniel Henrique Barboza (3):
>   pci-ids.rst: add Red Hat pci-id for RISC-V IOMMU device
>   test/qtest: add riscv-iommu-pci tests
>   qtest/riscv-iommu-test: add init queues test
>
> Tomasz Jeznach (9):
>   exec/memtxattr: add process identifier to the transaction attributes
>   hw/riscv: add riscv-iommu-bits.h
>   hw/riscv: add RISC-V IOMMU base emulation
>   hw/riscv: add riscv-iommu-pci reference device
>   hw/riscv/virt.c: support for RISC-V IOMMU PCIDevice hotplug
>   hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)
>   hw/riscv/riscv-iommu: add s-stage and g-stage support
>   hw/riscv/riscv-iommu: add ATS support
>   hw/riscv/riscv-iommu: add DBG support
>
>  docs/specs/pci-ids.rst           |    2 +
>  hw/riscv/Kconfig                 |    4 +
>  hw/riscv/meson.build             |    1 +
>  hw/riscv/riscv-iommu-bits.h      |  416 ++++++
>  hw/riscv/riscv-iommu-pci.c       |  177 +++
>  hw/riscv/riscv-iommu.c           | 2283 ++++++++++++++++++++++++++++++
>  hw/riscv/riscv-iommu.h           |  146 ++
>  hw/riscv/trace-events            |   15 +
>  hw/riscv/trace.h                 |    1 +
>  hw/riscv/virt.c                  |   33 +-
>  include/exec/memattrs.h          |    5 +
>  include/hw/pci/pci.h             |    1 +
>  include/hw/riscv/iommu.h         |   36 +
>  meson.build                      |    1 +
>  tests/qtest/libqos/meson.build   |    4 +
>  tests/qtest/libqos/riscv-iommu.c |   76 +
>  tests/qtest/libqos/riscv-iommu.h |  100 ++
>  tests/qtest/meson.build          |    1 +
>  tests/qtest/riscv-iommu-test.c   |  234 +++
>  19 files changed, 3535 insertions(+), 1 deletion(-)
>  create mode 100644 hw/riscv/riscv-iommu-bits.h
>  create mode 100644 hw/riscv/riscv-iommu-pci.c
>  create mode 100644 hw/riscv/riscv-iommu.c
>  create mode 100644 hw/riscv/riscv-iommu.h
>  create mode 100644 hw/riscv/trace-events
>  create mode 100644 hw/riscv/trace.h
>  create mode 100644 include/hw/riscv/iommu.h
>  create mode 100644 tests/qtest/libqos/riscv-iommu.c
>  create mode 100644 tests/qtest/libqos/riscv-iommu.h
>  create mode 100644 tests/qtest/riscv-iommu-test.c
>
> --
> 2.44.0
>
>

