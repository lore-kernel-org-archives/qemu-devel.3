Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4319C87FDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 09:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uirmy-0007vJ-6d; Mon, 04 Aug 2025 05:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uirjx-0006P6-Rx; Mon, 04 Aug 2025 05:44:24 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uirjv-0007Qh-7h; Mon, 04 Aug 2025 05:44:21 -0400
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id AB2EE140009A;
 Mon,  4 Aug 2025 05:44:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Mon, 04 Aug 2025 05:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1754300653; x=
 1754387053; bh=jpnt22zTHvEUsgW/BSYGgA1OXSj3OtziOPzXW38pL3Y=; b=R
 Cydhr1YRske9XpipiUtJsp4o2BRo/t/kEebMPj5m6Zcah+3VuFKiHXPuHnVq/uQw
 DuaAYC4o8CdoI3On4PY6PyBwtgMJL+6Gy66jj7PmPV+QX0waAJgYkvbKxYq9gYWG
 flmj2aFUsPIJ4dC5aiCE1nTUKR/Rf7vbv3mqW7d5TcWOjq0UNZvU59ga+Ip732s0
 8j3Bdx1XG3l2/QADkQiQMNfM8NNSocnu3y8l62egSfvnITo444EjfUoM+bAjZ4z3
 4HTS4jxQq8+N1k8il8WT1JoGa3NkhhdN88UIYb1W7oxAzA5kZo6vaRgGcbaNrCHY
 lm6Gp6R5iyP4IjmNGXqhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1754300653; x=1754387053; bh=jpnt22zTHvEUsgW/BSYGgA1OXSj3OtziOPz
 XW38pL3Y=; b=BiTF2lMO6xnFDvqjq/oSS/s/4te9RX2TBUxpc9YZPf+H9aLPOmg
 30g1wsnI+EYIBUJV/Akz5HDDZjTWjUDbBRmTbFo75u0BAiUBwT4VGIGlTRhReAXC
 fD37NC+TTG8JGcR1Hh9R5fzV7vh+uuJfidtNurOUQBLfV9pBBjjZv5l9+xWmqKoZ
 TdnYbTLNEBrh3ZXrzsca5y/GaZyzjIxZ3IulgjVcEZAkhwm77TBciJdialKodyNQ
 Tb9im/KaqHKj68OqC7b+iES2aAwSKVbSjj3wPpgjGqw1hXsN7YhwZBjSePzaO/B1
 OI+U9gtnudhhsbrT8Se5ll1JUmkzaOC5L4g==
X-ME-Sender: <xms:7ICQaNSTcHta_EcbNjlXTjbG-dQn_Oa34HgohlkHyawHgj56oefWwg>
 <xme:7ICQaMJ8Gltfz6r68AHNox_y6--ZQhDIkJBnIK5u1pkLaHPL7zc3VhAR-H4kqt8Xq
 R3u6TAUPCK76ho-gDE>
X-ME-Received: <xmr:7ICQaDBRYvDb1tI6nMOwe9eVFZMlGIfsjzmNWT-oazzqKzBAoyPKC7Na>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepfeeuhfeljedtueetveelvedtkefgkedukeehheettdfggfefveduhfetudfhfeeu
 necuffhomhgrihhnpegumhgrqdhhvghlphgvrhhsrdgtfidptghtrhhlrdgtfienucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhr
 vghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuth
 dprhgtphhtthhopehksghushgthhesmhgvthgrrdgtohhmpdhrtghpthhtohepqhgvmhhu
 qdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdqsghlohgtkh
 esnhhonhhgnhhurdhorhhgpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhr
 ghdprhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:7ICQaFBEIMpM5-0QzElJCrX4KCDcGItPsix4FYYkNae0XwHJn9RAuw>
 <xmx:7ICQaFAgfuxMW1_YBlsuybz5UGPNE53l3IZvQLDU-ek-kkoDc-Rx6Q>
 <xmx:7ICQaApfkWF7KYFKOAnapIYIxYco1YiS-3_Y5MmKbv9iDf2RryXqMw>
 <xmx:7ICQaPnMfHNh5RzsU7AF5lSWtO6zBbs-EpdY5sM657V4_hT76DnG-g>
 <xmx:7YCQaE-AhHOG-ha_te98rYMhLNFGeMtjYPJZmBMQCkQdimTfIfJr4rUD>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:44:12 -0400 (EDT)
Date: Mon, 4 Aug 2025 11:44:10 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@meta.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] hw/nvme: cap MDTS value for internal limitation
Message-ID: <aJCA6oB1LZdHbAz9@AALNPWKJENSEN.aal.scsc.local>
References: <20250801142457.3012213-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zq02knK2vAlAjncK"
Content-Disposition: inline
In-Reply-To: <20250801142457.3012213-1-kbusch@meta.com>
Received-SPF: pass client-ip=103.168.172.153; envelope-from=its@irrelevant.dk;
 helo=fhigh-a2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--zq02knK2vAlAjncK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug  1 07:24, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>=20
> The emulated device had let the user set whatever max transfers size
> they wanted, including no limit. However the device does have an
> internal limit of 1024 segments. NVMe doesn't report max segments,
> though. This is implicitly inferred based on the MDTS and MPSMIN values.
>=20
> IOV_MAX is currently 1024 which 4k PRPs can exceed with 2MB transfers.
> Don't allow MDTS values that can exceed this, otherwise users risk
> seeing "internal error" status to their otherwise protocol compliant
> commands.
>=20
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  hw/nvme/ctrl.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index e764ec7683..5bfb773b5a 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -8335,6 +8335,11 @@ static bool nvme_check_params(NvmeCtrl *n, Error *=
*errp)
>          host_memory_backend_set_mapped(n->pmr.dev, true);
>      }
> =20
> +    if (!n->params.mdts || ((1 << n->params.mdts) + 1) > IOV_MAX) {
> +        error_setg(errp, "mdts exceeds IOV_MAX");
> +        return false;
> +    }
> +
>      if (n->params.zasl > n->params.mdts) {
>          error_setg(errp, "zoned.zasl (Zone Append Size Limit) must be le=
ss "
>                     "than or equal to mdts (Maximum Data Transfer Size)");
> --=20
> 2.47.3
>=20
>=20

Hi Keith,

Looks good.

The dma helpers can actually deal with this, given a relatively simple
patch:

diff --git i/system/dma-helpers.c w/system/dma-helpers.c
index 6bad75876f11..fd169237efb2 100644
--- i/system/dma-helpers.c
+++ w/system/dma-helpers.c
@@ -158,6 +158,11 @@ static void dma_blk_cb(void *opaque, int ret)
         }
         if (!mem)
             break;
+
+        if (dbs->iov.niov =3D=3D IOV_MAX) {
+            break;
+        }
+
         qemu_iovec_add(&dbs->iov, mem, cur_len);
         dbs->sg_cur_byte +=3D cur_len;
         if (dbs->sg_cur_byte =3D=3D dbs->sg->sg[dbs->sg_cur_index].len) {

In hw/nvme/ctrl.c the checks can then be dropped:

diff --git i/hw/nvme/ctrl.c w/hw/nvme/ctrl.c
index 518d02dc6670..4d8f678cfda5 100644
--- i/hw/nvme/ctrl.c
+++ w/hw/nvme/ctrl.c
@@ -849,10 +849,6 @@ static uint16_t nvme_map_addr(NvmeCtrl *n, NvmeSg *sg,=
 hwaddr addr, size_t len)
             return NVME_INVALID_USE_OF_CMB | NVME_DNR;
         }

-        if (sg->iov.niov + 1 > IOV_MAX) {
-            goto max_mappings_exceeded;
-        }
-
         if (cmb) {
             return nvme_map_addr_cmb(n, &sg->iov, addr, len);
         } else {
@@ -864,10 +860,6 @@ static uint16_t nvme_map_addr(NvmeCtrl *n, NvmeSg *sg,=
 hwaddr addr, size_t len)
         return NVME_INVALID_USE_OF_CMB | NVME_DNR;
     }

-    if (sg->qsg.nsg + 1 > IOV_MAX) {
-        goto max_mappings_exceeded;
-    }
-
     qemu_sglist_add(&sg->qsg, addr, len);

     return NVME_SUCCESS;

This allows >2MB transfers with PRPs. However, it is not a clean fix
since it does not deal with the issue that remains for the CMB (which
uses the blk_aio api directly.

I'll queue up your patch for now. Thanks!

--zq02knK2vAlAjncK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmiQgOYACgkQTeGvMW1P
DemEhAf/Tj4wFi8drWhAtSc39we7beTXJJRZdrG9Wtqb5tEVBdGPSh84dKJ2CxQr
yoFtdXxJXNtRJPnj1Dy9DzwezvYPuQCZhd0yE35UPBjPixqRibND6BNz2y0ioTkk
p9V4vmKvLkknPmhE36f/2k0Uz/yJTf3+zSrSg8/PfqenD1hzPJuvfNf1d6tejhcr
aGK213soWMnGJ0hcgww4UhiaxdVOE8bQH9WaiKTmTu1CtZW0QhzyO21dKCqdY3fr
k+WpvnWPbuo4zz5EgtxigEd8XBtCweOAnVMLU15a+ZgUlzssYML+ez4ae9yQ8xAn
7uMm3uyJbk6lQsADXAYf6xYsM9XpQQ==
=emtF
-----END PGP SIGNATURE-----

--zq02knK2vAlAjncK--

