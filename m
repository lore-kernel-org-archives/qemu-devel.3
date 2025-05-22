Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204E6C54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 06:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHzfi-0004sz-Ml; Thu, 22 May 2025 02:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uHzfg-0004sr-KD
 for qemu-devel@nongnu.org; Thu, 22 May 2025 02:44:52 -0400
Received: from netsrv01.beckhoff.com ([62.159.14.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uHzfe-0001hE-Gb
 for qemu-devel@nongnu.org; Thu, 22 May 2025 02:44:52 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1747896286; bh=grOhdlAC5X15XHquS+zFQHmT/tyR3kgRt/UGF07dv08=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 ZDQ3dZpOvA+yyz+rYgtVFvby6TgMLb0OnZV5T93nWZGJbCXPVeoqMafX/irfrjoQh9sgwNjSbvNxpZOswDTWAg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1747896286; bh=grOhdlAC5X15XHquS+zFQHmT/tyR3kgRt/UGF07dv08=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 Ch8qP1f4ay1BOAAadalaA3MFdZYKJzne3eYvFoQO3GcPsWoxW3OLsdbfAhaK/Hb2FQjXWqmdENl50NIde4kIAbXMx+ITeFXbfHbpQ41Rvrf3itqqki+yTMUrSsoAsZy6y7dlfvxXcSxiXmfXLj6QUcY81mhkoHesK90Dv91yoewA4Rp6XpceB/se//3B6TUmW1w7GmDAcdbhdbN95m2SyoX70gXwQWbF4F5w+QUIzp0PakiDVbu8wyMM8+GvUB1B3Ra/6dhLrh0Bot9URIJhrt/AHfcXfQZastd9OH5Cjw8grv1+5ocyhMGZ0FyJd4TWDXdAUtw4Yqgf4f6PAcSEgw==
Received: from 172.17.6.19 by netsrv01.beckhoff.com
 (TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384); Thu, 22 May 2025 06:44:46 GMT
Received: from ex10.beckhoff.com (172.17.2.111) by ex13.beckhoff.com
 (172.17.6.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 22 May
 2025 08:44:41 +0200
Received: from ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b]) by
 ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b%12]) with mapi id
 15.02.1748.010; Thu, 22 May 2025 08:44:41 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "edmund.raile@protonmail.com" <edmund.raile@protonmail.com>,
 "edmund.raile@proton.me" <edmund.raile@proton.me>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] vfio/igd: Fix incorrect error propagation in
 vfio_pci_igd_opregion_detect()
Thread-Topic: [PATCH] vfio/igd: Fix incorrect error propagation in
 vfio_pci_igd_opregion_detect()
Thread-Index: AQHbymbNxHvevimGEUCbKAOYaq4PIbPeE6aA
Date: Thu, 22 May 2025 06:44:41 +0000
Message-ID: <24549633cc8c5d374fb3ede24939b17cd07d054f.camel@beckhoff.com>
References: <20250521154036.28219-1-tomitamoeko@gmail.com>
In-Reply-To: <20250521154036.28219-1-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.62.149]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-QLzhtMm++2SEeZ79NeyY"
MIME-Version: 1.0
Received-SPF: pass client-ip=62.159.14.10; envelope-from=C.Koehne@beckhoff.com;
 helo=netsrv01.beckhoff.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--=-QLzhtMm++2SEeZ79NeyY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-05-21 at 23:40 +0800, Tomita Moeko wrote:
> =EF=BB=BFCAUTION: External Email!!
> In vfio_pci_igd_opregion_detect(), errp will be set when device does
> not have OpRegion or is hotplugged. This errp will be propergated to
> pci_qdev_realize(), which interprets it as failure, causing unexpected
> termination on devices without OpRegion like SR-IOV VFs or discrete
> GPUs. Fix it by not setting errp in vfio_pci_igd_opregion_detect().
>=20
> This patch also checks if the device has OpRegion before hotplug status
> to prvent unwanted warning messages on non-IGD devices.
>=20

prevent

> Fixes: c0273e77f2d7 ("vfio/igd: Detect IGD device by OpRegion")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2968
> Reported-by: Edmund Raile <edmund.raile@protonmail.com>
> Link:
> https://nospamproxywebp.beckhoff.com/enQsig/link?id=3DBAgAAADuIFWfr8z-Rqg=
AAABiHH1XDaojIZQJ51lW0MfdmbQ31Dc6Q9h8spLn3SSpPU_3qX9yZXScfxI-jMpRRWHhwwz3Wz=
jHhTZuw3K8bmq6pYob7gKjPbBhTbeNLyeDio9w7y6aczQOHjPiGEAK1Zd5bXPhuYMJhd0r02BDX=
xk2NzfU10_-lfkisL6dUaMagg0Urr9aoCFD5may09obVXsyPg-RtsX8nfXOGmiQX-6W6i3Z7jYH=
4Ys1
> =C2=A0
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>=20

--=20
Kind regards,
Corvin

--=-QLzhtMm++2SEeZ79NeyY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmgux9cACgkQ2FTaVjFe
AmqeURAAlYsAss9clqB10v/m37iyoJKUE4Q9b7j26NgRJYFvbVKCOh2fU3DcArVF
WjFFv3nE4lML29mqGmyHsF6xa2idCsqYdwb8/bKx40XcaxeZ5VLY+9PBZ29+0OHG
4LCgea907oODkcSZv9awRtixp5uMmIkSI3el56UTDkN9tMhqeHMhaZXqOrTI3qjm
2rTb7z/PTjbO2Fr3oUoZJewfD9NqscP2u9zACyjs5yn1svlCINz8BG5w8D9t85Gq
0HYuC0Sf2BDGSvGV0Vejy+rPXvkw+Iw9yqJ4AlepGlw0seuIuNXLQC2mXGv7j7Uw
q8S9DsZuIMyktOQ/PWSDYPkXrJOIAF+aT2ogN9Px+Z+yVHa1WzRJZXiFEjWcqa6G
WmS5nrKZn611DoqEvEtfZFEJTQbD3ePQM9ogLWMc5QKzZN8Ei/7Y0bwGAfUazFkd
LwRaFWUA3Nv/MmplaqkLkHjsx+IeJf9n6rn4R1nP71wNU49Q4Q/x/3JuVQ8SYwv1
q8ZVzjd7wkrd+51h6C5+SFNHj9ptgC+nRWbP66vg1BOjffep/NdkdhDDAbvkkqMb
8iIXqnOFBtAhIAYY+4H/lbdUzo2YksshiCHVzhi2SlEjp0b3bgfvsF0up3NenLBu
jS5N/pGPG1Z4oPdSyeDi2OhFD3OgFlOi4KoCY+CfHD5CZ1TuXwA=
=eppG
-----END PGP SIGNATURE-----

--=-QLzhtMm++2SEeZ79NeyY--


