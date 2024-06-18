Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9106C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 22:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJh2Z-000679-8R; Tue, 18 Jun 2024 18:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJh2W-00066e-2r
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:10:56 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJh2U-0003f5-Fb
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:10:55 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-706264e1692so664557b3a.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 15:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718748653; x=1719353453; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cNWCei83wFklZqG3U3G6xGYII0XS+TGPg2i4TXY0Wwo=;
 b=DNLjvQ40aMWdKmbNmIBVIVnrTNUgG5Gzp1Af06BtHFB36kNQlwnW98jpS9znUjiZTg
 /rFbm/wZmQPxE9/kRHzYcQfhm0N5PJxzo08MzJxHbk+8wgai77B2Bouu8mAbtGc/kGR5
 w16PUmXRPzMHjyu9zw3OzoQy1un8nRssk74zY5wbOMEIkB44iBnlV/Aia/6rVIo954vl
 kI4QvAho8FcfOMMdEiRqlhuBCP9mCTbTqJ1txfyhX25Ac1T1Jje8431kUaXRHdUBD3RO
 lTZzsYfj+tgh+3J46oWJ/9vAiUP+dcnOB4Jaqm55we+cLCXEVnsW8HjRbWzt1pw2RBKb
 zGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718748653; x=1719353453;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cNWCei83wFklZqG3U3G6xGYII0XS+TGPg2i4TXY0Wwo=;
 b=OLc6V9kQ6yoyqT2NCPxayeaMU/pd53/fTrn1dVtUU8zxZb1oR60ZahLPW3vII2SYJy
 iNqoKd8mrPz96Ze/rEQR9bGgah/117Gn1+GT5mhh9rfI8MpDgQybE8tiJ26GV+i+6Z2+
 Oj260R0CYrmx1jINBHJJ/x5nGm4lE5TVMyPvBwI1hVcZ5g6M2yt1R6m8yejvflfUwj8b
 /zTMxmNoru3/wITPprwryoJV4Uj5fwOvfz+/44J2o/SykFaIHh/WglLgevFiY7fTTbrp
 GTd2hk1iguoSnOeULx3HtI0Ilb2r5nFYO1e0X5//6tLaFGMRFCZnmnZpqmP91sIWeHkf
 Q77Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPNJ1PGeE6E2tSsx0ja+vRXFYfFuBxrXKf6QiTDrmTopAZGHPFxOtc3X8uqjjqvZmMYqDqejOlCp2xq0tkULXPFNby5nA=
X-Gm-Message-State: AOJu0YzQKMPKopPrDoAw62wALdz+tIXsLyHzOGtyO1w+JqG53xKPES+0
 prxd1SiEG3neMM+vMX8+4TN7+44LjO+H685nlaHcnM3Sfe9vEiAneYbI4R7c76I=
X-Google-Smtp-Source: AGHT+IHoQabX1Xxwd4vPS7u7/JaMNfwB4akksm/t3u3pMWGlX8EURXn/e9qTtJIyvJJ8jw10mauo7A==
X-Received: by 2002:a62:b60d:0:b0:704:37b2:4ced with SMTP id
 d2e1a72fcca58-70629c429c2mr885742b3a.11.1718748652814; 
 Tue, 18 Jun 2024 15:10:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705cc96ad04sm9448731b3a.64.2024.06.18.15.10.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 15:10:52 -0700 (PDT)
Message-ID: <2d336fcb-5130-487f-aa1e-0665f7a3a15e@linaro.org>
Date: Tue, 18 Jun 2024 15:10:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/23] Add thread initialization for BSD-USER
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-11-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-11-itachis@FreeBSD.org>
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

On 6/17/24 11:57, Ajeet Singh wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Initializes thread's register state
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
> ---
>   bsd-user/aarch64/target_arch_thread.h | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/bsd-user/aarch64/target_arch_thread.h b/bsd-user/aarch64/target_arch_thread.h
> index d2f2dea7ce..bfc9050cb1 100644
> --- a/bsd-user/aarch64/target_arch_thread.h
> +++ b/bsd-user/aarch64/target_arch_thread.h
> @@ -42,4 +42,20 @@ static inline void target_thread_set_upcall(CPUARMState *regs, abi_ulong entry,
>       pstate_write(regs, PSTATE_MODE_EL0t);
>   }
>   
> +static inline void target_thread_init(struct target_pt_regs *regs,
> +        struct image_info *infop)
> +{
> +    abi_long stack = infop->start_stack;
> +
> +    /*
> +     * Make sure the stack is properly aligned.
> +     * arm64/include/param.h (STACKLIGN() macro)
> +     */
> +
> +    memset(regs, 0, sizeof(*regs));
> +    regs->regs[0] = infop->start_stack;
> +    regs->pc = infop->entry;
> +    regs->sp = stack & ~(16 - 1);

ROUND_DOWN, otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

