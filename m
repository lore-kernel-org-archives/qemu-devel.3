Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B045606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=wQk6fElN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Ay-0006I2-MD; Mon, 16 Nov 2026 15:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Aw-0006Gw-FB; Mon, 16 Nov 2026 15:19:38 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3At-0003mT-DS; Mon, 16 Nov 2026 15:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860362; bh=yGA+DMTODqI5X/tdwxPCEhV4W8Mm12MSx9tCfp5JrHQ=;
 h=From:To:Cc:Subject:Date;
 b=wQk6fElNM0V72vZ7NtDfh1T+7gnjMkjHKfYeu9+9T85SrqWdRaV1+wnFyz4w7/5QG
 xx0YaOuBlsPTRKyBVW6oIhGTLXntMkaXPJUQI61j8y8MrQZ/cJ6Kvn+RF+y46Wbjts
 adPuaKxlTt3rNgDt33vIvy5LHPxGDkKltew0xbTIGKss5pnelU6AE/LW3dPepGAk33
 3FAjRM5XxFr24kKOSucl20QsLR0WNp/njY7kiBe8vh4aGuPSKRVJladpeI07FW0mzb
 LnKdOMbX3TaZk6n6+xBlR8nNCz4QPVjvj0Vi/0xiCJR1XExDDXy26K+nbiJ6vlASlr
 XI18n1NGJhsaA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CEDD11E7136;
 Mon, 16 Nov 2026 23:19:22 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C7B9645FB6C;
 Mon, 16 Nov 2026 23:19:22 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B6FD6B8DCE; Mon, 16 Nov 2026 23:19:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 00/59] Patch Round-up for stable 10.0.16,
 freeze on 2026-11-26
Date: Mon, 16 Nov 2026 23:18:04 +0300
Message-ID: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v10.0.16:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.0

Patch freeze is 2026-11-26, and the release is planned for 2026-11-28:

  https://wiki.qemu.org/Planning/10.0

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
07 0b76df366bfd Nikhil Kumar Singh:
   hw/pci-host/pnv_phb4: fix guest-triggerable abort on 8-byte config access
08 c278e6dc1abc Bernhard Beschow:
   hw/watchdog/wdt_imx2: Preserve own locked bits in WCR
09 328d4c566a03 Bernhard Beschow:
   hw/watchdog/wdt_imx2: Fix handling of write one once WCR bits
10 98d21eef2c38 Bernhard Beschow:
   hw/watchdog/wdt_imx2: Clear WDT lock on reset
11 b26d4302a897 Peter Maydell:
   hw/net/cadence_gem: Check guest-provided queue numbers in screening 
   registers
12 91a551871ff Junjie Cao:
   hw/cxl: free the CCI background timer on Type-3 reset and exit
13 4992210c8445 Daejun Park:
   hw/ufs: Fail SCSI commands that move data without a PRDT
14 ad2f77a00b4a Daejun Park:
   hw/ufs: Pass SYNCHRONIZE CACHE(16) to scsi-hd as SYNCHRONIZE CACHE(10)
15 f9e0f4d949a0 Daejun Park:
   hw/ufs: Check the PRDT size against the transfer length of the CDB
16 e0c80f0b9ca5 Keith Monahan:
   target/hppa: Use 32-bit load of PSW in rsm and ssm
17 2a2fc7ea6c72 Stefan Hajnoczi:
   qed: fix incorrect denominator in qed_bytes_to_clusters() 
   (CVE-2026-118594)
18 03efcb7cfdef Oleksij Samorukov:
   qga: set FreeBSD virtio-serial channel to raw mode
19 e91d320a5bbc Farhan Ali:
   s390x/pci: Free FMB timer on zPCI device unplug
20 b71287f00782 Farhan Ali:
   s390x/pci: Change reset method from legacy to resettable exit
21 c8b6ce2fa6d6 Peter Maydell:
   hw/dma/xlnx_dpdma: Don't allow DMA off end of host buffers
22 753e24f55f0f Peter Maydell:
   target/arm: For linux-user, prioritize PC misalignment fault over insn 
   abort
23 ab46596975c5 Junjie Cao:
   usb-host: reset the open retry count after a successful open
24 8b604732242e Junjie Cao:
   hw/usb/hcd-xhci: fail Address Device when the DCBAA entry is unreadable
25 213c716c5873 Junjie Cao:
   tests/qtest/usb-hcd-xhci: test Address Device with an unreadable DCBAA
26 9f94fd68c89b Paolo Bonzini:
   target/i386/tcg: reject VEX.NP for MMX instructions
27 41d5e37e0e20 Philippe Mathieu-Daudé:
   hw/virtio/vhost: Replace legacy cpu_physical_memory_*map() calls
28 558084367e90 Vladimir Sementsov-Ogievskiy:
   vhost: make vhost_memory_unmap() null-safe
29 c85f42703df6 Vladimir Sementsov-Ogievskiy:
   vhost: vhost_virtqueue_start(): fix failure path
30 060ef8cac115 Vladimir Sementsov-Ogievskiy:
   vhost: simplify calls to vhost_memory_unmap()
31 60abdf60d505 Vladimir Sementsov-Ogievskiy:
   vhost: move vrings mapping to the top of vhost_virtqueue_start()
32 4801e50cf1af Vladimir Sementsov-Ogievskiy:
   vhost: vhost_virtqueue_start(): drop extra local variables
33 4e61c89262aa Vladimir Sementsov-Ogievskiy:
   vhost: final refactoring of vhost vrings map/unmap
34 94c862925d3c Bibo Mao:
   target/loongarch: Fix memory access address with fldle
35 fa9e186ab673 Michael S. Tsirkin:
   virtio-net: validate IHL in virtio_net_rsc_extract_unit4 before use
36 7eacd04f49b9 Manos Pitsidianakis:
   target/arm/ptw: check XN for ARMv6 in get_S1prot()
37 e7666745773f Ferdinand Schober:
   arm/cpu: fix GIC v3 flag for a64fx
38 2527d738072b Manos Pitsidianakis:
   hw/intc/arm_gic: move num-priority-bits check
39 43523008040e Manos Pitsidianakis:
   hw/intc/arm_gic: do not hardcode GICv2 minimum binary point
40 47ecb8004103 Chris Copeland:
   target/arm: Clear the local monitor on AArch32 (v8) exception returns
41 bf67d56f282c Anton Johansson:
   target/riscv: Fix CPU state access on big-endian hosts
42 fdf80a4f5162 Peter Maydell:
   block/vmdk: Avoid assertion if image file has no extents
43 fe2cbdda07c2 Peter Maydell:
   block/vmdk: Avoid reading off the end of descriptor memory
44 53c06d5239b4 Peter Maydell:
   block/vmdk: Use larger types for byte counts in vmdk_read_extent()
45 09153b7e5f8f Peter Maydell:
   block/vmdk: Reject a zero cluster_sectors parameter
46 43d614ab3a2d Peter Maydell:
   block/vmdk: Avoid overflowing multiplication in vmdk_open_vmdk4()
47 be9bac072ede Andrey Drobyshev:
   iotests/common.rc: add disk_usage function
48 c49dda7254d4 Eric Blake:
   iotests: Filter out ZFS in several tests
49 26aae5102312 Andrey Drobyshev:
   iotests/290: add test case to check 'discard-no-unref' option behavior
50 3fe45543bf42 Andrey Drobyshev:
   qcow2: fix snapshot data corruption with discard-no-unref=on
51 8f23f50082b2 Andrey Drobyshev:
   iotests/290: add 'discard' and 'write -z -u' case with a snapshot
52 67198583a1ef Thomas Huth:
   block/vhdx: Prevent out-of-bounds BAT accesses with malicious vhdx files
53 74e68729ca8e Chinmay Rath:
   spapr-vscsi: clamp adapter info DMA write length to struct size
54 fd2cee4c2e64 Eric Blake:
   docs: Mention security considerations for NBD
55 9bc9e737a384 Eric Blake:
   iotests: Refactor python NBD server setup
56 3ec7bb19359c Eric Blake:
   nbd/server: Reject rather than assert on non-compliant BLOCK_STATUS
57 3e6759157ecb Eric Blake:
   iotests: Add new nbd-robustness test
58 325b8b75d508 Eric Blake:
   nbd/server: Reject rather than assert on non-compliant 
   NBD_OPT_SET_META_CONTEXT
59 e682c0e57017 Eric Blake:
   iotests: Add another nbd-robustness test

