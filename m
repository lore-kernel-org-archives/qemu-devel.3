Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1EDC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 08:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrY2-0004M4-AV; Mon, 05 May 2025 04:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBrXy-0004HW-Tk
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:51:34 -0400
Received: from internet2.beckhoff.com ([194.25.186.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBrXw-0003a2-VO
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:51:34 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1746435091; bh=IyANnXf3ryRMXn2P8sC/u0FGSmkXpblCiW6k3SwfpDw=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 qdwoEDh0S7j7QOvXjFqdUpxGby4CeTqTd0rmnNKHwKI44hZp8/QxiaoZme7Ad9NO6CHuj+Yi9aRgdKyThj5kCg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1746435091; bh=IyANnXf3ryRMXn2P8sC/u0FGSmkXpblCiW6k3SwfpDw=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 ovzn2b9+c2q+GRsFQoC2z8MMVMYZgX7N+YgZ/SuP/02Q2d7/knxIDJ9SoiQRZq6AmVviv69UahV0NBeR9BJ5GY9vpDn9wOG1fGkisjR+h9dwQ3+XXEMlmef/FHkYz6KnAh6uSYmJknMTD800Q3AUs0xaevpbcovDArv9pe9mLeiuE+cYpb31+I0CDCqTUExidxfnLOop0PxB/a74SMGa3R5/zWb17y2sAa8sTKjTN0BGAJOhQgwh51x0zw4iybOGyIIDSA5bI/a50cWK28AZ5k3prO3zvhBjAXP5mOctVSleLXmnLkzEzWFvYksG4fgAetIst+6wG5rko2ki1tVvoQ==
Received: from 172.17.3.7 by INTERNET2.beckhoff.com
 (TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384); Mon, 05 May 2025 08:51:31 GMT
Received: from ex10.beckhoff.com (172.17.2.111) by ex14.beckhoff.com
 (172.17.3.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 May
 2025 10:51:08 +0200
Received: from ex10.beckhoff.com ([fe80::3762:2101:fb4e:8ffa]) by
 ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b%12]) with mapi id
 15.02.1748.010; Mon, 5 May 2025 10:51:08 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 5/9] vfio/igd: Check OpRegion support on GVT-g mdev
Thread-Topic: [PATCH 5/9] vfio/igd: Check OpRegion support on GVT-g mdev
Thread-Index: AQHbuFgWMMFgEbOUzUG5e5DneKZadLPDo3UA
Date: Mon, 5 May 2025 08:51:08 +0000
Message-ID: <cf0f9cebcf5b2997351d2963e72fdd9f5eafe2c5.camel@beckhoff.com>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
 <20250428161004.35613-6-tomitamoeko@gmail.com>
In-Reply-To: <20250428161004.35613-6-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.62.149]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-pjgyI/Suy9N/TXy3oapV"
MIME-Version: 1.0
Received-SPF: pass client-ip=194.25.186.210;
 envelope-from=C.Koehne@beckhoff.com; helo=INTERNET2.beckhoff.com
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

--=-pjgyI/Suy9N/TXy3oapV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-04-29 at 00:10 +0800, Tomita Moeko wrote:
> =EF=BB=BFCAUTION: External Email!!
> The Intel GVT-g backend `kvmgt` always emulates OpRegion for vGPU,
> make sure the OpRegion is present for enabling access to it
> automatically later.
>=20
> Also, hotplugging GVT-g vGPU is now always disallowed regardless of
> OpRegion to prevent potential issues. Intel has never claimed support
> for GVT-g hotplugging.
>=20
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> =C2=A0hw/vfio/igd.c | 8 ++++++--
> =C2=A01 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index c6ecbefb35..496d3df598 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -684,9 +684,13 @@ static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevic=
e
> *vdev, Error **errp)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 if (!vfio_pci_igd_opregion_detect(vdev, &opregion, er=
rp)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Should never reach here, K=
VMGT always emulates OpRegion */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> +=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OP=
REGION) &&
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (!vfio_pci_igd_opregion_detec=
t(vdev, &opregion, errp) ||
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !vfio_pci_igd_opregion_=
init(vdev, opregion, errp))) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !vfio_pci_igd_opregion_init(v=
dev, opregion, errp)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0

Reviewed-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>


--=20
Kind regards,
Corvin

--=-pjgyI/Suy9N/TXy3oapV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmgYe/oACgkQ2FTaVjFe
Ampg9g/6A33UR9VExH5rLDdXW6wBs3v2JvldN6t9AmdRCsT1JJNBPQlaJgl7cbIm
Xt4HUe6TMvF6MiOhjtxvT9lAD4x3m0e6qcoAbEj5nj8H0TEBl53o6spuvN+uHX2i
Y8f71HYZL+wJth/WgKoQfyu5tWCZywYNLhOJ5uZ9BgzF6PUmQLCdTupklI6lK4Vy
buf9gNPIC5JfmUm5CBqUw103NujtmxiIgdGkLtqXhcyZDDd4sGoZUBK0rAfVOxW2
CSl1CacK0nIP7oPnyXRVevWvZpExNGwxxg/HQ1fVx1jY53RUcD/vUJ/hR4dZxr6c
JZD6rGtI/aqsGCfCwsJrQK7IeBdqdXcqOHaOly9pzxKqQKBOdQfnsfDz5ujGsMFb
8+aBBuKROaQca4kdv9aBN81VCSBzhr39jWIHF00fYnUbolPUm11uvPEzOmg3jIY3
HHWIZZWA0id4cNdt7wNkEo1mgDwxb5mpKcx27PK1DYcfPEEEz2JnW7LYBJGHn22I
isG5bOi9Zcu3JyGgoRlqhCQl6uRX+SJ4BtQ+sV69Gq63HzhcHkZIzZuYhZfIg/3X
wJUZr6fNFkSRcg73RUJcu+1GoFcsq7RTDJO+Oxw+2a+4gjWsrg/wLvb0l6oGzGn1
p6BON4b81BjwNmfrX54Px/13p9Zn3PXKwvdqjjPwLrKPkredhDk=
=KYWT
-----END PGP SIGNATURE-----

--=-pjgyI/Suy9N/TXy3oapV--


