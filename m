Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C48C71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 13:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR9lX-00025j-Dh; Mon, 16 Jun 2025 09:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uR9l3-0001sb-2w
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:20:17 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uR9l0-0005Pw-Ok
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:20:16 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-23602481460so40553635ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 06:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750080013; x=1750684813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PUB2OOKyEQvR4QTaMbE6HOiXKSfQPJhPDp5XJ1tNVCw=;
 b=XJbIJQY/rDuILqBF2eUetlDiLMAjw0hGfUTpxHrodzmSUPM+ZWax9V3Nq4ouzWVY8B
 hEedNOnCOGryCLS4FDUvi5HwgYnKW4eMUBTWfIY3FJv4kOxix1G/sgj3g3HdLCu9nH3i
 d8fcZVkIKTchA1s7XT93Nm/el3YzKXXhi55HO7LtPmuETuGKCxVNIl4BGJPe2WopTjUd
 aJmDtKz/YXkBSlTJ99rcIF2y/M5aofZ+yhtceyUGuvo55aaKjqpBy5A6dXi5IlfwnM9Z
 YVVFppGt/Gk/yUiIJbzevFIXOPrpVtVEH1h/ULv/TcKLgShOZv5wSsZYlvcoaO9RQF1i
 eGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750080013; x=1750684813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PUB2OOKyEQvR4QTaMbE6HOiXKSfQPJhPDp5XJ1tNVCw=;
 b=wCoNBBB+SbvlwHyrjz3bCKA7On0KFH3Dw9gU1c2AFFFyiuXM0v7LAajmI5u29vYqDE
 5FsjuNa5I8jt8RHn9p0rF+VWQZLgw2Ox5X1uFls2BScQ7EdC6xRWjyEFNraXItjn61ke
 FN0VXhvk2MCYSaBhmhIy8fNiELZ9XBZvT776a2gi+rkEqRpqra+t7gUSPLuiTYMEg1dc
 SHEC3JgJs4NeCqZ2QKFCjPzeJoT7MYqq/npM53RwejKl6n5R3kn8vEPuJsBSDRchgWu0
 Kx0N8fbOTSpGdcTgRlLAkBH2L6hEZ/50uZz29yf53V88wKQ5C8PGEftxRxnC0vhCdVyp
 1ZCA==
X-Gm-Message-State: AOJu0Yz18KbU5tKXwFR2cqExe8k0+eX25/9/O3w8Qw3G7jP6iOsQk3gh
 4RfsYP3lr6JFX5WK9GdtyouaRfrP4ZpFGcTkHEFAHldYcPdT0Sa4q3DGZuFyiXmxcGPwT68DLcn
 9vK0U
X-Gm-Gg: ASbGncvFlEINE2qp+oQVZmJuowZQEq6A6iwett3ziwl/xWeSDalJUdCUdnJ6h9Jsvqz
 +vh5kdHPnNPVYuKMGluDco66AJ60H1h+6xq6rWh/1HkjE0+xVySjP1Poo2ncOnuS5bkfG/f/9z3
 EwSpqmdGPPtPjdiwAoVLBSCTjexBXjvY4YgnvJHxiLdFw4ODsdNXohN7mt8OWLZ4x4NSCSPUhAP
 oK8Yo66Cq8x+TGQ4keVou0zELmBT9gHI8ST7RGXr3yGQWsgTinDZnoK6k0HfMBA2YvEHlhy8mz8
 YbOt5M8DULM2plMhtsgrAw/A6OQtHRy+DwCaI2MkXXSA4j7KDjAPv+hX7huu1iDjayk=
X-Google-Smtp-Source: AGHT+IEU+rYnzPWOroUfAtV5+7aYn3EUMHCY+LIx9bqvK79Hz8yB4OWtqfjvijJdfFUbzgkNgD8Y7w==
X-Received: by 2002:a17:902:f688:b0:233:d1e6:4d12 with SMTP id
 d9443c01a7336-2366afe7a32mr114409995ad.13.1750080012716; 
 Mon, 16 Jun 2025 06:20:12 -0700 (PDT)
Received: from gromero0.. ([186.215.60.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2365de781dfsm60848405ad.131.2025.06.16.06.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 06:20:12 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 1/8] hw/intc/gicv3_its: Do not check its_class_name()
Date: Mon, 16 Jun 2025 13:18:17 +0000
Message-Id: <20250616131824.425315-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616131824.425315-1-gustavo.romero@linaro.org>
References: <20250616131824.425315-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x634.google.com
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

Since commit cc5e719e2c8 ("kvm: require KVM_CAP_SIGNAL_MSI"), the single
implementation of its_class_name() no longer returns NULL (it now always
returns a valid char pointer). Hence, update the prototype docstring and
remove the tautological checks that use the its_class_name() returned
value.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt-acpi-build.c               | 32 +++++++++++---------------
 include/hw/intc/arm_gicv3_its_common.h |  2 +-
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 7e8e0f0298..9eee284c80 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -737,20 +737,18 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                                           memmap[VIRT_HIGH_GIC_REDIST2].size);
         }
 
-        if (its_class_name()) {
-            /*
-             * ACPI spec, Revision 6.0 Errata A
-             * (original 6.0 definition has invalid Length)
-             * 5.2.12.18 GIC ITS Structure
-             */
-            build_append_int_noprefix(table_data, 0xF, 1);  /* Type */
-            build_append_int_noprefix(table_data, 20, 1);   /* Length */
-            build_append_int_noprefix(table_data, 0, 2);    /* Reserved */
-            build_append_int_noprefix(table_data, 0, 4);    /* GIC ITS ID */
-            /* Physical Base Address */
-            build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
-            build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
-        }
+        /*
+         * ACPI spec, Revision 6.0 Errata A
+         * (original 6.0 definition has invalid Length)
+         * 5.2.12.18 GIC ITS Structure
+         */
+        build_append_int_noprefix(table_data, 0xF, 1);  /* Type */
+        build_append_int_noprefix(table_data, 20, 1);   /* Length */
+        build_append_int_noprefix(table_data, 0, 2);    /* Reserved */
+        build_append_int_noprefix(table_data, 0, 4);    /* GIC ITS ID */
+        /* Physical Base Address */
+        build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
+        build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
     } else {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
@@ -969,10 +967,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
                           vms->oem_table_id);
     }
 
-    if (its_class_name()) {
-        acpi_add_table(table_offsets, tables_blob);
-        build_iort(tables_blob, tables->linker, vms);
-    }
+    acpi_add_table(table_offsets, tables_blob);
+    build_iort(tables_blob, tables->linker, vms);
 
 #ifdef CONFIG_TPM
     if (tpm_get_version(tpm_find()) == TPM_VERSION_2_0) {
diff --git a/include/hw/intc/arm_gicv3_its_common.h b/include/hw/intc/arm_gicv3_its_common.h
index 7dc712b38d..3c7b543b01 100644
--- a/include/hw/intc/arm_gicv3_its_common.h
+++ b/include/hw/intc/arm_gicv3_its_common.h
@@ -128,7 +128,7 @@ struct GICv3ITSCommonClass {
  * Return the ITS class name to use depending on whether KVM acceleration
  * and KVM CAP_SIGNAL_MSI are supported
  *
- * Returns: class name to use or NULL
+ * Returns: class name to use
  */
 const char *its_class_name(void);
 
-- 
2.34.1


