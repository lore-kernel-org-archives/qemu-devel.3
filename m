Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC634E6B243
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 11:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6q1F-0002Et-4L; Fri, 01 Nov 2024 07:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t6q1D-0002EN-4g; Fri, 01 Nov 2024 07:40:43 -0400
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t6q1A-00085L-S2; Fri, 01 Nov 2024 07:40:42 -0400
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id E802D1380204;
 Fri,  1 Nov 2024 07:40:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 01 Nov 2024 07:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1730461238; x=
 1730547638; bh=fgeCaeIWviRTY3jzMA54feJPSPcYMfcWC+O2Myve6sM=; b=t
 TmaJAhAhu6MbpUpNREcyFolyI4jVLnHLTE2R2M7QEnnPfgUmYkx4QMtUIypw5wMV
 vOWu/+sUdtTOL9RuexoKsyLIyCR7veHcz32Ip4H+FFPLg4aM5NwyV571konv/Nhb
 e+A5n3+a87A+GQJPlvO1zfRCZfdGhcsQaedYXxfbz37qyA2WD1GeO2caTFzoQvSs
 yXL5mA2PQzgiRIO6QfMM8Xr5WOko0P8VkCDJ4mJUnFIa0uwRlYViU9BTXLbBFgLt
 7fmiCteW+orlA+YYIVXw/iEiAMaEozoFWoXkpY/G9YULJ64IZ8/LOVqu9rRl0upq
 4hlQ8ay9+rz3kZmH4aLjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1730461238; x=1730547638; bh=fgeCaeIWviRTY3jzMA54feJPSPcYMfcWC+O
 2Myve6sM=; b=SWvnQ92s7jV3BggmjoxKJ1lcOey7cI0hkK1eRmiZbjFFpJJotFF
 ub2bewgsyfm7ThCoBMJo5GS11U6NSG7Di+vhPMLGLigdeioLcrbco43lRhSpm1Ck
 phrzkX1DeEiQWT6AF0j8XwP1IgY0iIfEt7xJCCvpU1ZjACJUrg0Dp0A77JIMmszZ
 m1jIU9fHEzNJtexjlVgdFzc/yVRqqH/gGf4cWGeG7zPr8OQxbzaz4arOeB1Kf/AE
 Jx+CiBwMpcMZ/tCAr9+ortClIVKpkPlEC0U3KUUBkgiajlPr889uMX1o9Kjk02jr
 20rNWsLNYsNfIJAPcrs1VoNNz3UP1ppF2Vg==
X-ME-Sender: <xms:Nr4kZ-60Ojc_BI1MnWMarFBWkfmVzlFCXNePIwfI6js7BO1CMcQLcw>
 <xme:Nr4kZ3756rnWgfQ4V3zM_7YONqlXw0Lm30W612rLBLMcJA_EKSELN1maF9yu2gtEf
 RtAT2QI87A82bhK0pw>
X-ME-Received: <xmr:Nr4kZ9fGu4DYOK2BRSptjTbaPLc9-8ZdbdNMeMOiyBUuEawX5KCKjoKVOe4i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekledgfedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveej
 vedtuddugeeigeetffffjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhiughnihhghhhtsehtrh
 grihhnfihithdrtghhpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdr
 ohhrghdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
 epfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepmhhsthesrhgvughhrght
 rdgtohhmpdhrtghpthhtohepmhgrrhgtvghlrdgrphhfvghlsggruhhmsehgmhgrihhlrd
 gtohhmpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgt
 phhtthhopehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:Nr4kZ7I_sIlMWu6ioFkUucWqhSvduUwjKg76jhzM9yTRgz1pm3CsxA>
 <xmx:Nr4kZyLPoEl8kvRq2zUH9a8bFOAiQkoZBjgKLsTfdCpxIeyT_MRiPQ>
 <xmx:Nr4kZ8xZz8OlhGiWJVWpA9QKmX58GiA8OTZVTLhRiOOJjo3gaxpHqg>
 <xmx:Nr4kZ2IVpMxv6HZC63aN2ES16M6sthE_4pIXl8SaQp6Qn_UYh1q3tQ>
 <xmx:Nr4kZx8TVhimOJTb7shVP8_ksCO7qopH57J1KQfOapQ67RdkLlfRTWTB>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 07:40:37 -0400 (EDT)
Date: Fri, 1 Nov 2024 12:40:36 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Julia <midnight@trainwit.ch>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:nvme" <qemu-block@nongnu.org>
Subject: Re: [PATCH] hw/nvme: Remove references to PCI IRQ "pulsing" when
 asserting
Message-ID: <ZyS9sLbTl3G58A-J@AALNPWKJENSEN.aal.scsc.local>
References: <20241015103351.688803-1-midnight@trainwit.ch>
 <71d8eded-5700-4584-99e5-ab6195d9c959@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HBt/dRe6+IJWT1d7"
Content-Disposition: inline
In-Reply-To: <71d8eded-5700-4584-99e5-ab6195d9c959@app.fastmail.com>
Received-SPF: pass client-ip=103.168.172.148; envelope-from=its@irrelevant.dk;
 helo=fout-a5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--HBt/dRe6+IJWT1d7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 18 15:01, Julia wrote:
> Actually, it seems that trace_pci_nvme_irq_pin is emitted even if the
> IRQ is not asserted due to a setting of the interrupt masks.  Which is
> weird because there's no corresponding one for deasserting. Possibly
> this should be reworded for 'interrupt is high (but might be
> masked?)', or just leave it to the standard PCI IRQ traces.
>=20

Yeah, I have a patch in queue that does just that.

--HBt/dRe6+IJWT1d7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmckvjQACgkQTeGvMW1P
DelJAQf/alxMIopJy3glFTDzsKZYkEDaO+j0Znm7kwW9b/gJSKY12jwSOJd18jEz
kGTqpjIGPy6cd3nLSs/6AlrkY8LG/xx5SANMDjL3kCpMRcIomsXfHRDiCX45DcQx
Gyr6+nKbxDBHDwtOwyH9Ne3KGtQJvioe3m5XjNRJqk4schtgjBxtNFz7Std9/Tsl
Fcuack8IsBGiu/aFSdmNoUG4cdwmHozNsfAlV4Q07o9tzMJ4vNHM7cAN27Jveb26
zeSTTqdb/j8bpqetbKuT/cTvWHaejgzNq0WKGQwyPYh6THgL5qriwgbaZ3eD0O+d
W1tTMP5otPLr40tm8Bls/Qf5/79aVA==
=DEDO
-----END PGP SIGNATURE-----

--HBt/dRe6+IJWT1d7--

