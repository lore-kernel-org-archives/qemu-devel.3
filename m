Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3796CD98E7
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQkT-00048h-E0; Tue, 16 Jun 2026 06:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQkQ-0003lp-Gb
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:10:22 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQkO-0004Ri-7i
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:10:22 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-36d98b9aa9aso3625512a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604619; x=1782209419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kyd3XUQvNLMbX96LTRLPZV85FORbdH15nuG5gD0APJk=;
 b=iDPiXEzT0RIO1twb3Ow0ey4FS8SdKnb+p1N2cOnTK41JhfTtSZVc1Nf9bMQcw1DJ1Y
 aZl6xQtTgKoFPZKalUyYPVBbkazsGYogu9JugxTIr7joQNJkUNWLMKTY+2teoNgIFSVw
 OvMeozXRgwJiL5J8+3JdKUng33OLNWNXseLFhQfxub7baD0/Vac3RTllj/M/oPxZoZew
 sQlQmy6Ef9dP0Lhdp2KzB14H/2RLbUL6ve9ssnC+GZmA8R34FoW3y73i41iv1RpcFZvn
 2F/juv4J+DgyBYeANB4FP3AXK5lVD9ErGw1QaCR0eOmnSDV3bOQv6duwU0aXo1C56ZmD
 2Emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604619; x=1782209419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kyd3XUQvNLMbX96LTRLPZV85FORbdH15nuG5gD0APJk=;
 b=oXyjvbDglx01ploPf+RvO8TaDxJa+ZBdwFB1YfFaLrU6QJa/Y6mnyTALTaBi2szEFu
 FKvFdqS1sI02uzoWZb/LbTL07tvBXxdnLDvJdUWuNuE3C6Zxk/Rsj0AYjqDiglbC9x/m
 jHREYjrlxVCNcgRx+mSF3ib6vGXXwzjJqsr5TcbZIRiZihlEKgUwTpptCRhHhmmFh7ax
 n3K/SsLh1E+MOPvNLbRvr7BaiA4CMZ5gMz0Zhy+Q5xkruyjpwUadtvYMiuB1+Zt/5eVZ
 hA+xnna3OkIU/i6/9q8jhwCydAYyscqo4pCN34doCM8CumscN4auiDHk6IHfbZbz3AVn
 edrA==
X-Gm-Message-State: AOJu0Yz3oFZNVnBfn0jJv0BksJX9lTKikLwlTiSt9SRxa0k6L91lXNYJ
 2xyhZ+Iq6xnki14Jqcx9+Y31cbJ0UDr+5trAuLYdDKba+Z8vvuqQfEt3x9wyqjOA
X-Gm-Gg: Acq92OGRWgGVBnYBGXJGAkpeVy1aslivQb7FK6JcWnoU5Ei2sdtnHN8e22yEwt6vTOd
 /N2mWY7P/mMHlEf8dvQFKeWhKLx+Fng5UZCGrQbACVdKy1d9wwyzVNWgsOqhvGtUyRD8cxEAdpR
 ecSAtl+eG/D10uBdnLLH+kb8xh3Ypiy5u2HxUz9e3ouy3tTZNmCNrT6+h812WsP1Lcsb0DX/NE8
 WOoobcZp6RpVHMs5faYXO3shZkPxOIh/iRnS+Pc3Qb7srJhdaFZ1/is3u4rA+5vBKaEw7Yiseqe
 GFxRx4QgsKfc6UAdLHzvOS5gbJjCJiV/X+x28K97OU7pfHd7yJ4xZ6LkvujTr9VOiMqggFbbtDZ
 bMoTbt753cT9e5zQKhaWKwydT9tsMhr4W8rprVwd3OMYhrLtVVw0Txq2tPzu16QSql/1o1wDJnL
 8pEjo1h3Jez+T7aN/4mQ8spQlkbjs93Zn2kBFzi6EtZabLR3QcGBY=
X-Received: by 2002:a17:90b:33ce:b0:36b:3ecd:88d2 with SMTP id
 98e67ed59e1d1-37a01847928mr18136910a91.3.1781604618689; 
 Tue, 16 Jun 2026 03:10:18 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:10:18 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 82/83] hw/riscv/fdt_common.c: create
 create_fdt_socket_cpu_internal()
Date: Tue, 16 Jun 2026 20:05:25 +1000
Message-ID: <20260616100527.1939565-83-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1034.google.com
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

The sifive_u board does not share the same CPU socket FDT bits from the
other boards.  In particular the riscv,isa creation is done using either
CPU0 from soc.e_cpus.harts, and for all other CPUs soc.u_cups.harts is
used.

It would be too cumbersome to add all these details in the common code
so we're going to add a special sifive_u only helper that shares the
common bits with the common helper used by the other boards.

create_fdt_socket_cpu_internal() contains the common bits shared between
the sifive_u board and the rest.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260615203734.954428-13-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/fdt-common.c | 108 +++++++++++++++++++++++++-----------------
 1 file changed, 65 insertions(+), 43 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 6c795409a4..70168ad657 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -94,28 +94,29 @@ void fdt_create_cpu_socket_subnode(void *fdt, uint64_t timebase_frequency)
     qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
 }
 
-void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
-                            int socket_id, int num_harts_socket,
-                            int socket_hartid_base, uint32_t *phandle,
-                            uint32_t *intc_phandles, bool numa_enabled,
-                            bool is_32_bit)
+static void
+create_fdt_socket_cpu_internal(void *fdt, char *clust_name, RISCVCPU *cpu_ptr,
+                               int cpu, int socket_id, int socket_hartid_base,
+                               uint32_t *phandle, uint32_t *intc_phandles,
+                               bool numa_enabled, bool is_32_bit)
 {
-    g_autofree char *clust_name = NULL;
-    uint32_t cpu_phandle;
-
-    clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket_id);
-    qemu_fdt_add_subnode(fdt, clust_name);
-
-    for (int cpu = num_harts_socket - 1; cpu >= 0; cpu--) {
-        RISCVCPU *cpu_ptr = &socket_harts[cpu];
+    g_autofree char *cpu_name = NULL;
+    g_autofree char *core_name = NULL;
+    g_autofree char *intc_name = NULL;
+    uint32_t cpu_phandle = (*phandle)++;
+    bool is_sifive_u = cpu_ptr == NULL;
+
+    cpu_name = g_strdup_printf("/cpus/cpu@%d", socket_hartid_base + cpu);
+
+    /*
+     * The sifive_u board has an exclusive satp and riscv,isa
+     * schema that can't be shared with other boards, so part
+     * of the CPU FDT creation (i.e. the /cpus/cpu@N subnode)
+     * is still being done by the board.
+     */
+    if (!is_sifive_u) {
         int8_t satp_mode_max = cpu_ptr->cfg.max_satp_mode;
-        g_autofree char *cpu_name = NULL;
-        g_autofree char *core_name = NULL;
-        g_autofree char *intc_name = NULL;
-
-        cpu_phandle = (*phandle)++;
 
-        cpu_name = g_strdup_printf("/cpus/cpu@%d", socket_hartid_base + cpu);
         qemu_fdt_add_subnode(fdt, cpu_name);
 
         if (satp_mode_max != -1) {
@@ -140,30 +141,51 @@ void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
             qemu_fdt_setprop_cell(fdt, cpu_name, "riscv,cbop-block-size",
                                   cpu_ptr->cfg.cbop_blocksize);
         }
+    }
 
-        qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
-        qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
-        qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
-                              socket_hartid_base + cpu);
-        qemu_fdt_setprop_string(fdt, cpu_name, "device_type", "cpu");
-        if (numa_enabled) {
-            qemu_fdt_setprop_cell(fdt, cpu_name, "numa-node-id", socket_id);
-        }
-        qemu_fdt_setprop_cell(fdt, cpu_name, "phandle", cpu_phandle);
-
-        intc_phandles[cpu] = (*phandle)++;
-
-        intc_name = g_strdup_printf("%s/interrupt-controller", cpu_name);
-        qemu_fdt_add_subnode(fdt, intc_name);
-        qemu_fdt_setprop_cell(fdt, intc_name, "phandle",
-                              intc_phandles[cpu]);
-        qemu_fdt_setprop_string(fdt, intc_name, "compatible",
-                                "riscv,cpu-intc");
-        qemu_fdt_setprop(fdt, intc_name, "interrupt-controller", NULL, 0);
-        qemu_fdt_setprop_cell(fdt, intc_name, "#interrupt-cells", 1);
-
-        core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
-        qemu_fdt_add_subnode(fdt, core_name);
-        qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
+    qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
+    qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
+    qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
+                          socket_hartid_base + cpu);
+    qemu_fdt_setprop_string(fdt, cpu_name, "device_type", "cpu");
+    if (numa_enabled) {
+        qemu_fdt_setprop_cell(fdt, cpu_name, "numa-node-id", socket_id);
+    }
+    qemu_fdt_setprop_cell(fdt, cpu_name, "phandle", cpu_phandle);
+
+    intc_phandles[cpu] = (*phandle)++;
+
+    intc_name = g_strdup_printf("%s/interrupt-controller", cpu_name);
+    qemu_fdt_add_subnode(fdt, intc_name);
+    qemu_fdt_setprop_cell(fdt, intc_name, "phandle",
+                          intc_phandles[cpu]);
+    qemu_fdt_setprop_string(fdt, intc_name, "compatible",
+                            "riscv,cpu-intc");
+    qemu_fdt_setprop(fdt, intc_name, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop_cell(fdt, intc_name, "#interrupt-cells", 1);
+
+    core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
+    qemu_fdt_add_subnode(fdt, core_name);
+    qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
+}
+
+void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
+                            int socket_id, int num_harts_socket,
+                            int socket_hartid_base, uint32_t *phandle,
+                            uint32_t *intc_phandles, bool numa_enabled,
+                            bool is_32_bit)
+{
+    g_autofree char *clust_name = NULL;
+
+    clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket_id);
+    qemu_fdt_add_subnode(fdt, clust_name);
+
+    for (int cpu = num_harts_socket - 1; cpu >= 0; cpu--) {
+        RISCVCPU *cpu_ptr = &socket_harts[cpu];
+
+        create_fdt_socket_cpu_internal(fdt, clust_name, cpu_ptr, cpu,
+                                       socket_id, socket_hartid_base,
+                                       phandle, intc_phandles, numa_enabled,
+                                       is_32_bit);
     }
 }
-- 
2.54.0


