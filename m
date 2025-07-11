Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75028C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 20:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaKe5-0003Mn-Ez; Fri, 11 Jul 2025 16:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uaKdj-0003Hf-Mm; Fri, 11 Jul 2025 16:46:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uaKdh-0003g8-BT; Fri, 11 Jul 2025 16:46:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 25098135CFE;
 Fri, 11 Jul 2025 23:46:04 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 020F823FF39;
 Fri, 11 Jul 2025 23:46:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.19 00/15] Patch Round-up for stable 7.2.19,
 freeze on 2025-07-21
Date: Fri, 11 Jul 2025 23:46:15 +0300
Message-ID: <qemu-stable-7.2.19-20250711111933@cover.tls.msk.ru>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following patches are queued for QEMU stable v7.2.19:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2025-07-21, and the release is planned for 2025-07-23:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 fb8e59abbe46 Jamin Lin:
   hw/misc/aspeed_hace: Ensure HASH_IRQ is always set to prevent firmware 
   hang
02 a9403bfcd930 Huaitong Han:
   vhost: Don't set vring call if guest notifier is unused
03 5ddd6c8dc849 Volker Rümelin:
   audio: fix SIGSEGV in AUD_get_buffer_size_out()
04 eef2dd03f948 Fiona Ebner:
   hw/core/qdev-properties-system: Add missing return in set_drive_helper()
05 9c55c03c05c1 Bibo Mao:
   hw/loongarch/virt: Fix big endian support with MCFG table
06 f5ec751ee70d Shameer Kolothum:
   hw/arm/virt: Check bypass iommu is not set for iommu-map DT property
07 e372214e663a Ethan Chen:
   qemu-options.hx: Fix reversed description of icount sleep behavior
08 5ad2b1f443a9 J. Neuschäfer:
   linux-user/arm: Fix return value of SYS_cacheflush
09 0d0fc3f46589 Richard Henderson:
   tcg: Fix constant propagation in tcg_reg_alloc_dup
10 a412575837b6 Philippe Mathieu-Daudé:
   target/arm: Correct KVM & HVF dtb_compatible value
11 f9b0f6930407 Richard Henderson:
   target/arm: Fix SME vs AdvSIMD exception priority
12 b4b2e070f41d Richard Henderson:
   target/arm: Fix sve_access_check for SME
13 e6ffd009c771 Richard Henderson:
   target/arm: Fix 128-bit element ZIP, UZP, TRN
14 3801c5b75ffc Richard Henderson:
   target/arm: Fix PSEL size operands to tcg_gen_gvec_ands
15 cfc688c00ade Richard Henderson:
   target/arm: Fix f16_dotadd vs nan selection

