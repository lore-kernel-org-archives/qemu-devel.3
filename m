Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41427C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPr6-0007dF-Of; Mon, 12 May 2025 05:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPql-0007a6-Bu
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqi-0000gK-DD
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GEfhgjcPT/GBUnM84bK7bsIsAMy9sqc6j75hmuztNz8=;
 b=LrRYBMAIF75WHUsWSK9hJatEkkxkzujeN5cX65mZXTydzCWzbKpXXyXFSsRHKjc335Edq2
 24tSfkoUO+ZTaICfR0fJ87JoxlH+Jd2t+trsbxr+F7X4uh6tEnLJ52Oq54YkhiPgtezy4R
 0WP0hs6RlxUF76s7GXBwyuShx2xBmjc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-LcdToKYtPseFo94yEygRfQ-1; Mon, 12 May 2025 05:53:26 -0400
X-MC-Unique: LcdToKYtPseFo94yEygRfQ-1
X-Mimecast-MFC-AGG-ID: LcdToKYtPseFo94yEygRfQ_1747043605
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad224fe3745so277771466b.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043604; x=1747648404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GEfhgjcPT/GBUnM84bK7bsIsAMy9sqc6j75hmuztNz8=;
 b=XUpd6lcY+1cmoB2zYkJzErjNfOkMEVci3U1NdGCQQEMXZ4me9LCaZBR4PglCJyB7JG
 6o8XdSh0jy/7X0LVHQ0iqAAPSour0kvKaX4GOp1CwZStT9PpmFsq7YEKwakwqonEDwtm
 WdqWpPO2f/IJiU9SIbL2+frohQAIAO0y9UiXqIozhbSaWDh5mKmcnYHfkRflUOvB6h07
 Xbkr/eIl/9JKgQub0HT9nt7mqa9YRNvIhls4rX1hODAfArOOzg0o40l2WO0PIHYCY7Ck
 X8jhI5/WQXfubCH08tcmWnNTUULrXPqAhnWFV/VzC9Wam5cV7zjqrjtfPXL0CYaxo9EJ
 qUmw==
X-Gm-Message-State: AOJu0YxRgmJ/98LnRTzKLhwSJMcamhvL+ZwzjoIssscl+i899qVXsEmP
 vvs6TF87QC0+SB+M3uCp7xRoZL23v9JBWYgcqcwz/YFdHk5mdK8+Rqxl9k71cBJPjru2B6bWZD2
 ffBvM4O7z3fMTc5U0NswZOtQ6gSwBzTepME1F2HTFOQTXmddyj10dqYhG+rJQAYeTgHDuJnbWzk
 SuP3WeTiNmIWG7ky57neyqGWRjxKag3HEIstZO
X-Gm-Gg: ASbGnctBFsoeEuETWvu2ASHJhEVwLFFUZVi10ffyxKvLiL/CSgPei8c+ahoQXiL4td3
 if0q82ec5mS85SKAGrEt2Nlt3RfPO8HK9IxVoW3JWt3h//UK9XjNbDjM4+bYhrzAeRDd/VWeMEI
 UfsY2tRwNqT9yBBwONM5KKRiVdj3BmCH23WIKZDovUDGLHmhLKiGMznM8+Vowt293wuPimhQ+Mk
 AEnNbmjf2o4Ms9zYYwUxjv46+5FSC6h9R00EL6l1YEFhp8tQFgsZdxl9RhHCXrqNxGP6ihQwqNL
 I6apzkKbp5pMany3TRYKwtTVHmlINMI2Z7PklrM9RJpmMwg=
X-Received: by 2002:a17:907:7da2:b0:abf:7453:1f1a with SMTP id
 a640c23a62f3a-ad219024691mr1138234666b.36.1747043604021; 
 Mon, 12 May 2025 02:53:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/zWKYXpde/tH0Xw6WmsbYu7rcQXtt6CfMyvR4hVKfbia2OWirFuAbBfcLaSehngdcI4ofKQ==
X-Received: by 2002:a17:907:7da2:b0:abf:7453:1f1a with SMTP id
 a640c23a62f3a-ad219024691mr1138232366b.36.1747043603496; 
 Mon, 12 May 2025 02:53:23 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2197bd479sm588780066b.151.2025.05.12.02.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:53:22 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 05/26] target/riscv: move satp_mode.{map,
 init} out of CPUConfig
Date: Mon, 12 May 2025 11:52:05 +0200
Message-ID: <20250512095226.93621-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512095226.93621-1-pbonzini@redhat.com>
References: <20250512095226.93621-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Paolo Bonzini <pbonzini@redhat.com>
From:  Paolo Bonzini via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

They are used to provide the nice QOM properties for svNN,
but the canonical source of the CPU configuration is now
cpu->cfg.max_satp_mode.  Store them in the ArchCPU struct.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h     | 14 ++++++++++++++
 target/riscv/cpu_cfg.h | 14 --------------
 target/riscv/cpu.c     | 32 ++++++++++++++++----------------
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 852e4681e3d..8b23aa27740 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -498,6 +498,19 @@ struct CPUArchState {
     uint64_t rnmi_excpvec;
 };
 
+/*
+ * map is a 16-bit bitmap: the most significant set bit in map is the maximum
+ * satp mode that is supported. It may be chosen by the user and must respect
+ * what qemu implements (valid_1_10_32/64) and what the hw is capable of
+ * (supported bitmap below).
+ *
+ * init is a 16-bit bitmap used to make sure the user selected a correct
+ * configuration as per the specification.
+ */
+typedef struct {
+    uint16_t map, init;
+} RISCVSATPModes;
+
 /*
  * RISCVCPU:
  * @env: #CPURISCVState
@@ -514,6 +527,7 @@ struct ArchCPU {
 
     /* Configuration Settings */
     RISCVCPUConfig cfg;
+    RISCVSATPModes satp_modes;
 
     QEMUTimer *pmu_timer;
     /* A bitmask of Available programmable counters */
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 8b80e03c9ab..8fa73c8a07d 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -21,19 +21,6 @@
 #ifndef RISCV_CPU_CFG_H
 #define RISCV_CPU_CFG_H
 
-/*
- * map is a 16-bit bitmap: the most significant set bit in map is the maximum
- * satp mode that is supported. It may be chosen by the user and must respect
- * what qemu implements (valid_1_10_32/64) and what the hw is capable of
- * (supported bitmap below).
- *
- * init is a 16-bit bitmap used to make sure the user selected a correct
- * configuration as per the specification.
- */
-typedef struct {
-    uint16_t map, init;
-} RISCVSATPMap;
-
 struct RISCVCPUConfig {
     bool ext_zba;
     bool ext_zbb;
@@ -195,7 +182,6 @@ struct RISCVCPUConfig {
     bool short_isa_string;
 
     int8_t max_satp_mode;
-    RISCVSATPMap satp_mode;
 };
 
 typedef struct RISCVCPUConfig RISCVCPUConfig;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0326cd8e563..54a996c2927 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1192,8 +1192,8 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (cpu->cfg.satp_mode.map == 0) {
-        if (cpu->cfg.satp_mode.init == 0) {
+    if (cpu->satp_modes.map == 0) {
+        if (cpu->satp_modes.init == 0) {
             /* If unset by the user, we fallback to the default satp mode. */
             set_satp_mode_default_map(cpu);
         } else {
@@ -1203,7 +1203,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
              * valid_vm_1_10_32/64.
              */
             for (int i = 1; i < 16; ++i) {
-                if ((cpu->cfg.satp_mode.init & (1 << i)) &&
+                if ((cpu->satp_modes.init & (1 << i)) &&
                     supported & (1 << i)) {
                     for (int j = i - 1; j >= 0; --j) {
                         if (supported & (1 << j)) {
@@ -1217,7 +1217,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    satp_mode_map_max = satp_mode_max_from_map(cpu->cfg.satp_mode.map);
+    satp_mode_map_max = satp_mode_max_from_map(cpu->satp_modes.map);
 
     /* Make sure the user asked for a supported configuration (HW and qemu) */
     if (satp_mode_map_max > cpu->cfg.max_satp_mode) {
@@ -1233,8 +1233,8 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
      */
     if (!rv32) {
         for (int i = satp_mode_map_max - 1; i >= 0; --i) {
-            if (!(cpu->cfg.satp_mode.map & (1 << i)) &&
-                (cpu->cfg.satp_mode.init & (1 << i)) &&
+            if (!(cpu->satp_modes.map & (1 << i)) &&
+                (cpu->satp_modes.init & (1 << i)) &&
                 (supported & (1 << i))) {
                 error_setg(errp, "cannot disable %s satp mode if %s "
                            "is enabled", satp_mode_str(i, false),
@@ -1322,11 +1322,11 @@ bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu)
 static void cpu_riscv_get_satp(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    RISCVSATPMap *satp_map = opaque;
+    RISCVSATPModes *satp_modes = opaque;
     uint8_t satp = satp_mode_from_str(name);
     bool value;
 
-    value = satp_map->map & (1 << satp);
+    value = satp_modes->map & (1 << satp);
 
     visit_type_bool(v, name, &value, errp);
 }
@@ -1334,7 +1334,7 @@ static void cpu_riscv_get_satp(Object *obj, Visitor *v, const char *name,
 static void cpu_riscv_set_satp(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    RISCVSATPMap *satp_map = opaque;
+    RISCVSATPModes *satp_modes = opaque;
     uint8_t satp = satp_mode_from_str(name);
     bool value;
 
@@ -1342,8 +1342,8 @@ static void cpu_riscv_set_satp(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    satp_map->map = deposit32(satp_map->map, satp, 1, value);
-    satp_map->init |= 1 << satp;
+    satp_modes->map = deposit32(satp_modes->map, satp, 1, value);
+    satp_modes->init |= 1 << satp;
 }
 
 void riscv_add_satp_mode_properties(Object *obj)
@@ -1352,16 +1352,16 @@ void riscv_add_satp_mode_properties(Object *obj)
 
     if (cpu->env.misa_mxl == MXL_RV32) {
         object_property_add(obj, "sv32", "bool", cpu_riscv_get_satp,
-                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mode);
+                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
     } else {
         object_property_add(obj, "sv39", "bool", cpu_riscv_get_satp,
-                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mode);
+                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
         object_property_add(obj, "sv48", "bool", cpu_riscv_get_satp,
-                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mode);
+                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
         object_property_add(obj, "sv57", "bool", cpu_riscv_get_satp,
-                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mode);
+                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
         object_property_add(obj, "sv64", "bool", cpu_riscv_get_satp,
-                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mode);
+                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
     }
 }
 
-- 
2.49.0


