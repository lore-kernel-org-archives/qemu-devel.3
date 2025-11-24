Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47340CFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 10:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNU63-00046z-Cw; Mon, 24 Nov 2025 05:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vNU4o-0003S1-6q; Mon, 24 Nov 2025 05:45:49 -0500
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vNU4k-0007Hh-UA; Mon, 24 Nov 2025 05:45:44 -0500
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.stl.internal (Postfix) with ESMTP id DA63D7A004F;
 Mon, 24 Nov 2025 05:45:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Mon, 24 Nov 2025 05:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1763981132; x=
 1764067532; bh=g4cNGBX/BTd8K8ZMwbF1u1qserLH2QhrcTFtfOzOZ9Y=; b=H
 D+BYwMI/ln3L/auQLDY/goeRFJaVBzxngHbaztTh5mxKEz/kZz/P9lcOHEb2d4xz
 JHpDhacH/EVDW92GdTbjNrUu2ocHDpqBOMLqDrEvCig/Z8nD006KI0rDr1JvPHdZ
 PaH3E3zvRmhGX+yh4RRzJJA17uU+/3oJxaYqiKI8ZorOqD+twvSIeEm5GQju+IGr
 8O+UnM26Ew3ZjuUOvnPRWrs1sw2MdWMv3ZR5JIigu8eTD32Eb0ObHPcQnfAlAFjE
 SLBbqkQSjE58oke7GfmlhOFIfkLyAgwq/GbUKbd8kgiGgKi4U+kBe+6TCgcwWnD4
 fl1YhbLHE2S9lDJ3JfpyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1763981132; x=1764067532; bh=g4cNGBX/BTd8K8ZMwbF1u1qserLH2QhrcTF
 tfOzOZ9Y=; b=RjbKZOJWvkhYLgviEV/DSqdv/c2SLjJ4iEt7HtjmFDJ/3uWDuxb
 O/C+kxI0Z2Nw8pvQxmcYw8Yfsn88XnAGphL4TJ4zf/izKx5lt9B9evOs/QRn2Rpk
 OfkvIE5ulRWg3U63d1bzJWbmXFalivRJqAhipz2FnjcsqHJB614AW+QmfiWUDwwb
 JDp4jr6tyihoFc+hUFlGgxCRPPDzYYQIpEXxiR5Lwgp5MkkaF1oL8uJt5/GJVp1b
 LBHaYOkIT2BffZ0RKbKiBfk7SP5/l4mNzk2k724cR4xaaS+PtTjjwSVcOEyPDznP
 4N2m4PTyATWh1MnDde+XeNw7HsuBLIL0HZA==
X-ME-Sender: <xms:SzckaUxTKlOGRI177Fer_fPFCct14--_TyfmQD_2aejOPR9aTkW8Ig>
 <xme:SzckaYt1jTO-nWnBpxGNGVOJg8tIrFVpeZ5-mTGDawPHaV9ym_6OL6603bTbmLriH
 JurLg01T5ebhhFO2ER79BtrhpVnrPDCj_fVde42B1podDhf1W2o9XM>
X-ME-Received: <xmr:SzckaXDqALqvMNANLvT6V9OU3Y5w74tTr7S6vS0noDpSg5hko0YRD4ArK4Ldrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeekfeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffffjeev
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhm
 thhpohhuthdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpdhrtghpth
 htohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehfrghr
 ohhsrghssehsuhhsvgdruggvpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhngh
 hnuhdrohhrghdprhgtphhtthhopehguhhsthgrvhhordhrohhmvghroheslhhinhgrrhho
 rdhorhhgpdhrtghpthhtohepphgsohhniihinhhisehrvgguhhgrthdrtghomhdprhgtph
 htthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhoshhssegu
 vghfmhgrtghrohdrihhtpdhrtghpthhtoheplhhvihhvihgvrhesrhgvughhrghtrdgtoh
 hm
X-ME-Proxy: <xmx:SzckaaFYELxiYccLW6KotD6CqDxGY4Ls3F-6eBGmtvFlEVpXbG_64g>
 <xmx:SzckaXCbqIjsTvgJBhESJ-Og7VDmCE_DO9SGALPlJAWQb64vbesYwg>
 <xmx:SzckaQnQJUf9lppxpcSEY63Ngv50xlbBgrKKt9ipnBtLfdrxiPe-EQ>
 <xmx:SzckadOBazYmLajWIZtgsSvcSwzrZdqz7K2dEJVr8FTHcJhBt_eslw>
 <xmx:TDckabOjoi0FYGUb8GbPpiReSK8CnNeNvF0wUqklAJzZ6-HYPMeSTPDw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 05:45:31 -0500 (EST)
Date: Mon, 24 Nov 2025 11:45:30 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH-for-10.2] hw/nvme/ctrl: Validate PMR memory size
Message-ID: <aSQ3SmEYSlvc7yE2@AALNPWKJENSEN.aal.scsc.local>
References: <20251124040201.55117-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FN7+Z7C0xckadnBY"
Content-Disposition: inline
In-Reply-To: <20251124040201.55117-1-philmd@linaro.org>
Received-SPF: pass client-ip=202.12.124.159; envelope-from=its@irrelevant.dk;
 helo=fhigh-b8-smtp.messagingengine.com
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


--FN7+Z7C0xckadnBY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 24 05:02, Philippe Mathieu-Daud=C3=A9 wrote:
> Per the PCI spec 3.0, in section 6.2.5.1, "Address Maps":
>=20
>   A 32-bit register can be implemented to support a single
>   memory size that is a power of 2 from 16 bytes to 2 GB.
>=20
> Add a check in nvme_init_pmr(), returning an error if the
> PMR region size is too small; and update the QTest.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Thanks Philippe!

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--FN7+Z7C0xckadnBY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmkkN0cACgkQTeGvMW1P
DekANgf8CIb9eb2ckW1/WNH6IgEojXACbuN9lkaTBEq0lzw4lmPSVTh+VBuRsUgX
vj4ipVxmzZ9dC5lOa0CykT7laQ8GYrl88t5N04qJ0q9GeRj82fiWXgzYnIdz+GaN
dT4VTlix14QOato9XSdyUKGvSH9SM7e+jp86maEVgUyYAJ0ioG+hV+nGaAIkS8K3
Wd69S/+H8HNVIdlXpq/d5v0IVPc8I/1Fj6Lp60SD4UWlZY+2I0+cdiJP9S3cMdLH
Q7GCD4UmgPZMhWgofmcjqiitdGCaN6lvCh23aC98oW6NT5qTI9MwmUKHa54aWxiy
Ny5jRZqpYlU0ilO2tiVOkVuvFpTbkQ==
=nmn+
-----END PGP SIGNATURE-----

--FN7+Z7C0xckadnBY--

