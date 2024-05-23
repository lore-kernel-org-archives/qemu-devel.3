Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A9EC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAID2-0003bU-N8; Thu, 23 May 2024 19:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sAICc-0003Ph-9M
 for qemu-devel@nongnu.org; Thu, 23 May 2024 19:50:30 -0400
Received: from wfhigh4-smtp.messagingengine.com ([64.147.123.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sAICa-00069i-8G
 for qemu-devel@nongnu.org; Thu, 23 May 2024 19:50:30 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.west.internal (Postfix) with ESMTP id 7D9C9180014F;
 Thu, 23 May 2024 19:50:24 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Thu, 23 May 2024 19:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716508224;
 x=1716594624; bh=LW4aK9XTyKUmZxTZH294SxZu+XQD10YAegRLotGaOaw=; b=
 N/29o30KXKM1ewBzcvI8GnfKGxuTUKXpfSfHUlaJa/T1jKGBvvBwQ0Dh4RXQbXxI
 YIGh+h25pnnjoGEZwImbJ6Rd6L+V2W9Kjb1tNZQnhU3wVLfNVhaABKhc5UR7DsWk
 Z4rpGD5cbAjO+JOHO8B+kUNwyoWDnAXv0G8tCLkZ6OjBPVavHj4xvF9V1+UmRPA3
 4DwF1eu3bevxF6XpIS9RccB/UQX+KRSMuh/Si19+2MBhH9ly33kAlMA2zYBBXOkO
 IJXFABC73T/9DayD0SSjscE9zvDr3EPGvOi7hkTXh1w2TO3lJ1iJ/UKSXvfxMnjY
 RqcjtsEW7QkhrKkcDO6JIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716508224; x=
 1716594624; bh=LW4aK9XTyKUmZxTZH294SxZu+XQD10YAegRLotGaOaw=; b=h
 f/izwKy/qiMZhSZE+e2pF+vWasPEx3MY6vcnVFqH8oZ5m5T8W88sdmu9tYnVf8TT
 t6BVpHWSXJwx2tAPAKQ2MByPETBIKr55fgM/cv0Gg1bYo0srpUZvFu0ADdT8zoxS
 ENppEdXAqpHO560Ta4m5JOFXJXblgOe+fcsql9d2YDJUwFKQYhFYkJaIC7SPyZM7
 T6UNPBba//R8eSw5nnVOjfk/XgoBTF+uZGIbaHTSSNlAzpoo4LT164/rMDhipsQq
 LJC9XqSfMnptDeeSU44hQGvab6jxLtIA/+bfjvv5FRcE5BNLVg3lQt/u29GAGvH4
 u+Whu0QVCaH+2f5cqbU+Q==
X-ME-Sender: <xms:P9ZPZqFHQEHej2mLkYGSgldTpeNBUu3JR6gAIp9noZKAuvBQ0rK02Q>
 <xme:P9ZPZrVBG3ddpQwbbBobqhNRyq91MoBPG7oxZNflDFR5DGEYotlctpYub_vaRiK_G
 RoUU64H5kyJj_H-WNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeijedgvdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpeelueeuffeggfdujeevtdevtefguddugedtjeefteeh
 uefgteekhfdtveeuueegteenucffohhmrghinhepphgrthgthhgvfidrohhrghdpkhgvrh
 hnvghlrdhorhhgpdhgihhtvggvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfr
 rghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtg
 homh
X-ME-Proxy: <xmx:P9ZPZkLw37Py9ZSxgwRvTqfyIAw1MyXk9_pOFhrM6FDav9beSvp8pQ>
 <xmx:P9ZPZkEE8MVgi71zVWM3Bq6IrJfjTE5mBPrN2vrRk7c1MygOr0q-Cw>
 <xmx:P9ZPZgX6M3GN_QGa1GlghM3dbVuyzsu5f_9EKnmHO4Rbyx52NinkQA>
 <xmx:P9ZPZnOORDmf6FC6nrpqrt46dyqvcp6UUl4hrSXa0gePPOqs_pGXiw>
 <xmx:QNZPZthigNqnjSM3yqS_JKVUsVTzg9X5SQS9W-9Yx0d-Hl3b6KYNouO4>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 37C8B36A0074; Thu, 23 May 2024 19:50:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-480-g515a2f54a-fm-20240515.001-g515a2f54
MIME-Version: 1.0
Message-Id: <2fc2750a-2cd5-4839-9939-98746ee1c602@app.fastmail.com>
In-Reply-To: <20240521123225.231072-1-gaosong@loongson.cn>
References: <20240521123225.231072-1-gaosong@loongson.cn>
Date: Fri, 24 May 2024 00:50:02 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Song Gao" <gaosong@loongson.cn>, "Bibo Mao" <maobibo@loongson.cn>
Cc: "QEMU devel" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 0/3] Add extioi virt extension support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=64.147.123.155;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfhigh4-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8821=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=E5=
=8D=881:32=EF=BC=8CSong Gao=E5=86=99=E9=81=93=EF=BC=9A
> On LoongArch, IRQs can be routed to four vcpus with hardware extioi.
> This patch adds the extioi virt extension support so that the IRQ can
> route to 256 vcpus.

Hi Song,

Sorry for chime in here, I'm a little bit confused by this series, can
you give me a little bit of context behind?

I don't see this functionality on 3A5000/3A6000's user manual, so is this
some sort of undocumented hardware feature?

I checked openEuler kernel patch you referred, it seems like this applie=
s to
hypervisor mode only. I suppose it should be handled by KVM subsystem in
kernel, why do we need this in user mode device emulation?

Currently, LoongArch's in-kernel irqchip functionality does not include =
such
feature, can we see KVM side support for this, or at least a draft speci=
fication?

Thanks
- Jiaxun

>
> v3:
> - Split patch2 to two small patch.
> - remove unused code.
> - loongarch_extioi_reset() clear status without checking virt extioi
>   features.
> - Link to v2:=20
> https://patchew.org/QEMU/20240514090756.988096-1-gaosong@loongson.cn/
>
> v2:
> - Split the patch to two small patch.
> - Drop 'RFC' title. extioi virt extension suport only enable on kvm
>   mode and  the extioi driver need patch[1].
>   but this series do not affect the old codes in any way.
> - Link to v1:=20
> https://lore.kernel.org/all/20240116022526.498613-1-gaosong@loongson.c=
n/#r
>
> [1]:=20
> https://gitee.com/openeuler/kernel/commit/5d97cff72f91f4f20a536efd60ec=
a75bfcb78a64
>
> Thanks.
> Song Gao
>
> Song Gao (3):
>   hw/intc/loongarch_extioi: Add extioi virt extension definition
>   hw/loongarch/virt: Enable extioi virt extension
>   hw/loongarch/virt: Use MemTxAttrs interface for misc ops
>
>  include/hw/intc/loongarch_extioi.h |  21 ++++++
>  include/hw/loongarch/virt.h        |   2 +
>  target/loongarch/cpu.h             |   1 +
>  hw/intc/loongarch_extioi.c         |  88 +++++++++++++++++++++-
>  hw/loongarch/virt.c                | 116 +++++++++++++++++++++++++----
>  5 files changed, 210 insertions(+), 18 deletions(-)
>
> --=20
> 2.34.1

--=20
- Jiaxun

