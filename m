Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00987106B533
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 13:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5O07-0007tz-3v; Wed, 25 Mar 2026 09:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w5O04-0007td-VC
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 09:10:21 -0400
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w5O03-0006RW-7M
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 09:10:20 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id AA3AE140027F;
 Wed, 25 Mar 2026 09:10:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 09:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1774444217; x=1774530617; bh=X4vr3y5P7uxElxeresXU7PPjABdWVi5p
 0gRn5cEe2Wc=; b=IvOKnC4o4QuKP9JV2ovzMpa//h/pfQZG4O5vktFg3LQDPL5U
 zqw/PIE6Cm6DdQ6IVCTZQKGwS5kiMlXHbTzCuUATAJpdwXl2Cxya357lp1IZjsue
 wvwC76JVfbJCYp2uM0JxTQ8zqaD/rqXxShsIGd/08FJ3yz6Yp24Aod1xDqB8gZwf
 3hQnY147efP8N7c6GLgXqlYjJ2aXTLSIAcxT4vvIcAI0MsS/c6WJDUFWVPuoGSEw
 mYsusVJYYtPIKzKDYjDImBbdLtV/Xn3t3KatMQ8G4qydUmpfcC6+MRi0U/dOMZ6Q
 WT7OGhI60NMJVJEn+pAgPAvcOVheBcNt+RHMHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774444217; x=
 1774530617; bh=X4vr3y5P7uxElxeresXU7PPjABdWVi5p0gRn5cEe2Wc=; b=0
 nK+a8mXAsUkLwelnpdPQH8kpFCxoVs0XTl6RnUN4fR3RFjZc8mwXaVXfNyYZpagn
 sane6VXZLAFEOJRdgNnYClpNBkNM+cXTHbSqlSJN9XHI3/V4WXVTeqm2/T+qp8W5
 1UmLhktxqWPDYkDZim40IRR/e7vPIdc3Pz9SX8f51avNlbAYWTuY4+7C0Z2uxTI3
 wATj8W/TYXK6htjvzrGYEKwgYwWvAFWcjO9ifeE7yfFApJDODXFzE/wxWUnSAvhd
 dvXu3iGBO2J+SKi61d5NKbwPj2yEjI2brGhEGN66W7e2bo9s+MgZ8+lsaeyIV2Jz
 AvFK7wKE9DXM9QIvjCdUQ==
X-ME-Sender: <xms:ud7DaadNvWUFArQqOUPaLmpT6RW_i8i18jLt4CHb3klXtdxdzOJf2g>
 <xme:ud7DaX5bw8RhqXQiz5NN0rszzvfoybRINW6qAn1KtkTCW2_tcqR8cBJBPfvSEr5_T
 7Pk4EiBsIw0TLSSrUnX7_DDODrxTGm73ElnEG6US1RACr3wCk_lx2RZ>
X-ME-Received: <xmr:ud7DaVWDTDB8aAsFEfU3ay4JWxS5E9p_jzpCWN47mqCgRvtHB23u48_D86lr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegheegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrh
 gtrghnughrvgdrlhhurhgvrghusehrvgguhhgrthdrtghomhdprhgtphhtthhopegsrghl
 rghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehphhhilhhmugeslhhinhgrrh
 hordhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdp
 rhgtphhtthhopehkrhgrgigvlhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhrg
 gusehjrggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:ud7Dae642_r1RexPf-luBXHDeHlnJ5eE28m3Tbct-BEOuyz4Z8YJxg>
 <xmx:ud7DaYpgkX2WWTK0VeW4fft9i6pcL0UAXsrEfh02dAq0Qs-IC6Yk8A>
 <xmx:ud7DaZk1Ck5aBrYYJyVs8KEee-17JiBtYiCuGMHtHd9_wZIrJQ_1Zw>
 <xmx:ud7DacO-lItpMAkE6A0g28JLwqYTIWaSVsZnYwFgUc3bbX6ilSrnXA>
 <xmx:ud7Daaf6Fq5_ddVp_Wc_7dSJE8YLixpEe3xGBw93LBz1BOlSOMoNsDbE>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 09:10:16 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 03781d58;
 Wed, 25 Mar 2026 13:10:16 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Mar 2026 09:10:16 -0400
Message-Id: <DHBVZ7B7ZCAN.D37FLYFV0847@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, "Gerd Hoffmann" <kraxel@redhat.com>,
 <marcandre.lureau@redhat.com>, =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v6 7/8] ati-vga: Simplify pointer image handling
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <cover.1774110169.git.balaton@eik.bme.hu>
 <b9de530074b954d661a0eb9b8b4ad82a66085456.1774110169.git.balaton@eik.bme.hu>
 <DHB2SIE9XM4F.38ZR2LJ2F670B@jablonski.xyz>
 <fa102b60-4b0d-7d70-81b1-dc145ee8b5f0@eik.bme.hu>
In-Reply-To: <fa102b60-4b0d-7d70-81b1-dc145ee8b5f0@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.155; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a4-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Chad Jablonski <chad@jablonski.xyz>

