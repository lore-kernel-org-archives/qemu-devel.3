Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C732D606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ynDEXjUt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWa6H-00078L-PJ; Thu, 26 Nov 2026 09:05:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christopher.elwood2024@gmail.com>)
 id 1xWT1w-0007Vl-43
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 01:32:29 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christopher.elwood2024@gmail.com>)
 id 1xWT1u-000446-4e
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 01:32:27 -0500
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-53644b28706so102811261cf.3
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 22:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795674742; x=1796279542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8hzrF4+vtHNE3BF7VknLANTlGaG4dcRdQ697tzIwUjw=;
 b=ynDEXjUtPdAyftozPC/woi0D3hogM7orG3pqRNKAIg0IOqnYe69xTKYbwRRk0B48fJ
 pGMRofrydHED9jy8bppKjqLRxNjaAAk2gl6iqClDMScTX0HmvtEOzOq0BPzwKCpi9TLJ
 gBaj9ewqJr65tu54HnNJHJAnA2lc1473h3BvBIMBzcoqV0raDXY213BKzUte3aAWG/f0
 86ctJP/zMJO/3H8BpcuUNS1xeFVD/tLs0xPQhOKKeofgPYPwThRsnZt+sZzECyTmnTDt
 kRDnGyVykmFqONorpBjqQzxR7asUFkPLekq1Q5H/VdybhBzJvUWJxm2G+g5nFeWsHPOa
 pvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674742; x=1796279542;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8hzrF4+vtHNE3BF7VknLANTlGaG4dcRdQ697tzIwUjw=;
 b=VIMD0F9iTRd95Dsjd/LIJIRppyrSmqf6oIoQmmGtCqi+gfnicGHM3yDS0spEM8TC3w
 4ZuuNU/bja08WgbM7eGWOlQExAWgysCMgKLgWd1eothNbr+AIEX3EbCTdAPZN+k90C2g
 dOS7ObOUycDUoI8qPa/UlExFbOLh3WQWW9lllUjhDpPTw9f3nanD6qTdA0VzIQFotskR
 DRoCfwR7XpzyghUfu19awt7iRhGeF2Y7IeQ1vJQQ9YfWT3ETAVZ4/nq8jMf7cwvrrL56
 BhYtzden3mpRewOwNXK31w5Nk1SgG/lrAaMgOZRZE3HkfP9eH2VFQtKh4t1ElHKVtmUg
 +LYw==
X-Gm-Message-State: APuU4Z9VRo+LajPbqiyEqb9dR+B/IJtVikYj0MxkQyS9RzYo7TZRUtjS
 Ehsub/UPr7waDXCThME2n+KkDAR9BanWTgdzvafuglJHYgBMYDGKLBWPEmIokgO+
X-Gm-Gg: AZFdTZemmL0sq6Z9Xu1ipgNa88maOHNmgqUQomUvylleLn3J9VFeiwft4ajH9jT7g4M
 Qlt+a2G2mAGUxxJWpNvST+WMIevdqnd+4nFij9V5S8TMLaApOL0U5/BZmeZz1DgP/bIPbexpRf1
 y4xNnQvZ5akKM5VTtN1UfGcO2fyL0VPSXCreD9kDw+85o14c9XKgfnA5DgNjqq4scKIi7fU00+n
 q41b1pfObaDevxA9fqmtS5wiALtIpyfu2mrc3t8H+vMn/PnUADcSe8x7KNab5KFvM+joiXYD6lV
 Bo2iMrkz6l5JbUsgExfketoibPah/Eqe68eokdQOp+EfflNQvLTbXSzep0l5/GQHMaNb+f3ffGh
 VJOWVshOh8Q9rZlVUmIDKBvsw+NwI5nXLvjgiGA84ucYNo83hkhijScB8yY1op7zjgElXh7tfUN
 lHRaJ8r2cgYuw8XxN6HVy5txy26ZSpAcHgz07duMpvW5FYDhD+s7wjTU37ifNic1efRQiqMwMcd
 BxKXvp+SWM6Qhd0WVqzzmwoY/4GZmSWR99Ro+YQxqVcx3brnbyekJYfEIns2rZB6zjogciawD7s
 vho3iP0PkOZZ1MDWEf1uzXd5+/hfJjQ/tUZS02S/QK9JiCzUxK/+LO1fCycnBEYnGafxE2xSwUJ
 GhSuiwBdZNWg3P4Xv4N0mPFbt5Gw4LGl3
X-Received: by 2002:a05:622a:58c6:b0:55d:36d3:a949 with SMTP id
 d75a77b69052e-55d769ea509mr391577981cf.27.1795674742287; 
 Wed, 25 Nov 2026 22:32:22 -0800 (PST)
Received: from localhost.localdomain (46-110-2-156.zmmnohaa.metronetinc.net.
 [46.110.2.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d7888fb27sm172357501cf.25.2026.11.25.22.32.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 22:32:21 -0800 (PST)
From: Christopher Elwood <christopher.elwood2024@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Christopher Elwood <christopher.elwood2024@gmail.com>
Subject: [PATCH] target/riscv: raise access fault for shadow stack accesses to
 non-SS pages
Date: Thu, 26 Nov 2026 01:32:19 -0500
Message-Id: <20261126063219.90134-1-christopher.elwood2024@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=christopher.elwood2024@gmail.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 26 Nov 2026 09:05:23 -0500
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Section 15.1.2.3 ("Shadow Stack Memory Protection") of the RISC-V
privileged specification says:

    "Shadow stack instructions are restricted to accessing shadow stack
    (pte.xwr=010b) pages. Should a shadow stack instruction access a
    page that is not designated as a shadow stack page and is not
    marked as read-only (pte.xwr=001), a store/AMO access-fault
    exception will be invoked."

QEMU does not implement this.  For sspush and ssamoswap.d in S-mode:

 - RW (xwr=011) and RWX (xwr=111) pages are written with no trap.
 - X (xwr=100) and RX (xwr=101) pages raise a store page fault
   (cause 15) instead of an access fault (cause 7).

SSPOPCHK loads through the same MMU index, so it is affected too: on RW,
RWX and RX pages it raised a software-check exception (cause 18) when
the loaded value mismatched, and on X pages a page fault.  It now raises
a store/AMO access fault on all four, which takes priority over the
software check.

Handle these encodings in the leaf PTE switch of get_physical_address()
and return a new TRANSLATE_SS_ACCESS_FAULT result for shadow stack
accesses on the first stage.  riscv_cpu_tlb_fill() reports it as a
store/AMO access fault.  Read-only pages keep raising a store page
fault, and G-stage leaves are unaffected.

Tested: unpatched master vs. this patch on riscv64-softmmu, same base
and configure flags.  Reproducer from #4622: exit status 255 before, 0
after, all eight cases raising cause 7.  Scenario 3 from #4379
(sspopchk with a mismatching value on an RW page): cause 18 before,
cause 7 after; scenario 1 (unmapped page) stays at cause 15.  sspopchk
on RW/RWX/X/RX pages now raises cause 7, and sspush, sspopchk and
ssamoswap.d on SS, read-only and unmapped pages are unchanged.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4622
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4379
Co-developed-by: Tarun Patanjali tarun.patanjali@utexas.edu
Signed-off-by: Tarun Patanjali tarun.patanjali@utexas.edu
Co-developed-by: Rishab Pradeep rishab@rispop.dev
Signed-off-by: Rishab Pradeep rishab@rispop.dev
Signed-off-by: Christopher Elwood christopher.elwood2024@gmail.com
---
Scenario 2 of the reproducer attached to #4379 (M-mode ssamoswap.w,
mtval = 0 instead of the faulting address) is a separate problem and is
not changed by this patch.

The new check is made before the U/SUM and A/D checks.  The spec says
U/SUM is enforced normally for shadow stack accesses, so I would like
confirmation that an access fault is the right result for an SS
instruction to an RW page that also fails one of those checks.

 target/riscv/cpu.h            |  1 +
 target/riscv/tcg/cpu_helper.c | 23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 49a1186bdbb..2dd76837a7e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -139,6 +139,7 @@ enum {
     TRANSLATE_PMP_FAIL,
     TRANSLATE_G_STAGE_FAIL,
     TRANSLATE_PMA_FAIL,
+    TRANSLATE_SS_ACCESS_FAULT,
 };
 
 /* Extension context status */
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 58e98e975c2..d8af744068e 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -1438,6 +1438,19 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             return TRANSLATE_FAIL;
         }
         break;
+    case PTE_R | PTE_W:
+    case PTE_R | PTE_W | PTE_X:
+    case PTE_X:
+    case PTE_R | PTE_X:
+        /*
+         * Zicfiss: a shadow stack access may only target a shadow stack
+         * page (xwr=010) or a read-only page (handled above as a store
+         * page fault). Any other leaf is a store/AMO access fault.
+         */
+        if (is_sstack_idx && first_stage) {
+            return TRANSLATE_SS_ACCESS_FAULT;
+        }
+        break;
     }
 
     int prot = 0;
@@ -1780,6 +1793,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     bool two_stage_lookup = mmuidx_2stage(mmu_idx);
     bool two_stage_indirect_error = false;
     int ret = TRANSLATE_FAIL;
+    MMUAccessType fault_type = access_type;
     privilege_mode_t mode = mmuidx_priv(mmu_idx);
     /* default TLB page size */
     hwaddr tlb_size = TARGET_PAGE_SIZE;
@@ -1877,6 +1891,13 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
     if (ret == TRANSLATE_PMP_FAIL || ret == TRANSLATE_PMA_FAIL) {
         pmp_pma_violation = true;
+    } else if (ret == TRANSLATE_SS_ACCESS_FAULT) {
+        /*
+         * Shadow stack accesses to non-SS pages are always store/AMO
+         * access faults.
+         */
+        pmp_pma_violation = true;
+        fault_type = MMU_DATA_STORE;
     }
 
     if (ret == TRANSLATE_SUCCESS) {
@@ -1903,7 +1924,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         cpu_check_watchpoint(cs, address, size, MEMTXATTRS_UNSPECIFIED,
                              wp_access, retaddr);
 
-        raise_mmu_exception(env, address, access_type, pmp_pma_violation,
+        raise_mmu_exception(env, address, fault_type, pmp_pma_violation,
                             first_stage_error, two_stage_lookup,
                             two_stage_indirect_error);
         cpu_loop_exit_restore(cs, retaddr);
-- 
2.39.5 (Apple Git-154)

