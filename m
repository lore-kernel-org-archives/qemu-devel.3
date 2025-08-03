Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77B6C87FCA
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 10:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiWA6-0007ac-FY; Sun, 03 Aug 2025 06:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWA4-0007Wq-NY
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 06:41:52 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWA3-0004ia-6W
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 06:41:52 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-718409593b9so32037127b3.3
 for <qemu-devel@nongnu.org>; Sun, 03 Aug 2025 03:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754217709; x=1754822509; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5sZTrJdR5X/kRnACcS2MauxICV41ub3V/SC+1hpnEJ4=;
 b=TrNLkcigkdp1HshNjBuEhgPzcOHs6VRPAHfW0YX89T0ErYqrkjO+0+iS6kKxncyTmF
 fdPjQsvdSNEW5vbO9jhkiiabggh42pHwj+5EOs8oJ19QuOc6HDW9+BPGdlpf0V91ji7c
 zkBUOnNvjbg6euukhg2e6USPU2il/2Fsevh/mjMv/hIF9qPAcqy/9BU5xBORyW+41s1L
 3n1RcGIrxS9if4fD3SV7qNvvvGPGzlpY0AwwmNsqXk0bt+fwAQ3Q2WKZq8WNY6hMlDlp
 bmjDAPVpNlRb7aFRKUX6ZggJgfIRTGGMJSW427m8O9zMmdFE6FBqbvmFmummo41tQegA
 jYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754217709; x=1754822509;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5sZTrJdR5X/kRnACcS2MauxICV41ub3V/SC+1hpnEJ4=;
 b=LIOxXXqiK5pD28PJj7ugraJiY/6p+wFF5NO5WlB8cg4eE08coiLtITUTM6DwnS5tjN
 PyFfMftoN+z/WWfBVV4+LzyieahueA8wthiiZT1ZLJ3X0K+2tmJaeSyHarwMDbo6QdyR
 Qn/1zN1gKaakbr+W8z1M6BDBZYoew9qVDg1bp/g8sL47pIf10r1UXLfCK21XMGvfvlbs
 adqeojuzWICMB6FS6QdkVBxsw2gY2JJ0M/etoYCReGv1kn+XfRxYhvOvqTTnArNk8JdE
 sRJBNAMG9hXBVfsBkLuhTkIbBs2VEcrjvZFGRu3Vu3oFwI/H/awfsnSMvQtVmE7t5hbY
 NgUw==
X-Gm-Message-State: AOJu0YxtrR9GL/O7htw6ZQNgZtLNGEMuS/swd5BZJWcQPkTBJW6Yzr5J
 AUNAnuo5XWedRi2GXefNIEOwenMqmhn4KK3B7LN/q5OK2fFcaoZ0rAOCqblNOGDnQg2eZ4vVTag
 /4POIfEAbTBdiUyrbOxL68jJdZNLtprqZKC/e6rvuvg==
X-Gm-Gg: ASbGncvYNp5e2nla4zcXNOLS62+dvabcVlX5jb+NPUI+LQ9/Ag9er4ZAuLLzXJSD4sy
 MLN4rWeW5VbhXlM1cVvV6OV+h789ECBwCXWiACwYCrqu1XOPI4TfHstDQOCNgFc9A18oWIsEFTq
 3es1ElUazyOq1DxHg6+z3o1Xh525oaCXuiErzTWtRpbBMmnzNa/yb5FaYKzpfXbtqoCAIcihe2p
 oocIOFD
X-Google-Smtp-Source: AGHT+IGf3+JglBadjJyZfZzuk1tJkn6LAcV0RRsw0EouFv0FpP0Py5rCfDCnMUUur6zAT6hVs9khyUg0e7rgsnZ6tDQ=
X-Received: by 2002:a05:690c:6d82:b0:70f:83af:7db1 with SMTP id
 00721157ae682-71b7f7f5e59mr61802167b3.19.1754217709262; Sun, 03 Aug 2025
 03:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250802230459.412251-1-richard.henderson@linaro.org>
 <20250802230459.412251-3-richard.henderson@linaro.org>
In-Reply-To: <20250802230459.412251-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 3 Aug 2025 11:41:37 +0100
X-Gm-Features: Ac12FXyTgiwJZey11c1PB6feh_rNUm4awqqtI2JMr4JvDdSfzHoMlA1oVCQgujk
Message-ID: <CAFEAcA8miFBnjrV30Sy4iStDRS0+PkLjOwc9FyY6v_MbtdqiqQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/95] semihosting: Initialize heap once per process
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Sun, 3 Aug 2025 at 00:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> While semihosting isn't really thread aware, the current
> implementation allocates space for the heap per-thread.
>
> Remove the heap_base and heap_limit fields from TaskState.
> Replace with static variables within do_common_semihosting.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> @@ -492,19 +489,20 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
>      for(i = 0; i < 16; i++) {
>          env->regs[i] = regs->uregs[i];
>      }
> -#if TARGET_BIG_ENDIAN
> -    /* Enable BE8.  */
> -    if (EF_ARM_EABI_VERSION(info->elf_flags) >= EF_ARM_EABI_VER4
> -        && (info->elf_flags & EF_ARM_BE8)) {
> -        env->uncached_cpsr |= CPSR_E;
> -        env->cp15.sctlr_el[1] |= SCTLR_E0E;
> -    } else {
> -        env->cp15.sctlr_el[1] |= SCTLR_B;
> -    }
> -    arm_rebuild_hflags(env);
> -#endif
>
> -    ts->heap_base = info->brk;
> -    /* This will be filled in on the first SYS_HEAPINFO call.  */
> -    ts->heap_limit = 0;
> +    if (TARGET_BIG_ENDIAN) {
> +        CPUState *cpu = env_cpu(env);
> +        TaskState *ts = get_task_state(cpu);
> +        struct image_info *info = ts->info;
> +
> +        /* Enable BE8.  */
> +        if (EF_ARM_EABI_VERSION(info->elf_flags) >= EF_ARM_EABI_VER4
> +            && (info->elf_flags & EF_ARM_BE8)) {
> +            env->uncached_cpsr |= CPSR_E;
> +            env->cp15.sctlr_el[1] |= SCTLR_E0E;
> +        } else {
> +            env->cp15.sctlr_el[1] |= SCTLR_B;
> +        }
> +        arm_rebuild_hflags(env);
> +    }

This change to the big-endian handling code seems unrelated.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

> @@ -678,24 +678,20 @@ void do_common_semihosting(CPUState *cs)
>               * Some C libraries assume the heap immediately follows .bss, so
>               * allocate it using sbrk.
>               */
> -            if (!ts->heap_limit) {
> -                abi_ulong ret;
> -
> -                ts->heap_base = do_brk(0);
> -                limit = ts->heap_base + COMMON_SEMI_HEAP_SIZE;
> +            if (!heaplimit) {
> +                heapbase = do_brk(0);
>                  /* Try a big heap, and reduce the size if that fails.  */
> -                for (;;) {
> -                    ret = do_brk(limit);
> +                for (abi_ulong size = COMMON_SEMI_HEAP_SIZE; ; size >>= 1) {
> +                    abi_ulong limit = heapbase + size;
> +                    abi_ulong ret = do_brk(limit);
>                      if (ret >= limit) {
> +                        heaplimit = limit;
>                          break;
>                      }
> -                    limit = (ts->heap_base >> 1) + (limit >> 1);

The old code was doing this in a very weird way; what you
have here is much clearer...

>                  }
> -                ts->heap_limit = limit;
>              }

-- PMM

