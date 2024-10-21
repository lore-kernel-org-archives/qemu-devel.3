Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC22D3C934
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 01:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2h0E-00036V-7o; Sun, 20 Oct 2024 21:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2h0B-00035r-M9; Sun, 20 Oct 2024 21:14:31 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2h0A-0004et-3z; Sun, 20 Oct 2024 21:14:31 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-84fd2310413so1172290241.0; 
 Sun, 20 Oct 2024 18:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729473268; x=1730078068; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t3pUGYD9yZmntaoz3OP/AzCFq7gn7NKRuWKUMfunMr4=;
 b=Byz/3a5qAqrK4jKz1Y9WbMHzuZSUS9SrZc/TuTwEJt08++0ZugEl+lMVyhsKrviq/I
 2/XqfbqMAIaHHn/C0q4OusW4NeuHcmJAO5x//9bH+tVFenoVTMjOh23rTOk3a8nARyV1
 wQXifM8+VLrQw16aJIQxxZ9rTwsYJHqLfxreNXBZ8XFAlvz8/gg2mmNw7AAPfVnSitxf
 uA2zO4xUXx4FQn1OCa0VxCjgtgMHmZjVc3gemF7w0a+hyxoVRQzU9ShLhuc8J+q5TSkJ
 Eua+MF7IcZ+KpGWIuQMpw5WNurLv1sIzZ/rj3iYlMPs28d495UZCdr0ugxwvBrRWiJig
 wMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729473268; x=1730078068;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t3pUGYD9yZmntaoz3OP/AzCFq7gn7NKRuWKUMfunMr4=;
 b=N4ogYdgW0KkWkd1/LLgyK8QTrZD0KhjTYJKFuzrDg/mo/3XdKk1xnNIdHwW5lAz9J5
 RWAIy5iCqxSz4UxuBKWOGVdRyFMWeGjjWiaXwmYdsUkhtrjc7cTtbMn/DvtOk0T0OmHz
 FMLHFCam+16gPE72Jv5S+QNjotG0dmLqsb5OkynQabeUxNXC8c3VaLHwRLPppU3O3jNp
 aLbF25k4nPNS4VnM0f60JV+HvHveO53/AztVfwEP/izWPXcVrNpGAikNichxHcFzq/ai
 2s7QmlFQY/GTrJsDNIKvrbh+Szn9lNEPe8m5MufLcm6gZ2doLhnYpBTB1bwsqEy4yNfo
 Xf5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWJXaJKcCGiVJ6WmbawdBZPlZx8qnX0GXZYT9tmWfKkLDy8bUNmp98g9JSp/4IbsGTvavQf3BybSMD@nongnu.org
X-Gm-Message-State: AOJu0YzuOYihysf3QaG7HhOQ5N61wxf36diA0IGU5uRH8osiQa5LibmX
 bfghc94exJP8raP5iCash5X9GhBhoQNn+uFB6i0o4QQEo+pI71zL5DJyuMf+nmhUu0Ja7U1aAhd
 SLE8XCBYINTD9GKeOhvxDhj6GhcI=
X-Google-Smtp-Source: AGHT+IEsOCafehD/GDGI8fAsXfNRYRJlnkzHrFBHG8atvYS07XxI9QNdxrZfKqPODFuzUkucEemGW+0qpGemiKT8oKk=
X-Received: by 2002:a05:6102:3f4e:b0:4a3:bfd2:a880 with SMTP id
 ada2fe7eead31-4a5d6be2d09mr9876550137.28.1729473268377; Sun, 20 Oct 2024
 18:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20241017145226.365825-1-cleger@rivosinc.com>
 <20241017145226.365825-9-cleger@rivosinc.com>
In-Reply-To: <20241017145226.365825-9-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2024 11:14:02 +1000
Message-ID: <CAKmqyKMGTkac+0vhx=vEDKNrJnFLwxBzebCV4iZe4QHtNExPfQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] target/riscv: Implement Smdbltrp behavior
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
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

On Fri, Oct 18, 2024 at 12:54=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
> When the Smsdbltrp ISA extension is enabled, if a trap happens while
> MSTATUS.MDT is already set, it will trigger an abort or an NMI is the
> Smrnmi extension is available.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 52 +++++++++++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 18 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 623a3abbf7..8825572d5e 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1703,6 +1703,17 @@ static target_ulong riscv_transformed_insn(CPURISC=
VState *env,
>      return xinsn;
>  }
>
> +static void riscv_do_nmi(CPURISCVState *env, target_ulong cause, bool vi=
rt)
> +{
> +    env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_NMIE, false);
> +    env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_MNPV, virt);
> +    env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_MNPP, env->priv)=
;
> +    env->mncause =3D cause;
> +    env->mnepc =3D env->pc;
> +    env->pc =3D env->rnmi_irqvec;
> +    riscv_cpu_set_mode(env, PRV_M, false);
> +}
> +
>  /*
>   * Handle Traps
>   *
> @@ -1741,15 +1752,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      bool nnmi_excep =3D false;
>
>      if (cpu->cfg.ext_smrnmi && env->rnmip && async) {
> -        env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_NMIE, false)=
;
> -        env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_MNPV,
> -                                  env->virt_enabled);
> -        env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_MNPP,
> -                                  env->priv);
> -        env->mncause =3D cause | ((target_ulong)1U << (TARGET_LONG_BITS =
- 1));
> -        env->mnepc =3D env->pc;
> -        env->pc =3D env->rnmi_irqvec;
> -        riscv_cpu_set_mode(env, PRV_M, virt);
> +        riscv_do_nmi(env, cause | ((target_ulong)1U << (TARGET_LONG_BITS=
 - 1)),
> +                     virt);
>          return;
>      }
>
> @@ -1932,11 +1936,32 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>              /* Trapping to M mode, virt is disabled */
>              virt =3D false;
>          }
> +        /*
> +         * If the hart encounters an exception while executing in M-mode=
,
> +         * with the mnstatus.NMIE bit clear, the program counter is set =
to
> +         * the RNMI exception trap handler address.
> +         */
> +        nnmi_excep =3D cpu->cfg.ext_smrnmi &&
> +                     !get_field(env->mnstatus, MNSTATUS_NMIE) &&
> +                     !async;
>
>          s =3D env->mstatus;
>          s =3D set_field(s, MSTATUS_MPIE, get_field(s, MSTATUS_MIE));
>          s =3D set_field(s, MSTATUS_MPP, env->priv);
>          s =3D set_field(s, MSTATUS_MIE, 0);
> +        if (cpu->cfg.ext_smdbltrp) {
> +            if (env->mstatus & MSTATUS_MDT) {
> +                assert(env->priv =3D=3D PRV_M);
> +                if (!cpu->cfg.ext_smrnmi || nnmi_excep) {
> +                    cpu_abort(CPU(cpu), "M-mode double trap\n");
> +                } else {
> +                    riscv_do_nmi(env, cause, false);
> +                    return;
> +                }
> +            }
> +
> +            s =3D set_field(s, MSTATUS_MDT, 1);
> +        }
>          env->mstatus =3D s;
>          mxlen =3D 16 << riscv_cpu_mxl(env);
>          env->mcause =3D cause | ((target_ulong)async << (mxlen - 1));
> @@ -1950,15 +1975,6 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          env->mtval =3D tval;
>          env->mtinst =3D tinst;
>
> -        /*
> -         * If the hart encounters an exception while executing in M-mode=
,
> -         * with the mnstatus.NMIE bit clear, the program counter is set =
to
> -         * the RNMI exception trap handler address.
> -         */
> -        nnmi_excep =3D cpu->cfg.ext_smrnmi &&
> -                     !get_field(env->mnstatus, MNSTATUS_NMIE) &&
> -                     !async;
> -
>          if (nnmi_excep) {
>              env->pc =3D env->rnmi_excpvec;
>          } else {
> --
> 2.45.2
>
>

