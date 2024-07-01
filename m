Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DDBC27C4F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 01:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO5xS-0004Pv-GU; Sun, 30 Jun 2024 21:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sO5xL-0004PM-I8
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 21:35:49 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sO5xI-0001P0-II
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 21:35:47 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Dxi7rkB4JmmMELAA--.1662S3;
 Mon, 01 Jul 2024 09:35:32 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxPMfgB4JmH_k2AA--.63839S3; 
 Mon, 01 Jul 2024 09:35:30 +0800 (CST)
Subject: Re: [PATCH v3 1/4] hw/intc: Remove loongarch_ipi.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 gaosong <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
 <20240605-loongson3-ipi-v3-1-ddd2c0e03fa3@flygoat.com>
 <e1b8bbd8-2a9d-2417-1123-4aabfdedb684@loongson.cn>
 <002f4e7e-682b-479b-9c6c-8971a0e6640a@linaro.org>
 <8d975e9c-c2fd-09c8-7a37-5aebc63656d4@loongson.cn>
 <9a0f73c6-33e9-4576-9056-6a5fd0718630@linaro.org>
From: maobibo <maobibo@loongson.cn>
Message-ID: <ceebb4ea-a417-0985-d45e-3988d76e2086@loongson.cn>
Date: Mon, 1 Jul 2024 09:35:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9a0f73c6-33e9-4576-9056-6a5fd0718630@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxPMfgB4JmH_k2AA--.63839S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGr15CF13Ww1Dur1UKFWfZwc_yoW7Jr1fpF
 s3AF1avrW8Jr1rJr1vqr15XFyqyw1rK3W8XF13AF18Gr4qvr1qgF10qr10ga4UArW8ur10
 vr18JFy7ZFyUA3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
 kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
 twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
 k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
 4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
 42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.587,
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

Hi Philippe,

On 2024/6/27 下午9:02, Philippe Mathieu-Daudé wrote:
> On 27/6/24 04:44, gaosong wrote:
>> 在 2024/6/26 下午8:10, Philippe Mathieu-Daudé 写道:
>>> Hi Bibo,
>>>
>>> On 26/6/24 06:11, maobibo wrote:
>>>>
>>>>
>>>> On 2024/6/5 上午10:15, Jiaxun Yang wrote:
>>>>> It was missed out in previous commit.
>>>>>
>>>>> Fixes: b4a12dfc2132 ("hw/intc/loongarch_ipi: Rename as loongson_ipi")
>>>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>>>> ---
>>>>>   hw/intc/loongarch_ipi.c | 347 
>>>>> ------------------------------------------------
>>>>>   1 file changed, 347 deletions(-)
>>>
>>>
>>>>> -static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
>>>>> -{
>>>>> -    LoongArchIPI *s = LOONGARCH_IPI(dev);
>>>>> -    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>>>>> -    int i;
>>>>> -
>>>>> -    if (s->num_cpu == 0) {
>>>>> -        error_setg(errp, "num-cpu must be at least 1");
>>>>> -        return;
>>>>> -    }
>>>>> -
>>>>> -    memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev), 
>>>>> &loongarch_ipi_ops,
>>>>> -                          s, "loongarch_ipi_iocsr", 0x48);
>>>>> -
>>>>> -    /* loongarch_ipi_iocsr performs re-entrant IO through ipi_send */
>>>>> -    s->ipi_iocsr_mem.disable_reentrancy_guard = true;
>>>>> -
>>>>> -    sysbus_init_mmio(sbd, &s->ipi_iocsr_mem);
>>>>> -
>>>>> -    memory_region_init_io(&s->ipi64_iocsr_mem, OBJECT(dev),
>>>>> -                          &loongarch_ipi64_ops,
>>>>> -                          s, "loongarch_ipi64_iocsr", 0x118);
>>>>> -    sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
>>>> It is different with existing implementation.
>>>>
>>>> With hw/intc/loongson_ipi.c, every vcpu has one ipi_mmio_mem, 
>>>> however on loongarch ipi machine, there is no ipi_mmio_mem memory 
>>>> region.
>>>>
>>>> So if machine has 256 vcpus, there will be 256 ipi_mmio_mem memory 
>>>> regions. In function sysbus_init_mmio(), memory region can not exceed
>>>> QDEV_MAX_MMIO (32).  With so many memory regions, it slows down memory
>>>> region search speed also.
>>>>
>>>> void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory)
>>>> {
>>>>      int n;
>>>>
>>>>      assert(dev->num_mmio < QDEV_MAX_MMIO);
>>>>      n = dev->num_mmio++;
>>>>      dev->mmio[n].addr = -1;
>>>>      dev->mmio[n].memory = memory;
>>>> }
>>>>
>>>> Can we revert this patch? We want to do production usable by real 
>>>> users rather than show pure technology.
>>>
>>> Since commit b4a12dfc2132 this file is not built/tested anymore:
>>>
>>> -specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: 
>>> files('loongarch_ipi.c'))
>>> +specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: 
>>> files('loongson_ipi.c'))
>>>
>>> We don't want to maintain dead code.
>>>
>> Hi,  Philippe
>>
>> It is commmit 49eba52a5 that causes Loongarch to fail to start.
>>
>> What bibao means is that LoongArch and mips do not share 
>> "lloongson_ipi.c".
>> This avoids mutual influence.
>>
>>
>> My understanding of the next sentence is as follows.
>>
>> Nowadays, most of the open source operating systems in China use the 
>> latest QEMU.
>> e.g. OpenEuler/OpenAnolis/OpenCloudOS, etc. These operating systems 
>> have a large
>>   number of real users. so we need to maintain the stability of the 
>> LoongArch architecture
>> of the QEMU community as much as possible. This will reduce 
>> maintenance costs.
> 
> I'm glad there is a such large number of users :)
> 
>> Therefore, we would like to restore the 'loongarch_ipi.c' file. what 
>> do you think?
> 
> My preference on "reducing maintenance cost" is code reuse instead of
> duplication.
> 
> Before reverting, lets try to fix the issue. I suggested a v2:
> https://lore.kernel.org/qemu-devel/20240627125819.62779-2-philmd@linaro.org
Sorry for late reply.

How about split loongson_ipi.c into 
loongson_ipi_base.c/loongson_ipi_loongson.c/loongson_ipi_loongarch.c,

File loongson_ipi_base.c contains the common code, loongson_ipi_xxx.c 
contains arch specific. Soon we will submit irqchip in kernel function,
it will be much different for architectures, since ioctl command is 
different for two architectures to save/restore ipi registers.

Regards
Bibo Mao

> 
> That said, both current patch and the suggested fix pass our
> Avocado CI test suite (running tests/avocado/machine_loongarch.py).
> 
> Is your use case not covered? Could you expand the CI tests so
> we don't hit this problem again? (Also we could reproduce and
> fix more easily).
> 
> Thanks,
> 
> Phil.


