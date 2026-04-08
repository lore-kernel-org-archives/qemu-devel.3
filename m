Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D022910F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXwt-0004OG-TU; Wed, 08 Apr 2026 14:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAXws-0003kp-Aw
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:48:22 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAVHM-000816-8A
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 11:57:22 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43cfb723793so4209352f8f.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 08:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775663838; x=1776268638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DjQdBS/LB6uNmJg6V2kX2XLI/RscIjfmgjC29IlKSvA=;
 b=MF2vT+D0vLVYv5i7ilOWJKjvUQyd/JxHeLBucGneMiwWizgC+x0oF3QJ6HxG/GKg+m
 +W1sSFaJl23OaKB/Xh9TrYR13eWzemwqIBuPYBx58ATNEaAEaRlKxffOyTsz3YhMhF9P
 FMFHIMuNUnxCHV0xjDiD9zS3nqG9Y+1YX/3/Qkair8DUobuIkt4Iw3ywhXycO0zry2PC
 MNUsZSAnQvhaVhyC+Ei9TbDLpVsUlahsDexjI+9Z8a+8Yhu4l+5XDI5XbxSTllc/hyDd
 ThktGqJ+gUnQ7GtETFu6EY/3qevp8pxMh2hf4Il7MVlWUs0YiUrXYRgXHWGjQV7FqQKR
 AAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775663838; x=1776268638;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DjQdBS/LB6uNmJg6V2kX2XLI/RscIjfmgjC29IlKSvA=;
 b=aLAmKN50vtMb2QwxIdNs1gkcpESxUp4QPz7QhSUQQhf/H9a8ZlOgIkY4w+ivSI6sM1
 PrgDaNtCzDfteoKqhFTzf52dp5jCDu2dkx2Oc/mxIdlkysr3hZS20hhZpLCnzDO3A6fC
 SLocZqJZm7bwewjHtVfF1eXsAAqaqwpDSppzBYnAkCi88Q/HC+WBGUb1GcLmdnwoZtuz
 hCvajLkV1xMb5Q6gjnWVEwFfM3zsHYvUcufHJGTUtpmVbFoaPK2pxdr5Rx3G3bZ7hZpA
 vC5Ds6TyrdLxh5X4aSPkuFPT90m+ODJCpZvO1B5niowI2H5fBPG+OJiL06gUO3hKtxsO
 mtWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqpQp+IFAhjfq4beIN1Z5ATDKGDspQWRmSiTivIjdI10ZgJPN/ykoISuTQucS1cXTefamllHZ7VCiw@nongnu.org
X-Gm-Message-State: AOJu0YypZKbjIEdy/aRYYpgARMEBCyrcN2iJAxvbnrkPHMVWeaC+Vu+i
 83lNgzuxjzAAa2qjE5TQjqDqpyg9tJWP0d/hJ+HNW/i2ILZZmCnpABdpJjo2mjgABzY=
X-Gm-Gg: AeBDietxnXwKbvOYdniFG8UA4+Q8hgJAugdqSXp+CDdurk5ZLbbbmHv08UvJOVLhytM
 gRGwD3gpHRV0nJlqcPvZaQfIX5LEOj2rebTI/uYnoVkFNOxjZk7JOhoIfa0R6pJefoipnMV68px
 P8+xczCbOuYGpYbnQbFKNFhLsPXnyxJED9RPE43bKU7LSRG+U6xn7tWRn2dzFYQeoqjYEHvkJ07
 /2L70TyVcwqnqFcA/5TxT/xsIC85y4P/JZh/DUDPF2krinqlOQ0bxS6ClYu4zdjjIXLgUkjNvu3
 fiACaHY5b9XBPFbziWbp8BwOrcrux7BUVNPnHhp1KhA3OUOlJojlt75q/3cS+ZBPylm71ZvJnPW
 FkfbLGiw6ileL/hB/7wAi9xZAUrj1vYaQIeH01IWMdmGabgBkoQSYaoxrhrEx0JDlqTycX2/M0V
 1cv3i4nBC7QT0rxx5YZz1MvJLrYxFYAS7BdXp5hKdHa6xZL32mZ0dBGa52pgM7sDipkA==
X-Received: by 2002:a05:6000:2902:b0:43c:fad6:9ba9 with SMTP id
 ffacd0b85a97d-43d29305f2amr32121991f8f.45.1775663837051; 
 Wed, 08 Apr 2026 08:57:17 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f843dsm57556962f8f.37.2026.04.08.08.57.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 08:57:16 -0700 (PDT)
Message-ID: <f2abb1dd-55c7-47ca-8000-21fc9f5d987b@linaro.org>
Date: Wed, 8 Apr 2026 17:57:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/29] target/arm/tcg/translate.c: remove MO_TE usage
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-27-pierrick.bouvier@linaro.org>
 <5fc9d07c-cd22-45c0-bb5e-8bf93d20f112@linaro.org>
 <f40a06f2-d3b7-4130-a7ea-cd90337c6bb2@linaro.org>
In-Reply-To: <f40a06f2-d3b7-4130-a7ea-cd90337c6bb2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 8/4/26 10:20, Philippe Mathieu-Daudé wrote:
> On 9/1/26 23:50, Richard Henderson wrote:
>> On 1/9/26 16:31, Pierrick Bouvier wrote:
>>> dc->be_data is already set just above in the same function:
>>> ```
>>>      dc->be_data = EX_TBFLAG_ANY(tb_flags, BE_DATA) ? MO_BE : MO_LE;
>>> ```
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>   target/arm/tcg/translate.c | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
>>> index ec4358ba402..55b89817cb1 100644
>>> --- a/target/arm/tcg/translate.c
>>> +++ b/target/arm/tcg/translate.c
>>> @@ -6327,7 +6327,6 @@ static void 
>>> arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>>>       if (arm_feature(env, ARM_FEATURE_M)) {
>>>           dc->vfp_enabled = 1;
>>> -        dc->be_data = MO_TE;
>>>           dc->v7m_handler_mode = EX_TBFLAG_M32(tb_flags, HANDLER);
>>>           dc->v8m_secure = EX_TBFLAG_M32(tb_flags, SECURE);
>>>           dc->v8m_stackcheck = EX_TBFLAG_M32(tb_flags, STACKCHECK);
>>
>> Whoops, yes indeed.
>>
>> Cc: qemu-stable@nongnu.org
> 
> As per my v10 comments, why Cc stable? This is just removing pointless 
> code, right?
> 
>> Fixes: a729a46b05a ("target/arm: Add wrapper macros for accessing 
>> tbflags")
> 
> This commit doesn't seem to be related.
> 
> Do you mean commit 79cabf1f473 ("target/arm: Recover 4 bits from
> TBFLAGs")?
> 
>      We had completely run out of TBFLAG bits.
>      Split A- and M-profile bits into two overlapping buckets.
>      This results in 4 free bits.
> 
>      We used to initialize all of the a32 and m32 fields in DisasContext
>      by assignment, in arm_tr_init_disas_context.  Now we only initialize
>      either the a32 or m32 by assignment, because the bits overlap in
>      tbflags.  So zero the entire structure in gen_intermediate_code.
> 
> Since BE_DATA is in the TBFLAG_ANY set, I don't get why it
> is set to MO_TE for M-profile.

This is a question to Richard btw, not Pierrick ;)

> 
> At any rate this patch description deserves a better explanation IMHO.
> 
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>>
>> r~
> 


