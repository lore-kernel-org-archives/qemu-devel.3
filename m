Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED001088E63
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w337u-0007Iz-CZ; Wed, 18 Mar 2026 22:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w337q-0007HH-Uo
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:28:44 -0400
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w337o-0003vV-VR
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:28:42 -0400
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id 4301E1D001DF;
 Wed, 18 Mar 2026 22:28:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Wed, 18 Mar 2026 22:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1773887319; x=1773973719; bh=X4vr3y5P7uxElxeresXU7PPjABdWVi5p
 0gRn5cEe2Wc=; b=EeKPeeRJ+AAuMtl67cssmZ477SOhME6WNoihEOZXbN9D3vlH
 msF3xSyLZyObIV178JCfd/6wwJn8BuBw5tooj92c6TIZJxtJ+z3u23oupsRlomZ+
 RujTThR16Zc1ocq6A1GaceSMKvLWfuHUQZ5U22RactpYLl265enLX59dBDSV7qdL
 b8YFYBvUr7SUovorVhq8S9Kb/JuZwvsM5F287tzVznVbMif9ncH/RYvbnnJqPBvY
 bSSqai9lRW6gRlhrQqsMS0dYC/IUNigdFgvIqYGNgMrWo6r/jGR+E1yesfgmAN4i
 rggDzSXXz6d8FsWnp32BEfUKgGKvQdbInLhrUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773887319; x=
 1773973719; bh=X4vr3y5P7uxElxeresXU7PPjABdWVi5p0gRn5cEe2Wc=; b=L
 9sDmY34jWmcDR/rBBDvmG5MEQiHAF0cwjydllGey00XZXuDgbeLPK7UJi81dS0kV
 EJ19EQ4ablBCoERz7GIkUN/qg+C61k6UpWvZOIoHDSjIa4HaGS5Dd8DSzD5Fi0O5
 km8YfPZA3y/vQiYwESPbtHl5bSflQy+nwRLjdWnki+C5YQ18YzXmBRFFVpVII0dm
 ueyYFCEP0AiANdC1SijTr2ds1kh7ZkXVnFSkMWuru4ZFRRwy7kkWdSRG7QAIh6KC
 jnHGiW/XjlwoTi3MIV8eBy1v16GOAIKLiCWzfd+e2NYHLedA2MSKRaYusdQ407FO
 0RHDQ5wYlMjcPuDxFvKbA==
X-ME-Sender: <xms:Vl-7acJCRwxxgKq3xvx4p96wWHTNqQzcsPVr6NHBNhzwgud_XUZA0w>
 <xme:Vl-7af35mv5ntpgiqarCi_C_Ylwe9DovZB4UtL4x99j66vnRvMiHHs8JyL4eKXVFO
 RlL5lEzj2FireaVdUlqXwFwxecyUwF-buoQk-7GoBFyPw5JL0rD0YOB>
X-ME-Received: <xmr:Vl-7aWgZlchrDA83xPZb30IKyPPAFc4ZX4LOZa9CsLMaO2M4W_Jy3hs7kdF1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehkeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkuffhvfevofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpeekkeekfedujefgleeguddtuefg
 hedvhfehhfdutdekffdujeelfeefkeegleejhfenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrrg
 igvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhho
 nhhgnhhurdhorhhgpdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhurhgvrghusehrvg
 guhhgrthdrtghomhdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpdhr
 tghpthhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtoheptghhrg
 gusehjrggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:Vl-7aQWxHNzLpFUeymgLlZ5r308cB-pgxscO8Df8Y8U3EEnrHJ96gQ>
 <xmx:Vl-7aVWsU2ymx0zJfenYvR4yHZEic5UYe_P5ta0nahlDgi_wLMHfOQ>
 <xmx:Vl-7aQjdAHCwWDEUhfF3VGFzJx8QHFz9bJbQ5Mmx_kjfVS5m87mf4Q>
 <xmx:Vl-7aQbDWzi3efRKP54L0bqTYoFeVuXBmu7fFMGlDtPj0BxY70pl_Q>
 <xmx:V1-7aZqARe7uJKSwgPRbvTIhuGkHeOre5YajvwXlDJjk0TdbfCFYb3Ma>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 22:28:38 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 14fd1ec2;
 Thu, 19 Mar 2026 02:28:38 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 22:28:38 -0400
Message-Id: <DH6EKNXJHAFW.33AF7MQ5GKGMG@jablonski.xyz>
Subject: Re: [PATCH v4 3/6] ati-vga: Do not add crtc offset to src and dst
 data address
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>
Cc: "Gerd Hoffmann" <kraxel@redhat.com>, <marcandre.lureau@redhat.com>,
 "Chad Jablonski" <chad@jablonski.xyz>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: aerc 0.21.0
References: <cover.1773797056.git.balaton@eik.bme.hu>
 <3abba5651a31af2d40b20269e224c0dcec73fc9a.1773797056.git.balaton@eik.bme.hu>
In-Reply-To: <3abba5651a31af2d40b20269e224c0dcec73fc9a.1773797056.git.balaton@eik.bme.hu>
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

Reviewed-by: Chad Jablonski <chad@jablonski.xyz>

