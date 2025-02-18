Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B05EC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQvQ-0006iN-Io; Tue, 18 Feb 2025 11:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkQvL-0006hT-Gp
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:58:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkQvJ-0004PG-Sx
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739897896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2BbDNRK96mmo/Qz7zUcwEQmp042aAATtMb3Z2v/Sxw0=;
 b=gS+DrNPru7trO/S1RbrAACB4EhYUd0bFZTFzABmMvUtNky0uBEiC9ods4vIj6m0YSiwcRh
 j166pvU4je5/S5rp6WSki/K18tIRabCooSrDzP51dc3/ysXMDBqh9wrcadgwDZwuSAuxpv
 QUHUbANMxxoJ8vB9FMLbHox7O76FnEY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-On3NNbgzPJuaCtNgYoIMNw-1; Tue, 18 Feb 2025 11:58:14 -0500
X-MC-Unique: On3NNbgzPJuaCtNgYoIMNw-1
X-Mimecast-MFC-AGG-ID: On3NNbgzPJuaCtNgYoIMNw_1739897894
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43998ec3733so1959675e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:58:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739897893; x=1740502693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2BbDNRK96mmo/Qz7zUcwEQmp042aAATtMb3Z2v/Sxw0=;
 b=khbT+vHVmEHmYAuiyElWDOwnnc6Gal+Q9TYDdN/ieZEy2bL9jdxOZGeoaJI9yWbEZ1
 REcSn8S0T7fYN5HmqSgCL3RNO7/S5v/L1BoUD/Gy8KuFCzDV53rSQWR9uYFBGyYDuL5e
 kDrAFiPXTbrRZxyo7xZtSmTGJZ40Y6x8PWxvVU2eWTzl/+HTmSn7qdncgJsZejZQG465
 uJoPsm+pmHlWCgt0GJP5zgczCYALM30f6EPaEyUBw6vo7Hlaoa/EGBZVqbbxL5nDp+k9
 8QbTjnTzTxygFPS5SveoxkzsqoHOOoNIz26BZEcyy4Q84LwoR9YZjqo9kqB5bX+Z5kDA
 P0nQ==
X-Gm-Message-State: AOJu0YwVHL27CfI5gM1pQwcAXcuLNPk1BPfnoXNke+VC4g2FQakxUvMY
 yN2Iiw0Hej3g8MDrCkuMww6qazXLoqxJU1dAop8CSsKj8Ce2rxnzPNeTkjIkVaUWEB9XDUXUuS2
 qfRL2V6yIc3RqM8xBQfOlvowA4G1fjwV4vs2N6ruTr08974n8JtwNb6HNxx/GJD6xgmlxHoFCl+
 kZMFIApmvZgi1A2Mp0B3G/vVoajhrkwjziXfigopc=
X-Gm-Gg: ASbGnctCBjn6RNDFzfKHvoth4W1oD4S+t9h5lsnDcs40GJxspGZAtbdClPlNdR2yz02
 epAVAX11mhPNqJUGujioh+fMmeUsENeTEX43DDrbpB88KN/CGhMlTxh+S1ZaG2dzIAfQNzBkHyR
 4g9bxEL5Y73V4Qc43Aiwe+BjKx1D4vnWY6ynhyS73gRXGno2slXKQrbB5NaCL+AnzsxkY6K7bA1
 qzHfk37MmToZmPkLOVT6OArxv5ku774QVkGyAHENWeMRVGl1hwuZXJO2RjURucGrzG396WLgf/7
 ZLxhZnBeCK0=
X-Received: by 2002:a05:600c:154f:b0:434:a902:97cd with SMTP id
 5b1f17b1804b1-4396e6fa332mr130888795e9.12.1739897893221; 
 Tue, 18 Feb 2025 08:58:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvFxfvAQaskhKwOp8avqvoJtAFDP9DK9p9ELbSSt2y2DfhVSA3VYZ4PtRv3s/2cu1c1gh+Ng==
X-Received: by 2002:a05:600c:154f:b0:434:a902:97cd with SMTP id
 5b1f17b1804b1-4396e6fa332mr130888525e9.12.1739897892783; 
 Tue, 18 Feb 2025 08:58:12 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43984924201sm64793375e9.6.2025.02.18.08.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:58:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 7/7] target/riscv: move satp_mode.{map,init} out of CPUConfig
Date: Tue, 18 Feb 2025 17:57:57 +0100
Message-ID: <20250218165757.554178-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218165757.554178-1-pbonzini@redhat.com>
References: <20250218165757.554178-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

They are used to provide the nice QOM properties for svNN,
but the canonical source of the CPU configuration is now
cpu->cfg.max_satp_mode.  Store them in the ArchCPU struct.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h     | 14 ++++++++++++++
 target/riscv/cpu_cfg.h | 14 --------------
 target/riscv/cpu.c     | 32 ++++++++++++++++----------------
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f9b223bf8a7..df7a05e7d15 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -492,6 +492,19 @@ struct CPUArchState {
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
@@ -508,6 +521,7 @@ struct ArchCPU {
 
     /* Configuration Settings */
     RISCVCPUConfig cfg;
+    RISCVSATPModes satp_modes;
 
     QEMUTimer *pmu_timer;
     /* A bitmask of Available programmable counters */
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 1d7fff8decd..7b7067d5bee 100644
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
@@ -191,7 +178,6 @@ struct RISCVCPUConfig {
 
 #ifndef CONFIG_USER_ONLY
     int8_t max_satp_mode;
-    RISCVSATPMap satp_mode;
 #endif
 };
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 86a048b62c5..8ab7fe2e286 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1197,8 +1197,8 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (cpu->cfg.satp_mode.map == 0) {
-        if (cpu->cfg.satp_mode.init == 0) {
+    if (cpu->satp_modes.map == 0) {
+        if (cpu->satp_modes.init == 0) {
             /* If unset by the user, we fallback to the default satp mode. */
             set_satp_mode_default_map(cpu);
         } else {
@@ -1208,7 +1208,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
              * valid_vm_1_10_32/64.
              */
             for (int i = 1; i < 16; ++i) {
-                if ((cpu->cfg.satp_mode.init & (1 << i)) &&
+                if ((cpu->satp_modes.init & (1 << i)) &&
                     supported & (1 << i)) {
                     for (int j = i - 1; j >= 0; --j) {
                         if (supported & (1 << j)) {
@@ -1222,7 +1222,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    satp_mode_map_max = satp_mode_max_from_map(cpu->cfg.satp_mode.map);
+    satp_mode_map_max = satp_mode_max_from_map(cpu->satp_modes.map);
 
     /* Make sure the user asked for a supported configuration (HW and qemu) */
     if (satp_mode_map_max > cpu->cfg.max_satp_mode) {
@@ -1238,8 +1238,8 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
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
@@ -1327,11 +1327,11 @@ bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu)
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
@@ -1339,7 +1339,7 @@ static void cpu_riscv_get_satp(Object *obj, Visitor *v, const char *name,
 static void cpu_riscv_set_satp(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    RISCVSATPMap *satp_map = opaque;
+    RISCVSATPModes *satp_modes = opaque;
     uint8_t satp = satp_mode_from_str(name);
     bool value;
 
@@ -1347,8 +1347,8 @@ static void cpu_riscv_set_satp(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    satp_map->map = deposit32(satp_map->map, satp, 1, value);
-    satp_map->init |= 1 << satp;
+    satp_modes->map = deposit32(satp_modes->map, satp, 1, value);
+    satp_modes->init |= 1 << satp;
 }
 
 void riscv_add_satp_mode_properties(Object *obj)
@@ -1357,16 +1357,16 @@ void riscv_add_satp_mode_properties(Object *obj)
 
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
2.48.1


