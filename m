Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62E0D15DBB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 11:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3D9U-0000XI-3Y; Tue, 22 Oct 2024 07:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t3D9Q-0000Vl-Tf
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:34:13 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t3D9O-0008G2-U7
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:34:12 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e2e6a1042dso4356792a91.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 04:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1729596849; x=1730201649; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uatBwRbZdUuRH9JbxOfOc5YcVZt42QS2AMZQu5Q7kOg=;
 b=IZJR/i9IS34Am6j6MPuvjcBwNqgnvqLJ69Dx88n5dySe+L0kXfNiTG95tXpZaj08wl
 JQ9fP1yZRpVVZXDHSixECY4HZ5V8Pw1jU7k+OK0WHitFk7Xt+jUjAlm2MskZbgWhGUxu
 vLpIZgyOnb87OWqv9zFDvDi5YJKqJLpwDrttG8fdQGU57hF42r+haMikrFwqwOsB7oW1
 EWkn9LrjMcVLOR9r5lr/IXZIrLd1kP4wY5jLIj9TrSMDO4JZGJaJe/F+eisNfXf3WBlx
 bPsL4+EOqxgyuZOl69evRJKzfMZI5j0qIPmId4Hg5Yl+QjbZFn1/KuzXoMIjl+t05LBs
 xZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729596849; x=1730201649;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uatBwRbZdUuRH9JbxOfOc5YcVZt42QS2AMZQu5Q7kOg=;
 b=F8O7jo/U8ypstr004MgVsDWU37ddN06+jCzavrAspKLzzySqeK4M6wJwy5hN3KkcWT
 Ke2nW2DFcCsK43+Yd63jZnhtmX5du4REv+2e3VlcleKYxZ98k5mE9NaFYDADBijscneb
 bv5oewF+0BSCY20s20q5LQ4i3C4+BipepOxKnZyltP4DmdM71jkTaafSOba+JPkIGAOV
 cINDzbvZhLYcIfqXPUME97to66kMZIJRa3kjFGwatHeHrFRnboFOLu9OP3iZ4L9APlyV
 cc+YRzbMn8kzbAu6R5LH+cGIWFpbvCA109qqGJVZ+/S+ZEmzbjL5e2VBwl1Q+zzY2B6V
 ervg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeCISU9vKWw2SKKaDdX/YzreilnSwnKKck1NdxQhMm91MnzzcYTf/8Y7mWCyvJhSFd7/FzFIiQBWnr@nongnu.org
X-Gm-Message-State: AOJu0YzRaEHBk3NqxBtjFIBjja2EmyF8fuPhgqUBByHdPottgl5+0kZy
 v3gHCNrwD9Q20vet1jBQ4unkuyAt72DKK1eXZSlPWKijdvzif/EjUm5gmH4zF4Q=
X-Google-Smtp-Source: AGHT+IGSsYhaExA4FWSgMzywDZ5OLf6M4lMBkZMdkVijY+l4tdp0C+1HIbBzArOH0ZMdwSBpy6/YHA==
X-Received: by 2002:a17:90b:1650:b0:2e3:191e:7ef7 with SMTP id
 98e67ed59e1d1-2e5616e8b0amr17044339a91.12.1729596848936; 
 Tue, 22 Oct 2024 04:34:08 -0700 (PDT)
Received: from [192.168.68.110] ([177.188.133.9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5e2691e4csm1385304a91.23.2024.10.22.04.34.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 04:34:08 -0700 (PDT)
Message-ID: <4a7075e0-f6a6-42bf-b0ce-5f217f98423e@ventanamicro.com>
Date: Tue, 22 Oct 2024 08:34:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/14] util: Add RISC-V vector extension probe in
 cpuinfo
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair23@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20241022001134.828724-1-richard.henderson@linaro.org>
 <20241022001134.828724-4-richard.henderson@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241022001134.828724-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 10/21/24 9:11 PM, Richard Henderson wrote:
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> 
> Add support for probing RISC-V vector extension availability in
> the backend. This information will be used when deciding whether
> to use vector instructions in code generation.
> 
> Cache lg2(vlenb) for the backend. The storing of lg2(vlenb) means
> we can convert all of the division into subtraction.
> 
> While the compiler doesn't support RISCV_HWPROBE_EXT_ZVE64X,
> we use RISCV_HWPROBE_IMA_V instead. RISCV_HWPROBE_IMA_V is more
> strictly constrainted than RISCV_HWPROBE_EXT_ZVE64X. At least in
> current QEMU implemenation, the V vector extension depends on the
> zve64d extension.
> 
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> Message-ID: <20241007025700.47259-2-zhiwei_liu@linux.alibaba.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Tested with a KVM guest running in an emulated RV host.


Tested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   host/include/riscv/host/cpuinfo.h |  2 ++
>   util/cpuinfo-riscv.c              | 34 ++++++++++++++++++++++++++++++-
>   2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/host/include/riscv/host/cpuinfo.h b/host/include/riscv/host/cpuinfo.h
> index 2b00660e36..cdc784e7b6 100644
> --- a/host/include/riscv/host/cpuinfo.h
> +++ b/host/include/riscv/host/cpuinfo.h
> @@ -10,9 +10,11 @@
>   #define CPUINFO_ZBA             (1u << 1)
>   #define CPUINFO_ZBB             (1u << 2)
>   #define CPUINFO_ZICOND          (1u << 3)
> +#define CPUINFO_ZVE64X          (1u << 4)
>   
>   /* Initialized with a constructor. */
>   extern unsigned cpuinfo;
> +extern unsigned riscv_lg2_vlenb;
>   
>   /*
>    * We cannot rely on constructor ordering, so other constructors must
> diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
> index 8cacc67645..971c924012 100644
> --- a/util/cpuinfo-riscv.c
> +++ b/util/cpuinfo-riscv.c
> @@ -4,6 +4,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/host-utils.h"
>   #include "host/cpuinfo.h"
>   
>   #ifdef CONFIG_ASM_HWPROBE_H
> @@ -13,6 +14,7 @@
>   #endif
>   
>   unsigned cpuinfo;
> +unsigned riscv_lg2_vlenb;
>   static volatile sig_atomic_t got_sigill;
>   
>   static void sigill_handler(int signo, siginfo_t *si, void *data)
> @@ -34,7 +36,7 @@ static void sigill_handler(int signo, siginfo_t *si, void *data)
>   /* Called both as constructor and (possibly) via other constructors. */
>   unsigned __attribute__((constructor)) cpuinfo_init(void)
>   {
> -    unsigned left = CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZICOND;
> +    unsigned left = CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZICOND | CPUINFO_ZVE64X;
>       unsigned info = cpuinfo;
>   
>       if (info) {
> @@ -50,6 +52,10 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>   #endif
>   #if defined(__riscv_arch_test) && defined(__riscv_zicond)
>       info |= CPUINFO_ZICOND;
> +#endif
> +#if defined(__riscv_arch_test) && \
> +    (defined(__riscv_vector) || defined(__riscv_zve64x))
> +    info |= CPUINFO_ZVE64X;
>   #endif
>       left &= ~info;
>   
> @@ -69,11 +75,22 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>   #ifdef RISCV_HWPROBE_EXT_ZICOND
>               info |= pair.value & RISCV_HWPROBE_EXT_ZICOND ? CPUINFO_ZICOND : 0;
>               left &= ~CPUINFO_ZICOND;
> +#endif
> +            /* For rv64, V is Zve64d, a superset of Zve64x. */
> +            info |= pair.value & RISCV_HWPROBE_IMA_V ? CPUINFO_ZVE64X : 0;
> +#ifdef RISCV_HWPROBE_EXT_ZVE64X
> +            info |= pair.value & RISCV_HWPROBE_EXT_ZVE64X ? CPUINFO_ZVE64X : 0;
>   #endif
>           }
>       }
>   #endif /* CONFIG_ASM_HWPROBE_H */
>   
> +    /*
> +     * We only detect support for vectors with hwprobe.  All kernels with
> +     * support for vectors in userspace also support the hwprobe syscall.
> +     */
> +    left &= ~CPUINFO_ZVE64X;
> +
>       if (left) {
>           struct sigaction sa_old, sa_new;
>   
> @@ -113,6 +130,21 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>           assert(left == 0);
>       }
>   
> +    if (info & CPUINFO_ZVE64X) {
> +        /*
> +         * We are guaranteed by RVV-1.0 that VLEN is a power of 2.
> +         * We are guaranteed by Zve64x that VLEN >= 64, and that
> +         * EEW of {8,16,32,64} are supported.
> +         */
> +        unsigned long vlenb;
> +        /* csrr %0, vlenb */
> +        asm volatile(".insn i 0x73, 0x2, %0, zero, -990" : "=r"(vlenb));
> +        assert(vlenb >= 8);
> +        assert(is_power_of_2(vlenb));
> +        /* Cache VLEN in a convenient form. */
> +        riscv_lg2_vlenb = ctz32(vlenb);
> +    }
> +
>       info |= CPUINFO_ALWAYS;
>       cpuinfo = info;
>       return info;

