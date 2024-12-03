Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4CAE74AC1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 16:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIVRH-0007gx-Mi; Tue, 03 Dec 2024 11:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tIVR4-0007d4-1w
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 11:07:39 -0500
Received: from internet2.beckhoff.com ([194.25.186.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tIVR1-0005Iv-TD
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 11:07:37 -0500
Received: from 172.17.5.172 by INTERNET2.beckhoff.com (Tls12, Aes256, Sha384, 
 DiffieHellmanEllipticKey384); Tue, 03 Dec 2024 16:07:32 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1733242052; bh=tzMR8qi0cHxH5VQrSDZT8xKJUFfT/JIDQnoXWJtsTOI=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 aXNPk//ekegDXzZuxgLirfJ28Y/NQJHNLRsnf9Yht8e2dXUIN/CSgTskwfX0AeWCjro+pbQlTfZlyL5t3HoVDg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1733242052; bh=tzMR8qi0cHxH5VQrSDZT8xKJUFfT/JIDQnoXWJtsTOI=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 uY26Uw1INai2VZznMxhyYNJye8U1uZH+0GIn2epj5/u2CvDE/6NV5BdgPijYkFgRlZcoiZhsHhjbSdmwh1GmCIPk3CNesF1PSfRfQL/99tOfWHxf8t2y5620Nh2S9vZq3TCdp5UF1abInwqAI4Au0nAR92UGsh8iVAnNcYpheC89fk6eGYCQ8yAW2/H8f6HGjngtdaVUerpq/2X61k226t2/56xkrCxlVAJZoYIXAW8ucd0FSooGw5Z2mDXPoY//3iK3CZbaF5XFUzM5Q0CtlIC94yDDndEhwNQAjUZZNuGZDrj4M8jSBiDtA8BDaXurXuficKN2OfAjgZxRni6Yzw==
Received: from ex04.beckhoff.com (172.17.5.170) by ex07.beckhoff.com
 (172.17.5.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 3 Dec
 2024 17:07:31 +0100
Received: from ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3]) by
 ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3%6]) with mapi id
 15.01.2507.039; Tue, 3 Dec 2024 17:07:31 +0100
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "clg@redhat.com" <clg@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 2/9] vfio/igd: align generation with i915 kernel driver
Thread-Topic: [PATCH v2 2/9] vfio/igd: align generation with i915 kernel driver
Thread-Index: AQHbRYhUSLwVVMUlPk2MnzaOgk/5K7LUnxQA
Date: Tue, 3 Dec 2024 16:07:30 +0000
Message-ID: <95fb9b1b28df08722fbc62816a7e65eb8654cf2c.camel@beckhoff.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
 <20241203133548.38252-3-tomitamoeko@gmail.com>
In-Reply-To: <20241203133548.38252-3-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.130.158]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-vg0IvDPEnzOY/gVjsOu+"
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

--=-vg0IvDPEnzOY/gVjsOu+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2024-12-03 at 21:35 +0800, Tomita Moeko wrote:
> =EF=BB=BFCAUTION: External Email!!
> Define the igd device generations according to i915 kernel driver to
> avoid confusion, and adjust comment placement to clearly reflect the
> relationship between ids and devices.
>=20
> The condition of how GTT stolen memory size is calculated is changed
> accordingly as GGMS is in multiple of 2 starting from gen 8.
>=20
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> =C2=A0hw/vfio/igd.c | 44 ++++++++++++++++++++++----------------------
> =C2=A01 file changed, 22 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 6ba3045bf3..2ede72d243 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -59,33 +59,33 @@
> =C2=A0 */
> =C2=A0static int igd_gen(VFIOPCIDevice *vdev)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 if ((vdev->device_id & 0xfff) =3D=3D 0xa84) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 8; /* Broxton */
> +=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0 * Device IDs for Broxton/Apollo Lake are 0x0a84=
, 0x1a84, 0x1a85, 0x5a84
> +=C2=A0=C2=A0=C2=A0=C2=A0 * and 0x5a85
> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0 if ((vdev->device_id & 0xffe) =3D=3D 0xa84) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 9;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0

I'd slightly prefer matching those ids explicitly. At some point it may eve=
n
make more sense to copy the pciids of Linux and reuse them [1].

Note that this is just a suggestion!

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/inc=
lude/drm/intel/i915_pciids.h?h=3Dv6.12

> =C2=A0=C2=A0=C2=A0=C2=A0 switch (vdev->device_id & 0xff00) {
> -=C2=A0=C2=A0=C2=A0 /* SandyBridge, IvyBridge, ValleyView, Haswell */
> -=C2=A0=C2=A0=C2=A0 case 0x0100:
> -=C2=A0=C2=A0=C2=A0 case 0x0400:
> -=C2=A0=C2=A0=C2=A0 case 0x0a00:
> -=C2=A0=C2=A0=C2=A0 case 0x0c00:
> -=C2=A0=C2=A0=C2=A0 case 0x0d00:
> -=C2=A0=C2=A0=C2=A0 case 0x0f00:
> +=C2=A0=C2=A0=C2=A0 case 0x0100:=C2=A0=C2=A0=C2=A0 /* SandyBridge, IvyBri=
dge */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 6;
> -=C2=A0=C2=A0=C2=A0 /* BroadWell, CherryView, SkyLake, KabyLake */
> -=C2=A0=C2=A0=C2=A0 case 0x1600:
> -=C2=A0=C2=A0=C2=A0 case 0x1900:
> -=C2=A0=C2=A0=C2=A0 case 0x2200:
> -=C2=A0=C2=A0=C2=A0 case 0x5900:
> +=C2=A0=C2=A0=C2=A0 case 0x0400:=C2=A0=C2=A0=C2=A0 /* Haswell */
> +=C2=A0=C2=A0=C2=A0 case 0x0a00:=C2=A0=C2=A0=C2=A0 /* Haswell */
> +=C2=A0=C2=A0=C2=A0 case 0x0c00:=C2=A0=C2=A0=C2=A0 /* Haswell */
> +=C2=A0=C2=A0=C2=A0 case 0x0d00:=C2=A0=C2=A0=C2=A0 /* Haswell */
> +=C2=A0=C2=A0=C2=A0 case 0x0f00:=C2=A0=C2=A0=C2=A0 /* Valleyview/Bay Trai=
l */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 7;
> +=C2=A0=C2=A0=C2=A0 case 0x1600:=C2=A0=C2=A0=C2=A0 /* Broadwell */
> +=C2=A0=C2=A0=C2=A0 case 0x2200:=C2=A0=C2=A0=C2=A0 /* Cherryview */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 8;
> -=C2=A0=C2=A0=C2=A0 /* CoffeeLake */
> -=C2=A0=C2=A0=C2=A0 case 0x3e00:
> +=C2=A0=C2=A0=C2=A0 case 0x1900:=C2=A0=C2=A0=C2=A0 /* Skylake */
> +=C2=A0=C2=A0=C2=A0 case 0x5900:=C2=A0=C2=A0=C2=A0 /* Kaby Lake */
> +=C2=A0=C2=A0=C2=A0 case 0x3e00:=C2=A0=C2=A0=C2=A0 /* Coffee Lake */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 9;
> -=C2=A0=C2=A0=C2=A0 /* ElkhartLake */
> -=C2=A0=C2=A0=C2=A0 case 0x4500:
> +=C2=A0=C2=A0=C2=A0 case 0x4500:=C2=A0=C2=A0=C2=A0 /* Elkhart Lake */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 11;
> -=C2=A0=C2=A0=C2=A0 /* TigerLake */
> -=C2=A0=C2=A0=C2=A0 case 0x9A00:
> +=C2=A0=C2=A0=C2=A0 case 0x9A00:=C2=A0=C2=A0=C2=A0 /* Tiger Lake */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 12;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> @@ -258,7 +258,7 @@ static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 gmch =3D vfio_pci_read_config(&vdev->pdev, IGD_G=
MCH, sizeof(gmch));
> =C2=A0=C2=A0=C2=A0=C2=A0 ggms =3D (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
> -=C2=A0=C2=A0=C2=A0 if (gen > 6) {
> +=C2=A0=C2=A0=C2=A0 if (gen >=3D 8) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ggms =3D 1 << ggms;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> @@ -668,7 +668,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, i=
nt
> nr)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Determine the size of stolen memory needed fo=
r GTT */
> =C2=A0=C2=A0=C2=A0=C2=A0 ggms_mb =3D (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
> -=C2=A0=C2=A0=C2=A0 if (gen > 6) {
> +=C2=A0=C2=A0=C2=A0 if (gen >=3D 8) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ggms_mb =3D 1 << ggms_mb=
;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0

Reviewed-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>

--=-vg0IvDPEnzOY/gVjsOu+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmdPLMIACgkQ2FTaVjFe
AmqNJQ//deEwVsL3FWHW6XdGf7RbqMRPlhT1XnM2Un2xuhACSAn3tXWaXPvhN3rq
C3RTUDGyzC4k1tFhhJRL0lladzriIOx/6v6vpz1kfyS2AZZyUHT+kH4qOyA9pgXf
+/2/yhpnA2QEZ8hJ+McBQuCld5MiIQ6IU/XGw+KlYCRfhX4fKrraBkUZQSvP50qz
2ivkcuf5nt8anPneC4cmdNpIs0YcXk6+zqNGaoqK0+1KC843OxkmS0NRwgT4n/m/
bkqO/QZwvN+hYeDen8G+ZRto7nB4p1IX0uF95TErXXdHe3Yi3adg299OEFPQubvQ
i3Ibm8CIiUi2W2OSBdYjrck+ah17czy0QzvKsDqHxyEU1gPliJlOs5fgT+BueDSo
ibTPalJJJBO4xJf/pWqJvnjoAATna9U8YzlbFC9EAriJdAkpm/DRcZ30V1EIkCOj
FC6HN4KOUflFf1YOoPM+2luyN5yLU512s+FRaWTnx/wu1hMyKfqRxbr4WhFwlkXh
8E6iwecFtuUR+rIfb2S+xzmoGNPJYWOQ2nxl1x1aGldQ8kD2POxYKiakamV/iATL
xH/9KTt4rSpgMaltl7jLkS+1+Qcw+AWltE+ZwasHJK91+Y45mD6ruOaghBzYaZru
tv8tW29t70k61AVESW6wBIhKFo4LxM+vR4kA3d1mbE65KkU4Fi0=
=ckVD
-----END PGP SIGNATURE-----

--=-vg0IvDPEnzOY/gVjsOu+--


