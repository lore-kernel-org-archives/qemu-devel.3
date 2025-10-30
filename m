Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9699CCF9FA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vENYj-0003ml-2y; Thu, 30 Oct 2025 03:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vENYg-0003lv-71; Thu, 30 Oct 2025 03:58:58 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vENYd-0000Ft-39; Thu, 30 Oct 2025 03:58:57 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 688E514001DC;
 Thu, 30 Oct 2025 03:58:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 30 Oct 2025 03:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1761811128; x=
 1761897528; bh=UrDv/QgLFQcGUeXOC/BQcJcxbDzF9UMvpEHPdtlYSEg=; b=d
 ZRp6f/eyufIuGOC2JXeUJCBgBvmNV/m6Race374QgOfv71XewXY5ceUP1EkCtryB
 hMkfdXPpZ5/hon8RWzU5/spYzeBRjRNDmSlTs8oLh65bfw3LJJV09mZl6/7o6Thw
 1sNVIDGI/PKssln12t0w/iLe2FkopFydlXYBwMu+8dmE+NCbeRHWzRYauITANKv0
 9DF1ocyUiBWR8bINbJW/CazqWrO9EBpHm+WCmX9XuXnO4RT0QO4gWlTm4egX1Ka3
 fiRyOn4j+jnsGCMcWlpS1hOW68ZalBYMjP2ah/AEq6dlee3zZVUjG3Pkmd45P+Qd
 YL1ku9xNTp2t8zR3+y2EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1761811128; x=1761897528; bh=UrDv/QgLFQcGUeXOC/BQcJcxbDzF9UMvpEH
 PdtlYSEg=; b=a5rou/++gotEkp8dX/FjYOg5EX4lLdDlI/Sqgvk2NiXHDQHz/er
 nJbFHNEBBMfdwsPGXXoI+GQG1ZXy/prtQyKH7z7y9mnEKZrEp22POw801flIKeby
 UHamln5d20Qq8a932pmx28pwIEWRtioW+3KJ8GwmWD5UgVHeOq+QCrbvNhUFYCFS
 rUmnSXqmuGK4SJibJEPRd3/EMpumU6VRZApzMyPqrTpEzVlRV6sn3wgsmfVYA4tb
 VkL+z9W+UVVSgIHq34Kb9wO9JwJ8BicnUV7gbGyVtA77EbtAyc7p18RANBvyBB/I
 Rqz0L5ZE7x2VQL2LAiyl55FJ5+ZONfQkCAA==
X-ME-Sender: <xms:txoDaRof7gumKjkpWwGzFpP87FeXM70OB6YQzuwq9GrNCD68AZZtHA>
 <xme:txoDafhsMTPKwB2fKL1nNdSfue1NoZ4dL3FsQCdSqr18ZHaXuOAL1z-GfCI0JpTAn
 VBGiYKOGcyCvCkfPL26Kv5unbB-E40ci2Xvj8-JMSZrKFLXExK5Fw>
X-ME-Received: <xmr:txoDabNQXYjcL5r3GWNdM1SZxYXQO_CNZmrwE2OJ3Y641XZrt7_ChhVESfj13tgvS2UmbMQqSI8ct06vC6sGUf92rELXj_EOoG-9i1BbzNjp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeitdejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkfhggtggujgesghdtroertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepieevffffhfeludekhefhteeuleekffduueeikedtgeethfegfeelieduleevleek
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhm
 thhpohhuthdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpdhrtghpth
 htohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehmrghr
 khdrtggrvhgvrgihlhgrnhgusehnuhhtrghnihigrdgtohhmpdhrtghpthhtohepqhgvmh
 huqdhpphgtsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdqrhhishgtvhes
 nhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuh
 drohhrghdprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrght
 rdgtohhmpdhrtghpthhtohepqhgvmhhuqdgrrhhmsehnohhnghhnuhdrohhrghdprhgtph
 htthhopehqvghmuhdqshefledtgiesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:txoDaRyZcUKSeI_9YuExyBuCIvRoS1QqT4cudIWZYj1NpNDrDUbHRA>
 <xmx:txoDaVqSDpCnCnjFBTj27NTMLCC4adqbxMiRbyxzgVFgAvS6WaSsRw>
 <xmx:txoDaZNpV5fs27Sm5Xd64rzh_EQyP6uqtBbLIscHBV5B3a7CMrNqHA>
 <xmx:txoDaRecIA3w9IW2XEwyGMNaFJg2GkDuzmzGtLUpicFUKLtM6OkXEA>
 <xmx:uBoDaY56jnFZEZ_7dWBwNSG-DD1OiDETEFJp32JUxSossehdxXt_9Nw2>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 03:58:47 -0400 (EDT)
Date: Thu, 30 Oct 2025 08:58:46 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>
Subject: Re: [PATCH v3 15/25] hw/nvme: Use memory_region_get_address()
Message-ID: <aQMatsNYBqDBhfZc@AALNPWKJENSEN.aal.scsc.local>
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-16-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zt3Grwg4pdZkcslU"
Content-Disposition: inline
In-Reply-To: <20251028181300.41475-16-philmd@linaro.org>
Received-SPF: pass client-ip=103.168.172.153; envelope-from=its@irrelevant.dk;
 helo=fhigh-a2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--zt3Grwg4pdZkcslU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 28 19:12, Philippe Mathieu-Daud=C3=A9 wrote:
> MemoryRegion::addr is private data of MemoryRegion, use
> memory_region_get_address() to access it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--zt3Grwg4pdZkcslU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmkDGrMACgkQTeGvMW1P
Dem1TQgAp5XQB+BIr4L+NumxU1Yk0BD3iPO28/wev9OeXNxH0AN6uCkIgmvrEApu
HNrhz9uSYXV31zfjxZHmhIdIaO/uPNy7P8Btwvv9NBiV0NFpM/9PLIvWSoMWg3n/
TUuN54gx8oA8smaXw+FkhrC0cH3ahPsby2rlZ2EyrcIhWI5oolGNxGUgNzG2pWcf
+bKCG0cqADFz6mLJoHIU9l1BesOFq6mx2C0mDHl7q9MwuckiqjEhTdYS4SqwpX3z
wg4zWmu/z7UBps5IpT7eHWBIGSycA1jyeK8wisbJxyxdNEPJbWfqVKu/lTY6wWt+
aJKZEDTTopr/4x67Zi/JiNLM/rYB0g==
=l0FZ
-----END PGP SIGNATURE-----

--zt3Grwg4pdZkcslU--

