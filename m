Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D0BC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 08:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQjaC-0002h8-EY; Mon, 08 Jul 2024 04:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sQjaA-0002Yt-Oz; Mon, 08 Jul 2024 04:18:46 -0400
Received: from fout7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sQja9-0001Qb-2X; Mon, 08 Jul 2024 04:18:46 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.nyi.internal (Postfix) with ESMTP id B28771380841;
 Mon,  8 Jul 2024 04:18:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Mon, 08 Jul 2024 04:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1720426723; x=
 1720513123; bh=LT4cIEzPYXls8RV9XRrr7c+k29KARiEDFndSIVUd6eE=; b=a
 /osUB6xF+TzkXIWORuGbkgbo36EMgHD7kEbDmF1j6WRuPKHxL6J9svjjFOlm6uEs
 rHdhTcHDg5OmYILpCjHtiDtFLH8ypRSjDcsEbvWU5LmkhpW4whdKw/tIPE3sxWMP
 8Qn1mUVacINrRWzdy3hTMO3F3KUlvnhcbZBrmb/mnpEYIityQu1Q7N51pQI6YcS8
 fUZ6HCqZRWEuxCsOkn3HsPx0wNGGncgvhvTs9h9uV6CdxJG5f3TVB4b3DXBQ/Rum
 hYIFj+BcGOz98HPedJ9vicfmucNIixWPXVuXMeDojqBQCpfHO5uuGEQeYSFEGyKF
 wQBodFQDcKg+XLOa8xDQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1720426723; x=1720513123; bh=LT4cIEzPYXls8RV9XRrr7c+k29KA
 RiEDFndSIVUd6eE=; b=H9K99WG5+8mG9d0KU1ZPDhUWoQM28sDjPe/66SllHxM0
 +f4844RtpVJwPanGjoTmMeR/QbQowVDanTnADVQUeUWthHG/AIrYulTvP91f0lYd
 VyRJPM9Mi6rUZN4tKsmbBkJP/dyXfBLUEDVLK72bcxuHX4na7QZr7TW6EVxQVPfi
 NEyyUoILGPJQP7CTKnCNQQYsjrBCzgZpv9XwVFD6PawHaw8g9njL6W5DpQHlGZ3M
 ik4dk8syYunl3wPXe8HvwuW/stORFHsE6o+885CI6oDOIkGYrciMkOx761ekZj/s
 dfVbmHEVDxcTXnvc4qgx3V1btpfeQSXb5kbAA7d86w==
X-ME-Sender: <xms:4qCLZgrlfcMqLy4HEkpkGnY_PZik0pli6ae_DC75uwWWlLyKDA9R9A>
 <xme:4qCLZmqdj3FcOKiBQT2PxB5cOS2hgdXs4RwElgladaGzZaZxQS3YiDHCBn3Pjp9qD
 ijgpMrgE0UqmkHh-l8>
X-ME-Received: <xmr:4qCLZlOaq2Iu615tlemxhW9iBEhtrPzmgqWI3RlrmVNvJ3kND9pnj5csiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejgddtudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffej
 veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:4qCLZn6zHrOtj-5CRNmHJn_dir7BL1VKxMU2iNl6eZwroJ5Wfjptlw>
 <xmx:4qCLZv5kwdFNS8VKT0GEEKhjypen-6fXsysoAAKHUL0S6rSB8E_lPA>
 <xmx:4qCLZnjQIu_OWN-jZjKL_GeojjkeCT-Z6gSVFReGShKs-DQPZi1BGQ>
 <xmx:4qCLZp4kXMpIQ7DbGM-rOxaoXpDudKvYfCm4iklxGVj3hWDEyD531A>
 <xmx:46CLZurAa2ep9rbfFTNFBFoJbPJxYAkLZnJJH7evgd1DXx5MjkLtoXpc>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jul 2024 04:18:42 -0400 (EDT)
Date: Mon, 8 Jul 2024 10:18:37 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v7 07/10] hw/nvme: add helper functions for converting
 reservation types
Message-ID: <Zoug3X2md0oskFu-@cormorant.local>
References: <20240705105614.3377694-1-luchangqi.123@bytedance.com>
 <20240705105614.3377694-8-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DAyUOdiTu5dOOLC5"
Content-Disposition: inline
In-Reply-To: <20240705105614.3377694-8-luchangqi.123@bytedance.com>
Received-SPF: pass client-ip=103.168.172.150; envelope-from=its@irrelevant.dk;
 helo=fout7-smtp.messagingengine.com
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


--DAyUOdiTu5dOOLC5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul  5 18:56, Changqi Lu wrote:
> This commit introduces two helper functions
> that facilitate the conversion between the
> reservation types used in the NVME protocol
> and those used in the block layer.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  hw/nvme/nvme.h | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>=20
> diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
> index bed8191bd5..6d0e456348 100644
> --- a/hw/nvme/nvme.h
> +++ b/hw/nvme/nvme.h
> @@ -474,6 +474,90 @@ static inline const char *nvme_io_opc_str(uint8_t op=
c)
>      }
>  }
> =20
> +static inline NvmeResvType block_pr_type_to_nvme(BlockPrType type)
> +{
> +    switch (type) {
> +    case BLK_PR_WRITE_EXCLUSIVE:
> +        return NVME_RESV_WRITE_EXCLUSIVE;
> +    case BLK_PR_EXCLUSIVE_ACCESS:
> +        return NVME_RESV_EXCLUSIVE_ACCESS;
> +    case BLK_PR_WRITE_EXCLUSIVE_REGS_ONLY:
> +        return NVME_RESV_WRITE_EXCLUSIVE_REGS_ONLY;
> +    case BLK_PR_EXCLUSIVE_ACCESS_REGS_ONLY:
> +        return NVME_RESV_EXCLUSIVE_ACCESS_REGS_ONLY;
> +    case BLK_PR_WRITE_EXCLUSIVE_ALL_REGS:
> +        return NVME_RESV_WRITE_EXCLUSIVE_ALL_REGS;
> +    case BLK_PR_EXCLUSIVE_ACCESS_ALL_REGS:
> +        return NVME_RESV_EXCLUSIVE_ACCESS_ALL_REGS;
> +    }
> +
> +    return 0;
> +}
> +
> +static inline BlockPrType nvme_pr_type_to_block(NvmeResvType type)
> +{
> +    switch (type) {
> +    case NVME_RESV_WRITE_EXCLUSIVE:
> +        return BLK_PR_WRITE_EXCLUSIVE;
> +    case NVME_RESV_EXCLUSIVE_ACCESS:
> +        return BLK_PR_EXCLUSIVE_ACCESS;
> +    case NVME_RESV_WRITE_EXCLUSIVE_REGS_ONLY:
> +        return BLK_PR_WRITE_EXCLUSIVE_REGS_ONLY;
> +    case NVME_RESV_EXCLUSIVE_ACCESS_REGS_ONLY:
> +        return BLK_PR_EXCLUSIVE_ACCESS_REGS_ONLY;
> +    case NVME_RESV_WRITE_EXCLUSIVE_ALL_REGS:
> +        return BLK_PR_WRITE_EXCLUSIVE_ALL_REGS;
> +    case NVME_RESV_EXCLUSIVE_ACCESS_ALL_REGS:
> +        return BLK_PR_EXCLUSIVE_ACCESS_ALL_REGS;
> +    }
> +
> +    return 0;
> +}
> +
> +static inline uint8_t nvme_pr_cap_to_block(uint16_t nvme_pr_cap)
> +{
> +    uint8_t res =3D 0;
> +
> +    res |=3D (nvme_pr_cap & NVME_PR_CAP_PTPL) ?
> +           NVME_PR_CAP_PTPL : 0;
> +    res |=3D (nvme_pr_cap & NVME_PR_CAP_WR_EX) ?
> +           BLK_PR_CAP_WR_EX : 0;
> +    res |=3D (nvme_pr_cap & NVME_PR_CAP_EX_AC) ?
> +           BLK_PR_CAP_EX_AC : 0;
> +    res |=3D (nvme_pr_cap & NVME_PR_CAP_WR_EX_RO) ?
> +           BLK_PR_CAP_WR_EX_RO : 0;
> +    res |=3D (nvme_pr_cap & NVME_PR_CAP_EX_AC_RO) ?
> +           BLK_PR_CAP_EX_AC_RO : 0;
> +    res |=3D (nvme_pr_cap & NVME_PR_CAP_WR_EX_AR) ?
> +           BLK_PR_CAP_WR_EX_AR : 0;
> +    res |=3D (nvme_pr_cap & NVME_PR_CAP_EX_AC_AR) ?
> +           BLK_PR_CAP_EX_AC_AR : 0;
> +
> +    return res;
> +}
> +
> +static inline uint8_t block_pr_cap_to_nvme(uint8_t block_pr_cap)
> +{
> +    uint16_t res =3D 0;
> +
> +    res |=3D (block_pr_cap & BLK_PR_CAP_PTPL) ?
> +              NVME_PR_CAP_PTPL : 0;
> +    res |=3D (block_pr_cap & BLK_PR_CAP_WR_EX) ?
> +              NVME_PR_CAP_WR_EX : 0;
> +    res |=3D (block_pr_cap & BLK_PR_CAP_EX_AC) ?
> +              NVME_PR_CAP_EX_AC : 0;
> +    res |=3D (block_pr_cap & BLK_PR_CAP_WR_EX_RO) ?
> +              NVME_PR_CAP_WR_EX_RO : 0;
> +    res |=3D (block_pr_cap & BLK_PR_CAP_EX_AC_RO) ?
> +              NVME_PR_CAP_EX_AC_RO : 0;
> +    res |=3D (block_pr_cap & BLK_PR_CAP_WR_EX_AR) ?
> +              NVME_PR_CAP_WR_EX_AR : 0;
> +    res |=3D (block_pr_cap & BLK_PR_CAP_EX_AC_AR) ?
> +              NVME_PR_CAP_EX_AC_AR : 0;
> +
> +    return res;
> +}
> +
>  typedef struct NvmeSQueue {
>      struct NvmeCtrl *ctrl;
>      uint16_t    sqid;
> --=20
> 2.20.1
>=20

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--=20
One of us - No more doubt, silence or taboo about mental illness.

--DAyUOdiTu5dOOLC5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmaLoN0ACgkQTeGvMW1P
DenMNwf/ZQWFuKGkIuIDX4NQ1+4ikSFe788E9Z/IiZvZoP7jrYrRfUJUqFcr5Ilp
1HQ595C2rHPDHSrKlCfQgnfTvLILkyRu5xAmHPgg2nrNLHsvNJR09uRwgy6EKbzz
ilQnt4OfFtuWI3ydXsEU6Ou6VmPNR9EKRQeDPtRAEpaqYI3nPMgMltcz2PIHre22
aM7+KtI+oxy8L+sNUJwUeEOOMp8TPtQW6/T4jwHASQjJf4kgp/F4tN7+tIdcKh+2
u4p3FfgkkCo+99+BXQy7vCNDsyBRb45FNU7jsmA5zAuSvJqbOtn7YiZZgKxUYHnJ
ut1OK6rXCxg8euRrF924gJ9EWIpIEQ==
=a5Ik
-----END PGP SIGNATURE-----

--DAyUOdiTu5dOOLC5--

