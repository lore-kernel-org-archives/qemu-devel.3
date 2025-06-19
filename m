Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD136C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 12:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSEQf-0000zx-2A; Thu, 19 Jun 2025 08:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1uSEQc-0000zS-9H; Thu, 19 Jun 2025 08:31:38 -0400
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1uSEQZ-0004dh-HP; Thu, 19 Jun 2025 08:31:38 -0400
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id BD20C114019A;
 Thu, 19 Jun 2025 08:31:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Thu, 19 Jun 2025 08:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1750336292; x=1750422692; bh=DTuJ1Sywhv
 D1/8Ak7EOA6B+1P89kuNDOpEV88BsdxXc=; b=mwBwDilKyd9HkdaG2E0QPYl9Uu
 K+k5kqqAgkc89yblXOpPLG3BEDJvdiS8CvZ9zhygD5OBtqjRttVxbEH81Jz9yxEB
 ljUUFR0zw5EO3t9jelH3WcXo4xNIvdwqse1LjttdAbotN3slkQCzdzt4rn6/7j4Q
 ZpPBP1M0v5A7IKg68tgNxOoJPbwmk6XqRQ23iCR/ZRTBnXkvMG/0un17ZCUtBX4x
 6tPQm7pylEUD+D3YD2YpGWxGHxxHgYpda5nLIfvAWEj/Ohqi5Fecyfd82LJJG1TO
 XTklvbjJgwsym6PNFNb8GCtUDjvM5hdM9FKWA86xAd4jBIwk2CfOe9fM70zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1750336292; x=1750422692; bh=DTuJ1SywhvD1/8Ak7EOA6B+1P89kuNDOpEV
 88BsdxXc=; b=SdCOHrgOd2ApnGgJNKR6IU42FIMAYD4aT7OEXl6lfVFsmySOisg
 Bq0b/dyjCkN9Y4bIRCts7RfKfWGC+PbMy081D4BCwF/omvb3vSlTxJouKdd8bfBD
 PlL+HhuwwFhCTV5nE9EUWjXDHutirwRoyQUNz7PMfL8L6ZqpHSjc4Aq4AE9YHnz4
 CBeEk5U2SF8ASyvmJjjSbb84A4I+HxXH2rbIgR65cVb5F0Y3DSDj/T2i0TLZXeXc
 jixNcYH5uk8eniT9yRG3+2uLlBHyKYz3DmaM6WIchK1itORO69VdkLoaUKkSrWyz
 zN7fW0Hykw3VmS4x4Ln8yNQFkL6muPyoUWg==
X-ME-Sender: <xms:IwNUaC-fH7HDUnccUPboWWZooU9T5j-MHf3KZ2JMXPwZ7IGfvAq88A>
 <xme:IwNUaCsdxZzPrqd-2ptDGaUQu4PCyPhyVKsslBF8WpGfgy4qvVJevJtW0t5RoJJZK
 aJNhNIarksHWeujZRY>
X-ME-Received: <xmr:IwNUaIBlJv3xxu70d2n7drVDQxpbbQuEt9_iTSXkSYBre8hgHu-FE1vFwNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdehheefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhluc
 fvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddunecu
 hfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghksehsthiftg
 igrdighiiiqeenucggtffrrghtthgvrhhnpedtjeejgfdugefhtedvudfghfejfeejfefh
 ffeffeelgeduveejleelffefvdffleenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
 grmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiiipdhnsggprhgt
 phhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghlgheskhgroh
 gurdhorhhgpdhrtghpthhtohepphgsohhniihinhhisehrvgguhhgrthdrtghomhdprhgt
 phhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphhtth
 hopehsthgvvhgvnhgplhgvvgesrghsphgvvgguthgvtghhrdgtohhmpdhrtghpthhtohep
 lhgvvghtrhhohiesghhmrghilhdrtghomhdprhgtphhtthhopehjrghmihhnpghlihhnse
 grshhpvggvughtvggthhdrtghomhdprhgtphhtthhopegrnhgurhgvfiestghouggvtgho
 nhhsthhruhgtthdrtghomhdrrghupdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrg
 hupdhrtghpthhtohepqhgvmhhuqdgrrhhmsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:IwNUaKejbR9LTBSWVje49i6e0mBOtRzvPY6FWhEFhRZN6aBKjMqsvg>
 <xmx:IwNUaHN87s4tgIWvbhePhOVz6oxqymJcP4r8OxUFj_hzvKRWtOINfw>
 <xmx:IwNUaEnrRFQ4Dtu0vCTDaINn9ELDRE26T-ShDpfC85N3zmWROHzx4w>
 <xmx:IwNUaJtVpXQ-xeM1lgsxRRgQbNIdkNJAF5EpyWL0hIT8hrh47FJmDw>
 <xmx:JANUaMz0s7nhrg2l1OOgO6GgQGKxfBvhhOhFMOVU3U1w52ya5VtnEWB5>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jun 2025 08:31:30 -0400 (EDT)
Date: Thu, 19 Jun 2025 08:31:30 -0400
From: Patrick Williams <patrick@stwcx.xyz>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/arm/aspeed: add Catalina machine type
Message-ID: <aFQDIiJDCeavt57O@heinlein>
References: <20250619034338.2678536-1-patrick@stwcx.xyz>
 <77c90f31-801f-48e7-b35c-db202a022769@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ka2dZUjXQSmmKKYg"
Content-Disposition: inline
In-Reply-To: <77c90f31-801f-48e7-b35c-db202a022769@kaod.org>
Received-SPF: pass client-ip=103.168.172.152; envelope-from=patrick@stwcx.xyz;
 helo=fhigh-a1-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--Ka2dZUjXQSmmKKYg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 07:49:47AM +0200, C=E9dric Le Goater wrote:
=20
> Could you please also provide a functional test using this build ?
> (same question for fuji-bmc and fby35-bmc if still possible)

I can provide one for Catalina.  I just realized that the openbmc
jenkins isn't building that like it should.  I fixed it and I'll point
you to an image.

I don't have a way to generate something for fuji or fby35 right now.
Those aren't actually OpenBMC systems (they're the older "Facebook
OpenBMC") so we don't have a public image build infrastructure set up
for them.

--=20
Patrick Williams

--Ka2dZUjXQSmmKKYg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmhUAyAACgkQqwNHzC0A
wRkVoxAAjjHCC+WZ3VG2QZEv/g0dKm0/u7bZzTQjKv8EmWaIYyCht7kxJ6yfrb09
SwOeptIGag8J+pWs8OohYhy8x6+QMK0PmAwGEhJFxoXGsJldJ4vIffRNff4FVyx3
pQ/XOr+U7pEO41zo2nbfiHRFNorIP84TUDzxaL6QDpl/cJo78NJN42yoy9mxheCc
IJrxt41IZh0g8MtVWBz14c0mO3nARPB0wB7Qqy5O7H87hWxdF4NdtN236huVV5UW
WjiWiUZFp96CuRkls3aI7ubN1nIUh9iPqWFc7qk7y+VwQ2L43dRF/0nRdTjIKUel
uQvTl0FW3ezK1rAcBCok1XqymGEE+DsanhlnxCrDrYlN0aRfih2R2Os2lavLm56s
hA3dXe+WcShB6vaeJj0z1uDGbdV2fTM6JFkrwuIsb0LxJ9+mWz9cqAWaCzW3305N
slxasbZatsixRPQm46xnS9OOg+9TADIgCSx9sbr7nvSdZduxfDJUEvNQ5EkkV7sQ
NPaG3tKPtUBt7TZTwI2uqzL1oYI/+uHiVF+J9o1pfQnbATWH/o2bHWwIMh13g5g2
g9KCcWgWWuhCXeFwAwVLbJGBR+qyNS+HZ1bCVTnGw0Ml60MxceMTiYwcQ9SB+Ulo
dn4xkooaaI2RruISDzN6Em2W7q/ZiVjfVwWhrxDE1qd1iuEBUkU=
=uAOK
-----END PGP SIGNATURE-----

--Ka2dZUjXQSmmKKYg--

