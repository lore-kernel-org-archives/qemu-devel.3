Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204C9D78326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 14:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI7B8-00088i-NX; Mon, 02 Dec 2024 09:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tI333-0006Oh-IN
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:48:57 -0500
Received: from netsrv01.beckhoff.com ([62.159.14.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tI330-0008Gd-VY
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:48:57 -0500
Received: from 172.17.5.173 by netsrv01.beckhoff.com (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Mon, 02 Dec 2024 09:48:53 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1733132933; bh=nADn4HbV5/OVZnq+Xrz3JvS2JyWEU8hFlUlDnl8TWms=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 weJtcnsedMSD3WJGAEIVdrDfrf09vGu1RjPO2vYVbE4hUJIM4RUGlnbwQCCIcRtBs4DhmpGXDpg13jiFGSzYBA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1733132933; bh=nADn4HbV5/OVZnq+Xrz3JvS2JyWEU8hFlUlDnl8TWms=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 AabQbA1Dlx8ytUm3OG1QW87xSdZEpOS+WA7kIJviBbtMeDuKxAYVFuhBJNajiQweJrXUTvmipy16W/SmyY0HA2MmCH/oBndCBZhCsH2fP0yB2g6K9PCptYrcIR0fTyTvY3bwQRM3RSK3AR4tbeq7u0LBcTJewQKfRvwgC7fvVRy7kX2z0AghCTclAp0YryORbY/w7C2gQ2KIvWKtyjDLe0S+QcaxUn/3khNlMJcnyoqm68dRRNw/s/eHj1WdujLbbm/cVcB0jCIkJ9X/B2Z1iGiZSTYz2l7SM4PApSI+TMZ6tAsG8N8qKPFAfjUdqiq3Xo2mGJ73MbmdTcYQsqkTPg==
Received: from ex04.beckhoff.com (172.17.5.170) by ex08.beckhoff.com
 (172.17.5.173) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 2 Dec
 2024 10:48:51 +0100
Received: from ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3]) by
 ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3%6]) with mapi id
 15.01.2507.039; Mon, 2 Dec 2024 10:48:51 +0100
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "clg@redhat.com" <clg@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>
Subject: Re: [PATCH 8/8] vfio/igd: add x-igd-gms option back to set DSM region
 size for guest
Thread-Topic: [PATCH 8/8] vfio/igd: add x-igd-gms option back to set DSM
 region size for guest
Thread-Index: AQHbRAt+xWEC9BDyn0i+aKAtXK5OubLSpe8A
Date: Mon, 2 Dec 2024 09:48:51 +0000
Message-ID: <352b53107d7d6666f7d307afebb81da744690e2f.camel@beckhoff.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
 <20241201160938.44355-9-tomitamoeko@gmail.com>
In-Reply-To: <20241201160938.44355-9-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.130.225]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-3GoboWEBPOWTLZh2pRlZ"
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

--=-3GoboWEBPOWTLZh2pRlZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-12-02 at 00:09 +0800, Tomita Moeko wrote:
> =EF=BB=BFCAUTION: External Email!!
> DSM region is likely to store framebuffer in Windows, a small DSM
> region may cause display issues (e.g. half of the screen is black).
> By default, QEMU uses host's original value, which is determined by
> DVMT Pre-Allocated option in Intel FSP of host bios. Some vendors
> do not expose this config item to users. In such cases, x-igd-gms
> option can be used to manually set the data stolen memory size for
> guest.
>=20
> When DVMT Pre-Allocated option is available in host BIOS, user should
> set DSM region size there instead of using x-igd-gms option.
>=20
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> =C2=A0hw/vfio/igd.c | 17 +++++++++++++++++
> =C2=A01 file changed, 17 insertions(+)
>=20
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 3fd822241d..614223123b 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -712,6 +712,23 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, =
int nr)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk,=
 next);
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0 * Allow user to override dsm size using x-igd-g=
ms option, in multiples of
> +=C2=A0=C2=A0=C2=A0=C2=A0 * 32MiB. This option should only be used when t=
he desired size cannot be
> +=C2=A0=C2=A0=C2=A0=C2=A0 * set from DVMT Pre-Allocated option in host BI=
OS.
> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0 if (vdev->igd_gms) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gen < 8 && vdev->igd_gms =
<=3D 0x10) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gmch =
&=3D ~(IGD_GMCH_GEN6_GMS_MASK << IGD_GMCH_GEN6_GMS_SHIFT);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gmch =
|=3D vdev->igd_gms << IGD_GMCH_GEN6_GMS_SHIFT;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (vdev->igd_gms <=3D=
 0x40) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gmch =
&=3D ~(IGD_GMCH_GEN8_GMS_MASK << IGD_GMCH_GEN8_GMS_SHIFT);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gmch =
|=3D vdev->igd_gms << IGD_GMCH_GEN8_GMS_SHIFT;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error=
_report("Unsupported IGD GMS value 0x%x", vdev->igd_gms);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 ggms_size =3D igd_gtt_memory_size(gen, gmch);
> =C2=A0=C2=A0=C2=A0=C2=A0 gms_size =3D igd_stolen_memory_size(gen, gmch);
> =C2=A0

As mentioned in my commit removing the x-igd-gms option, I've seen issues o=
n Windows guest when
setting a wrong gms value. I can try to recheck this.


--=20
Kind regards,
Corvin
disable-disclaimer-BADE




--=-3GoboWEBPOWTLZh2pRlZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmdNgoQACgkQ2FTaVjFe
AmqOsg/+ILCRNRZql87MS20XULcwAeWsKDv2ZY7IZ9hDbcuoOCc8FwMQP8H7Y3cR
fRAr2M3L6KvIZVIgSt+aG8LysG2adojZaWg+JSlR5YrmGtbQKo6FP1ZIw4vWjyvx
I6tLSdhPQg0cZ1wviCo9S9QEvFAgt2wvxJonOdhUPZgwFnQKgNuFIuML4H73mEEc
6/qHvOcR/sKmGg6bvLYPgBs+STT1I6EezJsDcLfHRcUHC9Cfbm9beetAP99+Q/w3
ZXRj52FuKFtEGzp8WUBwlAGuVTXJPHUtoX4b+0vGaHmor6OwjfIZEeamQWee8Hqy
NDKKKj86y9YW5ZreQli8o42ejFIuFBRq4y6Q+ENesgOqaMOXceBoH7wQcbKmdhFI
9vVfDAUBfKe/mhYxPNmSoDlY4iWspBfDZqD75IFCb/gDMhr+auTQj5e37wjAFDZu
sMGD6KP2lhWbVNWzk/L9ie1icmTcZCUwF6+aJJcTGEA+iRCW3RwN604vfjXjba+i
EmRrLak+O72IuZdQvM8bTlTEvXA1AJGK44/zHEgo6QdYP6ODtpT8455xSLbqtjuw
Isoac7BV6IqKWb0/3Ds0Mt2W1jiYwcWc31IaGsJCbbGJ1NUd/jFCEFd6DYcgf3d2
FkqrD83KZicApJ5OyB51Dv6V3cT7xaH+H10samgA3i8VP9UkdeM=
=jFvm
-----END PGP SIGNATURE-----

--=-3GoboWEBPOWTLZh2pRlZ--


