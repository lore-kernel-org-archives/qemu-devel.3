Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44116FD532A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 10:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvudg-0007wR-M9; Fri, 27 Feb 2026 05:00:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vvudN-0007gI-1k; Fri, 27 Feb 2026 04:59:46 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vvudK-0002Wg-Nd; Fri, 27 Feb 2026 04:59:44 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 7E970EC0BF2;
 Fri, 27 Feb 2026 04:59:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Fri, 27 Feb 2026 04:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1772186378; x=
 1772272778; bh=hli+U77ru0/VMkKaNgOGOsvtCKOy3PG+aVkU6g9JoZA=; b=R
 vZeEMKPvK/DjxBfjkhInmG99oBGSbMfvRfOqMMZwvGNV5j1BOi4rVUnin9CgeMD+
 +IoRIukX76kpYYIVdIa44pEteMcTkEj57PAwT/IsccVHPzif1DpAmEdthBk1lIsH
 8E1JZsBPG7zXo5HDpdVc9NwCRdr/bAFulILY3yMyRROqbtJ41kRXbWu5jrv68NLI
 yYUbyK7YxLwog3svi3sCvplLU27rj/PhiovVnvqSsWWhAkQVLKwqkNVGL002qAZC
 j0TYgPej0cy1zP+Fd0P3gaPbq1c4Vl0MCs4Nto2W2aLb8zOfuUypQzc3KIQ3y49h
 I/caF5FvEcnrBt4DtUQ9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1772186378; x=1772272778; bh=hli+U77ru0/VMkKaNgOGOsvtCKOy3PG+aVk
 U6g9JoZA=; b=YXGtJjQifK2ApeuHhFe9MGfU+BYMUwbwiQ2rkVmNnAMg4YYGmSr
 FmU0XH4nqViXIiIwcGXjWdcKGM5B4m5fw35AnXN4ctQME25IFysblmqTPTqh/PLl
 Y5nYNyEv6n6GYOi+bZGK8GiXEpyhcLwWTtnZx7KS9oDG7+XnnQHrfHOIigPPxFBS
 qQQNrWCwm9AlXH/7zuC25LUXFYssE3Q3cClnJz9+VaAHjVT4Ae8EMZ/z2VPkmnnP
 76e8Swoxg+fy0D7CD8nUaL7PiGlMopCnIGgJCCHZLJSlpYlRYAd96bd1JfDQP8Ts
 u5GX7WCMYWlYo7GGbc4y9kTtoy0LF7j7Hmw==
X-ME-Sender: <xms:CWuhaSfoNyiWQZiinR3DM3pWuicT1DNvfxNI35giEdkRVtyKf7P2Eg>
 <xme:CWuhaYPgDBFPU6Gwf5bIi_M-FTcryyvvnW2m8h70f7bc92UgLpCMhmiBSi5qsRqcT
 koBEISqo2PYVjmd6xTzk2etPG37bMViIbC_N3fVHKjZJPsnV2FROAE>
X-ME-Received: <xmr:CWuhaVuauOkKHMQvmhzJlQ69G--U9h5G8VxWbWGbMbV0ZqmhOcMbaO-RVmgZdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeekjedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffffjeev
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtoheprghlvgigrghnuggvrhesmhhihhgrlhhitgihnhdrtghomh
 dprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthht
 ohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepphgvthgvrhigsehrvg
 guhhgrthdrtghomhdprhgtphhtthhopehfrghrohhsrghssehsuhhsvgdruggvpdhrtghp
 thhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgtphhtthhopehksg
 hushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvghkshgrnhgurhdrmhhi
 khhhrghlihhtshihnhesfhhuthhurhhfuhhsihhonhdrihhopdhrtghpthhtohepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:CWuhaRBb38ZqyU4yTSIq-mPxNDJjivoVHdFwjum0NiLKQ7prEvBnEA>
 <xmx:CWuhacb6x7KbKILD6pXQKa4xj-DreWqXiN6vOv13ROxUwjwUhrcjLg>
 <xmx:CWuhacVfiLoojojtHSVCvH_shHYymZYBABjweU1yy-SjpF92iKNBOw>
 <xmx:CWuhabP0N5PZKhsVyDtv0185prfAO9LSqKqzA7NjcxhENt3rrNi4bg>
 <xmx:CmuhaQTNBFVZXkMqBBsaZyzQ10obc8uGlbCS4KGuJpuKRnm17cVt1-Yl>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 04:59:36 -0500 (EST)
Date: Fri, 27 Feb 2026 10:59:35 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH 0/4] [RFC] hw/nvme: add basic live migration support
Message-ID: <aaFrB7fMMUPfMP_5@AALNPWKJENSEN.aal.scsc.local>
References: <20260217152517.271422-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="drv9vBNIkbi6+QSk"
Content-Disposition: inline
In-Reply-To: <20260217152517.271422-1-alexander@mihalicyn.com>
Received-SPF: pass client-ip=103.168.172.150; envelope-from=its@irrelevant.dk;
 helo=fout-a7-smtp.messagingengine.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_PASS=-0.001,
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


--drv9vBNIkbi6+QSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 17 16:25, Alexander Mikhalitsyn wrote:
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>=20
> Dear friends,
>=20
> This patchset adds basic live migration support for
> QEMU emulated NVMe device.
>=20
> Implementation has some limitations:
> - only one NVMe namespace is supported
> - SMART counters are not preserved
> - CMB is not supported
> - PMR is not supported
> - SPDM is not supported
> - SR-IOV is not supported
> - AERs are not fully supported
>=20
> I believe this is something I can support in next patchset versions or
> separately on-demand (when usecase appears). But I wanted to share this
> first version as RFC to get some feedback on this in case if I'm approach=
ing
> it wrong.
>=20

Hi Alex,

Nice work!

As you have already identified, there are a lot of features that are
non-trivial to implement migration for. I am completely in favor of only
supporting migration on a very limited feature set (i.e., don't worry
about CMB, PMR, SPDM, SR-IOV, ZNS/FDP and so on). Focus on the bare
mandatory requirements. It would be preferable if the "is migration
possible?" test is an allowlist instead of a denylist. That makes sure
we don't add a feature down the road and forget to add it to the
denylist. I'm not 100% sure how to go about that at this point.

AERs are something we need to deal with. We should not drop events. I
don't think I have a problem with aborting enqueued AERs, but not the
events.

Finally, this at a minimum needs somekind of simple smoke test to catch
regressions. Preferably as part of the QEMU test suite itself, but if
that is hard to achieve, then I may be ok with an out-of-tree test that
maintainers can use.


Cheers,
Klaus

--drv9vBNIkbi6+QSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmmhawQACgkQTeGvMW1P
DelzBQf+JU4qtXatKaO9/Fp2UzwNUfkKnX++tINzMtMcOJjjHvTF39GP4khEJ42y
AbUldIEXCPTkS998Bg6eyDEjjevmjWPwfasEP8kGRjv+BU/m7wzQb/8gvJm9aONQ
y2SuDs+oFBsOX2SwEuip+7bqbMyQtYSGp0jLr1dhEDfZs3LLqRrG2tLtkDkJVffZ
AjtDievovllx60DIMULmKXilfn+Emw4eRYh61r6qHANFddkJRx4by7C3M3JRRfaw
TQvI3voGIra9UenVdSA9F+ss+ofuatu/ZOU+RPmXvACkjBwfoR3Mg1bMekXgAV9c
4O5biVbIkapZ7L2QXX0p7uc9QwrjWQ==
=2TOr
-----END PGP SIGNATURE-----

--drv9vBNIkbi6+QSk--

