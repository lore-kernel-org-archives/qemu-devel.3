Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10B0CF6BE2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 01:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdIea-0000gr-Px; Tue, 06 Jan 2026 20:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdIeY-0000PT-3e; Tue, 06 Jan 2026 20:48:02 -0500
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdIeV-0001o3-Qv; Tue, 06 Jan 2026 20:48:01 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 16036140006B;
 Tue,  6 Jan 2026 20:47:58 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 06 Jan 2026 20:47:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1767750478; x=1767836878; bh=99Eoqkcn2BMrLXxTUg6mZlD+mU2r9onm
 2IC2ON9uvFk=; b=R3sAuld3t3hXd0jg54g0bUNW6SOYz8X62bwc11YlmWhIvN9W
 WdXBvRI5B7YJyHuaHinfz6djEIzmaNDWjsb3YOCi96C8ZpHovZaJBoIqJac+oEM2
 V998EFgyxJiNA3bGX8iRxq/zj1Aw7yu65D76GNuMFshX1g59zkEq4pg1o+BuZ8lV
 nreGEjmc1L6yYEyxKGrFYwcA3aUNC945ZyZldyq3sfozD42hrOE5feddzRMNW5+f
 WIE8h8/hhRTo53ZQQRt9/xiWwy2ValeDEQIlQYzc7/WQxNb+C/uHEIFskiqyLxKc
 cetoRN0NXnFZG3bAkY3ZVK62Tg/wXXRzHY+Uuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767750478; x=
 1767836878; bh=99Eoqkcn2BMrLXxTUg6mZlD+mU2r9onm2IC2ON9uvFk=; b=d
 /zlFc9mAn96+7T9QerSEnyVZHB4sGVxt7anrpKLxiurqaSoXhm8jn41YB9JeuH0N
 ZantRq6WYpSDnXPWJigNOX6zgw3rIOwlHNUv+VfdxMbh3tidMvLuczAnLxQ2cRax
 s84vkEVmDHBGeskObvmZsxzcGCdsKDIqco23WQWtOauYfJo29+iNJds18fHkNLxg
 +f0em+2gCZLHMIAcJIrHsiy0SVDulQfKT/QCGjxKhpi08J6dBpdsjny6JF0ia453
 wICyy0DG6rsoIy9mwAcQchDaOJwlFcW7MVsccWz5IHEnX6SpUlBUOdfilpWGigQM
 p8s2wz+ujUHDpnzCVxe5Q==
X-ME-Sender: <xms:TbtdaZw42fwjYwq0T3U7gUqPvhTakNP_CUfy3xNn7C27akyN2rqt0Q>
 <xme:TbtdaQQDWKx3_mK1ERSOet4ULIX8KjFYTzgJb0lyhDx1zjBrFyeqWn7Itg4n5AM9y
 cF5cBPEdSREmtoxyeTwMlg76DYYHU9qBaKIar2ORlPPhsIqolri5kk>
X-ME-Received: <xmr:TbtdaYXuyCGJBM3UFO1iAkOXFwqZbl_Ysx-1x72EOdpU6g3gn51r1mUXDTBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddujeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggrlh
 grthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtoheptghhrggusehjrggslhhonhhs
 khhirdighiiipdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
 dprhgtphhtthhopehqvghmuhdquggvvhgvlhdqsghouhhntggvshdotghhrggupehjrggs
 lhhonhhskhhirdighiiisehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:TbtdaaYalfoNtVXzyBonPocjgUrHdvGDHZFeOnYBzz9dSaRk-3J4VQ>
 <xmx:TbtdaW2yttlYrLVJZCZj-ab8Ka6ytue7yiHIJYOuwVXtNVh15jtilA>
 <xmx:TbtdaUg0KiiFpiqBhYBDMgMlmf6RyFBpSDv6_8Tqnr3AnKnmszK_Vw>
 <xmx:TbtdaSYGPC8hMCKj9qhX66xB7o71NT9aT7_WJeghk8s4ah3Epfy_sw>
 <xmx:Trtdad5-7iMqjdgPkwKlrDwJl-Jn3Wo3QWxVNxzt6uNijAD0AJOUP6sx>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 20:47:57 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 11de5e22;
 Wed, 7 Jan 2026 01:47:56 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Jan 2026 20:47:56 -0500
Message-Id: <DFHZ8TT9TJN2.2PU1PUV121NUI@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, <qemu-devel-bounces+chad=jablonski.xyz@nongnu.org>
Subject: Re: [PATCH v4 1/9] ati-vga: Store DP_DATATYPE and DP_MIX fields
 independently
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20260106185700.2102742-1-chad@jablonski.xyz>
 <20260106185700.2102742-2-chad@jablonski.xyz>
 <4948bfc9-6dde-566b-d01a-84a9d439306e@eik.bme.hu>
In-Reply-To: <4948bfc9-6dde-566b-d01a-84a9d439306e@eik.bme.hu>
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
> If this made the code simpler I wouldn't be against it but this does not=
=20
> seem to save much as these values are either never used or not used often=
=20
> enough to store them separately but doing so makes the register=20
> read/writes more complex. It's easy enough to extract the needed fields=
=20
> from the regs into a local once at the beginning of a block where there=
=20
> are used and that way we at least store and return the unimplemented bits=
=20
> in the registers even if we do nothing with them yet without having to=20
> handle them separately. So I'm sorry it's causing you another rebase but =
I=20
> think we should drop this patch. I came to this conclusion after searchin=
g=20
> for the added uint8_t and bool fields after this series and most usages=
=20
> are in register read/write and the others that aren't often just compare=
=20
> to a constant that can be already shifted so maybe rop3 is the only one=
=20
> that might benefit but that can be stored in a local variable. As for=20
> which register to store them in as the authorative place I'd use the=20
> M6/RV100 register reference which lists DP_GUI_MASTER_CNTL fields as alia=
s=20
> of other regs so maybe this patch only needs to fix the DP_GUI_MASTER_CNT=
L=20
> in mm_read to return the missing fields.
>

Fair enough! Not a problem at all. I've been struggling to decide when to
split out state like this and this gives me an idea of how to think about
it in general. I'll store these values in DP_MIX and DP_DATATYPE and fix
the DP_GUI_MASTER_CNTL read in V5.

