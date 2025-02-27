Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E761C197BF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 12:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tncuk-0005HO-M0; Thu, 27 Feb 2025 07:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tncud-0005FH-RK
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 07:22:48 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tncuZ-0005w6-Nn
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 07:22:47 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxTWsIWcBnWrqEAA--.30631S3;
 Thu, 27 Feb 2025 20:22:32 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxLscFWcBnW+0rAA--.34520S3;
 Thu, 27 Feb 2025 20:22:31 +0800 (CST)
Subject: Re: [PATCH v2 0/9] target/loongarch: LoongArch32 fixes 1
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU devel <qemu-devel@nongnu.org>
Cc: Song Gao <gaosong@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
References: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
 <3fd27fd1-b976-2705-7093-aecc6ffa0438@loongson.cn>
 <23d25d66-07f4-454b-903a-f5704e1e686c@app.fastmail.com>
 <baa9614a-a216-58bb-3bce-d56da0c7f287@loongson.cn>
 <b3aa056b-cde8-4f4f-879a-70b1c10e6824@app.fastmail.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <9c3dd441-97bc-6884-9863-371fb23441b0@loongson.cn>
Date: Thu, 27 Feb 2025 20:21:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b3aa056b-cde8-4f4f-879a-70b1c10e6824@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLscFWcBnW+0rAA--.34520S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WFyfXryrWrW7Cw4UCrW3urX_yoW8Cr4kpF
 W8Aay3GF4Utr10v3Wvg34Fg3WYy3srGw15XwnYgry8CrnIvr10qrWqqw17Cry3urySqFy0
 qrWUtw17W3W5GrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70PfDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.13,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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



On 2025/2/27 下午6:44, Jiaxun Yang wrote:
> 
> 
> 在2025年2月25日二月 下午12:33，bibo mao写道：
>> On 2025/2/25 下午8:08, Jiaxun Yang wrote:
>>>
>>>
>>> 在2025年2月25日二月 上午8:50，bibo mao写道：
>>>> On 2025/2/25 上午8:40, Jiaxun Yang wrote:
>>>>> Hi all,
>>>>>
>>>>> This series is a collection of small fixes I made to TCG for
>>>>> LoongArch32.
>>>>>
>>>>> There are still many thing broken, especially on CSRs. More
>>>>> series following. However this is sufficient to boot 32bit
>>>>> kernel.
>>>> Is there any product introduction about LoongArch32 board? such as MMU
>>>> type, memory type(DDR or SRAM), interrupt controller type.
>>>
>>> Sure, for LoongArch32 the most accessible board at the moment is chiplap FPGA [1].
>>>
>>> There are also some ASIC designs (BaiXing Project) based on chiplab.
>>>
>>> Long in short:
>>>
>>> - MMU: PG style
>>> - Mmeory: DDR
>>> - Interrupt controller: custom (Loongson-1C like) connected to CPU's
>>>                           int pin.
>> Thanks for the information, Would you like to emulate LoongArch32
>> chiplap FPGA board in qemu side or other LoongArch32 boards?
> 
> My plan is to use current virt machine (with EXTIOI and so on) for
> LoongArch32, it is trivial to bring up in kernel and give us a lot more
> flexibility rather than emulating an actual board.
virt machine is mainly for kvm board. If it is used as LoongArch32 
board, there is no much benefit to add bunch of code in kernel and qemu 
to emulate non-exist board, on the contrast it is hard to maintain.

In LoongArch community There are many cases posting code in one time, 
disappear and lose maintenance :(

Regards
Bibo MAo

> 
> Thanks
> - Jiaxun
> 
>>
>> Regards
>> Bibo Mao
>>>
>>> Thanks
>>>
>>> [1]: https://gitee.com/loongson-edu/chiplab
>>>
>>>>
>>>> Regards
>>>> Bibo Mao
>>>>>
>>>
>>>
> 


