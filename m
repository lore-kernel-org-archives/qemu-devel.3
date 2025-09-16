Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7E4CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya4R-0002z5-DW; Tue, 16 Sep 2025 14:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4M-0002gP-IT
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:22 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4K-0001Z8-KW
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:22 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45dcff2f313so36462335e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045979; x=1758650779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7fb8C6jKVF8IguArqYccsarl7uaiPckC2N324fDKSOw=;
 b=Xxz4JIzJHOoq8nB/foZJ8PfZqYixhb6Mg3T2F17Kpyi/kHQB5chsTyyiXkANdJmkUm
 elAAkezzWRMsMeadRjh1Ocm95wSkdt3T9hZB02kU0fAlfp0KAu9A+fSZXVZ5DSsE3MF3
 6thV0yRZgu5J35klEteq3u01QL7bUvD5d64SDe0O1Bw+33c0FlrEZKuDvk/YD84OHbxN
 lC8pdfJM6nhakaU+AKLFCKAucSa0qf8vdo5kkktVwZ0Cs45afY+C9RSaLlLHu41BkbLE
 f+QMXBIYhIsWYBUUMXUcl54ypFL7ekB3eGwy6pKm1sWDFIZzmM+I4pPcfXDgzGYRKfDg
 zf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045979; x=1758650779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7fb8C6jKVF8IguArqYccsarl7uaiPckC2N324fDKSOw=;
 b=QHFIDw7e1AbrBq5v01sBKhJvhwXKDy4YisEDLiN3pFna/bDHV0c3Z1GqhQ1gw3QrDU
 qGLjdRq1UbOvkWuisjVTH4MvUgCtbtTf0fblWQMjgXKgUaZx7HqhJ1qEqo3Ims4UL+HT
 AxJl2qLJynY6Fo3inhIYUOUEkBwIJmKgZFI8gJsMw6Bta3G9Q067yWI82e+d+VTeYTO0
 o1hAbnPqm80yMYkgbxwNcww7cw8qr1URgbUOTiPI0xPb/73HpM39Mf4fGftgGiWfrvxQ
 EpIbCAlZeFr93PlSbEIGwo3L9STC+GCSlM8J74xYQ2f+2o7I3Og0nDaaka1awhyYN8Z5
 sVFg==
X-Gm-Message-State: AOJu0YwYSr8T1MAgnhphh6imTAWksfP6sA8MFBBsQ1v7S1WUam08pFOs
 dIiTgdaSqIBdPGmbuvn7eMyUxYvYHbsT6ayT9L4lPtemJ0AdSGcwKW5O4+zflqQuctWelvbYUrm
 aG/2Y
X-Gm-Gg: ASbGncvX+sdRZQDYHXDCOzzYIy1sO5bi6BR+LHUmWC675dbX8cS7p3IuPdB1Qo0G6zE
 fj53obiSZDqBLv1vTRgy9Zorr40S1VaOl7ixzzNErt3JQs+zLE7dG5EjjXwUkxXSOq1xoG+xnHG
 CXceSn37wBUpHliUZ5Q9aNHIdAHyt7WYfIuxVfrp3ankZiYSX88SXuJJO6sNv2iHRlDHNgf+iyO
 eOBbZTsVkc7hqP+n/zxEd3QdqKzrfhExkEGmzygPVjANo56XmrpB3wpKeFhMXa0sC1kwGs9AC9M
 IiNiYpbDgKdeJShzcnrwhtK7BhaKhvtYcZDzLrL/MAkKCRIn8Bo6jqnckRHTvOTwt8bU8M+QGHw
 cIR4IqF/4B/iE4OhkwXWPfQEuBRVn
X-Google-Smtp-Source: AGHT+IH6BLPVS2oi6VlLUZ0LJhSx7Z+YA0GWhA8qtEgwrfDULVq0spRX3WjF+CEOIGdc3pSDr4YFiw==
X-Received: by 2002:a05:600c:828c:b0:45d:98be:ee95 with SMTP id
 5b1f17b1804b1-45f211caa67mr151008285e9.3.1758045978889; 
 Tue, 16 Sep 2025 11:06:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/36] target/arm: Add prot_check parameter to pmsav8_mpu_lookup
Date: Tue, 16 Sep 2025 19:05:39 +0100
Message-ID: <20250916180611.1481266-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Separate the access_type from the protection check.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250830054128.448363-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h    |  5 +++--
 target/arm/ptw.c          | 11 ++++++-----
 target/arm/tcg/m_helper.c |  4 ++--
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index f5a1e75db37..899242e572f 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1624,8 +1624,9 @@ bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
     __attribute__((nonnull));
 
 bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
-                       MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                       bool is_secure, GetPhysAddrResult *result,
+                       MMUAccessType access_type, unsigned prot_check,
+                       ARMMMUIdx mmu_idx, bool is_secure,
+                       GetPhysAddrResult *result,
                        ARMMMUFaultInfo *fi, uint32_t *mregion);
 
 void arm_log_exception(CPUState *cs);
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index ed5c728eab6..9652f40ff82 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2561,8 +2561,9 @@ static uint32_t *regime_rlar(CPUARMState *env, ARMMMUIdx mmu_idx,
 }
 
 bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
-                       MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                       bool secure, GetPhysAddrResult *result,
+                       MMUAccessType access_type, unsigned prot_check,
+                       ARMMMUIdx mmu_idx, bool secure,
+                       GetPhysAddrResult *result,
                        ARMMMUFaultInfo *fi, uint32_t *mregion)
 {
     /*
@@ -2750,7 +2751,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
     if (arm_feature(env, ARM_FEATURE_M)) {
         fi->level = 1;
     }
-    return !(result->f.prot & (1 << access_type));
+    return (prot_check & ~result->f.prot) != 0;
 }
 
 static bool v8m_is_sau_exempt(CPUARMState *env,
@@ -2952,8 +2953,8 @@ static bool get_phys_addr_pmsav8(CPUARMState *env,
         }
     }
 
-    ret = pmsav8_mpu_lookup(env, address, access_type, mmu_idx, secure,
-                            result, fi, NULL);
+    ret = pmsav8_mpu_lookup(env, address, access_type, 1 << access_type,
+                            mmu_idx, secure, result, fi, NULL);
     if (sattrs.subpage) {
         result->f.lg_page_size = 0;
     }
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 28307b56151..d856e3bc8e2 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -2829,8 +2829,8 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
         ARMMMUFaultInfo fi = {};
 
         /* We can ignore the return value as prot is always set */
-        pmsav8_mpu_lookup(env, addr, MMU_DATA_LOAD, mmu_idx, targetsec,
-                          &res, &fi, &mregion);
+        pmsav8_mpu_lookup(env, addr, MMU_DATA_LOAD, PAGE_READ, mmu_idx,
+                          targetsec, &res, &fi, &mregion);
         if (mregion == -1) {
             mrvalid = false;
             mregion = 0;
-- 
2.43.0


