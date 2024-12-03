Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB09E74AC3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 16:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIVo6-0007ij-CN; Tue, 03 Dec 2024 11:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tIVns-0007hc-QD
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 11:31:14 -0500
Received: from netsrv01.beckhoff.com ([62.159.14.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tIVnq-0000A2-Fa
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 11:31:12 -0500
Received: from 172.17.5.170 by netsrv01.beckhoff.com (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Tue, 03 Dec 2024 16:30:57 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1733243457; bh=k5A8LeEF2I6jPC9H+0sOfYCj4UvAWkDcDmbCVcEVRSI=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 2b7bIuKCD1iRUqqq16dn/h4Fv8Rr37VqmwTh18JSRZkH1+RDkaFATwU4h5Fw6pXbY3MYjmmTwH/Tt9VEiTyRDw==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1733243457; bh=k5A8LeEF2I6jPC9H+0sOfYCj4UvAWkDcDmbCVcEVRSI=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 DF7hT7Sg9RS2nUIjc0V1iQ8Toe8QOME2r/+nQARqxSOkUuo5qyS52K3HIse8+8iYGU62kN0kceieQL1I5YvDAJ/OShzJCZjxg195Wz9AgsVcQZpQwjDLfSMHK0EKSCN/8bZePPEmhjpc+eiQXV3ACtSu3inu+fNkc6oKZ2L6UHO9RywzDvbBerLvYRpvVQz08/YhyhUio57Hsvr2MNKjTPflPLFcr1Pmk+5c/SN5b78t23jTFQzHwzIEle6IslTUbY/aBIasp3Kl08mA9zVBdU/fECxhcEjfSWypkTGfKo7wTU/J9ZH8oINNv7tQLFD7tEjk2Ax3klmZXUqxqoWEtQ==
Received: from ex04.beckhoff.com (172.17.5.170) by ex04.beckhoff.com
 (172.17.5.170) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 3 Dec
 2024 17:30:56 +0100
Received: from ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3]) by
 ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3%6]) with mapi id
 15.01.2507.039; Tue, 3 Dec 2024 17:30:56 +0100
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "clg@redhat.com" <clg@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 9/9] vfio/igd: add x-igd-gms option back to set DSM
 region size for guest
Thread-Topic: [PATCH v2 9/9] vfio/igd: add x-igd-gms option back to set DSM
 region size for guest
Thread-Index: AQHbRYhddLgSIFSlVECr5GhAxaeGIbLUpaAA
Date: Tue, 3 Dec 2024 16:30:56 +0000
Message-ID: <fb3afcb5ea495e96c6aa9e657cb413ab47c15026.camel@beckhoff.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
 <20241203133548.38252-10-tomitamoeko@gmail.com>
In-Reply-To: <20241203133548.38252-10-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.130.158]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-3kqb/cyjPnardjAdCREO"
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

--=-3kqb/cyjPnardjAdCREO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2024-12-03 at 21:35 +0800, Tomita Moeko wrote:
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

It might be worth linking the commit which has removed x-igd-gms and mentio=
n
that the behaviour changed slightly. Previously, the DSM region size was se=
t to
0 if x-igd-gms was unset. This patch keeps the host value if x-igd-gms is u=
nset.

> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> =C2=A0hw/vfio/igd.c | 17 +++++++++++++++++
> =C2=A01 file changed, 17 insertions(+)
>=20
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index e464cd6949..0814730f40 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -717,6 +717,23 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, =
int
> nr)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk,=
 next);
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0 * Allow user to override dsm size using x-igd-g=
ms option, in multiples
> of
> +=C2=A0=C2=A0=C2=A0=C2=A0 * 32MiB. This option should only be used when t=
he desired size cannot be
> +=C2=A0=C2=A0=C2=A0=C2=A0 * set from DVMT Pre-Allocated option in host BI=
OS.
> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0 if (vdev->igd_gms) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gen < 8 && vdev->igd_gms =
<=3D 0x10) {

This doesn't work as intended for values larger than 0x10. For those values=
,
qemu ignores the generation and set GMS as it would be a gen 8 or later dev=
ice.

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

--=20
Kind regards,
Corvin

--=-3kqb/cyjPnardjAdCREO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmdPMkAACgkQ2FTaVjFe
Ampcgg/9GH2Hqy3M2Rk5wON6PDiu/Wbgy2POh5ZURwiujzDGI7imEmLdHNK048AT
MHZVLtn9ki82EbyM7gAxd79FFn4FfK3rRgehcPD/DRoxEytspli8LEERPvygugnR
NEMRkGUu3Ht9YwFVyUF6P+9mq23ISXh6k9dS6TcsXp3/Ldk0ARHVg8mU8DbUHLfC
hzYWTZRjt4yL5M++m6eXPOc9pOiH81CUWyN0K6wjlnwlhvyKPsXQBNlu3wvqpF4u
mDXPpApxVAj9RlRGd3+VSh7yDNxBcvc7QQONyjC556cqzYnB6pDoAIqYQ/9oYpuh
3/Xca8liOddO6m90JiatfKEu5bMVFOJYXh5xPqmmT4usXjsMNO6yGwrJSSCHMwoR
x5feVGncvj4z+5P/vd5pT++kUYSSc9RcbLqLbUYbj6bY52fuWiAuxSJC8Vcf3QxZ
2gNDCtN9Mm+7aITsDFDgJVUF+sU44DSfBBiDSMqeYkr9qnIP1N65n1ZQyluRRtrc
e+pTAGfE7XXnVC4ChVm9O6+KVwwS/Ek2Y/1wpvEQuYCGVt1tIb4XcdKVzX8GxzgW
HC/o5MY8GsbtsGJ4UJCLdeB1R1bKphySet6vnXWnVhEFvrHRBU1wIPD81woUufcD
Wp9B9EmmEyJ7ghLs76/iuvdW5bkMCRVzHZ/6Yvl2WVNpkXDn+gw=
=3XJW
-----END PGP SIGNATURE-----

--=-3kqb/cyjPnardjAdCREO--


