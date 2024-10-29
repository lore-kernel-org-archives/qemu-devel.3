Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5F6D5B86C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 03:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5crb-0001wm-Qg; Mon, 28 Oct 2024 23:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t5crZ-0001wB-CP; Mon, 28 Oct 2024 23:25:45 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t5crX-0000Iu-Jq; Mon, 28 Oct 2024 23:25:45 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-84fb1225a89so1405612241.2; 
 Mon, 28 Oct 2024 20:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730172341; x=1730777141; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ceLh86KrRAgpxR5vy7NRhx6WwXROcvyhrZ19hka8Hjo=;
 b=kZQ2rhfZ86YYVQ4FAQksA79tediPhqFCSlZHPh2sFoxlT/SLoVZVDleH+6dz4uBYMX
 /mzuZhreWhptYhKZZVaiygici81cjExekgu6jLca24liE3LUc5rqLZHGu4PncDVqTDMW
 XiRaQjJ54Rp5VovO9t3IrJ3OiZwoyQP/jIEsbfxl6LaNOnaYfQJVy2C7nzMsinzlYpWM
 x40+0FwfZwNzZkLIt1QMb/V/d6c9WKhDJf5ISXAb4snOBEzbM1uM7l+oPAKfmt2GX+ue
 ciJW3Q5JEZyZHZWIz/bhV6IHUPtSm+dSrcCzsm2FhJgbRDiqDcpi2sQyzi2LEh9N+idN
 +Zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730172341; x=1730777141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ceLh86KrRAgpxR5vy7NRhx6WwXROcvyhrZ19hka8Hjo=;
 b=JtED3xz0Gemqp9pNZGV1nOfIR50LWwnoYoivbHoHS3BfwKXx7yXVL+ZWAc/mQrnLHl
 ySSaUIFFm5wsVK8p3w2NIjm1EvO3bAQygiN7czHVcaaj1+52Q+/PNr318fSNUlxam3sb
 LVoxZGalhmeuTrLlUzSssZ0G63vYKnYxQBLcZLjUoCV6QSb9FUOUsy6mqWW2Zz7S+anm
 QqGPz74AH+5dF8S+v8E7TUs6MpmnpcL3S7XSRJgqJPCbN4epWnShxKCpZIxN0b2H70A0
 So40fG6MJxCofwazYgwkY3lFMops9apNc4yVuRUY0y+bWhPYCWmv3U7WhgrQlLRhDAgV
 y85Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj+5oHvbF42XdH2iOLfv5f4GsLoSD/EkgyC+17SRyISQpILsZ71WqDGpla3N+Dwl7yLzA9z9JAHE7J@nongnu.org
X-Gm-Message-State: AOJu0YxdA0qyqoW9zsKaV/vsB8zs+KGhIlhqhe0kb+Zlb7xpPPsrHkIn
 WlBucu3huST4U0j7GXfzflw2LD7kwVbzQEcXhplPPQf3HcrweEGztP3bZ/nAUYJkG54zjIpAf/j
 NRh2bm8ttj/erWhUAdI9ECSmFAys=
X-Google-Smtp-Source: AGHT+IHpcLedNA8yD2pNMd0adI6136xpFt38Wn8EqZV+oR9h20jalTqXfP/SzKPYhn4+7LjaJGUtoTtBMRZbhCtVAbo=
X-Received: by 2002:a05:6122:a11:b0:509:e80:3ed2 with SMTP id
 71dfb90a1353d-51015055cf8mr7421564e0c.7.1730172341500; Mon, 28 Oct 2024
 20:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20241008225010.1861630-1-debug@rivosinc.com>
 <20241008225010.1861630-5-debug@rivosinc.com>
In-Reply-To: <20241008225010.1861630-5-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 Oct 2024 13:25:15 +1000
Message-ID: <CAKmqyKPX2nyxyfRDAmfDd0HCO+gFr9bnNY_3ewgrcAY+Zd+hvA@mail.gmail.com>
Subject: Re: [PATCH v16 04/20] target/riscv: save and restore elp state on
 priv transitions
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, 
 kito.cheng@sifive.com, Andy Chiu <andy.chiu@sifive.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
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

On Wed, Oct 9, 2024 at 8:52=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> wr=
ote:
>
> elp state is recorded in *status on trap entry (less privilege to higher
> privilege) and restored in elp from *status on trap exit (higher to less
> privilege).
>
> Additionally this patch introduces a forward cfi helper function to
> determine if current privilege has forward cfi is enabled or not based on
> *envcfg (for U, VU, S, VU, HS) or mseccfg csr (for M).
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Co-developed-by: Jim Shu <jim.shu@sifive.com>
> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h        |  1 +
>  target/riscv/cpu_helper.c | 54 +++++++++++++++++++++++++++++++++++++++
>  target/riscv/op_helper.c  | 17 ++++++++++++
>  3 files changed, 72 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index e9f26b5121..6c5e199e72 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -547,6 +547,7 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_=
ulong geilen);
>  bool riscv_cpu_vector_enabled(CPURISCVState *env);
>  void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
>  int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
> +bool cpu_get_fcfien(CPURISCVState *env);
>  G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>                                                 MMUAccessType access_type=
,
>                                                 int mmu_idx, uintptr_t re=
taddr);
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index a935377b4a..d7b776c556 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -33,6 +33,7 @@
>  #include "cpu_bits.h"
>  #include "debug.h"
>  #include "tcg/oversized-guest.h"
> +#include "pmp.h"
>
>  int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
>  {
> @@ -63,6 +64,33 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetc=
h)
>  #endif
>  }
>
> +bool cpu_get_fcfien(CPURISCVState *env)
> +{
> +    /* no cfi extension, return false */
> +    if (!env_archcpu(env)->cfg.ext_zicfilp) {
> +        return false;
> +    }
> +
> +    switch (env->priv) {
> +    case PRV_U:
> +        if (riscv_has_ext(env, RVS)) {
> +            return env->senvcfg & SENVCFG_LPE;
> +        }
> +        return env->menvcfg & MENVCFG_LPE;
> +#ifndef CONFIG_USER_ONLY
> +    case PRV_S:
> +        if (env->virt_enabled) {
> +            return env->henvcfg & HENVCFG_LPE;
> +        }
> +        return env->menvcfg & MENVCFG_LPE;
> +    case PRV_M:
> +        return env->mseccfg & MSECCFG_MLPE;
> +#endif
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>  void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>                            uint64_t *cs_base, uint32_t *pflags)
>  {
> @@ -546,6 +574,15 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *e=
nv)
>      }
>      bool current_virt =3D env->virt_enabled;
>
> +    /*
> +     * If zicfilp extension available and henvcfg.LPE =3D 1,
> +     * then apply SPELP mask on mstatus
> +     */
> +    if (env_archcpu(env)->cfg.ext_zicfilp &&
> +        get_field(env->henvcfg, HENVCFG_LPE)) {
> +        mstatus_mask |=3D SSTATUS_SPELP;
> +    }
> +
>      g_assert(riscv_has_ext(env, RVH));
>
>      if (current_virt) {
> @@ -1760,6 +1797,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      if (env->priv <=3D PRV_S && cause < 64 &&
>          (((deleg >> cause) & 1) || s_injected || vs_injected)) {
>          /* handle the trap in S-mode */
> +        /* save elp status */
> +        if (cpu_get_fcfien(env)) {
> +            env->mstatus =3D set_field(env->mstatus, MSTATUS_SPELP, env-=
>elp);
> +        }
> +
>          if (riscv_has_ext(env, RVH)) {
>              uint64_t hdeleg =3D async ? env->hideleg : env->hedeleg;
>
> @@ -1808,6 +1850,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          riscv_cpu_set_mode(env, PRV_S, virt);
>      } else {
>          /* handle the trap in M-mode */
> +        /* save elp status */
> +        if (cpu_get_fcfien(env)) {
> +            env->mstatus =3D set_field(env->mstatus, MSTATUS_MPELP, env-=
>elp);
> +        }
> +
>          if (riscv_has_ext(env, RVH)) {
>              if (env->virt_enabled) {
>                  riscv_cpu_swap_hypervisor_regs(env);
> @@ -1839,6 +1886,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          riscv_cpu_set_mode(env, PRV_M, virt);
>      }
>
> +    /*
> +     * Interrupt/exception/trap delivery is asynchronous event and as pe=
r
> +     * zicfilp spec CPU should clear up the ELP state. No harm in cleari=
ng
> +     * unconditionally.
> +     */
> +    env->elp =3D false;
> +
>      /*
>       * NOTE: it is not necessary to yield load reservations here. It is =
only
>       * necessary for an SC from "another hart" to cause a load reservati=
on
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 25a5263573..eddedacf4b 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -309,6 +309,15 @@ target_ulong helper_sret(CPURISCVState *env)
>
>      riscv_cpu_set_mode(env, prev_priv, prev_virt);
>
> +    /*
> +     * If forward cfi enabled for new priv, restore elp status
> +     * and clear spelp in mstatus
> +     */
> +    if (cpu_get_fcfien(env)) {
> +        env->elp =3D get_field(env->mstatus, MSTATUS_SPELP);
> +    }
> +    env->mstatus =3D set_field(env->mstatus, MSTATUS_SPELP, 0);
> +
>      return retpc;
>  }
>
> @@ -349,6 +358,14 @@ target_ulong helper_mret(CPURISCVState *env)
>      }
>
>      riscv_cpu_set_mode(env, prev_priv, prev_virt);
> +    /*
> +     * If forward cfi enabled for new priv, restore elp status
> +     * and clear mpelp in mstatus
> +     */
> +    if (cpu_get_fcfien(env)) {
> +        env->elp =3D get_field(env->mstatus, MSTATUS_MPELP);
> +    }
> +    env->mstatus =3D set_field(env->mstatus, MSTATUS_MPELP, 0);
>
>      return retpc;
>  }
> --
> 2.45.0
>
>

