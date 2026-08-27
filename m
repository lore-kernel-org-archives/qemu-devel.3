Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9CBC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziYt-0005fc-Ph; Thu, 27 Aug 2026 18:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYq-0005e3-HY
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:27:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYo-0001Iq-MQ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:27:04 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLomq547115
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5aFpdYGlNsE5Enj7mfxPMqR8658viNfL7KoBkLVoVBM=; b=EBaxRXIae75fYOTG
 IahDVvjUfXK7PeQji7hvQd9UFzV3GwcmcOIAY8gM+wMLu22r6sRf64/PIA2Whzsn
 pg+j+bSCF4res/wuKYW0Ci3MCPoDBXha5Lu9cccbYdESb2l728MKl1CtT6lSzy1g
 cuuVSpBccLfsop+1fHB5kMpLrbwsnjGuuzTIl2MI2yEhBq144WZkAjVcZ750ATHY
 fI/1JgvJ225jtfNs/+TkCqdzk47GLTK2uUae4vfttAsVhaUlKSRLm2lbXB3oi38V
 bUQQ28bVMwBWwipYN5jABKPWnKrE+XxObUW5VnvK7KAmQoXdbUDLVjjiKN1FeHe8
 xUBtBQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gak562urr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-933023a5980so29198385a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869611; x=1788474411; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5aFpdYGlNsE5Enj7mfxPMqR8658viNfL7KoBkLVoVBM=;
 b=FYJvZym3228OgofR8KvTmkB9tiCXCDZtsz1MMpK4bi4unasZiVIO8ZU029E0OYgpli
 GRCV4etVAyvbCV2/WUPPih3tGlc60YdA1tlew/K6NZT1t2clsQOFtRHJWktfQBnpCoZS
 O7PiZek54tz2cLn6KpNV8Z2Phhp+yKe1awOUtmmPuB6aBDy0qSo8X5Nu1KtSQ/MGp5rJ
 25iuo5xXR4xL/AEYfANR4VE1bIt9g6lG4qe/fkvrtxV5mJrd7RmrrLRBEFu/WEqGJIib
 1lyUPfGRn88/uVy+Fz+1BbXYzGRtNvr/xH0e9pfK8ijtz97kQZk1S40o6nMOnRPe9l8W
 e/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869611; x=1788474411;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5aFpdYGlNsE5Enj7mfxPMqR8658viNfL7KoBkLVoVBM=;
 b=KXMw5NyudmmNdRtEsq7DzFbUkHPJvOr+sT1ehifGVNTYtjYV6GaQvezDX2s/hLorYv
 u389SfZwrs68WMvqmTEckX6AELonBqvmXHWvCpLTwUF2C6b7bnWdJR0zZ+Ei12x6Ix2s
 L8GGaHru9XZN1vCESKnNfjeifzs0WEWSeRyQ2ZzZjkMHfheR6t4DAYf0qRxJMml7ZhG3
 wHDf0O5ztCc4U8jynhzEYMDG/z6MtrN1YZ1GTC1ddJtLrZ2E273vdcd6WESgXrHZhLxT
 uzoutH0OeEXjwpIbRrH/IKBCPMbv95WuyFR68RP47GGMBmX+0AChUb5CIW1zGdhPGWr3
 D52g==
X-Gm-Message-State: AFuF++kB46ithvMqhN7HIYTmZ2fdxB3WyWRC2zgLlKIV1dJHn6rPmbfd
 EZrwcdvZ54U+p0YCinEQOrR7B+zSwYFzXmzVc7+NOjzkVMQSi9ZjncE8MEoh18Tpf0qvhEY6hzd
 gnR4iD2K7Wwb/UEFfL2fgSrF5HicyEC8/4dRboXMJNKucdf3o+U6/D7KtrVDJeweC2g==
X-Gm-Gg: AR+sD10w6EiX40bYIAgUSTo8iBKo0jMj3b+jPuGZCVtjKL2KBndEVCFfcqDcOWkR2du
 JM5qTnGqYSf2wnKuQO649hcJzpHzHXI1KGA9xE0Ln/bdhcO1WpIklCSAWiDgDFyCNBIbqKq+Bp8
 doPK7cctONQoIYSK2/IutVNWwYoPK7GXMb6igDDhENwal1QtZFVdZf/8hJ/3yIv312ZPpJtpNvX
 +IjLV7AMXnYlNwC/Zl5JXE2N1/zJKm35S7Gp4MoWuuq0QQvhCCMWqC61NWHBOc4Me/o0s4xXajV
 Y2KTnyKjiUHRvCXqsCad0l6bz9w2AwFIAYFzLmCuw2M/nKPrfE6SDkl94OyhKpE8kWxQLEhGBA0
 34QLiwGfqw86HRuTQE7HaG2hP38pT1CQzG/TWkQ==
X-Received: by 2002:a05:620a:6606:b0:937:1097:feb8 with SMTP id
 af79cd13be357-939138be733mr270483985a.24.1787869610992; 
 Thu, 27 Aug 2026 15:26:50 -0700 (PDT)
X-Received: by 2002:a05:620a:6606:b0:937:1097:feb8 with SMTP id
 af79cd13be357-939138be733mr270477985a.24.1787869610441; 
 Thu, 27 Aug 2026 15:26:50 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173a734dsm8924985a.26.2026.08.27.15.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:26:49 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 11/14] hw/riscv/device-common,
 virt.c: add riscv_create_platform_bus()
Date: Thu, 27 Aug 2026 19:26:04 -0300
Message-ID: <20260827222608.329788-12-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
References: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfXxiirNaAwNOkS
 FZPLLNCuXtUdrUa7O0ywnzeUWZiR5ACxpTmz3m7YWEJeZFXo1Gp3ekbB9/a7CmGf4IiCpz5egxA
 mM1Z2uocJKkOTP9CuEtugduPjDW0jqY=
X-Proofpoint-ORIG-GUID: QvVhyAXZvlJ5ScmLJ6Osf88wGE8hkrIU
X-Proofpoint-GUID: QvVhyAXZvlJ5ScmLJ6Osf88wGE8hkrIU
X-Authority-Analysis: v=2.4 cv=G+Ms1dk5 c=1 sm=1 tr=0 ts=6a90b9ab cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=aH2Wc4Ua3Gm2Ww6jc38A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX/0ZFhwYFuVzU
 pAVj+ThDzTQTfg9RIqgziwmNM7g5syf0RqbnL9V7y17dC0QFiwAcaw2ke22oNa/Bln5C7NNNOJk
 z2CjdZ8p0aH3dSnkPPuByeGWahL3n3Rh0kdZgu7XJWsNBesiY0lXC4TiiPGtigv/ckMPyrx/WI8
 6P87czlsnESmWcKeZor/Q9W3e0yNcpYxILcNeK5xJoGs2J0M1m7qKNZ8ay6dK8ce7W5xcdARcnx
 MVqosqEqM2Q5UFg679MuAzFtC6diFn/Zzpw2iIJNDaNSlHOgFXaBBGGk654+TIE02t8ZLTtVJRF
 CJAGHvPi0fyoh9zfDDN69AgqEx3p5VDGcDXLgOl2Y6gZlfptCuBMEAp4x0TA8yjIWdXb6vbNo99
 7T498CoyItwaLpqXhzMvdvKgls1Hxr6Tn6e+6BgYY7HWKaiX8xgW2bl3GGQ+8jtUW7DpST+Kdi/
 7733jKVuIjGqL28nYpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270190
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


