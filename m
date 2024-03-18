Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7B2C54E6A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFf1-0007UJ-AV; Mon, 18 Mar 2024 12:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFex-0007Rp-H0
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFet-0004eM-Kv
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=odPqgcRarP/qfco3bEKoj8jaqMYx3BuQ+fTJjBu4E9k=;
 b=ZcHcnlET0wKq7sMmUIWwyAEGyjp5xIZdMGLgjbU/BIcCvf5kb3mkIFjhV9ImLT4PHVj91Z
 geLjh0C0DmOngnBGfU9lSO+8EIjzA/3PLvfbuZups7P8NXvpixWWUGJ7wev7wuColx78C9
 dZNsqtuCgNRBAQh+54yfTPeh+W/96/I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-eY0ZZT8sOlSJQuCmxhvpjA-1; Mon, 18 Mar 2024 12:16:04 -0400
X-MC-Unique: eY0ZZT8sOlSJQuCmxhvpjA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41413c99712so3684115e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778562; x=1711383362;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=odPqgcRarP/qfco3bEKoj8jaqMYx3BuQ+fTJjBu4E9k=;
 b=ft+A7f5bnVf0kS+y4TInAf/chicp6+1aU6pbPqri6PSEeQDg2P3wNcc9Cbsj0hSRbQ
 iow7o8PhyPfRQvBe3CuItO1ZmgMH7bpWQrBa5tS8KqETQy9noGibbEroBZQgrJAOIWf9
 T1fu+APT8EOt+ct0iSYi+1AAomS4A85VKSKO7gR3GYzS2niKGUrsztGeapV3WZiDCyCL
 VEVre1n34Z3fcC6D0diKd8a/iIjhaRuHSabbc47+EF5RELWX9HwLfL+vZ4TAxS/0ho+Z
 po/w6wb9r/3BkzCHNBVbXF5m+hm5k1lxJJWFRAb9sSDogP+8EgZmMDJITefpyn+ulWL1
 jN0A==
X-Gm-Message-State: AOJu0Yy8DtEKymqwKBHYSXYKeExpr7M37aIiiFITpWF8XxBT71upersx
 qydKXzOGgNWYMGVfPT8NX7Sa7w8e2TmU7VfnoxVHleSeQufYO5Tyd0e3WvJ3xpH1i4+6WPwv/V5
 OwplFWi0OPliHN3MFPaaQjqaBidvqb1k4Ay5MIqCUvqFSmayPwUCInZyNxCjV6AZjJIATEOk3MJ
 0PoSnv1LeY5gNUc7WcnSc3BwFdSL8GdQ==
X-Received: by 2002:a05:600c:524c:b0:414:cd1:e46d with SMTP id
 fc12-20020a05600c524c00b004140cd1e46dmr3307387wmb.23.1710778562380; 
 Mon, 18 Mar 2024 09:16:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYtH6+pcelhFS1te3Ktfz2rupk7YbN8zWHT/vn59oCUwf/m7Y9T0HMXw/o3XSv/GWfeQVeJQ==
X-Received: by 2002:a05:600c:524c:b0:414:cd1:e46d with SMTP id
 fc12-20020a05600c524c00b004140cd1e46dmr3307344wmb.23.1710778561762; 
 Mon, 18 Mar 2024 09:16:01 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 d6-20020a05600c34c600b004140837a0d4sm8222211wmq.3.2024.03.18.09.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:16:01 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:15:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PULL 09/24] smbios: get rid of smbios_legacy global
Message-ID: <b3854ce8a77f14b40a59c4fcef234f4af04504d5.1710778506.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

clean up smbios_set_defaults() which is reused by legacy
and non legacy machines from being aware of 'legacy' notion
and need to turn it off. And push legacy handling up to
PC machine code where it's relevant.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Message-Id: <20240314152302.2324164-7-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/firmware/smbios.h |  2 +-
 hw/arm/virt.c                |  2 +-
 hw/i386/fw_cfg.c             |  7 ++++---
 hw/loongarch/virt.c          |  2 +-
 hw/riscv/virt.c              |  2 +-
 hw/smbios/smbios.c           | 35 +++++++++++++++--------------------
 6 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index 36744b6cc9..7b42e7b4ac 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -310,7 +310,7 @@ struct smbios_type_127 {
 void smbios_entry_add(QemuOpts *opts, Error **errp);
 void smbios_set_cpuid(uint32_t version, uint32_t features);
 void smbios_set_defaults(const char *manufacturer, const char *product,
-                         const char *version, bool legacy_mode,
+                         const char *version,
                          bool uuid_encoded, SmbiosEntryPointType ep_type);
 void smbios_set_default_processor_family(uint16_t processor_family);
 uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e5cd935232..b634c908a7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1650,7 +1650,7 @@ static void virt_build_smbios(VirtMachineState *vms)
     }
 
     smbios_set_defaults("QEMU", product,
-                        vmc->smbios_old_sys_ver ? "1.0" : mc->name, false,
+                        vmc->smbios_old_sys_ver ? "1.0" : mc->name,
                         true, SMBIOS_ENTRY_POINT_TYPE_64);
 
     /* build the array of physical mem area from base_memmap */
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index fcb4fb0769..c1e9c0fd9c 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -63,15 +63,16 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
     if (pcmc->smbios_defaults) {
         /* These values are guest ABI, do not change */
         smbios_set_defaults("QEMU", mc->desc, mc->name,
-                            pcmc->smbios_legacy_mode, pcmc->smbios_uuid_encoded,
+                            pcmc->smbios_uuid_encoded,
                             pcms->smbios_entry_point_type);
     }
 
     /* tell smbios about cpuid version and features */
     smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
 
-    smbios_tables = smbios_get_table_legacy(ms->smp.cpus, &smbios_tables_len);
-    if (smbios_tables) {
+    if (pcmc->smbios_legacy_mode) {
+        smbios_tables = smbios_get_table_legacy(ms->smp.cpus,
+                                                &smbios_tables_len);
         fw_cfg_add_bytes(fw_cfg, FW_CFG_SMBIOS_ENTRIES,
                          smbios_tables, smbios_tables_len);
         return;
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index efce112310..53bfdcee61 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -355,7 +355,7 @@ static void virt_build_smbios(LoongArchMachineState *lams)
         return;
     }
 
-    smbios_set_defaults("QEMU", product, mc->name, false,
+    smbios_set_defaults("QEMU", product, mc->name,
                         true, SMBIOS_ENTRY_POINT_TYPE_64);
 
     smbios_get_tables(ms, NULL, 0, &smbios_tables, &smbios_tables_len,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a094af97c3..535fd047ba 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1275,7 +1275,7 @@ static void virt_build_smbios(RISCVVirtState *s)
         product = "KVM Virtual Machine";
     }
 
-    smbios_set_defaults("QEMU", product, mc->name, false,
+    smbios_set_defaults("QEMU", product, mc->name,
                         true, SMBIOS_ENTRY_POINT_TYPE_64);
 
     if (riscv_is_32bit(&s->soc[0])) {
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 003c539d76..9f9087601c 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -54,7 +54,6 @@ struct smbios_table {
 
 static uint8_t *smbios_entries;
 static size_t smbios_entries_len;
-static bool smbios_legacy = true;
 static bool smbios_uuid_encoded = true;
 /* end: legacy structures & constants for <= 2.0 machines */
 
@@ -633,9 +632,16 @@ static void smbios_build_type_1_fields(void)
 
 uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length)
 {
-    if (!smbios_legacy) {
-        *length = 0;
-        return NULL;
+    /* drop unwanted version of command-line file blob(s) */
+    g_free(smbios_tables);
+    smbios_tables = NULL;
+
+    /* also complain if fields were given for types > 1 */
+    if (find_next_bit(have_fields_bitmap,
+                      SMBIOS_MAX_TYPE + 1, 2) < SMBIOS_MAX_TYPE + 1) {
+        error_report("can't process fields for smbios "
+                     "types > 1 on machine versions < 2.1!");
+        exit(1);
     }
 
     if (!smbios_immutable) {
@@ -1129,28 +1135,13 @@ void smbios_set_default_processor_family(uint16_t processor_family)
 }
 
 void smbios_set_defaults(const char *manufacturer, const char *product,
-                         const char *version, bool legacy_mode,
+                         const char *version,
                          bool uuid_encoded, SmbiosEntryPointType ep_type)
 {
     smbios_have_defaults = true;
-    smbios_legacy = legacy_mode;
     smbios_uuid_encoded = uuid_encoded;
     smbios_ep_type = ep_type;
 
-    /* drop unwanted version of command-line file blob(s) */
-    if (smbios_legacy) {
-        g_free(smbios_tables);
-        /* in legacy mode, also complain if fields were given for types > 1 */
-        if (find_next_bit(have_fields_bitmap,
-                          SMBIOS_MAX_TYPE+1, 2) < SMBIOS_MAX_TYPE+1) {
-            error_report("can't process fields for smbios "
-                         "types > 1 on machine versions < 2.1!");
-            exit(1);
-        }
-    } else {
-        g_free(smbios_entries);
-    }
-
     SMBIOS_SET_DEFAULT(type1.manufacturer, manufacturer);
     SMBIOS_SET_DEFAULT(type1.product, product);
     SMBIOS_SET_DEFAULT(type1.version, version);
@@ -1226,6 +1217,10 @@ void smbios_get_tables(MachineState *ms,
 {
     unsigned i, dimm_cnt, offset;
 
+    /* drop unwanted (legacy) version of command-line file blob(s) */
+    g_free(smbios_entries);
+    smbios_entries = NULL;
+
     if (!smbios_immutable) {
         smbios_build_type_0_table();
         smbios_build_type_1_table();
-- 
MST


