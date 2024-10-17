Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95BAD374A4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1S3s-0003P2-8V; Thu, 17 Oct 2024 11:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t1S3q-0003Nk-9n
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:05:10 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t1S3n-0008Os-8J
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:05:10 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c9693dc739so1438948a12.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1729177505; x=1729782305; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lDMSCWq37/De8x9iAljIJuzvnpwvPEXMxqtanZab1jc=;
 b=gt2Z0wUlKKSmgQKdkoyeHHG38fgCafljD+Z8jepErmFHMS9yXqU3gzBodNttdHWDug
 HjE6SRho9dUYJPPdpI8DKhxFAstYsd3cQGgf5UtpY/k7K7AfaRnwwGVoXhoHEeF2gCMj
 O52YT+vGkFBzy52d2dLyt3iV0g/Z65oa9f0ivG2nvcTbAznNS0dv+Hg6HhKYSsIh9fN3
 8eJ4HeFQ/3oO5tyg2KNY7W5peeadiQA3CksbavBST/gTp+BuVIaWmTJMYNAqUWkR/ALP
 Jw4d6fA/u/3APCUuEMXD7clOhYNwsKQO3haVvOzmQ5+Ip9BRdrkvC2V4tfTT1gKM9BJs
 2nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729177505; x=1729782305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lDMSCWq37/De8x9iAljIJuzvnpwvPEXMxqtanZab1jc=;
 b=mm8kKUsNjy3n156XnvRSeNFfU2CbMuEWAoj2L0hvp9SQ6L5gWPDspoJ6JGStH4xTDI
 TWfjZ9PUt4mukLrkHJjmkSmavLdl3FBvFxYg4pwHtNeTzs6QoblmiE17i8zScf+0aPlT
 xb9lxM1jegCucHHshwyGxzPbE8Rq81SsoZ4HvwriDczsoJMJXnuR0bnlqJ3HtNaycRIy
 Ko0XJjN/+jtSp4tWMba+ULGisqCiCn0QhYIl6WCj3scn3X545wAC+j7YKKvnkAnEpGBZ
 YfhAbmQge0iu2oJAmgPz1QISiy9UUnidzfVx8/yjwIIwgxWE4GVO2akWDeJNDZgRSWNx
 k7yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUscOGVGJAvjVLy+wgPN+Y48uFeQ3Xr2w6+d0YQ897jJ/NSZCchHs+56OlRshSSLU4DflDohvjw1j3S@nongnu.org
X-Gm-Message-State: AOJu0YwCx8BVoWn3hwcHf6YnbPidRNGHnWT5WNP2r61FxRn5eS6FUEmO
 RBJ6CwU+fREbDGiLlG8Z5LuTZ4g3zbGGfkzMixBn5dssuRh7E3vtVkuFV3/J6jmXJv/w6wsdWS3
 JP3KWc/4RiW+Mefw3noxXJu/y1t7ev00SU/mCWg==
X-Google-Smtp-Source: AGHT+IH1wOlrvcmxxZAfQL2a3YlThcrY+OP0Ur2zd2+N1rNVltw84rMikYG+5NHMcA5czQfHbp00g7sUV7/nJ4MiKdY=
X-Received: by 2002:a05:6402:1d4a:b0:5c9:7d96:772d with SMTP id
 4fb4d7f45d1cf-5c97d967951mr12355873a12.22.1729177503832; Thu, 17 Oct 2024
 08:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240619152708.135991-1-rkanwal@rivosinc.com>
 <20240619152708.135991-4-rkanwal@rivosinc.com>
 <CANzO1D33XPxXAJ8kxBz0oa1R8pb5et3BQV5EELiEvdhSjj3S1Q@mail.gmail.com>
 <CAECbVCuQ-tWFrskOZ3FcG+nziamTb8fHV8iA5VOUfhFa4AvAMA@mail.gmail.com>
In-Reply-To: <CAECbVCuQ-tWFrskOZ3FcG+nziamTb8fHV8iA5VOUfhFa4AvAMA@mail.gmail.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Thu, 17 Oct 2024 23:04:52 +0800
Message-ID: <CAE_xrPiRtiO+2-PazQSZJkfKfWwZ1=0UoMOkQ82Z7vAUFJ4+wA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] target/riscv: Add support for Control Transfer
 Records extension CSRs.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, tech-control-transfer-records@lists.riscv.org, 
 jason.chien@sifive.com
Content-Type: multipart/alternative; boundary="000000000000deb8d20624ad8293"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=frank.chang@sifive.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--000000000000deb8d20624ad8293
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 7:18=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.co=
m> wrote:

> On Tue, Aug 27, 2024 at 10:28=E2=80=AFAM Frank Chang <frank.chang@sifive.=
com>
> wrote:
> >
> > Rajnesh Kanwal <rkanwal@rivosinc.com> =E6=96=BC 2024=E5=B9=B46=E6=9C=88=
19=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:27=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > >
> > > This commit adds support for [m|s|vs]ctrcontrol, sctrstatus and
> > > sctrdepth CSRs handling.
> > >
> > > Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> > > ---
> > >  target/riscv/cpu.h     |   5 ++
> > >  target/riscv/cpu_cfg.h |   2 +
> > >  target/riscv/csr.c     | 128 +++++++++++++++++++++++++++++++++++++++=
++
> > >  3 files changed, 135 insertions(+)
> > >
> > > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > > index a185e2d494..3d4d5172b8 100644
> > > --- a/target/riscv/cpu.h
> > > +++ b/target/riscv/cpu.h
> > > @@ -263,6 +263,11 @@ struct CPUArchState {
> > >      target_ulong mcause;
> > >      target_ulong mtval;  /* since: priv-1.10.0 */
> > >
> > > +    uint64_t mctrctl;
> > > +    uint32_t sctrdepth;
> > > +    uint32_t sctrstatus;
> > > +    uint64_t vsctrctl;
> > > +
> > >      /* Machine and Supervisor interrupt priorities */
> > >      uint8_t miprio[64];
> > >      uint8_t siprio[64];
> > > diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> > > index d9354dc80a..d329a65811 100644
> > > --- a/target/riscv/cpu_cfg.h
> > > +++ b/target/riscv/cpu_cfg.h
> > > @@ -123,6 +123,8 @@ struct RISCVCPUConfig {
> > >      bool ext_zvfhmin;
> > >      bool ext_smaia;
> > >      bool ext_ssaia;
> > > +    bool ext_smctr;
> > > +    bool ext_ssctr;
> >
> > Base on: https://github.com/riscv/riscv-control-transfer-records/pull/2=
9
> > Smctr and Ssctr depend on both S-mode and Sscsrind.
> > We should add the implied rules for Smctr and Ssctr.
> >
> > Regards,
> > Frank Chang
>
> Hi Frank,
>
> Are you referring to the checks in riscv_cpu_validate_set_extensions()?
> These checks are already present in the last patch.
>
>
> https://lore.kernel.org/qemu-riscv/20240619152708.135991-7-rkanwal@rivosi=
nc.com/
>
>
Hi Rajnesh,

No, I was referring to the implied rules defined in:
https://github.com/qemu/qemu/blob/master/target/riscv/cpu.c#L2630

The implied rules will enable the implied extensions when the "parent"
extension is enabled.
Unless user turns them off explicitly from the command line,
which is an error and will be caught by the check rules you mentioned above=
.

The spec defines that:
"Smctr and Ssctr depend on both the implementation of S-mode and the
Sscsrind extension"
which means that we should add RVS and Sscsrind extensions as the implied
rules for Smctr and Ssctr respectively.

The use of the word "depends" in the spec is quite ambiguous.
But I once had a chance to ask Andrew Waterman about it,
and he replied that we should treat =E2=80=9Cdepends on=E2=80=9D or =E2=80=
=9Crequires=E2=80=9D as a synonym
for =E2=80=9Cimplies=E2=80=9D.


Regards,
Frank Chang

>
> >
> > >      bool ext_sscofpmf;
> > >      bool ext_smepmp;
> > >      bool rvv_ta_all_1s;
> > > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > > index 2f92e4b717..0b5bf4d050 100644
> > > --- a/target/riscv/csr.c
> > > +++ b/target/riscv/csr.c
> > > @@ -621,6 +621,48 @@ static RISCVException
> pointer_masking(CPURISCVState *env, int csrno)
> > >      return RISCV_EXCP_ILLEGAL_INST;
> > >  }
> > >
> > > +/*
> > > + * M-mode:
> > > + * Without ext_smctr raise illegal inst excep.
> > > + * Otherwise everything is accessible to m-mode.
> > > + *
> > > + * S-mode:
> > > + * Without ext_ssctr or mstateen.ctr raise illegal inst excep.
> > > + * Otherwise everything other than mctrctl is accessible.
> > > + *
> > > + * VS-mode:
> > > + * Without ext_ssctr or mstateen.ctr raise illegal inst excep.
> > > + * Without hstateen.ctr raise virtual illegal inst excep.
> > > + * Otherwise allow sctrctl (vsctrctl), sctrstatus, 0x200-0x2ff entry
> range.
> > > + * Always raise illegal instruction exception for sctrdepth.
> > > + */
> > > +static RISCVException ctr_mmode(CPURISCVState *env, int csrno)
> > > +{
> > > +    /* Check if smctr-ext is present */
> > > +    if (riscv_cpu_cfg(env)->ext_smctr) {
> > > +        return RISCV_EXCP_NONE;
> > > +    }
> > > +
> > > +    return RISCV_EXCP_ILLEGAL_INST;
> > > +}
> > > +
> > > +static RISCVException ctr_smode(CPURISCVState *env, int csrno)
> > > +{
> > > +    const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
> > > +
> > > +    if (!cfg->ext_smctr && !cfg->ext_ssctr) {
> > > +        return RISCV_EXCP_ILLEGAL_INST;
> > > +    }
> > > +
> > > +    RISCVException ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
> > > +    if (ret =3D=3D RISCV_EXCP_NONE && csrno =3D=3D CSR_SCTRDEPTH &&
> > > +        env->virt_enabled) {
> > > +        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
> > > +    }
> > > +
> > > +    return ret;
> > > +}
> > > +
> > >  static RISCVException aia_hmode(CPURISCVState *env, int csrno)
> > >  {
> > >      int ret;
> > > @@ -3835,6 +3877,86 @@ static RISCVException write_satp(CPURISCVState
> *env, int csrno,
> > >      return RISCV_EXCP_NONE;
> > >  }
> > >
> > > +static RISCVException rmw_sctrdepth(CPURISCVState *env, int csrno,
> > > +                                    target_ulong *ret_val,
> > > +                                    target_ulong new_val,
> target_ulong wr_mask)
> > > +{
> > > +    uint64_t mask =3D wr_mask & SCTRDEPTH_MASK;
> > > +
> > > +    if (ret_val) {
> > > +        *ret_val =3D env->sctrdepth;
> > > +    }
> > > +
> > > +    env->sctrdepth =3D (env->sctrdepth & ~mask) | (new_val & mask);
> > > +
> > > +    /* Correct depth. */
> > > +    if (wr_mask & SCTRDEPTH_MASK) {
> > > +        uint64_t depth =3D get_field(env->sctrdepth, SCTRDEPTH_MASK)=
;
> > > +
> > > +        if (depth > SCTRDEPTH_MAX) {
> > > +            depth =3D SCTRDEPTH_MAX;
> > > +            env->sctrdepth =3D set_field(env->sctrdepth,
> SCTRDEPTH_MASK, depth);
> > > +        }
> > > +
> > > +        /* Update sctrstatus.WRPTR with a legal value */
> > > +        depth =3D 16 << depth;
> > > +        env->sctrstatus =3D
> > > +            env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK | (depth - 1))=
;
> > > +    }
> > > +
> > > +    return RISCV_EXCP_NONE;
> > > +}
> > > +
> > > +static RISCVException rmw_sctrstatus(CPURISCVState *env, int csrno,
> > > +                                     target_ulong *ret_val,
> > > +                                     target_ulong new_val,
> target_ulong wr_mask)
> > > +{
> > > +    uint32_t depth =3D 16 << get_field(env->sctrdepth, SCTRDEPTH_MAS=
K);
> > > +    uint32_t mask =3D wr_mask & SCTRSTATUS_MASK;
> > > +
> > > +    if (ret_val) {
> > > +        *ret_val =3D env->sctrstatus;
> > > +    }
> > > +
> > > +    env->sctrstatus =3D (env->sctrstatus & ~mask) | (new_val & mask)=
;
> > > +
> > > +    /* Update sctrstatus.WRPTR with a legal value */
> > > +    env->sctrstatus =3D env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK |
> (depth - 1));
> > > +
> > > +    return RISCV_EXCP_NONE;
> > > +}
> > > +
> > > +static RISCVException rmw_xctrctl(CPURISCVState *env, int csrno,
> > > +                                    target_ulong *ret_val,
> > > +                                    target_ulong new_val,
> target_ulong wr_mask)
> > > +{
> > > +    uint64_t csr_mask, mask =3D wr_mask;
> > > +    uint64_t *ctl_ptr =3D &env->mctrctl;
> > > +
> > > +    if (csrno =3D=3D CSR_MCTRCTL) {
> > > +        csr_mask =3D MCTRCTL_MASK;
> > > +    } else if (csrno =3D=3D CSR_SCTRCTL && !env->virt_enabled) {
> > > +        csr_mask =3D SCTRCTL_MASK;
> > > +    } else {
> > > +        /*
> > > +         * This is for csrno =3D=3D CSR_SCTRCTL and env->virt_enable=
d =3D=3D
> true
> > > +         * or csrno =3D=3D CSR_VSCTRCTL.
> > > +         */
> > > +        csr_mask =3D VSCTRCTL_MASK;
> > > +        ctl_ptr =3D &env->vsctrctl;
> > > +    }
> > > +
> > > +    mask &=3D csr_mask;
> > > +
> > > +    if (ret_val) {
> > > +        *ret_val =3D *ctl_ptr & csr_mask;
> > > +    }
> > > +
> > > +    *ctl_ptr =3D (*ctl_ptr & ~mask) | (new_val & mask);
> > > +
> > > +    return RISCV_EXCP_NONE;
> > > +}
> > > +
> > >  static RISCVException read_vstopi(CPURISCVState *env, int csrno,
> > >                                    target_ulong *val)
> > >  {
> > > @@ -5771,6 +5893,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =
=3D {
> > >      [CSR_SPMBASE] =3D    { "spmbase", pointer_masking, read_spmbase,
> > >                           write_spmbase
>       },
> > >
> > > +    [CSR_MCTRCTL]    =3D { "mctrctl",    ctr_mmode,  NULL, NULL,
> rmw_xctrctl },
> > > +    [CSR_SCTRCTL]    =3D { "sctrctl",    ctr_smode,  NULL, NULL,
> rmw_xctrctl },
> > > +    [CSR_VSCTRCTL]   =3D { "vsctrctl",   ctr_smode,  NULL, NULL,
> rmw_xctrctl },
> > > +    [CSR_SCTRDEPTH]  =3D { "sctrdepth",  ctr_smode,  NULL, NULL,
> rmw_sctrdepth },
> > > +    [CSR_SCTRSTATUS] =3D { "sctrstatus", ctr_smode,  NULL, NULL,
> rmw_sctrstatus },
> > > +
> > >      /* Performance Counters */
> > >      [CSR_HPMCOUNTER3]    =3D { "hpmcounter3",    ctr,
> read_hpmcounter },
> > >      [CSR_HPMCOUNTER4]    =3D { "hpmcounter4",    ctr,
> read_hpmcounter },
> > > --
> > > 2.34.1
> > >
> > >
>

--000000000000deb8d20624ad8293
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Oct 17, 2024 at 7:18=E2=80=AFPM R=
ajnesh Kanwal &lt;<a href=3D"mailto:rkanwal@rivosinc.com">rkanwal@rivosinc.=
com</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On Tue, Aug 27, 2024 at 10:28=E2=80=AFAM Fran=
k Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank">fra=
nk.chang@sifive.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Rajnesh Kanwal &lt;<a href=3D"mailto:rkanwal@rivosinc.com" target=3D"_=
blank">rkanwal@rivosinc.com</a>&gt; =E6=96=BC 2024=E5=B9=B46=E6=9C=8819=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:27=E5=AF=AB=E9=81=93=EF=BC=
=9A<br>
&gt; &gt;<br>
&gt; &gt; This commit adds support for [m|s|vs]ctrcontrol, sctrstatus and<b=
r>
&gt; &gt; sctrdepth CSRs handling.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Rajnesh Kanwal &lt;<a href=3D"mailto:rkanwal@rivos=
inc.com" target=3D"_blank">rkanwal@rivosinc.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 ++<br=
>
&gt; &gt;=C2=A0 target/riscv/cpu_cfg.h |=C2=A0 =C2=A02 +<br>
&gt; &gt;=C2=A0 target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0| 128 +++++++++++++++=
++++++++++++++++++++++++++<br>
&gt; &gt;=C2=A0 3 files changed, 135 insertions(+)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h<br>
&gt; &gt; index a185e2d494..3d4d5172b8 100644<br>
&gt; &gt; --- a/target/riscv/cpu.h<br>
&gt; &gt; +++ b/target/riscv/cpu.h<br>
&gt; &gt; @@ -263,6 +263,11 @@ struct CPUArchState {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 target_ulong mcause;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 target_ulong mtval;=C2=A0 /* since: priv-1.10=
.0 */<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint64_t mctrctl;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint32_t sctrdepth;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint32_t sctrstatus;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint64_t vsctrctl;<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* Machine and Supervisor interrupt prioritie=
s */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint8_t miprio[64];<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint8_t siprio[64];<br>
&gt; &gt; diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h<br>
&gt; &gt; index d9354dc80a..d329a65811 100644<br>
&gt; &gt; --- a/target/riscv/cpu_cfg.h<br>
&gt; &gt; +++ b/target/riscv/cpu_cfg.h<br>
&gt; &gt; @@ -123,6 +123,8 @@ struct RISCVCPUConfig {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 bool ext_zvfhmin;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 bool ext_smaia;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 bool ext_ssaia;<br>
&gt; &gt; +=C2=A0 =C2=A0 bool ext_smctr;<br>
&gt; &gt; +=C2=A0 =C2=A0 bool ext_ssctr;<br>
&gt;<br>
&gt; Base on: <a href=3D"https://github.com/riscv/riscv-control-transfer-re=
cords/pull/29" rel=3D"noreferrer" target=3D"_blank">https://github.com/risc=
v/riscv-control-transfer-records/pull/29</a><br>
&gt; Smctr and Ssctr depend on both S-mode and Sscsrind.<br>
&gt; We should add the implied rules for Smctr and Ssctr.<br>
&gt;<br>
&gt; Regards,<br>
&gt; Frank Chang<br>
<br>
Hi Frank,<br>
<br>
Are you referring to the checks in riscv_cpu_validate_set_extensions()?<br>
These checks are already present in the last patch.<br>
<br>
<a href=3D"https://lore.kernel.org/qemu-riscv/20240619152708.135991-7-rkanw=
al@rivosinc.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.=
org/qemu-riscv/20240619152708.135991-7-rkanwal@rivosinc.com/</a><br><br></b=
lockquote><div><br></div><div>Hi Rajnesh,</div><div><br></div><div>No, I wa=
s referring to the implied=C2=A0rules defined in:</div><div><a href=3D"http=
s://github.com/qemu/qemu/blob/master/target/riscv/cpu.c#L2630">https://gith=
ub.com/qemu/qemu/blob/master/target/riscv/cpu.c#L2630</a><br></div><div><br=
></div><div>The implied rules will enable the implied extensions when the &=
quot;parent&quot; extension is enabled.</div><div>Unless user turns them of=
f explicitly from the command line,</div><div>which is an=C2=A0error and wi=
ll be caught by the check rules you mentioned above.</div><div><br></div><d=
iv>The spec defines that:</div><div>&quot;Smctr and Ssctr depend on both th=
e implementation of S-mode and the Sscsrind extension&quot;</div><div>which=
 means that we should add RVS and Sscsrind=C2=A0extensions as the implied r=
ules for Smctr and Ssctr respectively.</div><div><br></div><div>The use of =
the word &quot;depends&quot; in the spec is quite ambiguous.</div><div>But =
I once had a chance to ask Andrew Waterman about it,</div><div>and he repli=
ed that we should treat =E2=80=9Cdepends on=E2=80=9D or =E2=80=9Crequires=
=E2=80=9D as a synonym for =E2=80=9Cimplies=E2=80=9D.</div><div><br></div><=
div><br></div><div>Regards,</div><div>Frank Chang</div><div><br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 bool ext_sscofpmf;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 bool ext_smepmp;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 bool rvv_ta_all_1s;<br>
&gt; &gt; diff --git a/target/riscv/csr.c b/target/riscv/csr.c<br>
&gt; &gt; index 2f92e4b717..0b5bf4d050 100644<br>
&gt; &gt; --- a/target/riscv/csr.c<br>
&gt; &gt; +++ b/target/riscv/csr.c<br>
&gt; &gt; @@ -621,6 +621,48 @@ static RISCVException pointer_masking(CPURIS=
CVState *env, int csrno)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_ILLEGAL_INST;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; +/*<br>
&gt; &gt; + * M-mode:<br>
&gt; &gt; + * Without ext_smctr raise illegal inst excep.<br>
&gt; &gt; + * Otherwise everything is accessible to m-mode.<br>
&gt; &gt; + *<br>
&gt; &gt; + * S-mode:<br>
&gt; &gt; + * Without ext_ssctr or mstateen.ctr raise illegal inst excep.<b=
r>
&gt; &gt; + * Otherwise everything other than mctrctl is accessible.<br>
&gt; &gt; + *<br>
&gt; &gt; + * VS-mode:<br>
&gt; &gt; + * Without ext_ssctr or mstateen.ctr raise illegal inst excep.<b=
r>
&gt; &gt; + * Without hstateen.ctr raise virtual illegal inst excep.<br>
&gt; &gt; + * Otherwise allow sctrctl (vsctrctl), sctrstatus, 0x200-0x2ff e=
ntry range.<br>
&gt; &gt; + * Always raise illegal instruction exception for sctrdepth.<br>
&gt; &gt; + */<br>
&gt; &gt; +static RISCVException ctr_mmode(CPURISCVState *env, int csrno)<b=
r>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 /* Check if smctr-ext is present */<br>
&gt; &gt; +=C2=A0 =C2=A0 if (riscv_cpu_cfg(env)-&gt;ext_smctr) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_NONE;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 return RISCV_EXCP_ILLEGAL_INST;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static RISCVException ctr_smode(CPURISCVState *env, int csrno)<b=
r>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);<=
br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 if (!cfg-&gt;ext_smctr &amp;&amp; !cfg-&gt;ext_ssc=
tr) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_ILLEGAL_INST;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 RISCVException ret =3D smstateen_acc_ok(env, 0, SM=
STATEEN0_CTR);<br>
&gt; &gt; +=C2=A0 =C2=A0 if (ret =3D=3D RISCV_EXCP_NONE &amp;&amp; csrno =
=3D=3D CSR_SCTRDEPTH &amp;&amp;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;virt_enabled) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_VIRT_INSTRUCTION_F=
AULT;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 static RISCVException aia_hmode(CPURISCVState *env, int csr=
no)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; &gt; @@ -3835,6 +3877,86 @@ static RISCVException write_satp(CPURISCVS=
tate *env, int csrno,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_NONE;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; +static RISCVException rmw_sctrdepth(CPURISCVState *env, int csrn=
o,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong=
 *ret_val,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong=
 new_val, target_ulong wr_mask)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 uint64_t mask =3D wr_mask &amp; SCTRDEPTH_MASK;<br=
>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 if (ret_val) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *ret_val =3D env-&gt;sctrdepth;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 env-&gt;sctrdepth =3D (env-&gt;sctrdepth &amp; ~ma=
sk) | (new_val &amp; mask);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 /* Correct depth. */<br>
&gt; &gt; +=C2=A0 =C2=A0 if (wr_mask &amp; SCTRDEPTH_MASK) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t depth =3D get_field(env-&gt=
;sctrdepth, SCTRDEPTH_MASK);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (depth &gt; SCTRDEPTH_MAX) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 depth =3D SCTRDEPTH_MA=
X;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;sctrdepth =3D =
set_field(env-&gt;sctrdepth, SCTRDEPTH_MASK, depth);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Update sctrstatus.WRPTR with a le=
gal value */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 depth =3D 16 &lt;&lt; depth;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;sctrstatus =3D<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;sctrstatus &am=
p; (~SCTRSTATUS_WRPTR_MASK | (depth - 1));<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 return RISCV_EXCP_NONE;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static RISCVException rmw_sctrstatus(CPURISCVState *env, int csr=
no,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target=
_ulong *ret_val,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target=
_ulong new_val, target_ulong wr_mask)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 uint32_t depth =3D 16 &lt;&lt; get_field(env-&gt;s=
ctrdepth, SCTRDEPTH_MASK);<br>
&gt; &gt; +=C2=A0 =C2=A0 uint32_t mask =3D wr_mask &amp; SCTRSTATUS_MASK;<b=
r>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 if (ret_val) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *ret_val =3D env-&gt;sctrstatus;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 env-&gt;sctrstatus =3D (env-&gt;sctrstatus &amp; ~=
mask) | (new_val &amp; mask);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 /* Update sctrstatus.WRPTR with a legal value */<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 env-&gt;sctrstatus =3D env-&gt;sctrstatus &amp; (~=
SCTRSTATUS_WRPTR_MASK | (depth - 1));<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 return RISCV_EXCP_NONE;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static RISCVException rmw_xctrctl(CPURISCVState *env, int csrno,=
<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong=
 *ret_val,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong=
 new_val, target_ulong wr_mask)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 uint64_t csr_mask, mask =3D wr_mask;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint64_t *ctl_ptr =3D &amp;env-&gt;mctrctl;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 if (csrno =3D=3D CSR_MCTRCTL) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 csr_mask =3D MCTRCTL_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 } else if (csrno =3D=3D CSR_SCTRCTL &amp;&amp; !en=
v-&gt;virt_enabled) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 csr_mask =3D SCTRCTL_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 } else {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* This is for csrno =3D=3D CSR=
_SCTRCTL and env-&gt;virt_enabled =3D=3D true<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* or csrno =3D=3D CSR_VSCTRCTL=
.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 csr_mask =3D VSCTRCTL_MASK;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctl_ptr =3D &amp;env-&gt;vsctrctl;<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 mask &amp;=3D csr_mask;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 if (ret_val) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *ret_val =3D *ctl_ptr &amp; csr_mask=
;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 *ctl_ptr =3D (*ctl_ptr &amp; ~mask) | (new_val &am=
p; mask);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 return RISCV_EXCP_NONE;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 static RISCVException read_vstopi(CPURISCVState *env, int c=
srno,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong *v=
al)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; @@ -5771,6 +5893,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZ=
E] =3D {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 [CSR_SPMBASE] =3D=C2=A0 =C2=A0 { &quot;spmbas=
e&quot;, pointer_masking, read_spmbase,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0write_spmbase=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 [CSR_MCTRCTL]=C2=A0 =C2=A0 =3D { &quot;mctrctl&quo=
t;,=C2=A0 =C2=A0 ctr_mmode,=C2=A0 NULL, NULL, rmw_xctrctl },<br>
&gt; &gt; +=C2=A0 =C2=A0 [CSR_SCTRCTL]=C2=A0 =C2=A0 =3D { &quot;sctrctl&quo=
t;,=C2=A0 =C2=A0 ctr_smode,=C2=A0 NULL, NULL, rmw_xctrctl },<br>
&gt; &gt; +=C2=A0 =C2=A0 [CSR_VSCTRCTL]=C2=A0 =C2=A0=3D { &quot;vsctrctl&qu=
ot;,=C2=A0 =C2=A0ctr_smode,=C2=A0 NULL, NULL, rmw_xctrctl },<br>
&gt; &gt; +=C2=A0 =C2=A0 [CSR_SCTRDEPTH]=C2=A0 =3D { &quot;sctrdepth&quot;,=
=C2=A0 ctr_smode,=C2=A0 NULL, NULL, rmw_sctrdepth },<br>
&gt; &gt; +=C2=A0 =C2=A0 [CSR_SCTRSTATUS] =3D { &quot;sctrstatus&quot;, ctr=
_smode,=C2=A0 NULL, NULL, rmw_sctrstatus },<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* Performance Counters */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 [CSR_HPMCOUNTER3]=C2=A0 =C2=A0 =3D { &quot;hp=
mcounter3&quot;,=C2=A0 =C2=A0 ctr,=C2=A0 =C2=A0 read_hpmcounter },<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 [CSR_HPMCOUNTER4]=C2=A0 =C2=A0 =3D { &quot;hp=
mcounter4&quot;,=C2=A0 =C2=A0 ctr,=C2=A0 =C2=A0 read_hpmcounter },<br>
&gt; &gt; --<br>
&gt; &gt; 2.34.1<br>
&gt; &gt;<br>
&gt; &gt;<br>
</blockquote></div></div>

--000000000000deb8d20624ad8293--

