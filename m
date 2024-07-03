Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7912BC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 09:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOwAe-00070N-PE; Wed, 03 Jul 2024 05:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOwAY-0006xJ-Op; Wed, 03 Jul 2024 05:20:55 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOwAV-0000f7-KL; Wed, 03 Jul 2024 05:20:53 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-718b714d362so2881559a12.0; 
 Wed, 03 Jul 2024 02:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719998450; x=1720603250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hVHNsl9b3skdVGNnNugzAYW9elI3JbTRFQEEYf405t8=;
 b=AohNcNnpoGek8eYQJDpgdYcRkBcW/rRY8FhQ6tBB7v3cWYKxRdfaB9Dv9ZOwVzw863
 4eKnjG0AABaOzxYF9z38E4DeqeD5W+P93dBPXLlQwEoBbCWQBESNIpI+k1neAFa0lN8i
 MdJaMNyNUVGgqiCuOeGMXowa8yWC9XQvQ3d58Fd+aDBlH7aCjgCfUiX2d1WBMpRET0bJ
 beP863vkE4SpgSWflQj+6DUJtruL8+AnkER8cOR3TRzm4FX1YT81HJtVL5TLaDtn4eeM
 Am4u3Q1II6eLnr+aawD+WsD9PaIRZSC/Xknq4HrUwb9puKdgy7ydUFofOVgPaQ2GkPnD
 49ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719998450; x=1720603250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hVHNsl9b3skdVGNnNugzAYW9elI3JbTRFQEEYf405t8=;
 b=YZWokGVqWxbiFXp8MTOlShJUXAW2rimn+9MUfma5o96BiBsitfokt39XwNiUMo5WAS
 MxiBYZWh+IRkfthEEYBlH+pO/mnn4bMXQvwd8dG3VpFsEXLrewjWobR4fm7y3jiYozkq
 OGHFD3m/mWCcfAkJHfAlMinvTQxOtjoUw5a+Y6CWZA6ZAw4UduTPOZZraNqPXdNkCXW/
 c7WOQOUB5HxdUI1T5h2aadQQkq5d7HiL2fUuM18KTvTR3K5WMwf/k2Iv7lW/IM2yTyb8
 KTS+JW3f584d0cja4FfGFwaNwJUfm0eofHzZsEpNIzf7IygRVh8FlNZlqsOVQ1kasjmd
 MNmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEMhq3UeSZYySeodLSfyyt7TkAboFNK7x9wYfwPdJH7pUMOagim/bMwV2xUk9v2QjYfaQ+ZsY3LEDQDSzPL9fXxVivQRl8j7NhzHIq0jotUIRI/ldNWYMxmuW8JQ==
X-Gm-Message-State: AOJu0YwCSC9BViHSW5dq8hNnfV7T2akLzwxL9TrGzcOMCi4i2rtHEJAm
 ynFxFuGQjPl0SmWbvUF1BuC7epa/3MSzkmt1VX6mZmmAuEIwQoGA
X-Google-Smtp-Source: AGHT+IFCVijXLSUVCPQKmjWnzoBH99FVFxRLUQsMEGi01Cnnd8fA1mDBZQkWvZqZeQ2MPbgYsDjxCw==
X-Received: by 2002:a17:90a:640f:b0:2c3:195b:dc2e with SMTP id
 98e67ed59e1d1-2c93d6ea775mr7252944a91.9.1719998449681; 
 Wed, 03 Jul 2024 02:20:49 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c95ca64649sm2905596a91.13.2024.07.03.02.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 02:20:49 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: its@irrelevant.dk, mst@redhat.com, hchkuo@avery-design.com.tw,
 wilfred.mallawa@wdc.com, jiewen.yao@intel.com, marcel.apfelbaum@gmail.com,
 lukas@wunner.de, cbrowy@avery-design.com, qemu-devel@nongnu.org,
 Jonathan.Cameron@Huawei.com, kbusch@kernel.org
Cc: Alistair Francis <alistair.francis@wdc.com>, alistair23@gmail.com,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jesper Devantier <foss@defmacro.it>,
 Jonathan Cameron <Jonathan.cameron@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 2/3] backends: Initial support for SPDM socket support
Date: Wed,  3 Jul 2024 19:20:26 +1000
Message-ID: <20240703092027.644758-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703092027.644758-1-alistair.francis@wdc.com>
References: <20240703092027.644758-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>

SPDM enables authentication, attestation and key exchange to assist in
providing infrastructure security enablement. It's a standard published
by the DMTF [1].

SPDM supports multiple transports, including PCIe DOE and MCTP.
This patch adds support to QEMU to connect to an external SPDM
instance.

SPDM support can be added to any QEMU device by exposing a
TCP socket to a SPDM server. The server can then implement the SPDM
decoding/encoding support, generally using libspdm [2].

This is similar to how the current TPM implementation works and means
that the heavy lifting of setting up certificate chains, capabilities,
measurements and complex crypto can be done outside QEMU by a well
supported and tested library.

1: https://www.dmtf.org/standards/SPDM
2: https://github.com/DMTF/libspdm

Signed-off-by: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
Signed-off-by: Chris Browy <cbrowy@avery-design.com>
Co-developed-by: Jonathan Cameron <Jonathan.cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ Changes by WM
 - Bug fixes from testing
]
Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
[ Changes by AF:
 - Convert to be more QEMU-ified
 - Move to backends as it isn't PCIe specific
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                  |   6 +
 include/sysemu/spdm-socket.h |  74 ++++++++++++
 backends/spdm-socket.c       | 216 +++++++++++++++++++++++++++++++++++
 backends/Kconfig             |   4 +
 backends/meson.build         |   2 +
 5 files changed, 302 insertions(+)
 create mode 100644 include/sysemu/spdm-socket.h
 create mode 100644 backends/spdm-socket.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6725913c8b..c76a0cfe12 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3397,6 +3397,12 @@ F: tests/qtest/*tpm*
 F: docs/specs/tpm.rst
 T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
 
+SPDM
+M: Alistair Francis <alistair.francis@wdc.com>
+S: Maintained
+F: backends/spdm-socket.c
+F: include/sysemu/spdm-socket.h
+
 Checkpatch
 S: Odd Fixes
 F: scripts/checkpatch.pl
diff --git a/include/sysemu/spdm-socket.h b/include/sysemu/spdm-socket.h
new file mode 100644
index 0000000000..5d8bd9aa4e
--- /dev/null
+++ b/include/sysemu/spdm-socket.h
@@ -0,0 +1,74 @@
+/*
+ * QEMU SPDM socket support
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef SPDM_REQUESTER_H
+#define SPDM_REQUESTER_H
+
+/**
+ * spdm_socket_connect: connect to an external SPDM socket
+ * @port: port to connect to
+ * @errp: error object handle
+ *
+ * This will connect to an external SPDM socket server. On error
+ * it will return -1 and errp will be set. On success this function
+ * will return the socket number.
+ */
+int spdm_socket_connect(uint16_t port, Error **errp);
+
+/**
+ * spdm_socket_rsp: send and receive a message to a SPDM server
+ * @socket: socket returned from spdm_socket_connect()
+ * @transport_type: SPDM_SOCKET_TRANSPORT_TYPE_* macro
+ * @req: request buffer
+ * @req_len: request buffer length
+ * @rsp: response buffer
+ * @rsp_len: response buffer length
+ *
+ * Send platform data to a SPDM server on socket and then receive
+ * a response.
+ */
+uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
+                         void *req, uint32_t req_len,
+                         void *rsp, uint32_t rsp_len);
+
+/**
+ * spdm_socket_close: send a shutdown command to the server
+ * @socket: socket returned from spdm_socket_connect()
+ * @transport_type: SPDM_SOCKET_TRANSPORT_TYPE_* macro
+ *
+ * This will issue a shutdown command to the server.
+ */
+void spdm_socket_close(const int socket, uint32_t transport_type);
+
+#define SPDM_SOCKET_COMMAND_NORMAL                0x0001
+#define SPDM_SOCKET_COMMAND_OOB_ENCAP_KEY_UPDATE  0x8001
+#define SPDM_SOCKET_COMMAND_CONTINUE              0xFFFD
+#define SPDM_SOCKET_COMMAND_SHUTDOWN              0xFFFE
+#define SPDM_SOCKET_COMMAND_UNKOWN                0xFFFF
+#define SPDM_SOCKET_COMMAND_TEST                  0xDEAD
+
+#define SPDM_SOCKET_TRANSPORT_TYPE_MCTP           0x01
+#define SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE        0x02
+
+#define SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE       0x1200
+
+#endif
diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
new file mode 100644
index 0000000000..d0663d696c
--- /dev/null
+++ b/backends/spdm-socket.c
@@ -0,0 +1,216 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * QEMU SPDM socket support
+ *
+ * This is based on:
+ * https://github.com/DMTF/spdm-emu/blob/07c0a838bcc1c6207c656ac75885c0603e344b6f/spdm_emu/spdm_emu_common/command.c
+ * but has been re-written to match QEMU style
+ *
+ * Copyright (c) 2021, DMTF. All rights reserved.
+ * Copyright (c) 2023. Western Digital Corporation or its affiliates.
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/spdm-socket.h"
+#include "qapi/error.h"
+
+static bool read_bytes(const int socket, uint8_t *buffer,
+                       size_t number_of_bytes)
+{
+    ssize_t number_received = 0;
+    ssize_t result;
+
+    while (number_received < number_of_bytes) {
+        result = recv(socket, buffer + number_received,
+                      number_of_bytes - number_received, 0);
+        if (result <= 0) {
+            return false;
+        }
+        number_received += result;
+    }
+    return true;
+}
+
+static bool read_data32(const int socket, uint32_t *data)
+{
+    bool result;
+
+    result = read_bytes(socket, (uint8_t *)data, sizeof(uint32_t));
+    if (!result) {
+        return result;
+    }
+    *data = ntohl(*data);
+    return true;
+}
+
+static bool read_multiple_bytes(const int socket, uint8_t *buffer,
+                                uint32_t *bytes_received,
+                                uint32_t max_buffer_length)
+{
+    uint32_t length;
+    bool result;
+
+    result = read_data32(socket, &length);
+    if (!result) {
+        return result;
+    }
+
+    if (length > max_buffer_length) {
+        return false;
+    }
+
+    if (bytes_received) {
+        *bytes_received = length;
+    }
+
+    if (length == 0) {
+        return true;
+    }
+
+    return read_bytes(socket, buffer, length);
+}
+
+static bool receive_platform_data(const int socket,
+                                  uint32_t transport_type,
+                                  uint32_t *command,
+                                  uint8_t *receive_buffer,
+                                  uint32_t *bytes_to_receive)
+{
+    bool result;
+    uint32_t response;
+    uint32_t bytes_received;
+
+    result = read_data32(socket, &response);
+    if (!result) {
+        return result;
+    }
+    *command = response;
+
+    result = read_data32(socket, &transport_type);
+    if (!result) {
+        return result;
+    }
+
+    bytes_received = 0;
+    result = read_multiple_bytes(socket, receive_buffer, &bytes_received,
+                                 *bytes_to_receive);
+    if (!result) {
+        return result;
+    }
+    *bytes_to_receive = bytes_received;
+
+    return result;
+}
+
+static bool write_bytes(const int socket, const uint8_t *buffer,
+                        uint32_t number_of_bytes)
+{
+    ssize_t number_sent = 0;
+    ssize_t result;
+
+    while (number_sent < number_of_bytes) {
+        result = send(socket, buffer + number_sent,
+                      number_of_bytes - number_sent, 0);
+        if (result == -1) {
+            return false;
+        }
+        number_sent += result;
+    }
+    return true;
+}
+
+static bool write_data32(const int socket, uint32_t data)
+{
+    data = htonl(data);
+    return write_bytes(socket, (uint8_t *)&data, sizeof(uint32_t));
+}
+
+static bool write_multiple_bytes(const int socket, const uint8_t *buffer,
+                                 uint32_t bytes_to_send)
+{
+    bool result;
+
+    result = write_data32(socket, bytes_to_send);
+    if (!result) {
+        return result;
+    }
+
+    return write_bytes(socket, buffer, bytes_to_send);
+}
+
+static bool send_platform_data(const int socket,
+                               uint32_t transport_type, uint32_t command,
+                               const uint8_t *send_buffer, size_t bytes_to_send)
+{
+    bool result;
+
+    result = write_data32(socket, command);
+    if (!result) {
+        return result;
+    }
+
+    result = write_data32(socket, transport_type);
+    if (!result) {
+        return result;
+    }
+
+    return write_multiple_bytes(socket, send_buffer, bytes_to_send);
+}
+
+int spdm_socket_connect(uint16_t port, Error **errp)
+{
+    int client_socket;
+    struct sockaddr_in server_addr;
+
+    client_socket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+    if (client_socket < 0) {
+        error_setg(errp, "cannot create socket: %s", strerror(errno));
+        return -1;
+    }
+
+    memset((char *)&server_addr, 0, sizeof(server_addr));
+    server_addr.sin_family = AF_INET;
+    server_addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+    server_addr.sin_port = htons(port);
+
+
+    if (connect(client_socket, (struct sockaddr *)&server_addr,
+                sizeof(server_addr)) < 0) {
+        error_setg(errp, "cannot connect: %s", strerror(errno));
+        close(client_socket);
+        return -1;
+    }
+
+    return client_socket;
+}
+
+uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
+                         void *req, uint32_t req_len,
+                         void *rsp, uint32_t rsp_len)
+{
+    uint32_t command;
+    bool result;
+
+    result = send_platform_data(socket, transport_type,
+                                SPDM_SOCKET_COMMAND_NORMAL,
+                                req, req_len);
+    if (!result) {
+        return 0;
+    }
+
+    result = receive_platform_data(socket, transport_type, &command,
+                                   (uint8_t *)rsp, &rsp_len);
+    if (!result) {
+        return 0;
+    }
+
+    assert(command != 0);
+
+    return rsp_len;
+}
+
+void spdm_socket_close(const int socket, uint32_t transport_type)
+{
+    send_platform_data(socket, transport_type,
+                       SPDM_SOCKET_COMMAND_SHUTDOWN, NULL, 0);
+}
diff --git a/backends/Kconfig b/backends/Kconfig
index 2cb23f62fa..d3dbe19868 100644
--- a/backends/Kconfig
+++ b/backends/Kconfig
@@ -3,3 +3,7 @@ source tpm/Kconfig
 config IOMMUFD
     bool
     depends on VFIO
+
+config SPDM_SOCKET
+    bool
+    default y
diff --git a/backends/meson.build b/backends/meson.build
index 106312f0c8..d1af4c8be3 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -32,4 +32,6 @@ endif
 system_ss.add(when: gio, if_true: files('dbus-vmstate.c'))
 system_ss.add(when: 'CONFIG_SGX', if_true: files('hostmem-epc.c'))
 
+system_ss.add(when: 'CONFIG_SPDM_SOCKET', if_true: files('spdm-socket.c'))
+
 subdir('tpm')
-- 
2.45.2


