Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4488CE7B06
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 12:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJtIY-0006yb-Hl; Fri, 14 Nov 2025 07:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1vJtCO-0001t6-SJ; Fri, 14 Nov 2025 07:46:50 -0500
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1vJtCH-0000VX-A4; Fri, 14 Nov 2025 07:46:44 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E071E1400138;
 Fri, 14 Nov 2025 07:46:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 14 Nov 2025 07:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1763124381;
 x=1763210781; bh=KRYaujiTt/NaBsbWVwqCf8TZUqbb8yn18Xn+agrRczw=; b=
 xYw68h30mOhha24Fy+Djx1xc28TWR+ECpjvcdZxAd8PpW3IpvQphK4vUToR/2kIT
 ddw45vQcaseH695Yym7cwPZgeTlI7WwjK0JEN+z102/PPahAsMbtXi2JUgTwjNUn
 5G1N1TyJ+1xl3p1ATSixjpbNinTRt0jHgO+D4u89iWf6NK/r6mlxuOUhPHWZWjKg
 +3C7HThvqa/bO9YzkNVvrQkSOB3s7k+FL86Ek1/qTF6sEJf9dNTThO+2Ig2ZNcOb
 JlU6q6P6SGXk/fEjqdfGE+XY8EVE5AQlX6LODYbihfwiPvfyUDsIUNgQoRBQPjLQ
 RmwyUlqZv9xGiD51Qu0oNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763124381; x=
 1763210781; bh=KRYaujiTt/NaBsbWVwqCf8TZUqbb8yn18Xn+agrRczw=; b=q
 tO1PWTSFRu9NpxEDakCpSS0jxM15f5M7nRoQ+0xEr8vaXATkezmoePgbWuXbkAn5
 02l1iFwZi+EjExSYZVqx/l80qHFRigPjuD7ATYsfJ3arRtITUmsfeDpdJMtGG1o/
 QGSP+Oy48fGmYJzw2L/xd/Z2nibhTw9IuJcMn6hVikdRbfyzFyeU+6pkipj6PYyt
 kO4zeGiACYWk0T3qi0vyDyejupjqwWV3foMjiPOTUpsQ5xlICGVp9sBl5sVi3JFx
 msS3qzi7U7h+dqYe/qet1hUQkq//d4KkD7XvCEG+l8S5WKnfrxOXWFkOMcawxebR
 uYMtwDVsdiAcfFFkPRymA==
X-ME-Sender: <xms:nCQXaeQtrHyqW1zIlLTrndImcnf0qI6wwQUaQBopTju9Ilkbqa7emw>
 <xme:nCQXaeuA6ltEL9pNcrVsDHqG5WttY0N5syBXXA-95NiVnQeTXPfpelZAkOLRv9MA3
 nXLfoNIjifq0dWIskySIbEuWbb9MZTbPurhvhKnmK9OZgLixM6yvy8>
X-ME-Received: <xmr:nCQXaa18WIOnoQREN2G1zsYXPJ4129IzS2AzJHohqay7_t8KwmFsKsh-AtCDdz-iJo4xRyJu9FrKt1HFK378GNx66Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdelkeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedflfgvshhp
 vghrucffvghvrghnthhivghrfdcuoehfohhsshesuggvfhhmrggtrhhordhitheqnecugg
 ftrfgrthhtvghrnheptdevkeffvefgkeeutdfhteelhfehhfeugeffgfdthfelfeeuudff
 gfelleeuudeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepfhhoshhsseguvghfmhgrtghrohdrihhtpdhnsggprhgtphhtthhopeejpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpd
 hrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthho
 pehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhgvmhhuqdgslhhotg
 hksehnohhnghhnuhdrohhrghdprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehl
 ihhnrghrohdrohhrghdprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtg
 homhdprhgtphhtthhopehqvghmuhdquggvvhgvlhdqsghouhhntggvshdoqhgvmhhuqdgu
 vghvvghlpegrrhgthhhivhgvrhdrkhgvrhhnvghlrdhorhhgsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:nCQXafWH-mA2nbIevglkN7oN-qfpJ-3LpjGwnkYycHh0GSEDHWurHw>
 <xmx:nCQXaVLd8RfQURpMvQeUU8A1yqfTjKYdrxCZlMwyew4uMtEI4J9tNQ>
 <xmx:nCQXaR1WGjGeWJRqLKw7LhGv6W7c24N4xY0gjHsutgPVeijA3iZ8MQ>
 <xmx:nCQXab6MBWIuM_963ovcRaNO0EugkqYmPmf_ndojboKDoKLSk7lTWg>
 <xmx:nSQXaakEL_YZGepx588aHlolpk2AnKIJXiM8zpYLCyadIF3bpzHk2Dsh>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Nov 2025 07:46:19 -0500 (EST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Nov 2025 13:46:17 +0100
Message-Id: <DE8FFH3SWJXI.R5P4RVKOJWKQ@defmacro.it>
Cc: "Peter Maydell" <peter.maydell@linaro.org>, "Klaus Jensen"
 <k.jensen@samsung.com>,
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Subject: Re: [PATCH for-10.2] hw/nvme: fix namespace atomic parameter setup
From: "Jesper Devantier" <foss@defmacro.it>
To: "Klaus Jensen" <its@irrelevant.dk>, <qemu-devel@nongnu.org>, "Keith
 Busch" <kbusch@kernel.org>, <qemu-block@nongnu.org>
X-Mailer: aerc 0.20.1
References: <20251104-nvme-fix-atomics-v1-1-fe13be5a8339@samsung.com>
In-Reply-To: <20251104-nvme-fix-atomics-v1-1-fe13be5a8339@samsung.com>
Received-SPF: pass client-ip=103.168.172.159; envelope-from=foss@defmacro.it;
 helo=fhigh-a8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>

