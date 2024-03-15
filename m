Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E706AC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 21:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlF3y-0008LL-1R; Fri, 15 Mar 2024 17:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlF3w-0008JC-0w
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 17:26:00 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlF3u-0005XC-El
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 17:25:59 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5d8b519e438so2091041a12.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 14:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710537944; x=1711142744; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fK1B5sMu/v3wEBSqLZuuy1p9TIcXm46zOw9z/PhJuGE=;
 b=b7jOz06IU0NGSkv8iI/vgDWnxBqqF9QX8PRcF2y6NdJdtW0Ni9/f4OV8CKrjVKtwlT
 OB+a2z3mV8Oliy2cCI9wJLkIpjKRqsN/0WABqXs/YlizwJzSw4Sf4cMJr2/HI68Qzjfx
 p3AOZ9Wd1MFqMwhTH8KRtjqze0URADmz8yfZdzzbjIlXbGDLb40GbHps8pkWoCeyLs1+
 fxIWFesD38tXQBeMjikx3HcAEUQ/cw6KZu2hTluPNVGEWSV7wopKgRIoJx8CRKFU6saf
 wNcQUdTvdD6rSNLBK+gZJftiTix7xbVS3uR+tg+pMGbONJKpGGOCFopYfOMSpV7uY+B8
 ukqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710537944; x=1711142744;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fK1B5sMu/v3wEBSqLZuuy1p9TIcXm46zOw9z/PhJuGE=;
 b=E+H6U5b6i7bfmMuENV6jFVIUpKhcIXttBAVTcmXyg8oHa+QbOpsWg+yPoytcJx6Qk3
 KcZ2a53n52aW0uOkk/5TavZXBYUU2EIgakIcQCGbeT5MxM0Uz4Sls/j+6bPUz+ZHFAaU
 sVv7SdCzh6Dzjza23+cmFr/Vwld9uvQIDDYhJrU3lvOi34qV4D2nRJr6eIhuxoqwDbEB
 k01dYw5cjQ5mEkcLU98N69OcLGeYosJklaKXgNNbHFjwqg0++YYuJ/qajI+xEN2ZE53/
 ZFHwzQ6snsVC0ICwdBKmvGH6ZbiwN7F0i7EUxeLL3uDOeMSK/7XslfASJVTDmC3l+jUP
 Cmzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV06tzLzMI2HfkJHMxLUgzS2YtfytzuEBJxfvKFx3iY4Z/mlp8tcTqUoNF8g79JpXC9SO2bg0zEzkL0gG0mhntSP/rodM0=
X-Gm-Message-State: AOJu0YwWPpzmnk2O4XLMRtI6EkhcF7p4ZWikYXo6793m8c78mWRx27EL
 GlbD7xZWXmpL/4kF5VjgRRAOiAdsTjEb0xyGberTMUAEMMCW/crqPhJj0pPv5VI=
X-Google-Smtp-Source: AGHT+IFFMWbUuSXJCT65f8Qrgu+p9a42PS/5v/Ne3XGmqvQe1KbM63wGmXGgLrlTrk6wvDOtsUu7QA==
X-Received: by 2002:a17:90a:8006:b0:29c:e2b:ace8 with SMTP id
 b6-20020a17090a800600b0029c0e2bace8mr5770934pjn.35.1710537944569; 
 Fri, 15 Mar 2024 14:25:44 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 d5-20020a17090ac24500b0029df6fbfd02sm1888637pjx.12.2024.03.15.14.25.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 14:25:43 -0700 (PDT)
Message-ID: <76faab59-3dac-46c6-a548-7ec2d7f2e4d4@linaro.org>
Date: Fri, 15 Mar 2024 11:25:39 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 09/12] accel/tcg/internal: Check for USER_ONLY
 definition instead of SOFTMMU
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org
References: <20240313213339.82071-1-philmd@linaro.org>
 <20240313213339.82071-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240313213339.82071-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 3/13/24 11:33, Philippe Mathieu-Daudé wrote:
> Since we *might* have user emulation with softmmu,
> replace the system emulation check by !user emulation one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/internal-target.h | 6 +++---
>   accel/tcg/tb-hash.h         | 4 ++--
>   accel/tcg/tcg-all.c         | 2 +-
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
> index 4e36cf858e..b22b29c461 100644
> --- a/accel/tcg/internal-target.h
> +++ b/accel/tcg/internal-target.h
> @@ -24,7 +24,7 @@
>   #define assert_memory_lock()
>   #endif
>   
> -#if defined(CONFIG_SOFTMMU) && defined(CONFIG_DEBUG_TCG)
> +#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_DEBUG_TCG)
>   void assert_no_pages_locked(void);
>   #else
>   static inline void assert_no_pages_locked(void) { }
> @@ -62,12 +62,12 @@ void tb_unlock_page1(tb_page_addr_t, tb_page_addr_t);
>   void tb_unlock_pages(TranslationBlock *);
>   #endif
>   
> -#ifdef CONFIG_SOFTMMU
> +#ifndef CONFIG_USER_ONLY
>   void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
>                                      unsigned size,
>                                      uintptr_t retaddr);
>   G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
> -#endif /* CONFIG_SOFTMMU */
> +#endif /* !CONFIG_USER_ONLY */
>   
>   TranslationBlock *tb_gen_code(CPUState *cpu, vaddr pc,
>                                 uint64_t cs_base, uint32_t flags,

Ok.


> diff --git a/accel/tcg/tb-hash.h b/accel/tcg/tb-hash.h
> index a0c61f25cd..45a484ce82 100644
> --- a/accel/tcg/tb-hash.h
> +++ b/accel/tcg/tb-hash.h
> @@ -25,7 +25,7 @@
>   #include "qemu/xxhash.h"
>   #include "tb-jmp-cache.h"
>   
> -#ifdef CONFIG_SOFTMMU
> +#ifndef CONFIG_USER_ONLY
>   
>   /* Only the bottom TB_JMP_PAGE_BITS of the jump cache hash bits vary for
>      addresses on the same page.  The top bits are the same.  This allows
> @@ -58,7 +58,7 @@ static inline unsigned int tb_jmp_cache_hash_func(vaddr pc)
>       return (pc ^ (pc >> TB_JMP_CACHE_BITS)) & (TB_JMP_CACHE_SIZE - 1);
>   }
>   
> -#endif /* CONFIG_SOFTMMU */
> +#endif /* CONFIG_USER_ONLY */
>   
>   static inline
>   uint32_t tb_hash_func(tb_page_addr_t phys_pc, vaddr pc,

Not ok, this is really softmmu related.  If we have user-only softmmu, then we'll need to 
take multiple mappings into account, just like this.

Perhaps add a comment so it's easy to see this (and whichever else) have already been audited?


> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index c6619f5b98..929af1f64c 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -116,7 +116,7 @@ static int tcg_init_machine(MachineState *ms)
>       tb_htable_init();
>       tcg_init(s->tb_size * MiB, s->splitwx_enabled, max_cpus);
>   
> -#if defined(CONFIG_SOFTMMU)
> +#if !defined(CONFIG_USER_ONLY)
>       /*
>        * There's no guest base to take into account, so go ahead and
>        * initialize the prologue now.

With system, we *know* softmmu must be used.
With user-only, we will want to wait until after command-line processing.

Ok with comment change to "never a guest base".


r~


