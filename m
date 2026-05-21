Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89137CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 01:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPsFi-0008Di-7R; Wed, 20 May 2026 21:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wPsFY-0008DT-DO; Wed, 20 May 2026 21:31:00 -0400
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wPsFV-0004GJ-6f; Wed, 20 May 2026 21:30:59 -0400
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4B81014000EC;
 Wed, 20 May 2026 21:30:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Wed, 20 May 2026 21:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1779327056; x=1779413456; bh=X4vr3y5P7uxElxeresXU7PPjABdWVi5p
 0gRn5cEe2Wc=; b=VWGkJL+S1ickipz/WWFTIQdeFwQ7hwl+tDkaqIL9o2TtN4DX
 TdnvIP8YuRh9FYdZD5Pb9T20XwBOlnXBq4Az6bYSmWKJh8Mc93OItnLFP7L3A3Az
 FOmSNy7DkzutQIA9GNfz6Er9ianv4+zwgSazaFEKbLE+DVsO2x9xbfRKLXLaYxhs
 b5FSBnqJyTHfoWVWm4zO7R5RZLF0nGkOjF6RpBHj+XZ9M1AangkyJA1Wge1tmX0r
 doQXEjOxRib6tckIXQVGqwbItljJL/YM7HW0DP6XV6z43p+Iu0y8T8MtnckHWw9o
 FlVwjW0P22zf5YXVKFBSUAZGi7PpFN8SXiZsPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779327056; x=
 1779413456; bh=X4vr3y5P7uxElxeresXU7PPjABdWVi5p0gRn5cEe2Wc=; b=M
 DVu4JbdPnQoFQ8/7enkEgmxdpKjp7Eu/I8yjHOYUdh78j2IwuLtgL8Ei26ogQDR1
 rk3Y8RHy6qVa+sxtPVfRc4Fi+d5+RdaxGdU4OBBHdXaK5Nq/T+/BDI1z6tRhjDN5
 VUGAXOTwB8LUII3GwcI13Mdtl+hua1OERyfQFV+KcpsSzTH6cDbyq57hczwULIt9
 pCAIOrayo7U8Lsb8XeIAqi3O7BDvKBZbjP18HGsBODcZ+x9uulGS/x1dZPNmAVOJ
 JdqfL46YR3yR+dRjy6FemQrK9zeRiCFbxdK1LtegfBb0fxQ4HPfsRuvGxxPW7Taj
 M9cUjM64ZPVYZJsVCIx9g==
X-ME-Sender: <xms:UGAOat5FWFubc3OmAJvkb0JRpGRc0oHSaH7ryBVVpuo6WfkweDxU_A>
 <xme:UGAOatI30R72_pb9wUtvFF_N346fp4HQOygpGrnSuXhgXjICFA77IHibtdTDuvhOz
 ADsc-OyvJ6ZiSK0B0iFgr4apc7SjJwQlu3XRjlCwmSeMQ5qVHtVMAA>
X-ME-Received: <xmr:UGAOamtMF5RmllzJjvjOnH6AA98rgUuSORUG8IB7PTozKN4KOIu72hD9IUD3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeivddtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggrlh
 grthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtohepphhhihhlmhgusehlihhnrghr
 ohdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpd
 hrtghpthhtohepqhgvmhhuqdhsthgrsghlvgesnhhonhhgnhhurdhorhhgpdhrtghpthht
 ohepsggvrgduvgesphhrohhtohhnrdhmvgdprhgtphhtthhopegthhgrugesjhgrsghloh
 hnshhkihdrgiihiidprhgtphhtthhopehjuhhnjhhivgdrtggrohesihhnthgvlhdrtgho
 mh
X-ME-Proxy: <xmx:UGAOasIZ58cM8tvz9t0BIbrFjd9uUar4k1qV7GFtfl5XlTnR5cN3kA>
 <xmx:UGAOav8XFwEgNXnhRnu3N-ZKSURGEWbCcSfzlM8eLfWaqxRM2o_ESQ>
 <xmx:UGAOalyxxcnd5v8GXEAIRUK6JK7VJQwWLTwERDm61-VwUUSSEi-Qsg>
 <xmx:UGAOas6HL0NLPNb9BTdHeV1RBYY_3g3YARIqJ1d0FjGqdcVJndO6qw>
 <xmx:UGAOahFj5BdkoD6RHwoGjH4m4i5c6ZS1UCIq0F-RlRZVkOV-rYLzwQNV>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 21:30:55 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id a64ba143;
 Thu, 21 May 2026 01:30:55 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 May 2026 21:30:55 -0400
Message-Id: <DINYSSO8JSHX.26JJ5ULW89BNC@jablonski.xyz>
Cc: <balaton@eik.bme.hu>, <chad@jablonski.xyz>, <philmd@linaro.org>,
 <bea1e@proton.me>, <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2 2/2] hw/display/ati: guard against zero bpp in
 ati_host_data_flush
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "Junjie Cao" <junjie.cao@intel.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0
References: <20260519023937.439077-1-junjie.cao@intel.com>
 <20260519023937.439077-3-junjie.cao@intel.com>
In-Reply-To: <20260519023937.439077-3-junjie.cao@intel.com>
Received-SPF: pass client-ip=103.168.172.154; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a3-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_PDS_OTHER_BAD_TLD=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

