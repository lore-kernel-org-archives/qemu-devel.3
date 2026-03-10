Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDF7EB1042
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzuF6-0003Pz-IH; Tue, 10 Mar 2026 06:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vzuEv-0003Of-6s; Tue, 10 Mar 2026 06:23:02 -0400
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vzuEt-0001uq-5g; Tue, 10 Mar 2026 06:23:00 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 163B11D00159;
 Tue, 10 Mar 2026 06:22:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 10 Mar 2026 06:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1773138172; x=
 1773224572; bh=tjugxnBVJ2/0dcevPD8F9pLeE0JL/pmlroOQG8+I5JM=; b=Z
 hekG18I7GnG0hsK3VrdF6529ljkPQsRYjZLOBSL0ZmRoT8+HFb1c0en/dH2MCPsO
 AsvDw9bK2PXChafIcynzHYwqA1PfnL/C5LtC7TLXlsGuae9hgTUDH907GciBYPvL
 ktP5pgnhAg7pQX5wpj11boEV2P2bFIAPoSHlr5sZCriVN2SYADCiVnd5Jx4tDxG8
 QgJhdP+gNunvZ8VMK+tJXKLmUowXrXoUBOUOsawYq8nsigETbJISTEdqqebljAxp
 zifcpiQV8MoyOs8XQvkamnDNMGQiTHgOKTnqzpJ3ISLvaa8HwLCJK8iQdxMuAjem
 U1Fo21g1UfXQib3W924OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1773138172; x=1773224572; bh=tjugxnBVJ2/0dcevPD8F9pLeE0JL/pmlroO
 QG8+I5JM=; b=YtEZZASYb957dQFGVESuQJ+9NY64PG+jfCaqDmD3cGq2sVUsLiR
 orvoKit9VUQWdQKIMkWPeZjjgjTPO5POvgP/HIIG4Hm3Gj7JvdMLzMXrRq4KkOlb
 Lj4xNWcvXVBL5VsQRtrG0xOB4q1yTSXRQ3OMxLgZ6jfurLVaEHxAIWJSYaugYxb8
 lmuHPJl+MAFQUbTv50HNq57j2w6Scj0oBxOTP2MmS2cRU1B2DWU1L3GWhv1Izxzt
 LbF+U4/H9JKQgVXbdyb+uZ4Dsg6267V49LtZvg8/SuhE/V4WIb8dzQxqwK6oY5Vl
 ur5BOp6HV/vKJUdvtu10GhdZxrWum25ee7A==
X-ME-Sender: <xms:_PCvafS26tEFgiwWqk0K2aVDENJM2bVc3Z_zZCm6nUpahsoyHU6l9g>
 <xme:_PCvaa19jNQob52c8CMzZKb-5Y0VrSj1REn1ps50HCS_aZEAwAsT50BZ1PDVkGXLO
 fJ3aJ69ng0osiWBtJOXO61hDya3zYW_PMr3hhbHcLHM3czY3gWuh5A>
X-ME-Received: <xmr:_PCvaUtMEQ48qDci-1mg-KfATDtmC8y80mo-Dtnf5gjeazDtULS4G2ehPhiSM5xGJ-tAOQLKrSOXrXd58F2BNDM6-N4xL2rtsL3Qpf_k9xDJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedtkedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepffduvdfhheejudfgieejueeileegveduvdelhfekhffgteetffdtvdekveeileef
 necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhn
 sggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprdhrrg
 hghhgrvhesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehqvghmuhdqsghlohgtkhes
 nhhonhhgnhhurdhorhhgpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghrohdrihhtpd
 hrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghn
 khgrjhdrrhgrghhhrghvsehlihhnuhigrdguvghvpdhrtghpthhtohepkhdrjhgvnhhsvg
 hnsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhn
 ghhnuhdrohhrghdprhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:_PCvaQjZdXXPYqSZJfrt3D2d1J6nJfziysjOeOtXZJevdexxV_a1FQ>
 <xmx:_PCvaV9WF3uH_ywEZeYXFxbvBm5EvDz5HjvAZtnaYAUryYjhxYO68w>
 <xmx:_PCvaTs-BteT0YMrtFGxhn8faYczGCvV9XhEsVvaTYXw5ZbPPxvx1Q>
 <xmx:_PCvaZoPNNoj_-07RHwtkCPLEBK2oZRGMqfzbU_cUVuyTSsqL6VPLw>
 <xmx:_PCvaaTUy7kpz4odspVcsc8etRx_0LQ18syK_EnX-tHG7dX7MO8HphCE>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 06:22:51 -0400 (EDT)
Date: Tue, 10 Mar 2026 11:22:49 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: qemu-block@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, pankaj.raghav@linux.dev,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/block/nvme: re-enable wzds bit in namespace dlfeat
Message-ID: <aa_w-cz2nKsCdkMi@AALNPWKJENSEN.aal.scsc.local>
References: <20260301160720.1562509-2-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4A7bk6oha26a0BHQ"
Content-Disposition: inline
In-Reply-To: <20260301160720.1562509-2-p.raghav@samsung.com>
Received-SPF: pass client-ip=202.12.124.150; envelope-from=its@irrelevant.dk;
 helo=fout-b7-smtp.messagingengine.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--4A7bk6oha26a0BHQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar  1 17:07, Pankaj Raghav wrote:
> dlfeat was changed from 0x9 to 0x1 when PI support was added.
> It was removed because we can't rely on unmap and have to physically
> clear it to get the checksums right but that doesnt mean that we do not
> support the bit.
>=20
> The spec says that if wzds is enabled, then the controller supports
> deallocate (DEAC) on write zeroes. But DEAC bit in write zeroes command
> is only a hint, the controller might choose to physically write zeroes in
> those areas.
>=20
> As we are sending write zeroes command with BDRV_REQ_MAY_UNMAP to the
> underlying block device anyway (if the unmap operation is supported),
> change the dlfeat value back to 0x9.
>=20
> A new flag FALLOC_FL_WRITE_ZEROES has been introduced in linux for
> fallocate which will use the wzds bit in dlfeat to quickly zeroout extents
> using unmap operation whenever possible[1].
>=20
> [1] https://lore.kernel.org/linux-fsdevel/20250619111806.3546162-1-yi.zha=
ng@huaweicloud.com/
>=20
> Fixes: 146f720c55 ("hw/block/nvme: end-to-end data protection")
> Suggested-by: Klaus Jensen <k.jensen@samsung.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  hw/nvme/ns.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
> index 38f86a1726..b0106eaa5c 100644
> --- a/hw/nvme/ns.c
> +++ b/hw/nvme/ns.c
> @@ -75,7 +75,7 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
>      ns->csi =3D NVME_CSI_NVM;
>      ns->status =3D 0x0;
> =20
> -    ns->id_ns.dlfeat =3D 0x1;
> +    ns->id_ns.dlfeat =3D 0x9;
> =20
>      /* support DULBE and I/O optimization fields */
>      id_ns->nsfeat |=3D (NVME_ID_NS_NSFEAT_DAE | NVME_ID_NS_NSFEAT_OPTPER=
F_ALL);
> --=20
> 2.50.1
>=20

Applied to nvme-next. Thanks Pankaj!

--4A7bk6oha26a0BHQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmmv8PYACgkQTeGvMW1P
DencBwgAqqu3dkMY5XpnCOH1gBLsydRxFGbz90fkZavl93YZQFIX7Q765jRDWKnk
FisxbkDzsql6/k2QJ+5A+EpZpxET4jjxMX/uT0PcPQMKjR7tGRUfJjSt9mzkiL8d
K2+dc0p3nfxAdoOx2biu8uw7VgaLELLZs5hfXcUlHbJqmqxaoxunvn1rB6tgQX4V
Af0FNqtF+YMgOoNt2jZYbMObpkXsjhFS7GEwXAXHQFkD41bWlbKGTl+by32sC/TF
B2NFpq2wOYyesfjZ36GIk91NZJdlitOShRAvyA9vzPDDD4XiWDiXZVN8CPrwaONX
8Yfh9lt93otc5myjDZszofxFvYVDjg==
=t452
-----END PGP SIGNATURE-----

--4A7bk6oha26a0BHQ--

