Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE15C5472E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 00:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siNZ5-0007nS-58; Sun, 25 Aug 2024 20:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNZ3-0007mB-9t; Sun, 25 Aug 2024 20:26:33 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNZ1-00036Y-Eq; Sun, 25 Aug 2024 20:26:33 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5bed72ff2f2so4546910a12.2; 
 Sun, 25 Aug 2024 17:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724631989; x=1725236789; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GTzhCpatVJbAE/6SXW93RHxtBZQx6PUSgPWDb03816U=;
 b=a+yjcAV3dPbRobkGpOk8QpXFG4gzABX0iBRvY1+HzhjjwZoe/+P24BMiqAoAfaWnaD
 6TsCCZDIw2bC5UKxI8h1rWOuUnAUMnJ9QOYgVIhPyKZuSuLd38LqawGAv1SX9QyOL5fZ
 CZbPtCZQaZcB3zdQkYql52P8HC5dxX7j5tLp98ofcSv1d/397Ru+mhkk04k2mjONfsjo
 n5RoN8gQDX4PJKmo3krqZ3lOh51PsnMkMSGHguKhEhB58yqAsVs4MDoUFC6aDjOnrk+S
 gIUWMVSm3aBiqhzjnNRwb8/dS8G9WqtVocjXGtVA6d//wmVCA4Cqccxn9NUYusum3Kqb
 O77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724631989; x=1725236789;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GTzhCpatVJbAE/6SXW93RHxtBZQx6PUSgPWDb03816U=;
 b=Hub7tTSvxetHOsFpKOFTPGOExcV51gRqEINfKz85fMJ7KKe3uZwk8/0ROh+bwzXPPF
 +xuk8J3l19OHDtDbzV/tt6YbAuCb1bcmysEcloI+61kbshE6qWekQkNGat2rCAIi3q+p
 kV57ChY0oMscDpJ+eWmAKSThuV9NKCTvnyWbwX3GuObJ0Zq4O5ehH2JnbSckZc+MxHs1
 sFTI6nDSjklCzCsxMym+ZCiQDthJg1LXo0E5izvxnMWgD+0OkYNHSdvxLmCr8JmAG79m
 eSkpL23MoZFGCVcnPLU1ZYIGSmmpjSQMdA9XQ50NsRf5gOCqWRL9bI/13RFCa4cx6u21
 QYyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEL5C34lg7Iw/UMMcATVqAMLu2yTXRBffq5TIGl5edCjrXtQdPdNkqWC9JmoSqcMDRFbmBm6fs0gJg@nongnu.org
X-Gm-Message-State: AOJu0YxJnjT7kX4Kyj7z3bYCHCn8o45840RsQvLC5BVk70gtolCNr9+3
 juU3030Pc4v6YeMT6L7qNzhioNP8Axl6TlOKJ+8+IpNSTMnINGrjhfYBk3uqtjYAbbf8b0FVN5u
 bZDRJRUyrg3tBjV6Vt0SyQDCuIjk=
X-Google-Smtp-Source: AGHT+IEH6VXgJVIg6nLgtHVElbkuk/CHY+uxYFs98nyDe8Oxjkh91QHpLGshZxLWY+iN/b+iiaj6u6qOa59QSKJjHyU=
X-Received: by 2002:a05:6402:2745:b0:5be:f295:a181 with SMTP id
 4fb4d7f45d1cf-5c0891a23f4mr5513117a12.28.1724631988919; Sun, 25 Aug 2024
 17:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240721072422.1377506-1-alvinga@andestech.com>
 <20240721072422.1377506-3-alvinga@andestech.com>
 <SEYPR03MB67002DA61D8E15CD006817B1A88D2@SEYPR03MB6700.apcprd03.prod.outlook.com>
In-Reply-To: <SEYPR03MB67002DA61D8E15CD006817B1A88D2@SEYPR03MB6700.apcprd03.prod.outlook.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Aug 2024 10:26:01 +1000
Message-ID: <CAKmqyKN2rBBhO3BWs5kNUWKqPcH0dZS7ETPp-gHpe1AnDd=MiA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] target/riscv: Add textra matching condition for
 the triggers
To: =?UTF-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>, 
 "bin.meng@windriver.com" <bin.meng@windriver.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, 
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
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

On Tue, Aug 20, 2024 at 2:00=E2=80=AFPM Alvin Che-Chia Chang(=E5=BC=B5=E5=
=93=B2=E5=98=89)
<alvinga@andestech.com> wrote:
>
> Hi Alistair,
>
> > -----Original Message-----
> > From: Alvin Che-Chia Chang(=E5=BC=B5=E5=93=B2=E5=98=89) <alvinga@andest=
ech.com>
> > Sent: Sunday, July 21, 2024 3:24 PM
> > To: qemu-riscv@nongnu.org; qemu-devel@nongnu.org
> > Cc: alistair.francis@wdc.com; bin.meng@windriver.com;
> > liwei1518@gmail.com; dbarboza@ventanamicro.com;
> > zhiwei_liu@linux.alibaba.com; Alvin Che-Chia Chang(=E5=BC=B5=E5=93=B2=
=E5=98=89)
> > <alvinga@andestech.com>
> > Subject: [PATCH v3 2/2] target/riscv: Add textra matching condition for=
 the
> > triggers
> >
> > According to RISC-V Debug specification, the optional textra32 and
> > textra64 trigger CSRs can be used to configure additional matching cond=
itions
> > for the triggers. For example, if the textra.MHSELECT field is set to 4
> > (mcontext), this trigger will only match or fire if the low bits of
> > mcontext/hcontext equal textra.MHVALUE field.
> >
> > This commit adds the aforementioned matching condition as common trigge=
r
> > matching conditions. Currently, the only legal values of textra.MHSELEC=
T are 0
> > (ignore) and 4 (mcontext). When textra.MHSELECT is 0, we pass the check=
ing.
> > When textra.MHSELECT is 4, we compare textra.MHVALUE with mcontext CSR.
> > The remaining fields, such as textra.SBYTEMASK, textra.SVALUE, and
> > textra.SSELECT, are hardwired to zero for now. Thus, we skip checking t=
hem
> > here.
> >
> > Signed-off-by: Alvin Chang <alvinga@andestech.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/debug.c | 63
> > +++++++++++++++++++++++++++++++++++++++++++-
> >  target/riscv/debug.h |  3 +++
> >  2 files changed, 65 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/riscv/debug.c b/target/riscv/debug.c index
> > d6b4a06144..62bb758860 100644
> > --- a/target/riscv/debug.c
> > +++ b/target/riscv/debug.c
> > @@ -364,11 +364,72 @@ static bool trigger_priv_match(CPURISCVState *env=
,
> > trigger_type_t type,
> >      return false;
> >  }
> >
> > +static bool trigger_textra_match(CPURISCVState *env, trigger_type_t ty=
pe,
> > +                                 int trigger_index) {
> > +    target_ulong textra =3D env->tdata3[trigger_index];
> > +    target_ulong mhvalue, mhselect;
> > +
> > +    if (type < TRIGGER_TYPE_AD_MATCH || type >
> > TRIGGER_TYPE_AD_MATCH6) {
> > +        /* textra checking is only applicable when type is 2, 3, 4, 5,=
 or 6 */
> > +        return true;
> > +    }
> > +
> > +    switch (riscv_cpu_mxl(env)) {
> > +    case MXL_RV32:
> > +        mhvalue  =3D get_field(textra, TEXTRA32_MHVALUE);
> > +        mhselect =3D get_field(textra, TEXTRA32_MHSELECT);
> > +        break;
> > +    case MXL_RV64:
> > +    case MXL_RV128:
> > +        mhvalue  =3D get_field(textra, TEXTRA64_MHVALUE);
> > +        mhselect =3D get_field(textra, TEXTRA64_MHSELECT);
> > +        break;
> > +    default:
> > +        g_assert_not_reached();
> > +    }
> > +
> > +    /* Check mhvalue and mhselect. */
> > +    switch (mhselect) {
> > +    case MHSELECT_IGNORE:
> > +        break;
> > +    case MHSELECT_MCONTEXT:
> > +        /* Match or fire if the low bits of mcontext/hcontext equal mh=
value.
> > */
> > +        if (riscv_has_ext(env, RVH)) {
> > +            if (mhvalue !=3D env->mcontext) {
> > +                return false;
> > +            }
> > +        } else {
> > +            switch (riscv_cpu_mxl(env)) {
> > +            case MXL_RV32:
> > +                if (mhvalue !=3D (env->mcontext & MCONTEXT32)) {
> > +                    return false;
> > +                }
> > +                break;
> > +            case MXL_RV64:
> > +            case MXL_RV128:
> > +                if (mhvalue !=3D (env->mcontext & MCONTEXT64)) {
> > +                    return false;
> > +                }
> > +                break;
> > +            default:
> > +                g_assert_not_reached();
> > +            }
> > +        }
>
> I have some new ideas on this part.
> Should we replace this whole if-else with just the following simple code =
?
>
>     case MHSELECT_MCONTEXT:
>         /* Match if the low bits of mcontext/hcontext equal mhvalue. */
>         if (mhvalue !=3D env->mcontext) {
>             return false;
>         }
>         break;
>
> Those masks on mcontext have been applied in write_mcontext().
> I think we can skip the masks here.
> What do you think ?

Yep, that would be much better

Alistair

>
>
> Regards,
> Alvin Chang
>
> > +        break;
> > +    default:
> > +        break;
> > +    }
> > +
> > +    return true;
> > +}
> > +
> >  /* Common matching conditions for all types of the triggers. */  stati=
c bool
> > trigger_common_match(CPURISCVState *env, trigger_type_t type,
> >                                   int trigger_index)  {
> > -    return trigger_priv_match(env, type, trigger_index);
> > +    return trigger_priv_match(env, type, trigger_index) &&
> > +           trigger_textra_match(env, type, trigger_index);
> >  }
> >
> >  /* type 2 trigger */
> > diff --git a/target/riscv/debug.h b/target/riscv/debug.h index
> > c347863578..f76b8f944a 100644
> > --- a/target/riscv/debug.h
> > +++ b/target/riscv/debug.h
> > @@ -131,6 +131,9 @@ enum {
> >  #define ITRIGGER_VU           BIT(25)
> >  #define ITRIGGER_VS           BIT(26)
> >
> > +#define MHSELECT_IGNORE       0
> > +#define MHSELECT_MCONTEXT     4
> > +
> >  bool tdata_available(CPURISCVState *env, int tdata_index);
> >
> >  target_ulong tselect_csr_read(CPURISCVState *env);
> > --
> > 2.34.1
>
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

