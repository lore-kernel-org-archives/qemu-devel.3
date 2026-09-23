Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C84C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9N0s-00066p-Ck; Wed, 23 Sep 2026 09:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mw3-0004VN-M5
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:23:00 -0400
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mw0-0007mZ-6U
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:22:55 -0400
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-328664ef783so545454eec.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169760; x=1790774560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sbxGSR1jQ3mjsiUMVexNy6mEJBAK/pzPmYIAHajWfls=;
 b=WOLb50X38OEXFZS0zhxfaTQFCOMgnBi11AucXTQe+a7BcU4HcjzVyC2i/fim/WSnfy
 Zn5LcnEFh6oZiN5No2REcjYgaJYIGW9qtnl0+6+tJIdfnZod1jk3V0e5ERYEALxyACFG
 BbLQ7qTSfQFn4U1AqdgKo0g3da19L5Otlw09L5voieD3Dl3ovCTmUAardACNbdciBVx7
 wZexwBxkuUsie9Cx3pvFcseL5P7+qKsQuY73cF2GtAHluuKa+Femxom6STQs7cABqSmu
 OkuSHsa3mqmxa1cp8x+QILIwz1mzVncfCVf6GJRDllao/3yHFB0oy1ajwzBAz9un0/Vx
 nr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169760; x=1790774560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sbxGSR1jQ3mjsiUMVexNy6mEJBAK/pzPmYIAHajWfls=;
 b=KYRwW7B8OMDpkVOXveIT7fivS+Yh9cpUlVNxqfR4ZSRECfMuDBa0cONMZuCEfwOlIB
 z3ICh6Fd8RIyeWUzp3SFviTSdLdQ6QjID54UxlLluKVEc530gf3bChQevI8JIgnD5Dzr
 bC40oNNMHfpqGWXC/Txzfl9CVF3EgmJ+yBBHX7lLAMHo6YZUPdZePPWxIT96lNCelrXK
 Qgu/oIbGtFcqK+UrCKACPW3M9KvVM46VSJRBd/+FAJukFtruESbbOeA4kV0l6x9kxLRh
 EKVJbwpuCkfr/cZaAvENmBU3Oi9NMcnBrjP6y6thZob+MzVhDzFJ8+oiOaoSQQWx6d7d
 ZqGw==
X-Gm-Message-State: AFuF++lc0w19XYgI8pvnWug91CsHq8ddw3FGHIz/QufR+PdUIXwDWLS9
 obBGLXi/aPHXi4WQD8gzG1eh1miMcCgYpb/GKxUR8J0Rd0uYNl7ykQm/otdy/POWI48=
X-Gm-Gg: AYBFou395PJgFzQgjBQDzzW89+IxkS0U2GsXYBgxLTjpJnUEjW5/6KPeG5zP21axRgy
 MsFGJwfWgW1DkdfbVc3VBSKM7qt0/BPBQd2W0K+w1mbl6mHlcArtPz6KXa6RhSwc+Q8Fq1teXV9
 fjoUq4BEckkwr22j+W1RhpWEc+PQFKZQKy5cSdI+oUcrPkE8JSnWIDLxZv8CbPZPFEM0jChjQpe
 fXC+aQMDwD5IuSZZr+EaXYiD9Cgv8Yg7VbefUhkAA2fivheZiLBbYYgqNPSoj7QjVxKxCW0IxhJ
 DWewLG5CVMN9rDQEApMSHoqj0a575dLChRAWdydcjJozqKdhROeMljSbrwNK11t9Ks9mDZicgls
 E3hTtNKw8YBCww90c2w/BkJ4T9PQD816I1Y5yn5P2bmeoV/LfDtVSnTR5FZjvU1Olt/en7/+Bqs
 x4aKo6kHXssBLs34hSyA+g/yC/0hBLxkgeNn19/oOPTWDGGrawxcTq8IrkM9rmlhy0fyHxLObcS
 K/Mr/zTfWNocQ69PLI54IxGJWoaJoE=
X-Received: by 2002:a05:7300:fb0a:b0:339:66ff:51b3 with SMTP id
 5a478bee46e88-33e8e2b67b8mr2443005eec.37.1790169759593; 
 Wed, 23 Sep 2026 06:22:39 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:22:38 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, xen-devel@lists.xenproject.org,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Fabiano Rosas <farosas@suse.de>, Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Song Gao <17746591750@163.com>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 035/114] target/riscv: gate CPU types with TargetInfo
Date: Wed, 23 Sep 2026 21:15:09 +0800
Message-ID: <20260923131635.1894-36-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

- Gate CPU types with TypeInfo.is_available instead of
  TARGET_RISCV32/64: DEFINE_RISCV_CPU_AVAIL, DEFINE_RISCV64_CPU,
  and DEFINE_RISCV_CPU_32_64SYS.
- Add RISCVCPUDef.target_init. max and bare keep RV64/SV57 in
  the TypeInfo; on riscv32 the callbacks set RV32/SV32 after
  merge. Do not inherit the parent pointer.
- Validate RV64/128 misa_mxl_max only when not target_riscv32().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/cpu.c | 128 ++++++++++++++++++++++++++++++---------------
 target/riscv/cpu.h |   7 +++
 2 files changed, 93 insertions(+), 42 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c6f17390755..4343f431d62 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1586,18 +1586,37 @@ static const MISAExtInfo misa_ext_info_arr[] = {
     MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)")
 };
 
+static void riscv_max_target_init(RISCVCPUClass *mcc)
+{
+    if (!target_riscv32()) {
+        return;
+    }
+    mcc->def->misa_mxl_max = MXL_RV32;
+    mcc->def->cfg.max_satp_mode = VM_1_10_SV32;
+}
+
+static void riscv_bare_target_init(RISCVCPUClass *mcc)
+{
+    if (!target_riscv32()) {
+        return;
+    }
+    /* BARE has no misa_mxl_max, so the class_base_init satp clamp skips it. */
+    mcc->def->cfg.max_satp_mode = VM_1_10_SV32;
+}
+
 static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
 {
     CPUClass *cc = CPU_CLASS(mcc);
 
     /* Validate that MISA_MXL is set properly. */
     switch (mcc->def->misa_mxl_max) {
-#ifdef TARGET_RISCV64
     case MXL_RV64:
     case MXL_RV128:
+        if (target_riscv32()) {
+            g_assert_not_reached();
+        }
         cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
         break;
-#endif
     case MXL_RV32:
         cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
         break;
@@ -3092,6 +3111,8 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
 
     if (pcc->def) {
         mcc->def = g_memdup2(pcc->def, sizeof(*pcc->def));
+        /* TypeInfo supplies target_init; do not inherit the parent pointer. */
+        mcc->def->target_init = NULL;
     } else {
         mcc->def = g_new0(RISCVCPUDef, 1);
     }
@@ -3152,6 +3173,9 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
             mcc->def->custom_csrs = def->custom_csrs;
         }
 #endif
+        if (def->target_init) {
+            def->target_init(mcc);
+        }
     }
 
     if (!object_class_is_abstract(c)) {
@@ -3262,6 +3286,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = (parent_type_name),                       \
         .abstract = true,                                   \
+        .is_available = target_is_base_riscv,               \
         .class_data = &(const RISCVCPUDef) {                \
              .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
              .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
@@ -3270,10 +3295,11 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         },                                                  \
     }
 
-#define DEFINE_RISCV_CPU(type_name, parent_type_name, ...)  \
+#define DEFINE_RISCV_CPU_AVAIL(type_name, parent_type_name, avail, ...) \
     {                                                       \
         .name = (type_name),                                \
         .parent = (parent_type_name),                       \
+        .is_available = (avail),                            \
         .class_data = &(const RISCVCPUDef) {                \
              .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
              .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
@@ -3282,8 +3308,37 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         },                                                  \
     }
 
+#define DEFINE_RISCV_CPU(type_name, parent_type_name, ...)  \
+    DEFINE_RISCV_CPU_AVAIL(type_name, parent_type_name,     \
+                           target_is_base_riscv, __VA_ARGS__)
+
+#define DEFINE_RISCV64_CPU(type_name, parent_type_name, ...) \
+    DEFINE_RISCV_CPU_AVAIL(type_name, parent_type_name,     \
+                           target_is_riscv64, __VA_ARGS__)
+
+/*
+ * Original:
+ *   #if defined(TARGET_RISCV32) || \
+ *       (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
+ *
+ * RV32 models on every riscv32 binary, and on system riscv64
+ * (-cpu rv32 / e31 / ibex). Not linux-user riscv64.
+ */
+static bool riscv32_64sys_available(const TargetInfo *ti)
+{
+#ifdef CONFIG_USER_ONLY
+    return target_is_riscv32(ti);
+#else
+    return target_is_base_riscv(ti);
+#endif
+}
+
+#define DEFINE_RISCV_CPU_32_64SYS(type_name, parent_type_name, ...) \
+    DEFINE_RISCV_CPU_AVAIL(type_name, parent_type_name,     \
+                           riscv32_64sys_available, __VA_ARGS__)
+
 #define DEFINE_PROFILE_CPU(type_name, parent_type_name, profile_)    \
-    DEFINE_RISCV_CPU(type_name, parent_type_name,             \
+    DEFINE_RISCV64_CPU(type_name, parent_type_name,             \
         .profile = &(profile_))
 
 static void riscv_cpu_instance_finalize(Object *obj)
@@ -3311,6 +3366,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .class_size = sizeof(RISCVCPUClass),
         .class_init = riscv_cpu_common_class_init,
         .class_base_init = riscv_cpu_class_base_init,
+        .is_available = target_is_base_riscv,
     },
 
     DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU,
@@ -3339,21 +3395,14 @@ static const TypeInfo riscv_cpu_type_infos[] = {
          * only MBARE will be available if the user doesn't enable
          * a mode manually (see riscv_cpu_satp_mode_finalize()).
          */
-#ifdef TARGET_RISCV32
-        .cfg.max_satp_mode = VM_1_10_SV32,
-#else
         .cfg.max_satp_mode = VM_1_10_SV57,
-#endif
+        .target_init = riscv_bare_target_init,
     ),
 
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX, TYPE_RISCV_DYNAMIC_CPU,
-#if defined(TARGET_RISCV32)
-        .misa_mxl_max = MXL_RV32,
-        .cfg.max_satp_mode = VM_1_10_SV32,
-#elif defined(TARGET_RISCV64)
         .misa_mxl_max = MXL_RV64,
         .cfg.max_satp_mode = VM_1_10_SV57,
-#endif
+        .target_init = riscv_max_target_init,
     ),
 
     DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E, TYPE_RISCV_VENDOR_CPU,
@@ -3378,9 +3427,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.pmp_regions = 8
     ),
 
-#if defined(TARGET_RISCV32) || \
-    (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
+    DEFINE_RISCV_CPU_32_64SYS(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV32,
         .misa_mxl_max = MXL_RV32,
 
@@ -3406,7 +3453,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_svvptc = true,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_IBEX, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV_CPU_32_64SYS(TYPE_RISCV_CPU_IBEX, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV32,
         .misa_ext = RVI | RVM | RVC | RVU,
         .priv_spec = PRIV_VERSION_1_12_0,
@@ -3423,37 +3470,35 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_xlrbr = true
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E31, TYPE_RISCV_CPU_SIFIVE_E,
+    DEFINE_RISCV_CPU_32_64SYS(TYPE_RISCV_CPU_SIFIVE_E31, TYPE_RISCV_CPU_SIFIVE_E,
         .misa_mxl_max = MXL_RV32
     ),
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E34, TYPE_RISCV_CPU_SIFIVE_E,
+    DEFINE_RISCV_CPU_32_64SYS(TYPE_RISCV_CPU_SIFIVE_E34, TYPE_RISCV_CPU_SIFIVE_E,
         .misa_mxl_max = MXL_RV32,
         .misa_ext = RVF,  /* IMAFCU */
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U34, TYPE_RISCV_CPU_SIFIVE_U,
+    DEFINE_RISCV_CPU_32_64SYS(TYPE_RISCV_CPU_SIFIVE_U34, TYPE_RISCV_CPU_SIFIVE_U,
         .misa_mxl_max = MXL_RV32,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
+    DEFINE_RISCV_CPU_32_64SYS(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV32,
         .misa_ext = RVI
     ),
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32E, TYPE_RISCV_BARE_CPU,
+    DEFINE_RISCV_CPU_32_64SYS(TYPE_RISCV_CPU_RV32E, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV32,
         .misa_ext = RVE
     ),
-#endif
 
-#if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX32, TYPE_RISCV_DYNAMIC_CPU,
+#ifndef CONFIG_USER_ONLY
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_MAX32, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV32,
         .misa_mxl_max = MXL_RV32,
     ),
 #endif
 
-#if defined(TARGET_RISCV64)
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE64, TYPE_RISCV_DYNAMIC_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_BASE64, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
         .misa_mxl_max = MXL_RV64,
 
@@ -3479,19 +3524,19 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_svvptc = true,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
         .misa_mxl_max = MXL_RV64
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U54, TYPE_RISCV_CPU_SIFIVE_U,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_SIFIVE_U54, TYPE_RISCV_CPU_SIFIVE_U,
         .misa_mxl_max = MXL_RV64,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SHAKTI_C, TYPE_RISCV_CPU_SIFIVE_U,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_SHAKTI_C, TYPE_RISCV_CPU_SIFIVE_U,
         .misa_mxl_max = MXL_RV64,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C906, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_THEAD_C906, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVG | RVC | RVS | RVU,
         .priv_spec = PRIV_VERSION_1_11_0,
@@ -3519,7 +3564,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C908, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_THEAD_C908, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
         .priv_spec = PRIV_VERSION_1_12_0,
@@ -3566,12 +3611,12 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C908V, TYPE_RISCV_CPU_THEAD_C908,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_THEAD_C908V, TYPE_RISCV_CPU_THEAD_C908,
         .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU | RVV,
         .vext_spec = VEXT_VERSION_1_00_0,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_TT_ASCALON, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_TT_ASCALON, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVG | RVC | RVS | RVU | RVH | RVV,
         .priv_spec = PRIV_VERSION_1_13_0,
@@ -3635,7 +3680,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV57,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_VEYRON_V1, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_VEYRON_V1, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVG | RVC | RVS | RVU | RVH,
         .priv_spec = PRIV_VERSION_1_12_0,
@@ -3671,7 +3716,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV48,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVG | RVC | RVB | RVS | RVU,
         .priv_spec = PRIV_VERSION_1_12_0,
@@ -3694,7 +3739,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV39,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_XIANGSHAN_KMH, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_XIANGSHAN_KMH, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVG | RVC | RVB | RVS | RVU | RVH | RVV,
         .priv_spec = PRIV_VERSION_1_13_0,
@@ -3754,7 +3799,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     ),
 
     /* https://mips.com/products/hardware/p8700/ */
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
         .priv_spec = PRIV_VERSION_1_12_0,
@@ -3777,16 +3822,16 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     ),
 
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
         .misa_mxl_max = MXL_RV128,
     ),
 #endif /* CONFIG_TCG */
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV64I, TYPE_RISCV_BARE_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_RV64I, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVI
     ),
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV64E, TYPE_RISCV_BARE_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_RV64E, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVE
     ),
@@ -3795,7 +3840,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  TYPE_RISCV_CPU_RV64I,  RVA22S64),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  TYPE_RISCV_CPU_RV64I,  RVA23U64),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23S64,  TYPE_RISCV_CPU_RV64I,  RVA23S64),
-#endif /* TARGET_RISCV64 */
 };
 
 DEFINE_TYPES(riscv_cpu_type_infos)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 034d7e96c49..265c6322067 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -597,6 +597,13 @@ typedef struct RISCVCPUDef {
 #endif
     /* This is just a setter for env->num_triggers.  */
     uint32_t num_triggers;
+
+    /*
+     * Optional per-CPU callback run from riscv_cpu_class_base_init
+     * after the static def is merged. Use it to adjust fields that
+     * depend on the build target (e.g. clamp misa_mxl_max for RV32).
+     */
+    void (*target_init)(struct RISCVCPUClass *mcc);
 } RISCVCPUDef;
 
 /**
-- 
2.52.0.windows.1


