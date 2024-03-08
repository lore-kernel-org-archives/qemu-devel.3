Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1197C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYA2-00071Y-A3; Fri, 08 Mar 2024 06:13:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9t-0006l1-5T
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:02 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9r-0001e4-Bm
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:00 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dca3951ad9so15459335ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896376; x=1710501176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wEpRih6ORzdJDXGHz5nwlcHK1igTWX+SezuwlHiscb8=;
 b=My6GIFmupZtCZjvqyvXJVc+U5IpF60cqCabtPvOyOl8RANveTJ3GAw8Beoi0CbcWt6
 OCfMgTkdvz08Wktv3oLEzakRvJkJgNffoJCkVqyWTSf2flNvECndtHgiwVSxO1Pnqa7+
 MAtGhyn6X3gGzIidNFdOVFCBN3xMAMeX2XzhOxXnDGkjg8gmuw9A6PcXKQ/hLRvTz3+Z
 5mWODeO0ol/GFsYFFf1hargqPGu6/WHQbpnFb1SD/pmov4VZoL3oebTrAkG+um78oVsA
 HBfeKWGLjNvTLs/bBksJmGtxFjm7YfzuZiQkVxU8+M8LwvV9Qp/SHQ4xZCzcEeOh2o5L
 ZAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896376; x=1710501176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wEpRih6ORzdJDXGHz5nwlcHK1igTWX+SezuwlHiscb8=;
 b=g+A8TevEFfG4ES+TkiFLH9GMwSboSmKwGS3jjgTICtEGhlTplF63NkI6rhiUTUUqm3
 NHNrcM+upzyF86bgL4whfbB//cDnPvRohd1WLRlVIdVntWHRTtFxr/+bn1db//hRTUmx
 RjWhmS7hS+Gvhlpe6LFZ3gfr4JDalsyxfGpbhVVWDeFau22sm3P2sfQT4ct6D5fE+a1c
 2fbxdxQ31OkOtKRdr6dScrfkh7G+bN8RUarNY/HEop3BHMd1h5HtwXSQfbTfZ3ei6sDG
 5K1MwB5hCGeyjkYkuXBmqkONV0Bu20VEJfnCPQNjqPAGkFDqMGHtmR/Hmrb24zhPvpUQ
 O1Jw==
X-Gm-Message-State: AOJu0YwiKtHbMwjFp/BSoMJjuL+uUTB+syszsiyJZn4yEKhHtCg8YsAf
 ksHOa3hQ8tlwB4/KHxkdpx7QjOaUniQc2GOrf6k6AnZb1C1XoqvuhpZ0BWJN+fdUVQ==
X-Google-Smtp-Source: AGHT+IEkAzhd090gQcng/Y13yUwBW58AvobQW8Q9B0Z5+B0/EE797ji6EwLXVCy365p6cIMdRLmUdA==
X-Received: by 2002:a17:902:9881:b0:1dc:b531:839 with SMTP id
 s1-20020a170902988100b001dcb5310839mr8969123plp.25.1709896376311; 
 Fri, 08 Mar 2024 03:12:56 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:12:55 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Haibo Xu <haibo1.xu@intel.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 16/34] hw/riscv/virt-acpi-build.c: Add SRAT and SLIT ACPI tables
Date: Fri,  8 Mar 2024 21:11:34 +1000
Message-ID: <20240308111152.2856137-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Haibo Xu <haibo1.xu@intel.com>

Enable ACPI NUMA support by adding the following 2 ACPI tables:
SRAT: provides the association for memory/Harts and Proximity Domains
SLIT: provides the relative distance between Proximity Domains

The SRAT RINTC Affinity Structure definition[1] was based on the recently
approved ACPI CodeFirst ECR[2].

[1] https://github.com/riscv-non-isa/riscv-acpi/issues/25
[2] https://mantis.uefi.org/mantis/view.php?id=2433

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20240129094200.3581037-1-haibo1.xu@intel.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt-acpi-build.c | 60 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 0baa902fea..ef72db018e 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -564,11 +564,61 @@ static void build_madt(GArray *table_data,
     acpi_table_end(linker, &table);
 }
 
+/*
+ * ACPI spec, Revision 6.5+
+ * 5.2.16 System Resource Affinity Table (SRAT)
+ * REF: https://github.com/riscv-non-isa/riscv-acpi/issues/25
+ *      https://drive.google.com/file/d/1YTdDx2IPm5IeZjAW932EYU-tUtgS08tX/view
+ */
+static void
+build_srat(GArray *table_data, BIOSLinker *linker, RISCVVirtState *vms)
+{
+    int i;
+    uint64_t mem_base;
+    MachineClass *mc = MACHINE_GET_CLASS(vms);
+    MachineState *ms = MACHINE(vms);
+    const CPUArchIdList *cpu_list = mc->possible_cpu_arch_ids(ms);
+    AcpiTable table = { .sig = "SRAT", .rev = 3, .oem_id = vms->oem_id,
+                        .oem_table_id = vms->oem_table_id };
+
+    acpi_table_begin(&table, table_data);
+    build_append_int_noprefix(table_data, 1, 4); /* Reserved */
+    build_append_int_noprefix(table_data, 0, 8); /* Reserved */
+
+    for (i = 0; i < cpu_list->len; ++i) {
+        uint32_t nodeid = cpu_list->cpus[i].props.node_id;
+        /*
+         * 5.2.16.8 RINTC Affinity Structure
+         */
+        build_append_int_noprefix(table_data, 7, 1);      /* Type */
+        build_append_int_noprefix(table_data, 20, 1);     /* Length */
+        build_append_int_noprefix(table_data, 0, 2);        /* Reserved */
+        build_append_int_noprefix(table_data, nodeid, 4); /* Proximity Domain */
+        build_append_int_noprefix(table_data, i, 4); /* ACPI Processor UID */
+        /* Flags, Table 5-70 */
+        build_append_int_noprefix(table_data, 1 /* Flags: Enabled */, 4);
+        build_append_int_noprefix(table_data, 0, 4); /* Clock Domain */
+    }
+
+    mem_base = vms->memmap[VIRT_DRAM].base;
+    for (i = 0; i < ms->numa_state->num_nodes; ++i) {
+        if (ms->numa_state->nodes[i].node_mem > 0) {
+            build_srat_memory(table_data, mem_base,
+                              ms->numa_state->nodes[i].node_mem, i,
+                              MEM_AFFINITY_ENABLED);
+            mem_base += ms->numa_state->nodes[i].node_mem;
+        }
+    }
+
+    acpi_table_end(linker, &table);
+}
+
 static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
 {
     GArray *table_offsets;
     unsigned dsdt, xsdt;
     GArray *tables_blob = tables->table_data;
+    MachineState *ms = MACHINE(s);
 
     table_offsets = g_array_new(false, true,
                                 sizeof(uint32_t));
@@ -604,6 +654,16 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
                    s->oem_table_id);
     }
 
+    if (ms->numa_state->num_nodes > 0) {
+        acpi_add_table(table_offsets, tables_blob);
+        build_srat(tables_blob, tables->linker, s);
+        if (ms->numa_state->have_numa_distance) {
+            acpi_add_table(table_offsets, tables_blob);
+            build_slit(tables_blob, tables->linker, ms, s->oem_id,
+                       s->oem_table_id);
+        }
+    }
+
     /* XSDT is pointed to by RSDP */
     xsdt = tables_blob->len;
     build_xsdt(tables_blob, tables->linker, table_offsets, s->oem_id,
-- 
2.44.0


