Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3265C38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 04:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sROVh-0006j4-10; Wed, 10 Jul 2024 00:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sROVd-0006hq-DW
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 00:00:52 -0400
Received: from fout1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sROVb-0000gt-NP
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 00:00:49 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id 78AD21381496;
 Wed, 10 Jul 2024 00:00:45 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Wed, 10 Jul 2024 00:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1720584045;
 x=1720670445; bh=seMt1EsaCT5ubOudGEXUKj81NxX0kjEq8/hucl3DCBQ=; b=
 FHGxSQ3Ealv04xv9nSk3js8AP3J6RLSMZmKU2+8IUtxdoczf8CsZg20Q6ufFlRdF
 Mf3OIL6xQNrofdOeq7UTWOKcL/kUeowcTPdVHzOxOxTJe79WEIvisrcgxS/2aw47
 SCrthvJQNAbWuma8HeS/yw+vYM0r2+Ejh89j31ZJ4ww0+PycNfbU85X4YbLwkR3T
 lzLprk3tL8WIsbDyL+Z6tfReADD47rR1TOn3yuSgrRzTC/7Sp8nT+iZ9w3dOJxZ3
 KAGdVCsV0XydUwuU8Y9au7afkHC2YVPmlrmsPt4y5tWHc7VQ3zTTwOxvqj0AzHcm
 y5oRfOi6BKNtp91R1BjzrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720584045; x=
 1720670445; bh=seMt1EsaCT5ubOudGEXUKj81NxX0kjEq8/hucl3DCBQ=; b=m
 XaVBiqUmiqxyNBcePttvCkg9Y7ObHIgUZOSkRGCaDpfjgNRTilbJONvwnxj4sVsU
 +X0yr23l1DHQ7hRkGcTyVJqZAlp1jQMgUp3T7SJbY/jvps1+VSY3pWWxzE6CNXt7
 U8WHySdfF6G+N+In9n8f4bsJsyUoIIOawJw34wHuoopwRQOZ1/DLtZ1TkwaoSfan
 /BbM+COq6wvVL+p/1AT6xnBmmA3+SZHgLtRrBvYHIOIDku9CJbz2mkw5LPfCJuuB
 qSwanoRhamkxJnNqxhiQ2N4ttUXEqsyyHNXrrpuCiSon0ke16JhLelOjrW75mdvu
 adXp1OcKFEt+DtLYutNXg==
X-ME-Sender: <xms:bAeOZp2rtbY4KYgl-xRGuENqXrDAwMC78kdvavrTC_Ms-3DMb5-soA>
 <xme:bAeOZgE8O6YtZaIblZ33FyOWDUdVgxOBvTOWC8--EzYtlOlOKP08MI1KG5W3K0GZ2
 TQhnkpTMx3dmGFvxf8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfedtgdejkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
 rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
 eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
 geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:bAeOZp7KbSUBTIcVRTflUWMQ3wiBBjVzsxXhNRE_ufzDzA53aBUlFQ>
 <xmx:bAeOZm2lVKb7zQjEqHjhU5mHOhr0PT6uQ0q3HeqywRXPm222FyWXmw>
 <xmx:bAeOZsEhaiEVNgFzLT4OARBvMxJUQ_aLqH3ckdf_WKLRlUKhEbWQZw>
 <xmx:bAeOZn9hVpGovMfWMiwlrkJToI2tReST91x4DDvRZCz06GLuxMgodw>
 <xmx:bQeOZoiXNhmJ1-efqvDjzwAF9bBU5htjgS8BNWEkSNUt-vgncwqy6mOl>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id E79E736A0074; Wed, 10 Jul 2024 00:00:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
MIME-Version: 1.0
Message-Id: <db13dadd-6a04-4da1-893e-e613ad39ab15@app.fastmail.com>
In-Reply-To: <fb5d8ffb-b183-ffbe-b64a-c4506b5b546d@loongson.cn>
References: <20240704033802.3838618-1-maobibo@loongson.cn>
 <fb5d8ffb-b183-ffbe-b64a-c4506b5b546d@loongson.cn>
Date: Wed, 10 Jul 2024 12:00:11 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Song Gao" <gaosong@loongson.cn>
Cc: "Paolo Bonzini" <pbonzini@redhat.com>, "QEMU devel" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 0/4] Reconstruct loongson ipi driver
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.144;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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



=E5=9C=A82024=E5=B9=B47=E6=9C=889=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=E5=
=8D=888:04=EF=BC=8Cmaobibo=E5=86=99=E9=81=93=EF=BC=9A
> Hi Philippe/Jiaxun,
>
> Could you do me a favor giving a review about this patch?

Hi Bibo,

I=E2=80=99m currently traveling, will test and review next week.

I=E2=80=99m not really convinced to give a R-b but I=E2=80=99m fine with=
 a T-b.

Thanks

>
> Regards
> Bibo Mao
>
> On 2024/7/4 =E4=B8=8A=E5=8D=8811:37, Bibo Mao wrote:
>> Now loongson ipi and loongarch ipi share the same code with different
>> macro, loongson ipi has its separate function such mmio region,
>> loongarch ipi has other requirement such as irqchip in kernel.
>>=20
>> Interrupt irqchip has strong relationship with architecture, since
>> it sends irq to vcpu and interfaces to get irqchip register is also
>> architecture specific.
>>=20
>> Here like other architectures, base class TYPE_LOONGSON_IPI_COMMON
>> is added, it comes from loongson ipi mostly. And it defined four abst=
ract
>> interfaces which can be used for MIPS 3A4000 and Loongarch 3A5000 mac=
hine,
>> also can be used for 3A5000 irqchip in kernel mode soon.
>>=20
>> Also Loongarch ipi and loongson ipi device are added here, it inherits
>> from base class TYPE_LOONGSON_IPI_COMMON. Loongarch ipi is tested,
>> loongson ipi device only passes to compile and make check, it is not
>> tested.
>>=20
>> Bibo Mao (4):
>>    hw/intc/loongson_ipi_common: Add loongson ipi common class
>>    hw/intc/loongarch_ipi: Add loongarch ipi support
>>    hw/loongarch/virt: Replace loongson ipi with loongarch ipi
>>    hw/intc/loongson_ipi: reconstruct driver inherit from common class
>>=20
>>   hw/intc/Kconfig                       |   3 +
>>   hw/intc/loongarch_ipi.c               |  80 ++++++
>>   hw/intc/loongson_ipi.c                | 330 ++-------------------
>>   hw/intc/loongson_ipi_common.c         | 394 +++++++++++++++++++++++=
+++
>>   hw/intc/meson.build                   |   3 +-
>>   hw/loongarch/Kconfig                  |   2 +-
>>   hw/loongarch/virt.c                   |   4 +-
>>   include/hw/intc/loongarch_ipi.h       |  33 +++
>>   include/hw/intc/loongson_ipi.h        |  54 ++--
>>   include/hw/intc/loongson_ipi_common.h |  77 +++++
>>   include/hw/loongarch/virt.h           |   1 -
>>   11 files changed, 632 insertions(+), 349 deletions(-)
>>   create mode 100644 hw/intc/loongarch_ipi.c
>>   create mode 100644 hw/intc/loongson_ipi_common.c
>>   create mode 100644 include/hw/intc/loongarch_ipi.h
>>   create mode 100644 include/hw/intc/loongson_ipi_common.h
>>=20
>>=20
>> base-commit: 6746482d12da3b6e4d3cdf06481a0027a797f719
>>

--=20
- Jiaxun

