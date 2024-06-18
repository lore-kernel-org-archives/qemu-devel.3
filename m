Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3311C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 22:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJhQX-0006y0-Ty; Tue, 18 Jun 2024 18:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhQX-0006xp-3L
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:35:45 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhQU-0007ba-W8
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:35:44 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-704090c11easo4996108b3a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 15:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718750141; x=1719354941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PSqjDbFufydQwKjNat/hHIN9YuasIYTcdjVbqmWH69U=;
 b=kJmDh8NcRCnIZBPNvVCat39+/AoVKyrrJltygwS1HOBuimFSu23DCD6sohr+2G8Aik
 YzPdE5aAcextZDOLuh8rXRBLyqsrMxJu2wHZtrkrhb1gNkulwnjAA7FMmGETwsNDG2q8
 NnxkBAViHXNlqszZ4TgSve+KVeZ3Yw55VBUsX5PbNlZc9ExgzA/YVUPytg+M+IxqAnmw
 oQo7p/J+Y7fxroOrZP1AvGwUIZqmajNppNmfJBsbD1CE2OO4l4zLnRsRS/voUFxGnX1r
 +rWiLKJk54Gv3tzcsehIt+ODC4WszNApH7wgSmSz2z2KLlbxS7sNDEVdTLIaQ8pEFJjP
 dcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718750141; x=1719354941;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PSqjDbFufydQwKjNat/hHIN9YuasIYTcdjVbqmWH69U=;
 b=hkA5M2ZaLBn6hHZp1aT7Ep71GcXmC6HcEFYYUO5NV6UppUNOKX3ynzVU56QC0Z2XCW
 yut7I+kH81Yi991e/CXL2gFNBW5dXSAzvNs334tv4+UWNn7I+HBfMyjmAtWIX6xXYSth
 usH9PMGY3hui2n0NcJFitgZfJYFvPPXlE8Q92oXAUGZiUKoqNZmuYoQ2k/tCG/RP5gDc
 4BalP+GTIOsqMUnpj+z7sdniIctCSH5frQjtmxffSNAIyTqIE4wt/N9VbO6y/fMr58NX
 hC8m24GsAIjN634BMTOPZfrbZ9kFQJMjx6a6wsXhAzFg4E+KDvYAZgapr+cF5sUAuP6o
 jNig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWVRJa6zQ4OCc1kWWyRvLz2dHvYp5Ct1MI371qy8+WS8uxWp3J3SPHlVV9KbYesRqrHcoz+M5EFKVb70Uz4anEl+KYhh0=
X-Gm-Message-State: AOJu0YzhCgZcbEu5RQ9pAHvoQ8k0JZoZsZorRBe1pZzvDh83bsA74Vez
 Xl64RIiNzikVoEleWaiUldeB21Vxkm2OziZdjptq/Jm0iq0CDGUfE/WfS2FfeyI=
X-Google-Smtp-Source: AGHT+IFhC0ZsYhtAsZwhbysJ1MdLbV6Ixc5rXcZS8iOBqwwypPc1JvCoR9YiMAQDfjf9V4jaLTyvaA==
X-Received: by 2002:a05:6a20:a11b:b0:1b2:b2b:5698 with SMTP id
 adf61e73a8af0-1bcbb5cbfa4mr1149690637.33.1718750141481; 
 Tue, 18 Jun 2024 15:35:41 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb3d1aasm9816049b3a.140.2024.06.18.15.35.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 15:35:41 -0700 (PDT)
Message-ID: <89658d86-0123-4d07-84e6-b5bea63cb787@linaro.org>
Date: Tue, 18 Jun 2024 15:35:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/23] Add ARM AArch64 specific signal definitions for
 bsd-user
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-19-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-19-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
> Defined register indices and sizes,introduced structures to represent
> general purpose registers, floating point registers, and machine context
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> Co-authored-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/aarch64/target_arch_signal.h | 80 +++++++++++++++++++++++++++
>   1 file changed, 80 insertions(+)
>   create mode 100644 bsd-user/aarch64/target_arch_signal.h
> 
> diff --git a/bsd-user/aarch64/target_arch_signal.h b/bsd-user/aarch64/target_arch_signal.h
> new file mode 100644
> index 0000000000..df17173316
> --- /dev/null
> +++ b/bsd-user/aarch64/target_arch_signal.h
> @@ -0,0 +1,80 @@
> +/*
> + * ARM AArch64 specific signal definitions for bsd-user
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
> +#ifndef TARGET_ARCH_SIGNAL_H
> +#define TARGET_ARCH_SIGNAL_H
> +
> +#include "cpu.h"
> +
> +#define TARGET_REG_X0   0
> +#define TARGET_REG_X30  30
> +#define TARGET_REG_X31  31
> +#define TARGET_REG_LR   TARGET_REG_X30
> +#define TARGET_REG_SP   TARGET_REG_X31
> +
> +#define TARGET_INSN_SIZE    4       /* arm64 instruction size */
> +
> +/* Size of the signal trampolin code. See _sigtramp(). */
> +#define TARGET_SZSIGCODE    ((abi_ulong)(9 * TARGET_INSN_SIZE))
> +
> +/* compare to sys/arm64/include/_limits.h */
> +#define TARGET_MINSIGSTKSZ  (1024 * 4)                  /* min sig stack size */
> +#define TARGET_SIGSTKSZ     (TARGET_MINSIGSTKSZ + 32768)  /* recommended size */
> +
> +/* struct __mcontext in sys/arm64/include/ucontext.h */
> +
> +struct target_gpregs {
> +    uint64_t    gp_x[30];
> +    uint64_t    gp_lr;
> +    uint64_t    gp_sp;
> +    uint64_t    gp_elr;
> +    uint32_t    gp_spsr;
> +    uint32_t    gp_pad;
> +};
> +
> +struct target_fpregs {
> +    __uint128_t fp_q[32];

Per patch 6, re not using __uint128_t directly.


r~

