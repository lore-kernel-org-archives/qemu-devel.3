Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F05606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm1 header.b=X2XexuL+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ESNLzwK0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLJ7C-0002lC-Ag; Mon, 26 Oct 2026 07:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xLJ78-0002ko-Dt
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:43:42 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xLJ76-0002Dp-4X
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:43:42 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id DAB0F140096B
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 07:43:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 26 Oct 2026 07:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1793015015; x=
 1793101415; bh=XeuMRTQ79fPY6szr+VeKVDws593mbUU6INhDYfVFzWM=; b=X
 2XexuL+IqMnTZtWS8EEnn8cMv8+cFKyEsnJonx9aJICeweY60FZ9rj+gVFsEqf1W
 EqZ9cHaQP+u7aila9TEZj8NkBkQmXjzEQGevyiyrXQto4YM/nvyeyX+zVZrxIwtK
 hOY+wTVOEgLw53mx4aCU+m9qL4NVlJyzyycVEU47FOPJtO4DTkgCgFdIzIDEz/P7
 CpzbiT5//ugY9gORGSteG5fyOcBH0m2xzgjvCsvrT9bvw6x8yKI+ep10py9MYtnz
 gUaP+CU/w/vkaaUyxrv2nwSk8c10wDNwp5H6F/v6LXgotpVUYWdxVNSNcH8bwrLT
 kJAAYlri5SJR5g48zbJwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1793015015; x=1793101415; bh=XeuMRTQ79fPY6szr+VeKVDws593mbUU6INh
 DYfVFzWM=; b=ESNLzwK0hI6Brf8uaX+1ErsnIXS7e47vnIJcPv225uG0+9B/7/9
 d5lh1bgqCxdlRN8C5k2VBPaXwzXw8CJlBXWaOz558Eck2lXxlMbOQCYkilcOiG0o
 NXTDCVV3JIKNMksRI7RAdeL3c+neNebSjQDUNa29xZX1eKTkCFTE18HEqSgx1fD6
 l6wLG1x14fIlqVNPgTZl6R5NcLoE3NMVs1cdJedp24WTw3iH19mF4DepxL0JRmff
 TLWHzZ9UbG46ycNqWnkgP6YxV8EQC7G8qXLRq0Xo1rlc7TkpsbqjZGkQjMyzgkbp
 mNOeOhe4zCsPksiXz6tzLdjbxOCyr6FbWww==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793015015; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm1:rsa-sha256:T7YfEqhBpxECH0O0OIv8cb0dK2nHEDIEw8hX3pTteCGeVrG
 iuy2YnCumIbJMDo/kccVM8+fJztXod8KaEDYCq+177nU5ItWk83Sw/cZfbO0ivMJ
 Q9xs4Xc21zLUJIzvzgqR5uhjI+5qjMJUBAm0gK2eYlWt0j94Z1DjmnWdLQBei44Y
 Im9xszyyBpx9VX0r1+4WowulD4IIhtjIhjmhxzKOWFBY6K6HzpPHx9ZybY4WIAMp
 rrhQRUDuGeNbC3cxe+jwVSUxjB4BduK4i06nbvAtz+cEiG/TiArfE5C/3Kx3vhRT
 zREB0TrCFjWAM2C/EzDElRKDTA2TWw8rhJGeKdg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-disposition,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:ZmCaHCsvipYALuJy+MXk+po//SBb/JGV0x4ixeEv/A8=:QGx2kvCtTumQbMkIc2y6ECOk4/cfSdKN3m3OOrTVUVI=;
X-ME-Sender: <xms:5jzfanQtUWc3_nxKE7IWYLimaPE4laGHk8XTxBIXa_0-hBDm5rXyhw>
 <xme:5jzfakyQDkxbAnF6OHYqySw4FlQ3wJcM02SKVADzNCGix6SEenVYt7-UU1z8Yvjnl
 C8b2wx4GImB7L6kKuHljEJoy2s0GlDz4KOJ1DeFXdLbisE0kaVYf3r6>
X-ME-Received: <xmr:5jzfavAIq-ijJTbISKrqWFCujgYj60WOGK-Qd-zlTFZCTJ3UVHRJEMiYmljA>
X-ME-Proxy-Cause: dmFkZTE23kF2GMMNtn3aN9dejObauURWiFD6mI8VJan+B4RNi044qhjCCgT/ZAE85RxRqr
 kHObThgtk0b58jsOj3X0iCWNy/aNydRBACSkuMF1w1azOgtFX4VZ3CraLxP70VRrRSGo0T
 XTMenUc7HgQtR5ih32/OgSgY7j6tiaKIzT6ErLA9buTuNkAaJ7tLKyIA6034AiccKtWsKK
 Kp26/21JCotsjM5JAnxu8djz0l3wOxdiItTogregOH2IOuIRfitHfitNO7cmI2L7cotVx1
 qkDJ24mDQW7dTtDjNNY2bQq0ZDkjYBCe9mrOIsKDD69beNZdw3LNEZhSYN/s6f/G6GwNF6
 OvktklKd+nktzdp4SUROw/yhM70NN4XnClVFsweS+JVdftLXW0gxJcSj3i8RDafDg6oVFL
 vP4syfUWAKO/zhwSBktnSNmAiPSJf5UFWOpYdRGnxCQ6w+igbBfxpb+7xUCyAJLkXYDbYN
 aIrzaImfLAez4yJlaF/CXH5jsoeWvDt/FDvNEM0y0ujzL1y+nw2861P3Yks/M2OBRHso/x
 2YjTig1EZAove4tx3WfdFOdyIppJF0hThBwQaeObxbakeW9Mv1XCtUwjNGvmFPDorlSKf4
 02mWVjZeQrRFBRbO89JlRr7oYJUBDRm7bPaVeRp+D+ugh/mRRIUa00CseR2w
X-ME-Proxy: <xmx:5jzfaoFOzkqWvggEDKHgK9YdgBcj0aDKcGOHYPWOQ6eqKAqhOm8wWg>
 <xmx:5jzfauMnafiigh_Z4poCxj3WQyKYdpeHI46rtqnPzRZZboN8e5EAIQ>
 <xmx:5jzfah6jbOtVIOXuh8d9l0ma16A4dL5wR-324EFh3rEZa6-0Ogr1lw>
 <xmx:5jzfapiX9rzbvFoQveUt-Tzf69S4-m_nJx8hJXz02riaZBmzOKuazQ>
 <xmx:5zzfasW0Z-ULY4kLyEWPQw2NEzg-O9TNXpc9ADQQZvVZJT72lCCPi5Yv>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 07:43:34 -0400 (EDT)
Date: Mon, 26 Oct 2026 12:43:31 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>,
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH RESEND 1/5] hw/nvme: fix endianness handling in the
 atomic write path
Message-ID: <at884BO3rt0R8RQB@AALNPWKJENSEN.aal.scsc.local>
References: <20261026-nvme-mam-v1-0-5d53b5529ffa@samsung.com>
 <20261026-nvme-mam-v1-1-5d53b5529ffa@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6dalPMlUy9TF/le6"
Content-Disposition: inline
In-Reply-To: <20261026-nvme-mam-v1-1-5d53b5529ffa@samsung.com>
Received-SPF: pass client-ip=103.168.172.157; envelope-from=its@irrelevant.dk;
 helo=fhigh-a6-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--6dalPMlUy9TF/le6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 26 11:13, Daniel Gomez wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
>=20
> NvmeCmd, NvmeRwCmd, and NvmeIdCtrl are NVMe data structures in
> little-endian, fix the cases where their fields are used as host values.
>=20
> Note that in the case of nvme_atomic_configure_max_write_size() we now
> pass the clamped AWUPF instead of the unclamped one.
>=20
> Fixes: ebd1568fc732 ("hw/nvme: add atomic write support")
> Fixes: 3b41acc96299 ("hw/nvme: enable ns atomic writes")
>=20
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

Will add CC: qemu-stable@nongnu.org in pull.

> ---
>  hw/nvme/ctrl.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 4893cf7e741..c884ca8a181 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -7832,7 +7832,7 @@ static int nvme_atomic_write_check(NvmeCtrl *n, Nvm=
eCmd *cmd,
>      int i;
> =20
>      if ((cmd->opcode =3D=3D NVME_CMD_READ) || ((cmd->opcode =3D=3D NVME_=
CMD_WRITE) &&
> -        ((rw->nlb + 1) > atomic->atomic_max_write_size))) {
> +        ((nlb + 1) > atomic->atomic_max_write_size))) {
>          cmd_atomic_wr =3D false;
>      }
> =20
> @@ -7869,7 +7869,7 @@ static int nvme_atomic_write_check(NvmeCtrl *n, Nvm=
eCmd *cmd,
> =20
>              if (((req_rw->opcode =3D=3D NVME_CMD_WRITE) ||
>                   (req_rw->opcode =3D=3D NVME_CMD_READ)) &&
> -                (cmd->nsid =3D=3D req->ns->params.nsid)) {
> +                (le32_to_cpu(cmd->nsid) =3D=3D req->ns->params.nsid)) {
>                  req_slba =3D le64_to_cpu(req_rw->slba);
>                  req_nlb =3D (uint32_t)le16_to_cpu(req_rw->nlb);
>                  req_elba =3D req_slba + req_nlb;
> @@ -7895,7 +7895,7 @@ static int nvme_atomic_write_check(NvmeCtrl *n, Nvm=
eCmd *cmd,
> =20
>  static NvmeAtomic *nvme_get_atomic(NvmeCtrl *n, NvmeCmd *cmd)
>  {
> -    NvmeNamespace *ns =3D nvme_ns(n, cmd->nsid);
> +    NvmeNamespace *ns =3D nvme_ns(n, le32_to_cpu(cmd->nsid));
> =20
>      if (ns && ns->atomic.atomic_writes) {
>          return &ns->atomic;
> @@ -8889,6 +8889,7 @@ static void nvme_init_state(NvmeCtrl *n)
>      NvmeSecCtrlEntry *sctrl;
>      PCIDevice *pci =3D PCI_DEVICE(n);
>      NvmeIdCtrl *id =3D &n->id_ctrl;
> +    uint16_t awun, awupf;
>      uint8_t max_vfs;
>      int i;
> =20
> @@ -8950,19 +8951,20 @@ static void nvme_init_state(NvmeCtrl *n)
>      }
> =20
>      /* Atomic Write */
> -    id->awun =3D cpu_to_le16(n->params.atomic_awun);
> -    id->awupf =3D cpu_to_le16(n->params.atomic_awupf);
>      n->dn =3D n->params.atomic_dn;
> +    awun =3D n->params.atomic_awun;
> +    awupf =3D n->params.atomic_awupf;
> =20
> -    if (id->awun || id->awupf) {
> -        if (id->awupf > id->awun) {
> -            id->awupf =3D 0;
> +    if (awun || awupf) {
> +        if (awupf > awun) {
> +            awupf =3D 0;
>          }
> =20
> -        nvme_atomic_configure_max_write_size(n->dn, n->params.atomic_awu=
n,
> -                                             n->params.atomic_awupf,
> -                                             &n->atomic);
> +        nvme_atomic_configure_max_write_size(n->dn, awun, awupf, &n->ato=
mic);
>      }
> +
> +    id->awun =3D cpu_to_le16(awun);
> +    id->awupf =3D cpu_to_le16(awupf);
>  }
> =20
>  static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
>=20
> --=20
> 2.56.0
>=20
>=20

--6dalPMlUy9TF/le6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmrfPOAACgkQTeGvMW1P
DekrWgf/dCQdFVsGnYh7IwmdrfuQRjcJlDuXfJ9Ox2PGqIxwkcpvm6JPidV4URKQ
grbcwpYe+WX/8yUIbCROsUklzGoRQTHn/Tynle+DsK1zjUHj7rUV/51AcIYQAilK
G6uq6Sv0ZmZNfUCIucnoEmnM1e24fPv9kWYqdelonBKs7hLGIA4zeTp0i/303X8A
y33M1wpz6WT1kRiAYecE02+ioAW2yonqA+c8BM94ZYxzs0qxUYRVwwtOJqncWWKV
2R09sk7+vwzT9U+NwiWw0/hEDfn6D3nqR8uSJodoIG4ngtYsvpMtdXrIvtyDqilM
FlK9WqETVL34uGPWdwE+kBf7TA0gzg==
=q/XW
-----END PGP SIGNATURE-----

--6dalPMlUy9TF/le6--

