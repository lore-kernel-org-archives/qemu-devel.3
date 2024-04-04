Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6409FCD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 13:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsMjJ-0004hX-My; Thu, 04 Apr 2024 09:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rsMif-0004Rv-M2; Thu, 04 Apr 2024 09:01:40 -0400
Received: from wfout7-smtp.messagingengine.com ([64.147.123.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rsMiX-0008UG-9y; Thu, 04 Apr 2024 09:01:27 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.west.internal (Postfix) with ESMTP id AADE01C0009D;
 Thu,  4 Apr 2024 09:01:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Thu, 04 Apr 2024 09:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1712235678; x=
 1712322078; bh=PTSoAqhg9DRQadSdrSdba4Men32J4rAqiYRSBg13j28=; b=T
 5g8YlPx/2qPK/W5+lzGp4bH2vGx8DIQKMO6Z/LpaQup5VQ7cmiEVZ0TC9WcB/CRF
 DUoEmPY9gQCDQTZorJh9F+xVixn020X8/gW43qdpL/m9mMaMaudt0SoXPfarWwZz
 3eOwg0VBTAa7Bar1uS7GPEW+c7kx0HyjEF0WNrB+8b5tCX9Pzqv3cwqN7uJmk/sZ
 nTqTRpvk/wJ4W6unZlC+bHHf/qZCBF1JIsPSz1vhSeW2SB2EsiTpHNcHIakVoFxU
 8tEx0C6LY/gjLlFHj9jj/XsTATqNB7Kp5TUelS4mxsH2PDczL9Zci7okAjGUhuJ9
 KI7k5Mql47P1Y0SK5dBlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1712235678; x=1712322078; bh=PTSoAqhg9DRQadSdrSdba4Men32J
 4rAqiYRSBg13j28=; b=HZ42P2ypYr9ujOE6f+CD8qeI84gdoU+cEHKtwCcdRbK8
 yuBl79wG05OrubDwQBRG7pgjZOHDcDeY3999VrZ9qO+HWiNXAR27VMre6ibV8z5l
 JZl8vJ2QdzLpmGFfPxlZ36HiOHrWHpjIUFfjs9Xoz2/awjyWiVM5cLdKSk2gnVUm
 xg/AmUjtS0Ctl+VYfM8JG7sK5jPW6qgCIN6Vt+OL3oiQyc99mSbuxc2Tv4n53jNv
 MPCnVsrt+WBop1rfZGhfKj23+PR6fgIotHfVbpa4LAMbPeNPU2qpnl69gZRLQ0i9
 IqW1H6tjcY5rD8TyidPC/KXzN/Pj9yM2bXCxwuIFYg==
X-ME-Sender: <xms:naQOZrd8XrAYIgcliNQO35ltVdM_igbrBqk0HFCq0RufTuIvM95LYQ>
 <xme:naQOZhOg8e7FBIKoF4lvE_S2XQejD8TMD6rvWRS2K0R0hphOFnMuMjXBVlZ61cz3I
 W9d5Ecd8t77uOKVm8k>
X-ME-Received: <xmr:naQOZkiSltVa1oijO3xU7xCWmMKRiwzrkqw-jnUHNRaYZseDBr2i8_87vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
 jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:naQOZs9kzMey64iWyOvfDLrSohwLWHQ07Z-wOQPdP5zUCABoexnevg>
 <xmx:naQOZnuqsGEJ0y55wGaRi4UCOQW3mR3-kIzl0Ol4LcnUPMZTlCmQkQ>
 <xmx:naQOZrG0raUCqztkIngL4zkRjfvb4SPIQlIXyMVZamiIngqIHRCYUg>
 <xmx:naQOZuOGFh94_XjRGrzkjJQAmdtpMLp1uw4c04G2D7-IzigoMrofmQ>
 <xmx:nqQOZtCcrugCmVBhTM1PLB7txhEl_1FGjvM6dm6H8cS5izSifYWiwQQd>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 09:01:16 -0400 (EDT)
Date: Thu, 4 Apr 2024 15:01:12 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: John Berg <jhnberg@amazon.co.uk>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, foss@defmacro.it,
 qemu-block@nongnu.org, John Berg <jhnberg@amazon.com>
Subject: Re: [PATCH] hw/nvme: Add support for setting the MQES for the NVMe
 emulation
Message-ID: <Zg6kmPGVZOVhfDbo@cormorant.local>
References: <20240404120418.1611513-1-jhnberg@amazon.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QXi+KMsfXN46qA57"
Content-Disposition: inline
In-Reply-To: <20240404120418.1611513-1-jhnberg@amazon.co.uk>
Received-SPF: pass client-ip=64.147.123.150; envelope-from=its@irrelevant.dk;
 helo=wfout7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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


--QXi+KMsfXN46qA57
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr  4 13:04, John Berg wrote:
> From: John Berg <jhnberg@amazon.com>
>=20
> The MQES field in the CAP register describes the Maximum Queue Entries
> Supported for the IO queues of an NVMe controller. Adding a +1 to the
> value in this field results in the total queue size. A full queue is
> when a queue of size N contains N - 1 entries, and the minimum queue
> size is 2. Thus the lowest MQES value is 1.
>=20
> This patch adds the new mqes property to the NVMe emulation which allows
> a user to specify the maximum queue size by setting this property. This
> is useful as it enables testing of NVMe controller where the MQES is
> relatively small. The smallest NVMe queue size supported in NVMe is 2
> submission and completion entries, which means that the smallest legal
> mqes value is 1.
>=20
> The following example shows how the mqes can be set for a the NVMe
> emulation:
>=20
> -drive id=3Dnvme0,if=3Dnone,file=3Dnvme.img,format=3Draw
> -device nvme,drive=3Dnvme0,serial=3Dfoo,mqes=3D1
>=20
> If the mqes property is not provided then the default mqes will still be
> 0x7ff (the queue size is 2048 entries).
>=20
> Signed-off-by: John Berg <jhnberg@amazon.co.uk>
> ---
>  hw/nvme/ctrl.c | 9 ++++++++-
>  hw/nvme/nvme.h | 1 +
>  2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 127c3d2383..86cda9bc73 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -7805,6 +7805,12 @@ static bool nvme_check_params(NvmeCtrl *n, Error *=
*errp)
>          return false;
>      }
> =20
> +    if (params->mqes < 1)
> +    {

Please keep the `{` on the same line as the `if`. I think checkpatch.pl
should catch this.

No need to send a v2, I'll fix it up when I apply it to nvme-next :)

Thanks!

--QXi+KMsfXN46qA57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmYOpJcACgkQTeGvMW1P
DelqbQf/eYJP+zY4ALsofWCh9Uah62cI50J80cKwHxxUmoNxE1HwoCK4yEnfSlbJ
1IgaVWQPslXIwLWNbH021GY6RUiu5KO3/mXq6Pc3Y/zZWLj5bA6aiGvMxxpiXFy3
kz8/B+7e67YOVU+qGHvVyu9HSSQ9Kq7Q5D9UleCGGeFbSGrSMS/bT4iwwNceIMW/
VtYqc1Knmn0ypyh9EKTFJFt+oRcBWqJ28WBEVjLxo7aKVwY/bQUUNLyhi1xrFWRn
1/aazB8PPO7iVAH5ulyfNpiHD6ubST45FiUEBdqABW48WXwYYa8m1LF+/Hf5uDcY
wLSnOccbeuo3PPAGcb4H1OJjq5w2/Q==
=QYvO
-----END PGP SIGNATURE-----

--QXi+KMsfXN46qA57--

