Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BD2C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 22:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOlnN-0003iZ-7W; Tue, 02 Jul 2024 18:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOlnH-0003bJ-Dy
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 18:16:12 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOlnB-00019h-Rr
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 18:16:10 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-6c5bcb8e8edso3905161a12.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 15:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719958564; x=1720563364; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IpYGeMoHXXx9o7qsPLEmznXVSgvR1hH8hEmynS0g+3c=;
 b=DiUs5X5Dda6IhYOjKyf75FY5g13kWD+riOix+lrsr0mLU9SJZ/cGV/Wcw5dCB5udJ3
 /sTcHViKgzlq/Q2nFG6/CBbKhOsb5JyaDA4U11Im91TCxP5RaRwj//l2P6r2UbEJaJeH
 TqpNXBEX6gdt1oaAZPAKl+3NQ8GJtws/BPd/6hEJPaUexzCPRyASXH7pO0XC1VvPioC2
 iWXshDO6u7eVKbXH9oyvVNDUEzj4r/yPMiQGtQ0mHGX7e9E9vYfLEGpbY+T1EtZPxEqf
 wnGIUGfDhNC57+2kWyZWm8Zb74hIZCpfa5onH6BqKi7jr67IETyXkd7AwdXTGerc4NOk
 bLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719958564; x=1720563364;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IpYGeMoHXXx9o7qsPLEmznXVSgvR1hH8hEmynS0g+3c=;
 b=c4MRnsF6zGmGOMPA1Ui402ECMlqAfwPu1LHIwVQ2E/GB3Nt+cJwRwU2y76HZAIXqRx
 vTLlX2ezfb1SzPl27/zCFhmFc/PgCiZQK3QHOY4GPg9GVf6lbL8fgaIswcxQqABJACFP
 O1u9xzXxtsvlwAKFLyM9zvK1CayNGNYrW+zuPY8cyijuHUG2regHWec9Af+K3qNj1nii
 w97SLbiZI1vRudEq8MLSRW4EfNVzCjL826+uafcr14GMZE64r32T/yo0yUQcnypz5H1V
 KUjljGroM3uvRxOzgcyXjNCADXG9v7q9mvk4HaxrEwAy5Pt7W+HKTkVFy4pj1K9Y0Tid
 5KkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8knkk2Z6Hw+QtQWkhvaW3WT9XAvIvDawVLgaUfurHSqRgwp+hMGaqQmUv3pTj0d+V7ZkPnftA+nWJ/DwoyOnUYM67cPc=
X-Gm-Message-State: AOJu0Yzhc0VzwD5FLlDDz8G1hdi4P0h5IzKu64YFq8fj26pIARptBqGk
 ORmRvHo/zeKfTtqc9f7YaiIQtCVRxEjyIAYfPqJPP9kG2YTu6w++MiPEaAYsBdo=
X-Google-Smtp-Source: AGHT+IF8tYcPh7g3XZIpZeJP9/DH2FsZ2H6hbhYAG2+YAlMjUBYlyxwcBEg6u1yy/zw3XgmtP8XEkQ==
X-Received: by 2002:a05:6a20:da88:b0:1c0:bd3d:6d20 with SMTP id
 adf61e73a8af0-1c0bd3d7228mr817681637.14.1719958563680; 
 Tue, 02 Jul 2024 15:16:03 -0700 (PDT)
Received: from [192.168.68.109] ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1535b1esm89584265ad.140.2024.07.02.15.16.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 15:16:03 -0700 (PDT)
Message-ID: <793a6bbe-5ac6-400c-b02b-9893a8887ee0@ventanamicro.com>
Date: Tue, 2 Jul 2024 19:15:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] util/cpuinfo-riscv: Use linux __riscv_hwprobe syscall
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: brad@comstyle.com, Alistair.Francis@wdc.com, palmer@dabbelt.com,
 qemu-riscv@nongnu.org
References: <20240627180350.128575-1-richard.henderson@linaro.org>
 <20240627180350.128575-4-richard.henderson@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240627180350.128575-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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



On 6/27/24 3:03 PM, Richard Henderson wrote:
> With recent linux kernels, there is a syscall to probe for various
> ISA extensions.  These bits were phased in over several kernel
> releases, so we still require checks for symbol availability.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   meson.build          |  6 ++++++
>   util/cpuinfo-riscv.c | 26 ++++++++++++++++++++++++++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 97e00d6f59..58afd0125d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2837,6 +2837,12 @@ have_cpuid_h = cc.links('''
>     }''')
>   config_host_data.set('CONFIG_CPUID_H', have_cpuid_h)
>   
> +# Don't bother to advertise asm/hwprobe.h for old versions that do
> +# not contain RISCV_HWPROBE_EXT_ZBA.
> +config_host_data.set('CONFIG_ASM_HWPROBE_H',
> +                     cc.has_header_symbol('asm/hwprobe.h',
> +                                          'RISCV_HWPROBE_EXT_ZBA'))
> +

FWIW I looked around Linux and I think we can snapshot hwprobe support by
checking for RISCV_HWPROBE_KEY_IMA_EXT_0 (Linux commit 162e4df137c) if we
ever need hwprobe for exts earlier than ZBA (C and V).

Checking for ZBA is fine for this patch though.


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   config_host_data.set('CONFIG_AVX2_OPT', get_option('avx2') \
>     .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX2') \
>     .require(cc.links('''
> diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
> index abf799794f..cf59ce83a3 100644
> --- a/util/cpuinfo-riscv.c
> +++ b/util/cpuinfo-riscv.c
> @@ -6,6 +6,11 @@
>   #include "qemu/osdep.h"
>   #include "host/cpuinfo.h"
>   
> +#ifdef CONFIG_ASM_HWPROBE_H
> +#include <asm/hwprobe.h>
> +#include <sys/syscall.h>
> +#endif
> +
>   unsigned cpuinfo;
>   static volatile sig_atomic_t got_sigill;
>   
> @@ -47,6 +52,27 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>   #endif
>       left &= ~info;
>   
> +#ifdef CONFIG_ASM_HWPROBE_H
> +    if (left) {
> +        /*
> +         * TODO: glibc 2.40 will introduce <sys/hwprobe.h>, which
> +         * provides __riscv_hwprobe and __riscv_hwprobe_one,
> +         * which is a slightly cleaner interface.
> +         */
> +        struct riscv_hwprobe pair = { .key = RISCV_HWPROBE_KEY_IMA_EXT_0 };
> +        if (syscall(__NR_riscv_hwprobe, &pair, 1, 0, NULL, 0) == 0
> +            && pair.key >= 0) {
> +            info |= pair.value & RISCV_HWPROBE_EXT_ZBA ? CPUINFO_ZBA : 0;
> +            info |= pair.value & RISCV_HWPROBE_EXT_ZBB ? CPUINFO_ZBB : 0;
> +            left &= ~(CPUINFO_ZBA | CPUINFO_ZBB);
> +#ifdef RISCV_HWPROBE_EXT_ZICOND
> +            info |= pair.value & RISCV_HWPROBE_EXT_ZICOND ? CPUINFO_ZICOND : 0;
> +            left &= ~CPUINFO_ZICOND;
> +#endif
> +        }
> +    }
> +#endif /* CONFIG_ASM_HWPROBE_H */
> +
>       if (left) {
>           struct sigaction sa_old, sa_new;
>   

