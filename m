Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4842C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyd9-0003qH-Sy; Tue, 25 Aug 2026 17:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyyd7-0003oP-IP
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:24:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyyd5-0002MU-MJ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:24:25 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PL9rWP3099221
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=sKbGwJXyn+M
 cuKxpE6iklpsr3F53nmaiHi3Fl9IxJqo=; b=TmnCd15WPZOsPEFBf7DEUPX4+3l
 haerKTnzY9oDQ8IZqu84gzkFmn8/MOjeSEVdnLPLyvclSxzbsXyann0N9ZZdyYsf
 p54ZEOKB9qNek2wkKMuzKMXV1xVWp0BVe8RTFiwBzTF84Br+BvGuRniQphAupbev
 WHTJ7mLykzr3v7fmE+UK9k2SxvsFLabDlVqNTUP/yoSUD24cNhGS+Maw5Pth9qVq
 RPrfwwvNorXmCGSngJrIRSDuQiGnpvXz85XUJk49jzSq1qjAN+SOii6EyvCuFzRO
 hYj2bL+jLcoDExlbxyT83Mggd20FafwLQkU/mDDGnWcTEBh1MlUxMFNSc6g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9bkua1x2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:24:12 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-904ee4473a8so3027826d6.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787693051; x=1788297851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sKbGwJXyn+McuKxpE6iklpsr3F53nmaiHi3Fl9IxJqo=;
 b=OWUU/tJREx8IodSFRamTdgaQT88/COubu56pwQBCJ18VhxdSp/OvBk8YMbiIhQfe+I
 t9YsDoIMVGGpj+UgNPYlUGjFB3Bjyxmu8LQoG+Ulbu+GVWIXMxkqdp5xBfjqsebTX31g
 VGJ+XRwG1md2OjEfD3IEve+C6hTK//Cbol2aP89bcKhKaERjFS8Dr+U+sc3xauqa7qzu
 Q2N/b6ZuSl5l22+IFBAd4EAhvPHVLfUg2urytV79uaMpkowA61DAsjBl3mfzJGXXILbx
 IXGsXwFRc7OJAheRc2iQD8SBchEu4NMlRdLmwjeYHEuYt7qzIbdg94TnQ2CBrFB/RTrJ
 +aJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787693051; x=1788297851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sKbGwJXyn+McuKxpE6iklpsr3F53nmaiHi3Fl9IxJqo=;
 b=B7eyOw5bt9KIbozKXoiUT264qNRcHXL4ZNDSAwcz+50kvI8phvGErAr6DPzZpw7dn5
 hks8pTS7iJk7qjiMr5w8DKliay9qtVGILGhJq2tsfbzmwQMuQCgfMWgYARw9D6QvsZtG
 K3jnEUZUWcgAhB+58YaJ4i+dksjIveUHn+BEQA6yYdqHDDaHPn9Vy+0asGX6U6hLpyT/
 l5GV19h7BVEjKkUdAUoJCzmmSP1xmHCrJHU1W1lYKkcRHnYYS3Im07SwDNGn6e87+10c
 XtnCULIFj1vghJijF9AgWF3uwp2D9oxSoG2qc8tg869aN2vP/KTC2gDnmocAcBlY5bv1
 nPwg==
X-Gm-Message-State: AFuF++nKK+B9NOQbd9AkXhmGZ4HDbEaZntugm3i5WdJJnmgwpYv/UUfe
 BJFFGEBg9yXqAa+nXhljyOK3JdksrRncq6xDllyB2rl3rh4GNfTUBwTEQ5bg0GSkqXpjqDqtEba
 vq0X6EQzjXJlZdg6eibWMrX+TJclSRMK5rzPbEcC5gpzNuHWduV+tkgut/d38aqfNDg==
X-Gm-Gg: AR+sD13sl1v5GFnzSXUhpO5fL0s7wVdnELSBfqJEwM3JFcvGwV8A07V0jgbpFXU/JIn
 eASv5fJXIWtXadfVg6IFrAMtLXj8y0EJLlIGALOub195w6phm0aJesMtDu/odT9g2VHpo7qUMKw
 mdC3VB29wa/e0xoiRhKB6peZoCWaGXJRDc6TIOEuIAGqyhhiyHxCHT+8vRzFitZbChDgPf7aNsI
 zoSMSQJQ/gN/JtAe77Z2ptI6LTbGbEmA3DHd6cVg5MqYdO8eD5nNm2AiK2XjMENtrki4spCx5l2
 jEB8ecK9N8kRT8c97/S0dlazPPFpA14GJ0a105guBY6Bh2uEiS7TcCzan/mry7G6JjBzN5iPGU1
 QH8ecYjRnFxG+rSoyDtB+bGc8dV4/iDhz4HaddQ==
X-Received: by 2002:a05:6214:1c88:b0:90c:c4fe:8d9c with SMTP id
 6a1803df08f44-90cc7979099mr16769826d6.27.1787693051275; 
 Tue, 25 Aug 2026 14:24:11 -0700 (PDT)
X-Received: by 2002:a05:6214:1c88:b0:90c:c4fe:8d9c with SMTP id
 6a1803df08f44-90cc7979099mr16769406d6.27.1787693050860; 
 Tue, 25 Aug 2026 14:24:10 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cc65299f0sm8646386d6.41.2026.08.25.14.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 14:24:10 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 11/13] hw/riscv/device-common, virt.c: add flash helpers
Date: Tue, 25 Aug 2026 18:23:23 -0300
Message-ID: <20260825212326.1907-12-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
References: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NU0ZPdFVAfuv8O6UXua9bxOFGUzuI4sn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfX5jKwIIe55VeV
 nfCwm6rapfTyyKIWzV15p9Mlk2HkC2oFTaezOB5H7XaQOucOkTWqrVFMyvm7OF5OaMCV6vviiDc
 ECgraBhfzV+mtwCmtjLWdiZF17DVhPU=
X-Authority-Analysis: v=2.4 cv=TZGmcxQh c=1 sm=1 tr=0 ts=6a8e07fc cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Ak_EWCeJEXv7LabEeCgA:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: NU0ZPdFVAfuv8O6UXua9bxOFGUzuI4sn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfX4kyrvaOZgcy9
 zGWzjxSEyLFUZ643i2LxCHN3cvM0GW0v0YPpSOFBumWpFIi0vVeGAIH7c8K6bWV0Pl++SPd0vzb
 qtp9AnUpWCsEQPvJqQ+jrcRTUzUXfljhE9+hOyyj+ra6zW755n7VHuqBQJqVG9JeOgS9NEeOE04
 Q/wPniWFnWdn9RjG5PS+TEtebrVQKT8YTPwsN+Uz5/obrvO8yFYR/WEfjmRnhwD6Sqbs0NjbMpf
 g34L3nHnyttcXLOFT8GtyKWGDQ2/55RJQyqsBje/C7r72onxTnDFBcl5li56zAqKGqQrnhHFcuj
 iaGKPtc6NARSJ3C1uI5AOEAh70qp8pJ4aWQjmfRkTXsS+Z9WqbxqctYlULwqseZpZc+A6yM37vv
 15xMwOg5jEWvm6yXUqHPJYWFbh/YZbm6kl/OCCRWFGP84Iuv2Um58dzcMtgWwUYDXgPoEcgbuuC
 vllkBlzrma/fVC09eyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250182
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


