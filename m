Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5C9C982FD
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 01:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8pMH-0000Tz-6u; Mon, 21 Sep 2026 21:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x8pME-0000Tj-Ap
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 21:31:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x8pMA-0002aR-W5
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 21:31:42 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxKvBs2rFqbnwOAA--.42240S3;
 Tue, 22 Sep 2026 09:31:24 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAx2c1l2rFqHJMjAA--.10469S2;
 Tue, 22 Sep 2026 09:31:19 +0800 (CST)
Subject: Re: [PATCH RESEND] target/loongarch: add get_sys() helper
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
References: <20260920024305.18296-1-prcups@krgm.moe>
 <e3adaec7-48f3-2a3c-5270-e2a0a2dd3ded@loongson.cn>
 <u3zKTxIUQm662wDx7NaOSA@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <250b3838-aec2-33fb-93d8-c84847168fae@loongson.cn>
Date: Tue, 22 Sep 2026 09:30:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <u3zKTxIUQm662wDx7NaOSA@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAx2c1l2rFqHJMjAA--.10469S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtF4fWw1rGw4fXr4fZr4DKFX_yoWxZw4fpr
 WkAF9I93WUWFW8Ar1Iq3W5t3Z0qr4xCw1I9340k3WxA3s5tr43XFWDGrn3CF95AryFkr40
 9F1DGF43GFs8JFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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



On 2026/9/21 下午12:20, SignKirigami wrote:
> On 2026年9月20日星期日 中国标准时间 11:40:37，Bibo Mao wrote：
>>
>> On 2026/9/20 上午10:43, SignKirigami wrote:
>>> Add get_sys() to retrieve a CPUSysState by VM level. Use it to access
>>> the host state in CPU initialization and reset paths, and name the
>>> local pointer host to distinguish it from the currently selected state
>>> returned by env_sys() or guest. There is no function change in this
>>> patch.
>>>
>>> Signed-off-by: SignKirigami <prcups@krgm.moe>
>>> ---
>>> This patch is a resend of [1], Sorry for wrongly handling Signed-off-by.
>>>    
>>> [1]: https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg05969.html
>>>
>>>    target/loongarch/cpu.c | 45 +++++++++++++++++++++---------------------
>>>    target/loongarch/cpu.h |  5 +++++
>>>    2 files changed, 27 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>>> index f22f64efb8..c71531c1cf 100644
>>> --- a/target/loongarch/cpu.c
>>> +++ b/target/loongarch/cpu.c
>>> @@ -142,12 +142,12 @@ static void loongarch_la464_init_csr(DeviceState *dev)
>>>        static bool initialized;
>>>        LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>>>        CPULoongArchState *env = &cpu->env;
>>> -    CPUSysState *sys = env_sys(env);
>>> +    CPUSysState *host = get_sys(env, VM_LEVEL0);
>> Why env_sys() need be replaced with get_sys() in CPU init stage?
>>
>> Regards
>> Bibo Mao
> It needs to be distinguished from CPUSysState* which is gotten from
> VM_LEVEL1, and from current vm_level after LVZ is imported.
By my understanding, with loongarch_la464_init_csr(), its default level 
is VM_LEVEL0 even if LVZ is supported. VMM hypervisor will set CSR 
registers when start VM. Is that right?

With loongarch_cpu_reset_hold(), when vCPU is running in VM mode, there 
may be reset/shutdown request.

Regards
Bibo Mao

> Regards
> SignKirigami
>>>        int i, num;
>>>    
>>>        if (!initialized) {
>>>            initialized = true;
>>> -        num = FIELD_EX64(sys->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM);
>>> +        num = FIELD_EX64(host->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM);
>>>            for (i = num; i < 16; i++) {
>>>                set_csr_flag(LOONGARCH_CSR_SAVE(i), CSRFL_UNUSED);
>>>            }
>>> @@ -300,7 +300,7 @@ static void loongarch_la464_initfn(Object *obj)
>>>    {
>>>        LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>>>        CPULoongArchState *env = &cpu->env;
>>> -    CPUSysState *sys;
>>> +    CPUSysState *host = get_sys(env, VM_LEVEL0);
>>>        uint32_t data = 0, field;
>>>        int i;
>>>    
>>> @@ -408,19 +408,18 @@ static void loongarch_la464_initfn(Object *obj)
>>>        data = FIELD_DP32(data, CPUCFG20, L3IU_SIZE, 6);
>>>        env->cpucfg[20] = data;
>>>    
>>> -    sys = env_sys(env);
>>> -    sys->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
>>> +    host->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
>>>    
>>> -    sys->CSR_PRCFG1 = FIELD_DP64(sys->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM, 8);
>>> -    sys->CSR_PRCFG1 = FIELD_DP64(sys->CSR_PRCFG1, CSR_PRCFG1, TIMER_BITS, 0x2f);
>>> -    sys->CSR_PRCFG1 = FIELD_DP64(sys->CSR_PRCFG1, CSR_PRCFG1, VSMAX, 7);
>>> +    host->CSR_PRCFG1 = FIELD_DP64(host->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM, 8);
>>> +    host->CSR_PRCFG1 = FIELD_DP64(host->CSR_PRCFG1, CSR_PRCFG1, TIMER_BITS, 0x2f);
>>> +    host->CSR_PRCFG1 = FIELD_DP64(host->CSR_PRCFG1, CSR_PRCFG1, VSMAX, 7);
>>>    
>>> -    sys->CSR_PRCFG2 = 0x3ffff000;
>>> +    host->CSR_PRCFG2 = 0x3ffff000;
>>>    
>>> -    sys->CSR_PRCFG3 = FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, TLB_TYPE, 2);
>>> -    sys->CSR_PRCFG3 = FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, MTLB_ENTRY, 63);
>>> -    sys->CSR_PRCFG3 = FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, STLB_WAYS, 7);
>>> -    sys->CSR_PRCFG3 = FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS, 8);
>>> +    host->CSR_PRCFG3 = FIELD_DP64(host->CSR_PRCFG3, CSR_PRCFG3, TLB_TYPE, 2);
>>> +    host->CSR_PRCFG3 = FIELD_DP64(host->CSR_PRCFG3, CSR_PRCFG3, MTLB_ENTRY, 63);
>>> +    host->CSR_PRCFG3 = FIELD_DP64(host->CSR_PRCFG3, CSR_PRCFG3, STLB_WAYS, 7);
>>> +    host->CSR_PRCFG3 = FIELD_DP64(host->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS, 8);
>>>    
>>>        cpu->msgint = ON_OFF_AUTO_OFF;
>>>        cpu->ptw = ON_OFF_AUTO_OFF;
>>> @@ -627,7 +626,7 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>>>        CPUState *cs = CPU(obj);
>>>        LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(obj);
>>>        CPULoongArchState *env = cpu_env(cs);
>>> -    CPUSysState *sys = env_sys(env);
>>> +    CPUSysState *host = get_sys(env, VM_LEVEL0);
>>>    
>>>        if (lacc->parent_phases.hold) {
>>>            lacc->parent_phases.hold(obj, type);
>>> @@ -638,7 +637,7 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>>>         * its value is equal to zero for boot cpu, it causes reboot issue.
>>>         */
>>>        memset(env, 0, offsetof(CPULoongArchState, end_reset_fields));
>>> -    memset(sys, 0, offsetof(CPUSysState, end_reset_fields));
>>> +    memset(host, 0, offsetof(CPUSysState, end_reset_fields));
>>>    
>>>    #ifdef CONFIG_TCG
>>>        env->fcsr0_mask = FCSR0_M1 | FCSR0_M2 | FCSR0_M3;
>>> @@ -655,17 +654,17 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>>>        }
>>>    #endif
>>>    
>>> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DA, 1);
>>> -    sys->CSR_CPUID = cs->cpu_index;
>>> -    sys->CSR_TID = cs->cpu_index;
>>> +    host->CSR_CRMD = FIELD_DP64(host->CSR_CRMD, CSR_CRMD, DA, 1);
>>> +    host->CSR_CPUID = cs->cpu_index;
>>> +    host->CSR_TID = cs->cpu_index;
>>>    
>>>        /* set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits from CSR_PRCFG2 */
>>> -    if (sys->CSR_PRCFG2 == 0) {
>>> -        sys->CSR_PRCFG2 = 0x3fffff000;
>>> +    if (host->CSR_PRCFG2 == 0) {
>>> +        host->CSR_PRCFG2 = 0x3fffff000;
>>>        }
>>> -    tlb_ps = ctz32(sys->CSR_PRCFG2);
>>> -    sys->CSR_STLBPS = FIELD_DP64(sys->CSR_STLBPS, CSR_STLBPS, PS, tlb_ps);
>>> -    sys->CSR_PWCL = FIELD_DP64(sys->CSR_PWCL, CSR_PWCL, PTBASE, tlb_ps);
>>> +    tlb_ps = ctz32(host->CSR_PRCFG2);
>>> +    host->CSR_STLBPS = FIELD_DP64(host->CSR_STLBPS, CSR_STLBPS, PS, tlb_ps);
>>> +    host->CSR_PWCL = FIELD_DP64(host->CSR_PWCL, CSR_PWCL, PTBASE, tlb_ps);
>>>    
>>>    #ifndef CONFIG_USER_ONLY
>>>        env->pc = 0x1c000000;
>>> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
>>> index c592f69885..477a5dee7d 100644
>>> --- a/target/loongarch/cpu.h
>>> +++ b/target/loongarch/cpu.h
>>> @@ -512,6 +512,11 @@ static inline void set_sys_state(CPULoongArchState *env, CPUSysState *sys)
>>>        env->sys_state = sys;
>>>    }
>>>    
>>> +static inline CPUSysState *get_sys(CPULoongArchState *env, int vm_level)
>>> +{
>>> +    return &env->sys_states[vm_level];
>>> +}
>>> +
>>>    static inline CPUTimerState *env_timer(CPULoongArchState *env)
>>>    {
>>>        return &env->sys_states[0].timer_state;
>>>
>>
>>
> 
> 
> 


