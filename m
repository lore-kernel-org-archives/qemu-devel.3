Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86373C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Mv-0007cp-3X; Fri, 28 Aug 2026 16:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03Ms-0007Tf-Ar
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:40:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03Mq-0006df-73
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:40:05 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SKa0et492786
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0QGz/8B7wCPNje9O4Qm1vB9zHh4pgJMhEaZHiw2hcZM=; b=FgZSJbE598BdhZ+z
 I94OwF7U3/E4ZlmYJOX0pbfU+upd+FTI19QGpz9FHF3Nwk1n0NIb+Qee6+nZbVm/
 WoBGdlUSN5OSpp7f1FPx0iZ/pp5o/ZD3nT5sm0UElczPIL7U2YaKJ3VmRbxY+ssn
 BhLPPz76CeGx6rCn51gf1JvS7OPWhpz1J297Oc4xl9Z5E0kWWwuqk2RyoLkENUjR
 o6WtC67No0hve0ge29oAoYVeGpG7edn/RMoC8XIbAmQHAtT80QRFT3y/MYkzAnAK
 LqhBwJRpi+QaT8gDB8IgoiojosnmIaBcJywWx2FE4EDaSHWz2swIQu6C6c2bnbfx
 V32Dkw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbhgtr0bj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:40:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-938153538caso250602285a.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 13:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787949602; x=1788554402; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0QGz/8B7wCPNje9O4Qm1vB9zHh4pgJMhEaZHiw2hcZM=;
 b=VCB7G7e9A+jDO7fxyuNOfuajUSXURiIoS/98ELvRvAzDkUcgL/VagqH65hm2kyshu9
 oM0+0XCku63RaN9VzjQC76xafq2jCXjNizqu7r3ZbGFNXFHBQrWqSd+aUJJ7yaKEw0fA
 Gbk02JGwK+0f0KJK2Ty/x8mCUu08wt33Ntuoi9pfbq3NF+c5cePQl30dnzM6h4GW8o/K
 W//uNhCttZpFkNcdF2QHqZOXCiUSEK4y/5xI6cLpQxXhCBroDkongxusFwXSb37yNOBW
 PoMXx7I+qzREn9QtAQou/VnzgnhjPsX+0LnmsD/np4qk/CEp5iDhtS4rvA5tyWx/NtOd
 ArPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787949602; x=1788554402;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0QGz/8B7wCPNje9O4Qm1vB9zHh4pgJMhEaZHiw2hcZM=;
 b=iTUgvr2HfJIyzA8m4OARPN0NfK5gQkGVu4vAjtk1p0vtB1qAUL3duKZ+fDCQdpdUX8
 AVZMqWBRuqSJtXjWnrF+fYwGK0+cIbFchYD1nD44k47d3jJymsWW8BMttZ1L7wqwkUi3
 d2sYUKOiN1pMAvY43IjN06WwcClvTaqU0p2BjhkSzdm4ZcfgZGnntSckafJLTfg61W3J
 1P7P2ed53xc2CJEXNUlimMevvBLOTPtyAZ0nP4ZVKC0wCyWmEMmZphsRJx6L+WRANqWP
 bO8/sqeaZtI/KNDaF9A5GudIugiaHJk/2Q5LFtNJQcCSDrddV6GNNyIckCWpV0927IVC
 j8dg==
X-Gm-Message-State: AFuF++mCcyh1Ksk5qpH+I1psmS/pEs3CuHxPJrmJYORnEq4SFldWfBU5
 qgVA0lGjVVaKGtki9X26UKlTMMP0weHQDcjo/H6/vsSdQuHvPGBcRmW4lHlqCnUC3JkPSOdX5Ij
 2CXRBKG6bLItZwSP5R3rjXJPlR3Ab3+hccJ9ikwsJmxNuPjfOEWSCgrvHPcMrHB6JiQ==
X-Gm-Gg: AR+sD13NueEKAF7QPIkwfou3BRwRwR0yXhK5Vwj9oEGl52ZscBkkFsI2VSBvPTWpKie
 SzZyfRAmGPuCuNyjoID2kb5PkWMSj844Mnr3WUniNx7OnSqobJ8wkRDQ6iCVUzRcikVrjvsuM1g
 YcEQZFbrA02u1hqWBBDiSUYxj72six8ISQvYJReiYgRlFqSR7CFsps+PPk+RtjDVxrkc9wf0gFz
 U6jrwdon8C0h2XePNIRs3cJ2CPRZx/dZn9VE9t9ZjwjulyqsXfW/fpt/Czbe+1WDp4OnL0Jzu4w
 bLsXpjKYl4612J66ePrFnCmOkVHemxuGflY/PHdEpTpjyxP3CMthBugo08lqE1ouNkH4aAi/Gor
 pePKgce3G8mb/92HSqRiGjO2sf0m2n9nb/a4dmg==
X-Received: by 2002:a05:620a:ac1c:b0:925:e485:fca7 with SMTP id
 af79cd13be357-93913804c88mr1054418785a.15.1787949601799; 
 Fri, 28 Aug 2026 13:40:01 -0700 (PDT)
X-Received: by 2002:a05:620a:ac1c:b0:925:e485:fca7 with SMTP id
 af79cd13be357-93913804c88mr1054414185a.15.1787949601357; 
 Fri, 28 Aug 2026 13:40:01 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173f2758sm218063985a.37.2026.08.28.13.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 13:40:00 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v5 13/15] hw/riscv/device-common, virt.c: add flash helpers
Date: Fri, 28 Aug 2026 17:39:15 -0300
Message-ID: <20260828203918.350131-14-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfX9Ey/6258e4i9
 Ki93dt1sgmwTvNSxrfAKgfQUmT35tFrROjkThjWerTl31BbHybIH1+PzrlzPjeOtTEywndOQY1C
 aTCYxXKLIUlCoEcnWWmBL1YT5Lee5cg=
X-Proofpoint-GUID: K8YBg8UPORZyrv_ywlhMeCDz__8ca4wj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfX4l599uFB1g/r
 jjFxJoGr0uOcf3B5HPTRpjBE07SCCsjok2eTHCed7nBHbIkRHjCBrxNaddaG4D+Ksxr6cLZ1yek
 6llRq4Wccpm4h9+X6EYoVR3K39mJDeU5wuxMAKGQrGopJEtGtrkWtS1Y0AiPZRgCrEaNTaIVX/h
 jvS51/GlkFgunxxlqU2TUv9enTgBVq/56Mk3iGrr2/hwkOXaBQT/k0kvF0tgP9de3Atp/CkoJD6
 7VdjkcBlc7GoahUymE8RF28WgNchvWXDuFUKnvS3zApK6siYjR0O2Ma8x8/7YuOe/irC+QXDnIP
 0UKg/Azpbx/gdh1opuwZo37OjgeHzfUud/kIBo+9Hf9MXkMUrlcC4LuGceNH3Umq6ov0BXnGc3q
 ddp0A5511/49ncun48OojVSmsIv0o+dDBh8qGg9PCUaGca96tEQqKpX7NTkEqi3qgmFU8l4Y+LT
 kHV86l/v3nzZ2NLErUw==
X-Proofpoint-ORIG-GUID: K8YBg8UPORZyrv_ywlhMeCDz__8ca4wj
X-Authority-Analysis: v=2.4 cv=e/A2j6p/ c=1 sm=1 tr=0 ts=6a91f222 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Faol744VrePhJRHcD5sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_06,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280179
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


