Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE50C71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 21:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYszJ-0000mj-UY; Mon, 07 Jul 2025 17:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsLB-0005Hp-Gp
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:30 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsL9-0004IX-K1
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:29 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4a9741b513eso76887041cf.1
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 13:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751919686; x=1752524486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39P8VwpVLIfAbJ0MKK9p00r7QAC2cXfVTIDM3C9j734=;
 b=sF4H6B9zyYDdjs3QnoE2CKA0OvXwVseq+38UBpvLqWyLPdaeQZRUG6gvNSxH2WiY0j
 CetSDmDhVuAbynU6F6cijlCQYyNCPKlL0dbw8CP7Aw6Dg0e86L/0A9VmspXdJdySHDki
 8Y5m/bjpnbKGd9zrqqhWW3NlsvfmE6gt0pZEphOOynkE6TyNDgxepi7rrnnYyQEgG0H/
 EwHWYXjsaXH0eTCS9Zwk3kKyrdicfHeq73ZB9XghfmNWtMDmLS4zZ5Lxr9RIIlAK7t8Z
 l0nOCNgyPtwTqQvwzABkLUDJ0Lcw/sD1ISj8l1eyREmoeqSjV4d9SlEZ3S223If6dg4l
 XsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751919686; x=1752524486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=39P8VwpVLIfAbJ0MKK9p00r7QAC2cXfVTIDM3C9j734=;
 b=Exl/qCd8rHnHGIs1jg2Y2FImlWUR8hOpkGSDeDRjoCURyHvAisujcA6ADSIqvnuNL8
 QZyZa3Zq3/S15T25lziH0cwjany4zWuH1hjFbZBLtbA/VLlCxJrhmW6R19uUWVFeqw/m
 Q9kd6tzgaeLO8ErIBKyi5on22Q9CJ+NSkuMFDHbjjCJuj/nsCvYuAZNCWYQWlJKN3T/W
 pBvIpWbz9vdS5nj68/7+yZNKoywBxM/Qz61jNLlWuA4EZlIhOWBqrPgKHTaslXF3qrmE
 z9YrSR35RdXXnpsvidFVDUl8v4yrSodwYZjQ+oL+1M6JroeVaBfwvyHBA7UUMvwt6v6X
 SmBA==
X-Gm-Message-State: AOJu0Yw19xC1tD8ZT39B4QLBcRakLXxKQTzBPpd2UghRA4pWNyCsPFjI
 7GkrtilB0UqlxgNx5EVrcgHze2JaDrWE1lLn5miF6p6jvKogMcmpkxgB/qZu6vyhDrEb1DDrT6j
 yJ1BYB/8=
X-Gm-Gg: ASbGncs5GgvuzQ3wuWla/0pJObcxnlx/CZoxbhVn39o8bazm2Pwy8wiX0FZoeejTTPS
 2ctZj0U7AwYl3hXWkPQrC3eVmBfXWD+1l5CPf1F8HLHMXHihEW2P7y70d2FbIITHD2oW6AYOfO4
 JHwcjL2lD/y5Dx/DgPULjitR4rodxyOyGDDua1Spj4/T2BsgviF00/MB7NVRVk2hhNXg44fCSY8
 v113xbs2kWfoOm8OmjOrN3ywZu4WkLRbD0jZVg8DcfLP0c+el3woNoJSTbOaqXEpspUzXin2kcs
 qvh06HyDgKgJWX12YmooSCQkjGsGtauHP+obEckrRIS1lUO/L+QVPoCtJXqppAzg2SV+7UFv+67
 FXKJPwwr3MBTzFsYW
X-Google-Smtp-Source: AGHT+IHYn0BMjkKpe9MlSSuW87004TOHH0LyNw+ZiGNipRMRa1VpCvjECYgi5N87l4Rk8zaNGhPy2g==
X-Received: by 2002:a05:622a:4e08:b0:4a4:3b41:916c with SMTP id
 d75a77b69052e-4a9cc6ad7femr12312151cf.17.1751919686264; 
 Mon, 07 Jul 2025 13:21:26 -0700 (PDT)
Received: from stoup.. ([172.58.142.143]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a78dd4sm69050351cf.51.2025.07.07.13.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 13:21:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 06/20] target/arm: Convert pmsav8_mpu_lookup to access_perm
Date: Mon,  7 Jul 2025 14:20:57 -0600
Message-ID: <20250707202111.293787-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707202111.293787-1-richard.henderson@linaro.org>
References: <20250707202111.293787-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h    | 2 +-
 target/arm/ptw.c          | 6 +++---
 target/arm/tcg/m_helper.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index c4765e4489..629aa7bc23 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1606,7 +1606,7 @@ bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
     __attribute__((nonnull));
 
 bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
-                       MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                       unsigned access_perm, ARMMMUIdx mmu_idx,
                        bool is_secure, GetPhysAddrResult *result,
                        ARMMMUFaultInfo *fi, uint32_t *mregion);
 
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index b71c963f67..a11df31b18 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2561,7 +2561,7 @@ static uint32_t *regime_rlar(CPUARMState *env, ARMMMUIdx mmu_idx,
 }
 
 bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
-                       MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                       unsigned access_perm, ARMMMUIdx mmu_idx,
                        bool secure, GetPhysAddrResult *result,
                        ARMMMUFaultInfo *fi, uint32_t *mregion)
 {
@@ -2750,7 +2750,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
     if (arm_feature(env, ARM_FEATURE_M)) {
         fi->level = 1;
     }
-    return !(result->f.prot & (1 << access_type));
+    return access_perm & ~result->f.prot;
 }
 
 static bool v8m_is_sau_exempt(CPUARMState *env,
@@ -2952,7 +2952,7 @@ static bool get_phys_addr_pmsav8(CPUARMState *env,
         }
     }
 
-    ret = pmsav8_mpu_lookup(env, address, access_type, mmu_idx, secure,
+    ret = pmsav8_mpu_lookup(env, address, 1 << access_type, mmu_idx, secure,
                             result, fi, NULL);
     if (sattrs.subpage) {
         result->f.lg_page_size = 0;
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 6614719832..220a3b472f 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -2820,7 +2820,7 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
         ARMMMUFaultInfo fi = {};
 
         /* We can ignore the return value as prot is always set */
-        pmsav8_mpu_lookup(env, addr, MMU_DATA_LOAD, mmu_idx, targetsec,
+        pmsav8_mpu_lookup(env, addr, PAGE_READ, mmu_idx, targetsec,
                           &res, &fi, &mregion);
         if (mregion == -1) {
             mrvalid = false;
-- 
2.43.0


