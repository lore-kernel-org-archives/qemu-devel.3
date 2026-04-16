Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7686F8D758
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 14:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDOAT-0004iD-8A; Thu, 16 Apr 2026 10:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wDOAR-0004hh-HQ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 10:58:07 -0400
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wDOAP-0007TY-TS
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 10:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1776351483; x=1776956283; i=lukasstraub2@web.de;
 bh=fI9/VNyos2T/pDhgYXRFQrPAzurkDgvjA7WJsA4x7+U=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=IONwy6z7TeIM592Jrp4iaA8OLqz1P8fQ3I/I6OzrAby91RwxoslFyHSvYdLy6OCd
 Hs0U0pVwa6njgPVn8/fDpZsqJrNtX8igp82Bu4RGThstb9v37YoMTUb5Xg140s8oH
 ZvIiiHBjY6hXbBYQPe3zycESUG0MVNhUUsJadFdI9DmrAvH/kRQu6bg934a8iixZb
 cDmRkkZJ2/ojK2X6DIZkF2KnLQwodikqV1G4aq89DlKZnT79Oj69NS5kkEJzXGzfm
 OG/gdMgXjVLvgbP8+LESGrRKHE55Q1Cmu8rVui2e5zCJ/JC4SZac9dEtHkfLuvO+r
 PR2mM2unemfkbaaBHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzTPW-1vQleV3Khk-013JGr; Thu, 16
 Apr 2026 16:58:03 +0200
Date: Thu, 16 Apr 2026 16:58:01 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 28/28] MAINTAINERS: Remove Xie Changlong
Message-ID: <20260416165801.5795ef14@penguin>
In-Reply-To: <20260416091654.316158-29-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
 <20260416091654.316158-29-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jXfrnrNX+ceZwnya13g.nSF";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:JrofK3jj3PGBvjxg71JcoHAQhPAcG0/JPAisOS982hdYvHVr6Po
 /DjSNE6eJLiiZXKqrPRi3FHsc7PsEg+FTplWW26L8YlBueuENKgdTuLCMC9UzUpQ3DVep9y
 HdF6nU3uKiNJxIdv2lWu8IPqS3gaAQvyjB6sJowukn4RxNmYRIbxmogycjrKorLA7xggeWj
 33daE0RHvaexHpwU26ORg==
UI-OutboundReport: notjunk:1;M01:P0:yiBAYvtDSZg=;N6l6/nqpOLIr16ZiX2/w+4fSQD4
 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
 Goc0S8vl+/my536vALghBiyrm6zZOc5D1xNw=
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--Sig_/jXfrnrNX+ceZwnya13g.nSF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Apr 2026 10:16:54 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> Xie Changlong has not posted to qemu-devel in some years and did not
> respond to a query about whether they still wished to be listed in
> our MAINTAINERS file.  Remove them, on the assumption that they are
> no longer active in QEMU.
>=20
> This makes the "Replication" block filter orphan.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1fb56bdac8..a50e5dbaab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4382,8 +4382,7 @@ F: block/export/vduse-blk.c
>  F: block/export/vduse-blk.h
> =20
>  Replication
> -M: Xie Changlong <xiechanglong.d@gmail.com>
> -S: Supported
> +S: Orphan
>  F: replication*
>  F: block/replication.c
>  F: tests/unit/test-replication.c

Reviewed-by: Lukas Straub <lukasstraub2@web.de>

I will take over maintainsership for this component.

--Sig_/jXfrnrNX+ceZwnya13g.nSF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmng+PkACgkQNasLKJxd
slj++A//Q4Vk8vvC5QOcGZTkmLfN/LRPIqEET5mWNNYoHcixo19viOrqSNY/m1wo
EjDyWr8ZJ7CxG/dwEhDtuWLGcYzyzFl/Bfpwfe/B3q37Rw3NJeSslDfhVW/AYRl9
HzFF1/N+hhytYNPMwTMiEGzDiMjNp7D9sfx/DBiofdUl0R6yrkxBgiXLEU5TYX2g
GsjKD2RVD8MIgPFiuXZCaNDEkFtWidWCMxcdPVgObDhpO+K2LnpQ3Uotad96D4hS
09fLFzT9Ob7NnZPPetlgvE54395gdzq/AO4dV4j5VkbRyGvsFtQ8ekdVKVSOuQzn
m8LKFnL7miPMBkCnHj1+irorNhCpX06eJhtqDRW7VNPgmTdcHUOMImsIcVtFndTS
xr1n9h0g/bFUnEpX2o4jVDp2ssFXvjWYa4C4tlpHbFTCasybbo2c863GRtR6Bc7o
jufRc0C1bSqKJbhPY3zhznkg72oEbb4tCuKG2Rk4YWM8AHYDt1EW8H06PyWZnmWV
i4h90WgaeD09V6Lo7qLGvrL1iJPgHxSGzcj6UqVYfQ137nULztxMr7RuqeSovfiM
FRLHPVBmvEtvUki3yfqjcFCHPo7VBqGaNd58oBlgVdoCbdUBzxD6BNSGDM59Cfm1
8fuNwb7HLOeANqNfSpQWjzqYILl7U6fy7mIZ99umEYZrGDau9lc=
=7U+r
-----END PGP SIGNATURE-----

--Sig_/jXfrnrNX+ceZwnya13g.nSF--

