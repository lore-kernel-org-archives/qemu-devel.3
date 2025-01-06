Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC64E77197
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 03:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUdNA-0006lA-EV; Sun, 05 Jan 2025 22:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUdN8-0006ki-Lz; Sun, 05 Jan 2025 22:01:42 -0500
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUdN6-00071L-Vv; Sun, 05 Jan 2025 22:01:42 -0500
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-5188b485988so4397757e0c.3; 
 Sun, 05 Jan 2025 19:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736132498; x=1736737298; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tlITjtL2yIaf1XY2Q19hu43l0Op7qilhp9dArVfezTc=;
 b=IB2l+O0DKNKU4zbdi47/EcxJvBc/qCGFM8WBP9wCWN6wlqNI4mQYuf1b9lznOr9WvD
 quVuuU4QBYw2I/L2Iotp31oQJfPXYn4qZDfZcIokmHgCxYgV+KVQy0UrD9itH7gBp2QN
 n5UMusDlSax6vRH3HKcHLdTG5mw4o+ZralyssjVVpAr/wCu0u+j2FB7hJtOhuAUcfcM3
 9txZnLeq9iJGbmV5YOLwIN8npyRO4OX8zs3I8pghUASQ4gELAeSQFqDdbYNXFUqC2ZKk
 2GAlW6aIqHH9nBlXQ3DQL3ocpLn1K37CtvILDoRl6g6mndFXEZKWWGI7IY5X1Bz7jmDB
 SLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736132498; x=1736737298;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tlITjtL2yIaf1XY2Q19hu43l0Op7qilhp9dArVfezTc=;
 b=cLLkrMud/OY2+hHs8D5ZDauxS9ioMQ0P+T6OasPXrQJWl9D+VSEWZKq1PHeMW+Qq69
 6buLIpnTu627Xxv64jahiGgsk7cHR25McB4PwS3bCo5qyh07d16FuPhFhOuR7o1CRBTE
 cibS9IoEbYOXnjckTjQkuovY5cXyML1R3elldMXZbtPXyPWdVj7TKBxuNiAhpTD6G/xX
 0gMcC2I+MTeF6/deQVUoxQMilf6NglkWLrd9keK6+caP4Jvm9Iu/HZ+EXA05NXkDQNsw
 aePf8hCmue7205/6+yiFuBzWitgo7LpUf8PYx91c+QIgR6ipqktFgUalOZhFHO/vNN+P
 sozg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMOcsPr4mRCimPLJeNR/2FrlUkl5tjQLbjbJdp37bcoYRPkTdgW80Cd8X2TLlbHtqitu3fNSDn1XJX@nongnu.org
X-Gm-Message-State: AOJu0YzKejrDR/3xnVUebpuS90/yrwwvaCmxGMNTcrsPLROigVOHNrl2
 ku9xooTYzeUX6HwuCKkXkNKUZjzKB050RZeDBhg1mDgNeYltV5ejr9AOYpNvWTVE4bICgYh5kmv
 wIurCwIByevbh0wAgZ6vASDy99Pw=
X-Gm-Gg: ASbGncu39anUlZcWqOsaIrZ9iDUogbtH4cKSLKHipGakoSEHiJ14FSVOYWzIyY3OKxM
 YMqvHrbH74qWmtwQ4V53zEYszX3DT+m+Kd4xOjj9fqgaDN5kLc5CPhv8wp3To+Y9E5rI=
X-Google-Smtp-Source: AGHT+IGAeg1pjDAYGOtueY0R+ccqU/EeEWyZsXxx+Ndki1oN2oVj+CkEgQZdM33be2DODa7S7q2u9eMoQy0ptX/iPPw=
X-Received: by 2002:a05:6122:2518:b0:516:240b:58ff with SMTP id
 71dfb90a1353d-51b75c5a3d0mr37031665e0c.5.1736132498650; Sun, 05 Jan 2025
 19:01:38 -0800 (PST)
MIME-Version: 1.0
References: <20241219174657.1988767-1-dbarboza@ventanamicro.com>
 <20241219174657.1988767-3-dbarboza@ventanamicro.com>
In-Reply-To: <20241219174657.1988767-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2025 13:01:12 +1000
Message-ID: <CAKmqyKMavWHJFzd_rThGzqcsioAoDMMD3=pLm2nJiOSO9V0XcA@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv: add trace in riscv_raise_exception()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Dec 20, 2024 at 3:48=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> When using system mode we can get the CPU traps being taken via the
> 'riscv_trap' trace or the "-d int" qemu log. User mode does not a way of
> logging/showing exceptions to users.
>
> Add a trace in riscv_raise_exception() to allow qemu-riscv(32/64) users
> to check all exceptions being thrown. This is particularly useful to
> help identifying insns that are throwing SIGILLs.
>
> As it is today we need to debug their binaries to identify where the
> illegal insns are:
>
> $ ~/work/qemu/build/qemu-riscv64 -cpu rv64 ./foo.out
> Illegal instruction (core dumped)
>
> After this change users can capture the trace and use EPC to pinpoint
> the insn:
>
> $ ~/work/qemu/build/qemu-riscv64 -cpu rv64 -trace riscv_exception ./foo.o=
ut
> riscv_exception 8 (user_ecall) on epc 0x17cd2
> riscv_exception 8 (user_ecall) on epc 0x17cda
> riscv_exception 8 (user_ecall) on epc 0x17622
> (...)
> riscv_exception 2 (illegal_instruction) on epc 0x1053a
> Illegal instruction (core dumped)
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/op_helper.c  | 6 ++++++
>  target/riscv/trace-events | 3 +++
>  2 files changed, 9 insertions(+)
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 29c104bc23..29de8eb43d 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -24,6 +24,7 @@
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
>  #include "exec/helper-proto.h"
> +#include "trace.h"
>
>  /* Exceptions processing helpers */
>  G_NORETURN void riscv_raise_exception(CPURISCVState *env,
> @@ -31,6 +32,11 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *e=
nv,
>                                        uintptr_t pc)
>  {
>      CPUState *cs =3D env_cpu(env);
> +
> +    trace_riscv_exception(exception,
> +                          riscv_cpu_get_trap_name(exception, false),
> +                          env->pc);
> +
>      cs->exception_index =3D exception;
>      cpu_loop_exit_restore(cs, pc);
>  }
> diff --git a/target/riscv/trace-events b/target/riscv/trace-events
> index 49ec4d3b7d..93837f82a1 100644
> --- a/target/riscv/trace-events
> +++ b/target/riscv/trace-events
> @@ -9,3 +9,6 @@ pmpaddr_csr_write(uint64_t mhartid, uint32_t addr_index, =
uint64_t val) "hart %"
>
>  mseccfg_csr_read(uint64_t mhartid, uint64_t val) "hart %" PRIu64 ": read=
 mseccfg, val: 0x%" PRIx64
>  mseccfg_csr_write(uint64_t mhartid, uint64_t val) "hart %" PRIu64 ": wri=
te mseccfg, val: 0x%" PRIx64
> +
> +# op_helper.c
> +riscv_exception(uint32_t exception, const char *desc, uint64_t epc) "%u =
(%s) on epc 0x%"PRIx64""
> --
> 2.47.1
>
>

