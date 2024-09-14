Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682B8C02195
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2024 12:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spRbR-0004zY-FP; Sat, 14 Sep 2024 08:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1spRbO-0004t8-UT
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 08:10:10 -0400
Received: from fhigh4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1spRbM-00016d-0Q
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 08:10:10 -0400
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 2C91D11400D7;
 Sat, 14 Sep 2024 08:10:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Sat, 14 Sep 2024 08:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1726315806;
 x=1726402206; bh=+pQRI2UNaYKrEaBXF0kMpmeABnw5+w+xaFzYlqIlOQo=; b=
 KUvzlz54R6pPmO1MrIWChgPFP7xe7jMXkuvCF1fGHecFhFUsExN+9uBc69vaO9QG
 wZhK7WIPvOsgzTfriiIwstL2c3vOtfoHvaDI3M6GZi7fpqMbqtXT/trp8SIIvS9E
 cABuQ2FuIq6FOh60iDsF52qYJlESyhbTmgzUhBtrejstWARwJuLeIF5US05X2Vdx
 VsZVxGGwPRXg6MD+yVicdTJa6zHZFx1TiMQTMBplrc2dzUGOLMFaeK3MrwUT1nER
 0r7gV6oGnjE27Cfnf4UzDAeB2KKswZtnmrEufbfgDu7hDE7xh6dR6BUuPf9NeU1A
 ZRDn/dW5V/VXc9vQNoyQcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726315806; x=
 1726402206; bh=+pQRI2UNaYKrEaBXF0kMpmeABnw5+w+xaFzYlqIlOQo=; b=Q
 E7V/gIO+P4VhXFKxHGFfBI42lqOZ2XRD7H70cFyyYlux+8olhv87GtKc/gNnduqn
 wGD/jUwHi9Mlo6a2NAa+mMNeZC/4iv/QRAIMK0pYeFwuDcs4nR6uJRpsEr9IJ0mY
 VlDv3J6VuuxmFATrXy13VXE/EyUGv9CiduBAR4U6NoRe9qAnwbb4J6d5q7Y1vZUe
 la2yqP4A+jUEwjELv1zEm95UBj5Izm4JY+tejerGUW5rSyQAPpOyDoo7Y1DEMVBz
 j0MHQxi+l7LL/9u8Zo1xwRNJI18tDvUcFdSaX4/P9v7s4iy8EjCPlS16cUCRXJcp
 XLZPIbJVJVMQmxmEjiqkQ==
X-ME-Sender: <xms:HX3lZsQesoSqP69LtO-vgQRQNiD27jeX31qjwNt4M1KOgKKRjnYRhg>
 <xme:HX3lZpxNISQBDn7p2HKh7jD-i_vbuH__oEEc5xxflCto6mNuufmhDZQaLPt-1MLSU
 kDM7uLOdSpAccriRs8>
X-ME-Received: <xmr:HX3lZp2LGBkKT6H69Uxk5ijOiPdyiQhEnj6Ex46_NVx_WTJNwZ7ec0y9cfgLOhhsOtk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddggeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
 necuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhi
 hgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffek
 gedugefhtdduudeghfeuveegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdr
 tghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehjihgrgihu
 nhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhrtghpthhtohepghgrohhsohhngheslh
 hoohhnghhsohhnrdgtnh
X-ME-Proxy: <xmx:HX3lZgDsgdwWETHJ54AIs3sCa0UEacnWK8pzMQCSsD3Z3ewXqAiltQ>
 <xmx:HX3lZlhAnWkBPWznzi3JtQlRwYaoHGm8-YN38acvBLyIIt57zTE82w>
 <xmx:HX3lZsoRymHE_ryEGnM49nKy3bZioM1_SScnTF_x8N7_fA4jopUwig>
 <xmx:HX3lZoig2jMRLYzxYc0DpkYh5EMI_H2-2v7EWcBPAGBQgInYXwm8fA>
 <xmx:Hn3lZqsm8wnnGGh3B9pJBhvFxi4uE9_NDlLC2Z3RgiOvRAjJw9kd5h32>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Sep 2024 08:10:05 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sat, 14 Sep 2024 13:10:02 +0100
Subject: [PATCH 1/2] hw/loongarch/boot: Refactor EFI booting protocol
 generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240914-loongarch-booting-v1-1-1517cae11c10@flygoat.com>
References: <20240914-loongarch-booting-v1-0-1517cae11c10@flygoat.com>
In-Reply-To: <20240914-loongarch-booting-v1-0-1517cae11c10@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=19158;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=eGWxce0Sl0H2AawVqfNfmNjGH5/bjBKGLaGZIFY1yJ0=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSntTLpslf9Z5lN3Lpvxu3Z/vbbpPRM2gR4IrnXf2T9Y
 F/8e+aJjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZhI1nlGhpvvJmp+50pVtrG7
 P+npgokGOy+kb9jizJ3kf21F35a2/1wM/zO+qm7Z3KB/ZJZ/I0+3yInEzz0n/nH9V/9ZLLcxL3r
 vDVYA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.155;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Refector EFI style booting data structure generation to
support 32bit EFI variant on LoongArch32 CPU.

All data structs are filled with padding members if necessary
and marked as QEMU_PACKED to avoid host ABI alignment impact.

Host endian is being cared as well.

It also fixed various problems in old implementation such
as null pointer on empty string, memory desc map_size not set,
incorrect memory map definition and so on.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/loongarch/boot.c         | 220 ++++++++++++++++++++++++++++++--------------
 include/hw/loongarch/boot.h | 106 +++++++++++++++++----
 2 files changed, 237 insertions(+), 89 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index cb668703bddd..4d01c01594e2 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2023 Loongson Technology Corporation Limited
  */
 
+#include <zlib.h>
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "target/loongarch/cpu.h"
@@ -31,7 +32,7 @@ static const unsigned int slave_boot_code[] = {
 
                   /* Clear mailbox.                            */
     0x1400002d,   /* lu12i.w    $t1, 1(0x1)                    */
-    0x038081ad,   /* ori        $t1, $t1, CORE_BUF_20  */
+    0x038081ad,   /* ori        $t1, $t1, CORE_BUF_20          */
     0x06481da0,   /* iocsrwr.d  $zero, $t1                     */
 
                   /* Enable IPI interrupt.                     */
@@ -74,88 +75,163 @@ static inline void *guidcpy(void *dst, const void *src)
     return memcpy(dst, src, sizeof(efi_guid_t));
 }
 
-static void init_efi_boot_memmap(struct efi_system_table *systab,
-                                 void *p, void *start)
+static void efi_hdr_crc32(efi_table_hdr_t *hdr)
 {
-    unsigned i;
-    struct efi_boot_memmap *boot_memmap = p;
-    efi_guid_t tbl_guid = LINUX_EFI_BOOT_MEMMAP_GUID;
-
-    /* efi_configuration_table 1 */
-    guidcpy(&systab->tables[0].guid, &tbl_guid);
-    systab->tables[0].table = (struct efi_configuration_table *)(p - start);
-    systab->nr_tables = 1;
-
-    boot_memmap->desc_size = sizeof(efi_memory_desc_t);
-    boot_memmap->desc_ver = 1;
-    boot_memmap->map_size = 0;
+    uint32_t val;
 
-    efi_memory_desc_t *map = p + sizeof(struct efi_boot_memmap);
-    for (i = 0; i < memmap_entries; i++) {
-        map = (void *)boot_memmap + sizeof(*map);
-        map[i].type = memmap_table[i].type;
-        map[i].phys_addr = ROUND_UP(memmap_table[i].address, 64 * KiB);
-        map[i].num_pages = ROUND_DOWN(memmap_table[i].address +
-                        memmap_table[i].length - map[i].phys_addr, 64 * KiB);
-        p += sizeof(efi_memory_desc_t);
-    }
+    hdr->crc32 = 0;
+    val = crc32(0, (const unsigned char *)hdr, hdr->headersize);
+    hdr->crc32 = cpu_to_le32(val);
 }
 
-static void init_efi_initrd_table(struct efi_system_table *systab,
-                                  void *p, void *start)
+static void init_efi_vendor_string(void **p)
 {
-    efi_guid_t tbl_guid = LINUX_EFI_INITRD_MEDIA_GUID;
-    struct efi_initrd *initrd_table  = p;
+    uint16_t *vendor_str = *p;
 
-    /* efi_configuration_table 2 */
-    guidcpy(&systab->tables[1].guid, &tbl_guid);
-    systab->tables[1].table = (struct efi_configuration_table *)(p - start);
-    systab->nr_tables = 2;
+    /* QEMU in UTF16-LE */
+    stw_le_p(vendor_str++, 0x0051); /* Q */
+    stw_le_p(vendor_str++, 0x0045); /* E */
+    stw_le_p(vendor_str++, 0x004D); /* M */
+    stw_le_p(vendor_str++, 0x0055); /* U */
+    stw_le_p(vendor_str++, 0x0000); /* \0 */
 
-    initrd_table->base = initrd_offset;
-    initrd_table->size = initrd_size;
+    *p = vendor_str;
+    *p = QEMU_ALIGN_PTR_UP(*p, sizeof(target_long));
 }
 
-static void init_efi_fdt_table(struct efi_system_table *systab)
+static void memmap_write_descs(efi_memory_desc_t *map)
 {
-    efi_guid_t tbl_guid = DEVICE_TREE_GUID;
-
-    /* efi_configuration_table 3 */
-    guidcpy(&systab->tables[2].guid, &tbl_guid);
-    systab->tables[2].table = (void *)FDT_BASE;
-    systab->nr_tables = 3;
-}
-
-static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
-{
-    void *bp_tables_start;
-    struct efi_system_table *systab = p;
+    int i;
 
-    info->a2 = p - start;
+    for (i = 0; i < memmap_entries; i++) {
+        uint32_t efi_type;
+        hwaddr start = memmap_table[i].address;
+        hwaddr end = memmap_table[i].address + memmap_table[i].length;
+
+        switch (memmap_table[i].type) {
+        case MEMMAP_TYPE_MEMORY:
+            efi_type = EFI_CONVENTIONAL_MEMORY;
+            break;
+        case MEMMAP_TYPE_RESERVED:
+            efi_type = EFI_RESERVED_TYPE;
+            break;
+        case MEMMAP_TYPE_ACPI:
+            efi_type = EFI_ACPI_RECLAIM_MEMORY;
+            break;
+        case MEMMAP_TYPE_NVS:
+            efi_type = EFI_ACPI_MEMORY_NVS;
+            break;
+        default:
+            efi_type = EFI_RESERVED_TYPE;
+            break;
+        }
 
-    systab->hdr.signature = EFI_SYSTEM_TABLE_SIGNATURE;
-    systab->hdr.revision = EFI_SPECIFICATION_VERSION;
-    systab->hdr.revision = sizeof(struct efi_system_table),
-    systab->fw_revision = FW_VERSION << 16 | FW_PATCHLEVEL << 8;
-    systab->runtime = 0;
-    systab->boottime = 0;
-    systab->nr_tables = 0;
+        if (memmap_table[i].reserved) {
+            start = QEMU_ALIGN_DOWN(start, EFI_PAGE_SIZE);
+            end = QEMU_ALIGN_UP(end, EFI_PAGE_SIZE);
+        } else {
+            start = QEMU_ALIGN_UP(start, EFI_PAGE_SIZE);
+            end = QEMU_ALIGN_DOWN(end, EFI_PAGE_SIZE);
+        }
 
-    p += ROUND_UP(sizeof(struct efi_system_table), 64 * KiB);
+        map[i].type = cpu_to_le32(efi_type);
+        map[i].phys_addr = cpu_to_le64(start);
+        map[i].virt_addr = cpu_to_le64(start);
+        map[i].num_pages = cpu_to_le64((end - start) >> EFI_PAGE_SHIFT);
+    }
+}
 
-    systab->tables = p;
-    bp_tables_start = p;
+#define EFI_BOOT_MEMMAP_TABLE_GEN(type)                                     \
+static void init_efi_boot_memmap_##type(void *guidp, void **p)              \
+{                                                                           \
+    struct efi_boot_memmap_##type *boot_memmap = *p;                        \
+    efi_guid_t tbl_guid = LINUX_EFI_BOOT_MEMMAP_GUID;                       \
+                                                                            \
+    /* efi_configuration_table 1 */                                         \
+    guidcpy(guidp, &tbl_guid);                                              \
+                                                                            \
+    boot_memmap->desc_size = cpu_to_le##type(sizeof(efi_memory_desc_t));    \
+    boot_memmap->desc_ver = cpu_to_le32(1);                                 \
+    boot_memmap->map_size = cpu_to_le##type(boot_memmap->desc_size *        \
+                                            memmap_entries);                \
+    memmap_write_descs(boot_memmap->map);                                   \
+    *p += sizeof(struct efi_boot_memmap_##type);                            \
+}
 
-    init_efi_boot_memmap(systab, p, start);
-    p += ROUND_UP(sizeof(struct efi_boot_memmap) +
-                  sizeof(efi_memory_desc_t) * memmap_entries, 64 * KiB);
-    init_efi_initrd_table(systab, p, start);
-    p += ROUND_UP(sizeof(struct efi_initrd), 64 * KiB);
-    init_efi_fdt_table(systab);
+#define EFI_INITRD_TABLE_GEN(type)                                          \
+static void init_efi_initrd_table_##type(void *guidp, void **p)             \
+{                                                                           \
+    efi_guid_t tbl_guid = LINUX_EFI_INITRD_MEDIA_GUID;                      \
+    struct efi_initrd_##type *initrd_table = *p;                            \
+                                                                            \
+    /* efi_configuration_table  */                                          \
+    guidcpy(guidp, &tbl_guid);                                              \
+                                                                            \
+    initrd_table->base = cpu_to_le##type(initrd_offset);                    \
+    initrd_table->size = cpu_to_le##type(initrd_size);                      \
+    *p += sizeof(struct efi_initrd_##type);                                 \
+}
 
-    systab->tables = (struct efi_configuration_table *)(bp_tables_start - start);
+#define BOOTP_ALIGN_PTR_UP(p, s, n)                                         \
+        ((typeof(p))((uintptr_t)(s) +                                       \
+            QEMU_ALIGN_UP((uintptr_t)(p) - (uintptr_t)(s), n)))
+
+#define EFI_INIT_SYSTAB_GEN(type)                                           \
+    EFI_BOOT_MEMMAP_TABLE_GEN(type)                                         \
+    EFI_INITRD_TABLE_GEN(type)                                              \
+static void init_systab_##type(struct loongarch_boot_info *info,            \
+                               void *p, void *start)                        \
+{                                                                           \
+    uint32_t nr_tables = 0;                                                 \
+    const efi_guid_t fdt_guid = DEVICE_TREE_GUID;                           \
+    struct efi_system_table_##type *systab;                                 \
+    struct efi_configuration_table_##type *cfg_tabs;                        \
+                                                                            \
+    p = BOOTP_ALIGN_PTR_UP(p, start, EFI_TABLE_ALIGN);                      \
+    systab = p;                                                             \
+    info->a2 = p - start;                                                   \
+                                                                            \
+    systab->hdr.signature = cpu_to_le64(EFI_SYSTEM_TABLE_SIGNATURE);        \
+    systab->hdr.revision = cpu_to_le32(EFI_SPECIFICATION_VERSION);          \
+    systab->hdr.headersize =                                                \
+            cpu_to_le32(sizeof(struct efi_system_table_##type));            \
+    systab->fw_revision =                                                   \
+            cpu_to_le32(FW_VERSION << 16 | FW_PATCHLEVEL << 8);             \
+    systab->runtime = 0;                                                    \
+    systab->boottime = 0;                                                   \
+    systab->nr_tables = 0;                                                  \
+                                                                            \
+    p += sizeof(struct efi_system_table_##type);                            \
+    systab->fw_vendor = cpu_to_le##type(p - start);                         \
+    init_efi_vendor_string(&p);                                             \
+                                                                            \
+    p = BOOTP_ALIGN_PTR_UP(p, start, EFI_TABLE_ALIGN);                      \
+    systab->tables = cpu_to_le##type(p - start);                            \
+    cfg_tabs = p;                                                           \
+    p += sizeof(struct efi_configuration_table_##type) * 3;                 \
+                                                                            \
+    p = BOOTP_ALIGN_PTR_UP(p, start, EFI_TABLE_ALIGN);                      \
+    cfg_tabs[nr_tables].table = cpu_to_le##type(p - start);                 \
+    init_efi_boot_memmap_##type(&cfg_tabs[nr_tables].guid, &p);             \
+    nr_tables++;                                                            \
+                                                                            \
+    if (initrd_size > 0) {                                                  \
+        cfg_tabs[nr_tables].table = cpu_to_le##type(p - start);             \
+        init_efi_initrd_table_##type(&cfg_tabs[nr_tables].guid, &p);        \
+        nr_tables++;                                                        \
+    }                                                                       \
+                                                                            \
+    guidcpy(&cfg_tabs[nr_tables].guid, &fdt_guid);                          \
+    cfg_tabs[nr_tables].table = cpu_to_le##type(FDT_BASE);                  \
+    nr_tables++;                                                            \
+                                                                            \
+    systab->nr_tables = cpu_to_le32(nr_tables);                             \
+    efi_hdr_crc32(&systab->hdr);                                            \
 }
 
+EFI_INIT_SYSTAB_GEN(32)
+EFI_INIT_SYSTAB_GEN(64)
+
 static void init_cmdline(struct loongarch_boot_info *info, void *p, void *start)
 {
     hwaddr cmdline_addr = p - start;
@@ -223,7 +299,7 @@ static void reset_load_elf(void *opaque)
 
     cpu_reset(CPU(cpu));
     if (env->load_elf) {
-	if (cpu == LOONGARCH_CPU(first_cpu)) {
+        if (cpu == LOONGARCH_CPU(first_cpu)) {
             env->gpr[4] = env->boot_info->a0;
             env->gpr[5] = env->boot_info->a1;
             env->gpr[6] = env->boot_info->a2;
@@ -265,21 +341,25 @@ static void loongarch_firmware_boot(LoongArchVirtMachineState *lvms,
     fw_cfg_add_kernel_info(info, lvms->fw_cfg);
 }
 
-static void init_boot_rom(struct loongarch_boot_info *info, void *p)
+static void init_boot_rom(struct loongarch_boot_info *info, void *p,
+                          bool is_64bit)
 {
     void *start = p;
 
     init_cmdline(info, p, start);
     p += COMMAND_LINE_SIZE;
 
-    init_systab(info, p, start);
+    if (is_64bit)
+        init_systab_64(info, p, start);
+    else
+        init_systab_32(info, p, start);
 }
 
 static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
 {
     void *p, *bp;
     int64_t kernel_addr = 0;
-    LoongArchCPU *lacpu;
+    LoongArchCPU *lacpu = LOONGARCH_CPU(first_cpu);
     CPUState *cs;
 
     if (info->kernel_filename) {
@@ -294,7 +374,7 @@ static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
     /* Load cmdline and system tables at [0 - 1 MiB] */
     p = g_malloc0(1 * MiB);
     bp = p;
-    init_boot_rom(info, p);
+    init_boot_rom(info, p, is_la64(&lacpu->env));
     rom_add_blob_fixed_as("boot_info", bp, 1 * MiB, 0, &address_space_memory);
 
     /* Load slave boot code at pflash0 . */
diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
index b3b870df1f09..96ec15016a31 100644
--- a/include/hw/loongarch/boot.h
+++ b/include/hw/loongarch/boot.h
@@ -38,11 +38,35 @@ typedef struct {
         EFI_GUID(0xb1b621d5, 0xf19c, 0x41a5,  0x83, 0x0b, \
                  0xd9, 0x15, 0x2c, 0x69, 0xaa, 0xe0)
 
+/* Memory types: */
+#define EFI_RESERVED_TYPE           0
+#define EFI_LOADER_CODE             1
+#define EFI_LOADER_DATA             2
+#define EFI_BOOT_SERVICES_CODE      3
+#define EFI_BOOT_SERVICES_DATA      4
+#define EFI_RUNTIME_SERVICES_CODE   5
+#define EFI_RUNTIME_SERVICES_DATA   6
+#define EFI_CONVENTIONAL_MEMORY     7
+#define EFI_UNUSABLE_MEMORY         8
+#define EFI_ACPI_RECLAIM_MEMORY     9
+#define EFI_ACPI_MEMORY_NVS         10
+#define EFI_MEMORY_MAPPED_IO        11
+#define EFI_MEMORY_MAPPED_IO_PORT_SPACE 12
+#define EFI_PAL_CODE                13
+#define EFI_PERSISTENT_MEMORY       14
+#define EFI_UNACCEPTED_MEMORY       15
+#define EFI_MAX_MEMORY_TYPE         16
+
+#define EFI_PAGE_SHIFT      12
+#define EFI_PAGE_SIZE       (1UL << EFI_PAGE_SHIFT)
+
+#define EFI_TABLE_ALIGN     (64 * KiB)
+
 struct efi_config_table {
     efi_guid_t guid;
     uint64_t *ptr;
     const char name[16];
-};
+} QEMU_PACKED;
 
 typedef struct {
     uint64_t signature;
@@ -50,51 +74,90 @@ typedef struct {
     uint32_t headersize;
     uint32_t crc32;
     uint32_t reserved;
-} efi_table_hdr_t;
+} QEMU_PACKED efi_table_hdr_t;
 
-struct efi_configuration_table {
+struct efi_configuration_table_32 {
     efi_guid_t guid;
-    void *table;
-};
+    uint32_t table;
+} QEMU_PACKED;
 
-struct efi_system_table {
+struct efi_configuration_table_64 {
+    efi_guid_t guid;
+    uint64_t table;
+} QEMU_PACKED;
+
+struct efi_system_table_32 {
+    efi_table_hdr_t hdr;
+    uint32_t fw_vendor;        /* physical addr of CHAR16 vendor string */
+    uint32_t fw_revision;
+    uint32_t con_in_handle;
+    uint32_t con_in;
+    uint32_t con_out_handle;
+    uint32_t con_out;
+    uint32_t stderr_handle;
+    uint32_t stderr_placeholder;
+    uint32_t runtime;
+    uint32_t boottime;
+    uint32_t nr_tables;
+    uint32_t tables;
+} QEMU_PACKED;
+
+struct efi_system_table_64 {
     efi_table_hdr_t hdr;
     uint64_t fw_vendor;        /* physical addr of CHAR16 vendor string */
     uint32_t fw_revision;
+    uint32_t __pad1;
     uint64_t con_in_handle;
-    uint64_t *con_in;
+    uint64_t con_in;
     uint64_t con_out_handle;
-    uint64_t *con_out;
+    uint64_t con_out;
     uint64_t stderr_handle;
     uint64_t stderr_placeholder;
-    uint64_t *runtime;
-    uint64_t *boottime;
-    uint64_t nr_tables;
-    struct efi_configuration_table *tables;
-};
+    uint64_t runtime;
+    uint64_t boottime;
+    uint32_t nr_tables;
+    uint32_t __pad2;
+    uint64_t tables;
+} QEMU_PACKED;
 
 typedef struct {
     uint32_t type;
-    uint32_t pad;
+    uint32_t __pad;
     uint64_t phys_addr;
     uint64_t virt_addr;
     uint64_t num_pages;
     uint64_t attribute;
-} efi_memory_desc_t;
+} QEMU_PACKED efi_memory_desc_t;
+
+struct efi_boot_memmap_32 {
+    uint32_t map_size;
+    uint32_t desc_size;
+    uint32_t desc_ver;
+    uint32_t map_key;
+    uint32_t buff_size;
+    uint32_t __pad;
+    efi_memory_desc_t map[32];
+} QEMU_PACKED;
 
-struct efi_boot_memmap {
+struct efi_boot_memmap_64 {
     uint64_t map_size;
     uint64_t desc_size;
     uint32_t desc_ver;
+    uint32_t __pad;
     uint64_t map_key;
     uint64_t buff_size;
     efi_memory_desc_t map[32];
-};
+} QEMU_PACKED;
+
+struct efi_initrd_32 {
+    uint32_t base;
+    uint32_t size;
+} QEMU_PACKED;
 
-struct efi_initrd {
+struct efi_initrd_64 {
     uint64_t base;
     uint64_t size;
-};
+} QEMU_PACKED;
 
 struct loongarch_boot_info {
     uint64_t ram_size;
@@ -110,6 +173,11 @@ extern unsigned memmap_entries;
 struct memmap_entry {
     uint64_t address;
     uint64_t length;
+    /* E820 style type */
+#define MEMMAP_TYPE_MEMORY      1
+#define MEMMAP_TYPE_RESERVED    2
+#define MEMMAP_TYPE_ACPI        3
+#define MEMMAP_TYPE_NVS         4
     uint32_t type;
     uint32_t reserved;
 };

-- 
2.46.0


