Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B3FC38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 06:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRQVA-0005yE-L2; Wed, 10 Jul 2024 02:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sRQV7-0005xD-Ik
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:08:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sRQV4-00062f-NY
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:08:25 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxLOtQJY5mI70CAA--.8235S3;
 Wed, 10 Jul 2024 14:08:16 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx78dNJY5mFhpCAA--.20698S3; 
 Wed, 10 Jul 2024 14:08:15 +0800 (CST)
Subject: Re: [PATCH v2 0/4] Reconstruct loongson ipi driver
To: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU devel <qemu-devel@nongnu.org>
References: <20240704033802.3838618-1-maobibo@loongson.cn>
 <fb5d8ffb-b183-ffbe-b64a-c4506b5b546d@loongson.cn>
 <db13dadd-6a04-4da1-893e-e613ad39ab15@app.fastmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <88a085c5-9de0-90a2-87c3-5fa885a97d80@loongson.cn>
Date: Wed, 10 Jul 2024 14:08:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <db13dadd-6a04-4da1-893e-e613ad39ab15@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx78dNJY5mFhpCAA--.20698S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuryrJryDuFyUZr15uFyrXwc_yoW5GryrpF
 W3C3Wa9r48Jry7Jrnaqas8XFy5Arn3GrW2vF1S934xCr90vF1Fvw18Ar93Way3A34DJFyj
 vFWrKryUWF1UA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
 F4_UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.431,
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



On 2024/7/10 下午12:00, Jiaxun Yang wrote:
> 
> 
> 在2024年7月9日七月 下午8:04，maobibo写道：
>> Hi Philippe/Jiaxun,
>>
>> Could you do me a favor giving a review about this patch?
> 
> Hi Bibo,
> 
> I’m currently traveling, will test and review next week.
> 
> I’m not really convinced to give a R-b but I’m fine with a T-b.
That is ok for me, have a good time.

Regards
Bibo Mao
> 
> Thanks
> 
>>
>> Regards
>> Bibo Mao
>>
>> On 2024/7/4 上午11:37, Bibo Mao wrote:
>>> Now loongson ipi and loongarch ipi share the same code with different
>>> macro, loongson ipi has its separate function such mmio region,
>>> loongarch ipi has other requirement such as irqchip in kernel.
>>>
>>> Interrupt irqchip has strong relationship with architecture, since
>>> it sends irq to vcpu and interfaces to get irqchip register is also
>>> architecture specific.
>>>
>>> Here like other architectures, base class TYPE_LOONGSON_IPI_COMMON
>>> is added, it comes from loongson ipi mostly. And it defined four abstract
>>> interfaces which can be used for MIPS 3A4000 and Loongarch 3A5000 machine,
>>> also can be used for 3A5000 irqchip in kernel mode soon.
>>>
>>> Also Loongarch ipi and loongson ipi device are added here, it inherits
>>> from base class TYPE_LOONGSON_IPI_COMMON. Loongarch ipi is tested,
>>> loongson ipi device only passes to compile and make check, it is not
>>> tested.
>>>
>>> Bibo Mao (4):
>>>     hw/intc/loongson_ipi_common: Add loongson ipi common class
>>>     hw/intc/loongarch_ipi: Add loongarch ipi support
>>>     hw/loongarch/virt: Replace loongson ipi with loongarch ipi
>>>     hw/intc/loongson_ipi: reconstruct driver inherit from common class
>>>
>>>    hw/intc/Kconfig                       |   3 +
>>>    hw/intc/loongarch_ipi.c               |  80 ++++++
>>>    hw/intc/loongson_ipi.c                | 330 ++-------------------
>>>    hw/intc/loongson_ipi_common.c         | 394 ++++++++++++++++++++++++++
>>>    hw/intc/meson.build                   |   3 +-
>>>    hw/loongarch/Kconfig                  |   2 +-
>>>    hw/loongarch/virt.c                   |   4 +-
>>>    include/hw/intc/loongarch_ipi.h       |  33 +++
>>>    include/hw/intc/loongson_ipi.h        |  54 ++--
>>>    include/hw/intc/loongson_ipi_common.h |  77 +++++
>>>    include/hw/loongarch/virt.h           |   1 -
>>>    11 files changed, 632 insertions(+), 349 deletions(-)
>>>    create mode 100644 hw/intc/loongarch_ipi.c
>>>    create mode 100644 hw/intc/loongson_ipi_common.c
>>>    create mode 100644 include/hw/intc/loongarch_ipi.h
>>>    create mode 100644 include/hw/intc/loongson_ipi_common.h
>>>
>>>
>>> base-commit: 6746482d12da3b6e4d3cdf06481a0027a797f719
>>>
> 


