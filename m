Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C434C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 08:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrQk-0000Fs-7E; Mon, 05 May 2025 04:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBrQS-00009F-6v
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:43:52 -0400
Received: from internet2.beckhoff.com ([194.25.186.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBrQQ-0002Xg-6T
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:43:47 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1746434623; bh=EQZjXnptKugQVRCuUneqyDg9xsAxEX1bSlEhEPDPCFw=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 +eqgQl9Voewx20wrrX8tAD71uVK2oUQ2ZUBwcygoHYtR0GqPetmicGYDqHoqAQkP1V4IN/llog0RsXjSoyC6Ag==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1746434623; bh=EQZjXnptKugQVRCuUneqyDg9xsAxEX1bSlEhEPDPCFw=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 jDSNDMHwM0R/KkRyXZ1Nc26A3v4UVKL7/ZwfPH/eGqQI8aRWOa84cDLScikLTJRzBU0ciwOVHxrkTwT6xAzgPs25zf2UeIEDJoP7T6GurB+/JZkWJrLCgiDpTH1VxE3NKR1YJcC2C3ImKwPeXnZMAcpOzTbF7j5d7bFhtBtM7gjPUteSksd8SGvDpJgljnLQC0xbUI6HK4lDMUU3h5rhaXnnn7gP018ZY99tzg3musUNdWRGHoQpr2Yt7XBUtwemtR9sZWxFVopJmdlv760hRZOJ+qhnMQ11DJ0Rb8Qig80Wytw70Q/y/DHvvry6FZPLxMwywIY3wlDBd2LBnUgzNA==
Received: from 172.17.3.7 by INTERNET2.beckhoff.com
 (TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384); Mon, 05 May 2025 08:43:43 GMT
Received: from ex10.beckhoff.com (172.17.2.111) by ex14.beckhoff.com
 (172.17.3.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 May
 2025 10:43:41 +0200
Received: from ex10.beckhoff.com ([fe80::3762:2101:fb4e:8ffa]) by
 ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b%12]) with mapi id
 15.02.1748.010; Mon, 5 May 2025 10:43:41 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/9] vfio/igd: Always emulate ASLS (OpRegion) register
Thread-Topic: [PATCH 2/9] vfio/igd: Always emulate ASLS (OpRegion) register
Thread-Index: AQHbuFgQWEpBCgFRI0WsOJiyNUcWELPDoWIA
Date: Mon, 5 May 2025 08:43:41 +0000
Message-ID: <067b7673179229acaea534a58421ac69fa93fe68.camel@beckhoff.com>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
 <20250428161004.35613-3-tomitamoeko@gmail.com>
In-Reply-To: <20250428161004.35613-3-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.62.149]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-ZmGeWQBMnooprOz/qLlJ"
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

--=-ZmGeWQBMnooprOz/qLlJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-04-29 at 00:09 +0800, Tomita Moeko wrote:
> =EF=BB=BFCAUTION: External Email!!
> ASLS register represents the base address of OpRegion, and it is
> programmed with HPA. In IGD passthrough scenario, it needs to be
> reprogrammed with GPA by guest firmware. To prevent guest accessing
> wrong memory range, ASLS should always be emulated and cleared.
>=20
> In GVT-g scenario, emulating ASLS is unnecessary as access is handled
> by kvmgt backend [1].
>=20
> [1]:
> https://nospamproxywebp.beckhoff.com/enQsig/link?id=3DBAgAAABJA62ZTEhCO9A=
AAABrY_qcw0M6GbfmA-k7rdTnC1V9Xvjw6ICEYmTbOt6IWZMsfh2X-PfG-_1bXLcfyp_Hlcdbse=
t-kq2osW-E9lPT94hoZN2NjovxXaqp2dueSyklxM-bP7ox1AHZkQJVv5lgR-iU3PuZeJMms5zmO=
uYd9fmL0ePbCC-bv9lN8VEaMAQWUFVb0pGt2t9WWfuMxqO6p0pmItn7Qhonu9rHCbBSelFWN9wb=
y1aKHKufBkSBgBiuN2lSz9nZ8WTeKQ8ifh8cfOhPiAsVRWSeVpNeuoyV0
> =C2=A0
>=20
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> =C2=A0hw/vfio/igd.c | 14 +++++++++-----
> =C2=A01 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index cecc3245b7..ae19456457 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -182,10 +182,6 @@ static bool vfio_pci_igd_opregion_init(VFIOPCIDevice
> *vdev,
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 trace_vfio_pci_igd_opregion_enabled(vdev-
> >https://nospamproxywebp.beckhoff.com/enQsig/link?id=3DBAgAAABJA62ZTEhCO2=
wAAADrv
> lj4V-SebC4SGxyCHAuiWIj2uPV-Sufmo150PAYs9nDhYSQLRd1-
> LAyUjMsdhaDDdO6n0SKd9uzKZMhYr5A8uAV__w527iEN3jptdWlJNyitq2eScjUl3HLAVTzhe=
EDnkr
> yTDojPqVjnFFk1=C2=A0);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
> -=C2=A0=C2=A0=C2=A0 pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
> -=C2=A0=C2=A0=C2=A0 pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~=
0);
> -
> =C2=A0=C2=A0=C2=A0=C2=A0 return true;
> =C2=A0}
> =C2=A0
> @@ -583,7 +579,15 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice
> *vdev, Error **errp)
> =C2=A0=C2=A0=C2=A0=C2=A0 if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_LP=
C) &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !vfio_pci_igd_setup_lpc_=
bridge(vdev, errp)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
> -=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0 * ASLS (OpRegion address) is read-only, emulate=
d
> +=C2=A0=C2=A0=C2=A0=C2=A0 * It contains HPA, guest firmware need to repro=
gram it with GPA.
> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0 pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
> +=C2=A0=C2=A0=C2=A0 pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
> +=C2=A0=C2=A0=C2=A0 pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~=
0);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Allow user to override dsm size using x-=
igd-gms option, in multiples
> of

Reviewed-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>


--=20
Kind regards,
Corvin

--=-ZmGeWQBMnooprOz/qLlJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmgYejwACgkQ2FTaVjFe
Amo4gBAAq7KPo75BM7aoZb4rKazfJuYmFBixjiq2mXxb6Y94luLCN9E6avM+Woa2
dmaaFtDNxx8qof+eNx7dQNDPRc8auG6Vm6+aegBJ1RmZNVR2ucdz9rE7f6S7ENWW
QRZ0EXOztfc7SNmiQboCBxldK7S/xe4o8F3xNmmaPa2TkhTb5An5SpMAXcHmVYDm
+/v4qCCSN+xKERdTYOLIoDm5lAzyFHqaETIBVCEads9M/h37IsUcFUYKiWtEUSI2
oUrg1ZC950w+XwiCVO6p9yd4Zb3zNGWNTQmDXAdG7y7gBqYd4Y8nGii5ANCZ+9VK
TWSF7mcsiI2fJg78P6OIP/LuigvD5Hy+31Q+FQAJbRtzFakHfHHKgxDUqSD5FSZH
6asrxo5oD1qblWNZ2cKmlYof2mq5DnlWmcR8VOoE1e8sydXkuomBGZKr5xPKghQS
FkqEV5ZeNf4gdheT3LOGnycDHOEuAkhj6In4lI1ESoS2DGjiGaOgi1d0/pSiuj/N
biCjx/Ul5RQH7Uvdw10CB4drnIjYCMgnwsZs54lZOhh/1mAJgLWEHSn7XzPZFzFv
FbWYc8WRPvBs1QG6LGaTVF4CuokFz1HpAe1ePnwVmbVfoRNu+Du2OMPXQtgYd2J3
mZLfhxWVD7V3a/2gobU0KUd83XRQHbwqf4YBZGWc9gw7Za/Jtl8=
=4mzv
-----END PGP SIGNATURE-----

--=-ZmGeWQBMnooprOz/qLlJ--


