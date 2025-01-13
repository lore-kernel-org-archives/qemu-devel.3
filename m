Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D2AC02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 23:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXU2n-0000Zb-9V; Mon, 13 Jan 2025 18:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tXU2l-0000Z6-Pv
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 18:40:27 -0500
Received: from fout-b1-smtp.messagingengine.com ([202.12.124.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tXU2j-0002T4-QD
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 18:40:27 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 13FBD114016E;
 Mon, 13 Jan 2025 18:40:23 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Mon, 13 Jan 2025 18:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1736811622;
 x=1736898022; bh=uqqvwvKm43zvSFZH7Wc/SgbGYNCqGVkth3F6Wbq1avk=; b=
 YgaejmRCSIq2CGbunIWAJPNfqh/fpsFcGFMUS/iWCGOfYNJSHHNlvL8HW4Z971Md
 7NUDFiJSt5B1NeVgTiKd+d6vsCKqd8z4KvmZugres4c2R/gsuCcv5QkQLtBu9GG8
 fIw9d72o9MzzrTXhJiG4bWkmz2sYiQnZ5RVRJGgtEdLGJQsb9iPL8c9awCl8wDQ7
 0PS1R9m6lXEvBZq4GubQxh54RzGAYaKNvvcsbn6F08ttHeVkXJ86axQ5AFHrsGqC
 MAjnhvluCcbpk4zsAQnu3UUSIHJUg5zRXdvtdAAbLsVYceI2u21q7L+JYUWkQQTd
 OT7SCROZbNTTC5HSsWLVJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736811622; x=
 1736898022; bh=uqqvwvKm43zvSFZH7Wc/SgbGYNCqGVkth3F6Wbq1avk=; b=r
 lCkNZ4jQrh81hpgcIht8MuScFKAPVEyQsBNyjyTryBiGQkuVpDALyCV/1tbntcS5
 2N0t3xP2YVExxKNonBsNrWuNUT1zsNZ8UCxTMctAlaH7mK535+t8CMjhyYovhGrQ
 i/tJ6elvyQxLfMzrI6X/LkOJvRJ0lYc+igrJ87vp+ewXHBvhd0Os8Yrl5oS1BCP4
 8WZxzUUE1QxOD7USj64FZs7x3RF1WhuUWc2McdjePdWKEMvhQyoOWl/iQZDZ5eS7
 9zvnxE75NkXuJn+kFlBzbPp5cn/PSMZjDI9GEN/BsbLyR5t/WsHyze7DvGsc3qmG
 b1v5OWogm/crbTNZEMLMA==
X-ME-Sender: <xms:ZqSFZ2T4VTAXUVlf2ilFmUYcnXPk5Pa1EN-iRHu_Fiqma82lahKcLA>
 <xme:ZqSFZ7y26s3ucX8DEB6tznUXHkjpRRWqmZUIjtJeJpFdV0HxyxS1-3ow2bg-XjGGG
 TmTZHoCbQ4ZY0P3yIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehhedguddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
 necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
 hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeet
 hefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
 thdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
 htoheprghurhgvlhhivghnsegruhhrvghlfedvrdhnvghtpdhrtghpthhtoheprghrihhk
 rghlohesghhmrghilhdrtghomhdprhgtphhtthhopegthhgvnhhhuhgrtggriheskhgvrh
 hnvghlrdhorhhgpdhrtghpthhtohepphgruhhlsghurhhtohhnsehkvghrnhgvlhdrohhr
 ghdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpdhrtghpthhtohepqh
 gvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:ZqSFZz0OzQHwCYnnrOBFHRH6LNVvx6E0XUv_L8RPq0-7K24_q59K6Q>
 <xmx:ZqSFZyBKOUqqEvfGNM4HNCamIpkBWoDPzCgXXmx_7Asva1sMOe9fCQ>
 <xmx:ZqSFZ_gTwWQyTjyE6-rDynsfoC76URH7sC5Suy1B_AKp_saVWBN9bA>
 <xmx:ZqSFZ-rsrFenY9yvYdXErVJh8sVVUAj-K2FkOn1st5m0Fj3ZNhT5Mw>
 <xmx:ZqSFZ1ahyPFXFCQSdhQQx5ZGlsz7nhwsU57V-PvYXCu8GyJvt73k4BdB>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 6A6D11C20068; Mon, 13 Jan 2025 18:40:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 13 Jan 2025 23:40:04 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: "paulburton@kernel.org" <paulburton@kernel.org>,
 "Aurelien Jarno" <aurelien@aurel32.net>,
 "Aleksandar Rikalo" <arikalo@gmail.com>,
 "Huacai Chen" <chenhuacai@kernel.org>
Message-Id: <7d718cd9-e0dd-4f97-96ca-8430e41680b7@app.fastmail.com>
In-Reply-To: <20250113195525.57150-1-philmd@linaro.org>
References: <20250113195525.57150-1-philmd@linaro.org>
Subject: Re: [PATCH v2 00/19] hw/mips: Remove all uses of &first_cpu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=202.12.124.144;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-b1-smtp.messagingengine.com
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



=E5=9C=A82025=E5=B9=B41=E6=9C=8813=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8B=E5=
=8D=887:55=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=93=EF=BC=9A
> v2:
> - Add documentation
> - Reorder propagation to reduce code churn around &first_cpu
>
> v1:
> - Keep references to vCPUs in CPS and MaltaState,
> - Refactor the MIPS Bootloader API to take CPU argument
> - Access first CPU propagate from machine_init()
>
> Based-on: <20250112215835.29320-1-philmd@linaro.org>
> "hw/mips/loongson3: Remove uses of &first_cpu global"

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Also tested bootloader stuff :-)

>
> Philippe Mathieu-Daud=C3=A9 (19):
>   hw/mips/cps: Keep reference of vCPUs in MIPSCPSState
>   hw/mips/malta: Check CPU index instead of using &first_cpu
>   hw/mips/malta: Keep reference of vCPUs in MaltaState
>   hw/mips/malta: Propagate MaltaState to write_bootloader()
>   hw/mips/malta: Propagate MaltaState to bl_setup_gt64120_jump_kernel()
>   hw/mips/boston: Replace bl_gen_write_ulong() -> bl_gen_write_u64()
>   hw/mips/boston: Propagate CPU to gen_firmware()
>   hw/mips/fuloong: Propagate CPU to write_bootloader()
>   hw/mips/bootloader: Document public API
>   hw/mips/bootloader: Propagate CPU to bl_gen_write_u[32,64,long]()
>   hw/mips/bootloader: Propagate CPU to bl_gen_jump_[to,kernel]()
>   hw/mips/bootloader: Propagate CPU env to bl_gen_load_ulong()
>   hw/mips/bootloader: Propagate CPU env to bl_gen_[d]li()
>   hw/mips/bootloader: Propagate CPU env to bl_gen_s[w,d]()
>   hw/mips/bootloader: Propagate CPU env to bl_gen_jalr()
>   hw/mips/bootloader: Propagate CPU env to bl_gen_dsll()
>   hw/mips/bootloader: Propagate CPU env to bl_gen_nop()
>   hw/mips/bootloader: Propagate CPU env to bootcpu_supports_isa()
>   hw/mips/bootloader: Remove use of &first_cpu in bootcpu_supports_isa=
()
>
>  include/hw/mips/bootloader.h |  69 +++++++++++++++++++--
>  include/hw/mips/cps.h        |   1 +
>  hw/mips/bootloader.c         | 113 ++++++++++++++++++++---------------
>  hw/mips/boston.c             |  21 ++++---
>  hw/mips/cps.c                |   4 +-
>  hw/mips/fuloong2e.c          |   6 +-
>  hw/mips/malta.c              |  60 +++++++++++--------
>  7 files changed, 184 insertions(+), 90 deletions(-)
>
> --=20
> 2.47.1

--=20
- Jiaxun

