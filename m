Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099FFC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5X0-0003so-Mp; Tue, 12 Mar 2024 13:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Ur-0006ZI-9f; Tue, 12 Mar 2024 13:01:02 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Uo-0008Um-BB; Tue, 12 Mar 2024 13:01:01 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e649a2548cso4019269b3a.3; 
 Tue, 12 Mar 2024 10:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262856; x=1710867656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2rcEzjFiw//Qjpwo4SWUe5/5IQxOZFXiJDgJn5KABlY=;
 b=ebMV48tOZyzh3w+ILTvGsZ+k+CX5lU90GaLucmtDErd8DNxYW3EXrpSxnVdaK1dVER
 KvZ1KECfWtYFvEldjkviTC+ySll1RIa+TsJcF19XsyrJzggib1EAOP2BGIDX27v0Wbvb
 a2v2eNIBpZ2ey3+u9Q/yPlOmQ8wVKX01pm658TywJCXz8st/gtJNAY3pjMOHUuT10e7A
 i2lSxXCsz6dlSFA6uAuvYfnn2jFeioPOYqq2rwMdtNpJhZ+b/KK39MA5zcTfzHZi6aGK
 xUH38nYfcAvTp+rxP1nGJ/puYV1FJYSj85iDnIiDG4J+huKR4r3wngHT2MihVpBzOv6/
 1fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262856; x=1710867656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2rcEzjFiw//Qjpwo4SWUe5/5IQxOZFXiJDgJn5KABlY=;
 b=Fca2w32YfHEQ2HB/TGZffHe0N0PJmK69EEvvwnP5WtdWxOmxf/LUv4LbSdy1T1bW26
 OQ5IHgx91GiDA0dU0rG2HE6NtXa/N/6M1tMlWzz5zhm+Dd8Yg8I06wd0ScgyMO6ueg5m
 J8MMYUH3ejL9bA7bxjxj2652VP63qzj+u9bJl8TSHkmiFxhDtQK8p8aYbyY0Uq8g3ckn
 meuCYWrgLtXy6AgrHJICM/iiBit7fS1N8blaatMd8pRd06CCEAULNoIUt5B1SPO2f7GY
 U4HiZwFuSdEIkX5n70aP6/IdvjglJZvesNWgsxVDp0nnAzJv5OAfi8U9E7URN8z/oIb9
 EuvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7wvGR2Lrs8BdRJS/G+OPv55KEjAyNYkjY7zlmp/MNRGdfs0j0n2fdy7wNPtB8ZAdvXrcdZR61R0G6KfsBaPvKAPE2
X-Gm-Message-State: AOJu0YzkcKgPj9cA6TKfISVVeofh1s0y20ssjgWlSH5w0ACPisPWRtuB
 l/nrKZIDBPNqzmofinJngErvje/M8dH6+01pMO40wF5ThGDGp/DjLzKguNnd8cc=
X-Google-Smtp-Source: AGHT+IEn+h/SnxXCJXoyjUFH13z513+W0Mud8C2VR3i/IzrPuUy2s4QZCmgUAiT64afjE13BEYZxCw==
X-Received: by 2002:a05:6a00:b49:b0:6e6:1b89:aef3 with SMTP id
 p9-20020a056a000b4900b006e61b89aef3mr37867pfo.14.1710262855996; 
 Tue, 12 Mar 2024 10:00:55 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.10.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:00:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Michael Neuling <mikey@neuling.org>
Subject: [PULL 31/38] spapr: nested: Introduce H_GUEST_[CREATE|DELETE] hcalls.
Date: Wed, 13 Mar 2024 02:58:42 +1000
Message-ID: <20240312165851.2240242-32-npiggin@gmail.com>
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

Introduce the nested PAPR hcalls:
    - H_GUEST_CREATE which is used to create and allocate resources for
nested guest being created.
    - H_GUEST_DELETE which is used to delete and deallocate resources
for the nested guest being deleted. It also supports deleting all nested
guests at once using a deleteAll flag.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_nested.c         | 103 ++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h        |   4 +-
 include/hw/ppc/spapr_nested.h |   7 +++
 3 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index c35acee51f..1f6eb68b93 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -521,6 +521,105 @@ static target_ulong h_guest_set_capabilities(PowerPCCPU *cpu,
     }
 }
 
+static void
+destroy_guest_helper(gpointer value)
+{
+    struct SpaprMachineStateNestedGuest *guest = value;
+    g_free(guest);
+}
+
+static target_ulong h_guest_create(PowerPCCPU *cpu,
+                                   SpaprMachineState *spapr,
+                                   target_ulong opcode,
+                                   target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong flags = args[0];
+    target_ulong continue_token = args[1];
+    uint64_t guestid;
+    int nguests = 0;
+    struct SpaprMachineStateNestedGuest *guest;
+
+    if (flags) { /* don't handle any flags for now */
+        return H_UNSUPPORTED_FLAG;
+    }
+
+    if (continue_token != -1) {
+        return H_P2;
+    }
+
+    if (!spapr->nested.capabilities_set) {
+        return H_STATE;
+    }
+
+    if (!spapr->nested.guests) {
+        spapr->nested.guests = g_hash_table_new_full(NULL,
+                                                     NULL,
+                                                     NULL,
+                                                     destroy_guest_helper);
+    }
+
+    nguests = g_hash_table_size(spapr->nested.guests);
+
+    if (nguests == PAPR_NESTED_GUEST_MAX) {
+        return H_NO_MEM;
+    }
+
+    /* Lookup for available guestid */
+    for (guestid = 1; guestid < PAPR_NESTED_GUEST_MAX; guestid++) {
+        if (!(g_hash_table_lookup(spapr->nested.guests,
+                                  GINT_TO_POINTER(guestid)))) {
+            break;
+        }
+    }
+
+    if (guestid == PAPR_NESTED_GUEST_MAX) {
+        return H_NO_MEM;
+    }
+
+    guest = g_try_new0(struct SpaprMachineStateNestedGuest, 1);
+    if (!guest) {
+        return H_NO_MEM;
+    }
+
+    guest->pvr_logical = spapr->nested.pvr_base;
+    g_hash_table_insert(spapr->nested.guests, GINT_TO_POINTER(guestid), guest);
+    env->gpr[4] = guestid;
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_guest_delete(PowerPCCPU *cpu,
+                                   SpaprMachineState *spapr,
+                                   target_ulong opcode,
+                                   target_ulong *args)
+{
+    target_ulong flags = args[0];
+    target_ulong guestid = args[1];
+    struct SpaprMachineStateNestedGuest *guest;
+
+    /*
+     * handle flag deleteAllGuests, if set:
+     * guestid is ignored and all guests are deleted
+     *
+     */
+    if (flags & ~H_GUEST_DELETE_ALL_FLAG) {
+        return H_UNSUPPORTED_FLAG; /* other flag bits reserved */
+    } else if (flags & H_GUEST_DELETE_ALL_FLAG) {
+        g_hash_table_destroy(spapr->nested.guests);
+        return H_SUCCESS;
+    }
+
+    guest = g_hash_table_lookup(spapr->nested.guests, GINT_TO_POINTER(guestid));
+    if (!guest) {
+        return H_P2;
+    }
+
+    g_hash_table_remove(spapr->nested.guests, GINT_TO_POINTER(guestid));
+
+    return H_SUCCESS;
+}
+
 void spapr_register_nested_hv(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -543,12 +642,16 @@ void spapr_register_nested_papr(void)
                              h_guest_get_capabilities);
     spapr_register_hypercall(H_GUEST_SET_CAPABILITIES,
                              h_guest_set_capabilities);
+    spapr_register_hypercall(H_GUEST_CREATE, h_guest_create);
+    spapr_register_hypercall(H_GUEST_DELETE, h_guest_delete);
 }
 
 void spapr_unregister_nested_papr(void)
 {
     spapr_unregister_hypercall(H_GUEST_GET_CAPABILITIES);
     spapr_unregister_hypercall(H_GUEST_SET_CAPABILITIES);
+    spapr_unregister_hypercall(H_GUEST_CREATE);
+    spapr_unregister_hypercall(H_GUEST_DELETE);
 }
 
 #else
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 2906d59137..13416fc3d7 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -586,8 +586,10 @@ struct SpaprMachineState {
 #define H_WATCHDOG              0x45C
 #define H_GUEST_GET_CAPABILITIES 0x460
 #define H_GUEST_SET_CAPABILITIES 0x464
+#define H_GUEST_CREATE           0x470
+#define H_GUEST_DELETE           0x488
 
-#define MAX_HCALL_OPCODE         H_GUEST_SET_CAPABILITIES
+#define MAX_HCALL_OPCODE         H_GUEST_DELETE
 
 /* The hcalls above are standardized in PAPR and implemented by pHyp
  * as well.
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 73687e03e4..56d43e540b 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -9,8 +9,13 @@ typedef struct SpaprMachineStateNested {
 #define NESTED_API_KVM_HV  1
     bool capabilities_set;
     uint32_t pvr_base;
+    GHashTable *guests;
 } SpaprMachineStateNested;
 
+typedef struct SpaprMachineStateNestedGuest {
+    uint32_t pvr_logical;
+} SpaprMachineStateNestedGuest;
+
 /* Nested PAPR API related macros */
 #define H_GUEST_CAPABILITIES_COPY_MEM 0x8000000000000000
 #define H_GUEST_CAPABILITIES_P9_MODE  0x4000000000000000
@@ -20,6 +25,8 @@ typedef struct SpaprMachineStateNested {
 #define H_GUEST_CAP_COPY_MEM_BMAP     0
 #define H_GUEST_CAP_P9_MODE_BMAP      1
 #define H_GUEST_CAP_P10_MODE_BMAP     2
+#define PAPR_NESTED_GUEST_MAX         4096
+#define H_GUEST_DELETE_ALL_FLAG       0x8000000000000000ULL
 
 /*
  * Register state for entering a nested guest with H_ENTER_NESTED.
-- 
2.42.0


