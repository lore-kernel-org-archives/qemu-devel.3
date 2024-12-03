Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A043E74AC2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 16:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIVYi-0001hm-0o; Tue, 03 Dec 2024 11:15:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tIVYf-0001hY-PE
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 11:15:29 -0500
Received: from netsrv01.beckhoff.com ([62.159.14.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tIVYb-0006N2-Vp
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 11:15:29 -0500
Received: from 172.17.2.169 by netsrv01.beckhoff.com (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Tue, 03 Dec 2024 16:15:22 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1733242522; bh=MYQ0dm8OISa862wi6qB+cw+LZitp5ezDYFmVzAqerPs=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 B8lnBNh+n88kqXP43aDmN6Q1EHdmEtyeZ/81AxoORdnHPuqNUsf+rZLpRLYxFx7FwbZWFll+cH29XnHu0CORCA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1733242522; bh=MYQ0dm8OISa862wi6qB+cw+LZitp5ezDYFmVzAqerPs=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 edJU6Kwe8d9nMIhEU2dHQAOs5DNz89encB2zqIc2fIOX2sPQVwVBTyDvNobpd8HVlOj84t28OHDfr9e3QfOT3gPvxmkIAd5GIrvBuB/ULsevny+NbOIgC5s8pNrZFIjnCORwjNxzJUmzpuLtK9nL/xRFsBC6eMG9A4ddaWIhIyWuiWjaUFgvO6NGfiBOU1MtNsDx4MPH/tRa/328QHrvTPCE4CZs1w0NNxkmaZX46vOtkcuiw09IcvkbI/4WmwMS2sk6acFKRRS6S4Uq3w/EV0HtUqTWnvjr1/W2eL5tfC8WtljfYDxzFzZTBWMI2ae6D3SOGBcHTNg1rgHhEz1IKA==
Received: from ex04.beckhoff.com (172.17.5.170) by ex03.beckhoff.com
 (172.17.2.169) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 3 Dec
 2024 17:15:21 +0100
Received: from ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3]) by
 ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3%6]) with mapi id
 15.01.2507.039; Tue, 3 Dec 2024 17:15:21 +0100
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "clg@redhat.com" <clg@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 4/9] vfio/igd: add Gemini Lake and Comet Lake device ids
Thread-Topic: [PATCH v2 4/9] vfio/igd: add Gemini Lake and Comet Lake device
 ids
Thread-Index: AQHbRYhWLFtXVc2X0E2hw5/QUlT45bLUoUWA
Date: Tue, 3 Dec 2024 16:15:21 +0000
Message-ID: <730a0f069d69b50e09abf0b7391687ed838f9c4b.camel@beckhoff.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
 <20241203133548.38252-5-tomitamoeko@gmail.com>
In-Reply-To: <20241203133548.38252-5-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.130.158]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-4w+Hi+QLoPH3a5r2n0N9"
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

--=-4w+Hi+QLoPH3a5r2n0N9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2024-12-03 at 21:35 +0800, Tomita Moeko wrote:
> =EF=BB=BFCAUTION: External Email!!
> Both Gemini Lake and Comet Lake are gen 9 devices. Many user reports
> on internet shows legacy mode of igd passthrough works as qemu treats
> them as gen 8 devices by default before e433f208973f ("vfio/igd:
> return an invalid generation for unknown devices").
>=20

Are there any user reports you can link to in the commit message?

> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> =C2=A0hw/vfio/igd.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index b5bfdc6580..7f389de7ac 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -80,8 +80,10 @@ static int igd_gen(VFIOPCIDevice *vdev)
> =C2=A0=C2=A0=C2=A0=C2=A0 case 0x2200:=C2=A0=C2=A0=C2=A0 /* Cherryview */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 8;
> =C2=A0=C2=A0=C2=A0=C2=A0 case 0x1900:=C2=A0=C2=A0=C2=A0 /* Skylake */
> +=C2=A0=C2=A0=C2=A0 case 0x3100:=C2=A0=C2=A0=C2=A0 /* Gemini Lake */
> =C2=A0=C2=A0=C2=A0=C2=A0 case 0x5900:=C2=A0=C2=A0=C2=A0 /* Kaby Lake */
> =C2=A0=C2=A0=C2=A0=C2=A0 case 0x3e00:=C2=A0=C2=A0=C2=A0 /* Coffee Lake */
> +=C2=A0=C2=A0=C2=A0 case 0x9B00:=C2=A0=C2=A0=C2=A0 /* Comet Lake */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 9;
> =C2=A0=C2=A0=C2=A0=C2=A0 case 0x4500:=C2=A0=C2=A0=C2=A0 /* Elkhart Lake *=
/
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 11;

Reviewed-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>

--=-4w+Hi+QLoPH3a5r2n0N9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmdPLpkACgkQ2FTaVjFe
Amo2Pw/+LfDQX3Pvo9+JpxI0jBLQwiOFfl1fxnA5eNsSDr02UGyRSDCIciQrC02X
9m+uuSZ28ktCUr6w0VMScUIVM61Iy7r7RRv/eF4FiT8t+VR1iBAaiguldiBbRQ6a
h7kOwgDkYCOZuSCLIR8cdc4DCaFnNyjEORXCN380IjFIprJR0mQDR1zE3mbgavSF
zdPZ4A5VQL3Y3ZR1rg5OVrn18pEirkmwGTi3YxBo2r0hcRFZoafUuHkFMVbj4nNS
kPvxsgwHxcr25MTpEY2uW+O04JVCaWXiCHuQk+/Y5HNS2xBtf5TTR9GpBzIyr81j
ozCHeyVOYKNDxCTS88ileD3bWEP/lBEDdIAsjLwCdkBdbs00euUDuVXgpqOhyZI+
PLwhxSGXeHYPF06mjNKfeQqEVQwZL20x6GtSgvfLML5d1/VwYRjG6Onzn3N51n4Y
UB0QRCUhPsUwV847U3/ow5Ix169M9UJ4ElDAuo+E5V7s5pYYiGumNsyqhChnvvXY
Ge24uVbD1I2tjkN1Yj3eK1f1bfZEgeB9NQTqE3vGQGfYJJicf9q1TFXvbquXjEWY
M65qLx889CMWUyFgufyAYZKbpgsFfJmEnw12gdVss7oOTaMWbxMSWtfLYs6tzabF
z++WbGbJbzWa9znL7QquSG4EzlAVWxA/Zs0ZjRCcChIkM+PuW88=
=LOBO
-----END PGP SIGNATURE-----

--=-4w+Hi+QLoPH3a5r2n0N9--


