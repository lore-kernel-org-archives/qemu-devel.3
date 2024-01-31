Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8164EC47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 18:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVFhK-0002kb-4y; Wed, 31 Jan 2024 13:52:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1rVFhI-0002jk-5l; Wed, 31 Jan 2024 13:52:32 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1rVFhF-0007G9-OG; Wed, 31 Jan 2024 13:52:31 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 2AE22CE218B;
 Wed, 31 Jan 2024 18:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28416C433F1;
 Wed, 31 Jan 2024 18:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706727137;
 bh=czBRZcYgNVSyZkkOYTT2dhNf10PuR0vW9rEahq38vEE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dkNDmVNJ0eqMU5SErP0KRoykAPVw26WJ2dckkZuZmblk6yist+NB/Lbed6tnTxcjf
 qB5+6Zh8zG9BFoT+uetSTiDYL4xNbMEgSWEdFd8L1+l53Md2T+FuwhAySZLoh4LUj/
 JTGamt0gt9H+Mje1zMNqBY6iQ6K8Xbt1WMizPxqjg8wZX5JBAViONte0YwaIMhXvYp
 vVF4P7oyQcRLnpNrdfYS+PFo8H437QXS4zoV4iYhFmdHLbCFV6JnPCFnhl8fptTVTb
 t2I2X5eh/16amEdUu5GVvSWHcDJdrpLSj2wGy8i5Sc7HUO6pZBFKmH2R/4x5GcsiQ2
 JEsvzRf6PswbA==
Date: Wed, 31 Jan 2024 18:52:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Christoph =?iso-8859-1?Q?M=FCllner?= <christoph.muellner@vrull.eu>
Cc: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 Alistair.Francis@wdc.com, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, qemu-riscv@nongnu.org, bjorn@kernel.org,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Subject: Re: [PATCH 2/2] target/riscv: Support xtheadmaee for thead-c906
Message-ID: <20240131-groove-preamble-a2334b869f4e@spud>
References: <20240130111159.532-1-zhiwei_liu@linux.alibaba.com>
 <20240130111159.532-3-zhiwei_liu@linux.alibaba.com>
 <CAEg0e7g7AY0YcTu4RiXtim3Ofkq3TuCWd4QjGqkF7xZNiYJ1Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y5kulPWHU31cP58D"
Content-Disposition: inline
In-Reply-To: <CAEg0e7g7AY0YcTu4RiXtim3Ofkq3TuCWd4QjGqkF7xZNiYJ1Ng@mail.gmail.com>
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=conor@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--Y5kulPWHU31cP58D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 12:43:25PM +0100, Christoph M=C3=BCllner wrote:
> On Tue, Jan 30, 2024 at 12:12=E2=80=AFPM LIU Zhiwei
> <zhiwei_liu@linux.alibaba.com> wrote:
> >
> > thead-c906 uses some flags in pte [60-63] bits. It has history reasons =
that
> > SVPBMT didn't exist when thead-c906 came to world.
> >
> > We named this feature as xtheadmaee. this feature is controlled by an c=
ustom
> > CSR named mxstatus, whose maee field encodes whether enable the pte [60=
-63] bits.
> >
> > The sections "5.2.2.1 Page table structure" and "15.1.7.1 M-mode extens=
ion
> > status register (MXSTATUS)" in document[1] give the detailed information
> > about its design.
>=20
> I would prefer if we would not define an extension like XTheadMaee
> without a specification.
> The linked document defines the bit MAEE in a custom CSR, but the
> scope of XTheadMaee
> is not clearly defined (the term XTheadMaee is not even part of the PDF).
>=20
> We have all the XThead* extensions well described here:
>   https://github.com/T-head-Semi/thead-extension-spec/tree/master
> And it would not be much effort to add XTheadMaee there as well.

Yeah, I was gonna request exactly this, so glad to see you beat me to
the punch. It would be really great if this was done, particularly if
this xmaee is going to appear in devicetrees and sooner or later is
gonna want to be documented in a binding.

Cheers,
Conor.

> For those who don't know the context of this patch, here is the c906
> boot regression report from Bj=C3=B6rn:
>   https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg04766.html

--Y5kulPWHU31cP58D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbqW3AAKCRB4tDGHoIJi
0hVWAQCCqKZ6/90laeEqKGvCIrydZllOe1Kpyz/pyNmmVZU0ywD/YDxhjADP0PR9
d9Ae4Pv71r+42PEEUQDaw4ca4xvCVg0=
=bchw
-----END PGP SIGNATURE-----

--Y5kulPWHU31cP58D--

