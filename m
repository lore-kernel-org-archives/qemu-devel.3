Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADD2606AC23
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=hQSzmbod;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=UMCbB/Pc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRz9Z-00081A-TM; Fri, 13 Nov 2026 16:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xRz9Y-00080b-3v
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:49:48 -0500
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xRz9V-0005Cz-W4
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:49:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=Vbszunp
 /31e1c1w5ugNZ8FqS8qrB100aOUQFvZZU1W9Bx0+NuD9h3leBkVh4SDySBe2IbGwf86z73
 ZkWwtOb6VNMgKXJ8FDv5kCWSaDXny/+zGuINc/PMlnN0puSbw0sENMBLq70QcJJPL9J+RM
 7HnkXjo3OGNYETCV9fOj3eWN6PC7bLeDG7iqU0jkSFygHQ7vV2lRkY/rs6dHALA/U0A3GM
 BYspPlEq/KXZnH7ZMBaz33s4CEKzCyS4S/YPg5W1sfYZNf3oz2K3VfKSNAPUrMIjy0NHdL
 jBoxPwxxHLwcsKhANzAWOCxKD5jlWttMl+L8+YwQCQACfH/k9U0JqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=6
 zDwH/up1noOHi0hJQoAgQLlnYa5OXaxlSoaLGbfMes=;
 h=date:subject:cc:to:
 from:dkim-signature:dkim-signature; d=mx.catap.net; b=jFcU9e4TuBH5d7L6
 KhGVnI/fTSmuYRahEroNVK7cDu1hV7p78XevVauhc4sVCw5jwPX1BDTk2ECMxm4kcuRO33
 /vU0wew+nCavMvHcNk3MofT2Zbfz1T3mbSX9WapXbjKK/YdZhhGD+SDeuxkz37j27bXpuG
 n5Nsyv+HI7uD9w92jwuGjgYvcFYU7tFM7xPRGT6uuGf6N0rbjUt0UEBMAklcAQmgq3qz0g
 aeDZRTZ5wAAcuqhnO2zt7Nabn4GtCPMfwpcV2yaldrgnghGtj9X/DjehBqrCbOnQiT2/EW
 s0ONVC/FohQjrDu0GWNmjF0fbJc+vI220pBvW2EeEN2kPg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=hQSzmbod; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=UMCbB/Pc;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=6zDwH/up
 1noOHi0hJQoAgQLlnYa5OXaxlSoaLGbfMes=; h=date:subject:cc:to:from;
 d=korins.ky; b=hQSzmbodBtb19PpP2sAj0lskgv/GLeCCmZ86CUbOxyctCf4jceDExo8
 RDMuqu/JbzM7UAI2iPYg3pdyYaTPo99pQeIo/GjPoTEfHfRl340u2Y+tkTBoQ4H57l/CDj
 A135Qe+9pKXbdIgji/B9EeQ1g0PF6DxYfrgBOsYYJRx5DOvhKZiSjJxC8QN3Kgf0x7KlI6
 dE+LbvXY2YsadWpxN6eJP9qKdJlMrwv089gA0ggXDlGEM09AjnzCuRztb47GN2mWWw/2Ou
 md+YBG/IKxvtJQDlwryhmtK6wboc1Bopeoyxjakx6mzwMiC7ouKX0w6oifn25GdYLCqyhN
 R0pL4mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=6zDwH/up1noOHi0hJQoAgQLlnYa5OXaxlSoaLGbfMes=; h=date:subject:cc:to:
 from; d=korins.ky; b=UMCbB/Pco7yOSExT/0d3I2VyANGxOR2v8QNP0XTLekL2pA9WK
 4snMprUhEimDseU7J8itXow9ZhS/Ju4Nn8uDg==
Received: by mx1.catap.net (OpenSMTPD) id e1490d5c;
 Fri, 13 Nov 2026 22:49:41 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 3ad3f9ef;
 Fri, 13 Nov 2026 22:49:32 +0100 (CET)
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
Subject: [PATCH v8 00/26] hw/mips: add Octeon III EBB7304 support
Date: Fri, 13 Nov 2026 22:45:14 +0100
Message-ID: <20261113214926.98536-1-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
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
(v11.2.0-rc0) and addressed a few remarks from Philippe Mathieu-Daudé,
and additional fix of two typos.

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


