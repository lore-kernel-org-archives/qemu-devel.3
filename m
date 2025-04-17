Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391C8C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Mt2-0008WL-SN; Thu, 17 Apr 2025 06:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5Mt1-0008VW-Qu
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:54:27 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5Msw-0003cO-1Y
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:54:27 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736c1cf75e4so436866b3a.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 03:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744887260; x=1745492060; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tIJ3izDwhM7rqWWbObHdV4Xt43nkxUxukpA0UtZRKQU=;
 b=J7aePoEXsb/1ygPQzk0YKBoD4cs8t7T2hTCC6XQggA31kajZO1y8hkOV5Mipu3fNAo
 J9mK0fRjQeoLnIkgqOtSIRuub6eLbFGRTjLb2YQC2BMhjnZDFvdaDlnIM6aU4I9dIgmW
 bhrlgIN7l+rBmMe/wHd4I26FVQd9x/GIPc84lttE2rSeY2UGphBbCIiU5isIjr+SreEL
 ijvEJK/MBdN4AMvH84Qn3vtFd3O0pxgnFv6ppA8AErXmSPlBO0B323fDsqt9HG6NuQ04
 tWzcQX3wWX7Opbby1PyMAsJmpmbCV+QwhwY/vpEuBluOXWWCAEQW/xxhSkR1U7bYzsks
 3QBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744887260; x=1745492060;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tIJ3izDwhM7rqWWbObHdV4Xt43nkxUxukpA0UtZRKQU=;
 b=cfHykV3qWa/koSS4fZbt4ycgWM1JUwfJvg4bMT/AjcEOkaktg+kzwCTm+QajMV6LHC
 XUSl6fpA+w7jEP3UHzpmOeOnKJXHEnUngD0zCTfSgWOcohliF4br0z5o3J4u6BugUjgb
 4h5VNN1YwY0qnFkZDX+KSaVe87EatUExP9ETOmUw8s5OMWmSUfNS8ujlc7Eur8sa70AQ
 aiHbf2sfoY84xQN8LtMlKCDWA0B4APOD1bOhP4ezPtfurV+wnFoWwJIADbfu2GMLkNkP
 M/ba7YURA72dLyqwpGbE5s4VSXJmV1Szi4iXyYAz0czKYbdOcbV7xdulaQj60ttf08Mu
 3SPA==
X-Gm-Message-State: AOJu0YwuEooRWpg9//3rGHdymqOWprlhstr+Me34leEqIVYJq0zccxQ/
 f50Fg8WfuYLI/N0/GONCkeqeY/CPiMICnDAGBDtOBm8S9GMTIbzO7f0uUzqMSbtUTQO6U8tKBuz
 +ds/tF2vrXyr6C0ShmdyvQibykw0qtXTvjwQXHDVR/8lP8ypE/dTmdqKnEUmEAzhdukqI2HQNsl
 ETnXtgEjOWCgrgTC8uY+kDcNz7k1Fsjaw0tg==
X-Gm-Gg: ASbGnctMyMXoqSl8AOGZ47gDsO1TejkN99nenc9drXB1lnLHTsZl1IbuM/eY0I5XPfx
 9OvTDvGBu5CumNL59LAauAC6czVBBW4wdhQ3fmhlF8vzPAFCYWQlDbexNTdRKQCisPIhGBC/7Ma
 k3WjfGr7D8GpBw44Iweyj2yg67OxVupyXnVEfvky3dasREeWrm3+UZJXt4OjKpDce+yRL/H1RnX
 noJ9DC4oazG4tfPzQ3ttGX9Hz2BkyQnStIYYwhKy+SDN63uvw3pRyT+iqK7aJ20YxuiNKDwkwjq
 Lfr0J8AqSmGs4T9awvdISSWeZAOgDcVVIdCjDxinWdFRURusUzXAFZgFhbr1QEpVp5ONvgZitg=
 =
X-Google-Smtp-Source: AGHT+IF40f822bix5T7GlrTTNXiZpe0a+pnE6+4c9T/1uqdysjEy2VfHjvCtsnqbFP4gPuZJWv+TZw==
X-Received: by 2002:a05:6a00:888:b0:72f:590f:2859 with SMTP id
 d2e1a72fcca58-73c267174d7mr7807724b3a.13.1744887259678; 
 Thu, 17 Apr 2025 03:54:19 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230ddaasm12366251b3a.138.2025.04.17.03.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 03:54:19 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 14/18] hw/misc: riscv_wgchecker: Implement RISC-V
 WorldGuard Checker
Date: Thu, 17 Apr 2025 18:52:45 +0800
Message-Id: <20250417105249.18232-15-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250417105249.18232-1-jim.shu@sifive.com>
References: <20250417105249.18232-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Implement the RISC-V WorldGuard Checker, which sits in front of RAM or
device MMIO and allow software to configure it to either pass through or
reject transactions.

We implement the wgChecker as a QEMU IOMMU, which will direct transactions
either through to the devices and memory behind it or to a special
"never works" AddressSpace if they are blocked.

This initial commit implements the skeleton of the device:
 * it always permits accesses
 * it doesn't implement wgChecker's slot registers
 * it doesn't implement the interrupt or other behaviour
   for blocked transactions

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/misc/meson.build                |   2 +-
 hw/misc/riscv_wgchecker.c          | 603 +++++++++++++++++++++++++++++
 hw/misc/trace-events               |   8 +
 include/hw/misc/riscv_worldguard.h |  63 +++
 4 files changed, 675 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/riscv_wgchecker.c

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 3d2f4bb6a3..73c11bc7c9 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -34,7 +34,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
-specific_ss.add(when: 'CONFIG_RISCV_WORLDGUARD', if_true: files('riscv_worldguard.c'))
+specific_ss.add(when: 'CONFIG_RISCV_WORLDGUARD', if_true: files('riscv_worldguard.c', 'riscv_wgchecker.c'))
 
 subdir('macio')
 
diff --git a/hw/misc/riscv_wgchecker.c b/hw/misc/riscv_wgchecker.c
new file mode 100644
index 0000000000..ea50f4f53a
--- /dev/null
+++ b/hw/misc/riscv_wgchecker.c
@@ -0,0 +1,603 @@
+/*
+ * RISC-V WorldGuard Checker Device
+ *
+ * Copyright (c) 2022 SiFive, Inc.
+ *
+ * This provides WorldGuard Checker model.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "exec/hwaddr.h"
+#include "exec/exec-all.h"
+#include "hw/irq.h"
+#include "hw/registerfields.h"
+#include "hw/sysbus.h"
+#include "hw/hw.h"
+#include "hw/qdev-properties.h"
+#include "hw/misc/riscv_worldguard.h"
+#include "target/riscv/cpu.h"
+#include "trace.h"
+
+/* Common */
+REG32(VENDOR,               0x000)
+REG32(IMPID,                0x004)
+
+/* wgChecker */
+REG32(NSLOTS,               0x008)
+REG64(ERRCAUSE,             0x010)
+    FIELD(ERRCAUSE, WID,        0,  8)
+    FIELD(ERRCAUSE, R,          8,  1)
+    FIELD(ERRCAUSE, W,          9,  1)
+    FIELD(ERRCAUSE, BE,         62, 1)
+    FIELD(ERRCAUSE, IP,         63, 1)
+
+#define ERRCAUSE_MASK   \
+    (R_ERRCAUSE_WID_MASK | \
+     R_ERRCAUSE_R_MASK   | \
+     R_ERRCAUSE_W_MASK   | \
+     R_ERRCAUSE_BE_MASK  | \
+     R_ERRCAUSE_IP_MASK)
+
+REG64(ERRADDR,              0x018)
+
+/*
+ * Accesses only reach these read and write functions if the wgChecker
+ * is blocking them; non-blocked accesses go directly to the downstream
+ * memory region without passing through this code.
+ */
+static MemTxResult riscv_wgc_mem_blocked_read(void *opaque, hwaddr addr,
+                                               uint64_t *pdata,
+                                               unsigned size, MemTxAttrs attrs)
+{
+    uint32_t wid = mem_attrs_to_wid(attrs);
+
+    trace_riscv_wgc_mem_blocked_read(addr, size, wid);
+
+    *pdata = 0;
+    return MEMTX_OK;
+}
+
+static MemTxResult riscv_wgc_mem_blocked_write(void *opaque, hwaddr addr,
+                                               uint64_t value,
+                                               unsigned size, MemTxAttrs attrs)
+{
+    uint32_t wid = mem_attrs_to_wid(attrs);
+
+    trace_riscv_wgc_mem_blocked_write(addr, value, size, wid);
+
+    return MEMTX_OK;
+}
+
+static const MemoryRegionOps riscv_wgc_mem_blocked_ops = {
+    .read_with_attrs = riscv_wgc_mem_blocked_read,
+    .write_with_attrs = riscv_wgc_mem_blocked_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 8,
+};
+
+static IOMMUTLBEntry riscv_wgc_translate(IOMMUMemoryRegion *iommu,
+                                          hwaddr addr, IOMMUAccessFlags flags,
+                                          int iommu_idx)
+{
+    WgCheckerRegion *region = container_of(iommu, WgCheckerRegion, upstream);
+    RISCVWgCheckerState *s = RISCV_WGCHECKER(region->wgchecker);
+    hwaddr phys_addr;
+    uint64_t region_size;
+
+    IOMMUTLBEntry ret = {
+        .iova = addr & ~WG_ALIGNED_MASK,
+        .translated_addr = addr & ~WG_ALIGNED_MASK,
+        .addr_mask = WG_ALIGNED_MASK,
+        .perm = IOMMU_RW,
+    };
+
+    /* addr shouldn't exceed region size of down/upstream. */
+    region_size = memory_region_size(region->downstream);
+    g_assert(addr < region_size);
+
+    /*
+     * Look at the wgChecker configuration for this address, and
+     * return a TLB entry directing the transaction at either
+     * downstream_as or blocked_io_as, as appropriate.
+     * For the moment, always permit accesses.
+     */
+
+    /* Use physical address instead of offset */
+    phys_addr = addr + region->region_offset;
+
+    is_success = true;
+
+    trace_riscv_wgc_translate(phys_addr, flags,
+        iommu_idx, is_success ? "pass" : "block");
+
+    ret.target_as = is_success ? &region->downstream_as : &region->blocked_io_as;
+    return ret;
+}
+
+static int riscv_wgc_attrs_to_index(IOMMUMemoryRegion *iommu, MemTxAttrs attrs)
+{
+    return mem_attrs_to_wid(attrs);
+}
+
+static int riscv_wgc_num_indexes(IOMMUMemoryRegion *iommu)
+{
+    return worldguard_config->nworlds;
+}
+
+static uint64_t riscv_wgchecker_readq(void *opaque, hwaddr addr)
+{
+    RISCVWgCheckerState *s = RISCV_WGCHECKER(opaque);
+    uint64_t val = 0;
+
+    switch (addr) {
+    case A_ERRCAUSE:
+        val = s->errcause & ERRCAUSE_MASK;
+        break;
+    case A_ERRADDR:
+        val = s->erraddr;
+        break;
+    case A_NSLOTS:
+        val = s->slot_count;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Unexpected memory access to (0x%" HWADDR_PRIX ", %u) \n",
+                      __func__, addr, 8);
+        break;
+    }
+
+    return val;
+}
+
+static uint64_t riscv_wgchecker_readl(void *opaque, hwaddr addr)
+{
+    RISCVWgCheckerState *s = RISCV_WGCHECKER(opaque);
+    uint64_t val = 0;
+
+    switch (addr) {
+    case A_VENDOR:
+        val = 0;
+        break;
+    case A_IMPID:
+        val = 0;
+        break;
+    case A_NSLOTS:
+        val = extract64(s->slot_count, 0, 32);
+        break;
+    case A_NSLOTS + 4:
+        val = extract64(s->slot_count, 0, 32);
+        break;
+    case A_ERRCAUSE:
+        val = s->errcause & ERRCAUSE_MASK;
+        val = extract64(val, 0, 32);
+        break;
+    case A_ERRCAUSE + 4:
+        val = s->errcause & ERRCAUSE_MASK;
+        val = extract64(val, 32, 32);
+        break;
+    case A_ERRADDR:
+        val = extract64(s->erraddr, 0, 32);
+        break;
+    case A_ERRADDR + 4:
+        val = extract64(s->erraddr, 32, 32);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Unexpected memory access to (0x%" HWADDR_PRIX ", %u) \n",
+                      __func__, addr, 4);
+        break;
+    }
+
+    return val;
+}
+
+static uint64_t riscv_wgchecker_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint64_t val = 0;
+
+    switch (size) {
+    case 8:
+        val = riscv_wgchecker_readq(opaque, addr);
+        break;
+    case 4:
+        val = riscv_wgchecker_readl(opaque, addr);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid read size %u to wgChecker\n",
+                      __func__, size);
+        return 0;
+    }
+
+    return val;
+}
+
+static void riscv_wgchecker_writeq(void *opaque, hwaddr addr,
+                                    uint64_t value)
+{
+    RISCVWgCheckerState *s = RISCV_WGCHECKER(opaque);
+
+    switch (addr) {
+    case A_ERRCAUSE:
+        s->errcause = value & ERRCAUSE_MASK;
+        break;
+    case A_ERRADDR:
+        s->erraddr = value;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Unexpected memory access to (0x%" HWADDR_PRIX ", %u) \n",
+                      __func__, addr, 8);
+        break;
+    }
+}
+
+static void riscv_wgchecker_writel(void *opaque, hwaddr addr,
+                                    uint64_t value)
+{
+    RISCVWgCheckerState *s = RISCV_WGCHECKER(opaque);
+
+    switch (addr) {
+    case A_ERRCAUSE:
+        value &= extract64(ERRCAUSE_MASK, 0, 32);
+        s->errcause = deposit64(s->errcause, 0, 32, value);
+        break;
+    case A_ERRCAUSE + 4:
+        value &= extract64(ERRCAUSE_MASK, 32, 32);
+        s->errcause = deposit64(s->errcause, 32, 32, value);
+        break;
+    case A_ERRADDR:
+        s->erraddr = deposit64(s->erraddr, 0, 32, value);
+        break;
+    case A_ERRADDR + 4:
+        s->erraddr = deposit64(s->erraddr, 32, 32, value);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Unexpected memory access to (0x%" HWADDR_PRIX ", %u) \n",
+                      __func__, addr, 4);
+        break;
+    }
+}
+
+static void riscv_wgchecker_write(void *opaque, hwaddr addr,
+                                   uint64_t value, unsigned size)
+{
+    switch (size) {
+    case 8:
+        riscv_wgchecker_writeq(opaque, addr, value);
+        break;
+    case 4:
+        riscv_wgchecker_writel(opaque, addr, value);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid write size %u to wgChecker\n",
+                      __func__, size);
+        break;
+    }
+}
+
+static MemTxResult riscv_wgchecker_read_with_attrs(
+    void *opaque, hwaddr addr, uint64_t *pdata, unsigned size,
+    MemTxAttrs attrs)
+{
+    SysBusDevice *dev = SYS_BUS_DEVICE(opaque);
+
+    trace_riscv_wgchecker_mmio_read(dev->mmio[0].addr, addr, size);
+
+    *pdata = 0;
+    if (could_access_wgblocks(attrs, "wgChecker")) {
+        *pdata = riscv_wgchecker_read(opaque, addr, size);
+    }
+
+    return MEMTX_OK;
+}
+
+static MemTxResult riscv_wgchecker_write_with_attrs(
+    void *opaque, hwaddr addr, uint64_t data, unsigned size,
+    MemTxAttrs attrs)
+{
+    SysBusDevice *dev = SYS_BUS_DEVICE(opaque);
+
+    trace_riscv_wgchecker_mmio_write(dev->mmio[0].addr, addr, size, data);
+
+    if (could_access_wgblocks(attrs, "wgChecker")) {
+        riscv_wgchecker_write(opaque, addr, data, size);
+    }
+
+    return MEMTX_OK;
+}
+
+static const MemoryRegionOps riscv_wgchecker_ops = {
+    .read_with_attrs = riscv_wgchecker_read_with_attrs,
+    .write_with_attrs = riscv_wgchecker_write_with_attrs,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 8
+    }
+};
+
+static void riscv_wgc_iommu_memory_region_class_init(ObjectClass *klass,
+                                                  void *data)
+{
+    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
+
+    imrc->translate = riscv_wgc_translate;
+    imrc->attrs_to_index = riscv_wgc_attrs_to_index;
+    imrc->num_indexes = riscv_wgc_num_indexes;
+}
+
+static const TypeInfo riscv_wgc_iommu_memory_region_info = {
+    .name = TYPE_RISCV_WGC_IOMMU_MEMORY_REGION,
+    .parent = TYPE_IOMMU_MEMORY_REGION,
+    .class_init = riscv_wgc_iommu_memory_region_class_init,
+};
+
+
+#define DEFINE_REGION(N)                                                \
+    DEFINE_PROP_LINK("downstream-mr[" #N "]", RISCVWgCheckerState,     \
+                     mem_regions[N].downstream,                         \
+                     TYPE_MEMORY_REGION, MemoryRegion *),               \
+    DEFINE_PROP_UINT64("region-offset[" #N "]", RISCVWgCheckerState,   \
+                       mem_regions[N].region_offset, 0)                 \
+
+static Property riscv_wgchecker_properties[] = {
+    DEFINE_PROP_UINT32("slot-count", RISCVWgCheckerState, slot_count, 0x1),
+    DEFINE_PROP_UINT32("mmio-size", RISCVWgCheckerState, mmio_size, 0x1000),
+
+    /* Assume 1 wgChecker has 16 regions at maximum (WGC_NUM_REGIONS). */
+    DEFINE_REGION(0), DEFINE_REGION(1), DEFINE_REGION(2), DEFINE_REGION(3),
+    DEFINE_REGION(4), DEFINE_REGION(5), DEFINE_REGION(6), DEFINE_REGION(7),
+    DEFINE_REGION(8), DEFINE_REGION(9), DEFINE_REGION(10), DEFINE_REGION(11),
+    DEFINE_REGION(12), DEFINE_REGION(13), DEFINE_REGION(14), DEFINE_REGION(15),
+
+    DEFINE_PROP_UINT64("addr-range-start", RISCVWgCheckerState, addr_range_start, 0),
+    DEFINE_PROP_UINT64("addr-range-size", RISCVWgCheckerState, addr_range_size, UINT64_MAX),
+
+    /*
+     * We could only set individual wgChecker to hw-bypass mode. It is
+     * usually used in wgChecker of BootROM, since SW has no way to enable
+     * the permission of it.
+     */
+    DEFINE_PROP_BOOL("hw-bypass", RISCVWgCheckerState, hw_bypass, false),
+};
+
+static int int_log2_down(int n)
+{
+    int i = 0;
+
+    n >>= 1;
+
+    while (n) {
+        i++;
+        n >>= 1;
+    }
+
+    return i;
+}
+
+static int int_log2_up(int n)
+{
+    return int_log2_down(n - 1) + 1;
+}
+
+/*
+ * Change the address range to be NAPOT alignment.
+ *
+ * New address range should totally cover the origin range, but new range
+ * should be configured by 1 NAPOT region (slot).
+ */
+static void address_range_align_napot(RISCVWgCheckerState *s)
+{
+    uint64_t start, end, size, new_size;
+
+    start = s->addr_range_start;
+    end = s->addr_range_start + s->addr_range_size;
+    size = s->addr_range_size;
+
+    if (size == UINT64_MAX) {
+        /* Full address range. No need of NAPOT alignment. */
+        return;
+    }
+
+    /* Size is the next power-of-2 number. */
+    size = 1 << (int_log2_up(size));
+    start = QEMU_ALIGN_DOWN(start, size);
+    end = QEMU_ALIGN_UP(end, size);
+    new_size = end - start;
+
+    /*
+     * If base is not aligned to region size (new_size),
+     * double the region size and try it again.
+     */
+    while ((new_size != size) && (size != 1ULL << 63)) {
+        size *= 2;
+        start = QEMU_ALIGN_DOWN(start, size);
+        end = QEMU_ALIGN_UP(end, size);
+        new_size = end - start;
+    }
+
+    s->addr_range_start = start;
+    s->addr_range_size = size;
+}
+
+static void riscv_wgchecker_realize(DeviceState *dev, Error **errp)
+{
+    Object *obj = OBJECT(dev);
+    RISCVWgCheckerState *s = RISCV_WGCHECKER(dev);
+    uint64_t size;
+
+    if (worldguard_config == NULL) {
+        error_setg(errp, "Couldn't find global WorldGuard configs. "
+                   "Please realize %s device at first.",
+                   TYPE_RISCV_WORLDGUARD);
+        return;
+    }
+
+    if (s->slot_count == 0) {
+        error_setg(errp, "wgChecker slot-count couldn't be zero.");
+        return;
+    }
+
+    memory_region_init_io(&s->mmio, OBJECT(dev), &riscv_wgchecker_ops, s,
+                          TYPE_RISCV_WGCHECKER, s->mmio_size);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+
+    /* Address range should be NAPOT alignment */
+    address_range_align_napot(s);
+
+    for (int i=0; i<WGC_NUM_REGIONS; i++) {
+        WgCheckerRegion *region = &s->mem_regions[i];
+
+        if (!region->downstream) {
+            continue;
+        }
+        region->wgchecker = s;
+
+        const char *upstream_name = g_strdup_printf(
+            "wgchecker-upstream-%"HWADDR_PRIx, region->region_offset);
+        const char *downstream_name = g_strdup_printf(
+            "wgchecker-downstream-%"HWADDR_PRIx, region->region_offset);
+
+        size = memory_region_size(region->downstream);
+        memory_region_init_iommu(&region->upstream, sizeof(region->upstream),
+                                 TYPE_RISCV_WGC_IOMMU_MEMORY_REGION,
+                                 obj, upstream_name, size);
+
+        /* upstream MRs are 2nd ~ (n+1)th MemoryRegion. */
+        sysbus_init_mmio(SYS_BUS_DEVICE(dev), MEMORY_REGION(&region->upstream));
+
+        /*
+         * This memory region is not exposed to users of this device as a
+         * sysbus MMIO region, but is instead used internally as something
+         * that our IOMMU translate function might direct accesses to.
+         */
+        memory_region_init_io(&region->blocked_io, obj, &riscv_wgc_mem_blocked_ops,
+                              region, "wgchecker-blocked-io", size);
+
+        address_space_init(&region->downstream_as, region->downstream,
+                           downstream_name);
+        address_space_init(&region->blocked_io_as, &region->blocked_io,
+                           "wgchecker-blocked-io");
+    }
+}
+
+static void riscv_wgchecker_unrealize(DeviceState *dev)
+{
+    RISCVWgCheckerState *s = RISCV_WGCHECKER(dev);
+
+    g_free(s->slots);
+    if (s->num_default_slots && s->default_slots) {
+        g_free(s->default_slots);
+    }
+}
+
+static void riscv_wgchecker_reset_enter(Object *obj, ResetType type)
+{
+    RISCVWgCheckerState *s = RISCV_WGCHECKER(obj);
+    uint64_t start = s->addr_range_start;
+    uint64_t end = s->addr_range_start + s->addr_range_size;
+    int nslots = s->slot_count;
+
+    s->errcause = 0;
+    s->erraddr = 0;
+}
+
+static void riscv_wgchecker_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, riscv_wgchecker_properties);
+    dc->user_creatable = true;
+    dc->realize = riscv_wgchecker_realize;
+    dc->unrealize = riscv_wgchecker_unrealize;
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    rc->phases.enter = riscv_wgchecker_reset_enter;
+}
+
+static void riscv_wgchecker_instance_init(Object *obj)
+{
+    RISCVWgCheckerState *s = RISCV_WGCHECKER(obj);
+
+    s->num_default_slots = 0;
+}
+
+static const TypeInfo riscv_wgchecker_info = {
+    .name          = TYPE_RISCV_WGCHECKER,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = riscv_wgchecker_instance_init,
+    .instance_size = sizeof(RISCVWgCheckerState),
+    .class_init    = riscv_wgchecker_class_init,
+};
+
+static void riscv_wgchecker_register_types(void)
+{
+    type_register_static(&riscv_wgchecker_info);
+    type_register_static(&riscv_wgc_iommu_memory_region_info);
+}
+
+type_init(riscv_wgchecker_register_types)
+
+/*
+ * Create WgChecker device
+ */
+DeviceState *riscv_wgchecker_create(hwaddr addr, uint32_t size,
+                                    qemu_irq irq, uint32_t slot_count,
+                                    uint64_t addr_range_start,
+                                    uint64_t addr_range_size,
+                                    uint32_t num_of_region,
+                                    MemoryRegion **downstream,
+                                    uint64_t *region_offset,
+                                    uint32_t num_default_slots,
+                                    WgCheckerSlot *default_slots)
+{
+    DeviceState *dev = qdev_new(TYPE_RISCV_WGCHECKER);
+    RISCVWgCheckerState *s = RISCV_WGCHECKER(dev);
+    char name_mr[32];
+    char name_offset[32];
+    int i;
+
+    qdev_prop_set_uint32(dev, "slot-count", slot_count);
+    qdev_prop_set_uint32(dev, "mmio-size", size);
+    qdev_prop_set_uint64(dev, "addr-range-start", addr_range_start);
+    if (addr_range_size) {
+        qdev_prop_set_uint64(dev, "addr-range-size", addr_range_size);
+    }
+
+    g_assert(num_of_region <= WGC_NUM_REGIONS);
+    for (i=0; i<num_of_region; i++) {
+        snprintf(name_mr, 32, "downstream-mr[%d]", i);
+        snprintf(name_offset, 32, "region-offset[%d]", i);
+
+        object_property_set_link(OBJECT(dev), name_mr,
+                                 OBJECT(downstream[i]), &error_fatal);
+        qdev_prop_set_uint64(dev, name_offset, region_offset[i]);
+    }
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
+    return dev;
+}
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 4383808d7a..b1d8538220 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -395,3 +395,11 @@ ivshmem_flat_interrupt_peer(uint16_t peer_id, uint16_t vector_id) "Interrupting
 i2c_echo_event(const char *id, const char *event) "%s: %s"
 i2c_echo_recv(const char *id, uint8_t data) "%s: recv 0x%02" PRIx8
 i2c_echo_send(const char *id, uint8_t data) "%s: send 0x%02" PRIx8
+
+# riscv_worldguard.c
+riscv_wgchecker_mmio_read(uint64_t base, uint64_t offset, unsigned int size) "base = 0x%"PRIx64", offset = 0x%"PRIx64", size = 0x%x"
+riscv_wgchecker_mmio_write(uint64_t base, uint64_t offset, unsigned int size, uint64_t val) "base = 0x%"PRIx64", offset = 0x%"PRIx64", size = 0x%x, val = 0x%"PRIx64
+
+riscv_wgc_mem_blocked_read(uint64_t addr, unsigned size, uint32_t wid) "wgChecker blocked read: offset 0x%" PRIx64 " size %u wid %" PRIu32
+riscv_wgc_mem_blocked_write(uint64_t addr, uint64_t data, unsigned size, uint32_t wid) "wgChecker blocked write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u wid %" PRIu32
+riscv_wgc_translate(uint64_t addr, int flags, int wid, const char *res) "wgChecker translate: addr 0x%016" PRIx64 " flags 0x%x wid %d: %s"
diff --git a/include/hw/misc/riscv_worldguard.h b/include/hw/misc/riscv_worldguard.h
index 211a72e438..7b5aae866a 100644
--- a/include/hw/misc/riscv_worldguard.h
+++ b/include/hw/misc/riscv_worldguard.h
@@ -53,4 +53,67 @@ void riscv_worldguard_apply_cpu(uint32_t hartid);
 uint32_t mem_attrs_to_wid(MemTxAttrs attrs);
 bool could_access_wgblocks(MemTxAttrs attrs, const char *wgblock);
 
+#define TYPE_RISCV_WGCHECKER  "riscv.wgchecker"
+
+typedef struct RISCVWgCheckerState RISCVWgCheckerState;
+DECLARE_INSTANCE_CHECKER(RISCVWgCheckerState, RISCV_WGCHECKER,
+                         TYPE_RISCV_WGCHECKER)
+
+#define TYPE_RISCV_WGC_IOMMU_MEMORY_REGION    "riscv-wgc-iommu-memory-region"
+
+typedef struct WgCheckerSlot WgCheckerSlot;
+struct WgCheckerSlot {
+    uint64_t addr;
+    uint64_t perm;
+    uint32_t cfg;
+};
+
+typedef struct WgCheckerRegion WgCheckerRegion;
+struct WgCheckerRegion {
+    MemoryRegion *downstream;
+    uint64_t region_offset;
+
+    IOMMUMemoryRegion upstream;
+    MemoryRegion blocked_io;
+    AddressSpace downstream_as;
+    AddressSpace blocked_io_as;
+
+    RISCVWgCheckerState *wgchecker;
+};
+
+#define WGC_NUM_REGIONS     16
+
+struct RISCVWgCheckerState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion mmio;
+    qemu_irq irq;
+
+    /* error reg */
+    uint64_t errcause;
+    uint64_t erraddr;
+
+    /* Memory regions protected by wgChecker */
+    WgCheckerRegion mem_regions[WGC_NUM_REGIONS];
+
+    /* Property */
+    uint32_t slot_count; /* nslots */
+    uint32_t mmio_size;
+    uint64_t addr_range_start;
+    uint64_t addr_range_size;
+    bool hw_bypass;
+};
+
+DeviceState *riscv_wgchecker_create(hwaddr addr, uint32_t size,
+                                    qemu_irq irq, uint32_t slot_count,
+                                    uint64_t addr_range_start,
+                                    uint64_t addr_range_size,
+                                    uint32_t num_of_region,
+                                    MemoryRegion **downstream,
+                                    uint64_t *region_offset,
+                                    uint32_t num_default_slots,
+                                    WgCheckerSlot *default_slots);
+
 #endif
-- 
2.17.1


