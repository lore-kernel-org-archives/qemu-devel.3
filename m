Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64200F54AB0
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w51p9-0005sa-Kd; Tue, 24 Mar 2026 09:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w51p7-0005s2-0d
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 09:29:33 -0400
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w51p5-00021g-F5
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 09:29:32 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D40CC1400227;
 Tue, 24 Mar 2026 09:29:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 24 Mar 2026 09:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1774358968; x=1774445368; bh=X4vr3y5P7uxElxeresXU7PPjABdWVi5p
 0gRn5cEe2Wc=; b=Wb3fdy3GZLvN5x+iqUS8O2QmgMirrWo06CdKUjXkEkbjY04k
 Unisv5TeP1jG8eYLkF08fXCcF4T4iukNPiv6hpNakvydhxCbJryKMC4oNxFNpkIi
 aIwBubxDnIqDBFC8+grnHHmqGOlgjXB+QXU9FK0ztL1iXm0Srt/hSAq3EIx7zQE3
 gP/YApvYt30spgUb2KnSxoycZMgdlMR7qdz+sNvwDgsHwyhVBUZY06+qdhHBnvD+
 Jf8a30/bGyuNXvqpI0dvEBDiGQIKbDWLJSBoTxZCmz5+d9AL3UM5ec1Qs7IvkjHa
 3d/6nxEU6vWUjZas4HusTsbjP0XFBOqKQljXyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774358968; x=
 1774445368; bh=X4vr3y5P7uxElxeresXU7PPjABdWVi5p0gRn5cEe2Wc=; b=y
 qE5rvomF+5MDqKbbvacgHRh1JlsDZGUXO0eilspBZ9SajeWtoM3slt3QdZNMY8c4
 P4ebGJbSxaio8SeaJWGVQ7/hffQnRrH/QMO0KUe/1lEgPL5XeDK4L1J5FTcxR5be
 QW52nHAFjzFfPHzmtO3G31z+oyykv9Vj8OXEvXpUMy83hb8qXFgcgcT/uSBCrjOH
 ePP6a8DjfDe1W+vKdqCuaNYp6MWfvsfuF9/nz4mV49rK8OBFDJbLOLWVCnui+MJB
 VcnweQHd/545tVNMiIsvVq44ZJBDWKWibFHzI0bvjX49Hngo416Ae5yfsE1fOz9q
 B7J56r0Qmic7kx2y/en8w==
X-ME-Sender: <xms:uJHCaQBUHm3bPmIeoZvYolFx92lyyJn8ClpTJPw6S0ALz5Cry1gqIw>
 <xme:uJHCaWMF0xyzM5gNdnVGNo3Q3-EPNkmdI-PI8oZAKCqVbQlDJP1PcGbs35wfJkcOP
 JQaSV-G39dTRd5-9Bd3hRpHsgPuBNV8ege7LOtOlICa7mfssQlqt_Q>
X-ME-Received: <xmr:uJHCadaXt_bZUmD0SQByhge5S-Vj-wCFTBQFOvq5YkXM1-WlIgzdiawLWP55>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddujedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrg
 gusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgr
 thdrtghomhdprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrg
 htrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdp
 rhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehphh
 hilhhmugeslhhinhgrrhhordhorhhg
X-ME-Proxy: <xmx:uJHCadtZy29DpdbUnpDbaO9bjV10ViZbXJ_nvVNdNWSBWhG02q-zvg>
 <xmx:uJHCaXPTqXKZ0HT9-2f6d-czfwXTBmo6tnMM5X_eEy86rxlJZ-WrGw>
 <xmx:uJHCac54fJ1T5IsuO2L9YWP2bYI6lRW5bB3owrlQBdtv0Cg-YXRCgA>
 <xmx:uJHCaVT6ePIGgaM7Hrw2P_AP7m2_WIOrlhu5bR50o8yDSAxt-Ns9CA>
 <xmx:uJHCacirsHAVti3BNs1HiqxeB7O0xLa_nIlXE3pGdP-mYqOwxM3SQz_u>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 09:29:27 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id c108b180;
 Tue, 24 Mar 2026 13:29:27 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Mar 2026 09:29:27 -0400
Message-Id: <DHB1RCHC2VHE.23RNH0BD0ESCI@jablonski.xyz>
Cc: "Gerd Hoffmann" <kraxel@redhat.com>, <marcandre.lureau@redhat.com>,
 "Chad Jablonski" <chad@jablonski.xyz>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 8/8] ati-vga: Make sure hardware cursor data is
 within vram
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0
References: <cover.1774110169.git.balaton@eik.bme.hu>
 <2ecf42bdeb96a4206b27dc39b3ff13cc8a6190d0.1774110169.git.balaton@eik.bme.hu>
In-Reply-To: <2ecf42bdeb96a4206b27dc39b3ff13cc8a6190d0.1774110169.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.156; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a5-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, PDS_OTHER_BAD_TLD=2, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

