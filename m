Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95222C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 03:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmmOW-0003Xl-B2; Tue, 19 Mar 2024 23:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rmmOP-0003Vc-40; Tue, 19 Mar 2024 23:13:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rmmOM-0005nB-7m; Tue, 19 Mar 2024 23:13:28 -0400
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TztrT56hdz1R7Rb;
 Wed, 20 Mar 2024 11:10:33 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 301B214013B;
 Wed, 20 Mar 2024 11:13:07 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 11:13:06 +0800
Message-ID: <d871b00d-9b77-4e31-b2a7-168d9209e286@huawei.com>
Date: Wed, 20 Mar 2024 11:13:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH v8 05/23] target/arm: Support MSR access to ALLINT
To: Peter Maydell <peter.maydell@linaro.org>
CC: <eduardo@habkost.net>, <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, 
 <wangyanan55@huawei.com>, <richard.henderson@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240318093546.2786144-1-ruanjinjie@huawei.com>
 <20240318093546.2786144-6-ruanjinjie@huawei.com>
 <CAFEAcA8ft7eeh0oT-imh-L7m0nPo3TekPUYdcdwYA0xK-qd5gA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA8ft7eeh0oT-imh-L7m0nPo3TekPUYdcdwYA0xK-qd5gA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.35; envelope-from=ruanjinjie@huawei.com;
 helo=szxga07-in.huawei.com
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.417,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2024/3/20 0:45, Peter Maydell wrote:
> On Mon, 18 Mar 2024 at 09:37, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> Support ALLINT msr access as follow:
>>         mrs <xt>, ALLINT        // read allint
>>         msr ALLINT, <xt>        // write allint with imm
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> v5:
>> - Add Reviewed-by.
>> v4:
>> - Remove arm_is_el2_enabled() check in allint_check().
>> - Change to env->pstate instead of env->allint.
>> v3:
>> - Remove EL0 check in aa64_allint_access() which alreay checks in .access
>>   PL1_RW.
>> - Use arm_hcrx_el2_eff() in aa64_allint_access() instead of env->cp15.hcrx_el2.
>> - Make ALLINT msr access function controlled by aa64_nmi.
>> ---
>>  target/arm/helper.c | 34 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
> 
> If you configure with --target-list=aarch64-softmmu,arm-softmmu
> you'll find this fails to build:
> 
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index b19a0178ce..aa0151c775 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -4752,6 +4752,36 @@ static void aa64_daif_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>      env->daif = value & PSTATE_DAIF;
>>  }
>>
>> +static void aa64_allint_write(CPUARMState *env, const ARMCPRegInfo *ri,
>> +                              uint64_t value)
>> +{
>> +    env->pstate = (env->pstate & ~PSTATE_ALLINT) | (value & PSTATE_ALLINT);
>> +}
>> +
>> +static uint64_t aa64_allint_read(CPUARMState *env, const ARMCPRegInfo *ri)
>> +{
>> +    return env->pstate & PSTATE_ALLINT;
>> +}
>> +
>> +static CPAccessResult aa64_allint_access(CPUARMState *env,
>> +                                         const ARMCPRegInfo *ri, bool isread)
>> +{
>> +    if (arm_current_el(env) == 1 && (arm_hcrx_el2_eff(env) & HCRX_TALLINT)) {
>> +        return CP_ACCESS_TRAP_EL2;
>> +    }
>> +    return CP_ACCESS_OK;
>> +}
>> +
>> +static const ARMCPRegInfo nmi_reginfo[] = {
>> +    { .name = "ALLINT", .state = ARM_CP_STATE_AA64,
>> +      .opc0 = 3, .opc1 = 0, .opc2 = 0, .crn = 4, .crm = 3,
>> +      .type = ARM_CP_NO_RAW,
>> +      .access = PL1_RW, .accessfn = aa64_allint_access,
>> +      .fieldoffset = offsetof(CPUARMState, pstate),
>> +      .writefn = aa64_allint_write, .readfn = aa64_allint_read,
>> +      .resetfn = arm_cp_reset_ignore },
>> +};
> 
> These functions and the array have been put in a bit of the
> file that is built whether TARGET_AARCH64 is defined or not...
> 
>> +
>>  static uint64_t aa64_pan_read(CPUARMState *env, const ARMCPRegInfo *ri)
>>  {
>>      return env->pstate & PSTATE_PAN;
>> @@ -9889,6 +9919,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>>      if (cpu_isar_feature(aa64_nv2, cpu)) {
>>          define_arm_cp_regs(cpu, nv2_reginfo);
>>      }
>> +
>> +    if (cpu_isar_feature(aa64_nmi, cpu)) {
>> +        define_arm_cp_regs(cpu, nmi_reginfo);
>> +    }
>>  #endif
> 
> ...but the only reference to them is inside an ifdef TARGET_AARCH64.
> 
> Moving the nmi_reginfo[] and the functions so they are next to
> some other TARGET_AARCH64-only reginfo array inside one of the
> existing ifdef blocks is probably the nicest fix.

Thank you! I'll fix it.

> 
>>
>>      if (cpu_isar_feature(any_predinv, cpu)) {
>> --
> 
> thanks
> -- PMM

