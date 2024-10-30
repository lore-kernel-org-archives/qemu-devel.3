Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569CAD74956
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 01:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5xjQ-0007X3-7z; Tue, 29 Oct 2024 21:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t5xjO-0007Um-FU
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 21:42:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1t5xjM-0001Oe-1n
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 21:42:42 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxeeENjyFn7UQdAA--.61294S3;
 Wed, 30 Oct 2024 09:42:37 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCxfcIMjyFn+DcoAA--.49721S3;
 Wed, 30 Oct 2024 09:42:36 +0800 (CST)
Subject: Re: [PATCH v2 1/4] hw/loongarch/virt: Add CPU topology support
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>
References: <20241029095335.2219343-1-maobibo@loongson.cn>
 <20241029095335.2219343-2-maobibo@loongson.cn> <ZyDg00Vwowxkt5LO@intel.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <632065ad-e5e1-94f7-0d79-189d64bcc43c@loongson.cn>
Date: Wed, 30 Oct 2024 09:42:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ZyDg00Vwowxkt5LO@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxfcIMjyFn+DcoAA--.49721S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtF1UJF18XrW3Gr17tF1xtFc_yoW3JF4DpF
 4qka1UXw1UJ3s5Zw4DW3W7WFy0krn2gw1xX3WxKF4Fy3Wq9345JrWkKrZ09Fs8uF1qqFyj
 qF4rAF9xZFW2gFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1EksDUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.804,
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

Hi Zhao,

Thanks for reviewing the patch.

On 2024/10/29 下午9:19, Zhao Liu wrote:
> Hi Bibo,
> 
> [snip]
> 
>> +In the CPU topology relationship, When we know the ``socket_id`` ``core_id``
>> +and ``thread_id`` of the CPU, we can calculate its ``arch_id``:
>> +
>> +``arch_id = (socket_id * S) + (core_id * C) + (thread_id * T)``
> 
> What's the difference between arch_id and CPU index (CPUState.cpu_index)?
>    
>>   static void virt_init(MachineState *machine)
>>   {
>> -    LoongArchCPU *lacpu;
>>       const char *cpu_model = machine->cpu_type;
>>       MemoryRegion *address_space_mem = get_system_memory();
>>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
>> @@ -1145,7 +1144,7 @@ static void virt_init(MachineState *machine)
>>       hwaddr base, size, ram_size = machine->ram_size;
>>       const CPUArchIdList *possible_cpus;
>>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>> -    CPUState *cpu;
>> +    Object *cpuobj;
>>   
>>       if (!cpu_model) {
>>           cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
>> @@ -1164,12 +1163,25 @@ static void virt_init(MachineState *machine)
>>   
>>       /* Init CPUs */
>>       possible_cpus = mc->possible_cpu_arch_ids(machine);
>> -    for (i = 0; i < possible_cpus->len; i++) {
>> -        cpu = cpu_create(machine->cpu_type);
>> -        cpu->cpu_index = i;
>> -        machine->possible_cpus->cpus[i].cpu = cpu;
>> -        lacpu = LOONGARCH_CPU(cpu);
>> -        lacpu->phy_id = machine->possible_cpus->cpus[i].arch_id;
>> +    for (i = 0; i < machine->smp.cpus; i++) {
>> +        cpuobj = object_new(machine->cpu_type);
>> +        object_property_set_uint(cpuobj, "phy-id",
>> +                                possible_cpus->cpus[i].arch_id, NULL);
>> +        /*
>> +         * The CPU in place at the time of machine startup will also enter
>> +         * the CPU hot-plug process when it is created, but at this time,
>> +         * the GED device has not been created, resulting in exit in the CPU
>> +         * hot-plug process, which can avoid the incumbent CPU repeatedly
>> +         * applying for resources.
>> +         *
>> +         * The interrupt resource of the in-place CPU will be requested at
>> +         * the current function call virt_irq_init().
>> +         *
>> +         * The interrupt resource of the subsequently inserted CPU will be
>> +         * requested in the CPU hot-plug process.
>> +         */
>> +        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
>> +        object_unref(cpuobj);
> 
> You can use qdev_realize_and_unref().
sure, will do.

> 
>>       }
>>       fdt_add_cpu_nodes(lvms);
>>       fdt_add_memory_nodes(machine);
>> @@ -1286,6 +1298,35 @@ static void virt_initfn(Object *obj)
>>       virt_flash_create(lvms);
>>   }
>>   
>> +static int virt_get_arch_id_from_topo(MachineState *ms, LoongArchCPUTopo *topo)
>> +{
>> +    int arch_id, sock_vcpu_num, core_vcpu_num;
>> +
>> +    /*
>> +     * calculate total logical cpus across socket/core/thread.
>> +     * For more information on how to calculate the arch_id,
>> +     * you can refer to the CPU Topology chapter of the
>> +     * docs/system/loongarch/virt.rst document.
>> +     */
>> +    sock_vcpu_num = topo->socket_id * (ms->smp.threads * ms->smp.cores);
>> +    core_vcpu_num = topo->core_id * ms->smp.threads;
>> +
>> +    /* get vcpu-id(logical cpu index) for this vcpu from this topology */
>> +    arch_id = (sock_vcpu_num + core_vcpu_num) + topo->thread_id;
> 
> Looking at the calculations, arch_id looks the same as cpu_index, right?
The value of arch_id and cpu_index is the same now, however meaning is 
different. cpu_index is cpuslot index of possible_cpus array, arch_id is 
physical id.

Now there is no special HW calculation for physical id, value of them is 
the same. In future if physical id width exceeds 8-bit because extioi 
only support max 256 cpu routing, its calculation method will change.
> 
>> +    assert(arch_id >= 0 && arch_id < ms->possible_cpus->len);
>> +
>> +    return arch_id;
>> +}
>> +
>> +static void virt_get_topo_from_index(MachineState *ms,
>> +                                     LoongArchCPUTopo *topo, int index)
>> +{
>> +    topo->socket_id = index / (ms->smp.cores * ms->smp.threads);
>> +    topo->core_id = index / ms->smp.threads % ms->smp.cores;
>> +    topo->thread_id = index % ms->smp.threads;
>> +}
>> +
>>   static bool memhp_type_supported(DeviceState *dev)
>>   {
>>       /* we only support pc dimm now */
>> @@ -1385,8 +1426,9 @@ static HotplugHandler *virt_get_hotplug_handler(MachineState *machine,
>>   
>>   static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>>   {
>> -    int n;
>> +    int n, arch_id;
>>       unsigned int max_cpus = ms->smp.max_cpus;
>> +    LoongArchCPUTopo topo;
>>   
>>       if (ms->possible_cpus) {
>>           assert(ms->possible_cpus->len == max_cpus);
>> @@ -1397,17 +1439,17 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>>                                     sizeof(CPUArchId) * max_cpus);
>>       ms->possible_cpus->len = max_cpus;
>>       for (n = 0; n < ms->possible_cpus->len; n++) {
>> +        virt_get_topo_from_index(ms, &topo, n);
>> +        arch_id = virt_get_arch_id_from_topo(ms, &topo);
>> +        ms->possible_cpus->cpus[n].vcpus_count = ms->smp.threads;
> 
> In include/hw/boards.h, the doc of CPUArchId said:
> 
> vcpus_count - number of threads provided by @cpu object
> 
> And I undersatnd each element in possible_cpus->cpus[] is mapped to a
> CPU object, so that here vcpus_count should be 1.
yes, it is should be 1, thank for pointing it out
> 
> 
>>           ms->possible_cpus->cpus[n].type = ms->cpu_type;
>> -        ms->possible_cpus->cpus[n].arch_id = n;
>> -
>> +        ms->possible_cpus->cpus[n].arch_id = arch_id;
>>           ms->possible_cpus->cpus[n].props.has_socket_id = true;
>> -        ms->possible_cpus->cpus[n].props.socket_id  =
>> -                                   n / (ms->smp.cores * ms->smp.threads);
>> +        ms->possible_cpus->cpus[n].props.socket_id = topo.socket_id;
>>           ms->possible_cpus->cpus[n].props.has_core_id = true;
>> -        ms->possible_cpus->cpus[n].props.core_id =
>> -                                   n / ms->smp.threads % ms->smp.cores;
>> +        ms->possible_cpus->cpus[n].props.core_id = topo.core_id;
>>           ms->possible_cpus->cpus[n].props.has_thread_id = true;
>> -        ms->possible_cpus->cpus[n].props.thread_id = n % ms->smp.threads;
>> +        ms->possible_cpus->cpus[n].props.thread_id = topo.thread_id;
>>       }
>>       return ms->possible_cpus;
>>   }
>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index 7212fb5f8f..5dfc0d5c43 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -16,6 +16,7 @@
>>   #include "kvm/kvm_loongarch.h"
>>   #include "exec/exec-all.h"
>>   #include "cpu.h"
>> +#include "hw/qdev-properties.h"
>>   #include "internals.h"
>>   #include "fpu/softfloat-helpers.h"
>>   #include "cpu-csr.h"
>> @@ -780,6 +781,15 @@ static int64_t loongarch_cpu_get_arch_id(CPUState *cs)
>>   }
>>   #endif
>>   
>> +static Property loongarch_cpu_properties[] = {
>> +    DEFINE_PROP_UINT32("phy-id", LoongArchCPU, phy_id, UNSET_PHY_ID),
> 
> IIUC, the phy_id is kind of like the x86 apic_id, but the field is completely
> derived from topology, so why do you need to define it as a property and then
> expose it to the user?
The property is wrongly used here. we want to differentiate cold-added 
cpus and hot-added cpus.  phy_id of cold-added cpus can be set during 
power on, however that of hot-added cpus is default -1.

Internal variable phy_id can be set with default value -1 in function 
loongarch_cpu_init(), property can be removed.

Regards
Bibo Mao
> 
> Thanks,
> Zhao
> 


