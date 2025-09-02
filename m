Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833ABCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI2a-0007LG-II; Mon, 01 Sep 2025 23:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2N-0006b3-Kv
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2K-0004w9-J5
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:27 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822TL7O017357
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LsJ1LXtFQjKlVRm2VA8fsf5sAhwAw/Q3j5jrOxqGFCM=; b=fVTA9IjHb8hZx7xt
 pO1p16n/AlB2jRJuw6xZGoGOlt63Ebfott0r3z6Y/aT1WPV3Jqzs3r/5Ggu7WE0x
 SqdlfbwiqFhehhNBDC2Ng5ljSKOVEu+0cvoxeKSPVlWdvvKOQ6xjNL4PprBYg8XR
 kuzr7NmKepBJglk28ap8QbzPmW8UUBMslhGLeWEfohfsZvzCeKOXZRMVYHw8KiXB
 tFZPvNkBACqpSIxBrEO0HYPmAjAlkcCyNl7h6SLaUfTMwNDyMvGJpaqOWiaE1M+V
 ORuwaa7m589kJcWWh8gXfSd0I94Nffmsk9dOD9OO1nuPiHB26Dfm/UGPlTYN6+Zw
 Zl4gfg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urvyxdnv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:50:12 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-329e375d372so274521a91.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785011; x=1757389811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LsJ1LXtFQjKlVRm2VA8fsf5sAhwAw/Q3j5jrOxqGFCM=;
 b=LsveSSsBOQrDtsAQPJxPUnZpB2eEhbqziO5FoY00dsPXIiXcFNk28AKAhsoHvgkfYN
 5QEbiKkyFcgJ2Ghk/Evu3eSo77mlvs4gcd+ye0h7rXhwoSqNRV3tttoRxwPoQVNPCfj7
 G9yrtyce0t/nVjvV80IPsMy5LfLvNAMQuYZ//yrHQ+WRdNmGzfBwo+OFPHRitCj8OQN2
 Kox4odA7dEho9vbWkb5McrDnnzDrebv95HVr59ERpwFZqdAf3wIpQGW6RGR0Rs2NIPWS
 VOseGD3vmHeJj37BNvBnaqNcn7j4P6EWQnt0eoATxEBhuT/NUWrdPujWfP0i/Zz0CsH/
 LEGQ==
X-Gm-Message-State: AOJu0YzKOE8Kl5G1PWKYuj68Tc1iCRgoaYpH92mKcyAiI/rReV2b53x2
 UCSFVI+lLvI6db43q2v9EK/tRlV2v0r1TWJopVSfLtWaSv53VhuVVUMo4bIc4UQ2EQn5m1jozSE
 54PEbCd0FD8DmqG5nyBMp3arhJZGzDgObIkRAGrhnZaFv3EEr2hbJZkbJWNzSTSRXOS/b
X-Gm-Gg: ASbGncsyvJTOnoa3Wao9diBO2/fHAfSFBG3JvqFi3pKMmkgoF97lYbQFKreeyPCYoDP
 JMzjDo2ws1s0FK+clG39bRX7Kk/eaO9U5wrcPh3/xRb5VXU7dlmkSqYfFi/5QeEcBpl7i37KXVP
 GHrF2oD1wCr4mA5DuPeeJn2QueNwq6DYGN3pbckAMZFXS06HbrzOffGe+loTg+5EnT2aVCqMB0D
 V/q6H5StEio1k0gkDoawTnHxIrJa9bmOeDQjGzutAeDvlcLza15WUMS78kpuFwdB3cUL+jgAjK5
 wL1ghG4RookY6+f/9H/99FqCBZqjIECPQFj5EEngicLx7BbDAqalqZ66068/Fv82ytekuxRVKiw
 cxjqIzPrLEZwO
X-Received: by 2002:a17:90b:17cb:b0:327:ea30:b with SMTP id
 98e67ed59e1d1-328156baa8bmr14470573a91.18.1756785011220; 
 Mon, 01 Sep 2025 20:50:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkgb+jPbjDZWShsFLpXUtyKQGDkElNkrvO1PE81LjIGgqrVU5E0iEPEcnVJ/AiJgVFYmaZLQ==
X-Received: by 2002:a17:90b:17cb:b0:327:ea30:b with SMTP id
 98e67ed59e1d1-328156baa8bmr14470519a91.18.1756785010564; 
 Mon, 01 Sep 2025 20:50:10 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327c5fc5055sm14117932a91.14.2025.09.01.20.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:50:10 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 08/11] hw/hexagon: Define hexagon "virt" machine
Date: Mon,  1 Sep 2025 20:49:48 -0700
Message-Id: <20250902034951.1948194-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
References: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ovW6fqM6eWTY6Y7qtHcuSFioIhKXoHZJ
X-Proofpoint-ORIG-GUID: ovW6fqM6eWTY6Y7qtHcuSFioIhKXoHZJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX12ztyh5P1Olx
 1NFTUABAo31sf3URfk40G3YTaidPJAsVr8wpHn6iPqrfsMO8HQnt+mCfA94ggIrBdp1z73anhFb
 vZKoaNHUd1AIptz2A1o9OXex9FJiPy6MmWeNUNXu5mJh6GjKrOsNWKaYBlUb/wZoSzegRl/u+kW
 x0fSDUqoNucDuIc/bOLjmFO6gAf1Hv9Al1Fb8b8ljDNobhZCwNs2B+KIPhC3XACxSeoYea+bg1k
 iN4mT/fQTKXlg5qDeR70MHtRDIkjXq8fnxsX64EhExtfZRdWPZSGDclndY4t0WiJ5Mce3F1kqE2
 HEY2p3DGiRZhcnYARP8Gp023l67Xp+afsYpv0oS1O1i4GCnDX1p8l7/xW/sS6A5UHh0lP6bAuOp
 LWVZLUiQ
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b66974 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=6WAqP26IpYyNH_cq97EA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Brian Cain <bcain@quicinc.com>

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 configs/devices/hexagon-softmmu/default.mak |   1 +
 configs/targets/hexagon-softmmu.mak         |   1 +
 include/hw/hexagon/virt.h                   |  43 ++
 hw/hexagon/virt.c                           | 435 ++++++++++++++++++++
 hw/hexagon/Kconfig                          |  10 +
 hw/hexagon/meson.build                      |   2 +
 tests/qemu-iotests/testenv.py               |   1 +
 7 files changed, 493 insertions(+)
 create mode 100644 include/hw/hexagon/virt.h
 create mode 100644 hw/hexagon/virt.c

diff --git a/configs/devices/hexagon-softmmu/default.mak b/configs/devices/hexagon-softmmu/default.mak
index 08e709aea7..37b4f9f323 100644
--- a/configs/devices/hexagon-softmmu/default.mak
+++ b/configs/devices/hexagon-softmmu/default.mak
@@ -3,5 +3,6 @@
 # Uncomment the following lines to disable these optional devices:
 
 # Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_HEX_VIRT=y
 # CONFIG_HEX_DSP=y
 # CONFIG_L2VIC=y
diff --git a/configs/targets/hexagon-softmmu.mak b/configs/targets/hexagon-softmmu.mak
index 8c208bf468..9f8fca1dc1 100644
--- a/configs/targets/hexagon-softmmu.mak
+++ b/configs/targets/hexagon-softmmu.mak
@@ -4,3 +4,4 @@ TARGET_ARCH=hexagon
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES=gdb-xml/hexagon-core.xml gdb-xml/hexagon-hvx.xml gdb-xml/hexagon-sys.xml
 TARGET_LONG_BITS=32
+TARGET_NEED_FDT=y
diff --git a/include/hw/hexagon/virt.h b/include/hw/hexagon/virt.h
new file mode 100644
index 0000000000..0c92fb3bb8
--- /dev/null
+++ b/include/hw/hexagon/virt.h
@@ -0,0 +1,43 @@
+/*
+ * Definitions for hexagon virt board.
+ *
+ * Copyright (c) 2024-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_HEXAGONVIRT_H
+#define HW_HEXAGONVIRT_H
+
+#include "hw/boards.h"
+#include "target/hexagon/cpu.h"
+
+struct HexagonVirtMachineState {
+    /*< private >*/
+    MachineState parent_obj;
+
+    int fdt_size;
+    MemoryRegion *sys;
+    MemoryRegion cfgtable;
+    MemoryRegion ram;
+    MemoryRegion tcm;
+    MemoryRegion vtcm;
+    MemoryRegion bios;
+    DeviceState *l2vic;
+    Clock *apb_clk;
+};
+
+void hexagon_load_fdt(const struct HexagonVirtMachineState *vms);
+
+enum {
+    VIRT_UART0,
+    VIRT_QTMR0,
+    VIRT_QTMR1,
+    VIRT_GPT,
+    VIRT_MMIO,
+    VIRT_FDT,
+};
+
+#define TYPE_HEXAGON_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
+OBJECT_DECLARE_SIMPLE_TYPE(HexagonVirtMachineState, HEXAGON_VIRT_MACHINE)
+
+#endif /* HW_HEXAGONVIRT_H */
diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
new file mode 100644
index 0000000000..615fde773d
--- /dev/null
+++ b/hw/hexagon/virt.c
@@ -0,0 +1,435 @@
+/*
+ * Hexagon virt emulation
+ *
+ * Copyright (c) 2024-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hexagon/virt.h"
+#include "elf.h"
+#include "hw/char/pl011.h"
+#include "hw/clock.h"
+#include "hw/core/sysbus-fdt.h"
+#include "hw/hexagon/hexagon.h"
+#include "hw/hexagon/hexagon_globalreg.h"
+#include "hw/loader.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-clock.h"
+#include "hw/register.h"
+#include "qemu/error-report.h"
+#include "qemu/guest-random.h"
+#include "qemu/units.h"
+#include "elf.h"
+#include "machine_cfg_v68n_1024.h.inc"
+#include "system/address-spaces.h"
+#include "system/device_tree.h"
+#include "system/reset.h"
+#include "system/system.h"
+#include <libfdt.h>
+
+static const int VIRTIO_DEV_COUNT = 8;
+
+static const MemMapEntry base_memmap[] = {
+    [VIRT_UART0] = { 0x10000000, 0x00000200 },
+    [VIRT_MMIO] = { 0x11000000, 0x1000000, },
+    [VIRT_GPT] = { 0xab000000, 0x00001000 },
+    [VIRT_FDT] = { 0x99800000, 0x00400000 },
+};
+
+static const int irqmap[] = {
+    [VIRT_MMIO] = 18, /* ...to 18 + VIRTIO_DEV_COUNT - 1 */
+    [VIRT_GPT] = 12,
+    [VIRT_UART0] = 15,
+    [VIRT_QTMR0] = 2,
+    [VIRT_QTMR1] = 4,
+};
+
+
+static void create_fdt(HexagonVirtMachineState *vms)
+{
+    MachineState *ms = MACHINE(vms);
+    void *fdt = create_device_tree(&vms->fdt_size);
+
+    if (!fdt) {
+        error_report("create_device_tree() failed");
+        exit(1);
+    }
+
+    ms->fdt = fdt;
+
+    qemu_fdt_setprop_string(fdt, "/", "compatible", "linux,hexagon-virt");
+    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
+    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x1);
+    qemu_fdt_setprop_string(fdt, "/", "model", "linux,hexagon-virt");
+
+    qemu_fdt_setprop_string(fdt, "/", "model", "hexagon-virt,qemu");
+    qemu_fdt_setprop_string(fdt, "/", "compatible", "qcom,sm8150");
+
+    qemu_fdt_add_subnode(fdt, "/soc");
+    qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
+    qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x1);
+    qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
+
+    qemu_fdt_add_subnode(fdt, "/chosen");
+
+    uint8_t rng_seed[32];
+    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
+    qemu_fdt_setprop(fdt, "/chosen", "rng-seed", rng_seed, sizeof(rng_seed));
+}
+
+static void fdt_add_hvx(HexagonVirtMachineState *vms,
+                        const hexagon_machine_config *m_cfg, Error **errp)
+{
+    const MachineState *ms = MACHINE(vms);
+    uint32_t vtcm_size_bytes = m_cfg->cfgtable.vtcm_size_kb * 1024;
+    if (vtcm_size_bytes > 0) {
+        memory_region_init_ram(&vms->vtcm, NULL, "vtcm.ram", vtcm_size_bytes,
+                               errp);
+        memory_region_add_subregion(vms->sys, m_cfg->cfgtable.vtcm_base << 16,
+                                    &vms->vtcm);
+
+        qemu_fdt_add_subnode(ms->fdt, "/soc/vtcm");
+        qemu_fdt_setprop_string(ms->fdt, "/soc/vtcm", "compatible",
+                                "qcom,hexagon_vtcm");
+
+        assert(sizeof(m_cfg->cfgtable.vtcm_base) == sizeof(uint32_t));
+        qemu_fdt_setprop_cells(ms->fdt, "/soc/vtcm", "reg", 0,
+                               m_cfg->cfgtable.vtcm_base << 16,
+                               vtcm_size_bytes);
+    }
+
+    if (m_cfg->cfgtable.ext_contexts > 0) {
+        qemu_fdt_add_subnode(ms->fdt, "/soc/hvx");
+        qemu_fdt_setprop_string(ms->fdt, "/soc/hvx", "compatible",
+                                "qcom,hexagon-hvx");
+        qemu_fdt_setprop_cells(ms->fdt, "/soc/hvx", "qcom,hvx-max-ctxts",
+                               m_cfg->cfgtable.ext_contexts);
+        qemu_fdt_setprop_cells(ms->fdt, "/soc/hvx", "qcom,hvx-vlength",
+                               m_cfg->cfgtable.hvx_vec_log_length);
+    }
+}
+
+static int32_t irq_hvm_ic_phandle = -1;
+static void fdt_add_hvm_pic_node(HexagonVirtMachineState *vms,
+                                 const hexagon_machine_config *m_cfg)
+{
+    MachineState *ms = MACHINE(vms);
+    irq_hvm_ic_phandle = qemu_fdt_alloc_phandle(ms->fdt);
+
+    qemu_fdt_setprop_cell(ms->fdt, "/soc", "interrupt-parent",
+                          irq_hvm_ic_phandle);
+
+    qemu_fdt_add_subnode(ms->fdt, "/soc/interrupt-controller");
+    qemu_fdt_setprop_cell(ms->fdt, "/soc/interrupt-controller",
+                          "#address-cells", 2);
+    qemu_fdt_setprop_cell(ms->fdt, "/soc/interrupt-controller",
+                          "#interrupt-cells", 2);
+    qemu_fdt_setprop_string(ms->fdt, "/soc/interrupt-controller", "compatible",
+                            "qcom,h2-pic,hvm-pic");
+    qemu_fdt_setprop(ms->fdt, "/soc/interrupt-controller",
+                     "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop_cell(ms->fdt, "/soc/interrupt-controller", "phandle",
+                          irq_hvm_ic_phandle);
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(vms->l2vic), 1,
+                    m_cfg->cfgtable.fastl2vic_base << 16);
+}
+
+
+static void fdt_add_gpt_node(HexagonVirtMachineState *vms)
+{
+    g_autofree char *name = NULL;
+    MachineState *ms = MACHINE(vms);
+
+    name = g_strdup_printf("/soc/gpt@%" PRIx64,
+                           (int64_t)base_memmap[VIRT_GPT].base);
+    qemu_fdt_add_subnode(ms->fdt, name);
+    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
+                            "qcom,h2-timer,hvm-timer");
+    qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", irqmap[VIRT_GPT], 0);
+    qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0x0,
+                           base_memmap[VIRT_GPT].base,
+                           base_memmap[VIRT_GPT].size);
+}
+
+static int32_t clock_phandle = -1;
+static void fdt_add_clocks(const HexagonVirtMachineState *vms)
+{
+    MachineState *ms = MACHINE(vms);
+    clock_phandle = qemu_fdt_alloc_phandle(ms->fdt);
+    qemu_fdt_add_subnode(ms->fdt, "/apb-pclk");
+    qemu_fdt_setprop_string(ms->fdt, "/apb-pclk", "compatible", "fixed-clock");
+    qemu_fdt_setprop_cell(ms->fdt, "/apb-pclk", "#clock-cells", 0x0);
+    qemu_fdt_setprop_cell(ms->fdt, "/apb-pclk", "clock-frequency", 24000000);
+    qemu_fdt_setprop_string(ms->fdt, "/apb-pclk", "clock-output-names",
+                            "clk24mhz");
+    qemu_fdt_setprop_cell(ms->fdt, "/apb-pclk", "phandle", clock_phandle);
+}
+
+static void fdt_add_uart(const HexagonVirtMachineState *vms, int uart)
+{
+    char *nodename;
+    hwaddr base = base_memmap[uart].base;
+    hwaddr size = base_memmap[uart].size;
+    assert(uart == 0);
+    int irq = irqmap[VIRT_UART0 + uart];
+    const char compat[] = "arm,pl011\0arm,primecell";
+    const char clocknames[] = "uartclk\0apb_pclk";
+    MachineState *ms = MACHINE(vms);
+    DeviceState *dev;
+    SysBusDevice *s;
+
+    dev = qdev_new(TYPE_PL011);
+    s = SYS_BUS_DEVICE(dev);
+    qdev_prop_set_chr(dev, "chardev", serial_hd(0));
+    qdev_connect_clock_in(dev, "clk", vms->apb_clk);
+    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_mmio_map(s, 0, base);
+    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->l2vic, irq));
+
+    nodename = g_strdup_printf("/pl011@%" PRIx64, base);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+
+    /* Note that we can't use setprop_string because of the embedded NUL */
+    qemu_fdt_setprop(ms->fdt, nodename, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0, base, size);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", 32 + irq, 0);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "clocks", clock_phandle,
+                           clock_phandle);
+    qemu_fdt_setprop(ms->fdt, nodename, "clock-names", clocknames,
+                     sizeof(clocknames));
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
+                          irq_hvm_ic_phandle);
+
+    qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
+    qemu_fdt_add_subnode(ms->fdt, "/aliases");
+    qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", nodename);
+
+    g_free(nodename);
+}
+
+static void fdt_add_cpu_nodes(const HexagonVirtMachineState *vms)
+{
+    MachineState *ms = MACHINE(vms);
+    qemu_fdt_add_subnode(ms->fdt, "/cpus");
+    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
+    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
+
+    /* cpu nodes */
+    for (int num = ms->smp.cpus - 1; num >= 0; num--) {
+        char *nodename = g_strdup_printf("/cpus/cpu@%d", num);
+        qemu_fdt_add_subnode(ms->fdt, nodename);
+        qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "cpu");
+        qemu_fdt_setprop_cell(ms->fdt, nodename, "reg", num);
+        qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle",
+                              qemu_fdt_alloc_phandle(ms->fdt));
+        g_free(nodename);
+    }
+}
+
+
+static void fdt_add_virtio_devices(const HexagonVirtMachineState *vms)
+{
+    MachineState *ms = MACHINE(vms);
+    /* VirtIO MMIO devices */
+    for (int i = 0; i < VIRTIO_DEV_COUNT; i++) {
+        char *nodename;
+        int irq = irqmap[VIRT_MMIO] + i;
+        size_t size = base_memmap[VIRT_MMIO].size;
+        hwaddr base = base_memmap[VIRT_MMIO].base + i * size;
+
+        nodename = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
+        qemu_fdt_add_subnode(ms->fdt, nodename);
+        qemu_fdt_setprop_string(ms->fdt, nodename, "compatible", "virtio,mmio");
+        qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 1,
+                                     size);
+        qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq, 0);
+        qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
+                              irq_hvm_ic_phandle);
+
+        sysbus_create_simple(
+            "virtio-mmio", base,
+            qdev_get_gpio_in(vms->l2vic, irqmap[VIRT_MMIO] + i));
+
+        g_free(nodename);
+    }
+}
+
+static void virt_instance_init(Object *obj)
+{
+    HexagonVirtMachineState *vms = HEXAGON_VIRT_MACHINE(obj);
+
+    create_fdt(vms);
+}
+
+void hexagon_load_fdt(const HexagonVirtMachineState *vms)
+{
+    MachineState *ms = MACHINE(vms);
+    hwaddr fdt_addr = base_memmap[VIRT_FDT].base;
+    uint32_t fdtsize = vms->fdt_size;
+
+    g_assert(fdtsize <= base_memmap[VIRT_FDT].size);
+    /* copy in the device tree */
+    rom_add_blob_fixed_as("fdt", ms->fdt, fdtsize, fdt_addr,
+                          &address_space_memory);
+    qemu_register_reset_nosnapshotload(
+        qemu_fdt_randomize_seeds,
+        rom_ptr_for_as(&address_space_memory, fdt_addr, fdtsize));
+}
+
+static uint64_t load_kernel(const HexagonVirtMachineState *vms)
+{
+    MachineState *ms = MACHINE(vms);
+    uint64_t entry = 0;
+    if (load_elf_ram_sym(ms->kernel_filename, NULL, NULL, NULL, &entry, NULL,
+                         NULL, NULL, 0, EM_HEXAGON, 0, 0, &address_space_memory,
+                         false, NULL) > 0) {
+        return entry;
+    }
+    error_report("error loading '%s'", ms->kernel_filename);
+    exit(1);
+}
+
+static uint64_t load_bios(HexagonVirtMachineState *vms)
+{
+    MachineState *ms = MACHINE(vms);
+    uint64_t bios_addr = 0x0;  /* Load BIOS at reset vector address 0x0 */
+    int bios_size;
+
+    bios_size = load_image_targphys(ms->firmware ?: "", bios_addr, 64 * 1024);
+    if (bios_size < 0) {
+        error_report("Could not load BIOS '%s'", ms->firmware ?: "");
+        exit(1);
+    }
+
+    return bios_addr;  /* Return entry point at address 0x0 */
+}
+
+static void do_cpu_reset(void *opaque)
+{
+    HexagonCPU *cpu = opaque;
+    CPUState *cs = CPU(cpu);
+    cpu_reset(cs);
+}
+
+static void virt_init(MachineState *ms)
+{
+    HexagonVirtMachineState *vms = HEXAGON_VIRT_MACHINE(ms);
+    Error **errp = NULL;
+    const hexagon_machine_config *m_cfg = &v68n_1024;
+
+    qemu_fdt_setprop_string(ms->fdt, "/chosen", "bootargs", ms->kernel_cmdline);
+
+    vms->sys = get_system_memory();
+
+    /* Create APB clock for peripherals */
+    vms->apb_clk = clock_new(OBJECT(ms), "apb-pclk");
+    clock_set_hz(vms->apb_clk, 24000000);
+
+    memory_region_init_ram(&vms->ram, NULL, "ddr.ram", ms->ram_size, errp);
+    memory_region_add_subregion(vms->sys, 0x0, &vms->ram);
+
+    if (m_cfg->l2tcm_size) {
+        memory_region_init_ram(&vms->tcm, NULL, "tcm.ram", m_cfg->l2tcm_size,
+                               errp);
+        memory_region_add_subregion(vms->sys, m_cfg->cfgtable.l2tcm_base << 16,
+                                    &vms->tcm);
+    }
+
+    memory_region_init_rom(&vms->cfgtable, NULL, "config_table.rom",
+                           sizeof(m_cfg->cfgtable), errp);
+    memory_region_add_subregion(vms->sys, m_cfg->cfgbase, &vms->cfgtable);
+    fdt_add_hvx(vms, m_cfg, errp);
+    const char *cpu_model = ms->cpu_type;
+
+    if (!cpu_model) {
+        cpu_model = HEXAGON_CPU_TYPE_NAME("v73");
+    }
+
+    DeviceState *gsregs_dev = qdev_new(TYPE_HEXAGON_GLOBALREG);
+    object_property_add_child(OBJECT(ms), "global-regs", OBJECT(gsregs_dev));
+    qdev_prop_set_uint64(gsregs_dev, "config-table-addr", m_cfg->cfgbase);
+    qdev_prop_set_uint32(gsregs_dev, "dsp-rev", v68_rev);
+    qdev_prop_set_uint32(gsregs_dev, "qtimer-base-addr", m_cfg->qtmr_region);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(gsregs_dev), errp);
+
+    HexagonCPU *cpu_0 = NULL;
+    for (int i = 0; i < ms->smp.cpus; i++) {
+        HexagonCPU *cpu = HEXAGON_CPU(object_new(ms->cpu_type));
+        qemu_register_reset(do_cpu_reset, cpu);
+
+        if (i == 0) {
+            cpu_0 = cpu;
+            if (ms->kernel_filename) {
+                uint64_t entry = load_kernel(vms);
+                qdev_prop_set_uint32(DEVICE(cpu_0), "exec-start-addr", entry);
+            } else if (ms->firmware) {
+                uint64_t entry = load_bios(vms);
+                qdev_prop_set_uint32(DEVICE(cpu_0), "exec-start-addr", entry);
+            }
+        }
+        qdev_prop_set_bit(DEVICE(cpu), "start-powered-off", (i != 0));
+        qdev_prop_set_uint32(DEVICE(cpu), "hvx-contexts",
+                             m_cfg->cfgtable.ext_contexts);
+        object_property_set_link(OBJECT(cpu), "global-regs",
+                                 OBJECT(gsregs_dev), errp);
+        qdev_prop_set_uint32(DEVICE(cpu), "l2vic-base-addr", m_cfg->l2vic_base);
+        qdev_prop_set_uint32(DEVICE(cpu), "jtlb-entries",
+                             m_cfg->cfgtable.jtlb_size_entries);
+
+        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
+            return;
+        }
+    }
+    vms->l2vic = sysbus_create_varargs(
+        "l2vic", m_cfg->l2vic_base, qdev_get_gpio_in(DEVICE(cpu_0), 0),
+        qdev_get_gpio_in(DEVICE(cpu_0), 1), qdev_get_gpio_in(DEVICE(cpu_0), 2),
+        qdev_get_gpio_in(DEVICE(cpu_0), 3), qdev_get_gpio_in(DEVICE(cpu_0), 4),
+        qdev_get_gpio_in(DEVICE(cpu_0), 5), qdev_get_gpio_in(DEVICE(cpu_0), 6),
+        qdev_get_gpio_in(DEVICE(cpu_0), 7), NULL);
+
+    fdt_add_hvm_pic_node(vms, m_cfg);
+    fdt_add_virtio_devices(vms);
+    fdt_add_cpu_nodes(vms);
+    fdt_add_clocks(vms);
+    fdt_add_uart(vms, VIRT_UART0);
+    fdt_add_gpt_node(vms);
+
+    rom_add_blob_fixed_as("config_table.rom", &m_cfg->cfgtable,
+                          sizeof(m_cfg->cfgtable), m_cfg->cfgbase,
+                          &address_space_memory);
+
+
+    hexagon_load_fdt(vms);
+}
+
+
+static void virt_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->init = virt_init;
+    mc->default_cpu_type = HEXAGON_CPU_TYPE_NAME("v73");
+    mc->default_ram_size = 4 * GiB;
+    mc->max_cpus = 8;
+    mc->default_cpus = 8;
+    mc->is_default = false;
+    mc->default_kernel_irqchip_split = false;
+    mc->block_default_type = IF_VIRTIO;
+    mc->default_boot_order = NULL;
+    mc->no_cdrom = 1;
+    mc->numa_mem_supported = false;
+    mc->default_nic = "virtio-mmio-bus";
+}
+
+
+static const TypeInfo virt_machine_types[] = { {
+    .name = TYPE_HEXAGON_VIRT_MACHINE,
+    .parent = TYPE_MACHINE,
+    .instance_size = sizeof(HexagonVirtMachineState),
+    .class_init = virt_class_init,
+    .instance_init = virt_instance_init,
+} };
+
+DEFINE_TYPES(virt_machine_types)
diff --git a/hw/hexagon/Kconfig b/hw/hexagon/Kconfig
index 7b9577f68f..dc74751d21 100644
--- a/hw/hexagon/Kconfig
+++ b/hw/hexagon/Kconfig
@@ -3,3 +3,13 @@ config HEX_DSP
     default y
     depends on HEXAGON && TCG
     imply PTIMER
+
+config HEX_VIRT
+    bool
+    default y
+    depends on HEX_DSP && FDT
+    select DEVICE_TREE
+    select VIRTIO_MMIO
+    select PL011
+    select VIRTIO_BLK
+    select VIRTIO_SCSI
diff --git a/hw/hexagon/meson.build b/hw/hexagon/meson.build
index 11e71a67d5..4b856b9583 100644
--- a/hw/hexagon/meson.build
+++ b/hw/hexagon/meson.build
@@ -3,3 +3,5 @@ hexagon_ss.add(when: 'CONFIG_HEX_DSP', if_true: files('hexagon_dsp.c', 'hexagon_
 
 hw_arch += {'hexagon': hexagon_ss}
 
+hexagon_ss.add(when: 'CONFIG_HEX_VIRT', if_true: files('virt.c', 'hexagon_globalreg.c'))
+
diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
index 6326e46b7b..b8eeed703a 100644
--- a/tests/qemu-iotests/testenv.py
+++ b/tests/qemu-iotests/testenv.py
@@ -239,6 +239,7 @@ def __init__(self, source_dir: str, build_dir: str,
             ('arm', 'virt'),
             ('aarch64', 'virt'),
             ('avr', 'mega2560'),
+            ('hexagon', 'virt'),
             ('m68k', 'virt'),
             ('or1k', 'virt'),
             ('riscv32', 'virt'),
-- 
2.34.1


