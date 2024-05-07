Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DD1C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 08:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4GPJ-0003Nd-W1; Tue, 07 May 2024 04:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GPE-0003KP-Mt; Tue, 07 May 2024 04:42:36 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GP8-0003CX-Iv; Tue, 07 May 2024 04:42:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6B7AD64BC4;
 Tue,  7 May 2024 11:42:45 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 54D5AC85AD;
 Tue,  7 May 2024 11:42:26 +0300 (MSK)
Received: (nullmailer pid 1026502 invoked by uid 1000);
 Tue, 07 May 2024 08:42:26 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Michael Roth <michael.roth@amd.com>
Subject: [Stable-8.2.4 00/16] Patch Round-up for stable 8.2.4 (planned for
 2024-05-12)
Date: Tue,  7 May 2024 11:41:59 +0300
Message-Id: <qemu-stable-8.2.4-20240506205855@cover.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
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

The following patches are queued for QEMU stable v8.2.4:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-8.2

The release is planned for 2024-05-12, to address a few issues
encountered with v8.2.3 release, - a bit wrong tarball with some
replication hiccups in the CDN behind download.qemu.org, and a
build failure on riscv. The planning page:

  https://wiki.qemu.org/Planning/8.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 49c211ffca00 Daniel Henrique Barboza:
   target/riscv/kvm: change KVM_REG_RISCV_FP_F to u32
02 450bd6618fda Daniel Henrique Barboza:
   target/riscv/kvm: change KVM_REG_RISCV_FP_D to u64
03 10f86d1b8450 Daniel Henrique Barboza:
   target/riscv/kvm: change timer regs size to u64
04 2cc637f1ea08 Li Zhijian:
   migration/colo: Fix bdrv_graph_rdlock_main_loop: Assertion 
   `!qemu_in_coroutine()' failed.
05 04f6fb897a5a Michael Tokarev:
   linux-user: do_setsockopt: fix SOL_ALG.ALG_SET_KEY
06 ae6d91a7e9b7 Zhu Yangyang:
   nbd/server: do not poll within a coroutine context
07 4fa333e08dd9 Eric Blake:
   nbd/server: Mark negotiation functions as coroutine_fn
08 06479dbf3d7d Li Zhijian:
   backends/cryptodev-builtin: Fix local_error leaks
09 0cbb322f70e8 Michael Tokarev:
   target/loongarch/cpu.c: typo fix: expection
10 dcc5c018c7e6 Peter Maydell:
   tests/avocado: update sunxi kernel from armbian to 6.6.16
11 a88a04906b96 Thomas Huth:
   .gitlab-ci.d/cirrus.yml: Shorten the runtime of the macOS and FreeBSD jobs
12 f2c8aeb1afef Jeuk Kim:
   hw/ufs: Fix buffer overflow bug
13 4b00855f0ee2 Alexandra Diupina:
   hw/dmax/xlnx_dpdma: fix handling of address_extension descriptor fields
14 eb656a60fd93 Philippe Mathieu-Daudé:
   hw/arm/npcm7xx: Store derivative OTP fuse key in little endian
15 c365e6b07057 Philippe Mathieu-Daudé:
   target/sh4: Fix ADDV opcode
16 e88a856efd1d Philippe Mathieu-Daudé:
   target/sh4: Fix SUBV opcode

