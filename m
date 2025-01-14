Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF7CC02185
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 19:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXm9l-0007jw-VV; Tue, 14 Jan 2025 14:00:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXm9P-0006Vl-Mi
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 14:00:31 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXm9M-00036g-FV
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 14:00:31 -0500
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-71e35be77b5so1583755a34.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 11:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736881226; x=1737486026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YiYlxwHXUU3zuaz/O7pjImuUFKQ8yguanE/cPjiFeRA=;
 b=RyQwiwRETqFIbhs3010C6dXQT/jht63xzolmG08UDJnwhb6CuU7UkyP9/TGwLUJhrX
 L1z6tTiVaxHGjctxRK3fPYy9JOLkeccuY+KYSjiNnsgThdSOqO0IW6EquWRDArDwt+Kw
 lE+vxhTVcczjzkqwwnbmapXlaq5LkKPLh3s/KlYSiT4y/UPGYoiZYMLKb1m6nB8w1RQT
 El4zBSENH16GunAPpM4chpci9axnchyVgMdRmUnJqOz1wtXK5jVekmb1QdqLn5CkduFq
 PUbXPctBd7439s5kN7oAMQhd9b/i6IHfETSkSzH5wkxCeWOXc24GTIFs1hMo56O5Tcyv
 Ubuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736881226; x=1737486026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YiYlxwHXUU3zuaz/O7pjImuUFKQ8yguanE/cPjiFeRA=;
 b=MXULqYYTaPDU8zylaf+CuMI7Vx/6v/8tmzWGpByFpcS60ZEERRqyXFnUnrTpW9XbYD
 MIoR/7yUJ8ywVNT9iYTErz7Uer2FB+lVFY5ZnPLhqB68XKgwwWuQmnRf66ljaba3HkV+
 GpA4RlNfSH2ZXcIto+pTGLFcSQPYuNisO9gHkAcReWIyrzLsvjAS1eKEBYQlOl1Bh4Y/
 1iO7JLbHki0zF9aWZgKvnLh1XNwtKrFZd2tjTz1fYJ3PJj0EgI5JsRlRryGqE70G+P8T
 qnejebejUO8pade8QaVzvOGcykqLya7ZzGvSvnErG9nXwrmCh7cnbL5nhFnpCGo+cayz
 3nFw==
X-Gm-Message-State: AOJu0Yy/enb5XULpqjunFBCxMZZN13w86x2HMSCg3ZRWpKAlde+ARNaC
 gbQzRQhj07g2B+vQLRGh5iuPUFxhmWs7SfY9U9H1MV5Swl27v4TkPNJFoBCrKQEnnQU7CMQPqBM
 ucUfMag==
X-Gm-Gg: ASbGnctgkJUVntULwBuAX7RlKk79pB6YFE6w+StKfoNNM+GAmgcszsBPEnHFB9nuP44
 myOW17FqaBKaj1Wocw7AuhBYyx3szcJnBvx4c0/GTClB4Y/yvxViSgeD1OTiswOJyZskH8hZXCs
 TvBfLAe9u3KgeM4o9Z6W8U+MfkZOydsvggW9h1petUTn0jd+v5a2ViMwBsZ6EHPZDHXni/DE/qm
 +pZn6ZbGAbGDolMzFTVz91kNBtkdjCEQbYaxwX+jTRRyXpXzA8cRb+fSe0uAqzNQzRnAJz8kEt+
 pC2GorrluA==
X-Google-Smtp-Source: AGHT+IFVR9sjTY7YrBBztzQ83pIyMP+Kfe/jsQbvdwXkUevtaoZ1zPeKIuo/IGEod8JC/PJ6zm9Lhw==
X-Received: by 2002:a05:6830:6994:b0:71d:f21b:a447 with SMTP id
 46e09a7af769-721e2e5b5a6mr16337156a34.17.1736881224261; 
 Tue, 14 Jan 2025 11:00:24 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([189.110.107.205])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7231855ee1esm4875647a34.32.2025.01.14.11.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 11:00:23 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 3/4] target/riscv: add RVA23U64 profile
Date: Tue, 14 Jan 2025 16:00:00 -0300
Message-ID: <20250114190001.1650942-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114190001.1650942-1-dbarboza@ventanamicro.com>
References: <20250114190001.1650942-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

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
index 6fb4d5f374..371a7d63fa 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2395,9 +2395,33 @@ static RISCVCPUProfile RVA22S64 = {
     }
 };
 
+/*
+ * All mandatory extensions from RVA22U64 are present
+ * in RVA23U64 so set RVA22 as a parent. We need to
+ * declare just the newly added mandatory extensions.
+ */
+static RISCVCPUProfile RVA23U64 = {
+    .parent = &RVA22U64,
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
 
@@ -2884,6 +2908,13 @@ static void rva22s64_profile_cpu_init(Object *obj)
 
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
@@ -3163,6 +3194,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  MXL_RV64,  rva23u64_profile_cpu_init),
 #endif /* TARGET_RISCV64 */
 };
 
-- 
2.47.1


