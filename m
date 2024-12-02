Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28070D78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 14:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI7B8-000877-FJ; Mon, 02 Dec 2024 09:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tI2dv-0000zu-O4
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:22:59 -0500
Received: from internet2.beckhoff.com ([194.25.186.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tI2dt-0000mw-Ra
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:22:59 -0500
Received: from 172.17.5.170 by INTERNET2.beckhoff.com (Tls12, Aes256, Sha384, 
 DiffieHellmanEllipticKey384); Mon, 02 Dec 2024 09:22:55 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1733131375; bh=9xgeFqB4vQWeXXr1WR+e8Jzaw55r1X9rvGl8BFbS698=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 +IGgQYJbwglIi5PFJWbQpaHAodNcZKTAHXdYUDtVI+cjaZqnAED6+lx5LOD0GCMHVrpaQdok7AugqYi8WJHhAA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1733131375; bh=9xgeFqB4vQWeXXr1WR+e8Jzaw55r1X9rvGl8BFbS698=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 uhV9SeA3fQVbZJcETaaL6iTrN9LBq83+15WlHMEfIUb485ccpWu0vOyPNaApdD/eh3qf4lSP1xZlCpPLp4OXLOx4ZjFfGoiFKDzFo520dHdrN06I5aidc3ANNbsRtJ29vZvc8L4mVtw090BUPFmDSjbY/MeTMv9pkFJxjXezolZNlVig2o5rVl7BwTG+Nw4VdeFRHTUfY1Z0mFOgMb/E0c7fViuxw/pntfNse0PVAe7wNS2pb4h3TUpF8CN0zSfGm25fb9NaUDthf07MYY8rrHu+5cxxXiWCphP+IIGjC0cf6gdw6qn1/PgGc1qqYAMafIlIAZz90K7DDzf2vgboWw==
Received: from ex04.beckhoff.com (172.17.5.170) by ex04.beckhoff.com
 (172.17.5.170) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 2 Dec
 2024 10:22:54 +0100
Received: from ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3]) by
 ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3%6]) with mapi id
 15.01.2507.039; Mon, 2 Dec 2024 10:22:54 +0100
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "clg@redhat.com" <clg@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>
Subject: Re: [PATCH 5/8] vfio/igd: add Alder/Raptor/Rocket/Ice/Jasper Lake
 device ids
Thread-Topic: [PATCH 5/8] vfio/igd: add Alder/Raptor/Rocket/Ice/Jasper Lake
 device ids
Thread-Index: AQHbRAt5lvqv2W4DqkyKSp+qBkmxg7LSnq0A
Date: Mon, 2 Dec 2024 09:22:54 +0000
Message-ID: <a9238d7f77df8e015b2280ed774e88f1ad9923d5.camel@beckhoff.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
 <20241201160938.44355-6-tomitamoeko@gmail.com>
In-Reply-To: <20241201160938.44355-6-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.130.225]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-oJkdduGf0IA7qOGa6rKn"
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
X-Mailman-Approved-At: Mon, 02 Dec 2024 09:13:31 -0500
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

--=-oJkdduGf0IA7qOGa6rKn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-12-02 at 00:09 +0800, Tomita Moeko wrote:
> =EF=BB=BFCAUTION: External Email!!
> All gen 11 and 12 igd devices have 64 bit BDSM register at 0xC0 in its
> config space, add them to the list to support igd passthrough on
> Alder/
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
> index 71342863d6..a86faf2fa9 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -79,9 +79,14 @@ static int igd_gen(VFIOPCIDevice *vdev)
> =C2=A0=C2=A0=C2=A0=C2=A0 case 0x5900:=C2=A0=C2=A0=C2=A0 /* Kaby Lake */
> =C2=A0=C2=A0=C2=A0=C2=A0 case 0x3e00:=C2=A0=C2=A0=C2=A0 /* Coffee Lake */
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
disable-disclaimer-BADE

--=-oJkdduGf0IA7qOGa6rKn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmdNfG4ACgkQ2FTaVjFe
AmrA6Q/+Nr6xkevBNIsjYmEMVYKlPYLXqasQveXBNd5Gnbg8vOgi8kkvaERnn3fd
bJZ4+h5XSBwzkcNC0RB3RKhWIJYgHAGmgJuG2seHnkqnPL18PM09JNaGt/s33+eJ
DWcJDvor7CgtYOSDA+LNXM7dc1ga6P6PIjyeHMHG4ExZLF2RG9T1B1GIbmmGZeF1
b4pRIpJg4ERKly5dbmotyvQjrcLfMdLw4hspwKSQgvVHq3IOgf1QtxqNB2z7SA0G
cONb14ipc6LeYQHLfPBNlqFx5d/0J41lN71OaATXNN2AMYtsbtkfm2HvcpCm6EXE
pDde6jGiaYi/DkM8Dq2eswjivizcZ1Q9z+TJVoROXb46xMywiykpXIR1gqKstLrD
PfhuC+SWXnGalQFh/WrAsgZ1k7BWpfJ6h+atajd2yJfP1S3Z0HOmX+Xj0SC/W/7S
nAVivZXhWPSts387K2CoTwyTEoAhrOvZaFFRO6bPYHNnir4wEle/rKfmpGxqnKTE
DOZ1p54c6pyHZEKYC4yUK6PCQ7vugRB3KrM6AYfpRpLHyljN9+cTQA9wWcR1kzyB
lJsofxeS9F6HKVNX4RkfhiGIslDWuCl+S4OTxvQkoMDIf4mlgfELYKCGk+mX+C4K
iKmOCODdbA79PYct8ZhAMLjEqe6xPIAPwFSD69mwZ6z7RgJhfTg=
=fjPC
-----END PGP SIGNATURE-----

--=-oJkdduGf0IA7qOGa6rKn--


