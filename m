Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C92C71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 13:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR9lb-00028V-3C; Mon, 16 Jun 2025 09:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uR9lU-00021k-AT
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:20:44 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uR9lQ-0005V9-D2
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:20:42 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2351227b098so35844825ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 06:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750080034; x=1750684834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTagyUmf5Z2Dqe0MgGzh/1SbGYQJX9bpKTLCVGqNfjo=;
 b=aEbmjWoIFRj+/Tgpug+MiTdsXYMK1ZXFEeUA37vZ6Qz2QbtrQfgB2QfYLWYKwPpMjc
 ktRPOMdjLMQkkhpDhHzXfgT/weftw9yeiMOYv3D9y+z+gyip9hsr+H8FaG1cEeZgsggd
 qp3PfEItuC9jgAA6gW8a3U7semNR30aILp0lm++uzrBHt5Xo+lRVH+PI3tMMHU1XBvq+
 iozh1xd2g6vXy4N3xfkRw56app9PT5q9Zw1eykoEK+fYLpovz1Klld3Zg6ZhNIBILaAW
 OC6yiyHUr85ThWJqgo1vCh4Mec/rXjXgGG94wXiHZkgCeM2DALmcmy1Vpqb7We+M0VTt
 D7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750080034; x=1750684834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XTagyUmf5Z2Dqe0MgGzh/1SbGYQJX9bpKTLCVGqNfjo=;
 b=ia92u6+7Hw7LsxH5+qJD5TZzcKxEUJCy7DZbT3/s7yWUoiLcCf9bJGj0zvRcNlC3sq
 fg0HPCU0cUKVmTI42iDx0Q2i63lKLjiotyn0dx8RJNrastwAHDyMdI3mJ5c+/OtpCV+9
 HY5rA9z9bVNIGcj4wM/0NPwQ1qJgxc1D94M5xGIqWQ6KR/ZeFbqFeQQCBIrkUxtJ3aUl
 W1kUZ3saEPrerPiOlapyo+sKwk2p1eNrtu9oKVYG4xlIrSuiMno4XEXPCnumqAegEQsS
 AYxe0XYgTaPrgwwKMUeloUMiI3tegEXmi0Vt2agwvtzEypmfiqNqwbAilL+8zjlxDesH
 /EKg==
X-Gm-Message-State: AOJu0YyKSGjIUA8xfMB4xNQw04VvGahSMk4zryFKd+xd/4rxxG9xT0XI
 4mmrLsM7gMO9hzN6zNOItqu0ql2a3AWsz6HPULx7iTUH6ffNydJMXjWV8/7Dh1+wKFpkKor4W4G
 fFBud
X-Gm-Gg: ASbGncsPm29QUcbYe7HI3XGcgFkbCCsOIrK86F/1piroj1h5+IWn2EusvOo53X8xMjQ
 D3avyv8Fsyiu9EjJuZ12eoY4z1TSHvZK9y1dlDPkukqWZ0wj3Xlfi/eeNGZz+PBAefVc0XxBYbE
 PCk73+IdpNMRsbIBZyy1e8ZX5EW9V79499Y1MdBz32HrJdWT/Qcyv3BRywPsNot4ugqYUua6KMK
 Dt6xwTiFwXOop0ZXLeZAz3ikBz7+KrFXu/mT1KFTtEjZsVjHgta8YKoqEMOAVPhv0g0FE8LVK4P
 c/goqq4VuoBdTk+eZxVc4QvjmnqTjZ4PJo3U6OE72KWE8z4hebKstcm68Pb0mtHI5/g=
X-Google-Smtp-Source: AGHT+IEsbR7SW1wGZy9pnnwzl56UJLTomICzbZgdshbr+I/csSx1Js0mT1INqcg57+C1+216G4Kkew==
X-Received: by 2002:a17:903:1a90:b0:235:efbb:9539 with SMTP id
 d9443c01a7336-2366b32ceb4mr127437995ad.17.1750080033808; 
 Mon, 16 Jun 2025 06:20:33 -0700 (PDT)
Received: from gromero0.. ([186.215.60.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2365de781dfsm60848405ad.131.2025.06.16.06.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 06:20:33 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com
Subject: [PATCH v4 7/8] hw/arm/virt-acpi-build: Fix ACPI IORT and MADT tables
 when its=off
Date: Mon, 16 Jun 2025 13:18:23 +0000
Message-Id: <20250616131824.425315-8-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616131824.425315-1-gustavo.romero@linaro.org>
References: <20250616131824.425315-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x630.google.com
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

Currently, the ITS Group nodes in the IORT table and the GIC ITS Struct
in the MADT table are always generated, even if GIC ITS is not available
on the machine.

This commit fixes it by not generating the ITS Group nodes, not mapping
any other node to them, and not advertising the GIC ITS in the MADT
table, when GIC ITS is not available on the machine.

Since the fix changes the MADT and IORT tables, add the blobs for the
"its=off" test to the allow list and update them in the next commit.

Reported-by: Udo Steinberg <udo@hypervisor.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2886
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt-acpi-build.c                    | 152 ++++++++++++--------
 tests/qtest/bios-tables-test-allowed-diff.h |   2 +
 2 files changed, 93 insertions(+), 61 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6990bce3bb..2240421980 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -295,32 +295,42 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         /* Sort the smmu idmap by input_base */
         g_array_sort(smmu_idmaps, iort_idmap_compare);
 
-        /*
-         * Split the whole RIDs by mapping from RC to SMMU,
-         * build the ID mapping from RC to ITS directly.
-         */
-        for (i = 0; i < smmu_idmaps->len; i++) {
-            idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
+        nb_nodes = 2; /* RC and SMMUv3 */
+        rc_mapping_count = smmu_idmaps->len;
+
+        if (vms->its) {
+            /*
+             * Split the whole RIDs by mapping from RC to SMMU,
+             * build the ID mapping from RC to ITS directly.
+             */
+            for (i = 0; i < smmu_idmaps->len; i++) {
+                idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
+
+                if (next_range.input_base < idmap->input_base) {
+                    next_range.id_count = idmap->input_base - next_range.input_base;
+                    g_array_append_val(its_idmaps, next_range);
+                }
+
+                next_range.input_base = idmap->input_base + idmap->id_count;
+            }
 
-            if (next_range.input_base < idmap->input_base) {
-                next_range.id_count = idmap->input_base - next_range.input_base;
+            /* Append the last RC -> ITS ID mapping */
+            if (next_range.input_base < 0x10000) {
+                next_range.id_count = 0x10000 - next_range.input_base;
                 g_array_append_val(its_idmaps, next_range);
             }
 
-            next_range.input_base = idmap->input_base + idmap->id_count;
+            nb_nodes++; /* ITS */
+            rc_mapping_count += its_idmaps->len;
         }
-
-        /* Append the last RC -> ITS ID mapping */
-        if (next_range.input_base < 0x10000) {
-            next_range.id_count = 0x10000 - next_range.input_base;
-            g_array_append_val(its_idmaps, next_range);
-        }
-
-        nb_nodes = 3; /* RC, ITS, SMMUv3 */
-        rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
     } else {
-        nb_nodes = 2; /* RC, ITS */
-        rc_mapping_count = 1;
+        if (vms->its) {
+            nb_nodes = 2; /* RC and ITS */
+            rc_mapping_count = 1; /* Direct map to ITS */
+        } else {
+            nb_nodes = 1; /* RC only */
+            rc_mapping_count = 0; /* No output mapping */
+        }
     }
     /* Number of IORT Nodes */
     build_append_int_noprefix(table_data, nb_nodes, 4);
@@ -329,31 +339,43 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, IORT_NODE_OFFSET, 4);
     build_append_int_noprefix(table_data, 0, 4); /* Reserved */
 
-    /* Table 12 ITS Group Format */
-    build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */
-    node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
-    build_append_int_noprefix(table_data, node_size, 2); /* Length */
-    build_append_int_noprefix(table_data, 1, 1); /* Revision */
-    build_append_int_noprefix(table_data, id++, 4); /* Identifier */
-    build_append_int_noprefix(table_data, 0, 4); /* Number of ID mappings */
-    build_append_int_noprefix(table_data, 0, 4); /* Reference to ID Array */
-    build_append_int_noprefix(table_data, 1, 4); /* Number of ITSs */
-    /* GIC ITS Identifier Array */
-    build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
+    if (vms->its) {
+        /* Table 12 ITS Group Format */
+        build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */
+        node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
+        build_append_int_noprefix(table_data, node_size, 2); /* Length */
+        build_append_int_noprefix(table_data, 1, 1); /* Revision */
+        build_append_int_noprefix(table_data, id++, 4); /* Identifier */
+        build_append_int_noprefix(table_data, 0, 4); /* Number of ID mappings */
+        build_append_int_noprefix(table_data, 0, 4); /* Reference to ID Array */
+        build_append_int_noprefix(table_data, 1, 4); /* Number of ITSs */
+        /* GIC ITS Identifier Array */
+        build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
+    }
 
     if (vms->iommu == VIRT_IOMMU_SMMUV3) {
         int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
-
+        int num_id_mappings, offset_to_id_array;
+
+        if (vms->its) {
+            num_id_mappings = 1; /* ITS Group node */
+            offset_to_id_array = SMMU_V3_ENTRY_SIZE; /* Just after the header */
+        } else {
+            num_id_mappings = 0; /* No ID mappings */
+            offset_to_id_array = 0; /* No ID mappings array */
+        }
         smmu_offset = table_data->len - table.table_offset;
         /* Table 9 SMMUv3 Format */
         build_append_int_noprefix(table_data, 4 /* SMMUv3 */, 1); /* Type */
-        node_size =  SMMU_V3_ENTRY_SIZE + ID_MAPPING_ENTRY_SIZE;
+        node_size =  SMMU_V3_ENTRY_SIZE +
+                     (ID_MAPPING_ENTRY_SIZE * num_id_mappings);
         build_append_int_noprefix(table_data, node_size, 2); /* Length */
         build_append_int_noprefix(table_data, 4, 1); /* Revision */
         build_append_int_noprefix(table_data, id++, 4); /* Identifier */
-        build_append_int_noprefix(table_data, 1, 4); /* Number of ID mappings */
+        /* Number of ID mappings */
+        build_append_int_noprefix(table_data, num_id_mappings, 4);
         /* Reference to ID Array */
-        build_append_int_noprefix(table_data, SMMU_V3_ENTRY_SIZE, 4);
+        build_append_int_noprefix(table_data, offset_to_id_array, 4);
         /* Base address */
         build_append_int_noprefix(table_data, vms->memmap[VIRT_SMMU].base, 8);
         /* Flags */
@@ -370,8 +392,10 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         /* DeviceID mapping index (ignored since interrupts are GSIV based) */
         build_append_int_noprefix(table_data, 0, 4);
 
-        /* output IORT node is the ITS group node (the first node) */
-        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
+        if (vms->its) {
+            /* Output IORT node is the ITS Group node (the first node). */
+            build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
+        }
     }
 
     /* Table 17 Root Complex Node */
@@ -415,20 +439,24 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                                   range->id_count, smmu_offset);
         }
 
-        /* Map DeviceIDs (input) from SMMUv3 to ITS Group nodes: SMMU -> ITS. */
-        for (i = 0; i < its_idmaps->len; i++) {
-            range = &g_array_index(its_idmaps, AcpiIortIdMapping, i);
-            /* Output IORT node is the ITS Group node (the first node). */
-            build_iort_id_mapping(table_data, range->input_base,
-                                  range->id_count, IORT_NODE_OFFSET);
+        if (vms->its) {
+            /* Map DeviceIDs (input) from SMMUv3 to ITS Group nodes: SMMU -> ITS. */
+            for (i = 0; i < its_idmaps->len; i++) {
+                range = &g_array_index(its_idmaps, AcpiIortIdMapping, i);
+                /* Output IORT node is the ITS Group node (the first node). */
+                build_iort_id_mapping(table_data, range->input_base,
+                                      range->id_count, IORT_NODE_OFFSET);
+            }
         }
     } else {
-        /*
-         * Map bypassed RIDs (input) (don't go through the SMMU) to ITS Group
-         * nodes: RC -> ITS.
-         * Output IORT node is the ITS Group node (the first node).
-         */
-        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
+        if (vms->its) {
+            /*
+             * Map bypassed RIDs (input) (don't go through the SMMU) to ITS Group
+             * nodes: RC -> ITS.
+             * Output IORT node is the ITS Group node (the first node).
+             */
+            build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
+        }
     }
 
     acpi_table_end(linker, &table);
@@ -741,18 +769,20 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                                           memmap[VIRT_HIGH_GIC_REDIST2].size);
         }
 
-        /*
-         * ACPI spec, Revision 6.0 Errata A
-         * (original 6.0 definition has invalid Length)
-         * 5.2.12.18 GIC ITS Structure
-         */
-        build_append_int_noprefix(table_data, 0xF, 1);  /* Type */
-        build_append_int_noprefix(table_data, 20, 1);   /* Length */
-        build_append_int_noprefix(table_data, 0, 2);    /* Reserved */
-        build_append_int_noprefix(table_data, 0, 4);    /* GIC ITS ID */
-        /* Physical Base Address */
-        build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
-        build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
+        if (vms->its) {
+            /*
+             * ACPI spec, Revision 6.0 Errata A
+             * (original 6.0 definition has invalid Length)
+             * 5.2.12.18 GIC ITS Structure
+             */
+            build_append_int_noprefix(table_data, 0xF, 1);  /* Type */
+            build_append_int_noprefix(table_data, 20, 1);   /* Length */
+            build_append_int_noprefix(table_data, 0, 2);    /* Reserved */
+            build_append_int_noprefix(table_data, 0, 4);    /* GIC ITS ID */
+            /* Physical Base Address */
+            build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
+            build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
+        }
     } else {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..a88198d5c2 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/APIC.its_off",
+"tests/data/acpi/aarch64/virt/IORT.its_off",
-- 
2.34.1


