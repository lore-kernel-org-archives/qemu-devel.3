Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA925C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 00:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCU0n-0002gq-JV; Wed, 29 May 2024 20:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1sCU0k-0002fU-Ju; Wed, 29 May 2024 20:51:18 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1sCU0g-00079T-6h; Wed, 29 May 2024 20:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202312; t=1717030264;
 bh=/x5MO5PMetOccCGk5BJ2AKYTra5/NI7uwtPxEryYeuI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OfjzBKnthU9rc9F9vSQCMJMHUf/yEHDYI5mVcfLovFqnTkjmlKGDhWjkLA0l0ecsi
 /+SYmnD9yGbAJoDh/yRkaG2Q4eEisTUIGTZR+9MVVpH/OLKzSt20IViUX4wiVoRcRE
 JDVq3qhNYy5LK5jfq91xWiizRBWyktG+1zabMQB9BO4JEzaVzIdciOSYCl9BMnIiMq
 dQNoIl+f+lahtl2QS+jmj+p88itlZ9UaD4toX82yfT+4jZERuPSegr4FBCo9pdYGmL
 u36bvr6C7tavOG4qvM+Lq4tRhZNH7WuxEaFrpYZpym4RjlpIomuxqujE9oUoUmk68Z
 4PGlgATLhGilQ==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4VqSNm21l5z4x0K; Thu, 30 May 2024 10:51:04 +1000 (AEST)
Date: Thu, 30 May 2024 10:29:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Oleg Sviridov <oleg.sviridov@red-soft.ru>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/net: prevent potential NULL dereference
Message-ID: <ZlfIU7TOiXnP96Aa@zatzit>
References: <20240529110804.3636963-1-oleg.sviridov@red-soft.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/sU6HQx4taIxBvKr"
Content-Disposition: inline
In-Reply-To: <20240529110804.3636963-1-oleg.sviridov@red-soft.ru>
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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


--/sU6HQx4taIxBvKr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 02:07:18PM +0300, Oleg Sviridov wrote:
> Pointer, returned from function 'spapr_vio_find_by_reg', may be NULL and =
is dereferenced immediately after.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Signed-off-by: Oleg Sviridov <oleg.sviridov@red-soft.ru>
> ---
>  hw/net/spapr_llan.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
> index ecb30b7c76..f40b733229 100644
> --- a/hw/net/spapr_llan.c
> +++ b/hw/net/spapr_llan.c
> @@ -770,6 +770,10 @@ static target_ulong h_change_logical_lan_mac(PowerPC=
CPU *cpu,
>      SpaprVioVlan *dev =3D VIO_SPAPR_VLAN_DEVICE(sdev);

Hmm... I thought VIO_SPAPR_VLAN_DEVICE() was supposed to abort if sdev
was NULL or not of the right type.  Or have the rules for qom helpers
changed since I wrote this.

>      int i;
> =20
> +    if (!dev) {
> +        return H_PARAMETER;
> +    }
> +
>      for (i =3D 0; i < ETH_ALEN; i++) {
>          dev->nicconf.macaddr.a[ETH_ALEN - i - 1] =3D macaddr & 0xff;
>          macaddr >>=3D 8;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/sU6HQx4taIxBvKr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmZXyD4ACgkQzQJF27ox
2Ge8/A/8CqrylNLCTnwwO89S4/KLlnyJ6CVrDrp5QS2U5gZ20fDknieXYvibcz9r
K/KWa++aKbuyKSc32zqA64NE2c1inVbzQBvWyRZGarHGvhjgGuad/tZt+TNWidPl
Nwoeoq3t6wT2NmW6gS0DeHVoByB+8EOFdnGemKb1FLJS4i+R3hDI7R9HZgch7YFH
Ae/YdCR8NMBnNeg8yMDGwU4zxlTz7AY+0nmtlGE4sAlJgXQV6npPSiHxcvZI9hjo
aiy+O6lYoJI6GqkopqWtlwCuQaslAjbkaJg+DUFyLGDuKSGDkJu9U0RftgHJi1PL
FoRiZQy9fohCXJAMRZYK8LlFM9d/CYeCkhutc8x4U4Vdqsfei6akPY7elAG/4JG8
vfsowk2COpeYF2vjaeOtY5waqeVdr0Jzgaj+UX9cbujUVDK7BSvobuB5NiOj2QMx
YReCVIYheVDt1kxo7WjeY64kv2sf3VsW9FbkwJoZ7Is3aK82cH1K21B+Q7B63mY6
ZOX9tfj2HHJYVymxuRQO2av8w1Smlh5oMjDLBvt0+VpiI/7NVezQbfni2UkSNm6w
xl0+altPsJagAMrJYHlYPSQTO2fNBVRZWeBgwiOmQB057NCzs0F9yxfVQ1PeRiR5
56lVgUwgrEDHL32k2oLX1g5mCvFpq8i0PinlI4eb5N9IuYfFj+U=
=OODS
-----END PGP SIGNATURE-----

--/sU6HQx4taIxBvKr--

