Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79954C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 16:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH3ZB-00012q-Qq; Mon, 19 May 2025 12:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uH3Z8-00012U-Ev
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:42:14 -0400
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uH3Z6-0006m4-3a
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:42:14 -0400
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E7A6C25400DC;
 Mon, 19 May 2025 12:42:09 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-06.internal (MEProxy); Mon, 19 May 2025 12:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1747672929;
 x=1747759329; bh=+W45c2kdfwAFEomb2WVmfvUdLH5DSPDfGqGAOQKWafk=; b=
 jxmonzrzkSZDwQrrzaDFrrDEzOzQ2JsZucwr6EylYdgK1Ain2eYkpWoiFkskfUv0
 cI1jGPPEgqrsHiQCnjRcdrU25q0hpIaNnFRPkt4pkxmXlxjmZsm8aisGN68zBlDp
 gqJNfbELDLfiA2UQhSbYlV+/TwrVXRo9nTmBby7hiTkLZMPB7LVMQjqtdYEwmZ7p
 p3CVYuLFGyktvW4ayLUn3StDIgQxEfHL13X0yxETro/LXqVSugdARcp0cNHLGLX/
 TFsIr/Gl1mpxKQBnUZpl9NJxheLkStNlNFDktx/p4iRteEBNWoBFXGwyBaSUOIgl
 OwFWA7mPfWyz1/fmbwaqCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747672929; x=
 1747759329; bh=+W45c2kdfwAFEomb2WVmfvUdLH5DSPDfGqGAOQKWafk=; b=n
 Dmj9YYw2hwB0foKUEBVtGXe0dPcqv4YiUeLRM4t/UCP0bEgvpFOhFYl5l6xTarC1
 debz9IcHaNnl5y6ZcNewbch573BapPCkpvUvFPjrD1uh51Wkwhm7fF+f68JKGxfk
 nF67WAIWW8hBnzsip1/9wbrdf66jhHdid8K/N2F96R5Q3oV04V393dCTgJ9QNOwe
 iNY/P2iy0yCk4s9kgWG87WyDewwD9xtlLVDPMY0fIVn7w65PJ2dNx3c4gHkOKu6n
 DOvra3NsAn+n8Re59VVMXeQT5skZxm2r0tps4RDT5Z+jag0cijTkXs2Pma6wOouZ
 bD9O+zGsFoazhN/u9UMrg==
X-ME-Sender: <xms:YV8raKjdLmvqol7k-ZTcJPE8_7mgS47DnJUqBPjO_TWZFoD5SxbX3Q>
 <xme:YV8raLBs7wzGYWrzie1qSBBZTaMERSy8IdUAwA6F3IopNsoAR8QEIVQxSspCJ3vK8
 X7xDsmCyt5fq_MWMr0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddukeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
 tdejnecuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghngh
 esfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdff
 keethefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihg
 ohgrthdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtg
 hpthhtohepsghisghordhmrghosehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhvghn
 hhhurggtrghisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrghoshhonhhgsehloh
 honhhgshhonhdrtghnpdhrtghpthhtoheplhhigihirghnghhlrghisehlohhonhhgshho
 nhdrtghnpdhrtghpthhtohepmhgrohgsihgsoheslhhoohhnghhsohhnrdgtnhdprhgtph
 htthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:YV8raCG_N2cwEr2y_dmxHEbMHi87nHXUnqOlHeXZjyZSx7tHZFzscA>
 <xmx:YV8raDRzwx2omRnCYcaPhoZxnwUKdQluVBGbkl-y-v-w8u0jbG4zgQ>
 <xmx:YV8raHyJ7M1QVjHke6eD4wN4Nh5l0IvXZpVN6-fQxTazyar_lDax1g>
 <xmx:YV8raB6OcvjmhqwTdbPOinYZEFt3QrtqKSKQIPK-nKyvGES-ZBxnGQ>
 <xmx:YV8raGuVt8bJJlllopuT9DQYbQJ7Lf-kb5jZgNcCKk3WOz56NaeCWVGJ>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 38E461060060; Mon, 19 May 2025 12:42:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T61eab45fb9657032
Date: Mon, 19 May 2025 17:41:19 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "bibo mao" <bibo.mao@gmail.com>
Cc: "Bibo Mao" <maobibo@loongson.cn>, "Song Gao" <gaosong@loongson.cn>,
 "Huacai Chen" <chenhuacai@kernel.org>, "QEMU devel" <qemu-devel@nongnu.org>,
 "Xianglai Li" <lixianglai@loongson.cn>
Message-Id: <1426cff7-28d2-4c40-b41f-194267d1717c@app.fastmail.com>
In-Reply-To: <CAPpFdZ0NMe56bZMj=akJNaFJEjBpx4W_3Uyzr=6j-3moDWOaDw@mail.gmail.com>
References: <20250509100747.1070094-1-maobibo@loongson.cn>
 <20250509100747.1070094-4-maobibo@loongson.cn>
 <5fa02121-43f6-4335-883e-efe07a2f3711@app.fastmail.com>
 <391ab7d0-9e61-1b9d-fbd3-98dd23f2d2a7@loongson.cn>
 <671157ca-de54-4053-93a9-8ea7f3fa1f1f@app.fastmail.com>
 <0e4690a6-1f28-f97c-a7dc-3b7888d23f38@loongson.cn>
 <930362d4-695a-44e6-a220-898e265a944c@app.fastmail.com>
 <1422bdc1-9251-b88e-44fd-e953ee88d0bd@loongson.cn>
 <73bd3e6c-78b0-4378-b391-8f20beac2079@app.fastmail.com>
 <CAPpFdZ0NMe56bZMj=akJNaFJEjBpx4W_3Uyzr=6j-3moDWOaDw@mail.gmail.com>
Subject: Re: [PATCH 03/15] hw/intc/loongarch_extioi: Add irqchip-in-kernel
 save/restore function
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=202.12.124.159;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-b8-smtp.messagingengine.com
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



=E5=9C=A82025=E5=B9=B45=E6=9C=8819=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=
=8D=882:24=EF=BC=8Cbibo mao=E5=86=99=E9=81=93=EF=BC=9A
[...]
>> I don't think there is any disadvantage. I don't really buy the "diff=
erent machine"
>> justification you made. Paravirt solution tends to have its own behav=
iour and I don't
>> think it's a bad thing to expose it to users.
> irqchip-in-kernel is some kind of optimization, register layout and
> function is the same whatever it is
> emulated in kernel or user mode.

I can already observe some differences, for example with in-kernel irqch=
ip
PCH MSI can be delivered to any EXTIOI vector while in user space it's o=
nly
possible to do so for 64+ vector.

I'm also planning to bring user space EXTIOI emulation closer to hardwar=
e,
as I found many issues when I was trying to bring up SylixOS BSP in QEMU,
and it's unlikely in-kernel one will follow due to performance considera=
tions.

>
> The same for cpu type, do you think that cpu type la464 should be
> named as la464-kvm in
> KVM mode? Or you do not care about name at all=EF=BC=9F
            ^=20

I do think it for user interface it should be "host" or "max" whenever
possible in KVM mode. From QOM perspective, TCG vs KVM is handled by
TYPE_ACCEL_OPS, this makes clear distinctions at higher level.

Also, EXTIOI device is not user creatable, QOM tree information is a deep
internal detail. I searched mailing list and gitlab issues and I was una=
ble to
find any user reports about "qom tree information confused users", given=
 that
other architectures had taken this approach for a while.

QOM is severing QEMU's internal design, not vice versa.

Thanks
--=20
- Jiaxun

