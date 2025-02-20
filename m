Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A4EC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 11:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl4HY-0001hb-86; Thu, 20 Feb 2025 05:59:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1tl4HW-0001gy-Dm
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:59:50 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1tl4HU-0001nE-Eb
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:59:50 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id E98971380A25;
 Thu, 20 Feb 2025 05:59:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 20 Feb 2025 05:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1740049185; x=1740135585; bh=N+dDY/2AGx
 dycnIPXWfPFjiWgoo6WSgHy9EejcNRf/Y=; b=SvHSVZN6I0h68MSQ/2Pdl88Wn/
 YGs1NpNsM+JJbkaJw+F8FYzJ6X2IfsQEWnOdibrC1z7eZaPLPmB6/E4O0Pq/KaSk
 HmBDc3C2dAdgdPln/KX98nOcf2kD1UNZbSyFmvo1Pjdr0DgDt3cMM+6SodraIi7F
 /2IvSs6bDV/d0X+gHfs5d0bbG4wz2u9ww4OtWeJ4+bd5B0O2lHLYgQfQCdiWAhXM
 JyBi+J/r9QLwnGgF9cAPuJ881nypbcJ2z1smwvFLN4/f5SYtHyAwfoPwswNmbWix
 8iBn3DxUsETa8RP+oR4/hDv1CbqCDIHsou17siXqtIZklYdbdOBK6e08Vomg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1740049185; x=1740135585; bh=N+dDY/2AGxdycnIPXWfPFjiWgoo6WSgHy9E
 ejcNRf/Y=; b=bdHjmBjW9uz7pFXxsCGHGt3jSmwgMu9dGMusXP4vUVgbJ1tHihn
 pKBWadu2wFZH7AVZHKvWcg1n/MIO3BC8AFIP/iUbghu81UZn7+j52+eg9F7ZqQhd
 y7X6qqTU92b4eY0VJ2QGN0YGe1l8EiFrBbarfcspI2Qxfd61b+o6MH7RjbLheQc9
 N9tbArz2WdgxkvXaINhkNlEbrahHt1omTP8GgwsGbXpMbx/DOgWnBeGobFDXgTEq
 cyBDAMddhfxTOOVK0XwEAv/0T0LXPvooUbTgk8g3+/q3WMxybi9iumES4VAEbeSz
 s/0ph12NAYntPeX17QKmCmaJwUtko5ldeHg==
X-ME-Sender: <xms:IQu3Z_0xWstBc04sw0X0nOZCn9O6UJpG69dYxwYWhUco1mbswz1awg>
 <xme:IQu3Z-GygmFttAHgZDRCmPjY8ll8POJJxCj8kDaSMlEaOX6r3m3nAOBXDVN6kjRC5
 da26PnkPJ8pBfXj-w>
X-ME-Received: <xmr:IQu3Z_6nKO4nGIH6QqgDjv9tzpNGdNo87mhiN4DfagPaD_3UhKGj9HrLPOOwlGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiieeliecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfggtgesghdtreertddttden
 ucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecugg
 ftrfgrthhtvghrnhepieduffeuieelgfetgfdttddtkeekheekgfehkedufeevteegfeei
 ffetvdetueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhephhhisegrlhihshhsrgdrihhspdhnsggprhgtphhtthhopedutddpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepshhtvghvvghnshgusegthhhrohhmihhumhdrohhrgh
 dprhgtphhtthhopegrlhgvgidrsggvnhhnvggvsehlihhnrghrohdrohhrghdprhgtphht
 thhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtoheprggvsh
 htvghvvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrvhhiugesrhgvughhrght
 rdgtohhmpdhrtghpthhtohepjhgrshhofigrnhhgsehrvgguhhgrthdrtghomhdprhgtph
 htthhopehmshhtsehrvgguhhgrthdrtghomhdprhgtphhtthhopehsghgrrhiirghrvges
 rhgvughhrghtrdgtohhmpdhrtghpthhtohepshhlphesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:IQu3Z00nSVU_WDr77iOm6K2nLQvsIoDtpSy8FqEVjSDkjISm7tNlMw>
 <xmx:IQu3ZyGutEaGqHkwi3mTavJIcpZASlH01axTXzxSZQwG1iMMaXUJ1Q>
 <xmx:IQu3Z19mshRs_pelRgVAjAIkqiaBeAYAcbw5RaXmw15t9uOYDwDrAQ>
 <xmx:IQu3Z_mBIEwsiq9w2Gk6g0_lnuf8yNtcPntLGciqYUkDH9f4T2oFPg>
 <xmx:IQu3Z68KlzTQXRIqGaXDSem03Gs7Zw9qy9fbEWt_tr1TQgtCSlHFngWH>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Feb 2025 05:59:45 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id 82703FC23; Thu, 20 Feb 2025 11:59:44 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: slp@redhat.com, stevensd@chromium.org, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Stefano Garzarella <sgarzare@redhat.com>,
 stefanha@redhat.com, david@redhat.com, mst@redhat.com,
 jasowang@redhat.com, Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH v4 1/9] vhost-user: Add VirtIO Shared Memory map request
In-Reply-To: <20250217164012.246727-2-aesteve@redhat.com>
References: <20250217164012.246727-1-aesteve@redhat.com>
 <20250217164012.246727-2-aesteve@redhat.com>
Date: Thu, 20 Feb 2025 11:59:42 +0100
Message-ID: <875xl4g9up.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Received-SPF: pass client-ip=103.168.172.150; envelope-from=hi@alyssa.is;
 helo=fout-a7-smtp.messagingengine.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Albert Esteve <aesteve@redhat.com> writes:

> @@ -192,6 +194,24 @@ typedef struct VhostUserShared {
>      unsigned char uuid[16];
>  } VhostUserShared;
>=20=20
> +/* For the flags field of VhostUserMMap */
> +#define VHOST_USER_FLAG_MAP_R (1u << 0)
> +#define VHOST_USER_FLAG_MAP_W (1u << 1)
> +
> +typedef struct {
> +    /* VIRTIO Shared Memory Region ID */
> +    uint8_t shmid;
> +    uint8_t padding[7];
> +    /* File offset */
> +    uint64_t fd_offset;
> +    /* Offset within the VIRTIO Shared Memory Region */
> +    uint64_t shm_offset;
> +    /* Size of the mapping */
> +    uint64_t len;
> +    /* Flags for the mmap operation, from VHOST_USER_FLAG_* */

Perhaps this should say VHOST_USER_FLAG_MAP_*?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCZ7cLHgAKCRBbRZGEIw/w
ovsoAQCxIVgK8Xu7gTQHiPNvEdXy2PiRgvXId1iLa0dsTb8vKgEAreWkqJhjCGqs
Ma1YwlzhsSa0XDJM/Pl71xx/6S3D5QU=
=eNch
-----END PGP SIGNATURE-----
--=-=-=--

