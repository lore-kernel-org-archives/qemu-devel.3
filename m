Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC339C3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 10:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sd65v-0006Co-CY; Sun, 11 Aug 2024 06:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hal.martin@gmail.com>)
 id 1sd65P-0006Bm-Or
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 06:46:09 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hal.martin@gmail.com>)
 id 1sd65N-0005Ew-1V
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 06:46:06 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-530e22878cfso3128907e87.2
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 03:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723373163; x=1723977963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZD5O7TwQmMaTpkciTY8PROyMm0V8tr+t1MtcpKWowJ4=;
 b=aF3a/GlXbP67a7i0qtroayF398KVlwo4uOHHk9BJzpYV5MmtFf4ITsLZDB+qSwTEwZ
 E8CY6+7Xk1zWVjBqDJ18FEQSWpblBbXOKLYp3rpb6//75cyY9b8dT+2SpqujdOMhOy/U
 fSZ3H82w5FxzCyxM39vTGncZhv67uOWcfOpvNhLyNmi+T6tKf3tU8mtq7oM5pjboBpD8
 QhJogDuS9tu9tIYx9/l+NJrOboDJbqTjlhAiXKSVSEOlOqlfDxPFwXqAssbR4CYg3RD7
 1rbfpO+HN77GZbl/W07eGjo4djwybPGXP8H4Jn0LSPaB2kit9t8RHViDl/MSGYmeCc++
 N0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723373163; x=1723977963;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZD5O7TwQmMaTpkciTY8PROyMm0V8tr+t1MtcpKWowJ4=;
 b=WUKzcJFXsmmkBvUbdmOoZEjbfeg/zrDongj0wYCjvyzrItGeDhmMWN0VShLXk2i9k7
 KBuyXyxxyf5zfqSIfX2eKtFiLHWILeLSOg+w+/9QMOxOuBEPAtcWnhp65LUU5zhsYh2v
 RI34Iu4qwEu3YCFUv4ks998cmhxepHzJE+j8bx9kIaX8XnILdJYOFwPa9lYClh2SzKZ7
 xfFNu+EMrwXIIxMkQ3AvFVxosoJEVVhmXCWEnt6k0SuCjH7XYaypX6zQQ922HaezA9YA
 e9L29TVFl0oDXfPpk7MkPu96t3eFTNo0NhypNnADoIpmIMiDaMjmTMxTt9eplN8hnRzK
 9IFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR3i9x/AYK+MLvZaOo6I4DGdXXaYg4LgQHvj/VK9B4HqHuvnFnSBu9gpsoYzB/mQf4wQPOoX/IK+I+k2USrgTqvQX4MsU=
X-Gm-Message-State: AOJu0YxjEUyDgxl7F+rCIb0B7KAyKTNCgJdVztFXHGRs5slX4gQpt6Iq
 FpyG0PV5FSMJX51LjgCN5Zbg8QxRoB64g0BhtUngpAHnks6Dq5V8
X-Google-Smtp-Source: AGHT+IF8KPVyFtsNUyWbGLw5SPPHNNpfR/JFitnWQ2GKefzj2lJDkBc3xRpqg88aMZOPk0NMkUCAkQ==
X-Received: by 2002:a05:6512:15a3:b0:52c:e402:4dc1 with SMTP id
 2adb3069b0e04-530eea425b6mr4983556e87.55.1723373162424; 
 Sun, 11 Aug 2024 03:46:02 -0700 (PDT)
Received: from fitlet2.primaryno.de ([2a00:1598:d884:b000:201:c0ff:fe1f:9fb1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53200f1b70fsm429273e87.229.2024.08.11.03.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 03:46:02 -0700 (PDT)
From: Hal Martin <hal.martin@gmail.com>
To: mst@redhat.com
Cc: Hal Martin <hal.martin@gmail.com>, qemu-devel@nongnu.org,
 imammedo@redhat.com, anisinha@redhat.com
Subject: [PATCH] hw/smbios: support for type 7 (cache information)
Date: Sun, 11 Aug 2024 10:45:38 +0000
Message-Id: <20240811104538.14223-1-hal.martin@gmail.com>
X-Mailer: git-send-email 2.38.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=hal.martin@gmail.com; helo=mail-lf1-x130.google.com
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

This patch adds support for SMBIOS type 7 (Cache Information) to qemu.

level: cache level (1-8)
size: cache size in bytes

Example usage:
-smbios type=7,level=1,size=0x8000

Signed-off-by: Hal Martin <hal.martin@gmail.com>
---
 hw/smbios/smbios.c           | 63 ++++++++++++++++++++++++++++++++++++
 include/hw/firmware/smbios.h | 18 +++++++++++
 qemu-options.hx              |  2 ++
 3 files changed, 83 insertions(+)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index a394514264..65942f2354 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -83,6 +83,12 @@ static struct {
     .processor_family = 0x01, /* Other */
 };
 
+struct type7_instance {
+    uint16_t level, size;
+    QTAILQ_ENTRY(type7_instance) next;
+};
+static QTAILQ_HEAD(, type7_instance) type7 = QTAILQ_HEAD_INITIALIZER(type7);
+
 struct type8_instance {
     const char *internal_reference, *external_reference;
     uint8_t connector_type, port_type;
@@ -330,6 +336,23 @@ static const QemuOptDesc qemu_smbios_type4_opts[] = {
     { /* end of list */ }
 };
 
+static const QemuOptDesc qemu_smbios_type7_opts[] = {
+    {
+        .name = "type",
+        .type = QEMU_OPT_NUMBER,
+        .help = "SMBIOS element type",
+    },{
+        .name = "level",
+        .type = QEMU_OPT_NUMBER,
+        .help = "cache level",
+    },{
+        .name = "size",
+        .type = QEMU_OPT_NUMBER,
+        .help = "cache size",
+    },
+    { /* end of list */ }
+};
+
 static const QemuOptDesc qemu_smbios_type8_opts[] = {
     {
         .name = "type",
@@ -733,6 +756,32 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance,
     smbios_type4_count++;
 }
 
+static void smbios_build_type_7_table(void)
+{
+    unsigned instance = 0;
+    struct type7_instance *t7;
+    char designation[20];
+
+    QTAILQ_FOREACH(t7, &type7, next) {
+        SMBIOS_BUILD_TABLE_PRE(7, T0_BASE + instance, true);
+        sprintf(designation, "CPU Internal L%d", t7->level);
+        SMBIOS_TABLE_SET_STR(7, socket_designation, designation);
+        t->cache_configuration =  0x180 | (t7->level-1); /* not socketed, enabled, write back*/
+        t->installed_size =  t7->size;
+        t->maximum_cache_size =  t7->size; /* set max to installed */
+        t->supported_sram_type = 0x10; /* pipeline burst */
+        t->current_sram_type = 0x10; /* pipeline burst */
+        t->cache_speed = 0x1; /* 1 ns */
+        t->error_correction_type = 0x6; /* Multi-bit ECC */
+        t->system_cache_type = 0x05; /* Unified */
+        t->associativity = 0x6; /* Fully Associative */
+        t->maximum_cache_size2 = t7->size;
+        t->installed_cache_size2 = t7->size;
+        SMBIOS_BUILD_TABLE_POST;
+        instance++;
+    }
+}
+
 static void smbios_build_type_8_table(void)
 {
     unsigned instance = 0;
@@ -1120,6 +1169,7 @@ static bool smbios_get_tables_ep(MachineState *ms,
         }
     }
 
+    smbios_build_type_7_table();
     smbios_build_type_8_table();
     smbios_build_type_9_table(errp);
     smbios_build_type_11_table();
@@ -1478,6 +1528,19 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
                            UINT16_MAX);
             }
             return;
+        case 7:
+            if (!qemu_opts_validate(opts, qemu_smbios_type7_opts, errp)) {
+                return;
+            }
+            struct type7_instance *t7_i;
+            t7_i = g_new0(struct type7_instance, 1);
+            t7_i->level = qemu_opt_get_number(opts,"level", 0x0);
+            t7_i->size = qemu_opt_get_number(opts, "size", 0x0200);
+            /* Only cache levels 1-8 are permitted */
+            if (t7_i->level > 0 && t7_i->level < 9) {
+                QTAILQ_INSERT_TAIL(&type7, t7_i, next);
+            }
+            return;
         case 8:
             if (!qemu_opts_validate(opts, qemu_smbios_type8_opts, errp)) {
                 return;
diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index f066ab7262..1ea1506b46 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -220,6 +220,24 @@ typedef enum smbios_type_4_len_ver {
     SMBIOS_TYPE_4_LEN_V30 = offsetofend(struct smbios_type_4, thread_count2),
 } smbios_type_4_len_ver;
 
+/* SMBIOS type 7 - Cache Information (v2.0+) */
+struct smbios_type_7 {
+    struct smbios_structure_header header;
+    uint8_t socket_designation;
+    uint16_t cache_configuration;
+    uint16_t maximum_cache_size;
+    uint16_t installed_size;
+    uint16_t supported_sram_type;
+    uint16_t current_sram_type;
+    uint8_t cache_speed;
+    uint8_t error_correction_type;
+    uint8_t system_cache_type;
+    uint8_t associativity;
+    uint32_t maximum_cache_size2;
+    uint32_t installed_cache_size2;
+    /* contained elements follow */
+} QEMU_PACKED;
+
 /* SMBIOS type 8 - Port Connector Information */
 struct smbios_type_8 {
     struct smbios_structure_header header;
diff --git a/qemu-options.hx b/qemu-options.hx
index cee0da2014..3b49813fcc 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2706,6 +2706,8 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
     "              [,asset=str][,part=str][,max-speed=%d][,current-speed=%d]\n"
     "              [,processor-family=%d,processor-id=%d]\n"
     "                specify SMBIOS type 4 fields\n"
+    "-smbios type=7[,level=%d][,size=%d]\n"
+    "                specify SMBIOS type 7 fields\n"
     "-smbios type=8[,external_reference=str][,internal_reference=str][,connector_type=%d][,port_type=%d]\n"
     "                specify SMBIOS type 8 fields\n"
     "-smbios type=11[,value=str][,path=filename]\n"
-- 
2.42.0


