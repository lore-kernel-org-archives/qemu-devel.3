Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3897CD98E2
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE47-0002bk-D3; Mon, 15 Jun 2026 16:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZE45-0002Q8-58
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:37:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZE42-00027m-TI
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:37:48 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIx6Jf860994
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5LJaYqtl6u+
 XytPct5+BK6SqKUAJjxknsAwaAaqMSw4=; b=Vq6h7FRg3CRrftr+2CZQsMeBMjI
 at1ryKBI8n8oXSVCle8itN9zispO9Jayro0hlPFlJtXWMWa0HBC7fVruFIggdTVa
 ALdiwzwABF169TvGBlWyM73eU9IIFbR2E03CcE+AqGYNXztu2Q09B4dbjzwpjjRD
 655S6z9fV/x3mM1YQ7UVhi1pd+kAdC5G5DXRHeiWyqlEd+eHxFb7Sx4tJCqleAkI
 Lmt05WCmyVza3B8uquNiYcdCl8g/JYAMubLqCCfs59//nKUX5IZHT1xw9AVzvJL/
 y0arR1xLlXhSL/IE81NrokLjUm/T7UkmHEIkgPxocaa51VEntLtYeEX51Ng==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eteydavhy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:37:45 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ceba6ec0ccso98460356d6.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 13:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781555864; x=1782160664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5LJaYqtl6u+XytPct5+BK6SqKUAJjxknsAwaAaqMSw4=;
 b=fh0250XZkDTd6j2nVND6V/LshCa+FO51arj+wFkZDKu+8JWGnXFA4A4QohbDDeg5sQ
 I14KoKMOvAePkYeXn2SqTbOW1rSE8M1BlBalnPL6NP6xlY84MZ9OKqzmTDrpgB6MvWa3
 o5UrQlxNRsp5RlwaPdPe/mKiRVxVLX4C0rKFaKWn7d9Xn8/1vUKuN4gQRSV0+M1y1huj
 Q/1DiEzbiZe0SOwoom47ZK76lxrdbhjfOncA6Hl0vzllteb0oK8y3OCRSaSH3VWptJ6D
 qNtU4HKvpbCL9vK/LRAJc7hHPtsTGm8e/NlII4KoUDaIzGZG3I2hE9KC8fJzI5mgmtzn
 lf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781555864; x=1782160664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5LJaYqtl6u+XytPct5+BK6SqKUAJjxknsAwaAaqMSw4=;
 b=Luhz8gqLl5u92VM8WahAJWi+kyqd64qwri+D3gEbhHz/cJEN6Bdv7Cw+D9uk/QQSqp
 BcbJ84vnvjMnAsp57dkQMv3nQSbHLYAzIOeLDo7h+OHB6b0vv0J32sJqQq/GuucilLi1
 kv76K+AhfqmBOQoRt6Rm2SXk3Zw1d6IvzDLyxbdG4IBEVaEw/EhF80Owr5I5d+FsnN/p
 SnQPTO0Vml+Wc9Au47v8m8lts6O/WOo8ZKfHX8N+bap+cdOJPpwDh8lkpJKUiSu0zg3s
 vJK+Q2/t5ixSGB/LqQZNtQ5mLFUasi4IId1gIOb11sqxrgmuK4NMZ6FJU5jH+yA14CFF
 olRw==
X-Gm-Message-State: AOJu0YyTl9s3CrS8iwFN5M/tBEfE2Z4GAHlVevVr3MeKorjaILnNxDxZ
 oZYl4KHD2Fmy+kYRZOHw8DxGNLL1fSibsGRWkU41jz9iyvUcnEvs4A7XZHWZJV7u0eAKfQixtga
 KohbHI3S54iqnyzdBj8oCpECChaQZkAU04NX5BPpGTCmgI+HLqXXLVcFAyH9M0rFC1w==
X-Gm-Gg: Acq92OHMyye027jNvRsa+yFGJsewhMoZRtVmIYbF6hge267BXW0XQjzydFqcBuknTxE
 aHaho+JwjexuXx1Z2MGMRgq8dCzU0dK7udVFZxoitwC2OGA48QKACmSa7uAtQCGoDd6caxhaJ3q
 +VDi/JN+9OEytENBthgGuHU9srmj25aSTGDPmorEb0yN8k4rd/D+tWfEHxtjjjEqHtlUKaYCJo9
 +tpG9js2h8s2Agh8bX/hXvnJ+hGcicO9/GWucSTTnFetX7nfxvP/ZwBIDDL3OI9z90PoUEVMPoR
 rxfH4QMuB1Pq6HP3ycIf2I2mxR/8HO9tmpDH1QdBT4hRlto31S0Y26rAFGmxxIxnF5R/YXwIWuw
 ZP4IbQ4RbZU2PyLfsPr0rPraneUsjKTTngITPlN+4N3HjbUF6NILnrhrc2UI=
X-Received: by 2002:a05:6214:f0a:b0:8a5:104b:e37b with SMTP id
 6a1803df08f44-8d4502aed80mr212503386d6.42.1781555864288; 
 Mon, 15 Jun 2026 13:37:44 -0700 (PDT)
X-Received: by 2002:a05:6214:f0a:b0:8a5:104b:e37b with SMTP id
 6a1803df08f44-8d4502aed80mr212503056d6.42.1781555863870; 
 Mon, 15 Jun 2026 13:37:43 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d9f4740fbasm9749906d6.29.2026.06.15.13.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 13:37:43 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 02/13] hw/riscv: add fdt-common helper
Date: Mon, 15 Jun 2026 17:37:22 -0300
Message-ID: <20260615203734.954428-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
References: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: t6bhbCQsbf6KeuJvnzaMn7M8HAnqL0z4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIxOCBTYWx0ZWRfX3CIF2Vl9tpoL
 rLSNGBT8wbjhZYR67qMs0zHfY66chJakxsyrRwbRJUXDEHeqzmKHNNhTwlnYBUL+esjlDwyVSta
 M/N9HL/FW0+PxKMnK9kHGU/8DLywzBs=
X-Authority-Analysis: v=2.4 cv=QrJuG1yd c=1 sm=1 tr=0 ts=6a306299 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=u1ybqLB28KXXVxpIts0A:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: t6bhbCQsbf6KeuJvnzaMn7M8HAnqL0z4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIxOCBTYWx0ZWRfX4UBVIu7bBdVj
 PUf/xe6JoRqoKa38zxjXit+bxCpmjAh/e5avd1L3hhHEbu9d6QnpCJv1BltwP8ljVHzu/xTU2Vg
 LoHyOGQecjDnZBmvh8lmU8Njo2GXaU0KRTHrGYo+gA9iwURs/gXmKQNQUas+dawt4mWsPG4CWCD
 9HRVmBJhgaBX3r/RmwF4Khgn26uvqL3uj26opa+3CyOpLdWc5aWeWDGJtBD7gY/ODMYMqqiqsim
 kVW+d/BgTrx02VavwazkhHh/8vpCWp6mxtcsAOVeCC5fXxkFvnwafd1JrMhNhZPmSbXyZ2DBH67
 v/SeKbQMtAsuKL9pycNEkAB5bCUp45+tNF0RSzATW0uYFyq+U1zICrKb0ZgrhIJIIftJr70EOnm
 X4KbXyMZ3O/HrXIZyTXUzJSogQkXtYAObxKfut7o3hMP3eDXIIGAZ96s9IyIrNOGwlBfAU5JfFh
 yLjn7GkLm4xCmZDX/2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150218
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

There's too much duplication between RISC-V boards and one of the most
common culprits is the FDT functions.

Add a new file for board FDT helpers.  Start by creating a helper that
initializes the FDT and init it with the common board boilerplate.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 37 +++++++++++++++++++++++++++++++++++
 hw/riscv/meson.build          |  1 +
 hw/riscv/sifive_u.c           | 20 +++----------------
 hw/riscv/spike.c              | 19 +++---------------
 hw/riscv/virt.c               | 19 +++---------------
 include/hw/riscv/fdt-common.h | 14 +++++++++++++
 6 files changed, 61 insertions(+), 49 deletions(-)
 create mode 100644 hw/riscv/fdt-common.c
 create mode 100644 include/hw/riscv/fdt-common.h

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
new file mode 100644
index 0000000000..b155246998
--- /dev/null
+++ b/hw/riscv/fdt-common.c
@@ -0,0 +1,37 @@
+/*
+ * RISC-V board helpers for FDT generation.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/error-report.h"
+#include "system/device_tree.h"
+#include "hw/riscv/fdt-common.h"
+
+void *create_board_device_tree(const char *model, const char *compatible,
+                               int *fdt_size)
+{
+    void *fdt = create_device_tree(fdt_size);
+
+    if (!fdt) {
+        error_report("create_device_tree() failed");
+        exit(1);
+    }
+
+    qemu_fdt_setprop_string(fdt, "/", "model", model);
+    qemu_fdt_setprop_string(fdt, "/", "compatible", compatible);
+    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
+    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
+
+    qemu_fdt_add_subnode(fdt, "/soc");
+    qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
+    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "simple-bus");
+    qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
+    qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
+
+    return fdt;
+}
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 533472e22a..f19db0dd7f 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -1,5 +1,6 @@
 riscv_ss = ss.source_set()
 riscv_ss.add(files('boot.c'))
+riscv_ss.add(files('fdt-common.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
 riscv_ss.add(files('riscv_hart.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 3abbd6c823..5d3b2751ad 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -52,6 +52,7 @@
 #include "hw/riscv/sifive_u.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/machines-qom.h"
+#include "hw/riscv/fdt-common.h"
 #include "hw/char/sifive_uart.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
@@ -112,23 +113,8 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         "sifive,plic-1.0.0", "riscv,plic0"
     };
 
-    fdt = ms->fdt = create_device_tree(&s->fdt_size);
-    if (!fdt) {
-        error_report("create_device_tree() failed");
-        exit(1);
-    }
-
-    qemu_fdt_setprop_string(fdt, "/", "model", "SiFive HiFive Unleashed A00");
-    qemu_fdt_setprop_string(fdt, "/", "compatible",
-                            "sifive,hifive-unleashed-a00");
-    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
-    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
-
-    qemu_fdt_add_subnode(fdt, "/soc");
-    qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
-    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "simple-bus");
-    qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
-    qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
+    fdt = ms->fdt = create_board_device_tree("SiFive HiFive Unleashed A00",
+        "sifive,hifive-unleashed-a00", &s->fdt_size);
 
     hfclk_phandle = phandle++;
     nodename = g_strdup_printf("/hfclk");
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index f9d00e0d5c..79c9bb041f 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -32,6 +32,7 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/spike.h"
 #include "hw/riscv/boot.h"
+#include "hw/riscv/fdt-common.h"
 #include "hw/riscv/numa.h"
 #include "hw/riscv/machines-qom.h"
 #include "hw/char/riscv_htif.h"
@@ -66,16 +67,8 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
         "sifive,clint0", "riscv,clint0"
     };
 
-    fdt = ms->fdt = create_device_tree(&fdt_size);
-    if (!fdt) {
-        error_report("create_device_tree() failed");
-        exit(1);
-    }
-
-    qemu_fdt_setprop_string(fdt, "/", "model", "ucbbar,spike-bare,qemu");
-    qemu_fdt_setprop_string(fdt, "/", "compatible", "ucbbar,spike-bare-dev");
-    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
-    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
+    fdt = ms->fdt = create_board_device_tree("ucbbar,spike-bare,qemu",
+        "ucbbar,spike-bare-dev", &fdt_size);
 
     qemu_fdt_add_subnode(fdt, "/htif");
     qemu_fdt_setprop_string(fdt, "/htif", "compatible", "ucb,htif0");
@@ -84,12 +77,6 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
             0x0, memmap[SPIKE_HTIF].base, 0x0, memmap[SPIKE_HTIF].size);
     }
 
-    qemu_fdt_add_subnode(fdt, "/soc");
-    qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
-    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "simple-bus");
-    qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
-    qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
-
     qemu_fdt_add_subnode(fdt, "/cpus");
     qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
         RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 0c489bb412..cb1d83fd48 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -36,6 +36,7 @@
 #include "hw/riscv/riscv-iommu-bits.h"
 #include "hw/riscv/virt.h"
 #include "hw/riscv/boot.h"
+#include "hw/riscv/fdt-common.h"
 #include "hw/riscv/machines-qom.h"
 #include "hw/riscv/numa.h"
 #include "kvm/kvm_riscv.h"
@@ -1150,22 +1151,8 @@ static void create_fdt(RISCVVirtState *s)
     uint8_t rng_seed[32];
     g_autofree char *name = NULL;
 
-    ms->fdt = create_device_tree(&s->fdt_size);
-    if (!ms->fdt) {
-        error_report("create_device_tree() failed");
-        exit(1);
-    }
-
-    qemu_fdt_setprop_string(ms->fdt, "/", "model", "riscv-virtio,qemu");
-    qemu_fdt_setprop_string(ms->fdt, "/", "compatible", "riscv-virtio");
-    qemu_fdt_setprop_cell(ms->fdt, "/", "#size-cells", 0x2);
-    qemu_fdt_setprop_cell(ms->fdt, "/", "#address-cells", 0x2);
-
-    qemu_fdt_add_subnode(ms->fdt, "/soc");
-    qemu_fdt_setprop(ms->fdt, "/soc", "ranges", NULL, 0);
-    qemu_fdt_setprop_string(ms->fdt, "/soc", "compatible", "simple-bus");
-    qemu_fdt_setprop_cell(ms->fdt, "/soc", "#size-cells", 0x2);
-    qemu_fdt_setprop_cell(ms->fdt, "/soc", "#address-cells", 0x2);
+    ms->fdt = create_board_device_tree("riscv-virtio,qemu", "riscv-virtio",
+                                       &s->fdt_size);
 
     /*
      * The "/soc/pci@..." node is needed for PCIE hotplugs
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
new file mode 100644
index 0000000000..adf9b33dfd
--- /dev/null
+++ b/include/hw/riscv/fdt-common.h
@@ -0,0 +1,14 @@
+/*
+ * RISC-V board helpers for FDT generation.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef RISCV_VIRT_FDT_H
+#define RISCV_VIRT_FDT_H
+
+void *create_board_device_tree(const char *model, const char *compatible,
+                               int *fdt_size);
+#endif
-- 
2.43.0


