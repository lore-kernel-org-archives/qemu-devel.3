Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79541C27C7B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 07:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6XV-0004vi-2b; Mon, 17 Jun 2024 03:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6XS-0004fY-QM
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:12:26 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6XQ-0002II-Vz
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:12:26 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a6f7720e6e8so105240766b.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 00:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718608343; x=1719213143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AcGt/z0KhUKek0a1UeOAxUojkF/dPIFAWy9VNt68BA4=;
 b=PYsmlOtCRed4Zz4uClLAxuOklaENcNxEOsqveDfw05buerFRpJq/esP5J976ViPCn6
 e4k6fOi7MQeqN34V5Fhlr813EYM6fBi/3pvEUE8j1W0QZn//XTaZHnr3ly/AQ9zEx1xM
 E62t0iU8a8U0QdBgbf4AwheAF6uZZmmCIwUwDlwxMjvKLYogxYYpbb+1mY0Ku5o55Nij
 5YVLNjHKTrUQ2+PZsxVTaBtYOOYSV79Z1aYxWSgB3hb58rDsjtd4O71gM07TPgr19d1T
 DGmhdhdR6CQ5txbnIhzTvTh0S2guSSmNZcN8r5qiraqzjEHddxwEP3sW9+HKjRkSnUlF
 IelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718608343; x=1719213143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AcGt/z0KhUKek0a1UeOAxUojkF/dPIFAWy9VNt68BA4=;
 b=TFKMwQ2o/DT2Vd6dQSlyNqPi7wldFTQGEiQg4DuHuH4KawvDsND8Z8TzgLckhkTuI1
 HBCHo7f3oFdYjgYV0KTTKL3t4ujMULU4MyyU68Wg9//V/I5gD8Bk8/ABy+xkumZjqV0N
 rTkRY6HfrGV3BQJBKT9Nuwzmyy/g/nBvRce+5EY/tWdFuQIvu+/Mwdynq/aumbjvOSo+
 oDMHopa5Od98nV+FaiFi6s5ZV1hq+xpSZWbCI7GKUp8T1CMGrwLmKsCzI5dwE59RXW1p
 gkNDnw91e5yoZjrrPYRpDTlBiQzbJOXMimZcPPmMsyBKBuDd/aiOHBHLxTamtXmywgcU
 cdbw==
X-Gm-Message-State: AOJu0YyvwDRV1JQlYNEhmOe5y6aBqFEmHFogJOpI4aMxgjSAZPS9r2FE
 DP1Ous0dNALyVqo8LKTp+j0spHZJYbz/WRx4uuAdW+PeLwLjgjqo3NarVtAPxParlQua/BadK17
 omcs=
X-Google-Smtp-Source: AGHT+IESDWEdU6RHmOgLi59EembKraYBwGvrb1P2v1H8WHPOJGL99FG4Cie1lW5xz7egY0lN8dTCYw==
X-Received: by 2002:a17:906:c34b:b0:a6f:14b8:a017 with SMTP id
 a640c23a62f3a-a6f60de601emr709584266b.74.1718608342807; 
 Mon, 17 Jun 2024 00:12:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db5b3asm486909066b.52.2024.06.17.00.12.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jun 2024 00:12:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 11/23] hw/smbios: Remove 'uuid_encoded' argument from
 smbios_set_defaults()
Date: Mon, 17 Jun 2024 09:11:06 +0200
Message-ID: <20240617071118.60464-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240617071118.60464-1-philmd@linaro.org>
References: <20240617071118.60464-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

'uuid_encoded' is always true, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/firmware/smbios.h | 3 +--
 hw/arm/virt.c                | 3 +--
 hw/i386/fw_cfg.c             | 2 +-
 hw/loongarch/virt.c          | 2 +-
 hw/riscv/virt.c              | 2 +-
 hw/smbios/smbios.c           | 6 ++----
 6 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index 8d3fb2fb3b..f066ab7262 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -331,8 +331,7 @@ void smbios_add_usr_blob_size(size_t size);
 void smbios_entry_add(QemuOpts *opts, Error **errp);
 void smbios_set_cpuid(uint32_t version, uint32_t features);
 void smbios_set_defaults(const char *manufacturer, const char *product,
-                         const char *version,
-                         bool uuid_encoded);
+                         const char *version);
 void smbios_set_default_processor_family(uint16_t processor_family);
 uint8_t *smbios_get_table_legacy(size_t *length, Error **errp);
 void smbios_get_tables(MachineState *ms,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3c93c0c0a6..268b25e332 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1677,8 +1677,7 @@ static void virt_build_smbios(VirtMachineState *vms)
     }
 
     smbios_set_defaults("QEMU", product,
-                        vmc->smbios_old_sys_ver ? "1.0" : mc->name,
-                        true);
+                        vmc->smbios_old_sys_ver ? "1.0" : mc->name);
 
     /* build the array of physical mem area from base_memmap */
     mem_array.address = vms->memmap[VIRT_MEM].base;
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index f9e8af3bf5..7c43c325ef 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -63,7 +63,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
 
     if (pcmc->smbios_defaults) {
         /* These values are guest ABI, do not change */
-        smbios_set_defaults("QEMU", mc->desc, mc->name, true);
+        smbios_set_defaults("QEMU", mc->desc, mc->name);
     }
 
     /* tell smbios about cpuid version and features */
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 66cef201ab..b7ea17d5f3 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -556,7 +556,7 @@ static void virt_build_smbios(LoongArchVirtMachineState *lvms)
         return;
     }
 
-    smbios_set_defaults("QEMU", product, mc->name, true);
+    smbios_set_defaults("QEMU", product, mc->name);
 
     smbios_get_tables(ms, SMBIOS_ENTRY_POINT_TYPE_64,
                       NULL, 0,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 4fdb660525..5676d66d12 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1277,7 +1277,7 @@ static void virt_build_smbios(RISCVVirtState *s)
         product = "KVM Virtual Machine";
     }
 
-    smbios_set_defaults("QEMU", product, mc->name, true);
+    smbios_set_defaults("QEMU", product, mc->name);
 
     if (riscv_is_32bit(&s->soc[0])) {
         smbios_set_default_processor_family(0x200);
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index eed5787b15..8261eb716f 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -30,7 +30,7 @@
 #include "hw/pci/pci_device.h"
 #include "smbios_build.h"
 
-static bool smbios_uuid_encoded = true;
+static const bool smbios_uuid_encoded = true;
 /*
  * SMBIOS tables provided by user with '-smbios file=<foo>' option
  */
@@ -1017,11 +1017,9 @@ void smbios_set_default_processor_family(uint16_t processor_family)
 }
 
 void smbios_set_defaults(const char *manufacturer, const char *product,
-                         const char *version,
-                         bool uuid_encoded)
+                         const char *version)
 {
     smbios_have_defaults = true;
-    smbios_uuid_encoded = uuid_encoded;
 
     SMBIOS_SET_DEFAULT(smbios_type1.manufacturer, manufacturer);
     SMBIOS_SET_DEFAULT(smbios_type1.product, product);
-- 
2.41.0


