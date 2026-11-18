Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E2E606A325
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=eIA8taHk;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dpRZC1f5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTncP-0000A7-S7; Wed, 18 Nov 2026 16:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xTncO-00007w-5f
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 16:55:04 -0500
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xTncM-0005Bw-Of
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 16:55:03 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 0978E1D002A7
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 16:55:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 18 Nov 2026 16:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1795038901; x=
 1795125301; bh=OZVKwgDih5pCMfgxcdKtsmx9hIOn7Or+UQdR/9E2hA8=; b=e
 IA8taHkhHMmFDvPRZ3NEvm+amdJXcEknd2+/C0Td1qPJ/3vdIrhvOtvgu7vKyITL
 SM9axauRZXXhNj1qQaGMxVTdld/MTtghr7TyMsTaYxEI/h5Bm+eMcgV22TOK9SwT
 r8q6srE4Q+yVsKyL/gpP/oWDdGvCNdzq0qgTR0BUTCtjQdZqEnxbiCnAo4vGZ/I7
 zw60eJR0pQxggz1PtBzS/sJTKGtSwYVo+IWdFaDOZTeqyGO6NM7nxgby0CVklimP
 9EmutjPEcFrdhybFthcVsUk3eDcD5Rx4A5d5PTZZjyGkAFDlBcQaQd7t3B81MdtT
 w4jnJBV+TSczBwkdBoMBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1795038901; x=1795125301; bh=OZVKwgDih5pCMfgxcdKtsmx9hIOn7Or+UQd
 R/9E2hA8=; b=dpRZC1f5mUFygc2h3TbPoNWdIIYPwXinzOGr0zxNfc5EonfpCqu
 RY+ZkyMV2DMgK8ScYRjCX+Xr5HhahSMerUDwvBM8jfXwNtuAuPFcWmeIYRChV38b
 +O08xIt/j661eni4FySqOUgtu/uZKPIhUQZmvmK2NMMW5CDOOJ4AM7D1V1NA4VyG
 T6aB3TTWZ1/p3eYKMDSTAF4o3uAPOEO7rGYujNPQ/pi/CP0eOaXeoJjy88GUBAnh
 LU7DHjNcrMRGulfM5NDscVurk8B/WyZDkZcV2vkmMRdCv70Zv7NNrK+wlqCFgt8k
 1GuXdknhW8zqlJ0XPgyoK2Pal0ThNRanE3A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795038901; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:dFlXSgWFk+4gss0m9SEiy1rerVUeWLzrKCFfWbGB0vl2vke
 PbfVnw26r/6fOGzpAl10QkXxBc4Uq9dN/nQDzlVSvO6md9gvSJ6zRHRALwn8cCXI
 ymSotZGnUh79qP4cQh4P2FTcbcq0qpcUOAA2WffSc2yzEMyeFaxlcJ7IV73fGmul
 qePEiqRA2smgLJieXaqSHdROgZ5i+vDRDBn95XPxr2qxNyjQxaUo6pMzhw86omcD
 KPgCsY/b5UkFqUSF5OuOMpRl2b2nzl+HJa5dGJrNap0YnXn0T3l1FakcKxOnJm3S
 pk2duw1KPvRrpvOGiWUi5F7k/U6kgQS6DAZWmFQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-disposition,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:rP+T+OyO44EocBebVhNck8g0KSV6FNGPdnxEwBvt67k=:Q17ENZ/FEDdkdcPM2BpC0wQ9VDzrd0Nhd5Wjtg+mLoY=;
X-ME-Sender: <xms:tR7-alaXJkmqJhkudM6FaRcrpX_qsUfW0TNCGwgTjQAZiIAjPXEevQ>
 <xme:tR7-alUNquwUKRn1AtQMW76r1PBTCwzZ3tEiOhoh8aH505FP9cFu5ww8oBOMReFpI
 lMLQnT6Kc83vRojc6wmiBUUcpDxwjaA_X7scxpXeGORzABtHeLU9ZEfnA>
X-ME-Received: <xmr:tR7-ajhT9-I_4rHHEK8TJqsKRpDc1EjUdxrZHZCvjuZFBIT6bi3ftGBcOA6gnk3z9TxFB03iscrdmaBVXGPRaKRKBf3n9Po>
X-ME-Proxy-Cause: dmFkZTEOtVvZBWf6QgcdOvWbiK/vN4zfPr7Ixxz2wrIUlxezwStn18+xqjHiZ93TDFqUBe
 Hh9zZpiRCJ2SIgGG2zInwvW51dezx4zGSf/RovpZeOlF13R6Id31r4mCjCD7rEvdVyaAu4
 n64To3fIKFx7D9VMKB+8BOuoIIJfRrFs+g3rwHL24k7yCSz9rmPffhmDXhK9PZAzVBNTh8
 LCN+YWVLsVWMP+S/CC6yb82CKVYXqj1l3SfYhFhuf9+W/NGI6w+DxE4uqGIkEY9+wSZhqJ
 e2mPwywrvbOIO2PXSjwZguQMBwk5lNfogNI8DRlvubFvbRWxOIk2zXcFfPyU1ep2+uFZbq
 O66iT5+7XpGeb1jDduUaG1/bGWDdnAqlk6kXAEvMTtkdvcltLMnoa3MdY92Dw4DuPfdLox
 +Zm3UyKEaDu1F/IjOc5UqNdce6APAZbqGhndR2hI64cQhTYiipxJU16ZOxCLAJpyeA1VRh
 4vozX27ynB4cPKB4wC6fkDzv2ZoEnZwf4sXXx6b+ZSS7hI02PNozlXyzoHZrz6G/VABFRP
 AaRn+eDWaYUoTtKOZ12fC/Q3ErvN/hcvAwSpiDOhALDpPN2aY4cidaLovWl3YCr3BtKKH6
 B7v4iu5d0a8mhbXzEvSFHU1NoJ0SY337HcwJ7Y3FYS9bYkfFL/698IqY7TRA
X-ME-Proxy: <xmx:tR7-ajsAJBeNGtB1IZjjFfYmVZ_WX-0sckLDxW_morUACU-KGUhd3A>
 <xmx:tR7-as51sNuh6_68irqss0-LcDAo-hGalLJoC-DNmxcwRuoTe8uMLQ>
 <xmx:tR7-anOszjUM_cvq7QUOlrOYUOpL1DzTsuNgSay7hRJDNwJPUQSn_w>
 <xmx:tR7-aiuOaLJhHfQlH-1QUd0PcjTjGdwQr4hZe4RMbT5bRVcJNhafPw>
 <xmx:tR7-aj-0-JeacNYGQEVYRWsrrspvYS0U1rqS0ka-DDcQaiFC2-2NvJ16>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 16:55:00 -0500 (EST)
Date: Wed, 18 Nov 2026 22:54:59 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Jesper Devantier <foss@defmacro.it>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Jesper Wendel Devantier <j.devantier@samsung.com>
Subject: Re: [PATCH 3/7] hw/nvme: fdp enabled helper
Message-ID: <av4es2QofrBq4D0W@AALNPWKJENSEN.aal.scsc.local>
References: <20261118-jwd-181126-fdp-fixes-v1-0-ed76fad7861d@samsung.com>
 <20261118-jwd-181126-fdp-fixes-v1-3-ed76fad7861d@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8vduRwGqOLIlCFsb"
Content-Disposition: inline
In-Reply-To: <20261118-jwd-181126-fdp-fixes-v1-3-ed76fad7861d@samsung.com>
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

--8vduRwGqOLIlCFsb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 18 16:01, Jesper Devantier wrote:
> From: Jesper Wendel Devantier <j.devantier@samsung.com>
>=20
> Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  hw/nvme/ctrl.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index c8da01f11d0..5d4122309ea 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -385,6 +385,11 @@ static inline bool nvme_parse_pid(NvmeNamespace *ns,=
 uint16_t pid,
>      return nvme_ph_valid(ns, *ph) && nvme_rg_valid(ns->endgrp, *rg);
>  }
> =20
> +static inline bool nvme_fdp_enabled(NvmeCtrl *n)
> +{
> +    return n->subsys && n->subsys->endgrp.fdp.enabled;
> +}
> +
>  static void nvme_assign_zone_state(NvmeNamespace *ns, NvmeZone *zone,
>                                     NvmeZoneState state)
>  {
>=20
> --=20
> 2.51.2
>=20
>=20

--8vduRwGqOLIlCFsb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmr+HrMACgkQTeGvMW1P
DekIwAf+KiYnnXU317YBPOPnywJVgv6Pn8+rqDFMI9xRDY75Yl5pxDyd0G7VrrQ+
XPx3l77FxmyKwNjX2CVD/TwgH/WcradQYV+vzBs4jJXSgiNuJCadlQa80UPcTnZV
9peA6bgSaC3w1Mh0n/kyNCynsYTCfKjj3oN/FBkxXPlacgr4ALHGkU3EUmiz2iuX
a2Xf/p1mAEQWuEFBwsCI9GOg3kOrTsd/HlIu7giiqo7I6lTKigeEMeDFm+Dxumdl
FTRAGmWs1GsVR4MXv2MNPJsLKeHpNL7stjzINKokjSdcUtmo6yF0YJW+HxhlZAck
9xSTW6FBwqbL3ZXEuXC3rebSh2po1A==
=o+Pn
-----END PGP SIGNATURE-----

--8vduRwGqOLIlCFsb--

