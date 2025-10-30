Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1931FCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vENZ9-0003rL-KE; Thu, 30 Oct 2025 03:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vENZ7-0003pW-BQ; Thu, 30 Oct 2025 03:59:25 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vENZ5-0000MP-0u; Thu, 30 Oct 2025 03:59:25 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 4418DEC00FF;
 Thu, 30 Oct 2025 03:59:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 03:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1761811159; x=
 1761897559; bh=rgBdBTUlayjkuNUuoGOCZg+/F5LhGbCJmCRiUCgKzRc=; b=Y
 iiT0yxpFSGgu67MNslZ3jb5vWkAgvpIZ942QRZ19QZoruaUQ/INOTcjXS71LD1Xp
 23w8/kr3isp5+U+0rHNi54iimkz25yhluH12MdyPFili6ve3ELu3JUYkdywAoGt5
 AzGkhEoJqZKrv802ZFIpANj6FKPzmXhHqgCHH/spJ4RMZiwvXwAUE/GgO2K3h3Le
 tMDAluwNdBgx7VBpEwDMlXjOlSZx+Haghh8QxHoxyL1wAdOKodDkq4uekLySw1ts
 RCOEUh/JQA3l+MFlllA99hPPq7V8LWZUDZX9j8teSkHSA4g9GwAVhY4ReqPKFIEz
 tpBQOtumt6bfZ9mnZudtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1761811159; x=1761897559; bh=rgBdBTUlayjkuNUuoGOCZg+/F5LhGbCJmCR
 iUCgKzRc=; b=t5Dl1YxoAYTCsxqU21t3Ilj3r443/g/H3aoMMkExD9c3d4FJcz5
 oO3n6UeolbJOemt7WiGtm5fYhAWLX4H1QEZw3SXzkUjs2OyDQbIKlXMV2rSL0du5
 sCM7JMJda0uKWGglZH7e7gFMGllj5FpRYcdtcFaiSiJi4qa+Isi8Wvqf+Yy5x5Xd
 C29Rw7CNJj7tbgl6KC0Ia58FhbC/RnlbtM/JyCAZyz0zmfjJtzVZLGvefq3iVsUO
 TwolylFsk2lfBZJ/jXD1qMGoUYpATEOPjU/ToxEokIPtUxTyqWujaqbe+a97SP8h
 YruJryulDbub1tfDNawV1FpKWQ1+crzODSA==
X-ME-Sender: <xms:1hoDaUQTOot0NDsDYkBYOgWGhNC61BCiJrviw8wb2pI0RkbZaQfQCw>
 <xme:1hoDadoeniZ5aN4kKRKn-d6Wy13wyMFsNQ89FjYzfPeJpmQFs_TSbmv_Pj8WhS-7P
 qIPqtyjGq9qKpD-mceJ6wQMBnBnDQrNmXZcn-mvj-N577R3jrtXL0s>
X-ME-Received: <xmr:1hoDae0Zzs2YrpXAQnb4ODWU7lwL5conqbE67TSDmq51-Ep5fKJUXwNmivZqh6Eaxs30QSAiMGBDJOR5IveeLnqhC6GT8ynt5MKRQOzF5hCi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeitdejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffffjeev
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
X-ME-Proxy: <xmx:1hoDac5iufXrvViM64FuVenRsQ_zrobl9Kb9aeBxm88fWQL-cZgHsg>
 <xmx:1hoDaSRf7bCv2UTPgUwOEyhCgkMtBZBFaQIAjnHX6mbluTpkkWYSfA>
 <xmx:1hoDaZUXarj3hjhi54xa_zOK5ivUpta7bEHNlKCumkLr5-olPZZUDQ>
 <xmx:1hoDafF-QhBwmKMSGcjY3XyLmCbGz2iMPIc46qeLmvQn5bYhlp1u8g>
 <xmx:1xoDaTa8GeqW93MmUfFADEFlizx-Bl0xGLIScIGy8W-Fp1ftTpNjdWEd>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 03:59:18 -0400 (EDT)
Date: Thu, 30 Oct 2025 08:59:17 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>
Subject: Re: [PATCH v3 08/25] hw/nvme/ctrl: Use memory_region_size()
Message-ID: <aQMa1bECP5oZQMKr@AALNPWKJENSEN.aal.scsc.local>
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-9-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="co6+pYaLvIJ9a2Ks"
Content-Disposition: inline
In-Reply-To: <20251028181300.41475-9-philmd@linaro.org>
Received-SPF: pass client-ip=103.168.172.150; envelope-from=its@irrelevant.dk;
 helo=fout-a7-smtp.messagingengine.com
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


--co6+pYaLvIJ9a2Ks
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 28 19:12, Philippe Mathieu-Daud=C3=A9 wrote:
> MemoryRegion::size is private data of MemoryRegion,
> use the proper memory_region_size() getter to get it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--co6+pYaLvIJ9a2Ks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmkDGtUACgkQTeGvMW1P
DenRjQf/ZbbBjslUkCM2TBVssTYLG3NiFvDGPEizoepZ1lNaw/TKZEtTFgG49KF3
TesHPAMz1JQ8CGkn/qbgCzgygQflczoDkyfSzzfv+A6zflWCUEjWifJ+mXK6AmZw
7nGzfqWbftGNN4RYprILJbfAHyFc5PdBmZNy3ZggSO967CHYJBvqEeQ47/ZlVsgW
NYBeTCAwGOy3qk46Se6uewUC9iHeNYXHEqvp4GtqIWRnySudysnw+DwlSDPv1Ohc
+2HNILI1p5D7vvF0on6xWfozY+yfNX+ays4AvtrWmEXYM3Z9ObPfNeTQ/q0KFP/i
H3KRiJo9RAJY3U6PfWObIjUBd4d/bA==
=3Qt6
-----END PGP SIGNATURE-----

--co6+pYaLvIJ9a2Ks--

