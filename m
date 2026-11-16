Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10646606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=GGzfPD/J
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3H7-000320-Kj; Mon, 16 Nov 2026 15:26:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3H5-0002oe-7q; Mon, 16 Nov 2026 15:25:59 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3H2-0005cw-55; Mon, 16 Nov 2026 15:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860754; bh=9lq7NPMay/nAyGmjNd3S8CXazhW29lFBmfQ5vWfDvi8=;
 h=From:To:Cc:Subject:Date;
 b=GGzfPD/Juuhdhj8buMK2Lg/5/bntKggnEui8APs2qyGrigrbhoROGS8fAAq2rWNN1
 qcMoZ6OXAa2iZZmWRuedvyga+Lf0kFuULFColotOm5qPysA97UxYv1lgyWmgjSHu7h
 cHZZXnXLfnMSEGPaGBdW6BpQX1GxEYB/7hT7b/QBYCwvO4FlF+jOwEF3fTfaOyrZki
 2O8ZCMRfyA6W27Wz74XEJ0ayvOk7VK54v5alo/xzYYY2jA9F42FvxLo8/l1FAxIwDL
 Hy6mJCk2geiTsBo5mwpTRonuYGrWaWf6tn1lWe9wWlaxXNWA3aQd0vNrGjyvk9/r/u
 U8HSyaxQeqwrQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4F2601E7195;
 Mon, 16 Nov 2026 23:25:54 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4636E45FBC1;
 Mon, 16 Nov 2026 23:25:54 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 39CD2B8E46; Mon, 16 Nov 2026 23:25:54 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 00/63] Patch Round-up for stable 11.1.4,
 freeze on 2026-11-26
Date: Mon, 16 Nov 2026 23:24:39 +0300
Message-ID: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following patches are queued for QEMU stable v11.1.4:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-11.1

Patch freeze is 2026-11-26, and the release is planned for 2026-11-28:

  https://wiki.qemu.org/Planning/11.1

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 349a5fa831b7 Collin Walling:
   target/s390x: externalize feat dependency array
02 5aff5b12b713 Collin Walling:
   target/s390x: mark feats dependent on deprecated feats as deprecated
03 c341f8ce205f Peter Maydell:
   linux-user/loongarch64: In extframe_alloc, align before subtracting 
   sctx_info size
04 24f4453789bd Omar Elghoul:
   s390x/pci: reclaim DMA slots upon IOMMU disable
05 2b1b98f00332 Peter Maydell:
   linux-user: Use QemuSemaphore to wait for clone child thread
06 9c20897e50f4 Tan Chi:
   hw/riscv/riscv-iommu: fix entry leak with ioatc-limit=0
07 9164d533ecae Harshit Mukhedkar:
   target/riscv: fix uninitialised upper half in pmu_timer_trigger_irq()
08 0b76df366bfd Nikhil Kumar Singh:
   hw/pci-host/pnv_phb4: fix guest-triggerable abort on 8-byte config access
09 b5424abaf8e9 Bin Meng:
   hw/sd/sdcard: Keep high-capacity memory blocks at 512 bytes
10 c278e6dc1abc Bernhard Beschow:
   hw/watchdog/wdt_imx2: Preserve own locked bits in WCR
11 328d4c566a03 Bernhard Beschow:
   hw/watchdog/wdt_imx2: Fix handling of write one once WCR bits
12 98d21eef2c38 Bernhard Beschow:
   hw/watchdog/wdt_imx2: Clear WDT lock on reset
13 c814f8c9f8e7 Bernhard Beschow:
   hw/arm/imx8mm-evk: Fix reference count of SoC object
14 8cc795376e95 Jamin Lin:
   hw/pci-host/aspeed_pcie: Fix global MSI setting during class 
   initialization
15 d60f2b934245 Peter Maydell:
   hw/net/can/flexcan: Fix FLEXCAN_CRCR_MBCRC definition
16 b26d4302a897 Peter Maydell:
   hw/net/cadence_gem: Check guest-provided queue numbers in screening 
   registers
17 e8953bf0be6f Marc-André Lureau:
   qga/vss: fix provider handling of snapshots
18 a004df0be51f Junjie Cao:
   hw/cxl: destroy primary CCI before re-initialization on reset
19 4992210c8445 Daejun Park:
   hw/ufs: Fail SCSI commands that move data without a PRDT
20 ad2f77a00b4a Daejun Park:
   hw/ufs: Pass SYNCHRONIZE CACHE(16) to scsi-hd as SYNCHRONIZE CACHE(10)
21 f9e0f4d949a0 Daejun Park:
   hw/ufs: Check the PRDT size against the transfer length of the CDB
22 e0c80f0b9ca5 Keith Monahan:
   target/hppa: Use 32-bit load of PSW in rsm and ssm
23 3992091713eb Stian Halseth:
   accel/tcg: Do not flush and retry in place in tb_gen_code
24 2a2fc7ea6c72 Stefan Hajnoczi:
   qed: fix incorrect denominator in qed_bytes_to_clusters() 
   (CVE-2026-118594)
25 03efcb7cfdef Oleksij Samorukov:
   qga: set FreeBSD virtio-serial channel to raw mode
26 e91d320a5bbc Farhan Ali:
   s390x/pci: Free FMB timer on zPCI device unplug
27 b71287f00782 Farhan Ali:
   s390x/pci: Change reset method from legacy to resettable exit
28 c8b6ce2fa6d6 Peter Maydell:
   hw/dma/xlnx_dpdma: Don't allow DMA off end of host buffers
29 753e24f55f0f Peter Maydell:
   target/arm: For linux-user, prioritize PC misalignment fault over insn abort
30 8def1f30d5d4 Alex Bennée:
   target/arm: hold bql when SEV sets the event_register
31 ab46596975c5 Junjie Cao:
   usb-host: reset the open retry count after a successful open
32 8b604732242e Junjie Cao:
   hw/usb/hcd-xhci: fail Address Device when the DCBAA entry is unreadable
33 213c716c5873 Junjie Cao:
   tests/qtest/usb-hcd-xhci: test Address Device with an unreadable DCBAA
34 432ea8cc7d27 Daniel Paziyski:
   pcie_sriov: register user created virtual function before realizing it
35 7ecad9ed2e1c Daniel Paziyski:
   pci: fix null pointer dereference on pci device registration failure
36 36bc5a879e0f Daniel Paziyski:
   pcie_sriov: perform additional checks after pci device realization
37 e1b6779cd4c2 Daniel Paziyski:
   pcie_sriov: fix null pointer dereference when initializing PFs in a 
   system with user and device created VFs
38 9f94fd68c89b Paolo Bonzini:
   target/i386/tcg: reject VEX.NP for MMX instructions
39 94c862925d3c Bibo Mao:
   target/loongarch: Fix memory access address with fldle
40 07a4c09e4c1c Bibo Mao:
   target/loongarch: Clear PAGE_READ when PTE.NR is set
41 fa9e186ab673 Michael S. Tsirkin:
   virtio-net: validate IHL in virtio_net_rsc_extract_unit4 before use
42 7eacd04f49b9 Manos Pitsidianakis:
   target/arm/ptw: check XN for ARMv6 in get_S1prot()
43 e7666745773f Ferdinand Schober:
   arm/cpu: fix GIC v3 flag for a64fx
44 2527d738072b Manos Pitsidianakis:
   hw/intc/arm_gic: move num-priority-bits check
45 43523008040e Manos Pitsidianakis:
   hw/intc/arm_gic: do not hardcode GICv2 minimum binary point
46 47ecb8004103 Chris Copeland:
   target/arm: Clear the local monitor on AArch32 (v8) exception returns
47 bf67d56f282c Anton Johansson:
   target/riscv: Fix CPU state access on big-endian hosts
48 fdf80a4f5162 Peter Maydell:
   block/vmdk: Avoid assertion if image file has no extents
49 fe2cbdda07c2 Peter Maydell:
   block/vmdk: Avoid reading off the end of descriptor memory
50 53c06d5239b4 Peter Maydell:
   block/vmdk: Use larger types for byte counts in vmdk_read_extent()
51 09153b7e5f8f Peter Maydell:
   block/vmdk: Reject a zero cluster_sectors parameter
52 43d614ab3a2d Peter Maydell:
   block/vmdk: Avoid overflowing multiplication in vmdk_open_vmdk4()
53 26aae5102312 Andrey Drobyshev:
   iotests/290: add test case to check 'discard-no-unref' option behavior
54 3fe45543bf42 Andrey Drobyshev:
   qcow2: fix snapshot data corruption with discard-no-unref=on
55 8f23f50082b2 Andrey Drobyshev:
   iotests/290: add 'discard' and 'write -z -u' case with a snapshot
56 67198583a1ef Thomas Huth:
   block/vhdx: Prevent out-of-bounds BAT accesses with malicious vhdx files
57 74e68729ca8e Chinmay Rath:
   spapr-vscsi: clamp adapter info DMA write length to struct size
58 fd2cee4c2e64 Eric Blake:
   docs: Mention security considerations for NBD
59 9bc9e737a384 Eric Blake:
   iotests: Refactor python NBD server setup
60 3ec7bb19359c Eric Blake:
   nbd/server: Reject rather than assert on non-compliant BLOCK_STATUS
61 3e6759157ecb Eric Blake:
   iotests: Add new nbd-robustness test
62 325b8b75d508 Eric Blake:
   nbd/server: Reject rather than assert on non-compliant 
   NBD_OPT_SET_META_CONTEXT
63 e682c0e57017 Eric Blake:
   iotests: Add another nbd-robustness test

