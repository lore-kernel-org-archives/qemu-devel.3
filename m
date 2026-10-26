Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377E1606A320
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YROjYjbU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLP2-0002Z7-3E; Mon, 26 Oct 2026 10:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLLOW-0002U9-21
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 10:09:50 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLLOU-0002EJ-6W
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 10:09:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso3143169f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 07:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793023784; x=1793628584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aULPKl9qSVaw10b8fVCSR3N//3y36NIH+jzufg8zy/s=;
 b=YROjYjbUTD7MeXe6X9fUchyPUHQZnzM7YFMVIjnU8uLFCydSRh6rME2zG9MYlNPoZg
 EK1fPXf/bmcmf2PD8+8iANKzEsj9uW9juvQeS/RJRnYWNeP4i0ORKtX5OENhpWZf8N8+
 vh4j5+I1uEWtvXPjhKkhjJ7tKKn+KBSyrLVt9krkeIyOo+ju/+KcBSbPcKcJZ2c4rDdz
 g2vPvN5Pu82FttmUVGHd2XE8ugxTEukhlemwbx9KHbg3qHuLv1wHLDpo02SKlZuB/z1M
 +EoiQ3TvJ29wqS8ZQxmFOWSMABK9n3r7DjjfeSMXtb8ZNqyM0CyXuAmN0JuLqjoAmAf0
 UBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793023784; x=1793628584;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aULPKl9qSVaw10b8fVCSR3N//3y36NIH+jzufg8zy/s=;
 b=Vmv+inIj9r3+HXkVEG9GUEUY+6MMx8k5WYqkGc3T8lZju1ANHY859CDM0nCU8lKdJs
 vHF1JNqauRNwklv8B469pmWb+UhIBktyQ2zU12qhrUpkqnKxmb/ojiZlWeys6LCxs6I0
 EM9yZXco7taCA2NKnK3SY2GjQsAD6p/mRBkD4N8vvBv9fQpA9G4NW5COE8FqSqEe1El4
 ajejgrZ26oINQUm0BFJ7g8v3tTYtQedQhxuhtrad8Kd2NJPW+o8wd0d3KA55nRBes9Nu
 gw37M9qkReCQtjKeY9Vz9u+ceAMGbXAUAusYFMitqJT1t/yBWX8PJxMZIqptoA/EJ35R
 QTSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxi11APDx8aLi3TslUHvJMYyMxA/GtnLICfhzZ+eOceyqXfnYu6kCOeEOSuqbVjJMShM7eyBamiNPqh@nongnu.org
X-Gm-Message-State: AFq9FYKQKnMLMBM+iMD1z54ha9WhXrBdFtHvYHCZ0GytBjP+JH9A2T52
 zeB/QRBYkrYS/XKQDlehLa4W6rcKptIvaDOXRvylhmMovxLVr9mkrJRA3cweQTUFZ98=
X-Gm-Gg: AYBFou2+mUy1nn3jUsouOibtWV8ABlK09Nf35PPRx6i9Oh4vvh4jqLaavIiVlE7YBjZ
 ZwB7HO+r+wktmK6emHb2wr/etlZGTvE+xWbWjUxKa6H2TmJ/5osF7He+0Dv0BtlGWkWg05IowVv
 lYzel1e3TI5UA7EHascN9Q4jsAUNzYPisUePxRvGYk/Sh2whCQqP94KK3Kqbj/104fMOUqfxTyZ
 qMMa34jAiQ1Jh3kULfrhuQ2BLPKx6KyiHPh/kLE+e1RIIstlIIwBdQhUY50U+4hbK576LV52CmH
 X+zETrfSbvfCuGUHqz4E6dIGD2MfhBqrUiAkzHhsgy8+p321xDZ/K5RLt++7BqfzwbhH+rgABuQ
 1lpq6CqF87IlHHwS6pTsCJNwJgRfedDM0HS4Z8xWWfrfeQYR/6FEYwjXTVofUMK01yOQRyZazC0
 Q5NSOxsVgk8dNF7O4OnDAw7icp6BXmaua+TtplJ0R1On7yAuzlSIcqcOtsHNvlmZvIkqLJTvZ1V
 TVO5JYs/qEwoMZHOFJO+2UtavgBphgS7v0e/kk38iX68PqCpfc/qZecsCfpETMmUSSuUazT/oIp
 rWCpKCPH1olIngZgQtfVWSzPC7Ab4BTBm6HdcfobSPWgzyhBliHrPDbWohws
X-Received: by 2002:a05:6000:491c:b0:48e:4395:2dc with SMTP id
 ffacd0b85a97d-48e439506a9mr12075950f8f.22.1793023784242; 
 Mon, 26 Oct 2026 07:09:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4115f496sm15814077f8f.5.2026.10.26.07.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 07:09:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/arm: For linux-user,
 prioritize PC misalignment fault over insn abort
Date: Mon, 26 Oct 2026 14:09:42 +0000
Message-ID: <20261026140942.2768950-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Arm architecture requires that for PC alignment fault exceptions
take precedence over Instruction Abort exceptions.  We get this wrong
for linux-user mode, because QEMU detects the lack of any backing
memory via probe_access_internal(), and calls
arm_cpu_record_sigsegv(), which always reports either a Translation
or Permission fault:

#3  0x0000649548976b94 in arm_deliver_fault (cpu=0x649555ce5920, addr=1, access_type=MMU_INST_FETCH, mmu_idx=0, fi=0x7fff87e4c940)
    at ../../target/arm/tcg/tlb_helper.c:274
#4  0x0000649548976d69 in arm_cpu_record_sigsegv (cs=0x649555ce5920, addr=1, access_type=MMU_INST_FETCH, maperr=true, ra=0)
    at ../../target/arm/tcg/tlb_helper.c:421
#5  0x0000649548c97650 in cpu_loop_exit_sigsegv (cpu=0x649555ce5920, addr=1, access_type=MMU_INST_FETCH, maperr=true, ra=0)
    at ../../linux-user/signal.c:761
#6  0x00006495488f8235 in probe_access_internal (env=0x649555ce99a0, addr=1, fault_size=1, access_type=MMU_INST_FETCH, nonfault=false, ra=0)
    at ../../accel/tcg/user-exec.c:790
#7  0x00006495488f850d in get_page_addr_code_hostp (env=0x649555ce99a0, addr=1, hostp=0x7fff87e4ca70) at ../../accel/tcg/user-exec.c:828
#8  0x00006495488e5433 in get_page_addr_code (env=0x649555ce99a0, addr=1) at ../../accel/tcg/internal-common.h:116
#9  0x00006495488e56bd in tb_htable_lookup (cpu=0x649555ce5920, s=...) at ../../accel/tcg/cpu-exec.c:206
#10 0x00006495488e58c8 in tb_lookup (cpu=0x649555ce5920, s=...) at ../../accel/tcg/cpu-exec.c:251
#11 0x00006495488e5d2a in helper_lookup_tb_ptr (env=0x649555ce99a0) at ../../accel/tcg/cpu-exec.c:398
#12 0x00007d973c000270 in code_gen_buffer ()

Make arm_cpu_record_sigsegv() report a PC alignment fault for
MMU_INST_FETCH accesses to non-4-aligned addresses for A64 and A32,
matching the logic used in arm_cpu_tlb_fill_align() for system
emulation.  (Unaligned PC faults can't happen for Thumb.) This is
then passed to the guest binary as SIGBUS rather than SIGSEGV.

(The Fixes tag is for the commit that introduced this function, but
the bug was also present in the previous implementation.  It's an odd
corner case so it's not worth the effort to try to backport the fix
beyond that.)

Cc: qemu-stable@nongnu.org
Fixes: 9b12b6b44250c2 ("target/arm: Implement arm_cpu_record_sigsegv")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4699
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/tlb_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 4c3f16dc2aa..2e84b1cb369 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -418,6 +418,10 @@ void arm_cpu_record_sigsegv(CPUState *cs, vaddr addr,
      * For now, it's easiest to deliver the fault normally.
      */
     cpu_restore_state(cs, ra);
+    if (access_type == MMU_INST_FETCH && !cpu->env.thumb && (addr & 3)) {
+        /* Misaligned PC faults take precedence over insn abort */
+        fi.type = ARMFault_Alignment;
+    }
     arm_deliver_fault(cpu, addr, access_type, MMU_USER_IDX, &fi);
 }
 
-- 
2.43.0


