Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D09C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03N5-0007mq-Se; Fri, 28 Aug 2026 16:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03N4-0007mS-Fa
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:40:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03N2-0006np-Dd
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:40:18 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SJ7Tf23331027
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nyKGR9ByEDWBLOAhMhaSOKX70qpsV8Bw3hlJiUJq8Cs=; b=pb3HzL18RmWOjzGW
 H30dy1AIXx+0SHHT2SR8FECha+YPCKaTiWcS8HzO+9CHOma/zGSdaQy3Z/qUCLX6
 FaQL+hC0gezGRP9EvnauFN4Uvvn/696OLHQODD46Vx8HLeh1x6kkPgxxUaEkRpyU
 zp05diZC72HW0UcqUNHPvXZ73YE7UQYfIgdXVaDEnhV3aypAMDY2+IxtPyZvAB0O
 eJLrelIAyJwxvdCkpkscQTwRZyXCfG7QbdcCGNnt1A7c6QYxxyACcGSZRJfPDt7A
 Y8BbLQ06jk3LePr30MxOdNic4fTijWSj1qyHBtKqiqM8jIZyGehKTHjUOevhXEtP
 xp485A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb42rbefr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:40:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93918756165so238945185a.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 13:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787949605; x=1788554405; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nyKGR9ByEDWBLOAhMhaSOKX70qpsV8Bw3hlJiUJq8Cs=;
 b=PqgpCqh3Q8OTNPbUCM1wuQmvzlUBPbl/pgJEuncmsjd+hq9Scwfd8ut8J/9Gk/36Ot
 QwiUpB4IT/jESV9Lja3un9Ie9VDyDZesbYj9iLzZ9WQNW8KXYYXKsIt0rBQ3Gsf9eh01
 F8uWjORgVs63AVnkQiZ5W3Nv1atzhDwKmsabTdnMcBYK/BHwrDgT6EAyjQ5Mrg/wBPSV
 dDZCYOxQXWBD+Bjm4mspf9Ob9ljsx0tMKxe29iYrB5vmif/15Fi+KvqA8yy2LfgZ/2G9
 7AG+OFwR1ISPf7lNBVOdkzyIULN9mG7QSy3YKfNwBJvIeHXB3kzPfBc6aLX4HgbjxJqA
 dd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787949605; x=1788554405;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nyKGR9ByEDWBLOAhMhaSOKX70qpsV8Bw3hlJiUJq8Cs=;
 b=Xz56Piryoq9qIr46ZzpkmkR3Zp8qIJHJ9rwfCeAhyv32hCLnUnHlv0cLQ12oKj1dVO
 k9TfN0IsqHYEIui7a9pDJM9UV6yVDDcTQP+fJjIQCjfDY5GYW4ACRx9Qj4ie8MqW4O6D
 1+AQcb6iVMywh25tibfFSLgNt5IpJYwLnNvL2vsY4Jg2aSc55lZH8TFY+1mJJTwjXOWB
 lHHW+97RdX4sMNk0Y23TuOnD7ciLGWHAWaSNnAwp4PlLu7eocnye74tlE2v2q+FvH9Oz
 ILrzi3qC8k9gusrAhHiPymdqmTUgVSqfqCB8dLP6ZqKO/bAklSB4rtsDJXubq2qu8rYC
 K7pQ==
X-Gm-Message-State: AFuF++m1e+qLM312MvltngnahclKtfNRO7n0YG9GQCXbkhVBK4SfN29h
 F2WYUJMNqHMPhLkHaR2Jpk84jYz9+4s6COBxfoxsAjgblclp5EMnFJMyFnRuhMeoEPdNVp+rD0u
 tpepycfkabPXln3BcwWcHYvmfshyIAtrimaOVoqw5ZvNVEB+d8RrjGKXCqLvDR9SJHw==
X-Gm-Gg: AR+sD130btwdtMjE6vw5IkrIXUQqYV+/4HQc+Rn5y2AvyUicgekvO9oLemOxojBeFGa
 s6oTslKStbJkrrvLHLqoEhVSEkO9+g6LtglHtysAK4X7v63UHx3bRle8E7HCYtdc6YrgtMSADqB
 BBCbDVK8VXoqZHEAR/3/Zoq4yGRq6LYGhblRWlM2xdqdT3dqZCLmGSTb9Wg+M1mlUtNGoiOwlr3
 82HGUbCYXkQ8qNF6JrBxBCKmzEr5vv8l/kRg4N7WjpSJkn5fBxw/BhtxGoUOLIxGUutzlF2FOsf
 yJM/dssco39TvY9WLYukbLyA36+AVX1+6rOo2XZI9QtMpQPBn3Bwu/kLQPgQ8AfPO5w8N4SiJJR
 U08tyW87Gmx4J3au77yVgX83AcYk+r+1NC2rZ1g==
X-Received: by 2002:a05:620a:2990:b0:939:1786:435c with SMTP id
 af79cd13be357-93917864d29mr772850785a.6.1787949604453; 
 Fri, 28 Aug 2026 13:40:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2990:b0:939:1786:435c with SMTP id
 af79cd13be357-93917864d29mr772841985a.6.1787949603901; 
 Fri, 28 Aug 2026 13:40:03 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173f2758sm218063985a.37.2026.08.28.13.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 13:40:03 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v5 14/15] hw/riscv/device-common,
 virt.c: add riscv_gpex_pcie_init()
Date: Fri, 28 Aug 2026 17:39:16 -0300
Message-ID: <20260828203918.350131-15-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: T1q59lwccNOmxaYCypFvQ1JCPgmjIDgo
X-Proofpoint-ORIG-GUID: T1q59lwccNOmxaYCypFvQ1JCPgmjIDgo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfX2gcb+9GJI2Nb
 nB3cXZnlvI/cnnL0c8AWbPa0if7fO3XLNfA0z8D2FcvGIPjf5SuGMdGDGYlRdiV3dGOWde59TEy
 9aFH1/u4mWp4dnxSxUYK0EbtW60jqv9vzoeqLg83knxyix/S6bJbGdQv4aZLwaNe4Iw6qCIQuRq
 vgygs313M4MBLJx3x8nWdfkUIFcMxWjnOa361JymfrhoezxkOvGq2miBJJsGilUCla3Y3Jun95d
 I3eSzwbmtNIBFz6fs9WTay3od4FHwM8ecIIQ3b+XkHoS6x+DfLJ2ouBybh+s2DT/F5iJ2rb3FBO
 LQ8lXrMhPGHBU9iPIxVhFqH8+VVKEB10Efk2ILFxfO+h3OtN/gZQyKrYh+e1GBx5wNYUSaUAKfp
 e3pFzpzKULWAQMlgUFK3240WbRslQSOx69yDIx4nkm+EvjZkmYuWMDd1TAE5lMXVMAebMVQBG+E
 wwFbNMzb0B5XJX90JZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfXypjiOPmTzuS9
 gxWt43LKl6uqoME+p92WtjNKUtuxBVQuok+BE8TI9izxzW1HjssA8JUrwk854IGHuP29Py5qR/L
 WaBuklEaAOD6pdTB+C9mjUu1UGRa/2c=
X-Authority-Analysis: v=2.4 cv=Fpo1OWrq c=1 sm=1 tr=0 ts=6a91f225 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=i57S3HUJNi793Ni1t6cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_06,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280179
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

The GPEX_HOST initialization in 'virt' can be moved to device-common.c
and be re-used later for other boards, namely the future
'riscv-server-ref' emulation.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/device-common.c         | 76 +++++++++++++++++++++++++++++++
 hw/riscv/virt.c                  | 77 ++------------------------------
 include/hw/riscv/device-common.h |  7 +++
 3 files changed, 87 insertions(+), 73 deletions(-)

diff --git a/hw/riscv/device-common.c b/hw/riscv/device-common.c
index a054cd7114..d1a6814f87 100644
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
+DeviceState *riscv_gpex_pcie_init(MemoryRegion *sys_mem,
+                                  DeviceState *irqchip,
+                                  const MemMapEntry *pcie_ecam_mem,
+                                  const MemMapEntry *pcie_mmio_mem,
+                                  const MemMapEntry *high_pcie_mmio_mem,
+                                  const MemMapEntry *pcie_pio_mem,
+                                  int pcie_irq)
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
index 9ff5beae77..d75dec2dd2 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -540,78 +540,6 @@ static void create_fdt(RISCVVirtState *s)
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
@@ -963,7 +891,10 @@ static void virt_machine_init(MachineState *machine)
             qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
     }
 
-    gpex_pcie_init(system_memory, pcie_irqchip, s);
+    riscv_gpex_pcie_init(system_memory, pcie_irqchip,
+                   &s->memmap[VIRT_PCIE_ECAM], &s->memmap[VIRT_PCIE_MMIO],
+                   &virt_high_pcie_memmap, &s->memmap[VIRT_PCIE_PIO],
+                   PCIE_IRQ);
 
     s->platform_bus_dev = riscv_create_platform_bus(mmio_irqchip,
         &s->memmap[VIRT_PLATFORM_BUS], VIRT_PLATFORM_BUS_IRQ,
diff --git a/include/hw/riscv/device-common.h b/include/hw/riscv/device-common.h
index 9f8bc67a1d..572912ec36 100644
--- a/include/hw/riscv/device-common.h
+++ b/include/hw/riscv/device-common.h
@@ -22,4 +22,11 @@ PFlashCFI01 *riscv_flash_create(Object *parent, const char *name,
                                 int flash_sector_size);
 void riscv_init_flash_map(PFlashCFI01 *flash, hwaddr base, hwaddr size,
                           MemoryRegion *sysmem, int flash_sector_size);
+DeviceState *riscv_gpex_pcie_init(MemoryRegion *sys_mem,
+                                  DeviceState *irqchip,
+                                  const MemMapEntry *pcie_ecam_mem,
+                                  const MemMapEntry *pcie_mmio_mem,
+                                  const MemMapEntry *high_pcie_mmio_mem,
+                                  const MemMapEntry *pcie_pio_mem,
+                                  int pcie_irq);
 #endif
-- 
2.43.0


