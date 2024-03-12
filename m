Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1FBC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5Xd-0005PU-Vf; Tue, 12 Mar 2024 13:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Ul-0006Q5-7T; Tue, 12 Mar 2024 13:00:57 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Ud-0008Ss-9T; Tue, 12 Mar 2024 13:00:52 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e55731af5cso3023750b3a.0; 
 Tue, 12 Mar 2024 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262844; x=1710867644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g1D76JqJ2U58FMi1RODuDn/OgN6fCV9pAj01Xlhk49w=;
 b=XdenP9VJqdJQ1/LmWYmO0Yg+Z53J3ZeF+VPwCeGpQMirngLWm/YMqFxoYE7VyPwe4K
 KOnr2QdWBLmvp4kNZMKKKCKbPuva3V5+5KCfnqhhLP39PsYKAKMvPckvjkw0jpNYOVbR
 6uO6ceMcev5Srx2QIKchMm3t80DsrEchhY9EVGwYmLdxjigbl+/8+G8fGHSG6TVoQv6s
 XSnItcg6kP9BXUmzKsvGKY+fsbg+VkMBw4fGyhNwCuQ4E5YExuyNLLe2Bc9NvOggnSeF
 mgq/Ah11vYHFt/vOjp1oDFm+PK5Tkpuuj3ln8fOv8mEijK6hg2z2wn3zqCktUJu8V+9G
 afrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262844; x=1710867644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g1D76JqJ2U58FMi1RODuDn/OgN6fCV9pAj01Xlhk49w=;
 b=FggXoP8xaOa4ASdscacZ3POKJmhGJosQxlihPtiMXcmGvhrZNVFqXnp7WobXSKpn0f
 1YIycIKcZlHqxnoBzao5zLMFTTq6VLJ9rhO/6QzBtaeX2v/mvG8rIYR7jdvrjB9w82ao
 y7nnFO1kM1s41Y6/qzMbxZbY8ajDo/aQcuEZ6CQlH2J322NCxKZjcV9vRpX7XN1VwI2n
 Zhdebw4d1wGrTXuaNWT8cMVE/TtEkOh96kQ1bPJVQqTFxNdibMQFlSNNkDqsmvNfxCKp
 wKc9Ez9b82nvkhSpv9JB4gqiHEYUnV+Bl/EXH5Rcl+fgnvD8b35Wcq5eQZ7yOIPi7fG3
 fleg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2PH/9OEqoqPjikFOOjQouMLB2bpMT/85XqLrRGTW6iPMwasJqrMC52oufa/v9YWgXLb90YRHJvZHZbZxl0b4VsHDy
X-Gm-Message-State: AOJu0YzFxVcMdo8NdlzYS/CC0TkzYhTCaIC9vPKid3ai6XdlsZWIHOcs
 cFNKlJ3+MYdF6yyAqwvv1VEBDxHmDRj8JFUZSXCGtvCQGoOVasaMmEhFoAxEOKQ=
X-Google-Smtp-Source: AGHT+IEiwrhGU/MbOuCWoouRzs2qRHau/Bb2N1QT2z9BIlx+xTLFWoJydDgWSfX9Ghx52uozenN8fw==
X-Received: by 2002:a05:6a20:5485:b0:1a1:4d8b:6f2c with SMTP id
 i5-20020a056a20548500b001a14d8b6f2cmr8696437pzk.2.1710262844392; 
 Tue, 12 Mar 2024 10:00:44 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.10.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:00:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 28/38] spapr: nested: keep nested-hv related code restricted to
 its API.
Date: Wed, 13 Mar 2024 02:58:39 +1000
Message-ID: <20240312165851.2240242-29-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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

spapr_exit_nested and spapr_get_pate_nested_hv contains code which
is specific to nested-hv API. Isolating code flows based on API
helps extending it to be used with different API as well.

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c                |  6 +++++-
 hw/ppc/spapr_nested.c         | 25 ++++++++++++++++++++++---
 include/hw/ppc/spapr_nested.h |  3 +++
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ff429d0ffe..e001ffe06f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1421,7 +1421,11 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
         entry->dw1 = spapr->patb_entry;
         return true;
     } else {
-        return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
+        assert(spapr_nested_api(spapr));
+        if (spapr_nested_api(spapr) == NESTED_API_KVM_HV) {
+            return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
+        }
+        return false;
     }
 }
 
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index c2a33fc3a9..12fdbe2aba 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -11,11 +11,19 @@
 void spapr_nested_reset(SpaprMachineState *spapr)
 {
     if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV)) {
+        spapr->nested.api = NESTED_API_KVM_HV;
         spapr_unregister_nested_hv();
         spapr_register_nested_hv();
+    } else {
+        spapr->nested.api = 0;
     }
 }
 
+uint8_t spapr_nested_api(SpaprMachineState *spapr)
+{
+    return spapr->nested.api;
+}
+
 #ifdef CONFIG_TCG
 
 bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
@@ -310,7 +318,7 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
     return env->gpr[3];
 }
 
-void spapr_exit_nested(PowerPCCPU *cpu, int excp)
+static void spapr_exit_nested_hv(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
@@ -322,8 +330,6 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     struct kvmppc_pt_regs *regs;
     hwaddr len;
 
-    assert(spapr_cpu->in_nested);
-
     nested_save_state(&l2_state, cpu);
     hsrr0 = env->spr[SPR_HSRR0];
     hsrr1 = env->spr[SPR_HSRR1];
@@ -413,6 +419,19 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     address_space_unmap(CPU(cpu)->as, regs, len, len, true);
 }
 
+void spapr_exit_nested(PowerPCCPU *cpu, int excp)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+
+    assert(spapr_cpu->in_nested);
+    if (spapr_nested_api(spapr) == NESTED_API_KVM_HV) {
+        spapr_exit_nested_hv(cpu, excp);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 void spapr_register_nested_hv(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 2488ea98da..bf3a7b8d89 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -5,6 +5,8 @@
 
 typedef struct SpaprMachineStateNested {
     uint64_t ptcr;
+    uint8_t api;
+#define NESTED_API_KVM_HV  1
 } SpaprMachineStateNested;
 
 /*
@@ -103,4 +105,5 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp);
 typedef struct SpaprMachineState SpaprMachineState;
 bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
                               target_ulong lpid, ppc_v3_pate_t *entry);
+uint8_t spapr_nested_api(SpaprMachineState *spapr);
 #endif /* HW_SPAPR_NESTED_H */
-- 
2.42.0


