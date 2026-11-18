Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CEB606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=OjN492KA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=IdvG2EYr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTnbi-0008RV-Pe; Wed, 18 Nov 2026 16:54:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xTnbf-0008Ps-J4
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 16:54:19 -0500
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xTnbd-0004Y3-Rq
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 16:54:19 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id E974E1D0023E
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 16:54:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 18 Nov 2026 16:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1795038855; x=
 1795125255; bh=4vb6T13sRILfaCGX2ocVOFGLPaZbwcrOJFQKh5q3o8E=; b=O
 jN492KApNexvWfhJ23s3zpJUtxKiXU6kqTk3sUXW5Bt/q3Z7JqZlUswDt5yIWwu+
 riSpj6DO5/Ka4SUaB7Nigae1bi/1xmT2O+2Y5nJPM4L/w8Qsv03e/fxyDMziOWGh
 pNO1vdRSS3wt3SfUqSDMcuqsO9u8gPtlzqVzajDGkeDehD8mo4CHTtHzEC3kFA9s
 uUrOSxVCkgQU5Oerta7GetDjSj4ce0nBN75KtpH2v8dweKsNCHQYbU5yUV+7XdCv
 OuO0p9I8zBy4Q/GkFmgNyKex0BU56CSTIQeoOhu7XqmCGcNZzKy+a5Wcj6eRATG8
 xXy6Je1WsjPOySt5wJMrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1795038855; x=1795125255; bh=4vb6T13sRILfaCGX2ocVOFGLPaZbwcrOJFQ
 Kh5q3o8E=; b=IdvG2EYrD1gjfOnmINpmzK8TkCtyKUsP4ZDKLuKPeb4saRsQK5Q
 dBAToY542442SellgErAgpfiwqhq9e66etRyr4o16c0tynGbXecLTzjlbnE8Y6z3
 73+hY79Q/5/vzBeyTmRKw8U6OSp0ru2i+Vx1J0AwpkvbvGa5ot7kiLqLoWF65sq/
 Sz40vlAD43AH8pDJtcm8YPl9TU4rh7BMrNLaTUJFf+Xj2vI3zvY3cDT+/8KatWCJ
 cl06EKM6IiQARO3n9gQofWsYHRCe8tlNi0Vx7jIRDshPSBfpy7mFIBriZ9xwvA2+
 dlDpKOn8Cp0bJQ5dL6Rr//slp3/i8VPPyXQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795038855; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:QpWK0eU1ZoDSY/uW9Aw9mAysmr6A2MpsQarrgCIU/tFuHll
 7eGct/MFT4SJj6CBbPbaPekRXJIQxPbNJrSURl+70sHjQJC4vx/Qy7U38aS2ttaY
 0BjVbIR7uPPwHK6eMoxZ8taBeZl/R9PQBWzkK9m6Jq1LDaRepBsZ+AN3yIOxFipC
 VaruZdKdSPndp1UrdWUjIceVFV9rjZT4d/1fl2/R5s+NStpBSyJQMnw7msPqX1ca
 zmEBk02SJ8rUxGO8JYv86gQKGbV+aX369XAxNHxBzwIH+lTDFShwj6rvKgfM4KRS
 KsULDGLFExnN70I16qM2fv8jHb3gGcfu5lnOryw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-disposition,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:EsPZeJjiXEJokMcI7HHlYrKd+wSTeEkbPp6Q4AGU3Sk=:lio6VCHr3WLpehgKtQ19BZnFN11c+OHVw/Nk/AN9/SU=;
X-ME-Sender: <xms:hh7-ahFiNF1HzVsrIn7C3MeYfLft7TD7gDN4lPBucY3fqux-YFj0Wg>
 <xme:hh7-avRgEekVuJJiesBLskD--52KyYWy8nAb-8MVBe37rkxOEzyisP7tpaq8vqT-4
 z95zg5IVPmonoGoLa_9GURY9Q3QE7vDItD7MD_U5uyLM9d1CXWaNAzy>
X-ME-Received: <xmr:hh7-auvHqiiL9MPmaqpzh3Ih2IUWsDZfE9pVM6mAr3tGtTKrqvgUu5yP9gN35-di6rhljCxiSNnE2FGuYgVHBasKx4VdrKc>
X-ME-Proxy-Cause: dmFkZTFGuu8CD/3+TSDwkY6CZ75VQfaEytTDPiRpJ+0i2xh1FqiVlCV1kZEGiYxASD2ZRr
 uPk0EYSZ9sNDg7ZOnLufi0LcCD2eVkDDUUCCfJrOWPeBuzPEPWyvenZqL5i8tVBfLXuF0i
 UdO1YefMBBFPl/UNhtdEQqjNjanDVNGnoxTlA7ET3uSuafyqLMd1VEgSU8nm42MkETN00x
 ZZH1IgT8NmoiNJCOivrlI2TGjW8RlvqWAesMY7sTE/s1dhGvq9iGXlakeAomKUQJ82NSMT
 ZPTpcwHiGS5lQud1TMHtb6c5MV4HeD1N0t5InOjGcMdk6y6kRS8BjbiE7r351TNxF570EU
 Zvnjbwlc9YSVotH/xVzJJBv27AIQilfcqcwhap9EnkX6E/Xmo0u8JfK3IDspWt0ljynHyY
 CH2wVSZ7zk6HyB8/VVu6E7LDnyIZbwX/8ZNRsnFhTifDtaL5auk+lCpK2MFYnhZ2xB9TuS
 zkYnn3FfQb36xT81RT8+PKFFA7nrmjMqpJ+8tKImAvQVnmI8x84+u3UVFfhq85ND6PsNRw
 nz6GYswWg54sQ1PgZys53IyWtt9ERSeDWCntnF5RCoTCtC6PPDcIaNp/5NjP6Lk8cp0X39
 NLTqJK0xb2Avs+la2KyoIrK/Any3aj3GuaOkAWqfE3qYjTvrqITEvwogUR2g
X-ME-Proxy: <xmx:hh7-anKCac6I2qYx_3lFrtomHblDxlmUFMK8S9ESy44WJMcgNHkSPQ>
 <xmx:hh7-ajlR-hPyzGIKZinQ-B4v07BdxYhhTyXChbQe8U9zKmrot0-pvw>
 <xmx:hh7-agI7B5nTMBHZZJ2qDvjbdo1EnACwwfYhF1hg71uPxxwm2HbqWQ>
 <xmx:hh7-ag67ZS-O1V9zE3mZI6uInjOu1YxMhmZID0trYGp7rLXTr-gdtA>
 <xmx:hx7-apL8z7p03AX39xSXaHYUpRgdHJeSK0I3P-cd0XrUNGjgl5jjKVjX>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 16:54:14 -0500 (EST)
Date: Wed, 18 Nov 2026 22:54:12 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Jesper Devantier <foss@defmacro.it>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Jesper Wendel Devantier <j.devantier@samsung.com>
Subject: Re: [PATCH 1/7] hw/nvme: get feature - return invalid field if sel
 is reserved
Message-ID: <av4egTdSTXJUlQUV@AALNPWKJENSEN.aal.scsc.local>
References: <20261118-jwd-181126-fdp-fixes-v1-0-ed76fad7861d@samsung.com>
 <20261118-jwd-181126-fdp-fixes-v1-1-ed76fad7861d@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xe136c9rPGWUi2mO"
Content-Disposition: inline
In-Reply-To: <20261118-jwd-181126-fdp-fixes-v1-1-ed76fad7861d@samsung.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--Xe136c9rPGWUi2mO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 18 16:01, Jesper Devantier wrote:
> From: Jesper Wendel Devantier <j.devantier@samsung.com>
>=20
> Base 2.4, figure 198, bits 10:08.
> Get feature will now return invalid field if the value of sel
> is in the reserved range.
>=20
> Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>

Fixes: 7c46310d298d ("hw/block/nvme: support the get/set features select an=
d save fields")
Cc: qemu-stable@nongnu.org
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  hw/nvme/ctrl.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 71c24dc02b6..ee670481876 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -6462,6 +6462,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeR=
equest *req)
>      case NVME_GETFEAT_SELECT_CAP:
>          result =3D nvme_feature_cap[fid];
>          goto out;
> +    default:
> +        return NVME_INVALID_FIELD | NVME_DNR;
>      }
> =20
>      switch (fid) {
>=20
> --=20
> 2.51.2
>=20
>=20

--Xe136c9rPGWUi2mO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmr+HoIACgkQTeGvMW1P
DelxDAf/WOhUjNLmn8VYcRwwyT9LitC3meZU9z9+i9BI0WI6u47zEEP2dKf58N7N
fN5eCAN/NcW3Rk2cmbm8vj6gufZBE5NCsUsKyrqfotLIW/CgXWVjPuha2MSLFM0g
exjCvq0JDIdGeU05g8NoRVaWUxWCTXcuKo98gqJdZUdbY5JesuV3KCKmhYX91Qej
QgsNFHnST8a+fKNxgIAA3R/zXWRl0Mgj8H6gZgTWtqfJ3C/hvWXr2nfITgXEgHI+
Jl5regMblBMqT9SL2MU7ntMHX5LWkrEi5JiASKKQwICYhoSEBgEQKfnwiAvEy2Kl
LaVc4dgjbvLonW5GcWwXpdVUYuhGAA==
=PhQo
-----END PGP SIGNATURE-----

--Xe136c9rPGWUi2mO--

