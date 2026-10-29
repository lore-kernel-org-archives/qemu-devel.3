Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920FA606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 05:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=Leue3II0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMIYU-0002Ol-Ay; Thu, 29 Oct 2026 01:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xMIYS-0002Nd-HM; Thu, 29 Oct 2026 01:20:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xMIYO-0006cS-VK; Thu, 29 Oct 2026 01:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793251187; bh=SFcNEWIz8KI/37q1wegHIISNo7ICiREo50lWcLEEHXw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Leue3II0ozBErxIhtaMbur2xnlIzGVIMQYKi5XHMg8OLmY8NGYGOhilC/0COn1QP8
 lVwu9+IbEB5MnZaDKBylbTWkfURuMYCj9VCGmKXWDn4JX7NEsbwt3lygnyGRWncl0p
 CezqoP0sZll/aq+Q45ADIovzq7bXavBcUYpRXOkPI9kBy00Nazjz/Tv1sZVm3L3qiH
 vVN3+8NbYoLNiMmxY1nWpiwvFzii8XN/VNMivZz0UmxNold8eYrTh3rlRieNo4N7DF
 gTbJ8cIuTY1KW4HbgnXm0z/5tKwBjk+cDJuvLkho+1PgcexSX0+Mf2CuMleiMh1KeS
 8YI/M0O55Rgow==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 781221E219E;
 Thu, 29 Oct 2026 08:19:47 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 756E544DF23;
 Thu, 29 Oct 2026 08:19:47 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 70CD3A63E8; Thu, 29 Oct 2026 08:19:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-stable@nongnu.org
Subject: [ANNOUNCE] QEMU 11.1.3 Stable released
Date: Thu, 29 Oct 2026 08:19:22 +0300
Message-ID: <20261029051934.1487878-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029051934.1487878-1-mjt@tls.msk.ru>
References: <20261029051934.1487878-1-mjt@tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi everyone,

The QEMU v11.1.3 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-11.1.3.tar.xz
  https://download.qemu.org/qemu-11.1.3.tar.xz.sig (signature)

v11.1.3 is now tagged in the official qemu.git repository, and the
stable-11.1 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-11.1

There are 98 changes since the previous v11.1.2 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-11.1-hash master-hash Author Name: Commmit-Subject):

005c61c0ef6 Michael Tokarev:
 Update version for 11.1.3 release
8bee8b3dffa fe0f4a5a57 Philippe Mathieu-Daudé:
 target/ppc: Name the EBB exceptions
23b370b21cc ab6579bf73 Peter Maydell:
 hw/intc/exynos4210_combiner: Fix group register range check
b8eb59ff60a be67e61e29 Peter Maydell:
 hw/misc/bcm2835_cprman: Treat invalid clock mux source select as GND
d8cc56e9a28 cfa70f3a82 Thomas Huth:
 hw/usb/hcd-xhci: More reentrancy guard fixes for the XHCI code
6700316248a 6ab4cd2f13 Tommaso Califano:
 hw/usb/dev-mtp: Fix heap OOB read in usb_mtp_write_metadata()
1c3e688b183 1ccf17e9dc Tommaso Califano:
 hw/usb/dev-mtp: Fix assert crash on short CMD_SEND_OBJECT
2aba176fe2d a86338565c Haotian Jiang:
 usb-host: delete bottom halves during unrealize
dc73ad78128 59cb510910 Haotian Jiang:
 usb-host: free request on libusb submit failure
3f0eeebc803 432f505fa6 Junjie Cao:
 tests/qtest/usb-hcd-xhci: test interrupt pacing above 2^32
36f13dafeb2 322894eed3 Junjie Cao:
 usb-host: free configuration descriptors on error paths
a2a1a954907 e1b7f5e2a6 Junjie Cao:
 usb-host: validate interface number before indexing altsetting
9369434a30a 46dcc681ea Junjie Cao:
 tests/qtest: Cover OHCI endpoint type mismatches
e118248d9c9 9ad9a5a923 Peter Maydell:
 hw/usb/hcd-ohci: Fail iso packets sent to non-iso endpoints and vice-versa
483db5ddb1a b17205f23a Tommaso Califano:
 hw/usb/dev-mtp: Fix assert crash on undersized BULK IN
5a7758d6d2c e90644eea1 Martin Pitt:
 hw/uefi: fix ContentInfo detection in wrap_pkcs7()
31e4c99baf5 12df325604 Christian Schoenebeck:
 hw/9pfs: fix dirent stream protection for legacy (9p2000.u) Tread
2d494acdbb5 faa80b9847 Denis V. Lunev:
 iotests/migrate-bitmaps-postcopy-test: add a bitmap on a second node
62f725bd36d 4d11088a08 Denis V. Lunev:
 migration/block-dirty-bitmap: fix postcopy abort with bitmaps on several nodes
1b4a4019914 319cd41f11 Denis V. Lunev:
 migration: add QEMU_COUNTED_STRING_SIZE for counted string buffers
b66ab958d9c 901ac73874 Fiona Ebner:
 qemu-img: convert: flush target image after copying
630d9dc82d6 c6c8bdc21a Fiona Ebner:
 block: report flush error during bdrv_close()
34d8b6d8709 9d2cdc4d3b Fiona Ebner:
 iotests.py: add filter_qemu()
7819c7705c2 90b5f6ca17 Fiona Ebner:
 iotests: add test cases for failing flush after qemu-img convert
7450360e8cc a567ef8655 Daniel P. Berrangé:
 seccomp: really fix blocking of setns/execveat/unshare
8a9f2a0b584 f33fb19cab Daniel P. Berrangé:
 seccomp: fix blocking of setns/execveat/unshare
f207638c13d cb82463fa9 dodochicha:
 target/riscv: Check Svnapot PTE before updating A/D bits
37fe6b6ad95 71041ce05c Rick Richard:
 tests/qtest/bios-tables-test: Update riscv64 virt SPCR golden reference
278e3552ef5 ee23f530e9 Rick Richard:
 hw/riscv/virt-acpi-build: Fix the UART register width in SPCR
1af8e99822a ba280c3510 Rick Richard:
 tests/qtest/bios-tables-test: Allow changes to riscv64 virt SPCR
55dd6122c13 f20acdba2a Xie Bo:
 target/riscv/kvm: Preserve VCSR across migration
249e18c8752 0f9adcab46 Xie Bo:
 target/riscv/kvm: Reject migration with a different timer frequency
fb280414430 e52de6b65f Xie Bo:
 target/riscv/kvm: Preserve FCSR across migration
6b6a519e4d2 55a3524a89 Christian S. Lima:
 targetriscv: svinval instructions raise virtual instruction exception
963eb3cb855 410166b550 Zephyr Li:
 target/riscv: stop translating after WFI
75213859c7f 7f9ab1dc6c Mayuresh Chitale:
 target/riscv: Restore LCOFI handling in interrupt CSRs
ddf01610169 366b4fba0f imaginos:
 target/riscv: check G-stage write permission for VS-stage A/D updates
e89003d149e 37f2ab5593 Peter Maydell:
 hw/intc/arm_gicv5: Make IRS_IDR0 reads return actual value, not 0
d2dd4bce25f 2579771a28 Fuad Tabba:
 tests/tcg/aarch64: Test the TTBR layout with TCR.DS and a 48-bit OA
cfadd7fdf5a 2c37211946 Fuad Tabba:
 target/arm: Use the 52-bit TTBR base address layout when TCR.DS is set
31fbb602c54 bb79850255 Fuad Tabba:
 tests/tcg/aarch64: Add a test for a two-entry 52-bit TTBR table
3c4032504ff 0dedeff932 Fuad Tabba:
 target/arm: Clear TTBR[5:0] from a 52-bit table base address
b77e3908697 306d9ab85f Aurelien Jarno:
 tcg/riscv64: Remove vector min/max ops with immediates
dc0b14e4741 21b6c3e5bc Artemii Mashanov:
 target/i386: fix immediate stack adjustment for RET and RETF
621f9b0e991 0dd9fb43ea Artemii Mashanov:
 target/i386/tcg: zero FXSAVE FOP and reserved slot bytes
ae1a7e175be f9ca6b19ac Dominic P:
 tests/tcg: Add tests for sign extension after rotate
3edfef095ff d228536a51 Dominic P:
 tcg/optimize: Do not derive s_mask from rotated s_mask
64c20eeb996 35164929cf Marc-André Lureau:
 hw/display/vga: fix OOB writes after external surface resize
770b7d41839 9b206e5265 Stefan Berger:
 hw/tpm: crb: Do not clear internal buffers when backend is busy
04fb445f8e0 6728170d2d Stefan Berger:
 tpm_emulator: Reject sending commands smaller than the request header
8bd96336c66 99a8b5a0dd Daniel P. Berrangé:
 io: cork TLS writes to avoid small TLS records
c33ab7340ed cf4f672c11 Kevin Wolf:
 block: Remove now redundant bdrv_wait_serialising_requests() calls
7e6a8d069ff 0bd5a1b3d6 Kevin Wolf:
 block: Fix corruption from broken RMW atomicity
4675afbab68 efe98c2a09 Denis V. Lunev:
 block: reject a reopen of an unusable node instead of crashing
b2d517fd064 af28b65fae Denis V. Lunev:
 qcow2: do not clear the dirty bit when reopening a read-only node
4fac279346f 196a50b090 Stefan Hajnoczi:
 file-posix: add statx(STATX_DIOALIGN) support
ef1dbcfe6ea 8daaf8d3b1 Denis V. Lunev:
 block: fix bdrv_next() skipping monitor-owned nodes
318b3644736 2910b995f6 Denis V. Lunev:
 iotests: cover inactivating a read-only node
3247ea72389 429bf66a1f Denis V. Lunev:
 block/throttle-groups: fix crash when enabling I/O limits on a busy disk
68df2cefcfe 4668899d66 Daniel P. Berrangé:
 io: prevent unbounded read of websocket data from client
6b85309dde4 d198957674 Tommaso Califano:
 hw/usb: Fix USB MTP Use-After-Free in usb_mtp_deletefn List Iteration
b8d45ea45c1 a5b4837a25 Paolo Bonzini:
 target/i386/tcg: ignore VEX.L for unary scalar instructions
6cc067b1d97 12916d64b7 Maxim Levitsky:
 accel/kvm: coalesced mmio: check lenght of the MMIO write entry
fac3798546c 0f98b46846 Maxim Levitsky:
 accel/kvm: protect kvm_resample_fd_list with a mutex
3cbe6da76c5 b7f51182c0 Maxim Levitsky:
 system: fix buffer overflow in tdx_parse_panic_message
07a6c20669b 6d5fb14d36 Simon Scherer:
 target/i386: Don't clear C1 for FCOMI/FCOMIP/FUCOMI/FUCOMIP
cea26d6f834 6802a4b239 Simon Scherer:
 target/i386: clear C1 for all x87 compare instructions
8230b4093f0 fb024800d6 Yanfei Xu:
 target/i386: Migrate error code only with an exception
5af7f730e7f 8d496d8f9f Jakub Lipový:
 target/i386/tcg: raise #GP(0) on null SS load with RPL != CPL
53b291c4db2 46a8b8b378 y zhou:
 plugins: fix register handle encoding to reserve NULL as invalid
7c5695d0e80 6ee626e349 Daniel Paziyski:
 hw/nvme: fix memory leak on sr-iov capable nvme controller removal
7818b0d11fd 90fcba23c5 Daniel Paziyski:
 hw/nvme: fix assertion failure on sr-iov capable nvme controller removal
0024528af5a cd3be3bd96 Denis V. Lunev:
 block/nbd: clear reply.cookie under receive_mutex
ac398d68a2b 75b0a993da Denis V. Lunev:
 block/nbd: never index requests[] with an unchecked cookie
519986cdb5e 9998d225bb Denis V. Lunev:
 block/nbd: clear reply.cookie when the reply is rejected
dd4b12f00fe 7e429d3624 Andrey Drobyshev:
 hw/display/qxl: trace skipped stale loadvm commands
8c3e766357a 95bc45193b Andrey Drobyshev:
 hw/display/qxl: validate replayed commands in qxl_post_load
13ec3962425 050f5408bf Andrey Drobyshev:
 hw/display/qxl: factor out qxl_guest_phys2virt()
422e508cf9b f9f70b50e3 Fabiano Rosas:
 migration: Introduce VMStateStructMember
5f3dbb56bf3 3ece85b53c Marc-André Lureau:
 virtio-gpu: disable blob scanouts on mapping cleanup
58486a587f5 665494c3ac Marc-André Lureau:
 hw/usb/dev-smartcard-reader: validate migrated fields in post_load
bf66c153acb 069dcc103b Marc-André Lureau:
 hw/usb/dev-smartcard-reader: decode bulk-out length as little-endian
67cd05f4bb6 d7f20657e7 Marc-André Lureau:
 hw/usb/dev-smartcard-reader: fix assert on pending answers overflow
43a624d2753 49851e8595 Marc-André Lureau:
 hw/usb/dev-smartcard-reader: fix OOB read from pending bulk-in ring
4823a3093b3 1847dcd96d Marc-André Lureau:
 hw/usb/dev-smartcard-reader: validate interrupt transfer length
c9267a193b0 d818e2b0e6 Matthew Rosato:
 s390x/pci: Reject apertures beyond IOAT capacity in translation mode
eb77a720b2e 10a81449a2 Matthew Rosato:
 s390x/pci: Use qemu_log_mask() for guest-triggered errors in reg_ioat()
049f614dcb6 e57ad36701 Matthew Rosato:
 s390x/pci: Fix frame stepping in rpcit_service_call()
4f66512c345 119860f15c Eric Farman:
 s390x/sclp: Reject short headers in PV case
8c33176cf20 930a188edb Eric Farman:
 s390x/css: Use datastream pointer for checking no-data CCWs
c8766cac231 77cc481c23 Eric Farman:
 hw/intc/s390x: Fix check after g_try_realloc
ac7504ad5e4 057ca01937 Eric Farman:
 vfio/ap: Clear error object pointer after non-fatal errors
41d9159113c bd5bc2861f Eric Farman:
 virtio-ccw: Fix rc check in read configuration path
0cb9e2c7dd4 13c7ba5e0f Eric Farman:
 virtio-ccw: Do not overwrite existing indicators
163e73e175c 92b935de27 Eric Farman:
 virtio-ccw: Limit ISC to MAX_ISC
65edcf1172a 89e653b773 Thomas Huth:
 hw/usb/hcd-xhci: Limit DMA transfers to plain memory
54d855918e5 998b6db69e Fuad Tabba:
 target/arm: Fix WFxT timeouts when the offset puts the count ahead
6c3dceb7318 66d4ea65a0 Fuad Tabba:
 target/arm: Fix next timer tick when the offset puts the count ahead
6e974869877 653b0c06c8 Jean-Francois Bortolotti:
 target/arm: Fix PMSAv8 shareability decode for R-profile MPU regions


