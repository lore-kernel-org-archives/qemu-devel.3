Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E639C83030
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 21:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYt0a-0004Eg-4i; Mon, 07 Jul 2025 17:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsLL-0005NM-Pt
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:50 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsLJ-0004L1-T4
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:39 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7d9e2f85b2cso34665285a.2
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 13:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751919696; x=1752524496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Nul40+dgiHaLOzX7hjn+6zDcctExYo7C9aAP6bNzfk=;
 b=L18O2ay34ErW5CDA7R2SSWiA2nsdSPVRRYFDfEZPW6mpBhfp++eDok8TqBzKrkwaAK
 YvQTB1Jqp+XQvkfVYXMJjWzoZNleuAPxTFU3grnx41stY946tLgKbvw7UyNzV/RwgMmg
 FU/WT9YZeJqdWo4dZDFpFi+bSgGeBTpWgeailKgaOis16xVMWNnfZDGpOKjPH7k0eMVR
 YenAKvfivw3NAc47w+fp42+KWGSEZQCP7lyop+MFHVoYCOFyY8ZdjJOVwu0Ry8ET8/FD
 ao/g48FvLUWgLYE+VHml1swHMJW3It5u9QUE2uv1NRb2lOyxawuFbKspX7QCeA/vesS4
 dyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751919696; x=1752524496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Nul40+dgiHaLOzX7hjn+6zDcctExYo7C9aAP6bNzfk=;
 b=TIZ8xqnmn0WUoaQBLT5QZAU6Y6C6Gcod6OuBVdAUTCeqqmLkt664iIvjWOnyU8wY1Y
 Xwgc7WU3CoRHWbnZR+z/UVo0W2da1dJsxg99ocV5odPRakwUy6apAT2xVcNxtII7aO/m
 aQw/S+gippe8tqJQW3Jok7XNZYQS4wQtYKkxPhY7XU8yQx4AwQ01QFRYfv6Lj4rqmPy+
 yt+tbZAKbBvJW8OQxJGKEkGLEqyJg9I6m+lhcyrSodailvfqsYbzLcJXGu/fBz78mia/
 aG8ncWyRcegqiHlH7q/fWPwFcphVwVTi+F69M2rjOr6y3/81GIMwUSXY4KCoQJfcnhCj
 XakQ==
X-Gm-Message-State: AOJu0YwsjDhK6C5K5oJaGGiAmOpCW/CEf66Dzvcfb02GTR+HMKMR9Lzv
 gxmG8tYS9T2wC9lWOHzDPatCspdijG7OR25A4RKcu1tkJaRlPi4Ws3jR8VfBagbzTGMZJ568X8X
 OW8PNHwk=
X-Gm-Gg: ASbGncsgXRpUGZ34qVZu5CybP5Z7t3o1zquWh/7UjkLQwggDR+qC5oXo/UB0IzasUnY
 JV5V9zvRUKwCiRLTLY9GRGxU5Y2XKndix9Uz+PrAfTX/ScuE65Mm5fowlIB/tPJbE+wtnvwjpHq
 LkwL9FvwCMYxCB/HX1b7FgbMjhzA8I4N5L5gZpgtzHea+756kxfCz3EcD5z8kXC9KcO/yX3FL/C
 Zl8x0iTXfSiUY82oNs/hpShjnq8J06rc08hibufs6IqdZtCQqQ+9kbO9uPrKJ+dSuPmxCeUnU4v
 oCE7rvH8YTOIMMBpm3MtG8rAuNHD0kWwhT1P+M/llEzCx0lwTjTQnAn6W0jcuJP2I/cCXSZWktj
 of5Ndwo+UZGpFCqaU
X-Google-Smtp-Source: AGHT+IGjlhvXpQcylwkHIcT0x4O8VpWvDpMhq95vAyF72ak7bs+5o1e23ePiQWFrTV8elA5QLDD0Kg==
X-Received: by 2002:a05:620a:3904:b0:7d3:e710:1d3 with SMTP id
 af79cd13be357-7d5dcc72e1dmr2004169785a.7.1751919695420; 
 Mon, 07 Jul 2025 13:21:35 -0700 (PDT)
Received: from stoup.. ([172.58.142.143]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a78dd4sm69050351cf.51.2025.07.07.13.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 13:21:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 11/20] target/arm: Convert get_phys_addr_nogpc to access_perm
Date: Mon,  7 Jul 2025 14:21:02 -0600
Message-ID: <20250707202111.293787-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707202111.293787-1-richard.henderson@linaro.org>
References: <20250707202111.293787-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x731.google.com
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

Because of the recursion with get_phys_addr_twostage,
we must convert the two functions at the same time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 5b8040a174..fef9e9a7cb 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -74,7 +74,7 @@ typedef struct S1Translate {
 
 static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
                                 vaddr address,
-                                MMUAccessType access_type, MemOp memop,
+                                unsigned access_perm, MemOp memop,
                                 GetPhysAddrResult *result,
                                 ARMMMUFaultInfo *fi);
 
@@ -3276,7 +3276,7 @@ static bool get_phys_addr_disabled(CPUARMState *env,
 
 static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
                                    vaddr address,
-                                   MMUAccessType access_type, MemOp memop,
+                                   unsigned access_perm, MemOp memop,
                                    GetPhysAddrResult *result,
                                    ARMMMUFaultInfo *fi)
 {
@@ -3288,7 +3288,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     ARMSecuritySpace ipa_space;
     uint64_t hcr;
 
-    ret = get_phys_addr_nogpc(env, ptw, address, access_type,
+    ret = get_phys_addr_nogpc(env, ptw, address, access_perm,
                               memop, result, fi);
 
     /* If S1 fails, return early.  */
@@ -3315,7 +3315,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     cacheattrs1 = result->cacheattrs;
     memset(result, 0, sizeof(*result));
 
-    ret = get_phys_addr_nogpc(env, ptw, ipa, access_type,
+    ret = get_phys_addr_nogpc(env, ptw, ipa, access_perm,
                               memop, result, fi);
     fi->s2addr = ipa;
 
@@ -3383,7 +3383,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
 
 static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
                                       vaddr address,
-                                      MMUAccessType access_type, MemOp memop,
+                                      unsigned access_perm, MemOp memop,
                                       GetPhysAddrResult *result,
                                       ARMMMUFaultInfo *fi)
 {
@@ -3404,7 +3404,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     case ARMMMUIdx_Phys_Root:
     case ARMMMUIdx_Phys_Realm:
         /* Checking Phys early avoids special casing later vs regime_el. */
-        return get_phys_addr_disabled(env, ptw, address, 1 << access_type,
+        return get_phys_addr_disabled(env, ptw, address, access_perm,
                                       result, fi);
 
     case ARMMMUIdx_Stage1_E0:
@@ -3445,7 +3445,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
         ptw->in_mmu_idx = mmu_idx = s1_mmu_idx;
         if (arm_feature(env, ARM_FEATURE_EL2) &&
             !regime_translation_disabled(env, ARMMMUIdx_Stage2, ptw->in_space)) {
-            return get_phys_addr_twostage(env, ptw, address, access_type,
+            return get_phys_addr_twostage(env, ptw, address, access_perm,
                                           memop, result, fi);
         }
         /* fall through */
@@ -3477,21 +3477,22 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
 
         if (arm_feature(env, ARM_FEATURE_V8)) {
             /* PMSAv8 */
-            ret = get_phys_addr_pmsav8(env, ptw, address, 1 << access_type,
+            ret = get_phys_addr_pmsav8(env, ptw, address, access_perm,
                                        result, fi);
         } else if (arm_feature(env, ARM_FEATURE_V7)) {
             /* PMSAv7 */
-            ret = get_phys_addr_pmsav7(env, ptw, address, 1 << access_type,
+            ret = get_phys_addr_pmsav7(env, ptw, address, access_perm,
                                        result, fi);
         } else {
             /* Pre-v7 MPU */
-            ret = get_phys_addr_pmsav5(env, ptw, address, 1 << access_type,
+            ret = get_phys_addr_pmsav5(env, ptw, address, access_perm,
                                        result, fi);
         }
-        qemu_log_mask(CPU_LOG_MMU, "PMSA MPU lookup for %s at 0x%08" PRIx32
+        qemu_log_mask(CPU_LOG_MMU, "PMSA MPU lookup for %c%c%c at 0x%08" PRIx32
                       " mmu_idx %u -> %s (prot %c%c%c)\n",
-                      access_type == MMU_DATA_LOAD ? "reading" :
-                      (access_type == MMU_DATA_STORE ? "writing" : "execute"),
+                      access_perm & PAGE_READ ? 'r' : '-',
+                      access_perm & PAGE_WRITE ? 'w' : '-',
+                      access_perm & PAGE_EXEC ? 'x' : '-',
                       (uint32_t)address, mmu_idx,
                       ret ? "Miss" : "Hit",
                       result->f.prot & PAGE_READ ? 'r' : '-',
@@ -3504,18 +3505,18 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     /* Definitely a real MMU, not an MPU */
 
     if (regime_translation_disabled(env, mmu_idx, ptw->in_space)) {
-        return get_phys_addr_disabled(env, ptw, address, 1 << access_type,
+        return get_phys_addr_disabled(env, ptw, address, access_perm,
                                       result, fi);
     }
 
     if (regime_using_lpae_format(env, mmu_idx)) {
-        return get_phys_addr_lpae(env, ptw, address, 1 << access_type,
+        return get_phys_addr_lpae(env, ptw, address, access_perm,
                                   memop, result, fi);
     } else if (arm_feature(env, ARM_FEATURE_V7) ||
                regime_sctlr(env, mmu_idx) & SCTLR_XP) {
-        return get_phys_addr_v6(env, ptw, address, 1 << access_type, result, fi);
+        return get_phys_addr_v6(env, ptw, address, access_perm, result, fi);
     } else {
-        return get_phys_addr_v5(env, ptw, address, 1 << access_type, result, fi);
+        return get_phys_addr_v5(env, ptw, address, access_perm, result, fi);
     }
 }
 
@@ -3525,7 +3526,7 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
                               GetPhysAddrResult *result,
                               ARMMMUFaultInfo *fi)
 {
-    if (get_phys_addr_nogpc(env, ptw, address, access_type,
+    if (get_phys_addr_nogpc(env, ptw, address, 1 << access_type,
                             memop, result, fi)) {
         return true;
     }
@@ -3547,7 +3548,7 @@ bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
         .in_mmu_idx = mmu_idx,
         .in_space = space,
     };
-    return get_phys_addr_nogpc(env, &ptw, address, access_type,
+    return get_phys_addr_nogpc(env, &ptw, address, 1 << access_type,
                                memop, result, fi);
 }
 
-- 
2.43.0


