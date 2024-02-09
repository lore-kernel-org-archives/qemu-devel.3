Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA366C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYObm-0003kq-5G; Fri, 09 Feb 2024 05:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1rYObk-0003UQ-9R
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:48 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1rYObh-0000Jo-9b
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:47 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailout.nyi.internal (Postfix) with ESMTP id 4324A5C01A3;
 Fri,  9 Feb 2024 05:59:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 09 Feb 2024 05:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1707476383;
 x=1707562783; bh=8vxOURXgfWb/5Wm4okHVBaq4kt1aGZ3FoHDb6NQm/ZY=; b=
 uezKO+AsXMIo0bqNDnMS83nRfIjODWUxQz7Ipk/U16vgFEMcViADaaLtFL4N2d0A
 x3pKjxJ+FgcII8NCCF4tn5A1ALvWqJPa4MO2SZtDwKB33Dk2vBFEyjLUzvkHF582
 UxdoIKRrDzKHExTzJUpYrKiw69CLwuQCbOjRrhu3N3+WXTqP/0TinLj7JUnxZW2U
 gMMk0M8N1k5LZ7+zRn/1rhgjYl80CtD/9KxFoSUoput7bqjN8y/OFlp2GZdTkZqc
 t+A+gISVeVCcP1H8xRjklQeKW0ACGM4cm+R7i62ye0nGUH2+o9L0zxexOGsUO6Si
 4vl0DRp7mqgouy73POqiVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707476383; x=
 1707562783; bh=8vxOURXgfWb/5Wm4okHVBaq4kt1aGZ3FoHDb6NQm/ZY=; b=y
 3f0Dwm8BWuMjtXBO1ktP7f7nuRx6FlX2v0az9fzEncz3opU3aSIbZRMxgGDXFqT5
 BAN2lC+bMga2uYd6TVtm72Gh1L9Honp+UVChmVIn15+ZyGP/ubAEQho3+/UtQTPw
 34f0XmhD108nHZr2JjQSXNkg5VKTGv9meb1frvEed6coV3Qe8oI1CzOMa8/vBZd9
 5lRpw192PGiJI+D10otsJAYaHyeWb3qLM4yudUAaCttXN1yS42jpNyHg1kIVrmmE
 /eTICV69FubwPqnrMbF6WdkYgXBjAspfvH3w08MQ0tgGK419O6nuJqefbXWkrSpY
 hW2YwOKdZGJagscm1IsAg==
X-ME-Sender: <xms:ngXGZSpMRQJtYYoPPb8leetU-sv2C8qJtt9EwFJ6exTukAE92LpPQQ>
 <xme:ngXGZQpGnSQPM6Vh3Y2JbIo76iYTA11sbQ5kBky0p3qeTI-cAHise3a3mizKO3a9b
 ca3Y8K-uWiRtJqp6Ow>
X-ME-Received: <xmr:ngXGZXMmfBhHGrfZEzmiJYNRkSY1CtFjoH0Du9_I4h7HZ1Fo9qhf1EOHJB_pTUjehMjZwJyP35aMdmpSDn0VUc7DJfIaXc-T9s0hsmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigddvudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpeduheejgfetvdekvedvveeikeelkefhveekveelheeikeefudet
 ueffudfhhedtheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
 fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghes
 fhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:ngXGZR4dT2iilXpOnG1RGJCoLWl9giVsjHS4eJDAlA1dr7e3tMJ2cg>
 <xmx:ngXGZR4exJXBhQQWUYURXDzNkONdORG-8SP9AOBjDJuHarADphpeOw>
 <xmx:ngXGZRhjHkBbtwnsBN8RnBduat8aMcwkyMhv1Wz9qtgzoAz4KWh4QA>
 <xmx:nwXGZWHB_ag5QSxEkoB12ky7xKZU1u7ieigbitSemzg8_x5sCoobQw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 05:59:41 -0500 (EST)
Message-ID: <2ffa6eac-eb52-4b2f-952a-228328d6003c@flygoat.com>
Date: Fri, 9 Feb 2024 10:59:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/11] target/mips: Remove I6500 CPU definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen
 <chenhuacai@kernel.org>, Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <20240209090513.9401-1-philmd@linaro.org>
Content-Language: en-US
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Autocrypt: addr=jiaxun.yang@flygoat.com; keydata=
 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
 HVO98ZmbMeg=
In-Reply-To: <20240209090513.9401-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.27; envelope-from=jiaxun.yang@flygoat.com;
 helo=out3-smtp.messagingengine.com
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



在 2024/2/9 09:05, Philippe Mathieu-Daudé 写道:
> Alternative to:
> https://lore.kernel.org/qemu-devel/20240209085347.8446-1-philmd@linaro.org/
> If the I6500 can not be tested or its support is incomplete,
> there is no point in wasting energy maintaining it.

Actually all SAAR and ITU stuff are optional for I6500 in real world so 
it's fine
to just leave I6500 defined without SAAR support.

The main difference between I6400 and I6500 is multi-cluster support, I do
have some patch for bringing proper multi-cluster support to QEMU, but
it can't work with boston due to address space limitations.

Should I give mips-virt stuff another go?

Thanks
- Jiaxun

>
> Philippe Mathieu-Daudé (11):
>    target/mips: Remove helpers accessing SAAR registers
>    hw/misc/mips: Reduce itc_reconfigure() scope
>    target/mips: Remove MIPSITUState::itu field
>    target/mips: Remove CPUMIPSState::saarp field
>    hw/misc/mips_itu: Remove MIPSITUState::cpu0 field
>    hw/misc/mips_itu: Remove MIPSITUState::saar field
>    target/mips: Remove CPUMIPSState::CP0_SAAR[2] field
>    target/mips: Remove helpers accessing SAARI register
>    target/mips: Remove CPUMIPSState::CP0_SAARI field
>    target/mips: Remove the unused DisasContext::saar field
>    target/mips: Remove I6500 CPU definition
>
>   docs/about/removed-features.rst     |  5 +++
>   include/hw/misc/mips_itu.h          |  6 ---
>   target/mips/cpu.h                   |  4 --
>   target/mips/tcg/translate.h         |  1 -
>   target/mips/tcg/sysemu_helper.h.inc |  6 ---
>   hw/mips/cps.c                       |  3 --
>   hw/misc/mips_itu.c                  | 35 ++--------------
>   target/mips/sysemu/machine.c        |  4 +-
>   target/mips/tcg/sysemu/cp0_helper.c | 63 -----------------------------
>   target/mips/tcg/translate.c         | 62 ----------------------------
>   tests/qtest/machine-none-test.c     |  2 +-
>   target/mips/cpu-defs.c.inc          | 40 ------------------
>   12 files changed, 12 insertions(+), 219 deletions(-)
>

-- 
---
Jiaxun Yang


