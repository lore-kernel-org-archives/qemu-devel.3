Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07705606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=Cw9AQ5VZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JBI1H17Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWVIt-0007rg-TW; Thu, 26 Nov 2026 03:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xWVIp-0007oE-BF
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 03:58:03 -0500
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xWVIm-000353-If
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 03:58:02 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 06E621D003E7
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 03:57:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 26 Nov 2026 03:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1795683478; x=
 1795769878; bh=6sLfcT9LuxcagKgdTxF+/AegvnxXxI9GyOuxg86jyj8=; b=C
 w9AQ5VZHaBElTYnHGGzECBCEXdrCzojGEU0PoOs45e9DFzr2OEgUPt5l6GzmebBF
 nfFvwyUv4Do+hJiQi3b9YFhjStZIpK/cuOATmbZer+nXjQTO+daUUMDTTdKKw2Es
 wIU2/W4T2vcWyt2TEBovPsFV6fNfryrbi68c0Kp49uJxbZk2Mr4amHS/FowGmRaR
 b2wmCvjIZB/2CHiMI+CzpwUNWdDze3uwyuDjX9nrtNqgOlRbTn4pGqdrvhyb+iyd
 Ctbe+BRa+A7YLiNk0DWNrH5p8a49OaH+f861QTHgXsQ1+RHv3C9uuuRzJ3vw/NLC
 5TgTgMWhklmJ6/umwylXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1795683478; x=1795769878; bh=6sLfcT9LuxcagKgdTxF+/AegvnxXxI9GyOu
 xg86jyj8=; b=JBI1H17Y1t3RB5V2V6H4aS5lPWxVIAflkcTby2FDOVne1f9q1Vg
 9yOrYQ45jnPbRJx61MIl0OBPUbDztA1uOabPXpAPtC47v6UzA4oaC9tvUkCDWc37
 TnDzR3os8Y4yIpDHPv79o06radCqV9DT4fyEasjOyDIJc3LYrxaH/zNiO8ilzS+A
 9W5a2bZtAZxt79iDGj3Jgp/9Xru0XQnrwevwTfEeDh+R6mXY10SwziJdCgF2pQE5
 jpN6CjmzRBYmkCNz50+lhcznct6tbkRA5zR7nWSQxab2YxlFEPgUhHdcstVr21Xk
 xZ3Ywa4R7zjw60JIRazrnFuPQ5puLXXhJRA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795683478; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:NUNnyD0jXPUrYZ5YiFs+mWS9GYCqjS/3059voEebNtQMbf3
 RQSw/tG9a0YANuYJJqd5pY2Gb5QyvIyafzSyRJRH1ZX55qfLccGutg03L/5a+tID
 yb9lQUvEs3kVESVsr1XRLX28I/V5r629Kd/QbXTLw27hc5h535qSgBpcUTx6x4NL
 LLqd7ZYgcqgBe6cAIuEetLuXnXXhfDuSV1wXTtcQLHB8X5+BBndL2jolpxjiH+Zm
 ggj8jo4jVGofEt10mnEqRtUiQAPa+F4du3TL9AfzKHlOghEHAyKxvPax3CPkLTlS
 ZKy6iYtsNJn/lrtrNG/NnETWRUwZ2H4zPiM/Lfw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-disposition,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:t9dLjqWFfh+oWwzs9jcbO6SK36iIHgM1swog5XX6WZw=:Oo2JiVBzhXPbQUhO1qxdB21dRGorfC/bf40D1FWUvnY=;
X-ME-Sender: <xms:lvQHa7gCq3jS327YIA-Z_HL8k_EQB4sJoZms9JX_v33uHiBMQF0jxg>
 <xme:lvQHaw_S3RqxZbuFF2I8BR2AA0HN8H7IXBJ5slD5zPF8Epk0-dJltxhZGszv8R7MW
 3GLBZOSZMzaShJSbnsQvA8hE71A3V0ULgJLvxjtUwGTdGd4T08zliQaKQ>
X-ME-Received: <xmr:lvQHa2oyObnRYpOcLwUaw9qrAXIsJUS_JYT5gLHPes2jeefZwIt22QsuQP-2pwBEuacYRm5-anW3oM8Dh01pCPlLR-1OB94>
X-ME-Proxy-Cause: dmFkZTFo94kLYF7hAb+9+2gHBZr8SLtnN0ADOO7PwW6xDuh0HMu3+dYAtJBdF6FnpK8+Gr
 e6H0spC4FNqITXeABn9UCScMnkUT5In5rNlKvsWv8vCiLAqM3NCjB7JkrPQFA4Q/hSIHmj
 V/awYdCm1FGdRjtYKt+4+33pGT6HK/R3WsdOr6h8jHrb9i0sQibW/e4ymzYvKRoaj27VN1
 pX+qxBdup3BC4uBD11N06M2ywxVgWYgMUsJse+/RbG3gVIj8ope9qXeTcQ1Qs64bjILwKq
 xLMFq8sbtCIN3r4+SOCEvVkQf8BBrk1f6CzDbB1f+iFjpzkvxldtPMyhOJ3MfPFHtxokm5
 MzupfpG6slYk39HysneUC6uoi6ym4Lwt/PDjEkCx1vBPoJbIC4hGPNld3E/CFL0CR5GULK
 m7fxjC6H0vKIsaTv8qCJoIiuC9+tV1aAa5vtgUgnhrhzgFnJOxWGsf/mR2uHmVcQce8uTf
 DehmTbRAeBAQpG4+lbf83RjLaecC9egeBjc0CS6jYiztq2ZRPCNxRUzM5NsV4YeXU72Mbw
 hmKUOqvUazr4RJZqw/bbxCbIicR2FftbJE8NQL754PsP4/wUtenzygRZtOYXGz7REXnido
 Jsd6Ps5ogpMdg+uQPtPteMvQwK/4Kyen/GEDj4pIz3iP3enjXUx8uduoxVlQ
X-ME-Proxy: <xmx:lvQHa4X0zp2T9VH9AHIZSLKQKr7oqfOjsxpL00mRI17PNNea1shkcQ>
 <xmx:lvQHa1D1LCpuhuas2PkJmEYHUKUdP65fYAzeOpp7CaCAjAx7RD_aQQ>
 <xmx:lvQHa83CN8PtdXqvcFr6T6y1Pzwxe4ZnuVxj1Zp2mNKgT0XqHVPBfA>
 <xmx:lvQHa33uM_lYLA49-YRg3IMfZgkvdBMtugGF6Zd4zI2TWYBZ2sqtVA>
 <xmx:lvQHazEp96XWSG1CZHM9BjwGtPXfzywVAi4jrOI6-QFVVx3LOP7I54Gd>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 03:57:57 -0500 (EST)
Date: Thu, 26 Nov 2026 09:57:56 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH] hw/nvme: fix interleaved transfers through host memory
 buffers
Message-ID: <awf0kS-YmgOvxWfm@AALNPWKJENSEN.aal.scsc.local>
References: <20261126-fix-4520-v1-1-ce4dfd39d38f@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2UOSfwQ0AE6cBIe9"
Content-Disposition: inline
In-Reply-To: <20261126-fix-4520-v1-1-ce4dfd39d38f@samsung.com>
Received-SPF: pass client-ip=202.12.124.149; envelope-from=its@irrelevant.dk;
 helo=fout-b6-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--2UOSfwQ0AE6cBIe9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 26 09:11, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> nvme_tx_interleaved is used in the bounce path for interleaved metadata
> (extended LBAs). It does not consider that the scatter list may cover
> host memory instead of guest addresses (for example, CMB mappings). On
> such non-dma transactions the host pointer is fed to nvme_addr_rw, which
> treats it as a guest address. For a controller with a CMB, I/O on an
> extended-LBA namespace with protection information fails with a Data
> Transfer Error or, worse, ends up corrupting guest memory.
>=20
> Move the data directly for the host memory case as intended.
>=20
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
> Fixes: bc3a65e99254 ("hw/block/nvme: add metadata support")
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Cc: qemu-stable@nongnu.org

> ---
>  hw/nvme/ctrl.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 5755aad1fa72..a698b553bab9 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -1315,7 +1315,6 @@ static uint16_t nvme_tx_interleaved(NvmeCtrl *n, Nv=
meSg *sg, uint8_t *ptr,
>                                      int32_t skip_bytes, int64_t offset,
>                                      NvmeTxDirection dir)
>  {
> -    hwaddr addr;
>      uint32_t trans_len, count =3D bytes;
>      bool dma =3D sg->flags & NVME_SG_DMA;
>      int64_t sge_len;
> @@ -1343,19 +1342,25 @@ static uint16_t nvme_tx_interleaved(NvmeCtrl *n, =
NvmeSg *sg, uint8_t *ptr,
>          trans_len =3D MIN(trans_len, sge_len - offset);
> =20
>          if (dma) {
> -            addr =3D sg->qsg.sg[sg_idx].base + offset;
> -        } else {
> -            addr =3D (hwaddr)(uintptr_t)sg->iov.iov[sg_idx].iov_base + o=
ffset;
> -        }
> +            hwaddr addr =3D sg->qsg.sg[sg_idx].base + offset;
> =20
> -        if (dir =3D=3D NVME_TX_DIRECTION_TO_DEVICE) {
> -            ret =3D nvme_addr_read(n, addr, ptr, trans_len);
> +            if (dir =3D=3D NVME_TX_DIRECTION_TO_DEVICE) {
> +                ret =3D nvme_addr_read(n, addr, ptr, trans_len);
> +            } else {
> +                ret =3D nvme_addr_write(n, addr, ptr, trans_len);
> +            }
> +
> +            if (ret) {
> +                return NVME_DATA_TRAS_ERROR;
> +            }
>          } else {
> -            ret =3D nvme_addr_write(n, addr, ptr, trans_len);
> -        }
> +            uint8_t *seg =3D (uint8_t *)sg->iov.iov[sg_idx].iov_base + o=
ffset;
> =20
> -        if (ret) {
> -            return NVME_DATA_TRAS_ERROR;
> +            if (dir =3D=3D NVME_TX_DIRECTION_TO_DEVICE) {
> +                memcpy(ptr, seg, trans_len);
> +            } else {
> +                memcpy(seg, ptr, trans_len);
> +            }
>          }
> =20
>          ptr +=3D trans_len;
>=20
> ---
> base-commit: 9751c62358073580cbf330a4df22077a7c6a407c
> change-id: 20261125-fix-4520-92154e6a45c4
>=20
> Best regards,
> -- =20
> Klaus Jensen <k.jensen@samsung.com>
>=20
>=20

--2UOSfwQ0AE6cBIe9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmsH9JEACgkQTeGvMW1P
DelEDQgApbSZk0HZF1rEcsSeyS/iDtgvVvA2pffykGsmy+AWCm1Xajp8ap5NUkeW
hZtmVQ4wyN9wkS4JTMcayFsY+ytyXAfp6YSapuON7N6mdomoNiROJ5O6KCH/6X2A
l0K7EsqSCbUhuJTxX/AfFCyZHKIGMBUnkiOxVFfhpJSmxXtk3bOCvOhJQitv+uUa
zgCOXZkuuPXlYwnncYWZ1T7+urLGrKuRaVEPl2d5DTO2OdYge8wg3Xf5ns84XWoq
E+PYqevKwuVAAgk7n7AimonCqCOREB/lnemCKu3+0Z8D/i9bXDOi41SxjV7szh/y
JvJ6Ebw4YNG6PFXJG/jQxyucvbmGVQ==
=7tMF
-----END PGP SIGNATURE-----

--2UOSfwQ0AE6cBIe9--

