Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B3CE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 04:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUecm-0001gz-VW; Sun, 05 Jan 2025 23:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUecl-0001gl-Vv; Sun, 05 Jan 2025 23:21:56 -0500
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUeck-0006c7-FR; Sun, 05 Jan 2025 23:21:55 -0500
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-85b92397fe2so2112390241.3; 
 Sun, 05 Jan 2025 20:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736137313; x=1736742113; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UePU0F6CHdK8zhadkxr+KP3RD7MCuHXw9cDqB2jyveM=;
 b=hh6ho5eVutvTLwVdUZpprZ6y8GXg21gmkscLS3Mbo5BczwOU+dEdeUfI+yXhEuk5Qs
 +2p9zQdnBVrnrqnW3HShLqi8vFfF/Ks051xTsV7qtW9FNKE9VxTaGlvKN/hmGfXAyb1f
 ZjyBmepLTsl6xKebQnClPcAIJB08VnW0l7qD4rYdA/YIROx6lftryD4l2SYNH9XyoCAZ
 e7ELWSLlZspYgWqlwv+2UeE7FFNBygMKqUhX9DSU2UdoDNpGHE44wPuCe+bjUW9dqUzP
 XfpnL30YN8Fg/tyDCaZZaZ0DEVZ8ukZ+fkOU/bDmGt+nixxkFAFbJHK2JnEVUiLU1JCW
 ikJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736137313; x=1736742113;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UePU0F6CHdK8zhadkxr+KP3RD7MCuHXw9cDqB2jyveM=;
 b=rXol5LcqjM1pf9ZcFaypSRoF5+mOxX4qO70IIMzXPX+pxcoSYF89aoaOjGtVwE73EC
 p2zJb2ERvHlg3Aw2KMnczQP9HSY+6Q5kCXMDj5Sb0i0a4ezebyJbSkMVNW9nFVm4Haq7
 KjfIq7Ds7fTm1ERwW+Z9C16+PdymYXtIC6ME6ecqPZgIOccXeEG8FYyRqkc68LZz92ZH
 r/Vccunj564vMvCFc2gpZdN3TNFlRZNSvaaCyj4x0VXJzY+M4vgT5OLclD2adDPM1SJf
 Q0e3coEJ1qDsExr1crR2YkpPwh6Qo1WKsi67Lkxwoc8po4OySinwRJaHLqtV/Nlb0DTA
 TMkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDBEDSE9y2wE3c8Danl5hBw0iJp9E5yYhSAS29VZUOZ7TUrqPLe0DbnNyPi8xPqW2+o/Lr/gQBc++h@nongnu.org
X-Gm-Message-State: AOJu0YykfX4s7Q77774EX+q0FonaKEsJf/lYocZN/nVVcz6Uu09xhXXk
 /TVeuLlC2sy5ig9zwAIH88NUidNiWpQzubismInn7DGcPqStvluhJaJWV14cdqC5UZsEc0Vpt5r
 wMhdRXku82I6bdEsfQYDc+p4PtrY=
X-Gm-Gg: ASbGncvmJt2GNdjx8prt9lf5VE5c5IAs1AU3X0d15pFB904EAwOnGhpi9CapSTb3ZSe
 DqGk171zkk69g1OlaNb+8DuRGU+yhnawfwwCjLeGoSTzV1+ApRDmAKFspEeB6+GKpEwY=
X-Google-Smtp-Source: AGHT+IHtwVtSLOhrLFu7QiaCikwtfNpoqSd0c/GfeFxKV8SyiwbKR2fGsypwccFLwHPIWrooXZlhyim6JDyAa5Vm1ZQ=
X-Received: by 2002:a05:6102:549f:b0:4b2:7996:6ba4 with SMTP id
 ada2fe7eead31-4b2cc48a41cmr42883993137.25.1736137312969; Sun, 05 Jan 2025
 20:21:52 -0800 (PST)
MIME-Version: 1.0
References: <20241231032654.133039-1-frank.chang@sifive.com>
 <20241231032654.133039-7-frank.chang@sifive.com>
In-Reply-To: <20241231032654.133039-7-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2025 14:21:27 +1000
Message-ID: <CAKmqyKP8W7oEpMnUWmMwhjQ1h2cdjW2SQKb1Mng_Ea6iHfdxdA@mail.gmail.com>
Subject: Re: [PATCH v11 6/6] target/riscv: Add Zicfilp support for Smrnmi
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
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

On Tue, Dec 31, 2024 at 1:28=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Zicfilp extension introduces the MNPELP (bit 9) in mnstatus.
> The MNPELP field holds the previous ELP.
>
> When a RNMI trap is delivered, the MNPELP is set to ELP and ELP set
> to NO_LP_EXPECTED. Upon a mnret, if the mnstatus.MNPP holds the
> value y, then ELP is set to the value of MNPELP if yLPE is 1;
> otherwise, it is set to NO_LP_EXPECTED.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_bits.h   |  1 +
>  target/riscv/cpu_helper.c | 11 ++++++++++-
>  target/riscv/op_helper.c  |  9 +++++++++
>  3 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 17787fd693..be9d0f5c05 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -643,6 +643,7 @@ typedef enum {
>  /* RNMI mnstatus CSR mask */
>  #define MNSTATUS_NMIE       0x00000008
>  #define MNSTATUS_MNPV       0x00000080
> +#define MNSTATUS_MNPELP     0x00000200
>  #define MNSTATUS_MNPP       0x00001800
>
>  /* VM modes (satp.mode) privileged ISA 1.10 */
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e5ffbbbd83..1fb1e31031 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1918,6 +1918,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          env->mnepc =3D env->pc;
>          env->pc =3D env->rnmi_irqvec;
>
> +        if (cpu_get_fcfien(env)) {
> +            env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_MNPELP, =
env->elp);
> +        }
> +
>          /* Trapping to M mode, virt is disabled */
>          riscv_cpu_set_mode(env, PRV_M, false);
>
> @@ -2085,7 +2089,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          /* handle the trap in M-mode */
>          /* save elp status */
>          if (cpu_get_fcfien(env)) {
> -            env->mstatus =3D set_field(env->mstatus, MSTATUS_MPELP, env-=
>elp);
> +            if (nnmi_excep) {
> +                env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_MNPE=
LP,
> +                                          env->elp);
> +            } else {
> +                env->mstatus =3D set_field(env->mstatus, MSTATUS_MPELP, =
env->elp);
> +            }
>          }
>
>          if (riscv_has_ext(env, RVH)) {
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 63ec53e992..a4b625fcd9 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -402,6 +402,15 @@ target_ulong helper_mnret(CPURISCVState *env)
>
>      riscv_cpu_set_mode(env, prev_priv, prev_virt);
>
> +    /*
> +     * If forward cfi enabled for new priv, restore elp status
> +     * and clear mnpelp in mnstatus
> +     */
> +    if (cpu_get_fcfien(env)) {
> +        env->elp =3D get_field(env->mnstatus, MNSTATUS_MNPELP);
> +    }
> +    env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_MNPELP, 0);
> +
>      return retpc;
>  }
>
> --
> 2.34.1
>
>

