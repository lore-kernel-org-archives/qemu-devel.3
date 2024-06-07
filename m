Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182EDC27C55
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 10:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFXB2-0001kr-Hh; Fri, 07 Jun 2024 06:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sFXAz-0001jE-99
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 06:50:29 -0400
Received: from wfout8-smtp.messagingengine.com ([64.147.123.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sFXAw-0004bB-Ks
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 06:50:29 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.west.internal (Postfix) with ESMTP id 680511C000FA;
 Fri,  7 Jun 2024 06:50:23 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Fri, 07 Jun 2024 06:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1717757423;
 x=1717843823; bh=yTf5sD3+p/akuuj3PkYMhXheqPD2Z8OZQOhySzLWpGk=; b=
 lfYdFvfoNh7I4vgoXUwgh6rQKUE9CCpBbMIcED9iv2UZJHrBbm54B5J79uBFArE4
 +6aeuJs9gKZRc6LHdLqL7qQFh7qUI3S2TFbGyuaFA4iEb3Cntp0d1OjRgi3KjW0d
 fn1MOCoEIa9Yz6Gl7GZK+2oA7iWlPIB7fMGt4FNnB8/OLxJeBcq6+v+gjYYfznp7
 TpNvbQ4VGO8u2IoY80/izXi6/VUG/M6SyJ0nk0cEQpoBPv0hj24vUdNfejdA4w+s
 aDcD1BfIwp0RyZPa97LKR03HU+NSLopgx2F7VWSWRYARDp+zb6N6sBxuZ2mGCPG8
 d+4oBe+0N8eLNgmPUnB4pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717757423; x=
 1717843823; bh=yTf5sD3+p/akuuj3PkYMhXheqPD2Z8OZQOhySzLWpGk=; b=O
 fhgb0xcKeMSIjc12NMpWnIonZSWZ3ibAwUyRdgrdvKDNqHlH7innHgsCBzo9dXzz
 9sjMrcPZccAKVlNJiWckpJkibEA/qerhYFgMn2Ri1zbl7pwhRTcuwkcdQYDy8+ua
 PDIjNphSh2U4BZl+JvKUwgJE3HpGNgQpzT+HuPLWVFk/3mn7fOUZDqTwVizOMo+R
 HDQrEDY0/wy6nar+t8oP06YKzHUhOwsd9YeqCGdrGY33DKBom+9Og+biw9ze8eEW
 oej4UKHB44Iw/kAWDQLcQWE+HZn8R07xUcIfcrn/U0fva2MwJpUv4n4foXdtrjsP
 InROCv5Ae+/sA/oSAUzMA==
X-ME-Sender: <xms:7uViZmgbG6z41Fi-YHtUvJCAPTEj1wYOhdf0DxDHJRrbkpjzCZlw6w>
 <xme:7uViZnA3AF6shJhOKhI7TTby94X54l5ilCom21Efs09NlwmoHOICN88jLUStF5Mte
 DrofJIXkZPuRpzzI8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtuddgtdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpefgudejteevuedvjeeludefffdvieevudehueetfefh
 udehvdetvdfgudejtefgvdenucffohhmrghinhepuggvsghirghnrdhorhhgnecuvehluh
 hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdih
 rghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:7uViZuGShmou4OHxk6m0qTVWag2S_XJL0k8BKSFl--PNFgsni9YhDA>
 <xmx:7uViZvQbkg2Hr_NpWJon2ObmhVRl6Xc-yYbWFeN8QxE2A_SC85G1cg>
 <xmx:7uViZjzjhqUan3zOb5ziAvhTebwOMkWCUCCB42GjtclSR8Tlf4MovA>
 <xmx:7uViZt5Eza7pyCI2dxlcDlHCmYj79XZ5LWxt3_Qcy9OpJOP8MlZgBQ>
 <xmx:7-ViZu-b_PXnPEjr40IWwgJGYXTxCvitvdVa8qIh61S8B723aV13aWHx>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id B99EE36A0074; Fri,  7 Jun 2024 06:50:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
MIME-Version: 1.0
Message-Id: <bb0a56c7-df3f-41a6-81b8-b962e3875ad9@app.fastmail.com>
In-Reply-To: <cbc243e6-b77e-4f52-88c5-04b94dad1d20@app.fastmail.com>
References: <20240511-mips_mttcg-v1-1-1b71d9b85234@flygoat.com>
 <87h6e8g9p3.fsf@draig.linaro.org>
 <cbc243e6-b77e-4f52-88c5-04b94dad1d20@app.fastmail.com>
Date: Fri, 07 Jun 2024 11:49:03 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: "QEMU devel" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] mips64el-softmmu: Enable MTTCG
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=64.147.123.151;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfout8-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B46=E6=9C=885=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=E5=
=8D=881:47=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
[...]
> I'll try to upgrade kernel used in this test.

Unfortunately, we don't have kernel build from reliable source
for that test.

I requested Debian project to build kernel for us[1].

[1]: https://salsa.debian.org/kernel-team/linux/-/merge_requests/1074

Thanks
>
> Thanks
> - Jiaxun
>>
[...]
>
> --=20
> - Jiaxun

--=20
- Jiaxun

