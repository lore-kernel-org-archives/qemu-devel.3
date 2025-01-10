Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEF1E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 10:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWCIP-000819-OB; Fri, 10 Jan 2025 05:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tWCIN-00080K-7C; Fri, 10 Jan 2025 05:31:15 -0500
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tWCIL-0007NK-1w; Fri, 10 Jan 2025 05:31:14 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 99A542540092;
 Fri, 10 Jan 2025 05:31:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Fri, 10 Jan 2025 05:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1736505069; x=
 1736591469; bh=BwBLPkXhl7iDRH/r3ZMS7O9BwUWfHN928urQQcMNZpE=; b=S
 dD87qkUNFmAXf4Z2e9a0AZzFYIrPftL9MMiHdM/rBCot9J6BFfppcXwogIxTGtXK
 nFU+VKJ9xSw4YBo3T2ICThHmPMSB6y4sKVfADUfT/UZ70pQGFAluoCrd9IHJvseQ
 Fq9f6pTuDNOPL1MEgJIW/a8FYvGCQ3FmCakrC5XKyg+9Tqa92GAWeVPpVUwviZoo
 9VVwIy5ztbrWKpIrePkyc1Lx30sIouygD6aK++8ex2TH+d7nYIeqHT4E/T9TIaxm
 F6s3XAZaOd4cDIoDxTkGwDfy88kYTk6Nw6S0ehrZe5Knq5fquAV9KGgn9Muojef9
 /Si4qkR4epT9WKwoe5ZmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1736505069; x=1736591469; bh=BwBLPkXhl7iDRH/r3ZMS7O9BwUWfHN928ur
 QQcMNZpE=; b=m3qIGYpDEHa+vGmlwUFT93qL3qxzHRFhWwC+qA9opxpr3aPnpFh
 K9LGP6vBJhfwroAoWFkt05prI75j8qLo8knGukwl/xlYPqIvVHPQvIR6ptFcvDNj
 TPH2ZODBrtfN6/2+XcPeZ5qMspU9Up6qUHHXNmLrXVnxKbihiGHovwv1TimAvNij
 WSVxwSI9qNWhixfY6SWV0sA/1cc3mRDE3LJY7IV+EjmERBYq9NOUO0YdNp4sFBM+
 snBoZRdErIfBSRY4Jp16yerlwyueN9M6C8XF07NInnK9zCNfSFCylu99KQKsr7Sw
 7t0WaVeabpX8L4w1kXsSiSkZsSqDDjpQTmQ==
X-ME-Sender: <xms:7PaAZ3dIW1rglY2NU3yxjfv7dNv4Z4j_nfSdEUHsb0Sc7AnuBV6eIA>
 <xme:7PaAZ9PgosMrmD053-zDOF0z4tonxUda1Fxh9ZULl1ILWG7BVK7BNKl4YvI7CqBHc
 4y5pW0GRRfFuzZrsMw>
X-ME-Received: <xmr:7PaAZwikO9YFstgBu7zqw-3QVFxgtWDbZZrKkIVGBFTCeoqCe-XCMaEZzI44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgudejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepieehheevhfeggefhheehfeeugffgkeetkeefueet
 hedvleffffevfffftefhgedunecuffhomhgrihhnpehophgvnhgtohhmphhuthgvrdhorh
 hgpdhnvhhmvgigphhrvghsshdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgr
 rhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprh
 gtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehssggrthgvshes
 rhgrihhthhhlihhnrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhngh
 hnuhdrohhrghdprhgtphhtthhopehjrdhgrhgrnhgrughoshesshgrmhhsuhhnghdrtgho
 mhdprhgtphhtthhopehjrghvihgvrhdrghhonhiisehsrghmshhunhhgrdgtohhmpdhrtg
 hpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgtphhtthhopehk
 sghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhoshhsseguvghfmhgrtg
 hrohdrihhtpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:7PaAZ49zBzkv9rfU5WNk6z6h_rimzq6uaFl66170-lFL1s4I1wT6WQ>
 <xmx:7PaAZztyFsBZSSfXlUzp5uyH0tbZoUTkx8H4CnKVKyJS8WJthRM4gA>
 <xmx:7PaAZ3FBeu1nIuPavJeXOCX0PLsyx-ZunbW7ftPhz7BnQzXj7kn90g>
 <xmx:7PaAZ6P0orjyY1N2BdHrX9CTE4TdDktZ4-vntjbZfQ4DTG6_hlrJsQ>
 <xmx:7faAZ5Ceu2e7jsxisKwucn_rVXkK6yghUbfCOdn9RnaQ4rTfUhxOOpzs>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 05:31:08 -0500 (EST)
Date: Fri, 10 Jan 2025 11:31:07 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Stephen Bates <sbates@raithlin.com>
Cc: qemu-devel@nongnu.org, j.granados@samsung.com, javier.gonz@samsung.com,
 qemu-block@nongnu.org, kbusch@kernel.org, foss@defmacro.it
Subject: Re: [PATCH v2 1/1] hw/nvme: Add OCP SMART / Health Information
 Extended Log Page
Message-ID: <Z4D2SSzH5B-yL-s2@AALNPWKJENSEN.aal.scsc.local>
References: <Z0nre-4GLin5yeGX@snoc-pinewood>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AsSHbpB4DM6Te+6L"
Content-Disposition: inline
In-Reply-To: <Z0nre-4GLin5yeGX@snoc-pinewood>
Received-SPF: pass client-ip=202.12.124.156; envelope-from=its@irrelevant.dk;
 helo=fhigh-b5-smtp.messagingengine.com
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


--AsSHbpB4DM6Te+6L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 29 09:27, Stephen Bates wrote:
> The Open Compute Project [1] includes a Datacenter NVMe
> SSD Specification [2]. The most recent version of this specification
> (as of November 2024) is 2.6.1. This specification layers on top of
> the NVM Express specifications [3] to provide additional
> functionality. A key part of of this is the 512 Byte OCP SMART / Health
> Information Extended log page that is defined in Section 4.8.6 of the
> specification.
>=20
> We add a controller argument (ocp) that toggles on/off the SMART log
> extended structure.  To accommodate different vendor specific specificati=
ons
> like OCP, we add a multiplexing function (nvme_vendor_specific_log) which
> will route to the different log functions based on arguments and log ids.
> We only return the OCP extended SMART log when the command is 0xC0 and ocp
> has been turned on in the nvme argumants.
>=20
> Though we add the whole nvme SMART log extended structure, we only popula=
te
> the physical_media_units_{read,written}, log_page_version and
> log_page_uuid.
>=20
> This patch is based on work done by Joel but has been modified enough
> that he requested a co-developed-by tag rather than a signed-off-by.
>=20
> [1]: https://www.opencompute.org/
> [2]: https://www.opencompute.org/documents/datacenter-nvme-ssd-specificat=
ion-v2-6-1-pdf
> [3]: https://nvmexpress.org/specifications/
>=20
> Signed-off-by: Stephen Bates <sbates@raithlin.com>
> Co-developed-by: Joel Granados <j.granados@samsung.com>

Hi Stephen,

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

Thanks! Applied to nvme-next!

--AsSHbpB4DM6Te+6L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmeA9uoACgkQTeGvMW1P
Dekjigf/S4X6Zv03UikATUH/2yYQXIfBvge4eluj7HGiGxNj3Zc+lRvZBOh7IT8O
WiffRygpXAYHUPO79NcpfUqzHFxrjPMlwQ5c8g+GalTyKRcqmb2azURVqH2dYXmM
h0w/c4uMokRjsYlW0iNIgNuC2sNxrMaZ/oi8xa7632yjrGSITczv6Go9pV57qlDN
rYOAWNWkv1Ogd6gcz1QIyVMMp9Aa78VEtgwfxbRIhnJAnDIP9VB/06sGQUHnFQFt
hHS6u4XdOXHZ6zkOu6fpYQ1SR4CmzKia+00gujJ7NeWlJZpfddaxMeHi2KPOYC8c
lcEN438aDQpwZ2VhFTV4I4tqxc913g==
=ksDD
-----END PGP SIGNATURE-----

--AsSHbpB4DM6Te+6L--

