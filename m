Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0A1606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=intQIeIR;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=hOjGY5W9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR9Qy-0000sa-2y; Wed, 11 Nov 2026 09:36:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xR9Qm-0000qS-Rq
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:36:10 -0500
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xR9Qj-00025c-FN
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:36:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=CHUk7NO
 L/0UHn7wziu6r4IF6Zvafckrtt2UOItTS4jKA4CtTsZBSmuPvQTcZJzNbGeEPe6p5ZsSS1
 DrVe9KQ5XwXQZ5q4ADtTjOMSdwIon/6f8bZa2XzOFEHdExCROuTAYDmpqcMdss/By3oCeQ
 ahxLiu7w+zeTbsrk921YY/pRmVgt5oLreeWGAxi/BTlGC+soilczvozvNK4jCEUT1bgrYF
 MmcZXwy3OZMcXmfMYQYnO2eWfAlrOVvzrlR5Zr9IHC9W/rBE1puoBely/3/sX9JhB3I/4k
 ntjE5HJlY8TDGCKee8YuahB/1zxLxK8MLOhwDvZF9mtIJp55EUSV14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=l
 rjAqoX31HMeMlQZhR+5MVnVxIgBTE6lizCSXn57Hlg=;
 h=date:subject:cc:to:
 from:dkim-signature:dkim-signature; d=mx.catap.net; b=eJ0oQImUZPkZ2dGi
 eJYLYoSoV1n93uMOFxG2htrRPizIZyk0xljyomxH+Db5nN+Gd6bMp2gmXc57NvfVsoQrk3
 Kt80RpxMV3veFWOyHvD4v259THk+gzMFRXMI9gNzDz34r1eNaue84g0K/9nhj4DZMDpITn
 E+45GoZmTj9y6YkJ6aVldY5Ai/OWgvDHb4jbHNzomWM/wGoDXKQ/bXXG6F+BXh8ft5vGqd
 U8Ewk2fwK7m6FNuqzMk/pQlVPKBg4VQqduRStiEj3nv9/DRrQXWpCazWpxu2cYpz+VRQR1
 P/SurSJt38tT0XtBoYBhC38vhtuDBG8aVaWet+tPCRvDCg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=intQIeIR; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=hOjGY5W9;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=lrjAqoX3
 1HMeMlQZhR+5MVnVxIgBTE6lizCSXn57Hlg=; h=date:subject:cc:to:from;
 d=korins.ky; b=intQIeIRpIaaw1oyC4owiVY7TzcYeSCN4RCn71e7ubmATnXXesR7+p5
 E8kysG8NhnMTX7rtekQQ9o13D2zAYFSfdOvZS4Wtk4Q7H18wie2S8u3PWwIHvCwUqdd7x/
 Po3VX+hrGm/bhqSdlYLCRhWKnC/mFwwOf57a6YaiAIXDJ7hk/5a33TDhgQj4dMoyOMQ4sy
 6QRJEkxzlMsfCEopnM7ENu+3iO2hC3VgTSCb1arrpY7lJewCceEhKl9ZViuOOnC4TH98/C
 C9vZh5ZbuhpxFsqnn6u2cL3X4xG7OIj6LCeozA03JnE49B3TNkBbK7dIYceCAGJy4eYHcD
 pYkJv2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=lrjAqoX31HMeMlQZhR+5MVnVxIgBTE6lizCSXn57Hlg=; h=date:subject:cc:to:
 from; d=korins.ky; b=hOjGY5W9AeEyOzwC043wBjVtLuFLQ+XAT5MpOyqB+4MtyW4p9
 FToIKPMZqlRqVkMy9uFap7G1OLF69SUdVtRCA==
Received: by mx2.catap.net (OpenSMTPD) id 64e8dbc3;
 Wed, 11 Nov 2026 15:35:58 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 1f1f04bd;
 Wed, 11 Nov 2026 15:35:54 +0100 (CET)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PATCH v7 0/26] hw/mips: add Octeon III EBB7304 support
Date: Wed, 11 Nov 2026 15:32:00 +0100
Message-ID: <20261111143533.1775-1-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Greetings,

This is rebased to 29760efaf96bbe5928f8111881eddbf5ac06439e
(v11.2.0-rc0) and addressed a few remarks from Philippe Mathieu-Daudé.

This series adds enough Cavium Octeon III CN73xx and EBB7304 board
support for upstream U-Boot 2026.04 to boot OpenBSD/octeon from USB
storage or through PCI e1000 and TFTP; the same machine also reaches
the prompt of the vendor U-Boot 2013.07 image from the Ubiquiti
EdgeRouter Infinity ER-8-XG recovery set. The model intentionally
covers the hardware exercised by these firmware and operating system
paths.

The vendor recovery image is U-Boot 2013.07, UBNT build
e1000_002_ef3a9; it reaches:

    Octeon ubnt_e1000(Failsafe)#

This is the expected command prompt of the recovery U-Boot environment;
"Failsafe" describes the recovery image and does not indicate an
emulation or boot failure.

Early Octeon investigation used Amir Mehmood's original Octeon
host.patch as a behavioral reference; the basic machine approach and
several hardware model ideas come from that work. No code from that
patch remains in this implementation.

The series starts with three generic MIPS correctness fixes for MTTCG
interrupt state, MIPS64 segment checks, and architectural tlbwr
replacement semantics. It then adds Octeon CP0 state, the CN73xx CPU
model, PageMask handling, and unaligned accesses before introducing an
empty EBB7304 machine. The remaining patches add the machine state and
peripherals incrementally, followed by the functional test.

The machine currently models:

* the EBB7304 RAM layout, boot flash aliases, and boot-local RAM;
* CN73xx CPUs, Octeon CP0 state, CVMSEG, and configurable clocks;
* reset control, legacy CIU and CIU3 interrupt routing, mailboxes, and
  secondary CPU release;
* UART, two TWSI controllers, synthesized DDR4 SPD, four LMC register
  banks, fuses, RNG, POW, and the firmware probes used during platform
  initialization;
* the EMM registers needed for firmware MMC initialization;
* two UCTL-wrapped DWC3 controllers, sufficient for U-Boot USB storage;
* a minimal PCIe host bridge, sufficient for a PCI e1000 device.

The functional test starts upstream U-Boot with four CPUs, enumerates
PCI, obtains a DHCP lease, downloads bsd.rd through user mode TFTP, and
boots the OpenBSD/octeon 7.9 installer.

The OpenBSD boot and USB stress testing requires additional patch for
xHCI which I haven't included into this series:
https://patchew.org/QEMU/20260719215455.96122-1-kirill@korins.ky/

Each submitted commit was built in sequence and given the meaningful
smoke test available at that point. The final tree was tested with:

    ninja -C build qemu-system-mips64
    gmake -C build check-qtest-mips64
    gmake -C build check-functional-mips64

The machine was used to build a few GCC build and full OpenBSD/octeon
release with LLVM inside OpenBSD/octeon using:

    -m 32G -smp 8 -accel tcg,thread=multi

The longest non interrupted workload was near two weeks.

Known limitations are:

* native Octeon Ethernet is not modelled; the OpenBSD test uses PCI
  e1000;
* EMM implements the firmware initialization path, not a complete MMC
  data path;
* direct kernel boot through -kernel is not implemented;
* the newly modelled board and peripheral state lacks VMState
  descriptions; migration and savevm are not expected to preserve the
  complete machine state.

Patch layout:

  1. target/mips: make CP0 interrupt state atomic
  2. target/mips: fix MIPS64 segment access checks
  3. target/mips: drop hidden TLB shadowing for tlbwr
  4. target/mips: add Octeon CP0 register state
  5. target/mips: add Octeon CN73xx CPU model
  6. target/mips: pass env to compute_pagemask
  7. target/mips: accept Octeon PageMask encodings
  8. target/mips: allow Octeon unaligned accesses
  9. hw/mips: add empty Octeon III machine
 10. hw/mips: add Octeon CPUs and boot memory
 11. hw/mips: add Octeon reset controller
 12. hw/mips: add Octeon CIU3 CPU control
 13. hw/mips: add Octeon CIU3 interrupt routing
 14. hw/mips: add Octeon legacy CIU
 15. hw/mips: add Octeon CSR window
 16. hw/mips: expose Octeon reset CSRs
 17. hw/mips: add Octeon MIO boot support
 18. hw/mips: wire the Octeon UART
 19. hw/i2c: add Octeon TWSI controller
 20. hw/mips: add Octeon EMM controller
 21. hw/mips: add Octeon LMC controllers
 22. hw/mips: add Octeon boot support registers
 23. hw/usb: add Octeon USB controller
 24. hw/pci-bridge: add Octeon PCI host bridge
 25. hw/pci-bridge: add Octeon PCI memory window
 26. tests/functional: test Octeon III boot



