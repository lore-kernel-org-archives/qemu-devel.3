Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA9BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 01:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1G6b-0007Kh-67; Sun, 28 Apr 2024 21:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1s1G6Y-0007KK-Lo; Sun, 28 Apr 2024 21:46:55 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1s1G6V-0004oR-7X; Sun, 28 Apr 2024 21:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202312; t=1714355201;
 bh=YduI4ygNClkx7D0DQALagO/Lvb8EHC6qiw3IVGr0AWQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=apktbWaQmyY0achxuUx24Hq4KpF2vi9g6AHmu30+zSQMzYabyX+z8f+JMgjdKD+mE
 ODZ5oF6c9zoCWdy6BTE/bV39gkmCWKjUvRGWejPYCOV/27Ji17A1wCyXUIFB7nxgba
 /rxFA36gXVeAv1X8l8EYR5/qOjBpfknxOE+XJtjxratWBh36FoC4gOqjt1aUPOHfGy
 qXTp0e+obF0Zbl3YNLr7YM+j8jes51lVnnosdXvKkIHAIx++4nwcQ2OgDmO9+0INHF
 Zs/e2FdOTYBzaEDoIgSIHXQWui2VK/vsmQQ1aLrZoxY1ikuVS3+1EFVY8mYEo07b/y
 faw1IyCBygcXA==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4VSR5F5k41z4wyp; Mon, 29 Apr 2024 11:46:41 +1000 (AEST)
Date: Mon, 29 Apr 2024 11:44:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?iso-8859-1?Q?Fr=E9d=E9ric?= Barrat <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 09/10] ppc: Make Power11 as default cpu type for
 'pseries' and 'powernv'
Message-ID: <Zi77fx1WW0KJRb5o@zatzit>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-10-adityag@linux.ibm.com>
 <3d64c7e6-6128-4723-b7c5-11967b0a7457@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ktqjxqf9bcS4kWpb"
Content-Disposition: inline
In-Reply-To: <3d64c7e6-6128-4723-b7c5-11967b0a7457@kaod.org>
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--ktqjxqf9bcS4kWpb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 04:32:18PM +0200, C=E9dric le Goater wrote:
> On 4/26/24 13:00, Aditya Gupta wrote:
> > Make Power11 as default cpu type for 'pseries' and 'powernv' machine ty=
pe,
> > with Power11 being the newest supported Power processor in QEMU.
>=20
> This is too early. We should merge Power11 support first, possibly in 9.1,
> and then change default in a future release, 9.2, 10.0

Additionally, changes to defaults in pseries must be versioned, so
that the behaviour of existing machine types won't change.

>=20
> Thanks,
>=20
> C.
>=20
>=20
>=20
> >=20
> > Cc: C=E9dric Le Goater <clg@kaod.org>
> > Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
> > Cc: David Gibson <david@gibson.dropbear.id.au>
> > Cc: Fr=E9d=E9ric Barrat <fbarrat@linux.ibm.com>
> > Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> > Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> > Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> > ---
> >   hw/ppc/pnv.c   | 4 ++--
> >   hw/ppc/spapr.c | 2 +-
> >   2 files changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 06e272f3bdd3..0c5a6bc424af 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -2531,8 +2531,6 @@ static void pnv_machine_p10_common_class_init(Obj=
ectClass *oc, void *data)
> >       mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power10_v2.0");
> >       compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_c=
ompat));
> > -    mc->alias =3D "powernv";
> > -
> >       pmc->compat =3D compat;
> >       pmc->compat_size =3D sizeof(compat);
> >       pmc->dt_power_mgt =3D pnv_dt_power_mgt;
> > @@ -2569,6 +2567,8 @@ static void pnv_machine_power11_class_init(Object=
Class *oc, void *data)
> >       /* do power10_class_init as p11 core is same as p10 */
> >       pnv_machine_p10_common_class_init(oc, data);
> > +    mc->alias =3D "powernv";
> > +
> >       mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER11";
> >       mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power11");
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index d2d1e310a3be..1c3e2da8e9e4 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -4698,7 +4698,7 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
> >       smc->dr_lmb_enabled =3D true;
> >       smc->update_dt_enabled =3D true;
> > -    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power10_v2.0");
> > +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power11");
> >       mc->has_hotpluggable_cpus =3D true;
> >       mc->nvdimm_supported =3D true;
> >       smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_ENABLED;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ktqjxqf9bcS4kWpb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmYu+34ACgkQzQJF27ox
2GcyAQ/7BD08t5JlODjFeiIXpFVGbBEPQ1Qpq5Bf+/MNJCXk5xRg+3J78N0hDjWJ
nCF6Ld9NCLxIuZaERo5i8fjTs9mwBNW3v9khHKFwbKvFWN3vOdnujblRH/HiI6ef
R3P4MsT7E4I9MY9WMxf6ftCrdoc8BysLESa7QXM9xMP/0FmDCFbdqXiQQVAdGJ8C
vAgCwjR2VNo2d4mDjv1fvARZLDVEaxhpDtz+l8yrkcDfyNKb1naXl1d2gHmggS/F
1U3fa66bXryRGMl54G8WmyilZeTtG7xz3hCeH8ukcU59KufabFWXxN0axz3E5i1j
qFOAdzexFWcoA/CzpfhMl7uW3bM8s4Qd2BOZuC26c2QqvkIS8oS9n0u8puY9F50l
XXukxX/z8xt9Vr1Mo04KKacNLw3F/yUxhuPjzjjUB8Bq2no2tW70+q0gjegbkiER
PfdrflxAxjLPriLN7UTgX4s74cHDQA2urmvVb5M/aOJoNagcjv2x7Q9/KkULvMhR
l4cW6qMJMoMqjhAlpK9k36ppOn2Kh8DwyWcZOIEuipsPdDLdMiMjjE9TJ3gNGwHe
ffYOhgae7quLO5Py1USpKeOOmLQHQ9UBotpKUNJuqu97l6CMIa219m9i4S5UCNI+
cxt0qdE6VPVeSGhhr+6o/sgaPyo1iTa3n8VlbJXRt9qZjFEqdug=
=d5xE
-----END PGP SIGNATURE-----

--ktqjxqf9bcS4kWpb--

