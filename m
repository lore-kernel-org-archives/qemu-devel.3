Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACA0C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UAv-0007Wu-Sx; Thu, 03 Apr 2025 19:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0UAs-0007WX-UG; Thu, 03 Apr 2025 19:40:43 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0UAp-0008Gq-Vq; Thu, 03 Apr 2025 19:40:41 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-86d587dbc15so1312027241.1; 
 Thu, 03 Apr 2025 16:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743723638; x=1744328438; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/a4EQ9NCQ5q17YdsafP52dZ2Wnqu4rs3Cn5sjtuUOs=;
 b=drlDMJqRVKciddB20jXJaQ5Loohw+xLURl16afYvdEX1ee10JPCFQVGOVtaE1Q0xZx
 xeicYSoePgOmTj8CtThNxxoTVBxgrYfwhYaVJjQB5v5FKD4Z7A/fpJ0CzWLfTmmCK8td
 j5hF78K/Tmnd3CvVowfG+gM3QVcQm2iseEfiyA8zEv06lctapAkoZTLjc2gTREzI7Y6n
 VLAzcvmVyP2pk92WcKooD1HjojjUAY0zEXXQjchs6ksD1Se89zr2zPd9tWGSLwaJVAyW
 3e5EbGoLMQz9FsKbj3PMavlqbeRDdJCR/sb63VNAaAI9+KxSmrzuez4xMN63nhZ7pnfJ
 9Dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743723638; x=1744328438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w/a4EQ9NCQ5q17YdsafP52dZ2Wnqu4rs3Cn5sjtuUOs=;
 b=o/oPIysYZUnSj6JHlAe69ADTzN5AIQEAtPnrv5E5Mli+A2rtV7We4glZJ+Udn0/1rG
 O+zMKH1ndfIs5eKGL+AWeFvpcdXVs0hV1DtLFR0Q/I33jkMt8Rl2Xntb6suHZcCRUmTF
 /3egkQ1icQeCFTyf7t5YiACU0+nvHR/YU7xfHBCvJIsVbsRTD5H2XEdAj4FtZxrWdPun
 YTxTCBf6KX4m3R76+r9DP37IeLTw2aBlNLKZA8NmXYAT6mSVnJP+f8uYCHQ/gBxSCqSN
 EdsX+9SBFjoNlV20drcyG+Sof6wqM4FbmpxCkMJhXWscuUiHG/WOsP5RetEYxOZOgZgR
 hiwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbhOxw8tRVqY1pUvIElKVXGaDIndMcIzC6AcLatlmXkF3XScOkjCGtDRk7LtKHr7A3Gvw+5GqLFy3S@nongnu.org
X-Gm-Message-State: AOJu0Yy4/m0XxiqRe4fa+1wIQvc+Rs+J0XFhXPLsTBduu00tnlkNy2pe
 LooXJEom+sptRH5fieUtoIMvlvsoKVNk/VOTK4ddH6nqrOMyKyhRDwe7WFlFt5Lugd560p/87Gn
 XyRkouG8ds78TcW2govZ8SjC4zjU=
X-Gm-Gg: ASbGnctkYuPXztdGW9z8HJYTct+cH5pZAmscVf4BoCzOJ49V4AFhEmKjqZ2Tmy5IFqG
 wKhJtPvCWegxwRAzLcJreFoX7tgkznFJmQCqHTOnGgkmcexi6ZVaIh+vNmBUUS0pPcA4/yL+egz
 5Dkfe7CxRYXrp/5DjGoNejIWm33pMe5Qao9FfY5DP+OvYC635vzgjD7BsM00r8QP+P6+s=
X-Google-Smtp-Source: AGHT+IEbkQggoWJ+Lf399yzKhD9zHKygWNEPjZHJIXgGK41sNpgnSQInd2/io9HB3xKeQzXiUmsBXVsilEFBr6CCOjg=
X-Received: by 2002:a67:be02:0:b0:4c1:8ded:2d66 with SMTP id
 ada2fe7eead31-4c845b9933dmr4335799137.12.1743723637999; Thu, 03 Apr 2025
 16:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250401103344.84257-1-jay.chang@sifive.com>
 <20250401103344.84257-2-jay.chang@sifive.com>
In-Reply-To: <20250401103344.84257-2-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 09:40:11 +1000
X-Gm-Features: ATxdqUHxrllk8mygpReRWqOdYoaIlT-STBw3nNlgjPnTJ1mDEB8LIHct8GWhzIY
Message-ID: <CAKmqyKPB2HBFnreduGPjQFE1cqL7VFk6-7iB=ecymr8Luf3O9A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/riscv: Restrict midelegh access to S-mode
 harts
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
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

On Tue, Apr 1, 2025 at 8:35=E2=80=AFPM Jay Chang <jay.chang@sifive.com> wro=
te:
>
> RISC-V AIA Spec states:
> "For a machine-level environment, extension Smaia encompasses all added
> CSRs and all modifications to interrupt response behavior that the AIA
> specifies for a hart, over all privilege levels. For a supervisor-level
> environment, extension Ssaia is essentially the same as Smaia except
> excluding the machine-level CSRs and behavior not directly visible to
> supervisor level."
>
> Since midelegh is an AIA machine-mode CSR, add Smaia extension check in
> aia_smode32 predicate.
>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 975d6e307f..81a57249bf 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -372,8 +372,11 @@ static RISCVException aia_smode(CPURISCVState *env, =
int csrno)
>  static RISCVException aia_smode32(CPURISCVState *env, int csrno)
>  {
>      int ret;
> +    int csr_priv =3D get_field(csrno, 0x300);
>
> -    if (!riscv_cpu_cfg(env)->ext_ssaia) {
> +    if (csr_priv =3D=3D PRV_M && !riscv_cpu_cfg(env)->ext_smaia) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    } else if (!riscv_cpu_cfg(env)->ext_ssaia) {
>          return RISCV_EXCP_ILLEGAL_INST;
>      }
>
> @@ -5832,7 +5835,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>      [CSR_MVIP]     =3D { "mvip",     aia_any, NULL, NULL, rmw_mvip    },
>
>      /* Machine-Level High-Half CSRs (AIA) */
> -    [CSR_MIDELEGH] =3D { "midelegh", aia_any32, NULL, NULL, rmw_midelegh=
 },
> +    [CSR_MIDELEGH] =3D { "midelegh", aia_smode32, NULL, NULL, rmw_midele=
gh },
>      [CSR_MIEH]     =3D { "mieh",     aia_any32, NULL, NULL, rmw_mieh    =
 },
>      [CSR_MVIENH]   =3D { "mvienh",   aia_any32, NULL, NULL, rmw_mvienh  =
 },
>      [CSR_MVIPH]    =3D { "mviph",    aia_any32, NULL, NULL, rmw_mviph   =
 },
> --
> 2.48.1
>
>

