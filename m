Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE5CC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 08:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGwBz-0001mq-19; Mon, 19 May 2025 04:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uGwBx-0001mV-6t
 for qemu-devel@nongnu.org; Mon, 19 May 2025 04:49:49 -0400
Received: from fhigh-b3-smtp.messagingengine.com ([202.12.124.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uGwBu-0006x5-VH
 for qemu-devel@nongnu.org; Mon, 19 May 2025 04:49:48 -0400
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8C3EE254011E;
 Mon, 19 May 2025 04:49:45 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-06.internal (MEProxy); Mon, 19 May 2025 04:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1747644585;
 x=1747730985; bh=WCJFo3zkioz4+fOSjAiueXuYC9oR82lasSAZuHZWXFw=; b=
 dkdN+/mp8bBwHcEHJSkXmhQK+fzOLNQhoxau3uPQsT4TNmM9N1qJxTuafw7AZOhN
 TBr9ciORu3yTty7ufm4vAsHJF0+2NiSzv+7k0JOCdKBqVSe5GdXztTSP0iD4gevZ
 TRtsJP/xKd1j/KGXCIh8cl4J1gpbh+McV69EG3QM0bb9D8fmQX9kWhbkq6FVrDfu
 srN+rCsqmhAKB/8cGwDqr7oRMYkp7epE7uNF/wVAB2qpVWQbHSyiowq/EB6bIFyE
 G7m4p1yFLQpzjRwPJ2hkCyvUUUhqtDDldF1o2xu3eBwm7F4fTLaIV48d5woQ3+7i
 1AJY2Voz97rKxnzR5u680Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747644585; x=
 1747730985; bh=WCJFo3zkioz4+fOSjAiueXuYC9oR82lasSAZuHZWXFw=; b=k
 7paSEXDOcfyM+y/AO6UpAIxUTP4ssdGfQN3sreXs1wa/+fGWghZLRoU1ic0rhiV8
 SQSGrEt8+4TLLE2Zuwp+WuRnB+HJuKkkXIjhMDkk6Ze6EqMZ9AwNNRMm2bdnct9L
 q3SI9T6JbglHx5wF1mkTX0ky4y8LY1UVqlEHhi6PyjqHC8lWBM++dKAK8mVDE/Vi
 glfAdI0hgPc1yop7FFHz8cHYErPdXap3hM9o7VGrOWbq2pii8aBexsTn/t0AECvl
 zfdAd//ZnGFnWTDefDWTObwjO6/dPrDJANzoSG2pAJcjW3bd3OMx0qha/hMBuKFn
 Sh2mxtSpXW5MH8v0t6ePw==
X-ME-Sender: <xms:qPAqaMr0U-AmkNXl4L7jp7xlbs0nWeYeFl5YNWJhM7iCVQFqgxWucw>
 <xme:qPAqaCrS2g_4NEfn-Jg5EfnSx5op3brwLgEW_fdhw0udNW4-ACVCh1EW8CkNSg3fJ
 TCCkcPM-5FN_oIIZJM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddtleegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
 tdejnecuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghngh
 esfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdff
 keethefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihg
 ohgrthdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
 hpthhtoheptghhvghnhhhurggtrghisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
 rghoshhonhhgsehlohhonhhgshhonhdrtghnpdhrtghpthhtoheplhhigihirghnghhlrg
 hisehlohhonhhgshhonhdrtghnpdhrtghpthhtohepmhgrohgsihgsoheslhhoohhnghhs
 ohhnrdgtnhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:qPAqaBOQFXsaIfYhhWZBGUYhtpefhyB_PvrnjIiuD19mQCyfQsttzw>
 <xmx:qPAqaD7WBlioeR-8YgbREFNAo0-aBJpkbOb5wU_vmgKM_UxjIPy6UA>
 <xmx:qPAqaL6w0CBCwoQZHPH64ldV5W6i0yewIJJoyRZeOEThLoUOpCemIA>
 <xmx:qPAqaDiRtKv6IaSBHZr030AorabKtJ1hR0EPurAdm2E2pP8LpQiHIA>
 <xmx:qfAqaAaanMLJ2_XoxZagwCswsH--kHXO7dMBa8IiRoM3wAgWXEGFeNVO>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 8E4091060061; Mon, 19 May 2025 04:49:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T61eab45fb9657032
Date: Mon, 19 May 2025 09:49:24 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>, "Song Gao" <gaosong@loongson.cn>
Cc: "Huacai Chen" <chenhuacai@kernel.org>,
 "QEMU devel" <qemu-devel@nongnu.org>, "Xianglai Li" <lixianglai@loongson.cn>
Message-Id: <930362d4-695a-44e6-a220-898e265a944c@app.fastmail.com>
In-Reply-To: <0e4690a6-1f28-f97c-a7dc-3b7888d23f38@loongson.cn>
References: <20250509100747.1070094-1-maobibo@loongson.cn>
 <20250509100747.1070094-4-maobibo@loongson.cn>
 <5fa02121-43f6-4335-883e-efe07a2f3711@app.fastmail.com>
 <391ab7d0-9e61-1b9d-fbd3-98dd23f2d2a7@loongson.cn>
 <671157ca-de54-4053-93a9-8ea7f3fa1f1f@app.fastmail.com>
 <0e4690a6-1f28-f97c-a7dc-3b7888d23f38@loongson.cn>
Subject: Re: [PATCH 03/15] hw/intc/loongarch_extioi: Add irqchip-in-kernel
 save/restore function
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=202.12.124.154;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-b3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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



=E5=9C=A82025=E5=B9=B45=E6=9C=8819=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=
=8D=888:09=EF=BC=8CBibo Mao=E5=86=99=E9=81=93=EF=BC=9A
> On 2025/5/19 =E4=B8=8B=E5=8D=882:50, Jiaxun Yang wrote:
>>=20
>>=20
>> =E5=9C=A82025=E5=B9=B45=E6=9C=8819=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=
=E5=8D=883:56=EF=BC=8CBibo Mao=E5=86=99=E9=81=93=EF=BC=9A
>> [...]
>>>>
>>>> Hi Bibo,
>>>>
>>>> I believe hijacking loongarch_extioi.c is not the proper way to do =
it.
>>>> The sensible solution is to create a TYPE_LOONGARCH_EXTIOI_KVM, whi=
ch
>>>> inherits TYPE_LOONGARCH_EXTIOI_COMMON, and let machine create
>>>> TYPE_LOONGARCH_EXTIOI_KVM vs TYPE_LOONGARCH_EXTIOI as necessary.
>>> what is advantage about creating TYPE_LOONGARCH_EXTIOI_KVM device in=
 KVM
>>> node and TYPE_LOONGARCH_EXTIOI device in TCG mode?
>>=20
>> Cleaner, less error-prone, isolate unnecessary emulation functions to
>> reduce attack surface...
> yes, there is a beautiful code logic internal, however from user the=20
> device tree will be different because of irqchip-in-kernel feature, su=
ch=20
> as different output of *info qom-tree*. It will bring out illusions of=20
> different virt machine type for users.

It's actually different machine as kernel irqchip is never on par with u=
sermode
emulation. This approach is taken by i386 (TYPE_KVM_IOAPIC vs TYPE_IOAPI=
C),
Arm (TYPE_KVM_ARM_ITS vs TYPE_ARM_GICV3_ITS), PowerPC (TYPE_KVM_OPENPIC =
vs
TYPE_OPENPIC) and I see no reason that LoongArch should not follow.

I'm actually planning to bring user space EXTIOI emulation closer to act=
ual
hardware behaviour and I wound not expect such change to be accepted by
in-kernel irqchip.

Thanks

>
> Regards
> Bibo Mao
>>=20

--=20
- Jiaxun

