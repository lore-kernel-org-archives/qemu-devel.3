Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6317EEB575
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 00:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vb6xR-0001ai-Nh; Wed, 31 Dec 2025 19:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb6xE-0001Z6-HZ; Wed, 31 Dec 2025 19:54:18 -0500
Received: from fout-b1-smtp.messagingengine.com ([202.12.124.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb6xB-0005CY-Py; Wed, 31 Dec 2025 19:54:15 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 762601D0005E;
 Wed, 31 Dec 2025 19:54:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 31 Dec 2025 19:54:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1767228851; x=1767315251; bh=bhZQy/5jBUzINhcePIt/xONoOqENNoVH
 /9JyJc/yobo=; b=i47NONSwBxW8Kw3BfDzlO7xfeexlLWukZ5J8ljvjzqxki9Jx
 6BGHIJmO/Hqmt5h5id3gqwJKPsqLpvofKc3ywCQWarBJAyafBaspzVmo8aretR2w
 z9QSmh6UmKRoLl+Bsa9blDD/E1W+gEkbtH9dPpHJKKJFT8/fKT0iYHlp3YVM9Si2
 Z4RA3CT7Ccw+imtMRB+YTSMTYtdbESA9ep9Ih2CxNfdIdcxN1wbGQ/9qsIjJR4TO
 zv8fHx0AHmWBiY24iR/5kHE8cqIdE/WhsY65EQ9RHb1fp7nd8ikZ49//N8WBp+sI
 zk6a/W95MKqxM0ubpjIIG5qDU3FyYedUP9U/QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767228851; x=
 1767315251; bh=bhZQy/5jBUzINhcePIt/xONoOqENNoVH/9JyJc/yobo=; b=E
 nG9uMl7ul/78ZiUu3n+7DWhVge/igGU8eQkVaas+GMNxaUeWfZ5X4BGZ2edHwgWi
 Xy/FK9sgehD4o2RPiSNxvtYiSOaL8YF8EdgKBXGgxaOL0jzsQD9A6P8yY3n725sX
 x7HVcID8a9XJXcVtPwxhedMwXUCy/BapxnlQWTlKvie/Y0mrL9K/6myBcO7//Na/
 hsi3cpGjHeeR61VSYrmsRx4Omom1XIX6TD6Y56IJKFvSvnb99VeI3E40McvuWxV9
 xw1zG0UWC8UAabladXGHpwl7kVJSrO5RrDwqxKEP8+g/icjDxqKQhXnZbTIbGZmT
 zzit9CS1EKjvH2BDsVFEQ==
X-ME-Sender: <xms:ssVVaTHucwmb8HHfOxvoljohTnFlBt_v04zhSIkehsyHe8tFmFBc7w>
 <xme:ssVVaXUxt6QTO6LfQ2N7dE0TzEWDxMRWYgcId5gpzwtspYHjgd5FJyR6b0mPVLWd3
 02R9Srdm_QG8Ibk6JYcXRSVErZpCcYXfboRZB8JLqdD8K1O65b00uA>
X-ME-Received: <xmr:ssVVaaI6NTRokVu99ZSIZvzaCmymSY1JyzSyTmfK71HQCfEa9ABW7x2075h6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekgeeflecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhepggfgtgffkf
 evuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfvehhrgguucflrggslhhonhhs
 khhifdcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnh
 ephfefudffkeffheduffetledvkeetvdejhedtheektefhhedvgefhheethfffkeegnecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrgguse
 hjrggslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhp
 ohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlhdqsghouhhntggvshdotghhrggupe
 hjrggslhhonhhskhhirdighiiisehnohhnghhnuhdrohhrghdprhgtphhtthhopegthhgr
 ugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhopehqvghmuhdquggvvhgvlhesnh
 honhhgnhhurdhorhhgpdhrtghpthhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:ssVVaf-Qz2_vHBl0LECJxfIdDC63E5CbSr2h1gqKSZVw7ZwM1EZVVQ>
 <xmx:ssVVaVIM-5F78jKwXDfPMqXrBdahnlls7YvNX1e-WLgnM2l-RXdLgw>
 <xmx:ssVVack4JHsm8rsIWgfTnxOdmWzrtbVBryKKHWfbyygqLDiKzIBDKw>
 <xmx:ssVVaRPXpyiqKxzoW2GscBMgeXJGVYmjtOs_LLqQmlByyfXNJ9tasA>
 <xmx:s8VVaZMwO-aP0DCx1Z_vyg5I6waey-E-wz-3yjF8ndAG0Sx2Z3z_StaO>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 19:54:10 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id ddd7c1ac;
 Thu, 1 Jan 2026 00:54:09 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 31 Dec 2025 19:54:09 -0500
Message-Id: <DFCUCDPY9DRX.3Q6NTWWVHI8EZ@jablonski.xyz>
Cc: <balaton@eik.bme.hu>, <qemu-devel-bounces+chad=jablonski.xyz@nongnu.org>
Subject: Re: [PATCH 0/7] ati-vga: CCE engine setup and PIO packet processing
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "Chad Jablonski" <chad@jablonski.xyz>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0
References: <20251231212107.1020964-1-chad@jablonski.xyz>
In-Reply-To: <20251231212107.1020964-1-chad@jablonski.xyz>
Received-SPF: pass client-ip=202.12.124.144; envelope-from=chad@jablonski.xyz;
 helo=fout-b1-smtp.messagingengine.com
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

This series was accidentally based on my pending HOST_DATA series.
Sending a v2 rebased on master. Sorry for the noise!

