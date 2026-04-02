Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07013D6AB18
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q2P-0008SE-JI; Thu, 02 Apr 2026 17:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2G-0008LH-No
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:10 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2E-000785-JV
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:08 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-66bb66db39dso2177083a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167025; x=1775771825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LKKPXz0sjji07wp3e+Tjd0az/D2l0r8RdFJziCGOVu0=;
 b=MKUu0K4UB8wgHdpbx0M5q8i1D0wBINYz3B0/s/P0RG+UMz22FtU2wogRohLRzn8QoN
 ly8Cdl7vQZJSqtwKEr/CSUhYIRd+ZrhrUw23Jq7cXbRyLW105pmN3oXtH0TOVuLrLm1r
 b+iHcMXIPLmMFzszluezSxNrqQ71JnIZhluSLDIXYpElUJWACa7WLTEjWyDZ9/2jPqwc
 8E16xZvEJrjygTSvuuuRBi4zNMrkyVkE4UwDMyVOFmCPgHf8HqeOq4HSB/qVANRphe9P
 VAUYkIwxkX/ZrFfDKqMLm84yYqoVZun2gQS+9hCaXnMtu17QQJET7FPZN+9Mle5L2TUx
 7glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167025; x=1775771825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LKKPXz0sjji07wp3e+Tjd0az/D2l0r8RdFJziCGOVu0=;
 b=tWQP14kOb5WlwrweGao28lJrUz8nlvJydhZHebY6yyxfDTSZv6+H77ucykV3uYQ0Ux
 kK4gRebLM8NWkle+0+i34yz1g8VBUW5h65hANG3yfCUk3ojvQgGrxcR0dOmRl870vDVw
 uuFgJHJDA4XwaRwFqrjjHk9AuJnZ8X5c1VK2R+aSpyPWtZs8mKdn2on+zu9DXDNiafHj
 jAskVYlqh7SVMq3E4OPDHNdZyKZzBdDHS+7YPSH+5c9PM2B/AJVK5jwyqEoxmDsTXA0z
 nSP6YmxcIpL0NgJxZGUVrWBD/t1tu13Fjdn7gIRX5C2i98fJEaGstx0A6XThM8q0mUhr
 ZBww==
X-Gm-Message-State: AOJu0YwD4zCxslFJ3mXJTUjRVWrXpIK+3PSa52u0pNMfRiHMkEmg/TDs
 507zAQiWazXxehyfd54CWcYpKxPZaPjwyYYrpXfSbOrRRAgsA5We0AVyZquiQrg3
X-Gm-Gg: ATEYQzyMbjFSwY5muePHrO/r7W/FL0DzfGxqKIoJ5LOkxZx6ASDEkc/ipyIV1NXwzwr
 T3jdU92haMChODztWt7FXNtpb7UzzZBeZWXKtMsY2Eyw4RrJEKyLo+n5xT5DpxNmnHzrjpDAwFO
 yev20q8X7VXiJ/QKK+6ynIX2LC8wAyhyNHq6PmiEo9bg7njw4b5y8v622kNY9xnPYLNdvyMlh2v
 qWHJrn3x8gKxoFmXS2cV9MB3wsfxyvqq2zmgB497pyfmq1UzL2H+gY+S+tQ0BNLIrstgEPQi352
 pPR//3hA+1Pi9/Twe/JE+s3LEAnS5ui/d+EGYBx5ADXUqF4UIOnqf0SsWoeP//G4f3QiQ2aSNqX
 +Txqh+cTDWzKUb+sydYgcxeCLTOSoDYffmHWUfFqwq0QyCkmPaFWnVkSU/PPZPYkRn45bjiJt84
 di8BMjnAbrMhoZ5g5vkmcUkK9TIICq39j6MuCKVS7DG8Yep/yBcVQoltViwEeTNVXLVsPaLw==
X-Received: by 2002:a17:906:ba83:b0:b9c:6178:6a77 with SMTP id
 a640c23a62f3a-b9c67925198mr29744866b.25.1775167024835; 
 Thu, 02 Apr 2026 14:57:04 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:57:04 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v3 13/33] hw/core/fdt_generic_util: add TYPE_FDT_GENERIC_MMAP
Date: Thu,  2 Apr 2026 23:55:58 +0200
Message-ID: <20260402215629.745866-14-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Add new FDT_GENERIC_MMAP class and interface to allow
devices to register own handlers for mapping memory
regions in device tree's 'reg' property.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c         | 11 ++++++++
 include/hw/core/fdt_generic_util.h | 44 ++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index 8ae9e23073..8f91bcb66c 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -617,3 +617,14 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
     return 0;
 }
 
+static const TypeInfo fdt_generic_mmap_info = {
+    .name          = TYPE_FDT_GENERIC_MMAP,
+    .parent        = TYPE_INTERFACE,
+    .class_size = sizeof(FDTGenericMMapClass),
+};
+
+static void fdt_generic_register_types(void)
+{
+    type_register_static(&fdt_generic_mmap_info);
+}
+type_init(fdt_generic_register_types)
diff --git a/include/hw/core/fdt_generic_util.h b/include/hw/core/fdt_generic_util.h
index 71bedb6631..e3671990ad 100644
--- a/include/hw/core/fdt_generic_util.h
+++ b/include/hw/core/fdt_generic_util.h
@@ -16,4 +16,48 @@
 
 FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq);
 
+#define TYPE_FDT_GENERIC_MMAP "fdt-generic-mmap"
+
+#define FDT_GENERIC_MMAP_CLASS(klass) \
+     OBJECT_CLASS_CHECK(FDTGenericMMapClass, (klass), TYPE_FDT_GENERIC_MMAP)
+#define FDT_GENERIC_MMAP_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(FDTGenericMMapClass, (obj), TYPE_FDT_GENERIC_MMAP)
+#define FDT_GENERIC_MMAP(obj) \
+     INTERFACE_CHECK(FDTGenericMMap, (obj), TYPE_FDT_GENERIC_MMAP)
+
+typedef struct FDTGenericMMap {
+    /*< private >*/
+    Object parent_obj;
+} FDTGenericMMap;
+
+/*
+ * The number of "things" in the tuple. Not to be confused with the cell length
+ * of the tuple (which is variable based on content
+ */
+
+#define FDT_GENERIC_REG_TUPLE_LENGTH 4
+
+typedef struct FDTGenericRegPropInfo {
+    int n;
+    union {
+        struct {
+            uint64_t *a;
+            uint64_t *s;
+            uint64_t *b;
+            uint64_t *p;
+        };
+        uint64_t *x[FDT_GENERIC_REG_TUPLE_LENGTH];
+    };
+    Object **parents;
+} FDTGenericRegPropInfo;
+
+typedef struct FDTGenericMMapClass {
+    /*< private >*/
+    InterfaceClass parent_class;
+
+    /*< public >*/
+    bool (*parse_reg)(FDTGenericMMap *obj, FDTGenericRegPropInfo info,
+                      Error **errp);
+} FDTGenericMMapClass;
+
 #endif /* FDT_GENERIC_UTIL_H */
-- 
2.43.0


