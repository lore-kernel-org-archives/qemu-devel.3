Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56220606A337
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DD5bo5J5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnah-0001qU-JJ; Tue, 24 Nov 2026 05:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xVnaf-0001q5-W3
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:17:34 -0500
Received: from mail-pj2-x06.google.com ([2607:f8b0:4864:39::6])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xVnae-0004XV-1T
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:17:33 -0500
Received: by mail-pj2-x06.google.com with SMTP id
 98e67ed59e1d1-3b4be95e0afso603491a91.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 02:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795515450; x=1796120250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E4ClsPfAVGVsUlAyTfXGjWVNdf+PP23iT7j9Z2VKM1M=;
 b=DD5bo5J5xi1F2sr4RIMi9btjJsxAbnH/FplNtHnupEQqj8grd9AmkWJMiOEq4oo30/
 TXPPkyIMNoTVJt9K7TIVybd6lZC8RVS+r0uC+629Oe4wPOHazWyYWWjQkSSaCJrlEd2V
 sp/TalUC+MNq8C1tNghpzjjj7fQVATISaYz334nUqM1VTvQlw7802eAXVK6ba+WrozRJ
 wkMNP3cLSr5jSDdGD1bdY6t9gHrkgBwA266s+aKJKZZZCUBjAM3T9i4CV+4gQoGbHKNr
 rGvoldR7FoHQGyWd1DLdI2TzntFcm2hJrGDjGWMSG40SDzRnrYHTNsFF8Hvfc9K8sW7b
 cIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795515450; x=1796120250;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E4ClsPfAVGVsUlAyTfXGjWVNdf+PP23iT7j9Z2VKM1M=;
 b=aPlA0l8mCOyoChxLQFfzF3hpS3RlLBm5Yb8BusdF8FSWVu0CdS+JEkggpetdgtNV7s
 mNHFh4o2Ct99TE/YsCp1e7p8KwH9UZ6BjiNYZZM3W/EHXu9IKVxrZUD1roegNHAMVDAm
 6i1wEXr7StElF2+xxbgSFZYU2FEZYtmPapTvGCyYjz8bJFqQkS2fUXbvI04WoYipieZF
 N9VNATAzBUBBpzBiYhfEgcLrGKIMX+ssO32xD0t0U6XizrazpU7/P+huEUUELhW9nlEP
 P8N4TQ0nKkiAifAQHENB9liqm3sp/aT4ZS+TKk3bfRPJnX/Nfz/ONjJElzPJGb1KGUjv
 ZXTg==
X-Gm-Message-State: APuU4Z8Cwr6gaQ4upO1la0nN3iB/Qk7ZP1/iHnkx86l2826GvpFlJ0Mr
 +h4G8uAY/fMLKdjTPMFUmiMvkRNXtgG1bJ2GraWJb2xyA3Mjp6rfVGfxXrYQ/YZy
X-Gm-Gg: AZFdTZc1M5wweozbrGCuBddVR8Ad2VDw+yrtfj7+hdAfDJQ6nRTe6pFXTR70+WEjf1p
 nDTcnqva0pcxqPhc/3QxHLut26nqGhmAxCr4Cgyia/pR5Srkscnpf+en6PTJjI1DYrGZ4hmFKv9
 +m1WIFLvggdzJPyYxBTve0QUw5aenuAoVC3YmvCc3ErPrCJ+f5uriVzBNPTOHOE5Em/Jzc44EXS
 OcaLPI05GFAWwquu3n3Pn3S7zaeGPVeBCohzo6vdFnmQ28dF45HUsBhlSU4SVWD9nePWACcwbhI
 4TBUQS6OADqYIjRcbIoDKzXZgdTBiSTg/qWlAtg44XPBf65/6dTDDbX/eRBbCKe5K0H8pIVk6EL
 iwJKiRUMRliKRBDo3UB29RbFoNSa9E5a+Cn3owkG7bymx3bpIKslJn/LY3kzv/zJ69kodPeREjT
 JJEco21ziySTOfzhyZeN8Crk2LuxCzTkffzxSFKDJO4BDvXl3ebzsp7JNoXW/4e6/2PMddzeqR0
 5RCfq73KT0Aw6cPJZP+OTCGWkPszH6F/o5KfGk2GYjejsK4u8Ga4FrEz/RUYDpSoUa3dTrz1KNs
 u2AzgUmwu9HgWh7bykSOWs5/PVCME9o=
X-Received: by 2002:a17:90b:17cd:b0:3ab:884b:65a8 with SMTP id
 98e67ed59e1d1-3b41c9032bfmr12393685a91.26.1795515450209; 
 Tue, 24 Nov 2026 02:17:30 -0800 (PST)
Received: from computer ([2604:3d09:98d:800:e939:4613:1d28:dfcc])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6cea748csm6627920a12.4.2026.11.24.02.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 02:17:29 -0800 (PST)
From: Tim <mdspan.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, zhao1.liu@intel.com,
 Tim <mdspan.github@gmail.com>
Subject: [PATCH v3 0/5] target/i386: emulate LAM in TCG
Date: Tue, 24 Nov 2026 10:16:49 +0000
Message-ID: <20261124101655.2269531-1-mdspan.github@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::6;
 envelope-from=mdspan.github@gmail.com; helo=mail-pj2-x06.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series emulates LAM in TCG for x86_64 system mode and reports it
in "-cpu max". linux-user support will follow in a separate series.

Patch 1 keeps the CR3 LAM bits out of the PML5 table address. Patch 2
makes the large-page check in tlb_flush_range_locked() compare under
the flush mask, as agreed in [2]. Patch 3 adds MMU indexes for
LAM-masked data accesses. Patch 4 is the LAM emulation, and patch 5
adds a system-mode test.

The design follows the RFC thread [1]:

- On a TLB miss, get_physical_address() masks the address and runs
  the canonical check and the page walk on the result. The entry is
  installed under the tagged address, so each tag of a page has its
  own entry. INVLPG and INVLPGA flush every tagged alias with
  tlb_flush_page_bits_by_mmuidx(), and a change of CR4.LAM_SUP
  flushes the TLB.

- Patch 3 adds LAM forms of the three 64-bit data MMU indexes and an
  hflags bit, HF_LAM, that is set while LAM is enabled. With HF_LAM
  set, data accesses use the LAM indexes, and only those are masked.
  Instruction fetches always use the normal indexes, so fetch and
  data entries for a tagged address are in separate TLBs. Without
  LAM, only the normal indexes are used.

- Exceptions do not report the tagged address, which answers
  Richard's question [3]. On #PF, CR2 receives the masked address
  (SDM Vol. 3A, section 4.4.3), and #GP reports no address.

- gdbstub, monitor, and qemu_plugin_translate_vaddr() translate a
  tagged address as a data access does.

Known gaps:

- Data breakpoints on an untagged address do not fire for accesses
  through a tagged alias.

- With LAM_U48 and 5-level paging, gdbstub, monitor, and
  qemu_plugin_translate_vaddr() translate an instruction address at
  or above 2^47 as a data address, not as a fetch does.

v3:
- Patch 3: LAM forms of the 64-bit data MMU indexes, selected by the
  new HF_LAM bit, in place of the fetch MMU indexes, as Richard
  suggested [5] and agreed [6].
- Patch 4: mask only for the LAM MMU indexes.
- Patch 5: test exception delivery with a tagged IDTR base, which
  covers the LAM indexes from x86_mmu_index_kernel_pl().

v2:
- New patch 3: separate MMU indexes for instruction fetch, as
  Richard suggested [4].
- Patch 4: mask only for non-fetch MMU indexes.
- Patch 5: set exe_name only where it differs from the default, for
  the check added in commit 1138de1d.

v2: https://lore.kernel.org/qemu-devel/20261120104431.733136-1-mdspan.github@gmail.com/
v1: https://lore.kernel.org/qemu-devel/20261110130108.706228-1-mdspan.github@gmail.com/

[1] https://lists.nongnu.org/archive/html/qemu-devel/2026-10/msg01840.html
[2] https://lists.nongnu.org/archive/html/qemu-devel/2026-11/msg01599.html
[3] https://lists.nongnu.org/archive/html/qemu-devel/2026-10/msg05620.html
[4] https://lore.kernel.org/qemu-devel/4a2dd42c-fe8e-46ad-a74c-bae94d088be8@linaro.org/
[5] https://lists.nongnu.org/archive/html/qemu-devel/2026-11/msg04655.html
[6] https://lists.nongnu.org/archive/html/qemu-devel/2026-11/msg04942.html

Tim (5):
  target/i386: mask the PML5 table address taken from CR3
  accel/tcg: compare large pages under the flush mask
  target/i386: add MMU indexes for LAM-masked data accesses
  target/i386: emulate LAM in TCG
  tests/tcg/x86_64: add a LAM system test

 accel/tcg/cputlb.c                   |   4 +-
 target/i386/cpu.c                    |   2 +-
 target/i386/cpu.h                    |  89 ++-
 target/i386/helper.c                 |  21 +-
 target/i386/tcg/seg_helper.c         |   2 +-
 target/i386/tcg/system/excp_helper.c |  15 +-
 target/i386/tcg/system/misc_helper.c |  24 +-
 target/i386/tcg/system/svm_helper.c  |   3 +-
 target/i386/tcg/tcg-cpu.c            |  12 +-
 tests/tcg/x86_64/system/boot.S       |  14 +
 tests/tcg/x86_64/system/lam.c        | 835 +++++++++++++++++++++++++++
 tests/tcg/x86_64/system/meson.build  |  16 +
 12 files changed, 1018 insertions(+), 19 deletions(-)
 create mode 100644 tests/tcg/x86_64/system/lam.c

base-commit: 45b7c3e45e2b778e560a0734daa6aa0059bc0edc
-- 
2.47.3


