Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F261D29FBE
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 19:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRFGy-0005G6-HM; Thu, 04 Dec 2025 14:45:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter@pjd.dev>)
 id 1vRFGw-0005Er-Dt; Thu, 04 Dec 2025 14:45:50 -0500
Received: from fout-b1-smtp.messagingengine.com ([202.12.124.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter@pjd.dev>)
 id 1vRFGu-00073s-4E; Thu, 04 Dec 2025 14:45:49 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id E4AB11D00166;
 Thu,  4 Dec 2025 14:45:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 04 Dec 2025 14:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pjd.dev; h=cc:cc
 :content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1764877544;
 x=1764963944; bh=qhIgUhDQcDTlfo1MknYhbh+kpXzL/E993d8Sf0Girwg=; b=
 aR24EWaVM4vu6IAU4jPmohqXNMS5CRjfP4vhx+wb0bdQomk4J+td/sAVIsd5scp2
 5pYDwMMPapuDytXmhMebhOwZH44lrlAp0k/HWi5iksgEpxGkdCgFpv83GDS5fs0c
 wX3c41mo5iTZ2FlmE9OYWRM9ISUi3943hMW2h5ZmLJGruDwYBqXqBT7ouUfolP43
 m+e48nFHSVhD5UNVqXmaw1xY4z2EaTnils0ymeHHRTDXjEPaCXvOQPIt1J9emTRu
 ERLCt1+YLEdTNy6bWWknMCr9iFlCHDgmERlgiTHNmZo1QAfPZMtprnIu2Yat9Ieu
 MnodyliH1bizKaLMgO7PhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764877544; x=
 1764963944; bh=qhIgUhDQcDTlfo1MknYhbh+kpXzL/E993d8Sf0Girwg=; b=n
 wbpHm05CdVBeGII53I4Wcv/IH8PBX84bB41SOnTkpSK3nItkG2/E5QOXpZexWtdC
 yfQFMIgSPZV1WdoRd61cgwdG+90K6ok5QGyWifkWPx23SQMv2/iLymyojdyu2uQ+
 9PnWAHW3sVMK5DtIvh6EazsGpidS0Dd3bAxvGmFFdG1Bm9vcS5FKPsLdE6swBSP7
 jqllBLlSC2SG4/HZ3vkHLFpZ5RGhDUHxC/RuzDuu6uydvsHoTCN0gSGrXnc3ogsH
 aK4pw4+x09PfRdD10LP80nOfw66wvAVG7vHEJBncM0te/JVpJX0DacbDG+Ywmssy
 1tAIblEEnhY+ICWAaek0A==
X-ME-Sender: <xms:5-QxabEmEkE6bVr9ax_jLpn0eVMyvyV3PnYNy1-GIl2dhoJV6msenA>
 <xme:5-QxaWkFIo-DrwyrpP2YXq0qYHlLXlsgwTqBIkL7bsnUtpjVq00w1TNxr5UcksIn_
 QMKXAfwHmEsvJv54vmdOPLJB9YT-o5i-ebbw2YstYXfGIqgqzfnDww>
X-ME-Received: <xmr:5-QxaWfncoSRMhkWQ7Ks0gCVgw_W6vuAI7OZu_qA5mgw8wOcb5-KYoHHQ9Y1K6NSIR85A5Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeigeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 eptgfghfggufffkfhfvegjvffosehtqhhmtdhhtdejnecuhfhrohhmpefrvghtvghrucff
 vghlvghvohhrhigrshcuoehpvghtvghrsehpjhgurdguvghvqeenucggtffrrghtthgvrh
 hnpeeuiedtvdejgfegfffgudetvddtueffueejffejgeelveeutddtveehfffhfeetieen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpvghtvg
 hrsehpjhgurdguvghvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhht
 pdhrtghpthhtohepshhtvghvvghnpghlvggvsegrshhpvggvughtvggthhdrtghomhdprh
 gtphhtthhopegtlhhgsehrvgguhhgrthdrtghomhdprhgtphhtthhopehpvghtvghrrdhm
 rgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopegrnhgurhgvfiestghoug
 gvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghpthhtohepqhgvmhhuqdgrrhhmsehn
 ohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurd
 horhhgpdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrghdprhgtphhtthho
 pehjohgvlhesjhhmshdrihgurdgruhdprhgtphhtthhopehlvggvthhrohihsehgmhgrih
 hlrdgtohhm
X-ME-Proxy: <xmx:5-QxacHjqzxXH5AKWR-HKlqA6NzfLQ-vLnfaxygEGDs8F16TrVRr3g>
 <xmx:5-QxaUh6hmcl7ki43r6zE8c-2hxI3hpiEsL-q7WRW0YXvoe6EAFztA>
 <xmx:5-QxaY0rsM3polrB9rycbR3GWfR2D6OxQhXgxc-uV0YO4IxSehQFtw>
 <xmx:5-QxaXdycA9VWUjIBgptgHbgbAJl43i4l_j73T2c4K-R_Pc48PbUOg>
 <xmx:6OQxaV4TdcyApleFZxXWgmrnTpIjnWV-HIjTn2VIXO6TDAYMSWNzeXGw>
Feedback-ID: i9e814621:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Dec 2025 14:45:43 -0500 (EST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Peter Delevoryas <peter@pjd.dev>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] aspeed: Deprecate the fby35 machine
Date: Thu, 4 Dec 2025 11:45:31 -0800
Message-Id: <2B4B594F-DFB1-4BD1-8FF3-8F74EB2EC52A@pjd.dev>
References: <8f8fb825-891a-4c06-9676-4aa232cd4642@kaod.org>
Cc: =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Maydell Peter <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8f8fb825-891a-4c06-9676-4aa232cd4642@kaod.org>
To: =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
X-Mailer: iPhone Mail (23B85)
Received-SPF: pass client-ip=202.12.124.144; envelope-from=peter@pjd.dev;
 helo=fout-b1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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



> On Dec 2, 2025, at 11:42=E2=80=AFPM, C=C3=A9dric Le Goater <clg@kaod.org> w=
rote:
>=20
> =EF=BB=BFHello,
>=20
>> On 11/26/25 11:24, C=C3=A9dric Le Goater wrote:
>> There are no functional tests for the 'fby35' machine which makes
>> harder to determine when something becomes deprecated or unused.
>> The 'fby35' machine was originally added as an example of a multi-SoC
>> system, with the expectation the models would evolve over time in an
>> heterogeneous system. This hasn't happened and no public firmware is
>> available to boot it. It can be replaced by the 'ast2700fc', another
>> multi-SoC machine based on the newer AST2700 SoCs which are excepted
>> to receive better support in the future.
>> Cc: Peter Delevoryas <peter@pjd.dev>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
>=20
>=20
> No objections ? If not, I will queue the deprecation for QEMU 10.2.
> Since deprecation is tolerated in the -rc phase.

Oh hey, sorry I missed the original email, yeah no objections! Totally fair.=
 :) We=E2=80=99re not using this internally either, we=E2=80=99ve mostly end=
ed up pursuing multi-process solutions. Even though I think single-process s=
tuff is interesting, getting multi master i2c to work between socs in the sa=
me process can be tricky.

Thanks,
Peter

>=20
> Thanks,
>=20
> C.
>=20


