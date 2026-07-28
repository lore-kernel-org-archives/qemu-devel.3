Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB406C531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wokWe-0007qb-FK; Tue, 28 Jul 2026 12:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wokWc-0007kg-MV; Tue, 28 Jul 2026 12:19:26 -0400
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wokWa-0001kd-GA; Tue, 28 Jul 2026 12:19:26 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id B19ACEC0387;
 Tue, 28 Jul 2026 12:19:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 28 Jul 2026 12:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1785255562; x=
 1785341962; bh=iI2lOoxlTFaZosu2XQziaVDKsmV7HEO8B4kvXMSadss=; b=a
 nsoPAkZSfepEMmuNgcHbXOESVc+pYGFxp5PAOw7XC8T51DuIuhUArSxzoZlIwc3F
 LLVnNsdrRWM8Sbq+Le9RSp8myeR3qDFn9oC+QFEWrtaVDtqvpb4COWKByPRfIEJh
 zuBBp30dlWIyw5Mokd5c5pBqz6sMX5mESTRBQjcD6bKxtPsmBCF4bWhnf2TVzret
 y4MOiZi82xTxUOZfDjoIvy6Un89+Kwu1TtdqzXAtS9+k9H6dV4kVct/L3iwDsvMk
 a9odDO+mtH0jvuNKVeH3rL1I3jHUjPF123fM5pjBZ7y4qnQDIdGiop8SBrEVGs2f
 nLzy/iB1nA5DmlF+jTy0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1785255562; x=1785341962; bh=iI2lOoxlTFaZosu2XQziaVDKsmV7HEO8B4k
 vXMSadss=; b=L7PV5GcneYa4a9j+2UWsg0dJLZrX8hy6lgMotBW6dfIx7Hpe8VB
 rDhkzKfru+Ybqaj27Gkra5MHnoSS1pcgWTj1ZZbDhw59pbTNfFxDk6OM4nvE+UMa
 cCGLy7clvcVTNfzOpLBDDf6MZvLDc0ENcFmWlQI1o1OUSkl9v2kjJreLlO9dmQmU
 duwafxa2akkvktPcTUTZrxPh5WCJIFsovxKxuaHc89ROXLqzboBZAMRv4XuIz8qu
 HnwgySpCpOjQqeWVJokmRY7NDz+s7d8U/tQp0i2Vir0c/XX1FrTftT7nZF1yEWih
 84BZqS19fMd47LDqlUGljD8qUKoFPlNlHdQ==
X-ME-Sender: <xms:idZoajSpUr2Px7PpGOVWENOhHi5AIeb0Swaq0-wkGCmIHUB8fj839g>
 <xme:idZoanWj2iY5LNQyor2A1EQXGzCrYrwpIFFgBGdYkpHBU2hWVsMqixoKCAQQr5lVh
 Ij4wnSt2-OZ8dJoAn2smXF2pIeVrNSy8XwLyzMNElaD7GT9FZ0-SIg>
X-ME-Received: <xmr:idZoaseL7Kbzch3H9NBjsgiKyDEkkM53CSuOHCStfRt1Ie9K7P2jhCnoSpj3yxkL4nr6I4wqVSMaw4hj-BrBXiLExW2fMJs>
X-ME-Proxy-Cause: dmFkZTEtcQaa0JWIoN8qNXKf0FPQK54ujQ5B/M0yw+Gnmy9N96Dq49rWEP4TC8Ek1FH4ld
 ayFbHTpuUx2UVR5LjMA79/KRi3zfwj/m9GEkCxhaJlwflbyA4bMiDgWLBDaj5CCD/guMqq
 uOAD7U+KeZFJg8k4392H6qWQd6xExi9JROESt332PvtyCrAK5npWdmUncSFxDOioUAiFR3
 WFLuLYPHPCfqfxqq5hivGmh1QrMATOh1AIrk16gT7UNTFkAuij50nmjuFjy5mtKjaEAB+v
 5m3ky7qtBQjf7rEgsj5BJLbe54qXP9Y4reDv2qWYcKJzieOxTOdYV58J2XTQlFwh3yZPGO
 MdNKen+dd7d5F6rwUKROA5iSfbyzkhQxU6gmYo+83ArWWbhzPA0r58soTZJtkqFP89xtQL
 5adK6UWcd66Cb4TJOtilsdgsB2xHDLbHccSnaZLSADS7tgf3H/zVrJ/GQ4qSKT87Hw2rGx
 eJBS2O2Ow3YUwTnJxOpkC/+FeuN4+FT50pQL1odwXsm8dFIwUomFoiW8Kg1TUiYYvnADuk
 cJ90w7F1Bg653IW+C1jjowSTZmI/i7KvYI0vCGo5g8utiQWQRocTiPN5OJqx5m7ORsscem
 dhr6m2EaCzADkhHBtYKxrFoKJp5FBnMsEhZuWaraUTI7ebV7eBcC1Yy2X6PA
X-ME-Proxy: <xmx:idZoajIDTRNbCzGm_Bb4SMUuBCI98dgeNRiXr-QIvnxlX1nwtZsZlg>
 <xmx:idZoahx4QTggT9wgO622TBEMxlsw0uzLuYt_R1PG-XhRiZD2s6FmuQ>
 <xmx:idZoahsCO9l8QwEE8pZGX0xYsZd2rFuktfdrEnuwZcog8fe-4f8-NQ>
 <xmx:idZoasAj76UCb899FeSUIG7k5p5rlkb6K1QeeZnwGSGhEqwFZHpfvA>
 <xmx:itZoarQZE5t14hKRQAIaZXeucHMtHQCaJ1mXTeopd00KUvQwVKVgoQO5>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 12:19:20 -0400 (EDT)
Date: Tue, 28 Jul 2026 18:19:18 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] hw/nvme: fix unintentional integer overflow in shift
Message-ID: <amjWhJLsmk85RrOZ@AALNPWKJENSEN.aal.scsc.local>
References: <20260728-fix-shift-v2-1-6c2355edcfbc@samsung.com>
 <ef1474c7-8461-4c31-aa56-7f79ee9ab280@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OjoMGAxBjjcenz9a"
Content-Disposition: inline
In-Reply-To: <ef1474c7-8461-4c31-aa56-7f79ee9ab280@oss.qualcomm.com>
Received-SPF: pass client-ip=103.168.172.151; envelope-from=its@irrelevant.dk;
 helo=fout-a8-smtp.messagingengine.com
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

--OjoMGAxBjjcenz9a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 28 18:15, Philippe Mathieu-Daud=C3=A9 wrote:
> On 28/7/26 11:42, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > Fix potentially overflowing shift operation.
> >=20
> > Cc: qemu-stable@nongnu.org
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> > Resolves: Coverity CID 1663674
> > Fixes: ec917cd49918 ("hw/nvme: fix FDP set FDP events")
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> > Changes in v2:
> > - use deposit64
> > - Link to v1: https://lore.kernel.org/qemu-devel/20260728-fix-shift-v1-=
1-bdb98c205233@samsung.com
> > ---
> >   hw/nvme/ctrl.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> Please include "qemu/bitops.h" when applying (it is indirectly
> included but we rather explicit includes otherwise refactoring
> unrelated headers might break here), otherwise:
>=20

Gotcha.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
>=20

--OjoMGAxBjjcenz9a
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmpo1oQACgkQTeGvMW1P
DemilggAgpxDlIMEof7nunn3L+AAdqb/3LBO8EL9Pzo0yNF7fO8NOnKpsB2BSTDM
MY41aAhtDRQl0Ra6hRA5qrml+3cfA+crYA+Bazhr1XWnV24P43xbKKJmFc4898sF
IDovtDGii8w6WUFzaJ+Hm8pfHF/qPsPCcQW6GiHpEsjKEDZ7VXT65wAw7oJhCF50
f8Wp9r6JSL9xMHD9LYvkWxRxI2tpSXEswwrWFWxDgjVcWV2mIwOVSFdFQgFkKyXR
4bR+nfAz1McFEIJHEEhr0kCFaNUw55X9f2YWgOZBEpBWdz/rKLJeKwTXlYlKKyiI
PuNZRmtE+vBTnEHbu6KxXYJAfLNqdg==
=yUZL
-----END PGP SIGNATURE-----

--OjoMGAxBjjcenz9a--

