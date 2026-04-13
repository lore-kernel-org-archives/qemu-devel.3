Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6510CF34C6B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 17:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCLBg-0004gC-IS; Mon, 13 Apr 2026 13:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wCLBe-0004fy-SN; Mon, 13 Apr 2026 13:35:03 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wCLBc-0002OD-IF; Mon, 13 Apr 2026 13:35:02 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 15F93EC04FC;
 Mon, 13 Apr 2026 13:34:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 13 Apr 2026 13:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1776101699; x=
 1776188099; bh=0TZHTFy/wTEE72HoRTcOvtkq7TFGEMaP4+WuZ6Yb+rg=; b=F
 hCiyHb97W/EF2XhbXNwC/rsRNAXi5vB6lKNKG4hgKPkG+UbX/4UQlStYmdmuagGW
 e9mpD2Wa+m3NdysHm4Za9IwvO9EE2eJk+Fgm3kpUswelSVTY200BJwx5i8p/p+je
 kDAtKiOYD5fcY3W6Pe+qrL4hzCPjooZqo2UL+Yt/GR/GcjPaGRqk2zeJBqCTj4BT
 rKWVQ93zEY3RIoL4XCXMghrjClqWZbhWWmK2CS2g28TYO5kc5mpHdKRurq0eQCVM
 lOsmlLyLMhRystRdkj/NHLP+yFB8F5Vl/q9hS7nC13Rpp6WlsgqZawqxYgeDE/jX
 Ej3i3bFkAVJUppV9vVMtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1776101699; x=1776188099; bh=0TZHTFy/wTEE72HoRTcOvtkq7TFGEMaP4+W
 uZ6Yb+rg=; b=ZiGhgmNoKAzWPVDyXzVCi0DX8Y6ZRCmFR+GoIJjkxDsEZqoMdsP
 Niuwq2QSQN85n2zWmnzIZo/iANHCR9131/o8i/ndNzdY60PupD3caHq/3g05YmPT
 6PVkphubJBZl1cGpAoQJiK9AEbJord1A4OEGzo5q/+cpWJ+aRT3rJLr9HP5yZtDo
 lCuKYni0uSoPzmFuPYKZpK1MVnGe8dgWoq0erRGoe5mSfOqo6qhK+X4oSfw4JMtg
 zq2oXh1+0xULUhGGf7qqyjtBXf4L0WPVNGliWx9fS+YggIca+1F6qNDfpPtdTPyS
 YsRJ/UZqsby02hiA4F5IBQzjO5zjBM1EwuQ==
X-ME-Sender: <xms:QSndacjXTT4v2XDc5AjvJndQAPPv_Ha3jYC1QVcfw__r-7fTtfmIHQ>
 <xme:QSndadJhYf5JXmlA53jyxRO8nfBhRASRR-J200_V7A8Z7pqyjPb6Vkzc0egFgWH4p
 hlY3OVyVeDlCEJOjVbmbojqxU0aOLDlAvjewjovJ5_jx9K6D1_GhxU>
X-ME-Received: <xmr:QSndaTlgiuAAhRHwnencMArfv7Jz8uIU2SQMnMGlZAMf6c4EjnEXEz44q3LxP67GKHXrxXGXR4QG-Xc1kD4QhQqWjtRGS04>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeekgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffejveen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhsse
 hirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtohepsggvrhhrrghnghgvsehrvgguhhgrthdrtghomhdprhgtph
 htthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepphhi
 vghrrhhitghkrdgsohhuvhhivghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehphh
 hilhhmugeslhhinhgrrhhordhorhhgpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgv
 lhdrohhrghdprhgtphhtthhopehkfiholhhfsehrvgguhhgrthdrtghomhdprhgtphhtth
 hopehsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghvihesshgt
 hihllhgruggsrdgtohhmpdhrtghpthhtohepfhgrmhesvghuphhhohhnrdhnvght
X-ME-Proxy: <xmx:QSndadOsVGJSzubrT5wgkGPQvYAxl5iCojvl-VGANahOcFPtkAVX_g>
 <xmx:QSndaV5Jx7r1JTAXpDCwtx6x2PufD8c_j9dlYuEtAYQHAkTuXM8Opg>
 <xmx:QSndaZZQ2h7uFgHSmzMXYNK8X3u7b3ZQyWh8sO1L3pl5x7H8ZZAN7w>
 <xmx:QSndaacejT5CL00XGAIULCS9MzOIYM5el5weirSBwzF8Vs1WqjlCZQ>
 <xmx:QyndaYnp76HGxSbe0tq6h3VoEohmayPd3DDk0rJKvUnIYssl-TCz6Bbe>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 13:34:57 -0400 (EDT)
Date: Mon, 13 Apr 2026 19:34:56 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Avi Kivity <avi@scylladb.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: Re: [PATCH 0/4] hw/nvme: make model & firmware version cnofigurable
Message-ID: <ad0pQDzYIki56wUe@AALNPWKJENSEN.aal.scsc.local>
References: <20260306165717.3360110-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OgHqLDwYem1ofw4s"
Content-Disposition: inline
In-Reply-To: <20260306165717.3360110-1-berrange@redhat.com>
Received-SPF: pass client-ip=103.168.172.144; envelope-from=its@irrelevant.dk;
 helo=fout-a1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--OgHqLDwYem1ofw4s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar  6 16:57, Daniel P. Berrang=C3=A9 wrote:
> These are both currently set to QEMU specific hardcoded defaults,
> and in common with other block devices, should allow user overrides.
>=20
> The pre-existing serial field should also be length checked to
> detect & report invalid user input instead of silently truncating.
>=20
> Daniel P. Berrang=C3=A9 (4):
>   include/block: define constants for NVME string fields
>   hw/nvme: report error for oversized 'serial' parameter
>   hw/nvme: add user controlled 'model' property
>   hw/nvme: add user controlled 'firmware-version' property
>=20
>  docs/system/devices/nvme.rst | 10 ++++++++++
>  hw/nvme/ctrl.c               | 31 ++++++++++++++++++++++++++++---
>  hw/nvme/nvme.h               |  2 ++
>  include/block/nvme.h         | 10 +++++++---
>  4 files changed, 47 insertions(+), 6 deletions(-)
>=20
> --=20
> 2.53.0
>=20
>=20

Given the reference to prior art on introducing error checking in these
cases, this LGTM.

Applied to nvme.for-11.1. Thanks!

--OgHqLDwYem1ofw4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmndKT0ACgkQTeGvMW1P
Dem9Dwf+P7v3292YCfbRQDS5z615fDBjfLaSlinoptvL7K5QXulJPTvyKWJyuM6u
sfbWXDIZ7J21ZnTWeX3PL4iuaCA30cG9LlkSrR+5pJ8ELLjHhBLFz9vNuip0R8T9
bi6POydXHixA5/m1E6lS4M82Hg4YnrC6+jhELK12BuTzH9TeRd9b8eEPVfxx+Arn
RIBgIvJ3g68daIhNGB4TrGw1PvmjwnQiblFqUzB5yzwvSKDESwtJ41WZukRSQIfy
vEZpHyIYmOWrzaYWDWXeHtnSA3gyjdmB7GOwYERPy+jaWL7AAcn5aZi1fwPfoLsF
2CRCPeRw1TfDyH13uQavUigBV+twCA==
=xgCE
-----END PGP SIGNATURE-----

--OgHqLDwYem1ofw4s--

