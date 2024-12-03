Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE90E74AC2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 16:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIVbd-0002TM-KF; Tue, 03 Dec 2024 11:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tIVbc-0002TD-I0
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 11:18:32 -0500
Received: from internet2.beckhoff.com ([194.25.186.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tIVba-0006hr-P5
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 11:18:32 -0500
Received: from 172.17.2.171 by INTERNET2.beckhoff.com (Tls12, Aes256, Sha384, 
 DiffieHellmanEllipticKey384); Tue, 03 Dec 2024 16:18:28 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1733242708; bh=Xv93XSrN6QodWVZUBbiFXURKScoGqbRm2e5gVg+bKe0=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 s6Rd5m9Gsc88/+Yw3XqVK7A/gh4P/N2/vOl8XXUeJc9gAFqeidQcljvpcUzqOmyPg6o4Ixu/zQjlxfApxtz8Bg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1733242708; bh=Xv93XSrN6QodWVZUBbiFXURKScoGqbRm2e5gVg+bKe0=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 ChCch3Ayc9o4+kWwh8hde2zQ0Ki588RT6SBK892xdXHlVnbBknIH6dIDiwFaHQkc8+adxcmwUucpGO79QImkhxTxivcTgQrN/UQfMPZ3VxTaZhqMh10EDNJ7kJFDD0qY5qLxSt9RF0U1SWK0Q20g/aDrg5IjtWiJj2jg3+ni9ZLZ2us0kMfoTUoe4jqof8NGWnO6iayMVVVAI9wtEFjFmUfVGvZZ4l2hZCspxoFGCeXzsM1GBYiUW5Pv8B3op5BxDvqMLVzm8Bk5K+2Lxwz31f107i1+JTE9wxsuz9O0XbZebWvnO6lOejeX8GVmjyQXuAmIxPW//CB/LOe/f4FnEQ==
Received: from ex04.beckhoff.com (172.17.5.170) by ex05.beckhoff.com
 (172.17.2.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 3 Dec
 2024 17:18:27 +0100
Received: from ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3]) by
 ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3%6]) with mapi id
 15.01.2507.039; Tue, 3 Dec 2024 17:18:27 +0100
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "clg@redhat.com" <clg@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 5/9] vfio/igd: add Alder/Raptor/Rocket/Ice/Jasper Lake
 device ids
Thread-Topic: [PATCH v2 5/9] vfio/igd: add Alder/Raptor/Rocket/Ice/Jasper Lake
 device ids
Thread-Index: AQHbRYhYMzYX3ZNh0E+MQkF3dHleU7LUoiOA
Date: Tue, 3 Dec 2024 16:18:27 +0000
Message-ID: <5f4a6a8ac973d7406bfda0491648b926b6d48768.camel@beckhoff.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
 <20241203133548.38252-6-tomitamoeko@gmail.com>
In-Reply-To: <20241203133548.38252-6-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.130.158]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-cDNAO2e5LanPtjiOX+Nx"
MIME-Version: 1.0
Received-SPF: pass client-ip=194.25.186.210;
 envelope-from=C.Koehne@beckhoff.com; helo=INTERNET2.beckhoff.com
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

--=-cDNAO2e5LanPtjiOX+Nx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2024-12-03 at 21:35 +0800, Tomita Moeko wrote:
> =EF=BB=BFCAUTION: External Email!!
> All gen 11 and 12 igd devices have 64 bit BDSM register at 0xC0 in its
> config space, add them to the list to support igd passthrough on Alder/
> Raptor/Rocket/Ice/Jasper Lake platforms.
>=20
> Tested legacy mode of igd passthrough works properly on both linux and
> windows guests with AlderLake-S GT1 (8086:4680).
>=20
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> =C2=A0hw/vfio/igd.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 7f389de7ac..fea9be0b2d 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -85,9 +85,14 @@ static int igd_gen(VFIOPCIDevice *vdev)
> =C2=A0=C2=A0=C2=A0=C2=A0 case 0x3e00:=C2=A0=C2=A0=C2=A0 /* Coffee Lake */
> =C2=A0=C2=A0=C2=A0=C2=A0 case 0x9B00:=C2=A0=C2=A0=C2=A0 /* Comet Lake */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 9;
> +=C2=A0=C2=A0=C2=A0 case 0x8A00:=C2=A0=C2=A0=C2=A0 /* Ice Lake */
> =C2=A0=C2=A0=C2=A0=C2=A0 case 0x4500:=C2=A0=C2=A0=C2=A0 /* Elkhart Lake *=
/
> +=C2=A0=C2=A0=C2=A0 case 0x4E00:=C2=A0=C2=A0=C2=A0 /* Jasper Lake */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 11;
> =C2=A0=C2=A0=C2=A0=C2=A0 case 0x9A00:=C2=A0=C2=A0=C2=A0 /* Tiger Lake */
> +=C2=A0=C2=A0=C2=A0 case 0x4C00:=C2=A0=C2=A0=C2=A0 /* Rocket Lake */
> +=C2=A0=C2=A0=C2=A0 case 0x4600:=C2=A0=C2=A0=C2=A0 /* Alder Lake */
> +=C2=A0=C2=A0=C2=A0 case 0xA700:=C2=A0=C2=A0=C2=A0 /* Raptor Lake */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 12;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0

Reviewed-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>

--=-cDNAO2e5LanPtjiOX+Nx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmdPL1MACgkQ2FTaVjFe
AmofdBAAsb4b2AhdJgFEMWd60D0ZTpQ618RW0jiovD+J2tkKNKvKIOVV2LrZOEnH
6QFL2UJQsA4B4pXeFXTb39dQ1BMPKazh8K8QEdPqyiKHV0T7p/940iUAlZoYrzjP
31oikFU30JzLD3jaEh/XPHqs8gwZcKSi9EfnTTR/YDQnzWGCvWCaNhd/fLuvRblF
pK5Gf5t1qyz3CsRT6ox5WuzuTw9xDDkDIRhnnVTUM3mHPF3KACJWKKSTObSgpmjD
vWt7S1zl7kcVGHbkM6PFJJLRYKnNWJ8L0tda4+VuG0+CpRnRnRz1jl9W0Uhb+VTc
M1VYnBVmRVI/BILGOI1k9zldXmCD8Ufx00noZQnnkWe6AnbBeezeEUehWQu5aySq
f69eor2N3rwG1XHCLZL1Y2q6Tsht6tDWoZ0SPgKTTCJVSj4OiLnpsJFuhrO/HKDK
/ZawY/Qeho+bY8+hvv1TINT3wxXtWgdreuFsRzpHeSN4ifT0lUy6NNMONHP0yFRm
F5MeXmGs21mSVChgXBPiKljNR/opbaye+PLGFzQ6aI6Ch+iBIP3I/ZV2s/31s7CZ
aCtNyBmPakjtiwvubNUHNR8y56i2TGQSqFbofQngL9s8V5FMSuJLjAwOA1cMZLmU
BV1oLuUQOyUkwIYbpdhwW2wGmq3giUqNCdc84aKGr0u/xf6Djoo=
=QJS6
-----END PGP SIGNATURE-----

--=-cDNAO2e5LanPtjiOX+Nx--


