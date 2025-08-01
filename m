Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E676DC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 17:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhtk2-0007F7-4w; Fri, 01 Aug 2025 13:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhsGV-0001XE-25
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:05:51 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhsGT-0003r4-0H
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:05:50 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-74190a2fc10so485226a34.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 09:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754064347; x=1754669147; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/wgsRW2CkspSNXlSsGnf4Owk+LP5ewR2OD8tIsP+fMU=;
 b=R0SJOzaU7GZzW4gsJetg19SR2ou8RgQVqY77yH5kHNHpcI++TyEW712OISLMmZ3P35
 7tCz2u9kUKhfSOttoRr+zVY0wdzhC8o+Y9zC2VbdSGleqx559OrBnOjkzP7FPKQ977EE
 yojOnHif9JWBauwdq8YXOpxaK20Z4ftRdBmSD0wb+wqtOLVbSD8++WEWxpQLYWBy3jnT
 0AOZLev48zm26QB+6R18x4G649IdnD2WIHIW/B8RqkyyKHnjp2NTnxJlzy1VF0V1eIqB
 baNuS4t34lLEInjJwjSrTSKNy52lY+9W9bFHoA0k3TKUlMlUwp1RJpSz7iBrUbQS8q3j
 WAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754064347; x=1754669147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/wgsRW2CkspSNXlSsGnf4Owk+LP5ewR2OD8tIsP+fMU=;
 b=TzpvB/PRkI400zPWhHbYsFHxpzSVfGSL8nOe6JYfolYflN7xkuL4/eajF8hxy+Tq3H
 FehacWwRoNRobK8dEkKDaPHb7l7LWhM9MStslOccJcYVEiqoZP5RuCy9DOv9Ti4Rw21X
 Q99B+mDMJc9kd8CSghBLLhsoRl6rgb8BIxFhmK73kZkv/jsZyBdFDt4yzkLyF0nDdU79
 zHI6bLXhyOvVublweB3zhp62Ru9On9Nrr1cBRrL/sM/6Lop1k+AcwnV++jcr3VaGY4TI
 K2vFXlyfEvo4E12zi2Q7vV9eAKBVOVU8VLGHrpsqE3miL8QHkIj4kwIW1/WDLGRL/kG3
 nGrQ==
X-Gm-Message-State: AOJu0YyfLaSPa4OJv1bL/CQG6LwsuqsEb2sejPoaFgsyg5w/6rmHTIOj
 BjfM7m3hKjBSNSeXLyIaaN+V5gbQ6+7Jzr3hpligBgfmEz2ND0CZHocnlM27ZNAEBEmTs1HBs+O
 mh2CPoAStsy2Byq9ON5t5MxV4eK4J/UsIP8f1MCdMMA==
X-Gm-Gg: ASbGncurx8896tKY7n2SP+bk5lpnWDHXwQUkyHaV4iA3WAiVCjGuIjblOdQQ1IRt9bf
 1Xq8kFI+nas8UojE4QzDwrHliQZWxcgBymASt/1ZqkVRWPUKSbzWobtrZW95JzhDAjQJ0ognZnI
 PNEDe6taHXxM36u6BAkrPmYcSe8kfe00lGq7YR4lK1tWrrK5FiaIdj7iAussFdnoiMDIc9ycKic
 LJk+SrA
X-Google-Smtp-Source: AGHT+IE/5Z55mfOGdPpFGWhGB69xv5w401Raw7HRFuFL42Bzn+ycM/k0JYgT4qawSVz+L/jfKsa4RvObUrVvoIecUtI=
X-Received: by 2002:a05:6830:4109:b0:741:84f0:5461 with SMTP id
 46e09a7af769-7419d06ae79mr23190a34.6.1754064346618; Fri, 01 Aug 2025 09:05:46
 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-22-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-22-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 17:05:34 +0100
X-Gm-Features: Ac12FXwT_67GHf_ifN5PFOw_s-zoCkcjsEUDVu7l-JVS-Hl7cHbtmGsB40Hj7h8
Message-ID: <CAFEAcA-GObaf6Sf2preS42Cd1HueRkjuKgE1_=ofe-ZrcJ3=Dg@mail.gmail.com>
Subject: Re: [PATCH 21/89] linux-user: Unify init of semihosting fields in
 TaskState
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x334.google.com
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

On Wed, 30 Jul 2025 at 01:48, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Initialize all 3 fields in main(), rather than in 4 different
> target-specific functions.  Adjust the ifdef to be function
> rather than target specific.  Include stack_base in the ifdef.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/qemu.h             |  4 ++--
>  linux-user/aarch64/cpu_loop.c |  8 --------
>  linux-user/arm/cpu_loop.c     | 37 +++++++++++++++--------------------
>  linux-user/m68k/cpu_loop.c    |  9 ---------
>  linux-user/main.c             |  5 +++++
>  linux-user/riscv/cpu_loop.c   |  5 -----
>  6 files changed, 23 insertions(+), 45 deletions(-)
>
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 6c97ab221f..dff7767bc8 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -122,12 +122,12 @@ struct TaskState {
>  #ifdef TARGET_M68K
>      abi_ulong tp_value;
>  #endif
> -#if defined(TARGET_ARM) || defined(TARGET_M68K) || defined(TARGET_RISCV)
> +#ifdef CONFIG_SEMIHOSTING
>      /* Extra fields for semihosted binaries.  */
>      abi_ulong heap_base;
>      abi_ulong heap_limit;
> -#endif
>      abi_ulong stack_base;
> +#endif
>      int used; /* non zero if used */
>      struct image_info *info;
>      struct linux_binprm *bprm;

> diff --git a/linux-user/main.c b/linux-user/main.c
> index 68972f00a1..4def4be1c1 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -1050,6 +1050,11 @@ int main(int argc, char **argv, char **envp)
>
>  #ifdef CONFIG_SEMIHOSTING
>      qemu_semihosting_guestfd_init();
> +
> +    ts->stack_base = info->start_stack;
> +    ts->heap_base = info->brk;
> +    /* This will be filled in on the first SYS_HEAPINFO call.  */
> +    ts->heap_limit = 0;
>  #endif

Do we need to hide the struct fields and their initialization
behind an ifdef at all? We allocate our TaskState structs on
the heap so we don't care too much about their size, and
the init code here is trivial.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

