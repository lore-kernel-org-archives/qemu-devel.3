Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9490ACCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 03:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFl6l-00032w-4N; Sun, 02 Nov 2025 22:19:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vFl6j-00032X-Fg
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:19:49 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vFl6g-0003Bk-KS
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:19:49 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id BE748EC022D;
 Sun,  2 Nov 2025 22:19:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Sun, 02 Nov 2025 22:19:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1762139984; x=1762226384; bh=YY4MxKQr7+momo/ZeAfvFbdJvP7x+bEe
 LQoLHiHi2EM=; b=ZZYYeom7TtKd6UiPeY7J0YP8RDyGbg62kYvXvn/7xZLV9q6u
 Ej9WLMSu8YHNTYJVt50n5nK8QbWLJRmAZK0rb8hOQ32YV1tKHybA7n/f841/3X+0
 dDgltbcD4LIZmmEWTb1sLatCHIYIVK3ozD7rI8W1f/d76LdN4XOaspsaieaj6+jh
 NjnBZOWiWHoTqu+ch5nm3devbQIHHUHIM4mdmZ/bkPh8P2NEx+IME3mPRiiqmRwX
 O+Hbw4JKc3tf54O90n0DckBo6UQ+/9RzZbzmEAl/+sSYIkTB0nKDsCoUHdCO6kP7
 oSMECIm+xqFDud5Hkrq810kyuuQ1rw3FYb8yjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762139984; x=
 1762226384; bh=YY4MxKQr7+momo/ZeAfvFbdJvP7x+bEeLQoLHiHi2EM=; b=b
 PWVexN9Iot7uTj3QTda19YeLoUodTAXOwTq9vG2aw7qu9WY6rOwAMZBYD3NQMUO8
 lxtOCJWCc0GnPmpQcLQgI7cxVZku2HLroJu+ePFk4v6+wnfJ3oxWpqVDXySqzxdz
 e70A8AydEMRChreNWTkjJdIEFDAKKOOaIGwIE82Chyx4ReQ8bVzLS0xgQqs6oxy8
 Rw0MIyrrNoM4QU+76FCosSmKsNW6/IuajnAFdt1Th47liZeCdCoiCVkP5uWlPHEg
 gfvyu2jS+kkNO1fACHYEvls4sAF2BhwWdY6GJxn+Bd0vOTe3rP+f3TN/MfRZ69Ml
 5JzXwsMH3B3xAkOpqC1oQ==
X-ME-Sender: <xms:UB8IaQKOJgVhl_8ZMYZsxVAvbm4aaV3pNyYkqWkjFzscdO2CjXomGg>
 <xme:UB8IaXk6qiylSlid2CzIQ34H1tQ4GvgDMKyhySQ1AK5eYpTwU4_YLoBpS2UQ4crEt
 bySMyEKV79qJlMSGIOIjJeZalVKjtwBlnkd96AMxue2oxN6rFdn_0Q>
X-ME-Received: <xmr:UB8IaeGjDf9TSC2D-c3WbeuICfHwJjFu3PO54lx50yYICMry7MAlhACiKeqt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejtdefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvfevuffhofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpeekffekuddvtdehjeduhfekteet
 gedvfeffieeugfefffevheeggfdtkeeuteekteenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrg
 gusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehn
 ohhnghhnuhdrohhrghdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuh
X-ME-Proxy: <xmx:UB8IaXFwQfQELI0vPmdls-zKmBucWdHK3l9Te7UBhp7D75uglGRkDg>
 <xmx:UB8IabPhb9vjLekP2m3BgwtZmehs47GMc_8Voa_uQUtwLTejREVlVg>
 <xmx:UB8IaWFs_0gtxW9bd-aDhIUB_I2xPDQykMEooYpFOJN0pTjdhVA_EA>
 <xmx:UB8IaSNVXwUbAppXKryr5qfG8IFJ_KC588BUK-FTjDJwo-OJf6L4oQ>
 <xmx:UB8IaexKV7k3BCX0alja4gMJ_U71MUtwz_LzbAC2ZDalh6kP_v1VXKJ7>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 22:19:43 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id a8747c16;
 Mon, 3 Nov 2025 03:19:43 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Nov 2025 22:19:43 -0500
Message-Id: <DDYQHOPQ02RD.2DZ3N1Y4X4HEB@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>
Subject: Re: [PATCH] ati-vga: Implement HOST_DATA transfers to enable X.org
 text rendering
From: "Chad Jablonski" <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20251029140112.275456-1-chad@jablonski.xyz>
 <e3e36622-94fc-b892-6283-280b3ec5292d@eik.bme.hu>
 <fabdf0f2-4dbf-488e-9bf9-1249c3154678@eik.bme.hu>
In-Reply-To: <fabdf0f2-4dbf-488e-9bf9-1249c3154678@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.150; envelope-from=chad@jablonski.xyz;
 helo=fout-a7-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Thanks for the feedback! And wise treating this as an RFC.
I found a lot to improve in the process of splitting things up.

I've taken all of your suggestions and sending a v2 here shortly:

- Split into multiple patches
- Integrated the host data blit into ati_2d_blt
- Now works with the fallback (non-pixman) implementation
- Implemented scissor clipping
- Various other fixes/improvements

I did test this with x86_64 Solaris 10. There appear to be a lot of issues
there but text in xterm does draw correctly now where it didn't before this
patch series. I haven't gotten around to setting up MorphOS yet. It's
completely new to me but I'm excited to give it a try here soon.

