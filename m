Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04DAC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 21:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmKW3-00075O-5n; Mon, 18 Mar 2024 17:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmKW1-000758-N9
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:27:29 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmKW0-0003I5-7f
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:27:29 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e6ade6a66aso4299255b3a.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 14:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710797246; x=1711402046; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DCqeig5zDkXTylYnws8vk0I5LFlEF4tlOOB1r8NANzo=;
 b=QZPQc/eGDoFz6MScOQ/co03U+d1pr0FYE7KcLG09zjFrnjdXLi1/MndYzcMCrWWoXo
 ZS/jt79EkWGEn2zMWGPVCwUoQOzFBIyLuEOEkUa0JdW/NM5QPDkRqqy94np2DOPHpueM
 CwaMxVuVIMkQM99JXOJKNmgzz9OTcJT+7DlXQidIjeqibwOqBAW04L5eKuV4F+zkoM/n
 kJoMO1N6QszEEuCmoC7n8bjGzx1kJfYX1Yg8li2dP0vHpsRzVnDRRxVWHjfJ2576+LAy
 lX0BJ46VmTOmApHstI/O/xakDhoQ42Jx/+L1crAwvt2spIxHt1CR7GqIOOnN8j/E9JwP
 BiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710797246; x=1711402046;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DCqeig5zDkXTylYnws8vk0I5LFlEF4tlOOB1r8NANzo=;
 b=bzzLUdaiR9e3XBRuoIaO9+T9rtmRJz2IwtWrg/ZCJtyKiDxc2Sg13CuJa0idv0X501
 VWYWHLnMJtvrH8EoSqr/uggBi15wFkizG1n5aKn1A+EsdfsyyywTWC/mOxSSOXmand/0
 1SXEEhkYeN6wpCsLr/VdYIJ7E0HyRTJ8kFG2nBFsF5vnjSa/lAEkacjjB62fRRmbg0cG
 qFGWcAetX0dHyndUvA+uyXvIV0s/LLZAHaZn9oKsc+Ocdkln+lzNvd/dgqRHDofGJ7eT
 Am6bO3Jniu/LhTLiNxRxdcX2D9sz0v0NXW5Sl8/4pgBlWmouosVm1DJBHr4h7Fkm4heA
 HnFA==
X-Gm-Message-State: AOJu0Yz/YpgcHZUIFHLQVv7gkI6VQAl/f/qq9grxdyZBmP8H40Each6z
 Hg2Ypmoh2jwNMQIWasXNN2IadofITVUO4Wi2I7JBeKaCCp+IL2MBvWJBd+8gppsXrkqXls5BGjw
 v
X-Google-Smtp-Source: AGHT+IF7VKnmMUKdjaPu/mQchoVKrPB7x6F55zAKMg7xYsFHAhj1oKHFfafTz1GZs+t7eTDOyFoLDQ==
X-Received: by 2002:a05:6a20:d908:b0:1a3:6ee8:b84c with SMTP id
 jd8-20020a056a20d90800b001a36ee8b84cmr1891624pzb.13.1710797246608; 
 Mon, 18 Mar 2024 14:27:26 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 d14-20020a63d70e000000b005dc36761ad1sm7821274pgg.33.2024.03.18.14.27.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 14:27:26 -0700 (PDT)
Message-ID: <1572dd6f-7a39-44dc-9fd3-5d02f331da54@linaro.org>
Date: Mon, 18 Mar 2024 11:27:23 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] target/hppa: copy new_spc to iasq_f on be,n
 instruction
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240317221431.251515-1-svens@stackframe.org>
 <20240317221431.251515-6-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240317221431.251515-6-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 3/17/24 12:14, Sven Schnelle wrote:
> Otherwise the first instruction at the new location gets executed from
> the old space.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   target/hppa/translate.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 58d7ec1ade..a09112e4ae 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -3777,6 +3777,9 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
>           }
>           copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
>           tcg_gen_mov_i64(cpu_iasq_b, new_spc);
> +        if (a->n) {
> +            tcg_gen_mov_i64(cpu_iasq_f, new_spc);
> +        }
>           nullify_set(ctx, a->n);
>       }
>       tcg_gen_lookup_and_goto_ptr();


Without use_nullify_skip(), we're going to execute the next instruction even if we know it 
is nullified (a->n).  This is usually because there's a page crossing or breakpoint, and 
we need to take the exception that might be raised there.

So, we advance the queue:

         copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
         if (ctx->iaoq_b == -1) {
             tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
         }

then put the branch destination at the back of the queue:

         copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
         tcg_gen_mov_i64(cpu_iasq_b, new_spc);

Note that iaoq_b is always -1 on a space change.

So your change does not look correct.
What is the issue that you saw?


r~

