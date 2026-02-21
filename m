Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DC4C61DE7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 13:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtnRy-0001w2-1e; Sat, 21 Feb 2026 08:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1vtnRv-0001vN-OR
 for qemu-devel@nongnu.org; Sat, 21 Feb 2026 08:55:12 -0500
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1vtnRs-0005vf-GJ
 for qemu-devel@nongnu.org; Sat, 21 Feb 2026 08:55:11 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id F3C69EC05B4;
 Sat, 21 Feb 2026 08:55:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Sat, 21 Feb 2026 08:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1771682105; x=1771768505; bh=4slj67GZVv
 fKovDsD57P5OjSg0W1HXhWEDxoqRMI7VQ=; b=gYVP8UINu0CWqy1PdWMh3YNNJI
 Z1Ropb2353MWbSn8V53XLjE/nNgR27P8oz9RpZh6hGvbTdbso8OZ3Rfpc3jbcqQS
 z7SPDAruIxHOuuNQlBlRVXZIeKdBXoE85dE5ub25rPhdYVK3k0wTR1MeY2zGOBSl
 1Ugw4tUwNqETPe4dj+lJ/2jgUXZxd2fFRJdnngca/e2Oa00j9vNNmhbsoGyTgWQQ
 h5sXOQTOcF29CfCpnR6oJtAx6zQXnmBCq7PbS0X0DppiCKBut0XCg6tmOXBJCf7K
 SPk9khDabXR2Cd6oexTF+urF5VjPLGRUwOSQGC6NfMjdu7zKpBVBglYLWxFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1771682105; x=1771768505; bh=4slj67GZVvfKovDsD57P5OjSg0W1HXhWEDx
 oqRMI7VQ=; b=aciVPJf5XX/wva4cph5VhKGhoaNOsxbhBrX8HTRrevi5nkqvPK2
 2x1nquQjHCH/Szzgo/mYF3Gv4PM0FHRL410zhOqU5IWUOQHmRqM0E1DmZmVrZVOK
 duplHC8mOwGBV+gq+AuqURDSEAcNu21P26IzPdtZFVfciouCU1uZ8VRCXqypN98F
 nbxDw+o/dJ8eDdOV8wMKx7Lhad+vgWdRMmiH9+y2adbZMLgw22BD8qdHwUGXWXAw
 Gy6bxnFsmlIch8p6ZmIZv3KSi8xgMU9ND8fQp//+o5yYoPhQSH0EW+ZexzV9IR0v
 qk1z6jiZ97+ntkHYrIzhzA9cgl26XJQ0ZcQ==
X-ME-Sender: <xms:ObmZaVtLvR14GQqu894PNdtvctoDGIO2G0QzRSZzd5Cjno5hMeaDaw>
 <xme:ObmZaUA35NCDfJvupla1hKWKERV-y_REVbDpeUCZ64isBlpxIQbFx0YFs0RUoGurT
 7H9nJghxAcQyXtFnEtwVq2Pc_ly2Vxa5o0Zsq20TfZs3Znz-ZZI3A>
X-ME-Received: <xmr:ObmZaSWOIH601IWsKX04YPaBpx7G-qfEqyYMGJr75A7qXrWwTcC4O1KOwGWER6POEwuVWB-B6Dwr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeduheegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefujghffffkgggtsehgtderredttddtnecuhfhrohhmpeetlhihshhsrgcu
 tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeeiudffue
 eilefgtefgtddttdekkeehkefgheekudefveetgeefiefftedvteeuveenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrd
 hishdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
 pehsthgvvhgvnhhsugestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtoheprghlvgigrd
 gsvghnnhgvvgeslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhgrnhhoshdrphhithhs
 ihguihgrnhgrkhhisheslhhinhgrrhhordhorhhgpdhrtghpthhtohepphhhihhlmhguse
 hlihhnrghrohdrohhrghdprhgtphhtthhopehpihgvrhhrihgtkhdrsghouhhvihgvrhes
 lhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuh
 drohhrghdprhgtphhtthhopegrvghsthgvvhgvsehrvgguhhgrthdrtghomhdprhgtphht
 thhopegusggrshhsvgihsehrvgguhhgrthdrtghomhdprhgtphhtthhopehjrghsohifrg
 hnghesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:ObmZadEBNPOoZLsHRNr0vDmBGsz2OIsw88kFdIhRlJTfAAe8OHaZUw>
 <xmx:ObmZadOnbqehbWnadoCM786hHYeDb4fjorQ8fcgm9pbqA256FBFB5g>
 <xmx:ObmZaZVSzzZ4miHizTn7bPV-xX7pO8ajDMtMYUGJMip_ShbPFvsyQA>
 <xmx:ObmZaUxF08EnxBbBsBY2Hws3Y4ZMAV861mewc60xRddjpXBLrbgVKw>
 <xmx:ObmZaUGgweV07sEVfbmifiaqxOBG-BDkEXroWuhbDEItq2k-VZoh5O0L>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Feb 2026 08:55:04 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id E517E74FEC3D; Sat, 21 Feb 2026 14:54:58 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, mst@redhat.com, dbassey@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Fabiano
 Rosas <farosas@suse.de>, stefanha@redhat.com,
 manos.pitsidianakis@linaro.org, Stefano Garzarella <sgarzare@redhat.com>,
 jasowang@redhat.com, Laurent Vivier <lvivier@redhat.com>, slp@redhat.com,
 stevensd@chromium.org
Subject: Re: [PATCH v13 3/7] vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
In-Reply-To: <20260219130334.787858-4-aesteve@redhat.com>
References: <20260219130334.787858-1-aesteve@redhat.com>
 <20260219130334.787858-4-aesteve@redhat.com>
Date: Sat, 21 Feb 2026 14:54:52 +0100
Message-ID: <87tsvakxqr.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Received-SPF: pass client-ip=103.168.172.147; envelope-from=hi@alyssa.is;
 helo=fout-a4-smtp.messagingengine.com
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

--=-=-=
Content-Type: text/plain

Albert Esteve <aesteve@redhat.com> writes:

> Add SHMEM_MAP/_UNMAP request to the vhost-user
> spec documentation.
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 61 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)

Reviewed-by: Alyssa Ross <hi@alyssa.is>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaZm5LAAKCRBbRZGEIw/w
ogaoAP46zbj68S052lT9BLsDODnFfe35kPWsbcEi130rfZDTJwEAqnF3nqBLw30X
MkmGQbGhCRhukHfrTD6b1UyAG1S1lgw=
=0e/z
-----END PGP SIGNATURE-----
--=-=-=--

