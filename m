Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9611BCEFC38
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 17:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syE4r-000782-6j; Tue, 08 Oct 2024 13:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syE4o-00076u-HA
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 13:32:50 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syE4m-0001VG-9Z
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 13:32:50 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71df67c67fcso2245487b3a.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 10:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728408765; x=1729013565; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U4Y923DNTB69Q7mP3ieLv48ZUpge+neE9bsJN+T0+x8=;
 b=LszUHZptFxu9SIsgvbjX9HPL1Im+xyXl5iMj85wHUK9nRQYRAKnQV7+/mlWluW861S
 8omywQ4TEFM9/vrsIl9NcM0vQAEbohi07YcERmkTZyJsS8SUtpyMmUeiBl4/uwTm+xKE
 PryBaWyRQ40Rgzxm91RVWJWhoqrOirZWqjXPmw60yNU2Ag0eO65oQfe4a2dFCjuP+zmw
 dlqzQedr/ECFA/K+9DghxtfVKiaIqHk+FWIN1tbzwd3j7fGGhP+fVlXhlGS1l0s+II8L
 yvcWRbY6teAx7O7CIe2tkdiEDgM0sVrqnpY+/pZDAS8X//iKzEdWbSipj9NXmNx16sj4
 yReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728408765; x=1729013565;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U4Y923DNTB69Q7mP3ieLv48ZUpge+neE9bsJN+T0+x8=;
 b=sNc93IPUkm9977uyjJrbvuIhOTREDLuKtlzA+i0BDnZSDtEZLJ/3RmwHa1BwOtyWky
 S5xNmwRsdIAVko0aBwOAnYNjv9hFnf3T8CL4ws4VenTSbp8si1JpbGN4oDeZTPTMO34K
 gR8VTPGSaYeu1G+SPkMa3mAmI8zHx49NkOxoiE2iP4Pz1iYlMRApXxFTO9WF+XPYbTjo
 WCT3a+Lm2aZgzEMpd7k/Chk5EytnwzOCNk8x7b3gjt2+TuqQQg/FC0I7zIs6d/WFq7U/
 nzIPU7j5+HKa1docwBQ+pObVq5M1hhfwFwHcRelm6nIF1p5D3Gp03TrzKpwUY7t/k2BK
 8qxA==
X-Gm-Message-State: AOJu0YzYUgKKmH3VUCuCgGNW5x1kMLO24xBMxUUuoQwQzRqjo+eMHZki
 hr6eyeb3oV/RmS9RpIUNDskvQcwR3mJ3/NsVrf9FYH4Z3VnkIjebsDU5VNTH0L8=
X-Google-Smtp-Source: AGHT+IGNqyg5pdejspXKBggqd2RvQRJTE4x6tHjisJvKdNG8KH+pUiftg7ccR+Rf3hDmeAa8Wu2wqw==
X-Received: by 2002:a05:6a00:1904:b0:71e:1722:d019 with SMTP id
 d2e1a72fcca58-71e1722d508mr3560925b3a.22.1728408765209; 
 Tue, 08 Oct 2024 10:32:45 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d67beasm6573709b3a.179.2024.10.08.10.32.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 10:32:44 -0700 (PDT)
Message-ID: <5c33b223-10cc-4ad6-a3e8-15082266b31d@linaro.org>
Date: Tue, 8 Oct 2024 10:32:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/21] target/arm: Pass MemOp to get_phys_addr
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
References: <20241005200600.493604-1-richard.henderson@linaro.org>
 <20241005200600.493604-14-richard.henderson@linaro.org>
 <CAFEAcA_jXTuB6c8oVcXmi66zcXn5-PYM7W9z1wf7-fzXg7_Oiw@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_jXTuB6c8oVcXmi66zcXn5-PYM7W9z1wf7-fzXg7_Oiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/8/24 07:45, Peter Maydell wrote:
> On Sat, 5 Oct 2024 at 21:06, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Zero is the safe do-nothing value for callers to use.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/internals.h      | 3 ++-
>>   target/arm/ptw.c            | 2 +-
>>   target/arm/tcg/m_helper.c   | 8 ++++----
>>   target/arm/tcg/tlb_helper.c | 2 +-
>>   4 files changed, 8 insertions(+), 7 deletions(-)
> 
>> diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
>> index 23d7f73035..f7354f3c6e 100644
>> --- a/target/arm/tcg/m_helper.c
>> +++ b/target/arm/tcg/m_helper.c
>> @@ -222,7 +222,7 @@ static bool v7m_stack_write(ARMCPU *cpu, uint32_t addr, uint32_t value,
>>       int exc;
>>       bool exc_secure;
>>
>> -    if (get_phys_addr(env, addr, MMU_DATA_STORE, mmu_idx, &res, &fi)) {
>> +    if (get_phys_addr(env, addr, MMU_DATA_STORE, 0, mmu_idx, &res, &fi)) {
>>           /* MPU/SAU lookup failed */
>>           if (fi.type == ARMFault_QEMU_SFault) {
>>               if (mode == STACK_LAZYFP) {
>> @@ -311,7 +311,7 @@ static bool v7m_stack_read(ARMCPU *cpu, uint32_t *dest, uint32_t addr,
>>       bool exc_secure;
>>       uint32_t value;
>>
>> -    if (get_phys_addr(env, addr, MMU_DATA_LOAD, mmu_idx, &res, &fi)) {
>> +    if (get_phys_addr(env, addr, MMU_DATA_LOAD, 0, mmu_idx, &res, &fi)) {
>>           /* MPU/SAU lookup failed */
>>           if (fi.type == ARMFault_QEMU_SFault) {
>>               qemu_log_mask(CPU_LOG_INT,
> 
> We do actually know what kind of memory operation we're doing here:
> it's a 4-byte access. (It should never be unaligned because an M-profile
> SP can't ever be un-4-aligned, though I forget whether our implementation
> really enforces that.)
> 
>> @@ -2009,7 +2009,7 @@ static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUIdx mmu_idx, bool secure,
>>                         "...really SecureFault with SFSR.INVEP\n");
>>           return false;
>>       }
>> -    if (get_phys_addr(env, addr, MMU_INST_FETCH, mmu_idx, &res, &fi)) {
>> +    if (get_phys_addr(env, addr, MMU_INST_FETCH, 0, mmu_idx, &res, &fi)) {
>>           /* the MPU lookup failed */
>>           env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_IACCVIOL_MASK;
>>           armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_MEM, env->v7m.secure);
> 
> Similarly this is a 16-bit load that in theory should never
> be possible to be unaligned.
> 
>> @@ -2045,7 +2045,7 @@ static bool v7m_read_sg_stack_word(ARMCPU *cpu, ARMMMUIdx mmu_idx,
>>       ARMMMUFaultInfo fi = {};
>>       uint32_t value;
>>
>> -    if (get_phys_addr(env, addr, MMU_DATA_LOAD, mmu_idx, &res, &fi)) {
>> +    if (get_phys_addr(env, addr, MMU_DATA_LOAD, 0, mmu_idx, &res, &fi)) {
>>           /* MPU/SAU lookup failed */
>>           if (fi.type == ARMFault_QEMU_SFault) {
>>               qemu_log_mask(CPU_LOG_INT,
> 
> and this is another 4-byte load via sp.
> 
>> diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
>> index 885bf4ec14..1d8b7bcaa2 100644
>> --- a/target/arm/tcg/tlb_helper.c
>> +++ b/target/arm/tcg/tlb_helper.c
>> @@ -344,7 +344,7 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>>        * return false.  Otherwise populate fsr with ARM DFSR/IFSR fault
>>        * register format, and signal the fault.
>>        */
>> -    ret = get_phys_addr(&cpu->env, address, access_type,
>> +    ret = get_phys_addr(&cpu->env, address, access_type, 0,
>>                           core_to_arm_mmu_idx(&cpu->env, mmu_idx),
>>                           &res, fi);
>>       if (likely(!ret)) {

The question is: if it should be impossible for them to be misaligned, should we pass an 
argument that checks alignment and then (!) potentially raise a guest exception.

I suspect the answer is no.

If it should be impossible, no alignment fault is ever visible to the guest in this 
context, then we should at most assert(), otherwise do nothing.

We *can* pass, e.g. MO_32 or MO_16 for documentation purposes, if you like.  Without 
additional adornment, this does not imply alignment enforcement (i.e. MO_ALIGN).  But this 
would be functionally indistinguishable from 0 (which I imperfectly documented with "or 0" 
in the function block comments).


r~

