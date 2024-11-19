Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE733D60D1B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 10:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDL7K-0006p5-Sc; Tue, 19 Nov 2024 05:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tDL7G-0006ox-KV
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 05:05:50 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tDL79-0007UF-6W
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 05:05:48 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Ax6+HzYjxn815CAA--.64289S3;
 Tue, 19 Nov 2024 18:05:39 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMDxfUfyYjxn6DJdAA--.27846S3;
 Tue, 19 Nov 2024 18:05:39 +0800 (CST)
Subject: Re: [PATCH v4 5/6] hw/loongarch/virt: Update the ACPI table for
 hotplug cpu
To: Igor Mammedov <imammedo@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
References: <20241112021738.1952851-1-maobibo@loongson.cn>
 <20241112021738.1952851-6-maobibo@loongson.cn>
 <20241118175139.510424ad@imammedo.users.ipa.redhat.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <bec61441-f11e-2671-7bd6-4fed3984a10f@loongson.cn>
Date: Tue, 19 Nov 2024 18:05:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20241118175139.510424ad@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxfUfyYjxn6DJdAA--.27846S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3GryUXF4DJF17KF4kKF1fXwc_yoW7tF15pF
 WkAFs3tF48WFyfJ39aq3s0gFn5trn7GwsF9F4xKrySkF97Cr18WF10ywsxCFWDJws7X3Wv
 va4qqay7WF47tFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jY
 38nUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.492,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 2024/11/19 上午12:51, Igor Mammedov wrote:
> On Tue, 12 Nov 2024 10:17:37 +0800
> Bibo Mao <maobibo@loongson.cn> wrote:
> 
>> On LoongArch virt machine, ACPI GED hardware is used for CPU hotplug
>> handler, here CPU hotplug support feature is added based on GED handler,
>> also CPU scan and reject method is added about CPU device in DSDT table.
>>
>> Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   hw/loongarch/Kconfig        |  1 +
>>   hw/loongarch/acpi-build.c   | 35 +++++++++++++++++++++++++++++++++--
>>   hw/loongarch/virt.c         | 10 ++++++++++
>>   include/hw/loongarch/virt.h |  1 +
>>   4 files changed, 45 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
>> index fe1c6feac1..bb2838b7b5 100644
>> --- a/hw/loongarch/Kconfig
>> +++ b/hw/loongarch/Kconfig
>> @@ -17,6 +17,7 @@ config LOONGARCH_VIRT
>>       select LOONGARCH_EXTIOI
>>       select LS7A_RTC
>>       select SMBIOS
>> +    select ACPI_CPU_HOTPLUG
>>       select ACPI_PCI
>>       select ACPI_HW_REDUCED
>>       select FW_CFG_DMA
>> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
>> index 50709bda0f..c220edec68 100644
>> --- a/hw/loongarch/acpi-build.c
>> +++ b/hw/loongarch/acpi-build.c
>> @@ -47,6 +47,22 @@
>>   #define ACPI_BUILD_DPRINTF(fmt, ...)
>>   #endif
>>   
>> +static void virt_madt_cpu_entry(int uid,
>> +                                const CPUArchIdList *apic_ids,
>> +                                GArray *entry, bool force_enabled)
>> +{
>> +    uint32_t flags, apic_id = apic_ids->cpus[uid].arch_id;
>> +
>> +    flags = apic_ids->cpus[uid].cpu || force_enabled ? 1 /* Enabled */ : 0;
>> +
>> +    /* Rev 1.0b, Table 5-13 Processor Local APIC Structure */
>> +    build_append_int_noprefix(entry, 0, 1);       /* Type */
>> +    build_append_int_noprefix(entry, 8, 1);       /* Length */
>> +    build_append_int_noprefix(entry, uid, 1);     /* ACPI Processor ID */
>> +    build_append_int_noprefix(entry, apic_id, 1); /* APIC ID */
> 
> is it really APIC ID or just copy paste mistake from x86?
That is copied from x86, from ACPI spec it is "Physical Processor ID", 
will modify it in next patch.

Regards
Bibo Mao
> 
> 
>> +    build_append_int_noprefix(entry, flags, 4); /* Flags */
>> +}
>> +
>>   /* build FADT */
>>   static void init_common_fadt_data(AcpiFadtData *data)
>>   {
>> @@ -123,15 +139,17 @@ build_madt(GArray *table_data, BIOSLinker *linker,
>>       build_append_int_noprefix(table_data, 1 /* PCAT_COMPAT */, 4); /* Flags */
>>   
>>       for (i = 0; i < arch_ids->len; i++) {
>> +        uint32_t flags;
>> +
>>           /* Processor Core Interrupt Controller Structure */
>>           arch_id = arch_ids->cpus[i].arch_id;
>> -
>> +        flags   = arch_ids->cpus[i].cpu ? 1 : 0;
>>           build_append_int_noprefix(table_data, 17, 1);    /* Type */
>>           build_append_int_noprefix(table_data, 15, 1);    /* Length */
>>           build_append_int_noprefix(table_data, 1, 1);     /* Version */
>>           build_append_int_noprefix(table_data, i, 4);     /* ACPI Processor ID */
>>           build_append_int_noprefix(table_data, arch_id, 4); /* Core ID */
>> -        build_append_int_noprefix(table_data, 1, 4);     /* Flags */
>> +        build_append_int_noprefix(table_data, flags, 4); /* Flags */
>>       }
>>   
>>       /* Extend I/O Interrupt Controller Structure */
>> @@ -334,6 +352,7 @@ build_la_ged_aml(Aml *dsdt, MachineState *machine)
>>   {
>>       uint32_t event;
>>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
>> +    CPUHotplugFeatures opts;
>>   
>>       build_ged_aml(dsdt, "\\_SB."GED_DEVICE,
>>                     HOTPLUG_HANDLER(lvms->acpi_ged),
>> @@ -346,6 +365,18 @@ build_la_ged_aml(Aml *dsdt, MachineState *machine)
>>                                    AML_SYSTEM_MEMORY,
>>                                    VIRT_GED_MEM_ADDR);
>>       }
>> +
>> +    if (event & ACPI_GED_CPU_HOTPLUG_EVT) {
>> +        opts.acpi_1_compatible = false;
>> +        opts.has_legacy_cphp = false;
>> +        opts.fw_unplugs_cpu = false;
>> +        opts.smi_path = NULL;
>> +
>> +        build_cpus_aml(dsdt, machine, opts, virt_madt_cpu_entry,
>> +                       VIRT_GED_CPUHP_ADDR, "\\_SB",
>> +                       AML_GED_EVT_CPU_SCAN_METHOD, AML_SYSTEM_MEMORY);
>> +    }
>> +
>>       acpi_dsdt_add_power_button(dsdt);
>>   }
>>   
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index 0e0c6c202b..b49b15c0f6 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -666,11 +666,17 @@ static DeviceState *create_acpi_ged(DeviceState *pch_pic,
>>   {
>>       DeviceState *dev;
>>       MachineState *ms = MACHINE(lvms);
>> +    MachineClass *mc = MACHINE_GET_CLASS(lvms);
>>       uint32_t event = ACPI_GED_PWR_DOWN_EVT;
>>   
>>       if (ms->ram_slots) {
>>           event |= ACPI_GED_MEM_HOTPLUG_EVT;
>>       }
>> +
>> +    if (mc->has_hotpluggable_cpus) {
>> +        event |= ACPI_GED_CPU_HOTPLUG_EVT;
>> +    }
>> +
>>       dev = qdev_new(TYPE_ACPI_GED);
>>       qdev_prop_set_uint32(dev, "ged-event", event);
>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>> @@ -682,6 +688,10 @@ static DeviceState *create_acpi_ged(DeviceState *pch_pic,
>>       /* ged regs used for reset and power down */
>>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, VIRT_GED_REG_ADDR);
>>   
>> +    if (mc->has_hotpluggable_cpus) {
>> +        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 3, VIRT_GED_CPUHP_ADDR);
>> +    }
>> +
>>       sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
>>                          qdev_get_gpio_in(pch_pic, VIRT_SCI_IRQ - VIRT_GSI_BASE));
>>       return dev;
>> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
>> index 260e6bd7cf..79a85723c9 100644
>> --- a/include/hw/loongarch/virt.h
>> +++ b/include/hw/loongarch/virt.h
>> @@ -30,6 +30,7 @@
>>   #define VIRT_GED_EVT_ADDR       0x100e0000
>>   #define VIRT_GED_MEM_ADDR       (VIRT_GED_EVT_ADDR + ACPI_GED_EVT_SEL_LEN)
>>   #define VIRT_GED_REG_ADDR       (VIRT_GED_MEM_ADDR + MEMORY_HOTPLUG_IO_LEN)
>> +#define VIRT_GED_CPUHP_ADDR     (VIRT_GED_REG_ADDR + ACPI_GED_REG_COUNT)
>>   
>>   #define COMMAND_LINE_SIZE       512
>>   
> 


