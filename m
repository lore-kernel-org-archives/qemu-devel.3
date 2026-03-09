Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274B7EA854C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 02:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzPv9-00037C-JR; Sun, 08 Mar 2026 22:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vzPv7-00036t-FZ
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 22:00:33 -0400
Received: from fout-b5-smtp.messagingengine.com ([202.12.124.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vzPv5-0002fh-Os
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 22:00:33 -0400
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 862141D00082;
 Sun,  8 Mar 2026 22:00:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Sun, 08 Mar 2026 22:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1773021628; x=1773108028; bh=12T3J0h2KARTDT/AcyRA6eCuh4ma/nyq
 YA5dXyVut+k=; b=DPJ5xCDmMW8BpRuwgkGGeprYft2mlYk6Od9T3kbEd1AM4npT
 +dPdYjrXzaQNsDGl1+c64ZGDTQKP3cttXwFDXgH+6v8NAKFkM+2JwKM++uqt12ct
 1EuJjjWzfo+fsD6ioZAqfvhDZeeDB7UpAKTKad1/DLfj6v6/iBGDluDiHD3DynxB
 EM7w7XhQ8IhcQ01CnNDqVgzHyQP/nrWErduA2/sgd+k3MNC2hd9LowCnOsULP6QL
 84MQuB2xFVz0qFJp8Av0kLMjolH35IwO8l4XwSqevOlvO/IkX8ggORzAhwdxP7IA
 qyxzcPLuOLBQU0JKatMU9xgsIx+4zCP+wAWYuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773021628; x=
 1773108028; bh=12T3J0h2KARTDT/AcyRA6eCuh4ma/nyqYA5dXyVut+k=; b=I
 XRb249cL+O3zZ09Rpq1SnLhL1zxG8vCuf1nH13xu6GQHXGddP73mHpiMWN6hN53A
 bbtTUjNdKMEhqsy2QVlSXv93iZGO3YbivXkfqLjDV5GFc1Oc2d6g+HNLS5kRA6xd
 LH2TCZJh5h24l8cwWNGW/YhxZz7Vn9PFPPsNBYtz/zPXSmYA9Nna6aPxcnk9oOZk
 pJM1JdwzZhamtc/ZKcFwF+MKvkbuhOr2zjR/ELKazxrYoPBKNWb+ADJFCRhs7moc
 vnJT1cxSzOKI+ZdneL0Fb6X0vfvqmjYPIUB9D+7i81NXoEJQseqXUGKNR+T3wgaM
 qgDCiEYK0N+dRc8ITPe9Q==
X-ME-Sender: <xms:vCmuaS5ijjh9gkiiLT16I8bxqH6t5sdFOWkJC-D9sZ8mT6UQr2P0eg>
 <xme:vCmuaflirl5KufHxYGvlGFatVjh_99PRRngXkDlZjybUlbtF3j5C7re4Da5jqIyGX
 YzwSl0E9nHQM4mvE8NnQEaz2-F5tdM1JYIZzhJFB1JK5paKuQNzfFM>
X-ME-Received: <xmr:vCmuabQ0e3FgOTznTli2oMDTLEvKI2iU8SESiWHvsRF3ogC1SmmO0WQV6gSP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeeikeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhih
 hlmhgusehlihhnrghrohdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhho
 nhhgnhhurdhorhhgpdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomhdprh
 gtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhopehmrghr
 tggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsggrlh
 grthhonhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:vCmuaWGYrJSJE53d2_K3uA3AziKg7AJ7dJPpxX-bIORNbor79q8KWQ>
 <xmx:vCmuaYHWRVyY0Mt0ppNb5Pfz1iMHiXb0TPMfEiX9c6KVZwKGEM6V3Q>
 <xmx:vCmuacRZkDR07OfP2RGDe4MKJiLLrPthF6OAk1DoAplJlZSmSjToBQ>
 <xmx:vCmuaRLH1Nicnr4nPx11_Je1zFDrRWM6nhg5vO9j1MF8N1SgqujzBw>
 <xmx:vCmuaWY7gZFuQBL5pRvpNyLtWEXf9iX0NdbPNwc2XLjQBphRrGUuYC-a>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Mar 2026 22:00:27 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 66ee7c92;
 Mon, 9 Mar 2026 02:00:26 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Mar 2026 22:00:26 -0400
Message-Id: <DGXVPMQPMXN3.3QYKWHOQKKS72@jablonski.xyz>
Cc: "Gerd Hoffmann" <kraxel@redhat.com>, <marcandre.lureau@redhat.com>,
 "Chad Jablonski" <chad@jablonski.xyz>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v12 0/9] ati-vga: Implement HOST_DATA transfers to
 enable X.org text rendering
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0
References: <cover.1773020351.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1773020351.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.148; envelope-from=chad@jablonski.xyz;
 helo=fout-b5-smtp.messagingengine.com
X-Spam_score_int: 24
X-Spam_score: 2.4
X-Spam_bar: ++
X-Spam_report: (2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_NTLD_LINKBAIT=1,
 FROM_SUSPICIOUS_NTLD=0.5, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
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

Thanks Zoltan! You beat me to it. This fix looks good to me. And thank
you Philippe for picking this up.

