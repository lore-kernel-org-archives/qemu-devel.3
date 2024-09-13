Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1304AFA3738
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 09:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp2Yd-0000q1-KV; Fri, 13 Sep 2024 05:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sp2Ya-0000pQ-7Z
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 05:25:36 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sp2YX-0004Pi-RA
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 05:25:35 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxneoJBeRm1skGAA--.16240S3;
 Fri, 13 Sep 2024 17:25:29 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxn+QIBeRm4a0FAA--.32584S3;
 Fri, 13 Sep 2024 17:25:29 +0800 (CST)
Subject: Re: [PATCH v4 1/5] hw/loongarch: Rename LOONGARCH_MACHINE with
 LOONGARCH_VIRT_MACHINE
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20240508031110.2507477-1-maobibo@loongson.cn>
 <20240508031110.2507477-2-maobibo@loongson.cn>
 <2f7acdd5-9d9d-442c-a19f-c8a5828ae02b@redhat.com>
 <87jzfg2d7y.fsf@pond.sub.org>
From: maobibo <maobibo@loongson.cn>
Message-ID: <4df78e82-6a4b-c543-281c-b63b283dca42@loongson.cn>
Date: Fri, 13 Sep 2024 17:25:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87jzfg2d7y.fsf@pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn+QIBeRm4a0FAA--.32584S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFW3XFyDZrW5Aw4DXr4xAFc_yoW8XF18pr
 9xAF10ka1qqrZ7ArnIq3WFgF1UArZayFy2qFn5tr4Fka98ur1Fgr10y34kuayUAwn5AF1v
 vws5C3yavayru3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Li
 SJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.188,
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



On 2024/9/13 下午4:02, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 08/05/2024 05.11, Bibo Mao wrote:
>>> On LoongArch system, there is only virt machine type now, name
>>> LOONGARCH_MACHINE is confused, rename it with LOONGARCH_VIRT_MACHINE.
>>> Machine name about Other real hw boards can be added in future.
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>> ---
>> ...
>>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>>> index c0999878df..6619cb52a9 100644
>>> --- a/hw/loongarch/virt.c
>>> +++ b/hw/loongarch/virt.c
>> ...
>>> @@ -1208,7 +1208,6 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
>>>        MachineClass *mc = MACHINE_CLASS(oc);
>>>        HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
>>>    -    mc->desc = "Loongson-3A5000 LS7A1000 machine";
>>>        mc->init = loongarch_init;
>>>        mc->default_ram_size = 1 * GiB;
>>>        mc->default_cpu_type = LOONGARCH_CPU_TYPE_NAME("la464");
>>
>>   Hi!
>>
>> I noticed that the machine now does not have any description anymore, which is kind of ugly when you list the available machines:
>>
>> $ ./qemu-system-loongarch64 -M help
>> Supported machines are:
>> none                 empty machine
>> virt                 (null) (default)
>>
>> Could you please come up with a new mc->desc for the virt machine?
> 
> Formatting a null pointer with %s is actually a crash bug on some
> systems.
Thanks for pointing it out, I will submit a patch to add the description.

Regards
Bibo Ma


