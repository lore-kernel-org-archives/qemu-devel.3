Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2EFCF9C5B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfHM-0003kk-Aj; Mon, 23 Sep 2024 05:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3YTPxZggKCsoq7tr+wy9w44w1u.s426u2A-tuBu1343w3A.47w@flex--ardb.bounces.google.com>)
 id 1ssfHK-0003iI-Ri
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 05:22:46 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3YTPxZggKCsoq7tr+wy9w44w1u.s426u2A-tuBu1343w3A.47w@flex--ardb.bounces.google.com>)
 id 1ssfHJ-0005zg-0k
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 05:22:46 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6d7124939beso62099597b3.2
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 02:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1727083361; x=1727688161; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Vx0S0EoF5VOfTDD0EAY1LpxEtaebb5mReMlj7psinmA=;
 b=qzn/OgsfXDu1oH6SVFY0/sqZd1Crjmr8V+D0gKvfRPgEr0721T+ITQrX5ZUNo5c/to
 umep7xa1UhYkFFJyEYNpbjDEyLxBIZNt4VDGthIZ32D0dY2VsGAgqiwsYbHiK1LsqjEa
 5BkQ/hd4Ri++MnKZINqUOCKcKl6Tl+EwLZOC17NtwUwE7QmBJGJoKdbcIY25hga/Jtjt
 vlw0OWCX+TeBTTob+OG6fOXYtl77rsb7LIbcx1DpiSWGIbh9zc3EiBiDnZACRGPaREaF
 s4omSwSwed9sqt7IEzbE2UuorRG/tMR2EmBSU9TBJgOArUSTLnaUa+PyXuOGPJ9deq+5
 C8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083361; x=1727688161;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vx0S0EoF5VOfTDD0EAY1LpxEtaebb5mReMlj7psinmA=;
 b=pUEcQosVU1dxM3Ixgcm/m4hoLeAq3T28mcDxS40OxeM9FQQP9KQ027RoXlzwOQpAFv
 XM7FCt6MGPYr3tkym4WGilTbCwR7cSxWqgRs6424ftfqn2YPqRn6W1D7b8zS/7mwtDhg
 aeHo24I06nkq9vL/ReGc4ag0mMpCfmMGecqFIknZh6VVRztTxaWYkL18IycY7XEOedD+
 jQHoge37pkByKrFtvm2gOnDkVAZPcD4UWzjDFOjVqU+4xq0F0PNv43IehECzZCYoMj+7
 9/ZtUbZ5zvanSikLuqLbsregCjSoY3gVDYUPiLo959cpZYvOyUh1qmfJtmwI7RN7eF4S
 moYg==
X-Gm-Message-State: AOJu0YxVAAKvn384KQZGu0PeZbo+NGS2eDx+pFJOVaOIK3FXHVIUPzdG
 8IBqxnsIFzECfepp6GUrj8JclNW+gjv1AFH/sH9qmjuyyXAgbCqoA4d21INrjkqiT59ijQyoA6V
 Zr311rrvw/XIXzSQHnW6oK0algSJgROdOuzcOk9wqYle1Va0m9P5TonN+3uNEnv9CplDQ6F5Zq3
 xNeAC7vGcIyQcssdozB0S9
X-Google-Smtp-Source: AGHT+IEmnLtOyQzoPk+WaiLw0ZmerXdU3q1w8AywboU7Z64Mcfy6PWStYSLugTwQZAdah968VafN5C9K
X-Received: from palermo.c.googlers.com
 ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a81:8d50:0:b0:62f:1f63:ae4f with SMTP id
 00721157ae682-6dfeed0ead4mr947207b3.1.1727083361430; Mon, 23 Sep 2024
 02:22:41 -0700 (PDT)
Date: Mon, 23 Sep 2024 11:22:33 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240923092233.3235856-1-ardb+git@google.com>
Subject: [PATCH] target/arm: Avoid target_ulong for physical address lookups
From: Ard Biesheuvel <ardb+git@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, richard.henderson@linaro.org, 
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3YTPxZggKCsoq7tr+wy9w44w1u.s426u2A-tuBu1343w3A.47w@flex--ardb.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

So replace target_ulong with hwaddr in places where it may carry an
address value that is not representable in 32 bits.

Fixes: f3639a64f602ea ("target/arm: Use softmmu tlbs for page table walking")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 target/arm/internals.h |  4 ++--
 target/arm/ptw.c       | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index c5d7b0b492..31c82430d8 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1449,7 +1449,7 @@ typedef struct GetPhysAddrResult {
  *  * for PSMAv5 based systems we don't bother to return a full FSR format
  *    value.
  */
-bool get_phys_addr(CPUARMState *env, target_ulong address,
+bool get_phys_addr(CPUARMState *env, hwaddr address,
                    MMUAccessType access_type, ARMMMUIdx mmu_idx,
                    GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
     __attribute__((nonnull));
@@ -1468,7 +1468,7 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
  * Similar to get_phys_addr, but use the given security space and don't perform
  * a Granule Protection Check on the resulting address.
  */
-bool get_phys_addr_with_space_nogpc(CPUARMState *env, target_ulong address,
+bool get_phys_addr_with_space_nogpc(CPUARMState *env, hwaddr address,
                                     MMUAccessType access_type,
                                     ARMMMUIdx mmu_idx, ARMSecuritySpace space,
                                     GetPhysAddrResult *result,
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index defd6b84de..8ec4f7f368 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -74,13 +74,13 @@ typedef struct S1Translate {
 } S1Translate;
 
 static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
-                                target_ulong address,
+                                hwaddr address,
                                 MMUAccessType access_type,
                                 GetPhysAddrResult *result,
                                 ARMMMUFaultInfo *fi);
 
 static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
-                              target_ulong address,
+                              hwaddr address,
                               MMUAccessType access_type,
                               GetPhysAddrResult *result,
                               ARMMMUFaultInfo *fi);
@@ -3217,7 +3217,7 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
  */
 static bool get_phys_addr_disabled(CPUARMState *env,
                                    S1Translate *ptw,
-                                   target_ulong address,
+                                   hwaddr address,
                                    MMUAccessType access_type,
                                    GetPhysAddrResult *result,
                                    ARMMMUFaultInfo *fi)
@@ -3300,7 +3300,7 @@ static bool get_phys_addr_disabled(CPUARMState *env,
 }
 
 static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
-                                   target_ulong address,
+                                   hwaddr address,
                                    MMUAccessType access_type,
                                    GetPhysAddrResult *result,
                                    ARMMMUFaultInfo *fi)
@@ -3405,7 +3405,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
 }
 
 static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
-                                      target_ulong address,
+                                      hwaddr address,
                                       MMUAccessType access_type,
                                       GetPhysAddrResult *result,
                                       ARMMMUFaultInfo *fi)
@@ -3542,7 +3542,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
 }
 
 static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
-                              target_ulong address,
+                              hwaddr address,
                               MMUAccessType access_type,
                               GetPhysAddrResult *result,
                               ARMMMUFaultInfo *fi)
@@ -3558,7 +3558,7 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
     return false;
 }
 
-bool get_phys_addr_with_space_nogpc(CPUARMState *env, target_ulong address,
+bool get_phys_addr_with_space_nogpc(CPUARMState *env, hwaddr address,
                                     MMUAccessType access_type,
                                     ARMMMUIdx mmu_idx, ARMSecuritySpace space,
                                     GetPhysAddrResult *result,
@@ -3571,7 +3571,7 @@ bool get_phys_addr_with_space_nogpc(CPUARMState *env, target_ulong address,
     return get_phys_addr_nogpc(env, &ptw, address, access_type, result, fi);
 }
 
-bool get_phys_addr(CPUARMState *env, target_ulong address,
+bool get_phys_addr(CPUARMState *env, hwaddr address,
                    MMUAccessType access_type, ARMMMUIdx mmu_idx,
                    GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
 {
-- 
2.46.0.792.g87dc391469-goog


