Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D876C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Ms-0007T4-9D; Fri, 28 Aug 2026 16:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03Mq-0007PD-II
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:40:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03Mo-0006aP-Fe
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:40:04 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SJ7KIY2761588
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5aFpdYGlNsE5Enj7mfxPMqR8658viNfL7KoBkLVoVBM=; b=gFasxbA6KhflV7Du
 u8y05Vl1S0pZEP4GWQ/uEeJP1BAF6aN7Jeo3bTHf8H07qS5OvhhvioIKKP90xOrT
 zfNk6w9l0lgL2e98VwVF4UONd/ZOfqGiepIuFck9uAEV2Di4L4IkZPo7WITiT4MT
 2AKHZnkRtEQpj3cmapmxNQSo5q622HvV6ccGrQqWqWtGF/vxgbKSglzyBFN0nMe9
 wbkK/QxT3WbSAbVD8lBMyxd0N3rGeNJ2uzy/KflJOaDj3v5aas5iafl3M8IzcI0L
 iQNUnypWqQIjLH9CklHZaLd0ZXh1kMaXz+sCbH8OWAwjPL5XcAuIVTLGpzuPqm8P
 DlAhvw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbag9sqpj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:40:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-936708f129aso136561885a.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 13:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787949599; x=1788554399; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5aFpdYGlNsE5Enj7mfxPMqR8658viNfL7KoBkLVoVBM=;
 b=HIGroCAEq4JgiZKOf+YyrSM+ptMytvJPWjAWFsgnumiEx6F0HAVS3YU8rSVZHthwT9
 9JP5Hh7kfnS0AjzRaCgMtE+UpbrzDj7Dyqad/d7zXePtbpmXR1TkG+cWMv536RXmPBUh
 dRDvJ5BLcdJMGJee7kkUZQpBGTR+4glgM/0qfWV7BPRPXnyQvJ/xKssaEsVc8xC5kZnu
 rPMIZvNvr0tCCh9lphCY3ZSjE//wDXxXGC+iBIhrQhReou/vdVYbM+QamELbTo/TdRly
 7/7plgpkb8l1FIR2hO6KfeqCsvUIj6xW44CXQG/9a/Hw5sNbn79gXjVhAlOT0lE9QvYe
 p/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787949599; x=1788554399;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5aFpdYGlNsE5Enj7mfxPMqR8658viNfL7KoBkLVoVBM=;
 b=Dc27jFSBxnbO8s1WFxppwjyGh6SuFe6wa2Ut01sN7IIajYUNzfrJ9GFtcDd7UozvVa
 ZJYoc2c5VCrWOGGRPj0IG95ERd2Zucjw6KXODoKFtd3FPFevD1bQFZf+X2TGhLea304g
 6rSgTKkkC0pDATinKLQI0tljfP3Rn0jXtA8KkQGDgbxgx7toD0+MsDlskh8uE1NYWRTX
 gt1PmNFB6MFODLuq9GoSCgPP5I04PaOZE2VoV/2ix2mmNBYKTybYdH1l705nQdOuLMM6
 Y/huyVpreQyY26lpMJNTWU16RHa4ptBwZy+lNOukz72jeBujoPqHG+x40NksqX2cwS76
 FhhQ==
X-Gm-Message-State: AFuF++m4edHdPYYSe0b9WR0kswJtfNSVPtGUKF0RI8JM9+i/gHqKbccz
 LsrIuHzdC0EITB/Ik4NVwF8YTxblzUWIeFmGiW8fDFHySCxubCo25qZQlunwd3+X40QdsnPy607
 EDr4qhCxfzlI3K5PSk/72YKI/XjZnEvUVF7xwz2ETycNEyZ3lVb5RH7/muZ73LNHYlw==
X-Gm-Gg: AR+sD12RRJteyOoh0/gGBkE4sHNY6ysSzCuFO0Szy3NfSOa2pIkIqkX/kkOwDo+kdcN
 0Y1NVmwutZmI7N8qYK7kVHF9i+s5Da5Z9oFFVBOuxkcY2ttc3AoKmwbZxSjiv0RQ3S81178blvO
 GEHcZvZMDSn+WCIAXTH41rEeMN9uRjnMT9+JGtytlUQeY2vtQzRLZ5lyY4l6j6lub7+VtHmjtOb
 S/rkpGWR3OwDkoTqw2X6PLvdL3EUcS4Lx1vXT8l3X6K4gX8F6OwDo4sg1wewpgr4quwaW+8Nh0i
 TMs6weIvPzGotyop7RF4KRx0SXyoXmLJr9ywuxPruynGcYMJZdHq2ZLWzniIH+F5LA0H+FsdMo6
 VtewfQsDR/KApZhWYyeVwQ8/MA/VbV+5s959g8w==
X-Received: by 2002:a05:620a:f02:b0:92e:535b:e08b with SMTP id
 af79cd13be357-939139571eemr1004702585a.33.1787949599188; 
 Fri, 28 Aug 2026 13:39:59 -0700 (PDT)
X-Received: by 2002:a05:620a:f02:b0:92e:535b:e08b with SMTP id
 af79cd13be357-939139571eemr1004698385a.33.1787949598737; 
 Fri, 28 Aug 2026 13:39:58 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173f2758sm218063985a.37.2026.08.28.13.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 13:39:58 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v5 12/15] hw/riscv/device-common,
 virt.c: add riscv_create_platform_bus()
Date: Fri, 28 Aug 2026 17:39:14 -0300
Message-ID: <20260828203918.350131-13-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UalhjqSN c=1 sm=1 tr=0 ts=6a91f220 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=aH2Wc4Ua3Gm2Ww6jc38A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfXw6bdvSUOrFD2
 PV4FR65yaJZ6ojzfg8XVrb/EujKhXrvbRHWf7FBs0G5sRIOa638TG5LH6SvhJUA0cahLJjMmCOv
 JuMP9b3lZzeXhLBh1dlXdY0+IYHFn/c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfX3VgvWM21LkVU
 MBYdBprBxgETY5ihujJYIVnpSrKWRRQmTxG9k+HejR27E4UcY2t8I8oz1n42IGyo9afZbfNzGQT
 K99KQPcnRzQQS360MkbhlA4zLalZdYx0AOUKVIZs+G9Wlo0u8zCV51+kzQN/Wbqk4SRSSQNHw3I
 VG/W8LvgtTIxdJpk2OUjK/wkToo+Tn0y11ocHKaLrLbVYZWKZXEkmZHQcnDIgiIL1B5pHhMdpf7
 IEvzTBJPdwnu9omFtVAmXAEUeH4I4cojWm+a7JQoPEt40ePEKkYK0mE7Q/kcDiec3zEKgWiu40w
 HciURHvF/YZNzWCi1+ljcs2gcFITWksvcDCGUNP+4+CNCFPzWv0fRCGCoPLS7PnZXIM6KP+CaXn
 z6UtCdNMjl9C64LiIFBSxWHHdT7Cy55+rCYOFyZhH9wpODOnhI4odCyeyJ9aLSVAHgk2inc3IJN
 qU1p6stdtVqAXB8sslA==
X-Proofpoint-ORIG-GUID: k-le4G1RNFl2F5h9TcWOMq6G2FQubH49
X-Proofpoint-GUID: k-le4G1RNFl2F5h9TcWOMq6G2FQubH49
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_06,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280179
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

There will be code repetition instances added by the 'riscv-server-ref'
board w.r.t device creation and initialization.  Instead of waiting for
that code to land we're adding helpers beforehand.  The idea is to make
the new board code shorter and more palatable for reviewers.

A new 'device-common' file is created for such helpers.  We'll start
with the platform bus, a nice piece of software that only the 'virt'
board uses so far, and the 'riscv-server-ref' will use to support TPM
devices.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/device-common.c         | 48 ++++++++++++++++++++++++++++++++
 hw/riscv/meson.build             |  1 +
 hw/riscv/virt.c                  | 30 +++-----------------
 include/hw/riscv/device-common.h | 19 +++++++++++++
 4 files changed, 72 insertions(+), 26 deletions(-)
 create mode 100644 hw/riscv/device-common.c
 create mode 100644 include/hw/riscv/device-common.h

diff --git a/hw/riscv/device-common.c b/hw/riscv/device-common.c
new file mode 100644
index 0000000000..d3c68a9e71
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
+DeviceState *riscv_create_platform_bus(DeviceState *irqchip,
+                                       const MemMapEntry *platform_bus_mem,
+                                       int platform_bus_base_irq,
+                                       int platform_bus_num_irqs)
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
index ccea5784f0..a2671ae341 100644
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
@@ -683,31 +684,6 @@ static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
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
@@ -1030,7 +1006,9 @@ static void virt_machine_init(MachineState *machine)
 
     gpex_pcie_init(system_memory, pcie_irqchip, s);
 
-    create_platform_bus(s, mmio_irqchip);
+    s->platform_bus_dev = riscv_create_platform_bus(mmio_irqchip,
+        &s->memmap[VIRT_PLATFORM_BUS], VIRT_PLATFORM_BUS_IRQ,
+        VIRT_PLATFORM_BUS_NUM_IRQS);
 
     serial_mm_init(system_memory, s->memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
diff --git a/include/hw/riscv/device-common.h b/include/hw/riscv/device-common.h
new file mode 100644
index 0000000000..12af031bbf
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
+DeviceState *riscv_create_platform_bus(DeviceState *irqchip,
+                                       const MemMapEntry *platform_bus_mem,
+                                       int platform_bus_base_irq,
+                                       int platform_bus_num_irqs);
+#endif
-- 
2.43.0


