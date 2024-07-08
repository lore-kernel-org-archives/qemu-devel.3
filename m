Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FDFC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 14:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQpRE-0001NV-Rc; Mon, 08 Jul 2024 10:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sQpRD-0001J6-0m
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:33:55 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sQpR6-0002JX-Lz
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:33:54 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-58b0dddab8cso5913583a12.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 07:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720449226; x=1721054026; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pufEBI35LmA84qV8HraObFf9paHS9J8Az/AcBoA2O0E=;
 b=Vil+OPrffkmnP9JitCCy5YeKh3ebeoP2igWWmvUtAjhyT/LHe6v66bKzOhPCyGtFRp
 vszQq4SaKfNMXd+kjXGiH6mKKThZ3Fqn/+HSJbRv1ySQqwyARFX9XVJnYTySkvt9Ruek
 A8YcLFa8mNpw7R8Qz9witKb+bU6dwQPsX5r/bDKTOxu5O1jljnKsDNCJ0sqwo8dcZPAm
 bo7SEnvxC6anCsND0au+PISpT4v3X7But6xw/t37goN4uj11PYsmT2nB6otx1QLuF/yK
 cNONhXjPDzrMAfmOquBoIggc4vzAKwQ7giNwgN4jlbrBdn5QJhI8Mmb2gcVXOGYghzti
 nRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720449226; x=1721054026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pufEBI35LmA84qV8HraObFf9paHS9J8Az/AcBoA2O0E=;
 b=elUrE/A0T+qmta4xJKAPMGXi9DHasm2LXlmLbY2nLz53NbMKD7jnzcqYG0s4+Mx6h8
 nCdCDEmrqshJsF08BqQyrGrk4Kf4TNUFwytRO5kusq8KpTu4wWD3hAIz0+7gqGoCJ2N2
 DUnnz8mFF2b6jMR09Hu4KWynGv73gT8SFpjmX/pOr6UUa/uu5+cDN8WC3ZOK4pKfTH/4
 kYseU8S4ZwNXYypfVwBeggJOqbMzOD4Domm/h8Q55tTAwRDL14BwdK9Im+fWSIhUcM7E
 1Ul0PRcJNAsHxxqLS3iS6WLdwnXSutSqHH4tl0S7LmaNqPyxbL1TvdWHDCCebVWMrUFj
 UN9Q==
X-Gm-Message-State: AOJu0YxQDMyUCO5jRVaGfH+mdkGzpe5V93ewys/BDlYRaAoy0jYYQstH
 N1ir4qW7gegSxWTdkvD08Lq+Q6MMkSFFlzXRKsc4WcaO/RkgWO9FnOxFhQ9uWYSts5lsZeWrL3O
 wac6PINKgvAgfg4BxtT5GoYjuC57dSqNQFsSBDQWv0dbqA4R6
X-Google-Smtp-Source: AGHT+IGbYHguRRqHrfX4nWxAWcyJ/TP36l2gymeaEwx6UR6LhIRachN9y8vkffpIcZmnbi12O/kJWRxiIGN57G+elwY=
X-Received: by 2002:a05:6402:13d5:b0:58b:73f4:2ed with SMTP id
 4fb4d7f45d1cf-58e5b4aede0mr7711256a12.35.1720449225571; Mon, 08 Jul 2024
 07:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240702234155.2106399-1-richard.henderson@linaro.org>
 <20240702234155.2106399-3-richard.henderson@linaro.org>
In-Reply-To: <20240702234155.2106399-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jul 2024 15:33:34 +0100
Message-ID: <CAFEAcA_n4r_h==JK1bPi9dNpP_pLCUOx1d1Mx+H85RshuBrPNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/arm: Use memset_ra, memmove_ra in helper-a64.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 iii@linux.ibm.com, david@redhat.com, balaton@eik.bme.hu
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Wed, 3 Jul 2024 at 00:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Without this, qemu user will not unwind from the SIGSEGV
> properly and die with
>
>   qemu-aarch64: QEMU internal SIGSEGV {code=ACCERR, addr=0x7d1b36ec2000}
>   Segmentation fault
>
> Fill in the test case for ppc and s390x, which also use memset
> from within a helper (but don't currently crash fwiw).
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-a64.c        | 10 ++--
>  tests/tcg/multiarch/memset-fault.c | 77 ++++++++++++++++++++++++++++++
>  2 files changed, 82 insertions(+), 5 deletions(-)
>  create mode 100644 tests/tcg/multiarch/memset-fault.c
>
> diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
> index 0ea8668ab4..666bdb7c1a 100644
> --- a/target/arm/tcg/helper-a64.c
> +++ b/target/arm/tcg/helper-a64.c
> @@ -971,7 +971,7 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
>      }
>  #endif
>
> -    memset(mem, 0, blocklen);
> +    memset_ra(mem, 0, blocklen, GETPC());
>  }
>
>  void HELPER(unaligned_access)(CPUARMState *env, uint64_t addr,
> @@ -1120,7 +1120,7 @@ static uint64_t set_step(CPUARMState *env, uint64_t toaddr,
>      }
>  #endif
>      /* Easy case: just memset the host memory */
> -    memset(mem, data, setsize);
> +    memset_ra(mem, data, setsize, ra);
>      return setsize;
>  }

I think strictly speaking since page_limit() and page_limit_rev()
only look at the target page size and not the host page size,
this will not quite behave correctly in the case where the
host page size is smaller than the target page size, but that
case doesn't work properly in any number of other situations
already, so I don't really care about it.

> @@ -1163,7 +1163,7 @@ static uint64_t set_step_tags(CPUARMState *env, uint64_t toaddr,
>      }
>  #endif
>      /* Easy case: just memset the host memory */
> -    memset(mem, data, setsize);
> +    memset_ra(mem, data, setsize, ra);
>      mte_mops_set_tags(env, toaddr, setsize, *mtedesc);
>      return setsize;
>  }
> @@ -1497,7 +1497,7 @@ static uint64_t copy_step(CPUARMState *env, uint64_t toaddr, uint64_t fromaddr,
>      }
>  #endif
>      /* Easy case: just memmove the host memory */
> -    memmove(wmem, rmem, copysize);
> +    memmove_ra(wmem, rmem, copysize, ra);
>      return copysize;
>  }
>
> @@ -1572,7 +1572,7 @@ static uint64_t copy_step_rev(CPUARMState *env, uint64_t toaddr,
>       * Easy case: just memmove the host memory. Note that wmem and
>       * rmem here point to the *last* byte to copy.
>       */
> -    memmove(wmem - (copysize - 1), rmem - (copysize - 1), copysize);
> +    memmove_ra(wmem - (copysize - 1), rmem - (copysize - 1), copysize, ra);
>      return copysize;
>  }
>
> diff --git a/tests/tcg/multiarch/memset-fault.c b/tests/tcg/multiarch/memset-fault.c
> new file mode 100644
> index 0000000000..0e8258a88f
> --- /dev/null
> +++ b/tests/tcg/multiarch/memset-fault.c
> @@ -0,0 +1,77 @@
> +#include <stdlib.h>
> +#include <signal.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +#include <assert.h>

Can we have a copyright-and-license header comment for all new
files, please?

> +
> +#if defined(__powerpc64__)
> +/* Needed for PT_* constants */
> +#include <asm/ptrace.h>
> +#endif
> +
> +static void *ptr;
> +static void *pc;
> +
> +static void test(void)
> +{
> +#ifdef __aarch64__
> +    void *t;
> +    asm("adr %0,1f; str %0,%1; 1: dc zva,%2"
> +        : "=&r"(t), "=m"(pc) : "r"(ptr));
> +#elif defined(__powerpc64__)
> +    void *t;
> +    asm("bl 0f; 0: mflr %0; addi %0,%0,1f-0b; std %0,%1; 1: dcbz 0,%2"
> +        : "=&r"(t), "=m"(pc) : "r"(ptr) : "lr");
> +#elif defined(__s390x__)
> +    void *t;
> +    asm("larl %0,1f; stg %0,%1; 1: xc 0(256,%2),0(%2)"
> +        : "=&r"(t), "=m"(pc) : "r"(ptr));
> +#else
> +    *(int *)ptr = 0;
> +#endif
> +}
> +
> +static void *host_signal_pc(ucontext_t *uc)
> +{
> +#ifdef __aarch64__
> +    return (void *)uc->uc_mcontext.pc;
> +#elif defined(__powerpc64__)
> +    return (void *)uc->uc_mcontext.gp_regs[PT_NIP];
> +#elif defined(__s390x__)
> +    return (void *)uc->uc_mcontext.psw.addr;
> +#else
> +    return NULL;
> +#endif
> +}
> +
> +static void sigsegv(int sig, siginfo_t *info, void *uc)
> +{
> +    assert(info->si_addr == ptr);
> +    assert(host_signal_pc(uc) == pc);
> +    exit(0);
> +}
> +
> +int main(void)
> +{
> +    static const struct sigaction sa = {
> +        .sa_flags = SA_SIGINFO,
> +        .sa_sigaction = sigsegv
> +    };
> +    size_t size;
> +    int r;
> +
> +    size = getpagesize();
> +    ptr = mmap(NULL, size, PROT_READ | PROT_WRITE,
> +               MAP_ANON | MAP_PRIVATE, -1, 0);
> +    assert(ptr != MAP_FAILED);
> +
> +    test();
> +
> +    r = sigaction(SIGSEGV, &sa, NULL);
> +    assert(r == 0);
> +    r = mprotect(ptr, size, PROT_NONE);
> +    assert(r == 0);
> +
> +    test();
> +    abort();
> +}

A few comments in this test program to explain what it's
doing would be helpful.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

