Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B2EC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5Wy-0003ij-UJ; Tue, 12 Mar 2024 13:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Uu-0006e3-JK; Tue, 12 Mar 2024 13:01:10 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Us-0008VD-Qe; Tue, 12 Mar 2024 13:01:04 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e6adc557b6so613744b3a.2; 
 Tue, 12 Mar 2024 10:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262860; x=1710867660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZxAZDNkVeicKPAVy4559sSS+y8z567HqIodOKDjwHAw=;
 b=KJldXMTckeIWiSdjk/wRV0AlkfgIHt8m/Hd5Iu9d1CBnsmBWUAAluwoVms9HZfMLMG
 9rt50ap5z176oN+MBw6vpeyzqEGkhQxbI9K9FzZ+GbbSoMHvxtaYqbWKTXKYh9JiXby8
 nitGJCTb+A8sAgtonOM3E4l1P1NyfJAKoJrNq2g+bK70pFo/kNu3xqMUItCCFGlbD5kc
 FI15c85P1VHHfqpxHTnu36AQID+sEDglCv/dbiQrztUrcXH8+01o+TOIOXKRapX14k3f
 x1S2KUfy3oZv9eP/VZevDkKA2rrAQZGwcLIGFNLavk7B6BWiFvVpCysORTsE/jzLrWeP
 FjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262860; x=1710867660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZxAZDNkVeicKPAVy4559sSS+y8z567HqIodOKDjwHAw=;
 b=Du/gfOyvvuFFnNz6DuS2c+h0SdDTnJ1jQiZeKmY8RYUi9keBz8HDS4Ol/+WiMsBPpa
 Ul2rTmuEX9VtX2QMPZ5cM+S0ntRcU6o/PJv4rPvo9HxdJmJvf2kTcjJuFD6xaMFvPPjC
 ZMhLw2QutcYN2s8aSD9xrMjRX7kj4dPCC/dnAUVoqjK9Lxu0xf9odrZw1l1AhU/cElig
 RlQBoq61mQv9vRzCxTCvpKDNkK3FqHVioZe2ll4qFx4blTi76zSnvND01Yg7fic6AGNG
 pZVO5qGlg5QTK7OnyYcHYO3pZpLXno79MtsOg6b/aAi+Ss01+pUjseP4g/Lr7LR8aAsx
 rSHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu68DvBYQQfmzGYWeX61h8Sa0R07PftqIOYEn/7h08gKvWNXoN1Exoxdau/ob+dsipvT7JlwpnmUm8POozHUmw09q0
X-Gm-Message-State: AOJu0YzO/XQsTihlJJrAH6qxPf9P/IgRm/hgAvF96tdvQbo2arfG5E78
 8nTAALuhwzXT4EbrTKj+NoPS7N5Ppe6AOW10c42z8z+PsuW8AVqxLKRTWw6q5jU=
X-Google-Smtp-Source: AGHT+IF+zd89vHLmB71USiPGNDhEL/5CEgsZvqUEXzI4bt/aHFGlpiXKLwsxG77xG1M0sg2LIoPrag==
X-Received: by 2002:a05:6a20:1456:b0:1a3:1246:c43e with SMTP id
 a22-20020a056a20145600b001a31246c43emr956956pzi.28.1710262859946; 
 Tue, 12 Mar 2024 10:00:59 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.10.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:00:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Michael Neuling <mikey@neuling.org>
Subject: [PULL 32/38] spapr: nested: Introduce H_GUEST_CREATE_VCPU hcall.
Date: Wed, 13 Mar 2024 02:58:43 +1000
Message-ID: <20240312165851.2240242-33-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

Introduce the nested PAPR hcall H_GUEST_CREATE_VCPU which is used to
create and initialize the specified VCPU resource for the previously
created guest. Each guest can have multiple VCPUs upto max 2048.
All VCPUs for a guest gets deallocated on guest delete.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_nested.c         | 62 +++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h        |  2 ++
 include/hw/ppc/spapr_nested.h |  8 +++++
 3 files changed, 72 insertions(+)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 1f6eb68b93..72bf3dc6d4 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -8,6 +8,7 @@
 #include "hw/ppc/spapr_nested.h"
 #include "mmu-book3s-v3.h"
 #include "cpu-models.h"
+#include "qemu/log.h"
 
 void spapr_nested_reset(SpaprMachineState *spapr)
 {
@@ -434,6 +435,16 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     }
 }
 
+static
+SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
+                                                     target_ulong guestid)
+{
+    SpaprMachineStateNestedGuest *guest;
+
+    guest = g_hash_table_lookup(spapr->nested.guests, GINT_TO_POINTER(guestid));
+    return guest;
+}
+
 static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
                                              SpaprMachineState *spapr,
                                              target_ulong opcode,
@@ -525,6 +536,7 @@ static void
 destroy_guest_helper(gpointer value)
 {
     struct SpaprMachineStateNestedGuest *guest = value;
+    g_free(guest->vcpus);
     g_free(guest);
 }
 
@@ -620,6 +632,54 @@ static target_ulong h_guest_delete(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
+static target_ulong h_guest_create_vcpu(PowerPCCPU *cpu,
+                                        SpaprMachineState *spapr,
+                                        target_ulong opcode,
+                                        target_ulong *args)
+{
+    target_ulong flags = args[0];
+    target_ulong guestid = args[1];
+    target_ulong vcpuid = args[2];
+    SpaprMachineStateNestedGuest *guest;
+
+    if (flags) { /* don't handle any flags for now */
+        return H_UNSUPPORTED_FLAG;
+    }
+
+    guest = spapr_get_nested_guest(spapr, guestid);
+    if (!guest) {
+        return H_P2;
+    }
+
+    if (vcpuid < guest->nr_vcpus) {
+        qemu_log_mask(LOG_UNIMP, "vcpuid " TARGET_FMT_ld " already in use.",
+                      vcpuid);
+        return H_IN_USE;
+    }
+    /* linear vcpuid allocation only */
+    assert(vcpuid == guest->nr_vcpus);
+
+    if (guest->nr_vcpus >= PAPR_NESTED_GUEST_VCPU_MAX) {
+        return H_P3;
+    }
+
+    SpaprMachineStateNestedGuestVcpu *vcpus, *curr_vcpu;
+    vcpus = g_try_renew(struct SpaprMachineStateNestedGuestVcpu,
+                        guest->vcpus,
+                        guest->nr_vcpus + 1);
+    if (!vcpus) {
+        return H_NO_MEM;
+    }
+    guest->vcpus = vcpus;
+    curr_vcpu = &vcpus[guest->nr_vcpus];
+    memset(curr_vcpu, 0, sizeof(SpaprMachineStateNestedGuestVcpu));
+
+    curr_vcpu->enabled = true;
+    guest->nr_vcpus++;
+
+    return H_SUCCESS;
+}
+
 void spapr_register_nested_hv(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -644,6 +704,7 @@ void spapr_register_nested_papr(void)
                              h_guest_set_capabilities);
     spapr_register_hypercall(H_GUEST_CREATE, h_guest_create);
     spapr_register_hypercall(H_GUEST_DELETE, h_guest_delete);
+    spapr_register_hypercall(H_GUEST_CREATE_VCPU, h_guest_create_vcpu);
 }
 
 void spapr_unregister_nested_papr(void)
@@ -652,6 +713,7 @@ void spapr_unregister_nested_papr(void)
     spapr_unregister_hypercall(H_GUEST_SET_CAPABILITIES);
     spapr_unregister_hypercall(H_GUEST_CREATE);
     spapr_unregister_hypercall(H_GUEST_DELETE);
+    spapr_unregister_hypercall(H_GUEST_CREATE_VCPU);
 }
 
 #else
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 13416fc3d7..070135793a 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -365,6 +365,7 @@ struct SpaprMachineState {
 #define H_UNSUPPORTED     -67
 #define H_OVERLAP         -68
 #define H_STATE           -75
+#define H_IN_USE          -77
 #define H_UNSUPPORTED_FLAG -256
 #define H_MULTI_THREADS_ACTIVE -9005
 
@@ -587,6 +588,7 @@ struct SpaprMachineState {
 #define H_GUEST_GET_CAPABILITIES 0x460
 #define H_GUEST_SET_CAPABILITIES 0x464
 #define H_GUEST_CREATE           0x470
+#define H_GUEST_CREATE_VCPU      0x474
 #define H_GUEST_DELETE           0x488
 
 #define MAX_HCALL_OPCODE         H_GUEST_DELETE
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 56d43e540b..2ac3076fac 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -14,6 +14,8 @@ typedef struct SpaprMachineStateNested {
 
 typedef struct SpaprMachineStateNestedGuest {
     uint32_t pvr_logical;
+    unsigned long nr_vcpus;
+    struct SpaprMachineStateNestedGuestVcpu *vcpus;
 } SpaprMachineStateNestedGuest;
 
 /* Nested PAPR API related macros */
@@ -27,6 +29,7 @@ typedef struct SpaprMachineStateNestedGuest {
 #define H_GUEST_CAP_P10_MODE_BMAP     2
 #define PAPR_NESTED_GUEST_MAX         4096
 #define H_GUEST_DELETE_ALL_FLAG       0x8000000000000000ULL
+#define PAPR_NESTED_GUEST_VCPU_MAX    2048
 
 /*
  * Register state for entering a nested guest with H_ENTER_NESTED.
@@ -120,6 +123,11 @@ struct nested_ppc_state {
     int64_t tb_offset;
 };
 
+typedef struct SpaprMachineStateNestedGuestVcpu {
+    bool enabled;
+    struct nested_ppc_state state;
+} SpaprMachineStateNestedGuestVcpu;
+
 void spapr_exit_nested(PowerPCCPU *cpu, int excp);
 typedef struct SpaprMachineState SpaprMachineState;
 bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
-- 
2.42.0


