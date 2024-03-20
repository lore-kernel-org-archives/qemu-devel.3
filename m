Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AEAC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 04:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmnmB-0001yY-5w; Wed, 20 Mar 2024 00:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rmnm9-0001yD-0i; Wed, 20 Mar 2024 00:42:05 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rmnm7-0005zD-1S; Wed, 20 Mar 2024 00:42:04 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4d432122a2dso1609522e0c.0; 
 Tue, 19 Mar 2024 21:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710909720; x=1711514520; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AahSnFMfmGByonWDDLM06Y7TC1QB2DWs0dZmM73NJIA=;
 b=HhHiEi7U8G48IWeZS4l1uBqgf8uiT5H+lYpsw6W9KVry7qV/WudDs+d9wu9t63RMFg
 8L3EOL+GcVVyCEXnbSlZVfwRaeQsd1JLLDq0PcaEkUFuoebIGgEHHon9v1DKBFcufJSL
 pfwA6i3JQSJdVlXISYCccdXBZQY7RucF8AWp9lSfvt0/RJOPsvr9Qh5rHDm08C4w3Mf7
 T5je2/2FnYv0voiiHvCqMNr/Dv7fJDA4U7gARtBHftVf9KRjEH6WhvEdK1+sRPEpXz3K
 AxrR8DcrLread+jAbBTiaenSXLfTHpLXfrbLtDl+ekUfw9HqW6qQP3RNuRBfK5K1vRuK
 DxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710909720; x=1711514520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AahSnFMfmGByonWDDLM06Y7TC1QB2DWs0dZmM73NJIA=;
 b=IXvOvDyjDL4N+6zuELNk5h5S70hAuDKtH3uene205JPG8FLScb6oZytSP6YPduKEo+
 VBg4bnhnMt6NJQB00/XvGttB5iDXishFfdOSzKGK2U2mNVcS4072azsqnP7WmFLY0gkO
 tDE8Uq/addVwm6tSKvfKXz4kMOcJ2QYsGaMR8w0tNF8lakQ0ENMqZrwzndP0Rn+87EC3
 rqna09c/eL9GNvTXhrvqW93xpIaattADJqiEdXEy/lzv162bY1UHqIZXOtLZgBjwBQ+S
 79nASn92xARxS0ifa2Em6TwjGmsMP1wvrLi8wyL6ESifSOnsdhzWLLg2lO36EVhtTeM1
 gJnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVut9Mc31rzF+vu608AV/p/qV/4J+gMCYlQYczUW2ckvLGGVj0yEABQ/oghy3WQmEZxvn+K6gPRSEyH1YVxws3lqNrWRIRzn8vw2ce62RiV/loNnRqqyV3hLgnXOuKp5hFuHSknItB34VHR77uVV2XfLw==
X-Gm-Message-State: AOJu0Yx3eAL3/KfpQ0fwcWx4QM2YOliOrmy7D8af7MyJmSBYoFfoo2+l
 aGPwcirChEhq6toUodiaissJcKuWGT3qI19O6iFhqkDa/sUKbNZ6ZRU88ThPOewFkCF8g/F/2Nu
 ZzxHD2svkSblmHkhivqUoPvIt1xM=
X-Google-Smtp-Source: AGHT+IERPiETT+iO+QLAkY1csoUZzJJoHjvD5mUMdxz09+5T55JaZvxkZYAkGMnElIVBaNWtXTsBaeV3IGai2Urui24=
X-Received: by 2002:ac5:cb6f:0:b0:4d8:37eb:9562 with SMTP id
 l15-20020ac5cb6f000000b004d837eb9562mr364065vkn.0.1710909719830; Tue, 19 Mar
 2024 21:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240116010930.43433-1-jeeheng.sia@starfivetech.com>
 <20240116010930.43433-2-jeeheng.sia@starfivetech.com>
 <49d0d8d3-c7fd-4039-aeed-6c31ba16557a@ventanamicro.com>
 <CAKmqyKPE-ERHShmAJQH3VNc7XqOfOeKYYyCRswJSUwf7hqm1xA@mail.gmail.com>
 <Zek4cO8ci2O38NFJ@sunil-laptop>
 <b50a1d69-4978-4aa9-a30b-24f5c8f8d306@ventanamicro.com>
In-Reply-To: <b50a1d69-4978-4aa9-a30b-24f5c8f8d306@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 20 Mar 2024 14:41:33 +1000
Message-ID: <CAKmqyKNaLLBqFnd+BoL+OK6REr95rOP6D5MNWR=hS+dqSYRQtg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hw/arm/virt-acpi-build.c: Migrate SPCR creation to
 common location
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com
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

On Thu, Mar 7, 2024 at 7:22=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 3/7/24 00:45, Sunil V L wrote:
> > On Thu, Mar 07, 2024 at 11:33:25AM +1000, Alistair Francis wrote:
> >> On Thu, Mar 7, 2024 at 4:59=E2=80=AFAM Daniel Henrique Barboza
> >> <dbarboza@ventanamicro.com> wrote:
> >>>
> >>> Hi,
> >>>
> >>> This patch break check-qtest, most specifically 'bios-table'test', fo=
r aarch64.
> >>> I found this while running riscv-to-apply.next in the Gitlab pipeline=
.
> >>>
> >>>
> >>> Here's the output:
> >>>
> >>> $ make -j && QTEST_QEMU_BINARY=3D./qemu-system-aarch64 V=3D1 ./tests/=
qtest/bios-tables-test
> >>> TAP version 13
> >>> # random seed: R02Sf0f2fa0a3fac5d540b1681c820621b7d
> >>> # starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-59=
1353.sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-591353.qmp=
,id=3Dchar0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -=
machine none -accel qtest
> >>> 1..8
> >>> # Start of aarch64 tests
> >>> # Start of acpi tests
> >>> # starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-59=
1353.sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-591353.qmp=
,id=3Dchar0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -=
machine virt  -accel tcg -nodefaults -nographic -drive if=3Dpflash,format=
=3Draw,file=3Dpc-bios/edk2-aarch64-code.fd,readonly=3Don -drive if=3Dpflash=
,format=3Draw,file=3Dpc-bios/edk2-arm-vars.fd,snapshot=3Don -cdrom tests/da=
ta/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2 -cpu cortex-a57 -smb=
ios type=3D4,max-speed=3D2900,current-speed=3D2700 -accel qtest
> >>> acpi-test: Warning! SPCR binary file mismatch. Actual [aml:/tmp/aml-9=
G53J2], Expected [aml:tests/data/acpi/virt/SPCR].
> >>> See source file tests/qtest/bios-tables-test.c for instructions on ho=
w to update expected files.
> >>> acpi-test: Warning! SPCR mismatch. Actual [asl:/tmp/asl-SR53J2.dsl, a=
ml:/tmp/aml-9G53J2], Expected [asl:/tmp/asl-4Z33J2.dsl, aml:tests/data/acpi=
/virt/SPCR].
> >>>
> >>> The diff is here:
> >>>
> >>> --- /tmp/asl-4Z33J2.dsl 2024-03-06 15:40:24.879879348 -0300
> >>> +++ /tmp/asl-SR53J2.dsl 2024-03-06 15:40:24.877879347 -0300
> >>> @@ -1,57 +1,49 @@
> >>>    /*
> >>>     * Intel ACPI Component Architecture
> >>>     * AML/ASL+ Disassembler version 20220331 (64-bit version)
> >>>     * Copyright (c) 2000 - 2022 Intel Corporation
> >>>
> >>> (...)
> >>>
> >>>    [000h 0000   4]                    Signature : "SPCR"    [Serial P=
ort Console Redirection Table]
> >>> -[004h 0004   4]                 Table Length : 00000050
> >>> +[004h 0004   4]                 Table Length : 0000004F
> >>>    [008h 0008   1]                     Revision : 02
> >>> -[009h 0009   1]                     Checksum : B1
> >>> +[009h 0009   1]                     Checksum : B2
> >>>    [00Ah 0010   6]                       Oem ID : "BOCHS "
> >>>
> >>> (...)
> >>>
> >>> -[042h 0066   2]                PCI Vendor ID : FFFF
> >>> +[042h 0066   2]                PCI Vendor ID : 00FF
> >>>
> >>>
> >>> After inspecting the common helper and what the original ARM code was=
 doing
> >>> I found out that we're missing something down there:
> >>>
> >>>
> >>> On 1/15/24 22:09, Sia Jee Heng wrote:
> >>>> RISC-V should also generate the SPCR in a manner similar to ARM.
> >>>> Therefore, instead of replicating the code, relocate this function
> >>>> to the common AML build.
> >>>>
> >>>> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> >>>> ---
> >>>>    hw/acpi/aml-build.c         | 51 ++++++++++++++++++++++++++++
> >>>>    hw/arm/virt-acpi-build.c    | 68 +++++++++++++++-----------------=
-----
> >>>>    include/hw/acpi/acpi-defs.h | 33 ++++++++++++++++++
> >>>>    include/hw/acpi/aml-build.h |  4 +++
> >>>>    4 files changed, 115 insertions(+), 41 deletions(-)
> >>>>
> >>>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> >>>> index af66bde0f5..f3904650e4 100644
> >>>> --- a/hw/acpi/aml-build.c
> >>>> +++ b/hw/acpi/aml-build.c
> >>>> @@ -1994,6 +1994,57 @@ static void build_processor_hierarchy_node(GA=
rray *tbl, uint32_t flags,
> >>>>        }
> >>>>    }
> >>>>
> >>>> +void build_spcr(GArray *table_data, BIOSLinker *linker,
> >>>> +                const AcpiSpcrData *f, const uint8_t rev,
> >>>> +                const char *oem_id, const char *oem_table_id)
> >>>> +{
> >>>> +    AcpiTable table =3D { .sig =3D "SPCR", .rev =3D rev, .oem_id =
=3D oem_id,
> >>>> +                        .oem_table_id =3D oem_table_id };
> >>>> +
> >>>> +    acpi_table_begin(&table, table_data);
> >>>> +    /* Interface type */
> >>>> +    build_append_int_noprefix(table_data, f->interface_type, 1);
> >>>> +    /* Reserved */
> >>>> +    build_append_int_noprefix(table_data, 0, 3);
> >>>> +    /* Base Address */
> >>>> +    build_append_gas(table_data, f->base_addr.id, f->base_addr.widt=
h,
> >>>> +                     f->base_addr.offset, f->base_addr.size,
> >>>> +                     f->base_addr.addr);
> >>>> +    /* Interrupt type */
> >>>> +    build_append_int_noprefix(table_data, f->interrupt_type, 1);
> >>>> +    /* IRQ */
> >>>> +    build_append_int_noprefix(table_data, f->pc_interrupt, 1);
> >>>> +    /* Global System Interrupt */
> >>>> +    build_append_int_noprefix(table_data, f->interrupt, 4);
> >>>> +    /* Baud Rate */
> >>>> +    build_append_int_noprefix(table_data, f->baud_rate, 1);
> >>>> +    /* Parity */
> >>>> +    build_append_int_noprefix(table_data, f->parity, 1);
> >>>> +    /* Stop Bits */
> >>>> +    build_append_int_noprefix(table_data, f->stop_bits, 1);
> >>>> +    /* Flow Control */
> >>>> +    build_append_int_noprefix(table_data, f->flow_control, 1);
> >>>
> >>> Here. We're missing the "Language" entry.
> >>>
> >>>
> >>> This diff fixes the broken test:
> >>>
> >>>
> >>> $ git diff
> >>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> >>> index f3904650e4..6d4517cfbe 100644
> >>> --- a/hw/acpi/aml-build.c
> >>> +++ b/hw/acpi/aml-build.c
> >>> @@ -2024,6 +2024,8 @@ void build_spcr(GArray *table_data, BIOSLinker =
*linker,
> >>>        build_append_int_noprefix(table_data, f->stop_bits, 1);
> >>>        /* Flow Control */
> >>>        build_append_int_noprefix(table_data, f->flow_control, 1);
> >>> +    /* Language */
> >>> +    build_append_int_noprefix(table_data, f->language, 1);
> >>>        /* Terminal Type */
> >>>        build_append_int_noprefix(table_data, f->terminal_type, 1);
> >>>        /* PCI Device ID  */
> >>
> >> Thanks! I added this to the patch
> >>
> >>>
> >>>
> >>>
> >>> As a side note, it seems like 'bios-table-test' isn't being run for R=
ISC-V. Not sure if this
> >>> is intentional or a foresight.
> >>
> >> I think you are looking for oversight :)
> >>
> >> I think it's just an oversight, not intentional.
> >>
> > Adding these test cases is WIP. Drew had already pointed this. Myself
> > and Haibo are looking at it. But I doubt patches can be sent before 9.0
> > deadlines. Can we add them post 9.0?
>
> I don't recall the last time I had to deal with a new test being added af=
ter the
> code freeze. It's not a new feature, it increases test coverage and it mi=
ght find
> bugs, so my guess is that it's fine.
>
> Alistair/Peter, any thoughts?

It's probably a post 9.0 thing, especially as I have been sick the
last week and am only just catching up.

Alistair

>
>
> Thanks,
>
> Daniel
>
>
>
>
> >
> > Thanks,
> > Sunil

