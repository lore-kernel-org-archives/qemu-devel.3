Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787CEC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 07:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMiTM-0003km-RQ; Wed, 04 Jun 2025 03:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uMiTJ-0003js-UQ; Wed, 04 Jun 2025 03:23:37 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uMiTH-000800-H8; Wed, 04 Jun 2025 03:23:37 -0400
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 0186413803F0;
 Wed,  4 Jun 2025 03:23:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Wed, 04 Jun 2025 03:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1749021813; x=
 1749108213; bh=JdI6ZF9J7IRpY0GeLk5N8mugk7X11V+wlTQhe5XmziM=; b=c
 zwyQ+G1uSQHIHIFr0o5tj9ibZeHwVWMZ6Y5+v0qcIKXE1I7/1JPiYP4H3rHyWElM
 mk3mN4LSX9ocrlHmUtL4oF01zvUNG7cebv9p/6v2w2KLPi1GL6/36+Jwaj2MnHnM
 vKQnWfUxUeCX33JE51wYbM+Uua8Fu96Z2sH1KPfB51OWzQcQpZmJnCVvhdW6X3ov
 ByW9tWmdxEODbsej1y4kw0gAVVrWaZrEx2yK27gpqXRKvRXL2f2PtPcoIRDUb+vX
 hO3BJDFOIz/d8DqxyE/t05bIDUaCDABwXPJEDSBydU1KcnsLWCep7szG2LH/mKBQ
 stYAU0scg7xrZkoZlZqYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1749021813; x=1749108213; bh=JdI6ZF9J7IRpY0GeLk5N8mugk7X11V+wlTQ
 he5XmziM=; b=j35Bx/ZjdANJIm5qqadtuA2VtRimRNdFStNXXpl0fn2cURz7U7T
 0PJZH1NYewnYqB+j+Uc2JWU7v7vCs0MAI+A2YDz4UA77e+9+2klbfXlQfCl5ggtL
 d6kfDfC5RbxM8nw5+WBN2U72XGxG3lovMWNtMUP5Qif/dvAvxxY24JopWGkutsUR
 Xk+UaA4KJrICzlY0B6Pw3qkYBPyMm6VC/KXY01lPM+9E6DhyXMd0YGtjoE8VO2V9
 5Sq73j+Z+diPmKMfpY8WKsfaFHoyagIegIxqgdg9ZntLUqV3uXuyBY3foUOq8Hmr
 /KIwcNUcqnhN4Ef0wWiDoAZPpZVSW2SS/hQ==
X-ME-Sender: <xms:c_Q_aP-PfbtRvROQhjD-LrOCJypNooyvphRosXWzvnc2oC3o2rRvxg>
 <xme:c_Q_aLuF38y0aZipErTTcAMoMcdW5PfusJMqlhGZBTNAs2iW7JnSeh61o1TlyCdFJ
 KlXY5EgTsj_4Mlf-fE>
X-ME-Received: <xmr:c_Q_aNBKFnfHa5AF-bHUKzsnLb1z-mqlzDFOzgkDoxpLodOuDoKEUEzhiEViWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddujeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveej
 vedtuddugeeigeetffffjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhjthesthhlshdrmhhskh
 drrhhupdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgt
 phhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhoshhsse
 guvghfmhgrtghrohdrihhtpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhn
 uhdrohhrghdprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtghomhdprh
 gtphhtthhopegrlhgrnhdrrggurghmshhonhesohhrrggtlhgvrdgtohhmpdhrtghpthht
 ohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:c_Q_aLcmWFgw6-JBcJi7bC-IIdn5BcGETD6_vg150S7K2IbhzP-jAA>
 <xmx:c_Q_aEOqSG9yAY_qaYDH9QvG8AlGGhpznjQsXniTjtS27QhI10px8w>
 <xmx:c_Q_aNlMkzt4Um-b9XO4rHKso5Cyhh5XHOstt2wmu8xNbQm96bodlQ>
 <xmx:c_Q_aOs_bC2XJgYTwhbmYEOsPdW7KwCJxMwJ8rT7JC2LxQv2fFnGLg>
 <xmx:dfQ_aKg46zgPqtmf1TRNtz5DnMWB1Ti0_-rux8ghgGTjchGQPZJ00QUb>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 03:23:31 -0400 (EDT)
Date: Wed, 4 Jun 2025 09:23:30 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH 0/2] hw/nvme: stable fixes
Message-ID: <aD_0ckiBYw40-fOQ@AALNPWKJENSEN.aal.scsc.local>
References: <20250603-nvme-fixes-v1-0-01d67258ffca@samsung.com>
 <0bb11abb-50cc-4ee1-9d91-bcb522161f0e@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M78Kti55Y8EVAbG4"
Content-Disposition: inline
In-Reply-To: <0bb11abb-50cc-4ee1-9d91-bcb522161f0e@tls.msk.ru>
Received-SPF: pass client-ip=103.168.172.144; envelope-from=its@irrelevant.dk;
 helo=fout-a1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--M78Kti55Y8EVAbG4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun  4 10:21, Michael Tokarev wrote:
> On 03.06.2025 15:59, Klaus Jensen wrote:
> > Two fixes for stable. See commits.
>=20
> What do you mean "for stable"?
> Are these not for master but for stable *only*?
>=20
> Usually changes for qemu-stable are picked up *from*
> master branch, unless there are major changes in
> stable already.
>=20
> Thanks,
>=20
> /mjt

Hi Michael,

I was intending to CC to qemu-stable when I do the PULL to master after
I get reviews :) The intention was not for you to pick it up
immediately.

My apologies if the word "stable" in the subject caught your radar
unintentionally! :)

Thanks,
Klaus

--M78Kti55Y8EVAbG4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmg/9G8ACgkQTeGvMW1P
Dek+PQf/aAZraQX7IFa5iREXmzE6IrQ/ZSNVVqJvOPylRamTV8NWFnrKK0AxK4na
sy9iHpcychuGWoPefuZoX1jd59A3fDyweOvWkQS2iowCeV785H5nztKY6Tcyo7MP
eHBhqIgMGH71LsEp5es91k2AbD5afiydnfvm8ETZEPN1EkiliTM8P+OnhFESvBwj
0Qqm2rh99UbfX0V4kwFOGCNJOBLODHtTPnGtp0xhqkyyIiwMdrKqtqi4WYCt/4Xp
6ZlKPmztiaAgQepfK8ARLJpa92p8nqQTi2fUTvU9QdP5wi1AO8MIu+EYXTi+BmA7
TyTvPHeGnLBCXdntDkzKtYfrY5eF0Q==
=oK3T
-----END PGP SIGNATURE-----

--M78Kti55Y8EVAbG4--

