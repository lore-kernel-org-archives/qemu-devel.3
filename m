Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43ECDC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 06:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGuKq-0006eq-Ol; Mon, 19 May 2025 02:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uGuKj-0006e8-Qo
 for qemu-devel@nongnu.org; Mon, 19 May 2025 02:50:45 -0400
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uGuKg-0007s6-Nu
 for qemu-devel@nongnu.org; Mon, 19 May 2025 02:50:45 -0400
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 54C6E2540103;
 Mon, 19 May 2025 02:50:39 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-06.internal (MEProxy); Mon, 19 May 2025 02:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1747637439;
 x=1747723839; bh=mhOAedMkD+5qhFmrEGK2RHp0KZK0bASUeZ3n1lSctyE=; b=
 Z3GdK2YsrierhGIjvW2S/vu4z2nAf968mU3bMAUs2BY0aCzjgh9t6gS5Gbs0u8lY
 vugP2tYQTNFcVKOPthr0hyfnV5GpdvUBkoGUJUQ/qDocuhxOUed2livDqGfgVk2A
 6K9r9i8jO95O/Ox+NSSWXzDRZ0xB4+ci/pCvssZOzZ9QJR1M5sD5T4lupPcE1OsV
 FAwE9ilDt0n7IneUNj7NqVV89Ql0gMvTP4z5k2tzESfu+74pYzgLkhAqI7jdeQYM
 EknmlUR7aFi8WhMwDWcVzNqd8ZJdElU8KCdF+Mv9f7BvRRl054OG1ZW5QgFpC0Oo
 IRthKAAM00L+uUPX9jB9Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747637439; x=
 1747723839; bh=mhOAedMkD+5qhFmrEGK2RHp0KZK0bASUeZ3n1lSctyE=; b=m
 DPOfceuoZg7fwzNDqAoeRDeC29C620o5hE6QxtChu3Q61ho/ga96Z4S4HbVMy5BY
 0LHXPsENWRHOkE5Awy0f9iP0Qxe0QM8HvytywP7z4q8eJlChdH0kmpHQIci9wGg1
 0Nec8/GJI4BlNtIzW96mE0HewTcI9Hp0HG5nBqG7o1atFIuVSR9ttaZLrPG+jVCJ
 Nybdaq8CmQO+dhGDX+HbqytC7g6XPHV6EhbVxj6/7uLPMixotSc8Yi66baN+JuPY
 YBGSg+FpLb+nQNUmN9EcCGqz9ScaK//xxdH4QhwISgRq+zOL2iGvNPUUajmCPmNg
 imi8EqyY3X1j/LM5LwxuQ==
X-ME-Sender: <xms:vtQqaFrn_3kM5T2ldLamu4_I1x23rYUVliZRXDnPTaFR-DXraApAMw>
 <xme:vtQqaHp5vnbS26I4x5Cj7aAjANmQxdeDsSQn0Emr1quyM5CWfd_DsgtzYuW1fQtCu
 0AMU2lyXT8GGoPiojU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddtjedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:vtQqaCOtFXDpa7GLdLjBsJ9tbMKtQUmnuQaKQth4_02OidFazkBW8A>
 <xmx:vtQqaA6W720-Huowzaq_V_xwSJcSwksMr0yWVp8qfM2vwmqoK6tfoA>
 <xmx:vtQqaE48_8Qptk_ezCk1ahw6LYT0Rtfw8_esjdmt90yqMS4wCrS9BA>
 <xmx:vtQqaIhdqe1bfGK5zM2F5uPg1fLXhd97ZIcpeHDLQTbQltcRMubcIg>
 <xmx:v9QqaJYPMZ_WHXZqZDpD6Q62yn4THpCWAHU_zJXGFaMZQdBjcxHENnAn>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 62AF31060060; Mon, 19 May 2025 02:50:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T61eab45fb9657032
Date: Mon, 19 May 2025 07:50:16 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>, "Song Gao" <gaosong@loongson.cn>
Cc: "Huacai Chen" <chenhuacai@kernel.org>,
 "QEMU devel" <qemu-devel@nongnu.org>, "Xianglai Li" <lixianglai@loongson.cn>
Message-Id: <671157ca-de54-4053-93a9-8ea7f3fa1f1f@app.fastmail.com>
In-Reply-To: <391ab7d0-9e61-1b9d-fbd3-98dd23f2d2a7@loongson.cn>
References: <20250509100747.1070094-1-maobibo@loongson.cn>
 <20250509100747.1070094-4-maobibo@loongson.cn>
 <5fa02121-43f6-4335-883e-efe07a2f3711@app.fastmail.com>
 <391ab7d0-9e61-1b9d-fbd3-98dd23f2d2a7@loongson.cn>
Subject: Re: [PATCH 03/15] hw/intc/loongarch_extioi: Add irqchip-in-kernel
 save/restore function
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=202.12.124.153;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-b2-smtp.messagingengine.com
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
=8D=883:56=EF=BC=8CBibo Mao=E5=86=99=E9=81=93=EF=BC=9A
[...]
>>=20
>> Hi Bibo,
>>=20
>> I believe hijacking loongarch_extioi.c is not the proper way to do it.
>> The sensible solution is to create a TYPE_LOONGARCH_EXTIOI_KVM, which
>> inherits TYPE_LOONGARCH_EXTIOI_COMMON, and let machine create
>> TYPE_LOONGARCH_EXTIOI_KVM vs TYPE_LOONGARCH_EXTIOI as necessary.
> what is advantage about creating TYPE_LOONGARCH_EXTIOI_KVM device in K=
VM=20
> node and TYPE_LOONGARCH_EXTIOI device in TCG mode?

Cleaner, less error-prone, isolate unnecessary emulation functions to
reduce attack surface...

>
> That means there will be two virt machine types since device name is=20
> different in different accel mode.

Yes I do think you shouldn't aim migration capability between different
accel mode. It's not doable given we can't emulate full set of h/w behav=
iour.

>>=20
>> In this way you can avoid ugly "irqchip-in-kernel" property.
>> Also you don't really want all those emulation functions in
>> loongarch_extioi.c to kick in when irqchip is in kernel. If
>> IOCSR VMEXIT happens on extioi range, it's a hypervisor error
>> rather than something needs to be emulated.
>>=20
>> Also I think EXTIOI_VIRT_CONFIG range MMIO needs to be handled
>> differently on KVM vs userspace irqchip. EXTIOI_VIRT_CONFIG needs
>> to be relayed to kernel, as virt_iocsr_misc_write will perform
>> IOCSR read/write in userspace, this needs to be translated to
>> KVM_DEV_LOONGARCH_EXTIOI_SW_STATUS_STATE.
> Will handle it, misc iocsr should be emulated in kernel also.

IMHO misc IOCSR should be in user space because it described
the capability of machine instead of CPU, it's not a part of
irqchip.

>
> Regards
> Bibo Mao

Thanks
--=20
- Jiaxun

