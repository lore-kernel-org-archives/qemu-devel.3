Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AA5C87FCB
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 16:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukmbh-0005bR-HJ; Sat, 09 Aug 2025 12:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukmbe-0005Zy-UE
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 12:39:43 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukmbb-0003c0-72
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 12:39:42 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-23c8f179e1bso41863075ad.1
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1754757577; x=1755362377; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HFJgI2ugXTAC8a5i2+VWDcIWxEZUl1vWZ1nA7BGb2D4=;
 b=k8H/8daZQEUEPtE3UIQEaRPZysWkfBoLmnW95jRhfCL/j2kaUzWHVOwDeu8KXnG/ft
 VzQ7UQh+HPBn/HSM/A8kSrkAP7Lvq2kg47nRjnPIHGvLTRYFBluazSkBTOtxZoFOYOMF
 6DVrT8LK29GlJrjI4WIdcz9Y3p1EmRJoHZkWm3CeVGT9P/+vwGkHMlEGEpKZ4pP5YLh3
 62U8oqeaIHutTlckomHqoTOfbMcWtqvrtSqGsH8LfSyYgkwuZ+tJ8hMULkIPJE7KccP3
 I8Tndo/l1hye4pS9/yU6baVHD6d1fVG0+6RDmix6EVuEpaqDkbiq0tzbAvTZhytg3Ioj
 EjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754757577; x=1755362377;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HFJgI2ugXTAC8a5i2+VWDcIWxEZUl1vWZ1nA7BGb2D4=;
 b=CVWA12peLVOWnfROQkx7Rf+6kpEEeuy7jBdLGYhpSI6rV7jg+SdyXYXfB+qWd64KIr
 DfuMcIKIDjI9wb+5ECymMrMltg4QQps37wNHtMJbUPFkQUcO5EmsAMI2DhOa0JN+B24s
 w0dd0LnzdEgyJQpRmiuNvA0M0k5SXmk7Hu37123Bc3hH8zoFIgongO8lTVGZdE1Pri7z
 vSa/1c1yxunAwTL+E3IS2aiCbvlAV8NFdvBXOon8ARbQuSpCkKQquNfTWh4FEpyHPSL2
 RSdq3R5AqCLRobF8EI83dUmmnirxPsIa3m+DIF70O6sjP5izfrfGQagLw8KKoWooF5FD
 s6eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsU4VMNE+LItU5LAn3I/0oTU9kPZrI3GysI7nrO5zrLFvdSRWkDkQZtVWCJg/2LqF5gEg8F6DY3P1u@nongnu.org
X-Gm-Message-State: AOJu0YypyOI/1NZ1Hpzzuvyc+acJ1dHDt2S/r+LsYQwpi+v9OXsTmFEu
 HvwqmP9tijMMWqYQChHgCpUPgPkecPuVWwnu18IUH1qT9QYSU1wmdFH/8KZjTGRfvUs=
X-Gm-Gg: ASbGnct0wiXM2m32C9b7bMjBEGvaYqhGrSfu4OHGWQnUSSdu6BufEetoGPpDLdZol83
 2e9uud9jnApT8kw9f67SeXBw91onM1hsjvby8ZANYQ+m5kH3LkX9oZx4OnLufp5IY5JNDDXWqO7
 cB+dhJEoh1LChNyT/qfxce3zpVR8tP6h0gz1IGATc0O8Z8I4eQotXzSZEmagQQ6OBKv+RLvqYX1
 d5J3eMmtAELDKJq1jm9uykKY9gpGerc6uX4Y9E/PKpWziqa3ux6LbfZdVs7ZFuGswcWLMgz6TU8
 +zvyZRkgX/rD0zvEUpSuriYb3koPZT0IgJBVtoX2zsiZubjiO2IWAgNfkPRvdPdPljoqaas0rEZ
 j3C9d+x4Kkg5PayYYrzeAgztC5Gl47CFzc3vHsg==
X-Google-Smtp-Source: AGHT+IE+fk52r5xu/emUzR5O4V9Vw+HuckASvFVd0GPCN0BqyiwhLZMv0hsFnOot4DqaLMBFAsd36w==
X-Received: by 2002:a17:902:d481:b0:223:619e:71da with SMTP id
 d9443c01a7336-242c225767emr119650755ad.49.1754757577379; 
 Sat, 09 Aug 2025 09:39:37 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.127.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899a909sm231663125ad.123.2025.08.09.09.39.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Aug 2025 09:39:36 -0700 (PDT)
Message-ID: <efccad5e-d5a8-4ebe-b2ae-1b683239399d@ventanamicro.com>
Date: Sat, 9 Aug 2025 13:39:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/18] hw/misc: riscv_wgchecker: Implement RISC-V
 WorldGuard Checker
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <20250417105249.18232-1-jim.shu@sifive.com>
 <20250417105249.18232-15-jim.shu@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250417105249.18232-15-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 4/17/25 7:52 AM, Jim Shu wrote:
> Implement the RISC-V WorldGuard Checker, which sits in front of RAM or
> device MMIO and allow software to configure it to either pass through or
> reject transactions.
> 
> We implement the wgChecker as a QEMU IOMMU, which will direct transactions
> either through to the devices and memory behind it or to a special
> "never works" AddressSpace if they are blocked.
> 
> This initial commit implements the skeleton of the device:
>   * it always permits accesses
>   * it doesn't implement wgChecker's slot registers
>   * it doesn't implement the interrupt or other behaviour
>     for blocked transactions
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>   hw/misc/meson.build                |   2 +-
>   hw/misc/riscv_wgchecker.c          | 603 +++++++++++++++++++++++++++++
>   hw/misc/trace-events               |   8 +
>   include/hw/misc/riscv_worldguard.h |  63 +++
>   4 files changed, 675 insertions(+), 1 deletion(-)
>   create mode 100644 hw/misc/riscv_wgchecker.c
> 
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 3d2f4bb6a3..73c11bc7c9 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -34,7 +34,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
> -specific_ss.add(when: 'CONFIG_RISCV_WORLDGUARD', if_true: files('riscv_worldguard.c'))
> +specific_ss.add(when: 'CONFIG_RISCV_WORLDGUARD', if_true: files('riscv_worldguard.c', 'riscv_wgchecker.c'))
>   
>   subdir('macio')
>   
> diff --git a/hw/misc/riscv_wgchecker.c b/hw/misc/riscv_wgchecker.c
> new file mode 100644
> index 0000000000..ea50f4f53a
> --- /dev/null
> +++ b/hw/misc/riscv_wgchecker.c
> @@ -0,0 +1,603 @@

(...)

> +
> +static void riscv_wgchecker_realize(DeviceState *dev, Error **errp)
> +{
> +    Object *obj = OBJECT(dev);
> +    RISCVWgCheckerState *s = RISCV_WGCHECKER(dev);
> +    uint64_t size;
> +
> +    if (worldguard_config == NULL) {
> +        error_setg(errp, "Couldn't find global WorldGuard configs. "
> +                   "Please realize %s device at first.",

Extra "at":  "Please realize %s device first."


Everything else LGTM:


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

> +                   TYPE_RISCV_WORLDGUARD);
> +        return;
> +    }
> +
> +    if (s->slot_count == 0) {
> +        error_setg(errp, "wgChecker slot-count couldn't be zero.");
> +        return;
> +    }
> +
> +    memory_region_init_io(&s->mmio, OBJECT(dev), &riscv_wgchecker_ops, s,
> +                          TYPE_RISCV_WGCHECKER, s->mmio_size);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
> +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
> +
> +    /* Address range should be NAPOT alignment */
> +    address_range_align_napot(s);
> +
> +    for (int i=0; i<WGC_NUM_REGIONS; i++) {
> +        WgCheckerRegion *region = &s->mem_regions[i];
> +
> +        if (!region->downstream) {
> +            continue;
> +        }
> +        region->wgchecker = s;
> +
> +        const char *upstream_name = g_strdup_printf(
> +            "wgchecker-upstream-%"HWADDR_PRIx, region->region_offset);
> +        const char *downstream_name = g_strdup_printf(
> +            "wgchecker-downstream-%"HWADDR_PRIx, region->region_offset);
> +
> +        size = memory_region_size(region->downstream);
> +        memory_region_init_iommu(&region->upstream, sizeof(region->upstream),
> +                                 TYPE_RISCV_WGC_IOMMU_MEMORY_REGION,
> +                                 obj, upstream_name, size);
> +
> +        /* upstream MRs are 2nd ~ (n+1)th MemoryRegion. */
> +        sysbus_init_mmio(SYS_BUS_DEVICE(dev), MEMORY_REGION(&region->upstream));
> +
> +        /*
> +         * This memory region is not exposed to users of this device as a
> +         * sysbus MMIO region, but is instead used internally as something
> +         * that our IOMMU translate function might direct accesses to.
> +         */
> +        memory_region_init_io(&region->blocked_io, obj, &riscv_wgc_mem_blocked_ops,
> +                              region, "wgchecker-blocked-io", size);
> +
> +        address_space_init(&region->downstream_as, region->downstream,
> +                           downstream_name);
> +        address_space_init(&region->blocked_io_as, &region->blocked_io,
> +                           "wgchecker-blocked-io");
> +    }
> +}
> +
> +static void riscv_wgchecker_unrealize(DeviceState *dev)
> +{
> +    RISCVWgCheckerState *s = RISCV_WGCHECKER(dev);
> +
> +    g_free(s->slots);
> +    if (s->num_default_slots && s->default_slots) {
> +        g_free(s->default_slots);
> +    }
> +}
> +
> +static void riscv_wgchecker_reset_enter(Object *obj, ResetType type)
> +{
> +    RISCVWgCheckerState *s = RISCV_WGCHECKER(obj);
> +    uint64_t start = s->addr_range_start;
> +    uint64_t end = s->addr_range_start + s->addr_range_size;
> +    int nslots = s->slot_count;
> +
> +    s->errcause = 0;
> +    s->erraddr = 0;
> +}
> +
> +static void riscv_wgchecker_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    device_class_set_props(dc, riscv_wgchecker_properties);
> +    dc->user_creatable = true;
> +    dc->realize = riscv_wgchecker_realize;
> +    dc->unrealize = riscv_wgchecker_unrealize;
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    rc->phases.enter = riscv_wgchecker_reset_enter;
> +}
> +
> +static void riscv_wgchecker_instance_init(Object *obj)
> +{
> +    RISCVWgCheckerState *s = RISCV_WGCHECKER(obj);
> +
> +    s->num_default_slots = 0;
> +}
> +
> +static const TypeInfo riscv_wgchecker_info = {
> +    .name          = TYPE_RISCV_WGCHECKER,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_init = riscv_wgchecker_instance_init,
> +    .instance_size = sizeof(RISCVWgCheckerState),
> +    .class_init    = riscv_wgchecker_class_init,
> +};
> +
> +static void riscv_wgchecker_register_types(void)
> +{
> +    type_register_static(&riscv_wgchecker_info);
> +    type_register_static(&riscv_wgc_iommu_memory_region_info);
> +}
> +
> +type_init(riscv_wgchecker_register_types)
> +
> +/*
> + * Create WgChecker device
> + */
> +DeviceState *riscv_wgchecker_create(hwaddr addr, uint32_t size,
> +                                    qemu_irq irq, uint32_t slot_count,
> +                                    uint64_t addr_range_start,
> +                                    uint64_t addr_range_size,
> +                                    uint32_t num_of_region,
> +                                    MemoryRegion **downstream,
> +                                    uint64_t *region_offset,
> +                                    uint32_t num_default_slots,
> +                                    WgCheckerSlot *default_slots)
> +{
> +    DeviceState *dev = qdev_new(TYPE_RISCV_WGCHECKER);
> +    RISCVWgCheckerState *s = RISCV_WGCHECKER(dev);
> +    char name_mr[32];
> +    char name_offset[32];
> +    int i;
> +
> +    qdev_prop_set_uint32(dev, "slot-count", slot_count);
> +    qdev_prop_set_uint32(dev, "mmio-size", size);
> +    qdev_prop_set_uint64(dev, "addr-range-start", addr_range_start);
> +    if (addr_range_size) {
> +        qdev_prop_set_uint64(dev, "addr-range-size", addr_range_size);
> +    }
> +
> +    g_assert(num_of_region <= WGC_NUM_REGIONS);
> +    for (i=0; i<num_of_region; i++) {
> +        snprintf(name_mr, 32, "downstream-mr[%d]", i);
> +        snprintf(name_offset, 32, "region-offset[%d]", i);
> +
> +        object_property_set_link(OBJECT(dev), name_mr,
> +                                 OBJECT(downstream[i]), &error_fatal);
> +        qdev_prop_set_uint64(dev, name_offset, region_offset[i]);
> +    }
> +
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
> +    return dev;
> +}
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 4383808d7a..b1d8538220 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -395,3 +395,11 @@ ivshmem_flat_interrupt_peer(uint16_t peer_id, uint16_t vector_id) "Interrupting
>   i2c_echo_event(const char *id, const char *event) "%s: %s"
>   i2c_echo_recv(const char *id, uint8_t data) "%s: recv 0x%02" PRIx8
>   i2c_echo_send(const char *id, uint8_t data) "%s: send 0x%02" PRIx8
> +
> +# riscv_worldguard.c
> +riscv_wgchecker_mmio_read(uint64_t base, uint64_t offset, unsigned int size) "base = 0x%"PRIx64", offset = 0x%"PRIx64", size = 0x%x"
> +riscv_wgchecker_mmio_write(uint64_t base, uint64_t offset, unsigned int size, uint64_t val) "base = 0x%"PRIx64", offset = 0x%"PRIx64", size = 0x%x, val = 0x%"PRIx64
> +
> +riscv_wgc_mem_blocked_read(uint64_t addr, unsigned size, uint32_t wid) "wgChecker blocked read: offset 0x%" PRIx64 " size %u wid %" PRIu32
> +riscv_wgc_mem_blocked_write(uint64_t addr, uint64_t data, unsigned size, uint32_t wid) "wgChecker blocked write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u wid %" PRIu32
> +riscv_wgc_translate(uint64_t addr, int flags, int wid, const char *res) "wgChecker translate: addr 0x%016" PRIx64 " flags 0x%x wid %d: %s"
> diff --git a/include/hw/misc/riscv_worldguard.h b/include/hw/misc/riscv_worldguard.h
> index 211a72e438..7b5aae866a 100644
> --- a/include/hw/misc/riscv_worldguard.h
> +++ b/include/hw/misc/riscv_worldguard.h
> @@ -53,4 +53,67 @@ void riscv_worldguard_apply_cpu(uint32_t hartid);
>   uint32_t mem_attrs_to_wid(MemTxAttrs attrs);
>   bool could_access_wgblocks(MemTxAttrs attrs, const char *wgblock);
>   
> +#define TYPE_RISCV_WGCHECKER  "riscv.wgchecker"
> +
> +typedef struct RISCVWgCheckerState RISCVWgCheckerState;
> +DECLARE_INSTANCE_CHECKER(RISCVWgCheckerState, RISCV_WGCHECKER,
> +                         TYPE_RISCV_WGCHECKER)
> +
> +#define TYPE_RISCV_WGC_IOMMU_MEMORY_REGION    "riscv-wgc-iommu-memory-region"
> +
> +typedef struct WgCheckerSlot WgCheckerSlot;
> +struct WgCheckerSlot {
> +    uint64_t addr;
> +    uint64_t perm;
> +    uint32_t cfg;
> +};
> +
> +typedef struct WgCheckerRegion WgCheckerRegion;
> +struct WgCheckerRegion {
> +    MemoryRegion *downstream;
> +    uint64_t region_offset;
> +
> +    IOMMUMemoryRegion upstream;
> +    MemoryRegion blocked_io;
> +    AddressSpace downstream_as;
> +    AddressSpace blocked_io_as;
> +
> +    RISCVWgCheckerState *wgchecker;
> +};
> +
> +#define WGC_NUM_REGIONS     16
> +
> +struct RISCVWgCheckerState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    MemoryRegion mmio;
> +    qemu_irq irq;
> +
> +    /* error reg */
> +    uint64_t errcause;
> +    uint64_t erraddr;
> +
> +    /* Memory regions protected by wgChecker */
> +    WgCheckerRegion mem_regions[WGC_NUM_REGIONS];
> +
> +    /* Property */
> +    uint32_t slot_count; /* nslots */
> +    uint32_t mmio_size;
> +    uint64_t addr_range_start;
> +    uint64_t addr_range_size;
> +    bool hw_bypass;
> +};
> +
> +DeviceState *riscv_wgchecker_create(hwaddr addr, uint32_t size,
> +                                    qemu_irq irq, uint32_t slot_count,
> +                                    uint64_t addr_range_start,
> +                                    uint64_t addr_range_size,
> +                                    uint32_t num_of_region,
> +                                    MemoryRegion **downstream,
> +                                    uint64_t *region_offset,
> +                                    uint32_t num_default_slots,
> +                                    WgCheckerSlot *default_slots);
> +
>   #endif


