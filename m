Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23CBCDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 04:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcbIO-0005B5-5Z; Thu, 25 Jun 2026 00:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wcbID-0005AE-Pz
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 00:02:22 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wcbI9-0001T5-Lr
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 00:02:20 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxDupAqDxqxbEXAA--.60303S3;
 Thu, 25 Jun 2026 12:02:08 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxC8I9qDxqT1yyAA--.10011S3;
 Thu, 25 Jun 2026 12:02:08 +0800 (CST)
Subject: Re: [PATCH 3/4] target/loongarch/kvm: remove redundant cpucfg failure
 traces
To: Tao Cui <cui.tao@linux.dev>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@mailo.com>,
 Qiang Ma <maqianga@uniontech.com>, Tao Cui <cuitao@kylinos.cn>
References: <20260625015835.678819-1-cui.tao@linux.dev>
 <20260625015835.678819-4-cui.tao@linux.dev>
 <19b9d5f5-1304-6500-23d5-225f3c021422@loongson.cn>
 <f26f5a87-f60d-4dd7-9e6c-270ea9de7ad4@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <be3f669c-7cbc-19dd-1546-a047a3f2011a@loongson.cn>
Date: Thu, 25 Jun 2026 11:58:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f26f5a87-f60d-4dd7-9e6c-270ea9de7ad4@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxC8I9qDxqT1yyAA--.10011S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF4kKr4kKF1fXF4kJFWrJFc_yoW5Kr17pr
 n2yF98KryUArWkJw1qq34DXryUJr17Gw47Z3WxJFyxAr43tr12qF40qrsIgF4rG3ykXas0
 qFW5urZxZFy5X3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
 67AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
 daVFxhVjvjDU0xZFpf9x07jYSoJUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.97,
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



On 2026/6/25 上午11:33, Tao Cui wrote:
> 
> 
> 在 2026/6/25 10:38, Bibo Mao 写道:
>>
>>
>> On 2026/6/25 上午9:58, Tao Cui wrote:
>>> From: Tao Cui <cuitao@kylinos.cn>
>>>
>>> kvm_get_one_reg() and kvm_set_one_reg() already trace on failure, so the
>>> trace_kvm_failed_get_cpucfg()/trace_kvm_failed_put_cpucfg() calls in
>>> kvm_loongarch_get_cpucfg() and kvm_loongarch_put_cpucfg() duplicate that.
>>> Remove the calls and the now-unused trace events.
>>>
>>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>>> ---
>>>    target/loongarch/kvm/kvm.c    | 6 ------
>>>    target/loongarch/trace-events | 2 --
>>>    2 files changed, 8 deletions(-)
>>>
>>> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>>> index fffb2d431a..6c3eea87b0 100644
>>> --- a/target/loongarch/kvm/kvm.c
>>> +++ b/target/loongarch/kvm/kvm.c
>>> @@ -714,9 +714,6 @@ static int kvm_loongarch_get_cpucfg(CPUState *cs)
>>>          for (i = 0; i < 21; i++) {
>>>            ret = kvm_get_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
>>> -        if (ret < 0) {
>>> -            trace_kvm_failed_get_cpucfg(strerror(errno));
>> yeap, the trace is unnecessary, should we return immediately if there is error? otherwise the previous error will be overwritten.
>>
> 
> You're right that the per-iteration ret assignmentoverwrites earlier errors. That's addressed in patch 4/4 ("fix cpucfg sync
> error handling") of this series:
> 
>      int r = kvm_get_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
>      ret |= r;
>      if (!r) {
>          env->cpucfg[i] = (uint32_t)val;
>      }
> 
> I went with ret |= (accumulate) rather than returning immediately, to match
> the existing kvm_loongarch_get_csr()/put_csr() loops in the same file which
> also accumulate; it additionally skips storing cpucfg[i] on a failed read.
> 
> Happy to switch to an early return if you prefer that style.
Both are ok for me, no special points here :)

Regards
Bibo Mao
> 
> Thanks,
> Tao
> 
>>
>>> -        }
>>>            env->cpucfg[i] = (uint32_t)val;
>>>        }
>>>        return ret;
>>> @@ -772,9 +769,6 @@ static int kvm_loongarch_put_cpucfg(CPUState *cs)
>>>        }
>>>            val = env->cpucfg[i];
>>>            ret = kvm_set_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
>>> -        if (ret < 0) {
>>> -            trace_kvm_failed_put_cpucfg(strerror(errno));
>>> -        }
>>>        }
>>>        return ret;
>>>    }
>>> diff --git a/target/loongarch/trace-events b/target/loongarch/trace-events
>>> index dea11edc0f..829d8e0f53 100644
>>> --- a/target/loongarch/trace-events
>>> +++ b/target/loongarch/trace-events
>>> @@ -9,7 +9,5 @@ kvm_failed_get_mpstate(const char *msg) "Failed to get mp_state from KVM: %s"
>>>    kvm_failed_put_mpstate(const char *msg) "Failed to put mp_state into KVM: %s"
>>>    kvm_failed_get_counter(const char *msg) "Failed to get counter from KVM: %s"
>>>    kvm_failed_put_counter(const char *msg) "Failed to put counter into KVM: %s"
>>> -kvm_failed_get_cpucfg(const char *msg) "Failed to get cpucfg from KVM: %s"
>>> -kvm_failed_put_cpucfg(const char *msg) "Failed to put cpucfg into KVM: %s"
>>>    kvm_arch_handle_exit(int num) "kvm arch handle exit, the reason number: %d"
>>>    kvm_set_intr(int irq, int level) "kvm set interrupt, irq num: %d, level: %d"
>>>
>>
> 


