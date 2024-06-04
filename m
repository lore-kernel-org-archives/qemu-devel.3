Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E636C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 03:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEKsB-0007Le-6k; Mon, 03 Jun 2024 23:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEKs3-0007Kj-Hc; Mon, 03 Jun 2024 23:30:00 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEKs1-0004Fd-3x; Mon, 03 Jun 2024 23:29:59 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-80ad0bb602eso1548528241.1; 
 Mon, 03 Jun 2024 20:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717471795; x=1718076595; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXB5nqjIpJ9CripEswHXbDBXna3nIZo6vZiUyZYXBj8=;
 b=H+NANRVyZvJbe/al1leEQunIYNFwXELeO2BtZUwozzUP/J6SihruITDVWS6Pte14hx
 u083MaT/h6MWq8Vhw7Tqqg7PrsaFmmxoHB4J9wgkg8xxo2Tvc0uzbpvq51gxcn3+SDEA
 BvMGUacek5bxxNiqRBjop2nmrkJFzem6xafW0Gn0fxtZdbGfFsgNMOcVdVWH+oryWDNf
 m184ps2AZsvsw0QUCL7s2vaIW1rIDMn+ku4w1qhd6LJ+jHNlHhvjaPSsqgFpWHKebPNG
 vL83PJsH03m5uARccBMl1NBrgdOMaZbUq+zmznNYGxFKzecgSHUr9BLcBXbQFs6uu5/h
 SLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717471795; x=1718076595;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CXB5nqjIpJ9CripEswHXbDBXna3nIZo6vZiUyZYXBj8=;
 b=mOn5MEDKWqBjwKriVYd5eAG6SqB9lTTClagRb4Gb656ITDXOhmoBAozuIhsbOT/cuT
 Bedh1s+6C4h2F6Rw06heMf6zv6nyOB668oOqWQDZS1sNfRhMmPYuk5WFl61H7X7T+BTv
 0dREWszloLY6eDG2IVGpNc3ePiUcXbkX6gpd6cf+ELmdxwyBDeS6NeS/XciE9Bye98Lp
 E3K2g71zQl1M7bb8VqZVysEackgYbvClDOJRkYq5TcCM5bJWlBLp1/BjPsdsHXwgjEfv
 u3nul0VIrBWvIgjZbWudvJo3gJrRDk0mkfDlBKWes2Xo7tQ9iLl5RkkVBTD1ym0eJImM
 Pq9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1tcgQcnrJ2BAwKJJUI20NPpbi0c8diCi4tRDwhmM7p7NTYfA+10Prk5NdQGRsYfTul0Erqk4GvRyD7JxPZf+ad2Qt46vt4LXkf7/DL6l1hr8EVD72BezpW9o=
X-Gm-Message-State: AOJu0YxScEWB4PM7+vYovFpE9wFotSOxDOXahT7l5lELi8B2c8avQR/u
 dSr8rq91LM08mcvj3wBjljpKeLqaBocLm2+C4zWNqm5nCGVyG2f/afYfIc4zNkHx2xCbyySx5Kx
 LhGLvx10KrmNSsWMiZBUxAQvI6s81MEmJ
X-Google-Smtp-Source: AGHT+IEIj3XqkDMRx+1OTxRnOBuIMsCB7lyVcknWRLgAzu1GWNKZ503fGLYMtPJjIHeCiYjDMdJvjvmXohKtJ/cRLz4=
X-Received: by 2002:a05:6102:3112:b0:48b:9296:762c with SMTP id
 ada2fe7eead31-48bc20801b4mr10831609137.2.1717471794808; Mon, 03 Jun 2024
 20:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240524061411.341599-1-sunilvl@ventanamicro.com>
In-Reply-To: <20240524061411.341599-1-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 13:29:28 +1000
Message-ID: <CAKmqyKPQDpo541dF_inV1imL4i6U3KgpeOTPf7TcD-qUwe_O=w@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Add support for RISC-V ACPI tests
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, Haibo1 Xu <haibo1.xu@intel.com>, 
 Anup Patel <apatel@ventanamicro.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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

On Fri, May 24, 2024 at 4:14=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> Currently, bios-table-test doesn't support RISC-V. This series enables
> the framework changes required and basic testing. Things like NUMA
> related test cases will be added later.
>
> This needs refactoring/renaming of ARM64 bios table tests. Importantly,
> the test cases now look for the expected AML files under
> tests/data/acpi/virt/aarch64 path instead of directly under
> tests/data/acpi/virt. To keep test cases not to fail because of this
> movement, they are updated to look for both paths first.
>
> As part of this effort, it is found that uefi-test-tools is currently
> broken to build. So, updated its Makefile as well to use python based
> edk2 build script.

It would be great to get someone who knows the UEFI world better than I
do to ack these changes, especially the first few patches


Alistair

>
> The changes are also available at branch
> https://gitlab.com/vlsunil/qemu/-/tree/riscv_bios_table_test_v2
>
> Changes since v1:
>         1) Addressed feedback from Gerd and Alistair
>         2) Rebased and added tags received
>
> Sunil V L (12):
>   uefi-test-tools/UefiTestToolsPkg: Add RISC-V support
>   uefi-test-tools: Add support for python based build script
>   tests/data/uefi-boot-images: Add RISC-V ISO image
>   qtest: bios-tables-test: Rename aarch64 tests with aarch64 in them
>   tests/qtest/bios-tables-test.c: Add support for arch in path
>   tests/data/acpi/virt: Move ACPI tables under aarch64
>   meson.build: Add RISC-V to the edk2-target list
>   pc-bios/meson.build: Add support for RISC-V in unpack_edk2_blobs
>   tests/data/acpi/rebuild-expected-aml.sh: Add RISC-V
>   tests/qtest/bios-tables-test: Add empty ACPI data files for RISC-V
>   tests/qtest/bios-tables-test.c: Enable basic testing for RISC-V
>   tests/qtest/bios-tables-test: Add expected ACPI data files for RISC-V
>
>  meson.build                                   |   2 +-
>  pc-bios/meson.build                           |   2 +
>  tests/data/acpi/rebuild-expected-aml.sh       |   5 +-
>  tests/data/acpi/virt/{ =3D> aarch64}/APIC       | Bin
>  .../acpi/virt/{ =3D> aarch64}/APIC.acpihmatvirt | Bin
>  .../acpi/virt/{ =3D> aarch64}/APIC.topology     | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/DBG2       | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/DSDT       | Bin
>  .../acpi/virt/{ =3D> aarch64}/DSDT.acpihmatvirt | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/DSDT.memhp | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/DSDT.pxb   | Bin
>  .../acpi/virt/{ =3D> aarch64}/DSDT.topology     | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/FACP       | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/GTDT       | Bin
>  .../acpi/virt/{ =3D> aarch64}/HMAT.acpihmatvirt | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/IORT       | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/MCFG       | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/NFIT.memhp | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/PPTT       | Bin
>  .../acpi/virt/{ =3D> aarch64}/PPTT.acpihmatvirt | Bin
>  .../acpi/virt/{ =3D> aarch64}/PPTT.topology     | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/SLIT.memhp | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/SPCR       | Bin
>  .../acpi/virt/{ =3D> aarch64}/SRAT.acpihmatvirt | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/SRAT.memhp | Bin
>  .../data/acpi/virt/{ =3D> aarch64}/SRAT.numamem | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/SSDT.memhp | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/VIOT       | Bin
>  tests/data/acpi/virt/riscv64/APIC             | Bin 0 -> 116 bytes
>  tests/data/acpi/virt/riscv64/DSDT             | Bin 0 -> 3518 bytes
>  tests/data/acpi/virt/riscv64/FACP             | Bin 0 -> 276 bytes
>  tests/data/acpi/virt/riscv64/MCFG             | Bin 0 -> 60 bytes
>  tests/data/acpi/virt/riscv64/RHCT             | Bin 0 -> 314 bytes
>  tests/data/acpi/virt/riscv64/SPCR             | Bin 0 -> 80 bytes
>  .../bios-tables-test.riscv64.iso.qcow2        | Bin 0 -> 16896 bytes
>  tests/qtest/bios-tables-test.c                |  93 ++++++++++++++----
>  tests/qtest/meson.build                       |   3 +
>  tests/uefi-test-tools/Makefile                |  19 ++--
>  .../UefiTestToolsPkg/UefiTestToolsPkg.dsc     |   6 +-
>  tests/uefi-test-tools/uefi-test-build.config  |  52 ++++++++++
>  40 files changed, 147 insertions(+), 35 deletions(-)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/APIC (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/APIC.acpihmatvirt (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/APIC.topology (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/DBG2 (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/DSDT (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/DSDT.acpihmatvirt (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/DSDT.memhp (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/DSDT.pxb (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/DSDT.topology (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/FACP (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/GTDT (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/HMAT.acpihmatvirt (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/IORT (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/MCFG (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/NFIT.memhp (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/PPTT (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/PPTT.acpihmatvirt (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/PPTT.topology (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/SLIT.memhp (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/SPCR (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/SRAT.acpihmatvirt (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/SRAT.memhp (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/SRAT.numamem (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/SSDT.memhp (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/VIOT (100%)
>  create mode 100644 tests/data/acpi/virt/riscv64/APIC
>  create mode 100644 tests/data/acpi/virt/riscv64/DSDT
>  create mode 100644 tests/data/acpi/virt/riscv64/FACP
>  create mode 100644 tests/data/acpi/virt/riscv64/MCFG
>  create mode 100644 tests/data/acpi/virt/riscv64/RHCT
>  create mode 100644 tests/data/acpi/virt/riscv64/SPCR
>  create mode 100644 tests/data/uefi-boot-images/bios-tables-test.riscv64.=
iso.qcow2
>  create mode 100644 tests/uefi-test-tools/uefi-test-build.config
>
> --
> 2.40.1
>

