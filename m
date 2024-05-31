Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3203DC25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 04:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCuGQ-0007tX-Ce; Fri, 31 May 2024 00:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1sCuGO-0007tI-F5; Fri, 31 May 2024 00:53:12 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1sCuGJ-0000F4-Nj; Fri, 31 May 2024 00:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202312; t=1717131179;
 bh=oL0pYk4A7KSFwNjeA9WL5DKG2QueX/P12UxW4zsoc+g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C0Pv8mkAg3vgA2AQFlvQrH0QB5vojqDPg3KQT3VcCJVD0cyPhSU+KHrNT0Fv77pjS
 AM35/8wj8m8sN6msvN7kokzn+OrTn09RP2Lt9jukgcByIfMr7JX83lBugBWxpfNk7a
 3LyNCF7BaxTfjCJPircfA1xt3xA3WlI88KCCTbswlOAYWu3A9EDRGlWcrNSiNhzlB8
 X6xi0OWzmHY1B4Ks+ywQJ2Du3XpO/sP7/7muU5yzBh9IM6xPdbsjGuNkjLOP8uHvly
 swx5UCWzLBrP9Hnb7TmF7We1L6bxv5ySuvfK7sfeZIge1aBFB873iv0jweg8nwRGEK
 Y66s1/OKWIbKg==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4Vr9jR4b3tz4wqM; Fri, 31 May 2024 14:52:59 +1000 (AEST)
Date: Fri, 31 May 2024 14:52:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Oleg Sviridov <oleg.sviridov@red-soft.ru>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/net: prevent potential NULL dereference
Message-ID: <ZllXpPUvYf1QqMs4@zatzit>
References: <20240529110804.3636963-1-oleg.sviridov@red-soft.ru>
 <ZlfIU7TOiXnP96Aa@zatzit>
 <CAFEAcA8zLOEo09dWioEac2tuPXv+jPYbnTduWZ-MixKbeNBC4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2OxTl3U88ZfmT4mL"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8zLOEo09dWioEac2tuPXv+jPYbnTduWZ-MixKbeNBC4g@mail.gmail.com>
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


--2OxTl3U88ZfmT4mL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 10:03:51AM +0100, Peter Maydell wrote:
> On Thu, 30 May 2024 at 01:52, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >
> > On Wed, May 29, 2024 at 02:07:18PM +0300, Oleg Sviridov wrote:
> > > Pointer, returned from function 'spapr_vio_find_by_reg', may be NULL =
and is dereferenced immediately after.
> > >
> > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > >
> > > Signed-off-by: Oleg Sviridov <oleg.sviridov@red-soft.ru>
> > > ---
> > >  hw/net/spapr_llan.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
> > > index ecb30b7c76..f40b733229 100644
> > > --- a/hw/net/spapr_llan.c
> > > +++ b/hw/net/spapr_llan.c
> > > @@ -770,6 +770,10 @@ static target_ulong h_change_logical_lan_mac(Pow=
erPCCPU *cpu,
> > >      SpaprVioVlan *dev =3D VIO_SPAPR_VLAN_DEVICE(sdev);
> >
> > Hmm... I thought VIO_SPAPR_VLAN_DEVICE() was supposed to abort if sdev
> > was NULL or not of the right type.  Or have the rules for qom helpers
> > changed since I wrote this.
>=20
> QOM casts abort if the type is wrong, but a NULL pointer is
> passed through as a NULL pointer.

Ah, my mistake.  LGTM, then.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2OxTl3U88ZfmT4mL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmZZV58ACgkQzQJF27ox
2GfCnhAAjEVv/MLsbk5FA7+IPwqOzPSwrkpNuTURxMbInbQXd5jmUg55LPRuSo0o
jGuv8MZXPyb78zZLmEdtrE2f0ZfDlrsbjt1IYjhw0o1zSo0g9jPfwqBy4ccr+27P
A6LzPMkpcOfmjW/6fhh2WhB1GVwTU6/FSOQEUg0IRsc0+WTiL+EVyvy2a4+3iRhl
APOqB9Lgq53fI8cy5uRs4QJYGDSw+ijHppo/diRhyjOdNNygz25b3PY7DgNfHVqE
T2YYru8iCuIDIeg92zdSLsCG7AKAWqJXolBrjGO2N46YPBsxgMVixB6g5vlQtCCb
tkauD+GnpMwPZFloIzpOcY3XOiXsvUzvY5nxmATZDNHxyeDh1pNnNcyRqS+s/xNq
09M6oNAns7tbvc2/0C5cABT2O8Zf0omkH6hsEoJgTJzzUTHUWQuz/4cqmU9yxBQ7
D3MDyZ4oiIE5Hqxg4dhocGhvbi02gBX7nfSNIf682duJReZ/CD5fLrm7L/7zMRkE
x5Jo61lfD8k7rlHzPKd8zFM+wNOLNOLH25yfFdMbPtzDK/OrlTG2uK12vEJwt+Nv
OfPoJSvO3jcTFay3S0rgISeGmz3XedhHK99TK++m9+LTkh3wROBH32/3GaKtzdyD
SveybHpTlmNj2a1sh/Nv9tvBVx4ze+Wb6hhMIYmEEho7GHCNBDQ=
=6dNL
-----END PGP SIGNATURE-----

--2OxTl3U88ZfmT4mL--

