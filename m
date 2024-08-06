Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE47BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 00:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb7om-0000e2-1Q; Mon, 05 Aug 2024 20:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb7oY-0000bd-6X; Mon, 05 Aug 2024 20:12:34 -0400
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb7oV-00070U-I0; Mon, 05 Aug 2024 20:12:33 -0400
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-492959b906eso85822137.0; 
 Mon, 05 Aug 2024 17:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722903150; x=1723507950; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9LUG1JWPuZy0H3bwMTmvdzJP1Utj3evUrfX4VqXtpE=;
 b=IjfFF3Fcl9/Gu0rTbKqojbbe5CnBD0Rieioo+KXB3ZDsnKGoGFYAvpY34OjkxkKScG
 dmXwu+NZBDyrffGzuBHNbsliTR0xHO83FKOTr3K98Bd3kCZbjLbwumZTEriNOCdDtwcK
 62v9IlS3z8zNRgNl6lmFPAQ/tMEyKUewmIAzc15V/hZqqiaGVoVZxaEYPB0s/4LOuUc7
 80DOHDt/3FCB6Bq2QQY8HEbj9/+8kana1Utxe+MWzyd/Rr5fSp8x6RpLamk3CYljr9LG
 Rm0wy6xtbNds5jSMg/fi+syI70/S2grPKqkYJuAj1YjPe5hC/tPI4MHWTOlo4nj3hrPq
 NuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722903150; x=1723507950;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b9LUG1JWPuZy0H3bwMTmvdzJP1Utj3evUrfX4VqXtpE=;
 b=oG0q+iOraZXhCpMAOywi1wQ3hZ8aQYHbDLiMSEdvyxCaJgUTthfy3LMtAUEJlWiz5R
 JxxmrzM4ychBh05+Kg58jO8IzagDDFVqNGigpTD6H22IU4R3Bnfzo3Oi3pfQ5Zop0DOi
 fYK1la0Yk1gjrqA77P5+4BVvyd9S5ztWxAKM7RE1TKYUXetnU4B1a1dVJMVbQ4xwkVS2
 UdNoAdtUW7YzJLwMKpN6RUJZB6TwAzA2sBMx1FsijOLJhFuU4l3x+MNV1YGUN89OUqVJ
 hl/Mb0jMBDFJg3rCiGPeiKkt8h8IDlgm6U8v7qAWeWpaIWp3wuJhFF+bgI4aOXNa1OLR
 0KlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+vBYYdGlJcOPnNrbj494osWFUpRtn+9PpqRbx9cTVdNz6CjeExDT+tVVDlMnb7TZZGyHHxhTTsIBgsibWmmo/d4lw/I8=
X-Gm-Message-State: AOJu0Yy+PDOVNaUMn3mjxHbTHKmjTrBjWU/1jyBza6C+5u4J8O3Va53u
 zuvgndIpToIauQQVD7ngCfjgeQbEfhRdoN2YkY8fwDOBqJM/OZyeE/Oova7M1UaAgsQdOZLM7Hm
 gbLNcTMQCmZVWu6ZO1p5KbU2dz+U=
X-Google-Smtp-Source: AGHT+IEtrtlQj7XYGLMdCCKwTrkSzTrnL7O4gjSrQQmeJm5Kl69qQq+xe3R6Fj5sUjt0LZWbfi0Y2uZPRSZ670ybRUs=
X-Received: by 2002:a05:6102:32ce:b0:493:bb36:9be9 with SMTP id
 ada2fe7eead31-4945bdb17b5mr16725330137.1.1722903150055; Mon, 05 Aug 2024
 17:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-3-c4170a5348ca@rivosinc.com>
In-Reply-To: <20240723-counter_delegation-v2-3-c4170a5348ca@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 6 Aug 2024 10:12:04 +1000
Message-ID: <CAKmqyKPo0K0JkUrer0EQXGWHmEU8oQ=9KQb1QY2sTx_zeH9ArQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] target/riscv: Enable S*stateen bits for AIA
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2a.google.com
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

On Wed, Jul 24, 2024 at 9:31=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> As per the ratified AIA spec v1.0, three stateen bits control AIA CSR
> access.
>
> Bit 60 controls the indirect CSRs
> Bit 59 controls the most AIA CSR state
> Bit 58 controls the IMSIC state such as stopei and vstopei
>
> Enable the corresponding bits in [m|h]stateen and enable corresponding
> checks in the CSR accessor functions.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  target/riscv/csr.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 87 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 58be8bc3cc8c..18b9ae802b15 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -316,19 +316,42 @@ static RISCVException smode32(CPURISCVState *env, i=
nt csrno)
>
>  static RISCVException aia_smode(CPURISCVState *env, int csrno)
>  {
> +    int ret;
> +
>      if (!riscv_cpu_cfg(env)->ext_ssaia) {
>          return RISCV_EXCP_ILLEGAL_INST;
>      }
>
> +    if (csrno =3D=3D CSR_STOPEI) {
> +        ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_IMSIC);
> +    } else {
> +        ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_AIA);
> +    }
> +
> +    if (ret !=3D RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
>      return smode(env, csrno);
>  }
>
>  static RISCVException aia_smode32(CPURISCVState *env, int csrno)
>  {
> +    int ret;
> +
>      if (!riscv_cpu_cfg(env)->ext_ssaia) {
>          return RISCV_EXCP_ILLEGAL_INST;
>      }
>
> +    ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_AIA);
> +    if (ret !=3D RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
> +    if (ret !=3D RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
>      return smode32(env, csrno);
>  }
>
> @@ -567,15 +590,38 @@ static RISCVException pointer_masking(CPURISCVState=
 *env, int csrno)
>
>  static RISCVException aia_hmode(CPURISCVState *env, int csrno)
>  {
> +    int ret;
> +
>      if (!riscv_cpu_cfg(env)->ext_ssaia) {
>          return RISCV_EXCP_ILLEGAL_INST;
>       }
>
> -     return hmode(env, csrno);
> +    if (csrno =3D=3D CSR_VSTOPEI) {
> +        ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_IMSIC);
> +    } else {
> +        ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_AIA);
> +    }
> +
> +    if (ret !=3D RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
> +    return hmode(env, csrno);
>  }
>
>  static RISCVException aia_hmode32(CPURISCVState *env, int csrno)
>  {
> +    int ret;
> +
> +    if (!riscv_cpu_cfg(env)->ext_ssaia) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +     }
> +
> +    ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_AIA);
> +    if (ret !=3D RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
>      if (!riscv_cpu_cfg(env)->ext_ssaia) {
>          return RISCV_EXCP_ILLEGAL_INST;
>      }
> @@ -1992,6 +2038,12 @@ static RISCVException rmw_xiselect(CPURISCVState *=
env, int csrno,
>                                     target_ulong wr_mask)
>  {
>      target_ulong *iselect;
> +    int ret;
> +
> +    ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
> +    if (ret !=3D RISCV_EXCP_NONE) {
> +        return ret;
> +    }
>
>      /* Translate CSR number for VS-mode */
>      csrno =3D csrind_xlate_vs_csrno(env, csrno);
> @@ -2162,6 +2214,11 @@ static RISCVException rmw_xireg(CPURISCVState *env=
, int csrno,
>      int ret =3D -EINVAL;
>      target_ulong isel;
>
> +    ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
> +    if (ret !=3D RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
>      /* Translate CSR number for VS-mode */
>      csrno =3D csrind_xlate_vs_csrno(env, csrno);
>
> @@ -2610,6 +2667,22 @@ static RISCVException write_mstateen0(CPURISCVStat=
e *env, int csrno,
>      if (env->priv_ver >=3D PRIV_VERSION_1_13_0) {
>          wr_mask |=3D SMSTATEEN0_P1P13;
>      }
> +    /*
> +     * TODO: Do we need to check ssaia as well ? Can we enable ssaia wit=
hout
> +     * smaia ?
> +     */
> +    if (riscv_cpu_cfg(env)->ext_smaia) {
> +        wr_mask |=3D SMSTATEEN0_SVSLCT;
> +    }

This looks right to me, do we need the TODO?

Otherwise

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

