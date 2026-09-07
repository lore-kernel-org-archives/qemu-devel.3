Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC694C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3U1h-0003U9-NK; Mon, 07 Sep 2026 03:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1x3U1g-0003Tt-TB; Mon, 07 Sep 2026 03:44:24 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1x3U1f-0003lI-Bl; Mon, 07 Sep 2026 03:44:24 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 2EFE814001F3;
 Mon,  7 Sep 2026 03:44:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Mon, 07 Sep 2026 03:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1788767062; x=
 1788853462; bh=ebdEyI0jrwRMt9NrUmBBT2qm7KdfH7bIi/sjF4gTWCg=; b=w
 MUsjBxpJoGU+yCy/owiuFGIPJJImltygUGmgK9VYR0bDR6fwM8qHlGW24HU5r6Cu
 YLr+gX2pDZlOJnIfCbXGoDnO+Lt/jnpa3cQu+GqpWIjWNTM5whVg47SqwNOZtEil
 lrDxjUFD/UNsNWkO+RijqTnkgzPD9uCMmaj1/qdLkoJ9HBS+0omIH5vulU0tBTsb
 xjHiT6PwfD1/0qvzmc9vfkuXioAAaOVYlsnSMigEhKXGli6jhoI9zWuVdqOcJjEE
 5p+9N1TiSkEIt0fv/ZkBChI0a1+kYWbG/5UZJLb0VoP/i35AgwyfTlxUqwEP/4r1
 tmcObJbo6BimIT7N2LpDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1788767062; x=1788853462; bh=ebdEyI0jrwRMt9NrUmBBT2qm7KdfH7bIi/s
 jF4gTWCg=; b=G/nCX1FIpaOkjRiUuhb9qYLCEc50tyXCT3822NaaXDdLKl4fIuy
 PJH5225lcH5izmtf2C/9V8jTDbnABXbL0XohjU2f1mLkxR9TBUnejfavNzds7h8H
 me8H7JZ7uWvZYlzmuX1WzRD4Cz71eeQ6HFU9ZmxfgzK1hOpYSTaq67bzr5kv9Nzy
 pp8gAuZfliU29Jdv5Ymm6AVzHZyFyXzqf+cDw8N7sMcHH61E0//x2JNtsgEV2YaU
 QaoiW1EnQNceOb1PGYs4uSzQ6JEoybXOZjeEHQaXmpgQWV9FT5XX7SjP+oQ2DmuF
 u7rI9LI8vetkjVqKK7qVD0nYDoLChaUAnZg==
X-ME-Sender: <xms:VmueaqkTj1ChOsqbMEqr19WTv-6KgBofDnHq79YscBiXj37czROeMQ>
 <xme:VmueasxTkRV9nJctEnSvI_leLkBbhPzw16YNNA_uDv6d8g_5XzunhE9d0xFIrYEIg
 nikoS9rDCUkhqpFRqVqkVTeHze51uLVkym4SkXGQJMJBK2xCA3MdA>
X-ME-Received: <xmr:VmueanpsQvbfRpDZRIFPFdZquQzT8kWDKHbvcCcXlk8D1hy3ofx1wqvGhxExtw>
X-ME-Proxy-Cause: dmFkZTE0DyY61Xl0DX+nQo+Y6DggQLbFpLuUtn6pvtqYNy5ujot/DMQ3bIe/vlYUYMb3xl
 PQn9U2JEZD/Wn4+97MTeDZTjxGSAed2v5YDKljiU+1F39HOm77+OHHJomJsy+48rt77wwN
 WGTuKZuXtzaMWbEwiLJRhVPSmE6+ojNw8Vc3xrPR/P6MyePaEwB3T7ifUwIuqQ5YBxLv4g
 uz2OYOUB06UxO/zAucHvlrEDP0QcU1AEtosIZrv82E3sa95oRcwrULq7YOm1lUDdnkC/2Q
 5wiypLEFXZRYothnYhbxK2+tqRFcOdYrO146zdTLEtX6K2jzXcyMR3ZGMmUHtuOlnWaPj0
 y2TbL75MlgCFuhHLwpiNy0um0pNvfB8OSYQew8BNBoOkQmP0UgxjSd7KJY0kO+C7i+EI/K
 6WjK6JQD/Vp8FMNCXvCplA5RZs4Cp65Sm6CBtQRlkKsq9WXj9hfStcZtCGIrKVY8bv6X8Q
 ZcuJs52Ga0/yxmpmD+9Rw5t2p7pe8Z5whmLa5/PENJWyKNPgDW06IqX2PIBebNT6j+6UN3
 jsnVSFGsdkP/iaRvoCxCEDbN8hLJa8pcjf1S4ErZgpbzOS+Q2M7/Pom2OijfENVGPLfV4v
 6zsHWMwEc5ZKA+SP4XiZ8RvGPtjEqRsGmzjuv/Cxju3/DjZ2PD7s2AkPMbtA
X-ME-Proxy: <xmx:Vmueaj7QA1NfZH6TgAq640odjFuQ53Drl6JBb1vdA01GZHu8EqdiBg>
 <xmx:Vmueamc6I26ebOL9mSH4hKaM8sB4ttPzzuZxU-3ufmEBlAmmhGJcpg>
 <xmx:Vmueag7WG0OVUGjP3_dTbL3DlSw8_vW2tqy2M-LqJzaLSs3mJVBTzA>
 <xmx:VmuealuMx1XtrgsoLgA0DgWFUmra_47dFjp2N5mypy15QesL6KUUoQ>
 <xmx:VmueatyhZeMvrllNL8yRey47ToJlVSaFnWqEiTRzShYgcBJ-e-aVtZs4>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 03:44:21 -0400 (EDT)
Date: Mon, 7 Sep 2026 09:44:20 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Daniel Paziyski <danielpaziyski@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 0/2] hw/nvme: sr-iov hotunplug fixes (assertion failure,
 memory leak)
Message-ID: <ap5rVGS81A44tGGV@AALNPWKJENSEN.aal.scsc.local>
References: <20260905121812.47816-1-danielpaziyski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YZ4CIRZLZf8Q4raQ"
Content-Disposition: inline
In-Reply-To: <20260905121812.47816-1-danielpaziyski@gmail.com>
Received-SPF: pass client-ip=103.168.172.153; envelope-from=its@irrelevant.dk;
 helo=fhigh-a2-smtp.messagingengine.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--YZ4CIRZLZf8Q4raQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep  5 14:18, Daniel Paziyski wrote:
> As the subject suggests, in this series an assertion failure and a memory=
 leak
> are fixed when hotunplugging a nvme controller with virtual functions.
>=20
> The patches are exactly the same as
> https://lore.kernel.org/qemu-devel/20260805124519.30054-2-danielpaziyski@=
gmail.com/
> ("[PATCH 1/3] hw/nvme: fix assertion failure on sr-iov capable nvme contr=
oller removal")
> https://lore.kernel.org/qemu-devel/20260805124519.30054-3-danielpaziyski@=
gmail.com/
> ("[PATCH 2/3] hw/nvme: fix memory leak on sr-iov capable nvme controller =
removal")
>=20
> posted in the series at
> https://lore.kernel.org/qemu-devel/20260805124519.30054-1-danielpaziyski@=
gmail.com/
> ("[PATCH 0/3] NVMe hotunplug and PCI SR-IOV fixes")
>=20
> I split the patches here, as a separate series, since the other patch is
> unrelated to these ones and requires a fix, and it was a mistake on my pa=
rt to
> put patches for different subsystems in the same series.
>=20
> Cc: qemu-block@nongnu.org
> Cc: qemu-stable@nongnu.org
>=20
> Daniel Paziyski (2):
>   hw/nvme: fix assertion failure on sr-iov capable nvme controller
>     removal
>   hw/nvme: fix memory leak on sr-iov capable nvme controller removal
>=20
>  hw/nvme/ctrl.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> --=20
> 2.55.0
>=20
>=20

Thanks,

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--YZ4CIRZLZf8Q4raQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmqea1QACgkQTeGvMW1P
DemoFQf+O/zmcJBrEX0jaRfMCj0LFMzZ8PozO7Ewc1AxbFkX9Y+kTpaH0Nv6awbX
nvOGn3+sxZJzSn/rWNrOHuCaYzx67XXzxZP5K0ffSAoVEzLeNMqSNOhrCsfSCxVF
zRJ+KWE9AaQ5pP8LKxQyHc1YC6kHfvIt8XYa5n6a7gNWsJtdOELRI6xBxXVAx1Jw
zCeDYtJoeJalNNSgiCLW9mSSfHCmJMouOCs545E/w0YTNluaulWw/M1IFiqFrpiK
fKCf16hcTZktDf2Ehs46+JVVlDOA0rswHNUY+B3z/nUone/u46EYOhO6C0GRzbza
dhty7hEhAfLY2y/ZDPHQPYCdtlU+NA==
=qU7R
-----END PGP SIGNATURE-----

--YZ4CIRZLZf8Q4raQ--

