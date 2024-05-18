Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0610C25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 13:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8Jk0-0005ZI-8y; Sat, 18 May 2024 09:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s8Jjx-0005Yu-U1
 for qemu-devel@nongnu.org; Sat, 18 May 2024 09:04:46 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s8Jjs-0002YY-7J
 for qemu-devel@nongnu.org; Sat, 18 May 2024 09:04:45 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e3c3aa8938so34408825ad.1
 for <qemu-devel@nongnu.org>; Sat, 18 May 2024 06:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716037478; x=1716642278; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ja4lE5SXHLzqVZjYOzV6CEw6ufW7YLiqgbVnTIF56qE=;
 b=CAHlRC1Z3mR0+ooTg2jSZOWfimzqIzkTUg4Kp/BOrxgrwClyzZ0JcjJcaqjxE/gOrx
 0FloNxpAjYct8KYkvfrvlatPY0hj+X7d6S2WuTqhqMJyncHowu3aXCcWkZ2DQJy8S3id
 xohHOm1M9tD31BwHOGlvfc0VUAsg/M4KdossrBMrgkmCOYm4+df7dm7J/KMALsN5T6w5
 xR59JO9KYKTQCRdI55DSeapSRGWEFNhp2X84TDtgMjS3m29+IKslFNVLnjM5FJnT0SMU
 eSwQN+I0y8e5sxwlkFALb7X8Cc0w4FxUixacsCb2cbPxxP8+ebUkC1BQd20x8x+BLP22
 CL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716037478; x=1716642278;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ja4lE5SXHLzqVZjYOzV6CEw6ufW7YLiqgbVnTIF56qE=;
 b=Q2nhk+R2NKRmfHmwxTajS9xgRdhzPFTaW3cajHDRdtMaqNWO1IPweVNAdr7rVXYFQD
 7E64ZhAVnwwNYb0MdGdxhY2X0ocgbP+HiZ7ua6WnF9x2HvuLKvp34CpIM6gEzQub9uVk
 /8+/ZzF/V1/nX+erZc2cTcWkk6ZYXUg4PK101bpJzao2egpNen0zczWVbJ4fVgxlqYZb
 8cSmweL9cB6jWO6lfP1//U19S9KRjPj/wM+MW0vZ72oqmnkHEVBmuamCUBfH8am5FNM7
 KUiA34/Ei2BZUINmDGxwXVhjrwFIpUlCd0yO5RSioLAb1XMqoq6qjzgSm/FW9Eb2cpMV
 59+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXJN7xqXTa2cRGXo4pyITaSjjEaDg77CaVbx3IyG6rw6VfoWTON8W5klEdBBiGydYjqkkcwsfrbfTLFbKnMktrZOalcSM=
X-Gm-Message-State: AOJu0YyOM81okaIKknbxCTpw8zHI9MaJjxdhIZnko5l8kOW7/CJun2YC
 udYegwaUXj6btlOb/cYA5KQ+kQAL/EEf7X0aFKcHPl0B6thniAUMgLPfpuP6hD4=
X-Google-Smtp-Source: AGHT+IH0eZAWLw8tCSNKlkaeGR3YWirRQ+0y8Hddf3vNUYiWFUPDNWCSBUgVwSApyeTTUlKQEbaRyg==
X-Received: by 2002:a05:6a21:2d8b:b0:1af:f6b9:e3e4 with SMTP id
 adf61e73a8af0-1aff6b9e5e8mr21057607637.12.1716037478398; 
 Sat, 18 May 2024 06:04:38 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.57])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f695362d8asm2503991b3a.148.2024.05.18.06.04.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 May 2024 06:04:38 -0700 (PDT)
Message-ID: <a1874b42-eab5-4a8d-b1ee-cbf69be41e72@ventanamicro.com>
Date: Sat, 18 May 2024 10:04:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/riscv: Move Guest irqs out of the core local
 irqs range.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com
References: <20240513114602.72098-1-rkanwal@rivosinc.com>
 <20240513114602.72098-3-rkanwal@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240513114602.72098-3-rkanwal@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 5/13/24 08:46, Rajnesh Kanwal wrote:
> Qemu maps IRQs 0:15 for core interrupts and 16 onward for
> guest interrupts which are later translated to hgiep in
> `riscv_cpu_set_irq()` function.
> 
> With virtual IRQ support added, software now can fully
> use the whole local interrupt range without any actual
> hardware attached.
> 
> This change moves the guest interrupt range after the
> core local interrupt range to avoid clash.
> 
> Fixes: 1697837ed9 ("target/riscv: Add M-mode virtual
> interrupt and IRQ filtering support.")
> Fixes: 40336d5b1d ("target/riscv: Add HS-mode virtual
> interrupt and IRQ filtering support.")
> 

As I said in patch 1, please do not split the commit titles in a
"Fixes" tag:

> Fixes: 1697837ed9 ("target/riscv: Add M-mode virtual interrupt and IRQ filtering support.")
> Fixes: 40336d5b1d ("target/riscv: Add HS-mode virtual interrupt and IRQ filtering support.")


> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---
>   target/riscv/cpu_bits.h | 3 ++-
>   target/riscv/csr.c      | 7 ++++++-
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 13ce2218d1..33f28bb115 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -664,7 +664,8 @@ typedef enum RISCVException {
>   #define IRQ_M_EXT                          11
>   #define IRQ_S_GEXT                         12
>   #define IRQ_PMU_OVF                        13
> -#define IRQ_LOCAL_MAX                      16
> +#define IRQ_LOCAL_MAX                      64
> +/* -1 is due to bit zero of hgeip and hgeie being ROZ. */
>   #define IRQ_LOCAL_GUEST_MAX                (TARGET_LONG_BITS - 1)
>   
>   /* mip masks */
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index c9d685dcc5..78f42fcae5 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1141,7 +1141,12 @@ static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
>   
>   #define VSTOPI_NUM_SRCS 5
>   
> -#define LOCAL_INTERRUPTS (~0x1FFF)
> +/* All core local interrupts except the fixed ones 0:12. This macro is for virtual
> + * interrupts logic so please don't change this to avoid messing up the whole support,
> + * For reference see AIA spec: `5.3 Interrupt filtering and virtual interrupts for
> + * supervisor level` and `6.3.2 Virtual interrupts for VS level`.
> + */

The comment format we use is capped at 80 chars per line and starts with a
leading /*  on a separated line:


> +/*
> +/* All core local interrupts except the fixed ones 0:12. This macro is
> +/* for virtual interrupts logic so please don't change this to avoid
> +/* messing up the whole support. For reference see AIA spec:
> +/* `5.3 Interrupt filtering and virtual interrupts for supervisor level`
> +/* and `6.3.2 Virtual interrupts for VS level`.
> + */

You can run ./scripts/checkpatch.pl in the generated patch file to see if the
patch is compliant with the expected code style.



Thanks,


Daniel



> +#define LOCAL_INTERRUPTS   (~0x1FFFULL)
>   
>   static const uint64_t delegable_ints =
>       S_MODE_INTERRUPTS | VS_MODE_INTERRUPTS | MIP_LCOFIP;

