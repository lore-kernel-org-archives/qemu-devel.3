Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD3FCD3427
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 03:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKT4M-0001lb-22; Tue, 05 May 2026 23:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wKT4F-0001j1-I9
 for qemu-devel@nongnu.org; Tue, 05 May 2026 23:37:00 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wKT4C-0006Nt-Sa
 for qemu-devel@nongnu.org; Tue, 05 May 2026 23:36:58 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-35fb16e56efso4131702a91.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 20:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1778038614; x=1778643414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NmSBLcNJwbzykPdrUBPXLq5aVjtVgxVeir17yo2flxY=;
 b=b0YV6M6mwijuu8j+qNTcK/rI2MKwUFx/7Cw3p58kqsw9YJimyhTO/ASilsSONOR+It
 GBoI4SXQX2/gGbn8v+i6pujVbLIR+fpNDaBNDbPgWsgTg/8Ijhm5+NMA5eYiEoUEBw8s
 WQGrO6Wz93AhEbpXgYByWEGSThgLIRQ8ZzRi+GFgcbCW8dIxEqPEEmCKWrEljmJjfuPs
 SwJlofVvimRM8P07g/BkgQw6pllDSa0KnHIi4UpYdTEmF0bGCjEEfcTp5XX3r9ZfVtiO
 eMWd3uXB7o9wQHGETeYe91n9vk4jBXJ6j4A5Uj3vA0EFbs9VDESS/2wj4r5i5xPK21UY
 e17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778038614; x=1778643414;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NmSBLcNJwbzykPdrUBPXLq5aVjtVgxVeir17yo2flxY=;
 b=KJg5R/ROMY+98yFWOdeWx2yUB2b01cqziMQT43PWNvORF6X1IblWT6Gkzhb4O/cZOE
 K9CatmIn17IOdN3iC1pvz4s4i4DO9DNANOVYrHNwYuVJ+YlNn/pEzb9RLSZFcMGsSgR7
 JC2/3yfJGZI0yHzPdHSk7EO32HpfVJcTaZT9mqeA5vF4/n7wotIAqFIGOTD8/kbZS9aZ
 fDJetM5/gkhZt2x3GlyihDYEUIIJCiRnw1GCvZNlHJ7Dqkrtv13vIayPIEbTGS+ncu3j
 JJt4TFNhWafkdvCAJSshPq8G/IQke6NR2C3ys34e/Vv+phvJQzUVgCTQJgZSM1TG9fVL
 HHTw==
X-Gm-Message-State: AOJu0YxYlDnUOVQg+/LfN7b2nYuom2BkibXH9wmv6OUo5AOT8Bvw3XEE
 0W5jvadiTgfyU+rOW/ZSbAgnWkI1QYc2P3RKfEMfxQHs/xxcD+z9waSUwAHp1DZd1vRjvd2/bpB
 k+TipbjZ3SWSOMIivIiaNC9/ytrA29R+jeaENt8ozVR15tt7O5Qdhu/JobWWFu9M9CcBqpqKo2+
 uB8EIS6xEY+iGnRxIyY3yeKL98Wdl+dBNbjyayZBn4
X-Gm-Gg: AeBDieuS5PtM/7iNP5z9WcyL0CFp63d2B7eezzmevQDFYzYOfVgbhSlsLnbb8KEeKxl
 qohHyFeaNZ81mcmGqnvwoFSNorq6j+ZZuVX8JgS074MDDrgrlwrk3kNE4pzQNcFFwZ76EusaJ4d
 XIvSfiXOi2gUXOU/r1An0UaDzwtSTQYc89XTXN9P5Cz+kKflFi1Y3II6zqavuerBwVt375r2d9R
 ziFBo9J0YBrvb6bPsPHqr/UMtq9HOPG10WrmjN1GwNv7JvY+Q7EMVUIg7cmDsCIGaGrakQ89gkW
 kUKA7L/Isvwr8+/f9//OqXqxkFk1ua7QitzZCPHp7xF7yl44W00QslMOkpi1ENqbmA2Pk/6B/9l
 eGY590TobAuT3JN7MCxeCcIuC3MBTr2Q3ZNOj3WlFyL+s9rt8YWm9wY8xN1BMnvkOlK6QZ9osBH
 /t78fIgD0xwHO6npGm4LnJDeaBJUAf+knB13jSDJHEHfV/0G0UnLl++IY=
X-Received: by 2002:a17:903:13cf:b0:2b2:501c:bc0 with SMTP id
 d9443c01a7336-2ba79290f29mr15809285ad.7.1778038614073; 
 Tue, 05 May 2026 20:36:54 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7ca34cfdsm7666265ad.79.2026.05.05.20.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 20:36:53 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Song Gao <gaosong@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 0/5] Defer the IOMMU translation in the CPU path and
 support access_type
Date: Wed,  6 May 2026 11:36:37 +0800
Message-ID: <20260506033642.3641390-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=jim.shu@sifive.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Incoming security protection devices feature more complex IOMMUMemoryRegion
implementation in the CPU path than ARM MPC device. For example,
RISC-V wgChecker [1] may permit the access with only RO/WO permissions.
Consequently, the IOMMUMemoryRegion could return different sections for
read & write access.

To support such IOMMUMemoryRegion behavior in the CPU path, the design
of IOMMU translation must be updated:

1. address_space_translate*() must now pass the access_type to
   IOMMUMemoryRegion.
2. Since IOMMU translation results are too complex to be fully stored
   in the CPU TLB. we will defer the translation until the actual access
   occurs. Also, TLB is allowed to store the untranslated IOMMU region.

To implement deferred IOMMU translation, this patchset introduces the
following changes:

1. tlb_set_page_full() no longer translates the IOMMU region
   immediately. Instead, it stores the untranslated region directly in
   the TLB. A new slow-path flag, TLB_IOMMU, is introduced to force
   access into the slow path when a region has not yet been translated
   in the TLB entry.

2. When the CPU utilizes a TLB entry in the slow path, it should perform
   the lazy IOMMU translation of the access_type first. The resulting
   translated region and access type are stored in CPUTLBEntryFull.
   Since the slow path always performs lazy translation first, we can
   switch the CPUTLBEntryFull content to the correct access type before
   use.

3. To accelerate memory access in the fast path, lazy translation can
   update the addend of the CPUTLBEntry when translating the region to a
   host memory region. We restrict the IOMMU region to have a single
   non-zero 'addend' across all permissions. If a second 'addend' is
   present for a CPUTLBEntry, QEMU will trigger an assertion. This
   limitation is sufficient for security devices, as their "secondary"
   region is typically an IO region used to emulate device error
   handling when access is rejected.

4. To support non-slow TLB flags, lazy translation can update the TLB
   flags in the 'addr_idx' of the CPUTLBEntry. Lazy translation only
   updates the flags for the permissions specified in @prot. This
   ensures that each access_type of a translated region to maintains
   independent TLB flags. For example, TLB_DIRTY of memory region will
   not be "polluted" from other permission that translated to different
   region.

Both RISC-V wgChecker [1] and RISC-V IOPMP [2] devices require this
feature.

[1] RISC-V WG:
https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
[2] RISC-V IOPMP:
https://patchew.org/QEMU/20250312093735.1517740-1-ethan84@andestech.com/

Changed since v2:
- Fix unused initialized memory error

Changed since v1:
- Remove the ping-pong TLB entry behavior. Instead, defer the IOMMU
  translation until actual access in the CPU path. Provide a IOMMU
  lazy translation function with the special handling of 'addend'
  and 'addr_idx' fields of CPUTLBEntry.
- Fix the checkpatch warning.

Jim Shu (5):
  accel/tcg: Pass access_type as an argument of tlb_set_page*()
  accel/tcg: address_space_translate*() will pass the correct
    iommu_flags
  accel/tcg: Provide early AS translate function
  accel/tcg: Add IOMMU lazy translation function
  accel/tcg: Support IOMMU lazy translation in CPU TLB

 accel/tcg/cputlb.c                   | 247 +++++++++++++++++++++++++--
 include/accel/tcg/iommu.h            |  17 +-
 include/exec/cputlb.h                |  11 +-
 include/exec/tlb-flags.h             |   4 +-
 include/hw/core/cpu.h                |  15 ++
 system/physmem.c                     |  60 ++++++-
 target/alpha/helper.c                |   2 +-
 target/avr/helper.c                  |   3 +-
 target/i386/tcg/system/excp_helper.c |   3 +-
 target/loongarch/tcg/tlb_helper.c    |   2 +-
 target/m68k/helper.c                 |  10 +-
 target/microblaze/helper.c           |   8 +-
 target/mips/tcg/system/tlb_helper.c  |   4 +-
 target/or1k/mmu.c                    |   2 +-
 target/ppc/mmu_helper.c              |   2 +-
 target/riscv/cpu_helper.c            |   2 +-
 target/rx/cpu.c                      |   3 +-
 target/s390x/tcg/excp_helper.c       |   2 +-
 target/sh4/helper.c                  |   3 +-
 target/sparc/mmu_helper.c            |   6 +-
 target/tricore/helper.c              |   2 +-
 target/xtensa/helper.c               |   3 +-
 22 files changed, 354 insertions(+), 57 deletions(-)

-- 
2.43.0


