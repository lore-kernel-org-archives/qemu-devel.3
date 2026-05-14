Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A4CCD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 10:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNSr2-0006ck-A1; Thu, 14 May 2026 05:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wNSr1-0006cW-B0; Thu, 14 May 2026 05:59:43 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wNSqy-0002Kv-Rs; Thu, 14 May 2026 05:59:43 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6B5F540845;
 Thu, 14 May 2026 09:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8D5C2BCB3;
 Thu, 14 May 2026 09:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778752778;
 bh=b41AWW7glvaYZU/utq+DgCmbkoQ885N1s/Y1UDwzXh4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qvYalj6cCLDIqLARJQnvi2Kjdv0V89RDrxLJVTFpRJyn8MpoH+J9HoRAVJKLBc73z
 HcG3tSwRXjfl64QMVXxvwXqpxYXGGYSN9UVNewZlnFMdS8CQx4+wjK808j/njb+4tV
 IANZZ6GdXeumQDZZM/f0gjn5QCoEHz/Df+ZGrwHbAq6/DKJgtW323bb3fcACmClJnV
 7lQISEe9HWJ9xHx2HwdEu44RpYbIffmlK4TA6j0+TDURMCI2UXBeVBox8lMOgTi3uv
 yG3E1UYRLMnm3Sn/r7nkkcJ5dMpP97CZn8WnKgOWXRchABziVMq5it2enU8Vbu3wL+
 hG4XR3ZOhvJ5g==
Date: Thu, 14 May 2026 10:59:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 palmer@dabbelt.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, sebastian.huber@embedded-brains.de,
 Alistair Francis <alistair.francis@wdc.com>,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] MAINTAINERS: Mark Microchip PolarFire SoC as Odd Fixes
Message-ID: <20260514-flatly-gallantly-00579d38db65@spud>
References: <20260513023859.518484-1-alistair.francis@wdc.com>
 <82b83672-24b9-40d1-9a19-89fd64c0606f@linaro.org>
 <20260513-pampers-threaten-2a71df36e314@spud>
 <CAKmqyKN5Tjwuy+S+NzEN0Xpsv_U7rQSM=PtvAkNNuhgA_oaRXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="REBQpQu2SmLqP/OA"
Content-Disposition: inline
In-Reply-To: <CAKmqyKN5Tjwuy+S+NzEN0Xpsv_U7rQSM=PtvAkNNuhgA_oaRXQ@mail.gmail.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=conor@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--REBQpQu2SmLqP/OA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 09:54:43AM +1000, Alistair Francis wrote:
> On Thu, May 14, 2026 at 7:26=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Wed, May 13, 2026 at 08:10:06AM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
> > > On 13/5/26 04:38, alistair23@gmail.com wrote:
> > > > From: Alistair Francis <alistair.francis@wdc.com>
> > > >
> > > > Mark the "Microchip PolarFire SoC Icicle Kit" as Odd Fixes and enli=
st
> > > > Conor and Sebastian as people to help deal with the fixes.
> > > >
> > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > ---
> > > > Conor let me know if it should be a different address
> > > >
> > > >   MAINTAINERS | 4 +++-
> > > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 952ed683bb..9626eb1ea9 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -1751,8 +1751,10 @@ F: target/riscv/xlrbr.decode
> > > >   F: tests/tcg/riscv64/test-crc32.S
> > > >   Microchip PolarFire SoC Icicle Kit
> > > > +M: Conor Dooley <conor@kernel.org>
> > > > +M: Sebastian Huber <sebastian.huber@embedded-brains.de>
> > >
> > > Maybe worth having a look at Guenter's following patch for this
> > > machine:
> > > https://github.com/groeck/qemu/commit/1a66d5b4e5fe9
> >
> > Ye, I can do that. It looks mostly pretty sane, but needs a bit of
> > cleanup I think before it is really applicable.
> >
> > Does it matter if the rates the PLLs report are accurate btw? Since
>=20
> You know the hardware better than us. Generally if it allows the guest
> boot and the values are sane then that's probably fine

In that case, there's very little that needs doing with it IMO.
Dropping this one line here is probably sufficient:
https://github.com/groeck/qemu/commit/1a66d5b4e5fe9#diff-9d9266aa5117a927ed=
a2de5ec50e77c41664adfbf48599ffaa58c9e7def28d0dR98-R116

I'll test that out and see.

>=20
> Alistair
>=20
> > everything here is emulated, it shouldn't matter if the PLLs run say all
> > at 100 MHz instead of one at 100 and one at 40, right? They're just used
> > to clock things like i2c or pwm controllers.
>=20

--REBQpQu2SmLqP/OA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagWdBQAKCRB4tDGHoIJi
0ijpAP9wWtaN2Qd+cEXFxV0UbFuPl2YyMBhii/dMv1tIDKJnAwD/R8LS5uFS1fxB
18WpQD4zaW4SYjycUBlpi09fKEfIDwE=
=8syB
-----END PGP SIGNATURE-----

--REBQpQu2SmLqP/OA--

