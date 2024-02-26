Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F7CC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWZt-0006Cv-Om; Mon, 26 Feb 2024 03:43:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1reWZr-0006CJ-J8; Mon, 26 Feb 2024 03:43:11 -0500
Received: from wfout7-smtp.messagingengine.com ([64.147.123.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1reWZm-0007uJ-18; Mon, 26 Feb 2024 03:43:11 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.west.internal (Postfix) with ESMTP id BAB491C00074;
 Mon, 26 Feb 2024 03:43:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Mon, 26 Feb 2024 03:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1708936980; x=
 1709023380; bh=8C84jEXZ6IhS/b/vm6IGT6Dqh46Mf8J898H9Q+UThL0=; b=s
 PLmHaSSJQoDoqn1O+olrWtQjoqo3UhFfsVDsxtP4oaXpMA6ycua5T8B0GrJdx+YU
 8Sp8MzB9MMoBzJZnh5x135OLEilJd1PbJwPyaf5ULoerPES1DQdB8hkp9/VtVzwb
 +TFValdXuep5+26q6gYwwXPkytz6tdOwCLrn2rQflxIcEjBZwYAxbCv47OZi4XzZ
 2wYYsjE85Gzbgo68n+7nxLxlAejJX+Db6f8PvXTl/jrlmQ5zidgieHzBFaD3uk/C
 ioIitmzz0N/kPYAFQwGSeVXv0IIpP8pB5NsOvJb6+TycEWK6pxpX4ItYNhyu1G1x
 SLAB+ALxaig208a6vZFmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1708936980; x=1709023380; bh=8C84jEXZ6IhS/b/vm6IGT6Dqh46M
 f8J898H9Q+UThL0=; b=lvgUKG6+ntQFkeniHnKDof+i1VxSMYfHMQCNAOdSbQ3K
 Vy3O6wxljDiMFEop8lcVngB5v3p62flUawji6V7UlC+3EbROcFSh+lG/o9hgY9LG
 rnaxhBQeF7xcwigTPcM1pRqWLWNWMArJT1NqoOfa/EZQ37rD5L/czDV5Dqm19YOF
 rRLkgFL6JM/Eelj2FL9/aqQ3CwqEUz+WVE12OKlrnvDotbjEaUOeCcx6K1NVYXeZ
 qyTGahiJzNfAElNZOMvAaotCk2YYzmIMQnvLgleMJy8xFJ6D3PO2SN8ib8TMa+D+
 VYIaBJpw5YzCafIoZu8MwC1Q9zKInwORobqmodJJ7w==
X-ME-Sender: <xms:E0_cZX4F8p3vh5El283AaIjG4m04P89qn3aRDMV5T5k_LgHhLEnr9Q>
 <xme:E0_cZc6mGU2LeWkBAz7oF1JKH2FLgBE4dyrvVArTTgrY3XjDTzTSEBoagOlRJ5tA0
 NzZzT63u7bHtIgnyrs>
X-ME-Received: <xmr:E0_cZedxEUEnYChQR3KAdi8tKSMGwleSLctQ67kssGg8XMJwYQRYSr7CfVDklQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedugdduvdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
 jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:E0_cZYJ1mvi6xrAfxR6z6GL4EWjYZn3FREbjmsiNvcufEP6HvpsJ8Q>
 <xmx:E0_cZbKYcuvh_PKumjvj771V1bCYqIgYMnlz-wVZOWnT5WI1DzOY6w>
 <xmx:E0_cZRyM-dU5Zbz2stqOyhnSGruZpcheXexUVyOBivsI92fqw9pgdA>
 <xmx:FE_cZYqAko4u5DyDEHyYHkkdlWDPBhvoXRyB3dfxLfhEQR5zaOdD4rLY0IE>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Feb 2024 03:42:59 -0500 (EST)
Date: Mon, 26 Feb 2024 09:42:55 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] hw/nvme: fix invalid endian conversion
Message-ID: <ZdxPDxYdqYLgY2Xp@cormorant.local>
References: <20240222-fix-sriov-numcntl-v1-1-d60bea5e72d0@samsung.com>
 <295b6a29-d0a7-40b1-ae37-34faab925d67@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TxADA0+lnQOPN4Lv"
Content-Disposition: inline
In-Reply-To: <295b6a29-d0a7-40b1-ae37-34faab925d67@linaro.org>
Received-SPF: pass client-ip=64.147.123.150; envelope-from=its@irrelevant.dk;
 helo=wfout7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--TxADA0+lnQOPN4Lv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 26 09:18, Philippe Mathieu-Daud=C3=A9 wrote:
> On 22/2/24 10:29, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > numcntl is one byte and so is max_vfs. Using cpu_to_le16 on big endian
> > hosts results in numcntl being set to 0.
> >=20
> > Fix by dropping the endian conversion.
> >=20
> > Fixes: 746d42b13368 ("hw/nvme: Initialize capability structures for pri=
mary/secondary controllers")
> > Reported-by: Kevin Wolf <kwolf@redhat.com>
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >   hw/nvme/ctrl.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Hi Klaus, I'm not seeing other NVMe patches on the list,
> so I'll queue this on my hw-misc tree, but feel free to
> object and I'll unqueue :)
>=20
> Thanks,
>=20

No, thats perfect! Thanks! :)

--TxADA0+lnQOPN4Lv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmXcTw4ACgkQTeGvMW1P
DemdSAgAk7h4wfGrkPy4Uhs0lCJUZOcPV99iDlrtCqIVPtdQGOqx+lWyZ+PsZ0bW
YRz/T9z6E9TMYRFS/F1tNcmLaQow4BB+J1VGhuBe8rkELvGh2MfetEtChyhpt7He
NkrRG6D4Xe5GnkRTwMiPSVFlSGw2swiyvKYyfBXxK2GDBPUnsv4B0++4kyOY2dU7
qpuZmQESkA7AaQZC/LUqUKQlcylTJjxez1vZ6EcRt7qAbFqDIvcDN0n3wLA1RyO3
kE+dChW+KjM/JYCrmfziTcA4WuY22WqS74ZTL4wNgg3zTRnPqlp3cq5vTBrtYNp8
K2ZGDsh3RY7JEYVV+CBTgTAJJmF8BA==
=uKsO
-----END PGP SIGNATURE-----

--TxADA0+lnQOPN4Lv--

