Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A14C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 08:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOCQM-00068X-GD; Mon, 01 Jul 2024 04:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sOCQ1-000664-IF
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:29:49 -0400
Received: from fout7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sOCPz-0002sL-Pc
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:29:49 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id B1C1213802D5;
 Mon,  1 Jul 2024 04:29:46 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Mon, 01 Jul 2024 04:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1719822586;
 x=1719908986; bh=u1O9mJ7L1LNKG6nph+UiwGm/XtnWbdsxHsT5UUGvze0=; b=
 PDknan5nwBZOaGYKWlofVO+45RMqTGoD/mXtjk9pHPm7VmHBIUhsiMeDjFZ0O6fy
 DY/jhwovfi1FaVthZRJM2LoyhsJ4EZcPeZoVTGjVOrGxU0iokWLl0mINCKcLHiZ0
 VUuOrZiGzA/7g1mOthWPXTpWaU81hSOcFIK9WUtPovo0VCn4/Hl7FYON8drBZMRH
 GfYEr68KLB0anx5MJPXNTUCSp7++rZlalBRpopUxQu6tnvVpCC0+QS/txfVQbVTx
 YfaCd/3BSTVSVEFBasSnucdj5Bww9rpMMb9Ypcchh3hMElLLs21oJ9rFUpi+GMp/
 XBQQHqgWRQB/Sgjq0uaVkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719822586; x=
 1719908986; bh=u1O9mJ7L1LNKG6nph+UiwGm/XtnWbdsxHsT5UUGvze0=; b=q
 3FyuNXIdZLeCnYx7dtqc9NAg6MsAvaR9NWKElOnssloOktbaGLZuwofUwpU8wYav
 uMddBsl5qqUPeP0kLAostyBmGmdNhYBy31OfqzP/y875rMLjz8/VtvckGkNLM3Kg
 PeutJbdovMaWMhhuIkw9gVKNBU13NnTwjNzsM3gZioJmfpAIbY2gITRWRbxLrttz
 P3tRBRqxytxfPPXvhHxbshLJX3BYnzrhT84dD60rw0ok3AmJ8rKcX2tP7ZtoMx6T
 HLvNhm8/VzV0kwd6QuBKUw35awADXbKuCBXbEdWptxGnuE/wo5g2HAMN+uOPIZsY
 Ev1wfcn8vJQKMJVVeJ1ng==
X-ME-Sender: <xms:-miCZp7LgFvNhEe1g2EmDLAJEuZxG53VXK8wNYW19qaF9XzmQGvSXw>
 <xme:-miCZm7CZK5a3AFFTArSpaGCQsatMBtP5VHdC316yro-rSp6A2Y9OBPRRiXkwkST_
 UICzZ0VoCfBwuHVy6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgddtgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
 rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
 eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
 geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:-miCZgf1XWB12HL4OYs15y2d_CdGS7CLTT-R2oQTfR8_RDI3kQ5dPQ>
 <xmx:-miCZiIKfaucjL72-_Bt-EUEgQL6DJSyzx_EFMWBBL5Ev6V51W10Zg>
 <xmx:-miCZtKg82rSMZ_W4EyIDFHUGFLPUyuZXB0Ux1YJ86XlBEl9qFKq6g>
 <xmx:-miCZrzBtkrVPOyuKMl6Esw1NYr1i3YZqeRaoaPMqy475AmEvAP3Lg>
 <xmx:-miCZl9UUGxoR3r2-gArxDzYxJ4qv54dm8jUPmkKW16U01iOeEElF4mQ>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id F1CE936A0074; Mon,  1 Jul 2024 04:29:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
MIME-Version: 1.0
Message-Id: <dd0754c2-2a42-4cf4-8c23-eb7a1ca100b5@app.fastmail.com>
In-Reply-To: <c817c31b-3f22-da1a-c110-4873e1a36eab@loongson.cn>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
 <20240605-loongson3-ipi-v3-1-ddd2c0e03fa3@flygoat.com>
 <e1b8bbd8-2a9d-2417-1123-4aabfdedb684@loongson.cn>
 <002f4e7e-682b-479b-9c6c-8971a0e6640a@linaro.org>
 <8d975e9c-c2fd-09c8-7a37-5aebc63656d4@loongson.cn>
 <9a0f73c6-33e9-4576-9056-6a5fd0718630@linaro.org>
 <ceebb4ea-a417-0985-d45e-3988d76e2086@loongson.cn>
 <3544da40-d680-20f2-d7af-cf304d07bc8d@loongson.cn>
 <74a9606c-3b3b-4af3-8242-944619f898c9@app.fastmail.com>
 <c817c31b-3f22-da1a-c110-4873e1a36eab@loongson.cn>
Date: Mon, 01 Jul 2024 09:29:30 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 gaosong <gaosong@loongson.cn>, "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Huacai Chen" <chenhuacai@kernel.org>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Peter Maydell" <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 1/4] hw/intc: Remove loongarch_ipi.c
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.150;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout7-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B47=E6=9C=881=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8A=E5=
=8D=888:22=EF=BC=8Cmaobibo=E5=86=99=E9=81=93=EF=BC=9A
> On 2024/7/1 =E4=B8=8B=E5=8D=883:01, Jiaxun Yang wrote:
>>=20
>>=20
>> =E5=9C=A82024=E5=B9=B47=E6=9C=881=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8A=
=E5=8D=887:44=EF=BC=8Cmaobibo=E5=86=99=E9=81=93=EF=BC=9A
>>> Also this patch is problematic on LoongArch.
>>>
>>> The original patch is to search physical cpuid rather than logic cpu=
id.
>>>
>>> We want to make ipi module better and better, however now it comes b=
ack
>>> to initial state at the beginning :(
>>=20
>> Isn't arch_id the "physical id" you want? "cs->cpu_index" is the logi=
cal ID
>> for QEMU.
>>=20
>> arch_id is setup by arch code, like APIC ID for x86.
>>=20
>> I had come across the old ipi_getcpu  implementation, and I'm sure we=
 were
>> looking at arch_id as well.
> So, where is implementation code for function get_arch_id() looking fo=
r=20
> vcpu with physical index?

Hi Bibo,

cpu_by_arch_id will be redirected to:

```
CPUState *cpu_by_arch_id(int64_t id)
{
    CPUState *cpu;

    CPU_FOREACH(cpu) {
        CPUClass *cc =3D CPU_GET_CLASS(cpu);

        if (cc->get_arch_id(cpu) =3D=3D id) {
            return cpu;
        }
    }
    return NULL;
}
```

It iterates over all vcpus and return CPUStates with corresponding arch_=
id.

Whereas, for LoongArch's get_arch_id implementation:
```
static int64_t loongarch_cpu_get_arch_id(CPUState *cs)
{
    LoongArchCPU *cpu =3D LOONGARCH_CPU(cs);

    return cpu->phy_id;
}
```
I believe it matches our intension here.

Thanks

>
> Regards
> Bibo Mao
>
>>=20
>> Thanks
>> - Jiaxun
>>>
>>> commit 03ca348b6b9038ce284916b36c19f700ac0ce7a6
>>> Author: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> Date:   Wed Jun 5 10:04:27 2024
>>>
>>>       hw/intc/loongson_ipi: Replace ipi_getcpu with cpu_by_arch_id
>>>
>>>       cpu_by_arch_id is doing the same thing as our ipi_getcpu logic.
>>>
>>>       Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>>       Reviewed-by: Song Gao <gaosong@loongson.cn>
>>>       Message-ID: <20240605-loongson3-ipi-v3-4-ddd2c0e03fa3@flygoat.=
com>
>>>       Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>>
>>>
>>> Regards
>>> Bibo Mao
>>>

--=20
- Jiaxun

