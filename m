Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82ABCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJ7s-0000hP-Py; Tue, 04 Nov 2025 10:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.riscv@isrc.iscas.ac.cn>)
 id 1vGJ7Z-0000c5-OU; Tue, 04 Nov 2025 10:38:58 -0500
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <chao.liu.riscv@isrc.iscas.ac.cn>)
 id 1vGJ7T-0002g8-MK; Tue, 04 Nov 2025 10:38:56 -0500
Received: from [192.168.71.4] (unknown [114.88.97.170])
 by APP-03 (Coremail) with SMTP id rQCowADXU+v+HQpp5IZ0AQ--.31075S2;
 Tue, 04 Nov 2025 23:38:38 +0800 (CST)
Message-ID: <07a70da2-9356-48ab-ba1c-9a1d0c5a5fb1@isrc.iscas.ac.cn>
Date: Tue, 4 Nov 2025 23:38:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 1/1] hw/riscv/server_platform_ref.c: add virtio bus
To: Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wangjingwei@iscas.ac.cn
References: <cover.1762172539.git.chao.liu.riscv@isrc.iscas.ac.cn>
 <38a180e7ed4014ba7d401dc9b8de755fadf33bea.1762172539.git.chao.liu.riscv@isrc.iscas.ac.cn>
 <4e825697-e57c-4f77-8920-9f18b787e425@ventanamicro.com>
 <20251104-7b7ec269da2412cc24e99234@orel>
From: Chao Liu <chao.liu.riscv@isrc.iscas.ac.cn>
In-Reply-To: <20251104-7b7ec269da2412cc24e99234@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADXU+v+HQpp5IZ0AQ--.31075S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw1fKr43CF48WF1DKr17KFg_yoW7XFWfpr
 4UGF4rKa1DGF13KF93Z3WUKa1Yywn7CF43uw1IgF48Crn09FnrG34UG348WFyxAr18Gr1j
 9F4DuFWSkF95Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK
 82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
 C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
 MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
 IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
 87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07betCcUUUUU=
X-Originating-IP: [114.88.97.170]
X-CM-SenderInfo: pfkd0hholxh2hlvf4qplvuuh5lvft2wodfhubq/1tbiBwsQAGkKFlkapwAAsN
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=chao.liu.riscv@isrc.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/4/2025 10:19 PM, Andrew Jones wrote:
> On Tue, Nov 04, 2025 at 09:55:40AM -0300, Daniel Henrique Barboza wrote:
>> CCing Drew since he's the TG chair for this spec
>>
>> On 11/3/25 9:39 AM, Chao Liu wrote:
>>> Add an always present virtio bus for the rvsp-ref board.
>>>
>>> The IRQs being used are similar to what the 'virt' board is using: IRQs
>>> 40 to 47, one IRQ for queue.
>>>
>>> Signed-off-by: Chao Liu <chao.liu.riscv@isrc.iscas.ac.cn>
>>> ---
>>>    hw/riscv/server_platform_ref.c | 42 ++++++++++++++++++++++++++++++++--
>>>    1 file changed, 40 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
>>> index 975f07ddfb..24c3fc2e41 100644
>>> --- a/hw/riscv/server_platform_ref.c
>>> +++ b/hw/riscv/server_platform_ref.c
>>> @@ -46,6 +46,7 @@
>>>    #include "target/riscv/cpu.h"
>>>    #include "target/riscv/pmu.h"
>>>    #include "net/net.h"
>>> +#include "hw/virtio/virtio-mmio.h"
>>>    #define RVSP_CPUS_MAX_BITS             9
>>>    #define RVSP_CPUS_MAX                  (1 << RVSP_CPUS_MAX_BITS)
>>> @@ -108,16 +109,20 @@ enum {
>>>        RVSP_PCIE_MMIO,
>>>        RVSP_PCIE_PIO,
>>>        RVSP_PCIE_ECAM,
>>> -    RVSP_PCIE_MMIO_HIGH
>>> +    RVSP_PCIE_MMIO_HIGH,
>>> +    RVSP_VIRTIO
>>>    };
>>>    enum {
>>>        RVSP_UART0_IRQ = 10,
>>>        RVSP_RTC_IRQ = 11,
>>>        RVSP_PCIE_IRQ = 0x20, /* 32 to 35 */
>>> -    IOMMU_SYS_IRQ = 0x24 /* 36 to 39 */
>>> +    IOMMU_SYS_IRQ = 0x24, /* 36 to 39 */
>>> +    RVSP_VIRTIO_IRQ = 0x28 /* 40 to 47 */
>>>    };
>>> +#define RVSP_VIRTIO_COUNT 8
>>> +
>>>    /*
>>>     * The server soc reference machine physical address space used by some of the
>>>     * devices namely ACLINT, APLIC and IMSIC depend on number of Sockets, number
>>> @@ -151,6 +156,7 @@ static const MemMapEntry rvsp_ref_memmap[] = {
>>>        [RVSP_APLIC_M] =        {  0xc000000, APLIC_SIZE(RVSP_CPUS_MAX) },
>>>        [RVSP_APLIC_S] =        {  0xd000000, APLIC_SIZE(RVSP_CPUS_MAX) },
>>>        [RVSP_UART0] =          { 0x10000000,         0x100 },
>>> +    [RVSP_VIRTIO] =         { 0x10001000,        0x1000 },
>>>        [RVSP_FLASH] =          { 0x20000000,     0x4000000 },
>>>        [RVSP_IMSIC_M] =        { 0x24000000, RVSP_IMSIC_MAX_SIZE },
>>>        [RVSP_IMSIC_S] =        { 0x28000000, RVSP_IMSIC_MAX_SIZE },
>>> @@ -816,6 +822,29 @@ static void create_fdt_flash(RVSPMachineState *s, const MemMapEntry *memmap)
>>>        qemu_fdt_setprop_cell(ms->fdt, name, "bank-width", 4);
>>>    }
>>> +static void create_fdt_virtio(RVSPMachineState *s, uint32_t irq_virtio_phandle)
>>> +{
>>> +    int i;
>>> +    MachineState *ms = MACHINE(s);
>>> +    hwaddr virtio_base = rvsp_ref_memmap[RVSP_VIRTIO].base;
>>> +
>>> +    for (i = 0; i < RVSP_VIRTIO_COUNT; i++) {
>>> +        g_autofree char *name = NULL;
>>> +        uint64_t size = rvsp_ref_memmap[RVSP_VIRTIO].size;
>>> +        hwaddr addr = virtio_base + i * size;
>>> +
>>> +        name = g_strdup_printf("/soc/virtio_mmio@%"HWADDR_PRIx, addr);
>>> +
>>> +        qemu_fdt_add_subnode(ms->fdt, name);
>>> +        qemu_fdt_setprop_string(ms->fdt, name, "compatible", "virtio,mmio");
>>> +        qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg", 2, addr, 2, size);
>>> +        qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
>>> +            irq_virtio_phandle);
>>> +        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts",
>>> +                            RVSP_VIRTIO_IRQ + i, 0x4);
>>> +    }
>>> +}
>>> +
>>>    static void finalize_fdt(RVSPMachineState *s)
>>>    {
>>>        uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
>>> @@ -835,6 +864,8 @@ static void finalize_fdt(RVSPMachineState *s)
>>>        create_fdt_uart(s, rvsp_ref_memmap, irq_mmio_phandle);
>>>        create_fdt_rtc(s, rvsp_ref_memmap, irq_mmio_phandle);
>>> +
>>> +    create_fdt_virtio(s, irq_mmio_phandle);
>>>    }
>>>    static void create_fdt(RVSPMachineState *s, const MemMapEntry *memmap)
>>> @@ -1205,6 +1236,13 @@ static void rvsp_ref_machine_init(MachineState *machine)
>>>            }
>>>        }
>>> +    /* VirtIO MMIO devices */
>>> +    for (i = 0; i < RVSP_VIRTIO_COUNT; i++) {
>>> +        sysbus_create_simple("virtio-mmio",
>>> +            memmap[RVSP_VIRTIO].base + i * memmap[RVSP_VIRTIO].size,
>>> +            qdev_get_gpio_in(mmio_irqchip, RVSP_VIRTIO_IRQ + i));
>>> +    }
>>> +
>>
>> When you said virtio support I thought about virtio-pci and virtio-net-pci. I'm not sure if
>> we need a virtio-mmio for that.
>>
>> Also, I can't say if adding a device like virtio-mmio might conflict with something else from
>> the server plat specification. Drew, care to comment?
> 
> I'd rather we don't add virtio-mmio to the reference platform. In
> hindsight, I guess the only reason virtio was brought up was for
> virtio-mmio, since virtio-pci devices could already have been used.
> So I apologize for misleading by saying adding virtio support was
> fine.
> 
> Let's discuss the motivation. Which virtio devices were intended to
> be added to these virtio-mmio transports?
> 

Looking at it this way, we really don’t need to add virtio-mmio. At first, I added it to help
EDK II recognize the OS image.

Thanks for Drew’s reminder. With the command below, I can now make EDK II recognize the OS image:

```
   $QEMU ... \
   -drive file=$drive,format=qcow2,id=virtio-drive,if=none \
   -device virtio-blk-pci,drive=virtio-drive,id=virtio-blk-0
```

Thanks,
Chao


