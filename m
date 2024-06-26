Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9763DC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 07:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMNRj-0001FW-6g; Wed, 26 Jun 2024 03:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sMNRg-0001Dt-Bv
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 03:52:00 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sMNRc-00088p-Ff
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 03:52:00 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxUPCVyHtmFS8KAA--.41090S3;
 Wed, 26 Jun 2024 15:51:49 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxRcWTyHtm4KUxAA--.41192S3; 
 Wed, 26 Jun 2024 15:51:49 +0800 (CST)
Subject: Re: [PATCH v3 1/4] hw/intc: Remove loongarch_ipi.c
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU devel <qemu-devel@nongnu.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
 <20240605-loongson3-ipi-v3-1-ddd2c0e03fa3@flygoat.com>
 <e1b8bbd8-2a9d-2417-1123-4aabfdedb684@loongson.cn>
 <a08de6f3-3e7d-4ea4-8595-c047b4880a58@app.fastmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <775c3f6c-d119-565a-ffbe-976e790da146@loongson.cn>
Date: Wed, 26 Jun 2024 15:51:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a08de6f3-3e7d-4ea4-8595-c047b4880a58@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxRcWTyHtm4KUxAA--.41192S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAr47Kr4fKF15trWxAry8Xrc_yoWrZFW7pr
 y5ZF1DCFy8Wr4DZw1kXwn5WF4Y9r1fKw47uF43K3W8uF4DKr90qF1vyry29as7Aw48Cw1F
 v3yUCa43Xa4UA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
 67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==
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



On 2024/6/26 下午3:40, Jiaxun Yang wrote:
> 
> 
> 在2024年6月26日六月 上午5:11，maobibo写道：
> [...]
>> It is different with existing implementation.
> What do you mean? Isn't this the actual hardware behaviour?
> 
>>
>> With hw/intc/loongson_ipi.c, every vcpu has one ipi_mmio_mem, however on
>> loongarch ipi machine, there is no ipi_mmio_mem memory region.
>> So if machine has 256 vcpus, there will be 256 ipi_mmio_mem memory
>> regions. In function sysbus_init_mmio(), memory region can not exceed
>> QDEV_MAX_MMIO (32).  With so many memory regions, it slows down memory
>> region search speed also.
> Ouch, never thought about that before, but I think we can control the
> registration of sysbus_mmio with a device property or even ifdef so LoongArch
> machine won't be affected.
> 
> For MIPS loongson3-virt machine, our CPU number is capped, so that won't
> be a problem.
> 
> I'm currently travelling without access to my PC, I'll prepare a patch
> as soon as I gain access again. Feel free to send a patch before me with
> this approach if you desperately want to fix it.
> 
>>
>> void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory)
>> {
>>       int n;
>>
>>       assert(dev->num_mmio < QDEV_MAX_MMIO);
>>       n = dev->num_mmio++;
>>       dev->mmio[n].addr = -1;
>>       dev->mmio[n].memory = memory;
>> }
>>
>> Can we revert this patch? We want to do production usable by real users
>> rather than show pure technology.
> 
> I don't really get your point, we have at leat 4 real users requesting SMP
> support for loongson3-virt on gitlab issues, plus I need this to test
> MIPS/Loongson64 SMP kernel.
> 
> If there is a problem with your use case, we can fix it. Why we do want to
> remove the functionality when there is an easy fix?
I do not think we have the ability to abstract hw and continuous 
maintenance for two different architecture, including you and me.

So I suggest that different files will be better for the present. After 
one year or later, if we have further understanding about system, it is 
ok to merge them into one file.

Regards
Bibo Mao
> 
> It’s not only the features necessary for you that made QEMU an outstanding
> project; it’s everything coming together that completes it.
> 
> Thanks
> - Jiaxun
>>
>> Regards
>> Bibo Mao
>>
>>> -
>>> -    s->cpu = g_new0(IPICore, s->num_cpu);
>>> -    if (s->cpu == NULL) {
>>> -        error_setg(errp, "Memory allocation for ExtIOICore faile");
>>> -        return;
>>> -    }
>>> -
>>> -    for (i = 0; i < s->num_cpu; i++) {
>>> -        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
>>> -    }
>>> -}
>>> -
>>> -static const VMStateDescription vmstate_ipi_core = {
>>> -    .name = "ipi-single",
>>> -    .version_id = 2,
>>> -    .minimum_version_id = 2,
>>> -    .fields = (const VMStateField[]) {
>>> -        VMSTATE_UINT32(status, IPICore),
>>> -        VMSTATE_UINT32(en, IPICore),
>>> -        VMSTATE_UINT32(set, IPICore),
>>> -        VMSTATE_UINT32(clear, IPICore),
>>> -        VMSTATE_UINT32_ARRAY(buf, IPICore, IPI_MBX_NUM * 2),
>>> -        VMSTATE_END_OF_LIST()
>>> -    }
>>> -};
>>> -
>>> -static const VMStateDescription vmstate_loongarch_ipi = {
>>> -    .name = TYPE_LOONGARCH_IPI,
>>> -    .version_id = 2,
>>> -    .minimum_version_id = 2,
>>> -    .fields = (const VMStateField[]) {
>>> -        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongArchIPI, num_cpu,
>>> -                         vmstate_ipi_core, IPICore),
>>> -        VMSTATE_END_OF_LIST()
>>> -    }
>>> -};
>>> -
>>> -static Property ipi_properties[] = {
>>> -    DEFINE_PROP_UINT32("num-cpu", LoongArchIPI, num_cpu, 1),
>>> -    DEFINE_PROP_END_OF_LIST(),
>>> -};
>>> -
>>> -static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
>>> -{
>>> -    DeviceClass *dc = DEVICE_CLASS(klass);
>>> -
>>> -    dc->realize = loongarch_ipi_realize;
>>> -    device_class_set_props(dc, ipi_properties);
>>> -    dc->vmsd = &vmstate_loongarch_ipi;
>>> -}
>>> -
>>> -static void loongarch_ipi_finalize(Object *obj)
>>> -{
>>> -    LoongArchIPI *s = LOONGARCH_IPI(obj);
>>> -
>>> -    g_free(s->cpu);
>>> -}
>>> -
>>> -static const TypeInfo loongarch_ipi_info = {
>>> -    .name          = TYPE_LOONGARCH_IPI,
>>> -    .parent        = TYPE_SYS_BUS_DEVICE,
>>> -    .instance_size = sizeof(LoongArchIPI),
>>> -    .class_init    = loongarch_ipi_class_init,
>>> -    .instance_finalize = loongarch_ipi_finalize,
>>> -};
>>> -
>>> -static void loongarch_ipi_register_types(void)
>>> -{
>>> -    type_register_static(&loongarch_ipi_info);
>>> -}
>>> -
>>> -type_init(loongarch_ipi_register_types)
>>>
> 


