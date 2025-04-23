Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EE2C369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7UWc-0007wH-DT; Wed, 23 Apr 2025 03:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1u7UW8-0007FI-4y
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:27:38 -0400
Received: from netsrv01.beckhoff.com ([62.159.14.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1u7UW4-0001oc-LD
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:27:35 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1745392889; bh=Rr34iC+98xOWhR3eHesDXdZMCMjic/PQpKmV4GVKNpA=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 /10gXPS+Rpi+rY7zx2PWFZ3v9Hd1JFj/YtGgf8WZDpbjZFOLsr9BMVhSsQGX3hnKr0L2i1nxTQmEqDDmshiRAg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1745392889; bh=Rr34iC+98xOWhR3eHesDXdZMCMjic/PQpKmV4GVKNpA=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 SLF4wwbpPX9Et1d9cy6iT5AgZ87UqZLSRVxffyDvQxohMc7cG1Po7ca/uKFGrzzAAIXulTLuZM0yuIOwHhnjyuyNlbv9tfpsZBVvzoD7TXT8Gtjui+yZUa8uv3VdzXcJam/M2ChrdA2uYdwju3YCXmYj1Q4rgnTcDhQfsZiSJxsGLegHq/4Aytg65XPB1lyZkY9WOk6+/YbhRt7Csl+LoTZu9UTanIrJbvESOukMDLn6RzouElmQFMw46iBq7M4KngAHojJiruV467wJh1vNm4UagAM6zWELSDPkTZFY5y3F884KqBJLNT+9ExhgosORsSTJg5lo2lFHjJG52MjJlw==
Received: from 172.17.6.17 by netsrv01.beckhoff.com
 (TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384); Wed, 23 Apr 2025 07:21:28 GMT
Received: from ex02.beckhoff.com (172.17.5.63) by ex09.beckhoff.com
 (172.17.6.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 23 Apr
 2025 09:21:20 +0200
Received: from ex04.beckhoff.com (172.17.5.170) by ex02.beckhoff.com
 (172.17.5.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 23 Apr
 2025 09:21:16 +0200
Received: from ex04.beckhoff.com ([fe80::d02e:4c24:89d8:a7a3]) by
 ex04.beckhoff.com ([fe80::d02e:4c24:89d8:a7a3%6]) with mapi id
 15.01.2507.039; Wed, 23 Apr 2025 09:21:16 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 11/11] vfio/igd: Update IGD passthrough documentation
Thread-Topic: [PATCH 11/11] vfio/igd: Update IGD passthrough documentation
Thread-Index: AQHbstsAJ5LTlz2MWkG9Q3Oa3549hrOwuVMA
Date: Wed, 23 Apr 2025 07:21:16 +0000
Message-ID: <6390a892e59771a899871038521bd6d2637835c8.camel@beckhoff.com>
References: <20250421163112.21316-1-tomitamoeko@gmail.com>
 <20250421163112.21316-12-tomitamoeko@gmail.com>
In-Reply-To: <20250421163112.21316-12-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.62.149]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-R3N0LbEowIx50V+HmIGi"
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

--=-R3N0LbEowIx50V+HmIGi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-04-22 at 00:31 +0800, Tomita Moeko wrote:
> CAUTION: External Email!!
> In previous commits, several changes were made to IGD passthrough:
> * Legacy mode now requires the IGD to be Gen6=E2=80=93Gen9.
> * OpRegion quirk is enabled by default.
> * "etc/igd-bdsm-size" is set to 0 when guest firmware does not need to
> =C2=A0 allocate Data Stolen Memory and write BDSM register.
> Update the documentation to reflect these changes.
>=20
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> =C2=A0docs/igd-assign.txt | 11 +++++++++--
> =C2=A01 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
> index 3aed7956d5..eac31ea3dd 100644
> --- a/docs/igd-assign.txt
> +++ b/docs/igd-assign.txt
> @@ -47,6 +47,7 @@ Intel document [1] shows how to dump VBIOS to file. For=
 UEFI
> Option ROM, see
> =C2=A0
> =C2=A0QEMU also provides a "Legacy" mode that implicitly enables full fun=
ctionality
> =C2=A0on IGD, it is automatically enabled when
> +* IGD generation is 6 to 9 (Sandy Bridge to Comet Lake)=20
> =C2=A0* Machine type is i440fx
> =C2=A0* IGD is assigned to guest BDF 00:02.0
> =C2=A0* ROM BAR or romfile is present
> @@ -101,7 +102,7 @@ digital formats work well.
> =C2=A0
> =C2=A0Options
> =C2=A0=3D=3D=3D=3D=3D=3D=3D
> -* x-igd-opregion=3D[on|*off*]
> +* x-igd-opregion=3D[*on*|off]
> =C2=A0=C2=A0 Copy host IGD OpRegion and expose it to guest with fw_cfg
> =C2=A0
> =C2=A0* x-igd-lpc=3D[on|*off*]
> @@ -123,7 +124,7 @@ Examples
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
> @@ -156,6 +157,12 @@ fw_cfg requirements on the VM firmware:
> =C2=A0=C2=A0=C2=A0 it's expected that this fw_cfg file is only relevant t=
o a single PCI
> =C2=A0=C2=A0=C2=A0 class VGA device with Intel vendor ID, appearing at PC=
I bus address
> 00:02.0.
> =C2=A0
> +=C2=A0=C2=A0 Starting from Meteor Lake, IGD devices access stolen memory=
 via its MMIO
> +=C2=A0=C2=A0 BAR2 (LMEMBAR) and removed the BDSM register in config spac=
e. There is
> +=C2=A0=C2=A0 no need for guest firmware to allocate data stolen memory i=
n guest address
> +=C2=A0=C2=A0 space and write it to BDSM register. Value of this fw_cfg f=
ile is 0 in
> +=C2=A0=C2=A0 such case.
> +
> =C2=A0Upstream Seabios has OpRegion and BDSM (pre-Gen11 device only) supp=
ort.
> =C2=A0However, the support is not accepted by upstream EDK2/OVMF. A recom=
mended
> =C2=A0solution is to create a virtual OpRom with following DXE drivers:

Not sure how upstream prefers handling documentation. Those are only small
changes, so I'd add them to the corresponding commits.


--=20
Kind regards,
Corvin

--=-R3N0LbEowIx50V+HmIGi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmgIlOQACgkQ2FTaVjFe
AmpgtQ//SpBkew0x9sjrLDj+CY8Vbw3DJGuJvz7b63s8n7YazBkImTi/p5AP96EE
1lquzowYewNAkCvCQ3ZUL8kAw5qpsSpcx+4PmZIZf8zCNQEx1xvBbTcLxINxxOIL
mYiZrgnybhr84GqW1sAyrc3F7S7c9Aef/9FIO3eAoRtuJo7nmzrIbdZhs5pv+u/L
C3IL8k6RmV3AKNy5KPpQ4XGU4LerCZ43RtM57WhK6otCzaIqtMbDLPXxNHUQ5tIg
mIDuXsFo9S/TrdJML6d//jbmPPRo3tK17XCrDwEjgWp7+wO73sg9iOyfPEecjUhC
VgvHcoyT8S7Jy4932LubusGRPtsm599+RdhKlsVT2LQ/SxH5HClma5a/MD51SnpH
6iLWkXUO0HQA6noMbtCTNoNnNGvAPHb4MX2dVNj3yZmIbPD2uNnmTn2OsLdZtyZX
jNhq9OHFhUo9EdjG1pnftWZmwuNQVasZGi3lzp6boe6Z0AupUKFVNzH+tw54wpN/
+FI5NO96qX0lb+on9j7vTZATuj+shr41qcpi/jT1PdK1qIMmdX1ZYdFwXDtVvD0E
0nb5J7MmHwMpbGpIE965qLF2VIbAjTEHn37J+htKH2HuEwvGsU9/r4ae8Nwp1x2Q
h6sJKo12zoNYPUaLlTlZ81LIW4SISQY8qimJ/HjT5GIHa/l/2NI=
=kG/A
-----END PGP SIGNATURE-----

--=-R3N0LbEowIx50V+HmIGi--


