Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D43C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 05:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQgt5-0002m7-Lx; Mon, 08 Jul 2024 01:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sQgt3-0002iw-Qf
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 01:26:05 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sQgt1-0002tX-VF
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 01:26:05 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-426636ef8c9so6946935e9.2
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 22:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1720416362; x=1721021162; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZpayKAEFxEVZAaH4ZWrn0Q1u51XQ6H3kIZWM2t9BbaA=;
 b=AsfrbOmAcs/fw7GVYJ1+HHRxAdNKqZQq0yZeVupFi8wTe4ckutZmFUO8+MvpsdPdAg
 aXSvVI1e76of1frXSydgyqG2CYEny5ooc001so/6A3lh+kTbfQMbXgzbP2JS6xEa5ybI
 ei1CL8OLfpSpZrLovPZGtm74wKtNYbESpZq3pe7/RuFfx8aIsKnFlSBHOTsRWeOK+7I3
 +GZNQTeNck1+tSIJ/Tp5umMaBPUtgmy5oS5NyCnV6Emzc4Sjs0jCgswBMupOh4iDSEFd
 Z1H5CRKc05pnb8YBtDChqsJD2apYGqt1Ko+mc3UB7Ucd9jU/4RvbULH3+IkayISoA/sA
 cEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720416362; x=1721021162;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZpayKAEFxEVZAaH4ZWrn0Q1u51XQ6H3kIZWM2t9BbaA=;
 b=nosm3UhpuD0Ak8lcAt7qR7gGbgrcxmlK65fDzMVBsTvvuNFxOTGIhIdKnUgU5XwASM
 +NcFj+MwJ08FBH6GWu+DhKkJxllee5UwEAZMblX8FzJabFPq5SBUJby5LNZfYq6mKZlq
 dKhQVp5B/r3CSqrbL7UVtnT87d2zdtB4vMgRY1v3ZrZDGwe3yeCLRzfDngiyO6qjnrjI
 DiMjEwI83Pmc3G0WFnnXY6x2Pjj0IxFpPdX/3yvCrH+MykulOdFUmGY1SwQiRmLNH69O
 tXNoBll/z4zdyDsxpNHIdm7IUuBTQZIzsYamI3/Js9iXNUl5nDdP8qiIi6cDzejZumtn
 7YXA==
X-Gm-Message-State: AOJu0YwlUUwz6rIXy2Vs71BPQwqUEw5EhxFqhGWlb+NDwp+62rznpx42
 hKs6BPmqr6JUG+ERj+lj/0FeGx+G6TgjA576tAKZaKKTEXS9qvkOQch9+ogeJac=
X-Google-Smtp-Source: AGHT+IHqcypsvI4nhxIkIUzc4evH06LudLehZUsBxEDIKMu4wz5KFX4ie3ZXJIa/HoXZV6mWoci0tQ==
X-Received: by 2002:a05:600c:4393:b0:426:5de3:2ae5 with SMTP id
 5b1f17b1804b1-4265de32becmr47748575e9.10.1720416362366; 
 Sun, 07 Jul 2024 22:26:02 -0700 (PDT)
Received: from [10.11.12.72] ([90.220.10.255])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d50f5sm148779385e9.9.2024.07.07.22.26.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jul 2024 22:26:01 -0700 (PDT)
Message-ID: <020c731c-8bfc-4524-9750-879dd44b6cfe@opnsrc.net>
Date: Mon, 8 Jul 2024 05:26:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 5/8] hw/acpi: Update CPUs AML with cpu-(ctrl)dev change
To: Igor Mammedov <imammedo@redhat.com>, Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, andrew.jones@linux.dev, david@redhat.com,
 philmd@linaro.org, eric.auger@redhat.com, oliver.upton@linux.dev,
 pbonzini@redhat.com, mst@redhat.com, will@kernel.org, gshan@redhat.com,
 rafael@kernel.org, alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, npiggin@gmail.com, harshpb@linux.ibm.com,
 linuxarm@huawei.com, Shaoqin Huang <shahuang@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-6-salil.mehta@huawei.com>
 <20240706163524.012b6caf@imammedo.users.ipa.redhat.com>
Content-Language: en-GB
From: Salil Mehta <salil.mehta@opnsrc.net>
In-Reply-To: <20240706163524.012b6caf@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wm1-x331.google.com
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

On 06/07/2024 14:35, Igor Mammedov wrote:
> On Fri, 7 Jun 2024 12:56:46 +0100
> Salil Mehta <salil.mehta@huawei.com> wrote:
>
>> CPUs Control device(\\_SB.PCI0) register interface for the x86 arch is IO port
>> based and existing CPUs AML code assumes _CRS objects would evaluate to a system
>> resource which describes IO Port address. But on ARM arch CPUs control
>> device(\\_SB.PRES) register interface is memory-mapped hence _CRS object should
>> evaluate to system resource which describes memory-mapped base address. Update
>> build CPUs AML function to accept both IO/MEMORY region spaces and accordingly
>> update the _CRS object.
> ack for above change
Thanks
>
>
> but below part is one too many different changes withing 1 patch.
> anyways, GPE part probably won't be needed if you follow suggestion made
> on previous patch.

The change mentioned in the earlier patches might end up creating

noise for this patch-set as one will have to touch the Memory Hotplug

part as well. I'm willing to do that change but I think it is a noise for

this patch-set, really.

>   
>> On x86, CPU Hotplug uses Generic ACPI GPE Block Bit 2 (GPE.2) event handler to
>> notify OSPM about any CPU hot(un)plug events. Latest CPU Hotplug is based on
>> ACPI Generic Event Device framework and uses ACPI GED device for the same. Not
>> all architectures support GPE based CPU Hotplug event handler. Hence, make AML
>> for GPE.2 event handler conditional.
>>
>> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Tested-by: Xianglai Li <lixianglai@loongson.cn>
>> Tested-by: Miguel Luis <miguel.luis@oracle.com>
>> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
>> Tested-by: Zhao Liu <zhao1.liu@intel.com>
>> ---
>>   hw/acpi/cpu.c         | 23 ++++++++++++++++-------
>>   hw/i386/acpi-build.c  |  3 ++-
>>   include/hw/acpi/cpu.h |  5 +++--
>>   3 files changed, 21 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
>> index af2b6655d2..4c63514b16 100644
>> --- a/hw/acpi/cpu.c
>> +++ b/hw/acpi/cpu.c
>> @@ -343,9 +343,10 @@ const VMStateDescription vmstate_cpu_hotplug = {
>>   #define CPU_FW_EJECT_EVENT "CEJF"
>>   
>>   void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>> -                    build_madt_cpu_fn build_madt_cpu, hwaddr io_base,
>> +                    build_madt_cpu_fn build_madt_cpu, hwaddr base_addr,
>>                       const char *res_root,
>> -                    const char *event_handler_method)
>> +                    const char *event_handler_method,
>> +                    AmlRegionSpace rs)
>>   {
>>       Aml *ifctx;
>>       Aml *field;
>> @@ -370,13 +371,19 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>>           aml_append(cpu_ctrl_dev, aml_mutex(CPU_LOCK, 0));
>>   
>>           crs = aml_resource_template();
>> -        aml_append(crs, aml_io(AML_DECODE16, io_base, io_base, 1,
>> +        if (rs == AML_SYSTEM_IO) {
>> +            aml_append(crs, aml_io(AML_DECODE16, base_addr, base_addr, 1,
>>                                  ACPI_CPU_HOTPLUG_REG_LEN));
>> +        } else {
> else
>   if (rs == yours type)
>> +            aml_append(crs, aml_memory32_fixed(base_addr,
>> +                               ACPI_CPU_HOTPLUG_REG_LEN, AML_READ_WRITE));
>> +        }
> else assert on not supported input

Sure, no problem. I can incorporate the change.

Thanks, Salil.

>
>> +
>>           aml_append(cpu_ctrl_dev, aml_name_decl("_CRS", crs));
>>   
>>           /* declare CPU hotplug MMIO region with related access fields */
>>           aml_append(cpu_ctrl_dev,
>> -            aml_operation_region("PRST", AML_SYSTEM_IO, aml_int(io_base),
>> +            aml_operation_region("PRST", rs, aml_int(base_addr),
>>                                    ACPI_CPU_HOTPLUG_REG_LEN));
>>   
>>           field = aml_field("PRST", AML_BYTE_ACC, AML_NOLOCK,
>> @@ -700,9 +707,11 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>>       aml_append(sb_scope, cpus_dev);
>>       aml_append(table, sb_scope);
>>   
>> -    method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
>> -    aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
>> -    aml_append(table, method);
>> +    if (event_handler_method) {
>> +        method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
>> +        aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
>> +        aml_append(table, method);
>> +    }
>>   
>>       g_free(cphp_res_path);
>>   }
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 53f804ac16..b73b136605 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -1537,7 +1537,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>               .fw_unplugs_cpu = pm->smi_on_cpu_unplug,
>>           };
>>           build_cpus_aml(dsdt, machine, opts, pc_madt_cpu_entry,
>> -                       pm->cpu_hp_io_base, "\\_SB.PCI0", "\\_GPE._E02");
>> +                       pm->cpu_hp_io_base, "\\_SB.PCI0", "\\_GPE._E02",
>> +                       AML_SYSTEM_IO);
>>       }
>>   
>>       if (pcms->memhp_io_base && nr_mem) {
>> diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
>> index e6e1a9ef59..48cded697c 100644
>> --- a/include/hw/acpi/cpu.h
>> +++ b/include/hw/acpi/cpu.h
>> @@ -61,9 +61,10 @@ typedef void (*build_madt_cpu_fn)(int uid, const CPUArchIdList *apic_ids,
>>                                     GArray *entry, bool force_enabled);
>>   
>>   void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>> -                    build_madt_cpu_fn build_madt_cpu, hwaddr io_base,
>> +                    build_madt_cpu_fn build_madt_cpu, hwaddr base_addr,
>>                       const char *res_root,
>> -                    const char *event_handler_method);
>> +                    const char *event_handler_method,
>> +                    AmlRegionSpace rs);
>>   
>>   void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list);
>>   

