Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22023FF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 06:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHyJ3-0004ob-72; Wed, 29 Apr 2026 02:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wHyI0-0004Ym-QF; Wed, 29 Apr 2026 02:20:53 -0400
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wHyHy-0007Ad-Ml; Wed, 29 Apr 2026 02:20:52 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id C41BC7A00D7;
 Wed, 29 Apr 2026 02:20:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 29 Apr 2026 02:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1777443644; x=
 1777530044; bh=0bwSaUsoV2tnXSfctUDa1jx4PG8j/+1OdtyMER4F9Ik=; b=I
 HqxcEDIs5k4RBnErWYN+uRVJRKcEvygLjuuWqJXfRytisGUHZgkYcZRXcwepZSGd
 YQeOro8NyUnIk75Hmrs2tQwhwNl4Kfcr5X9SHmhniDWKzwDQtUeCHrq6v4f4MOPc
 C6AyOfgDJdu0CGfXgp3bvxcZdI+XMIvSksh20JivlPB1eugk45zHn0vFxSpf+4IM
 vNL2Zb3d86Z+ixamj8Sq8yWG/lKHVjqc8az7TyMV03Ev5fRomBppdnAvuOmWgaxz
 UKqwTetUxIpwqTcjxVIdpzES4bxDumvG93zy7RZdT71M8dHwxXZf1AjnFEzu6h4X
 JBGWMA45U4IIIVvS1G7eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1777443644; x=1777530044; bh=0bwSaUsoV2tnXSfctUDa1jx4PG8j/+1Odty
 MER4F9Ik=; b=qYKwxY22meV/EwxtCAczqmOL8jF/nk1QA7xO9gfWQ3UEw1BSEOi
 /+It6Jebf9jLJAZ0H1L/pvMdDb+L4zvNyXHpVyxbH0lF0DJWYzYtyn8a9vXwOyLh
 jBSk0uPResLRiY05sdyS7D2+Kdo9l2BuJLe8CGuqWtEOEXvBZPHgCFpmk7INRKu1
 C+Kxv2U5eISuvcrd06+g908gw+jLZCf4VuZptNBnBzS+HeXlxOtHBpt140caVDvP
 WpuEFImVy8XsxYH/nsx5HeFNCtj7otowFeMl6nbJoFgvR5QKT06sfYS6WwGe40GO
 43LSjYEWbJtmUdlHBi7dqqjDhX2qT3lv3Sw==
X-ME-Sender: <xms:PKPxaQdH7mcpDu0tscSPxihBOSuXNbzIi5F6gg67Cr_I3Ylal1m7UA>
 <xme:PKPxac6NZb-4aoxrRViuUVxlmT6Ft2y_m4HxoOHA3kbrVzG9eYHbi_tkhWwwWcRWA
 aql28DgEwzIhxODbPNIXQcrqx2oEHKIQFRbn1-atRnsy23Zq8nS6EG9>
X-ME-Received: <xmr:PKPxaaM-DsdEp0bfTNKh4bKuJ8E0hnAd1bQZIpiiPqy17rSKaW0HpmrUnVmrjH8a3NjLSR0l0fVPaAkaT-EjqCsuEU57n-U>
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
X-ME-Proxy: <xmx:PKPxadG_kF-u_BJ-GAfCOXaB5DcNHK9Dl4PcfVLfvUnGQ4TzGX1j4Q>
 <xmx:PKPxaeQw6Bgh0ojJhdapEVxYP4i4nZ8FLxP8Ro74dfnfw7QezavHlQ>
 <xmx:PKPxaVRF28NtgDpUSVbNsjCrpPyXbX810FHG5wHodmwerFU2Zn-hcQ>
 <xmx:PKPxaZfVu0gDbS4JiXW5HjOeyPMz58zCDtF_4I9vSu3L3a4wohPs5Q>
 <xmx:PKPxaV4MnFn-aR4eIPEYSc2k0KNIqJeshA3k6UUv5Vq_16RKEpgJa6cZ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 02:20:43 -0400 (EDT)
Date: Wed, 29 Apr 2026 08:20:42 +0200
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
Subject: Re: [PATCH v6 3/8] hw/nvme: split nvme_init_sq/nvme_init_cq into
 helpers
Message-ID: <afGjOqwqeug2JIWf@AALNPWKJENSEN.aal.scsc.local>
References: <20260419130139.15554-1-alexander@mihalicyn.com>
 <20260419130139.15554-4-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Yhx4C6eW4jqtuNzK"
Content-Disposition: inline
In-Reply-To: <20260419130139.15554-4-alexander@mihalicyn.com>
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


--Yhx4C6eW4jqtuNzK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 19 15:01, Alexander Mikhalitsyn wrote:
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>=20
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.i=
o>

LGTM, but a short description on why this is needed in preparation for
later patches would be nice :)

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  hw/nvme/ctrl.c | 59 +++++++++++++++++++++++++++++++-------------------
>  1 file changed, 37 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 9f9c9bcbead..191398e700f 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -4854,18 +4854,14 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequ=
est *req)
>      return NVME_SUCCESS;
>  }
> =20
> -static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
> -                         uint16_t sqid, uint16_t cqid, uint16_t size)
> +static void __nvme_init_sq(NvmeSQueue *sq)
>  {
> +    NvmeCtrl *n =3D sq->ctrl;
> +    uint16_t sqid =3D sq->sqid;
> +    uint16_t cqid =3D sq->cqid;
>      int i;
>      NvmeCQueue *cq;
> =20
> -    sq->ctrl =3D n;
> -    sq->dma_addr =3D dma_addr;
> -    sq->sqid =3D sqid;
> -    sq->size =3D size;
> -    sq->cqid =3D cqid;
> -    sq->head =3D sq->tail =3D 0;
>      sq->io_req =3D g_new0(NvmeRequest, sq->size);
> =20
>      QTAILQ_INIT(&sq->req_list);
> @@ -4895,6 +4891,18 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl =
*n, uint64_t dma_addr,
>      n->sq[sqid] =3D sq;
>  }
> =20
> +static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
> +                         uint16_t sqid, uint16_t cqid, uint16_t size)
> +{
> +    sq->ctrl =3D n;
> +    sq->dma_addr =3D dma_addr;
> +    sq->sqid =3D sqid;
> +    sq->size =3D size;
> +    sq->cqid =3D cqid;
> +    sq->head =3D sq->tail =3D 0;
> +    __nvme_init_sq(sq);
> +}
> +
>  static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeRequest *req)
>  {
>      NvmeSQueue *sq;
> @@ -5555,25 +5563,16 @@ static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeRequ=
est *req)
>      return NVME_SUCCESS;
>  }
> =20
> -static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
> -                         uint16_t cqid, uint16_t vector, uint16_t size,
> -                         uint16_t irq_enabled)
> +static void __nvme_init_cq(NvmeCQueue *cq)
>  {
> +    NvmeCtrl *n =3D cq->ctrl;
>      PCIDevice *pci =3D PCI_DEVICE(n);
> +    uint16_t cqid =3D cq->cqid;
> =20
> -    if (msix_enabled(pci) && irq_enabled) {
> -        msix_vector_use(pci, vector);
> +    if (msix_enabled(pci) && cq->irq_enabled) {
> +        msix_vector_use(pci, cq->vector);
>      }
> =20
> -    cq->ctrl =3D n;
> -    cq->cqid =3D cqid;
> -    cq->size =3D size;
> -    cq->dma_addr =3D dma_addr;
> -    cq->phase =3D 1;
> -    cq->irq_enabled =3D irq_enabled;
> -    cq->vector =3D vector;
> -    cq->head =3D cq->tail =3D 0;
> -    QTAILQ_INIT(&cq->req_list);
>      QTAILQ_INIT(&cq->sq_list);
>      if (n->dbbuf_enabled) {
>          cq->db_addr =3D n->dbbuf_dbs + (cqid << 3) + (1 << 2);
> @@ -5590,6 +5589,22 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl =
*n, uint64_t dma_addr,
>                                   &DEVICE(cq->ctrl)->mem_reentrancy_guard=
);
>  }
> =20
> +static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
> +                         uint16_t cqid, uint16_t vector, uint16_t size,
> +                         uint16_t irq_enabled)
> +{
> +    cq->ctrl =3D n;
> +    cq->cqid =3D cqid;
> +    cq->size =3D size;
> +    cq->dma_addr =3D dma_addr;
> +    cq->phase =3D 1;
> +    cq->irq_enabled =3D irq_enabled;
> +    cq->vector =3D vector;
> +    cq->head =3D cq->tail =3D 0;
> +    QTAILQ_INIT(&cq->req_list);
> +    __nvme_init_cq(cq);
> +}
> +
>  static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
>  {
>      NvmeCQueue *cq;
> --=20
> 2.47.3
>=20
>=20

--Yhx4C6eW4jqtuNzK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmnxozoACgkQTeGvMW1P
DemMzQf/X3MsIMzaiXQhJyuv9ojUz5QuXrzbdLuQGkNWAf3OcGF/ESiwy/MAwyYy
n5OIwDIEfxYtvLiAvv6R0cODipjw5/q3Xhinbq8FIuL6RsznpZ6R9ED2oRpkCGuJ
G3TZt8FCaTaBU4ES+jM8RpB3boGAtxEjOsdZfkG2I14T0on+kp7cHuokCFObv5Kd
weXSFNc5gZzAmR4qyfojc0eHFZjnjN7hfIXK7wZDZ6JWQiYZYtn+I/gtkk9bFHPH
bL0Htxhw2cRPoarHD0csEOuguCgVEedv1Xc/dSgJBW99NeWX99bNgYI14RUhYDqd
zlUsYKDPGvRa/fO9rQEmNhOLfN/pWA==
=zEST
-----END PGP SIGNATURE-----

--Yhx4C6eW4jqtuNzK--

