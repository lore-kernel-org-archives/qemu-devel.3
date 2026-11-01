Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84898606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=Ia1+AX9y;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=U6yQmpxW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNWXG-0006bX-3A; Sun, 01 Nov 2026 09:27:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWX4-0006a2-I6
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:39 -0500
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWX1-00083i-TS
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=WhinARh
 4lgUCbofna6/7EKsK6xFQHN+ql6hX/ty4p1jtNza/HAS+YgkepUD/R0nYWOvn+DPn0HdH+
 cluDgvYT14wf6JmdCnBqTcGe7p/wFwoRCmGoq3TDmlAGwMHeQ8LdDpqO2Fa//jXrFQFTUl
 19uIA0PtqH+iXeb47/Dl0DzakvkQ761eqLotT9vb8ao/eQSm6e4jRiFifq+E+LZ9JkYO+X
 ns/+TFnupVHkswM+M1Ca9pYm+kmduM4bJ4eEtod2Q816qPqmHCqgdknDhs9LYna7K4g1Ww
 BMAeJqnl0X+MysCCghhIa1rVAhgkd8L+9XgCl4L1BJitX8WdF+g+DEw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=U
 eohqH/HZAkK67NlrgJJc/mAlL8HrowqiAn3cCjq8DE=;
 h=date:subject:cc:to:
 from:dkim-signature:dkim-signature; d=mx.catap.net; b=oNK99hjz9KWK3xxY
 qa1EyyH66lmrv5CjZFtbZbC9NYCeFzbT4+TUZQ/JBOwe2GyEfTP2jn4ITuRe1sFarVatQQ
 N/to/GbXZkF5FXHdAKq7A6LrfZebPyii064hg82VzmPzQpkr0lg1xr7qf+mPMCDGQv+neg
 WPKMO6pYZYajF+6eyR2bHTS4bOGjs6Lbo75YVAocHzYeeGXz9CuBr1mecmuuj4B8RlDN8M
 /9RdojlEJ/1ziPuLSREL/FQvtpU653ge75TGYmDC6jX0tjzN4UWxRNgMKpIFXGEs+yLmPL
 gWROQFX8HBn2OjbOcNd2IzcLxFK6nXg11R/WnFsheXLcUA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=Ia1+AX9y; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=U6yQmpxW;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=UeohqH/H
 ZAkK67NlrgJJc/mAlL8HrowqiAn3cCjq8DE=; h=date:subject:cc:to:from;
 d=korins.ky; b=Ia1+AX9yqZUE37HJYPPpO6rgMUn0aAGF3k8vJbIO/3EfU+tD5xD5z6/
 DxBgd8z+Ik5aviMq1SUhrsfb0UnDj3zGLP/V/4BvJyWfqLoZGVA7l1eHd3c3AsLyr8zqh9
 /rNBp8px17zM0hVLv8tlObkuLh2oSn6yiQEQDQscA9fI5f8QGpTSTVEP9DXhV02ybpDt1Z
 ABPrk4XRd8kXE3pzGIRBwhE8iCAMSSpDHuo7TpuzPJY1gBEYhL1OZVeV2HSfyuVdfX6rwu
 7xlWYsbY7BExUBdk47wdU7U53VPxljCD/4uMNmcx9L520+xnQ3mOolsp+EeIhGIVCx0+zi
 nWdgR1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=UeohqH/HZAkK67NlrgJJc/mAlL8HrowqiAn3cCjq8DE=; h=date:subject:cc:to:
 from; d=korins.ky; b=U6yQmpxWwTdu6BKgogBHi64VoGNp7k8RLUMy2TctMccejfQKs
 JjVgSVvxG3QzglRLS5YLqBD46LsYUmOTogHBw==
Received: by mx1.catap.net (OpenSMTPD) id 39e433b3;
 Sun, 1 Nov 2026 15:27:32 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id a3d00f22;
 Sun, 1 Nov 2026 15:27:30 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v6 0/26] hw/mips: add Octeon III EBB7304 support
Date: Sun,  1 Nov 2026 15:23:16 +0100
Message-ID: <20261101142723.41346-1-kirill@korins.ky>
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

I had given temporary access to Ubiquiti USG-XG-8 which allows me to run
a probe to model its CPU, I also had rebased the series to
33eb51c859834f2024090bf843c69814267b6c26

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



