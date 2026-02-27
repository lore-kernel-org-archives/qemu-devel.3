Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311EAFEFB5E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 15:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvzqi-0005bN-Lu; Fri, 27 Feb 2026 10:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vvzXh-0008CS-ID
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:14:15 -0500
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vvzXe-0004oP-Rq
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:14:12 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 87A4A7A024E;
 Fri, 27 Feb 2026 10:14:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Fri, 27 Feb 2026 10:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1772205246; x=1772291646; bh=xU50X1Af8SHLbP1FxYKWvdyBhJ3V2Gcv
 iRZgUbrKLRc=; b=j0rHUtqcYRB9mMeY3osWLfpFPy0Yh6NZOYvjnK0EIds5lSt8
 XZnv611WVwwtpTltICR1loq7oajd4b5DaQFC7ZIy6aPIgNUYD89OGUHC3UymLaqI
 AmK4HM3YH6CytS/2Dn7Kwzv7WIJ6sHS5b05v7FdvyuLdCqtK7RItYA/znami4Pm4
 i8XZgQ4d+IslOSYda0ReWbICiZtSiROiosJB9RF8iBcDyLx8GrjUGDXZ+bX84bZw
 eH8OUFQuV0ji/bqYO8KY2Y5TuLl0jQOIYrNLz1v7CmTkw4/CHjdL3NiTpNe3pl4w
 d0nzJihHvOzpwcBtOAO409yFoAKTN+yjkfPOMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772205246; x=
 1772291646; bh=xU50X1Af8SHLbP1FxYKWvdyBhJ3V2GcviRZgUbrKLRc=; b=Q
 epg3XbGqmAZ0Lo7o7bEjQC97lJ+yMHoDFw5flN6MPyunLshzNBgYj8oc01llXtwE
 fPtS4sFw+4PCOPdg8hywBZrO5v818nIXS2RcUoBrPVcOg/j+6qHd5b534c1Uun+x
 S4qBuVMXuXCp6qM0JPSXy125qBYq+sjrJdhp1D9wpAdClBUQAZ1Vk+o3vBMPxsso
 7UHIuPjHA0poeOb8QRwEILv4SreKpnZNIMTEAKz5kzpQI+dQvo7qBShhyKN0MLW6
 ZTA/VW1C/En6nbt5SV2REG6efEWoP/0wILRpxrh0mwyQFnHro6VqCxAFPZ9UXB6+
 +mdWtSQYb3X45I8cO7kNg==
X-ME-Sender: <xms:vbShaU9TBcs4NxJynswKHYChTawIyORBW2xJ1-q_ciGBef7Ndph17Q>
 <xme:vbShaUJqwzoaanYCr6M6AVaKXot_DUGDMFwgjunqseOxMfWIeOliEznQXmoXXBSnj
 eMvgQv9sJACyR8xoLUTWboqCYbzm1axgY9vfWHZ2sns_bbxFcf7NDE>
X-ME-Received: <xmr:vbShaXaSAfw_TIU_gGsTPZ73vuZgY_x_9fHCT4KeZ81K55w5GtH43jAWZ9D0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelfeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvfevuffhofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpeekffekuddvtdehjeduhfekteet
 gedvfeffieeugfefffevheeggfdtkeeuteekteenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrg
 gusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepsggrlhgrthhonhesvghikhdr
 sghmvgdrhhhupdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:vbShaeLj0_fNDgKcY2UsOVAJgRKHLLBrqMGfyI0xTz_UcqhD6G7wVA>
 <xmx:vbShadCOrl7R0C7Vcskd26tD4oTMjZix4QYKSX5YjulvW4TMjO3APA>
 <xmx:vbShabov8zbtUbxDZrsCOhFtINYP7YSRti1GQySRn3bKMgGH7fA93A>
 <xmx:vbShaQh4t5t1v4qmWA7yvwHriAusaD_ffk8wOw_oSqMOLw7-nGeIDQ>
 <xmx:vrShae24C05vdJwWhGqnnjO8MrI7fyiqK-SavTfQtfIUriVMTKrk6Ie8>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 10:14:05 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 1b7463a0;
 Fri, 27 Feb 2026 15:14:04 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Feb 2026 10:14:04 -0500
Message-Id: <DGPUBU36JIT0.1NCHM4YPRQL8X@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>
Subject: Re: [PATCH v8 18/18] ati-vga: Implement HOST_DATA flush to VRAM
From: "Chad Jablonski" <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20260204164606.3425246-1-chad@jablonski.xyz>
 <20260204164606.3425246-19-chad@jablonski.xyz>
 <7757167f-fb29-2506-291e-90b1185b5384@eik.bme.hu>
In-Reply-To: <7757167f-fb29-2506-291e-90b1185b5384@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.155; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b4-smtp.messagingengine.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Feb 2026 10:33:50 -0500
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
> Is there any check anywhere that prevents a malicious guest to keep=20
> writing host data and write past the vram area? I think the dst checks in=
=20
> ati_2d_do_blt inherited from ati_2d_blt would probably catch that but is=
=20
> there anything we can check here to prevent getting there? Like stopping=
=20
> host data after the dst region ends and then ignoring further HOST_DATA=
=20
> register writes which is probably what the real chip does too. Also what=
=20
> happens if a guest just writes HOST_DATA without starting a blit first. D=
o=20
> we end up here with nonsense values or is that prevented somewhere. I=20
> think we need to check somewhere if there's an ongoing host data blt=20
> before trying to use that data. Maybe it's there already somewhere but=20
> I've missed it.
>

I did a deeper investigation on this and you're right the hardware seems
to set an "active" flag for the blit. When the blit isn't active
HOST_DATA writes are ignored. This will be addressed in v9. Writing beyond
VRAM I believe was already handled by a comparison of the current row
against the dst height and as you said eventually the dst checks in
ati_2d_do_blt. But the active flag also makes sure these sorts of writes
are ignored when a blit isn't in progress, which wasn't the case before.

But I did learn something new while looking into early writes to host_data_=
last
and how that affects engine state. I learned that the accumulator is actual=
ly
256-bits flushed every 128-bits. It initially looked like an early end of t=
he
blit was just drawing garbage or uninitialized memory to the framebuffer bu=
t
by chance I tried out some wider blits and noticed a repeating pattern at
256-bits. If ended early it just cycles through whatever is in the accumula=
tor
to finish off the blit! So that change will also be in v9.

