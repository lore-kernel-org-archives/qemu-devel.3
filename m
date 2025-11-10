Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FAFCCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 20:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIYJb-0006ix-OC; Mon, 10 Nov 2025 15:16:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vIXxW-00029b-Hn
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 14:53:50 -0500
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vIXxU-0003oq-Nd
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 14:53:50 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id BC40D1400074;
 Mon, 10 Nov 2025 14:53:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 10 Nov 2025 14:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1762804426; x=1762890826; bh=UAfCxtzxyQLHmk6jy0uNdW2OnccBEC6n
 LMJwTUn+shw=; b=EibRjmG+zIq/31XAAsvJfL0iffTvjdtHTncqlXk4Ft/0tkY+
 4tVEsByEz/TK8SSuDAi1N72u+bLrUiDkEZ2FWET07L6Ja1DIKscEupuSfjPit7dS
 Osuh/RMEi2BdZQpAUcmjjqNyV5bQkeDLAe2medp1Pg9RNWjvOyBKrtfSgYuOKEjp
 pmiNysqj5buUwz6wisv6m7Yq2DzN0v3T3/hFf3TDFfS2L2h7XfwaxdGVQZ4jvCz5
 w/xvGnloR7bn+Q94HZXOf4Kd01/F05sc+/CLeYFQFRjv31RE8zTRTcb4A/WFIr6i
 SZgsPCpI2vXPbuBJKnA9XdOLhbM0XWITGbGsIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762804426; x=
 1762890826; bh=UAfCxtzxyQLHmk6jy0uNdW2OnccBEC6nLMJwTUn+shw=; b=0
 aXV6mqxBKbgopTMyoeSxdn0gCL4ZBcyXHH8UsuELtlwjDv4mGeUmUEDiPYBtz3rb
 kT2koY7cWGAWYtFVMUJ9yg25O0yJltDTOg0Upy2aNMI7l65XXjL/P0sGRtjCzX/2
 UD13rudvksu/Qe3Yggu78SSONrk17LHyTIL32cTuzSbSf3iNVQI5GgDOJfGaz5JZ
 nD9O9C8Wyiwd6h6/EckvgU7O2mp9H10f8HXb8AdnIF78ZkCj0qf5tG3Dc+PBP53W
 b8+CMu5WahdegQH5PHjmtFEnZ7dVWxNujAQO/26Qj6Jcc5My/52grk27yyuHZxez
 lV7E0sF6nmC7RYZQNO6GA==
X-ME-Sender: <xms:ykISabtjRZ8kT2G0Zhjs1nOTid5HV73lfv8oe_HgGHsg8rL47lo3_Q>
 <xme:ykISaT5wW_RicfHIIYggsaGag9EF3rfycd4_8U_soJxQ0rnEYeANEGqLletYFdSfG
 buQuH2M1jIY5rgEpRV8BnFcHTjO2XS6Ju9zQnMg1gb9VD-aEUNnUg>
X-ME-Received: <xmr:ykISacKGbKOxv-db3oU3FD4ze3mAYKaeVa93IuKACa-uSLafKfyl0ByCmoCJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleelvddtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmh
 huqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegsrghlrghtohhnsegv
 ihhkrdgsmhgvrdhhuhdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihii
X-ME-Proxy: <xmx:ykISaT4w6nU9sk7AjdzABdg6PLajrksPwV9Llk7qAQZ1lSSdOGNtiQ>
 <xmx:ykISafy5l0PGK0iO5fGabr9rd6YsErl-wgt-pWh-Tz13EsCv1IyAKA>
 <xmx:ykISaXYZlB-UBIKq2GSzXPejxlOjJmYAKNjwgDi_vXpnUaSwE0t9iw>
 <xmx:ykISaRTlibvgRbnf7yHPaGON1MzB2fFp6mm_fE8sX-b1LP2Q5EvAOQ>
 <xmx:ykISaQktbnCuoyBDGdvUxROd3aNnKOQLiP_FmlIS7CEo78hL9691x6l->
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 14:53:45 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 5d5a1e07;
 Mon, 10 Nov 2025 19:53:44 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Nov 2025 14:53:44 -0500
Message-Id: <DE5A0KUARVWT.3RSORF4A7409B@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 5/7] ati-vga: Implement HOST_DATA register writes
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20251103033608.120908-1-chad@jablonski.xyz>
 <20251103033608.120908-6-chad@jablonski.xyz>
 <441b1bbc-3432-680f-80d7-09a256a62436@eik.bme.hu>
 <b92ef3bf-affd-6a74-6b05-581c6d510e61@eik.bme.hu>
In-Reply-To: <b92ef3bf-affd-6a74-6b05-581c6d510e61@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.153; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a2-smtp.messagingengine.com
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

>>
>> I wonder where the real chip stores this information?
>
> I don't think there's a separate buffer for this on real card and the
> command FIFO is not long enough to store it so it should probably use
> vram. But how does it know which part of that can be used? Maybe you coul=
d
> write some pattern into HOST_DATAx registers (like 0xaaaaaaaa, 0x55555555
> but longer than the FIFO to make sure it's not staying there) and then
> before writing HOST_DATA_LAST look for that pattern in vram to see if it
> appears anywhere. Maybe some register points there or the card has some
> memory management I don't know about? (I don't know much about GPUs so
> it's quite possible I have no idea how it should work.) If the pattern is
> not found I don't have any better idea to find out how this should work.
> (We could keep the separate buffer in emulation for now but I'm curious
> how the real chip does it and if we can emulate that.)
>
> Regards,
> BALATON Zoltan

Hi BALATON,

You're absolutely right. After spending some time setting up a nicer test
environment I'm able to confirm this behavior on the Rage 128 Pro Ultra TF:

write HOST_DATA0
write HOST_DATA1
write HOST_DATA2
write HOST_DATA3
-> Data appears in the framebuffer at the destination
write HOST_DATA4
write HOST_DATA5
write HOST_DATA6
write HOST_DATA7
-> Data appears in the framebuffer at the destination

The card does not wait for HOST_DATA_LAST to flush to the destination.
So it would appear that there is no buffer at all or even a special area in
VRAM. It's looking like there is a 128-bit accumulator which makes total
sense given the architecture of the card. I'd like to do some additional
testing but you were right to question this. I'll address it in patch v3.


