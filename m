Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCFCC3064D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 04:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMK0x-0000r7-WC; Wed, 26 Jun 2024 00:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sMK0s-0000oz-Ns
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 00:12:06 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sMK0p-0005m0-8f
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 00:12:06 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bxa+oIlXtm_yMKAA--.41083S3;
 Wed, 26 Jun 2024 12:11:52 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxJMUFlXtmeXYxAA--.41471S3; 
 Wed, 26 Jun 2024 12:11:51 +0800 (CST)
Subject: Re: [PATCH v3 1/4] hw/intc: Remove loongarch_ipi.c
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
 <20240605-loongson3-ipi-v3-1-ddd2c0e03fa3@flygoat.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <e1b8bbd8-2a9d-2417-1123-4aabfdedb684@loongson.cn>
Date: Wed, 26 Jun 2024 12:11:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240605-loongson3-ipi-v3-1-ddd2c0e03fa3@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxJMUFlXtmeXYxAA--.41471S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWfJFy5try7ZF45tw47Kr1xWFX_yoWDAF47pr
 ZxZF4xWF4rtrsrWF1DJa1DWF1DCw1fWFy3tanYkwnY9F4kWr1q9Fyvy3yava4kA347Aw1F
 vFsrGFZxXF4DtwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzZ2-
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.423,
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



On 2024/6/5 上午10:15, Jiaxun Yang wrote:
> It was missed out in previous commit.
> 
> Fixes: b4a12dfc2132 ("hw/intc/loongarch_ipi: Rename as loongson_ipi")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   hw/intc/loongarch_ipi.c | 347 ------------------------------------------------
>   1 file changed, 347 deletions(-)
> 
> diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
> deleted file mode 100644
> index 44b3b9c138d6..000000000000
> --- a/hw/intc/loongarch_ipi.c
> +++ /dev/null
> @@ -1,347 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * LoongArch ipi interrupt support
> - *
> - * Copyright (C) 2021 Loongson Technology Corporation Limited
> - */
> -
> -#include "qemu/osdep.h"
> -#include "hw/boards.h"
> -#include "hw/sysbus.h"
> -#include "hw/intc/loongarch_ipi.h"
> -#include "hw/irq.h"
> -#include "hw/qdev-properties.h"
> -#include "qapi/error.h"
> -#include "qemu/log.h"
> -#include "exec/address-spaces.h"
> -#include "migration/vmstate.h"
> -#include "target/loongarch/cpu.h"
> -#include "trace.h"
> -
> -static MemTxResult loongarch_ipi_readl(void *opaque, hwaddr addr,
> -                                       uint64_t *data,
> -                                       unsigned size, MemTxAttrs attrs)
> -{
> -    IPICore *s;
> -    LoongArchIPI *ipi = opaque;
> -    uint64_t ret = 0;
> -    int index = 0;
> -
> -    s = &ipi->cpu[attrs.requester_id];
> -    addr &= 0xff;
> -    switch (addr) {
> -    case CORE_STATUS_OFF:
> -        ret = s->status;
> -        break;
> -    case CORE_EN_OFF:
> -        ret = s->en;
> -        break;
> -    case CORE_SET_OFF:
> -        ret = 0;
> -        break;
> -    case CORE_CLEAR_OFF:
> -        ret = 0;
> -        break;
> -    case CORE_BUF_20 ... CORE_BUF_38 + 4:
> -        index = (addr - CORE_BUF_20) >> 2;
> -        ret = s->buf[index];
> -        break;
> -    default:
> -        qemu_log_mask(LOG_UNIMP, "invalid read: %x", (uint32_t)addr);
> -        break;
> -    }
> -
> -    trace_loongarch_ipi_read(size, (uint64_t)addr, ret);
> -    *data = ret;
> -    return MEMTX_OK;
> -}
> -
> -static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr,
> -                          MemTxAttrs attrs)
> -{
> -    int i, mask = 0, data = 0;
> -
> -    /*
> -     * bit 27-30 is mask for byte writing,
> -     * if the mask is 0, we need not to do anything.
> -     */
> -    if ((val >> 27) & 0xf) {
> -        data = address_space_ldl(env->address_space_iocsr, addr,
> -                                 attrs, NULL);
> -        for (i = 0; i < 4; i++) {
> -            /* get mask for byte writing */
> -            if (val & (0x1 << (27 + i))) {
> -                mask |= 0xff << (i * 8);
> -            }
> -        }
> -    }
> -
> -    data &= mask;
> -    data |= (val >> 32) & ~mask;
> -    address_space_stl(env->address_space_iocsr, addr,
> -                      data, attrs, NULL);
> -}
> -
> -static int archid_cmp(const void *a, const void *b)
> -{
> -   CPUArchId *archid_a = (CPUArchId *)a;
> -   CPUArchId *archid_b = (CPUArchId *)b;
> -
> -   return archid_a->arch_id - archid_b->arch_id;
> -}
> -
> -static CPUArchId *find_cpu_by_archid(MachineState *ms, uint32_t id)
> -{
> -    CPUArchId apic_id, *found_cpu;
> -
> -    apic_id.arch_id = id;
> -    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
> -        ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
> -        archid_cmp);
> -
> -    return found_cpu;
> -}
> -
> -static CPUState *ipi_getcpu(int arch_id)
> -{
> -    MachineState *machine = MACHINE(qdev_get_machine());
> -    CPUArchId *archid;
> -
> -    archid = find_cpu_by_archid(machine, arch_id);
> -    if (archid) {
> -        return CPU(archid->cpu);
> -    }
> -
> -    return NULL;
> -}
> -
> -static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
> -{
> -    uint32_t cpuid;
> -    hwaddr addr;
> -    CPUState *cs;
> -
> -    cpuid = extract32(val, 16, 10);
> -    cs = ipi_getcpu(cpuid);
> -    if (cs == NULL) {
> -        return MEMTX_DECODE_ERROR;
> -    }
> -
> -    /* override requester_id */
> -    addr = SMP_IPI_MAILBOX + CORE_BUF_20 + (val & 0x1c);
> -    attrs.requester_id = cs->cpu_index;
> -    send_ipi_data(&LOONGARCH_CPU(cs)->env, val, addr, attrs);
> -    return MEMTX_OK;
> -}
> -
> -static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
> -{
> -    uint32_t cpuid;
> -    hwaddr addr;
> -    CPUState *cs;
> -
> -    cpuid = extract32(val, 16, 10);
> -    cs = ipi_getcpu(cpuid);
> -    if (cs == NULL) {
> -        return MEMTX_DECODE_ERROR;
> -    }
> -
> -    /* override requester_id */
> -    addr = val & 0xffff;
> -    attrs.requester_id = cs->cpu_index;
> -    send_ipi_data(&LOONGARCH_CPU(cs)->env, val, addr, attrs);
> -    return MEMTX_OK;
> -}
> -
> -static MemTxResult loongarch_ipi_writel(void *opaque, hwaddr addr, uint64_t val,
> -                                        unsigned size, MemTxAttrs attrs)
> -{
> -    LoongArchIPI *ipi = opaque;
> -    IPICore *s;
> -    int index = 0;
> -    uint32_t cpuid;
> -    uint8_t vector;
> -    CPUState *cs;
> -
> -    s = &ipi->cpu[attrs.requester_id];
> -    addr &= 0xff;
> -    trace_loongarch_ipi_write(size, (uint64_t)addr, val);
> -    switch (addr) {
> -    case CORE_STATUS_OFF:
> -        qemu_log_mask(LOG_GUEST_ERROR, "can not be written");
> -        break;
> -    case CORE_EN_OFF:
> -        s->en = val;
> -        break;
> -    case CORE_SET_OFF:
> -        s->status |= val;
> -        if (s->status != 0 && (s->status & s->en) != 0) {
> -            qemu_irq_raise(s->irq);
> -        }
> -        break;
> -    case CORE_CLEAR_OFF:
> -        s->status &= ~val;
> -        if (s->status == 0 && s->en != 0) {
> -            qemu_irq_lower(s->irq);
> -        }
> -        break;
> -    case CORE_BUF_20 ... CORE_BUF_38 + 4:
> -        index = (addr - CORE_BUF_20) >> 2;
> -        s->buf[index] = val;
> -        break;
> -    case IOCSR_IPI_SEND:
> -        cpuid = extract32(val, 16, 10);
> -        /* IPI status vector */
> -        vector = extract8(val, 0, 5);
> -        cs = ipi_getcpu(cpuid);
> -        if (cs == NULL) {
> -            return MEMTX_DECODE_ERROR;
> -        }
> -
> -        /* override requester_id */
> -        attrs.requester_id = cs->cpu_index;
> -        loongarch_ipi_writel(ipi, CORE_SET_OFF, BIT(vector), 4, attrs);
> -        break;
> -    default:
> -        qemu_log_mask(LOG_UNIMP, "invalid write: %x", (uint32_t)addr);
> -        break;
> -    }
> -
> -    return MEMTX_OK;
> -}
> -
> -static const MemoryRegionOps loongarch_ipi_ops = {
> -    .read_with_attrs = loongarch_ipi_readl,
> -    .write_with_attrs = loongarch_ipi_writel,
> -    .impl.min_access_size = 4,
> -    .impl.max_access_size = 4,
> -    .valid.min_access_size = 4,
> -    .valid.max_access_size = 8,
> -    .endianness = DEVICE_LITTLE_ENDIAN,
> -};
> -
> -/* mail send and any send only support writeq */
> -static MemTxResult loongarch_ipi_writeq(void *opaque, hwaddr addr, uint64_t val,
> -                                        unsigned size, MemTxAttrs attrs)
> -{
> -    MemTxResult ret = MEMTX_OK;
> -
> -    addr &= 0xfff;
> -    switch (addr) {
> -    case MAIL_SEND_OFFSET:
> -        ret = mail_send(val, attrs);
> -        break;
> -    case ANY_SEND_OFFSET:
> -        ret = any_send(val, attrs);
> -        break;
> -    default:
> -       break;
> -    }
> -
> -    return ret;
> -}
> -
> -static const MemoryRegionOps loongarch_ipi64_ops = {
> -    .write_with_attrs = loongarch_ipi_writeq,
> -    .impl.min_access_size = 8,
> -    .impl.max_access_size = 8,
> -    .valid.min_access_size = 8,
> -    .valid.max_access_size = 8,
> -    .endianness = DEVICE_LITTLE_ENDIAN,
> -};
> -
> -static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
> -{
> -    LoongArchIPI *s = LOONGARCH_IPI(dev);
> -    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> -    int i;
> -
> -    if (s->num_cpu == 0) {
> -        error_setg(errp, "num-cpu must be at least 1");
> -        return;
> -    }
> -
> -    memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev), &loongarch_ipi_ops,
> -                          s, "loongarch_ipi_iocsr", 0x48);
> -
> -    /* loongarch_ipi_iocsr performs re-entrant IO through ipi_send */
> -    s->ipi_iocsr_mem.disable_reentrancy_guard = true;
> -
> -    sysbus_init_mmio(sbd, &s->ipi_iocsr_mem);
> -
> -    memory_region_init_io(&s->ipi64_iocsr_mem, OBJECT(dev),
> -                          &loongarch_ipi64_ops,
> -                          s, "loongarch_ipi64_iocsr", 0x118);
> -    sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
It is different with existing implementation.

With hw/intc/loongson_ipi.c, every vcpu has one ipi_mmio_mem, however on 
loongarch ipi machine, there is no ipi_mmio_mem memory region.

So if machine has 256 vcpus, there will be 256 ipi_mmio_mem memory 
regions. In function sysbus_init_mmio(), memory region can not exceed
QDEV_MAX_MMIO (32).  With so many memory regions, it slows down memory
region search speed also.

void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory)
{
     int n;

     assert(dev->num_mmio < QDEV_MAX_MMIO);
     n = dev->num_mmio++;
     dev->mmio[n].addr = -1;
     dev->mmio[n].memory = memory;
}

Can we revert this patch? We want to do production usable by real users 
rather than show pure technology.

Regards
Bibo Mao

> -
> -    s->cpu = g_new0(IPICore, s->num_cpu);
> -    if (s->cpu == NULL) {
> -        error_setg(errp, "Memory allocation for ExtIOICore faile");
> -        return;
> -    }
> -
> -    for (i = 0; i < s->num_cpu; i++) {
> -        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
> -    }
> -}
> -
> -static const VMStateDescription vmstate_ipi_core = {
> -    .name = "ipi-single",
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> -    .fields = (const VMStateField[]) {
> -        VMSTATE_UINT32(status, IPICore),
> -        VMSTATE_UINT32(en, IPICore),
> -        VMSTATE_UINT32(set, IPICore),
> -        VMSTATE_UINT32(clear, IPICore),
> -        VMSTATE_UINT32_ARRAY(buf, IPICore, IPI_MBX_NUM * 2),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
> -static const VMStateDescription vmstate_loongarch_ipi = {
> -    .name = TYPE_LOONGARCH_IPI,
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> -    .fields = (const VMStateField[]) {
> -        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongArchIPI, num_cpu,
> -                         vmstate_ipi_core, IPICore),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
> -static Property ipi_properties[] = {
> -    DEFINE_PROP_UINT32("num-cpu", LoongArchIPI, num_cpu, 1),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
> -static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
> -{
> -    DeviceClass *dc = DEVICE_CLASS(klass);
> -
> -    dc->realize = loongarch_ipi_realize;
> -    device_class_set_props(dc, ipi_properties);
> -    dc->vmsd = &vmstate_loongarch_ipi;
> -}
> -
> -static void loongarch_ipi_finalize(Object *obj)
> -{
> -    LoongArchIPI *s = LOONGARCH_IPI(obj);
> -
> -    g_free(s->cpu);
> -}
> -
> -static const TypeInfo loongarch_ipi_info = {
> -    .name          = TYPE_LOONGARCH_IPI,
> -    .parent        = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(LoongArchIPI),
> -    .class_init    = loongarch_ipi_class_init,
> -    .instance_finalize = loongarch_ipi_finalize,
> -};
> -
> -static void loongarch_ipi_register_types(void)
> -{
> -    type_register_static(&loongarch_ipi_info);
> -}
> -
> -type_init(loongarch_ipi_register_types)
> 


