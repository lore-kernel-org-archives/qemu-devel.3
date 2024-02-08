Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90791C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 12:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY3in-00006m-0F; Thu, 08 Feb 2024 07:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rY3ii-000068-Vt; Thu, 08 Feb 2024 07:41:37 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rY3ig-0001Xt-VC; Thu, 08 Feb 2024 07:41:36 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 5CF7E5C00C2;
 Thu,  8 Feb 2024 07:41:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Thu, 08 Feb 2024 07:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1707396092; x=
 1707482492; bh=C3bQlhI0tMqJY/ndHwv7ez7GMpqC1abzjlRuLcW6jBg=; b=b
 Cg/TwUmtYbpAfS18engKgCrcD6MaOdcLrPa6FsdrC3kIqZw2DeGxAIeDAKZ48UZP
 XrJCT4x3qyvbCbhnULOtEcRtQESsCBlmdLZ56GrtvhzPkO4qrjHhKC4Rr5zwGVEx
 EDLSWem4a9yWa7MFThs+v9kt5OS2kmXHxIlugOVioiSNpH/vW/nn519p7p1X6qnb
 09fND3+8YOkBnEC95FpaJJviTphOLYGAulNm8ohwz1rC8WE82yEIJJAwJH3jxlMz
 yAeif13LuUJWdjHmhrwSUqghqUuA5A4k6UYoeb2FNzS8mIdqe2Weca/aDEpOclvs
 F9x88IbP711P1I9uPOTSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1707396092; x=1707482492; bh=C3bQlhI0tMqJY/ndHwv7ez7GMpqC
 1abzjlRuLcW6jBg=; b=w0YkEsiiLrDdHyLjHHEPOdT/QbQPgGbdE10gcpimgsF9
 h2GtxxCtfw+DwC5pQ25AYmVDndnPe7qtQCY8LJoHR9e+sOlQHwdcnalVSad2BmIb
 djo09hEEbgbOm0LQ1M+QWUWV786rhuQr4V8XqaEkAX6ovhJeUD5DMPKRjBCKShZT
 C8wwaV4I134gwovN4btFTr5GzNaODy9bfQf9lkOEB629SWpfHtcUnJiK8HVnajwg
 QPdHBObOKOF4Zq2o0pd1oDWj1KHZ8OVLrAjI+Hazq9jgyX+29+LALAKdWZj/Fj67
 X3+HibxnUQF9TSGIWylREeo8cQrNcf5fhJInkZqmqA==
X-ME-Sender: <xms:_MvEZeENVGEMsfotdMtOdWe7-fGDmwPadMX7ZIQInbUijX0xmtTb6w>
 <xme:_MvEZfUqpCb4yowc5CYzy88AAB6sqT2LsGNlNKzBCMNmfY9AZ--jeO4xWcqqG_BR6
 B4M_5mVgMpFQXzBj0I>
X-ME-Received: <xmr:_MvEZYLAuvnabN5u-smZDa_MLaQ5EPN8Xioq825bU4WduoC9m3Peo_IC4hPfhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeggdegudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffej
 veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:_MvEZYEvNJbHZbcFvha05taG3icSMm32Ty6Rbbt--DkbW7478wC-Pw>
 <xmx:_MvEZUXkFby9lHWdBtu1q7lGoszwDj9KJh8S-RlL3AJHls1yOZWOjw>
 <xmx:_MvEZbPL6obvpWJwrPs2JvK8kyhwIAJCW0ZEBWWte_u4uxxR0aOB5A>
 <xmx:_MvEZWKt1LOH46O3ACe9XPdHnU2owRSq7D3cSba2jlxbgtCJ1Ywe-A>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Feb 2024 07:41:31 -0500 (EST)
Date: Thu, 8 Feb 2024 13:41:26 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Minwoo Im <minwoo.im@samsung.com>
Subject: Re: [PATCH] hw/nvme: fix invalid check on mcl
Message-ID: <ZcTL9u-_V4Z8euAz@cormorant.local>
References: <20240208-fix-copy-mcl-check-v1-1-6f89df85f9d3@samsung.com>
 <ZcTKCAWaWzL6YT08@minwoo-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3qiRxMaStRWIm+bm"
Content-Disposition: inline
In-Reply-To: <ZcTKCAWaWzL6YT08@minwoo-desktop>
Received-SPF: pass client-ip=66.111.4.26; envelope-from=its@irrelevant.dk;
 helo=out2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


--3qiRxMaStRWIm+bm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb  8 21:33, Minwoo Im wrote:
> On 24-02-08 13:22:48, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > The number of logical blocks within a source range is converted into a
> > 1s based number at the time of parsing. However, when verifying the copy
> > length we add one again, causing the check against MCL to fail in error.
> >=20
> > Fixes: 381ab99d8587 ("hw/nvme: check maximum copy length (MCL) for COPY=
")
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>=20
> Hi Klaus,
>=20
> Reviewed-by: Minwoo Im <minwoo.im@samsung.com>
>=20
> Thanks!
>=20

Thanks Minwoo, applied to nvme-next!

--3qiRxMaStRWIm+bm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmXEy/YACgkQTeGvMW1P
DemZ+Af8DmEPxzFqaDS2bUlOXxrCKfRkG2D0+Xxv1fiVUJLb4CndnZ3gLdXfnyBi
HVSc/pPaPo+L4XyBhoBud7bGdPgsgwVzbD4BEa+ScchCnV4BJIGYdXwO+8NAm7BW
Wpw/LpNfVEKOl6ZohfpR1JA0etqHML8sqXEkxgYfhdSABqQXJMAa9O/ALsZOVsOr
N7cIgkpaF6EuKehh36efn1MOixPOO2Jhxy9DIW8NsZsQHeX8+25ukwG/1ooWuuUH
JT7Ykr3Y+Dz0D2VCl8wSvrGB5wyNHFPBLHXeG6oH5vBh3EBt2IfjzWuRG/8/IJyG
AI7jjmWwmunXR1EXZLANKTBj77Ma7Q==
=0hYH
-----END PGP SIGNATURE-----

--3qiRxMaStRWIm+bm--

