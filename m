Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CE7C52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsMq-0001wx-40; Fri, 02 Aug 2024 09:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsMk-0001rG-ME
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:30:42 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsMi-0008LS-PO
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:30:42 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7104f939aa7so2622572b3a.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 06:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722605439; x=1723210239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lJF6OXA8C/Y1QICtD5IvcceFO/fI3pk8Ew6d8EDRZFA=;
 b=x3ne/9MnK8pEUvTeRf5+V9Dl3398l5yGAFmBzKLdBxmMDGVnb/NZ0KtZLRdeQqU9oz
 0Wt92YIurqJiM6rCHBalABvzlM4nSPP+mW9DV4WHKlRo6LCfYeEWm4HR3AkDZ7sgzyco
 W2uck+5idieeziJUXFlupaE58X1j+mBqwk/OIOC7najF2JmkvFoKTOPTVBzFCNgIsuhf
 WBu9lXTwR1X4Ijq9L0nwR1TVtweVIuR3O/bn2DHaW/vRsxjPtTim1xrrwnQ3U/TcbgV0
 0nArxbvlvOhCQFzfu91MEzTLNRTVnQD78obAknnzKVDYpyzNOtmEKaeveviYX9ct17DI
 skVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722605439; x=1723210239;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lJF6OXA8C/Y1QICtD5IvcceFO/fI3pk8Ew6d8EDRZFA=;
 b=KI7ooXt51lxnb/5rrf3A69ELO2yQNk/wYRn/ib3uwBYzoIaj3V4eKgcy4sRm+kwqxK
 ZIVvfwGd9GDs6rlyDwWocGXD0MZgh/u9RiL8Wde9LErUD+0GeY8/Buk12nEN24tKw+EK
 d7wJBh4s2v0GUk3pB2CDpF8S3FY78QTN8rD6OZT0PMi1kLB9bVLlf0hk21ObIHbUT5AL
 RvCDLoIGZhe/37Q4vR/+V7B/rM6dc+uG4JpIHoutX+AX97UEWTXEnoDdHJZati2v2AV0
 KRkYCuKxKVHJVNSiHfhUeVNrKnS8643vBmEGt1a8QDhLJUeYlxPtmmWg8kJTYIWXJIoP
 Y92A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP9+YpFFKN5fnZjrZuebt1Gtcd9LdAYgMBIJopua7Lly2GQQ9xQ0dxQhaWh2q2PawUvcoRL4cFcYexFcR1QEdDmMXJTdQ=
X-Gm-Message-State: AOJu0YxxZgDy+qGtRY7EzN7C/DXeqqXxYOSz/8yMCTHy1u7eiUqUzR/O
 cSpGOwsyyR6/o0kyeoy5J7zvBAEfU7Baxq3Gfx4QFk/o6BwD1CJN47CQ4vTpv+Y=
X-Google-Smtp-Source: AGHT+IGkpjgZFzgJaJu7jPFFw2ZF59idNuvh4gdLC9lapOlPQyhndBdjB9xC2jkqmHf2wLZ6PWWu1g==
X-Received: by 2002:a05:6a00:14c8:b0:706:31d9:9c99 with SMTP id
 d2e1a72fcca58-7106cdceb8emr5244159b3a.0.1722605438900; 
 Fri, 02 Aug 2024 06:30:38 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec01cfesm1351579b3a.4.2024.08.02.06.30.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 06:30:38 -0700 (PDT)
Message-ID: <4cdcacde-a5f8-4365-bd6c-65e98a77eada@linaro.org>
Date: Fri, 2 Aug 2024 23:30:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/18] bsd-user: Add RISC-V thread setup and
 initialization support
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
 <20240802083423.142365-11-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802083423.142365-11-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
> Implemented functions for setting up and initializing threads in the
> RISC-V architecture.
> The 'target_thread_set_upcall' function sets up the stack pointer,
> program counter, and function argument for new threads.
> The 'target_thread_init' function initializes thread registers based on
> the provided image information.
> 
> Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
> Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
> ---
>   bsd-user/riscv/target_arch_thread.h | 47 +++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
>   create mode 100644 bsd-user/riscv/target_arch_thread.h
> 
> diff --git a/bsd-user/riscv/target_arch_thread.h b/bsd-user/riscv/target_arch_thread.h
> new file mode 100644
> index 0000000000..faabb9fb45
> --- /dev/null
> +++ b/bsd-user/riscv/target_arch_thread.h
> @@ -0,0 +1,47 @@
> +/*
> + *  RISC-V thread support
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
> +
> +#ifndef TARGET_ARCH_THREAD_H
> +#define TARGET_ARCH_THREAD_H
> +
> +/* Compare with cpu_set_upcall() in riscv/riscv/vm_machdep.c */
> +static inline void target_thread_set_upcall(CPURISCVState *regs,
> +    abi_ulong entry, abi_ulong arg, abi_ulong stack_base,
> +    abi_ulong stack_size)
> +{
> +    abi_ulong sp;
> +
> +    sp = (abi_ulong)(stack_base + stack_size) & ~(16 - 1);
> +
> +    regs->gpr[xSP] = sp;
> +    regs->pc = entry;
> +    regs->gpr[xA0] = arg;
> +}
> +
> +/* Compare with exec_setregs() in riscv/riscv/machdep.c */

exec_machdep.c.

> +static inline void target_thread_init(struct target_pt_regs *regs,
> +    struct image_info *infop)
> +{
> +    regs->sepc = infop->entry;
> +    regs->regs[xRA] = infop->entry;
> +    regs->regs[10] = infop->start_stack;               /* a0 */

xA0

> +    regs->regs[xSP] = infop->start_stack & ~(16 - 1);

ROUND_DOWN.


r~

