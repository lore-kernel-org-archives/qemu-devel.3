Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701B6EA8542
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 02:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzQTw-00015d-As; Sun, 08 Mar 2026 22:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vzQTu-00015Q-Sa
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 22:36:30 -0400
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vzQTt-000737-7o
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 22:36:30 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 600867A0154;
 Sun,  8 Mar 2026 22:36:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Sun, 08 Mar 2026 22:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1773023787; x=1773110187; bh=X4vr3y5P7uxElxeresXU7PPjABdWVi5p
 0gRn5cEe2Wc=; b=kgU0wogp+d7yj8G/pIupycfPSIq5I31jsx0KdVEFMHsFIWpz
 IOgBiQ3Ri1rdJZZH0Up+5kQkVZ0pkprfEfl3UeMj/G3Gw1o4/LKc+HUG5K+3SRiw
 eQxziDEnOLLkl5mu7WKWmlU53d4pRQclWaOKRCXcJTR0gN7llzBswGxx31rlwBCr
 0A5IxcJEnv2rOqsTZIeTuR71Rog9g1XGUzvp8CG72ggPkiQ0G0I6YBOCpYsIN07q
 OTVremgBnss0esu6LBOeQl8yZAUPGMrgQ6AK8GoOdq5IaUFunYxdBYEDOH4mY7JJ
 f01jN0FI8e57aM8SYf+vc/Vj0A6dKIA0uQpgzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773023787; x=
 1773110187; bh=X4vr3y5P7uxElxeresXU7PPjABdWVi5p0gRn5cEe2Wc=; b=a
 xyQamloF1STC2TrtP675yJy2J8/P+keZxxSxXPL2RdvTA50PSpr7fOidopswtgtd
 nSM3VXaB8thLQsb3lFygHGD0diZQUOz38Jid0XCH2DKH38v1qLk6FVNrOBQSCCRR
 k5VvMhmnAEoX7C1mAlqKVyFYCudQ0DkG6gvyIz0yfl4pPgiOxu6QYuaWdlNZeD71
 eMZj6RcktP/Ie1ooUITPXbCETzZ7G6AES+tVAw9Wz9MtJRprafI9ZKBV4foSgXn2
 zFvKihOsy+3k4kRw/GTmxwZ2Us5bTHcu5NYhnayqdwG0RH0/5S6cPEruLqtHe67A
 sgK9qeAc5AHTIiNtQdVLQ==
X-ME-Sender: <xms:KjKuaaE5Auf786XkhvJ5mvpZnr415Y7eqUc3_SnQNWDwtbfjcPG6wg>
 <xme:KjKuaSMWUjWs4oGNX3s7Y-lzqftmO9zSv9y0Ej7yVD8cK4u7oatxs56nXJzgJBUUl
 jRN8ObaX_aRhUMaEqb6RWDFxBz4PqgxYXgKE0TKc02GWD_kXdvCqA>
X-ME-Received: <xmr:KjKuacdxLdliH4m9LYyLR5ZlB3wxWk_7ndnHWI5AA8GxKhk-b2LBwC0iMe8V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeeiledtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkuffhvfevofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpeekkeekfedujefgleeguddtuefg
 hedvhfehhfdutdekffdujeelfeefkeegleejhfenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggrlh
 grthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhu
 rhgvrghusehrvgguhhgrthdrtghomhdprhgtphhtthhopegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiidprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
 pdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:KjKuaftlp0ckBZ427Yh-GRCJBnspjcsfwKV7N-LssAfcEQk47S8iqw>
 <xmx:KjKuadmqX8qKBtKLkMZpvDLZJYb739kwk9j5g4qVnfqsiCBxAS4qdA>
 <xmx:KjKuaRwOQ9CKZmNS_cR0rVQnBHGdZ1qRzdftC7OXiE2iuEvqdNTT_w>
 <xmx:KjKuafNxQ4s0yHOEZ3zbi9lBnufrGxTgX2_cAWZSxQgSIiF7YyTr4A>
 <xmx:KzKuaWrcdPAoafDZCZg4yzgPa42XR3-8hcYhAVQ2kx4j8SzRxUS5dRho>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Mar 2026 22:36:26 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id c293eeef;
 Mon, 9 Mar 2026 02:36:25 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Mar 2026 22:36:25 -0400
Message-Id: <DGXWH6QV4EVO.1TSVT5R0C2OUI@jablonski.xyz>
Subject: Re: [PATCH 1/2] ati-vga: Simplify hw cursor drawing
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>
Cc: "Gerd Hoffmann" <kraxel@redhat.com>, <marcandre.lureau@redhat.com>,
 "Chad Jablonski" <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <cover.1773009887.git.balaton@eik.bme.hu>
 <90b49357b6bf80bcf8962331575ffd16a96b706a.1773009887.git.balaton@eik.bme.hu>
In-Reply-To: <90b49357b6bf80bcf8962331575ffd16a96b706a.1773009887.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.158; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b7-smtp.messagingengine.com
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

Reviewed-by: Chad Jablonski <chad@jablonski.xyz>

