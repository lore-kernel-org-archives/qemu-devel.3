Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE30C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 02:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMf7n-0002GU-KN; Wed, 26 Jun 2024 22:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sMf7k-0002G3-C2
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 22:44:36 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sMf7h-0007VB-Fs
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 22:44:36 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Bx3+sH0nxmZH4KAA--.26542S3;
 Thu, 27 Jun 2024 10:44:23 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxMMQE0nxmeb4yAA--.18115S3; 
 Thu, 27 Jun 2024 10:44:22 +0800 (CST)
Subject: Re: [PATCH v3 1/4] hw/intc: Remove loongarch_ipi.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 maobibo <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
 <20240605-loongson3-ipi-v3-1-ddd2c0e03fa3@flygoat.com>
 <e1b8bbd8-2a9d-2417-1123-4aabfdedb684@loongson.cn>
 <002f4e7e-682b-479b-9c6c-8971a0e6640a@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <8d975e9c-c2fd-09c8-7a37-5aebc63656d4@loongson.cn>
Date: Thu, 27 Jun 2024 10:44:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <002f4e7e-682b-479b-9c6c-8971a0e6640a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxMMQE0nxmeb4yAA--.18115S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr48tF1UGFW7Zw15CrWUWrX_yoW5tw1kpF
 s3AFy3WFW0qrn5Jr1ktr17XryDCw18G3WUXF1YvF18Ar4DZr1qgr10vr1vgFyUJ3y8ur10
 vr18GFy7Z3WUA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9N3UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.112,
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

在 2024/6/26 下午8:10, Philippe Mathieu-Daudé 写道:
> Hi Bibo,
>
> On 26/6/24 06:11, maobibo wrote:
>>
>>
>> On 2024/6/5 上午10:15, Jiaxun Yang wrote:
>>> It was missed out in previous commit.
>>>
>>> Fixes: b4a12dfc2132 ("hw/intc/loongarch_ipi: Rename as loongson_ipi")
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> ---
>>>   hw/intc/loongarch_ipi.c | 347 
>>> ------------------------------------------------
>>>   1 file changed, 347 deletions(-)
>
>
>>> -static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
>>> -{
>>> -    LoongArchIPI *s = LOONGARCH_IPI(dev);
>>> -    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>>> -    int i;
>>> -
>>> -    if (s->num_cpu == 0) {
>>> -        error_setg(errp, "num-cpu must be at least 1");
>>> -        return;
>>> -    }
>>> -
>>> -    memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev), 
>>> &loongarch_ipi_ops,
>>> -                          s, "loongarch_ipi_iocsr", 0x48);
>>> -
>>> -    /* loongarch_ipi_iocsr performs re-entrant IO through ipi_send */
>>> -    s->ipi_iocsr_mem.disable_reentrancy_guard = true;
>>> -
>>> -    sysbus_init_mmio(sbd, &s->ipi_iocsr_mem);
>>> -
>>> -    memory_region_init_io(&s->ipi64_iocsr_mem, OBJECT(dev),
>>> -                          &loongarch_ipi64_ops,
>>> -                          s, "loongarch_ipi64_iocsr", 0x118);
>>> -    sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
>> It is different with existing implementation.
>>
>> With hw/intc/loongson_ipi.c, every vcpu has one ipi_mmio_mem, however 
>> on loongarch ipi machine, there is no ipi_mmio_mem memory region.
>>
>> So if machine has 256 vcpus, there will be 256 ipi_mmio_mem memory 
>> regions. In function sysbus_init_mmio(), memory region can not exceed
>> QDEV_MAX_MMIO (32).  With so many memory regions, it slows down memory
>> region search speed also.
>>
>> void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory)
>> {
>>      int n;
>>
>>      assert(dev->num_mmio < QDEV_MAX_MMIO);
>>      n = dev->num_mmio++;
>>      dev->mmio[n].addr = -1;
>>      dev->mmio[n].memory = memory;
>> }
>>
>> Can we revert this patch? We want to do production usable by real 
>> users rather than show pure technology.
>
> Since commit b4a12dfc2132 this file is not built/tested anymore:
>
> -specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: 
> files('loongarch_ipi.c'))
> +specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: 
> files('loongson_ipi.c'))
>
> We don't want to maintain dead code.
>
Hi,  Philippe

It is commmit 49eba52a5 that causes Loongarch to fail to start.

What bibao means is that LoongArch and mips do not share "lloongson_ipi.c".
This avoids mutual influence.


My understanding of the next sentence is as follows.

Nowadays, most of the open source operating systems in China use the 
latest QEMU.
e.g. OpenEuler/OpenAnolis/OpenCloudOS, etc. These operating systems have 
a large
  number of real users. so we need to maintain the stability of the 
LoongArch architecture
of the QEMU community as much as possible. This will reduce maintenance 
costs.

Therefore, we would like to restore the 'loongarch_ipi.c' file. what do 
you think?

Thanks.
Song Gao

> Regards,
>
> Phil.


