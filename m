Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4D6CEBF7C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 07:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su58L-0005z4-Ig; Fri, 27 Sep 2024 03:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3hFr2ZggKClEtAwu+z1Cz77z4x.v759x5D-wxEx4676z6D.7Az@flex--ardb.bounces.google.com>)
 id 1su58J-0005uY-CC
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 03:11:19 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3hFr2ZggKClEtAwu+z1Cz77z4x.v759x5D-wxEx4676z6D.7Az@flex--ardb.bounces.google.com>)
 id 1su584-0001v5-3Y
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 03:11:19 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e163641feb9so4001116276.0
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 00:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1727421060; x=1728025860; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lOn6T+82Izo+xmMT9FJnB1AJP+keeTcBlNZwftIR+lo=;
 b=aUBlm+/dKEAP9pvuKWhtwas9dxUBbNokngHG5Yc8pJmvIQuggkGb/Dpyjlp37jccUE
 X1xl/VbVDS/TEHa3SU8ZCoFkv88VneaynbV6X6WfePoElyvLR6Ea4UTRqj+qRZFNr/vV
 uDfwNXVaco1TH3gF/a4218mmHz4RHDytxj+kMOdkqR2K1ELjzPxyf5zU7plxl2ID32ma
 Rl2g17e4uiiXFN5VDww1fwJNd5n3ScrLFglZtjaK6wg4mQb/Xh+66HakSNWYV4ak7HEW
 +c0RtyYp5tQS/8NwP4fkCa11bqv/pTZlzZxaK22BpMCOJ1Q2avlJ+Cx+GQZ4n0Vgc9+7
 LJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727421060; x=1728025860;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lOn6T+82Izo+xmMT9FJnB1AJP+keeTcBlNZwftIR+lo=;
 b=WGNna+Kc7z/0K6FOoyDE1FBv5s5z8AkAsoHenItRNBZtsM2jrGXX+MbMmX3XUOqitv
 gt9MNdNSZh0QHKuZsRt2ev8CNoyrHfAjEFxGlM8Byf1mzoF8oMOUmwKbu0dWDLWSD2k9
 ufHKBqwKwe/dEdZMhe0OuroItg96bPZxLRsfWTmQmUU/e/l10tTGRVOzCOTWX+PHD13X
 2lo2i+lLjiREjKr0cmd1fZ5OPepGOp/ouDXqpKUvg7ATAzNNAgtx/bvAXan/4JVt2IVJ
 cxWx4TovH2fVc6gnhPKubL61qvxXXzdSUHfAXJlK7q/xZU6E55B27H4LL+0zIxgT6aUl
 x3oA==
X-Gm-Message-State: AOJu0Yx3wEJOKPJHLhScNdVCBYD10gZhBbbFSyAVkM/BIQbjjgud1qyH
 8dDm+JIZCFFFLX4wj6QV6E0s+8knYXvzMdBLcg9MMS1H5m1Bi9ucYoHl3KLLSawb8b3jewmvCk/
 FSVAkYksYkV8/74tZo8faWDX6uvyjOlqSy9x2ElhdinqIlAQ4aGe93KD11YkS8L0wh4xms0Shwf
 p9L9IFO+A/bI61wfF4Tm6f
X-Google-Smtp-Source: AGHT+IF51thR+olJM7pmh8OUXALTIDx+KR3r1H5yPXBAvEdegdbBFQoqaxDECentujXQ+A9kFCbH2lbh
X-Received: from palermo.c.googlers.com
 ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:2d17:0:b0:e20:cfc2:a326 with SMTP id
 3f1490d57ef6-e25e6c34060mr15841276.6.1727421060114; Fri, 27 Sep 2024 00:11:00
 -0700 (PDT)
Date: Fri, 27 Sep 2024 09:10:51 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240927071051.1444768-1-ardb+git@google.com>
Subject: [PATCH v2] target/arm: Avoid target_ulong for physical address lookups
From: Ard Biesheuvel <ardb+git@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Ard Biesheuvel <ardb@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3hFr2ZggKClEtAwu+z1Cz77z4x.v759x5D-wxEx4676z6D.7Az@flex--ardb.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

From: Ard Biesheuvel <ardb@kernel.org>

target_ulong is typedef'ed as a 32-bit integer when building the
qemu-system-arm target, and this is smaller than the size of an
intermediate physical address when LPAE is being used.

Given that Linux may place leaf level user page tables in high memory
when built for LPAE, the kernel will crash with an external abort as
soon as it enters user space when running with more than ~3 GiB of
system RAM.

So replace target_ulong with vaddr in places where it may carry an
address value that is not representable in 32 bits.

Fixes: f3639a64f602ea ("target/arm: Use softmmu tlbs for page table walking")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 target/arm/internals.h |  4 ++--
 target/arm/ptw.c       | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index c5d7b0b492..1e5da81ce9 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1449,7 +1449,7 @@ typedef struct GetPhysAddrResult {
  *  * for PSMAv5 based systems we don't bother to return a full FSR format
  *    value.
  */
-bool get_phys_addr(CPUARMState *env, target_ulong address,
+bool get_phys_addr(CPUARMState *env, vaddr address,
                    MMUAccessType access_type, ARMMMUIdx mmu_idx,
                    GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
     __attribute__((nonnull));
@@ -1468,7 +1468,7 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
  * Similar to get_phys_addr, but use the given security space and don't perform
  * a Granule Protection Check on the resulting address.
  */
-bool get_phys_addr_with_space_nogpc(CPUARMState *env, target_ulong address,
+bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
                                     MMUAccessType access_type,
                                     ARMMMUIdx mmu_idx, ARMSecuritySpace space,
                                     GetPhysAddrResult *result,
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index defd6b84de..659855133c 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -74,13 +74,13 @@ typedef struct S1Translate {
 } S1Translate;
 
 static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
-                                target_ulong address,
+                                vaddr address,
                                 MMUAccessType access_type,
                                 GetPhysAddrResult *result,
                                 ARMMMUFaultInfo *fi);
 
 static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
-                              target_ulong address,
+                              vaddr address,
                               MMUAccessType access_type,
                               GetPhysAddrResult *result,
                               ARMMMUFaultInfo *fi);
@@ -3217,7 +3217,7 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
  */
 static bool get_phys_addr_disabled(CPUARMState *env,
                                    S1Translate *ptw,
-                                   target_ulong address,
+                                   vaddr address,
                                    MMUAccessType access_type,
                                    GetPhysAddrResult *result,
                                    ARMMMUFaultInfo *fi)
@@ -3300,7 +3300,7 @@ static bool get_phys_addr_disabled(CPUARMState *env,
 }
 
 static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
-                                   target_ulong address,
+                                   vaddr address,
                                    MMUAccessType access_type,
                                    GetPhysAddrResult *result,
                                    ARMMMUFaultInfo *fi)
@@ -3405,7 +3405,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
 }
 
 static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
-                                      target_ulong address,
+                                      vaddr address,
                                       MMUAccessType access_type,
                                       GetPhysAddrResult *result,
                                       ARMMMUFaultInfo *fi)
@@ -3542,7 +3542,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
 }
 
 static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
-                              target_ulong address,
+                              vaddr address,
                               MMUAccessType access_type,
                               GetPhysAddrResult *result,
                               ARMMMUFaultInfo *fi)
@@ -3558,7 +3558,7 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
     return false;
 }
 
-bool get_phys_addr_with_space_nogpc(CPUARMState *env, target_ulong address,
+bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
                                     MMUAccessType access_type,
                                     ARMMMUIdx mmu_idx, ARMSecuritySpace space,
                                     GetPhysAddrResult *result,
@@ -3571,7 +3571,7 @@ bool get_phys_addr_with_space_nogpc(CPUARMState *env, target_ulong address,
     return get_phys_addr_nogpc(env, &ptw, address, access_type, result, fi);
 }
 
-bool get_phys_addr(CPUARMState *env, target_ulong address,
+bool get_phys_addr(CPUARMState *env, vaddr address,
                    MMUAccessType access_type, ARMMMUIdx mmu_idx,
                    GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
 {
-- 
2.46.1.824.gd892dcdcdd-goog


