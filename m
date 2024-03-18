Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D412C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFfF-00082H-HQ; Mon, 18 Mar 2024 12:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFfD-0007tW-Bs
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFf5-0004jk-SP
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+2NU3RdVHDfdhC7PtdUsznUnUG0uH352XNbJ00IycZU=;
 b=EWF+/UHk1TMYcH+nHQIfc3gMMt8PAj7EZUF7kfcN3BKZvoic2xxUhWjL8/9ZXSsD4Xjd+W
 HqhvrIOdftJfqrjI2SSazmruheSNAezAPpexJN+68jDow/iAQntmLPeTcrgfzHx7l6wrTu
 3c/cfr78SRdtBWqOt/kcHWmrNpF/WCI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-GgfXB7r6PrG2BuqLkMJEdA-1; Mon, 18 Mar 2024 12:16:29 -0400
X-MC-Unique: GgfXB7r6PrG2BuqLkMJEdA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33ed8677d16so1308869f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778588; x=1711383388;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+2NU3RdVHDfdhC7PtdUsznUnUG0uH352XNbJ00IycZU=;
 b=KSJ9H6f6EDJ+xmuMrO6GwEBsyuzTLGEC1VRIYIOHLsjOpizgloBoJfLLUBXDQN1DMB
 QsfLZKegWh4RHB7YgQjFdvZRVqwLBXauZ7x7xz9iF08w9e+XOJd3DYGhZavEWLptYXvh
 Z9eK77fEADLrip2KsLgpfFFqqM/R5GsA+M398+QNggnBqzx8kdOMOZDjil9L4UweBqcm
 HLwHzWEHQCD6ByGWQ/q5kJDOoWFxwdueD/nNoKSbSPZJ8Vx41928Va0Ao2inRDOF32Xf
 uBTcfyjyHjfygpLZmDwFQxOOnF0rrnEMFXwcJzWDTdoqhivYS50weGOpR5tyWmctYfnK
 Ju+g==
X-Gm-Message-State: AOJu0YxIByfS6SkEGkpXzZ1QeGBzAkhVa09R3XkxDa15TqE3jGDzXMdr
 emSu7ezQXPYSN+qLeqfAzKVGeD3lgYG3cSIJPWKaLqTf//s5Jsf8pfQtNTMd0fJj2/tOm8GEqG9
 f0SS5hfzufyf87+Ddg5wYE5teP2lT6V5vlrnDj1CnyY3ncn+pBjAWkEuKDyNLvXQi2NfZWeS/XL
 78Vsm6p5VO0XAQ19clVDmcnnrBf3JEjg==
X-Received: by 2002:adf:fa52:0:b0:33d:a1c4:9c63 with SMTP id
 y18-20020adffa52000000b0033da1c49c63mr9682915wrr.49.1710778588038; 
 Mon, 18 Mar 2024 09:16:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExwsDV6retvT4AXi9Q/totjrophQkvzqZehNJ2HPcgGFLls82e7hufFZpHU+M79ypG1uVeVQ==
X-Received: by 2002:adf:fa52:0:b0:33d:a1c4:9c63 with SMTP id
 y18-20020adffa52000000b0033da1c49c63mr9682881wrr.49.1710778587534; 
 Mon, 18 Mar 2024 09:16:27 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 bv16-20020a0560001f1000b00341798ba0a8sm1892563wrb.87.2024.03.18.09.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:16:25 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:16:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 15/24] smbios: handle errors consistently
Message-ID: <643e1c9ef9d90a6e80b82998d41c91302fef506b.1710778506.git.mst@redhat.com>
References: <cover.1710778506.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710778506.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Igor Mammedov <imammedo@redhat.com>

Current code uses mix of error_report()+exit(1)
and error_setg() to handle errors.
Use newer error_setg() everywhere, beside consistency
it will allow to detect error condition without killing
QEMU and attempt switch-over to SMBIOS3.x tables/entrypoint
in follow up patch.

while at it, clear smbios_tables pointer after freeing.
that will avoid double free if smbios_get_tables() is called
multiple times.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Message-Id: <20240314152302.2324164-13-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/firmware/smbios.h |  4 ++--
 hw/i386/fw_cfg.c             |  3 ++-
 hw/smbios/smbios.c           | 34 ++++++++++++++++++++++------------
 hw/smbios/smbios_legacy.c    | 22 ++++++++++++++--------
 4 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index ccc51e72f5..d4b91d5a14 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -326,7 +326,7 @@ struct smbios_type_127 {
     struct smbios_structure_header header;
 } QEMU_PACKED;
 
-void smbios_validate_table(void);
+bool smbios_validate_table(Error **errp);
 void smbios_add_usr_blob_size(size_t size);
 void smbios_entry_add(QemuOpts *opts, Error **errp);
 void smbios_set_cpuid(uint32_t version, uint32_t features);
@@ -334,7 +334,7 @@ void smbios_set_defaults(const char *manufacturer, const char *product,
                          const char *version,
                          bool uuid_encoded, SmbiosEntryPointType ep_type);
 void smbios_set_default_processor_family(uint16_t processor_family);
-uint8_t *smbios_get_table_legacy(size_t *length);
+uint8_t *smbios_get_table_legacy(size_t *length, Error **errp);
 void smbios_get_tables(MachineState *ms,
                        const struct smbios_phys_mem_area *mem_array,
                        const unsigned int mem_array_size,
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index d1281066f4..e387bf50d0 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -71,7 +71,8 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
     smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
 
     if (pcmc->smbios_legacy_mode) {
-        smbios_tables = smbios_get_table_legacy(&smbios_tables_len);
+        smbios_tables = smbios_get_table_legacy(&smbios_tables_len,
+                                                &error_fatal);
         fw_cfg_add_bytes(fw_cfg, FW_CFG_SMBIOS_ENTRIES,
                          smbios_tables, smbios_tables_len);
         return;
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 242106fd87..f7ca7d77e3 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -19,7 +19,6 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/config-file.h"
-#include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "sysemu/sysemu.h"
@@ -511,23 +510,25 @@ opts_init(smbios_register_config);
  */
 #define SMBIOS_21_MAX_TABLES_LEN 0xffff
 
-static void smbios_check_type4_count(uint32_t expected_t4_count)
+static bool smbios_check_type4_count(uint32_t expected_t4_count, Error **errp)
 {
     if (smbios_type4_count && smbios_type4_count != expected_t4_count) {
-        error_report("Expected %d SMBIOS Type 4 tables, got %d instead",
-                     expected_t4_count, smbios_type4_count);
-        exit(1);
+        error_setg(errp, "Expected %d SMBIOS Type 4 tables, got %d instead",
+                   expected_t4_count, smbios_type4_count);
+        return false;
     }
+    return true;
 }
 
-void smbios_validate_table(void)
+bool smbios_validate_table(Error **errp)
 {
     if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_32 &&
         smbios_tables_len > SMBIOS_21_MAX_TABLES_LEN) {
-        error_report("SMBIOS 2.1 table length %zu exceeds %d",
-                     smbios_tables_len, SMBIOS_21_MAX_TABLES_LEN);
-        exit(1);
+        error_setg(errp, "SMBIOS 2.1 table length %zu exceeds %d",
+                   smbios_tables_len, SMBIOS_21_MAX_TABLES_LEN);
+        return false;
     }
+    return true;
 }
 
 bool smbios_skip_table(uint8_t type, bool required_table)
@@ -1151,15 +1152,18 @@ void smbios_get_tables(MachineState *ms,
     smbios_build_type_41_table(errp);
     smbios_build_type_127_table();
 
-    smbios_check_type4_count(ms->smp.sockets);
-    smbios_validate_table();
+    if (!smbios_check_type4_count(ms->smp.sockets, errp)) {
+        goto err_exit;
+    }
+    if (!smbios_validate_table(errp)) {
+        goto err_exit;
+    }
     smbios_entry_point_setup();
 
     /* return tables blob and entry point (anchor), and their sizes */
     *tables = smbios_tables;
     *tables_len = smbios_tables_len;
     *anchor = (uint8_t *)&ep;
-
     /* calculate length based on anchor string */
     if (!strncmp((char *)&ep, "_SM_", 4)) {
         *anchor_len = sizeof(struct smbios_21_entry_point);
@@ -1168,6 +1172,12 @@ void smbios_get_tables(MachineState *ms,
     } else {
         abort();
     }
+
+    return;
+err_exit:
+    g_free(smbios_tables);
+    smbios_tables = NULL;
+    return;
 }
 
 static void save_opt(const char **dest, QemuOpts *opts, const char *name)
diff --git a/hw/smbios/smbios_legacy.c b/hw/smbios/smbios_legacy.c
index 21f143e738..a6544bf55a 100644
--- a/hw/smbios/smbios_legacy.c
+++ b/hw/smbios/smbios_legacy.c
@@ -19,7 +19,7 @@
 #include "qemu/bswap.h"
 #include "hw/firmware/smbios.h"
 #include "sysemu/sysemu.h"
-#include "qemu/error-report.h"
+#include "qapi/error.h"
 
 struct smbios_header {
     uint16_t length;
@@ -128,7 +128,7 @@ static void smbios_build_type_1_fields(void)
     }
 }
 
-uint8_t *smbios_get_table_legacy(size_t *length)
+uint8_t *smbios_get_table_legacy(size_t *length, Error **errp)
 {
     int i;
     size_t usr_offset;
@@ -136,15 +136,15 @@ uint8_t *smbios_get_table_legacy(size_t *length)
     /* complain if fields were given for types > 1 */
     if (find_next_bit(smbios_have_fields_bitmap,
                       SMBIOS_MAX_TYPE + 1, 2) < SMBIOS_MAX_TYPE + 1) {
-        error_report("can't process fields for smbios "
+        error_setg(errp, "can't process fields for smbios "
                      "types > 1 on machine versions < 2.1!");
-        exit(1);
+        goto err_exit;
     }
 
     if (test_bit(4, smbios_have_binfile_bitmap)) {
-        error_report("can't process table for smbios "
-                     "type 4 on machine versions < 2.1!");
-        exit(1);
+        error_setg(errp, "can't process table for smbios "
+                   "type 4 on machine versions < 2.1!");
+        goto err_exit;
     }
 
     g_free(smbios_entries);
@@ -173,7 +173,13 @@ uint8_t *smbios_get_table_legacy(size_t *length)
 
     smbios_build_type_0_fields();
     smbios_build_type_1_fields();
-    smbios_validate_table();
+    if (!smbios_validate_table(errp)) {
+        goto err_exit;
+    }
+
     *length = smbios_entries_len;
     return smbios_entries;
+err_exit:
+    g_free(smbios_entries);
+    return NULL;
 }
-- 
MST


