Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79825C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 07:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOugB-0005BT-4h; Wed, 03 Jul 2024 03:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sOug9-0005BH-Io
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 03:45:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sOufv-0005e2-2b
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 03:45:16 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Ax3vB_AYVmhm8AAA--.1520S3;
 Wed, 03 Jul 2024 15:45:04 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxQcR8AYVmMF45AA--.31404S3; 
 Wed, 03 Jul 2024 15:45:02 +0800 (CST)
Subject: Re: [PATCH 1/3] hw/intc/loongson_ipi_common: Add loongson ipi common
 class
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Song Gao <gaosong@loongson.cn>
Cc: QEMU devel <qemu-devel@nongnu.org>
References: <20240703021245.3752786-1-maobibo@loongson.cn>
 <20240703021245.3752786-2-maobibo@loongson.cn>
 <66ae71c4-7b79-4d95-ad23-17b00f7eae08@app.fastmail.com>
 <0fc1703c-6007-c0fe-c261-6c549ba58752@loongson.cn>
 <73e84270-1d37-4718-ae24-f87997ac1e03@app.fastmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <d24527c9-3e24-37ba-8d22-f5447a5d0c10@loongson.cn>
Date: Wed, 3 Jul 2024 15:45:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <73e84270-1d37-4718-ae24-f87997ac1e03@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxQcR8AYVmMF45AA--.31404S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3uFyfWFyxXFy5uFW5Kw1xWFX_yoW8Aw4DWo
 W3Jan7ArW5Jr1UZF1jq39Fvry2v3W5Wr4UArWxAwsrGa13ta4UAa1qgr18Za1DCF1rtF17
 JF9rJw4fZrW7ZF1rl-sFpf9Il3svdjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUYA7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
 xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
 Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
 xGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
 6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
 xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
 jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
 0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
 67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8TqcUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.819,
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



On 2024/7/3 下午3:33, Jiaxun Yang wrote:
> 
> 
> 在2024年7月3日七月 下午2:40，maobibo写道：
> [...]
> Hi Bobo,
>>
>> MMIO is loongson ipi specific, it is not necessary to put into common
>> function. Functions loongson_ipi_core_readl/loongson_ipi_core_writel can
>> be exported in header file include/hw/intc/loongson_ipi_common.h, or get
>> MemoryRegionOps of first memoryregion of loongson_ipi instance.
>>
>> There is pseudo code:
> 
> Thanks for your demonstration. I'm still not quite convinced it's worthy to split
> but I'm not going to block you if we don't have other oppositions.
> 
> Do you mind to finish conversion of loongson_ipi as well? Since you are drafting the
> design.
It depends on schedule, I hope Loongarch IPI can merge before qemu is 
frozen. However I will try to write loongson_ipi but it can just pass to 
compile, no test. If it takes too long time to merge both Loongarch IPI 
and loongson ipi, I will only provide support for Loongarch IPI :)

> 
>>
>> static void loongson_ipi_realize(DeviceState *dev, Error **errp)
>> {
>>       LoongarchIPIState *s = LOONGARCH_IPI(dev);
>>       LoongarchIPIClass *lic = LOONGARCH_IPI_GET_CLASS(s);
>>       Error *local_err = NULL;
>>
>>       lic->parent_realize(dev, &local_err);
>>       if (local_err) {
>>           error_propagate(errp, local_err);
>>           return;
>>       }
>>
>>       ....
>>       *do mmio specific implematation in loongson ipi itself*
>> }
>>
>> static void loongson_ipi_class_init(ObjectClass *klass, void *data)
>> {
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>>       LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
>>       LoongarchIPIClass *lic = LOONGARCH_IPI_CLASS(klass);
>>
>>       device_class_set_parent_realize(dc, loongson_ipi_realize,
>> &lic->parent_realize);
>>       licc->get_iocsr_as = get_iocsr_as;
>> }
>>
>>>
>>> If current implementation is hindering your future plan can you elaborate so we
>>> can work on a resolution.
>>>
>>> I'm happy to help with devlopment and testing.
>>>
>>>>    3. Interace cpu_by_arch_id is added, by default generic function
>>>> cpu_by_arch_id() is used to search vcpu from physical cpuid, it is
>>>> generic searching method. Different machine may define another search
>>>> method such binary searching method.
>>>
>>> If you are going to implement some faster searching algorithm why don't we
>>>    make it generic for all architectures?
>> It depends on the detailed physical id layout, is physical id is growing
>> up with logic cpu id or irrelative with logic cpu id? Different
>> architecture has different logic definition about physical id.
> 
> For x86' APIC id and RISC-V's hardid they are all somehow linear.
> I'd suggest you to post a RFC patch regarding better algorithm.
Thanks for your suggestion, currently there is no such plan, it is above 
my ability :(

Regards
Bibo Mao
> 
> Thanks
> - Jiaxun
>>
>> Regards
>> Bibo Mao
>>
>>>
>>> Thanks
>>> - Jiaxun
>>>
>>>>
>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>> ---
>>>>    hw/intc/loongson_ipi_common.c         | 394 ++++++++++++++++++++++++++
>>>>    include/hw/intc/loongson_ipi_common.h |  71 +++++
>>>>    2 files changed, 465 insertions(+)
>>>>    create mode 100644 hw/intc/loongson_ipi_common.c
>>>>    create mode 100644 include/hw/intc/loongson_ipi_common.h
>>>>
>>>> diff --git a/hw/intc/loongson_ipi_common.c
>>>> b/hw/intc/loongson_ipi_common.c
>>>> new file mode 100644
>>>> index 0000000000..f462f24f32
>>>> --- /dev/null
>>>> +++ b/hw/intc/loongson_ipi_common.c
>>>> @@ -0,0 +1,394 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>>> +/*
>>>> + * Loongson ipi interrupt support
>>>> + *
>>>> + * Copyright (C) 2021 Loongson Technology Corporation Limited
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +#include "hw/boards.h"
>>>> +#include "hw/sysbus.h"
>>>> +#include "hw/intc/loongson_ipi_common.h"
>>>> +#include "hw/irq.h"
>>>> +#include "hw/qdev-properties.h"
>>>> +#include "qapi/error.h"
>>>> +#include "qemu/log.h"
>>>> +#include "exec/address-spaces.h"
>>>> +#include "exec/memory.h"
>>>> +#include "migration/vmstate.h"
>>>> +#include "trace.h"
>>>> +
>>>> +static MemTxResult loongson_ipi_core_readl(void *opaque, hwaddr addr,
>>>> +                                           uint64_t *data,
>>>> +                                           unsigned size, MemTxAttrs
>>>> attrs)
>>>> +{
>>>> +    IPICore *s = opaque;
>>>> +    uint64_t ret = 0;
>>>> +    int index = 0;
>>>> +
>>>> +    addr &= 0xff;
>>>> +    switch (addr) {
>>>> +    case CORE_STATUS_OFF:
>>>> +        ret = s->status;
>>>> +        break;
>>>> +    case CORE_EN_OFF:
>>>> +        ret = s->en;
>>>> +        break;
>>>> +    case CORE_SET_OFF:
>>>> +        ret = 0;
>>>> +        break;
>>>> +    case CORE_CLEAR_OFF:
>>>> +        ret = 0;
>>>> +        break;
>>>> +    case CORE_BUF_20 ... CORE_BUF_38 + 4:
>>>> +        index = (addr - CORE_BUF_20) >> 2;
>>>> +        ret = s->buf[index];
>>>> +        break;
>>>> +    default:
>>>> +        qemu_log_mask(LOG_UNIMP, "invalid read: %x", (uint32_t)addr);
>>>> +        break;
>>>> +    }
>>>> +
>>>> +    trace_loongson_ipi_read(size, (uint64_t)addr, ret);
>>>> +    *data = ret;
>>>> +    return MEMTX_OK;
>>>> +}
>>>> +
>>>> +static MemTxResult loongson_ipi_iocsr_readl(void *opaque, hwaddr addr,
>>>> +                                            uint64_t *data,
>>>> +                                            unsigned size, MemTxAttrs
>>>> attrs)
>>>> +{
>>>> +    LoongsonIPICommonState *ipi = opaque;
>>>> +    IPICore *s;
>>>> +
>>>> +    if (attrs.requester_id >= ipi->num_cpu) {
>>>> +        return MEMTX_DECODE_ERROR;
>>>> +    }
>>>> +
>>>> +    s = &ipi->cpu[attrs.requester_id];
>>>> +    return loongson_ipi_core_readl(s, addr, data, size, attrs);
>>>> +}
>>>> +
>>>> +static MemTxResult send_ipi_data(LoongsonIPICommonState *ipi, CPUState
>>>> *cpu,
>>>> +                                 uint64_t val,
>>>> +                                 hwaddr addr, MemTxAttrs attrs)
>>>> +{
>>>> +    int i, mask = 0, data = 0;
>>>> +    AddressSpace *iocsr_as;
>>>> +    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
>>>> +
>>>> +    iocsr_as = NULL;
>>>> +    if (licc->get_iocsr_as) {
>>>> +        iocsr_as = licc->get_iocsr_as(cpu);
>>>> +    }
>>>> +
>>>> +    if (!iocsr_as) {
>>>> +        return MEMTX_DECODE_ERROR;
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * bit 27-30 is mask for byte writing,
>>>> +     * if the mask is 0, we need not to do anything.
>>>> +     */
>>>> +    if ((val >> 27) & 0xf) {
>>>> +        data = address_space_ldl_le(iocsr_as, addr, attrs, NULL);
>>>> +        for (i = 0; i < 4; i++) {
>>>> +            /* get mask for byte writing */
>>>> +            if (val & (0x1 << (27 + i))) {
>>>> +                mask |= 0xff << (i * 8);
>>>> +            }
>>>> +        }
>>>> +    }
>>>> +
>>>> +    data &= mask;
>>>> +    data |= (val >> 32) & ~mask;
>>>> +    address_space_stl_le(iocsr_as, addr, data, attrs, NULL);
>>>> +
>>>> +    return MEMTX_OK;
>>>> +}
>>>> +
>>>> +static CPUState *get_cpu_by_arch_id(LoongsonIPICommonState *ipi,
>>>> uint32_t cpuid)
>>>> +{
>>>> +    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
>>>> +
>>>> +    if (licc->cpu_by_arch_id) {
>>>> +        return licc->cpu_by_arch_id(cpuid);
>>>> +    }
>>>> +
>>>> +    return cpu_by_arch_id(cpuid);
>>>> +}
>>>> +
>>>> +static MemTxResult mail_send(LoongsonIPICommonState *ipi, uint64_t val,
>>>> +                             MemTxAttrs attrs)
>>>> +{
>>>> +    uint32_t cpuid;
>>>> +    hwaddr addr;
>>>> +    CPUState *cs;
>>>> +
>>>> +    cpuid = extract32(val, 16, 10);
>>>> +    cs = get_cpu_by_arch_id(ipi, cpuid);
>>>> +    if (cs == NULL) {
>>>> +        return MEMTX_DECODE_ERROR;
>>>> +    }
>>>> +
>>>> +    /* override requester_id */
>>>> +    addr = SMP_IPI_MAILBOX + CORE_BUF_20 + (val & 0x1c);
>>>> +    attrs.requester_id = cs->cpu_index;
>>>> +    return send_ipi_data(ipi, cs, val, addr, attrs);
>>>> +}
>>>> +
>>>> +static MemTxResult any_send(LoongsonIPICommonState *ipi, uint64_t val,
>>>> +                            MemTxAttrs attrs)
>>>> +{
>>>> +    uint32_t cpuid;
>>>> +    hwaddr addr;
>>>> +    CPUState *cs;
>>>> +
>>>> +    cpuid = extract32(val, 16, 10);
>>>> +    cs = get_cpu_by_arch_id(ipi, cpuid);
>>>> +    if (cs == NULL) {
>>>> +        return MEMTX_DECODE_ERROR;
>>>> +    }
>>>> +
>>>> +    /* override requester_id */
>>>> +    addr = val & 0xffff;
>>>> +    attrs.requester_id = cs->cpu_index;
>>>> +    return send_ipi_data(ipi, cs, val, addr, attrs);
>>>> +}
>>>> +
>>>> +static MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr,
>>>> +                                            uint64_t val, unsigned
>>>> size,
>>>> +                                            MemTxAttrs attrs)
>>>> +{
>>>> +    IPICore *s = opaque;
>>>> +    LoongsonIPICommonState *ipi = s->ipi;
>>>> +    int index = 0;
>>>> +    uint32_t cpuid;
>>>> +    uint8_t vector;
>>>> +    CPUState *cs;
>>>> +
>>>> +    addr &= 0xff;
>>>> +    trace_loongson_ipi_write(size, (uint64_t)addr, val);
>>>> +    switch (addr) {
>>>> +    case CORE_STATUS_OFF:
>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "can not be written");
>>>> +        break;
>>>> +    case CORE_EN_OFF:
>>>> +        s->en = val;
>>>> +        break;
>>>> +    case CORE_SET_OFF:
>>>> +        s->status |= val;
>>>> +        if (s->status != 0 && (s->status & s->en) != 0) {
>>>> +            qemu_irq_raise(s->irq);
>>>> +        }
>>>> +        break;
>>>> +    case CORE_CLEAR_OFF:
>>>> +        s->status &= ~val;
>>>> +        if (s->status == 0 && s->en != 0) {
>>>> +            qemu_irq_lower(s->irq);
>>>> +        }
>>>> +        break;
>>>> +    case CORE_BUF_20 ... CORE_BUF_38 + 4:
>>>> +        index = (addr - CORE_BUF_20) >> 2;
>>>> +        s->buf[index] = val;
>>>> +        break;
>>>> +    case IOCSR_IPI_SEND:
>>>> +        cpuid = extract32(val, 16, 10);
>>>> +        /* IPI status vector */
>>>> +        vector = extract8(val, 0, 5);
>>>> +        cs = get_cpu_by_arch_id(ipi, cpuid);
>>>> +        if (cs == NULL || cs->cpu_index >= ipi->num_cpu) {
>>>> +            return MEMTX_DECODE_ERROR;
>>>> +        }
>>>> +        loongson_ipi_core_writel(&ipi->cpu[cs->cpu_index],
>>>> CORE_SET_OFF,
>>>> +                                 BIT(vector), 4, attrs);
>>>> +        break;
>>>> +    default:
>>>> +        qemu_log_mask(LOG_UNIMP, "invalid write: %x", (uint32_t)addr);
>>>> +        break;
>>>> +    }
>>>> +
>>>> +    return MEMTX_OK;
>>>> +}
>>>> +
>>>> +static MemTxResult loongson_ipi_iocsr_writel(void *opaque, hwaddr addr,
>>>> +                                            uint64_t val, unsigned
>>>> size,
>>>> +                                            MemTxAttrs attrs)
>>>> +{
>>>> +    LoongsonIPICommonState *ipi = opaque;
>>>> +    IPICore *s;
>>>> +
>>>> +    if (attrs.requester_id >= ipi->num_cpu) {
>>>> +        return MEMTX_DECODE_ERROR;
>>>> +    }
>>>> +
>>>> +    s = &ipi->cpu[attrs.requester_id];
>>>> +    return loongson_ipi_core_writel(s, addr, val, size, attrs);
>>>> +}
>>>> +
>>>> +static const MemoryRegionOps loongson_ipi_iocsr_ops = {
>>>> +    .read_with_attrs = loongson_ipi_iocsr_readl,
>>>> +    .write_with_attrs = loongson_ipi_iocsr_writel,
>>>> +    .impl.min_access_size = 4,
>>>> +    .impl.max_access_size = 4,
>>>> +    .valid.min_access_size = 4,
>>>> +    .valid.max_access_size = 8,
>>>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>>>> +};
>>>> +
>>>> +/* mail send and any send only support writeq */
>>>> +static MemTxResult loongson_ipi_writeq(void *opaque, hwaddr addr,
>>>> uint64_t val,
>>>> +                                        unsigned size, MemTxAttrs
>>>> attrs)
>>>> +{
>>>> +    MemTxResult ret = MEMTX_OK;
>>>> +    LoongsonIPICommonState *ipi = opaque;
>>>> +
>>>> +    addr &= 0xfff;
>>>> +    switch (addr) {
>>>> +    case MAIL_SEND_OFFSET:
>>>> +        ret = mail_send(ipi, val, attrs);
>>>> +        break;
>>>> +    case ANY_SEND_OFFSET:
>>>> +        ret = any_send(ipi, val, attrs);
>>>> +        break;
>>>> +    default:
>>>> +       break;
>>>> +    }
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static const MemoryRegionOps loongson_ipi64_ops = {
>>>> +    .write_with_attrs = loongson_ipi_writeq,
>>>> +    .impl.min_access_size = 8,
>>>> +    .impl.max_access_size = 8,
>>>> +    .valid.min_access_size = 8,
>>>> +    .valid.max_access_size = 8,
>>>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>>>> +};
>>>> +
>>>> +static void loongson_ipi_common_realize(DeviceState *dev, Error **errp)
>>>> +{
>>>> +    LoongsonIPICommonState *s = LOONGSON_IPI_COMMON(dev);
>>>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>>>> +    int i;
>>>> +
>>>> +    if (s->num_cpu == 0) {
>>>> +        error_setg(errp, "num-cpu must be at least 1");
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev),
>>>> +                          &loongson_ipi_iocsr_ops,
>>>> +                          s, "loongson_ipi_iocsr", 0x48);
>>>> +
>>>> +    /* loongson_ipi_iocsr performs re-entrant IO through ipi_send */
>>>> +    s->ipi_iocsr_mem.disable_reentrancy_guard = true;
>>>> +
>>>> +    sysbus_init_mmio(sbd, &s->ipi_iocsr_mem);
>>>> +
>>>> +    memory_region_init_io(&s->ipi64_iocsr_mem, OBJECT(dev),
>>>> +                          &loongson_ipi64_ops,
>>>> +                          s, "loongson_ipi64_iocsr", 0x118);
>>>> +    sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
>>>> +
>>>> +    s->cpu = g_new0(IPICore, s->num_cpu);
>>>> +    if (s->cpu == NULL) {
>>>> +        error_setg(errp, "Memory allocation for IPICore faile");
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    for (i = 0; i < s->num_cpu; i++) {
>>>> +        s->cpu[i].ipi = s;
>>>> +        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
>>>> +    }
>>>> +}
>>>> +
>>>> +static int loongson_ipi_pre_save(void *opaque)
>>>> +{
>>>> +    LoongsonIPICommonState *s = (LoongsonIPICommonState *)opaque;
>>>> +    LoongsonIPICommonClass *c = LOONGSON_IPI_COMMON_GET_CLASS(s);
>>>> +
>>>> +    if (c->pre_save) {
>>>> +        c->pre_save(s);
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int loongson_ipi_post_load(void *opaque, int version_id)
>>>> +{
>>>> +    LoongsonIPICommonState *s = (LoongsonIPICommonState *)opaque;
>>>> +    LoongsonIPICommonClass *c = LOONGSON_IPI_COMMON_GET_CLASS(s);
>>>> +
>>>> +    if (c->post_load) {
>>>> +        c->post_load(s);
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static const VMStateDescription vmstate_ipi_core = {
>>>> +    .name = "ipi-single",
>>>> +    .version_id = 2,
>>>> +    .minimum_version_id = 2,
>>>> +    .fields = (const VMStateField[]) {
>>>> +        VMSTATE_UINT32(status, IPICore),
>>>> +        VMSTATE_UINT32(en, IPICore),
>>>> +        VMSTATE_UINT32(set, IPICore),
>>>> +        VMSTATE_UINT32(clear, IPICore),
>>>> +        VMSTATE_UINT32_ARRAY(buf, IPICore, IPI_MBX_NUM * 2),
>>>> +        VMSTATE_END_OF_LIST()
>>>> +    }
>>>> +};
>>>> +
>>>> +static const VMStateDescription vmstate_loongson_ipi = {
>>>> +    /* Fixed name to keep compatible */
>>>> +    .name = "loongson_ipi",
>>>> +    .pre_save  = loongson_ipi_pre_save,
>>>> +    .post_load = loongson_ipi_post_load,
>>>> +    .version_id = 2,
>>>> +    .minimum_version_id = 2,
>>>> +    .fields = (const VMStateField[]) {
>>>> +        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu,
>>>> LoongsonIPICommonState,
>>>> +                                       num_cpu, vmstate_ipi_core,
>>>> IPICore),
>>>> +        VMSTATE_END_OF_LIST()
>>>> +    }
>>>> +};
>>>> +
>>>> +static Property ipi_properties[] = {
>>>> +    DEFINE_PROP_UINT32("num-cpu", LoongsonIPICommonState, num_cpu, 1),
>>>> +    DEFINE_PROP_END_OF_LIST(),
>>>> +};
>>>> +
>>>> +static void loongson_ipi_common_class_init(ObjectClass *klass, void
>>>> *data)
>>>> +{
>>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>>> +
>>>> +    dc->realize = loongson_ipi_common_realize;
>>>> +    device_class_set_props(dc, ipi_properties);
>>>> +    dc->vmsd = &vmstate_loongson_ipi;
>>>> +}
>>>> +
>>>> +static void loongson_ipi_common_finalize(Object *obj)
>>>> +{
>>>> +    LoongsonIPICommonState *s = LOONGSON_IPI_COMMON(obj);
>>>> +
>>>> +    g_free(s->cpu);
>>>> +}
>>>> +
>>>> +static const TypeInfo loongson_ipi_common_info = {
>>>> +    .name          = TYPE_LOONGSON_IPI_COMMON,
>>>> +    .parent        = TYPE_SYS_BUS_DEVICE,
>>>> +    .instance_size = sizeof(LoongsonIPICommonState),
>>>> +    .class_size    = sizeof(LoongsonIPICommonClass),
>>>> +    .class_init    = loongson_ipi_common_class_init,
>>>> +    .instance_finalize = loongson_ipi_common_finalize,
>>>> +    .abstract = true,
>>>> +};
>>>> +
>>>> +static void loongson_ipi_common_register_types(void)
>>>> +{
>>>> +    type_register_static(&loongson_ipi_common_info);
>>>> +}
>>>> +
>>>> +type_init(loongson_ipi_common_register_types)
>>>> diff --git a/include/hw/intc/loongson_ipi_common.h
>>>> b/include/hw/intc/loongson_ipi_common.h
>>>> new file mode 100644
>>>> index 0000000000..1f074863e6
>>>> --- /dev/null
>>>> +++ b/include/hw/intc/loongson_ipi_common.h
>>>> @@ -0,0 +1,71 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>>> +/*
>>>> + * Loongson ipi interrupt header files
>>>> + *
>>>> + * Copyright (C) 2021 Loongson Technology Corporation Limited
>>>> + */
>>>> +
>>>> +#ifndef HW_LOONGSON_IPI_COMMON_H
>>>> +#define HW_LOONGSON_IPI_COMMON_H
>>>> +
>>>> +#include "hw/sysbus.h"
>>>> +#include "hw/core/cpu.h"
>>>> +#include "qom/object.h"
>>>> +
>>>> +/* Mainy used by iocsr read and write */
>>>> +#define SMP_IPI_MAILBOX      0x1000ULL
>>>> +#define CORE_STATUS_OFF       0x0
>>>> +#define CORE_EN_OFF           0x4
>>>> +#define CORE_SET_OFF          0x8
>>>> +#define CORE_CLEAR_OFF        0xc
>>>> +#define CORE_BUF_20           0x20
>>>> +#define CORE_BUF_28           0x28
>>>> +#define CORE_BUF_30           0x30
>>>> +#define CORE_BUF_38           0x38
>>>> +#define IOCSR_IPI_SEND        0x40
>>>> +#define IOCSR_MAIL_SEND       0x48
>>>> +#define IOCSR_ANY_SEND        0x158
>>>> +
>>>> +#define MAIL_SEND_ADDR        (SMP_IPI_MAILBOX + IOCSR_MAIL_SEND)
>>>> +#define MAIL_SEND_OFFSET      0
>>>> +#define ANY_SEND_OFFSET       (IOCSR_ANY_SEND - IOCSR_MAIL_SEND)
>>>> +
>>>> +#define IPI_MBX_NUM           4
>>>> +
>>>> +#define TYPE_LOONGSON_IPI_COMMON "loongson_ipi_common"
>>>> +typedef struct LoongsonIPICommonClass LoongsonIPICommonClass;
>>>> +typedef struct LoongsonIPICommonState LoongsonIPICommonState;
>>>> +DECLARE_OBJ_CHECKERS(LoongsonIPICommonState, LoongsonIPICommonClass,
>>>> +                     LOONGSON_IPI_COMMON, TYPE_LOONGSON_IPI_COMMON)
>>>> +
>>>> +typedef struct IPICore {
>>>> +    LoongsonIPICommonState *ipi;
>>>> +    uint32_t status;
>>>> +    uint32_t en;
>>>> +    uint32_t set;
>>>> +    uint32_t clear;
>>>> +    /* 64bit buf divide into 2 32bit buf */
>>>> +    uint32_t buf[IPI_MBX_NUM * 2];
>>>> +    qemu_irq irq;
>>>> +} IPICore;
>>>> +
>>>> +struct LoongsonIPICommonState {
>>>> +    SysBusDevice parent_obj;
>>>> +    MemoryRegion ipi_iocsr_mem;
>>>> +    MemoryRegion ipi64_iocsr_mem;
>>>> +    uint32_t num_cpu;
>>>> +    IPICore *cpu;
>>>> +};
>>>> +
>>>> +struct LoongsonIPICommonClass {
>>>> +    /*< private >*/
>>>> +    SysBusDeviceClass parent_class;
>>>> +    /*< public >*/
>>>> +
>>>> +    void (*pre_save)(LoongsonIPICommonState *s);
>>>> +    void (*post_load)(LoongsonIPICommonState *s);
>>>> +    AddressSpace *(*get_iocsr_as)(CPUState *cpu);
>>>> +    CPUState *(*cpu_by_arch_id)(int64_t id);
>>>> +};
>>>> +
>>>> +#endif
>>>> -- 
>>>> 2.39.3
>>>
> 


