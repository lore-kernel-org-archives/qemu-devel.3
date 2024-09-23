Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE18ACF9C69
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 11:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssh5r-0003Gg-Mo; Mon, 23 Sep 2024 07:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1ssh5q-0003G6-8K
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 07:19:02 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1ssh5o-0003c5-6v
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 07:19:01 -0400
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4115A11401C7;
 Mon, 23 Sep 2024 07:18:57 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Mon, 23 Sep 2024 07:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1727090337;
 x=1727176737; bh=1LdQoYyyRAvN9JfQQOcHkVpaaTLC1M+TrNCg4anfYDM=; b=
 FyH1R653Sud6UhYVsLoqo52oKC3KRsgJRo+nheku3R3cXBxwZ9JHt00vcM8BD149
 C0PWbmFH818WoXSSmFCkljv9UU4CqtJY+9gFexO6G4/Sr6IBiyHGpd/JffbXuEow
 3TNnY7bh3Fcn5CSxgIBP/xj/f38k0hePqSlupjg01ata0ZwDZKXhNaBf05ZR1Iza
 EdkKs0FXZNbUa9z/QJJ2zj/ZvfTJJtjQDnSe1b0QK4l+/5g+0r/10rSq1G/jFe+/
 103iogMKz8AZmGp/B1BEHVKGgDt732HfTnGin94BRbusGZNvb4JppWlsjkYZO8Eb
 TEZQakRCCbnQ+ylPZU/lBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727090337; x=
 1727176737; bh=1LdQoYyyRAvN9JfQQOcHkVpaaTLC1M+TrNCg4anfYDM=; b=e
 FMqH3VhJyuGG0H2074MWiOzOLBQcm6fJSyJAxAeUTFlwFt4/23F72wEcFehAuwex
 9Y2+jRir2gkaTjSqpxAEnCv/mHXn/GVPTccHs4D9lOKqI+RC4+M39DfbCS9f6hyh
 mSxucct37QAPCMRzQwZh/sc1eaYdQ5aIdkG0g/GtkABo4ssMv1sQZPJqscAEUelN
 ixjcPcuX9ZgC/lhkFo+nLzJn7qYBcDHtpKEScApu6YixiLMM9T6E0vxXdYurgLt8
 JKtOoToSN89ZrLRkAdaotD3C2M7T4lDx7+gZoHEnGol0r41UEaF4BPpo1/XJoIdx
 UYMt5kaduiMSUbFUbNSxw==
X-ME-Sender: <xms:oE7xZnmvwZlxnFad6ED8jBn_CLzN22bWD2l5itKP0wCWkeDZaTDVKQ>
 <xme:oE7xZq2IoHR9DG07Z020Hugo6Nlc3DcefAS3NaboGVH8FXxoftbzTxlBdTEAUQrPY
 CF-5caK1g3NAoScUEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudelledggeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
 necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
 hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeet
 hefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
 thdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
 htohepghgrohhsohhngheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehmrghosghi
 sghosehlohhonhhgshhonhdrtghnpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnoh
 hnghhnuhdrohhrgh
X-ME-Proxy: <xmx:oE7xZtr3AeD2YOYHXOnvZ9j0QQmnRIY6CMbFUzg1uI8dQo9RzfhBTg>
 <xmx:oE7xZvnPX_O7kZ3esTrthAuVGwUPiM09Mu7vtaR5xIMpxfW--NJFlg>
 <xmx:oE7xZl0HdZgmsjgFZq1dOJZYWT53tothW8Q4Xc5AeOoUAwt443EBDg>
 <xmx:oE7xZutMFP8Q9yqf08dzYYy8YSSAeKeAygC25NX6jTqo_66akW_P3A>
 <xmx:oU7xZjDD5ObIX_d4A7dyaOhsv22_zrOORhhQl5_8OPHHERKK40rYSznV>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id B6F041C20066; Mon, 23 Sep 2024 07:18:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 23 Sep 2024 12:18:35 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Song Gao" <gaosong@loongson.cn>, "Bibo Mao" <maobibo@loongson.cn>
Message-Id: <2d48e280-407e-46b0-9b10-092725a501af@app.fastmail.com>
In-Reply-To: <2d46845b-8702-44ba-b302-e569ad1e90e4@app.fastmail.com>
References: <20240914-loongarch-booting-v1-0-1517cae11c10@flygoat.com>
 <2d46845b-8702-44ba-b302-e569ad1e90e4@app.fastmail.com>
Subject: Re: [PATCH 0/2] hw/loongarch/booting: Booting protocol refactoring
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.153;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-a2-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B49=E6=9C=8819=E6=97=A5=E4=B9=9D=E6=9C=88 =E4=B8=8B=E5=
=8D=8812:31=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> =E5=9C=A82024=E5=B9=B49=E6=9C=8814=E6=97=A5=E4=B9=9D=E6=9C=88 =E4=B8=8B=
=E5=8D=881:10=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
>> Hi all,
>>
>> This series refactored booting protocol generation code
>> to better accommodate different host ABI / Alignment and
>> endianess.
>
> + Bibo,
>
> Ping for review.

Ping?

Thanks


--=20
- Jiaxun

