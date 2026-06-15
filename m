Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B7ACD98E2
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE4W-0002xY-ST; Mon, 15 Jun 2026 16:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZE4S-0002td-Cj
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZE4P-0002B1-IV
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:12 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIx0E6883729
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VUUaj6zt+3f
 DukkFVi7zWZg2GaDQtFm9TLKwBCjxo6I=; b=TU+5Tu9gcg54sXDCrteTe8JYxud
 E7MGUV6cxSDGrSJhPci10vaSewbZ5lQt6aLw5GIJp2PTeBaD8NcQVL0EMBXpXQOe
 XqDGePgDCW1DBdfGIdMmvnK+grnUNOn37Yl8ObPh7gM0kWUr3DGTJLViRMmdfaOC
 qMM1hsSa1Y5WiSWs03SM2eX6WgD/yEgMhDYeOWNl0RVEC4y1dtsKNLAAwdW+YGOs
 nyLR7azXZzkoMEK9C8Pw70PbRW8NEs3/Z12WwyxU53K9cfvdTlDGw3Iw4ba4dgk7
 sQRRBP+Id5APgVH+HMQ1P5h6mloIb4oPO8UIStNsNcnYxpXEFgiojs0G71Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etfa72tsq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:37:57 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ccd83d58d9so55868316d6.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 13:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781555876; x=1782160676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUUaj6zt+3fDukkFVi7zWZg2GaDQtFm9TLKwBCjxo6I=;
 b=hP4gLzFfgfDxulOqjbAN6SHakPCTLE69Th1rv1zbGOYtUgiFD9L1FA3WncRWv0nnwZ
 ZzqQnt7xwufinNXC24TIdXgX7v7JWnEe1+CZTRj86OdawrVHy+DhjL8vu90v/nPFIqB1
 zxM9ypBkLOtqGORT6hh0wswqdJM7eagdRaCNdbaPJ9ePVyKQHFLf7ngPO1c1TtK99FHI
 zbZoug295gfAXTSCp1Re18+UfiyH0ZE0TQuZ2b6epg0yL51G3RmB4eEsTrvuKaJF87Un
 1GrnY1taas4rpLcILOqnUTEoSrKlwcE4QW7GustWZ9rdhla5EzHgtImQNyQTmfxVzKH9
 P0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781555876; x=1782160676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VUUaj6zt+3fDukkFVi7zWZg2GaDQtFm9TLKwBCjxo6I=;
 b=eCeW8wJfO1J3If+rpNVR4XyojRDpNpLafoIPqwzofFT86xpY0Ri1jqmiSvZ7RmVph1
 ep7TVLqRWmfbJyCx0KUU/6NIUNcrD6gw7A2XZ2W3BfjpAIhOTf18GOkiWJGKj6IelPAP
 ornpOQGcpYWk+vbrRFI4WBtF1hSQUj8OkwMJKGD6CvXF3gzmuKUG4CKirqpKlzAru4mV
 eEbG60vgr6OY+fUl91wLIyjgdFOETS3o+YSdIg1lYS2yE++uL4dwBzjK9CLzzZUPxEsU
 QBkf70/8YEja5R4aVSmhNXYlPpDG7677ZeAzdRqZdTjjEhl05RDZNxDom6S6ben2LS5z
 4r0g==
X-Gm-Message-State: AOJu0YwacWKjEjsGTMYDjG9zEQ374qu+89BQE7opIIODJl4YGJcSZoYG
 VwMy7j0scRQyY8q5TZdeJdYq0hcUYwqAUYOHzU/QcO7fwhOpHgbXiKGCJv04MmT6rIzk/T5M0Oq
 0sT62e3hANwWh/0NYWm5ynH5Spq4cI5Lu0VLSoRv1tKoqNd3lMt5hVk+p4+DCTqfoDw==
X-Gm-Gg: Acq92OETFid4upI40IIXKcpCUEegYqiSWiN8Roc3wO2vlDsczsvNXFSSJxvdd9QczSW
 3PptN7rnV77bQGEaSOCG9AH7lIL1eZx+xPmcRiP9RH+tcZ5FI1znyJ31YA+gYUjL/ProK03slY9
 2BnWGK/iY8IJyaothIP7rpa8YEBkq9Y7TPGGty+7cL0hwAfEuiHIgn5yVUAZHZgXnaGafUaBPiP
 +3Th1NaTOqUvpbRONJlYPcE27tgzRCgtRW8rWW8PnqdG7mp6JvC/gx5gNYVnKix3itv3T/Q+kIL
 yX5v3IuKaWTh7qkfy0fV8gyMOYHw+JMWxocqbzWXREpMT6jaNfbEgaYvBeE93J+9lUON3XQhxp+
 VmCdf6so5G1FWoNgZP+7EXTN8/31+uvt6ZGkiQA4f/E9Myrg1oJWlm/AkT/Y=
X-Received: by 2002:a05:6214:434a:b0:8cc:f3e0:87fd with SMTP id
 6a1803df08f44-8da1dbd5913mr11255156d6.8.1781555876230; 
 Mon, 15 Jun 2026 13:37:56 -0700 (PDT)
X-Received: by 2002:a05:6214:434a:b0:8cc:f3e0:87fd with SMTP id
 6a1803df08f44-8da1dbd5913mr11254696d6.8.1781555875740; 
 Mon, 15 Jun 2026 13:37:55 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d9f4740fbasm9749906d6.29.2026.06.15.13.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 13:37:55 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 07/13] hw/riscv: add create_fdt_clint() helper
Date: Mon, 15 Jun 2026 17:37:27 -0300
Message-ID: <20260615203734.954428-8-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
References: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GsE8HYuRa8QlVzMrSDvR8USkbjXvMlHb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIxOCBTYWx0ZWRfX1Fdx9eQib78U
 kLYPZldLgn98OZ3B+tED+2SUQJLMHnW6pZMo+IULegrfGl3DjZWdBhRqgy2POdPuYlSiS05vE7C
 7pwMfJZpI4d6eed+dSqUV7t3Llv/W+w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIxOCBTYWx0ZWRfX6RX7rAe7GppA
 f6bWhug0NI793Vgg++qfm9lax1NHrbB18IleyDuSRGAQVQK7nzqVDfFwRPPynFP96SSdbiNwU1j
 nEtDpbhY+HNuwdFp67jWi+qpxEJHMtdNfQ+e/80X3TPMBlpTfwoA3Nww8w07lK/gTZiws64pFPS
 pxCJQ2oWZ/Tlim7KeVQTNmzJ4UYqZyXKlLVYyZFkQLC2TTx5Jf4HxfCtHc1SlPpBoNXFZxZPFz3
 YK29uz1Cb3RYwIC7AI6aZqenQ+e5aOhE7kmOOIUQnr2A8zR00ELJdRgOHvxYWCW/9q7uo9tulyn
 wq6fQEiJozvI944gcPs7E4i6uyv057TBhcyE6az6Iowdj61yMfvc834eWwUMbx/urZ8NRTe29XI
 gdLn2aXM1/10n3/qsUdHaxZX/CIopm4rr+dypRddRnVpHNaC7IyoQNQ0UbZYj4FsUMRPwXJHYiC
 X8hhuf3W1JeX9fUhgYw==
X-Proofpoint-GUID: GsE8HYuRa8QlVzMrSDvR8USkbjXvMlHb
X-Authority-Analysis: v=2.4 cv=AN2yTM5Z c=1 sm=1 tr=0 ts=6a3062a5 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=ZWw3GhFu8BCHsFC3ebIA:9 a=1HOtulTD9v-eNWfpl4qZ:22
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Move all clint FDT generation to fdt-common.c reducing code repetition.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 33 +++++++++++++++++++++++++
 hw/riscv/sifive_u.c           | 25 +++----------------
 hw/riscv/spike.c              | 31 ++++-------------------
 hw/riscv/virt.c               | 46 ++++++-----------------------------
 include/hw/riscv/fdt-common.h |  5 ++++
 5 files changed, 54 insertions(+), 86 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 719c36e001..d2661ec389 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -12,6 +12,7 @@
 #include "system/device_tree.h"
 #include "hw/core/boards.h"
 #include "hw/riscv/fdt-common.h"
+#include "target/riscv/cpu_bits.h"
 
 void *create_board_device_tree(const char *model, const char *compatible,
                                int *fdt_size)
@@ -50,3 +51,35 @@ void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
         qemu_fdt_setprop_cell(fdt, mem_name, "numa-node-id", socket_id);
     }
 }
+
+void create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
+                             int socket_id, uint32_t *intc_phandles,
+                             int num_harts, bool numa_enabled)
+{
+    g_autofree uint32_t *clint_cells = g_new0(uint32_t, num_harts * 4);
+    g_autofree char *clint_name = NULL;
+    static const char * const clint_compat[2] = {
+        "sifive,clint0", "riscv,clint0"
+    };
+
+    for (int cpu = 0; cpu < num_harts; cpu++) {
+        clint_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
+        clint_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
+        clint_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
+        clint_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
+    }
+
+    clint_name = g_strdup_printf("/soc/clint@%"HWADDR_PRIx, addr);
+    qemu_fdt_add_subnode(fdt, clint_name);
+    qemu_fdt_setprop_string_array(fdt, clint_name, "compatible",
+                                  (char **)&clint_compat,
+                                  ARRAY_SIZE(clint_compat));
+    qemu_fdt_setprop_sized_cells(fdt, clint_name, "reg",
+                                 2, addr, 2, size);
+    qemu_fdt_setprop(fdt, clint_name, "interrupts-extended",
+                     clint_cells, num_harts * sizeof(uint32_t) * 4);
+
+    if (numa_enabled) {
+        qemu_fdt_setprop_cell(fdt, clint_name, "numa-node-id", socket_id);
+    }
+}
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ce86989bc8..9a791b36d6 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -105,9 +105,6 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     uint32_t plic_phandle, prci_phandle, gpio_phandle, phandle = 1;
     uint32_t hfclk_phandle, rtcclk_phandle, phy_phandle;
     static const char * const ethclk_names[2] = { "pclk", "hclk" };
-    static const char * const clint_compat[2] = {
-        "sifive,clint0", "riscv,clint0"
-    };
     static const char * const plic_compat[2] = {
         "sifive,plic-1.0.0", "riscv,plic0"
     };
@@ -180,25 +177,9 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         g_free(nodename);
     }
 
-    cells =  g_new0(uint32_t, ms->smp.cpus * 4);
-    for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
-        cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
-        cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
-        cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
-        cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
-    }
-    nodename = g_strdup_printf("/soc/clint@%lx",
-        (long)memmap[SIFIVE_U_DEV_CLINT].base);
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_string_array(fdt, nodename, "compatible",
-        (char **)&clint_compat, ARRAY_SIZE(clint_compat));
-    qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        0x0, memmap[SIFIVE_U_DEV_CLINT].base,
-        0x0, memmap[SIFIVE_U_DEV_CLINT].size);
-    qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
-        cells, ms->smp.cpus * sizeof(uint32_t) * 4);
-    g_free(cells);
-    g_free(nodename);
+    create_fdt_socket_clint(fdt, memmap[SIFIVE_U_DEV_CLINT].base,
+                            memmap[SIFIVE_U_DEV_CLINT].size, 0,
+                            intc_phandles, ms->smp.cpus, false);
 
     nodename = g_strdup_printf("/soc/otp@%lx",
         (long)memmap[SIFIVE_U_DEV_OTP].base);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 82005ec163..b15188fb07 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -58,13 +58,10 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
     unsigned long clint_addr;
     int cpu, socket;
     MachineState *ms = MACHINE(s);
-    uint32_t *clint_cells;
     uint32_t cpu_phandle, phandle = 1;
-    char *clint_name, *clust_name;
+    char *clust_name;
     char *core_name, *cpu_name, *intc_name;
-    static const char * const clint_compat[2] = {
-        "sifive,clint0", "riscv,clint0"
-    };
+    bool numa_enabled = riscv_numa_enabled(ms);
 
     fdt = ms->fdt = create_board_device_tree("ucbbar,spike-bare,qemu",
         "ucbbar,spike-bare-dev", &fdt_size);
@@ -136,29 +133,11 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
         create_fdt_socket_memory(fdt, memaddr, memsize, socket,
                                  riscv_numa_enabled(ms));
 
-        clint_cells =  g_new0(uint32_t, s->soc[socket].num_harts * 4);
-
-        for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
-            clint_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
-            clint_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
-            clint_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
-            clint_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
-        }
-
         clint_addr = memmap[SPIKE_CLINT].base +
             (memmap[SPIKE_CLINT].size * socket);
-        clint_name = g_strdup_printf("/soc/clint@%lx", clint_addr);
-        qemu_fdt_add_subnode(fdt, clint_name);
-        qemu_fdt_setprop_string_array(fdt, clint_name, "compatible",
-            (char **)&clint_compat, ARRAY_SIZE(clint_compat));
-        qemu_fdt_setprop_cells(fdt, clint_name, "reg",
-            0x0, clint_addr, 0x0, memmap[SPIKE_CLINT].size);
-        qemu_fdt_setprop(fdt, clint_name, "interrupts-extended",
-            clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
-        riscv_socket_fdt_write_id(ms, clint_name, socket);
-
-        g_free(clint_name);
-        g_free(clint_cells);
+        create_fdt_socket_clint(fdt, clint_addr, memmap[SPIKE_CLINT].size,
+                                socket, intc_phandles,
+                                s->soc[socket].num_harts, numa_enabled);
         g_free(clust_name);
     }
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index df3eadef78..b134f11266 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -302,42 +302,6 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
     }
 }
 
-static void create_fdt_socket_clint(RISCVVirtState *s,
-                                    int socket,
-                                    uint32_t *intc_phandles)
-{
-    int cpu;
-    g_autofree char *clint_name = NULL;
-    g_autofree uint32_t *clint_cells = NULL;
-    hwaddr clint_addr;
-    MachineState *ms = MACHINE(s);
-    static const char * const clint_compat[2] = {
-        "sifive,clint0", "riscv,clint0"
-    };
-
-    clint_cells = g_new0(uint32_t, s->soc[socket].num_harts * 4);
-
-    for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
-        clint_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
-        clint_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
-        clint_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
-        clint_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
-    }
-
-    clint_addr = s->memmap[VIRT_CLINT].base +
-                 s->memmap[VIRT_CLINT].size * socket;
-    clint_name = g_strdup_printf("/soc/clint@%"HWADDR_PRIx, clint_addr);
-    qemu_fdt_add_subnode(ms->fdt, clint_name);
-    qemu_fdt_setprop_string_array(ms->fdt, clint_name, "compatible",
-                                  (char **)&clint_compat,
-                                  ARRAY_SIZE(clint_compat));
-    qemu_fdt_setprop_sized_cells(ms->fdt, clint_name, "reg",
-        2, clint_addr, 2, s->memmap[VIRT_CLINT].size);
-    qemu_fdt_setprop(ms->fdt, clint_name, "interrupts-extended",
-        clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
-    riscv_socket_fdt_write_id(ms, clint_name, socket);
-}
-
 static void create_fdt_socket_aclint(RISCVVirtState *s,
                                      int socket,
                                      uint32_t *intc_phandles)
@@ -728,6 +692,7 @@ static void create_fdt_sockets(RISCVVirtState *s,
     uint32_t xplic_phandles[MAX_NODES];
     g_autofree uint32_t *intc_phandles = NULL;
     int socket_count = riscv_socket_count(ms);
+    bool numa_enabled = riscv_numa_enabled(ms);
 
     qemu_fdt_add_subnode(ms->fdt, "/cpus");
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
@@ -762,8 +727,13 @@ static void create_fdt_sockets(RISCVVirtState *s,
             create_fdt_socket_aclint(s, socket,
                                      &intc_phandles[phandle_pos]);
         } else if (tcg_enabled()) {
-            create_fdt_socket_clint(s, socket,
-                                    &intc_phandles[phandle_pos]);
+            hwaddr clintaddr = s->memmap[VIRT_CLINT].base +
+                               s->memmap[VIRT_CLINT].size * socket;
+
+            create_fdt_socket_clint(ms->fdt, clintaddr,
+                                    s->memmap[VIRT_CLINT].size,
+                                    socket, &intc_phandles[phandle_pos],
+                                    s->soc[socket].num_harts, numa_enabled);
         }
     }
 
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 81689f418b..6e81d6cd6c 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -13,4 +13,9 @@ void *create_board_device_tree(const char *model, const char *compatible,
                                int *fdt_size);
 void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
                               int socket_id, bool numa_enabled);
+void create_fdt_clint(void *fdt, hwaddr addr, uint64_t size,
+                      uint32_t *intc_phandles, int num_harts);
+void create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
+                             int socket_id, uint32_t *intc_phandles,
+                             int num_harts, bool numa_enabled);
 #endif
-- 
2.43.0


