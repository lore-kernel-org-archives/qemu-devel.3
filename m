Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E77C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziYu-0005gD-Mc; Thu, 27 Aug 2026 18:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYt-0005fk-NS
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:27:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYq-0001Jk-TZ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:27:07 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLxhk218898
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0QGz/8B7wCPNje9O4Qm1vB9zHh4pgJMhEaZHiw2hcZM=; b=hDc9wQ6ZzBj3COQw
 Nmce/lLz+dAWGy3IwHI/44xs/7/SLkjUAWxzCVtIjwditNlCGE3zYebEJBBOH1ZU
 xfrXBFOFtW28fEt/1mFcgQ+mXHiOLfB1WeH7t+XO3LqFiYg+Wlle4lhjLmVIHUS/
 f0LChPqWHdPNJnPBZGiEY+T6lsDOZAAcRzAC3RX7LDEqxV8e1UhfwYjKZdkntc4/
 r3flhKv37fAGUL5oCEq14RHawHKjYvvilWxj7S96qHHnWzhlY1iZOgVm5dpmPheK
 j/9L+jyuM0ZtKODOZvRAJ3JQIv4LoN01ZYWmHIzA1Lp+wubzff9HRrpl/jMxZzdA
 JPugQQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaphw23br-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934956beec8so65789185a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869613; x=1788474413; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0QGz/8B7wCPNje9O4Qm1vB9zHh4pgJMhEaZHiw2hcZM=;
 b=Bm0lNOjDVBgHI8X4/aUtUOC07P7sF/aGVDLRog7scBgIzrMcpXsb/1gAsSzHccejCA
 eA59BVqrl2qBmRBQwHifSS9XhehCLE9t3r3zwRtgLbTv5jEeFc+1g3qtBep5wP8+HTOI
 i6Os5WLLHjkxgzKLg/z8ZtNrNvEn5Kv2PJ/3neGhqP/jiuDyq1O3EcjCrSHPWEmTaVCq
 R9+PnFhgeohNFxk89BP7IcTDt7Zr/4ZNv/dEFn+I98g1/crznMRKyvmHMa0PKpas6dgf
 aVLTCAaedB4n1KjZs6iymotmIx/LKn02hLJwbS/IIwNgS2zIpDQwfALIF8XoX1D2hJ0t
 PELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869613; x=1788474413;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0QGz/8B7wCPNje9O4Qm1vB9zHh4pgJMhEaZHiw2hcZM=;
 b=KksfTzGPKCRRHYXaACmogaUrOJBLDY1Rzv/E3eYqhheRIrhlTujzQKhEGa07vSIEGm
 DN4/guaaX2dtBV3DjbJwr/aWP9BRydA6Z6Avdx6Dl9C4lKynPS5JHeh3hnv23yoew0lz
 uFGYde6tM1OTrEQ8o0ONsdgTa4ptFfIil2K3dw0uYkIITOS7/2vNsWfsgy6zAORyqfY1
 aHENpV5RjvZIzkpJ6cvSQrlz7eOnYmK4Tx90ob8CcQVTW/9nit+s1C9aCxRddvQNyPhW
 s76dbe8e7JuT7RC56yuhTKMcpFLpHeepWOToSN6zTpezG5da86Z7CYwU+ngNVnXepOwd
 Cbvw==
X-Gm-Message-State: AFuF++ljMTwAEh1jX33oRHO8PG27Vj1k5ex4T65HO3JXR2FvzT+yMXgx
 01inQQupwRePvlt/BAcrlbx+lpN33HCrpbpBJjpW/UNA6CSkmXFuEmgWNrIE3waxiQL/gbvGqr0
 OShxs2Xmm48+aKPnJqYk7uM+McKBDSkNQjcl0obaiWYy+rfwXaFSSVWq65t+uWz0F6g==
X-Gm-Gg: AR+sD13Sy0+8FjW8RKYQuNrBqoZaOp5DpnHDLFn+y9uhFcbvDEkj2Qx2xWa9j3mwTsG
 mAVT4VFreNzEhedjOUTL6N22nPCC/GFMgHaMclDF0BVxgCoSJQaz+Esw/MVC6Xfd8XitnxnXFS6
 w4g6S6uhQMEZEAbNJz9VDFnaFZKXKrop3Wfq5A6F94hhGCydCQVfrcqmzqsYkEoTjyU1bDv59xW
 +STVOIeGtyVpQp56G6MEL30KZXPJ8Q4kyF7OXXuima/BIQJrkmRhEIohn/ZwOFzfH/egWqsmT93
 ZdeZArl9fywnqqcF+HZea6f4Q89nto3Ct63lW6sGD6mHO7njUHfw03nb0kfUwBejOGiP84Q5Nnk
 nuEcvD4pCH6RWzFK3Up3G+jlI+XzEv4Gkoh05QQ==
X-Received: by 2002:a05:620a:7288:b0:938:ac3e:5a24 with SMTP id
 af79cd13be357-93913948cfbmr237326285a.31.1787869613272; 
 Thu, 27 Aug 2026 15:26:53 -0700 (PDT)
X-Received: by 2002:a05:620a:7288:b0:938:ac3e:5a24 with SMTP id
 af79cd13be357-93913948cfbmr237323885a.31.1787869612880; 
 Thu, 27 Aug 2026 15:26:52 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173a734dsm8924985a.26.2026.08.27.15.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:26:52 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 12/14] hw/riscv/device-common, virt.c: add flash helpers
Date: Thu, 27 Aug 2026 19:26:05 -0300
Message-ID: <20260827222608.329788-13-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
References: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cnUbDjtllPbzO5OPQ6hdGv0HgqUs2BUY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX6P2JFHvBFOBS
 1taffQEcfoKVKXv8BBncG18KZY0JerPn//0gMME1pOspKhh8Pa6CaTtGWToNw7phlQiaf+OnkkG
 NvieQgQb2/K9itAuk8kMbHsBM8m2XuY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX0iskdECeBUiT
 TS6iRVf7CzoVN1uzIan75mSeDBBFh908j8I+z2aU72tRon0BRgDUVCIFfrgbf12VjuiYcogmgCD
 UDFpUM4dhHWBJe6ZZT3J3CSu1jjutYpA1bDJqUAxSoTGDb120kJ0Eb1ge11UHb4nSqeIF1OIVws
 IFdRbclIxrsUzXQS8tpQ/ccMbNZ9cs2F1LmrYSpu/o2abUW+tYF0IXhtrgeR2xwqlVDOmjyYu56
 9ll1vF/THH4WbCRl99MJ+MAmN4bpGqbB8OaxLHTBNKWd4e9L/726EudyPef5Gl8ZbdM8Hd4wVQG
 0sdalrSUU7m1M2Xzcphss4vCTtyoUgsI4uRu6FqyRPBX3OIWCCNqgq5rLCK4zbOUoPZ44IfXXj8
 bYFPR7roKYn1l44julTnlmut3f9y9hFl7TGnWztqgKGggWWBd25vY3umJiCuiKKZgm7Qxucj/Qc
 ruGYxV2eyUTxEZA7rqg==
X-Proofpoint-ORIG-GUID: cnUbDjtllPbzO5OPQ6hdGv0HgqUs2BUY
X-Authority-Analysis: v=2.4 cv=E8b9Y6dl c=1 sm=1 tr=0 ts=6a90b9ad cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Faol744VrePhJRHcD5sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
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

Move the flash device creating and flash map initialization to
device-common.c.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/device-common.c         | 44 ++++++++++++++++++++++++
 hw/riscv/virt.c                  | 57 +++++---------------------------
 include/hw/riscv/device-common.h |  6 ++++
 3 files changed, 58 insertions(+), 49 deletions(-)

diff --git a/hw/riscv/device-common.c b/hw/riscv/device-common.c
index d3c68a9e71..a054cd7114 100644
--- a/hw/riscv/device-common.c
+++ b/hw/riscv/device-common.c
@@ -10,11 +10,13 @@
 
 #include "hw/riscv/device-common.h"
 
+#include "hw/block/flash.h"
 #include "hw/core/platform-bus.h"
 #include "hw/core/qdev.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/sysbus.h"
 #include "qapi/error.h"
+#include "qom/object.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
 
@@ -46,3 +48,45 @@ DeviceState *riscv_create_platform_bus(DeviceState *irqchip,
 
     return dev;
 }
+
+PFlashCFI01 *riscv_flash_create(Object *parent, const char *name,
+                                const char *alias_prop_name,
+                                int flash_sector_size)
+{
+    /*
+     * Create a single flash device.  We use the same parameters as
+     * the flash devices on the ARM virt board.
+     */
+    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
+
+    qdev_prop_set_uint64(dev, "sector-length", flash_sector_size);
+    qdev_prop_set_uint8(dev, "width", 4);
+    qdev_prop_set_uint8(dev, "device-width", 2);
+    qdev_prop_set_bit(dev, "big-endian", false);
+    qdev_prop_set_uint16(dev, "id0", 0x89);
+    qdev_prop_set_uint16(dev, "id1", 0x18);
+    qdev_prop_set_uint16(dev, "id2", 0x00);
+    qdev_prop_set_uint16(dev, "id3", 0x00);
+    qdev_prop_set_string(dev, "name", name);
+
+    object_property_add_child(parent, name, OBJECT(dev));
+    object_property_add_alias(parent, alias_prop_name,
+                              OBJECT(dev), "drive");
+
+    return PFLASH_CFI01(dev);
+}
+
+void riscv_init_flash_map(PFlashCFI01 *flash, hwaddr base, hwaddr size,
+                          MemoryRegion *sysmem, int flash_sector_size)
+{
+    DeviceState *dev = DEVICE(flash);
+
+    assert(QEMU_IS_ALIGNED(size, flash_sector_size));
+    assert(size / flash_sector_size <= UINT32_MAX);
+
+    qdev_prop_set_uint32(dev, "num-blocks", size / flash_sector_size);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    memory_region_add_subregion(sysmem, base,
+                            sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a2671ae341..9ff5beae77 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -120,53 +120,12 @@ static MemMapEntry virt_high_pcie_memmap;
 
 #define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
 
-static PFlashCFI01 *virt_flash_create1(RISCVVirtState *s,
-                                       const char *name,
-                                       const char *alias_prop_name)
-{
-    /*
-     * Create a single flash device.  We use the same parameters as
-     * the flash devices on the ARM virt board.
-     */
-    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
-
-    qdev_prop_set_uint64(dev, "sector-length", VIRT_FLASH_SECTOR_SIZE);
-    qdev_prop_set_uint8(dev, "width", 4);
-    qdev_prop_set_uint8(dev, "device-width", 2);
-    qdev_prop_set_bit(dev, "big-endian", false);
-    qdev_prop_set_uint16(dev, "id0", 0x89);
-    qdev_prop_set_uint16(dev, "id1", 0x18);
-    qdev_prop_set_uint16(dev, "id2", 0x00);
-    qdev_prop_set_uint16(dev, "id3", 0x00);
-    qdev_prop_set_string(dev, "name", name);
-
-    object_property_add_child(OBJECT(s), name, OBJECT(dev));
-    object_property_add_alias(OBJECT(s), alias_prop_name,
-                              OBJECT(dev), "drive");
-
-    return PFLASH_CFI01(dev);
-}
-
 static void virt_flash_create(RISCVVirtState *s)
 {
-    s->flash[0] = virt_flash_create1(s, "virt.flash0", "pflash0");
-    s->flash[1] = virt_flash_create1(s, "virt.flash1", "pflash1");
-}
-
-static void virt_flash_map1(PFlashCFI01 *flash,
-                            hwaddr base, hwaddr size,
-                            MemoryRegion *sysmem)
-{
-    DeviceState *dev = DEVICE(flash);
-
-    assert(QEMU_IS_ALIGNED(size, VIRT_FLASH_SECTOR_SIZE));
-    assert(size / VIRT_FLASH_SECTOR_SIZE <= UINT32_MAX);
-    qdev_prop_set_uint32(dev, "num-blocks", size / VIRT_FLASH_SECTOR_SIZE);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-
-    memory_region_add_subregion(sysmem, base,
-                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
-                                                       0));
+    s->flash[0] = riscv_flash_create(OBJECT(s), "virt.flash0", "pflash0",
+                                     VIRT_FLASH_SECTOR_SIZE);
+    s->flash[1] = riscv_flash_create(OBJECT(s), "virt.flash1", "pflash1",
+                                     VIRT_FLASH_SECTOR_SIZE);
 }
 
 static void virt_flash_map(RISCVVirtState *s,
@@ -175,10 +134,10 @@ static void virt_flash_map(RISCVVirtState *s,
     hwaddr flashsize = s->memmap[VIRT_FLASH].size / 2;
     hwaddr flashbase = s->memmap[VIRT_FLASH].base;
 
-    virt_flash_map1(s->flash[0], flashbase, flashsize,
-                    sysmem);
-    virt_flash_map1(s->flash[1], flashbase + flashsize, flashsize,
-                    sysmem);
+    riscv_init_flash_map(s->flash[0], flashbase, flashsize,
+                         sysmem, VIRT_FLASH_SECTOR_SIZE);
+    riscv_init_flash_map(s->flash[1], flashbase + flashsize, flashsize,
+                         sysmem, VIRT_FLASH_SECTOR_SIZE);
 }
 
 static void create_fdt_socket_plic(RISCVVirtState *s,
diff --git a/include/hw/riscv/device-common.h b/include/hw/riscv/device-common.h
index 12af031bbf..9f8bc67a1d 100644
--- a/include/hw/riscv/device-common.h
+++ b/include/hw/riscv/device-common.h
@@ -10,10 +10,16 @@
 #define RISCV_DEVICE_COMMON_H
 
 #include "exec/hwaddr.h"
+#include "hw/block/flash.h"
 #include "hw/core/qdev.h"
 
 DeviceState *riscv_create_platform_bus(DeviceState *irqchip,
                                        const MemMapEntry *platform_bus_mem,
                                        int platform_bus_base_irq,
                                        int platform_bus_num_irqs);
+PFlashCFI01 *riscv_flash_create(Object *parent, const char *name,
+                                const char *alias_prop_name,
+                                int flash_sector_size);
+void riscv_init_flash_map(PFlashCFI01 *flash, hwaddr base, hwaddr size,
+                          MemoryRegion *sysmem, int flash_sector_size);
 #endif
-- 
2.43.0


