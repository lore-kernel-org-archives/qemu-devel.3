Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E074C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 10:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjzTq-0002sv-Vv; Tue, 12 Mar 2024 06:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjzTH-0002do-0v; Tue, 12 Mar 2024 06:34:59 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjzTE-0006Tk-Vx; Tue, 12 Mar 2024 06:34:58 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dda8e5fa8dso12072305ad.2; 
 Tue, 12 Mar 2024 03:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710239695; x=1710844495; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zDrSxw2a1dZXNh2t4XrQi8qVcPP8vMSjMjJ8Zj8JwNI=;
 b=NfZDe8ist+RXGgSn5nM2X9jkZodeqvecE5maYjAW7Msr1uhrRkV+7bFFpL4lq1IdSw
 OE6NMBR3/Bh3fDm/YEyozWfy+ozi29iXBEXZwRQgpaxrk3xs8RVjtJ62r7a+8z5/wkyW
 vTBcFR5eXIt0VghtaY2JD+YJKpYlbE763RbXirUmWOeogo2XLhpSGa7a6cAGqnUYNFmB
 h/h12G3jDlxfmwNgnLaoCB9M9+XpP2PALJonNMt7MilthPGZVxrVGnqjAfFRoGmIVzeN
 HCKaiUWrExKe0rhb0R+YuRFXbHqJfd9O2SL4B3y6G2VJ0Hsv8BWiuSrMeJPUL6fv0yqb
 iPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710239695; x=1710844495;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zDrSxw2a1dZXNh2t4XrQi8qVcPP8vMSjMjJ8Zj8JwNI=;
 b=tpA20WPczZ5etg7ITlIfBc4Z/cgfOI8sP+o1GwHFtPanwzQjTVUChPnkirIh1RoIJT
 vB1deChWb2LbNQFP7sp+kvI4WmlyhG3hTiCNIhUuwqIyDBT1I3gxtEEA/fVtXllrGfJm
 zC/1MPDd4yRbsEM85OXIoGWsdezUSls0ABScubu/xgflvZK3Cfd/KdRR4qy4l19spdAg
 g8MHB97jilOO0rngnPoMK9V5hToxmEaMzPwpzSLu7u0kGF1O5fYmsXz7qH0XOKbuV7K9
 hPzQcf0KI/SNDwo4bTWUXNCjyHOk7NEDvGT3yuF+uPbz7jcHds5ss+doicj4wQ63G4cj
 Nz9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOnKaVatlaJJxC0rn4Zl4BQjkB/3xfxVVgeK1OahaILrYQrXNKiZlgfZE8IgE86gOioUSUMzgsEXeaohKWVeNswJ2t
X-Gm-Message-State: AOJu0YyrC1jmQro3a7PvwdhFAfr3TYdA/QKN/EAPtKxhwP3g8X82E85H
 asXlkFQ7/lLMexuNwKnRGHBbLVNj8EcigZ7yzNZ8wIaUJsQ5GvQN
X-Google-Smtp-Source: AGHT+IGl+z2dSUgStFnnLuYp1yN6ZuyAB1TvvM0LOUJ2+7zkmWgE5mfmHf83z5CE0l79RJcaK6dcgw==
X-Received: by 2002:a17:902:bb92:b0:1dc:3261:ab7 with SMTP id
 m18-20020a170902bb9200b001dc32610ab7mr8039703pls.49.1710239695206; 
 Tue, 12 Mar 2024 03:34:55 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 ix14-20020a170902f80e00b001dca3a65200sm6376156plb.228.2024.03.12.03.34.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 03:34:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 20:34:50 +1000
Message-Id: <CZRPDFEWNO6X.28MWRY8A1IB2H@wheely>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "David Gibson" <david@gibson.dropbear.id.au>,
 "Benjamin Gray" <bgray@linux.ibm.com>
Subject: Re: [PATCH 06/13] ppc/spapr: Add pa-features for POWER10 machines
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-7-npiggin@gmail.com>
 <297e96cb-568f-4811-b563-e999ee079b5f@linux.ibm.com>
In-Reply-To: <297e96cb-568f-4811-b563-e999ee079b5f@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

On Tue Mar 12, 2024 at 7:34 PM AEST, Harsh Prateek Bora wrote:
>
>
> On 3/12/24 00:21, Nicholas Piggin wrote:
> > From: Benjamin Gray <bgray@linux.ibm.com>
> >=20
> > Add POWER10 pa-features entry.
> >=20
> > Notably DEXCR and and [P]HASHST/[P]HASHCHK instruction support is
>
> s/and and/and
>
> > advertised. Each DEXCR aspect is allocated a bit in the device tree,
> > using the 68--71 byte range (inclusive). The functionality of the
> > [P]HASHST/[P]HASHCHK instructions is separately declared in byte 72,
> > bit 0 (BE).
> >=20
> > Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
> > [npiggin: reword title and changelog, adjust a few bits]
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   hw/ppc/spapr.c | 34 ++++++++++++++++++++++++++++++++++
> >   1 file changed, 34 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 247f920f07..128bfe11a8 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -265,6 +265,36 @@ static void spapr_dt_pa_features(SpaprMachineState=
 *spapr,
> >           /* 60: NM atomic, 62: RNG */
> >           0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
> >       };
> > +    /* 3.1 removes SAO, HTM support */
> > +    uint8_t pa_features_31[] =3D { 74, 0,
> > +        /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: fri[nzpm]|DABRX|SPRG3|SLB0|P=
P110 */
> > +        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ=
 */
> > +        0xf6, 0x1f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
> > +        /* 6: DS207 */
> > +        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
> > +        /* 16: Vector */
> > +        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
> > +        /* 18: Vec. Scalar, 20: Vec. XOR */
> > +        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
> > +        /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
> > +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
> > +        /* 32: LE atomic, 34: EBB + ext EBB */
> > +        0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
> > +        /* 40: Radix MMU */
> > +        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
> > +        /* 42: PM, 44: PC RA, 46: SC vec'd */
> > +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
> > +        /* 48: SIMD, 50: QP BFP, 52: String */
> > +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
> > +        /* 54: DecFP, 56: DecI, 58: SHA */
> > +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
> > +        /* 60: NM atomic, 62: RNG */
> > +        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
> > +        /* 68: DEXCR[SBHE|IBRTPDUS|SRAPD|NPHIE|PHIE] */
> > +        0x00, 0x00, 0xce, 0x00, 0x00, 0x00, /* 66 - 71 */
> > +        /* 72: [P]HASHCHK */
>
> Do we want to mention [P]HASHST as well in comment above ?

Sure. I'll do a quick respin.

Thanks,
Nick

>
> > +        0x80, 0x00,                         /* 72 - 73 */
> > +    };
> >       uint8_t *pa_features =3D NULL;
> >       size_t pa_size;
> >  =20
>
> In future, we may want to have helpers returning pointer to the
> pa_features array and corresponding size conditionally based on the
> required ISA support needed, instead of having local arrays bloat this
> routine.
>
> For now, with cosmetic fixes,
>
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>
> > @@ -280,6 +310,10 @@ static void spapr_dt_pa_features(SpaprMachineState=
 *spapr,
> >           pa_features =3D pa_features_300;
> >           pa_size =3D sizeof(pa_features_300);
> >       }
> > +    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0, cpu->compat=
_pvr)) {
> > +        pa_features =3D pa_features_31;
> > +        pa_size =3D sizeof(pa_features_31);
> > +    }
> >       if (!pa_features) {
> >           return;
> >       }


