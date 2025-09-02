Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7AECA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 08:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utMkV-0000K6-3m; Tue, 02 Sep 2025 04:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1utMkO-0000JJ-50
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 04:52:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1utMkJ-0002Pn-2P
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 04:52:11 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Axjr8rsLZor7YFAA--.10653S3;
 Tue, 02 Sep 2025 16:51:56 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxpeQosLZo5Zh4AA--.51571S3;
 Tue, 02 Sep 2025 16:51:55 +0800 (CST)
Subject: Re: [PATCH v2] hw/loongarch/virt: Add reset interface for virt-machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
References: <20250901081900.2931303-1-maobibo@loongson.cn>
 <e99ce8c4-b2cc-4eba-a947-f150330eda34@linaro.org>
 <a205202e-7d0d-0739-ddd6-11a2081a9810@loongson.cn>
 <186d81e1-220c-47b2-a899-9f48520b44ff@linaro.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <1ce8d6ce-7b86-62dd-e980-39d90deb3def@loongson.cn>
Date: Tue, 2 Sep 2025 16:49:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <186d81e1-220c-47b2-a899-9f48520b44ff@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpeQosLZo5Zh4AA--.51571S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFyUXw1fJF1UWFyxCw4fXrc_yoW8Krykpr
 97CFs8tryDGr1fJw4a9w1Uuryjyw1ktwn8ZF13JF1Fyrs0gryYqr4jvryq9FZrArWrGF4j
 qr4DKry3uFyUAFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
 xVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
 AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
 42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
 IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
 xhVjvjDU0xZFpf9x07UWHqcUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.599,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 2025/9/2 下午4:09, Philippe Mathieu-Daudé wrote:
> On 2/9/25 04:27, Bibo Mao wrote:
>>
>>
>> On 2025/9/1 下午6:51, Philippe Mathieu-Daudé wrote:
>>> Hi Bibo,
>>>
>>> On 1/9/25 10:19, Bibo Mao wrote:
>>>> With generic cpu reset interface, pc register is entry of FLASH for
>>>> UEFI BIOS. However with direct kernel booting requirement, there is
>>>> a little different, pc register of primary cpu is entry address of ELF
>>>> file.
>>>>
>>>> At the same time with requirement of cpu hotplug, hot-added CPU should
>>>> register reset interface for this cpu object. Now reset callback is
>>>> not registered for hot-added CPU.
>>>>
>>>> With this patch reset callback for CPU is register when CPU instance
>>>> is created, and reset interface is added for virt-machine board. In
>>>> reset interface of virt-machine, reset for direct kernel booting
>>>> requirement is called.
>>>>
>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>> ---
>>>> v1 ... v2:
>>>>    1. Add qemu_unregister_reset() in function 
>>>> loongarch_cpu_unrealizefn(),
>>>>       remove reset callback if vCPU is unrealized.
>>>> ---
>>>>
>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>> ---
>>>>   hw/loongarch/boot.c         |  9 +--------
>>>>   hw/loongarch/virt.c         | 14 ++++++++++++++
>>>>   include/hw/loongarch/boot.h |  1 +
>>>>   target/loongarch/cpu.c      | 11 +++++++++++
>>>>   4 files changed, 27 insertions(+), 8 deletions(-)
> 
> 
>>>>   static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
>>>>   {
>>>>       CPUState *cs = CPU(dev);
>>>> @@ -668,6 +675,9 @@ static void loongarch_cpu_realizefn(DeviceState 
>>>> *dev, Error **errp)
>>>>       qemu_init_vcpu(cs);
>>>>       cpu_reset(cs);
>>>
>>> Devices shouldn't call their DeviceReset handler manually, as it is
>>> always called after DeviceRealize.
>  >> ok, will remove this.
> 
> This is a legacy pattern we want to eventually clean. Maybe we still
> need this one at this point. See for reference this series:
> https://lore.kernel.org/qemu-devel/20231128170008.57ddb03e@imammedo.users.ipa.redhat.com/ 
> 
Will keep it and thanks for the information, although it is hard to me 
to know the details :-(

Regards
Bibo Mao


