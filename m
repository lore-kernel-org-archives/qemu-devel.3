Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85061C61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 06:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPEyK-0001jN-Bb; Wed, 11 Jun 2025 02:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1uPEyB-0001j8-3s
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 02:29:55 -0400
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1uPEy9-0000np-8b
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 02:29:54 -0400
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id EBFF511401C0;
 Wed, 11 Jun 2025 02:29:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 11 Jun 2025 02:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1749623391; x=1749709791; bh=jTRKXrMaTn
 lusgYsbcpleYoeB940ODQx8jB1YalZeFg=; b=mAu9iDTpCfQW2HZSlPBv9aeGUq
 NhSWQCUk9HhaKT/KQofPBddbQm3rEoIDP1hhvGzsITdp0GpYFqMZkXMQUwWSZ7lL
 vKRm5dTteDO5y+jfD3LF+4B1giI91GKwqZJjDix/5WEmtmgqBN54mAanmBmjzQEG
 PBGQdOsSG/4Vznaa0j7kmFuMQAVn+PRXWbpm9BaTfVXJWA/l42Ft3v0qGG9yqezu
 RalrV4pYF5WFasq4NFfcD8YfXGccLcMCnpQQkizLHYrOi4+PvOyGCX9f896usWXP
 vJuX2O2MYN5XG1OGU6zJR1L8AnMwo0W5bpmbpaQ96gv+VyG7ceoN/FinfH2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1749623391; x=1749709791; bh=jTRKXrMaTnlusgYsbcpleYoeB940ODQx8jB
 1YalZeFg=; b=MOiTd8In4nyFOV7x9zTCfWfTOhphSA4CXmcrknxbRVv/Ze3c0/D
 zzzkoV9x7lZfqOw0t0GD2OQb6MGZSGSTpMfau91IFwtpcsD9f67o8EMEYx9VVg+m
 rNZBAFRKeF/TZd6ukfO2T3cTUiqb2YkW/Ac0mYVz60yIFHE42h0C7xjZJNZ/RN2z
 95IhB2GYkacFXZEReTd1bipCgYosocisGii6aTLXxfUBabN/kf9O6KegJ1dKMEEc
 oYfwmwukFvoxCbrVFta8y6bqfeJKicj6kRBqRD6fxrt4N6ISu1Zb2ZwRgfA0je6Y
 wgTVaVmVT1cKk3q4UUg3liIgEIWMtxPjVDA==
X-ME-Sender: <xms:XyJJaDgubqmsyTDIy5IwC-w6tSHrdRZ_JiPDSV_7jxmWJJik2Qqfkg>
 <xme:XyJJaAAaBpXeix79-tR8HEzUtzRtvmupx-z8ZUeLhe4m5kcqVb535-MiyyH0IbrgW
 nK9pv2OSjZRzon5PQ>
X-ME-Received: <xmr:XyJJaDFqVd4hxNxJjqUlxquEB3rWSmzyaUVhDmrkf2gzrP1hWd7fxYqfKws_Mi-HAL4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduudekvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfggtgesghdtreertddttden
 ucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecugg
 ftrfgrthhtvghrnhepieduffeuieelgfetgfdttddtkeekheekgfehkedufeevteegfeei
 ffetvdetueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhephhhisegrlhihshhsrgdrihhspdhnsggprhgtphhtthhopedutddpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepshhtvghvvghnshgusegthhhrohhmihhumhdrohhrgh
 dprhgtphhtthhopegrlhgvgidrsggvnhhnvggvsehlihhnrghrohdrohhrghdprhgtphht
 thhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtoheprggvsh
 htvghvvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrvhhiugesrhgvughhrght
 rdgtohhmpdhrtghpthhtohepjhgrshhofigrnhhgsehrvgguhhgrthdrtghomhdprhgtph
 htthhopehmshhtsehrvgguhhgrthdrtghomhdprhgtphhtthhopehsghgrrhiirghrvges
 rhgvughhrghtrdgtohhmpdhrtghpthhtohepshhlphesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:XyJJaASp1Q8K_fTgEKCyGvZ3eAlYnNCIEeucQe-Kqg_gfd6Io16oHw>
 <xmx:XyJJaAxTxjeoIGfgarfj93k4HVWEW6vXqrTBMopcGD0OV4YoK-3Z5Q>
 <xmx:XyJJaG7ABGaUpLCqX9Zi-HcgSMNboxnGH20OuzSG6FZt6IU3uBgOuQ>
 <xmx:XyJJaFxU7vCJCdXIGMWsTahMtASySZL_MXe6NoltwkTsEnvpW4A-vw>
 <xmx:XyJJaJpwQwFN451RBNppoq7jCRXXeN7Wk3VYpici0bonpjOd0nmxrduK>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 02:29:51 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id 87FE37127E5; Wed, 11 Jun 2025 08:29:32 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, slp@redhat.com, david@redhat.com, "Michael S.
 Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 jasowang@redhat.com, stevensd@chromium.org, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH v5 7/7] vhost-user-devive: Add shmem BAR
In-Reply-To: <20250609144729.884027-8-aesteve@redhat.com>
References: <20250609144729.884027-1-aesteve@redhat.com>
 <20250609144729.884027-8-aesteve@redhat.com>
Date: Wed, 11 Jun 2025 08:29:29 +0200
Message-ID: <877c1ipz92.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Received-SPF: pass client-ip=103.168.172.152; envelope-from=hi@alyssa.is;
 helo=fhigh-a1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--=-=-=
Content-Type: text/plain

Subject should say vhost-user-devi*c*e

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaEkiSgAKCRBbRZGEIw/w
oglSAQCcNBORaEu6/ZHXIQgvrfoY3VnK1uNhVQH9Pq9SGDolXwD/a5V7xGaDBTwl
u7Ha0y1Ps5kq+WNdBAL/ZqFQjPO83g0=
=P0Z0
-----END PGP SIGNATURE-----
--=-=-=--

