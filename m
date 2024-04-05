Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247B0CD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 12:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsiwH-0007pD-5W; Fri, 05 Apr 2024 08:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsiwF-0007ow-D0
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:44:59 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsiwD-00043D-Ib
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:44:59 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a519ef3054bso109704066b.1
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 05:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712321096; x=1712925896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MHvI03SEuODPRGUdMbkO9fSICy40FCR9p4fk+8lCqwo=;
 b=vTarYN1JbOy9iL+GrfA3I/++cyZvrZgS5tkVpEYFHnOdU3qX0jizeT1SGRivZlB2ix
 CbFMYyf+z4D4CXvMzuR9BL+iMyIUiVAlXy6DIdQi0dUOatBqQe/1/oUDArH1+9MD4Izt
 nQeP8iDFfO1g+Cp4d0V1NdNfqJISF4cfd19CanFVTyW/zYwKn59O+htfHHQQ2X9qRgsY
 JHPQZLlt6p0DdNHFWZq9Grh5zAkw0DhJGFZB1QHzJvnFjd7VOtmIbSTbO6tXZ57JAPMe
 os+hFN2fm6M/Ya2FQsRe5AOixGLMFenRNmkLecbJo6NanM2Ahcyvdh5o4ZFiFT5EAt1S
 xGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712321096; x=1712925896;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MHvI03SEuODPRGUdMbkO9fSICy40FCR9p4fk+8lCqwo=;
 b=cTV3tj7mr2+3a24KzkBJ36oYU1DFsLv++bwq0mhWKyp3w8xGR+gZid+UIsr5SAKPfv
 JZaYCYgCsJl6p23QIsiupDUiU9T3qBORRhz9M71u3FNgART8k373uEcUXsZv0nKbkUP7
 3hDYymuUTKoKk2AmRby8/YLsiR0ciEVzGo5/1mV67b5Sxs7KKOAgxTAZwaQkgFAeJPqL
 3D46qZV/iKpND86i7Cfp1WVR11zGqh1R1hxZcnLH4o7ps8F+DHj5L+iswt1zaWogWxCv
 hH8k2luzax/aL2Wa0RPbElMp4Rp2/VQt2oNvdXF1zVV4HaXiFfLcwy4Izy6bia99cLVs
 2Tog==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB5sxhPkN3nAanogZlWAPfSxD6JVMJDXHU2WVktie0IR+D9ySjrfnzhMGx/EzEzEZR/KKK3NB8+fWRcpM3tGYM68Qi0IQ=
X-Gm-Message-State: AOJu0Yyf0RoCssuiwjXaFOkoZPuSOPtcX/5DEnbFfp9yWhq6rEbzxYJL
 huxg2QlllspmCKepYZyZ7DaKFNCgoxZE4VRAcYA3rlVkXufc8/0s72QPqIGkJaWsXfwr+YQd75G
 s
X-Google-Smtp-Source: AGHT+IHhWgUE0fZZza6a8zSxKlEDc+IT3inruKPwkUnWv+IvUfrbhAz7gvv/XRMEUFsS/aBSB16iPA==
X-Received: by 2002:a17:906:5610:b0:a4e:e47:9ee7 with SMTP id
 f16-20020a170906561000b00a4e0e479ee7mr974055ejq.49.1712321095662; 
 Fri, 05 Apr 2024 05:44:55 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.34])
 by smtp.gmail.com with ESMTPSA id
 w14-20020a170907270e00b00a4e29b7eb60sm809420ejk.3.2024.04.05.05.44.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 05:44:55 -0700 (PDT)
Message-ID: <1121b161-541c-4dc8-bbff-2bc029b0a199@linaro.org>
Date: Fri, 5 Apr 2024 14:44:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/32] accel/tcg: Provide default implementation of
 disas_log
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv <qemu-riscv@nongnu.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
 <20240405102459.462551-17-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240405102459.462551-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 5/4/24 12:24, Richard Henderson wrote:
> Almost all of the disas_log implementations are identical.
> Unify them within translator_loop.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/translator.c           |  9 ++++++++-
>   target/alpha/translate.c         |  9 ---------
>   target/arm/tcg/translate-a64.c   | 11 -----------
>   target/arm/tcg/translate.c       | 12 ------------
>   target/avr/translate.c           |  8 --------
>   target/cris/translate.c          | 11 -----------
>   target/hexagon/translate.c       |  9 ---------
>   target/hppa/translate.c          |  6 ++++--
>   target/i386/tcg/translate.c      | 11 -----------
>   target/loongarch/tcg/translate.c |  8 --------
>   target/m68k/translate.c          |  9 ---------
>   target/microblaze/translate.c    |  9 ---------
>   target/mips/tcg/translate.c      |  9 ---------
>   target/nios2/translate.c         |  9 ---------
>   target/openrisc/translate.c      | 11 -----------
>   target/ppc/translate.c           |  9 ---------
>   target/riscv/translate.c         | 18 ------------------
>   target/rx/translate.c            |  8 --------
>   target/sh4/translate.c           |  9 ---------
>   target/sparc/translate.c         |  9 ---------
>   target/tricore/translate.c       |  9 ---------
>   target/xtensa/translate.c        |  9 ---------
>   22 files changed, 12 insertions(+), 200 deletions(-)


> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 8a1a8bc3aa..7470795578 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -4815,12 +4815,12 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
>       }
>   }
>   
> +#ifdef CONFIG_USER_ONLY
>   static void hppa_tr_disas_log(const DisasContextBase *dcbase,
>                                 CPUState *cs, FILE *logfile)
>   {
>       target_ulong pc = dcbase->pc_first;
>   
> -#ifdef CONFIG_USER_ONLY
>       switch (pc) {
>       case 0x00:
>           fprintf(logfile, "IN:\n0x00000000:  (null)\n");
> @@ -4835,11 +4835,11 @@ static void hppa_tr_disas_log(const DisasContextBase *dcbase,
>           fprintf(logfile, "IN:\n0x00000100:  syscall\n");
>           return;
>       }
> -#endif
>   
>       fprintf(logfile, "IN: %s\n", lookup_symbol(pc));
>       target_disas(logfile, cs, pc, dcbase->tb->size);
>   }
> +#endif
>   
>   static const TranslatorOps hppa_tr_ops = {
>       .init_disas_context = hppa_tr_init_disas_context,
> @@ -4847,7 +4847,9 @@ static const TranslatorOps hppa_tr_ops = {
>       .insn_start         = hppa_tr_insn_start,
>       .translate_insn     = hppa_tr_translate_insn,
>       .tb_stop            = hppa_tr_tb_stop,
> +#ifdef CONFIG_USER_ONLY
>       .disas_log          = hppa_tr_disas_log,

Preferrably rename with '_user'.

> +#endif
>   };


> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 9d57089fcc..9fd1ac1d60 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -20,7 +20,6 @@
>   #include "qemu/log.h"
>   #include "cpu.h"
>   #include "tcg/tcg-op.h"
> -#include "disas/disas.h"
>   #include "exec/cpu_ldst.h"
>   #include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
> @@ -1271,29 +1270,12 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
>       }
>   }
>   
> -static void riscv_tr_disas_log(const DisasContextBase *dcbase,
> -                               CPUState *cpu, FILE *logfile)
> -{
> -#ifndef CONFIG_USER_ONLY
> -    RISCVCPU *rvcpu = RISCV_CPU(cpu);
> -    CPURISCVState *env = &rvcpu->env;
> -#endif
> -
> -    fprintf(logfile, "IN: %s\n", lookup_symbol(dcbase->pc_first));
> -#ifndef CONFIG_USER_ONLY
> -    fprintf(logfile, "Priv: "TARGET_FMT_ld"; Virt: %d\n",
> -            env->priv, env->virt_enabled);

Should we mention the removal of this fprintf() in sysemu?

> -#endif
> -    target_disas(logfile, cpu, dcbase->pc_first, dcbase->tb->size);
> -}
> -
>   static const TranslatorOps riscv_tr_ops = {
>       .init_disas_context = riscv_tr_init_disas_context,
>       .tb_start           = riscv_tr_tb_start,
>       .insn_start         = riscv_tr_insn_start,
>       .translate_insn     = riscv_tr_translate_insn,
>       .tb_stop            = riscv_tr_tb_stop,
> -    .disas_log          = riscv_tr_disas_log,
>   };

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


