Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10034CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN9J-0003MZ-Ad; Sat, 30 Aug 2025 11:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1urtwC-0005di-Vg
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:54:22 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1urtw8-00079R-BF
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:54:19 -0400
Received: from loongson.cn (unknown [10.20.42.126])
 by gateway (Coremail) with SMTP id _____8AxSNGiXLFoUn8EAA--.9215S3;
 Fri, 29 Aug 2025 15:54:10 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
 by front1 (Coremail) with SMTP id qMiowJBxZOSfXLFoTTdwAA--.21919S3;
 Fri, 29 Aug 2025 15:54:09 +0800 (CST)
Subject: Re: Re: [PATCH] hw/loongarch/virt: Add reset interface for
 virt-machine
To: maobibo <maobibo@loongson.cn>, Peter Maydell <peter.maydell@linaro.org>
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
References: <20241031065418.3111892-1-maobibo@loongson.cn>
 <CAFEAcA_4PabxEui-wbztw+nDpHsoAJNi-HWJU4opax54HgAo5w@mail.gmail.com>
 <c6a29d72-763b-69b6-c5e2-3f5c3828f6ea@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <bc03fd77-ef72-e871-da36-c745bac5d0a8@loongson.cn>
Date: Fri, 29 Aug 2025 15:53:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c6a29d72-763b-69b6-c5e2-3f5c3828f6ea@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJBxZOSfXLFoTTdwAA--.21919S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3ArW3Jr13Zr1rJF1rAF18Zwc_yoWxXr1Dpr
 ykAF45JrZ5Wrn7Jw42ga4UuFyqyr1xKa1aqF1xtFy0kFsFgryjgr4jqryq9F1DAw48WF1Y
 vr15Cw13ZF45X3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUU
 U
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.357,
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

Hi Peter:
>> On Thu, 31 Oct 2024 at 06:55, Bibo Mao <maobibo@loongson.cn> wrote:
>>>
>>> With generic cpu reset interface, pc register is entry of FLASH for
>>> UEFI BIOS. However with direct kernel booting requirement, there is
>>> little different, pc register of primary cpu is entry address of ELF
>>> file.
>>>
>>> At the same time with requirement of cpu hotplug, hot-added CPU should
>>> register reset interface for this cpu object. Now reset callback is
>>> not registered for hot-added CPU.
>>>
>>> With this patch reset callback for CPU is register when CPU instance
>>> is created, and reset interface is added for virt-machine board. In
>>> reset interface of virt-machine, reset for direct kernel booting
>>> requirement is called.
>>>
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>> ---
>>>   hw/loongarch/boot.c         |  9 +--------
>>>   hw/loongarch/virt.c         | 14 ++++++++++++++
>>>   include/hw/loongarch/boot.h |  1 +
>>>   target/loongarch/cpu.c      | 10 ++++++++++
>>>   4 files changed, 26 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
>>> index cb668703bd..cbb4e3737d 100644
>>> --- a/hw/loongarch/boot.c
>>> +++ b/hw/loongarch/boot.c
>>> @@ -216,12 +216,11 @@ static int64_t load_kernel_info(struct 
>>> loongarch_boot_info *info)
>>>       return kernel_entry;
>>>   }
>>>
>>> -static void reset_load_elf(void *opaque)
>>> +void reset_load_elf(void *opaque)
>>>   {
>>>       LoongArchCPU *cpu = opaque;
>>>       CPULoongArchState *env = &cpu->env;
>>>
>>> -    cpu_reset(CPU(cpu));
>>>       if (env->load_elf) {
>>>          if (cpu == LOONGARCH_CPU(first_cpu)) {
>>>               env->gpr[4] = env->boot_info->a0;
>>> @@ -320,12 +319,6 @@ static void loongarch_direct_kernel_boot(struct 
>>> loongarch_boot_info *info)
>>>   void loongarch_load_kernel(MachineState *ms, struct 
>>> loongarch_boot_info *info)
>>>   {
>>>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
>>> -    int i;
>>> -
>>> -    /* register reset function */
>>> -    for (i = 0; i < ms->smp.cpus; i++) {
>>> -        qemu_register_reset(reset_load_elf, 
>>> LOONGARCH_CPU(qemu_get_cpu(i)));
>>> -    }
>>>
>>>       info->kernel_filename = ms->kernel_filename;
>>>       info->kernel_cmdline = ms->kernel_cmdline;
>>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>>> index 9a635d1d3d..80680d178c 100644
>>> --- a/hw/loongarch/virt.c
>>> +++ b/hw/loongarch/virt.c
>>> @@ -1434,6 +1434,19 @@ static int64_t 
>>> virt_get_default_cpu_node_id(const MachineState *ms, int idx)
>>>       }
>>>   }
>>>
>>> +static void virt_reset(MachineState *machine, ResetType type)
>>> +{
>>> +    CPUState *cs;
>>> +
>>> +    /* Reset all devices including CPU devices */
>>> +    qemu_devices_reset(type);
>>> +
>>> +    /* Reset PC and register context for kernel direct booting 
>>> method */
>>> +    CPU_FOREACH(cs) {
>>> +        reset_load_elf(LOONGARCH_CPU(cs));
>>> +    }
>>> +}
>>> +
>>>   static void virt_class_init(ObjectClass *oc, void *data)
>>>   {
>>>       MachineClass *mc = MACHINE_CLASS(oc);
>>> @@ -1457,6 +1470,7 @@ static void virt_class_init(ObjectClass *oc, 
>>> void *data)
>>>       mc->auto_enable_numa_with_memdev = true;
>>>       mc->get_hotplug_handler = virt_get_hotplug_handler;
>>>       mc->default_nic = "virtio-net-pci";
>>> +    mc->reset = virt_reset;
>>>       hc->plug = virt_device_plug_cb;
>>>       hc->pre_plug = virt_device_pre_plug;
>>>       hc->unplug_request = virt_device_unplug_request;
>>> diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
>>> index b3b870df1f..c7020ec9bb 100644
>>> --- a/include/hw/loongarch/boot.h
>>> +++ b/include/hw/loongarch/boot.h
>>> @@ -115,5 +115,6 @@ struct memmap_entry {
>>>   };
>>>
>>>   void loongarch_load_kernel(MachineState *ms, struct 
>>> loongarch_boot_info *info);
>>> +void reset_load_elf(void *opaque);
>>>
>>>   #endif /* HW_LOONGARCH_BOOT_H */
>>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>>> index 7212fb5f8f..f7f8fcc024 100644
>>> --- a/target/loongarch/cpu.c
>>> +++ b/target/loongarch/cpu.c
>>> @@ -592,6 +592,13 @@ static void 
>>> loongarch_cpu_disas_set_info(CPUState *s, disassemble_info *info)
>>>       info->print_insn = print_insn_loongarch;
>>>   }
>>>
>>> +#ifndef CONFIG_USER_ONLY
>>> +static void loongarch_cpu_reset_cb(void *opaque)
>>> +{
>>> +    cpu_reset((CPUState *) opaque);
>>> +}
>>> +#endif
>>> +
>>>   static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
>>>   {
>>>       CPUState *cs = CPU(dev);
>>> @@ -607,6 +614,9 @@ static void loongarch_cpu_realizefn(DeviceState 
>>> *dev, Error **errp)
>>>       loongarch_cpu_register_gdb_regs_for_features(cs);
>>>
>>>       cpu_reset(cs);
>>> +#ifndef CONFIG_USER_ONLY
>>> +    qemu_register_reset(loongarch_cpu_reset_cb, dev);
>>> +#endif
>>
>> Please don't add new uses of qemu_register_reset().
>> I know that CPU reset is currently rather awkward (because
>> we don't automatically-reset CPU objects the way we do most
>> device objects), but generally what should happen is that
>> the machine model should arrange to reset the CPU objects
>> it creates. (Which is what it looks like the code you're
>> removing in this patch was doing already.)
> Currently the machine model does not register reset callback for 
> hot-added CPUs, so we put reset callback registration on CPU object 
> created stage, that works for hot-added CPUs.
>

I see this comment has been around for a long time. Can this patch be 
merged? Recently,
I also encountered the same problem, so I submitted a patch.
However, I found that this patch was a bit better than the one I submitted.
So, I wonder what the final conclusion of this patch is.

Thanks!
Xianglai.

> Regards
> Bibo Mao
>>
>> thanks
>> -- PMM
>>
>
>
>


