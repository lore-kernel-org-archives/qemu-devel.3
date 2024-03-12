Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331D2C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5WR-0000su-Oq; Tue, 12 Mar 2024 13:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Ub-0006Mq-DD; Tue, 12 Mar 2024 13:00:48 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5UZ-0008S0-HW; Tue, 12 Mar 2024 13:00:45 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e55731af5cso3023720b3a.0; 
 Tue, 12 Mar 2024 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262841; x=1710867641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1WSS859ppO453pGVNhu4iKbtEfJ5LrxUVyPjlrAMcE=;
 b=P/xoBKkjSDDS+BKAcGAr9JcJEqDvuFDFBlBFb4Mgby5VfBOkBNBQzpi0zx1SQqJfZD
 HDSQC9oUtyawr3bx4imwTI7HpAdJ0o1sc2DBlpOPjqRvxTbCtVjMf5AKcgmAR4sAnSZq
 D2G8Z6i6zMiVFib3DJ3wzOPetXKnsnz4+xotfppueqvIRfb0mDZ75YOKWGKo5Xw2a+qV
 CUwonHrnMaJvtbmTZrrNkMgKxzT4F6hHKK4cDWKJFpU9+vgHT0gUPgb21BevBUYy+DRg
 P4IuP2x1W7jzh8GtfUEE8gY/+omne09B9k/YKSH9XhUauOcRRObo3sl/aJiqLoC2mG1L
 cUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262841; x=1710867641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F1WSS859ppO453pGVNhu4iKbtEfJ5LrxUVyPjlrAMcE=;
 b=xDxtncNyfme6Y1Y2TQMMb35c61f1NLPE6Q90ewco1LgZY1ctD1PP2/h8+rcRiY3YcB
 AxODHl9n71+ITQhkMR/CZY1jsL/iKZMq1TywFiPG1ASGUCUbtSt4zenIUkroE7QpCnxb
 GRdtn6uvPGBcNd8eLR/Xmq/phzYrLQYzhW3bpxIHHQZM+lHYqwjUYHKwirTVmvO6DLOb
 M1qhETDkfswDbiTvFPkv2meFw3UQY9t0kYmOebaF/YcJOT9cE/zKpOIe9u88GwWgKVFF
 0MUSlQfqhD0NvqTRvm/9SNmoZPLToLWLAVoA+rNe8uEN2ZcceX6kHTuxrFI/IDlObSa9
 hnGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzblY6F6Y9cEnN9+3aq0iBxCjvNd1d0nn+TBD4dDwcNkRuciFqyx08CVOrNgzc8junDIDGwaDfPnAbDGBHxc4t3TGj
X-Gm-Message-State: AOJu0Yx8LY+tHzT+7f47wBEPoxbfc6QZXBANB3ZT/ZB/xFo7BEbh6FI8
 //9QO30uH27Dgstr4JzW81KuHYusakRV7rZyoujrubSQmnAdvhl7hLOLs9Wfhfc=
X-Google-Smtp-Source: AGHT+IFkqRswDGTa2+iWUSxZpSrlPg9KFrz4LA/N0SJaxFFhK//tGMwK+7xHkg1zRKwoLgyXkYtx2g==
X-Received: by 2002:a05:6a00:c8b:b0:6e6:a004:aaf1 with SMTP id
 a11-20020a056a000c8b00b006e6a004aaf1mr38003pfv.1.1710262840870; 
 Tue, 12 Mar 2024 10:00:40 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.10.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:00:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Michael Neuling <mikey@neuling.org>
Subject: [PULL 27/38] spapr: nested: Introduce SpaprMachineStateNested to
 store related info.
Date: Wed, 13 Mar 2024 02:58:38 +1000
Message-ID: <20240312165851.2240242-28-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

Currently, nested_ptcr is being used by existing nested-hv API to store
nested guest related info. This need to be organised to extend support
for the nested PAPR API which would need to store additional info
related to nested guests in next series of patches.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_nested.c         | 8 ++++----
 include/hw/ppc/spapr.h        | 3 ++-
 include/hw/ppc/spapr_nested.h | 5 +++++
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index f7888ca8bd..c2a33fc3a9 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -25,8 +25,8 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
 
     assert(lpid != 0);
 
-    patb = spapr->nested_ptcr & PTCR_PATB;
-    pats = spapr->nested_ptcr & PTCR_PATS;
+    patb = spapr->nested.ptcr & PTCR_PATB;
+    pats = spapr->nested.ptcr & PTCR_PATS;
 
     /* Check if partition table is properly aligned */
     if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
@@ -63,7 +63,7 @@ static target_ulong h_set_ptbl(PowerPCCPU *cpu,
         return H_PARAMETER;
     }
 
-    spapr->nested_ptcr = ptcr; /* Save new partition table */
+    spapr->nested.ptcr = ptcr; /* Save new partition table */
 
     return H_SUCCESS;
 }
@@ -195,7 +195,7 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
     struct kvmppc_pt_regs *regs;
     hwaddr len;
 
-    if (spapr->nested_ptcr == 0) {
+    if (spapr->nested.ptcr == 0) {
         return H_NOT_AVAILABLE;
     }
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 78a736297b..0eb01ea6fd 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -12,6 +12,7 @@
 #include "hw/ppc/spapr_xive.h"  /* For SpaprXive */
 #include "hw/ppc/xics.h"        /* For ICSState */
 #include "hw/ppc/spapr_tpm_proxy.h"
+#include "hw/ppc/spapr_nested.h" /* For SpaprMachineStateNested */
 
 struct SpaprVioBus;
 struct SpaprPhbState;
@@ -213,7 +214,7 @@ struct SpaprMachineState {
     uint32_t vsmt;       /* Virtual SMT mode (KVM's "core stride") */
 
     /* Nested HV support (TCG only) */
-    uint64_t nested_ptcr;
+    SpaprMachineStateNested nested;
 
     Notifier epow_notifier;
     QTAILQ_HEAD(, SpaprEventLogEntry) pending_events;
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 1df1ce14f6..2488ea98da 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -3,6 +3,10 @@
 
 #include "target/ppc/cpu.h"
 
+typedef struct SpaprMachineStateNested {
+    uint64_t ptcr;
+} SpaprMachineStateNested;
+
 /*
  * Register state for entering a nested guest with H_ENTER_NESTED.
  * New member must be added at the end.
@@ -96,6 +100,7 @@ struct nested_ppc_state {
 };
 
 void spapr_exit_nested(PowerPCCPU *cpu, int excp);
+typedef struct SpaprMachineState SpaprMachineState;
 bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
                               target_ulong lpid, ppc_v3_pate_t *entry);
 #endif /* HW_SPAPR_NESTED_H */
-- 
2.42.0


