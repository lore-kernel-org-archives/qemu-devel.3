Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5646CC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5Mb-0007TG-PJ; Thu, 22 Feb 2024 04:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rd5MZ-0007Sh-Os; Thu, 22 Feb 2024 04:27:31 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rd5MX-0002ii-DQ; Thu, 22 Feb 2024 04:27:31 -0500
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TgSRT4zTYzXhDg;
 Thu, 22 Feb 2024 17:25:25 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 8894B140257;
 Thu, 22 Feb 2024 17:27:21 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 17:27:20 +0800
Message-ID: <61cb54a9-0940-e92f-e409-0aa8a20587e0@huawei.com>
Date: Thu, 22 Feb 2024 17:27:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH v2 06/22] target/arm: Add support for Non-maskable
 Interrupt
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-7-ruanjinjie@huawei.com>
 <94867836-95f4-4da2-96e9-583e508a762d@linaro.org>
In-Reply-To: <94867836-95f4-4da2-96e9-583e508a762d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=ruanjinjie@huawei.com; helo=szxga02-in.huawei.com
X-Spam_score_int: -74
X-Spam_score: -7.5
X-Spam_bar: -------
X-Spam_report: (-7.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.297,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2024/2/22 4:06, Richard Henderson wrote:
> On 2/21/24 03:08, Jinjie Ruan via wrote:
>> This only implements the external delivery method via the GICv3.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   target/arm/cpu-qom.h |  3 ++-
>>   target/arm/cpu.c     | 39 ++++++++++++++++++++++++++++++++++-----
>>   target/arm/cpu.h     |  2 ++
>>   target/arm/helper.c  |  1 +
>>   4 files changed, 39 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
>> index 8e032691db..66d555a605 100644
>> --- a/target/arm/cpu-qom.h
>> +++ b/target/arm/cpu-qom.h
>> @@ -36,11 +36,12 @@ DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
>>   #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
>>   #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
>>   -/* Meanings of the ARMCPU object's four inbound GPIO lines */
>> +/* Meanings of the ARMCPU object's five inbound GPIO lines */
>>   #define ARM_CPU_IRQ 0
>>   #define ARM_CPU_FIQ 1
>>   #define ARM_CPU_VIRQ 2
>>   #define ARM_CPU_VFIQ 3
>> +#define ARM_CPU_NMI 4
>>     /* For M profile, some registers are banked secure vs non-secure;
>>    * these are represented as a 2-element array where the first element
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 5e5978c302..055670343e 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -128,7 +128,7 @@ static bool arm_cpu_has_work(CPUState *cs)
>>         return (cpu->power_state != PSCI_OFF)
>>           && cs->interrupt_request &
>> -        (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
>> +        (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI
>>            | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ |
>> CPU_INTERRUPT_VSERR
>>            | CPU_INTERRUPT_EXITTB);
>>   }
> 
> I think you should not include CPU_INTERRUPT_NMI when it cannot be
> delivered, e.g. FEAT_NMI not enabled.

I'll fix it.

> 
> 
>> @@ -668,6 +668,7 @@ static inline bool arm_excp_unmasked(CPUState *cs,
>> unsigned int excp_idx,
>>       CPUARMState *env = cpu_env(cs);
>>       bool pstate_unmasked;
>>       bool unmasked = false;
>> +    bool nmi_unmasked = false;
>>         /*
>>        * Don't take exceptions if they target a lower EL.
>> @@ -678,13 +679,29 @@ static inline bool arm_excp_unmasked(CPUState
>> *cs, unsigned int excp_idx,
>>           return false;
>>       }
>>   +    nmi_unmasked = (!(env->allint & PSTATE_ALLINT)) &
>> +                   (!((env->cp15.sctlr_el[target_el] &
>> SCTLR_SPINTMASK) &&
>> +                   (env->pstate & PSTATE_SP) && cur_el == target_el));
> 
> I don't see SCTLR_ELx.NMI being tested anywhere, which is required to
> enable everything else.

I'll Add it

> 
>>       case EXCP_FIQ:
>> -        pstate_unmasked = !(env->daif & PSTATE_F);
>> +        if (cpu_isar_feature(aa64_nmi, env_archcpu(env))) {
>> +            pstate_unmasked = (!(env->daif & PSTATE_F)) & nmi_unmasked;
>> +        } else {
>> +            pstate_unmasked = !(env->daif & PSTATE_F);
>> +        }
>>           break;
>>         case EXCP_IRQ:
>> -        pstate_unmasked = !(env->daif & PSTATE_I);
>> +        if (cpu_isar_feature(aa64_nmi, env_archcpu(env))) {
>> +            pstate_unmasked = (!(env->daif & PSTATE_I)) & nmi_unmasked;
>> +        } else {
>> +            pstate_unmasked = !(env->daif & PSTATE_I);
>> +        }
>>           break;
> 
> I don't see what this is doing.  While Superpriority is IMPLEMENTATION
> DEFINED, how are you defining it for QEMU?  Is there a definition from
> real hw which makes sense under emulation?
> 
> 
> r~

