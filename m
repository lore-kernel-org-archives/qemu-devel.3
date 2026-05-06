Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44594CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKdT1-0003Md-Ci; Wed, 06 May 2026 10:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wKdSz-0003MH-FC; Wed, 06 May 2026 10:43:13 -0400
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wKdSx-0001ny-8N; Wed, 06 May 2026 10:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1778078584; x=1778683384; i=lukasstraub2@web.de;
 bh=tQMZ6ae7SGss5HQt78pwCY5Yv9yf8ZkIZPuYDJJKPzw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=pDeSWFbfgPzqL5DIsLJye0c5pxYMDaV2gn/qf/wIixAsBCZSHmnnHuo2t3EjHfKa
 l3zC0+fQJEmTHfwiOqPRXuU1mMyH8W8sGaGr9s768HgvLHN7W5nxGD0NGiIb/wTEX
 CRl2jkMhdi4eHqBg8LdUvsQ1N1Sv/MzJaNrk6lmnUSw/QEZzGaKKYxeIYspjYj/yR
 9YmMlgJBTLeLkQtLrlO1YN0HfTuijLycrCVM4wVAn46AdeQGSB+HZkCgxNz6vuSny
 9dCDIbHAYVLt1uOXi1M4HV9m9bQWKNVQLwb6ktK5ajqBx9UmfqYwNPnrEnrBfLnjN
 rqLHkU5EN7TeRfxqew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mae3c-1vipfe2hKM-00oYob; Wed, 06
 May 2026 16:43:04 +0200
Date: Wed, 6 May 2026 16:42:52 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Peter Xu
 <peterx@redhat.com>, Zhang Chen <zhangckid@gmail.com>
Subject: Re: [PATCH 0/2] MAINTAINERS: Add myself as maintainer for replication
Message-ID: <20260506164252.464bd83a@penguin>
In-Reply-To: <20260425-replication_maintainer-v1-0-f6ab019ff0ca@web.de>
References: <20260425-replication_maintainer-v1-0-f6ab019ff0ca@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XlhaN6a4AueaRh4xaMnjB5v";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:yZNQODn5uVxxODw6mgcG/7UqSbtOYqU04yPR//kkSNJ9dWgfXYj
 Y4c+c4KLgn2KKirJGMj7zEsQRX1KvjyTOnRre9xbEQrMJofp5QJANC0yZ6cNuCs5SrDqk0h
 JpcFW+G2y0pltuW2UEVp7ZSUQzde9DO7xc28km5r+gqcqJ7otGZxp7GsVTVdt5C3fnx59a5
 saJqmznprD/c1BWNgkSzQ==
UI-OutboundReport: notjunk:1;M01:P0:o1fikgrZm0I=;L6zsJir3VuPMwIgBv8wCqASjyYX
 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
 4jCOGa4k86aXm6g+Gqon5aMRYcQ=
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--Sig_/XlhaN6a4AueaRh4xaMnjB5v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 25 Apr 2026 16:08:21 +0200
Lukas Straub <lukasstraub2@web.de> wrote:

> I recently took up maintainership for the orphaned COLO migraion componen=
t.
> Here I take over maintainership for replication which is another important
> component for COLO.
>=20
> To: qemu-devel@nongnu.org
> Cc: qemu-block@nongnu.org
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Hanna Reitz <hreitz@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Zhang Chen <zhangckid@gmail.com>
>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
> Lukas Straub (2):
>       MAINTAINERS: Add myself as maintainer for replication
>       MAINTAINERS: Rename Replication -> COLO block replication
>=20
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> ---
> base-commit: 4bde339ecb41b16e90810233ba5ee2fa87bd443f
> change-id: 20260425-replication_maintainer-c5f63ac49ae6
>=20
> Best regards,

Ping.

--Sig_/XlhaN6a4AueaRh4xaMnjB5v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmn7U2wACgkQNasLKJxd
slhG6A/+JS2DeFEUgxLa1nGY3w4Ea5s0sPcD5dPdyimGLk0yCGO8iJf2JyFC36qF
Ne/JOYWqOK0Q6Iabr9kYcDI/lT83ojCtnk/M1QisvlA62ylDsBpFLlw54Ugno397
VSqZHMJyaX7HNNj+14n7NzHeyZVgUoKlNGHZvd0Rp5eX1URCFgVQMhXhIRBsWio9
nnWmRVXPAS+I7j4pJEe9xPU99VIof/2ubZjy5ui5ugFd7cPOkOyTWH58saUDCLKN
fx0iIEGgCNWppsOBG37OfUPBDHNuK6LYRXnjjP4Fnh3N+Lk1ptXaMVwLAP0pp076
8TV2QViycpYXs4eTrc/WBFiL23XmCSHvh90RRGzlrjQGf9vl5+E/HdLCHB2zD0n6
QvW7X7XNhq4YsQR3PaHxWreSSyBZ/tVMRMXSkMjHs/ccmf1k0TtzrpXfDdbMFWe+
iMvUFC1rAJfXWxWTQ7tI9bKmDOvKmdhZDo5P3rORMvxn5BE6FNNW0UJNeE+3VCTW
uck2jOlX+ViQwiGuoWnu/bfvpq7F+mDayrvTXPd6/XUvPIzxvCr/y4f5UD/b9EUs
1TjeiA/8e1HJgtcYOK9RXTxJTXoPl/JcS9s3z+dtletTOZD7qQuL1JSJBhG2o7TF
NeKLm2Mjcymai4MDgJIIu9C3CLUBMC4tkEHXkbh+5v92fdDCo3s=
=GmQv
-----END PGP SIGNATURE-----

--Sig_/XlhaN6a4AueaRh4xaMnjB5v--

