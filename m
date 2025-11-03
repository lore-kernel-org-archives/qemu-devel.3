Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88C7CCFA00
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 02:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFkj7-0007yq-FW; Sun, 02 Nov 2025 21:55:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vFkj5-0007x9-1y; Sun, 02 Nov 2025 21:55:23 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vFkj1-0008Fi-8U; Sun, 02 Nov 2025 21:55:22 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id CEBFAEC023B;
 Sun,  2 Nov 2025 21:55:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Sun, 02 Nov 2025 21:55:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1762138514; x=1762224914; bh=c+RCGRlywL4jN6wWd41NdVoAbntuq+Ik
 qmNj+IoSBJE=; b=pyK1IzfjbpfPZtQhnFfU+0Uxw0t/5yb/PdJgfKCmkgm+RNGW
 DLFtK84XlFcc3Y5DnlolmmSk3yT+Y3bG4QyU8cd7GTZglT3BBVGwlRX612Kd4vzN
 aSS/rALjtV2WB3i6eVhTy6BZavWUSjw6EAdOQmCTN+nuGY1pvr3eF8wymIgbfvk3
 Cz4LHWRJyQscAcUaQ26WKAgFKbPGoGQJe9iZLksxyyvgWZCcKQsDUV84Sogxcd5o
 Mdz491tfm6AAjpRjZevXGZMWPLIFqMWXlJ0Nx+7F+j0qqPN5YCpb0p4AbMdHSit2
 tlmrjTZ2KdQcpIW1KlASNjmM7kLYqX8uJlNtaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762138514; x=
 1762224914; bh=c+RCGRlywL4jN6wWd41NdVoAbntuq+IkqmNj+IoSBJE=; b=r
 zRSiNuYSdrBU9a43wveCB1N/Lpxm2DqSpXX2YxFp97YppGnxacJHcNVbKwsgXEKf
 FOQricgJzsp3c/6xV9g1An1mkQarhkDI1bv9zbAxbsyyEHw8pIZVYHghXDIvCk+L
 Ozp2MS2vErZv/295vHun2gagFpsDZG+tTLQ357YYWhJqngU9vEMjlulwynNb92il
 9RZX8O27jL2ohjWsa/F9OATJjbUDFHm8Xr/tkzCmoLMoyTU59cEbL7QF0BNS2QFm
 efBzeBcmDzbnlgoZZQOXHtdiNHSdPlm0Ntm+GA6nYK/VN7jJGegmIU007MeVay8n
 dRNQnE8o1iaBKM2KK7AYQ==
X-ME-Sender: <xms:khkIaSQn3ftaLhcK_f8JvRAHrvHfGRmVCM27ByquLN218JabVWc7GQ>
 <xme:khkIaerosFbz9LrBBd0GBzJYTe-0OLJj79UUqrlA60WMC7sl211AMdfMSSOhCbhMP
 lBDDYAHlYMe9B3sLN5kWu0IVfCuaq0DSLX15XUedokihpR6dZ0OIA4>
X-ME-Received: <xmr:khkIaYL6XyFoj5P7RjhfvddOye5G9UOVHeznAQ7L4RE3vD2uuTrvduJq00d5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeileelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggrlh
 grthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgr
 thdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpd
 hrtghpthhtohepmhgrrhgtrghnughrvgdrlhhurhgvrghusehrvgguhhgrthdrtghomhdp
 rhgtphhtthhopehqvghmuhdquggvvhgvlhdqsghouhhntggvshdotghhrggupehjrggslh
 honhhskhhirdighiiisehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:khkIaZqfZ6JVYbJ6_2YkZZj9m1Ph7iRdZip3XY0w67ppuyGPgJnBuA>
 <xmx:khkIaYwNkSKDPmeCiQv6-xNdijOWCrlHLtmw97kCki3u5LXw2v4xbw>
 <xmx:khkIaVPm-vIbpAdUeekLvvEwYHbfzdHHDRme4l1ZpgDtRMxgv6ClPA>
 <xmx:khkIaV7rf4R4YfzXZubd0kdWs_k8PLCe_igz1kSOF9cq8QDprIu87A>
 <xmx:khkIacARe20fveJfRLvquxgMu8PPXLC-aTyFKHPz55XTLr9C319f0Z_V>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 21:55:13 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 4cd76208;
 Mon, 3 Nov 2025 02:55:11 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Nov 2025 21:55:11 -0500
Message-Id: <DDYPYWJR1NYS.IV5FU7V1GR5B@jablonski.xyz>
Cc: "Gerd Hoffmann" <kraxel@redhat.com>, <marcandre.lureau@redhat.com>,
 <qemu-devel-bounces+chad=jablonski.xyz@nongnu.org>
Subject: Re: [PATCH] ati-vga: Separate default control bit for source
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0
References: <20251007195435.8ACAC56F2A3@zero.eik.bme.hu>
In-Reply-To: <20251007195435.8ACAC56F2A3@zero.eik.bme.hu>
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

Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
Tested-by: Chad Jablonski <chad@jablonski.xyz>

Hey Balaton!

This fix looks correct to me. Source and destination should use
their respective bits. I applied my latest HOST_DATA changes on
top of this and saw no problems when rendering text in xterm
with rage 128.

There is one thing I _did_ notice. I implemented similar behavior with the
GMC_SRC_CLIPPING and GMC_DST_CLIPPING fields (default and leave alone).
But I implemented them as a copy of the default values during the write
when the bits are set to default. Both approaches seem to work. If you want
to keep them consistent I can test the actual hardware to see which approac=
h
it uses or I can just update my patch to match this style.

