Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC9AC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 10:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sERWV-0005s5-4V; Tue, 04 Jun 2024 06:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sERWT-0005rw-NR
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 06:36:09 -0400
Received: from wfhigh6-smtp.messagingengine.com ([64.147.123.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sERWO-0001qO-5l
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 06:36:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.west.internal (Postfix) with ESMTP id A95411800137;
 Tue,  4 Jun 2024 06:36:01 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Tue, 04 Jun 2024 06:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1717497361;
 x=1717583761; bh=Blt/XI23FU4mJ3yMpYaYq+oPK8Bni4UfoDlflQO8Kk8=; b=
 aSdDrVj0TGnqWVudmUOwQq01g/Ts3YyiRvn4QghzqvXrD0C/jK5vRJh2m5HGnIkk
 5Q9Dgr5kbP4gYAto+9e6l2Qlbqj6ONS8wHYo9D/xanRizAQsIXvn1ag46TXxMauR
 2nLs26FptTTWQ7jEEWJh+xIY5QF1pFQQIYvk6AfMIbvk3zuR5cPz9auc9Zw1JVtk
 A7Xhn2DK07K3iATba9U8JRN85pVrHYCr1I4hl+3lppLPJog1iYTrsB06tC9GZBOD
 yXKjwYZaTDz/WLZQHdPBjSHaEzYyK6nOeJu2jwAoVJG6LF4zDAhwbdPYvR6JHtv8
 pWmXD2BdfMXhbhBadiVdxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717497361; x=
 1717583761; bh=Blt/XI23FU4mJ3yMpYaYq+oPK8Bni4UfoDlflQO8Kk8=; b=I
 J+S8hrZiE35rhyReP3Vqo96+WQ2Mlh3gxlMmDAjSvmCu+wIeIyVQ+hCwh0XOMTwp
 O7oysV2Ft/Exms3jFIIfRIyEHfYAVeUXXyg2BYiQZPtWnzdb+TeoymUESFIAXLGl
 F5ct/GcE2V03MiEMnYEZCaAVlCO0yJKvvP32YrbeloZkLzYhaH43PBBEKQIAxg5E
 vHOHdH/gDCJdLO1rgTW/JTuO+qIRy/ujZdfN4+Opdp9hPgY/eSwNXfworZpuCb5X
 Kab9ulSfH+fXQiwwJbbXrnxB/jxZwTsKaB3FyPXL/j6N2GHqravHTGhwQyzVWnCs
 sMnr9iaH1qPXxegJzDitA==
X-ME-Sender: <xms:EO5eZmtzLQ-ekXTkQDuiQF6QVkvoKoXDDQsTKjZhFx2OYssVuRglDg>
 <xme:EO5eZrdipsSt7hZeHQPw_a954wj8CNHLwCzhitGli66ZV-MvXzb-ABzXJrbGJtgWs
 eWoUfm3qeQWnbAxvRU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedgvdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:EO5eZhzKnOHcAH9IDf4a30U29Xg3qSKhDJLafOhbzZGWMyRVsSMhmA>
 <xmx:EO5eZhOiCszfoBpC7mT6krWWiBdvhk8bZINPetFSF3AllvdaN3ac0w>
 <xmx:EO5eZm_Y642WqR_7gcGDwwrXdhbOcF2A0ZwOV5fltC13vVWR6afn6A>
 <xmx:EO5eZpV9GZtmdFJB97UkGIaNQviA2IDFL0dLFM44ebdVxmOWwtHpZA>
 <xmx:Ee5eZtYgemrC0HiqjlEd3knIRsh9jTTmY5ztQ8JXHiDjPDoJWZ1aJlPZ>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id A7D5336A0074; Tue,  4 Jun 2024 06:36:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
MIME-Version: 1.0
Message-Id: <78c0f76a-327a-4f67-a016-c9f73560494b@app.fastmail.com>
In-Reply-To: <a3700c0c-889e-4bae-8a91-e374f8a5e03a@linaro.org>
References: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
 <20240508-loongson3-ipi-v1-3-1a7b67704664@flygoat.com>
 <a3700c0c-889e-4bae-8a91-e374f8a5e03a@linaro.org>
Date: Tue, 04 Jun 2024 11:35:41 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>, "Song Gao" <gaosong@loongson.cn>
Cc: "Huacai Chen" <chenhuacai@kernel.org>
Subject: Re: [PATCH 3/5] hw/intc/loongson_ipi: Implement IOCSR address space
 for MIPS
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=64.147.123.157;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfhigh6-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B46=E6=9C=883=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=E5=
=8D=884:45=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=93=EF=BC=9A
[...]
>
> LoongsonIPI should have an array of CPUState[] and MemoryRegion[].
> (Or maybe add them to IPICore.)
> Expose them as QOM link properties.
>
> Caller wire them while creating the LoongsonIPI.
> Then loongson_ipi_realize() resolves them once.
> No need to call get_cpu_iocsr_as() and ipi_getcpu() for each MMIO
> access IMO.

I was tempted to do so but realized that arch_id might be discontinuous
for LoongArch.

@Song, can you confirm if it's viable?

Thanks
- Jiaxun
>
>> +
>> +    if (!iocsr_as) {
>> +        return MEMTX_DECODE_ERROR;
>> +    }

--=20
- Jiaxun

