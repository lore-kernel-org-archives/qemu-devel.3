Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D939C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 16:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvJLW-0006Lf-2O; Fri, 12 Apr 2024 12:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rvJKz-00066g-Sb
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 12:01:21 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rvJKt-0002yq-B0
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 12:01:12 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5aa20adda1dso705522eaf.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 09:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1712937658; x=1713542458; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xIMcktWFO91El3u/U/XloLit4e/clcy7kEqGAJx1vmo=;
 b=XdaFogKAC/sIRPeA9KeyWjywM6VC0V48qwVPtFNU8ycqT1P7KdjolPSIs4pRqu2Gyy
 +yqk/tocv2XY2rgIUJ7BaRvNM5jZDip3yGMjhDm5Puhg+snukiV4zSoNs1nK0zZtZ2zS
 vn9UTIXERaBuvRDzDPXjSViFxHlC3fynm0L+1Wd6ZPhbAeMgyrsrUPhemujuF1+CF/Ob
 rrczwTV8d11S2pfItKcMsVzWYE37iP1tJOQxIZegjTwKKv0BUtAwi4btj18Wd7xPWHXq
 AGxDmOTAYBYUzjgqJI9Qrp+FZI8uYiYwdkh7ZpJgKDik/mvHiGORa0ZVQa1qtNcwueyd
 A0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712937658; x=1713542458;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xIMcktWFO91El3u/U/XloLit4e/clcy7kEqGAJx1vmo=;
 b=BdFkr96SJGiBxxydlB9pVwdDNf4cHIoQCbaQAYwdTCN/+mX1617ERYveCES6s9bSSD
 mtb5/tM71V9thKnRc+27S/2sIAsjxVhOqgVDORCX8fZpq2ndnuQE7G7Bnfy8YI57+WuL
 9MkYa6cbO/rt9zK167KyFs6GFVFBWwEWAApse5GhYbC/O99PYQbrXPqi3cZj0bB9K0BR
 OvvW7uXjFt4V2NcRv0BEQjlKMR1jhPAtaHp8aZfmDiQ3QqnWDtWYb5Oqu8lr33iV3UqG
 yrIuwfV7bbcTZpaufIzH/P9kt+LrnV1+T70oiP5//FTRm01FGziaPgDfxfrFMeN6mIzw
 GdzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUABxuiOzBLi6cHMhDO+zro86Vay97Cm4iwuHsyzBSLKxZrPdClLzQ8Ikop5wv3UAwBYdv03u3R4lbwDk5G7giOhrKvNGc=
X-Gm-Message-State: AOJu0YyvlaIECwatktdKMPQWcHdMUqSt+is9e4f5YhcoL156sPmu3wts
 f00c19o8dGStnrWlQmQpGTqNhJ2//Yp0hgZzYblbXRgf6w/T5LUoZZlNvNwU2Pk=
X-Google-Smtp-Source: AGHT+IHXaMIlRoBs5IRmG30cBM8SGuhFmcNNlsUo0vm+AtNtSEkoR2X1F/JTH0mBQBJlXoKTzqfI6A==
X-Received: by 2002:a05:6359:7981:b0:17e:f422:5e48 with SMTP id
 xe1-20020a056359798100b0017ef4225e48mr2863271rwb.13.1712937657830; 
 Fri, 12 Apr 2024 09:00:57 -0700 (PDT)
Received: from [192.168.68.110] ([177.45.186.202])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a656aab000000b005dcc8a3b26esm2468192pgu.16.2024.04.12.09.00.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 09:00:57 -0700 (PDT)
Message-ID: <6947ea59-ccbd-43b8-b8a0-bc543b9992f9@ventanamicro.com>
Date: Fri, 12 Apr 2024 13:00:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] target/riscv: prioritize pmp errors in
 raise_mmu_exception()
Content-Language: en-US
To: Aleksei Filippov <alexei.filippov@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, Joseph Chan <jchan@ventanamicro.com>
References: <20240409175241.1297072-1-dbarboza@ventanamicro.com>
 <a8680fb3-8547-4b68-98d1-fd2d2d278375@syntacore.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <a8680fb3-8547-4b68-98d1-fd2d2d278375@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc31.google.com
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



On 4/12/24 11:15, Aleksei Filippov wrote:
> 
> 
> On 09.04.2024 20:52, Daniel Henrique Barboza wrote:
>> raise_mmu_exception(), as is today, is prioritizing guest page faults by
>> checking first if virt_enabled && !first_stage, and then considering the
>> regular inst/load/store faults.
>>
>> There's no mention in the spec about guest page fault being a higher
>> priority that PMP faults. In fact, privileged spec section 3.7.1 says:
>>
>> "Attempting to fetch an instruction from a PMP region that does not have
>> execute permissions raises an instruction access-fault exception.
>> Attempting to execute a load or load-reserved instruction which accesses
>> a physical address within a PMP region without read permissions raises a
>> load access-fault exception. Attempting to execute a store,
>> store-conditional, or AMO instruction which accesses a physical address
>> within a PMP region without write permissions raises a store
>> access-fault exception."
>>
>> So, in fact, we're doing it wrong - PMP faults should always be thrown,
>> regardless of also being a first or second stage fault.
>>
>> The way riscv_cpu_tlb_fill() and get_physical_address() work is
>> adequate: a TRANSLATE_PMP_FAIL error is immediately reported and
>> reflected in the 'pmp_violation' flag. What we need is to change
>> raise_mmu_exception() to prioritize it.
>>
>> Reported-by: Joseph Chan <jchan@ventanamicro.com>
>> Fixes: 82d53adfbb ("target/riscv/cpu_helper.c: Invalid exception on MMU translation stage")
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu_helper.c | 22 ++++++++++++----------
>>   1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index fc090d729a..e3a7797d00 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -1176,28 +1176,30 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
>>
>>       switch (access_type) {
>>       case MMU_INST_FETCH:
>> -        if (env->virt_enabled && !first_stage) {
>> +        if (pmp_violation) {
>> +            cs->exception_index = RISCV_EXCP_INST_ACCESS_FAULT;
>> +        } else if (env->virt_enabled && !first_stage) {
>>               cs->exception_index = RISCV_EXCP_INST_GUEST_PAGE_FAULT;
>>           } else {
>> -            cs->exception_index = pmp_violation ?
>> -                RISCV_EXCP_INST_ACCESS_FAULT : RISCV_EXCP_INST_PAGE_FAULT;
>> +            cs->exception_index = RISCV_EXCP_INST_PAGE_FAULT;
>>           }
>>           break;
>>       case MMU_DATA_LOAD:
>> -        if (two_stage && !first_stage) {
>> +        if (pmp_violation) {
>> +            cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
>> +        } else if (two_stage && !first_stage) {
>>               cs->exception_index = RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
>>           } else {
>> -            cs->exception_index = pmp_violation ?
>> -                RISCV_EXCP_LOAD_ACCESS_FAULT : RISCV_EXCP_LOAD_PAGE_FAULT;
>> +            cs->exception_index = RISCV_EXCP_LOAD_PAGE_FAULT;
>>           }
>>           break;
>>       case MMU_DATA_STORE:
>> -        if (two_stage && !first_stage) {
>> +        if (pmp_violation) {
>> +            cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
>> +        } else if (two_stage && !first_stage) {
>>               cs->exception_index = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
>>           } else {
>> -            cs->exception_index = pmp_violation ?
>> -                RISCV_EXCP_STORE_AMO_ACCESS_FAULT :
>> -                RISCV_EXCP_STORE_PAGE_FAULT;
>> +            cs->exception_index = RISCV_EXCP_STORE_PAGE_FAULT;
>>           }
>>           break;
>>       default:
> 
> 
> Just tested your patch and found out that we still need to fix `if else` in
> riscv_cpu_tlb_fill() after pmp check in 2 stage translation part, as I suggested
> before, cz the problem with mtval2 will happened in case of successes 2 stage
> translation but failed pmp check. In this case we gonna set
> mtval2(env->guest_phys_fault_addr in context of riscv_cpu_tlb_fill()) as this
> was a guest-page-fault, but it didn't and mtval2 should be zero, according to
> RISCV privileged spec sect. 9.4.4: When a guest page-fault is taken into M-mode,
> mtval2 is written with either zero or guest physical address that faulted,
> shifted by 2 bits. *For other traps, mtval2 is set to zero...*

Thanks for giving it a go. You're right, this patch alone is not enough and we'll
need your patch too.

But note that, with what you've said in mind, your patch will also end up setting
mtval2 and env->guest_phys_fault_addr in case a PMP fault occurs during the
get_physical_address() right at the start of second stage:

         if (ret == TRANSLATE_SUCCESS) {
             /* Second stage lookup */
             im_address = pa;

             ret = get_physical_address(env, &pa, &prot2, im_address, NULL,
                                        access_type, MMUIdx_U, false, true,
                                        false);


I think your patch needs to also prevent env->guest_phys_fault_addr to be set when
ret == TRANSLATE_PMP_FAIL.

With these changes in your patch, and this patch, we're free to set "first_stage_error = false;"
at the start of second stage lookup, keeping consistency, because raise_mmu_exception is now
able to deal with it. I can amend this change in this patch. This patch would prioritize
PMP errors, your patch will fix the problem with mtval2.

Let me know what do you think. If you agree I can re-send both patches together.


Thanks,


Daniel





