Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7B3CE7AA6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 00:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smMo1-00046F-5X; Thu, 05 Sep 2024 20:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smMny-00043N-Lt
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 20:26:27 -0400
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smMnx-0001dC-3S
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 20:26:26 -0400
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-49bc42bec6dso448525137.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 17:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725582384; x=1726187184; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ogDSlmXA/CPYUsN3fdN98mZzfZE0/vc4+zkoRTrQbDo=;
 b=WAzADRej4NRInZ7u5iRUp1vifiCM+HKWsnxLu8fevy7+pO28GjOnZzb675L2xF2CLl
 +FtVq5Fzn7M39MJQTL+JVw5IVnXbS+63/jRaWJSaOQ3OZRL2haIkiDClj+fIVHDxw7uA
 qZUzKm1HFy1Ex3Do6S3oRLq0xZHJK+qUm/b90DggSttcEMfUaiTnVfJPJ1Dnag9lNSuf
 g25wqvrrLF/IU9Xnn/7p/wTqJLDMzvpyHItrvXjQ+dho97HwWRg4+QQioRRSMW854sMI
 FTwddqnHivyO0cy6UXr1QtOVhcle6DnUwF+l+eOKaADarXhtdy83UFnmX/4XQI6nV7eL
 hIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725582384; x=1726187184;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ogDSlmXA/CPYUsN3fdN98mZzfZE0/vc4+zkoRTrQbDo=;
 b=c7praDrtVndoaSHOoC11EOIztJGPoWN6IE7smp4ElCDoHkfB47oJfD5Nke4sk8f9KJ
 Mks75mA6Oo71lAG8lpyHLiFR7SGRsHA4J2X9mlVRh77L26kaqnUYCdfb4f7e7oJTBHqj
 DmoTlsWwUGDF/i3GYDGTCdMpxNgdQZxrsgFre3qhh1PMpzH8y+itbRwP92RHBEOfspDY
 jTKw9KWpiVddsWlAAw+cBjiiDrZue+WN2uOOwa5mTsThPdj+hYZQlyqtQExZDmqM+pR/
 V6WeuL5FdBPr1BFQ8vCAvF/HZxdl3iz8iVC6UVIQMQ6nBq5wUXA5OBqnpvJC5/jljBaL
 hzoQ==
X-Gm-Message-State: AOJu0YwSY/xdyXAHV9wZvdngx/3oLgCy0OQJiBidapclctA9e+apBTlx
 M7YJL0GHw+z3he43oJHbr2zlEJ10xFB7LxUt79Bk9dCpFbx7UIhpEHe6P/OqI4YBVDfMm3B0liL
 KU9g2pu8+8JIZEWbfS4BnuBfK298=
X-Google-Smtp-Source: AGHT+IGeF8qzzmqtkXb0rJ/JDuOFg1KWMLHcLC2viIxCHgF3bR9QPu5Z6sgDX8rZzO8bqCPqNfW62AhNXVLquumkUlQ=
X-Received: by 2002:a05:6102:4194:b0:48f:dfb8:77aa with SMTP id
 ada2fe7eead31-49bde1af558mr1361506137.17.1725582383884; Thu, 05 Sep 2024
 17:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240828095243.90491-1-itachis@FreeBSD.org>
 <20240828095243.90491-3-itachis@FreeBSD.org>
In-Reply-To: <20240828095243.90491-3-itachis@FreeBSD.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2024 10:25:57 +1000
Message-ID: <CAKmqyKMVmF1cXpwca+P2DgYSQ7-Vrny3LO6++2wgKPTrmFeNVQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/17] bsd-user: Add RISC-V CPU execution loop and
 syscall handling
To: Ajeet Singh <itachis6234@gmail.com>
Cc: qemu-devel@nongnu.org, Mark Corbin <mark@dibsco.co.uk>,
 Warner Losh <imp@bsdimp.com>, 
 Ajeet Singh <itachis@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@freebsd.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
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

On Wed, Aug 28, 2024 at 7:53=E2=80=AFPM Ajeet Singh <itachis6234@gmail.com>=
 wrote:
>
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
> ---
>  bsd-user/riscv/target_arch_cpu.h | 94 ++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>
> diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arc=
h_cpu.h
> index e17c910ae9..ba589909e2 100644
> --- a/bsd-user/riscv/target_arch_cpu.h
> +++ b/bsd-user/riscv/target_arch_cpu.h
> @@ -36,4 +36,98 @@ static inline void target_cpu_init(CPURISCVState *env,
>      env->pc =3D regs->sepc;
>  }
>
> +static inline void target_cpu_loop(CPURISCVState *env)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +    int trapnr;
> +    abi_long ret;
> +    unsigned int syscall_num;
> +    int32_t signo, code;
> +
> +    for (;;) {
> +        cpu_exec_start(cs);
> +        trapnr =3D cpu_exec(cs);
> +        cpu_exec_end(cs);
> +        process_queued_cpu_work(cs);
> +
> +        signo =3D 0;
> +
> +        switch (trapnr) {
> +        case EXCP_INTERRUPT:
> +            /* just indicate that signals should be handled asap */
> +            break;
> +        case EXCP_ATOMIC:
> +            cpu_exec_step_atomic(cs);
> +            break;
> +        case RISCV_EXCP_U_ECALL:
> +            syscall_num =3D env->gpr[xT0];
> +            env->pc +=3D TARGET_INSN_SIZE;
> +            /* Compare to cpu_fetch_syscall_args() in riscv/riscv/trap.c=
 */
> +            if (TARGET_FREEBSD_NR___syscall =3D=3D syscall_num ||
> +                TARGET_FREEBSD_NR_syscall =3D=3D syscall_num) {
> +                ret =3D do_freebsd_syscall(env,
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
> +                ret =3D do_freebsd_syscall(env,
> +                                         syscall_num,
> +                                         env->gpr[xA0],
> +                                         env->gpr[xA1],
> +                                         env->gpr[xA2],
> +                                         env->gpr[xA3],
> +                                         env->gpr[xA4],
> +                                         env->gpr[xA5],
> +                                         env->gpr[xA6],
> +                                         env->gpr[xA7]

There is trailing white space on these lines and in a few other
patches in this series.

Can you run ./scripts/checkpatch.pl against the changes and then send
a v5 with the issues addressed

Alistair

> +                    );
> +            }
> +
> +            /*
> +             * Compare to cpu_set_syscall_retval() in
> +             * riscv/riscv/vm_machdep.c
> +             */
> +            if (ret >=3D 0) {
> +                env->gpr[xA0] =3D ret;
> +                env->gpr[xT0] =3D 0;
> +            } else if (ret =3D=3D -TARGET_ERESTART) {
> +                env->pc -=3D TARGET_INSN_SIZE;
> +            } else if (ret !=3D -TARGET_EJUSTRETURN) {
> +                env->gpr[xA0] =3D -ret;
> +                env->gpr[xT0] =3D 1;
> +            }
> +            break;
> +        case RISCV_EXCP_ILLEGAL_INST:
> +            signo =3D TARGET_SIGILL;
> +            code =3D TARGET_ILL_ILLOPC;
> +            break;
> +        case RISCV_EXCP_BREAKPOINT:
> +            signo =3D TARGET_SIGTRAP;
> +            code =3D TARGET_TRAP_BRKPT;
> +            break;
> +        case EXCP_DEBUG:
> +            signo =3D TARGET_SIGTRAP;
> +            code =3D TARGET_TRAP_BRKPT;
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
>  #endif /* TARGET_ARCH_CPU_H */
> --
> 2.34.1
>
>

