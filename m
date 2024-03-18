Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5E5C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFew-0007Q3-9l; Mon, 18 Mar 2024 12:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFeu-0007N6-CH
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFes-0004e3-K7
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aoA2peaGF2qOzBoAWlslzkVrIFIZMqTVQz88w0hXmqE=;
 b=JEQ7IhyouN7f/87bZKy7qpm5Mv/GJJy2+GEorxvGE73FZoIkGR2dxLeHyPU5rQZpz0Sy6k
 0RwfZE4bQIFhsueqJp1l4XBpk66GV4c8T4m+grn+dfAzRdqlZONn0+nOca4DNi5kEN9zS0
 QgJWaVezp/j3ofXwYQD950hbBZ+U8Zs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-F6EbXTIOMlGjZUi0GwqVbA-1; Mon, 18 Mar 2024 12:16:02 -0400
X-MC-Unique: F6EbXTIOMlGjZUi0GwqVbA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3416632aeffso851267f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778561; x=1711383361;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aoA2peaGF2qOzBoAWlslzkVrIFIZMqTVQz88w0hXmqE=;
 b=shovFH/7OWEW06j+cbITlTgWKi3MZNWr2kWpDP7j824LpWsx9dKuWRGBvLR/+7gWZ6
 Or3ew8laFyGWsaG1xNduTAe+piY3aZflx+CF9LOOID+jeyhxhX6WORiq/4oPNZtE69I5
 kgCkeYwSS3FV/SU6JirApx/LQ+FCeUpX4lVq/CLgK722wYUGT7Bb6dJW9BF1yscudF5N
 +SncxpU1L6O1Ek2nq9spBrmbVA4AdErbQF656MmlWeeaQ1yXz0kF1SOBUyJFf+trzyN4
 /jgpfVsOHGSxnDcR/4+n5YrbCRIAqnvIbW12TdFH9ulsnjUbiG1YAenQFeIP3LJgCisN
 BX8Q==
X-Gm-Message-State: AOJu0YzJI/HkTS1oYB72cMjngkmxtkdSft+pgL9fFMeRFAQDKKfiP52X
 wglzerNZBzlSI6kWho8izXAGKBHXIWKnW6ik6X+jTUSaLtLq1tJc6TStLUGVWBo9CkhM8YQPpII
 za0Bsraj+tQyJekwVir2tCcA0t7kkA9ApqAVozUYfMOufpSKP82S4lFojOntMNbKmgNhGY3xHRz
 xKNq+y4L2mtmwQKdtqEnoDtGr4FxW9QQ==
X-Received: by 2002:a5d:42cf:0:b0:33d:4ee2:883d with SMTP id
 t15-20020a5d42cf000000b0033d4ee2883dmr8354328wrr.39.1710778558063; 
 Mon, 18 Mar 2024 09:15:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLmuJjSB+Q1fhj0qTUO1mcdtqJ23AZiChAccQKv0I7rQuMy5PokGFJ0WFtLCO++RNmVnhhDQ==
X-Received: by 2002:a5d:42cf:0:b0:33d:4ee2:883d with SMTP id
 t15-20020a5d42cf000000b0033d4ee2883dmr8354298wrr.39.1710778557454; 
 Mon, 18 Mar 2024 09:15:57 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 a26-20020a5d457a000000b0033e7e9c8657sm10137260wrc.45.2024.03.18.09.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:15:56 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:15:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 08/24] smbios: get rid of smbios_smp_sockets global
Message-ID: <e94e0a833b9d909e239829a2030dbb6e7c2db01d.1710778506.git.mst@redhat.com>
References: <cover.1710778506.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710778506.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

it makes smbios_validate_table() independent from
smbios_smp_sockets global, which in turn lets
smbios_get_tables() avoid using not related legacy code.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Message-Id: <20240314152302.2324164-6-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/firmware/smbios.h |  2 +-
 hw/i386/fw_cfg.c             |  2 +-
 hw/smbios/smbios.c           | 22 +++++++++-------------
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index c21b8d3285..36744b6cc9 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -313,7 +313,7 @@ void smbios_set_defaults(const char *manufacturer, const char *product,
                          const char *version, bool legacy_mode,
                          bool uuid_encoded, SmbiosEntryPointType ep_type);
 void smbios_set_default_processor_family(uint16_t processor_family);
-uint8_t *smbios_get_table_legacy(MachineState *ms, size_t *length);
+uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length);
 void smbios_get_tables(MachineState *ms,
                        const struct smbios_phys_mem_area *mem_array,
                        const unsigned int mem_array_size,
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index a635234e68..fcb4fb0769 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -70,7 +70,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
     /* tell smbios about cpuid version and features */
     smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
 
-    smbios_tables = smbios_get_table_legacy(ms, &smbios_tables_len);
+    smbios_tables = smbios_get_table_legacy(ms->smp.cpus, &smbios_tables_len);
     if (smbios_tables) {
         fw_cfg_add_bytes(fw_cfg, FW_CFG_SMBIOS_ENTRIES,
                          smbios_tables, smbios_tables_len);
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index a1741a64a6..003c539d76 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -70,7 +70,7 @@ static SmbiosEntryPoint ep;
 static int smbios_type4_count = 0;
 static bool smbios_immutable;
 static bool smbios_have_defaults;
-static uint32_t smbios_cpuid_version, smbios_cpuid_features, smbios_smp_sockets;
+static uint32_t smbios_cpuid_version, smbios_cpuid_features;
 
 static DECLARE_BITMAP(have_binfile_bitmap, SMBIOS_MAX_TYPE+1);
 static DECLARE_BITMAP(have_fields_bitmap, SMBIOS_MAX_TYPE+1);
@@ -539,14 +539,11 @@ opts_init(smbios_register_config);
  */
 #define SMBIOS_21_MAX_TABLES_LEN 0xffff
 
-static void smbios_validate_table(MachineState *ms)
+static void smbios_validate_table(uint32_t expected_t4_count)
 {
-    uint32_t expect_t4_count = smbios_legacy ?
-                                        ms->smp.cpus : smbios_smp_sockets;
-
-    if (smbios_type4_count && smbios_type4_count != expect_t4_count) {
+    if (smbios_type4_count && smbios_type4_count != expected_t4_count) {
         error_report("Expected %d SMBIOS Type 4 tables, got %d instead",
-                     expect_t4_count, smbios_type4_count);
+                     expected_t4_count, smbios_type4_count);
         exit(1);
     }
 
@@ -634,7 +631,7 @@ static void smbios_build_type_1_fields(void)
     }
 }
 
-uint8_t *smbios_get_table_legacy(MachineState *ms, size_t *length)
+uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length)
 {
     if (!smbios_legacy) {
         *length = 0;
@@ -644,7 +641,7 @@ uint8_t *smbios_get_table_legacy(MachineState *ms, size_t *length)
     if (!smbios_immutable) {
         smbios_build_type_0_fields();
         smbios_build_type_1_fields();
-        smbios_validate_table(ms);
+        smbios_validate_table(expected_t4_count);
         smbios_immutable = true;
     }
     *length = smbios_entries_len;
@@ -1235,10 +1232,9 @@ void smbios_get_tables(MachineState *ms,
         smbios_build_type_2_table();
         smbios_build_type_3_table();
 
-        smbios_smp_sockets = ms->smp.sockets;
-        assert(smbios_smp_sockets >= 1);
+        assert(ms->smp.sockets >= 1);
 
-        for (i = 0; i < smbios_smp_sockets; i++) {
+        for (i = 0; i < ms->smp.sockets; i++) {
             smbios_build_type_4_table(ms, i);
         }
 
@@ -1284,7 +1280,7 @@ void smbios_get_tables(MachineState *ms,
         smbios_build_type_41_table(errp);
         smbios_build_type_127_table();
 
-        smbios_validate_table(ms);
+        smbios_validate_table(ms->smp.sockets);
         smbios_entry_point_setup();
         smbios_immutable = true;
     }
-- 
MST


