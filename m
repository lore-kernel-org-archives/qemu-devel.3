Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754C5C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 07:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOB9L-0006TU-TU; Mon, 01 Jul 2024 03:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sOB9I-0006T3-Pl
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 03:08:28 -0400
Received: from fout6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sOB9H-0004V3-2H
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 03:08:28 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id 5B513138009C;
 Mon,  1 Jul 2024 03:08:26 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Mon, 01 Jul 2024 03:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1719817706;
 x=1719904106; bh=UqxxtnQtceqMgq5KZIyTdgd+UFrOtzcbmIMPzw6KfKI=; b=
 U8bBWZcIIT//vBHlblv7XTYWz8c8786olszMC58JPwX8W+SHM0PnD63ccNtdOW/J
 sY8sIjW67ere0T47mg0aD3zKXMHmbmBCjJmYGUlF8v/vQI4MVRAEI91IqG/5Zwth
 h5KXinGXkqBy0Ntkj7UDZW4mXPPtfjYsNbT+U6MmJsWxGjRwgtrnwhADHGKiARwi
 yQvUyW3CDMHURQ/frskYBLc8Ey4haobpHun6mrmBF20YULRdN2ipwWG5+l2DSoHC
 TlHqdEgnMmeAYT5sDkbDKqSWFpO1Ifcv8UoLEfdRFy2JKCyjMNXoc+BxvBWioT+G
 NZWk51WuvgogXJ9iRi2N0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719817706; x=
 1719904106; bh=UqxxtnQtceqMgq5KZIyTdgd+UFrOtzcbmIMPzw6KfKI=; b=F
 ZFq0MNX1TjIUwz47ufkLj0kGxRZa/qbQifbehbQi0D+Y/m+rpvr9+nR6ULnVovOd
 tKGWeYp/3bKcz8zlnlD9uUAwqjxA3Axp9GAJZL4dS9MDUOje8LU/tU+NXCqg1xnN
 0vRI+KqzRQzC7tHNGr0tH3iwEhQPdIHcCpjh7QeqeKhcRMZr5TO18ktUwFZAbCf1
 6/YDABUhyct+ZtfSCO6TRZ9QUCoVHzMqROP5GXOJGiZrcZdUq73uI8BU1ML4Sq8v
 qbLByM5VQazrPzohgMvRqnCcuHl34IaMuxrp7+SGma+SzdijiO5GGMAp9ULkEHMq
 r3U0GroCY9zVFQrg7ne0w==
X-ME-Sender: <xms:6VWCZqBo-XnplsbqH1tXrLd-l_19UBWhy4qO35GaSKagt5JrAkQCHw>
 <xme:6VWCZkhop36vYeTjIkGYNI-V1Tr2HjrMhbOlBiZCvX38G6w6qPpuU1AbH32a3BgOc
 oSczX4DFol9QJ6DP2I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvgdduudehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:6VWCZtluuN5_VnHxfcbEqRBS6nx_WjVlKp_vjFzKNwHCpopLKuNFvg>
 <xmx:6VWCZoyUDSvv0pyW06JyffVZSBi6ONV_MkOCEV14QsK8sb7168xhmA>
 <xmx:6VWCZvTLkR13LZsOs4Jw2lfxa2ICzsEx9x_n65k4j5Rd347xKPLMpw>
 <xmx:6VWCZjarJ7KF-H23rQA-ts1yLeOyY7v6Oh22sPSkhmJfZ6e77De8Og>
 <xmx:6lWCZuE1Ev8zhIDiOsmLErA4G2b2fENzncmghMBN1893vrtPTwytnvAs>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 9CCF336A0074; Mon,  1 Jul 2024 03:08:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
MIME-Version: 1.0
Message-Id: <2b73d23a-4c36-4f0e-9d30-1d1af4c472fd@app.fastmail.com>
In-Reply-To: <ceebb4ea-a417-0985-d45e-3988d76e2086@loongson.cn>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
 <20240605-loongson3-ipi-v3-1-ddd2c0e03fa3@flygoat.com>
 <e1b8bbd8-2a9d-2417-1123-4aabfdedb684@loongson.cn>
 <002f4e7e-682b-479b-9c6c-8971a0e6640a@linaro.org>
 <8d975e9c-c2fd-09c8-7a37-5aebc63656d4@loongson.cn>
 <9a0f73c6-33e9-4576-9056-6a5fd0718630@linaro.org>
 <ceebb4ea-a417-0985-d45e-3988d76e2086@loongson.cn>
Date: Mon, 01 Jul 2024 08:08:11 +0100
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
Received-SPF: pass client-ip=103.168.172.149;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout6-smtp.messagingengine.com
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
=8D=882:35=EF=BC=8Cmaobibo=E5=86=99=E9=81=93=EF=BC=9A
[...]
>
> How about split loongson_ipi.c into=20
> loongson_ipi_base.c/loongson_ipi_loongson.c/loongson_ipi_loongarch.c,
>
> File loongson_ipi_base.c contains the common code, loongson_ipi_xxx.c=20
> contains arch specific. Soon we will submit irqchip in kernel function,
> it will be much different for architectures, since ioctl command is=20
> different for two architectures to save/restore ipi registers.

MIPS's in kernel IPI IOCTL interface is non-existent so far, so if you a=
re going
to design something, I think it will be adopted by MIPS if necessary. Th=
ere is still
no need to create divergence in between.

That being said, You are more than welcomed to draft a patch so we can d=
iscuss based
on that.

Thanks
>
> Regards
> Bibo Mao

--=20
- Jiaxun

