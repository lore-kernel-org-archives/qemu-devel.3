Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5A8C52D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 10:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdocH-00065H-UD; Tue, 13 Aug 2024 06:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdoc8-00064b-8L
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 06:18:53 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdoc5-0005mj-T9
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 06:18:52 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ef248ab2aeso82727911fa.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 03:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723544328; x=1724149128; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b9YcO4AI7o/2a0qs5pZn+ZudhM2lTnDG405tnwjcgeQ=;
 b=ObS0/mBCCAEIysZs6YGJUFOytwrU3wlJMZCXOunnwvnsHfvRzGTU2SkGInYK84yNmd
 MhzPw3GhlgWA9n4DyGYtAsyvEX3xB0L7ykCo9gGcg02aRwViaSnMFWL07XZzec2maMeN
 hA7pKe19AkbyNQ7B4R+H2RIFnXlBr1cm2bD0oBKWNF7OQ7E/0G2Hd6vU3KkQGDhsMsga
 UIvdymQxu5EAVbynmtcMoEJJ+styJ3hgjo37hP1xv6EML/SGpcA0/1EY9tUfq5xqLSRG
 Mof+AQQWrSOZYC6nDPwOBJt0ELriJOazrlXQMRdTb93cyUw1PUhLFA81uE12Sqi8B2eJ
 tT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723544328; x=1724149128;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b9YcO4AI7o/2a0qs5pZn+ZudhM2lTnDG405tnwjcgeQ=;
 b=REO6wLzeFWZN9JXu4+k22bev2iw2AAkcr/b39o5NtU7ZJXqqe2OxLK/2AQOS7WjODM
 EJeaAykCCRlTN28vHIndFTDM9NAAV+JBFbS6oQIeJDo5niu6c41S6adKSAc7fDtWT0zh
 aNJalG69Wdl1rxbdRiuTwSFhmUH4+JuplS5XZFF0R+ZQh71fNDZn1x+wMIMbIKZxJ1FX
 uWoNhOzPchLzPuq14yLFe1rrDCmQIijwHzy+eH819s4COaY8r2/5y4sVXGhU+Wc0fOxY
 /JMAbv+UJMJZR6aKtbB1XWtt72cz3Iu0EudGJyp0biJqWnjb4Betysx/Ghv2t4rlFAfI
 Mbhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOCNU7vJsXxV1mr7xncXJXxoSXLfDN3XeMFbjwU9fpS+rJK5yYtsSPoH3gQvppY5SA29ac+G+repybopSeCzcBEZ6Yu9M=
X-Gm-Message-State: AOJu0YymDA0GzxbaOMDurpYxqJWVFaY4JIckOUlQ48twAvV635JOAQjn
 vCSkTBX841CtQu5ql+tFfQ8Ob0lObMVH85pkyE3WeH6dxsLIL3d4V3zFNL4s194=
X-Google-Smtp-Source: AGHT+IFXwNgEApVZARyOTMQm4Ss7HJk+/qY/eJ6tRXpiJGFLyVqDlnZ4TibxEO5IDGIlW43e80mMPw==
X-Received: by 2002:a2e:a584:0:b0:2ef:2677:7b74 with SMTP id
 38308e7fff4ca-2f2b727ee71mr26182091fa.41.1723544327524; 
 Tue, 13 Aug 2024 03:18:47 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.129.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f414e041sm56091366b.168.2024.08.13.03.18.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 03:18:46 -0700 (PDT)
Message-ID: <c747ff96-53fc-44be-9ca0-59edcd380fdc@linaro.org>
Date: Tue, 13 Aug 2024 12:18:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1] target/mips: Fix execution mode in
 page_table_walk_refill()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Waldemar Brodkorb <wbx@uclibc-ng.org>
References: <20240811165407.26312-1-philmd@linaro.org>
 <be719b7b-9096-4d15-9947-8e4003de302d@linaro.org>
 <2506e429-b5ca-4ff1-99a0-2df157321c4d@linaro.org>
 <62e4979d-bf44-4555-996c-c51bdf6e2441@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <62e4979d-bf44-4555-996c-c51bdf6e2441@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/8/24 09:02, Richard Henderson wrote:
> On 8/12/24 15:35, Philippe Mathieu-Daudé wrote:
>> On 12/8/24 02:48, Richard Henderson wrote:
>>> On 8/12/24 02:54, Philippe Mathieu-Daudé wrote:
>>>> When refactoring page_table_walk_refill() in commit 4e999bf419
>>>> we replaced the execution mode and forced it to kernel mode.
>>>> Restore the previous behavior to also get supervisor / user modes.
>>>>
>>>> Reported-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>>>> Reported-by: Waldemar Brodkorb <wbx@uclibc-ng.org>
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2470
>>>> Fixes: 4e999bf419 ("target/mips: Pass ptw_mmu_idx down from 
>>>> mips_cpu_tlb_fill")
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>   target/mips/tcg/sysemu/tlb_helper.c | 5 +++--
>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/target/mips/tcg/sysemu/tlb_helper.c 
>>>> b/target/mips/tcg/sysemu/tlb_helper.c
>>>> index 3ba6d369a6..e7ae4f0bef 100644
>>>> --- a/target/mips/tcg/sysemu/tlb_helper.c
>>>> +++ b/target/mips/tcg/sysemu/tlb_helper.c
>>>> @@ -940,8 +940,9 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr 
>>>> address, int size,
>>>>            * Memory reads during hardware page table walking are 
>>>> performed
>>>>            * as if they were kernel-mode load instructions.
>>>>            */
>>>> -        int ptw_mmu_idx = (env->hflags & MIPS_HFLAG_ERL ?
>>>> -                           MMU_ERL_IDX : MMU_KERNEL_IDX);
>>>> +        int ptw_mmu_idx = (env->hflags & MIPS_HFLAG_ERL)
>>>> +                          ? MMU_ERL_IDX
>>>> +                          : (env->hflags & MIPS_HFLAG_KSU);
>>>
>>> This contradicts the comment above.
>>> If this code change is correct, then the comment isn't.
>>
>> OK.
>>
>>> But the comment certainly makes sense -- page tables are never 
>>> accessible to user mode.
>>
>> But we are still dropping the supervisor mode, so OK if I
>> reword as:
>>
>> "Restore the previous behavior to also get supervisor modes."
> 
> The old code
> 
> -        env->hflags &= ~MIPS_HFLAG_KSU;
> 
> drops both supervisor and user bits, so my comment still stands.

Right, I missed that.

The issue is in get_pte(), we have:

   page_table_walk_refill()
   -> get_pte()
      -> cpu_ld[lq]_code()
         -> cpu_mmu_index()

Since we don't mask anymore the modes in hflags, cpu_mmu_index() can
return UM or SM.

I'll respin the fix.

Phil.

