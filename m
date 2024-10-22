Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C897BCDD0FB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 23:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Nz2-00022M-PB; Tue, 22 Oct 2024 19:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1t3Nz0-000226-Ru
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 19:08:11 -0400
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1t3Nyz-0007TJ-2z
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 19:08:10 -0400
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 332C811400A8;
 Tue, 22 Oct 2024 19:08:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Tue, 22 Oct 2024 19:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1729638485;
 x=1729724885; bh=gLWyeo27jt32SwSzz1pf6JLWX5ghm4vG19DKUkdvu4s=; b=
 fZc6nkFMHOZNaHL/YPfkDrtr+5CccLoPqXEhDlSugLzgf+QkQoMSk4JO4iTeTDMk
 G8E5pCVXetRQogHTfjrhThP9VuRI0nSeyMfQo5zn7lXRVkAHQ/1EU3cFfOi0/hba
 IJVMAX2FxmWRhToz7JQU2KXbobGvctdejRZ7CBqYH9c2OUX6eSyvCQXKy/IPwRrZ
 toIwZc+I/Q8ITysk6s4BxNq8jqeZCGIQM99n2lfl1Q8BLhLsOiPJ9ZY7Cjt6hHFp
 JFS5JlQjZM0WwMLSkusPxD/HnTo8ORAclbis+mbg5GbKQV/ao6jsIx5oJdgdV5FC
 aOOdvkv/WEAjeLY+TtcI1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1729638485; x=1729724885; bh=gLWyeo27jt32SwSzz1pf6JLWX5gh
 m4vG19DKUkdvu4s=; b=gYEHqVpQp6VRHnXRl6d/VVRHFuq2xElKprhzpuURT7vg
 4e3JPp0/abERTz56DH9ILe4DmJg7wfBzJRhSiv5/1yn00iBMvdTd6ugS9Cst1M/H
 2b6IAyUA3HvYh+V29hRfboNYWyGl64ZRWdVDEA1e09YGLafEu7hOCZTjDDOq01LS
 DLZACHYSxuwBV9qeh8JOFW/uW7LIBjf2CccaDmfphsst06xhp/XWnUPvNjmEMRZW
 QtX5IGrCBcSNCKiEq6aY6zcj7w2qe/AuXZgumZq3NMrWbvF+9QqgSV5h0XaubixS
 mGE8hBycfZecmyCJ3ujzto4krRsV4iju63xjhPDE3w==
X-ME-Sender: <xms:VDAYZ0ORFsmZS3oUHia_DBgNIUIJgsyc0xRCAK3BbyFgGajGXh2OVg>
 <xme:VDAYZ68n2DADqKMFxS--YK25vPiVRnjuKPMB6iR9s22B2TkhrS_jjiAwIZcp7dGaL
 dgiP4ERp5LQGg>
X-ME-Received: <xmr:VDAYZ7R3ZE58GPGHJjFZF2EOBNezujTFXbXZSW9pm06nD99sUNQwe3e05HMAHb8CpC_N57mbQY2IefpTgogSVPiwgf9laow_OA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeiiedgudelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeen
 ucfhrhhomhepofgrrhgvkhcuofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomh
 grrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggft
 rfgrthhtvghrnhepgfduleetfeevhfefheeiteeliefhjefhleduveetteekveettddvge
 euteefjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
 mhepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomhdpnh
 gspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhiqhhi
 rghnrdgthhgvnhesrghmugdrtghomhdprhgtphhtthhopehsshhtrggsvghllhhinhhise
 hkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhhthhhonhihseigvghnphhrohhjvggt
 thdrohhrghdprhgtphhtthhopehprghulhesgigvnhdrohhrghdprhgtphhtthhopegvug
 hgrghrrdhighhlvghsihgrshesghhmrghilhdrtghomhdprhgtphhtthhopehqvghmuhdq
 uggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepgigvnhdquggvvhgvlheslh
 hishhtshdrgigvnhhprhhojhgvtghtrdhorhhgpdhrtghpthhtoheprhgrhidrhhhurghn
 ghesrghmugdrtghomh
X-ME-Proxy: <xmx:VDAYZ8sbJls7UmFmGjBY8wwnqIG_kc2QFUDujBzOFA4ymG0SLuUtRA>
 <xmx:VDAYZ8f7mfGghvNx4zXrTBWksMh6t9hP8VkfW39qzsaTCVvhRs2ziw>
 <xmx:VDAYZw2aH2VomF9pLbflbR4bzCU1Xy6Prfy8vl4Vin8TdQwqZ5TelA>
 <xmx:VDAYZw_XdS-GFpNDfEDvX5bjZgSe_TnQVvD3U_sbR17HOF5R8DCcpg>
 <xmx:VTAYZ6v75qRKf96NS14TSoKohg4irk9FlfPIPToQpThYNu3a34QufZXz>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Oct 2024 19:08:03 -0400 (EDT)
Date: Wed, 23 Oct 2024 01:07:58 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org,
 Huang Rui <Ray.Huang@amd.com>
Subject: Re: [QEMU PATCH v8] xen/passthrough: use gsi to map pirq when dom0
 is PVH
Message-ID: <ZxgwUd3riLmFzFC4@mail-itl>
References: <20241016062827.2301004-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SkGEWvdQLHgEL56A"
Content-Disposition: inline
In-Reply-To: <20241016062827.2301004-1-Jiqian.Chen@amd.com>
Received-SPF: none client-ip=103.168.172.156;
 envelope-from=marmarek@invisiblethingslab.com;
 helo=fhigh-a5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


--SkGEWvdQLHgEL56A
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Oct 2024 01:07:58 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
	Anthony PERARD <anthony@xenproject.org>,
	Paul Durrant <paul@xen.org>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	qemu-devel@nongnu.org, xen-devel@lists.xenproject.org,
	Huang Rui <Ray.Huang@amd.com>
Subject: Re: [QEMU PATCH v8] xen/passthrough: use gsi to map pirq when dom0
 is PVH

On Wed, Oct 16, 2024 at 02:28:27PM +0800, Jiqian Chen wrote:
> --- a/hw/xen/xen_pt.h
> +++ b/hw/xen/xen_pt.h
> @@ -36,6 +36,7 @@ void xen_pt_log(const PCIDevice *d, const char *f, ...)=
 G_GNUC_PRINTF(2, 3);
>  #  define XEN_PT_LOG_CONFIG(d, addr, val, len)
>  #endif
> =20
> +#define DOMID_RUN_QEMU 0

Please, don't hardcode dom0 here, QEMU can be running in a stubdomain
too (in which case, this will hilariously explode, as it will check what
dom0 is, instead of where QEMU is running).=20
Stewart already provided an alternative.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--SkGEWvdQLHgEL56A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmcYMFEACgkQ24/THMrX
1yzrtgf/RxY7ihUCUzl90Phvk7LA0aAjTgAlXY4tEH52qQTnO/A+Z2NDm4oSLjbH
GPiSPBEgeoFQCaRhSNA+jim37EFaYU70jK0KX6cLH8F47iZwmTYGvkGDRoTuEaQo
Fn/aiU8AbdMBhoW5gQMlQCr5xlHpyOwBoK7ewQXxJnQLGbGYBMNCm1HXd9SUTfTW
4PL1dFsnDuFHkYDvyoOYYlCTVa3tkI0jvROYPZknizN0LUU9FaUfNQI4jORR3x4z
2u9NJ5geSTvcU6qWFjAGUAQFC6D3R4S9VEYKxGf8AtGq1vn2S6+l6n6tXA4N7xAd
dzP9KRD7WxFiJBSLISLGfJUA7XDX8A==
=EME9
-----END PGP SIGNATURE-----

--SkGEWvdQLHgEL56A--

