Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63125C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 10:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPtT-00035r-Um; Mon, 12 May 2025 05:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPs4-0001ck-Ls
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPs2-0000nC-UU
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GtfFznS59ToaV2jOSsbqx7T25/8SiCPZlne6x1Jiy8M=;
 b=g51suyp/jX4xSdmfzhOX7EB1WJhU5MSOgcIOR+BX4nbVvZ7Q/t/NNu4Viq4QIcuzbHCiN9
 6klWvVjRmupFgMli5G+N3Njh0sfha651YZN01FO3Sb3ApwBT6+037Vsgat1Ad8RLJwQ4UQ
 TAD6yneKepNnv559IBQcKhAAPcPlKT8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-KIMyCQUrNaKzTXc1QjpxXg-1; Mon, 12 May 2025 05:54:49 -0400
X-MC-Unique: KIMyCQUrNaKzTXc1QjpxXg-1
X-Mimecast-MFC-AGG-ID: KIMyCQUrNaKzTXc1QjpxXg_1747043688
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad23f75ecb1so201962366b.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043687; x=1747648487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GtfFznS59ToaV2jOSsbqx7T25/8SiCPZlne6x1Jiy8M=;
 b=okj84WD2stM2aviz78dquXZGvgXcxCgSXTExvP7m+e8FU93aAbiNq58t3pueaHLg+Y
 be43Edc3SXPvsSDfE2H6jHrm7uMMriFaw6aAnFsxzF//EX7zy2dwpbfYeSQExtLprsVv
 FB6boGa1tw2/JKSGqgECwaWnX9gXlJFWahroV7rNugcc9E+Tb/KyTAcVayPre1OmR3Q2
 rAZMMrHCdpmOGXsGS4mHCR+BPbRC+DlIWvHRsW9j0/db8b+0r62US5/3hRCE7HhIurNX
 2upbzHA/H+/MZ5mUvAgUtZ71YZnRfWt/25jslvj+rmtJg0IHGcI8Tf7RRzRrVrTi+/vO
 G6yA==
X-Gm-Message-State: AOJu0YxURf+hRf1LbLOIRKW3pBjmmaqJQpD2NreEkIfBnPmYQy7H/vDt
 b14p9LMTvDwtWVnaB0jHCTcPLbsL2qOb0efUCmE+Zyap2/wsjXCUkUpX5aTj5l9XuF3t4FEJgt6
 9+/hc4NPQgbasI6FE+1hFbHZdkwX0RMVbx1FAbhkCOPk+buHCTUF7AEpiTLXxZLmWDbwc2d81NL
 Eko8kZYgkHsuDwnJzREldhQWYIQ6mE+F7seZ+y
X-Gm-Gg: ASbGncttfCnEp88KCm9ApGZRjgfBob/Gl0NJPnbNDtJ5t2FdgzpEw1irUbeVmIL7sPp
 swJEF3uWLV3k/o+6F1K7PZdI9WFi6X/bfTdMEuRqAAbQX0Ujh96VLkx61yYFXtWapTrJNMjnIPR
 ZP6dbkXnX2uB2zFrSAW17+AOinbsgNLSZUCD7Gt3SXfbHj18rW1p1xQTK/ra1QUmF+vEAol6CwB
 G9nJHj407F4SLJXHgTJ2pa3lrX39X/oIfAT5p8X5wyFUW/FnxbKSJwBXgAkarU7gHfAycg1mTLc
 swX9n7lrnw/lbmtGjob9tAa9E5p5wbCdMJe5/g3EuZaY7MA=
X-Received: by 2002:a17:907:3cc7:b0:ad2:5830:ed2 with SMTP id
 a640c23a62f3a-ad25830119emr178323766b.61.1747043687108; 
 Mon, 12 May 2025 02:54:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF020jzJ3oGOXa0IU0j5hMZjWgAMonjcGvn5VvKndUc5ZIpFIAGW2HNdxXM58Gl2cscH1NYVw==
X-Received: by 2002:a17:907:3cc7:b0:ad2:5830:ed2 with SMTP id
 a640c23a62f3a-ad25830119emr178321466b.61.1747043686671; 
 Mon, 12 May 2025 02:54:46 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219346383sm590973966b.47.2025.05.12.02.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:54:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org
Subject: [PATCH 24/26] target/riscv: convert Xiangshan Nanhu to RISCVCPUDef
Date: Mon, 12 May 2025 11:52:24 +0200
Message-ID: <20250512095226.93621-25-pbonzini@redhat.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 80 +++++++++++++---------------------------------
 1 file changed, 23 insertions(+), 57 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c884e09d869..f4d4abada75 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -440,16 +440,6 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit)
     g_assert_not_reached();
 }
 
-static void __attribute__((unused))
-set_satp_mode_max_supported(RISCVCPU *cpu, int satp_mode)
-{
-    bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
-    const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
-
-    assert(valid_vm[satp_mode]);
-    cpu->cfg.max_satp_mode = satp_mode;
-}
-
 static bool get_satp_mode_supported(RISCVCPU *cpu, uint16_t *supported)
 {
     bool rv32 = riscv_cpu_is_32bit(cpu);
@@ -498,38 +488,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
 }
 #endif
 
-#if defined(TARGET_RISCV64)
-
-static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVG | RVC | RVB | RVS | RVU);
-    env->priv_ver = PRIV_VERSION_1_12_0;
-
-    /* Enable ISA extensions */
-    cpu->cfg.ext_zbc = true;
-    cpu->cfg.ext_zbkb = true;
-    cpu->cfg.ext_zbkc = true;
-    cpu->cfg.ext_zbkx = true;
-    cpu->cfg.ext_zknd = true;
-    cpu->cfg.ext_zkne = true;
-    cpu->cfg.ext_zknh = true;
-    cpu->cfg.ext_zksed = true;
-    cpu->cfg.ext_zksh = true;
-    cpu->cfg.ext_svinval = true;
-
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_SV39);
-#endif
-}
-
-#endif /* !TARGET_RISCV64 */
-
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
@@ -2891,19 +2849,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
 }
 #endif
 
-#define DEFINE_VENDOR_CPU(type_name, misa_mxl_max_, initfn) \
-    {                                                       \
-        .name = (type_name),                                \
-        .parent = TYPE_RISCV_VENDOR_CPU,                    \
-        .instance_init = (initfn),                          \
-        .class_data = &(const RISCVCPUDef) {                \
-             .misa_mxl_max = (misa_mxl_max_),               \
-             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .cfg.max_satp_mode = -1,                       \
-        },                                                  \
-    }
-
 #define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...) \
     {                                                       \
         .name = (type_name),                                \
@@ -3203,8 +3148,29 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV48,
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
-                                                 MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVG | RVC | RVB | RVS | RVU,
+        .priv_spec = PRIV_VERSION_1_12_0,
+
+        /* ISA extensions */
+        .cfg.ext_zbc = true,
+        .cfg.ext_zbkb = true,
+        .cfg.ext_zbkc = true,
+        .cfg.ext_zbkx = true,
+        .cfg.ext_zknd = true,
+        .cfg.ext_zkne = true,
+        .cfg.ext_zknh = true,
+        .cfg.ext_zksed = true,
+        .cfg.ext_zksh = true,
+        .cfg.ext_svinval = true,
+
+        .cfg.mmu = true,
+        .cfg.pmp = true,
+
+        .cfg.max_satp_mode = VM_1_10_SV39,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
-- 
2.49.0


