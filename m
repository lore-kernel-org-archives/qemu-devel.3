Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857C8C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 15:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryvUl-0005eJ-A2; Mon, 22 Apr 2024 11:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryvUg-0005dN-U4
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:22:12 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryvUc-0001em-SL
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:22:10 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e50a04c317so25313875ad.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 08:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713799323; x=1714404123; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C0SU+TbBMhbgYmkmJ8rOK9q462Q0MK4FTq+GFgaFPs4=;
 b=Qhy738+4qV/sPurC4UbozBPuIK9xvxcigwp904dqhyqkLhzlphhyF5sEDL3a6I4Eao
 MssmtEEyDSp80z6zxHkzruvlm/JBLQ7l1fpBr1WU1cuoaRQIL1W1QkWxeDFpJZ0mye5E
 C3LLHtNJVTj8vHOtdU5fSCiq14zvh4ucyJIxuzs3hVzisBdy5lApPEa6JooBXfuYWxnl
 lkLdfItdRzdSZA26uWfIeWYIeC4W8ks5vRoBLte37c+3S4KVIAPHedUCl6smaCsfW40h
 ZMxQ05g0nuaKHkivhCpXyRbrRl6rAvv59D2DqoYMAQFN/UtQgWLKChD3l8kdRWhsoVcx
 wuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713799323; x=1714404123;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C0SU+TbBMhbgYmkmJ8rOK9q462Q0MK4FTq+GFgaFPs4=;
 b=oIi1T2RO+xqH9OZ0XQ/u04sbG5aKT6vnTgX1XDNiXQ/TGQa3SgBUmnjnaYe/DCDuFR
 4Z5Dmk1qC/mYXEgNeHcFC5KfIjGGq0Tsv/Lh1agSOXrQKZ5WUDFX4MeM0dE3TboscoNn
 GBKdt9FgRlxoUfK3pMto9KCY8v+9qGpkW+SofYswvf4m+n3GEwMaj7Iks4gU5BbMQWJY
 bkknLSgnrRnhF6lzwxzYSG7ztjDRLRrdKjYVpD7fEmIT91eXWC3GSIUfarOi1ak0fDjm
 g/atchaMqqg4+wOXn4TeB3TU67gVfBmnMlJ7d41znezCGUZ+X7O0+PnizQL/E1YbfLj8
 iQGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnqWKUVWYY/VlQadk4A6yCMXTsJxCnt/XEnUjb80/574/Y/3ONTx/u5LEj6OLvXqnbRjxCPRFDN1s0bsHc+V/61gjTyTI=
X-Gm-Message-State: AOJu0YwSRAKJMRv1KlYmDozz5uhTcRx6DmbnnTya9zeXtU81uGRlKSYf
 YO4YlNcFjhQPFtBfhX0y0injAbkfaKcUWSHDN3bE96SFlJULK/eS1xgYzbrDlXI=
X-Google-Smtp-Source: AGHT+IFehresvE5JhIQdkHefgnN0/+KbGYtb2w46k6TByvr4Ul0cjNUVwJ/a8IEQ1i5pYNm1Mgg1mw==
X-Received: by 2002:a17:903:110d:b0:1e7:d482:9e32 with SMTP id
 n13-20020a170903110d00b001e7d4829e32mr11452143plh.7.1713799323456; 
 Mon, 22 Apr 2024 08:22:03 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a170902e54800b001e2bb03893dsm8229306plf.198.2024.04.22.08.22.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 08:22:02 -0700 (PDT)
Message-ID: <753b3a55-9589-4dcb-b656-8b3025e847df@linaro.org>
Date: Mon, 22 Apr 2024 08:21:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, qemu-devel@nongnu.org
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <f397f267-06d9-46c1-8acc-1c9ebf9c3773@linaro.org>
 <CAFEAcA8i_wU+RSRk+D1L8YKy72zHz4YFV20r2Z7m+3ARfzb51w@mail.gmail.com>
 <CAFEAcA_kHDGWVic=xRm4xOsi-cQC-fF5Z2FWRCrwe_E35KBmNw@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_kHDGWVic=xRm4xOsi-cQC-fF5Z2FWRCrwe_E35KBmNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 4/22/24 04:26, Peter Maydell wrote:
> On Mon, 22 Apr 2024 at 11:46, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Sun, 21 Apr 2024 at 06:40, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>> --- a/target/arm/cpu.c
>>>> +++ b/target/arm/cpu.c
>>>> @@ -1314,8 +1314,18 @@ static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>>>>        }
>>>>    }
>>>>
>>>> -uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz)
>>>> +uint64_t arm_build_mp_affinity(ARMCPU *cpu, int idx, uint8_t clustersz)
>>>>    {
>>>> +    if (cpu->has_smt) {
>>>> +        /*
>>>> +         * Right now, the ARM CPUs with SMT supported by QEMU only have
>>>> +         * one thread per core. So Aff0 is always 0.
>>>> +         */
>>>
>>> Well, this isn't true.
>>>
>>>       -smp [[cpus=]n][,maxcpus=maxcpus][,drawers=drawers][,books=books][,sockets=sockets]
>>>                      [,dies=dies][,clusters=clusters][,cores=cores][,threads=threads]
>>>
>>> I would expect all of Aff[0-3] to be settable with the proper topology parameters.
>>
>> As I understand it the MPIDR value is more or less independent
>> of the topology information as presented to the guest OS.
>> The options to the -smp command set the firmware topology
>> information, which doesn't/shouldn't affect the reported
>> MPIDR values, and in particular shouldn't change whether
>> the CPU selected has the MT bit set or not.
>>
>> For Arm's CPUs they fall into two categories:
>>   * older ones don't set MT in their MPIDR, and the Aff0
>>     field is effectively the CPU number
>>   * newer ones do set MT in their MPIDR, but don't have
>>     SMT, so their Aff0 is always 0 and their Aff1
>>     is the CPU number
>>
>> Of all the CPUs we model, none of them are the
>> architecturally-permitted "MT is set, CPU implements
>> actual SMT, Aff0 indicates the thread in the CPU" type.
> 
> Looking at the TRM, Neoverse-E1 is "MT is set, actual SMT,
> Aff0 is the thread" (Aff0 can be 0 or 1). We just don't
> model that CPU type yet. But we should probably make
> sure we don't block ourselves into a corner where that
> would be awkward -- I'll have a think about this and
> look at what x86 does with the topology info.

I'm suggesting that we set things up per -smp, and if the user chooses a -cpu value for 
which that topology doesn't make sense, we do it anyway and let them keep both pieces.


r~

