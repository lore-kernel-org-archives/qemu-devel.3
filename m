Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6DCCA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 08:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuRMD-0001aN-3e; Fri, 05 Sep 2025 03:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uuRM3-0001X2-2Q; Fri, 05 Sep 2025 03:59:31 -0400
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uuRLw-00022R-G2; Fri, 05 Sep 2025 03:59:30 -0400
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 5C63614000CE;
 Fri,  5 Sep 2025 03:59:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Fri, 05 Sep 2025 03:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1757059160; x=
 1757145560; bh=+2bR5nK6iyFz9Ed9n3w6YoWp1/wQG+r8Tz4VCeQod3U=; b=e
 GFlwULRZADrcl5q8G0SzENZ5+QSMPJGs/1g9aN3+MGEbBHPo+g8yn5SKdrggUINT
 xYI34hRk9Izb5+CzhZfsamJKt5PIpowcBndWZ08f6tA3jDTVkChwPzMzUR4XQm/I
 VgWx7usTkWlieHPNNrNk6J2Q9SMpneL+alo7ZsbzbhihlyhnKymSiOhEsclsF9xB
 vZb3ZTDCEbjWz6968NCSANMTLf7/hlAk8bB/HBsdl4snqTIy2KTpKhMlUSO9WpZy
 8nU6iGIzACqt335jlRUNpE7IGeNzH5+ax7U49A0IUVghSW7YinBjtvkmVLX0FeGe
 JvEQSTaikzz3kaGLfY46w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1757059160; x=1757145560; bh=+2bR5nK6iyFz9Ed9n3w6YoWp1/wQG+r8Tz4
 VCeQod3U=; b=C4IAco/y7uutdaEMxYKvryIK2kucKoJoFZrCxlhSudU83C64p7P
 elKKzRLMaixLLzUsRtM9e2qULLpXDHEU0EfFdm5mUOKNZoCYpM4oYYMxHQktSWVf
 h4H6Ev9gYYTopTCpeH8LPf9SwwY7nPxqfU/d60j3fumrG4cPKG+mbvuu0h9eYcsf
 hzytIZb/nE0kx37yQObt2HrsBWw+7Ki/SfxMWAIM3pI3rhSfQrTkMPKTMPBr2I85
 d/npzErrdssmkv0a+IUd5qVyFGJj3FBjEw12dmgsnX5wn0d3SD813E6FmDkGg5e5
 Grd+b36yrFAQpRUUWQr55t4DnjnuX5L/qWQ==
X-ME-Sender: <xms:V5i6aO3A4nsWV7BV9dCHw2B0FEXo3p3N2hqENlNAAv_7x-plJuaMYg>
 <xme:V5i6aJhtICIZ_sBmKD9ntn2Ol1hfbCAM4x6Y4WtXj8EqUNQiccMMyBoqWd9fMUCz_
 3r1Xa8dQIhH_ikQqWc>
X-ME-Received: <xmr:V5i6aHWpUmbKOIlQqyGfq5fiEPpxNGEtV2c2s-QMUoXEPO2Ge9vvCipQ0QVB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 epfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushculfgv
 nhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvghrnh
 epjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffffjeevnecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesih
 hrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
 uhhtpdhrtghpthhtohepmhhjthesthhlshdrmhhskhdrrhhupdhrtghpthhtohepqhgvmh
 huqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehpvghtvghrrdhmrgih
 uggvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopehkrdhjvghnshgvnhesshgrmh
 hsuhhnghdrtghomhdprhgtphhtthhopehqvghmuhdqshhtrggslhgvsehnohhnghhnuhdr
 ohhrghdprhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:V5i6aAUUw-lGGwak5lvr7eB5AA-g6CPJLzQtiQ3tCbDEuVfeqSw7mA>
 <xmx:V5i6aPgi2CWsMAzQc4imWwXkhP8dE43T-9GBOYZJdMEpiRXnQg6r2Q>
 <xmx:V5i6aDYqGqeEfKkZ_K7Mxy_GPH6F2Oyw3nrq2GpVQfXr7xloJQz_5g>
 <xmx:V5i6aEqBpmQRZRYzRsHXBXiupsBu72SD4cWJZDlMPEllRyAXTbE7DQ>
 <xmx:WJi6aB-Sc0-t4-ef88ar1vi9pp5FFqVflVJdFvyxiwngF6x5OkAfcJUn>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 03:59:18 -0400 (EDT)
Date: Fri, 5 Sep 2025 09:59:17 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PULL 0/3] nvme fixes
Message-ID: <aLqYVZ63dDNyg_D1@AALNPWKJENSEN.aal.scsc.local>
References: <20250811112557.521-1-its@irrelevant.dk>
 <986bb1ea-b889-4c06-a2fd-92c76496e0f1@tls.msk.ru>
 <bf8d4aa4-cbb2-4973-8541-0c4aaf2e12d2@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jeFfMnPgcInw95kf"
Content-Disposition: inline
In-Reply-To: <bf8d4aa4-cbb2-4973-8541-0c4aaf2e12d2@tls.msk.ru>
Received-SPF: pass client-ip=103.168.172.152; envelope-from=its@irrelevant.dk;
 helo=fhigh-a1-smtp.messagingengine.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--jeFfMnPgcInw95kf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep  5 10:57, Michael Tokarev wrote:
> On 12.08.2025 08:49, Michael Tokarev wrote:
> > On 11.08.2025 14:25, Klaus Jensen wrote:
> >=20
> > > Keith Busch (1):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/nvme: cap MDTS value for inte=
rnal limitation
> > >=20
> > > Klaus Jensen (2):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/nvme: fix namespace attachment
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/nvme: revert CMIC behavior
> > >=20
> > > =C2=A0 hw/nvme/ctrl.c | 43 ++++++++++++++++++++++++++++---------------
> > > =C2=A0 1 file changed, 28 insertions(+), 15 deletions(-)
> >=20
> > Is there anything there which should be applied to qemu stable
> > series?=C2=A0 Or *not* to be applied? :)
> >=20
> > (current relevant stable series is 10.0, which is supposed to be LTS).
>=20
> I'm picking this up for stable-10.0.x, together with 53493c1f83
> "hw/nvme: cap MDTS value for internal limitation".  Please let me
> know if I shouldn't.
>=20

Thanks Michael, that is perfect.

--jeFfMnPgcInw95kf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmi6mFMACgkQTeGvMW1P
DekDDAgAtIOr1wQOPVdHUo+JaJbDyky4EVAY1l72h69KHYOSbOVB27B9/T+r9RPM
X2MehfhSaUTtwp6iGeBNXTcXYHFG0o8Gbj+nOxykJOKH5kC7PzTmgBvo3HV5EqCr
3de5ntjBdxr7JeXANWClWe44tdsejrRonGD9jnDh7bdTOxD4QnuoGcoIhWq+wc4S
CMsFilbpi7g4dc/MAyN6OyCxYJpT/r7b42dOYFw0IPOilQIy6qb//ZUAGf0ClMya
vMpEdM5SxL4seSmnPSJADSs+1Ob0K0HkwO/UooGiMevAoqAK4ns/QtNqqxBHDnW8
6frrJwV7JiBDrqFB4hI22heIgKaB9A==
=p953
-----END PGP SIGNATURE-----

--jeFfMnPgcInw95kf--

