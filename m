Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3D2CE7AA5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 01:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smNYL-0003S6-QK; Thu, 05 Sep 2024 21:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1smNYI-0003RO-TY
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 21:14:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1smNYG-0007xy-5R
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 21:14:18 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bxf5lkV9pmyfIrAA--.47243S3;
 Fri, 06 Sep 2024 09:14:12 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front2 (Coremail) with SMTP id qciowMDx7sVjV9pmMkUHAA--.21102S3;
 Fri, 06 Sep 2024 09:14:11 +0800 (CST)
Subject: Re: qemu direct kernel boot on LoongArch
To: =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: loongarch@lists.linux.dev, qemu-devel@nongnu.org, xry111@xry111.site
References: <49432aed-3ed7-2f07-7f65-311faef96197@loongson.cn>
 <ZtkhtxcJUK-JediY@zx2c4.com>
 <f50c4868-7c2e-1ede-ab19-c67ea0acaab3@loongson.cn>
 <CAHmME9rRJjJ5tHf_xtprkHtWz-ButOOZXVo=E9y8qSyQ-qu6ew@mail.gmail.com>
 <ccc7db47-d065-4e78-bf67-c4e8855c9be4@t-8ch.de> <ZtnGA4mH0I2hdx4N@zx2c4.com>
 <ea52a89c-449f-4aed-8138-f81ad20a1a79@t-8ch.de>
 <CAHmME9pPvk4s9JnEPmc9w71hkeHD_1U-fAy0+8MQNmO_9Gh3=g@mail.gmail.com>
 <b11ba2f4-ba4b-40fb-860e-e10e760562fe@t-8ch.de>
 <CAHmME9pjokr=ahBbJA9Ljf8jjOyfyRAk0Qo4YeDYO_gs78GGzg@mail.gmail.com>
 <7311f2fa-2353-48ad-85f5-5eae1f6cb65f@t-8ch.de>
From: maobibo <maobibo@loongson.cn>
Message-ID: <bac8575f-1c43-1242-9113-ef7957b50e68@loongson.cn>
Date: Fri, 6 Sep 2024 09:14:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7311f2fa-2353-48ad-85f5-5eae1f6cb65f@t-8ch.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qciowMDx7sVjV9pmMkUHAA--.21102S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZFyDXw4ktrWkJrW7XryxZwc_yoW5Jw1fpr
 y7KayDKr4ktr4fAr1Iqr1YgF4jy34ftw1jqws5tFyUJryqqF1Yqr12qrWUCa4UXw1fGw1j
 kFyUXa47Xr4DJagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
 xVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
 AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
 42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
 IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
 KfnxnUUI43ZEXa7IU1LiSJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.9,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 2024/9/6 上午12:03, Thomas Weißschuh wrote:
> On 2024-09-05 17:18:07+0000, Jason A. Donenfeld wrote:
>> On Thu, Sep 5, 2024 at 5:16 PM Thomas Weißschuh <thomas@t-8ch.de> wrote:
>>>
>>> On 2024-09-05 17:07:22+0000, Jason A. Donenfeld wrote:
>>>> On Thu, Sep 5, 2024 at 5:05 PM Thomas Weißschuh <thomas@t-8ch.de> wrote:
>>>>>
>>>>> On 2024-09-05 16:53:55+0000, Jason A. Donenfeld wrote:
>>>>>> On Thu, Sep 05, 2024 at 07:25:05AM +0200, Thomas Weißschuh wrote:
>>>>>>> On 2024-09-05 06:04:12+0000, Jason A. Donenfeld wrote:
>>>>>>>> On Thu, Sep 5, 2024 at 5:45 AM maobibo <maobibo@loongson.cn> wrote:
>>>>>>>>>
>>>>>>>>> Jason,
>>>>>>>>>
>>>>>>>>> With the latest qemu 9.1 version, elf format booting is supported.
>>>>>>>>
>>>>>>>> Thanks, I just figured this out too, about 4 minutes ago. Excellent.
>>>>>>>> And the 1G minimum ram limit is gone too.
>>>>>>>>
>>>>>>>> Now working on how to trigger resets.
>>>>>>>
>>>>>>> With "reset" do you mean normal (non-panic) system shutdown/poweroff?
>>>>>>> Since QEMU 9.1 and a recent kernel you can use the pvpanic device for
>>>>>>> that in a cross-architecture way.
>>>>>>
>>>>>> What I mean is that I need for userspace calling `reboot(RB_AUTOBOOT);`
>>>>>> to actually result in QEMU being told to reboot the system. Sounds like
>>>>>> that's not possible (yet?) in 9.1?
>>>>>
>>>>> With reboot(RB_POWER_OFF) this is indeed the exact usecase for pvpanic
>>>>
>>>> I'm actually using reboot(RB_AUTOBOOT) wth QEMU's -no-reboot, because
>>>> that tends to be far more compatible with a greater number of
>>>> platforms, for example, x86 without acpi. Shucks.
>>>
>>> You can check that both QEMU and the kernel support pvpanic shutdown
>>> through sysfs and if so use reboot(RB_POWER_OFF); and
>>> reboot(RB_AUTOBOOT) otherwise.
>>
>> I guess. But the whole idea is to bloat the code as little as possible
>> and use one interface for everything. Pushing that all up into
>> userspace is pretty icky.
> 
> If it works through ACPI everywhere then sure.
> 
>> It sounds like LoongArch already supports this via ACPI GED, but
>> there's some plumbing that needs to be done still. So maybe I'll just
>> wait for that.
> 
> Also sounds reasonable.
yeap, will submit a patch to expose ACPI GED pm interface with FDT method.

> 
>> Meanwhile, any idea about adding a second serial to the platform? I've
>> been futzing with it for a bit now to no avail.
> 
> No idea, sorry.
Will investigate the second serial method.

Regards
Bibo Mao


