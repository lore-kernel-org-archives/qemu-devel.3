Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2FBEDEBFD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 01:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxb0s-0001eJ-Oq; Tue, 03 Mar 2026 20:26:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxb0r-0001dw-0w
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:26:57 -0500
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxb0p-0003JS-96
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:26:56 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 6DAD7EC0616;
 Tue,  3 Mar 2026 20:26:52 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 03 Mar 2026 20:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1772587612; x=1772674012; bh=mBIt7eRDL1CQ6j6SdOzmGRng6lo2Lwo7
 t02TOJKw384=; b=Vrye3xi6Yqi6GyLaKbMOjBstnvnNaTf7uJfKn1HrhqjLJVKJ
 sPVnvrozAQln1S5D+GqlrezIvqRoYhpRSahtJ8evPIj8SqjRqYeuKhD0a2GX2Plj
 MjwqFGa1K3QobPAOKs6CJvaMGX7+SkvJqr1XgiZdOQ3moBvr7tp9Zajp8GCV9dTW
 9UsyY4RXbCvJT2PWDwhm4Rj1t3vbcVwGcpv4Zi1O7V4Me7aGp8Rs2dDZIs8gubuS
 Hku/HX6c7DSBNaAdsw4FGomNpKAgUsRMGUWZQiBl2cnthUCWbDq0imGTgcpzI6xO
 +B/ipvCXoxjR5OBd3QxBmyMaXIdJO3sXLlD9fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772587612; x=
 1772674012; bh=mBIt7eRDL1CQ6j6SdOzmGRng6lo2Lwo7t02TOJKw384=; b=2
 JAERbZszjQUxk8uOX3LVXxOLnTYQYx8/LiQ0/j/2ls/HQU88CTLtgBbZtMwPxOQs
 Hj3/OvhNR+4CcrQ6djMH/+xelP15LEbyow1zpSlVB2XP2RBzLti5z/EcHCHDVvCh
 /1dvbgfZ1ByjzY1Guuy1rCaZ0R/2+ZSLXNorioAMUqH2+sPdJ5AyGXu5t85cg5ic
 D/WYAoQ39SHxDtOdvlEIwRNmsa5a5rXxf2RSmJ2Lr0cdeyzF1Q6+UNj0B4/vZmOF
 T/d+T5r2DHOh9+9Ri1gel4ipMM5ROOyHml0FQN3AKOL2UAzFakgRaWkQvSJExVAc
 nPhIh/44frxc2SwJFkcPg==
X-ME-Sender: <xms:XIqnaXntlz2P0zzvXUQ0V38QfB1Yg10cEiYWEcsES2kVWY1fzq4m3A>
 <xme:XIqnaRu5w63TYhJm3D1lbgNPYRumU6xkgKFHB5Qa3nc2Nm-EPoRok8jd6XABNIk4z
 xAJP_yqFAGo-vUTdOVGN1rxQ3QOFTME09SLilFLd-9ahNbOhvd02oA>
X-ME-Received: <xmr:XIqnaV-lmoa3B7XhNTtC2xDrZfA36-GYsuSIEWHVnPqfp8qNVECHB70l9zPn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvudehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvfevuffhofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpeekffekuddvtdehjeduhfekteet
 gedvfeffieeugfefffevheeggfdtkeeuteekteenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmh
 huqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegthhgrugesjhgrsghl
 ohhnshhkihdrgiihiidprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuh
 dprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhm
 pdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:XIqnabPtoJuY8cjUAggB-mYV71rxDClZJfnioKgXswAyPOZjqgsy0w>
 <xmx:XIqnaTHELWnPRNe7UuHF8P5IbLz5Q7_vtFBKCB7ebpo2gvsHwQoPRg>
 <xmx:XIqnaZTo6EVPSY6AWLCUf1X5N0iG9aP_aUh5QlTUV_r-NsjpIYgpcA>
 <xmx:XIqnaQtHyRvpt0bK8RyoUUeMljraiqMoibegova3bHt7XCy976g_5Q>
 <xmx:XIqnaeLgm_W0Zyz897cYYvBFmG8YOtVETXp2QffqwbSAdH5QqusJ6EWu>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 20:26:51 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 3bd63ca8;
 Wed, 4 Mar 2026 01:26:51 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Mar 2026 20:26:51 -0500
Message-Id: <DGTLV6S10ROE.37PRQWXFH73W@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, "Gerd Hoffmann" <kraxel@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v11 17/17] ati-vga: Implement HOST_DATA flush to VRAM
From: "Chad Jablonski" <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20260303024730.1489136-1-chad@jablonski.xyz>
 <20260303024730.1489136-18-chad@jablonski.xyz>
 <6cd73946-b4e5-873b-eafc-64be19a5a51b@eik.bme.hu>
In-Reply-To: <6cd73946-b4e5-873b-eafc-64be19a5a51b@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.146; envelope-from=chad@jablonski.xyz;
 helo=fout-a3-smtp.messagingengine.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.499,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> Also tested that it works with MorphOS that was known to need it for some=
=20
> font rendering so this fixes Xorg and MorphOS. It is now fully reviewed,=
=20

This is great! Thank you Zoltan for all of your time and patience
reviewing.

