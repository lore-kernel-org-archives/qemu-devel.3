Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03039CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 03:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcaqy-0007Xj-Ej; Wed, 24 Jun 2026 23:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wcaqw-0007XX-KL
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 23:34:11 -0400
Received: from out-176.mta1.migadu.com ([95.215.58.176])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wcaqu-0000xZ-KK
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 23:34:10 -0400
Message-ID: <f26f5a87-f60d-4dd7-9e6c-270ea9de7ad4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1782358444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxjQEtgqVyXt24BEYWW2EhZmy6MtBwm7xqoQ7Utl2qo=;
 b=tss1GAfdvBModra+21M0YjjwLQnRBDHSfm2cPCiGI/OThe4iDhoemqmwbmGk5m8bpbvnNY
 JMoTTCppDiXSsm8RwcJOH16Nzoa17YvBaOKX1T7+u5nVrxoXjUYr7jOVt2Hr7hCnqSb4Sl
 4cC5MW3V2M9/pFgdwOAlQeXFIdgt4jA=
Date: Thu, 25 Jun 2026 11:33:46 +0800
MIME-Version: 1.0
Cc: cui.tao@linux.dev, Song Gao <gaosong@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Qiang Ma <maqianga@uniontech.com>, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 3/4] target/loongarch/kvm: remove redundant cpucfg failure
 traces
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
References: <20260625015835.678819-1-cui.tao@linux.dev>
 <20260625015835.678819-4-cui.tao@linux.dev>
 <19b9d5f5-1304-6500-23d5-225f3c021422@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <19b9d5f5-1304-6500-23d5-225f3c021422@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.176; envelope-from=cui.tao@linux.dev;
 helo=out-176.mta1.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



在 2026/6/25 10:38, Bibo Mao 写道:
> 
> 
> On 2026/6/25 上午9:58, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> kvm_get_one_reg() and kvm_set_one_reg() already trace on failure, so the
>> trace_kvm_failed_get_cpucfg()/trace_kvm_failed_put_cpucfg() calls in
>> kvm_loongarch_get_cpucfg() and kvm_loongarch_put_cpucfg() duplicate that.
>> Remove the calls and the now-unused trace events.
>>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>   target/loongarch/kvm/kvm.c    | 6 ------
>>   target/loongarch/trace-events | 2 --
>>   2 files changed, 8 deletions(-)
>>
>> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>> index fffb2d431a..6c3eea87b0 100644
>> --- a/target/loongarch/kvm/kvm.c
>> +++ b/target/loongarch/kvm/kvm.c
>> @@ -714,9 +714,6 @@ static int kvm_loongarch_get_cpucfg(CPUState *cs)
>>         for (i = 0; i < 21; i++) {
>>           ret = kvm_get_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
>> -        if (ret < 0) {
>> -            trace_kvm_failed_get_cpucfg(strerror(errno));
> yeap, the trace is unnecessary, should we return immediately if there is error? otherwise the previous error will be overwritten.
> 

You're right that the per-iteration ret assignmentoverwrites earlier errors. That's addressed in patch 4/4 ("fix cpucfg sync
error handling") of this series:

    int r = kvm_get_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
    ret |= r;
    if (!r) {
        env->cpucfg[i] = (uint32_t)val;
    }

I went with ret |= (accumulate) rather than returning immediately, to match
the existing kvm_loongarch_get_csr()/put_csr() loops in the same file which
also accumulate; it additionally skips storing cpucfg[i] on a failed read.

Happy to switch to an early return if you prefer that style.

Thanks,
Tao

> 
>> -        }
>>           env->cpucfg[i] = (uint32_t)val;
>>       }
>>       return ret;
>> @@ -772,9 +769,6 @@ static int kvm_loongarch_put_cpucfg(CPUState *cs)
>>       }
>>           val = env->cpucfg[i];
>>           ret = kvm_set_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
>> -        if (ret < 0) {
>> -            trace_kvm_failed_put_cpucfg(strerror(errno));
>> -        }
>>       }
>>       return ret;
>>   }
>> diff --git a/target/loongarch/trace-events b/target/loongarch/trace-events
>> index dea11edc0f..829d8e0f53 100644
>> --- a/target/loongarch/trace-events
>> +++ b/target/loongarch/trace-events
>> @@ -9,7 +9,5 @@ kvm_failed_get_mpstate(const char *msg) "Failed to get mp_state from KVM: %s"
>>   kvm_failed_put_mpstate(const char *msg) "Failed to put mp_state into KVM: %s"
>>   kvm_failed_get_counter(const char *msg) "Failed to get counter from KVM: %s"
>>   kvm_failed_put_counter(const char *msg) "Failed to put counter into KVM: %s"
>> -kvm_failed_get_cpucfg(const char *msg) "Failed to get cpucfg from KVM: %s"
>> -kvm_failed_put_cpucfg(const char *msg) "Failed to put cpucfg into KVM: %s"
>>   kvm_arch_handle_exit(int num) "kvm arch handle exit, the reason number: %d"
>>   kvm_set_intr(int irq, int level) "kvm set interrupt, irq num: %d, level: %d"
>>
> 


