Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B02DC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 04:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHyXW-000659-RY; Fri, 14 Jun 2024 00:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sHyXU-00064h-TS
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 00:27:48 -0400
Received: from fhigh6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sHyXT-0000rj-0L
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 00:27:48 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id DE6AB114025C;
 Fri, 14 Jun 2024 00:27:45 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Fri, 14 Jun 2024 00:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718339265;
 x=1718425665; bh=1hjgK+kAYfTTKu3Gmtob3biK7TLVqlkZYrjHaELYD5w=; b=
 LpRcB+mZJBfk85L/Q5cGWeYG0fo85TCf6aZTL0awKrkjeyDf1vyr3T2MhpxSI7An
 Xqj8J3kBYQnhWS+MK0gItDnP6mvypFkQorjSGVTkfwlFe6PO+WesWpHXRJmQd5tL
 uevDLEELlJVcHH8xWvax6wiZHFnEpJr69RmSXrVzM4bdfzRNt8lWOzeRfycdoQET
 e5IexX2ztN7PUZjtQUrl0lSDDr0qVyKRr6A7mVOAUXUy0DPxJpxbl8ZtThzxGi3g
 qKFcaxzdNjvdjc2odCMNSbOkCsmSFXo6t+dGUqrts1gRo3+nqHr1B65Nb4LhIgPB
 aPYFST6DHVZ0TzcpNdBVNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718339265; x=
 1718425665; bh=1hjgK+kAYfTTKu3Gmtob3biK7TLVqlkZYrjHaELYD5w=; b=U
 SVk+TOMXxYNJ8PKdpFqYZwJfMFLWVyF/dncdxyYXkqbgpF/itQqB00nMakv30763
 csjfADQ/ALivIjI08hlOovEKihwJDrABHPbAsoTvXXUFBf5/mMADO46lYrRt+Xbf
 NQo6Vo4QKmzof1mhTpMgqdGkmKYmXvfEOy9rGPzmEVvScK6QqrwrvBgLC4UY7eYM
 ps6imllpePlQbb4po0AAw1k+sUCi4c9XkPanbVg8L9rO78gZOm+g8ZO2lEED1o5i
 UUhyaAARjoZ3PGXTkmxan/DQyM3EIlKMiem+82FhwgFzfsLx9kcChJiro/7nR6np
 WCMdD17JIVTWVJI5cKnAQ==
X-ME-Sender: <xms:wcZrZswStrE1tlo8q_cryOz-7HoHLR9I-Y-riHMgm0fNXd8pAO256Q>
 <xme:wcZrZgRlb8NjtMVd8YUdj29uff5lRkJsRoX8fLXU0YwV2UW0nXQ_EYtm0ULyz1ehM
 gbCIlf3umwsD-hSKCI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedgjeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpeekleevffehtdeigfekfefhffdtudffvdeuvedtffet
 heeuiefhgfetleekleekjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
 hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdih
 rghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:wcZrZuXyP9pBP8ltHlVVGAh10Mp1_BesoR3sn5GpImuAVNwjzs_Yfw>
 <xmx:wcZrZqiVcyd7F0VZ1s70qmZb9oBLWY_hXy0QtglnoblUf57SwYaB0w>
 <xmx:wcZrZuBsz4eifLiJKgAVPy2bT4xFHbtRkJgh5EMqfdiYzpI2a4CPxw>
 <xmx:wcZrZrI3iU7dmjdKKnqVljHVK53MCWIvTapFt9lYj1L4tXYgTy5ONA>
 <xmx:wcZrZi73agBPgM64mrxFgYudKwBLcsDe7G40cUbZTR_M5gNo_UHiVJ0O>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 1859936A0074; Fri, 14 Jun 2024 00:27:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
MIME-Version: 1.0
Message-Id: <ac2dbd67-97f7-4748-b545-3d05cb1d9a36@app.fastmail.com>
In-Reply-To: <002b6625-9fed-beeb-700c-93438023d873@loongson.cn>
References: <20240613-loongarch64-sleep-v1-0-d2ef0aaa543a@flygoat.com>
 <002b6625-9fed-beeb-700c-93438023d873@loongson.cn>
Date: Fri, 14 Jun 2024 05:27:25 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>, "QEMU devel" <qemu-devel@nongnu.org>,
 "Ani Sinha" <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "Igor Mammedov" <imammedo@redhat.com>, "Song Gao" <gaosong@loongson.cn>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 "Sergio Lopez" <slp@redhat.com>
Subject: Re: [PATCH 0/3] S3 and S4 sleep for loongarch/virt & microvm
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.157;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh6-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B46=E6=9C=8814=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=884:32=EF=BC=8Cmaobibo=E5=86=99=E9=81=93=EF=BC=9A
> It is interesting.
>
> How to wakeup VM if it sleeps in S3/S4, from emulated keyboard or=20
> ethernet magic packet or qemu monitor command in background?

Hi Bibo,

The best way to wake the guest is system_wakeup command in monitor.

Thanks
- Jiaxun

>
> Regards
> Bibo Mao
>
>
> On 2024/6/14 =E4=B8=8A=E5=8D=881:30, Jiaxun Yang wrote:
>> Hi all,
>>=20
>> This series implemented S3 and S4 sleep for loongarch virt machine
>> and microvm.
>>=20
>> For loongarch/virt a kernel patch is requried [1].
>>=20
>> [1]: https://lore.kernel.org/loongarch/20240613-loongarch64-sleep-v1-=
0-a245232af5e4@flygoat.com/
>>=20
>> Please review.
>> Thanks
>>=20
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>> Jiaxun Yang (3):
>>        acpi/ged: Implement S3 and S4 sleep
>>        hw/loongarch/virt: Wire up S3 and S4 sleep
>>        hw/i386/microvm: Wire up S3 and S4 sleep
>>=20
>>   hw/acpi/generic_event_device.c         | 70 +++++++++++++++++++++++=
+++++++----
>>   hw/i386/acpi-microvm.c                 | 18 +++++++++
>>   hw/i386/microvm.c                      |  3 ++
>>   hw/loongarch/acpi-build.c              | 18 +++++++++
>>   hw/loongarch/virt.c                    |  3 ++
>>   include/hw/acpi/generic_event_device.h | 12 +++++-
>>   6 files changed, 115 insertions(+), 9 deletions(-)
>> ---
>> base-commit: f3e8cc47de2bc537d4991e883a85208e4e1c0f98
>> change-id: 20240613-loongarch64-sleep-37b2466b8d76
>>=20
>> Best regards,
>>

--=20
- Jiaxun

