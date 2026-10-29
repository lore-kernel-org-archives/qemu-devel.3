Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5C9606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=KzKkRRA7;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=cRh958tj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMX0u-00086H-W7; Thu, 29 Oct 2026 16:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX0s-00085l-S4
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:19 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX0q-0007TA-Gq
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=GYie87Y
 qT0lyyrmUo6czoXJCkij+lgbH3pvdvAu7xIWk8St8KRtcFBp/mgzNuBFA42kBE2f1fh5y2
 DrYNtkp+EzIM8c91KYdoXmJ/OFKa/RZilyX61bOzB+2a3Yy3v8PA/UBa6V76vvurscFJWA
 1FKN38SRF5zuY+4A/TmIbICbOIQxSln1Q9bUc1f2Tmo8L1P1gyMDJyycwGPwRodOOj5DVn
 dzclcfRong0XLMSw+R+3XgRikk6k7a0LjUdXsbAj3JYwh9Ga5ubF7BauvwySF2t6cjcj0e
 xOR3ogls+DRGqQnC8C1Cxny+hso+xgxayt+izYNJ5RjnE1KB/ad22EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=A
 CWkMzVjFh5PYRF+DOBK8ObqW460uv353zsL/Vvj2PU=;
 h=date:subject:cc:to:
 from:dkim-signature:dkim-signature; d=mx.catap.net; b=UZHGY0EoqgUbFyqi
 6H0MhKW66bgsS5JoNYyDqAN2vo9ApakMwOePyVNo6gV3EdMZg/X+2jf26bC1Neglpl6x50
 qUgJtlPzINn3Qa2HxYO05JsudHry3YxBS0xRY8JjK9lcL3FqhYPKIcyJelo+4EuuwCGkVG
 ijlN4eHHRTm+ejRHBaFjRlCxsUfBy1Kb/K+ahmW9DOP1FiRmC7p1Blsqy8MPh06xv9MLCu
 7VtlfoYT7KbV5GE/ELWLP01apLyMmHKkLp94yoTgHGHvPfTKNsGBOQRCjpQpwgYcmGBJ/i
 bmxDihuApjA1tY06hVS3+esDlGuo4VKdb/dfMvGku0uA4Q==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=KzKkRRA7; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=cRh958tj;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=ACWkMzVj
 Fh5PYRF+DOBK8ObqW460uv353zsL/Vvj2PU=; h=date:subject:cc:to:from;
 d=korins.ky; b=KzKkRRA75xGrsFK6rEfoiuQqCX0rzK11CBzVHHJuTPUrz9xU9ltwMmR
 uWbgWF6Nawei0HoYGZNekr90nevd1myI4Aauknj+BhoJj1ut34Lpox6SoN9hG7jnPZEBSb
 iN6uioy+Xwmjc3Xx3NMfedpOwhiYjwYPJJZ5b4mH9EAAW+n1FxoKuZ+GIZ9zg+0B/dgyF1
 FZjsns2nygXrp+QKpV3Oxlm7TGePUr7xns/UDU7HCfxOm4rNAm3m6QMEEotyoCPp7uE55l
 sDMbRqy9NfxMkss1HxttgBx8Syx0UWiOJzYF6pbrQVjBfBEV1HNpF/CLVxVISO2t/uevjS
 Y/Ce0HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=ACWkMzVjFh5PYRF+DOBK8ObqW460uv353zsL/Vvj2PU=; h=date:subject:cc:to:
 from; d=korins.ky; b=cRh958tjzoXxL8bH8fE/sDi94Lx9BTQj8MuIylyaZrw9NoIfP
 nc0fW0PUQmf+TMtXRP9nFQP07c0D4l4QYSUBw==
Received: by mx1.catap.net (OpenSMTPD) id 8a6e0f54;
 Thu, 29 Oct 2026 21:46:13 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 8fc231ca;
 Thu, 29 Oct 2026 21:46:12 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v5 0/26] hw/mips: add Octeon III EBB7304 support
Date: Thu, 29 Oct 2026 21:43:45 +0100
Message-ID: <20261029204609.38989-1-kirill@korins.ky>
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
few remarks from Philippe Mathieu-Daudé which I resend the second time,
becaus ouriginal v5 sending was messed up by me and ignored by patchew.org
Sorry for the noise.

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


