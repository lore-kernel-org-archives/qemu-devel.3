Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F9FC25B7E
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 23:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN4C-00044L-Ed; Sun, 26 May 2024 19:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN4A-00042d-1w; Sun, 26 May 2024 19:14:14 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN47-0003Uu-Gn; Sun, 26 May 2024 19:14:13 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2EED44E6004;
 Mon, 27 May 2024 01:12:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 7upQJeal9L23; Mon, 27 May 2024 01:12:35 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 293EC4E6000; Mon, 27 May 2024 01:12:35 +0200 (CEST)
Message-Id: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 00/43] Remaining MMU clean up patches
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:12:35 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is the rest of the MMU clean up series the first part of which
was merged. Here are the remaining patches rebased and some more added.

Regards,
BALATON Zoltan

BALATON Zoltan (43):
  target/ppc: Reorganise and rename ppc_hash32_pp_prot()
  target/ppc/mmu_common.c: Remove local name for a constant
  target/ppc/mmu_common.c: Remove single use local variable
  target/ppc/mmu_common.c: Remove single use local variable
  target/ppc/mmu_common.c: Remove another single use local variable
  target/ppc/mmu_common.c: Remove yet another single use local variable
  target/ppc/mmu_common.c: Return directly in ppc6xx_tlb_pte_check()
  target/ppc/mmu_common.c: Simplify ppc6xx_tlb_pte_check()
  target/ppc/mmu_common.c: Remove unused field from mmu_ctx_t
  target/ppc/mmu_common.c: Remove hash field from mmu_ctx_t
  target/ppc/mmu_common.c: Remove pte_update_flags()
  target/ppc/mmu_common.c: Remove nx field from mmu_ctx_t
  target/ppc/mmu_common.c: Convert local variable to bool
  target/ppc/mmu_common.c: Remove single use local variable
  target/ppc/mmu_common.c: Simplify a switch statement
  target/ppc/mmu_common.c: Inline and remove ppc6xx_tlb_pte_check()
  target/ppc/mmu_common.c: Remove ptem field from mmu_ctx_t
  target/ppc: Add function to get protection key for hash32 MMU
  target/ppc/mmu-hash32.c: Inline and remove ppc_hash32_pte_prot()
  target/ppc/mmu_common.c: Init variable in function that relies on it
  target/ppc/mmu_common.c: Remove key field from mmu_ctx_t
  target/ppc/mmu_common.c: Stop using ctx in ppc6xx_tlb_check()
  target/ppc/mmu_common.c: Rename function parameter
  target/ppc/mmu_common.c: Use defines instead of numeric constants
  target/ppc: Remove bat_size_prot()
  target/ppc/mmu_common.c: Stop using ctx in get_bat_6xx_tlb()
  target/ppc/mmu_common.c: Remove mmu_ctx_t
  target/ppc/mmu-hash32.c: Inline and remove ppc_hash32_pte_raddr()
  target/ppc/mmu-hash32.c: Move get_pteg_offset32() to the header
  target/ppc: Unexport some functions from mmu-book3s-v3.h
  target/ppc/mmu-radix64: Remove externally unused parts from header
  target/ppc: Remove includes from mmu-book3s-v3.h
  target/ppc: Remove single use static inline function
  target/ppc/internal.h: Consolidate ifndef CONFIG_USER_ONLY blocks
  target/ppc/mmu-hash32.c: Change parameter type of
    ppc_hash32_bat_lookup()
  target/ppc/mmu-hash32: Remove some static inlines from header
  target/ppc/mmu-hash32.c: Return and use pte address instead of base +
    offset
  target/ppc/mmu-hash32.c: Use pte address as parameter instead of
    offset
  target/ppc: Change parameter type of some inline functions
  target/ppc: Change parameter type of ppc64_v3_radix()
  target/ppc: Change MMU xlate functions to take CPUState
  target/ppc/mmu-hash32.c: Change parameter type of ppc_hash32_set_[rc]
  target/ppc/mmu-hash32.c: Change parameter type of
    ppc_hash32_direct_store

 hw/ppc/spapr_rtas.c                 |   2 +-
 hw/ppc/spapr_vhyp_mmu.c             |  21 +-
 target/ppc/internal.h               |  34 +--
 target/ppc/mmu-book3s-v3.c          |   1 -
 target/ppc/mmu-book3s-v3.h          |  47 +---
 target/ppc/mmu-booke.c              |   5 +-
 target/ppc/mmu-booke.h              |   2 +-
 target/ppc/mmu-hash32.c             | 165 ++++--------
 target/ppc/mmu-hash32.h             |  86 +++---
 target/ppc/mmu-hash64.c             |  54 +++-
 target/ppc/mmu-hash64.h             |   3 +-
 target/ppc/mmu-radix64.c            |  57 +++-
 target/ppc/mmu-radix64.h            |  55 +---
 target/ppc/mmu_common.c             | 405 ++++++++++------------------
 target/ppc/mmu_helper.c             |   9 +-
 target/ppc/translate/vsx-impl.c.inc |   6 +-
 16 files changed, 376 insertions(+), 576 deletions(-)

-- 
2.30.9


