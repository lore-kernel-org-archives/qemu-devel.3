Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B969C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 13:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY3n3-00063g-JK; Wed, 15 Jan 2025 08:50:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tY3my-00060K-9d
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:50:32 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tY3mw-0007sq-6L
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:50:31 -0500
Received: by mail-oi1-x241.google.com with SMTP id
 5614622812f47-3eba559611aso1999503b6e.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 05:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736949029; x=1737553829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x6/uHcxy8S071Ts6210PwMh1tRs0xCtUorTWG4sXCFw=;
 b=m3qMxckd7nNLrg6WVRuOow2EQ/Zl2nS1KLn20GZUZ+3UHiV1ZuLi1eF63fXSYoqnnQ
 k9DImMOVx9OSzc9Cd6alUexlPuMKkGxG8jIsq6qDGRnbg4XlblD/ktlQQcxhW1ih4WwQ
 k+FCL912P6odOewDCpotgOF3QWRO0o7XT3Si+nLScmXbjLThyXLrTNQ9DbjLIhiigbL4
 fVMRIMicUEVoACLvkznKfvtWAMrNmglT3uXlH7aLVs21ChppCJnZkmgrFGH7oFY6LZGA
 TmhVz3Iayfgj8bTKDQjie9lkP9HQWjpZMxAlNyCXfCVYlH7e30zKkcOhjYnPpMz8oirc
 F6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736949029; x=1737553829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x6/uHcxy8S071Ts6210PwMh1tRs0xCtUorTWG4sXCFw=;
 b=Lmzwdyezo5HWpZl9ZWh6YVwAmNAdTqYUViXXrlfXoa7rzbcw6+rwiV1q6JDSYnB/cL
 6vMewTTeKuMs3y8MoILlj5HARXf6Psj79fdYmRkM3a1tg59c6ABiYlYUTuTN60UBtRPB
 5PhgMsH5IsNow4rNvEAGzSQLrNKaKJ2KAyhbjzLdnPhKgh5mJqeM20ibH3lu19ro0/GU
 p4lsDndDDZadeqj+kyQllbLcRxGPGnWABL9vGD47CZctzt6DG7eCUwWmnSpDPQYBMqlb
 9XmlkhUq8W99Lqr80NySRPBxC/rLOSIYSTWwaIC9cZ7+gazOt6IGxEFBSqSFX9j10r8s
 tqKA==
X-Gm-Message-State: AOJu0YwALO8oF2xCk25hxx79rg70DgS3MFp6CiStLWGgwMNv0xwsA+qk
 nbeeVA7ALeCEipBvWpDV3TlxjCOkVMmWJWEbx4Hqos5mx5svuaZlykjcwTJtMCCiEGu7RVbzpSM
 83Amr2Q==
X-Gm-Gg: ASbGncuoATtrCar1/SE15k4n25ExsXGfze6BEhX7LOMEPbw56OSPTp2Kp38oB3j05vB
 HH1S4yZalhBhmYZHh7JAmjd8uKD1+vvTVa7lVVdg0f6QoopRIML9d4xM317MpNyUQhIJP+effEs
 q89QpDQcnpdB/Wi2nbXY6kJGH4v+Lt9EmpnRi50Le5H4tFvbvdfbflbFere1TWD3r/XGKYk4PY4
 z4S3MbniFFUHMBa5QPUqVBhuCh44OYf3HCaZccbgyungWKyeXo7DRZKwaE=
X-Google-Smtp-Source: AGHT+IFc1u5E8l57Fp2oA/FJt4N4QIJv6YSJfH++l7pWSDd+fJIGIE0UqrIHTdwn4U1l02vX9A96qg==
X-Received: by 2002:a05:6808:2e93:b0:3ea:4c54:51f3 with SMTP id
 5614622812f47-3ef2ec61f23mr16909791b6e.16.1736949028724; 
 Wed, 15 Jan 2025 05:50:28 -0800 (PST)
Received: from grind.. ([191.202.238.10]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f0379eff69sm4952177b6e.41.2025.01.15.05.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:50:27 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 5/6] target/riscv: add RVA23U64 profile
Date: Wed, 15 Jan 2025 10:49:56 -0300
Message-ID: <20250115134957.2179085-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115134957.2179085-1-dbarboza@ventanamicro.com>
References: <20250115134957.2179085-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x241.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add RVA23U64 as described in [1]. Add it as a child of RVA22U64 since
all RVA22U64 mandatory extensions are also present in RVA23U64. What's
left then is to list the mandatory extensions that are RVA23 only.

A new "rva23u64" CPU is also added.

[1] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index d56b067bf2..53ead481a9 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -40,6 +40,7 @@
 #define TYPE_RISCV_CPU_RV64E            RISCV_CPU_TYPE_NAME("rv64e")
 #define TYPE_RISCV_CPU_RVA22U64         RISCV_CPU_TYPE_NAME("rva22u64")
 #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
+#define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e215b1004d..761da41e53 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2397,9 +2397,34 @@ static RISCVCPUProfile RVA22S64 = {
     }
 };
 
+/*
+ * All mandatory extensions from RVA22U64 are present
+ * in RVA23U64 so set RVA22 as a parent. We need to
+ * declare just the newly added mandatory extensions.
+ */
+static RISCVCPUProfile RVA23U64 = {
+    .u_parent = &RVA22U64,
+    .s_parent = NULL,
+    .name = "rva23u64",
+    .misa_ext = RVV,
+    .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
+    .satp_mode = RISCV_PROFILE_ATTR_UNUSED,
+    .ext_offsets = {
+        CPU_CFG_OFFSET(ext_zvfhmin), CPU_CFG_OFFSET(ext_zvbb),
+        CPU_CFG_OFFSET(ext_zvkt), CPU_CFG_OFFSET(ext_zihintntl),
+        CPU_CFG_OFFSET(ext_zicond), CPU_CFG_OFFSET(ext_zimop),
+        CPU_CFG_OFFSET(ext_zcmop), CPU_CFG_OFFSET(ext_zcb),
+        CPU_CFG_OFFSET(ext_zfa), CPU_CFG_OFFSET(ext_zawrs),
+        CPU_CFG_OFFSET(ext_supm),
+
+        RISCV_PROFILE_EXT_LIST_END
+    }
+};
+
 RISCVCPUProfile *riscv_profiles[] = {
     &RVA22U64,
     &RVA22S64,
+    &RVA23U64,
     NULL,
 };
 
@@ -2886,6 +2911,13 @@ static void rva22s64_profile_cpu_init(Object *obj)
 
     RVA22S64.enabled = true;
 }
+
+static void rva23u64_profile_cpu_init(Object *obj)
+{
+    rv64i_bare_cpu_init(obj);
+
+    RVA23U64.enabled = true;
+}
 #endif
 
 static const gchar *riscv_gdb_arch_name(CPUState *cs)
@@ -3165,6 +3197,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  MXL_RV64,  rva23u64_profile_cpu_init),
 #endif /* TARGET_RISCV64 */
 };
 
-- 
2.47.1


