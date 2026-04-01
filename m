Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639C210F92EC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 01:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7k4Y-0006vs-8u; Tue, 31 Mar 2026 21:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1w7k4V-0006tr-Eg
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 21:08:39 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1w7k4S-0008Jc-Ed
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 21:08:39 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxosAHcMxp2qQgAA--.33609S3;
 Wed, 01 Apr 2026 09:08:23 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxquAGcMxpeCJiAA--.56247S3;
 Wed, 01 Apr 2026 09:08:22 +0800 (CST)
Subject: Re: [PATCH v2 0/2] hw/loongarch/virt: Add versioned machine type
 support
To: Cornelia Huck <cohuck@redhat.com>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20251225014102.2666365-1-maobibo@loongson.cn>
 <7276eab9-784a-a551-53b6-d4906c1704aa@loongson.cn>
 <87ecl0dw8a.fsf@redhat.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <fb29cd36-07a6-e9e0-3d55-1cdf409c8eb2@loongson.cn>
Date: Wed, 1 Apr 2026 09:05:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87ecl0dw8a.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxquAGcMxpeCJiAA--.56247S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ary5uw4DCrW3Ww43ArW7KFX_yoW8WFykpF
 WfZFn8uF48Xr4Sk3Zak3WUX3WYy34xGasrWr1fX3sYkFnI9r1Fvr10yr4j9asrJ3yrJr40
 qFn7Ka4fu3WUZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.988,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2026/3/31 下午8:22, Cornelia Huck wrote:
> On Thu, Mar 26 2026, Bibo Mao <maobibo@loongson.cn> wrote:
> 
>> ping.
>>
>> Should the first compatible machine type patch merged before QEMU
>> version release or just after it?
> 
> This is unfortunately the first time I've seen these patches... I would
> expect it to be merged at the beginning of a development cycle, maybe
> softfreeze would have still been ok, but I guess we're a bit late for
> 11.0 now.
> 
> Note, I'm not really the maintainer for this, I guess maintainership for
> this would be with general loongarch machine maintainership, and I would
> have expected it to be included in a pull req there.
> 
> I plan on sending the compat machines for 11.1 soon, feel free to pick
> that patch and rebase this series on top of that (or on top of whatever
> pull req ends up including the 11.1 machines.)
Hi Cornelia,

Thanks for your guidance.

I will sent a new patch with the compat machines for 11.1, please help 
me to pick the patch.

Regards
Bibo Mao
> 
>>
>> Regards
>> Bibo Mao
>>
>> On 2025/12/25 上午9:41, Bibo Mao wrote:
>>> Now la464 CPU type feature is basically finished, versioned machine type
>>> is added here for compatibility support in future.
>>>
>>> ---
>>> v1 ... v2:
>>>     1. Change version machine from 10.2 to 11.0
>>> ---
>>> Bibo Mao (2):
>>>     hw/loongarch/virt: Define virt machine type with type_init()
>>>     hw/loongarch/virt: Define versioned virt machine
>>>
>>>    hw/loongarch/virt.c | 66 ++++++++++++++++++++++++++++++++++++---------
>>>    1 file changed, 53 insertions(+), 13 deletions(-)
>>>
>>>
>>> base-commit: 8dd5bceb2f9cc58481e9d22355a8d998220896de
>>>


