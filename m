Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20242C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU3F7-0004M9-JU; Wed, 17 Jul 2024 07:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sU3F4-0004Ez-SC
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:54:42 -0400
Received: from fhigh3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sU3El-0005fL-ED
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:54:39 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id B2EA111401D4;
 Wed, 17 Jul 2024 07:54:20 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute2.internal (MEProxy); Wed, 17 Jul 2024 07:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721217260;
 x=1721303660; bh=saSUrcE0htd+ld2AIN6wzF70vaWYNlPFDN349Wottt0=; b=
 P5b4nZdCTb65EJuXyE0L2AQRMXOFu4RDp4XaS4y/HdF/0zDPc6/czFbpea2LXaqf
 4IySfFzDkzb8rdr/jo/skuW20YIGXFJ/zFmQgCwj6QEqiVgp87ZOPxLkCTO72zlA
 HGRsjnQWBtmD4sYDxm1/4EKYvUXrTZEKHneA5/nbNRZNc1wwpOB34GEzMmgtpkM0
 zgCi80oxQIbI5igBPlm5qOZlPlDGkh2lvmcmiUgUTiSm3fyFTjctq80Qk+bDvi0H
 dt8AssZHCiS+i1jU4U8tgY2i2PAy2JE9gx6oT1yWpU3wrdnmi96bkscMbKUBsOUu
 96MQndUiZA8DIO+gZ4Pn8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721217260; x=
 1721303660; bh=saSUrcE0htd+ld2AIN6wzF70vaWYNlPFDN349Wottt0=; b=k
 DPkKOSGTlWm0pBbqxlLkVLCbSvAYxqFB8Opoe7OFoud390xMt1/guNJFtSKUPMp5
 F37UPNz/yE+GzukOcgvVbi97g1FopNJ9B9TG44RJIsvb0BVaLsDlcd2LxWOnhhFv
 bGZp6fald4K3v1bYyyh0XRAgKF9DjcFrqhRuoft4b2kCZR0FOaNyp60TiGkY3qCJ
 wTULUEyHzfpJsGyXqyQfQNQwjLs1XTzs7trMjCiF89/xbtuEJ+6I56Hjx2xDlino
 s/o70NoJNp7hTKgUo2kZBXMLopmOHmUathXXAQaZxV/2STdRuONaoaJgVRgkwI4K
 4g6levjuw3hVvSqd+y1Ng==
X-ME-Sender: <xms:67CXZotNkJOmASihISJCQCqFZtn0IVRZxsQ1vanh3xAr6dD5n7I4YA>
 <xme:67CXZlcCNshW3WUEQNLwDyOpSsn3blcN8NWc2oAV4NXgYlMw-zIRPtE04Wowqp1mI
 kBgE2iYaiVDjLOnm7U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdeghecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
 rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
 eqnecuggftrfgrthhtvghrnhepkeelveffhedtiefgkeefhffftdduffdvueevtdffteeh
 ueeihffgteelkeelkeejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
 htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigr
 nhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:67CXZjyBrVZfaVhlqDNNGBV-aeq99EKa12C849Y2Jae5ORsf1UUWdg>
 <xmx:67CXZrNaLzqUcl8LrEdeEOiKr4VQUV-GmiCw2nUNEs2zHZVQ08SAuQ>
 <xmx:67CXZo807mQNnRH-bIAi-AFvfYxQPY7QvwB_CgtYILxVPRAZ5Au7Dw>
 <xmx:67CXZjV3X_NA-_zNU8CAVtUFAAM9_o-c6TTxC0wRaviFWwwzVHnyRQ>
 <xmx:7LCXZsbrWM2hfSoZr0PJTySldyX3DHVGGkkKPZZZPzShXgPWopBX_bpg>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 3102C36A0074; Wed, 17 Jul 2024 07:54:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
MIME-Version: 1.0
Message-Id: <80bdfa26-8638-4022-bbd4-e93b6132fc8a@app.fastmail.com>
In-Reply-To: <51574a26-9f62-e069-f8db-d7f243f89b44@loongson.cn>
References: <20240704033802.3838618-1-maobibo@loongson.cn>
 <682d514b-1d49-4e23-9cb7-a6fd83cbd863@linaro.org>
 <d26cf86a-2247-b5d9-3674-64cead2fa816@loongson.cn>
 <b4a9e1e9-467c-2d50-0d24-174fc9e5c5fe@loongson.cn>
 <4061a31e-1cd8-4cd7-96f3-3e5208e12a87@linaro.org>
 <51574a26-9f62-e069-f8db-d7f243f89b44@loongson.cn>
Date: Wed, 17 Jul 2024 19:53:56 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Paolo Bonzini" <pbonzini@redhat.com>, "Song Gao" <gaosong@loongson.cn>
Cc: "QEMU devel" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 0/4] Reconstruct loongson ipi driver
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.154;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh3-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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



=E5=9C=A82024=E5=B9=B47=E6=9C=8817=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=E5=
=8D=885:22=EF=BC=8Cmaobibo=E5=86=99=E9=81=93=EF=BC=9A
> On 2024/7/16 =E4=B8=8B=E5=8D=882:40, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 16/7/24 03:29, maobibo wrote:
>>>
>>>
>>> On 2024/7/16 =E4=B8=8A=E5=8D=889:04, maobibo wrote:
>>>>
>>>>
>>>> On 2024/7/15 =E4=B8=8B=E5=8D=8811:17, Philippe Mathieu-Daud=C3=A9 w=
rote:
>>>>> On 4/7/24 05:37, Bibo Mao wrote:
>>>>>> Now loongson ipi and loongarch ipi share the same code with diffe=
rent
>>>>>> macro, loongson ipi has its separate function such mmio region,
>>>>>> loongarch ipi has other requirement such as irqchip in kernel.
>>>>>>
>>>>>> Interrupt irqchip has strong relationship with architecture, since
>>>>>> it sends irq to vcpu and interfaces to get irqchip register is al=
so
>>>>>> architecture specific.
>>>>>>
>>>>>> Here like other architectures, base class TYPE_LOONGSON_IPI_COMMON
>>>>>> is added, it comes from loongson ipi mostly. And it defined four=20
>>>>>> abstract
>>>>>> interfaces which can be used for MIPS 3A4000 and Loongarch 3A5000=20
>>>>>> machine,
>>>>>> also can be used for 3A5000 irqchip in kernel mode soon.
>>>>>>
>>>>>> Also Loongarch ipi and loongson ipi device are added here, it inh=
erits
>>>>>> from base class TYPE_LOONGSON_IPI_COMMON. Loongarch ipi is tested,
>>>>>> loongson ipi device only passes to compile and make check, it is =
not
>>>>>> tested.
>>>>>>
>>>>>> Bibo Mao (4):
>>>>>> =C2=A0=C2=A0 hw/intc/loongson_ipi_common: Add loongson ipi common=
 class
>>>>>> =C2=A0=C2=A0 hw/intc/loongarch_ipi: Add loongarch ipi support
>>>>>> =C2=A0=C2=A0 hw/loongarch/virt: Replace loongson ipi with loongar=
ch ipi
>>>>>> =C2=A0=C2=A0 hw/intc/loongson_ipi: reconstruct driver inherit fro=
m common class
>>>>>
>>>>> I'll try to respin a clearer v3.
>>>> I am ok with it since it solve the problem, and it is suitable for=20
>>>> 9.1 release. Only that in the long time we hope that intc emulation=20
>>>> driver has common base class + tcg/kvm driver, similar with other=20
>>>> architecture.
>>>>
>>> Sorry for the confusion, I had thought it was another topic.
>>>
>>> Thanks for pointing out the problem and welcome the v3 version.
>>=20
>> Please do not post v3, let me post it.
> Hi Philippe,
>
> QEMU 9.1 is coming to soft frozen stage, do you have enough time worki=
ng=20
> on it?  Is it ok to use bugfix patch for 9.1 release version?

Bug fix is always qualified between soft freeze and release.

I tested the series for MIPS yesterday and can confirm it do work.

Will give my tags on v3.

Thanks

> https://lore.kernel.org/all/20240627125819.62779-2-philmd@linaro.org/
>
> After 9.1 is released, there will be enough time for patch v3.
>
> Regards
> Bibo, Mao

--=20
- Jiaxun

