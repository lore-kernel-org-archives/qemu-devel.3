Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88171606A32F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=agUqjnQx;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RLy1Vsbo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTieU-0000T4-KN; Wed, 18 Nov 2026 11:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xTidw-0000QN-FU
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 11:36:21 -0500
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xTidu-0005b8-Is
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 11:36:20 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 99ED07A0259
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 11:36:16 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 18 Nov 2026 11:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1795019776; x=
 1795106176; bh=VsrDUILDAUM4m1cPuEoMghsIta77LgsjOquSSmXtd6w=; b=a
 gUqjnQxlxosTXOtZVCGslhV/Q6KhEHqNyBQxfd8rRVFiYV7uqZyrX8r7yXr2PhTn
 dzQMbzifik56lbcNQRHgKLxmXZo/oHF2HmzX1Kt6iSPnSK0veaFcpPQ4TjimEdVo
 A1W+J5pYTPBJZ6pDOD4RH4GhWb/FMUYDagbcdGo5eEtRC+pQg/ywsjS21TYNkjRn
 oKq8SBjHaA+gb/UB180GIXFqYe+c1//FUSCnPSRL+9n8d+H+W/c58JphhW3eUJ7p
 +XhYtYOXSDg1jqTaekFDLY1J5d5CWlqidrqC5gFtbebUWlcxfNlpoW3GLaCK1694
 GvTFZZ/aXOiK7tGaYS/rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1795019776; x=1795106176; bh=VsrDUILDAUM4m1cPuEoMghsIta77LgsjOqu
 SSmXtd6w=; b=RLy1VsbozcRuumI0IYCnW0jOEeS9YLZ88flwO1ooOi12hn/zeI5
 FPInAjBeUezY0LZFZZNlVRtREQMMcO/dWXZt0G/NPjl4kwiA24jJnTL5mA6OoyuK
 bo9Q1wX37kSCUNx3Ib9sY2KPQJqRhZl+4sRFWsjjpcu9ri8n7Jnm0h4sIFUxuBC/
 tZeoCYkGql6qGiEWAhdIGQSeAZNN6+WsErFq+32DcXJzdCqU7ajkj8v8R2z+4BXV
 1LB3mEHwO4JLZz0q6TxAWjX9+TJj4cy75UbOVSTFHF7kJ1/1HuVfVFo3aRwWn2F1
 U85tzz25S/ncNe7JTraVjzZqvnYvbb/Q8JA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795019776; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:HrLGIdw4FdtelkX8i8E/SdmOJNDJyd7ae/xFwWeLormrLcV
 xdK8alxNzgb7joNvweiPn0RiTNCfbC5SIpndG9meWgcNByU8eCXOVOothIKX7oa5
 bMnD7mUIe4SKQYFt9Sywgml5LObSoXpaEEcJDjoCP6PkTJjcQjbX1xxpXYC0sy6C
 ZanUSUGrWmlSbb0LImpbZYJQDeCMZcUcMStfj/C7nbL+8477QbFfIDWboJMLn89l
 tfxt9M8o8pjOEmxeC5B5a+QedbAQeHFHuk0jP8t9cAmgS2dC3kdFXrMH1bifw1cy
 aKT8uwELPjvpYiFfTqGfmz0DsZER/2DATGyI+wQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-disposition,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:ExnIdU8JicYZ6y4qenSEyx7f0t3kjqhPFDyYm/NRriw=:4/llhpyMzHXX1h/tL76JHhjBfgelhKC1fUHP3yKO7XE=;
X-ME-Sender: <xms:_9P9ajd3wqP3vtP84wgWR1cKmwi-CJJlQ5-8BHkXkHr4l4lEjY4TIQ>
 <xme:_9P9aiKGmA2zHZEW7DnGseLocuTdy3zyjr8ySFm_GcOXlXk9e0ueEBIfcsiQM9g-x
 8wWPLv7BfGKA0PI-eKexPmhBeIGQxJinf07QtyTGLh9sicdXW1biFXS>
X-ME-Received: <xmr:_9P9aoHwBEwPxevKbDKXQ2G-nmZNc6Hysu4EOFNqFL2fxp8E5-UmHnU5zcZMnaAuTuo4XK9dbK0n5UcoWjQ27vRUJTphanE>
X-ME-Proxy-Cause: dmFkZTG3I3sR8n7UyuUGRxcSCcNz/sE2vl3lwBxWt4/PsIJWnW1ElvkUR0oUQ0OuacDztA
 GYUQBta8B9nWhabwsw5zkbl3QvN3El89xyQMO/EEex/Y+kDnHJgfBv+UU4KTg2zG6/RwPt
 WHxdB4pB/bOLfbfMre2XpKlgBPy3zFXGqZqGjJD4SGO89zybA0qmN2znDs1GL08DzI0Fs9
 vWd1xhvTq0IeRyVH1YxgK6y0iG9p0ItatHophew1NBFxRjoQqlUJk6p3a/eeLdj4gOkM2g
 8eIWynQcauhTzS4JYHCXUGJ3fGw56SAKKuECkw89Hiho7zH3QnUq3X2gQiCVuuaVEUsLDr
 vw1SDap8nTITpdTWQBxd8g9gMxfvQBKyq7XG2XOxq4ztlhIELiAxODR8g3CrfTNxJmlS58
 thmCay4O5dghoq/aIrF9MWTgRoXsIpMklIkq7fabXucPC3DMxkuqrVPQbkzt4ORxfE0NZj
 AtDQmyBMNgJ7xqnTiy9NAsPPQtmUt6nz8x3nDKXbjiaEXu685reaZxE4Tl/VkhVTjA4pUy
 7ps3d8iqI7nO0W/MnZ+Eo7jKSaqJ+elnLcBJnpiNAlWZtGg4M7nITPtY1nenpl1ZE3WjED
 5TF5n/vTM6bjb6Fo8tzexjLbtolbSvcEDVMMXbtYHW/C+t08EklvzlLJDumQ
X-ME-Proxy: <xmx:_9P9alCOi1q-T9Z7kdOeV0efwDJrJdrFv_YJFdKCWNp4VxrJRZ7Z9A>
 <xmx:_9P9ar_SyslZZC6raBoJBP8JJ6fseJHgnjsWd3v-hZhaDJ60YODClA>
 <xmx:_9P9ahDFtPLURDSB7pGpx4jVOTtNscZZLKDdM_1yZLgB6WsWEo3lSw>
 <xmx:_9P9agQXOrHQ0Kx1HtTd26YL0hhOasBsp7DlLL4R1r7kh6q64-7i4g>
 <xmx:ANT9aha_d4tGr_p5sAwqd6zc6BUm6TNj3vDsSexOsGS04vPsCo7xyEUg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 11:36:15 -0500 (EST)
Date: Wed, 18 Nov 2026 17:36:13 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Jesper Devantier <foss@defmacro.it>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Jesper Wendel Devantier <j.devantier@samsung.com>
Subject: Re: [PATCH 5/7] hw/nvme: get feature FDP (1Dh) fixes
Message-ID: <av3T-nIrgsD_kXY6@AALNPWKJENSEN.aal.scsc.local>
References: <20261118-jwd-181126-fdp-fixes-v1-0-ed76fad7861d@samsung.com>
 <20261118-jwd-181126-fdp-fixes-v1-5-ed76fad7861d@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HOoinY1SBJRuJXig"
Content-Disposition: inline
In-Reply-To: <20261118-jwd-181126-fdp-fixes-v1-5-ed76fad7861d@samsung.com>
Received-SPF: pass client-ip=202.12.124.155; envelope-from=its@irrelevant.dk;
 helo=fhigh-b4-smtp.messagingengine.com
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

--HOoinY1SBJRuJXig
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 18 16:01, Jesper Devantier wrote:
> From: Jesper Wendel Devantier <j.devantier@samsung.com>
>=20
> - endurance group is 16 bits, mask appropriately
> - support reporting current/default values correctly
> - use fdp enabled helper
>=20
> Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>
> ---
>  hw/nvme/ctrl.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 8fc0884fcda..d82ff6793ff 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -6342,16 +6342,17 @@ static uint16_t nvme_get_feature_timestamp(NvmeCt=
rl *n, NvmeRequest *req)
>      return nvme_c2h(n, (uint8_t *)&timestamp, sizeof(timestamp), req);
>  }
> =20
> -static int nvme_get_feature_fdp(NvmeCtrl *n, uint32_t endgrpid,
> +static int nvme_get_feature_fdp(NvmeCtrl *n, uint16_t endgrpid,
> +                                bool current,
>                                  uint32_t *result)

Minor nit. Since we are changing the function signature here, we should
change that int return value to uint16_t.

--HOoinY1SBJRuJXig
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmr90/oACgkQTeGvMW1P
DenBbQf+PYLY3MN/LlKFkYClukMnJiXUAai2v3T6seamfT6nmwscd/TTnnmz7fQi
kl3ieFauNhdPIMzRIDBFG8H+I21Rjno5FRtrP/7GQMUtYaSYLmEF0yovQk+qFx7l
nLSHpBL3YMrgb+mVYbPGJfYCz3jK5T+eouPB6+gOLuOFX0u5Kg1fvyX6hG2071/a
kZz8X06o0f+SnrLIO7WiWz4MhmqoV9I8YNnExsbUqV/ovYjKAm5jfdRQW+tBzweQ
d/Mbae/0ybH6v3nA4fsU7bgApUMv5UbmLImhV8ouSFO85UB/ZMZTCrkuSoFa6iT2
jyEqsB+rOHzdudK496I8uTmQ82zTjw==
=DXLT
-----END PGP SIGNATURE-----

--HOoinY1SBJRuJXig--

