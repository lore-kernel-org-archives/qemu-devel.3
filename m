Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B53CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yvq-0002UO-PJ; Wed, 01 Oct 2025 11:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v3yvp-0002T0-2A; Wed, 01 Oct 2025 11:39:53 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v3yva-0007Ck-IJ; Wed, 01 Oct 2025 11:39:49 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4009F56F320;
 Wed, 01 Oct 2025 17:39:07 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 9ZthWBj0VZB0; Wed,  1 Oct 2025 17:39:05 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2D7FD56F30C; Wed, 01 Oct 2025 17:39:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2810256F298;
 Wed, 01 Oct 2025 17:39:05 +0200 (CEST)
Date: Wed, 1 Oct 2025 17:39:05 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 00/22] hw/core/cpu: Remove @CPUState::as field
In-Reply-To: <20251001150529.14122-1-philmd@linaro.org>
Message-ID: <be95d6c7-2d1e-98cb-8235-9a1aac05fb50@eik.bme.hu>
References: <20251001150529.14122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1200896199-1759333145=:37311"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1200896199-1759333145=:37311
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 1 Oct 2025, Philippe Mathieu-Daudé wrote:
> Instead of using the convenient @CPUState::as shortcut, use

I'm not sure convenient in English means what you meant here at least it's 
not clear to me what you mean. Does this make it more inconvenient? Maybe 
you need a different word here.

> cpu_get_address_space(asidx=0) to get the vCPU first address

Could you move cpu_get_address_space() to the header and make it inline? I 
know you had another series to reduce inline functions but this is just 
one line and won't be inlined by the compiler unless it's defined in the 
header. I don't know if this is relevant but it keeps closer to the 
current behaviour.

Regards,
BALATON Zoltan

> space.
>
> The goal is to reduce the risk of AS mis-use for targets
> that uses multiple ASes per vCPU.
>
> Based-on: <20251001082127.65741-1-philmd@linaro.org>
>
> Philippe Mathieu-Daudé (22):
>  system/qtest: Use &address_space_memory for first vCPU address space
>  disas/disas-mon: Get cpu first addr space with cpu_get_address_space()
>  monitor/hmp-cmds: Get cpu first addr space with
>    cpu_get_address_space()
>  hw/core/loader: Get cpu first addr space with cpu_get_address_space()
>  hw/ppc: Get cpu first addr space with cpu_get_address_space()
>  hw/m86k: Get cpu first addr space with cpu_get_address_space()
>  target/xtensa: Get cpu first addr space with cpu_get_address_space()
>  target/riscv: Get cpu first addr space with cpu_get_address_space()
>  semihosting: Get cpu first addr space with cpu_get_address_space()
>  target/alpha: Get cpu first addr space with cpu_get_address_space()
>  target/arm: Get cpu first addr space with cpu_get_address_space()
>  target/hppa: Get cpu first addr space with cpu_get_address_space()
>  target/i386: Get cpu first addr space with cpu_get_address_space()
>  target/loongarch: Get cpu first addr space with
>    cpu_get_address_space()
>  target/m68k: Get cpu first addr space with cpu_get_address_space()
>  target/microblaze: Get cpu first addr space with
>    cpu_get_address_space()
>  target/ppc: Get cpu first addr space with cpu_get_address_space()
>  target/s390x: Get cpu first addr space with cpu_get_address_space()
>  target/sparc: Get cpu first addr space with cpu_get_address_space()
>  hw/core/cpu: Remove @CPUState::as field
>  exec/cpu: Declare cpu_memory_rw_debug() in 'hw/core/cpu.h' and
>    document
>  target/sparc: Reduce inclusions of 'exec/cpu-common.h'
>
> include/exec/cpu-common.h         |  4 ---
> include/hw/core/cpu.h             | 23 +++++++++++--
> target/ppc/mmu-hash32.h           | 12 ++++---
> target/sparc/cpu.h                |  1 -
> disas/disas-mon.c                 |  3 +-
> hw/core/cpu-common.c              |  1 -
> hw/core/generic-loader.c          |  5 +--
> hw/intc/spapr_xive.c              |  5 +--
> hw/m68k/mcf5208.c                 |  6 ++--
> hw/m68k/q800.c                    | 17 ++++++----
> hw/m68k/virt.c                    |  5 +--
> hw/ppc/pegasos2.c                 |  2 +-
> hw/ppc/spapr.c                    | 12 +++----
> hw/ppc/spapr_hcall.c              | 55 ++++++++++++++++---------------
> hw/ppc/spapr_iommu.c              |  4 +--
> hw/ppc/spapr_nested.c             | 43 +++++++++++++-----------
> monitor/hmp-cmds-target.c         |  3 +-
> semihosting/arm-compat-semi.c     |  4 ++-
> system/cpus.c                     |  2 +-
> system/physmem.c                  | 10 ------
> system/qtest.c                    | 27 +++++++--------
> target/alpha/helper.c             |  8 +++--
> target/arm/cpu.c                  |  7 ++--
> target/hppa/int_helper.c          |  3 +-
> target/i386/arch_memory_mapping.c | 10 +++---
> target/loongarch/cpu_helper.c     |  5 +--
> target/loongarch/tcg/tlb_helper.c |  7 ++--
> target/m68k/helper.c              | 28 ++++++++--------
> target/microblaze/op_helper.c     |  6 ++--
> target/ppc/excp_helper.c          |  4 +--
> target/ppc/mmu-book3s-v3.c        |  5 +--
> target/ppc/mmu-hash32.c           |  6 ++--
> target/ppc/mmu-hash64.c           | 12 ++++---
> target/ppc/mmu-radix64.c          | 13 ++++----
> target/riscv/cpu_helper.c         |  7 ++--
> target/s390x/cpu-system.c         |  4 ++-
> target/s390x/mmu_helper.c         |  9 ++---
> target/s390x/tcg/excp_helper.c    | 10 +++---
> target/s390x/tcg/mem_helper.c     |  6 ++--
> target/sparc/helper.c             |  1 +
> target/sparc/int64_helper.c       |  1 +
> target/sparc/ldst_helper.c        | 22 +++++++------
> target/sparc/mmu_helper.c         | 21 +++++++-----
> target/xtensa/mmu_helper.c        |  3 +-
> 44 files changed, 253 insertions(+), 189 deletions(-)
>
>
--3866299591-1200896199-1759333145=:37311--

