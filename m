Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DFDC47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 19:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT5cq-00026G-AH; Thu, 25 Jan 2024 14:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3v7myZQwKCjIbOPWVSghSTObUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--nabihestefan.bounces.google.com>)
 id 1rT5cp-000260-8c
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:42:59 -0500
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3v7myZQwKCjIbOPWVSghSTObUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--nabihestefan.bounces.google.com>)
 id 1rT5cn-0005C9-C1
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:42:58 -0500
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dc223d528cfso11075674276.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 11:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1706211775; x=1706816575; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=3jTjlGeBBnuwDYuzvWta2GuhroHiwZcZMqWvUdPq+UQ=;
 b=dHd15xJWfejewV5KKIw7+Swx0ZvbVkCct6jvRu6PrA1C2kA4tK9aln2GiSqyVLq/QR
 5B6iZm90zegEIaJj7tRv2rTb0mfCf1FLLt6ID8xYlHhq1VrADVjnuQ0jhsNVxUSxuzbZ
 fIJkXIROiFmagv4NAEQbRObDKXYUsIgF5r2MLPiyHNhsrdndeNSXPyD0u1S5sjeLc3Vp
 Mdek3rLXcpe9mxW1xa20Jig073s4g8rgWmdnDH55pdJPApjlnLxgGIc6ZDqqTNDiT5pY
 9ZY2eNU8lhFoAeOdNmMJ3H6i+sE7qr3YERF+RrQhOZ7EUxE/goSwRXXRnJzURk3ZeDj/
 i/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706211775; x=1706816575;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3jTjlGeBBnuwDYuzvWta2GuhroHiwZcZMqWvUdPq+UQ=;
 b=VOLDLw6xEZWwNJs9Hy2ejvAuCo6s+I2iC0prOqYTOmCprJcvAgtcU2MPoqvo/ad3jW
 DAfEXf4/kPrY19T0F3TdtVJaOZ+E6JWtOyr0I6vZzgM6qWwI7k+OjOtE5HYNzsI0S/U7
 F2cfejU478Sm6Qq6H/lWTgCvbJaW/d4P7XD/+jPoBCzICuCcQer0FwnjoZ/CeJk0A+hT
 TLhmH+sJW1xTeU8ZVCQI6dJRvZeAauYZfFOCKE4EwzEOu2UdMLifTnQDHNP0MuiSPjiN
 pMp7lMQP5x57fe7yKJNkMaBY3IW0OHYoGfDWWsfrKhQhognCryuEF4LvW+y/zodTVclv
 sy0A==
X-Gm-Message-State: AOJu0Yzbhs7P9ewgj5JIwX2XmPuN6zOEDhY3o/gtzTO3wB1VOZjDl0V9
 Do/BFP2/XwTMxcIFCdgJO753QsE9j9WPh5cg53+TGz5dhJwOYKtcjkj4Vi/MDnZ/9K5czGAwVcz
 i78DIqXKqU+sH4Kt5Ar2OGHlNCQ==
X-Google-Smtp-Source: AGHT+IHLMa7Hjzbb5oVnfoSVlX2U5lH8ds08kJ+k7noxiAQreEF17vztuEyd1pA4G8qcQOshlKsybmBGCX25Xpauw+Y=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:cc5:b0:dc2:5510:4a55 with
 SMTP id cq5-20020a0569020cc500b00dc255104a55mr161337ybb.11.1706211775012;
 Thu, 25 Jan 2024 11:42:55 -0800 (PST)
Date: Thu, 25 Jan 2024 19:42:41 +0000
In-Reply-To: <20240125194247.1589037-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240125194247.1589037-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125194247.1589037-4-nabihestefan@google.com>
Subject: [PATCH v15 3/9] hw/misc: Add qtest for NPCM7xx PCI Mailbox
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3v7myZQwKCjIbOPWVSghSTObUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb49.google.com
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

From: Hao Wu <wuhaotsh@google.com>

This patches adds a qtest for NPCM7XX PCI Mailbox module.
It sends read and write requests to the module, and verifies that
the module contains the correct data after the requests.

Change-Id: I2e1dbaecf8be9ec7eab55cb54f7fdeb0715b8275
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
---
 tests/qtest/meson.build             |   1 +
 tests/qtest/npcm7xx_pci_mbox-test.c | 242 ++++++++++++++++++++++++++++
 2 files changed, 243 insertions(+)
 create mode 100644 tests/qtest/npcm7xx_pci_mbox-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index d22434b14e..101f9c219e 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -185,6 +185,7 @@ qtests_sparc64 = \
 qtests_npcm7xx = \
   ['npcm7xx_adc-test',
    'npcm7xx_gpio-test',
+   'npcm7xx_pci_mbox-test',
    'npcm7xx_pwm-test',
    'npcm7xx_rng-test',
    'npcm7xx_sdhci-test',
diff --git a/tests/qtest/npcm7xx_pci_mbox-test.c b/tests/qtest/npcm7xx_pci_mbox-test.c
new file mode 100644
index 0000000000..56103df2a8
--- /dev/null
+++ b/tests/qtest/npcm7xx_pci_mbox-test.c
@@ -0,0 +1,242 @@
+/*
+ * QTests for Nuvoton NPCM7xx PCI Mailbox Modules.
+ *
+ * Copyright 2024 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qnum.h"
+#include "libqtest-single.h"
+
+#define PCI_MBOX_BA         0xf0848000
+#define PCI_MBOX_IRQ        8
+
+/* register offset */
+#define PCI_MBOX_STAT       0x00
+#define PCI_MBOX_CTL        0x04
+#define PCI_MBOX_CMD        0x08
+
+#define CODE_OK             0x00
+#define CODE_INVALID_OP     0xa0
+#define CODE_INVALID_SIZE   0xa1
+#define CODE_ERROR          0xff
+
+#define OP_READ             0x01
+#define OP_WRITE            0x02
+#define OP_INVALID          0x41
+
+
+static int sock;
+static int fd;
+
+/*
+ * Create a local TCP socket with any port, then save off the port we got.
+ */
+static in_port_t open_socket(void)
+{
+    struct sockaddr_in myaddr;
+    socklen_t addrlen;
+
+    myaddr.sin_family = AF_INET;
+    myaddr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+    myaddr.sin_port = 0;
+    sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+    g_assert(sock != -1);
+    g_assert(bind(sock, (struct sockaddr *) &myaddr, sizeof(myaddr)) != -1);
+    addrlen = sizeof(myaddr);
+    g_assert(getsockname(sock, (struct sockaddr *) &myaddr , &addrlen) != -1);
+    g_assert(listen(sock, 1) != -1);
+    return ntohs(myaddr.sin_port);
+}
+
+static void setup_fd(void)
+{
+    fd_set readfds;
+
+    FD_ZERO(&readfds);
+    FD_SET(sock, &readfds);
+    g_assert(select(sock + 1, &readfds, NULL, NULL, NULL) == 1);
+
+    fd = accept(sock, NULL, 0);
+    g_assert(fd >= 0);
+}
+
+static uint8_t read_response(uint8_t *buf, size_t len)
+{
+    uint8_t code;
+    ssize_t ret = read(fd, &code, 1);
+
+    if (ret == -1) {
+        return CODE_ERROR;
+    }
+    if (code != CODE_OK) {
+        return code;
+    }
+    g_test_message("response code: %x", code);
+    if (len > 0) {
+        ret = read(fd, buf, len);
+        if (ret < len) {
+            return CODE_ERROR;
+        }
+    }
+    return CODE_OK;
+}
+
+static void receive_data(uint64_t offset, uint8_t *buf, size_t len)
+{
+    uint8_t op = OP_READ;
+    uint8_t code;
+    ssize_t rv;
+
+    while (len > 0) {
+        uint8_t size;
+        uint8_t offset_bytes[8];
+
+        if (len >= 8) {
+            size = 8;
+        } else if (len >= 4) {
+            size = 4;
+        } else if (len >= 2) {
+            size = 2;
+        } else {
+            size = 1;
+        }
+
+        g_test_message("receiving %u bytes", size);
+        /* Write op */
+        rv = write(fd, &op, 1);
+        g_assert_cmpint(rv, ==, 1);
+        /* Write offset */
+        stq_le_p(offset_bytes, offset);
+        rv = write(fd, offset_bytes, sizeof(uint64_t));
+        g_assert_cmpint(rv, ==, sizeof(uint64_t));
+        /* Write size */
+        g_assert_cmpint(write(fd, &size, 1), ==, 1);
+
+        /* Read data and Expect response */
+        code = read_response(buf, size);
+        g_assert_cmphex(code, ==, CODE_OK);
+
+        buf += size;
+        offset += size;
+        len -= size;
+    }
+}
+
+static void send_data(uint64_t offset, const uint8_t *buf, size_t len)
+{
+    uint8_t op = OP_WRITE;
+    uint8_t code;
+    ssize_t rv;
+
+    while (len > 0) {
+        uint8_t size;
+        uint8_t offset_bytes[8];
+
+        if (len >= 8) {
+            size = 8;
+        } else if (len >= 4) {
+            size = 4;
+        } else if (len >= 2) {
+            size = 2;
+        } else {
+            size = 1;
+        }
+
+        g_test_message("sending %u bytes", size);
+        /* Write op */
+        rv = write(fd, &op, 1);
+        g_assert_cmpint(rv, ==, 1);
+        /* Write offset */
+        stq_le_p(offset_bytes, offset);
+        rv = write(fd, offset_bytes, sizeof(uint64_t));
+        g_assert_cmpint(rv, ==, sizeof(uint64_t));
+        /* Write size */
+        g_assert_cmpint(write(fd, &size, 1), ==, 1);
+        /* Write data */
+        g_assert_cmpint(write(fd, buf, size), ==, size);
+
+        /* Expect response */
+        code = read_response(NULL, 0);
+        g_assert_cmphex(code, ==, CODE_OK);
+
+        buf += size;
+        offset += size;
+        len -= size;
+    }
+}
+
+static void test_invalid_op(void)
+{
+    uint8_t op = OP_INVALID;
+    uint8_t code;
+    uint8_t buf[1];
+
+    g_assert_cmpint(write(fd, &op, 1), ==, 1);
+    code = read_response(buf, 1);
+    g_assert_cmphex(code, ==, CODE_INVALID_OP);
+}
+
+/* Send data via chardev and read them in guest. */
+static void test_guest_read(void)
+{
+    const char *data = "Hello World!";
+    uint64_t offset = 0xa0;
+    char buf[100];
+    size_t len = strlen(data);
+
+    send_data(offset, (uint8_t *)data, len);
+    memread(PCI_MBOX_BA + offset, buf, len);
+    g_assert_cmpint(strncmp(data, buf, len), ==, 0);
+}
+
+/* Write data in guest and read out via chardev. */
+static void test_guest_write(void)
+{
+    const char *data = "Hello World!";
+    uint64_t offset = 0xa0;
+    char buf[100];
+    size_t len = strlen(data);
+
+    memwrite(PCI_MBOX_BA + offset, data, len);
+    receive_data(offset, (uint8_t *)buf, len);
+    g_assert_cmpint(strncmp(data, buf, len), ==, 0);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+    int port;
+
+    g_test_init(&argc, &argv, NULL);
+    port = open_socket();
+    g_test_message("port=%d", port);
+    global_qtest = qtest_initf("-machine npcm750-evb "
+        "-chardev socket,id=npcm7xx-pcimbox-chr,host=localhost,"
+        "port=%d,reconnect=10 "
+        "-global driver=npcm7xx-pci-mbox,property=chardev,"
+        "value=npcm7xx-pcimbox-chr",
+        port);
+    setup_fd();
+    qtest_irq_intercept_in(global_qtest, "/machine/soc/a9mpcore/gic");
+
+    qtest_add_func("/npcm7xx_pci_mbox/invalid_op", test_invalid_op);
+    qtest_add_func("/npcm7xx_pci_mbox/read", test_guest_read);
+    qtest_add_func("/npcm7xx_pci_mbox/write", test_guest_write);
+    ret = g_test_run();
+    qtest_quit(global_qtest);
+
+    return ret;
+}
-- 
2.43.0.429.g432eaa2c6b-goog


