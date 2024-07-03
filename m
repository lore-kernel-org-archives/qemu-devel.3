Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D9CC3065C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 01:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOoex-0007KJ-CD; Tue, 02 Jul 2024 21:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOoew-0007K3-6a; Tue, 02 Jul 2024 21:19:46 -0400
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOoes-00085e-8k; Tue, 02 Jul 2024 21:19:45 -0400
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-48fde151f25so70583137.1; 
 Tue, 02 Jul 2024 18:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719969581; x=1720574381; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JHJ81nI5cs2a3/TRLHe0PjJRYgXLDxhW942qw03hgG8=;
 b=Ukevau91eDXJyweBtrzKHO1dzP742SEDVZtYdlHFphvI39tGQFq1pQYMTbybG5qAfe
 NpeAwsjy9v1PEmxCFfH5ixbg5A4yPDEoV7sb0V3z3vanMy7E2tk0e+NsW+zj7RLAggHx
 Ym8y4QxdpeSgfiEZoHMEPZ4dMsD+EONfXC9no3YOKZKT8hoRuDmbQ4E68XpDDHJmVuFi
 SnpHX1MewMPe/aY2NgAdgKAAkY5N5fj2UKaKnPY2AvkAz+elNI120hipWtUSVjesAfjA
 YNvFS8EDLSIXj72WQDB2nMJyiIED4Oy6FpRlI4/UEr9liKoMCGqVzTZbxLRB9XB/k0BM
 YeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719969581; x=1720574381;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JHJ81nI5cs2a3/TRLHe0PjJRYgXLDxhW942qw03hgG8=;
 b=BiRGzE7bYiAQsXjhJsTP0cyFE5EJVSkd2gK5UnPZ7ODnyhSLdqYPXdJrTgGD4qq3p6
 quoR3AkXV1Fr/3frz3aW+fTMmS3sjmeo/TiWzDTIdxPEiZ8SKVEZdo272fSTDkTzOXMn
 9MDPdw5cumCfU6VHOSU9yca91+mE3fMNjbmhF6K3ADft883Q+jkoPfr84GGy3EXkZHe8
 IrDrWgLndMCSfT5n7/+3p1ynG2qTYma5lNtqszEnlze00dne0N5KRpqNUfdbM1GFMlv+
 CuSNfS6DUUDHgT3ST3iQGZFSnLw5t/w+eyVARyH90FbxdfFF8/QgHM9o+avhIWyb+0zq
 Sf3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlnzCk3dH3dErPHdZeJPmjhtyf77Pj78dOTJrF3h1Zn/hpvVUlgZ1KetXg59oGmY6WQioV0/wYeg9U1D++vROn6K8xrbk=
X-Gm-Message-State: AOJu0YzeePezJuxG0RhavdAa8UoWbI9Kzdzs5K3orA8kv69roKHsYKUo
 o53byp/soiqAJhVq5MC1OTJ89M9sgrdFvmmQfK99KqgJxaFPBf61Og6DSC+F//MbFZLtiSZY1i2
 R2VUWZl2sckEr4l8da4OWDRguXfc=
X-Google-Smtp-Source: AGHT+IEIJgYrcfo0X/hU6CCEgnawZnlRA/YQgx8/N9m6ETjxfv6UWn32tSgqxBwKNXCUCnG86nVmOnfJRZlGd2YU3gU=
X-Received: by 2002:a67:b44d:0:b0:48f:4b47:5f27 with SMTP id
 ada2fe7eead31-48faf154c58mr10957730137.33.1719969580723; Tue, 02 Jul 2024
 18:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
 <20240626-smcntrpmf_v7-v7-5-bb0f10af7fa9@rivosinc.com>
In-Reply-To: <20240626-smcntrpmf_v7-v7-5-bb0f10af7fa9@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jul 2024 11:19:14 +1000
Message-ID: <CAKmqyKN3V9-q+CE93y_+1r=yjr7U1YKa=mCpjZ7nOr-6JtN=ig@mail.gmail.com>
Subject: Re: [PATCH v7 05/11] target/riscv: Add cycle & instret privilege mode
 filtering support
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Rajnesh Kanwal <rkanwal@rivosinc.com>, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe36.google.com
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

On Thu, Jun 27, 2024 at 10:00=E2=80=AFAM Atish Patra <atishp@rivosinc.com> =
wrote:
>
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
>
> QEMU only calculates dummy cycles and instructions, so there is no
> actual means to stop the icount in QEMU. Hence this patch merely adds
> the functionality of accessing the cfg registers, and cause no actual
> effects on the counting of cycle and instret counters.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> ---
>  target/riscv/csr.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 88 insertions(+)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 3ad851707e5c..665c534db1a0 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -236,6 +236,24 @@ static RISCVException sscofpmf_32(CPURISCVState *env=
, int csrno)
>      return sscofpmf(env, csrno);
>  }
>
> +static RISCVException smcntrpmf(CPURISCVState *env, int csrno)
> +{
> +    if (!riscv_cpu_cfg(env)->ext_smcntrpmf) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException smcntrpmf_32(CPURISCVState *env, int csrno)
> +{
> +    if (riscv_cpu_mxl(env) !=3D MXL_RV32) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return smcntrpmf(env, csrno);
> +}
> +
>  static RISCVException any(CPURISCVState *env, int csrno)
>  {
>      return RISCV_EXCP_NONE;
> @@ -830,6 +848,62 @@ static RISCVException read_hpmcounterh(CPURISCVState=
 *env, int csrno,
>
>  #else /* CONFIG_USER_ONLY */
>
> +static RISCVException read_mcyclecfg(CPURISCVState *env, int csrno,
> +                                     target_ulong *val)
> +{
> +    *val =3D env->mcyclecfg;

We don't do a good job of this in other places, but we should check
for RVU and RVS to determine if the bits can actually be set.

This is especially important for Hypervisor support (VS/VU-modes), as
that is often not supported so we should report that here

Alistair

> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
> +                                      target_ulong val)
> +{
> +    env->mcyclecfg =3D val;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_mcyclecfgh(CPURISCVState *env, int csrno,
> +                                      target_ulong *val)
> +{
> +    *val =3D env->mcyclecfgh;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_mcyclecfgh(CPURISCVState *env, int csrno,
> +                                       target_ulong val)
> +{
> +    env->mcyclecfgh =3D val;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_minstretcfg(CPURISCVState *env, int csrno,
> +                                       target_ulong *val)
> +{
> +    *val =3D env->minstretcfg;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_minstretcfg(CPURISCVState *env, int csrno,
> +                                        target_ulong val)
> +{
> +    env->minstretcfg =3D val;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_minstretcfgh(CPURISCVState *env, int csrno,
> +                                        target_ulong *val)
> +{
> +    *val =3D env->minstretcfgh;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_minstretcfgh(CPURISCVState *env, int csrno,
> +                                         target_ulong val)
> +{
> +    env->minstretcfgh =3D val;
> +    return RISCV_EXCP_NONE;
> +}
> +
>  static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
>                                       target_ulong *val)
>  {
> @@ -5051,6 +5125,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>                               write_mcountinhibit,
>                               .min_priv_ver =3D PRIV_VERSION_1_11_0      =
 },
>
> +    [CSR_MCYCLECFG]      =3D { "mcyclecfg",   smcntrpmf, read_mcyclecfg,
> +                             write_mcyclecfg,
> +                             .min_priv_ver =3D PRIV_VERSION_1_12_0      =
 },
> +    [CSR_MINSTRETCFG]    =3D { "minstretcfg", smcntrpmf, read_minstretcf=
g,
> +                             write_minstretcfg,
> +                             .min_priv_ver =3D PRIV_VERSION_1_12_0      =
 },
> +
>      [CSR_MHPMEVENT3]     =3D { "mhpmevent3",     any,    read_mhpmevent,
>                               write_mhpmevent                           }=
,
>      [CSR_MHPMEVENT4]     =3D { "mhpmevent4",     any,    read_mhpmevent,
> @@ -5110,6 +5191,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>      [CSR_MHPMEVENT31]    =3D { "mhpmevent31",    any,    read_mhpmevent,
>                               write_mhpmevent                           }=
,
>
> +    [CSR_MCYCLECFGH]     =3D { "mcyclecfgh",   smcntrpmf_32, read_mcycle=
cfgh,
> +                             write_mcyclecfgh,
> +                             .min_priv_ver =3D PRIV_VERSION_1_12_0      =
  },
> +    [CSR_MINSTRETCFGH]   =3D { "minstretcfgh", smcntrpmf_32, read_minstr=
etcfgh,
> +                             write_minstretcfgh,
> +                             .min_priv_ver =3D PRIV_VERSION_1_12_0      =
  },
> +
>      [CSR_MHPMEVENT3H]    =3D { "mhpmevent3h",    sscofpmf_32,  read_mhpm=
eventh,
>                               write_mhpmeventh,
>                               .min_priv_ver =3D PRIV_VERSION_1_12_0      =
  },
>
> --
> 2.34.1
>
>

