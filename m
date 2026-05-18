Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799DECD4F48
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsZj-0000iw-Ng; Mon, 18 May 2026 03:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1wOsZY-0000Yp-I4; Mon, 18 May 2026 03:39:35 -0400
Received: from mx08-0090a401.pphosted.com ([66.159.246.175])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1wOsZW-0002gG-FZ; Mon, 18 May 2026 03:39:32 -0400
Received: from pps.filterd (m0463075.ppops.net [127.0.0.1])
 by mx08-0090a401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64I5CPdu1805690; Mon, 18 May 2026 07:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beckhoff.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=mail2022r; bh=UqGcXjgm7gqHXEvVsAKh1+Qf
 8IQAGN/OVMKgOjxRie0=; b=H9VwExOYEwXmGpKZ9DgDxCN4Y+BsqcwxiDD8HSzV
 4zSZ/80Nva7xARi1QP0uTpmiySCOZWBdtum/tft8Or49nYa8BHWbD/dRUnwi4YQx
 Jw0MlYgEvA7RiusGqZGKkrXP/L3jEu1SBt6HtIyNHj+KiqVnSW81V793uLn+ooqg
 g5snE0OxhZKmngen6CGFFixf5A6NsOaYf3uqWEnMmQ6Ys11OhNFdbOBDRAA6/51h
 P3uDVZjXZZlnKa6YPGEAAzR4HotXzdEqin1Q+MuHQ5/aFfuV/Nr3kEij3P7O3mko
 wmh+qLvEwZXL5WVYlHhETD/+JnV7MdY6EFaPG8MXkZ6zDg==
Received: from ex14.beckhoff.com ([62.159.14.12])
 by mx08-0090a401.pphosted.com (PPS) with ESMTPS id 4e743thmrd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2026 07:39:24 +0000 (GMT)
Received: from ex10.beckhoff.com (172.17.2.111) by ex14.beckhoff.com
 (172.17.3.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 18 May
 2026 09:39:23 +0200
Received: from ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b]) by
 ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b%12]) with mapi id
 15.02.2562.035; Mon, 18 May 2026 09:39:23 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "alex.bennee@linaro.org" <alex.bennee@linaro.org>
CC: "hreitz@redhat.com" <hreitz@redhat.com>, "alistair@alistair23.me"
 <alistair@alistair23.me>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "edgar.iglesias@gmail.com"
 <edgar.iglesias@gmail.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 =?utf-8?B?WWFubmljayBWb8OfZW4=?= <Y.Vossen@beckhoff.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 00/15] hw/arm: add Beckhoff CX7200 board
Thread-Topic: [PATCH v5 00/15] hw/arm: add Beckhoff CX7200 board
Thread-Index: AQHcZQFHPSNPcPq7EEaJLYF/Bl03xLVTXiHygMDpOAA=
Date: Mon, 18 May 2026 07:39:23 +0000
Message-ID: <421fc251f1f167cf095b7683ea41ccfe48474c20.camel@beckhoff.com>
References: <20251204093502.50582-1-corvin.koehne@gmail.com>
 <87wm1jhzkb.fsf@draig.linaro.org>
In-Reply-To: <87wm1jhzkb.fsf@draig.linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.129.38]
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="=-vEKY4l0sik4wNDkY8j84"
MIME-Version: 1.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA3MiBTYWx0ZWRfX0aycHlKEeCLp
 3p6O9NC470u7IkcVOf6nuqeXJby2sXDHfwoLmWHxR8HncaKJ/Dr0pDBLLt0IOu/9AVV3jZD2nsr
 HfMu1VoM2lT+kqKs2NufvzMxdOFwIjFMcQPo9JgPotSn42gBjIo2uWzYw0dAmRSyxtR2lqKHcbJ
 WnbYdmZ/5wkg68GpSqfGc1NzT36OeocrE7oPgFdzREk3OErRav3pnULB5NxPp9pU37GAZUQlwbd
 6eeA/RVK+FYrYTZ4DtR2RSaO68uM27kjuRoXe4GlN4+60nWez5399xYTKk31e47ut/7fi6m4KWO
 Bn3lmfztgD9Ofe1ZFybBkTcD7d7tQ2XF6NfoZspZp4tsCWSIxhxfQUFjTKdOo17+pg/TiARv+Lf
 d4b4w7TlVH2c1JSp1MU0vg5AqIqTlJ1M9tESO3BgDQwCiKbUoqTdekeZrSSf1x9Vt8mEpUR1d/l
 5JP8f9S0gNFU8+M4Dkw==
X-Proofpoint-GUID: AvO3ZgUCG7fSp_ReVsdX_8WMlzHSPLlC
X-Proofpoint-ORIG-GUID: AvO3ZgUCG7fSp_ReVsdX_8WMlzHSPLlC
X-Authority-Analysis: v=2.4 cv=CaU4Irrl c=1 sm=1 tr=0 ts=6a0ac22c cx=c_pps
 a=ZkhbYXbYXnnsONUOWLo3Bg==:117 a=ZkhbYXbYXnnsONUOWLo3Bg==:17
 a=xqWC_Br6kY4A:10 a=zoJHxBl5aBcA:10 a=NGcC8JguVDcA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=a9bgyBvlNMQzFU9Z5g25:22 a=pEnWR6l_7HET9bmtpPat:22
 a=NEAV23lmAAAA:8 a=Cmw_MBCVAAAA:8 a=pGLkceISAAAA:8 a=uWXjGa5q-P-bnwGHkEMA:9
 a=QEXdDO2ut3YA:10 a=xEm3df6wRxaQY7_TQgUA:9 a=FfaGCDsud1wA:10
 a=ZJSrCmYe3mwGoKZA4Vko:22
Received-SPF: pass client-ip=66.159.246.175;
 envelope-from=C.Koehne@beckhoff.com; helo=mx08-0090a401.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--=-vEKY4l0sik4wNDkY8j84
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Thu, 2026-01-15 at 11:42 +0000, Alex Benn=C3=A9e wrote:
> Corvin K=C3=B6hne <corvin.=E2=80=8Akoehne@=E2=80=8Agmail.=E2=80=8Acom> wr=
ites: > From: Corvin K=C3=B6hne
> <c.=E2=80=8Akoehne@=E2=80=8Abeckhoff.=E2=80=8Acom> > > Hi, > > Beckhoff h=
as build a board, called
> CX7200, based on the Xilinx Zynq A9 > platform. This commit series adds
> =C2=A0
> Corvin K=C3=B6hne <corvin.koehne@gmail.com> writes:
>=20
> > From: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
> >=20
> > Hi,
> >=20
> > Beckhoff has build a board, called CX7200, based on the Xilinx Zynq A9
> > platform. This commit series adds the Beckhoff CX7200 as new board vari=
ant
> > to
> > QEMU.
> >=20
> > The emulation is able to successfully boot an CX7200 image. The image
> > includes
> > some self tests executed on every boot. Only the cache self test fails =
due
> > to
> > QEMU emulating the cache as always being coherent. The self tests inclu=
de
> > f.e.:
> >=20
> > * Network
> > * Flash
> > * CCAT DMA + EEPROM [1]
> > * TwinCAT (Beckhoff's automation control software [2])
> >=20
> > [1] https://github.com/beckhoff/ccat=20
> > [2] https://www.beckhoff.com/en-us/products/automation/=20
>=20
> Is it possible to host a binary build somewhere so there can be a
> functional test?
>=20
>=20

Sry for the quite late response. There's currently no binary build publicly
available. We're planning to release one but things are moving (very) slowl=
y.


--=20
Best regards,
Corvin



This email contains confidential information. If you have received it in er=
ror, you must not read, use, copy or pass on this e-mail or its attachments.
If you have received the e-mail in error, please inform me immediately by r=
eply e-mail and then delete this e-mail from your system. Thank you

Diese E-Mail enth=C3=A4lt vertrauliche Informationen. Sollten Sie sie irrt=
=C3=BCmlich erhalten haben, d=C3=BCrfen Sie diese E-Mail oder ihre Anh=C3=
=A4nge nicht lesen, verwenden, kopieren oder weitergeben.
Sollten Sie die Mail versehentlich erhalten haben, teilen Sie mir dies bitt=
e umgehend per Antwort-E-Mail mit und l=C3=B6schen Sie diese E-Mail dann au=
s Ihrem System. Vielen Dank

Beckhoff Automation GmbH & Co. KG=20
Managing Director: Dipl. Phys. Hans Beckhoff
Registered office: Verl, Germany=20
Register court: Guetersloh HRA 7075

DisclaimerID:x9d5u140


--=-vEKY4l0sik4wNDkY8j84
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmoKwioACgkQ2FTaVjFe
AmrYpw//UFGiZduvi+ZpxOwZiudToe8hWMB1wZY3lg1z73aUqpTM1cCOcctl76De
eQJXYYiTs9eiokjjZ8p81aoOQun3hfgadmHTjVMTB4I0fG79Wv1PtlHJSNyFK39i
dOyM4Fu3PNputJgtdEY6RLBUBnhDW+PAUcacw+/RpdVzdBvtpRhN+E0e9MoEj8Os
glrsmF1gqCBskq0hifleK80ebgT0mYy2m6PIeAw7DSNWuKxXPkkF5MqE8AAl7Rqj
K6qlg9I8lsic8S7hPsrFqfgqxbVyjLh61oygpJG29Y5bIhKheHRLKEUUx7FUP4re
adzCsvmJY6ck8JuOO0+IoFY7NLC7wA0kNhgP8wrok0xwO9qEy6uqDKEFdBXfj2+W
7D5mVl6rnVO/JI5TS+RBt7172myPEm3HVXk7gwSevgL3HyB8KTFx1HP8aPzyYXEh
mo3yJI7ipY9bFQiV6qe1aMCYjA4tcE9jENWjuZmqvinPU2TvaldtbA8cmhnftqYB
CHDi4K3b2lTaj9tpdabW3jrS5yJW/wb7QN5NX3PbXiqYYBZ3/JE8YM2TSQ3FEoSD
J3yxFzEFeiU7PysOcD8dKgTTJP4Fk0irSnsJB7f+cZQ3ydHUzJy/hTsy99FAVInG
VWLdg8vnCPmjIxhbXHUzUd0uhbtamxHrnLRdD3HO1in0GUnzAIQ=
=HOzq
-----END PGP SIGNATURE-----

--=-vEKY4l0sik4wNDkY8j84--

