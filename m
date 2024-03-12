Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75B2C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5X3-0004Mo-Tz; Tue, 12 Mar 2024 13:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Uz-0006ra-CM; Tue, 12 Mar 2024 13:01:12 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Ux-0008W0-6F; Tue, 12 Mar 2024 13:01:08 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e46dcd8feaso3547291b3a.2; 
 Tue, 12 Mar 2024 10:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262865; x=1710867665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2CypqX/Zjp70n1FIoUG4M+IW/+WsFwMUoVGMfQIzaMo=;
 b=b/REzB6l7pbdOy+KUfM42WvGzdeVHZorqLfVlqv0A9Tky4v7568crIac870EU7+9/f
 /gQts3H2aaPqnZL8nzPDugaE249fC5SPZNSFQmfLp/IxqSTbdcRbDbR8xwP7R02MaYS3
 SSkNiQ29FW1fhZS4TOKKJLu2sPbtFisky6ox8rg6ZgETokNzYbHCDAjr7bTDAOBukVhm
 UJd6Z6xhgaejNbH63mW52Fp2oxdlNH2OHAy/QMqZ17Jf65DIpk20tcItXlkaIGxdcb0V
 GayIkg3LxZzwuonp2CZ5kXFGbfKvDWLsIFSVDrZHa8BHLDGI2uc7JvW00HaphuDMSCZv
 xJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262865; x=1710867665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2CypqX/Zjp70n1FIoUG4M+IW/+WsFwMUoVGMfQIzaMo=;
 b=eGy/6gWDYfqZEXsGBmdQhK0mA0feq2ueZZ/i/ekQuDqUbaCdGcjnYkPJ9pV3gqA+aP
 aMZG9FfzK3vjUiLY3eYpBoCAQLqk99SI9nudI/IO4VagBvAHJe8+KQMRoAFNX3XGGEBg
 n8l9gkhX5yg5RF7+aL9Cb7bkefV0E4CPQjGwh/uUUvwqhfbN1b4jXR5PHsNSsnn15/U/
 Kpk2CxaN7hSh3BLvoJ3EjDCOcELNTLHzXmnXf8YwPFwocFfy90WxoY3OsLOqm72RygXC
 R6SYMS1qRvFyl8SkQBGQqJpYGhMVnWRvtrGUMVqQLRfTaBNLkfGt/jpW8MZWVNqqiqlx
 orSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5td+a/D5VidgTXIWkjkw323Ij6vtj0bVwGiS6aPa2yGj/lEXXlwmBCa6rIenv9UscbOIW8mliFJLDg+AYxUUVy1dO
X-Gm-Message-State: AOJu0YwOLNCGFOSUnN+ApOEYo33VGwMDgR5QAw9jH379tensqUZT8YQp
 L7LblhBsR3MbTChsmYigU0lqYpniT+MlJudDVz2hPOx2bQf04Baz7AUyDf2D2pI=
X-Google-Smtp-Source: AGHT+IFJJxMYg0TP0UEwCYa/y+jNm4u4anAjhlnmR8IMi17UrIjCCksLKesHrMnQtMGV7dKJSm4xHg==
X-Received: by 2002:a05:6a20:2443:b0:1a1:1022:45f0 with SMTP id
 t3-20020a056a20244300b001a1102245f0mr2450932pzc.54.1710262865335; 
 Tue, 12 Mar 2024 10:01:05 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.10.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:01:03 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 33/38] spapr: nested: Extend nested_ppc_state for nested PAPR
 API
Date: Wed, 13 Mar 2024 02:58:44 +1000
Message-ID: <20240312165851.2240242-34-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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

Currently, nested_ppc_state stores a certain set of registers and works
with nested_[load|save]_state() for state transfer as reqd for nested-hv API.
Extending these with additional registers state as reqd for nested PAPR API.

Acked-by: Nicholas Piggin <npiggin@gmail.com>
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_nested.c         | 106 ++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_nested.h |  50 ++++++++++++++++
 target/ppc/cpu.h              |   2 +
 3 files changed, 158 insertions(+)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 72bf3dc6d4..6a2ff963c6 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -108,6 +108,7 @@ static target_ulong h_copy_tofrom_guest(PowerPCCPU *cpu,
 static void nested_save_state(struct nested_ppc_state *save, PowerPCCPU *cpu)
 {
     CPUPPCState *env = &cpu->env;
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
 
     memcpy(save->gpr, env->gpr, sizeof(save->gpr));
 
@@ -134,6 +135,58 @@ static void nested_save_state(struct nested_ppc_state *save, PowerPCCPU *cpu)
     save->pidr = env->spr[SPR_BOOKS_PID];
     save->ppr = env->spr[SPR_PPR];
 
+    if (spapr_nested_api(spapr) == NESTED_API_PAPR) {
+        save->pvr = env->spr[SPR_PVR];
+        save->amor = env->spr[SPR_AMOR];
+        save->dawr0 = env->spr[SPR_DAWR0];
+        save->dawrx0 = env->spr[SPR_DAWRX0];
+        save->ciabr = env->spr[SPR_CIABR];
+        save->purr = env->spr[SPR_PURR];
+        save->spurr = env->spr[SPR_SPURR];
+        save->ic = env->spr[SPR_IC];
+        save->vtb = env->spr[SPR_VTB];
+        save->hdar = env->spr[SPR_HDAR];
+        save->hdsisr = env->spr[SPR_HDSISR];
+        save->heir = env->spr[SPR_HEIR];
+        save->asdr = env->spr[SPR_ASDR];
+        save->dawr1 = env->spr[SPR_DAWR1];
+        save->dawrx1 = env->spr[SPR_DAWRX1];
+        save->dexcr = env->spr[SPR_DEXCR];
+        save->hdexcr = env->spr[SPR_HDEXCR];
+        save->hashkeyr = env->spr[SPR_HASHKEYR];
+        save->hashpkeyr = env->spr[SPR_HASHPKEYR];
+        memcpy(save->vsr, env->vsr, sizeof(save->vsr));
+        save->ebbhr = env->spr[SPR_EBBHR];
+        save->tar = env->spr[SPR_TAR];
+        save->ebbrr = env->spr[SPR_EBBRR];
+        save->bescr = env->spr[SPR_BESCR];
+        save->iamr = env->spr[SPR_IAMR];
+        save->amr = env->spr[SPR_AMR];
+        save->uamor = env->spr[SPR_UAMOR];
+        save->dscr = env->spr[SPR_DSCR];
+        save->fscr = env->spr[SPR_FSCR];
+        save->pspb = env->spr[SPR_PSPB];
+        save->ctrl = env->spr[SPR_CTRL];
+        save->vrsave = env->spr[SPR_VRSAVE];
+        save->dar = env->spr[SPR_DAR];
+        save->dsisr = env->spr[SPR_DSISR];
+        save->pmc1 = env->spr[SPR_POWER_PMC1];
+        save->pmc2 = env->spr[SPR_POWER_PMC2];
+        save->pmc3 = env->spr[SPR_POWER_PMC3];
+        save->pmc4 = env->spr[SPR_POWER_PMC4];
+        save->pmc5 = env->spr[SPR_POWER_PMC5];
+        save->pmc6 = env->spr[SPR_POWER_PMC6];
+        save->mmcr0 = env->spr[SPR_POWER_MMCR0];
+        save->mmcr1 = env->spr[SPR_POWER_MMCR1];
+        save->mmcr2 = env->spr[SPR_POWER_MMCR2];
+        save->mmcra = env->spr[SPR_POWER_MMCRA];
+        save->sdar = env->spr[SPR_POWER_SDAR];
+        save->siar = env->spr[SPR_POWER_SIAR];
+        save->sier = env->spr[SPR_POWER_SIER];
+        save->vscr = ppc_get_vscr(env);
+        save->fpscr = env->fpscr;
+    }
+
     save->tb_offset = env->tb_env->tb_offset;
 }
 
@@ -141,6 +194,7 @@ static void nested_load_state(PowerPCCPU *cpu, struct nested_ppc_state *load)
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
 
     memcpy(env->gpr, load->gpr, sizeof(env->gpr));
 
@@ -167,6 +221,58 @@ static void nested_load_state(PowerPCCPU *cpu, struct nested_ppc_state *load)
     env->spr[SPR_BOOKS_PID] = load->pidr;
     env->spr[SPR_PPR] = load->ppr;
 
+    if (spapr_nested_api(spapr) == NESTED_API_PAPR) {
+        env->spr[SPR_PVR] = load->pvr;
+        env->spr[SPR_AMOR] = load->amor;
+        env->spr[SPR_DAWR0] = load->dawr0;
+        env->spr[SPR_DAWRX0] = load->dawrx0;
+        env->spr[SPR_CIABR] = load->ciabr;
+        env->spr[SPR_PURR] = load->purr;
+        env->spr[SPR_SPURR] = load->purr;
+        env->spr[SPR_IC] = load->ic;
+        env->spr[SPR_VTB] = load->vtb;
+        env->spr[SPR_HDAR] = load->hdar;
+        env->spr[SPR_HDSISR] = load->hdsisr;
+        env->spr[SPR_HEIR] = load->heir;
+        env->spr[SPR_ASDR] = load->asdr;
+        env->spr[SPR_DAWR1] = load->dawr1;
+        env->spr[SPR_DAWRX1] = load->dawrx1;
+        env->spr[SPR_DEXCR] = load->dexcr;
+        env->spr[SPR_HDEXCR] = load->hdexcr;
+        env->spr[SPR_HASHKEYR] = load->hashkeyr;
+        env->spr[SPR_HASHPKEYR] = load->hashpkeyr;
+        memcpy(env->vsr, load->vsr, sizeof(env->vsr));
+        env->spr[SPR_EBBHR] = load->ebbhr;
+        env->spr[SPR_TAR] = load->tar;
+        env->spr[SPR_EBBRR] = load->ebbrr;
+        env->spr[SPR_BESCR] = load->bescr;
+        env->spr[SPR_IAMR] = load->iamr;
+        env->spr[SPR_AMR] = load->amr;
+        env->spr[SPR_UAMOR] = load->uamor;
+        env->spr[SPR_DSCR] = load->dscr;
+        env->spr[SPR_FSCR] = load->fscr;
+        env->spr[SPR_PSPB] = load->pspb;
+        env->spr[SPR_CTRL] = load->ctrl;
+        env->spr[SPR_VRSAVE] = load->vrsave;
+        env->spr[SPR_DAR] = load->dar;
+        env->spr[SPR_DSISR] = load->dsisr;
+        env->spr[SPR_POWER_PMC1] = load->pmc1;
+        env->spr[SPR_POWER_PMC2] = load->pmc2;
+        env->spr[SPR_POWER_PMC3] = load->pmc3;
+        env->spr[SPR_POWER_PMC4] = load->pmc4;
+        env->spr[SPR_POWER_PMC5] = load->pmc5;
+        env->spr[SPR_POWER_PMC6] = load->pmc6;
+        env->spr[SPR_POWER_MMCR0] = load->mmcr0;
+        env->spr[SPR_POWER_MMCR1] = load->mmcr1;
+        env->spr[SPR_POWER_MMCR2] = load->mmcr2;
+        env->spr[SPR_POWER_MMCRA] = load->mmcra;
+        env->spr[SPR_POWER_SDAR] = load->sdar;
+        env->spr[SPR_POWER_SIAR] = load->siar;
+        env->spr[SPR_POWER_SIER] = load->sier;
+        ppc_store_vscr(env, load->vscr);
+        ppc_store_fpscr(env, load->fpscr);
+    }
+
     env->tb_env->tb_offset = load->tb_offset;
 
     /*
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 2ac3076fac..d232014ccb 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -7,6 +7,7 @@ typedef struct SpaprMachineStateNested {
     uint64_t ptcr;
     uint8_t api;
 #define NESTED_API_KVM_HV  1
+#define NESTED_API_PAPR    2
     bool capabilities_set;
     uint32_t pvr_base;
     GHashTable *guests;
@@ -121,6 +122,55 @@ struct nested_ppc_state {
     uint64_t ppr;
 
     int64_t tb_offset;
+    /* Nested PAPR API */
+    uint64_t amor;
+    uint64_t dawr0;
+    uint64_t dawrx0;
+    uint64_t ciabr;
+    uint64_t purr;
+    uint64_t spurr;
+    uint64_t ic;
+    uint64_t vtb;
+    uint64_t hdar;
+    uint64_t hdsisr;
+    uint64_t heir;
+    uint64_t asdr;
+    uint64_t dawr1;
+    uint64_t dawrx1;
+    uint64_t dexcr;
+    uint64_t hdexcr;
+    uint64_t hashkeyr;
+    uint64_t hashpkeyr;
+    ppc_vsr_t vsr[64] QEMU_ALIGNED(16);
+    uint64_t ebbhr;
+    uint64_t tar;
+    uint64_t ebbrr;
+    uint64_t bescr;
+    uint64_t iamr;
+    uint64_t amr;
+    uint64_t uamor;
+    uint64_t dscr;
+    uint64_t fscr;
+    uint64_t pspb;
+    uint64_t ctrl;
+    uint64_t vrsave;
+    uint64_t dar;
+    uint64_t dsisr;
+    uint64_t pmc1;
+    uint64_t pmc2;
+    uint64_t pmc3;
+    uint64_t pmc4;
+    uint64_t pmc5;
+    uint64_t pmc6;
+    uint64_t mmcr0;
+    uint64_t mmcr1;
+    uint64_t mmcr2;
+    uint64_t mmcra;
+    uint64_t sdar;
+    uint64_t siar;
+    uint64_t sier;
+    uint32_t vscr;
+    uint64_t fpscr;
 };
 
 typedef struct SpaprMachineStateNestedGuestVcpu {
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 7c48b2eadb..be5f74a7cd 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1755,9 +1755,11 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_PSPB              (0x09F)
 #define SPR_DPDES             (0x0B0)
 #define SPR_DAWR0             (0x0B4)
+#define SPR_DAWR1             (0x0B5)
 #define SPR_RPR               (0x0BA)
 #define SPR_CIABR             (0x0BB)
 #define SPR_DAWRX0            (0x0BC)
+#define SPR_DAWRX1            (0x0BD)
 #define SPR_HFSCR             (0x0BE)
 #define SPR_VRSAVE            (0x100)
 #define SPR_USPRG0            (0x100)
-- 
2.42.0


