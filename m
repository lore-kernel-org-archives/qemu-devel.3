Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E281C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY8Ms-00088k-Ps; Wed, 15 Jan 2025 13:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tY8Mm-000881-2p
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:43:48 -0500
Received: from mail-oa1-x43.google.com ([2001:4860:4864:20::43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tY8Mk-0003AU-AW
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:43:47 -0500
Received: by mail-oa1-x43.google.com with SMTP id
 586e51a60fabf-2a01bcd0143so81972fac.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736966625; x=1737571425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x6/uHcxy8S071Ts6210PwMh1tRs0xCtUorTWG4sXCFw=;
 b=DylRQNShDLClyQguvUTpO+NyJYsw+zc4sB6/tYmT5r3nl23AzuI2O+KyRVYvpHefgM
 f9Jh7uKVE6T2dmxg5/HwVecniZa3eKVQoCFKU7jF6DSGYiSdjXzGo8UvsfgSP85A5GAe
 kcDFoipK1wgVxWRxjodGA6Ylhm9VPQGXoAOAsAAQNyP+1PXi3bsR6Kvsh6W/Nwdsa/zq
 eqrXQ1WCqd0YGHsfGhAxfp7TXbshF+mqffU5IQN4dCnvcQLU0GM/zYMs/cQvJHNzhonL
 BJ0xLmcD4uGmphnNI1LH06exQShTKiB0ugEyqVM2Wh2sTttP31eNKvJfgSjssqMV+ij3
 Rk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736966625; x=1737571425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x6/uHcxy8S071Ts6210PwMh1tRs0xCtUorTWG4sXCFw=;
 b=flZA0HwEmX1Z0WBv3DbkVlQpafvOnOynGOPtf/oHnSyHhxK5DNMu7YGy3QGgQMrnAd
 yxDsHXmwmiiO1tMG3WGsqlI1ZLum+NUhV1N6S4seslum9McAOOmeGGh6DQcBAfIE4LUE
 eGls8XiPO/vGc87cUbYdG/1UZGo845ufMB+D+z1Y12KcWoE0jUdxvNVy83ssiaEJ6Ppa
 keV7AhARA/cS3huT+oZAEwGk0jqaBK+eh0FYHzDr0uY4TjSN3VXpPMezQeJzQNRcBiS4
 74dYogq2A3aOi4caabt5gS12qUO18CJ66flqse4wzYnqKgvFoYro8NXIJ1r9OlT/ET4c
 WxUA==
X-Gm-Message-State: AOJu0YwjHE/7oHkO6GD3ipxB7p2t/hWIZRM7e6A8bjZVWcivjS7Z/qMT
 aldtxtDRgf0TbVS5s1+jwAUivQlPcF+gg9of0R1UtjfUqLviTr5bf49NbP7Yk/rYV8/SNEKOY+X
 GpDZo+w==
X-Gm-Gg: ASbGnctx7iscoYv8l+yYp+wQiucz2tO/D65/SaNANdUp0Kwmbiw2J6C1C0eP8Yu2hKd
 AzSGO8pM8mobtx6dtEkER+2iTl95QlETguQcNkSmDXJypVCoeKe/sGkoU26jDcpUNFw//uBNY3E
 7Q5DpfDZaEOInQNCefaCBMt8godyYb7yTevcXnNwDy1D1qOBpw+MxpxlmXLciQGfmIBLvok+eox
 UBFUPGzN3/DBSn1bcCaDsVFfTyvCMj9M/ggqg7n5zf35JKCOOAqbdlBleI=
X-Google-Smtp-Source: AGHT+IEbP2nc6gNG0lwEXWOr1+gcvSrQ5Fsdf6qIYzuJtxtG3fuaKmC1RqH7/zfVM3AFrcsS0+tOhg==
X-Received: by 2002:a05:6871:6281:b0:29e:569a:f90d with SMTP id
 586e51a60fabf-2aa0690ed62mr17328593fac.32.1736966624975; 
 Wed, 15 Jan 2025 10:43:44 -0800 (PST)
Received: from grind.. ([191.202.238.10]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ad80a5cb64sm6539196fac.47.2025.01.15.10.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:43:43 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 5/6] target/riscv: add RVA23U64 profile
Date: Wed, 15 Jan 2025 15:43:15 -0300
Message-ID: <20250115184316.2344583-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115184316.2344583-1-dbarboza@ventanamicro.com>
References: <20250115184316.2344583-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::43;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x43.google.com
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


