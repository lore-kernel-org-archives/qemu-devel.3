Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E54A606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=HQqEC6DK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLCj-0008LH-Cx; Mon, 26 Oct 2026 09:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLCA-0007L6-19; Mon, 26 Oct 2026 09:57:03 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLC6-0000Iw-Ag; Mon, 26 Oct 2026 09:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022929; bh=UyRwEOxL71RoRyNiSOfknJ5D4A8VOH+IajxObnVRlLM=;
 h=From:To:Cc:Subject:Date;
 b=HQqEC6DKFR1qNBo5opI5aN4ewQXVv90FstItVS7Sm9tMM8G8HvSR3p1UBYbqulEY6
 jd3NhRYblN34IydADxCLNBqmv8NVh6w1BVbhhoJndYzS6v7S3CZg4D731lWB+q3Gml
 2GdA0b3G7gntgUx8QaXiipg/EmXVqNyczzbUY+OhqE8SYBKG22gVaEU5rZbasl9qgW
 uj1c2e1vx1Q/pGFiKeP5v+veSERd4wEzaw3VOPLt1MqBJvop+j5o7Z4DtUji5hwjOS
 xtbMf5pWuFWXwdQDVL433C/ycbNSaXD2ZiC61w+9GhB6Q+xdpAQT/rBB7pSMc62bra
 I3XoInWV3a/NQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7EC4A1E1294;
 Mon, 26 Oct 2026 16:55:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7BCD944B8E1;
 Mon, 26 Oct 2026 16:55:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 75BB6934B3; Mon, 26 Oct 2026 16:55:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 v2 00/98] Patch Round-up for stable 11.1.3,
 (frozen) freeze on 2026-10-26
Date: Mon, 26 Oct 2026 16:55:00 +0300
Message-ID: <qemu-stable-11.1.3-20261026165135@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v11.1.3:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-11.1

Patch freeze is 2026-10-26, and the release is planned for 2026-10-28:

  https://wiki.qemu.org/Planning/11.1

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 653b0c06c83d Jean-Francois Bortolotti:
   target/arm: Fix PMSAv8 shareability decode for R-profile MPU regions
02* 66d4ea65a064 Fuad Tabba:
   target/arm: Fix next timer tick when the offset puts the count ahead
03* 998b6db69e3e Fuad Tabba:
   target/arm: Fix WFxT timeouts when the offset puts the count ahead
04* 89e653b77369 Thomas Huth:
   hw/usb/hcd-xhci: Limit DMA transfers to plain memory
05* 92b935de2709 Eric Farman:
   virtio-ccw: Limit ISC to MAX_ISC
06* 13c7ba5e0f14 Eric Farman:
   virtio-ccw: Do not overwrite existing indicators
07* bd5bc2861fb6 Eric Farman:
   virtio-ccw: Fix rc check in read configuration path
08* 057ca01937b7 Eric Farman:
   vfio/ap: Clear error object pointer after non-fatal errors
09* 77cc481c2311 Eric Farman:
   hw/intc/s390x: Fix check after g_try_realloc
10* 930a188edbbc Eric Farman:
   s390x/css: Use datastream pointer for checking no-data CCWs
11* 119860f15cd2 Eric Farman:
   s390x/sclp: Reject short headers in PV case
12* e57ad3670188 Matthew Rosato:
   s390x/pci: Fix frame stepping in rpcit_service_call()
13* 10a81449a279 Matthew Rosato:
   s390x/pci: Use qemu_log_mask() for guest-triggered errors in reg_ioat()
14* d818e2b0e631 Matthew Rosato:
   s390x/pci: Reject apertures beyond IOAT capacity in translation mode
15* 1847dcd96d7d Marc-André Lureau:
   hw/usb/dev-smartcard-reader: validate interrupt transfer length
16* 49851e859506 Marc-André Lureau:
   hw/usb/dev-smartcard-reader: fix OOB read from pending bulk-in ring
17* d7f20657e756 Marc-André Lureau:
   hw/usb/dev-smartcard-reader: fix assert on pending answers overflow
18* 069dcc103be7 Marc-André Lureau:
   hw/usb/dev-smartcard-reader: decode bulk-out length as little-endian
19* 665494c3ac07 Marc-André Lureau:
   hw/usb/dev-smartcard-reader: validate migrated fields in post_load
20* 3ece85b53c12 Marc-André Lureau:
   virtio-gpu: disable blob scanouts on mapping cleanup
21* f9f70b50e3eb Fabiano Rosas:
   migration: Introduce VMStateStructMember
22* 050f5408bfcf Andrey Drobyshev:
   hw/display/qxl: factor out qxl_guest_phys2virt()
23* 95bc45193bbe Andrey Drobyshev:
   hw/display/qxl: validate replayed commands in qxl_post_load
24* 7e429d3624c4 Andrey Drobyshev:
   hw/display/qxl: trace skipped stale loadvm commands
25* 9998d225bb95 Denis V. Lunev:
   block/nbd: clear reply.cookie when the reply is rejected
26* 75b0a993dacb Denis V. Lunev:
   block/nbd: never index requests[] with an unchecked cookie
27* cd3be3bd96c0 Denis V. Lunev:
   block/nbd: clear reply.cookie under receive_mutex
28* 90fcba23c526 Daniel Paziyski:
   hw/nvme: fix assertion failure on sr-iov capable nvme controller removal
29* 6ee626e34979 Daniel Paziyski:
   hw/nvme: fix memory leak on sr-iov capable nvme controller removal
30* 46a8b8b37825 y zhou:
   plugins: fix register handle encoding to reserve NULL as invalid
31* 8d496d8f9fce Jakub Lipový:
   target/i386/tcg: raise #GP(0) on null SS load with RPL != CPL
32* fb024800d6dd Yanfei Xu:
   target/i386: Migrate error code only with an exception
33* 6802a4b23919 Simon Scherer:
   target/i386: clear C1 for all x87 compare instructions
34* 6d5fb14d36a6 Simon Scherer:
   target/i386: Don't clear C1 for FCOMI/FCOMIP/FUCOMI/FUCOMIP
35* b7f51182c081 Maxim Levitsky:
   system: fix buffer overflow in tdx_parse_panic_message
36* 0f98b46846eb Maxim Levitsky:
   accel/kvm: protect kvm_resample_fd_list with a mutex
37* 12916d64b78e Maxim Levitsky:
   accel/kvm: coalesced mmio: check lenght of the MMIO write entry
38* a5b4837a253e Paolo Bonzini:
   target/i386/tcg: ignore VEX.L for unary scalar instructions
39* d198957674b3 Tommaso Califano:
   hw/usb: Fix USB MTP Use-After-Free in usb_mtp_deletefn List Iteration
40* 4668899d6615 Daniel P. Berrangé:
   io: prevent unbounded read of websocket data from client
41* 429bf66a1f23 Denis V. Lunev:
   block/throttle-groups: fix crash when enabling I/O limits on a busy disk
42* 2910b995f6c8 Denis V. Lunev:
   iotests: cover inactivating a read-only node
43* 8daaf8d3b1c5 Denis V. Lunev:
   block: fix bdrv_next() skipping monitor-owned nodes
44* 196a50b0902b Stefan Hajnoczi:
   file-posix: add statx(STATX_DIOALIGN) support
45* af28b65fae6f Denis V. Lunev:
   qcow2: do not clear the dirty bit when reopening a read-only node
46* efe98c2a0932 Denis V. Lunev:
   block: reject a reopen of an unusable node instead of crashing
47* 0bd5a1b3d60c Kevin Wolf:
   block: Fix corruption from broken RMW atomicity
48* cf4f672c11d6 Kevin Wolf:
   block: Remove now redundant bdrv_wait_serialising_requests() calls
49* 99a8b5a0dda9 Daniel P. Berrangé:
   io: cork TLS writes to avoid small TLS records
50* 6728170d2d08 Stefan Berger:
   tpm_emulator: Reject sending commands smaller than the request header
51* 9b206e526550 Stefan Berger:
   hw/tpm: crb: Do not clear internal buffers when backend is busy
52* 35164929cfa3 Marc-André Lureau:
   hw/display/vga: fix OOB writes after external surface resize
53* d228536a5142 Dominic P:
   tcg/optimize: Do not derive s_mask from rotated s_mask
54* f9ca6b19acb1 Dominic P:
   tests/tcg: Add tests for sign extension after rotate
55* 0dd9fb43ea22 Artemii Mashanov:
   target/i386/tcg: zero FXSAVE FOP and reserved slot bytes
56* 21b6c3e5bccf Artemii Mashanov:
   target/i386: fix immediate stack adjustment for RET and RETF
57* 306d9ab85fdb Aurelien Jarno:
   tcg/riscv64: Remove vector min/max ops with immediates
58* 0dedeff9328d Fuad Tabba:
   target/arm: Clear TTBR[5:0] from a 52-bit table base address
59* bb79850255c8 Fuad Tabba:
   tests/tcg/aarch64: Add a test for a two-entry 52-bit TTBR table
60* 2c372119465e Fuad Tabba:
   target/arm: Use the 52-bit TTBR base address layout when TCR.DS is set
61* 2579771a28a2 Fuad Tabba:
   tests/tcg/aarch64: Test the TTBR layout with TCR.DS and a 48-bit OA
62* 37f2ab559305 Peter Maydell:
   hw/intc/arm_gicv5: Make IRS_IDR0 reads return actual value, not 0
63* 366b4fba0fae imaginos:
   target/riscv: check G-stage write permission for VS-stage A/D updates
64* 7f9ab1dc6c6e Mayuresh Chitale:
   target/riscv: Restore LCOFI handling in interrupt CSRs
65* 410166b550cc Zephyr Li:
   target/riscv: stop translating after WFI
66* 55a3524a8926 Christian S. Lima:
   targetriscv: svinval instructions raise virtual instruction exception
67* e52de6b65f5f Xie Bo:
   target/riscv/kvm: Preserve FCSR across migration
68* 0f9adcab46c0 Xie Bo:
   target/riscv/kvm: Reject migration with a different timer frequency
69* f20acdba2a96 Xie Bo:
   target/riscv/kvm: Preserve VCSR across migration
70* ba280c351011 Rick Richard:
   tests/qtest/bios-tables-test: Allow changes to riscv64 virt SPCR
71* ee23f530e99d Rick Richard:
   hw/riscv/virt-acpi-build: Fix the UART register width in SPCR
72* 71041ce05c95 Rick Richard:
   tests/qtest/bios-tables-test: Update riscv64 virt SPCR golden reference
73* cb82463fa9bf dodochicha:
   target/riscv: Check Svnapot PTE before updating A/D bits
74 f33fb19cab41 Daniel P. Berrangé:
   seccomp: fix blocking of setns/execveat/unshare
75 a567ef86557b Daniel P. Berrangé:
   seccomp: really fix blocking of setns/execveat/unshare
76 90b5f6ca171d Fiona Ebner:
   iotests: add test cases for failing flush after qemu-img convert
77 9d2cdc4d3b71 Fiona Ebner:
   iotests.py: add filter_qemu()
78 c6c8bdc21af3 Fiona Ebner:
   block: report flush error during bdrv_close()
79 901ac73874c2 Fiona Ebner:
   qemu-img: convert: flush target image after copying
80 319cd41f110a Denis V. Lunev:
   migration: add QEMU_COUNTED_STRING_SIZE for counted string buffers
81 4d11088a088d Denis V. Lunev:
   migration/block-dirty-bitmap: fix postcopy abort with bitmaps on several 
   nodes
82 faa80b9847b9 Denis V. Lunev:
   iotests/migrate-bitmaps-postcopy-test: add a bitmap on a second node
83 12df3256042c Christian Schoenebeck:
   hw/9pfs: fix dirent stream protection for legacy (9p2000.u) Tread
84 e90644eea1ce Martin Pitt:
   hw/uefi: fix ContentInfo detection in wrap_pkcs7()
85 b17205f23a9a Tommaso Califano:
   hw/usb/dev-mtp: Fix assert crash on undersized BULK IN
86 9ad9a5a92398 Peter Maydell:
   hw/usb/hcd-ohci: Fail iso packets sent to non-iso endpoints and vice-versa
87 46dcc681eac0 Junjie Cao:
   tests/qtest: Cover OHCI endpoint type mismatches
88 e1b7f5e2a671 Junjie Cao:
   usb-host: validate interface number before indexing altsetting
89 322894eed304 Junjie Cao:
   usb-host: free configuration descriptors on error paths
90 432f505fa65e Junjie Cao:
   tests/qtest/usb-hcd-xhci: test interrupt pacing above 2^32
91 59cb51091013 Haotian Jiang:
   usb-host: free request on libusb submit failure
92 a86338565cea Haotian Jiang:
   usb-host: delete bottom halves during unrealize
93 1ccf17e9dc6b Tommaso Califano:
   hw/usb/dev-mtp: Fix assert crash on short CMD_SEND_OBJECT
94 6ab4cd2f13de Tommaso Califano:
   hw/usb/dev-mtp: Fix heap OOB read in usb_mtp_write_metadata()
95 cfa70f3a82f5 Thomas Huth:
   hw/usb/hcd-xhci: More reentrancy guard fixes for the XHCI code
96 be67e61e29a8 Peter Maydell:
   hw/misc/bcm2835_cprman: Treat invalid clock mux source select as GND
97 ab6579bf73b5 Peter Maydell:
   hw/intc/exynos4210_combiner: Fix group register range check
98 fe0f4a5a5727 Philippe Mathieu-Daudé:
   target/ppc: Name the EBB exceptions

(commit(s) marked with * were in previous series and are not resent)

