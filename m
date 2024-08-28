Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA14C71150
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 23:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjSAf-0005ZC-8k; Wed, 28 Aug 2024 19:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjSAd-0005VM-Ld; Wed, 28 Aug 2024 19:33:47 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjSAb-0001Rs-UI; Wed, 28 Aug 2024 19:33:47 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4fd117e0008so30910e0c.3; 
 Wed, 28 Aug 2024 16:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724888024; x=1725492824; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2uUONyEyHw6Q5e8/L50W7Uj5ByRJrhhl2kikUcrcjw=;
 b=g6JK8Bx+okGKzkyiO8PoepwP8stVO9QjgqzPUz3ADiuYrcxRsO0ba+7SHtYF/XvZPs
 Yn+fKwn2D8F6KtULVUQWbFk7n2iGzFSSTB9QGJSho5eZRj2hW7Of/THvhYOz1Z/jfkSV
 xNVigoDYecS7wgPs1p59Ihn9Re/CbDrXLS+M8u+YqJ4V66uEmwooSNlp1zx+TlBqMkXQ
 viL2KRIBO8O2/ANI3QHapohAmxX6eCGraoAs6RdrWpv9kxIwxWWVLX68uKI7vZfZhXHX
 9BNzNgCOujb2VTdfGuc03AfEBrGCRwTsld1f5LYFCFl0j6RBcKm9xqAyCIaJrCB3yZaK
 32JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724888024; x=1725492824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N2uUONyEyHw6Q5e8/L50W7Uj5ByRJrhhl2kikUcrcjw=;
 b=FIzr5ocCEWgGtOw37fKYmyuZuVjgxFVsbuEqOH/r+DPE+0yJT59fvvR2wiuYbZxrZ7
 mDMSEE1IkdltAMuegCXuDqm5MgNUxQ36dNYyHmflD1ZBcCGr5D1EbuJ/emFqrllXKhBU
 sL8BFzITfTqdiicjgnk2FiPyqo0F1zHoVBdDKKU3O8vMgzqfD23nxIyQPwpI/aUKZEAd
 bjqe5CUowedM3PYa3e752xlJUiX0IkFmSi0/63YI89GOmEvcVFUv8oZWQK8NBjfwrvHH
 gnuNzd46cQ/2zU+FHZPiZHaPYkvJP3nBqGCZtEh/Dn0kFKr0KqCDwT+ZoPQHgP8H5KT8
 w+eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2gidPqDgxpONKB9zxzhAPDeB0F9f1ZHtckdoZj5m/lFTTsd5BMW4osHEwPPghf0X9cXzLtb1jRo7j@nongnu.org
X-Gm-Message-State: AOJu0Yxh2Vo+FwrQjLDsn8EfwvpMLhOd4Ucp/8aW1NVXr6ntsMaF0gw7
 feB5uJ2yRYzhmGkTeQq1ePEYpjey/CBEqDKeKDRVljgXIW1lzKct/zELtfo/zVN2uQV8k5yH0Bh
 4wxrmgZjISTSfOYTCXJeOm77Axpg=
X-Google-Smtp-Source: AGHT+IHocxAgiFzrtlYkt/7RSlStATgOFkwfzqxX4sMZRvWmnhIIBiMgQ8EYzGdbCV+NxoaSgMG+2UmwqYJl0sK6hgY=
X-Received: by 2002:a05:6122:3d13:b0:4f6:b094:80b1 with SMTP id
 71dfb90a1353d-4fff16e37cemr1084270e0c.11.1724888024030; Wed, 28 Aug 2024
 16:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240828174739.714313-1-debug@rivosinc.com>
 <20240828174739.714313-15-debug@rivosinc.com>
In-Reply-To: <20240828174739.714313-15-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 29 Aug 2024 09:33:17 +1000
Message-ID: <CAKmqyKOMNxZE9S_xB8NTfceN_f3EHeQOB6oVFJj2wMXdLPbe4A@mail.gmail.com>
Subject: Re: [PATCH v11 14/20] target/riscv: AMO operations always raise
 store/AMO fault
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Thu, Aug 29, 2024 at 3:49=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> This patch adds one more word for tcg compile which can be obtained durin=
g
> unwind time to determine fault type for original operation (example AMO).
> Depending on that, fault can be promoted to store/AMO fault.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h         |  9 ++++++++-
>  target/riscv/cpu_helper.c  | 20 ++++++++++++++++++++
>  target/riscv/tcg/tcg-cpu.c |  1 +
>  target/riscv/translate.c   |  2 +-
>  4 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index e758f4497e..0a13604e37 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -46,8 +46,13 @@ typedef struct CPUArchState CPURISCVState;
>  /*
>   * RISC-V-specific extra insn start words:
>   * 1: Original instruction opcode
> + * 2: more information about instruction
>   */
> -#define TARGET_INSN_START_EXTRA_WORDS 1
> +#define TARGET_INSN_START_EXTRA_WORDS 2
> +/*
> + * b0: Whether a instruction always raise a store AMO or not.
> + */
> +#define RISCV_UW2_ALWAYS_STORE_AMO 1
>
>  #define RV(x) ((target_ulong)1 << (x - 'A'))
>
> @@ -226,6 +231,8 @@ struct CPUArchState {
>      bool      elp;
>      /* shadow stack register for zicfiss extension */
>      target_ulong ssp;
> +    /* env place holder for extra word 2 during unwind */
> +    target_ulong excp_uw2;
>      /* sw check code for sw check exception */
>      target_ulong sw_check_code;
>  #ifdef CONFIG_USER_ONLY
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 39544cade6..8294279b01 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1741,6 +1741,22 @@ static target_ulong riscv_transformed_insn(CPURISC=
VState *env,
>      return xinsn;
>  }
>
> +static target_ulong promote_load_fault(target_ulong orig_cause)
> +{
> +    switch (orig_cause) {
> +    case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
> +        return RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
> +
> +    case RISCV_EXCP_LOAD_ACCESS_FAULT:
> +        return RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
> +
> +    case RISCV_EXCP_LOAD_PAGE_FAULT:
> +        return RISCV_EXCP_STORE_PAGE_FAULT;
> +    }
> +
> +    /* if no promotion, return original cause */
> +    return orig_cause;
> +}
>  /*
>   * Handle Traps
>   *
> @@ -1752,6 +1768,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
>      CPURISCVState *env =3D &cpu->env;
>      bool write_gva =3D false;
> +    bool always_storeamo =3D (env->excp_uw2 & RISCV_UW2_ALWAYS_STORE_AMO=
);
>      uint64_t s;
>
>      /*
> @@ -1785,6 +1802,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          case RISCV_EXCP_STORE_AMO_ACCESS_FAULT:
>          case RISCV_EXCP_LOAD_PAGE_FAULT:
>          case RISCV_EXCP_STORE_PAGE_FAULT:
> +            if (always_storeamo) {
> +                cause =3D promote_load_fault(cause);
> +            }
>              write_gva =3D env->two_stage_lookup;
>              tval =3D env->badaddr;
>              if (env->two_stage_indirect_lookup) {
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 4da26cb926..83771303a8 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -129,6 +129,7 @@ static void riscv_restore_state_to_opc(CPUState *cs,
>          env->pc =3D pc;
>      }
>      env->bins =3D data[1];
> +    env->excp_uw2 =3D data[2];
>  }
>
>  static const TCGCPUOps riscv_tcg_ops =3D {
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index b1d251e893..16fff70dac 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1265,7 +1265,7 @@ static void riscv_tr_insn_start(DisasContextBase *d=
cbase, CPUState *cpu)
>          pc_next &=3D ~TARGET_PAGE_MASK;
>      }
>
> -    tcg_gen_insn_start(pc_next, 0);
> +    tcg_gen_insn_start(pc_next, 0, 0);
>      ctx->insn_start_updated =3D false;
>  }
>
> --
> 2.44.0
>
>

