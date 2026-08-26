Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D107C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLT9-0003bJ-W8; Wed, 26 Aug 2026 17:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzLT9-0003ae-3k
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 17:47:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzLT7-0001QO-7i
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 17:47:38 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QKdp2b2341043
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HqLjL/zkQpFshhaPRziOHY5ff4D21FcvZ73WkXsU1Po=; b=WrEdrB3rKUutEhha
 57Gkh62q8TazPgNJt8H7araqkgKwAEnoBopuk0RAaVJf8Vw8yuEd1TiVfD7PaJep
 PrBF4UroM3NBB3NWqj2iIpjfYoPusofo84T+5rnHzF604s0qq/hbYAnOgxhqxhah
 wOtJXLzt0hT7rcE4+54P3m3rz2tlTo/DPWzKG++WQ+DGf6SDgZE3KGvHV4WHTBes
 cZVWjpbH8fLaFx3cKuv7YDRhEmJanNk+PCHORkmZzZy18WtpMEbPoGSPmWSySFbe
 EH89WPEWA3GkxJN8bVYNR/VtucrtRg3HCADqHHgFBDebEdptjSAmfAJq/ARJVI5W
 8FJ9Gg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4eggxb2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:47:26 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90cc2b97f8fso26308846d6.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787780846; x=1788385646; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HqLjL/zkQpFshhaPRziOHY5ff4D21FcvZ73WkXsU1Po=;
 b=DtlqtmFmoQOjd8dQli6F8fhanKdXODiUMpepbpfuSYoGA3+Ne9XoefX8kL0QGx6re/
 IqcG3cKA34q0v0jr9EbBiPq1fMEzBP4Bl2RRFMpg+Co3Bi4sMQ3v4Ts5Nq9ZpMdvOD91
 NxxhJZyw7sVdxz3XH7ZRkLPf0wZT2glkMzhGG6duC23UoBHBrCPR4gSDSqZdZXpMAS9J
 BQA9MHHynSentrNERFSesrubtp7Qonre/pG3leZsvHZvlybiMtbkWqWi+T+RwIyJmxc7
 3TBeVxph8YrZI8QnICzkGiXW/GHPpUxxFEmg9vrtmODSg/Np/yjqQp6UNfE5ep9mJ4iP
 JllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787780846; x=1788385646;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HqLjL/zkQpFshhaPRziOHY5ff4D21FcvZ73WkXsU1Po=;
 b=ZwsASoosIUN4Kix1LQQQxOV7huwij3mSTB7YSV3UhgkmZ2Sf8edDXIjZJExrodIhgw
 P+qPSZstYFu15sbkz5murXpM9t9oBZZeOw5/8oowQzzEC+s78LNhi3//BgtH14ydv9yK
 vbRuM6b05+vQw1rq5+lRmNENtiMxbiMXSCyMRb+pmZrtkLFbW+HCjJWcvXUdms9SaYYc
 RP7mJr9vNyRJrSQiE0LNS4s1EZNqxEVy9cW5ijIqYFEkQIu4Y56BJgBZu3clRdF1wQ8z
 ksHChIzoLnnDjIIWQNAcRFehU7o1A+Msi23k+GKzIDYK0uifkZjxY6lVov1xE0OqKclI
 vlvg==
X-Gm-Message-State: AFuF++k8kP2Fx4r3E81mac1UrbOc8sN0MCgZ9uc4seN8pQrnS3Mh9VwT
 0MExreh7yNiZ30jSPKx7yWGgsCNgjCg7Vf2NaxsIXBRNV94nRRq37/YcVACrCwf/3KVbz15s8k+
 H5rNDWGzU4jjZU1JVu9cnVh/8kQjdboBrR8MH3Tf4mLhZ+lQSuWmBuVH8FXOnmt2noQ==
X-Gm-Gg: AR+sD12XuyEqXmqagcyQ7NilGMinI/YckFholc2exxxGlPmu4KB0GnP287xPLk+conm
 CUqGXGOehlCa0duM72/ViEnOfFxar2uyPu5p1fRJnGWEekfl3Uox2ecD9tokTFFslFT94nuf+ao
 k2twrYeFMPaBxHG/dnel5rN7tLcZb6bs3RR2MaurqL19ER3LQ28OiY+VgmIBK2MZ1VHHc4LXERM
 e0Q26wV+s6DTV4AYCyq3U/6UImHjpynOtI9jIA+R6LZOkfrVFbtuJjHXBZD4AtSoRpcqHTAQWfU
 PHFbBiXnnrZnBP4EcU0o0A+8nIWI8mPU6Xa4BVov/qacFOMuYoYmMVGKwgfXcxTJ9NO68PJDKak
 3L2E5PRyZOjL52DgGF8exbZui57S3kimsDseMig==
X-Received: by 2002:ad4:5966:0:b0:8ef:1fc9:935b with SMTP id
 6a1803df08f44-90cc793cb0dmr105324016d6.12.1787780845563; 
 Wed, 26 Aug 2026 14:47:25 -0700 (PDT)
X-Received: by 2002:ad4:5966:0:b0:8ef:1fc9:935b with SMTP id
 6a1803df08f44-90cc793cb0dmr105323516d6.12.1787780845106; 
 Wed, 26 Aug 2026 14:47:25 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cd73e4117sm490916d6.24.2026.08.26.14.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 14:47:24 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 13/14] hw/riscv/device-common,
 virt.c: add riscv_gpex_pcie_init()
Date: Wed, 26 Aug 2026 18:46:41 -0300
Message-ID: <20260826214643.122728-14-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826214643.122728-1-daniel.barboza@oss.qualcomm.com>
References: <20260826214643.122728-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PpFRhd34C_7wSjagsLMk21GzGRxOsZ7L
X-Proofpoint-ORIG-GUID: PpFRhd34C_7wSjagsLMk21GzGRxOsZ7L
X-Authority-Analysis: v=2.4 cv=DsRmPm/+ c=1 sm=1 tr=0 ts=6a8f5eee cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=i57S3HUJNi793Ni1t6cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE4MyBTYWx0ZWRfX3MVJjRoVfjun
 XQKOLFv14xBDLt/6YF7jcper6JotXwYP22m8pI+iOZAQGZCI8tNjJf2pgl9YK9t4xqxRn5tjXv/
 Edh4/VJODHP/kJ3dGIdJVnu98MVcPsn/sNSHtM5tptgMWTQf3bGDprV3iMZVbHdLnEmKr8eHxs9
 vs60soWFzstCxnz6lH++fgjrWsVeki3IQcD9STppTQqHA0+AEjBvriDZL/LCrsl+DGoreomVZr/
 +p8Hd661iXxOfNe667EGwgM1jf9XDqoeWyx+vtLGzo7CZf8T2FdvrClR0mm8A4hAhjfMWSo8A1c
 +eTLzxEytwnFqoOc4f5ngijFQ+KapD9/Vhx9qdbybcnCP/BRB0BWe/KXp0c3mbTWEEQwCQeaWja
 A+iYYxTVblsedV8Hg64qGVFpw7IMRWpcGY0KT3BA81W5Rk5klFvZ4wmnrkA+vCteEaQs6DzJArY
 1LdCMrf23kO9xcjVO0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE4MyBTYWx0ZWRfX0IaztCACokIy
 DCNgR3NGbeGMqIVByOlQfXpegmgRA4iynReHH3aGdSmJfyAHSBo7bEwGs3xyZaloIiXHMedmbwZ
 dwd57oLKZaNx5o4xqjyepDdxLPafWFA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260183
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
index b033c19fee..c1cb98fab0 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -526,78 +526,6 @@ static void create_fdt(RISCVVirtState *s)
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
@@ -947,7 +875,10 @@ static void virt_machine_init(MachineState *machine)
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


