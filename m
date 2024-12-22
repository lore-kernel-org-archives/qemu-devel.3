Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7102E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 10:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPJOH-00073c-Va; Sun, 22 Dec 2024 05:40:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hal.martin@gmail.com>)
 id 1tPJOE-00072T-8e
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 05:40:50 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hal.martin@gmail.com>)
 id 1tPJOC-0000I8-5G
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 05:40:49 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso20439955e9.1
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 02:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734864045; x=1735468845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+hbx3GO4unRR6HZV4IvVMmVfOKjlVa0u39KZ6AEi31k=;
 b=Gj3sAyrZMetX1sf4lO9cue4QM75E2kVWsmBNq0WvMPcfFuW4W/4qb6bP/8v/XvJ2pN
 S9vl/S2A4ycQI0lGXbBLvt6gcAt/2yOI15h9rUXHAORxSS1xT03EoZO3/rzivma96TBD
 TreP4Pka7vnviOikullTyUESD4h3k/FHsEoZfxJRk7lo0vHRgwSQDDwJ2WGxot7poe8Q
 CBtqOZkzCkGQ6Rktp8dYOOC1e3H3CK7ZEwu58KovCEBS2tWIFgIbL0O9hyzcmfFQyAuJ
 NAEenkApjLmxQM6+Knhovwh2259yXVOZcd8T81Gm1qUphMNkR4UCY+hbEJIGBb2pjQGp
 2BzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734864045; x=1735468845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+hbx3GO4unRR6HZV4IvVMmVfOKjlVa0u39KZ6AEi31k=;
 b=YDEgvE8hNdWNtxKmZYOWRdX/inQjUCkyBKhYoV5cI+E3i2Z69GOMFbNfnJcc6Zz8TT
 v9OzCGW/ju2hwm4bwfBEFx2qI5XyDx+2SqVkuEurnv94f75W0/DDVJxjJpvEw9iRZZ2V
 HFrg5ox1BPavvPcQHkk5BBhAMSFFjnXaHv0v/d5+oGnzdJMhOZz9OFqml3r6R8aCJ+wR
 et6mMAwVYXg4Fv3uepynKPGjgNiaWDWhQoTZa2jKckXTcl/yTeA8XAqE/pP7Y4ti3sWR
 C0PiGUDVOsxcuY3jXzhRDjkKB+ub1wb+tPcE1L1d+72KEnq8sGQcsc6SEj3+OmKnMrNK
 3YyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWmTB5uX3V6I80ndJ5j26fSW2fuIvL6nJG+yPRkl3gXI0zM3C+FyYei2IMTe9nJIm8zSNxPX/oafaX@nongnu.org
X-Gm-Message-State: AOJu0Ywwye3rRD6Hdy/WkVZwX0qkDcvGArr6SYDYlqiRUT27+pUv3Z5r
 ao6zkBqxZcode4cj4oWoM8S0XPvH7L87M4lQirfTzvIoazYuYdR6
X-Gm-Gg: ASbGnctfch3SkdbBv/bPvhu1W/GJ8o+Mr1gjNUKvA5gGILK4EZG5c5AyG5TcdCGy1Jp
 cDXVbfTwqlOmHCEGom9P8rvarUdHaF7kZOYhtRixxPMBEhbxFGSVCLTtnrX9Mgkz1XNtOdbHin+
 y695EtLPVGrGjl6zVtJ6ortH4u1w39zol8WS4qq/eD6X9bRL/Yr91hXGid4LKd/fNFisQpl2hJp
 WMh5woY/ptJQOMe09ACGR2apDWyKQgslaktXi7/kMnDQaQvwDxCKYAlb3A8u37EkisySg==
X-Google-Smtp-Source: AGHT+IEtGoCKxEy/GhAZT+IVQoWaV7Y90aZ0UoJ6OJNXkhQ9rdVJ65mW/PolbLxvtNKuLllvEusp2Q==
X-Received: by 2002:a7b:cc0f:0:b0:436:1b77:b5aa with SMTP id
 5b1f17b1804b1-4365c775154mr115907875e9.8.1734864044776; 
 Sun, 22 Dec 2024 02:40:44 -0800 (PST)
Received: from fitlet2.primaryno.de ([185.154.111.60])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b417afsm135278785e9.36.2024.12.22.02.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 02:40:44 -0800 (PST)
From: Hal Martin <hal.martin@gmail.com>
To: imammedo@redhat.com
Cc: Hal Martin <hal.martin@gmail.com>, qemu-devel@nongnu.org, mst@redhat.com,
 anisinha@redhat.com
Subject: [PATCH v4] hw/smbios: support for type 7 (cache information)
Date: Sun, 22 Dec 2024 10:40:05 +0000
Message-Id: <20241222104005.10501-1-hal.martin@gmail.com>
X-Mailer: git-send-email 2.38.5
In-Reply-To: <20240926160501.593c2b96@imammedo.users.ipa.redhat.com>
References: <20240926160501.593c2b96@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=hal.martin@gmail.com; helo=mail-wm1-x334.google.com
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
size: cache size

Example usage:
-smbios type=7,level=1,size=1M

Note: this does not change the actual layout of the CPU cache(s),
it simply allows the user to specify data in SMBIOS to be presented
to the guest. This is useful for example if you have software that
queries SMBIOS for the CPU cache levels/size.

Signed-off-by: Hal Martin <hal.martin@gmail.com>
---
 hw/smbios/smbios.c           | 116 +++++++++++++++++++++++++++++++++++
 include/hw/firmware/smbios.h |  29 +++++++++
 qemu-options.hx              |   2 +
 3 files changed, 147 insertions(+)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 02a09eb9cd..9885e902b0 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/config-file.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
@@ -83,6 +84,13 @@ static struct {
     .processor_family = 0x01, /* Other */
 };
 
+struct type7_instance {
+    uint16_t level;
+    uint64_t size;
+    QTAILQ_ENTRY(type7_instance) next;
+};
+static QTAILQ_HEAD(, type7_instance) type7 = QTAILQ_HEAD_INITIALIZER(type7);
+
 struct type8_instance {
     const char *internal_reference, *external_reference;
     uint8_t connector_type, port_type;
@@ -330,6 +338,23 @@ static const QemuOptDesc qemu_smbios_type4_opts[] = {
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
+        .type = QEMU_OPT_SIZE,
+        .help = "cache size",
+    },
+    { /* end of list */ }
+};
+
 static const QemuOptDesc qemu_smbios_type8_opts[] = {
     {
         .name = "type",
@@ -733,6 +758,80 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance,
     smbios_type4_count++;
 }
 
+static void smbios_build_type_7_table(SmbiosEntryPointType ep_type)
+{
+    unsigned instance = 0;
+    size_t tbl_len = SMBIOS_TYPE_7_LEN_V21;
+    struct type7_instance *t7;
+    char designation[50];
+    uint16_t cache_size = 0;
+    uint32_t cache_size2 = 0;
+
+    if (ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
+        tbl_len = SMBIOS_TYPE_7_LEN_V31;
+    }
+
+    QTAILQ_FOREACH(t7, &type7, next) {
+        if (t7->size < 1024) {
+            error_report("SMBIOS CPU cache size (%lu) is too small (>1k)",
+                         t7->size);
+            exit(1);
+        }
+        SMBIOS_BUILD_TABLE_PRE(7, T0_BASE + instance, true);
+        sprintf(designation, "CPU Internal L%d", t7->level);
+        SMBIOS_TABLE_SET_STR(7, socket_designation, designation);
+        /* cache not socketed, enabled, write back */
+        t->cache_configuration =  cpu_to_le16(0x180 | ((t7->level) - 1));
+        if (tbl_len == SMBIOS_TYPE_7_LEN_V21) {
+            if (t7->size > 1024*MiB) {
+                error_report("SMBIOS 2.0 doesn't support CPU cache "
+                            "sizes more than 1024 MiB, use "
+                            "-machine smbios-entry-point-type=64 option to "
+                            "enable SMBIOS 3.0 support");
+                exit(1);
+            }
+        }
+        /* size is defined in 1k granularity */
+        cache_size = t7->size/1024;
+        if (t7->size > INT16_MAX) {
+            /* set granularity to 64KiB */
+            cache_size = cpu_to_le16(t7->size/(64*1024) | (0x1 << 15));
+        }
+
+        t->supported_sram_type = cpu_to_le16(0x10); /* pipeline burst */
+        t->current_sram_type = cpu_to_le16(0x10); /* pipeline burst */
+        t->cache_speed = 0x1; /* 1 ns */
+        t->error_correction_type = 0x6; /* Multi-bit ECC */
+        t->system_cache_type = 0x05; /* Unified */
+        t->associativity = 0x6; /* Fully Associative */
+
+        if (tbl_len == SMBIOS_TYPE_7_LEN_V31) {
+            if (t7->size > ((uint64_t)2 << 45)) {
+                error_report("SMBIOS CPU cache size (%lu) is too large",
+                             t7->size);
+                exit(1);
+            }
+            cache_size2 = t7->size/1024;
+            /* For Cache sizes greater than 2047 MB, the */
+            /* Maximum Cache Size field is set to 0xFFFF */
+            if (cache_size2 > (2 << 20)) {
+                cache_size = 0xffff;
+                /* set granularity to 64KiB */
+                cache_size2 = cpu_to_le32(t7->size/(64*1024) | (0x1 << 31));
+            }
+
+            t->maximum_cache_size2 = cache_size2;
+            t->installed_cache_size2 = cache_size2;
+
+        }
+        t->installed_size = cache_size;
+        /* set max size to installed size */
+        t->maximum_cache_size = cache_size;
+        SMBIOS_BUILD_TABLE_POST;
+        instance++;
+    }
+}
+
 static void smbios_build_type_8_table(void)
 {
     unsigned instance = 0;
@@ -1120,6 +1219,7 @@ static bool smbios_get_tables_ep(MachineState *ms,
         }
     }
 
+    smbios_build_type_7_table(ep_type);
     smbios_build_type_8_table();
     smbios_build_type_9_table(errp);
     smbios_build_type_11_table();
@@ -1478,6 +1578,22 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
                            UINT16_MAX);
             }
             return;
+        case 7:
+            if (!qemu_opts_validate(opts, qemu_smbios_type7_opts, errp)) {
+                return;
+            }
+            struct type7_instance *t7_i;
+            t7_i = g_new0(struct type7_instance, 1);
+            t7_i->level = qemu_opt_get_number(opts, "level", 0);
+            t7_i->size = qemu_opt_get_size(opts, "size", 0);
+            /* Only cache levels 1-8 are permitted */
+            if (t7_i->level > 8) {
+                error_setg(errp, "SMBIOS CPU cache level %d is invalid (1-8)",
+                           t7_i->level);
+                return;
+            }
+            QTAILQ_INSERT_TAIL(&type7, t7_i, next);
+            return;
         case 8:
             if (!qemu_opts_validate(opts, qemu_smbios_type8_opts, errp)) {
                 return;
diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index f066ab7262..996d36fead 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -220,6 +220,35 @@ typedef enum smbios_type_4_len_ver {
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
+    /* SMBIOS spec 3.1.0, Table 36  */
+    uint32_t maximum_cache_size2;
+    uint32_t installed_cache_size2;
+    /* contained elements follow */
+} QEMU_PACKED;
+
+typedef enum smbios_type_7_len_ver {
+    SMBIOS_TYPE_7_LEN_V20 = offsetofend(struct smbios_type_7,
+                                        current_sram_type),
+    SMBIOS_TYPE_7_LEN_V21 = offsetofend(struct smbios_type_7,
+                                        associativity),
+    SMBIOS_TYPE_7_LEN_V31 = offsetofend(struct smbios_type_7,
+                                        installed_cache_size2),
+} smbios_type_7_len_ver;
+
+
 /* SMBIOS type 8 - Port Connector Information */
 struct smbios_type_8 {
     struct smbios_structure_header header;
diff --git a/qemu-options.hx b/qemu-options.hx
index cc694d3b89..a85bfac647 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2644,6 +2644,8 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
     "              [,asset=str][,part=str][,max-speed=%d][,current-speed=%d]\n"
     "              [,processor-family=%d][,processor-id=%d]\n"
     "                specify SMBIOS type 4 fields\n"
+    "-smbios type=7[,level=%d][,size=%d]\n"
+    "                specify SMBIOS type 7 fields\n"
     "-smbios type=8[,external_reference=str][,internal_reference=str][,connector_type=%d][,port_type=%d]\n"
     "                specify SMBIOS type 8 fields\n"
     "-smbios type=11[,value=str][,path=filename]\n"
-- 
2.42.0


