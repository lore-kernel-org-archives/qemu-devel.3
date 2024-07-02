Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58381C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 18:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOifS-0003QE-D0; Tue, 02 Jul 2024 14:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1sOifQ-0003MV-1q
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:55:52 -0400
Received: from fout4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1sOifN-0006jx-3Y
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:55:50 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfout.nyi.internal (Postfix) with ESMTP id 6C4A613801A1;
 Tue,  2 Jul 2024 14:55:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 02 Jul 2024 14:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1719946544; x=
 1720032944; bh=ELupffcjP154YucZBFgL+NyKyCqOkU00CWsIkFxKwmI=; b=j
 xXrIlcnj+l+Tf2dw2GYjzxu1wfvwXHYb6ksxbtSKBn4f3cyndoVwgDVIpOWfC6iU
 lQdXC59CZqp+w7qisvnUQwVKsQwTuccJoVl3MeyeNd/S/RhZxjK3YeYlPBV9xLLf
 ZSD4Axvkz2oJGEmGBIqr/BzH/YamFQGisDh932TyzXwSD2y3gKmVBNR/5fP6LZQk
 4O+C3FTmY6DuYExRADycxw8kNE4NpQJec1BHEeCEnCXm5MQ0WO3Hgu+ySbYe1SKZ
 ZVnVjNNl6GO0oGBrKSexqIqMDnUJ+zhpSxhYT4pktzXIwVfo5F8LA7On/AArEtoq
 oKhIXnScO9hL6tJTb7A+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1719946544; x=1720032944; bh=ELupffcjP154YucZBFgL+NyKyCqO
 kU00CWsIkFxKwmI=; b=Q91ehQm7jNYGP3fFleYyyeBGMg/hnmmjeGRurqI0g18p
 k0VMdOwIaP9OLmriLilQsUApFgYcHX8njZOd4lhV6qxFIK+6tB8vgJl0m5z7gIik
 6aJbFMessrGBdv+ZlvcRCHriRXrbc2TpJbkGM+2UXt4EL1H5MxuMjHeq8KcclW+X
 6ntyhnV6ExlHXkuqJZ++iXeAJWZg8wVhZYUIxVlvkoT5UgQusy5xussNvbLtPooQ
 pVbXeWK5pqBeFSJfUGLraJTMKQnhTbWrcGRrZEoeLrWpYEpc/r2d7srsI0L9Riwh
 A7ycb7C2JyWTxABXNz3XgBS7B59HKtTvn5VX+48srQ==
X-ME-Sender: <xms:L02EZhTkDGFUJvXsoyUOFYbG2H2vrBZLUK3C4FVG8EXTVK8W0hU5ZQ>
 <xme:L02EZqwwzclQ8ymvNXXSfqsmZVeAuVZQFkFCBwgDBbAAZdquN_9RORdjy5ulWd1Nv
 6nS2MjwEVUo4beZ210>
X-ME-Received: <xmr:L02EZm2ZCERWtWGxMIctnjmiW4gsAqbID0khMhnGtBolEnWIMt-7kBk1pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehgdduvdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
 jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:L02EZpCt4OzXVM72hbhNkJXzhJc7HN0deNuJbqZ3zq0XcBVmwbNftQ>
 <xmx:L02EZqgKndQVhA5UEnu4g4waw1j-zchDBbs5UQ1w-Hynp3DBb3ZQsA>
 <xmx:L02EZtoVN6IaWWQbaS0HLDx0E10Uw6D66GJ8DXevBXqrplTG4804YQ>
 <xmx:L02EZli7qzKwYyEy69aZzFM9marh7Djfal5aqdry9dSy4eDjetJf2w>
 <xmx:ME2EZsapHVXEZlMHPJ9Qde4NRBhIFUfWbl9SEbDV_BIrw9MZuhPFoKtN>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jul 2024 14:55:42 -0400 (EDT)
Date: Tue, 2 Jul 2024 20:55:37 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Cc: Ayush Mishra <ayush.m55@samsung.com>, qemu-devel@nongnu.org,
 foss@defmacro.it
Subject: Re: [PATCH] hw/nvme: actually implement abort
Message-ID: <ZoRNKb_u5SW3Ts0e@cormorant.local>
References: <CGME20240702133144epcas5p22b982613bfbfce0e7ad0c74fd72a7956@epcas5p2.samsung.com>
 <20240702080232.848849-1-ayush.m55@samsung.com>
 <ZoQby9WzEesIhuLz@kbusch-mbp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iawZ6SKbd08+BDln"
Content-Disposition: inline
In-Reply-To: <ZoQby9WzEesIhuLz@kbusch-mbp>
Received-SPF: pass client-ip=103.168.172.147; envelope-from=its@irrelevant.dk;
 helo=fout4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--iawZ6SKbd08+BDln
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul  2 09:24, Keith Busch wrote:
> On Tue, Jul 02, 2024 at 01:32:32PM +0530, Ayush Mishra wrote:
> > Abort was not implemented previously, but we can implement it for AERs =
and asynchrnously for I/O.
>=20
> Not implemented for a reason. The target has no idea if the CID the
> host requested to be aborted is from the same context that the target
> has. Target may have previoulsy completed it, and the host re-issued a
> new command after the abort, and due to the queueing could have been
> observed in a different order, and now you aborted the wrong command.

I might be missing something here, but are you saying that the Abort
command is fundamentally flawed? Isn't this a host issue? The Abort is
for a specific CID on a specific SQID. The host *should* not screw this
up and reuse a CID it has an outstanding Abort on?

I don't think there are a lot of I/O commands that a host would be able
to cancel (in QEMU, not at all, because only the iscsi backend
actually implements blk_aio_cancel_async). But some commands that issue
multiple AIOs, like Copy, may be long running and with this it can
actually be cancelled.

And with regards to AERs, I don't see why it is not advantageous to be
able to Abort one?

--iawZ6SKbd08+BDln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmaETSgACgkQTeGvMW1P
DekELwgAuL15MnrD/HOtGQWf7Tjrn8gau2LUKxAtoX7PgvWeznKFMdlewB+ActAl
yaEHFGCS/A0hHl3udLVE5oI9cSQFlLSLeNzsl4Ua8zazNLpdB7fJWy6+1fb/mNx2
RwB36kj/K5oHZUDYntg0Z6K0IlLAXw4vypfk0yUqLu2BaEEqh/6A1xN5s28zxgi8
as7mXX/jvZWaa2nmU+znx4ZC1EHAa2H84st6soZKjTp6r+y8G/Ii7Smlu05Z6TPV
YEcIKGTdFvOzO2cifRHc2sE2r0i6NTsPKE/xaQ2kx3rTEBg0Z/QvXI9qNEYoTqLO
O4tdv93s7TaxTc2fAyScJ47RaBa/gg==
=agQ5
-----END PGP SIGNATURE-----

--iawZ6SKbd08+BDln--

