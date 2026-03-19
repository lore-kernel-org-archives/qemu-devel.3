Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8454E1088E67
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w33N9-0002AW-As; Wed, 18 Mar 2026 22:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w33N7-0002AM-FG
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:44:29 -0400
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w33N5-0005QP-AM
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:44:29 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id B6A247A0139;
 Wed, 18 Mar 2026 22:44:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 18 Mar 2026 22:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1773888265; x=1773974665; bh=f5etx1XF6gmJnr70HWS9fxPEelEVLZbB
 ZyDBzXr1eD0=; b=Ao0OBdZZ+vgjpUz33HLc6OJadhtQiH4AZZb4WyB2xNGwjeMD
 y2rjfeC65051ejaCOZpCVDzGSXa1b96oJIfhPd7fQ/i/HfeBomnZmT27Wq9uvmZ5
 IuhyIGIdxBBXZRQzeLkvFsN0eFwDsjXbz9qktL9glxfqIlCFBRq3cxnh8/D9+mNJ
 L129pqzC5MVY3bJJHSri75z0Cdl4bA2CE8+0DNGN6gm5Vuag6mwkDqB42dxHLraC
 6gh1h6VrNnhxPJlhkO0oa8rwuvnfoQJMAJkkZlOwq1WAtO5saOflUT+c892C8Cb7
 G06v3QiNoQIv9Rwd3pmOmJ/PcQlX11UvJpTFWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773888265; x=
 1773974665; bh=f5etx1XF6gmJnr70HWS9fxPEelEVLZbBZyDBzXr1eD0=; b=e
 msdQywep2jvF+KPekFiayNx/VFtAQwB9cerN21un9uRRHdSOzfUyR0xEsQj37gv9
 nJEbAnCYdi/gshgoNYiaXtMfPVSmwbivFbZcBTzUiCX3MJ9gfTc2t3pf+txJxfQI
 GclvmssU8BoXSe20LJ7HdaujSkF7zGbTGuWRE/w/An+AfYpacUCS6nyqm/VyEMkP
 zK5qVVA2t5MBJoWKb6u7BuX82voNhcMq5GY+J7NMPhPrtMildt2eLgzQo9ntZ0ty
 /wW+arXkeSyzPUlABZrxCBJfcq7zOpeHI0sQjbGXW9M3o69RIP+3Jauyexu9nyIK
 iJhepITZ8Ww8jm3hK1/Mg==
X-ME-Sender: <xms:CWO7aefIiOZ0OSBJMnYwRbU_B66w9AACB32zh6HZgf0bWg8p1_hZ0w>
 <xme:CWO7ab5VIot6VPkX-7OHTuSyQRacPNBCwLyLTfAw3DulW7BYi_Q7jZ6h1ClJeIjzA
 C1Qat8D9XOw4POy3zTEXc8X0HcC0iA5JSwufr1acSMrHeSlMtcMuQ>
X-ME-Received: <xmr:CWO7aZWQki5Xjejo9VyIJhB3R9GeCSXkn34iGlnxaGe_uth0LPYrqGioJYt1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehkeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrrg
 igvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgs
 mhgvrdhhuhdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtph
 htthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmhhuqdgu
 vghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehmrghrtggrnhgurhgvrdhluh
 hrvggruhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:CWO7aS7dluU2B64pTYqZfq9yN0cGq_R0uDgGIALZPpjwAmhvp2r57A>
 <xmx:CWO7acpP0Xx2fn-DzRt0sU3Q8hORQ7uS7AwPG9yrc_WxKZO3haEBrQ>
 <xmx:CWO7admTNnzg372TOGmW2BwXDD-vfu4IAdgpg3My5Dwx_88gvgGvhg>
 <xmx:CWO7aQNgJnQongAMRfLNHTEn43dpcWr-NvmhFclBjp8qLE5PzeIZDA>
 <xmx:CWO7aedPdLQObdkqhkQ2GnLfEmqALpS0R6KSr8nrdX_xqa0CKmkaF6-3>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 22:44:24 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 2f386ac8;
 Thu, 19 Mar 2026 02:44:24 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 22:44:24 -0400
Message-Id: <DH6EWQPXGV8S.24AJUL9J93QLM@jablonski.xyz>
Cc: "Gerd Hoffmann" <kraxel@redhat.com>, <marcandre.lureau@redhat.com>,
 "Chad Jablonski" <chad@jablonski.xyz>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 6/6] ati-vga: Add work around for fuloong2e
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0
References: <cover.1773797056.git.balaton@eik.bme.hu>
 <a96811f47b6ae3224e2b2a7761248622d6578e76.1773797056.git.balaton@eik.bme.hu>
In-Reply-To: <a96811f47b6ae3224e2b2a7761248622d6578e76.1773797056.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.156; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b5-smtp.messagingengine.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

> +    if (s->linear_aper_sz < 16 * MiB) {
> +        error_setg(errp, "x-linear-aper-size is too small (minimum 16 Mi=
B");
> +        return;
> +    }

Small typo here missing the closing ")" in the error message. But
otherwise:

Reviewed-by: Chad Jablonski <chad@jablonski.xyz>

