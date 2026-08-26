Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17371C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGo8-0006MB-Ov; Wed, 26 Aug 2026 12:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGo7-0006Ll-IS
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:48:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGo4-0000wz-S3
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:48:59 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QDumht1703178
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zik9fMnwPW+
 cjZ1etBvvnJ0/y9M6axxZ9bmNknOgDGA=; b=F+UIaS6UfJ+4/bXKxYavJjZocez
 tAZzRoLHy45mhYs7iwozxCg7IfjprUIzI/a4ivxBKLapQMcK9tVykU/blbcDvNcI
 Y6+0SJAbdGvBVzSSgaLeLG4CGCTTvqBmgVU1QUpX8YrIMxn8W9O0wOkPzrKKZB+U
 zszq68B5TtqAYOyCdsgDftW5AhfwZMO5N7y2jkJMoG+kulBoDuJHvYOKjR28JU2Y
 SnxUyyBM0GT3r8cX72FtLQ/I0C2ow2Jgs+qNyRvsiIQ2vaxvkEK/q05jlN1fyO4W
 xRpqv7JdY+i9oIEsYjvVl2Z6c7cx6QNNRawGk5XZ8GSS4phd7978j10J0eA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga0wbrtu1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:55 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90cc2b97f8fso21374616d6.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787762934; x=1788367734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zik9fMnwPW+cjZ1etBvvnJ0/y9M6axxZ9bmNknOgDGA=;
 b=jEjJxuaPfga5fLAP0ptSOxeUBzXYhfPYA2Rys00HcuCTJW4WE2u/VtLsMEPiYwzcEX
 4vDpHnLxspWAH6TK46zQ+z2PowoitqPwVN+iYOtlSm8o19g+0U4vSdCppgSZX0+BIf/P
 vBYw08ZJDvfbXnVRuLD/eGYUXutwIlNSXtcWtcw28SKaj6ZbQcrINcX1pF2fM+emZFNf
 J/09Jqd2HPRg9WmKURJ5vQRx5cwv5UsfHlsk64X6aopTGM92pb229sJgXRx5dIrJSLE1
 1U4RG+gxUTi6g0hs06Y7nPoB1hFb/LsDq8PcySUU8y+vHPcTuz6pXSIdm8aPG1zLYygs
 G18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762934; x=1788367734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zik9fMnwPW+cjZ1etBvvnJ0/y9M6axxZ9bmNknOgDGA=;
 b=CvRa3jQ5QLzI2f3zI8d2xvaY7gndpA+wu7ReM8IK37i/RTTmaqNv+3T38BX8aXXpzG
 NuXwA444OHxKsTfY+KdghgRgnvvAOFr0IfRaJFtd/52lob+L6uScy0FRhq3TS3Srf7AK
 CG2zR7S439nyBs95VTjfro7kOMADPZXw8fBRgOEHuIs/q9lYG4z9/L7Gzw/49k6Ivmcf
 Q8X8Dd9hxg5bD0mKOZKoBpym/KZAWjDHmaGFEbvHh6phN5Y81W2Wdq6ewp8apr7Vx3Y1
 JzDndl8XuQihEWKdtzBUQNqMiT5jY4COxblei2Fc0nF1SYC+K6xA4WTBSa6sm0elELxy
 AF3g==
X-Gm-Message-State: AFuF++npQqPjgQkfJYYbD5jxtFPstkIXLJk6O6VCBQxthhdPO3Mh+hlw
 qnH0lFewxoiVdhS4TiHxjTOAl8rAbx7ZJLtjHYxumzMWEs83ktMF0n4MEDMB3lIaayipWvJyxFn
 shs0pXM+5kwcxGoueSfMGw+6HAgkFci3/0dYoAcyfLY3n8/o1qxZeZKMDJdYY/xBJQw==
X-Gm-Gg: AR+sD11mdqMNxhamhICrmRvmfoNISYbwHD17RGMbZYScGC0mzC0M9JMfRIpVxX5N1C8
 TF815WOOyfNQ+nDyU4mV5GK2avhVQ/mUVxiWygcCLBLi951Ib5Yx3cyABoPE83mCxwECHLZ4C0g
 0UfRUtxW8cE7qtckoDteBIQdEjI8lrpzZYB5Nt6BEmPeDrlb80+MxFvXB4Afek+aKpBLusFtJeV
 Vo4JEToR7nGjCWuH+KJj13k2MdwM5ALYipgmzbatIEaZIIOIuM9CO2cXRUeYu44ulkoxucm7mYB
 O1coN9hpEPgHvslHGwu0Go60sciIIaIMYyVEskx7sTcuEYC/PqWVEqmpYEgs16528xQKrcrDCHj
 EecqgaYwQ4LY6Hw99+g4Otm/8jNcZCJcejDDOzQ==
X-Received: by 2002:a05:622a:5d1:b0:52d:92c1:b7b2 with SMTP id
 d75a77b69052e-52e4228f2fbmr76381431cf.2.1787762934111; 
 Wed, 26 Aug 2026 09:48:54 -0700 (PDT)
X-Received: by 2002:a05:622a:5d1:b0:52d:92c1:b7b2 with SMTP id
 d75a77b69052e-52e4228f2fbmr76380921cf.2.1787762933396; 
 Wed, 26 Aug 2026 09:48:53 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e4275fc3esm20092651cf.25.2026.08.26.09.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:48:52 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v2 12/13] hw/riscv/device-common, virt.c: add gpex_pcie_init()
Date: Wed, 26 Aug 2026 13:48:12 -0300
Message-ID: <20260826164814.44335-13-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
References: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jPDaI_il70YePWNg8cF41AOzTO4SrvzZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfXxS5Zypzy2eyv
 8pHJpSga3ir6HoqcrJftQE7TKIRp5A3jiq/RjIyChyg0OpxsvIa2NSpFf0Us5/KTdb1vNr6Rf8e
 Ai7OUqEUzh88Fb2zKD3a5pRr93UHvYU=
X-Proofpoint-GUID: jPDaI_il70YePWNg8cF41AOzTO4SrvzZ
X-Authority-Analysis: v=2.4 cv=SoCgLvO0 c=1 sm=1 tr=0 ts=6a8f18f7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=i57S3HUJNi793Ni1t6cA:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfX8rm72ol4S4hj
 Xa+2k3OX/lMNH4E+HVL2UEXUDQaBWO0jTidL3RF60AzAclTEUbscenydTraLmNQmT+ZSkukORRN
 RVk3FafGr9F2D00fEevkgDyWZvU20iGzhMkV35Z/fMQbLgRqke8fARb12ZeBB1vUaeLnSprexxB
 KnQqul+0GPF+4PiYtrePl9+VH8UY2DJxAKTmVTyRPi0HVHCEe8Ulg7oUw42+yJ48M+/hMW2V+O5
 e56x2c7y/CUCTmmBbvk/WpEry5vb7ZcpjvZqgg0qxj3ZKDFIQq4ks4agJ+V0Xa2f6PzTts9MphA
 bYfGPePb5I2XDy+M9VPAe3rbrxQxwFEjT+FWBBWf7aMFepiUYIJ93gbwwpgrJCdYexbwi4ywB+/
 rRDidSilIbHWAur6wO0yBcDCqFSVzb6/GRgg6T8/urMyN2R6Mcrukez2D0LGO2TWSeakN6TxZUl
 gbHoxQBxnCWgEA7QhMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260140
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

The GPEX_HOST initialization in 'virt' can be moved to device-common.c
and be re-used later for other boards, namely the future
'riscv-server-ref' emulation.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/device-common.c         | 76 +++++++++++++++++++++++++++++++
 hw/riscv/virt.c                  | 77 ++------------------------------
 include/hw/riscv/device-common.h |  7 +++
 3 files changed, 87 insertions(+), 73 deletions(-)

diff --git a/hw/riscv/device-common.c b/hw/riscv/device-common.c
index 03e85a7c86..49f6fb8dd2 100644
--- a/hw/riscv/device-common.c
+++ b/hw/riscv/device-common.c
@@ -15,6 +15,8 @@
 #include "hw/core/qdev.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/sysbus.h"
+#include "hw/pci/pci.h"
+#include "hw/pci-host/gpex.h"
 #include "qapi/error.h"
 #include "qom/object.h"
 #include "system/address-spaces.h"
@@ -90,3 +92,77 @@ void riscv_init_flash_map(PFlashCFI01 *flash, hwaddr base, hwaddr size,
     memory_region_add_subregion(sysmem, base,
                             sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 }
+
+DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
+                            DeviceState *irqchip,
+                            const MemMapEntry *pcie_ecam_mem,
+                            const MemMapEntry *pcie_mmio_mem,
+                            const MemMapEntry *high_pcie_mmio_mem,
+                            const MemMapEntry *pcie_pio_mem,
+                            int pcie_irq)
+{
+    DeviceState *dev;
+    MemoryRegion *ecam_alias, *ecam_reg;
+    MemoryRegion *mmio_alias, *high_mmio_alias, *mmio_reg;
+    hwaddr ecam_base = pcie_ecam_mem->base;
+    hwaddr ecam_size = pcie_ecam_mem->size;
+    hwaddr mmio_base = pcie_mmio_mem->base;
+    hwaddr mmio_size = pcie_mmio_mem->size;
+    hwaddr high_mmio_base = high_pcie_mmio_mem->base;
+    hwaddr high_mmio_size = high_pcie_mmio_mem->size;
+    hwaddr pio_base = pcie_pio_mem->base;
+    hwaddr pio_size = pcie_pio_mem->size;
+
+    dev = qdev_new(TYPE_GPEX_HOST);
+
+    /* Set GPEX object properties for the virt machine */
+    object_property_set_uint(OBJECT(dev), PCI_HOST_ECAM_BASE,
+                            ecam_base, NULL);
+    object_property_set_int(OBJECT(dev), PCI_HOST_ECAM_SIZE,
+                            ecam_size, NULL);
+    object_property_set_uint(OBJECT(dev), PCI_HOST_BELOW_4G_MMIO_BASE,
+                             mmio_base, NULL);
+    object_property_set_int(OBJECT(dev), PCI_HOST_BELOW_4G_MMIO_SIZE,
+                            mmio_size, NULL);
+    object_property_set_uint(OBJECT(dev), PCI_HOST_ABOVE_4G_MMIO_BASE,
+                             high_mmio_base, NULL);
+    object_property_set_int(OBJECT(dev), PCI_HOST_ABOVE_4G_MMIO_SIZE,
+                            high_mmio_size, NULL);
+    object_property_set_uint(OBJECT(dev), PCI_HOST_PIO_BASE,
+                            pio_base, NULL);
+    object_property_set_int(OBJECT(dev), PCI_HOST_PIO_SIZE,
+                            pio_size, NULL);
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    ecam_alias = g_new0(MemoryRegion, 1);
+    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
+                             ecam_reg, 0, ecam_size);
+    memory_region_add_subregion(get_system_memory(), ecam_base, ecam_alias);
+
+    mmio_alias = g_new0(MemoryRegion, 1);
+    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
+                             mmio_reg, mmio_base, mmio_size);
+    memory_region_add_subregion(get_system_memory(), mmio_base, mmio_alias);
+
+    /* Map high MMIO space */
+    high_mmio_alias = g_new0(MemoryRegion, 1);
+    memory_region_init_alias(high_mmio_alias, OBJECT(dev), "pcie-mmio-high",
+                             mmio_reg, high_mmio_base, high_mmio_size);
+    memory_region_add_subregion(get_system_memory(), high_mmio_base,
+                                high_mmio_alias);
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, pio_base);
+
+    for (int i = 0; i < PCI_NUM_PINS; i++) {
+        qemu_irq irq = qdev_get_gpio_in(irqchip, pcie_irq + i);
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
+        gpex_set_irq_num(GPEX_HOST(dev), i, pcie_irq + i);
+    }
+
+    GPEX_HOST(dev)->gpex_cfg.bus = PCI_HOST_BRIDGE(dev)->bus;
+    return dev;
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 6ffafae46d..af9de36726 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -518,78 +518,6 @@ static void create_fdt(RISCVVirtState *s)
     create_fdt_pmu(s);
 }
 
-static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
-                                          DeviceState *irqchip,
-                                          RISCVVirtState *s)
-{
-    DeviceState *dev;
-    MemoryRegion *ecam_alias, *ecam_reg;
-    MemoryRegion *mmio_alias, *high_mmio_alias, *mmio_reg;
-    hwaddr ecam_base = s->memmap[VIRT_PCIE_ECAM].base;
-    hwaddr ecam_size = s->memmap[VIRT_PCIE_ECAM].size;
-    hwaddr mmio_base = s->memmap[VIRT_PCIE_MMIO].base;
-    hwaddr mmio_size = s->memmap[VIRT_PCIE_MMIO].size;
-    hwaddr high_mmio_base = virt_high_pcie_memmap.base;
-    hwaddr high_mmio_size = virt_high_pcie_memmap.size;
-    hwaddr pio_base = s->memmap[VIRT_PCIE_PIO].base;
-    hwaddr pio_size = s->memmap[VIRT_PCIE_PIO].size;
-    qemu_irq irq;
-    int i;
-
-    dev = qdev_new(TYPE_GPEX_HOST);
-
-    /* Set GPEX object properties for the virt machine */
-    object_property_set_uint(OBJECT(dev), PCI_HOST_ECAM_BASE,
-                            ecam_base, NULL);
-    object_property_set_int(OBJECT(dev), PCI_HOST_ECAM_SIZE,
-                            ecam_size, NULL);
-    object_property_set_uint(OBJECT(dev), PCI_HOST_BELOW_4G_MMIO_BASE,
-                             mmio_base, NULL);
-    object_property_set_int(OBJECT(dev), PCI_HOST_BELOW_4G_MMIO_SIZE,
-                            mmio_size, NULL);
-    object_property_set_uint(OBJECT(dev), PCI_HOST_ABOVE_4G_MMIO_BASE,
-                             high_mmio_base, NULL);
-    object_property_set_int(OBJECT(dev), PCI_HOST_ABOVE_4G_MMIO_SIZE,
-                            high_mmio_size, NULL);
-    object_property_set_uint(OBJECT(dev), PCI_HOST_PIO_BASE,
-                            pio_base, NULL);
-    object_property_set_int(OBJECT(dev), PCI_HOST_PIO_SIZE,
-                            pio_size, NULL);
-
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-
-    ecam_alias = g_new0(MemoryRegion, 1);
-    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
-    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
-                             ecam_reg, 0, ecam_size);
-    memory_region_add_subregion(get_system_memory(), ecam_base, ecam_alias);
-
-    mmio_alias = g_new0(MemoryRegion, 1);
-    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
-    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
-                             mmio_reg, mmio_base, mmio_size);
-    memory_region_add_subregion(get_system_memory(), mmio_base, mmio_alias);
-
-    /* Map high MMIO space */
-    high_mmio_alias = g_new0(MemoryRegion, 1);
-    memory_region_init_alias(high_mmio_alias, OBJECT(dev), "pcie-mmio-high",
-                             mmio_reg, high_mmio_base, high_mmio_size);
-    memory_region_add_subregion(get_system_memory(), high_mmio_base,
-                                high_mmio_alias);
-
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, pio_base);
-
-    for (i = 0; i < PCI_NUM_PINS; i++) {
-        irq = qdev_get_gpio_in(irqchip, PCIE_IRQ + i);
-
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
-        gpex_set_irq_num(GPEX_HOST(dev), i, PCIE_IRQ + i);
-    }
-
-    GPEX_HOST(dev)->gpex_cfg.bus = PCI_HOST_BRIDGE(dev)->bus;
-    return dev;
-}
-
 static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
 {
     FWCfgState *fw_cfg;
@@ -939,7 +867,10 @@ static void virt_machine_init(MachineState *machine)
             qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
     }
 
-    gpex_pcie_init(system_memory, pcie_irqchip, s);
+    gpex_pcie_init(system_memory, pcie_irqchip,
+                   &s->memmap[VIRT_PCIE_ECAM], &s->memmap[VIRT_PCIE_MMIO],
+                   &virt_high_pcie_memmap, &s->memmap[VIRT_PCIE_PIO],
+                   PCIE_IRQ);
 
     s->platform_bus_dev = create_platform_bus(mmio_irqchip,
                                               &s->memmap[VIRT_PLATFORM_BUS],
diff --git a/include/hw/riscv/device-common.h b/include/hw/riscv/device-common.h
index 1cdb8ab5cc..77760e082c 100644
--- a/include/hw/riscv/device-common.h
+++ b/include/hw/riscv/device-common.h
@@ -22,4 +22,11 @@ PFlashCFI01 *riscv_flash_create(Object *parent, const char *name,
                                 int flash_sector_size);
 void riscv_init_flash_map(PFlashCFI01 *flash, hwaddr base, hwaddr size,
                           MemoryRegion *sysmem, int flash_sector_size);
+DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
+                            DeviceState *irqchip,
+                            const MemMapEntry *pcie_ecam_mem,
+                            const MemMapEntry *pcie_mmio_mem,
+                            const MemMapEntry *high_pcie_mmio_mem,
+                            const MemMapEntry *pcie_pio_mem,
+                            int pcie_irq);
 #endif
-- 
2.43.0


