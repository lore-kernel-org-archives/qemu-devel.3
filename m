Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693D3CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQkO-0003UT-JF; Tue, 16 Jun 2026 06:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQkK-00035V-NK
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:10:16 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQkI-0004R8-Cs
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:10:16 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c858b5de728so2760101a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604613; x=1782209413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i1xwmUA9TTjHMmivkF2u3G7PEJxmulZlpojz/NCNHBo=;
 b=aXNmygzRrdEI5sIDHyT8aFWir4XwKD/3srWpY8o/tsbiRlsoUZk/LV3eFV+B/HH3vj
 iS+GRa2Kbv7rZcE2C1KYtBXaYoBl2hPzh3ZRYaR3j0Sc7W7pFWsbdMOJMhZfV01Fv4n6
 Lvslsk5PrmucWqCsUXcOk8ueiKrd+rQOGwUz0hB/5LQc8oxK7ctPINwcDjJtmumTX546
 WDM9wnOkYO+LR+RmvzB1QNjbFmtX9EbpXeJbCHIIZ4bn8RVXR3y/jKqlVkh/KFAsvkqF
 +5tY0JAUuqELTuM3aCgcESUMPqY5BV8Z1hoXU2IO2lNLbrV0o8GnzdlRO9ktcpGJcfC3
 faVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604613; x=1782209413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i1xwmUA9TTjHMmivkF2u3G7PEJxmulZlpojz/NCNHBo=;
 b=oUqZd5Bv2rQv8RTFLOMkI6mev+r8CHPGN9vzc7eeeqL5w3U3g2cRDyGwBBYa073X/r
 qT2tDnAnNfUN4Gd7xmJ5ECAc1zNP/e5n1GkKJUbk8BNbdIgiz8F1CfW+MSC2RK1NQ/WF
 ZGxliik/BdJuPtV3roJVCy1mZR08YIK5xR12KMK/MD3IKAnd7k/LT/2dmnIVWvC5/2H9
 3dos/2p6iEayNP47C+dSEG8+fGP98LPKWALp1xoZ4DgeDW0umH3QVHHYfCC0NxFmE+J9
 qhOaBspAsTL0oRm/F9BDrlupReEjDbMmmGLdx6zMbi1J35a/ZhpffqxDHOkX5rejiwDB
 cpYQ==
X-Gm-Message-State: AOJu0YwHE52yDU043tZlMNMACnfXupGe557I/pKzmLOO8+82RKPnuSsc
 iUYRrStCl8fvOXJFPcRv9Dzwo5mboqg8DRDx4WXsrkvqJveGaN2DlhQyDiTph88Q
X-Gm-Gg: Acq92OGqxe3YUm8TO+kVS91AXIed48TL2udbQ21KJCxdxV3QCaLk+ENzGmlkwGeh8bc
 TgS5h9pJyqo1umyZyXuogdQvfabq0ayyzHS2fNXzYAF0+ha41a/1muno/ccUZ+btItcNYWomGmx
 Mpr5INzRMV7Qj7WvN7KdHwzAsR+rP4LahZGHIOnV8BTvJoyH1dCUvspdXDXoJdL1+1Gd5UdYjnR
 2tpMsnIHvcNuagPPtDKwTFo/fEQO0ejgPnx8TsMiLR5UbB9wuV48AWncQUbbLejEqBinBy9vnsz
 IYYYqbednJgwOcjVmQbL0V/JqHJaVy+Qs/ALCU44jg+CNNuypcPN9GseiUWq45o4woSXgLrjWBr
 Pivof3BK8UuNyhOTO9/m/MIEfY5XBNbpUWo2Nj7JV8RbJxJeQYLqWLXis1OCujlcZlQZNfk0Uow
 2pHtWmY22Tg9w4rHnuB0RFqgWv9cgajnU/tO8nfYru
X-Received: by 2002:a05:6a21:4a98:b0:3a2:dabf:fef9 with SMTP id
 adf61e73a8af0-3b79636162cmr15790843637.27.1781604612862; 
 Tue, 16 Jun 2026 03:10:12 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:10:12 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 80/83] hw/riscv: add create_fdt_socket_cpus()
Date: Tue, 16 Jun 2026 20:05:23 +1000
Message-ID: <20260616100527.1939565-81-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Consolidate the creation of CPUs socket FDT in a helper that can be
shared across all boards.

The code was basically moved from the function with the same name from
'virt.c', with additional bits to create the cluster subnode beforehand.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260615203734.954428-11-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/fdt-common.h |  7 +++
 hw/riscv/fdt-common.c         | 74 +++++++++++++++++++++++++++++++
 hw/riscv/virt.c               | 83 +++--------------------------------
 3 files changed, 87 insertions(+), 77 deletions(-)

diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 27020e69c6..3af9d5c3fd 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -9,6 +9,8 @@
 #ifndef RISCV_VIRT_FDT_H
 #define RISCV_VIRT_FDT_H
 
+#include "target/riscv/cpu.h"
+
 void *create_board_device_tree(const char *model, const char *compatible,
                                int *fdt_size);
 void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
@@ -19,4 +21,9 @@ void create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
                              int socket_id, uint32_t *intc_phandles,
                              int num_harts, bool numa_enabled);
 void fdt_create_cpu_socket_subnode(void *fdt, uint64_t timebase_frequency);
+void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
+                            int socket_id, int num_harts_socket,
+                            int socket_hartid_base, uint32_t *phandle,
+                            uint32_t *intc_phandles, bool numa_enabled,
+                            bool is_32_bit);
 #endif
diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 02ac9ddcd8..6c795409a4 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -93,3 +93,77 @@ void fdt_create_cpu_socket_subnode(void *fdt, uint64_t timebase_frequency)
     qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
     qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
 }
+
+void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
+                            int socket_id, int num_harts_socket,
+                            int socket_hartid_base, uint32_t *phandle,
+                            uint32_t *intc_phandles, bool numa_enabled,
+                            bool is_32_bit)
+{
+    g_autofree char *clust_name = NULL;
+    uint32_t cpu_phandle;
+
+    clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket_id);
+    qemu_fdt_add_subnode(fdt, clust_name);
+
+    for (int cpu = num_harts_socket - 1; cpu >= 0; cpu--) {
+        RISCVCPU *cpu_ptr = &socket_harts[cpu];
+        int8_t satp_mode_max = cpu_ptr->cfg.max_satp_mode;
+        g_autofree char *cpu_name = NULL;
+        g_autofree char *core_name = NULL;
+        g_autofree char *intc_name = NULL;
+
+        cpu_phandle = (*phandle)++;
+
+        cpu_name = g_strdup_printf("/cpus/cpu@%d", socket_hartid_base + cpu);
+        qemu_fdt_add_subnode(fdt, cpu_name);
+
+        if (satp_mode_max != -1) {
+            g_autofree char *sv_name = NULL;
+            sv_name = g_strdup_printf("riscv,%s",
+                                      satp_mode_str(satp_mode_max, is_32_bit));
+            qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", sv_name);
+        }
+        riscv_isa_write_fdt(cpu_ptr, fdt, cpu_name);
+
+        if (cpu_ptr->cfg.ext_zicbom) {
+            qemu_fdt_setprop_cell(fdt, cpu_name, "riscv,cbom-block-size",
+                                  cpu_ptr->cfg.cbom_blocksize);
+        }
+
+        if (cpu_ptr->cfg.ext_zicboz) {
+            qemu_fdt_setprop_cell(fdt, cpu_name, "riscv,cboz-block-size",
+                                  cpu_ptr->cfg.cboz_blocksize);
+        }
+
+        if (cpu_ptr->cfg.ext_zicbop) {
+            qemu_fdt_setprop_cell(fdt, cpu_name, "riscv,cbop-block-size",
+                                  cpu_ptr->cfg.cbop_blocksize);
+        }
+
+        qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
+        qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
+        qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
+                              socket_hartid_base + cpu);
+        qemu_fdt_setprop_string(fdt, cpu_name, "device_type", "cpu");
+        if (numa_enabled) {
+            qemu_fdt_setprop_cell(fdt, cpu_name, "numa-node-id", socket_id);
+        }
+        qemu_fdt_setprop_cell(fdt, cpu_name, "phandle", cpu_phandle);
+
+        intc_phandles[cpu] = (*phandle)++;
+
+        intc_name = g_strdup_printf("%s/interrupt-controller", cpu_name);
+        qemu_fdt_add_subnode(fdt, intc_name);
+        qemu_fdt_setprop_cell(fdt, intc_name, "phandle",
+                              intc_phandles[cpu]);
+        qemu_fdt_setprop_string(fdt, intc_name, "compatible",
+                                "riscv,cpu-intc");
+        qemu_fdt_setprop(fdt, intc_name, "interrupt-controller", NULL, 0);
+        qemu_fdt_setprop_cell(fdt, intc_name, "#interrupt-cells", 1);
+
+        core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
+        qemu_fdt_add_subnode(fdt, core_name);
+        qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
+    }
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 6641b60131..33775a61fd 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -231,77 +231,6 @@ static void create_pcie_irq_map(RISCVVirtState *s, void *fdt, char *nodename,
                            0x1800, 0, 0, 0x7);
 }
 
-static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
-                                   char *clust_name, uint32_t *phandle,
-                                   uint32_t *intc_phandles)
-{
-    int cpu;
-    uint32_t cpu_phandle;
-    MachineState *ms = MACHINE(s);
-    bool is_32_bit = riscv_is_32bit(&s->soc[0]);
-
-    for (cpu = s->soc[socket].num_harts - 1; cpu >= 0; cpu--) {
-        RISCVCPU *cpu_ptr = &s->soc[socket].harts[cpu];
-        int8_t satp_mode_max = cpu_ptr->cfg.max_satp_mode;
-        g_autofree char *cpu_name = NULL;
-        g_autofree char *core_name = NULL;
-        g_autofree char *intc_name = NULL;
-        g_autofree char *sv_name = NULL;
-
-        cpu_phandle = (*phandle)++;
-
-        cpu_name = g_strdup_printf("/cpus/cpu@%d",
-            s->soc[socket].hartid_base + cpu);
-        qemu_fdt_add_subnode(ms->fdt, cpu_name);
-
-        if (satp_mode_max != -1) {
-            sv_name = g_strdup_printf("riscv,%s",
-                                      satp_mode_str(satp_mode_max, is_32_bit));
-            qemu_fdt_setprop_string(ms->fdt, cpu_name, "mmu-type", sv_name);
-        }
-
-        riscv_isa_write_fdt(cpu_ptr, ms->fdt, cpu_name);
-
-        if (cpu_ptr->cfg.ext_zicbom) {
-            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbom-block-size",
-                                  cpu_ptr->cfg.cbom_blocksize);
-        }
-
-        if (cpu_ptr->cfg.ext_zicboz) {
-            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cboz-block-size",
-                                  cpu_ptr->cfg.cboz_blocksize);
-        }
-
-        if (cpu_ptr->cfg.ext_zicbop) {
-            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbop-block-size",
-                                  cpu_ptr->cfg.cbop_blocksize);
-        }
-
-        qemu_fdt_setprop_string(ms->fdt, cpu_name, "compatible", "riscv");
-        qemu_fdt_setprop_string(ms->fdt, cpu_name, "status", "okay");
-        qemu_fdt_setprop_cell(ms->fdt, cpu_name, "reg",
-            s->soc[socket].hartid_base + cpu);
-        qemu_fdt_setprop_string(ms->fdt, cpu_name, "device_type", "cpu");
-        riscv_socket_fdt_write_id(ms, cpu_name, socket);
-        qemu_fdt_setprop_cell(ms->fdt, cpu_name, "phandle", cpu_phandle);
-
-        intc_phandles[cpu] = (*phandle)++;
-
-        intc_name = g_strdup_printf("%s/interrupt-controller", cpu_name);
-        qemu_fdt_add_subnode(ms->fdt, intc_name);
-        qemu_fdt_setprop_cell(ms->fdt, intc_name, "phandle",
-            intc_phandles[cpu]);
-        qemu_fdt_setprop_string(ms->fdt, intc_name, "compatible",
-            "riscv,cpu-intc");
-        qemu_fdt_setprop(ms->fdt, intc_name, "interrupt-controller", NULL, 0);
-        qemu_fdt_setprop_cell(ms->fdt, intc_name, "#interrupt-cells", 1);
-
-        core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
-        qemu_fdt_add_subnode(ms->fdt, core_name);
-        qemu_fdt_setprop_cell(ms->fdt, core_name, "cpu", cpu_phandle);
-    }
-}
-
 static void create_fdt_socket_aclint(RISCVVirtState *s,
                                      int socket,
                                      uint32_t *intc_phandles)
@@ -693,6 +622,7 @@ static void create_fdt_sockets(RISCVVirtState *s,
     g_autofree uint32_t *intc_phandles = NULL;
     int socket_count = riscv_socket_count(ms);
     bool numa_enabled = riscv_numa_enabled(ms);
+    bool is_32_bit = riscv_is_32bit(&s->soc[0]);
 
     fdt_create_cpu_socket_subnode(ms->fdt,
         kvm_enabled() ? kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
@@ -702,18 +632,17 @@ static void create_fdt_sockets(RISCVVirtState *s,
 
     phandle_pos = ms->smp.cpus;
     for (socket = (socket_count - 1); socket >= 0; socket--) {
-        g_autofree char *clust_name = NULL;
         hwaddr memaddr = s->memmap[VIRT_DRAM].base +
                          riscv_socket_mem_offset(ms, socket);
         uint64_t memsize = riscv_socket_mem_size(ms, socket);
 
         phandle_pos -= s->soc[socket].num_harts;
 
-        clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket);
-        qemu_fdt_add_subnode(ms->fdt, clust_name);
-
-        create_fdt_socket_cpus(s, socket, clust_name, phandle,
-                               &intc_phandles[phandle_pos]);
+        create_fdt_socket_cpus(ms->fdt, (&s->soc[socket])->harts, socket,
+                               s->soc[socket].num_harts,
+                               s->soc[socket].hartid_base,
+                               phandle, &intc_phandles[phandle_pos],
+                               numa_enabled, is_32_bit);
 
         create_fdt_socket_memory(ms->fdt, memaddr, memsize,
                                  socket, riscv_numa_enabled(ms));
-- 
2.54.0


