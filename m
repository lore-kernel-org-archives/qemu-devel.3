Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8716DC3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 02:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGqaK-000304-OU; Sun, 18 May 2025 22:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uGqaJ-0002zr-Jk
 for qemu-devel@nongnu.org; Sun, 18 May 2025 22:50:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uGqaH-0003fJ-P4
 for qemu-devel@nongnu.org; Sun, 18 May 2025 22:50:35 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bx3651nCpoeZHxAA--.45099S3;
 Mon, 19 May 2025 10:50:29 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxn8VxnCpoX0fgAA--.49917S3;
 Mon, 19 May 2025 10:50:29 +0800 (CST)
Subject: Re: [PATCH 14/15] target/loongarch: Report error with split
 kernel_irqchip option
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, QEMU devel <qemu-devel@nongnu.org>,
 Xianglai Li <lixianglai@loongson.cn>
References: <20250509100747.1070094-1-maobibo@loongson.cn>
 <20250509101245.1070255-1-maobibo@loongson.cn>
 <20250509101245.1070255-4-maobibo@loongson.cn>
 <977bcff5-d3bf-47b5-8958-d279ca22a4d4@app.fastmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <c8487b55-ff53-6086-afc1-d15b9bce5590@loongson.cn>
Date: Mon, 19 May 2025 10:49:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <977bcff5-d3bf-47b5-8958-d279ca22a4d4@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn8VxnCpoX0fgAA--.49917S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Gr47Jw4fur4DtF4DuFyDArc_yoWDJwc_uF
 17Aws5urW8Wa1qy3Z8t395Aw17tr4rGa1FvFWDXr4UK34DJ3WkZrs8K3Z5C34akr4kJws8
 A3s8XrnYyF13KosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8w0
 eJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.872,
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



On 2025/5/9 下午8:14, Jiaxun Yang wrote:
> 
> 
> 在2025年5月9日周五 上午11:12，Bibo Mao写道：
>> Option kernel_irqchip=split is not supported on LoongArch virt machine,
>> report error and exit if detect split kernel_irqchip option.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   target/loongarch/kvm/kvm.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>> index 1bda570482..a8e5724b21 100644
>> --- a/target/loongarch/kvm/kvm.c
>> +++ b/target/loongarch/kvm/kvm.c
>> @@ -1249,7 +1249,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>
>>   int kvm_arch_irqchip_create(KVMState *s)
>>   {
>> -    return 0;
>> +    if (kvm_kernel_irqchip_split()) {
>> +        error_report("-machine kernel_irqchip=split is not supported on ARM.");
>                                                                             ^ ARM :)
oops, silly copy and past here :)
will do.

Regards
Bibo Mao
> 
> Thanks
> 


