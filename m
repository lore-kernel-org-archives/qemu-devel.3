Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2A5C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4h0k-00086s-RV; Wed, 08 May 2024 09:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s4h0Y-0007rb-1z
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:06:54 -0400
Received: from fhigh5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s4h0V-0006P0-Hf
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:06:53 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 6DA3711400CB;
 Wed,  8 May 2024 09:06:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Wed, 08 May 2024 09:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715173610;
 x=1715260010; bh=0woTM6v2YrHEnCvmMyaL4AAFc2N7E4nD7s8VicpXfHw=; b=
 Gori9IIIcp8ZQs8OFBgQzexpkEvze21mZTroDKflnyM1aTn/LnsT9HOG7+TedZlc
 vD78hD6Wc5nW+DZgfdbIPSCKlEyIr6Z86sX+lgW5DreNtv7GMd4da/FhRVcT5Db9
 K+8e7Tj8jec7D9/VmF6gv9AQh+jbnICtxlFUYQcPoN5r8np2e5stWtW3jF17y9dl
 KuqtrFJZqoIkzBZGIkoMm4eNdoP2NL0g7G8KAPVk/zAr3G3cnZD0dgPy0J89M2mx
 jxANRh+C/TeBDv38Dsd1whzAPKhtm/ByjKRBJg+th1Sb833+OoXU4o/oU9p6HYsK
 5jqJpG8g3MGrHjPd9sFdNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715173610; x=
 1715260010; bh=0woTM6v2YrHEnCvmMyaL4AAFc2N7E4nD7s8VicpXfHw=; b=h
 4T8AQk+fjzrIJZbthnocQwk0h1Z4fSFMCZIUBcpTm24MpxCkv8tAnINwK0rXb7f1
 cN8DFAS99TfAQQURp4Xr8bofQELZQZvuKxtzMWOxHLNkws5TuDz4t/wiTrNlZj8g
 sn9xE9plb0IUL4iT0TEPQsCA5mj4SxWy90QXCQanINiRI2YGQOZG9RShtY/2x7NS
 yUnt8CXdraNXj2j/91TbXK47ZJnTYr5L1g/IrLYz7XDfqwbRfBWUMr5eBx4nd2ju
 VrNmHgaFndTHHPQCCGk4hYISSdpv/hJ+3d/kLRFhPQ2zFl2lYohyg25ePgiw5kXQ
 AbIe0uIqUCcrJaK+/yiDg==
X-ME-Sender: <xms:6Xg7ZpMZ3XiHYq6_BjxKeg5YoyGMfbaPHdSk9OQFzj5ttDc72gK-Eg>
 <xme:6Xg7Zr8RmHAZzvLUACJClDtry3akbR8vB91DNjUXMn9Z7pYV_q3gEzTixQt4r4Oer
 7IPBL-41oIePzVkS2A>
X-ME-Received: <xmr:6Xg7ZoSAJYbbSzOJYAR3iFy0P1YhXr6TsU0kGnZ8ZUIT_ocCjIYn3Eo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:6Xg7Zlu8AQZOItnrAdnMMA0-gSNXIn7LqlURf1ViBfLSLuM3EbpnSw>
 <xmx:6Xg7Zhe5HujoFdC20xhttf4cPuGmJFDGK9nfcyxLmnlyqZY42GMZQQ>
 <xmx:6Xg7Zh0VeoMbNQ44-KK_fv20ryOJso1JB_OrbQknipNJWXNhKo4jhg>
 <xmx:6Xg7Zt-cTLmE79CZYZmnX-jKXK8UZPBI78FaTMJ8xPTegt144UfWsg>
 <xmx:6ng7ZqFu3qSNaupVrG0nhtkes0VM3pzKZXw4LA8Uo7qMGpkUcFrSvsmV>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 May 2024 09:06:48 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 08 May 2024 14:06:47 +0100
Subject: [PATCH 2/5] hw/intc/loongarch_ipi: Rename as loongson_ipi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-loongson3-ipi-v1-2-1a7b67704664@flygoat.com>
References: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
In-Reply-To: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16805;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=Lx+O7k+C2WBGs0hlCmEOhNAyiKma2qcM3y8l7fMFfDI=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTriudvtKqi37YfVQr4UpHq4P77t51KtOcHp5YH80SEj
 gQcfXu6o5SFQYyDQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACbispmR4V5I15SA699fllQt
 4E0z/PkvqDf3fcrqO3vlZLXb+7/6RzIydEprFhup5CbysHzs0424KVyksE+oL3tCdti/2zEy4r+
 5AQ==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.156;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

This device will be shared among LoongArch and MIPS
based Loongson machine, rename it as loongson_ipi
to reflect this nature.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 MAINTAINERS                                        |   4 +
 hw/intc/Kconfig                                    |   2 +-
 hw/intc/loongson_ipi.c                             | 347 +++++++++++++++++++++
 hw/intc/meson.build                                |   2 +-
 hw/intc/trace-events                               |   6 +-
 hw/loongarch/Kconfig                               |   2 +-
 hw/loongarch/virt.c                                |   4 +-
 .../hw/intc/{loongarch_ipi.h => loongson_ipi.h}    |  12 +-
 include/hw/loongarch/virt.h                        |   2 +-
 9 files changed, 366 insertions(+), 15 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f08cc528eb6..290dc3227baf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1241,7 +1241,9 @@ F: configs/devices/loongarch64-softmmu/default.mak
 F: hw/loongarch/
 F: include/hw/loongarch/virt.h
 F: include/hw/intc/loongarch_*.h
+F: include/hw/intc/loongson_ipi.h
 F: hw/intc/loongarch_*.c
+F: hw/intc/loongson_ipi.c
 F: include/hw/pci-host/ls7a.h
 F: hw/rtc/ls7a_rtc.c
 F: gdb-xml/loongarch*.xml
@@ -1375,10 +1377,12 @@ Loongson-3 virtual platforms
 M: Huacai Chen <chenhuacai@kernel.org>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Maintained
+F: hw/intc/loongson_ipi.c
 F: hw/intc/loongson_liointc.c
 F: hw/mips/loongson3_bootp.c
 F: hw/mips/loongson3_bootp.h
 F: hw/mips/loongson3_virt.c
+F: include/hw/intc/loongson_ipi.h
 F: include/hw/intc/loongson_liointc.h
 F: tests/avocado/machine_mips_loongson3v.py
 
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index ad59abebaa1d..58b6d3a71003 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -87,7 +87,7 @@ config GOLDFISH_PIC
 config M68K_IRQC
     bool
 
-config LOONGARCH_IPI
+config LOONGSON_IPI
     bool
 
 config LOONGARCH_PCH_PIC
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
new file mode 100644
index 000000000000..8c888da3b27c
--- /dev/null
+++ b/hw/intc/loongson_ipi.c
@@ -0,0 +1,347 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Loongson ipi interrupt support
+ *
+ * Copyright (C) 2021 Loongson Technology Corporation Limited
+ */
+
+#include "qemu/osdep.h"
+#include "hw/boards.h"
+#include "hw/sysbus.h"
+#include "hw/intc/loongson_ipi.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "exec/address-spaces.h"
+#include "migration/vmstate.h"
+#include "target/loongarch/cpu.h"
+#include "trace.h"
+
+static MemTxResult loongson_ipi_readl(void *opaque, hwaddr addr,
+                                       uint64_t *data,
+                                       unsigned size, MemTxAttrs attrs)
+{
+    IPICore *s;
+    LoongsonIPI *ipi = opaque;
+    uint64_t ret = 0;
+    int index = 0;
+
+    s = &ipi->cpu[attrs.requester_id];
+    addr &= 0xff;
+    switch (addr) {
+    case CORE_STATUS_OFF:
+        ret = s->status;
+        break;
+    case CORE_EN_OFF:
+        ret = s->en;
+        break;
+    case CORE_SET_OFF:
+        ret = 0;
+        break;
+    case CORE_CLEAR_OFF:
+        ret = 0;
+        break;
+    case CORE_BUF_20 ... CORE_BUF_38 + 4:
+        index = (addr - CORE_BUF_20) >> 2;
+        ret = s->buf[index];
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "invalid read: %x", (uint32_t)addr);
+        break;
+    }
+
+    trace_loongson_ipi_read(size, (uint64_t)addr, ret);
+    *data = ret;
+    return MEMTX_OK;
+}
+
+static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr,
+                          MemTxAttrs attrs)
+{
+    int i, mask = 0, data = 0;
+
+    /*
+     * bit 27-30 is mask for byte writing,
+     * if the mask is 0, we need not to do anything.
+     */
+    if ((val >> 27) & 0xf) {
+        data = address_space_ldl(env->address_space_iocsr, addr,
+                                 attrs, NULL);
+        for (i = 0; i < 4; i++) {
+            /* get mask for byte writing */
+            if (val & (0x1 << (27 + i))) {
+                mask |= 0xff << (i * 8);
+            }
+        }
+    }
+
+    data &= mask;
+    data |= (val >> 32) & ~mask;
+    address_space_stl(env->address_space_iocsr, addr,
+                      data, attrs, NULL);
+}
+
+static int archid_cmp(const void *a, const void *b)
+{
+   CPUArchId *archid_a = (CPUArchId *)a;
+   CPUArchId *archid_b = (CPUArchId *)b;
+
+   return archid_a->arch_id - archid_b->arch_id;
+}
+
+static CPUArchId *find_cpu_by_archid(MachineState *ms, uint32_t id)
+{
+    CPUArchId apic_id, *found_cpu;
+
+    apic_id.arch_id = id;
+    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
+        ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
+        archid_cmp);
+
+    return found_cpu;
+}
+
+static CPUState *ipi_getcpu(int arch_id)
+{
+    MachineState *machine = MACHINE(qdev_get_machine());
+    CPUArchId *archid;
+
+    archid = find_cpu_by_archid(machine, arch_id);
+    if (archid) {
+        return CPU(archid->cpu);
+    }
+
+    return NULL;
+}
+
+static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
+{
+    uint32_t cpuid;
+    hwaddr addr;
+    CPUState *cs;
+
+    cpuid = extract32(val, 16, 10);
+    cs = ipi_getcpu(cpuid);
+    if (cs == NULL) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    /* override requester_id */
+    addr = SMP_IPI_MAILBOX + CORE_BUF_20 + (val & 0x1c);
+    attrs.requester_id = cs->cpu_index;
+    send_ipi_data(&LOONGARCH_CPU(cs)->env, val, addr, attrs);
+    return MEMTX_OK;
+}
+
+static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
+{
+    uint32_t cpuid;
+    hwaddr addr;
+    CPUState *cs;
+
+    cpuid = extract32(val, 16, 10);
+    cs = ipi_getcpu(cpuid);
+    if (cs == NULL) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    /* override requester_id */
+    addr = val & 0xffff;
+    attrs.requester_id = cs->cpu_index;
+    send_ipi_data(&LOONGARCH_CPU(cs)->env, val, addr, attrs);
+    return MEMTX_OK;
+}
+
+static MemTxResult loongson_ipi_writel(void *opaque, hwaddr addr, uint64_t val,
+                                        unsigned size, MemTxAttrs attrs)
+{
+    LoongsonIPI *ipi = opaque;
+    IPICore *s;
+    int index = 0;
+    uint32_t cpuid;
+    uint8_t vector;
+    CPUState *cs;
+
+    s = &ipi->cpu[attrs.requester_id];
+    addr &= 0xff;
+    trace_loongson_ipi_write(size, (uint64_t)addr, val);
+    switch (addr) {
+    case CORE_STATUS_OFF:
+        qemu_log_mask(LOG_GUEST_ERROR, "can not be written");
+        break;
+    case CORE_EN_OFF:
+        s->en = val;
+        break;
+    case CORE_SET_OFF:
+        s->status |= val;
+        if (s->status != 0 && (s->status & s->en) != 0) {
+            qemu_irq_raise(s->irq);
+        }
+        break;
+    case CORE_CLEAR_OFF:
+        s->status &= ~val;
+        if (s->status == 0 && s->en != 0) {
+            qemu_irq_lower(s->irq);
+        }
+        break;
+    case CORE_BUF_20 ... CORE_BUF_38 + 4:
+        index = (addr - CORE_BUF_20) >> 2;
+        s->buf[index] = val;
+        break;
+    case IOCSR_IPI_SEND:
+        cpuid = extract32(val, 16, 10);
+        /* IPI status vector */
+        vector = extract8(val, 0, 5);
+        cs = ipi_getcpu(cpuid);
+        if (cs == NULL) {
+            return MEMTX_DECODE_ERROR;
+        }
+
+        /* override requester_id */
+        attrs.requester_id = cs->cpu_index;
+        loongson_ipi_writel(ipi, CORE_SET_OFF, BIT(vector), 4, attrs);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "invalid write: %x", (uint32_t)addr);
+        break;
+    }
+
+    return MEMTX_OK;
+}
+
+static const MemoryRegionOps loongson_ipi_ops = {
+    .read_with_attrs = loongson_ipi_readl,
+    .write_with_attrs = loongson_ipi_writel,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 8,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+/* mail send and any send only support writeq */
+static MemTxResult loongson_ipi_writeq(void *opaque, hwaddr addr, uint64_t val,
+                                        unsigned size, MemTxAttrs attrs)
+{
+    MemTxResult ret = MEMTX_OK;
+
+    addr &= 0xfff;
+    switch (addr) {
+    case MAIL_SEND_OFFSET:
+        ret = mail_send(val, attrs);
+        break;
+    case ANY_SEND_OFFSET:
+        ret = any_send(val, attrs);
+        break;
+    default:
+       break;
+    }
+
+    return ret;
+}
+
+static const MemoryRegionOps loongson_ipi64_ops = {
+    .write_with_attrs = loongson_ipi_writeq,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void loongson_ipi_realize(DeviceState *dev, Error **errp)
+{
+    LoongsonIPI *s = LOONGSON_IPI(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    int i;
+
+    if (s->num_cpu == 0) {
+        error_setg(errp, "num-cpu must be at least 1");
+        return;
+    }
+
+    memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev), &loongson_ipi_ops,
+                          s, "loongson_ipi_iocsr", 0x48);
+
+    /* loongson_ipi_iocsr performs re-entrant IO through ipi_send */
+    s->ipi_iocsr_mem.disable_reentrancy_guard = true;
+
+    sysbus_init_mmio(sbd, &s->ipi_iocsr_mem);
+
+    memory_region_init_io(&s->ipi64_iocsr_mem, OBJECT(dev),
+                          &loongson_ipi64_ops,
+                          s, "loongson_ipi64_iocsr", 0x118);
+    sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
+
+    s->cpu = g_new0(IPICore, s->num_cpu);
+    if (s->cpu == NULL) {
+        error_setg(errp, "Memory allocation for ExtIOICore faile");
+        return;
+    }
+
+    for (i = 0; i < s->num_cpu; i++) {
+        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
+    }
+}
+
+static const VMStateDescription vmstate_ipi_core = {
+    .name = "ipi-single",
+    .version_id = 2,
+    .minimum_version_id = 2,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(status, IPICore),
+        VMSTATE_UINT32(en, IPICore),
+        VMSTATE_UINT32(set, IPICore),
+        VMSTATE_UINT32(clear, IPICore),
+        VMSTATE_UINT32_ARRAY(buf, IPICore, IPI_MBX_NUM * 2),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_loongson_ipi = {
+    .name = TYPE_LOONGSON_IPI,
+    .version_id = 2,
+    .minimum_version_id = 2,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongsonIPI, num_cpu,
+                         vmstate_ipi_core, IPICore),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property ipi_properties[] = {
+    DEFINE_PROP_UINT32("num-cpu", LoongsonIPI, num_cpu, 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void loongson_ipi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = loongson_ipi_realize;
+    device_class_set_props(dc, ipi_properties);
+    dc->vmsd = &vmstate_loongson_ipi;
+}
+
+static void loongson_ipi_finalize(Object *obj)
+{
+    LoongsonIPI *s = LOONGSON_IPI(obj);
+
+    g_free(s->cpu);
+}
+
+static const TypeInfo loongson_ipi_info = {
+    .name          = TYPE_LOONGSON_IPI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(LoongsonIPI),
+    .class_init    = loongson_ipi_class_init,
+    .instance_finalize = loongson_ipi_finalize,
+};
+
+static void loongson_ipi_register_types(void)
+{
+    type_register_static(&loongson_ipi_info);
+}
+
+type_init(loongson_ipi_register_types)
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 58140da5f293..f4b540e6a8b7 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -68,7 +68,7 @@ specific_ss.add(when: 'CONFIG_XIVE', if_true: files('xive.c'))
 specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_XIVE'],
 		if_true: files('spapr_xive_kvm.c'))
 specific_ss.add(when: 'CONFIG_M68K_IRQC', if_true: files('m68k_irqc.c'))
-specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: files('loongarch_ipi.c'))
+specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: files('loongson_ipi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c'))
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index a979784f9bee..b815cea129e2 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -291,9 +291,9 @@ sh_intc_read(unsigned size, uint64_t offset, unsigned long val) "size %u 0x%" PR
 sh_intc_write(unsigned size, uint64_t offset, unsigned long val) "size %u 0x%" PRIx64 " <- 0x%lx"
 sh_intc_set(int id, int enable) "setting interrupt group %d to %d"
 
-# loongarch_ipi.c
-loongarch_ipi_read(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%"PRIx64
-loongarch_ipi_write(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%"PRIx64
+# loongson_ipi.c
+loongson_ipi_read(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%"PRIx64
+loongson_ipi_write(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%"PRIx64
 # loongarch_pch_pic.c
 loongarch_pch_pic_irq_handler(int irq, int level) "irq %d level %d"
 loongarch_pch_pic_low_readw(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%" PRIx64
diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index 5727efed6d84..ccbcde5e55e5 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -8,7 +8,7 @@ config LOONGARCH_VIRT
     select SERIAL
     select VIRTIO_PCI
     select PLATFORM_BUS
-    select LOONGARCH_IPI
+    select LOONGSON_IPI
     select LOONGARCH_PCH_PIC
     select LOONGARCH_PCH_MSI
     select LOONGARCH_EXTIOI
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index c0999878df6a..517929cb1438 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -21,7 +21,7 @@
 #include "net/net.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "hw/intc/loongarch_ipi.h"
+#include "hw/intc/loongson_ipi.h"
 #include "hw/intc/loongarch_extioi.h"
 #include "hw/intc/loongarch_pch_pic.h"
 #include "hw/intc/loongarch_pch_msi.h"
@@ -697,7 +697,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
      */
 
     /* Create IPI device */
-    ipi = qdev_new(TYPE_LOONGARCH_IPI);
+    ipi = qdev_new(TYPE_LOONGSON_IPI);
     qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
 
diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongson_ipi.h
similarity index 84%
rename from include/hw/intc/loongarch_ipi.h
rename to include/hw/intc/loongson_ipi.h
index 1c1e834849e0..2c0e8820f5ec 100644
--- a/include/hw/intc/loongarch_ipi.h
+++ b/include/hw/intc/loongson_ipi.h
@@ -1,12 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * LoongArch ipi interrupt header files
+ * Loongson ipi interrupt header files
  *
  * Copyright (C) 2021 Loongson Technology Corporation Limited
  */
 
-#ifndef HW_LOONGARCH_IPI_H
-#define HW_LOONGARCH_IPI_H
+#ifndef HW_LOONGSON_IPI_H
+#define HW_LOONGSON_IPI_H
 
 #include "hw/sysbus.h"
 
@@ -30,8 +30,8 @@
 
 #define IPI_MBX_NUM           4
 
-#define TYPE_LOONGARCH_IPI "loongarch_ipi"
-OBJECT_DECLARE_SIMPLE_TYPE(LoongArchIPI, LOONGARCH_IPI)
+#define TYPE_LOONGSON_IPI "loongson_ipi"
+OBJECT_DECLARE_SIMPLE_TYPE(LoongsonIPI, LOONGSON_IPI)
 
 typedef struct IPICore {
     uint32_t status;
@@ -43,7 +43,7 @@ typedef struct IPICore {
     qemu_irq irq;
 } IPICore;
 
-struct LoongArchIPI {
+struct LoongsonIPI {
     SysBusDevice parent_obj;
     MemoryRegion ipi_iocsr_mem;
     MemoryRegion ipi64_iocsr_mem;
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 4e14bf6060d0..e1a440a751c8 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -11,7 +11,7 @@
 #include "target/loongarch/cpu.h"
 #include "hw/boards.h"
 #include "qemu/queue.h"
-#include "hw/intc/loongarch_ipi.h"
+#include "hw/intc/loongson_ipi.h"
 #include "hw/block/flash.h"
 #include "hw/loongarch/boot.h"
 

-- 
2.34.1


