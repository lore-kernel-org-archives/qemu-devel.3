Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C02C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYObW-0001vS-Nz; Fri, 09 Feb 2024 05:59:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObU-0001dr-Ow
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:32 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObO-0000Gz-DF
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:31 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-21920c78c9fso390985fac.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476365; x=1708081165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3esT2gP09ngePOxl0aGtsw5fdTayTD8DyvGQ56mj7k=;
 b=EsefeuVxbdyRCFXjiJnONfJJqMHrQREXtCXqJRPXb1GzKuIeu//4P3gUrC/JVoXUAh
 s7tRiALFdKS3YKgFlnfGsf9XyVUFmNaeeKQESwaqwSZmlym1ooWMWd70QUac0v8n6gZD
 OWrKa74mZu7dsesB+0ppp0AA1GOwa9sTrEELIeuZJXkz/mhMTzkKThC0kTJqL9pqIBZ8
 nIJG1NhSY2dtm2sbMTNgrzghLhPi5XXvcMzIm0aexLtgcDjTtzYX3h6jnd+i0/TAO510
 4laVJ60dKwqHeQLXBKXjHaVmxsF6N1q2oQji/9ZoIUQrrQ4kWAOC4gxKuEfRsvFeONwS
 JRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476365; x=1708081165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X3esT2gP09ngePOxl0aGtsw5fdTayTD8DyvGQ56mj7k=;
 b=OJ6Td6HkJA90M2N8dy1hIdyxRaCtJm3t+aSEs8uMichrCUlR34MNSfBdI0MydriUmT
 jtOxtNorWsQ3dLBYRjhyQOIQio49JF+rteV2I4LhMLqB1f4JRMjEd2rnYqjPES6chVbc
 u6tIjjx1zC47RG8McNNWl3mvGVDZscWLCoD20YAwHpzlZsm5G7Ri6sKUtrUmvhN9ttKy
 hgXBgVNu662d93pAuq/7IZiwcclpW2L3xahikKlVbZM8JS98jHE/D8RbjaZ/EKG9P2Gv
 CQ/9SYPEYaKyqQ0pgCvdAvPIONLmmGDNwVLEMQMUqf1+ADyXp1tKuA1zTDo1ZXj4v8pu
 Duug==
X-Gm-Message-State: AOJu0Yz08YWjSOJfykzu58QeA8G94KHXm5mIDtte4uk1FYa76oFPsYVI
 m1e5c3MJKHlqahj0cmX8GPckomJ6Vp3cIuDH7Zw0VygegRiqpmgkhSNApj6x8TjSiw==
X-Google-Smtp-Source: AGHT+IFriOg2blq9IPpSn7J7JYmen3GmfR7x41cNiK1WYmHMXPrhlnihCVNpIFlyyXiK5eRBPDRlWg==
X-Received: by 2002:a05:6870:468c:b0:21a:293:d22d with SMTP id
 a12-20020a056870468c00b0021a0293d22dmr1157373oap.23.1707476364956; 
 Fri, 09 Feb 2024 02:59:24 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVY5JrA/T0eHyB8y0nSioZ50nt1QLF3nd7bCtpTE0FFwgcbXBcTaq0sZW1ydwoqEmiolWP/mpYF2aCSfD75Vrte9euNMB2V/SW8uksGVJ6JLMvL34VSNWJnpKiy0Dp4Q7ZO+vPQBD1zs6SmT2tvZ6aK/t/mc6b7vh369EFr2VoTKqA=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:59:24 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Vladimir Isaev <vladimir.isaev@syntacore.com>
Subject: [PULL 18/61] target/riscv/cpu.c: move 'mvendorid' to
 riscv_cpu_properties[]
Date: Fri,  9 Feb 2024 20:57:30 +1000
Message-ID: <20240209105813.3590056-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=alistair23@gmail.com; helo=mail-oa1-x32.google.com
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

Keep all class properties in riscv_cpu_properties[].

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
tested-by tags added, rebased with Alistair's riscv-to-apply.next.
Message-ID: <20240112140201.127083-7-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 69 +++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 32 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f0e3cfda33..a14d7da11d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1985,6 +1985,41 @@ static const PropertyInfo prop_cboz_blksize = {
     .set = prop_cboz_blksize_set,
 };
 
+static void prop_mvendorid_set(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    bool dynamic_cpu = riscv_cpu_is_dynamic(obj);
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint32_t prev_val = cpu->cfg.mvendorid;
+    uint32_t value;
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        return;
+    }
+
+    if (!dynamic_cpu && prev_val != value) {
+        error_setg(errp, "Unable to change %s mvendorid (0x%x)",
+                   object_get_typename(obj), prev_val);
+        return;
+    }
+
+    cpu->cfg.mvendorid = value;
+}
+
+static void prop_mvendorid_get(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    uint32_t value = RISCV_CPU(obj)->cfg.mvendorid;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_mvendorid = {
+    .name = "mvendorid",
+    .get = prop_mvendorid_get,
+    .set = prop_mvendorid_set,
+};
+
 /*
  * RVA22U64 defines some 'named features' or 'synthetic extensions'
  * that are cache related: Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa
@@ -2071,6 +2106,8 @@ static Property riscv_cpu_properties[] = {
     {.name = "cbop_blocksize", .info = &prop_cbop_blksize},
     {.name = "cboz_blocksize", .info = &prop_cboz_blksize},
 
+     {.name = "mvendorid", .info = &prop_mvendorid},
+
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
 #endif
@@ -2151,35 +2188,6 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
 };
 #endif
 
-static void cpu_set_mvendorid(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
-{
-    bool dynamic_cpu = riscv_cpu_is_dynamic(obj);
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    uint32_t prev_val = cpu->cfg.mvendorid;
-    uint32_t value;
-
-    if (!visit_type_uint32(v, name, &value, errp)) {
-        return;
-    }
-
-    if (!dynamic_cpu && prev_val != value) {
-        error_setg(errp, "Unable to change %s mvendorid (0x%x)",
-                   object_get_typename(obj), prev_val);
-        return;
-    }
-
-    cpu->cfg.mvendorid = value;
-}
-
-static void cpu_get_mvendorid(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
-{
-    uint32_t value = RISCV_CPU(obj)->cfg.mvendorid;
-
-    visit_type_uint32(v, name, &value, errp);
-}
-
 static void cpu_set_mimpid(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
@@ -2290,9 +2298,6 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     cc->gdb_arch_name = riscv_gdb_arch_name;
     cc->gdb_get_dynamic_xml = riscv_gdb_get_dynamic_xml;
 
-    object_class_property_add(c, "mvendorid", "uint32", cpu_get_mvendorid,
-                              cpu_set_mvendorid, NULL, NULL);
-
     object_class_property_add(c, "mimpid", "uint64", cpu_get_mimpid,
                               cpu_set_mimpid, NULL, NULL);
 
-- 
2.43.0


