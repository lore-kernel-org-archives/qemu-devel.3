Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4826C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 04:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW6yd-0004zV-Jl; Tue, 23 Jul 2024 00:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sW6yc-0004yh-EJ; Tue, 23 Jul 2024 00:18:14 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sW6ya-0001Fh-Q6; Tue, 23 Jul 2024 00:18:14 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fb3b7d0d3aso1277335ad.2; 
 Mon, 22 Jul 2024 21:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721708290; x=1722313090; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q2r874GZdG5CSKYB/kH4+zQWXo2tWB+qrhCYJ2xmr6Q=;
 b=MH8jFTZmLRLmOfsX1/2ISAjP0DrBNCuNV7hRlBuiFADb/9ILFMzbz7VqOP/qLa96Cp
 qVI1w5x+ycDTjvpVuyAwXD8ZgxtCC2xosRkfZbpFIlMNhgU+qnMvORE0/75oM06KNara
 R/rSyAtIK01/mtUbeRDo9eFEUxhxQsYDh+cQjV9PVxKROcN8Jeh/RpHEioq5M34BOsCx
 sXYHItXGywcS8nDZLelMRr8sPRvr9X7rqkhPb0YTRCeGc0o63/eYs3sb7K4cck3p3Klc
 X7/WSkQNwezQtthFNYwZuu2D3ANbAVylQ7JLik2MYQq9asiDdxXKZ9deqQqsik02gQBx
 mysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721708290; x=1722313090;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q2r874GZdG5CSKYB/kH4+zQWXo2tWB+qrhCYJ2xmr6Q=;
 b=gxLFvkpZ4g8troDBuhb+WiufCEWmacDwgjEZ7XoudmWKqu9MkeDOUjkq/Vr1blmdc1
 4yukxgA7nT3hSsmdxJcT0J+hA0n/cSn16TmYvt2tBORR+qp91kED+glsscQqWwwecDpM
 s19gIOAHFXmRewhf/Vg1xKIwKrPrfS1p5XA/VZDVCddfFQSx3uJMKEKud8peKdwznIN9
 GhDziF5pXTY6D/0qIaYdPz32daWJ+SNKYJfC11EU9IDja83B6htb3D3qsG3HgvgAtoX8
 AEL6rsx/ulE7n8MYRkExYyCZY55pHdDslILcUKBmk6j2DDXEKeed6unoBgTxeKU4vtfD
 4+TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO5BWkepgMUgfPCQH+oX8pYjfktZkPELWayuITw+s2DWr3fJMudrwZuUKZ82sdKqOC37JTtGI10hPueOxYQFGbtYkj
X-Gm-Message-State: AOJu0YxlYW65HvZjD3IuvgvLbK6IHCk0e1XnIiBWCZ6rbjM0VIgZxXkr
 VLCycBWUfgp1ALBxe5C82cDLN2TKapjhNzskwfZn17mmwuIzbENh
X-Google-Smtp-Source: AGHT+IEClPhiR9BOC05HBH0IHYoI4pLQRADil+ZORrK7vh78PGS3y8/iJ2uNDe+jsn6gCWOg2/YLnQ==
X-Received: by 2002:a17:903:1cc:b0:1fd:9c2d:2f20 with SMTP id
 d9443c01a7336-1fd9c2d3246mr48794155ad.46.1721708290054; 
 Mon, 22 Jul 2024 21:18:10 -0700 (PDT)
Received: from localhost ([203.220.44.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f431b2dsm63684655ad.185.2024.07.22.21.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 21:18:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jul 2024 14:18:02 +1000
Message-Id: <D2WMNDZEGNYY.2OPUMBFIEPTLI@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "David Gibson"
 <david@gibson.dropbear.id.au>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Laurent Vivier" <lvivier@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Mahesh J Salgaonkar"
 <mahesh@linux.ibm.com>, "Madhavan Srinivasan" <maddy@linux.ibm.com>
Subject: Re: [PATCH] ppc/pnv: Update Power10's cfam id to use Power10 DD2
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aditya Gupta" <adityag@linux.ibm.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
X-Mailer: aerc 0.18.0
References: <20240502062701.1379833-1-adityag@linux.ibm.com>
 <a1e529e9-32b2-438a-b50d-10117296d4e1@kaod.org>
 <00d202a7-03dd-4cb0-8e02-3c49a025e284@linux.ibm.com>
In-Reply-To: <00d202a7-03dd-4cb0-8e02-3c49a025e284@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon Jul 22, 2024 at 7:17 PM AEST, Aditya Gupta wrote:
> Hello,
>
> Any comments on this change ?
>
> Though this isn't urgent and won't change behaviour much, mainly other=20
> than skiboot recognising the chip as P10 DD2.

Hey Aditya,

Yeah I missed this in my last PR but I have it in my tree.

Thanks,
Nick

>
>
> Thanks
>
> - Aditya Gupta
>
>
> On 02/05/24 13:51, C=C3=A9dric Le Goater wrote:
>
> > On 5/2/24 08:27, Aditya Gupta wrote:
> >> Power10 DD1.0 was dropped in:
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0 commit 8f054d9ee825 ("ppc: Drop support for P=
OWER9 and POWER10=20
> >> DD1 chips")
> >>
> >> Use the newer Power10 DD2 chips cfam id.
> >>
> >> Cc: C=C3=A9dric Le Goater <clg@kaod.org>
> >> Cc: David Gibson <david@gibson.dropbear.id.au>
> >> Cc: Fr=C3=A9d=C3=A9ric Barrat <fbarrat@linux.ibm.com>
> >> Cc: Laurent Vivier <lvivier@redhat.com>
> >> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> >> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> >> Cc: Nicholas Piggin <npiggin@gmail.com>
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Cc: Thomas Huth <thuth@redhat.com>
> >> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> >
> >
> > Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> >
> > Thanks,
> >
> > C.
> >
> >
> >> ---
> >> =C2=A0 hw/ppc/pnv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 2 +-
> >> =C2=A0 tests/qtest/pnv-xscom.h | 2 +-
> >> =C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> >> index 6e3a5ccdec76..06a4e4d13948 100644
> >> --- a/hw/ppc/pnv.c
> >> +++ b/hw/ppc/pnv.c
> >> @@ -2090,7 +2090,7 @@ static void=20
> >> pnv_chip_power10_class_init(ObjectClass *klass, void *data)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PnvChipClass *k =3D PNV_CHIP_CLASS(klas=
s);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static const int i2c_ports_per_engine[P=
NV10_CHIP_MAX_I2C] =3D=20
> >> {14, 14, 2, 16};
> >> =C2=A0 -=C2=A0=C2=A0=C2=A0 k->chip_cfam_id =3D 0x120da04900008000ull; =
/* P10 DD1.0 (with=20
> >> NX) */
> >> +=C2=A0=C2=A0=C2=A0 k->chip_cfam_id =3D 0x220da04980000000ull; /* P10 =
DD2.0 (with NX) */
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->cores_mask =3D POWER10_CORE_MASK;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->chip_pir =3D pnv_chip_pir_p10;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->intc_create =3D pnv_chip_power10_int=
c_create;
> >> diff --git a/tests/qtest/pnv-xscom.h b/tests/qtest/pnv-xscom.h
> >> index 6f62941744a6..5aa1701ea768 100644
> >> --- a/tests/qtest/pnv-xscom.h
> >> +++ b/tests/qtest/pnv-xscom.h
> >> @@ -56,7 +56,7 @@ static const PnvChip pnv_chips[] =3D {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .chip_type=C2=
=A0 =3D PNV_CHIP_POWER10,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cpu_model=C2=
=A0 =3D "POWER10",
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .xscom_base =3D=
 0x000603fc00000000ull,
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cfam_id=C2=A0=C2=A0=C2=A0=
 =3D 0x120da04900008000ull,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cfam_id=C2=A0=C2=A0=C2=A0=
 =3D 0x220da04980000000ull,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .first_core =3D=
 0x0,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_i2c=C2=A0=
=C2=A0=C2=A0 =3D 4,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> >


