Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959A2C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 06:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2P3X-0004Jf-L9; Wed, 09 Apr 2025 02:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1u2P3B-0004I7-J6; Wed, 09 Apr 2025 02:36:42 -0400
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1u2P37-000140-R9; Wed, 09 Apr 2025 02:36:39 -0400
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id B61582540243;
 Wed,  9 Apr 2025 02:36:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Wed, 09 Apr 2025 02:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1744180593; x=
 1744266993; bh=cIHFbBgEyrE8tImz7zVripQZWWqD6xlhWvqr+0y70b8=; b=b
 xtkhePO5/QcMQKM9TkE9tXbdsUSQZVAkW7xmLoIx2BI692J39I/83QqoL/MuLe3p
 ZLWQdj6VjVweHnDVGOEMY1gZG/8frD+vZ/Hnx5Sj8mITS78NNAl8ohu7jRLUa7GX
 yfJoUX3ABK41UIIW4tCeOk2JBJY97/bUyQzgdIngndMGyMThUz5crjydH7L8w3KP
 NK+M4A14Eh7vq4FtDTONBAmzCHxbFo+Ykcfp9mEsWDZ8DxYlNXptSKrhsBgbswzf
 PYy45dTkXgB05piUJ4B8Sx7NMEl4Ztru2rOc0Usl7Qus3N+gR63aydUzLBS4P95x
 6g6XHUZlJZIdL6EyCl1Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1744180593; x=1744266993; bh=cIHFbBgEyrE8tImz7zVripQZWWqD6xlhWvq
 r+0y70b8=; b=wwxYntoisjb74+7Nu0nZ8dr6q9SzpvO7zgirsAdOWR4r2H8qslp
 cVJxQtRyJgQgzumfvlRVSiiYrPLZI3p0K5yZayNOBvNFBXY889jfQrHa42nIdn+m
 u1fA431J0QmjVTHu6scP+BwTWR1g8dhQdfrsQbt1EQRA5iAFyic7XGyC8h2KGdc1
 JYi/qc8AyUgq26oqI5lFxR8YVMRiZSFHj/8h06HeeU+NOSpR5JjPDpaC/aONbHyQ
 HPcPZ5MUglLEmnuJjR5XX7UY66JrUGICdLbxf1CzmsZgQ06cf10fu/LHfEWH+fY3
 eBqA27JlJPsFCovO5HsdT1jTqa5ZezK3wdg==
X-ME-Sender: <xms:cBX2Z7RREbzs7p7oJC37_dvbhdtq-Ty5BCeZ0cHlpwvJ5CVpg4WxFg>
 <xme:cBX2Z8ydrVTnmSA8cfwxY5hbI2HMBJ_UJ2S93NYVkoLC9X7QEUwupddfNUi7kmcic
 ldBfZ16p0YuQX0JuFo>
X-ME-Received: <xmr:cBX2Zw3QIWE4VuDq9Rkdte90CrUwEln13YCSknS_qpEoUKGvvfMvEAtORWqN9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdehvdelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddt
 jeenucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnh
 htrdgukheqnecuggftrfgrthhtvghrnhepjefgjeefffdvuefhieefhffggfeuleehudek
 veejvedtuddugeeigeetffffjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
 hmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghp
 thhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhlmhgusehlih
 hnrghrohdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdho
 rhhgpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
 hfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhopehqvghmuhdqsghlohgtkhes
 nhhonhhgnhhurdhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrd
 gtohhmpdhrtghpthhtoheprghlrghnrdgruggrmhhsohhnsehorhgrtghlvgdrtghomhdp
 rhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:cBX2Z7CvMBMf6Q3CC441jkKTrZYxQAfWUf2EX8Jh4nbzZt-XrBmW6A>
 <xmx:cBX2Z0iyFryWEOizA66Nomqe7-S5wkn4qr3MeOLGRex-IUEQzzuZpw>
 <xmx:cBX2Z_o0HcX0u_RRi64t6RFD-nAFFHtkOFyzRt2xf3dWdS2e88Aedg>
 <xmx:cBX2Z_i7HUDGIbEhqcM73dhd796YQJie1fL2928hFAhHiNMvFX-oyg>
 <xmx:cRX2Z_0rrMh6vsZ-kAlnhueHiefZBAv3MjluzclEreP0Fo7JgOBrN1w2>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 02:36:32 -0400 (EDT)
Date: Wed, 9 Apr 2025 08:36:31 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH] hw/nvme: fix attachment of private namespaces
Message-ID: <Z_YVb8ByfXoM6pyi@AALNPWKJENSEN.aal.scsc.local>
References: <20250408-fix-private-ns-v1-1-28e169b6b60b@samsung.com>
 <f9c9c189-bbca-4cea-8aba-29410b85d0e5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nLH5kkRa8b3wYac2"
Content-Disposition: inline
In-Reply-To: <f9c9c189-bbca-4cea-8aba-29410b85d0e5@linaro.org>
Received-SPF: pass client-ip=202.12.124.159; envelope-from=its@irrelevant.dk;
 helo=fhigh-b8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--nLH5kkRa8b3wYac2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr  8 20:56, Philippe Mathieu-Daud=C3=A9 wrote:
> On 8/4/25 12:20, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > Fix regression when attaching private namespaces that gets attached to
> > the wrong controller.
> >=20
> > Keep track of the original controller "owner" of private namespaces, and
> > only attach if this matches on controller enablement.
> >=20
> > Fixes: 6ccca4b6bb9f ("hw/nvme: rework csi handling")
> > Reported-by: Alan Adamson <alan.adamson@oracle.com>
> > Suggested-by: Alan Adamson <alan.adamson@oracle.com>
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >   hw/nvme/ctrl.c   | 7 ++++++-
> >   hw/nvme/ns.c     | 4 ++++
> >   hw/nvme/nvme.h   | 3 +++
> >   hw/nvme/subsys.c | 9 +--------
> >   4 files changed, 14 insertions(+), 9 deletions(-)
>=20
>=20
> Patch queued, thanks!

Hi Philippe,

Thanks for picking this up!

--nLH5kkRa8b3wYac2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmf2FWwACgkQTeGvMW1P
Demnsgf+No6ov1V7In5byciSyghhho96R/DTTb8icNz/0QrvU60qAwTeiNfmTgjg
sKS7c0YPznTpHlNHg0KiyVJWGs/MC6upa2nNpYJ1hHWrX6CqVFMrKlaYFEhhymqo
/vpz9iX7mBuepg61S6O0ib61jXDWChW4i9K7TSyUdr9IpJHq6Fl2JZx86IwjhkQo
5yadWytNYpOBtpjwa5JJ5uN2V7N8H9Yqel8II40qgsOvP4BuD/cGN0bnLgx0d0RH
W5KH96ZmO19SIBP3QBD5GG371B7S/iQxovm56qczp0mKbdMKrSAQ/6/11dt9iFT7
+jKAdZuid/UzvWAm1pOR414zQ+YhaA==
=AxQ/
-----END PGP SIGNATURE-----

--nLH5kkRa8b3wYac2--

