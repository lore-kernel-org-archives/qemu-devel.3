Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FB0D78326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 14:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI7B7-000808-89; Mon, 02 Dec 2024 09:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tI2VC-00089O-Kj
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:13:58 -0500
Received: from internet2.beckhoff.com ([194.25.186.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tI2VA-0007D1-9L
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:13:58 -0500
Received: from 172.17.5.171 by INTERNET2.beckhoff.com (Tls12, Aes256, Sha384, 
 DiffieHellmanEllipticKey384); Mon, 02 Dec 2024 09:13:54 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1733130834; bh=oHSA1jLzyuVtTL1R44YuEg3nEckcmwu7wnuVB2TMfnM=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 /qvMhFcSuBcNHdyz1wH2OsF5x7CTy8g43IAjGKoNX63bshdDVdwx+V2+rT860Pk3vJadLjl3O2lX/XoybkjzBQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1733130834; bh=oHSA1jLzyuVtTL1R44YuEg3nEckcmwu7wnuVB2TMfnM=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 EWHrUKeFDGdFh8pVplezc3dspf7MQ+yQGWo4MlzUqmwAuaMxE33vl+k5O4YE+cgr70JB5NDrVbNbhmv4wJis/4nc9lTOkuu5N4AIfUd1oZraTUhn35mKZXsrrBZ8neRIi9emzsgvgaAm6rMVP8N6M8oMkGjsfxNBw7Ut+K7m2qMV6sDtvp8d5g4vmrEtvi2Hef4krukQALXXF8HGeFA6h/l4GSfj5Frc9LMAawpH/OrOzCC0+aAMABqPzC5ew7unrNfcQQS6RV9Jb3VTZQ4sC+Ftt9nDCp/iKNO+2+50O/KmLi3Ibrv3UWCbsPCeqEHhh7B5qXF9pLsM2qQImlKllg==
Received: from ex04.beckhoff.com (172.17.5.170) by ex06.beckhoff.com
 (172.17.5.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 2 Dec
 2024 10:13:53 +0100
Received: from ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3]) by
 ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3%6]) with mapi id
 15.01.2507.039; Mon, 2 Dec 2024 10:13:53 +0100
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "clg@redhat.com" <clg@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 3/8] vfio/igd: remove unsupported device ids
Thread-Topic: [PATCH 3/8] vfio/igd: remove unsupported device ids
Thread-Index: AQHbRAt2zrG1EOad6kOEOcI4+R4AXLLSXdcAgAA+UoA=
Date: Mon, 2 Dec 2024 09:13:53 +0000
Message-ID: <a49b93e3bdff4dafa4e20f5cae1e5be00dae8a7a.camel@beckhoff.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
 <20241201160938.44355-4-tomitamoeko@gmail.com>
 <20241201223050.12ead1a4.alex.williamson@redhat.com>
In-Reply-To: <20241201223050.12ead1a4.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [87.122.28.117]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-LIkpgo6SYRUmWgeSKJI9"
MIME-Version: 1.0
Received-SPF: pass client-ip=194.25.186.210;
 envelope-from=C.Koehne@beckhoff.com; helo=INTERNET2.beckhoff.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--=-LIkpgo6SYRUmWgeSKJI9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2024-12-01 at 22:30 -0700, Alex Williamson wrote:
> CAUTION: External Email!!
> On Mon,=C2=A0 2 Dec 2024 00:09:33 +0800
> Tomita Moeko <tomitamoeko@gmail.com> wrote:
>=20
> > Since e433f208973f ("vfio/igd: return an invalid generation for
> > unknown
> > devices"), the default return of igd_gen() was changed to
> > unsupported.
> > There is no need to filter out those unsupported devices.
> >=20
> > Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> > ---
> > =C2=A0hw/vfio/igd.c | 10 ----------
> > =C2=A01 file changed, 10 deletions(-)
> >=20
> > diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> > index b449316ec0..8f300498e4 100644
> > --- a/hw/vfio/igd.c
> > +++ b/hw/vfio/igd.c
> > @@ -64,16 +64,6 @@ static int igd_gen(VFIOPCIDevice *vdev)
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 switch (vdev->device_id & 0xff00) {
> > -=C2=A0=C2=A0=C2=A0 /* Old, untested, unavailable, unknown */
> > -=C2=A0=C2=A0=C2=A0 case 0x0000:
> > -=C2=A0=C2=A0=C2=A0 case 0x2500:
> > -=C2=A0=C2=A0=C2=A0 case 0x2700:
> > -=C2=A0=C2=A0=C2=A0 case 0x2900:
> > -=C2=A0=C2=A0=C2=A0 case 0x2a00:
> > -=C2=A0=C2=A0=C2=A0 case 0x2e00:
> > -=C2=A0=C2=A0=C2=A0 case 0x3500:
> > -=C2=A0=C2=A0=C2=A0 case 0xa000:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
> > =C2=A0=C2=A0=C2=A0=C2=A0 /* SandyBridge, IvyBridge, ValleyView, Haswell=
 */
> > =C2=A0=C2=A0=C2=A0=C2=A0 case 0x0100:
> > =C2=A0=C2=A0=C2=A0=C2=A0 case 0x0400:
>=20
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
>=20
>=20

Reviewed-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
disable-disclaimer-BADE




--=-LIkpgo6SYRUmWgeSKJI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmdNelEACgkQ2FTaVjFe
Amri8Q/7B5+YPcUg8Wk8qIfK54NipFRJZCfyTdNqkzsl0WdIWuZbS60jJZnqg/ZO
Y0kLuj6FnMqe/s6x6LmYGTG/66EZT+LCkWSRZHJwR20z/B8j9fKlFDz3N981f4vs
9+V0zydFZMa6fgp0vxOceDtMtCeOqrmahYY82w5X7XXSFeFP6J3eQb6RmLNXJFNx
SscyW/OVuRjVpfABEYCE/CRaWir3TPDld/fnMAfULQAz+IjWR2IKmA/w1q3L9IhO
I8LLcSODzdgOyvZB+RDnNizd5j6ghm5zUCzYbMSCy1Df6/RnGCdj5WS3fAjnreID
UunAfsLXT9NQD0OAF21krXrutLqekPJ/8XhjPRRIJ94sHFaZDVGnCU9MGlid3EEH
k0J3mPlUKybDaaKysZpxpjyJkhkWubngtP/kwkBtFatEuRb6vL+xtMtPYbRuWJrt
W/3XUfnXk4RQZeKULHjorjxH+rtBplYq8veBBDFuDjdDD18/eKKzjqKN9IsheSdy
giSe4gB0K2Ik/e3+0NDwNWuZRb2rSrkHTDhU6phOZ96hA6hgAOSHOf6Hs+rg6Zrg
Obs+bGTIozkn7EvBJ3X+EHuXoklbY1t2OCadHg1wR9PPo/35EDFXTUkOu1s/kBRB
dzFbS/5pZI0j3g3cd3RdWbJDqt2PZu2Do9Vrvz58fTIlewKgrwY=
=g8xD
-----END PGP SIGNATURE-----

--=-LIkpgo6SYRUmWgeSKJI9--


