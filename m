Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2840ECED24E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyu6-0004AN-Mu; Mon, 07 Oct 2024 21:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3nogEZwUKCgEubwjqhpphmf.dpnrfnv-efwfmopohov.psh@flex--tavip.bounces.google.com>)
 id 1sxysx-0008CR-Ja
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:36 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3nogEZwUKCgEubwjqhpphmf.dpnrfnv-efwfmopohov.psh@flex--tavip.bounces.google.com>)
 id 1sxyst-0000DM-7E
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:34 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6e2baf2ff64so75973027b3.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 18:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728350367; x=1728955167; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=KH/2xv+ry9E6fErLW4rxS6RZmIvXaaOZIkrg/WhK4hs=;
 b=E2IPreJg/qpe9C4HZIVYUl2AoLpgWNToFGeYZsH+sMaXZz3c31uhCKtffKNXPBwNZR
 3CXoacMfTSpq8TOnLP9S86M/HI3SJ/NwPeP/B52CunBCG1ecXHXugSQPg5hOVPbUz//0
 j6Rwm+THEUt/hOKd9dDX+i8goQw5ndtBptBe/bNXwGsCFz+BYN4Pr5vZFsIw8unH8xmR
 I9/XArOEGjwu7wjaELZlQcxd1oivqpJhmHGuxWZaSJp/ESqHur71Q0xhWeeUFtcXOE8M
 adWbHJl0xIbX8ogLBSsTllQb14XvWg5Bjxfq4f8UaqV9rHbRvyUPcVxCN2B/wdfGWIE4
 9N2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350367; x=1728955167;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KH/2xv+ry9E6fErLW4rxS6RZmIvXaaOZIkrg/WhK4hs=;
 b=uhh8X65gXBBchvyOtfp1kmbC4VlS4xR9H2bpPUGHzFOd+sQISIRdYws6j0+KMJ4dh1
 LcRV90bD9IJD7htsy8Gg99rSJOmxlsf1Wzm0eWF7n5BeLhN5WeIZ+PW/KVcUEifqieMw
 irf6RKePbUbpb2cWi7md33k9sxLgdyfueexnZqi96PlzdWbwloV8zkEHsNwoGtCiWPYX
 WQ0Qj4wVkP4JqXSXerb2954GE1TRdpzDSG5ZJmCWEutUSajRub6k3du37ZvEgg0j1FTb
 3PFQe5+yNDQatPOGyVUiAoG9JJDtHcfJ4pG1kThq/JnAoIdIQDkADfS1AEZ8AhXcENSg
 DJCw==
X-Gm-Message-State: AOJu0YwYBAmhugtdk33HXbNbSmavuKHm2AWsg+jWr4l/TZ9KgZ+/1YDe
 ZSqKB1Q8rWQHIEKwMG7T5jYpkxr6Tn5kgbHQcyHJFV8cn7PKgw1ePuDdm4NxYXBYwoHVnYNtF/x
 aLf13jNWMsKtzjCNS61FzGRQ5ECVaq4K7m08lO4oWz0+Y9ohPoHHXNuJ6dGVG86FuQFUoBkubPs
 frbAkZKUehlnVW+dFaYcHSoS3g8Q==
X-Google-Smtp-Source: AGHT+IEPgy4jBCEt/GAlr5KBC579+z7N16RaMIrOgzKSXWJPySuiz34MQJTVEkI0pz4USPrVQ52UP1boKg==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a81:ad0b:0:b0:6e2:121c:4509 with
 SMTP id
 00721157ae682-6e2c72bbd4bmr1572397b3.7.1728350366897; Mon, 07 Oct 2024
 18:19:26 -0700 (PDT)
Date: Mon,  7 Oct 2024 18:18:44 -0700
In-Reply-To: <20241008011852.1439154-1-tavip@google.com>
Mime-Version: 1.0
References: <20241008011852.1439154-1-tavip@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008011852.1439154-19-tavip@google.com>
Subject: [PATCH v2 18/25] tests/qtest: add flexcomm usart tests
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3nogEZwUKCgEubwjqhpphmf.dpnrfnv-efwfmopohov.psh@flex--tavip.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.024,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Add flexcomm usart polling and irq unit tests.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/qtest/flexcomm-usart-test.c | 316 ++++++++++++++++++++++++++++++
 tests/qtest/meson.build           |   3 +-
 2 files changed, 318 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/flexcomm-usart-test.c

diff --git a/tests/qtest/flexcomm-usart-test.c b/tests/qtest/flexcomm-usart-test.c
new file mode 100644
index 0000000000..0ffa49dd6f
--- /dev/null
+++ b/tests/qtest/flexcomm-usart-test.c
@@ -0,0 +1,316 @@
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
+#include <glib/gstdio.h>
+
+#include "io/channel-socket.h"
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
+#include "hw/arm/svd/flexcomm_usart.h"
+#include "hw/arm/svd/rt500.h"
+#include "reg-utils.h"
+
+#define FLEXCOMM_BASE RT500_FLEXCOMM0_BASE
+#define FLEXCOMM_USART_BASE RT500_FLEXCOMM0_BASE
+#define DEVICE_NAME "/machine/soc/flexcomm0"
+
+struct TestState {
+    QTestState *qtest;
+    QIOChannel *ioc;
+};
+
+static void polling_test(gconstpointer user_data)
+{
+    struct TestState *t = (struct TestState *)user_data;
+    uint32_t tmp;
+    char byte;
+    int fifo_size;
+    QDict *resp;
+
+    resp = qmp("{\"execute\": \"system_reset\"}");
+    qdict_unref(resp);
+
+    /* select and lock USART */
+    tmp = FIELD_DP32(FLEXCOMM_PERSEL_USART, FLEXCOMM_PSELID, LOCK, 1);
+    REG32_WRITE(FLEXCOMM, PSELID, tmp);
+
+    fifo_size = REG32_READ_FIELD(FLEXCOMM_USART, FIFOSIZE, FIFOSIZE);
+
+    /* enable USART */
+    REG32_WRITE_FIELD(FLEXCOMM_USART, CFG, ENABLE, 1);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, CFG, ENABLE), ==, 1);
+
+    /* enable TX and RX FIFO */
+    REG32_WRITE_FIELD(FLEXCOMM_USART, FIFOCFG, ENABLETX, 1);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOCFG, ENABLETX),
+                     ==, 1);
+    REG32_WRITE_FIELD(FLEXCOMM_USART, FIFOCFG, ENABLERX, 1);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOCFG, ENABLERX),
+                     ==, 1);
+
+    /* test writes and fifo counters wrap */
+    for (int i = 0; i < fifo_size / 2; i++) {
+        /* check fifostat */
+        g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOSTAT, RXFULL),
+                         ==, 0);
+        g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOSTAT, RXNOTEMPTY),
+                         ==, 0);
+        g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOSTAT, TXNOTFULL),
+                         ==, 1);
+        g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOSTAT, TXEMPTY),
+                         ==, 1);
+
+        REG32_WRITE(FLEXCOMM_USART, FIFOWR, 'a' + i);
+        qio_channel_read(t->ioc, &byte, 1, &error_abort);
+        g_assert_cmpuint(byte, ==, 'a' + i);
+    }
+
+    /* test reads and fifo level */
+
+    for (int i = 0; i < fifo_size / 2; i++) {
+        byte = 'A' + i;
+        g_assert_cmpuint(qio_channel_write(t->ioc, &byte, 1, &error_abort),
+                         ==, 1);
+    }
+
+    /* wait for the RXLVL to update */
+    WAIT_REG32_FIELD(1000, FLEXCOMM_USART, FIFOSTAT, RXLVL,
+                     fifo_size / 2);
+
+    /* check fifo stat */
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOSTAT, RXFULL),
+                     ==, 0);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOSTAT, RXNOTEMPTY),
+                     ==, 1);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOSTAT, TXNOTFULL),
+                     ==, 1);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOSTAT, TXEMPTY),
+                     ==, 1);
+
+    /* send until FIFO is full */
+    for (int i = fifo_size / 2; i < fifo_size; i++) {
+        byte = 'A' + i;
+        g_assert_cmpuint(qio_channel_write(t->ioc, &byte, 1, &error_abort),
+                         ==, 1);
+    }
+
+    /* wait for the RXLVL to update */
+    WAIT_REG32_FIELD(1000, FLEXCOMM_USART, FIFOSTAT, RXLVL, fifo_size);
+
+    /* check fifo stat */
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOSTAT, RXFULL),
+                     ==, 1);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOSTAT, RXNOTEMPTY),
+                     ==, 1);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOSTAT, TXNOTFULL),
+                     ==, 1);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOSTAT, TXEMPTY),
+                     ==, 1);
+
+    /* check read no pop */
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFORDNOPOP, RXDATA),
+                     ==, 'A');
+
+    /* now read from the fifo  */
+    for (int i = 0; i < fifo_size; i++) {
+        g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFORD, RXDATA),
+                         ==, 'A' + i);
+    }
+
+    /* check fifostat */
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOSTAT, RXFULL), ==, 0);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOSTAT, RXNOTEMPTY),
+                     ==, 0);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOSTAT, TXNOTFULL),
+                     ==, 1);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOSTAT, TXEMPTY),
+                     ==, 1);
+}
+
+static void irq_test(gconstpointer user_data)
+{
+    struct TestState *t = (struct TestState *)user_data;
+    char buf[256] = { 0, };
+    uint32_t tmp;
+    QDict *resp;
+
+    resp = qmp("{\"execute\": \"system_reset\"}");
+    qdict_unref(resp);
+
+    qtest_irq_intercept_out_named(t->qtest, DEVICE_NAME,
+                                  SYSBUS_DEVICE_GPIO_IRQ);
+
+    /* select and lock FLEXCOMM_USART */
+    tmp = FIELD_DP32(FLEXCOMM_PERSEL_USART, FLEXCOMM_PSELID, LOCK, 1);
+    REG32_WRITE(FLEXCOMM, PSELID, tmp);
+
+    /*
+     * set RX IRQ/DMA trigger level to 4 bytes - value 3 in FIFOTRIG
+     *
+     * 0000 - Trigger when the RX FIFO has received 1 entry (is no longer empty)
+     * 0001 - Trigger when the RX FIFO has received 2 entries
+     * 1111 - Trigger when the RX FIFO has received 16 entries (has become full)
+     */
+    REG32_WRITE_FIELD(FLEXCOMM_USART, FIFOTRIG, RXLVL, 3);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOTRIG, RXLVL),
+                     ==, 3);
+
+    /* enable RX trigger for IRQ/DMA  */
+    REG32_WRITE_FIELD(FLEXCOMM_USART, FIFOTRIG, RXLVLENA, 1);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOTRIG, RXLVLENA),
+                     ==, 1);
+
+    /* enable RXLVL interrupt */
+    REG32_WRITE_FIELD(FLEXCOMM_USART, FIFOINTENSET, RXLVL, 1);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOINTENSET, RXLVL),
+                     ==, 1);
+
+    /* enable FLEXCOMM_USART */
+    REG32_WRITE_FIELD(FLEXCOMM_USART, CFG, ENABLE, 1);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, CFG, ENABLE),
+                     ==, 1);
+
+    /* enable TX and RX FIFO */
+    REG32_WRITE_FIELD(FLEXCOMM_USART, FIFOCFG, ENABLETX, 1);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOCFG, ENABLETX),
+                     ==, 1);
+    REG32_WRITE_FIELD(FLEXCOMM_USART, FIFOCFG, ENABLERX, 1);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOCFG, ENABLERX),
+                     ==, 1);
+
+    /* check interrupt status */
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOINTSTAT, RXLVL),
+                     ==, 0);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOINTSTAT, TXLVL),
+                     ==, 0);
+    g_assert_false(get_irq(0));
+
+    /* enable TX trigger for IRQ/DMA  */
+    REG32_WRITE_FIELD(FLEXCOMM_USART, FIFOTRIG, TXLVLENA, 1);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOTRIG, TXLVLENA),
+                     ==, 1);
+
+    /* enable irq for TX */
+    REG32_WRITE_FIELD(FLEXCOMM_USART, FIFOINTENSET, TXLVL, 1);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOINTENSET, TXLVL),
+                     ==, 1);
+
+    /* check TX irq */
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOINTSTAT, TXLVL),
+                     ==, 1);
+    g_assert_true(get_irq(0));
+
+    /* disable irq for TX */
+    REG32_WRITE_FIELD(FLEXCOMM_USART, FIFOTRIG, TXLVLENA, 0);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOTRIG, TXLVLENA),
+                     ==, 0);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOINTSTAT, TXLVL),
+                     ==, 0);
+    g_assert_false(get_irq(0));
+
+    /* send 3 bytes */
+    g_assert_cmpuint(qio_channel_write(t->ioc, buf, 3, &error_abort),
+                     ==, 3);
+
+    /* check that we have 3 bytes in the fifo */
+    WAIT_REG32_FIELD(1000, FLEXCOMM_USART, FIFOSTAT, RXLVL, 3);
+
+    /* and no interrupt has been triggered yet */
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOINTSTAT, RXLVL),
+                     ==, 0);
+    g_assert_false(get_irq(0));
+
+    /* push it over the edge */
+    g_assert_cmpuint(qio_channel_write(t->ioc, buf, 1, &error_abort), ==, 1);
+
+    /* check that we have 4 bytes in the fifo */
+    WAIT_REG32_FIELD(1000, FLEXCOMM_USART, FIFOSTAT, RXLVL, 4);
+
+    /* and the interrupt has been triggered */
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOINTSTAT, RXLVL),
+                     ==, 1);
+    g_assert_true(get_irq(0));
+
+    /* read one byte from the fifo */
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFORD, RXDATA),
+                     ==, 0);
+
+    /* we should have 3 bytes in the FIFO */
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOSTAT, RXLVL),
+                     ==, 3);
+
+    /* and no interrupts active */
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_USART, FIFOINTSTAT, RXLVL),
+             ==, 0);
+    g_assert_false(get_irq(0));
+}
+
+static void close_ioc(void *ioc)
+{
+    qio_channel_close(ioc, NULL);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+    struct TestState test;
+    char *tmp_path = g_dir_make_tmp("qemu-flexcomm-usart-test.XXXXXX", NULL);
+    SocketAddress addr = {
+        .type = SOCKET_ADDRESS_TYPE_UNIX,
+        .u.q_unix.path = g_build_filename(tmp_path, "sock", NULL),
+    };
+    char *args;
+    QIOChannelSocket *lioc;
+
+    module_call_init(MODULE_INIT_QOM);
+    g_test_init(&argc, &argv, NULL);
+
+    lioc = qio_channel_socket_new();
+    qio_channel_socket_listen_sync(lioc, &addr, 1, &error_abort);
+
+    qtest_add_data_func("/flexcomm-usart/polling", &test, polling_test);
+    qtest_add_data_func("/flexcomm-usart/irq", &test, irq_test);
+
+    args = g_strdup_printf("-M rt595-evk "
+                           "-chardev socket,id=flexcomm0-usart,path=%s",
+                           addr.u.q_unix.path);
+    test.qtest = qtest_start(args);
+
+    qio_channel_wait(QIO_CHANNEL(lioc), G_IO_IN);
+    test.ioc = QIO_CHANNEL(qio_channel_socket_accept(lioc, &error_abort));
+    g_assert(test.ioc);
+    qtest_add_abrt_handler(close_ioc, test.ioc);
+
+    ret = g_test_run();
+
+    qtest_end();
+
+    qtest_remove_abrt_handler(test.ioc);
+    g_unlink(addr.u.q_unix.path);
+    g_free(addr.u.q_unix.path);
+    g_rmdir(tmp_path);
+    g_free(tmp_path);
+    g_free(args);
+    object_unref(OBJECT(test.ioc));
+    object_unref(OBJECT(lioc));
+
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index f35bb52aa2..c7a5bb61e9 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -233,7 +233,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
    config_all_devices.has_key('CONFIG_DM163')? ['dm163-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_FLEXCOMM')? ['flexcomm-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_FLEXCOMM') ? ['flexcomm-test', 'flexcomm-usart-test'] : []) + \
   ['arm-cpu-features',
    'boot-serial-test']
 
@@ -350,6 +350,7 @@ qtests = {
   'virtio-net-failover': files('migration-helpers.c'),
   'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
   'netdev-socket': files('netdev-socket.c', '../unit/socket-helpers.c'),
+  'flexcomm-usart-test': [io],
 }
 
 if vnc.found()
-- 
2.47.0.rc0.187.ge670bccf7e-goog


