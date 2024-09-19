Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6787ACE8D7A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 11:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srFOD-0002hs-VK; Thu, 19 Sep 2024 07:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1srFO5-0002h4-TA
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 07:31:56 -0400
Received: from fout2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1srFO1-00055j-AD
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 07:31:51 -0400
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 4B16C138008C;
 Thu, 19 Sep 2024 07:31:45 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Thu, 19 Sep 2024 07:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1726745505;
 x=1726831905; bh=tA9cykiGJ3geWKPniMlL8Lav7oTSAfOxqz6gjwT9AjM=; b=
 KUsvn6cLSEVEaFPeIE2hG4PVjjKPFd9ke8Yh93zGtJEvfpgJdzA1QFbcZOOwe767
 FrEXHA84q64qXg2rz8+rVr8ilD5o33NzKhzLw2OnTpaQY6HeJhtyUCVQteeLdCF3
 /Gn38cpjGoU9RWOzhZ4dVPEmlFbox/hvioF7z9Yf2jQbQX+fPRx3+BRKzQQ0xO/P
 X+xh90rHvmXhZrNqU1lhjRCHzo1xIb+9CqQqpk114PdbX42POKF5nj/OwpwyW4Bx
 zfjKY3oUfebVsLEGqyS08ChmRkcUDAM9Pzz8a2tLsMKTNj3+NawLPHSKotwIClBr
 3Clh0O+xrbHzo0qByL41wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1726745505; x=
 1726831905; bh=tA9cykiGJ3geWKPniMlL8Lav7oTSAfOxqz6gjwT9AjM=; b=j
 doN7JjqHIsjLAqOZOA+c/vi4KkA263nTTnkq4QeCb9eR2shjFfitLszErThWLZg3
 pQyzu+Y3f4YQFbJNVgbJAyqVMmfyTPfpgpJ+hfJK0hjAkczM8K+tuhpH9v/Yws1S
 bgGpWITXhtN7WlRtvGIKMybQrVks9mQ1VREhLjjxr1oDtz+x8w5kRlfNk4YGkye2
 9BBi4hjNLnedmEFebYgoamjf+xJD7P6Vt0c3uk7Qr2w8+d5IeBfzMBZQF2FG7Qmv
 h8eny4Y36+zfVWeYIEEHLH/Mn2yuGPAeVwQZTzpuC51ylmEJGIR6dE1IBxkmtvVm
 yHUlyKSGQOx0Y5cLHKUIQ==
X-ME-Sender: <xms:oAvsZs8aH_5Lsvls1Ax2SmbMQT_XFDh2N2DS-cwWK01kLH-tOhklww>
 <xme:oAvsZkuAHqZPuvDnHiy5RIHLAdUaHgY5d5qNwDu62kgZ6VovIrQJA7tTvjVRz0B6c
 wCXvXFVm7ahWAUgeDo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeluddggeduucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:oAvsZiBaxGiGNbNWbEuKbyelKGdVJU6TnWPuX313gxcDO3PHM6j5Ag>
 <xmx:oAvsZseL9h4V_LQB8ZOQlex706NdYhXi8u1Y2kTf-vD3GvUV9Cmnjw>
 <xmx:oAvsZhMSRloUATbX1a4kuPkrTHqjT6XzNHLc6A0Oq_usnytnI8fAtg>
 <xmx:oAvsZmlgfQj4lez9qb68i5qOYSLwp0rNAUVesF9aJeHjHVgqwuM51g>
 <xmx:oQvsZqYuzE6vOsiI0GrKkR7qcUyNlwHIbMNlZhtm9KuWHddzRqj2Ro9q>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id B73241C20065; Thu, 19 Sep 2024 07:31:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Thu, 19 Sep 2024 12:31:07 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Song Gao" <gaosong@loongson.cn>, "Bibo Mao" <maobibo@loongson.cn>
Message-Id: <2d46845b-8702-44ba-b302-e569ad1e90e4@app.fastmail.com>
In-Reply-To: <20240914-loongarch-booting-v1-0-1517cae11c10@flygoat.com>
References: <20240914-loongarch-booting-v1-0-1517cae11c10@flygoat.com>
Subject: Re: [PATCH 0/2] hw/loongarch/booting: Booting protocol refactoring
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.145;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout2-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B49=E6=9C=8814=E6=97=A5=E4=B9=9D=E6=9C=88 =E4=B8=8B=E5=
=8D=881:10=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> Hi all,
>
> This series refactored booting protocol generation code
> to better accommodate different host ABI / Alignment and
> endianess.

+ Bibo,

Ping for review.

Thanks

>
> It also enhanced LoongArch32 support.
>
> Thanks
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Jiaxun Yang (2):
>       hw/loongarch/boot: Refactor EFI booting protocol generation
>       hw/loongarch/boot: Rework boot code generation
>
>  hw/loongarch/boot.c         | 321 ++++++++++++++++++++++++++++-------=
---------
>  include/hw/loongarch/boot.h | 106 ++++++++++++---
>  2 files changed, 293 insertions(+), 134 deletions(-)
> ---
> base-commit: 28ae3179fc52d2e4d870b635c4a412aab99759e7
> change-id: 20240914-loongarch-booting-b5ae3f4976b7
>
> Best regards,
> --=20
> Jiaxun Yang <jiaxun.yang@flygoat.com>

--=20
- Jiaxun

