Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120AD109E521
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5W6a-00084P-Fo; Wed, 25 Mar 2026 17:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5W6Z-00083X-BH
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:49:35 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5W6X-0002ID-Dp
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:49:35 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-35a094cc3e9so202264a91.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774475371; x=1775080171; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=svEIMfcV1hGwm2nQWkZz/3DsxNH0BPRvTGZZTKu0S6E=;
 b=ba9H9Lb+Fpxc9Va5FYglKivhBNF6C+sOPynd3XxfQhInetijYl+7Dul3rnjhAqlRF4
 6+f/HxWMJv0/G8PV+jvny+awy8VNHP+en2zfjTjMJcvBkV6j/6LecUqfpGx9agBbfkpa
 LRE/rDQfkzObZa+V9buYzZaF8Ixtv5wNOwLu6zHNFJZhQwLJEQj3h69c4lixqad0wMPg
 Y7z5ATm4PBnDvvDuVsl/Sqx5d1tcTWmVsFVD8SBjKDyLNMNIzoUpFKFszR3gBowVnhqv
 12Sz5aAgo0/7OrjcOn+oPWQJz/h4wpwoBK/NAjSU8kY/FyQ6JDq19CWJrDoxTHjxuRzN
 Br+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774475371; x=1775080171;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=svEIMfcV1hGwm2nQWkZz/3DsxNH0BPRvTGZZTKu0S6E=;
 b=BOm3iqbNduaOmhg/0DOYkSkBGsCgApi6lMkosSJBsYiTl/Peoh+seIedg4xqyHmVZE
 K85lB96aCShzlVRATfl83KnFVAZdKMHpWoaJKG+TmOb4EPLqg9pujAst6PsJ+KYQfiW9
 KWU513ZSgyaE0opZ0F5Udh5RRROheQ0Ur6gDZB7FWtemuUUyZart+a8K9YEo6bGizPyC
 u2aZDBCKQEINy2WjVpClZJh0tWb8odUx0shUO3Mdb0qzpltMLliWS9hrPx+AsOjPMqyQ
 FZYGMajNjK1+Nag1S0FpW4c5xKtwMUbBJHSxcCmi4FyRpSEsZ2Hwk+LiVeZbyiG+6JHm
 nEeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi9IylRQEL7yc2eDyn8iUnTm5L/O1nhZPUvIBv5ZrVd5HzcfwV8UmnLeOoDam+xllFQ1C6N6xcB54k@nongnu.org
X-Gm-Message-State: AOJu0YwN49XQOEW5jfQZZ1SpI8FuQIm13HjeD8/XvaNmJ3sAIYY7pfBc
 gZTCLHPdNBgpPx4dPjYufCsfin1N1dsneVwHC6a1ZPCwsSMZ9e2B1vd5Q9seQ9msJEo=
X-Gm-Gg: ATEYQzyCMbUzcA9crq7l2HRO3RxZsP+EJ1S4LdVq4b0O5V23c0+It+hGxdcNLADliGD
 l/Aujzth+QflY4C98JpofZX0WxwaP5fH1Rhp+SqbsjDUKUgR6zgcWy8I7SsIg+3AQov20GQ6Oor
 hFcbExJ4iQ8/drb5N/kQp8kr3pYPa4SJ+JyGWQmjiUTGEZm0YyTbPg8VN7/iBQnp7i93TULlzYn
 xzfsa6JGLc69+1WAiwTDwhKFnZM9DB/dVov8RY3bc1lHSBIF991P0lKUYL60pEvy+GWagd8VJ7a
 GuW/IUmFr/lqvgSZJoB62JgvcYgfjgeh+wN+fjCl+ex6M4LFTrNhyq1mMLvQ2x1EN+Lxty3+nbU
 CCnV+nidvMPhznWEZ/Vly+4kXAShde7ifTf0/L18Jg2+ySAV5x+UngSbnHCCxpW8UeVYLYBepUE
 FPio3V81yYaFdcWHAY63W4FhJh75NOzXiZe5zBiMQ8BG3AQxQ33zS4xX7ybfES/PYJatJU
X-Received: by 2002:a05:6a21:99a6:b0:39b:e321:784f with SMTP id
 adf61e73a8af0-39c4ae0936bmr5499417637.40.1774475371314; 
 Wed, 25 Mar 2026 14:49:31 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7673984212sm372550a12.30.2026.03.25.14.49.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 14:49:30 -0700 (PDT)
Message-ID: <85cd9ae9-dff2-437f-82c1-638d349c5082@linaro.org>
Date: Wed, 25 Mar 2026 14:49:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 10/10] migration: Restrict legacy
 VMSTATE_UINTTL() macros to few targets
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Alistair Francis
 <alistair.francis@wdc.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Anton Johansson <anjo@rev.ng>, Peter Xu <peterx@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260325211728.89204-1-philmd@linaro.org>
 <20260325211728.89204-11-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260325211728.89204-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/25/26 2:17 PM, Philippe Mathieu-Daudé wrote:
> Only 5 base targets use VMSTATE_UINTTL (MIPS, PPC, X86, SPARC and
> RISCV). In order to build a single binary (preliminary step toward
> heterogeneous emulation) we need to remove it, but it will take some
> time. Add a temporary TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API
> definition to keep targets not using these macros clean while we keep
> cleaning the last few targets one by one, preventing legacy uses to
> creep back in.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   configs/targets/i386-softmmu.mak     |  1 +
>   configs/targets/mips-softmmu.mak     |  1 +
>   configs/targets/mips64-softmmu.mak   |  1 +
>   configs/targets/mips64el-softmmu.mak |  1 +
>   configs/targets/mipsel-softmmu.mak   |  1 +
>   configs/targets/ppc-softmmu.mak      |  1 +
>   configs/targets/ppc64-softmmu.mak    |  1 +
>   configs/targets/riscv32-softmmu.mak  |  1 +
>   configs/targets/riscv64-softmmu.mak  |  1 +
>   configs/targets/sparc-softmmu.mak    |  1 +
>   configs/targets/sparc64-softmmu.mak  |  1 +
>   configs/targets/x86_64-softmmu.mak   |  1 +
>   include/migration/cpu.h              | 24 +++++++++++-------------
>   target/ppc/machine.c                 |  1 +
>   scripts/make-config-poison.sh        |  1 +
>   15 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
> index 38a8f85201f..048ae17fdc5 100644
> --- a/configs/targets/i386-softmmu.mak
> +++ b/configs/targets/i386-softmmu.mak
> @@ -4,3 +4,4 @@ TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
>   TARGET_XML_FILES= i386-32bit.xml
>   TARGET_LONG_BITS=32
>   TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
> +TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
> diff --git a/configs/targets/mips-softmmu.mak b/configs/targets/mips-softmmu.mak
> index 95397af9442..81990d21880 100644
> --- a/configs/targets/mips-softmmu.mak
> +++ b/configs/targets/mips-softmmu.mak
> @@ -2,3 +2,4 @@ TARGET_ARCH=mips
>   TARGET_BIG_ENDIAN=y
>   TARGET_LONG_BITS=32
>   TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
> +TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
> diff --git a/configs/targets/mips64-softmmu.mak b/configs/targets/mips64-softmmu.mak
> index f9cc41b9ed4..2f7873af06d 100644
> --- a/configs/targets/mips64-softmmu.mak
> +++ b/configs/targets/mips64-softmmu.mak
> @@ -3,3 +3,4 @@ TARGET_BASE_ARCH=mips
>   TARGET_BIG_ENDIAN=y
>   TARGET_LONG_BITS=64
>   TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
> +TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
> diff --git a/configs/targets/mips64el-softmmu.mak b/configs/targets/mips64el-softmmu.mak
> index 4e7dedc5f30..62e74f77ba5 100644
> --- a/configs/targets/mips64el-softmmu.mak
> +++ b/configs/targets/mips64el-softmmu.mak
> @@ -2,3 +2,4 @@ TARGET_ARCH=mips64
>   TARGET_BASE_ARCH=mips
>   TARGET_LONG_BITS=64
>   TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
> +TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
> diff --git a/configs/targets/mipsel-softmmu.mak b/configs/targets/mipsel-softmmu.mak
> index b0fba8a9d0a..57e556b93b8 100644
> --- a/configs/targets/mipsel-softmmu.mak
> +++ b/configs/targets/mipsel-softmmu.mak
> @@ -1,3 +1,4 @@
>   TARGET_ARCH=mips
>   TARGET_LONG_BITS=32
>   TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
> +TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
> diff --git a/configs/targets/ppc-softmmu.mak b/configs/targets/ppc-softmmu.mak
> index 867898bd47c..1e28d40b440 100644
> --- a/configs/targets/ppc-softmmu.mak
> +++ b/configs/targets/ppc-softmmu.mak
> @@ -3,3 +3,4 @@ TARGET_BIG_ENDIAN=y
>   TARGET_KVM_HAVE_GUEST_DEBUG=y
>   TARGET_XML_FILES= power-core.xml power-fpu.xml power-altivec.xml power-spe.xml
>   TARGET_LONG_BITS=32
> +TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
> diff --git a/configs/targets/ppc64-softmmu.mak b/configs/targets/ppc64-softmmu.mak
> index 10d7a2681e7..8c7171f9d5e 100644
> --- a/configs/targets/ppc64-softmmu.mak
> +++ b/configs/targets/ppc64-softmmu.mak
> @@ -6,3 +6,4 @@ TARGET_XML_FILES= power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml
>   # all boards require libfdt
>   TARGET_NEED_FDT=y
>   TARGET_LONG_BITS=64
> +TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
> diff --git a/configs/targets/riscv32-softmmu.mak b/configs/targets/riscv32-softmmu.mak
> index 26080599be7..a9cd8ae89ee 100644
> --- a/configs/targets/riscv32-softmmu.mak
> +++ b/configs/targets/riscv32-softmmu.mak
> @@ -5,3 +5,4 @@ TARGET_XML_FILES= riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml ri
>   TARGET_NEED_FDT=y
>   TARGET_LONG_BITS=32
>   TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
> +TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
> diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv64-softmmu.mak
> index 5059c550480..3f97cd6dfa5 100644
> --- a/configs/targets/riscv64-softmmu.mak
> +++ b/configs/targets/riscv64-softmmu.mak
> @@ -6,3 +6,4 @@ TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml ri
>   TARGET_NEED_FDT=y
>   TARGET_LONG_BITS=64
>   TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
> +TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
> diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-softmmu.mak
> index 126ce12abb0..0630fa54b43 100644
> --- a/configs/targets/sparc-softmmu.mak
> +++ b/configs/targets/sparc-softmmu.mak
> @@ -4,3 +4,4 @@ TARGET_XML_FILES=sparc32-cpu.xml sparc32-fpu.xml sparc32-cp0.xml
>   TARGET_LONG_BITS=32
>   TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
>   TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
> +TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
> diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
> index 4e621fb8e39..500db845ea9 100644
> --- a/configs/targets/sparc64-softmmu.mak
> +++ b/configs/targets/sparc64-softmmu.mak
> @@ -5,3 +5,4 @@ TARGET_XML_FILES=sparc64-cpu.xml sparc64-fpu.xml sparc64-cp0.xml
>   TARGET_LONG_BITS=64
>   TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
>   TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
> +TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
> diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
> index c7f8746b4f5..18b3575e4e2 100644
> --- a/configs/targets/x86_64-softmmu.mak
> +++ b/configs/targets/x86_64-softmmu.mak
> @@ -5,3 +5,4 @@ TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
>   TARGET_XML_FILES= i386-64bit.xml i386-64bit-apx.xml
>   TARGET_LONG_BITS=64
>   TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
> +TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
> diff --git a/include/migration/cpu.h b/include/migration/cpu.h
> index 05a1ddde343..4c8c9c34cc8 100644
> --- a/include/migration/cpu.h
> +++ b/include/migration/cpu.h
> @@ -3,25 +3,23 @@
>   #ifndef MIGRATION_CPU_H
>   #define MIGRATION_CPU_H
>   
> +#ifdef TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API
> +
>   #include "exec/cpu-defs.h"
> -#include "migration/qemu-file-types.h"
>   #include "migration/vmstate.h"
>   
>   #if TARGET_LONG_BITS == 64
> -#define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
> -    VMSTATE_UINT64_V(_f, _s, _v)
> -#define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
> -    VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
> +#define VMSTATE_UINTTL(_f, _s) \
> +    VMSTATE_UINT64_V(_f, _s, 0)
> +#define VMSTATE_UINTTL_ARRAY(_f, _s, _n) \
> +    VMSTATE_UINT64_ARRAY_V(_f, _s, _n, 0)
>   #else
> -#define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
> -    VMSTATE_UINT32_V(_f, _s, _v)
> -#define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
> -    VMSTATE_UINT32_ARRAY_V(_f, _s, _n, _v)
> +#define VMSTATE_UINTTL(_f, _s) \
> +    VMSTATE_UINT32_V(_f, _s, 0)
> +#define VMSTATE_UINTTL_ARRAY(_f, _s, _n) \
> +    VMSTATE_UINT32_ARRAY_V(_f, _s, _n, 0)
>   #endif
>   
> -#define VMSTATE_UINTTL(_f, _s)                                        \
> -    VMSTATE_UINTTL_V(_f, _s, 0)
> -#define VMSTATE_UINTTL_ARRAY(_f, _s, _n)                              \
> -    VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, 0)
> +#endif /* TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API */
>   
>   #endif
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 49cfdc6d674..f6169a128dc 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -5,6 +5,7 @@
>   #include "helper_regs.h"
>   #include "mmu-hash64.h"
>   #include "migration/cpu.h"
> +#include "migration/qemu-file-types.h"
>   #include "qapi/error.h"
>   #include "kvm_ppc.h"
>   #include "power8-pmu.h"
> diff --git a/scripts/make-config-poison.sh b/scripts/make-config-poison.sh
> index b4d61e8bc9e..a1c5fa77d9d 100755
> --- a/scripts/make-config-poison.sh
> +++ b/scripts/make-config-poison.sh
> @@ -12,6 +12,7 @@ exec sed -n \
>     -e '/CONFIG_SOFTMMU/d' \
>     -e '/TARGET_NOT_USING_LEGACY_LDST_PHYS_API/d' \
>     -e '/TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API/d' \
> +  -e '/TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API/d' \
>     -e '/^#define / {' \
>     -e    's///' \
>     -e    's/ .*//' \

I'm not sure it's needed to have this flag.

Indeed, it's not possible to eradicate VMSTATE_UINTTL because of 
retrocompatibility, so it will never be completely removed. Thus, you 
can leave it as it is and implement the hint mentioned on Patch 8, which 
is retrocompatible by design.

With this, no change will be needed in target code, and only migration 
and include/migration/cpu.h will need a change.

Regards,
Pierrick

