Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7A5C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPyr-00084v-K7; Wed, 27 Mar 2024 05:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPyX-0007tn-Ls
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:53:47 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPyV-00075f-P7
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:53:41 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4149571d4b6so2256515e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711533217; x=1712138017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXPzkwsH5pTrUa0Pgjl4p3bDfrtQHwfhdOq2M84tSsU=;
 b=Jio39v6NHSIQ9dt9tROwMbuiHO3RJiOsPuFLM2NVWbplLlCTfIQmf2Ooqpzu4haoA5
 oXZzduslO2ZSEPnvm+/ULIESwYGCo+0vTXFoDc4tnx80ybzR7WKqNRyWRnYDPr0JSj+H
 aOxFaHGC7Gz63sWjmiO6vrOjBaVzqoCv8e2U19RnxkIB6theN2acixNaXtH/sTeWTSof
 gfhayn3CjxpvVLqdjj2k+cYwOhM3kTHIjUVGbFd387It0MuLOBXSg4kyFf8JzeggS62e
 Qq9Puk1KR9+y1tatnpRpSV5iadSOmwk7TK+Z1x84MGTKCs5DQ4//81QYgoxxj8y7j28Y
 oG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711533217; x=1712138017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zXPzkwsH5pTrUa0Pgjl4p3bDfrtQHwfhdOq2M84tSsU=;
 b=NiAdrqq9c9eiLlrNKhfzKKGeGCdSlXKvn60rBgnuLFwjgvceS/Q8DpZ9L4p3wGaPEU
 fSWPSNwY7KH2eeIkQZ3WwRRNnfPEt9bhRwJRNN1ZmIpzBcQo8MEkm9Ik0JDzpZEuNTul
 jgALHK37tHp4mG9pmnIfDR+Tg1UBjEPyc0/TgcwW0JRc1/cxprTbsWp7lq4s2CwEHWoK
 eWRkUi11oftWSn0Ml/OkM4GuZEV1IwB4vAEzgp2OamKBNXaNQvez/n5hqDO8hL3o4X7n
 xBULCPtIaBSzzW9xus4dRQm/TjgCd/P3DqAoEIfIUupS5YNs6PgLHq71AH/QN/ycBkuu
 JnXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX01RRcceKuge0R5Qyetb3KHel3mH8pBo6nN0r6OB0IWJFPiJLnm13FVPQl3FNrGHlGj2CwQ9e7tfE/3o5yu1yWp7jkw6Q=
X-Gm-Message-State: AOJu0Yy9p+k6T6+omtaMckHE11q23Hg9S342tc/p2oy3EiA3MTtEj6+Y
 6D4qygB/DwUbE1Nm+4LKnAVJjHrOm49tV1Vhyip9UwC7D6uGtHRTtkKXyhikANY=
X-Google-Smtp-Source: AGHT+IEaOJx/JFOukmJ9mOgUY91CHYo+Y9oLDQ6ewVtaYGLOtTve7MLMmwbQP5ZoFvz7H2+Mz/UuTQ==
X-Received: by 2002:a05:600c:6d8:b0:413:3110:2d06 with SMTP id
 b24-20020a05600c06d800b0041331102d06mr1873900wmn.16.1711533217730; 
 Wed, 27 Mar 2024 02:53:37 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 fa21-20020a05600c519500b00412a31d2e2asm1604680wmb.32.2024.03.27.02.53.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Mar 2024 02:53:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Zhao Liu <zhao1.liu@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH-for-9.1 v2 21/21] hw/i386/pc: Replace
 PCMachineClass::acpi_data_size by PC_ACPI_DATA_SIZE
Date: Wed, 27 Mar 2024 10:51:23 +0100
Message-ID: <20240327095124.73639-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240327095124.73639-1-philmd@linaro.org>
References: <20240327095124.73639-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

PCMachineClass::acpi_data_size was only used by the pc-i440fx-2.0
machine, which got removed. Since it is constant, replace the class
field by a definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240305134221.30924-19-philmd@linaro.org>
---
 include/hw/i386/pc.h |  4 ----
 hw/i386/pc.c         | 19 ++++++++++++-------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 96ccb4583f..0ad971782c 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -74,9 +74,6 @@ typedef struct PCMachineState {
  *
  * Compat fields:
  *
- * @acpi_data_size: Size of the chunk of memory at the top of RAM
- *                  for the BIOS ACPI tables and other BIOS
- *                  datastructures.
  * @gigabyte_align: Make sure that guest addresses aligned at
  *                  1Gbyte boundaries get mapped to host
  *                  addresses aligned at 1Gbyte boundaries. This
@@ -100,7 +97,6 @@ struct PCMachineClass {
 
     /* ACPI compat: */
     bool has_acpi_build;
-    unsigned acpi_data_size;
     int pci_root_uid;
 
     /* SMBIOS compat: */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 27e04c52f6..f01a30d3d9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -256,6 +256,16 @@ GlobalProperty pc_compat_2_4[] = {
 };
 const size_t pc_compat_2_4_len = G_N_ELEMENTS(pc_compat_2_4);
 
+/*
+ * @PC_ACPI_DATA_SIZE:
+ * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
+ * and other BIOS datastructures.
+ *
+ * BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K
+ * reported to be used at the moment, 32K should be enough for a while.
+ */
+#define PC_ACPI_DATA_SIZE (0x20000 + 0x8000)
+
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
 {
     GSIState *s;
@@ -634,8 +644,7 @@ void xen_load_linux(PCMachineState *pcms)
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     rom_set_fw(fw_cfg);
 
-    x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
-                   pcmc->pvh_enabled);
+    x86_load_linux(x86ms, fw_cfg, PC_ACPI_DATA_SIZE, pcmc->pvh_enabled);
     for (i = 0; i < nb_option_roms; i++) {
         assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
                !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
@@ -969,8 +978,7 @@ void pc_memory_init(PCMachineState *pcms,
     }
 
     if (linux_boot) {
-        x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
-                       pcmc->pvh_enabled);
+        x86_load_linux(x86ms, fw_cfg, PC_ACPI_DATA_SIZE, pcmc->pvh_enabled);
     }
 
     for (i = 0; i < nb_option_roms; i++) {
@@ -1722,9 +1730,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->gigabyte_align = true;
     pcmc->has_reserved_memory = true;
     pcmc->enforce_amd_1tb_hole = true;
-    /* BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K reported
-     * to be used at the moment, 32K should be enough for a while.  */
-    pcmc->acpi_data_size = 0x20000 + 0x8000;
     pcmc->pvh_enabled = true;
     pcmc->kvmclock_create_always = true;
     x86mc->apic_xrupt_override = true;
-- 
2.41.0


