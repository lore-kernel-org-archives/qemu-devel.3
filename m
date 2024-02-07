Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7DDC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 08:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXdam-0006Rq-VW; Wed, 07 Feb 2024 03:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXdaj-0006RW-9E
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 03:47:37 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXdag-0003Ez-0P
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 03:47:36 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d094bc2244so3637821fa.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 00:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707295651; x=1707900451; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E81wdmjqVBdZnfYE3yph211KNjmHI7u3Z6Id1C6xguY=;
 b=T4wqb5csRyYAEmB2AGWKDwqD2o02BpraO0PD93TgxZYlpPuc7k+lNwj1lADvHKfdBS
 EQrrYquTZC+pgDGjE9SbwlW9F3zzCXejoXYfX2hSLNZ8wFS62xy+YLwulbelpYK6AvSe
 CA9wTyC1mBcueyhygvjfKqzra0vbyHpR2Dh4/zTx7NhWlfSeFligNoG6fyXmj5lIVDQv
 YN+lRtrvtwVcN9uqR9Fv1/qNT9Y+GAzhfTTK27GMuSABSNh0KyIfI+mEkRzcfMJMcKIy
 YITfELApEQarpFFk33xm1XwIZcQGLtcdJynfDGGLltcVn/osuinQMqj3AxNBb+qoErl/
 iHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707295651; x=1707900451;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E81wdmjqVBdZnfYE3yph211KNjmHI7u3Z6Id1C6xguY=;
 b=LcVcPa0uLfKQkxklpV0XT36Xu9ZUWx6IdZfXJykRLUG6oPsueKhniRBptVCZsOtLFL
 3ZhLTg1skpLZ1gV0wglYPMx0Qi5XC/uCCSp3tlZ6+VzdGJc6/HesDx+4RO7CIxmNns1A
 6pCB8bITJIREfvlIakbFqfJsV8CdG1vPMCKC3KpdD5JRcjlZWAH/fQvk+SNfZdGri0SB
 zLn9kJTIriHKrn53IFANoMXiKl0A67kCavOF6zTb4fLAfwLSTPgaB8htpFm76WD0QV/v
 B/h3ngBGw5XohkfKCkpQp7HXasI7yjyZnwJ19cJTf6wOBPkmCeYcToDfWfhZD+L7cpHk
 XPtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0Ss/82sKmlT4NC9RU6v2qNOW9sp0NxsglJJr/9vDUc8v+eB8z/1YNuK0G1Wj0R09VP2qq+fDeQwMjODqDmiQEOha+YPw=
X-Gm-Message-State: AOJu0Yz0NeTvSGdl2Av68+W2uhmgAZ0QEfeBWN9rUB8/6orPXtbhTUmu
 QO1pyasOWdkqr8flIAUacnE81RQUAszF04pelHgmf6vbC1irZjOBls/O1877d3M=
X-Google-Smtp-Source: AGHT+IHlvzGTdzHrCt5ATjsTqnCTbOoACEag8ibHuoBhgnv6K04g8Np3Mfx4OnZNtTlaRooX8lhkag==
X-Received: by 2002:a2e:9902:0:b0:2d0:a0a6:9a3f with SMTP id
 v2-20020a2e9902000000b002d0a0a69a3fmr3350192lji.38.1707295651016; 
 Wed, 07 Feb 2024 00:47:31 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXt5M54f3CK4fBcRsfahFI8PfbJLdTJuzUiNk43BuPJ+0SzinSgk/aWj288kMNiwykUIqWrMfm8JD7ymJ3AzOaePiA0xYiHQwsoJb1OoK40FPt4rzxb+RJrOp4=
Received: from [192.168.69.100] ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a056402428d00b0055c82e27412sm443612edc.75.2024.02.07.00.47.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 00:47:30 -0800 (PST)
Message-ID: <76017b2e-f519-480e-8ad5-b45fda1670d3@linaro.org>
Date: Wed, 7 Feb 2024 09:47:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] hw/misc/mps2-scc: Factor out which-board
 conditionals
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-7-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240206132931.38376-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

On 6/2/24 14:29, Peter Maydell wrote:
> The MPS SCC device has a lot of different flavours for the various
> different MPS FPGA images, which look mostly similar but have
> differences in how particular registers are handled.  Currently we
> deal with this with a lot of open-coded checks on scc_partno(), but
> as we add more board types this is getting a bit hard to read.
> 
> Factor out the conditions into some functions which we can
> give more descriptive names to.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/misc/mps2-scc.c | 45 +++++++++++++++++++++++++++++++--------------
>   1 file changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
> index 6c1b1cd3795..02a80bacd71 100644
> --- a/hw/misc/mps2-scc.c
> +++ b/hw/misc/mps2-scc.c
> @@ -59,6 +59,30 @@ static int scc_partno(MPS2SCC *s)
>       return extract32(s->id, 4, 8);
>   }
>   
> +/* Is CFG_REG2 present? */
> +static bool have_cfg2(MPS2SCC *s)
> +{
> +    return scc_partno(s) == 0x524 || scc_partno(s) == 0x547;
> +}
> +
> +/* Is CFG_REG3 present? */
> +static bool have_cfg3(MPS2SCC *s)
> +{
> +    return scc_partno(s) != 0x524 && scc_partno(s) != 0x547;
> +}

Looking at next patch and nitpicking, if we want to avoid
a switch() case use, this style is easier to review IMHO:

    static bool have_cfg2(MPS2SCC *s)
    {
        return    scc_partno(s) == 0x524
               || scc_partno(s) == 0x547;
    }

Anyway, already R-b.

