Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15257FF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 06:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHyG6-00030g-Cm; Wed, 29 Apr 2026 02:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wHyFk-0002x5-9M; Wed, 29 Apr 2026 02:18:34 -0400
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wHyFi-0006Hg-8A; Wed, 29 Apr 2026 02:18:32 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 804727A00A5;
 Wed, 29 Apr 2026 02:18:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 29 Apr 2026 02:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1777443505; x=
 1777529905; bh=TV9kc4iShjRSzB/yejf1EMqz2Nq4q335ld0T0GfipmM=; b=A
 LZ8XSzfe1d5iz1JNe2voH+gGAh7A4WSg+c8cFzZM7GQm1uqGHIXfXJV5yFYX4Tl0
 Zgsfg/W61mQufIrb2yGFCU5EcnDCgSBUhUdMO+Kxy9vX5stzf3SHgfsbqAS4esB2
 RYnBBxKXLmGf6qXVKJ1Oivx2WKui7pE+Cr2r3Ud0Zy/DRn59Yt6SiI4eZWcVTfoe
 j/GJpRPeaR1kK2k46e1fEVZ+kkaCldvmn9Q3SsqD/zV9EIpIUrAN9/lvwFUC3jzX
 KOiCm7LgsqumeiY/rTZfAs+UmzPkVuRWuiNVbj9sv3W/xQfHYOR6D94M9CXgXG8v
 3DHjjuWK5U2F+4g8VggLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1777443505; x=1777529905; bh=TV9kc4iShjRSzB/yejf1EMqz2Nq4q335ld0
 T0GfipmM=; b=RcjbLbNqmN4pOu+5Xf9qE3w36iBNfSzRRwQ2A1yDCg8N2HyfpYX
 bYHaXiW31EJ1hTwneJVwGk5T2o3O9kzsPy/3bmiwCaJWG4qElvBGeNi9Mrc60sjo
 2BDmidVxtRDBEtIa9q4KdgDkwbIHV3+KPZgbPSzyDhJIk32l92W3N9FgB2XELtYU
 ezkMHea7sVcb4/Bt2Z5baxrrW9Fjzje6KAsG2fQCqKiCbDLywnbAcEvbMiUTz2qS
 j/5z9pFxdSmPFMEig9n4wkdmHV1BEtIhZxPhWC6Su3hVq0qg5Q+6O8Ao0k2jmqsz
 1sPiXB84O8KUduEXAusgNXxUktoxipJx9+w==
X-ME-Sender: <xms:r6LxaXEIymF2j3lD9ldc2tKLAg6m9WxloWRDR8Cf6AcWm1nFv-m9NA>
 <xme:r6LxaVSc_yiJkBNVn898qCvr_bdKZd8rwC838GTfJIL6miAy4sPdlskoU8RJWmUV0
 D41LyMYEYkY2pHNiqoI0HksXjz5Wy5Oo2wFS6wK_MxYTa4fqWldOO8>
X-ME-Received: <xmr:r6LxaZcNZu8P08_LdunfU3avqWtefLM-Imul2O49zWsAiElfKurUsvWM0sDU8NGHTnrMp0ICpHc3371mabhfEKHbMB6mJhU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekfeejtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffejveen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhsse
 hirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtoheprghlvgigrghnuggvrhesmhhihhgrlhhitgihnhdrtghomh
 dprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthht
 ohepkhifohhlfhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepqhgvmhhuqdgslhhotg
 hksehnohhnghhnuhdrohhrghdprhgtphhtthhopehfrghmsegvuhhphhhonhdrnhgvthdp
 rhgtphhtthhopehsthhgrhgrsggvrhesshhtghhrrggsvghrrdhorhhgpdhrtghpthhtoh
 epphhhihhlmhgusehlihhnrghrohdrohhrghdprhgtphhtthhopehpsghonhiiihhnihes
 rhgvughhrghtrdgtohhmpdhrtghpthhtohepshhtvghfrghnhhgrsehrvgguhhgrthdrtg
 homh
X-ME-Proxy: <xmx:r6LxaTg9X8Uw8Wq3zmfwRFLDOkCQ6cgJmW1P2yAU5USX9CxgXx-rHQ>
 <xmx:r6LxaUIDI1TAv84X0Niiav5DyXvmUTWHWVvwWzD_lInGNlzVEQNzRQ>
 <xmx:r6LxaQFu8s2UqcT5pCNLNlugkwMsQ7DThBTyfJYWUGdhfqfVbY8pPw>
 <xmx:r6Lxaa1Y24jDv4F-Cmv89fjr8MIFO8xIn-sJGXp1iGxMDwagAHfULQ>
 <xmx:saLxaZP6CTI1xPJOFyuyq7gsTLERlp2IHua3oCdt-cnwfR2Bk2HKyiN9>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 02:18:23 -0400 (EDT)
Date: Wed, 29 Apr 2026 08:18:21 +0200
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
Subject: Re: [PATCH v6 4/8] hw/nvme: set CQE.sq_id earlier in nvme_process_sq
Message-ID: <afGirZIPZ0TT5ipC@AALNPWKJENSEN.aal.scsc.local>
References: <20260419130139.15554-1-alexander@mihalicyn.com>
 <20260419130139.15554-5-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RX0EiVYpKZIZ2q7j"
Content-Disposition: inline
In-Reply-To: <20260419130139.15554-5-alexander@mihalicyn.com>
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


--RX0EiVYpKZIZ2q7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 19 15:01, Alexander Mikhalitsyn wrote:
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>=20
> Instead of filling req->cqe.sq_id in nvme_post_cqes, let's set it earlier
> in nvme_process_sq.
>=20
> This shouldn't cause any issues, because req->cqe.sq_id never changes
> during lifetime of req.
>=20
> This will help us for migration support.
>=20
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.i=
o>

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  hw/nvme/ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 191398e700f..d9bf32bff2c 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -1520,7 +1520,6 @@ static void nvme_post_cqes(void *opaque)
> =20
>          sq =3D req->sq;
>          req->cqe.status =3D cpu_to_le16((req->status << 1) | cq->phase);
> -        req->cqe.sq_id =3D cpu_to_le16(sq->sqid);
>          req->cqe.sq_head =3D cpu_to_le16(sq->head);
>          addr =3D cq->dma_addr + (cq->tail << NVME_CQES);
>          ret =3D pci_dma_write(PCI_DEVICE(n), addr, (void *)&req->cqe,
> @@ -7848,6 +7847,7 @@ static void nvme_process_sq(void *opaque)
>          QTAILQ_REMOVE(&sq->req_list, req, entry);
>          QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
>          nvme_req_clear(req);
> +        req->cqe.sq_id =3D cpu_to_le16(sq->sqid);
>          req->cqe.cid =3D cmd.cid;
>          memcpy(&req->cmd, &cmd, sizeof(NvmeCmd));
> =20
> --=20
> 2.47.3
>=20
>=20

--RX0EiVYpKZIZ2q7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmnxoqoACgkQTeGvMW1P
Dek9oQf+IRc5ZxrN9j4mVldYKAwfkUWp5HN+YH7PPpIPj7dyYP2rxt0ZFLl6olfJ
adey1Du5VODXvjV/wT2255jRvn3oVxIn07AQPtKZt9KsCzE4Mm01J1VJKu8ljsMP
2nWB9g3kqijSPaWdyH7ehAiWFx4tuUEaQt6R1PKS1QuoazCQx312RsLHuBtTzxT9
VqISAKoOubCb2OPRllk7cOHiihXKVM9Xwatr5B4MMDaXqh+fxdIGk5A8TsKqc74d
YFwDVnzOBvN51eReS36OhuO64I/nTUFxfgrvC16jkFAL56WMKEWYQ6ALAoOBkVZJ
LFmYkObFZhuouv7dXh4SJu0nhXm7Cw==
=BDQ8
-----END PGP SIGNATURE-----

--RX0EiVYpKZIZ2q7j--

