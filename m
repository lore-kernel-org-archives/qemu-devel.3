Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C22106F304
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 08:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5gP3-0007D4-Qp; Thu, 26 Mar 2026 04:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1w5gOx-0007Cs-Lm
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 04:49:16 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1w5gOu-0005oa-IA
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 04:49:15 -0400
Received: from loongson.cn (unknown [10.20.42.126])
 by gateway (Coremail) with SMTP id _____8BxEMD+8sRpqtgeAA--.29230S3;
 Thu, 26 Mar 2026 16:49:03 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
 by front1 (Coremail) with SMTP id qMiowJCxOMH98sRpI9NdAA--.34665S3;
 Thu, 26 Mar 2026 16:49:01 +0800 (CST)
Subject: Re: [PATCH V2] hw/loongarch: add rtc acpi table
To: chen huacai <zltjiangshi@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20260312021350.1052791-1-lixianglai@loongson.cn>
 <CABDp7VqCb6R9h8WYsseaD34fJEyhYNAoCAgC2QHFc7D-dVFzdw@mail.gmail.com>
 <a845bc6a-8ba7-cec6-1a38-41732b738b02@loongson.cn>
 <CABDp7Vp=xvz=D9AjQaqZNVteLX=UrbLyaQBBiNjGA2E6qc6WbQ@mail.gmail.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <fa3519ce-550d-754e-41a2-61f1835c7cd8@loongson.cn>
Date: Thu, 26 Mar 2026 16:41:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CABDp7Vp=xvz=D9AjQaqZNVteLX=UrbLyaQBBiNjGA2E6qc6WbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxOMH98sRpI9NdAA--.34665S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ww47trWxJF13Zr4rurWUWrX_yoWxZr1fpr
 W7CFnIyr4DXFy3X34avw1j9rnIyrykK34jvr1xAr18Gr90grnrXr10y3y7Ka4rZ348JF10
 vF4vgFy3Wa45ZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QV
 y3UUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.227,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi huacai:
> On Thu, Mar 19, 2026 at 10:35 AM lixianglai <lixianglai@loongson.cn> wrote:
>> Hi huacai :
>>> Hi, Xianglai,
>>>
>>> On Thu, Mar 12, 2026 at 10:40 AM Xianglai Li <lixianglai@loongson.cn> wrote:
>>>> Add the acpi table to the loongson rtc hardware so that the virtual machine
>>>> kernel can use the loongson RTC-related drivers.
>>>>
>>>> Delete the interrupt information in the rtc fdt table.
>>> Why not use virtio-rtc? In this way we don't need to modify the ls7a rtc driver.
>> Sorry for the late reply.
>> However, I did not find the device simulation model of virtio-rtc under
>> the hw/rtc directory.
> virtio-rtc was added to the Linux kernel some time ago, it is very
> new. But goldfish_rtc is another virtual rtc which is widely used and
> has a long time in QEMU, you can consider it.


Oh, I found the virtio rtc driver in the kernel, but couldn't find the 
device simulation for virtio rtc
in the qemu source code. Finally, I found a patch in the qemu mailing list.

Of course, we can replace the rtc equipment model (e.g. goldfish_rtc), 
but we can't remove ls7a
rtc from the perspective of compatibility, and we need to consider the 
cost of bios and virtual
machine kernel modification after changing the rtc device model as I 
mentioned above,
I think we should hear from other community members about whether we 
should eventually change
the loongarch virt virtual machine rtc device model.

Hi, @Song and @Bibo Do you have any opinions on this? Looking forward to 
hearing your suggestions!!
>> But, there is a simulation model for the ls7a rtc device, which is
>> strongly related to
>> the virtualization of our loongarch platform.
>>
>> So it makes perfect sense to use the ls7a rtc here. Otherwise, no
>> platform would need to use the ls7a rtc,
>> and changing the simulation model of the rtc device at this stage,
>> our bios would also need to be modified accordingly. This would result
>> in a very high cost of modification.
> I don't strongly object to ls7a rtc, but if you use it please try your
> best to make it the same as real hardware. It is unacceptable to
> modify the kernel driver to adapt the virtual ls7a rtc.
Here, I would like to clarify that this patch merely achieves the 
purpose of disabling
the interrupt function of the RTC driver by modifying the RTC ACPI.
This patch does not require any corresponding modifications to the RTC 
driver in the kernel.

Thanks!
Xianglai.


>
> Huacai
>
>> Thanks!
>> Xianglai.
>>
>>> Huacai
>>>
>>>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>>>> ---
>>>> Cc: Song Gao <gaosong@loongson.cn>
>>>> Cc: Bibo Mao <maobibo@loongson.cn>
>>>> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>>>
>>>> change:
>>>> V1->V2:
>>>> 1.Add a comment to explain why the acpi table no longer provides interrupt numbers
>>>> 2.Delete the interrupt number from the rtc fdt table
>>>>
>>>>    hw/loongarch/virt-acpi-build.c | 25 +++++++++++++++++++++++++
>>>>    hw/loongarch/virt-fdt-build.c  | 16 ++++++++--------
>>>>    2 files changed, 33 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
>>>> index 3e34bedcd6..42820001d7 100644
>>>> --- a/hw/loongarch/virt-acpi-build.c
>>>> +++ b/hw/loongarch/virt-acpi-build.c
>>>> @@ -460,6 +460,30 @@ static void acpi_dsdt_add_tpm(Aml *scope, LoongArchVirtMachineState *vms)
>>>>    }
>>>>    #endif
>>>>
>>>> +static void acpi_dsdt_add_rtc(Aml *scope)
>>>> +{
>>>> +    Aml *dev = aml_device("RTC");
>>>> +
>>>> +    aml_append(dev, aml_name_decl("_HID", aml_string("LOON0001")));
>>>> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>>>> +
>>>> +    Aml *crs = aml_resource_template();
>>>> +    aml_append(crs,
>>>> +        aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
>>>> +                         AML_NON_CACHEABLE, AML_READ_WRITE,
>>>> +                         0, VIRT_RTC_REG_BASE,
>>>> +                         VIRT_RTC_REG_BASE + VIRT_RTC_LEN - 1,
>>>> +                         0, VIRT_RTC_LEN));
>>>> +    /*
>>>> +     * The virtual machine model does not support suspend and wake-up,
>>>> +     * and rtc is no longer the wake-up source. Therefore, the current
>>>> +     * rtc table no longer provides the rtc alarm interrupt number to
>>>> +     * avoid the software initializing alarm.
>>>> +     */
>>>> +    aml_append(dev, aml_name_decl("_CRS", crs));
>>>> +    aml_append(scope, dev);
>>>> +}
>>>> +
>>>>    /* build DSDT */
>>>>    static void
>>>>    build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>>>> @@ -475,6 +499,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>>>>        for (i = 0; i < VIRT_UART_COUNT; i++) {
>>>>            build_uart_device_aml(dsdt, i);
>>>>        }
>>>> +    acpi_dsdt_add_rtc(dsdt);
>>>>        build_pci_device_aml(dsdt, lvms);
>>>>        build_la_ged_aml(dsdt, machine);
>>>>        build_flash_aml(dsdt, lvms);
>>>> diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.c
>>>> index 6c06b36fca..42f014a7bd 100644
>>>> --- a/hw/loongarch/virt-fdt-build.c
>>>> +++ b/hw/loongarch/virt-fdt-build.c
>>>> @@ -458,8 +458,7 @@ static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
>>>>        g_free(nodename);
>>>>    }
>>>>
>>>> -static void fdt_add_rtc_node(LoongArchVirtMachineState *lvms,
>>>> -                             uint32_t *pch_pic_phandle)
>>>> +static void fdt_add_rtc_node(LoongArchVirtMachineState *lvms)
>>>>    {
>>>>        char *nodename;
>>>>        hwaddr base = VIRT_RTC_REG_BASE;
>>>> @@ -470,12 +469,13 @@ static void fdt_add_rtc_node(LoongArchVirtMachineState *lvms,
>>>>        qemu_fdt_add_subnode(ms->fdt, nodename);
>>>>        qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
>>>>                                "loongson,ls7a-rtc");
>>>> +    /*
>>>> +     * The virtual machine model does not support suspend and wake-up,
>>>> +     * and rtc is no longer the wake-up source. Therefore, the current
>>>> +     * rtc table no longer provides the rtc alarm interrupt number to
>>>> +     * avoid the software initializing alarm.
>>>> +     */
>>>>        qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
>>>> -    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
>>>> -                           VIRT_RTC_IRQ - VIRT_GSI_BASE ,
>>>> -                           FDT_IRQ_TYPE_LEVEL_HIGH);
>>>> -    qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
>>>> -                          *pch_pic_phandle);
>>>>        g_free(nodename);
>>>>    }
>>>>
>>>> @@ -550,7 +550,7 @@ void virt_fdt_setup(LoongArchVirtMachineState *lvms)
>>>>            fdt_add_uart_node(lvms, &pch_pic_phandle, base, irq, i == 0);
>>>>        }
>>>>
>>>> -    fdt_add_rtc_node(lvms, &pch_pic_phandle);
>>>> +    fdt_add_rtc_node(lvms);
>>>>        fdt_add_ged_reset(lvms);
>>>>        platform_bus_add_all_fdt_nodes(machine->fdt, "/platic",
>>>>                                       VIRT_PLATFORM_BUS_BASEADDRESS,
>>>> --
>>>> 2.39.1
>>>>
>>>>
>


