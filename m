Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84C7E8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIGT-0002AW-VD; Tue, 03 Feb 2026 10:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vnIGQ-000277-GL; Tue, 03 Feb 2026 10:24:28 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vnIGO-0003AY-U3; Tue, 03 Feb 2026 10:24:26 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id B8C83EC00BB;
 Tue,  3 Feb 2026 10:24:23 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 03 Feb 2026 10:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1770132263; x=1770218663; bh=+GN+QBtvgZIjESY8s2gYLJsVkMa7FkSj
 w2VrNRtlYgQ=; b=ZYkgIxNju+hvQ/35V+QapsMiLoW+31o7ufep4FbHwR1A1M35
 PtI6WbamhaxzKhOblt2kRCMLkwj31xBAQZO/lv6MMgipmfNf097dstJG5GaRacwY
 Gvib3vtUfCopYW1uuqtuHRXS2bKH3N4eeP1xi4MPZC1Sf3RCcmWa5mWSu/F6TW+T
 FpIcdIxnj+RKx6067sA3K9o4i+CW+HXJmEQk+SOkB5c0TdVzp6rm2X5b0w/4+wQL
 3ZUY3fIjyojkvXDQvE4LZFmdR1KtgpB/ff47phqEcM+hhnPfE2Ey61EKkJbP/93Z
 wr1dSY0aLpJicSab9mIAvf/FtwMOwjdJ1mWy3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770132263; x=
 1770218663; bh=+GN+QBtvgZIjESY8s2gYLJsVkMa7FkSjw2VrNRtlYgQ=; b=r
 AnK5UiCt/Hju7hf01x60/wB4vLF7cr1DJ/OsaE7k25LWuPlrXMw05eu6UHczBuuf
 LaKGEe3j8pniEk/53I3RTdaxi2L1RWFbBQb2LFC5RNouw6N9qGtysPXRngrasZ6w
 KUYRY+kz8gqUimskZWkWols5gTFYnxTo6x1bIfQGTpQiyx1/3DqFPUOGQHVAM1D5
 ZEws1lFDdrVQ9m3225qme7qP8Mm25PY9gM/LAWJZzkwosG/JOGMP1lhED/T/mrOY
 K4u096npmtu27kkJsGe6SWDQHeOeRrpkYJt6zCudxi4w+zf07YUZ+lQtDdFzDgoD
 84q1gdkQP3SZBBXUe88AQ==
X-ME-Sender: <xms:JxOCaTCF5iI0WLpHEXG_HFTgps_VQGRDUu5xJZS5HAuOklkx7QzHWA>
 <xme:JxOCaQiWPsNO1jIcYD8ywbFPp7_OyI6xa2fZzfEAxqMgIlTafpdjWReZM4zp0ZjUl
 gZXFl-2CmCV4Pllso6yt114LFVNaVS-rYLQyo69NCsjvNwic_iKVgs>
X-ME-Received: <xmr:JxOCaTkfuwn3NemgiaoNLfiNr55dKDh4oOqnl9ubYzOGKq178zUOeOP1kegx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedtgedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkuffhvfevofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpeekkeekfedujefgleeguddtuefg
 hedvhfehhfdutdekffdujeelfeefkeegleejhfenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmh
 huqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgv
 lhdqsghouhhntggvshdotghhrggupehjrggslhhonhhskhhirdighiiisehnohhnghhnuh
 drohhrghdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphht
 thhopegthhgrugesjhgrsghlohhnshhkihdrgiihii
X-ME-Proxy: <xmx:JxOCaUqPZVLOyZmMii5a-9AYcfuDi_1WPzBiPgFaYIzg-tcZ7-pcWg>
 <xmx:JxOCaUG0c0UtCI5d-7a8NHxvmJqIRvOIdBNnxSSaEst1YVXKM27lbw>
 <xmx:JxOCaYxzuF5h8yuwkvCpdN_1faWcPPLLi7AcAwx8VGh9zKV8MnG_Eg>
 <xmx:JxOCaRoOVIFy_rS7LFiTirUhSRXvg8GHp5KEMErwxVczNb4JcEoSTQ>
 <xmx:JxOCafJjYEJBEBF4dg1kqNCN49wR5f3s6xGocUgbt-ULx3xCu7WRjKlA>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 10:24:23 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 2b06476c;
 Tue, 3 Feb 2026 15:24:22 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Feb 2026 10:24:22 -0500
Message-Id: <DG5FIN3H49YO.RK3FTIRHL4G9@jablonski.xyz>
Subject: Re: [PATCH v7 08/19] ati-vga: Consolidate dirty region tracking in
 ati_2d_blt
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, <qemu-devel-bounces+chad=jablonski.xyz@nongnu.org>
X-Mailer: aerc 0.21.0
References: <20260202204738.3080092-1-chad@jablonski.xyz>
 <20260202204738.3080092-9-chad@jablonski.xyz>
 <7e2672e6-5e7b-47d2-1070-ccc71060513e@eik.bme.hu>
In-Reply-To: <7e2672e6-5e7b-47d2-1070-ccc71060513e@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.150; envelope-from=chad@jablonski.xyz;
 helo=fout-a7-smtp.messagingengine.com
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

>
> Are you sure dst_offset calculation this way is correct? Also if=20
> s->regs.crtc_offset is not 0 as that seems to be added to dst_bits for=20
> Rage128Pro. This may be replaced with correct value from ctx later but=20
> then you could just keep the original here to make sure it's not broken.
>

Good catch on this. I totally overlooked the R128-specific update to it.
I'll keep the original here. It does eventually bite us again in patch
11. This was an attempt to avoid adding it to the ctx while also allowing u=
s
to pass only VGACommonState into ati_set_dirty instead of the full
ATIVGAState. But it may have been a bit ambitious.

The alternative here is to either continue to pass ATIVGAState to
ati_set_dirty or add dst_offset to the ATI2DCtx. It feels a little out of
place to me (like vram_end) on ATI2DCtx but I think that's a better tradeof=
f
than continuing to pass the full ATIVGAState struct. I'll add it to the ctx
in v8 unless you have objections or a cleaner approach.

