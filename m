Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB7AC5475B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 01:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri2dz-0007lH-Tx; Wed, 06 Mar 2024 20:33:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ri2dx-0007kk-OU; Wed, 06 Mar 2024 20:33:57 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ri2dv-0002Vb-U7; Wed, 06 Mar 2024 20:33:57 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4d34dadcb23so44677e0c.1; 
 Wed, 06 Mar 2024 17:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709775232; x=1710380032; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0gKcgXUAqsrdbjOkYzokDH/fQSp9QAEthg8XXtAZaE4=;
 b=QX8e4Q1AD7TpfgpKjyzWLvwxoB5afLcn29c2/TdrfCWVMYYg3ECEjNnENLWJQZjJ5Y
 k+J+3gZsWss//ZPyaI64FZU6bQh3HNgDteZBYPKmjnKTUfAHKAwgfrT7nAz9uWEMWvQX
 QnG8Qerau0ENnzRhWR4kLoOqTMMQEFOxt3ZZ3NH7B+F4TL8qYmA6VNtxIczdzxA6DvF4
 PadCdtSTUuIwwdgoEkC4XJiLclWr0BgTPnV3Milz/86dKRt7J/nyEOxTMq7vnRZ9R9b4
 KqNaY2DVkTCv09cJkxz3K3AlzRYPiwv7dOJOhjeNmhN8LGufjzdghgTZEWTh+eDAciqG
 AOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709775232; x=1710380032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0gKcgXUAqsrdbjOkYzokDH/fQSp9QAEthg8XXtAZaE4=;
 b=TCvFByjS7Qw2cSeN3TNquu0F7KVps6StjtTUv8/y1y6OETEShsjR8z/AdQaftG/85v
 f/1D9u9bQxcX5Wn9U+BxyJYx7qGv0G5RmTaMc8pQ8A0RMzG7HN7AkiGkxOeP7GvPhdeB
 s67vqKobqWEy6IkUzzRIGKWPAfdls6MZB4UMcJvoDXEOfdlb7OIimZHdrynHfgUO9ddw
 ADB4tlUItI1CpO2hn6YT5M2Ti1JXxB9ZtXRFkBntvV44H3XWOlVXbe4e6bb4Ec30Xqgr
 aJtVqDOXMQsDhHLmzMlZmgU0nIZxhA8pPxI07mmo0O/tHRmEMyku1Pkp1OtPz9sTwu3u
 pfTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViUyxV0PwioLpQFtrhvHcYKcrz6z81ndu1Jbaj7J3qcPyNFvXfZGtql/7fPJOrxim1hiuEDrm9KxwvCl5Xd2VW2b8IzhRshO8/hy2hkmriEvqLGA/gkGuJs37SL+PZqJMA8A4kppnAN2+3qF8/H+qDxg==
X-Gm-Message-State: AOJu0YypSpcBEAW+iR4N+/iEKfEHQ8j6Be1n8fTp9BSCYMBgNvxuUyBT
 UkfmhoeWQYa4FWLJMyfdXkRGSJzmTU6flo1y1hTrwZ6Pd3eUjmgK2DAHX2ZaYr2VBjdXKgpGDzs
 ndoeU3nPpv0P+k0y68Gw9KgWyJ1VM34lWtsE=
X-Google-Smtp-Source: AGHT+IHY3UWOGy+9+X2nVxf/Ysi7r4zCI3OvsEg0coUJJWqkkLJWTsR28RLS6YK2hah5D6uhwuxuLFnMFEfggORIPs0=
X-Received: by 2002:a05:6122:2212:b0:4cb:2662:3653 with SMTP id
 bb18-20020a056122221200b004cb26623653mr7551893vkb.9.1709775231737; Wed, 06
 Mar 2024 17:33:51 -0800 (PST)
MIME-Version: 1.0
References: <20240116010930.43433-1-jeeheng.sia@starfivetech.com>
 <20240116010930.43433-2-jeeheng.sia@starfivetech.com>
 <49d0d8d3-c7fd-4039-aeed-6c31ba16557a@ventanamicro.com>
In-Reply-To: <49d0d8d3-c7fd-4039-aeed-6c31ba16557a@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 7 Mar 2024 11:33:25 +1000
Message-ID: <CAKmqyKPE-ERHShmAJQH3VNc7XqOfOeKYYyCRswJSUwf7hqm1xA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hw/arm/virt-acpi-build.c: Migrate SPCR creation to
 common location
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, mst@redhat.com, 
 imammedo@redhat.com, anisinha@redhat.com, peter.maydell@linaro.org, 
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Thu, Mar 7, 2024 at 4:59=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> This patch break check-qtest, most specifically 'bios-table'test', for aa=
rch64.
> I found this while running riscv-to-apply.next in the Gitlab pipeline.
>
>
> Here's the output:
>
> $ make -j && QTEST_QEMU_BINARY=3D./qemu-system-aarch64 V=3D1 ./tests/qtes=
t/bios-tables-test
> TAP version 13
> # random seed: R02Sf0f2fa0a3fac5d540b1681c820621b7d
> # starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-591353=
.sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-591353.qmp,id=
=3Dchar0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -mac=
hine none -accel qtest
> 1..8
> # Start of aarch64 tests
> # Start of acpi tests
> # starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-591353=
.sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-591353.qmp,id=
=3Dchar0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -mac=
hine virt  -accel tcg -nodefaults -nographic -drive if=3Dpflash,format=3Dra=
w,file=3Dpc-bios/edk2-aarch64-code.fd,readonly=3Don -drive if=3Dpflash,form=
at=3Draw,file=3Dpc-bios/edk2-arm-vars.fd,snapshot=3Don -cdrom tests/data/ue=
fi-boot-images/bios-tables-test.aarch64.iso.qcow2 -cpu cortex-a57 -smbios t=
ype=3D4,max-speed=3D2900,current-speed=3D2700 -accel qtest
> acpi-test: Warning! SPCR binary file mismatch. Actual [aml:/tmp/aml-9G53J=
2], Expected [aml:tests/data/acpi/virt/SPCR].
> See source file tests/qtest/bios-tables-test.c for instructions on how to=
 update expected files.
> acpi-test: Warning! SPCR mismatch. Actual [asl:/tmp/asl-SR53J2.dsl, aml:/=
tmp/aml-9G53J2], Expected [asl:/tmp/asl-4Z33J2.dsl, aml:tests/data/acpi/vir=
t/SPCR].
>
> The diff is here:
>
> --- /tmp/asl-4Z33J2.dsl 2024-03-06 15:40:24.879879348 -0300
> +++ /tmp/asl-SR53J2.dsl 2024-03-06 15:40:24.877879347 -0300
> @@ -1,57 +1,49 @@
>   /*
>    * Intel ACPI Component Architecture
>    * AML/ASL+ Disassembler version 20220331 (64-bit version)
>    * Copyright (c) 2000 - 2022 Intel Corporation
>
> (...)
>
>   [000h 0000   4]                    Signature : "SPCR"    [Serial Port C=
onsole Redirection Table]
> -[004h 0004   4]                 Table Length : 00000050
> +[004h 0004   4]                 Table Length : 0000004F
>   [008h 0008   1]                     Revision : 02
> -[009h 0009   1]                     Checksum : B1
> +[009h 0009   1]                     Checksum : B2
>   [00Ah 0010   6]                       Oem ID : "BOCHS "
>
> (...)
>
> -[042h 0066   2]                PCI Vendor ID : FFFF
> +[042h 0066   2]                PCI Vendor ID : 00FF
>
>
> After inspecting the common helper and what the original ARM code was doi=
ng
> I found out that we're missing something down there:
>
>
> On 1/15/24 22:09, Sia Jee Heng wrote:
> > RISC-V should also generate the SPCR in a manner similar to ARM.
> > Therefore, instead of replicating the code, relocate this function
> > to the common AML build.
> >
> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > ---
> >   hw/acpi/aml-build.c         | 51 ++++++++++++++++++++++++++++
> >   hw/arm/virt-acpi-build.c    | 68 +++++++++++++++---------------------=
-
> >   include/hw/acpi/acpi-defs.h | 33 ++++++++++++++++++
> >   include/hw/acpi/aml-build.h |  4 +++
> >   4 files changed, 115 insertions(+), 41 deletions(-)
> >
> > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > index af66bde0f5..f3904650e4 100644
> > --- a/hw/acpi/aml-build.c
> > +++ b/hw/acpi/aml-build.c
> > @@ -1994,6 +1994,57 @@ static void build_processor_hierarchy_node(GArra=
y *tbl, uint32_t flags,
> >       }
> >   }
> >
> > +void build_spcr(GArray *table_data, BIOSLinker *linker,
> > +                const AcpiSpcrData *f, const uint8_t rev,
> > +                const char *oem_id, const char *oem_table_id)
> > +{
> > +    AcpiTable table =3D { .sig =3D "SPCR", .rev =3D rev, .oem_id =3D o=
em_id,
> > +                        .oem_table_id =3D oem_table_id };
> > +
> > +    acpi_table_begin(&table, table_data);
> > +    /* Interface type */
> > +    build_append_int_noprefix(table_data, f->interface_type, 1);
> > +    /* Reserved */
> > +    build_append_int_noprefix(table_data, 0, 3);
> > +    /* Base Address */
> > +    build_append_gas(table_data, f->base_addr.id, f->base_addr.width,
> > +                     f->base_addr.offset, f->base_addr.size,
> > +                     f->base_addr.addr);
> > +    /* Interrupt type */
> > +    build_append_int_noprefix(table_data, f->interrupt_type, 1);
> > +    /* IRQ */
> > +    build_append_int_noprefix(table_data, f->pc_interrupt, 1);
> > +    /* Global System Interrupt */
> > +    build_append_int_noprefix(table_data, f->interrupt, 4);
> > +    /* Baud Rate */
> > +    build_append_int_noprefix(table_data, f->baud_rate, 1);
> > +    /* Parity */
> > +    build_append_int_noprefix(table_data, f->parity, 1);
> > +    /* Stop Bits */
> > +    build_append_int_noprefix(table_data, f->stop_bits, 1);
> > +    /* Flow Control */
> > +    build_append_int_noprefix(table_data, f->flow_control, 1);
>
> Here. We're missing the "Language" entry.
>
>
> This diff fixes the broken test:
>
>
> $ git diff
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index f3904650e4..6d4517cfbe 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -2024,6 +2024,8 @@ void build_spcr(GArray *table_data, BIOSLinker *lin=
ker,
>       build_append_int_noprefix(table_data, f->stop_bits, 1);
>       /* Flow Control */
>       build_append_int_noprefix(table_data, f->flow_control, 1);
> +    /* Language */
> +    build_append_int_noprefix(table_data, f->language, 1);
>       /* Terminal Type */
>       build_append_int_noprefix(table_data, f->terminal_type, 1);
>       /* PCI Device ID  */

Thanks! I added this to the patch

>
>
>
> As a side note, it seems like 'bios-table-test' isn't being run for RISC-=
V. Not sure if this
> is intentional or a foresight.

I think you are looking for oversight :)

I think it's just an oversight, not intentional.

Alistair

