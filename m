Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811D2CD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 06:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruRXy-0003xv-DM; Wed, 10 Apr 2024 02:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruRXv-0003xd-QI
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 02:34:59 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruRXu-0004Jd-1h
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 02:34:59 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-222b6a05bb1so3594309fac.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 23:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712730896; x=1713335696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DjssVysbhcp9rJd99TSABMh/n519hYdFgDAbHKkdo70=;
 b=NfHFWuYvaIr6Welupjad1/W49AdBaOFrV8rtmhI7Tal+2FVNh0+fQDFAq/sRsQJ84e
 5xbfOkJFS0iAf2xyv31/YUcLu2cJwrZeNmfmH9b/vYt4lLfFAt+Q0iK91UqetGS9Jg0Z
 xhRa0hZlCtOJIb1xHusHDsmwOamuueJvl+TPGV7ZQsI8wH1Zd3XXAgkwvSCYxgEJmh68
 qUNy0EQf2AbPHUXFVx+6u9RjDR/jBgyUtSG+a95NB5nBE8yzndlZyvpLSiq7NAIiN5Xa
 rqL68H/WFiyrYbsdzIrLBqpZMxGiSJ9pWGeTSb6CdrIjxcLmW5eINO0hClc6PjvGOgsF
 stIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712730896; x=1713335696;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DjssVysbhcp9rJd99TSABMh/n519hYdFgDAbHKkdo70=;
 b=cWkyPXBE5EyV/AQsqsVis6tPluJafYIn7tmZB8rqh4SeP3GElHaZSeMvEY/CZvuwoY
 8j3kKSkqKvIKPklV8d8UPzTNeKJDjaDaJ9GXRwXCMPm91/igh/UpjmqmOvP/RwHXC4d5
 d8Tonfa5DKECcXCeMrOShrVFpiUW0X3IWOMBOUjg/Y3vDchRYVEO2GpBvZvIg4qQNDDZ
 Z6T4l7v9sJh0p4fBQQADnWv+pRpFq31IanW1zHLViHp9CFjnw+L2zU2LDG8wr4NUeTGs
 oon7UhS/gQK+vd2hcFDeVYCQEEIPfHcVNcVVjw96sndGexW8YYeRU4UWo+4PLiXHTG7y
 lo7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKcpgJZ+IBL4DoijHAMXoy3fO5Owi1otZPI2nPpIupB2Owdt9XJ1/vpLcdoNO1jBm1/7WB4NNwZNdJJm7bIyT/+MZKJ1I=
X-Gm-Message-State: AOJu0YxUD3w//8cnfCuTLYa3VIayejSLvLFlRsZ2rh95x8OJDU+x/Fby
 GJ9vkG4Y0huo7hEN4E6rKGQGrDb9k6ZyT833LkaGhXzIpP5u38D/xYNLe88WwBs=
X-Google-Smtp-Source: AGHT+IHnXj1TqanBT/Ok8Rmhqz3ihtinRSMZ2zEr7NnEz5Hn8HjPUSF0dLif9RPbAX2psXQYovZqjw==
X-Received: by 2002:a05:6870:968c:b0:22a:7899:37c4 with SMTP id
 o12-20020a056870968c00b0022a789937c4mr2002035oaq.20.1712730896244; 
 Tue, 09 Apr 2024 23:34:56 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 gr6-20020a056a004d0600b006ead007a49dsm9431286pfb.49.2024.04.09.23.34.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 23:34:55 -0700 (PDT)
Message-ID: <ec63bef5-780e-44d0-8979-a31f7b54b07f@linaro.org>
Date: Tue, 9 Apr 2024 20:34:52 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 04/19] target/i386: do not use s->tmp0 and s->tmp4
 to compute flags
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-5-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240409164323.776660-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

On 4/9/24 06:43, Paolo Bonzini wrote:
> Create a new temporary whenever flags have to use one, instead of using
> s->tmp0 or s->tmp4.  NULL can now be passed as the scratch register
> to gen_prepare_*.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 54 +++++++++++++++++++++----------------
>   1 file changed, 31 insertions(+), 23 deletions(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 197cccb6c96..debc1b27283 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -947,9 +947,9 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
>       case CC_OP_SUBB ... CC_OP_SUBQ:
>           /* (DATA_TYPE)CC_SRCT < (DATA_TYPE)CC_SRC */
>           size = s->cc_op - CC_OP_SUBB;
> -        t1 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
> -        /* If no temporary was used, be careful not to alias t1 and t0.  */
> -        t0 = t1 == cpu_cc_src ? s->tmp0 : reg;
> +        /* Be careful not to alias t1 and t0.  */
> +        t1 = gen_ext_tl(NULL, cpu_cc_src, size, false);
> +        t0 = (reg == t1 || !reg) ? tcg_temp_new() : reg;
>           tcg_gen_mov_tl(t0, s->cc_srcT);
>           gen_extu(size, t0);

The tcg_temp_new, mov, and extu can be had with gen_ext_tl...

>           goto add_sub;
> @@ -957,8 +957,9 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
>       case CC_OP_ADDB ... CC_OP_ADDQ:
>           /* (DATA_TYPE)CC_DST < (DATA_TYPE)CC_SRC */
>           size = s->cc_op - CC_OP_ADDB;
> -        t1 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
> -        t0 = gen_ext_tl(reg, cpu_cc_dst, size, false);
> +        /* Be careful not to alias t1 and t0.  */
> +        t1 = gen_ext_tl(NULL, cpu_cc_src, size, false);
> +        t0 = gen_ext_tl(reg == t1 ? NULL : reg, cpu_cc_dst, size, false);

... like this.

It would be helpful to update the function comments (nothing is 'compute ... to reg' in 
these functions).  Future cleanup, perhaps rename 'reg' to 'scratch', or remove the 
argument entirely where applicable.

> @@ -1109,11 +1113,13 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
>           size = s->cc_op - CC_OP_SUBB;
>           switch (jcc_op) {
>           case JCC_BE:
> -            tcg_gen_mov_tl(s->tmp4, s->cc_srcT);
> -            gen_extu(size, s->tmp4);
> -            t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
> -            cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = s->tmp4,
> -                               .reg2 = t0, .use_reg2 = true };
> +            /* Be careful not to alias t1 and t0.  */
> +            t1 = gen_ext_tl(NULL, cpu_cc_src, size, false);
> +            t0 = (reg == t1 || !reg) ? tcg_temp_new() : reg;
> +            tcg_gen_mov_tl(t0, s->cc_srcT);
> +            gen_extu(size, t0);

gen_ext_tl

> +            cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = t0,
> +                               .reg2 = t1, .use_reg2 = true };
>               break;
>   
>           case JCC_L:
> @@ -1122,11 +1128,13 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
>           case JCC_LE:
>               cond = TCG_COND_LE;
>           fast_jcc_l:
> -            tcg_gen_mov_tl(s->tmp4, s->cc_srcT);
> -            gen_exts(size, s->tmp4);
> -            t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size, true);
> -            cc = (CCPrepare) { .cond = cond, .reg = s->tmp4,
> -                               .reg2 = t0, .use_reg2 = true };
> +            /* Be careful not to alias t1 and t0.  */
> +            t1 = gen_ext_tl(NULL, cpu_cc_src, size, true);
> +            t0 = (reg == t1 || !reg) ? tcg_temp_new() : reg;
> +            tcg_gen_mov_tl(t0, s->cc_srcT);
> +            gen_exts(size, t0);

gen_ext_tl

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

