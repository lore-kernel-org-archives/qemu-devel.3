Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FAE606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 00:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=Ezd4hkz6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW0Un-0004Hf-Px; Tue, 24 Nov 2026 19:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xW0Uf-0004Fm-Rw
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 19:04:14 -0500
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xW0Ub-0002oS-0N
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 19:04:13 -0500
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-33c10faf6easo614048eec.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 16:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795565046; x=1796169846; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7/Y43LKJSKoRlc+gCkoCQQGHMOgYejlW2zFcpPJtusY=;
 b=Ezd4hkz6P2SFlE3SV5pSiMKy2/oAATvO3bIX4F0czL2qiHC5K7hrf+pzDA6Q2Q2/vk
 SfLoKVOme4KKk/tfK1Gzp5V60sqENw4OldBK/8aJXlShulY4q48VKMyeZAnrDtWY0DYC
 PnchYAGmBkgv7tRXfrs90qlj5LP+INvMDPH67zowC+aJ93tea4+tbRAtrzgdxUJq40g3
 1cTlr55oq2qWjRg6VCpYvfgcf2wbx3rtJkoPbW9gptO+4Gi+RSNb1Se1NEeXVP5ks7Km
 ykVe7uXzsbb86qVreDVJJxTQIpeEylSaJEtzDNnX000/JtrtVnxYxEZOpqvlLwlbaSDQ
 lRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795565046; x=1796169846;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7/Y43LKJSKoRlc+gCkoCQQGHMOgYejlW2zFcpPJtusY=;
 b=vai9ZZoTSkJ0zJ8fVfNPnINa/5JgaDkXjxp5OS3sZmWm1ph1/68/EdNjVPUsswZTVu
 HYpJc9bimZ4NLGnb5VMVFJ9PJdPAKDtSII3Xj4iwdYt4nHqsSqOJIe598oU72HKygDC8
 5/yOwzv305eHWVpJ6PqMPVLkPHTOvrmp8xyv1pUGq9I634kYFhXp5+p2dAjG6mU1XI2a
 jood3IHxxQ1z/Pz3VyTCaSS+VG6/NguaeUflp4tOF5Y4eWr/92bwONS85PVCs5H74Git
 JYXAmKyaBjq4rzyXfk9j2Fd2yFxSvglOo02hP8xz55+y5OQUVJy079/Le24WbPEQf3w5
 wUUg==
X-Forwarded-Encrypted: i=1;
 AL+hErE4oadhS+VAZrZgVnVUQ6UhNm+hyJ6FaXT9JmyIZZheEjdnKqWNBaSwN71dsTQd15jUHUZlSqPZ0n3o@nongnu.org
X-Gm-Message-State: APuU4Z/9iZYy8iZ6pYAgrhk8Jr0+ysMidg8u/R6dzz8ieExEIup0qN5R
 4onpV9XHx+KYWe4IyG3ygIO9wSLnyeCN1ySdu8IZGS4OOiq4saJntVBX+RoPercdOWg=
X-Gm-Gg: AZFdTZeVYKbvt4nCKNKaJRVFbjC+2rn2S61MBlzRfngXA3QdTpfN0trzOtigmdW/ASS
 fXtPZcyBfAHZjtUORgRLQhjMsdaJFvAf7af80duvIJRK0PN8n51t6ayqms+L8usP0azc5XvBQyJ
 EF/Rs4pMv7d0S1WASYIHiyuHgGR6pM4Ewy/OQuq5I1i3CB/FPVziOgPuyAm0YAqpHBd8q5HMajH
 auACeayogVcGvmKvDxwzooojsEAEJOTuWpx7qRwnVMgoOH1Kk4m4uIdtUZxorwKUWS3e7vx5Ezw
 52T8q9AbXggONLlSf6eSOmBtDxAySlQuN+biXbSMA6xwD2kTPXfTZ+fUzvOdbgBmwJC6D8eClHB
 NZEb55TXK9nV916pKpVBxuPwUKEXNu/E7HCFv4YIyFzRhXmTgw2M01frSv/DVN5jzCENWS+0eM8
 DFWtFqaiwJcWoqhUrjs7q9jEABiNQNsu3XDeXVk2bD3C4FI3yXPdDufe8p1NKX5joOicokKM9//
 r6454HDw2LNJleDttemF3X+Tc3liUspxSTnRu/Uv9Q8vxgksUdzpmz+lijbm9bGigdg/oUkg3lh
 9Rz3neuRIMP36FgN198MTd5hraavdeJC/Y9uwoom1rMmxmhb0XI=
X-Received: by 2002:a05:7300:16a3:b0:36d:5fbc:8c8d with SMTP id
 5a478bee46e88-3856ef457b6mr23738287eec.2.1795565045351; 
 Tue, 24 Nov 2026 16:04:05 -0800 (PST)
Received: from [172.16.1.33] ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e99fdsm60021034eec.5.2026.11.24.16.03.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 16:04:04 -0800 (PST)
Message-ID: <356a99d8-f969-4ace-8ee4-82c95dc252f1@tenstorrent.com>
Date: Wed, 25 Nov 2026 10:03:55 +1000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] hw/riscv/atlantis: Add the RCPU to the Atlantis SoC
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mpe@kernel.org"
 <mpe@kernel.org>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "joel@jms.id.au" <joel@jms.id.au>
References: <20261030040516.853444-1-portias@oss.tenstorrent.com>
 <20261030040516.853444-7-portias@oss.tenstorrent.com>
 <6d53915a01b6fdeca3dd752c18df3c988dd6fdb5.camel@wdc.com>
Content-Language: en-US
From: Portia Stephens <portias@tenstorrent.com>
In-Reply-To: <6d53915a01b6fdeca3dd752c18df3c988dd6fdb5.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=portias@tenstorrent.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 12/11/2026 9:12 AM, Alistair Francis wrote:
> On Fri, 2026-10-30 at 14:05 +1000, Portia Stephens wrote:
>> The Atlantis SoC has a Realtime CPU, RV32 core. It is part of
>> the security subsystem and is responsible for booting the Ascalon
>> cluster. The RCPU has a different memory view from the Ascalon cores
>> but
>> shares access to many peripherals.
>>
>> This adds the RCPU to the Atlantis SoC with the minimum changes
>> to allow the bootrom to run and wait for the next stage
>> bootloader (FSBL) over UART. The RCPU has its own console (uart0),
>> separate from Ascalon which is exposed on serial_hd 1 on the command
>> line.
>>
>> On hardware, the RCPU will be responsible for loading the Ascalon
>> images
>> into DRAM and releasing the resets of the Ascalon cores. For now the
>> Ascalon cores are still bootstrapping their images directly into DRAM
>> via the command line arguments.
>>
>> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
>> ---
>>   hw/riscv/Kconfig               |   1 +
>>   hw/riscv/tt_atlantis.c         | 298
>> ++++++++++++++++++++++++++++++++-
>>   include/hw/riscv/tt_atlantis.h |  44 +++++
>>   3 files changed, 337 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
>> index 4eccfa443e..8e1812923a 100644
>> --- a/hw/riscv/Kconfig
>> +++ b/hw/riscv/Kconfig
>> @@ -150,6 +150,7 @@ config TENSTORRENT
>>       select DS1338
>>       select TMP105
>>       select CPU_CLUSTER
>> +    select UNIMP
>>   
>>   config XIANGSHAN_KUNMINGHU
>>       bool
>> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
>> index 076f2321e0..f778091e91 100644
>> --- a/hw/riscv/tt_atlantis.c
>> +++ b/hw/riscv/tt_atlantis.c
>> @@ -51,6 +51,7 @@ QEMU_BUILD_BUG_ON(TT_IMSIC_STRIDE != (0x1000 <<
>> TT_IMSIC_GUEST_BITS));
>>   #define TT_ACLINT_TIMEBASE_FREQ 1000000000
>>   
>>   #define ASCALON_CLUSTER_ID     0
>> +#define RCPU_CLUSTER_ID        1
>>   
>>   static const MemMapEntry tt_atlantis_memmap[] = {
>>       /* Keep sorted with :'<,'>!sort -g -k 4 */
>> @@ -78,6 +79,53 @@ static const MemMapEntry tt_atlantis_memmap[] = {
>>       [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
>>   };
>>   
>> +static const MemMapEntry tt_atlantis_rcpu_memmap[] = {
>> +    /* Keep sorted with :'<,'>!sort -g -k 4 */
>> +    [TT_ATL_BOOTROM] =           { 0x00040000,    0x40000 },
>> +    [TT_ATL_RCPU_SRAM] =         { 0x20100000,   0x100000 },
>> +    [TT_ATL_PRCM_RCPU] =         { 0x40000000,    0x10000 },
>> +    [TT_ATL_WDT0] =              { 0x40030000,    0x10000 },
>> +    [TT_ATL_WDT1] =              { 0x40040000,    0x10000 },
>> +    [TT_ATL_IO_CTRL] =           { 0x40060000,    0x10000 },
>> +    [TT_ATL_RCPU_MAILBOX] =      { 0x40100000,    0x10000 },
>> +    [TT_ATL_RCPU_SMN_FIREWALL] = { 0x41010000,    0x10000 },
>> +    [TT_ATL_NOCM_FIREWALL] =     { 0x41020000,    0x10000 },
>> +    [TT_ATL_UART0] =             { 0x48100000,    0x10000 },
>> +    [TT_ATL_UART1] =             { 0x48110000,    0x10000 },
>> +    [TT_ATL_UART2] =             { 0x48120000,    0x10000 },
>> +    [TT_ATL_UART3] =             { 0x48130000,    0x10000 },
>> +    [TT_ATL_UART4] =             { 0x48140000,    0x10000 },
>> +    [TT_ATL_GPIO] =              { 0x48150000,    0x10000 },
>> +    [TT_ATL_QSPI] =              { 0x4a000000,  0x2000000 },
>> +    [TT_ATL_OTP] =               { 0x50000000,   0x100000 },
>> +    [TT_ATL_PRCM_TRNG] =         { 0x50600000,    0x10000 },
>> +    [TT_ATL_SPACC] =             { 0x50800000,   0x100000 },
>> +    [TT_ATL_DDR_LO] =            { 0x60000000, 0x40000000 },
>> +    [TT_ATL_MIMSIC] =            { 0xa0000000,  0x8000000 },
>> +    [TT_ATL_PRCM_PCIE] =         { 0xa8000000,    0x10000 },
>> +    [TT_ATL_PRCM_MM] =           { 0xb0000000,   0x100000 },
>> +    [TT_ATL_SDHCI0] =            { 0xb4020000,    0x10000 },
>> +    [TT_ATL_SDHCI1] =            { 0xb4030000,    0x10000 },
>> +    [TT_ATL_PRCM_HSIO] =         { 0xb40c0000,    0x10000 },
>> +    [TT_ATL_PRCM_DDR0] =         { 0xb8000000,    0x10000 },
>> +    [TT_ATL_PRCM_DDR1] =         { 0xb8800000,    0x10000 },
>> +    [TT_ATL_DDRC0_CTRL] =        { 0xb9000000,   0x800000 },
>> +    [TT_ATL_DDRC1_CTRL] =        { 0xb9800000,   0x800000 },
>> +    [TT_ATL_MAPLIC] =            { 0xbc000000,  0x3000000 },
>> +    [TT_ATL_PRCM_ASC] =          { 0xbf000000,  0x1000000 },
>> +    [TT_ATL_RCPU_CLIC] =         { 0xe000e000,     0x2000 },
>> +    [TT_ATL_RCPU_CLINT] =        { 0xe0020000,     0xc000 },
>> +};
>> +
>> +/*
>> + * Map the entire 4G memory view as unimplemented to prevent faults
>> from
>> + * devices that have not been modeled yet.
>> + */
>> +static const UnimplementedDeviceConfig rcpu_unimp_dev[] = {
>> +    {"unimp", "tt-rcpu.unimp", 0x0, UINT32_MAX,  -1000},
>> +    { }
>> +};
>> +
>>   static I2CBus *i2c_get_bus(TTAtlantisSoCState *s, unsigned busnr)
>>   {
>>       assert(busnr < TT_ATL_NUM_I2C);
>> @@ -549,6 +597,85 @@ static inline int tt_atlantis_uart_index(int
>> uart_dev)
>>       return uart_dev - TT_ATL_UART0;
>>   }
>>   
>> +static void tt_rcpu_cluster_init(Object *obj)
>> +{
>> +    TTRCPUClusterState *rc = TT_RCPU_CLUSTER(obj);
>> +
>> +    object_initialize_child(obj, "tt-rcpu.cluster", &rc->cluster,
>> +                            TYPE_CPU_CLUSTER);
>> +    object_initialize_child(OBJECT(&rc->cluster), "cpus", &rc->cpus,
>> +                            TYPE_RISCV_HART_ARRAY);
>> +}
>> +
>> +static void tt_rcpu_cluster_realize(DeviceState *dev, Error **errp)
>> +{
>> +    TTRCPUClusterState *rc = TT_RCPU_CLUSTER(dev);
>> +
>> +    rc->memmap = tt_atlantis_rcpu_memmap;
>> +
>> +    /* The RCPU has its own memory view. Create it here before the
>> CPU uses it */
>> +    memory_region_init(&rc->memory, OBJECT(rc), "tt-rcpu.memory",
>> +                       UINT32_MAX);
>> +
>> +    /* The RCPU's maskrom which is inaccessible outside of the RCPU
>> */
>> +    if (!memory_region_init_rom(&rc->bootrom, OBJECT(rc),
>> +                                "tt-rcpu.bootrom",
>> +                                rc->memmap[TT_ATL_BOOTROM].size,
>> errp)) {
>> +        return;
>> +    }
>> +    memory_region_add_subregion(&rc->memory,
>> +                                rc->memmap[TT_ATL_BOOTROM].base,
>> +                                &rc->bootrom);
>> +
>> +    /* RCPU SRAM */
>> +    if (!memory_region_init_ram(&rc->sram, OBJECT(rc),
>> +                                "tt-rcpu.sram",
>> +                                rc->memmap[TT_ATL_RCPU_SRAM].size,
>> errp)) {
>> +        return;
>> +    }
>> +    memory_region_add_subregion(&rc->memory,
>> +                                rc->memmap[TT_ATL_RCPU_SRAM].base,
>> +                                &rc->sram);
>> +
>> +    /* CPUs */
>> +    object_property_set_str(OBJECT(&rc->cpus), "cpu-type",
>> TYPE_RISCV_CPU_TT_RCPU,
>> +                            &error_abort);
>> +    object_property_set_int(OBJECT(&rc->cpus), "hartid-base", 0,
>> +                            &error_abort);
>> +    object_property_set_int(OBJECT(&rc->cpus), "num-harts", 1,
>> +                            &error_abort);
>> +    object_property_set_int(OBJECT(&rc->cpus), "resetvec",
>> +                            rc->memmap[TT_ATL_BOOTROM].base,
>> +                            &error_abort);
>> +    object_property_set_link(OBJECT(&rc->cpus), "memory",
>> +                             OBJECT(&rc->memory),
>> +                             &error_abort);
>> +
>> +    if (!sysbus_realize(SYS_BUS_DEVICE(&rc->cpus), errp)) {
>> +        return;
>> +    }
>> +
>> +    qdev_prop_set_int32(DEVICE(&rc->cluster), "cluster-id",
>> RCPU_CLUSTER_ID);
>> +    /* cluster must be realized after the hart array */
>> +    if (!qdev_realize(DEVICE(&rc->cluster), NULL, errp)) {
>> +        return;
>> +    }
>> +
>> +    create_unimplemented_devices(OBJECT(rc), &rc->memory,
>> rcpu_unimp_dev);
>> +
>> +    /* no bootrom image is provided, don't let the core run */
>> +    CPU(&rc->cpus.harts[0])->start_powered_off = true;
>> +}
>> +
>> +static void tt_rcpu_cluster_class_init(ObjectClass *oc, const void
>> *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(oc);
>> +
>> +    dc->realize = tt_rcpu_cluster_realize;
>> +    /* The cluster must be instantiated by a machine or SoC */
>> +    dc->user_creatable = false;
>> +}
>> +
>>   static void tt_ascalon_cluster_init(Object *obj)
>>   {
>>       TTAscalonClusterState *ac = TT_ASCALON_CLUSTER(obj);
>> @@ -647,11 +774,48 @@ static void tt_atlantis_soc_init(Object *obj)
>>       }
>>   }
>>   
>> +/*
>> + * Create and add a new alias to a memory container
>> + * @obj
>> + * @m MemoryRegion container for the alias to be added to
>> + * @orig MemoryRegion original region to be aliased
>> + *    Ascalon memory
>> + * @size of the subregion
>> + * @base address of the subregion
>> + * @name for the alias being added to the RCPU memory
>> + */
>> +static void create_alias(Object *obj, MemoryRegion *m,
>> +        MemoryRegion *orig, hwaddr size, hwaddr base, const char
>> *name)
>> +{
>> +    MemoryRegion *alias = g_new(MemoryRegion, 1);
>> +
>> +    memory_region_init_alias(alias, obj, name, orig, 0,
>> +                             size);
>> +    memory_region_add_subregion(m, base, alias);
>> +}
>> +
>> +/*
>> + * Alias a device to a memory container
>> + * @obj
>> + * @m MemoryRegion container for the alias to be added to
>> + * @dev Device to be added.
>> + * @size of the subregion
>> + * @base address of the subregion
>> + * @name for the alias being added to the RCPU memory
>> + */
>> +static void create_device_alias(Object *obj, MemoryRegion *m,
>> DeviceState *dev,
>> +        hwaddr size, hwaddr base, const char *name)
>> +{
>> +    MemoryRegion *orig = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
>> 0);
>> +    create_alias(obj, m, orig, size, base, name);
>> +}
>> +
>>   static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
>>   {
>>       TTAtlantisSoCState *s = TT_ATLANTIS_SOC(dev);
>>       TTAscalonClusterState *ac = &s->ascalon;
>> -    ram_addr_t lo_ram_size, ram_size;
>> +    TTRCPUClusterState *rc = &s->rcpu;
>> +    ram_addr_t lo_ram_size, ram_size, rcpu_ram_size;
>>       int hart_count = ac->num_harts;
>>   
>>       if (!s->dram) {
>> @@ -663,6 +827,14 @@ static void tt_atlantis_soc_realize(DeviceState
>> *dev, Error **errp)
>>           return;
>>       }
>>   
>> +    if (s->has_rcpu) {
>> +        /* Only create the RCPU if it is enabled */
>> +        object_initialize_child(OBJECT(s), "rcpu", &s->rcpu,
>> TYPE_TT_RCPU_CLUSTER);
>> +        if (!qdev_realize(DEVICE(&s->rcpu), NULL, errp)) {
>> +            return;
>> +        }
>> +    }
>> +
>>       ram_size = memory_region_size(s->dram);
>>   
>>       s->irqchip = riscv_create_aia(&ac->memory,
>> @@ -708,6 +880,23 @@ static void tt_atlantis_soc_realize(DeviceState
>> *dev, Error **errp)
>>                                0, lo_ram_size);
>>       memory_region_add_subregion(&ac->memory,
>>                                   ac->memmap[TT_ATL_DDR_LO].base, &s-
>>> ram_lo);
>> +    if (s->has_rcpu) {
>> +        /*
>> +         * The RCPU has a 1G view of lower DDR. DDR low size can be
>> configured by
>> +         * the command line parameters so pick the minimum between
>> 1G and the user
>> +         * provided size.
>> +         */
>> +        rcpu_ram_size = MIN(rc->memmap[TT_ATL_DDR_LO].size,
>> lo_ram_size);
>> +        create_alias(OBJECT(s), &rc->memory, &s->ram_lo,
>> +                     rcpu_ram_size,
>> +                     rc->memmap[TT_ATL_DDR_LO].base,
>> +                     "tt-rcpu.ram");
>> +
>> +        /* UART0, the RCPU console */
>> +        qdev_prop_set_chr(DEVICE(&s-
>>> uart[tt_atlantis_uart_index(TT_ATL_UART0)]),
>> +                          "chardev", serial_hd(1));
> 
> This seems switched around, UART0 and serial_hd(1)

This is intentional. Ascalon's console is on uart1 and rcpu on uart0. 
The machine will always have Ascalon enabled but the rcpu is optional. 
We want the Ascalon console to always show up on the first command line 
serial interface.


> 
>> +    }
>> +
>>   
>>       /* 4 PRCM blocks */
>>       if (!sysbus_realize(SYS_BUS_DEVICE(&s-
>>> prcm[TT_ATLANTIS_PRCM_DOMAIN_RCPU]),
>> @@ -718,6 +907,13 @@ static void tt_atlantis_soc_realize(DeviceState
>> *dev, Error **errp)
>>           &ac->memory, ac->memmap[TT_ATL_PRCM_RCPU].base,
>>           sysbus_mmio_get_region(
>>               SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_RCPU]),
>> 0));
>> +    if (s->has_rcpu) {
>> +        create_device_alias(OBJECT(s), &rc->memory,
>> +                            DEVICE(&s-
>>> prcm[TT_ATLANTIS_PRCM_DOMAIN_RCPU]),
>> +                            rc->memmap[TT_ATL_PRCM_RCPU].size,
>> +                            rc->memmap[TT_ATL_PRCM_RCPU].base,
>> +                            "tt-rcpu.rcpu-prcm");
>> +    }
>>   
>>       if (!sysbus_realize(SYS_BUS_DEVICE(&s-
>>> prcm[TT_ATLANTIS_PRCM_DOMAIN_HSIO]),
>>                           errp)) {
>> @@ -727,6 +923,13 @@ static void tt_atlantis_soc_realize(DeviceState
>> *dev, Error **errp)
>>           &ac->memory, ac->memmap[TT_ATL_PRCM_HSIO].base,
>>           sysbus_mmio_get_region(
>>               SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_HSIO]),
>> 0));
>> +    if (s->has_rcpu) {
>> +        create_device_alias(OBJECT(s), &rc->memory,
>> +                            DEVICE(&s-
>>> prcm[TT_ATLANTIS_PRCM_DOMAIN_HSIO]),
>> +                            rc->memmap[TT_ATL_PRCM_HSIO].size,
>> +                            rc->memmap[TT_ATL_PRCM_HSIO].base,
>> +                            "tt-rcpu.rcpu-hsio");
>> +    }
>>   
>>       if (!sysbus_realize(SYS_BUS_DEVICE(&s-
>>> prcm[TT_ATLANTIS_PRCM_DOMAIN_PCIE]),
>>                           errp)) {
>> @@ -736,6 +939,13 @@ static void tt_atlantis_soc_realize(DeviceState
>> *dev, Error **errp)
>>           &ac->memory, ac->memmap[TT_ATL_PRCM_PCIE].base,
>>           sysbus_mmio_get_region(
>>               SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_PCIE]),
>> 0));
>> +    if (s->has_rcpu) {
>> +        create_device_alias(OBJECT(s), &rc->memory,
>> +                            DEVICE(&s-
>>> prcm[TT_ATLANTIS_PRCM_DOMAIN_PCIE]),
>> +                            rc->memmap[TT_ATL_PRCM_PCIE].size,
>> +                            rc->memmap[TT_ATL_PRCM_PCIE].base,
>> +                            "tt-rcpu.rcpu-pcie");
>> +    }
>>   
>>       if (!sysbus_realize(SYS_BUS_DEVICE(&s-
>>> prcm[TT_ATLANTIS_PRCM_DOMAIN_MM]),
>>                           errp)) {
>> @@ -745,8 +955,15 @@ static void tt_atlantis_soc_realize(DeviceState
>> *dev, Error **errp)
>>           &ac->memory, ac->memmap[TT_ATL_PRCM_MM].base,
>>           sysbus_mmio_get_region(
>>               SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_MM]),
>> 0));
>> +    if (s->has_rcpu) {
>> +        create_device_alias(OBJECT(s), &rc->memory,
>> +                            DEVICE(&s-
>>> prcm[TT_ATLANTIS_PRCM_DOMAIN_MM]),
>> +                            rc->memmap[TT_ATL_PRCM_MM].size,
>> +                            rc->memmap[TT_ATL_PRCM_MM].base,
>> +                            "tt-rcpu.rcpu-mm");
>> +    }
>>   
>> -    /* UART1, the soc console (UART0 is for the boot
>> microcontroller) */
>> +    /* UART1, the soc console */
>>       qdev_prop_set_chr(DEVICE(&s-
>>> uart[tt_atlantis_uart_index(TT_ATL_UART1)]),
>>                         "chardev", serial_hd(0));
>>   
>> @@ -761,6 +978,16 @@ static void tt_atlantis_soc_realize(DeviceState
>> *dev, Error **errp)
>>                                       sysbus_mmio_get_region(sbd, 0));
>>           sysbus_connect_irq(sbd, 0,
>>                              qdev_get_gpio_in(s->irqchip,
>> TT_ATL_UART0_IRQ + i));
>> +
>> +        if (s->has_rcpu) {
>> +            /* Alias the devices to the rcpu memory view */
>> +            g_autofree char *name = g_strdup_printf("tt-
>> rcpu.uart%d", i);
>> +
>> +            create_device_alias(OBJECT(s), &rc->memory, DEVICE(&s-
>>> uart[i]),
>> +                                rc->memmap[TT_ATL_UART0 + i].size,
>> +                                rc->memmap[TT_ATL_UART0 + i].base,
>> +                                name);
>> +        }
>>       }
>>   
>>       /* I2C */
>> @@ -781,6 +1008,7 @@ static void tt_atlantis_soc_realize(DeviceState
>> *dev, Error **errp)
>>   static const Property tt_atlantis_soc_props[] = {
>>       DEFINE_PROP_LINK("dram", TTAtlantisSoCState, dram,
>>                        TYPE_MEMORY_REGION, MemoryRegion *),
>> +    DEFINE_PROP_BOOL("has-rcpu", TTAtlantisSoCState, has_rcpu,
>> false)
>>   };
>>   
>>   static void tt_atlantis_soc_class_init(ObjectClass *oc, const void
>> *data)
>> @@ -798,20 +1026,44 @@ static void
>> tt_atlantis_machine_init(MachineState *machine)
>>       TTAtlantisState *ams = TT_ATLANTIS_MACHINE(machine);
>>       TTAtlantisSoCState *s = &ams->soc;
>>       TTAscalonClusterState *ac = &s->ascalon;
>> +    uint32_t num_asc_harts;
>>   
>>       object_initialize_child(OBJECT(machine), "soc", &ams->soc,
>>                               TYPE_TT_ATLANTIS_SOC);
>>   
>> -    /* User input machine properties, cpu_type and smp.cpus apply to
>> Ascalon */
>> +    /*
>> +     * The smp must include the RCPU since smp.cpus limits the total
>> number of
>> +     * CPUs that TCG creates. If RCPU is enabled, remove it from the
>> hart count
>> +     * passed to Ascalon.
>> +     */
>> +    if (ams->has_rcpu) {
>> +        if (machine->smp.cpus <= 1) {
>> +            error_report("smp.cpus must be at least 2 when RCPU is
>> enabled. " \
>> +                         "Run with ,rcpu=off to disable RCPU.");
>> +            exit(1);
>> +        }
>> +        num_asc_harts = machine->smp.cpus - 1;
>> +    } else {
>> +        if (machine->smp.cpus > 8) {
>> +            error_report("smp.cpus must be 8 or less when RCPU is
>> not enabled. " \
>> +                         "Run with ,rcpu=off -smp cpus=8 for 8
>> Ascalon cores " \
>> +                         "and no RCPU.");
>> +            exit(1);
>> +        }
>> +        num_asc_harts = machine->smp.cpus;
>> +    }
>> +
>>       object_property_set_str(OBJECT(ac), "cpu-type",
>>                               machine->cpu_type,
>>                               &error_abort);
>>       object_property_set_int(OBJECT(ac), "num-harts",
>> -                            machine->smp.cpus,
>> +                            num_asc_harts,
>>                               &error_abort);
>>   
>>       object_property_set_link(OBJECT(s), "dram", OBJECT(machine-
>>> ram),
>>                                &error_abort);
>> +    object_property_set_bool(OBJECT(&ams->soc), "has-rcpu", ams-
>>> has_rcpu,
>> +                             &error_abort);
>>   
>>       qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
>>   
>> @@ -830,19 +1082,47 @@ static void
>> tt_atlantis_machine_init(MachineState *machine)
>>       qemu_add_machine_init_done_notifier(&ams->machine_done);
>>   }
>>   
>> +static bool tt_atlantis_machine_get_rcpu(Object *obj, Error **errp)
>> +{
>> +    TTAtlantisState *s = TT_ATLANTIS_MACHINE(obj);
>> +
>> +    return s->has_rcpu;
>> +}
>> +
>> +static void tt_atlantis_machine_set_rcpu(Object *obj, bool value,
>> Error **errp)
>> +{
>> +    TTAtlantisState *s = TT_ATLANTIS_MACHINE(obj);
>> +
>> +    s->has_rcpu = value;
>> +}
>> +
>>   static void tt_atlantis_machine_class_init(ObjectClass *oc, const
>> void *data)
>>   {
>>       MachineClass *mc = MACHINE_CLASS(oc);
>> +    ObjectProperty *prop;
>>   
>>       mc->desc = "Tenstorrent Atlantis RISC-V SoC (Experimental)";
>>       mc->init = tt_atlantis_machine_init;
>> -    mc->max_cpus = 8;
>> -    mc->default_cpus = 8;
>> +    /*
>> +     * The smp count must include the RCPU since tcg limits the
>> number of
>> +     * threads created based on it. When rcpu=on, the number of
>> Ascalon harts
>> +     * created is smp.cpus - 1. When rcpu=off, the number of Ascalon
>> harts is
>> +     * smp.cpus.
>> +     */
>> +    mc->max_cpus = 9;
>> +    mc->default_cpus = 8; /* Default to no RCPU */
>>       mc->default_ram_size = 4 * GiB;
>>       mc->default_cpu_type = TYPE_RISCV_CPU_TT_ASCALON;
>>       mc->block_default_type = IF_VIRTIO;
>>       mc->no_cdrom = 1;
>>       mc->default_ram_id = "tt_atlantis.ram";
>> +
>> +    prop = object_class_property_add_bool(oc, "rcpu",
>> tt_atlantis_machine_get_rcpu,
>> +                                   tt_atlantis_machine_set_rcpu);
>> +    object_class_property_set_description(oc, "rcpu",
>> +                                          "Set to enable/disable
>> modeling the RCPU.");
>> +    object_property_set_default_bool(prop, false);
> 
> Do we actually need this? It seems confusing to users.
> 
> If I run `./qemu-system-riscv64 -M tt-atlantis ...` I get a system with
> 8 Ascalon cores.
> 
> Then if I run `./qemu-system-riscv64 -M tt-atlantis,rcpu=true ...` I
> now have 7 Ascalon cores (and 1 RCPU). That seems confusing and doesn't
> appear to be clearly documented.
> 
> I feel like just detecting SMP 9 means RCPU and 8 Ascalon is a better
> bet. Or at least good documentation and maybe even a warning?


So I went through and implemented this a couple ways and I still think 
this is least bad way.

My goal is to keep the current command line interface the same, so by 
default the user gets 8 Ascalon cores and no rcpu. I do think we need an 
explicit machine flag to say the rcpu is enabled. We want to support 1 
Ascalon core + rcpu and in the future enabling the rcpu will lead to a 
different boot flow. For example, without the rcpu the user can use 
-kernel and -bios option to boot Asaclon. In the future, enabling RCPU 
will require the user to provide the firmware payload via an SD or NOR 
drive. I will mark the flag as experiemental in the next series since 
the rcpu boot is not fully supported yet.

There isn't a way to detect if the user has overriden the default smp 
count which makes a warning difficult, I could add a warning if only 7 
Ascalon cores are enabled. This isn't actually invalid but it is an 
usual number of Ascalon cpus to select and the most likely incorrect usage.

I will update the docuemntation to say the user should specify the smp 
count as 9 when enabling the RCPU, I should of had this in this patch 
series. If the RCPU is disabled by default, enabling it requires 
knowledge of the system (or at least looking at the docuementation) and 
it seems reasonable, even if unideal, to expect the user to provide -smp 9.
> 
> Alistair
> 
>> +
>>   }
>>   
>>   static const TypeInfo tt_atlantis_types[] = {
>> @@ -852,6 +1132,12 @@ static const TypeInfo tt_atlantis_types[] = {
>>           .instance_size = sizeof(TTAscalonClusterState),
>>           .instance_init = tt_ascalon_cluster_init,
>>           .class_init = tt_ascalon_cluster_class_init,
>> +    }, {
>> +        .name       = TYPE_TT_RCPU_CLUSTER,
>> +        .parent     = TYPE_DEVICE,
>> +        .instance_size = sizeof(TTRCPUClusterState),
>> +        .instance_init = tt_rcpu_cluster_init,
>> +        .class_init = tt_rcpu_cluster_class_init,
>>       }, {
>>           .name       = TYPE_TT_ATLANTIS_SOC,
>>           .parent     = TYPE_DEVICE,
>> diff --git a/include/hw/riscv/tt_atlantis.h
>> b/include/hw/riscv/tt_atlantis.h
>> index e5fce1f675..5a200410f3 100644
>> --- a/include/hw/riscv/tt_atlantis.h
>> +++ b/include/hw/riscv/tt_atlantis.h
>> @@ -16,6 +16,7 @@
>>   #include "hw/misc/tt_atlantis_prcm.h"
>>   #include "hw/char/dw8250.h"
>>   #include "hw/cpu/cluster.h"
>> +#include "hw/misc/unimp.h"
>>   #include "hw/riscv/riscv_hart.h"
>>   
>>   #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
>> @@ -27,6 +28,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisSoCState,
>> TT_ATLANTIS_SOC)
>>   #define TYPE_TT_ASCALON_CLUSTER "riscv.tt-ascalon-cluster"
>>   OBJECT_DECLARE_SIMPLE_TYPE(TTAscalonClusterState,
>> TT_ASCALON_CLUSTER)
>>   
>> +#define TYPE_TT_RCPU_CLUSTER "riscv.tt-rcpu-cluster"
>> +OBJECT_DECLARE_SIMPLE_TYPE(TTRCPUClusterState, TT_RCPU_CLUSTER)
>> +
>>   #define TT_ATL_NUM_I2C 5
>>   #define TT_ATL_NUM_PRCM 4
>>   #define TT_ATL_NUM_UARTS 5
>> @@ -48,12 +52,27 @@ struct TTAscalonClusterState {
>>       char *cpu_type;
>>   };
>>   
>> +struct TTRCPUClusterState {
>> +    /*< private >*/
>> +    DeviceState parent;
>> +
>> +    /*< public >*/
>> +    const MemMapEntry *memmap;
>> +    MemoryRegion memory;
>> +
>> +    RISCVHartArrayState cpus;
>> +    CPUClusterState cluster;
>> +    MemoryRegion bootrom;
>> +    MemoryRegion sram;
>> +};
>> +
>>   struct TTAtlantisSoCState {
>>       /*< private >*/
>>       DeviceState parent;
>>   
>>       /*< public >*/
>>       TTAscalonClusterState ascalon;
>> +    TTRCPUClusterState rcpu;
>>   
>>       MemoryRegion *dram;
>>       MemoryRegion ram_hi;
>> @@ -63,6 +82,8 @@ struct TTAtlantisSoCState {
>>       DesignWareI2CState i2c[TT_ATL_NUM_I2C];
>>       DW8250State uart[TT_ATL_NUM_UARTS];
>>       TTAtlantisPRCMState prcm[TT_ATL_NUM_PRCM];
>> +
>> +    bool has_rcpu;              /* Enable RCPU */
>>   };
>>   
>>   struct TTAtlantisState {
>> @@ -73,6 +94,8 @@ struct TTAtlantisState {
>>       Notifier machine_done;
>>   
>>       TTAtlantisSoCState soc;
>> +
>> +    bool has_rcpu;              /* Enable RCPU */
>>   };
>>   
>>   enum {
>> @@ -93,15 +116,28 @@ enum {
>>       TT_ATL_BOOTROM,
>>       TT_ATL_DDR_LO,
>>       TT_ATL_DDR_HI,
>> +    TT_ATL_GPIO,
>>       TT_ATL_I2C0,
>>       TT_ATL_I2C1,
>>       TT_ATL_I2C2,
>>       TT_ATL_I2C3,
>>       TT_ATL_I2C4,
>> +    TT_ATL_IO_CTRL,
>>       TT_ATL_MAPLIC,
>>       TT_ATL_MIMSIC,
>> +    TT_ATL_NOCM_FIREWALL,
>> +    TT_ATL_OTP,
>> +    TT_ATL_QSPI,
>> +    TT_ATL_RCPU_CLIC,
>> +    TT_ATL_RCPU_CLINT,
>> +    TT_ATL_RCPU_MAILBOX,
>> +    TT_ATL_RCPU_SMN_FIREWALL,
>> +    TT_ATL_RCPU_SRAM,
>>       TT_ATL_SAPLIC,
>> +    TT_ATL_SDHCI0,
>> +    TT_ATL_SDHCI1,
>>       TT_ATL_SIMSIC,
>> +    TT_ATL_SPACC,
>>       TT_ATL_UART0,
>>       TT_ATL_UART1,
>>       TT_ATL_UART2,
>> @@ -111,6 +147,14 @@ enum {
>>       TT_ATL_PRCM_HSIO,
>>       TT_ATL_PRCM_PCIE,
>>       TT_ATL_PRCM_MM,
>> +    TT_ATL_PRCM_ASC,
>> +    TT_ATL_PRCM_DDR0,
>> +    TT_ATL_PRCM_DDR1,
>> +    TT_ATL_DDRC0_CTRL,
>> +    TT_ATL_DDRC1_CTRL,
>> +    TT_ATL_PRCM_TRNG,
>> +    TT_ATL_WDT0,
>> +    TT_ATL_WDT1,
>>   };
>>   
>>   /*


