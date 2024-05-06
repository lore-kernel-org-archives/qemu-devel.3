Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC75C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 15:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s40Jt-0007jB-0d; Mon, 06 May 2024 11:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s40Jp-0007hE-1D
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:31:59 -0400
Received: from wfhigh1-smtp.messagingengine.com ([64.147.123.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s40Jk-0003JY-Vm
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:31:55 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.west.internal (Postfix) with ESMTP id 4205B1800123;
 Mon,  6 May 2024 11:31:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Mon, 06 May 2024 11:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1715009507; x=1715095907; bh=9q
 kPuxLpOL5az0FyzD29sfaThSDlmwI4Ujxs7bT7BR8=; b=KVLeYhVMvtfUYec51w
 6yyYM0/TbdVzyQ8I3lbnwG0pAsWPx1aZqaa06VTX4DKWrXQTFeC37XmXmW1xb3Yd
 CKtVgh76g00/S56Ra88lKbbduGBEMz1jnc7L3p7as3Oira2aFl5/m2MEs+Tfpkhn
 +ouNhkojOJtCbA9pa1rOUpr6yK+6CvGtkLgHdatMGt8oiaQ+v1VNpbR70Nuf4Yo3
 IMdCM33tJC9rDAxfSQxMVXgfbGm+uPssIfjqeOf8urgbDTvedg+NJbiKp2InIt0S
 Xje9jEf8MHUlH4DkIz/0MZokI6OIkQehoojLwhxeg3pKMMVWNZRQviubgI7CMi3U
 cBEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1715009507; x=1715095907; bh=9qkPuxLpOL5az
 0FyzD29sfaThSDlmwI4Ujxs7bT7BR8=; b=i9O0CvE6y1rU7LI1Cp9X128T/16rZ
 Nw03rMQCxy1ktStAKXQSSnJt350eNCg8et/ID/Z7RO4aruUvs1XGNO5wMh/xmCZ3
 U8YvA05hKCZApd0qaChd6CAN/zMQe6EdUjWXHfXRg5VzeckJ7Q2wVcVtGCNh42hZ
 1gQKWdaSd9hJ+SJiLMAs8pIvT5wv6J1vzdSncG8ovUYe6NBwPcdslh3umknXjMy6
 T+jOlPik5Lse0BGIljCJiKwoV71sCXmgdA2cRHZCn+ph7CJFymS4eJIsI26wyj72
 hbakmg2CnZl4eZ6NI4Dag+1KYtmMzCny1yc5sm1CMpHSQvevKwwOWyyhQ==
X-ME-Sender: <xms:4_c4ZlewNoX7xU7kSfsdodGL4sJDbhBDTYBMRBsG7Nx5eX8zBrtvWA>
 <xme:4_c4ZjNb4SSInvNciEe7ZutSVavFzcMg4WLT2XZfLVh4FGkiC3wxcQfPLuWNd9yj4
 5igVzryVrZ0ScGszq4>
X-ME-Received: <xmr:4_c4Zuj-R3C7qx5gNz-c74CSXIA1Y0s6MNrjNfA1-MTv7bmKj3Vgv1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgledtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtkeertdertdejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepkeejgfdtteeljeeuvdeiteegheefleehgeevuefgfeevhfevheeh
 hfefieegvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:4_c4Zu9kb_AT68gca3Nob57dmI_YpG5YHpHjWmyQ5T6lDsbIs7tiig>
 <xmx:4_c4Zht4tP6mF-qJmMffNdBtzon6CN8T5ImNsEhnjah4PzHdEAEBwQ>
 <xmx:4_c4ZtEBijrl4NhLs-CsOFu2l8fyLktcobq909AN5t2l-I6LROLUkw>
 <xmx:4_c4ZoMdrkeOc_gxtKApzFlCboyFlxKTczzr4cjsO9E-iFUe_cTzOw>
 <xmx:4_c4ZpJwyDrvGq4jzKgxgWhMaCbYTeDVtAJ3qurfyIDc2HzmaqSCfP96>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 11:31:47 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/5] hw/mips: Proper multi core support
Date: Mon, 06 May 2024 16:31:34 +0100
Message-Id: <20240506-mips-smp-v1-0-3cc234786910@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANb3OGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwMz3dzMgmLd4twCXcvENMtUc8PEFItkIyWg8oKi1LTMCrBR0bG1tQC
 V8DEGWgAAAA==
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2782;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=oNlozXeAJRJUSVaV0fKqi4kZN1E3eUjY+6x2UcXdfzA=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjSL7487riTP+lh30eRIuPBRnh87hU5wHr1jM/Wl9T0JI
 U6O4jnsHaUsDGIcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRZF2G//53D+xfsuI5S+zW
 Z5/8tDV+6AkeDnl+XFB/Q9enA092d/UyMhx0EjOTSztyeX1LR2Dxvv4dd7fUdqk/kJE6Hlh66P2
 dRbwA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=64.147.123.152;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfhigh1-smtp.messagingengine.com
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

Hi all,

This series implemented propper multiple core support for MIPS
CPS systsm.

Previously all CPUs are being implemented as a smt thread in a
single core. Now it respects topology supplied in QEMU args.

To test:
Build a latest kernel with 64r6el_defconfig (tested on 6.6,
next-20240506).

Then run:
```
qemu-system-mips64el -M boston -cpu I6500 -kernel ~/linux-next/vmlinux -smp 4,cores=2,threads=2 -append "console=ttyS0,115200" -nographic
```
In dmesg of guest kernel:
```
[    0.000000] VP topology {2,2} total 4
...
[    0.085190] smp: Bringing up secondary CPUs ...
[    0.090219] Primary instruction cache 64kB, VIPT, 4-way, linesize 64 bytes.
[    0.095461] Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 64 bytes
[    0.096658] CPU1 revision is: 0001b000 (MIPS I6500)
[    0.096718] FPU revision is: 20f30300
[    0.124711] Synchronize counters for CPU 1: done.
[    0.940979] Primary instruction cache 64kB, VIPT, 4-way, linesize 64 bytes.
[    0.941041] Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 64 bytes
[    0.941256] CPU2 revision is: 0001b000 (MIPS I6500)
[    0.941289] FPU revision is: 20f30300
[    0.965322] Synchronize counters for CPU 2: done.
[    1.260937] Primary instruction cache 64kB, VIPT, 4-way, linesize 64 bytes.
[    1.261001] Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 64 bytes
[    1.261172] CPU3 revision is: 0001b000 (MIPS I6500)
[    1.261209] FPU revision is: 20f30300
[    1.285390] Synchronize counters for CPU 3: done.
[    1.346985] smp: Brought up 1 node, 4 CPUs
```

Please review.

Thanks

To: qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (5):
      target/mips: Make globalnumber a CPU property
      hw/msic/mips_cmgcr: Implement multicore functions
      hw/msic/mips_cpc: Implement multi core support
      hw/mips/cps: Implement multi core support
      hw/mips/boston: Implement multi core support

 hw/mips/boston.c             |  37 +++++++++-
 hw/mips/cps.c                |  66 ++++++++++-------
 hw/misc/mips_cmgcr.c         | 168 +++++++++++++++++++++++++++++++++++--------
 hw/misc/mips_cpc.c           |  97 ++++++++++++++++++-------
 include/hw/mips/cps.h        |   1 +
 include/hw/misc/mips_cmgcr.h |  87 +++++++++++++++++++---
 include/hw/misc/mips_cpc.h   |  15 +++-
 target/mips/cpu.c            |  16 ++++-
 target/mips/cpu.h            |  10 ++-
 target/mips/sysemu/machine.c |   5 +-
 10 files changed, 403 insertions(+), 99 deletions(-)
---
base-commit: 248f6f62df073a3b4158fd0093863ab885feabb5
change-id: 20240506-mips-smp-9af9e71ad8c2

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


