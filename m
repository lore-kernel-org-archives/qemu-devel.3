Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2F9C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 02:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfsaq-0007Pf-UM; Sun, 18 Aug 2024 22:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sfsaq-0007PA-6b
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 22:58:04 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sfsao-00036q-Av
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 22:58:03 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7a0e8b76813so2938649a12.3
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 19:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724036280; x=1724641080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/sCxbbaX1hObMFIBzmxb2PIxsdzDBuo+mAOJoXAGis8=;
 b=MZwch7/5xB5B/EqO7ULWUmrd7DMKo39kjq6w5hzIyqZIp8yvdzgzvqckMmmw9q61bF
 NmPgv8Pmz5dvRCvDP98B9M8rl3rHrCFGLiYD8j8SDmD1Gm+hL+FdqBHBQGkVko9htsNk
 lT1hAqOi10hSXi7V/JzTBwcglfiqW23G3rHTpZSfa9ezyyyxRtKCQJF7elsAnquIMpkR
 IXnYVanxTy0u6iD+m0IzSTjcCJe8frRX1r9u2s1+Zt/EtByfK97NZz3Zlb1o7Z85okOu
 bMq00ezam4Qa0s/kevA3QacsF/AYeyNebR6v7FAnuARQGHKV3ugYrca4843trh/jVhDa
 ISxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724036280; x=1724641080;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/sCxbbaX1hObMFIBzmxb2PIxsdzDBuo+mAOJoXAGis8=;
 b=m8BVgWcmZfT9KNPd+5Mf6gbQKT66RwQAogH5d3I2y6sF02WiLvdgoPWdxkn/c1CNSP
 7XI7/2en3E1DBtuAuX8hEJKt1XfzPP4YiJUtOF/Tj/0XeH9/yLU7gyJN8WsQJsbWS5i1
 FaOw5RD/Lge+KmZchZNgD01zv8jocQNCsiSuBd6X0oxZAPFzBt9cfmmTnftbAQKBwIs9
 OzBVcoNj+kyw47v8FsrDpgbn7+dkOXt0eNHBWa1MLuCyPcRVFZJ8GHbfFIvYm9WKNqYH
 ZU26qz5m6pV95CkMhh2912fve71qO4FdbNXG4LrioiMjL4cKxgmTdL7Hr5jN70awXErx
 Ff7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXebUdmsMiUk7txcrkAruBJuuAujgIbWhD5LRcCFZINEVEoNsEYb+RaJyvubn6Bfkyw2dP35h71nKXADW6vuFvJC32ExSA=
X-Gm-Message-State: AOJu0YyARWv3xNGAM9TaDvaWnR8grDuprOrdEb1aALqH7drZBiVHPh60
 ooockpL3ew0+eHn77JtH+1+HwuCpcRVG9MtZwwdnSnofMuDJxFZpSZLKeRQT3r8/mOvFzoR2A0t
 cpzlM9g==
X-Google-Smtp-Source: AGHT+IGnq1NPW/V9oG5DYL9xYb1PdlUKPmRWdqpvBnWntvmxSKH0mAjk4KUBkXCoRONtqQMW1szoaA==
X-Received: by 2002:a05:6a21:398a:b0:1c3:acd1:5cdd with SMTP id
 adf61e73a8af0-1c905053531mr12564013637.47.1724036279423; 
 Sun, 18 Aug 2024 19:57:59 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f031bc0fsm55693335ad.101.2024.08.18.19.57.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Aug 2024 19:57:59 -0700 (PDT)
Message-ID: <5944345c-6e71-46b4-b323-d3804ed8f04f@linaro.org>
Date: Mon, 19 Aug 2024 12:57:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/17] bsd-user: Implement RISC-V CPU initialization
 and main loop
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240816170949.238511-1-itachis@FreeBSD.org>
 <20240816170949.238511-2-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240816170949.238511-2-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 8/17/24 03:09, Ajeet Singh wrote:
> From: Mark Corbin <mark@dibsco.co.uk>
> 
> Added the initial implementation for RISC-V CPU initialization and main
> loop. This includes setting up the general-purpose registers and
> program counter based on the provided target architecture definitions.
> 
> Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
> ---
>   bsd-user/riscv/target_arch_cpu.h | 39 ++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
>   create mode 100644 bsd-user/riscv/target_arch_cpu.h
> 
> diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
> new file mode 100644
> index 0000000000..28f56560e0
> --- /dev/null
> +++ b/bsd-user/riscv/target_arch_cpu.h
> @@ -0,0 +1,39 @@
> +/*
> + *  RISC-V CPU init and loop
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
> +#ifndef TARGET_ARCH_CPU_H
> +#define TARGET_ARCH_CPU_H
> +
> +#include "target_arch.h"
> +
> +#define TARGET_DEFAULT_CPU_MODEL "max"
> +
> +static inline void target_cpu_init(CPURISCVState *env,
> +        struct target_pt_regs *regs)
> +{
> +    int i;
> +
> +    for (i = 0; i < 32; i++) {
> +        env->gpr[i] = regs->regs[i];

Again, r0 is zero.  Clearer if we never set that outside of reset.

r~

> +    }
> +
> +    env->pc = regs->sepc;
> +}
> +
> +#endif /* TARGET_ARCH_CPU_H */


