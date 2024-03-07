Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A73C54E41
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 01:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri26l-0000jX-H4; Wed, 06 Mar 2024 19:59:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ri26i-0000iq-EM; Wed, 06 Mar 2024 19:59:36 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ri26c-00084u-Px; Wed, 06 Mar 2024 19:59:36 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5a12d228941so180417eaf.1; 
 Wed, 06 Mar 2024 16:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709773169; x=1710377969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLkJRjGutYW/XPTDxXYWqsdIPZoRK6WDt7SqwEG44js=;
 b=AO8SAlS+MU8SjwKvC7f4BeyrcFP1Xved1fF7Z293ldjx3DmcJ4rJAPcbRHAom1p8aF
 4dKBlHAv8OGW9TUNmWNsMRNX5sgjyO8OYN9x2hGhXzWXRZTo+EJDT3lH7JXzc07IubuA
 GUeBAaRHp8iHgxIhERvsbXxsRbapCNmI7XOp7z2bFOjFlJwOKFBszDBfEaORM94oop83
 XPXgCN6xb8t/o4oF6C5QBV7OP7A1Uyxz8qMOFttIxSLgDeFrvzZBM0YA1Z8tHn2/KOVM
 Zm0YVFdVDc3fRTvTzJ48cJZz4qFkpq3B0VfmILohLK4W9mHzPHmzxw4eOaTgAIzatSY8
 fXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709773169; x=1710377969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLkJRjGutYW/XPTDxXYWqsdIPZoRK6WDt7SqwEG44js=;
 b=uWhups0MmSs/PtxvYMjX0VVmdAAa9OKvkqYCb7rx2uUxpPFpEBtL7tX8Lz3Tq7U1fe
 0D//cNUKPS+vGM/bKvvyGk4RJIs1au+akmM4i1N+HjKFVdNfhWlXT0ViKSrhrXgTrAw0
 CUrNbnJaeQTWBWac7E8i0RgHi1/vMcSmI1DN1e/LcppuDwtk8eBLHjxVDtsHBuPfilxg
 lxwspr1dAVeVbNg0wjjWGqq//x7aXOOnBCLmFCfT+5HIHlUa9acLOM/pooq5MkXSXQeG
 8MuKb56CrCOMPWm8Dd4u3MR8NI2QxSwDhZVmCngRO83KR8YGq9pK2A6tx0+tMLQKctps
 aAag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF8WY2YfopY14XFMXguIDFstYDgxuAjS7vC2LUWCW6a8gwwlThcfVGffLJVwDrGHp5g3L4y180MXp2FdIdrWaE24iwe/4F8VwCApZ2/xhomcG5pv2CXRcw5QQ9JQ==
X-Gm-Message-State: AOJu0YxF1VD9l4ToefUbOfNlpEFUaPEawMr3+GidoQiKXiA/Kgp8sVGV
 GzptgEmedztzvGKvILeHZ7q83w90iTODu6Hs2wExlfe8PEdvYufM
X-Google-Smtp-Source: AGHT+IE9ZqA6Zwfw4MyTDrW3jCjbCm3Bo5sdlZHG60D6UP8Ips/+3ZVxRkQYE6BX2TsFhbvG6L1UPA==
X-Received: by 2002:a05:6358:93a7:b0:17b:f881:6635 with SMTP id
 h39-20020a05635893a700b0017bf8816635mr6130477rwb.28.1709773169119; 
 Wed, 06 Mar 2024 16:59:29 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 n21-20020a63f815000000b005dbd0facb4dsm11420276pgh.61.2024.03.06.16.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 16:59:28 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: marcel.apfelbaum@gmail.com, Jonathan.Cameron@Huawei.com, its@irrelevant.dk,
 mst@redhat.com, hchkuo@avery-design.com.tw, wilfred.mallawa@wdc.com,
 cbrowy@avery-design.com, kbusch@kernel.org, lukas@wunner.de,
 jiewen.yao@intel.com, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, alistair23@gmail.com,
 Jonathan Cameron <Jonathan.cameron@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 2/3] backends: Initial support for SPDM socket support
Date: Thu,  7 Mar 2024 10:58:58 +1000
Message-ID: <20240307005859.356555-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307005859.356555-1-alistair.francis@wdc.com>
References: <20240307005859.356555-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 include/sysemu/spdm-socket.h |  44 +++++++
 backends/spdm-socket.c       | 216 +++++++++++++++++++++++++++++++++++
 backends/Kconfig             |   4 +
 backends/meson.build         |   2 +
 5 files changed, 272 insertions(+)
 create mode 100644 include/sysemu/spdm-socket.h
 create mode 100644 backends/spdm-socket.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4183f2f3ab..a07706c225 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3395,6 +3395,12 @@ F: tests/qtest/*tpm*
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
index 0000000000..24e6fccb83
--- /dev/null
+++ b/include/sysemu/spdm-socket.h
@@ -0,0 +1,44 @@
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
+int spdm_socket_connect(uint16_t port, Error **errp);
+uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
+                         void *req, uint32_t req_len,
+                         void *rsp, uint32_t rsp_len);
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
index 8b2b111497..e5d4db7971 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -31,4 +31,6 @@ endif
 system_ss.add(when: gio, if_true: files('dbus-vmstate.c'))
 system_ss.add(when: 'CONFIG_SGX', if_true: files('hostmem-epc.c'))
 
+system_ss.add(when: 'CONFIG_SPDM_SOCKET', if_true: files('spdm-socket.c'))
+
 subdir('tpm')
-- 
2.44.0


