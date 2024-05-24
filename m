Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096C4C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 01:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAJfN-00036C-Rx; Thu, 23 May 2024 21:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sAJfK-00035b-4L
 for qemu-devel@nongnu.org; Thu, 23 May 2024 21:24:14 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sAJfG-0000N9-KG
 for qemu-devel@nongnu.org; Thu, 23 May 2024 21:24:13 -0400
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8Axz68z7E9m_zcDAA--.3383S3;
 Fri, 24 May 2024 09:24:04 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx68Yu7E9mL2sHAA--.20446S3; 
 Fri, 24 May 2024 09:24:00 +0800 (CST)
Subject: Re: [PATCH v3 0/3] Add extioi virt extension support
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
Cc: QEMU devel <qemu-devel@nongnu.org>
References: <20240521123225.231072-1-gaosong@loongson.cn>
 <2fc2750a-2cd5-4839-9939-98746ee1c602@app.fastmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <a5e3b106-d961-b9e8-50d4-a4bd395c856b@loongson.cn>
Date: Fri, 24 May 2024 09:23:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2fc2750a-2cd5-4839-9939-98746ee1c602@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx68Yu7E9mL2sHAA--.20446S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr1UurWxCF4xWw4rtryruFX_yoW5CFWfpF
 W5CFWa9r4UJry7A3Za93Z3XFyYqws5GFWIgasaq34fW345WF1j9ry09rnYqF9rWryrGFy0
 q3ykGry5u3WUAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.153,
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


Song will online next week.
Please correct me if there is something wrong, song.

On 2024/5/24 上午7:50, Jiaxun Yang wrote:
> 
> 
> 在2024年5月21日五月 下午1:32，Song Gao写道：
>> On LoongArch, IRQs can be routed to four vcpus with hardware extioi.
>> This patch adds the extioi virt extension support so that the IRQ can
>> route to 256 vcpus.
> 
> Hi Song,
> 
> Sorry for chime in here, I'm a little bit confused by this series, can
> you give me a little bit of context behind?
Currently interrupt can be routed to only 4 vcpus with one HW extioi. On 
virt machine, there are 256 vcpus even more in future.

Extioi virt extension is introduced here to route irq to more vcpus.
> 
> I don't see this functionality on 3A5000/3A6000's user manual, so is this
> some sort of undocumented hardware feature?
No, it is not real HW, it is Extioi virt extension, it is virt machine 
model only.

> 
> I checked openEuler kernel patch you referred, it seems like this applies to
> hypervisor mode only. I suppose it should be handled by KVM subsystem in
> kernel, why do we need this in user mode device emulation?
Will do when irqchip is emulated in kernel. Now irqchip is emulated in 
userspace, so it is implemented in userspace firstly.

However it is necessary to emulate in userspace. User can select to 
whether to emulate irqchip in userspace or kernel space, user space 
emulation is easy to debug, kernel space has higher performance. Both 
need extioi virt extension.
> 
> Currently, LoongArch's in-kernel irqchip functionality does not include such
> feature, can we see KVM side support for this, or at least a draft specification?
yeap, maybe more documentation need written for the extioi virt 
extension model.

We are preparing to port irqchip to kernel space, this function will be 
added in kernel space also.


Regards
Bibo Mao
> 
> Thanks
> - Jiaxun
> 
>>
>> v3:
>> - Split patch2 to two small patch.
>> - remove unused code.
>> - loongarch_extioi_reset() clear status without checking virt extioi
>>    features.
>> - Link to v2:
>> https://patchew.org/QEMU/20240514090756.988096-1-gaosong@loongson.cn/
>>
>> v2:
>> - Split the patch to two small patch.
>> - Drop 'RFC' title. extioi virt extension suport only enable on kvm
>>    mode and  the extioi driver need patch[1].
>>    but this series do not affect the old codes in any way.
>> - Link to v1:
>> https://lore.kernel.org/all/20240116022526.498613-1-gaosong@loongson.cn/#r
>>
>> [1]:
>> https://gitee.com/openeuler/kernel/commit/5d97cff72f91f4f20a536efd60eca75bfcb78a64
>>
>> Thanks.
>> Song Gao
>>
>> Song Gao (3):
>>    hw/intc/loongarch_extioi: Add extioi virt extension definition
>>    hw/loongarch/virt: Enable extioi virt extension
>>    hw/loongarch/virt: Use MemTxAttrs interface for misc ops
>>
>>   include/hw/intc/loongarch_extioi.h |  21 ++++++
>>   include/hw/loongarch/virt.h        |   2 +
>>   target/loongarch/cpu.h             |   1 +
>>   hw/intc/loongarch_extioi.c         |  88 +++++++++++++++++++++-
>>   hw/loongarch/virt.c                | 116 +++++++++++++++++++++++++----
>>   5 files changed, 210 insertions(+), 18 deletions(-)
>>
>> -- 
>> 2.34.1
> 


