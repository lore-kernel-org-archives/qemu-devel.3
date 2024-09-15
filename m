Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502D3C3ABA8
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 19:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spvG5-0002P0-0H; Sun, 15 Sep 2024 15:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1spvG2-0002Na-7r
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 15:50:06 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1spvG0-0004N9-AW
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 15:50:05 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fc47abc040so29725585ad.0
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 12:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1726429802; x=1727034602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PDdg/dGFri1fJiok+0CaeP8qIyJ7xAqUj1+d3zXgH/o=;
 b=G6Ro0xCy1pmDY/zQ9LvrFF0LmgGlT4JYS1lmyesIWiw0RIWsKamTN6d1itnsQiuAov
 BqE4JgYTyEVviTn6taUfMrxC/BLTlhHp0cxeHY0bSk4ZxmZMCPOpwVUfLmmIRPQFaFL3
 h2g0FPiMR0Z5f4B+TIiW13T5EdXSnZDzwchNzV8U8RwzwaOH+cvWfVj8Fde4/baWc6/x
 34kAubWJb24pCPsbI7BSf1v/dNScdD453NXfPD1tDDj2gVmZ94bOVYS+A7W0WjPjHl0p
 nRc0eahdRRM/anucfJSlhOdjp+T6rVcfGK2RBy4OzwXMX50qBWnZmfnEov7lT9sFh8iK
 IXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726429802; x=1727034602;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PDdg/dGFri1fJiok+0CaeP8qIyJ7xAqUj1+d3zXgH/o=;
 b=hgygSdC8IQkPQHpG7wceV3qPKCILbjkK3v0U7GcLL/3kvPbVi+wClsv6s2119pcX7k
 gUHpm6o3NoxnGWK7RsyhJLXNPRv0qCQlJn9fawgakdhJxUs0nJcstUq5OM+paxfO716F
 XlW6aqzxtW4x0OteisnBx1uYdxRpabENBzS1WrBR+MviB23CNHqdXdLMd0/X2GHA4LFh
 zxfca766vlcmYwsLoot+XdhiuyKHVTzvnJH7LwQq0vuWguLgIYorlZachl/S0c1s9xVA
 8RY/ZB2sAM5TOq3Wn7wCBamq4j2LoOTJg89A/OXte16vxVMxotF7z77fB5fQRexTGXc2
 dgPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9c3De58kSDFJEQgfyzj3/P/YbCqyiaJa+xYexJ5NjLRpM8UGKYHz8xj34Dep+xX3eXhviVfRTHp+X@nongnu.org
X-Gm-Message-State: AOJu0Yw5UcTwxgB7JzR7uxKj8ZyXbsbSPS1cf4HW+b3ZY0ZJiAiZEdPf
 LQ3ARqKvIlnUXXPBDQXDSRiA/Jc38rJvrJNaomp9DWmu8t9ngaYbdOropHwka4c=
X-Google-Smtp-Source: AGHT+IFE/4nxbo1wB0i9IDpsQgUDMccdA3Os3/yTWmibuXfGOoswPYlcJgKg2DFiiYmNVYitOEWLAg==
X-Received: by 2002:a17:902:cf41:b0:200:abb6:4daf with SMTP id
 d9443c01a7336-2076e41299bmr177624465ad.39.1726429802329; 
 Sun, 15 Sep 2024 12:50:02 -0700 (PDT)
Received: from [192.168.68.110] (201-68-240-33.dsl.telesp.net.br.
 [201.68.240.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20794764130sm24856135ad.302.2024.09.15.12.49.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Sep 2024 12:50:01 -0700 (PDT)
Message-ID: <1521e34a-2759-4c07-bf99-01b7d734550b@ventanamicro.com>
Date: Sun, 15 Sep 2024 16:49:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 27/47] bsd-user: Add RISC-V CPU execution loop and syscall
 handling
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Ajeet Singh <itachis@FreeBSD.org>,
 Jessica Clarke <jrtc27@jrtc27.com>, Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
 <20240912052953.2552501-28-alistair.francis@wdc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240912052953.2552501-28-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
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



On 9/12/24 2:29 AM, Alistair Francis wrote:
> From: Mark Corbin <mark@dibsco.co.uk>
> 
> Implemented the RISC-V CPU execution loop, including handling various
> exceptions and system calls. The loop continuously executes CPU
> instructions,processes exceptions, and handles system calls by invoking
> FreeBSD syscall handlers.
> 
> Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
> Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20240907031927.1908-3-itachis@FreeBSD.org>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   bsd-user/riscv/target_arch_cpu.h | 94 ++++++++++++++++++++++++++++++++
>   1 file changed, 94 insertions(+)
> 
> diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
> index e17c910ae9..ea2a8d1ace 100644
> --- a/bsd-user/riscv/target_arch_cpu.h
> +++ b/bsd-user/riscv/target_arch_cpu.h
> @@ -36,4 +36,98 @@ static inline void target_cpu_init(CPURISCVState *env,
>       env->pc = regs->sepc;
>   }
>   

This patch won't build:

In file included from ../bsd-user/main.c:53:
../bsd-user/riscv/target_arch_cpu.h:126:13: error: call to undeclared function 'force_sig_fault'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
   126 |             force_sig_fault(signo, code, env->pc);
       |             ^
../bsd-user/riscv/target_arch_cpu.h:129:9: error: call to undeclared function 'process_pending_signals'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
   129 |         process_pending_signals(env);
       |         ^

You're missing the following header:


diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
index 57abfbd556..a93ea3915a 100644
--- a/bsd-user/riscv/target_arch_cpu.h
+++ b/bsd-user/riscv/target_arch_cpu.h
@@ -21,6 +21,7 @@
  #define TARGET_ARCH_CPU_H
  
  #include "target_arch.h"
+#include "signal-common.h"
  
  #define TARGET_DEFAULT_CPU_MODEL "max"





This diff will also fix this other build error:


../bsd-user/main.c:608:5: error: call to undeclared function 'signal_init'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
   608 |     signal_init();
       |     ^
3 errors generated.


Because bsd-user/main.c is including target_arch_cpu.h.





Thanks,

Daniel

> +static inline void target_cpu_loop(CPURISCVState *env)
> +{
> +    CPUState *cs = env_cpu(env);
> +    int trapnr;
> +    abi_long ret;
> +    unsigned int syscall_num;
> +    int32_t signo, code;
> +
> +    for (;;) {
> +        cpu_exec_start(cs);
> +        trapnr = cpu_exec(cs);
> +        cpu_exec_end(cs);
> +        process_queued_cpu_work(cs);
> +
> +        signo = 0;
> +
> +        switch (trapnr) {
> +        case EXCP_INTERRUPT:
> +            /* just indicate that signals should be handled asap */
> +            break;
> +        case EXCP_ATOMIC:
> +            cpu_exec_step_atomic(cs);
> +            break;
> +        case RISCV_EXCP_U_ECALL:
> +            syscall_num = env->gpr[xT0];
> +            env->pc += TARGET_INSN_SIZE;
> +            /* Compare to cpu_fetch_syscall_args() in riscv/riscv/trap.c */
> +            if (TARGET_FREEBSD_NR___syscall == syscall_num ||
> +                TARGET_FREEBSD_NR_syscall == syscall_num) {
> +                ret = do_freebsd_syscall(env,
> +                                         env->gpr[xA0],
> +                                         env->gpr[xA1],
> +                                         env->gpr[xA2],
> +                                         env->gpr[xA3],
> +                                         env->gpr[xA4],
> +                                         env->gpr[xA5],
> +                                         env->gpr[xA6],
> +                                         env->gpr[xA7],
> +                                         0);
> +            } else {
> +                ret = do_freebsd_syscall(env,
> +                                         syscall_num,
> +                                         env->gpr[xA0],
> +                                         env->gpr[xA1],
> +                                         env->gpr[xA2],
> +                                         env->gpr[xA3],
> +                                         env->gpr[xA4],
> +                                         env->gpr[xA5],
> +                                         env->gpr[xA6],
> +                                         env->gpr[xA7]
> +                    );
> +            }
> +
> +            /*
> +             * Compare to cpu_set_syscall_retval() in
> +             * riscv/riscv/vm_machdep.c
> +             */
> +            if (ret >= 0) {
> +                env->gpr[xA0] = ret;
> +                env->gpr[xT0] = 0;
> +            } else if (ret == -TARGET_ERESTART) {
> +                env->pc -= TARGET_INSN_SIZE;
> +            } else if (ret != -TARGET_EJUSTRETURN) {
> +                env->gpr[xA0] = -ret;
> +                env->gpr[xT0] = 1;
> +            }
> +            break;
> +        case RISCV_EXCP_ILLEGAL_INST:
> +            signo = TARGET_SIGILL;
> +            code = TARGET_ILL_ILLOPC;
> +            break;
> +        case RISCV_EXCP_BREAKPOINT:
> +            signo = TARGET_SIGTRAP;
> +            code = TARGET_TRAP_BRKPT;
> +            break;
> +        case EXCP_DEBUG:
> +            signo = TARGET_SIGTRAP;
> +            code = TARGET_TRAP_BRKPT;
> +            break;
> +        default:
> +            fprintf(stderr, "qemu: unhandled CPU exception "
> +                "0x%x - aborting\n", trapnr);
> +            cpu_dump_state(cs, stderr, 0);
> +            abort();
> +        }
> +
> +        if (signo) {
> +            force_sig_fault(signo, code, env->pc);
> +        }
> +
> +        process_pending_signals(env);
> +    }
> +}
> +
>   #endif /* TARGET_ARCH_CPU_H */

