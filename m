Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BD7CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 04:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPvFq-00014S-1f; Thu, 21 May 2026 00:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPvFo-00013l-7s; Thu, 21 May 2026 00:43:28 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPvFl-0003Oq-MO; Thu, 21 May 2026 00:43:27 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64L4hJmb051138
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 21 May 2026 13:43:19 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=H4pXrTLxtLklurT0dQMZJFFwX+t+Pw/T6jSaC1qidss=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1779338599; v=1;
 b=sfeVbTiYZAtCjIMSDF/2CIoKt1k1v74MErjXZE2pRskLBTXuRY+X+AKYV3DtEil3
 fKLtsGrfkayRz5zL0ckBYpKdw4M/dQYVcr8d9lQvg4w8oyrov3yn5pIwlBwKArIS
 lY1STeHHUz1REaLsOuWCrj5VJjxz6BYMep3cBPjnxfJygCMBDgdhc53I9mUazPv9
 A9ZONrZpFBuQVKWYocae2QhqYK2l6Ve94w85CXenDbcA8OtspEbCDiNJYklXWWTc
 0Ds2mlaee7kNnyzvsnWeMZZbOManLtwmZjn7BqGFUWhrsOEzJ+WJ224hukfcB6GN
 uM0G+s6IrAjrCqP+mOLgcQ==
Message-ID: <ea0ee6f6-4753-45d4-ac55-a4ccbf6b7cf7@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 21 May 2026 13:43:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] hw/arm/virt: Remove the lower bound of HighMem IO
 Regions
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, "Michael S. Tsirkin"
 <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260520-virt-v6-0-d96180454fdf@rsg.ci.i.u-tokyo.ac.jp>
 <20260520-virt-v6-3-d96180454fdf@rsg.ci.i.u-tokyo.ac.jp>
 <20260520155152.3652a6e9@imammedo>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260520155152.3652a6e9@imammedo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

On 2026/05/20 22:51, Igor Mammedov wrote:
> On Wed, 20 May 2026 18:56:32 +0900
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> 
>> Remove the lower bound of the Highmem IO Regions' addresses for the
>> latest machine version to increase the chance to fit the regions in the
>> PA space.
>>
>> The lower bound was especially problematic when using virt-install on
>> Apple M2. virt-install 5.0.0 adds multiple pcie-root-port devices that
> 
> it looks like with this patch everything would move down,
> with 'small' but, VIRT_HIGH_PCIE_MMIO that still won't fit into M2 PA and
> will get disabled.
> Is it intended (perhaps it should be mentioned in patch)

Yes. It is another opportunity for improvement, but out of scopoe of 
this patch.

> 
> 
>> require sufficient space in the ECAM region. However, the Highmem ECAM
>> region did not fit in the limited PA space on the hardware, and the ECAM
>> region size was limited to 16 MiB. If virt-install had added more than
>> 16 devices to the root bridge, the region overflowed, which prevented
>> edk2-stable202505 from scanning PCI devices, including the boot disk,
>> causing boot failures.
>>
>> Ideally, a virtual machine with more than 16 devices added to the root
>> bridge should just work so that users and management layers do not have
>> to care whether they use constrained hardware.
>>
>> The base address of the Highmem IO Regions was fixed when commit
>> f90747c4e8fb ("hw/arm/virt: GICv3 DT node with one or two redistributor
>> regions") added the first Highmem IO Region. Later, commit 957e32cffa57
>> ("hw/arm/virt: Dynamic memory map depending on RAM requirements")
>> allowed moving the Highmem IO Regions to higher addresses to accommodate
>> RAM more than 255 GiB, but the lower bound remained to keep the legacy
>> memory map.
>>
>> Remove the lower bound for the latest machine version to accommodate
>> more devices with the root bridge. Keeping the lower bound for the old
>> machine versions ensures the compatibility is still maintained.
>>
>> The hardcoded memory map in tests/qtest/libqos/generic-pcihost.c is also
>> updated.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>   include/hw/arm/virt.h                |  1 +
>>   hw/arm/virt.c                        | 17 +++++++++++------
>>   tests/qtest/libqos/generic-pcihost.c |  2 +-
>>   3 files changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>> index 3ba33b4bd274..6c8ba8f3185b 100644
>> --- a/include/hw/arm/virt.h
>> +++ b/include/hw/arm/virt.h
>> @@ -142,6 +142,7 @@ typedef enum VirtGICType {
>>   
>>   struct VirtMachineClass {
>>       MachineClass parent;
>> +    hwaddr min_highmem_base;
>>       bool no_tcg_its;
>>       bool no_highmem_compact;
>>       bool no_kvm_steal_time;
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index b090233893c5..78a85a966ad7 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -229,8 +229,7 @@ static const MemMapEntry base_memmap[] = {
>>    * Highmem IO Regions: This memory map is floating, located after the RAM.
>>    * Each MemMapEntry base (GPA) will be dynamically computed, depending on the
>>    * top of the RAM, so that its base get the same alignment as the size,
>> - * ie. a 512GiB entry will be aligned on a 512GiB boundary. If there is
>> - * less than 256GiB of RAM, the floating area starts at the 256GiB mark.
>> + * ie. a 512GiB entry will be aligned on a 512GiB boundary.
>>    * Note the extended_memmap is sized so that it eventually also includes the
>>    * base_memmap entries (VIRT_HIGH_GIC_REDIST2 index is greater than the last
>>    * index of base_memmap).
>> @@ -2479,6 +2478,7 @@ static void virt_set_high_memmap(VirtMachineState *vms,
>>   static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
>>   {
>>       MachineState *ms = MACHINE(vms);
>> +    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>>       hwaddr base, device_memory_base, device_memory_size, memtop;
>>       int i;
>>   
>> @@ -2505,8 +2505,7 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
>>       /*
>>        * We compute the base of the high IO region depending on the
>>        * amount of initial and device memory. The device memory start/size
>> -     * is aligned on 1GiB. We never put the high IO region below 256GiB
>> -     * so that if maxram_size is < 255GiB we keep the legacy memory map.
>> +     * is aligned on 1GiB.
>>        * The device region size assumes 1GiB page max alignment per slot.
>>        */
>>       device_memory_base =
>> @@ -2524,8 +2523,8 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
>>           error_report("maxmem/slots too huge");
>>           exit(EXIT_FAILURE);
>>       }
>> -    if (base < vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES) {
>> -        base = vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
>> +    if (base < vmc->min_highmem_base) {
>> +        base = vmc->min_highmem_base;
>>       }
>>   
>>       /* We know for sure that at least the memory fits in the PA space */
>> @@ -4367,6 +4366,12 @@ static void virt_machine_11_0_options(MachineClass *mc)
>>       virt_machine_11_1_options(mc);
>>       compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len);
>>       vmc->hvf_no_kernel_irqchip_default = true;
>> +
>> +    /*
>> +     * Do not put the high IO region below 256GiB so that if maxram_size is
>> +     * < 255GiB we keep the legacy memory map.
>> +     */
>> +    vmc->min_highmem_base = base_memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
>>   }
>>   DEFINE_VIRT_MACHINE(11, 0)
>>   
>> diff --git a/tests/qtest/libqos/generic-pcihost.c b/tests/qtest/libqos/generic-pcihost.c
>> index b77617524cac..287e8445ec5b 100644
>> --- a/tests/qtest/libqos/generic-pcihost.c
>> +++ b/tests/qtest/libqos/generic-pcihost.c
>> @@ -210,7 +210,7 @@ void qpci_init_generic(QGenericPCIBus *qpci, QTestState *qts,
>>       qpci->bus.pio_limit = 0x10000;
>>       qpci->bus.mmio_alloc_ptr = 0x10000000;
>>       qpci->bus.mmio_limit = 0x2eff0000;
>> -    qpci->ecam_alloc_ptr = 0x4010000000;
>> +    qpci->ecam_alloc_ptr = 0x90000000;
>>   
>>       qpci->obj.get_driver = qpci_generic_get_driver;
>>   }
>>
> 


