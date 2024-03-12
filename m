Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB25AC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5WU-00016R-Eb; Tue, 12 Mar 2024 13:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5UZ-0006Ll-Ut; Tue, 12 Mar 2024 13:00:48 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5UW-0008RM-3Q; Tue, 12 Mar 2024 13:00:43 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e6aa5c5a6fso140188b3a.0; 
 Tue, 12 Mar 2024 10:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262837; x=1710867637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uGGK8C7KiRqAJNCTwSuiIvTju4WLaHuX/qCVDSVsKBE=;
 b=DIUoquRR8It3DNhZiysoa1RT8UZAZH9VkL+LCoS2PzhvJFJbc5xDOxZIGv1z2VseaH
 WmdkKGJEj1uq905h4uJjOsbmlpI8KDEAZZNcBqyi4IlIF31Bnc2196KZGc9mTRp2uPpM
 EVbd7v3fM0E6riqL+CCCf75csibKu1htiZuYCCx+4lPwsCzTlBTYiXM62gS+vigUqwwF
 lFQx1euUbEm4i8Kjuw0fxGRrHCfC282bzP0OLEhRTHTdDB20H+4mqwAbbL3Dw/xD2TnR
 N2MVkIfsRx05EWDNkTRGPBvKsjpZQo5oHtWPZPbkAFfgV/90BdVrmyIYZfO6XOR9ZtQO
 0gzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262837; x=1710867637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uGGK8C7KiRqAJNCTwSuiIvTju4WLaHuX/qCVDSVsKBE=;
 b=a6eUeM5kaYFeXLIc8++926aHDgIh8b9jii8sguFhMDu4qztlr2wlTp3IPENdc+FGwt
 Q5xeCYOROXKxMGihWg3KBPXNb6UxZcPEbWp1eJbQXiXKuJFvAV6lPpMeq2/9e4WLhxbm
 RDx0EAwzB7yYQ0BFYANy8QLXKhPKr2i9uRb6RJQTzLwVbrt3jGInJchVZ400vacFDd7J
 nuAYFlE4qp/t04ynN4zjSJxTVeh3lF6pfrxgzvlwKMb1mveLDHckERuYIOmQFJWpUGiH
 EGE+RE0/cR3AQzUjIdyD6nQgWb62goVGXBVy7JnMWtMtQk36c9h8bN2DpsTYPDfsNsE8
 K7IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQkXXApgqTNVbqmu93IifMywhJR36xuXUaRDtaaIJVUySrukzi0FVKvmrZxah4BITfuMbzwO67KkdX46Nv1zYSeDf7
X-Gm-Message-State: AOJu0Ywa09/w/lsyMMDfG8634V2kVRfXBlfNP4x5vPnRlWtoPVOmYUQR
 aTdQS3NhWH5lBwU7bfrdMnO1OALLy+RpJyACbmr5fm2EJrB1UH3c6DAkDg1V9WA=
X-Google-Smtp-Source: AGHT+IHEiM1rcQH28G0DHhxvsQVUa4KMN5aAccVNQHWbOedj2EaqakMWn8GNV90lgM1+j5qE545adg==
X-Received: by 2002:a05:6a00:841:b0:6e6:8c49:f2f6 with SMTP id
 q1-20020a056a00084100b006e68c49f2f6mr35034pfk.24.1710262837166; 
 Tue, 12 Mar 2024 10:00:37 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.10.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:00:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 26/38] spapr: nested: move nested part of spapr_get_pate into
 spapr_nested.c
Date: Wed, 13 Mar 2024 02:58:37 +1000
Message-ID: <20240312165851.2240242-27-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Most of the nested code has already been moved to spapr_nested.c
This logic inside spapr_get_pate is related to nested guests and
better suited for spapr_nested.c, hence moving there.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c                | 28 ++-------------------------
 hw/ppc/spapr_nested.c         | 36 +++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_nested.h |  3 ++-
 3 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7321c35174..ff429d0ffe 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1407,7 +1407,6 @@ void spapr_init_all_lpcrs(target_ulong value, target_ulong mask)
     }
 }
 
-
 static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
                            target_ulong lpid, ppc_v3_pate_t *entry)
 {
@@ -1420,33 +1419,10 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
         /* Copy PATE1:GR into PATE0:HR */
         entry->dw0 = spapr->patb_entry & PATE0_HR;
         entry->dw1 = spapr->patb_entry;
-
+        return true;
     } else {
-        uint64_t patb, pats;
-
-        assert(lpid != 0);
-
-        patb = spapr->nested_ptcr & PTCR_PATB;
-        pats = spapr->nested_ptcr & PTCR_PATS;
-
-        /* Check if partition table is properly aligned */
-        if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
-            return false;
-        }
-
-        /* Calculate number of entries */
-        pats = 1ull << (pats + 12 - 4);
-        if (pats <= lpid) {
-            return false;
-        }
-
-        /* Grab entry */
-        patb += 16 * lpid;
-        entry->dw0 = ldq_phys(CPU(cpu)->as, patb);
-        entry->dw1 = ldq_phys(CPU(cpu)->as, patb + 8);
+        return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
     }
-
-    return true;
 }
 
 #define HPTE(_table, _i)   (void *)(((uint64_t *)(_table)) + ((_i) * 2))
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 8e0ee0d22f..f7888ca8bd 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -6,6 +6,7 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/spapr_nested.h"
+#include "mmu-book3s-v3.h"
 
 void spapr_nested_reset(SpaprMachineState *spapr)
 {
@@ -16,6 +17,35 @@ void spapr_nested_reset(SpaprMachineState *spapr)
 }
 
 #ifdef CONFIG_TCG
+
+bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                              target_ulong lpid, ppc_v3_pate_t *entry)
+{
+    uint64_t patb, pats;
+
+    assert(lpid != 0);
+
+    patb = spapr->nested_ptcr & PTCR_PATB;
+    pats = spapr->nested_ptcr & PTCR_PATS;
+
+    /* Check if partition table is properly aligned */
+    if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
+        return false;
+    }
+
+    /* Calculate number of entries */
+    pats = 1ull << (pats + 12 - 4);
+    if (pats <= lpid) {
+        return false;
+    }
+
+    /* Grab entry */
+    patb += 16 * lpid;
+    entry->dw0 = ldq_phys(CPU(cpu)->as, patb);
+    entry->dw1 = ldq_phys(CPU(cpu)->as, patb + 8);
+    return true;
+}
+
 #define PRTS_MASK      0x1f
 
 static target_ulong h_set_ptbl(PowerPCCPU *cpu,
@@ -413,4 +443,10 @@ void spapr_unregister_nested_hv(void)
 {
     /* DO NOTHING */
 }
+
+bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                              target_ulong lpid, ppc_v3_pate_t *entry)
+{
+    return false;
+}
 #endif
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 09d95182b2..1df1ce14f6 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -96,5 +96,6 @@ struct nested_ppc_state {
 };
 
 void spapr_exit_nested(PowerPCCPU *cpu, int excp);
-
+bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                              target_ulong lpid, ppc_v3_pate_t *entry);
 #endif /* HW_SPAPR_NESTED_H */
-- 
2.42.0


