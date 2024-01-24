Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0FBC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 23:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSmmm-0007Xh-9L; Wed, 24 Jan 2024 18:36:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <johnstra10@gmail.com>)
 id 1rSmmk-0007XZ-Tl
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:35:59 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <johnstra10@gmail.com>)
 id 1rSmmh-0005oe-QW
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:35:58 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d71207524dso26975255ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 15:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706139353; x=1706744153; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PIVjt+ckhj1BFpTJ8aRt1qPg1YE2IlwSqtIt2kv4zxA=;
 b=UnscIFZp7ak75tRyJg2iqB5u9bJ4Rq9ufcWJo9iozm+VChCx7KQ7EW3/gMNRkHy5Og
 RZEeFwykrMFwX3gLstfnJB7soDDnT22qljs5w3yjH+9kALo1H86b6u60HlaYheePJ8hN
 PtXgPsPYnHmPvfEzQgEsSvv7vXZK7AvrOy6RQgYLGVsg15DVqpmHS8Lq0/Ys3X9YSWPE
 f4zmKAKCKfJYOCgVLhnyCKaGY70w/x4Wl3K3zjyB4F7whRT3Ss/35wAvoDuF8jurYGrW
 Sq9VU4YpCIk8S6+CFbw6q1SnFXJDMlg9+TXfoverqCZ0aqBjkZv1x7ltHH0PvN1PcOsH
 ZAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706139353; x=1706744153;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PIVjt+ckhj1BFpTJ8aRt1qPg1YE2IlwSqtIt2kv4zxA=;
 b=xD5iF3qoGt8UAS9cVhT5fcCu/8mA3cH4+BJDxFcXmw9Es1SPBEPDgJfIQ8MWhj8ppR
 lbG3cbqbeR8Sds6OW93LpG7e9WKzTMLFhbLX3jTaMCVMYDgVkdLJ+V2lcswvgnoR0zUx
 OIWEvyQEfQKRMEr/KYFD2ChJ+f85KGrNTdp5YCMBCQKbUnwL0haTCOTjwH3DTDYMiSE1
 /5HvBQZomBjntzzActN73dBeMaiGYMnb53ycHPO61sHDIvDZCVDW9cT5WBlq245bMShZ
 O5XPsOT5kL6mBiKEoBSXP4JyIMQl15yfyTP45e1y+afnpwz1JZJoXabRo+r5DyXHD1jw
 BhNw==
X-Gm-Message-State: AOJu0YykkyzVxz1EVFN++L2+7oQ7h23NzYkqx9rlYDAq6+pgmh9FZfnz
 UqtrOqy671yTywlt0iLnEC8Y/4IuahFzLm6wGy+Gm4Xvmcs/7W0Kekb2baKJVos=
X-Google-Smtp-Source: AGHT+IEwrfEp+0REui4enSInxX02dQeo8keqkLr+H3SDJ/s+vyuykKTI4jnRkvazKmDG2P53Os11eA==
X-Received: by 2002:a17:902:cecb:b0:1d4:3734:3dc5 with SMTP id
 d11-20020a170902cecb00b001d437343dc5mr185011plg.48.1706139353440; 
 Wed, 24 Jan 2024 15:35:53 -0800 (PST)
Received: from [50.34.46.225] ([50.34.46.225])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a170902bcc100b001d75cd8e3c0sm4691459pls.130.2024.01.24.15.35.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 15:35:53 -0800 (PST)
Message-ID: <b60c850d-bbc8-45dd-92c5-f16273740225@gmail.com>
Date: Wed, 24 Jan 2024 15:35:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] accel/kvm: Define KVM_ARCH_HAVE_MCE_INJECTION in each
 target
Content-Language: en-US
To: qemu-devel@nongnu.org
References: <20240124155425.73195-1-philmd@linaro.org>
 <20240124155425.73195-2-philmd@linaro.org>
From: john strange <johnstra10@gmail.com>
In-Reply-To: <20240124155425.73195-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=johnstra10@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

It might be good to replace "MCE" in kvm-all.c with a generic 
abstraction for error injection to avoid carrying the MCE constructs 
into non-x86 sigbus handlers.

thanks,
-john

On 1/24/24 07:54, Philippe Mathieu-Daudé wrote:
> Instead of having KVM_HAVE_MCE_INJECTION optionally defined,
> always define KVM_ARCH_HAVE_MCE_INJECTION for each target,
> and set KVM_HAVE_MCE_INJECTION if it is not zero.
>
> It is now clearer for KVM targets to detect if they lack the
> MCE injection implementation. Also, moving headers around
> is no more painful, because if a target neglects to define
> KVM_ARCH_HAVE_MCE_INJECTION, the build will fail.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> I'd rather keep "cpu-param.h" simple/short.
>
> Is a per-target "kvm-param.h" any better?
> Or per-target "accel-param.h"? For example TCG_GUEST_DEFAULT_MO
> is TCG specific and could also go there. Otherwise it will go
> in "cpu-param.h".
> ---
>   include/sysemu/kvm.h         | 5 +++++
>   target/arm/cpu-param.h       | 5 +++++
>   target/arm/cpu.h             | 4 ----
>   target/i386/cpu-param.h      | 2 ++
>   target/i386/cpu.h            | 2 --
>   target/loongarch/cpu-param.h | 2 ++
>   target/mips/cpu-param.h      | 2 ++
>   target/ppc/cpu-param.h       | 2 ++
>   target/riscv/cpu-param.h     | 2 ++
>   target/s390x/cpu-param.h     | 2 ++
>   10 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index d614878164..2e9aa2fc53 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -212,6 +212,7 @@ int kvm_on_sigbus(int code, void *addr);
>   
>   #ifdef NEED_CPU_H
>   #include "cpu.h"
> +#include "cpu-param.h"
>   
>   void kvm_flush_coalesced_mmio_buffer(void);
>   
> @@ -349,6 +350,10 @@ bool kvm_vcpu_id_is_valid(int vcpu_id);
>   /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
>   unsigned long kvm_arch_vcpu_id(CPUState *cpu);
>   
> +#if KVM_ARCH_HAVE_MCE_INJECTION
> +#define KVM_HAVE_MCE_INJECTION
> +#endif
> +
>   #ifdef KVM_HAVE_MCE_INJECTION
>   void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
>   #endif
> diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
> index f9b462a98f..d71cc29864 100644
> --- a/target/arm/cpu-param.h
> +++ b/target/arm/cpu-param.h
> @@ -30,7 +30,12 @@
>    */
>   # define TARGET_PAGE_BITS_VARY
>   # define TARGET_PAGE_BITS_MIN  10
> +#endif
>   
> +#ifdef TARGET_AARCH64
> +#define KVM_ARCH_HAVE_MCE_INJECTION 1
> +#else
> +#define KVM_ARCH_HAVE_MCE_INJECTION 0
>   #endif
>   
>   #endif
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index ec276fcd57..f92c8d3b88 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -30,10 +30,6 @@
>   /* ARM processors have a weak memory model */
>   #define TCG_GUEST_DEFAULT_MO      (0)
>   
> -#ifdef TARGET_AARCH64
> -#define KVM_HAVE_MCE_INJECTION 1
> -#endif
> -
>   #define EXCP_UDEF            1   /* undefined instruction */
>   #define EXCP_SWI             2   /* software interrupt */
>   #define EXCP_PREFETCH_ABORT  3
> diff --git a/target/i386/cpu-param.h b/target/i386/cpu-param.h
> index 911b4cd51b..5933b0b756 100644
> --- a/target/i386/cpu-param.h
> +++ b/target/i386/cpu-param.h
> @@ -24,4 +24,6 @@
>   #endif
>   #define TARGET_PAGE_BITS 12
>   
> +#define KVM_ARCH_HAVE_MCE_INJECTION 1
> +
>   #endif
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 7f0786e8b9..230ab1cded 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -33,8 +33,6 @@
>   /* The x86 has a strong memory model with some store-after-load re-ordering */
>   #define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
>   
> -#define KVM_HAVE_MCE_INJECTION 1
> -
>   /* support for self modifying code even if the modified instruction is
>      close to the modifying instruction */
>   #define TARGET_HAS_PRECISE_SMC
> diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
> index cfe195db4e..f69a94e6b5 100644
> --- a/target/loongarch/cpu-param.h
> +++ b/target/loongarch/cpu-param.h
> @@ -14,4 +14,6 @@
>   
>   #define TARGET_PAGE_BITS 12
>   
> +#define KVM_ARCH_HAVE_MCE_INJECTION 0
> +
>   #endif
> diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
> index 594c91a156..45c885e00e 100644
> --- a/target/mips/cpu-param.h
> +++ b/target/mips/cpu-param.h
> @@ -30,4 +30,6 @@
>   #define TARGET_PAGE_BITS_MIN 12
>   #endif
>   
> +#define KVM_ARCH_HAVE_MCE_INJECTION 0
> +
>   #endif
> diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
> index 0a0416e0a8..9975ae73ab 100644
> --- a/target/ppc/cpu-param.h
> +++ b/target/ppc/cpu-param.h
> @@ -33,4 +33,6 @@
>   #endif
>   #define TARGET_PAGE_BITS 12
>   
> +#define KVM_ARCH_HAVE_MCE_INJECTION 0
> +
>   #endif
> diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
> index b2a9396dec..e6199f4f6d 100644
> --- a/target/riscv/cpu-param.h
> +++ b/target/riscv/cpu-param.h
> @@ -28,4 +28,6 @@
>    *  - M mode HLV/HLVX/HSV 0b111
>    */
>   
> +#define KVM_ARCH_HAVE_MCE_INJECTION 0
> +
>   #endif
> diff --git a/target/s390x/cpu-param.h b/target/s390x/cpu-param.h
> index 84ca08626b..4728b3957e 100644
> --- a/target/s390x/cpu-param.h
> +++ b/target/s390x/cpu-param.h
> @@ -13,4 +13,6 @@
>   #define TARGET_PHYS_ADDR_SPACE_BITS 64
>   #define TARGET_VIRT_ADDR_SPACE_BITS 64
>   
> +#define KVM_ARCH_HAVE_MCE_INJECTION 0
> +
>   #endif

