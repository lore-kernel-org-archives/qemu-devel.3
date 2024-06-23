Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C097EC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 17:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLRKS-0001eF-Pm; Sun, 23 Jun 2024 13:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLRKO-0001df-E2
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 13:48:36 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLRKM-00041V-I7
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 13:48:36 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-706524adf91so1640833b3a.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 10:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719164913; x=1719769713; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Wm6gOMwirCIAjlbyQ36hwZxIcM1l/lqLuZn+yu3/xE=;
 b=PVjeh6iyFz6xqOBgjxBZjdfAAe+bFPha6hLBkbrYQ24q8HFZbHpfhPi5vqoEiVX/1K
 l6BBNUu1FSHu7IO5z9g68bSvxrQEbWTEeXS/HlO/vgXvE2aSejpacVDly7O6ERmayotM
 F4cl2yPNMIKx1snY5uEfzlKhKkqbHjAbLI+7TYbfof7HcHYKtv+bOPLPKpBelE1R16yl
 QRLSUIU6Jahn+i5aZ6lz/3e6mYk/ibmn8P/du0a037T8iUDPYw8/R/9wJ1VIsuqZFew5
 Zl29yiqR8r/kUlE9188D0BxhynSSpT9iYUidn0JrSLj0unSHifQNPAu/1XURtgrTv95C
 DmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719164913; x=1719769713;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Wm6gOMwirCIAjlbyQ36hwZxIcM1l/lqLuZn+yu3/xE=;
 b=cjew7qyeg7riRbp7peDhNPUAaZzgKjtTP4dSKre4CRiBY1UHPmdpfRpgp88lAKTgmH
 SHIwtjGmlU0ccon8DQ1IRZP1u0pi3yNxxA8yXFea6zeXKkm+TTP2BsioW2fGS5EHV3qH
 KjRudSc2am4P7IVL0TksMkTsiptng1tth8HoVBH6Txa8pV4iDY1iOyIWRX/xUQUECRhy
 g8V4vLbCcrkiA0mgLAI6kZT+e8AGEuEGYXBQt6I3hReMpPSpA+k6JFlzhteA+vM2EqL3
 WeNQhHHpJd4UKa9z+jMLw6m2dP2vBuNVXxhG5A9bbeLm4e3YHBWugBBd10b7xnJYmxK/
 awJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVku4cmEhThQvCvt+Ocoa2eqvIWi41SLAcYviP8Chn51GRt7Eb6vv2d2RhFm+dpS+yUjWXP0H7Q/R7rTBG0Ddoab9kVCE8=
X-Gm-Message-State: AOJu0YwOyPrpq+zbwv415J0fqWWqyatTf7HiOqa0MoonUeM539pchuO7
 KQy2ZWt4Rm9p8XZHRXzEuuZ/cqopz0XHIWRnzq9Z8eWlBgjCqC6VTz2th01099niLeSAkveaLWJ
 M
X-Google-Smtp-Source: AGHT+IEqXbI083Jj35cDFsykV34Am/CliJrIz3yyF9cVkv8VyKi5MrDgpnqDe4+F8/wRh1n+mWZ2eA==
X-Received: by 2002:a05:6a00:3d11:b0:705:95ce:cfd3 with SMTP id
 d2e1a72fcca58-7067105619emr3908756b3a.31.1719164913003; 
 Sun, 23 Jun 2024 10:48:33 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7067eb5b970sm935673b3a.177.2024.06.23.10.48.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 10:48:32 -0700 (PDT)
Message-ID: <ed5ad041-80fe-45f7-a638-9df34ef37fef@linaro.org>
Date: Sun, 23 Jun 2024 10:48:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/23] Add set_mcontext function for ARM AArch64 in
 bsd-user
To: Warner Losh <imp@bsdimp.com>
Cc: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org,
 Ajeet Singh <itachis@freebsd.org>, Stacey Son <sson@freebsd.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-23-itachis@FreeBSD.org>
 <8bf36c67-070e-4e04-987b-c64b502ed62d@linaro.org>
 <CANCZdfpX1rFFznOohEenUv3kpEg91NR04QZPd3wJnBk1SmR8fg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CANCZdfpX1rFFznOohEenUv3kpEg91NR04QZPd3wJnBk1SmR8fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 6/23/24 08:54, Warner Losh wrote:
> 
> 
> On Tue, Jun 18, 2024 at 4:51 PM Richard Henderson <richard.henderson@linaro.org 
> <mailto:richard.henderson@linaro.org>> wrote:
> 
>     On 6/17/24 11:58, Ajeet Singh wrote:
>      > From: Stacey Son <sson@FreeBSD.org>
>      >
>      > The function copies register values from the provided target_mcontext_t
>      > structure to the CPUARMState registers
>      >
>      > Signed-off-by: Stacey Son <sson@FreeBSD.org>
>      > Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
>      > ---
>      >   bsd-user/aarch64/signal.c | 22 ++++++++++++++++++++++
>      >   1 file changed, 22 insertions(+)
>      >
>      > diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
>      > index 43c886e603..13faac8ce6 100644
>      > --- a/bsd-user/aarch64/signal.c
>      > +++ b/bsd-user/aarch64/signal.c
>      > @@ -95,3 +95,25 @@ abi_long setup_sigframe_arch(CPUARMState *env, abi_ulong frame_addr,
>      >       return 0;
>      >   }
>      >
>      > +/*
>      > + * Compare to set_mcontext() in arm64/arm64/machdep.c
>      > + * Assumes that the memory is locked if frame points to user memory.
>      > + */
>      > +abi_long set_mcontext(CPUARMState *regs, target_mcontext_t *mcp, int srflag)
>      > +{
>      > +    int err = 0, i;
>      > +    const uint64_t *gr = mcp->mc_gpregs.gp_x;
>      > +
>      > +    for (i = 0; i < 30; i++) {
>      > +        regs->xregs[i] = tswap64(gr[i]);
>      > +    }
>      > +
>      > +    regs->xregs[TARGET_REG_SP] = tswap64(mcp->mc_gpregs.gp_sp);
>      > +    regs->xregs[TARGET_REG_LR] = tswap64(mcp->mc_gpregs.gp_lr);
>      > +    regs->pc = mcp->mc_gpregs.gp_elr;
> 
>     tswap.
> 
> 
> So "regs->pc = tswap64(mcp->mc_gpregs.gp_elr)"  then?

Yes.

> 
>      > +    pstate_write(regs, mcp->mc_gpregs.gp_spsr);
>      > +
>      > +    /* XXX FP? */
> 
>     Similarly, see target_restore_fpsimd_record.
> 
> 
> Since neither this, nor the get_mcontext is written for FP on upstream yet, can we do 
> those as a followup commit?

Yes.


r~

