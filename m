Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C7CC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGoD-0006Pd-MO; Wed, 26 Aug 2026 12:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGoC-0006PM-B6
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:49:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGoA-0000vw-HZ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:49:04 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QDunUt593273
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=sKbGwJXyn+M
 cuKxpE6iklpsr3F53nmaiHi3Fl9IxJqo=; b=cE+mt4D0aEPmO+goMV7LYVrWVYz
 DiRMoWFiCVNznUQy1K29Ix7icmusLDcaxUPn3Yfk7k7UsVLrf5y4TDkjscm0EvOh
 RSHv7Ur1VCUZdFoKsh2hVmfeX4wfB7i4pBppNHGjx7MkVePaaX4fQGK3fXKxKdYW
 c0SHbLbAmuz07TsK3uRTO0mt+selVu1FpcKoYnwlbZzy65kqhUJzixXCBdRsICcO
 utG42JwLiHIeSopbLgCBaEs/1ov1rCCQZrELyaOzBNNf388S9wUGlzMvxB99JeHh
 pSBSCVC7gDBFaNxllXu1iRXY9UIfzAwtSHZxme4kJWmGMtRcEHPJqkdUQYw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9s9gaumk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52f52ccd459so6408201cf.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 09:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787762931; x=1788367731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sKbGwJXyn+McuKxpE6iklpsr3F53nmaiHi3Fl9IxJqo=;
 b=A+EF+7/MVCZmHLRIldEytFdVoNezxK4YEpMbpkqBzLKgbXC32qWvA89kFDhHJidteZ
 cwEgD6FjQlEnagTQ97CZvm1a0GA5Gqs1gBbmsaR+FHgI+sf1vCfFqsntxXBfkq2uOjb+
 N5YCyvmH/Kpg8ChVXrnn2eOjnn63eoxBimOJURSint+NmHZxdmXYoCdsM/owdPhB/Vqj
 jerdrG5Z+cSb1DDXyfDT6L+w5r/OH6Vtfo/JNo5Oy0kzaHWAdrVaajGsk8NNZjMVYnYW
 P+Rtx8JLxbD8Ob237vQvqV9f8t72y7r5Vtn3TBrQulyL9nIhYMd4/GL9GBF1IetT5CVJ
 vLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762931; x=1788367731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sKbGwJXyn+McuKxpE6iklpsr3F53nmaiHi3Fl9IxJqo=;
 b=rZM+CKy/F488FqC3VkfThwuTilvosMiDY7DUCqvfEGATGyCmp1hMBzhlp0C6kgkzvR
 EntW8kmCs5gj4vGjdEyOxomsrNWijSo+Z4V3Rnq7B8zI03rv0i4VYiwHhNNDP+3Je9zl
 9HhqJ9QiPWaOis1++ikBriVnOLk8X70SPKynwy/91m0aFh2DEKFo0RPSZCU7w5adDbIj
 YFEAi/8V34zHXomB85Lox9JlLifkxgE4UBR8fdmnrP4j08/rMm77OFS71JTMx7HJsgN5
 1C6QUYbgIwiGAHVhQoaRjItAS1zttSXnC++NTE6okFP9mFLUbOOKTOyxW/8EhYN5r+1A
 mIkg==
X-Gm-Message-State: AFuF++nO9O+vXVso/EP+EfZ0EPha2UDI0me5cIb2du3UWFs95fUrQqOG
 4j+YDc3KnZYtbcOFn2gUsPpQs3yE/YWu8M97l4IC1thvOgeGSKuFD7JpblmBERBLB/gk7RoEtw+
 w6LAWdcPBgfPNzDU+KFDCeqGmfuB3eoOeJLkI/OaI6o5oU0yX+O/EvbuNggRKIZu63A==
X-Gm-Gg: AR+sD11/qBnxDqcJFXTlCE2BX7xUMSJ1QEcZpeMgzFcK2m7NrTIim7mtC0s66wvRx2m
 8TIg6RECHtEiwUF6Z37awRxeRiMUY+8J5sX+OPMEZUmatqmtxmjXUdzLwRE+7b0XWiZU5WJz9qA
 yaE3SdjGd2inB5hJTTncggJYvOhD/moNWBCmWUTJ26YsNrOFh+vu+yefUnqhDONe87s0qybIr8d
 zNW8u6tATCSkSzvu6VF1e55zRfPD7d40wgMjTGW1L10rG/w8kk7Rh7Lt+wne2kPyVuMi84O1IA2
 cPeVMEevn9QFGdeGUijlYftIhYYsu1WQ77LqvLOIBDxTSHlW5p16K6ZEUFZnxxIUE204gbh2Sc2
 tF1n0pkfnHbaHFKalxeH8LUTkPFxJos5CNTUugg==
X-Received: by 2002:a05:622a:8319:b0:52e:f03e:4af7 with SMTP id
 d75a77b69052e-52ef03e57f5mr37906451cf.17.1787762930786; 
 Wed, 26 Aug 2026 09:48:50 -0700 (PDT)
X-Received: by 2002:a05:622a:8319:b0:52e:f03e:4af7 with SMTP id
 d75a77b69052e-52ef03e57f5mr37905881cf.17.1787762930318; 
 Wed, 26 Aug 2026 09:48:50 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e4275fc3esm20092651cf.25.2026.08.26.09.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:48:49 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v2 11/13] hw/riscv/device-common, virt.c: add flash helpers
Date: Wed, 26 Aug 2026 13:48:11 -0300
Message-ID: <20260826164814.44335-12-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
References: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Kn1eDnQu8gUjTCAUJj2fdAdwA4GGfokr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfX8TxZLam6CBbv
 i+Xz1G7mCeO8mimCz3OTgYmME1QDyaHX3QroJahHArahp1GbOPN4maBQirOLNhe8PyzsFfUpZ6H
 Gxbo/BiZb8cNs6nLN2QmgD+NhR6YJYrOMtOHBlO5T7K4Y6I14KY5cKlRepbEcxnOui2MMEH4PT/
 36Xqtx+uGaj4g8FI6o6plCjVI37jP3rxiH+IW7RmDqPqt6CO+AtF1oq98/KC9g8MN8kIMne21r6
 JzHq8ItAOtXt5iZButbMB936v9dYe1ODPULQVVINkzZTc1SzXCbjlnXlFlKLtx5bmKHF+7djeI6
 c+taJUNTXAijsp9GC9yT3Oa4m8QfL1uNhiDpF+6KBkHbhPOVJEIc7E0SaxRi5fAzfk0dOAn2k+0
 CshNSryUPpOkRKB6e7/AlY9UrgzE4zHHEjr9j7CWIsFGQu08WOrDq0NhnIKYtkqWWyCm2ZYtzxC
 KQBBBsq73vDkpQIPYog==
X-Authority-Analysis: v=2.4 cv=Xfq5Co55 c=1 sm=1 tr=0 ts=6a8f18f3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=Ak_EWCeJEXv7LabEeCgA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfXwVZKN2AUoxT9
 wUW1i3vM59o27xLhLi9XUHjapJoHDXoSypPA9zXjrbk4dLOgaNBDWFr5TINnj8BacC72asT8lOP
 cVLD0mhst3ZSXes+stw2FSh8atHzTGU=
X-Proofpoint-ORIG-GUID: Kn1eDnQu8gUjTCAUJj2fdAdwA4GGfokr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260140
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

Move the flash device creating and flash map initialization to
device-common.c.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/device-common.c         | 44 ++++++++++++++++++++++++
 hw/riscv/virt.c                  | 57 +++++---------------------------
 include/hw/riscv/device-common.h |  6 ++++
 3 files changed, 58 insertions(+), 49 deletions(-)

diff --git a/hw/riscv/device-common.c b/hw/riscv/device-common.c
index 74627b996d..03e85a7c86 100644
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
 
@@ -46,3 +48,45 @@ DeviceState *create_platform_bus(DeviceState *irqchip,
 
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
index 7ecc3aeb6e..6ffafae46d 100644
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
index f91c39511f..1cdb8ab5cc 100644
--- a/include/hw/riscv/device-common.h
+++ b/include/hw/riscv/device-common.h
@@ -10,10 +10,16 @@
 #define RISCV_DEVICE_COMMON_H
 
 #include "exec/hwaddr.h"
+#include "hw/block/flash.h"
 #include "hw/core/qdev.h"
 
 DeviceState *create_platform_bus(DeviceState *irqchip,
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


