Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472CFCD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 09:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKvOc-00024Q-JY; Thu, 07 May 2026 05:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wKvOW-000249-FR; Thu, 07 May 2026 05:51:48 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wKvOU-0005gh-To; Thu, 07 May 2026 05:51:48 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 60DAF418CF;
 Thu,  7 May 2026 09:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79211C2BCB2;
 Thu,  7 May 2026 09:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778147503;
 bh=RMm2dQ0X7CR6zI2nNSIjYpECgAHDTi6azh7SeT60qus=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VQzr/neG7CCYtxZsopVHOvCqIdJOYyzNx2IHumqUyW+xQOpZBtswH/v/weSPddlcl
 3aMUa+7Pfyv6pVq6KwYaFbDWEuhLyGpjO/whTimCnGYfrdj/WMAKihpbwsib/2eWCh
 445hseuYoo/xmzdOUQ8Wco4HMjKfebz6wnM84JcZmoWyGFaSfTOTea9LkHbgvlSHT5
 BuyA+8GaEZN0TiIftLCQAEeVHgfkFOGsXY9LAurkHRKVOvkr4iax8FAFv84xNvCS8T
 J7vzoknojHh+EvafmDUCu85QvwEFcJGEm8DAeYNJHjNEBpcAtNbvfM/JS6MQRFJNoM
 +CaE6uLtZ83Ag==
Date: Thu, 7 May 2026 10:51:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 integration@gluster.org, Zhao Liu <zhao1.liu@intel.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Mark Kanda <mark.kanda@oracle.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Glenn Miles <milesg@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Ben Chaney <bchaney@akamai.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: MAINTAINERS entries that aren't S: Orphan but maybe should be
Message-ID: <20260507-zoning-jovial-9d340aa043c7@spud>
References: <87y0hwbvbp.fsf@pond.sub.org>
 <CAKmqyKMC0jxMMV0RuPHZrwBbsAeHhOvM+Ak_+=hGgM1C8eeUxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Mew+wDqXUhKeAUOc"
Content-Disposition: inline
In-Reply-To: <CAKmqyKMC0jxMMV0RuPHZrwBbsAeHhOvM+Ak_+=hGgM1C8eeUxA@mail.gmail.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=conor@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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


--Mew+wDqXUhKeAUOc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026 at 09:40:55AM +1000, Alistair Francis wrote:
> On Wed, May 6, 2026 at 10:03=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
> >
> > I'm cc'ing reviewers and lists mentioned below, and frequent
> > contributors to MAINTAINERS.
> >
> > There are a number of MAINTAINERS entries with S: other than "Orphan"
> > without M:
> >
> >     $ awk '/^M: / { m++ } /^S: / { s=3D$2 } /^$/ && s { if (!m && s !=
=3D "Orphan") print t; m=3D0; s=3D""; getline; t=3DFILENAME ":" FNR ": " $0=
; next }' MAINTAINERS
> >     MAINTAINERS:1736: Microchip PolarFire SoC Icicle Kit
>=20
> Conor, Sebastian and Guenter, are you still using the Microchip
> PolarFire SoC Icicle Kit? We currently don't have a maintainer for it.
> I'm tempted to deprecate it, as I thought it didn't really work
> anyway, but I wasn't sure.

I use it occasionally, and if it was to actually break to the point that
it cannot boot a kernel I would fix it. You're right that it doesn't
work properly though, the board's actual boot flow cannot be run on the
emulation available in qemu.

I could be an Odd fixes reviewer, but I have never found the time to
actually go fix that problem or add any of the peripherals that are not
mandatory to boot a kernel, so anything more than that isn't realistic.

--Mew+wDqXUhKeAUOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCafxgqAAKCRB4tDGHoIJi
0tBKAQDPcI3GtxazLFmMWwMAqY0Ddp0vqlDD9E0zpIqofDZg7AEA/H0gmlznb40/
PQF/YCXlpOG02v3SlQjHcBDLdYHeZAs=
=LSlr
-----END PGP SIGNATURE-----

--Mew+wDqXUhKeAUOc--

