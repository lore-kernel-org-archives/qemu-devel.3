Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B1CC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGoB-0006Oq-Ds; Wed, 26 Aug 2026 12:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGoA-0006Nj-1w
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:49:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGo8-0000vM-1v
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:49:01 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QDuuBt1461933
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HeOItTZvILg
 yY+ctPuYqKhbG6qTTQsbkyGXvY2Arifc=; b=CyPh91zgymvMjMXTY8HJPfb+BRv
 XO1Su0WOIlBzNVuE6aaBVdC4ZkYUnBLEtZHiFAgp+24UjSU6EgeorMA+z+Vuz/iT
 IwOlIw5OnitRtdeca+Wdok/jcjgL5FGqQB/QP4q1h4+H/Jqu4PXNS6leQUFlen3t
 HO4gBHDCmHCoL4r0xucBeuB8tsshxI7/1GIj1WHdZEqqFreaGhbm0CXU8vtxGfOf
 2S+b0FRmtvN4L9IojafPzE9Pvi7rvz3ehfFgod8Hb2Z7tJNMlHn+9Nvxyt7gim/f
 cycZL1zybIel6PGzEKXh3CzQ3ve5UDPu023/JNDOhgjM010JnFY/6A/+IJQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r1gk3k4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:48 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5174a236220so13933051cf.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 09:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787762928; x=1788367728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HeOItTZvILgyY+ctPuYqKhbG6qTTQsbkyGXvY2Arifc=;
 b=i77tLlK9ohiXSiUI7sIu4fn4mrw4g4mv0hwRYmmiT7xO+ZRWFTIkS3ThlbOmQA0jGt
 r+vKlMCC+PbMOY29nYB90fumGLYt08jLQpdDzKOdlKPO9Ekht2Rs3iaTVApCgb9MNHcr
 44sIqzT2ndvenU98LYniTN6k+r0txgUMmirKG6bAHjqc/SDZOBfypAdrlU2o1xBMHqNZ
 Kg1Xy7X6DCThMRpSQi6PipdOsXJ6jtmSDFAf/ferbZaGM4wnp4VV6HprGglBZUK8vD2h
 WAw1vgpcJhl1E6eOh+SPnrNj+ofRcS1jiZNi3yD/kLkd/cnJ6Y6A493+/c3AayUSpjZD
 Sn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762928; x=1788367728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HeOItTZvILgyY+ctPuYqKhbG6qTTQsbkyGXvY2Arifc=;
 b=hz2snvST4Xgqs1iCjtt84PbPYY0VA1w3KB8NsF9JaJmTRW+A7HRrs/iPG+WqIKmIqo
 MXKkuB8lK4/HCmDH9P7hESKtYB9U4hD18aEjfv9nGpAbdURx96mQb3LQ8KTaFmEmeM0x
 mjQh5kk96fexVSZCXPhzKNougdXTasU6Nyt3/M5n49wgJd1P1y+lT/SpLHuf4ETyeztf
 5DgSGx/wL/sIHxL7Hxfi6Wd8Doic/RqnZ7hsoFUp2cMpKlDyy+PMq8XFzKOJAzpLUOXB
 yOhxYPQnEekZq9CK6uTUU+VV56rjC98zr5NDfEqxYeEvlMdbKssEEnoQ15hBFKm6fFJ7
 km1Q==
X-Gm-Message-State: AFuF++nViA9jh30hDC8tYyJcysGt535on7aDZg2ymUM1E4iK+5mbrtfY
 aesjgsDMHcPVFnSmMVvIKp3+Iv535zaqNyadTJXXkQf4hZwl1UpN0+pB7n7PawvXDszyNXwdKEn
 ytxKHQXzJ3qYafUBkwtkErYIdY9Cdax9f4fBU2KT/HZ+lYUWxNWOlcrtwehR9Uq5hIg==
X-Gm-Gg: AR+sD10PANo0cT4N70CpRFegKHERlTj5iNnduwCRPp2Vcr7PVpotuYxWoXtRIvOPP+G
 fveEixAKjWCZ8uiTZSKG16h9laJlfxLbd4sP06gVUflO1IJzqUuxg3AgBR51xCETUnWt45LjdGc
 ldaV/viIegDLNz4d0aV4DwWIq1Dybe76pFCpQ1sK2m02EXJIM7tm6nZ1+Ccv6cDYp3FDuZT6LSW
 XXt6Z9U3yj2yu/jm0PNNbm/dzqfT5/BAFnpYSVQKU8TP4hnnkU6mqGRS6GUKKpcsqSDAvEkgt5V
 zCuf5ZiWSTOz3GpktvuaaQe8WTAZz5cstlBbHexkToERir+/PfGOS2sPqjeju0Xb6UOMpidYc66
 GsZV/kjsmLvmT6toZlAFnc/Z4h1PWiqov229jYA==
X-Received: by 2002:a05:622a:15d6:b0:528:3163:716b with SMTP id
 d75a77b69052e-52e4221517cmr82854031cf.3.1787762927872; 
 Wed, 26 Aug 2026 09:48:47 -0700 (PDT)
X-Received: by 2002:a05:622a:15d6:b0:528:3163:716b with SMTP id
 d75a77b69052e-52e4221517cmr82853491cf.3.1787762927318; 
 Wed, 26 Aug 2026 09:48:47 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e4275fc3esm20092651cf.25.2026.08.26.09.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:48:46 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v2 10/13] hw/riscv/device-common,
 virt.c: add create_platform_bus()
Date: Wed, 26 Aug 2026 13:48:10 -0300
Message-ID: <20260826164814.44335-11-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
References: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XJLskt3fT-3VuKUWhTxtjsN19lPy1zQ-
X-Authority-Analysis: v=2.4 cv=FPMrAeos c=1 sm=1 tr=0 ts=6a8f18f0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=8qX1o8pqpDL_2YrQefAA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfXwagzEW2KGaea
 757i3/DDvcyI7gpW1B2+/B3svhiy29HaqMJAGQp3ZTkimYNH3A6K1+5F+ZDpPzKu8iRmJzySw90
 nqyzvW0fNOCOiFw56Ut2btZXe0R0XzU=
X-Proofpoint-ORIG-GUID: XJLskt3fT-3VuKUWhTxtjsN19lPy1zQ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfX8hs77vDO1fFs
 8MCncFyw9Gvhp6vhG14rQRGRnLgfZe2DcTeRf98PuYbTuObVNicONYD2LcxqCF7TzsRNv2Um4a4
 6LprY78exmpseF22bUCNwodqLeieDoKDINu1F1s0rCShbqK2AaGqlFoSDMgmdwVPYYCL5pB273b
 E7DguAWKxuKc6PZgwoljOZWJEvN5NLy46IxlK2iRywwQm3/g0snVAzj2mHnWEH5mu3AtspZsC4/
 oahAXb0TRW26ATu8VIHr/9LyaVighTM36FHAZogSYpuV2gzF0ssJAVaY1LAGtuX2prSQf+xitFx
 JsKq+wkVyL0QpJNkm9MgRDe9AmyfS3F8yw0J0CQ87rqeULkrg8Am4TIaKBoMtkpdZ1SLaSgD7qs
 yytJNUivyEIDuaQTmHzIyP5y1nw+NPZQQ43zS5PJKpGmLHzTg2x3Bp6RE72KRQS7Dvp3MyhpP99
 kWNG8M7Cgbwa4Xheohg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260140
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


