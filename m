Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1822C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKnj-0008PW-7u; Tue, 20 May 2025 07:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnR-0007ae-VM
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnP-000379-Uw
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pclGgII9H31kAnQAAEP1/Lu0tJNerW4w1K/5Ar8SzF4=;
 b=ha/w1qaRwS0mrcWhmBrvu77R7EbaDVP0nOGBgdm+OzH1XUL/r4I4lpgy4AvBCEVjymZDUB
 RHex5q4JcYW6nR1CCzzBcYlU1NFcF3R3uYJP6iQcYTnSN8QpMa4vbsEhOL9JhW9mb1cyA6
 tIdSWrH9uQuA/G+/0x4eisNOx4TpLOI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-lieydUO1MwelzMujmcXrsA-1; Tue, 20 May 2025 07:06:05 -0400
X-MC-Unique: lieydUO1MwelzMujmcXrsA-1
X-Mimecast-MFC-AGG-ID: lieydUO1MwelzMujmcXrsA_1747739165
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad56437a03eso190598266b.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739164; x=1748343964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pclGgII9H31kAnQAAEP1/Lu0tJNerW4w1K/5Ar8SzF4=;
 b=u6HewECwmYcjucTxpIGE2UUsR16TC83vQpeea9BtB0VFQRFhJAJ+SZqxOHzQssH10q
 rPsT+Ju8dTmwPoK75N02/Gn6rVcMfZ+SNpS+iRmYZ/8kuDqfHWFVTCyw/0jtIWec25JK
 zme0nmRLXQsBFeWqjJmGHrJVDvGZ4lwJDFAOa9QoshLn9MYCTNwZAdSfEi2Nc7QSsa+P
 R7HCKqV28EK38Jk3x2epoVOc7DhueCrnSQmU1RrJdb4GG9NtBOEezeK3NPxP3MfHStDu
 VJPjKQuJnxoW7H765fQVN2UJEdkU/KcRCQMUTpQMhNqndd5HbUB5o0aDooIcweBhlRUm
 dD+A==
X-Gm-Message-State: AOJu0Ywbav7kOHdmIcz3gqX7OISfk3LBCMKHQbdVvEUYzqQfhwWz0DKn
 l4NuaVaYO6e5nBSnRjeQgLrHrMZmj9CmUdZKHeeX8magZ/FkMq/anz8aEr1QhdswM0Ljl7ZjEyZ
 BGBIIW27Lip6q99HjgY42hQrEyail7VL8rFF9zQYMKynSMnkwNeXPWVUO0VRB/3lA7li7aTfCHL
 pZ7xzwDQFmRzB71guV4sS/dpbfCSQmjXpgn6S+xNnv
X-Gm-Gg: ASbGnctD0IzdU2DkuCC4TEfYJQ7neZ5KZkjs0jKLTYPUkZPxNPtSj6ulFmEpEJNZkED
 XsCmuJhIByZTzr6K+E3cr7U4sGlSLYP3+v9v9OjNhkO1yYDf9SEQ7vDBY5EDScJbICoR/Qt3NJY
 0TkvgsnzxgyejIt8fTb0aTteQMZ4I81aBiZ1FnFPIvCTszfOzG7QJg3f40Q67fYnUkyI8SCm9+0
 2XvluufeYZFpYwEuemQlhyrutU4x+j8YYvPv0L+iiHrXZv30TD8onNMGRloWPzPBCiovi9ji8q9
 aHC3eUEpJkK/yg==
X-Received: by 2002:a17:907:c21:b0:ad2:28be:9a16 with SMTP id
 a640c23a62f3a-ad536f280cbmr1348924166b.51.1747739164199; 
 Tue, 20 May 2025 04:06:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlXPn0UvUgq6Gd5dQIKpoX2TmKQpCnj+jyS7nsRzP9ub3aWGnvRK2fADinHJjehb1d4xCTzQ==
X-Received: by 2002:a17:907:c21:b0:ad2:28be:9a16 with SMTP id
 a640c23a62f3a-ad536f280cbmr1348920766b.51.1747739163754; 
 Tue, 20 May 2025 04:06:03 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d497214sm716844266b.146.2025.05.20.04.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:06:01 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/35] target/riscv: move satp_mode.{map, init} out of CPUConfig
Date: Tue, 20 May 2025 13:05:09 +0200
Message-ID: <20250520110530.366202-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index 3d89a4a83ba..731ea2540cd 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -499,6 +499,19 @@ struct CPUArchState {
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
@@ -515,6 +528,7 @@ struct ArchCPU {
 
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


