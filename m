Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2E1C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 08:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrXN-0003RO-8A; Mon, 05 May 2025 04:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBrXJ-0003Qz-CJ
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:50:53 -0400
Received: from netsrv01.beckhoff.com ([62.159.14.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBrXH-0003WO-D1
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:50:53 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1746435048; bh=8ec+EroGjSwybhsy/4rYBy6Myiua0EtrMwLAliuiTg8=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 IEX6jYHc8xugBarvaR7L3kdTFz0mfK8HMLydfKLbtpyQYOnqKFoMAund/IXneEVlKV2E8uAdkENoVr5JbEWuCg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1746435048; bh=8ec+EroGjSwybhsy/4rYBy6Myiua0EtrMwLAliuiTg8=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 ApRvovEhAsY36GchLeRpu+LOaQnKgkloz2DmeARr2LnwOWWGYqXlJmS0feu0FnnqW0L6kecsjRUN2PTsZ83xZ84tDNOnAbbd5KNZmcnF1HXvURx4yzeCHD0KW0HLtQB/DW4MfgbOHtBmupvpcm+Ph2jMXmSMW1cdaVAdAc9EnfL+84r+LiOaQaQ3ymLfgazKHgs8Wy9W9BYJC3ZdCDHmDD85n/++0Ywe/n8dAHa2d3RW/bORKOJbBXtw6jMhZR3tRj0YJCM9mGDth0HuLSpI8ZgimgbpyJX2qaj2PQCuQZwVyBhMSyHLDCl8cMLTsC59K2pn0Bo/QbOEuP6a85WtEw==
Received: from 172.17.2.111 by netsrv01.beckhoff.com
 (TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384); Mon, 05 May 2025 08:50:48 GMT
Received: from ex10.beckhoff.com (172.17.2.111) by ex10.beckhoff.com
 (172.17.2.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 May
 2025 10:50:47 +0200
Received: from ex10.beckhoff.com ([fe80::3762:2101:fb4e:8ffa]) by
 ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b%12]) with mapi id
 15.02.1748.010; Mon, 5 May 2025 10:50:47 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 4/9] vfio/igd: Check vendor and device ID on GVT-g mdev
Thread-Topic: [PATCH 4/9] vfio/igd: Check vendor and device ID on GVT-g mdev
Thread-Index: AQHbuFgVqZDxtLxvYUS+TKuxD7niRrPDo1yA
Date: Mon, 5 May 2025 08:50:47 +0000
Message-ID: <808c3c34c617b6202b5b077f3b3e24b604e29a76.camel@beckhoff.com>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
 <20250428161004.35613-5-tomitamoeko@gmail.com>
In-Reply-To: <20250428161004.35613-5-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.62.149]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-EvtoZ1+iWYf2iTx7SEiH"
MIME-Version: 1.0
Received-SPF: pass client-ip=62.159.14.10; envelope-from=C.Koehne@beckhoff.com;
 helo=netsrv01.beckhoff.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--=-EvtoZ1+iWYf2iTx7SEiH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-04-29 at 00:09 +0800, Tomita Moeko wrote:
> =EF=BB=BFCAUTION: External Email!!
> Check the vendor and device ID on GVT-g mdev to ensure it is a supported
> device [1]. This extra check is required for automatically enabling
> OpRegion access later.
>=20
> Note that Cherryview and Gemini Lake are marked as supported here since
> current code cannot distinguish them with other Gen8 and Gen9 devices.
> Since mdev cannot be created on these devices, this has no functional
> impact.
>=20
> [1]
> https://nospamproxywebp.beckhoff.com/enQsig/link?id=3DBAgAAAC7d6njJfw46ss=
AAADF-nyovaDPsQJyKOV5T7sLGnzTfabj4BLcrjbmZT8baVh1nRPWc5X1Mlcgmchoiq4Ame7F9p=
v8Dm3p32EVUqXHVZUZ4ydwKGK8058NOSzZdk88Xvq87l3akIni9zsivM8SufPB80Ps4QQhkcFR2=
xjFsyp1doPFX7-vdSDEuv_KSFgq4SZ6UXxq6JDwaLRbsVEkIog7tW-TROEpexsHJm7QzPVbqSCu=
oHky-Rb7fvkEimsF6AGSvCpAEejUDe78EDkE1k4RSw53IT6Ohg2
> =C2=A0
>=20
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> =C2=A0hw/vfio/igd.c | 12 ++++++++++++
> =C2=A01 file changed, 12 insertions(+)
>=20
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index d6880cbff7..c6ecbefb35 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -671,6 +671,18 @@ error:
> =C2=A0static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error =
**errp)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 g_autofree struct vfio_region_info *opregion =3D=
 NULL;
> +=C2=A0=C2=A0=C2=A0 int gen;
> +
> +=C2=A0=C2=A0=C2=A0 if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_I=
D) ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !vfio_is_vga(vdev)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /* FIXME: Cherryview is Gen8, but don't support GVT-g=
 */
> +=C2=A0=C2=A0=C2=A0 gen =3D igd_gen(vdev);
> +=C2=A0=C2=A0=C2=A0 if (gen !=3D 8 && gen !=3D 9) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> +=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OP=
REGION) &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (!vfio_pci_igd_opregion_=
detect(vdev, &opregion, errp) ||

Reviewed-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>


--=20
Kind regards,
Corvin

--=-EvtoZ1+iWYf2iTx7SEiH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmgYe+UACgkQ2FTaVjFe
Amo+Yw//TdYbwNw6latCjLZkXELBu+unsVHhTWZVIwYfOjSR6L/w3r6IR+UgUdti
lOfLbJslU6+fsny+nAs5+eRSZabkF2tiit43iOxOlk0izdb6xg0PsUfceNUOH63J
YzOlIlsWqDtxNAWeiAeFsX7TIs87T1zdSSr9SfB4M8VtZ2Ltxz2Bg33uEpRH/4Q+
W9XiZCibCcycSu5K91mCdbDDYKEuAmU4K6T0SayakW/tMYsTlNDw7PQaOfFdKGtr
iG0QUaoSwZ7BtES0fxoD/qz10FP3XDuAwRyt2iqs7enIyoY2kg5WZH2lnrl+o6oP
By4OyTVe/iLWhsBHw49TU4E4aEohk2RN2RmjvTXySxZJxat8+M6DCgLCe+EawJpe
LqTZFLToG/GFWSsJINfdiQShPzwbXH9p0qkBgFBbwEjEuh4kWBGmeTQk9ND7tPsg
M4bLTMEKM7KreBXlZkeTphX1YLbkoXTLS6o4QlEbLET0ZTnq75VSCYWWWlCFSmsn
QZFoB5F6H+7zr52O/ZROk9r8vE37OaZfXVANkAjNXZ4QkIYzBH6Kqlq21Q8QMGbp
pagA4LNxlSeiyMsaEn5E9wUPaXx6/V78Z+qyDYntBkqrxq7qg/VWISxgfrnhSP5d
d5p/8cSru4IHWT0LMY6SJ84N/1c2kysjdcCYJpXgRpPQeXCO8uE=
=TSZu
-----END PGP SIGNATURE-----

--=-EvtoZ1+iWYf2iTx7SEiH--


