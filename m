Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE375C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 08:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrPZ-0007wK-5j; Mon, 05 May 2025 04:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBrPV-0007uY-Lk
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:42:49 -0400
Received: from internet2.beckhoff.com ([194.25.186.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBrPT-0002Sh-3g
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:42:49 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1746434563; bh=VPMsXHEYa9B5d45kdpG2CvQ2WZuik1Yv0yFAuqmblI0=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 cj/S5Zh8X5VWhfv+5DtR8RlqbdGhbhvpGVZuMU2B6jV234+Z8kzMBbUnmWrm8R48s/rAIzMmahfhx2KH+AnoAA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1746434563; bh=VPMsXHEYa9B5d45kdpG2CvQ2WZuik1Yv0yFAuqmblI0=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 na3qPYrtvg0+hNBICh668LUq05brm2Yz56bwk73G9shfEfxg8fnIOoVbLM8dD9Exr9YyH9Ktzs6aa7Rq13ikQOES9NHKXFk17Bpu0ZwaxZraaDzRg1kHbIWVBYyUMVXvr/sctXG7U+T/ynAx1uXgqa2DNVsKS9EeCzXej90ijd47Kd4kkp/rDP6h80G6ScY2id43GTLIpG2y19vKGgm1CiWEaqmLXnhh8L4c+2D8/VSCHYGtX9YZUBeO6uu77txG4Q4N0d+xZBfCAbIUYkdj6lkrJOATzS6FQlebwxrnOeD9gz1jF9rRME6II2RwKBm6w5wMw2c/+F7qNwZvdcG4zg==
Received: from 172.17.6.17 by INTERNET2.beckhoff.com
 (TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384); Mon, 05 May 2025 08:42:43 GMT
Received: from ex10.beckhoff.com (172.17.2.111) by ex09.beckhoff.com
 (172.17.6.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 May
 2025 10:42:35 +0200
Received: from ex10.beckhoff.com ([fe80::3762:2101:fb4e:8ffa]) by
 ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b%12]) with mapi id
 15.02.1748.010; Mon, 5 May 2025 10:42:35 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/9] vfio/igd: Restrict legacy mode to Gen6-9 devices
Thread-Topic: [PATCH 1/9] vfio/igd: Restrict legacy mode to Gen6-9 devices
Thread-Index: AQHbuFgOmBZ4WgH5xk+uObMuUHIqGrPDoRKA
Date: Mon, 5 May 2025 08:42:35 +0000
Message-ID: <4781421b63032965326824850f34b90ad4b313ea.camel@beckhoff.com>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
 <20250428161004.35613-2-tomitamoeko@gmail.com>
In-Reply-To: <20250428161004.35613-2-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.62.149]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-NnHofdAOmi0e8dNUsXfS"
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

--=-NnHofdAOmi0e8dNUsXfS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-04-29 at 00:09 +0800, Tomita Moeko wrote:
> =EF=BB=BFCAUTION: External Email!!
> Intel only provides legacy VBIOS for IGD up to Gen9, and there is no
> CSM support on later devices. Additionally, Seabios can only handle
> 32-bit BDSM register used until Gen9. Since legacy mode requires VGA
> capability, restrict it to Gen6 through Gen9 devices.
>=20
> Link:
> https://nospamproxywebp.beckhoff.com/enQsig/link?id=3DBAgAAADAsHNi0zEFiak=
AAACORk589NFmMEL0IRdt7DRVpnoi_6WKuXqQANgyXom23JAMNMr3UlEVSZvZdOtespZyqyGqsg=
LV2z0x8MkoDwNY9VFWuoC1hAOa_kpJihDYFTkqJw9sxp1uw6X9Oml3OGmOnrY8bVlHo2n7h5uiu=
73mh7RdgB0cFnBy59ExBLmCowsh6nXK5LA_Udnf-WbH0pzMWtCwjhPF453hx1Rm93_KYzUhuysw=
u_sg0
> =C2=A0
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> =C2=A0docs/igd-assign.txt | 1 +
> =C2=A0hw/vfio/igd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++++-
> =C2=A02 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
> index 3aed7956d5..95beb76812 100644
> --- a/docs/igd-assign.txt
> +++ b/docs/igd-assign.txt
> @@ -47,6 +47,7 @@ Intel document [1] shows how to dump VBIOS to file. For=
 UEFI
> Option ROM, see
> =C2=A0
> =C2=A0QEMU also provides a "Legacy" mode that implicitly enables full fun=
ctionality
> =C2=A0on IGD, it is automatically enabled when
> +* IGD generation is 6 to 9 (Sandy Bridge to Comet Lake)
> =C2=A0* Machine type is i440fx
> =C2=A0* IGD is assigned to guest BDF 00:02.0
> =C2=A0* ROM BAR or romfile is present
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 6678e0e5cd..cecc3245b7 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -516,11 +516,13 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice
> *vdev, Error **errp)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * For backward compatibility, enable legac=
y mode when
> +=C2=A0=C2=A0=C2=A0=C2=A0 * - Device geneation is 6 to 9 (including both)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * - Machine type is i440fx (pc_piix)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * - IGD device is at guest BDF 00:02.0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * - Not manually disabled by x-igd-legacy-=
mode=3Doff
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0 if ((vdev->igd_legacy_mode !=3D ON_OFF_AUTO_OFF)=
 &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (gen >=3D 6 && gen <=3D 9) &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !strcmp(MACHINE_GET_CLAS=
S(qdev_get_machine())->family, "pc_piix") &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (&vdev->pdev =3D=3D pci_=
find_device(pci_device_root_bus(&vdev->pdev),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, PCI_DEVFN(0x2, 0)))) =
{
> @@ -565,7 +567,9 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *=
vdev,
> Error **errp)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vdev->features |=3D VFIO=
_FEATURE_ENABLE_IGD_LPC;
> =C2=A0=C2=A0=C2=A0=C2=A0 } else if (vdev->igd_legacy_mode =3D=3D ON_OFF_A=
UTO_ON) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(&err,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Machine is not i440fx or assigned BDF=
 is not 00:02.0");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Machine is not i440fx, assigned BDF i=
s not 00:02.0, "
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "or device %04x (gen %d) doesn't suppo=
rt legacy mode",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vdev->device_id, gen);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0

Afaik, at least the LPC quirk is required for Gen 10 and above for the GOP =
to
work properly. On the other hand, Intel hasn't published any GOP yet, so it
might be unlikely that user use it. So, not sure if this is a breaking chan=
ge or
not.

Besides that:

Reviewed-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>


--=20
Kind regards,
Corvin

--=-NnHofdAOmi0e8dNUsXfS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmgYefkACgkQ2FTaVjFe
AmpWow//Qbpu8iIHXvJQIZMDiSoZE9wa5HU+gsjzFopC4TnGslgRMrcuQc7SOEaV
u5yWEAg7n750ZDoSZyBtD0N0R38nW6+5nT/zg6OdfWtW2NbJfQ5F+GANT/cV03j+
+ZMbob4H1tjUk3sBeKN+AwbcIvG7SJsu3FnmZVMnTwb6gJ7IznAke8J8PLL2twsU
F3Pcgc14cglas4edhMQZ7ql0AOegAicdvirJ0AwUY0P4dmvVlvMul0QQKsgQKGaY
43mvrACDkWCL7jo2zq66oigTqQGFE+vbna5Dsfhv84JOxjEtTvkqz+HGxOjHbumF
zMrTYp4M3eow5whjVNz4aYsnn15RtcW00I8V94HwOXb79qiDBXb2P05KUc0mtg4H
FeEbCQXjmyy7oNkIeHUD6NAMuLSrYEHkKDdw81Hze7pakDO6cFOhIXfcqsdjEXHi
fAtsV6XQ8+qlO7FQk8lKGhgdYtoHJcPaUsQkz7vJ62zxuh9x0ofmPfW5wjp1L4/G
bWCLvlS/UG5Q2NFL9JY6nil12uaSug/Q+zTE9XaZUnwTWCVfzvbU6kV6VTzRfjTB
hLcuW3nhXuUcfp8S97i8inZOO8QhV7UlkJFOvFBmScBNM9Q4F3rYnAdnxGD7HA/R
zSPGBXn5eZKpBNT47xGVZVdQJq1and77ctTp6bFdn9ZOXuYcNQI=
=agyo
-----END PGP SIGNATURE-----

--=-NnHofdAOmi0e8dNUsXfS--


