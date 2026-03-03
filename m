Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33E5EC143A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxPQZ-0006FG-Ch; Tue, 03 Mar 2026 08:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vxPQU-0006F1-7V; Tue, 03 Mar 2026 08:04:38 -0500
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vxPQS-0006UK-9a; Tue, 03 Mar 2026 08:04:38 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 3E46B1D00199;
 Tue,  3 Mar 2026 08:04:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 03 Mar 2026 08:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772543072; x=
 1772629472; bh=9GzEr5kZ1gycyEuKd+3kWdiujLERvK7KTOeMQGu8xeg=; b=G
 18T2I8OzI1OG7/Xxj7pmJHPygxqLbgeHEFOn7Jv2HMSQ4ebYj0C5qlSxIRBiSO4M
 xe2GRUoy5Qgd8NFG9P+zZmio/WUIVZ4kFELrOLDx6lHIAAezUVSk5HkWyhalBT+U
 wRSnnWebvXNom0My98UeOnjwtaBTy8qL8xKxyd2kRRgTJ0TntP9n2BUaOelPmj2E
 ywadkIOF9/YLVITQ/u6KzNtqFQJJ0AoVQrnUKi2jgjp5hMubu5lMqeYAOs9O9O9D
 ODGKGf8XxBzuL4wEblaX3St6gc54Xc2Q8ZAZ6foDn7ZvZ75AajhslOXIB/tyLcPb
 izpphPOKB//1YNh+tAoaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1772543072; x=1772629472; bh=9GzEr5kZ1gycyEuKd+3kWdiujLERvK7KTOe
 MQGu8xeg=; b=4yq031LU3gu0e0N+badbfgM5manJZZr2C3fJPbPoyvRoL4iS02S
 Bvhshx6C+uXjOXxt76BKFx/M83pBiyP8DSh1Dr/B4ShfiCGpRhEk1LGaev1IAW0E
 u0OpPJxxOKI86H5LfcGw/+L3yGaPjXQL6XO8RygePwGf+SY+t9gohkOACfsoKKk5
 g+XKZehftDElU+4TQ4wsrvN1/FAcyNyMiaRLISgfcyhsL45EYn1/rS6UKtIQHz63
 BVnXCF3EmcMQwvn5oSzYbfXYuhnHW1kKlPeY36sa0jr8+Asw+hC1HCBjAxm29ira
 kGKijftxcQ/U91vIer/xUPh4p+m0lIsAYDg==
X-ME-Sender: <xms:X9ymaX0ZDOC8svDbxZIDmEmm6e-hgIBnS2z9900VGYnyz2KqtNg93w>
 <xme:X9ymaQKIlnseey_T2bWBqogt09PaRqdZ2by0eawaGlL_VdRhYA8ZxPqyQbBYM4PoW
 w2o5On9XeemMOj3F4rkDRU2bLoNaOESk-yqzUKsqdg26piLJMl2A5o>
X-ME-Received: <xmr:X9ymaXwQ_G6-5HhkQvUOQvOzP-TzwwAMmtRS7uyLpKBZezbYrYlYt_9YghGAP7sglrKBL3GG5uMabGO5-plJmjn6aPDqc0bpAIisSjut7ap5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtieehucetufdoteggodetrf
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
 hrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthho
 pehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrnhhkrghjrdhrrg
 hghhgrvheslhhinhhugidruggvvhdprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhs
 uhhnghdrtghomhdprhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:X9ymaeVn2wB1z1pD_K3AuY0-UAb2YF-ayIGUBGKRUfwN0OFFAzNaNA>
 <xmx:X9ymaXi4a21ZEHtrgupxbPGvXRQbM67OHpgT86xxqGQ-tUaFZHO2MA>
 <xmx:X9ymaeB4IvIkjGT7HyY8HnbLifRRy4vtbqA6UEZRdsaPLPrpi6fTUg>
 <xmx:X9ymadtFBejKkyIpnws61yxzAa1VXv6_eD-S_VXCs6d6pm63crKJgA>
 <xmx:YNymaU3wZrC_nPhF6m4s6oqgjN6Voih1CZn3gqgpCaW5tDqWubOJui-a>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 08:04:30 -0500 (EST)
Date: Tue, 3 Mar 2026 14:04:28 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: qemu-block@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 pankaj.raghav@linux.dev, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH] hw/block/nvme: re-enable wzds bit in namespace dlfeat
Message-ID: <aabcXIMoH9yRLnrs@AALNPWKJENSEN.aal.scsc.local>
References: <20260301160720.1562509-2-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wu287Kjc4d0qlRsr"
Content-Disposition: inline
In-Reply-To: <20260301160720.1562509-2-p.raghav@samsung.com>
Received-SPF: pass client-ip=202.12.124.146; envelope-from=its@irrelevant.dk;
 helo=fout-b3-smtp.messagingengine.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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


--wu287Kjc4d0qlRsr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar  1 17:07, Pankaj Raghav wrote:
> dlfeat was changed from 0x9 to 0x1 when PI support was added.
> It was removed because we can't rely on unmap and have to physically
> clear it to get the checksums right but that doesnt mean that we do not
> support the bit.
>=20

Minor correction; It wasn't removed because we couldn't rely on unmap.
It was removed by mistake. The device supports the deallocate bit in the
write zeroes command regardless.

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

While most devices will likely zero efficiently, please note that WZDS
being set is no guarantee that the operation is "quick". You get zero
guarantees on this. Yes, sane devices will likely behave, but the spec
uses SHOULD and MAY wording. Not SHALLs.

> [1] https://lore.kernel.org/linux-fsdevel/20250619111806.3546162-1-yi.zha=
ng@huaweicloud.com/
>=20
> Fixes: 146f720c55 ("hw/block/nvme: end-to-end data protection")
> Suggested-by: Klaus Jensen <k.jensen@samsung.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

LGTM.

Thanks Pankaj!

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

--wu287Kjc4d0qlRsr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmmm3FoACgkQTeGvMW1P
DemLPgf+O5MNbdng553kPg2hi0SleutJp6FhTSEZ2/7FWlu48IqqpO0MRXi9DtmP
2kBxq+F0vzNC8RyjIMUd3PYTB8GvOHzOjCxmm96EQ8p5U+1TCu9ykbrfSm8RJguZ
4Aez0Jw4Y1iO2XWdkc8jzXBQ8+Z07ywPxpWx/m53+t/N2ojf6tmOk623NVz01Smm
dNWuVDNjYDYX86KVKxNcuGDALHoxBeJpA+tmx3gDctk/8IjseikqiZ25zlFPTG5e
8AI+e+u1Qq4mp25I0uTfUmTOOgfgkZOKdlX28hJn7X69SGT+mBnZ0ZI2pbvavp/R
v6JFyKrwaI4EN4WXAsK+SO3D6K06rw==
=6utX
-----END PGP SIGNATURE-----

--wu287Kjc4d0qlRsr--

