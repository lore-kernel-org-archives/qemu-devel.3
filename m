Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524F5C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 20:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0RMy-0000TA-6y; Thu, 03 Apr 2025 16:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RMv-0000Sm-5D
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:40:57 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RMt-00053m-Bv
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:40:56 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so1182100f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 13:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743712853; x=1744317653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wgBNy0vxL5goVE1RO7+eU01X51ted55h8TOUfbLYmNA=;
 b=H30ZVGJKBcaaq2FOoqIwv/af32jtCU0el+/5zMVoqK1CvVmSoOZ/rxZDV7qXe/HJwV
 uTDpOZbQgmgimhkgNUbwsDxbgaHYkbxjCwWmEtPfTk5JB0SCSht0SX9F8xH3t6CbW1bz
 Uh57RKKWHIs+y0LqtVuAa3cLYjVYb2x1BI2pT3mUpElwKgxKvLX5vmBkGIOQpdYkxY7H
 5inTP/9ZPyvKiNc8BhRwqR/796/vNZ7bePhMHPIfbcfdxqSVTg58inXEQnVs9poCUKeb
 ILlBUZAH9On7zsbXT0k0wKQqh+uvRduU8OqXP2C3Yo9eT6prVEWyjm1PdwguQC1SszAF
 Cn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743712853; x=1744317653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgBNy0vxL5goVE1RO7+eU01X51ted55h8TOUfbLYmNA=;
 b=o0BFs1+5VDD6RKBDZkGqQu5EnQtO8iDjvgRYuHcJIrmzSpx0tG8FxYDQF4FBqD/tC0
 xw7ttwlSM1CUi/bX7ttgRFm5cCXtmXUEgpL0a9g3Zd9yx+buqsrod7SaTV4unzi/H6Ic
 ADiDk292vz20ikuSTISl6w+EvsnqGscqko81oj7JbhUF8lNUbeOkD/iRuM5iEoiUHaJk
 w1MFrcy6pD5PE4b+rDWeIZ44T6jjiEx5lf8cN900ArXLNSM5X2Gjukkjky4v2cJruw+b
 wqNn+voyUEpJO0YyOLxIPdZBos6Smuv3KZlODpnoMAFS4Se1PnbHUErAqHXQw+R1onFj
 V0bg==
X-Gm-Message-State: AOJu0Yx9Z4wLmLlLp9qZzeB0pxUkOn1AMHPrBOCd8V02j/GlSmN6lf4G
 O4HDrV14KEc8n2F0GrMKCDR7Q+u07H9Qm5wi1lvILcApq9zy0MaWZkwPrt9/C73aJi91Y9U3ytq
 H
X-Gm-Gg: ASbGncuEDOgz0Qqz3VI3tekCzf0TPKTsgMAoRAYDRZOtUcknJk4qb+YNLiuNxBFc3qZ
 milSewcAQ/K7rU2c280mGa7t9pL1mp+mexoL0vgqJ7fd4C3Uq1a4lnXSngnk2V0nlcXWWfhq/Y+
 VCDRGlpLBF8wxIFAeYzQfTpDVuiHsQUIl3h9/r35Ops4ifATpMwOiH8A2AtAO+SknXFrLsZIvN9
 qhhyGaQEb98P2vWekNfF/Ut1DYgNv44UHkudbhsiTxM81qoIhKuW4iUeQPh4U54eDAaTgBAeyag
 Sk0pJxh6wi0gxTuDT+Fx2uLFZuyoxi35JyoFwS61Gsdu9QcwhbX94/aaf6JxoVMiNOVwDg9dGzj
 Z4/ojz2/5Ztg7eeUlDCEw4gqV
X-Google-Smtp-Source: AGHT+IH4lgvNsUHnBXhJTwhPZ6ES/eca2Luz/7MBxFtwM/gfjOqkPfYWg5DMg91sjnjMgnPylkv8YA==
X-Received: by 2002:a5d:6dab:0:b0:391:31c8:ba59 with SMTP id
 ffacd0b85a97d-39cb357afeamr595947f8f.4.1743712853197; 
 Thu, 03 Apr 2025 13:40:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d92dsm2701086f8f.71.2025.04.03.13.40.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 13:40:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-10.1 v3 4/9] hw/arm/virt-acpi: Factor its_enabled() helper
 out
Date: Thu,  3 Apr 2025 22:40:24 +0200
Message-ID: <20250403204029.47958-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403204029.47958-1-philmd@linaro.org>
References: <20250403204029.47958-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

GIC ITS is checked for the MADT and IORT tables.
Factor the checks out to the its_enabled() helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/virt-acpi-build.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9b7fc99f170..1c389ef5cdb 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -208,6 +208,13 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
 #define ROOT_COMPLEX_ENTRY_SIZE 36
 #define IORT_NODE_OFFSET 48
 
+static bool its_enabled(VirtMachineState *vms)
+{
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+
+    return !vmc->no_its;
+}
+
 /*
  * Append an ID mapping entry as described by "Table 4 ID mapping format" in
  * "IO Remapping Table System Software on ARM Platforms", Chapter 3.
@@ -670,7 +677,6 @@ static void
 build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     int i;
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     const MemMapEntry *memmap = vms->memmap;
     AcpiTable table = { .sig = "APIC", .rev = 4, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
@@ -741,7 +747,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                                           memmap[VIRT_HIGH_GIC_REDIST2].size);
         }
 
-        if (!vmc->no_its) {
+        if (its_enabled(vms)) {
             /*
              * ACPI spec, Revision 6.0 Errata A
              * (original 6.0 definition has invalid Length)
@@ -973,7 +979,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
                           vms->oem_table_id);
     }
 
-    if (!vmc->no_its) {
+    if (its_enabled(vms)) {
         acpi_add_table(table_offsets, tables_blob);
         build_iort(tables_blob, tables->linker, vms);
     }
-- 
2.47.1


