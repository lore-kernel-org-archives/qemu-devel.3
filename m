Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B44F54ABC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52aA-0007o4-C7; Tue, 24 Mar 2026 10:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w52a4-0007mP-38
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:18:05 -0400
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w52a2-0003Et-Ce
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:18:03 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 41665EC0129;
 Tue, 24 Mar 2026 10:18:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 24 Mar 2026 10:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1774361881; x=1774448281; bh=3wW12ktOK6jWJ/8EdMjm9o2rkpq2mgsc
 ALbbW8t2JVQ=; b=lvaVE4hLI9YV/tM0OKEZ2/AEUkBEU6t4wnuvH5WZFE75sWiq
 e6QKs4+Mnm3jWRynSphCF/GAZY93ldbes2n7J0r2mXH76IEPPmX6NIa1yBn67wVt
 HQg2MkftYb8+wRdCqws8l61+L9Aocg8/8tpxTxr9Q9RlcUYCNGZQ69Pv7KCe9VOW
 7gQ4rdYCGsJYWC3GgREqrtgzRUjmHcpSNXIeYAKO6hTXfVadW8RPBaNQVaWCQSGn
 lSipfVHgpht4Y3gdQziDchRSh4PLvHDG7SloyqJpPQ4E9GZ1lM50sk1v/ugtn6Lw
 eFiSnSoncQLgeYEURsoxNkoi5ujnA2odfoHugg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774361881; x=
 1774448281; bh=3wW12ktOK6jWJ/8EdMjm9o2rkpq2mgscALbbW8t2JVQ=; b=g
 90Ele0J2IvpApkyLZyGbeAniLAX5baIQxL3MWkA4TU3OA9IFymbzUXCh+TNbtqc+
 9smNUXhAveAZgIldQQ0In/rruuTnhWsGJdhe2lmH2NLS0vpfHbTBXgxj/YzB3SZX
 9Jt3NxVKQKq4glX2f9dXhReDJazEEy9nwZ0KNBIIo1R7LKxhUtcVY4BApYAcfEz9
 xPi4Pr+XdQOXAH7PId/jU9mUQ7EgA0FNt6toMlI1SibSGk1ZM2ztGedVUngWWFe6
 OEQ501bWjWIpUqezco+eagfFP70Bnv+M2vYOlEYMqH++TLz7vwxbb5zR/6iCiJNO
 D+M3Dt4ZiD7K+7GtZeILQ==
X-ME-Sender: <xms:GJ3CaZ7906e_nsM_xEYsW2q53bEctmnY9yiGJzCC9_8tGc5H5ogPXQ>
 <xme:GJ3CaakxOLS1Un2sduJF9ub9vhLfnu0rqVjAHL_6LEy_EKbXxh0MqsD_ur2YIjlXy
 8pE-razMDghBs0mA57nQtw5JleTCpx6OYVY4w_HDFNE0Yw6hlc3bHs>
X-ME-Received: <xmr:GJ3CaaRVGtdpGnovzgIEms94QzBcCSBn7Xj_EuuFJ8ib3Y6-XMCHcs9evknL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddukedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhih
 hlmhgusehlihhnrghrohdrohhrghdprhgtphhtthhopehkrhgrgigvlhesrhgvughhrght
 rdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprh
 gtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhmpdhr
 tghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepsggrlh
 grthhonhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:GJ3CaZE-RU7DdOK1uyDx3U0rkzGrXES63BUXTeVIdWNURSTJdYBIsw>
 <xmx:GJ3CafG401uhKk3trnWOyCVe5fSdgOemo7XDHVdOSxQT_YFFSj3xnA>
 <xmx:GJ3CaXRjqlz21VRtOh2pxszeEwqdwrvMcYdd1gz8QVQybX2WG-1XsQ>
 <xmx:GJ3CaQIH397I1Ch5uIN8J8T0H7mtOyXgwPGfxvcrTZYoGDuwFtj5MA>
 <xmx:GZ3CaVYyJN2Q7rvJjSSUJGVbqhSedFPVCXbmh7oPqidkBpBfUYmSYfR5>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 10:17:59 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 09ff8c9e;
 Tue, 24 Mar 2026 14:17:59 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Mar 2026 10:17:59 -0400
Message-Id: <DHB2SIE9XM4F.38ZR2LJ2F670B@jablonski.xyz>
Cc: "Gerd Hoffmann" <kraxel@redhat.com>, <marcandre.lureau@redhat.com>,
 "Chad Jablonski" <chad@jablonski.xyz>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 7/8] ati-vga: Simplify pointer image handling
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0
References: <cover.1774110169.git.balaton@eik.bme.hu>
 <b9de530074b954d661a0eb9b8b4ad82a66085456.1774110169.git.balaton@eik.bme.hu>
In-Reply-To: <b9de530074b954d661a0eb9b8b4ad82a66085456.1774110169.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.146; envelope-from=chad@jablonski.xyz;
 helo=fout-a3-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, PDS_OTHER_BAD_TLD=2, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

>      /* FIXME handle cur_hv_offs correctly */
> +    srcoff =3D s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
> +             (s->regs.cur_hv_offs & 0xffff) * 16;

This is pre-existing (and a FIXME!) but do we want to be subtracting the
horizontal cursor offset (s->regs.cur_hv_offs >> 16) here? I think when
it's non-zero it would mean that the first row of the cursor would be offse=
t
and rows would contain bytes from the next row at the end. The way I read t=
he
register reference is that the horizontal offset is the number of columns t=
he
cursor is shifted. So I don't think this would affect the source, just how =
it's drawn.

> +    for (int i =3D 0; i < 64; i++, srcoff +=3D 16) {
> +        data[i] =3D ldq_le_p(&s->vga.vram_ptr[srcoff]);
> +        data[i + 64] =3D ldq_le_p(&s->vga.vram_ptr[srcoff + 8]);

Is this ldq_le_p correct here? Wouldn't this cause issues on BE hosts?

