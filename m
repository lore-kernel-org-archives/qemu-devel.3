Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682EACCF2C4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhb3-0008LN-J8; Fri, 16 Oct 2026 09:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHfCv-0006Nr-QP; Fri, 16 Oct 2026 06:30:37 -0400
Received: from out203-205-221-240.mail.qq.com ([203.205.221.240])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHfCs-0004W2-Vq; Fri, 16 Oct 2026 06:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792146629; bh=LYX0tnxe42765fXSGaBPeAk0ygBd9HvLmRFnTW8wljo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fYPmS6uoTGXp95Ekca5plu/FuFPJ7mnZPisn5x5vwDdpQMC5u17SrRKwlWtlRhZ55
 DNiXAaiC0gVb9J9J5dx8o3sDDA/eG68vB++zMskNnJGBUeT2mSLPSsGfvVj80xkA/I
 NUf5HUB476AWljKxS0IVnKhRfqEVLq4piErtKQqA=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id 79B1B405; Fri, 16 Oct 2026 18:30:27 +0800
X-QQ-mid: xmsmtpt1792146627tu46m62ec
Message-ID: <tencent_E3765EAA6D66F47871052AAD65C21FD1F905@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoed6F+kN84uN2AvrE47OEWTVJVpUdwO6rlXWf4CIpN1vOTcYyFzH
 zh4ifml9vV1uVzfgIGcCU2WAd0kT3tVrkzNZHa45sCXQOb8hNK7H/AsZoEM9X7eMvtAjpJBo8L8h
 Yz6jQARumlRHhFdyra/yaMbkuNBgV9ZLB1WCr8aTG9gnTrlC81TsfncdjqF3bEz64ap5gKzt9FiY
 izJ3/wK4rtyrpD9oYySAZ9BO388gchVESgVrP9DwWgzv3RklcYSHIQixG2of27sbQ+Yw+z1lePeV
 QyENGMxN2OFtpIvIBH2ADUl//x7/8RW4TLK8w5HVQJl4JPU9HSV8Mv351m0aco/FcnDTTBKfhKUH
 loET/xn03P41g93WuFB+Cpipy8ynaP1F5PiYx4FroDQ4YDRX0SYC/LCAdDDhF7AVFiI++qWZnU2c
 5Vktz/qiX3OuTS4B87AhNRoAVyhau2Q9vaRUaor6KTJKPDVAkwtZvncSwZdIuip7jp+tWBHne2jB
 gLLqJJRM9HRWD/uCIJutcZMA57VbPw/FS59Dr1jkD15+uAHDSfCGCgN0GauMrjGIIUygm9vhKxdP
 oKbqWVfjP2m7luBX3quwS2Uq25SzEkETLEWO5zYgAnnwC7mjSH/75alos4X0c79Smaykn3IwgA1s
 SrHahk94bIbVd9Ph3SUDk+6kghu0leDzjQgsji2vF8+HJBpGEVd7znKP8CpJPL0cTVTrNW86QXFu
 Et952WiGGmUEaQthfh3wDFPmcIAwDcOYp2kEzLbSEJ4tfL83zjHJM6y+igLBg+efsWjEUvfOy2iW
 gu3LasgrbogOGw8lLmj8AUJv8rXYB5IlQ64fI4NtATI9RREZK6sZ0mEsOUEq6sZueWT6k+RiKt6s
 bNKKU3CMNvP9LI9Hi34gYcL7671xHd5OopwCy+Ksu2Ees8n3GnNZjZ5yCR3y2ttnx3SiMZtuJPCa
 SwKT3UnjIJZuoK/CNUhxK9VAZiH8J5/JwtnvJCtqPVedcPprW64e3XiCWDdwz0S6Ta8sfFp7VaRz
 1E0GOyo9taGifKvRpIs6nwErHmYNsd0Us6G55Nz5N8W15rJ0tBHGDOiMdolIbStTOagIBh4jRPrZ
 5NoN3v9cp53TG+r1V1IdrqkpZEeQ==
X-QQ-XMRINFO: NIY0FsY06mWik60O6xSizP/2tkZG+oPoPQ==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 34/37] hw/arm/virt: Wire MSC error and overflow interrupts to
 the GIC
Date: Fri, 16 Oct 2026 18:10:54 +0800
X-OQ-MSGID: <20261016101058.1900808-20-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101058.1900808-1-2118537295@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.240; envelope-from=2118537295@qq.com;
 helo=out203-205-221-240.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:46 -0400
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

Each board-created MSC gets two free SPIs above the platform bus range
(MPAM_SPI_BASE = 112 + PLATFORM_BUS_NUM_IRQS), connected to the GIC
(sysbus irq outputs [0] error, [1] overflow, both level).  The
assigned GSIVs (SPI + 32) are recorded as err-gsiv/oflow-gsiv qdev
properties, which the ACPI MPAM table already reports.

Guest-verified on virt,mpam=on gic-v3 with linux 7.3.0-rc6:
/proc/interrupts lists mpam:msc:error on hwirq 208/210/212 Level, no
error storms, full resctrl regression suite passes.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/virt.c | 59 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1bcdd20..4ef7aed 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2144,8 +2144,35 @@ static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
 #define MPAM_VIRT_NUM_PARTID     256
 #define MPAM_VIRT_NUM_INTPARTID  32
 
+/*
+ * MPAM MSC wired interrupts start above the platform bus SPI range
+ * (112 .. 112 + PLATFORM_BUS_NUM_IRQS - 1).  Two lines per MSC.
+ */
+#define MPAM_SPI_BASE   (112 + PLATFORM_BUS_NUM_IRQS)
+
+/*
+ * Hand a not-yet-realized MSC its two wired interrupt SPIs (error first,
+ * overflow second — the sysbus_init_irq() order in hw/arm/mpam.c), and
+ * record the GSIVs (INTID = SPI + 32) the ACPI MPAM table must report.
+ */
+static void mpam_msc_assign_irqs(DeviceState *dev,
+                                 int *err_spi, int *oflow_spi, int *next_spi)
+{
+    if (*next_spi + 1 >= NUM_IRQS) {
+        error_report("virt: out of SPIs for MPAM MSC interrupts");
+        exit(1);
+    }
+    *err_spi = (*next_spi)++;
+    *oflow_spi = (*next_spi)++;
+
+    object_property_set_int(OBJECT(dev), "err-gsiv", *err_spi + 32,
+                            &error_fatal);
+    object_property_set_int(OBJECT(dev), "oflow-gsiv", *oflow_spi + 32,
+                            &error_fatal);
+}
+
 static void create_mpam_msc_cache(VirtMachineState *vms, int level,
-                                  hwaddr *base)
+                                  hwaddr *base, int *next_spi)
 {
     MachineState *ms = MACHINE(vms);
     const CPUArchIdList *cpu_list = ms->possible_cpus;
@@ -2180,13 +2207,14 @@ static void create_mpam_msc_cache(VirtMachineState *vms, int level,
     }
 
     for (i = 0; i < cpu_list->len; i += step) {
+        int err_spi, oflow_spi;
+
         dev = qdev_new(TYPE_MPAM_MSC_CACHE);
         object_property_set_uint(OBJECT(dev), "num-ris", 1, &error_fatal);
         object_property_set_uint(OBJECT(dev), "num-partid",
                                  MPAM_VIRT_NUM_PARTID, &error_fatal);
         object_property_set_uint(OBJECT(dev), "num-int-partid",
-                                 MPAM_VIRT_NUM_INTPARTID,
-                                 &error_fatal);
+                                 MPAM_VIRT_NUM_INTPARTID, &error_fatal);
         object_property_set_uint(OBJECT(dev), "cache-level", level,
                                  &error_fatal);
         object_property_set_uint(OBJECT(dev), "cache-type", UNIFIED_CACHE,
@@ -2196,8 +2224,13 @@ static void create_mpam_msc_cache(VirtMachineState *vms, int level,
         object_property_set_uint(OBJECT(dev), "csu-capacity-bytes",
                                  level == 2 ? 512 * KiB : 32 * MiB,
                                  &error_fatal);
+        mpam_msc_assign_irqs(dev, &err_spi, &oflow_spi, next_spi);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, *base);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                           qdev_get_gpio_in(vms->gic, err_spi));
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1,
+                           qdev_get_gpio_in(vms->gic, oflow_spi));
         *base += MPAM_SIZE;
     }
 }
@@ -2207,6 +2240,7 @@ static void create_mpam_msc(VirtMachineState *vms, Error **errp)
     MachineState *ms = MACHINE(vms);
     DeviceState *dev;
     int i, count = 0;
+    int next_spi = MPAM_SPI_BASE;
     hwaddr base = vms->memmap[VIRT_MPAM_MSC].base;
 
     if (ms->numa_state->num_nodes == 0) {
@@ -2218,6 +2252,8 @@ static void create_mpam_msc(VirtMachineState *vms, Error **errp)
         for (i = 0; i < ms->numa_state->num_nodes; i++) {
             /* at most 16 mem MSCs (4-bit selector space, SPI budget) */
             if (ms->numa_state->nodes[i].node_mem > 0 && count < 16) {
+                int err_spi, oflow_spi;
+
                 dev = qdev_new(TYPE_MPAM_MSC_MEM);
 
                 object_property_set_uint(OBJECT(dev), "node", i,
@@ -2230,14 +2266,21 @@ static void create_mpam_msc(VirtMachineState *vms, Error **errp)
                 object_property_set_uint(OBJECT(dev), "num-int-partid",
                                          MPAM_VIRT_NUM_INTPARTID,
                                          &error_fatal);
+                mpam_msc_assign_irqs(dev, &err_spi, &oflow_spi,
+                                     &next_spi);
                 sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
                 sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
+                sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                                   qdev_get_gpio_in(vms->gic, err_spi));
+                sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1,
+                                   qdev_get_gpio_in(vms->gic, oflow_spi));
                 base += MPAM_SIZE;
                 count++;
             }
         }
     } else {
         int count_with_mem = 0;
+        int err_spi, oflow_spi;
 
         for (i = 0; i < ms->numa_state->num_nodes; i++) {
             if (ms->numa_state->nodes[i].node_mem) {
@@ -2252,14 +2295,18 @@ static void create_mpam_msc(VirtMachineState *vms, Error **errp)
         object_property_set_uint(OBJECT(dev), "num-int-partid",
                                  2, /* extreme narrowing */
                                  &error_fatal);
-
+        mpam_msc_assign_irqs(dev, &err_spi, &oflow_spi, &next_spi);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                           qdev_get_gpio_in(vms->gic, err_spi));
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1,
+                           qdev_get_gpio_in(vms->gic, oflow_spi));
         base += MPAM_SIZE;
     }
 
-    create_mpam_msc_cache(vms, 3, &base);
-    create_mpam_msc_cache(vms, 2, &base);
+    create_mpam_msc_cache(vms, 3, &base, &next_spi);
+    create_mpam_msc_cache(vms, 2, &base, &next_spi);
 }
 
 static void create_pcie(VirtMachineState *vms)
-- 
2.43.0


