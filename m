Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2DBC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 05:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCuur-0006fZ-SR; Fri, 31 May 2024 01:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sCuup-0006f0-B5
 for qemu-devel@nongnu.org; Fri, 31 May 2024 01:34:59 -0400
Received: from wfhigh8-smtp.messagingengine.com ([64.147.123.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sCuun-0007iB-Ay
 for qemu-devel@nongnu.org; Fri, 31 May 2024 01:34:58 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.west.internal (Postfix) with ESMTP id E5C0618001D0;
 Fri, 31 May 2024 01:34:53 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Fri, 31 May 2024 01:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1717133693;
 x=1717220093; bh=jSJ2XWOA5fvDIcmEwjQhMaZ8YYrz/0bVtlISvm6KyC4=; b=
 iMN1SzU7B41Xs7jNtktlB8GZ5m2XjeCepBAL0crz5Dvm2MfwuPFThiCg3aM9MflS
 ew7uNZLTV0ee5Dg/kiHAQYcYFEvUtj9RCQ2UOxHh30v4QamUG7fYFlaNJvehwyEu
 s+Il1nujM9XebBfiDqFfDqUOwLshNNMIvvG0a1waGjqLLeb7rKgwrAVCRRiCflU3
 pPxRTph8OlFTQuNGzDdhKf0LJIQd4m4zv9+jijD1sMLROArOZm45ladEpcTAyn00
 MqMnpf13MOktdVBzj+4riviHMGan1LfGEzGlb29Nglyuy6CTD0zELlAiEZU3Btku
 Rmv2e9vIDL3jYCUdXz9nLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717133693; x=
 1717220093; bh=jSJ2XWOA5fvDIcmEwjQhMaZ8YYrz/0bVtlISvm6KyC4=; b=P
 /OKrKQvG8xZ09xcC4JOYnIXHaKcBSCq/4kURXhYCJ9XgP7J+AAYb5jVNfAedxVHD
 LzZjWHkXiJtRXlcpCYDOz18vZPwwLpeXR/Ox2dGNrTGALg/61jXzHNx+fHeInHNw
 Pn8TjntZ7SPm0l6+rE08DTMljyvAKRX1jaZu+4YzAOhDlNwybIjFKcnHN2n9rgmL
 VUp1YzmlyfHEIElyZvNmqoiBLDWwO5NdPHBb4IS2YekEP7XIhoJsRyqr4wgXpKAc
 P3BJ4A5uG2lB2fglgJa88d3RK6Ptf7H4hPWzST8Kds89/SkhBQlh8bTeQFP5a6Mq
 zRHo08bbdxLj6fiT0QLVQ==
X-ME-Sender: <xms:fWFZZqlYxCqqZ6lkZMK1rby6Mz5jkLWX6sTwaQz6vDqJOkoZZTYPGQ>
 <xme:fWFZZh2yAy_lPaSgmb1HC7J-vV7hVGRC60Fnps8-EKjRiyRQban6dapAq-m31Hc5J
 LRM2M4ApM_Jmlgh4DQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekhedgleegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpeehkeejjeffvdevjedtkeeugeeggfevjeduuefhgefh
 tedukeetgfdtiedufeetteenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgihhtlh
 grsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
 ohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:fWFZZoo8taaF18m8_DpZOI3oZMUjyaBbDeFImgeBCX9vGEybA-Bq1w>
 <xmx:fWFZZukuqo-EU2Fs62bJ5qVPqWu0EReVFTegruqm7l7D74NAlBwqYQ>
 <xmx:fWFZZo0Tq5ogbkKwNHiA8Puzyj6VJy--QG4sJX3hRp481ntgDyek1w>
 <xmx:fWFZZludSltjB6JSVqTTUGQT0NbApFBCwQheNagxeSK1FHy2C33CfA>
 <xmx:fWFZZio6jZxlZ0BybQTrU_bLfxWreEkfTQU1eUVknIPDIcmU9PIngmlW>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 1C6D536A0074; Fri, 31 May 2024 01:34:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
MIME-Version: 1.0
Message-Id: <9fb052b6-5787-4e70-9af7-e579bda0bb73@app.fastmail.com>
In-Reply-To: <f80b55c3-f527-fe1a-4033-d9dde1ee0b01@loongson.cn>
References: <20230515111908.2606580-1-gaosong@loongson.cn>
 <20230515111908.2606580-3-gaosong@loongson.cn>
 <3819e261-646d-467a-b783-85700b0e6842@redhat.com>
 <f2840fc6-0a16-b9ba-937e-f381d2c60bdb@loongson.cn>
 <bd599efc-1b5a-47a1-b0e9-15c59907a256@app.fastmail.com>
 <f80b55c3-f527-fe1a-4033-d9dde1ee0b01@loongson.cn>
Date: Fri, 31 May 2024 06:34:32 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: gaosong <gaosong@loongson.cn>, "Thomas Huth" <thuth@redhat.com>,
 "Xiaojuan Yang" <yangxiaojuan@loongson.cn>
Cc: "QEMU devel" <qemu-devel@nongnu.org>, "Chao Li" <lichao@loongson.cn>,
 "Bibo Mao" <maobibo@loongson.cn>, "xianglai li" <lixianglai@loongson.cn>
Subject: Re: tests/avocado: Add LoongArch machine start test
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=64.147.123.159;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfhigh8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8831=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8A=E5=
=8D=882:52=EF=BC=8Cgaosong=E5=86=99=E9=81=93=EF=BC=9A
> =E5=9C=A8 2024/5/30 =E4=B8=8B=E5=8D=889:16, Jiaxun Yang =E5=86=99=E9=81=
=93:
>>
>> =E5=9C=A82024=E5=B9=B45=E6=9C=8830=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=
=E5=8D=882:00=EF=BC=8Cgaosong=E5=86=99=E9=81=93=EF=BC=9A
>> [...]
>>>> FYI, the test does not seem to work anymore - apparently the binari=
es
>>>> have changed and now the hashes do not match anymore. Could you ple=
ase
>>>> update it? (preferably with some versioned binaries that do not cha=
nge
>>>> in the course of time?)
>>>>
>>> Thank you,=C2=A0 I had send a patch to fix it.
>> Hi Song,
>>
>> As LoongArch EDK2 support has been merged long ago, do you to make a =
clean
>> build and add it to pc-bios directory?
> EDK2 LoongArchVirt under OvmfPkg is being committed to upstream.
>
> PR:
> https://github.com/tianocore/edk2/pull/5208

I meant here:

https://gitlab.com/qemu-project/qemu/-/tree/master/pc-bios?ref_type=3Dhe=
ads

Thanks
>
> Thanks
> Song Gao
>>
>> Thanks
>> - Jiaxun

--=20
- Jiaxun

