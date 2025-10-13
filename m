Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADACCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 20:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8OmI-0004Kb-OB; Mon, 13 Oct 2025 16:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v8OmG-0004K7-Gv
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 16:04:16 -0400
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v8OmE-0007VZ-AL
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 16:04:16 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id CA7777A043E;
 Mon, 13 Oct 2025 16:04:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 13 Oct 2025 16:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1760385852; x=1760472252; bh=muvxI7pHPmWbtq1FBaaUzFyTrzfpb0wI
 WHi+T9njv4Q=; b=ivNKdnKZh+G9jgO7CbXFoN2tdrHgvJ+RVXFqEP6M2pd5Oy/g
 k5FYGIqcPHMte1xXB6PMhhSbvjxT+v2wxgA0WuX2eGrQlNyLO+11MIYe5HnFIAGR
 /ZHwua/5ekyTD9Yx9KQnzZm1130Q3X5/2CG3nE/kU2Eq7aFbQAQkFXoBnEudFfCb
 JXeGZOX6n9T8WmuxGDkVquAoLaStQo4Ml2hR7hymhMFo2okPEenglCM8ChOJ1rIk
 adqYYUKyDms/0f6hPV8LdubJFvSyLZnrSpRTtAsbgl5y15wY3nFMGH+R8gLgj/gV
 rAEY7nDGRp2yzxOyTSB7JBq1Zz+6yroErt9ZNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760385852; x=
 1760472252; bh=muvxI7pHPmWbtq1FBaaUzFyTrzfpb0wIWHi+T9njv4Q=; b=F
 kcLMqghF8eU7woMpju6LB0sf4rS1IXnv2lzFCWUgdosGy8TgXPuC9mcDAj/I9aZx
 qUM8N2b82Onkz00sphvJgbb/yN5JvqFw9jSnMaw4VgFLf4clCJnwK4bo9qnx0Eqp
 66hQ7yeXfRnvnE6X2SZmKEm3AmbwNHbFyIechPz7TATXRbP2FUm63hYVo709g4nU
 1upQ9AVR2gD5haEpMPxlE0IgSokA17yftVnGVnAYkY7qcedyIFMbqzjYtsUtnv68
 mmC/JxSTIUgg4qks7bmMq7XlM3u+9Li1MlvU52kX4lHiZ2iauqPOAsCk0lm3Ljoh
 DOJmfKm2rQfOkI9SWDYyA==
X-ME-Sender: <xms:O1vtaGu6L4WZfMoD0mC-FvG4in1-X92PeTEDc2xV92UaPE-JK_FD_g>
 <xme:O1vtaCVon1Yj_D20Uk8f1xjayHS-69LLK4On5tt3dwPYC_KjhMvPtPzZVqzMLP12q
 lLHpQW-yPtU6_wkzqBSQNA3Cmt3AJH2M5ahvR6MarX3Rufdwf4-vguR>
X-ME-Received: <xmr:O1vtaKEon9TDh3VzEl3o0aMOF90qpsmc9FE7JomOOtr2ktp1xQB2vg9Y5qeq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekheeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvfevuffhofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpeekffekuddvtdehjeduhfekteet
 gedvfeffieeugfefffevheeggfdtkeeuteekteenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrg
 gusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgr
 thdrtghomhdprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrg
 htrdgtohhmpdhrtghpthhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghp
 thhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:O1vtaM0cUh652NoWPTKnsBae00CzKB3edl8hEe-ZxwNxIn02Cy8E_A>
 <xmx:O1vtaEMu6DaQpv9ilbiVpH9VZmccvDFZaVPyr4BjJQJiJS25QSe8wg>
 <xmx:O1vtaD4-LL6pxp8UpnFfvP_nGoD5uDlwS8g9z2BAE7kuRN1hGOll_A>
 <xmx:O1vtaG18IzSojpJ9VIHe6nU2yoJohyc7GMHgK4y-j0-KP1-i109njg>
 <xmx:PFvtaAxS57xxQuh-Uvcylsn77u2injRQOqDwy1WxpW6OUp4JFyf0Y-Zs>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 16:04:11 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id c4ae1809;
 Mon, 13 Oct 2025 20:04:09 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Oct 2025 16:04:09 -0400
Message-Id: <DDHGPB02664A.3C0GAHH5K41QT@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, "Gerd Hoffmann" <kraxel@redhat.com>,
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] ati-vga: Fix framebuffer mapping by using
 hardware-correct aperture sizes
From: "Chad Jablonski" <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20251001034616.3017119-1-chad@jablonski.xyz>
 <8ca9a290-39be-7d52-2add-f37a30e05545@eik.bme.hu>
 <DDHA2TJZB67L.8WL7I58CQAZ6@jablonski.xyz>
 <31fa1128-e693-494d-2515-467866d1598b@eik.bme.hu>
In-Reply-To: <31fa1128-e693-494d-2515-467866d1598b@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.156; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b5-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=2, RCVD_IN_DNSWL_LOW=-0.7,
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
> I'm not saying the 64MB alignment is not correct (I don't know what is=20
> correct and assuming the Xorg driver was tested with real cards it's=20
> possible this assumption holds) but maybe it comes from having a 64MB VRA=
M=20
> BAR that contains twice the size of actual VRAM including the AGP window=
=20
> which also satisfies the 32MB alignment for VRAM, so the commit message=
=20
> may nees to be adjusted to say that instead of something not supported by=
=20
> documentation. Do you have any PCI cards? There were PCI versions of=20
> these. I wonder if they also have the same VRAM BAR. If not then no=20
> problem, we can go with what works for known drivers.
>

Unfortunately I don't have a PCI Rage 128. They actually seem to be somewha=
t
rare compared to the AGP versions!

Testing results from two Rage 128 AGP cards:

Card                      VRAM    PCI BAR0   CONFIG_MEMSIZE  CONFIG_APER_SI=
ZE  AGP_APER_OFFSET
-----------------------   ----    --------   --------------  --------------=
--  ---------------
Rage 128 Pro Ultra TF     32MB    64MB       0x02000000      0x02000000    =
    0x02000000
Rage 128 RF/SG AGP        16MB    64MB       0x01000000      0x02000000    =
    0x02000000


* PCI BAR0 (Region 0) is fixed at 64MB for both cards, regardless of actual
  VRAM size.

* CONFIG_MEMSIZE correctly reports actual VRAM size (32MB and 16MB).

* CONFIG_APER_SIZE is fixed at 32MB (0x02000000) on both cards, regardless
  of:
   - Actual VRAM size
   - AGP enabled/disabled status
   - AGP_APER_SIZE configuration (tested with 8MB AGP enabled)

   This directly contradicts the Rage 128 Pro Register Reference Guide
   (pg. 3-202) which states: "Size of linear apertures (both 0 and 1).
   This includes both the frame buffer image and the AGP system memory
   image area."

* AGP_APER_OFFSET is also fixed at 32MB (0x02000000) on both cards. On the
  16MB card, this creates a 16MB gap between the end of framebuffer and the
  start of the AGP window.

So for Rage 128, CONFIG_APER_SIZE should be set to a fixed 32MB value, not
dynamically calculated from CONFIG_MEMSIZE + AGP space as the documentation
suggests and as was previously implemented by me =F0=9F=98=AC.

I'm less sure about the Radeon and your additional context around the Radeo=
n
on PowerPC makes me very nervous to change it right now. Especially given I
have a single example of that card and it's for a PC. I think it makes more
sense to leave the behavior of CONFIG_APER_SIZE for that card unchanged.

I will send a v2 patch that:
  * Sets Rage 128 CONFIG_APER_SIZE to 32MB
  * Updates the commit message to reflect that
  * Leaves Radeon unchanged (half of the vram_size)
  * Addresses the style issues


