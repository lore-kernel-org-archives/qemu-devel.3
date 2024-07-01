Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C846C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 07:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOB3F-0003mY-To; Mon, 01 Jul 2024 03:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sOB3E-0003lz-Cv
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 03:02:12 -0400
Received: from fout6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sOB3C-0003Wn-SX
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 03:02:12 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id 8516413800EE;
 Mon,  1 Jul 2024 03:02:09 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Mon, 01 Jul 2024 03:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1719817329;
 x=1719903729; bh=MTphpb3Z+h2Z5/moFFzGirPkMTEq6EbA1gTCpYjlsrc=; b=
 rEVSVxfkuh4ZS2h1P6vkciYbSbEzsk77LjalqM+mnq0tUFKziaQrnr5WAzCdPydf
 VhXN2wyK8hr/IzoIJi6yjlUQKX9mlCWqbU7EL9sYrcd3QY7Jafm7FBp6Bsy00JFX
 syImljfMcJcoQ1tZQs//2X82pLJtbNDFTRSWahCOlnfKM4NacaMaEHJiM/DW4o1J
 NEYP3czrITW4eFhK8oBLw3n0fhMFrbtuWnzFl5SzoIPLTZiOaGZWCiXTGx5WtSoP
 Daq0jtL2Xo/KA+UHgBt3Kvzsitu8zUNfHOGUBrItdK/Cy28dJZcYTCx0gtDqZckh
 hvMItgRiH0WF/eBA07FW5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719817329; x=
 1719903729; bh=MTphpb3Z+h2Z5/moFFzGirPkMTEq6EbA1gTCpYjlsrc=; b=p
 42dIGN9YUhalFvgGVDdlLClxWH3T31F3kNICnTnJ2BoubJF0Bha+K88u7N3weSwh
 dV7NV/hK5AUulEQFvsI+Bjv6ArjBwSBR+J38eBE8olvix4eG5uNbSzN0aOrWjAoT
 Ypoy1a8VbowzBPZWYGSIIaHEE60CLUQ/sX/j1P5D0+xq8x1BGl+cXnRa8U9r03eT
 CIuAbVdoWSXBsgciYAcP5SS1sqO/PpWI6E1i/c/Y+WkPvDTXKelxlVHIIpeZTUXO
 REuOsm58mJ8tquc57Ps2vD2OVUmXpkHSBCGhlHQQF72iXiuOJL3DZVf2BLpCdNgz
 EZ43eUleox4bChgDRnqgQ==
X-ME-Sender: <xms:cFSCZnyGSMZWAORC_EZRJjjcpDxGOPBt0qzWUaF8DkaaWwFhWbO5WA>
 <xme:cFSCZvTG-l-z5HIVTqFGUf6sQjcY1D-Bk9uVJhAEu4_1NyH1eZh54CJ8wxsKB85u3
 y83EXMAu-fh_9WRRYs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvgdduudegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:cFSCZhVG1iRpL6FN_mU86fE72ohMUXJQxJhHRNo9OYXgEf7_Uv9Rlw>
 <xmx:cVSCZhghckjW2Gkxc5p36T9Gx03WzIN-MvCW6bDnY0u-wKss5RpYzQ>
 <xmx:cVSCZpBrt_Ct60CBfDTjzuXBbBtTwLETd83-tOm2Wk1kSfULcOUdPw>
 <xmx:cVSCZqLIYtJaLs_M_7bq53HBtQ8_w6Wcjm2DOFpnXe6gO3RwohmSbg>
 <xmx:cVSCZr2CFAX9-BpGGbwtmPyDrmOj9Dh4KyZHsFbXwBdYi_kslZrdeLL7>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id DD2CC36A0074; Mon,  1 Jul 2024 03:02:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
MIME-Version: 1.0
Message-Id: <74a9606c-3b3b-4af3-8242-944619f898c9@app.fastmail.com>
In-Reply-To: <3544da40-d680-20f2-d7af-cf304d07bc8d@loongson.cn>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
 <20240605-loongson3-ipi-v3-1-ddd2c0e03fa3@flygoat.com>
 <e1b8bbd8-2a9d-2417-1123-4aabfdedb684@loongson.cn>
 <002f4e7e-682b-479b-9c6c-8971a0e6640a@linaro.org>
 <8d975e9c-c2fd-09c8-7a37-5aebc63656d4@loongson.cn>
 <9a0f73c6-33e9-4576-9056-6a5fd0718630@linaro.org>
 <ceebb4ea-a417-0985-d45e-3988d76e2086@loongson.cn>
 <3544da40-d680-20f2-d7af-cf304d07bc8d@loongson.cn>
Date: Mon, 01 Jul 2024 08:01:53 +0100
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
=8D=887:44=EF=BC=8Cmaobibo=E5=86=99=E9=81=93=EF=BC=9A
> Also this patch is problematic on LoongArch.
>
> The original patch is to search physical cpuid rather than logic cpuid.
>
> We want to make ipi module better and better, however now it comes bac=
k=20
> to initial state at the beginning :(

Isn't arch_id the "physical id" you want? "cs->cpu_index" is the logical=
 ID
for QEMU.

arch_id is setup by arch code, like APIC ID for x86.

I had come across the old ipi_getcpu  implementation, and I'm sure we we=
re
looking at arch_id as well.

Thanks
- Jiaxun
>
> commit 03ca348b6b9038ce284916b36c19f700ac0ce7a6
> Author: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Date:   Wed Jun 5 10:04:27 2024
>
>      hw/intc/loongson_ipi: Replace ipi_getcpu with cpu_by_arch_id
>
>      cpu_by_arch_id is doing the same thing as our ipi_getcpu logic.
>
>      Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>      Reviewed-by: Song Gao <gaosong@loongson.cn>
>      Message-ID: <20240605-loongson3-ipi-v3-4-ddd2c0e03fa3@flygoat.com>
>      Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
>
> Regards
> Bibo Mao
>
--=20
- Jiaxun

