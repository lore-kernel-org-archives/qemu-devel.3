Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D0EE7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 12:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJAtj-0001kD-1P; Thu, 05 Dec 2024 07:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1263914829@qq.com>) id 1tJAtg-0001k0-3f
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 07:23:56 -0500
Received: from xmbghk7.mail.qq.com ([43.163.128.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1263914829@qq.com>) id 1tJAsx-0001mK-7C
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 07:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1733401372; bh=sM40K65DgyZ1arHtB2K4vFQxijU0oHwYji/1H2EOaNQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FOjUVs0GNCsxZ4S2Mv2iAwHSREbN8wlgkIYXZH4Iz7CuX2PJ1vGktHbTdwOPF3jgB
 LPVK7X5h1TwXXYX6pLz9vW63mn7wBk3MK+CCBJYdQv5Ov84Zp/VSZEFP/2JskxW/i3
 S9eEiGqsNXTBlRXVC1wwcDJnqR3c9MQOnAI9tNiI=
Received: from localhost.localdomain ([183.63.119.93])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id 5B22C6F9; Thu, 05 Dec 2024 20:22:50 +0800
X-QQ-mid: xmsmtpt1733401370tflx3c3wk
Message-ID: <tencent_6D7718DD36E722040ACEAC685854D83EA40A@qq.com>
X-QQ-XMAILINFO: Nx5J06Esz7r7NbxM/mHrEhneBywzViz0aQyJQdoftJjwO+iiZaNTyqJL0TX56Y
 /sT66MpwGjclUq9EsFPgLpqSqMJV8NeyrdHkteJHtxX8UdHOrsotQUUcLFUV9IulQtnLf1F36ytW
 Ojx7wXdMq68PnYtH/HuRR42PhKekJ5DxNqQ6XoOR3h9ruoXcjhuJo4QLyUW7xxgKq7ZnOOnofeCf
 5E1JGHBmb1IAqyL2H8DYRIXEpwrq1zF92vFYvSDIoJZ3/K1QxSLmAxRYv+dnRHa9+An8MECnhi0L
 4olsbrQYJJoNMiU8FkCdUVOISpP6bG903pIJEbHE5UkPn5RHNlBwnvkFAAxqHmQtcvpEzRNVg6vl
 64JYRNjzKmBeguMVYBscxRtuL9wLR/a849NOf4+GFVbVup/wXGaysEOUX18NSV7qtQPU1/OJe33M
 wLdl3VbcFlmjm79JmHAC6KvIEWpbnELqleOIbP6kjR0/dhdhW1Y0oEUGCkD235wDZ5SxbE54okZy
 NAJ0ILn51x9FbUe2xHbBa1h7LoXdcF6Xn1biq6TxHdywiwOFsflxQkM68ofBROt7R6i7AJAbsXvS
 rdXpYZ7gSDWZIac2AM7Xqe8LC/VPZUWLPENutwAmy6FYNmaGcHGHKnC82KpnaQAOZLCIiVZ/kLB3
 lI66cYnyLiva++I0BP0p4BnKfLwpU2SMjxUDxduzo1OEtaVVl1PQ6c4LDui6JTeyN56WcVR7TDZ6
 /tgCufCEQMv74+3b1mWt1Wd70V7JTOzir9g7rGSfD3aM80L4XaALO3VIggNf3AvydclGFwoNv5Rj
 gM7gjYZmyb8Cb/tALcfogB4KKex/StMdZdz72bNuhnUD9gWVQHkUdWzYCJ7XVVqD3hn1TOlIoyXp
 Gbu7LI4b6QEQy/WpDlEoYytWwPedEcgbx/Mtxj9B29tStiQK/eODNdCKqpHHtEJVVVSw00/Xi9Al
 4uVTuhxkY4HL52pP9StHiPRq2LhOQy3QkIphU17htrRAswexEwihImVfa+nXPr
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Nano Shinonome <1263914829@qq.com>
To: qemu-devel@nongnu.org
Cc: Nano Shinonome <1263914829@qq.com>
Subject: [PATCH 1/1] Add Zhaoxin Kaixian KX-7000 emulation and Shanghai vendor
 id Zhaoxin Kaixian KX-7000 is a Chinese made "ShiJiDaDao" microarchitecture
 CPU,
 which can be found in Zhaoxin offical website and third party evaluation. This
 CPU is increasingly being used in China's information and innovation
 environment. Offical website:
 https://www.zhaoxin.com/prod_view.aspx?nid=3&typeid=593&id=2757 PassMark
 Software website:
 https://www.cpubenchmark.net/cpu.php?cpu=ZHAOXIN+KaiXian+KX-7000 TechPowerUp:
 https://www.techpowerup.com/327036/zhaoxins-kx-7000-8-core-processor-tested-in-detail-bested-by-7-year-old-core-i3?cp=1
 GCC offical website also support "ShiJiDaDao" microarchitecture opinion in
 https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html .
Date: Thu,  5 Dec 2024 20:21:49 +0800
X-OQ-MSGID: <3a0df47f6290fc5cd336b0622ec346b3becd23dc.1733401072.git.1263914829@qq.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733401072.git.1263914829@qq.com>
References: <cover.1733401072.git.1263914829@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.46; envelope-from=1263914829@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Nano Shinonome <1263914829@qq.com>
---
 target/i386/cpu.c | 8781 +++++++++++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h | 2767 ++++++++++++++
 2 files changed, 11548 insertions(+)
 create mode 100644 target/i386/cpu.c
 create mode 100644 target/i386/cpu.h

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
new file mode 100644
index 0000000..a3298da
--- /dev/null
+++ b/target/i386/cpu.c
@@ -0,0 +1,8781 @@
+/*
+ *  i386 CPUID, CPU class, definitions, models
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/cutils.h"
+#include "qemu/qemu-print.h"
+#include "qemu/hw-version.h"
+#include "cpu.h"
+#include "tcg/helper-tcg.h"
+#include "sysemu/hvf.h"
+#include "hvf/hvf-i386.h"
+#include "kvm/kvm_i386.h"
+#include "sev.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qapi/qapi-visit-machine.h"
+#include "standard-headers/asm-x86/kvm_para.h"
+#include "hw/qdev-properties.h"
+#include "hw/i386/topology.h"
+#ifndef CONFIG_USER_ONLY
+#include "sysemu/reset.h"
+#include "qapi/qapi-commands-machine-target.h"
+#include "exec/address-spaces.h"
+#include "hw/boards.h"
+#include "hw/i386/sgx-epc.h"
+#endif
+
+#include "disas/capstone.h"
+#include "cpu-internal.h"
+
+static void x86_cpu_realizefn(DeviceState *dev, Error **errp);
+static void x86_cpu_get_supported_cpuid(uint32_t func, uint32_t index,
+                                        uint32_t *eax, uint32_t *ebx,
+                                        uint32_t *ecx, uint32_t *edx);
+
+/* Helpers for building CPUID[2] descriptors: */
+
+struct CPUID2CacheDescriptorInfo {
+    enum CacheType type;
+    int level;
+    int size;
+    int line_size;
+    int associativity;
+};
+
+/*
+ * Known CPUID 2 cache descriptors.
+ * From Intel SDM Volume 2A, CPUID instruction
+ */
+struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] = {
+    [0x06] = { .level = 1, .type = INSTRUCTION_CACHE, .size =   8 * KiB,
+               .associativity = 4,  .line_size = 32, },
+    [0x08] = { .level = 1, .type = INSTRUCTION_CACHE, .size =  16 * KiB,
+               .associativity = 4,  .line_size = 32, },
+    [0x09] = { .level = 1, .type = INSTRUCTION_CACHE, .size =  32 * KiB,
+               .associativity = 4,  .line_size = 64, },
+    [0x0A] = { .level = 1, .type = DATA_CACHE,        .size =   8 * KiB,
+               .associativity = 2,  .line_size = 32, },
+    [0x0C] = { .level = 1, .type = DATA_CACHE,        .size =  16 * KiB,
+               .associativity = 4,  .line_size = 32, },
+    [0x0D] = { .level = 1, .type = DATA_CACHE,        .size =  16 * KiB,
+               .associativity = 4,  .line_size = 64, },
+    [0x0E] = { .level = 1, .type = DATA_CACHE,        .size =  24 * KiB,
+               .associativity = 6,  .line_size = 64, },
+    [0x1D] = { .level = 2, .type = UNIFIED_CACHE,     .size = 128 * KiB,
+               .associativity = 2,  .line_size = 64, },
+    [0x21] = { .level = 2, .type = UNIFIED_CACHE,     .size = 256 * KiB,
+               .associativity = 8,  .line_size = 64, },
+    /* lines per sector is not supported cpuid2_cache_descriptor(),
+    * so descriptors 0x22, 0x23 are not included
+    */
+    [0x24] = { .level = 2, .type = UNIFIED_CACHE,     .size =   1 * MiB,
+               .associativity = 16, .line_size = 64, },
+    /* lines per sector is not supported cpuid2_cache_descriptor(),
+    * so descriptors 0x25, 0x20 are not included
+    */
+    [0x2C] = { .level = 1, .type = DATA_CACHE,        .size =  32 * KiB,
+               .associativity = 8,  .line_size = 64, },
+    [0x30] = { .level = 1, .type = INSTRUCTION_CACHE, .size =  32 * KiB,
+               .associativity = 8,  .line_size = 64, },
+    [0x41] = { .level = 2, .type = UNIFIED_CACHE,     .size = 128 * KiB,
+               .associativity = 4,  .line_size = 32, },
+    [0x42] = { .level = 2, .type = UNIFIED_CACHE,     .size = 256 * KiB,
+               .associativity = 4,  .line_size = 32, },
+    [0x43] = { .level = 2, .type = UNIFIED_CACHE,     .size = 512 * KiB,
+               .associativity = 4,  .line_size = 32, },
+    [0x44] = { .level = 2, .type = UNIFIED_CACHE,     .size =   1 * MiB,
+               .associativity = 4,  .line_size = 32, },
+    [0x45] = { .level = 2, .type = UNIFIED_CACHE,     .size =   2 * MiB,
+               .associativity = 4,  .line_size = 32, },
+    [0x46] = { .level = 3, .type = UNIFIED_CACHE,     .size =   4 * MiB,
+               .associativity = 4,  .line_size = 64, },
+    [0x47] = { .level = 3, .type = UNIFIED_CACHE,     .size =   8 * MiB,
+               .associativity = 8,  .line_size = 64, },
+    [0x48] = { .level = 2, .type = UNIFIED_CACHE,     .size =   3 * MiB,
+               .associativity = 12, .line_size = 64, },
+    /* Descriptor 0x49 depends on CPU family/model, so it is not included */
+    [0x4A] = { .level = 3, .type = UNIFIED_CACHE,     .size =   6 * MiB,
+               .associativity = 12, .line_size = 64, },
+    [0x4B] = { .level = 3, .type = UNIFIED_CACHE,     .size =   8 * MiB,
+               .associativity = 16, .line_size = 64, },
+    [0x4C] = { .level = 3, .type = UNIFIED_CACHE,     .size =  12 * MiB,
+               .associativity = 12, .line_size = 64, },
+    [0x4D] = { .level = 3, .type = UNIFIED_CACHE,     .size =  16 * MiB,
+               .associativity = 16, .line_size = 64, },
+    [0x4E] = { .level = 2, .type = UNIFIED_CACHE,     .size =   6 * MiB,
+               .associativity = 24, .line_size = 64, },
+    [0x60] = { .level = 1, .type = DATA_CACHE,        .size =  16 * KiB,
+               .associativity = 8,  .line_size = 64, },
+    [0x66] = { .level = 1, .type = DATA_CACHE,        .size =   8 * KiB,
+               .associativity = 4,  .line_size = 64, },
+    [0x67] = { .level = 1, .type = DATA_CACHE,        .size =  16 * KiB,
+               .associativity = 4,  .line_size = 64, },
+    [0x68] = { .level = 1, .type = DATA_CACHE,        .size =  32 * KiB,
+               .associativity = 4,  .line_size = 64, },
+    [0x78] = { .level = 2, .type = UNIFIED_CACHE,     .size =   1 * MiB,
+               .associativity = 4,  .line_size = 64, },
+    /* lines per sector is not supported cpuid2_cache_descriptor(),
+    * so descriptors 0x79, 0x7A, 0x7B, 0x7C are not included.
+    */
+    [0x7D] = { .level = 2, .type = UNIFIED_CACHE,     .size =   2 * MiB,
+               .associativity = 8,  .line_size = 64, },
+    [0x7F] = { .level = 2, .type = UNIFIED_CACHE,     .size = 512 * KiB,
+               .associativity = 2,  .line_size = 64, },
+    [0x80] = { .level = 2, .type = UNIFIED_CACHE,     .size = 512 * KiB,
+               .associativity = 8,  .line_size = 64, },
+    [0x82] = { .level = 2, .type = UNIFIED_CACHE,     .size = 256 * KiB,
+               .associativity = 8,  .line_size = 32, },
+    [0x83] = { .level = 2, .type = UNIFIED_CACHE,     .size = 512 * KiB,
+               .associativity = 8,  .line_size = 32, },
+    [0x84] = { .level = 2, .type = UNIFIED_CACHE,     .size =   1 * MiB,
+               .associativity = 8,  .line_size = 32, },
+    [0x85] = { .level = 2, .type = UNIFIED_CACHE,     .size =   2 * MiB,
+               .associativity = 8,  .line_size = 32, },
+    [0x86] = { .level = 2, .type = UNIFIED_CACHE,     .size = 512 * KiB,
+               .associativity = 4,  .line_size = 64, },
+    [0x87] = { .level = 2, .type = UNIFIED_CACHE,     .size =   1 * MiB,
+               .associativity = 8,  .line_size = 64, },
+    [0xD0] = { .level = 3, .type = UNIFIED_CACHE,     .size = 512 * KiB,
+               .associativity = 4,  .line_size = 64, },
+    [0xD1] = { .level = 3, .type = UNIFIED_CACHE,     .size =   1 * MiB,
+               .associativity = 4,  .line_size = 64, },
+    [0xD2] = { .level = 3, .type = UNIFIED_CACHE,     .size =   2 * MiB,
+               .associativity = 4,  .line_size = 64, },
+    [0xD6] = { .level = 3, .type = UNIFIED_CACHE,     .size =   1 * MiB,
+               .associativity = 8,  .line_size = 64, },
+    [0xD7] = { .level = 3, .type = UNIFIED_CACHE,     .size =   2 * MiB,
+               .associativity = 8,  .line_size = 64, },
+    [0xD8] = { .level = 3, .type = UNIFIED_CACHE,     .size =   4 * MiB,
+               .associativity = 8,  .line_size = 64, },
+    [0xDC] = { .level = 3, .type = UNIFIED_CACHE,     .size = 1.5 * MiB,
+               .associativity = 12, .line_size = 64, },
+    [0xDD] = { .level = 3, .type = UNIFIED_CACHE,     .size =   3 * MiB,
+               .associativity = 12, .line_size = 64, },
+    [0xDE] = { .level = 3, .type = UNIFIED_CACHE,     .size =   6 * MiB,
+               .associativity = 12, .line_size = 64, },
+    [0xE2] = { .level = 3, .type = UNIFIED_CACHE,     .size =   2 * MiB,
+               .associativity = 16, .line_size = 64, },
+    [0xE3] = { .level = 3, .type = UNIFIED_CACHE,     .size =   4 * MiB,
+               .associativity = 16, .line_size = 64, },
+    [0xE4] = { .level = 3, .type = UNIFIED_CACHE,     .size =   8 * MiB,
+               .associativity = 16, .line_size = 64, },
+    [0xEA] = { .level = 3, .type = UNIFIED_CACHE,     .size =  12 * MiB,
+               .associativity = 24, .line_size = 64, },
+    [0xEB] = { .level = 3, .type = UNIFIED_CACHE,     .size =  18 * MiB,
+               .associativity = 24, .line_size = 64, },
+    [0xEC] = { .level = 3, .type = UNIFIED_CACHE,     .size =  24 * MiB,
+               .associativity = 24, .line_size = 64, },
+};
+
+/*
+ * "CPUID leaf 2 does not report cache descriptor information,
+ * use CPUID leaf 4 to query cache parameters"
+ */
+#define CACHE_DESCRIPTOR_UNAVAILABLE 0xFF
+
+/*
+ * Return a CPUID 2 cache descriptor for a given cache.
+ * If no known descriptor is found, return CACHE_DESCRIPTOR_UNAVAILABLE
+ */
+static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache)
+{
+    int i;
+
+    assert(cache->size > 0);
+    assert(cache->level > 0);
+    assert(cache->line_size > 0);
+    assert(cache->associativity > 0);
+    for (i = 0; i < ARRAY_SIZE(cpuid2_cache_descriptors); i++) {
+        struct CPUID2CacheDescriptorInfo *d = &cpuid2_cache_descriptors[i];
+        if (d->level == cache->level && d->type == cache->type &&
+            d->size == cache->size && d->line_size == cache->line_size &&
+            d->associativity == cache->associativity) {
+                return i;
+            }
+    }
+
+    return CACHE_DESCRIPTOR_UNAVAILABLE;
+}
+
+/* CPUID Leaf 4 constants: */
+
+/* EAX: */
+#define CACHE_TYPE_D    1
+#define CACHE_TYPE_I    2
+#define CACHE_TYPE_UNIFIED   3
+
+#define CACHE_LEVEL(l)        (l << 5)
+
+#define CACHE_SELF_INIT_LEVEL (1 << 8)
+
+/* EDX: */
+#define CACHE_NO_INVD_SHARING   (1 << 0)
+#define CACHE_INCLUSIVE       (1 << 1)
+#define CACHE_COMPLEX_IDX     (1 << 2)
+
+/* Encode CacheType for CPUID[4].EAX */
+#define CACHE_TYPE(t) (((t) == DATA_CACHE) ? CACHE_TYPE_D : \
+                       ((t) == INSTRUCTION_CACHE) ? CACHE_TYPE_I : \
+                       ((t) == UNIFIED_CACHE) ? CACHE_TYPE_UNIFIED : \
+                       0 /* Invalid value */)
+
+static uint32_t max_thread_ids_for_cache(X86CPUTopoInfo *topo_info,
+                                         enum CpuTopologyLevel share_level)
+{
+    uint32_t num_ids = 0;
+
+    switch (share_level) {
+    case CPU_TOPOLOGY_LEVEL_CORE:
+        num_ids = 1 << apicid_core_offset(topo_info);
+        break;
+    case CPU_TOPOLOGY_LEVEL_DIE:
+        num_ids = 1 << apicid_die_offset(topo_info);
+        break;
+    case CPU_TOPOLOGY_LEVEL_SOCKET:
+        num_ids = 1 << apicid_pkg_offset(topo_info);
+        break;
+    default:
+        /*
+         * Currently there is no use case for THREAD and MODULE, so use
+         * assert directly to facilitate debugging.
+         */
+        g_assert_not_reached();
+    }
+
+    return num_ids - 1;
+}
+
+static uint32_t max_core_ids_in_package(X86CPUTopoInfo *topo_info)
+{
+    uint32_t num_cores = 1 << (apicid_pkg_offset(topo_info) -
+                               apicid_core_offset(topo_info));
+    return num_cores - 1;
+}
+
+/* Encode cache info for CPUID[4] */
+static void encode_cache_cpuid4(CPUCacheInfo *cache,
+                                X86CPUTopoInfo *topo_info,
+                                uint32_t *eax, uint32_t *ebx,
+                                uint32_t *ecx, uint32_t *edx)
+{
+    assert(cache->size == cache->line_size * cache->associativity *
+                          cache->partitions * cache->sets);
+
+    *eax = CACHE_TYPE(cache->type) |
+           CACHE_LEVEL(cache->level) |
+           (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0) |
+           (max_core_ids_in_package(topo_info) << 26) |
+           (max_thread_ids_for_cache(topo_info, cache->share_level) << 14);
+
+    assert(cache->line_size > 0);
+    assert(cache->partitions > 0);
+    assert(cache->associativity > 0);
+    /* We don't implement fully-associative caches */
+    assert(cache->associativity < cache->sets);
+    *ebx = (cache->line_size - 1) |
+           ((cache->partitions - 1) << 12) |
+           ((cache->associativity - 1) << 22);
+
+    assert(cache->sets > 0);
+    *ecx = cache->sets - 1;
+
+    *edx = (cache->no_invd_sharing ? CACHE_NO_INVD_SHARING : 0) |
+           (cache->inclusive ? CACHE_INCLUSIVE : 0) |
+           (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
+}
+
+static uint32_t num_threads_by_topo_level(X86CPUTopoInfo *topo_info,
+                                          enum CpuTopologyLevel topo_level)
+{
+    switch (topo_level) {
+    case CPU_TOPOLOGY_LEVEL_THREAD:
+        return 1;
+    case CPU_TOPOLOGY_LEVEL_CORE:
+        return topo_info->threads_per_core;
+    case CPU_TOPOLOGY_LEVEL_MODULE:
+        return topo_info->threads_per_core * topo_info->cores_per_module;
+    case CPU_TOPOLOGY_LEVEL_DIE:
+        return topo_info->threads_per_core * topo_info->cores_per_module *
+               topo_info->modules_per_die;
+    case CPU_TOPOLOGY_LEVEL_SOCKET:
+        return topo_info->threads_per_core * topo_info->cores_per_module *
+               topo_info->modules_per_die * topo_info->dies_per_pkg;
+    default:
+        g_assert_not_reached();
+    }
+    return 0;
+}
+
+static uint32_t apicid_offset_by_topo_level(X86CPUTopoInfo *topo_info,
+                                            enum CpuTopologyLevel topo_level)
+{
+    switch (topo_level) {
+    case CPU_TOPOLOGY_LEVEL_THREAD:
+        return 0;
+    case CPU_TOPOLOGY_LEVEL_CORE:
+        return apicid_core_offset(topo_info);
+    case CPU_TOPOLOGY_LEVEL_MODULE:
+        return apicid_module_offset(topo_info);
+    case CPU_TOPOLOGY_LEVEL_DIE:
+        return apicid_die_offset(topo_info);
+    case CPU_TOPOLOGY_LEVEL_SOCKET:
+        return apicid_pkg_offset(topo_info);
+    default:
+        g_assert_not_reached();
+    }
+    return 0;
+}
+
+static uint32_t cpuid1f_topo_type(enum CpuTopologyLevel topo_level)
+{
+    switch (topo_level) {
+    case CPU_TOPOLOGY_LEVEL_INVALID:
+        return CPUID_1F_ECX_TOPO_LEVEL_INVALID;
+    case CPU_TOPOLOGY_LEVEL_THREAD:
+        return CPUID_1F_ECX_TOPO_LEVEL_SMT;
+    case CPU_TOPOLOGY_LEVEL_CORE:
+        return CPUID_1F_ECX_TOPO_LEVEL_CORE;
+    case CPU_TOPOLOGY_LEVEL_MODULE:
+        return CPUID_1F_ECX_TOPO_LEVEL_MODULE;
+    case CPU_TOPOLOGY_LEVEL_DIE:
+        return CPUID_1F_ECX_TOPO_LEVEL_DIE;
+    default:
+        /* Other types are not supported in QEMU. */
+        g_assert_not_reached();
+    }
+    return 0;
+}
+
+static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
+                                X86CPUTopoInfo *topo_info,
+                                uint32_t *eax, uint32_t *ebx,
+                                uint32_t *ecx, uint32_t *edx)
+{
+    X86CPU *cpu = env_archcpu(env);
+    unsigned long level, base_level, next_level;
+    uint32_t num_threads_next_level, offset_next_level;
+
+    assert(count <= CPU_TOPOLOGY_LEVEL_SOCKET);
+
+    /*
+     * Find the No.(count + 1) topology level in avail_cpu_topo bitmap.
+     * The search starts from bit 0 (CPU_TOPOLOGY_LEVEL_THREAD).
+     */
+    level = CPU_TOPOLOGY_LEVEL_THREAD;
+    base_level = level;
+    for (int i = 0; i <= count; i++) {
+        level = find_next_bit(env->avail_cpu_topo,
+                              CPU_TOPOLOGY_LEVEL_SOCKET,
+                              base_level);
+
+        /*
+         * CPUID[0x1f] doesn't explicitly encode the package level,
+         * and it just encodes the invalid level (all fields are 0)
+         * into the last subleaf of 0x1f.
+         */
+        if (level == CPU_TOPOLOGY_LEVEL_SOCKET) {
+            level = CPU_TOPOLOGY_LEVEL_INVALID;
+            break;
+        }
+        /* Search the next level. */
+        base_level = level + 1;
+    }
+
+    if (level == CPU_TOPOLOGY_LEVEL_INVALID) {
+        num_threads_next_level = 0;
+        offset_next_level = 0;
+    } else {
+        next_level = find_next_bit(env->avail_cpu_topo,
+                                   CPU_TOPOLOGY_LEVEL_SOCKET,
+                                   level + 1);
+        num_threads_next_level = num_threads_by_topo_level(topo_info,
+                                                           next_level);
+        offset_next_level = apicid_offset_by_topo_level(topo_info,
+                                                        next_level);
+    }
+
+    *eax = offset_next_level;
+    /* The count (bits 15-00) doesn't need to be reliable. */
+    *ebx = num_threads_next_level & 0xffff;
+    *ecx = (count & 0xff) | (cpuid1f_topo_type(level) << 8);
+    *edx = cpu->apic_id;
+
+    assert(!(*eax & ~0x1f));
+}
+
+/* Encode cache info for CPUID[0x80000005].ECX or CPUID[0x80000005].EDX */
+static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)
+{
+    assert(cache->size % 1024 == 0);
+    assert(cache->lines_per_tag > 0);
+    assert(cache->associativity > 0);
+    assert(cache->line_size > 0);
+    return ((cache->size / 1024) << 24) | (cache->associativity << 16) |
+           (cache->lines_per_tag << 8) | (cache->line_size);
+}
+
+#define ASSOC_FULL 0xFF
+
+/* AMD associativity encoding used on CPUID Leaf 0x80000006: */
+#define AMD_ENC_ASSOC(a) (a <=   1 ? a   : \
+                          a ==   2 ? 0x2 : \
+                          a ==   4 ? 0x4 : \
+                          a ==   8 ? 0x6 : \
+                          a ==  16 ? 0x8 : \
+                          a ==  32 ? 0xA : \
+                          a ==  48 ? 0xB : \
+                          a ==  64 ? 0xC : \
+                          a ==  96 ? 0xD : \
+                          a == 128 ? 0xE : \
+                          a == ASSOC_FULL ? 0xF : \
+                          0 /* invalid value */)
+
+/*
+ * Encode cache info for CPUID[0x80000006].ECX and CPUID[0x80000006].EDX
+ * @l3 can be NULL.
+ */
+static void encode_cache_cpuid80000006(CPUCacheInfo *l2,
+                                       CPUCacheInfo *l3,
+                                       uint32_t *ecx, uint32_t *edx)
+{
+    assert(l2->size % 1024 == 0);
+    assert(l2->associativity > 0);
+    assert(l2->lines_per_tag > 0);
+    assert(l2->line_size > 0);
+    *ecx = ((l2->size / 1024) << 16) |
+           (AMD_ENC_ASSOC(l2->associativity) << 12) |
+           (l2->lines_per_tag << 8) | (l2->line_size);
+
+    if (l3) {
+        assert(l3->size % (512 * 1024) == 0);
+        assert(l3->associativity > 0);
+        assert(l3->lines_per_tag > 0);
+        assert(l3->line_size > 0);
+        *edx = ((l3->size / (512 * 1024)) << 18) |
+               (AMD_ENC_ASSOC(l3->associativity) << 12) |
+               (l3->lines_per_tag << 8) | (l3->line_size);
+    } else {
+        *edx = 0;
+    }
+}
+
+/* Encode cache info for CPUID[8000001D] */
+static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
+                                       X86CPUTopoInfo *topo_info,
+                                       uint32_t *eax, uint32_t *ebx,
+                                       uint32_t *ecx, uint32_t *edx)
+{
+    assert(cache->size == cache->line_size * cache->associativity *
+                          cache->partitions * cache->sets);
+
+    *eax = CACHE_TYPE(cache->type) | CACHE_LEVEL(cache->level) |
+               (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0);
+    *eax |= max_thread_ids_for_cache(topo_info, cache->share_level) << 14;
+
+    assert(cache->line_size > 0);
+    assert(cache->partitions > 0);
+    assert(cache->associativity > 0);
+    /* We don't implement fully-associative caches */
+    assert(cache->associativity < cache->sets);
+    *ebx = (cache->line_size - 1) |
+           ((cache->partitions - 1) << 12) |
+           ((cache->associativity - 1) << 22);
+
+    assert(cache->sets > 0);
+    *ecx = cache->sets - 1;
+
+    *edx = (cache->no_invd_sharing ? CACHE_NO_INVD_SHARING : 0) |
+           (cache->inclusive ? CACHE_INCLUSIVE : 0) |
+           (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
+}
+
+/* Encode cache info for CPUID[8000001E] */
+static void encode_topo_cpuid8000001e(X86CPU *cpu, X86CPUTopoInfo *topo_info,
+                                      uint32_t *eax, uint32_t *ebx,
+                                      uint32_t *ecx, uint32_t *edx)
+{
+    X86CPUTopoIDs topo_ids;
+
+    x86_topo_ids_from_apicid(cpu->apic_id, topo_info, &topo_ids);
+
+    *eax = cpu->apic_id;
+
+    /*
+     * CPUID_Fn8000001E_EBX [Core Identifiers] (CoreId)
+     * Read-only. Reset: 0000_XXXXh.
+     * See Core::X86::Cpuid::ExtApicId.
+     * Core::X86::Cpuid::CoreId_lthree[1:0]_core[3:0]_thread[1:0];
+     * Bits Description
+     * 31:16 Reserved.
+     * 15:8 ThreadsPerCore: threads per core. Read-only. Reset: XXh.
+     *      The number of threads per core is ThreadsPerCore+1.
+     *  7:0 CoreId: core ID. Read-only. Reset: XXh.
+     *
+     *  NOTE: CoreId is already part of apic_id. Just use it. We can
+     *  use all the 8 bits to represent the core_id here.
+     */
+    *ebx = ((topo_info->threads_per_core - 1) << 8) | (topo_ids.core_id & 0xFF);
+
+    /*
+     * CPUID_Fn8000001E_ECX [Node Identifiers] (NodeId)
+     * Read-only. Reset: 0000_0XXXh.
+     * Core::X86::Cpuid::NodeId_lthree[1:0]_core[3:0]_thread[1:0];
+     * Bits Description
+     * 31:11 Reserved.
+     * 10:8 NodesPerProcessor: Node per processor. Read-only. Reset: XXXb.
+     *      ValidValues:
+     *      Value   Description
+     *      0h      1 node per processor.
+     *      7h-1h   Reserved.
+     *  7:0 NodeId: Node ID. Read-only. Reset: XXh.
+     *
+     * NOTE: Hardware reserves 3 bits for number of nodes per processor.
+     * But users can create more nodes than the actual hardware can
+     * support. To genaralize we can use all the upper 8 bits for nodes.
+     * NodeId is combination of node and socket_id which is already decoded
+     * in apic_id. Just use it by shifting.
+     */
+    if (cpu->legacy_multi_node) {
+        *ecx = ((topo_info->dies_per_pkg - 1) << 8) |
+               ((cpu->apic_id >> apicid_die_offset(topo_info)) & 0xFF);
+    } else {
+        *ecx = (cpu->apic_id >> apicid_pkg_offset(topo_info)) & 0xFF;
+    }
+
+    *edx = 0;
+}
+
+/*
+ * Definitions of the hardcoded cache entries we expose:
+ * These are legacy cache values. If there is a need to change any
+ * of these values please use builtin_x86_defs
+ */
+
+/* L1 data cache: */
+static CPUCacheInfo legacy_l1d_cache = {
+    .type = DATA_CACHE,
+    .level = 1,
+    .size = 32 * KiB,
+    .self_init = 1,
+    .line_size = 64,
+    .associativity = 8,
+    .sets = 64,
+    .partitions = 1,
+    .no_invd_sharing = true,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+};
+
+/*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
+static CPUCacheInfo legacy_l1d_cache_amd = {
+    .type = DATA_CACHE,
+    .level = 1,
+    .size = 64 * KiB,
+    .self_init = 1,
+    .line_size = 64,
+    .associativity = 2,
+    .sets = 512,
+    .partitions = 1,
+    .lines_per_tag = 1,
+    .no_invd_sharing = true,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+};
+
+/* L1 instruction cache: */
+static CPUCacheInfo legacy_l1i_cache = {
+    .type = INSTRUCTION_CACHE,
+    .level = 1,
+    .size = 32 * KiB,
+    .self_init = 1,
+    .line_size = 64,
+    .associativity = 8,
+    .sets = 64,
+    .partitions = 1,
+    .no_invd_sharing = true,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+};
+
+/*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
+static CPUCacheInfo legacy_l1i_cache_amd = {
+    .type = INSTRUCTION_CACHE,
+    .level = 1,
+    .size = 64 * KiB,
+    .self_init = 1,
+    .line_size = 64,
+    .associativity = 2,
+    .sets = 512,
+    .partitions = 1,
+    .lines_per_tag = 1,
+    .no_invd_sharing = true,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+};
+
+/* Level 2 unified cache: */
+static CPUCacheInfo legacy_l2_cache = {
+    .type = UNIFIED_CACHE,
+    .level = 2,
+    .size = 4 * MiB,
+    .self_init = 1,
+    .line_size = 64,
+    .associativity = 16,
+    .sets = 4096,
+    .partitions = 1,
+    .no_invd_sharing = true,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+};
+
+/*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */
+static CPUCacheInfo legacy_l2_cache_cpuid2 = {
+    .type = UNIFIED_CACHE,
+    .level = 2,
+    .size = 2 * MiB,
+    .line_size = 64,
+    .associativity = 8,
+    .share_level = CPU_TOPOLOGY_LEVEL_INVALID,
+};
+
+
+/*FIXME: CPUID leaf 0x80000006 is inconsistent with leaves 2 & 4 */
+static CPUCacheInfo legacy_l2_cache_amd = {
+    .type = UNIFIED_CACHE,
+    .level = 2,
+    .size = 512 * KiB,
+    .line_size = 64,
+    .lines_per_tag = 1,
+    .associativity = 16,
+    .sets = 512,
+    .partitions = 1,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+};
+
+/* Level 3 unified cache: */
+static CPUCacheInfo legacy_l3_cache = {
+    .type = UNIFIED_CACHE,
+    .level = 3,
+    .size = 16 * MiB,
+    .line_size = 64,
+    .associativity = 16,
+    .sets = 16384,
+    .partitions = 1,
+    .lines_per_tag = 1,
+    .self_init = true,
+    .inclusive = true,
+    .complex_indexing = true,
+    .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+};
+
+/* TLB definitions: */
+
+#define L1_DTLB_2M_ASSOC       1
+#define L1_DTLB_2M_ENTRIES   255
+#define L1_DTLB_4K_ASSOC       1
+#define L1_DTLB_4K_ENTRIES   255
+
+#define L1_ITLB_2M_ASSOC       1
+#define L1_ITLB_2M_ENTRIES   255
+#define L1_ITLB_4K_ASSOC       1
+#define L1_ITLB_4K_ENTRIES   255
+
+#define L2_DTLB_2M_ASSOC       0 /* disabled */
+#define L2_DTLB_2M_ENTRIES     0 /* disabled */
+#define L2_DTLB_4K_ASSOC       4
+#define L2_DTLB_4K_ENTRIES   512
+
+#define L2_ITLB_2M_ASSOC       0 /* disabled */
+#define L2_ITLB_2M_ENTRIES     0 /* disabled */
+#define L2_ITLB_4K_ASSOC       4
+#define L2_ITLB_4K_ENTRIES   512
+
+/* CPUID Leaf 0x14 constants: */
+#define INTEL_PT_MAX_SUBLEAF     0x1
+/*
+ * bit[00]: IA32_RTIT_CTL.CR3 filter can be set to 1 and IA32_RTIT_CR3_MATCH
+ *          MSR can be accessed;
+ * bit[01]: Support Configurable PSB and Cycle-Accurate Mode;
+ * bit[02]: Support IP Filtering, TraceStop filtering, and preservation
+ *          of Intel PT MSRs across warm reset;
+ * bit[03]: Support MTC timing packet and suppression of COFI-based packets;
+ */
+#define INTEL_PT_MINIMAL_EBX     0xf
+/*
+ * bit[00]: Tracing can be enabled with IA32_RTIT_CTL.ToPA = 1 and
+ *          IA32_RTIT_OUTPUT_BASE and IA32_RTIT_OUTPUT_MASK_PTRS MSRs can be
+ *          accessed;
+ * bit[01]: ToPA tables can hold any number of output entries, up to the
+ *          maximum allowed by the MaskOrTableOffset field of
+ *          IA32_RTIT_OUTPUT_MASK_PTRS;
+ * bit[02]: Support Single-Range Output scheme;
+ */
+#define INTEL_PT_MINIMAL_ECX     0x7
+/* generated packets which contain IP payloads have LIP values */
+#define INTEL_PT_IP_LIP          (1 << 31)
+#define INTEL_PT_ADDR_RANGES_NUM 0x2 /* Number of configurable address ranges */
+#define INTEL_PT_ADDR_RANGES_NUM_MASK 0x3
+#define INTEL_PT_MTC_BITMAP      (0x0249 << 16) /* Support ART(0,3,6,9) */
+#define INTEL_PT_CYCLE_BITMAP    0x1fff         /* Support 0,2^(0~11) */
+#define INTEL_PT_PSB_BITMAP      (0x003f << 16) /* Support 2K,4K,8K,16K,32K,64K */
+
+/* CPUID Leaf 0x1D constants: */
+#define INTEL_AMX_TILE_MAX_SUBLEAF     0x1
+#define INTEL_AMX_TOTAL_TILE_BYTES     0x2000
+#define INTEL_AMX_BYTES_PER_TILE       0x400
+#define INTEL_AMX_BYTES_PER_ROW        0x40
+#define INTEL_AMX_TILE_MAX_NAMES       0x8
+#define INTEL_AMX_TILE_MAX_ROWS        0x10
+
+/* CPUID Leaf 0x1E constants: */
+#define INTEL_AMX_TMUL_MAX_K           0x10
+#define INTEL_AMX_TMUL_MAX_N           0x40
+
+void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
+                              uint32_t vendor2, uint32_t vendor3)
+{
+    int i;
+    for (i = 0; i < 4; i++) {
+        dst[i] = vendor1 >> (8 * i);
+        dst[i + 4] = vendor2 >> (8 * i);
+        dst[i + 8] = vendor3 >> (8 * i);
+    }
+    dst[CPUID_VENDOR_SZ] = '\0';
+}
+
+#define I486_FEATURES (CPUID_FP87 | CPUID_VME | CPUID_PSE)
+#define PENTIUM_FEATURES (I486_FEATURES | CPUID_DE | CPUID_TSC | \
+          CPUID_MSR | CPUID_MCE | CPUID_CX8 | CPUID_MMX | CPUID_APIC)
+#define PENTIUM2_FEATURES (PENTIUM_FEATURES | CPUID_PAE | CPUID_SEP | \
+          CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV | CPUID_PAT | \
+          CPUID_PSE36 | CPUID_FXSR)
+#define PENTIUM3_FEATURES (PENTIUM2_FEATURES | CPUID_SSE)
+#define PPRO_FEATURES (CPUID_FP87 | CPUID_DE | CPUID_PSE | CPUID_TSC | \
+          CPUID_MSR | CPUID_MCE | CPUID_CX8 | CPUID_PGE | CPUID_CMOV | \
+          CPUID_PAT | CPUID_FXSR | CPUID_MMX | CPUID_SSE | CPUID_SSE2 | \
+          CPUID_PAE | CPUID_SEP | CPUID_APIC)
+
+#define TCG_FEATURES (CPUID_FP87 | CPUID_PSE | CPUID_TSC | CPUID_MSR | \
+          CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC | CPUID_SEP | \
+          CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV | CPUID_PAT | \
+          CPUID_PSE36 | CPUID_CLFLUSH | CPUID_ACPI | CPUID_MMX | \
+          CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS | CPUID_DE)
+          /* partly implemented:
+          CPUID_MTRR, CPUID_MCA, CPUID_CLFLUSH (needed for Win64) */
+          /* missing:
+          CPUID_VME, CPUID_DTS, CPUID_SS, CPUID_HT, CPUID_TM, CPUID_PBE */
+
+/*
+ * Kernel-only features that can be shown to usermode programs even if
+ * they aren't actually supported by TCG, because qemu-user only runs
+ * in CPL=3; remove them if they are ever implemented for system emulation.
+ */
+#if defined CONFIG_USER_ONLY
+#define CPUID_EXT_KERNEL_FEATURES \
+          (CPUID_EXT_PCID | CPUID_EXT_TSC_DEADLINE_TIMER)
+#else
+#define CPUID_EXT_KERNEL_FEATURES 0
+#endif
+#define TCG_EXT_FEATURES (CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | \
+          CPUID_EXT_MONITOR | CPUID_EXT_SSSE3 | CPUID_EXT_CX16 | \
+          CPUID_EXT_SSE41 | CPUID_EXT_SSE42 | CPUID_EXT_POPCNT | \
+          CPUID_EXT_XSAVE | /* CPUID_EXT_OSXSAVE is dynamic */   \
+          CPUID_EXT_MOVBE | CPUID_EXT_AES | CPUID_EXT_HYPERVISOR | \
+          CPUID_EXT_RDRAND | CPUID_EXT_AVX | CPUID_EXT_F16C | \
+          CPUID_EXT_FMA | CPUID_EXT_X2APIC | CPUID_EXT_KERNEL_FEATURES)
+          /* missing:
+          CPUID_EXT_DTES64, CPUID_EXT_DSCPL, CPUID_EXT_VMX, CPUID_EXT_SMX,
+          CPUID_EXT_EST, CPUID_EXT_TM2, CPUID_EXT_CID,
+          CPUID_EXT_XTPR, CPUID_EXT_PDCM, CPUID_EXT_PCID, CPUID_EXT_DCA,
+          CPUID_EXT_TSC_DEADLINE_TIMER
+          */
+
+#ifdef TARGET_X86_64
+#define TCG_EXT2_X86_64_FEATURES CPUID_EXT2_LM
+#else
+#define TCG_EXT2_X86_64_FEATURES 0
+#endif
+
+/*
+ * CPUID_*_KERNEL_FEATURES denotes bits and features that are not usable
+ * in usermode or by 32-bit programs.  Those are added to supported
+ * TCG features unconditionally in user-mode emulation mode.  This may
+ * indeed seem strange or incorrect, but it works because code running
+ * under usermode emulation cannot access them.
+ *
+ * Even for long mode, qemu-i386 is not running "a userspace program on a
+ * 32-bit CPU"; it's running "a userspace program with a 32-bit code segment"
+ * and therefore using the 32-bit ABI; the CPU itself might be 64-bit
+ * but again the difference is only visible in kernel mode.
+ */
+#if defined CONFIG_LINUX_USER
+#define CPUID_EXT2_KERNEL_FEATURES (CPUID_EXT2_LM | CPUID_EXT2_FFXSR)
+#elif defined CONFIG_USER_ONLY
+/* FIXME: Long mode not yet supported for i386 bsd-user */
+#define CPUID_EXT2_KERNEL_FEATURES CPUID_EXT2_FFXSR
+#else
+#define CPUID_EXT2_KERNEL_FEATURES 0
+#endif
+
+#define TCG_EXT2_FEATURES ((TCG_FEATURES & CPUID_EXT2_AMD_ALIASES) | \
+          CPUID_EXT2_NX | CPUID_EXT2_MMXEXT | CPUID_EXT2_RDTSCP | \
+          CPUID_EXT2_3DNOW | CPUID_EXT2_3DNOWEXT | CPUID_EXT2_PDPE1GB | \
+          CPUID_EXT2_SYSCALL | TCG_EXT2_X86_64_FEATURES | \
+          CPUID_EXT2_KERNEL_FEATURES)
+
+#if defined CONFIG_USER_ONLY
+#define CPUID_EXT3_KERNEL_FEATURES CPUID_EXT3_OSVW
+#else
+#define CPUID_EXT3_KERNEL_FEATURES 0
+#endif
+
+#define TCG_EXT3_FEATURES (CPUID_EXT3_LAHF_LM | CPUID_EXT3_SVM | \
+          CPUID_EXT3_CR8LEG | CPUID_EXT3_ABM | CPUID_EXT3_SSE4A | \
+          CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_KERNEL_FEATURES)
+
+#define TCG_EXT4_FEATURES 0
+
+#if defined CONFIG_USER_ONLY
+#define CPUID_SVM_KERNEL_FEATURES (CPUID_SVM_NRIPSAVE | CPUID_SVM_VNMI)
+#else
+#define CPUID_SVM_KERNEL_FEATURES 0
+#endif
+#define TCG_SVM_FEATURES (CPUID_SVM_NPT | CPUID_SVM_VGIF | \
+          CPUID_SVM_SVME_ADDR_CHK | CPUID_SVM_KERNEL_FEATURES)
+
+#define TCG_KVM_FEATURES 0
+
+#if defined CONFIG_USER_ONLY
+#define CPUID_7_0_EBX_KERNEL_FEATURES CPUID_7_0_EBX_INVPCID
+#else
+#define CPUID_7_0_EBX_KERNEL_FEATURES 0
+#endif
+#define TCG_7_0_EBX_FEATURES (CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_SMAP | \
+          CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ADX | \
+          CPUID_7_0_EBX_CLFLUSHOPT |            \
+          CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_FSGSBASE | \
+          CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_RDSEED | \
+          CPUID_7_0_EBX_SHA_NI | CPUID_7_0_EBX_KERNEL_FEATURES)
+          /* missing:
+          CPUID_7_0_EBX_HLE
+          CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM */
+
+#if !defined CONFIG_USER_ONLY || defined CONFIG_LINUX
+#define TCG_7_0_ECX_RDPID CPUID_7_0_ECX_RDPID
+#else
+#define TCG_7_0_ECX_RDPID 0
+#endif
+#define TCG_7_0_ECX_FEATURES (CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU | \
+          /* CPUID_7_0_ECX_OSPKE is dynamic */ \
+          CPUID_7_0_ECX_LA57 | CPUID_7_0_ECX_PKS | CPUID_7_0_ECX_VAES | \
+          TCG_7_0_ECX_RDPID)
+
+#if defined CONFIG_USER_ONLY
+#define CPUID_7_0_EDX_KERNEL_FEATURES (CPUID_7_0_EDX_SPEC_CTRL | \
+          CPUID_7_0_EDX_ARCH_CAPABILITIES | CPUID_7_0_EDX_SPEC_CTRL_SSBD)
+#else
+#define CPUID_7_0_EDX_KERNEL_FEATURES 0
+#endif
+#define TCG_7_0_EDX_FEATURES (CPUID_7_0_EDX_FSRM | CPUID_7_0_EDX_KERNEL_FEATURES)
+
+#define TCG_7_1_EAX_FEATURES (CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | \
+          CPUID_7_1_EAX_FSRC | CPUID_7_1_EAX_CMPCCXADD)
+#define TCG_7_1_EDX_FEATURES 0
+#define TCG_7_2_EDX_FEATURES 0
+#define TCG_APM_FEATURES 0
+#define TCG_6_EAX_FEATURES CPUID_6_EAX_ARAT
+#define TCG_XSAVE_FEATURES (CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1)
+          /* missing:
+          CPUID_XSAVE_XSAVEC, CPUID_XSAVE_XSAVES */
+#define TCG_14_0_ECX_FEATURES 0
+#define TCG_SGX_12_0_EAX_FEATURES 0
+#define TCG_SGX_12_0_EBX_FEATURES 0
+#define TCG_SGX_12_1_EAX_FEATURES 0
+#define TCG_24_0_EBX_FEATURES 0
+
+#if defined CONFIG_USER_ONLY
+#define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB | \
+          CPUID_8000_0008_EBX_IBRS | CPUID_8000_0008_EBX_STIBP | \
+          CPUID_8000_0008_EBX_STIBP_ALWAYS_ON | CPUID_8000_0008_EBX_AMD_SSBD | \
+          CPUID_8000_0008_EBX_AMD_PSFD)
+#else
+#define CPUID_8000_0008_EBX_KERNEL_FEATURES 0
+#endif
+
+#define TCG_8000_0008_EBX  (CPUID_8000_0008_EBX_XSAVEERPTR | \
+          CPUID_8000_0008_EBX_WBNOINVD | CPUID_8000_0008_EBX_KERNEL_FEATURES)
+
+FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
+    [FEAT_1_EDX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "fpu", "vme", "de", "pse",
+            "tsc", "msr", "pae", "mce",
+            "cx8", "apic", NULL, "sep",
+            "mtrr", "pge", "mca", "cmov",
+            "pat", "pse36", "pn" /* Intel psn */, "clflush" /* Intel clfsh */,
+            NULL, "ds" /* Intel dts */, "acpi", "mmx",
+            "fxsr", "sse", "sse2", "ss",
+            "ht" /* Intel htt */, "tm", "ia64", "pbe",
+        },
+        .cpuid = {.eax = 1, .reg = R_EDX, },
+        .tcg_features = TCG_FEATURES,
+        .no_autoenable_flags = CPUID_HT,
+    },
+    [FEAT_1_ECX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "pni" /* Intel,AMD sse3 */, "pclmulqdq", "dtes64", "monitor",
+            "ds-cpl", "vmx", "smx", "est",
+            "tm2", "ssse3", "cid", NULL,
+            "fma", "cx16", "xtpr", "pdcm",
+            NULL, "pcid", "dca", "sse4.1",
+            "sse4.2", "x2apic", "movbe", "popcnt",
+            "tsc-deadline", "aes", "xsave", NULL /* osxsave */,
+            "avx", "f16c", "rdrand", "hypervisor",
+        },
+        .cpuid = { .eax = 1, .reg = R_ECX, },
+        .tcg_features = TCG_EXT_FEATURES,
+    },
+    /* Feature names that are already defined on feature_name[] but
+     * are set on CPUID[8000_0001].EDX on AMD CPUs don't have their
+     * names on feat_names below. They are copied automatically
+     * to features[FEAT_8000_0001_EDX] if and only if CPU vendor is AMD.
+     */
+    [FEAT_8000_0001_EDX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL /* fpu */, NULL /* vme */, NULL /* de */, NULL /* pse */,
+            NULL /* tsc */, NULL /* msr */, NULL /* pae */, NULL /* mce */,
+            NULL /* cx8 */, NULL /* apic */, NULL, "syscall",
+            NULL /* mtrr */, NULL /* pge */, NULL /* mca */, NULL /* cmov */,
+            NULL /* pat */, NULL /* pse36 */, NULL, NULL /* Linux mp */,
+            "nx", NULL, "mmxext", NULL /* mmx */,
+            NULL /* fxsr */, "fxsr-opt", "pdpe1gb", "rdtscp",
+            NULL, "lm", "3dnowext", "3dnow",
+        },
+        .cpuid = { .eax = 0x80000001, .reg = R_EDX, },
+        .tcg_features = TCG_EXT2_FEATURES,
+    },
+    [FEAT_8000_0001_ECX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "lahf-lm", "cmp-legacy", "svm", "extapic",
+            "cr8legacy", "abm", "sse4a", "misalignsse",
+            "3dnowprefetch", "osvw", "ibs", "xop",
+            "skinit", "wdt", NULL, "lwp",
+            "fma4", "tce", NULL, "nodeid-msr",
+            NULL, "tbm", "topoext", "perfctr-core",
+            "perfctr-nb", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = { .eax = 0x80000001, .reg = R_ECX, },
+        .tcg_features = TCG_EXT3_FEATURES,
+        /*
+         * TOPOEXT is always allowed but can't be enabled blindly by
+         * "-cpu host", as it requires consistent cache topology info
+         * to be provided so it doesn't confuse guests.
+         */
+        .no_autoenable_flags = CPUID_EXT3_TOPOEXT,
+    },
+    [FEAT_C000_0001_EDX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, "xstore", "xstore-en",
+            NULL, NULL, "xcrypt", "xcrypt-en",
+            "ace2", "ace2-en", "phe", "phe-en",
+            "pmm", "pmm-en", NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = { .eax = 0xC0000001, .reg = R_EDX, },
+        .tcg_features = TCG_EXT4_FEATURES,
+    },
+    [FEAT_KVM] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
+            "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhalt",
+            NULL, "kvm-pv-tlb-flush", "kvm-asyncpf-vmexit", "kvm-pv-ipi",
+            "kvm-poll-control", "kvm-pv-sched-yield", "kvm-asyncpf-int", "kvm-msi-ext-dest-id",
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            "kvmclock-stable-bit", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = { .eax = KVM_CPUID_FEATURES, .reg = R_EAX, },
+        .tcg_features = TCG_KVM_FEATURES,
+    },
+    [FEAT_KVM_HINTS] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "kvm-hint-dedicated", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = { .eax = KVM_CPUID_FEATURES, .reg = R_EDX, },
+        .tcg_features = TCG_KVM_FEATURES,
+        /*
+         * KVM hints aren't auto-enabled by -cpu host, they need to be
+         * explicitly enabled in the command-line.
+         */
+        .no_autoenable_flags = ~0U,
+    },
+    [FEAT_SVM] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "npt", "lbrv", "svm-lock", "nrip-save",
+            "tsc-scale", "vmcb-clean",  "flushbyasid", "decodeassists",
+            NULL, NULL, "pause-filter", NULL,
+            "pfthreshold", "avic", NULL, "v-vmsave-vmload",
+            "vgif", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, "vnmi", NULL, NULL,
+            "svme-addr-chk", NULL, NULL, NULL,
+        },
+        .cpuid = { .eax = 0x8000000A, .reg = R_EDX, },
+        .tcg_features = TCG_SVM_FEATURES,
+    },
+    [FEAT_7_0_EBX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "fsgsbase", "tsc-adjust", "sgx", "bmi1",
+            "hle", "avx2", "fdp-excptn-only", "smep",
+            "bmi2", "erms", "invpcid", "rtm",
+            NULL, "zero-fcs-fds", "mpx", NULL,
+            "avx512f", "avx512dq", "rdseed", "adx",
+            "smap", "avx512ifma", "pcommit", "clflushopt",
+            "clwb", "intel-pt", "avx512pf", "avx512er",
+            "avx512cd", "sha-ni", "avx512bw", "avx512vl",
+        },
+        .cpuid = {
+            .eax = 7,
+            .needs_ecx = true, .ecx = 0,
+            .reg = R_EBX,
+        },
+        .tcg_features = TCG_7_0_EBX_FEATURES,
+    },
+    [FEAT_7_0_ECX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL, "avx512vbmi", "umip", "pku",
+            NULL /* ospke */, "waitpkg", "avx512vbmi2", NULL,
+            "gfni", "vaes", "vpclmulqdq", "avx512vnni",
+            "avx512bitalg", NULL, "avx512-vpopcntdq", NULL,
+            "la57", NULL, NULL, NULL,
+            NULL, NULL, "rdpid", NULL,
+            "bus-lock-detect", "cldemote", NULL, "movdiri",
+            "movdir64b", NULL, "sgxlc", "pks",
+        },
+        .cpuid = {
+            .eax = 7,
+            .needs_ecx = true, .ecx = 0,
+            .reg = R_ECX,
+        },
+        .tcg_features = TCG_7_0_ECX_FEATURES,
+    },
+    [FEAT_7_0_EDX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, "avx512-4vnniw", "avx512-4fmaps",
+            "fsrm", NULL, NULL, NULL,
+            "avx512-vp2intersect", NULL, "md-clear", NULL,
+            NULL, NULL, "serialize", NULL,
+            "tsx-ldtrk", NULL, NULL /* pconfig */, "arch-lbr",
+            NULL, NULL, "amx-bf16", "avx512-fp16",
+            "amx-tile", "amx-int8", "spec-ctrl", "stibp",
+            "flush-l1d", "arch-capabilities", "core-capability", "ssbd",
+        },
+        .cpuid = {
+            .eax = 7,
+            .needs_ecx = true, .ecx = 0,
+            .reg = R_EDX,
+        },
+        .tcg_features = TCG_7_0_EDX_FEATURES,
+    },
+    [FEAT_7_1_EAX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "sha512", "sm3", "sm4", NULL,
+            "avx-vnni", "avx512-bf16", NULL, "cmpccxadd",
+            NULL, NULL, "fzrm", "fsrs",
+            "fsrc", NULL, NULL, NULL,
+            NULL, "fred", "lkgs", "wrmsrns",
+            NULL, "amx-fp16", NULL, "avx-ifma",
+            NULL, NULL, "lam", NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = {
+            .eax = 7,
+            .needs_ecx = true, .ecx = 1,
+            .reg = R_EAX,
+        },
+        .tcg_features = TCG_7_1_EAX_FEATURES,
+    },
+    [FEAT_7_1_EDX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, NULL, NULL,
+            "avx-vnni-int8", "avx-ne-convert", NULL, NULL,
+            "amx-complex", NULL, "avx-vnni-int16", NULL,
+            NULL, NULL, "prefetchiti", NULL,
+            NULL, NULL, NULL, "avx10",
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = {
+            .eax = 7,
+            .needs_ecx = true, .ecx = 1,
+            .reg = R_EDX,
+        },
+        .tcg_features = TCG_7_1_EDX_FEATURES,
+    },
+    [FEAT_7_2_EDX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "intel-psfd", "ipred-ctrl", "rrsba-ctrl", "ddpd-u",
+            "bhi-ctrl", "mcdt-no", NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = {
+            .eax = 7,
+            .needs_ecx = true, .ecx = 2,
+            .reg = R_EDX,
+        },
+        .tcg_features = TCG_7_2_EDX_FEATURES,
+    },
+    [FEAT_24_0_EBX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            [16] = "avx10-128",
+            [17] = "avx10-256",
+            [18] = "avx10-512",
+        },
+        .cpuid = {
+            .eax = 0x24,
+            .needs_ecx = true, .ecx = 0,
+            .reg = R_EBX,
+        },
+        .tcg_features = TCG_24_0_EBX_FEATURES,
+    },
+    [FEAT_8000_0007_EDX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            "invtsc", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = { .eax = 0x80000007, .reg = R_EDX, },
+        .tcg_features = TCG_APM_FEATURES,
+        .unmigratable_flags = CPUID_APM_INVTSC,
+    },
+    [FEAT_8000_0007_EBX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "overflow-recov", "succor", NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = { .eax = 0x80000007, .reg = R_EBX, },
+        .tcg_features = 0,
+        .unmigratable_flags = 0,
+    },
+    [FEAT_8000_0008_EBX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "clzero", NULL, "xsaveerptr", NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, "wbnoinvd", NULL, NULL,
+            "ibpb", NULL, "ibrs", "amd-stibp",
+            NULL, "stibp-always-on", NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            "amd-ssbd", "virt-ssbd", "amd-no-ssb", NULL,
+            "amd-psfd", NULL, NULL, NULL,
+        },
+        .cpuid = { .eax = 0x80000008, .reg = R_EBX, },
+        .tcg_features = TCG_8000_0008_EBX,
+        .unmigratable_flags = 0,
+    },
+    [FEAT_8000_0021_EAX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "no-nested-data-bp", NULL, "lfence-always-serializing", NULL,
+            NULL, NULL, "null-sel-clr-base", NULL,
+            "auto-ibrs", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            "eraps", NULL, NULL, "sbpb",
+            "ibpb-brtype", "srso-no", "srso-user-kernel-no", NULL,
+        },
+        .cpuid = { .eax = 0x80000021, .reg = R_EAX, },
+        .tcg_features = 0,
+        .unmigratable_flags = 0,
+    },
+    [FEAT_8000_0021_EBX] = {
+        .type = CPUID_FEATURE_WORD,
+        .cpuid = { .eax = 0x80000021, .reg = R_EBX, },
+        .tcg_features = 0,
+        .unmigratable_flags = 0,
+    },
+    [FEAT_8000_0022_EAX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "perfmon-v2", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = { .eax = 0x80000022, .reg = R_EAX, },
+        .tcg_features = 0,
+        .unmigratable_flags = 0,
+    },
+    [FEAT_XSAVE] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "xsaveopt", "xsavec", "xgetbv1", "xsaves",
+            "xfd", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = {
+            .eax = 0xd,
+            .needs_ecx = true, .ecx = 1,
+            .reg = R_EAX,
+        },
+        .tcg_features = TCG_XSAVE_FEATURES,
+    },
+    [FEAT_XSAVE_XSS_LO] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = {
+            .eax = 0xD,
+            .needs_ecx = true,
+            .ecx = 1,
+            .reg = R_ECX,
+        },
+    },
+    [FEAT_XSAVE_XSS_HI] = {
+        .type = CPUID_FEATURE_WORD,
+        .cpuid = {
+            .eax = 0xD,
+            .needs_ecx = true,
+            .ecx = 1,
+            .reg = R_EDX
+        },
+    },
+    [FEAT_6_EAX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, "arat", NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = { .eax = 6, .reg = R_EAX, },
+        .tcg_features = TCG_6_EAX_FEATURES,
+    },
+    [FEAT_XSAVE_XCR0_LO] = {
+        .type = CPUID_FEATURE_WORD,
+        .cpuid = {
+            .eax = 0xD,
+            .needs_ecx = true, .ecx = 0,
+            .reg = R_EAX,
+        },
+        .tcg_features = XSTATE_FP_MASK | XSTATE_SSE_MASK |
+            XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
+            XSTATE_PKRU_MASK,
+        .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
+            XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
+            XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
+            XSTATE_PKRU_MASK,
+    },
+    [FEAT_XSAVE_XCR0_HI] = {
+        .type = CPUID_FEATURE_WORD,
+        .cpuid = {
+            .eax = 0xD,
+            .needs_ecx = true, .ecx = 0,
+            .reg = R_EDX,
+        },
+        .tcg_features = 0U,
+    },
+    /*Below are MSR exposed features*/
+    [FEAT_ARCH_CAPABILITIES] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            "rdctl-no", "ibrs-all", "rsba", "skip-l1dfl-vmentry",
+            "ssb-no", "mds-no", "pschange-mc-no", "tsx-ctrl",
+            "taa-no", NULL, NULL, NULL,
+            NULL, "sbdr-ssdp-no", "fbsdp-no", "psdp-no",
+            NULL, "fb-clear", NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            "pbrsb-no", NULL, "gds-no", "rfds-no",
+            "rfds-clear", NULL, NULL, NULL,
+        },
+        .msr = {
+            .index = MSR_IA32_ARCH_CAPABILITIES,
+        },
+        /*
+         * FEAT_ARCH_CAPABILITIES only affects a read-only MSR, which
+         * cannot be read from user mode.  Therefore, it has no impact
+         > on any user-mode operation, and warnings about unsupported
+         * features do not matter.
+         */
+        .tcg_features = ~0U,
+    },
+    [FEAT_CORE_CAPABILITY] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, NULL, NULL,
+            NULL, "split-lock-detect", NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .msr = {
+            .index = MSR_IA32_CORE_CAPABILITY,
+        },
+    },
+    [FEAT_PERF_CAPABILITIES] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, "full-width-write", NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .msr = {
+            .index = MSR_IA32_PERF_CAPABILITIES,
+        },
+    },
+
+    [FEAT_VMX_PROCBASED_CTLS] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, "vmx-vintr-pending", "vmx-tsc-offset",
+            NULL, NULL, NULL, "vmx-hlt-exit",
+            NULL, "vmx-invlpg-exit", "vmx-mwait-exit", "vmx-rdpmc-exit",
+            "vmx-rdtsc-exit", NULL, NULL, "vmx-cr3-load-noexit",
+            "vmx-cr3-store-noexit", NULL, NULL, "vmx-cr8-load-exit",
+            "vmx-cr8-store-exit", "vmx-flexpriority", "vmx-vnmi-pending", "vmx-movdr-exit",
+            "vmx-io-exit", "vmx-io-bitmap", NULL, "vmx-mtf",
+            "vmx-msr-bitmap", "vmx-monitor-exit", "vmx-pause-exit", "vmx-secondary-ctls",
+        },
+        .msr = {
+            .index = MSR_IA32_VMX_TRUE_PROCBASED_CTLS,
+        }
+    },
+
+    [FEAT_VMX_SECONDARY_CTLS] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            "vmx-apicv-xapic", "vmx-ept", "vmx-desc-exit", "vmx-rdtscp-exit",
+            "vmx-apicv-x2apic", "vmx-vpid", "vmx-wbinvd-exit", "vmx-unrestricted-guest",
+            "vmx-apicv-register", "vmx-apicv-vid", "vmx-ple", "vmx-rdrand-exit",
+            "vmx-invpcid-exit", "vmx-vmfunc", "vmx-shadow-vmcs", "vmx-encls-exit",
+            "vmx-rdseed-exit", "vmx-pml", NULL, NULL,
+            "vmx-xsaves", NULL, NULL, NULL,
+            NULL, "vmx-tsc-scaling", "vmx-enable-user-wait-pause", NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .msr = {
+            .index = MSR_IA32_VMX_PROCBASED_CTLS2,
+        }
+    },
+
+    [FEAT_VMX_PINBASED_CTLS] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            "vmx-intr-exit", NULL, NULL, "vmx-nmi-exit",
+            NULL, "vmx-vnmi", "vmx-preemption-timer", "vmx-posted-intr",
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .msr = {
+            .index = MSR_IA32_VMX_TRUE_PINBASED_CTLS,
+        }
+    },
+
+    [FEAT_VMX_EXIT_CTLS] = {
+        .type = MSR_FEATURE_WORD,
+        /*
+         * VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE is copied from
+         * the LM CPUID bit.
+         */
+        .feat_names = {
+            NULL, NULL, "vmx-exit-nosave-debugctl", NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL /* vmx-exit-host-addr-space-size */, NULL, NULL,
+            "vmx-exit-load-perf-global-ctrl", NULL, NULL, "vmx-exit-ack-intr",
+            NULL, NULL, "vmx-exit-save-pat", "vmx-exit-load-pat",
+            "vmx-exit-save-efer", "vmx-exit-load-efer",
+                "vmx-exit-save-preemption-timer", "vmx-exit-clear-bndcfgs",
+            NULL, "vmx-exit-clear-rtit-ctl", NULL, NULL,
+            NULL, "vmx-exit-load-pkrs", NULL, "vmx-exit-secondary-ctls",
+        },
+        .msr = {
+            .index = MSR_IA32_VMX_TRUE_EXIT_CTLS,
+        }
+    },
+
+    [FEAT_VMX_ENTRY_CTLS] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, "vmx-entry-noload-debugctl", NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, "vmx-entry-ia32e-mode", NULL, NULL,
+            NULL, "vmx-entry-load-perf-global-ctrl", "vmx-entry-load-pat", "vmx-entry-load-efer",
+            "vmx-entry-load-bndcfgs", NULL, "vmx-entry-load-rtit-ctl", NULL,
+            NULL, NULL, "vmx-entry-load-pkrs", "vmx-entry-load-fred",
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .msr = {
+            .index = MSR_IA32_VMX_TRUE_ENTRY_CTLS,
+        }
+    },
+
+    [FEAT_VMX_MISC] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, NULL, NULL,
+            NULL, "vmx-store-lma", "vmx-activity-hlt", "vmx-activity-shutdown",
+            "vmx-activity-wait-sipi", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, "vmx-vmwrite-vmexit-fields", "vmx-zero-len-inject", NULL,
+        },
+        .msr = {
+            .index = MSR_IA32_VMX_MISC,
+        }
+    },
+
+    [FEAT_VMX_EPT_VPID_CAPS] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            "vmx-ept-execonly", NULL, NULL, NULL,
+            NULL, NULL, "vmx-page-walk-4", "vmx-page-walk-5",
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            "vmx-ept-2mb", "vmx-ept-1gb", NULL, NULL,
+            "vmx-invept", "vmx-eptad", "vmx-ept-advanced-exitinfo", NULL,
+            NULL, "vmx-invept-single-context", "vmx-invept-all-context", NULL,
+            NULL, NULL, NULL, NULL,
+            "vmx-invvpid", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            "vmx-invvpid-single-addr", "vmx-invept-single-context",
+                "vmx-invvpid-all-context", "vmx-invept-single-context-noglobals",
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .msr = {
+            .index = MSR_IA32_VMX_EPT_VPID_CAP,
+        }
+    },
+
+    [FEAT_VMX_BASIC] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            [54] = "vmx-ins-outs",
+            [55] = "vmx-true-ctls",
+            [56] = "vmx-any-errcode",
+            [58] = "vmx-nested-exception",
+        },
+        .msr = {
+            .index = MSR_IA32_VMX_BASIC,
+        },
+        /* Just to be safe - we don't support setting the MSEG version field.  */
+        .no_autoenable_flags = MSR_VMX_BASIC_DUAL_MONITOR,
+    },
+
+    [FEAT_VMX_VMFUNC] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            [0] = "vmx-eptp-switching",
+        },
+        .msr = {
+            .index = MSR_IA32_VMX_VMFUNC,
+        }
+    },
+
+    [FEAT_14_0_ECX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, "intel-pt-lip",
+        },
+        .cpuid = {
+            .eax = 0x14,
+            .needs_ecx = true, .ecx = 0,
+            .reg = R_ECX,
+        },
+        .tcg_features = TCG_14_0_ECX_FEATURES,
+     },
+
+    [FEAT_SGX_12_0_EAX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "sgx1", "sgx2", NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, "sgx-edeccssa",
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = {
+            .eax = 0x12,
+            .needs_ecx = true, .ecx = 0,
+            .reg = R_EAX,
+        },
+        .tcg_features = TCG_SGX_12_0_EAX_FEATURES,
+    },
+
+    [FEAT_SGX_12_0_EBX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "sgx-exinfo" , NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = {
+            .eax = 0x12,
+            .needs_ecx = true, .ecx = 0,
+            .reg = R_EBX,
+        },
+        .tcg_features = TCG_SGX_12_0_EBX_FEATURES,
+    },
+
+    [FEAT_SGX_12_1_EAX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL, "sgx-debug", "sgx-mode64", NULL,
+            "sgx-provisionkey", "sgx-tokenkey", NULL, "sgx-kss",
+            NULL, NULL, "sgx-aex-notify", NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = {
+            .eax = 0x12,
+            .needs_ecx = true, .ecx = 1,
+            .reg = R_EAX,
+        },
+        .tcg_features = TCG_SGX_12_1_EAX_FEATURES,
+    },
+};
+
+typedef struct FeatureMask {
+    FeatureWord index;
+    uint64_t mask;
+} FeatureMask;
+
+typedef struct FeatureDep {
+    FeatureMask from, to;
+} FeatureDep;
+
+static FeatureDep feature_dependencies[] = {
+    {
+        .from = { FEAT_7_0_EDX,             CPUID_7_0_EDX_ARCH_CAPABILITIES },
+        .to = { FEAT_ARCH_CAPABILITIES,     ~0ull },
+    },
+    {
+        .from = { FEAT_7_0_EDX,             CPUID_7_0_EDX_CORE_CAPABILITY },
+        .to = { FEAT_CORE_CAPABILITY,       ~0ull },
+    },
+    {
+        .from = { FEAT_1_ECX,             CPUID_EXT_PDCM },
+        .to = { FEAT_PERF_CAPABILITIES,       ~0ull },
+    },
+    {
+        .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
+        .to = { FEAT_VMX_PROCBASED_CTLS,    ~0ull },
+    },
+    {
+        .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
+        .to = { FEAT_VMX_PINBASED_CTLS,     ~0ull },
+    },
+    {
+        .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
+        .to = { FEAT_VMX_EXIT_CTLS,         ~0ull },
+    },
+    {
+        .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
+        .to = { FEAT_VMX_ENTRY_CTLS,        ~0ull },
+    },
+    {
+        .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
+        .to = { FEAT_VMX_MISC,              ~0ull },
+    },
+    {
+        .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
+        .to = { FEAT_VMX_BASIC,             ~0ull },
+    },
+    {
+        .from = { FEAT_8000_0001_EDX,       CPUID_EXT2_LM },
+        .to = { FEAT_VMX_ENTRY_CTLS,        VMX_VM_ENTRY_IA32E_MODE },
+    },
+    {
+        .from = { FEAT_VMX_PROCBASED_CTLS,  VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS },
+        .to = { FEAT_VMX_SECONDARY_CTLS,    ~0ull },
+    },
+    {
+        .from = { FEAT_XSAVE,               CPUID_XSAVE_XSAVES },
+        .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_XSAVES },
+    },
+    {
+        .from = { FEAT_1_ECX,               CPUID_EXT_RDRAND },
+        .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_RDRAND_EXITING },
+    },
+    {
+        .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_INVPCID },
+        .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_ENABLE_INVPCID },
+    },
+    {
+        .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_MPX },
+        .to = { FEAT_VMX_EXIT_CTLS,         VMX_VM_EXIT_CLEAR_BNDCFGS },
+    },
+    {
+        .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_MPX },
+        .to = { FEAT_VMX_ENTRY_CTLS,        VMX_VM_ENTRY_LOAD_BNDCFGS },
+    },
+    {
+        .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_RDSEED },
+        .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_RDSEED_EXITING },
+    },
+    {
+        .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_INTEL_PT },
+        .to = { FEAT_14_0_ECX,              ~0ull },
+    },
+    {
+        .from = { FEAT_8000_0001_EDX,       CPUID_EXT2_RDTSCP },
+        .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_RDTSCP },
+    },
+    {
+        .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_EPT },
+        .to = { FEAT_VMX_EPT_VPID_CAPS,     0xffffffffull },
+    },
+    {
+        .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_EPT },
+        .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST },
+    },
+    {
+        .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_VPID },
+        .to = { FEAT_VMX_EPT_VPID_CAPS,     0xffffffffull << 32 },
+    },
+    {
+        .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_VMFUNC },
+        .to = { FEAT_VMX_VMFUNC,            ~0ull },
+    },
+    {
+        .from = { FEAT_8000_0001_ECX,       CPUID_EXT3_SVM },
+        .to = { FEAT_SVM,                   ~0ull },
+    },
+    {
+        .from = { FEAT_7_0_ECX,             CPUID_7_0_ECX_WAITPKG },
+        .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE },
+    },
+    {
+        .from = { FEAT_8000_0001_EDX,       CPUID_EXT2_LM },
+        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
+    },
+    {
+        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_LKGS },
+        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
+    },
+    {
+        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_WRMSRNS },
+        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
+    },
+    {
+        .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
+        .to = { FEAT_7_0_ECX,               CPUID_7_0_ECX_SGX_LC },
+    },
+    {
+        .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
+        .to = { FEAT_SGX_12_0_EAX,          ~0ull },
+    },
+    {
+        .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
+        .to = { FEAT_SGX_12_0_EBX,          ~0ull },
+    },
+    {
+        .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
+        .to = { FEAT_SGX_12_1_EAX,          ~0ull },
+    },
+    {
+        .from = { FEAT_24_0_EBX,            CPUID_24_0_EBX_AVX10_128 },
+        .to = { FEAT_24_0_EBX,              CPUID_24_0_EBX_AVX10_256 },
+    },
+    {
+        .from = { FEAT_24_0_EBX,            CPUID_24_0_EBX_AVX10_256 },
+        .to = { FEAT_24_0_EBX,              CPUID_24_0_EBX_AVX10_512 },
+    },
+    {
+        .from = { FEAT_24_0_EBX,            CPUID_24_0_EBX_AVX10_VL_MASK },
+        .to = { FEAT_7_1_EDX,               CPUID_7_1_EDX_AVX10 },
+    },
+    {
+        .from = { FEAT_7_1_EDX,             CPUID_7_1_EDX_AVX10 },
+        .to = { FEAT_24_0_EBX,              ~0ull },
+    },
+};
+
+typedef struct X86RegisterInfo32 {
+    /* Name of register */
+    const char *name;
+    /* QAPI enum value register */
+    X86CPURegister32 qapi_enum;
+} X86RegisterInfo32;
+
+#define REGISTER(reg) \
+    [R_##reg] = { .name = #reg, .qapi_enum = X86_CPU_REGISTER32_##reg }
+static const X86RegisterInfo32 x86_reg_info_32[CPU_NB_REGS32] = {
+    REGISTER(EAX),
+    REGISTER(ECX),
+    REGISTER(EDX),
+    REGISTER(EBX),
+    REGISTER(ESP),
+    REGISTER(EBP),
+    REGISTER(ESI),
+    REGISTER(EDI),
+};
+#undef REGISTER
+
+/* CPUID feature bits available in XSS */
+#define CPUID_XSTATE_XSS_MASK    (XSTATE_ARCH_LBR_MASK)
+
+ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
+    [XSTATE_FP_BIT] = {
+        /* x87 FP state component is always enabled if XSAVE is supported */
+        .feature = FEAT_1_ECX, .bits = CPUID_EXT_XSAVE,
+        .size = sizeof(X86LegacyXSaveArea) + sizeof(X86XSaveHeader),
+    },
+    [XSTATE_SSE_BIT] = {
+        /* SSE state component is always enabled if XSAVE is supported */
+        .feature = FEAT_1_ECX, .bits = CPUID_EXT_XSAVE,
+        .size = sizeof(X86LegacyXSaveArea) + sizeof(X86XSaveHeader),
+    },
+    [XSTATE_YMM_BIT] =
+          { .feature = FEAT_1_ECX, .bits = CPUID_EXT_AVX,
+            .size = sizeof(XSaveAVX) },
+    [XSTATE_BNDREGS_BIT] =
+          { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_MPX,
+            .size = sizeof(XSaveBNDREG)  },
+    [XSTATE_BNDCSR_BIT] =
+          { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_MPX,
+            .size = sizeof(XSaveBNDCSR)  },
+    [XSTATE_OPMASK_BIT] =
+          { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
+            .size = sizeof(XSaveOpmask) },
+    [XSTATE_ZMM_Hi256_BIT] =
+          { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
+            .size = sizeof(XSaveZMM_Hi256) },
+    [XSTATE_Hi16_ZMM_BIT] =
+          { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
+            .size = sizeof(XSaveHi16_ZMM) },
+    [XSTATE_PKRU_BIT] =
+          { .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_PKU,
+            .size = sizeof(XSavePKRU) },
+    [XSTATE_ARCH_LBR_BIT] = {
+            .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_ARCH_LBR,
+            .offset = 0 /*supervisor mode component, offset = 0 */,
+            .size = sizeof(XSavesArchLBR) },
+    [XSTATE_XTILE_CFG_BIT] = {
+        .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_AMX_TILE,
+        .size = sizeof(XSaveXTILECFG),
+    },
+    [XSTATE_XTILE_DATA_BIT] = {
+        .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_AMX_TILE,
+        .size = sizeof(XSaveXTILEDATA)
+    },
+};
+
+uint32_t xsave_area_size(uint64_t mask, bool compacted)
+{
+    uint64_t ret = x86_ext_save_areas[0].size;
+    const ExtSaveArea *esa;
+    uint32_t offset = 0;
+    int i;
+
+    for (i = 2; i < ARRAY_SIZE(x86_ext_save_areas); i++) {
+        esa = &x86_ext_save_areas[i];
+        if ((mask >> i) & 1) {
+            offset = compacted ? ret : esa->offset;
+            ret = MAX(ret, offset + esa->size);
+        }
+    }
+    return ret;
+}
+
+static inline bool accel_uses_host_cpuid(void)
+{
+    return kvm_enabled() || hvf_enabled();
+}
+
+static inline uint64_t x86_cpu_xsave_xcr0_components(X86CPU *cpu)
+{
+    return ((uint64_t)cpu->env.features[FEAT_XSAVE_XCR0_HI]) << 32 |
+           cpu->env.features[FEAT_XSAVE_XCR0_LO];
+}
+
+/* Return name of 32-bit register, from a R_* constant */
+static const char *get_register_name_32(unsigned int reg)
+{
+    if (reg >= CPU_NB_REGS32) {
+        return NULL;
+    }
+    return x86_reg_info_32[reg].name;
+}
+
+static inline uint64_t x86_cpu_xsave_xss_components(X86CPU *cpu)
+{
+    return ((uint64_t)cpu->env.features[FEAT_XSAVE_XSS_HI]) << 32 |
+           cpu->env.features[FEAT_XSAVE_XSS_LO];
+}
+
+/*
+ * Returns the set of feature flags that are supported and migratable by
+ * QEMU, for a given FeatureWord.
+ */
+static uint64_t x86_cpu_get_migratable_flags(X86CPU *cpu, FeatureWord w)
+{
+    FeatureWordInfo *wi = &feature_word_info[w];
+    CPUX86State *env = &cpu->env;
+    uint64_t r = 0;
+    int i;
+
+    for (i = 0; i < 64; i++) {
+        uint64_t f = 1ULL << i;
+
+        /* If the feature name is known, it is implicitly considered migratable,
+         * unless it is explicitly set in unmigratable_flags */
+        if ((wi->migratable_flags & f) ||
+            (wi->feat_names[i] && !(wi->unmigratable_flags & f))) {
+            r |= f;
+        }
+    }
+
+    /* when tsc-khz is set explicitly, invtsc is migratable */
+    if ((w == FEAT_8000_0007_EDX) && env->user_tsc_khz) {
+        r |= CPUID_APM_INVTSC;
+    }
+
+    return r;
+}
+
+void host_cpuid(uint32_t function, uint32_t count,
+                uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx)
+{
+    uint32_t vec[4];
+
+#ifdef __x86_64__
+    asm volatile("cpuid"
+                 : "=a"(vec[0]), "=b"(vec[1]),
+                   "=c"(vec[2]), "=d"(vec[3])
+                 : "0"(function), "c"(count) : "cc");
+#elif defined(__i386__)
+    asm volatile("pusha \n\t"
+                 "cpuid \n\t"
+                 "mov %%eax, 0(%2) \n\t"
+                 "mov %%ebx, 4(%2) \n\t"
+                 "mov %%ecx, 8(%2) \n\t"
+                 "mov %%edx, 12(%2) \n\t"
+                 "popa"
+                 : : "a"(function), "c"(count), "S"(vec)
+                 : "memory", "cc");
+#else
+    abort();
+#endif
+
+    if (eax)
+        *eax = vec[0];
+    if (ebx)
+        *ebx = vec[1];
+    if (ecx)
+        *ecx = vec[2];
+    if (edx)
+        *edx = vec[3];
+}
+
+/* CPU class name definitions: */
+
+/* Return type name for a given CPU model name
+ * Caller is responsible for freeing the returned string.
+ */
+static char *x86_cpu_type_name(const char *model_name)
+{
+    return g_strdup_printf(X86_CPU_TYPE_NAME("%s"), model_name);
+}
+
+static ObjectClass *x86_cpu_class_by_name(const char *cpu_model)
+{
+    g_autofree char *typename = x86_cpu_type_name(cpu_model);
+    return object_class_by_name(typename);
+}
+
+static char *x86_cpu_class_get_model_name(X86CPUClass *cc)
+{
+    const char *class_name = object_class_get_name(OBJECT_CLASS(cc));
+    assert(g_str_has_suffix(class_name, X86_CPU_TYPE_SUFFIX));
+    return cpu_model_from_type(class_name);
+}
+
+typedef struct X86CPUVersionDefinition {
+    X86CPUVersion version;
+    const char *alias;
+    const char *note;
+    PropValue *props;
+    const CPUCaches *const cache_info;
+} X86CPUVersionDefinition;
+
+/* Base definition for a CPU model */
+typedef struct X86CPUDefinition {
+    const char *name;
+    uint32_t level;
+    uint32_t xlevel;
+    /* vendor is zero-terminated, 12 character ASCII string */
+    char vendor[CPUID_VENDOR_SZ + 1];
+    int family;
+    int model;
+    int stepping;
+    uint8_t avx10_version;
+    FeatureWordArray features;
+    const char *model_id;
+    const CPUCaches *const cache_info;
+    /*
+     * Definitions for alternative versions of CPU model.
+     * List is terminated by item with version == 0.
+     * If NULL, version 1 will be registered automatically.
+     */
+    const X86CPUVersionDefinition *versions;
+    const char *deprecation_note;
+} X86CPUDefinition;
+
+/* Reference to a specific CPU model version */
+struct X86CPUModel {
+    /* Base CPU definition */
+    const X86CPUDefinition *cpudef;
+    /* CPU model version */
+    X86CPUVersion version;
+    const char *note;
+    /*
+     * If true, this is an alias CPU model.
+     * This matters only for "-cpu help" and query-cpu-definitions
+     */
+    bool is_alias;
+};
+
+/* Get full model name for CPU version */
+static char *x86_cpu_versioned_model_name(const X86CPUDefinition *cpudef,
+                                          X86CPUVersion version)
+{
+    assert(version > 0);
+    return g_strdup_printf("%s-v%d", cpudef->name, (int)version);
+}
+
+static const X86CPUVersionDefinition *
+x86_cpu_def_get_versions(const X86CPUDefinition *def)
+{
+    /* When X86CPUDefinition::versions is NULL, we register only v1 */
+    static const X86CPUVersionDefinition default_version_list[] = {
+        { 1 },
+        { /* end of list */ }
+    };
+
+    return def->versions ?: default_version_list;
+}
+
+static const CPUCaches epyc_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 64 * KiB,
+        .line_size = 64,
+        .associativity = 4,
+        .partitions = 1,
+        .sets = 256,
+        .lines_per_tag = 1,
+        .self_init = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 512 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 1024,
+        .lines_per_tag = 1,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .size = 8 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 8192,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .inclusive = true,
+        .complex_indexing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
+static CPUCaches epyc_v4_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 64 * KiB,
+        .line_size = 64,
+        .associativity = 4,
+        .partitions = 1,
+        .sets = 256,
+        .lines_per_tag = 1,
+        .self_init = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 512 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 1024,
+        .lines_per_tag = 1,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .size = 8 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 8192,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .inclusive = true,
+        .complex_indexing = false,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
+static const CPUCaches epyc_rome_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 512 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 1024,
+        .lines_per_tag = 1,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .size = 16 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 16384,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .inclusive = true,
+        .complex_indexing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
+static const CPUCaches epyc_rome_v3_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 512 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 1024,
+        .lines_per_tag = 1,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .size = 16 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 16384,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .inclusive = true,
+        .complex_indexing = false,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
+static const CPUCaches epyc_milan_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 512 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 1024,
+        .lines_per_tag = 1,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .size = 32 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 32768,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .inclusive = true,
+        .complex_indexing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
+static const CPUCaches epyc_milan_v2_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 512 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 1024,
+        .lines_per_tag = 1,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .size = 32 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 32768,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .inclusive = true,
+        .complex_indexing = false,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
+static const CPUCaches epyc_genoa_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 1 * MiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 2048,
+        .lines_per_tag = 1,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .size = 32 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 32768,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .inclusive = true,
+        .complex_indexing = false,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
+/* The following VMX features are not supported by KVM and are left out in the
+ * CPU definitions:
+ *
+ *  Dual-monitor support (all processors)
+ *  Entry to SMM
+ *  Deactivate dual-monitor treatment
+ *  Number of CR3-target values
+ *  Shutdown activity state
+ *  Wait-for-SIPI activity state
+ *  PAUSE-loop exiting (Westmere and newer)
+ *  EPT-violation #VE (Broadwell and newer)
+ *  Inject event with insn length=0 (Skylake and newer)
+ *  Conceal non-root operation from PT
+ *  Conceal VM exits from PT
+ *  Conceal VM entries from PT
+ *  Enable ENCLS exiting
+ *  Mode-based execute control (XS/XU)
+ *  TSC scaling (Skylake Server and newer)
+ *  GPA translation for PT (IceLake and newer)
+ *  User wait and pause
+ *  ENCLV exiting
+ *  Load IA32_RTIT_CTL
+ *  Clear IA32_RTIT_CTL
+ *  Advanced VM-exit information for EPT violations
+ *  Sub-page write permissions
+ *  PT in VMX operation
+ */
+
+static const X86CPUDefinition builtin_x86_defs[] = {
+    {
+        .name = "qemu64",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_AMD,
+        .family = 15,
+        .model = 107,
+        .stepping = 1,
+        .features[FEAT_1_EDX] =
+            PPRO_FEATURES |
+            CPUID_MTRR | CPUID_CLFLUSH | CPUID_MCA |
+            CPUID_PSE36,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSE3 | CPUID_EXT_CX16,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_SYSCALL | CPUID_EXT2_NX,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_LAHF_LM | CPUID_EXT3_SVM,
+        .xlevel = 0x8000000A,
+        .model_id = "QEMU Virtual CPU version " QEMU_HW_VERSION,
+    },
+    {
+        .name = "phenom",
+        .level = 5,
+        .vendor = CPUID_VENDOR_AMD,
+        .family = 16,
+        .model = 2,
+        .stepping = 3,
+        /* Missing: CPUID_HT */
+        .features[FEAT_1_EDX] =
+            PPRO_FEATURES |
+            CPUID_MTRR | CPUID_CLFLUSH | CPUID_MCA |
+            CPUID_PSE36 | CPUID_VME,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSE3 | CPUID_EXT_MONITOR | CPUID_EXT_CX16 |
+            CPUID_EXT_POPCNT,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_SYSCALL | CPUID_EXT2_NX |
+            CPUID_EXT2_3DNOW | CPUID_EXT2_3DNOWEXT | CPUID_EXT2_MMXEXT |
+            CPUID_EXT2_FFXSR | CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP,
+        /* Missing: CPUID_EXT3_CMP_LEG, CPUID_EXT3_EXTAPIC,
+                    CPUID_EXT3_CR8LEG,
+                    CPUID_EXT3_MISALIGNSSE, CPUID_EXT3_3DNOWPREFETCH,
+                    CPUID_EXT3_OSVW, CPUID_EXT3_IBS */
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_LAHF_LM | CPUID_EXT3_SVM |
+            CPUID_EXT3_ABM | CPUID_EXT3_SSE4A,
+        /* Missing: CPUID_SVM_LBRV */
+        .features[FEAT_SVM] =
+            CPUID_SVM_NPT,
+        .xlevel = 0x8000001A,
+        .model_id = "AMD Phenom(tm) 9550 Quad-Core Processor"
+    },
+    {
+        .name = "core2duo",
+        .level = 10,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 15,
+        .stepping = 11,
+        /* Missing: CPUID_DTS, CPUID_HT, CPUID_TM, CPUID_PBE */
+        .features[FEAT_1_EDX] =
+            PPRO_FEATURES |
+            CPUID_MTRR | CPUID_CLFLUSH | CPUID_MCA |
+            CPUID_PSE36 | CPUID_VME | CPUID_ACPI | CPUID_SS,
+        /* Missing: CPUID_EXT_DTES64, CPUID_EXT_DSCPL, CPUID_EXT_EST,
+         * CPUID_EXT_TM2, CPUID_EXT_XTPR, CPUID_EXT_PDCM, CPUID_EXT_VMX */
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSE3 | CPUID_EXT_MONITOR | CPUID_EXT_SSSE3 |
+            CPUID_EXT_CX16,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_SYSCALL | CPUID_EXT2_NX,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_LAHF_LM,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_ACK_INTR_ON_EXIT,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES,
+        .xlevel = 0x80000008,
+        .model_id = "Intel(R) Core(TM)2 Duo CPU     T7700  @ 2.40GHz",
+    },
+    {
+        .name = "kvm64",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 15,
+        .model = 6,
+        .stepping = 1,
+        /* Missing: CPUID_HT */
+        .features[FEAT_1_EDX] =
+            PPRO_FEATURES | CPUID_VME |
+            CPUID_MTRR | CPUID_CLFLUSH | CPUID_MCA |
+            CPUID_PSE36,
+        /* Missing: CPUID_EXT_POPCNT, CPUID_EXT_MONITOR */
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSE3 | CPUID_EXT_CX16,
+        /* Missing: CPUID_EXT2_PDPE1GB, CPUID_EXT2_RDTSCP */
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_SYSCALL | CPUID_EXT2_NX,
+        /* Missing: CPUID_EXT3_LAHF_LM, CPUID_EXT3_CMP_LEG, CPUID_EXT3_EXTAPIC,
+                    CPUID_EXT3_CR8LEG, CPUID_EXT3_ABM, CPUID_EXT3_SSE4A,
+                    CPUID_EXT3_MISALIGNSSE, CPUID_EXT3_3DNOWPREFETCH,
+                    CPUID_EXT3_OSVW, CPUID_EXT3_IBS, CPUID_EXT3_SVM */
+        .features[FEAT_8000_0001_ECX] =
+            0,
+        /* VMX features from Cedar Mill/Prescott */
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_ACK_INTR_ON_EXIT,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING,
+        .xlevel = 0x80000008,
+        .model_id = "Common KVM processor"
+    },
+    {
+        .name = "qemu32",
+        .level = 4,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 6,
+        .stepping = 3,
+        .features[FEAT_1_EDX] =
+            PPRO_FEATURES,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSE3,
+        .xlevel = 0x80000004,
+        .model_id = "QEMU Virtual CPU version " QEMU_HW_VERSION,
+    },
+    {
+        .name = "kvm32",
+        .level = 5,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 15,
+        .model = 6,
+        .stepping = 1,
+        .features[FEAT_1_EDX] =
+            PPRO_FEATURES | CPUID_VME |
+            CPUID_MTRR | CPUID_CLFLUSH | CPUID_MCA | CPUID_PSE36,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_ECX] =
+            0,
+        /* VMX features from Yonah */
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_ACK_INTR_ON_EXIT,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_MOV_DR_EXITING | VMX_CPU_BASED_UNCOND_IO_EXITING |
+             VMX_CPU_BASED_USE_IO_BITMAPS | VMX_CPU_BASED_MONITOR_EXITING |
+             VMX_CPU_BASED_PAUSE_EXITING | VMX_CPU_BASED_USE_MSR_BITMAPS,
+        .xlevel = 0x80000008,
+        .model_id = "Common 32-bit KVM processor"
+    },
+    {
+        .name = "coreduo",
+        .level = 10,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 14,
+        .stepping = 8,
+        /* Missing: CPUID_DTS, CPUID_HT, CPUID_TM, CPUID_PBE */
+        .features[FEAT_1_EDX] =
+            PPRO_FEATURES | CPUID_VME |
+            CPUID_MTRR | CPUID_CLFLUSH | CPUID_MCA | CPUID_ACPI |
+            CPUID_SS,
+        /* Missing: CPUID_EXT_EST, CPUID_EXT_TM2 , CPUID_EXT_XTPR,
+         * CPUID_EXT_PDCM, CPUID_EXT_VMX */
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSE3 | CPUID_EXT_MONITOR,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_NX,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_ACK_INTR_ON_EXIT,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_MOV_DR_EXITING | VMX_CPU_BASED_UNCOND_IO_EXITING |
+             VMX_CPU_BASED_USE_IO_BITMAPS | VMX_CPU_BASED_MONITOR_EXITING |
+             VMX_CPU_BASED_PAUSE_EXITING | VMX_CPU_BASED_USE_MSR_BITMAPS,
+        .xlevel = 0x80000008,
+        .model_id = "Genuine Intel(R) CPU           T2600  @ 2.16GHz",
+    },
+    {
+        .name = "486",
+        .level = 1,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 4,
+        .model = 8,
+        .stepping = 0,
+        .features[FEAT_1_EDX] =
+            I486_FEATURES,
+        .xlevel = 0,
+        .model_id = "",
+    },
+    {
+        .name = "pentium",
+        .level = 1,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 5,
+        .model = 4,
+        .stepping = 3,
+        .features[FEAT_1_EDX] =
+            PENTIUM_FEATURES,
+        .xlevel = 0,
+        .model_id = "",
+    },
+    {
+        .name = "pentium2",
+        .level = 2,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 5,
+        .stepping = 2,
+        .features[FEAT_1_EDX] =
+            PENTIUM2_FEATURES,
+        .xlevel = 0,
+        .model_id = "",
+    },
+    {
+        .name = "pentium3",
+        .level = 3,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 7,
+        .stepping = 3,
+        .features[FEAT_1_EDX] =
+            PENTIUM3_FEATURES,
+        .xlevel = 0,
+        .model_id = "",
+    },
+    {
+        .name = "athlon",
+        .level = 2,
+        .vendor = CPUID_VENDOR_AMD,
+        .family = 6,
+        .model = 2,
+        .stepping = 3,
+        .features[FEAT_1_EDX] =
+            PPRO_FEATURES | CPUID_PSE36 | CPUID_VME | CPUID_MTRR |
+            CPUID_MCA,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_MMXEXT | CPUID_EXT2_3DNOW | CPUID_EXT2_3DNOWEXT,
+        .xlevel = 0x80000008,
+        .model_id = "QEMU Virtual CPU version " QEMU_HW_VERSION,
+    },
+    {
+        .name = "n270",
+        .level = 10,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 28,
+        .stepping = 2,
+        /* Missing: CPUID_DTS, CPUID_HT, CPUID_TM, CPUID_PBE */
+        .features[FEAT_1_EDX] =
+            PPRO_FEATURES |
+            CPUID_MTRR | CPUID_CLFLUSH | CPUID_MCA | CPUID_VME |
+            CPUID_ACPI | CPUID_SS,
+            /* Some CPUs got no CPUID_SEP */
+        /* Missing: CPUID_EXT_DSCPL, CPUID_EXT_EST, CPUID_EXT_TM2,
+         * CPUID_EXT_XTPR */
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSE3 | CPUID_EXT_MONITOR | CPUID_EXT_SSSE3 |
+            CPUID_EXT_MOVBE,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_NX,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_LAHF_LM,
+        .xlevel = 0x80000008,
+        .model_id = "Intel(R) Atom(TM) CPU N270   @ 1.60GHz",
+    },
+    {
+        .name = "Conroe",
+        .level = 10,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 15,
+        .stepping = 3,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSSE3 | CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_LAHF_LM,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_ACK_INTR_ON_EXIT,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Celeron_4x0 (Conroe/Merom Class Core 2)",
+    },
+    {
+        .name = "Penryn",
+        .level = 10,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 23,
+        .stepping = 3,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
+            CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_LAHF_LM,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_ACK_INTR_ON_EXIT |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Core 2 Duo P9xxx (Penryn Class Core 2)",
+    },
+    {
+        .name = "Nehalem",
+        .level = 11,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 26,
+        .stepping = 3,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_POPCNT | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
+            CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_SYSCALL | CPUID_EXT2_NX,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_LAHF_LM,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Core i7 9xx (Nehalem Class Core i7)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .alias = "Nehalem-IBRS",
+                .props = (PropValue[]) {
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Intel Core i7 9xx (Nehalem Core i7, IBRS update)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
+    },
+    {
+        .name = "Westmere",
+        .level = 11,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 44,
+        .stepping = 1,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_AES | CPUID_EXT_POPCNT | CPUID_EXT_SSE42 |
+            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
+            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_SYSCALL | CPUID_EXT2_NX,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_LAHF_LM,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST,
+        .xlevel = 0x80000008,
+        .model_id = "Westmere E56xx/L56xx/X56xx (Nehalem-C)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .alias = "Westmere-IBRS",
+                .props = (PropValue[]) {
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Westmere E56xx/L56xx/X56xx (IBRS update)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
+    },
+    {
+        .name = "SandyBridge",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 42,
+        .stepping = 1,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
+            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_POPCNT |
+            CPUID_EXT_X2APIC | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
+            CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ |
+            CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_LAHF_LM,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Xeon E312xx (Sandy Bridge)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .alias = "SandyBridge-IBRS",
+                .props = (PropValue[]) {
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Intel Xeon E312xx (Sandy Bridge, IBRS update)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
+    },
+    {
+        .name = "IvyBridge",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 58,
+        .stepping = 9,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
+            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_POPCNT |
+            CPUID_EXT_X2APIC | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
+            CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ |
+            CPUID_EXT_SSE3 | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_SMEP |
+            CPUID_7_0_EBX_ERMS,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_LAHF_LM,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Xeon E3-12xx v2 (Ivy Bridge)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .alias = "IvyBridge-IBRS",
+                .props = (PropValue[]) {
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Intel Xeon E3-12xx v2 (Ivy Bridge, IBRS)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
+    },
+    {
+        .name = "Haswell",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 60,
+        .stepping = 4,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
+            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
+            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
+            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
+            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
+            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
+            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
+            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
+            CPUID_7_0_EBX_RTM,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Core Processor (Haswell)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .alias = "Haswell-noTSX",
+                .props = (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    { "stepping", "1" },
+                    { "model-id", "Intel Core Processor (Haswell, no TSX)", },
+                    { /* end of list */ }
+                },
+            },
+            {
+                .version = 3,
+                .alias = "Haswell-IBRS",
+                .props = (PropValue[]) {
+                    /* Restore TSX features removed by -v2 above */
+                    { "hle", "on" },
+                    { "rtm", "on" },
+                    /*
+                     * Haswell and Haswell-IBRS had stepping=4 in
+                     * QEMU 4.0 and older
+                     */
+                    { "stepping", "4" },
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Intel Core Processor (Haswell, IBRS)" },
+                    { /* end of list */ }
+                }
+            },
+            {
+                .version = 4,
+                .alias = "Haswell-noTSX-IBRS",
+                .props = (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    /* spec-ctrl was already enabled by -v3 above */
+                    { "stepping", "1" },
+                    { "model-id",
+                      "Intel Core Processor (Haswell, no TSX, IBRS)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
+    },
+    {
+        .name = "Broadwell",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 61,
+        .stepping = 2,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
+            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
+            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
+            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
+            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
+            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
+            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
+            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
+            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
+            CPUID_7_0_EBX_SMAP,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+             VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Core Processor (Broadwell)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .alias = "Broadwell-noTSX",
+                .props = (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    { "model-id", "Intel Core Processor (Broadwell, no TSX)", },
+                    { /* end of list */ }
+                },
+            },
+            {
+                .version = 3,
+                .alias = "Broadwell-IBRS",
+                .props = (PropValue[]) {
+                    /* Restore TSX features removed by -v2 above */
+                    { "hle", "on" },
+                    { "rtm", "on" },
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Intel Core Processor (Broadwell, IBRS)" },
+                    { /* end of list */ }
+                }
+            },
+            {
+                .version = 4,
+                .alias = "Broadwell-noTSX-IBRS",
+                .props = (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    /* spec-ctrl was already enabled by -v3 above */
+                    { "model-id",
+                      "Intel Core Processor (Broadwell, no TSX, IBRS)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
+    },
+    {
+        .name = "Skylake-Client",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 94,
+        .stepping = 3,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
+            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
+            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
+            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
+            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
+            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
+            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
+            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
+            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
+            CPUID_7_0_EBX_SMAP,
+        /* XSAVES is added in version 4 */
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        /* Missing: Mode-based execute control (XS/XU), processor tracing, TSC scaling */
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+             VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Core Processor (Skylake)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .alias = "Skylake-Client-IBRS",
+                .props = (PropValue[]) {
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Intel Core Processor (Skylake, IBRS)" },
+                    { /* end of list */ }
+                }
+            },
+            {
+                .version = 3,
+                .alias = "Skylake-Client-noTSX-IBRS",
+                .props = (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    { "model-id",
+                      "Intel Core Processor (Skylake, IBRS, no TSX)" },
+                    { /* end of list */ }
+                }
+            },
+            {
+                .version = 4,
+                .note = "IBRS, XSAVES, no TSX",
+                .props = (PropValue[]) {
+                    { "xsaves", "on" },
+                    { "vmx-xsaves", "on" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
+    },
+    {
+        .name = "ShiJiDaDao",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_VIA,
+        .family = 7,
+        .model = 107,
+        .stepping = 1,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
+            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
+            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
+            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 | CPUID_EXT_FMA |
+            CPUID_EXT_MOVBE | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
+            CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
+        .xlevel = 0x80000008,
+        .model_id = "ZHAOXIN KaiXian KX-7000 (ShiJiDaDao)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            { /* end of list */ }
+        }
+    },
+    {
+        .name = "Skylake-Server",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 85,
+        .stepping = 4,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
+            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
+            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
+            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
+            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
+            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP |
+            CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
+            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
+            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
+            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
+            CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
+            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
+            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_PKU,
+        /* XSAVES is added in version 5 */
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        /* Missing: Mode-based execute control (XS/XU), processor tracing, TSC scaling */
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+             VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Xeon Processor (Skylake)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .alias = "Skylake-Server-IBRS",
+                .props = (PropValue[]) {
+                    /* clflushopt was not added to Skylake-Server-IBRS */
+                    /* TODO: add -v3 including clflushopt */
+                    { "clflushopt", "off" },
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Intel Xeon Processor (Skylake, IBRS)" },
+                    { /* end of list */ }
+                }
+            },
+            {
+                .version = 3,
+                .alias = "Skylake-Server-noTSX-IBRS",
+                .props = (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    { "model-id",
+                      "Intel Xeon Processor (Skylake, IBRS, no TSX)" },
+                    { /* end of list */ }
+                }
+            },
+            {
+                .version = 4,
+                .props = (PropValue[]) {
+                    { "vmx-eptp-switching", "on" },
+                    { /* end of list */ }
+                }
+            },
+            {
+                .version = 5,
+                .note = "IBRS, XSAVES, EPT switching, no TSX",
+                .props = (PropValue[]) {
+                    { "xsaves", "on" },
+                    { "vmx-xsaves", "on" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
+    },
+    {
+        .name = "Cascadelake-Server",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 85,
+        .stepping = 6,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
+            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
+            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
+            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
+            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
+            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP |
+            CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
+            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
+            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
+            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
+            CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
+            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
+            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_PKU |
+            CPUID_7_0_ECX_AVX512VNNI,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
+        /* XSAVES is added in version 5 */
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        /* Missing: Mode-based execute control (XS/XU), processor tracing, TSC scaling */
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+             VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Xeon Processor (Cascadelake)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            { .version = 2,
+              .note = "ARCH_CAPABILITIES",
+              .props = (PropValue[]) {
+                  { "arch-capabilities", "on" },
+                  { "rdctl-no", "on" },
+                  { "ibrs-all", "on" },
+                  { "skip-l1dfl-vmentry", "on" },
+                  { "mds-no", "on" },
+                  { /* end of list */ }
+              },
+            },
+            { .version = 3,
+              .alias = "Cascadelake-Server-noTSX",
+              .note = "ARCH_CAPABILITIES, no TSX",
+              .props = (PropValue[]) {
+                  { "hle", "off" },
+                  { "rtm", "off" },
+                  { /* end of list */ }
+              },
+            },
+            { .version = 4,
+              .note = "ARCH_CAPABILITIES, no TSX",
+              .props = (PropValue[]) {
+                  { "vmx-eptp-switching", "on" },
+                  { /* end of list */ }
+              },
+            },
+            { .version = 5,
+              .note = "ARCH_CAPABILITIES, EPT switching, XSAVES, no TSX",
+              .props = (PropValue[]) {
+                  { "xsaves", "on" },
+                  { "vmx-xsaves", "on" },
+                  { /* end of list */ }
+              },
+            },
+            { /* end of list */ }
+        }
+    },
+    {
+        .name = "Cooperlake",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 85,
+        .stepping = 10,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
+            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
+            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
+            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
+            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
+            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP |
+            CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
+            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
+            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
+            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
+            CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
+            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
+            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_PKU |
+            CPUID_7_0_ECX_AVX512VNNI,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_STIBP |
+            CPUID_7_0_EDX_SPEC_CTRL_SSBD | CPUID_7_0_EDX_ARCH_CAPABILITIES,
+        .features[FEAT_ARCH_CAPABILITIES] =
+            MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_IBRS_ALL |
+            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO |
+            MSR_ARCH_CAP_PSCHANGE_MC_NO | MSR_ARCH_CAP_TAA_NO,
+        .features[FEAT_7_1_EAX] =
+            CPUID_7_1_EAX_AVX512_BF16,
+        /* XSAVES is added in version 2 */
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        /* Missing: Mode-based execute control (XS/XU), processor tracing, TSC scaling */
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+             VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Xeon Processor (Cooperlake)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            { .version = 2,
+              .note = "XSAVES",
+              .props = (PropValue[]) {
+                  { "xsaves", "on" },
+                  { "vmx-xsaves", "on" },
+                  { /* end of list */ }
+              },
+            },
+            { /* end of list */ }
+        }
+    },
+    {
+        .name = "Icelake-Server",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 134,
+        .stepping = 0,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
+            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
+            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
+            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
+            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
+            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP |
+            CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
+        .features[FEAT_8000_0008_EBX] =
+            CPUID_8000_0008_EBX_WBNOINVD,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
+            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
+            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
+            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
+            CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
+            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
+            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
+            CPUID_7_0_ECX_AVX512_VBMI2 | CPUID_7_0_ECX_GFNI |
+            CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
+            CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
+            CPUID_7_0_ECX_AVX512_VPOPCNTDQ | CPUID_7_0_ECX_LA57,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
+        /* XSAVES is added in version 5 */
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        /* Missing: Mode-based execute control (XS/XU), processor tracing, TSC scaling */
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Xeon Processor (Icelake)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .note = "no TSX",
+                .alias = "Icelake-Server-noTSX",
+                .props = (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    { /* end of list */ }
+                },
+            },
+            {
+                .version = 3,
+                .props = (PropValue[]) {
+                    { "arch-capabilities", "on" },
+                    { "rdctl-no", "on" },
+                    { "ibrs-all", "on" },
+                    { "skip-l1dfl-vmentry", "on" },
+                    { "mds-no", "on" },
+                    { "pschange-mc-no", "on" },
+                    { "taa-no", "on" },
+                    { /* end of list */ }
+                },
+            },
+            {
+                .version = 4,
+                .props = (PropValue[]) {
+                    { "sha-ni", "on" },
+                    { "avx512ifma", "on" },
+                    { "rdpid", "on" },
+                    { "fsrm", "on" },
+                    { "vmx-rdseed-exit", "on" },
+                    { "vmx-pml", "on" },
+                    { "vmx-eptp-switching", "on" },
+                    { "model", "106" },
+                    { /* end of list */ }
+                },
+            },
+            {
+                .version = 5,
+                .note = "XSAVES",
+                .props = (PropValue[]) {
+                    { "xsaves", "on" },
+                    { "vmx-xsaves", "on" },
+                    { /* end of list */ }
+                },
+            },
+            {
+                .version = 6,
+                .note = "5-level EPT",
+                .props = (PropValue[]) {
+                    { "vmx-page-walk-5", "on" },
+                    { /* end of list */ }
+                },
+            },
+            {
+                .version = 7,
+                .note = "TSX, taa-no",
+                .props = (PropValue[]) {
+                    /* Restore TSX features removed by -v2 above */
+                    { "hle", "on" },
+                    { "rtm", "on" },
+                    { /* end of list */ }
+                },
+            },
+            { /* end of list */ }
+        }
+    },
+    {
+        .name = "SapphireRapids",
+        .level = 0x20,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 143,
+        .stepping = 4,
+        /*
+         * please keep the ascending order so that we can have a clear view of
+         * bit position of each feature.
+         */
+        .features[FEAT_1_EDX] =
+            CPUID_FP87 | CPUID_VME | CPUID_DE | CPUID_PSE | CPUID_TSC |
+            CPUID_MSR | CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC |
+            CPUID_SEP | CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV |
+            CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH | CPUID_MMX | CPUID_FXSR |
+            CPUID_SSE | CPUID_SSE2,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3 |
+            CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID | CPUID_EXT_SSE41 |
+            CPUID_EXT_SSE42 | CPUID_EXT_X2APIC | CPUID_EXT_MOVBE |
+            CPUID_EXT_POPCNT | CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_AES |
+            CPUID_EXT_XSAVE | CPUID_EXT_AVX | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_SYSCALL | CPUID_EXT2_NX | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_RDTSCP | CPUID_EXT2_LM,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_LAHF_LM | CPUID_EXT3_ABM | CPUID_EXT3_3DNOWPREFETCH,
+        .features[FEAT_8000_0008_EBX] =
+            CPUID_8000_0008_EBX_WBNOINVD,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_HLE |
+            CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 |
+            CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID | CPUID_7_0_EBX_RTM |
+            CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
+            CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP |
+            CPUID_7_0_EBX_AVX512IFMA | CPUID_7_0_EBX_CLFLUSHOPT |
+            CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_AVX512CD | CPUID_7_0_EBX_SHA_NI |
+            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512VL,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
+            CPUID_7_0_ECX_AVX512_VBMI2 | CPUID_7_0_ECX_GFNI |
+            CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
+            CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
+            CPUID_7_0_ECX_AVX512_VPOPCNTDQ | CPUID_7_0_ECX_LA57 |
+            CPUID_7_0_ECX_RDPID | CPUID_7_0_ECX_BUS_LOCK_DETECT,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_FSRM | CPUID_7_0_EDX_SERIALIZE |
+            CPUID_7_0_EDX_TSX_LDTRK | CPUID_7_0_EDX_AMX_BF16 |
+            CPUID_7_0_EDX_AVX512_FP16 | CPUID_7_0_EDX_AMX_TILE |
+            CPUID_7_0_EDX_AMX_INT8 | CPUID_7_0_EDX_SPEC_CTRL |
+            CPUID_7_0_EDX_ARCH_CAPABILITIES | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
+        .features[FEAT_ARCH_CAPABILITIES] =
+            MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_IBRS_ALL |
+            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO |
+            MSR_ARCH_CAP_PSCHANGE_MC_NO | MSR_ARCH_CAP_TAA_NO,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES | CPUID_D_1_EAX_XFD,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_7_1_EAX] =
+            CPUID_7_1_EAX_AVX_VNNI | CPUID_7_1_EAX_AVX512_BF16 |
+            CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | CPUID_7_1_EAX_FSRC,
+        .features[FEAT_VMX_BASIC] =
+            MSR_VMX_BASIC_INS_OUTS | MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] =
+            VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_IA32E_MODE |
+            VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+            VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] =
+            MSR_VMX_EPT_EXECONLY |
+            MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_PAGE_WALK_LENGTH_5 |
+            MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB | MSR_VMX_EPT_1GB |
+            MSR_VMX_EPT_INVEPT | MSR_VMX_EPT_AD_BITS |
+            MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+            MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT |
+            MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+            VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+            VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+            VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
+            VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] =
+            MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_ACTIVITY_HLT |
+            MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] =
+            VMX_PIN_BASED_EXT_INTR_MASK | VMX_PIN_BASED_NMI_EXITING |
+            VMX_PIN_BASED_VIRTUAL_NMIS | VMX_PIN_BASED_VMX_PREEMPTION_TIMER |
+            VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] =
+            VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+            VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+            VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+            VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+            VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+            VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+            VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_VIRTUAL_NMI_PENDING |
+            VMX_CPU_BASED_MOV_DR_EXITING | VMX_CPU_BASED_UNCOND_IO_EXITING |
+            VMX_CPU_BASED_USE_IO_BITMAPS | VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+            VMX_CPU_BASED_USE_MSR_BITMAPS | VMX_CPU_BASED_MONITOR_EXITING |
+            VMX_CPU_BASED_PAUSE_EXITING |
+            VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+            VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+            VMX_SECONDARY_EXEC_ENABLE_EPT | VMX_SECONDARY_EXEC_DESC |
+            VMX_SECONDARY_EXEC_RDTSCP |
+            VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+            VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_WBINVD_EXITING |
+            VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+            VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+            VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+            VMX_SECONDARY_EXEC_RDRAND_EXITING |
+            VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+            VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+            VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML |
+            VMX_SECONDARY_EXEC_XSAVES,
+        .features[FEAT_VMX_VMFUNC] =
+            MSR_VMX_VMFUNC_EPT_SWITCHING,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Xeon Processor (SapphireRapids)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    { "sbdr-ssdp-no", "on" },
+                    { "fbsdp-no", "on" },
+                    { "psdp-no", "on" },
+                    { /* end of list */ }
+                }
+            },
+            {
+                .version = 3,
+                .props = (PropValue[]) {
+                    { "ss", "on" },
+                    { "tsc-adjust", "on" },
+                    { "cldemote", "on" },
+                    { "movdiri", "on" },
+                    { "movdir64b", "on" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
+    },
+    {
+        .name = "GraniteRapids",
+        .level = 0x20,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 173,
+        .stepping = 0,
+        /*
+         * please keep the ascending order so that we can have a clear view of
+         * bit position of each feature.
+         */
+        .features[FEAT_1_EDX] =
+            CPUID_FP87 | CPUID_VME | CPUID_DE | CPUID_PSE | CPUID_TSC |
+            CPUID_MSR | CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC |
+            CPUID_SEP | CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV |
+            CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH | CPUID_MMX | CPUID_FXSR |
+            CPUID_SSE | CPUID_SSE2,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3 |
+            CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID | CPUID_EXT_SSE41 |
+            CPUID_EXT_SSE42 | CPUID_EXT_X2APIC | CPUID_EXT_MOVBE |
+            CPUID_EXT_POPCNT | CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_AES |
+            CPUID_EXT_XSAVE | CPUID_EXT_AVX | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_SYSCALL | CPUID_EXT2_NX | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_RDTSCP | CPUID_EXT2_LM,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_LAHF_LM | CPUID_EXT3_ABM | CPUID_EXT3_3DNOWPREFETCH,
+        .features[FEAT_8000_0008_EBX] =
+            CPUID_8000_0008_EBX_WBNOINVD,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_HLE |
+            CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 |
+            CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID | CPUID_7_0_EBX_RTM |
+            CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
+            CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP |
+            CPUID_7_0_EBX_AVX512IFMA | CPUID_7_0_EBX_CLFLUSHOPT |
+            CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_AVX512CD | CPUID_7_0_EBX_SHA_NI |
+            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512VL,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
+            CPUID_7_0_ECX_AVX512_VBMI2 | CPUID_7_0_ECX_GFNI |
+            CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
+            CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
+            CPUID_7_0_ECX_AVX512_VPOPCNTDQ | CPUID_7_0_ECX_LA57 |
+            CPUID_7_0_ECX_RDPID | CPUID_7_0_ECX_BUS_LOCK_DETECT,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_FSRM | CPUID_7_0_EDX_SERIALIZE |
+            CPUID_7_0_EDX_TSX_LDTRK | CPUID_7_0_EDX_AMX_BF16 |
+            CPUID_7_0_EDX_AVX512_FP16 | CPUID_7_0_EDX_AMX_TILE |
+            CPUID_7_0_EDX_AMX_INT8 | CPUID_7_0_EDX_SPEC_CTRL |
+            CPUID_7_0_EDX_ARCH_CAPABILITIES | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
+        .features[FEAT_ARCH_CAPABILITIES] =
+            MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_IBRS_ALL |
+            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO |
+            MSR_ARCH_CAP_PSCHANGE_MC_NO | MSR_ARCH_CAP_TAA_NO |
+            MSR_ARCH_CAP_SBDR_SSDP_NO | MSR_ARCH_CAP_FBSDP_NO |
+            MSR_ARCH_CAP_PSDP_NO | MSR_ARCH_CAP_PBRSB_NO,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES | CPUID_D_1_EAX_XFD,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_7_1_EAX] =
+            CPUID_7_1_EAX_AVX_VNNI | CPUID_7_1_EAX_AVX512_BF16 |
+            CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | CPUID_7_1_EAX_FSRC |
+            CPUID_7_1_EAX_AMX_FP16,
+        .features[FEAT_7_1_EDX] =
+            CPUID_7_1_EDX_PREFETCHITI,
+        .features[FEAT_7_2_EDX] =
+            CPUID_7_2_EDX_MCDT_NO,
+        .features[FEAT_VMX_BASIC] =
+            MSR_VMX_BASIC_INS_OUTS | MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] =
+            VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_IA32E_MODE |
+            VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+            VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] =
+            MSR_VMX_EPT_EXECONLY |
+            MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_PAGE_WALK_LENGTH_5 |
+            MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB | MSR_VMX_EPT_1GB |
+            MSR_VMX_EPT_INVEPT | MSR_VMX_EPT_AD_BITS |
+            MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+            MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT |
+            MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+            VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+            VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+            VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
+            VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] =
+            MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_ACTIVITY_HLT |
+            MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] =
+            VMX_PIN_BASED_EXT_INTR_MASK | VMX_PIN_BASED_NMI_EXITING |
+            VMX_PIN_BASED_VIRTUAL_NMIS | VMX_PIN_BASED_VMX_PREEMPTION_TIMER |
+            VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] =
+            VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+            VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+            VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+            VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+            VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+            VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+            VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_VIRTUAL_NMI_PENDING |
+            VMX_CPU_BASED_MOV_DR_EXITING | VMX_CPU_BASED_UNCOND_IO_EXITING |
+            VMX_CPU_BASED_USE_IO_BITMAPS | VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+            VMX_CPU_BASED_USE_MSR_BITMAPS | VMX_CPU_BASED_MONITOR_EXITING |
+            VMX_CPU_BASED_PAUSE_EXITING |
+            VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+            VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+            VMX_SECONDARY_EXEC_ENABLE_EPT | VMX_SECONDARY_EXEC_DESC |
+            VMX_SECONDARY_EXEC_RDTSCP |
+            VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+            VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_WBINVD_EXITING |
+            VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+            VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+            VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+            VMX_SECONDARY_EXEC_RDRAND_EXITING |
+            VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+            VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+            VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML |
+            VMX_SECONDARY_EXEC_XSAVES,
+        .features[FEAT_VMX_VMFUNC] =
+            MSR_VMX_VMFUNC_EPT_SWITCHING,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Xeon Processor (GraniteRapids)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    { "ss", "on" },
+                    { "tsc-adjust", "on" },
+                    { "cldemote", "on" },
+                    { "movdiri", "on" },
+                    { "movdir64b", "on" },
+                    { "avx10", "on" },
+                    { "avx10-128", "on" },
+                    { "avx10-256", "on" },
+                    { "avx10-512", "on" },
+                    { "avx10-version", "1" },
+                    { "stepping", "1" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ },
+        },
+    },
+    {
+        .name = "SierraForest",
+        .level = 0x23,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 175,
+        .stepping = 0,
+        /*
+         * please keep the ascending order so that we can have a clear view of
+         * bit position of each feature.
+         */
+        .features[FEAT_1_EDX] =
+            CPUID_FP87 | CPUID_VME | CPUID_DE | CPUID_PSE | CPUID_TSC |
+            CPUID_MSR | CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC |
+            CPUID_SEP | CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV |
+            CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH | CPUID_MMX | CPUID_FXSR |
+            CPUID_SSE | CPUID_SSE2,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3 |
+            CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID | CPUID_EXT_SSE41 |
+            CPUID_EXT_SSE42 | CPUID_EXT_X2APIC | CPUID_EXT_MOVBE |
+            CPUID_EXT_POPCNT | CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_AES |
+            CPUID_EXT_XSAVE | CPUID_EXT_AVX | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_SYSCALL | CPUID_EXT2_NX | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_RDTSCP | CPUID_EXT2_LM,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_LAHF_LM | CPUID_EXT3_ABM | CPUID_EXT3_3DNOWPREFETCH,
+        .features[FEAT_8000_0008_EBX] =
+            CPUID_8000_0008_EBX_WBNOINVD,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
+            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS |
+            CPUID_7_0_EBX_INVPCID | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSHOPT | CPUID_7_0_EBX_CLWB |
+            CPUID_7_0_EBX_SHA_NI,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU | CPUID_7_0_ECX_GFNI |
+            CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
+            CPUID_7_0_ECX_RDPID | CPUID_7_0_ECX_BUS_LOCK_DETECT,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_FSRM | CPUID_7_0_EDX_SERIALIZE |
+            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_ARCH_CAPABILITIES |
+            CPUID_7_0_EDX_SPEC_CTRL_SSBD,
+        .features[FEAT_ARCH_CAPABILITIES] =
+            MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_IBRS_ALL |
+            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO |
+            MSR_ARCH_CAP_PSCHANGE_MC_NO | MSR_ARCH_CAP_SBDR_SSDP_NO |
+            MSR_ARCH_CAP_FBSDP_NO | MSR_ARCH_CAP_PSDP_NO |
+            MSR_ARCH_CAP_PBRSB_NO,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_7_1_EAX] =
+            CPUID_7_1_EAX_AVX_VNNI | CPUID_7_1_EAX_CMPCCXADD |
+            CPUID_7_1_EAX_FSRS | CPUID_7_1_EAX_AVX_IFMA,
+        .features[FEAT_7_1_EDX] =
+            CPUID_7_1_EDX_AVX_VNNI_INT8 | CPUID_7_1_EDX_AVX_NE_CONVERT,
+        .features[FEAT_7_2_EDX] =
+            CPUID_7_2_EDX_MCDT_NO,
+        .features[FEAT_VMX_BASIC] =
+            MSR_VMX_BASIC_INS_OUTS | MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] =
+            VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_IA32E_MODE |
+            VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+            VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] =
+            MSR_VMX_EPT_EXECONLY | MSR_VMX_EPT_PAGE_WALK_LENGTH_4 |
+            MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB | MSR_VMX_EPT_1GB |
+            MSR_VMX_EPT_INVEPT | MSR_VMX_EPT_AD_BITS |
+            MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+            MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT |
+            MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+            VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+            VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+            VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
+            VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] =
+            MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_ACTIVITY_HLT |
+            MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] =
+            VMX_PIN_BASED_EXT_INTR_MASK | VMX_PIN_BASED_NMI_EXITING |
+            VMX_PIN_BASED_VIRTUAL_NMIS | VMX_PIN_BASED_VMX_PREEMPTION_TIMER |
+            VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] =
+            VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+            VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+            VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+            VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+            VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+            VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+            VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_VIRTUAL_NMI_PENDING |
+            VMX_CPU_BASED_MOV_DR_EXITING | VMX_CPU_BASED_UNCOND_IO_EXITING |
+            VMX_CPU_BASED_USE_IO_BITMAPS | VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+            VMX_CPU_BASED_USE_MSR_BITMAPS | VMX_CPU_BASED_MONITOR_EXITING |
+            VMX_CPU_BASED_PAUSE_EXITING |
+            VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+            VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+            VMX_SECONDARY_EXEC_ENABLE_EPT | VMX_SECONDARY_EXEC_DESC |
+            VMX_SECONDARY_EXEC_RDTSCP |
+            VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+            VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_WBINVD_EXITING |
+            VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+            VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+            VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+            VMX_SECONDARY_EXEC_RDRAND_EXITING |
+            VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+            VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+            VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML |
+            VMX_SECONDARY_EXEC_XSAVES,
+        .features[FEAT_VMX_VMFUNC] =
+            MSR_VMX_VMFUNC_EPT_SWITCHING,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Xeon Processor (SierraForest)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            { /* end of list */ },
+        },
+    },
+    {
+        .name = "Denverton",
+        .level = 21,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 95,
+        .stepping = 1,
+        .features[FEAT_1_EDX] =
+            CPUID_FP87 | CPUID_VME | CPUID_DE | CPUID_PSE | CPUID_TSC |
+            CPUID_MSR | CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC |
+            CPUID_SEP | CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV |
+            CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH | CPUID_MMX | CPUID_FXSR |
+            CPUID_SSE | CPUID_SSE2,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_MONITOR |
+            CPUID_EXT_SSSE3 | CPUID_EXT_CX16 | CPUID_EXT_SSE41 |
+            CPUID_EXT_SSE42 | CPUID_EXT_X2APIC | CPUID_EXT_MOVBE |
+            CPUID_EXT_POPCNT | CPUID_EXT_TSC_DEADLINE_TIMER |
+            CPUID_EXT_AES | CPUID_EXT_XSAVE | CPUID_EXT_RDRAND,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_SYSCALL | CPUID_EXT2_NX | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_RDTSCP | CPUID_EXT2_LM,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_ERMS |
+            CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_SMAP |
+            CPUID_7_0_EBX_CLFLUSHOPT | CPUID_7_0_EBX_SHA_NI,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_ARCH_CAPABILITIES |
+            CPUID_7_0_EDX_SPEC_CTRL_SSBD,
+        /* XSAVES is added in version 3 */
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC | CPUID_XSAVE_XGETBV1,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_ARCH_CAPABILITIES] =
+            MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+             VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Atom Processor (Denverton)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .note = "no MPX, no MONITOR",
+                .props = (PropValue[]) {
+                    { "monitor", "off" },
+                    { "mpx", "off" },
+                    { /* end of list */ },
+                },
+            },
+            {
+                .version = 3,
+                .note = "XSAVES, no MPX, no MONITOR",
+                .props = (PropValue[]) {
+                    { "xsaves", "on" },
+                    { "vmx-xsaves", "on" },
+                    { /* end of list */ },
+                },
+            },
+            { /* end of list */ },
+        },
+    },
+    {
+        .name = "Snowridge",
+        .level = 27,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 134,
+        .stepping = 1,
+        .features[FEAT_1_EDX] =
+            /* missing: CPUID_PN CPUID_IA64 */
+            /* missing: CPUID_DTS, CPUID_HT, CPUID_TM, CPUID_PBE */
+            CPUID_FP87 | CPUID_VME | CPUID_DE | CPUID_PSE |
+            CPUID_TSC | CPUID_MSR | CPUID_PAE | CPUID_MCE |
+            CPUID_CX8 | CPUID_APIC | CPUID_SEP |
+            CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV |
+            CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH |
+            CPUID_MMX |
+            CPUID_FXSR | CPUID_SSE | CPUID_SSE2,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_MONITOR |
+            CPUID_EXT_SSSE3 |
+            CPUID_EXT_CX16 |
+            CPUID_EXT_SSE41 |
+            CPUID_EXT_SSE42 | CPUID_EXT_X2APIC | CPUID_EXT_MOVBE |
+            CPUID_EXT_POPCNT |
+            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_AES | CPUID_EXT_XSAVE |
+            CPUID_EXT_RDRAND,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_SYSCALL |
+            CPUID_EXT2_NX |
+            CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP |
+            CPUID_EXT2_LM,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_3DNOWPREFETCH,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE |
+            CPUID_7_0_EBX_SMEP |
+            CPUID_7_0_EBX_ERMS |
+            CPUID_7_0_EBX_MPX |  /* missing bits 13, 15 */
+            CPUID_7_0_EBX_RDSEED |
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSHOPT |
+            CPUID_7_0_EBX_CLWB |
+            CPUID_7_0_EBX_SHA_NI,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_UMIP |
+            /* missing bit 5 */
+            CPUID_7_0_ECX_GFNI |
+            CPUID_7_0_ECX_MOVDIRI | CPUID_7_0_ECX_CLDEMOTE |
+            CPUID_7_0_ECX_MOVDIR64B,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_SPEC_CTRL |
+            CPUID_7_0_EDX_ARCH_CAPABILITIES | CPUID_7_0_EDX_SPEC_CTRL_SSBD |
+            CPUID_7_0_EDX_CORE_CAPABILITY,
+        .features[FEAT_CORE_CAPABILITY] =
+            MSR_CORE_CAP_SPLIT_LOCK_DETECT,
+        /* XSAVES is added in version 3 */
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+             VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Atom Processor (SnowRidge)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    { "mpx", "off" },
+                    { "model-id", "Intel Atom Processor (Snowridge, no MPX)" },
+                    { /* end of list */ },
+                },
+            },
+            {
+                .version = 3,
+                .note = "XSAVES, no MPX",
+                .props = (PropValue[]) {
+                    { "xsaves", "on" },
+                    { "vmx-xsaves", "on" },
+                    { /* end of list */ },
+                },
+            },
+            {
+                .version = 4,
+                .note = "no split lock detect, no core-capability",
+                .props = (PropValue[]) {
+                    { "split-lock-detect", "off" },
+                    { "core-capability", "off" },
+                    { /* end of list */ },
+                },
+            },
+            { /* end of list */ },
+        },
+    },
+    {
+        .name = "KnightsMill",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 133,
+        .stepping = 0,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SS | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR |
+            CPUID_MMX | CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV |
+            CPUID_MCA | CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC |
+            CPUID_CX8 | CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC |
+            CPUID_PSE | CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
+            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
+            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
+            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
+            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
+            CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP |
+            CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
+            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS |
+            CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_AVX512F |
+            CPUID_7_0_EBX_AVX512CD | CPUID_7_0_EBX_AVX512PF |
+            CPUID_7_0_EBX_AVX512ER,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_AVX512_VPOPCNTDQ,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_AVX512_4VNNIW | CPUID_7_0_EDX_AVX512_4FMAPS,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Xeon Phi Processor (Knights Mill)",
+    },
+    {
+        .name = "Opteron_G1",
+        .level = 5,
+        .vendor = CPUID_VENDOR_AMD,
+        .family = 15,
+        .model = 6,
+        .stepping = 1,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
+        .xlevel = 0x80000008,
+        .model_id = "AMD Opteron 240 (Gen 1 Class Opteron)",
+    },
+    {
+        .name = "Opteron_G2",
+        .level = 5,
+        .vendor = CPUID_VENDOR_AMD,
+        .family = 15,
+        .model = 6,
+        .stepping = 1,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_CX16 | CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
+        .xlevel = 0x80000008,
+        .model_id = "AMD Opteron 22xx (Gen 2 Class Opteron)",
+    },
+    {
+        .name = "Opteron_G3",
+        .level = 5,
+        .vendor = CPUID_VENDOR_AMD,
+        .family = 16,
+        .model = 2,
+        .stepping = 3,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_POPCNT | CPUID_EXT_CX16 | CPUID_EXT_MONITOR |
+            CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL |
+            CPUID_EXT2_RDTSCP,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A |
+            CPUID_EXT3_ABM | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
+        .xlevel = 0x80000008,
+        .model_id = "AMD Opteron 23xx (Gen 3 Class Opteron)",
+    },
+    {
+        .name = "Opteron_G4",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_AMD,
+        .family = 21,
+        .model = 1,
+        .stepping = 2,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
+            CPUID_EXT_POPCNT | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
+            CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ |
+            CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL | CPUID_EXT2_RDTSCP,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_FMA4 | CPUID_EXT3_XOP |
+            CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_MISALIGNSSE |
+            CPUID_EXT3_SSE4A | CPUID_EXT3_ABM | CPUID_EXT3_SVM |
+            CPUID_EXT3_LAHF_LM,
+        .features[FEAT_SVM] =
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
+        /* no xsaveopt! */
+        .xlevel = 0x8000001A,
+        .model_id = "AMD Opteron 62xx class CPU",
+    },
+    {
+        .name = "Opteron_G5",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_AMD,
+        .family = 21,
+        .model = 2,
+        .stepping = 0,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_F16C | CPUID_EXT_AVX | CPUID_EXT_XSAVE |
+            CPUID_EXT_AES | CPUID_EXT_POPCNT | CPUID_EXT_SSE42 |
+            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_FMA |
+            CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL | CPUID_EXT2_RDTSCP,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_TBM | CPUID_EXT3_FMA4 | CPUID_EXT3_XOP |
+            CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_MISALIGNSSE |
+            CPUID_EXT3_SSE4A | CPUID_EXT3_ABM | CPUID_EXT3_SVM |
+            CPUID_EXT3_LAHF_LM,
+        .features[FEAT_SVM] =
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
+        /* no xsaveopt! */
+        .xlevel = 0x8000001A,
+        .model_id = "AMD Opteron 63xx class CPU",
+    },
+    {
+        .name = "EPYC",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_AMD,
+        .family = 23,
+        .model = 1,
+        .stepping = 2,
+        .features[FEAT_1_EDX] =
+            CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX | CPUID_CLFLUSH |
+            CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA | CPUID_PGE |
+            CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 | CPUID_MCE |
+            CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE | CPUID_DE |
+            CPUID_VME | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_RDRAND | CPUID_EXT_F16C | CPUID_EXT_AVX |
+            CPUID_EXT_XSAVE | CPUID_EXT_AES |  CPUID_EXT_POPCNT |
+            CPUID_EXT_MOVBE | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
+            CPUID_EXT_CX16 | CPUID_EXT_FMA | CPUID_EXT_SSSE3 |
+            CPUID_EXT_MONITOR | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_FFXSR | CPUID_EXT2_MMXEXT | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
+            CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
+            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED |
+            CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSHOPT |
+            CPUID_7_0_EBX_SHA_NI,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_SVM] =
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
+        .xlevel = 0x8000001E,
+        .model_id = "AMD EPYC Processor",
+        .cache_info = &epyc_cache_info,
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .alias = "EPYC-IBPB",
+                .props = (PropValue[]) {
+                    { "ibpb", "on" },
+                    { "model-id",
+                      "AMD EPYC Processor (with IBPB)" },
+                    { /* end of list */ }
+                }
+            },
+            {
+                .version = 3,
+                .props = (PropValue[]) {
+                    { "ibpb", "on" },
+                    { "perfctr-core", "on" },
+                    { "clzero", "on" },
+                    { "xsaveerptr", "on" },
+                    { "xsaves", "on" },
+                    { "model-id",
+                      "AMD EPYC Processor" },
+                    { /* end of list */ }
+                }
+            },
+            {
+                .version = 4,
+                .props = (PropValue[]) {
+                    { "model-id",
+                      "AMD EPYC-v4 Processor" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_v4_cache_info
+            },
+            { /* end of list */ }
+        }
+    },
+    {
+        .name = "Dhyana",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_HYGON,
+        .family = 24,
+        .model = 0,
+        .stepping = 1,
+        .features[FEAT_1_EDX] =
+            CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX | CPUID_CLFLUSH |
+            CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA | CPUID_PGE |
+            CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 | CPUID_MCE |
+            CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE | CPUID_DE |
+            CPUID_VME | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_RDRAND | CPUID_EXT_F16C | CPUID_EXT_AVX |
+            CPUID_EXT_XSAVE | CPUID_EXT_POPCNT |
+            CPUID_EXT_MOVBE | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
+            CPUID_EXT_CX16 | CPUID_EXT_FMA | CPUID_EXT_SSSE3 |
+            CPUID_EXT_MONITOR | CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_FFXSR | CPUID_EXT2_MMXEXT | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
+            CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT,
+        .features[FEAT_8000_0008_EBX] =
+            CPUID_8000_0008_EBX_IBPB,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
+            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED |
+            CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSHOPT,
+        /* XSAVES is added in version 2 */
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_SVM] =
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
+        .xlevel = 0x8000001E,
+        .model_id = "Hygon Dhyana Processor",
+        .cache_info = &epyc_cache_info,
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            { .version = 2,
+              .note = "XSAVES",
+              .props = (PropValue[]) {
+                  { "xsaves", "on" },
+                  { /* end of list */ }
+              },
+            },
+            { /* end of list */ }
+        }
+    },
+    {
+        .name = "EPYC-Rome",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_AMD,
+        .family = 23,
+        .model = 49,
+        .stepping = 0,
+        .features[FEAT_1_EDX] =
+            CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX | CPUID_CLFLUSH |
+            CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA | CPUID_PGE |
+            CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 | CPUID_MCE |
+            CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE | CPUID_DE |
+            CPUID_VME | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_RDRAND | CPUID_EXT_F16C | CPUID_EXT_AVX |
+            CPUID_EXT_XSAVE | CPUID_EXT_AES |  CPUID_EXT_POPCNT |
+            CPUID_EXT_MOVBE | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
+            CPUID_EXT_CX16 | CPUID_EXT_FMA | CPUID_EXT_SSSE3 |
+            CPUID_EXT_MONITOR | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_FFXSR | CPUID_EXT2_MMXEXT | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
+            CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT | CPUID_EXT3_PERFCORE,
+        .features[FEAT_8000_0008_EBX] =
+            CPUID_8000_0008_EBX_CLZERO | CPUID_8000_0008_EBX_XSAVEERPTR |
+            CPUID_8000_0008_EBX_WBNOINVD | CPUID_8000_0008_EBX_IBPB |
+            CPUID_8000_0008_EBX_STIBP,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
+            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED |
+            CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSHOPT |
+            CPUID_7_0_EBX_SHA_NI | CPUID_7_0_EBX_CLWB,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_RDPID,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_SVM] =
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
+        .xlevel = 0x8000001E,
+        .model_id = "AMD EPYC-Rome Processor",
+        .cache_info = &epyc_rome_cache_info,
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    { "ibrs", "on" },
+                    { "amd-ssbd", "on" },
+                    { /* end of list */ }
+                }
+            },
+            {
+                .version = 3,
+                .props = (PropValue[]) {
+                    { "model-id",
+                      "AMD EPYC-Rome-v3 Processor" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_rome_v3_cache_info
+            },
+            {
+                .version = 4,
+                .props = (PropValue[]) {
+                    /* Erratum 1386 */
+                    { "model-id",
+                      "AMD EPYC-Rome-v4 Processor (no XSAVES)" },
+                    { "xsaves", "off" },
+                    { /* end of list */ }
+                },
+            },
+            { /* end of list */ }
+        }
+    },
+    {
+        .name = "EPYC-Milan",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_AMD,
+        .family = 25,
+        .model = 1,
+        .stepping = 1,
+        .features[FEAT_1_EDX] =
+            CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX | CPUID_CLFLUSH |
+            CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA | CPUID_PGE |
+            CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 | CPUID_MCE |
+            CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE | CPUID_DE |
+            CPUID_VME | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_RDRAND | CPUID_EXT_F16C | CPUID_EXT_AVX |
+            CPUID_EXT_XSAVE | CPUID_EXT_AES |  CPUID_EXT_POPCNT |
+            CPUID_EXT_MOVBE | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
+            CPUID_EXT_CX16 | CPUID_EXT_FMA | CPUID_EXT_SSSE3 |
+            CPUID_EXT_MONITOR | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
+            CPUID_EXT_PCID,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_FFXSR | CPUID_EXT2_MMXEXT | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
+            CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT | CPUID_EXT3_PERFCORE,
+        .features[FEAT_8000_0008_EBX] =
+            CPUID_8000_0008_EBX_CLZERO | CPUID_8000_0008_EBX_XSAVEERPTR |
+            CPUID_8000_0008_EBX_WBNOINVD | CPUID_8000_0008_EBX_IBPB |
+            CPUID_8000_0008_EBX_IBRS | CPUID_8000_0008_EBX_STIBP |
+            CPUID_8000_0008_EBX_AMD_SSBD,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
+            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED |
+            CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSHOPT |
+            CPUID_7_0_EBX_SHA_NI | CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_ERMS |
+            CPUID_7_0_EBX_INVPCID,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_RDPID | CPUID_7_0_ECX_PKU,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_FSRM,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_SVM] =
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE | CPUID_SVM_SVME_ADDR_CHK,
+        .xlevel = 0x8000001E,
+        .model_id = "AMD EPYC-Milan Processor",
+        .cache_info = &epyc_milan_cache_info,
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    { "model-id",
+                      "AMD EPYC-Milan-v2 Processor" },
+                    { "vaes", "on" },
+                    { "vpclmulqdq", "on" },
+                    { "stibp-always-on", "on" },
+                    { "amd-psfd", "on" },
+                    { "no-nested-data-bp", "on" },
+                    { "lfence-always-serializing", "on" },
+                    { "null-sel-clr-base", "on" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_milan_v2_cache_info
+            },
+            { /* end of list */ }
+        }
+    },
+    {
+        .name = "EPYC-Genoa",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_AMD,
+        .family = 25,
+        .model = 17,
+        .stepping = 0,
+        .features[FEAT_1_EDX] =
+            CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX | CPUID_CLFLUSH |
+            CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA | CPUID_PGE |
+            CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 | CPUID_MCE |
+            CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE | CPUID_DE |
+            CPUID_VME | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_RDRAND | CPUID_EXT_F16C | CPUID_EXT_AVX |
+            CPUID_EXT_XSAVE | CPUID_EXT_AES |  CPUID_EXT_POPCNT |
+            CPUID_EXT_MOVBE | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
+            CPUID_EXT_PCID | CPUID_EXT_CX16 | CPUID_EXT_FMA |
+            CPUID_EXT_SSSE3 | CPUID_EXT_MONITOR | CPUID_EXT_PCLMULQDQ |
+            CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_FFXSR | CPUID_EXT2_MMXEXT | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
+            CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT | CPUID_EXT3_PERFCORE,
+        .features[FEAT_8000_0008_EBX] =
+            CPUID_8000_0008_EBX_CLZERO | CPUID_8000_0008_EBX_XSAVEERPTR |
+            CPUID_8000_0008_EBX_WBNOINVD | CPUID_8000_0008_EBX_IBPB |
+            CPUID_8000_0008_EBX_IBRS | CPUID_8000_0008_EBX_STIBP |
+            CPUID_8000_0008_EBX_STIBP_ALWAYS_ON |
+            CPUID_8000_0008_EBX_AMD_SSBD | CPUID_8000_0008_EBX_AMD_PSFD,
+        .features[FEAT_8000_0021_EAX] =
+            CPUID_8000_0021_EAX_NO_NESTED_DATA_BP |
+            CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING |
+            CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE |
+            CPUID_8000_0021_EAX_AUTO_IBRS,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
+            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS |
+            CPUID_7_0_EBX_INVPCID | CPUID_7_0_EBX_AVX512F |
+            CPUID_7_0_EBX_AVX512DQ | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_AVX512IFMA |
+            CPUID_7_0_EBX_CLFLUSHOPT | CPUID_7_0_EBX_CLWB |
+            CPUID_7_0_EBX_AVX512CD | CPUID_7_0_EBX_SHA_NI |
+            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512VL,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
+            CPUID_7_0_ECX_AVX512_VBMI2 | CPUID_7_0_ECX_GFNI |
+            CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
+            CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
+            CPUID_7_0_ECX_AVX512_VPOPCNTDQ | CPUID_7_0_ECX_LA57 |
+            CPUID_7_0_ECX_RDPID,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_FSRM,
+        .features[FEAT_7_1_EAX] =
+            CPUID_7_1_EAX_AVX512_BF16,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_SVM] =
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE | CPUID_SVM_VNMI |
+            CPUID_SVM_SVME_ADDR_CHK,
+        .xlevel = 0x80000022,
+        .model_id = "AMD EPYC-Genoa Processor",
+        .cache_info = &epyc_genoa_cache_info,
+    },
+};
+
+/*
+ * We resolve CPU model aliases using -v1 when using "-machine
+ * none", but this is just for compatibility while libvirt isn't
+ * adapted to resolve CPU model versions before creating VMs.
+ * See "Runnability guarantee of CPU models" at
+ * docs/about/deprecated.rst.
+ */
+X86CPUVersion default_cpu_version = 1;
+
+void x86_cpu_set_default_version(X86CPUVersion version)
+{
+    /* Translating CPU_VERSION_AUTO to CPU_VERSION_AUTO doesn't make sense */
+    assert(version != CPU_VERSION_AUTO);
+    default_cpu_version = version;
+}
+
+static X86CPUVersion x86_cpu_model_last_version(const X86CPUModel *model)
+{
+    int v = 0;
+    const X86CPUVersionDefinition *vdef =
+        x86_cpu_def_get_versions(model->cpudef);
+    while (vdef->version) {
+        v = vdef->version;
+        vdef++;
+    }
+    return v;
+}
+
+/* Return the actual version being used for a specific CPU model */
+static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
+{
+    X86CPUVersion v = model->version;
+    if (v == CPU_VERSION_AUTO) {
+        v = default_cpu_version;
+    }
+    if (v == CPU_VERSION_LATEST) {
+        return x86_cpu_model_last_version(model);
+    }
+    return v;
+}
+
+static Property max_x86_cpu_properties[] = {
+    DEFINE_PROP_BOOL("migratable", X86CPU, migratable, true),
+    DEFINE_PROP_BOOL("host-cache-info", X86CPU, cache_info_passthrough, false),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void max_x86_cpu_realize(DeviceState *dev, Error **errp)
+{
+    Object *obj = OBJECT(dev);
+
+    if (!object_property_get_int(obj, "family", &error_abort)) {
+        if (X86_CPU(obj)->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
+            object_property_set_int(obj, "family", 15, &error_abort);
+            object_property_set_int(obj, "model", 107, &error_abort);
+            object_property_set_int(obj, "stepping", 1, &error_abort);
+        } else {
+            object_property_set_int(obj, "family", 6, &error_abort);
+            object_property_set_int(obj, "model", 6, &error_abort);
+            object_property_set_int(obj, "stepping", 3, &error_abort);
+        }
+    }
+
+    x86_cpu_realizefn(dev, errp);
+}
+
+static void max_x86_cpu_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    X86CPUClass *xcc = X86_CPU_CLASS(oc);
+
+    xcc->ordering = 9;
+
+    xcc->model_description =
+        "Enables all features supported by the accelerator in the current host";
+
+    device_class_set_props(dc, max_x86_cpu_properties);
+    dc->realize = max_x86_cpu_realize;
+}
+
+static void max_x86_cpu_initfn(Object *obj)
+{
+    X86CPU *cpu = X86_CPU(obj);
+
+    /* We can't fill the features array here because we don't know yet if
+     * "migratable" is true or false.
+     */
+    cpu->max_features = true;
+    object_property_set_bool(OBJECT(cpu), "pmu", true, &error_abort);
+
+    /*
+     * these defaults are used for TCG and all other accelerators
+     * besides KVM and HVF, which overwrite these values
+     */
+    object_property_set_str(OBJECT(cpu), "vendor", CPUID_VENDOR_AMD,
+                            &error_abort);
+    object_property_set_str(OBJECT(cpu), "model-id",
+                            "QEMU TCG CPU version " QEMU_HW_VERSION,
+                            &error_abort);
+}
+
+static const TypeInfo max_x86_cpu_type_info = {
+    .name = X86_CPU_TYPE_NAME("max"),
+    .parent = TYPE_X86_CPU,
+    .instance_init = max_x86_cpu_initfn,
+    .class_init = max_x86_cpu_class_init,
+};
+
+static char *feature_word_description(FeatureWordInfo *f, uint32_t bit)
+{
+    assert(f->type == CPUID_FEATURE_WORD || f->type == MSR_FEATURE_WORD);
+
+    switch (f->type) {
+    case CPUID_FEATURE_WORD:
+        {
+            const char *reg = get_register_name_32(f->cpuid.reg);
+            assert(reg);
+            return g_strdup_printf("CPUID.%02XH:%s",
+                                   f->cpuid.eax, reg);
+        }
+    case MSR_FEATURE_WORD:
+        return g_strdup_printf("MSR(%02XH)",
+                               f->msr.index);
+    }
+
+    return NULL;
+}
+
+static bool x86_cpu_have_filtered_features(X86CPU *cpu)
+{
+    FeatureWord w;
+
+    for (w = 0; w < FEATURE_WORDS; w++) {
+        if (cpu->filtered_features[w]) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
+                                      const char *verbose_prefix)
+{
+    CPUX86State *env = &cpu->env;
+    FeatureWordInfo *f = &feature_word_info[w];
+    int i;
+
+    if (!cpu->force_features) {
+        env->features[w] &= ~mask;
+    }
+    cpu->filtered_features[w] |= mask;
+
+    if (!verbose_prefix) {
+        return;
+    }
+
+    for (i = 0; i < 64; ++i) {
+        if ((1ULL << i) & mask) {
+            g_autofree char *feat_word_str = feature_word_description(f, i);
+            warn_report("%s: %s%s%s [bit %d]",
+                        verbose_prefix,
+                        feat_word_str,
+                        f->feat_names[i] ? "." : "",
+                        f->feat_names[i] ? f->feat_names[i] : "", i);
+        }
+    }
+}
+
+static void x86_cpuid_version_get_family(Object *obj, Visitor *v,
+                                         const char *name, void *opaque,
+                                         Error **errp)
+{
+    X86CPU *cpu = X86_CPU(obj);
+    CPUX86State *env = &cpu->env;
+    uint64_t value;
+
+    value = (env->cpuid_version >> 8) & 0xf;
+    if (value == 0xf) {
+        value += (env->cpuid_version >> 20) & 0xff;
+    }
+    visit_type_uint64(v, name, &value, errp);
+}
+
+static void x86_cpuid_version_set_family(Object *obj, Visitor *v,
+                                         const char *name, void *opaque,
+                                         Error **errp)
+{
+    X86CPU *cpu = X86_CPU(obj);
+    CPUX86State *env = &cpu->env;
+    const uint64_t max = 0xff + 0xf;
+    uint64_t value;
+
+    if (!visit_type_uint64(v, name, &value, errp)) {
+        return;
+    }
+    if (value > max) {
+        error_setg(errp, "parameter '%s' can be at most %" PRIu64,
+                   name ? name : "null", max);
+        return;
+    }
+
+    env->cpuid_version &= ~0xff00f00;
+    if (value > 0x0f) {
+        env->cpuid_version |= 0xf00 | ((value - 0x0f) << 20);
+    } else {
+        env->cpuid_version |= value << 8;
+    }
+}
+
+static void x86_cpuid_version_get_model(Object *obj, Visitor *v,
+                                        const char *name, void *opaque,
+                                        Error **errp)
+{
+    X86CPU *cpu = X86_CPU(obj);
+    CPUX86State *env = &cpu->env;
+    uint64_t value;
+
+    value = (env->cpuid_version >> 4) & 0xf;
+    value |= ((env->cpuid_version >> 16) & 0xf) << 4;
+    visit_type_uint64(v, name, &value, errp);
+}
+
+static void x86_cpuid_version_set_model(Object *obj, Visitor *v,
+                                        const char *name, void *opaque,
+                                        Error **errp)
+{
+    X86CPU *cpu = X86_CPU(obj);
+    CPUX86State *env = &cpu->env;
+    const uint64_t max = 0xff;
+    uint64_t value;
+
+    if (!visit_type_uint64(v, name, &value, errp)) {
+        return;
+    }
+    if (value > max) {
+        error_setg(errp, "parameter '%s' can be at most %" PRIu64,
+                   name ? name : "null", max);
+        return;
+    }
+
+    env->cpuid_version &= ~0xf00f0;
+    env->cpuid_version |= ((value & 0xf) << 4) | ((value >> 4) << 16);
+}
+
+static void x86_cpuid_version_get_stepping(Object *obj, Visitor *v,
+                                           const char *name, void *opaque,
+                                           Error **errp)
+{
+    X86CPU *cpu = X86_CPU(obj);
+    CPUX86State *env = &cpu->env;
+    uint64_t value;
+
+    value = env->cpuid_version & 0xf;
+    visit_type_uint64(v, name, &value, errp);
+}
+
+static void x86_cpuid_version_set_stepping(Object *obj, Visitor *v,
+                                           const char *name, void *opaque,
+                                           Error **errp)
+{
+    X86CPU *cpu = X86_CPU(obj);
+    CPUX86State *env = &cpu->env;
+    const uint64_t max = 0xf;
+    uint64_t value;
+
+    if (!visit_type_uint64(v, name, &value, errp)) {
+        return;
+    }
+    if (value > max) {
+        error_setg(errp, "parameter '%s' can be at most %" PRIu64,
+                   name ? name : "null", max);
+        return;
+    }
+
+    env->cpuid_version &= ~0xf;
+    env->cpuid_version |= value & 0xf;
+}
+
+static char *x86_cpuid_get_vendor(Object *obj, Error **errp)
+{
+    X86CPU *cpu = X86_CPU(obj);
+    CPUX86State *env = &cpu->env;
+    char *value;
+
+    value = g_malloc(CPUID_VENDOR_SZ + 1);
+    x86_cpu_vendor_words2str(value, env->cpuid_vendor1, env->cpuid_vendor2,
+                             env->cpuid_vendor3);
+    return value;
+}
+
+static void x86_cpuid_set_vendor(Object *obj, const char *value,
+                                 Error **errp)
+{
+    X86CPU *cpu = X86_CPU(obj);
+    CPUX86State *env = &cpu->env;
+    int i;
+
+    if (strlen(value) != CPUID_VENDOR_SZ) {
+        error_setg(errp, "value of property 'vendor' must consist of"
+                   " exactly " stringify(CPUID_VENDOR_SZ) " characters");
+        return;
+    }
+
+    env->cpuid_vendor1 = 0;
+    env->cpuid_vendor2 = 0;
+    env->cpuid_vendor3 = 0;
+    for (i = 0; i < 4; i++) {
+        env->cpuid_vendor1 |= ((uint8_t)value[i    ]) << (8 * i);
+        env->cpuid_vendor2 |= ((uint8_t)value[i + 4]) << (8 * i);
+        env->cpuid_vendor3 |= ((uint8_t)value[i + 8]) << (8 * i);
+    }
+}
+
+static char *x86_cpuid_get_model_id(Object *obj, Error **errp)
+{
+    X86CPU *cpu = X86_CPU(obj);
+    CPUX86State *env = &cpu->env;
+    char *value;
+    int i;
+
+    value = g_malloc(48 + 1);
+    for (i = 0; i < 48; i++) {
+        value[i] = env->cpuid_model[i >> 2] >> (8 * (i & 3));
+    }
+    value[48] = '\0';
+    return value;
+}
+
+static void x86_cpuid_set_model_id(Object *obj, const char *model_id,
+                                   Error **errp)
+{
+    X86CPU *cpu = X86_CPU(obj);
+    CPUX86State *env = &cpu->env;
+    int c, len, i;
+
+    if (model_id == NULL) {
+        model_id = "";
+    }
+    len = strlen(model_id);
+    memset(env->cpuid_model, 0, 48);
+    for (i = 0; i < 48; i++) {
+        if (i >= len) {
+            c = '\0';
+        } else {
+            c = (uint8_t)model_id[i];
+        }
+        env->cpuid_model[i >> 2] |= c << (8 * (i & 3));
+    }
+}
+
+static void x86_cpuid_get_tsc_freq(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    X86CPU *cpu = X86_CPU(obj);
+    int64_t value;
+
+    value = cpu->env.tsc_khz * 1000;
+    visit_type_int(v, name, &value, errp);
+}
+
+static void x86_cpuid_set_tsc_freq(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    X86CPU *cpu = X86_CPU(obj);
+    const int64_t max = INT64_MAX;
+    int64_t value;
+
+    if (!visit_type_int(v, name, &value, errp)) {
+        return;
+    }
+    if (value < 0 || value > max) {
+        error_setg(errp, "parameter '%s' can be at most %" PRId64,
+                   name ? name : "null", max);
+        return;
+    }
+
+    cpu->env.tsc_khz = cpu->env.user_tsc_khz = value / 1000;
+}
+
+/* Generic getter for "feature-words" and "filtered-features" properties */
+static void x86_cpu_get_feature_words(Object *obj, Visitor *v,
+                                      const char *name, void *opaque,
+                                      Error **errp)
+{
+    uint64_t *array = (uint64_t *)opaque;
+    FeatureWord w;
+    X86CPUFeatureWordInfo word_infos[FEATURE_WORDS] = { };
+    X86CPUFeatureWordInfoList list_entries[FEATURE_WORDS] = { };
+    X86CPUFeatureWordInfoList *list = NULL;
+
+    for (w = 0; w < FEATURE_WORDS; w++) {
+        FeatureWordInfo *wi = &feature_word_info[w];
+        /*
+                * We didn't have MSR features when "feature-words" was
+                *  introduced. Therefore skipped other type entries.
+                */
+        if (wi->type != CPUID_FEATURE_WORD) {
+            continue;
+        }
+        X86CPUFeatureWordInfo *qwi = &word_infos[w];
+        qwi->cpuid_input_eax = wi->cpuid.eax;
+        qwi->has_cpuid_input_ecx = wi->cpuid.needs_ecx;
+        qwi->cpuid_input_ecx = wi->cpuid.ecx;
+        qwi->cpuid_register = x86_reg_info_32[wi->cpuid.reg].qapi_enum;
+        qwi->features = array[w];
+
+        /* List will be in reverse order, but order shouldn't matter */
+        list_entries[w].next = list;
+        list_entries[w].value = &word_infos[w];
+        list = &list_entries[w];
+    }
+
+    visit_type_X86CPUFeatureWordInfoList(v, "feature-words", &list, errp);
+}
+
+/* Convert all '_' in a feature string option name to '-', to make feature
+ * name conform to QOM property naming rule, which uses '-' instead of '_'.
+ */
+static inline void feat2prop(char *s)
+{
+    while ((s = strchr(s, '_'))) {
+        *s = '-';
+    }
+}
+
+/* Return the feature property name for a feature flag bit */
+static const char *x86_cpu_feature_name(FeatureWord w, int bitnr)
+{
+    const char *name;
+    /* XSAVE components are automatically enabled by other features,
+     * so return the original feature name instead
+     */
+    if (w == FEAT_XSAVE_XCR0_LO || w == FEAT_XSAVE_XCR0_HI) {
+        int comp = (w == FEAT_XSAVE_XCR0_HI) ? bitnr + 32 : bitnr;
+
+        if (comp < ARRAY_SIZE(x86_ext_save_areas) &&
+            x86_ext_save_areas[comp].bits) {
+            w = x86_ext_save_areas[comp].feature;
+            bitnr = ctz32(x86_ext_save_areas[comp].bits);
+        }
+    }
+
+    assert(bitnr < 64);
+    assert(w < FEATURE_WORDS);
+    name = feature_word_info[w].feat_names[bitnr];
+    assert(bitnr < 32 || !(name && feature_word_info[w].type == CPUID_FEATURE_WORD));
+    return name;
+}
+
+/* Compatibility hack to maintain legacy +-feat semantic,
+ * where +-feat overwrites any feature set by
+ * feat=on|feat even if the later is parsed after +-feat
+ * (i.e. "-x2apic,x2apic=on" will result in x2apic disabled)
+ */
+static GList *plus_features, *minus_features;
+
+static gint compare_string(gconstpointer a, gconstpointer b)
+{
+    return g_strcmp0(a, b);
+}
+
+/* Parse "+feature,-feature,feature=foo" CPU feature string
+ */
+static void x86_cpu_parse_featurestr(const char *typename, char *features,
+                                     Error **errp)
+{
+    char *featurestr; /* Single 'key=value" string being parsed */
+    static bool cpu_globals_initialized;
+    bool ambiguous = false;
+
+    if (cpu_globals_initialized) {
+        return;
+    }
+    cpu_globals_initialized = true;
+
+    if (!features) {
+        return;
+    }
+
+    for (featurestr = strtok(features, ",");
+         featurestr;
+         featurestr = strtok(NULL, ",")) {
+        const char *name;
+        const char *val = NULL;
+        char *eq = NULL;
+        char num[32];
+        GlobalProperty *prop;
+
+        /* Compatibility syntax: */
+        if (featurestr[0] == '+') {
+            plus_features = g_list_append(plus_features,
+                                          g_strdup(featurestr + 1));
+            continue;
+        } else if (featurestr[0] == '-') {
+            minus_features = g_list_append(minus_features,
+                                           g_strdup(featurestr + 1));
+            continue;
+        }
+
+        eq = strchr(featurestr, '=');
+        if (eq) {
+            *eq++ = 0;
+            val = eq;
+        } else {
+            val = "on";
+        }
+
+        feat2prop(featurestr);
+        name = featurestr;
+
+        if (g_list_find_custom(plus_features, name, compare_string)) {
+            warn_report("Ambiguous CPU model string. "
+                        "Don't mix both \"+%s\" and \"%s=%s\"",
+                        name, name, val);
+            ambiguous = true;
+        }
+        if (g_list_find_custom(minus_features, name, compare_string)) {
+            warn_report("Ambiguous CPU model string. "
+                        "Don't mix both \"-%s\" and \"%s=%s\"",
+                        name, name, val);
+            ambiguous = true;
+        }
+
+        /* Special case: */
+        if (!strcmp(name, "tsc-freq")) {
+            int ret;
+            uint64_t tsc_freq;
+
+            ret = qemu_strtosz_metric(val, NULL, &tsc_freq);
+            if (ret < 0 || tsc_freq > INT64_MAX) {
+                error_setg(errp, "bad numerical value %s", val);
+                return;
+            }
+            snprintf(num, sizeof(num), "%" PRId64, tsc_freq);
+            val = num;
+            name = "tsc-frequency";
+        }
+
+        prop = g_new0(typeof(*prop), 1);
+        prop->driver = typename;
+        prop->property = g_strdup(name);
+        prop->value = g_strdup(val);
+        qdev_prop_register_global(prop);
+    }
+
+    if (ambiguous) {
+        warn_report("Compatibility of ambiguous CPU model "
+                    "strings won't be kept on future QEMU versions");
+    }
+}
+
+static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose);
+
+/* Build a list with the name of all features on a feature word array */
+static void x86_cpu_list_feature_names(FeatureWordArray features,
+                                       strList **list)
+{
+    strList **tail = list;
+    FeatureWord w;
+
+    for (w = 0; w < FEATURE_WORDS; w++) {
+        uint64_t filtered = features[w];
+        int i;
+        for (i = 0; i < 64; i++) {
+            if (filtered & (1ULL << i)) {
+                QAPI_LIST_APPEND(tail, g_strdup(x86_cpu_feature_name(w, i)));
+            }
+        }
+    }
+}
+
+static void x86_cpu_get_unavailable_features(Object *obj, Visitor *v,
+                                             const char *name, void *opaque,
+                                             Error **errp)
+{
+    X86CPU *xc = X86_CPU(obj);
+    strList *result = NULL;
+
+    x86_cpu_list_feature_names(xc->filtered_features, &result);
+    visit_type_strList(v, "unavailable-features", &result, errp);
+}
+
+/* Print all cpuid feature names in featureset
+ */
+static void listflags(GList *features)
+{
+    size_t len = 0;
+    GList *tmp;
+
+    for (tmp = features; tmp; tmp = tmp->next) {
+        const char *name = tmp->data;
+        if ((len + strlen(name) + 1) >= 75) {
+            qemu_printf("\n");
+            len = 0;
+        }
+        qemu_printf("%s%s", len == 0 ? "  " : " ", name);
+        len += strlen(name) + 1;
+    }
+    qemu_printf("\n");
+}
+
+/* Sort alphabetically by type name, respecting X86CPUClass::ordering. */
+static gint x86_cpu_list_compare(gconstpointer a, gconstpointer b)
+{
+    ObjectClass *class_a = (ObjectClass *)a;
+    ObjectClass *class_b = (ObjectClass *)b;
+    X86CPUClass *cc_a = X86_CPU_CLASS(class_a);
+    X86CPUClass *cc_b = X86_CPU_CLASS(class_b);
+    int ret;
+
+    if (cc_a->ordering != cc_b->ordering) {
+        ret = cc_a->ordering - cc_b->ordering;
+    } else {
+        g_autofree char *name_a = x86_cpu_class_get_model_name(cc_a);
+        g_autofree char *name_b = x86_cpu_class_get_model_name(cc_b);
+        ret = strcmp(name_a, name_b);
+    }
+    return ret;
+}
+
+static GSList *get_sorted_cpu_model_list(void)
+{
+    GSList *list = object_class_get_list(TYPE_X86_CPU, false);
+    list = g_slist_sort(list, x86_cpu_list_compare);
+    return list;
+}
+
+static char *x86_cpu_class_get_model_id(X86CPUClass *xc)
+{
+    Object *obj = object_new_with_class(OBJECT_CLASS(xc));
+    char *r = object_property_get_str(obj, "model-id", &error_abort);
+    object_unref(obj);
+    return r;
+}
+
+static char *x86_cpu_class_get_alias_of(X86CPUClass *cc)
+{
+    X86CPUVersion version;
+
+    if (!cc->model || !cc->model->is_alias) {
+        return NULL;
+    }
+    version = x86_cpu_model_resolve_version(cc->model);
+    if (version <= 0) {
+        return NULL;
+    }
+    return x86_cpu_versioned_model_name(cc->model->cpudef, version);
+}
+
+static void x86_cpu_list_entry(gpointer data, gpointer user_data)
+{
+    ObjectClass *oc = data;
+    X86CPUClass *cc = X86_CPU_CLASS(oc);
+    g_autofree char *name = x86_cpu_class_get_model_name(cc);
+    g_autofree char *desc = g_strdup(cc->model_description);
+    g_autofree char *alias_of = x86_cpu_class_get_alias_of(cc);
+    g_autofree char *model_id = x86_cpu_class_get_model_id(cc);
+
+    if (!desc && alias_of) {
+        if (cc->model && cc->model->version == CPU_VERSION_AUTO) {
+            desc = g_strdup("(alias configured by machine type)");
+        } else {
+            desc = g_strdup_printf("(alias of %s)", alias_of);
+        }
+    }
+    if (!desc && cc->model && cc->model->note) {
+        desc = g_strdup_printf("%s [%s]", model_id, cc->model->note);
+    }
+    if (!desc) {
+        desc = g_strdup_printf("%s", model_id);
+    }
+
+    if (cc->model && cc->model->cpudef->deprecation_note) {
+        g_autofree char *olddesc = desc;
+        desc = g_strdup_printf("%s (deprecated)", olddesc);
+    }
+
+    qemu_printf("  %-20s  %s\n", name, desc);
+}
+
+/* list available CPU models and flags */
+void x86_cpu_list(void)
+{
+    int i, j;
+    GSList *list;
+    GList *names = NULL;
+
+    qemu_printf("Available CPUs:\n");
+    list = get_sorted_cpu_model_list();
+    g_slist_foreach(list, x86_cpu_list_entry, NULL);
+    g_slist_free(list);
+
+    names = NULL;
+    for (i = 0; i < ARRAY_SIZE(feature_word_info); i++) {
+        FeatureWordInfo *fw = &feature_word_info[i];
+        for (j = 0; j < 64; j++) {
+            if (fw->feat_names[j]) {
+                names = g_list_append(names, (gpointer)fw->feat_names[j]);
+            }
+        }
+    }
+
+    names = g_list_sort(names, (GCompareFunc)strcmp);
+
+    qemu_printf("\nRecognized CPUID flags:\n");
+    listflags(names);
+    qemu_printf("\n");
+    g_list_free(names);
+}
+
+#ifndef CONFIG_USER_ONLY
+
+/* Check for missing features that may prevent the CPU class from
+ * running using the current machine and accelerator.
+ */
+static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
+                                                 strList **list)
+{
+    strList **tail = list;
+    X86CPU *xc;
+    Error *err = NULL;
+
+    if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
+        QAPI_LIST_APPEND(tail, g_strdup("kvm"));
+        return;
+    }
+
+    xc = X86_CPU(object_new_with_class(OBJECT_CLASS(xcc)));
+
+    x86_cpu_expand_features(xc, &err);
+    if (err) {
+        /* Errors at x86_cpu_expand_features should never happen,
+         * but in case it does, just report the model as not
+         * runnable at all using the "type" property.
+         */
+        QAPI_LIST_APPEND(tail, g_strdup("type"));
+        error_free(err);
+    }
+
+    x86_cpu_filter_features(xc, false);
+
+    x86_cpu_list_feature_names(xc->filtered_features, tail);
+
+    object_unref(OBJECT(xc));
+}
+
+static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
+{
+    ObjectClass *oc = data;
+    X86CPUClass *cc = X86_CPU_CLASS(oc);
+    CpuDefinitionInfoList **cpu_list = user_data;
+    CpuDefinitionInfo *info;
+
+    info = g_malloc0(sizeof(*info));
+    info->name = x86_cpu_class_get_model_name(cc);
+    x86_cpu_class_check_missing_features(cc, &info->unavailable_features);
+    info->has_unavailable_features = true;
+    info->q_typename = g_strdup(object_class_get_name(oc));
+    info->migration_safe = cc->migration_safe;
+    info->has_migration_safe = true;
+    info->q_static = cc->static_model;
+    if (cc->model && cc->model->cpudef->deprecation_note) {
+        info->deprecated = true;
+    } else {
+        info->deprecated = false;
+    }
+    /*
+     * Old machine types won't report aliases, so that alias translation
+     * doesn't break compatibility with previous QEMU versions.
+     */
+    if (default_cpu_version != CPU_VERSION_LEGACY) {
+        info->alias_of = x86_cpu_class_get_alias_of(cc);
+    }
+
+    QAPI_LIST_PREPEND(*cpu_list, info);
+}
+
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+{
+    CpuDefinitionInfoList *cpu_list = NULL;
+    GSList *list = get_sorted_cpu_model_list();
+    g_slist_foreach(list, x86_cpu_definition_entry, &cpu_list);
+    g_slist_free(list);
+    return cpu_list;
+}
+
+#endif /* !CONFIG_USER_ONLY */
+
+uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
+{
+    FeatureWordInfo *wi = &feature_word_info[w];
+    uint64_t r = 0;
+    uint64_t unavail = 0;
+
+    if (kvm_enabled()) {
+        switch (wi->type) {
+        case CPUID_FEATURE_WORD:
+            r = kvm_arch_get_supported_cpuid(kvm_state, wi->cpuid.eax,
+                                                        wi->cpuid.ecx,
+                                                        wi->cpuid.reg);
+            break;
+        case MSR_FEATURE_WORD:
+            r = kvm_arch_get_supported_msr_feature(kvm_state,
+                        wi->msr.index);
+            break;
+        }
+    } else if (hvf_enabled()) {
+        if (wi->type != CPUID_FEATURE_WORD) {
+            return 0;
+        }
+        r = hvf_get_supported_cpuid(wi->cpuid.eax,
+                                    wi->cpuid.ecx,
+                                    wi->cpuid.reg);
+    } else if (tcg_enabled()) {
+        r = wi->tcg_features;
+    } else {
+        return ~0;
+    }
+
+    switch (w) {
+#ifndef TARGET_X86_64
+    case FEAT_8000_0001_EDX:
+        /*
+         * 32-bit TCG can emulate 64-bit compatibility mode.  If there is no
+         * way for userspace to get out of its 32-bit jail, we can leave
+         * the LM bit set.
+         */
+        unavail = tcg_enabled()
+            ? CPUID_EXT2_LM & ~CPUID_EXT2_KERNEL_FEATURES
+            : CPUID_EXT2_LM;
+        break;
+#endif
+
+    case FEAT_8000_0007_EBX:
+        if (cpu && !IS_AMD_CPU(&cpu->env)) {
+            /* Disable AMD machine check architecture for Intel CPU.  */
+            unavail = ~0;
+        }
+        break;
+
+    case FEAT_7_0_EBX:
+#ifndef CONFIG_USER_ONLY
+        if (!check_sgx_support()) {
+            unavail = CPUID_7_0_EBX_SGX;
+        }
+#endif
+        break;
+    case FEAT_7_0_ECX:
+#ifndef CONFIG_USER_ONLY
+        if (!check_sgx_support()) {
+            unavail = CPUID_7_0_ECX_SGX_LC;
+        }
+#endif
+        break;
+
+    default:
+        break;
+    }
+
+    r &= ~unavail;
+    if (cpu && cpu->migratable) {
+        r &= x86_cpu_get_migratable_flags(cpu, w);
+    }
+    return r;
+}
+
+static void x86_cpu_get_supported_cpuid(uint32_t func, uint32_t index,
+                                        uint32_t *eax, uint32_t *ebx,
+                                        uint32_t *ecx, uint32_t *edx)
+{
+    if (kvm_enabled()) {
+        *eax = kvm_arch_get_supported_cpuid(kvm_state, func, index, R_EAX);
+        *ebx = kvm_arch_get_supported_cpuid(kvm_state, func, index, R_EBX);
+        *ecx = kvm_arch_get_supported_cpuid(kvm_state, func, index, R_ECX);
+        *edx = kvm_arch_get_supported_cpuid(kvm_state, func, index, R_EDX);
+    } else if (hvf_enabled()) {
+        *eax = hvf_get_supported_cpuid(func, index, R_EAX);
+        *ebx = hvf_get_supported_cpuid(func, index, R_EBX);
+        *ecx = hvf_get_supported_cpuid(func, index, R_ECX);
+        *edx = hvf_get_supported_cpuid(func, index, R_EDX);
+    } else {
+        *eax = 0;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+    }
+}
+
+static void x86_cpu_get_cache_cpuid(uint32_t func, uint32_t index,
+                                    uint32_t *eax, uint32_t *ebx,
+                                    uint32_t *ecx, uint32_t *edx)
+{
+    uint32_t level, unused;
+
+    /* Only return valid host leaves.  */
+    switch (func) {
+    case 2:
+    case 4:
+        host_cpuid(0, 0, &level, &unused, &unused, &unused);
+        break;
+    case 0x80000005:
+    case 0x80000006:
+    case 0x8000001d:
+        host_cpuid(0x80000000, 0, &level, &unused, &unused, &unused);
+        break;
+    default:
+        return;
+    }
+
+    if (func > level) {
+        *eax = 0;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+    } else {
+        host_cpuid(func, index, eax, ebx, ecx, edx);
+    }
+}
+
+/*
+ * Only for builtin_x86_defs models initialized with x86_register_cpudef_types.
+ */
+void x86_cpu_apply_props(X86CPU *cpu, PropValue *props)
+{
+    PropValue *pv;
+    for (pv = props; pv->prop; pv++) {
+        if (!pv->value) {
+            continue;
+        }
+        object_property_parse(OBJECT(cpu), pv->prop, pv->value,
+                              &error_abort);
+    }
+}
+
+/*
+ * Apply properties for the CPU model version specified in model.
+ * Only for builtin_x86_defs models initialized with x86_register_cpudef_types.
+ */
+
+static void x86_cpu_apply_version_props(X86CPU *cpu, X86CPUModel *model)
+{
+    const X86CPUVersionDefinition *vdef;
+    X86CPUVersion version = x86_cpu_model_resolve_version(model);
+
+    if (version == CPU_VERSION_LEGACY) {
+        return;
+    }
+
+    for (vdef = x86_cpu_def_get_versions(model->cpudef); vdef->version; vdef++) {
+        PropValue *p;
+
+        for (p = vdef->props; p && p->prop; p++) {
+            object_property_parse(OBJECT(cpu), p->prop, p->value,
+                                  &error_abort);
+        }
+
+        if (vdef->version == version) {
+            break;
+        }
+    }
+
+    /*
+     * If we reached the end of the list, version number was invalid
+     */
+    assert(vdef->version == version);
+}
+
+static const CPUCaches *x86_cpu_get_versioned_cache_info(X86CPU *cpu,
+                                                         X86CPUModel *model)
+{
+    const X86CPUVersionDefinition *vdef;
+    X86CPUVersion version = x86_cpu_model_resolve_version(model);
+    const CPUCaches *cache_info = model->cpudef->cache_info;
+
+    if (version == CPU_VERSION_LEGACY) {
+        return cache_info;
+    }
+
+    for (vdef = x86_cpu_def_get_versions(model->cpudef); vdef->version; vdef++) {
+        if (vdef->cache_info) {
+            cache_info = vdef->cache_info;
+        }
+
+        if (vdef->version == version) {
+            break;
+        }
+    }
+
+    assert(vdef->version == version);
+    return cache_info;
+}
+
+/*
+ * Load data from X86CPUDefinition into a X86CPU object.
+ * Only for builtin_x86_defs models initialized with x86_register_cpudef_types.
+ */
+static void x86_cpu_load_model(X86CPU *cpu, X86CPUModel *model)
+{
+    const X86CPUDefinition *def = model->cpudef;
+    CPUX86State *env = &cpu->env;
+    FeatureWord w;
+
+    /*NOTE: any property set by this function should be returned by
+     * x86_cpu_static_props(), so static expansion of
+     * query-cpu-model-expansion is always complete.
+     */
+
+    /* CPU models only set _minimum_ values for level/xlevel: */
+    object_property_set_uint(OBJECT(cpu), "min-level", def->level,
+                             &error_abort);
+    object_property_set_uint(OBJECT(cpu), "min-xlevel", def->xlevel,
+                             &error_abort);
+
+    object_property_set_int(OBJECT(cpu), "family", def->family, &error_abort);
+    object_property_set_int(OBJECT(cpu), "model", def->model, &error_abort);
+    object_property_set_int(OBJECT(cpu), "stepping", def->stepping,
+                            &error_abort);
+    object_property_set_str(OBJECT(cpu), "model-id", def->model_id,
+                            &error_abort);
+    for (w = 0; w < FEATURE_WORDS; w++) {
+        env->features[w] = def->features[w];
+    }
+
+    /* legacy-cache defaults to 'off' if CPU model provides cache info */
+    cpu->legacy_cache = !x86_cpu_get_versioned_cache_info(cpu, model);
+
+    env->features[FEAT_1_ECX] |= CPUID_EXT_HYPERVISOR;
+
+    /* sysenter isn't supported in compatibility mode on AMD,
+     * syscall isn't supported in compatibility mode on Intel.
+     * Normally we advertise the actual CPU vendor, but you can
+     * override this using the 'vendor' property if you want to use
+     * KVM's sysenter/syscall emulation in compatibility mode and
+     * when doing cross vendor migration
+     */
+
+    /*
+     * vendor property is set here but then overloaded with the
+     * host cpu vendor for KVM and HVF.
+     */
+    object_property_set_str(OBJECT(cpu), "vendor", def->vendor, &error_abort);
+
+    object_property_set_uint(OBJECT(cpu), "avx10-version", def->avx10_version,
+                             &error_abort);
+
+    x86_cpu_apply_version_props(cpu, model);
+
+    /*
+     * Properties in versioned CPU model are not user specified features.
+     * We can simply clear env->user_features here since it will be filled later
+     * in x86_cpu_expand_features() based on plus_features and minus_features.
+     */
+    memset(&env->user_features, 0, sizeof(env->user_features));
+}
+
+static const gchar *x86_gdb_arch_name(CPUState *cs)
+{
+#ifdef TARGET_X86_64
+    return "i386:x86-64";
+#else
+    return "i386";
+#endif
+}
+
+static void x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
+{
+    X86CPUModel *model = data;
+    X86CPUClass *xcc = X86_CPU_CLASS(oc);
+    CPUClass *cc = CPU_CLASS(oc);
+
+    xcc->model = model;
+    xcc->migration_safe = true;
+    cc->deprecation_note = model->cpudef->deprecation_note;
+}
+
+static void x86_register_cpu_model_type(const char *name, X86CPUModel *model)
+{
+    g_autofree char *typename = x86_cpu_type_name(name);
+    TypeInfo ti = {
+        .name = typename,
+        .parent = TYPE_X86_CPU,
+        .class_init = x86_cpu_cpudef_class_init,
+        .class_data = model,
+    };
+
+    type_register(&ti);
+}
+
+
+/*
+ * register builtin_x86_defs;
+ * "max", "base" and subclasses ("host") are not registered here.
+ * See x86_cpu_register_types for all model registrations.
+ */
+static void x86_register_cpudef_types(const X86CPUDefinition *def)
+{
+    X86CPUModel *m;
+    const X86CPUVersionDefinition *vdef;
+
+    /* AMD aliases are handled at runtime based on CPUID vendor, so
+     * they shouldn't be set on the CPU model table.
+     */
+    assert(!(def->features[FEAT_8000_0001_EDX] & CPUID_EXT2_AMD_ALIASES));
+    /* catch mistakes instead of silently truncating model_id when too long */
+    assert(def->model_id && strlen(def->model_id) <= 48);
+
+    /* Unversioned model: */
+    m = g_new0(X86CPUModel, 1);
+    m->cpudef = def;
+    m->version = CPU_VERSION_AUTO;
+    m->is_alias = true;
+    x86_register_cpu_model_type(def->name, m);
+
+    /* Versioned models: */
+
+    for (vdef = x86_cpu_def_get_versions(def); vdef->version; vdef++) {
+        g_autofree char *name =
+            x86_cpu_versioned_model_name(def, vdef->version);
+
+        m = g_new0(X86CPUModel, 1);
+        m->cpudef = def;
+        m->version = vdef->version;
+        m->note = vdef->note;
+        x86_register_cpu_model_type(name, m);
+
+        if (vdef->alias) {
+            X86CPUModel *am = g_new0(X86CPUModel, 1);
+            am->cpudef = def;
+            am->version = vdef->version;
+            am->is_alias = true;
+            x86_register_cpu_model_type(vdef->alias, am);
+        }
+    }
+
+}
+
+uint32_t cpu_x86_virtual_addr_width(CPUX86State *env)
+{
+    if  (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_LA57) {
+        return 57; /* 57 bits virtual */
+    } else {
+        return 48; /* 48 bits virtual */
+    }
+}
+
+void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
+                   uint32_t *eax, uint32_t *ebx,
+                   uint32_t *ecx, uint32_t *edx)
+{
+    X86CPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
+    uint32_t limit;
+    uint32_t signature[3];
+    X86CPUTopoInfo topo_info;
+    uint32_t cores_per_pkg;
+    uint32_t threads_per_pkg;
+
+    topo_info.dies_per_pkg = env->nr_dies;
+    topo_info.modules_per_die = env->nr_modules;
+    topo_info.cores_per_module = cs->nr_cores / env->nr_dies / env->nr_modules;
+    topo_info.threads_per_core = cs->nr_threads;
+
+    cores_per_pkg = topo_info.cores_per_module * topo_info.modules_per_die *
+                    topo_info.dies_per_pkg;
+    threads_per_pkg = cores_per_pkg * topo_info.threads_per_core;
+
+    /* Calculate & apply limits for different index ranges */
+    if (index >= 0xC0000000) {
+        limit = env->cpuid_xlevel2;
+    } else if (index >= 0x80000000) {
+        limit = env->cpuid_xlevel;
+    } else if (index >= 0x40000000) {
+        limit = 0x40000001;
+    } else {
+        limit = env->cpuid_level;
+    }
+
+    if (index > limit) {
+        /* Intel documentation states that invalid EAX input will
+         * return the same information as EAX=cpuid_level
+         * (Intel SDM Vol. 2A - Instruction Set Reference - CPUID)
+         */
+        index = env->cpuid_level;
+    }
+
+    switch(index) {
+    case 0:
+        *eax = env->cpuid_level;
+        *ebx = env->cpuid_vendor1;
+        *edx = env->cpuid_vendor2;
+        *ecx = env->cpuid_vendor3;
+        break;
+    case 1:
+        *eax = env->cpuid_version;
+        *ebx = (cpu->apic_id << 24) |
+               8 << 8; /* CLFLUSH size in quad words, Linux wants it. */
+        *ecx = env->features[FEAT_1_ECX];
+        if ((*ecx & CPUID_EXT_XSAVE) && (env->cr[4] & CR4_OSXSAVE_MASK)) {
+            *ecx |= CPUID_EXT_OSXSAVE;
+        }
+        *edx = env->features[FEAT_1_EDX];
+        if (threads_per_pkg > 1) {
+            *ebx |= threads_per_pkg << 16;
+            *edx |= CPUID_HT;
+        }
+        if (!cpu->enable_pmu) {
+            *ecx &= ~CPUID_EXT_PDCM;
+        }
+        break;
+    case 2:
+        /* cache info: needed for Pentium Pro compatibility */
+        if (cpu->cache_info_passthrough) {
+            x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
+            break;
+        } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
+            *eax = *ebx = *ecx = *edx = 0;
+            break;
+        }
+        *eax = 1; /* Number of CPUID[EAX=2] calls required */
+        *ebx = 0;
+        if (!cpu->enable_l3_cache) {
+            *ecx = 0;
+        } else {
+            *ecx = cpuid2_cache_descriptor(env->cache_info_cpuid2.l3_cache);
+        }
+        *edx = (cpuid2_cache_descriptor(env->cache_info_cpuid2.l1d_cache) << 16) |
+               (cpuid2_cache_descriptor(env->cache_info_cpuid2.l1i_cache) <<  8) |
+               (cpuid2_cache_descriptor(env->cache_info_cpuid2.l2_cache));
+        break;
+    case 4:
+        /* cache info: needed for Core compatibility */
+        if (cpu->cache_info_passthrough) {
+            x86_cpu_get_cache_cpuid(index, count, eax, ebx, ecx, edx);
+            /*
+             * QEMU has its own number of cores/logical cpus,
+             * set 24..14, 31..26 bit to configured values
+             */
+            if (*eax & 31) {
+                int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
+
+                *eax &= ~0xFC000000;
+                *eax |= max_core_ids_in_package(&topo_info) << 26;
+                if (host_vcpus_per_cache > threads_per_pkg) {
+                    *eax &= ~0x3FFC000;
+
+                    /* Share the cache at package level. */
+                    *eax |= max_thread_ids_for_cache(&topo_info,
+                                CPU_TOPOLOGY_LEVEL_SOCKET) << 14;
+                }
+            }
+        } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
+            *eax = *ebx = *ecx = *edx = 0;
+        } else {
+            *eax = 0;
+
+            switch (count) {
+            case 0: /* L1 dcache info */
+                encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
+                                    &topo_info,
+                                    eax, ebx, ecx, edx);
+                if (!cpu->l1_cache_per_core) {
+                    *eax &= ~MAKE_64BIT_MASK(14, 12);
+                }
+                break;
+            case 1: /* L1 icache info */
+                encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
+                                    &topo_info,
+                                    eax, ebx, ecx, edx);
+                if (!cpu->l1_cache_per_core) {
+                    *eax &= ~MAKE_64BIT_MASK(14, 12);
+                }
+                break;
+            case 2: /* L2 cache info */
+                encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
+                                    &topo_info,
+                                    eax, ebx, ecx, edx);
+                break;
+            case 3: /* L3 cache info */
+                if (cpu->enable_l3_cache) {
+                    encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
+                                        &topo_info,
+                                        eax, ebx, ecx, edx);
+                    break;
+                }
+                /* fall through */
+            default: /* end of info */
+                *eax = *ebx = *ecx = *edx = 0;
+                break;
+            }
+        }
+        break;
+    case 5:
+        /* MONITOR/MWAIT Leaf */
+        *eax = cpu->mwait.eax; /* Smallest monitor-line size in bytes */
+        *ebx = cpu->mwait.ebx; /* Largest monitor-line size in bytes */
+        *ecx = cpu->mwait.ecx; /* flags */
+        *edx = cpu->mwait.edx; /* mwait substates */
+        break;
+    case 6:
+        /* Thermal and Power Leaf */
+        *eax = env->features[FEAT_6_EAX];
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+        break;
+    case 7:
+        /* Structured Extended Feature Flags Enumeration Leaf */
+        if (count == 0) {
+            /* Maximum ECX value for sub-leaves */
+            *eax = env->cpuid_level_func7;
+            *ebx = env->features[FEAT_7_0_EBX]; /* Feature flags */
+            *ecx = env->features[FEAT_7_0_ECX]; /* Feature flags */
+            if ((*ecx & CPUID_7_0_ECX_PKU) && env->cr[4] & CR4_PKE_MASK) {
+                *ecx |= CPUID_7_0_ECX_OSPKE;
+            }
+            *edx = env->features[FEAT_7_0_EDX]; /* Feature flags */
+        } else if (count == 1) {
+            *eax = env->features[FEAT_7_1_EAX];
+            *edx = env->features[FEAT_7_1_EDX];
+            *ebx = 0;
+            *ecx = 0;
+        } else if (count == 2) {
+            *edx = env->features[FEAT_7_2_EDX];
+            *eax = 0;
+            *ebx = 0;
+            *ecx = 0;
+        } else {
+            *eax = 0;
+            *ebx = 0;
+            *ecx = 0;
+            *edx = 0;
+        }
+        break;
+    case 9:
+        /* Direct Cache Access Information Leaf */
+        *eax = 0; /* Bits 0-31 in DCA_CAP MSR */
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+        break;
+    case 0xA:
+        /* Architectural Performance Monitoring Leaf */
+        if (cpu->enable_pmu) {
+            x86_cpu_get_supported_cpuid(0xA, count, eax, ebx, ecx, edx);
+        } else {
+            *eax = 0;
+            *ebx = 0;
+            *ecx = 0;
+            *edx = 0;
+        }
+        break;
+    case 0xB:
+        /* Extended Topology Enumeration Leaf */
+        if (!cpu->enable_cpuid_0xb) {
+                *eax = *ebx = *ecx = *edx = 0;
+                break;
+        }
+
+        *ecx = count & 0xff;
+        *edx = cpu->apic_id;
+
+        switch (count) {
+        case 0:
+            *eax = apicid_core_offset(&topo_info);
+            *ebx = topo_info.threads_per_core;
+            *ecx |= CPUID_B_ECX_TOPO_LEVEL_SMT << 8;
+            break;
+        case 1:
+            *eax = apicid_pkg_offset(&topo_info);
+            *ebx = threads_per_pkg;
+            *ecx |= CPUID_B_ECX_TOPO_LEVEL_CORE << 8;
+            break;
+        default:
+            *eax = 0;
+            *ebx = 0;
+            *ecx |= CPUID_B_ECX_TOPO_LEVEL_INVALID << 8;
+        }
+
+        assert(!(*eax & ~0x1f));
+        *ebx &= 0xffff; /* The count doesn't need to be reliable. */
+        break;
+    case 0x1C:
+        if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
+            x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);
+            *edx = 0;
+        }
+        break;
+    case 0x1F:
+        /* V2 Extended Topology Enumeration Leaf */
+        if (!x86_has_extended_topo(env->avail_cpu_topo)) {
+            *eax = *ebx = *ecx = *edx = 0;
+            break;
+        }
+
+        encode_topo_cpuid1f(env, count, &topo_info, eax, ebx, ecx, edx);
+        break;
+    case 0xD: {
+        /* Processor Extended State */
+        *eax = 0;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+        if (!(env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE)) {
+            break;
+        }
+
+        if (count == 0) {
+            *ecx = xsave_area_size(x86_cpu_xsave_xcr0_components(cpu), false);
+            *eax = env->features[FEAT_XSAVE_XCR0_LO];
+            *edx = env->features[FEAT_XSAVE_XCR0_HI];
+            /*
+             * The initial value of xcr0 and ebx == 0, On host without kvm
+             * commit 412a3c41(e.g., CentOS 6), the ebx's value always == 0
+             * even through guest update xcr0, this will crash some legacy guest
+             * (e.g., CentOS 6), So set ebx == ecx to workaround it.
+             */
+            *ebx = kvm_enabled() ? *ecx : xsave_area_size(env->xcr0, false);
+        } else if (count == 1) {
+            uint64_t xstate = x86_cpu_xsave_xcr0_components(cpu) |
+                              x86_cpu_xsave_xss_components(cpu);
+
+            *eax = env->features[FEAT_XSAVE];
+            *ebx = xsave_area_size(xstate, true);
+            *ecx = env->features[FEAT_XSAVE_XSS_LO];
+            *edx = env->features[FEAT_XSAVE_XSS_HI];
+            if (kvm_enabled() && cpu->enable_pmu &&
+                (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR) &&
+                (*eax & CPUID_XSAVE_XSAVES)) {
+                *ecx |= XSTATE_ARCH_LBR_MASK;
+            } else {
+                *ecx &= ~XSTATE_ARCH_LBR_MASK;
+            }
+        } else if (count == 0xf && cpu->enable_pmu
+                   && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
+            x86_cpu_get_supported_cpuid(0xD, count, eax, ebx, ecx, edx);
+        } else if (count < ARRAY_SIZE(x86_ext_save_areas)) {
+            const ExtSaveArea *esa = &x86_ext_save_areas[count];
+
+            if (x86_cpu_xsave_xcr0_components(cpu) & (1ULL << count)) {
+                *eax = esa->size;
+                *ebx = esa->offset;
+                *ecx = esa->ecx &
+                       (ESA_FEATURE_ALIGN64_MASK | ESA_FEATURE_XFD_MASK);
+            } else if (x86_cpu_xsave_xss_components(cpu) & (1ULL << count)) {
+                *eax = esa->size;
+                *ebx = 0;
+                *ecx = 1;
+            }
+        }
+        break;
+    }
+    case 0x12:
+#ifndef CONFIG_USER_ONLY
+        if (!kvm_enabled() ||
+            !(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_SGX)) {
+            *eax = *ebx = *ecx = *edx = 0;
+            break;
+        }
+
+        /*
+         * SGX sub-leafs CPUID.0x12.{0x2..N} enumerate EPC sections.  Retrieve
+         * the EPC properties, e.g. confidentiality and integrity, from the
+         * host's first EPC section, i.e. assume there is one EPC section or
+         * that all EPC sections have the same security properties.
+         */
+        if (count > 1) {
+            uint64_t epc_addr, epc_size;
+
+            if (sgx_epc_get_section(count - 2, &epc_addr, &epc_size)) {
+                *eax = *ebx = *ecx = *edx = 0;
+                break;
+            }
+            host_cpuid(index, 2, eax, ebx, ecx, edx);
+            *eax = (uint32_t)(epc_addr & 0xfffff000) | 0x1;
+            *ebx = (uint32_t)(epc_addr >> 32);
+            *ecx = (uint32_t)(epc_size & 0xfffff000) | (*ecx & 0xf);
+            *edx = (uint32_t)(epc_size >> 32);
+            break;
+        }
+
+        /*
+         * SGX sub-leafs CPUID.0x12.{0x0,0x1} are heavily dependent on hardware
+         * and KVM, i.e. QEMU cannot emulate features to override what KVM
+         * supports.  Features can be further restricted by userspace, but not
+         * made more permissive.
+         */
+        x86_cpu_get_supported_cpuid(0x12, count, eax, ebx, ecx, edx);
+
+        if (count == 0) {
+            *eax &= env->features[FEAT_SGX_12_0_EAX];
+            *ebx &= env->features[FEAT_SGX_12_0_EBX];
+        } else {
+            *eax &= env->features[FEAT_SGX_12_1_EAX];
+            *ebx &= 0; /* ebx reserve */
+            *ecx &= env->features[FEAT_XSAVE_XCR0_LO];
+            *edx &= env->features[FEAT_XSAVE_XCR0_HI];
+
+            /* FP and SSE are always allowed regardless of XSAVE/XCR0. */
+            *ecx |= XSTATE_FP_MASK | XSTATE_SSE_MASK;
+
+            /* Access to PROVISIONKEY requires additional credentials. */
+            if ((*eax & (1U << 4)) &&
+                !kvm_enable_sgx_provisioning(cs->kvm_state)) {
+                *eax &= ~(1U << 4);
+            }
+        }
+#endif
+        break;
+    case 0x14: {
+        /* Intel Processor Trace Enumeration */
+        *eax = 0;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+        if (!(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) ||
+            !kvm_enabled()) {
+            break;
+        }
+
+        /*
+         * If these are changed, they should stay in sync with
+         * x86_cpu_filter_features().
+         */
+        if (count == 0) {
+            *eax = INTEL_PT_MAX_SUBLEAF;
+            *ebx = INTEL_PT_MINIMAL_EBX;
+            *ecx = INTEL_PT_MINIMAL_ECX;
+            if (env->features[FEAT_14_0_ECX] & CPUID_14_0_ECX_LIP) {
+                *ecx |= CPUID_14_0_ECX_LIP;
+            }
+        } else if (count == 1) {
+            *eax = INTEL_PT_MTC_BITMAP | INTEL_PT_ADDR_RANGES_NUM;
+            *ebx = INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP;
+        }
+        break;
+    }
+    case 0x1D: {
+        /* AMX TILE, for now hardcoded for Sapphire Rapids*/
+        *eax = 0;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+        if (!(env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_AMX_TILE)) {
+            break;
+        }
+
+        if (count == 0) {
+            /* Highest numbered palette subleaf */
+            *eax = INTEL_AMX_TILE_MAX_SUBLEAF;
+        } else if (count == 1) {
+            *eax = INTEL_AMX_TOTAL_TILE_BYTES |
+                   (INTEL_AMX_BYTES_PER_TILE << 16);
+            *ebx = INTEL_AMX_BYTES_PER_ROW | (INTEL_AMX_TILE_MAX_NAMES << 16);
+            *ecx = INTEL_AMX_TILE_MAX_ROWS;
+        }
+        break;
+    }
+    case 0x1E: {
+        /* AMX TMUL, for now hardcoded for Sapphire Rapids */
+        *eax = 0;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+        if (!(env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_AMX_TILE)) {
+            break;
+        }
+
+        if (count == 0) {
+            /* Highest numbered palette subleaf */
+            *ebx = INTEL_AMX_TMUL_MAX_K | (INTEL_AMX_TMUL_MAX_N << 8);
+        }
+        break;
+    }
+    case 0x24: {
+        *eax = 0;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+        if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && count == 0) {
+            *ebx = env->features[FEAT_24_0_EBX] | env->avx10_version;
+        }
+        break;
+    }
+    case 0x40000000:
+        /*
+         * CPUID code in kvm_arch_init_vcpu() ignores stuff
+         * set here, but we restrict to TCG none the less.
+         */
+        if (tcg_enabled() && cpu->expose_tcg) {
+            memcpy(signature, "TCGTCGTCGTCG", 12);
+            *eax = 0x40000001;
+            *ebx = signature[0];
+            *ecx = signature[1];
+            *edx = signature[2];
+        } else {
+            *eax = 0;
+            *ebx = 0;
+            *ecx = 0;
+            *edx = 0;
+        }
+        break;
+    case 0x40000001:
+        *eax = 0;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+        break;
+    case 0x80000000:
+        *eax = env->cpuid_xlevel;
+        *ebx = env->cpuid_vendor1;
+        *edx = env->cpuid_vendor2;
+        *ecx = env->cpuid_vendor3;
+        break;
+    case 0x80000001:
+        *eax = env->cpuid_version;
+        *ebx = 0;
+        *ecx = env->features[FEAT_8000_0001_ECX];
+        *edx = env->features[FEAT_8000_0001_EDX];
+
+        /* The Linux kernel checks for the CMPLegacy bit and
+         * discards multiple thread information if it is set.
+         * So don't set it here for Intel to make Linux guests happy.
+         */
+        if (threads_per_pkg > 1) {
+            if (env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1 ||
+                env->cpuid_vendor2 != CPUID_VENDOR_INTEL_2 ||
+                env->cpuid_vendor3 != CPUID_VENDOR_INTEL_3) {
+                *ecx |= 1 << 1;    /* CmpLegacy bit */
+            }
+        }
+        if (tcg_enabled() && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 &&
+            !(env->hflags & HF_LMA_MASK)) {
+            *edx &= ~CPUID_EXT2_SYSCALL;
+        }
+        break;
+    case 0x80000002:
+    case 0x80000003:
+    case 0x80000004:
+        *eax = env->cpuid_model[(index - 0x80000002) * 4 + 0];
+        *ebx = env->cpuid_model[(index - 0x80000002) * 4 + 1];
+        *ecx = env->cpuid_model[(index - 0x80000002) * 4 + 2];
+        *edx = env->cpuid_model[(index - 0x80000002) * 4 + 3];
+        break;
+    case 0x80000005:
+        /* cache info (L1 cache) */
+        if (cpu->cache_info_passthrough) {
+            x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
+            break;
+        }
+        *eax = (L1_DTLB_2M_ASSOC << 24) | (L1_DTLB_2M_ENTRIES << 16) |
+               (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
+        *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |
+               (L1_ITLB_4K_ASSOC <<  8) | (L1_ITLB_4K_ENTRIES);
+        *ecx = encode_cache_cpuid80000005(env->cache_info_amd.l1d_cache);
+        *edx = encode_cache_cpuid80000005(env->cache_info_amd.l1i_cache);
+        break;
+    case 0x80000006:
+        /* cache info (L2 cache) */
+        if (cpu->cache_info_passthrough) {
+            x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
+            break;
+        }
+        *eax = (AMD_ENC_ASSOC(L2_DTLB_2M_ASSOC) << 28) |
+               (L2_DTLB_2M_ENTRIES << 16) |
+               (AMD_ENC_ASSOC(L2_ITLB_2M_ASSOC) << 12) |
+               (L2_ITLB_2M_ENTRIES);
+        *ebx = (AMD_ENC_ASSOC(L2_DTLB_4K_ASSOC) << 28) |
+               (L2_DTLB_4K_ENTRIES << 16) |
+               (AMD_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) |
+               (L2_ITLB_4K_ENTRIES);
+        encode_cache_cpuid80000006(env->cache_info_amd.l2_cache,
+                                   cpu->enable_l3_cache ?
+                                   env->cache_info_amd.l3_cache : NULL,
+                                   ecx, edx);
+        break;
+    case 0x80000007:
+        *eax = 0;
+        *ebx = env->features[FEAT_8000_0007_EBX];
+        *ecx = 0;
+        *edx = env->features[FEAT_8000_0007_EDX];
+        break;
+    case 0x80000008:
+        /* virtual & phys address size in low 2 bytes. */
+        *eax = cpu->phys_bits;
+        if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
+            /* 64 bit processor */
+             *eax |= (cpu_x86_virtual_addr_width(env) << 8);
+             *eax |= (cpu->guest_phys_bits << 16);
+        }
+        *ebx = env->features[FEAT_8000_0008_EBX];
+        if (threads_per_pkg > 1) {
+            /*
+             * Bits 15:12 is "The number of bits in the initial
+             * Core::X86::Apic::ApicId[ApicId] value that indicate
+             * thread ID within a package".
+             * Bits 7:0 is "The number of threads in the package is NC+1"
+             */
+            *ecx = (apicid_pkg_offset(&topo_info) << 12) |
+                   (threads_per_pkg - 1);
+        } else {
+            *ecx = 0;
+        }
+        *edx = 0;
+        break;
+    case 0x8000000A:
+        if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
+            *eax = 0x00000001; /* SVM Revision */
+            *ebx = 0x00000010; /* nr of ASIDs */
+            *ecx = 0;
+            *edx = env->features[FEAT_SVM]; /* optional features */
+        } else {
+            *eax = 0;
+            *ebx = 0;
+            *ecx = 0;
+            *edx = 0;
+        }
+        break;
+    case 0x8000001D:
+        *eax = 0;
+        if (cpu->cache_info_passthrough) {
+            x86_cpu_get_cache_cpuid(index, count, eax, ebx, ecx, edx);
+            break;
+        }
+        switch (count) {
+        case 0: /* L1 dcache info */
+            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache,
+                                       &topo_info, eax, ebx, ecx, edx);
+            break;
+        case 1: /* L1 icache info */
+            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache,
+                                       &topo_info, eax, ebx, ecx, edx);
+            break;
+        case 2: /* L2 cache info */
+            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache,
+                                       &topo_info, eax, ebx, ecx, edx);
+            break;
+        case 3: /* L3 cache info */
+            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache,
+                                       &topo_info, eax, ebx, ecx, edx);
+            break;
+        default: /* end of info */
+            *eax = *ebx = *ecx = *edx = 0;
+            break;
+        }
+        if (cpu->amd_topoext_features_only) {
+            *edx &= CACHE_NO_INVD_SHARING | CACHE_INCLUSIVE;
+        }
+        break;
+    case 0x8000001E:
+        if (cpu->core_id <= 255) {
+            encode_topo_cpuid8000001e(cpu, &topo_info, eax, ebx, ecx, edx);
+        } else {
+            *eax = 0;
+            *ebx = 0;
+            *ecx = 0;
+            *edx = 0;
+        }
+        break;
+    case 0x80000022:
+        *eax = *ebx = *ecx = *edx = 0;
+        /* AMD Extended Performance Monitoring and Debug */
+        if (kvm_enabled() && cpu->enable_pmu &&
+            (env->features[FEAT_8000_0022_EAX] & CPUID_8000_0022_EAX_PERFMON_V2)) {
+            *eax |= CPUID_8000_0022_EAX_PERFMON_V2;
+            *ebx |= kvm_arch_get_supported_cpuid(cs->kvm_state, index, count,
+                                                 R_EBX) & 0xf;
+        }
+        break;
+    case 0xC0000000:
+        *eax = env->cpuid_xlevel2;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+        break;
+    case 0xC0000001:
+        /* Support for VIA CPU's CPUID instruction */
+        *eax = env->cpuid_version;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = env->features[FEAT_C000_0001_EDX];
+        break;
+    case 0xC0000002:
+    case 0xC0000003:
+    case 0xC0000004:
+        /* Reserved for the future, and now filled with zero */
+        *eax = 0;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+        break;
+    case 0x8000001F:
+        *eax = *ebx = *ecx = *edx = 0;
+        if (sev_enabled()) {
+            *eax = 0x2;
+            *eax |= sev_es_enabled() ? 0x8 : 0;
+            *eax |= sev_snp_enabled() ? 0x10 : 0;
+            *ebx = sev_get_cbit_position() & 0x3f; /* EBX[5:0] */
+            *ebx |= (sev_get_reduced_phys_bits() & 0x3f) << 6; /* EBX[11:6] */
+        }
+        break;
+    case 0x80000021:
+        *eax = *ebx = *ecx = *edx = 0;
+        *eax = env->features[FEAT_8000_0021_EAX];
+        *ebx = env->features[FEAT_8000_0021_EBX];
+        break;
+    default:
+        /* reserved values: zero */
+        *eax = 0;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+        break;
+    }
+}
+
+static void x86_cpu_set_sgxlepubkeyhash(CPUX86State *env)
+{
+#ifndef CONFIG_USER_ONLY
+    /* Those default values are defined in Skylake HW */
+    env->msr_ia32_sgxlepubkeyhash[0] = 0xa6053e051270b7acULL;
+    env->msr_ia32_sgxlepubkeyhash[1] = 0x6cfbe8ba8b3b413dULL;
+    env->msr_ia32_sgxlepubkeyhash[2] = 0xc4916d99f2b3735dULL;
+    env->msr_ia32_sgxlepubkeyhash[3] = 0xd4f8c05909f9bb3bULL;
+#endif
+}
+
+static bool cpuid_has_xsave_feature(CPUX86State *env, const ExtSaveArea *esa)
+{
+    if (!esa->size) {
+        return false;
+    }
+
+    if (env->features[esa->feature] & esa->bits) {
+        return true;
+    }
+    if (esa->feature == FEAT_7_0_EBX && esa->bits == CPUID_7_0_EBX_AVX512F
+        && (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10)) {
+        return true;
+    }
+
+    return false;
+}
+
+static void x86_cpu_reset_hold(Object *obj, ResetType type)
+{
+    CPUState *cs = CPU(obj);
+    X86CPU *cpu = X86_CPU(cs);
+    X86CPUClass *xcc = X86_CPU_GET_CLASS(obj);
+    CPUX86State *env = &cpu->env;
+    target_ulong cr4;
+    uint64_t xcr0;
+    int i;
+
+    if (xcc->parent_phases.hold) {
+        xcc->parent_phases.hold(obj, type);
+    }
+
+    memset(env, 0, offsetof(CPUX86State, end_reset_fields));
+
+    if (tcg_enabled()) {
+        cpu_init_fp_statuses(env);
+    }
+
+    env->old_exception = -1;
+
+    /* init to reset state */
+    env->int_ctl = 0;
+    env->hflags2 |= HF2_GIF_MASK;
+    env->hflags2 |= HF2_VGIF_MASK;
+    env->hflags &= ~HF_GUEST_MASK;
+
+    cpu_x86_update_cr0(env, 0x60000010);
+    env->a20_mask = ~0x0;
+    env->smbase = 0x30000;
+    env->msr_smi_count = 0;
+
+    env->idt.limit = 0xffff;
+    env->gdt.limit = 0xffff;
+    env->ldt.limit = 0xffff;
+    env->ldt.flags = DESC_P_MASK | (2 << DESC_TYPE_SHIFT);
+    env->tr.limit = 0xffff;
+    env->tr.flags = DESC_P_MASK | (11 << DESC_TYPE_SHIFT);
+
+    cpu_x86_load_seg_cache(env, R_CS, 0xf000, 0xffff0000, 0xffff,
+                           DESC_P_MASK | DESC_S_MASK | DESC_CS_MASK |
+                           DESC_R_MASK | DESC_A_MASK);
+    cpu_x86_load_seg_cache(env, R_DS, 0, 0, 0xffff,
+                           DESC_P_MASK | DESC_S_MASK | DESC_W_MASK |
+                           DESC_A_MASK);
+    cpu_x86_load_seg_cache(env, R_ES, 0, 0, 0xffff,
+                           DESC_P_MASK | DESC_S_MASK | DESC_W_MASK |
+                           DESC_A_MASK);
+    cpu_x86_load_seg_cache(env, R_SS, 0, 0, 0xffff,
+                           DESC_P_MASK | DESC_S_MASK | DESC_W_MASK |
+                           DESC_A_MASK);
+    cpu_x86_load_seg_cache(env, R_FS, 0, 0, 0xffff,
+                           DESC_P_MASK | DESC_S_MASK | DESC_W_MASK |
+                           DESC_A_MASK);
+    cpu_x86_load_seg_cache(env, R_GS, 0, 0, 0xffff,
+                           DESC_P_MASK | DESC_S_MASK | DESC_W_MASK |
+                           DESC_A_MASK);
+
+    env->eip = 0xfff0;
+    env->regs[R_EDX] = env->cpuid_version;
+
+    env->eflags = 0x2;
+
+    /* FPU init */
+    for (i = 0; i < 8; i++) {
+        env->fptags[i] = 1;
+    }
+    cpu_set_fpuc(env, 0x37f);
+
+    env->mxcsr = 0x1f80;
+    /* All units are in INIT state.  */
+    env->xstate_bv = 0;
+
+    env->pat = 0x0007040600070406ULL;
+
+    if (kvm_enabled()) {
+        /*
+         * KVM handles TSC = 0 specially and thinks we are hot-plugging
+         * a new CPU, use 1 instead to force a reset.
+         */
+        if (env->tsc != 0) {
+            env->tsc = 1;
+        }
+    } else {
+        env->tsc = 0;
+    }
+
+    env->msr_ia32_misc_enable = MSR_IA32_MISC_ENABLE_DEFAULT;
+    if (env->features[FEAT_1_ECX] & CPUID_EXT_MONITOR) {
+        env->msr_ia32_misc_enable |= MSR_IA32_MISC_ENABLE_MWAIT;
+    }
+
+    memset(env->dr, 0, sizeof(env->dr));
+    env->dr[6] = DR6_FIXED_1;
+    env->dr[7] = DR7_FIXED_1;
+    cpu_breakpoint_remove_all(cs, BP_CPU);
+    cpu_watchpoint_remove_all(cs, BP_CPU);
+
+    cr4 = 0;
+    xcr0 = XSTATE_FP_MASK;
+
+#ifdef CONFIG_USER_ONLY
+    /* Enable all the features for user-mode.  */
+    if (env->features[FEAT_1_EDX] & CPUID_SSE) {
+        xcr0 |= XSTATE_SSE_MASK;
+    }
+    for (i = 2; i < ARRAY_SIZE(x86_ext_save_areas); i++) {
+        const ExtSaveArea *esa = &x86_ext_save_areas[i];
+        if (!((1 << i) & CPUID_XSTATE_XCR0_MASK)) {
+            continue;
+        }
+        if (cpuid_has_xsave_feature(env, esa)) {
+            xcr0 |= 1ull << i;
+        }
+    }
+
+    if (env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE) {
+        cr4 |= CR4_OSFXSR_MASK | CR4_OSXSAVE_MASK;
+    }
+    if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_FSGSBASE) {
+        cr4 |= CR4_FSGSBASE_MASK;
+    }
+#endif
+
+    env->xcr0 = xcr0;
+    cpu_x86_update_cr4(env, cr4);
+
+    /*
+     * SDM 11.11.5 requires:
+     *  - IA32_MTRR_DEF_TYPE MSR.E = 0
+     *  - IA32_MTRR_PHYSMASKn.V = 0
+     * All other bits are undefined.  For simplification, zero it all.
+     */
+    env->mtrr_deftype = 0;
+    memset(env->mtrr_var, 0, sizeof(env->mtrr_var));
+    memset(env->mtrr_fixed, 0, sizeof(env->mtrr_fixed));
+
+    env->interrupt_injected = -1;
+    env->exception_nr = -1;
+    env->exception_pending = 0;
+    env->exception_injected = 0;
+    env->exception_has_payload = false;
+    env->exception_payload = 0;
+    env->nmi_injected = false;
+    env->triple_fault_pending = false;
+#if !defined(CONFIG_USER_ONLY)
+    /* We hard-wire the BSP to the first CPU. */
+    apic_designate_bsp(cpu->apic_state, cs->cpu_index == 0);
+
+    cs->halted = !cpu_is_bsp(cpu);
+
+    if (kvm_enabled()) {
+        kvm_arch_reset_vcpu(cpu);
+    }
+
+    x86_cpu_set_sgxlepubkeyhash(env);
+
+    env->amd_tsc_scale_msr =  MSR_AMD64_TSC_RATIO_DEFAULT;
+
+#endif
+}
+
+void x86_cpu_after_reset(X86CPU *cpu)
+{
+#ifndef CONFIG_USER_ONLY
+    if (kvm_enabled()) {
+        kvm_arch_after_reset_vcpu(cpu);
+    }
+
+    if (cpu->apic_state) {
+        device_cold_reset(cpu->apic_state);
+    }
+#endif
+}
+
+static void mce_init(X86CPU *cpu)
+{
+    CPUX86State *cenv = &cpu->env;
+    unsigned int bank;
+
+    if (((cenv->cpuid_version >> 8) & 0xf) >= 6
+        && (cenv->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) ==
+            (CPUID_MCE | CPUID_MCA)) {
+        cenv->mcg_cap = MCE_CAP_DEF | MCE_BANKS_DEF |
+                        (cpu->enable_lmce ? MCG_LMCE_P : 0);
+        cenv->mcg_ctl = ~(uint64_t)0;
+        for (bank = 0; bank < MCE_BANKS_DEF; bank++) {
+            cenv->mce_banks[bank * 4] = ~(uint64_t)0;
+        }
+    }
+}
+
+static void x86_cpu_adjust_level(X86CPU *cpu, uint32_t *min, uint32_t value)
+{
+    if (*min < value) {
+        *min = value;
+    }
+}
+
+/* Increase cpuid_min_{level,xlevel,xlevel2} automatically, if appropriate */
+static void x86_cpu_adjust_feat_level(X86CPU *cpu, FeatureWord w)
+{
+    CPUX86State *env = &cpu->env;
+    FeatureWordInfo *fi = &feature_word_info[w];
+    uint32_t eax = fi->cpuid.eax;
+    uint32_t region = eax & 0xF0000000;
+
+    assert(feature_word_info[w].type == CPUID_FEATURE_WORD);
+    if (!env->features[w]) {
+        return;
+    }
+
+    switch (region) {
+    case 0x00000000:
+        x86_cpu_adjust_level(cpu, &env->cpuid_min_level, eax);
+    break;
+    case 0x80000000:
+        x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, eax);
+    break;
+    case 0xC0000000:
+        x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel2, eax);
+    break;
+    }
+
+    if (eax == 7) {
+        x86_cpu_adjust_level(cpu, &env->cpuid_min_level_func7,
+                             fi->cpuid.ecx);
+    }
+}
+
+/* Calculate XSAVE components based on the configured CPU feature flags */
+static void x86_cpu_enable_xsave_components(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+    int i;
+    uint64_t mask;
+    static bool request_perm;
+
+    if (!(env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE)) {
+        env->features[FEAT_XSAVE_XCR0_LO] = 0;
+        env->features[FEAT_XSAVE_XCR0_HI] = 0;
+        env->features[FEAT_XSAVE_XSS_LO] = 0;
+        env->features[FEAT_XSAVE_XSS_HI] = 0;
+        return;
+    }
+
+    mask = 0;
+    for (i = 0; i < ARRAY_SIZE(x86_ext_save_areas); i++) {
+        const ExtSaveArea *esa = &x86_ext_save_areas[i];
+        if (cpuid_has_xsave_feature(env, esa)) {
+            mask |= (1ULL << i);
+        }
+    }
+
+    /* Only request permission for first vcpu */
+    if (kvm_enabled() && !request_perm) {
+        kvm_request_xsave_components(cpu, mask);
+        request_perm = true;
+    }
+
+    env->features[FEAT_XSAVE_XCR0_LO] = mask & CPUID_XSTATE_XCR0_MASK;
+    env->features[FEAT_XSAVE_XCR0_HI] = (mask & CPUID_XSTATE_XCR0_MASK) >> 32;
+    env->features[FEAT_XSAVE_XSS_LO] = mask & CPUID_XSTATE_XSS_MASK;
+    env->features[FEAT_XSAVE_XSS_HI] = (mask & CPUID_XSTATE_XSS_MASK) >> 32;
+}
+
+/***** Steps involved on loading and filtering CPUID data
+ *
+ * When initializing and realizing a CPU object, the steps
+ * involved in setting up CPUID data are:
+ *
+ * 1) Loading CPU model definition (X86CPUDefinition). This is
+ *    implemented by x86_cpu_load_model() and should be completely
+ *    transparent, as it is done automatically by instance_init.
+ *    No code should need to look at X86CPUDefinition structs
+ *    outside instance_init.
+ *
+ * 2) CPU expansion. This is done by realize before CPUID
+ *    filtering, and will make sure host/accelerator data is
+ *    loaded for CPU models that depend on host capabilities
+ *    (e.g. "host"). Done by x86_cpu_expand_features().
+ *
+ * 3) CPUID filtering. This initializes extra data related to
+ *    CPUID, and checks if the host supports all capabilities
+ *    required by the CPU. Runnability of a CPU model is
+ *    determined at this step. Done by x86_cpu_filter_features().
+ *
+ * Some operations don't require all steps to be performed.
+ * More precisely:
+ *
+ * - CPU instance creation (instance_init) will run only CPU
+ *   model loading. CPU expansion can't run at instance_init-time
+ *   because host/accelerator data may be not available yet.
+ * - CPU realization will perform both CPU model expansion and CPUID
+ *   filtering, and return an error in case one of them fails.
+ * - query-cpu-definitions needs to run all 3 steps. It needs
+ *   to run CPUID filtering, as the 'unavailable-features'
+ *   field is set based on the filtering results.
+ * - The query-cpu-model-expansion QMP command only needs to run
+ *   CPU model loading and CPU expansion. It should not filter
+ *   any CPUID data based on host capabilities.
+ */
+
+/* Expand CPU configuration data, based on configured features
+ * and host/accelerator capabilities when appropriate.
+ */
+void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
+{
+    CPUX86State *env = &cpu->env;
+    FeatureWord w;
+    int i;
+    GList *l;
+
+    for (l = plus_features; l; l = l->next) {
+        const char *prop = l->data;
+        if (!object_property_set_bool(OBJECT(cpu), prop, true, errp)) {
+            return;
+        }
+    }
+
+    for (l = minus_features; l; l = l->next) {
+        const char *prop = l->data;
+        if (!object_property_set_bool(OBJECT(cpu), prop, false, errp)) {
+            return;
+        }
+    }
+
+    /*TODO: Now cpu->max_features doesn't overwrite features
+     * set using QOM properties, and we can convert
+     * plus_features & minus_features to global properties
+     * inside x86_cpu_parse_featurestr() too.
+     */
+    if (cpu->max_features) {
+        for (w = 0; w < FEATURE_WORDS; w++) {
+            /* Override only features that weren't set explicitly
+             * by the user.
+             */
+            env->features[w] |=
+                x86_cpu_get_supported_feature_word(cpu, w) &
+                ~env->user_features[w] &
+                ~feature_word_info[w].no_autoenable_flags;
+        }
+
+        if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && !env->avx10_version) {
+            uint32_t eax, ebx, ecx, edx;
+            x86_cpu_get_supported_cpuid(0x24, 0, &eax, &ebx, &ecx, &edx);
+            env->avx10_version = ebx & 0xff;
+        }
+    }
+
+    for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
+        FeatureDep *d = &feature_dependencies[i];
+        if (!(env->features[d->from.index] & d->from.mask)) {
+            uint64_t unavailable_features = env->features[d->to.index] & d->to.mask;
+
+            /* Not an error unless the dependent feature was added explicitly.  */
+            mark_unavailable_features(cpu, d->to.index,
+                                      unavailable_features & env->user_features[d->to.index],
+                                      "This feature depends on other features that were not requested");
+
+            env->features[d->to.index] &= ~unavailable_features;
+        }
+    }
+
+    if (!kvm_enabled() || !cpu->expose_kvm) {
+        env->features[FEAT_KVM] = 0;
+    }
+
+    x86_cpu_enable_xsave_components(cpu);
+
+    /* CPUID[EAX=7,ECX=0].EBX always increased level automatically: */
+    x86_cpu_adjust_feat_level(cpu, FEAT_7_0_EBX);
+    if (cpu->full_cpuid_auto_level) {
+        x86_cpu_adjust_feat_level(cpu, FEAT_1_EDX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_1_ECX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_6_EAX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_7_0_ECX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EDX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_7_2_EDX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_EDX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_ECX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_8000_0007_EDX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_8000_0008_EBX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_C000_0001_EDX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
+        x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
+
+        /* Intel Processor Trace requires CPUID[0x14] */
+        if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT)) {
+            if (cpu->intel_pt_auto_level) {
+                x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
+            } else if (cpu->env.cpuid_min_level < 0x14) {
+                mark_unavailable_features(cpu, FEAT_7_0_EBX,
+                    CPUID_7_0_EBX_INTEL_PT,
+                    "Intel PT need CPUID leaf 0x14, please set by \"-cpu ...,intel-pt=on,min-level=0x14\"");
+            }
+        }
+
+        /*
+         * Intel CPU topology with multi-dies support requires CPUID[0x1F].
+         * For AMD Rome/Milan, cpuid level is 0x10, and guest OS should detect
+         * extended toplogy by leaf 0xB. Only adjust it for Intel CPU, unless
+         * cpu->vendor_cpuid_only has been unset for compatibility with older
+         * machine types.
+         */
+        if (x86_has_extended_topo(env->avail_cpu_topo) &&
+            (IS_INTEL_CPU(env) || !cpu->vendor_cpuid_only)) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
+        }
+
+        /* Advanced Vector Extensions 10 (AVX10) requires CPUID[0x24] */
+        if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x24);
+        }
+
+        /* SVM requires CPUID[0x8000000A] */
+        if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
+        }
+
+        /* SEV requires CPUID[0x8000001F] */
+        if (sev_enabled()) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001F);
+        }
+
+        if (env->features[FEAT_8000_0021_EAX]) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x80000021);
+        }
+
+        /* SGX requires CPUID[0x12] for EPC enumeration */
+        if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_SGX) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x12);
+        }
+    }
+
+    /* Set cpuid_*level* based on cpuid_min_*level, if not explicitly set */
+    if (env->cpuid_level_func7 == UINT32_MAX) {
+        env->cpuid_level_func7 = env->cpuid_min_level_func7;
+    }
+    if (env->cpuid_level == UINT32_MAX) {
+        env->cpuid_level = env->cpuid_min_level;
+    }
+    if (env->cpuid_xlevel == UINT32_MAX) {
+        env->cpuid_xlevel = env->cpuid_min_xlevel;
+    }
+    if (env->cpuid_xlevel2 == UINT32_MAX) {
+        env->cpuid_xlevel2 = env->cpuid_min_xlevel2;
+    }
+
+    if (kvm_enabled() && !kvm_hyperv_expand_features(cpu, errp)) {
+        return;
+    }
+}
+
+/*
+ * Finishes initialization of CPUID data, filters CPU feature
+ * words based on host availability of each feature.
+ *
+ * Returns: true if any flag is not supported by the host, false otherwise.
+ */
+static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
+{
+    CPUX86State *env = &cpu->env;
+    FeatureWord w;
+    const char *prefix = NULL;
+    bool have_filtered_features;
+
+    uint32_t eax_0, ebx_0, ecx_0, edx_0;
+    uint32_t eax_1, ebx_1, ecx_1, edx_1;
+
+    if (verbose) {
+        prefix = accel_uses_host_cpuid()
+                 ? "host doesn't support requested feature"
+                 : "TCG doesn't support requested feature";
+    }
+
+    for (w = 0; w < FEATURE_WORDS; w++) {
+        uint64_t host_feat =
+            x86_cpu_get_supported_feature_word(NULL, w);
+        uint64_t requested_features = env->features[w];
+        uint64_t unavailable_features = requested_features & ~host_feat;
+        mark_unavailable_features(cpu, w, unavailable_features, prefix);
+    }
+
+    /*
+     * Check that KVM actually allows the processor tracing features that
+     * are advertised by cpu_x86_cpuid().  Keep these two in sync.
+     */
+    if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
+        kvm_enabled()) {
+        x86_cpu_get_supported_cpuid(0x14, 0,
+                                    &eax_0, &ebx_0, &ecx_0, &edx_0);
+        x86_cpu_get_supported_cpuid(0x14, 1,
+                                    &eax_1, &ebx_1, &ecx_1, &edx_1);
+
+        if (!eax_0 ||
+           ((ebx_0 & INTEL_PT_MINIMAL_EBX) != INTEL_PT_MINIMAL_EBX) ||
+           ((ecx_0 & INTEL_PT_MINIMAL_ECX) != INTEL_PT_MINIMAL_ECX) ||
+           ((eax_1 & INTEL_PT_MTC_BITMAP) != INTEL_PT_MTC_BITMAP) ||
+           ((eax_1 & INTEL_PT_ADDR_RANGES_NUM_MASK) <
+                                           INTEL_PT_ADDR_RANGES_NUM) ||
+           ((ebx_1 & (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP)) !=
+                (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP)) ||
+           ((ecx_0 & CPUID_14_0_ECX_LIP) !=
+                (env->features[FEAT_14_0_ECX] & CPUID_14_0_ECX_LIP))) {
+            /*
+             * Processor Trace capabilities aren't configurable, so if the
+             * host can't emulate the capabilities we report on
+             * cpu_x86_cpuid(), intel-pt can't be enabled on the current host.
+             */
+            mark_unavailable_features(cpu, FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT, prefix);
+        }
+    }
+
+    have_filtered_features = x86_cpu_have_filtered_features(cpu);
+
+    if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
+        x86_cpu_get_supported_cpuid(0x24, 0,
+                                    &eax_0, &ebx_0, &ecx_0, &edx_0);
+        uint8_t version = ebx_0 & 0xff;
+
+        if (version < env->avx10_version) {
+            if (prefix) {
+                warn_report("%s: avx10.%d. Adjust to avx10.%d",
+                            prefix, env->avx10_version, version);
+            }
+            env->avx10_version = version;
+            have_filtered_features = true;
+        }
+    } else if (env->avx10_version && prefix) {
+        warn_report("%s: avx10.%d.", prefix, env->avx10_version);
+        have_filtered_features = true;
+    }
+
+    return have_filtered_features;
+}
+
+static void x86_cpu_hyperv_realize(X86CPU *cpu)
+{
+    size_t len;
+
+    /* Hyper-V vendor id */
+    if (!cpu->hyperv_vendor) {
+        object_property_set_str(OBJECT(cpu), "hv-vendor-id", "Microsoft Hv",
+                                &error_abort);
+    }
+    len = strlen(cpu->hyperv_vendor);
+    if (len > 12) {
+        warn_report("hv-vendor-id truncated to 12 characters");
+        len = 12;
+    }
+    memset(cpu->hyperv_vendor_id, 0, 12);
+    memcpy(cpu->hyperv_vendor_id, cpu->hyperv_vendor, len);
+
+    /* 'Hv#1' interface identification*/
+    cpu->hyperv_interface_id[0] = 0x31237648;
+    cpu->hyperv_interface_id[1] = 0;
+    cpu->hyperv_interface_id[2] = 0;
+    cpu->hyperv_interface_id[3] = 0;
+
+    /* Hypervisor implementation limits */
+    cpu->hyperv_limits[0] = 64;
+    cpu->hyperv_limits[1] = 0;
+    cpu->hyperv_limits[2] = 0;
+}
+
+static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
+{
+    CPUState *cs = CPU(dev);
+    X86CPU *cpu = X86_CPU(dev);
+    X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
+    CPUX86State *env = &cpu->env;
+    Error *local_err = NULL;
+    unsigned requested_lbr_fmt;
+
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+    /* Use pc-relative instructions in system-mode */
+    tcg_cflags_set(cs, CF_PCREL);
+#endif
+
+    if (cpu->apic_id == UNASSIGNED_APIC_ID) {
+        error_setg(errp, "apic-id property was not initialized properly");
+        return;
+    }
+
+    /*
+     * Process Hyper-V enlightenments.
+     * Note: this currently has to happen before the expansion of CPU features.
+     */
+    x86_cpu_hyperv_realize(cpu);
+
+    x86_cpu_expand_features(cpu, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    /*
+     * Override env->features[FEAT_PERF_CAPABILITIES].LBR_FMT
+     * with user-provided setting.
+     */
+    if (cpu->lbr_fmt != ~PERF_CAP_LBR_FMT) {
+        if ((cpu->lbr_fmt & PERF_CAP_LBR_FMT) != cpu->lbr_fmt) {
+            error_setg(errp, "invalid lbr-fmt");
+            return;
+        }
+        env->features[FEAT_PERF_CAPABILITIES] &= ~PERF_CAP_LBR_FMT;
+        env->features[FEAT_PERF_CAPABILITIES] |= cpu->lbr_fmt;
+    }
+
+    /*
+     * vPMU LBR is supported when 1) KVM is enabled 2) Option pmu=on and
+     * 3)vPMU LBR format matches that of host setting.
+     */
+    requested_lbr_fmt =
+        env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_LBR_FMT;
+    if (requested_lbr_fmt && kvm_enabled()) {
+        uint64_t host_perf_cap =
+            x86_cpu_get_supported_feature_word(NULL, FEAT_PERF_CAPABILITIES);
+        unsigned host_lbr_fmt = host_perf_cap & PERF_CAP_LBR_FMT;
+
+        if (!cpu->enable_pmu) {
+            error_setg(errp, "vPMU: LBR is unsupported without pmu=on");
+            return;
+        }
+        if (requested_lbr_fmt != host_lbr_fmt) {
+            error_setg(errp, "vPMU: the lbr-fmt value (0x%x) does not match "
+                        "the host value (0x%x).",
+                        requested_lbr_fmt, host_lbr_fmt);
+            return;
+        }
+    }
+
+    if (x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid)) {
+        if (cpu->enforce_cpuid) {
+            error_setg(&local_err,
+                       accel_uses_host_cpuid() ?
+                       "Host doesn't support requested features" :
+                       "TCG doesn't support requested features");
+            goto out;
+        }
+    }
+
+    /* On AMD CPUs, some CPUID[8000_0001].EDX bits must match the bits on
+     * CPUID[1].EDX.
+     */
+    if (IS_AMD_CPU(env)) {
+        env->features[FEAT_8000_0001_EDX] &= ~CPUID_EXT2_AMD_ALIASES;
+        env->features[FEAT_8000_0001_EDX] |= (env->features[FEAT_1_EDX]
+           & CPUID_EXT2_AMD_ALIASES);
+    }
+
+    x86_cpu_set_sgxlepubkeyhash(env);
+
+    /*
+     * note: the call to the framework needs to happen after feature expansion,
+     * but before the checks/modifications to ucode_rev, mwait, phys_bits.
+     * These may be set by the accel-specific code,
+     * and the results are subsequently checked / assumed in this function.
+     */
+    cpu_exec_realizefn(cs, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
+        g_autofree char *name = x86_cpu_class_get_model_name(xcc);
+        error_setg(&local_err, "CPU model '%s' requires KVM or HVF", name);
+        goto out;
+    }
+
+    if (cpu->guest_phys_bits == -1) {
+        /*
+         * If it was not set by the user, or by the accelerator via
+         * cpu_exec_realizefn, clear.
+         */
+        cpu->guest_phys_bits = 0;
+    }
+
+    if (cpu->ucode_rev == 0) {
+        /*
+         * The default is the same as KVM's. Note that this check
+         * needs to happen after the evenual setting of ucode_rev in
+         * accel-specific code in cpu_exec_realizefn.
+         */
+        if (IS_AMD_CPU(env)) {
+            cpu->ucode_rev = 0x01000065;
+        } else {
+            cpu->ucode_rev = 0x100000000ULL;
+        }
+    }
+
+    /*
+     * mwait extended info: needed for Core compatibility
+     * We always wake on interrupt even if host does not have the capability.
+     *
+     * requires the accel-specific code in cpu_exec_realizefn to
+     * have already acquired the CPUID data into cpu->mwait.
+     */
+    cpu->mwait.ecx |= CPUID_MWAIT_EMX | CPUID_MWAIT_IBE;
+
+    /* For 64bit systems think about the number of physical bits to present.
+     * ideally this should be the same as the host; anything other than matching
+     * the host can cause incorrect guest behaviour.
+     * QEMU used to pick the magic value of 40 bits that corresponds to
+     * consumer AMD devices but nothing else.
+     *
+     * Note that this code assumes features expansion has already been done
+     * (as it checks for CPUID_EXT2_LM), and also assumes that potential
+     * phys_bits adjustments to match the host have been already done in
+     * accel-specific code in cpu_exec_realizefn.
+     */
+    if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
+        if (cpu->phys_bits &&
+            (cpu->phys_bits > TARGET_PHYS_ADDR_SPACE_BITS ||
+            cpu->phys_bits < 32)) {
+            error_setg(errp, "phys-bits should be between 32 and %u "
+                             " (but is %u)",
+                             TARGET_PHYS_ADDR_SPACE_BITS, cpu->phys_bits);
+            return;
+        }
+        /*
+         * 0 means it was not explicitly set by the user (or by machine
+         * compat_props or by the host code in host-cpu.c).
+         * In this case, the default is the value used by TCG (40).
+         */
+        if (cpu->phys_bits == 0) {
+            cpu->phys_bits = TCG_PHYS_ADDR_BITS;
+        }
+        if (cpu->guest_phys_bits &&
+            (cpu->guest_phys_bits > cpu->phys_bits ||
+            cpu->guest_phys_bits < 32)) {
+            error_setg(errp, "guest-phys-bits should be between 32 and %u "
+                             " (but is %u)",
+                             cpu->phys_bits, cpu->guest_phys_bits);
+            return;
+        }
+    } else {
+        /* For 32 bit systems don't use the user set value, but keep
+         * phys_bits consistent with what we tell the guest.
+         */
+        if (cpu->phys_bits != 0) {
+            error_setg(errp, "phys-bits is not user-configurable in 32 bit");
+            return;
+        }
+        if (cpu->guest_phys_bits != 0) {
+            error_setg(errp, "guest-phys-bits is not user-configurable in 32 bit");
+            return;
+        }
+
+        if (env->features[FEAT_1_EDX] & (CPUID_PSE36 | CPUID_PAE)) {
+            cpu->phys_bits = 36;
+        } else {
+            cpu->phys_bits = 32;
+        }
+    }
+
+    /* Cache information initialization */
+    if (!cpu->legacy_cache) {
+        const CPUCaches *cache_info =
+            x86_cpu_get_versioned_cache_info(cpu, xcc->model);
+
+        if (!xcc->model || !cache_info) {
+            g_autofree char *name = x86_cpu_class_get_model_name(xcc);
+            error_setg(errp,
+                       "CPU model '%s' doesn't support legacy-cache=off", name);
+            return;
+        }
+        env->cache_info_cpuid2 = env->cache_info_cpuid4 = env->cache_info_amd =
+            *cache_info;
+    } else {
+        /* Build legacy cache information */
+        env->cache_info_cpuid2.l1d_cache = &legacy_l1d_cache;
+        env->cache_info_cpuid2.l1i_cache = &legacy_l1i_cache;
+        env->cache_info_cpuid2.l2_cache = &legacy_l2_cache_cpuid2;
+        env->cache_info_cpuid2.l3_cache = &legacy_l3_cache;
+
+        env->cache_info_cpuid4.l1d_cache = &legacy_l1d_cache;
+        env->cache_info_cpuid4.l1i_cache = &legacy_l1i_cache;
+        env->cache_info_cpuid4.l2_cache = &legacy_l2_cache;
+        env->cache_info_cpuid4.l3_cache = &legacy_l3_cache;
+
+        env->cache_info_amd.l1d_cache = &legacy_l1d_cache_amd;
+        env->cache_info_amd.l1i_cache = &legacy_l1i_cache_amd;
+        env->cache_info_amd.l2_cache = &legacy_l2_cache_amd;
+        env->cache_info_amd.l3_cache = &legacy_l3_cache;
+    }
+
+#ifndef CONFIG_USER_ONLY
+    MachineState *ms = MACHINE(qdev_get_machine());
+    qemu_register_reset(x86_cpu_machine_reset_cb, cpu);
+
+    if (cpu->env.features[FEAT_1_EDX] & CPUID_APIC || ms->smp.cpus > 1) {
+        x86_cpu_apic_create(cpu, &local_err);
+        if (local_err != NULL) {
+            goto out;
+        }
+    }
+#endif
+
+    mce_init(cpu);
+
+    x86_cpu_gdb_init(cs);
+    qemu_init_vcpu(cs);
+
+    /*
+     * Most Intel and certain AMD CPUs support hyperthreading. Even though QEMU
+     * fixes this issue by adjusting CPUID_0000_0001_EBX and CPUID_8000_0008_ECX
+     * based on inputs (sockets,cores,threads), it is still better to give
+     * users a warning.
+     *
+     * NOTE: the following code has to follow qemu_init_vcpu(). Otherwise
+     * cs->nr_threads hasn't be populated yet and the checking is incorrect.
+     */
+    if (IS_AMD_CPU(env) &&
+        !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
+        cs->nr_threads > 1) {
+            warn_report_once("This family of AMD CPU doesn't support "
+                             "hyperthreading(%d). Please configure -smp "
+                             "options properly or try enabling topoext "
+                             "feature.", cs->nr_threads);
+    }
+
+#ifndef CONFIG_USER_ONLY
+    x86_cpu_apic_realize(cpu, &local_err);
+    if (local_err != NULL) {
+        goto out;
+    }
+#endif /* !CONFIG_USER_ONLY */
+    cpu_reset(cs);
+
+    xcc->parent_realize(dev, &local_err);
+
+out:
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
+static void x86_cpu_unrealizefn(DeviceState *dev)
+{
+    X86CPU *cpu = X86_CPU(dev);
+    X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
+
+#ifndef CONFIG_USER_ONLY
+    cpu_remove_sync(CPU(dev));
+    qemu_unregister_reset(x86_cpu_machine_reset_cb, dev);
+#endif
+
+    if (cpu->apic_state) {
+        object_unparent(OBJECT(cpu->apic_state));
+        cpu->apic_state = NULL;
+    }
+
+    xcc->parent_unrealize(dev);
+}
+
+typedef struct BitProperty {
+    FeatureWord w;
+    uint64_t mask;
+} BitProperty;
+
+static void x86_cpu_get_bit_prop(Object *obj, Visitor *v, const char *name,
+                                 void *opaque, Error **errp)
+{
+    X86CPU *cpu = X86_CPU(obj);
+    BitProperty *fp = opaque;
+    uint64_t f = cpu->env.features[fp->w];
+    bool value = (f & fp->mask) == fp->mask;
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
+                                 void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    X86CPU *cpu = X86_CPU(obj);
+    BitProperty *fp = opaque;
+    bool value;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+
+    if (value) {
+        cpu->env.features[fp->w] |= fp->mask;
+    } else {
+        cpu->env.features[fp->w] &= ~fp->mask;
+    }
+    cpu->env.user_features[fp->w] |= fp->mask;
+}
+
+/* Register a boolean property to get/set a single bit in a uint32_t field.
+ *
+ * The same property name can be registered multiple times to make it affect
+ * multiple bits in the same FeatureWord. In that case, the getter will return
+ * true only if all bits are set.
+ */
+static void x86_cpu_register_bit_prop(X86CPUClass *xcc,
+                                      const char *prop_name,
+                                      FeatureWord w,
+                                      int bitnr)
+{
+    ObjectClass *oc = OBJECT_CLASS(xcc);
+    BitProperty *fp;
+    ObjectProperty *op;
+    uint64_t mask = (1ULL << bitnr);
+
+    op = object_class_property_find(oc, prop_name);
+    if (op) {
+        fp = op->opaque;
+        assert(fp->w == w);
+        fp->mask |= mask;
+    } else {
+        fp = g_new0(BitProperty, 1);
+        fp->w = w;
+        fp->mask = mask;
+        object_class_property_add(oc, prop_name, "bool",
+                                  x86_cpu_get_bit_prop,
+                                  x86_cpu_set_bit_prop,
+                                  NULL, fp);
+    }
+}
+
+static void x86_cpu_register_feature_bit_props(X86CPUClass *xcc,
+                                               FeatureWord w,
+                                               int bitnr)
+{
+    FeatureWordInfo *fi = &feature_word_info[w];
+    const char *name = fi->feat_names[bitnr];
+
+    if (!name) {
+        return;
+    }
+
+    /* Property names should use "-" instead of "_".
+     * Old names containing underscores are registered as aliases
+     * using object_property_add_alias()
+     */
+    assert(!strchr(name, '_'));
+    /* aliases don't use "|" delimiters anymore, they are registered
+     * manually using object_property_add_alias() */
+    assert(!strchr(name, '|'));
+    x86_cpu_register_bit_prop(xcc, name, w, bitnr);
+}
+
+static void x86_cpu_post_initfn(Object *obj)
+{
+    static bool first = true;
+    uint64_t supported_xcr0;
+    int i;
+
+    if (first) {
+        first = false;
+
+        supported_xcr0 =
+            ((uint64_t) x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_HI) << 32) |
+            x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_LO);
+
+        for (i = XSTATE_SSE_BIT + 1; i < XSAVE_STATE_AREA_COUNT; i++) {
+            ExtSaveArea *esa = &x86_ext_save_areas[i];
+
+            if (!(supported_xcr0 & (1 << i))) {
+                esa->size = 0;
+            }
+        }
+    }
+
+    accel_cpu_instance_init(CPU(obj));
+}
+
+static void x86_cpu_init_default_topo(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+
+    env->nr_modules = 1;
+    env->nr_dies = 1;
+
+    /* thread, core and socket levels are set by default. */
+    set_bit(CPU_TOPOLOGY_LEVEL_THREAD, env->avail_cpu_topo);
+    set_bit(CPU_TOPOLOGY_LEVEL_CORE, env->avail_cpu_topo);
+    set_bit(CPU_TOPOLOGY_LEVEL_SOCKET, env->avail_cpu_topo);
+}
+
+static void x86_cpu_initfn(Object *obj)
+{
+    X86CPU *cpu = X86_CPU(obj);
+    X86CPUClass *xcc = X86_CPU_GET_CLASS(obj);
+    CPUX86State *env = &cpu->env;
+
+    x86_cpu_init_default_topo(cpu);
+
+    object_property_add(obj, "feature-words", "X86CPUFeatureWordInfo",
+                        x86_cpu_get_feature_words,
+                        NULL, NULL, (void *)env->features);
+    object_property_add(obj, "filtered-features", "X86CPUFeatureWordInfo",
+                        x86_cpu_get_feature_words,
+                        NULL, NULL, (void *)cpu->filtered_features);
+
+    object_property_add_alias(obj, "sse3", obj, "pni");
+    object_property_add_alias(obj, "pclmuldq", obj, "pclmulqdq");
+    object_property_add_alias(obj, "sse4-1", obj, "sse4.1");
+    object_property_add_alias(obj, "sse4-2", obj, "sse4.2");
+    object_property_add_alias(obj, "xd", obj, "nx");
+    object_property_add_alias(obj, "ffxsr", obj, "fxsr-opt");
+    object_property_add_alias(obj, "i64", obj, "lm");
+
+    object_property_add_alias(obj, "ds_cpl", obj, "ds-cpl");
+    object_property_add_alias(obj, "tsc_adjust", obj, "tsc-adjust");
+    object_property_add_alias(obj, "fxsr_opt", obj, "fxsr-opt");
+    object_property_add_alias(obj, "lahf_lm", obj, "lahf-lm");
+    object_property_add_alias(obj, "cmp_legacy", obj, "cmp-legacy");
+    object_property_add_alias(obj, "nodeid_msr", obj, "nodeid-msr");
+    object_property_add_alias(obj, "perfctr_core", obj, "perfctr-core");
+    object_property_add_alias(obj, "perfctr_nb", obj, "perfctr-nb");
+    object_property_add_alias(obj, "kvm_nopiodelay", obj, "kvm-nopiodelay");
+    object_property_add_alias(obj, "kvm_mmu", obj, "kvm-mmu");
+    object_property_add_alias(obj, "kvm_asyncpf", obj, "kvm-asyncpf");
+    object_property_add_alias(obj, "kvm_asyncpf_int", obj, "kvm-asyncpf-int");
+    object_property_add_alias(obj, "kvm_steal_time", obj, "kvm-steal-time");
+    object_property_add_alias(obj, "kvm_pv_eoi", obj, "kvm-pv-eoi");
+    object_property_add_alias(obj, "kvm_pv_unhalt", obj, "kvm-pv-unhalt");
+    object_property_add_alias(obj, "kvm_poll_control", obj, "kvm-poll-control");
+    object_property_add_alias(obj, "svm_lock", obj, "svm-lock");
+    object_property_add_alias(obj, "nrip_save", obj, "nrip-save");
+    object_property_add_alias(obj, "tsc_scale", obj, "tsc-scale");
+    object_property_add_alias(obj, "vmcb_clean", obj, "vmcb-clean");
+    object_property_add_alias(obj, "pause_filter", obj, "pause-filter");
+    object_property_add_alias(obj, "sse4_1", obj, "sse4.1");
+    object_property_add_alias(obj, "sse4_2", obj, "sse4.2");
+
+    object_property_add_alias(obj, "hv-apicv", obj, "hv-avic");
+    cpu->lbr_fmt = ~PERF_CAP_LBR_FMT;
+    object_property_add_alias(obj, "lbr_fmt", obj, "lbr-fmt");
+
+    if (xcc->model) {
+        x86_cpu_load_model(cpu, xcc->model);
+    }
+}
+
+static int64_t x86_cpu_get_arch_id(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+
+    return cpu->apic_id;
+}
+
+#if !defined(CONFIG_USER_ONLY)
+static bool x86_cpu_get_paging_enabled(const CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+
+    return cpu->env.cr[0] & CR0_PG_MASK;
+}
+#endif /* !CONFIG_USER_ONLY */
+
+static void x86_cpu_set_pc(CPUState *cs, vaddr value)
+{
+    X86CPU *cpu = X86_CPU(cs);
+
+    cpu->env.eip = value;
+}
+
+static vaddr x86_cpu_get_pc(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+
+    /* Match cpu_get_tb_cpu_state. */
+    return cpu->env.eip + cpu->env.segs[R_CS].base;
+}
+
+int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+#if !defined(CONFIG_USER_ONLY)
+    if (interrupt_request & CPU_INTERRUPT_POLL) {
+        return CPU_INTERRUPT_POLL;
+    }
+#endif
+    if (interrupt_request & CPU_INTERRUPT_SIPI) {
+        return CPU_INTERRUPT_SIPI;
+    }
+
+    if (env->hflags2 & HF2_GIF_MASK) {
+        if ((interrupt_request & CPU_INTERRUPT_SMI) &&
+            !(env->hflags & HF_SMM_MASK)) {
+            return CPU_INTERRUPT_SMI;
+        } else if ((interrupt_request & CPU_INTERRUPT_NMI) &&
+                   !(env->hflags2 & HF2_NMI_MASK)) {
+            return CPU_INTERRUPT_NMI;
+        } else if (interrupt_request & CPU_INTERRUPT_MCE) {
+            return CPU_INTERRUPT_MCE;
+        } else if ((interrupt_request & CPU_INTERRUPT_HARD) &&
+                   (((env->hflags2 & HF2_VINTR_MASK) &&
+                     (env->hflags2 & HF2_HIF_MASK)) ||
+                    (!(env->hflags2 & HF2_VINTR_MASK) &&
+                     (env->eflags & IF_MASK &&
+                      !(env->hflags & HF_INHIBIT_IRQ_MASK))))) {
+            return CPU_INTERRUPT_HARD;
+#if !defined(CONFIG_USER_ONLY)
+        } else if (env->hflags2 & HF2_VGIF_MASK) {
+            if((interrupt_request & CPU_INTERRUPT_VIRQ) &&
+                   (env->eflags & IF_MASK) &&
+                   !(env->hflags & HF_INHIBIT_IRQ_MASK)) {
+                        return CPU_INTERRUPT_VIRQ;
+            }
+#endif
+        }
+    }
+
+    return 0;
+}
+
+static bool x86_cpu_has_work(CPUState *cs)
+{
+    return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
+}
+
+int x86_mmu_index_pl(CPUX86State *env, unsigned pl)
+{
+    int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 0 : 1;
+    int mmu_index_base =
+        pl == 3 ? MMU_USER64_IDX :
+        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
+        (env->eflags & AC_MASK) ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;
+
+    return mmu_index_base + mmu_index_32;
+}
+
+static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    CPUX86State *env = cpu_env(cs);
+    return x86_mmu_index_pl(env, env->hflags & HF_CPL_MASK);
+}
+
+static int x86_mmu_index_kernel_pl(CPUX86State *env, unsigned pl)
+{
+    int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 0 : 1;
+    int mmu_index_base =
+        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
+        (pl < 3 && (env->eflags & AC_MASK)
+         ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX);
+
+    return mmu_index_base + mmu_index_32;
+}
+
+int cpu_mmu_index_kernel(CPUX86State *env)
+{
+    return x86_mmu_index_kernel_pl(env, env->hflags & HF_CPL_MASK);
+}
+
+static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+    info->mach = (env->hflags & HF_CS64_MASK ? bfd_mach_x86_64
+                  : env->hflags & HF_CS32_MASK ? bfd_mach_i386_i386
+                  : bfd_mach_i386_i8086);
+
+    info->cap_arch = CS_ARCH_X86;
+    info->cap_mode = (env->hflags & HF_CS64_MASK ? CS_MODE_64
+                      : env->hflags & HF_CS32_MASK ? CS_MODE_32
+                      : CS_MODE_16);
+    info->cap_insn_unit = 1;
+    info->cap_insn_split = 8;
+}
+
+void x86_update_hflags(CPUX86State *env)
+{
+   uint32_t hflags;
+#define HFLAG_COPY_MASK \
+    ~( HF_CPL_MASK | HF_PE_MASK | HF_MP_MASK | HF_EM_MASK | \
+       HF_TS_MASK | HF_TF_MASK | HF_VM_MASK | HF_IOPL_MASK | \
+       HF_OSFXSR_MASK | HF_LMA_MASK | HF_CS32_MASK | \
+       HF_SS32_MASK | HF_CS64_MASK | HF_ADDSEG_MASK)
+
+    hflags = env->hflags & HFLAG_COPY_MASK;
+    hflags |= (env->segs[R_SS].flags >> DESC_DPL_SHIFT) & HF_CPL_MASK;
+    hflags |= (env->cr[0] & CR0_PE_MASK) << (HF_PE_SHIFT - CR0_PE_SHIFT);
+    hflags |= (env->cr[0] << (HF_MP_SHIFT - CR0_MP_SHIFT)) &
+                (HF_MP_MASK | HF_EM_MASK | HF_TS_MASK);
+    hflags |= (env->eflags & (HF_TF_MASK | HF_VM_MASK | HF_IOPL_MASK));
+
+    if (env->cr[4] & CR4_OSFXSR_MASK) {
+        hflags |= HF_OSFXSR_MASK;
+    }
+
+    if (env->efer & MSR_EFER_LMA) {
+        hflags |= HF_LMA_MASK;
+    }
+
+    if ((hflags & HF_LMA_MASK) && (env->segs[R_CS].flags & DESC_L_MASK)) {
+        hflags |= HF_CS32_MASK | HF_SS32_MASK | HF_CS64_MASK;
+    } else {
+        hflags |= (env->segs[R_CS].flags & DESC_B_MASK) >>
+                    (DESC_B_SHIFT - HF_CS32_SHIFT);
+        hflags |= (env->segs[R_SS].flags & DESC_B_MASK) >>
+                    (DESC_B_SHIFT - HF_SS32_SHIFT);
+        if (!(env->cr[0] & CR0_PE_MASK) || (env->eflags & VM_MASK) ||
+            !(hflags & HF_CS32_MASK)) {
+            hflags |= HF_ADDSEG_MASK;
+        } else {
+            hflags |= ((env->segs[R_DS].base | env->segs[R_ES].base |
+                        env->segs[R_SS].base) != 0) << HF_ADDSEG_SHIFT;
+        }
+    }
+    env->hflags = hflags;
+}
+
+static Property x86_cpu_properties[] = {
+#ifdef CONFIG_USER_ONLY
+    /* apic_id = 0 by default for *-user, see commit 9886e834 */
+    DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, 0),
+    DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, 0),
+    DEFINE_PROP_INT32("core-id", X86CPU, core_id, 0),
+    DEFINE_PROP_INT32("module-id", X86CPU, module_id, 0),
+    DEFINE_PROP_INT32("die-id", X86CPU, die_id, 0),
+    DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, 0),
+#else
+    DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, UNASSIGNED_APIC_ID),
+    DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, -1),
+    DEFINE_PROP_INT32("core-id", X86CPU, core_id, -1),
+    DEFINE_PROP_INT32("module-id", X86CPU, module_id, -1),
+    DEFINE_PROP_INT32("die-id", X86CPU, die_id, -1),
+    DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, -1),
+#endif
+    DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
+    DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
+    DEFINE_PROP_UINT64_CHECKMASK("lbr-fmt", X86CPU, lbr_fmt, PERF_CAP_LBR_FMT),
+
+    DEFINE_PROP_UINT32("hv-spinlocks", X86CPU, hyperv_spinlock_attempts,
+                       HYPERV_SPINLOCK_NEVER_NOTIFY),
+    DEFINE_PROP_BIT64("hv-relaxed", X86CPU, hyperv_features,
+                      HYPERV_FEAT_RELAXED, 0),
+    DEFINE_PROP_BIT64("hv-vapic", X86CPU, hyperv_features,
+                      HYPERV_FEAT_VAPIC, 0),
+    DEFINE_PROP_BIT64("hv-time", X86CPU, hyperv_features,
+                      HYPERV_FEAT_TIME, 0),
+    DEFINE_PROP_BIT64("hv-crash", X86CPU, hyperv_features,
+                      HYPERV_FEAT_CRASH, 0),
+    DEFINE_PROP_BIT64("hv-reset", X86CPU, hyperv_features,
+                      HYPERV_FEAT_RESET, 0),
+    DEFINE_PROP_BIT64("hv-vpindex", X86CPU, hyperv_features,
+                      HYPERV_FEAT_VPINDEX, 0),
+    DEFINE_PROP_BIT64("hv-runtime", X86CPU, hyperv_features,
+                      HYPERV_FEAT_RUNTIME, 0),
+    DEFINE_PROP_BIT64("hv-synic", X86CPU, hyperv_features,
+                      HYPERV_FEAT_SYNIC, 0),
+    DEFINE_PROP_BIT64("hv-stimer", X86CPU, hyperv_features,
+                      HYPERV_FEAT_STIMER, 0),
+    DEFINE_PROP_BIT64("hv-frequencies", X86CPU, hyperv_features,
+                      HYPERV_FEAT_FREQUENCIES, 0),
+    DEFINE_PROP_BIT64("hv-reenlightenment", X86CPU, hyperv_features,
+                      HYPERV_FEAT_REENLIGHTENMENT, 0),
+    DEFINE_PROP_BIT64("hv-tlbflush", X86CPU, hyperv_features,
+                      HYPERV_FEAT_TLBFLUSH, 0),
+    DEFINE_PROP_BIT64("hv-evmcs", X86CPU, hyperv_features,
+                      HYPERV_FEAT_EVMCS, 0),
+    DEFINE_PROP_BIT64("hv-ipi", X86CPU, hyperv_features,
+                      HYPERV_FEAT_IPI, 0),
+    DEFINE_PROP_BIT64("hv-stimer-direct", X86CPU, hyperv_features,
+                      HYPERV_FEAT_STIMER_DIRECT, 0),
+    DEFINE_PROP_BIT64("hv-avic", X86CPU, hyperv_features,
+                      HYPERV_FEAT_AVIC, 0),
+    DEFINE_PROP_BIT64("hv-emsr-bitmap", X86CPU, hyperv_features,
+                      HYPERV_FEAT_MSR_BITMAP, 0),
+    DEFINE_PROP_BIT64("hv-xmm-input", X86CPU, hyperv_features,
+                      HYPERV_FEAT_XMM_INPUT, 0),
+    DEFINE_PROP_BIT64("hv-tlbflush-ext", X86CPU, hyperv_features,
+                      HYPERV_FEAT_TLBFLUSH_EXT, 0),
+    DEFINE_PROP_BIT64("hv-tlbflush-direct", X86CPU, hyperv_features,
+                      HYPERV_FEAT_TLBFLUSH_DIRECT, 0),
+    DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
+                            hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
+#ifdef CONFIG_SYNDBG
+    DEFINE_PROP_BIT64("hv-syndbg", X86CPU, hyperv_features,
+                      HYPERV_FEAT_SYNDBG, 0),
+#endif
+    DEFINE_PROP_BOOL("hv-passthrough", X86CPU, hyperv_passthrough, false),
+    DEFINE_PROP_BOOL("hv-enforce-cpuid", X86CPU, hyperv_enforce_cpuid, false),
+
+    /* WS2008R2 identify by default */
+    DEFINE_PROP_UINT32("hv-version-id-build", X86CPU, hyperv_ver_id_build,
+                       0x3839),
+    DEFINE_PROP_UINT16("hv-version-id-major", X86CPU, hyperv_ver_id_major,
+                       0x000A),
+    DEFINE_PROP_UINT16("hv-version-id-minor", X86CPU, hyperv_ver_id_minor,
+                       0x0000),
+    DEFINE_PROP_UINT32("hv-version-id-spack", X86CPU, hyperv_ver_id_sp, 0),
+    DEFINE_PROP_UINT8("hv-version-id-sbranch", X86CPU, hyperv_ver_id_sb, 0),
+    DEFINE_PROP_UINT32("hv-version-id-snumber", X86CPU, hyperv_ver_id_sn, 0),
+
+    DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
+    DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
+    DEFINE_PROP_BOOL("x-force-features", X86CPU, force_features, false),
+    DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
+    DEFINE_PROP_UINT32("phys-bits", X86CPU, phys_bits, 0),
+    DEFINE_PROP_UINT32("guest-phys-bits", X86CPU, guest_phys_bits, -1),
+    DEFINE_PROP_BOOL("host-phys-bits", X86CPU, host_phys_bits, false),
+    DEFINE_PROP_UINT8("host-phys-bits-limit", X86CPU, host_phys_bits_limit, 0),
+    DEFINE_PROP_BOOL("fill-mtrr-mask", X86CPU, fill_mtrr_mask, true),
+    DEFINE_PROP_UINT32("level-func7", X86CPU, env.cpuid_level_func7,
+                       UINT32_MAX),
+    DEFINE_PROP_UINT32("level", X86CPU, env.cpuid_level, UINT32_MAX),
+    DEFINE_PROP_UINT32("xlevel", X86CPU, env.cpuid_xlevel, UINT32_MAX),
+    DEFINE_PROP_UINT32("xlevel2", X86CPU, env.cpuid_xlevel2, UINT32_MAX),
+    DEFINE_PROP_UINT32("min-level", X86CPU, env.cpuid_min_level, 0),
+    DEFINE_PROP_UINT32("min-xlevel", X86CPU, env.cpuid_min_xlevel, 0),
+    DEFINE_PROP_UINT32("min-xlevel2", X86CPU, env.cpuid_min_xlevel2, 0),
+    DEFINE_PROP_UINT8("avx10-version", X86CPU, env.avx10_version, 0),
+    DEFINE_PROP_UINT64("ucode-rev", X86CPU, ucode_rev, 0),
+    DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
+    DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
+    DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
+    DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
+    DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
+    DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
+    DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
+    DEFINE_PROP_BOOL("kvm-pv-enforce-cpuid", X86CPU, kvm_pv_enforce_cpuid,
+                     false),
+    DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
+    DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
+    DEFINE_PROP_BOOL("x-migrate-smi-count", X86CPU, migrate_smi_count,
+                     true),
+    /*
+     * lecacy_cache defaults to true unless the CPU model provides its
+     * own cache information (see x86_cpu_load_def()).
+     */
+    DEFINE_PROP_BOOL("legacy-cache", X86CPU, legacy_cache, true),
+    DEFINE_PROP_BOOL("legacy-multi-node", X86CPU, legacy_multi_node, false),
+    DEFINE_PROP_BOOL("xen-vapic", X86CPU, xen_vapic, false),
+
+    /*
+     * From "Requirements for Implementing the Microsoft
+     * Hypervisor Interface":
+     * https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs
+     *
+     * "Starting with Windows Server 2012 and Windows 8, if
+     * CPUID.40000005.EAX contains a value of -1, Windows assumes that
+     * the hypervisor imposes no specific limit to the number of VPs.
+     * In this case, Windows Server 2012 guest VMs may use more than
+     * 64 VPs, up to the maximum supported number of processors applicable
+     * to the specific Windows version being used."
+     */
+    DEFINE_PROP_INT32("x-hv-max-vps", X86CPU, hv_max_vps, -1),
+    DEFINE_PROP_BOOL("x-hv-synic-kvm-only", X86CPU, hyperv_synic_kvm_only,
+                     false),
+    DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
+                     true),
+    DEFINE_PROP_BOOL("x-l1-cache-per-thread", X86CPU, l1_cache_per_core, true),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+#ifndef CONFIG_USER_ONLY
+#include "hw/core/sysemu-cpu-ops.h"
+
+static const struct SysemuCPUOps i386_sysemu_ops = {
+    .get_memory_mapping = x86_cpu_get_memory_mapping,
+    .get_paging_enabled = x86_cpu_get_paging_enabled,
+    .get_phys_page_attrs_debug = x86_cpu_get_phys_page_attrs_debug,
+    .asidx_from_attrs = x86_asidx_from_attrs,
+    .get_crash_info = x86_cpu_get_crash_info,
+    .write_elf32_note = x86_cpu_write_elf32_note,
+    .write_elf64_note = x86_cpu_write_elf64_note,
+    .write_elf32_qemunote = x86_cpu_write_elf32_qemunote,
+    .write_elf64_qemunote = x86_cpu_write_elf64_qemunote,
+    .legacy_vmsd = &vmstate_x86_cpu,
+};
+#endif
+
+static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
+{
+    X86CPUClass *xcc = X86_CPU_CLASS(oc);
+    CPUClass *cc = CPU_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+    FeatureWord w;
+
+    device_class_set_parent_realize(dc, x86_cpu_realizefn,
+                                    &xcc->parent_realize);
+    device_class_set_parent_unrealize(dc, x86_cpu_unrealizefn,
+                                      &xcc->parent_unrealize);
+    device_class_set_props(dc, x86_cpu_properties);
+
+    resettable_class_set_parent_phases(rc, NULL, x86_cpu_reset_hold, NULL,
+                                       &xcc->parent_phases);
+    cc->reset_dump_flags = CPU_DUMP_FPU | CPU_DUMP_CCOP;
+
+    cc->class_by_name = x86_cpu_class_by_name;
+    cc->parse_features = x86_cpu_parse_featurestr;
+    cc->has_work = x86_cpu_has_work;
+    cc->mmu_index = x86_cpu_mmu_index;
+    cc->dump_state = x86_cpu_dump_state;
+    cc->set_pc = x86_cpu_set_pc;
+    cc->get_pc = x86_cpu_get_pc;
+    cc->gdb_read_register = x86_cpu_gdb_read_register;
+    cc->gdb_write_register = x86_cpu_gdb_write_register;
+    cc->get_arch_id = x86_cpu_get_arch_id;
+
+#ifndef CONFIG_USER_ONLY
+    cc->sysemu_ops = &i386_sysemu_ops;
+#endif /* !CONFIG_USER_ONLY */
+
+    cc->gdb_arch_name = x86_gdb_arch_name;
+#ifdef TARGET_X86_64
+    cc->gdb_core_xml_file = "i386-64bit.xml";
+#else
+    cc->gdb_core_xml_file = "i386-32bit.xml";
+#endif
+    cc->disas_set_info = x86_disas_set_info;
+
+    dc->user_creatable = true;
+
+    object_class_property_add(oc, "family", "int",
+                              x86_cpuid_version_get_family,
+                              x86_cpuid_version_set_family, NULL, NULL);
+    object_class_property_add(oc, "model", "int",
+                              x86_cpuid_version_get_model,
+                              x86_cpuid_version_set_model, NULL, NULL);
+    object_class_property_add(oc, "stepping", "int",
+                              x86_cpuid_version_get_stepping,
+                              x86_cpuid_version_set_stepping, NULL, NULL);
+    object_class_property_add_str(oc, "vendor",
+                                  x86_cpuid_get_vendor,
+                                  x86_cpuid_set_vendor);
+    object_class_property_add_str(oc, "model-id",
+                                  x86_cpuid_get_model_id,
+                                  x86_cpuid_set_model_id);
+    object_class_property_add(oc, "tsc-frequency", "int",
+                              x86_cpuid_get_tsc_freq,
+                              x86_cpuid_set_tsc_freq, NULL, NULL);
+    /*
+     * The "unavailable-features" property has the same semantics as
+     * CpuDefinitionInfo.unavailable-features on the "query-cpu-definitions"
+     * QMP command: they list the features that would have prevented the
+     * CPU from running if the "enforce" flag was set.
+     */
+    object_class_property_add(oc, "unavailable-features", "strList",
+                              x86_cpu_get_unavailable_features,
+                              NULL, NULL, NULL);
+
+#if !defined(CONFIG_USER_ONLY)
+    object_class_property_add(oc, "crash-information", "GuestPanicInformation",
+                              x86_cpu_get_crash_info_qom, NULL, NULL, NULL);
+#endif
+
+    for (w = 0; w < FEATURE_WORDS; w++) {
+        int bitnr;
+        for (bitnr = 0; bitnr < 64; bitnr++) {
+            x86_cpu_register_feature_bit_props(xcc, w, bitnr);
+        }
+    }
+}
+
+static const TypeInfo x86_cpu_type_info = {
+    .name = TYPE_X86_CPU,
+    .parent = TYPE_CPU,
+    .instance_size = sizeof(X86CPU),
+    .instance_align = __alignof(X86CPU),
+    .instance_init = x86_cpu_initfn,
+    .instance_post_init = x86_cpu_post_initfn,
+
+    .abstract = true,
+    .class_size = sizeof(X86CPUClass),
+    .class_init = x86_cpu_common_class_init,
+};
+
+/* "base" CPU model, used by query-cpu-model-expansion */
+static void x86_cpu_base_class_init(ObjectClass *oc, void *data)
+{
+    X86CPUClass *xcc = X86_CPU_CLASS(oc);
+
+    xcc->static_model = true;
+    xcc->migration_safe = true;
+    xcc->model_description = "base CPU model type with no features enabled";
+    xcc->ordering = 8;
+}
+
+static const TypeInfo x86_base_cpu_type_info = {
+        .name = X86_CPU_TYPE_NAME("base"),
+        .parent = TYPE_X86_CPU,
+        .class_init = x86_cpu_base_class_init,
+};
+
+static void x86_cpu_register_types(void)
+{
+    int i;
+
+    type_register_static(&x86_cpu_type_info);
+    for (i = 0; i < ARRAY_SIZE(builtin_x86_defs); i++) {
+        x86_register_cpudef_types(&builtin_x86_defs[i]);
+    }
+    type_register_static(&max_x86_cpu_type_info);
+    type_register_static(&x86_base_cpu_type_info);
+}
+
+type_init(x86_cpu_register_types)
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
new file mode 100644
index 0000000..1685666
--- /dev/null
+++ b/target/i386/cpu.h
@@ -0,0 +1,2767 @@
+/*
+ * i386 virtual CPU header
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef I386_CPU_H
+#define I386_CPU_H
+
+#include "sysemu/tcg.h"
+#include "cpu-qom.h"
+#include "kvm/hyperv-proto.h"
+#include "exec/cpu-defs.h"
+#include "exec/memop.h"
+#include "hw/i386/topology.h"
+#include "qapi/qapi-types-common.h"
+#include "qemu/cpu-float.h"
+#include "qemu/timer.h"
+
+#define XEN_NR_VIRQS 24
+
+#define KVM_HAVE_MCE_INJECTION 1
+
+/* support for self modifying code even if the modified instruction is
+   close to the modifying instruction */
+#define TARGET_HAS_PRECISE_SMC
+
+#ifdef TARGET_X86_64
+#define I386_ELF_MACHINE  EM_X86_64
+#define ELF_MACHINE_UNAME "x86_64"
+#else
+#define I386_ELF_MACHINE  EM_386
+#define ELF_MACHINE_UNAME "i686"
+#endif
+
+enum {
+    R_EAX = 0,
+    R_ECX = 1,
+    R_EDX = 2,
+    R_EBX = 3,
+    R_ESP = 4,
+    R_EBP = 5,
+    R_ESI = 6,
+    R_EDI = 7,
+    R_R8 = 8,
+    R_R9 = 9,
+    R_R10 = 10,
+    R_R11 = 11,
+    R_R12 = 12,
+    R_R13 = 13,
+    R_R14 = 14,
+    R_R15 = 15,
+
+    R_AL = 0,
+    R_CL = 1,
+    R_DL = 2,
+    R_BL = 3,
+    R_AH = 4,
+    R_CH = 5,
+    R_DH = 6,
+    R_BH = 7,
+};
+
+typedef enum X86Seg {
+    R_ES = 0,
+    R_CS = 1,
+    R_SS = 2,
+    R_DS = 3,
+    R_FS = 4,
+    R_GS = 5,
+    R_LDTR = 6,
+    R_TR = 7,
+} X86Seg;
+
+/* segment descriptor fields */
+#define DESC_G_SHIFT    23
+#define DESC_G_MASK     (1 << DESC_G_SHIFT)
+#define DESC_B_SHIFT    22
+#define DESC_B_MASK     (1 << DESC_B_SHIFT)
+#define DESC_L_SHIFT    21 /* x86_64 only : 64 bit code segment */
+#define DESC_L_MASK     (1 << DESC_L_SHIFT)
+#define DESC_AVL_SHIFT  20
+#define DESC_AVL_MASK   (1 << DESC_AVL_SHIFT)
+#define DESC_P_SHIFT    15
+#define DESC_P_MASK     (1 << DESC_P_SHIFT)
+#define DESC_DPL_SHIFT  13
+#define DESC_DPL_MASK   (3 << DESC_DPL_SHIFT)
+#define DESC_S_SHIFT    12
+#define DESC_S_MASK     (1 << DESC_S_SHIFT)
+#define DESC_TYPE_SHIFT 8
+#define DESC_TYPE_MASK  (15 << DESC_TYPE_SHIFT)
+#define DESC_A_MASK     (1 << 8)
+
+#define DESC_CS_MASK    (1 << 11) /* 1=code segment 0=data segment */
+#define DESC_C_MASK     (1 << 10) /* code: conforming */
+#define DESC_R_MASK     (1 << 9)  /* code: readable */
+
+#define DESC_E_MASK     (1 << 10) /* data: expansion direction */
+#define DESC_W_MASK     (1 << 9)  /* data: writable */
+
+#define DESC_TSS_BUSY_MASK (1 << 9)
+
+/* eflags masks */
+#define CC_C    0x0001
+#define CC_P    0x0004
+#define CC_A    0x0010
+#define CC_Z    0x0040
+#define CC_S    0x0080
+#define CC_O    0x0800
+
+#define TF_SHIFT   8
+#define IOPL_SHIFT 12
+#define VM_SHIFT   17
+
+#define TF_MASK                 0x00000100
+#define IF_MASK                 0x00000200
+#define DF_MASK                 0x00000400
+#define IOPL_MASK               0x00003000
+#define NT_MASK                 0x00004000
+#define RF_MASK                 0x00010000
+#define VM_MASK                 0x00020000
+#define AC_MASK                 0x00040000
+#define VIF_MASK                0x00080000
+#define VIP_MASK                0x00100000
+#define ID_MASK                 0x00200000
+
+/* hidden flags - used internally by qemu to represent additional cpu
+   states. Only the INHIBIT_IRQ, SMM and SVMI are not redundant. We
+   avoid using the IOPL_MASK, TF_MASK, VM_MASK and AC_MASK bit
+   positions to ease oring with eflags. */
+/* current cpl */
+#define HF_CPL_SHIFT         0
+/* true if hardware interrupts must be disabled for next instruction */
+#define HF_INHIBIT_IRQ_SHIFT 3
+/* 16 or 32 segments */
+#define HF_CS32_SHIFT        4
+#define HF_SS32_SHIFT        5
+/* zero base for DS, ES and SS : can be '0' only in 32 bit CS segment */
+#define HF_ADDSEG_SHIFT      6
+/* copy of CR0.PE (protected mode) */
+#define HF_PE_SHIFT          7
+#define HF_TF_SHIFT          8 /* must be same as eflags */
+#define HF_MP_SHIFT          9 /* the order must be MP, EM, TS */
+#define HF_EM_SHIFT         10
+#define HF_TS_SHIFT         11
+#define HF_IOPL_SHIFT       12 /* must be same as eflags */
+#define HF_LMA_SHIFT        14 /* only used on x86_64: long mode active */
+#define HF_CS64_SHIFT       15 /* only used on x86_64: 64 bit code segment  */
+#define HF_RF_SHIFT         16 /* must be same as eflags */
+#define HF_VM_SHIFT         17 /* must be same as eflags */
+#define HF_AC_SHIFT         18 /* must be same as eflags */
+#define HF_SMM_SHIFT        19 /* CPU in SMM mode */
+#define HF_SVME_SHIFT       20 /* SVME enabled (copy of EFER.SVME) */
+#define HF_GUEST_SHIFT      21 /* SVM intercepts are active */
+#define HF_OSFXSR_SHIFT     22 /* CR4.OSFXSR */
+#define HF_SMAP_SHIFT       23 /* CR4.SMAP */
+#define HF_IOBPT_SHIFT      24 /* an io breakpoint enabled */
+#define HF_MPX_EN_SHIFT     25 /* MPX Enabled (CR4+XCR0+BNDCFGx) */
+#define HF_MPX_IU_SHIFT     26 /* BND registers in-use */
+#define HF_UMIP_SHIFT       27 /* CR4.UMIP */
+#define HF_AVX_EN_SHIFT     28 /* AVX Enabled (CR4+XCR0) */
+
+#define HF_CPL_MASK          (3 << HF_CPL_SHIFT)
+#define HF_INHIBIT_IRQ_MASK  (1 << HF_INHIBIT_IRQ_SHIFT)
+#define HF_CS32_MASK         (1 << HF_CS32_SHIFT)
+#define HF_SS32_MASK         (1 << HF_SS32_SHIFT)
+#define HF_ADDSEG_MASK       (1 << HF_ADDSEG_SHIFT)
+#define HF_PE_MASK           (1 << HF_PE_SHIFT)
+#define HF_TF_MASK           (1 << HF_TF_SHIFT)
+#define HF_MP_MASK           (1 << HF_MP_SHIFT)
+#define HF_EM_MASK           (1 << HF_EM_SHIFT)
+#define HF_TS_MASK           (1 << HF_TS_SHIFT)
+#define HF_IOPL_MASK         (3 << HF_IOPL_SHIFT)
+#define HF_LMA_MASK          (1 << HF_LMA_SHIFT)
+#define HF_CS64_MASK         (1 << HF_CS64_SHIFT)
+#define HF_RF_MASK           (1 << HF_RF_SHIFT)
+#define HF_VM_MASK           (1 << HF_VM_SHIFT)
+#define HF_AC_MASK           (1 << HF_AC_SHIFT)
+#define HF_SMM_MASK          (1 << HF_SMM_SHIFT)
+#define HF_SVME_MASK         (1 << HF_SVME_SHIFT)
+#define HF_GUEST_MASK        (1 << HF_GUEST_SHIFT)
+#define HF_OSFXSR_MASK       (1 << HF_OSFXSR_SHIFT)
+#define HF_SMAP_MASK         (1 << HF_SMAP_SHIFT)
+#define HF_IOBPT_MASK        (1 << HF_IOBPT_SHIFT)
+#define HF_MPX_EN_MASK       (1 << HF_MPX_EN_SHIFT)
+#define HF_MPX_IU_MASK       (1 << HF_MPX_IU_SHIFT)
+#define HF_UMIP_MASK         (1 << HF_UMIP_SHIFT)
+#define HF_AVX_EN_MASK       (1 << HF_AVX_EN_SHIFT)
+
+/* hflags2 */
+
+#define HF2_GIF_SHIFT            0 /* if set CPU takes interrupts */
+#define HF2_HIF_SHIFT            1 /* value of IF_MASK when entering SVM */
+#define HF2_NMI_SHIFT            2 /* CPU serving NMI */
+#define HF2_VINTR_SHIFT          3 /* value of V_INTR_MASKING bit */
+#define HF2_SMM_INSIDE_NMI_SHIFT 4 /* CPU serving SMI nested inside NMI */
+#define HF2_MPX_PR_SHIFT         5 /* BNDCFGx.BNDPRESERVE */
+#define HF2_NPT_SHIFT            6 /* Nested Paging enabled */
+#define HF2_IGNNE_SHIFT          7 /* Ignore CR0.NE=0 */
+#define HF2_VGIF_SHIFT           8 /* Can take VIRQ*/
+
+#define HF2_GIF_MASK            (1 << HF2_GIF_SHIFT)
+#define HF2_HIF_MASK            (1 << HF2_HIF_SHIFT)
+#define HF2_NMI_MASK            (1 << HF2_NMI_SHIFT)
+#define HF2_VINTR_MASK          (1 << HF2_VINTR_SHIFT)
+#define HF2_SMM_INSIDE_NMI_MASK (1 << HF2_SMM_INSIDE_NMI_SHIFT)
+#define HF2_MPX_PR_MASK         (1 << HF2_MPX_PR_SHIFT)
+#define HF2_NPT_MASK            (1 << HF2_NPT_SHIFT)
+#define HF2_IGNNE_MASK          (1 << HF2_IGNNE_SHIFT)
+#define HF2_VGIF_MASK           (1 << HF2_VGIF_SHIFT)
+
+#define CR0_PE_SHIFT 0
+#define CR0_MP_SHIFT 1
+
+#define CR0_PE_MASK  (1U << 0)
+#define CR0_MP_MASK  (1U << 1)
+#define CR0_EM_MASK  (1U << 2)
+#define CR0_TS_MASK  (1U << 3)
+#define CR0_ET_MASK  (1U << 4)
+#define CR0_NE_MASK  (1U << 5)
+#define CR0_WP_MASK  (1U << 16)
+#define CR0_AM_MASK  (1U << 18)
+#define CR0_NW_MASK  (1U << 29)
+#define CR0_CD_MASK  (1U << 30)
+#define CR0_PG_MASK  (1U << 31)
+
+#define CR4_VME_MASK  (1U << 0)
+#define CR4_PVI_MASK  (1U << 1)
+#define CR4_TSD_MASK  (1U << 2)
+#define CR4_DE_MASK   (1U << 3)
+#define CR4_PSE_MASK  (1U << 4)
+#define CR4_PAE_MASK  (1U << 5)
+#define CR4_MCE_MASK  (1U << 6)
+#define CR4_PGE_MASK  (1U << 7)
+#define CR4_PCE_MASK  (1U << 8)
+#define CR4_OSFXSR_SHIFT 9
+#define CR4_OSFXSR_MASK (1U << CR4_OSFXSR_SHIFT)
+#define CR4_OSXMMEXCPT_MASK  (1U << 10)
+#define CR4_UMIP_MASK   (1U << 11)
+#define CR4_LA57_MASK   (1U << 12)
+#define CR4_VMXE_MASK   (1U << 13)
+#define CR4_SMXE_MASK   (1U << 14)
+#define CR4_FSGSBASE_MASK (1U << 16)
+#define CR4_PCIDE_MASK  (1U << 17)
+#define CR4_OSXSAVE_MASK (1U << 18)
+#define CR4_SMEP_MASK   (1U << 20)
+#define CR4_SMAP_MASK   (1U << 21)
+#define CR4_PKE_MASK   (1U << 22)
+#define CR4_PKS_MASK   (1U << 24)
+#define CR4_LAM_SUP_MASK (1U << 28)
+
+#ifdef TARGET_X86_64
+#define CR4_FRED_MASK   (1ULL << 32)
+#else
+#define CR4_FRED_MASK   0
+#endif
+
+#define CR4_RESERVED_MASK \
+(~(target_ulong)(CR4_VME_MASK | CR4_PVI_MASK | CR4_TSD_MASK \
+                | CR4_DE_MASK | CR4_PSE_MASK | CR4_PAE_MASK \
+                | CR4_MCE_MASK | CR4_PGE_MASK | CR4_PCE_MASK \
+                | CR4_OSFXSR_MASK | CR4_OSXMMEXCPT_MASK | CR4_UMIP_MASK \
+                | CR4_LA57_MASK \
+                | CR4_FSGSBASE_MASK | CR4_PCIDE_MASK | CR4_OSXSAVE_MASK \
+                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK \
+                | CR4_LAM_SUP_MASK | CR4_FRED_MASK))
+
+#define DR6_BD          (1 << 13)
+#define DR6_BS          (1 << 14)
+#define DR6_BT          (1 << 15)
+#define DR6_FIXED_1     0xffff0ff0
+
+#define DR7_GD          (1 << 13)
+#define DR7_TYPE_SHIFT  16
+#define DR7_LEN_SHIFT   18
+#define DR7_FIXED_1     0x00000400
+#define DR7_GLOBAL_BP_MASK   0xaa
+#define DR7_LOCAL_BP_MASK    0x55
+#define DR7_MAX_BP           4
+#define DR7_TYPE_BP_INST     0x0
+#define DR7_TYPE_DATA_WR     0x1
+#define DR7_TYPE_IO_RW       0x2
+#define DR7_TYPE_DATA_RW     0x3
+
+#define DR_RESERVED_MASK 0xffffffff00000000ULL
+
+#define PG_PRESENT_BIT  0
+#define PG_RW_BIT       1
+#define PG_USER_BIT     2
+#define PG_PWT_BIT      3
+#define PG_PCD_BIT      4
+#define PG_ACCESSED_BIT 5
+#define PG_DIRTY_BIT    6
+#define PG_PSE_BIT      7
+#define PG_GLOBAL_BIT   8
+#define PG_PSE_PAT_BIT  12
+#define PG_PKRU_BIT     59
+#define PG_NX_BIT       63
+
+#define PG_PRESENT_MASK  (1 << PG_PRESENT_BIT)
+#define PG_RW_MASK       (1 << PG_RW_BIT)
+#define PG_USER_MASK     (1 << PG_USER_BIT)
+#define PG_PWT_MASK      (1 << PG_PWT_BIT)
+#define PG_PCD_MASK      (1 << PG_PCD_BIT)
+#define PG_ACCESSED_MASK (1 << PG_ACCESSED_BIT)
+#define PG_DIRTY_MASK    (1 << PG_DIRTY_BIT)
+#define PG_PSE_MASK      (1 << PG_PSE_BIT)
+#define PG_GLOBAL_MASK   (1 << PG_GLOBAL_BIT)
+#define PG_PSE_PAT_MASK  (1 << PG_PSE_PAT_BIT)
+#define PG_ADDRESS_MASK  0x000ffffffffff000LL
+#define PG_HI_USER_MASK  0x7ff0000000000000LL
+#define PG_PKRU_MASK     (15ULL << PG_PKRU_BIT)
+#define PG_NX_MASK       (1ULL << PG_NX_BIT)
+
+#define PG_ERROR_W_BIT     1
+
+#define PG_ERROR_P_MASK    0x01
+#define PG_ERROR_W_MASK    (1 << PG_ERROR_W_BIT)
+#define PG_ERROR_U_MASK    0x04
+#define PG_ERROR_RSVD_MASK 0x08
+#define PG_ERROR_I_D_MASK  0x10
+#define PG_ERROR_PK_MASK   0x20
+
+#define PG_MODE_PAE      (1 << 0)
+#define PG_MODE_LMA      (1 << 1)
+#define PG_MODE_NXE      (1 << 2)
+#define PG_MODE_PSE      (1 << 3)
+#define PG_MODE_LA57     (1 << 4)
+#define PG_MODE_SVM_MASK MAKE_64BIT_MASK(0, 15)
+
+/* Bits of CR4 that do not affect the NPT page format.  */
+#define PG_MODE_WP       (1 << 16)
+#define PG_MODE_PKE      (1 << 17)
+#define PG_MODE_PKS      (1 << 18)
+#define PG_MODE_SMEP     (1 << 19)
+#define PG_MODE_PG       (1 << 20)
+
+#define MCG_CTL_P       (1ULL<<8)   /* MCG_CAP register available */
+#define MCG_SER_P       (1ULL<<24) /* MCA recovery/new status bits */
+#define MCG_LMCE_P      (1ULL<<27) /* Local Machine Check Supported */
+
+#define MCE_CAP_DEF     (MCG_CTL_P|MCG_SER_P)
+#define MCE_BANKS_DEF   10
+
+#define MCG_CAP_BANKS_MASK 0xff
+
+#define MCG_STATUS_RIPV (1ULL<<0)   /* restart ip valid */
+#define MCG_STATUS_EIPV (1ULL<<1)   /* ip points to correct instruction */
+#define MCG_STATUS_MCIP (1ULL<<2)   /* machine check in progress */
+#define MCG_STATUS_LMCE (1ULL<<3)   /* Local MCE signaled */
+
+#define MCG_EXT_CTL_LMCE_EN (1ULL<<0) /* Local MCE enabled */
+
+#define MCI_STATUS_VAL   (1ULL<<63)  /* valid error */
+#define MCI_STATUS_OVER  (1ULL<<62)  /* previous errors lost */
+#define MCI_STATUS_UC    (1ULL<<61)  /* uncorrected error */
+#define MCI_STATUS_EN    (1ULL<<60)  /* error enabled */
+#define MCI_STATUS_MISCV (1ULL<<59)  /* misc error reg. valid */
+#define MCI_STATUS_ADDRV (1ULL<<58)  /* addr reg. valid */
+#define MCI_STATUS_PCC   (1ULL<<57)  /* processor context corrupt */
+#define MCI_STATUS_S     (1ULL<<56)  /* Signaled machine check */
+#define MCI_STATUS_AR    (1ULL<<55)  /* Action required */
+#define MCI_STATUS_DEFERRED    (1ULL<<44)  /* Deferred error */
+#define MCI_STATUS_POISON      (1ULL<<43)  /* Poisoned data consumed */
+
+/* MISC register defines */
+#define MCM_ADDR_SEGOFF  0      /* segment offset */
+#define MCM_ADDR_LINEAR  1      /* linear address */
+#define MCM_ADDR_PHYS    2      /* physical address */
+#define MCM_ADDR_MEM     3      /* memory address */
+#define MCM_ADDR_GENERIC 7      /* generic */
+
+#define MSR_IA32_TSC                    0x10
+#define MSR_IA32_APICBASE               0x1b
+#define MSR_IA32_APICBASE_BSP           (1<<8)
+#define MSR_IA32_APICBASE_ENABLE        (1<<11)
+#define MSR_IA32_APICBASE_EXTD          (1 << 10)
+#define MSR_IA32_APICBASE_BASE          (0xfffffU<<12)
+#define MSR_IA32_APICBASE_RESERVED \
+        (~(uint64_t)(MSR_IA32_APICBASE_BSP | MSR_IA32_APICBASE_ENABLE \
+                     | MSR_IA32_APICBASE_EXTD | MSR_IA32_APICBASE_BASE))
+
+#define MSR_IA32_FEATURE_CONTROL        0x0000003a
+#define MSR_TSC_ADJUST                  0x0000003b
+#define MSR_IA32_SPEC_CTRL              0x48
+#define MSR_VIRT_SSBD                   0xc001011f
+#define MSR_IA32_PRED_CMD               0x49
+#define MSR_IA32_UCODE_REV              0x8b
+#define MSR_IA32_CORE_CAPABILITY        0xcf
+
+#define MSR_IA32_ARCH_CAPABILITIES      0x10a
+#define ARCH_CAP_TSX_CTRL_MSR		(1<<7)
+
+#define MSR_IA32_PERF_CAPABILITIES      0x345
+#define PERF_CAP_LBR_FMT                0x3f
+
+#define MSR_IA32_TSX_CTRL		0x122
+#define MSR_IA32_TSCDEADLINE            0x6e0
+#define MSR_IA32_PKRS                   0x6e1
+#define MSR_RAPL_POWER_UNIT             0x00000606
+#define MSR_PKG_POWER_LIMIT             0x00000610
+#define MSR_PKG_ENERGY_STATUS           0x00000611
+#define MSR_PKG_POWER_INFO              0x00000614
+#define MSR_ARCH_LBR_CTL                0x000014ce
+#define MSR_ARCH_LBR_DEPTH              0x000014cf
+#define MSR_ARCH_LBR_FROM_0             0x00001500
+#define MSR_ARCH_LBR_TO_0               0x00001600
+#define MSR_ARCH_LBR_INFO_0             0x00001200
+
+#define FEATURE_CONTROL_LOCKED                    (1<<0)
+#define FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX  (1ULL << 1)
+#define FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX (1<<2)
+#define FEATURE_CONTROL_SGX_LC                    (1ULL << 17)
+#define FEATURE_CONTROL_SGX                       (1ULL << 18)
+#define FEATURE_CONTROL_LMCE                      (1<<20)
+
+#define MSR_IA32_SGXLEPUBKEYHASH0       0x8c
+#define MSR_IA32_SGXLEPUBKEYHASH1       0x8d
+#define MSR_IA32_SGXLEPUBKEYHASH2       0x8e
+#define MSR_IA32_SGXLEPUBKEYHASH3       0x8f
+
+#define MSR_P6_PERFCTR0                 0xc1
+
+#define MSR_IA32_SMBASE                 0x9e
+#define MSR_SMI_COUNT                   0x34
+#define MSR_CORE_THREAD_COUNT           0x35
+#define MSR_MTRRcap                     0xfe
+#define MSR_MTRRcap_VCNT                8
+#define MSR_MTRRcap_FIXRANGE_SUPPORT    (1 << 8)
+#define MSR_MTRRcap_WC_SUPPORTED        (1 << 10)
+
+#define MSR_IA32_SYSENTER_CS            0x174
+#define MSR_IA32_SYSENTER_ESP           0x175
+#define MSR_IA32_SYSENTER_EIP           0x176
+
+#define MSR_MCG_CAP                     0x179
+#define MSR_MCG_STATUS                  0x17a
+#define MSR_MCG_CTL                     0x17b
+#define MSR_MCG_EXT_CTL                 0x4d0
+
+#define MSR_P6_EVNTSEL0                 0x186
+
+#define MSR_IA32_PERF_STATUS            0x198
+
+#define MSR_IA32_MISC_ENABLE            0x1a0
+/* Indicates good rep/movs microcode on some processors: */
+#define MSR_IA32_MISC_ENABLE_DEFAULT    1
+#define MSR_IA32_MISC_ENABLE_MWAIT      (1ULL << 18)
+
+#define MSR_MTRRphysBase(reg)           (0x200 + 2 * (reg))
+#define MSR_MTRRphysMask(reg)           (0x200 + 2 * (reg) + 1)
+
+#define MSR_MTRRphysIndex(addr)         ((((addr) & ~1u) - 0x200) / 2)
+
+#define MSR_MTRRfix64K_00000            0x250
+#define MSR_MTRRfix16K_80000            0x258
+#define MSR_MTRRfix16K_A0000            0x259
+#define MSR_MTRRfix4K_C0000             0x268
+#define MSR_MTRRfix4K_C8000             0x269
+#define MSR_MTRRfix4K_D0000             0x26a
+#define MSR_MTRRfix4K_D8000             0x26b
+#define MSR_MTRRfix4K_E0000             0x26c
+#define MSR_MTRRfix4K_E8000             0x26d
+#define MSR_MTRRfix4K_F0000             0x26e
+#define MSR_MTRRfix4K_F8000             0x26f
+
+#define MSR_PAT                         0x277
+
+#define MSR_MTRRdefType                 0x2ff
+
+#define MSR_CORE_PERF_FIXED_CTR0        0x309
+#define MSR_CORE_PERF_FIXED_CTR1        0x30a
+#define MSR_CORE_PERF_FIXED_CTR2        0x30b
+#define MSR_CORE_PERF_FIXED_CTR_CTRL    0x38d
+#define MSR_CORE_PERF_GLOBAL_STATUS     0x38e
+#define MSR_CORE_PERF_GLOBAL_CTRL       0x38f
+#define MSR_CORE_PERF_GLOBAL_OVF_CTRL   0x390
+
+#define MSR_MC0_CTL                     0x400
+#define MSR_MC0_STATUS                  0x401
+#define MSR_MC0_ADDR                    0x402
+#define MSR_MC0_MISC                    0x403
+
+#define MSR_IA32_RTIT_OUTPUT_BASE       0x560
+#define MSR_IA32_RTIT_OUTPUT_MASK       0x561
+#define MSR_IA32_RTIT_CTL               0x570
+#define MSR_IA32_RTIT_STATUS            0x571
+#define MSR_IA32_RTIT_CR3_MATCH         0x572
+#define MSR_IA32_RTIT_ADDR0_A           0x580
+#define MSR_IA32_RTIT_ADDR0_B           0x581
+#define MSR_IA32_RTIT_ADDR1_A           0x582
+#define MSR_IA32_RTIT_ADDR1_B           0x583
+#define MSR_IA32_RTIT_ADDR2_A           0x584
+#define MSR_IA32_RTIT_ADDR2_B           0x585
+#define MSR_IA32_RTIT_ADDR3_A           0x586
+#define MSR_IA32_RTIT_ADDR3_B           0x587
+#define MAX_RTIT_ADDRS                  8
+
+#define MSR_EFER                        0xc0000080
+
+#define MSR_EFER_SCE   (1 << 0)
+#define MSR_EFER_LME   (1 << 8)
+#define MSR_EFER_LMA   (1 << 10)
+#define MSR_EFER_NXE   (1 << 11)
+#define MSR_EFER_SVME  (1 << 12)
+#define MSR_EFER_FFXSR (1 << 14)
+
+#define MSR_EFER_RESERVED\
+        (~(target_ulong)(MSR_EFER_SCE | MSR_EFER_LME\
+            | MSR_EFER_LMA | MSR_EFER_NXE | MSR_EFER_SVME\
+            | MSR_EFER_FFXSR))
+
+#define MSR_STAR                        0xc0000081
+#define MSR_LSTAR                       0xc0000082
+#define MSR_CSTAR                       0xc0000083
+#define MSR_FMASK                       0xc0000084
+#define MSR_FSBASE                      0xc0000100
+#define MSR_GSBASE                      0xc0000101
+#define MSR_KERNELGSBASE                0xc0000102
+#define MSR_TSC_AUX                     0xc0000103
+#define MSR_AMD64_TSC_RATIO             0xc0000104
+
+#define MSR_AMD64_TSC_RATIO_DEFAULT     0x100000000ULL
+
+#define MSR_K7_HWCR                     0xc0010015
+
+#define MSR_VM_HSAVE_PA                 0xc0010117
+
+#define MSR_IA32_XFD                    0x000001c4
+#define MSR_IA32_XFD_ERR                0x000001c5
+
+/* FRED MSRs */
+#define MSR_IA32_FRED_RSP0              0x000001cc       /* Stack level 0 regular stack pointer */
+#define MSR_IA32_FRED_RSP1              0x000001cd       /* Stack level 1 regular stack pointer */
+#define MSR_IA32_FRED_RSP2              0x000001ce       /* Stack level 2 regular stack pointer */
+#define MSR_IA32_FRED_RSP3              0x000001cf       /* Stack level 3 regular stack pointer */
+#define MSR_IA32_FRED_STKLVLS           0x000001d0       /* FRED exception stack levels */
+#define MSR_IA32_FRED_SSP1              0x000001d1       /* Stack level 1 shadow stack pointer in ring 0 */
+#define MSR_IA32_FRED_SSP2              0x000001d2       /* Stack level 2 shadow stack pointer in ring 0 */
+#define MSR_IA32_FRED_SSP3              0x000001d3       /* Stack level 3 shadow stack pointer in ring 0 */
+#define MSR_IA32_FRED_CONFIG            0x000001d4       /* FRED Entrypoint and interrupt stack level */
+
+#define MSR_IA32_BNDCFGS                0x00000d90
+#define MSR_IA32_XSS                    0x00000da0
+#define MSR_IA32_UMWAIT_CONTROL         0xe1
+
+#define MSR_IA32_VMX_BASIC              0x00000480
+#define MSR_IA32_VMX_PINBASED_CTLS      0x00000481
+#define MSR_IA32_VMX_PROCBASED_CTLS     0x00000482
+#define MSR_IA32_VMX_EXIT_CTLS          0x00000483
+#define MSR_IA32_VMX_ENTRY_CTLS         0x00000484
+#define MSR_IA32_VMX_MISC               0x00000485
+#define MSR_IA32_VMX_CR0_FIXED0         0x00000486
+#define MSR_IA32_VMX_CR0_FIXED1         0x00000487
+#define MSR_IA32_VMX_CR4_FIXED0         0x00000488
+#define MSR_IA32_VMX_CR4_FIXED1         0x00000489
+#define MSR_IA32_VMX_VMCS_ENUM          0x0000048a
+#define MSR_IA32_VMX_PROCBASED_CTLS2    0x0000048b
+#define MSR_IA32_VMX_EPT_VPID_CAP       0x0000048c
+#define MSR_IA32_VMX_TRUE_PINBASED_CTLS  0x0000048d
+#define MSR_IA32_VMX_TRUE_PROCBASED_CTLS 0x0000048e
+#define MSR_IA32_VMX_TRUE_EXIT_CTLS      0x0000048f
+#define MSR_IA32_VMX_TRUE_ENTRY_CTLS     0x00000490
+#define MSR_IA32_VMX_VMFUNC             0x00000491
+
+#define MSR_APIC_START                  0x00000800
+#define MSR_APIC_END                    0x000008ff
+
+#define XSTATE_FP_BIT                   0
+#define XSTATE_SSE_BIT                  1
+#define XSTATE_YMM_BIT                  2
+#define XSTATE_BNDREGS_BIT              3
+#define XSTATE_BNDCSR_BIT               4
+#define XSTATE_OPMASK_BIT               5
+#define XSTATE_ZMM_Hi256_BIT            6
+#define XSTATE_Hi16_ZMM_BIT             7
+#define XSTATE_PKRU_BIT                 9
+#define XSTATE_ARCH_LBR_BIT             15
+#define XSTATE_XTILE_CFG_BIT            17
+#define XSTATE_XTILE_DATA_BIT           18
+
+#define XSTATE_FP_MASK                  (1ULL << XSTATE_FP_BIT)
+#define XSTATE_SSE_MASK                 (1ULL << XSTATE_SSE_BIT)
+#define XSTATE_YMM_MASK                 (1ULL << XSTATE_YMM_BIT)
+#define XSTATE_BNDREGS_MASK             (1ULL << XSTATE_BNDREGS_BIT)
+#define XSTATE_BNDCSR_MASK              (1ULL << XSTATE_BNDCSR_BIT)
+#define XSTATE_OPMASK_MASK              (1ULL << XSTATE_OPMASK_BIT)
+#define XSTATE_ZMM_Hi256_MASK           (1ULL << XSTATE_ZMM_Hi256_BIT)
+#define XSTATE_Hi16_ZMM_MASK            (1ULL << XSTATE_Hi16_ZMM_BIT)
+#define XSTATE_PKRU_MASK                (1ULL << XSTATE_PKRU_BIT)
+#define XSTATE_ARCH_LBR_MASK            (1ULL << XSTATE_ARCH_LBR_BIT)
+#define XSTATE_XTILE_CFG_MASK           (1ULL << XSTATE_XTILE_CFG_BIT)
+#define XSTATE_XTILE_DATA_MASK          (1ULL << XSTATE_XTILE_DATA_BIT)
+
+#define XSTATE_DYNAMIC_MASK             (XSTATE_XTILE_DATA_MASK)
+
+#define ESA_FEATURE_ALIGN64_BIT         1
+#define ESA_FEATURE_XFD_BIT             2
+
+#define ESA_FEATURE_ALIGN64_MASK        (1U << ESA_FEATURE_ALIGN64_BIT)
+#define ESA_FEATURE_XFD_MASK            (1U << ESA_FEATURE_XFD_BIT)
+
+
+/* CPUID feature bits available in XCR0 */
+#define CPUID_XSTATE_XCR0_MASK  (XSTATE_FP_MASK | XSTATE_SSE_MASK | \
+                                 XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | \
+                                 XSTATE_BNDCSR_MASK | XSTATE_OPMASK_MASK | \
+                                 XSTATE_ZMM_Hi256_MASK | \
+                                 XSTATE_Hi16_ZMM_MASK | XSTATE_PKRU_MASK | \
+                                 XSTATE_XTILE_CFG_MASK | XSTATE_XTILE_DATA_MASK)
+
+/* CPUID feature words */
+typedef enum FeatureWord {
+    FEAT_1_EDX,         /* CPUID[1].EDX */
+    FEAT_1_ECX,         /* CPUID[1].ECX */
+    FEAT_7_0_EBX,       /* CPUID[EAX=7,ECX=0].EBX */
+    FEAT_7_0_ECX,       /* CPUID[EAX=7,ECX=0].ECX */
+    FEAT_7_0_EDX,       /* CPUID[EAX=7,ECX=0].EDX */
+    FEAT_7_1_EAX,       /* CPUID[EAX=7,ECX=1].EAX */
+    FEAT_8000_0001_EDX, /* CPUID[8000_0001].EDX */
+    FEAT_8000_0001_ECX, /* CPUID[8000_0001].ECX */
+    FEAT_8000_0007_EBX, /* CPUID[8000_0007].EBX */
+    FEAT_8000_0007_EDX, /* CPUID[8000_0007].EDX */
+    FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
+    FEAT_8000_0021_EAX, /* CPUID[8000_0021].EAX */
+    FEAT_8000_0021_EBX, /* CPUID[8000_0021].EBX */
+    FEAT_8000_0022_EAX, /* CPUID[8000_0022].EAX */
+    FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
+    FEAT_KVM,           /* CPUID[4000_0001].EAX (KVM_CPUID_FEATURES) */
+    FEAT_KVM_HINTS,     /* CPUID[4000_0001].EDX */
+    FEAT_SVM,           /* CPUID[8000_000A].EDX */
+    FEAT_XSAVE,         /* CPUID[EAX=0xd,ECX=1].EAX */
+    FEAT_6_EAX,         /* CPUID[6].EAX */
+    FEAT_XSAVE_XCR0_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
+    FEAT_XSAVE_XCR0_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
+    FEAT_ARCH_CAPABILITIES,
+    FEAT_CORE_CAPABILITY,
+    FEAT_PERF_CAPABILITIES,
+    FEAT_VMX_PROCBASED_CTLS,
+    FEAT_VMX_SECONDARY_CTLS,
+    FEAT_VMX_PINBASED_CTLS,
+    FEAT_VMX_EXIT_CTLS,
+    FEAT_VMX_ENTRY_CTLS,
+    FEAT_VMX_MISC,
+    FEAT_VMX_EPT_VPID_CAPS,
+    FEAT_VMX_BASIC,
+    FEAT_VMX_VMFUNC,
+    FEAT_14_0_ECX,
+    FEAT_SGX_12_0_EAX,  /* CPUID[EAX=0x12,ECX=0].EAX (SGX) */
+    FEAT_SGX_12_0_EBX,  /* CPUID[EAX=0x12,ECX=0].EBX (SGX MISCSELECT[31:0]) */
+    FEAT_SGX_12_1_EAX,  /* CPUID[EAX=0x12,ECX=1].EAX (SGX ATTRIBUTES[31:0]) */
+    FEAT_XSAVE_XSS_LO,     /* CPUID[EAX=0xd,ECX=1].ECX */
+    FEAT_XSAVE_XSS_HI,     /* CPUID[EAX=0xd,ECX=1].EDX */
+    FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
+    FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
+    FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
+    FEATURE_WORDS,
+} FeatureWord;
+
+typedef uint64_t FeatureWordArray[FEATURE_WORDS];
+uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
+
+/* cpuid_features bits */
+#define CPUID_FP87 (1U << 0)
+#define CPUID_VME  (1U << 1)
+#define CPUID_DE   (1U << 2)
+#define CPUID_PSE  (1U << 3)
+#define CPUID_TSC  (1U << 4)
+#define CPUID_MSR  (1U << 5)
+#define CPUID_PAE  (1U << 6)
+#define CPUID_MCE  (1U << 7)
+#define CPUID_CX8  (1U << 8)
+#define CPUID_APIC (1U << 9)
+#define CPUID_SEP  (1U << 11) /* sysenter/sysexit */
+#define CPUID_MTRR (1U << 12)
+#define CPUID_PGE  (1U << 13)
+#define CPUID_MCA  (1U << 14)
+#define CPUID_CMOV (1U << 15)
+#define CPUID_PAT  (1U << 16)
+#define CPUID_PSE36   (1U << 17)
+#define CPUID_PN   (1U << 18)
+#define CPUID_CLFLUSH (1U << 19)
+#define CPUID_DTS (1U << 21)
+#define CPUID_ACPI (1U << 22)
+#define CPUID_MMX  (1U << 23)
+#define CPUID_FXSR (1U << 24)
+#define CPUID_SSE  (1U << 25)
+#define CPUID_SSE2 (1U << 26)
+#define CPUID_SS (1U << 27)
+#define CPUID_HT (1U << 28)
+#define CPUID_TM (1U << 29)
+#define CPUID_IA64 (1U << 30)
+#define CPUID_PBE (1U << 31)
+
+#define CPUID_EXT_SSE3     (1U << 0)
+#define CPUID_EXT_PCLMULQDQ (1U << 1)
+#define CPUID_EXT_DTES64   (1U << 2)
+#define CPUID_EXT_MONITOR  (1U << 3)
+#define CPUID_EXT_DSCPL    (1U << 4)
+#define CPUID_EXT_VMX      (1U << 5)
+#define CPUID_EXT_SMX      (1U << 6)
+#define CPUID_EXT_EST      (1U << 7)
+#define CPUID_EXT_TM2      (1U << 8)
+#define CPUID_EXT_SSSE3    (1U << 9)
+#define CPUID_EXT_CID      (1U << 10)
+#define CPUID_EXT_FMA      (1U << 12)
+#define CPUID_EXT_CX16     (1U << 13)
+#define CPUID_EXT_XTPR     (1U << 14)
+#define CPUID_EXT_PDCM     (1U << 15)
+#define CPUID_EXT_PCID     (1U << 17)
+#define CPUID_EXT_DCA      (1U << 18)
+#define CPUID_EXT_SSE41    (1U << 19)
+#define CPUID_EXT_SSE42    (1U << 20)
+#define CPUID_EXT_X2APIC   (1U << 21)
+#define CPUID_EXT_MOVBE    (1U << 22)
+#define CPUID_EXT_POPCNT   (1U << 23)
+#define CPUID_EXT_TSC_DEADLINE_TIMER (1U << 24)
+#define CPUID_EXT_AES      (1U << 25)
+#define CPUID_EXT_XSAVE    (1U << 26)
+#define CPUID_EXT_OSXSAVE  (1U << 27)
+#define CPUID_EXT_AVX      (1U << 28)
+#define CPUID_EXT_F16C     (1U << 29)
+#define CPUID_EXT_RDRAND   (1U << 30)
+#define CPUID_EXT_HYPERVISOR  (1U << 31)
+
+#define CPUID_EXT2_FPU     (1U << 0)
+#define CPUID_EXT2_VME     (1U << 1)
+#define CPUID_EXT2_DE      (1U << 2)
+#define CPUID_EXT2_PSE     (1U << 3)
+#define CPUID_EXT2_TSC     (1U << 4)
+#define CPUID_EXT2_MSR     (1U << 5)
+#define CPUID_EXT2_PAE     (1U << 6)
+#define CPUID_EXT2_MCE     (1U << 7)
+#define CPUID_EXT2_CX8     (1U << 8)
+#define CPUID_EXT2_APIC    (1U << 9)
+#define CPUID_EXT2_SYSCALL (1U << 11)
+#define CPUID_EXT2_MTRR    (1U << 12)
+#define CPUID_EXT2_PGE     (1U << 13)
+#define CPUID_EXT2_MCA     (1U << 14)
+#define CPUID_EXT2_CMOV    (1U << 15)
+#define CPUID_EXT2_PAT     (1U << 16)
+#define CPUID_EXT2_PSE36   (1U << 17)
+#define CPUID_EXT2_MP      (1U << 19)
+#define CPUID_EXT2_NX      (1U << 20)
+#define CPUID_EXT2_MMXEXT  (1U << 22)
+#define CPUID_EXT2_MMX     (1U << 23)
+#define CPUID_EXT2_FXSR    (1U << 24)
+#define CPUID_EXT2_FFXSR   (1U << 25)
+#define CPUID_EXT2_PDPE1GB (1U << 26)
+#define CPUID_EXT2_RDTSCP  (1U << 27)
+#define CPUID_EXT2_LM      (1U << 29)
+#define CPUID_EXT2_3DNOWEXT (1U << 30)
+#define CPUID_EXT2_3DNOW   (1U << 31)
+
+/* CPUID[8000_0001].EDX bits that are aliases of CPUID[1].EDX bits on AMD CPUs */
+#define CPUID_EXT2_AMD_ALIASES (CPUID_EXT2_FPU | CPUID_EXT2_VME | \
+                                CPUID_EXT2_DE | CPUID_EXT2_PSE | \
+                                CPUID_EXT2_TSC | CPUID_EXT2_MSR | \
+                                CPUID_EXT2_PAE | CPUID_EXT2_MCE | \
+                                CPUID_EXT2_CX8 | CPUID_EXT2_APIC | \
+                                CPUID_EXT2_MTRR | CPUID_EXT2_PGE | \
+                                CPUID_EXT2_MCA | CPUID_EXT2_CMOV | \
+                                CPUID_EXT2_PAT | CPUID_EXT2_PSE36 | \
+                                CPUID_EXT2_MMX | CPUID_EXT2_FXSR)
+
+#define CPUID_EXT3_LAHF_LM (1U << 0)
+#define CPUID_EXT3_CMP_LEG (1U << 1)
+#define CPUID_EXT3_SVM     (1U << 2)
+#define CPUID_EXT3_EXTAPIC (1U << 3)
+#define CPUID_EXT3_CR8LEG  (1U << 4)
+#define CPUID_EXT3_ABM     (1U << 5)
+#define CPUID_EXT3_SSE4A   (1U << 6)
+#define CPUID_EXT3_MISALIGNSSE (1U << 7)
+#define CPUID_EXT3_3DNOWPREFETCH (1U << 8)
+#define CPUID_EXT3_OSVW    (1U << 9)
+#define CPUID_EXT3_IBS     (1U << 10)
+#define CPUID_EXT3_XOP     (1U << 11)
+#define CPUID_EXT3_SKINIT  (1U << 12)
+#define CPUID_EXT3_WDT     (1U << 13)
+#define CPUID_EXT3_LWP     (1U << 15)
+#define CPUID_EXT3_FMA4    (1U << 16)
+#define CPUID_EXT3_TCE     (1U << 17)
+#define CPUID_EXT3_NODEID  (1U << 19)
+#define CPUID_EXT3_TBM     (1U << 21)
+#define CPUID_EXT3_TOPOEXT (1U << 22)
+#define CPUID_EXT3_PERFCORE (1U << 23)
+#define CPUID_EXT3_PERFNB  (1U << 24)
+
+#define CPUID_SVM_NPT             (1U << 0)
+#define CPUID_SVM_LBRV            (1U << 1)
+#define CPUID_SVM_SVMLOCK         (1U << 2)
+#define CPUID_SVM_NRIPSAVE        (1U << 3)
+#define CPUID_SVM_TSCSCALE        (1U << 4)
+#define CPUID_SVM_VMCBCLEAN       (1U << 5)
+#define CPUID_SVM_FLUSHASID       (1U << 6)
+#define CPUID_SVM_DECODEASSIST    (1U << 7)
+#define CPUID_SVM_PAUSEFILTER     (1U << 10)
+#define CPUID_SVM_PFTHRESHOLD     (1U << 12)
+#define CPUID_SVM_AVIC            (1U << 13)
+#define CPUID_SVM_V_VMSAVE_VMLOAD (1U << 15)
+#define CPUID_SVM_VGIF            (1U << 16)
+#define CPUID_SVM_VNMI            (1U << 25)
+#define CPUID_SVM_SVME_ADDR_CHK   (1U << 28)
+
+/* Support RDFSBASE/RDGSBASE/WRFSBASE/WRGSBASE */
+#define CPUID_7_0_EBX_FSGSBASE          (1U << 0)
+/* Support TSC adjust MSR */
+#define CPUID_7_0_EBX_TSC_ADJUST        (1U << 1)
+/* Support SGX */
+#define CPUID_7_0_EBX_SGX               (1U << 2)
+/* 1st Group of Advanced Bit Manipulation Extensions */
+#define CPUID_7_0_EBX_BMI1              (1U << 3)
+/* Hardware Lock Elision */
+#define CPUID_7_0_EBX_HLE               (1U << 4)
+/* Intel Advanced Vector Extensions 2 */
+#define CPUID_7_0_EBX_AVX2              (1U << 5)
+/* FPU data pointer updated only on x87 exceptions */
+#define CPUID_7_0_EBX_FDP_EXCPTN_ONLY (1u << 6)
+/* Supervisor-mode Execution Prevention */
+#define CPUID_7_0_EBX_SMEP              (1U << 7)
+/* 2nd Group of Advanced Bit Manipulation Extensions */
+#define CPUID_7_0_EBX_BMI2              (1U << 8)
+/* Enhanced REP MOVSB/STOSB */
+#define CPUID_7_0_EBX_ERMS              (1U << 9)
+/* Invalidate Process-Context Identifier */
+#define CPUID_7_0_EBX_INVPCID           (1U << 10)
+/* Restricted Transactional Memory */
+#define CPUID_7_0_EBX_RTM               (1U << 11)
+/* Zero out FPU CS and FPU DS */
+#define CPUID_7_0_EBX_ZERO_FCS_FDS      (1U << 13)
+/* Memory Protection Extension */
+#define CPUID_7_0_EBX_MPX               (1U << 14)
+/* AVX-512 Foundation */
+#define CPUID_7_0_EBX_AVX512F           (1U << 16)
+/* AVX-512 Doubleword & Quadword Instruction */
+#define CPUID_7_0_EBX_AVX512DQ          (1U << 17)
+/* Read Random SEED */
+#define CPUID_7_0_EBX_RDSEED            (1U << 18)
+/* ADCX and ADOX instructions */
+#define CPUID_7_0_EBX_ADX               (1U << 19)
+/* Supervisor Mode Access Prevention */
+#define CPUID_7_0_EBX_SMAP              (1U << 20)
+/* AVX-512 Integer Fused Multiply Add */
+#define CPUID_7_0_EBX_AVX512IFMA        (1U << 21)
+/* Flush a Cache Line Optimized */
+#define CPUID_7_0_EBX_CLFLUSHOPT        (1U << 23)
+/* Cache Line Write Back */
+#define CPUID_7_0_EBX_CLWB              (1U << 24)
+/* Intel Processor Trace */
+#define CPUID_7_0_EBX_INTEL_PT          (1U << 25)
+/* AVX-512 Prefetch */
+#define CPUID_7_0_EBX_AVX512PF          (1U << 26)
+/* AVX-512 Exponential and Reciprocal */
+#define CPUID_7_0_EBX_AVX512ER          (1U << 27)
+/* AVX-512 Conflict Detection */
+#define CPUID_7_0_EBX_AVX512CD          (1U << 28)
+/* SHA1/SHA256 Instruction Extensions */
+#define CPUID_7_0_EBX_SHA_NI            (1U << 29)
+/* AVX-512 Byte and Word Instructions */
+#define CPUID_7_0_EBX_AVX512BW          (1U << 30)
+/* AVX-512 Vector Length Extensions */
+#define CPUID_7_0_EBX_AVX512VL          (1U << 31)
+
+/* AVX-512 Vector Byte Manipulation Instruction */
+#define CPUID_7_0_ECX_AVX512_VBMI       (1U << 1)
+/* User-Mode Instruction Prevention */
+#define CPUID_7_0_ECX_UMIP              (1U << 2)
+/* Protection Keys for User-mode Pages */
+#define CPUID_7_0_ECX_PKU               (1U << 3)
+/* OS Enable Protection Keys */
+#define CPUID_7_0_ECX_OSPKE             (1U << 4)
+/* UMONITOR/UMWAIT/TPAUSE Instructions */
+#define CPUID_7_0_ECX_WAITPKG           (1U << 5)
+/* Additional AVX-512 Vector Byte Manipulation Instruction */
+#define CPUID_7_0_ECX_AVX512_VBMI2      (1U << 6)
+/* Galois Field New Instructions */
+#define CPUID_7_0_ECX_GFNI              (1U << 8)
+/* Vector AES Instructions */
+#define CPUID_7_0_ECX_VAES              (1U << 9)
+/* Carry-Less Multiplication Quadword */
+#define CPUID_7_0_ECX_VPCLMULQDQ        (1U << 10)
+/* Vector Neural Network Instructions */
+#define CPUID_7_0_ECX_AVX512VNNI        (1U << 11)
+/* Support for VPOPCNT[B,W] and VPSHUFBITQMB */
+#define CPUID_7_0_ECX_AVX512BITALG      (1U << 12)
+/* POPCNT for vectors of DW/QW */
+#define CPUID_7_0_ECX_AVX512_VPOPCNTDQ  (1U << 14)
+/* 5-level Page Tables */
+#define CPUID_7_0_ECX_LA57              (1U << 16)
+/* Read Processor ID */
+#define CPUID_7_0_ECX_RDPID             (1U << 22)
+/* Bus Lock Debug Exception */
+#define CPUID_7_0_ECX_BUS_LOCK_DETECT   (1U << 24)
+/* Cache Line Demote Instruction */
+#define CPUID_7_0_ECX_CLDEMOTE          (1U << 25)
+/* Move Doubleword as Direct Store Instruction */
+#define CPUID_7_0_ECX_MOVDIRI           (1U << 27)
+/* Move 64 Bytes as Direct Store Instruction */
+#define CPUID_7_0_ECX_MOVDIR64B         (1U << 28)
+/* Support SGX Launch Control */
+#define CPUID_7_0_ECX_SGX_LC            (1U << 30)
+/* Protection Keys for Supervisor-mode Pages */
+#define CPUID_7_0_ECX_PKS               (1U << 31)
+
+/* AVX512 Neural Network Instructions */
+#define CPUID_7_0_EDX_AVX512_4VNNIW     (1U << 2)
+/* AVX512 Multiply Accumulation Single Precision */
+#define CPUID_7_0_EDX_AVX512_4FMAPS     (1U << 3)
+/* Fast Short Rep Mov */
+#define CPUID_7_0_EDX_FSRM              (1U << 4)
+/* AVX512 Vector Pair Intersection to a Pair of Mask Registers */
+#define CPUID_7_0_EDX_AVX512_VP2INTERSECT (1U << 8)
+/* SERIALIZE instruction */
+#define CPUID_7_0_EDX_SERIALIZE         (1U << 14)
+/* TSX Suspend Load Address Tracking instruction */
+#define CPUID_7_0_EDX_TSX_LDTRK         (1U << 16)
+/* Architectural LBRs */
+#define CPUID_7_0_EDX_ARCH_LBR          (1U << 19)
+/* AMX_BF16 instruction */
+#define CPUID_7_0_EDX_AMX_BF16          (1U << 22)
+/* AVX512_FP16 instruction */
+#define CPUID_7_0_EDX_AVX512_FP16       (1U << 23)
+/* AMX tile (two-dimensional register) */
+#define CPUID_7_0_EDX_AMX_TILE          (1U << 24)
+/* AMX_INT8 instruction */
+#define CPUID_7_0_EDX_AMX_INT8          (1U << 25)
+/* Speculation Control */
+#define CPUID_7_0_EDX_SPEC_CTRL         (1U << 26)
+/* Single Thread Indirect Branch Predictors */
+#define CPUID_7_0_EDX_STIBP             (1U << 27)
+/* Flush L1D cache */
+#define CPUID_7_0_EDX_FLUSH_L1D         (1U << 28)
+/* Arch Capabilities */
+#define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)
+/* Core Capability */
+#define CPUID_7_0_EDX_CORE_CAPABILITY   (1U << 30)
+/* Speculative Store Bypass Disable */
+#define CPUID_7_0_EDX_SPEC_CTRL_SSBD    (1U << 31)
+
+/* AVX VNNI Instruction */
+#define CPUID_7_1_EAX_AVX_VNNI          (1U << 4)
+/* AVX512 BFloat16 Instruction */
+#define CPUID_7_1_EAX_AVX512_BF16       (1U << 5)
+/* CMPCCXADD Instructions */
+#define CPUID_7_1_EAX_CMPCCXADD         (1U << 7)
+/* Fast Zero REP MOVS */
+#define CPUID_7_1_EAX_FZRM              (1U << 10)
+/* Fast Short REP STOS */
+#define CPUID_7_1_EAX_FSRS              (1U << 11)
+/* Fast Short REP CMPS/SCAS */
+#define CPUID_7_1_EAX_FSRC              (1U << 12)
+/* Support Tile Computational Operations on FP16 Numbers */
+#define CPUID_7_1_EAX_AMX_FP16          (1U << 21)
+/* Support for VPMADD52[H,L]UQ */
+#define CPUID_7_1_EAX_AVX_IFMA          (1U << 23)
+/* Linear Address Masking */
+#define CPUID_7_1_EAX_LAM               (1U << 26)
+
+/* Support for VPDPB[SU,UU,SS]D[,S] */
+#define CPUID_7_1_EDX_AVX_VNNI_INT8     (1U << 4)
+/* AVX NE CONVERT Instructions */
+#define CPUID_7_1_EDX_AVX_NE_CONVERT    (1U << 5)
+/* AMX COMPLEX Instructions */
+#define CPUID_7_1_EDX_AMX_COMPLEX       (1U << 8)
+/* PREFETCHIT0/1 Instructions */
+#define CPUID_7_1_EDX_PREFETCHITI       (1U << 14)
+/* Support for Advanced Vector Extensions 10 */
+#define CPUID_7_1_EDX_AVX10             (1U << 19)
+/* Flexible return and event delivery (FRED) */
+#define CPUID_7_1_EAX_FRED              (1U << 17)
+/* Load into IA32_KERNEL_GS_BASE (LKGS) */
+#define CPUID_7_1_EAX_LKGS              (1U << 18)
+/* Non-Serializing Write to Model Specific Register (WRMSRNS) */
+#define CPUID_7_1_EAX_WRMSRNS           (1U << 19)
+
+/* Do not exhibit MXCSR Configuration Dependent Timing (MCDT) behavior */
+#define CPUID_7_2_EDX_MCDT_NO           (1U << 5)
+
+/* XFD Extend Feature Disabled */
+#define CPUID_D_1_EAX_XFD               (1U << 4)
+
+/* Packets which contain IP payload have LIP values */
+#define CPUID_14_0_ECX_LIP              (1U << 31)
+
+/* AVX10 128-bit vector support is present */
+#define CPUID_24_0_EBX_AVX10_128        (1U << 16)
+/* AVX10 256-bit vector support is present */
+#define CPUID_24_0_EBX_AVX10_256        (1U << 17)
+/* AVX10 512-bit vector support is present */
+#define CPUID_24_0_EBX_AVX10_512        (1U << 18)
+/* AVX10 vector length support mask */
+#define CPUID_24_0_EBX_AVX10_VL_MASK    (CPUID_24_0_EBX_AVX10_128 | \
+                                         CPUID_24_0_EBX_AVX10_256 | \
+                                         CPUID_24_0_EBX_AVX10_512)
+
+/* RAS Features */
+#define CPUID_8000_0007_EBX_OVERFLOW_RECOV    (1U << 0)
+#define CPUID_8000_0007_EBX_SUCCOR      (1U << 1)
+
+/* CLZERO instruction */
+#define CPUID_8000_0008_EBX_CLZERO      (1U << 0)
+/* Always save/restore FP error pointers */
+#define CPUID_8000_0008_EBX_XSAVEERPTR  (1U << 2)
+/* Write back and do not invalidate cache */
+#define CPUID_8000_0008_EBX_WBNOINVD    (1U << 9)
+/* Indirect Branch Prediction Barrier */
+#define CPUID_8000_0008_EBX_IBPB        (1U << 12)
+/* Indirect Branch Restricted Speculation */
+#define CPUID_8000_0008_EBX_IBRS        (1U << 14)
+/* Single Thread Indirect Branch Predictors */
+#define CPUID_8000_0008_EBX_STIBP       (1U << 15)
+/* STIBP mode has enhanced performance and may be left always on */
+#define CPUID_8000_0008_EBX_STIBP_ALWAYS_ON    (1U << 17)
+/* Speculative Store Bypass Disable */
+#define CPUID_8000_0008_EBX_AMD_SSBD    (1U << 24)
+/* Paravirtualized Speculative Store Bypass Disable MSR */
+#define CPUID_8000_0008_EBX_VIRT_SSBD   (1U << 25)
+/* Predictive Store Forwarding Disable */
+#define CPUID_8000_0008_EBX_AMD_PSFD    (1U << 28)
+
+/* Processor ignores nested data breakpoints */
+#define CPUID_8000_0021_EAX_NO_NESTED_DATA_BP            (1U << 0)
+/* LFENCE is always serializing */
+#define CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING    (1U << 2)
+/* Null Selector Clears Base */
+#define CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE            (1U << 6)
+/* Automatic IBRS */
+#define CPUID_8000_0021_EAX_AUTO_IBRS                    (1U << 8)
+/* Enhanced Return Address Predictor Scurity */
+#define CPUID_8000_0021_EAX_ERAPS                        (1U << 24)
+/* Selective Branch Predictor Barrier */
+#define CPUID_8000_0021_EAX_SBPB                         (1U << 27)
+/* IBPB includes branch type prediction flushing */
+#define CPUID_8000_0021_EAX_IBPB_BRTYPE                  (1U << 28)
+/* Not vulnerable to Speculative Return Stack Overflow */
+#define CPUID_8000_0021_EAX_SRSO_NO                      (1U << 29)
+/* Not vulnerable to SRSO at the user-kernel boundary */
+#define CPUID_8000_0021_EAX_SRSO_USER_KERNEL_NO          (1U << 30)
+
+/*
+ * Return Address Predictor size. RapSize x 8 is the minimum number of
+ * CALL instructions software needs to execute to flush the RAP.
+ */
+#define CPUID_8000_0021_EBX_RAPSIZE    (8U << 16)
+
+/* Performance Monitoring Version 2 */
+#define CPUID_8000_0022_EAX_PERFMON_V2  (1U << 0)
+
+#define CPUID_XSAVE_XSAVEOPT   (1U << 0)
+#define CPUID_XSAVE_XSAVEC     (1U << 1)
+#define CPUID_XSAVE_XGETBV1    (1U << 2)
+#define CPUID_XSAVE_XSAVES     (1U << 3)
+
+#define CPUID_6_EAX_ARAT       (1U << 2)
+
+/* CPUID[0x80000007].EDX flags: */
+#define CPUID_APM_INVTSC       (1U << 8)
+
+#define CPUID_VENDOR_SZ      12
+
+#define CPUID_VENDOR_INTEL_1 0x756e6547 /* "Genu" */
+#define CPUID_VENDOR_INTEL_2 0x49656e69 /* "ineI" */
+#define CPUID_VENDOR_INTEL_3 0x6c65746e /* "ntel" */
+#define CPUID_VENDOR_INTEL "GenuineIntel"
+
+#define CPUID_VENDOR_AMD_1   0x68747541 /* "Auth" */
+#define CPUID_VENDOR_AMD_2   0x69746e65 /* "enti" */
+#define CPUID_VENDOR_AMD_3   0x444d4163 /* "cAMD" */
+#define CPUID_VENDOR_AMD   "AuthenticAMD"
+
+#define CPUID_VENDOR_VIA   "CentaurHauls"
+
+#define CPUID_VENDOR_HYGON    "HygonGenuine"
+
+#define CPUID_VENDOR_ZHAOXIN   "  Shanghai  "
+
+#define IS_INTEL_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 && \
+                           (env)->cpuid_vendor2 == CPUID_VENDOR_INTEL_2 && \
+                           (env)->cpuid_vendor3 == CPUID_VENDOR_INTEL_3)
+#define IS_AMD_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_AMD_1 && \
+                         (env)->cpuid_vendor2 == CPUID_VENDOR_AMD_2 && \
+                         (env)->cpuid_vendor3 == CPUID_VENDOR_AMD_3)
+
+#define CPUID_MWAIT_IBE     (1U << 1) /* Interrupts can exit capability */
+#define CPUID_MWAIT_EMX     (1U << 0) /* enumeration supported */
+
+/* CPUID[0xB].ECX level types */
+#define CPUID_B_ECX_TOPO_LEVEL_INVALID  0
+#define CPUID_B_ECX_TOPO_LEVEL_SMT      1
+#define CPUID_B_ECX_TOPO_LEVEL_CORE     2
+
+/* COUID[0x1F].ECX level types */
+#define CPUID_1F_ECX_TOPO_LEVEL_INVALID  CPUID_B_ECX_TOPO_LEVEL_INVALID
+#define CPUID_1F_ECX_TOPO_LEVEL_SMT      CPUID_B_ECX_TOPO_LEVEL_SMT
+#define CPUID_1F_ECX_TOPO_LEVEL_CORE     CPUID_B_ECX_TOPO_LEVEL_CORE
+#define CPUID_1F_ECX_TOPO_LEVEL_MODULE   3
+#define CPUID_1F_ECX_TOPO_LEVEL_DIE      5
+
+/* MSR Feature Bits */
+#define MSR_ARCH_CAP_RDCL_NO            (1U << 0)
+#define MSR_ARCH_CAP_IBRS_ALL           (1U << 1)
+#define MSR_ARCH_CAP_RSBA               (1U << 2)
+#define MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY (1U << 3)
+#define MSR_ARCH_CAP_SSB_NO             (1U << 4)
+#define MSR_ARCH_CAP_MDS_NO             (1U << 5)
+#define MSR_ARCH_CAP_PSCHANGE_MC_NO     (1U << 6)
+#define MSR_ARCH_CAP_TSX_CTRL_MSR       (1U << 7)
+#define MSR_ARCH_CAP_TAA_NO             (1U << 8)
+#define MSR_ARCH_CAP_SBDR_SSDP_NO       (1U << 13)
+#define MSR_ARCH_CAP_FBSDP_NO           (1U << 14)
+#define MSR_ARCH_CAP_PSDP_NO            (1U << 15)
+#define MSR_ARCH_CAP_FB_CLEAR           (1U << 17)
+#define MSR_ARCH_CAP_PBRSB_NO           (1U << 24)
+
+#define MSR_CORE_CAP_SPLIT_LOCK_DETECT  (1U << 5)
+
+/* VMX MSR features */
+#define MSR_VMX_BASIC_VMCS_REVISION_MASK             0x7FFFFFFFull
+#define MSR_VMX_BASIC_VMXON_REGION_SIZE_MASK         (0x00001FFFull << 32)
+#define MSR_VMX_BASIC_VMCS_MEM_TYPE_MASK             (0x003C0000ull << 32)
+#define MSR_VMX_BASIC_DUAL_MONITOR                   (1ULL << 49)
+#define MSR_VMX_BASIC_INS_OUTS                       (1ULL << 54)
+#define MSR_VMX_BASIC_TRUE_CTLS                      (1ULL << 55)
+#define MSR_VMX_BASIC_ANY_ERRCODE                    (1ULL << 56)
+#define MSR_VMX_BASIC_NESTED_EXCEPTION               (1ULL << 58)
+
+#define MSR_VMX_MISC_PREEMPTION_TIMER_SHIFT_MASK     0x1Full
+#define MSR_VMX_MISC_STORE_LMA                       (1ULL << 5)
+#define MSR_VMX_MISC_ACTIVITY_HLT                    (1ULL << 6)
+#define MSR_VMX_MISC_ACTIVITY_SHUTDOWN               (1ULL << 7)
+#define MSR_VMX_MISC_ACTIVITY_WAIT_SIPI              (1ULL << 8)
+#define MSR_VMX_MISC_MAX_MSR_LIST_SIZE_MASK          0x0E000000ull
+#define MSR_VMX_MISC_VMWRITE_VMEXIT                  (1ULL << 29)
+#define MSR_VMX_MISC_ZERO_LEN_INJECT                 (1ULL << 30)
+
+#define MSR_VMX_EPT_EXECONLY                         (1ULL << 0)
+#define MSR_VMX_EPT_PAGE_WALK_LENGTH_4               (1ULL << 6)
+#define MSR_VMX_EPT_PAGE_WALK_LENGTH_5               (1ULL << 7)
+#define MSR_VMX_EPT_UC                               (1ULL << 8)
+#define MSR_VMX_EPT_WB                               (1ULL << 14)
+#define MSR_VMX_EPT_2MB                              (1ULL << 16)
+#define MSR_VMX_EPT_1GB                              (1ULL << 17)
+#define MSR_VMX_EPT_INVEPT                           (1ULL << 20)
+#define MSR_VMX_EPT_AD_BITS                          (1ULL << 21)
+#define MSR_VMX_EPT_ADVANCED_VMEXIT_INFO             (1ULL << 22)
+#define MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT            (1ULL << 25)
+#define MSR_VMX_EPT_INVEPT_ALL_CONTEXT               (1ULL << 26)
+#define MSR_VMX_EPT_INVVPID                          (1ULL << 32)
+#define MSR_VMX_EPT_INVVPID_SINGLE_ADDR              (1ULL << 40)
+#define MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT           (1ULL << 41)
+#define MSR_VMX_EPT_INVVPID_ALL_CONTEXT              (1ULL << 42)
+#define MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS (1ULL << 43)
+
+#define MSR_VMX_VMFUNC_EPT_SWITCHING                 (1ULL << 0)
+
+
+/* VMX controls */
+#define VMX_CPU_BASED_VIRTUAL_INTR_PENDING          0x00000004
+#define VMX_CPU_BASED_USE_TSC_OFFSETING             0x00000008
+#define VMX_CPU_BASED_HLT_EXITING                   0x00000080
+#define VMX_CPU_BASED_INVLPG_EXITING                0x00000200
+#define VMX_CPU_BASED_MWAIT_EXITING                 0x00000400
+#define VMX_CPU_BASED_RDPMC_EXITING                 0x00000800
+#define VMX_CPU_BASED_RDTSC_EXITING                 0x00001000
+#define VMX_CPU_BASED_CR3_LOAD_EXITING              0x00008000
+#define VMX_CPU_BASED_CR3_STORE_EXITING             0x00010000
+#define VMX_CPU_BASED_CR8_LOAD_EXITING              0x00080000
+#define VMX_CPU_BASED_CR8_STORE_EXITING             0x00100000
+#define VMX_CPU_BASED_TPR_SHADOW                    0x00200000
+#define VMX_CPU_BASED_VIRTUAL_NMI_PENDING           0x00400000
+#define VMX_CPU_BASED_MOV_DR_EXITING                0x00800000
+#define VMX_CPU_BASED_UNCOND_IO_EXITING             0x01000000
+#define VMX_CPU_BASED_USE_IO_BITMAPS                0x02000000
+#define VMX_CPU_BASED_MONITOR_TRAP_FLAG             0x08000000
+#define VMX_CPU_BASED_USE_MSR_BITMAPS               0x10000000
+#define VMX_CPU_BASED_MONITOR_EXITING               0x20000000
+#define VMX_CPU_BASED_PAUSE_EXITING                 0x40000000
+#define VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS   0x80000000
+
+#define VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES 0x00000001
+#define VMX_SECONDARY_EXEC_ENABLE_EPT               0x00000002
+#define VMX_SECONDARY_EXEC_DESC                     0x00000004
+#define VMX_SECONDARY_EXEC_RDTSCP                   0x00000008
+#define VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE   0x00000010
+#define VMX_SECONDARY_EXEC_ENABLE_VPID              0x00000020
+#define VMX_SECONDARY_EXEC_WBINVD_EXITING           0x00000040
+#define VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST       0x00000080
+#define VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT       0x00000100
+#define VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY    0x00000200
+#define VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING       0x00000400
+#define VMX_SECONDARY_EXEC_RDRAND_EXITING           0x00000800
+#define VMX_SECONDARY_EXEC_ENABLE_INVPCID           0x00001000
+#define VMX_SECONDARY_EXEC_ENABLE_VMFUNC            0x00002000
+#define VMX_SECONDARY_EXEC_SHADOW_VMCS              0x00004000
+#define VMX_SECONDARY_EXEC_ENCLS_EXITING            0x00008000
+#define VMX_SECONDARY_EXEC_RDSEED_EXITING           0x00010000
+#define VMX_SECONDARY_EXEC_ENABLE_PML               0x00020000
+#define VMX_SECONDARY_EXEC_XSAVES                   0x00100000
+#define VMX_SECONDARY_EXEC_TSC_SCALING              0x02000000
+#define VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE   0x04000000
+
+#define VMX_PIN_BASED_EXT_INTR_MASK                 0x00000001
+#define VMX_PIN_BASED_NMI_EXITING                   0x00000008
+#define VMX_PIN_BASED_VIRTUAL_NMIS                  0x00000020
+#define VMX_PIN_BASED_VMX_PREEMPTION_TIMER          0x00000040
+#define VMX_PIN_BASED_POSTED_INTR                   0x00000080
+
+#define VMX_VM_EXIT_SAVE_DEBUG_CONTROLS             0x00000004
+#define VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE            0x00000200
+#define VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL      0x00001000
+#define VMX_VM_EXIT_ACK_INTR_ON_EXIT                0x00008000
+#define VMX_VM_EXIT_SAVE_IA32_PAT                   0x00040000
+#define VMX_VM_EXIT_LOAD_IA32_PAT                   0x00080000
+#define VMX_VM_EXIT_SAVE_IA32_EFER                  0x00100000
+#define VMX_VM_EXIT_LOAD_IA32_EFER                  0x00200000
+#define VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER       0x00400000
+#define VMX_VM_EXIT_CLEAR_BNDCFGS                   0x00800000
+#define VMX_VM_EXIT_PT_CONCEAL_PIP                  0x01000000
+#define VMX_VM_EXIT_CLEAR_IA32_RTIT_CTL             0x02000000
+#define VMX_VM_EXIT_LOAD_IA32_PKRS                  0x20000000
+#define VMX_VM_EXIT_ACTIVATE_SECONDARY_CONTROLS     0x80000000
+
+#define VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS            0x00000004
+#define VMX_VM_ENTRY_IA32E_MODE                     0x00000200
+#define VMX_VM_ENTRY_SMM                            0x00000400
+#define VMX_VM_ENTRY_DEACT_DUAL_MONITOR             0x00000800
+#define VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL     0x00002000
+#define VMX_VM_ENTRY_LOAD_IA32_PAT                  0x00004000
+#define VMX_VM_ENTRY_LOAD_IA32_EFER                 0x00008000
+#define VMX_VM_ENTRY_LOAD_BNDCFGS                   0x00010000
+#define VMX_VM_ENTRY_PT_CONCEAL_PIP                 0x00020000
+#define VMX_VM_ENTRY_LOAD_IA32_RTIT_CTL             0x00040000
+#define VMX_VM_ENTRY_LOAD_IA32_PKRS                 0x00400000
+
+/* Supported Hyper-V Enlightenments */
+#define HYPERV_FEAT_RELAXED             0
+#define HYPERV_FEAT_VAPIC               1
+#define HYPERV_FEAT_TIME                2
+#define HYPERV_FEAT_CRASH               3
+#define HYPERV_FEAT_RESET               4
+#define HYPERV_FEAT_VPINDEX             5
+#define HYPERV_FEAT_RUNTIME             6
+#define HYPERV_FEAT_SYNIC               7
+#define HYPERV_FEAT_STIMER              8
+#define HYPERV_FEAT_FREQUENCIES         9
+#define HYPERV_FEAT_REENLIGHTENMENT     10
+#define HYPERV_FEAT_TLBFLUSH            11
+#define HYPERV_FEAT_EVMCS               12
+#define HYPERV_FEAT_IPI                 13
+#define HYPERV_FEAT_STIMER_DIRECT       14
+#define HYPERV_FEAT_AVIC                15
+#define HYPERV_FEAT_SYNDBG              16
+#define HYPERV_FEAT_MSR_BITMAP          17
+#define HYPERV_FEAT_XMM_INPUT           18
+#define HYPERV_FEAT_TLBFLUSH_EXT        19
+#define HYPERV_FEAT_TLBFLUSH_DIRECT     20
+
+#ifndef HYPERV_SPINLOCK_NEVER_NOTIFY
+#define HYPERV_SPINLOCK_NEVER_NOTIFY             0xFFFFFFFF
+#endif
+
+#define EXCP00_DIVZ	0
+#define EXCP01_DB	1
+#define EXCP02_NMI	2
+#define EXCP03_INT3	3
+#define EXCP04_INTO	4
+#define EXCP05_BOUND	5
+#define EXCP06_ILLOP	6
+#define EXCP07_PREX	7
+#define EXCP08_DBLE	8
+#define EXCP09_XERR	9
+#define EXCP0A_TSS	10
+#define EXCP0B_NOSEG	11
+#define EXCP0C_STACK	12
+#define EXCP0D_GPF	13
+#define EXCP0E_PAGE	14
+#define EXCP10_COPR	16
+#define EXCP11_ALGN	17
+#define EXCP12_MCHK	18
+
+#define EXCP_VMEXIT     0x100 /* only for system emulation */
+#define EXCP_SYSCALL    0x101 /* only for user emulation */
+#define EXCP_VSYSCALL   0x102 /* only for user emulation */
+
+/* i386-specific interrupt pending bits.  */
+#define CPU_INTERRUPT_POLL      CPU_INTERRUPT_TGT_EXT_1
+#define CPU_INTERRUPT_SMI       CPU_INTERRUPT_TGT_EXT_2
+#define CPU_INTERRUPT_NMI       CPU_INTERRUPT_TGT_EXT_3
+#define CPU_INTERRUPT_MCE       CPU_INTERRUPT_TGT_EXT_4
+#define CPU_INTERRUPT_VIRQ      CPU_INTERRUPT_TGT_INT_0
+#define CPU_INTERRUPT_SIPI      CPU_INTERRUPT_TGT_INT_1
+#define CPU_INTERRUPT_TPR       CPU_INTERRUPT_TGT_INT_2
+
+/* Use a clearer name for this.  */
+#define CPU_INTERRUPT_INIT      CPU_INTERRUPT_RESET
+
+#define CC_OP_HAS_EFLAGS(op) ((op) >= CC_OP_EFLAGS && (op) <= CC_OP_ADCOX)
+
+/* Instead of computing the condition codes after each x86 instruction,
+ * QEMU just stores one operand (called CC_SRC), the result
+ * (called CC_DST) and the type of operation (called CC_OP). When the
+ * condition codes are needed, the condition codes can be calculated
+ * using this information. Condition codes are not generated if they
+ * are only needed for conditional branches.
+ */
+typedef enum {
+    CC_OP_EFLAGS = 0,  /* all cc are explicitly computed, CC_SRC = flags */
+    CC_OP_ADCX = 1,    /* CC_DST = C, CC_SRC = rest.  */
+    CC_OP_ADOX = 2,    /* CC_SRC2 = O, CC_SRC = rest.  */
+    CC_OP_ADCOX = 3,   /* CC_DST = C, CC_SRC2 = O, CC_SRC = rest.  */
+
+    /* Low 2 bits = MemOp constant for the size */
+#define CC_OP_FIRST_BWLQ CC_OP_MULB
+    CC_OP_MULB = 4, /* modify all flags, C, O = (CC_SRC != 0) */
+    CC_OP_MULW,
+    CC_OP_MULL,
+    CC_OP_MULQ,
+
+    CC_OP_ADDB, /* modify all flags, CC_DST = res, CC_SRC = src1 */
+    CC_OP_ADDW,
+    CC_OP_ADDL,
+    CC_OP_ADDQ,
+
+    CC_OP_ADCB, /* modify all flags, CC_DST = res, CC_SRC = src1 */
+    CC_OP_ADCW,
+    CC_OP_ADCL,
+    CC_OP_ADCQ,
+
+    CC_OP_SUBB, /* modify all flags, CC_DST = res, CC_SRC = src1 */
+    CC_OP_SUBW,
+    CC_OP_SUBL,
+    CC_OP_SUBQ,
+
+    CC_OP_SBBB, /* modify all flags, CC_DST = res, CC_SRC = src1 */
+    CC_OP_SBBW,
+    CC_OP_SBBL,
+    CC_OP_SBBQ,
+
+    CC_OP_LOGICB, /* modify all flags, CC_DST = res */
+    CC_OP_LOGICW,
+    CC_OP_LOGICL,
+    CC_OP_LOGICQ,
+
+    CC_OP_INCB, /* modify all flags except, CC_DST = res, CC_SRC = C */
+    CC_OP_INCW,
+    CC_OP_INCL,
+    CC_OP_INCQ,
+
+    CC_OP_DECB, /* modify all flags except, CC_DST = res, CC_SRC = C  */
+    CC_OP_DECW,
+    CC_OP_DECL,
+    CC_OP_DECQ,
+
+    CC_OP_SHLB, /* modify all flags, CC_DST = res, CC_SRC.msb = C */
+    CC_OP_SHLW,
+    CC_OP_SHLL,
+    CC_OP_SHLQ,
+
+    CC_OP_SARB, /* modify all flags, CC_DST = res, CC_SRC.lsb = C */
+    CC_OP_SARW,
+    CC_OP_SARL,
+    CC_OP_SARQ,
+
+    CC_OP_BMILGB, /* Z,S via CC_DST, C = SRC==0; O=0; P,A undefined */
+    CC_OP_BMILGW,
+    CC_OP_BMILGL,
+    CC_OP_BMILGQ,
+
+    CC_OP_BLSIB, /* Z,S via CC_DST, C = SRC!=0; O=0; P,A undefined */
+    CC_OP_BLSIW,
+    CC_OP_BLSIL,
+    CC_OP_BLSIQ,
+
+    /*
+     * Note that only CC_OP_POPCNT (i.e. the one with MO_TL size)
+     * is used or implemented, because the translation needs
+     * to zero-extend CC_DST anyway.
+     */
+    CC_OP_POPCNTB__, /* Z via CC_DST, all other flags clear.  */
+    CC_OP_POPCNTW__,
+    CC_OP_POPCNTL__,
+    CC_OP_POPCNTQ__,
+    CC_OP_POPCNT = sizeof(target_ulong) == 8 ? CC_OP_POPCNTQ__ : CC_OP_POPCNTL__,
+#define CC_OP_LAST_BWLQ CC_OP_POPCNTQ__
+
+    CC_OP_DYNAMIC, /* must use dynamic code to get cc_op */
+} CCOp;
+
+/* See X86DecodedInsn.cc_op, using int8_t. */
+QEMU_BUILD_BUG_ON(CC_OP_DYNAMIC > INT8_MAX);
+
+static inline MemOp cc_op_size(CCOp op)
+{
+    MemOp size = op & 3;
+
+    QEMU_BUILD_BUG_ON(CC_OP_FIRST_BWLQ & 3);
+    assert(op >= CC_OP_FIRST_BWLQ && op <= CC_OP_LAST_BWLQ);
+    assert(size <= MO_TL);
+
+    return size;
+}
+
+typedef struct SegmentCache {
+    uint32_t selector;
+    target_ulong base;
+    uint32_t limit;
+    uint32_t flags;
+} SegmentCache;
+
+typedef union MMXReg {
+    uint8_t  _b_MMXReg[64 / 8];
+    uint16_t _w_MMXReg[64 / 16];
+    uint32_t _l_MMXReg[64 / 32];
+    uint64_t _q_MMXReg[64 / 64];
+    float32  _s_MMXReg[64 / 32];
+    float64  _d_MMXReg[64 / 64];
+} MMXReg;
+
+typedef union XMMReg {
+    uint64_t _q_XMMReg[128 / 64];
+} XMMReg;
+
+typedef union YMMReg {
+    uint64_t _q_YMMReg[256 / 64];
+    XMMReg   _x_YMMReg[256 / 128];
+} YMMReg;
+
+typedef union ZMMReg {
+    uint8_t  _b_ZMMReg[512 / 8];
+    uint16_t _w_ZMMReg[512 / 16];
+    uint32_t _l_ZMMReg[512 / 32];
+    uint64_t _q_ZMMReg[512 / 64];
+    float16  _h_ZMMReg[512 / 16];
+    float32  _s_ZMMReg[512 / 32];
+    float64  _d_ZMMReg[512 / 64];
+    XMMReg   _x_ZMMReg[512 / 128];
+    YMMReg   _y_ZMMReg[512 / 256];
+} ZMMReg;
+
+typedef struct BNDReg {
+    uint64_t lb;
+    uint64_t ub;
+} BNDReg;
+
+typedef struct BNDCSReg {
+    uint64_t cfgu;
+    uint64_t sts;
+} BNDCSReg;
+
+#define BNDCFG_ENABLE       1ULL
+#define BNDCFG_BNDPRESERVE  2ULL
+#define BNDCFG_BDIR_MASK    TARGET_PAGE_MASK
+
+#if HOST_BIG_ENDIAN
+#define ZMM_B(n) _b_ZMMReg[63 - (n)]
+#define ZMM_W(n) _w_ZMMReg[31 - (n)]
+#define ZMM_L(n) _l_ZMMReg[15 - (n)]
+#define ZMM_H(n) _h_ZMMReg[31 - (n)]
+#define ZMM_S(n) _s_ZMMReg[15 - (n)]
+#define ZMM_Q(n) _q_ZMMReg[7 - (n)]
+#define ZMM_D(n) _d_ZMMReg[7 - (n)]
+#define ZMM_X(n) _x_ZMMReg[3 - (n)]
+#define ZMM_Y(n) _y_ZMMReg[1 - (n)]
+
+#define XMM_Q(n) _q_XMMReg[1 - (n)]
+
+#define YMM_Q(n) _q_YMMReg[3 - (n)]
+#define YMM_X(n) _x_YMMReg[1 - (n)]
+
+#define MMX_B(n) _b_MMXReg[7 - (n)]
+#define MMX_W(n) _w_MMXReg[3 - (n)]
+#define MMX_L(n) _l_MMXReg[1 - (n)]
+#define MMX_S(n) _s_MMXReg[1 - (n)]
+#else
+#define ZMM_B(n) _b_ZMMReg[n]
+#define ZMM_W(n) _w_ZMMReg[n]
+#define ZMM_L(n) _l_ZMMReg[n]
+#define ZMM_H(n) _h_ZMMReg[n]
+#define ZMM_S(n) _s_ZMMReg[n]
+#define ZMM_Q(n) _q_ZMMReg[n]
+#define ZMM_D(n) _d_ZMMReg[n]
+#define ZMM_X(n) _x_ZMMReg[n]
+#define ZMM_Y(n) _y_ZMMReg[n]
+
+#define XMM_Q(n) _q_XMMReg[n]
+
+#define YMM_Q(n) _q_YMMReg[n]
+#define YMM_X(n) _x_YMMReg[n]
+
+#define MMX_B(n) _b_MMXReg[n]
+#define MMX_W(n) _w_MMXReg[n]
+#define MMX_L(n) _l_MMXReg[n]
+#define MMX_S(n) _s_MMXReg[n]
+#endif
+#define MMX_Q(n) _q_MMXReg[n]
+
+typedef union {
+    floatx80 d __attribute__((aligned(16)));
+    MMXReg mmx;
+} FPReg;
+
+typedef struct {
+    uint64_t base;
+    uint64_t mask;
+} MTRRVar;
+
+#define CPU_NB_REGS64 16
+#define CPU_NB_REGS32 8
+
+#ifdef TARGET_X86_64
+#define CPU_NB_REGS CPU_NB_REGS64
+#else
+#define CPU_NB_REGS CPU_NB_REGS32
+#endif
+
+#define MAX_FIXED_COUNTERS 3
+#define MAX_GP_COUNTERS    (MSR_IA32_PERF_STATUS - MSR_P6_EVNTSEL0)
+
+#define TARGET_INSN_START_EXTRA_WORDS 1
+
+#define NB_OPMASK_REGS 8
+
+/* CPU can't have 0xFFFFFFFF APIC ID, use that value to distinguish
+ * that APIC ID hasn't been set yet
+ */
+#define UNASSIGNED_APIC_ID 0xFFFFFFFF
+
+typedef struct X86LegacyXSaveArea {
+    uint16_t fcw;
+    uint16_t fsw;
+    uint8_t ftw;
+    uint8_t reserved;
+    uint16_t fpop;
+    union {
+        struct {
+            uint64_t fpip;
+            uint64_t fpdp;
+        };
+        struct {
+            uint32_t fip;
+            uint32_t fcs;
+            uint32_t foo;
+            uint32_t fos;
+        };
+    };
+    uint32_t mxcsr;
+    uint32_t mxcsr_mask;
+    FPReg fpregs[8];
+    uint8_t xmm_regs[16][16];
+    uint32_t hw_reserved[12];
+    uint32_t sw_reserved[12];
+} X86LegacyXSaveArea;
+
+QEMU_BUILD_BUG_ON(sizeof(X86LegacyXSaveArea) != 512);
+
+typedef struct X86XSaveHeader {
+    uint64_t xstate_bv;
+    uint64_t xcomp_bv;
+    uint64_t reserve0;
+    uint8_t reserved[40];
+} X86XSaveHeader;
+
+/* Ext. save area 2: AVX State */
+typedef struct XSaveAVX {
+    uint8_t ymmh[16][16];
+} XSaveAVX;
+
+/* Ext. save area 3: BNDREG */
+typedef struct XSaveBNDREG {
+    BNDReg bnd_regs[4];
+} XSaveBNDREG;
+
+/* Ext. save area 4: BNDCSR */
+typedef union XSaveBNDCSR {
+    BNDCSReg bndcsr;
+    uint8_t data[64];
+} XSaveBNDCSR;
+
+/* Ext. save area 5: Opmask */
+typedef struct XSaveOpmask {
+    uint64_t opmask_regs[NB_OPMASK_REGS];
+} XSaveOpmask;
+
+/* Ext. save area 6: ZMM_Hi256 */
+typedef struct XSaveZMM_Hi256 {
+    uint8_t zmm_hi256[16][32];
+} XSaveZMM_Hi256;
+
+/* Ext. save area 7: Hi16_ZMM */
+typedef struct XSaveHi16_ZMM {
+    uint8_t hi16_zmm[16][64];
+} XSaveHi16_ZMM;
+
+/* Ext. save area 9: PKRU state */
+typedef struct XSavePKRU {
+    uint32_t pkru;
+    uint32_t padding;
+} XSavePKRU;
+
+/* Ext. save area 17: AMX XTILECFG state */
+typedef struct XSaveXTILECFG {
+    uint8_t xtilecfg[64];
+} XSaveXTILECFG;
+
+/* Ext. save area 18: AMX XTILEDATA state */
+typedef struct XSaveXTILEDATA {
+    uint8_t xtiledata[8][1024];
+} XSaveXTILEDATA;
+
+typedef struct {
+       uint64_t from;
+       uint64_t to;
+       uint64_t info;
+} LBREntry;
+
+#define ARCH_LBR_NR_ENTRIES            32
+
+/* Ext. save area 19: Supervisor mode Arch LBR state */
+typedef struct XSavesArchLBR {
+    uint64_t lbr_ctl;
+    uint64_t lbr_depth;
+    uint64_t ler_from;
+    uint64_t ler_to;
+    uint64_t ler_info;
+    LBREntry lbr_records[ARCH_LBR_NR_ENTRIES];
+} XSavesArchLBR;
+
+QEMU_BUILD_BUG_ON(sizeof(XSaveAVX) != 0x100);
+QEMU_BUILD_BUG_ON(sizeof(XSaveBNDREG) != 0x40);
+QEMU_BUILD_BUG_ON(sizeof(XSaveBNDCSR) != 0x40);
+QEMU_BUILD_BUG_ON(sizeof(XSaveOpmask) != 0x40);
+QEMU_BUILD_BUG_ON(sizeof(XSaveZMM_Hi256) != 0x200);
+QEMU_BUILD_BUG_ON(sizeof(XSaveHi16_ZMM) != 0x400);
+QEMU_BUILD_BUG_ON(sizeof(XSavePKRU) != 0x8);
+QEMU_BUILD_BUG_ON(sizeof(XSaveXTILECFG) != 0x40);
+QEMU_BUILD_BUG_ON(sizeof(XSaveXTILEDATA) != 0x2000);
+QEMU_BUILD_BUG_ON(sizeof(XSavesArchLBR) != 0x328);
+
+typedef struct ExtSaveArea {
+    uint32_t feature, bits;
+    uint32_t offset, size;
+    uint32_t ecx;
+} ExtSaveArea;
+
+#define XSAVE_STATE_AREA_COUNT (XSTATE_XTILE_DATA_BIT + 1)
+
+extern ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT];
+
+typedef enum TPRAccess {
+    TPR_ACCESS_READ,
+    TPR_ACCESS_WRITE,
+} TPRAccess;
+
+/* Cache information data structures: */
+
+enum CacheType {
+    DATA_CACHE,
+    INSTRUCTION_CACHE,
+    UNIFIED_CACHE
+};
+
+typedef struct CPUCacheInfo {
+    enum CacheType type;
+    uint8_t level;
+    /* Size in bytes */
+    uint32_t size;
+    /* Line size, in bytes */
+    uint16_t line_size;
+    /*
+     * Associativity.
+     * Note: representation of fully-associative caches is not implemented
+     */
+    uint8_t associativity;
+    /* Physical line partitions. CPUID[0x8000001D].EBX, CPUID[4].EBX */
+    uint8_t partitions;
+    /* Number of sets. CPUID[0x8000001D].ECX, CPUID[4].ECX */
+    uint32_t sets;
+    /*
+     * Lines per tag.
+     * AMD-specific: CPUID[0x80000005], CPUID[0x80000006].
+     * (Is this synonym to @partitions?)
+     */
+    uint8_t lines_per_tag;
+
+    /* Self-initializing cache */
+    bool self_init;
+    /*
+     * WBINVD/INVD is not guaranteed to act upon lower level caches of
+     * non-originating threads sharing this cache.
+     * CPUID[4].EDX[bit 0], CPUID[0x8000001D].EDX[bit 0]
+     */
+    bool no_invd_sharing;
+    /*
+     * Cache is inclusive of lower cache levels.
+     * CPUID[4].EDX[bit 1], CPUID[0x8000001D].EDX[bit 1].
+     */
+    bool inclusive;
+    /*
+     * A complex function is used to index the cache, potentially using all
+     * address bits.  CPUID[4].EDX[bit 2].
+     */
+    bool complex_indexing;
+
+    /*
+     * Cache Topology. The level that cache is shared in.
+     * Used to encode CPUID[4].EAX[bits 25:14] or
+     * CPUID[0x8000001D].EAX[bits 25:14].
+     */
+    CpuTopologyLevel share_level;
+} CPUCacheInfo;
+
+
+typedef struct CPUCaches {
+        CPUCacheInfo *l1d_cache;
+        CPUCacheInfo *l1i_cache;
+        CPUCacheInfo *l2_cache;
+        CPUCacheInfo *l3_cache;
+} CPUCaches;
+
+typedef struct HVFX86LazyFlags {
+    target_ulong result;
+    target_ulong auxbits;
+} HVFX86LazyFlags;
+
+typedef struct CPUArchState {
+    /* standard registers */
+    target_ulong regs[CPU_NB_REGS];
+    target_ulong eip;
+    target_ulong eflags; /* eflags register. During CPU emulation, CC
+                        flags and DF are set to zero because they are
+                        stored elsewhere */
+
+    /* emulator internal eflags handling */
+    target_ulong cc_dst;
+    target_ulong cc_src;
+    target_ulong cc_src2;
+    uint32_t cc_op;
+    int32_t df; /* D flag : 1 if D = 0, -1 if D = 1 */
+    uint32_t hflags; /* TB flags, see HF_xxx constants. These flags
+                        are known at translation time. */
+    uint32_t hflags2; /* various other flags, see HF2_xxx constants. */
+
+    /* segments */
+    SegmentCache segs[6]; /* selector values */
+    SegmentCache ldt;
+    SegmentCache tr;
+    SegmentCache gdt; /* only base and limit are used */
+    SegmentCache idt; /* only base and limit are used */
+
+    target_ulong cr[5]; /* NOTE: cr1 is unused */
+
+    bool pdptrs_valid;
+    uint64_t pdptrs[4];
+    int32_t a20_mask;
+
+    BNDReg bnd_regs[4];
+    BNDCSReg bndcs_regs;
+    uint64_t msr_bndcfgs;
+    uint64_t efer;
+
+    /* Beginning of state preserved by INIT (dummy marker).  */
+    struct {} start_init_save;
+
+    /* FPU state */
+    unsigned int fpstt; /* top of stack index */
+    uint16_t fpus;
+    uint16_t fpuc;
+    uint8_t fptags[8];   /* 0 = valid, 1 = empty */
+    FPReg fpregs[8];
+    /* KVM-only so far */
+    uint16_t fpop;
+    uint16_t fpcs;
+    uint16_t fpds;
+    uint64_t fpip;
+    uint64_t fpdp;
+
+    /* emulator internal variables */
+    float_status fp_status;
+    floatx80 ft0;
+
+    float_status mmx_status; /* for 3DNow! float ops */
+    float_status sse_status;
+    uint32_t mxcsr;
+    ZMMReg xmm_regs[CPU_NB_REGS == 8 ? 8 : 32] QEMU_ALIGNED(16);
+    ZMMReg xmm_t0 QEMU_ALIGNED(16);
+    MMXReg mmx_t0;
+
+    uint64_t opmask_regs[NB_OPMASK_REGS];
+#ifdef TARGET_X86_64
+    uint8_t xtilecfg[64];
+    uint8_t xtiledata[8192];
+#endif
+
+    /* sysenter registers */
+    uint32_t sysenter_cs;
+    target_ulong sysenter_esp;
+    target_ulong sysenter_eip;
+    uint64_t star;
+
+    uint64_t vm_hsave;
+
+#ifdef TARGET_X86_64
+    target_ulong lstar;
+    target_ulong cstar;
+    target_ulong fmask;
+    target_ulong kernelgsbase;
+
+    /* FRED MSRs */
+    uint64_t fred_rsp0;
+    uint64_t fred_rsp1;
+    uint64_t fred_rsp2;
+    uint64_t fred_rsp3;
+    uint64_t fred_stklvls;
+    uint64_t fred_ssp1;
+    uint64_t fred_ssp2;
+    uint64_t fred_ssp3;
+    uint64_t fred_config;
+#endif
+
+    uint64_t tsc_adjust;
+    uint64_t tsc_deadline;
+    uint64_t tsc_aux;
+
+    uint64_t xcr0;
+
+    uint64_t mcg_status;
+    uint64_t msr_ia32_misc_enable;
+    uint64_t msr_ia32_feature_control;
+    uint64_t msr_ia32_sgxlepubkeyhash[4];
+
+    uint64_t msr_fixed_ctr_ctrl;
+    uint64_t msr_global_ctrl;
+    uint64_t msr_global_status;
+    uint64_t msr_global_ovf_ctrl;
+    uint64_t msr_fixed_counters[MAX_FIXED_COUNTERS];
+    uint64_t msr_gp_counters[MAX_GP_COUNTERS];
+    uint64_t msr_gp_evtsel[MAX_GP_COUNTERS];
+
+    uint64_t pat;
+    uint32_t smbase;
+    uint64_t msr_smi_count;
+
+    uint32_t pkru;
+    uint32_t pkrs;
+    uint32_t tsx_ctrl;
+
+    uint64_t spec_ctrl;
+    uint64_t amd_tsc_scale_msr;
+    uint64_t virt_ssbd;
+
+    /* End of state preserved by INIT (dummy marker).  */
+    struct {} end_init_save;
+
+    uint64_t system_time_msr;
+    uint64_t wall_clock_msr;
+    uint64_t steal_time_msr;
+    uint64_t async_pf_en_msr;
+    uint64_t async_pf_int_msr;
+    uint64_t pv_eoi_en_msr;
+    uint64_t poll_control_msr;
+
+    /* Partition-wide HV MSRs, will be updated only on the first vcpu */
+    uint64_t msr_hv_hypercall;
+    uint64_t msr_hv_guest_os_id;
+    uint64_t msr_hv_tsc;
+    uint64_t msr_hv_syndbg_control;
+    uint64_t msr_hv_syndbg_status;
+    uint64_t msr_hv_syndbg_send_page;
+    uint64_t msr_hv_syndbg_recv_page;
+    uint64_t msr_hv_syndbg_pending_page;
+    uint64_t msr_hv_syndbg_options;
+
+    /* Per-VCPU HV MSRs */
+    uint64_t msr_hv_vapic;
+    uint64_t msr_hv_crash_params[HV_CRASH_PARAMS];
+    uint64_t msr_hv_runtime;
+    uint64_t msr_hv_synic_control;
+    uint64_t msr_hv_synic_evt_page;
+    uint64_t msr_hv_synic_msg_page;
+    uint64_t msr_hv_synic_sint[HV_SINT_COUNT];
+    uint64_t msr_hv_stimer_config[HV_STIMER_COUNT];
+    uint64_t msr_hv_stimer_count[HV_STIMER_COUNT];
+    uint64_t msr_hv_reenlightenment_control;
+    uint64_t msr_hv_tsc_emulation_control;
+    uint64_t msr_hv_tsc_emulation_status;
+
+    uint64_t msr_rtit_ctrl;
+    uint64_t msr_rtit_status;
+    uint64_t msr_rtit_output_base;
+    uint64_t msr_rtit_output_mask;
+    uint64_t msr_rtit_cr3_match;
+    uint64_t msr_rtit_addrs[MAX_RTIT_ADDRS];
+
+    /* Per-VCPU XFD MSRs */
+    uint64_t msr_xfd;
+    uint64_t msr_xfd_err;
+
+    /* Per-VCPU Arch LBR MSRs */
+    uint64_t msr_lbr_ctl;
+    uint64_t msr_lbr_depth;
+    LBREntry lbr_records[ARCH_LBR_NR_ENTRIES];
+
+    /* AMD MSRC001_0015 Hardware Configuration */
+    uint64_t msr_hwcr;
+
+    /* exception/interrupt handling */
+    int error_code;
+    int exception_is_int;
+    target_ulong exception_next_eip;
+    target_ulong dr[8]; /* debug registers; note dr4 and dr5 are unused */
+    union {
+        struct CPUBreakpoint *cpu_breakpoint[4];
+        struct CPUWatchpoint *cpu_watchpoint[4];
+    }; /* break/watchpoints for dr[0..3] */
+    int old_exception;  /* exception in flight */
+
+    uint64_t vm_vmcb;
+    uint64_t tsc_offset;
+    uint64_t intercept;
+    uint16_t intercept_cr_read;
+    uint16_t intercept_cr_write;
+    uint16_t intercept_dr_read;
+    uint16_t intercept_dr_write;
+    uint32_t intercept_exceptions;
+    uint64_t nested_cr3;
+    uint32_t nested_pg_mode;
+    uint8_t v_tpr;
+    uint32_t int_ctl;
+
+    /* KVM states, automatically cleared on reset */
+    uint8_t nmi_injected;
+    uint8_t nmi_pending;
+
+    uintptr_t retaddr;
+
+    /* RAPL MSR */
+    uint64_t msr_rapl_power_unit;
+    uint64_t msr_pkg_energy_status;
+
+    /* Fields up to this point are cleared by a CPU reset */
+    struct {} end_reset_fields;
+
+    /* Fields after this point are preserved across CPU reset. */
+
+    /* processor features (e.g. for CPUID insn) */
+    /* Minimum cpuid leaf 7 value */
+    uint32_t cpuid_level_func7;
+    /* Actual cpuid leaf 7 value */
+    uint32_t cpuid_min_level_func7;
+    /* Minimum level/xlevel/xlevel2, based on CPU model + features */
+    uint32_t cpuid_min_level, cpuid_min_xlevel, cpuid_min_xlevel2;
+    /* Maximum level/xlevel/xlevel2 value for auto-assignment: */
+    uint32_t cpuid_max_level, cpuid_max_xlevel, cpuid_max_xlevel2;
+    /* Actual level/xlevel/xlevel2 value: */
+    uint32_t cpuid_level, cpuid_xlevel, cpuid_xlevel2;
+    uint32_t cpuid_vendor1;
+    uint32_t cpuid_vendor2;
+    uint32_t cpuid_vendor3;
+    uint32_t cpuid_version;
+    FeatureWordArray features;
+    /* AVX10 version */
+    uint8_t avx10_version;
+    /* Features that were explicitly enabled/disabled */
+    FeatureWordArray user_features;
+    uint32_t cpuid_model[12];
+    /* Cache information for CPUID.  When legacy-cache=on, the cache data
+     * on each CPUID leaf will be different, because we keep compatibility
+     * with old QEMU versions.
+     */
+    CPUCaches cache_info_cpuid2, cache_info_cpuid4, cache_info_amd;
+
+    /* MTRRs */
+    uint64_t mtrr_fixed[11];
+    uint64_t mtrr_deftype;
+    MTRRVar mtrr_var[MSR_MTRRcap_VCNT];
+
+    /* For KVM */
+    uint32_t mp_state;
+    int32_t exception_nr;
+    int32_t interrupt_injected;
+    uint8_t soft_interrupt;
+    uint8_t exception_pending;
+    uint8_t exception_injected;
+    uint8_t has_error_code;
+    uint8_t exception_has_payload;
+    uint64_t exception_payload;
+    uint8_t triple_fault_pending;
+    uint32_t ins_len;
+    uint32_t sipi_vector;
+    bool tsc_valid;
+    int64_t tsc_khz;
+    int64_t user_tsc_khz; /* for sanity check only */
+    uint64_t apic_bus_freq;
+    uint64_t tsc;
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
+    void *xsave_buf;
+    uint32_t xsave_buf_len;
+#endif
+#if defined(CONFIG_KVM)
+    struct kvm_nested_state *nested_state;
+    MemoryRegion *xen_vcpu_info_mr;
+    void *xen_vcpu_info_hva;
+    uint64_t xen_vcpu_info_gpa;
+    uint64_t xen_vcpu_info_default_gpa;
+    uint64_t xen_vcpu_time_info_gpa;
+    uint64_t xen_vcpu_runstate_gpa;
+    uint8_t xen_vcpu_callback_vector;
+    bool xen_callback_asserted;
+    uint16_t xen_virq[XEN_NR_VIRQS];
+    uint64_t xen_singleshot_timer_ns;
+    QEMUTimer *xen_singleshot_timer;
+    uint64_t xen_periodic_timer_period;
+    QEMUTimer *xen_periodic_timer;
+    QemuMutex xen_timers_lock;
+#endif
+#if defined(CONFIG_HVF)
+    HVFX86LazyFlags hvf_lflags;
+    void *hvf_mmio_buf;
+#endif
+
+    uint64_t mcg_cap;
+    uint64_t mcg_ctl;
+    uint64_t mcg_ext_ctl;
+    uint64_t mce_banks[MCE_BANKS_DEF*4];
+    uint64_t xstate_bv;
+
+    /* vmstate */
+    uint16_t fpus_vmstate;
+    uint16_t fptag_vmstate;
+    uint16_t fpregs_format_vmstate;
+
+    uint64_t xss;
+    uint32_t umwait;
+
+    TPRAccess tpr_access_type;
+
+    /* Number of dies within this CPU package. */
+    unsigned nr_dies;
+
+    /* Number of modules within one die. */
+    unsigned nr_modules;
+
+    /* Bitmap of available CPU topology levels for this CPU. */
+    DECLARE_BITMAP(avail_cpu_topo, CPU_TOPOLOGY_LEVEL__MAX);
+} CPUX86State;
+
+struct kvm_msrs;
+
+/**
+ * X86CPU:
+ * @env: #CPUX86State
+ * @migratable: If set, only migratable flags will be accepted when "enforce"
+ * mode is used, and only migratable flags will be included in the "host"
+ * CPU model.
+ *
+ * An x86 CPU.
+ */
+struct ArchCPU {
+    CPUState parent_obj;
+
+    CPUX86State env;
+    VMChangeStateEntry *vmsentry;
+
+    uint64_t ucode_rev;
+
+    uint32_t hyperv_spinlock_attempts;
+    char *hyperv_vendor;
+    bool hyperv_synic_kvm_only;
+    uint64_t hyperv_features;
+    bool hyperv_passthrough;
+    OnOffAuto hyperv_no_nonarch_cs;
+    uint32_t hyperv_vendor_id[3];
+    uint32_t hyperv_interface_id[4];
+    uint32_t hyperv_limits[3];
+    bool hyperv_enforce_cpuid;
+    uint32_t hyperv_ver_id_build;
+    uint16_t hyperv_ver_id_major;
+    uint16_t hyperv_ver_id_minor;
+    uint32_t hyperv_ver_id_sp;
+    uint8_t hyperv_ver_id_sb;
+    uint32_t hyperv_ver_id_sn;
+
+    bool check_cpuid;
+    bool enforce_cpuid;
+    /*
+     * Force features to be enabled even if the host doesn't support them.
+     * This is dangerous and should be done only for testing CPUID
+     * compatibility.
+     */
+    bool force_features;
+    bool expose_kvm;
+    bool expose_tcg;
+    bool migratable;
+    bool migrate_smi_count;
+    bool max_features; /* Enable all supported features automatically */
+    uint32_t apic_id;
+
+    /* Enables publishing of TSC increment and Local APIC bus frequencies to
+     * the guest OS in CPUID page 0x40000010, the same way that VMWare does. */
+    bool vmware_cpuid_freq;
+
+    /* if true the CPUID code directly forward host cache leaves to the guest */
+    bool cache_info_passthrough;
+
+    /* if true the CPUID code directly forwards
+     * host monitor/mwait leaves to the guest */
+    struct {
+        uint32_t eax;
+        uint32_t ebx;
+        uint32_t ecx;
+        uint32_t edx;
+    } mwait;
+
+    /* Features that were filtered out because of missing host capabilities */
+    FeatureWordArray filtered_features;
+
+    /* Enable PMU CPUID bits. This can't be enabled by default yet because
+     * it doesn't have ABI stability guarantees, as it passes all PMU CPUID
+     * bits returned by GET_SUPPORTED_CPUID (that depend on host CPU and kernel
+     * capabilities) directly to the guest.
+     */
+    bool enable_pmu;
+
+    /*
+     * Enable LBR_FMT bits of IA32_PERF_CAPABILITIES MSR.
+     * This can't be initialized with a default because it doesn't have
+     * stable ABI support yet. It is only allowed to pass all LBR_FMT bits
+     * returned by kvm_arch_get_supported_msr_feature()(which depends on both
+     * host CPU and kernel capabilities) to the guest.
+     */
+    uint64_t lbr_fmt;
+
+    /* LMCE support can be enabled/disabled via cpu option 'lmce=on/off'. It is
+     * disabled by default to avoid breaking migration between QEMU with
+     * different LMCE configurations.
+     */
+    bool enable_lmce;
+
+    /* Compatibility bits for old machine types.
+     * If true present virtual l3 cache for VM, the vcpus in the same virtual
+     * socket share an virtual l3 cache.
+     */
+    bool enable_l3_cache;
+
+    /* Compatibility bits for old machine types.
+     * If true present L1 cache as per-thread, not per-core.
+     */
+    bool l1_cache_per_core;
+
+    /* Compatibility bits for old machine types.
+     * If true present the old cache topology information
+     */
+    bool legacy_cache;
+
+    /* Compatibility bits for old machine types.
+     * If true decode the CPUID Function 0x8000001E_ECX to support multiple
+     * nodes per processor
+     */
+    bool legacy_multi_node;
+
+    /* Compatibility bits for old machine types: */
+    bool enable_cpuid_0xb;
+
+    /* Enable auto level-increase for all CPUID leaves */
+    bool full_cpuid_auto_level;
+
+    /* Only advertise CPUID leaves defined by the vendor */
+    bool vendor_cpuid_only;
+
+    /* Only advertise TOPOEXT features that AMD defines */
+    bool amd_topoext_features_only;
+
+    /* Enable auto level-increase for Intel Processor Trace leave */
+    bool intel_pt_auto_level;
+
+    /* if true fill the top bits of the MTRR_PHYSMASKn variable range */
+    bool fill_mtrr_mask;
+
+    /* if true override the phys_bits value with a value read from the host */
+    bool host_phys_bits;
+
+    /* if set, limit maximum value for phys_bits when host_phys_bits is true */
+    uint8_t host_phys_bits_limit;
+
+    /* Forcefully disable KVM PV features not exposed in guest CPUIDs */
+    bool kvm_pv_enforce_cpuid;
+
+    /* Number of physical address bits supported */
+    uint32_t phys_bits;
+
+    /*
+     * Number of guest physical address bits available. Usually this is
+     * identical to host physical address bits. With NPT or EPT 4-level
+     * paging, guest physical address space might be restricted to 48 bits
+     * even if the host cpu supports more physical address bits.
+     */
+    uint32_t guest_phys_bits;
+
+    /* in order to simplify APIC support, we leave this pointer to the
+       user */
+    struct DeviceState *apic_state;
+    struct MemoryRegion *cpu_as_root, *cpu_as_mem, *smram;
+    Notifier machine_done;
+
+    struct kvm_msrs *kvm_msr_buf;
+
+    int32_t node_id; /* NUMA node this CPU belongs to */
+    int32_t socket_id;
+    int32_t die_id;
+    int32_t module_id;
+    int32_t core_id;
+    int32_t thread_id;
+
+    int32_t hv_max_vps;
+
+    bool xen_vapic;
+};
+
+typedef struct X86CPUModel X86CPUModel;
+
+/**
+ * X86CPUClass:
+ * @cpu_def: CPU model definition
+ * @host_cpuid_required: Whether CPU model requires cpuid from host.
+ * @ordering: Ordering on the "-cpu help" CPU model list.
+ * @migration_safe: See CpuDefinitionInfo::migration_safe
+ * @static_model: See CpuDefinitionInfo::static
+ * @parent_realize: The parent class' realize handler.
+ * @parent_phases: The parent class' reset phase handlers.
+ *
+ * An x86 CPU model or family.
+ */
+struct X86CPUClass {
+    CPUClass parent_class;
+
+    /*
+     * CPU definition, automatically loaded by instance_init if not NULL.
+     * Should be eventually replaced by subclass-specific property defaults.
+     */
+    X86CPUModel *model;
+
+    bool host_cpuid_required;
+    int ordering;
+    bool migration_safe;
+    bool static_model;
+
+    /*
+     * Optional description of CPU model.
+     * If unavailable, cpu_def->model_id is used.
+     */
+    const char *model_description;
+
+    DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
+    ResettablePhases parent_phases;
+};
+
+#ifndef CONFIG_USER_ONLY
+extern const VMStateDescription vmstate_x86_cpu;
+#endif
+
+int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request);
+
+int x86_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
+                             int cpuid, DumpState *s);
+int x86_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cpu,
+                             int cpuid, DumpState *s);
+int x86_cpu_write_elf64_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
+                                 DumpState *s);
+int x86_cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
+                                 DumpState *s);
+
+bool x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
+                                Error **errp);
+
+void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
+
+int x86_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+void x86_cpu_gdb_init(CPUState *cs);
+
+void x86_cpu_list(void);
+int cpu_x86_support_mca_broadcast(CPUX86State *env);
+
+#ifndef CONFIG_USER_ONLY
+hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
+                                         MemTxAttrs *attrs);
+int cpu_get_pic_interrupt(CPUX86State *s);
+
+/* MS-DOS compatibility mode FPU exception support */
+void x86_register_ferr_irq(qemu_irq irq);
+void fpu_check_raise_ferr_irq(CPUX86State *s);
+void cpu_set_ignne(void);
+void cpu_clear_ignne(void);
+#endif
+
+/* mpx_helper.c */
+void cpu_sync_bndcs_hflags(CPUX86State *env);
+
+/* this function must always be used to load data in the segment
+   cache: it synchronizes the hflags with the segment cache values */
+static inline void cpu_x86_load_seg_cache(CPUX86State *env,
+                                          X86Seg seg_reg, unsigned int selector,
+                                          target_ulong base,
+                                          unsigned int limit,
+                                          unsigned int flags)
+{
+    SegmentCache *sc;
+    unsigned int new_hflags;
+
+    sc = &env->segs[seg_reg];
+    sc->selector = selector;
+    sc->base = base;
+    sc->limit = limit;
+    sc->flags = flags;
+
+    /* update the hidden flags */
+    {
+        if (seg_reg == R_CS) {
+#ifdef TARGET_X86_64
+            if ((env->hflags & HF_LMA_MASK) && (flags & DESC_L_MASK)) {
+                /* long mode */
+                env->hflags |= HF_CS32_MASK | HF_SS32_MASK | HF_CS64_MASK;
+                env->hflags &= ~(HF_ADDSEG_MASK);
+            } else
+#endif
+            {
+                /* legacy / compatibility case */
+                new_hflags = (env->segs[R_CS].flags & DESC_B_MASK)
+                    >> (DESC_B_SHIFT - HF_CS32_SHIFT);
+                env->hflags = (env->hflags & ~(HF_CS32_MASK | HF_CS64_MASK)) |
+                    new_hflags;
+            }
+        }
+        if (seg_reg == R_SS) {
+            int cpl = (flags >> DESC_DPL_SHIFT) & 3;
+#if HF_CPL_MASK != 3
+#error HF_CPL_MASK is hardcoded
+#endif
+            env->hflags = (env->hflags & ~HF_CPL_MASK) | cpl;
+            /* Possibly switch between BNDCFGS and BNDCFGU */
+            cpu_sync_bndcs_hflags(env);
+        }
+        new_hflags = (env->segs[R_SS].flags & DESC_B_MASK)
+            >> (DESC_B_SHIFT - HF_SS32_SHIFT);
+        if (env->hflags & HF_CS64_MASK) {
+            /* zero base assumed for DS, ES and SS in long mode */
+        } else if (!(env->cr[0] & CR0_PE_MASK) ||
+                   (env->eflags & VM_MASK) ||
+                   !(env->hflags & HF_CS32_MASK)) {
+            /* XXX: try to avoid this test. The problem comes from the
+               fact that is real mode or vm86 mode we only modify the
+               'base' and 'selector' fields of the segment cache to go
+               faster. A solution may be to force addseg to one in
+               translate-i386.c. */
+            new_hflags |= HF_ADDSEG_MASK;
+        } else {
+            new_hflags |= ((env->segs[R_DS].base |
+                            env->segs[R_ES].base |
+                            env->segs[R_SS].base) != 0) <<
+                HF_ADDSEG_SHIFT;
+        }
+        env->hflags = (env->hflags &
+                       ~(HF_SS32_MASK | HF_ADDSEG_MASK)) | new_hflags;
+    }
+}
+
+static inline void cpu_x86_load_seg_cache_sipi(X86CPU *cpu,
+                                               uint8_t sipi_vector)
+{
+    CPUState *cs = CPU(cpu);
+    CPUX86State *env = &cpu->env;
+
+    env->eip = 0;
+    cpu_x86_load_seg_cache(env, R_CS, sipi_vector << 8,
+                           sipi_vector << 12,
+                           env->segs[R_CS].limit,
+                           env->segs[R_CS].flags);
+    cs->halted = 0;
+}
+
+int cpu_x86_get_descr_debug(CPUX86State *env, unsigned int selector,
+                            target_ulong *base, unsigned int *limit,
+                            unsigned int *flags);
+
+/* op_helper.c */
+/* used for debug or cpu save/restore */
+
+/* cpu-exec.c */
+/*
+ * The following helpers are only usable in user mode simulation.
+ * The host pointers should come from lock_user().
+ */
+void cpu_x86_load_seg(CPUX86State *s, X86Seg seg_reg, int selector);
+void cpu_x86_fsave(CPUX86State *s, void *host, size_t len);
+void cpu_x86_frstor(CPUX86State *s, void *host, size_t len);
+void cpu_x86_fxsave(CPUX86State *s, void *host, size_t len);
+void cpu_x86_fxrstor(CPUX86State *s, void *host, size_t len);
+void cpu_x86_xsave(CPUX86State *s, void *host, size_t len, uint64_t rbfm);
+bool cpu_x86_xrstor(CPUX86State *s, void *host, size_t len, uint64_t rbfm);
+
+/* cpu.c */
+void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
+                              uint32_t vendor2, uint32_t vendor3);
+typedef struct PropValue {
+    const char *prop, *value;
+} PropValue;
+void x86_cpu_apply_props(X86CPU *cpu, PropValue *props);
+
+void x86_cpu_after_reset(X86CPU *cpu);
+
+uint32_t cpu_x86_virtual_addr_width(CPUX86State *env);
+
+/* cpu.c other functions (cpuid) */
+void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
+                   uint32_t *eax, uint32_t *ebx,
+                   uint32_t *ecx, uint32_t *edx);
+void cpu_clear_apic_feature(CPUX86State *env);
+void cpu_set_apic_feature(CPUX86State *env);
+void host_cpuid(uint32_t function, uint32_t count,
+                uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
+bool cpu_has_x2apic_feature(CPUX86State *env);
+
+/* helper.c */
+void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
+void cpu_sync_avx_hflag(CPUX86State *env);
+
+#ifndef CONFIG_USER_ONLY
+static inline int x86_asidx_from_attrs(CPUState *cs, MemTxAttrs attrs)
+{
+    return !!attrs.secure;
+}
+
+static inline AddressSpace *cpu_addressspace(CPUState *cs, MemTxAttrs attrs)
+{
+    return cpu_get_address_space(cs, cpu_asidx_from_attrs(cs, attrs));
+}
+
+/*
+ * load efer and update the corresponding hflags. XXX: do consistency
+ * checks with cpuid bits?
+ */
+void cpu_load_efer(CPUX86State *env, uint64_t val);
+uint8_t x86_ldub_phys(CPUState *cs, hwaddr addr);
+uint32_t x86_lduw_phys(CPUState *cs, hwaddr addr);
+uint32_t x86_ldl_phys(CPUState *cs, hwaddr addr);
+uint64_t x86_ldq_phys(CPUState *cs, hwaddr addr);
+void x86_stb_phys(CPUState *cs, hwaddr addr, uint8_t val);
+void x86_stl_phys_notdirty(CPUState *cs, hwaddr addr, uint32_t val);
+void x86_stw_phys(CPUState *cs, hwaddr addr, uint32_t val);
+void x86_stl_phys(CPUState *cs, hwaddr addr, uint32_t val);
+void x86_stq_phys(CPUState *cs, hwaddr addr, uint64_t val);
+#endif
+
+/* will be suppressed */
+void cpu_x86_update_cr0(CPUX86State *env, uint32_t new_cr0);
+void cpu_x86_update_cr3(CPUX86State *env, target_ulong new_cr3);
+void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4);
+void cpu_x86_update_dr7(CPUX86State *env, uint32_t new_dr7);
+
+/* hw/pc.c */
+uint64_t cpu_get_tsc(CPUX86State *env);
+
+#define CPU_RESOLVING_TYPE TYPE_X86_CPU
+
+#ifdef TARGET_X86_64
+#define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu64")
+#else
+#define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu32")
+#endif
+
+#define cpu_list x86_cpu_list
+
+/* MMU modes definitions */
+#define MMU_KSMAP64_IDX    0
+#define MMU_KSMAP32_IDX    1
+#define MMU_USER64_IDX     2
+#define MMU_USER32_IDX     3
+#define MMU_KNOSMAP64_IDX  4
+#define MMU_KNOSMAP32_IDX  5
+#define MMU_PHYS_IDX       6
+#define MMU_NESTED_IDX     7
+
+#ifdef CONFIG_USER_ONLY
+#ifdef TARGET_X86_64
+#define MMU_USER_IDX MMU_USER64_IDX
+#else
+#define MMU_USER_IDX MMU_USER32_IDX
+#endif
+#endif
+
+static inline bool is_mmu_index_smap(int mmu_index)
+{
+    return (mmu_index & ~1) == MMU_KSMAP64_IDX;
+}
+
+static inline bool is_mmu_index_user(int mmu_index)
+{
+    return (mmu_index & ~1) == MMU_USER64_IDX;
+}
+
+static inline bool is_mmu_index_32(int mmu_index)
+{
+    assert(mmu_index < MMU_PHYS_IDX);
+    return mmu_index & 1;
+}
+
+int x86_mmu_index_pl(CPUX86State *env, unsigned pl);
+int cpu_mmu_index_kernel(CPUX86State *env);
+
+#define CC_DST  (env->cc_dst)
+#define CC_SRC  (env->cc_src)
+#define CC_SRC2 (env->cc_src2)
+#define CC_OP   (env->cc_op)
+
+#include "exec/cpu-all.h"
+#include "svm.h"
+
+#if !defined(CONFIG_USER_ONLY)
+#include "hw/i386/apic.h"
+#endif
+
+static inline void cpu_get_tb_cpu_state(CPUX86State *env, vaddr *pc,
+                                        uint64_t *cs_base, uint32_t *flags)
+{
+    *flags = env->hflags |
+        (env->eflags & (IOPL_MASK | TF_MASK | RF_MASK | VM_MASK | AC_MASK));
+    if (env->hflags & HF_CS64_MASK) {
+        *cs_base = 0;
+        *pc = env->eip;
+    } else {
+        *cs_base = env->segs[R_CS].base;
+        *pc = (uint32_t)(*cs_base + env->eip);
+    }
+}
+
+void do_cpu_init(X86CPU *cpu);
+
+#define MCE_INJECT_BROADCAST    1
+#define MCE_INJECT_UNCOND_AO    2
+
+void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
+                        uint64_t status, uint64_t mcg_status, uint64_t addr,
+                        uint64_t misc, int flags);
+
+uint32_t cpu_cc_compute_all(CPUX86State *env1);
+
+static inline uint32_t cpu_compute_eflags(CPUX86State *env)
+{
+    uint32_t eflags = env->eflags;
+    if (tcg_enabled()) {
+        eflags |= cpu_cc_compute_all(env) | (env->df & DF_MASK);
+    }
+    return eflags;
+}
+
+static inline MemTxAttrs cpu_get_mem_attrs(CPUX86State *env)
+{
+    return ((MemTxAttrs) { .secure = (env->hflags & HF_SMM_MASK) != 0 });
+}
+
+static inline int32_t x86_get_a20_mask(CPUX86State *env)
+{
+    if (env->hflags & HF_SMM_MASK) {
+        return -1;
+    } else {
+        return env->a20_mask;
+    }
+}
+
+static inline bool cpu_has_vmx(CPUX86State *env)
+{
+    return env->features[FEAT_1_ECX] & CPUID_EXT_VMX;
+}
+
+static inline bool cpu_has_svm(CPUX86State *env)
+{
+    return env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM;
+}
+
+/*
+ * In order for a vCPU to enter VMX operation it must have CR4.VMXE set.
+ * Since it was set, CR4.VMXE must remain set as long as vCPU is in
+ * VMX operation. This is because CR4.VMXE is one of the bits set
+ * in MSR_IA32_VMX_CR4_FIXED1.
+ *
+ * There is one exception to above statement when vCPU enters SMM mode.
+ * When a vCPU enters SMM mode, it temporarily exit VMX operation and
+ * may also reset CR4.VMXE during execution in SMM mode.
+ * When vCPU exits SMM mode, vCPU state is restored to be in VMX operation
+ * and CR4.VMXE is restored to it's original value of being set.
+ *
+ * Therefore, when vCPU is not in SMM mode, we can infer whether
+ * VMX is being used by examining CR4.VMXE. Otherwise, we cannot
+ * know for certain.
+ */
+static inline bool cpu_vmx_maybe_enabled(CPUX86State *env)
+{
+    return cpu_has_vmx(env) &&
+           ((env->cr[4] & CR4_VMXE_MASK) || (env->hflags & HF_SMM_MASK));
+}
+
+/* excp_helper.c */
+int get_pg_mode(CPUX86State *env);
+
+/* fpu_helper.c */
+
+/* Set all non-runtime-variable float_status fields to x86 handling */
+void cpu_init_fp_statuses(CPUX86State *env);
+void update_fp_status(CPUX86State *env);
+void update_mxcsr_status(CPUX86State *env);
+void update_mxcsr_from_sse_status(CPUX86State *env);
+
+static inline void cpu_set_mxcsr(CPUX86State *env, uint32_t mxcsr)
+{
+    env->mxcsr = mxcsr;
+    if (tcg_enabled()) {
+        update_mxcsr_status(env);
+    }
+}
+
+static inline void cpu_set_fpuc(CPUX86State *env, uint16_t fpuc)
+{
+     env->fpuc = fpuc;
+     if (tcg_enabled()) {
+        update_fp_status(env);
+     }
+}
+
+/* svm_helper.c */
+#ifdef CONFIG_USER_ONLY
+static inline void
+cpu_svm_check_intercept_param(CPUX86State *env1, uint32_t type,
+                              uint64_t param, uintptr_t retaddr)
+{ /* no-op */ }
+static inline bool
+cpu_svm_has_intercept(CPUX86State *env, uint32_t type)
+{ return false; }
+#else
+void cpu_svm_check_intercept_param(CPUX86State *env1, uint32_t type,
+                                   uint64_t param, uintptr_t retaddr);
+bool cpu_svm_has_intercept(CPUX86State *env, uint32_t type);
+#endif
+
+/* apic.c */
+void cpu_report_tpr_access(CPUX86State *env, TPRAccess access);
+void apic_handle_tpr_access_report(DeviceState *d, target_ulong ip,
+                                   TPRAccess access);
+
+/* Special values for X86CPUVersion: */
+
+/* Resolve to latest CPU version */
+#define CPU_VERSION_LATEST -1
+
+/*
+ * Resolve to version defined by current machine type.
+ * See x86_cpu_set_default_version()
+ */
+#define CPU_VERSION_AUTO   -2
+
+/* Don't resolve to any versioned CPU models, like old QEMU versions */
+#define CPU_VERSION_LEGACY  0
+
+typedef int X86CPUVersion;
+
+/*
+ * Set default CPU model version for CPU models having
+ * version == CPU_VERSION_AUTO.
+ */
+void x86_cpu_set_default_version(X86CPUVersion version);
+
+#ifndef CONFIG_USER_ONLY
+
+void do_cpu_sipi(X86CPU *cpu);
+
+#define APIC_DEFAULT_ADDRESS 0xfee00000
+#define APIC_SPACE_SIZE      0x100000
+
+/* cpu-dump.c */
+void x86_cpu_dump_local_apic_state(CPUState *cs, int flags);
+
+#endif
+
+/* cpu.c */
+bool cpu_is_bsp(X86CPU *cpu);
+
+void x86_cpu_xrstor_all_areas(X86CPU *cpu, const void *buf, uint32_t buflen);
+void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen);
+uint32_t xsave_area_size(uint64_t mask, bool compacted);
+void x86_update_hflags(CPUX86State* env);
+
+static inline bool hyperv_feat_enabled(X86CPU *cpu, int feat)
+{
+    return !!(cpu->hyperv_features & BIT(feat));
+}
+
+static inline uint64_t cr4_reserved_bits(CPUX86State *env)
+{
+    uint64_t reserved_bits = CR4_RESERVED_MASK;
+    if (!env->features[FEAT_XSAVE]) {
+        reserved_bits |= CR4_OSXSAVE_MASK;
+    }
+    if (!(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_SMEP)) {
+        reserved_bits |= CR4_SMEP_MASK;
+    }
+    if (!(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_SMAP)) {
+        reserved_bits |= CR4_SMAP_MASK;
+    }
+    if (!(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_FSGSBASE)) {
+        reserved_bits |= CR4_FSGSBASE_MASK;
+    }
+    if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_PKU)) {
+        reserved_bits |= CR4_PKE_MASK;
+    }
+    if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_LA57)) {
+        reserved_bits |= CR4_LA57_MASK;
+    }
+    if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_UMIP)) {
+        reserved_bits |= CR4_UMIP_MASK;
+    }
+    if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_PKS)) {
+        reserved_bits |= CR4_PKS_MASK;
+    }
+    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM)) {
+        reserved_bits |= CR4_LAM_SUP_MASK;
+    }
+    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED)) {
+        reserved_bits |= CR4_FRED_MASK;
+    }
+    return reserved_bits;
+}
+
+static inline bool ctl_has_irq(CPUX86State *env)
+{
+    uint32_t int_prio;
+    uint32_t tpr;
+
+    int_prio = (env->int_ctl & V_INTR_PRIO_MASK) >> V_INTR_PRIO_SHIFT;
+    tpr = env->int_ctl & V_TPR_MASK;
+
+    if (env->int_ctl & V_IGN_TPR_MASK) {
+        return (env->int_ctl & V_IRQ_MASK);
+    }
+
+    return (env->int_ctl & V_IRQ_MASK) && (int_prio >= tpr);
+}
+
+#if defined(TARGET_X86_64) && \
+    defined(CONFIG_USER_ONLY) && \
+    defined(CONFIG_LINUX)
+# define TARGET_VSYSCALL_PAGE  (UINT64_C(-10) << 20)
+#endif
+
+#endif /* I386_CPU_H */
-- 
2.47.1


