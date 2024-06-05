Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DC2C27C54
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 02:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEgBO-00035a-N9; Tue, 04 Jun 2024 22:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sEgBN-00035J-06
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 22:15:21 -0400
Received: from fout1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sEgBG-0001g8-Iy
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 22:15:20 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.nyi.internal (Postfix) with ESMTP id AF3A513800C1;
 Tue,  4 Jun 2024 22:15:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 04 Jun 2024 22:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1717553711;
 x=1717640111; bh=NrIRX9ZsNvroqXd41kE9DGd/VbYBHYm+V1sw+ms+4vY=; b=
 GLuW7rOd/+/vI7icfLK8U65Z+4FD4AbiBsGFHBP40LhouGkkARHaJSytfEENsQu0
 m781/KMfPZ0sYJQXFYeQFrinzjXZFBWzKOhvlpokWDe3kBcDYfimjd/KTNS6bjbD
 d2W9V2YjlBq4Y7P5doOG3dMD1EI8NfFfepboSvL2dPdfoJ86hLkPpSo5ta9IVYoM
 5peo9OvKw7G7OV7Vkodm/IBfDjlDdBO54dZHFUOhbe8g7hcbpWnDxiqZEPho+Dsc
 1rAD20oBtWghcXmeRQay5bzXiejAltTWAE8Pz4zdaltO4KfVG/Xd2F6LlMrLfEZ+
 ++JwCYRAJQlu4jknVZEbAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717553711; x=
 1717640111; bh=NrIRX9ZsNvroqXd41kE9DGd/VbYBHYm+V1sw+ms+4vY=; b=f
 8QBNVy9LcVJXNXit/bX0dmIOnCGcgZiuoyCV0k0rXLCJYKKJRpB3urBmBm2CSVYn
 ilWgyN3x+0e+fplXh4xJQ647E9MyiGH/mKxJN9TlOyaIM8v/X3a08RJLi4JLoljk
 teNSp82YX+W4TxE1E7neP0o9yGTj4/GkhI5WNIEJqnulOnlcd+xTTZX4Q+Hz5GF4
 MiI0+KVdYZlF3wZW6zHhORQfRLW67/7wrLzWV9W485T8okamDFcqFdQnXm/hhAGN
 lJwpbp6yjNhxajADBUUhCoqtNW5l4B4zPaeEMeKjpTxQzcqZ2mnim3ZduChJwA1s
 m3/P8BJZGZVz9gpq6A5/Q==
X-ME-Sender: <xms:L8pfZlDP98o9mQOAIt-JTqA15eUu5ClZhO63zcuLruncMPOGFrIGNQ>
 <xme:L8pfZjhBe9Uv_ERj3-3q8NalPJhMuhE7FnEjhFcfROYP6oWd5L5GohagNd62xjyZq
 H1rKMFdpV0Kdj6aG8I>
X-ME-Received: <xmr:L8pfZgltE0kJukcjII8QtI8AG7dk77kditUtNRxG-E9reklcRYkLgl4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgheeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:L8pfZvzuaigz3LwfbroV7NiBLYM-tIsXnu5-AUcKw5Iz0QoYTFYtSg>
 <xmx:L8pfZqTt0VzAhPDzZCHDD0yboSMMlMwlLl_jw3C8CK5O3r6-SnAH_Q>
 <xmx:L8pfZiYj-uyis-Wac7sm5GIqGWW4KZBGgdPPYgJuXNNKGGkeT0U2_w>
 <xmx:L8pfZrSsum8Ro48PTUw92bZf4iQRNVSPHGMNS3DeZ0p2grCg-CWVpw>
 <xmx:L8pfZnLvW_8PMMOVk9VhF29z-17Tjx59dZCZZ1SeuAX6KEq4tD5oQzsi>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 22:15:10 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 05 Jun 2024 03:15:02 +0100
Subject: [PATCH v3 1/4] hw/intc: Remove loongarch_ipi.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-loongson3-ipi-v3-1-ddd2c0e03fa3@flygoat.com>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
In-Reply-To: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10355;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=P48LUyyEbs6TzN/iodI/WarKZfJ2Iw5hqnbn2oP/Kh8=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrT4U3qayZNZ78/QUGEXszyfky/0bfuSVftvxMSuWaLya
 f3VzKTMjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjI8lmMDEdSr3CrXuJkvmA7
 c4u41ffvpwNn3Pt2Xj5ss6f6qnlHP31h+B9xcdVvie8V8jrnjNI2OH3+q6rg9mDb5KgHn6e4GHd
 5NXMDAA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.144;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

It was missed out in previous commit.

Fixes: b4a12dfc2132 ("hw/intc/loongarch_ipi: Rename as loongson_ipi")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/intc/loongarch_ipi.c | 347 ------------------------------------------------
 1 file changed, 347 deletions(-)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
deleted file mode 100644
index 44b3b9c138d6..000000000000
--- a/hw/intc/loongarch_ipi.c
+++ /dev/null
@@ -1,347 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * LoongArch ipi interrupt support
- *
- * Copyright (C) 2021 Loongson Technology Corporation Limited
- */
-
-#include "qemu/osdep.h"
-#include "hw/boards.h"
-#include "hw/sysbus.h"
-#include "hw/intc/loongarch_ipi.h"
-#include "hw/irq.h"
-#include "hw/qdev-properties.h"
-#include "qapi/error.h"
-#include "qemu/log.h"
-#include "exec/address-spaces.h"
-#include "migration/vmstate.h"
-#include "target/loongarch/cpu.h"
-#include "trace.h"
-
-static MemTxResult loongarch_ipi_readl(void *opaque, hwaddr addr,
-                                       uint64_t *data,
-                                       unsigned size, MemTxAttrs attrs)
-{
-    IPICore *s;
-    LoongArchIPI *ipi = opaque;
-    uint64_t ret = 0;
-    int index = 0;
-
-    s = &ipi->cpu[attrs.requester_id];
-    addr &= 0xff;
-    switch (addr) {
-    case CORE_STATUS_OFF:
-        ret = s->status;
-        break;
-    case CORE_EN_OFF:
-        ret = s->en;
-        break;
-    case CORE_SET_OFF:
-        ret = 0;
-        break;
-    case CORE_CLEAR_OFF:
-        ret = 0;
-        break;
-    case CORE_BUF_20 ... CORE_BUF_38 + 4:
-        index = (addr - CORE_BUF_20) >> 2;
-        ret = s->buf[index];
-        break;
-    default:
-        qemu_log_mask(LOG_UNIMP, "invalid read: %x", (uint32_t)addr);
-        break;
-    }
-
-    trace_loongarch_ipi_read(size, (uint64_t)addr, ret);
-    *data = ret;
-    return MEMTX_OK;
-}
-
-static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr,
-                          MemTxAttrs attrs)
-{
-    int i, mask = 0, data = 0;
-
-    /*
-     * bit 27-30 is mask for byte writing,
-     * if the mask is 0, we need not to do anything.
-     */
-    if ((val >> 27) & 0xf) {
-        data = address_space_ldl(env->address_space_iocsr, addr,
-                                 attrs, NULL);
-        for (i = 0; i < 4; i++) {
-            /* get mask for byte writing */
-            if (val & (0x1 << (27 + i))) {
-                mask |= 0xff << (i * 8);
-            }
-        }
-    }
-
-    data &= mask;
-    data |= (val >> 32) & ~mask;
-    address_space_stl(env->address_space_iocsr, addr,
-                      data, attrs, NULL);
-}
-
-static int archid_cmp(const void *a, const void *b)
-{
-   CPUArchId *archid_a = (CPUArchId *)a;
-   CPUArchId *archid_b = (CPUArchId *)b;
-
-   return archid_a->arch_id - archid_b->arch_id;
-}
-
-static CPUArchId *find_cpu_by_archid(MachineState *ms, uint32_t id)
-{
-    CPUArchId apic_id, *found_cpu;
-
-    apic_id.arch_id = id;
-    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
-        ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
-        archid_cmp);
-
-    return found_cpu;
-}
-
-static CPUState *ipi_getcpu(int arch_id)
-{
-    MachineState *machine = MACHINE(qdev_get_machine());
-    CPUArchId *archid;
-
-    archid = find_cpu_by_archid(machine, arch_id);
-    if (archid) {
-        return CPU(archid->cpu);
-    }
-
-    return NULL;
-}
-
-static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
-{
-    uint32_t cpuid;
-    hwaddr addr;
-    CPUState *cs;
-
-    cpuid = extract32(val, 16, 10);
-    cs = ipi_getcpu(cpuid);
-    if (cs == NULL) {
-        return MEMTX_DECODE_ERROR;
-    }
-
-    /* override requester_id */
-    addr = SMP_IPI_MAILBOX + CORE_BUF_20 + (val & 0x1c);
-    attrs.requester_id = cs->cpu_index;
-    send_ipi_data(&LOONGARCH_CPU(cs)->env, val, addr, attrs);
-    return MEMTX_OK;
-}
-
-static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
-{
-    uint32_t cpuid;
-    hwaddr addr;
-    CPUState *cs;
-
-    cpuid = extract32(val, 16, 10);
-    cs = ipi_getcpu(cpuid);
-    if (cs == NULL) {
-        return MEMTX_DECODE_ERROR;
-    }
-
-    /* override requester_id */
-    addr = val & 0xffff;
-    attrs.requester_id = cs->cpu_index;
-    send_ipi_data(&LOONGARCH_CPU(cs)->env, val, addr, attrs);
-    return MEMTX_OK;
-}
-
-static MemTxResult loongarch_ipi_writel(void *opaque, hwaddr addr, uint64_t val,
-                                        unsigned size, MemTxAttrs attrs)
-{
-    LoongArchIPI *ipi = opaque;
-    IPICore *s;
-    int index = 0;
-    uint32_t cpuid;
-    uint8_t vector;
-    CPUState *cs;
-
-    s = &ipi->cpu[attrs.requester_id];
-    addr &= 0xff;
-    trace_loongarch_ipi_write(size, (uint64_t)addr, val);
-    switch (addr) {
-    case CORE_STATUS_OFF:
-        qemu_log_mask(LOG_GUEST_ERROR, "can not be written");
-        break;
-    case CORE_EN_OFF:
-        s->en = val;
-        break;
-    case CORE_SET_OFF:
-        s->status |= val;
-        if (s->status != 0 && (s->status & s->en) != 0) {
-            qemu_irq_raise(s->irq);
-        }
-        break;
-    case CORE_CLEAR_OFF:
-        s->status &= ~val;
-        if (s->status == 0 && s->en != 0) {
-            qemu_irq_lower(s->irq);
-        }
-        break;
-    case CORE_BUF_20 ... CORE_BUF_38 + 4:
-        index = (addr - CORE_BUF_20) >> 2;
-        s->buf[index] = val;
-        break;
-    case IOCSR_IPI_SEND:
-        cpuid = extract32(val, 16, 10);
-        /* IPI status vector */
-        vector = extract8(val, 0, 5);
-        cs = ipi_getcpu(cpuid);
-        if (cs == NULL) {
-            return MEMTX_DECODE_ERROR;
-        }
-
-        /* override requester_id */
-        attrs.requester_id = cs->cpu_index;
-        loongarch_ipi_writel(ipi, CORE_SET_OFF, BIT(vector), 4, attrs);
-        break;
-    default:
-        qemu_log_mask(LOG_UNIMP, "invalid write: %x", (uint32_t)addr);
-        break;
-    }
-
-    return MEMTX_OK;
-}
-
-static const MemoryRegionOps loongarch_ipi_ops = {
-    .read_with_attrs = loongarch_ipi_readl,
-    .write_with_attrs = loongarch_ipi_writel,
-    .impl.min_access_size = 4,
-    .impl.max_access_size = 4,
-    .valid.min_access_size = 4,
-    .valid.max_access_size = 8,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-/* mail send and any send only support writeq */
-static MemTxResult loongarch_ipi_writeq(void *opaque, hwaddr addr, uint64_t val,
-                                        unsigned size, MemTxAttrs attrs)
-{
-    MemTxResult ret = MEMTX_OK;
-
-    addr &= 0xfff;
-    switch (addr) {
-    case MAIL_SEND_OFFSET:
-        ret = mail_send(val, attrs);
-        break;
-    case ANY_SEND_OFFSET:
-        ret = any_send(val, attrs);
-        break;
-    default:
-       break;
-    }
-
-    return ret;
-}
-
-static const MemoryRegionOps loongarch_ipi64_ops = {
-    .write_with_attrs = loongarch_ipi_writeq,
-    .impl.min_access_size = 8,
-    .impl.max_access_size = 8,
-    .valid.min_access_size = 8,
-    .valid.max_access_size = 8,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
-{
-    LoongArchIPI *s = LOONGARCH_IPI(dev);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    int i;
-
-    if (s->num_cpu == 0) {
-        error_setg(errp, "num-cpu must be at least 1");
-        return;
-    }
-
-    memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev), &loongarch_ipi_ops,
-                          s, "loongarch_ipi_iocsr", 0x48);
-
-    /* loongarch_ipi_iocsr performs re-entrant IO through ipi_send */
-    s->ipi_iocsr_mem.disable_reentrancy_guard = true;
-
-    sysbus_init_mmio(sbd, &s->ipi_iocsr_mem);
-
-    memory_region_init_io(&s->ipi64_iocsr_mem, OBJECT(dev),
-                          &loongarch_ipi64_ops,
-                          s, "loongarch_ipi64_iocsr", 0x118);
-    sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
-
-    s->cpu = g_new0(IPICore, s->num_cpu);
-    if (s->cpu == NULL) {
-        error_setg(errp, "Memory allocation for ExtIOICore faile");
-        return;
-    }
-
-    for (i = 0; i < s->num_cpu; i++) {
-        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
-    }
-}
-
-static const VMStateDescription vmstate_ipi_core = {
-    .name = "ipi-single",
-    .version_id = 2,
-    .minimum_version_id = 2,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(status, IPICore),
-        VMSTATE_UINT32(en, IPICore),
-        VMSTATE_UINT32(set, IPICore),
-        VMSTATE_UINT32(clear, IPICore),
-        VMSTATE_UINT32_ARRAY(buf, IPICore, IPI_MBX_NUM * 2),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static const VMStateDescription vmstate_loongarch_ipi = {
-    .name = TYPE_LOONGARCH_IPI,
-    .version_id = 2,
-    .minimum_version_id = 2,
-    .fields = (const VMStateField[]) {
-        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongArchIPI, num_cpu,
-                         vmstate_ipi_core, IPICore),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static Property ipi_properties[] = {
-    DEFINE_PROP_UINT32("num-cpu", LoongArchIPI, num_cpu, 1),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->realize = loongarch_ipi_realize;
-    device_class_set_props(dc, ipi_properties);
-    dc->vmsd = &vmstate_loongarch_ipi;
-}
-
-static void loongarch_ipi_finalize(Object *obj)
-{
-    LoongArchIPI *s = LOONGARCH_IPI(obj);
-
-    g_free(s->cpu);
-}
-
-static const TypeInfo loongarch_ipi_info = {
-    .name          = TYPE_LOONGARCH_IPI,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(LoongArchIPI),
-    .class_init    = loongarch_ipi_class_init,
-    .instance_finalize = loongarch_ipi_finalize,
-};
-
-static void loongarch_ipi_register_types(void)
-{
-    type_register_static(&loongarch_ipi_info);
-}
-
-type_init(loongarch_ipi_register_types)

-- 
2.43.0


