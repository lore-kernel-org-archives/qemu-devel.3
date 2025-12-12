Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59573D59D80
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 18:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU7Zn-0003tC-Sb; Fri, 12 Dec 2025 13:09:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vU7Zk-0003sr-LE
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 13:09:08 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vU7Zh-0008CX-KA
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 13:09:08 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-34ab8e0df53so1326084a91.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 10:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765562944; x=1766167744; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v/O3nA23mWErVWst4u5GNV4DaeVfUrTTdx5eUVvi804=;
 b=XGX9uu3wOs5YBYwHCsoGLBr8+okcQsQ3qrOEG/ZbNPg04uxNgUGb7C3+6Lz2iDrF89
 dCqwtFLLF3sTLl3/9uolSbRINJAc3eSnDwZsTZxyxUs1qKou9mP3P9DoTryNwCYWMs7R
 GosRBgNeNKBIvDpGxd12m3al4qAMqxksEnPSy2+PxfChOx3WyJbWk0zxVZqrTXCJFJ2T
 LD7gJ3aEPRxVcexuJM0kANcFHLoMBNIe60rI3i0bQTAA/kheYWLzYGIYAw/a1IDKqd7W
 5lPdYFBwccxlse6u/KvYUErcC7w3ifT7F8klAUa4qfjNEgh2B27FQbd6s0LDOEdFmVfq
 Iq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765562944; x=1766167744;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v/O3nA23mWErVWst4u5GNV4DaeVfUrTTdx5eUVvi804=;
 b=rzRI7VMRQ9UQGgUds6ATfSLM9gE3CZmIniHGCCPURdq3ID7meuKzeVn5Q1o1LWZ3cd
 z/Pyv2RB7NGXE2QUe1KTiHv0CaewGyEBRm+aI1cASVi7RrHehFO6VeGrif3p4A1kBeOk
 d3QOzDQfgt9FyggnwCryPOU6k63ME5qeeHpLSI5HnQUFYjYRLz/EjmBGLmnsjYJKfyz+
 nqqv+vLQt52wNEGR+ZklUlzaMaDJUq7DMJYCUKjpHhT6zeDuFqpctb5pFE+Fuk+me69P
 zEr8bH3OeuVNSunGWMjzy7Mkap43cAjlUkxJX2voFyAarQNVvbMMNVvLNEcXEMN8QZY/
 r32g==
X-Gm-Message-State: AOJu0YzaK+MTzEoJmwjgQ4KRNc2lOOq0qbm+7WDnm9I1TcMDGjMg9deY
 zv7v3u2gcAPVYKo9TMhkrJKEX4WTubTliesl8TqN/Gtss91zCwkfQo0RXaRr4VlyXgc=
X-Gm-Gg: AY/fxX7k+WeZNnZNz7AlrZA6oCXA1AiS9zt3TEtayq0fZzMOv0/JKJkg0F2KKgxMiRu
 NnnaCmtblKalokO23Y5Zzq35ok4kJYm2yuHUdmCSFJflzLXVb9bffdYRUA4zFj+GmA5bZd8igvj
 QPtPcFTRx6ORFMCP/pNhNqeAYPZ8v/K1VAdqDJHFDOeO8RaX1k1WHKuMmivnkhjsJat7KO2nPqj
 5AqMw0iTR6+Tb3V/QkAhLWNPw8xIn39GK7cyIG+KvrraNJeccOavFj/d1tqPV6IZt6ob3XvopuU
 LO3OBGV8CpzsDbKOp4z8LEDxzsiGZrpkHLr0tvhg/Sr86XDEdJYxWZqwFn4lkkcuVfIXDSziO5W
 8Z0VwYD7fOhmusX1OQ/wun+smu1sTi/xuTQe7NVvBINFIVOQgMrdHGvyEwryu1fMAWp6Z4Fl7Vb
 sgljwL4iyDrF1wg1NTobwg8xaDhG7YOnn/haJFdERxu3qpLwr0ik8JtpQ=
X-Google-Smtp-Source: AGHT+IH8Ku9A4ZjvbuO/zhwFwcSWfREtQp8ACuu4mm/MrnuBFDC5ft0g6aek2Q4Q/bNOezkWatn0Ww==
X-Received: by 2002:a17:90b:3b8e:b0:340:f05a:3eca with SMTP id
 98e67ed59e1d1-34abd76c2famr2763553a91.20.1765562943489; 
 Fri, 12 Dec 2025 10:09:03 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34abe1ffd98sm2501371a91.2.2025.12.12.10.09.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 10:09:03 -0800 (PST)
Message-ID: <1c170d41-f291-4c1c-b87e-1dba64231991@linaro.org>
Date: Fri, 12 Dec 2025 10:09:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/arm/ptw: make granule_protection_check usable
 without a cpu
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Tao Tang <tangtao1634@phytium.com.cn>
References: <20251211234426.2403792-1-pierrick.bouvier@linaro.org>
 <20251211234426.2403792-3-pierrick.bouvier@linaro.org>
 <CAFEAcA-G0QchOw_zXNwUq3KAAKJZggnpeXkt7ePBAUa1SD1P2Q@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA-G0QchOw_zXNwUq3KAAKJZggnpeXkt7ePBAUa1SD1P2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/12/25 2:35 AM, Peter Maydell wrote:
> On Thu, 11 Dec 2025 at 23:44, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> By removing cpu details and use a config struct, we can use the
>> same granule_protection_check with other devices, like SMMU.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> I'm not 100% sure about this approach, mainly because for SMMU
> so far we have taken the route of having its page table
> walk implementation be completely separate from the one in
> the MMU, even though it's pretty similar: the spec for
> CPU page table walk and the one for SMMU page table walk
> are technically in different documents and don't necessarily
> proceed 100% in sync. Still, the function is a pretty big
> one and our other option would probably end up being
> copy-and-paste, which isn't very attractive.
>

I understand your concerns, and will try my best to answer ot it.
I mentioned this approach to Richard yesterday and asked if it was 
something that we could do, and he had a positive feedback, at least in 
my perception.

For PTW, we depend on softmmu, which is why it's not reused on SMMU 
side, which doesn't use softmmu. For Granule Protection, we don't rely 
on it (so far), so I was tempted to make things common rather than 
duplicate this.

SMMU spec does not have a specific GPC or PTW description nor pseudo 
code, it just indicates to follow A-profile spec. The difference is in 
details, like which registers contains expected value, and the GPC field 
that is inconsistently stored somewhere else. Thus the idea to isolate 
this in a "config" structure and reuse the implementation. The same 
could have been done with PTW if we didn't rely on softmmu, or if SMMU 
used it, but that's a topic for another day.

I'm not sure from your paragraph if you are open to it or not, so it 
would help if you could be more explicit. Maybe giving a review is a way 
to say yes, but my brain firmware does not have the "indirect 
communication style" upgrade yet :).

> So my comments below are minor things.
> 
>> ---
>>   target/arm/cpu.h | 14 ++++++++++++++
>>   target/arm/ptw.c | 41 ++++++++++++++++++++++++-----------------
>>   2 files changed, 38 insertions(+), 17 deletions(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index efbef0341da..38cc5823a93 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -1216,6 +1216,20 @@ void arm_v7m_cpu_do_interrupt(CPUState *cpu);
>>
>>   hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
>>                                            MemTxAttrs *attrs);
>> +
>> +typedef struct ARMGranuleProtectionConfig {
>> +    uint64_t gpccr;
>> +    uint64_t gptbr;
>> +    uint8_t parange;
>> +    bool support_sel2;
>> +    AddressSpace *as_secure;
>> +} ARMGranuleProtectionConfig;
>> +
>> +bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
>> +                                  uint64_t paddress,
>> +                                  ARMSecuritySpace pspace,
>> +                                  ARMSecuritySpace ss,
>> +                                  ARMMMUFaultInfo *fi);
> 
> Could we have a doc comment for these prototypes, please?
>

I can add one yes.

>>   #endif /* !CONFIG_USER_ONLY */
>>
>>   int arm_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
>> index 2e6b149b2d1..2b620b03014 100644
>> --- a/target/arm/ptw.c
>> +++ b/target/arm/ptw.c
>> @@ -330,24 +330,23 @@ static bool regime_translation_disabled(CPUARMState *env, ARMMMUIdx mmu_idx,
>>       return (regime_sctlr(env, mmu_idx) & SCTLR_M) == 0;
>>   }
>>
>> -static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
>> -                                     ARMSecuritySpace pspace,
>> -                                     ARMSecuritySpace ss,
>> -                                     ARMMMUFaultInfo *fi)
>> +bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
>> +                                  uint64_t paddress,
>> +                                  ARMSecuritySpace pspace,
>> +                                  ARMSecuritySpace ss,
>> +                                  ARMMMUFaultInfo *fi)
>>   {
> 
> A comment here noting that we share this function with the SMMU
> would probably help us in avoiding inadvertently introducing
> CPU-specifics in future.
>

By definition, removing the cpu from prototype is the guarantee we don't 
use any CPU specifics. I can add a comment though.

>>       MemTxAttrs attrs = {
>>           .secure = true,
>>           .space = ARMSS_Root,
>>       };
>> -    ARMCPU *cpu = env_archcpu(env);
>> -    uint64_t gpccr = env->cp15.gpccr_el3;
>> +    const uint64_t gpccr = config.gpccr;
>>       unsigned pps, pgs, l0gptsz, level = 0;
>>       uint64_t tableaddr, pps_mask, align, entry, index;
>> -    AddressSpace *as;
>>       MemTxResult result;
>>       int gpi;
>>
>> -    if (!FIELD_EX64(gpccr, GPCCR, GPC)) {
>> +    if (!FIELD_EX64(config.gpccr, GPCCR, GPC)) {
> 
> We just set up the 'gpccr' local so we don't need to change this line,
> I think ?
>

Right, just an artifact I forgot to clean up before re-introducing local 
gpccr variable to remove other changed lines.

> Also, the SMMU's SMMU_ROOT_GPT_BASE_CFG does not have the GPC field
> (it keeps its enable bit elsewhere).
>

Yes, you can see in patch attached to cover letter this was handled by 
copying this field.
That said, I can keep a separate bool if you think it's better and 
represent better differences between cpu and smmu.

In SMMU spec, the field for GPC is marked as res0. No idea why they 
chose inconsistency here.

>>           return true;
>>       }
>>
>> @@ -362,7 +361,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
>>        * physical address size is invalid.
>>        */
>>       pps = FIELD_EX64(gpccr, GPCCR, PPS);
>> -    if (pps > FIELD_EX64_IDREG(&cpu->isar, ID_AA64MMFR0, PARANGE)) {
>> +    if (pps > config.parange) {
>>           goto fault_walk;
>>       }
>>       pps = pamax_map[pps];
>> @@ -432,7 +431,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
>>       }
>>
>>       /* GPC Priority 4: the base address of GPTBR_EL3 exceeds PPS. */
>> -    tableaddr = env->cp15.gptbr_el3 << 12;
>> +    tableaddr = config.gptbr << 12;
>>       if (tableaddr & ~pps_mask) {
>>           goto fault_size;
>>       }
>> @@ -446,12 +445,10 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
>>       align = MAKE_64BIT_MASK(0, align);
>>       tableaddr &= ~align;
>>
>> -    as = arm_addressspace(env_cpu(env), attrs);
>> -
>>       /* Level 0 lookup. */
>>       index = extract64(paddress, l0gptsz, pps - l0gptsz);
>>       tableaddr += index * 8;
>> -    entry = address_space_ldq_le(as, tableaddr, attrs, &result);
>> +    entry = address_space_ldq_le(config.as_secure, tableaddr, attrs, &result);
> 
> as_secure is an odd name for the AS here, because architecturally
> GPT walks are done to the Root physical address space. (This is
> why in the current code we set attrs.space to ARMSS_Root and then
> get the QEMU AddressSpace corresponding to those attrs. It happens
> that at the moment that's the same one we use as Secure, but in
> theory we could have 4 completely separate ones for NS, S, Root
> and Realm.)
>

If I followed original code correctly, the call was equivalent to:
cpu_get_address_space(env_cpu(env), ARMASIdx_S),
because .secure was set in attrs. See details below.

If you prefer completeness, we can introduce four memory regions, and 
four address spaces. But then, it does not match what cpu implementation 
is doing, so I'm not sure if we should change everything. I would favor 
consistency over preference here.

Let me know what would you prefer, and which naming convention we can 
follow, I'm open to any approach.

>>       if (result != MEMTX_OK) {
>>           goto fault_eabt;
>>       }
>> @@ -479,7 +476,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
>>       level = 1;
>>       index = extract64(paddress, pgs + 4, l0gptsz - pgs - 4);
>>       tableaddr += index * 8;
>> -    entry = address_space_ldq_le(as, tableaddr, attrs, &result);
>> +    entry = address_space_ldq_le(config.as_secure, tableaddr, attrs, &result);
>>       if (result != MEMTX_OK) {
>>           goto fault_eabt;
>>       }
>> @@ -513,7 +510,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
>>       case 0b1111: /* all access */
>>           return true;
>>       case 0b1000: /* secure */
>> -        if (!cpu_isar_feature(aa64_sel2, cpu)) {
>> +        if (!config.support_sel2) {
>>               goto fault_walk;
>>           }
>>           /* fall through */
>> @@ -3786,8 +3783,18 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
>>                               memop, result, fi)) {
>>           return true;
>>       }
>> -    if (!granule_protection_check(env, result->f.phys_addr,
>> -                                  result->f.attrs.space, ptw->in_space, fi)) {
>> +
>> +    ARMCPU *cpu = env_archcpu(env);
>> +    struct ARMGranuleProtectionConfig gpc = {
>> +        .gpccr = env->cp15.gpccr_el3,
>> +        .gptbr = env->cp15.gptbr_el3,
>> +        .parange = FIELD_EX64_IDREG(&cpu->isar, ID_AA64MMFR0, PARANGE),
>> +        .support_sel2 = cpu_isar_feature(aa64_sel2, cpu),
>> +        .as_secure = cpu_get_address_space(env_cpu(env), ARMASIdx_S)
> 
> Directly coding ARMASIDx_S here is a bit awkward, as noted above.
>

As mentioned above, this is what the original code was doing anyway, 
because of:

      MemTxAttrs attrs = {
          .secure = true,
          .space = ARMSS_Root,
      };

...

      as = arm_addressspace(env_cpu(env), attrs);

...

static inline AddressSpace *arm_addressspace(CPUState *cs, MemTxAttrs attrs)
{
     return cpu_get_address_space(cs, arm_asidx_from_attrs(cs, attrs));
}

....

static inline int arm_asidx_from_attrs(CPUState *cs, MemTxAttrs attrs)
{
     return attrs.secure ? ARMASIdx_S : ARMASIdx_NS;
}

Maybe something was wrong with original implementation though.

>> +    };
>> +    if (!arm_granule_protection_check(gpc, result->f.phys_addr,
>> +                                      result->f.attrs.space, ptw->in_space,
>> +                                      fi)) {
>>           fi->type = ARMFault_GPCFOnOutput;
>>           return true;
>>       }
> 
> thanks
> -- PMM

Thank you for your review Peter!

