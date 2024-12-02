Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87489D78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 14:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI7B7-0007x3-60; Mon, 02 Dec 2024 09:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tI2H0-00044Y-VG
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 03:59:19 -0500
Received: from internet2.beckhoff.com ([194.25.186.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tI2Gy-0003bp-QI
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 03:59:18 -0500
Received: from 172.17.2.168 by INTERNET2.beckhoff.com (Tls12, Aes256, Sha384, 
 DiffieHellmanEllipticKey384); Mon, 02 Dec 2024 08:54:13 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1733129653; bh=vNL4Z/RQbLtLFIUwLJZtL6mXrEakOIUI+B6p95Xjf+Y=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 PBPqvsrD+s8qD5B6TWt2wbeqES8OPndrcNQtMSuzK3QURwU3kuQPUODhb9iDyaYy2P9c4eunvXHPt9xo8EOnCA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1733129653; bh=vNL4Z/RQbLtLFIUwLJZtL6mXrEakOIUI+B6p95Xjf+Y=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 G1y6Y6lQVQ+fVGsQ1aT9r5CsnigEP+pQ/EcEowe6Gdi4ZFlbFP/8tjxEd9mWdsBy4p57vGsCpSCKBCSSQbvrUccC+gXyki4aaX7TNFSvG1ZVDXUwt+vmT1o+q+gCcWqLVfbBWbJvVQtkcsEsq7RCj2zamFl9qQbBPmN5RWpwcORqJvRVNzTINFoXGZIvZcfUsuJvYp1V25fi6Ytka3hwT8g3/+P8sK9qrT3eLwYGZAtnAzPT6BYl/Xlz5A1f7JZhcJKeKnFYqNklVggtD0VlQDoa5tmZHwn+GeXoRbycm6wd39ESm3keiZhGkX/ZM4VUVyxHFHP0WU7NSuE3rj0cQw==
Received: from ex04.beckhoff.com (172.17.5.170) by ex01.beckhoff.com
 (172.17.2.168) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 2 Dec
 2024 09:54:12 +0100
Received: from ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3]) by
 ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3%6]) with mapi id
 15.01.2507.039; Mon, 2 Dec 2024 09:54:12 +0100
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "clg@redhat.com" <clg@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>
Subject: Re: [PATCH 1/8] vfio/igd: fix GTT stolen memory size calculation for
 gen 7
Thread-Topic: [PATCH 1/8] vfio/igd: fix GTT stolen memory size calculation for
 gen 7
Thread-Index: AQHbRAt0pZjG6z7nuk6EZNf0+Qbb4LLSlqkA
Date: Mon, 2 Dec 2024 08:54:11 +0000
Message-ID: <91d12b8330698cd65ad2f24406efd34e8d5cd4a2.camel@beckhoff.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
 <20241201160938.44355-2-tomitamoeko@gmail.com>
In-Reply-To: <20241201160938.44355-2-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.130.225]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-CjWXpUZbR+fNxA1DmlCQ"
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

--=-CjWXpUZbR+fNxA1DmlCQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-12-02 at 00:09 +0800, Tomita Moeko wrote:
> =EF=BB=BFCAUTION: External Email!!
> Both intel documentation [1][2] and i915 driver shows GGMS represents
> GTT stolen memory size in multiple of 1MB, not 2MB starting from gen
> 8.
>=20
> [1]
> https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/3=
rd-gen-core-desktop-vol-2-datasheet.pdf
> [2]
> https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4=
th-gen-core-family-desktop-vol-2-datasheet.pdf
>=20
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> =C2=A0hw/vfio/igd.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 4047f4f071..e40e601026 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -268,7 +268,7 @@ static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 gmch =3D vfio_pci_read_config(&vdev->pdev, IGD_G=
MCH, sizeof(gmch));
> =C2=A0=C2=A0=C2=A0=C2=A0 ggms =3D (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
> -=C2=A0=C2=A0=C2=A0 if (gen > 6) {
> +=C2=A0=C2=A0=C2=A0 if (gen > 7) {

This seems odd. The commit message talks about gen 8 but it changes the
behaviour for gen 7 only. Additionally, ggms_mb is still shifted for gen
8 and later, so it's still increment by steps of 2 MB. Shouldn't this be
something like gen < 8?

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ggms =3D 1 << ggms;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> @@ -678,7 +678,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice
> *vdev, int nr)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Determine the size of stolen memory needed fo=
r GTT */
> =C2=A0=C2=A0=C2=A0=C2=A0 ggms_mb =3D (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
> -=C2=A0=C2=A0=C2=A0 if (gen > 6) {
> +=C2=A0=C2=A0=C2=A0 if (gen > 7) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ggms_mb =3D 1 << ggms_mb=
;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0

Btw. you could consider adding a link to the source code of i915 too.


--=20
Kind regards,
Corvin
disable-disclaimer-BADE

--=-CjWXpUZbR+fNxA1DmlCQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmdNdbQACgkQ2FTaVjFe
AmqnVA/+PD4zj+fqOjtNAb1IXvE8Kn5vj0TDPuYJZGRu+2aUg/ltRYGLiywTOlmQ
G63PueD/y09u6YT2ExhJoPpVMh/uUPOLoNiWpwOsGwnJ6D8v6tDTuhAqWIDArOP3
HUiOGgZTxp7he0lMY2vpFC/1r2G7ZMSu0E6THqdStmnVjv40ZWStlgsxQ9H/lDrA
pi1Gc4LKSgxDHNCeCZW8WPEeVkN2REOVngAlW/Gih+/h6RPQgSocU07MZByEuvmq
pEnqjqJzz22EAD1SI1qtguUZjdRwxtgKhfOeXMkjrF5vPrm5QXXCLdRAYU2jOhQd
TDUCH1Ls1KaEqbGr6uYiK2NVh5HD41cCckGA1yx86vUhERUE53S2G4kqKXltm7vg
fHfmpMdaWj7HiRrSAUKAiV40cyb7JPhVuIVOTtrkK5yALRmABD1evg1wgylwxgzl
syCx+HjZgz30y5Whp8DjI3JSwzP5Pv+tYlqSvnhUa793ym25YvOcAMFVwnnll8YB
TJey0CISH0ajjkjGu//Ymn/9uu2Q40kfNnyBBKoEkDxK24qNTin3DcDtXumzU7L4
7C7kKEk9utNPcuLNcTkUOorrPpfMCenQ6flLj4oamqLhh9HIDx7HxdjN7YqbproP
UbEauqTNzn41nC1iDFoUeCA9lgaoCIxEexrZb1ze6Oyn5lyRqRw=
=t1GF
-----END PGP SIGNATURE-----

--=-CjWXpUZbR+fNxA1DmlCQ--


