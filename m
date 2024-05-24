Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5EDC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 10:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sASZC-0005Kp-A3; Fri, 24 May 2024 06:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sASZ9-0005KP-LP; Fri, 24 May 2024 06:54:29 -0400
Received: from fhigh2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sASZ6-0007yk-UG; Fri, 24 May 2024 06:54:27 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id D34631140127;
 Fri, 24 May 2024 06:54:23 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Fri, 24 May 2024 06:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716548063;
 x=1716634463; bh=qKS+q3tjoIwnFnPg0++L3xg3qp9iIVD///7hq3nMgHg=; b=
 dB3HIBTUFtWJFVX5cRG3HN08CBW5wVNzZZBwHWKv7eNw+Slem3+nOPjOxpgAhypp
 l7PxORhrG80L1wfV3CUr8xSZ5CjeQJJuAbZ3eFRTy/VQBIw4QhN9EtLbZks61sjB
 Y+ps7BZ9FUoEOCvqRjo4UkllgN/5n4n3C7w5oG6Noj5TMKsgZ9MKsHZd4rpyG5ZK
 yj73UNZpTQTvVDOgLl24gxB+G93d/cP2fOEl2wmUEEebaJxZQGOTNzXi7D+zcYcZ
 umXXeQQ9eV0eyMXcXVNo2BWnUHVToTEnTRwqlkY/wGix9EzMujxrqqNAcujTCm72
 TWEf1cQ4YyMD8BUSlgVltQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716548063; x=
 1716634463; bh=qKS+q3tjoIwnFnPg0++L3xg3qp9iIVD///7hq3nMgHg=; b=Z
 rABza6HRjpBUStTp1h/39JD7AdVoNP1P0WYuIz8NQ94rbhwJb3T+XKfKoTV61eAw
 rkOezzMGrKVjqTqBoT9RVVbjUtUKgSEid1qwBN+eS8QcyRZ6OI8GvEL5ESi09dM2
 F8gyVuWy9xDfKpoGQQGNR1+FoOPsTyGltxtrs4bgF7yLSSyePpZ/5cErrPwogf4K
 8RZudGkLoNtDVG71Q2UXVoWUUdnGybRRlmC97hEFyLk25pDdAX1A1TS5JEb251bg
 96+dwciMKqsP/OwYVthrZNH4IjLms0f+doX1tB025RlmcjAzanEbqs9Ny/9CaENa
 /kEq0DDhUc14Rk/MQCsXw==
X-ME-Sender: <xms:33FQZpbhyo_hE0XFXREK0Pa6_YEBWOhDnPR7M1FWww4JgoB2zduu2A>
 <xme:33FQZgbtTNL888LHti36HFCw3VN-2qq5aIFfpHIN3AbZwzu-_4jNvejalC9FQPti-
 F5xB_xgkf1nxyWCR-c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgfeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpeehleejhfdvkeduieduiedvjeetgeehteeugfdtffeh
 gefgkedvieduieduheejhfenucffohhmrghinheptghorhhpihhtrdhruhenucevlhhush
 htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigr
 nhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:33FQZr-nnFQjhB3GYqAecgT44izRB8fgknO4oOzr8Z01QrrUM2KFcA>
 <xmx:33FQZnpyYFB_HKx8qp10BSjywu8KUTKvIWQZNN4o1tczcG49Qz27uA>
 <xmx:33FQZkoepnDGxJYgZ0koVZM68VVUyRQAtUPERmwhNTBcLfohkySKOQ>
 <xmx:33FQZtT9D88U7GlgwrBnOcwX8R6Nzmu3J_4BZ0fNubK1ZBiUYnAPGQ>
 <xmx:33FQZtm6EcwAOds8dohLuT9-DimLRkt47GpIg71MTh-oIaFV0gVAAMkw>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 4353D36A0074; Fri, 24 May 2024 06:54:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-480-g515a2f54a-fm-20240515.001-g515a2f54
MIME-Version: 1.0
Message-Id: <c95587fd-ef45-406d-8e1d-1ce9f680cdaf@app.fastmail.com>
In-Reply-To: <a53378e3-658b-43b5-8714-9be5a1fec2f3@tls.msk.ru>
References: <20240523014637.614872-1-gaosong@loongson.cn>
 <20240523014637.614872-11-gaosong@loongson.cn>
 <a53378e3-658b-43b5-8714-9be5a1fec2f3@tls.msk.ru>
Date: Fri, 24 May 2024 11:54:02 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Michael Tokarev" <mjt@tls.msk.ru>, "Song Gao" <gaosong@loongson.cn>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Richard Henderson" <richard.henderson@linaro.org>, qemu-stable@nongnu.org
Subject: Re: [PULL 10/10] hw/loongarch/virt: Fix FDT memory node address width
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.153;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh2-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8824=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8A=E5=
=8D=8811:10=EF=BC=8CMichael Tokarev=E5=86=99=E9=81=93=EF=BC=9A
> 23.05.2024 04:46, Song Gao wrote:
>> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>=20
>> Higher bits for memory nodes were omitted at qemu_fdt_setprop_cells.
>>=20
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> Reviewed-by: Song Gao <gaosong@loongson.cn>
>> Message-Id: <20240520-loongarch-fdt-memnode-v1-1-5ea9be93911e@flygoat=
.com>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   hw/loongarch/virt.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index e3bdf085b5..3e6e93edf3 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -464,7 +464,8 @@ static void fdt_add_memory_node(MachineState *ms,
>>       char *nodename =3D g_strdup_printf("/memory@%" PRIx64, base);
>>  =20
>>       qemu_fdt_add_subnode(ms->fdt, nodename);
>> -    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0, base, 0, siz=
e);
>> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", base >> 32, bas=
e,
>> +                           size >> 32, size);
>>       qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "memo=
ry");
>>  =20
>>       if (ms->numa_state && ms->numa_state->num_nodes) {
>
> This commit changes exactly the same place as the previous commit,
> v9.0.0-274-gb11f981452, "hw/loongarch: Fix fdt memory node wrong 'reg'=
".
>
> Was it the wrong fix?

Yes, I believe previous commit is the wrong fix on the same problem.

>
> Note the previous commit isn't in any released version of qemu.  So
> when picking up for any stable release, both needs to be picked up :)

Please go ahead!

Thanks
- Jiaxun

>
> Thanks,
>
> /mjt
> --=20
> GPG Key transition (from rsa2048 to rsa4096) since 2024-04-24.
> New key: rsa4096/61AD3D98ECDF2C8E  9D8B E14E 3F2A 9DD7 9199  28F1 61AD=20
> 3D98 ECDF 2C8E
> Old key: rsa2048/457CE0A0804465C5  6EE1 95D1 886E 8FFB 810D  4324 457C=20
> E0A0 8044 65C5
> Transition statement: http://www.corpit.ru/mjt/gpg-transition-2024.txt

--=20
- Jiaxun

