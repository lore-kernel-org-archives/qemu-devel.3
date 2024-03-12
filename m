Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF95AC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxu1-0006sA-Bh; Tue, 12 Mar 2024 04:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjxtr-0006aW-F5; Tue, 12 Mar 2024 04:54:19 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjxtn-0006TF-DK; Tue, 12 Mar 2024 04:54:17 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e6a6d486d6so171431b3a.1; 
 Tue, 12 Mar 2024 01:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710233653; x=1710838453; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXeLSgjwugMEyyphuQKJiFmWDEHb7hvXIOWU0Ez5sA8=;
 b=BIs7peD/wno3cOVcOPpR9uscMQm+SoDuxgigCHGN6CXVmCVawAETLVwkBibg+uzv0X
 b/pz16mHHoxznKskfTj3tACZEx1wPVqeuRb5pT7mUYcQuIOcgETmoQf3CBYTYvuuTWlh
 Kzhu60Jq6tTsXYitzXn6KsgMKWjVDzUg9+3WG1HzGFaApVmIWs56K/TV/TBRJOIQtcYX
 irOviVZEnbwcPxVUlqoC3H5r2xoNNvuXvSjiJh619msQK9wcB20IsefZtFeGyL56Idws
 QIZbdB92Bo2pO57zA8Ra7VGeYIXAAyzdRx3Jygz8cTFxTP+iQS7Yi0U6tAh6t5SAdLsR
 di+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710233653; x=1710838453;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MXeLSgjwugMEyyphuQKJiFmWDEHb7hvXIOWU0Ez5sA8=;
 b=qkIYeizuvv8MXj6XXBsnofe7KgqJq3sgJutP64GvkmI5+2rXkqPB+N+kqKLDSN23eI
 cHumOfWJafKm/uA9cG5hSJP7SeN3dbXwb7ErCE4yk0U7IHTq0fFBmpjLceVELhPXA5fJ
 ghya32sgKu18fPvUdZQaS+YUpuJPIDPsF17aG2mIwHnhHuR/R5wTs8WD72sAdcSUiKjt
 HnlgPydRvNPdKdVNcyIaxN9tTW2q6Ye7jY3O2om/oJmhuTzY2ZtxCWR1LBsPPbqyQCy/
 3F2paM7zQDY8n+wD++mFzHHU/ksOOaK8nB2/3dqc6LtUJnE7pn2gtma0cgoVIuBosGvS
 VA0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxImPXNFY5iYHK1ybP67cq3o8JGGvgXRxNqwLJGdjVVbFBSegotR2OUQpOIDVz+pkbufmfQNOg0hjdfb7JLg+/v7A+
X-Gm-Message-State: AOJu0Yzle/Y0JDPz15WwpeGoyYvU34zzBokbiKsVTL2mglKUwNnYSmeD
 cJlKQLkdWfvJwD7dDN+7vlNe2nMPlQVEcbvqu3ZdgQdQ+eExH9tN
X-Google-Smtp-Source: AGHT+IHfoDYoVF7WoxGfUN14YrBWypYaenxdPohw0bl/3u+RV2d63GbT3gr6R1EKxs7zLEOtWKUzxg==
X-Received: by 2002:a17:902:ec83:b0:1dc:7976:b52b with SMTP id
 x3-20020a170902ec8300b001dc7976b52bmr13954545plg.10.1710233653407; 
 Tue, 12 Mar 2024 01:54:13 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 y22-20020a17090264d600b001dcf96e2ab5sm6325389pli.11.2024.03.12.01.54.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 01:54:13 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 18:54:07 +1000
Message-Id: <CZRN8BK2A5HZ.2BLTSYG9MLSEP@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "David Gibson" <david@gibson.dropbear.id.au>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>
Subject: Re: [PATCH 08/13] ppc/pnv: Set POWER9, POWER10 ibm,pa-features bits
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-9-npiggin@gmail.com>
 <1f4b97ec-2cf0-4619-a3d1-6aae6e609ec3@kaod.org>
In-Reply-To: <1f4b97ec-2cf0-4619-a3d1-6aae6e609ec3@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Mar 12, 2024 at 6:06 PM AEST, C=C3=A9dric Le Goater wrote:
> On 3/11/24 19:51, Nicholas Piggin wrote:
> > Copy the pa-features arrays from spapr, adjusting slightly as
> > described in comments.
> >=20
> > Cc: "C=C3=A9dric Le Goater" <clg@kaod.org>
> > Cc: "Fr=C3=A9d=C3=A9ric Barrat" <fbarrat@linux.ibm.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   hw/ppc/pnv.c   | 67 ++++++++++++++++++++++++++++++++++++++++++++++++-=
-
> >   hw/ppc/spapr.c |  1 +
> >   2 files changed, 66 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 52d964f77a..3e30c08420 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -332,6 +332,35 @@ static void pnv_chip_power8_dt_populate(PnvChip *c=
hip, void *fdt)
> >       }
> >   }
> >  =20
> > +/*
> > + * Same as spapr pa_features_300 except pnv always enables CI largepag=
es bit.
> > + */
> > +static const uint8_t pa_features_300[] =3D { 66, 0,
> > +    /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: CILRG|fri[nzpm]|DABRX|SPRG3|SLB0=
|PP110 */
> > +    /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
> > +    0xf6, 0x3f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
> > +    /* 6: DS207 */
> > +    0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
> > +    /* 16: Vector */
> > +    0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
> > +    /* 18: Vec. Scalar, 20: Vec. XOR, 22: HTM */
> > +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 18 - 23 */
> > +    /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
> > +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
> > +    /* 32: LE atomic, 34: EBB + ext EBB */
> > +    0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
> > +    /* 40: Radix MMU */
> > +    0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
> > +    /* 42: PM, 44: PC RA, 46: SC vec'd */
> > +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
> > +    /* 48: SIMD, 50: QP BFP, 52: String */
> > +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
> > +    /* 54: DecFP, 56: DecI, 58: SHA */
> > +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
> > +    /* 60: NM atomic, 62: RNG */
> > +    0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
> > +};
> > +
> >   static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
> >   {
> >       static const char compat[] =3D "ibm,power9-xscom\0ibm,xscom";
> > @@ -349,7 +378,7 @@ static void pnv_chip_power9_dt_populate(PnvChip *ch=
ip, void *fdt)
> >           offset =3D pnv_dt_core(chip, pnv_core, fdt);
> >  =20
> >           _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
> > -                           pa_features_207, sizeof(pa_features_207))))=
;
> > +                           pa_features_300, sizeof(pa_features_300))))=
;
> >       }
> >  =20
> >       if (chip->ram_size) {
> > @@ -359,6 +388,40 @@ static void pnv_chip_power9_dt_populate(PnvChip *c=
hip, void *fdt)
> >       pnv_dt_lpc(chip, fdt, 0, PNV9_LPCM_BASE(chip), PNV9_LPCM_SIZE);
> >   }
> >  =20
> > +/*
> > + * Same as spapr pa_features_31 except pnv always enables CI largepage=
s bit,
> > + * always disables copy/paste.
> > + */
> > +static const uint8_t pa_features_31[] =3D { 74, 0,
> > +    /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: CILRG|fri[nzpm]|DABRX|SPRG3|SLB0=
|PP110 */
> > +    /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
> > +    0xf6, 0x3f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
> > +    /* 6: DS207 */
> > +    0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
> > +    /* 16: Vector */
> > +    0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
> > +    /* 18: Vec. Scalar, 20: Vec. XOR */
> > +    0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
> > +    /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
> > +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
> > +    /* 32: LE atomic, 34: EBB + ext EBB */
> > +    0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
> > +    /* 40: Radix MMU */
> > +    0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
> > +    /* 42: PM, 44: PC RA, 46: SC vec'd */
> > +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
> > +    /* 48: SIMD, 50: QP BFP, 52: String */
> > +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
> > +    /* 54: DecFP, 56: DecI, 58: SHA */
> > +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
> > +    /* 60: NM atomic, 62: RNG */
> > +    0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
> > +    /* 68: DEXCR[SBHE|IBRTPDUS|SRAPD|NPHIE|PHIE] */
> > +    0x00, 0x00, 0xce, 0x00, 0x00, 0x00, /* 66 - 71 */
> > +    /* 72: [P]HASHCHK */
> > +    0x80, 0x00,                         /* 72 - 73 */
> > +};
> > +
> >   static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
> >   {
> >       static const char compat[] =3D "ibm,power10-xscom\0ibm,xscom";
> > @@ -376,7 +439,7 @@ static void pnv_chip_power10_dt_populate(PnvChip *c=
hip, void *fdt)
> >           offset =3D pnv_dt_core(chip, pnv_core, fdt);
> >  =20
> >           _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
> > -                           pa_features_207, sizeof(pa_features_207))))=
;
> > +                           pa_features_31, sizeof(pa_features_31))));
> >       }
> >  =20
> >       if (chip->ram_size) {
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 128bfe11a8..b53c13e037 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -233,6 +233,7 @@ static void spapr_dt_pa_features(SpaprMachineState =
*spapr,
> >                                    PowerPCCPU *cpu,
> >                                    void *fdt, int offset)
> >   {
> > +    /* These should be kept in sync with pnv */
>
> yes. In that case, the array definition should be moved under target/ppc/=
.
> May be under PowerPCCPUClass ?

Yeah PowerPCCPUClass might be a good idea, although I'm not quite
decided whether it's best to just store the arrays there, or make a
list of features in another format and have a builder function to
turn that into the dt array. There's also a few differences between
spapr and pnv that I haven't worked out a nice way to handle yet.
I have a pi-features property to add too which is similar.

So yes this is a bit ugly but we're already duplicating and open coding
arrays so I'd like to just get this in to fix the missing P10 bits,
and refactor it afterwards.

Thanks,
Nick

