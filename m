Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CC5CF9C70
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 14:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sskIW-0000lb-0K; Mon, 23 Sep 2024 10:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sskIG-0000iv-8O
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 10:44:05 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sskHy-0005Zv-Cj
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 10:43:48 -0400
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 3598713801CB;
 Mon, 23 Sep 2024 10:43:45 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Mon, 23 Sep 2024 10:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1727102625;
 x=1727189025; bh=ljOcLPXS4Y4TW/5zsTCd8vjqIR+szAz2TFhbTFza510=; b=
 chM4w2lWeFxTycbTWs010KCdAlcBaTH3uocCWua686nA58xUksQzOQ/MxSN96v+N
 UZIlXfUyeVdtUeiZKSvsfg3pJcIuJjUUmbpvRv4/I8H2AXien4vKSksCh7Gl2ya5
 5pG6Zf4PxreT1v5pVit6rLOJOsCSVgwJ4ZTtseMOnz2JIu/G8FrfP9iNOri/5Fhz
 O1Fz7i0qHlYGU7yKW5bnNMYrMumTcZT0oGnII5uW2zzSKRUXxPsUv/KnAgu5vgDv
 QnoFh3k9EvwaSNPhcdWiDcq0aWVjU5TJtUyqlYML4WSQBn0DeWZmjG51Q5xl41lT
 6kDgoBe3mdWyUknpycz+gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727102625; x=
 1727189025; bh=ljOcLPXS4Y4TW/5zsTCd8vjqIR+szAz2TFhbTFza510=; b=Y
 s2BtSJ/7p9nWfLcQKeNgFvXSfDpas3FWje9t8S6N6EzmPiSvAws0AAKwx9X/NZP7
 TrasAli0t5nXNOG81BItGwT/IaTsMzUPDqsy6OJ03gDbS/NusR7LlAeq9xqnOQK0
 WfMddVpX09uJaOWOASlrlOa1hsw46CCJwuqgYU6y8G5pZePd31bpqeNT7LcKNa8v
 dKnFu/uWNOpe68JnCTazUvLDyt1Z7/Z5MF7Bz4tLwLkd62jjc7EuPop/M+t/9h7W
 0uRZlumqdQQYU1hx+YxDoBGqpEPQl3uhp1teYYvFOrr3ETu9bcJFk7ICbk6LfjwL
 nUYS6cvQ5dyhTJWPLjq/g==
X-ME-Sender: <xms:oH7xZlrh7YVr6kSVmloZcQ7utQN7rGTk9DTZ1AzS783bdF4QyaE3yQ>
 <xme:oH7xZnrrrdG1xwI-f_cf-Kjeovzuphao6ldanX_ANiq4unpmXEe9nzGU9uAjzFKVw
 VCh3dKS_cK_sJUTXCI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudelledgkeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
 necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
 hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepveeuffetfeekhefhtdfhleef
 ffejvdffkefgieeuudegkeegjeevtdffieeltdeunecuffhomhgrihhnpehgihhthhhusg
 drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
 pehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhope
 efpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghoshhonhhgsehlohhonhhg
 shhonhdrtghnpdhrtghpthhtohepmhgrohgsihgsoheslhhoohhnghhsohhnrdgtnhdprh
 gtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:oH7xZiM3dWCfpeFR1_eZTymsTqZkmYpIauHz49ZVmHHFkP8MESu6ZA>
 <xmx:oH7xZg5YmdTE5MqQ43BxTALcdX7rXhhJKl2vBhFvDj05mGy_6x7tqQ>
 <xmx:oH7xZk7Wktdwy_8Mg3aZR15StjbCQOaJtv7V33_Lz8W8q6eFR9MrYA>
 <xmx:oH7xZojv3Wo2Ri300qjOTMMsLUQQq4l_KXGNfbhDdLdT3f6355YMDg>
 <xmx:oX7xZkEfGSX-pBEXFg2GWQWItEwlIDLdegFEUxelnhyhOi-dbldN-abM>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 9633C1C20066; Mon, 23 Sep 2024 10:43:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 23 Sep 2024 15:43:23 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: gaosong <gaosong@loongson.cn>, "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Bibo Mao" <maobibo@loongson.cn>
Message-Id: <40448724-937a-452e-bd8f-e0b9e4c040c1@app.fastmail.com>
In-Reply-To: <866bab1c-5374-4be4-d92d-831d40b48b11@loongson.cn>
References: <20240914-loongarch-booting-v1-0-1517cae11c10@flygoat.com>
 <866bab1c-5374-4be4-d92d-831d40b48b11@loongson.cn>
Subject: Re: [PATCH 0/2] hw/loongarch/booting: Booting protocol refactoring
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.149;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-a6-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B49=E6=9C=8823=E6=97=A5=E4=B9=9D=E6=9C=88 =E4=B8=8B=E5=
=8D=881:34=EF=BC=8Cgaosong=E5=86=99=E9=81=93=EF=BC=9A
> =E5=9C=A8 2024/9/14 =E4=B8=8B=E5=8D=888:10, Jiaxun Yang =E5=86=99=E9=81=
=93:
>> Hi all,
>>
>> This series refactored booting protocol generation code
>> to better accommodate different host ABI / Alignment and
>> endianess.
>>
>> It also enhanced LoongArch32 support.
> Hi,
>
> I tested LoongArch64 and it works well.
>
> But how to test LoongArch32? Could you provide an example?

I have a W.I.P. LoonngArch 32 kernel tree[1] that can boot in QEMU,
but it still requires many other fixes in QEMU TCG.

32-bit stuff is just a bonus to this series and the main motivation
is to improve booting protocol quality.

Thanks

[1]: https://github.com/FlyGoat/linux/tree/b4/la32
>
> Thanks.
> Song Gao
>> Thanks
>>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>> Jiaxun Yang (2):
>>        hw/loongarch/boot: Refactor EFI booting protocol generation
>>        hw/loongarch/boot: Rework boot code generation
>>
>>   hw/loongarch/boot.c         | 321 ++++++++++++++++++++++++++++-----=
-----------
>>   include/hw/loongarch/boot.h | 106 ++++++++++++---
>>   2 files changed, 293 insertions(+), 134 deletions(-)
>> ---
>> base-commit: 28ae3179fc52d2e4d870b635c4a412aab99759e7
>> change-id: 20240914-loongarch-booting-b5ae3f4976b7
>>
>> Best regards,

--=20
- Jiaxun

