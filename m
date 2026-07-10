Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4326CC44508
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIIL-0000mO-1g; Fri, 10 Jul 2026 16:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIIJ-0000hZ-9B
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:57:59 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiII9-0001tM-Tz
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:57:58 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso1934137a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783717068; x=1784321868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6DlcOURZ8Vq6FHB8e3m8GHkjsu8dVLmyFcRV/xT55GA=;
 b=IlcDt8GypjmeRkoGkm1036T85xesu/lwtKMyumcYjc6DTn1rTP2kX/Yp85+bsV6r0I
 XtTavvrzgGvNP6c2AquwR5wGk8TQCY+XbgLkTqjedRr9yLg4Thv0LXuehQ6ppasgGKfl
 u8v3cJQ/mMtmw8cEnBNTp8vR9Pot0Zh8Nm42rlqT7QXvDwBhY7hjbheZGRz8dV9DuXB2
 L8fU5clY6Yc+u3tdDYQlarQXW/SKSMH7Z7J0O2wSlbPOaQ9BKywslHL8RK62FmyfzUHV
 IEJdPkplSuDLxNiIsDrjb10OBp5IRuWvzWnV17H/fWINCM1mF4WDuS7xaNKAcGEqogJH
 DXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783717068; x=1784321868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6DlcOURZ8Vq6FHB8e3m8GHkjsu8dVLmyFcRV/xT55GA=;
 b=diqwQqEusrl0DdEZre3FxxOGmPhIS2nTGJuexCJmGrCoveTxaB73wLupPdqwqfaUkt
 kmBWpB6MXEAveBZiHHk/XX5WAwG140JWZDAQz/PkQcov2ktL0h6detBsWyLOgEwePEtC
 PctXxW6DISWTfwtQA0F7HIxoFtU7eOM0PEh+1ed/NWPLLIwsS+aSETlkebzF0veRDz22
 6YQIQC3wqRagfobuzAMKsq1GtRivZAuw8bdbbY6NYxStNMNiLkVFs/EpEavegxXx4/To
 KLesZUTsYzJl8SWiil7tLU361WZZztP25pMokowrCE3JDJGOGx+haDiCsUYxPj5hrke6
 nfHw==
X-Gm-Message-State: AOJu0YxmYqJgU9xy0bHI3ply+W+JhEkQJ0pDZr8EoO7Z6Cls513chy1h
 H+yoELHu6StmI6FcTtqcuayRStvgzcGHv94eBUxwt/XM4Zs9zh5jXigJF/29WOZMSfwXcMskji7
 9iwOn
X-Gm-Gg: AfdE7clYsDdR3Hppbud8Pg1MvH3CF47rgEp34ShFPmrVMbEIQ3lrHs1tUc61qv+7nnd
 7BP8P5EquiNQailjCo5ou2iqdMPCvKNjaxWMtL8lT+2xFcPMX7RNv/eh4QyoZfKc+SnFWis53lx
 2PPaQUqKjvYDz467kwpdgfcZqsUsDp9VwYJYWpcz3Q+tVgXr3b8IxXi1EL1VdAd839EalntUx8j
 8a30vi5tDaUN6e2WwH7evNVp/9Sem6IQ46itf5M/9QVNiM2d9QPa8vRfjLwvRxEHzX4C/MKf6sY
 c4Xf2/gl8ycZQ3mstqsY8H24cQLcTEx1IP2I/CtlnsH12+1kwgI+Y59PeqkBtAVuLIzv8Uqhii4
 aScidWo2/HN6aE47k31omqJjHDv3h82/rl0PI6mf6KfeDznG3GuA3KxfDKWg9qaQgqUNBnPLifF
 90dISems88G9XRecWr1g==
X-Received: by 2002:a17:90b:3b89:b0:387:e0db:3fad with SMTP id
 98e67ed59e1d1-38dc7778aedmr450010a91.38.1783717068048; 
 Fri, 10 Jul 2026 13:57:48 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a58792cdasm3256221a91.16.2026.07.10.13.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:57:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 44/51] accel/tcg: Remove TCGCPUOps.adjust_watchpoint_address
Date: Fri, 10 Jul 2026 13:53:54 -0700
Message-ID: <20260710205401.836304-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h | 5 -----
 include/hw/core/cpu.h       | 2 --
 accel/tcg/watchpoint.c      | 6 ------
 3 files changed, 13 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 734bcd537b..a232288152 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -249,11 +249,6 @@ struct TCGCPUOps {
                                            MMUAccessType access_type,
                                            int mmu_idx, uintptr_t retaddr);
 
-    /**
-     * @adjust_watchpoint_address: hack for cpu_check_watchpoint (used by ARM)
-     */
-    vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr addr, int len);
-
     /**
      * @debug_check_watchpoint: return true if the architectural
      * watchpoint whose address has matched should really fire.
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5401d7c14b..c4c86b8595 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -139,8 +139,6 @@ struct SysemuCPUOps;
  * to GDB. The returned value is expected to be a simple constant string:
  * the caller will not g_free() it.
  * @disas_set_info: Setup architecture specific components of disassembly info
- * @adjust_watchpoint_address: Perform a target-specific adjustment to an
- * address before attempting to match it against watchpoints.
  * @deprecation_note: If this CPUClass is deprecated, this field provides
  *                    related information.
  * @max_as: Maximum valid index used to refer to the address spaces supported by
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index f96ffc018d..b8a49b7567 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -68,12 +68,6 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
         return;
     }
 
-    if (cpu->cc->tcg_ops->adjust_watchpoint_address) {
-        /* this is currently used only by ARM BE32 */
-        addr = cpu->cc->tcg_ops->adjust_watchpoint_address(cpu, addr, len);
-        last = addr + len - 1;
-    }
-
     assert((flags & ~BP_MEM_ACCESS) == 0);
 
     for (n = interval_tree_iter_first(&cpu->watchpoints, addr, last); n;
-- 
2.43.0


