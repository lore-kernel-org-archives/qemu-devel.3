Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF46C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5X2-0004Bx-Ub; Tue, 12 Mar 2024 13:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5UX-0006JN-IO; Tue, 12 Mar 2024 13:00:44 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5UT-0008P7-Uh; Tue, 12 Mar 2024 13:00:41 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e6b5432439so29711b3a.1; 
 Tue, 12 Mar 2024 10:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262833; x=1710867633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBITymDFeDXiJDgONKwZL8oLgmw8A0Gg/g7pdbBRahU=;
 b=V+59vRHJxwkgA1EaDCKFw8r/RqI1IF/1hOdqVGMDE2vJcbC33Wk+KVx+vwh+ELYOrv
 G3njQmkhz0cihQcQ9OWbi1HogpX2quYmaTIRm4B0FeTDpp1m/xGPQYGjbFf1JrydWRZe
 WshmlBT77nlmDse/HBudbWqNySI0ncu+eSirvUfuXE0qlyefkqF3CSTHIzEbniTfj5oW
 dPDSp2Dyd2Oik1UR4jKqcwRfVoj7do1hUtf1DGKCHbFhx8Uv2fdOGgmHLwfFSX9SYllc
 7rtDSweddrnH0Mqi7nDJy5WkW2iLbqXgYw9zM2NiCJn68cmqwfpjk+JDbYEsTRMwgw44
 1NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262833; x=1710867633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pBITymDFeDXiJDgONKwZL8oLgmw8A0Gg/g7pdbBRahU=;
 b=LE/nt+JSoY60N+xkodLCQEXxsMKllU5hjFf3ZxIjx0H6B4o8MtMtcDC4hkiymZ1bOL
 bl1Su8+X+vLIxnY7iuvgrr6/VPF4jMeyZ8mQjSqrIa/baWUvMvM7FHN1jtxzc1FXnPN8
 n+KtwLfFT0YISXw17w5fXaelbf1+u7KxD5OLxza4/PJj4A40/5w8UJH0ufLw/ffzzZeV
 /E288GbS3BEwrepPJ/9Xltj+aSMstzQ9fKKCrImDNcBgAQ9Ck8LKysooroMe9KihNmvO
 zgcXeXgqXw5k9jo6aDKrFK5uo9mnZOO4eS++1Yoo2UVmj1m8Fkv3cFDK+HN7Rqbvo0hS
 MIEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+qKKT3XrBv0aF4vGeaRDXl8VwbVElIoiLfrNj2EURm9Dzy5qjfLZkABIsqh3uWVa59gPWqbwQkX4cSTZLj9e9Up31
X-Gm-Message-State: AOJu0Yw3Qcxw5Wp6E6yr4sJLM9LwXY+DXebR1oomfpphBzb2WEnfaK6g
 d3bhjKG3ktPwvZg0DCBdvQ/sUKJVFbMSAYz1lNah/zXy0v2/F4l18A16R7EqYvs=
X-Google-Smtp-Source: AGHT+IFT0vRE1D+15HxGvwOVUTyBmL1xSAgU61PIwj17yKZEPoZa83WSAekJ/c9j96PLZKcC0CZJ+g==
X-Received: by 2002:a05:6a20:12c2:b0:1a3:2fea:936c with SMTP id
 v2-20020a056a2012c200b001a32fea936cmr322711pzg.41.1710262833625; 
 Tue, 12 Mar 2024 10:00:33 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.10.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:00:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 25/38] spapr: nested: register nested-hv api hcalls only for
 cap-nested-hv
Date: Wed, 13 Mar 2024 02:58:36 +1000
Message-ID: <20240312165851.2240242-26-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

Since cap-nested-hv is an optional capability, it makes sense to register
api specfic hcalls only when respective capability is enabled. This
requires to introduce a new API to unregister hypercalls to maintain
sanity across guest reboot since caps are re-applied across reboots and
re-registeration of hypercalls would hit assert otherwise.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c                |  1 +
 hw/ppc/spapr_hcall.c          | 24 ++++++++++++++++++++++--
 hw/ppc/spapr_nested.c         | 25 +++++++++++++++++++++++--
 include/hw/ppc/spapr.h        |  4 ++++
 include/hw/ppc/spapr_nested.h |  1 -
 5 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index abd484023a..7321c35174 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1734,6 +1734,7 @@ static void spapr_machine_reset(MachineState *machine, ShutdownCause reason)
 
     pef_kvm_reset(machine->cgs, &error_fatal);
     spapr_caps_apply(spapr);
+    spapr_nested_reset(spapr);
 
     first_ppc_cpu = POWERPC_CPU(first_cpu);
     if (kvm_enabled() && kvmppc_has_cap_mmu_radix() &&
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 75c2d12978..5e1d020e3d 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1525,6 +1525,28 @@ void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn)
     *slot = fn;
 }
 
+void spapr_unregister_hypercall(target_ulong opcode)
+{
+    spapr_hcall_fn *slot;
+
+    if (opcode <= MAX_HCALL_OPCODE) {
+        assert((opcode & 0x3) == 0);
+
+        slot = &papr_hypercall_table[opcode / 4];
+    } else if (opcode >= SVM_HCALL_BASE && opcode <= SVM_HCALL_MAX) {
+        /* we only have SVM-related hcall numbers assigned in multiples of 4 */
+        assert((opcode & 0x3) == 0);
+
+        slot = &svm_hypercall_table[(opcode - SVM_HCALL_BASE) / 4];
+    } else {
+        assert((opcode >= KVMPPC_HCALL_BASE) && (opcode <= KVMPPC_HCALL_MAX));
+
+        slot = &kvmppc_hypercall_table[opcode - KVMPPC_HCALL_BASE];
+    }
+
+    *slot = NULL;
+}
+
 target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
                              target_ulong *args)
 {
@@ -1638,8 +1660,6 @@ static void hypercall_register_types(void)
     spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support);
 
     spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
-
-    spapr_register_nested();
 }
 
 type_init(hypercall_register_types)
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 121aa96ddc..8e0ee0d22f 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -7,6 +7,14 @@
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/spapr_nested.h"
 
+void spapr_nested_reset(SpaprMachineState *spapr)
+{
+    if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV)) {
+        spapr_unregister_nested_hv();
+        spapr_register_nested_hv();
+    }
+}
+
 #ifdef CONFIG_TCG
 #define PRTS_MASK      0x1f
 
@@ -375,20 +383,33 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     address_space_unmap(CPU(cpu)->as, regs, len, len, true);
 }
 
-void spapr_register_nested(void)
+void spapr_register_nested_hv(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
     spapr_register_hypercall(KVMPPC_H_ENTER_NESTED, h_enter_nested);
     spapr_register_hypercall(KVMPPC_H_TLB_INVALIDATE, h_tlb_invalidate);
     spapr_register_hypercall(KVMPPC_H_COPY_TOFROM_GUEST, h_copy_tofrom_guest);
 }
+
+void spapr_unregister_nested_hv(void)
+{
+    spapr_unregister_hypercall(KVMPPC_H_SET_PARTITION_TABLE);
+    spapr_unregister_hypercall(KVMPPC_H_ENTER_NESTED);
+    spapr_unregister_hypercall(KVMPPC_H_TLB_INVALIDATE);
+    spapr_unregister_hypercall(KVMPPC_H_COPY_TOFROM_GUEST);
+}
 #else
 void spapr_exit_nested(PowerPCCPU *cpu, int excp)
 {
     g_assert_not_reached();
 }
 
-void spapr_register_nested(void)
+void spapr_register_nested_hv(void)
+{
+    /* DO NOTHING */
+}
+
+void spapr_unregister_nested_hv(void)
 {
     /* DO NOTHING */
 }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 5b5ba9ef77..78a736297b 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -631,6 +631,7 @@ typedef target_ulong (*spapr_hcall_fn)(PowerPCCPU *cpu, SpaprMachineState *sm,
                                        target_ulong *args);
 
 void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn);
+void spapr_unregister_hypercall(target_ulong opcode);
 target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
                              target_ulong *args);
 
@@ -1028,5 +1029,8 @@ void spapr_vof_client_dt_finalize(SpaprMachineState *spapr, void *fdt);
 
 /* H_WATCHDOG */
 void spapr_watchdog_init(SpaprMachineState *spapr);
+void spapr_register_nested_hv(void);
+void spapr_unregister_nested_hv(void);
+void spapr_nested_reset(SpaprMachineState *spapr);
 
 #endif /* HW_SPAPR_H */
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index d312a5d61d..09d95182b2 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -95,7 +95,6 @@ struct nested_ppc_state {
     int64_t tb_offset;
 };
 
-void spapr_register_nested(void);
 void spapr_exit_nested(PowerPCCPU *cpu, int excp);
 
 #endif /* HW_SPAPR_NESTED_H */
-- 
2.42.0


