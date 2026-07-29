Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1620C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp3e0-0005Iz-U7; Wed, 29 Jul 2026 08:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wp3dz-0005Hx-VV; Wed, 29 Jul 2026 08:44:20 -0400
Received: from fout-b1-smtp.messagingengine.com ([202.12.124.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wp3dy-0008Fo-7m; Wed, 29 Jul 2026 08:44:19 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 36D781D000F6;
 Wed, 29 Jul 2026 08:44:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 29 Jul 2026 08:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1785329056; x=
 1785415456; bh=eZfqUEbUUP/ZeW5roK/SIpDX6ceW3Xh2Oq13DuUnbtU=; b=B
 Z3H53gjtPK1hasDqXV+5jM1+c/dHoUI9vdXwVidQ2kGq3kje/KWgrOe9vQkNPX8F
 tUG+gAx996GWS2+vlDgqlc6ZLE/mpGQ3Rae4t/XpIVyPAk/dvnKNvH8gNl6Nbzfu
 XFEwRYYqDbyQGlr+QagZpfbSq+tRWg4SkgLh9yfpQeaOPGk8I2PNuCaxBmIc8wU4
 20nuf9x5ZjTPO2+SK1CjFaQ1WT2amor9tagm+T6oWdd0JXbxcQnv1ic89pZao0Ss
 XhFLGmm6ZTj3nO+auBv7MreD53rhQtu2hfSb/E1U0mYG6qTP/8miDTe03IlqXfLx
 qb50vlTu58tTQc6KNn1RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1785329056; x=1785415456; bh=eZfqUEbUUP/ZeW5roK/SIpDX6ceW3Xh2Oq1
 3DuUnbtU=; b=f+Wp3Sn158rbWIKY/1uWDRwYXAaiCXzr6iYgvbaTZgNtIlI8UjB
 qCCFwfYYoXgO8vQj1/vaf1WmbFXExKdgl14dj5sg4QweDD2CsN1LRG48WD0uBemp
 QIFXcVBklhwD/ANLQeuJJFOI++S9JBJQWqZUD4eqfVNC2ayeAYAmOAL8GuWK79su
 /aD6g9R/EkwOii/lXezbNnIHomrtRi4ExiW5jyItTkgfMah77tlnD8b6Ons9jyCS
 H/M65y4j29ZHJTIbEo87IIMAih+BWRteDbjFiIKFgYoDIDleLV1L6pggK/QXZ+Ou
 2ag5RlFLJaegVXFHreUSOZ4ObGy9/E+AhFQ==
X-ME-Sender: <xms:n_VpahDEByvBVgmajYR8RsGDUYdwKoiMkWayNoQBHYL2QEFwpxImRQ>
 <xme:n_VparatGeITWKaej8kIASl0DHf5gPiazrCgwgLsAP1Bl_R42rtt7BwpnIAcKC2mH
 ZWPGrjP_7SrcTqKnjYAuwIoPx16VzPc1bLctNRamvTd8scZyQhYo8E>
X-ME-Received: <xmr:n_VpapmVkx7CDzZosFzPi-flu48MxNq915I9UwfMaZ6gF3VE1iaU_0ZeHHV9EbYU63Mdpfc8954MLoSmdkvVNg>
X-ME-Proxy-Cause: dmFkZTFtJe0p4vMJmi1Az8EZ/ekao4wfgdDn6QQh48U1be+v4XCQHriWffjn9hXjVqLUCv
 6Axj3ciwxTjeZ5DLIVBhN5+iJxCTGLnRVp4b/FBhg0ZTvSLv/4NKVl8CZ7F3CDd73sdn85
 mgCwvSjGrFBXRIbLZ92OFn4TiU1NhJiV2WJ66mivmG8DvXbAmAJrhmCwJbop5FBH69gV9R
 8xYNQ09cSFOfh8i1zmJsmiATUYCTwAYODqjWbGUsuviDciFyjZcWBhurRIafyrN77/UOtU
 4pjfwdNTV5Zo+5uzv7cjKhVD3Iv1MKePyvWooi1u2JKj+UPXFsRnZfnGfu+BO3dvZ0Z+g2
 jqdsYvf3fYDAvQ9Mb5Q+Eis2VZtBvkeaLscWUMypH1/o54/pHHR1IkQDA0cFQnS1BDUkd3
 7HPQXnrKIsSIQqHnHP1f5e80PxA50NlnxA1OOFGYBzuSPZH+QPX0pqYEAtnlnvEDbLCZb4
 JO2tpGAJdgRKHCouSmB1deo21LwFjYj/yyGHK984l/heuQj9ic2V+CPIJtFl4BBQS1eAtw
 D5Do3oe6wUMKO6N3Ps6xK2eKWG8B06DVSk/SL7H0GzSggk+D788R/i2dFLolIFMGK6Adbs
 Y8cgxq6rOVdlEvGP9c3vegoQhRNPlaJpKq6kr4gL5W7jKsFhBx7fAkVr1ptQ
X-ME-Proxy: <xmx:n_VpagqTe_H2Jtzzqj1WoEa_7fGhXXE1esrPstsl1bAdg_tKHGz30A>
 <xmx:n_VparDQQdmXXQas4IKRTOeaC9RnzI7J29RdklG2xVC_-NYWB7bqSg>
 <xmx:n_VpajE4ctfLLAkaN4-VqOBj1EXez8_ANSkxL7U5Iu0p_cTEbtIoEA>
 <xmx:n_Vpal2J1OsHnlNIUey3FBJdHIRvucJCy-BzwVMCvUZR7VzbKEtY4g>
 <xmx:oPVpaork-x0Qdn9GLq_E7VmwiI_BrZrYhyAnzpmW96UzGaZi90BWAD9B>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 08:44:15 -0400 (EDT)
Date: Wed, 29 Jul 2026 14:44:13 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 4/6] hw/nvme: Fix block accounting for compare
Message-ID: <amn1nQAR37yHAhpl@AALNPWKJENSEN.aal.scsc.local>
References: <20260724152315.234183-1-hreitz@redhat.com>
 <20260724152315.234183-5-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q8bg8nPWK4f6gbgQ"
Content-Disposition: inline
In-Reply-To: <20260724152315.234183-5-hreitz@redhat.com>
Received-SPF: pass client-ip=202.12.124.144; envelope-from=its@irrelevant.dk;
 helo=fout-b1-smtp.messagingengine.com
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

--Q8bg8nPWK4f6gbgQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 24 17:23, Hanna Czenczek wrote:
> nvme_compare() starts block accounting for the operation, but
> nvme_compare_data_cb() (and nvme_compare_mdata_cb()) do not always
> finalize the cookie.  Specifically, there are a lot of error paths that
> do not call block_acct_failed().
>=20
> Fix this by putting block_acct_done()/block_acct_failed() under the
> `out` labels of nvme_compare_data_cb() and nvme_compare_mdata_cb().
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  hw/nvme/ctrl.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 32e78881234..335498a2d73 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -2388,7 +2388,6 @@ static void nvme_compare_mdata_cb(void *opaque, int=
 ret)
>      trace_pci_nvme_compare_mdata_cb(nvme_cid(req));
> =20
>      if (ret) {
> -        block_acct_failed(stats, acct);
>          req->status =3D NVME_UNRECOVERED_READ;
> =20
>          trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), req->statu=
s);
> @@ -2443,9 +2442,14 @@ static void nvme_compare_mdata_cb(void *opaque, in=
t ret)
>          goto out;
>      }
> =20
> -    block_acct_done(stats, acct);
> =20
>  out:
> +    if (req->status =3D=3D NVME_SUCCESS) {
> +        block_acct_done(stats, acct);
> +    } else {
> +        block_acct_failed(stats, acct);
> +    }
> +
>      qemu_iovec_destroy(&ctx->data.iov);
>      g_free(ctx->data.bounce);
> =20
> @@ -2473,7 +2477,6 @@ static void nvme_compare_data_cb(void *opaque, int =
ret)
>      trace_pci_nvme_compare_data_cb(nvme_cid(req));
> =20
>      if (ret) {
> -        block_acct_failed(stats, acct);
>          req->status =3D NVME_UNRECOVERED_READ;
> =20
>          trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), req->statu=
s);
> @@ -2512,9 +2515,13 @@ static void nvme_compare_data_cb(void *opaque, int=
 ret)
>          return;
>      }
> =20
> -    block_acct_done(stats, acct);
> -
>  out:
> +    if (req->status =3D=3D NVME_SUCCESS) {
> +        block_acct_done(stats, acct);
> +    } else {
> +        block_acct_failed(stats, acct);
> +    }
> +
>      qemu_iovec_destroy(&ctx->data.iov);
>      g_free(ctx->data.bounce);
>      g_free(ctx);
> --=20
> 2.55.0
>=20
>=20

--Q8bg8nPWK4f6gbgQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmpp9Z0ACgkQTeGvMW1P
Denp9gf/TjLwbOeg5hxrGk+Vip8Anqf+D5DlN6YyepLV647mLGhasjQrbLe9/EwJ
2QKz2flyne05IrX0V1FE5GNiePvQkmx6edvczbbJbv8C6zrw6dGH693BwRP5UUeR
WSL7gNGXr79DCnZHTJXymBZonuhXmNdXvQj4yWVgCFR1qM/SirB6/uMF6xYHqk+c
GTpiBXeuburrGMD6+7Lzql/ohmoNYNCaj/yomSN5qPrl0yr4K13AJbqsCn8eYjR+
k/+9i9jF63wm8i+IKCu92//QeVjY/3gJFevGBZ4EiqnEbeDr8jR7OZf+KhAJuWpZ
V7nEk2m09j+nPoNOZjU4Z4cIrCoeBQ==
=CkzU
-----END PGP SIGNATURE-----

--Q8bg8nPWK4f6gbgQ--

