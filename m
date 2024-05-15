Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBED5C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7AbQ-0004pu-Oc; Wed, 15 May 2024 05:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s7AbN-0004pj-Uh
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:07:09 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s7AbK-0002On-NS
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:07:09 -0400
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8DxV+kRe0RmjgENAA--.18912S3;
 Wed, 15 May 2024 17:06:26 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXbsOe0Rmj4ggAA--.20S3;
 Wed, 15 May 2024 17:06:24 +0800 (CST)
Subject: Re: [PATCH] tests/libqos: Add loongarch virt machine node
To: gaosong <gaosong@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240514115149.3266369-1-maobibo@loongson.cn>
 <5c204548-608d-f956-7616-426b67e3699c@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <4dac9590-7feb-2810-ac69-9bce22acf878@loongson.cn>
Date: Wed, 15 May 2024 17:06:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5c204548-608d-f956-7616-426b67e3699c@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxXbsOe0Rmj4ggAA--.20S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxKw17Xw4xAF1rZryfGry3trc_yoWfZr4DpF
 1xArWUXrWUJr1fJ34Dt3WUWFy5ArsrJa4UXFyIqF40yF4DCryjgr1jqr1qgF17Xr48Gr1U
 Zr1kWwsxZw1UGrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
 0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280
 aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
 xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
 xVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
 C2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
 JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
 WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
 daVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.127,
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



On 2024/5/15 下午5:01, gaosong wrote:
> 在 2024/5/14 下午7:51, Bibo Mao 写道:
>> Add loongarch virt machine to the graph. It is a modified copy of
>> the existing riscv virtmachine in riscv-virt-machine.c
>>
>> It contains a generic-pcihost controller, and an extra function
>> loongarch_config_qpci_bus() to configure GPEX pci host controller
>> information, such as ecam and pio_base addresses.
>>
>> Also hotplug handle checking about TYPE_VIRTIO_IOMMU_PCI device is
>> added on loongarch virt machine, since virtio_mmu_pci device requires
>> it.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
> qos-test failed.
> 
>   6/14 qemu:qtest+qtest-loongarch64 / 
> qtest-loongarch64/qos-test                       TIMEOUT 120.01s killed 
> by signal 11 SIGSEGV
>  >>> QTEST_QEMU_IMG=./qemu-img 
> PYTHON=/root/work/code/clean/github/qemu/build/pyvenv/bin/python3 
> QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon 
> MALLOC_PERTURB_=47 
> G_TEST_DBUS_DAEMON=/root/work/code/clean/github/qemu/tests/dbus-vmstate-daemon.sh 
> QTEST_QEMU_BINARY=./qemu-system-loongarch64 
> /root/work/code/clean/github/qemu/build/tests/qtest/qos-test --tap -k
> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― ✀ 
> ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> stderr:
> qemu-system-loongarch64: ram_size must be greater than 1G.
> Broken pipe
> ../tests/qtest/libqtest.c:195: kill_qemu() tried to terminate QEMU 
> process but encountered exit status 1 (expected 0)
> 
> TAP parsing error: Too few tests run (expected 128, got 60)
> 
> I think this patch depends on your numa series and migration series 
> patches.
Yes, it depends on numa/migration testcase patchset.

Regards
Bibo Mao
> 
> Thanks.
> Song Gao
>>   hw/loongarch/virt.c                         |   2 +
>>   tests/qtest/libqos/loongarch-virt-machine.c | 114 ++++++++++++++++++++
>>   tests/qtest/libqos/meson.build              |   1 +
>>   3 files changed, 117 insertions(+)
>>   create mode 100644 tests/qtest/libqos/loongarch-virt-machine.c
>>
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index db43b2fe4b..7f5ef87be4 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -45,6 +45,7 @@
>>   #include "sysemu/tpm.h"
>>   #include "sysemu/block-backend.h"
>>   #include "hw/block/flash.h"
>> +#include "hw/virtio/virtio-iommu.h"
>>   #include "qemu/error-report.h"
>>   static PFlashCFI01 *virt_flash_create1(LoongArchVirtMachineState *lvms,
>> @@ -1212,6 +1213,7 @@ static HotplugHandler 
>> *virt_get_hotplug_handler(MachineState *machine,
>>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>>       if (device_is_dynamic_sysbus(mc, dev) ||
>> +        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
>>           memhp_type_supported(dev)) {
>>           return HOTPLUG_HANDLER(machine);
>>       }
>> diff --git a/tests/qtest/libqos/loongarch-virt-machine.c 
>> b/tests/qtest/libqos/loongarch-virt-machine.c
>> new file mode 100644
>> index 0000000000..c12089c015
>> --- /dev/null
>> +++ b/tests/qtest/libqos/loongarch-virt-machine.c
>> @@ -0,0 +1,114 @@
>> +/*
>> + * libqos driver framework
>> + *
>> + * Copyright (c) 2018 Emanuele Giuseppe Esposito 
>> <e.emanuelegiuseppe@gmail.com>
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License version 2.1 as published by the Free Software Foundation.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, see 
>> <http://www.gnu.org/licenses/>
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "../libqtest.h"
>> +#include "qemu/module.h"
>> +#include "libqos-malloc.h"
>> +#include "qgraph.h"
>> +#include "virtio-mmio.h"
>> +#include "generic-pcihost.h"
>> +#include "hw/pci/pci_regs.h"
>> +
>> +#define LOONGARCH_PAGE_SIZE               0x1000
>> +#define LOONGARCH_VIRT_RAM_ADDR           0x100000
>> +#define LOONGARCH_VIRT_RAM_SIZE           0xFF00000
>> +
>> +#define LOONGARCH_VIRT_PIO_BASE           0x18000000
>> +#define LOONGARCH_VIRT_PCIE_PIO_OFFSET    0x4000
>> +#define LOONGARCH_VIRT_PCIE_PIO_LIMIT     0x10000
>> +#define LOONGARCH_VIRT_PCIE_ECAM_BASE     0x20000000
>> +#define LOONGARCH_VIRT_PCIE_MMIO32_BASE   0x40000000
>> +#define LOONGARCH_VIRT_PCIE_MMIO32_LIMIT  0x80000000
>> +
>> +typedef struct QVirtMachine QVirtMachine;
>> +
>> +struct QVirtMachine {
>> +    QOSGraphObject obj;
>> +    QGuestAllocator alloc;
>> +    QVirtioMMIODevice virtio_mmio;
>> +    QGenericPCIHost bridge;
>> +};
>> +
>> +static void virt_destructor(QOSGraphObject *obj)
>> +{
>> +    QVirtMachine *machine = (QVirtMachine *) obj;
>> +    alloc_destroy(&machine->alloc);
>> +}
>> +
>> +static void *virt_get_driver(void *object, const char *interface)
>> +{
>> +    QVirtMachine *machine = object;
>> +    if (!g_strcmp0(interface, "memory")) {
>> +        return &machine->alloc;
>> +    }
>> +
>> +    fprintf(stderr, "%s not present in loongarch/virtio\n", interface);
>> +    g_assert_not_reached();
>> +}
>> +
>> +static QOSGraphObject *virt_get_device(void *obj, const char *device)
>> +{
>> +    QVirtMachine *machine = obj;
>> +    if (!g_strcmp0(device, "generic-pcihost")) {
>> +        return &machine->bridge.obj;
>> +    } else if (!g_strcmp0(device, "virtio-mmio")) {
>> +        return &machine->virtio_mmio.obj;
>> +    }
>> +
>> +    fprintf(stderr, "%s not present in loongarch/virt\n", device);
>> +    g_assert_not_reached();
>> +}
>> +
>> +static void loongarch_config_qpci_bus(QGenericPCIBus *qpci)
>> +{
>> +    qpci->gpex_pio_base = LOONGARCH_VIRT_PIO_BASE;
>> +    qpci->bus.pio_alloc_ptr = LOONGARCH_VIRT_PCIE_PIO_OFFSET;
>> +    qpci->bus.pio_limit = LOONGARCH_VIRT_PCIE_PIO_LIMIT;
>> +    qpci->bus.mmio_alloc_ptr = LOONGARCH_VIRT_PCIE_MMIO32_BASE;
>> +    qpci->bus.mmio_limit = LOONGARCH_VIRT_PCIE_MMIO32_LIMIT;
>> +    qpci->ecam_alloc_ptr = LOONGARCH_VIRT_PCIE_ECAM_BASE;
>> +}
>> +
>> +static void *qos_create_machine_loongarch_virt(QTestState *qts)
>> +{
>> +    QVirtMachine *machine = g_new0(QVirtMachine, 1);
>> +
>> +    alloc_init(&machine->alloc, 0,
>> +               LOONGARCH_VIRT_RAM_ADDR,
>> +               LOONGARCH_VIRT_RAM_ADDR + LOONGARCH_VIRT_RAM_SIZE,
>> +               LOONGARCH_PAGE_SIZE);
>> +
>> +    qos_create_generic_pcihost(&machine->bridge, qts, &machine->alloc);
>> +    loongarch_config_qpci_bus(&machine->bridge.pci);
>> +
>> +    machine->obj.get_device = virt_get_device;
>> +    machine->obj.get_driver = virt_get_driver;
>> +    machine->obj.destructor = virt_destructor;
>> +    return machine;
>> +}
>> +
>> +static void virt_machine_register_nodes(void)
>> +{
>> +    qos_node_create_machine_args("loongarch64/virt",
>> +                                 qos_create_machine_loongarch_virt,
>> +                                 " -cpu la464");
>> +    qos_node_contains("loongarch64/virt", "generic-pcihost", NULL);
>> +}
>> +
>> +libqos_init(virt_machine_register_nodes);
>> diff --git a/tests/qtest/libqos/meson.build 
>> b/tests/qtest/libqos/meson.build
>> index 3aed6efcb8..558eb4c24b 100644
>> --- a/tests/qtest/libqos/meson.build
>> +++ b/tests/qtest/libqos/meson.build
>> @@ -61,6 +61,7 @@ libqos_srcs = files(
>>           'ppc64_pseries-machine.c',
>>           'x86_64_pc-machine.c',
>>           'riscv-virt-machine.c',
>> +        'loongarch-virt-machine.c',
>>   )
>>   if have_virtfs
>>
>> base-commit: dafec285bdbfe415ac6823abdc510e0b92c3f094


