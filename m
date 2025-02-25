Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6512C021BF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 12:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmtjx-0003aM-Sz; Tue, 25 Feb 2025 07:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmtjs-0003Ud-O2
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:08:40 -0500
Received: from fout-b5-smtp.messagingengine.com ([202.12.124.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmtjq-0007L9-D9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:08:40 -0500
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 2A41F11400B5;
 Tue, 25 Feb 2025 07:08:36 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-03.internal (MEProxy); Tue, 25 Feb 2025 07:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1740485316;
 x=1740571716; bh=H1CseWI94kZKIUtlN1eUptTfu/BpETdi7G4VVzz1deY=; b=
 pl8JBNgPi5kYQxG4vj6D48zKuwmiFvd46uWDixJd1WU3v+g8NYe8W9t4FThKIu8d
 aRd8L112pqfx3+Mnhn5POR/CncvqCLB7P0QT9iLbTgNFTejeBlExYnOHQrPRRVGI
 mXC3zClklDlePtgR8HEQmssgahcWzCvcbUL6MPCLz5koElgHk4zuAE04Hb+XzSAO
 qXQ2YWcfrviFg4DS2yrJrEbanhlrr2lH/ijLblUrB802KAZnAItZoBdEDWNN74BE
 vI/GA7wZn7888RrqaXxHlcA5sz6zkVxdfJ907w9aLkaqDxAO6g5fm86xBKr6TL5O
 RCGxEN5Py/Y961X8PBniGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740485316; x=
 1740571716; bh=H1CseWI94kZKIUtlN1eUptTfu/BpETdi7G4VVzz1deY=; b=U
 uSZQ1sLG3Rcgn7CjBHik4gAadXCM8h98NmeYahfoLxQEQIGlaiQPRCpc1LfhYIgx
 3IoBwdte1FwpeJqhA96Riqs57VEjVYG5AJTAhoK0CgP7vURacusUNBg8AAY4xSt7
 WiRheqAlKfLHl34bvQzTBK5P0bjV6yG3d5CAfvPwFi574mniOcluHf0YTZU+2Dnf
 X8tHC5Lrq3r7N9tjr+lvAXPbIoK0QouM9wBNE3wNW0nxi4iu0Y+HuNP1CON74Gld
 Aa4pHCBW7QPjMmfdYUHP/SHaYlH4CPwDYyKZQEFJXCXKGiavifcDhb+RENTPLuXE
 BvW+zpK4NPiHl4VIj98tQ==
X-ME-Sender: <xms:w7K9Zz5vw42-rzNPJKwHSfZP-63SkWtGdIRbEtJr5HWGxIgm9m2NOQ>
 <xme:w7K9Z44tRouLDl1TjGf025LlGPy4uqNH53IqBklNe6DIlgZ5ii7SzoK2ZbpQLHcdm
 sjicQCvjClbrosWFOE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudeiiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
 jeenucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgse
 hflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedtveekgfelfeevffejudfg
 leegueehueffgfdtjeejieehjeevvefhheevleekfeenucffohhmrghinhepghhithgvvg
 drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
 pehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhope
 egpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhho
 rdhorhhgpdhrtghpthhtohepghgrohhsohhngheslhhoohhnghhsohhnrdgtnhdprhgtph
 htthhopehmrghosghisghosehlohhonhhgshhonhdrtghnpdhrtghpthhtohepqhgvmhhu
 qdguvghvvghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:w7K9Z6dRF3RukR5uIl84KokogW04DMIwrSfQC6ex3Cd1tJ6uWPUtyQ>
 <xmx:w7K9Z0I6Ib7Sy394xmX_Inc4WBCYBA-JobOaDo3vlvIK5ZqK8zrw1w>
 <xmx:w7K9Z3LemPvjmgNJZKNZK9ccO6lRioi4HqPONFrRCjrPB_jEWV_GJQ>
 <xmx:w7K9Z9y-7-UtzBVGjztvtgLmP9Ru1MjmDJgWbTfQfpJvp00ux5cnkA>
 <xmx:xLK9Z_2j5qoc90px3tO1St5rgGEJ7i3ubnrtDQzYZSbRm2fIGfrzl9xd>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id BB8D81C20065; Tue, 25 Feb 2025 07:08:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Tue, 25 Feb 2025 12:08:17 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>, "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Song Gao" <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Message-Id: <23d25d66-07f4-454b-903a-f5704e1e686c@app.fastmail.com>
In-Reply-To: <3fd27fd1-b976-2705-7093-aecc6ffa0438@loongson.cn>
References: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
 <3fd27fd1-b976-2705-7093-aecc6ffa0438@loongson.cn>
Subject: Re: [PATCH v2 0/9] target/loongarch: LoongArch32 fixes 1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=202.12.124.148;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-b5-smtp.messagingengine.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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



=E5=9C=A82025=E5=B9=B42=E6=9C=8825=E6=97=A5=E4=BA=8C=E6=9C=88 =E4=B8=8A=E5=
=8D=888:50=EF=BC=8Cbibo mao=E5=86=99=E9=81=93=EF=BC=9A
> On 2025/2/25 =E4=B8=8A=E5=8D=888:40, Jiaxun Yang wrote:
>> Hi all,
>>=20
>> This series is a collection of small fixes I made to TCG for
>> LoongArch32.
>>=20
>> There are still many thing broken, especially on CSRs. More
>> series following. However this is sufficient to boot 32bit
>> kernel.
> Is there any product introduction about LoongArch32 board? such as MMU=20
> type, memory type(DDR or SRAM), interrupt controller type.

Sure, for LoongArch32 the most accessible board at the moment is chiplap=
 FPGA [1].

There are also some ASIC designs (BaiXing Project) based on chiplab.

Long in short:

- MMU: PG style
- Mmeory: DDR
- Interrupt controller: custom (Loongson-1C like) connected to CPU's
                        int pin.

Thanks

[1]: https://gitee.com/loongson-edu/chiplab

>
> Regards
> Bibo Mao
>>=20


--=20
- Jiaxun

