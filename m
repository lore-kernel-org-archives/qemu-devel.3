Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9F8C282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 00:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tugtX-0008Tf-Qj; Tue, 18 Mar 2025 20:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tugtT-0008TF-Ig
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:02:48 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tugtR-0001QL-AS
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:02:47 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-223a7065ff8so28747675ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 17:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742342563; x=1742947363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qyU3nmowUbI3PjJImrgVYnqyEM6xSEkF1bEg7NmyCjo=;
 b=xPuuariWoXHmwA3SsO325W5gXLE5/U/VEc90v1JUAw0JkV2GQdgrd6rEmbhAgJ0TyU
 3O4SOQRS11PAx02Ip+NkEkjjcj4/zpWuQF8lp3XQQ8S/Je+sDtUN+09Vt/Da6EN6rIIO
 FySYqjgahfdmsmLA69cD6+ovDjbI5IUz2ErDiZOFuoFOH4W0n5jJygCmW/x1twgEN27v
 saiog8sBdAGf6X53FmxNQTB5RfZIXluJdLb2+czQvPivvF4+Xj8xNWCItZvY3hvPFzRy
 R4edskrbjMdPGWLvfHHDOaO9KO13hIUBMNMhtzcuH/LAaSzFZq6fGxd1s5o/LlKkXtlr
 6F4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742342563; x=1742947363;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qyU3nmowUbI3PjJImrgVYnqyEM6xSEkF1bEg7NmyCjo=;
 b=gLnw5ZbiiC3yVe7GhhZvWnoFMJtUICD5fjZDeb1o6ppXICQCsnIPL3jSLUDIm5zgoV
 0meEeDrTLr3AWO9Q3yvqrlVwVbSJT2bHuAeN0kMS30fJ1fOtYHbfbdMpcxMiegQA7jUj
 HIa2DEqNE/L2Ca3jJ3xKhGUumCtUbKhOAgnTChW3zOUNUlP2BwBq1Xm2yVvmcsMSnI2t
 vp0LYA4TbL3ZSK/LZtRlGtpzwyZrM9KDggu8mLoh2rd/0JYBH5zUld6mTfVTnMHerbuK
 7qM52LSHw/acWQSXk+Bou413yLtsAR5rHtegUWagUM0dQd8mlwyowNLwdr7bI6BTzVcN
 G5+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWckZaxwZBOZBPY0CJuLlJwVOQlod3xY/ngjhlqL9zs3iklwFU0QwBKZmK5lrgftYAEWlfVzmc0yc7m@nongnu.org
X-Gm-Message-State: AOJu0Yy1wWY470/LHNOG7CYPvTUNC0onHviflq5tYWCz2s+1PIFEfB2Z
 6C6TWpMKRZ2XKStj3mlkKOwoX3gSlVOeN1abTI27R5A6+oHhcNJgEhVezGH8sSg=
X-Gm-Gg: ASbGncugwNcZaU3skw8AYrLGT5tQ6I/kBzOq9B3mF575XnOv2h5MD9XqsqsraLc0GdT
 iczjjK50A1nnT2HCYJXT4t83vxu22TAkJOLhNM1nO1Q/dSV56GhwBeoj1g7ryC80LCwcbEvetXr
 F0qf+TF6XdQHrFonUL5wAU9kcI0lt7+auUYZFQ/FHzkjOzbALj+G0pFbKDMCTkprW5XsLfH+D1f
 SQP6IlBcVnaZw5SdLoVR1NQY6duojLiw6jA6HAFKbUW0oX6GO7AWIyBwRfaQQEHq4pXhoCUZiIj
 BMcwrU0vIDr9ecnD4Wo8Qmc0DAKG3j3m/CoGLsi+45WgDxLGx9ihQfS4Rg==
X-Google-Smtp-Source: AGHT+IEb3mGX2pAhqaX0gpNa/lSwXHfjQDw8AeNWjDDIphosB3ozDr3SSm42rYAsnMpnjlXcCjDvxg==
X-Received: by 2002:a17:902:ea03:b0:21f:617a:f1b2 with SMTP id
 d9443c01a7336-22649a809e4mr8945905ad.46.1742342562610; 
 Tue, 18 Mar 2025 17:02:42 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bbfdfesm101440545ad.203.2025.03.18.17.02.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 17:02:42 -0700 (PDT)
Message-ID: <c76d7019-7087-4522-9b49-bc99fa71436f@linaro.org>
Date: Tue, 18 Mar 2025 17:02:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/42] include/exec: Split out cpu-mmu-index.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250318213209.2579218-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 3/18/25 14:31, Richard Henderson wrote:
> The implementation of cpu_mmu_index was split between cpu-common.h
> and cpu-all.h, depending on CONFIG_USER_ONLY.  We already have the
> plumbing common to user and system mode.  Using MMU_USER_IDX
> requires the cpu.h for a specific target, and so is restricted to
> when we're compiling per-target.
> 

A side question: Why is MMU_USER_IDX different depending on architecture?
I'm trying to understand why (and by what) previous indexes are reserved 
when MMU_USER_IDX is not zero.

> Include the new header only where needed.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h        |  6 ------
>   include/exec/cpu-common.h     | 20 ------------------
>   include/exec/cpu-mmu-index.h  | 39 +++++++++++++++++++++++++++++++++++
>   include/exec/cpu_ldst.h       |  1 +
>   semihosting/uaccess.c         |  1 +
>   target/arm/gdbstub64.c        |  3 +++
>   target/hppa/mem_helper.c      |  1 +
>   target/i386/tcg/translate.c   |  1 +
>   target/loongarch/cpu_helper.c |  1 +
>   target/microblaze/helper.c    |  1 +
>   target/microblaze/mmu.c       |  1 +
>   target/openrisc/translate.c   |  1 +
>   target/sparc/cpu.c            |  1 +
>   target/sparc/mmu_helper.c     |  1 +
>   target/tricore/helper.c       |  1 +
>   target/xtensa/mmu_helper.c    |  1 +
>   16 files changed, 54 insertions(+), 26 deletions(-)
>   create mode 100644 include/exec/cpu-mmu-index.h
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 902ca1f3c7..6108351f58 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -48,8 +48,6 @@ CPUArchState *cpu_copy(CPUArchState *env);
>   
>   #ifdef CONFIG_USER_ONLY
>   
> -static inline int cpu_mmu_index(CPUState *cs, bool ifetch);
> -
>   /*
>    * Allow some level of source compatibility with softmmu.  We do not
>    * support any of the more exotic features, so only invalid pages may
> @@ -59,10 +57,6 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch);
>   #define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 2))
>   #define TLB_WATCHPOINT      0
>   
> -static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
> -{
> -    return MMU_USER_IDX;
> -}
>   #else
>   
>   /*
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 3771b2130c..be032e1a49 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -272,24 +272,4 @@ static inline CPUState *env_cpu(CPUArchState *env)
>       return (CPUState *)env_cpu_const(env);
>   }
>   
> -#ifndef CONFIG_USER_ONLY
> -/**
> - * cpu_mmu_index:
> - * @env: The cpu environment
> - * @ifetch: True for code access, false for data access.
> - *
> - * Return the core mmu index for the current translation regime.
> - * This function is used by generic TCG code paths.
> - *
> - * The user-only version of this function is inline in cpu-all.h,
> - * where it always returns MMU_USER_IDX.
> - */
> -static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
> -{
> -    int ret = cs->cc->mmu_index(cs, ifetch);
> -    tcg_debug_assert(ret >= 0 && ret < NB_MMU_MODES);
> -    return ret;
> -}
> -#endif /* !CONFIG_USER_ONLY */
> -
>   #endif /* CPU_COMMON_H */
> diff --git a/include/exec/cpu-mmu-index.h b/include/exec/cpu-mmu-index.h
> new file mode 100644
> index 0000000000..b46e622048
> --- /dev/null
> +++ b/include/exec/cpu-mmu-index.h
> @@ -0,0 +1,39 @@
> +/*
> + * cpu_mmu_index()
> + *
> + *  Copyright (c) 2003 Fabrice Bellard
> + *
> + * SPDX-License-Identifier: LGPL-2.1+
> + */
> +
> +#ifndef EXEC_CPU_MMU_INDEX_H
> +#define EXEC_CPU_MMU_INDEX_H
> +
> +#include "hw/core/cpu.h"
> +#include "tcg/debug-assert.h"
> +#ifdef COMPILING_PER_TARGET
> +#include "cpu.h"
> +#endif
> +
> +/**
> + * cpu_mmu_index:
> + * @env: The cpu environment
> + * @ifetch: True for code access, false for data access.
> + *
> + * Return the core mmu index for the current translation regime.
> + * This function is used by generic TCG code paths.
> + */
> +static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
> +{
> +#ifdef COMPILING_PER_TARGET
> +# ifdef CONFIG_USER_ONLY
> +    return MMU_USER_IDX;
> +# endif
> +#endif
> +
> +    int ret = cs->cc->mmu_index(cs, ifetch);
> +    tcg_debug_assert(ret >= 0 && ret < NB_MMU_MODES);
> +    return ret;
> +}
> +
> +#endif /* EXEC_CPU_MMU_INDEX_H */
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index 1fbdbe59ae..0b10d840fe 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -67,6 +67,7 @@
>   #endif
>   
>   #include "exec/cpu-ldst-common.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/abi_ptr.h"
>   
>   #if defined(CONFIG_USER_ONLY)
> diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
> index 382a366ce3..a957891166 100644
> --- a/semihosting/uaccess.c
> +++ b/semihosting/uaccess.c
> @@ -9,6 +9,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "exec/cpu-all.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/exec-all.h"
>   #include "semihosting/uaccess.h"
>   
> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> index 1a4dbec567..a9d8352b76 100644
> --- a/target/arm/gdbstub64.c
> +++ b/target/arm/gdbstub64.c
> @@ -27,6 +27,9 @@
>   #include <sys/prctl.h>
>   #include "mte_user_helper.h"
>   #endif
> +#ifdef CONFIG_TCG
> +#include "exec/cpu-mmu-index.h"
> +#endif
>   
>   int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>   {
> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
> index fb1d93ef1f..510786518d 100644
> --- a/target/hppa/mem_helper.c
> +++ b/target/hppa/mem_helper.c
> @@ -22,6 +22,7 @@
>   #include "cpu.h"
>   #include "exec/exec-all.h"
>   #include "exec/cputlb.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/page-protection.h"
>   #include "exec/helper-proto.h"
>   #include "hw/core/cpu.h"
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index a8935f487a..20a5c69795 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -20,6 +20,7 @@
>   
>   #include "qemu/host-utils.h"
>   #include "cpu.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   #include "tcg/tcg-op.h"
> diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
> index 930466ca48..8662fb36ed 100644
> --- a/target/loongarch/cpu_helper.c
> +++ b/target/loongarch/cpu_helper.c
> @@ -8,6 +8,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "internals.h"
>   #include "cpu-csr.h"
>   
> diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
> index 27fc929bee..996514ffe8 100644
> --- a/target/microblaze/helper.c
> +++ b/target/microblaze/helper.c
> @@ -21,6 +21,7 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "exec/cputlb.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/page-protection.h"
>   #include "qemu/host-utils.h"
>   #include "exec/log.h"
> diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
> index f8587d5ac4..987ac9e3a7 100644
> --- a/target/microblaze/mmu.c
> +++ b/target/microblaze/mmu.c
> @@ -22,6 +22,7 @@
>   #include "qemu/log.h"
>   #include "cpu.h"
>   #include "exec/cputlb.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/page-protection.h"
>   
>   static unsigned int tlb_decode_size(unsigned int f)
> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
> index 7a6af183ae..5b437959ac 100644
> --- a/target/openrisc/translate.c
> +++ b/target/openrisc/translate.c
> @@ -20,6 +20,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/exec-all.h"
>   #include "tcg/tcg-op.h"
>   #include "qemu/log.h"
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index 5716120117..1bf00407af 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -22,6 +22,7 @@
>   #include "cpu.h"
>   #include "qemu/module.h"
>   #include "qemu/qemu-print.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   #include "hw/qdev-properties.h"
> diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
> index 7548d01777..4a0cedd9e2 100644
> --- a/target/sparc/mmu_helper.c
> +++ b/target/sparc/mmu_helper.c
> @@ -21,6 +21,7 @@
>   #include "qemu/log.h"
>   #include "cpu.h"
>   #include "exec/cputlb.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/page-protection.h"
>   #include "qemu/qemu-print.h"
>   #include "trace.h"
> diff --git a/target/tricore/helper.c b/target/tricore/helper.c
> index a64412e6bd..be3d97af78 100644
> --- a/target/tricore/helper.c
> +++ b/target/tricore/helper.c
> @@ -20,6 +20,7 @@
>   #include "hw/registerfields.h"
>   #include "cpu.h"
>   #include "exec/cputlb.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/page-protection.h"
>   #include "fpu/softfloat-helpers.h"
>   #include "qemu/qemu-print.h"
> diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
> index 63be741a42..96140c89c7 100644
> --- a/target/xtensa/mmu_helper.c
> +++ b/target/xtensa/mmu_helper.c
> @@ -33,6 +33,7 @@
>   #include "exec/helper-proto.h"
>   #include "qemu/host-utils.h"
>   #include "exec/cputlb.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


