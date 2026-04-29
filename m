Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446EEFF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 06:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHyGu-0003Sy-Vq; Wed, 29 Apr 2026 02:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wHyGh-0003O7-2o; Wed, 29 Apr 2026 02:19:31 -0400
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wHyGd-0006eo-2O; Wed, 29 Apr 2026 02:19:30 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 1C8427A00D7;
 Wed, 29 Apr 2026 02:19:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 29 Apr 2026 02:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1777443563; x=
 1777529963; bh=gHm5gi/U9SZ1qunpAMomYsZ9bbFJ8GKfUxUZpAE0ABc=; b=f
 3rfOPZuu28zfJ/74KcdVby9SlU3sEY8QLDXEYCI7OEDfJ2LmRTyqn8ILQffawXLN
 XG0PpKkuy8k9eK5MUHzEXl12294Nd/rnUBoIcrXml8KP940Zph3WDRBcFdIeG7Q5
 n0lUWfdYbgESev1LdIEcXgYdy8sGjGXEilJ2XQ8W4nsRqjvKIx9IlVJDDEsf8SLa
 3Aql9NrPhVA39yk4HQD0FHeMKE9s/ObaeR05KVvwCzyTsYDFHrOfXLkCR9MFoUsC
 X9IBTU7NI+AaKKq9i80ZBUEg6VJHyB82h40jqUazAcFCrzXcWxhj+rAVn02aih44
 Ptp2l3lJcAeL+2yRhptfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1777443563; x=1777529963; bh=gHm5gi/U9SZ1qunpAMomYsZ9bbFJ8GKfUxU
 ZpAE0ABc=; b=dccmUdqHZCtzmIe95TyU7lD3Ytgww6D7P9B6N80T73AenJ3hYy+
 8Ad18YXRjopPKzYPtX++4H0yi2GEG+yuWaXrGXkuAdIyaNh2Ews97vFdfLq948GC
 rqXTtYV+ZI8YqgjYVI912z2l9C+amM2oL7ZWkCCdsRWxJiOkIjMJ3JlZlqkf5ZmK
 Vu4XjqlnKkc5yQgftxthI//97GuwRrRfsAly+MmhdZm6qC+ILejlOChUdr0Hv0Zu
 UNA4IM+bC47G28IBz1TimuwpEHLdbsVHCslazNAkShKuTHz4hiBx7hpcRSNfrjju
 DwSZVBfVoy4R+2z3/XpCuUQkqyDGK807k0w==
X-ME-Sender: <xms:66LxaYuqxR1jd_GHPC4nL3RZcvbOGttFb0pIB4LCSS8qEoK06lxcBw>
 <xme:66LxaQKFM-U2NaeEV8HxsRuJSlKJHuxgwpIeV0q9I1veQXwANEP-sUJeGAAWA42U2
 iDqJELBmXiiBkFoDKVhcNjMKIdypktHNRXBiZKaKn93EVd44ViNENM>
X-ME-Received: <xmr:66Lxacc3yecByJFau1Qy16RABKRwImx9LDeKDLJ2u-awGazF-pRQsNB80w9uX8D4x88bY5WeR0CL-aEZIKWV86n2OHOI3sI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekfeejtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffejveen
 ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhsse
 hirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtoheprghlvgigrghnuggvrhesmhhihhgrlhhitgihnhdrtghomh
 dprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthht
 ohepkhifohhlfhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepqhgvmhhuqdgslhhotg
 hksehnohhnghhnuhdrohhrghdprhgtphhtthhopehfrghmsegvuhhphhhonhdrnhgvthdp
 rhgtphhtthhopehsthhgrhgrsggvrhesshhtghhrrggsvghrrdhorhhgpdhrtghpthhtoh
 epphhhihhlmhgusehlihhnrghrohdrohhrghdprhgtphhtthhopehpsghonhiiihhnihes
 rhgvughhrghtrdgtohhmpdhrtghpthhtohepshhtvghfrghnhhgrsehrvgguhhgrthdrtg
 homh
X-ME-Proxy: <xmx:66LxaSUsMzAQzAM-3X_FV7qqUCgQ6lVvE4apJ1bfjiQf-JL9RLaPpA>
 <xmx:66LxaajI05Dn3tcF9W_Ey4N9x6SFC9zZcusbC4Mm2nZMeJ3ouOHaew>
 <xmx:66Lxacj7NF4s35agdjbqNVz7vSjIHO8cbZYBPbWPuNBKvWIEo-CAgw>
 <xmx:66Lxafu8ymXC0-BHYhZjo_pEDkTrSdhB_SYt9zavlDwlRWKC-POcOA>
 <xmx:66LxaSLQuVBSWKbqH3me3YnSaAZlWQCQ5LwlK2VI6BIGUJUNPy8UAvxS>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 02:19:23 -0400 (EDT)
Date: Wed, 29 Apr 2026 08:19:22 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>,
 Keith Busch <kbusch@kernel.org>, Peter Xu <peterx@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v6 5/8] hw/nvme: unmap req->sg earlier in
 nvme_enqueue_req_completion
Message-ID: <afGi6jJymcv8Qic9@AALNPWKJENSEN.aal.scsc.local>
References: <20260419130139.15554-1-alexander@mihalicyn.com>
 <20260419130139.15554-6-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pz5XJJaRdA0OJcZR"
Content-Disposition: inline
In-Reply-To: <20260419130139.15554-6-alexander@mihalicyn.com>
Received-SPF: pass client-ip=202.12.124.158; envelope-from=its@irrelevant.dk;
 helo=fhigh-b7-smtp.messagingengine.com
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


--pz5XJJaRdA0OJcZR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 19 15:01, Alexander Mikhalitsyn wrote:
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>=20
> Instead of unmapping req->sg in nvme_post_cqes(), we can do it earlier in
> nvme_enqueue_req_completion(). When req completion is enqueued we don't
> need to access req->sg anymore. We only care about req->sq, req->cqe and
> req->status.
>=20
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.i=
o>

Nice cleanup,

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  hw/nvme/ctrl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index d9bf32bff2c..1ff91493b60 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -1534,7 +1534,6 @@ static void nvme_post_cqes(void *opaque)
>          QTAILQ_REMOVE(&cq->req_list, req, entry);
> =20
>          nvme_inc_cq_tail(cq);
> -        nvme_sg_unmap(&req->sg);
> =20
>          if (QTAILQ_EMPTY(&sq->req_list) && !nvme_sq_empty(sq)) {
>              qemu_bh_schedule(sq->bh);
> @@ -1564,6 +1563,8 @@ static void nvme_enqueue_req_completion(NvmeCQueue =
*cq, NvmeRequest *req)
>                                        req->status, req->cmd.opcode);
>      }
> =20
> +    nvme_sg_unmap(&req->sg);
> +
>      QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
>      QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
> =20
> --=20
> 2.47.3
>=20
>=20

--pz5XJJaRdA0OJcZR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmnxoukACgkQTeGvMW1P
Delncgf+KtfBJOzycVezlsX9wMxONrCZ9MR27Ag4kw0s9ZrPP14ML8sQQJBdy4UQ
eqdcnbomcwNKeIKIglKzbPo9uk5/9zGq7neVnsq/bVLVv9CpDmSbGHjFWkfUJT2N
sEjrrnf8TfiKXTbR92EsWLE38RPxdX5cCAYHXLFl9mZUiyY2mXzkDhYjN6Is5DTF
ngMvejNyB7WhnY4uBVqO/8Hoo7smsbHInelu/To2QzrTrUCFr9scBIdqZzxXFdMb
/edgoSVRq2dTkSZcKBcjxAAAQTDwndpsClN8tznksso2EOBrQJT9uFfcWZhSYTh0
5+WWChk86oh+TgnlaWWaRtu1dQlCjA==
=qwKW
-----END PGP SIGNATURE-----

--pz5XJJaRdA0OJcZR--

