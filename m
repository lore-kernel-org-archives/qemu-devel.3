Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C65C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 01:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcbmk-0003IX-6v; Tue, 20 Feb 2024 20:52:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rcbmh-0003IP-VV
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 20:52:31 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rcbmf-0004cQ-6g
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 20:52:31 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8CxmehVV9VlMKMPAA--.21111S3;
 Wed, 21 Feb 2024 09:52:21 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxdMxTV9Vlxl89AA--.44733S3; 
 Wed, 21 Feb 2024 09:52:21 +0800 (CST)
Subject: Re: [PATCH 4/5] hw/loongarch: Set minimium memory size as 256M
To: Thomas Huth <thuth@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240220124126.1164081-1-maobibo@loongson.cn>
 <20240220124126.1164081-5-maobibo@loongson.cn>
 <5b6950e7-1b32-43b1-aff7-08f54b52a056@redhat.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <62bf3ecd-940f-c262-25d5-6e8fafc7a285@loongson.cn>
Date: Wed, 21 Feb 2024 09:52:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5b6950e7-1b32-43b1-aff7-08f54b52a056@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxdMxTV9Vlxl89AA--.44733S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KrWUXF47tw45Gw4Dtr1xCrX_yoW8ZrWDpr
 Z5AFykCFy2qryktFn7JryUXryjqr1xt3ZFqF4UAayUGrs8Xr10qr42q34v9ryDAws7XF10
 vF1ktrn3ZF1Yv3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.297,
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



On 2024/2/21 上午12:47, Thomas Huth wrote:
> On 20/02/2024 13.41, Bibo Mao wrote:
>> The minium memory size for LoongArch UEFI bios is 256M, also some
>> test cases such as migration and qos uses parameter 256M.
>>
>> Here set minium memory size for Loongarch VirtMachine with 256M,
>> also default memory size is changed with 256M.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   hw/loongarch/virt.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index a7d700497d..5bc332f4e3 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -815,8 +815,8 @@ static void virt_init(MachineState *machine)
>>           cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
>>       }
>> -    if (ram_size < 1 * GiB) {
>> -        error_report("ram_size must be greater than 1G.");
>> +    if (ram_size < 256 * MiB) {
>> +        error_report("ram_size must be greater than 256M.");
>>           exit(1);
>>       }
>>       create_fdt(vms);
>> @@ -1144,7 +1144,7 @@ static void virt_class_init(ObjectClass *oc, 
>> void *data)
>>       HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
>>       mc->init = virt_init;
>> -    mc->default_ram_size = 1 * GiB;
>> +    mc->default_ram_size = 256 * MiB;
> 
> While changing the minimum ram_size in the first hunk is certainly a 
> good idea, you should maybe consider twice whether you also want to 
> change the default_ram_size here. 256 MiB is often not enough to run a 
> guest OS like Linux, so for most users it might be more convenient if 
> you have a default_ram_size of 1GiB instead. At least that's what I've 
> seen on other architectures. YMMV.
Sounds good, I will keep default ram size unchanged, and only change 
minimum ram size with 256MiB.

And thanks for your suggestion.

Regards
Bibo Mao
> 
>   Thomas


