Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79903C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxbW-0002In-GC; Fri, 28 Feb 2025 05:28:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbP-0002ED-6H
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbM-0002yr-Db
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MI0byVGxKFmxRraPYdhc/7dY1u5bQ1zrvWhpPcsLxdw=;
 b=TwWRXEK3RnzSr6YVmGIGGHfNnfFdtOaGb6GA9651+svgb6Iptne4oPuZJcKchd14+x41h/
 yTtkF37Jw8Zwwg1d+T7ygp7TBNaoHxuBo3htEyWuTXSfB4LzixkcfBUMng0Ltd0sAgTrZu
 R2c4hqGg+IqdmLUZlsWePdXoEhz6iWI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-QkQgQXajMZmFk6yC1-BGJA-1; Fri, 28 Feb 2025 05:28:14 -0500
X-MC-Unique: QkQgQXajMZmFk6yC1-BGJA-1
X-Mimecast-MFC-AGG-ID: QkQgQXajMZmFk6yC1-BGJA_1740738493
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-390e5214efdso1118133f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738492; x=1741343292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MI0byVGxKFmxRraPYdhc/7dY1u5bQ1zrvWhpPcsLxdw=;
 b=kOW/885B6lf2mc0pqNEkn/0gwLH3gEj6I+2uYkX5vp4Kt8jIb2xuYYNbC7OXF6mfn3
 hg/joYzmlWw+Qck8b6oegf7Rf0vMDbhMp7adAFztai9qMjlDRh5A7vaQdVTywC0vPHuT
 ttvzIUlnGQV4RfO6xMKW65CUBqB2dz+6MBJWpHcbGojmNcLk7eYaTph0vLjv2atD3wol
 p/27o2qUysyUueDYnqI8VQRoSzJmtUeoq4P2aNMCgtJAWRAu/jWUNCahn5vwLdiC54dM
 AnjkEonKlq7POLmry9II2OyrkApeZ1V6c5US3GjYxQtjQRxRuXy8SodMvQHsc9VMc1xw
 QuPw==
X-Gm-Message-State: AOJu0YymUD7ER7dxIWivOzDikNjSzKnWtARJ7DDhF1TDbzHLEQDQNQS4
 CTyxGJuhw6f+GziaZVUO2r5Nwa5aA2wt3iNd9wT+fk17WK7gokPE/83MfX5UE2e/eDJfwppkd3m
 f0wppP4BZXXcrXt+Tha04i2JUd5l5Di4PGNBKyH2XXABva1tAydx+27Xu/UYWZbREYA+QYp+Zqr
 y4N+tabuZE6yatVX7cInGeNck2atmDZoQFuxI9mt0=
X-Gm-Gg: ASbGncs6fVNHFi3i0EGwl8lmR6GwHo1G0l7Gn/V5tUggfo/PauacNWMicIEqdg4CarR
 sfkAohaNrfHaZnh1DFz3mvkbtylEpvvBWrAY/SFXxZ4WV8F9KQMFu2Iq4e9+L3C92OGcIt/0PlV
 pbljeDipRwDcf81uT3x24uhMF5Hl8CpckwEw92MCN3Svr9KtMNLjvY1cXzITK/iclPO3W2fAObg
 wJ0Jp9fT+ALF5BcSXf8+drgIGYfEgq0pW5Vqp+yMKmNcFdhFySbXR7HjoMato5fgds2wWJ9sDmw
 6uYyF9UlxT6DjDz278RY
X-Received: by 2002:a05:6000:1a86:b0:390:e9bd:d4f8 with SMTP id
 ffacd0b85a97d-390eca417a7mr2540384f8f.54.1740738492104; 
 Fri, 28 Feb 2025 02:28:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8R+Cv6/1gNfI1qBiki7i15KxewNlqsPDfzstsf75a2Awz0TCIN3kB4qqDZSdpcFd++7NjfA==
X-Received: by 2002:a05:6000:1a86:b0:390:e9bd:d4f8 with SMTP id
 ffacd0b85a97d-390eca417a7mr2540359f8f.54.1740738491685; 
 Fri, 28 Feb 2025 02:28:11 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e46f580bsm4752366f8f.0.2025.02.28.02.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:28:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 10/22] target/riscv: convert profile CPU models to RISCVCPUDef
Date: Fri, 28 Feb 2025 11:27:34 +0100
Message-ID: <20250228102747.867770-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228102747.867770-1-pbonzini@redhat.com>
References: <20250228102747.867770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Profile CPUs reuse the instance_init function for bare CPUs; make them
proper subclasses instead.  Enabling a profile is now done based on the
RISCVCPUDef struct: even though there is room for only one in RISCVCPUDef,
subclasses check that the parent class's profile is enabled through the
parent profile mechanism.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h |  1 +
 target/riscv/cpu.c | 59 +++++++++++++++++++++++++++++-----------------
 2 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2a8e1aa7d12..f00089bd733 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -533,6 +533,7 @@ struct ArchCPU {
 
 typedef struct RISCVCPUDef {
     RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
+    RISCVCPUProfile *profile;
     uint32_t misa_ext;
     int priv_spec;
     int32_t vext_spec;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cbb6cde082b..732a0540660 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1485,6 +1485,10 @@ static void riscv_cpu_init(Object *obj)
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
     cpu->cfg.max_satp_mode = -1;
 
+    if (mcc->def->profile) {
+        mcc->def->profile->enabled = true;
+    }
+
     env->misa_ext_mask = env->misa_ext = mcc->def->misa_ext;
     riscv_cpu_cfg_merge(&cpu->cfg, &mcc->def->cfg);
 
@@ -2859,22 +2863,6 @@ static const Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("x-misa-w", RISCVCPU, cfg.misa_w, false),
 };
 
-#if defined(TARGET_RISCV64)
-static void rva22u64_profile_cpu_init(Object *obj)
-{
-    rv64i_bare_cpu_init(obj);
-
-    RVA22U64.enabled = true;
-}
-
-static void rva22s64_profile_cpu_init(Object *obj)
-{
-    rv64i_bare_cpu_init(obj);
-
-    RVA22S64.enabled = true;
-}
-#endif
-
 static const gchar *riscv_gdb_arch_name(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
@@ -2941,6 +2929,22 @@ static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
     device_class_set_props(dc, riscv_cpu_properties);
 }
 
+static bool profile_has_parent(RISCVCPUProfile *trial, RISCVCPUProfile *parent)
+{
+    if (!parent) {
+        return true;
+    }
+
+    while (parent != trial) {
+        trial = trial->parent;
+        if (!trial) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
@@ -2955,6 +2959,11 @@ static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
     if (data) {
         const RISCVCPUDef *def = data;
         mcc->def->bare |= def->bare;
+        if (def->profile) {
+            assert(profile_has_parent(def->profile, mcc->def->profile));
+            assert(mcc->def->bare);
+            mcc->def->profile = def->profile;
+        }
         if (def->misa_mxl_max) {
             assert(def->misa_mxl_max <= MXL_RV128);
             mcc->def->misa_mxl_max = def->misa_mxl_max;
@@ -3111,16 +3120,21 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         }),                                                 \
     }
 
-#define DEFINE_PROFILE_CPU(type_name, misa_mxl_max_, initfn) \
+#define DEFINE_RISCV_CPU(type_name, parent_type_name, ...)  \
     {                                                       \
         .name = (type_name),                                \
-        .parent = TYPE_RISCV_BARE_CPU,                      \
-        .instance_init = (initfn),                          \
+        .parent = (parent_type_name),                       \
         .class_data = (void*) &((const RISCVCPUDef) {       \
-             .misa_mxl_max = (misa_mxl_max_),               \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             __VA_ARGS__                                    \
         }),                                                 \
     }
 
+#define DEFINE_PROFILE_CPU(type_name, parent_type_name, profile_)    \
+    DEFINE_RISCV_CPU(type_name, parent_type_name,             \
+        .profile = &(profile_))
+
 static const TypeInfo riscv_cpu_type_infos[] = {
     {
         .name = TYPE_RISCV_CPU,
@@ -3199,8 +3213,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif /* CONFIG_TCG */
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I,        MXL_RV64,  rv64i_bare_cpu_init),
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
-    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
-    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
+
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  TYPE_RISCV_CPU_RV64I,  RVA22U64),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  TYPE_RISCV_CPU_RV64I,  RVA22S64),
 #endif /* TARGET_RISCV64 */
 };
 
-- 
2.48.1


