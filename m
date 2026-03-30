Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C94BFB3CE2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w78aU-0002t9-AS; Mon, 30 Mar 2026 05:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1w78aH-0002qC-Qh; Mon, 30 Mar 2026 05:06:59 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1w78a9-0008Oc-81; Mon, 30 Mar 2026 05:06:53 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id CC5A0EC01D3;
 Mon, 30 Mar 2026 05:06:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 05:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1774861604; x=
 1774948004; bh=uArIj+6txqa3ZBAl5RdVWl7BayKDGz0f94+Z5vAak50=; b=Y
 3c/lnMaKxDwf8s2ZrNd2n8VUdhwsUOltQ4nKEKKW0Rw5xzy8duuQjMCeNS9RKKrV
 6BkGp+6VKzEVXPfH0OiQMJ0pNaxkXryzOTP2fSP/gF4ePG9gSn6FymyNrFCE9NsS
 kI0NbMKAhwysjenqgw8vSfd6sZiP5lZcx1d+xn3akopfuvm/80nPdyKouQQkMnZj
 VnOb1xdZCpmgx9n6ujeNOYICdC8ItRbUTGQM09RM88ogfK1XTyObKKfcRt8FbedD
 9uq8ecRbyytRfFBJOBsR1vn7S/nPmd97h+isyxqcxW9vWoILDPkiiB5wL3CsE8o0
 clrEYjGQczZqD8nLECL7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1774861604; x=1774948004; bh=uArIj+6txqa3ZBAl5RdVWl7BayKDGz0f94+
 Z5vAak50=; b=ONx8P5u5pG/eZFWK0mi6KyVpfm4AFOlQDmQsXmJiq/IjvAl7XgQ
 zE/0fkPw5EID/t3tFn5+MeXKNnkhpIb7HJ14XdP6Mzlh6SmUQsAOMqxIHsLKNaby
 2/7KqeFiYP+xAyUpykQr/WVmVXYgfZ5QelkofCBO1ABMfkUqe0u4Y+JFmdisNRTW
 rGalRU+oYo4oFRbWKgxCxD96EeFton4FcKA2XO4bNe4DF6jO84uLmy+o30uIOJw/
 WN9MxunwiaLs9C2cUDlL/6Tg4bJt/257OMZhLLdEOOBfVul/lSmU/zK03RDXHwil
 JuRwsnohgWLnwYtak9miQZGOnUH94EbGbnA==
X-ME-Sender: <xms:Iz3KaZVKZ8L3ac_dAheOTRGFlAJVqrFBoxoyzaHYxXca2HDjl6HBEw>
 <xme:Iz3KaWKGJAIrcscMkZtuYVAtQHmIVzn5OAPfqU-0V-dPXz0mNxj5_qmlyhKywgqo-
 x4GsIZ8gXJspHJJdxTiZyb21EE0AS9v-UC8fH-Zh9qSMOs95lQ8lzw>
X-ME-Received: <xmr:Iz3KaZ18RwyQGjQMaiNovDJ-lZdaDZWyS9ZV2W8Hpn2iUXk9AgvwCWmxvbMk7ifELZVJ-44LWPqq4cZ4dFVaCQSJRZDGR-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeekheekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepffduvdfhheejudfgieejueeileegveduvdelhfekhffgteetffdtvdekveeileef
 necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhn
 sggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhjth
 esthhlshdrmhhskhdrrhhupdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhn
 uhdrohhrghdprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdroh
 hrghdprhgtphhtthhopehprdhrrghghhgrvhesshgrmhhsuhhnghdrtghomhdprhgtphht
 thhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehksghush
 gthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghrohdr
 ihhtpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgtph
 htthhopehqvghmuhdqshhtrggslhgvsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:Iz3KaTIelqvILy_dxFbmP6-1Au7eX_9LiLup5Epk4u1-i9V_LOFKYQ>
 <xmx:Iz3KaUifQXzEg0cukqq-RafcnjEaGRWaICciJAYk7qdob3cvBv9U3Q>
 <xmx:Iz3KaTD5bfwRCa4ePdFRIk188EwNwK-H8HPqLeA2hyuQ-6TPtagGrA>
 <xmx:Iz3KaW6itDQEMnEE9ySYaEmrW3zsHcx-9gP6dvABj-w7rdMemzN41A>
 <xmx:JD3KaU_MDGcdPRMEhRLttn0XCQDp-jKNbbh4dQH5TiEkTDK-lq3d-NuB>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 05:06:42 -0400 (EDT)
Date: Mon, 30 Mar 2026 11:06:40 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pankaj Raghav <p.raghav@samsung.com>, Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PULL 1/2] hw/nvme: re-enable wzds bit in namespace dlfeat
Message-ID: <aco9IJkNY_t-rfKY@AALNPWKJENSEN.aal.scsc.local>
References: <20260326082350.17374-1-its@irrelevant.dk>
 <20260326082350.17374-2-its@irrelevant.dk>
 <445c4892-b403-49dd-b676-f7d1c07ebcdd@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uu+knFf4qzO2Xe+X"
Content-Disposition: inline
In-Reply-To: <445c4892-b403-49dd-b676-f7d1c07ebcdd@tls.msk.ru>
Received-SPF: pass client-ip=103.168.172.149; envelope-from=its@irrelevant.dk;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--uu+knFf4qzO2Xe+X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 28 09:57, Michael Tokarev wrote:
> On 26.03.2026 11:23, Klaus Jensen wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> >=20
> > dlfeat was changed from 0x9 to 0x1 when PI support was added.
> > It was removed because we can't rely on unmap and have to physically
> > clear it to get the checksums right but that doesnt mean that we do not
> > support the bit.
> >=20
> > The spec says that if wzds is enabled, then the controller supports
> > deallocate (DEAC) on write zeroes. But DEAC bit in write zeroes command
> > is only a hint, the controller might choose to physically write zeroes =
in
> > those areas.
> >=20
> > As we are sending write zeroes command with BDRV_REQ_MAY_UNMAP to the
> > underlying block device anyway (if the unmap operation is supported),
> > change the dlfeat value back to 0x9.
> >=20
> > A new flag FALLOC_FL_WRITE_ZEROES has been introduced in linux for
> > fallocate which will use the wzds bit in dlfeat to quickly zeroout exte=
nts
> > using unmap operation whenever possible[1].
> >=20
> > [1] https://lore.kernel.org/linux-fsdevel/20250619111806.3546162-1-yi.z=
hang@huaweicloud.com/
> >=20
> > Fixes: 146f720c55 ("hw/block/nvme: end-to-end data protection")
>=20
> Shouldn't this one be picked up for current qemu stable releases too?
>=20
> I'm picking it up for 10.0 and 10.2 series, please let me know
> if I shouldn't.
>=20

Michael,

Yes, please include in stable.

As always, thanks for being vigilant and picking this up!


Thanks,
Klaus

--uu+knFf4qzO2Xe+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmnKPR0ACgkQTeGvMW1P
DemchQf9FEdjxAurwqz8R+vSfSJjlfpnLpiN5mGB8IRSlWRIL8PuFizeo1yJqsl1
/jaYNcrenGg3ha+G7rHL7kfU+TNkrVLgEVALV8bp4euf6zfuNB83hDLBVHzT2LcN
Zat/cOPKe9dwkbBJviqRXnzcTgZMkyHUpZNYkGTQWZ1hHdpnqMccTCFn6OqMMPYl
muqTQdEYKrXYMzBJvTpigtzt0m1c9ONGV0p2QNyQqtmE2GRw3omKyS8hbR6geWrm
USVCDhUvZSR0fdwbkumEZ+Qgc/nCdGwWXlODAbuLwCbUQxn4b/BTcS6eDnWHJ1hv
Tw8d9wb7l/k7hEmaRkmAZJeAa/0+0w==
=iPGC
-----END PGP SIGNATURE-----

--uu+knFf4qzO2Xe+X--

