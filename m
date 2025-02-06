Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC97C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfyDM-0000cR-3D; Thu, 06 Feb 2025 04:30:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tfyD7-0000OC-6H
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:30:15 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tfyD1-0005o8-LL
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:30:11 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Cx73MKgaRn3DltAA--.27881S3;
 Thu, 06 Feb 2025 17:29:47 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCxbsUHgaRnat8BAA--.8594S3;
 Thu, 06 Feb 2025 17:29:46 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: fix vcpu reset command word issue
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
References: <20250205120635.2516406-1-lixianglai@loongson.cn>
 <3e857bbf-834b-3ae5-f9c4-35d858db5108@loongson.cn>
 <a8ee0227-8385-4907-b24b-efddaf907165@linaro.org>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <3bad0c4a-0fa0-a35f-d400-d0d38c22057b@loongson.cn>
Date: Thu, 6 Feb 2025 17:29:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a8ee0227-8385-4907-b24b-efddaf907165@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxbsUHgaRnat8BAA--.8594S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CrykAF4kCw15Cr1ftw4fWFX_yoW8Zry3pr
 ykAFWDKFyFkrykJ3sFq34qq34UAr47Gwn7XFyIqFyIyrs0qry0g3W0qrsI9F98Aw4xGF4Y
 yr1Fkr1UZFW7JwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
 6r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
 Ja73UjIFyTuYvjxUrNtxDUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.838,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2025/2/6 下午5:02, Philippe Mathieu-Daudé wrote:
> On 6/2/25 03:34, bibo mao wrote:
>> On 2025/2/5 下午8:06, Xianglai Li wrote:
>>> When the KVM_REG_LOONGARCH_VCPU_RESET command word
>>> is sent to the kernel through the kvm_set_one_reg interface,
>>> the parameter source needs to be a legal address,
>>> otherwise the kernel will return an error and the command word
>>> will fail to be sent.
>> Hi Xianglai,
>>
>> Good catch, it is actually one problem and thanks for reporting it.
>>
>>>
>>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>>> ---
>>> Cc: Bibo Mao <Maobibo@loongson.cn>
>>> Cc: Song Gao <gaosong@loongson.cn>
>>>
>>>   target/loongarch/kvm/kvm.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>>> index a3f55155b0..01cddb7012 100644
>>> --- a/target/loongarch/kvm/kvm.c
>>> +++ b/target/loongarch/kvm/kvm.c
>>> @@ -581,9 +581,10 @@ static int kvm_loongarch_get_lbt(CPUState *cs)
>>>   void kvm_arch_reset_vcpu(CPUState *cs)
>>>   {
>>>       CPULoongArchState *env = cpu_env(cs);
>>> +    uint64_t val;
>> How about set initial value here although it is not used? such as
>>         uint64_t val = 0;
> 
> Or        uint64_t unused = 0;
yes, that is better and easier to understand -:)

> 
>>>       env->mp_state = KVM_MP_STATE_RUNNABLE;
>>> -    kvm_set_one_reg(cs, KVM_REG_LOONGARCH_VCPU_RESET, 0);
>>> +    kvm_set_one_reg(cs, KVM_REG_LOONGARCH_VCPU_RESET, &val);
>> Can we add return value checking here? such as
>>         ret = kvm_set_one_reg(cs, KVM_REG_LOONGARCH_VCPU_RESET, &val);
>>         if (ret) {
>>             error_report("... %s", strerror(errno));
>>         }
>>
>> Regards
>> Bibo Mao
>>>   }
>>>   static int kvm_loongarch_get_mpstate(CPUState *cs)
>>>
>>
>>


