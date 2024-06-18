Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D47C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 22:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJhfP-0005Wr-7O; Tue, 18 Jun 2024 18:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhfM-0005Wa-QE
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:51:04 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhfL-00029v-7X
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:51:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f9aa039327so4128575ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 15:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718751060; x=1719355860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1eX004Bh/sE0HmilNW/vpshdPZJ14buOjXAO2yUxUGc=;
 b=m9K6sBCtPd8dzaaSbzleag92HTDJd6AqCmim07KJCaq6aCVKYmRPVgfLEPD2R6eorT
 2hLI/b7q3MsbwBN3iFbND2bpiOKIRxEfVOOvysrQrAn/KSbLpzMJi4EfJDpVkEw8mFjm
 8Cseaneof4bEmCuiJVrsX0iOkfY+Sjvs81X1GXW6/CVUyKGpMexZb6Vpx5ecYc/YZkgS
 7rcqFJrlrK1dotvXC+sigv5enoNqqkzHw9xliJb7XAQZEsAH29kMPf/zMDiR/UVUHXZe
 JH52MbJWVG6hOfkLrYHvQgFgLArZrqNxHUhQzXw37X4UpbKyiNLWQjoVTeTiPfn2Yn9y
 yiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718751060; x=1719355860;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1eX004Bh/sE0HmilNW/vpshdPZJ14buOjXAO2yUxUGc=;
 b=XCBsE20aMvQMJkzKitbtTIi1d+K3dd03kMVhfs+ncvdZycUwBMutxgIRRgg4obchqQ
 H0QjepDlFahBhfeKiXtcayao+xmZzZua+m8z1/tZ7dx0bNf20k6UisQpzafxztHN8HYz
 9jwkRJIDXlyxxNQ3vl1ReCnHouMh8Y6f4fz7zzMG+nCIA8mJSvgwXzck0d67nmA8Shmj
 4OJW00l+ojaBtPilpiOMUdssRhaIATbDHvMfo4q6iIO8OrKOfSMfRgPPnvtlmrF0J6sd
 cISoDriCJiT1m2Mm0F/5Opw6+WFaYPUYVn9It9uCpxs+3iieOYL4Yf8ovnaucAqTUtjU
 1Hqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqCDeDRJlXkjgChLL0IOII20n2lbaAX8TYPxSFh9G9rnBiDSRl0AUYyCYC+40+cIFXtSl1mgEeW1ho9fwHdYIVefxsb8g=
X-Gm-Message-State: AOJu0Yz9fByxf1Am6qc/4uzvqQs8GnpUbV4gfNeqm/HlQK2iMCUFjqH6
 CQFaQJunjGr27swY9z+UezLwuHj5a5PNfkKGB0b9Bx4Kcd6+RJnvwWHHQ0PymPA=
X-Google-Smtp-Source: AGHT+IE2kb/pl0AO8sbDyVQZZO8NJ6yJA363t8qguGT7XSWEhgt3jHWPEEiL7/IXPtt27ua+5NG9+g==
X-Received: by 2002:a17:902:d2c2:b0:1f7:21fd:aba3 with SMTP id
 d9443c01a7336-1f9aa3e3366mr11387355ad.34.1718751060106; 
 Tue, 18 Jun 2024 15:51:00 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855f1c9a3sm102778865ad.224.2024.06.18.15.50.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 15:50:59 -0700 (PDT)
Message-ID: <8bf36c67-070e-4e04-987b-c64b502ed62d@linaro.org>
Date: Tue, 18 Jun 2024 15:50:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/23] Add set_mcontext function for ARM AArch64 in
 bsd-user
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-23-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-23-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
> The function copies register values from the provided target_mcontext_t
> structure to the CPUARMState registers
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> ---
>   bsd-user/aarch64/signal.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
> index 43c886e603..13faac8ce6 100644
> --- a/bsd-user/aarch64/signal.c
> +++ b/bsd-user/aarch64/signal.c
> @@ -95,3 +95,25 @@ abi_long setup_sigframe_arch(CPUARMState *env, abi_ulong frame_addr,
>       return 0;
>   }
>   
> +/*
> + * Compare to set_mcontext() in arm64/arm64/machdep.c
> + * Assumes that the memory is locked if frame points to user memory.
> + */
> +abi_long set_mcontext(CPUARMState *regs, target_mcontext_t *mcp, int srflag)
> +{
> +    int err = 0, i;
> +    const uint64_t *gr = mcp->mc_gpregs.gp_x;
> +
> +    for (i = 0; i < 30; i++) {
> +        regs->xregs[i] = tswap64(gr[i]);
> +    }
> +
> +    regs->xregs[TARGET_REG_SP] = tswap64(mcp->mc_gpregs.gp_sp);
> +    regs->xregs[TARGET_REG_LR] = tswap64(mcp->mc_gpregs.gp_lr);
> +    regs->pc = mcp->mc_gpregs.gp_elr;

tswap.

> +    pstate_write(regs, mcp->mc_gpregs.gp_spsr);
> +
> +    /* XXX FP? */

Similarly, see target_restore_fpsimd_record.


r~

