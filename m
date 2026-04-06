Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD46F46C53
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 16:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9mXF-0003vB-Cs; Mon, 06 Apr 2026 12:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w9mXD-0003sn-E5
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 12:10:43 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w9mXB-00056F-Ip
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 12:10:43 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 0F378EC0387;
 Mon,  6 Apr 2026 12:10:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 06 Apr 2026 12:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1775491840; x=1775578240; bh=X4vr3y5P7uxElxeresXU7PPjABdWVi5p
 0gRn5cEe2Wc=; b=h1U4kv2/3+hgwvDCZsPhvhsa4K4KOUili6qUjBcAWbZGq6Dv
 jBL9o1exeicy0XBKTEjo1BGEq78uDZnjUiMZWMqToc7CaeywO5lTy0I0nzFzat4s
 D9T2055JI1UjMJI0ZoIfLtzeMBXOpAX9Ax5tYpbxzllRAoI2An+BM9ume83Kg7+d
 Th08/BzwxpDTFW16ugcPzsLl632ep/mc05q4iZCfcYJroXSqHcNCG7/hRwFWO6YS
 1fhyODmbATJg63ayjhopX3UfZaP+5YV/YRt0ykMgp4P2Z+UFY6IbQE5gfPhK/M7h
 1s8GQOhT2rPcDCkAWYh0zsVvz0s0oF59vleHmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775491840; x=
 1775578240; bh=X4vr3y5P7uxElxeresXU7PPjABdWVi5p0gRn5cEe2Wc=; b=g
 8ht8f+DtzfLftMAUXifvbZhQJp8LKnZRXUy8BmWW35sB+c2jfnmYI8x512WR7BTf
 T/LMhOwRekZm/eljehgsjQUm6iP6y5UCgI2p7wBzfZh62//OMGmLoVXVz9aYkG9R
 NFGz2EF9AN0mOqYEFHew0IpSl2NGIpjd+m6ASNjMtfVfHDoPagTIGhCKADEFTs05
 PBR9oE3usvrybBjR7hk+WIgt1UkE4RbJi+johJzFnPK56Xmw96AvgMUOZ4KBBHNq
 1ehANMEjklYCzwOokytBzta3VQ6edzcaOh97Zi9zHJD8yFklCbf3CK9kBawyy6G6
 B6yEVuL1IqM8t5ZntK1eA==
X-ME-Sender: <xms:_9rTaTKVzOhlw9S4WYzzjgoLba2hcn6QgqykotyWCTBFDyBlOLGXvg>
 <xme:_9rTaZZ2DNK29q7_jORd1pIy-Nsv8kYqTFNLpfvA-udRA0tRPMwrC5gtVFdqvMLRE
 S8EeBkapC2DPm-Mam7agtZzPMRTs2waFj2zxKKmoUjUUEZh9Dfwd3M>
X-ME-Received: <xmr:_9rTad8dZfPFDVjk4KQILDD0kRHz6FEHwV0JedDUC2stZxesqWzMZBYoJZGq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukedujecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
 cuvffnffculdejtddmnecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdej
 necuhfhrohhmpedfvehhrgguucflrggslhhonhhskhhifdcuoegthhgrugesjhgrsghloh
 hnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhephfefudffkeffheduffetledvkeet
 vdejhedtheektefhhedvgefhheethfffkeegnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhn
 sggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrghlrg
 htohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhr
 vggruhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrth
 drtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhr
 tghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepphhhih
 hlmhgusehlihhnrghrohdrohhrghdprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhl
 sehlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:_9rTaSaAJ_XEorOWdrTXH1vn9CTNg9iTSG3ZQ8KJO3EDG5GZWcpoqw>
 <xmx:_9rTaZOIsD1vhS42RwKY_rOkyn5xKzRG2Ngli-L1Pr4BEzu60m5e2w>
 <xmx:_9rTaWCYr5KqD0t2MKwWXS_RMvRYXlVgGtogxHfDyJfyAW-0SWDU0g>
 <xmx:_9rTaYJ8BGQOK1hA6i63g5XunxlxMhvIK_gVVEuJFHxORYTfcc3xOQ>
 <xmx:ANvTaYrWKsORiYfeRDD1dBJhUd4q_UHZY84NRIBqFGziOFcwf5SlHUXt>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 12:10:38 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 96ba9925;
 Mon, 6 Apr 2026 16:10:38 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Apr 2026 12:10:38 -0400
Message-Id: <DHM7BUEDLA6O.2FQIGTBT8650M@jablonski.xyz>
Cc: "Gerd Hoffmann" <kraxel@redhat.com>, <marcandre.lureau@redhat.com>,
 "Chad Jablonski" <chad@jablonski.xyz>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Peter
 Maydell" <peter.maydell@linaro.org>
Subject: Re: [PATCH] ati-vga: Do not crash on 24 bits per pixel
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0
References: <20260406012031.335A0596A24@zero.eik.bme.hu>
In-Reply-To: <20260406012031.335A0596A24@zero.eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.144; envelope-from=chad@jablonski.xyz;
 helo=fout-a1-smtp.messagingengine.com
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

Reviewed-by: Chad Jablonski <chad@jablonski.xyz>

