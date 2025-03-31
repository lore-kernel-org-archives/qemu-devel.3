Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B838C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 22:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzNNQ-0000bg-2a; Mon, 31 Mar 2025 18:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzNNO-0000ZX-9M
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:13:02 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzNNM-00076H-Jh
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:13:01 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39c14016868so1689100f8f.1
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 15:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743459179; x=1744063979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/KLJrDvoh1faXMk+CdmP0dMnMEwSNEMM0AJfQ5Q45FQ=;
 b=gWsE2kxbR348jSf67ACN5MUeMdZrzZbCfcaLi91wnIPYrIF3T12jeeLYreS3Gy2qdS
 vxRc1cPa5MIK7MUR1Dromjp8cYyWQ/wFZeJIaZN/mzccm76Zsmbb9Dl6Fs2gy0rto0P6
 dpZJnKx/nrH3mQK9r4MI/A8fvcIQYMDlAsVG1L/jpmTt7ROPCY4yx+15/oD8b4MiGpCa
 hpVycVYFzFPIu7KAPJiaNI2GuHsiNRVIyJQ4+TiD6mW4GgdUY5NSYAe+oxTaZaYlfDQ4
 TNJItKSfm7+PpuECKYvxkuuHVS1dB2snxBopXaZMJbZ38rb3bLFEhyYjjGwGq2UGJk7a
 7qtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743459179; x=1744063979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/KLJrDvoh1faXMk+CdmP0dMnMEwSNEMM0AJfQ5Q45FQ=;
 b=MkPF9tXGI6cu+QOmA84KDK7Ua72unQVhKXSTYqPF90Ju8VqkUW+2WurxY86TiXGRfC
 +/yQmD+5oOvfIgTC/v7w0ZJc1DbLiFuQxQoG9dAqVkQ1L4/9R2dGiDi0G8nWRkrRndcP
 p+QrfQi+P/mkaSNpEoGK8EkhOsnpaLL0y0rTGBk3WWEVu2zt5jkcju6RSWLhBAoEKfd/
 Ym/aTHC7s5cyzqZZo8Yghvvmb2+06ZBRAEshloFHU+d6AIBLodBzhwyYYZ2EYUf1/bUM
 /wM65PXwO56QNfzgcMCO4wRNHuM0b2EpV2V/Tjm/EHLBGRp2a7ur+i+M18w/3gX0l+BD
 JJ9w==
X-Gm-Message-State: AOJu0YzNT9Ov58sLf20O37Cb+MHQaGIx1eVTOn/1cROoSXVi/8mddY66
 SdwvjYnadeH+v1Nxhvid77gd8nW15A6yrxX32qsdCtfU0vbXZJFKJRwkTUSQWZq/GazEvWsyrml
 p
X-Gm-Gg: ASbGncueFP3+f5O7uogBih9FcbBeu8MBktaGeiGM+rmpremYcae3Ita7+0vwycO39pm
 Nme0ZHCwDVdA7lGYmbLF/CxrkfyuTyyZWSG0zyJAMSHvckBdVf40i9pXu/Shwsdb8FqGMb/r9Ev
 v/X2qfp6Z0IQO+JhYRsMpIlQNR0tsyLd62OoMx7JBn97ke6DBwQt6G/E0NCuuwOpdyS6lgXEeDk
 1hSmp/e1VXzFTy1xF9UJ87ZzPeNNa90Aje45cyaQmXRKTefxRuIcdCInG3JWlF3QRsVKkUkY4ut
 j9XcM/r7jR9gN1lFB9GeVQbgK/i0S+UYNiRJX9rFO7siiV+Gwn4xcEY9DBUGByo0zkDsu+8hm3Q
 rFELZxfvpMf0d7xVSgx8=
X-Google-Smtp-Source: AGHT+IEoTcby2vbSJx7NXCJSEzm8SgeEGERG/QhIcQsysIM/SBPkywV2DzGOrbqMaRSnQNtIMrXClA==
X-Received: by 2002:a05:6000:188b:b0:390:f0ff:2c11 with SMTP id
 ffacd0b85a97d-39c120cb546mr8952099f8f.2.1743459178856; 
 Mon, 31 Mar 2025 15:12:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8835e627sm164459555e9.29.2025.03.31.15.12.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 15:12:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 3/5] hw/arm/virt-acpi: Factor its_enabled() helper out
Date: Tue,  1 Apr 2025 00:12:37 +0200
Message-ID: <20250331221239.87150-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331221239.87150-1-philmd@linaro.org>
References: <20250331221239.87150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 hw/arm/virt-acpi-build.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3ac8f8e1786..fdc08b40883 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -208,6 +208,13 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
 #define ROOT_COMPLEX_ENTRY_SIZE 36
 #define IORT_NODE_OFFSET 48
 
+static bool its_enabled(VirtMachineState *vms)
+{
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+
+    return its_class_name() && !vmc->no_its;
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
 
-        if (its_class_name() && !vmc->no_its) {
+        if (its_enabled(vms)) {
             /*
              * ACPI spec, Revision 6.0 Errata A
              * (original 6.0 definition has invalid Length)
@@ -973,7 +979,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
                           vms->oem_table_id);
     }
 
-    if (its_class_name() && !vmc->no_its) {
+    if (its_enabled(vms)) {
         acpi_add_table(table_offsets, tables_blob);
         build_iort(tables_blob, tables->linker, vms);
     }
-- 
2.47.1


