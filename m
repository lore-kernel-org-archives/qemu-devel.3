Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED570C83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 00:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXTut-0003fT-LU; Thu, 03 Jul 2025 20:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXTuX-0003e6-Ad; Thu, 03 Jul 2025 20:04:14 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXTuU-00060c-Oq; Thu, 03 Jul 2025 20:04:12 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7d3f5796755so40039785a.1; 
 Thu, 03 Jul 2025 17:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751587449; x=1752192249; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LiK2t6Wl2jy+x06Y3TU3LBvKmXHH/54qSxIIAXLeGyU=;
 b=gdeQCCiP3+sndHtUr7jFbtLu1C+A+aMHwPKewVckZGT6BwPvgKcABgtuu83HujwDi4
 s6AqrcwxUEwKx8Dihj7fJQiz6UG7zaZ/+xsc+OGMXUX5A6gzAufaLZW8LEcRXk6C6A8L
 JaHlVRa2+rUZSRNn/P8wILyvt07j59qjUHH0k8paltlAt9NjwEK4wiW1QAw0dVCL5Jmi
 rRPyzscVctpQL6U1gd6PE6Ht6OOXycQGUTuHx7DKHetB8509RNPXn5uAjiHD7xuR1YdP
 kK1l6MktPydbtp2FYUWTVokbERdD/LG3wWJQcPLFjPmORYKyVzlVDs8QLrbgQjl8l1+7
 eiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751587449; x=1752192249;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LiK2t6Wl2jy+x06Y3TU3LBvKmXHH/54qSxIIAXLeGyU=;
 b=fNKqspjdYfSc7DX6mhXR5Yxe9Xs2vuV2XJJiQfEOAwtV0AB/fRVr0x141E2CsGEMJC
 ElZ0NCjRlxJ0mUUnDjM5lFAv9I+ld5GYQFAMsZeFmbZCJkgkUnRUi9D7cT6Njb7SfG2V
 jH/a8Rwj3KX35dW7khm6SOPOVmecNcyQ1V22XknbINbpSSYcbJtynChbjYgWkaVhAitz
 57rq8UJRwFO1Vg/akZm2jHM7NU6K7u2BwmtotMPebUDlabvZZWLQwM8vdKO6M/g5suCk
 CybguX0X6VMlacIW7E49IhLL+BnqAAyn9M26IjtjLreYlA80r58ZsMEpoOSGy95Rttje
 e8sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf4i2NBLCSXIJlZsjt2m6A5Bpa7xJE77H4XbNrl8loNHZUMfRvXJfY0sEaNK6DRe4mTL6Jtg2fNvcT@nongnu.org
X-Gm-Message-State: AOJu0Yy/n8BorMnskFiZpm6iLbzeOzRdiXosL++4oznlW5JpotI8wbm/
 3bFQnVxbV9ZsCU9UZ/KzhLoAXuM77SUhepEzK46P/V0z4FV6mxASVU5Vl2j+xQo859OJV/iLIz5
 iUbzzy2IDetM26mPf7vavlpJ/AONKAkI=
X-Gm-Gg: ASbGncshWynr4Kx71XG0M6OMr2aZMyhnrLej81kYOqi+JyjFvg4xCdo5SujK184Pf/O
 bAh6NPexHTKSvsw42ct1O5X7V3EKMB+jIRKg+tZC17gpNMawxQehV70FB3aby8B5vCCpRPLPvll
 QZ1F6avv0coDtmKFzevb4TNRnWI9EGZ6FaPiZDZfv3SFq/fXBBHHAK1cjvtxqHjl6HYL5xowNR3
 Q==
X-Google-Smtp-Source: AGHT+IGg5bwhBw5RRWsvSkrjPAH1pBTeMh5p+QhGrf3q6mIGrzs2ZYkR/bde/kT6OROoqvp10SA2M1E4JLX8Me28LYY=
X-Received: by 2002:a05:620a:1a0b:b0:7d5:dcd9:57f4 with SMTP id
 af79cd13be357-7d5ddb7266emr50774985a.18.1751587448806; Thu, 03 Jul 2025
 17:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250703182157.281320-1-charmitro@posteo.net>
 <20250703182157.281320-2-charmitro@posteo.net>
In-Reply-To: <20250703182157.281320-2-charmitro@posteo.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Jul 2025 10:03:41 +1000
X-Gm-Features: Ac12FXwY6fuEoMgDu6J41jDoqwZ46NsUeKa-mgVQ2V7emlngNjzt7bO8yY6BgVQ
Message-ID: <CAKmqyKOtb7JxV_f4ei2q14kuQkoT7-Ni1uq_tJNehm=HO+XFew@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: Fix MEPC/SEPC bit masking for IALIGN
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x72e.google.com
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

On Fri, Jul 4, 2025 at 4:25=E2=80=AFAM Charalampos Mitrodimas
<charmitro@posteo.net> wrote:
>
> According to the RISC-V Privileged Architecture specification, the low
> bit of MEPC/SEPC must always be zero. When IALIGN=3D32, the two low bits
> must be zero.
>
> This commit fixes the behavior of MEPC/SEPC CSR reads and writes, and
> the implicit reads by MRET/SRET instructions to properly mask the
> lowest bit(s) based on whether the C extension is enabled:
> - When C extension is enabled (IALIGN=3D16): mask bit 0
> - When C extension is disabled (IALIGN=3D32): mask bits [1:0]
>
> Previously, when vectored mode bits from STVEC (which sets bit 0 for
> vectored mode) were written to MEPC, the bits would not be cleared
> correctly, causing incorrect behavior on MRET.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2855
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c       |  8 ++++----
>  target/riscv/internals.h | 11 +++++++++++
>  target/riscv/op_helper.c |  4 ++--
>  3 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index fb14972169..c33a6e86d2 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3126,14 +3126,14 @@ static RISCVException write_mscratch(CPURISCVStat=
e *env, int csrno,
>  static RISCVException read_mepc(CPURISCVState *env, int csrno,
>                                  target_ulong *val)
>  {
> -    *val =3D env->mepc;
> +    *val =3D env->mepc & get_xepc_mask(env);
>      return RISCV_EXCP_NONE;
>  }
>
>  static RISCVException write_mepc(CPURISCVState *env, int csrno,
>                                   target_ulong val, uintptr_t ra)
>  {
> -    env->mepc =3D val;
> +    env->mepc =3D val & get_xepc_mask(env);
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -4113,14 +4113,14 @@ static RISCVException write_sscratch(CPURISCVStat=
e *env, int csrno,
>  static RISCVException read_sepc(CPURISCVState *env, int csrno,
>                                  target_ulong *val)
>  {
> -    *val =3D env->sepc;
> +    *val =3D env->sepc & get_xepc_mask(env);
>      return RISCV_EXCP_NONE;
>  }
>
>  static RISCVException write_sepc(CPURISCVState *env, int csrno,
>                                   target_ulong val, uintptr_t ra)
>  {
> -    env->sepc =3D val;
> +    env->sepc =3D val & get_xepc_mask(env);
>      return RISCV_EXCP_NONE;
>  }
>
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 4570bd50be..89ac6a160f 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -142,6 +142,17 @@ static inline float16 check_nanbox_h(CPURISCVState *=
env, uint64_t f)
>      }
>  }
>
> +static inline target_ulong get_xepc_mask(CPURISCVState *env)
> +{
> +    /* When IALIGN=3D32, both low bits must be zero.
> +     * When IALIGN=3D16 (has C extension), only bit 0 must be zero. */
> +    if (riscv_has_ext(env, RVC)) {
> +        return ~(target_ulong)1;
> +    } else {
> +        return ~(target_ulong)3;
> +    }
> +}
> +
>  #ifndef CONFIG_USER_ONLY
>  /* Our implementation of SysemuCPUOps::has_work */
>  bool riscv_cpu_has_work(CPUState *cs);
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 557807ba4b..15460bf84b 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -280,7 +280,7 @@ target_ulong helper_sret(CPURISCVState *env)
>          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      }
>
> -    target_ulong retpc =3D env->sepc;
> +    target_ulong retpc =3D env->sepc & get_xepc_mask(env);
>      if (!riscv_cpu_allow_16bit_insn(&env_archcpu(env)->cfg,
>                                      env->priv_ver,
>                                      env->misa_ext) && (retpc & 0x3)) {
> @@ -391,7 +391,7 @@ static target_ulong ssdbltrp_mxret(CPURISCVState *env=
, target_ulong mstatus,
>
>  target_ulong helper_mret(CPURISCVState *env)
>  {
> -    target_ulong retpc =3D env->mepc;
> +    target_ulong retpc =3D env->mepc & get_xepc_mask(env);
>      uint64_t mstatus =3D env->mstatus;
>      target_ulong prev_priv =3D get_field(mstatus, MSTATUS_MPP);
>
> --
> 2.47.2
>
>

