Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B78C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 12:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s29Md-0005Qv-R7; Wed, 01 May 2024 08:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1s29MJ-0005PW-Hl; Wed, 01 May 2024 08:46:51 -0400
Received: from fout1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1s29MH-0002je-8Q; Wed, 01 May 2024 08:46:51 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.nyi.internal (Postfix) with ESMTP id BDEAF1380143;
 Wed,  1 May 2024 08:46:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Wed, 01 May 2024 08:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1714567607; x=
 1714654007; bh=/v2NygAV7Ilh0ue5DUnmsu5nyZxRegRlZe0hBn3+318=; b=N
 9pFkaIWHspFj6m43befmR5LbDscsDKu2Uh3gPchEiTOmwHCyns1S4k8x4jPWyCRF
 s5BGhFrsP2H6xu4+102Q4p/O/vt2j+EyORTT9AKBzvFniQccZgGedCZaCGpGA0Va
 kEgSL1V16c0xPofc9E2u6N++z4TJwoV9LeB/WlIe+6AP70GysFa14Z5FvTEQjoiF
 Xjo1sw5bFlipFJnLQyQV4AlVqO/FEcUrB/VR2KX2BrL2VGUzB/5rqwpX0UzQlRd+
 bvBQv3M2qyZJZiE5qGZJ3QXltnGM1i3fhRjakLR4Le2yHlsNGKeYC9fvP0jSblo1
 L4vALz/6emLPaVFbmX/3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1714567607; x=1714654007; bh=/v2NygAV7Ilh0ue5DUnmsu5nyZxR
 egRlZe0hBn3+318=; b=UqpddovCeNnRmV4GcBkFnthuuySFLCKV732x4lvZNWto
 GCzDudoYd6+VWnjwbpLIFOW96SABWO9XPZ1mmj5VSyy946Jxzys9CSowqFZl+dDF
 B483VNONA7iH9bMUkekZoMbpmzKNptv/hhj9rGFgpxOi6uSQzyRPaICf/eniQf8e
 sUKt8EjKHiRjW6aouNznRnekxO3wJsQqGieiVhI00dGb0Um5eXXWKLfBWZ2Q30Jk
 tl7ZGa6mOp48/fQ2THjkGuPqXZipRWT1IrDRC+fAXhRbIZ/xAKueKVV9FAYyg2Fb
 Bw827zTOERzPyydU691/KXuRvnRqizibamP7L0VfnA==
X-ME-Sender: <xms:tzkyZuKZEb3uZwdShSTXxHVw2AdNgVx9TO4OEFLkrON3Znx0JAK_hg>
 <xme:tzkyZmKtDXFr5EitZyj983VXvBGog9Nx1Q-DumS4el1eWDbsqhOzfl4TEvWSCMLQZ
 _3tScX_fVzpH8eZWgc>
X-ME-Received: <xmr:tzkyZus2UTaMWCtzcWuoM0yIq41-f0_yoLQUXIZTTiuGN-4v8ua3v8W3aCPIUd9utdZUcfzslesUatLK_xA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduhedgleduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
 jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:tzkyZjbwcsedqyjoSIY-VHusfZEZvm89JMdnt9QknpGXp2sRY58ElQ>
 <xmx:tzkyZlaPzLFnYE--7RdkziRiHPR2sMkKa4-MF1TxQW5QfuM8wSWk0w>
 <xmx:tzkyZvDnDrV7WLk1pc39xFEq-FhGUfIih2hbV5oSt_i8fn3qVsc8KQ>
 <xmx:tzkyZrbyl9_tqPNzHKpfXnJFSuq1E51wHptZUaYqwAaMxFUX0emIxA>
 <xmx:tzkyZh5UpRIMqUjJcQp1KohtnC37rk7M8Rw8uWfhH0JHNnUOgZEnyXdj>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 May 2024 08:46:45 -0400 (EDT)
Date: Wed, 1 May 2024 14:46:39 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Minwoo Im <minwoo.im@samsung.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v2 3/4] hw/nvme: Support SR-IOV VFs more than 127
Message-ID: <ZjI5r-2lxntCfAGt@cormorant.local>
References: <20240331193032.5186-1-minwoo.im.dev@gmail.com>
 <20240331193032.5186-4-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ziZ7Gi58c+UyJ/eH"
Content-Disposition: inline
In-Reply-To: <20240331193032.5186-4-minwoo.im.dev@gmail.com>
Received-SPF: pass client-ip=103.168.172.144; envelope-from=its@irrelevant.dk;
 helo=fout1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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


--ziZ7Gi58c+UyJ/eH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr  1 04:30, Minwoo Im wrote:
> From: Minwoo Im <minwoo.im@samsung.com>
>=20
> The number of virtual functions(VFs) supported in SR-IOV is 64k as per
> spec.  To test a large number of MSI-X vectors mapping to CPU matrix in
> the QEMU system, we need much more than 127 VFs.  This patch made
> support for 256 VFs per a physical function(PF).
>=20

With patch 2 in place, shouldn't it be relatively straight forward to
convert the static array to be dynamic and just use numvfs to size it?
Then we won't have to add another patch when someone comes around and
wants to bump this again ;)

--ziZ7Gi58c+UyJ/eH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmYyOa8ACgkQTeGvMW1P
DekVrwf/e2pcQnw4GNlUCmUhhZmgQ5NkbScD3p7UWCJKjqU41h13aZbUwV5u+Rkt
4je1y3h+AxC8fD235PMWsfkc3U3YZYesHFOynQdyrspMf6JO/OTsL+qPeNLnp2oL
sbt3kEhxtofBIWb2W3iNDf7VemiO02gHrhVKSPMoglUWmBwv0DWwj2yr8bDbSa0x
us7qZtsPfse41Y4r7cR9Ai+ApWhNOvWwO2oCA+AU8wZqc0Krrsw+iyI9icUQ87le
jPxmSHEWUegZ7/PvXlMGho2Xcd0VDE7wjjrfkHKjQHPqwuPMWFrXmzskc3bGQZWY
JNUnzCLCz1H+JnBXYaVZzGI7gNBlIg==
=Fz5/
-----END PGP SIGNATURE-----

--ziZ7Gi58c+UyJ/eH--

