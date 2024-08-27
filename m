Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06442C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 06:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sipyV-0005EQ-1I; Tue, 27 Aug 2024 02:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3K3bNZgUKCoo7o9w3u22uzs.q204s08-rs9sz121u18.25u@flex--tavip.bounces.google.com>)
 id 1sipyM-0004Vg-74
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:46:34 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3K3bNZgUKCoo7o9w3u22uzs.q204s08-rs9sz121u18.25u@flex--tavip.bounces.google.com>)
 id 1sipyH-0006Aq-Bv
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:46:33 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2d3baf38457so5476091a91.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 23:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1724741164; x=1725345964; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=nzZ2KnsiXCcZkyOJnrOVWGo3C4OfA+YJL0LECFuxCWc=;
 b=lH1ptgUatpap0wK6CW0JEo8vE+gs25Zc6bz+KUdLbCGeAcNek3R84heutXWNXHmJmI
 6lL4TzXlzhiz9j/rrdixVl3gCS8aq3onExkOS2zhMbz+CNWsLGMLtgNgs5Z9TwIJvpmx
 5/e2CxlZ5ZA1ELNigDT3d3AZvEAsOQnr22UwYutNJj08ywE+JT1QmZZX0BQhkcjmQrIB
 TDn/sLSAgg8Ck2ZBcleZ7EWJwe6tflqnA51pdwE//MYyNjYQ4NQ7BxPzc9DU6V534UrR
 USBFEZhEAFLG7+T8YN+zqCaShSW7ZNbreW8zWafuicJhKhnHY+7YqW9o/CFzdVVo48QV
 WDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724741164; x=1725345964;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nzZ2KnsiXCcZkyOJnrOVWGo3C4OfA+YJL0LECFuxCWc=;
 b=juoOfbAdA2lmqnQ0So4ULG7jb83+AcqtUzc5asCNirLFaQVC2S8/eVj7z3kMAJkZSZ
 qDopiZe+vkW0c6M4P0S/lI79trhDl9EJczj7LuqUqEhsYUcNwhOfiOEE7BecYgqx9SN1
 p9UgvrnsE1uMXI9UStFaxtNMZd017oUX4DGjivexCyt3WGlFfnGC4aKjwPNBVPIOLTHH
 MNmF9B/QoWjS2YhDRQsc1/NcrF82u8rZ0GcIbqyCkQbJuqhp8C+sog1tCHu4rZJ+2Aa2
 wYwPqWpp0jTfnqoUgHQwCtpFfIMD0FGP1BuzL1SN8fu5gqd+RWQLCtvyOwLH3mhi3LDp
 7PSA==
X-Gm-Message-State: AOJu0YxgnUAixHRiRaXD6ai1gheEnSBbKp8m643nbeJqYzJWGXd1SphC
 cC8k3o7JUtPgw602c/OsmXtxgBjUgiUFicPDlk4Nidh0sBNcM2RTU+XbdOfAQ1E2LzTDaOiqPM4
 aPlXs+2jRRjQV1H0oLH1NYRA+gghobP2ptgiETQGuhUpx3YUtyPzgGp3NIrxIdFvTafFkYPeZmR
 M8hGwlls2vYgYMxI6/Iwee70VuFw==
X-Google-Smtp-Source: AGHT+IES8SnQ1CnDTxVYYdu4KChYObJLgTvyj3eTGOSw8lDW/WnNccSbtED9/99ZwOVPueVxWYHw7625Kg==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:90b:1e11:b0:2d1:b718:fc5f
 with SMTP id
 98e67ed59e1d1-2d8249ded2emr34546a91.1.1724741163229; Mon, 26 Aug 2024
 23:46:03 -0700 (PDT)
Date: Mon, 26 Aug 2024 23:45:21 -0700
In-Reply-To: <20240827064529.1246786-1-tavip@google.com>
Mime-Version: 1.0
References: <20240827064529.1246786-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827064529.1246786-18-tavip@google.com>
Subject: [RFC PATCH v3 17/24] tests/qtest: add flexcomm usart tests
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3K3bNZgUKCoo7o9w3u22uzs.q204s08-rs9sz121u18.25u@flex--tavip.bounces.google.com;
 helo=mail-pj1-x104a.google.com
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

Add flexcomm usart polling and irq unit tests.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/qtest/flexcomm-usart-test.c | 314 ++++++++++++++++++++++++++++++
 tests/qtest/meson.build           |   3 +-
 2 files changed, 316 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/flexcomm-usart-test.c

diff --git a/tests/qtest/flexcomm-usart-test.c b/tests/qtest/flexcomm-usart-test.c
new file mode 100644
index 0000000000..cb6b3c24b9
--- /dev/null
+++ b/tests/qtest/flexcomm-usart-test.c
@@ -0,0 +1,314 @@
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
+    args = g_strdup_printf("-M rt595-evk -chardev socket,id=flexcomm0,path=%s",
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
index 9631b6c401..93d1f781bc 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -229,7 +229,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
    config_all_devices.has_key('CONFIG_DM163')? ['dm163-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_FLEXCOMM')? ['flexcomm-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_FLEXCOMM') ? ['flexcomm-test', 'flexcomm-usart-test'] : []) + \
   ['arm-cpu-features',
    'boot-serial-test']
 
@@ -344,6 +344,7 @@ qtests = {
   'virtio-net-failover': files('migration-helpers.c'),
   'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
   'netdev-socket': files('netdev-socket.c', '../unit/socket-helpers.c'),
+  'flexcomm-usart-test': [io],
 }
 
 if vnc.found()
-- 
2.46.0.295.g3b9ea8a38a-goog


