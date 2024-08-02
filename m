Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9875C52D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZs6Q-0005dg-9d; Fri, 02 Aug 2024 09:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZs6O-0005cz-FZ
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:13:48 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZs6M-0004Dq-H5
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:13:48 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fc4fccdd78so62586215ad.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 06:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722604425; x=1723209225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DRooaxefjI9RcfAsV49nJ3qi5ReQaV9SUmPfpB9X+fs=;
 b=taoEfTcr0Ab9aHzCgNSGRO8cvXPoGszWEjQ17zcxR9nQLU3yeESl7+O3mpTU35W5GA
 V2mFxYV/PKGybmrfZBkvpANI3rx2nFPVoknm2MDrVDt9fDwWJ1XYxiFruqWUVSIqTopW
 NGZpylsgXZ8z+aLLjn/ujsKR9oCazuwt+5aRfhH9vTJAGmecYMh4J7m2RiGJSyRRiI7r
 ceRDXlbKIKKl1wGXPeGBs4zR4FQJ/1T5CQ96H5QlHPQCc/qEfBbhFXNLLwWzzqcWKcDL
 IqY2iGIXNtugDUMmSlTjl5UmPtiQYwBny2nyMWTf1FXfOY0Vm5XjmPQewQGGnOwWxfxg
 Vq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722604425; x=1723209225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DRooaxefjI9RcfAsV49nJ3qi5ReQaV9SUmPfpB9X+fs=;
 b=Bjg2B44+cn5tr0nfQ1kyYX4zG3xgiWR8xpAzPA042MhEimT6f1zyGzGvTKWy/WWjZV
 tq4xNE+0k6e3/IA0aaG4e8+a/KvCPsAZ+1CrQsx9qMgFNGpoNsCPbpXUf8N4v6ZTnr2S
 yCdqpoK2HmwHx7zVP0yZpbMrVW/1IWpssADrqvJeULzvb/Cfl/94NCGYqaGqJQ9e7zwk
 u5F8U2FZf8SiMi9IumLITaR7LoyuzqizEcp6XEJqbyUQ5UV+sKWXIo5HqJmkZ1w/4vLK
 FbVM1XxaKT505HGGnfRlNAnxJRnMZJVptUlK1794HGzfyux2yD/ZbP92KYQlcWQ29UFG
 dI6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3AcEClu8GpUKdn9b3dw+/Bz316lM/R4LLd/rlQ/JUxXyvyhfzyG6fruOKRQL97AJqsEq7MIao9N5tG3f9liwtOwVRNUI=
X-Gm-Message-State: AOJu0YzLTq+WoyBxQzfdGTPQ5BGRF5bkWDrXNQG78VJ1VgqiIIs7MczT
 4RmGUG9nhFC0fjrY0nvuNk+qgnOeiVO8Y22YoxNexXYokMxbYkq6nPQR3s45spQ=
X-Google-Smtp-Source: AGHT+IETVFufOrAl8bV3FcezOtDIFInxWKV9+Mx/glaG/Xqq19A/UlHewx5W53+RZkLrM8GS+4emTg==
X-Received: by 2002:a17:903:32c9:b0:1ff:52c:34ce with SMTP id
 d9443c01a7336-1ff574cac78mr45188215ad.53.1722604424391; 
 Fri, 02 Aug 2024 06:13:44 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f272f0sm16788005ad.4.2024.08.02.06.13.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 06:13:43 -0700 (PDT)
Message-ID: <3f7dc025-2589-4ca0-b13c-55b12e11ca61@linaro.org>
Date: Fri, 2 Aug 2024 23:13:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] bsd-user: Add RISC-V ELF definitions and hardware
 capability detection
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
 <20240802083423.142365-7-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802083423.142365-7-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
> Introduced RISC-V specific ELF definitions and hardware capability
> detection.
> Additionally, a function to retrieve hardware capabilities
> ('get_elf_hwcap') is implemented, which returns the common bits set in
> each CPU's ISA strings.
> 
> Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
> ---
>   bsd-user/riscv/target_arch_elf.h | 48 ++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
>   create mode 100644 bsd-user/riscv/target_arch_elf.h
> 
> diff --git a/bsd-user/riscv/target_arch_elf.h b/bsd-user/riscv/target_arch_elf.h
> new file mode 100644
> index 0000000000..dfb2a3e32e
> --- /dev/null
> +++ b/bsd-user/riscv/target_arch_elf.h
> @@ -0,0 +1,48 @@
> +/*
> + *  RISC-V ELF definitions
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
> +#ifndef TARGET_ARCH_ELF_H
> +#define TARGET_ARCH_ELF_H
> +
> +#define elf_check_arch(x) ((x) == EM_RISCV)
> +#define ELF_START_MMAP 0x80000000
> +#define ELF_ET_DYN_LOAD_ADDR    0x100000
> +#define ELF_CLASS   ELFCLASS64
> +
> +#define ELF_DATA    ELFDATA2LSB
> +#define ELF_ARCH    EM_RISCV
> +
> +/*
> + * Note: FreeBSD returns things a litle differently than this, but this is as
> + * close we have in the emulator. The FreeBSD/riscv64 kernel (in identcpu.c)
> + * returns the common bits set in each of the CPUs' ISA strings. Also, unlike
> + * linux, we don't mask out specific bits.

Given that all user-only cpus are identical, all bits are common.
So this really is identical to the freebsd kernel.

I think that this comment is more confusing than illuminating.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

