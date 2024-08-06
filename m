Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BA2C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 09:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbGUS-0002vG-JD; Tue, 06 Aug 2024 05:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zero.tangptr@gmail.com>)
 id 1sbGUQ-0002mU-Ea
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 05:28:22 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zero.tangptr@gmail.com>)
 id 1sbGUM-0002T6-U1
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 05:28:22 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a6135eso982388a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 02:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722936496; x=1723541296; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KAlhIHX6tS4E1n4BogBiXgp4i+6SzrRiVFW1tB1ecR0=;
 b=CE39AAeX+lEuuC2VT3omRDM/YG3od8c9V7I3ckuttbXAAdrsHRAiTgfMCSPJW8lQPI
 MUTjrHZ6SOLtq/tTIMjqBKgrQrze6KILEEQD1bbp+A7CCEURcaKqhdRQ9CS9EeiVQ1qJ
 avsGwxFvtbZe+8xaELpysYIR7VgRvIbr1x63wCiA6AYt8diIPDIyXcu5AXbgcXbcx0GD
 YQerR63raMKByoAUoxNllxGAiaNeHFznlZV2YXrk6xRW1kHecxenadjmxsyl66MTdmp0
 QR6pASHZbFM9luPuSrpBXwSHwfC+yJPmLXJDgDwQ/i4LkYxdg5IZYeeKVjTuBUPHftn1
 ellA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722936496; x=1723541296;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KAlhIHX6tS4E1n4BogBiXgp4i+6SzrRiVFW1tB1ecR0=;
 b=JqNAsjFQ+3pMuppxw32RqhdqzLL9UNDYQiujIlP8mC5FLPUyq8FseB02zb93pNjYYk
 NnQjbzYWAbryEsLaTxA3LVcgD3hz2iA62SFb6wPUTiVURTdfIxqPBoOrqhebQ1GKkJHV
 CEHUiXszgoWGYKv1l6ZsJjy9VYu/tYWDLfoxS4xRNrGq6j6Jb9jrEAlL7bcalSAgQ+qM
 tYaVODBZ+q6So2Cov7PB1cfSje/aQdg1NHzou73qKnASnUNfb34Vus9XkWjfnN9EmKEC
 KIFStejYTdh3bbFpYe6zJmmRcZ1SYHUg//EqmKROwDVsVK9YcSHR0Cbc6X1hVakebbaF
 yBTw==
X-Gm-Message-State: AOJu0Yzq0ewvUUIfDkzmNo0iZDV8jHSVv9WWEdkxMh502fI2BHcfCLqz
 XZeBvn7X7PSS0D0Ezus9uK3Ro5pmmAmHtCe+DvtoWnLuNoQjaxQc9lF1SxBXbK720H52qBYfaVJ
 QSM/v38UZ3btd2Gee9h1UV4oYp/on9oSK
X-Google-Smtp-Source: AGHT+IHpLQblTzwQrlDpXGleJA25LxgnRTK3Gx/eitUUKelSpvnEy97AUXoLzlPSuTHckbp1x6YOm8lA4iZYblldhKM=
X-Received: by 2002:a05:6402:655:b0:5b9:fe2f:48e4 with SMTP id
 4fb4d7f45d1cf-5b9fe2f490dmr8321295a12.6.1722936495326; Tue, 06 Aug 2024
 02:28:15 -0700 (PDT)
MIME-Version: 1.0
From: Zero Tang <zero.tangptr@gmail.com>
Date: Tue, 6 Aug 2024 17:28:01 +0800
Message-ID: <CAAXNugBYhpx249dUWgyXOtGjkxWatRHJSq94LrVFMGP_GjX7aA@mail.gmail.com>
Subject: [PATCH] hw/misc: Add a virtual PCILeech device
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com
Content-Type: multipart/alternative; boundary="000000000000c64ce3061f006973"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=zero.tangptr@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000c64ce3061f006973
Content-Type: text/plain; charset="UTF-8"

This virtual PCILeech device aims to help security researchers attack the
guest via DMA and test their IOMMU defenses.
This device is intended to support any systems with PCI, but I am only able
to test x86-based guests.
For what PCILeech is, check PCILeech GitHub repository:
https://github.com/ufrisk/pcileech
The QEMU-PCILeech plugin is currently awaiting merging:
https://github.com/ufrisk/LeechCore-plugins/pull/10

This is my first time contributing to QEMU and I am sorry that I forgot to
include a "[PATCH]" prefix in the title from my previous email and that I
didn't cc to relevant maintainers.
If needed, add my name and contact info into the maintainer's list.

Signed-off-by: Zero Tang <zero.tangptr@gmail.com>
---
 hw/misc/Kconfig     |   5 ++++
 hw/misc/meson.build |   1 +
 hw/misc/pcileech.c  | 291
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 297 insertions(+)

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1e08785b83..6c3ea7bf74 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -30,6 +30,11 @@ config EDU
     default y if TEST_DEVICES
     depends on PCI && MSI_NONBROKEN

+config PCILEECH
+    bool
+    default y
+    depends on PCI
+
 config PCA9552
     bool
     depends on I2C
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 2ca8717be2..e79931b9a6 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -1,5 +1,6 @@
 system_ss.add(when: 'CONFIG_APPLESMC', if_true: files('applesmc.c'))
 system_ss.add(when: 'CONFIG_EDU', if_true: files('edu.c'))
+system_ss.add(when: 'CONFIG_PCILEECH', if_true: files('pcileech.c'))
 system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmcoreinfo.c'))
 system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
 system_ss.add(when: 'CONFIG_ISA_TESTDEV', if_true: files('pc-testdev.c'))
diff --git a/hw/misc/pcileech.c b/hw/misc/pcileech.c
new file mode 100644
index 0000000000..252a570161
--- /dev/null
+++ b/hw/misc/pcileech.c
@@ -0,0 +1,291 @@
+/*
+ * QEMU Virtual PCILeech Device
+ *
+ * Copyright (c) 2024 Zero Tang
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
"Software"),
+ * to deal in the Software without restriction, including without
limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "hw/pci/pci.h"
+#include "hw/hw.h"
+#include "hw/pci/msi.h"
+#include "qemu/timer.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "qom/object.h"
+#include "qemu/main-loop.h" /* iothread mutex */
+#include "qemu/module.h"
+#include "qapi/visitor.h"
+
+#define TYPE_PCILEECH_DEVICE "pcileech"
+
+struct LeechRequestHeader {
+    uint8_t endianness; /* 0 - Little, 1 - Big */
+    uint8_t command;    /* 0 - Read, 1 - Write */
+    uint8_t reserved[6];
+    /* Variable Endianness */
+    uint64_t address;
+    uint64_t length;
+};
+
+struct LeechResponseHeader {
+    uint8_t endianness; /* 0 - Little, 1 - Big */
+    uint8_t reserved[3];
+    MemTxResult result;
+    uint64_t length;    /* Indicates length of data followed by header */
+};
+
+/* Verify the header length */
+static_assert(sizeof(struct LeechRequestHeader) == 24);
+static_assert(sizeof(struct LeechResponseHeader) == 16);
+
+struct PciLeechState {
+    /* Internal State */
+    PCIDevice device;
+    QemuThread thread;
+    QemuMutex mutex;
+    bool endianness;
+    bool stopping;
+    /* Communication */
+    char *host;
+    uint16_t port;
+    int sockfd;
+};
+
+typedef struct LeechRequestHeader LeechRequestHeader;
+typedef struct PciLeechState PciLeechState;
+
+DECLARE_INSTANCE_CHECKER(PciLeechState, PCILEECH, TYPE_PCILEECH_DEVICE)
+
+static void pci_leech_process_write_request(PciLeechState *state,
+                                            LeechRequestHeader *request,
+                                            int incoming)
+{
+    char buff[1024];
+    for (uint64_t i = 0; i < request->length; i += sizeof(buff)) {
+        struct LeechResponseHeader response = { 0 };
+        char* response_buffer = (char *)&response;
+        const uint64_t writelen = (request->length - i) <= sizeof(buff) ?
+                                         (request->length - i) :
sizeof(buff);
+        ssize_t recvlen = 0, sendlen = 0;
+        while (recvlen < writelen) {
+            recvlen += recv(incoming, &buff[recvlen], writelen - recvlen,
0);
+        }
+        response.endianness = state->endianness;
+        response.result = pci_dma_write(&state->device, request->address +
i,
+                                                            buff,
writelen);
+        if (response.result) {
+            printf("PCILeech: Address 0x%lX Write Error! MemTxResult:
0x%X\n",
+                    request->address + i, response.result);
+        }
+        response.length = 0;
+        while (sendlen < sizeof(struct LeechResponseHeader)) {
+            sendlen += send(incoming, &response_buffer[sendlen],
+                            sizeof(struct LeechResponseHeader) - sendlen,
0);
+        }
+    }
+}
+
+static void pci_leech_process_read_request(PciLeechState *state,
+                                            LeechRequestHeader *request,
+                                            int incoming)
+{
+    char buff[1024];
+    for (uint64_t i = 0; i < request->length; i += sizeof(buff)) {
+        struct LeechResponseHeader response = { 0 };
+        char* response_buffer = (char *)&response;
+        const uint64_t readlen = (request->length - i) <= sizeof(buff) ?
+                                    (request->length - i) : sizeof(buff);
+        ssize_t sendlen = 0;
+        response.endianness = state->endianness;
+        response.result = pci_dma_read(&state->device, request->address +
i,
+                                                            buff, readlen);
+        if (response.result) {
+            printf("PCILeech: Address 0x%lX Read Error! MemTxResult:
0x%X\n",
+                    request->address + i, response.result);
+        }
+        response.length = (request->endianness != state->endianness) ?
+                                            bswap64(readlen) : readlen;
+        while (sendlen < sizeof(struct LeechResponseHeader)) {
+            sendlen += send(incoming, &response_buffer[sendlen],
+                            sizeof(struct LeechResponseHeader) - sendlen,
0);
+        }
+        sendlen = 0;
+        while (sendlen < readlen) {
+            sendlen += send(incoming, &buff[sendlen], readlen - sendlen,
0);
+        }
+    }
+}
+
+static void *pci_leech_worker_thread(void *opaque)
+{
+    PciLeechState *state = PCILEECH(opaque);
+    while (1) {
+        LeechRequestHeader request;
+        char *request_buffer = (char *)&request;
+        ssize_t received = 0;
+        int incoming;
+        struct sockaddr address;
+        socklen_t addrlen;
+        /* Check if we are stopping. */
+        qemu_mutex_lock(&state->mutex);
+        if (state->stopping) {
+            qemu_mutex_unlock(&state->mutex);
+            break;
+        }
+        qemu_mutex_unlock(&state->mutex);
+        /* Accept PCILeech requests. */
+        /* Use HTTP1.0-like protocol for simplicity. */
+        incoming = accept(state->sockfd, &address, &addrlen);
+        if (incoming < 0) {
+            puts("WARNING: Failed to accept socket for PCILeech! Skipping "
+                 "Request...\n");
+            continue;
+        }
+        /* Get PCILeech requests. */
+        while (received < sizeof(LeechRequestHeader)) {
+            received += recv(incoming, &request_buffer[received],
+                            sizeof(LeechRequestHeader) - received, 0);
+        }
+        /* Swap endianness. */
+        if (request.endianness != state->endianness) {
+            request.address = bswap64(request.address);
+            request.length = bswap64(request.length);
+        }
+        /* Process PCILeech requests. */
+        qemu_mutex_lock(&state->mutex);
+        if (request.command) {
+            pci_leech_process_write_request(state, &request, incoming);
+        } else {
+            pci_leech_process_read_request(state, &request, incoming);
+        }
+        qemu_mutex_unlock(&state->mutex);
+        close(incoming);
+    }
+    return NULL;
+}
+
+static void pci_leech_realize(PCIDevice *pdev, Error **errp)
+{
+    PciLeechState *state = PCILEECH(pdev);
+    struct sockaddr_in sock_addr;
+    char host_ip[16];
+    struct hostent *he = gethostbyname(state->host);
+    if (he == NULL) {
+        puts("gethostbyname failed!");
+        exit(EXIT_FAILURE);
+    }
+    /* Initialize the socket for PCILeech. */
+    state->sockfd = socket(AF_INET, SOCK_STREAM, 0);
+    if (state->sockfd < 0) {
+        puts("Failed to initialize socket for PCILeech!");
+        exit(EXIT_FAILURE);
+    }
+    sock_addr.sin_family = AF_INET;
+    sock_addr.sin_addr = *(struct in_addr *)he->h_addr;
+    sock_addr.sin_port = htons(state->port);
+    inet_ntop(AF_INET, &sock_addr.sin_addr, host_ip, sizeof(host_ip));
+    if (bind(state->sockfd, (struct sockaddr *)&sock_addr,
sizeof(sock_addr))
+                                                                    < 0) {
+        puts("Failed to bind socket for PCILeech!");
+        close(state->sockfd);
+        exit(EXIT_FAILURE);
+    }
+    if (listen(state->sockfd, 10) < 0) {
+        puts("Failed to listen to socket for PCILeech!");
+        close(state->sockfd);
+        exit(EXIT_FAILURE);
+    }
+    printf("INFO: PCILeech is listening on %s:%u...\n", host_ip,
state->port);
+    /* Initialize the thread for PCILeech. */
+    qemu_mutex_init(&state->mutex);
+    qemu_thread_create(&state->thread, "pcileech", pci_leech_worker_thread,
+                                            state, QEMU_THREAD_JOINABLE);
+}
+
+static void pci_leech_finalize(PCIDevice *pdev)
+{
+    PciLeechState *state = PCILEECH(pdev);
+    puts("Stopping PCILeech Worker...");
+    qemu_mutex_lock(&state->mutex);
+    state->stopping = true;
+    qemu_mutex_unlock(&state->mutex);
+    close(state->sockfd);
+    qemu_thread_join(&state->thread);
+    qemu_mutex_destroy(&state->mutex);
+}
+
+char pci_leech_default_host[] = "0.0.0.0";
+
+static void pci_leech_instance_init(Object *obj)
+{
+    int x = 1;
+    char* y = (char *)&x;
+    PciLeechState *state = PCILEECH(obj);
+    /* QEMU's String-Property can't specify default value. */
+    /* So we have to set the default on our own. */
+    if (state->host == NULL) {
+        state->host = pci_leech_default_host;
+    }
+    /* Save Our Endianness. */
+    state->endianness = (*y == 0);
+}
+
+static Property leech_properties[] = {
+    DEFINE_PROP_UINT16("port", PciLeechState, port, 6789),
+    DEFINE_PROP_STRING("host", PciLeechState, host),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pci_leech_class_init(ObjectClass *class, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(class);
+    k->realize = pci_leech_realize;
+    k->exit = pci_leech_finalize;
+    /* Change the Vendor/Device ID to your favor. */
+    /* These are the default values from PCILeech-FPGA. */
+    k->vendor_id = PCI_VENDOR_ID_XILINX;
+    k->device_id = 0x0666;
+    k->revision = 0;
+    k->class_id = PCI_CLASS_NETWORK_ETHERNET;
+    device_class_set_props(dc, leech_properties);
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static void pci_leech_register_types(void)
+{
+    static InterfaceInfo interfaces[] = {
+        {INTERFACE_CONVENTIONAL_PCI_DEVICE},
+        {},
+    };
+    static const TypeInfo leech_info = {
+        .name = TYPE_PCILEECH_DEVICE,
+        .parent = TYPE_PCI_DEVICE,
+        .instance_size = sizeof(PciLeechState),
+        .instance_init = pci_leech_instance_init,
+        .class_init = pci_leech_class_init,
+        .interfaces = interfaces,
+    };
+    type_register_static(&leech_info);
+}
+
+type_init(pci_leech_register_types)

--000000000000c64ce3061f006973
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><font face=3D"arial, sans-serif">This virtual PCILeec=
h device aims to help security researchers attack the guest via DMA and tes=
t their IOMMU defenses.</font></div><div><font face=3D"arial, sans-serif">T=
his device is intended to support any systems with PCI, but I am only able =
to test x86-based guests.</font></div><div><font face=3D"arial, sans-serif"=
>For what PCILeech is, check PCILeech GitHub repository:=C2=A0</font><a hre=
f=3D"https://github.com/ufrisk/pcileech">https://github.com/ufrisk/pcileech=
</a></div><div>The QEMU-PCILeech plugin is currently awaiting merging:=C2=
=A0<a href=3D"https://github.com/ufrisk/LeechCore-plugins/pull/10">https://=
github.com/ufrisk/LeechCore-plugins/pull/10</a></div><div><br></div><div>Th=
is is my first time contributing to QEMU and I am sorry that I forgot to in=
clude a &quot;[PATCH]&quot; prefix in the title from my previous email and =
that I didn&#39;t cc to relevant maintainers.</div><div>If needed, add my n=
ame and contact info into the maintainer&#39;s list.</div><div><br></div><d=
iv>Signed-off-by: Zero Tang &lt;<a href=3D"mailto:zero.tangptr@gmail.com">z=
ero.tangptr@gmail.com</a>&gt;</div><font face=3D"monospace"><div><font face=
=3D"monospace">---</font></div>=C2=A0hw/misc/Kconfig =C2=A0 =C2=A0 | =C2=A0=
 5 ++++<br>=C2=A0hw/misc/meson.build | =C2=A0 1 +<br>=C2=A0hw/misc/pcileech=
.c =C2=A0| 291 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++<br>=C2=A03 files changed, 297 insertions(+)<br><br>diff -=
-git a/hw/misc/Kconfig b/hw/misc/Kconfig<br>index 1e08785b83..6c3ea7bf74 10=
0644<br>--- a/hw/misc/Kconfig<br>+++ b/hw/misc/Kconfig<br>@@ -30,6 +30,11 @=
@ config EDU<br>=C2=A0 =C2=A0 =C2=A0default y if TEST_DEVICES<br>=C2=A0 =C2=
=A0 =C2=A0depends on PCI &amp;&amp; MSI_NONBROKEN<br>=C2=A0<br>+config PCIL=
EECH<br>+ =C2=A0 =C2=A0bool<br>+ =C2=A0 =C2=A0default y<br>+ =C2=A0 =C2=A0d=
epends on PCI<br>+<br>=C2=A0config PCA9552<br>=C2=A0 =C2=A0 =C2=A0bool<br>=
=C2=A0 =C2=A0 =C2=A0depends on I2C<br>diff --git a/hw/misc/meson.build b/hw=
/misc/meson.build<br>index 2ca8717be2..e79931b9a6 100644<br>--- a/hw/misc/m=
eson.build<br>+++ b/hw/misc/meson.build<br>@@ -1,5 +1,6 @@<br>=C2=A0system_=
ss.add(when: &#39;CONFIG_APPLESMC&#39;, if_true: files(&#39;applesmc.c&#39;=
))<br>=C2=A0system_ss.add(when: &#39;CONFIG_EDU&#39;, if_true: files(&#39;e=
du.c&#39;))<br>+system_ss.add(when: &#39;CONFIG_PCILEECH&#39;, if_true: fil=
es(&#39;pcileech.c&#39;))<br>=C2=A0system_ss.add(when: &#39;CONFIG_FW_CFG_D=
MA&#39;, if_true: files(&#39;vmcoreinfo.c&#39;))<br>=C2=A0system_ss.add(whe=
n: &#39;CONFIG_ISA_DEBUG&#39;, if_true: files(&#39;debugexit.c&#39;))<br>=
=C2=A0system_ss.add(when: &#39;CONFIG_ISA_TESTDEV&#39;, if_true: files(&#39=
;pc-testdev.c&#39;))<br>diff --git a/hw/misc/pcileech.c b/hw/misc/pcileech.=
c<br>new file mode 100644<br>index 0000000000..252a570161<br>--- /dev/null<=
br>+++ b/hw/misc/pcileech.c<br>@@ -0,0 +1,291 @@<br>+/*<br>+ * QEMU Virtual=
 PCILeech Device<br>+ *<br>+ * Copyright (c) 2024 Zero Tang<br>+ *<br>+ * P=
ermission is hereby granted, free of charge, to any person obtaining a<br>+=
 * copy of this software and associated documentation files (the &quot;Soft=
ware&quot;),<br>+ * to deal in the Software without restriction, including =
without limitation<br>+ * the rights to use, copy, modify, merge, publish, =
distribute, sublicense,<br>+ * and/or sell copies of the Software, and to p=
ermit persons to whom the<br>+ * Software is furnished to do so, subject to=
 the following conditions:<br>+ *<br>+ * The above copyright notice and thi=
s permission notice shall be included in<br>+ * all copies or substantial p=
ortions of the Software.<br>+ *<br>+ * THE SOFTWARE IS PROVIDED &quot;AS IS=
&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR<br>+ * IMPLIED, INCLUDING =
BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,<br>+ * FITNESS FOR A =
PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE<br>+ * AUTHOR=
S OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER<br>+ * LIA=
BILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING<br>+ *=
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER<br>+ *=
 DEALINGS IN THE SOFTWARE.<br>+ */<br>+<br>+#include &quot;qemu/osdep.h&quo=
t;<br>+#include &quot;qemu/units.h&quot;<br>+#include &quot;hw/pci/pci.h&qu=
ot;<br>+#include &quot;hw/hw.h&quot;<br>+#include &quot;hw/pci/msi.h&quot;<=
br>+#include &quot;qemu/timer.h&quot;<br>+#include &quot;hw/qdev-properties=
.h&quot;<br>+#include &quot;hw/qdev-properties-system.h&quot;<br>+#include =
&quot;qom/object.h&quot;<br>+#include &quot;qemu/main-loop.h&quot; /* iothr=
ead mutex */<br>+#include &quot;qemu/module.h&quot;<br>+#include &quot;qapi=
/visitor.h&quot;<br>+<br>+#define TYPE_PCILEECH_DEVICE &quot;pcileech&quot;=
<br>+<br>+struct LeechRequestHeader {<br>+ =C2=A0 =C2=A0uint8_t endianness;=
 /* 0 - Little, 1 - Big */<br>+ =C2=A0 =C2=A0uint8_t command; =C2=A0 =C2=A0=
/* 0 - Read, 1 - Write */<br>+ =C2=A0 =C2=A0uint8_t reserved[6];<br>+ =C2=
=A0 =C2=A0/* Variable Endianness */<br>+ =C2=A0 =C2=A0uint64_t address;<br>=
+ =C2=A0 =C2=A0uint64_t length;<br>+};<br>+<br>+struct LeechResponseHeader =
{<br>+ =C2=A0 =C2=A0uint8_t endianness; /* 0 - Little, 1 - Big */<br>+ =C2=
=A0 =C2=A0uint8_t reserved[3];<br>+ =C2=A0 =C2=A0MemTxResult result;<br>+ =
=C2=A0 =C2=A0uint64_t length; =C2=A0 =C2=A0/* Indicates length of data foll=
owed by header */<br>+};<br>+<br>+/* Verify the header length */<br>+static=
_assert(sizeof(struct LeechRequestHeader) =3D=3D 24);<br>+static_assert(siz=
eof(struct LeechResponseHeader) =3D=3D 16);<br>+<br>+struct PciLeechState {=
<br>+ =C2=A0 =C2=A0/* Internal State */<br>+ =C2=A0 =C2=A0PCIDevice device;=
<br>+ =C2=A0 =C2=A0QemuThread thread;<br>+ =C2=A0 =C2=A0QemuMutex mutex;<br=
>+ =C2=A0 =C2=A0bool endianness;<br>+ =C2=A0 =C2=A0bool stopping;<br>+ =C2=
=A0 =C2=A0/* Communication */<br>+ =C2=A0 =C2=A0char *host;<br>+ =C2=A0 =C2=
=A0uint16_t port;<br>+ =C2=A0 =C2=A0int sockfd;<br>+};<br>+<br>+typedef str=
uct LeechRequestHeader LeechRequestHeader;<br>+typedef struct PciLeechState=
 PciLeechState;<br>+<br>+DECLARE_INSTANCE_CHECKER(PciLeechState, PCILEECH, =
TYPE_PCILEECH_DEVICE)<br>+<br>+static void pci_leech_process_write_request(=
PciLeechState *state,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LeechRequestHeader *request,<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int in=
coming)<br>+{<br>+ =C2=A0 =C2=A0char buff[1024];<br>+ =C2=A0 =C2=A0for (uin=
t64_t i =3D 0; i &lt; request-&gt;length; i +=3D sizeof(buff)) {<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0struct LeechResponseHeader response =3D { 0 };<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0char* response_buffer =3D (char *)&amp;response=
;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0const uint64_t writelen =3D (request-&gt;=
length - i) &lt;=3D sizeof(buff) ?<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (request-&gt;length - i) : sizeof(buff);<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t recvlen =3D 0, sendlen =3D 0;<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0while (recvlen &lt; writelen) {<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0recvlen +=3D recv(incoming, &amp;buff[recvle=
n], writelen - recvlen, 0);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0response.endianness =3D state-&gt;endianness;<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0response.result =3D pci_dma_write(&amp;state-&gt;de=
vice, request-&gt;address + i,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0buff, writelen);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 (response.result) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&=
quot;PCILeech: Address 0x%lX Write Error! MemTxResult: 0x%X\n&quot;,<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reques=
t-&gt;address + i, response.result);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0response.length =3D 0;<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0while (sendlen &lt; sizeof(struct LeechResponseHeader)) {<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sendlen +=3D send(incoming, &amp;r=
esponse_buffer[sendlen],<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(struct LeechResp=
onseHeader) - sendlen, 0);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =
=C2=A0}<br>+}<br>+<br>+static void pci_leech_process_read_request(PciLeechS=
tate *state,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0LeechRequestHeader *request,<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int incoming)=
<br>+{<br>+ =C2=A0 =C2=A0char buff[1024];<br>+ =C2=A0 =C2=A0for (uint64_t i=
 =3D 0; i &lt; request-&gt;length; i +=3D sizeof(buff)) {<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct LeechResponseHeader response =3D { 0 };<br>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0char* response_buffer =3D (char *)&amp;response;<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0const uint64_t readlen =3D (request-&gt;length -=
 i) &lt;=3D sizeof(buff) ?<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(request-&gt;length - i) : sizeof(buff);<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ssize_t sendlen =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0response.e=
ndianness =3D state-&gt;endianness;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0respons=
e.result =3D pci_dma_read(&amp;state-&gt;device, request-&gt;address + i,<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buff, rea=
dlen);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (response.result) {<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;PCILeech: Address 0x%lX Read=
 Error! MemTxResult: 0x%X\n&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0request-&gt;address + i, response.result)=
;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0respons=
e.length =3D (request-&gt;endianness !=3D state-&gt;endianness) ?<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0bswap64(readlen) : readlen;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0while (sendl=
en &lt; sizeof(struct LeechResponseHeader)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0sendlen +=3D send(incoming, &amp;response_buffer[sendlen],=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(struct LeechResponseHeader) - sendlen, 0=
);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0sendle=
n =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0while (sendlen &lt; readlen) {<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sendlen +=3D send(incoming, &amp=
;buff[sendlen], readlen - sendlen, 0);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br=
>+ =C2=A0 =C2=A0}<br>+}<br>+<br>+static void *pci_leech_worker_thread(void =
*opaque)<br>+{<br>+ =C2=A0 =C2=A0PciLeechState *state =3D PCILEECH(opaque);=
<br>+ =C2=A0 =C2=A0while (1) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0LeechRequest=
Header request;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0char *request_buffer =3D (c=
har *)&amp;request;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t received =3D 0;=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0int incoming;<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0struct sockaddr address;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0socklen_t ad=
drlen;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Check if we are stopping. */<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_lock(&amp;state-&gt;mutex);<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (state-&gt;stopping) {<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock(&amp;state-&gt;mutex);<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock(&amp;state-&gt;mutex);<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Accept PCILeech requests. */<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* Use HTTP1.0-like protocol for simplicity. */<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0incoming =3D accept(state-&gt;sockfd, &amp;addre=
ss, &amp;addrlen);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (incoming &lt; 0) {<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0puts(&quot;WARNING: Failed to =
accept socket for PCILeech! Skipping &quot;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Request...\n&quot;);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get PCILeech requests. */<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0while (received &lt; sizeof(LeechRequestHeader)) {<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0received +=3D recv(incoming, &amp=
;request_buffer[received],<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(LeechRequestH=
eader) - received, 0);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* Swap endianness. */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (re=
quest.endianness !=3D state-&gt;endianness) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0request.address =3D bswap64(request.address);<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0request.length =3D bswap64(request.length=
);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Pro=
cess PCILeech requests. */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_lock(=
&amp;state-&gt;mutex);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (request.command)=
 {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_leech_process_write_re=
quest(state, &amp;request, incoming);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0} els=
e {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_leech_process_read_re=
quest(state, &amp;request, incoming);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock(&amp;state-&gt;mutex);<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0close(incoming);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0=
 =C2=A0return NULL;<br>+}<br>+<br>+static void pci_leech_realize(PCIDevice =
*pdev, Error **errp)<br>+{<br>+ =C2=A0 =C2=A0PciLeechState *state =3D PCILE=
ECH(pdev);<br>+ =C2=A0 =C2=A0struct sockaddr_in sock_addr;<br>+ =C2=A0 =C2=
=A0char host_ip[16];<br>+ =C2=A0 =C2=A0struct hostent *he =3D gethostbyname=
(state-&gt;host);<br>+ =C2=A0 =C2=A0if (he =3D=3D NULL) {<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0puts(&quot;gethostbyname failed!&quot;);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0exit(EXIT_FAILURE);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0=
/* Initialize the socket for PCILeech. */<br>+ =C2=A0 =C2=A0state-&gt;sockf=
d =3D socket(AF_INET, SOCK_STREAM, 0);<br>+ =C2=A0 =C2=A0if (state-&gt;sock=
fd &lt; 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0puts(&quot;Failed to initializ=
e socket for PCILeech!&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(EXIT_FA=
ILURE);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0sock_addr.sin_family =3D AF_I=
NET;<br>+ =C2=A0 =C2=A0sock_addr.sin_addr =3D *(struct in_addr *)he-&gt;h_a=
ddr;<br>+ =C2=A0 =C2=A0sock_addr.sin_port =3D htons(state-&gt;port);<br>+ =
=C2=A0 =C2=A0inet_ntop(AF_INET, &amp;sock_addr.sin_addr, host_ip, sizeof(ho=
st_ip));<br>+ =C2=A0 =C2=A0if (bind(state-&gt;sockfd, (struct sockaddr *)&a=
mp;sock_addr, sizeof(sock_addr))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt; 0) {<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0puts(&quot;Failed to bind socket for PCILeech!&quot=
;);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0close(state-&gt;sockfd);<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0exit(EXIT_FAILURE);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=
=A0if (listen(state-&gt;sockfd, 10) &lt; 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0puts(&quot;Failed to listen to socket for PCILeech!&quot;);<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0close(state-&gt;sockfd);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0exit(EXIT_FAILURE);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0printf(&quot;I=
NFO: PCILeech is listening on %s:%u...\n&quot;, host_ip, state-&gt;port);<b=
r>+ =C2=A0 =C2=A0/* Initialize the thread for PCILeech. */<br>+ =C2=A0 =C2=
=A0qemu_mutex_init(&amp;state-&gt;mutex);<br>+ =C2=A0 =C2=A0qemu_thread_cre=
ate(&amp;state-&gt;thread, &quot;pcileech&quot;, pci_leech_worker_thread,<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0state, QEMU_THREAD_JOINABLE);<br>+}<br>+<br>+static void pci_leec=
h_finalize(PCIDevice *pdev)<br>+{<br>+ =C2=A0 =C2=A0PciLeechState *state =
=3D PCILEECH(pdev);<br>+ =C2=A0 =C2=A0puts(&quot;Stopping PCILeech Worker..=
.&quot;);<br>+ =C2=A0 =C2=A0qemu_mutex_lock(&amp;state-&gt;mutex);<br>+ =C2=
=A0 =C2=A0state-&gt;stopping =3D true;<br>+ =C2=A0 =C2=A0qemu_mutex_unlock(=
&amp;state-&gt;mutex);<br>+ =C2=A0 =C2=A0close(state-&gt;sockfd);<br>+ =C2=
=A0 =C2=A0qemu_thread_join(&amp;state-&gt;thread);<br>+ =C2=A0 =C2=A0qemu_m=
utex_destroy(&amp;state-&gt;mutex);<br>+}<br>+<br>+char pci_leech_default_h=
ost[] =3D &quot;0.0.0.0&quot;;<br>+<br>+static void pci_leech_instance_init=
(Object *obj)<br>+{<br>+ =C2=A0 =C2=A0int x =3D 1;<br>+ =C2=A0 =C2=A0char* =
y =3D (char *)&amp;x;<br>+ =C2=A0 =C2=A0PciLeechState *state =3D PCILEECH(o=
bj);<br>+ =C2=A0 =C2=A0/* QEMU&#39;s String-Property can&#39;t specify defa=
ult value. */<br>+ =C2=A0 =C2=A0/* So we have to set the default on our own=
. */<br>+ =C2=A0 =C2=A0if (state-&gt;host =3D=3D NULL) {<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0state-&gt;host =3D pci_leech_default_host;<br>+ =C2=A0 =C2=A0=
}<br>+ =C2=A0 =C2=A0/* Save Our Endianness. */<br>+ =C2=A0 =C2=A0state-&gt;=
endianness =3D (*y =3D=3D 0);<br>+}<br>+<br>+static Property leech_properti=
es[] =3D {<br>+ =C2=A0 =C2=A0DEFINE_PROP_UINT16(&quot;port&quot;, PciLeechS=
tate, port, 6789),<br>+ =C2=A0 =C2=A0DEFINE_PROP_STRING(&quot;host&quot;, P=
ciLeechState, host),<br>+ =C2=A0 =C2=A0DEFINE_PROP_END_OF_LIST(),<br>+};<br=
>+<br>+static void pci_leech_class_init(ObjectClass *class, void *data)<br>=
+{<br>+ =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(class);<br>+ =C2=A0 =
=C2=A0PCIDeviceClass *k =3D PCI_DEVICE_CLASS(class);<br>+ =C2=A0 =C2=A0k-&g=
t;realize =3D pci_leech_realize;<br>+ =C2=A0 =C2=A0k-&gt;exit =3D pci_leech=
_finalize;<br>+ =C2=A0 =C2=A0/* Change the Vendor/Device ID to your favor. =
*/<br>+ =C2=A0 =C2=A0/* These are the default values from PCILeech-FPGA. */=
<br>+ =C2=A0 =C2=A0k-&gt;vendor_id =3D PCI_VENDOR_ID_XILINX;<br>+ =C2=A0 =
=C2=A0k-&gt;device_id =3D 0x0666;<br>+ =C2=A0 =C2=A0k-&gt;revision =3D 0;<b=
r>+ =C2=A0 =C2=A0k-&gt;class_id =3D PCI_CLASS_NETWORK_ETHERNET;<br>+ =C2=A0=
 =C2=A0device_class_set_props(dc, leech_properties);<br>+ =C2=A0 =C2=A0set_=
bit(DEVICE_CATEGORY_MISC, dc-&gt;categories);<br>+}<br>+<br>+static void pc=
i_leech_register_types(void)<br>+{<br>+ =C2=A0 =C2=A0static InterfaceInfo i=
nterfaces[] =3D {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{INTERFACE_CONVENTIONAL_P=
CI_DEVICE},<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{},<br>+ =C2=A0 =C2=A0};<br>+ =
=C2=A0 =C2=A0static const TypeInfo leech_info =3D {<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.name =3D TYPE_PCILEECH_DEVICE,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.=
parent =3D TYPE_PCI_DEVICE,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.instance_size =
=3D sizeof(PciLeechState),<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.instance_init =
=3D pci_leech_instance_init,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.class_init =
=3D pci_leech_class_init,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.interfaces =3D i=
nterfaces,<br>+ =C2=A0 =C2=A0};<br>+ =C2=A0 =C2=A0type_register_static(&amp=
;leech_info);<br>+}<br>+<br>+type_init(pci_leech_register_types)</font><br>=
</div>

--000000000000c64ce3061f006973--

