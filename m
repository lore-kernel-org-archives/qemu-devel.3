Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5A9D2FFE0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 10:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1k9r-0007NL-30; Fri, 18 Oct 2024 06:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1t1k9o-0007Fc-PS
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:24:32 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1t1k9m-00064a-9u
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:24:32 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37ed2b8a78cso173443f8f.2
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 03:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729247069; x=1729851869;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mHZtMVpC60YOK/ppUErod4BT/A1Tsbsf8DDdgE6x7c=;
 b=raP3OlbpvspKVSlZCL0qgQwuUG1OvqaZadnsed652kFoIyHgxyAJ9b55eZmXwizNk8
 uWQ9q3pj1kw2FObjOqKwo6AOwSm+yg6TmfwtKLhJwpsifoR37yPqVnBOOCtP7YoxUSDI
 RxIwAprpUXpUu11eJDkF+qE8lQnUnQCX3tJQEdywNjX4MVm9LG55bm4p6U8VHmB/oin/
 Sxl3MlrYC7INiu+kE6jbDLEydjz0ZOe2szLzRod8yb/SS7KKMsPdMecrUwEyM7oFV/Qx
 Tcgdl9IqJy62sVN4DdGWfcsw0I3nPEq7L8LnP7eva7oVNdk7YVLwKu/tpM+GMjMi2b4X
 Zfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729247069; x=1729851869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8mHZtMVpC60YOK/ppUErod4BT/A1Tsbsf8DDdgE6x7c=;
 b=eW+PjLM+2iYA5XLSShxjgq4wAj2pXbojRDnDOtz4DK0nfBRBMG4fLFoKe0rqiKER4x
 ggl5PHnCxJrMv35/GCkQm35wbgFzrFHty374scCuddglG62w5rI6DcOcVCp2K+7VTk4y
 UzAJpFwJiH4CExN8rIoTmFKkP0yMfM5ynN/xOVTaX4Ofhn/bB8n/Ia0uXv5KoStM8aUW
 YNpEcd7VAUUQRbj5UJQLDD1nRpft4VYxkj2Ih5PB/ynaVEb6EoWKY2cXIV/BigQ3d+dw
 /X0C0chLKxbzi0iyqqY3fzej6DNMa1rN29EzC4VilifuAc+4ClYh8guOO1OJo1WwNwAs
 qeMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdKKqXbaJCGPBIEQKhoHnVFkX8RO2RPj2+rk/bf8AZvNuVQ5ts/G4qIB+pvjKw+jS1G+ETuZ59MB8W@nongnu.org
X-Gm-Message-State: AOJu0YwmO1XAQz/6bRkcXAW8DS9gqoCVgQKgryTuAfCaMAHyORRO/kD4
 bDh/F6OoOhCAAd8echULgkcp1FgxZiD6fPYYQrXFiz6DERcbLI2EpudAzGij4h+E553h0k0GAdq
 pJoaqmGxRSiqOGHzcTzgpNQGvqI56aO9ogXs0BA==
X-Google-Smtp-Source: AGHT+IGrzOGXgNbGbyqGIUcvvVnS8koMPm111Kse7j7DN00scloQjUO02yBh8+UKOvoA766wZ1maliU6oTT90VzudyE=
X-Received: by 2002:adf:edcd:0:b0:37c:cee0:96e6 with SMTP id
 ffacd0b85a97d-37ea2197f2fmr1359677f8f.27.1729247068660; Fri, 18 Oct 2024
 03:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240619152708.135991-1-rkanwal@rivosinc.com>
 <20240619152708.135991-4-rkanwal@rivosinc.com>
 <CANzO1D33XPxXAJ8kxBz0oa1R8pb5et3BQV5EELiEvdhSjj3S1Q@mail.gmail.com>
 <CAECbVCuQ-tWFrskOZ3FcG+nziamTb8fHV8iA5VOUfhFa4AvAMA@mail.gmail.com>
 <CAE_xrPiRtiO+2-PazQSZJkfKfWwZ1=0UoMOkQ82Z7vAUFJ4+wA@mail.gmail.com>
In-Reply-To: <CAE_xrPiRtiO+2-PazQSZJkfKfWwZ1=0UoMOkQ82Z7vAUFJ4+wA@mail.gmail.com>
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
Date: Fri, 18 Oct 2024 11:24:17 +0100
Message-ID: <CAECbVCtN7xK1S0COfejSzoY=+oSX1RQFYCoiBWd2oD+qhaVDfg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] target/riscv: Add support for Control Transfer
 Records extension CSRs.
To: Frank Chang <frank.chang@sifive.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, tech-control-transfer-records@lists.riscv.org, 
 jason.chien@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Oct 17, 2024 at 4:05=E2=80=AFPM Frank Chang <frank.chang@sifive.com=
> wrote:
>
> On Thu, Oct 17, 2024 at 7:18=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.=
com> wrote:
>>
>> On Tue, Aug 27, 2024 at 10:28=E2=80=AFAM Frank Chang <frank.chang@sifive=
.com> wrote:
>> >
>> > Rajnesh Kanwal <rkanwal@rivosinc.com> =E6=96=BC 2024=E5=B9=B46=E6=9C=
=8819=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:27=E5=AF=AB=E9=81=93=
=EF=BC=9A
>> > >
>> > > This commit adds support for [m|s|vs]ctrcontrol, sctrstatus and
>> > > sctrdepth CSRs handling.
>> > >
>> > > Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
>> > > ---
>> > >  target/riscv/cpu.h     |   5 ++
>> > >  target/riscv/cpu_cfg.h |   2 +
>> > >  target/riscv/csr.c     | 128 ++++++++++++++++++++++++++++++++++++++=
+++
>> > >  3 files changed, 135 insertions(+)
>> > >
>> > > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> > > index a185e2d494..3d4d5172b8 100644
>> > > --- a/target/riscv/cpu.h
>> > > +++ b/target/riscv/cpu.h
>> > > @@ -263,6 +263,11 @@ struct CPUArchState {
>> > >      target_ulong mcause;
>> > >      target_ulong mtval;  /* since: priv-1.10.0 */
>> > >
>> > > +    uint64_t mctrctl;
>> > > +    uint32_t sctrdepth;
>> > > +    uint32_t sctrstatus;
>> > > +    uint64_t vsctrctl;
>> > > +
>> > >      /* Machine and Supervisor interrupt priorities */
>> > >      uint8_t miprio[64];
>> > >      uint8_t siprio[64];
>> > > diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
>> > > index d9354dc80a..d329a65811 100644
>> > > --- a/target/riscv/cpu_cfg.h
>> > > +++ b/target/riscv/cpu_cfg.h
>> > > @@ -123,6 +123,8 @@ struct RISCVCPUConfig {
>> > >      bool ext_zvfhmin;
>> > >      bool ext_smaia;
>> > >      bool ext_ssaia;
>> > > +    bool ext_smctr;
>> > > +    bool ext_ssctr;
>> >
>> > Base on: https://github.com/riscv/riscv-control-transfer-records/pull/=
29
>> > Smctr and Ssctr depend on both S-mode and Sscsrind.
>> > We should add the implied rules for Smctr and Ssctr.
>> >
>> > Regards,
>> > Frank Chang
>>
>> Hi Frank,
>>
>> Are you referring to the checks in riscv_cpu_validate_set_extensions()?
>> These checks are already present in the last patch.
>>
>> https://lore.kernel.org/qemu-riscv/20240619152708.135991-7-rkanwal@rivos=
inc.com/
>>
>
> Hi Rajnesh,
>
> No, I was referring to the implied rules defined in:
> https://github.com/qemu/qemu/blob/master/target/riscv/cpu.c#L2630
>
> The implied rules will enable the implied extensions when the "parent" ex=
tension is enabled.
> Unless user turns them off explicitly from the command line,
> which is an error and will be caught by the check rules you mentioned abo=
ve.
>
> The spec defines that:
> "Smctr and Ssctr depend on both the implementation of S-mode and the Sscs=
rind extension"
> which means that we should add RVS and Sscsrind extensions as the implied=
 rules for Smctr and Ssctr respectively.
>
> The use of the word "depends" in the spec is quite ambiguous.
> But I once had a chance to ask Andrew Waterman about it,
> and he replied that we should treat =E2=80=9Cdepends on=E2=80=9D or =E2=
=80=9Crequires=E2=80=9D as a synonym for =E2=80=9Cimplies=E2=80=9D.
>
>
> Regards,
> Frank Chang
>

Thanks for the explanation Frank. I will fix this in the next version.

>> >
>> >
>> > >      bool ext_sscofpmf;
>> > >      bool ext_smepmp;
>> > >      bool rvv_ta_all_1s;
>> > > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> > > index 2f92e4b717..0b5bf4d050 100644
>> > > --- a/target/riscv/csr.c
>> > > +++ b/target/riscv/csr.c
>> > > @@ -621,6 +621,48 @@ static RISCVException pointer_masking(CPURISCVS=
tate *env, int csrno)
>> > >      return RISCV_EXCP_ILLEGAL_INST;
>> > >  }
>> > >
>> > > +/*
>> > > + * M-mode:
>> > > + * Without ext_smctr raise illegal inst excep.
>> > > + * Otherwise everything is accessible to m-mode.
>> > > + *
>> > > + * S-mode:
>> > > + * Without ext_ssctr or mstateen.ctr raise illegal inst excep.
>> > > + * Otherwise everything other than mctrctl is accessible.
>> > > + *
>> > > + * VS-mode:
>> > > + * Without ext_ssctr or mstateen.ctr raise illegal inst excep.
>> > > + * Without hstateen.ctr raise virtual illegal inst excep.
>> > > + * Otherwise allow sctrctl (vsctrctl), sctrstatus, 0x200-0x2ff entr=
y range.
>> > > + * Always raise illegal instruction exception for sctrdepth.
>> > > + */
>> > > +static RISCVException ctr_mmode(CPURISCVState *env, int csrno)
>> > > +{
>> > > +    /* Check if smctr-ext is present */
>> > > +    if (riscv_cpu_cfg(env)->ext_smctr) {
>> > > +        return RISCV_EXCP_NONE;
>> > > +    }
>> > > +
>> > > +    return RISCV_EXCP_ILLEGAL_INST;
>> > > +}
>> > > +
>> > > +static RISCVException ctr_smode(CPURISCVState *env, int csrno)
>> > > +{
>> > > +    const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
>> > > +
>> > > +    if (!cfg->ext_smctr && !cfg->ext_ssctr) {
>> > > +        return RISCV_EXCP_ILLEGAL_INST;
>> > > +    }
>> > > +
>> > > +    RISCVException ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_CTR)=
;
>> > > +    if (ret =3D=3D RISCV_EXCP_NONE && csrno =3D=3D CSR_SCTRDEPTH &&
>> > > +        env->virt_enabled) {
>> > > +        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>> > > +    }
>> > > +
>> > > +    return ret;
>> > > +}
>> > > +
>> > >  static RISCVException aia_hmode(CPURISCVState *env, int csrno)
>> > >  {
>> > >      int ret;
>> > > @@ -3835,6 +3877,86 @@ static RISCVException write_satp(CPURISCVStat=
e *env, int csrno,
>> > >      return RISCV_EXCP_NONE;
>> > >  }
>> > >
>> > > +static RISCVException rmw_sctrdepth(CPURISCVState *env, int csrno,
>> > > +                                    target_ulong *ret_val,
>> > > +                                    target_ulong new_val, target_ul=
ong wr_mask)
>> > > +{
>> > > +    uint64_t mask =3D wr_mask & SCTRDEPTH_MASK;
>> > > +
>> > > +    if (ret_val) {
>> > > +        *ret_val =3D env->sctrdepth;
>> > > +    }
>> > > +
>> > > +    env->sctrdepth =3D (env->sctrdepth & ~mask) | (new_val & mask);
>> > > +
>> > > +    /* Correct depth. */
>> > > +    if (wr_mask & SCTRDEPTH_MASK) {
>> > > +        uint64_t depth =3D get_field(env->sctrdepth, SCTRDEPTH_MASK=
);
>> > > +
>> > > +        if (depth > SCTRDEPTH_MAX) {
>> > > +            depth =3D SCTRDEPTH_MAX;
>> > > +            env->sctrdepth =3D set_field(env->sctrdepth, SCTRDEPTH_=
MASK, depth);
>> > > +        }
>> > > +
>> > > +        /* Update sctrstatus.WRPTR with a legal value */
>> > > +        depth =3D 16 << depth;
>> > > +        env->sctrstatus =3D
>> > > +            env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK | (depth - 1)=
);
>> > > +    }
>> > > +
>> > > +    return RISCV_EXCP_NONE;
>> > > +}
>> > > +
>> > > +static RISCVException rmw_sctrstatus(CPURISCVState *env, int csrno,
>> > > +                                     target_ulong *ret_val,
>> > > +                                     target_ulong new_val, target_u=
long wr_mask)
>> > > +{
>> > > +    uint32_t depth =3D 16 << get_field(env->sctrdepth, SCTRDEPTH_MA=
SK);
>> > > +    uint32_t mask =3D wr_mask & SCTRSTATUS_MASK;
>> > > +
>> > > +    if (ret_val) {
>> > > +        *ret_val =3D env->sctrstatus;
>> > > +    }
>> > > +
>> > > +    env->sctrstatus =3D (env->sctrstatus & ~mask) | (new_val & mask=
);
>> > > +
>> > > +    /* Update sctrstatus.WRPTR with a legal value */
>> > > +    env->sctrstatus =3D env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK |=
 (depth - 1));
>> > > +
>> > > +    return RISCV_EXCP_NONE;
>> > > +}
>> > > +
>> > > +static RISCVException rmw_xctrctl(CPURISCVState *env, int csrno,
>> > > +                                    target_ulong *ret_val,
>> > > +                                    target_ulong new_val, target_ul=
ong wr_mask)
>> > > +{
>> > > +    uint64_t csr_mask, mask =3D wr_mask;
>> > > +    uint64_t *ctl_ptr =3D &env->mctrctl;
>> > > +
>> > > +    if (csrno =3D=3D CSR_MCTRCTL) {
>> > > +        csr_mask =3D MCTRCTL_MASK;
>> > > +    } else if (csrno =3D=3D CSR_SCTRCTL && !env->virt_enabled) {
>> > > +        csr_mask =3D SCTRCTL_MASK;
>> > > +    } else {
>> > > +        /*
>> > > +         * This is for csrno =3D=3D CSR_SCTRCTL and env->virt_enabl=
ed =3D=3D true
>> > > +         * or csrno =3D=3D CSR_VSCTRCTL.
>> > > +         */
>> > > +        csr_mask =3D VSCTRCTL_MASK;
>> > > +        ctl_ptr =3D &env->vsctrctl;
>> > > +    }
>> > > +
>> > > +    mask &=3D csr_mask;
>> > > +
>> > > +    if (ret_val) {
>> > > +        *ret_val =3D *ctl_ptr & csr_mask;
>> > > +    }
>> > > +
>> > > +    *ctl_ptr =3D (*ctl_ptr & ~mask) | (new_val & mask);
>> > > +
>> > > +    return RISCV_EXCP_NONE;
>> > > +}
>> > > +
>> > >  static RISCVException read_vstopi(CPURISCVState *env, int csrno,
>> > >                                    target_ulong *val)
>> > >  {
>> > > @@ -5771,6 +5893,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =
=3D {
>> > >      [CSR_SPMBASE] =3D    { "spmbase", pointer_masking, read_spmbase=
,
>> > >                           write_spmbase                             =
         },
>> > >
>> > > +    [CSR_MCTRCTL]    =3D { "mctrctl",    ctr_mmode,  NULL, NULL, rm=
w_xctrctl },
>> > > +    [CSR_SCTRCTL]    =3D { "sctrctl",    ctr_smode,  NULL, NULL, rm=
w_xctrctl },
>> > > +    [CSR_VSCTRCTL]   =3D { "vsctrctl",   ctr_smode,  NULL, NULL, rm=
w_xctrctl },
>> > > +    [CSR_SCTRDEPTH]  =3D { "sctrdepth",  ctr_smode,  NULL, NULL, rm=
w_sctrdepth },
>> > > +    [CSR_SCTRSTATUS] =3D { "sctrstatus", ctr_smode,  NULL, NULL, rm=
w_sctrstatus },
>> > > +
>> > >      /* Performance Counters */
>> > >      [CSR_HPMCOUNTER3]    =3D { "hpmcounter3",    ctr,    read_hpmco=
unter },
>> > >      [CSR_HPMCOUNTER4]    =3D { "hpmcounter4",    ctr,    read_hpmco=
unter },
>> > > --
>> > > 2.34.1
>> > >
>> > >

