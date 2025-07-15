Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF2EC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublQd-0004CT-DM; Tue, 15 Jul 2025 15:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1ubl0z-0006Vz-5I
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:08:33 -0400
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1ubl0x-0001yj-Fj
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:08:32 -0400
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id BC473EC004E;
 Tue, 15 Jul 2025 15:08:30 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
 by phl-compute-06.internal (MEProxy); Tue, 15 Jul 2025 15:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1752606510;
 x=1752692910; bh=9PXGdBXHEkP0pmHM6WU1rsR0w2iS+OHLLukB/M/TEjA=; b=
 Z6qrzYpENDgrwf3u8j0vFndP5mCJ9LaZLAuwhyqTjz1FjUHrAXMlrYQi2QTB3BS9
 7CLnewSv7ML6oU+3qU7RLjOYDWlZACvO+hzsdPEVouuauHRJXHkRoo6Vr53hmbkE
 uCVkT1GUHRVwEEMcD7frEQD3BZYis0RLVCN6jCeVYzAqUJ5cK+nW14AvgTfSgckI
 49oR1E0SitpLx2DmzlNYm589ENPk520Jhm8ASMBrh8eByHMTN6qNshCagcvgKZYz
 riIS0/R4na2pe/l0/IV+uXBwnrvxQZ66ooL38lnGMZq0mOqwMRvzWzTgTF3YkWlm
 pIfsxPvhUZRT2MhdZu+bsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1752606510; x=1752692910; bh=9
 PXGdBXHEkP0pmHM6WU1rsR0w2iS+OHLLukB/M/TEjA=; b=oRwd0M7jCTdu42BHU
 pqwXsyOxw8dAAwGHuTeq21tNcocGB4iHomQQ8vQxg0ExfjAgQGfLIKSicCTs4hX3
 FcQW87WayS0bn7OqJzxVw5bBfNqoEk1u5hz3QEP4HenwQETri8zHNap9usTDphz0
 nztAhDW/lvFQnUhIIxsMKq+kx0q95H9WAPPZde3NGH9HGwhLVzWA/Y7Qu4OhJVZC
 fxFLGH5ulMJMMoqLMx4v6WDGWsCxA4cnfFjFyd2pstQWXVrNuJfGzWS+z6n7JGML
 4VIeHMy0zoUM/TJ+5jFRlUccHPrfqmiXglgCFeLZ+Koq7hpovCyzzh07FtD4UlJn
 81l2Q==
X-ME-Sender: <xms:Lqd2aI2mx3gCcAeU3YzqINLWfPIioFwKAHz0R-sC48syFRWZp5ohlQ>
 <xme:Lqd2aDG0luTUURboU-qUVSaRwTq4ppEVWFiRpysZpl1_myeDryfnPo5HRXYYwPjq6
 fcNsEATlW1rMNgf3Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheeifecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedflfhirgiguhhn
 ucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepjedvgfetvefhfffhudffheelieeiveelvdeileffgfeghfefkeeu
 hfdugeefleffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdpnhgspghrtghpthht
 ohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhlmhgusehlihhnrg
 hrohdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:Lqd2aPg4fZ-DucngGRjaq0FHgL7mUQ9PWBzMeAx2PKLwGJ0X2G2LkA>
 <xmx:Lqd2aMMHaTJD9xgEnJlS9yhOr9EgGLKRlljqNTeFP6b-bFkOQCj6cw>
 <xmx:Lqd2aA7JTz3v9A73_0V2xp8aq9s0svwfnoyjylKbf9Y-zta3mtNkpA>
 <xmx:Lqd2aK2sSTCpdo8lmhMO2OA4yFMVNS1NO-hd7iEMuddOOVj4nxfZlw>
 <xmx:Lqd2aCznaWn2s65310zT2V-r4vGKJTbOZ4I4zvkOhHgwRugtK0eu-ttu>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 7087E2CE0071; Tue, 15 Jul 2025 15:08:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: Tb0803b803f43f61f
Date: Tue, 15 Jul 2025 20:08:08 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "QEMU devel" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Message-Id: <632e091b-9af7-4363-8ce6-73cb6bde41b4@app.fastmail.com>
In-Reply-To: <20240506-mips-smp-v1-0-3cc234786910@flygoat.com>
References: <20240506-mips-smp-v1-0-3cc234786910@flygoat.com>
Subject: Re: [PATCH 0/5] hw/mips: Proper multi core support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.148;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-a5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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



=E5=9C=A82024=E5=B9=B45=E6=9C=886=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=
=8D=884:31=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> Hi all,
>
> This series implemented propper multiple core support for MIPS
> CPS systsm.

Ping :-)

This is a really long outstanding series, I just want to get some
review before respin.

Thanks
Jiaxun

>
> Previously all CPUs are being implemented as a smt thread in a
> single core. Now it respects topology supplied in QEMU args.
>
> To test:
> Build a latest kernel with 64r6el_defconfig (tested on 6.6,
> next-20240506).
>
> Then run:
> ```
> qemu-system-mips64el -M boston -cpu I6500 -kernel ~/linux-next/vmlinux=20
> -smp 4,cores=3D2,threads=3D2 -append "console=3DttyS0,115200" -nograph=
ic
> ```
> In dmesg of guest kernel:
> ```
> [    0.000000] VP topology {2,2} total 4
> ...
> [    0.085190] smp: Bringing up secondary CPUs ...
> [    0.090219] Primary instruction cache 64kB, VIPT, 4-way, linesize 6=
4=20
> bytes.
> [    0.095461] Primary data cache 64kB, 4-way, PIPT, no aliases,=20
> linesize 64 bytes
> [    0.096658] CPU1 revision is: 0001b000 (MIPS I6500)
> [    0.096718] FPU revision is: 20f30300
> [    0.124711] Synchronize counters for CPU 1: done.
> [    0.940979] Primary instruction cache 64kB, VIPT, 4-way, linesize 6=
4=20
> bytes.
> [    0.941041] Primary data cache 64kB, 4-way, PIPT, no aliases,=20
> linesize 64 bytes
> [    0.941256] CPU2 revision is: 0001b000 (MIPS I6500)
> [    0.941289] FPU revision is: 20f30300
> [    0.965322] Synchronize counters for CPU 2: done.
> [    1.260937] Primary instruction cache 64kB, VIPT, 4-way, linesize 6=
4=20
> bytes.
> [    1.261001] Primary data cache 64kB, 4-way, PIPT, no aliases,=20
> linesize 64 bytes
> [    1.261172] CPU3 revision is: 0001b000 (MIPS I6500)
> [    1.261209] FPU revision is: 20f30300
> [    1.285390] Synchronize counters for CPU 3: done.
> [    1.346985] smp: Brought up 1 node, 4 CPUs
> ```
>
> Please review.
>
> Thanks
>
> To: qemu-devel@nongnu.org
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Jiaxun Yang (5):
>       target/mips: Make globalnumber a CPU property
>       hw/msic/mips_cmgcr: Implement multicore functions
>       hw/msic/mips_cpc: Implement multi core support
>       hw/mips/cps: Implement multi core support
>       hw/mips/boston: Implement multi core support
>
>  hw/mips/boston.c             |  37 +++++++++-
>  hw/mips/cps.c                |  66 ++++++++++-------
>  hw/misc/mips_cmgcr.c         | 168 ++++++++++++++++++++++++++++++++++=
+--------
>  hw/misc/mips_cpc.c           |  97 ++++++++++++++++++-------
>  include/hw/mips/cps.h        |   1 +
>  include/hw/misc/mips_cmgcr.h |  87 +++++++++++++++++++---
>  include/hw/misc/mips_cpc.h   |  15 +++-
>  target/mips/cpu.c            |  16 ++++-
>  target/mips/cpu.h            |  10 ++-
>  target/mips/sysemu/machine.c |   5 +-
>  10 files changed, 403 insertions(+), 99 deletions(-)
> ---
> base-commit: 248f6f62df073a3b4158fd0093863ab885feabb5
> change-id: 20240506-mips-smp-9af9e71ad8c2
>
> Best regards,
> --=20
> Jiaxun Yang <jiaxun.yang@flygoat.com>

--=20
- Jiaxun

