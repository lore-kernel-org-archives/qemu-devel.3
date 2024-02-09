Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28057C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOg9-00029i-8E; Fri, 09 Feb 2024 06:04:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOdl-0007jw-OK
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:56 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOde-0000vs-UT
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:49 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e09a890341so16480b3a.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476504; x=1708081304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HOKNy9ynlkr4DIQOqrOPNJMZ6HhovS56d0KSBKYmDNI=;
 b=eNNjeE/+adY1JbMQ474DSCa/cGwYwmtjIPKMuqcuRiYUx5Ja00HXXVgar4lBJy3eTv
 MdkS9+ynrmjhO9GcCOrAp9V0+LCw7PMg0EQPKIFasYLqr7SOPs1pcEosXb/nhNAWhDED
 tV3QR+SKfOwYdN69k7lfCcB30d9SAlx2J/mlXYmp2MW4q/NmjfPhUeYTYS6h/njpXNoz
 sEYG2pG35TKH1P2VE5QnetdZKpXWIUEb/GTrdJd5KGNWgFuY35wkriq7iV5qXRETFRG9
 vHeZ8YRvpzC8YTEkCCU29UOLZRPVET4h7mduz8qbjYUZ851/WjjXi+dAwW2RvoeS9yNT
 siKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476504; x=1708081304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HOKNy9ynlkr4DIQOqrOPNJMZ6HhovS56d0KSBKYmDNI=;
 b=oYOK1OfIUKOGMFhJlCz/9MLJT4AJPqZ22sVRPx7t5ZFtrEKluciwcARfi4n/ExXMVa
 pQt0Q0nK+nB2ksCCVow6t5fyga/Zbz6ffHmbHAzEO9qYqa6/gwzmZkqWMEUUS6PmSW8j
 JKkeQcox91P8Jow/pws/juqxBVmbsFVj3i3XuVfpKpY3ouq91ZyFhGfjs4Nqeq9NWCG8
 tK3hPyq/uV/6vl0PUSGJEdMzWps7nToUtNuP0qBY76dEHWPHsExpj/K3xrBviHxQ7ehU
 fNe5K2OHCs9nwDn9JN453Nnrkkn6uUrfZY5QFQkDEDsRbA7Q/I5wc3QhFY6oUAK6zac/
 XuSA==
X-Gm-Message-State: AOJu0YxlLy7SAUfYpsC3SuRdH+GHnD6ZVU71tYCguDypvJ/mFT+4Y96v
 jLg+Frimi4+9Ji2I1ymByEAugEPCGAfbTQ8LAK4GzEIRg4thJHW/x8dFzhuB3p6eXg==
X-Google-Smtp-Source: AGHT+IFFXiBV5X5lhFckvgU8RqqV3uVnj9hRgqZc5eAD+tzMweWjHCPanCBVMsLF0yJY/qKjoTrQpg==
X-Received: by 2002:a05:6a20:e687:b0:19e:9959:35e with SMTP id
 mz7-20020a056a20e68700b0019e9959035emr1233664pzb.12.1707476504198; 
 Fri, 09 Feb 2024 03:01:44 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXceU8edh8nEZpGubAKlg3/Nrt8b1AqoSJ+rNG8nIUzw7QtO0Fa/TJKqYXpk89AbMp7vMMK6Jhn9MtaBxhOsHi5p05lzaP0vE0QKuYJl5wUamOP1BL9XMOyU0DNz0VDV1Jkrxk=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:01:43 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 61/61] target/riscv: add rv32i, rv32e and rv64e CPUs
Date: Fri,  9 Feb 2024 20:58:13 +1000
Message-ID: <20240209105813.3590056-62-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

A bare bones 32 bit RVI CPU, rv32i, will make users lives easier when a
full customized 32 bit CPU is desired, and users won't need to disable
defaults by hand as they would with the rv32 CPU. [1] has an example of
a situation that would be avoided with rv32i.

In fact, add bare bones CPUs for RVE as well. Trying to use RVE in QEMU
requires one to disable every single default extension, including RVI,
and then add the desirable extension set. Adding rv32e/rv64e makes it
more pleasant to use embedded CPUs in QEMU.

[1] https://lore.kernel.org/qemu-riscv/258be47f-97be-4308-bed5-dc34ef7ff954@Spark/

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240122123348.973288-3-dbarboza@ventanamicro.com>
[ Changes by AF:
 - Rebase on latest changes
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-qom.h |  3 +++
 target/riscv/cpu.c     | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 9219c2fcc3..3670cfe6d9 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -34,7 +34,10 @@
 #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
 #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
 #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x-rv128")
+#define TYPE_RISCV_CPU_RV32I            RISCV_CPU_TYPE_NAME("rv32i")
+#define TYPE_RISCV_CPU_RV32E            RISCV_CPU_TYPE_NAME("rv32e")
 #define TYPE_RISCV_CPU_RV64I            RISCV_CPU_TYPE_NAME("rv64i")
+#define TYPE_RISCV_CPU_RV64E            RISCV_CPU_TYPE_NAME("rv64e")
 #define TYPE_RISCV_CPU_RVA22U64         RISCV_CPU_TYPE_NAME("rva22u64")
 #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 08fc24c3f4..1b8d001d23 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -606,6 +606,12 @@ static void rv64i_bare_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     riscv_cpu_set_misa_ext(env, RVI);
 }
+
+static void rv64e_bare_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    riscv_cpu_set_misa_ext(env, RVE);
+}
 #else
 static void rv32_base_cpu_init(Object *obj)
 {
@@ -689,6 +695,18 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
     cpu->cfg.ext_zicsr = true;
     cpu->cfg.pmp = true;
 }
+
+static void rv32i_bare_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    riscv_cpu_set_misa_ext(env, RVI);
+}
+
+static void rv32e_bare_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    riscv_cpu_set_misa_ext(env, RVE);
+}
 #endif
 
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
@@ -2528,6 +2546,8 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31, MXL_RV32,  rv32_sifive_e_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34, MXL_RV32,  rv32_imafcu_nommu_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34, MXL_RV32,  rv32_sifive_u_cpu_init),
+    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32I,        MXL_RV32,  rv32i_bare_cpu_init),
+    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32E,        MXL_RV32,  rv32e_bare_cpu_init),
 #elif defined(TARGET_RISCV64)
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,       MXL_RV64,  riscv_any_cpu_init),
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV64,  riscv_max_cpu_init),
@@ -2539,6 +2559,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I,        MXL_RV64,  rv64i_bare_cpu_init),
+    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
 #endif
-- 
2.43.0


