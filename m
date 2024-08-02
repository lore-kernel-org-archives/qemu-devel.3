Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6040EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZscL-0005zU-Hz; Fri, 02 Aug 2024 09:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsc7-0005yN-Hm
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:46:36 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsc3-0005nN-TB
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:46:34 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7104f939aaaso2605977b3a.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 06:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722606390; x=1723211190; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SZVCcJdN42Etq4ofRA5pywOXMlTvt4SjHqJp5CRWTOk=;
 b=RYOh/uYJdTrkgbLBGt7J8K2Ht0A0b/BUWmdlY01jDoEadO2tCjzlssjcPLy1ervOPb
 fWAFmszB/7Uj5OY03tKcj6UuslgWJtFxBqx1JYlnfKzHDKH0jWJ4poSwwwpfLSQdcdOH
 12opQ/Ubvdi4fBj1Fp2WZOtWBRialQCFTGKUqE8wue2V2V9Is4PN+hmfaun5k7nxSSby
 5ks5SFPOog02+JarqVN2+k/C1Vp7dOtzT3Wqp0qsv1yRf+s7BS7zUFv/bo2yM85V8LOB
 YCg0hrl9x7uezwbo3+v2MuRcoxfJlEATkx6RJrYOecBZGzpyjAIsFsSYeCjhHWx26YYD
 7S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722606390; x=1723211190;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SZVCcJdN42Etq4ofRA5pywOXMlTvt4SjHqJp5CRWTOk=;
 b=Bgs0ZV0wtSqivJv9n+j8OXRMSeh45wXLt+LDff9EPZJb6yxOeKVHwSl09QUFZXbCov
 ADYeSnflYg6OCz744tgp4DRnO+47k3ASfIHdtAAu2whkuv41qhYkIY0K/ROz9huBpCul
 4T7FktAeMag6JLt72GKwhyzJCl/tiwRbWGdHrjitlHQlUhvOTjLXGhNwzfINSCaf6Gce
 m2KqeNBZvdoNTa9nP0qMvQEsQmf5GsLzbIUGMtPhdBhmdaRIKMQ65RyoY9XPspq6e4tI
 iDkiqQqvZe9IxAY5I20c3u/QLm0pqoJrqXc2woNN6v8zLJYSKsthidspT5kykqCQlls0
 OJgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxX1p1HI0DaHLr5x2amwOoUyc14FQp4E2aRZ/rHCy3SA6t137xeEaXEBrDkmG5IETGpVPEoTpHOVryF8skxmO92IClqWE=
X-Gm-Message-State: AOJu0YzaO8k8kOjLLESgALP6P2izHlvjXvasj+E0FovsxDMD8EWdEyg1
 2AgG7o+o/zr/gJPURMP8eqkKQAa2tZSZiZrHjfYv9uD9lwqk9szbOjGju1fFnVg=
X-Google-Smtp-Source: AGHT+IFmfv44kX7LWshMfMpBTGsC/v1/XuxZtRZXg8hGck7TV3/W0AyiadSOQNas6hR5iaMaAm9MBQ==
X-Received: by 2002:a05:6a20:9f4b:b0:1c0:f0c1:5d45 with SMTP id
 adf61e73a8af0-1c699627be9mr4269583637.44.1722606389962; 
 Fri, 02 Aug 2024 06:46:29 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b763a3bde6sm1375703a12.47.2024.08.02.06.46.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 06:46:29 -0700 (PDT)
Message-ID: <e336b442-cd6c-40ac-9a48-3f9356bd0c48@linaro.org>
Date: Fri, 2 Aug 2024 23:46:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/18] bsd-user: Implement RISC-V signal trampoline setup
 functions
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
 <20240802083423.142365-16-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802083423.142365-16-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 8/2/24 18:34, Ajeet Singh wrote:
> From: Mark Corbin <mark.corbin@embecsom.com>
> 
> Added functions for setting up the RISC-V signal trampoline and signal
> frame:
> 
> 'set_sigtramp_args()': Configures the RISC-V CPU state with arguments
> for the signal handler. It sets up the registers with the signal
> number,pointers to the signal info and user context, the signal handler
> address, and the signal frame pointer.
> 
> 'setup_sigframe_arch()': Initializes the signal frame with the current
> machine context.This function copies the context from the CPU state to
> the signal frame, preparing it for the signal handler.
> 
> Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Co-authored-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/riscv/signal.c | 63 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
>   create mode 100644 bsd-user/riscv/signal.c
> 
> diff --git a/bsd-user/riscv/signal.c b/bsd-user/riscv/signal.c
> new file mode 100644
> index 0000000000..005eb53cab
> --- /dev/null
> +++ b/bsd-user/riscv/signal.c
> @@ -0,0 +1,63 @@
> +/*
> + *  RISC-V signal definitions
> + *
> + *  Copyright (c) 2019 Mark Corbin
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#include "qemu/osdep.h"
> +
> +#include "qemu.h"
> +
> +/*
> + * Compare with sendsig() in riscv/riscv/exec_machdep.c
> + * Assumes that target stack frame memory is locked.
> + */
> +abi_long
> +set_sigtramp_args(CPURISCVState *regs, int sig, struct target_sigframe *frame,
> +    abi_ulong frame_addr, struct target_sigaction *ka)
> +{
> +    /*
> +     * Arguments to signal handler:
> +     *  a0 (10) = signal number
> +     *  a1 (11) = siginfo pointer
> +     *  a2 (12) = ucontext pointer
> +     *  pc      = signal pointer handler
> +     *  sp (2)  = sigframe pointer
> +     *  ra (1)  = sigtramp at base of user stack
> +     */
> +
> +     regs->gpr[10] = sig;
> +     regs->gpr[11] = frame_addr +
> +         offsetof(struct target_sigframe, sf_si);
> +     regs->gpr[12] = frame_addr +
> +         offsetof(struct target_sigframe, sf_uc);

xA0 .. xA2

> +     regs->pc = ka->_sa_handler;
> +     regs->gpr[2] = frame_addr;
> +     regs->gpr[1] = TARGET_PS_STRINGS - TARGET_SZSIGCODE;

xRA, xSP.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

