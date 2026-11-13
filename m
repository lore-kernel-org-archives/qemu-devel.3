Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ADE606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=nB5CQips;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mA72r2CW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmUP-0006LY-JR; Fri, 13 Nov 2026 03:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xRmTb-000644-IS
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:17:40 -0500
Received: from flow-a7-smtp.messagingengine.com ([103.168.172.142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xRmTZ-0005WV-9p
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:17:39 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailflow.phl.internal (Postfix) with ESMTP id D89551381FBF
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 03:17:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 13 Nov 2026 03:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1794557855; x=
 1794565055; bh=rsoDpmVmKN4ffTYcAuN+/gT4iXEsMGgnDb3T6gu0X3E=; b=n
 B5CQipsXnOf0lYTVPnzcnn5fHqACho5YE7wj5l+zQ5jD5Px0i8KSi8pdSDiGAfM2
 4lPcdSvhcVKN8pLm6Sx2527zSbN/P7Pgwz1NyKE4BrjK/XPJtw49n/ytAK3tJn5b
 P2Wh8JJ88L4dpxDthkJio2043HQQdR5Lro6SvHKtRzcDzt+Og3c45dhQJDzIN/99
 I7BGh0/WoE3SgWbdrUolhMxTJsIdz7u4SM6diPPxEpkOx5CqtdQ1mmDk8RuSufsl
 JX3uEe6Ec5MaIKwt4bcGleRV3zsXic1jVPxfWFjubD/jVca5dDuCnwlg933pWkAt
 uK3K/8JHURuz31e6zNOgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1794557855; x=1794565055; bh=rsoDpmVmKN4ffTYcAuN+/gT4iXEsMGgnDb3
 T6gu0X3E=; b=mA72r2CWILxExJLgkkdOqR2deupgT+jGvo5fGRlPf4JRTsxfa/g
 tE8T+aXwHMHfQ2UGvVlLwUDnWyWqxgVfsJLzNzJ7tdEbG7kF75u3FWY3Y313nMkT
 THDRAZbngXchmqQf96ny7b25WuonN6N5neEwLrNItgk4/6TaNtrXbkWrtmmRqfc0
 eqZqRkKNUebJn1ecf85Vh5JYNFl15ONcrXWSHklyIJmI9wolnZbLSFhQ2EY7w13n
 THmbvLktqKgLq5sXNg4gt5T8b2e0N/qtRlKN4DbztvrimsQutgLVczLjP+MMtz9i
 /uUVO+rheP8KSYKtyRvte1G9lj2AMfVWonw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794557855; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:PGoC0NxDNvVMcFQkHpT22kbAB0QL3B1vGe9GsIT+WwZ5mFY
 T+EGGEgX9rWlSccdbdW4HXSd+DI6PVzmqKc11XuruWs0WpslAFQ1azZv9SnJW2Xi
 SSJumfIr1UsDOOEiwtjBDovqx6MDhZiT+XM1OpxEMTHhyiaBGOP1o+D1zKuBpWBu
 Vg+9Frm3pG5RulPFj1PyfILCKpdoBtVbZRgsZBCHIxKsuY9tAXGNLd7WCDw3o51v
 GpQJBDSeMQxjTflBJnPWEdZnO2qvB2iue7m2UGSWOn7sceMVh/OLKn5E30fL1VQT
 Byh/pmkEbK5e2bmRUXFEf+jJUOA4tBQnueJH1oQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-disposition,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:YwUgcubXFj1IPHJp07vdA1eGEAkofWrfzjlKAQRpGT0=:dqw29q+PWckY5nvcgOCFyS9zZxvSeDn1pTuKpJRVzxQ=;
X-ME-Sender: <xms:n8f2aruvFLDIOVlMF-b85QouWj6H9pzLgNiMEfGK4TW_d-K8rv_YpA>
 <xme:n8f2alYuEb3Sl8Bs1R3RlILKJYj6-GvIhujUiGlXFGFlSIhWWu3vmDou-UipbsNus
 tEyjeiZRolo8pZwKs2xnVInmxHXEnyr-ipF8Rq3_Tt1VmSRyQ_GUSY>
X-ME-Received: <xmr:n8f2aqVGc5E_tVKH4mxCmQYwiPTkjBE9jvnZccwB2VwPlPeRr0ZraIZITXCGLg>
X-ME-Proxy-Cause: dmFkZTFnt7S4g2USOOkxspyUX07qTRO3l9NeTsuD8EF8aa0m97L7Jzfje7JLR+aiWLKYgC
 XFMLk8QW+LiD9rhDBFhtlQys8FGOQChEaS/5YGuqtmMZvAL7PUd3aliDpBSuxAhnOkABdH
 ngHHdUGGr01qkbiJrVGAtumeKfq94/7d/T5Q0KW/2SOUdYD3yHBjDZyw4U3RUWmlrblN9y
 EdYym8meSWVEB9evRYTCtMN0fYYKoVMG5xmEUvoSG4L0pzV6FKbd8kpXs9C2zureHbZa+t
 N+Ib7Z3MuInQFhnfNjiENaZBGcPb/nbUHUqMB7lJ2HePsTBDN9cUnpv6an0ID97uAaeHKu
 v8FO1f4mhfPXo36yCEwfZMdcgCh1hLwELa+3C9JCxGl43d6hMWHFnNhYSQgk6i4iVWd2fQ
 t1+eIGScf4TpqCsuBchnQmhhyzXJ0WDIPbsWrezd77ePn91Rqwbr3KF8FbEiM90Mw9CMFy
 QVUPipkktwF/vRfTwIR3Z1etqmdTyVCYg82WcK13thm/RpC5b3Z+4DZ/6uhzPzM6lb95IO
 DyBOOZBlJwKQQu+D57UZETUnH2ksHRIJmEw1aq9TwUwTiIgX6pJNTa7+uC1SGn6rNw8f8U
 3nC9MM6+fD/csD6z5m03hhYcSfBmu6CmYryfoMFQjxM9Fnv7cXBk4d0GNZoQ
X-ME-Proxy: <xmx:n8f2aqSTGq1qMQ0mJYFqdXaH8wH0P86EGWxpN1ChnhrWJ_SiDiFVaA>
 <xmx:n8f2aoOP6TBpdV5pIKL2o3Q6gLAw9XrILw1fZqP9nd-VaM8i5zzePg>
 <xmx:n8f2aoQ8E3VbdwBfkxp12moWA3u06hgIMbIHzsbRiWG_Yw9fkeGFpg>
 <xmx:n8f2amgrtclJ9T9zp4HfXdXPE8Hv7Ho0R2sEkkYwsfFjbnj0rPonlQ>
 <xmx:n8f2akfdZQGnpfPcLlb226B4w0Nl1BFIco70ypowTgJy7-YUD3LpRzmZ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 03:17:34 -0500 (EST)
Date: Fri, 13 Nov 2026 09:17:33 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Jesper Wendel Devantier <foss@defmacro.it>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH 2/3] hw/nvme: fix fdp reclaim unit accounting
Message-ID: <avbHm_D-VODuxSj_@AALNPWKJENSEN.aal.scsc.local>
References: <20261112-nvme-for-rc-v1-0-69b3e5dcd5c8@samsung.com>
 <20261112-nvme-for-rc-v1-2-69b3e5dcd5c8@samsung.com>
 <20261112165350.0-foss@defmacro.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wOoO/iR8yTo6JqBj"
Content-Disposition: inline
In-Reply-To: <20261112165350.0-foss@defmacro.it>
Received-SPF: pass client-ip=103.168.172.142; envelope-from=its@irrelevant.dk;
 helo=flow-a7-smtp.messagingengine.com
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

--wOoO/iR8yTo6JqBj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 12 17:08, Jesper Wendel Devantier wrote:
>=20
>=20
> On Thu, 12 Nov 2026 10:53:29 +0100, Klaus Jensen <its@irrelevant.dk> wrot=
e:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >
> > nvme_do_write_fdp falls back to placement handle zero for a write that
> > has no Data Placement directive or where the placement identifier is
> > invalid. However, it then passes the invalid placement identifier to
> > nvme_update_ruh which results in no update to RUAMW for placement handle
> > zero.
> >
> > Reset the placement identifier along with the handle in the fallback.
> >
> > Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >  hw/nvme/ctrl.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> > index 685cbc2f340c..a0d22dacedfa 100644
> > --- a/hw/nvme/ctrl.c
> > +++ b/hw/nvme/ctrl.c
> > @@ -3754,6 +3754,7 @@ static void nvme_do_write_fdp(NvmeCtrl *n, NvmeRe=
quest *req, uint64_t slba,
> >          !nvme_parse_pid(ns, pid, &ph, &rg)) {
> >          ph =3D 0;
> >          rg =3D 0;
> > +        pid =3D 0;
> >      }
> > =20
> >      ruhid =3D ns->fdp.phs[ph];
> >
> > --=20
> > 2.53.0
> >
> >
> >
>=20
> Correct.
> Had to re-familiarize myself, but pid (placement identifier) is essential=
ly
> a 2-tuple of (rg, ph)  (reclaim group, placement handle).
>=20
> NVMe Base Specification 2.4, =C2=A78.1.12.1 states that if the data place=
ment directive
> is unset/invalid that the write must then use the placement handle 0, but=
 that
> the reclaim group may be defined by the controller.
>=20
> Setting `pid=3D0` is correct, but only so long as we also set rg to 0.
> Perhaps a clearer way to specify this would be:
>=20
> ```
> pid =3D 0;
> nvme_parse_pid(ns, pid, &ph, &rg);
> ```
>=20
> .. it more clearly captures the relationship between PID and RG/PH.
> But the change is correct.
>=20

I like that, thanks!

> Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
>=20
>=20
>=20

--wOoO/iR8yTo6JqBj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmr2x5sACgkQTeGvMW1P
DemXpAf6AlidQgAlNy3s7a85vxF4JUMqba/VeA7ZfbZ683rRbFuWNm1k1UlapdNe
baIzVbLLcZzAuS9I5qekhSJnN5ekSFk5tV3w2sgSrQMWTlMyi5iVX0VeEvOtqcUt
MaYUxd5fNT4LNjyW4iflr709fq9rNw9/1csCbGQ+LQW5JfF/yKg+6FhORZOdmVSA
7oUwm3SGuqQpo9102pBkrSH9cp05lOflX2QFUn3ptQfCxoc3RxHj6wOoeXnP62mF
KB22KXg4yeJhaBEV6VR7uNO80KfoehX+PEx0owV8S++QXmI2O73dvGItqIDXpKZc
2eQ1HKgaGIoxCgs49DcDw9MJ48JJWw==
=Jiua
-----END PGP SIGNATURE-----

--wOoO/iR8yTo6JqBj--

