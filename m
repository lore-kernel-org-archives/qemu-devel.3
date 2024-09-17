Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBE0CAC594
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 18:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqche-000406-8R; Tue, 17 Sep 2024 14:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sqchL-00038V-30; Tue, 17 Sep 2024 14:13:14 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sqchI-0002vP-Re; Tue, 17 Sep 2024 14:13:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9F58E8FBFD;
 Tue, 17 Sep 2024 21:12:50 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 50F7313E75D;
 Tue, 17 Sep 2024 21:13:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 v2 00/82] Patch Round-up for stable 9.0.3,
 freeze on 2024-09-16 (frozen)
Date: Tue, 17 Sep 2024 21:12:43 +0300
Message-Id: <20240917181256.634732-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following patches are queued for QEMU stable v9.0.3:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-9.0

Patch freeze is 2024-09-16 (frozen), and the release is planned for 2024-09-18:

  https://wiki.qemu.org/Planning/9.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* a4975023fb13 Fiona Ebner:
   hw/scsi/lsi53c895a: bump instruction limit in scripts processing to fix 
   regression
02* 57a8a80d1a5b Fiona Ebner:
   scsi: fix regression and honor bootindex again for legacy drives
03* 3becc9390810 Markus Armbruster:
   qapi/qom: Document feature unstable of @x-vfio-user-server
04* 5669d26ec614 Peter Maydell:
   target/arm: Fix handling of LDAPR/STLR with negative offset
05* 25489b521b61 Peter Maydell:
   target/arm: LDAPR should honour SCTLR_ELx.nAA
06* 31d93fedf41c Daniyal Khan:
   target/arm: Use float_status copy in sme_fmopa_s
07* 207d30b5fdb5 Richard Henderson:
   target/arm: Use FPST_F16 for SME FMOPA (widening)
08* 30a1690f2402 Akihiko Odaki:
   hvf: arm: Do not advance PC when raising an exception
09* c510fe78f1b7 Zheyu Ma:
   hw/nvme: fix memory leak in nvme_dsm
10* a207d5f87d66 Zhao Liu:
   hw/cxl/cxl-host: Fix segmentation fault when getting cxl-fmw property
11* 98e77e3dd8dd Manos Pitsidianakis:
   virtio-snd: add max size bounds check in input cb
12* 9b6083465fb8 Manos Pitsidianakis:
   virtio-snd: check for invalid param shift operands
13* a3c8d7e38550 Clément Mathieu--Drif:
   intel_iommu: fix FRCD construction macro
14* 13be929aff80 Paolo Bonzini:
   target/i386: do not crash if microvm guest uses SGX CPUID leaves
15* 903cc9e1173e songziming:
   chardev/char-win-stdio.c: restore old console mode
16* 2465c89fb983 Bibo Mao:
   hw/intc/loongson_ipi: Access memory in little endian
17* 0c2086bc7360 Philippe Mathieu-Daudé:
   hw/intc/loongson_ipi: Fix resource leak
18* a18ffbcf8b9f Song Gao:
   target/loongarch: Fix helper_lddir() a CID INTEGER_OVERFLOW issue
19* 851495571d14 Peter Maydell:
   util/async.c: Forbid negative min/max in 
   aio_context_set_thread_pool_params()
20* e0bf95443ee9 Sergey Dyasli:
   Revert "qemu-char: do not operate on sources from finalize callbacks"
21* d72479b11797 Thomas Huth:
   hw/virtio: Fix the de-initialization of vhost-user devices
22* 83340193b991 Richard Henderson:
   target/rx: Use target_ulong for address in LI
23* 546d574b11e0 Frederik van Hövell:
   hw/char/bcm2835_aux: Fix assert when receive FIFO fills up
24* 0892fffc2aba Peter Maydell:
   hw/misc/bcm2835_property: Fix handling of FRAMEBUFFER_SET_PALETTE
25* 56f1c0db928a Peter Maydell:
   target/arm: Don't assert for 128-bit tile accesses when SVL is 128
26* ea3f5a90f036 Peter Maydell:
   target/arm: Fix UMOPA/UMOPS of 16-bit values
27* 76916dfa89e8 Peter Maydell:
   target/arm: Avoid shifts by -1 in tszimm_shr() and tszimm_shl()
28* f573ac059ed0 Peter Maydell:
   target/arm: Ignore SMCR_EL2.LEN and SVCR_EL2.LEN if EL2 is not enabled
29* 48e5b5f994bc Peter Maydell:
   docs/sphinx/depfile.py: Handle env.doc2path() returning a Path not a str
30* 9a45b0761628 Peter Maydell:
   hw/i386/amd_iommu: Don't leak memory in amdvi_update_iotlb()
31* 5a558be93ad6 Marco Palumbi:
   hw/arm/mps2-tz.c: fix RX/TX interrupts order
32* 55f9f4ee018c Peter Maydell:
   target/arm: Handle denormals correctly for FMOPA (widening)
33* f1595ceb9aad Akihiko Odaki:
   virtio-net: Ensure queue index fits with RSS
34* f937309fbdbb thomas:
   virtio-net: Fix network stall at the host side waiting for kick
35* 64f75f57f9d2 David Woodhouse:
   net: Reinstate '-net nic, model=help' output as documented in man page
36* 0bd5b9284fa9 Fabiano Rosas:
   migration/multifd: Fix multifd_send_setup cleanup when channel creation 
   fails
37* 5b0c2742c839 Ilya Leoshkevich:
   linux-user/elfload: Fix pr_pid values in core files
38* ac63755b2001 Richard Henderson:
   target/i386: Fix VSIB decode
39* 682a05280504 Richard Henderson:
   tcg/ppc: Sync tcg_out_test and constraints
40* ed5a159c3de4 Philippe Mathieu-Daudé:
   hw/sd/sdhci: Reset @data_count index on invalid ADMA transfers
41* b881cf00c99e Amjad Alsharafi:
   vvfat: Fix bug in writing to middle of file
42* 21b25a0e466a Amjad Alsharafi:
   vvfat: Fix usage of `info.file.offset`
43* f60a6f7e17bf Amjad Alsharafi:
   vvfat: Fix wrong checks for cluster mappings invariant
44* 5eed3db33650 Amjad Alsharafi:
   vvfat: Fix reading files with non-continuous clusters
45* c8f60bfb4345 Amjad Alsharafi:
   iotests: Add `vvfat` tests
46* fb1c2aaa981e Eric Blake:
   nbd/server: Plumb in new args to nbd_client_add()
47* c8a76dbd90c2 Eric Blake:
   nbd/server: CVE-2024-7409: Cap default max-connections to 100
48* b9b72cb3ce15 Eric Blake:
   nbd/server: CVE-2024-7409: Drop non-negotiating clients
49* 3e7ef738c846 Eric Blake:
   nbd/server: CVE-2024-7409: Close stray clients at server-stop
50* 3874f5f73c44 Eric Blake:
   nbd/server: CVE-2024-7409: Avoid use-after-free when closing server
51* fa62cb989a91 David Woodhouse:
   net: Fix '-net nic,model=' for non-help arguments
52* 446e5e8b4515 Jianzhou Yue:
   hw/core/ptimer: fix timer zero period condition for freq > 1GHz
53* 547c4e50929e Stefano Garzarella:
   block/blkio: use FUA flag on write zeroes only if supported
54* 416f2b16c02c Richard Henderson:
   target/i386: Do not apply REX to MMX operands
55* 8e0c9a9efa21 Richard Henderson:
   target/arm: Clear high SVE elements in handle_vec_simd_wshli
56* 150c24f34e9c Peter Maydell:
   target/arm: Update translation regime comment for new features
57* 4c2c04746932 Peter Maydell:
   target/arm: Fix usage of MMU indexes when EL3 is AArch32
58* 940d802b24e6 Alexander Ivanov:
   module: Prevent crash by resetting local_err in module_load_qom_all()
59* fe68cc0923eb Alyssa Ross:
   target/hexagon: don't look for static glib
60* 3aefee3ec01e Richard Henderson:
   linux-user: Preserve NULL hit in target_mmap subroutines
61* 12d36294a2d9 Richard Henderson:
   target/sparc: Restrict STQF to sparcv9
62* 87e012f29f2e Peter Maydell:
   crypto/tlscredspsk: Free username on finalize
63* 6a22121c4f25 Klaus Jensen:
   hw/nvme: fix leak of uninitialized memory in io_mgmt_recv
64* a8e63ff289d1 Cindy Lu:
   virtio-pci: Fix the use of an uninitialized irqfd
65* 4c107870e8b2 Peter Maydell:
   migration/multifd: Free MultiFDRecvParams::data
66* a4ad4a9d98f7 Richard Henderson:
   linux-user: Handle short reads in mmap_h_gt_g
67* 94962ff00d09 Nicholas Piggin:
   Revert "replay: stop us hanging in rr_wait_io_event"
68* 7d14471a1218 Volker Rümelin:
   hw/audio/virtio-snd: fix invalid param check
69* ead5078cf1a5 Helge Deller:
   target/hppa: Fix PSW V-bit packaging in cpu_hppa_get for hppa64
70 108d99742af1 Alex Bennée:
   gitlab: migrate the s390x custom machine to 22.04
71 203beb6f0474 Arman Nabiev:
   target/ppc: Fix migration of CPUs with TLB_EMB TLB type
72 b84f06c2bee7 David Hildenbrand:
   softmmu/physmem: fix memory leak in dirty_memory_extend()
73 c72cab5ad9f8 Tiago Pasqualini:
   crypto: run qcrypto_pbkdf2_count_iters in a new thread
74 e6c09ea4f9e5 Daniel P. Berrangé:
   crypto: check gnutls & gcrypt support the requested pbkdf hash
75 586ac2c67d70 Daniel P. Berrangé:
   crypto: avoid leak of ctx when bad cipher mode is given
76 d6192f3f7593 Haoran Zhang:
   hw/display/vhost-user-gpu.c: fix vhost_user_gpu_chr_read()
77 d0068b746a0a Alex Bennée:
   tests/docker: remove debian-armel-cross
78 19d2111059c8 Alex Bennée:
   tests/docker: update debian i686 and mipsel images to bookworm
79 7fc6611cad3e Volker Rümelin:
   hw/audio/virtio-sound: fix heap buffer overflow
80 110684c9a69a Jan Klötzke:
   hw/intc/arm_gic: fix spurious level triggered interrupts
81 ae23cd00170b Gert Wollny:
   ui/sdl2: set swap interval explicitly when OpenGL is enabled
82 8d5ab746b1e6 Daniel P. Berrangé:
   gitlab: fix logic for changing docker tag on stable branches

(commit(s) marked with * were in previous series and are not resent)

