Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C461C54FDF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 09:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpMtD-00075P-Ih; Thu, 30 Jul 2026 05:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wpMtA-00074z-JC; Thu, 30 Jul 2026 05:17:16 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wpMt8-0002dq-GG; Thu, 30 Jul 2026 05:17:16 -0400
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.phl.internal (Postfix) with ESMTP id 34951EC04AE;
 Thu, 30 Jul 2026 05:17:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Thu, 30 Jul 2026 05:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1785403032; x=
 1785489432; bh=+h8miCXuDj0hA1V9ztaoz/4HJO7w9S0WReMjQpJKjRw=; b=I
 HfL/tBMTUloVCYvDOl+ql3Ms7GV7PtuyYWgZSi8MUd7aqP71GmEAT9PIOA8qxOXR
 qKn5a1pNk+O/n6QoB0WV/j9qPkqMrunZkLDhV5k7qiJYPTgct/7dyowQhb+KskJn
 B5D3nsAKj9fYPQS2TVj03hgBP0JB90ZgNAhYico4Dvt0lyJHq7Lfo3GgFQ43cM1+
 3hy/jQaBZ1cUsTgA1Noi76mvVemRDWJ6FnOlC5eq6afsrF/BIX5B9+SlbpT8zSMB
 cr5JKGASuDXlHprnosGADre0rQqSJC2nLCm4ISf/284ScwljQuyD/U3RYS/g1EIm
 aLvY1zE7YqiS1eKj50O9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1785403032; x=1785489432; bh=+h8miCXuDj0hA1V9ztaoz/4HJO7w9S0WReM
 jQpJKjRw=; b=TzD4GX7GEUoCFkS6J3GTVHM7mmt6xuXjHtPHgMXBc/1bMs5m7l5
 Hjl2esIWBXf7uFXDRQcttr6POwwsGUVZQpAliK2oVWVftJiVBzoREdcHFt58VQq5
 /NYI9JwZdQjEJ5Otly24vc1cN91rqk7dUeBFyBkcSudpV/q7PjzL4pe5GPwL+sjt
 M9Hz9ialPeg6l+xiIlbeD2WMSEH6DiTMvdb20Wm6/ZhhmcLJLI6gEI6t6EZdLvPZ
 awTATZ+RMOzTvIVQcDvjlobCfJ8q0ykiGsOU+U6yKP9KwQEJ8TupRQBHBLctmEr6
 Oitsj/LmGDh3iiW7f1HYM3NuiWMfqBsE3Jw==
X-ME-Sender: <xms:lhZrai4JJSTs4CnEdRZgWvqNcwBu1gI22FucNUmMffgcsvQkJN0tqA>
 <xme:lhZraocjOHyp_WqoruYJVpjgWAFgPipI1Iv34m4tjuCOip4Mgzim6lTUw0KVNFVHF
 TAhqy3JWEnATaSZCzjBlNUByg9u-xXhBDlNOz6AUA079AVzBsatK0E>
X-ME-Received: <xmr:lhZral6j7Jl220_VTOMeFb8bGXCC-qx2E1GZ1N_9cR-ArYPZcCrzbHAt_4TKEcgSItvQZo8th3CxHyQCP1HeLzEhgl2GfeQ>
X-ME-Proxy-Cause: dmFkZTG4tRf+bWN/1LK4kPTRubluYuYF0gbumWUwIQetm4AZMfvvGTc615pDNhFvjml33O
 nKzatPaTY/bLAYxUvs8O5Ws+/lYd/xQRx+fZY1w9SdZSK/eqpseoQv8Yiud7nRzVWbCCzs
 IU1ecGxHCkmbZuDFc6yoxsE9TUsduBxWaD0u3i/DeYmbS93KHThGwAEtX+8aoF4jdZ/r/a
 ah2dvgrh9lDFwK1NiR8P0KsEorxEp/DyVST5GkWdTlRxsViKEPPVHNmkhylpO8KFMpjVyT
 AaxUhFvEw03KbTZpi/1H80Yb4AuC3i932Ua50HVt1KenVSh1OW8AltFiXPk9Cn9PnDZ6EI
 U+pC2pyr9i/fqOSiqaduuV5MrK1nt4EkGoLF/1lrb53klMmnrEYSB2X7AEGyUZzij/1iZm
 1qmhrmT+WJ9vEhP4jh3SOzIAVcE5jQmnquoFLOr4TYKNXiBZg2waN+MiAqdvHw0exoC7yd
 YMN48ucpg5byOo+8Zoky2qnKp+7dkk8kAQSBBpJ9tIpFThTZz1O0oBww4SJzlOx+WPktj3
 eIAw4c8kclh2r2nmtj5jfG4gjxByMpGPm3V8AcKwKhr3i4a/qFRC9ssCGImu8jsW2C47uz
 F5iY3JVihQa7PZwy7xFV/p0pCFVpIt7Py8pjVOtBcrIWE7ydztWFTCM6ZlnA
X-ME-Proxy: <xmx:lhZral8EpXNC7YfuDEVwFnHn98bF0d0IZQKp6Cq8OSb2ETjwCkHAlg>
 <xmx:lhZranEO4kQ2IIVp5iUNT13sZ-vpcLALEhIE3WCMtK-Osr0PsMHBsA>
 <xmx:lhZraqUjaJSl29P6ryR2TZwEcg-F0PWqXXhN3pLJcYnPIOA5MgdOJw>
 <xmx:lhZraj_UOUaqTtoH3aAQAmOpO-bSaJ-nGiLxZ6vEEkw72jv8OM1Plw>
 <xmx:mBZramhg4jb6t_UH2lesOcPEHdGhM__C7--9EljsAX9ENp5nzinOGjdc>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 05:17:10 -0400 (EDT)
Date: Thu, 30 Jul 2026 11:17:09 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel Paziyski <danielpaziyski@gmail.com>,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 QEMU Stable <qemu-stable@nongnu.org>
Subject: Re: [PULL 2/4] hw/nvme: fix assertion failure on subregion removal
Message-ID: <amsWjr670LZk0zcG@AALNPWKJENSEN.aal.scsc.local>
References: <20260728180018.3574-1-its@irrelevant.dk>
 <20260728180018.3574-3-its@irrelevant.dk>
 <9a9eb76f-446a-4fe1-a603-222918a2c13f@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Gj87SQnKRmjCgalu"
Content-Disposition: inline
In-Reply-To: <9a9eb76f-446a-4fe1-a603-222918a2c13f@tls.msk.ru>
Received-SPF: pass client-ip=103.168.172.144; envelope-from=its@irrelevant.dk;
 helo=fout-a1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

--Gj87SQnKRmjCgalu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 30 10:22, Michael Tokarev wrote:
> On 7/28/26 21:00, Klaus Jensen wrote:
> > From: Daniel Paziyski <danielpaziyski@gmail.com>
> >=20
> > When a controller is created with a MSI-X exclusive BAR, the bar0 memor=
y region
> > is not used at all, and so, the iomem region is not added as a subregio=
n of it.
> > However, when removing a NVMe controller, the iomem region is unconditi=
onally
> > removed as a subregion of bar0, causing an assertion failure. Remove th=
e iomem
> > memory region as a subregion of bar0 only if not using a MSI-X exclusiv=
e BAR.
> >=20
> > QEMU options (requires a hotunplug-aware OS):
> >=20
> >          -M q35 -device pcie-root-port,id=3Drp0 \
> >          -device nvme,serial=3Dctrl0,id=3Dctrl0,bus=3Drp0,msix-exclusiv=
e-bar=3Don
> >=20
> > In the QEMU monitor, or by causing an ejection from the OS:
> >=20
> >          device_del ctrl0
> >=20
> > Message in stderr:
> >=20
> > qemu-system-x86_64: ../system/memory.c:2617: memory_region_del_subregio=
n: Assertion `subregion->container =3D=3D mr' failed.
> >=20
> > Fixes: fa905f65c554 ("hw/nvme: add machine compatibility parameter to e=
nable msix exclusive bar")
> > Fixes: 9162f1012576 ("hw/nvme: fix msix_uninit with exclusive bar")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4090
> > Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
> > Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>=20
> It feels like this one should be picked up for the stable series too,
> should it not?  (I'm picking it up).
>=20

Yes, thanks Michael!

--Gj87SQnKRmjCgalu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmprFo4ACgkQTeGvMW1P
DeksoQf+KzkqY6I1CSAQdecpqxj8gELZ5MHEayimOFky5vFmoFUdNFI4yQVdXUGq
e4e6OX1Mgn70I2n8ETS23KwMy8PhRTEydULSpZnmLi/iFqxsaTR9uAjuqLehbQ+7
/RDWukO/7y93tpuoktOblYvPJJwZ3M/1zKq+6DuT4q7xSD/LxuvnXbThymDsj10C
90grk+ZXXOwgt2MtvPT7kbuUtYYweyRWmWTlHiIYF77OC5v2+Ge2wumJwj6q+XqI
C1nn6mywu5i2Pt5R5JfNbq22btPEg+Yuxe7m/nqoWbTzntwk6RYz68HajUWwbHqY
D/05/LtMOzt8rpTYUuzaCW7/SmE1KA==
=drI6
-----END PGP SIGNATURE-----

--Gj87SQnKRmjCgalu--

