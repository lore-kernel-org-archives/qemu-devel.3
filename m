Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF2DC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 09:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGwbx-0000Ol-Dh; Mon, 19 May 2025 05:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uGwbs-0000ON-DE
 for qemu-devel@nongnu.org; Mon, 19 May 2025 05:16:36 -0400
Received: from fhigh-b3-smtp.messagingengine.com ([202.12.124.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uGwbn-0005fL-FP
 for qemu-devel@nongnu.org; Mon, 19 May 2025 05:16:36 -0400
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 443AB254009D;
 Mon, 19 May 2025 05:16:29 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-06.internal (MEProxy); Mon, 19 May 2025 05:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1747646189;
 x=1747732589; bh=bQkSnZLtUEm+h6Nq2L9PHOhLC2WqGhy5j86Q6IGwDVM=; b=
 D/S0MoBpmW/iBAlSqsxSQDy+DWh1/1DvDYEUb82nrM2wmEgnfB8IkQmEFiMTLLdL
 p2OrdoPrbHP22Cs+4LY18VudosX3lVREHXsFUi9mzZVn/MVyGfnVvdHb58L4FRqb
 zvYPfyBLl5N0xLQxbebWZKlVS9N6pIDUSFEc7QNm5tDJodsJHwG3F85rJr66y0Ve
 lPB3F4RT6vB2ox46y75liwIj2ajnbpIH5oSTjSP6oaFJfav3ydGVs4uG7lKHaq3s
 nyKPdJ9dYVNjMTFwkYOU5KMR4F0KNc3c9e6O+Gjx7ZuVDBRdbTG3/nstAr1SpixF
 f4Qm9i9DZfDHEd4542Ya8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747646189; x=
 1747732589; bh=bQkSnZLtUEm+h6Nq2L9PHOhLC2WqGhy5j86Q6IGwDVM=; b=v
 U9K4MuZAhKicwkb6yr4kwQsR2q9btZ/rU9OA2SSvGqilYFPIF3uk/ucR6kHANNzT
 p7rYwlFnmnPHNPHaVnaWKrNvnlA5HDfqgoiUb/LSBny91M19LT+ZM+Cf2MnES4kD
 oWto5KPumO9LoeAejV+qqKjvZkfxn/xb5JYlWf7lNS0lQ5dnhH3+aAMHT1Y/d+k9
 48+q6s7AjXWNapcUZxtvMRycAIIldwpsm0N2CkArBHNk7Sm0f4fr6dQjM/euEyNT
 n8XAkaRoynCxx9vnUSParf10tnHFRWuP0Sh0bUshg5bBPzb55IypePSnBovZMIcX
 oT9/yxHc9wGHGWiKy6sxg==
X-ME-Sender: <xms:7PYqaN8U_nWTWOasgW1zwvDKXeLO747norCgk5iR-_Q7qlaDrU2Jkw>
 <xme:7PYqaBtZeWs7-p_5XsRVfrC1RvJMTle7uskF2HE7BhAvLn7yc3vKdRWeYM41dGWO3
 AZB0IIu37MgLCwy3UY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddtleelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:7PYqaLCK_U5aicX2I-JLEWBCkqdeo1601QrenMrPrYJKwjiwrsuLtg>
 <xmx:7PYqaBeZsSvsOKa9czkD40vfvViAm-JqFvcnti3HAFY2Gh61-m_Pig>
 <xmx:7PYqaCOdoHmL-k1unjqjZ9RshrOIN6N5qsPtpdrIH9wAYtx41Ff1iw>
 <xmx:7PYqaDn2us1CMN3fCHHaL5wBf6Sz5QBtlC5m2uFfDvZZ3tEsHu9KLQ>
 <xmx:7fYqaDAdwB6syT9ia3YMPQZ7kgNfTskF0TeN_SiY5ILNMh4bIOH2o3E9>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 62DA71060060; Mon, 19 May 2025 05:16:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T61eab45fb9657032
Date: Mon, 19 May 2025 10:15:37 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>, "Song Gao" <gaosong@loongson.cn>
Cc: "Huacai Chen" <chenhuacai@kernel.org>,
 "QEMU devel" <qemu-devel@nongnu.org>, "Xianglai Li" <lixianglai@loongson.cn>
Message-Id: <73bd3e6c-78b0-4378-b391-8f20beac2079@app.fastmail.com>
In-Reply-To: <1422bdc1-9251-b88e-44fd-e953ee88d0bd@loongson.cn>
References: <20250509100747.1070094-1-maobibo@loongson.cn>
 <20250509100747.1070094-4-maobibo@loongson.cn>
 <5fa02121-43f6-4335-883e-efe07a2f3711@app.fastmail.com>
 <391ab7d0-9e61-1b9d-fbd3-98dd23f2d2a7@loongson.cn>
 <671157ca-de54-4053-93a9-8ea7f3fa1f1f@app.fastmail.com>
 <0e4690a6-1f28-f97c-a7dc-3b7888d23f38@loongson.cn>
 <930362d4-695a-44e6-a220-898e265a944c@app.fastmail.com>
 <1422bdc1-9251-b88e-44fd-e953ee88d0bd@loongson.cn>
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
=8D=889:55=EF=BC=8CBibo Mao=E5=86=99=E9=81=93=EF=BC=9A
[...]
>> It's actually different machine as kernel irqchip is never on par wit=
h usermode
>> emulation. This approach is taken by i386 (TYPE_KVM_IOAPIC vs TYPE_IO=
APIC),
>> Arm (TYPE_KVM_ARM_ITS vs TYPE_ARM_GICV3_ITS), PowerPC (TYPE_KVM_OPENP=
IC vs
>> TYPE_OPENPIC) and I see no reason that LoongArch should not follow.
> So what is the advantage and disadvantage from yourself understanding =
here?

I think I made myself pretty clear in previous replies, in case you miss=
ed that.=20

The advantage is clean design, clean interface, clean vmstates (user spa=
ce emulation
tends to have more states vs in-kernel irqchip), proper signalling to us=
er that
migration between user-space/in-kernel irqchip is not feasible, perhaps =
some performance
advantage on reducing number of user space IOCSR ranges, reducing attack=
 surface
exposed by userspace emulation, reducing the chance of hypervisor error =
being covered
up by userspace fallback....

I don't think there is any disadvantage. I don't really buy the "differe=
nt machine"
justification you made. Paravirt solution tends to have its own behaviou=
r and I don't
think it's a bad thing to expose it to users.

Thanks
--=20
- Jiaxun

