Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CA2CD98E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE4A-0002lf-Vn; Mon, 15 Jun 2026 16:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZE49-0002ke-Od
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:37:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZE47-00029M-Gt
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:37:53 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIxA5h884066
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CG18iFQZU10
 ayHHW4odAvJfTCBncVzW+QTbcwlk1arI=; b=gbinksvQU4UeUdKj6bKOa01cupk
 JlKVHB85eekSWptJEIXQo+UW1ShYZ59P3ltRR1lnDt42+ir6PaV9YnfNfxir2LDc
 RY2Zj5JCqEdSIbueg8BTBrZwm+UTBgw1NU3CMY4XJPaJfHry19KORNuwf83uTbav
 gZVUUUTz9EIdfUzRkvDZFgICfUBSE1GN7RFIrL2JwOF0EDDUOP+LPorrqIDX1HJI
 k0iSYf1IfK8V2WY4NehCwkiUx1L0u/UU9uVUfgCpMGTgtNETXlrSlc/Y2+8MnBOo
 lJ6N7lgb0agfd6zm8YjlE/YfUSoDYykcoxXvTJV/9UVadFd7CqbvVWuaYYQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etfa72ts5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:37:50 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8cce230de8bso24317036d6.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781555869; x=1782160669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CG18iFQZU10ayHHW4odAvJfTCBncVzW+QTbcwlk1arI=;
 b=CnmT668BcL1ixQqK4lIDXelATjhBGkiPm+uzwSIaiobhoF8XcYuiT11HVtIR0BSg8I
 Ag/qkM9J85CSNNSi8IREBNBU778ZRaQKNFRBUophtXlJvzlJCA8fTtkWIYOzKfThJZPO
 XxCCpiCsILHcnU8vqqQDJXUeD44X3jhFeIVGvBbpc6aJ7CEQGvh9MUzp8KuVHAyyvvc9
 VkQIKCu3Dfy+yCjpQde2bhT7RKkLOYGDzwhuNvd/JUmX17M56k/1b2Ist/scCrdYBBYi
 7ME1wjvBNP7ZEzGKRRpWTVz1owc0BUfSM1Iop/6VMlO1jS4Nst2Tr7f0CSm7akf0YhKJ
 GoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781555869; x=1782160669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CG18iFQZU10ayHHW4odAvJfTCBncVzW+QTbcwlk1arI=;
 b=a0KXVDSPduMlKz2CY4fH/xz2GZAK6uH7A2v3WMVel73W5KEJFKIkDLj4G4AGU1Az0B
 Zw1xgucVkKP+Y8Cw6F9Vecp1e2VQU9w8YMxX1XMAvHHBTCpbDJd66hDnJ5fxkJIg+AxM
 l3sBx4AJqWvPh75Q+Zx7MZ4mwbnNfyfz3WG/HU/F2XCPPhPAsaBAkvKAF45K1R/CUQfc
 UzV6c6+UPuur0kwKIWC1IaErGrhTJYruBnE/caU+KS49RmN4NGxT88HJHduOzpKrtq5a
 bMW1XrhZ9/TUOAADye9r4z/1a620hQLOZ6uteHHcAlLm42h6QMoS+gj4k9mP/5IF/9Ma
 GfOg==
X-Gm-Message-State: AOJu0YzdJx5kxm7uvnw71Zu9JFsJLasiF2l8IIQudpqufvECq+8a+YTY
 WxuLFAelqtbUC+HEV8cKTuRfLWU5FCWPBBRfbb9grjVQeSJ1HKm+HFVcBTVKBODhMsFggLZEYnB
 RSSed63awmR8SSPbuBhqMBPUeG12CHSXd5xG6on6lizBnE3Gp7OcBt31JH2A2+o5BWg==
X-Gm-Gg: Acq92OGIfq6PV8IEYqAdFfBgeD9oWx+2is+fj4lOIE4vSA/4rBoC/8DKutKWbvUPKtM
 wcIXOwAxkkNGzRdz27Ncy3YK4UEMWCSGv7/jc0hQ0sfIdSD4ZIkrRqjcl7CqlZ6VbSOogr7e8tF
 xSeYc5YwuCULbGbpnhmRv65Nj3HfAT1NHcfQHOjsHn53QbbijalGxTWz3gtIpsM+fxZR1mrogXM
 znRmhGKdzNAyiACE6L6V43nykhBACHh4syReEYjf8vJMLJ3lGt48kZBROoCC+t9Huvqodgp2CO3
 CdvrkGK7ErlPcJe2g3f/lnU8yEJdN74iQiAeny0BsMTB6Px0BFK6wmt4s2MOKVmHsRq8P412mdg
 r8KRRKOVwjdC8pziLJV1R2FFWShhv2y+mZ91xeNP8smKpzaQXgp+eLc3XhWk=
X-Received: by 2002:a05:6214:2244:b0:8b6:1c72:3597 with SMTP id
 6a1803df08f44-8d44f42554dmr225890636d6.36.1781555869161; 
 Mon, 15 Jun 2026 13:37:49 -0700 (PDT)
X-Received: by 2002:a05:6214:2244:b0:8b6:1c72:3597 with SMTP id
 6a1803df08f44-8d44f42554dmr225890106d6.36.1781555868708; 
 Mon, 15 Jun 2026 13:37:48 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d9f4740fbasm9749906d6.29.2026.06.15.13.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 13:37:48 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 04/13] hw/riscv: add create_fdt_socket_memory() helper
Date: Mon, 15 Jun 2026 17:37:24 -0300
Message-ID: <20260615203734.954428-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
References: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: z6v1NFKvRuVVODcmQLha4DB3VgzfxHcA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIxOCBTYWx0ZWRfX8OuwikRlTM4K
 H2GV7gLfd95hvFQPP+UYFiKzWDngdQPioLZVERCI4Y4Le7kwP7PrcVMFxu5U2+TXiM+f6J8/RbC
 kWt3wpg86uQcCR13TgE8VzAJ6CEVKWo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIxOCBTYWx0ZWRfX9OyF3UlfXKiT
 dfokbHfPRam4jI66YosFe6ARx60Ld4mmXAoSiNNQ7136tbn3rZqyiHqvY+6Fcg5qd/WE6a6fZke
 HfH4wGwhO3erDz/P3N7Xucu3lWr93Vlc8cj7YS91O8QTCeathgEARzelWADiaKqmdXPdjla1Fpo
 bnYZ2G1g7NXWNQfx53rE2Cf+qxoDcEX58pw57y3qO0xAnl4ZL/zbpKisuY0t0UgWLfYjZZKOnki
 3cD/c3BoMaKhjdl1RvrcMPof3h/afVopd1lDGPVJodLrMdOwYJWriyODa/MYdiKEbWLNosGSjB+
 Sog+t1VBqvUL6qaOu5EDKiyoSj/f+ZBm5TFJG9n5/pGnUbFj1/qTQR1zI9Nj78mlXs8OK3wjP6Z
 KUkzice4WYZnYqk4hkOnrLWnp7DB0HcjoEap8QRWSylY27klUYRENlzjTAZ+Y3CE/rsMRzb+g2l
 bM0MDlDXIwxU7hjhnVQ==
X-Proofpoint-GUID: z6v1NFKvRuVVODcmQLha4DB3VgzfxHcA
X-Authority-Analysis: v=2.4 cv=AN2yTM5Z c=1 sm=1 tr=0 ts=6a30629e cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=KZ0xQHs0bhFOLZ5x_WUA:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150218
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

This helper encapsulates the creation of /memory@addr FDT subnodes.

Boards are responsible for calculating the adequate addr, size and
inform if we have numa enabled.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 15 +++++++++++++++
 hw/riscv/sifive_u.c           | 11 ++---------
 hw/riscv/spike.c              | 18 +++++++-----------
 hw/riscv/virt.c               | 23 ++++++-----------------
 include/hw/riscv/fdt-common.h |  2 ++
 5 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index b155246998..719c36e001 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -10,6 +10,7 @@
 
 #include "qemu/error-report.h"
 #include "system/device_tree.h"
+#include "hw/core/boards.h"
 #include "hw/riscv/fdt-common.h"
 
 void *create_board_device_tree(const char *model, const char *compatible,
@@ -35,3 +36,17 @@ void *create_board_device_tree(const char *model, const char *compatible,
 
     return fdt;
 }
+
+void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
+                              int socket_id, bool numa_enabled)
+{
+    g_autofree char *mem_name = g_strdup_printf("/memory@%"HWADDR_PRIx, addr);
+
+    qemu_fdt_add_subnode(fdt, mem_name);
+    qemu_fdt_setprop_sized_cells(fdt, mem_name, "reg", 2, addr, 2, size);
+    qemu_fdt_setprop_string(fdt, mem_name, "device_type", "memory");
+
+    if (numa_enabled) {
+        qemu_fdt_setprop_cell(fdt, mem_name, "numa-node-id", socket_id);
+    }
+}
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 5d3b2751ad..a00cfd08a7 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -98,7 +98,6 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
                        bool is_32_bit)
 {
     MachineState *ms = MACHINE(s);
-    uint64_t mem_size = ms->ram_size;
     void *fdt;
     int cpu;
     uint32_t *cells;
@@ -138,14 +137,8 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
     g_free(nodename);
 
-    nodename = g_strdup_printf("/memory@%lx",
-        (long)memmap[SIFIVE_U_DEV_DRAM].base);
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        memmap[SIFIVE_U_DEV_DRAM].base >> 32, memmap[SIFIVE_U_DEV_DRAM].base,
-        mem_size >> 32, mem_size);
-    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
-    g_free(nodename);
+    create_fdt_socket_memory(fdt, memmap[SIFIVE_U_DEV_DRAM].base,
+                             ms->ram_size, 0, false);
 
     qemu_fdt_add_subnode(fdt, "/cpus");
     qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 79c9bb041f..92facba29d 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -55,13 +55,12 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
 {
     void *fdt;
     int fdt_size;
-    uint64_t addr, size;
     unsigned long clint_addr;
     int cpu, socket;
     MachineState *ms = MACHINE(s);
     uint32_t *clint_cells;
     uint32_t cpu_phandle, intc_phandle, phandle = 1;
-    char *mem_name, *clint_name, *clust_name;
+    char *clint_name, *clust_name;
     char *core_name, *cpu_name, *intc_name;
     static const char * const clint_compat[2] = {
         "sifive,clint0", "riscv,clint0"
@@ -85,6 +84,10 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
     qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
 
     for (socket = (riscv_socket_count(ms) - 1); socket >= 0; socket--) {
+        hwaddr memaddr = memmap[SPIKE_DRAM].base +
+                         riscv_socket_mem_offset(ms, socket);
+        uint64_t memsize =  riscv_socket_mem_size(ms, socket);
+
         clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket);
         qemu_fdt_add_subnode(fdt, clust_name);
 
@@ -133,15 +136,8 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
             g_free(cpu_name);
         }
 
-        addr = memmap[SPIKE_DRAM].base + riscv_socket_mem_offset(ms, socket);
-        size = riscv_socket_mem_size(ms, socket);
-        mem_name = g_strdup_printf("/memory@%lx", (long)addr);
-        qemu_fdt_add_subnode(fdt, mem_name);
-        qemu_fdt_setprop_cells(fdt, mem_name, "reg",
-            addr >> 32, addr, size >> 32, size);
-        qemu_fdt_setprop_string(fdt, mem_name, "device_type", "memory");
-        riscv_socket_fdt_write_id(ms, mem_name, socket);
-        g_free(mem_name);
+        create_fdt_socket_memory(fdt, memaddr, memsize, socket,
+                                 riscv_numa_enabled(ms));
 
         clint_addr = memmap[SPIKE_CLINT].base +
             (memmap[SPIKE_CLINT].size * socket);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index cb1d83fd48..df3eadef78 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -302,22 +302,6 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
     }
 }
 
-static void create_fdt_socket_memory(RISCVVirtState *s, int socket)
-{
-    g_autofree char *mem_name = NULL;
-    hwaddr addr;
-    uint64_t size;
-    MachineState *ms = MACHINE(s);
-
-    addr = s->memmap[VIRT_DRAM].base + riscv_socket_mem_offset(ms, socket);
-    size = riscv_socket_mem_size(ms, socket);
-    mem_name = g_strdup_printf("/memory@%"HWADDR_PRIx, addr);
-    qemu_fdt_add_subnode(ms->fdt, mem_name);
-    qemu_fdt_setprop_sized_cells(ms->fdt, mem_name, "reg", 2, addr, 2, size);
-    qemu_fdt_setprop_string(ms->fdt, mem_name, "device_type", "memory");
-    riscv_socket_fdt_write_id(ms, mem_name, socket);
-}
-
 static void create_fdt_socket_clint(RISCVVirtState *s,
                                     int socket,
                                     uint32_t *intc_phandles)
@@ -759,6 +743,10 @@ static void create_fdt_sockets(RISCVVirtState *s,
     phandle_pos = ms->smp.cpus;
     for (socket = (socket_count - 1); socket >= 0; socket--) {
         g_autofree char *clust_name = NULL;
+        hwaddr memaddr = s->memmap[VIRT_DRAM].base +
+                         riscv_socket_mem_offset(ms, socket);
+        uint64_t memsize = riscv_socket_mem_size(ms, socket);
+
         phandle_pos -= s->soc[socket].num_harts;
 
         clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket);
@@ -767,7 +755,8 @@ static void create_fdt_sockets(RISCVVirtState *s,
         create_fdt_socket_cpus(s, socket, clust_name, phandle,
                                &intc_phandles[phandle_pos]);
 
-        create_fdt_socket_memory(s, socket);
+        create_fdt_socket_memory(ms->fdt, memaddr, memsize,
+                                 socket, riscv_numa_enabled(ms));
 
         if (virt_aclint_allowed() && s->have_aclint) {
             create_fdt_socket_aclint(s, socket,
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index adf9b33dfd..81689f418b 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -11,4 +11,6 @@
 
 void *create_board_device_tree(const char *model, const char *compatible,
                                int *fdt_size);
+void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
+                              int socket_id, bool numa_enabled);
 #endif
-- 
2.43.0


