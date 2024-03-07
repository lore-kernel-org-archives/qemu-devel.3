Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5892EC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri9xR-0004GS-G6; Thu, 07 Mar 2024 04:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ri9xO-0004Fw-KU
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:22:30 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ri9xK-000565-Q6
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:22:29 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e5760eeb7aso482426b3a.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 01:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709803345; x=1710408145; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FTVxRU5K7bUdUsDj3xGcg7m+v5jwrvME7QShy0kv7CE=;
 b=aW3OGytaK95bhdfCrj9NA9Nbj6o+pikZedExwZ4PFI5MM1JjJq8zvRL0uA7LhmnADn
 Re06TSg1Eoz/BADBrbPvKzHcNs7/5hibdxXajSDZxVFlz1AryPraQmdAWLZds8725Qei
 b/WqYancVB3cqVpkJJFVNEUHWX0Cfid9fSrKRmVHvKLEBEwnYJEHzky8Dp6DJrePxi+Q
 JhQuTnqMSMJqyLgl6n07c12iYWL0YQaoc+QiJbiIpU5DvEW5Rz1oLqwzbRTfHQeTDNbR
 hLLqQ7BQbtYU+EGK+eXRUEpmKGpEKGiML0gbI7OUIFL+G+2jaEsVLIV05kmeDv4NMHl4
 SX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709803345; x=1710408145;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FTVxRU5K7bUdUsDj3xGcg7m+v5jwrvME7QShy0kv7CE=;
 b=q5uETvVR3uX4PQgfDctLzs9KkFNN8o7hTystCINOPVhxchLkHMqnOKJw1Tj9qbRQxO
 g6AJkCXCAQ9Pn327kdtKWlVrGGZzXNu8pUXR2dilaQa9Tb6CiKrlCnN6Iw/OuGpgcU2R
 W5+vh4U/jAwJ9uTkLyyT7GXI1VmF+IzHgEZU6mC2cEj4n0hSFr0WBL+atrjZTw/35WoP
 eY1mCPXZYVRAglUgCTA36u/jU5doR+LmtsLXnPG9aC709HcPgBsjQ0bHkA+nQh3qKi72
 7GB1f5NR5twsZzH1oBUy6d3YvRPQxo1m3BWA5lapvAQG4Sl5H77vfblhenFaVOFCPy+l
 89OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIcFo+SF6I9zI/6n20VUvc0FH7psalkvcZWM3If8et28/2Kx0KFyWwFaVwylYAHXqqBLOJogvApj8/zLEuSqTGYhtuy1w=
X-Gm-Message-State: AOJu0YyCp4hN2BnrXuOe789P+9JDT65MN21iKgCVMjavwPkfBLzpRZIk
 wqr+GyfgDKD7wSBHoUJqFR8KV8t6XRnv1tzkij/93yin7Xxy0YJf2APjBkN6HjM=
X-Google-Smtp-Source: AGHT+IGbMnzCEKnnGB0j+VF9nWDCuAhlATuYU198L6+CZN3Bmn/TqWWJFyoTFZe1Q8WIS2enbFU7OQ==
X-Received: by 2002:a05:6a00:2d13:b0:6e5:fb97:ed05 with SMTP id
 fa19-20020a056a002d1300b006e5fb97ed05mr16479893pfb.25.1709803345223; 
 Thu, 07 Mar 2024 01:22:25 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a056a00008b00b006e5ce366f0csm9790621pfj.89.2024.03.07.01.22.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 01:22:24 -0800 (PST)
Message-ID: <b50a1d69-4978-4aa9-a30b-24f5c8f8d306@ventanamicro.com>
Date: Thu, 7 Mar 2024 06:22:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/arm/virt-acpi-build.c: Migrate SPCR creation to
 common location
Content-Language: en-US
To: Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair23@gmail.com>
Cc: Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
References: <20240116010930.43433-1-jeeheng.sia@starfivetech.com>
 <20240116010930.43433-2-jeeheng.sia@starfivetech.com>
 <49d0d8d3-c7fd-4039-aeed-6c31ba16557a@ventanamicro.com>
 <CAKmqyKPE-ERHShmAJQH3VNc7XqOfOeKYYyCRswJSUwf7hqm1xA@mail.gmail.com>
 <Zek4cO8ci2O38NFJ@sunil-laptop>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <Zek4cO8ci2O38NFJ@sunil-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 3/7/24 00:45, Sunil V L wrote:
> On Thu, Mar 07, 2024 at 11:33:25AM +1000, Alistair Francis wrote:
>> On Thu, Mar 7, 2024 at 4:59 AM Daniel Henrique Barboza
>> <dbarboza@ventanamicro.com> wrote:
>>>
>>> Hi,
>>>
>>> This patch break check-qtest, most specifically 'bios-table'test', for aarch64.
>>> I found this while running riscv-to-apply.next in the Gitlab pipeline.
>>>
>>>
>>> Here's the output:
>>>
>>> $ make -j && QTEST_QEMU_BINARY=./qemu-system-aarch64 V=1 ./tests/qtest/bios-tables-test
>>> TAP version 13
>>> # random seed: R02Sf0f2fa0a3fac5d540b1681c820621b7d
>>> # starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-591353.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-591353.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -machine none -accel qtest
>>> 1..8
>>> # Start of aarch64 tests
>>> # Start of acpi tests
>>> # starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-591353.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-591353.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -machine virt  -accel tcg -nodefaults -nographic -drive if=pflash,format=raw,file=pc-bios/edk2-aarch64-code.fd,readonly=on -drive if=pflash,format=raw,file=pc-bios/edk2-arm-vars.fd,snapshot=on -cdrom tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2 -cpu cortex-a57 -smbios type=4,max-speed=2900,current-speed=2700 -accel qtest
>>> acpi-test: Warning! SPCR binary file mismatch. Actual [aml:/tmp/aml-9G53J2], Expected [aml:tests/data/acpi/virt/SPCR].
>>> See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
>>> acpi-test: Warning! SPCR mismatch. Actual [asl:/tmp/asl-SR53J2.dsl, aml:/tmp/aml-9G53J2], Expected [asl:/tmp/asl-4Z33J2.dsl, aml:tests/data/acpi/virt/SPCR].
>>>
>>> The diff is here:
>>>
>>> --- /tmp/asl-4Z33J2.dsl 2024-03-06 15:40:24.879879348 -0300
>>> +++ /tmp/asl-SR53J2.dsl 2024-03-06 15:40:24.877879347 -0300
>>> @@ -1,57 +1,49 @@
>>>    /*
>>>     * Intel ACPI Component Architecture
>>>     * AML/ASL+ Disassembler version 20220331 (64-bit version)
>>>     * Copyright (c) 2000 - 2022 Intel Corporation
>>>
>>> (...)
>>>
>>>    [000h 0000   4]                    Signature : "SPCR"    [Serial Port Console Redirection Table]
>>> -[004h 0004   4]                 Table Length : 00000050
>>> +[004h 0004   4]                 Table Length : 0000004F
>>>    [008h 0008   1]                     Revision : 02
>>> -[009h 0009   1]                     Checksum : B1
>>> +[009h 0009   1]                     Checksum : B2
>>>    [00Ah 0010   6]                       Oem ID : "BOCHS "
>>>
>>> (...)
>>>
>>> -[042h 0066   2]                PCI Vendor ID : FFFF
>>> +[042h 0066   2]                PCI Vendor ID : 00FF
>>>
>>>
>>> After inspecting the common helper and what the original ARM code was doing
>>> I found out that we're missing something down there:
>>>
>>>
>>> On 1/15/24 22:09, Sia Jee Heng wrote:
>>>> RISC-V should also generate the SPCR in a manner similar to ARM.
>>>> Therefore, instead of replicating the code, relocate this function
>>>> to the common AML build.
>>>>
>>>> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
>>>> ---
>>>>    hw/acpi/aml-build.c         | 51 ++++++++++++++++++++++++++++
>>>>    hw/arm/virt-acpi-build.c    | 68 +++++++++++++++----------------------
>>>>    include/hw/acpi/acpi-defs.h | 33 ++++++++++++++++++
>>>>    include/hw/acpi/aml-build.h |  4 +++
>>>>    4 files changed, 115 insertions(+), 41 deletions(-)
>>>>
>>>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>>>> index af66bde0f5..f3904650e4 100644
>>>> --- a/hw/acpi/aml-build.c
>>>> +++ b/hw/acpi/aml-build.c
>>>> @@ -1994,6 +1994,57 @@ static void build_processor_hierarchy_node(GArray *tbl, uint32_t flags,
>>>>        }
>>>>    }
>>>>
>>>> +void build_spcr(GArray *table_data, BIOSLinker *linker,
>>>> +                const AcpiSpcrData *f, const uint8_t rev,
>>>> +                const char *oem_id, const char *oem_table_id)
>>>> +{
>>>> +    AcpiTable table = { .sig = "SPCR", .rev = rev, .oem_id = oem_id,
>>>> +                        .oem_table_id = oem_table_id };
>>>> +
>>>> +    acpi_table_begin(&table, table_data);
>>>> +    /* Interface type */
>>>> +    build_append_int_noprefix(table_data, f->interface_type, 1);
>>>> +    /* Reserved */
>>>> +    build_append_int_noprefix(table_data, 0, 3);
>>>> +    /* Base Address */
>>>> +    build_append_gas(table_data, f->base_addr.id, f->base_addr.width,
>>>> +                     f->base_addr.offset, f->base_addr.size,
>>>> +                     f->base_addr.addr);
>>>> +    /* Interrupt type */
>>>> +    build_append_int_noprefix(table_data, f->interrupt_type, 1);
>>>> +    /* IRQ */
>>>> +    build_append_int_noprefix(table_data, f->pc_interrupt, 1);
>>>> +    /* Global System Interrupt */
>>>> +    build_append_int_noprefix(table_data, f->interrupt, 4);
>>>> +    /* Baud Rate */
>>>> +    build_append_int_noprefix(table_data, f->baud_rate, 1);
>>>> +    /* Parity */
>>>> +    build_append_int_noprefix(table_data, f->parity, 1);
>>>> +    /* Stop Bits */
>>>> +    build_append_int_noprefix(table_data, f->stop_bits, 1);
>>>> +    /* Flow Control */
>>>> +    build_append_int_noprefix(table_data, f->flow_control, 1);
>>>
>>> Here. We're missing the "Language" entry.
>>>
>>>
>>> This diff fixes the broken test:
>>>
>>>
>>> $ git diff
>>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>>> index f3904650e4..6d4517cfbe 100644
>>> --- a/hw/acpi/aml-build.c
>>> +++ b/hw/acpi/aml-build.c
>>> @@ -2024,6 +2024,8 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
>>>        build_append_int_noprefix(table_data, f->stop_bits, 1);
>>>        /* Flow Control */
>>>        build_append_int_noprefix(table_data, f->flow_control, 1);
>>> +    /* Language */
>>> +    build_append_int_noprefix(table_data, f->language, 1);
>>>        /* Terminal Type */
>>>        build_append_int_noprefix(table_data, f->terminal_type, 1);
>>>        /* PCI Device ID  */
>>
>> Thanks! I added this to the patch
>>
>>>
>>>
>>>
>>> As a side note, it seems like 'bios-table-test' isn't being run for RISC-V. Not sure if this
>>> is intentional or a foresight.
>>
>> I think you are looking for oversight :)
>>
>> I think it's just an oversight, not intentional.
>>
> Adding these test cases is WIP. Drew had already pointed this. Myself
> and Haibo are looking at it. But I doubt patches can be sent before 9.0
> deadlines. Can we add them post 9.0?

I don't recall the last time I had to deal with a new test being added after the
code freeze. It's not a new feature, it increases test coverage and it might find
bugs, so my guess is that it's fine.

Alistair/Peter, any thoughts?


Thanks,

Daniel




> 
> Thanks,
> Sunil

