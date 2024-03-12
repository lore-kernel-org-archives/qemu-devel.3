Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E45C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5Z7-0000xY-9n; Tue, 12 Mar 2024 13:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Vg-00087z-4C; Tue, 12 Mar 2024 13:01:55 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Vd-0000AH-8G; Tue, 12 Mar 2024 13:01:51 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e6ac741ff7so545058b3a.0; 
 Tue, 12 Mar 2024 10:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262907; x=1710867707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lX04aDkXFvlRCQh6VqYz9F4OSVcE/Z+9u7GVIjBUl0g=;
 b=d9CIxTmwwwjO0NSWvHtxUV/ZUibzdH3otTp2OFllS5pYGspHy2uVnw+oM/XP7mjiPQ
 Blsn+cFjJLzh7PM6ZtTPObA0pBzKpj1XMLXKrGe3zvd0zaWPiXYCPBm0gks+Ns8BeGXN
 2wGta1rvgNPpYJpBQPRWbh3V3jArsfGO/54YJK1XllS/jes23Gg6ai5A/gqXeUlOywrl
 hlN8s7IzF+sSxOajwees5zHJkk3UbIWol8E2dA0agZNtWJ/+rjcg3fEwt5VAD//jmNck
 8Pc1k6DZi6k34UUQl+uZGOeQCuaTYtdd8bQ+gRuQsKqpDe6rsd0MSLTwXWlZfPYmd8T9
 h24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262907; x=1710867707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lX04aDkXFvlRCQh6VqYz9F4OSVcE/Z+9u7GVIjBUl0g=;
 b=tYa0hpIXZ6vuS2vFcMUuMJlP6LYxkThGaD0gpqcs5yJwpBDyJ+GA0TDOmUw978k0oz
 B0zDxw28Dn+udoZ5F3mHrprk4Tb+OgSqoXnYOXoh9BK9EweUP7zu0NTns7aem0FVEHRw
 qlWOHPmqpBXV1HVYDfVLiGc7civW7PGzI/JnkQndzMuOYxHAq1hC/bqYhgoKf/4Gc3oN
 A2fD17VigBwwVZMtvvVR+t4bJTtLjSoa6Ye1hedXtzBkqYcrF5njXA1di9GRcy8GEszr
 nqTmBVu6J2UQkW1kpEDN0BdoyMoyrp52wt6Dj1d9QluMZHPwbvelxsN5wBD4qC4SHxrP
 WC0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXODQAriTn/D1yiYa9RQIXiL1P2Mx05bcx9gm5SjjNWHxeVMAr31qflnt/6maMj4L1GstsHJxYJI+6pDM8oXVwjxK2u
X-Gm-Message-State: AOJu0YyIPDpZLNmz3M+HULwepHUrdxvMFWjETiyikghtiKqP4mHZ+kYT
 9TIGI6c3EdaF2/RMK5/9KLiVmA/Kxfe9phlWkRYWiwCMM/p9IvYtwxT6EX3uBiE=
X-Google-Smtp-Source: AGHT+IHHFobD/lume3I6+6DrjoB1PFYIfOvW3njMOKAlzt47rWA9eZLOMaGcsQ2ht4ZMbybwaI9dcw==
X-Received: by 2002:a05:6a20:3d25:b0:1a3:25f9:102b with SMTP id
 y37-20020a056a203d2500b001a325f9102bmr1014246pzi.12.1710262906960; 
 Tue, 12 Mar 2024 10:01:46 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.10.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:01:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Michael Neuling <mikey@neuling.org>
Subject: [PULL 38/38] spapr: nested: Introduce cap-nested-papr for Nested PAPR
 API
Date: Wed, 13 Mar 2024 02:58:49 +1000
Message-ID: <20240312165851.2240242-39-npiggin@gmail.com>
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

Introduce a SPAPR capability cap-nested-papr which enables nested PAPR
API for nested guests. This new API is to enable support for KVM on PowerVM
and the support in Linux kernel has already merged upstream.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c         |  2 ++
 hw/ppc/spapr_caps.c    | 54 ++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_nested.c  |  8 ++++---
 include/hw/ppc/spapr.h |  6 ++++-
 4 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index aaf73781b0..99d3fcb185 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2166,6 +2166,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_cap_fwnmi,
         &vmstate_spapr_fwnmi,
         &vmstate_spapr_cap_rpt_invalidate,
+        &vmstate_spapr_cap_nested_papr,
         NULL
     }
 };
@@ -4732,6 +4733,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_WORKAROUND;
     smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 16; /* 64kiB */
     smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
+    smc->default_caps.caps[SPAPR_CAP_NESTED_PAPR] = SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_ON;
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index e889244e52..62abf1ba9d 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -487,6 +487,50 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
             error_append_hint(errp, "Try appending -machine cap-nested-hv=off "
                                     "or use threads=1 with -smp\n");
         }
+        if (spapr_nested_api(spapr) &&
+            spapr_nested_api(spapr) != NESTED_API_KVM_HV) {
+            error_setg(errp, "Nested-HV APIs are mutually exclusive");
+            error_append_hint(errp, "Please use either cap-nested-hv or "
+                                    "cap-nested-papr to proceed.\n");
+            return;
+        } else {
+            spapr->nested.api = NESTED_API_KVM_HV;
+        }
+    }
+}
+
+static void cap_nested_papr_apply(SpaprMachineState *spapr,
+                                    uint8_t val, Error **errp)
+{
+    ERRP_GUARD();
+    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
+    CPUPPCState *env = &cpu->env;
+
+    if (!val) {
+        /* capability disabled by default */
+        return;
+    }
+
+    if (tcg_enabled()) {
+        if (!(env->insns_flags2 & PPC2_ISA300)) {
+            error_setg(errp, "Nested-PAPR only supported on POWER9 and later");
+            error_append_hint(errp,
+                              "Try appending -machine cap-nested-papr=off\n");
+            return;
+        }
+        if (spapr_nested_api(spapr) &&
+            spapr_nested_api(spapr) != NESTED_API_PAPR) {
+            error_setg(errp, "Nested-HV APIs are mutually exclusive");
+            error_append_hint(errp, "Please use either cap-nested-hv or "
+                                    "cap-nested-papr to proceed.\n");
+            return;
+        } else {
+            spapr->nested.api = NESTED_API_PAPR;
+        }
+    } else if (kvm_enabled()) {
+        error_setg(errp, "KVM implementation does not support Nested-PAPR");
+        error_append_hint(errp,
+                          "Try appending -machine cap-nested-papr=off\n");
     }
 }
 
@@ -735,6 +779,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "bool",
         .apply = cap_nested_kvm_hv_apply,
     },
+    [SPAPR_CAP_NESTED_PAPR] = {
+        .name = "nested-papr",
+        .description = "Allow Nested HV (PAPR API)",
+        .index = SPAPR_CAP_NESTED_PAPR,
+        .get = spapr_cap_get_bool,
+        .set = spapr_cap_set_bool,
+        .type = "bool",
+        .apply = cap_nested_papr_apply,
+    },
     [SPAPR_CAP_LARGE_DECREMENTER] = {
         .name = "large-decr",
         .description = "Allow Large Decrementer",
@@ -919,6 +972,7 @@ SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
 SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
 SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
 SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
+SPAPR_CAP_MIG_STATE(nested_papr, SPAPR_CAP_NESTED_PAPR);
 SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
 SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
 SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index ce3490bcf2..936659b4c0 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -13,13 +13,15 @@
 void spapr_nested_reset(SpaprMachineState *spapr)
 {
     if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV)) {
-        spapr->nested.api = NESTED_API_KVM_HV;
         spapr_unregister_nested_hv();
         spapr_register_nested_hv();
-    } else {
-        spapr->nested.api = 0;
+    } else if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_PAPR)) {
         spapr->nested.capabilities_set = false;
+        spapr_unregister_nested_papr();
+        spapr_register_nested_papr();
         spapr_nested_gsb_init();
+    } else {
+        spapr->nested.api = 0;
     }
 }
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 6223873641..4aaf23d28f 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -81,8 +81,10 @@ typedef enum {
 #define SPAPR_CAP_RPT_INVALIDATE        0x0B
 /* Support for AIL modes */
 #define SPAPR_CAP_AIL_MODE_3            0x0C
+/* Nested PAPR */
+#define SPAPR_CAP_NESTED_PAPR           0x0D
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_AIL_MODE_3 + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_NESTED_PAPR + 1)
 
 /*
  * Capability Values
@@ -592,6 +594,7 @@ struct SpaprMachineState {
 #define H_GUEST_CREATE_VCPU      0x474
 #define H_GUEST_GET_STATE        0x478
 #define H_GUEST_SET_STATE        0x47C
+#define H_GUEST_RUN_VCPU         0x480
 #define H_GUEST_DELETE           0x488
 
 #define MAX_HCALL_OPCODE         H_GUEST_DELETE
@@ -996,6 +999,7 @@ extern const VMStateDescription vmstate_spapr_cap_sbbc;
 extern const VMStateDescription vmstate_spapr_cap_ibs;
 extern const VMStateDescription vmstate_spapr_cap_hpt_maxpagesize;
 extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
+extern const VMStateDescription vmstate_spapr_cap_nested_papr;
 extern const VMStateDescription vmstate_spapr_cap_large_decr;
 extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
 extern const VMStateDescription vmstate_spapr_cap_fwnmi;
-- 
2.42.0


