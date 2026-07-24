Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39654C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 14:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnGRA-0002Q5-RJ; Fri, 24 Jul 2026 09:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1640586082@qq.com>)
 id 1wnGQy-0002JD-2s; Fri, 24 Jul 2026 09:59:36 -0400
Received: from out203-205-221-210.mail.qq.com ([203.205.221.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1640586082@qq.com>)
 id 1wnGQs-0003Qj-I0; Fri, 24 Jul 2026 09:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1784901558; bh=dTuPAVebZ+yGfLPswS25Mv6fDypXa5g/8sRuTXdQ5p4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=C+QZMoqej1uXMFJaJ/vyNqLK8Agil1YdRHRXZczOedoqjsuH4qo5zn5YQ+i2UjESO
 OramBXT14WLbwEUqUQk35DAm2Wq/SxEFlapA+E6qFWVZkfyWr9JVh4lwBcfyd8KsZV
 MvRwUbvdidORw5iZvJyRcl9kUdU/5RJpYgWfzG+o=
Received: from [127.0.1.1] ([240e:3bb:a98:9fe1:fbb4:4428:c3bc:a339])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id EC68C209; Fri, 24 Jul 2026 21:59:06 +0800
X-QQ-mid: xmsmtpt1784901555tjmbxq31z
Message-ID: <tencent_4F8C0FA306A477E8A9F195BF22F21BFA1F09@qq.com>
X-QQ-XMAILINFO: NIUDy+TY2wN0kf/pi73LI5IAmlR1n+bbq8mhx2ySxDeunE6y7bGjZpZYCYO7jZ
 sDRygZuoa/N4a0P0YSYBGbAcDTvI6aQygeIx4PqDKkMCAgfKHwizkqbAlvPsnj6bMROhbe++RgxS
 77BZseIVyWR/bUH+1HTOQXyZ6RLMgRgipp0+dDtJcggioRkCebh1hcdSfxL8jCw+1muc/my7WgI+
 if7DmaBB3RPbg3N8RIpAibGVg1R6h4lFJQVYkmklmnQVdb4PYVe1WdQQhssox2LRQymTMP1nvTSO
 /p7ED4SkF1ssRPBu0e2/trjfJNbN/gBtlip7B1KnWtLszQ2wO+tuU4YkrDyQ8bANWJtlBglhtj5V
 /XwnNZfqTElXCeJ46NwIQLT77RtC273bxIRdJepFhlIaSq2iYEtur+8uK13sfBqTdLciBmLt+w4k
 01RuPT2JI4fQXfojIv4nPgqfUmG4rbBOVFycirohX9N+5qbg1gqK7ANqDILdjBJm9U15SBEsWs7N
 jVMf8U83k5uZ5vzkGH++Lo7odBwsFG6rcgUZ2s69aMQgh6iOd5MRtQx+REbuyfbFYtiwh5HluLbk
 eWCooJRbMTw2BQwTvOnEyA0KluBfIEODSkVUSsF5nEZdSR7n93sypGn2a0t2i9/pCvvdZxUQ8MSF
 5qaksVClJ0u+18EyB5SmjwSYQJXnTlPNiGz6VOmMTtoSyPfYVERdPzqrk0m+BbUStc7DIj+pZACp
 2cbNxyaUxc1b667e0z+fDnfOJDw8dOrl4HK5FKDciV8CyVhkxdfLSFMgeqr8c0i/VTWaxlfhEk7K
 TjkkLoyyDKZjfkJ4u3nvQiTDkjhsHmex+7MhJXHw9uT3V9nE8iIrZE7VLXLcPJZHb6ImlxrG1MEo
 wECuGjJlzylA4X5o9g9CRLkJ9vEurF7UB0uxa5eJanvKpvrMyrvADWNAdmsXFbxyxaXFibYEkxFH
 Mf8b6YMAYrg6NTH2tQ7h2LNxllPJN4CQ4sshcH30InPFQv1Hnp70NnYN4eNBN7UTtwsSRgZ6buIA
 jLNgz2zm6KqRDXYFpp4ESqVI8YSuKq/ceNRdjLT4LTuOAR8AbPBTRck9X8OrMgvHUJhefdVp/jo1
 S/yYEGZPtkj6p8OxkIZ8ojKx56cgYANgloESW0qq4+3vv5FcrTyNqM3erwJ3SD/nrdUddb34kurF
 DBTlZfV5BxEDGYo9ohdAnkWGs8qv4ezpcdZe/A9IPVeSg2ww==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: zhenbaii <1640586082@qq.com>
Date: Fri, 24 Jul 2026 21:59:01 +0800
Subject: [PATCH 3/3] tests/qtest: add K230 UART test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-OQ-MSGID: <20260724-k230-uart-v2-v1-3-4c0657a703e5@qq.com>
References: <20260724-k230-uart-v2-v1-0-4c0657a703e5@qq.com>
In-Reply-To: <20260724-k230-uart-v2-v1-0-4c0657a703e5@qq.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 zhenbaii <1640586082@qq.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784901547; l=17690;
 i=1640586082@qq.com; s=20260721; h=from:subject:message-id;
 bh=8fls3Z9OByNuHOI8ctcrOfilygKU330A1Wk8FZMrVok=;
 b=muh88dmvGP6RwJXp53AYPJFzCUcUDAOQNo72wg7HsMD1ioDAL5AzicgLvgmaS5SMh1TpEHGS2
 +sln2y23jcED3UGytcUPp0HwpbyUE0Qjmp+vg/Eb3wA6jASQ4ziNPsR
X-Developer-Key: i=1640586082@qq.com; a=ed25519;
 pk=AjRy6i+I/zX9djX87K/xR2OQ2Myy7s7j7bDdi9Qz3zw=
Received-SPF: pass client-ip=203.205.221.210; envelope-from=1640586082@qq.com;
 helo=out203-205-221-210.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

8 functional-path test cases covering driver scenarios (device probe,
init & baud config, TX/RX datapath, THRE interrupt, RX interrupts,
error interrupts & IIR priority, busy detect & USR, advanced
features); all pass.

Signed-off-by: zhenbaii <1640586082@qq.com>
---
 tests/qtest/k230-uart-test.c | 514 +++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build      |   2 +-
 2 files changed, 515 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/k230-uart-test.c b/tests/qtest/k230-uart-test.c
new file mode 100644
index 0000000000000000000000000000000000000000..f85c690ebb57abb5b7f753f36c06c0900c3cfbb9
--- /dev/null
+++ b/tests/qtest/k230-uart-test.c
@@ -0,0 +1,514 @@
+/*
+ * QTest for the K230 UART — functional-path coverage.
+ *
+ * Tests are organised around driver usage scenarios rather than
+ * enumerating every register in isolation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include <string.h>
+
+#define UART_BASE  0x91400000
+#define R(off)     (UART_BASE + (off))
+
+/* register offsets */
+#define THR    0x00
+#define IER    0x04
+#define IIR    0x08
+#define LCR    0x0c
+#define MCR    0x10
+#define LSR    0x14
+#define SCR    0x1c
+#define USR    0x7c
+#define TFL    0x80
+#define RFL    0x84
+#define SRR    0x88
+#define SRTS   0x8c
+#define SBCR   0x90
+#define SDMAM  0x94
+#define SFE    0x98
+#define SRT    0x9c
+#define STET   0xa0
+#define HTX    0xa4
+#define CPR    0xf4
+#define CTR    0xfc
+
+/* bit fields */
+#define LCR_DLAB     0x80
+#define LCR_BC       0x40
+#define LCR_8N1      0x03
+
+#define LSR_DR       0x01
+#define LSR_OE       0x02
+#define LSR_THRE     0x20
+#define LSR_TEMT     0x40
+#define LSR_RESET    0x60
+
+#define IIR_IID      0x0f
+#define IIR_NONE     0x01
+#define IIR_THR      0x02
+#define IIR_RX       0x04
+#define IIR_LINE     0x06
+#define IIR_BUSY     0x07
+#define IIR_TO       0x0c
+#define IIR_FF       0xc0
+
+#define IER_RX       0x01
+#define IER_TX       0x02
+#define IER_LS       0x04
+#define IER_COLR     0x10
+#define IER_PTIME    0x80
+
+#define MCR_LB       0x10
+#define MCR_RTS      0x02
+
+#define FCR_FE       0x01
+#define FCR_RR       0x02
+#define FCR_XR       0x04
+#define FCR_TET_H    (3 << 4)
+#define FCR_RT_Q     (1 << 6)
+#define FCR_RT_F     (3 << 6)
+
+#define USR_BUSY     0x01
+#define USR_RESET    0x06
+
+#define SRR_UR       0x01
+#define SRR_RFR      0x02
+
+/* helpers */
+static uint32_t rd(QTestState *qts, uint32_t o)
+{
+    return qtest_readl(qts, R(o));
+}
+static uint32_t iid(QTestState *qts)
+{
+    return rd(qts, IIR) & IIR_IID;
+}
+
+static void poll_lsr(QTestState *qts, uint32_t m)
+{
+    int i;
+
+    for (i = 0; i < 1000; i++) {
+        if (rd(qts, LSR) & m) {
+            return;
+        }
+        g_usleep(1000);
+    }
+    g_assert_not_reached();
+}
+
+static void s1(QTestState *qts, int fd, char c)
+{
+    g_assert_cmpint(send(fd, &c, 1, 0), ==, 1);
+    poll_lsr(qts, LSR_DR);
+}
+
+static void sn(QTestState *qts, int fd, const char *d, int n)
+{
+    g_assert_cmpint(send(fd, d, n, 0), ==, n);
+    poll_lsr(qts, LSR_DR);
+}
+
+static void oe_nf(QTestState *qts, int fd)
+{
+    int i;
+
+    s1(qts, fd, 'A');
+    {
+        char c = 'B';
+        g_assert_cmpint(send(fd, &c, 1, 0), ==, 1);
+    }
+    for (i = 0; i < 200; i++) {
+        rd(qts, SCR);
+        g_usleep(1000);
+    }
+}
+
+/* 1. device probe */
+static void test_device_probe(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    uint32_t cpr = rd(qts, CPR);
+
+    g_assert_cmphex(cpr & 0x3, ==, 0x2);
+    g_assert_cmphex(cpr & (1 << 5), ==, (1 << 5));
+    g_assert_cmphex(cpr & (1 << 8), ==, (1 << 8));
+    g_assert_cmphex((cpr >> 16) & 0xff, ==, 0x2);
+    g_assert_cmphex(cpr & (1 << 4), ==, 0);
+    g_assert_cmphex(rd(qts, CTR), ==, 0x44570110);
+    g_assert_cmphex(rd(qts, LSR), ==, LSR_RESET);
+    g_assert_cmphex(rd(qts, USR), ==, USR_RESET);
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+    g_assert_cmphex(rd(qts, IIR) & IIR_FF, ==, 0);
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, 0);
+
+    qtest_writel(qts, R(IIR), FCR_FE);
+    g_assert_cmphex(rd(qts, IIR) & IIR_FF, ==, IIR_FF);
+    qtest_quit(qts);
+}
+
+/* 2. init & baud */
+static void test_init_and_baud(void)
+{
+    int fd;
+    QTestState *qts = qtest_init_with_serial("-machine k230", &fd);
+
+    qtest_writel(qts, R(LCR), LCR_DLAB);
+    qtest_writel(qts, R(THR), 0x55);
+    g_assert_cmphex(rd(qts, THR), ==, 0x55);
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    g_assert_cmphex(rd(qts, THR), ==, 0x00);
+
+    qtest_writel(qts, R(IIR), FCR_FE | FCR_RT_F);
+    qtest_writel(qts, R(IER), IER_RX);
+
+    /* divisor=1 -> timeout=12800ns */
+    qtest_writel(qts, R(LCR), LCR_8N1 | LCR_DLAB);
+    qtest_writel(qts, R(THR), 1); qtest_writel(qts, R(IER), 0);
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    s1(qts, fd, 'X');
+    qtest_clock_step(qts, 13000);
+    g_assert_cmphex(iid(qts), ==, IIR_TO);
+
+    /* divisor=100 -> timeout=1.28e6ns; 13000ns too short */
+    rd(qts, THR);
+    qtest_writel(qts, R(LCR), LCR_8N1 | LCR_DLAB);
+    qtest_writel(qts, R(THR), 100); qtest_writel(qts, R(IER), 0);
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    s1(qts, fd, 'Y');
+    qtest_clock_step(qts, 13000);
+    g_assert_cmphex(iid(qts), !=, IIR_TO);
+    qtest_clock_step(qts, 1300000);
+    g_assert_cmphex(iid(qts), ==, IIR_TO);
+
+    close(fd); qtest_quit(qts);
+}
+
+/* 3. TX / RX datapath */
+static void test_tx_rx_datapath(void)
+{
+    int fd;
+    QTestState *qts = qtest_init_with_serial("-machine k230", &fd);
+
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    g_assert_cmphex(rd(qts, LSR) & (LSR_THRE | LSR_TEMT),
+                    ==, LSR_THRE | LSR_TEMT);
+    qtest_writel(qts, R(THR), 'A');
+    g_assert_cmphex(rd(qts, LSR) & (LSR_THRE | LSR_TEMT),
+                    ==, LSR_THRE | LSR_TEMT);
+
+    /* external RX (FIFO mode) */
+    qtest_writel(qts, R(IIR), FCR_FE);
+    qtest_writel(qts, R(IER), IER_RX);
+    sn(qts, fd, "K230", 4);
+    for (int i = 0; i < 4; i++) {
+        if (i < 3) {
+            g_assert_cmphex(iid(qts), ==, IIR_RX);
+        }
+        g_assert_cmphex(rd(qts, THR), ==, "K230"[i]);
+    }
+    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, 0);
+
+    /* loopback */
+    qtest_writel(qts, R(MCR), MCR_LB);
+    qtest_writel(qts, R(THR), 'L');
+    g_assert_cmphex(rd(qts, THR), ==, 'L');
+    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, 0);
+
+    /* no loopback */
+    qtest_writel(qts, R(MCR), 0);
+    qtest_writel(qts, R(THR), 'Z');
+    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, 0);
+
+    /* TFL / RFL */
+    qtest_writel(qts, R(MCR), MCR_LB);
+    qtest_writel(qts, R(IIR), FCR_FE | FCR_RR | FCR_XR);
+    qtest_writel(qts, R(THR), 'X'); qtest_writel(qts, R(THR), 'Y');
+    g_assert_cmphex(rd(qts, TFL), ==, 0);
+    g_assert_cmphex(rd(qts, RFL), ==, 2);
+
+    /* non-FIFO mode */
+    qtest_writel(qts, R(MCR), 0);
+    qtest_writel(qts, R(IIR), 0);
+    s1(qts, fd, 'N');
+    g_assert_cmphex(rd(qts, THR), ==, 'N');
+    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, 0);
+
+    /* non-FIFO overrun */
+    int i;
+    s1(qts, fd, 'n');
+    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, LSR_DR);
+    {
+        char c = 'o';
+        send(fd, &c, 1, 0);
+    }
+    for (i = 0; i < 200; i++) {
+        rd(qts, SCR);
+        g_usleep(1000);
+    }
+    g_assert_cmphex(rd(qts, LSR) & LSR_OE, ==, LSR_OE);
+
+    close(fd); qtest_quit(qts);
+}
+
+/* 4. THRE interrupt */
+static void test_thre_interrupt(void)
+{
+    QTestState *qts = qtest_init("-machine k230 "
+                                 "-chardev null,id=c0 -serial chardev:c0");
+    qtest_writel(qts, R(LCR), LCR_8N1);
+
+    qtest_writel(qts, R(THR), 'A');
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+
+    qtest_writel(qts, R(IER), IER_TX);
+    g_assert_cmphex(iid(qts), ==, IIR_THR);
+
+    qtest_writel(qts, R(THR), 'B');
+    g_assert_cmphex(iid(qts), ==, IIR_THR);
+
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+    qtest_quit(qts);
+}
+
+/* 5. RX interrupts: timeout & trigger level */
+static void test_rx_interrupts(void)
+{
+    int fd;
+    QTestState *qts = qtest_init_with_serial("-machine k230", &fd);
+
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    qtest_writel(qts, R(IIR), FCR_FE | FCR_RT_F);
+    qtest_writel(qts, R(IER), IER_RX);
+
+    /* basic timeout */
+    s1(qts, fd, 'T');
+    qtest_clock_step(qts, 400000);
+    g_assert_cmphex(iid(qts), ==, IIR_TO);
+    g_assert_cmphex(rd(qts, THR), ==, 'T');
+    g_assert_cmphex(iid(qts), !=, IIR_TO);
+
+    /* timeout reset by new byte */
+    s1(qts, fd, 'A'); qtest_clock_step(qts, 200000);
+    s1(qts, fd, 'B');
+    qtest_clock_step(qts, 200000);
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+    qtest_clock_step(qts, 200000);
+    g_assert_cmphex(iid(qts), ==, IIR_TO);
+    rd(qts, THR);
+    rd(qts, THR);
+
+    /* timeout rearmed by partial drain */
+    s1(qts, fd, 'X');
+    s1(qts, fd, 'Y');
+    qtest_clock_step(qts, 400000);
+    g_assert_cmphex(iid(qts), ==, IIR_TO);
+    g_assert_cmphex(rd(qts, THR), ==, 'X');
+    qtest_clock_step(qts, 200000);
+    g_assert_cmphex(iid(qts), !=, IIR_TO);
+    qtest_clock_step(qts, 250000);
+    g_assert_cmphex(iid(qts), ==, IIR_TO);
+    g_assert_cmphex(rd(qts, THR), ==, 'Y');
+
+    /* RX trigger level: RT=Q -> trigger at 8 bytes */
+    qtest_writel(qts, R(IIR), FCR_FE | FCR_RT_Q);
+    sn(qts, fd, "ABCDEFG", 7);
+    g_usleep(20000);
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+    qtest_clock_step(qts, 400000);
+    g_assert_cmphex(iid(qts), ==, IIR_TO);
+    for (int i = 0; i < 7; i++) {
+        rd(qts, THR);
+    }
+
+    sn(qts, fd, "12345678", 8);
+    for (int i = 0; i < 1000; i++) {
+        if (iid(qts) == IIR_RX) {
+            break;
+        }
+        g_usleep(1000);
+    }
+    g_assert_cmphex(iid(qts), ==, IIR_RX);
+
+    close(fd); qtest_quit(qts);
+}
+
+/* 6. error interrupts & IIR priority */
+static void test_error_interrupts(void)
+{
+    int fd;
+    QTestState *qts = qtest_init_with_serial("-machine k230", &fd);
+
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    qtest_writel(qts, R(IER), IER_LS);
+
+    /* OE -> IIR=0x6; LSR clears; ELCOLR=0: RBR clears; ELCOLR=1: RBR keeps */
+    oe_nf(qts, fd);
+    g_assert_cmphex(iid(qts), ==, IIR_LINE);
+    rd(qts, LSR);
+    g_assert_cmphex(iid(qts), !=, IIR_LINE);
+
+    oe_nf(qts, fd);
+    g_assert_cmphex(iid(qts), ==, IIR_LINE);
+    rd(qts, THR);
+    g_assert_cmphex(iid(qts), !=, IIR_LINE);
+
+    qtest_writel(qts, R(IER), IER_LS | IER_COLR);
+    oe_nf(qts, fd);
+    g_assert_cmphex(iid(qts), ==, IIR_LINE);
+    rd(qts, THR);
+    g_assert_cmphex(iid(qts), ==, IIR_LINE);
+    rd(qts, LSR);
+    g_assert_cmphex(iid(qts), !=, IIR_LINE);
+
+    /* IIR priority: RX > TX (loopback) */
+    qtest_writel(qts, R(IIR), FCR_FE);
+    qtest_writel(qts, R(MCR), MCR_LB);
+    qtest_writel(qts, R(IER), IER_TX | IER_RX);
+    qtest_writel(qts, R(THR), 'P');
+    g_assert_cmphex(iid(qts), ==, IIR_RX);
+    g_assert_cmphex(rd(qts, THR), ==, 'P');
+    g_assert_cmphex(iid(qts), ==, IIR_THR);
+    iid(qts);
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+
+    /* OE in FIFO mode via loopback */
+    qtest_writel(qts, R(IER), IER_LS);
+    for (int i = 0; i < 32; i++) {
+        qtest_writel(qts, R(THR), 'a');
+    }
+    g_assert_cmphex(rd(qts, LSR) & LSR_OE, ==, 0);
+    qtest_writel(qts, R(THR), 'z');
+    g_assert_cmphex(iid(qts), ==, IIR_LINE);
+    g_assert_cmphex(rd(qts, LSR) & LSR_OE, ==, LSR_OE);
+
+    close(fd); qtest_quit(qts);
+}
+
+/* 7. USR & busy detect */
+static void test_busy_detect(void)
+{
+    int fd;
+    QTestState *qts = qtest_init_with_serial("-machine k230", &fd);
+
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    qtest_writel(qts, R(IIR), FCR_FE);
+
+    g_assert_cmphex(rd(qts, USR) & 0x1e, ==, 0x06);
+
+    qtest_writel(qts, R(MCR), MCR_LB);
+    qtest_writel(qts, R(THR), 'A');
+    g_assert_cmphex(rd(qts, USR) & 0x08, ==, 0x08);
+    rd(qts, THR);
+    g_assert_cmphex(rd(qts, USR) & 0x08, ==, 0);
+    qtest_writel(qts, R(MCR), 0);
+
+    /* BUSY via RX & loopback */
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, 0);
+    s1(qts, fd, 'Z');
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, USR_BUSY);
+    rd(qts, THR);
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, 0);
+
+    qtest_writel(qts, R(MCR), MCR_LB);
+    qtest_writel(qts, R(THR), 'L');
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, USR_BUSY);
+    rd(qts, THR);
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, 0);
+
+    /* busy-detect: LCR write rejected while BUSY=1 */
+    qtest_writel(qts, R(MCR), 0);
+    qtest_writel(qts, R(IIR), FCR_FE | FCR_RR | FCR_XR);
+    s1(qts, fd, 'B');
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, USR_BUSY);
+    qtest_writel(qts, R(LCR), LCR_8N1 | LCR_DLAB);
+    g_assert_cmphex(rd(qts, LCR), ==, LCR_8N1);
+    g_assert_cmphex(iid(qts), ==, IIR_BUSY);
+    rd(qts, USR);
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+    qtest_writel(qts, R(IIR), FCR_FE | FCR_RR);
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, 0);
+    qtest_writel(qts, R(LCR), LCR_8N1 | LCR_DLAB);
+    g_assert_cmphex(rd(qts, LCR), ==, LCR_8N1 | LCR_DLAB);
+
+    close(fd); qtest_quit(qts);
+}
+
+/* 8. advanced features */
+static void test_advanced_features(void)
+{
+    QTestState *qts = qtest_init("-machine k230 "
+                                 "-chardev null,id=c0 -serial chardev:c0");
+
+    /* shadow: SRTS<->MCR.RTS, SBCR<->LCR.BC, SDMAM, SFE, SRT, STET, HTX */
+    qtest_writel(qts, R(SRTS), 1);
+    g_assert_cmphex(rd(qts, MCR) & MCR_RTS, ==, MCR_RTS);
+    qtest_writel(qts, R(MCR), 0); g_assert_cmphex(rd(qts, SRTS), ==, 0);
+    qtest_writel(qts, R(SBCR), 1);
+    g_assert_cmphex(rd(qts, LCR) & LCR_BC, ==, LCR_BC);
+    qtest_writel(qts, R(LCR), 0); g_assert_cmphex(rd(qts, SBCR), ==, 0);
+    qtest_writel(qts, R(SDMAM), 1); g_assert_cmphex(rd(qts, SDMAM), ==, 1);
+    qtest_writel(qts, R(SRT), 0x2); g_assert_cmphex(rd(qts, SRT), ==, 0x2);
+    qtest_writel(qts, R(STET), 0x3); g_assert_cmphex(rd(qts, STET), ==, 0x3);
+    qtest_writel(qts, R(SFE), 1); g_assert_cmphex(rd(qts, SFE), ==, 1);
+    g_assert_cmphex(rd(qts, IIR) & IIR_FF, ==, IIR_FF);
+    qtest_writel(qts, R(HTX), 1); g_assert_cmphex(rd(qts, HTX), ==, 1);
+    qtest_writel(qts, R(HTX), 0); g_assert_cmphex(rd(qts, HTX), ==, 0);
+
+    /* HTX halt TX */
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    qtest_writel(qts, R(IIR), FCR_FE);
+    qtest_writel(qts, R(MCR), MCR_LB);
+
+    qtest_writel(qts, R(HTX), 1);
+    qtest_writel(qts, R(THR), 'H');
+    g_assert_cmphex(rd(qts, TFL), ==, 1);
+    g_assert_cmphex(rd(qts, RFL), ==, 0);
+
+    qtest_writel(qts, R(HTX), 0);
+    g_assert_cmphex(rd(qts, TFL), ==, 0);
+    g_assert_cmphex(rd(qts, RFL), ==, 1);
+    g_assert_cmphex(rd(qts, THR), ==, 'H');
+
+    /* SRR: RFR & UR */
+    qtest_writel(qts, R(THR), 'Z');
+    g_assert_cmphex(rd(qts, RFL), ==, 1);
+    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, LSR_DR);
+    qtest_writel(qts, R(SRR), SRR_RFR);
+    g_assert_cmphex(rd(qts, RFL), ==, 0);
+    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, 0);
+    g_assert_cmphex(rd(qts, SRR), ==, 0);
+    qtest_writel(qts, R(THR), 'Y');
+    qtest_writel(qts, R(SRR), SRR_UR);
+    g_assert_cmphex(rd(qts, LSR), ==, LSR_RESET);
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+    g_assert_cmphex(rd(qts, RFL), ==, 0);
+
+    /* PTIME + TET programmable THRE */
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    qtest_writel(qts, R(IIR), FCR_FE | FCR_TET_H);
+    qtest_writel(qts, R(IER), IER_TX | IER_PTIME);
+    qtest_writel(qts, R(THR), 'A');
+    g_assert_cmphex(rd(qts, LSR) & LSR_THRE, ==, LSR_THRE);
+    g_assert_cmphex(iid(qts), ==, IIR_THR);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/k230-uart/device_probe",       test_device_probe);
+    qtest_add_func("/k230-uart/init_and_baud",      test_init_and_baud);
+    qtest_add_func("/k230-uart/tx_rx_datapath",     test_tx_rx_datapath);
+    qtest_add_func("/k230-uart/thre_interrupt",     test_thre_interrupt);
+    qtest_add_func("/k230-uart/rx_interrupts",      test_rx_interrupts);
+    qtest_add_func("/k230-uart/error_interrupts",   test_error_interrupts);
+    qtest_add_func("/k230-uart/busy_detect",        test_busy_detect);
+    qtest_add_func("/k230-uart/advanced_features",  test_advanced_features);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 822e0bd286970339fe28127649feb131ce8a81b2..93246d9bf77206e9cebb9d8ade5801f4541d3b8d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -294,7 +294,7 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test', 'k230-uart-test'] : [])
 
 qtests_hexagon = ['boot-serial-test']
 

-- 
2.48.1


