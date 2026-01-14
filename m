Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BF6D31A09
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfspA-0007bW-AH; Tue, 13 Jan 2026 23:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfson-0007Al-IK
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:49:20 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsol-0004BW-HH
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:49:16 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a102494058so2248455ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366154; x=1768970954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3eKZ10Amt60QMkjRz6h5QFY2aN0VC8P3myZNHWyL8sw=;
 b=mG09vu9B7hnwc+pjHqFNwwnOgtzkgJQJva8OkxKmLHQbjDDrxFOpTENvRowUB3bAj8
 I91S37qlbayiPxy5HG2dPFSIetZjSu9HV841hDWE3VKq/j7vSzuCpsD1L1mAVm+MAadi
 auAkn+a8Mvw6aeQ9yFIt0l8O8gWhN0OKMBHg2FdhI+RaacS0Z6zuZ8u0CZFgiPj91DLK
 mrzAENnFWPebQuNblT728h/fcV5+wnwghAjah3udrAV6cG21Zkwu0oDzlvdwVJwsDDuc
 S7D03ip4XQDaDVDk3auRAMDDIHhlCB2d6fkUkJQLFQ/Du1SALnqUH8x1LOg7NfO/mJBE
 Ia1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366154; x=1768970954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3eKZ10Amt60QMkjRz6h5QFY2aN0VC8P3myZNHWyL8sw=;
 b=KwT6bTRMmdM0SnR/68EbNuRIYJ0ycvefUxscktjS2XGTpswDCnG+lCakttnPiiErBO
 l8TGLkBbn588L+trY+tDYYjo/qU2uLAqaSVfA7qNgBOw6xSZHplG3jTQL0gWTAKTKu0m
 mqlDsC5KNsJsfOAipOL8bHgxOlNrJMTDJzGj7lIFLQ/1mR8VGa1pE++U5Q5YgqBqSP5G
 s/rsIzlppHZHqS2Syh/9HsH85GPxhHcIUkYt8K5PnN9Qppx29gzYo8ghnKThiKZ+/xp0
 Y9yMthjaL5caewV6guBPwWw7K5QDXNjH94K53TSUEb1qV0lMTdUL0g1ovZQ9C0iWhmc6
 PYZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqTC9B1US+rFp9xuBZ6WfwPF2c8LkyeaqGEALO964zm9CBmZnXW6BSMzyswB2AXiuX1V52Dd270MMH@nongnu.org
X-Gm-Message-State: AOJu0YxqXcjb0iVDzSSCbyPIdGcu+9lxxRPToKNp7dl8Ka0ICjf4jaog
 VL5+k4CLBcLuk1NNVEak593byaVip4iIu8xnPSDmaf4JefgAw9TUDntY
X-Gm-Gg: AY/fxX5+HaSchUXnThAwHN+oeOUpC3yGXKQZ9ocd3zhk4rUGUfpFEA67J4QHfeZAnJU
 756VLbtx/eG9ld7w3qdxwyGz0d/abs66i2sEHSrcmi5Ba752rBYdPHPizoje7VpoG3sgfOkWvnn
 QoW//+aEZXoytVypIyylR/HulGz6WybRChpmwJ25MC85pyszKidSvq4HQbNeupr1SqwwpYxhXH7
 Kdvu1HaqXkR7dxDkodGYG1YOogRTALleqczkLu4sLHicVbxiiTZfzcHkaQ6YABR5qohMeSabeiE
 0WEM99b8665PD5/WHrKDCEqh9NeOJkLluKl+C1ON3Dpseb8yUfozIPQ0SCahXUwJXWrHOCrrazX
 o8o6AFBNPYRa/azPxVuGgPabs/gbCtnfl00Ee1PhMUYBVm3UDl5QQiJQWCw6PezAwFPHnQm0pve
 xMprlN7RYAwpFcdNWFLoXIQf/bR0ltajrPmy+zeq5N7N5aifDp46UVJE1f1oU=
X-Received: by 2002:a17:903:41c3:b0:2a0:f0bf:197a with SMTP id
 d9443c01a7336-2a599dac241mr14070195ad.13.1768366154198; 
 Tue, 13 Jan 2026 20:49:14 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:49:13 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
Subject: [RFC PATCH 22/25] target/riscv/debug: Support heterogeneous trigger
 types
Date: Wed, 14 Jan 2026 14:46:55 +1000
Message-ID: <20260114044701.1173347-23-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Not all Sdtrig implementations have heterogeneous triggers. Add
support to the CPU class Sdtrig config to specify the trigger
types that each trigger supports.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/cpu.c   |  8 ++++++++
 target/riscv/debug.c | 17 +++++++++++++----
 target/riscv/debug.h |  5 +++++
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6f7a327fc7..5708da5054 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2961,6 +2961,14 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
 /* Sdtrig implementation has 2 triggers that support match, match6, icount */
 static const RISCVSdtrigConfig default_sdtrig_config = {
     .nr_triggers = 2,
+    .triggers = {
+        [0 ... 1] = {
+            .type_mask = (1 << TRIGGER_TYPE_AD_MATCH) |
+                         (1 << TRIGGER_TYPE_AD_MATCH6) |
+                         (1 << TRIGGER_TYPE_INST_CNT) |
+                         (1 << TRIGGER_TYPE_UNAVAIL),
+        },
+    },
 };
 
 bool riscv_sdtrig_default_implementation(const RISCVSdtrigConfig *config)
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 93615b43fb..e8d343bf42 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -845,11 +845,19 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
     }
 
     if (tdata_index == TDATA1) {
+        CPUState *cs = env_cpu(env);
+        RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
+
         if (val == 0) {
             /* special case, writing 0 results in disabled trigger */
             val = build_tdata1(env, TRIGGER_TYPE_UNAVAIL, 0, 0);
         }
         trigger_type = extract_trigger_type(env, val);
+        if (!(mcc->def->debug_cfg->triggers[index].type_mask &
+              (1 << trigger_type))) {
+            val = build_tdata1(env, TRIGGER_TYPE_UNAVAIL, 0, 0);
+            trigger_type = extract_trigger_type(env, val);
+        }
     }
 
     switch (trigger_type) {
@@ -887,11 +895,12 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
 
 target_ulong tinfo_csr_read(CPURISCVState *env)
 {
-    /* assume all triggers support the same types of triggers */
+    CPUState *cs = env_cpu(env);
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
+    target_ulong index = env->sdtrig_state.trigger_cur;
+
     /* XXX: should we set 1 (version 1.0) in the version field? */
-    return BIT(TRIGGER_TYPE_AD_MATCH) |
-           BIT(TRIGGER_TYPE_INST_CNT) |
-           BIT(TRIGGER_TYPE_AD_MATCH6);
+    return mcc->def->debug_cfg->triggers[index].type_mask;
 }
 
 void riscv_cpu_debug_excp_handler(CPUState *cs)
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index 3ba12f95cd..f9e840d615 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -135,8 +135,13 @@ enum {
 #define MHSELECT_IGNORE       0
 #define MHSELECT_MCONTEXT     4
 
+struct trigger_properties {
+    uint16_t type_mask; /* Trigger types supported (0 = no trigger here) */
+};
+
 typedef struct RISCVSdtrigConfig {
     unsigned int nr_triggers;
+    struct trigger_properties triggers[RV_MAX_SDTRIG_TRIGGERS];
 } RISCVSdtrigConfig;
 
 bool tdata_available(CPURISCVState *env, int tdata_index);
-- 
2.51.0


