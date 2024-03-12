Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AB4C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5Wa-00020J-2S; Tue, 12 Mar 2024 13:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Un-0006Ta-8S; Tue, 12 Mar 2024 13:00:59 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Uk-0008UL-QA; Tue, 12 Mar 2024 13:00:56 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e6ab012eb1so791126b3a.3; 
 Tue, 12 Mar 2024 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262852; x=1710867652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D823XPpwMiJ34nimbNh5Jem7KoFIgSxF2nxMRNRXUM0=;
 b=X3MefoNFDB8j3+WSp9f38md6wuBNqrGvOZ+FRDeq+PU/cKGY/Zf328DKvfgjVyy4LU
 hLKgkiGLUqgIsepvLoRHs/tcLn8w64Cx/91ns6BR5cHtLZiUK6qAW/u+I1pkm9J0LB/X
 X+YnvCKSTTYvTXoa5GUGhQGjMnpAUzj56QTXkxM4fjf0lWWdJCUBOHKcK/oZssmjbV7I
 EXUOgi1NSTrypwXGn00baEynWJl2HIP28LGSHjAtWWxYH/+SuiRGCHlCQ/gpKcCwCzaQ
 xXZUDGlXxoeehA0tcqyDl4x1Z/IUcnYJPtV9lToXbZ06YwTxrqCAW13NndSg09EHDSD5
 AoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262852; x=1710867652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D823XPpwMiJ34nimbNh5Jem7KoFIgSxF2nxMRNRXUM0=;
 b=HsSlACGk/Ev+beS25JJWZZjJvmyP/vgp9e2GmO5RwW9xvDFlbybzqn1f+/76PS4WAv
 Ss+LidzRD5ryzYquuGmqiZ92H/i5M0tgEKMYs7jJbc3YuHGrv18WySjdGFQSwJjQunzm
 VZPPU3cOCYeEinxiS4bPkf/GBEszqd1htu8O4dtJmJMpUe7iuie0vxc5SrNvMZvR3Usz
 Uv+G9MyBfE1pb7Apd+OGlaI+mw7EjOaKQ9Y6xl3X7kCfg1iHdwdRLQ2AinMLMSy7pN65
 yItYoqnIticzEJF/2AivnJxAKLrpdhzJJrYe0YKxfFMo6llDwLDbvXhtD2ZhZMKPFBZe
 QrtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn1B/w+RVro71djlB91O9qEWzCfg4NWmHdjjabLn+60LA5w47Bly9wmF6PzKr1gWbiva+absHrRGOLc0FxHn5XUw9j
X-Gm-Message-State: AOJu0YxTUFoE+kR2VOqct+COBOs4b1/3Rajy1MjX40FALOEHImH7QB/f
 qFLsXoI+xFJfeNhb0UpqyqJsAW+CgJ735D3dUnWY9ae/RifJG5YGxISEvi5Sse0=
X-Google-Smtp-Source: AGHT+IGmiOiDuQdNm+F5+HoovQ+uw/LYqQR0k3LM1nwb67XW4ps2rTzUdBGljuGpdB/JxYOptTT97Q==
X-Received: by 2002:a05:6a00:801:b0:6e6:a3b3:923c with SMTP id
 m1-20020a056a00080100b006e6a3b3923cmr54942pfk.6.1710262852028; 
 Tue, 12 Mar 2024 10:00:52 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.10.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:00:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Amit Machhiwal <amachhiw@linux.vnet.ibm.com>
Subject: [PULL 30/38] spapr: nested: Introduce H_GUEST_[GET|SET]_CAPABILITIES
 hcalls.
Date: Wed, 13 Mar 2024 02:58:41 +1000
Message-ID: <20240312165851.2240242-31-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

Introduce the nested PAPR hcalls:
 - H_GUEST_GET_CAPABILITIES which is used to query the capabilities
   of the API and the L2 guests it provides.
 - H_GUEST_SET_CAPABILITIES which is used to set the Guest API
   capabilities that the Host Partition supports and may use.

[amachhiw: support for p9 compat mode and return register bug fixes]

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Amit Machhiwal <amachhiw@linux.vnet.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_nested.c         | 115 ++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h        |   7 ++-
 include/hw/ppc/spapr_nested.h |  12 ++++
 3 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 12fdbe2aba..c35acee51f 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -7,6 +7,7 @@
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/spapr_nested.h"
 #include "mmu-book3s-v3.h"
+#include "cpu-models.h"
 
 void spapr_nested_reset(SpaprMachineState *spapr)
 {
@@ -16,6 +17,7 @@ void spapr_nested_reset(SpaprMachineState *spapr)
         spapr_register_nested_hv();
     } else {
         spapr->nested.api = 0;
+        spapr->nested.capabilities_set = false;
     }
 }
 
@@ -432,6 +434,93 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     }
 }
 
+static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
+                                             SpaprMachineState *spapr,
+                                             target_ulong opcode,
+                                             target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong flags = args[0];
+
+    if (flags) { /* don't handle any flags capabilities for now */
+        return H_PARAMETER;
+    }
+
+    /* P10 capabilities */
+    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0,
+        spapr->max_compat_pvr)) {
+        env->gpr[4] |= H_GUEST_CAPABILITIES_P10_MODE;
+    }
+
+    /* P9 capabilities */
+    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
+        spapr->max_compat_pvr)) {
+        env->gpr[4] |= H_GUEST_CAPABILITIES_P9_MODE;
+    }
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_guest_set_capabilities(PowerPCCPU *cpu,
+                                             SpaprMachineState *spapr,
+                                             target_ulong opcode,
+                                              target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong flags = args[0];
+    target_ulong capabilities = args[1];
+    env->gpr[4] = 0;
+
+    if (flags) { /* don't handle any flags capabilities for now */
+        return H_PARAMETER;
+    }
+
+    if (capabilities & H_GUEST_CAPABILITIES_COPY_MEM) {
+        env->gpr[4] = 1;
+        return H_P2; /* isn't supported */
+    }
+
+    /*
+     * If there are no capabilities configured, set the R5 to the index of
+     * the first supported Power Processor Mode
+     */
+    if (!capabilities) {
+        env->gpr[4] = 1;
+
+        /* set R5 to the first supported Power Processor Mode */
+        if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0,
+                             spapr->max_compat_pvr)) {
+            env->gpr[5] = H_GUEST_CAP_P10_MODE_BMAP;
+        } else if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
+                                    spapr->max_compat_pvr)) {
+            env->gpr[5] = H_GUEST_CAP_P9_MODE_BMAP;
+        }
+
+        return H_P2;
+    }
+
+    /*
+     * If an invalid capability is set, R5 should contain the index of the
+     * invalid capability bit
+     */
+    if (capabilities & ~H_GUEST_CAP_VALID_MASK) {
+        env->gpr[4] = 1;
+
+        /* Set R5 to the index of the invalid capability */
+        env->gpr[5] = 63 - ctz64(capabilities);
+
+        return H_P2;
+    }
+
+    if (!spapr->nested.capabilities_set) {
+        spapr->nested.capabilities_set = true;
+        spapr->nested.pvr_base = env->spr[SPR_PVR];
+        return H_SUCCESS;
+    } else {
+        return H_STATE;
+    }
+}
+
 void spapr_register_nested_hv(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -447,6 +536,21 @@ void spapr_unregister_nested_hv(void)
     spapr_unregister_hypercall(KVMPPC_H_TLB_INVALIDATE);
     spapr_unregister_hypercall(KVMPPC_H_COPY_TOFROM_GUEST);
 }
+
+void spapr_register_nested_papr(void)
+{
+    spapr_register_hypercall(H_GUEST_GET_CAPABILITIES,
+                             h_guest_get_capabilities);
+    spapr_register_hypercall(H_GUEST_SET_CAPABILITIES,
+                             h_guest_set_capabilities);
+}
+
+void spapr_unregister_nested_papr(void)
+{
+    spapr_unregister_hypercall(H_GUEST_GET_CAPABILITIES);
+    spapr_unregister_hypercall(H_GUEST_SET_CAPABILITIES);
+}
+
 #else
 void spapr_exit_nested(PowerPCCPU *cpu, int excp)
 {
@@ -468,4 +572,15 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
 {
     return false;
 }
+
+void spapr_register_nested_papr(void)
+{
+    /* DO NOTHING */
+}
+
+void spapr_unregister_nested_papr(void)
+{
+    /* DO NOTHING */
+}
+
 #endif
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 0eb01ea6fd..2906d59137 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -364,6 +364,7 @@ struct SpaprMachineState {
 #define H_NOOP            -63
 #define H_UNSUPPORTED     -67
 #define H_OVERLAP         -68
+#define H_STATE           -75
 #define H_UNSUPPORTED_FLAG -256
 #define H_MULTI_THREADS_ACTIVE -9005
 
@@ -583,8 +584,10 @@ struct SpaprMachineState {
 #define H_RPT_INVALIDATE        0x448
 #define H_SCM_FLUSH             0x44C
 #define H_WATCHDOG              0x45C
+#define H_GUEST_GET_CAPABILITIES 0x460
+#define H_GUEST_SET_CAPABILITIES 0x464
 
-#define MAX_HCALL_OPCODE        H_WATCHDOG
+#define MAX_HCALL_OPCODE         H_GUEST_SET_CAPABILITIES
 
 /* The hcalls above are standardized in PAPR and implemented by pHyp
  * as well.
@@ -1033,5 +1036,7 @@ void spapr_watchdog_init(SpaprMachineState *spapr);
 void spapr_register_nested_hv(void);
 void spapr_unregister_nested_hv(void);
 void spapr_nested_reset(SpaprMachineState *spapr);
+void spapr_register_nested_papr(void);
+void spapr_unregister_nested_papr(void);
 
 #endif /* HW_SPAPR_H */
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index bf3a7b8d89..73687e03e4 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -7,8 +7,20 @@ typedef struct SpaprMachineStateNested {
     uint64_t ptcr;
     uint8_t api;
 #define NESTED_API_KVM_HV  1
+    bool capabilities_set;
+    uint32_t pvr_base;
 } SpaprMachineStateNested;
 
+/* Nested PAPR API related macros */
+#define H_GUEST_CAPABILITIES_COPY_MEM 0x8000000000000000
+#define H_GUEST_CAPABILITIES_P9_MODE  0x4000000000000000
+#define H_GUEST_CAPABILITIES_P10_MODE 0x2000000000000000
+#define H_GUEST_CAP_VALID_MASK        (H_GUEST_CAPABILITIES_P10_MODE | \
+                                       H_GUEST_CAPABILITIES_P9_MODE)
+#define H_GUEST_CAP_COPY_MEM_BMAP     0
+#define H_GUEST_CAP_P9_MODE_BMAP      1
+#define H_GUEST_CAP_P10_MODE_BMAP     2
+
 /*
  * Register state for entering a nested guest with H_ENTER_NESTED.
  * New member must be added at the end.
-- 
2.42.0


