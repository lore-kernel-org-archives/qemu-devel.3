Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAFEC2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 22:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJhkM-0007NH-Sd; Tue, 18 Jun 2024 18:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhkL-0007Mz-7U
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:56:13 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhkJ-0002lN-L8
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:56:12 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-705c739b878so264801b3a.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 15:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718751370; x=1719356170; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a4WkmOnchR+WyvyTYuT8IH8WGNbX83h72ql6PMaM/dw=;
 b=BNE+55st9VWanyyDIgfnHVhsUd42+rLmcKYkKfbYBc+I8u6ihAJQbXtb9k/t7FkmnH
 YbwJRFocT1cxMxmBx1PgFHf2on3GmhhNLFgsq+PCJiGNkJo32CbwiRaXOcY8U5TsMYhY
 AVkXyLzTK12YYr3ILrFjYd7Z8O+2PyPy0c/2eDqwAYt17Gv3eilKCiBqSPdo0OfNUrNf
 ifStzI0HIWSznd61qmHEtXsVyTqwh4AdWdgsunNTPUFRknuS9/P/h6oTj85MsKhutgBH
 CNeQvqYLq9Ode0N0uBsx5hhSDmZqeeV3Z5iRDoN+mmvc2uQ9eJZpRAghiyb9wcJgvCTa
 ZcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718751370; x=1719356170;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a4WkmOnchR+WyvyTYuT8IH8WGNbX83h72ql6PMaM/dw=;
 b=cMkNYJ9HmydF/XMxSw0qAXhGdgm7W3xp10sken+2x0V4cKDu8/MJWlSSU898BjOJQG
 s7qj+qfFNYQ0DNa49oOdRWsHTdFy2KlqrCAbfUmVgSCPolm6AiIMQqSAtpDWDTyRnPnw
 MZifq+tYLTAETpIpOV3+wquhcO2EmEFEBMzYc6OFavSea+BVF0PJoRJIIJ0/fL28h4KZ
 uLQynIa59GWm0niiJ6g+5rY++hQ/ioFngz9m6mMf3XFVNhuoMOvCYyNynE7c38QA9jCw
 HEofFr5HLJyau6IhvPuHuHFcHPs2QwMLEyClqxZiSS6GbQBkH1Rw/9prjvfIOqijcJYs
 gFYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmocGVzIfE7NJXeRd9KcNaLCHg8E4cz93rxN5bjLMHTLPXfpppHDTXUtp2ULNgZyYc/FkfC1GaTLRJrKD+Lu6ElWM9sp0=
X-Gm-Message-State: AOJu0YxiMw8tfhqIf+A8r8dmWacVBI+a2GQGwjr9LU39TG4Kz4DKyW1Z
 /UpBGNavU0rbJaI+NC8X0qy9aO5QfQn4cZjOFyIrtjW+UBG1QnPeeeOT3W08BN4=
X-Google-Smtp-Source: AGHT+IGFaoXCfMOuRyMsHpSzG9aTN98nFM8SrZVidnZQ70wGI2acmUOMTag/OPvIw5rkx3RjvyMEiw==
X-Received: by 2002:a05:6a20:4c09:b0:1af:b89b:a7f1 with SMTP id
 adf61e73a8af0-1bcba22f73emr1255026637.27.1718751369816; 
 Tue, 18 Jun 2024 15:56:09 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7062bf76540sm255077b3a.151.2024.06.18.15.56.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 15:56:09 -0700 (PDT)
Message-ID: <60ca952d-35c8-43dc-aba7-1b077867a7aa@linaro.org>
Date: Tue, 18 Jun 2024 15:56:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/23] Add get_ucontext_sigreturn function
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-24-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-24-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 6/17/24 11:58, Ajeet Singh wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Function checks the processor state to ensure that the current
> execution mode is EL0 and no flags indicating interrupts or
> exceptions are set
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> ---
>   bsd-user/aarch64/signal.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
> index 13faac8ce6..ad81531ec5 100644
> --- a/bsd-user/aarch64/signal.c
> +++ b/bsd-user/aarch64/signal.c
> @@ -117,3 +117,21 @@ abi_long set_mcontext(CPUARMState *regs, target_mcontext_t *mcp, int srflag)
>   
>       return err;
>   }
> +
> +/* Compare to sys_sigreturn() in  arm64/arm64/machdep.c */
> +abi_long get_ucontext_sigreturn(CPUARMState *regs, abi_ulong target_sf,
> +                                abi_ulong *target_uc)
> +{
> +    uint32_t pstate = pstate_read(regs);
> +
> +    *target_uc = 0;
> +
> +    if ((pstate & PSTATE_M) != PSTATE_MODE_EL0t  ||
> +        (pstate & (PSTATE_F | PSTATE_I | PSTATE_A | PSTATE_D)) != 0) {
> +        return -TARGET_EINVAL;
> +    }
> +
> +    *target_uc = target_sf;

Why delay this store?  I don't see why you're assigning 0 above.


r~

