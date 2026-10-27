Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80FA606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=aC1BocWZ;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=ZjZR7rdL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLefr-0005Ik-FK; Tue, 27 Oct 2026 06:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLefp-0005Hv-W0
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:44:58 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLefn-0007qu-Q2
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:44:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=sammT3q
 +eTgi8MGRtS1ia1ydCvM/cECCF4LQcWT/8OFiIyFDfJyJFAXsDef9xWp8BxVEwqwA7XPEq
 1xJApAj8l9wrxAfWxl3vdYwXd3Ui8MLA0VG8AlX+3xFnxCWSRGzQXuIzAUjixzK2AAfRPQ
 rQ9MW5baLKpxG/HfAZFwPW95/CnffSsp93dntvoNKNwSWp2FAmPstEFjmyYF2+uqOjwim5
 k8TXyZgClhq9j3hltZtTI1UrntnFswXTX/vbeJT2AsHxVhKblQjpMm0lBT9trQjBYmxHny
 GhYcnk893ae4Pfa6yxkq1t12qlzd1IeyWP9uf43dKcC/CGlxuniIC/w==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=c
 P8S0C+FJ6pqUKPBKhtcmHvbraVEENST2DoFUhFt+N4=;
 h=date:subject:cc:to:
 from:dkim-signature:dkim-signature; d=mx.catap.net; b=MVaf08rUDF4ev8SF
 xmAiVcNgP6z1k9tc91KFBJ0jrUtISBamD3Iter/AxFR+Ziswvo4wE+BC3Dd3gpDkd1gHfC
 qvPQU0+FPnJ/6fkCNocQMeihRpzCKg84Nl/4HHd+il8D6mA4Vacm//nS/sqXw0aL04cwz2
 qoXUfCUf9O2rPcb78LojsM0LoDLRaTo7v28o2lGSLvBK3Qsit0aPjdbV1QYyN4JkWdYQKF
 Hu/dZMPoWRSOdxTGJVxzRm/UdByI1tjWObLide1KLrEeY8Ag0+aODqWrPhgtyFxv1zSxmU
 n17cs2KaFsIDLkluXq1P8fEnCHmudxvEOMQZgkqZqhIa/g==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=aC1BocWZ; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=ZjZR7rdL;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=cP8S0C+F
 J6pqUKPBKhtcmHvbraVEENST2DoFUhFt+N4=; h=date:subject:cc:to:from;
 d=korins.ky; b=aC1BocWZ4sEWLcEYpAsHd4tdNfAPFF0LIxbq5uFFFs8MNZN3KWBedUq
 V70SHWO1wQhV6cSMSay+tHURqEv2AnfeSPaCS21cXJYXZ8C7omL1RMlBYAdTAzEg3zZFqU
 fatSaIBxRvtKGUpNEhi2qOBn4qxmZmOHJ0oiQ2lKwtux3BrKd19l9jNDHruxNeRcZmW++4
 O3UPartNiK+nLawlSGBlzRIVl8HT+IWoSyH4aOXFOJ71EukJyUDjBIz1146MKbf8fPiPX7
 Ym8/I+hyTUjRHNo5bM4B0EflUoRT5AUvYwOnG/1JenmB+gwgyifdV96tuLvHMAJ4CIHw7Y
 3tMugBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=cP8S0C+FJ6pqUKPBKhtcmHvbraVEENST2DoFUhFt+N4=; h=date:subject:cc:to:
 from; d=korins.ky; b=ZjZR7rdL9cI5NaAeKWAgsrmuQLbzDOl8q+mZ92tq0JkjcL4H3
 CWQPoDAWMDLkvEdourK/A4eXhJ3KfC6IscTAg==
Received: by mx2.catap.net (OpenSMTPD) id afbfe637;
 Tue, 27 Oct 2026 11:44:50 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 931d4340;
 Tue, 27 Oct 2026 11:44:48 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v4 0/25] hw/mips: add Octeon III EBB7304 support
Date: Tue, 27 Oct 2026 11:41:24 +0100
Message-ID: <20261027104433.25720-1-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
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

This is rebased to d73149283205645625bfa9fe029cfb68e4c4a9ae resend.

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
  6. target/mips: accept Octeon PageMask encodings
  7. target/mips: allow Octeon unaligned accesses
  8. hw/mips: add empty Octeon III machine
  9. hw/mips: add Octeon CPUs and boot memory
 10. hw/mips: add Octeon reset controller
 11. hw/mips: add Octeon CIU3 CPU control
 12. hw/mips: add Octeon CIU3 interrupt routing
 13. hw/mips: add Octeon legacy CIU
 14. hw/mips: add Octeon CSR window
 15. hw/mips: expose Octeon reset CSRs
 16. hw/mips: add Octeon MIO boot support
 17. hw/mips: wire the Octeon UART
 18. hw/i2c: add Octeon TWSI controller
 19. hw/mips: add Octeon EMM controller
 20. hw/mips: add Octeon LMC controllers
 21. hw/mips: add Octeon boot support registers
 22. hw/usb: add Octeon USB controller
 23. hw/pci-bridge: add Octeon PCI host bridge
 24. hw/pci-bridge: add Octeon PCI memory window
 25. tests/functional: test Octeon III boot



