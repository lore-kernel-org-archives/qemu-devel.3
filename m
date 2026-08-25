Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE9AC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyycw-0003h1-6b; Tue, 25 Aug 2026 17:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyycu-0003gQ-RA
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:24:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyycs-0002L5-VC
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:24:12 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PL9qoD3116883
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HeOItTZvILg
 yY+ctPuYqKhbG6qTTQsbkyGXvY2Arifc=; b=njkXKCsvaZaoFNj4clVtVcQX0A5
 CftkxRe0Q1O8W8bH01EM6HYO+CBpvBmBhHf7hf5rUMSbiW/JbjneSs+6CKkFsVzY
 wd4E21ythMSMIC8yMVOtHf4hisisaNUFT+060oRudqthzLlJET6WOWa/ucm+FX55
 OXGbRnY5sWfr6kRAIjhTXVPZbpIlQksRzkBBI4oiWLB/yXezOcDH6VlrG4FX1UUU
 O3pXYiARupcplF0klZYSTxLGjob1wbTEtufS73Geiz1Yz6FqUu4bu6hnJvTCKsgb
 hHKRS4YkGETMxgZNYi+e2FD+7GxlyChSIIS33gUffmmndmMPNEo9pJ2Yg3A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9g4mrk8w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:24:09 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52d7b3b6aa2so137291cf.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787693049; x=1788297849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HeOItTZvILgyY+ctPuYqKhbG6qTTQsbkyGXvY2Arifc=;
 b=e2uzUawYuhGY6lzkr40w2rppSlrXzRTX1SJpdU+MtJ5YjOReVHFjdn47rxWGIQzXvY
 YKIxKN9XJo2l9svSkdiVG21flsyZhKv8oKHTUk55UC4BoBqVpxFuH3RTDVvVlqnR4gGy
 V1twk4qsiRQXUNIF5MyJuN444rQ+1/0naVzTKdi4izZEFwaY73+RvDyVoppr2zdo3akA
 52bS1jvF8G8kZKl6L2PwlTnLEPa0wWkWUdiJ3nKt+ObgqFFUqoQ6QIpIIblVAH6aNP0X
 XfBJ3XbR5Xd/EQeuJN/5QUaN1hSsMPR+hwWkCcHhfhi1lbGP7hb7nvlLQHze++WdVdPe
 7INA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787693049; x=1788297849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HeOItTZvILgyY+ctPuYqKhbG6qTTQsbkyGXvY2Arifc=;
 b=YBNwIrKZTYc4wsq/hD3rb2ko2paeJjsBvMi20yEt1Hz+EAWIpETwUfTfyA8h6HTZoJ
 +3ckfnTkIJS7dkLv4qNag2LZmYedDreM6Lp8dNc+9Jt6ceDF8GS8EyIq++7zBf1eBkGD
 GZRpvrGX4ygIvV6TW7tBmTCB4tMVf6pvutibyHSNj/UIPiuytL6OGeIVEevajQGwuTwU
 90pckMxPPAOqBTja9WojqdJBT14B4ftD6cmSMAk+RutzH3gIXyKx+4ktWj8ttXjJHJI0
 1UkWAgId4Pit8CcrKUiwvoPMaIZ3VO/hcVwe61EjBaRtAypHVSoasQynGTwCfkAPqPrT
 8NRQ==
X-Gm-Message-State: AFuF++l+kKrlrNhQbhbSaZs4BMGsw6LuWrRLYRk40MH+WQUD7t4bUvUt
 OhDuVGkLsSbxfpx+CG970NPX0GEVxo15urQiMJTvr9Ysq0utpl+3y4fPTvQgpBI/5mKUP57CQdW
 /TT2Wvyoc8d3d00aebNALcluLsze50K86b+QQSykxkierEaZOMSvv0J91IrnXUAKK9w==
X-Gm-Gg: AR+sD13PR2D9DNvLasKGoURuE8SgVNsTGLhfvB2OmyswR876QJWdtogw19ZCsZx7Lsg
 QGUWEwDCYYGFBGQCvvBfoSQSaGZf+44fgNm8BeU06fR7cAz2DbFiZiOpko4/6AusLmFzt/+LIW2
 EMfmxQcl24hWDdwRB5TracA949PafuiJT9nCO0MK7Rj8KjhZ/wkJvOz46CtOajSzeOQNy4WcImE
 xBs4xucZ8u7PGqDscvWYFEMf1I8Du7Ed13Atx3bVKI1iyjqddxEYfJcWzm63TSm/k0xG5Hklaiq
 hC2hOoCJMLs5nF6rxOEdyNy7Q82sshUdVPzCw5V0tuaD8ZKvQxzYpULSj4eoLz84W+I4BddttXp
 H05THyVeYE1zhuULT887EozYQC/z5z60rvbS4cQ==
X-Received: by 2002:a05:622a:82:b0:51e:e5a2:ac82 with SMTP id
 d75a77b69052e-52e4230bf05mr19956721cf.23.1787693049222; 
 Tue, 25 Aug 2026 14:24:09 -0700 (PDT)
X-Received: by 2002:a05:622a:82:b0:51e:e5a2:ac82 with SMTP id
 d75a77b69052e-52e4230bf05mr19956041cf.23.1787693048590; 
 Tue, 25 Aug 2026 14:24:08 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cc65299f0sm8646386d6.41.2026.08.25.14.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 14:24:08 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 10/13] hw/riscv/device-common,
 virt.c: add create_platform_bus()
Date: Tue, 25 Aug 2026 18:23:22 -0300
Message-ID: <20260825212326.1907-11-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
References: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfX8CAIxgYFaKUn
 Y5j25hSiCgZvGuJjKvdMkLEApKeg9fnWPT9CiEtw9fi8cjOeN/jxVm0Uxw3YoeqgGunf9fTFgJs
 MJkuxbk32H/rRPU5euEWa2450dg3Abo=
X-Proofpoint-ORIG-GUID: kPGadjO3jhDKuLFh0PVOr26A0MAZbtjU
X-Authority-Analysis: v=2.4 cv=eYgNubEH c=1 sm=1 tr=0 ts=6a8e07f9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=8qX1o8pqpDL_2YrQefAA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfX+4fETMVULlb4
 9O4ci+VY8JJTnObronLgDSJjl+nlZ0uAEEERP9nNQWJJoPHs5Y9Q5t15SswoSdZdlpeuKFlGTOQ
 n0aFt63oP7U3Dl/4Ci7PoR5T+2+02IfechRzVBhWGl5v8qGYaaY1hVItQlBzmNKGjYIrGgGvs3G
 QUpfIWJxOfR2/8rAm+wExkDdOXZLh9MI2Swd38TvAUmhCjuky60u6LysQj2mXseD4Rv1ZL1oj+Q
 tYjI9+zWC0oUTh2npKFA8v9rmNPYgwdxxZHvJu9saEpwnv5u2cmshao1TJWFxantQfhST6n2gcK
 R288vcWAo9Rt0fOoxM+q9E5I5fRmsNVfxgM8Kq+kDprwEuhuRRWBF3qwla3unnUKVzVwEpClrRN
 e9LUKeEyKNcxJfFRl9eYC//l1/4jBYHKY9Xk48NUShZptcyoZLdnHHGW1DvLweOhMPGqVwAH0Zo
 BzWYo410gV46+qU8Hxw==
X-Proofpoint-GUID: kPGadjO3jhDKuLFh0PVOr26A0MAZbtjU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250182
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

There will be code repetition instances added by the 'riscv-server-ref'
board w.r.t device creation and initialization.  Instead of waiting for
that code to land we're adding helpers beforehand.  The idea is to make
the new board code shorter and more palatable for reviewers.

A new 'device-common' file is created for such helpers.  We'll start
with the platform bus, a nice piece of software that only the 'virt'
board uses so far, and the 'riscv-server-ref' will use to support TPM
devices.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/device-common.c         | 48 ++++++++++++++++++++++++++++++++
 hw/riscv/meson.build             |  1 +
 hw/riscv/virt.c                  | 31 ++++-----------------
 include/hw/riscv/device-common.h | 19 +++++++++++++
 4 files changed, 73 insertions(+), 26 deletions(-)
 create mode 100644 hw/riscv/device-common.c
 create mode 100644 include/hw/riscv/device-common.h

diff --git a/hw/riscv/device-common.c b/hw/riscv/device-common.c
new file mode 100644
index 0000000000..74627b996d
--- /dev/null
+++ b/hw/riscv/device-common.c
@@ -0,0 +1,48 @@
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
+#include "hw/riscv/device-common.h"
+
+#include "hw/core/platform-bus.h"
+#include "hw/core/qdev.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/sysbus.h"
+#include "qapi/error.h"
+#include "system/address-spaces.h"
+#include "system/memory.h"
+
+
+DeviceState *create_platform_bus(DeviceState *irqchip,
+                                 const MemMapEntry *platform_bus_mem,
+                                 int platform_bus_base_irq,
+                                 int platform_bus_num_irqs)
+{
+    MemoryRegion *sysmem = get_system_memory();
+    DeviceState *dev;
+    SysBusDevice *sysbus;
+
+    dev = qdev_new(TYPE_PLATFORM_BUS_DEVICE);
+    dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
+    qdev_prop_set_uint32(dev, "num_irqs", platform_bus_num_irqs);
+    qdev_prop_set_uint32(dev, "mmio_size", platform_bus_mem->size);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    sysbus = SYS_BUS_DEVICE(dev);
+    for (int i = 0; i < platform_bus_num_irqs; i++) {
+        int irq = platform_bus_base_irq + i;
+        sysbus_connect_irq(sysbus, i, qdev_get_gpio_in(irqchip, irq));
+    }
+
+    memory_region_add_subregion(sysmem,
+                                platform_bus_mem->base,
+                                sysbus_mmio_get_region(sysbus, 0));
+
+    return dev;
+}
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 0d82ceacc4..7aa3c1578d 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -1,6 +1,7 @@
 riscv_ss = ss.source_set()
 riscv_ss.add(files('aia.c'))
 riscv_ss.add(files('boot.c'))
+riscv_ss.add(files('device-common.c'))
 riscv_ss.add(files('fdt-common.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
 riscv_ss.add(files('riscv_hart.c'))
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index f3c176dddc..7ecc3aeb6e 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -35,6 +35,7 @@
 #include "hw/riscv/riscv-iommu-bits.h"
 #include "hw/riscv/virt.h"
 #include "hw/riscv/boot.h"
+#include "hw/riscv/device-common.h"
 #include "hw/riscv/fdt-common.h"
 #include "hw/riscv/machines-qom.h"
 #include "hw/riscv/numa.h"
@@ -661,31 +662,6 @@ static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
              memmap[VIRT_PLIC].size);
 }
 
-static void create_platform_bus(RISCVVirtState *s, DeviceState *irqchip)
-{
-    DeviceState *dev;
-    SysBusDevice *sysbus;
-    int i;
-    MemoryRegion *sysmem = get_system_memory();
-
-    dev = qdev_new(TYPE_PLATFORM_BUS_DEVICE);
-    dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
-    qdev_prop_set_uint32(dev, "num_irqs", VIRT_PLATFORM_BUS_NUM_IRQS);
-    qdev_prop_set_uint32(dev, "mmio_size", s->memmap[VIRT_PLATFORM_BUS].size);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    s->platform_bus_dev = dev;
-
-    sysbus = SYS_BUS_DEVICE(dev);
-    for (i = 0; i < VIRT_PLATFORM_BUS_NUM_IRQS; i++) {
-        int irq = VIRT_PLATFORM_BUS_IRQ + i;
-        sysbus_connect_irq(sysbus, i, qdev_get_gpio_in(irqchip, irq));
-    }
-
-    memory_region_add_subregion(sysmem,
-                                s->memmap[VIRT_PLATFORM_BUS].base,
-                                sysbus_mmio_get_region(sysbus, 0));
-}
-
 static void virt_build_smbios(RISCVVirtState *s)
 {
     MachineClass *mc = MACHINE_GET_CLASS(s);
@@ -1006,7 +982,10 @@ static void virt_machine_init(MachineState *machine)
 
     gpex_pcie_init(system_memory, pcie_irqchip, s);
 
-    create_platform_bus(s, mmio_irqchip);
+    s->platform_bus_dev = create_platform_bus(mmio_irqchip,
+                                              &s->memmap[VIRT_PLATFORM_BUS],
+                                              VIRT_PLATFORM_BUS_IRQ,
+                                              VIRT_PLATFORM_BUS_NUM_IRQS);
 
     serial_mm_init(system_memory, s->memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
diff --git a/include/hw/riscv/device-common.h b/include/hw/riscv/device-common.h
new file mode 100644
index 0000000000..f91c39511f
--- /dev/null
+++ b/include/hw/riscv/device-common.h
@@ -0,0 +1,19 @@
+/*
+ * RISC-V board helpers for FDT generation.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef RISCV_DEVICE_COMMON_H
+#define RISCV_DEVICE_COMMON_H
+
+#include "exec/hwaddr.h"
+#include "hw/core/qdev.h"
+
+DeviceState *create_platform_bus(DeviceState *irqchip,
+                                 const MemMapEntry *platform_bus_mem,
+                                 int platform_bus_base_irq,
+                                 int platform_bus_num_irqs);
+#endif
-- 
2.43.0


