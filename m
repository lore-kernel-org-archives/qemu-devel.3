Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB85EB3621
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 17:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx6l0-0007Mz-0Q; Mon, 02 Mar 2026 12:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx6ky-0007HC-6Z
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:08:32 -0500
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx6kv-0006gW-VZ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:08:31 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 39BE41400091;
 Mon,  2 Mar 2026 12:08:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 02 Mar 2026 12:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1772471308; x=1772557708; bh=w9OoLEZJZcWwoW9qKvfBEMk2VBJ04h3u
 gf9B4Kz7dM0=; b=ea6og+7JMsWu3oUVIaxTbD0EfLdXAx1+dzzo84Ect+GXg7no
 Ry2GnRHngXMdaJwMaZgBo+JskzB0/qXv/m5hOXbrnHVSEp99v/k2EgqrLJA/dmZS
 WK3FYxG4ITo7eS2lm6mGE6yXPLRmA4Yiv62JXGCb2lukx7Kqx97Z5wWMMn0syRGr
 vcFLxwAKeaaoBaF+w+d0xr9S2E0SWYFQ/8C7mFKcOLiKPABi9rA9qCTB1lswu5rI
 5SP9CpY81XwC7pRm5Cu+j0QtP6sgag7wukOFk1CFwAYnQia1bmrlsvgcsjN9VLJg
 y+k3M3ZQiD4/+Xtr7aPl7qNXHrvJUg/gDnUFEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772471308; x=
 1772557708; bh=w9OoLEZJZcWwoW9qKvfBEMk2VBJ04h3ugf9B4Kz7dM0=; b=y
 8Hq/2+k4UXvdHjnzlD0JhC8H4GLD7jirUmgDRtnaKpsIGzbCiIxM1zIvq8y6mTMd
 dsEBOrEONAfwFfp40kdFLrULJNCstxquqzheJD7lqjcgal1mlAjmeLY5bzEF8dia
 nMbNfpG3JG2rn424b3ftBce7ok/a+x0UCJx9JgEKvvR/ZeYmnMIx1Cjd11Kyds6I
 bNnmQL6w/EjGueXsjx//uAYsiXwh+CVkl+SbUURBJfpaqc1MmhJLBs4aVjI/mF88
 bDCXvtaRIbjM1ohvi1szSVW4P6iwj+9I8D7uycB0Y/I3v2MXUlfIQEC/iIo9qZdO
 TcpYqCSm2mW7eFsHG3hwg==
X-ME-Sender: <xms:C8SlaVxUQCxqBO2hPutykRQp6_xNdRWtJQbpDQxhE4jTMjLJgH9gjw>
 <xme:C8SlacJ5K0vxwDPcMhpuGlXzX83VQ1-WNRckV4wj5j8ccIuUFOetYggyAKxiI4kYY
 tI0083zmjcsOd4pmh0vfNdXJP_XozeTSl1kn1Tlzoy0AA_lgPITb9o>
X-ME-Received: <xmr:C8SlaXq20S7jWixBuMFOCIe0OPFk3IFrjqHmKvD50d7TiB5n8L_Tn-6MbYec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekvdegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkhffvvefuofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpeevudekfeeftdekkefgvdegudeh
 feeugeehfedtueehieehgefggeettdehgfehteenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrrg
 igvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgs
 mhgvrdhhuhdprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrg
 htrdgtohhmpdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghp
 thhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:C8SlaTJ4VeMlZkRwBG2sAn262ZdaO2PoKnDGvz6G75u4TaFV5ijNyQ>
 <xmx:C8SlaUTWjvR4elcoEBeJZu0rEaHvdpbGpHOeRUYJ6pi8fTtvd4l09A>
 <xmx:C8Slaaus_vdPUzW0mH2JxBIAUldIxyZIMdAio4MiH9DZUScypXOtOQ>
 <xmx:C8SladZubjSqWJx6IeEssoUzIve2rs08eS2LWXTOPNkUUIzBd_IrTg>
 <xmx:DMSlaTmQ-kOmRYalHQGEFCM-mAALS28-G90JnZdAqVIyInTw4FHMQI8w>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 12:08:27 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 2306db2d;
 Mon, 2 Mar 2026 17:08:26 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Mar 2026 12:08:26 -0500
Message-Id: <DGSGN1CT2CP7.2TKCLFRSV2AE8@jablonski.xyz>
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, "Gerd Hoffmann" <kraxel@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v9 17/18] ati-vga: Implement HOST_DATA register writes
X-Mailer: aerc 0.21.0
References: <20260227203944.746471-1-chad@jablonski.xyz>
 <20260227203944.746471-18-chad@jablonski.xyz>
 <bacdcf5e-6382-734d-d29e-c1ec435f5572@eik.bme.hu>
 <DGSEYLNI8QYM.H1MSRR2IWS1F@jablonski.xyz>
 <2f680b56-8f02-77ad-e8e2-9f2791c65f42@eik.bme.hu>
In-Reply-To: <2f680b56-8f02-77ad-e8e2-9f2791c65f42@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.159; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a8-smtp.messagingengine.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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

>
> We only have a week left before the freeze for next release so I think we=
=20
> should finalize the series with the next version without adding much more=
=20
> complexity at the last minute so I think we should go back to 128 bit as=
=20
> was in previous version and add the simple fixes from the last version an=
d=20
> use that for now and not start bigger rewrite now. This should work with=
=20
> Xorg and MorphOS and we can do more accurate emulation on top in the next=
=20
> devel cycle if it's found needed. If errors are found we can still fix=20
> that during the freeze but only if the series is merged by then. Will you=
=20
> make a version in the coming days or should I help and compile a series=
=20
> with the patches I think should work?
>

Sounds good to me. Yep, I'm working on a v10 returning to the 128-bit
accumulator and addressing the other feedback as we speak.

