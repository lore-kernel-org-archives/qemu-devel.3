Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6F6C52D7D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 10:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfGeJ-00083a-NW; Sat, 17 Aug 2024 06:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <303rAZgUKCgg1i3qxowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--tavip.bounces.google.com>)
 id 1sfGdt-0006Pf-M4
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:45 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <303rAZgUKCgg1i3qxowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--tavip.bounces.google.com>)
 id 1sfGdn-0003HP-8b
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:40 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-201ee593114so22505115ad.1
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 03:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723890390; x=1724495190; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=9VJw6sYoIuMPtBi09oflNn4QDUERsiOsocRbQjWdV6c=;
 b=K2gyn30/Yl3y7ydKtqvupIrqWPdyAOTWfzGBbloBNOcBYya6DB63dbr3tcefAUpWxJ
 qS9cs3WpldfynvOz0K70MRzxrji3Rz1+6TEpIKrnxfbU7+HHw5mvg3r1Mx2l3VcsPoaH
 sbaPdgfYbsUy1/elxy9ZKXOPkLvBOKJOhnL0y0KmhjItYjL4TLTQDv/Du2xIqiPMPD4J
 GEUX3wvsY7U/XASDMFii48M1NeQmwxOUAisUGeLnjx220FT/0GcMVeEUBUz6EJobBi53
 mIwQan9wB8g+87GPKzAyi+TKN5Xf3029XxxTGbw+rqscPhAKwjg/6p63txRSK/4AfnW8
 8szA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723890390; x=1724495190;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9VJw6sYoIuMPtBi09oflNn4QDUERsiOsocRbQjWdV6c=;
 b=BkQqLpTNEeLDwMD3W1mjgJnO5umU0SiAuHJaAstWBGuujAbaKKfy+FqYA4l1anI6Kw
 GWt+9hjjVScH+rGxxrI9dKxgAfjDkEihuRdvWxVgYLJ2oUKqA03Fs2gspEQHsXZXsmwK
 fuyLWrKuF7l9yeudAMuLSZQBc9H9kTA1++O3kDi63njsuosJ5Vwm6zTajJl/efhZFgKC
 81v2t+LOTJFs3W1/Fwv/TDZ+BFXIYZgsFGqj2vmj+BMZn+Lhc26jpdpVGZporK9Ri4ec
 tnsFbO0PloFGv5biIKgP4syaIejFmrW9VtG6NXWpFXkQIQ4/HjCUeMhKtYAGXNeaPIhL
 e9Ww==
X-Gm-Message-State: AOJu0YxazorAIhsOyqpN6TBACS1AjgKo6En1t2eyYDHRWU5wnPaauq1V
 e925p8qQEBu0OaKIMRyAnolVUwILvQ6XQaKLJRGk6A1GheiotfVSkNgFtL4jZMI2xGdd2+3uZSi
 zzAI0fNOQYT1WRws3tVbH7QlgmBS44Wh4npubLA9LidJPaRjHFRM9h+SVwy5zURK8uiO1fKbaw8
 8hnhxGcF42wGaUbHIkLoUXF6h68w==
X-Google-Smtp-Source: AGHT+IGULzJyT9wkl41mvWq8BQyyvwhnwQAMK0Ssc5ZHhvDTUFf8ouze3DHpE3ltunVokngp93/DnLN0BA==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:903:30c9:b0:1fa:2c53:5fc9
 with SMTP id
 d9443c01a7336-201ee510908mr230245ad.3.1723890387828; Sat, 17 Aug 2024
 03:26:27 -0700 (PDT)
Date: Sat, 17 Aug 2024 03:25:54 -0700
In-Reply-To: <20240817102606.3996242-1-tavip@google.com>
Mime-Version: 1.0
References: <20240817102606.3996242-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240817102606.3996242-12-tavip@google.com>
Subject: [RFC PATCH v2 11/23] test/unit: add flexcomm usart unit test
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 thuth@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, 
 alistair@alistair23.me, berrange@redhat.com, philmd@linaro.org, 
 jsnow@redhat.com, crosa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=303rAZgUKCgg1i3qxowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--tavip.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Add polling and irq unit tests for the flexcomm usart device model.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/unit/test-flexcomm-usart.c | 320 +++++++++++++++++++++++++++++++
 tests/unit/meson.build           |   7 +
 2 files changed, 327 insertions(+)
 create mode 100644 tests/unit/test-flexcomm-usart.c

diff --git a/tests/unit/test-flexcomm-usart.c b/tests/unit/test-flexcomm-usart.c
new file mode 100644
index 0000000000..83024b0b35
--- /dev/null
+++ b/tests/unit/test-flexcomm-usart.c
@@ -0,0 +1,320 @@
+/*
+ * Copyright (C) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/config-file.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "qemu/sockets.h"
+#include "sysemu/sysemu.h"
+#include "qemu/main-loop.h"
+#include "qemu/option.h"
+#include "exec/memory.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+
+#include "hw/misc/flexcomm.h"
+#include "sysbus-mock.h"
+#include "reg-utils.h"
+
+typedef struct {
+    DeviceState *dev;
+    int sock;
+    Chardev *chr;
+    bool irq;
+} TestFixture;
+
+#define FLEXCOMM_BASE 0x40106000UL
+#define FLEXCOMM_USART_BASE FLEXCOMM_BASE
+
+/* Callback for the interrupt line. */
+static void usart_irq_set(void *opaque, int line, int level)
+{
+    TestFixture *f = (TestFixture *)opaque;
+
+    f->irq = level;
+}
+
+/*
+ * Test fixture initialization.
+ */
+static void set_up(TestFixture *f, gconstpointer data)
+{
+    struct sockaddr_in sockaddr = {
+        .sin_family = AF_INET,
+    };
+    socklen_t sockaddr_len = sizeof(sockaddr);
+    char chr_opts[] = "udp:127.0.0.1:xxxxx";
+    FlexcommState *s;
+    char buf[] = "xxx";
+    int port;
+
+    /* create "server" socket and bind to a random port */
+    f->sock = socket(AF_INET, SOCK_DGRAM, 0);
+    g_assert(f->sock >= 0);
+    g_assert(bind(f->sock, &sockaddr, sizeof(sockaddr)) == 0);
+    g_assert(getsockname(f->sock, &sockaddr, &sockaddr_len) == 0);
+
+    /* create the an UDP char device and connect it to the sever */
+    port = ntohs(sockaddr.sin_port);
+    g_assert(port != 0);
+    snprintf(chr_opts, sizeof(chr_opts), "udp:127.0.0.1:%d", port);
+    f->chr = qemu_chr_new("udp", chr_opts, NULL);
+    g_assert_nonnull(f->chr);
+
+    /* test connectivity and connect server to UDP char device  */
+    qemu_chr_write_all(f->chr, (const uint8_t *)"210", sizeof("210"));
+    recvfrom(f->sock, buf, sizeof(buf), 0, &sockaddr, &sockaddr_len);
+    g_assert(strcmp(buf, "210") == 0);
+    g_assert(sockaddr_len == sizeof(sockaddr));
+    g_assert(connect(f->sock, &sockaddr, sockaddr_len) == 0);
+
+    f->dev = qdev_new(TYPE_FLEXCOMM);
+    g_assert(f->dev);
+
+    s = FLEXCOMM(f->dev);
+    s->irq = qemu_allocate_irq(usart_irq_set, f, 0);
+    g_assert(qemu_chr_fe_init(&s->chr, f->chr, &error_abort));
+
+    if (data != NULL) {
+        qdev_prop_set_int32(DEVICE(f->dev), "functions", (uintptr_t)data);
+    }
+
+    qdev_realize_and_unref(f->dev, NULL, &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(f->dev), 0, FLEXCOMM_BASE);
+
+    qemu_chr_be_update_read_handlers(f->chr, NULL);
+
+    device_cold_reset(f->dev);
+}
+
+static void tear_down(TestFixture *f, gconstpointer user_data)
+{
+    qdev_unrealize(f->dev);
+    object_unparent(OBJECT(f->chr));
+    close(f->sock);
+    g_free(f->dev);
+}
+
+static void polling_test(TestFixture *f, gconstpointer user_data)
+{
+    uint32_t tmp;
+    unsigned char byte;
+    int fifo_size;
+
+    /* select and lock USART */
+    tmp = FIELD_DP32(FLEXCOMM_PERSEL_USART, FLEXCOMM_PSELID, LOCK, 1);
+    REG32_WRITE(f->dev, FLEXCOMM, PSELID, tmp);
+
+    fifo_size = REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOSIZE, FIFOSIZE);
+
+    /* enable USART */
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_USART, CFG, ENABLE, 1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, CFG, ENABLE) == 1);
+
+    /* enable TX and RX FIFO */
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_USART, FIFOCFG, ENABLETX, 1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOCFG, ENABLETX) == 1);
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_USART, FIFOCFG, ENABLERX, 1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOCFG, ENABLERX) == 1);
+
+    /* test writes and fifo counters wrap */
+    for (int i = 0; i < fifo_size / 2; i++) {
+        /* check fifostat */
+        g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOSTAT, RXFULL) ==
+                 0);
+        g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOSTAT, RXNOTEMPTY)
+                 == 0);
+        g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOSTAT, TXNOTFULL)
+                 == 1);
+        g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOSTAT, TXEMPTY) ==
+                 1);
+
+        REG32_WRITE(f->dev, FLEXCOMM_USART, FIFOWR, 'a' + i);
+        recv(f->sock, &byte, 1, 0);
+        g_assert_cmpuint(byte, ==, 'a' + i);
+    }
+
+    /* test reads and fifo level */
+
+    for (int i = 0; i < fifo_size / 2; i++) {
+        byte = 'A' + i;
+        g_assert(send(f->sock, &byte, 1, 0) == 1);
+    }
+
+    /* wait for the RXLVL to update */
+    WAIT_REG32_FIELD(1000, f->dev, FLEXCOMM_USART, FIFOSTAT, RXLVL,
+                     fifo_size / 2);
+
+    /* check fifo stat */
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOSTAT, RXFULL) == 0);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOSTAT, RXNOTEMPTY)
+             == 1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOSTAT, TXNOTFULL)
+             == 1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOSTAT, TXEMPTY)
+             == 1);
+
+    /* send until FIFO is full */
+    for (int i = fifo_size / 2; i < fifo_size; i++) {
+        byte = 'A' + i;
+        g_assert(send(f->sock, &byte, 1, 0) == 1);
+    }
+
+    /* wait for the RXLVL to update */
+    WAIT_REG32_FIELD(1000, f->dev, FLEXCOMM_USART, FIFOSTAT, RXLVL, fifo_size);
+
+    /* check fifo stat */
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOSTAT, RXFULL) == 1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOSTAT, RXNOTEMPTY) ==
+             1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOSTAT, TXNOTFULL) ==
+             1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOSTAT, TXEMPTY) ==
+             1);
+
+    /* check read no pop */
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFORDNOPOP, RXDATA) ==
+             'A');
+
+    /* now read from the fifo  */
+    for (int i = 0; i < fifo_size; i++) {
+        g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFORD, RXDATA) ==
+                 'A' + i);
+    }
+
+    /* check fifostat */
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOSTAT, RXFULL) == 0);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOSTAT, RXNOTEMPTY) ==
+             0);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOSTAT, TXNOTFULL) ==
+             1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOSTAT, TXEMPTY) == 1);
+}
+
+static void irq_test(TestFixture *f, gconstpointer user_data)
+{
+    char buf[256] = { 0, };
+    uint32_t tmp;
+
+    /* select and lock FLEXCOMM_USART */
+    tmp = FIELD_DP32(FLEXCOMM_PERSEL_USART, FLEXCOMM_PSELID, LOCK, 1);
+    REG32_WRITE(f->dev, FLEXCOMM, PSELID, tmp);
+
+    /*
+     * set RX IRQ/DMA trigger level to 4 bytes - value 3 in FIFOTRIG
+     *
+     * 0000 - Trigger when the RX FIFO has received 1 entry (is no longer empty)
+     * 0001 - Trigger when the RX FIFO has received 2 entries
+     * 1111 - Trigger when the RX FIFO has received 16 entries (has become full)
+     */
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_USART, FIFOTRIG, RXLVL, 3);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOTRIG, RXLVL) == 3);
+
+    /* enable RX trigger for IRQ/DMA  */
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_USART, FIFOTRIG, RXLVLENA, 1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOTRIG, RXLVLENA) == 1);
+
+    /* enable RXLVL interrupt */
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_USART, FIFOINTENSET, RXLVL, 1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOINTENSET, RXLVL)
+             == 1);
+
+    /* enable FLEXCOMM_USART */
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_USART, CFG, ENABLE, 1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, CFG, ENABLE) == 1);
+
+    /* enable TX and RX FIFO */
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_USART, FIFOCFG, ENABLETX, 1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOCFG, ENABLETX) == 1);
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_USART, FIFOCFG, ENABLERX, 1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOCFG, ENABLERX) == 1);
+
+    /* check interrupt status */
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOINTSTAT, RXLVL) == 0);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOINTSTAT, TXLVL) == 0);
+    g_assert(f->irq == false);
+
+    /* enable TX trigger for IRQ/DMA  */
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_USART, FIFOTRIG, TXLVLENA, 1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOTRIG, TXLVLENA) == 1);
+
+    /* enable irq for TX */
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_USART, FIFOINTENSET, TXLVL, 1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOINTENSET, TXLVL) ==
+             1);
+
+    /* check TX irq */
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOINTSTAT, TXLVL) == 1);
+    g_assert(f->irq == true);
+
+    /* disable irq for TX */
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_USART, FIFOTRIG, TXLVLENA, 0);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOTRIG, TXLVLENA) == 0);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOINTSTAT, TXLVL) == 0);
+    g_assert(f->irq == false);
+
+    /* send 3 bytes */
+    g_assert(send(f->sock, buf, 3, 0) == 3);
+
+    /* check that we have 3 bytes in the fifo */
+    WAIT_REG32_FIELD(1000, f->dev, FLEXCOMM_USART, FIFOSTAT, RXLVL, 3);
+
+    /* and no interrupt has been triggered yet */
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOINTSTAT, RXLVL) == 0);
+    g_assert(f->irq == false);
+
+    /* push it over the edge */
+    g_assert(send(f->sock, buf, 1, 0) == 1);
+
+    /* check that we have 4 bytes in the fifo */
+    WAIT_REG32_FIELD(1000, f->dev, FLEXCOMM_USART, FIFOSTAT, RXLVL, 4);
+
+    /* and the interrupt has been triggered */
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOINTSTAT, RXLVL) == 1);
+    g_assert(f->irq == true);
+
+    /* read one byte from the fifo */
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFORD, RXDATA) == 0);
+
+    /* we should have 3 bytes in the FIFO */
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOSTAT, RXLVL) == 3);
+
+    /* and no interrupts active */
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_USART, FIFOINTSTAT, RXLVL) == 0);
+    g_assert(f->irq == false);
+}
+
+/* mock-up */
+const PropertyInfo qdev_prop_chr;
+
+int main(int argc, char **argv)
+{
+    qemu_init_main_loop(&error_abort);
+    socket_init();
+
+    g_test_init(&argc, &argv, NULL);
+
+    /* Initialize object types. */
+    sysbus_mock_init();
+    module_call_init(MODULE_INIT_QOM);
+    qemu_add_opts(&qemu_chardev_opts);
+
+    g_test_add("/flexcomm-usart/polling", TestFixture,
+               (gconstpointer)(1 << FLEXCOMM_FUNC_USART),
+               set_up, polling_test, tear_down);
+
+    g_test_add("/flexcomm-usart/irq", TestFixture,
+               (gconstpointer)(1 << FLEXCOMM_FUNC_USART),
+               set_up, irq_test, tear_down);
+
+    return g_test_run();
+}
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 70e816c034..dcfd2e661c 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -149,6 +149,13 @@ if have_system
       meson.project_source_root() / 'hw/misc/flexcomm.c',
       meson.project_source_root() / 'hw/char/flexcomm_usart.c',
      ],
+    'test-flexcomm-usart': [
+      hwcore, chardev, qom, migration,
+      meson.project_source_root() / 'hw/core/gpio.c',
+      meson.project_source_root() / 'tests/unit/sysbus-mock.c',
+      meson.project_source_root() / 'hw/misc/flexcomm.c',
+      meson.project_source_root() / 'hw/char/flexcomm_usart.c',
+    ],
   }
   if config_host_data.get('CONFIG_INOTIFY1')
     tests += {'test-util-filemonitor': []}
-- 
2.46.0.184.g6999bdac58-goog


