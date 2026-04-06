Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B94F46C53
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9m6d-0002p2-Sf; Mon, 06 Apr 2026 11:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w9m6c-0002oM-Re
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:43:14 -0400
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w9m6Z-0000wq-PE
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:43:14 -0400
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.phl.internal (Postfix) with ESMTP id C6176EC009A;
 Mon,  6 Apr 2026 11:43:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Mon, 06 Apr 2026 11:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1775490190; x=1775576590; bh=V8QtqT9dP3Wl6jQxRUvE+P1bcigP+AG8
 WfBqtn0IvCU=; b=EUOBoOa4AQixJsas3WazLEJi/RDHoslVFZmtAzmdDDH6+vXU
 VaBKYBqV8RJXmLg3nSlM6Og3IOZpICLhrZnKXvx6xz5lxtLYm/qvYtG03Ddy865T
 5dOJUTN4M5Xz5H5k3/dUm+6E+xJ+mir7rrLoj+rsOWJZmur1IDLHwe5G8GIqFxpe
 XzTX1BHidFJDYogfKoHOY8mM9XW68+NQmSf+/0+ehK0ckf7hK4wUjqQMhIMfg2os
 A54hKs1bMOOEzbsjRZSpTJAzdG6FnV5fYRXcfhnUgubNiIvE7velm4a3QlIeIF1O
 Yv2vafQidSUGLTEdm4gqyv6+ugYyLJFdXj1yTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775490190; x=
 1775576590; bh=V8QtqT9dP3Wl6jQxRUvE+P1bcigP+AG8WfBqtn0IvCU=; b=a
 Re2r2iIVF+eRoGSCBXpVOCs7GgGJipAvLH9netXVU+8quKyj2w2OwjASweWukD2+
 c68ns2C208FEJdAsHQPxAco71Td6XO/RruAfaGJDFRaspFbLQ2lRJ/dZeXIZwgV5
 tktvpLnNRQSCygQkw3UKVih9BZYUeDuPYDCf5BJ172lS4ZUCTB0hMQXfjx6ouXA4
 mSC8QHhVieHSXVJFXAGRdfnX1JDY77NX0bqlWfXig6NTrpIlJIMxXG1yqc1LMa4i
 2dHw2ggHdlYmnx3K5rHefvhFo8b8jWqv5xpqUp024rsL/4K/UKHDHogikemkEfGj
 JknevdbGfKmpTgK0RdSFg==
X-ME-Sender: <xms:jtTTacY5N7c5AqkgajLwV5YnqBI0h1-GzCzP3fzDjnvckzP5aWtbrA>
 <xme:jtTTaZqBwZUQahENq2bJs5Xlzthzpj-4vHKggVEBTYY8Ft0DPFnQQ--esUgQjLzGc
 _QqR31JceVAc2Kgji0nUpvzLCFWqsMHEyKnqaoc4DEuzjtkIWCv9_I>
X-ME-Received: <xmr:jtTTaZNmEI9c13S0G9ErPvcn9BsC3YbViEIXuT_PqGtrb05D1xG9b40sGGtT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukeduvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
 cuvffnffculdejtddmnecujfgurhepggfgtgffkffhvfevuffofhgjsehtqhertdertdej
 necuhfhrohhmpedfvehhrgguucflrggslhhonhhskhhifdcuoegthhgrugesjhgrsghloh
 hnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepvedukeeffedtkeekgfdvgeduheef
 ueegheeftdeuheeiheeggfegtedthefgheetnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhn
 sggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilh
 hmugeslhhinhgrrhhordhorhhgpdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhi
 rdighiiipdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprh
 gtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehkrhgr
 gigvlhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllh
 eslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhurhgvrghu
 sehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:jtTTacosVz7Xba5R_hsc11dO9tmToEmImtg2p39UZJmgpJRuY903rg>
 <xmx:jtTTaWdiSJtfGeaPdGuQwg0hH2YeHbr6W5Rk4ZwG4cc3aftk1vKa2A>
 <xmx:jtTTaaTPe4FJJzRtCoxECM2siEICOalW9lhhtfey6wJJpDG9geY6UA>
 <xmx:jtTTaXYcT3XAnb1mcc-n-MEP95ECGZLL2dZMAxrUBSKtW8fuxEVLBg>
 <xmx:jtTTaa4ZRRzZ79a8psFdAHCaLM4CHymn-f4_xZY9lnV8K66cgwgxI_m_>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 11:43:09 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 0a444fae;
 Mon, 6 Apr 2026 15:43:08 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Apr 2026 11:43:08 -0400
Message-Id: <DHM6QSMW0WMI.3SJWY7F5RS9OG@jablonski.xyz>
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>
Cc: "Gerd Hoffmann" <kraxel@redhat.com>, <marcandre.lureau@redhat.com>,
 "Chad Jablonski" <chad@jablonski.xyz>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Peter
 Maydell" <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] ati-vga: Fix setting CRTC_OFFSET
X-Mailer: aerc 0.21.0
References: <cover.1775228029.git.balaton@eik.bme.hu>
 <2b8af6022aba06aa98a249ae67922de29d82d86f.1775228029.git.balaton@eik.bme.hu>
In-Reply-To: <2b8af6022aba06aa98a249ae67922de29d82d86f.1775228029.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.151; envelope-from=chad@jablonski.xyz;
 helo=fout-a8-smtp.messagingengine.com
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

I've tested this under X.org 1.7.7 with:

SubSection "Display"
    Depth       24
    Modes       "640x480"
    Virtual     1024 768
EndSubSection

Prior to this patch output is garbled. After, the screen draws correctly
and panning works correctly. I did notice a bug when typing in xterm. If
the screen is panned at all the first character will appear but any
additional characters typed don't appear until the mouse is moved. But
that seems unrelated to this fix.

Tested-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>

