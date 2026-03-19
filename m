Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6865E1088E63
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w333j-0002qo-MW; Wed, 18 Mar 2026 22:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w333h-0002mN-JR
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:24:25 -0400
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w333f-0002MO-T9
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:24:25 -0400
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id D43B51D001B1;
 Wed, 18 Mar 2026 22:24:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Wed, 18 Mar 2026 22:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1773887061; x=1773973461; bh=OIWrAEQzcgltKWBLXPWtfo1gNPMhzT3L
 NeZNIz4wv14=; b=G4YiECRkFokBVZifBhVUhWvDVocfmKYWhs2M9IgQ4uyqAbaV
 eZ0t+JGAlIuU/2PNTpIGmMZzv4Z+xKM8ijQEmPGYXpfyjCjqrI75VLca+bvUw8ro
 cZt5Q77qZa252jXDX3RRmJoufEmQpCZLWsOdhgXRwZ13mF5CVjF6HG68zc50uUyV
 M2jE+6QuAMKFuUf4djtecXylM22mkKOyZowrufjjVLdv6NARxY91oscQ1tkvPxBJ
 Dy8S2pPPWRL2bvCoBP7EQZXXQ9LBXBekMWKuLLdyIpGrv3uql8qrUeshRJem3NmY
 +FsW1eQlk1x6NUY74B+888Sr20rC8FhXHPzxbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773887061; x=
 1773973461; bh=OIWrAEQzcgltKWBLXPWtfo1gNPMhzT3LNeZNIz4wv14=; b=v
 D07uYTmAGK/SXmrD+o9kujSGLyxqwnoyTMe8gw82zT7R6v0v+8bzMeONolVj6X4R
 0PtjWamhFNePzuXJ4q+shkYfNscqwLYhIBHnB7AvcdnIBjyb+wrXJkk53J6ycZ1H
 4bgvnyuP2XC+mLQn5F2QvMYbdGhC0G2OC40x6M282kQSXZ1YMpZJ5TMo5Xz64e7e
 9IMV0xcuYaa2653zNZ7Td7O6Xcn7Kh4x+1VWaRP5wFhsla9sHXaQv55geZV8zEDf
 qe7kv+e0IzZXF5SvFUqZJR5WVaIKqfAraCtwRNU7s/JJLV1KNG6tA/Mhn/O35eku
 ztoLPayseP/FBNZw0j0UA==
X-ME-Sender: <xms:VV67aXpOVFFhdh_QQjucGOqxJW57BZJ3FcwIz0yN5fJngCCGD7rZcQ>
 <xme:VV67aVVHUHthkdMAfkPn7cFhITG5RKNMHGO154DWocwfmYGLmvHsxFBfzZtXQjz1Z
 aQQY3Flfdcc0Y4mJPZTRZ4CWnDrX8bN17SJtvZ_z8vYKyIMEdU3TTPC>
X-ME-Received: <xmr:VV67aeAXZGI-omYFtO9szEQboP95hxVKrWW6t5c-RnNdB1vsi1C0cNOYKbg3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehkedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkuffhvfevofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpeekkeekfedujefgleeguddtuefg
 hedvhfehhfdutdekffdujeelfeefkeegleejhfenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhih
 hlmhgusehlihhnrghrohdrohhrghdprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhr
 vggruhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnoh
 hnghhnuhdrohhrghdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdp
 rhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhopehkrh
 grgigvlhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:VV67aR3afvidj0xq-ZeXfjr9BUB2CL6KWDWI3c0rik-LHcBwJ2UtAQ>
 <xmx:VV67aY27KmXe9oftlFG85IbgfgPtD6aId2Cz9ntXPdnv-JRnSeWnYQ>
 <xmx:VV67aeCn3jKwfEVArDUgaFY-7V7XyZUkPT_sVL98VhkFufUXGRABbg>
 <xmx:VV67af4wKcRrZeuHki_QOrSszX4KOQHc3KWEI9ly08qL1GPm4EBg1A>
 <xmx:VV67aewcZhxUsgIuV0tAdeTtQ-f2xR0qAvafq7lUEoNTjqjuk3dtuati>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 22:24:20 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id a74ac926;
 Thu, 19 Mar 2026 02:24:19 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 22:24:19 -0400
Message-Id: <DH6EHDCYS2HQ.1EFT0GB5D2L5V@jablonski.xyz>
Subject: Re: [PATCH v4 1/6] ati-vga: Fix colors when frame buffer endianness
 does not match host
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, "Gerd Hoffmann" <kraxel@redhat.com>,
 <marcandre.lureau@redhat.com>, =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
X-Mailer: aerc 0.21.0
References: <cover.1773797056.git.balaton@eik.bme.hu>
 <40f0e42b1fa51bea1d9199eb0cd519a5b8da6fdd.1773797056.git.balaton@eik.bme.hu>
 <DH633G213QPR.2EMRCN626JXVS@jablonski.xyz>
 <ec4a000e-cac6-01d0-a8cd-b21ef7aba431@eik.bme.hu>
In-Reply-To: <ec4a000e-cac6-01d0-a8cd-b21ef7aba431@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.150; envelope-from=chad@jablonski.xyz;
 helo=fout-b7-smtp.messagingengine.com
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

>
> I think to be a valid <24 bit color the upper bits should be 0 here. In=
=20
> practice this is called with register values where we only support 32 bit=
=20
> writes so the only way to get garbage there if the guest does a 32 bit=20
> write with garbage bits. (I.e. it can't do an 8 or 16 bit write and leave=
=20
> garbage in upper bits from earier value.) It seems unlikely that a guest=
=20
> doing 32 bit write would leave garbage in upper bits and if this could=20
> happen it's better to take care of that at register write not here so I'd=
=20
> assume color is some valid color for the bpp and the caller should make=
=20
> sure if needed. This function just expands that to 32 bits so we don't=20
> have to care about other sizes later.
>

Makes sense, thanks. Tested again with 8, 16, and 32-bit XOrg modes and
all display a gray background in fluxbox now.

Tested-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>

