Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAC610775F8
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2uhp-0004ir-6N; Wed, 18 Mar 2026 13:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w2uhh-0004hG-4M
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:29:12 -0400
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w2uhe-0003lL-GY
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:29:08 -0400
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id B5C1814001DD;
 Wed, 18 Mar 2026 13:28:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Wed, 18 Mar 2026 13:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1773854938; x=1773941338; bh=NLxqvO6KM8hWSwlO2aSOcACX6MKJjTuC
 4YarPxZ11nw=; b=KWZwF/+wOzJLruWHjHG0yQGGPoHa0qrP9LaLopxGgeOcLRHi
 jb4JxptktoGEdba9xRu1x8D+FaxGMTo4+08fFCIyMoUnuLSSeTRebkHwnTm2D78V
 rvZg/dqF8wWAT/FCX5Br++YVC1NcRRuyAYqgpu4soPprF79jNWFuR6y7AkcdnEdj
 0XhSO+3JHdb5e9ZT/lMY2DWMqlx4SLuQXoIx9xDouqb1qhOSrLJMo9ekXB6rsL5k
 FaiVzlKmkStiDeTttQrAz62qlYhwuCB6MCD2yRF5c4zjstrCap/eisNX2dZvVwLD
 d+7+WuLL5Sc6G6mkVqsTCvaD56jzEn62kCYYmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773854938; x=
 1773941338; bh=NLxqvO6KM8hWSwlO2aSOcACX6MKJjTuC4YarPxZ11nw=; b=l
 A02Xp566fAOT5QnakdA/jRIaE3f18KJ6Ltpr/+91heMJgrEG1AS5Eyg7n8wNybMt
 1dPEe8xRtWjgxr8FNmKUcKHZisGSLUY2OeQWjH3iqw80AGRXGWklYw3H6Z4qSVbd
 CX0Ht0n0+ac+weKM0NHALp8ViB0vXOQDKTAKHhGiOgPMGRFw52wwJT0kQMf6kU30
 HTv7pAXeb4Tc0kBpsPuELbRWjELWBcPXSnvu4Ww9VFP+q5bYXovEd+hLHlw8I8C5
 8ohLjV/km8SIty1BkEf8xaVcL3aGOrHUo30zE9Y4ZKs3eGpIbjBmAQwD7BLuzLV4
 6PgZ06x9bept4DSW/TVgQ==
X-ME-Sender: <xms:2eC6aeblWglNj2sDgR3ZWdMMUVTC15fB5C2ff_RkxmqGc7VTP83Wrg>
 <xme:2eC6aVHIuQFfmDHklFLEco6S_s_y_HTbBKbKQ7lxov7M1B7IuG-z3raF8SD3mdxCo
 kjFBMaUdwu9OM52oJ8mN8dwN3dkjjIWEngKgizecFJE5ZMwL7zQJaM>
X-ME-Received: <xmr:2eC6aSxrgtfTRGLgAYQWfoOTwJ2LM0t-x84oQ1ix8q3HXGqNGh8oObzS6a-n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdegjeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggrlh
 grthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtoheptghhrggusehjrggslhhonhhs
 khhirdighiiipdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhurhgvrghusehrvgguhh
 grthdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
 pdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrghdprhgtphhtthhopehkrh
 grgigvlhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:2eC6aXmZTsew25_JSzHyCsx3LqFtFzbVUqr6S8OhVHo0Oi2pNRJlVQ>
 <xmx:2eC6abndW0q1sEmEu5AKlbFWRXx0f0RP_BVFozxuGp2G9LUwejZnsA>
 <xmx:2eC6aZy8DZbp63V-PtBEi4CImF_WZOY6afMkZNVVpNg93muass1T2Q>
 <xmx:2eC6aQrtJXE76pDn0mQSfDgC5O9OUN36YOJsdTToKymmF_HjxvHTPA>
 <xmx:2uC6ad4cmifLpSpq3AgosxEJMFSZUCx4tEtHD9XpRcSudCHFZ7vn6K_0>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 13:28:57 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 7eb9cbd8;
 Wed, 18 Mar 2026 17:28:56 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 13:28:56 -0400
Message-Id: <DH633G213QPR.2EMRCN626JXVS@jablonski.xyz>
Cc: "Gerd Hoffmann" <kraxel@redhat.com>, <marcandre.lureau@redhat.com>,
 "Chad Jablonski" <chad@jablonski.xyz>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 1/6] ati-vga: Fix colors when frame buffer endianness
 does not match host
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0
References: <cover.1773797056.git.balaton@eik.bme.hu>
 <40f0e42b1fa51bea1d9199eb0cd519a5b8da6fdd.1773797056.git.balaton@eik.bme.hu>
In-Reply-To: <40f0e42b1fa51bea1d9199eb0cd519a5b8da6fdd.1773797056.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.158; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a7-smtp.messagingengine.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

> =20
> +static uint32_t make_filler(int bpp, uint32_t color)
> +{
> +    if (bpp < 24) {
> +        color |=3D color << 16;
> +        if (bpp < 15) {
> +            color |=3D color << 8;
> +        }
> +    }
> +    return color;
> +}
> +

Does this assume that the upper bits of color are zeroed when bpp < 24? Is =
that
a safe assumption or could those bits be garbage?

