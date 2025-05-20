Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01101C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKnn-0000Od-Pi; Tue, 20 May 2025 07:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnh-0008Mq-6x
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKne-0003EG-TS
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wAk3VJycK08RmuxbhLOpqsKTeVaRPtp4EDzgHmUZ2g8=;
 b=ciY3Gev5iDdk2/tIHXbaTIGkszuFGJgL5RXWimVt76AvXJMnpMQHZTbZdk1R5l8t4oi11v
 r752ApaiBtn8rJvev9AWLF6d0vaCp9x872t70Yqu6RkH/b/kXPQDhMGVl75d0p1eP9xB7y
 KB4jHX7k6NqCYsnCmYVdi5V9g2jMQPw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-Jm4sCJ7RNQSP_ZPPg1X-Kw-1; Tue, 20 May 2025 07:06:21 -0400
X-MC-Unique: Jm4sCJ7RNQSP_ZPPg1X-Kw-1
X-Mimecast-MFC-AGG-ID: Jm4sCJ7RNQSP_ZPPg1X-Kw_1747739180
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac6ef2d1b7dso429027366b.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739179; x=1748343979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wAk3VJycK08RmuxbhLOpqsKTeVaRPtp4EDzgHmUZ2g8=;
 b=PEyB+VCX8wCydd086CxDOiAFcA6+2OAettGHn0O60dZHvOkNhH7+A7oJx94aDeWmbk
 rEY3r9tTiae1u6tRoE17TDMauhSEdXETJ+/xqIyqNbm6/grKCu4iRTx/Zib68yI3WHgp
 fQ8v1FIQGkdJVX0HxYv5H7jnCo1CreRTyfbq2fDRUVHy2wrWchtLoibaIYAyzEhwVhg7
 06b/ZqST1XWZgVT6wNufXMY2V3PIYQykIxcErj+cZ3k+QTu15kSHlFmRbazQbJwr9YNz
 351IMiaDnaQ3sqYjeeDn+lGZPnLuEjVcvmRPSgVMEopKOebS/20DjYjP51mHLPGbJJyc
 aCyA==
X-Gm-Message-State: AOJu0YzfMUu9L9nqJMV0idGOqLQPmqZxOFQVwGttjiHTDtubrdnS6rpw
 TA1l4nZqj/6fuVLKz5tcQRCMW8IJvIdGRiiwH/hW7bJXT+dAM/UkpDWU/WpwpzvlPOm/bjTo6Kt
 Vl/QvSVqiFmmM9D3PVHIcHF7ePlB4UhaO+PyD7nZpBJoyf47HmNWl880neL2w7MdJpcYta1rqzU
 Y+O4x2Zg8uV0wFFk26InkpeR1GN+oL7cRIzS2maLqC
X-Gm-Gg: ASbGncu5YstQgBhIYfq8/0zDfnAPZvFKBE0Zdb4nc062pLuO+jmOiOCXQ7UuWV4+YN7
 HxK+TYrUqXEJ/2YHu+VyBnOzETTxHA3o8wu41sye/twmR4HzyyslBSSxWG9Ambp02KC5/JGDNxV
 a0fAOQUN/EhN8+5Ye08nElDl45vkU9ursjtjkEhhQwL8/UD9UXbiOkPYAtu13D6MTQwcJ/yPavE
 k3IrLP+ruCfuocLIEMXvPm18Wn30FBQPMzXHnc5JGF18sICYqg3Wk1+WA3wNMzndhdGNBve4Oi8
 laXQh9OKob90bg==
X-Received: by 2002:a17:907:3e20:b0:ad5:6d1a:6fa4 with SMTP id
 a640c23a62f3a-ad56d1a72c0mr705556766b.44.1747739178648; 
 Tue, 20 May 2025 04:06:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+lsNnPhSldruvQx3pEXqHfvs0QzXpXaF+W6k25TWWTk0YO/Fv75HOdqGG+XhNQU5i4oHx2g==
X-Received: by 2002:a17:907:3e20:b0:ad5:6d1a:6fa4 with SMTP id
 a640c23a62f3a-ad56d1a72c0mr705552966b.44.1747739178159; 
 Tue, 20 May 2025 04:06:18 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d490794sm718639166b.131.2025.05.20.04.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:06:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/35] target/riscv: add more RISCVCPUDef fields
Date: Tue, 20 May 2025 13:05:15 +0200
Message-ID: <20250520110530.366202-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Allow using RISCVCPUDef to replicate all the logic of custom .instance_init
functions.  To simulate inheritance, merge the child's RISCVCPUDef with
the parent and then finally move it to the CPUState at the end of
TYPE_RISCV_CPU's own instance_init function.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h         |  4 ++++
 target/riscv/cpu.c         | 42 +++++++++++++++++++++++++++++++++++++-
 target/riscv/kvm/kvm-cpu.c |  6 ++++++
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d2d4db95c17..29b01e9aa86 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -540,6 +540,10 @@ struct ArchCPU {
 
 typedef struct RISCVCPUDef {
     RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
+    uint32_t misa_ext;
+    int priv_spec;
+    int32_t vext_spec;
+    RISCVCPUConfig cfg;
 } RISCVCPUDef;
 
 /**
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 334791eebdf..634216870ed 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -73,6 +73,13 @@ bool riscv_cpu_option_set(const char *optname)
     return g_hash_table_contains(general_user_opts, optname);
 }
 
+static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConfig *src)
+{
+#define BOOL_FIELD(x) dest->x |= src->x;
+#define TYPED_FIELD(type, x, default_) if (src->x != default_) dest->x = src->x;
+#include "cpu_cfg_fields.h.inc"
+}
+
 #define ISA_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
     {#_name, _min_ver, CPU_CFG_OFFSET(_prop)}
 
@@ -434,7 +441,7 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit)
 }
 
 static void set_satp_mode_max_supported(RISCVCPU *cpu,
-                                        uint8_t satp_mode)
+                                        int satp_mode)
 {
     bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
     const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
@@ -1479,6 +1486,16 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.cboz_blocksize = 64;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
     cpu->cfg.max_satp_mode = -1;
+
+    env->misa_ext_mask = env->misa_ext = mcc->def->misa_ext;
+    riscv_cpu_cfg_merge(&cpu->cfg, &mcc->def->cfg);
+
+    if (mcc->def->priv_spec != RISCV_PROFILE_ATTR_UNUSED) {
+        cpu->env.priv_ver = mcc->def->priv_spec;
+    }
+    if (mcc->def->vext_spec != RISCV_PROFILE_ATTR_UNUSED) {
+        cpu->env.vext_ver = mcc->def->vext_spec;
+    }
 }
 
 static void riscv_bare_cpu_init(Object *obj)
@@ -3087,6 +3104,17 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
             assert(def->misa_mxl_max <= MXL_RV128);
             mcc->def->misa_mxl_max = def->misa_mxl_max;
         }
+        if (def->priv_spec != RISCV_PROFILE_ATTR_UNUSED) {
+            assert(def->priv_spec <= PRIV_VERSION_LATEST);
+            mcc->def->priv_spec = def->priv_spec;
+        }
+        if (def->vext_spec != RISCV_PROFILE_ATTR_UNUSED) {
+            assert(def->vext_spec != 0);
+            mcc->def->vext_spec = def->vext_spec;
+        }
+        mcc->def->misa_ext |= def->misa_ext;
+
+        riscv_cpu_cfg_merge(&mcc->def->cfg, &def->cfg);
     }
 
     if (!object_class_is_abstract(c)) {
@@ -3193,6 +3221,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .instance_init = (initfn),                          \
         .class_data = &(const RISCVCPUDef) {                \
              .misa_mxl_max = (misa_mxl_max_),               \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .cfg.max_satp_mode = -1,                       \
         },                                                  \
     }
 
@@ -3203,6 +3234,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .instance_init = (initfn),                          \
         .class_data = &(const RISCVCPUDef) {                \
              .misa_mxl_max = (misa_mxl_max_),               \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .cfg.max_satp_mode = -1,                       \
         },                                                  \
     }
 
@@ -3213,6 +3247,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .instance_init = (initfn),                          \
         .class_data = &(const RISCVCPUDef) {                \
              .misa_mxl_max = (misa_mxl_max_),               \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .cfg.max_satp_mode = -1,                       \
         },                                                  \
     }
 
@@ -3223,6 +3260,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .instance_init = (initfn),                          \
         .class_data = &(const RISCVCPUDef) {                \
              .misa_mxl_max = (misa_mxl_max_),               \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .cfg.max_satp_mode = -1,                       \
         },                                                  \
     }
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index e77f612af35..efb41fac53e 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -2093,10 +2093,16 @@ static const TypeInfo riscv_kvm_cpu_type_infos[] = {
 #if defined(TARGET_RISCV32)
         .class_data = &(const RISCVCPUDef) {
             .misa_mxl_max = MXL_RV32,
+            .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
+            .vext_spec = RISCV_PROFILE_ATTR_UNUSED,
+            .cfg.max_satp_mode = -1,
         },
 #elif defined(TARGET_RISCV64)
         .class_data = &(const RISCVCPUDef) {
             .misa_mxl_max = MXL_RV64,
+            .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
+            .vext_spec = RISCV_PROFILE_ATTR_UNUSED,
+            .cfg.max_satp_mode = -1,
         },
 #endif
     }
-- 
2.49.0


