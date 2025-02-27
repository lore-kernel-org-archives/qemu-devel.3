Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A33C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbNe-0005k2-5N; Thu, 27 Feb 2025 05:44:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tnbNV-0005jC-Fv
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:44:31 -0500
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tnbNS-0004Fe-Hb
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:44:28 -0500
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 2FC85114015F;
 Thu, 27 Feb 2025 05:44:23 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-03.internal (MEProxy); Thu, 27 Feb 2025 05:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1740653062;
 x=1740739462; bh=NpP9cr889mOnA+deJU2opomBK43EdE7lLP2L/rDxvbg=; b=
 n1oIjzdo6R5Kwoq0GpHY5PDh7LkR6GJ9yMVgdMMj92SIe8aESW8gvSTqLSRUDzVU
 s3zwFaLORypZRo3An1D3aUJbgcfrHwUqOFEE1EO7J2KbccdWiIPxCIhVTzvPYjx+
 XYXax0tOooQOSv2NhploCoOnA8GYadKkMsPGpDtBPkg13YZauMFKQeOJpt9AWPW3
 ygbFZ+sDIs1VG+H0Ux2mFPYW6RJypRS3RVvPquli/SkwFjrejO4VjiYehmn+PkMd
 XKqjRxvZ+IIivucn0W5954tq1CpyfgFpgaMeymy3bz/daOY1Gd5pVx9hxmJWFLZD
 a1YpWEUFyJK9PDEsiKRNaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740653062; x=
 1740739462; bh=NpP9cr889mOnA+deJU2opomBK43EdE7lLP2L/rDxvbg=; b=g
 t1zfTkDOZhN04pY2YWrib60RbCOXoipb6LiVeiftS2UhcrMKq3F4nLyzJzIYgjFC
 q5rqaPIpb31nBRJdGqaSHMtmP05/ruMNVIeK4S2hN+Yq/WLWSPKyGFclOS/L5GUG
 EDnxZsz9evWBciaun1g5IA3LGmT7MfJkAdc4TT0b30XJTJ8xLsg8fd3cgzHEzH7v
 KNIcROmGXA1V58FT1cHuVUr/hhPcfkcNTgQCsEDEyJKXDWs5f2Pa0mYfwr5Kiiwz
 LROseTfeih31vRJ4IAhnnxv3OP1OvwZ8Vdzoo5SgVHcCr3zXCk2bbahLFEZj1Yur
 VXqGORad8+tDSbjyFSeiw==
X-ME-Sender: <xms:BkLAZxBQWw7DWN6Z_GSi-l9mJXEGg6mShnmgNnwSPMM_bHkzXNjOsA>
 <xme:BkLAZ_iShR2FiQuZ0QIKsAOlCrcJKLzvgPHz48KP2uo3Qs-X5fpgkbvKqLYvMbtD6
 2rV85BHbhKuJoT6vI4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjedvhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:BkLAZ8m76heB7v3U6qgJl68XSFdZMBgykEzw6o8DDJZapBwMXvPnlw>
 <xmx:BkLAZ7z218NIf_HcxOfprZjBGBhgLipZBbH4sXQUHGgWjhUMUb8UjQ>
 <xmx:BkLAZ2S6NCTLox4fbZdel2_OUNw78gnqQRa0VphSS4DRGf5aY-v6Fw>
 <xmx:BkLAZ-bQ_9YcydE5y3UEmoyWd2bvmXu_wTNA6XEKtZ6oI-wMdK7H7w>
 <xmx:BkLAZ0ctn4oaLGnE7qDkciNHRfqnCzhXKqiHAf5b4L4NUVTAPMggIJah>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 537721C20066; Thu, 27 Feb 2025 05:44:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Thu, 27 Feb 2025 10:44:03 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>, "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Song Gao" <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Message-Id: <b3aa056b-cde8-4f4f-879a-70b1c10e6824@app.fastmail.com>
In-Reply-To: <baa9614a-a216-58bb-3bce-d56da0c7f287@loongson.cn>
References: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
 <3fd27fd1-b976-2705-7093-aecc6ffa0438@loongson.cn>
 <23d25d66-07f4-454b-903a-f5704e1e686c@app.fastmail.com>
 <baa9614a-a216-58bb-3bce-d56da0c7f287@loongson.cn>
Subject: Re: [PATCH v2 0/9] target/loongarch: LoongArch32 fixes 1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=202.12.124.145;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-b2-smtp.messagingengine.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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



=E5=9C=A82025=E5=B9=B42=E6=9C=8825=E6=97=A5=E4=BA=8C=E6=9C=88 =E4=B8=8B=E5=
=8D=8812:33=EF=BC=8Cbibo mao=E5=86=99=E9=81=93=EF=BC=9A
> On 2025/2/25 =E4=B8=8B=E5=8D=888:08, Jiaxun Yang wrote:
>>=20
>>=20
>> =E5=9C=A82025=E5=B9=B42=E6=9C=8825=E6=97=A5=E4=BA=8C=E6=9C=88 =E4=B8=8A=
=E5=8D=888:50=EF=BC=8Cbibo mao=E5=86=99=E9=81=93=EF=BC=9A
>>> On 2025/2/25 =E4=B8=8A=E5=8D=888:40, Jiaxun Yang wrote:
>>>> Hi all,
>>>>
>>>> This series is a collection of small fixes I made to TCG for
>>>> LoongArch32.
>>>>
>>>> There are still many thing broken, especially on CSRs. More
>>>> series following. However this is sufficient to boot 32bit
>>>> kernel.
>>> Is there any product introduction about LoongArch32 board? such as M=
MU
>>> type, memory type(DDR or SRAM), interrupt controller type.
>>=20
>> Sure, for LoongArch32 the most accessible board at the moment is chip=
lap FPGA [1].
>>=20
>> There are also some ASIC designs (BaiXing Project) based on chiplab.
>>=20
>> Long in short:
>>=20
>> - MMU: PG style
>> - Mmeory: DDR
>> - Interrupt controller: custom (Loongson-1C like) connected to CPU's
>>                          int pin.
> Thanks for the information, Would you like to emulate LoongArch32=20
> chiplap FPGA board in qemu side or other LoongArch32 boards?

My plan is to use current virt machine (with EXTIOI and so on) for
LoongArch32, it is trivial to bring up in kernel and give us a lot more
flexibility rather than emulating an actual board.

Thanks
- Jiaxun

>
> Regards
> Bibo Mao
>>=20
>> Thanks
>>=20
>> [1]: https://gitee.com/loongson-edu/chiplab
>>=20
>>>
>>> Regards
>>> Bibo Mao
>>>>
>>=20
>>

--=20
- Jiaxun

