Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A4CD232DB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 04:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve4LK-0003cU-NU; Thu, 08 Jan 2026 23:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1ve4LI-0003Y2-Rn; Thu, 08 Jan 2026 23:43:20 -0500
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1ve4LH-0002iq-0V; Thu, 08 Jan 2026 23:43:20 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 79FCA140009D;
 Thu,  8 Jan 2026 23:43:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 08 Jan 2026 23:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1767933796; x=1768020196; bh=+7ncO6wcVaGuQrbJ1MDSlWWw88t9SOJX
 R6Lq7ssK4Vk=; b=mVEY2NS1i2T4jo/BkUGDm8QWgpth67Avt7C6bGJDj+1qQtq1
 ysTFgHMgu6KIui7gH7omYOnoo9D4a9NQDEWNYkD54JlHz3nP3YYHevU10ZO233hH
 3nqB9otmPAmKTRwdfgqj4Q0CykA9wsnqErt4UFlgQgHaOsEImG7Ly2gh6/5C1deb
 yrHJV/Lg2kQp4f1AblDGLD7E/G2rdHVIhvy/FZPr1n3htfQ8rDONgMOSnqYIfe46
 0wKPXnd8kk8/wM5nvxBkMYgXAC/NXMUQX87bLcIolj3cAuodGfJuYUbRqelx3TJi
 T2BVMMTVUChuufaABIKJNtXWx08UlawA6nvPTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767933796; x=
 1768020196; bh=+7ncO6wcVaGuQrbJ1MDSlWWw88t9SOJXR6Lq7ssK4Vk=; b=J
 XSaf3LpGE6VYcRkTcQgT97a5lohhTQHGmrSE7S66vjwZBhudUxKl9IoH8EscgqZI
 o3xWFXoUcgGlXCbCuGl8JDyOOOCZMBwRI5H/nSuxbK3DbnqW7gMAuUGu+CXqygHE
 mFjd8jtkatdpUeoH6rDu96BM62dbDBIzD27Ad58pgyQEwwHVEV913+vzksOUXxKl
 KNkB9D54BbzHb48Yln/jac8T69ok4DIROZ9OAhBvwnkbaKEJingaPDBmh/cTkVAJ
 Znzt+wINqAA2fl4Enf/Q6FdKMcMFGsPnovhsENEDN3qxgGh4pphgYRHiBIwOrj+d
 kzzVschJLz3vqVix6jc9w==
X-ME-Sender: <xms:Y4dgaUibo-yH9N2Z-k5LV0CSgEKt1mhShwG2zW8_RgQzSS6h2wpwPg>
 <xme:Y4dgaUCOurh1WogwMCYhmAtFavyaOu32MX6zshkFFWt76TyxcDSc_FA3tQBGywkQ_
 cAGuHuLUckMgBpmMkSnKjd1nXx1bYC2mzr4PPRNDzaG00JXcjreNbE>
X-ME-Received: <xmr:Y4dgaREfJlSArT7eCoEUK_02CMvmzI1SHz9iL6YKH29mffEBvg1bL08iUlbE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdejkeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrg
 gusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepqhgvmhhuqdguvghvvghlqdgs
 ohhunhgtvghsodgthhgrugepjhgrsghlohhnshhkihdrgiihiiesnhhonhhgnhhurdhorh
 hgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphht
 thhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuh
X-ME-Proxy: <xmx:Y4dgaUKO8E4WRIP9dotVWXPZlh2D34qZX5HNTzsuiLM2mV55oV_HxA>
 <xmx:Y4dgadkTVcoazSH7vzqUmok4njrI9pN9zqw7HKeD8IWQZDLZ6AgBwA>
 <xmx:Y4dgaUS3sF5W97ZBJ8gLzQI_ZK22H0UsWv_vHWTnZCFYNTtlX_b6XQ>
 <xmx:Y4dgaXIzgIjN4ErPv2C4mTtpNfhG5CKChk2wqkt_Mf3-wfGUNa5XCw>
 <xmx:ZIdgaQqRn5io8auizGNRtBjiGLcQJSQ63IGSXqjTkkHy_CBnxpqbA181>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 23:43:15 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 139f557b;
 Fri, 9 Jan 2026 04:43:14 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 Jan 2026 23:43:14 -0500
Message-Id: <DFJS8544JXQY.2G7AMJGW14RII@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, <qemu-devel-bounces+chad=jablonski.xyz@nongnu.org>
Subject: Re: [PATCH v4 9/9] ati-vga: Implement HOST_DATA flush to VRAM
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20260106185700.2102742-1-chad@jablonski.xyz>
 <20260106185700.2102742-10-chad@jablonski.xyz>
 <246c8b76-7a62-7dc0-1f5e-52402e2ef53d@eik.bme.hu>
 <DFHZZ37UW2LJ.6K5XDSBLC354@jablonski.xyz>
 <45b2b112-ce4d-2cfa-1e48-1b30b4a09589@eik.bme.hu>
In-Reply-To: <45b2b112-ce4d-2cfa-1e48-1b30b4a09589@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.152; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a1-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

>
> Isn't that some ROP which we need to implement for blits using=20
> transparency anyway? I think the host data gets either straight pixels=20
> that we need to copy or some bitmask that need to be extended either with=
=20
> fg bg or fg over existing image. The latter could be implemented by not=
=20
> starting with empty row buffer but getting the row from the frame buffer=
=20
> then masking and ORing or whatever combining is needed. But if we have a=
=20
> ROP for that even for normal blits we'll need that anyway in the blit=20
> function.
>

Ah, yep, very good point. I wasn't even thinking about all of the other
ROPs that are going to need this.

> Pixman has no documentation so the only info is looking at the source. Bu=
t=20
> maybe we don't need to change anything if the host data flush prepares th=
e=20
> source buffer by either using the data for datatype 3, adding bg/fg for=
=20
> mono extract and either copying the dest row first into the buffer then d=
o=20
> the fg with transparency from host data bits then finally in all 3 cases=
=20
> just call ati_2d_blt with the prepared source buffer. That way no changes=
=20
> to ati_2d_blt is needed other than allowing it to take a state with the=
=20
> source and dest data rather than getting it from registers. The part that=
=20
> gets data from regs can be split out then what's left is what we need for=
=20
> host data. I haven't thought through it in detail but I think it could=20
> work and avoid duplicating the part that writes pixels to frame buffer.
>

It took me a bit but I think I see what you mean now! Sending an RFC
patch with a refactor that I think will set us up well to do this.

