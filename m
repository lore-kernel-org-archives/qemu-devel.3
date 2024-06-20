Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65432C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 20:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKOjp-00080q-Bs; Thu, 20 Jun 2024 16:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sKOjj-00080W-7u
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 16:50:31 -0400
Received: from fout4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sKOjh-0001tI-Ca
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 16:50:26 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id 7C6DA13801FE;
 Thu, 20 Jun 2024 16:50:17 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Thu, 20 Jun 2024 16:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1718916617;
 x=1719003017; bh=IFQyyZmVFMr8iChSh8C7HyGRGo57KJK6EX6rI6m/Peo=; b=
 TKsNja8xrzmSkKCdkKy4Qy49aCIM5ESjmc+pwwK4ocujgVxtj/F8mYpv1DxNa++0
 zoewXllBx/jMZnmWo6S6xVoBvU/6qwjX/j4q6dWQSrr3jQyBWMQAhAUaY22vmjXr
 0xaHDkflp0a8yd5M0XOXBOZWh2Jb4/cDDJO/bmtIJ0UsXpxZjMfUs669ArS9h+et
 HIIFfuTuZs2zSROyMYBXLA1tIG/TNqOVNzCN/eu0VpxJaO/g0zcyPMmTLK3ljgLy
 oVIvyhVuCt4IROHhpMFzaoELZzaHZlq72i8/Ju8IFvfmUQBtAg6axLWo7MuSW+Mc
 5Vj2nuqUzthmGZ7Ytounhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718916617; x=
 1719003017; bh=IFQyyZmVFMr8iChSh8C7HyGRGo57KJK6EX6rI6m/Peo=; b=A
 ZJi8RXtlwst6LIscYeClICeyU6hPKI069F+ESfgy4kzC1H6PpOcI4u2hlACU/uS1
 TtooUsXRgfPQn9yBxWl6RJAnZcFYiv26kh76KyDXcTG/Ma8QmtXQZPi6SgxTa+UG
 PsmWKiYSinD5cHNmhZUy5e4srGUrSHMJ1ZTtXi5Z3nYrNZp0thObvRWi//+/4C3P
 xpHdrrnM3CBSKWz968D3FztZc3LS0k+VR1IqR+PG3wfy+WeVB2wbOmu/3LoYsq4F
 EPRmai/jJba3gIjlbdBO6BPH98gpYcSWwkopQiAvJvd1T1uAkvAR4EllZx3zOBSF
 of8UTzOVj63OPDch1K/HQ==
X-ME-Sender: <xms:CJZ0ZiREt7tMJS-5NlGj754tzMah6ihhAziEpuVSj8HL_GCZbia4Dw>
 <xme:CJZ0Znx3ZuXix_OiFIruwebo6IDqjfY_uOPksPiPyz7fq04kxc3O-fCjvHyjD1BFT
 Xc0prX3EEXYaLRq5Yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefvddgudehiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
 lfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtg
 homheqnecuggftrfgrthhtvghrnhephfdtkeefgeelkeeggfduhfegudelheefgfeggffh
 fefhffdtgfegvdfhtdfhtedvnecuffhomhgrihhnpehiohgtshhrrdhmrhenucevlhhush
 htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigr
 nhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:CJZ0Zv2fqmErHZCpPePBFmC_hOG-nyn8sSlACGJpxUCiOpu5IQrFCg>
 <xmx:CJZ0ZuDYggmk6eIY_nkgJ6MfSRAo8jwKzZO9RMraT1tctPXYWzyb9A>
 <xmx:CJZ0ZrhbUwZQEEya0KYU09ws57A-5VOgy5cqA1cRe3ot96cRKPhh8A>
 <xmx:CJZ0Zqr5azSzLxvVgIe63ZFK4-hs-zBeBPZNGYaGg3gxnBXf_oMxYQ>
 <xmx:CZZ0ZusnGd2Sq7UzBGHivwu55Gx_g5n2wKt6gRDr7q6MeAUf6yE_1HVX>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id AE1D236A0075; Thu, 20 Jun 2024 16:50:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
MIME-Version: 1.0
Message-Id: <752417ad-ab72-4fed-8d1f-af41f15bc225@app.fastmail.com>
In-Reply-To: <d1fb28b8-15a4-401f-933b-2388af390bd8@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
 <20240618160039.36108-66-philmd@linaro.org>
 <d1fb28b8-15a4-401f-933b-2388af390bd8@linaro.org>
Date: Thu, 20 Jun 2024 21:49:56 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Song Gao" <gaosong@loongson.cn>
Subject: Re: [PULL 65/76] hw/mips/loongson3_virt: Wire up loongson_ipi device
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.147;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout4-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B46=E6=9C=8820=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=E5=
=8D=888:50=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=93=EF=BC=9A
[...]
> Do you mind posting a patch fixing it?

I'll prepare a series tomorrow with your comments on this patch before.

Thanks
- Jiaxun
>
>> +            hwaddr base =3D ((hwaddr)node << 44) + virt_memmap[VIRT_=
IPI].base;
>> +            base +=3D core * 0x100;
>> +            qdev_connect_gpio_out(ipi, i, cpu->env.irq[6]);
>> +            sysbus_mmio_map(SYS_BUS_DEVICE(ipi), i + 2, base);
>> +        }
>> +
>> +        if (ase_lcsr_available(&MIPS_CPU(cpu)->env)) {
>> +            MemoryRegion *core_iocsr =3D g_new(MemoryRegion, 1);
>> +            g_autofree char *name =3D g_strdup_printf("core%d_iocsr"=
, i);
>> +            memory_region_init_alias(core_iocsr, OBJECT(cpu), name,
>> +                                     iocsr, 0, UINT32_MAX);
>> +            memory_region_add_subregion(&MIPS_CPU(cpu)->env.iocsr.mr,
>> +                                        0, core_iocsr);
>> +        }
>> +
>> +        if (node > 0) {
>>               continue; /* Only node-0 can be connected to LIOINTC */
>>           }
>>  =20
>>           for (ip =3D 0; ip < 4 ; ip++) {
>> -            int pin =3D i * 4 + ip;
>> +            int pin =3D core * LOONGSON3_CORE_PER_NODE + ip;
>>               sysbus_connect_irq(SYS_BUS_DEVICE(liointc),
>>                                  pin, cpu->env.irq[ip + 2]);
>>           }

--=20
- Jiaxun

