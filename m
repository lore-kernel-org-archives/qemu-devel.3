Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B72C55174
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsgu0-0006Mv-OJ; Sat, 08 Aug 2026 09:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo-cheng@vip.qq.com>)
 id 1wseg3-0006fr-Qe; Sat, 08 Aug 2026 06:53:20 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo-cheng@vip.qq.com>)
 id 1wsefz-0003NB-SC; Sat, 08 Aug 2026 06:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vip.qq.com;
 s=s201512; t=1786186392;
 bh=tlEDeI9rUIv5/D2oJZ1211STflka7B5LSkBg5t4gP14=;
 h=In-Reply-To:References:Date:Subject:To:Cc:From;
 b=y2LZ2ZmWRNEBPdCzChBQyqMbwEu6znWRUuznU7M4HJACad8+huB48q6h7Qix/7Y8m
 M7aYSmqIClkxcZN4CArvfX0eOUWt8VdzGtgA+8vbpXTKRmbsWPArnKGhF8ATO2wS56
 e9tQ+AUeBDxUiCgJzZ1udIAk2hVPWyPe/hQ5WqsA=
Received: from localhost ([111.52.124.140])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id B6D36C57; Sat, 08 Aug 2026 18:45:45 +0800
X-QQ-mid: xmsmtpt1786185945tqyvf109m
Message-ID: <tencent_3B4BE5CB1802CC14474515C3715E8CF04008@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeFb5oHkEA8MFqQ9CPgzulpIEa0XkoO4U+Xel6yjR2BiF5em2/Em
 YTYPdl0kGzqfR/zjBrZ8yAIAP1G08ujmX5b1wtk5DwQ8G258T7neCtCqJ4zNQcqLTtGjA9gPT/U9
 5A4GPOSYnsa6NWan05SILbVYKkRxr9pg6VeaZzWl8oXE+0xRRJJ/BQC4xIGq59CLzti9Tz0/Hj46
 lwULX8h/eW12wNZguL5L9xpNibRVdHAlzmgjNvWVy7l1WZABwC8pq34xg8a+cZV3GsfyUJ8/hm5d
 tkreUHXQbCPFDTwStoO5p4IoVpx8GnNq6v8WCnDkvAScWpZO2ik4GBkG27cUKm49Z+7xsXFFDtNU
 P8MoWnVtUUY4+Rs9teunJ7o9NQMFM9TrbxPWweBnjvva7rkI4H95BDTOsANpG2m+etLW1bQElf4+
 oGx88lQd1/eIxbJJ53c9G4PegU6oiq75Kz0XaH5llFckLK8EZgYdYNhQB1JGihCHjUe1BZdf20cJ
 Q64Oks7h7N648VSweLS8X1dGlvtXEOzyjFl+6cNknO8ydDT/lfkPPSMdjaZTf8laeuZOieevHn02
 SYDKZHbe25vJeVKdjUfhMvvaHRZUzvrdsmzlnBB4tJsHQZsoUUkymoyXUokOKe6+huwPZGQvBY4F
 oDZqCr5C2GFDoZv30FNc4hvCsQTZzXZyEBr2mSZyjwG/GwyC5UlCYiKtpqmc6FFZoVIbDBgEcjP9
 46iC5Z3xrYpsCeQ0QqLE4JqUoLVvoV+Cx3JG9sUoiVkc5KahSP0FT5LJeBoOD6oWBEicOg0eeGEM
 fxubMJb91bGxuqxs9JD019wZsxn/dJiv98GLYiadAkifhqa7lF53zUfIzT2czYOYSi22oY0PJnpj
 Yj3nV3bJa6AGJrTmOaHWCdP/W/F0WxSQre33D04F4rNX8TM2hyOABCXmvkpeQi/Fu32WvdDMoCF6
 AnpawCuzV8qyz9mHkZBn692Vcgd/QP9WYh63CNhGtqO6EJOvuKBDzPuy5fkQi7EjScT1yWwKH9iQ
 HaHG3Tl3fm8uaxElwpxY8vWCYkCXWXwUiNexKadjAcMPaHa8LHe3FRJ/d7nYNmQiiY/CuYqd5BBW
 EKN96F3b3Cb/gvv3b04Cs2uthQ9UBudFWcSvk8
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-OQ-MSGID: <224c17025d3872a61036afb4639154ee644c2c93.1786185889.git.chengkelfan@qq.com>
In-Reply-To: <cover.1786185889.git.chengkelfan@qq.com>
References: <cover.1786185889.git.chengkelfan@qq.com>
Date: Sat, 8 Aug 2026 18:44:24 +0800
Subject: [PATCH 2/5] hw/rtc: add K230 RTC.
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
From: Leo Cheng <leo-cheng@vip.qq.com>
Received-SPF: pass client-ip=43.163.128.48; envelope-from=leo-cheng@vip.qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 08 Aug 2026 09:15:40 -0400
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

Model the K230 RTC: date/time keeping with leap-year carry, write protection, a masked comparator alarm, a TICK_EN periodic tick interrupt, and a live sub-second COUNT derived from virtual time. The alarm is re-evaluated on TIME/ALARM/INT_CTRL writes and the year comparison ignores the DATE leap flag. Register layout from the K230 TRM v0.3.1. Covered by tests/qtest/k230-rtc-test.

Signed-off-by: Leo Cheng <leo-cheng@vip.qq.com>
---
 hw/rtc/Kconfig              |   3 +
 hw/rtc/k230_rtc.c           | 306 ++++++++++++++++++++++++++++++++++++
 hw/rtc/meson.build          |   1 +
 hw/rtc/trace-events         |   5 +
 include/hw/rtc/k230_rtc.h   |  61 +++++++
 tests/qtest/k230-rtc-test.c | 188 ++++++++++++++++++++++
 6 files changed, 564 insertions(+)
 create mode 100644 hw/rtc/k230_rtc.c
 create mode 100644 include/hw/rtc/k230_rtc.h
 create mode 100644 tests/qtest/k230-rtc-test.c

diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
index 315b0e4..d764807 100644
--- a/hw/rtc/Kconfig
+++ b/hw/rtc/Kconfig
@@ -31,3 +31,6 @@ config RS5C372_RTC
     bool
     depends on I2C
     default y if I2C_DEVICES
+
+config K230_RTC
+    bool
diff --git a/hw/rtc/k230_rtc.c b/hw/rtc/k230_rtc.c
new file mode 100644
index 0000000..c1de83d
--- /dev/null
+++ b/hw/rtc/k230_rtc.c
@@ -0,0 +1,306 @@
+/*
+ * K230 RTC compatible with Kendryte K230 SDK
+ *
+ * Copyright (c) 2026 Leo Cheng <chengkelfan@qq.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * For more information, see <https://www.kendryte.com/en/proDetail/230>
+ */
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "hw/core/irq.h"
+#include "migration/vmstate.h"
+#include "hw/rtc/k230_rtc.h"
+#include "trace.h"
+
+static bool k230_rtc_is_leap(uint32_t year)
+{
+    return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
+}
+
+static void k230_rtc_advance(K230RtcState *s)
+{
+    uint32_t sec = extract32(s->time, 0, 6);
+    uint32_t min = extract32(s->time, 8, 6);
+    uint32_t hour = extract32(s->time, 16, 5);
+    uint32_t week = extract32(s->time, 24, 3);
+    uint32_t day = extract32(s->date, 0, 5);
+    uint32_t month = extract32(s->date, 8, 4);
+    uint32_t year_l = extract32(s->date, 16, 7);
+    uint32_t year_h = extract32(s->date, 24, 7);
+    static const uint8_t dim[12] = {31, 28, 31, 30, 31, 30,
+                                    31, 31, 30, 31, 30, 31};
+
+    if (++sec >= 60) {
+        sec = 0;
+        if (++min >= 60) {
+            min = 0;
+            if (++hour >= 24) {
+                uint32_t year = year_h * 100 + year_l;
+                uint32_t maxd = month >= 1 && month <= 12 ? dim[month - 1] : 31;
+
+                hour = 0;
+                week = (week + 1) % 7;
+                if (month == 2 && k230_rtc_is_leap(year)) {
+                    maxd = 29;
+                }
+                if (++day > maxd) {
+                    day = 1;
+                    if (++month > 12) {
+                        month = 1;
+                        if (++year_l >= 100) {
+                            year_l = 0;
+                            year_h++;
+                        }
+                    }
+                }
+            }
+        }
+    }
+
+    s->time = deposit32(deposit32(deposit32(deposit32(0, 0, 6, sec),
+                        8, 6, min), 16, 5, hour), 24, 3, week);
+    s->date = deposit32(deposit32(deposit32(deposit32(deposit32(0, 0, 5, day),
+                        8, 4, month), 16, 7, year_l), 24, 7, year_h),
+                        23, 1, k230_rtc_is_leap(year_h * 100 + year_l));
+}
+
+static void k230_rtc_update_irq(K230RtcState *s)
+{
+    qemu_set_irq(s->irq, s->alarm_pending || s->tick_pending);
+}
+
+static void k230_rtc_check_alarm(K230RtcState *s)
+{
+    uint32_t cmp = extract32(s->int_ctrl, K230_RTC_CMP_SHIFT, 7);
+    bool match = true;
+
+    if (!(s->int_ctrl & K230_RTC_ALARM_EN) || cmp == 0) {
+        return;
+    }
+
+    if (cmp & BIT(0)) { /* second */
+        match &= extract32(s->time, 0, 6) == extract32(s->alarm_time, 0, 6);
+    }
+    if (cmp & BIT(1)) { /* minute */
+        match &= extract32(s->time, 8, 6) == extract32(s->alarm_time, 8, 6);
+    }
+    if (cmp & BIT(2)) { /* hour */
+        match &= extract32(s->time, 16, 5) == extract32(s->alarm_time, 16, 5);
+    }
+    if (cmp & BIT(3)) { /* weekday */
+        match &= extract32(s->time, 24, 3) == extract32(s->alarm_time, 24, 3);
+    }
+    if (cmp & BIT(4)) { /* day */
+        match &= extract32(s->date, 0, 5) == extract32(s->alarm_date, 0, 5);
+    }
+    if (cmp & BIT(5)) { /* month */
+        match &= extract32(s->date, 8, 4) == extract32(s->alarm_date, 8, 4);
+    }
+    if (cmp & BIT(6)) { /* year: skip leap flag at bit 23 */
+        match &= extract32(s->date, 16, 7) == extract32(s->alarm_date, 16, 7) &&
+                 extract32(s->date, 24, 7) == extract32(s->alarm_date, 24, 7);
+    }
+
+    if (match) {
+        s->alarm_pending = true;
+        k230_rtc_update_irq(s);
+        trace_k230_rtc_alarm();
+    }
+}
+
+static void k230_rtc_tick(void *opaque)
+{
+    K230RtcState *s = K230_RTC(opaque);
+
+    s->last_tick_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    k230_rtc_advance(s);
+    if (s->int_ctrl & K230_RTC_TICK_EN) {
+        s->tick_pending = true;
+    }
+    k230_rtc_check_alarm(s);
+    k230_rtc_update_irq(s);
+    timer_mod(s->timer, s->last_tick_ns + NANOSECONDS_PER_SECOND);
+}
+
+static uint64_t k230_rtc_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    K230RtcState *s = K230_RTC(opaque);
+    uint32_t value = 0;
+
+    switch (addr) {
+    case K230_RTC_DATE:
+        value = s->date;
+        break;
+    case K230_RTC_TIME:
+        value = s->time;
+        break;
+    case K230_RTC_ALARM_DATE:
+        value = s->alarm_date;
+        break;
+    case K230_RTC_ALARM_TIME:
+        value = s->alarm_time;
+        break;
+    case K230_RTC_COUNT: {
+        uint32_t sum = extract32(s->count, 16, 16);
+        int64_t elapsed = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
+                          s->last_tick_ns;
+        uint64_t curr = 0;
+
+        if (elapsed > 0) {
+            curr = (uint64_t)elapsed * (sum + 1) / NANOSECONDS_PER_SECOND;
+        }
+        if (curr > sum) {
+            curr = sum;
+        }
+        value = (sum << 16) | (uint32_t)curr;
+        break;
+    }
+    case K230_RTC_INT_CTRL:
+        value = s->int_ctrl;
+        break;
+    default:
+        break;
+    }
+
+    trace_k230_rtc_read(addr, value);
+    return value;
+}
+
+static void k230_rtc_write(void *opaque, hwaddr addr,
+                           uint64_t value, unsigned int size)
+{
+    K230RtcState *s = K230_RTC(opaque);
+    bool w_en = s->int_ctrl & K230_RTC_TIMER_W_EN;
+
+    trace_k230_rtc_write(addr, value);
+
+    switch (addr) {
+    case K230_RTC_DATE:
+        if (w_en) {
+            s->date = value;
+            k230_rtc_check_alarm(s);
+        }
+        break;
+    case K230_RTC_TIME:
+        if (w_en) {
+            s->time = value;
+            k230_rtc_check_alarm(s);
+        }
+        break;
+    case K230_RTC_ALARM_DATE:
+        s->alarm_date = value;
+        k230_rtc_check_alarm(s);
+        break;
+    case K230_RTC_ALARM_TIME:
+        s->alarm_time = value;
+        k230_rtc_check_alarm(s);
+        break;
+    case K230_RTC_COUNT:
+        if (w_en) {
+            s->count = value;
+            s->last_tick_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        }
+        break;
+    case K230_RTC_INT_CTRL:
+        if (value & K230_RTC_ALARM_CLR) {
+            s->alarm_pending = false;
+            s->tick_pending = false;
+            value &= ~K230_RTC_ALARM_CLR;
+        }
+        s->int_ctrl = value;
+        k230_rtc_check_alarm(s);
+        k230_rtc_update_irq(s);
+        break;
+    default:
+        break;
+    }
+}
+
+static const MemoryRegionOps k230_rtc_ops = {
+    .read = k230_rtc_read,
+    .write = k230_rtc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void k230_rtc_reset(DeviceState *dev)
+{
+    K230RtcState *s = K230_RTC(dev);
+
+    s->date = 0;
+    s->time = 0;
+    s->alarm_date = 0;
+    s->alarm_time = 0;
+    s->count = 32767u << 16;
+    s->int_ctrl = 0;
+    s->alarm_pending = false;
+    s->tick_pending = false;
+    s->last_tick_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    qemu_set_irq(s->irq, 0);
+
+    timer_mod(s->timer, s->last_tick_ns + NANOSECONDS_PER_SECOND);
+}
+
+static const VMStateDescription vmstate_k230_rtc = {
+    .name = "k230.rtc",
+    .fields = (const VMStateField[]) {
+        VMSTATE_TIMER_PTR(timer, K230RtcState),
+        VMSTATE_UINT32(date, K230RtcState),
+        VMSTATE_UINT32(time, K230RtcState),
+        VMSTATE_UINT32(alarm_date, K230RtcState),
+        VMSTATE_UINT32(alarm_time, K230RtcState),
+        VMSTATE_UINT32(count, K230RtcState),
+        VMSTATE_UINT32(int_ctrl, K230RtcState),
+        VMSTATE_INT64(last_tick_ns, K230RtcState),
+        VMSTATE_BOOL(alarm_pending, K230RtcState),
+        VMSTATE_BOOL(tick_pending, K230RtcState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void k230_rtc_realize(DeviceState *dev, Error **errp)
+{
+    K230RtcState *s = K230_RTC(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->mmio, OBJECT(dev), &k230_rtc_ops, s,
+                          TYPE_K230_RTC, K230_RTC_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &s->mmio);
+    sysbus_init_irq(sbd, &s->irq);
+
+    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, k230_rtc_tick, s);
+}
+
+static void k230_rtc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = k230_rtc_realize;
+    device_class_set_legacy_reset(dc, k230_rtc_reset);
+    dc->vmsd = &vmstate_k230_rtc;
+    dc->desc = "K230 RTC";
+}
+
+static const TypeInfo k230_rtc_info = {
+    .name          = TYPE_K230_RTC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(K230RtcState),
+    .class_init    = k230_rtc_class_init,
+};
+
+static void k230_rtc_register_type(void)
+{
+    type_register_static(&k230_rtc_info);
+}
+type_init(k230_rtc_register_type)
diff --git a/hw/rtc/meson.build b/hw/rtc/meson.build
index 6c87864..3f3529c 100644
--- a/hw/rtc/meson.build
+++ b/hw/rtc/meson.build
@@ -14,3 +14,4 @@ system_ss.add(when: 'CONFIG_LS7A_RTC', if_true: files('ls7a_rtc.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-rtc.c'))
 system_ss.add(when: 'CONFIG_MC146818RTC', if_true: files('mc146818rtc.c'))
 system_ss.add(when: 'CONFIG_RS5C372_RTC', if_true: files('rs5c372.c'))
+system_ss.add(when: 'CONFIG_K230_RTC', if_true: files('k230_rtc.c'))
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
index d2f3621..beee3b1 100644
--- a/hw/rtc/trace-events
+++ b/hw/rtc/trace-events
@@ -43,3 +43,8 @@ goldfish_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x
 # rs5c372.c
 rs5c372_recv(uint32_t addr, uint8_t value) "[0x%" PRIx32 "] -> 0x%02" PRIx8
 rs5c372_send(uint32_t addr, uint8_t value) "[0x%" PRIx32 "] <- 0x%02" PRIx8
+
+# k230_rtc.c
+k230_rtc_read(uint64_t addr, uint32_t data) "K230 RTC read: [0x%" PRIx64 "] -> 0x%" PRIx32
+k230_rtc_write(uint64_t addr, uint64_t data) "K230 RTC write: [0x%" PRIx64 "] <- 0x%" PRIx64
+k230_rtc_alarm(void) "K230 RTC alarm"
diff --git a/include/hw/rtc/k230_rtc.h b/include/hw/rtc/k230_rtc.h
new file mode 100644
index 0000000..678ee37
--- /dev/null
+++ b/include/hw/rtc/k230_rtc.h
@@ -0,0 +1,61 @@
+/*
+ * K230 RTC compatible with Kendryte K230 SDK
+ *
+ * Copyright (c) 2026 Leo Cheng <chengkelfan@qq.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * For more information, see <https://www.kendryte.com/en/proDetail/230>
+ */
+#ifndef HW_RTC_K230_RTC_H
+#define HW_RTC_K230_RTC_H
+
+#include "hw/core/sysbus.h"
+#include "qemu/timer.h"
+#include "qom/object.h"
+
+#define TYPE_K230_RTC "riscv.k230.rtc"
+OBJECT_DECLARE_SIMPLE_TYPE(K230RtcState, K230_RTC)
+
+#define K230_RTC_MMIO_SIZE 0x400
+
+enum {
+    K230_RTC_DATE       = 0x00,
+    K230_RTC_TIME       = 0x04,
+    K230_RTC_ALARM_DATE = 0x08,
+    K230_RTC_ALARM_TIME = 0x0c,
+    K230_RTC_COUNT      = 0x10,
+    K230_RTC_INT_CTRL   = 0x14,
+};
+
+/* INT_CTRL bits */
+#define K230_RTC_TIMER_W_EN (1u << 0)
+#define K230_RTC_TIMER_R_EN (1u << 1)
+#define K230_RTC_TICK_EN    (1u << 8)
+#define K230_RTC_ALARM_EN   (1u << 16)
+#define K230_RTC_ALARM_CLR  (1u << 17)
+#define K230_RTC_CMP_SHIFT  24
+#define K230_RTC_CMP_SECOND (1u << 24)
+
+struct K230RtcState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    qemu_irq irq;
+    QEMUTimer *timer;
+
+    uint32_t date;
+    uint32_t time;
+    uint32_t alarm_date;
+    uint32_t alarm_time;
+    uint32_t count;
+    uint32_t int_ctrl;
+    int64_t last_tick_ns;
+    bool alarm_pending;
+    bool tick_pending;
+};
+
+#endif
diff --git a/tests/qtest/k230-rtc-test.c b/tests/qtest/k230-rtc-test.c
new file mode 100644
index 0000000..081f21d
--- /dev/null
+++ b/tests/qtest/k230-rtc-test.c
@@ -0,0 +1,188 @@
+/*
+ * QTest testcase for K230 RTC
+ *
+ * Copyright (c) 2026 Leo Cheng <chengkelfan@qq.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "libqtest.h"
+#include "hw/rtc/k230_rtc.h"
+
+#define RTC_BASE 0x91000C00
+
+#define PLIC_BASE    0xF00000000ULL
+#define PLIC_PENDING (PLIC_BASE + 0x1000)
+#define RTC_IRQ      175
+
+static bool plic_pending(QTestState *qts, int irq)
+{
+    uint32_t word = qtest_readl(qts, PLIC_PENDING + (irq / 32) * 4);
+    return (word >> (irq % 32)) & 1;
+}
+
+static void test_reset_values(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + K230_RTC_INT_CTRL), ==, 0);
+
+    qtest_quit(qts);
+}
+
+/* Write-protect: date/time writes need timer_w_en */
+static void test_write_protect(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* Protected: with w_en clear, writes are ignored */
+    qtest_writel(qts, RTC_BASE + K230_RTC_INT_CTRL, 0);
+    qtest_writel(qts, RTC_BASE + K230_RTC_TIME, 0x0A);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + K230_RTC_TIME), ==, 0);
+
+    /* Unlocked: enable then write date + time, read back */
+    qtest_writel(qts, RTC_BASE + K230_RTC_INT_CTRL, K230_RTC_TIMER_W_EN);
+    qtest_writel(qts, RTC_BASE + K230_RTC_DATE, (6 << 8) | 15);  /* Jun 15 */
+    qtest_writel(qts, RTC_BASE + K230_RTC_TIME,
+                 (12 << 16) | (30 << 8) | 45);  /* 12:30:45 */
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + K230_RTC_DATE), ==,
+                    (6 << 8) | 15);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + K230_RTC_TIME), ==,
+                    (12 << 16) | (30 << 8) | 45);
+
+    qtest_quit(qts);
+}
+
+/* One virtual second advances TIME.second */
+static void test_tick(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, RTC_BASE + K230_RTC_INT_CTRL, K230_RTC_TIMER_W_EN);
+    qtest_writel(qts, RTC_BASE + K230_RTC_TIME, 10);  /* second = 10 */
+
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND);
+    g_assert_cmpuint(qtest_readl(qts, RTC_BASE + K230_RTC_TIME) & 0x3F, ==, 11);
+
+    qtest_quit(qts);
+}
+
+/* Masked second alarm raises the RTC interrupt; cleared by alarm_clr */
+static void test_alarm(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, RTC_BASE + K230_RTC_INT_CTRL, K230_RTC_TIMER_W_EN);
+    qtest_writel(qts, RTC_BASE + K230_RTC_TIME, 10);
+    qtest_writel(qts, RTC_BASE + K230_RTC_ALARM_TIME, 11);
+    qtest_writel(qts, RTC_BASE + K230_RTC_INT_CTRL,
+                 K230_RTC_ALARM_EN | K230_RTC_CMP_SECOND);
+
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND);
+    g_assert_true(plic_pending(qts, RTC_IRQ));
+
+    /*
+     * alarm_clr is write-1 self-clearing and lowers the RTC IRQ line; the
+     * PLIC pending bit is sticky until claimed, so verify the ack bit here.
+     */
+    qtest_writel(qts, RTC_BASE + K230_RTC_INT_CTRL,
+                 K230_RTC_ALARM_EN | K230_RTC_CMP_SECOND | K230_RTC_ALARM_CLR);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + K230_RTC_INT_CTRL), ==,
+                    K230_RTC_ALARM_EN | K230_RTC_CMP_SECOND);
+
+    qtest_quit(qts);
+}
+
+/* COUNT sub-second field advances with virtual time within the second */
+static void test_count_live(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    uint32_t count;
+
+    /* half a second in -> curr = (sum+1)/2, sum field unchanged */
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND / 2);
+    count = qtest_readl(qts, RTC_BASE + K230_RTC_COUNT);
+    g_assert_cmpuint(count >> 16, ==, 32767);
+    g_assert_cmpuint(count & 0xFFFF, ==, 16384);
+
+    qtest_quit(qts);
+}
+
+/* TICK_EN turns the 1 Hz advance into a periodic interrupt; gated by TICK_EN */
+static void test_tick_irq(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* No TICK_EN: a tick advances time but raises no interrupt */
+    qtest_writel(qts, RTC_BASE + K230_RTC_INT_CTRL, K230_RTC_TIMER_W_EN);
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND);
+    g_assert_false(plic_pending(qts, RTC_IRQ));
+
+    /* TICK_EN set: the next tick raises the shared RTC interrupt */
+    qtest_writel(qts, RTC_BASE + K230_RTC_INT_CTRL,
+                 K230_RTC_TIMER_W_EN | K230_RTC_TICK_EN);
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND);
+    g_assert_true(plic_pending(qts, RTC_IRQ));
+
+    qtest_quit(qts);
+}
+
+/* Enabling an alarm whose time already matches fires without waiting a tick */
+static void test_alarm_immediate(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, RTC_BASE + K230_RTC_INT_CTRL, K230_RTC_TIMER_W_EN);
+    qtest_writel(qts, RTC_BASE + K230_RTC_TIME, 10);
+    qtest_writel(qts, RTC_BASE + K230_RTC_ALARM_TIME, 10);
+
+    /* enable while already matching -> immediate, no clock step */
+    qtest_writel(qts, RTC_BASE + K230_RTC_INT_CTRL,
+                 K230_RTC_TIMER_W_EN | K230_RTC_ALARM_EN | K230_RTC_CMP_SECOND);
+    g_assert_true(plic_pending(qts, RTC_IRQ));
+
+    qtest_quit(qts);
+}
+
+/*
+ * Year alarm must match in a leap year: advance() sets a leap flag at DATE
+ * bit 23, which must not contaminate the year comparison.
+ */
+static void test_alarm_year_leap(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    uint32_t date2024 = (20u << 24) | (24u << 16) | (6u << 8) | 15u; /* 2024 */
+
+    qtest_writel(qts, RTC_BASE + K230_RTC_INT_CTRL, K230_RTC_TIMER_W_EN);
+    qtest_writel(qts, RTC_BASE + K230_RTC_DATE, date2024);
+    /* one tick makes advance() set the leap flag (bit 23) in DATE */
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND);
+
+    qtest_writel(qts, RTC_BASE + K230_RTC_INT_CTRL,
+                 K230_RTC_TIMER_W_EN | K230_RTC_ALARM_EN |
+                 ((1u << 6) << K230_RTC_CMP_SHIFT));  /* year compare */
+    g_assert_false(plic_pending(qts, RTC_IRQ));       /* alarm_date still 0 */
+
+    qtest_writel(qts, RTC_BASE + K230_RTC_ALARM_DATE,
+                 (20u << 24) | (24u << 16));
+    g_assert_true(plic_pending(qts, RTC_IRQ));  /* matches despite leap flag */
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-rtc/reset_values", test_reset_values);
+    qtest_add_func("/k230-rtc/write_protect", test_write_protect);
+    qtest_add_func("/k230-rtc/tick", test_tick);
+    qtest_add_func("/k230-rtc/alarm", test_alarm);
+    qtest_add_func("/k230-rtc/count_live", test_count_live);
+    qtest_add_func("/k230-rtc/tick_irq", test_tick_irq);
+    qtest_add_func("/k230-rtc/alarm_immediate", test_alarm_immediate);
+    qtest_add_func("/k230-rtc/alarm_year_leap", test_alarm_year_leap);
+
+    return g_test_run();
+}
-- 
2.43.0


