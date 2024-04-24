Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC18C07E8E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 14:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzdOP-0001bR-6S; Wed, 24 Apr 2024 10:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzdON-0001Zf-C0
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 10:14:35 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzdOL-0007sG-6T
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 10:14:34 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41af6701806so7359035e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 07:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713968071; x=1714572871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qijCCGhiBXvnAFegZTfMZai02eDoT4yIJJgv6b7crGw=;
 b=lemOaSqyCRVmW963g+5DG0SBYDROI0GO3ZHiWfOLTiSYRTKPPe+Up/vrO7dGBVcCNS
 5og7IAirmvLwjRFvkNJB+geYES5UQoMJR28TYI9cZ5NlAqO/nByGU4yewZGL8teIukg3
 QR9rLglQVElgd2OWP36foAAOESTdDLN29PKY0+NbnP/4ybp4FofHGDyDYLZFbtFD5h3o
 OLl/Uw15geQPvfs13gE06WASpIqTNTzxv8EvRv1dS1zIWtv8nkElA56NQKckrsbF1Kmv
 oinLjOGjiS0wioBNE40W4w0PyMptCFGX9EskVFTGJgQNMBDc7lU09A9o8LUFJjV3N2Kw
 7JDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713968071; x=1714572871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qijCCGhiBXvnAFegZTfMZai02eDoT4yIJJgv6b7crGw=;
 b=TseO8AFlvkN+w7ksS/yU19yMquNMdDsYrYUTNuvg+mDDDCwEvI+RmRdFhWGLynnZT4
 fedFiPmho5hbPxXfWAL85OFjG3Aqvgjg+YgQQvhbMLKJ/tqow6TrTNnGIieZ9GJZj3QD
 I3p0M0fu+VV66ctEN/H5P4FMkuWfEYBMIZqNekHb6amLzdC/6qbqq1YKguYa5Db1/Vz0
 17XS6CpQcADK71rdFJ7j0CFdtJg/4/taw6iB/C2Eg/szmTdUudb5ezis80i64zLUvviM
 XhXu0xZ29v+Xf1IB3iBbgthWMFxeYNrGtW/uKvPwDx+7cl7SEurf09l5WaG1m+WuOcKj
 0JHA==
X-Gm-Message-State: AOJu0YwyzOSUyffQSk3ivr/om9rD/lNLkwpTkFoVtELn4VuybDN1xkHI
 5mtRB3FhawxExc9IFd82V74StzD3nXLJVl76IkF8YvslFsdl2Zn/i3uZnZf74XnvqAhfIoJnYSp
 1I+s=
X-Google-Smtp-Source: AGHT+IGiKAqRPPvSE+LuMoMkT4BUpm2xcCd3JrPZvgjJaELOoDpPVMc8es+a0iOmBX1tjm93IYz61w==
X-Received: by 2002:a05:600c:a005:b0:41a:1d3a:3fc1 with SMTP id
 jg5-20020a05600ca00500b0041a1d3a3fc1mr1950989wmb.3.1713968071200; 
 Wed, 24 Apr 2024 07:14:31 -0700 (PDT)
Received: from localhost.localdomain
 (mon75-h03-176-184-51-42.dsl.sta.abo.bbox.fr. [176.184.51.42])
 by smtp.gmail.com with ESMTPSA id
 fc19-20020a05600c525300b00418981b59d4sm27900969wmb.10.2024.04.24.07.14.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Apr 2024 07:14:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 3/5] hw/timer: Remove the ALTERA_TIMER model
Date: Wed, 24 Apr 2024 16:14:05 +0200
Message-ID: <20240424141408.87779-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240424141408.87779-1-philmd@linaro.org>
References: <20240424141408.87779-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

The ALTERA_TIMER was only used by Nios II machines,
which have been removed. Since it has no direct user,
remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240327144806.11319-4-philmd@linaro.org>
---
 hw/timer/altera_timer.c | 244 ----------------------------------------
 hw/timer/Kconfig        |   4 -
 hw/timer/meson.build    |   1 -
 3 files changed, 249 deletions(-)
 delete mode 100644 hw/timer/altera_timer.c

diff --git a/hw/timer/altera_timer.c b/hw/timer/altera_timer.c
deleted file mode 100644
index 0f1f54206a..0000000000
--- a/hw/timer/altera_timer.c
+++ /dev/null
@@ -1,244 +0,0 @@
-/*
- * QEMU model of the Altera timer.
- *
- * Copyright (c) 2012 Chris Wulff <crwulff@gmail.com>
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see
- * <http://www.gnu.org/licenses/lgpl-2.1.html>
- */
-
-#include "qemu/osdep.h"
-#include "qemu/module.h"
-#include "qapi/error.h"
-
-#include "hw/sysbus.h"
-#include "hw/irq.h"
-#include "hw/ptimer.h"
-#include "hw/qdev-properties.h"
-#include "qom/object.h"
-
-#define R_STATUS      0
-#define R_CONTROL     1
-#define R_PERIODL     2
-#define R_PERIODH     3
-#define R_SNAPL       4
-#define R_SNAPH       5
-#define R_MAX         6
-
-#define STATUS_TO     0x0001
-#define STATUS_RUN    0x0002
-
-#define CONTROL_ITO   0x0001
-#define CONTROL_CONT  0x0002
-#define CONTROL_START 0x0004
-#define CONTROL_STOP  0x0008
-
-#define TYPE_ALTERA_TIMER "ALTR.timer"
-OBJECT_DECLARE_SIMPLE_TYPE(AlteraTimer, ALTERA_TIMER)
-
-struct AlteraTimer {
-    SysBusDevice  busdev;
-    MemoryRegion  mmio;
-    qemu_irq      irq;
-    uint32_t      freq_hz;
-    ptimer_state *ptimer;
-    uint32_t      regs[R_MAX];
-};
-
-static int timer_irq_state(AlteraTimer *t)
-{
-    bool irq = (t->regs[R_STATUS] & STATUS_TO) &&
-               (t->regs[R_CONTROL] & CONTROL_ITO);
-    return irq;
-}
-
-static uint64_t timer_read(void *opaque, hwaddr addr,
-                           unsigned int size)
-{
-    AlteraTimer *t = opaque;
-    uint64_t r = 0;
-
-    addr >>= 2;
-
-    switch (addr) {
-    case R_CONTROL:
-        r = t->regs[R_CONTROL] & (CONTROL_ITO | CONTROL_CONT);
-        break;
-
-    default:
-        if (addr < ARRAY_SIZE(t->regs)) {
-            r = t->regs[addr];
-        }
-        break;
-    }
-
-    return r;
-}
-
-static void timer_write(void *opaque, hwaddr addr,
-                        uint64_t value, unsigned int size)
-{
-    AlteraTimer *t = opaque;
-    uint64_t tvalue;
-    uint32_t count = 0;
-    int irqState = timer_irq_state(t);
-
-    addr >>= 2;
-
-    switch (addr) {
-    case R_STATUS:
-        /* The timeout bit is cleared by writing the status register. */
-        t->regs[R_STATUS] &= ~STATUS_TO;
-        break;
-
-    case R_CONTROL:
-        ptimer_transaction_begin(t->ptimer);
-        t->regs[R_CONTROL] = value & (CONTROL_ITO | CONTROL_CONT);
-        if ((value & CONTROL_START) &&
-            !(t->regs[R_STATUS] & STATUS_RUN)) {
-            ptimer_run(t->ptimer, 1);
-            t->regs[R_STATUS] |= STATUS_RUN;
-        }
-        if ((value & CONTROL_STOP) && (t->regs[R_STATUS] & STATUS_RUN)) {
-            ptimer_stop(t->ptimer);
-            t->regs[R_STATUS] &= ~STATUS_RUN;
-        }
-        ptimer_transaction_commit(t->ptimer);
-        break;
-
-    case R_PERIODL:
-    case R_PERIODH:
-        ptimer_transaction_begin(t->ptimer);
-        t->regs[addr] = value & 0xFFFF;
-        if (t->regs[R_STATUS] & STATUS_RUN) {
-            ptimer_stop(t->ptimer);
-            t->regs[R_STATUS] &= ~STATUS_RUN;
-        }
-        tvalue = (t->regs[R_PERIODH] << 16) | t->regs[R_PERIODL];
-        ptimer_set_limit(t->ptimer, tvalue + 1, 1);
-        ptimer_transaction_commit(t->ptimer);
-        break;
-
-    case R_SNAPL:
-    case R_SNAPH:
-        count = ptimer_get_count(t->ptimer);
-        t->regs[R_SNAPL] = count & 0xFFFF;
-        t->regs[R_SNAPH] = count >> 16;
-        break;
-
-    default:
-        break;
-    }
-
-    if (irqState != timer_irq_state(t)) {
-        qemu_set_irq(t->irq, timer_irq_state(t));
-    }
-}
-
-static const MemoryRegionOps timer_ops = {
-    .read = timer_read,
-    .write = timer_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 4
-    }
-};
-
-static void timer_hit(void *opaque)
-{
-    AlteraTimer *t = opaque;
-    const uint64_t tvalue = (t->regs[R_PERIODH] << 16) | t->regs[R_PERIODL];
-
-    t->regs[R_STATUS] |= STATUS_TO;
-
-    ptimer_set_limit(t->ptimer, tvalue + 1, 1);
-
-    if (!(t->regs[R_CONTROL] & CONTROL_CONT)) {
-        t->regs[R_STATUS] &= ~STATUS_RUN;
-        ptimer_set_count(t->ptimer, tvalue);
-    } else {
-        ptimer_run(t->ptimer, 1);
-    }
-
-    qemu_set_irq(t->irq, timer_irq_state(t));
-}
-
-static void altera_timer_realize(DeviceState *dev, Error **errp)
-{
-    AlteraTimer *t = ALTERA_TIMER(dev);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-
-    if (t->freq_hz == 0) {
-        error_setg(errp, "\"clock-frequency\" property must be provided.");
-        return;
-    }
-
-    t->ptimer = ptimer_init(timer_hit, t, PTIMER_POLICY_LEGACY);
-    ptimer_transaction_begin(t->ptimer);
-    ptimer_set_freq(t->ptimer, t->freq_hz);
-    ptimer_transaction_commit(t->ptimer);
-
-    memory_region_init_io(&t->mmio, OBJECT(t), &timer_ops, t,
-                          TYPE_ALTERA_TIMER, R_MAX * sizeof(uint32_t));
-    sysbus_init_mmio(sbd, &t->mmio);
-}
-
-static void altera_timer_init(Object *obj)
-{
-    AlteraTimer *t = ALTERA_TIMER(obj);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-
-    sysbus_init_irq(sbd, &t->irq);
-}
-
-static void altera_timer_reset(DeviceState *dev)
-{
-    AlteraTimer *t = ALTERA_TIMER(dev);
-
-    ptimer_transaction_begin(t->ptimer);
-    ptimer_stop(t->ptimer);
-    ptimer_set_limit(t->ptimer, 0xffffffff, 1);
-    ptimer_transaction_commit(t->ptimer);
-    memset(t->regs, 0, sizeof(t->regs));
-}
-
-static Property altera_timer_properties[] = {
-    DEFINE_PROP_UINT32("clock-frequency", AlteraTimer, freq_hz, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void altera_timer_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->realize = altera_timer_realize;
-    device_class_set_props(dc, altera_timer_properties);
-    dc->reset = altera_timer_reset;
-}
-
-static const TypeInfo altera_timer_info = {
-    .name          = TYPE_ALTERA_TIMER,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(AlteraTimer),
-    .instance_init = altera_timer_init,
-    .class_init    = altera_timer_class_init,
-};
-
-static void altera_timer_register(void)
-{
-    type_register_static(&altera_timer_info);
-}
-
-type_init(altera_timer_register)
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index 010be7ed1f..61fbb62b65 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -17,10 +17,6 @@ config I8254
     bool
     depends on ISA_BUS
 
-config ALTERA_TIMER
-    bool
-    select PTIMER
-
 config ALLWINNER_A10_PIT
     bool
     select PTIMER
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index fc632ad445..80427852e0 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -1,6 +1,5 @@
 system_ss.add(when: 'CONFIG_A9_GTIMER', if_true: files('a9gtimer.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_A10_PIT', if_true: files('allwinner-a10-pit.c'))
-system_ss.add(when: 'CONFIG_ALTERA_TIMER', if_true: files('altera_timer.c'))
 system_ss.add(when: 'CONFIG_ARM_MPTIMER', if_true: files('arm_mptimer.c'))
 system_ss.add(when: 'CONFIG_ARM_TIMER', if_true: files('arm_timer.c'))
 system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_systick.c'))
-- 
2.41.0


