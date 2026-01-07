Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E405CF6BE2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 02:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdJBk-0006uE-ID; Tue, 06 Jan 2026 21:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdJBi-0006r8-F0; Tue, 06 Jan 2026 21:22:18 -0500
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdJBg-0001zX-JY; Tue, 06 Jan 2026 21:22:18 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8A99B1400060;
 Tue,  6 Jan 2026 21:22:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 06 Jan 2026 21:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1767752535; x=1767838935; bh=SRgaT2aHyq61ZSJ7SDuV0e40eyOpIDKi
 7kz4jvEZB1o=; b=fYXZoURsUSt8ZVGbyt49PxVG9JjXljSkhuurPkNkUjqNzK4m
 WPxZAQZNMAlO0TDrEhNZBxQid4uFCy6rGV/VARR/gfsTlsHirxHlsYqOlsg8PK/0
 1P+Iy3xrWn65knt6F/mpQ7JiAv3hLkyk0rLS02ao9tPin53ra/01ZyI0gtH/8s+A
 RodK3keSbWVQ44IpwgGIPO0uFIQdjC1SL7CAP9bqvcX+LQxdwS2hC4US5xI8yLm9
 hwJaLVOCLNvT/YDNzxS8FB9UbSFRPMTuure9yMUcMJrWqdCaj5fL1nwVMkGCRxvs
 Usxyh/PpcFt9Gk4rYjGrWiZT5pKkQ4wmfaDnWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767752535; x=
 1767838935; bh=SRgaT2aHyq61ZSJ7SDuV0e40eyOpIDKi7kz4jvEZB1o=; b=i
 /c0W0UbCh6o5x4kFnmFpuEF5cKxzTkcMh/l9J062kWtgnbStkIGEtEN/Md+xhf4K
 Z4zr1IZc3hcFZTAx+C4ORHZfnmuMPvqpgjApMz6b2nslXICKJEJ+rK8d5makyncA
 3Mx18Ukg3IfidqslcVck2lZ0dbq9reTOItqm8Y8tuFwLSdrsh3L9Nyly7EyDCcln
 fYFI0CK4RypuIsq6YRVR3vJk7krTGevQ6YN4jUd5rpP6h2tYAIODGOotQTfjBekH
 h6br+Zdys7wKnm8RrgR6uevRyRJIy3ZHkrPeY8Vy7ISx+P42me8OxZe+pHt0nWpN
 pU6lqmfsxk4QYtQ4IaQdQ==
X-ME-Sender: <xms:V8NdadSd7OZgFWFKkusl1nOvdBaMCM1epN53UXkNutkKZvZkMAih-w>
 <xme:V8NdadxrKqN13KltSzLNSgZ6o7-HfcZfuu9qqWuKsk11IlaJYarA1u1Ak3YkMLQiy
 EY_InnsZmqfPxAw6O1KfCdxO0_e522ULjodAFta-hm4waekB9KCvA>
X-ME-Received: <xmr:V8NdaX2isTq_ouOBnsSbhcVz17CnKV18D6xgSttWNHQS5VvilhybnHM8fk1o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddukeeiucetufdoteggodetrf
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
 hgpdhrtghpthhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtohep
 qhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:V8NdaT6L-p_VFmBDdszSJathrC8PAaiH8J_WA7VsaIinMdFXCaq0Zw>
 <xmx:V8NdaSUzMAV_xBafF9s0dsdL_Ps73RpyajNfzb6cOOOQ5K3RYwb5gQ>
 <xmx:V8NdaaBSKw4qDxqO3X8hrmqKlO_jswmxMPOyzSu9C5hT7uUx76TS7A>
 <xmx:V8NdaZ4BGWjKFR412bL63NPS_R3IxHvNjLeMLu7R4wdNZmV6QBvZ3Q>
 <xmx:V8NdaRbPulywszhXw1bR6xsnIFv42qriWuPOwOOvoX1RSOpnu9_5RezQ>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 21:22:14 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 08298469;
 Wed, 7 Jan 2026 02:22:14 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Jan 2026 21:22:14 -0500
Message-Id: <DFHZZ37UW2LJ.6K5XDSBLC354@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, <qemu-devel-bounces+chad=jablonski.xyz@nongnu.org>
Subject: Re: [PATCH v4 9/9] ati-vga: Implement HOST_DATA flush to VRAM
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20260106185700.2102742-1-chad@jablonski.xyz>
 <20260106185700.2102742-10-chad@jablonski.xyz>
 <246c8b76-7a62-7dc0-1f5e-52402e2ef53d@eik.bme.hu>
In-Reply-To: <246c8b76-7a62-7dc0-1f5e-52402e2ef53d@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.153; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a2-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
> I wonder if we could reuse the existing blt function here and keep pixman=
=20
> optimisations and avoid duplicating code by filling a src buffer with the=
=20
> expanded data after we accumulated the 128 bits and we need to flush and=
=20
> then call ati_2d_blt with that as src and dst modified to match where it=
=20
> should go instead of the full blit area that the registers describe. That=
=20
> needs to split ati_2d_blt or it should take a blit state instead of=20
> ATIVGAState that can either be filled from regs for a regular blit or for=
=20
> a smaller part for a host data blit so that way host data is just split=
=20
> into smaller 128 bit blits which I think is how the actual GPU works as=
=20
> well. Does that make sense? Do you think that could work?
>

I considered this. I initially rolled this back into the standard ati_2d_bl=
t
function but when I discovered the accumulator behavior it changed things a
bit. The thing that seemed off to me was that you can end up with "jagged"
blits from the accumulator. Meaning if you have a host_data blit with a wid=
th
of 100px and you flush the accumulator you don't end up with a rectangular
region to blit with pixman. You have a 100px line and then a 28px line that
you need to initiate two separate blits via pixman for. My gut told me that
the overhead of breaking things up and potentially making multiple calls to
pixman per flush would make it not worth it. But I admit I never tested it!

Another thing that isn't a problem in this patch but will complicate things
in the future is transparency (bg pixel leave alone). I get the impression
there may be some way to handle this with pixman using masks to avoid break=
ing
blits up even more but I haven't fully investigated that. Actually as I typ=
e
this I wonder if that same sort of masking could be used to avoid multiple
calls in the current implementation.

I may be totally off on how we could do this with pixman though too. I'm ne=
w to
it so I may not be aware of everything it can do.

