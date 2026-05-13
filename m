Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1873CD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 21:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNH64-0002TF-Q8; Wed, 13 May 2026 17:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wNH60-0002Sq-Cr; Wed, 13 May 2026 17:26:27 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wNH5y-0003at-Ru; Wed, 13 May 2026 17:26:24 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 471A560132;
 Wed, 13 May 2026 21:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F71C2BCB8;
 Wed, 13 May 2026 21:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778707581;
 bh=zpYGD7Xc+hVyrs3ZopjGwb16E8bTEpLTB476W/YDV4Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T5WhfpVOxNZMG+5wbvNTpYMuvA6bKVi7zEVsDtNHaQ0ICcBFHiojzRC8P9NtGT8v5
 VjVbHMg86BDNFZX7n2xhmC3f8fuC4gxxUaf2ztB5CPyWL2OClCYPcFK+KfgkwkayAM
 W4+dEBxAlnFu/3jTWI1x7/VkRBOTcuuUFaAXLoMWLmdn9IQs+tSnqBi3SJ5+IjzFwK
 zTT+w5sGhredf7dgKrUSrN+zevMn9sga/nBzL7DqQof/HnVYqvomm2/acypX+7ZPYO
 5FhHJmUWw+POaRAX/v3oUyTGfM2RMYQJOOLu3ik32kPrhW+tvuTglwIG6f5SJL6z64
 WoJYKR/zyzpmg==
Date: Wed, 13 May 2026 22:26:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: alistair23@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, sebastian.huber@embedded-brains.de,
 Alistair Francis <alistair.francis@wdc.com>,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] MAINTAINERS: Mark Microchip PolarFire SoC as Odd Fixes
Message-ID: <20260513-pampers-threaten-2a71df36e314@spud>
References: <20260513023859.518484-1-alistair.francis@wdc.com>
 <82b83672-24b9-40d1-9a19-89fd64c0606f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4zmLo4qGwoin1ar5"
Content-Disposition: inline
In-Reply-To: <82b83672-24b9-40d1-9a19-89fd64c0606f@linaro.org>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=conor@kernel.org;
 helo=tor.source.kernel.org
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


--4zmLo4qGwoin1ar5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 08:10:06AM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 13/5/26 04:38, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >=20
> > Mark the "Microchip PolarFire SoC Icicle Kit" as Odd Fixes and enlist
> > Conor and Sebastian as people to help deal with the fixes.
> >=20
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > Conor let me know if it should be a different address
> >=20
> >   MAINTAINERS | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 952ed683bb..9626eb1ea9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1751,8 +1751,10 @@ F: target/riscv/xlrbr.decode
> >   F: tests/tcg/riscv64/test-crc32.S
> >   Microchip PolarFire SoC Icicle Kit
> > +M: Conor Dooley <conor@kernel.org>
> > +M: Sebastian Huber <sebastian.huber@embedded-brains.de>
>=20
> Maybe worth having a look at Guenter's following patch for this
> machine:
> https://github.com/groeck/qemu/commit/1a66d5b4e5fe9

Ye, I can do that. It looks mostly pretty sane, but needs a bit of
cleanup I think before it is really applicable.

Does it matter if the rates the PLLs report are accurate btw? Since
everything here is emulated, it shouldn't matter if the PLLs run say all
at 100 MHz instead of one at 100 and one at 40, right? They're just used
to clock things like i2c or pwm controllers.

--4zmLo4qGwoin1ar5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagTsYgAKCRB4tDGHoIJi
0kN4AQCKRdejjgdz3zav/WYhruke6A3xhjYCYXfMZSiSEEpStwD+PCzaVGZXk8rp
l+vXh7LKdBbrCPaTbjtNnc4yeSgVowQ=
=geip
-----END PGP SIGNATURE-----

--4zmLo4qGwoin1ar5--

