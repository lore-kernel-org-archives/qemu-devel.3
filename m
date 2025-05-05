Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00594C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrhF-0000sy-P4; Mon, 05 May 2025 05:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBrhC-0000s9-HV
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:01:07 -0400
Received: from internet2.beckhoff.com ([194.25.186.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBrhA-00059s-7N
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:01:06 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1746435662; bh=dUeCWjSsAKI4X2G4Rtr/7CFIwB6ociNrRe/ukQ+pkYQ=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 mOiSuWOjL7A7NWzmbRzW7r1DLFhl9Bog0nf3q7sm4HZl1Ie+aMrjC2kZCE4zeLrcXgaUkQppf/ESXHkZIdgQCA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1746435662; bh=dUeCWjSsAKI4X2G4Rtr/7CFIwB6ociNrRe/ukQ+pkYQ=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 G9zVQMKweArfQOANjx2+4ZicylB9lB5+bGIVO9dLmGUVN/hvlvW6ffUQt62xNlClDF3U3w0NZ+AhjdO4rLAZPlfINjerhIHBfjrZ6yyyVsXpJYV1ZLRbFCBztu9JFI5FKu1RAf9eRKXTjMlr7qVsLYUK6aGa3JaO8PYOJEW/xWopWPGmVZDZo1BkUGb0qOHF+Fc2E5qu2LaFsC+KJgiX96oR7w7xEHtEmosDAl14y97JijGfTcnHeXErXBxj0eTWO7/gHuaP4FKlCVjRkkly8aQkX8mCM0ihUvxhVUXAGjPE2a5GdGkNOtxpSnQxOisM9oYLHLO5VVOlUcq9HRokoA==
Received: from 172.17.6.17 by INTERNET2.beckhoff.com
 (TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384); Mon, 05 May 2025 09:01:01 GMT
Received: from ex10.beckhoff.com (172.17.2.111) by ex09.beckhoff.com
 (172.17.6.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 May
 2025 11:01:00 +0200
Received: from ex10.beckhoff.com ([fe80::3762:2101:fb4e:8ffa]) by
 ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b%12]) with mapi id
 15.02.1748.010; Mon, 5 May 2025 11:01:00 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>
CC: =?utf-8?B?WWFubmljayBWb8OfZW4=?= <Y.Vossen@beckhoff.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "alistair@alistair23.me" <alistair@alistair23.me>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
Subject: Re: [PATCH 09/21] hw/misc: Add dummy ZYNQ DDR controller
Thread-Topic: [PATCH 09/21] hw/misc: Add dummy ZYNQ DDR controller
Thread-Index: AQHbmAcxfuzxPG0yy0uSfOogPp6ZurO0sVoAgA81fwA=
Date: Mon, 5 May 2025 09:01:00 +0000
Message-ID: <ae05465c5abf5049424242d089b7a984c988f93a.camel@beckhoff.com>
References: <20250318130817.119636-1-corvin.koehne@gmail.com>
 <20250318130817.119636-10-corvin.koehne@gmail.com>
 <aAu8MIQTmTPoRjIm@zapote>
In-Reply-To: <aAu8MIQTmTPoRjIm@zapote>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.62.149]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-+pETYegAOq3y8GhFK0Vq"
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

--=-+pETYegAOq3y8GhFK0Vq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-04-25 at 18:45 +0200, Edgar E. Iglesias wrote:
> CAUTION: External Email!!
> On Tue, Mar 18, 2025 at 02:08:00PM +0100, Corvin K=C3=B6hne wrote:
> > From: YannickV <Y.Vossen@beckhoff.com>
> >=20
> > A dummy DDR controller for ZYNQ has been added. While all registers are
> > present,
> > not all are functional. Read and write access is validated, and the use=
r
> > mode
> > can be set. This provides a basic DDR controller initialization, preven=
ting
> > system hangs due to endless polling or similar issues.
> >=20
> > Signed-off-by: Yannick Vo=C3=9Fen <y.vossen@beckhoff.com>
> > ---
> > =C2=A0hw/misc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 3 +
> > =C2=A0hw/misc/
> > https://nospamproxywebp.beckhoff.com/enQsig/link?id=3DBAgAAADa4z1g3ukVn=
moAAAAr
> > l_jkhWbCv_PHtUJpY7yEY601k79a77UyCbfaGco2JPpcaCOybQdhjR0cGnyWEZqCNC3PiEC=
WlYa1
> > 3TZ7D5x6Yi5GY1Ud-M0zCSTuJ2WblH0OX92Mv4EAFobjbqz_a8r85TtpkZfrrOoa0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1
> > +
> > =C2=A0hw/misc/zynq_ddr-ctrl.c | 331 +++++++++++++++++++++++++++++++++++=
+++++
> > =C2=A03 files changed, 335 insertions(+)
> > =C2=A0create mode 100644 hw/misc/zynq_ddr-ctrl.c
> >=20
> > diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> > index ec0fa5aa9f..1bc4228572 100644
> > --- a/hw/misc/Kconfig
> > +++ b/hw/misc/Kconfig
> > @@ -222,4 +222,7 @@ config IOSB
> > =C2=A0config XLNX_VERSAL_TRNG
> > =C2=A0=C2=A0=C2=A0=C2=A0 bool
> > =C2=A0
> > +config DDR_CTRLR
>=20
> I suggest XLNX_ZYNQ_DDRC ?
>=20
> And name the file accordingly, e.g xlnx-zynq-ddrc.c.
>=20
> You may also want to consider using the register API, see for example
> hw/misc/xlnx-versal-xramc.c, modelling another memory controller.
>=20
>=20

Thanks for the hint. Will take a look into it.


--=20
Kind regards,
Corvin

--=-+pETYegAOq3y8GhFK0Vq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmgYfkoACgkQ2FTaVjFe
AmoOfg//fbRARHbL7fUklSF4n3ucDAiWKKtumkasDyui/r2NT4xnELcsAmYykaxy
2XvkXzj0OzhaPfN3ZUqLqnbnss67rfqiUIwg1a1RylYCrFhyY+/rhVwkwF4XwWI1
/4cHJjWg4fPzXHfEBi9aA9NUyvuNnEedE8L9NS6TPYt6Pb33p4TRAtOGEYKSmjvh
6qJnu6sb23Wbc+mDjevWWnPjw7CCDmHoSNQBdLeqpa9NWoI8qnBjO9vMb0Z2Ppat
Fp0m/uRueez/r7dAsdh36ovh5FgFbaLahb7dDvBYGIbtKUIawX0/vle3oAfhZUdS
cBksIrLLcQTOyy9LTAwmItVL/aePmv+1jNSRe6g32988vnI3GwrSey7MfwTa8Pop
/HhPNRax0INqoNrhsIJZdJlgf8K/juAbsrWt6bAO7TRm5snM1yziavRdFIu1YooB
LAhIbIyhd/wudglR2h2vmbzDQMlJJ5nSmSGZyTXXuZ0uIBNN+1RqhGtvPMmMp7Io
aQ73KfyzaCYU8wOKU7j07EdrEhxYVI4dxPKbMRJ09oNoij1adDiMNviRimVxHvwJ
J+WoZtcSD+VjWuyMq3FUAgeO7svVCmZnCXXKysfBatF6a5Z5EHjYSzJX+bqv1aqy
XVxMBemH8+nFLwqqdkt9lENJkFsuxO4eKJqrYg63YL1JwJuREcI=
=M5IA
-----END PGP SIGNATURE-----

--=-+pETYegAOq3y8GhFK0Vq--


