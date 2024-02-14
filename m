Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A91C4829F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 07:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raA16-00087v-GH; Wed, 14 Feb 2024 02:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raA14-00087L-UN
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 02:49:14 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raA11-0000Uu-LI
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 02:49:14 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d109e82bd0so20169971fa.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 23:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707896949; x=1708501749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BQ6+HEUrpsiIOObbu51RsCVLPpL/i6+IPJ70mWBq6cg=;
 b=WLtQyNEWtDIsHYwZxuHCpJ+PVNdvhIswnPZhr7r7MdpCou/HThJc1cEYe87cjl6Fy1
 BNNpYHYJNE7jfN79w/BqVzTSH6o2iup3hzJXnG9a/xPNoKB2uEk7RegpuYwjnOdfAVuh
 6W86h9kD25a3FPphv5aasyukxdPeNLpowqZ1UO56Nqhg6h9YxS1Atpzzrnc3UXf/2CMQ
 UiIz+/W/RWdHBzZySJJDYuH+HpjfQgAC2qi123TGmTLhzrmvuipaNmJYRgZttFA9wB+o
 lDN9TN7UqVBR4Uws2kvlrh+5waE7acMma0W6b1P5u5JT6N6PcE+0+w359k4Wdfp7b0iN
 WmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707896949; x=1708501749;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BQ6+HEUrpsiIOObbu51RsCVLPpL/i6+IPJ70mWBq6cg=;
 b=Vkk1Ei8WXmMPpUUTQrDmFNo8YDAlyYBKQRFknuOGIdcYMuK5q+Yheu8PpQ/XkqEQWJ
 QUv8JwC6wOjyorzKDhKIG6r+J/UgvibiadMElxx7qlkIu5Jb3ipyzZkg2m1yADl5ybwK
 rb46mZgRzHOtf4pK8IuFTj4n5gBajvR3KC4UtIiJ+Og82770HUcWzMjIasRqArWz7n1u
 MYQwfi0HJ6/QJuzzLQMP+cR5fC+2jMcslCqJRaP2iU2vuCgkxlXZzcheeFx2GuO1lM3V
 qTjqPqL+r9f5jDxoRuf7hDRt4vViKr1PKGrysr8SwYSu2HJAXnvGec96ymk+RBvkITIv
 2HpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXeZGU02Sa7nmBijbq0BfLHkVwQD395/j8DuXFqcE4htbwXTcRKeAIASF6T3qgjkOh21esYz70VW8STrLpBvDLVqWJ3ZY=
X-Gm-Message-State: AOJu0YwwLCkfP4lPtzG4kuO47iac1LXgLI/q23iegunoO9JjJf7dhiYq
 Hdd9u94KHZ0nMeomzTN7OuSAXII7MeG2rwsUGd5jI7eK86BLb4P/hIm8NI3kHnI=
X-Google-Smtp-Source: AGHT+IEjCvQUmL5G0tqj47n0ESO3PT4ZLqamv6ALrWkpPxGxjfcp9wbHHN0hKAcYwC8jfJJFyju8Jg==
X-Received: by 2002:a2e:94d7:0:b0:2d0:e5cc:5795 with SMTP id
 r23-20020a2e94d7000000b002d0e5cc5795mr1258690ljh.0.1707896949149; 
 Tue, 13 Feb 2024 23:49:09 -0800 (PST)
Received: from [192.168.69.100] (mau49-h01-176-184-41-88.dsl.sta.abo.bbox.fr.
 [176.184.41.88]) by smtp.gmail.com with ESMTPSA id
 o4-20020a05600c510400b0040ef95e1c78sm1104675wms.3.2024.02.13.23.49.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 23:49:08 -0800 (PST)
Message-ID: <f95fec4c-a520-4476-b63c-5387b0948ac4@linaro.org>
Date: Wed, 14 Feb 2024 08:49:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Guenter Roeck <linux@roeck-us.net>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <1003f634-f13d-4a9e-af7a-34edc26e22a4@linaro.org>
In-Reply-To: <1003f634-f13d-4a9e-af7a-34edc26e22a4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 14/2/24 08:37, Philippe Mathieu-Daudé wrote:
> On 12/2/24 13:32, Peter Maydell wrote:
> 
>> So I would like to explore whether we can deprecate-and-drop
>> some or all of them. This would let us delete the code entirely
>> rather than spending a long time trying to bring it up to scratch
>> for a probably very small to nonexistent userbase. The aim of this
>> email is to see if anybody is still using any of these and would be
>> upset if they went away. Reports of "I tried to use this machine
>> type and it's just broken" are also interesting as they would
>> strongly suggest that the machine has no real users and can be
>> removed.
>>
>> The machines I have in mind are:


>> OMAP2 machines:
>>
>> n800                 Nokia N800 tablet aka. RX-34 (OMAP2420)
>> n810                 Nokia N810 tablet aka. RX-44 (OMAP2420)
> 
> For me these are broken since 2020 (commit 7998beb9c2 "arm/nseries:
> use memdev for RAM"), this was discussed in
> https://lore.kernel.org/qemu-devel/f2f276a9-a6ad-a2f8-2fbc-f1aca5423f79@amsat.org/
> but there was no clear consensus so I gave up testing them.

Eh good news the tests work again:

$ make check-avocado AVOCADO_TAGS='machine:n800 machine:n810' 
AVOCADO_ALLOW_UNTRUSTED_CODE=1 QEMU_TEST_FLAKY_TESTS=1 
AVOCADO_SHOW=app,console
   AVOCADO tests/avocado
JOB ID     : e089badc8daeae0882eb48e452164d00e8e19c18
JOB LOG    : job-2024-02-14T07.44-e089bad/job.log
  (1/2) tests/avocado/machine_arm_n8x0.py:N8x0Machine.test_n800: \
console: [    0.000000] Linux version 2.6.35~rc4-129.1-n8x0 
(abuild@build08) (gcc version 4.4.2 20091027 (MeeGo 4.4.2-7) (GCC) ) #1 
PREEMPT Mon Jul 12 15:04:46 UTC 2010
console: [    0.000000] CPU: ARMv6-compatible processor [4107b362] 
revision 2 (ARMv6TEJ), cr=00c5387f
console: [    0.000000] CPU: VIPT aliasing data cache, VIPT aliasing 
instruction cache
console: [    0.000000] Machine: Nokia N800
console: [    0.000000] Memory policy: ECC disabled, Data cache writeback
console: [    0.000000] OMAP2420
console: [    0.000000]
console: [    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 
size: 0x100000
console: [    0.000000] Built 1 zonelists in Zone order, mobility 
grouping on.  Total pages: 32512
console: [    0.000000] Kernel command line: printk.time=0 console=ttyS1
console: PID hash table entries: 512 (order: -1, 2048 bytes)
console: Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
console: Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
console: Memory: 128MB = 128MB total
console: Memory: 124008k/124008k available, 7064k reserved, 0K highmem
console: Virtual kernel memory layout:
console: vector  : 0xffff0000 - 0xffff1000   (   4 kB)
console: fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
console: DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
console: vmalloc : 0xc8800000 - 0xf8000000   ( 760 MB)
console: lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
console: modules : 0xbf000000 - 0xc0000000   (  16 MB)
console: .init : 0xc0008000 - 0xc0029000   ( 132 kB)
console: .text : 0xc0029000 - 0xc0379000   (3392 kB)
console: .data : 0xc038e000 - 0xc03ba2e0   ( 177 kB)
console: SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, 
Nodes=1
console: Hierarchical RCU implementation.
console: RCU-based detection of stalled CPUs is disabled.
console: Verbose stalled-CPUs detection is disabled.
console: NR_IRQS:368
console: ------------[ cut here ]------------
console: WARNING: at arch/arm/mach-omap2/clkt_clksel.c:194 
omap2_clksel_recalc+0xcc/0xe0()
console: clock: Could not find fieldval 0 for clock iva1_ifck parent core_ck
console: Modules linked in:
console: [<c002fa1c>] (unwind_backtrace+0x0/0xf0) from [<c0053850>] 
(warn_slowpath_common+0x4c/0x64)
console: [<c0053850>] (warn_slowpath_common+0x4c/0x64) from [<c00538e8>] 
(warn_slowpath_fmt+0x2c/0x3c)
console: [<c00538e8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c00388b4>] 
(omap2_clksel_recalc+0xcc/0xe0)
console: [<c00388b4>] (omap2_clksel_recalc+0xcc/0xe0) from [<c003a91c>] 
(propagate_rate+0x20/0x50)
console: [<c003a91c>] (propagate_rate+0x20/0x50) from [<c003a928>] 
(propagate_rate+0x2c/0x50)
console: ---[ end trace 1b75b31a2719ed1c ]---
console: ------------[ cut here ]------------
console: WARNING: at arch/arm/mach-omap2/clkt_clksel.c:194 
omap2_clksel_recalc+0xcc/0xe0()
console: clock: Could not find fieldval 0 for clock dsp_fck parent core_ck
console: Modules linked in:
console: [<c002fa1c>] (unwind_backtrace+0x0/0xf0) from [<c0053850>] 
(warn_slowpath_common+0x4c/0x64)
console: [<c0053850>] (warn_slowpath_common+0x4c/0x64) from [<c00538e8>] 
(warn_slowpath_fmt+0x2c/0x3c)
console: [<c00538e8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c00388b4>] 
(omap2_clksel_recalc+0xcc/0xe0)
console: [<c00388b4>] (omap2_clksel_recalc+0xcc/0xe0) from [<c003a91c>] 
(propagate_rate+0x20/0x50)
console: [<c003a91c>] (propagate_rate+0x20/0x50) from [<c003a928>] 
(propagate_rate+0x2c/0x50)
console: ---[ end trace 1b75b31a2719ed1d ]---
console: ------------[ cut here ]------------
console: WARNING: at arch/arm/mach-omap2/clkt_clksel.c:194 
omap2_clksel_recalc+0xcc/0xe0()
console: clock: Could not find fieldval 0 for clock dsp_irate_ick parent 
dsp_fck
console: Modules linked in:
console: [<c002fa1c>] (unwind_backtrace+0x0/0xf0) from [<c0053850>] 
(warn_slowpath_common+0x4c/0x64)
console: [<c0053850>] (warn_slowpath_common+0x4c/0x64) from [<c00538e8>] 
(warn_slowpath_fmt+0x2c/0x3c)
console: [<c00538e8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c00388b4>] 
(omap2_clksel_recalc+0xcc/0xe0)
console: [<c00388b4>] (omap2_clksel_recalc+0xcc/0xe0) from [<c003a91c>] 
(propagate_rate+0x20/0x50)
console: [<c003a91c>] (propagate_rate+0x20/0x50) from [<c003a928>] 
(propagate_rate+0x2c/0x50)
console: ---[ end trace 1b75b31a2719ed1e ]---
console: Clocking rate (Crystal/DPLL/MPU): 19.2/658/329 MHz
console: omap_hwmod: l3_hwmod: cannot be enabled (3)
console: omap_hwmod: l4_core_hwmod: cannot be enabled (3)
console: omap_hwmod: l4_wkup_hwmod: cannot be enabled (3)
console: GPMC revision 2.0
console: IRQ: Found an INTC at 0xfa0fe000 (revision 2.1) with 96 interrupts
console: Total of 96 interrupts on 1 active controller
console: OMAP GPIO hardware version 1.8
console: OMAP clockevent source: GPTIMER1 at 32000 Hz
console: Console: colour dummy device 80x30
console: Calibrating delay loop... 897.01 BogoMIPS (lpj=3506176)
console: pid_max: default: 32768 minimum: 301
console: Mount-cache hash table entries: 512
console: CPU: Testing write buffer coherency: ok
console: devtmpfs: initialized
console: NET: Registered protocol family 16
console: MUX: setup L15_24XX_I2C1_SDA (0xfa000112): 0x0018 -> 0x0000
console: MUX: setup M19_24XX_I2C1_SCL (0xfa000111): 0x0018 -> 0x0000
console: MUX: setup H19_24XX_I2C2_SDA (0xfa000114): 0x001f -> 0x0000
console: MUX: setup J15_24XX_I2C2_SCL (0xfa000113): 0x001f -> 0x0010
console: N8x0 MIPID config loaded
console: N8x0 Blizzard initialized
console: MUX: setup H18_24XX_MMC_CMD (0xfa0000f4): 0x001f -> 0x0000
console: MUX: setup H15_24XX_MMC_CLKI (0xfa0000fe): 0x001f -> 0x0000
console: MUX: setup G19_24XX_MMC_CLKO (0xfa0000f3): 0x000f -> 0x0000
console: MUX: setup F20_24XX_MMC_DAT0 (0xfa0000f5): 0x000f -> 0x0000
console: MUX: setup F19_24XX_MMC_DAT_DIR0 (0xfa0000f9): 0x000f -> 0x0000
console: MUX: setup G18_24XX_MMC_CMD_DIR (0xfa0000fd): 0x000f -> 0x0000
console: MUX: setup H14_24XX_MMC_DAT1 (0xfa0000f6): 0x001f -> 0x0000
console: MUX: setup E19_24XX_MMC_DAT2 (0xfa0000f7): 0x000f -> 0x0000
console: MUX: setup D19_24XX_MMC_DAT3 (0xfa0000f8): 0x000f -> 0x0000
console: MUX: setup E20_24XX_MMC_DAT_DIR1 (0xfa0000fa): 0x000f -> 0x0000
console: MUX: setup F18_24XX_MMC_DAT_DIR2 (0xfa0000fb): 0x000f -> 0x0000
console: MUX: setup E18_24XX_MMC_DAT_DIR3 (0xfa0000fc): 0x001f -> 0x0000
console: MUX: setup AA10_242X_DMAREQ0 (0xfa0000e5): 0x001f -> 0x0002
console: MUX: setup AA6_242X_DMAREQ1 (0xfa0000e6): 0x000f -> 0x0002
console: MUX: setup E4_242X_DMAREQ2 (0xfa000074): 0x0018 -> 0x0002
console: MUX: setup G4_242X_DMAREQ3 (0xfa000073): 0x0018 -> 0x0002
console: MUX: setup D3_242X_DMAREQ4 (0xfa000072): 0x0018 -> 0x0002
console: MUX: setup E3_242X_DMAREQ5 (0xfa000071): 0x0018 -> 0x0002
console: TUSB 6010
console: OMAP DMA hardware revision 4.0
console: bio: create slab <bio-0> at 0
console: SCSI subsystem initialized
console: i2c_omap i2c_omap.1: bus 1 rev3.4 at 400 kHz
console: i2c_omap i2c_omap.2: bus 2 rev3.4 at 400 kHz
console: Tahvo/Betty driver initialising
console: Betty v2.1 found
console: Retu/Vilma driver initialising
console: Vilma v1.5 found
console: Bluetooth: Core ver 2.15
console: NET: Registered protocol family 31
console: Bluetooth: HCI device and connection manager initialized
console: Bluetooth: HCI socket layer initialized
console: Switching to clocksource 32k_counter
console: musb_hdrc: version 6.0, tusb-omap-dma, peripheral, debug=0
console: tusb: Unable to detect TUSB6010
console: Could not start tusb6010 (-19)
console: musb_hdrc musb_hdrc: musb_init_controller failed with status -19
console: NET: Registered protocol family 2
console: IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
console: TCP established hash table entries: 4096 (order: 3, 32768 bytes)
console: TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
console: TCP: Hash tables configured (established 4096 bind 4096)
console: TCP reno registered
console: UDP hash table entries: 256 (order: 0, 4096 bytes)
console: UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
console: NET: Registered protocol family 1
console: PMU: registered new PMU device of type 0
console: NetWinder Floating Point Emulator V0.97 (double precision)
console: squashfs: version 4.0 (2009/01/31) Phillip Lougher
console: JFFS2 version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
console: fuse init (API version 7.14)
console: msgmni has been set to 242
console: alg: No test for stdrng (krng)
console: io scheduler noop registered
console: io scheduler cfq registered (default)
console: omapfb: ls041y3 rev 8f LCD detected, 24 data lines
console: omapfb: configured for panel ls041y3
console: omapfb: DISPC version 2.0 initialized
console: omapfb: RFBI version 1.0 initialized
console: omapfb: s1d13745 LCD controller rev 1 initialized (CNF pins 3)
console: omapfb omapfb: s1d1374x: setting update mode to auto
console: Console: switching to colour frame buffer device 100x30
console: omapfb: Framebuffer initialized. Total vram 770048 planes 1
console: omapfb: Pixclock 21940 kHz hfreq 24.9 kHz vfreq 51.0 Hz
console: omap_rng omap_rng: OMAP Random Number Generator ver. 00
console: Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
console: serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a 16550A
console: serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73) is a 16550A
console: console [ttyS1] enabled
console: serial8250.2: ttyS2 at MMIO 0x4806e000 (irq = 74) is a 16550A
console: brd: module loaded
console: loop: module loaded
console: Menelaus rev 2.2
console: OneNAND driver initializing
console: omap2-onenand omap2-onenand: initializing on CS0, phys base 
0x04000000, virtual base c8880000
console: Muxed OneNAND(DDP) 256MB 1.8V 16-bit (0x48)
console: OneNAND version = 0x0000
console: Scanning device for bad blocks
console: Creating 5 MTD partitions on "omap2-onenand":
console: 0x000000000000-0x000000020000 : "bootloader"
console: 0x000000020000-0x000000080000 : "config"
console: 0x000000080000-0x000000280000 : "kernel"
console: 0x000000280000-0x000000680000 : "initfs"
console: 0x000000680000-0x000010000000 : "rootfs"
console: PPP generic driver version 2.4.2
console: PPP Deflate Compression module registered
console: PPP BSD Compression module registered
console: tun: Universal TUN/TAP device driver, 1.6
console: tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
console: mice: PS/2 mouse device common for all mice
console: lm8323 2-0045: sent 2 bytes of -121 total
console: lm8323 2-0045: sending read cmd 0x82 failed
console: lm8323 2-0045: sent 2 bytes of -121 total
console: lm8323 2-0045: sent 2 bytes of -121 total
console: lm8323 2-0045: sent 2 bytes of -121 total
console: lm8323 2-0045: sent 2 bytes of -121 total
console: lm8323 2-0045: sent 2 bytes of -121 total
console: lm8323 2-0045: sent 3 bytes of -121 total
console: lm8323 2-0045: sent 3 bytes of -121 total
console: lm8323 2-0045: sending read cmd 0x80 failed
console: lm8323 2-0045: device not found
console: TSC2005 driver initializing
PASS (2.61 s)
  (2/2) tests/avocado/machine_arm_n8x0.py:N8x0Machine.test_n810: /
console: [    0.000000] Linux version 2.6.35~rc4-129.1-n8x0 
(abuild@build08) (gcc version 4.4.2 20091027 (MeeGo 4.4.2-7) (GCC) ) #1 
PREEMPT Mon Jul 12 15:04:46 UTC 2010
console: [    0.000000] CPU: ARMv6-compatible processor [4107b362] 
revision 2 (ARMv6TEJ), cr=00c5387f
console: [    0.000000] CPU: VIPT aliasing data cache, VIPT aliasing 
instruction cache
console: [    0.000000] Machine: Nokia N810
console: [    0.000000] Memory policy: ECC disabled, Data cache writeback
console: [    0.000000] OMAP2420
console: [    0.000000]
console: [    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 
size: 0x100000
console: [    0.000000] Built 1 zonelists in Zone order, mobility 
grouping on.  Total pages: 32512
console: [    0.000000] Kernel command line: printk.time=0 console=ttyS1
console: PID hash table entries: 512 (order: -1, 2048 bytes)
console: Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
console: Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
console: Memory: 128MB = 128MB total
console: Memory: 124008k/124008k available, 7064k reserved, 0K highmem
console: Virtual kernel memory layout:
console: vector  : 0xffff0000 - 0xffff1000   (   4 kB)
console: fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
console: DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
console: vmalloc : 0xc8800000 - 0xf8000000   ( 760 MB)
console: lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
console: modules : 0xbf000000 - 0xc0000000   (  16 MB)
console: .init : 0xc0008000 - 0xc0029000   ( 132 kB)
console: .text : 0xc0029000 - 0xc0379000   (3392 kB)
console: .data : 0xc038e000 - 0xc03ba2e0   ( 177 kB)
console: SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, 
Nodes=1
console: Hierarchical RCU implementation.
console: RCU-based detection of stalled CPUs is disabled.
console: Verbose stalled-CPUs detection is disabled.
console: NR_IRQS:368
console: ------------[ cut here ]------------
console: WARNING: at arch/arm/mach-omap2/clkt_clksel.c:194 
omap2_clksel_recalc+0xcc/0xe0()
console: clock: Could not find fieldval 0 for clock iva1_ifck parent core_ck
console: Modules linked in:
console: [<c002fa1c>] (unwind_backtrace+0x0/0xf0) from [<c0053850>] 
(warn_slowpath_common+0x4c/0x64)
console: [<c0053850>] (warn_slowpath_common+0x4c/0x64) from [<c00538e8>] 
(warn_slowpath_fmt+0x2c/0x3c)
console: [<c00538e8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c00388b4>] 
(omap2_clksel_recalc+0xcc/0xe0)
console: [<c00388b4>] (omap2_clksel_recalc+0xcc/0xe0) from [<c003a91c>] 
(propagate_rate+0x20/0x50)
console: [<c003a91c>] (propagate_rate+0x20/0x50) from [<c003a928>] 
(propagate_rate+0x2c/0x50)
console: ---[ end trace 1b75b31a2719ed1c ]---
console: ------------[ cut here ]------------
console: WARNING: at arch/arm/mach-omap2/clkt_clksel.c:194 
omap2_clksel_recalc+0xcc/0xe0()
console: clock: Could not find fieldval 0 for clock dsp_fck parent core_ck
console: Modules linked in:
console: [<c002fa1c>] (unwind_backtrace+0x0/0xf0) from [<c0053850>] 
(warn_slowpath_common+0x4c/0x64)
console: [<c0053850>] (warn_slowpath_common+0x4c/0x64) from [<c00538e8>] 
(warn_slowpath_fmt+0x2c/0x3c)
console: [<c00538e8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c00388b4>] 
(omap2_clksel_recalc+0xcc/0xe0)
console: [<c00388b4>] (omap2_clksel_recalc+0xcc/0xe0) from [<c003a91c>] 
(propagate_rate+0x20/0x50)
console: [<c003a91c>] (propagate_rate+0x20/0x50) from [<c003a928>] 
(propagate_rate+0x2c/0x50)
console: ---[ end trace 1b75b31a2719ed1d ]---
console: ------------[ cut here ]------------
console: WARNING: at arch/arm/mach-omap2/clkt_clksel.c:194 
omap2_clksel_recalc+0xcc/0xe0()
console: clock: Could not find fieldval 0 for clock dsp_irate_ick parent 
dsp_fck
console: Modules linked in:
console: [<c002fa1c>] (unwind_backtrace+0x0/0xf0) from [<c0053850>] 
(warn_slowpath_common+0x4c/0x64)
console: [<c0053850>] (warn_slowpath_common+0x4c/0x64) from [<c00538e8>] 
(warn_slowpath_fmt+0x2c/0x3c)
console: [<c00538e8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c00388b4>] 
(omap2_clksel_recalc+0xcc/0xe0)
console: [<c00388b4>] (omap2_clksel_recalc+0xcc/0xe0) from [<c003a91c>] 
(propagate_rate+0x20/0x50)
console: [<c003a91c>] (propagate_rate+0x20/0x50) from [<c003a928>] 
(propagate_rate+0x2c/0x50)
console: ---[ end trace 1b75b31a2719ed1e ]---
console: Clocking rate (Crystal/DPLL/MPU): 19.2/658/329 MHz
console: omap_hwmod: l3_hwmod: cannot be enabled (3)
console: omap_hwmod: l4_core_hwmod: cannot be enabled (3)
console: omap_hwmod: l4_wkup_hwmod: cannot be enabled (3)
console: GPMC revision 2.0
console: IRQ: Found an INTC at 0xfa0fe000 (revision 2.1) with 96 interrupts
console: Total of 96 interrupts on 1 active controller
console: OMAP GPIO hardware version 1.8
console: OMAP clockevent source: GPTIMER1 at 32000 Hz
console: Console: colour dummy device 80x30
console: Calibrating delay loop... 803.49 BogoMIPS (lpj=3137536)
console: pid_max: default: 32768 minimum: 301
console: Mount-cache hash table entries: 512
console: CPU: Testing write buffer coherency: ok
console: devtmpfs: initialized
console: NET: Registered protocol family 16
console: MUX: setup L15_24XX_I2C1_SDA (0xfa000112): 0x0018 -> 0x0000
console: MUX: setup M19_24XX_I2C1_SCL (0xfa000111): 0x0018 -> 0x0000
console: MUX: setup H19_24XX_I2C2_SDA (0xfa000114): 0x001f -> 0x0000
console: MUX: setup J15_24XX_I2C2_SCL (0xfa000113): 0x001f -> 0x0010
console: N8x0 MIPID config loaded
console: N8x0 Blizzard initialized
console: MUX: setup H18_24XX_MMC_CMD (0xfa0000f4): 0x001f -> 0x0000
console: MUX: setup H15_24XX_MMC_CLKI (0xfa0000fe): 0x001f -> 0x0000
console: MUX: setup G19_24XX_MMC_CLKO (0xfa0000f3): 0x000f -> 0x0000
console: MUX: setup F20_24XX_MMC_DAT0 (0xfa0000f5): 0x000f -> 0x0000
console: MUX: setup F19_24XX_MMC_DAT_DIR0 (0xfa0000f9): 0x000f -> 0x0000
console: MUX: setup G18_24XX_MMC_CMD_DIR (0xfa0000fd): 0x000f -> 0x0000
console: MUX: setup H14_24XX_MMC_DAT1 (0xfa0000f6): 0x001f -> 0x0000
console: MUX: setup E19_24XX_MMC_DAT2 (0xfa0000f7): 0x000f -> 0x0000
console: MUX: setup D19_24XX_MMC_DAT3 (0xfa0000f8): 0x000f -> 0x0000
console: MUX: setup E20_24XX_MMC_DAT_DIR1 (0xfa0000fa): 0x000f -> 0x0000
console: MUX: setup F18_24XX_MMC_DAT_DIR2 (0xfa0000fb): 0x000f -> 0x0000
console: MUX: setup E18_24XX_MMC_DAT_DIR3 (0xfa0000fc): 0x001f -> 0x0000
console: MUX: setup AA10_242X_DMAREQ0 (0xfa0000e5): 0x001f -> 0x0002
console: MUX: setup AA6_242X_DMAREQ1 (0xfa0000e6): 0x000f -> 0x0002
console: MUX: setup E4_242X_DMAREQ2 (0xfa000074): 0x0018 -> 0x0002
console: MUX: setup G4_242X_DMAREQ3 (0xfa000073): 0x0018 -> 0x0002
console: MUX: setup D3_242X_DMAREQ4 (0xfa000072): 0x0018 -> 0x0002
console: MUX: setup E3_242X_DMAREQ5 (0xfa000071): 0x0018 -> 0x0002
console: TUSB 6010
console: OMAP DMA hardware revision 4.0
console: bio: create slab <bio-0> at 0
console: SCSI subsystem initialized
console: i2c_omap i2c_omap.1: bus 1 rev3.4 at 400 kHz
console: i2c_omap i2c_omap.2: bus 2 rev3.4 at 400 kHz
console: Tahvo/Betty driver initialising
console: Betty v2.1 found
console: Retu/Vilma driver initialising
console: Vilma v1.5 found
console: Bluetooth: Core ver 2.15
console: NET: Registered protocol family 31
console: Bluetooth: HCI device and connection manager initialized
console: Bluetooth: HCI socket layer initialized
console: Switching to clocksource 32k_counter
console: musb_hdrc: version 6.0, tusb-omap-dma, peripheral, debug=0
console: tusb: Unable to detect TUSB6010
console: Could not start tusb6010 (-19)
console: musb_hdrc musb_hdrc: musb_init_controller failed with status -19
console: NET: Registered protocol family 2
console: IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
console: TCP established hash table entries: 4096 (order: 3, 32768 bytes)
console: TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
console: TCP: Hash tables configured (established 4096 bind 4096)
console: TCP reno registered
console: UDP hash table entries: 256 (order: 0, 4096 bytes)
console: UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
console: NET: Registered protocol family 1
console: PMU: registered new PMU device of type 0
console: NetWinder Floating Point Emulator V0.97 (double precision)
console: squashfs: version 4.0 (2009/01/31) Phillip Lougher
console: JFFS2 version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
console: fuse init (API version 7.14)
console: msgmni has been set to 242
console: alg: No test for stdrng (krng)
console: io scheduler noop registered
console: io scheduler cfq registered (default)
console: omapfb: ls041y3 rev 8f LCD detected, 24 data lines
console: omapfb: configured for panel ls041y3
console: omapfb: DISPC version 2.0 initialized
console: omapfb: RFBI version 1.0 initialized
console: omapfb: s1d13745 LCD controller rev 1 initialized (CNF pins 3)
console: omapfb omapfb: s1d1374x: setting update mode to auto
console: Console: switching to colour frame buffer device 100x30
console: omapfb: Framebuffer initialized. Total vram 770048 planes 1
console: omapfb: Pixclock 21940 kHz hfreq 24.9 kHz vfreq 51.0 Hz
console: omap_rng omap_rng: OMAP Random Number Generator ver. 00
console: Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
console: serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a 16550A
console: serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73) is a 16550A
console: console [ttyS1] enabled
console: serial8250.2: ttyS2 at MMIO 0x4806e000 (irq = 74) is a 16550A
console: brd: module loaded
console: loop: module loaded
-console: Menelaus rev 2.2
console: OneNAND driver initializing
console: omap2-onenand omap2-onenand: initializing on CS0, phys base 
0x04000000, virtual base c8880000
console: Muxed OneNAND(DDP) 256MB 1.8V 16-bit (0x48)
console: OneNAND version = 0x0000
console: Scanning device for bad blocks
console: Creating 5 MTD partitions on "omap2-onenand":
console: 0x000000000000-0x000000020000 : "bootloader"
console: 0x000000020000-0x000000080000 : "config"
console: 0x000000080000-0x000000280000 : "kernel"
console: 0x000000280000-0x000000680000 : "initfs"
console: 0x000000680000-0x000010000000 : "rootfs"
console: PPP generic driver version 2.4.2
console: PPP Deflate Compression module registered
console: PPP BSD Compression module registered
console: tun: Universal TUN/TAP device driver, 1.6
console: tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
console: mice: PS/2 mouse device common for all mice
console: lm8323 2-0045: sent 2 bytes of -121 total
console: lm8323 2-0045: sending read cmd 0x82 failed
console: lm8323 2-0045: sent 2 bytes of -121 total
console: lm8323 2-0045: sent 2 bytes of -121 total
console: lm8323 2-0045: sent 2 bytes of -121 total
console: lm8323 2-0045: sent 2 bytes of -121 total
console: lm8323 2-0045: sent 2 bytes of -121 total
console: lm8323 2-0045: sent 3 bytes of -121 total
console: lm8323 2-0045: sent 3 bytes of -121 total
console: lm8323 2-0045: sending read cmd 0x80 failed
console: lm8323 2-0045: device not found
console: TSC2005 driver initializing
PASS (2.30 s)
RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | 
CANCEL 0
JOB TIME   : 5.49 s


