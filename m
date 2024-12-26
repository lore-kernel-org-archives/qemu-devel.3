Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E53E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 23:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQwtr-0002uF-1V; Thu, 26 Dec 2024 18:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQwtp-0002u5-TD
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 18:04:13 -0500
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQwto-0006mE-Do
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 18:04:13 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 8A0BE1380128;
 Thu, 26 Dec 2024 18:04:11 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Thu, 26 Dec 2024 18:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735254251;
 x=1735340651; bh=8JNhwBwotnrjkq9IU62a3BKK5/5ezoi//QQF0qOUosg=; b=
 HSz9MXqaRE+8Y6uy3GMh5RUB9lRNvhq2S7+ZzQMgO4mxQYIunUK1pFDfYEpuJCZF
 7Rsn5oVZ8VoNhdbacyHHpTqfSsnVIPmD12tIMs2RWnP3RuCq6YM01Yln3umk96dv
 JureDO/FK3gyMfTT7/lFRrag22oLCPhkQ3jxzaOFNJphwrlRUAIGDIU5Ef/GQnOY
 Wy1Eu279mm0CZXO8H6V4gxzB1bev20C72Airrpx7Llq46zRf74rttYdRNtYHCFdJ
 8TqZO3/c39MWUt9rQOIV6cRGrJ72E3CHEERxPTvA+Qkq7f3+g9/qMaO9lnQXoz/9
 b12H4cNdZkB55bVBuCeUmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735254251; x=
 1735340651; bh=8JNhwBwotnrjkq9IU62a3BKK5/5ezoi//QQF0qOUosg=; b=W
 IHBCM6C9iJOQG+Yd85XvrHuoC4dLUe2zViBlzfM6OWF88Vs+jJ9qjZTfAoVafNeM
 teEJJ2ViAKlyzHkz09ZfxQPUmCEilKSyohm0IDz+r+smNjkKuwGp1Lz/2IZQsd6A
 wsOwfLRorVDswynk7yGF3K/YECf6sVWZE4rRGdMt1q3Zq/RNqmwJRzTrIlg9BpkV
 WdUjm7oQNkfCdFNNGJ3vpejNuiYE/o0sXbGbDuFzSBTkVvyudrQfVl6EtVxAil79
 3YpEQFKlk4DbdLmsZ89AuRQZxNMc4wUTal/Uv7HTnISgAqOOz4njKVaNp6hlKPPA
 YkelpNBKAUXZVChrh/GXg==
X-ME-Sender: <xms:6uBtZxoRVeppJKXngjmmf1LnsDRGGYYsz0wbEyzkbzHF7WtkjmES-A>
 <xme:6uBtZzrAg8tnMontMMVGsoAfKpSn4_jyimazxko1UdYoqDA5o_hmIrRt_Wi5IC-Mg
 m6enSxl4uq58EL2Yfk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudduledgtdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
 necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
 hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeet
 hefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
 thdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtph
 htthhopehmrghrtggvlhdrrghpfhgvlhgsrghumhesghhmrghilhdrtghomhdprhgtphht
 thhopegvughurghrughosehhrggskhhoshhtrdhnvghtpdhrtghpthhtohepfigrnhhghi
 grnhgrnhehheeshhhurgifvghirdgtohhmpdhrtghpthhtohepiihhrghouddrlhhiuhes
 ihhnthgvlhdrtghomhdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpd
 hrtghpthhtohepghgrohhsohhngheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehm
 rghosghisghosehlohhonhhgshhonhdrtghnpdhrtghpthhtohepqhgvmhhuqdguvghvvg
 hlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegrrhhmsghruhesrhgvughhrghtrdgt
 ohhm
X-ME-Proxy: <xmx:6uBtZ-NMpX6rmiS1T-nUnWF0jUdDCf-eTuMMOsLKz_cfzEVXGcQ69g>
 <xmx:6uBtZ84anW-ZxbaeNUqPteDexGjw61B0rAHdsamqmnCif0cMIEwAeQ>
 <xmx:6uBtZw5CJUKI7ZKuxZIQEfHeotQ_NxZ9bOH0IMDf_OsByiuxS7bKYw>
 <xmx:6uBtZ0hQBC2S-LQdKr57y9Sf3Ct-6K8NXV_hCNlCldcNEalvbQ78HA>
 <xmx:6-BtZ9xzuNRpkr95woRLz2-YrcGPOMiHoiBBGNtRx9qiNZj35dnB6e5E>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 9CF741C20066; Thu, 26 Dec 2024 18:04:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Thu, 26 Dec 2024 23:03:48 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Song Gao" <gaosong@loongson.cn>, "Bibo Mao" <maobibo@loongson.cn>,
 "Eric Blake" <eblake@redhat.com>, "Markus Armbruster" <armbru@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 "Yanan Wang" <wangyanan55@huawei.com>, "Zhao Liu" <zhao1.liu@intel.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>
Message-Id: <67a7b26b-606e-4bb7-b1d3-fbfd49bdfb5e@app.fastmail.com>
In-Reply-To: <189159ad-0b0d-46db-bc58-c7e1f0ef9bc6@linaro.org>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-20-0414594f8cb5@flygoat.com>
 <189159ad-0b0d-46db-bc58-c7e1f0ef9bc6@linaro.org>
Subject: Re: [PATCH v2 20/23] hw/loongarch/virt: Default to max32 CPU for
 LoongArch 32 build
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.145;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-a2-smtp.messagingengine.com
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

=E5=9C=A82024=E5=B9=B412=E6=9C=8826=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =
=E4=B8=8B=E5=8D=8810:56=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=
=93=EF=BC=9A
> On 26/12/24 22:19, Jiaxun Yang wrote:
>> la464 CPU is not available on LoongArch32. Use max32 which makes
>> more sense here.
>>=20
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>   hw/loongarch/virt.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>=20
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index 3a905cf71d46e3c5a29672f7bb73faedf1d29444..343d2e745e155d59f0ff1=
7124b3c77ec9b3c111e 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -1440,7 +1440,11 @@ static void virt_class_init(ObjectClass *oc, v=
oid *data)
>>       HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
>>  =20
>>       mc->init =3D virt_init;
>> +#if defined(TARGET_LOONGARCH64)
>>       mc->default_cpu_type =3D LOONGARCH_CPU_TYPE_NAME("la464");
>> +#elif defined(TARGET_LOONGARCH32)
>> +    mc->default_cpu_type =3D LOONGARCH_CPU_TYPE_NAME("max32");
>
> Why can't we use it on LOONGARCH64?

I think many users are launching qemu-system-loongarch64 with default CP=
U,
better not to break them, so we only do max32 as default for
qemu-system-loongarch32.

Thanks
>
>> +#endif
>>       mc->default_ram_id =3D "loongarch.ram";
>>       mc->desc =3D "QEMU LoongArch Virtual Machine";
>>       mc->max_cpus =3D LOONGARCH_MAX_CPUS;
>>

--=20
- Jiaxun

