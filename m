Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1073C3DA45
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 06:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTFGU-0008Mv-8O; Mon, 15 Jul 2024 02:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTFGS-0008EQ-4z; Mon, 15 Jul 2024 02:32:48 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTFGG-0000Q9-CJ; Mon, 15 Jul 2024 02:32:47 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70af0684c2bso2493167b3a.0; 
 Sun, 14 Jul 2024 23:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721025154; x=1721629954; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pFZjRGkCm5SsUrdzwIoWDcRPud/OO11RnIHGmkrIl3A=;
 b=ZrnqRHbSqqVq5O7XIKP5CUR90dire3iSGDkn3wOO53hRmOn21UbIkn8RWj9t0EQrWs
 WnZ1DON/ZjgCl8x20fRWGnhopMUhxrwfEthQYLy40XEbnGYDnXvDOVDQFWC2HXRp6Xhe
 xCAqB7eaS6Nxf+X1PvYePgmvggjrDtRkEWTzbPRTn8eeZMJ+Atc5J86u6MOuf3K5IS98
 OBFndTZkAhzsCHg3515vFVfnWBe94eDskrl2Y3yHe67yAPvflgnr+IXgJdmTska1XCTw
 vxw0VclNua65ZczIwgx2mNsnZcY5y8N4x0GvZ9ZnBa1qRnmOFxkaPuonH67arVmE5XjG
 SG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721025154; x=1721629954;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pFZjRGkCm5SsUrdzwIoWDcRPud/OO11RnIHGmkrIl3A=;
 b=awQlSRJ2vl4n25e7Ut6LUk1iw3fHpVOOb3XS9ehqz67C0UQMPGilsbHwggCeAYsvgJ
 Z0F3rYzSxkwqJ45T6k2CuiC7tB3e91uAxjbUggAyFFI9jwsz+UaHaQaadCFb2byrOy5m
 Fp0aymtOWgZ5AnltER18tC2p/BJFrHIO27i0ECEcz7RpcYjqOcAuhlOg1MSLbAPCdJ0T
 wM8cnozvsT1FaAhAtyi2z1iNTmPXVmYoLk42Yiss16bLa23raiF/x37rV22nCNwy8x5w
 m+E0qECwLaX56hhxUsnXYEowjLHll8hWS+DQIuejDsHISi8DP7qm8v+NJ9D8cUzNtVpv
 kHeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa3jHUtRQUNOWbyqEZn3oJhRoR34YNgwxrj9xgos3Us2XMOnp8njE8Lzh2YFGaRmR5YVeJQFDFVRp+IJTMwY9xp8YUZaZ+C/VdAWkGWdsAHSfcKa06Ec5vuog=
X-Gm-Message-State: AOJu0Yw8NBA0JW+0kkBYZPuRjRJ8+uPPVc7e2iJG8t10JCr3kDA1lLAQ
 8VjhremaKR/bVzQGF/XM1NnO6COIHdnnn6qaH3Asij+hDKJg5WIK
X-Google-Smtp-Source: AGHT+IEbqPoebk4EsaJvdyEZG5STkddiXzSMcX94paB0OmKvb8jOeW5Ovf2oA1TeaB7X8iWgAgyU5g==
X-Received: by 2002:a05:6a00:1d0e:b0:706:6cb2:ed17 with SMTP id
 d2e1a72fcca58-70b435220f9mr16929775b3a.2.1721025153620; 
 Sun, 14 Jul 2024 23:32:33 -0700 (PDT)
Received: from localhost ([1.146.120.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca69f0sm3584477b3a.150.2024.07.14.23.32.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 23:32:33 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jul 2024 16:32:28 +1000
Message-Id: <D2PWHYC8LOFQ.11K5J1O09Y2XP@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
Cc: =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 15/19] ppc/pnv: Add big-core machine property
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.17.0
References: <20240712120247.477133-1-npiggin@gmail.com>
 <20240712120247.477133-16-npiggin@gmail.com>
 <fb9fdbac-7b63-4832-915c-0af83c39cdf5@kaod.org>
In-Reply-To: <fb9fdbac-7b63-4832-915c-0af83c39cdf5@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat Jul 13, 2024 at 5:24 PM AEST, C=C3=A9dric Le Goater wrote:
> On 7/12/24 14:02, Nicholas Piggin wrote:
> > Big-core implementation is complete, so expose it as a machine
> > property that may be set with big-core=3Don option on powernv9 and
> > powernv10 machines.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   hw/ppc/pnv.c      | 62 +++++++++++++++++++++++++++++++++++-----------=
-
> >   hw/ppc/pnv_core.c |  2 +-
> >   2 files changed, 47 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 24f7c007ce..e405d416ff 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -2338,6 +2338,7 @@ static void pnv_chip_core_realize(PnvChip *chip, =
Error **errp)
> >                                    &error_abort);
> >  =20
> >           pnv_core->tod_state.big_core_quirk =3D pmc->quirk_tb_big_core=
;
> > +        pnv_core->big_core =3D chip->big_core;
>
>
> This can be dropped with the previous change.

Sounds good, hopefully I can get it to work :P

>
> >           qdev_realize(DEVICE(pnv_core), NULL, &error_fatal);
> >  =20
> > @@ -2578,6 +2579,34 @@ static int pnv10_xive_match_nvt(XiveFabric *xfb,=
 uint8_t format,
> >       return total_count;
> >   }
> >  =20
> > +static bool pnv_machine_get_big_core(Object *obj, Error **errp)
> > +{
> > +    PnvMachineState *pnv =3D PNV_MACHINE(obj);
> > +    return pnv->big_core;
> > +}
> > +
> > +static void pnv_machine_set_big_core(Object *obj, bool value, Error **=
errp)
> > +{
> > +    PnvMachineState *pnv =3D PNV_MACHINE(obj);
> > +    pnv->big_core =3D value;
> > +}
> > +
> > +static bool pnv_machine_get_hb(Object *obj, Error **errp)
> > +{
> > +    PnvMachineState *pnv =3D PNV_MACHINE(obj);
> > +
> > +    return !!pnv->fw_load_addr;
> > +}
> > +
> > +static void pnv_machine_set_hb(Object *obj, bool value, Error **errp)
> > +{
> > +    PnvMachineState *pnv =3D PNV_MACHINE(obj);
> > +
> > +    if (value) {
> > +        pnv->fw_load_addr =3D 0x8000000;
> > +    }
> > +}
> > +
> >   static void pnv_machine_power8_class_init(ObjectClass *oc, void *data=
)
> >   {
> >       MachineClass *mc =3D MACHINE_CLASS(oc);
> > @@ -2629,6 +2658,12 @@ static void pnv_machine_power9_class_init(Object=
Class *oc, void *data)
> >       pmc->dt_power_mgt =3D pnv_dt_power_mgt;
> >  =20
> >       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
> > +
> > +    object_class_property_add_bool(oc, "big-core",
> > +                                   pnv_machine_get_big_core,
> > +                                   pnv_machine_set_big_core);
> > +    object_class_property_set_description(oc, "big-core",
> > +                              "Use big-core (aka fused-core) mode");
> >   }
> >  =20
> >   static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *=
data)
> > @@ -2665,6 +2700,17 @@ static void pnv_machine_power10_class_init(Objec=
tClass *oc, void *data)
> >  =20
> >       pnv_machine_p10_common_class_init(oc, data);
> >       mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER10";
> > +
> > +    /*
> > +     * This is the parent of POWER10 Rainier class, so properies go he=
re
> > +     * rather than common init (which would add them to both parent an=
d
> > +     * child which is invalid).
> > +     */
> > +    object_class_property_add_bool(oc, "big-core",
> > +                                   pnv_machine_get_big_core,
> > +                                   pnv_machine_set_big_core);
> > +    object_class_property_set_description(oc, "big-core",
> > +                              "Use big-core (aka fused-core) mode");
> >   }
> >  =20
> >   static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void =
*data)
> > @@ -2677,22 +2723,6 @@ static void pnv_machine_p10_rainier_class_init(O=
bjectClass *oc, void *data)
> >       pmc->i2c_init =3D pnv_rainier_i2c_init;
> >   }
> >  =20
> > -static bool pnv_machine_get_hb(Object *obj, Error **errp)
> > -{
> > -    PnvMachineState *pnv =3D PNV_MACHINE(obj);
> > -
> > -    return !!pnv->fw_load_addr;
> > -}
> > -
> > -static void pnv_machine_set_hb(Object *obj, bool value, Error **errp)
> > -{
> > -    PnvMachineState *pnv =3D PNV_MACHINE(obj);
> > -
> > -    if (value) {
> > -        pnv->fw_load_addr =3D 0x8000000;
> > -    }
> > -}
> > -
> >   static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
> >   {
> >       CPUPPCState *env =3D cpu_env(cs);
> > diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> > index a96ec4e2b9..238a4cd4ab 100644
> > --- a/hw/ppc/pnv_core.c
> > +++ b/hw/ppc/pnv_core.c
> > @@ -296,7 +296,7 @@ static void pnv_core_realize(DeviceState *dev, Erro=
r **errp)
> >           obj =3D object_new(typename);
> >           cpu =3D POWERPC_CPU(obj);
> >  =20
> > -        pc->threads[i] =3D POWERPC_CPU(obj);
> > +        pc->threads[i] =3D cpu;
> >           if (cc->nr_threads > 1) {
> >               cpu->env.has_smt_siblings =3D true;
> >           }
>
> Superfluous change ?

Yup, snuck in. Good catch.

Thanks,
Nick

