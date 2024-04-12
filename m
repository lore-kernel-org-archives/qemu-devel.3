Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8895C001CC
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 02:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv6TI-0005Sw-Js; Thu, 11 Apr 2024 22:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv6TH-0005Sl-7P
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 22:16:55 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv6TC-0005gV-6x
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 22:16:54 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5d8b887bb0cso335678a12.2
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 19:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712888208; x=1713493008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k+c5wcg8srutPXwXw7tu22QSXegz/RsjheAsnta+l/g=;
 b=qix99p/t9OV5ifYfJ2d9FS2KDXpu7PMAu50HuZlGkNFd3esaR7qWZdujnepUz4NC86
 UUSFUMTOusDbUf8Pg6LQdmili9ZXZAuTnx2u2r+vU+k8TM848FabNDlr5LMWessAI+Lu
 tD8CTDEDEiX5auHU1epcTRKJZRe53yY8ibtPP0VPVkB6piKHQMnvr7TlaRe/V+tSuvRC
 4fKKlbB+pVgW/5zbrYcHtEkKJ+gaMZC6DbeFiuC8JPpYVfINxFXJHyokIQ93Ww8FhlPC
 iqfO551Q0H+dduXt+ib25h/+8+hkD0kM7mo7k2AcjZ/yUhp0mTLv3k/LrNp+S1VDELIx
 R1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712888208; x=1713493008;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k+c5wcg8srutPXwXw7tu22QSXegz/RsjheAsnta+l/g=;
 b=IhfwMIASoWUHsxZX74qLCEw6aQ3T9zyDeFnO08iKdN4uPJC6iBU4hfGlzaDd88KnX3
 79ggC7aj2PcVcuIkKKwbkZ4zPaWcmX0zl+sJllzE55oP5jDlYKarwBSbUMVJCMk0VXJ8
 iafO1NJRZte0KcJKuw1+vSmr0ChEtfkHjoXNXEbMeO2iLEWM+fDjsV8SlP5xAruWLj5x
 p6dh/zB89/3pjwzZho9RPaztbBkJ4KJ7/k8Z62E/OYD8GcW24lRcz+7dA8IaGEwKHjXX
 KGpo2WYHgjVUV99QJnHfVvLrWhr8BYS+WioUk7SilLt9ucxRXAuGhbyosxMZUZMmSEkV
 3gZw==
X-Gm-Message-State: AOJu0YyEVNXeDsY/K2Sp0JQFXWKTOjw4hXIptJCeNGX7TCVwT9RwQ9Ml
 0rYOiKiiSpy5pEVfseuLLyokKq2bNJD2MtCSpAyp/79mOWTLIJAJ2MxO9w07TTM=
X-Google-Smtp-Source: AGHT+IEd/Bw4c9SlNAHvnZBFeaNh6w4a+6QfybrYCOkoBDTcYnynjBrgR9c3H9Bj7yqI9FanTw1qWg==
X-Received: by 2002:a17:902:db11:b0:1e2:9205:5254 with SMTP id
 m17-20020a170902db1100b001e292055254mr1490689plx.7.1712888207875; 
 Thu, 11 Apr 2024 19:16:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a170902e74b00b001e28f7c4233sm1846812plf.236.2024.04.11.19.16.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 19:16:47 -0700 (PDT)
Message-ID: <48ec5cfe-e584-4e84-85d8-856bfd46345a@linaro.org>
Date: Thu, 11 Apr 2024 19:16:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: resolve ASI_USERTXT correctly
To: M Bazz <bazz@bazz1.com>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240411212936.945-1-bazz@bazz1.com>
 <dfa87b87-8685-46ea-ae5d-3735124fc76a@linaro.org>
 <CAMFqb-anRmzo1HP8Gn2y0eD98+ZsG_a54c_fLMaMc=0AGAz7DA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAMFqb-anRmzo1HP8Gn2y0eD98+ZsG_a54c_fLMaMc=0AGAz7DA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 4/11/24 18:15, M Bazz wrote:
> On Thu, Apr 11, 2024, 5:55 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 4/11/24 14:29, M Bazz wrote:
>>> fixes a longstanding bug which causes a "Nonparity Synchronous Error"
>>> kernel panic while using a debugger on Solaris / SunOS systems. The panic
>>> would occur on the first attempt to single-step the process.
>>>
>>> The problem stems from an lda instruction on ASI_USERTXT (8). This asi
>>> was not being resolved correctly by resolve_asi().
>>>
>>> Further details can be found in #2281
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2281
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2059
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1609
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1166
>>>
>>> Signed-off-by: M Bazz <bazz@bazz1.com>
>>> ---
>>>    target/sparc/translate.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
>>> index 319934d9bd..1596005e22 100644
>>> --- a/target/sparc/translate.c
>>> +++ b/target/sparc/translate.c
>>> @@ -3,6 +3,7 @@
>>>
>>>       Copyright (C) 2003 Thomas M. Ogrisegg <tom@fnord.at>
>>>       Copyright (C) 2003-2005 Fabrice Bellard
>>> +   Copyright (C) 2024 M Bazz <bazz@bazz1.com>
>>>
>>>       This library is free software; you can redistribute it and/or
>>>       modify it under the terms of the GNU Lesser General Public
>>> @@ -1159,6 +1160,7 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
>>>                   || (asi == ASI_USERDATA
>>>                       && (dc->def->features & CPU_FEATURE_CASA))) {
>>>            switch (asi) {
>>> +        case ASI_USERTXT:    /* User text access */
>>>            case ASI_USERDATA:   /* User data access */
>>>                mem_idx = MMU_USER_IDX;
>>>                type = GET_ASI_DIRECT;
>>
>> I don't believe this is correct, because it operates against the page's "read" permissions
>> instead of "execute" permissions.
>>
>>
>> r~
> 
> Hi Richard,
> 
> Thanks for your guidance. It set me in the right direction. Now I
> think I've got the right spot.
> 
> function `helper_ld_asi` has a block to help load ASI_KERNELTXT, but the
> ASI_USERTXT case defaults to sparc_raise_mmu_fault(); I believe this
> is the true culprit
> source reference:
> https://gitlab.com/qemu-project/qemu/-/blob/master/target/sparc/ldst_helper.c?ref_type=heads#L687
> 
> The code for the ASI_KERNELTXT seems generic enough to also use for
> ASI_USERTXT verbatim.
> See v2 patch below. I've done a `make test` -- all passing (3 skips).
> OS boots, and the
> debuggers are working without issue. What do you think?
> 
> Once we arrive at the right solution, I'll finalize the patch.
> -bazz
> 
> 
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index e581bb42ac..4f87e44a93 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -684,6 +684,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env,
> target_ulong addr,
>       case ASI_M_DIAGS:   /* Turbosparc DTLB Diagnostic */
>       case ASI_M_IODIAG:  /* Turbosparc IOTLB Diagnostic */
>           break;
> +    case ASI_USERTXT: /* User code access */
>       case ASI_KERNELTXT: /* Supervisor code access */
>           oi = make_memop_idx(memop, cpu_mmu_index(env_cpu(env), true));

No, this also does not work, because it uses the wrong permissions (kernel instead of 
user).  I have just sent a patch to fix both problems.


r~

