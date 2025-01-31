Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAFAC0218D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 11:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdp6K-0007zO-5Z; Fri, 31 Jan 2025 06:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1tdp6H-0007z7-RG; Fri, 31 Jan 2025 06:22:17 -0500
Received: from fhigh-b3-smtp.messagingengine.com ([202.12.124.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1tdp6F-0003mq-A2; Fri, 31 Jan 2025 06:22:17 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id EFAC7254012B;
 Fri, 31 Jan 2025 06:22:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Fri, 31 Jan 2025 06:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1738322530; x=1738408930; bh=hcsLvU0+im
 ojPGm+4z29TOaRciQxSnUDJWle6+Hbym8=; b=jAsUyJBKNoKikRh/gKGRvnlPPJ
 FU18kOsP5p2VunpNV7O/8K32OQRrbcIWILtFBbZLLM6fL8yghLON7IuwzIhCtH0p
 OUqIVbXwSp79scfIsq2ohqhVrtv+rj4vSIvidPczd6pm6K+NxaQcGdN4MwCwONGV
 1QIH2+An3YYPTwQxlYW2ObFvOUP129iuZX7idaj638/Yucw+iOGQNUH5gatq8Brh
 b926/DtsVpaj02+6CCRVjNSJVSyZeZI+WOvSreMPvcYfOchrIAP0dSE8f/C4vhxy
 U9u5ncEdz98MLmgISvTm5YWonKlToYHbfi5QOWVsjKOyqRn36uh+NQmgfixw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1738322530; x=1738408930; bh=hcsLvU0+imojPGm+4z29TOaRciQxSnUDJWl
 e6+Hbym8=; b=rMdTbRO4o5kcF4rpZ2HOYuW2Ft4sdFU7bNa/HM83BcyA0zVbZvQ
 M+WnUnEypLyJm36MBoAZnlkIk/CyWuOLnakfeKtUpF6BAnWIEpwOp/1HEJVeCo9M
 abQ8w38ktOl04E06nprGO/XCaE8iRywJzZwCy+T/QJGVCB9v/HVPjXpZtjl3f+8F
 0ZnD78fSrDNf9z8mDRoTtsMga1nm1AKIB6hy74Gj+9QzF6/wqm6I02IiXmOU2MlP
 szvrPow/383H1XBfLLlczvJ9DzXPA2NejZOgNiIXTFoH1F4nXO81aGr2gScu7wB7
 4dNOjLCB7ULscBBdkmLY2EjNN96Nv7EoQFA==
X-ME-Sender: <xms:YbKcZ2wcooIWKFWxuFxY77AnAcmAUKe-xVR-ftBqAhAmbDYQjBwXUQ>
 <xme:YbKcZyQ-FWhtdsya1JWY6HInOGprkAjgK3QWqBqIDXgljytkwVpQWfDXAgCHlFkrC
 njpaEqt18qebWM6qJ4>
X-ME-Received: <xmr:YbKcZ4UlcN_01KnM32j53hWqGKPkAbsrM1xffLd4NNozxTV06z1i3SH3ugo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnegfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhf
 gggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmsh
 cuoehprghtrhhitghksehsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpedtjeej
 gfdugefhtedvudfghfejfeejfefhffeffeelgeduveejleelffefvdffleenucevlhhush
 htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehs
 thiftgigrdighiiipdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprh
 gtphhtthhopegtlhhgsehrvgguhhgrthdrtghomhdprhgtphhtthhopehqvghmuhdqrghr
 mhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhngh
 hnuhdrohhrghdprhgtphhtthhopehjohgvlhesjhhmshdrihgurdgruhdprhgtphhtthho
 pegrnhgurhgvfiestghouggvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghpthhtoh
 epthhrohihpghlvggvsegrshhpvggvughtvggthhdrtghomhdprhgtphhtthhopehjrghm
 ihhnpghlihhnsegrshhpvggvughtvggthhdrtghomhdprhgtphhtthhopehsthgvvhgvnh
 gplhgvvgesrghsphgvvgguthgvtghhrdgtohhmpdhrtghpthhtohepthhhuhhthhesrhgv
 ughhrghtrdgtohhm
X-ME-Proxy: <xmx:YbKcZ8jj9BV01bTzQ6F6Mr8Ag7Ur55oFs9YwG8VId6Mlb2bb0Hy61g>
 <xmx:YbKcZ4BwjgY0vn2wLiaOZYZS3L4Yi9COAnYWGfar-IBSHsOkUb2ZTA>
 <xmx:YbKcZ9KCn_rM3khVh8LGQD98xmYzJnTrB3DVK3RGQV00B6ISbQ7cFg>
 <xmx:YbKcZ_DwqC3QcF-rTJdycqbLaJPcOjP8lXwCUBEkbQmM-02xT8gUqQ>
 <xmx:YrKcZ4uGqtASdXtYZBIXiDKqbzJ1V_OFTonWB8FEK5W8jcKQh2tRvRjO>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 06:22:09 -0500 (EST)
Date: Fri, 31 Jan 2025 06:22:08 -0500
From: Patrick Williams <patrick@stwcx.xyz>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <troy_lee@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 5/5] tests/functional: Introduce a bletchley machine test
Message-ID: <Z5yyYELBy6e3-ZBF@heinlein>
References: <20250129071820.1258133-1-clg@redhat.com>
 <20250129071820.1258133-6-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nAP/AiS4pr374Q5Q"
Content-Disposition: inline
In-Reply-To: <20250129071820.1258133-6-clg@redhat.com>
Received-SPF: pass client-ip=202.12.124.154; envelope-from=patrick@stwcx.xyz;
 helo=fhigh-b3-smtp.messagingengine.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=0.629, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--nAP/AiS4pr374Q5Q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 08:18:20AM +0100, C=E9dric Le Goater wrote:
> Use do_test_arm_aspeed_openbmc() to run the latest OpenBMC firmware
> build of the bletchley BMC.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@redhat.com>

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

--=20
Patrick Williams

--nAP/AiS4pr374Q5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmecsl4ACgkQqwNHzC0A
wRmRHBAAkBZhIIEUehgh8o05HEzdAhDP/nuY8xVdaeaJ2H+IQJpQyUKyXis6jTru
JvcBY87/6hpWzwmHpUq7D0m5Q/iDLIUphc2doQe0LpAiSCP2flv8C2J9PX8ak0Yl
YZ5yEmR6EWc2mMDlOHlSsrpZUESSg7K0+Ejc+4hwKemX2cZ8xx0Ddro8/NYHJ/R6
HeUjbJ+JAL9daaNClExdNk8UPJYx/x+X5ZHB3sXheGM3vooGIMwxWjghTdT4TcdY
6dlGhsA3JmHLXO4gIn43DohjiN70xI4LtvbqIkb/k1fUFsVlLyQlreaTMfX3RQnh
2/13aVQA8lxOV5oUoA6bRZ68n/6tSL4ADF+dDc/TzTBwqZqQb9S8uCOZGnwEyesk
xMzZhQzMmhLvXYzfL/MtreyubXmXiqgPJJAVSbQSGB6Jqht2SPc/Bg475uNfKqlH
f8Ahk4xvxksZrvtFJP6QnXsib5QJ95z5PDYA8jHH8DQI7JLZY61YRGlnUykKMhxK
hprKKlzKZGJLUqA2p0YtyDtwKM+FY5rtEC8hilCYlxzTUFqA6r0G3lI/ilalsxLR
d3bLkxfA89qUKEMywBTo8lhxntGdiv86ujuwxFJ/oNXc13Y0nq62Tir5udw/TeC9
lfb85ZKq1MGzdCldtbI6+MEnArXJZbHywvnPOVjKCE7PC0uXzR8=
=oAbZ
-----END PGP SIGNATURE-----

--nAP/AiS4pr374Q5Q--

