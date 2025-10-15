Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D4BCCD196
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 04:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8t56-0008W5-6r; Wed, 15 Oct 2025 00:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t52-0008VD-DZ; Wed, 15 Oct 2025 00:25:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t4y-0002fR-Lr; Wed, 15 Oct 2025 00:25:40 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ACF9215D9C5;
 Wed, 15 Oct 2025 07:24:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4FED829FE6E;
 Wed, 15 Oct 2025 07:25:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.2 00/11] Patch Round-up for stable 10.1.2,
 freeze on 2025-10-18
Date: Wed, 15 Oct 2025 07:25:04 +0300
Message-ID: <qemu-stable-10.1.2-20251014173635@cover.tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following patches are queued for QEMU stable v10.1.2:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.1

Patch freeze is 2025-10-18, and the release is planned for 2025-10-20:

  https://wiki.qemu.org/Planning/10.1

This release is supposed to go faster, because it contains two important
migration fixes.

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 2e54e5fda779 Damien Bergamini:
   pcie_sriov: Fix broken MMIO accesses from SR-IOV VFs
02 1c0f5142d921 ShengYi Hung:
   hid: fix incorrect return value for hid
03 f65918497cc6 nanliu:
   docs/devel: Correct uefi-vars-x64 device name
04 bab681f75204 Stefan Hajnoczi:
   pcie_sriov: make pcie_sriov_pf_exit() safe on non-SR-IOV devices
05 a23e719ca8e8 Peter Maydell:
   target/arm: Don't set HCR.RW for AArch32 only CPUs
06 c851052a77fd Jim Shu:
   target/riscv: Fix the mepc when sspopchk triggers the exception
07 84c1605b7606 Jim Shu:
   target/riscv: Fix SSP CSR error handling in VU/VS mode
08 0b16c7b6a854 Jim Shu:
   target/riscv: Fix ssamoswap error handling
09 81d1885dcc44 Max Chou:
   target/riscv: rvv: Fix vslide1[up|down].vx unexpected result when XLEN=32 
   and SEW=64
10 e9efa4a77168 Paolo Bonzini:
   target/i386: add compatibility property for arch_capabilities
11 6529f31e0dcc Hector Cao:
   target/i386: add compatibility property for pdcm feature

