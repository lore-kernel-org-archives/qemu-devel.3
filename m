Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F558C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 01:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Fg3-0003VL-Dh; Sun, 28 Apr 2024 21:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Fg1-0003V3-9l
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 21:19:29 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Ffy-0000ek-3B
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 21:19:27 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ac1674d890so3500665a91.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 18:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714353564; x=1714958364; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ex6qSPhCl4dDCVe8WewPuYkHQDtbpdHGwH0PRnv9NZg=;
 b=y9IPihkxMSt/gDVGy/kAwFaFaLDBK/d+dCTyiQmFczGNKykl6KZLkFWhC3ChlH+fAO
 n8jIr6TjIlAKZdpg2n6O6kbGpXds6NLlqoiwsoqvvD3yWuISkachuaHV/2cEZGqUaOid
 3KCAsEwrT03aRzKfYyWNTcjCkdr18X788dzVWxk3JYnggOenRjke/X0as56iB+4wNnqj
 1mDDiS62C863qyk1IVKUpKOs2bBrpbM/P8AiPdHp3PSwURqpfcOqCfgtRSPLya8Ufab7
 xSzylODJ9yieX5FvY5HGkcA7Vq9jTtQKRfljJJ1DMuGWhLBzBMEJqhSjW5DB1XaGpOUt
 xAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714353564; x=1714958364;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ex6qSPhCl4dDCVe8WewPuYkHQDtbpdHGwH0PRnv9NZg=;
 b=CdEoRsfV/yZiio6oDtW2XdFPOcIY6uEo8JnBscWPmatyW5mM4acgnGMLW9ELlIGJT2
 UwTtExjVtYNb+ItwPF0RZm5rkjWZujiOkAA2shaV351y4GdvvhIv7PkO95B+xwlCwUQC
 751VRdirgXCC7n0VsS+aE15RLI4aJ68KzwZHEi2GlIS5QQfSbfE1W0W2fs8iKkhe3Apf
 nohYQCS4Pup/ae7+z6PslPW7L0w93RBDcN9Qqd2vLUqRx15kwcL/l3UhOZrCTkepdI0y
 8aqPxBofkDrbqO8g+XI+B6tAuy399laSsaRxRHXPV/E/UKVNNjkYVFHEqRXI7v2/lLa1
 hwDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfVETTuKa0Tz7ZmVBDX0Jlt6NGaWkucQtJ/gL+o1WxNPLKB3MNZ9/ZK++E4/4ErWP5sZdv0Rqvl9jmWXOWm+DXKN0Xub8=
X-Gm-Message-State: AOJu0YzbojpawuP8ptYGIQSqykslFFAhbhXq1BE7Sd2VHB7ok8efRuZu
 6WGYqw4kzHro8EJXvsoElFMmeXu6+sT/K8qKfTBrOy+nMFyV4Kxs01/Ts5OsUeiY6VrVNBsknba
 u
X-Google-Smtp-Source: AGHT+IF+V090fuhw1GuXF1bxCR45zRoO3Wdd6ky/R2hryg0LvadG/uiXMK7IlbWR2FdUS9njR+Bg6A==
X-Received: by 2002:a17:90a:7e16:b0:2a5:4e39:6a8 with SMTP id
 i22-20020a17090a7e1600b002a54e3906a8mr8296800pjl.33.1714353564204; 
 Sun, 28 Apr 2024 18:19:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 cz16-20020a17090ad45000b002b206acbbb3sm50766pjb.30.2024.04.28.18.19.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 18:19:23 -0700 (PDT)
Message-ID: <1ecc5fdb-e736-4489-bf92-b8e64ac65bc9@linaro.org>
Date: Sun, 28 Apr 2024 18:19:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/24] user: Declare get_task_state() once in
 'accel/tcg/vcpu-state.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 4/28/24 15:14, Philippe Mathieu-Daudé wrote:
> While each user emulation implentation defines its own
> TaskState structure, both use the same get_task_state()
> declaration, in particular in common code (such gdbstub).
> Declare the method once in "accel/tcg/vcpu-state.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/vcpu-state.h | 18 ++++++++++++++++++
>   bsd-user/qemu.h        |  6 +-----
>   linux-user/qemu.h      |  6 +-----
>   3 files changed, 20 insertions(+), 10 deletions(-)
>   create mode 100644 accel/tcg/vcpu-state.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
> new file mode 100644
> index 0000000000..e407d914df
> --- /dev/null
> +++ b/accel/tcg/vcpu-state.h
> @@ -0,0 +1,18 @@
> +/*
> + * SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
> + * SPDX-FileCopyrightText: 2023 Linaro Ltd.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef ACCEL_TCG_VCPU_STATE_H
> +#define ACCEL_TCG_VCPU_STATE_H
> +
> +#include "hw/core/cpu.h"
> +
> +#ifdef CONFIG_USER_ONLY
> +static inline TaskState *get_task_state(const CPUState *cs)
> +{
> +    return cs->opaque;
> +}
> +#endif
> +
> +#endif
> diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> index be57374b41..65fe95fed1 100644
> --- a/bsd-user/qemu.h
> +++ b/bsd-user/qemu.h
> @@ -36,6 +36,7 @@ extern char **environ;
>   #include "exec/gdbstub.h"
>   #include "exec/page-protection.h"
>   #include "qemu/clang-tsa.h"
> +#include "accel/tcg/vcpu-state.h"
>   
>   #include "qemu-os.h"
>   /*
> @@ -116,11 +117,6 @@ struct TaskState {
>       struct target_sigaltstack sigaltstack_used;
>   } __attribute__((aligned(16)));
>   
> -static inline TaskState *get_task_state(CPUState *cs)
> -{
> -    return cs->opaque;
> -}
> -
>   void stop_all_tasks(void);
>   extern const char *interp_prefix;
>   extern const char *qemu_uname_release;
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 16d9f6ae8c..515af82d8b 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -8,6 +8,7 @@
>   
>   #include "syscall_defs.h"
>   #include "target_syscall.h"
> +#include "accel/tcg/vcpu-state.h"
>   
>   /*
>    * This is the size of the host kernel's sigset_t, needed where we make
> @@ -160,11 +161,6 @@ struct TaskState {
>       uint64_t start_boottime;
>   };
>   
> -static inline TaskState *get_task_state(CPUState *cs)
> -{
> -    return cs->opaque;
> -}
> -
>   abi_long do_brk(abi_ulong new_brk);
>   int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
>                       int flags, mode_t mode, bool safe);


