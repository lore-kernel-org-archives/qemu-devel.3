Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A3FC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFex-0007RY-4P; Mon, 18 Mar 2024 12:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFev-0007Pn-OR
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFes-0004gX-M1
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uc/CeWRDvT/TFblRTj0MYAUNkQhIh6oufOKqKBoDnoc=;
 b=Uj9TjfDBMsYJ9pQFRXh3H4Xf+C6JQd0RC81OouQGwy7jgTkWA7nr59B+qzOxGarMXDeFDG
 IME7DaK+/EAtXXQB/iIFVRfAif4l5rll6888ncjlE6NNdz+3Eeat8E/4v1GldAW4JNjEIE
 mAtq9zJpOPsSC+RPJKoXCBxdC1KT6qM=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-Go5CynVXOdmWlA5TycfM6Q-1; Mon, 18 Mar 2024 12:16:15 -0400
X-MC-Unique: Go5CynVXOdmWlA5TycfM6Q-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-4d425addd29so3653145e0c.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778574; x=1711383374;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uc/CeWRDvT/TFblRTj0MYAUNkQhIh6oufOKqKBoDnoc=;
 b=irKpIB393oVQS8wXjHQhs4JX3afdDK1GiWyixcY6e9Z3Qf/ts8zUOYoEGONqihn5yZ
 C17JJ/wCrUpUoEX0JoAu1gLPgtnwMTdG2sCAvlz7j4/kLtdjDxY3yfzxifv41RxTQU5t
 Snq64p6dzotOb2zT2moHlqd4DOXMIjtOC2GqU+Ni79wzqx4fpeytIVWx7nELqKl3hNKm
 85OBObxo+AQ0Lw8FFLpLDKzXI4DRU/x1ghycjnhhhDsHtvmlIjuqOJK38of2YMHIlx5M
 J3biLb2e4PjdtVLp7gIB/MW95EEcRCfyrDa77gE0GMRl1MjglAJzluIxMqXuZYJOnJXf
 7IhQ==
X-Gm-Message-State: AOJu0Yy/jgdQYwakFpuycJUpBdCIDSnI0RjrzG+ASYtmAgDOJNEpzVni
 FVYY94s8z7lvosacC3XQifhEAiS1EKOL5NHzAraR4+MNR9v7pbr6OxO2FlzXRRPH4jr3q69Wf1S
 s6N2KlhlzZKf2iRYa3WaJJV8d+59x6AtJfi/C0gYBFXAaC5RAqOp08MPa9KIB2/y9W58sRxHNjb
 xIKTWf+8xohwDvsvAlGCeHRY5f78s0ag==
X-Received: by 2002:a05:6122:984:b0:4b9:e8bd:3b2 with SMTP id
 g4-20020a056122098400b004b9e8bd03b2mr115579vkd.2.1710778572915; 
 Mon, 18 Mar 2024 09:16:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETP5FEgOUGFTFcQyI0HbOtCrOPlBmF9GhKeAAjmWaTleBFtXv6KRKeK0GeSbtKBvpFjmWU9g==
X-Received: by 2002:a05:6122:984:b0:4b9:e8bd:3b2 with SMTP id
 g4-20020a056122098400b004b9e8bd03b2mr115371vkd.2.1710778571091; 
 Mon, 18 Mar 2024 09:16:11 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 p5-20020ac5cca5000000b004d33a329719sm1104519vkm.38.2024.03.18.09.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:16:09 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:16:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 11/24] smbios: don't check type4 structures in legacy mode
Message-ID: <9cd7fd69cfad9180e22b9adb728fc7b596b4bc1e.1710778506.git.mst@redhat.com>
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

legacy mode doesn't support structures of type 2 and more,
and CLI has a check for '-smbios type' option, however it's
still possible to sneak in type4 as a blob with '-smbios file'
option. However doing the later makes SMBIOS tables broken
since SeaBIOS doesn't expect that.

Rather than trying to add support for type4 to legacy code
(both QEMU and SeaBIOS), simplify smbios_get_table_legacy()
by dropping not relevant check in legacy code and error out
on type4 blob.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Message-Id: <20240314152302.2324164-9-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/firmware/smbios.h |  2 +-
 hw/i386/fw_cfg.c             |  3 +--
 hw/smbios/smbios.c           | 18 ++++++++++++++----
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index 7b42e7b4ac..0f0dca8f83 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -313,7 +313,7 @@ void smbios_set_defaults(const char *manufacturer, const char *product,
                          const char *version,
                          bool uuid_encoded, SmbiosEntryPointType ep_type);
 void smbios_set_default_processor_family(uint16_t processor_family);
-uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length);
+uint8_t *smbios_get_table_legacy(size_t *length);
 void smbios_get_tables(MachineState *ms,
                        const struct smbios_phys_mem_area *mem_array,
                        const unsigned int mem_array_size,
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index c1e9c0fd9c..d1281066f4 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -71,8 +71,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
     smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
 
     if (pcmc->smbios_legacy_mode) {
-        smbios_tables = smbios_get_table_legacy(ms->smp.cpus,
-                                                &smbios_tables_len);
+        smbios_tables = smbios_get_table_legacy(&smbios_tables_len);
         fw_cfg_add_bytes(fw_cfg, FW_CFG_SMBIOS_ENTRIES,
                          smbios_tables, smbios_tables_len);
         return;
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index aab4ffb4cb..30196d2911 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -545,14 +545,17 @@ opts_init(smbios_register_config);
  */
 #define SMBIOS_21_MAX_TABLES_LEN 0xffff
 
-static void smbios_validate_table(uint32_t expected_t4_count)
+static void smbios_check_type4_count(uint32_t expected_t4_count)
 {
     if (smbios_type4_count && smbios_type4_count != expected_t4_count) {
         error_report("Expected %d SMBIOS Type 4 tables, got %d instead",
                      expected_t4_count, smbios_type4_count);
         exit(1);
     }
+}
 
+static void smbios_validate_table(void)
+{
     if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_32 &&
         smbios_tables_len > SMBIOS_21_MAX_TABLES_LEN) {
         error_report("SMBIOS 2.1 table length %zu exceeds %d",
@@ -637,7 +640,7 @@ static void smbios_build_type_1_fields(void)
     }
 }
 
-uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length)
+uint8_t *smbios_get_table_legacy(size_t *length)
 {
     int i;
     size_t usr_offset;
@@ -650,6 +653,12 @@ uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length)
         exit(1);
     }
 
+    if (test_bit(4, have_binfile_bitmap)) {
+        error_report("can't process table for smbios "
+                     "type 4 on machine versions < 2.1!");
+        exit(1);
+    }
+
     g_free(smbios_entries);
     smbios_entries_len = sizeof(uint16_t);
     smbios_entries = g_malloc0(smbios_entries_len);
@@ -676,7 +685,7 @@ uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length)
 
     smbios_build_type_0_fields();
     smbios_build_type_1_fields();
-    smbios_validate_table(expected_t4_count);
+    smbios_validate_table();
     *length = smbios_entries_len;
     return smbios_entries;
 }
@@ -1304,7 +1313,8 @@ void smbios_get_tables(MachineState *ms,
     smbios_build_type_41_table(errp);
     smbios_build_type_127_table();
 
-    smbios_validate_table(ms->smp.sockets);
+    smbios_check_type4_count(ms->smp.sockets);
+    smbios_validate_table();
     smbios_entry_point_setup();
 
     /* return tables blob and entry point (anchor), and their sizes */
-- 
MST


