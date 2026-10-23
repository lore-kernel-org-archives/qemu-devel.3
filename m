Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600D4606A32E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=t5XmPxVn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKG37-0003GO-Rs; Fri, 23 Oct 2026 10:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG36-0003GD-FA
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:12 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG33-0006Y3-GY
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:12 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a20b122af8so8225025e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792764908; x=1793369708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Dw1GCON5XXMpzAwQfAKCrxNf5ou7oQkEhrEUFURKH7Q=;
 b=t5XmPxVnsWxEnMKTXyHsekFJAeFcOSKvCzp2buGbnMdRskqaE4D46htGQFwhpO3sVN
 ZNNIb9VUaA5BquDDnNUw423O1MWc1EyQOkGNee9zyBKieH7nuriNbydb2nofkAxJpOg9
 Y0z8tDkmsw9TEvLESWxBRa3TqGE3ma5ikaFgYrXUfp1ojztGMe1K/8eUbbnBo288QvSt
 IvZQl5yFjG2ILbhQNqSUI+biEgIw1DN6x/CMg6BAXYKzYrNgSYa2O50y3LT595xQmfDT
 Ywfp5iHkzC4ccMVAr/ZWPz/+tepkBKCuPiQ7+X2d1GrHhfSH0pR9jbIwjEZiW12k3fzp
 M3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764908; x=1793369708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Dw1GCON5XXMpzAwQfAKCrxNf5ou7oQkEhrEUFURKH7Q=;
 b=EIO8bFhW8zGiTMphXKYq9yIq9JPLTJa8KRbPk/BhoFMnbM6JKiJwDWzwFbpVYqufWH
 rFzFkfXstm5sfPYlIUt6AFkIE7NKvicuXg76yVz8ujcOG74PfSGo/DzQ4mjcPJ0ULfnt
 YS7wHAJiptXyDP8cDpbUHSk2AS2rxmXhI17gCDHqzkd7tEgQal9wSPv+VZ8/+xBmQUBd
 aprLId78teuPgJU+JCpjTGpaBnaJW1NE7DSLUQPE24CWWbLMS25ufiOW73j/P+EO6rJg
 4efDqNkFZlt/P3mcRYclKHujqQPEPWrG3thiLeRdLqnohTRDN+BRsloWdczmdNF4fHYE
 PsCQ==
X-Gm-Message-State: AFq9FYJ3VFHqc0wPUuFAc5EuYIpasUESp3lHpSFt3BqtoX6hvi1VoK+E
 DSLsafLdGuFePueafIK1dryc9sl2R8sM75YnTiZ24xbNrlvGqrCXJTCVzaVQyyyc+EXe9e2+OLd
 Ls2XGnfk=
X-Gm-Gg: AYBFou17TDyVpsG8j8f0zYguUXshIo6F2W7X66PSgZHvEE7n+fFMN77ZBQsP8KAchSF
 T4KoJQ0XbCokNgOxvoNinxFc9K90e5vKWI1BNcvUvYMi+0kFRBK6oGgvXi3yb7rfgmV8Up+iaSU
 VT7cYhT/xL4cXRg8pi/E5TdGYC77EpvYGQXeqjJggznL0EZanUhJs/5dHhUpmpbHA9H5yVywJUe
 A4+uq6sAUZT24/Zhsjeks5fuCF2tCH66gmfGgLWXDXdTIYdXZBQwqZ6QkEut3/WgCw0yMf8oO+8
 KIgVOFLhU7bsyKTMQ1jb3ZfICy2843JT6zx6i5zO5rLE9B+5SZ0UtyduyjVUUJEhdHwtiq5NrMQ
 dGQK22KVhOOYMaL/S5MHDiaW3rM7XHJOfH1/+gcPYan9N4CaSvZcDBAp64OZj1ZXDZtcepAQa78
 gd7irM6ZiZmiY5YMqNQGqVhlBl5XxKKM8/SxTIrps0a3l6s52oSGoz9SEqDkBcjt9qf0YQSTgXw
 m/5ZcNDOQgVuPTaQmvhEut/JvSa/KJ/g4sUzPeCK6phWOehmWTFKGNA/B25leyWKPZDrxkm98it
 kdykkGzWxFg1S+oKaySlbAH6f/geg/fHthn2TdJaTjDoxtxPNPzFOPEDpAuh
X-Received: by 2002:a05:600c:8710:b0:49f:ce78:3562 with SMTP id
 5b1f17b1804b1-4a211eff1d1mr39649805e9.19.1792764907425; 
 Fri, 23 Oct 2026 07:15:07 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2fe31a7a4sm1310675e9.0.2026.10.23.07.15.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:15:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/16] hw/misc/bcm2838_rng200: add BCM2838 RNG200
Date: Fri, 23 Oct 2026 15:14:48 +0100
Message-ID: <20261023141503.1397009-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023141503.1397009-1-peter.maydell@linaro.org>
References: <20261023141503.1397009-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sergey Kambalin <serg.oker@gmail.com>

Add the BCM2838 (BCM2711/Raspberry Pi 4B) hardware random number
generator: register model (control, FIFO data/count, int
mask/status), a Fifo8-backed entropy buffer refilled from a
qemu_rng backend on a ptimer tick, and interrupt generation once the
FIFO crosses its configured threshold.

Part of Sergey Kambalin's original Raspberry Pi 4B series (patchwork
series 829638, posted to qemu-devel in 2024, never merged). Ported
to current master by Marcelo Manzo: header paths moved under
hw/core/, class_init()'s const void *data, the Resettable phases
API, Property[] losing its DEFINE_PROP_END_OF_LIST() sentinel, and
fifo8_pop_buf() gaining a caller-supplied destination buffer instead
of returning an internal pointer (adapted bcm2838_rng200_read_fifo_data()
to the new copying API, which QEMU's own fifo8.h now recommends over
the old fifo8_pop_bufptr() this code originally used). No functional
change otherwise.

Boot-tested: guest probes it ("iproc-rng200 fe104000.rng: hwrng
registered"), /dev/hwrng exists, and reading it returns real random
bytes.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Message-id: 20261015181111.60491-2-marcelomanzo@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: moved trace-events stanza to something vaguely approximating
alpha order, as part of resolving merge conflict]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/bcm2838_rng200.h |  41 ++++
 hw/misc/bcm2838_rng200.c         | 400 +++++++++++++++++++++++++++++++
 hw/misc/meson.build              |   1 +
 hw/misc/trace-events             |  10 +
 4 files changed, 452 insertions(+)
 create mode 100644 include/hw/misc/bcm2838_rng200.h
 create mode 100644 hw/misc/bcm2838_rng200.c

diff --git a/include/hw/misc/bcm2838_rng200.h b/include/hw/misc/bcm2838_rng200.h
new file mode 100644
index 00000000000..4217a48d9d7
--- /dev/null
+++ b/include/hw/misc/bcm2838_rng200.h
@@ -0,0 +1,41 @@
+/*
+ * BCM2838 Random Number Generator emulation
+ *
+ * Copyright (C) 2022 Sergey Pushkarev <sergey.pushkarev@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef BCM2838_RNG200_H
+#define BCM2838_RNG200_H
+
+#include "qom/object.h"
+#include "qemu/fifo8.h"
+#include "system/rng.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/ptimer.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/core/irq.h"
+
+#define TYPE_BCM2838_RNG200 "bcm2838-rng200"
+OBJECT_DECLARE_SIMPLE_TYPE(BCM2838Rng200State, BCM2838_RNG200)
+
+#define N_BCM2838_RNG200_REGS 10
+
+struct BCM2838Rng200State {
+    SysBusDevice busdev;
+    MemoryRegion iomem;
+
+    ptimer_state *ptimer;
+    RngBackend *rng;
+    Clock *clock;
+
+    uint32_t rng_fifo_cap;
+    Fifo8    fifo;
+
+    qemu_irq irq;
+
+    uint32_t regs[N_BCM2838_RNG200_REGS];
+};
+
+#endif /* BCM2838_RNG200_H */
diff --git a/hw/misc/bcm2838_rng200.c b/hw/misc/bcm2838_rng200.c
new file mode 100644
index 00000000000..1b39527cc0c
--- /dev/null
+++ b/hw/misc/bcm2838_rng200.c
@@ -0,0 +1,400 @@
+/*
+ * BCM2838 Random Number Generator emulation
+ *
+ * Copyright (C) 2022 Sergey Pushkarev <sergey.pushkarev@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qom/object_interfaces.h"
+#include "qapi/error.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/misc/bcm2838_rng200.h"
+#include "hw/core/registerfields.h"
+#include "hw/core/resettable.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+/* RNG200 registers */
+REG32(RNG_CTRL,               0x00)
+    FIELD(RNG_CTRL, RBG_ENABLE,   0 , 1)
+    FIELD(RNG_CTRL, RSVD,         1 , 12)
+    FIELD(RNG_CTRL, DIV,         13 , 8)
+
+REG32(RNG_SOFT_RESET,                0x04)
+REG32(RBG_SOFT_RESET,                0x08)
+REG32(RNG_TOTAL_BIT_COUNT,           0x0C)
+REG32(RNG_TOTAL_BIT_COUNT_THRESHOLD, 0x10)
+
+REG32(RNG_INT_STATUS,                               0x18)
+    FIELD(RNG_INT_STATUS, TOTAL_BITS_COUNT_IRQ,         0, 1)
+    FIELD(RNG_INT_STATUS, RSVD0,                        1, 4)
+    FIELD(RNG_INT_STATUS, NIST_FAIL_IRQ,                5, 1)
+    FIELD(RNG_INT_STATUS, RSVD1,                        6, 11)
+    FIELD(RNG_INT_STATUS, STARTUP_TRANSITIONS_MET_IRQ,  17, 1)
+    FIELD(RNG_INT_STATUS, RSVD2,                        18, 13)
+    FIELD(RNG_INT_STATUS, MASTER_FAIL_LOCKOUT_IRQ,      30, 1)
+
+REG32(RNG_INT_ENABLE,                               0x1C)
+    FIELD(RNG_INT_ENABLE, TOTAL_BITS_COUNT_IRQ,         0, 1)
+    FIELD(RNG_INT_ENABLE, RSVD0,                        1, 4)
+    FIELD(RNG_INT_ENABLE, NIST_FAIL_IRQ,                5, 1)
+    FIELD(RNG_INT_ENABLE, RSVD1,                        6, 11)
+    FIELD(RNG_INT_ENABLE, STARTUP_TRANSITIONS_MET_IRQ,  17, 1)
+    FIELD(RNG_INT_ENABLE, RSVD2,                        18, 13)
+    FIELD(RNG_INT_ENABLE, MASTER_FAIL_LOCKOUT_IRQ,      30, 1)
+
+REG32(RNG_FIFO_DATA, 0x20)
+
+REG32(RNG_FIFO_COUNT,              0x24)
+    FIELD(RNG_FIFO_COUNT, COUNT,       0, 8)
+    FIELD(RNG_FIFO_COUNT, THRESHOLD,   8, 8)
+
+
+#define RNG_WARM_UP_PERIOD_ELAPSED           17
+
+#define SOFT_RESET    1
+#define IRQ_PENDING   1
+
+#define BCM2838_RNG200_PTIMER_POLICY         (PTIMER_POLICY_CONTINUOUS_TRIGGER)
+
+static const VMStateDescription vmstate_bcm2838_rng200 = {
+    .name = "bcm2838_rng200",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(rng_fifo_cap, BCM2838Rng200State),
+        VMSTATE_UINT32_ARRAY(regs, BCM2838Rng200State, N_BCM2838_RNG200_REGS),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool is_rbg_enabled(BCM2838Rng200State *s)
+{
+    return FIELD_EX32(s->regs[R_RNG_CTRL], RNG_CTRL, RBG_ENABLE);
+}
+
+static void bcm2838_rng200_update_irq(BCM2838Rng200State *s)
+{
+    qemu_set_irq(s->irq,
+                !!(s->regs[R_RNG_INT_ENABLE] & s->regs[R_RNG_INT_STATUS]));
+}
+
+static void bcm2838_rng200_update_rbg_period(void *opaque, ClockEvent event)
+{
+    BCM2838Rng200State *s = (BCM2838Rng200State *)opaque;
+
+    ptimer_transaction_begin(s->ptimer);
+    ptimer_set_period_from_clock(s->ptimer, s->clock, s->rng_fifo_cap * 8);
+    ptimer_transaction_commit(s->ptimer);
+}
+
+static void bcm2838_rng200_update_fifo(void *opaque, const void *buf,
+                                       size_t size)
+{
+    BCM2838Rng200State *s = (BCM2838Rng200State *)opaque;
+    Fifo8 *fifo = &s->fifo;
+    size_t num = MIN(size, fifo8_num_free(fifo));
+    uint32_t num_bits = num * 8;
+    uint32_t bit_count = 0;
+    uint32_t bit_count_thld = 0;
+    uint32_t fifo_thld = 0;
+
+    bit_count = s->regs[R_RNG_TOTAL_BIT_COUNT];
+    bit_count_thld = s->regs[R_RNG_TOTAL_BIT_COUNT_THRESHOLD];
+
+    if (bit_count + num_bits < bit_count_thld) {
+        s->regs[R_RNG_TOTAL_BIT_COUNT] += num_bits;
+
+        fifo8_push_all(fifo, buf, num);
+
+        fifo_thld = FIELD_EX32(s->regs[R_RNG_FIFO_COUNT],
+                               RNG_FIFO_COUNT, THRESHOLD);
+
+        if (fifo8_num_used(fifo) > fifo_thld) {
+            s->regs[R_RNG_INT_STATUS] = FIELD_DP32(s->regs[R_RNG_INT_STATUS],
+                                                    RNG_INT_STATUS,
+                                                    TOTAL_BITS_COUNT_IRQ, 1);
+        }
+    }
+
+    s->regs[R_RNG_FIFO_COUNT] = FIELD_DP32(s->regs[R_RNG_FIFO_COUNT],
+                                           RNG_FIFO_COUNT,
+                                           COUNT,
+                                           fifo8_num_used(fifo) >> 2);
+    bcm2838_rng200_update_irq(s);
+    trace_bcm2838_rng200_update_fifo(num, fifo8_num_used(fifo));
+}
+
+static void bcm2838_rng200_fill_fifo(BCM2838Rng200State *s)
+{
+    rng_backend_request_entropy(s->rng, fifo8_num_free(&s->fifo),
+                                bcm2838_rng200_update_fifo, s);
+}
+
+static void bcm2838_rng200_disable_rbg(void)
+{
+    trace_bcm2838_rng200_disable_rbg();
+}
+
+static void bcm2838_rng200_enable_rbg(BCM2838Rng200State *s)
+{
+    s->regs[R_RNG_TOTAL_BIT_COUNT] = RNG_WARM_UP_PERIOD_ELAPSED;
+
+    bcm2838_rng200_fill_fifo(s);
+
+    trace_bcm2838_rng200_enable_rbg();
+}
+
+static void bcm2838_rng200_rng_reset(BCM2838Rng200State *s)
+{
+    memset(s->regs, 0, sizeof(s->regs));
+    s->regs[R_RNG_INT_STATUS] = FIELD_DP32(s->regs[R_RNG_INT_STATUS],
+                                           RNG_INT_STATUS,
+                                           STARTUP_TRANSITIONS_MET_IRQ,
+                                           IRQ_PENDING);
+    fifo8_reset(&s->fifo);
+
+    trace_bcm2838_rng200_rng_soft_reset();
+}
+
+static void bcm2838_rng200_rbg_reset(BCM2838Rng200State *s)
+{
+    trace_bcm2838_rng200_rbg_soft_reset();
+}
+
+static uint32_t bcm2838_rng200_read_fifo_data(BCM2838Rng200State *s)
+{
+    Fifo8 *fifo = &s->fifo;
+    uint32_t to_read = MIN(fifo8_num_used(fifo), 4);
+    uint8_t byte_buf[4] = {};
+    uint8_t *p = byte_buf;
+    uint32_t ret = 0;
+    uint32_t num;
+
+    while (to_read) {
+        num = fifo8_pop_buf(fifo, p, to_read);
+        p += num;
+        to_read -= num;
+    }
+    ret = ldl_le_p(byte_buf);
+
+    s->regs[R_RNG_FIFO_COUNT] = FIELD_DP32(s->regs[R_RNG_FIFO_COUNT],
+                                           RNG_FIFO_COUNT,
+                                           COUNT,
+                                           fifo8_num_used(fifo) >> 2);
+
+    bcm2838_rng200_fill_fifo(s);
+
+    return ret;
+}
+
+static void bcm2838_rng200_ctrl_write(BCM2838Rng200State *s, uint32_t value)
+{
+    bool currently_enabled = is_rbg_enabled(s);
+    bool enable_requested = FIELD_EX32(value, RNG_CTRL, RBG_ENABLE);
+
+    s->regs[R_RNG_CTRL] = value;
+
+    if (!currently_enabled && enable_requested) {
+        bcm2838_rng200_enable_rbg(s);
+    } else if (currently_enabled && !enable_requested) {
+        bcm2838_rng200_disable_rbg();
+    }
+}
+
+static uint64_t bcm2838_rng200_read(void *opaque, hwaddr offset,
+                                    unsigned size)
+{
+    BCM2838Rng200State *s = (BCM2838Rng200State *)opaque;
+    uint32_t res = 0;
+
+    switch (offset) {
+    case A_RNG_CTRL:
+        res = s->regs[R_RNG_CTRL];
+        break;
+    case A_RNG_SOFT_RESET:
+    case A_RBG_SOFT_RESET:
+        break;
+    case A_RNG_INT_STATUS:
+        res = s->regs[R_RNG_INT_STATUS];
+        break;
+    case A_RNG_INT_ENABLE:
+        res = s->regs[R_RNG_INT_ENABLE];
+        break;
+    case A_RNG_FIFO_DATA:
+        res = bcm2838_rng200_read_fifo_data(s);
+        break;
+    case A_RNG_FIFO_COUNT:
+        res = s->regs[R_RNG_FIFO_COUNT];
+        break;
+    case A_RNG_TOTAL_BIT_COUNT:
+        res = s->regs[R_RNG_TOTAL_BIT_COUNT];
+        break;
+    case A_RNG_TOTAL_BIT_COUNT_THRESHOLD:
+        res = s->regs[R_RNG_TOTAL_BIT_COUNT_THRESHOLD];
+        break;
+    default:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "bcm2838_rng200_read: Bad offset 0x%" HWADDR_PRIx "\n",
+            offset
+        );
+        res = 0;
+        break;
+    }
+
+    trace_bcm2838_rng200_read(offset, size, res);
+    return res;
+}
+
+static void bcm2838_rng200_write(void *opaque, hwaddr offset,
+                                 uint64_t value, unsigned size)
+{
+    BCM2838Rng200State *s = (BCM2838Rng200State *)opaque;
+
+    trace_bcm2838_rng200_write(offset, value, size);
+
+    switch (offset) {
+    case A_RNG_CTRL:
+        bcm2838_rng200_ctrl_write(s, value);
+        break;
+    case A_RNG_SOFT_RESET:
+        if (value & SOFT_RESET) {
+            bcm2838_rng200_rng_reset(s);
+        }
+        break;
+    case A_RBG_SOFT_RESET:
+        if (value & SOFT_RESET) {
+            bcm2838_rng200_rbg_reset(s);
+        }
+        break;
+    case A_RNG_INT_STATUS:
+        s->regs[R_RNG_INT_STATUS] &= ~value;
+        bcm2838_rng200_update_irq(s);
+        break;
+    case A_RNG_INT_ENABLE:
+        s->regs[R_RNG_INT_ENABLE] = value;
+        bcm2838_rng200_update_irq(s);
+        break;
+    case A_RNG_FIFO_COUNT:
+        s->regs[R_RNG_FIFO_COUNT] = value;
+        break;
+    case A_RNG_TOTAL_BIT_COUNT_THRESHOLD:
+        s->regs[R_RNG_TOTAL_BIT_COUNT_THRESHOLD] = value;
+        s->regs[R_RNG_TOTAL_BIT_COUNT] = value + 1;
+        break;
+    default:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "bcm2838_rng200_write: Bad offset 0x%" HWADDR_PRIx "\n",
+            offset
+        );
+        break;
+    }
+}
+
+static const MemoryRegionOps bcm2838_rng200_ops = {
+    .read = bcm2838_rng200_read,
+    .write = bcm2838_rng200_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .max_access_size = 4,
+        .min_access_size = 4,
+    },
+    .valid = {
+        .max_access_size = 4,
+        .min_access_size = 4
+    },
+};
+
+static void bcm2838_rng200_realize(DeviceState *dev, Error **errp)
+{
+    BCM2838Rng200State *s = BCM2838_RNG200(dev);
+
+    if (s->rng == NULL) {
+        Object *default_backend = object_new(TYPE_RNG_BUILTIN);
+
+        if (!user_creatable_complete(USER_CREATABLE(default_backend),
+                                     errp)) {
+            object_unref(default_backend);
+            error_setg(errp, "Failed to create user creatable RNG backend");
+            return;
+        }
+
+        object_property_add_child(OBJECT(dev), "default-backend",
+                                  default_backend);
+        object_unref(default_backend);
+
+        object_property_set_link(OBJECT(dev), "rng", default_backend,
+                                 errp);
+    }
+
+    fifo8_create(&s->fifo, s->rng_fifo_cap);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+}
+
+static void bcm2838_rng200_init(Object *obj)
+{
+    BCM2838Rng200State *s = BCM2838_RNG200(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    s->rng_fifo_cap = 128;
+
+    s->clock = qdev_init_clock_in(DEVICE(s), "rbg-clock",
+                                  bcm2838_rng200_update_rbg_period, s,
+                                  ClockPreUpdate);
+    if (s->clock == NULL) {
+        error_setg(&error_fatal, "Failed to init RBG clock");
+        return;
+    }
+
+    memory_region_init_io(&s->iomem, obj, &bcm2838_rng200_ops, s,
+                          TYPE_BCM2838_RNG200, 0x28);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void bcm2838_rng200_reset(Object *obj, ResetType type)
+{
+    BCM2838Rng200State *s = BCM2838_RNG200(obj);
+
+    bcm2838_rng200_rbg_reset(s);
+    bcm2838_rng200_rng_reset(s);
+}
+
+static const Property bcm2838_rng200_properties[] = {
+    DEFINE_PROP_LINK("rng", BCM2838Rng200State, rng,
+                     TYPE_RNG_BACKEND, RngBackend *),
+};
+
+static void bcm2838_rng200_class_init(ObjectClass *klass, const void *data)
+{
+    static ResettablePhases unused_parent_phases;
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = bcm2838_rng200_realize;
+    resettable_class_set_parent_phases(rc, NULL, bcm2838_rng200_reset, NULL,
+                                       &unused_parent_phases);
+    dc->vmsd = &vmstate_bcm2838_rng200;
+
+    device_class_set_props(dc, bcm2838_rng200_properties);
+}
+
+static const TypeInfo bcm2838_rng200_info = {
+    .name          = TYPE_BCM2838_RNG200,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2838Rng200State),
+    .class_init    = bcm2838_rng200_class_init,
+    .instance_init = bcm2838_rng200_init,
+};
+
+static void bcm2838_rng200_register_types(void)
+{
+    type_register_static(&bcm2838_rng200_info);
+}
+
+type_init(bcm2838_rng200_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 8a94aba751d..02e90b479ee 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -99,6 +99,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_thermal.c',
   'bcm2835_cprman.c',
   'bcm2835_powermgt.c',
+  'bcm2838_rng200.c',
 ))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 7fde3f8a769..6c425ce8da9 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -355,6 +355,16 @@ bcm2835_mbox_write(unsigned int size, uint64_t addr, uint64_t value) "mbox write
 bcm2835_mbox_read(unsigned int size, uint64_t addr, uint64_t value) "mbox read sz:%u addr:0x%"PRIx64" data:0x%"PRIx64
 bcm2835_mbox_irq(unsigned level) "mbox irq:ARM level:%u"
 
+# bcm2838_rng200.c
+bcm2838_rng200_rng_soft_reset(void) "RNumG soft reset"
+bcm2838_rng200_rbg_soft_reset(void) "RBitG soft reset"
+bcm2838_rng200_enable_rbg(void) "RBitG enabled"
+bcm2838_rng200_disable_rbg(void) "RBitG disabled"
+bcm2838_rng200_update_fifo(uint32_t len, uint32_t fifo_len) "len %u, fifo_len %u"
+bcm2838_rng200_fifo_full(void) "RNumG FIFO full"
+bcm2838_rng200_write(uint64_t addr, uint64_t value, unsigned size) "addr: 0x%"PRIx64" value: 0x%016" PRIx64 " size: %u"
+bcm2838_rng200_read(uint64_t addr, unsigned size, uint64_t value) "addr: 0x%"PRIx64" size: %u value: 0x%016" PRIx64
+
 # mac_via.c
 via1_rtc_update_data_out(int count, int value) "count=%d value=0x%02x"
 via1_rtc_update_data_in(int count, int value) "count=%d value=0x%02x"
-- 
2.43.0


