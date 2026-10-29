Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3011606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=dJH2Hh9s;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=82jY+TWq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMU8Y-0003Xu-2o; Thu, 29 Oct 2026 13:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMU8S-0003XS-Gf
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:41:56 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMU8O-0003H7-Ua
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:41:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=HHKq+EZ
 5qfq+GIJUU8rC01GWXB144j5emQJzqhh6rfHAdkQ8+0dxsDZM7ZoZO1ZHOoMyWNau+Rk9Y
 y1wgEqleKxku1IGNGfbAqvQQRs9IP2huHpJU1Z0oIhJnypl4UFGDhqnwQcXc3TPn1oOKBf
 68qfWdO/4zTjdWqEjc25VzDDQFYE5BAszPt7CzjNgzhaje49bbkh0wBnt4DEfx7lXB5Akr
 b7Xq4ZzOEZbbOL+czXjoyv06VdIMtCY4Bbt7rgXMhKvkQdBFj9WPy0cA8CT/wvE1Xo9Mlo
 wYtfYWARx1V7Dg0Xdo8mGqjjzpPwc2PHAGVKDqStYf0eWXuGVXXeaUA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=b
 4aTiViJEXmalCfxKWaxBCKTASeyCnEd0OTkGijMyMk=;
 h=date:subject:cc:to:
 from:dkim-signature:dkim-signature; d=mx.catap.net; b=pYTEaLEdVyiZxWez
 Zn2JkShjpDkjuHponb6zStvs6sR22ep1xjI+2KFuRTwuwGzYVLYf1MA3fSfL7p0iy69Ntp
 SRQiOLRD8D2x83ewgQvC56GnX1af8BrVEftMrweGPDjhpnm8LRHr3eqF+hXubOmIOh5EiR
 4sMUDFpqR1YFOzdU+ppd8ErQo6nqrz+teMABt7Q+mA/YA/dJT4Poc0A40l1gtnlx372UjW
 Woo2SM0Dnlehi3dz29+OoJOiNEUrjoxRBF+ukFhPMVrHMQuE4pBEmzpmAkyhibaHLyM1Oi
 roXGxisDoHYq+86bdOs5bBuAqaW7uVHOVlM8a/sAaoUhmw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=dJH2Hh9s; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=82jY+TWq;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=b4aTiViJ
 EXmalCfxKWaxBCKTASeyCnEd0OTkGijMyMk=; h=date:subject:cc:to:from;
 d=korins.ky; b=dJH2Hh9sBIHOxRz89/vgqTdy2KE2TEQFhqntbdD8Ox3qAQ0W3dMAYv7
 WuP6wRmS7N1399avx2cHHLfvSb9xotDKyk//f3q9jhuO6heqrqpYuYREZkk+3YeGcgqc4h
 jXGTKevN33xdcFjuWLe9sk9zaxU0go9hVxPzudzEaKzQ3HUdFJQD6U0uqnsi9e9hHCoaWy
 H9z3S3wUeaTJR70LO7DuHBxoQUdpugz1DB3SVdowvapeYrHAIQ6QdYO1gqn6i1B7SIKxo2
 /HqQtq2q+k8BnSbtpw/1Waelt4NeaGrioxmpTlujR4E57d9lyyj5/JqeOS61RCOd5t3eax
 8lRwTpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=b4aTiViJEXmalCfxKWaxBCKTASeyCnEd0OTkGijMyMk=; h=date:subject:cc:to:
 from; d=korins.ky; b=82jY+TWqDQXnH8l3Lw47PHCQteEvx9b71JgTwRkjiMtz+Xe10
 JufTmP0ZtSeJnsfa157JNIfqiSA/dqozj6LDQ==
Received: by mx1.catap.net (OpenSMTPD) id 83f8a5be;
 Thu, 29 Oct 2026 18:41:48 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 680b71bf;
 Thu, 29 Oct 2026 18:41:47 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v5 05/26] target/mips: add Octeon CN73xx CPU model
Date: Thu, 29 Oct 2026 18:36:00 +0100
Message-ID: <20261029174139.44302-1-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, URIBL_SBL=1.623 autolearn=ham autolearn_force=no
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

This is rebased to 5624b266cdd513506fb333e9041778407b6d1ac4 and addressed
few remarks from Philippe Mathieu-Daudé.

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



