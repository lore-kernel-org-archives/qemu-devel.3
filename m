Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0786C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 22:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJgz3-0002wG-Bn; Tue, 18 Jun 2024 18:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJgyz-0002ug-A6
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:07:18 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJgyx-0002Y1-Ed
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:07:17 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-710437d0affso475089a12.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 15:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718748434; x=1719353234; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PX1ZX/PwWlIbltbi4xvdXTzEcadBa3X+1iYRxpPdUqM=;
 b=HErBmYCgusOQZw9doFOSRPrjI1XxMwNWPZd4HLBjC48NXxnxqO4N1YJ3IbkaSKgXyC
 56GL1Vg/pLCIFswxttrX3kYpuNgjSyk6ALKgt/IGdlfZXgxV3iMh8WwTC+qzLGwEJwAI
 s1739XvVdqi5z7x4g+j3HRpnhZozBRUOsOkJZM8b36laRT254VwVPo6OSaC5IrYK+2ei
 P9z7s+b+wvtzHyr6BwHfkj9YdsokLk3iuBcBXuE2iyRZ3uRraq15BOyWW/B7ynv72mlR
 jm9xMVfPTiGKcgJ11hI1wLtwTRs6kNHHoxUt+mUNzkMM+Qrz+IOQI2eRRMwn8DgMmYxn
 WM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718748434; x=1719353234;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PX1ZX/PwWlIbltbi4xvdXTzEcadBa3X+1iYRxpPdUqM=;
 b=urh0h4FOPMFNULK8h7uExw9e3a7bQBR/s8BMYuc8LsK6SA37t8q8G4qD8T2e4e7WQe
 Gw3RusrcG9fdyQPikFUyOeU1WWGf9TcThHQncxnIJncRTVkYpNttsKRmwzsJyGYQUogx
 /9q6S3vXDLq6pThTm2rmYQcHQ5dkwvb33cWW78COgp87j/LT37JbQRrW7vwmaGP6ufQT
 78LPGp1xBq3EFbisJtkxDGwS3Y4+Px3G1hKfMXHzvDCAns0Ui+VE0yu4ZS4aqDtban7v
 usppkt8kPAI1qTWnAlarVazt6DTFijJHSGcAUaAA9G49hUeKJSAlkExmapnvRARvjUxB
 UYzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2cnVwFfzciAGoAX3l7wZsSGQ/ZeRlUj/PfNUnbMScVZNwyqB3Py72xvPAmxU/67UFGffGphcyCtYHRUQdS/1y2pO1vXU=
X-Gm-Message-State: AOJu0Yy4Z6K/LiY7+SOCxXC3+gZgyBaSAW6W618E3bQOGLar6GhpYqgT
 B+Mxvbfh7ceZRNo3dZcLKcsVwNknh70mk1mIlQSGij0bYBNWjsbkONb16cftSQs=
X-Google-Smtp-Source: AGHT+IEyVDLxRyapzBZrGD2EH2dIjFg9gIsummHuPYTemTBQeeppj2ybLXKQ8iD5FBrgzC/Z1mpgDg==
X-Received: by 2002:a17:90a:e390:b0:2c4:dc63:96d7 with SMTP id
 98e67ed59e1d1-2c7b5d8b460mr968250a91.41.1718748433604; 
 Tue, 18 Jun 2024 15:07:13 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6ff19a06b58sm8410490a12.49.2024.06.18.15.07.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 15:07:13 -0700 (PDT)
Message-ID: <745f154c-6bdd-427b-8921-12b7fde04ffd@linaro.org>
Date: Tue, 18 Jun 2024 15:07:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/23] Add thread setup for BSD-USER
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-10-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-10-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
> Function for setting up thread upcall which will
> add thread support to BSD-User
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
> ---
>   bsd-user/aarch64/target_arch_thread.h | 45 +++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
>   create mode 100644 bsd-user/aarch64/target_arch_thread.h
> 
> diff --git a/bsd-user/aarch64/target_arch_thread.h b/bsd-user/aarch64/target_arch_thread.h
> new file mode 100644
> index 0000000000..d2f2dea7ce
> --- /dev/null
> +++ b/bsd-user/aarch64/target_arch_thread.h
> @@ -0,0 +1,45 @@
> +/*
> + * ARM AArch64 thread support for bsd-user.
> + *
> + * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef TARGET_ARCH_THREAD_H
> +#define TARGET_ARCH_THREAD_H
> +
> +/* Compare to arm64/arm64/vm_machdep.c cpu_set_upcall_kse() */
> +static inline void target_thread_set_upcall(CPUARMState *regs, abi_ulong entry,
> +    abi_ulong arg, abi_ulong stack_base, abi_ulong stack_size)
> +{
> +    abi_ulong sp;
> +
> +    /*
> +     * Make sure the stack is properly aligned.
> +     * arm64/include/param.h (STACKLIGN() macro)
> +     */
> +    sp = (abi_ulong)(stack_base + stack_size) & ~(16 - 1);

sp = ROUND_DOWN(stack_base + stack_size, 16);

> +    pstate_write(regs, PSTATE_MODE_EL0t);

This is the default in arm_cpu_reset_hold for user-only.
There should be no need to duplicate this.


r~


