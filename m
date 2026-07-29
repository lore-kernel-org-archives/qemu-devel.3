Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE21C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp3db-00058B-W6; Wed, 29 Jul 2026 08:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wp3da-00057z-8j; Wed, 29 Jul 2026 08:43:54 -0400
Received: from fhigh-b3-smtp.messagingengine.com ([202.12.124.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wp3dX-0008DP-EC; Wed, 29 Jul 2026 08:43:54 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 14B137A0181;
 Wed, 29 Jul 2026 08:43:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 29 Jul 2026 08:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1785329027; x=
 1785415427; bh=RVd/Oov3NNAfGbNz3j0DVmGXw8O1fQFOyiWXIOHObXM=; b=I
 HlGq+uMp1Rew9WKcYZgGm1Ug71kSE3hij3obi5WFdMJeM76mNnp8kA7sHAej4FRb
 83YQDDHOdfkjCTK1o7tgaYLOfCm7vBZ3J4r2RUqTRBBxQuXL8v5t4c+F/34bVzIt
 J3IL35j45YCbu/fXJGPm838/IcGwhqSxMKaY5/Y/mCVYIIJrVcFxLBPC70Y+zyH9
 62dbHNz1Uiy9vlZ9Qd7i6+sy97biaQb++BBJMEL34IvVpG/ISTElgdxmipwhNo5X
 v0q0d3fpCwLkAMtdYDtnYaX41jvSbUEj2tf/aUsthDqp5tHzLU/hD8NTm5/AKlU7
 28Fk12BjbvvNrXzfm6K5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1785329027; x=1785415427; bh=RVd/Oov3NNAfGbNz3j0DVmGXw8O1fQFOyiW
 XIOHObXM=; b=hCOIq/8cl0bi7D0QFszNvMKiNlfWX7dBe6rH/qto2i7d4rNoJf1
 nV6kuOf/E6GBwuSH5U768vb/d3ZOrdqHJkANSLOfmBLMVkhkRNqT1nWvaky28jSf
 LGEjYgVXjkQYGmIt+cIFEyh/YUk+yvbyM0ki8GRIJGDUb/8wPl5zuW1h+rseJtas
 TfRt22KPxMtVqXgnFdnjKq5Owmmpuul8objDqOgQKpPKHlZa0saZKe0cwQsoeyIE
 S6uDFPCrj89yBTzsOvySu48UHCuPMzm6abADeiwzHiRUpC2qBqXSvfiX1fA5ajpF
 LL9z8lHUzyNHMF0DAk0iUO44DoMiGTzQzCw==
X-ME-Sender: <xms:gvVpasShQLMJCopuH5ox7Zy9PZNV75IT23ub-P2MSwWSVQx0LN4OIA>
 <xme:gvVpalrLb3OM68gE7cgTLinFTqqUwXuLQBdvZGk7UjO-5DEYiH3Vbo8mmWO2Eo7Y-
 CVaBhF64a59IsAVJc_ZvqNPz0CXBsVuPjvEfAQ6WM9V1nIIcr7DKyc>
X-ME-Received: <xmr:gvVpam2MD-pYhIrFHZnbpE7WYmMNoiNNqjMFhN5gwu2TRe8udEHLXBjO6EtT6vhQ1tXQGUDbD5FB1NY5EoJBtg>
X-ME-Proxy-Cause: dmFkZTE2vdLNc03oIdxIEdaP+rxRTv6Gli1j6WZGlNgMhMPBg+/YNiGvQLtlNwy20w2xNT
 DZgmxihs9sFgzUvh4bxgGOfTUwSwkNGFGfNxZLFuTfW9DkP3Y4e+LVkI67uSPhbLXLvciA
 1He1YxtcBMOH59z3/GfIfrX39iyOcWNVNlXB0kcGm8X8rbGScorlQMRq0vOAV4PdhWPohS
 TfNfCtbleuno0kHeAZvVlO0h2GvEENAuAwxIyOrt9LeK2mpFQNsF7pNMFzAm/mSxc2Ib4R
 hW2AWDGC631SQYBFc+ZljZxmNpm4UdejXKsm9d7LCfr5hHjGSZOPTZGkkZTlHmdEL0mEYN
 kAKgQahpW8rRQmN6BMhSjED5xsL4Nwoe+u6oNwK21Z36WkFPDd263BgAT/D+agyB+v0uO9
 vTu5AXO57fAKlGyfJmelqEzZVSzgidef6pWe2A05sooQaUxxA9OL2RH4oS36LbnnTQmBD9
 SZrUTHsBjTczxrRZwPo7GuvzW4MpDfEGwQvMslGXNZEqB7VQozupQvCU8WtTp5Yp743aY0
 3L2IjAY5N/LwQ7BcCHypMO7L9nq7qjUJmvud7+RoH9wMyplBwYt1FLaL+PY7umXtEPL0GO
 7dY6QXGZ3rp1nPm0UsbOdXPGk/s72Ut6dBKx7nCOIkzJcyAk/mg0V95J1H0A
X-ME-Proxy: <xmx:gvVpak4jdlijHeH-ZU9pC1Rd1CPM10fzd-2EX0vPHpX3pvatGD033w>
 <xmx:gvVpaqRVPsaFcrITWc3guA6g7u0j9jbVFA8eVWyY_1vqkMbsqJtc3A>
 <xmx:gvVpahUMWsfMVBZRvOjNhAf7AbEPm8zisWTMAg_nRiTCK5yrNc5new>
 <xmx:gvVpanGZGGhpE1EfMPa2PFJ-PAV_OEiAjfe3fvfdI-PlH8vwYrzztw>
 <xmx:g_VpajdX02ZcavZrbM50G8TsYv7O34HXrCdno2VEOvhh9I1wTbXXWGVL>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 08:43:45 -0400 (EDT)
Date: Wed, 29 Jul 2026 14:43:42 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 3/6] hw/nvme: Fix block accounting in nvme_copy()
Message-ID: <amn1depJNcBu4zHT@AALNPWKJENSEN.aal.scsc.local>
References: <20260724152315.234183-1-hreitz@redhat.com>
 <20260724152315.234183-4-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zk6kBMN1U7vBVwHw"
Content-Disposition: inline
In-Reply-To: <20260724152315.234183-4-hreitz@redhat.com>
Received-SPF: pass client-ip=202.12.124.154; envelope-from=its@irrelevant.dk;
 helo=fhigh-b3-smtp.messagingengine.com
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

--Zk6kBMN1U7vBVwHw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 24 17:23, Hanna Czenczek wrote:
> In nvme_copy(), we start accounting for each of the copied ranges, but
> only end it once (in nvme_copy_done()). We should end it after each
> read/write operation is done instead, so they are properly accounted
> for.
>=20
> We should also actually pass the number of bytes we are reading/writing
> (instead of 0), and probably account for the metadata operations also,
> as they are block operations we execute.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>

Thanks for this,

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  hw/nvme/ctrl.c | 53 +++++++++++++++++++++++++++++++-------------------
>  1 file changed, 33 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index a67e1598891..32e78881234 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -2801,8 +2801,6 @@ static const AIOCBInfo nvme_copy_aiocb_info =3D {
>  static void nvme_copy_done(NvmeCopyAIOCB *iocb)
>  {
>      NvmeRequest *req =3D iocb->req;
> -    NvmeNamespace *ns =3D req->ns;
> -    BlockAcctStats *stats =3D blk_get_stats(ns->blkconf.blk);
> =20
>      if (iocb->idx !=3D iocb->nr) {
>          req->cqe.result =3D cpu_to_le32(iocb->idx);
> @@ -2811,14 +2809,6 @@ static void nvme_copy_done(NvmeCopyAIOCB *iocb)
>      qemu_iovec_destroy(&iocb->iov);
>      g_free(iocb->bounce);
> =20
> -    if (iocb->ret < 0) {
> -        block_acct_failed(stats, &iocb->acct.read);
> -        block_acct_failed(stats, &iocb->acct.write);
> -    } else {
> -        block_acct_done(stats, &iocb->acct.read);
> -        block_acct_done(stats, &iocb->acct.write);
> -    }
> -
>      iocb->common.cb(iocb->common.opaque, iocb->ret);
>      qemu_aio_unref(iocb);
>  }
> @@ -2949,6 +2939,7 @@ static void nvme_copy_out_completed_cb(void *opaque=
, int ret)
>      NvmeCopyAIOCB *iocb =3D opaque;
>      NvmeRequest *req =3D iocb->req;
>      NvmeNamespace *dns =3D req->ns;
> +    BlockAcctStats *stats =3D blk_get_stats(dns->blkconf.blk);
>      uint32_t nlb;
> =20
>      nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format, =
NULL,
> @@ -2957,10 +2948,12 @@ static void nvme_copy_out_completed_cb(void *opaq=
ue, int ret)
>      if (ret < 0) {
>          iocb->ret =3D ret;
>          req->status =3D NVME_WRITE_FAULT;
> -        goto out;
> -    } else if (iocb->ret < 0) {
> +    }
> +    if (iocb->ret < 0) {
> +        block_acct_failed(stats, &iocb->acct.write);
>          goto out;
>      }
> +    block_acct_done(stats, &iocb->acct.write);
> =20
>      if (dns->params.zoned) {
>          nvme_advance_zone_wp(dns, iocb->zone, nlb);
> @@ -2977,11 +2970,18 @@ static void nvme_copy_out_cb(void *opaque, int re=
t)
>      NvmeCopyAIOCB *iocb =3D opaque;
>      NvmeRequest *req =3D iocb->req;
>      NvmeNamespace *dns =3D req->ns;
> +    BlockAcctStats *stats =3D blk_get_stats(dns->blkconf.blk);
>      uint32_t nlb;
>      size_t mlen;
>      uint8_t *mbounce;
> =20
> -    if (ret < 0 || iocb->ret < 0 || !dns->lbaf.ms) {
> +    if (ret < 0 || iocb->ret < 0) {
> +        block_acct_failed(stats, &iocb->acct.write);
> +        goto out;
> +    }
> +    block_acct_done(stats, &iocb->acct.write);
> +
> +    if (!dns->lbaf.ms) {
>          goto out;
>      }
> =20
> @@ -2994,6 +2994,7 @@ static void nvme_copy_out_cb(void *opaque, int ret)
>      qemu_iovec_reset(&iocb->iov);
>      qemu_iovec_add(&iocb->iov, mbounce, mlen);
> =20
> +    block_acct_start(stats, &iocb->acct.write, mlen, BLOCK_ACCT_WRITE);
>      iocb->aiocb =3D blk_aio_pwritev(dns->blkconf.blk, nvme_moff(dns, ioc=
b->slba),
>                                    &iocb->iov, 0, nvme_copy_out_completed=
_cb,
>                                    iocb);
> @@ -3010,6 +3011,7 @@ static void nvme_copy_in_completed_cb(void *opaque,=
 int ret)
>      NvmeRequest *req =3D iocb->req;
>      NvmeNamespace *sns =3D iocb->sns;
>      NvmeNamespace *dns =3D req->ns;
> +    BlockAcctStats *sstats =3D blk_get_stats(sns->blkconf.blk);
>      NvmeCopyCmd *copy =3D NULL;
>      uint8_t *mbounce =3D NULL;
>      uint32_t nlb;
> @@ -3022,10 +3024,12 @@ static void nvme_copy_in_completed_cb(void *opaqu=
e, int ret)
>      if (ret < 0) {
>          iocb->ret =3D ret;
>          req->status =3D NVME_UNRECOVERED_READ;
> -        goto out;
> -    } else if (iocb->ret < 0) {
> +    }
> +    if (iocb->ret < 0) {
> +        block_acct_failed(sstats, &iocb->acct.read);
>          goto out;
>      }
> +    block_acct_done(sstats, &iocb->acct.read);
> =20
>      nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format, =
&slba,
>                                   &nlb, NULL, &apptag, &appmask, &reftag);
> @@ -3100,7 +3104,7 @@ static void nvme_copy_in_completed_cb(void *opaque,=
 int ret)
>      qemu_iovec_reset(&iocb->iov);
>      qemu_iovec_add(&iocb->iov, iocb->bounce, len);
> =20
> -    block_acct_start(blk_get_stats(dns->blkconf.blk), &iocb->acct.write,=
 0,
> +    block_acct_start(blk_get_stats(dns->blkconf.blk), &iocb->acct.write,=
 len,
>                       BLOCK_ACCT_WRITE);
> =20
>      iocb->aiocb =3D blk_aio_pwritev(dns->blkconf.blk, nvme_l2b(dns, iocb=
->slba),
> @@ -3119,20 +3123,29 @@ static void nvme_copy_in_cb(void *opaque, int ret)
>  {
>      NvmeCopyAIOCB *iocb =3D opaque;
>      NvmeNamespace *sns =3D iocb->sns;
> +    BlockAcctStats *stats =3D blk_get_stats(sns->blkconf.blk);
>      uint64_t slba;
>      uint32_t nlb;
> +    size_t mlen;
> +
> +    if (ret < 0 || iocb->ret < 0) {
> +        block_acct_failed(stats, &iocb->acct.read);
> +        goto out;
> +    }
> +    block_acct_done(stats, &iocb->acct.read);
> =20
> -    if (ret < 0 || iocb->ret < 0 || !sns->lbaf.ms) {
> +    if (!sns->lbaf.ms) {
>          goto out;
>      }
> =20
>      nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format, =
&slba,
>                                   &nlb, NULL, NULL, NULL, NULL);
> =20
> +    mlen =3D nvme_m2b(sns, nlb);
>      qemu_iovec_reset(&iocb->iov);
> -    qemu_iovec_add(&iocb->iov, iocb->bounce + nvme_l2b(sns, nlb),
> -                   nvme_m2b(sns, nlb));
> +    qemu_iovec_add(&iocb->iov, iocb->bounce + nvme_l2b(sns, nlb), mlen);
> =20
> +    block_acct_start(stats, &iocb->acct.read, mlen, BLOCK_ACCT_READ);
>      iocb->aiocb =3D blk_aio_preadv(sns->blkconf.blk, nvme_moff(sns, slba=
),
>                                   &iocb->iov, 0, nvme_copy_in_completed_c=
b,
>                                   iocb);
> @@ -3337,7 +3350,7 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
>      qemu_iovec_reset(&iocb->iov);
>      qemu_iovec_add(&iocb->iov, iocb->bounce, len);
> =20
> -    block_acct_start(blk_get_stats(sns->blkconf.blk), &iocb->acct.read, =
0,
> +    block_acct_start(blk_get_stats(sns->blkconf.blk), &iocb->acct.read, =
len,
>                       BLOCK_ACCT_READ);
> =20
>      iocb->aiocb =3D blk_aio_preadv(sns->blkconf.blk, nvme_l2b(sns, slba),
> --=20
> 2.55.0
>=20
>=20

--Zk6kBMN1U7vBVwHw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmpp9XYACgkQTeGvMW1P
DenurQf+PlOSgZU+RxY4yqEBkWpJJ4Mg8MomITg/ZVskMuMxFAONxNvwctF5xh7G
D5BYI4YXJ104iyWszylUTCMrz3LkI8NDMyxNZ+qYkcDcMuv4cMheBUXwhuR8pAuX
LefoUYRym9ZBEWa6QoFtKbLYzlgpJBf2Y1Yi+CQfiVb8ptsSJNj+0zM15RMyVn1F
ThqLsdcslPBwwgM0VsF2NTX5WxHSFIyTZeCzeYelTBh3SXFcz+kfkABZqqD//t72
JqcbqVRxD9MkbAssMvJjJxOSjbEa8z7cmqqXh5Pgpl7oxgECBdzfyYZlPtlQdmt5
1IwUUq0i1WGtK59Dmfe854ueMYy4uw==
=7Mml
-----END PGP SIGNATURE-----

--Zk6kBMN1U7vBVwHw--

