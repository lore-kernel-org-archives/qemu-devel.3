Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD442D3C927
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 00:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2ga0-0004Gl-VG; Sun, 20 Oct 2024 20:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2gZy-0004GD-Mi; Sun, 20 Oct 2024 20:47:26 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2gZx-00027Z-7R; Sun, 20 Oct 2024 20:47:26 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-84fed1ff217so2531574241.1; 
 Sun, 20 Oct 2024 17:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729471643; x=1730076443; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXXnRSgtLkMQFiVQfg7CVOOS/maIR2NpIjhvHp6OS10=;
 b=mdsr0mR6zeDoLQEpzvac5SA+D50L+MGJnjbFkI6fou4/HbbfxLmH4zj5XoDiLPjO6P
 e+CMQ7UUmnep+uhGpUvRy0+s7Yo+N+nQnHPYK70KempGs6svH51oqG59ohVuMxS1s8rc
 gJGxzcuiZcpUGH15uMoOjtx0reEEYtBAmLLxnKsqYFM3cRpDGmWR3PcG7eIxhZ633Q6j
 qy4InDCxQarwnlghHl2Bp6oCuouj1oemanVB4b7iFV2m0aQduc3hoI8MokR+hqkpAMj0
 Fhw6y0n8vE+vnaCYCk6b/ZTvmcsO96W071s0v1xOu93YPA1v3KytyJgvLVOFkxesfsjd
 yVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729471643; x=1730076443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zXXnRSgtLkMQFiVQfg7CVOOS/maIR2NpIjhvHp6OS10=;
 b=kWmABGGieIHXvUYaG2nKoQgc+tlR6bSqVMSvgvIm1AG41GAg9Lbs5x5OowPxun4ONo
 aBvXLteTAoT43rSYYR/nL+I8/RLktiOyLqZnuu4qvv4KG3Xuhyyl1ZwgpDRat648e3YL
 QzDv/sI6UPVrc6ZDKLR6vRZnx4nu22Tnf/caX/sbxKwse3N2YZTDEDUqnt6CbkP2PHTp
 G30+D5kd3CWwIDzmT7u3D9RyBfKj2X3xEWTGR9J/N/vodnDsIbVGDP3q4QoYp0nQx5qL
 3qykUKqtsSt6MupQ6PIxZn+q+gkIeIh+p9OD3LGMPirmpnzIb8uTW7wac/0s6hQS3q8D
 kvRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZK4V49iaoMgVMhZ0RFHaAwHKHNWSJ9JeAfpZVLPjr9nnIwVWv4OtnSkfpMmoylcuoJdipB+Av/6G1@nongnu.org
X-Gm-Message-State: AOJu0YwUF6OtwTqdBBZjBkHCkK8GGX9GScLguzwnVbhuu1Uc1mCvuYbA
 WzbfC9LX1tzOYzNLgh3qr7MGvFsvFJDiJ8f8GU2nsMDjZ4L0N1XLeoed9Q/w1cWBqyjRRTqr1gw
 1Bpuq4fzj4hQCPvhjbaxBH6cf5+kXf1w9Fhw=
X-Google-Smtp-Source: AGHT+IGXh3sFnT/cnT4+kZSFjrmZR8T6hqq1w+V5pJ8+w1nfT/BoJxHy7u7I8Ew4cASc/U/cmMq/5AUHTSFm8yXbwXo=
X-Received: by 2002:a05:6102:c8b:b0:4a4:7e84:d654 with SMTP id
 ada2fe7eead31-4a5c49eb5bbmr9196638137.14.1729471643596; Sun, 20 Oct 2024
 17:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20241017145226.365825-1-cleger@rivosinc.com>
 <20241017145226.365825-2-cleger@rivosinc.com>
In-Reply-To: <20241017145226.365825-2-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2024 10:46:57 +1000
Message-ID: <CAKmqyKMoDSFaJz7LhX4GMV9AhOQUDLOt79Fctw_k97SazpSjjQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] target/riscv: fix henvcfg potentially containing
 stale bits
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
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

On Fri, Oct 18, 2024 at 12:55=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
> With the current implementation, if we had the current scenario:
> - set bit x in menvcfg
> - set bit x in henvcfg
> - clear bit x in menvcfg
> then, the internal variable env->henvcfg would still contain bit x due
> to both a wrong menvcfg mask used in write_henvcfg() as well as a
> missing update of henvcfg upon menvcfg update.
> This can lead to some wrong interpretation of the context. In order to
> update henvcfg upon menvcfg writing, call write_henvcfg() after writing
> menvcfg and fix the mask computation used in write_henvcfg() that is
> used to mesk env->menvcfg value (which could still lead to some stale
> bits). The same mechanism is also applied for henvcfgh writing.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  target/riscv/csr.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index b84b436151..9e832e0b39 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2345,6 +2345,8 @@ static RISCVException read_menvcfg(CPURISCVState *e=
nv, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
> +                                    target_ulong val);
>  static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>                                      target_ulong val)
>  {
> @@ -2357,6 +2359,7 @@ static RISCVException write_menvcfg(CPURISCVState *=
env, int csrno,
>                  (cfg->ext_svadu ? MENVCFG_ADUE : 0);
>      }
>      env->menvcfg =3D (env->menvcfg & ~mask) | (val & mask);
> +    write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
>
>      return RISCV_EXCP_NONE;
>  }
> @@ -2368,6 +2371,8 @@ static RISCVException read_menvcfgh(CPURISCVState *=
env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
> +                                    target_ulong val);
>  static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
>                                       target_ulong val)
>  {
> @@ -2378,6 +2383,7 @@ static RISCVException write_menvcfgh(CPURISCVState =
*env, int csrno,
>      uint64_t valh =3D (uint64_t)val << 32;
>
>      env->menvcfg =3D (env->menvcfg & ~mask) | (valh & mask);
> +    write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
>
>      return RISCV_EXCP_NONE;
>  }
> @@ -2435,6 +2441,7 @@ static RISCVException write_henvcfg(CPURISCVState *=
env, int csrno,
>                                      target_ulong val)
>  {
>      uint64_t mask =3D HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENV=
CFG_CBZE;
> +    uint64_t menvcfg_mask =3D 0;
>      RISCVException ret;
>
>      ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
> @@ -2443,10 +2450,11 @@ static RISCVException write_henvcfg(CPURISCVState=
 *env, int csrno,
>      }
>
>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
> -        mask |=3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG=
_ADUE);
> +        menvcfg_mask =3D HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE;
> +        mask |=3D env->menvcfg & menvcfg_mask;

This doesn't seem right.

Should it be something like

    if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
        mask |=3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_AD=
UE);
    }

    mask =3D env->menvcfg & mask;

>      }
>
> -    env->henvcfg =3D (env->henvcfg & ~mask) | (val & mask);
> +    env->henvcfg =3D (env->henvcfg & ~menvcfg_mask) | (val & mask);

Using both menvcfg_mask and mask seems wrong here

Alistair

