Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7549C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziYw-0005l2-Jo; Thu, 27 Aug 2026 18:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYv-0005h9-H6
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:27:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYt-0001Kq-J8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:27:09 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLume795150
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nyKGR9ByEDWBLOAhMhaSOKX70qpsV8Bw3hlJiUJq8Cs=; b=m+ciYOXQuvqFpkd4
 vrCBjA2BVa14O0m6h/uArov7DL3EEg2L1FQtPG45qGr6S0L8UIixE27pgqVWRlxk
 0GoDJG+i5sNsdK7WpTtvIPhu9L6j+seR1WWZ9fT62/y51fJEyJNrzk7Y1s//Kf3n
 TzllC+obB/KX2LPklrdRBI9V2ID+hkeQdijbG6EukeYJYFv3y2kYcw+Yh85Ze59O
 TcZHbUQS7kKxPsFY7F754pb+k2dlofJj5pqX0giHUdesQP0IoXpVspkG2NlMmOEq
 kgeaCEtnOFUViXw2agr9lLxCuIF5gSyD18UPCYsnJsdnEwx8xK6CHllJeio3Ytxw
 vq8GUw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gam6fjp62-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936e393061dso13997385a.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869616; x=1788474416; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nyKGR9ByEDWBLOAhMhaSOKX70qpsV8Bw3hlJiUJq8Cs=;
 b=XgvWT4+94FVMoStGtdZ+TtwGnNMQJD9L7ZB8AmBere0+VkHYJUXtMxa3Tyd31Zwq3e
 FSh4V4rNFDqE/WaHYmlXny8lqGF7C00/9Jm0qB/OMU2rz+pbViKzGpe7JiJwpk1A9m6u
 hk+bHh/pKh668xZriXR/OedGtJQTqeZ8a/DKKfn/13Gy0PG+rMOw5avuv6ITp+zd2dT9
 EThUas7jkEjNxfD863p5dKvXzqk1MZI+i1uYflBAdY++HDHWIy8qL2TT76yS+DdG6kq1
 UzXNG16SpxX9mBcFYvn6E1C4o/46KpitvWJIcphIATZ5r9Neanh2smUE7YZJKzO7+P5g
 j/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869616; x=1788474416;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nyKGR9ByEDWBLOAhMhaSOKX70qpsV8Bw3hlJiUJq8Cs=;
 b=BkqQlGvM31ZScGs+XGLrv+xu1hLOEI6Poxt0URoRCJzN2eDeEJVMMeRnJi1nYlYmwz
 1JAw951+FYruIono+E0ZayqKbTmTlDlcefLZUnfZaVLvad7m/oMDVClmq+mMi5HqxsfR
 EU3gnTUvD6c6H31KKQKiL77UhHsvQhq7sVVHg6Z76Eg8sa8QCVIGy4xRb2AjCBi0VEAZ
 ILwoFLjx7LLAIJrNobROJkBsp90zVC3nTgCv6/asOIHeDMuP9cAt14SOsVeNqH+UCCtP
 J/wxpzNQK5lAu27g47pOg5hmWnKO72zSFvqq8yGSBKIGjZt43l/XiNaIAkRxuCLHefOH
 Cg/Q==
X-Gm-Message-State: AFuF++nuD7OsR+4JxU1O/8iQq8ciHC4Uw8LIEu2zk9gzpliOuCpNWNGf
 XxfwEJoCsV7hIQ3XIJE2xJv5pVPJgxBmwg9zF3kTvHL9hl+YfqYTyZ96J6fyoYF/3wltniFTdUk
 mXTPJH9JNfxt1JaK+tacxbt/IuSEWRVGzt3I3ytidd86GIW2r4+l1Vo3VhIdE4k0kwA==
X-Gm-Gg: AR+sD11Sy9vnopUJNuT0SG+lLvrCgiT4xaIXJ3wp1KgYbQFpmpdDlxbkGznd2kk485F
 imiVLJWmFCS9/h5w5gCylmO7V7zIHqbuWCrRyqr2+jI0ZupuYd95f2pvVX1qNfvhwEqss0hny3R
 6f5fUgkKmgpfIfNSAqWR/PcdHGoMpTB3lGReJOzyyYq/z2G7XW/zBAUX9L3MgvGrU2/yV4pi9yZ
 ba4wNPGScUUaFlRFg1nqJGUsV0ex3HktWZSIPwptU5aeJtoV6RAmXHA2esSpJorTZSoov7ybutK
 VyiMvpVyLZ++3eiOfaJwgJrK/gsBxhrgnZbW6TlzpI3WVm+zluF1B9gD4aqpu7kf0SAAr59wdfq
 J3be5B4Ynsn27pXdwRMj1xnIxSR+uNzbPALxQCw==
X-Received: by 2002:a05:620a:8086:b0:939:16f6:4d01 with SMTP id
 af79cd13be357-93916f64e85mr50337985a.21.1787869615871; 
 Thu, 27 Aug 2026 15:26:55 -0700 (PDT)
X-Received: by 2002:a05:620a:8086:b0:939:16f6:4d01 with SMTP id
 af79cd13be357-93916f64e85mr50330985a.21.1787869615325; 
 Thu, 27 Aug 2026 15:26:55 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173a734dsm8924985a.26.2026.08.27.15.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:26:54 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 13/14] hw/riscv/device-common,
 virt.c: add riscv_gpex_pcie_init()
Date: Thu, 27 Aug 2026 19:26:06 -0300
Message-ID: <20260827222608.329788-14-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
References: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX0Mxd/fXkNuXK
 j2pEqtddTFkk9dkOS0ezh6+YfZox0b47sWGDsc3Ac2mIXJDMcZCvHuA1Yw+U130zJtqa5GyWwCp
 uylxHvnU4wjxrsKB777Cs9lEEz8M4UM=
X-Proofpoint-GUID: DxnxmhRHYcOBbXjAh_3c2agQDUpfz7L4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfXyhnViq7pAYMY
 oi/dY0o2uS7ZfryQ7am5/o/a+CmDnGoVGdUwQnSeMqsCdN2/Qr15jv1R3FF8MQZnluAyauW7KkW
 kEYArsMpyeVjOZmXw2tFhegdNoPhaqNaEvKeXc0KFXtHAhBkXpywajV+csPlf0NQuhDiAdfd6Wg
 WT/ndBCqErCgDJy2QNhz66TwVLIMEo8qZXmZxS/ud66sHzNXh7nnl2HAT20JhodwBj0fy9+uR3c
 pbKbjjf63tnEOVQK0yhvZUy8lZuZNfc7suhLUmr4UbrB+mGlwMpviMR6gAutmVfq/kYPtiqf3k0
 CYgP01LpdSPjatZRXDArqqNjz/OnyDRXlGCmRpLy93sMKAp3e8yLGKPBE37/XyK2Us725VW/pAF
 5m2VR5ENgKNPL1P79QB0/fgCUSYRFki7HT/w1V0g8NB7+INA9NODjYEUAPQ53tXhkHFXiKLkNQd
 yG7p5jm6mgFQPqyg1Mg==
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a90b9b0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=i57S3HUJNi793Ni1t6cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: DxnxmhRHYcOBbXjAh_3c2agQDUpfz7L4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
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


