Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC3FC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 08:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrYE-0004Xe-5V; Mon, 05 May 2025 04:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBrY9-0004Rv-J0
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:51:47 -0400
Received: from internet2.beckhoff.com ([194.25.186.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBrY7-0003a2-NQ
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:51:45 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1746435102; bh=xQrf2n0azY6cvPfjBc/AdvDNNb4eHCfDqQ9yDjZ8TC4=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 9wBUpJmNRIRXil+m2W59m+Tl4AfaVDl8EsY8QzDneBNIS1BaI+35ICyBDdsK7K7Pn0I2Sy0hMTpVajP7644/BQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1746435102; bh=xQrf2n0azY6cvPfjBc/AdvDNNb4eHCfDqQ9yDjZ8TC4=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 L8hAONdscCnIs2DjFRNmV5abway1H0emm6i8jygbfpVYxxz4BQoYnV09nzj1MDw51M3m4SKnVFezKeXvhCjWLCuSbmAAdoWeYgy5XD+/hfNiwFW+Rear4q3FE+TeRFx91GpCB58zapRNNAZloy9yiVC+g43mj7zyUreAgzf+YqqOxWuNre2ultbMizKdplEaeIDVtJaw3z91/+LhUtV2DoWKpniLUik8N+zAb6j5q1m1crKKuGQ+eMP2hkhVFIBoyeq8G6Sl72QcMfgX8Km0hA2d3bknHyzSsJUbgX5QvIWYU7WOb4PKQ1m1GZ7PFjEg75MoF4TVjzccwt0DSyE+qg==
Received: from 172.17.6.19 by INTERNET2.beckhoff.com
 (TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384); Mon, 05 May 2025 08:51:42 GMT
Received: from ex10.beckhoff.com (172.17.2.111) by ex13.beckhoff.com
 (172.17.6.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 May
 2025 10:51:41 +0200
Received: from ex10.beckhoff.com ([fe80::3762:2101:fb4e:8ffa]) by
 ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b%12]) with mapi id
 15.02.1748.010; Mon, 5 May 2025 10:51:41 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 6/9] vfio/igd: Enable OpRegion by default
Thread-Topic: [PATCH 6/9] vfio/igd: Enable OpRegion by default
Thread-Index: AQHbuFgZI3dZbvunJ0WooYa+gq15g7PDo52A
Date: Mon, 5 May 2025 08:51:41 +0000
Message-ID: <b143206fc9d5ce383d7bcf26082fb0449993414a.camel@beckhoff.com>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
 <20250428161004.35613-7-tomitamoeko@gmail.com>
In-Reply-To: <20250428161004.35613-7-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.62.149]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-PmgpEN1sCyupGMSOjgP0"
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

--=-PmgpEN1sCyupGMSOjgP0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-04-29 at 00:10 +0800, Tomita Moeko wrote:
> =EF=BB=BFCAUTION: External Email!!
> As the presence of OpRegion is used to detect IGD device now, and
> guest driver usually depends on OpRegion to work. Enable OpRegion
> on IGD devices by default for out-of-the-box passthrough experience
> (except pre-boot display output), especially for libvirt users.
>=20
> Example of IGD passthrough with libvirt:
> <hostdev mode=3D"subsystem" type=3D"pci" managed=3D"yes">
> =C2=A0 <source>
> =C2=A0=C2=A0=C2=A0 <address domain=3D"0x0000" bus=3D"0x00" slot=3D"0x02" =
function=3D"0x0"/>
> =C2=A0 </source>
> =C2=A0 <rom file=3D"/path/to/igd/rom"/>
> =C2=A0 <address type=3D"pci" domain=3D"0x0000" bus=3D"0x00" slot=3D"0x02"=
 function=3D"0x0"/>
> =C2=A0</hostdev>
>=20
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> =C2=A0docs/igd-assign.txt | 4 ++--
> =C2=A0hw/vfio/pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A02 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
> index 95beb76812..fc444503ff 100644
> --- a/docs/igd-assign.txt
> +++ b/docs/igd-assign.txt
> @@ -102,7 +102,7 @@ digital formats work well.
> =C2=A0
> =C2=A0Options
> =C2=A0=3D=3D=3D=3D=3D=3D=3D
> -* x-igd-opregion=3D[on|*off*]
> +* x-igd-opregion=3D[*on*|off]
> =C2=A0=C2=A0 Copy host IGD OpRegion and expose it to guest with fw_cfg
> =C2=A0
> =C2=A0* x-igd-lpc=3D[on|*off*]
> @@ -124,7 +124,7 @@ Examples
> =C2=A0
> =C2=A0* Adding IGD with OpRegion and LPC ID hack, but without VGA ranges
> =C2=A0=C2=A0 (For UEFI guests)
> -=C2=A0 -device vfio-pci,host=3D00:02.0,id=3Dhostdev0,addr=3D2.0,x-igd-le=
gacy-mode=3Doff,x-
> igd-opregion=3Don,x-igd-lpc=3Don,romfile=3Defi_oprom.rom
> +=C2=A0 -device vfio-pci,host=3D00:02.0,id=3Dhostdev0,addr=3D2.0,x-igd-le=
gacy-mode=3Doff,x-
> igd-lpc=3Don,romfile=3Defi_oprom.rom
> =C2=A0
> =C2=A0
> =C2=A0Guest firmware
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 05a7a62204..38ff231625 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3361,7 +3361,7 @@ static const Property vfio_pci_dev_properties[] =3D=
 {
> =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BIT("x-req", VFIOPCIDevice, features=
,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VFIO_FEATURE_ENABLE_REQ_BI=
T, true),
> =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice,=
 features,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VFIO_FEATURE_ENABLE_IGD_OPREGION=
_BIT, false),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VFIO_FEATURE_ENABLE_IGD_OPREGION=
_BIT, true),
> =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BIT("x-igd-lpc", VFIOPCIDevice, feat=
ures,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VFIO_FEATURE_ENABLE_IGD_LP=
C_BIT, false),
> =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_ON_OFF_AUTO("x-igd-legacy-mode", VFI=
OPCIDevice,

Reviewed-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>


--=20
Kind regards,
Corvin

--=-PmgpEN1sCyupGMSOjgP0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmgYfBsACgkQ2FTaVjFe
AmroDQ/9GhsvUbpHlczZL55/FegMp5UO8ecAEfbd6uBfBn+bORY3xHHzKJ8NPJC3
M0I5E/qVdQ2GxmmWWDjN717lfsLXvxQTyxVQhwpP6HAO9iipCBh0DSDL8fgqA71g
MEVKf+3axuBi7kPdjD8QEICNTH0XkEGiFFufGA1UbaHzYPpLHg2yEEAkgvEtpeH0
6GZs3/zTnEHE0PAcR2oa2VZth3bjdMbkhkc8ISggtYppsR9d7O8WVU5LwwQefC1M
yFfNwF4X5A+I9UYmAKRiMWtQkdePLzHx09sh0ZYmgr13gz9sQ4FP+DTxO60y81DJ
em837gFTVx+GmYXDB0NMSf5fV/go3TTLNB3QI0Kvan2VG6Wh2JE9PLvDrcjRH1QT
idDyuvYWhbkuybzv5ZPuQ9nPjn/YCwhKWt7WOAMzLlRQPj7xHLQ0mhbQ42xpyYf/
9tmutNetARfgLjN4iZ0Gk9W9eDQPmDQ/qi2e5iRDtcMbkcq0jmjwcRyKzejPFHU1
xUSoZ+GUMdCD1zLij3cf62iT92WztrE6CHvxQepB/uJkwYEU3MtQmq6ja//lylRf
RT5l7n2P+3+s2BqeHuE3tcYUjFVX5Yv48BZeSaRVLMH+mVwcVqcWqqbjicc4YShr
mtJZfGu9m+7T1BqtxnpcCYU2Yz0to+d/rRM4RfJlxQT2QVPGm74=
=TAfy
-----END PGP SIGNATURE-----

--=-PmgpEN1sCyupGMSOjgP0--


