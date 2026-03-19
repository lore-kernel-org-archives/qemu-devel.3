Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33751075289
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w39u2-0002Ak-7P; Thu, 19 Mar 2026 05:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1w39tz-000270-II; Thu, 19 Mar 2026 05:42:51 -0400
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1w39tx-0007Zo-6M; Thu, 19 Mar 2026 05:42:51 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 92EC6140023F;
 Thu, 19 Mar 2026 05:42:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Thu, 19 Mar 2026 05:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1773913365; x=
 1773999765; bh=uQndlip3J+OAmjRvc28tUyrn+y82Q/mkkL3Mnhxrqlw=; b=W
 HffookgfwfhvEpGWlUOpZvvihJRnS1qWUJkRmRjDZpxNlB65Zry5QbH3zdha7Oq4
 MQcIuXoDtIo4deG6VkNEIkyyyzR/Q088mdIEie4aSW1l4VxERdsFJPQl8rOeTp4U
 EtMgtfCG3E59ckdXJlrVgOZr57DR8TUJtKWAPNh/6T74zCAKbSRNNtRCRX6q3Mbg
 t7KpjBlxbdDT/IVxDjAFdgwHq4vgEQjiZaGsUHYGBGK3oNLlv+UyXGXzDZf3dzDU
 wAygrTKgVn1eCb7PGTHJ+di43dwyxry1K2rFiORO6YsEo202u16Mlmf8Yp7GULBl
 K75GkSSLVv5pKbEL0XF5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1773913365; x=1773999765; bh=uQndlip3J+OAmjRvc28tUyrn+y82Q/mkkL3
 Mnhxrqlw=; b=dEnWvwzACvdWhbneDnYr9xIqmg+Ozq853bXXNl5pZFBgH5kcrsy
 XT6WcShAVcEQaWrwjZnk6lDMojIoXYSfeoJZ095M/4LB0fFGUVNj/L+Je30LmZ29
 Xyq52ewW0WTXInqPx8KMCi07I1LaNTucUNvBp/luz2HLB5AdTM/gD3rlgzeQffP1
 HpKNDnZ/R+wfV6+DAfjMgnoYGmVP/Ui1oZ9txv1CP/Fncg+Z5B3kERT7dRaDOlaG
 f0kx/tAwPBMFgd7c76EhvPqg9IMb11c9L0EgQTxjLOTCK8c9Rq1LeekKJBNaaCOw
 NsuFK3h+lNs7T+Daox+flu7o9Zj2gUGoSnA==
X-ME-Sender: <xms:FMW7aXDr5owpjsyHcSF7nbGKWlrT-jHLt3T9dg6qO0g11KNiYw2ytw>
 <xme:FMW7aYf9SDDy_2_figgYsazB6mVdcFHqC6OzhSoBYJhCwF7xFETd24rsgr4drunJu
 TksiKkuuwAL3vK5QtWQETymeTEnT26M0DZzM2Z41UGxeq7UB4wzYnlr>
X-ME-Received: <xmr:FMW7aRmzV_tztvZDGFl4KqGEz0vQG0PVblZ-d6YXu9cpBhJbQdudp_foshIKHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeiieekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnheptdejkeevudekueegledvleehgffffefhjedtkeeugffhledvffetheevveegudei
 necuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhn
 sggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghigi
 hurghnlhhitddufedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghv
 vghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdqsghlohgtkhesnhhonh
 hgnhhurdhorhhgpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgt
 phhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhopehqvghmuhdqsh
 htrggslhgvsehnohhnghhnuhdrohhrghdprhgtphhtthhopehithhssehirhhrvghlvghv
 rghnthdrughk
X-ME-Proxy: <xmx:FMW7afG7GZdGObKR5JM_t9hbRZTELiPSZ1_8U2clTHJg1jOkColvYA>
 <xmx:FMW7aZ5nP6BkMbBD3fWLANl6cO3cD-dDD_OWJEIJKjFySh-dQ4xDMw>
 <xmx:FMW7aXmAbkpwMjesKP-iYk0p2DcoC6e0lJ2QNyxeUSYNZx_SsYzxlA>
 <xmx:FMW7aeo9up1VHUsC8uEVaDgyF4dRVN5efDHNkWpni5SvIN3tSmcWMw>
 <xmx:FcW7aV3X2xAdyiDe7bPTcH03tnOe8HqgLnX_0kWgHAJH9kaDyeUMdzvA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 05:42:44 -0400 (EDT)
Date: Thu, 19 Mar 2026 10:42:43 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Kaixuan Li <kaixuanli0131@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kbusch@kernel.org,
 foss@defmacro.it, qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/nvme: fix heap-buffer-overflow in nvme_abort
 (issues/3348)
Message-ID: <abvFE-l4WYHjrisP@AALNPWKJENSEN.aal.scsc.local>
References: <CAGVefVU7AbunJKhw9_R7jFX+RJi81QLimnkOuDM8wwvG++hesw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UgBAi9ymMeCoZoGd"
Content-Disposition: inline
In-Reply-To: <CAGVefVU7AbunJKhw9_R7jFX+RJi81QLimnkOuDM8wwvG++hesw@mail.gmail.com>
Received-SPF: pass client-ip=103.168.172.159; envelope-from=its@irrelevant.dk;
 helo=fhigh-a8-smtp.messagingengine.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DEAR_SOMETHING=1.973,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
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


--UgBAi9ymMeCoZoGd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 19 17:12, Kaixuan Li wrote:
> Dear Sir or Madam,
>=20
> Since my institution email address doesn't allow git email, I sent the
> patch manually as follows:
>=20
> In nvme_abort(), the submission queue pointer is dereferenced from the
>   guest-controlled sqid before validating it with nvme_check_sqid():
>=20
>       NvmeSQueue *sq =3D n->sq[sqid];
>=20
>   Since sqid is a 16-bit value (range 0-65535) taken directly from CDW10,
>   and n->sq[] is typically only max_ioqpairs+1 (65) entries, a malicious
> guest can trigger an out-of-bounds heap read by sending an Abort command
>   with a large sqid.
>=20
>   ASan reports this as heap-buffer-overflow in nvme_abort.
>=20
>   Fix this by moving the array dereference to after the nvme_check_sqid()
>   bounds validation.
>=20
>   Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3348
>   Fixes: 75209c071a ("hw/nvme: actually implement abort")
>   Cc: qemu-stable@nongnu.org
>   Signed-off-by: Kaixuan Li <kaixuanli@ntu.edu.sg>
>   ---
>    hw/nvme/ctrl.c | 4 +++-
>    1 file changed, 3 insertions(+), 1 deletion(-)
>=20
>   diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
>   index cc4593cd42..be6c7028cb 100644
>   --- a/hw/nvme/ctrl.c
>   +++ b/hw/nvme/ctrl.c
>   @@ -6111,7 +6111,7 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeReque=
st
> *req)
>    {
>        uint16_t sqid =3D le32_to_cpu(req->cmd.cdw10) & 0xffff;
>        uint16_t cid  =3D (le32_to_cpu(req->cmd.cdw10) >> 16) & 0xffff;
>   -    NvmeSQueue *sq =3D n->sq[sqid];
>   +    NvmeSQueue *sq;
>        NvmeRequest *r, *next;
>        int i;
>=20
>   @@ -6120,6 +6120,8 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeReque=
st
> *req)
>            return NVME_INVALID_FIELD | NVME_DNR;
>        }
>=20
>   +    sq =3D n->sq[sqid];
>   +
>        if (sqid =3D=3D 0) {
>            for (i =3D 0; i < n->outstanding_aers; i++) {
>                NvmeRequest *re =3D n->aer_reqs[i];
>   --
>   2.34.1
>=20

Hi,

Thanks!

I'll queue it up on nvme-next.

Klaus

--UgBAi9ymMeCoZoGd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmm7xRAACgkQTeGvMW1P
Dekh3Qf+K6RP+w9NDtNLwmH3EByOetR94f+s9sN7cAt0WDD33b8MLN7DQ3rbcHeB
ZSnEa0ffZoAonXkHQXwk0LKPpZ7Zyowfi2zBrsdmi4vvs9uYZBXwVIIRGdeqPZp1
RZ7RX+6E+X3Wv6QK2R9mm2NEoyTujbf6xcCVP9c/JeW02mRygwukJe1Ok8QYAvvS
S7JDQRPlabzDZuzU1M3B+qcML1b3PlHwsYjW1TRVjGy7JtglPaKbW7tWXJTIHKQS
E6FkMWiUy7BmjFaT5q4gP1dWQ9xjfCG6tWvGqCxZptwI5VtgcdOnofeHx2CjeRnT
XJv5muLYTVzH6NaxD6wtAbKhlB0VTg==
=AhPr
-----END PGP SIGNATURE-----

--UgBAi9ymMeCoZoGd--

