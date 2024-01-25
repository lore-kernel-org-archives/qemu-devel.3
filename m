Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D076AC47DDF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 03:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSqFg-0006y6-Ee; Wed, 24 Jan 2024 22:18:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1rSqFd-0006x9-0q; Wed, 24 Jan 2024 22:18:01 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1rSqFY-00053m-SA; Wed, 24 Jan 2024 22:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202312; t=1706152667;
 bh=4VoQYP24BD5r1tFesV0JCVRlHGZYY+f8XwkrH8e5MOI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P5t/dyrOvz6HF87hv8vAdqt/dDmPziFoLA+tEIM9U/lMcAxrEQe5xybU9JGQMQMvB
 99UPl7OoRrH1tyv/Z5D7WkJOYZESPfR26Mun6GD8JskjJvmmDUY5qtxWHeS8IHXEzu
 Hzfr5WcmSNxTDoy8WSXJnCEana3sB/hbxV809tINiocFtNMKAx2Up45C2eBFcFvJAG
 9m9mF4KToho/9+Ijp0bcL9vuPmW070ap5NYSpf4uew2hO3nR1FVVaXAa5d7MtGrCAk
 trvOCDneVdGLMz7zQtXfa5iycMdBxToyOITBNsAlMNWJ1c+NZO97pzsNMHLJAyxafD
 iEyMB9qLB59XQ==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4TL5cC0C5Xz4x5q; Thu, 25 Jan 2024 14:17:47 +1100 (AEDT)
Date: Thu, 25 Jan 2024 14:11:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 =?iso-8859-1?Q?Fr=E9d=E9ric?= Barrat <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/8] ppc/spapr|pnv: Remove SAO from pa-features when
 running MTTCG
Message-ID: <ZbHRaWhUbpsHa4I-@zatzit>
References: <20240118140942.164319-1-npiggin@gmail.com>
 <20240118140942.164319-3-npiggin@gmail.com>
 <ZanA-usH_Ec0uqie@zatzit> <CYLPOZ0VDE7U.40VIK25R65PQ@wheely>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jxp+fxGu16+O7y0Q"
Content-Disposition: inline
In-Reply-To: <CYLPOZ0VDE7U.40VIK25R65PQ@wheely>
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--jxp+fxGu16+O7y0Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 11:57:56AM +1000, Nicholas Piggin wrote:
> On Fri Jan 19, 2024 at 10:23 AM AEST, David Gibson wrote:
> > On Fri, Jan 19, 2024 at 12:09:36AM +1000, Nicholas Piggin wrote:
> > > SAO is a page table attribute that strengthens the memory ordering of
> > > accesses. QEMU with MTTCG does not implement this, so clear it in
> > > ibm,pa-features. There is a complication with spapr migration that is
> > > addressed with comments, it is not a new problem here.
> > >=20
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > ---
> > >  hw/ppc/pnv.c   |  5 +++++
> > >  hw/ppc/spapr.c | 15 +++++++++++++++
> > >  2 files changed, 20 insertions(+)
> > >=20
> > > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > > index b949398689..4969fbdb05 100644
> > > --- a/hw/ppc/pnv.c
> > > +++ b/hw/ppc/pnv.c
> > > @@ -158,6 +158,11 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *=
pc, void *fdt)
> > >      char *nodename;
> > >      int cpus_offset =3D get_cpus_node(fdt);
> > > =20
> > > +    if (qemu_tcg_mttcg_enabled()) {
> > > +        /* SSO (SAO) ordering is not supported under MTTCG. */
> > > +        pa_features[4 + 2] &=3D ~0x80;
> > > +    }
> > > +
> > >      nodename =3D g_strdup_printf("%s@%x", dc->fw_name, pc->pir);
> > >      offset =3D fdt_add_subnode(fdt, cpus_offset, nodename);
> > >      _FDT(offset);
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 021b1a00e1..1c79d5670d 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -284,6 +284,21 @@ static void spapr_dt_pa_features(SpaprMachineSta=
te *spapr,
> > >          return;
> > >      }
> > > =20
> > > +    if (qemu_tcg_mttcg_enabled()) {
> > > +        /*
> > > +         * SSO (SAO) ordering is not supported under MTTCG, so disab=
le it.
> > > +         * There is no cap for this, so there is a migration bug her=
e.
> > > +         * However don't disable it entirely, to allow it to be used=
 under
> > > +         * KVM. This is a minor concern because:
> > > +         * - SAO is an obscure an rarely (if ever) used feature.
> > > +         * - SAO is removed from POWER10 / v3.1, so there is already=
 a
> > > +         *   migration problem today.
> > > +         * - Linux does not test this pa-features bit today anyway, =
so it's
> > > +         *   academic.
> > > +         */
> > > +        pa_features[4 + 2] &=3D ~0x80;
> >
> > Oof.. I see the reasoning but modifying guest visible parameters based
> > on host capabilities without a cap really worries me nonetheless.
>=20
> Yeah :( It's not a new problem, but changing it based on host
> does make it look uglier I guess.

It's not really about whether it looks uglier, it's the fact that any
dependency of guest visible aspects of the VM on host properties is a
potential landmine for migration.

The qemu migration model is - pretty fundamentally - that the VM
should look and behave, from the point of view of the guest, the same
before and after migration.  If the behaviour of the VM changes based
on host properties it breaks that assumption, and it does so in a way
that the user can't control or even easily predict.  Tools such as
libvirt, or even qemu itself, can't verify that the migration is valid
if there are effectively invisible parameters to the VM configuration
that come from the host instead of the command line.

> Other option could be to just disable it always. I don't mind
> but someone did mention experimenting with it when I asked
> about removing support from Linux. They could still test with
> bare metal, and if ever started actually being used then we
> could add a cap for it.

I think that's a better idea.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jxp+fxGu16+O7y0Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmWx0WgACgkQzQJF27ox
2Ge/uQ/9F1BCffihfan0nhy+4YY63xUmWoHYww59yF3jX1uJtUtwZuNPo/5JKY1s
9LufgP7qtWp8qL/LBTmO/KybbCqdAQXHyqPOKBk88EatxyHGRTQqDnBXqpSP5RuU
Io3dFbtuJ3NCBKqlRBqYPjEGny8SE3fxEk06TB0Bo2O3vPvegq9I9rZFI65FGkvT
4xsRVcVB7hTTmKBs+iRKtiJ+kwkbImBv6hwdZ15dMhF/UCjDt06+x/qR0Djchsmo
EteE9mjRCLYJn/Jhgat5xlpez8wqTIsUH2UUXSQ4B/w+qerowiwfAMGMINmA/YZ8
T1oH9ok3JFuO3A5yaVDIcUn9FUU/PqK3wnyxo4vQZxkpQL05Av8vl2AYtZnpTjqJ
qhAVeTyKzZ/iKCZTsWiSFK+5c19YlewOeua5t+VFbKBR1Bw97LqLAO7trhdvqanp
oWAimoMmblDehJI86q/yt9Vqx7+MPayHSJPTq9ousUmHAm+ilhw89IPtgQA/el59
ErxemAJLbW1mbNFNw0Icj2kRjCbNApIhp/KwUecAc63Q4z6jcyBjRiAYhYpwiqCj
XH0txlk5kCq4c+op2dta/kP5LFPCT76PsEbI+UEl94xkAdlVeheTsyoTmonbczSn
1tzfJx715e4mm12BxSVaFPmMR2fzl7TdnkCx/2TiX4Yc1iCDJqM=
=c4/G
-----END PGP SIGNATURE-----

--jxp+fxGu16+O7y0Q--

