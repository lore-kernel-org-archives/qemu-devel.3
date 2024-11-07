Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1FCD29FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 02:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8s2U-0005Oo-5O; Wed, 06 Nov 2024 21:14:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t8s2R-0005OO-Kk
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 21:14:23 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1t8s2O-0005Dq-Ob
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 21:14:23 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxWOFuIixnSCw2AA--.42078S3;
 Thu, 07 Nov 2024 10:14:06 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMDx+0ZsIixn1G1IAA--.64490S3;
 Thu, 07 Nov 2024 10:14:05 +0800 (CST)
Subject: Re: [PATCH v2 1/4] hw/loongarch/virt: Add CPU topology support
To: Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>
References: <20241029095335.2219343-1-maobibo@loongson.cn>
 <20241029095335.2219343-2-maobibo@loongson.cn> <ZyDg00Vwowxkt5LO@intel.com>
 <20241106114150.5af254a7@imammedo.users.ipa.redhat.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <bf91f8fd-3ce8-3837-436d-30fd5665f5da@loongson.cn>
Date: Thu, 7 Nov 2024 10:13:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20241106114150.5af254a7@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx+0ZsIixn1G1IAA--.64490S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gr1UCr4DAFy8GFWfWr13ZFc_yoWfZF4rpF
 Wjka1jvr1UX3s5Zw4qg3W2gFy0kr1vgw1xX3WxGF4Fy3Z0gry3JrWUtrZ8uF48uFnFqF1j
 qr48CFZxZFy2qFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.588,
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



On 2024/11/6 下午6:41, Igor Mammedov wrote:
> On Tue, 29 Oct 2024 21:19:15 +0800
> Zhao Liu <zhao1.liu@intel.com> wrote:
> 
>> Hi Bibo,
>>
>> [snip]
>>
>>> +In the CPU topology relationship, When we know the ``socket_id`` ``core_id``
>>> +and ``thread_id`` of the CPU, we can calculate its ``arch_id``:
>>> +
>>> +``arch_id = (socket_id * S) + (core_id * C) + (thread_id * T)``
>>
>> What's the difference between arch_id and CPU index (CPUState.cpu_index)?
> 
> They might be the same but not necessarily.
> arch_id is unique cpu identifier from architecture point of view
> (which easily could be sparse and without specific order).
> (ex: for x86 it's apic_id, for spapr it's core_id)
> 
> while cpu_index is internal QEMU, that existed before possible_cpus[]
> and non-sparse range and depends on order of cpus are created.
> For machines that support possible_cpus[], we override default
> cpu_index assignment to fit possible_cpus[].
> 
> It might be nice to get rid of cpu_index in favor of possible_cpus[],
> but that would be a lot work probably with no huge benefit
> when it comes majority of machines that don't need variable
> cpu count.
> 
>>    
>>>   static void virt_init(MachineState *machine)
>>>   {
>>> -    LoongArchCPU *lacpu;
>>>       const char *cpu_model = machine->cpu_type;
>>>       MemoryRegion *address_space_mem = get_system_memory();
>>>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
>>> @@ -1145,7 +1144,7 @@ static void virt_init(MachineState *machine)
>>>       hwaddr base, size, ram_size = machine->ram_size;
>>>       const CPUArchIdList *possible_cpus;
>>>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>>> -    CPUState *cpu;
>>> +    Object *cpuobj;
>>>   
>>>       if (!cpu_model) {
>>>           cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
>>> @@ -1164,12 +1163,25 @@ static void virt_init(MachineState *machine)
>>>   
>>>       /* Init CPUs */
>>>       possible_cpus = mc->possible_cpu_arch_ids(machine);
>>> -    for (i = 0; i < possible_cpus->len; i++) {
>>> -        cpu = cpu_create(machine->cpu_type);
>>> -        cpu->cpu_index = i;
>>> -        machine->possible_cpus->cpus[i].cpu = cpu;
>>> -        lacpu = LOONGARCH_CPU(cpu);
>>> -        lacpu->phy_id = machine->possible_cpus->cpus[i].arch_id;
>>> +    for (i = 0; i < machine->smp.cpus; i++) {
>>> +        cpuobj = object_new(machine->cpu_type);
>>> +        object_property_set_uint(cpuobj, "phy-id",
>>> +                                possible_cpus->cpus[i].arch_id, NULL);
>>> +        /*
>>> +         * The CPU in place at the time of machine startup will also enter
>>> +         * the CPU hot-plug process when it is created, but at this time,
>>> +         * the GED device has not been created, resulting in exit in the CPU
>>> +         * hot-plug process, which can avoid the incumbent CPU repeatedly
>>> +         * applying for resources.
>>> +         *
>>> +         * The interrupt resource of the in-place CPU will be requested at
>>> +         * the current function call virt_irq_init().
>>> +         *
>>> +         * The interrupt resource of the subsequently inserted CPU will be
>>> +         * requested in the CPU hot-plug process.
>>> +         */
>>> +        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
>>> +        object_unref(cpuobj);
>>
>> You can use qdev_realize_and_unref().
>>
>>>       }
>>>       fdt_add_cpu_nodes(lvms);
>>>       fdt_add_memory_nodes(machine);
>>> @@ -1286,6 +1298,35 @@ static void virt_initfn(Object *obj)
>>>       virt_flash_create(lvms);
>>>   }
>>>   
>>> +static int virt_get_arch_id_from_topo(MachineState *ms, LoongArchCPUTopo *topo)
>>> +{
>>> +    int arch_id, sock_vcpu_num, core_vcpu_num;
>>> +
>>> +    /*
>>> +     * calculate total logical cpus across socket/core/thread.
>>> +     * For more information on how to calculate the arch_id,
>>> +     * you can refer to the CPU Topology chapter of the
>>> +     * docs/system/loongarch/virt.rst document.
>>> +     */
>>> +    sock_vcpu_num = topo->socket_id * (ms->smp.threads * ms->smp.cores);
>>> +    core_vcpu_num = topo->core_id * ms->smp.threads;
>>> +
>>> +    /* get vcpu-id(logical cpu index) for this vcpu from this topology */
>>> +    arch_id = (sock_vcpu_num + core_vcpu_num) + topo->thread_id;
>>
>> Looking at the calculations, arch_id looks the same as cpu_index, right?
>>
>>> +    assert(arch_id >= 0 && arch_id < ms->possible_cpus->len);
>>> +
>>> +    return arch_id;
>>> +}
>>> +
>>> +static void virt_get_topo_from_index(MachineState *ms,
>>> +                                     LoongArchCPUTopo *topo, int index)
>>> +{
>>> +    topo->socket_id = index / (ms->smp.cores * ms->smp.threads);
>>> +    topo->core_id = index / ms->smp.threads % ms->smp.cores;
>>> +    topo->thread_id = index % ms->smp.threads;
>>> +}
>>> +
>>>   static bool memhp_type_supported(DeviceState *dev)
>>>   {
>>>       /* we only support pc dimm now */
>>> @@ -1385,8 +1426,9 @@ static HotplugHandler *virt_get_hotplug_handler(MachineState *machine,
>>>   
>>>   static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>>>   {
>>> -    int n;
>>> +    int n, arch_id;
>>>       unsigned int max_cpus = ms->smp.max_cpus;
>>> +    LoongArchCPUTopo topo;
>>>   
>>>       if (ms->possible_cpus) {
>>>           assert(ms->possible_cpus->len == max_cpus);
>>> @@ -1397,17 +1439,17 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>>>                                     sizeof(CPUArchId) * max_cpus);
>>>       ms->possible_cpus->len = max_cpus;
>>>       for (n = 0; n < ms->possible_cpus->len; n++) {
>>> +        virt_get_topo_from_index(ms, &topo, n);
>>> +        arch_id = virt_get_arch_id_from_topo(ms, &topo);
>>> +        ms->possible_cpus->cpus[n].vcpus_count = ms->smp.threads;
>>
>> In include/hw/boards.h, the doc of CPUArchId said:
>>
>> vcpus_count - number of threads provided by @cpu object
>>
>> And I undersatnd each element in possible_cpus->cpus[] is mapped to a
>> CPU object, so that here vcpus_count should be 1.
> 
> it's arch specific, CPU object in possible_cpus was meant to point to
> thread/core/..higher layers in future../
> 
> For example spapr put's there CPUCore, where vcpus_count can be > 1
> 
> That is a bit broken though, since CPUCore is not CPUState by any means,
> spapr_core_plug() gets away with it only because
>    core_slot->cpu = CPU(dev)
> CPU() is dumb pointer cast.
> 
> Ideally CPUArchId::cpu should be (Object*) to accommodate various
> levels of granularity correctly (with dumb cast above it's just
> cosmetics though as long as we treat it as Object in non arch
> specific code).
> 
>>>           ms->possible_cpus->cpus[n].type = ms->cpu_type;
>>> -        ms->possible_cpus->cpus[n].arch_id = n;
>>> -
>>> +        ms->possible_cpus->cpus[n].arch_id = arch_id;
>>>           ms->possible_cpus->cpus[n].props.has_socket_id = true;
>>> -        ms->possible_cpus->cpus[n].props.socket_id  =
>>> -                                   n / (ms->smp.cores * ms->smp.threads);
>>> +        ms->possible_cpus->cpus[n].props.socket_id = topo.socket_id;
>>>           ms->possible_cpus->cpus[n].props.has_core_id = true;
>>> -        ms->possible_cpus->cpus[n].props.core_id =
>>> -                                   n / ms->smp.threads % ms->smp.cores;
>>> +        ms->possible_cpus->cpus[n].props.core_id = topo.core_id;
>>>           ms->possible_cpus->cpus[n].props.has_thread_id = true;
>>> -        ms->possible_cpus->cpus[n].props.thread_id = n % ms->smp.threads;
>>> +        ms->possible_cpus->cpus[n].props.thread_id = topo.thread_id;
>>>       }
>>>       return ms->possible_cpus;
>>>   }
>>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>>> index 7212fb5f8f..5dfc0d5c43 100644
>>> --- a/target/loongarch/cpu.c
>>> +++ b/target/loongarch/cpu.c
>>> @@ -16,6 +16,7 @@
>>>   #include "kvm/kvm_loongarch.h"
>>>   #include "exec/exec-all.h"
>>>   #include "cpu.h"
>>> +#include "hw/qdev-properties.h"
>>>   #include "internals.h"
>>>   #include "fpu/softfloat-helpers.h"
>>>   #include "cpu-csr.h"
>>> @@ -780,6 +781,15 @@ static int64_t loongarch_cpu_get_arch_id(CPUState *cs)
>>>   }
>>>   #endif
>>>   
>>> +static Property loongarch_cpu_properties[] = {
>>> +    DEFINE_PROP_UINT32("phy-id", LoongArchCPU, phy_id, UNSET_PHY_ID),
>>
>> IIUC, the phy_id is kind of like the x86 apic_id, but the field is completely
>> derived from topology, so why do you need to define it as a property and then
>> expose it to the user?
> 
> for x86 we do expose apic_id as a property as well, partly from historical pov
> but also it's better to access cpu fields via properties from outside of
> CPU object than directly poke inside of CPU structure from outside of CPU
> (especially if it comes to generic code)
yes, accessing fields via properties is better than directly poking 
internal structure elements. Is there internal property for cpu object? 
so that internal property is invisible for users.

There will be problem if user adds CPU object with apic-id property, for 
example:

qemu-system-x86_64 -display none -no-user-config -m 2048 -nodefaults 
-monitor stdio -machine pc,accel=kvm,usb=off -smp 1,maxcpus=2 -cpu 
IvyBridge-IBRS -qmp unix:/tmp/qmp-sock,server=on,wait=off

(qemu) device_add 
id=cpu-2,driver=IvyBridge-IBRS-x86_64-cpu,socket-id=0,core-id=1,thread-id=0,apic-id=100
Error: Invalid CPU [socket: 50, die: 0, module: 0, core: 0, thread: 0] 
with APIC ID 100, valid index range 0:1

(qemu) device_add 
id=cpu-2,driver=IvyBridge-IBRS-x86_64-cpu,socket-id=0,core-id=1,thread-id=0,apic-id=0
Error: CPU[0] with APIC ID 0 exists


Regards
Bibo Mao
> 
>>
>> Thanks,
>> Zhao
>>
>>


