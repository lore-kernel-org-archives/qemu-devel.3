Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BCEC54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 19:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVbhC-0003bd-U6; Sat, 28 Jun 2025 15:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uVbga-0003Hw-3L
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 15:58:04 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uVbgY-0000Lz-C6
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 15:58:03 -0400
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7c5f720c717so440672185a.0
 for <qemu-devel@nongnu.org>; Sat, 28 Jun 2025 12:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751140681; x=1751745481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZ0q9jw4G9PIRZS2vkZv4PVRsiR5/vYw1c9H/9K2wA4=;
 b=Baqn0cdHMS7wIq5hvdY3FazYk55DXymUoc5SGggUcOl7qlg9pJtVAc09ntxlUkxgpa
 AlfFyUZmJZoEfZZscx84dYU5hJ6ea9jHMYcABuM/9rdr5sO2KplBgVAAcFhmgtekPfsW
 Cn9p2WEuzGDN5MJn2SROgwE6SMCUONFcx7uQRlUQdl5qhvGBEHZM/KjqPou62O5EXBEe
 6dras35G75sH30ENUklZjwItJoc8oSNm0c45sTiS8Jl99zCWZNEI+XYYurzmPKTBGnOb
 XVodVJqBAejz+gGafqMLxrbF1ER0KKSaHk3utNZ3zxLPcGiM+sX/BBSTJyMiUZf7hpFq
 sQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751140681; x=1751745481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IZ0q9jw4G9PIRZS2vkZv4PVRsiR5/vYw1c9H/9K2wA4=;
 b=fjT5ko5rukwxJ8uIJ3eMiwZP7Qebl6fxAHx2r+DueUJLUALY9WgLMwy5LHnwdsf8Dd
 3Sg6Szo8+3e3ECOAsu9V+Rs3ITUUM4azW3XpwAExXLK+hOVPVrRR4qUYgU3zXV/O0S82
 I5bjRMSJ0TBReoQ2Ag4olG64rAKuk99imGJw/L+oZ3DGWte5QPHc5ONjAJIuoWZCmW4p
 OOkwJbI5KFjCWSVvCDfHm+8Bi88Qt6yVMbsL66V3EkPHbAjUt3dfPwO6S/kiVu077FU/
 GaEPG7x04Y/xaTI6nANlTRxZfLTG5XxHwRpEDmu8OTJsVF2XoxcPrzjgbjjjCXiAFHPW
 BnIA==
X-Gm-Message-State: AOJu0YzAP0r9J8R57LnuN9mKNcYQAwO2V6/eEj/ttieLGPPxtcdQcxeo
 IHoet/jN2ZS0preXxGt3jLhbeZmW+XWDGQYdWaXI27hqzqXqnmaXagEZ7blk/auk7aX72mmyvKR
 7s6Tr
X-Gm-Gg: ASbGncviVec29N4/wex/eE3W+qq/7c+oUcROnHc02HNa99WPSsajKaXBP5/v1vHZlm4
 A6QdZWVIRTQ50YmVtNqD6cWQ2cZ2lhJ2uzs9L4N1Pu1udMsXxs2ekPzUwwRAwlkPeq9brhwTjZR
 K/OsHAQVl09t/WgD3fVHmL3f9X4lhhOxhLle77Bzn/Ztop7wS7m/Wb10swmObhAhZWr2AZaYPjd
 tsIZv6Cdh2IrrHANSdtRd+y6lGel6kVp26MgS1a6qe2KXnw0JTze1+WRSRfFX5+Z1xbOdDZBqC5
 pilb9Pj4Y6n7Qea91wh9NgFMzhj8Wxd6+NDeCYanMcE2S2tcVC/pScTZa9z3IbpTEnw=
X-Google-Smtp-Source: AGHT+IG4kQzHVpMljhTiLVw6pgmFfn032FrbS3dfRfKmC+Zy+u7kIBaDPSgF2cKt5yrgUCiiivbGXA==
X-Received: by 2002:a05:620a:1714:b0:7d3:f8b8:b1ce with SMTP id
 af79cd13be357-7d4441b3c5cmr1022339285a.27.1751140681150; 
 Sat, 28 Jun 2025 12:58:01 -0700 (PDT)
Received: from gromero0.. ([186.215.58.88]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443136907sm334395585a.14.2025.06.28.12.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jun 2025 12:58:00 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com
Subject: [PATCH v6 5/9] hw/arm/virt-acpi-build: Factor out create_its_idmaps
Date: Sat, 28 Jun 2025 19:57:18 +0000
Message-Id: <20250628195722.977078-6-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250628195722.977078-1-gustavo.romero@linaro.org>
References: <20250628195722.977078-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qk1-x730.google.com
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

Factor out a new function, create_its_idmaps(), from the current
build_iort code. Add proper comments to it clarifying how the ID ranges
that go directly to the ITS Group node are computed based on the ones
that are directed to the SMMU node.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/arm/virt-acpi-build.c | 65 ++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index e9cd3fb351..068383f982 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -266,6 +266,43 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
     return idmap_a->input_base - idmap_b->input_base;
 }
 
+/* Compute ID ranges (RIDs) from RC that are directed to the ITS Group node */
+static void create_its_idmaps(GArray *its_idmaps, GArray *smmu_idmaps)
+{
+    AcpiIortIdMapping *idmap;
+    AcpiIortIdMapping next_range = {0};
+
+    /*
+     * Based on the RID ranges that are directed to the SMMU, determine the
+     * bypassed RID ranges, i.e., the ones that are directed to the ITS Group
+     * node and do not pass through the SMMU, by subtracting the SMMU-bound
+     * ranges from the full RID range (0x0000–0xFFFF).
+     */
+     for (int i = 0; i < smmu_idmaps->len; i++) {
+        idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
+
+        if (next_range.input_base < idmap->input_base) {
+            next_range.id_count = idmap->input_base - next_range.input_base;
+            g_array_append_val(its_idmaps, next_range);
+        }
+
+        next_range.input_base = idmap->input_base + idmap->id_count;
+    }
+
+    /*
+     * Append the last RC -> ITS ID mapping.
+     *
+     * RIDs are 16-bit, according to the PCI Express 2.0 Base Specification, rev
+     * 0.9, section 2.2.6.2, "Transaction Descriptor - Transaction ID Field",
+     * hence the end of the range is 0x10000.
+     */
+    if (next_range.input_base < 0x10000) {
+        next_range.id_count = 0x10000 - next_range.input_base;
+        g_array_append_val(its_idmaps, next_range);
+    }
+}
+
+
 /*
  * Input Output Remapping Table (IORT)
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
@@ -276,7 +313,6 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     int i, nb_nodes, rc_mapping_count;
     size_t node_size, smmu_offset = 0;
-    AcpiIortIdMapping *idmap;
     uint32_t id = 0;
     GArray *smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
     GArray *its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
@@ -287,34 +323,17 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_table_begin(&table, table_data);
 
     if (vms->iommu == VIRT_IOMMU_SMMUV3) {
-        AcpiIortIdMapping next_range = {0};
-
         object_child_foreach_recursive(object_get_root(),
                                        iort_host_bridges, smmu_idmaps);
 
         /* Sort the smmu idmap by input_base */
         g_array_sort(smmu_idmaps, iort_idmap_compare);
 
-        /*
-         * Split the whole RIDs by mapping from RC to SMMU,
-         * build the ID mapping from RC to ITS directly.
-         */
-        for (i = 0; i < smmu_idmaps->len; i++) {
-            idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
-
-            if (next_range.input_base < idmap->input_base) {
-                next_range.id_count = idmap->input_base - next_range.input_base;
-                g_array_append_val(its_idmaps, next_range);
-            }
-
-            next_range.input_base = idmap->input_base + idmap->id_count;
-        }
-
-        /* Append the last RC -> ITS ID mapping */
-        if (next_range.input_base < 0x10000) {
-            next_range.id_count = 0x10000 - next_range.input_base;
-            g_array_append_val(its_idmaps, next_range);
-        }
+	/*
+	 * Knowing the ID ranges from the RC to the SMMU, it's possible to
+	 * determine the ID ranges from RC that are directed to the ITS.
+	 */
+        create_its_idmaps(its_idmaps, smmu_idmaps);
 
         nb_nodes = 3; /* RC, ITS, SMMUv3 */
         rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
-- 
2.34.1


