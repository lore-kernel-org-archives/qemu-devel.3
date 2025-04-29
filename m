Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0BFC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eTM-0003pi-Qi; Tue, 29 Apr 2025 02:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1u9eSl-0003TH-0E
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:29:09 -0400
Received: from internet2.beckhoff.com ([194.25.186.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1u9eSj-0007Fd-0m
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:29:02 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1745908136; bh=LIte8/oLofGXljTDHq4wMHRHYs/P2O7OACNFLvS/zA4=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 U/+XwinajvqzVjuLk3ImQpHPManm+4Zf0uc88+Ip07pVPkNVxI1150kDdWf+XrPGPnZSeU1pCsGXCLaJLWEFDA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1745908136; bh=LIte8/oLofGXljTDHq4wMHRHYs/P2O7OACNFLvS/zA4=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 OxZi3ZZnxBIOsLWa9/qFoi8t+yxGMsHAqKy/FvABhhNf6u+R5mmwppwIEjx+3+k6lw0o9xkdtipEkgx3wtpFxSY1lqDwhKM0PcyA6SPRnxpwLeBKPQr36ZNOtrjXK2ZCBTO7KRqs1bV5uVB4/I1h8KzUd1eibXzAO0DXEHQ7nCQ7JclikJ83fgmMjEg2/F7+hZqxRrIvOPqJBlV21VKQdi4K3AbLJU0h/F+vEYMfmtIJI6iiGsnnOGNn2gAFTpe3Ehx4VhF6TNSRyzldFqM72uO//X3kO9O+Iy6Neq+5x5wR6wRSBRtJ14k0/h0WPTPKInDpSPaiFHsKrvhk6r0m9g==
Received: from 172.17.3.7 by INTERNET2.beckhoff.com
 (TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384); Tue, 29 Apr 2025 06:28:56 GMT
Received: from ex10.beckhoff.com (172.17.2.111) by ex14.beckhoff.com
 (172.17.3.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 29 Apr
 2025 08:28:55 +0200
Received: from ex10.beckhoff.com ([fe80::3762:2101:fb4e:8ffa]) by
 ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b%12]) with mapi id
 15.02.1748.010; Tue, 29 Apr 2025 08:28:55 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 8/9] vfio/igd: Only emulate GGC register when x-igd-gms is
 set
Thread-Topic: [PATCH 8/9] vfio/igd: Only emulate GGC register when x-igd-gms
 is set
Thread-Index: AQHbuFgfypfvonHOrUuwJtuFtfUFZrO6DbyA
Date: Tue, 29 Apr 2025 06:28:55 +0000
Message-ID: <806ee35261d6e032b5b06bffa419f941dc3a8a4e.camel@beckhoff.com>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
 <20250428161004.35613-9-tomitamoeko@gmail.com>
In-Reply-To: <20250428161004.35613-9-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.62.149]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-q54A07ZJYbogOUiHna1t"
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

--=-q54A07ZJYbogOUiHna1t
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-04-29 at 00:10 +0800, Tomita Moeko wrote:
> =EF=BB=BFCAUTION: External Email!!
> x-igd-gms is used for overriding DSM region size in GGC register in
> both config space and MMIO BAR0, by default host value is used.
> There is no need to emulate it in default case.
>=20
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>=20

Is the GGC register writeable after UEFI or is it locked? If it's writable,=
 I'm
wondering what might happen if the guest writes to the GGC register to incr=
ease
DSM region size.


--=20
Kind regards,
Corvin

--=-q54A07ZJYbogOUiHna1t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmgQcaUACgkQ2FTaVjFe
Amqafg/8C8TOUZE4GNN052LW0Q5WkQXbm58WCKbFMr2Shha96Ppqewsv/KqlbbVU
aKY7e7nX7nwEUSsx+NJbTc6ywZJBsR8ZNTCWQDYOQ7r0Soms0RflEYAKRoRwfXZ/
+VSyaiHjoemjnB+fJcFXauBHM+JW6zHmWW6RpeiWErodxhPwPUoms5HdzaVbVLQ7
fYYMEq5zh73/t9pTvHWRwBUfH9CdTVud6oN2VFDBxp570ie28E8XTsXvU2cv2od0
N5aFD2PdFH/zT7oTfXJyzWUe6Cve9H/sj4pz2IKe7F6XLeaWCfRoK4C7wLxKRkUe
fH0NwxUN7O4EK3RdKbygAMMcDVl4IZTpOCBPxCyRIUCoe7WPr8fMaNT6AgQ/Hzsa
y/WOc2de/08oGEsRnydFVEDq94LbwRtypy4rUJAedu6J4RBePmzU4TGy234I4VmP
/IftyVInnFCis4bEhIm+9+MWK+I5ifYk/ecCvPZshN+4f72Z6rxjmfaOdl3xHE03
VuuqWzwp6vcl8NSbU9cNWlbtf/9R4gqT+o34wYhDzGC4aXa0xsHEeJnOn6xIRO5o
z9ADfNvg5eVV4hO0Z3YQ5c1nq0y5EzkZWdHx6uEqy9sAxhT4YkHc53i0O+E5pz4E
Zhe0AM+xvczMkQmEWHF7UJezivqNm84xIKe/iHata1MF4LeX8JQ=
=TyRi
-----END PGP SIGNATURE-----

--=-q54A07ZJYbogOUiHna1t--


