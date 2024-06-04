Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B550FC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 03:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEL3i-00041C-4e; Mon, 03 Jun 2024 23:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEL3g-00040e-EX; Mon, 03 Jun 2024 23:42:00 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEL3e-0002BA-5k; Mon, 03 Jun 2024 23:42:00 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-80ac76f1226so3081478241.0; 
 Mon, 03 Jun 2024 20:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717472516; x=1718077316; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gPoe91GnOM/+xuENK98zsP6aIAET/rZTcrKjIDGAcDI=;
 b=X+rq8jJiSrXluc2Vl+6STcbUk4mIb0ozn2HT9JtlB8Wp0+PEU8MbS/gJ5WXTF565xC
 r+rgw0vOKPAwfmKi9FX8nQ/aZUckBpmYZZdsxinAtf/c9cdRk3mAbBtifuxv2OUYFQbj
 zxINB2h/abjfOZ5S6jEneaR3FUsvmPYBiPJBoSoZqnEWQI3K41dT6LAaGntz5kxL23Hi
 4+HrBIP38oPQF4Kxuuac21ZQcbexQq0b0zTq7+RQ3VQg2q8cyghmn0rG7gWGv8yItN0n
 /JdLhZcEI+SG+rM8daqcYIfHnaB1Vfa8ta8s+X+upCqrbfYt9CiUNfxzFIdqL6xDeCy3
 sfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717472516; x=1718077316;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gPoe91GnOM/+xuENK98zsP6aIAET/rZTcrKjIDGAcDI=;
 b=aSNdl1F6pmEG9oL1HHLV9EUtNOh4d3NJ2+qwIZfCA75zaqiSLHFycYgSo/PdFIj7Sn
 RVlahfhIqM7Yd+KPXoRoN7pNwAo3jhFJHgx4kQlshQl3jcpgP5RNHExpaNyraQwz8NgI
 KHwXINjWXrHyU3pQRYktXTUpSHcM5tjHOpio0xHsUSHabSbQlhq5xXXDZqXD/BGFgb7M
 Ou15fTpvfzmIkTj84fXkD0Iau/3jU2+4RC+6IOZCoCJ524PyuIGXgKbpK+VHzL+U2ytA
 jkbtkcsBN1R7y1/4csfpl3PiSGyw5rODP5BkBFayghypUZAT/C19QcoKt8f9C8u85jix
 IuyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwi7CA1TUegyjgLpaJq3VsjyVlkRdoERoiBkp3k/ALYTc/eK2XXYwLaiP658obijOSc5NfwyzksI2a4Og9LEfW/GTzHUM=
X-Gm-Message-State: AOJu0YyrReASbYHOeqV47ql5v6aRJZc46LGaCvJNDb3G5y8is7UNuJQl
 SdtSqmsyh52bVJDSwoPlxPE9yuKMuj/5PtrETiysXzM3RLt7msot48c+eQjB3zT7nv/m66RF+Vs
 EAN9097thw0851iqxIhUuC3CO0wk=
X-Google-Smtp-Source: AGHT+IEgaeKdRU+unE5G46LZvAsZQJa3M1Vo8FET//WmJiFWdtg/y4qAVpHas5y413agHG3AadER2qpZFoqaxKrQ82A=
X-Received: by 2002:a05:6102:1611:b0:48b:dc86:6154 with SMTP id
 ada2fe7eead31-48bf2242ab9mr1548050137.4.1717472516204; Mon, 03 Jun 2024
 20:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240403070823.80897-1-yumin686@andestech.com>
 <CAKmqyKPE2-4oys9tEGQy5UBQT=ppYFitqv3UCZ=gzoce8qtZ6A@mail.gmail.com>
 <SI2PR03MB5674292C8D87C5383AD8761F8CFF2@SI2PR03MB5674.apcprd03.prod.outlook.com>
In-Reply-To: <SI2PR03MB5674292C8D87C5383AD8761F8CFF2@SI2PR03MB5674.apcprd03.prod.outlook.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 13:41:30 +1000
Message-ID: <CAKmqyKORtYQX+WRunUBt6YdEzRH1zNFkeef1Nenqv8dOTwdHyg@mail.gmail.com>
Subject: Re: [PATCH v3] target/riscv: raise an exception when CSRRS/CSRRC
 writes a read-only CSR
To: =?UTF-8?B?WXVtaW5nIFl1LU1pbmcgQ2hhbmco5by16IKy6YqYKQ==?=
 <yumin686@andestech.com>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>, 
 "bin.meng@windriver.com" <bin.meng@windriver.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, 
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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

On Mon, Jun 3, 2024 at 4:00=E2=80=AFPM Yuming Yu-Ming Chang(=E5=BC=B5=E8=82=
=B2=E9=8A=98)
<yumin686@andestech.com> wrote:
>
> Hi Alistair,
>
> I think we need the following patch to fix this issue:

I have dropped the original patch from my tree. Please fix the issue
and send a new patch with the fix incorporated.

Alistair

>
> From 6175c9aee103e40b5a5da587f659563de93b3d85 Mon Sep 17 00:00:00 2001
> From: Alvin Chang <alvinga@andestech.com>
> Date: Thu, 18 Apr 2024 14:52:36 +0800
> Subject: [PATCH] target/riscv: Fix GDB can not read the read-only CSR
>
> From commit 563581cb60, use riscv_csrrw() to read a read-only CSR will
> lead to exception. Fix it by calling riscv_csrr() when GDB wants to read
> a read-only CSR.
>
> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> ---
>  target/riscv/csr.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 7aab267916..96accc1549 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -4625,7 +4625,11 @@ RISCVException riscv_csrrw_debug(CPURISCVState *en=
v, int csrno,
>  #if !defined(CONFIG_USER_ONLY)
>      env->debugger =3D true;
>  #endif
> -    ret =3D riscv_csrrw(env, csrno, ret_value, new_value, write_mask);
> +    if (!write_mask) {
> +        ret =3D riscv_csrr(env, csrno, ret_value);
> +    } else {
> +        ret =3D riscv_csrrw(env, csrno, ret_value, new_value, write_mask=
);
> +    }
>  #if !defined(CONFIG_USER_ONLY)
>      env->debugger =3D false;
>  #endif
> --
> 2.34.1
>
> Best regards,
> Yuming
>
> -----Original Message-----
> From: Alistair Francis <alistair23@gmail.com>
> Sent: Monday, June 3, 2024 1:39 PM
> To: Yuming Yu-Ming Chang(=E5=BC=B5=E8=82=B2=E9=8A=98) <yumin686@andestech=
.com>
> Cc: qemu-riscv@nongnu.org; qemu-devel@nongnu.org; palmer@dabbelt.com; ali=
stair.francis@wdc.com; bin.meng@windriver.com; liwei1518@gmail.com; dbarboz=
a@ventanamicro.com; zhiwei_liu@linux.alibaba.com
> Subject: Re: [PATCH v3] target/riscv: raise an exception when CSRRS/CSRRC=
 writes a read-only CSR
>
> [EXTERNAL MAIL]
>
> On Wed, Apr 3, 2024 at 5:10=E2=80=AFPM Yu-Ming Chang via <qemu-devel@nong=
nu.org> wrote:
> >
> > Both CSRRS and CSRRC always read the addressed CSR and cause any read s=
ide
> > effects regardless of rs1 and rd fields. Note that if rs1 specifies a r=
egister
> > holding a zero value other than x0, the instruction will still attempt =
to write
> > the unmodified value back to the CSR and will cause any attendant side =
effects.
> >
> > So if CSRRS or CSRRC tries to write a read-only CSR with rs1 which spec=
ifies
> > a register holding a zero value, an illegal instruction exception shoul=
d be
> > raised.
> >
> > Signed-off-by: Yu-Ming Chang <yumin686@andestech.com>
>
> This fails the GitLab CI tests
>
> https://gitlab.com/qemu-project/qemu/-/jobs/6953349448
>
> ERROR:../tests/plugin/insn.c:58:vcpu_init: assertion failed: (count > 0)
> timeout: the monitored command dumped core
> Aborted
> make[1]: *** [Makefile:178: run-plugin-catch-syscalls-with-libinsn.so] Er=
ror 134
> make: *** [/builds/qemu-project/qemu/tests/Makefile.include:56:
> run-tcg-tests-riscv64-linux-user] Error 2
>
> #0  riscv_gdb_get_csr (cs=3D<optimized out>, buf=3D0x5555558e7f50, n=3D30=
72)
>      at ../src/target/riscv/gdbstub.c:183
> #1  0x00007ffff7fb7841 in vcpu_init (id=3D<optimized out>,
>      vcpu_index=3D<optimized out>) at ../src/tests/plugin/insn.c:57
> #2  0x000055555569ef1a in plugin_vcpu_cb__simple (cpu=3D0x5555558fb820,
>      ev=3D<optimized out>) at ../src/plugins/core.c:111
>
>
> After
>
> 182             result =3D riscv_csrrw_debug(env, n, &val, 0, 0);
>
> result =3D=3D 2.
>
> I haven't had much luck reproducing this locally, so I don't have a
> great idea of why it isn't working. I suspect you need to ignore the
> checks for debug accesses
>
> Alistair
>
> > ---
> > Hi maintainers,
> >     Do I need to make any further improvements to this patch?
> >
> > Best regards,
> > Yuming
> >
> >  target/riscv/cpu.h       |  4 ++++
> >  target/riscv/csr.c       | 51 ++++++++++++++++++++++++++++++++++++----
> >  target/riscv/op_helper.c |  6 ++---
> >  3 files changed, 53 insertions(+), 8 deletions(-)
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 3b1a02b944..99006bdb45 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -710,6 +710,8 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr=
 *pc,
> >  void riscv_cpu_update_mask(CPURISCVState *env);
> >  bool riscv_cpu_is_32bit(RISCVCPU *cpu);
> >
> > +RISCVException riscv_csrr(CPURISCVState *env, int csrno,
> > +                          target_ulong *ret_value);
> >  RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
> >                             target_ulong *ret_value,
> >                             target_ulong new_value, target_ulong write_=
mask);
> > @@ -742,6 +744,8 @@ typedef RISCVException (*riscv_csr_op_fn)(CPURISCVS=
tate *env, int csrno,
> >                                            target_ulong new_value,
> >                                            target_ulong write_mask);
> >
> > +RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
> > +                               Int128 *ret_value);
> >  RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
> >                                  Int128 *ret_value,
> >                                  Int128 new_value, Int128 write_mask);
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index 726096444f..35662e1777 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -4312,7 +4312,7 @@ static RISCVException rmw_seed(CPURISCVState *env=
, int csrno,
> >
> >  static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
> >                                                 int csrno,
> > -                                               bool write_mask)
> > +                                               bool write)
> >  {
> >      /* check privileges and return RISCV_EXCP_ILLEGAL_INST if check fa=
ils */
> >      bool read_only =3D get_field(csrno, 0xC00) =3D=3D 3;
> > @@ -4334,7 +4334,7 @@ static inline RISCVException riscv_csrrw_check(CP=
URISCVState *env,
> >      }
> >
> >      /* read / write check */
> > -    if (write_mask && read_only) {
> > +    if (write && read_only) {
> >          return RISCV_EXCP_ILLEGAL_INST;
> >      }
> >
> > @@ -4421,11 +4421,22 @@ static RISCVException riscv_csrrw_do64(CPURISCV=
State *env, int csrno,
> >      return RISCV_EXCP_NONE;
> >  }
> >
> > +RISCVException riscv_csrr(CPURISCVState *env, int csrno,
> > +                           target_ulong *ret_value)
> > +{
> > +    RISCVException ret =3D riscv_csrrw_check(env, csrno, false);
> > +    if (ret !=3D RISCV_EXCP_NONE) {
> > +        return ret;
> > +    }
> > +
> > +    return riscv_csrrw_do64(env, csrno, ret_value, 0, 0);
> > +}
> > +
> >  RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
> >                             target_ulong *ret_value,
> >                             target_ulong new_value, target_ulong write_=
mask)
> >  {
> > -    RISCVException ret =3D riscv_csrrw_check(env, csrno, write_mask);
> > +    RISCVException ret =3D riscv_csrrw_check(env, csrno, true);
> >      if (ret !=3D RISCV_EXCP_NONE) {
> >          return ret;
> >      }
> > @@ -4473,13 +4484,45 @@ static RISCVException riscv_csrrw_do128(CPURISC=
VState *env, int csrno,
> >      return RISCV_EXCP_NONE;
> >  }
> >
> > +RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
> > +                               Int128 *ret_value)
> > +{
> > +    RISCVException ret;
> > +
> > +    ret =3D riscv_csrrw_check(env, csrno, false);
> > +    if (ret !=3D RISCV_EXCP_NONE) {
> > +        return ret;
> > +    }
> > +
> > +    if (csr_ops[csrno].read128) {
> > +        return riscv_csrrw_do128(env, csrno, ret_value,
> > +                                 int128_zero(), int128_zero());
> > +    }
> > +
> > +    /*
> > +     * Fall back to 64-bit version for now, if the 128-bit alternative=
 isn't
> > +     * at all defined.
> > +     * Note, some CSRs don't need to extend to MXLEN (64 upper bits no=
n
> > +     * significant), for those, this fallback is correctly handling th=
e
> > +     * accesses
> > +     */
> > +    target_ulong old_value;
> > +    ret =3D riscv_csrrw_do64(env, csrno, &old_value,
> > +                           (target_ulong)0,
> > +                           (target_ulong)0);
> > +    if (ret =3D=3D RISCV_EXCP_NONE && ret_value) {
> > +        *ret_value =3D int128_make64(old_value);
> > +    }
> > +    return ret;
> > +}
> > +
> >  RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
> >                                  Int128 *ret_value,
> >                                  Int128 new_value, Int128 write_mask)
> >  {
> >      RISCVException ret;
> >
> > -    ret =3D riscv_csrrw_check(env, csrno, int128_nz(write_mask));
> > +    ret =3D riscv_csrrw_check(env, csrno, true);
> >      if (ret !=3D RISCV_EXCP_NONE) {
> >          return ret;
> >      }
> > diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> > index f414aaebdb..b95d47e9ac 100644
> > --- a/target/riscv/op_helper.c
> > +++ b/target/riscv/op_helper.c
> > @@ -51,7 +51,7 @@ target_ulong helper_csrr(CPURISCVState *env, int csr)
> >      }
> >
> >      target_ulong val =3D 0;
> > -    RISCVException ret =3D riscv_csrrw(env, csr, &val, 0, 0);
> > +    RISCVException ret =3D riscv_csrr(env, csr, &val);
> >
> >      if (ret !=3D RISCV_EXCP_NONE) {
> >          riscv_raise_exception(env, ret, GETPC());
> > @@ -84,9 +84,7 @@ target_ulong helper_csrrw(CPURISCVState *env, int csr=
,
> >  target_ulong helper_csrr_i128(CPURISCVState *env, int csr)
> >  {
> >      Int128 rv =3D int128_zero();
> > -    RISCVException ret =3D riscv_csrrw_i128(env, csr, &rv,
> > -                                          int128_zero(),
> > -                                          int128_zero());
> > +    RISCVException ret =3D riscv_csrr_i128(env, csr, &rv);
> >
> >      if (ret !=3D RISCV_EXCP_NONE) {
> >          riscv_raise_exception(env, ret, GETPC());
> > --
> > 2.34.1
> >
> >
> CONFIDENTIALITY NOTICE:
>
> This e-mail (and its attachments) may contain confidential and legally pr=
ivileged information or information protected from disclosure. If you are n=
ot the intended recipient, you are hereby notified that any disclosure, cop=
ying, distribution, or use of the information contained herein is strictly =
prohibited. In this case, please immediately notify the sender by return e-=
mail, delete the message (and any accompanying documents) and destroy all p=
rinted hard copies. Thank you for your cooperation.
>
> Copyright ANDES TECHNOLOGY CORPORATION - All Rights Reserved.

