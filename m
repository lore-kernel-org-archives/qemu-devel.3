Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E7DC52D6D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2024 21:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saMdh-0006xy-Nn; Sat, 03 Aug 2024 17:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zero.tangptr@gmail.com>)
 id 1saMST-00062Z-Nl
 for qemu-devel@nongnu.org; Sat, 03 Aug 2024 17:38:37 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zero.tangptr@gmail.com>)
 id 1saMSQ-00013b-NC
 for qemu-devel@nongnu.org; Sat, 03 Aug 2024 17:38:37 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7d638a1f27so502818366b.2
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2024 14:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722721112; x=1723325912; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WCoXiAufGWS6jpEZvdBT5+z+kguZP6eWPxFSVnIROy4=;
 b=VfAOKD4Tz/n4P5GaTxne+t5mMc+ZENJEJs/bkj/aexL/uxvA7DVHHFLHtapzh4UeMF
 ZsekB5ebzilIklNuUjoU9pFc4eUq9EiXjMtVrNlXCLuMB9HszHGiGXFcBP27QLBGrcjJ
 VyZyzaEwTOOHxHhzM/vgd3KWj9zriJOELVvs0RdSaqT8wolEdP5z63Yq1sdeBbzrngch
 rEv4YuqDNuusbf0ppw3o3Zwtv08ykoF6vCmEQG3kTsI8IYmg90H63RREb48rTV4uK+wh
 +twr9N0VBiTpyXdURcDCwJqvZwKZzh5Ugvtx5Q643+ICArlPSKl112Az4U2dEymtIkIc
 kgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722721112; x=1723325912;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WCoXiAufGWS6jpEZvdBT5+z+kguZP6eWPxFSVnIROy4=;
 b=N7ZX3dUt3FZNJwzbHdWF9fZSZfmbiT7ulg0+NPZoSmZf5gdP/Jgv0CiXsVuexZYmP5
 coHrefXMrfNbFShW+SqEAE10XcdT/FCCYExSC2LrIJJccY8M4J8qWQbtcSu6EHV7OpqD
 2FM0ejErqxFjH1rp9MEjcpKl9GlzmJVCl6LpPDMiXxT5lJHhiX2s/sIO0K3Xrlzl2xhS
 Tlmdb8wN9wqXE1m20TF1TE5biLmseVDgQQ0r43J170VTKjVPD0ZcpjWbVHiLDUUaQctx
 yxqV4izpAbwOrac4DukHArHP8yKjSfcbyVYiAhi9lsKRspQjsCKzEpWCYi0SokaemXuf
 X21w==
X-Gm-Message-State: AOJu0YyK620UQwJ5pMYkpsWAzANUQVj2w/IASo4VjhxQdzu+As3DWekn
 9zHFMSmaoyMs5H/be47XVTFKcJYFJe94yQYvLRZgERfiG6Ky6ikDKkzF/rmDjcsIMfc6keOIN7u
 DGdhIW47M2YxUBo/ZCHA1fieWWkgvcJZb
X-Google-Smtp-Source: AGHT+IFbRInqYARBQ8ktd16C1nkG7fGZsBB5rBHKPI8pppYb5xnxB4wNV1kTcK++/7+8R9tMj9XIen95JMWTdSPKANY=
X-Received: by 2002:a50:eac1:0:b0:5a2:97d7:c728 with SMTP id
 4fb4d7f45d1cf-5b7f0ccf807mr6157524a12.0.1722721111306; Sat, 03 Aug 2024
 14:38:31 -0700 (PDT)
MIME-Version: 1.0
From: Zero Tang <zero.tangptr@gmail.com>
Date: Sun, 4 Aug 2024 05:38:17 +0800
Message-ID: <CAAXNugALnq_V1x7VkUOESmCpc54MSQ_C3D52SAVJMjs0AnoNZw@mail.gmail.com>
Subject: hw/misc: Add a virtual PCILeech device
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e2f8ff061ece439e"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=zero.tangptr@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 03 Aug 2024 17:50:09 -0400
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

--000000000000e2f8ff061ece439e
Content-Type: text/plain; charset="UTF-8"

This virtual PCI device is intended for security researchers to attack the
guest via DMA.
This is my first-time contribution and I hope I am doing things correctly.

Signed-off-by: Zero Tang <zero.tangptr@gmail.com>
---
 hw/misc/Kconfig     |   5 +
 hw/misc/meson.build |   1 +
 hw/misc/pcileech.c  | 283
++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 289 insertions(+)

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1e08785b83..0bdbe26f26 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -30,6 +30,11 @@ config EDU
     default y if TEST_DEVICES
     depends on PCI && MSI_NONBROKEN

+config PCI_LEECH
+    bool
+    default y
+    depends on PCI
+
 config PCA9552
     bool
     depends on I2C
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 2ca8717be2..7178eafa75 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -1,5 +1,6 @@
 system_ss.add(when: 'CONFIG_APPLESMC', if_true: files('applesmc.c'))
 system_ss.add(when: 'CONFIG_EDU', if_true: files('edu.c'))
+system_ss.add(when: 'CONFIG_PCI_LEECH', if_true: files('pcileech.c'))
 system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmcoreinfo.c'))
 system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
 system_ss.add(when: 'CONFIG_ISA_TESTDEV', if_true: files('pc-testdev.c'))
diff --git a/hw/misc/pcileech.c b/hw/misc/pcileech.c
new file mode 100644
index 0000000000..f6782d055e
--- /dev/null
+++ b/hw/misc/pcileech.c
@@ -0,0 +1,283 @@
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
+        printf("PCILeech: Write MemTxResult: 0x%X\n", response.result);
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
+        printf("PCILeech: Read MemTxResult: 0x%X\n", response.result);
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
+        /* Swap endianness */
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
+    /* Initialize the socket for PCILeech.*/
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
+    /* Save Endianness */
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

--000000000000e2f8ff061ece439e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><font face=3D"arial, sans-serif">This virtual PCI dev=
ice is intended for security researchers to attack the guest via DMA.</font=
></div><div><font face=3D"arial, sans-serif">This is my first-time contribu=
tion and I hope I am doing things correctly.</font></div><div><font face=3D=
"arial, sans-serif"><br></font></div><div><font face=3D"arial, sans-serif">=
Signed-off-by: Zero Tang &lt;<a href=3D"mailto:zero.tangptr@gmail.com">zero=
.tangptr@gmail.com</a>&gt;</font></div><div><font face=3D"monospace">---</f=
ont></div><div><font face=3D"monospace">=C2=A0hw/misc/Kconfig =C2=A0 =C2=A0=
 | =C2=A0 5 +<br>=C2=A0hw/misc/meson.build | =C2=A0 1 +<br>=C2=A0hw/misc/pc=
ileech.c =C2=A0| 283 ++++++++++++++++++++++++++++++++++++++++++++++++++++<b=
r>=C2=A03 files changed, 289 insertions(+)<br><br>diff --git a/hw/misc/Kcon=
fig b/hw/misc/Kconfig<br>index 1e08785b83..0bdbe26f26 100644<br>--- a/hw/mi=
sc/Kconfig<br>+++ b/hw/misc/Kconfig<br>@@ -30,6 +30,11 @@ config EDU<br>=C2=
=A0 =C2=A0 =C2=A0default y if TEST_DEVICES<br>=C2=A0 =C2=A0 =C2=A0depends o=
n PCI &amp;&amp; MSI_NONBROKEN<br>=C2=A0<br>+config PCI_LEECH<br>+ =C2=A0 =
=C2=A0bool<br>+ =C2=A0 =C2=A0default y<br>+ =C2=A0 =C2=A0depends on PCI<br>=
+<br>=C2=A0config PCA9552<br>=C2=A0 =C2=A0 =C2=A0bool<br>=C2=A0 =C2=A0 =C2=
=A0depends on I2C<br>diff --git a/hw/misc/meson.build b/hw/misc/meson.build=
<br>index 2ca8717be2..7178eafa75 100644<br>--- a/hw/misc/meson.build<br>+++=
 b/hw/misc/meson.build<br>@@ -1,5 +1,6 @@<br>=C2=A0system_ss.add(when: &#39=
;CONFIG_APPLESMC&#39;, if_true: files(&#39;applesmc.c&#39;))<br>=C2=A0syste=
m_ss.add(when: &#39;CONFIG_EDU&#39;, if_true: files(&#39;edu.c&#39;))<br>+s=
ystem_ss.add(when: &#39;CONFIG_PCI_LEECH&#39;, if_true: files(&#39;pcileech=
.c&#39;))<br>=C2=A0system_ss.add(when: &#39;CONFIG_FW_CFG_DMA&#39;, if_true=
: files(&#39;vmcoreinfo.c&#39;))<br>=C2=A0system_ss.add(when: &#39;CONFIG_I=
SA_DEBUG&#39;, if_true: files(&#39;debugexit.c&#39;))<br>=C2=A0system_ss.ad=
d(when: &#39;CONFIG_ISA_TESTDEV&#39;, if_true: files(&#39;pc-testdev.c&#39;=
))<br>diff --git a/hw/misc/pcileech.c b/hw/misc/pcileech.c<br>new file mode=
 100644<br>index 0000000000..f6782d055e<br>--- /dev/null<br>+++ b/hw/misc/p=
cileech.c<br>@@ -0,0 +1,283 @@<br>+/*<br>+ * QEMU Virtual PCILeech Device<b=
r>+ *<br>+ * Copyright (c) 2024 Zero Tang<br>+ *<br>+ * Permission is hereb=
y granted, free of charge, to any person obtaining a<br>+ * copy of this so=
ftware and associated documentation files (the &quot;Software&quot;),<br>+ =
* to deal in the Software without restriction, including without limitation=
<br>+ * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,<br>+ * and/or sell copies of the Software, and to permit persons to w=
hom the<br>+ * Software is furnished to do so, subject to the following con=
ditions:<br>+ *<br>+ * The above copyright notice and this permission notic=
e shall be included in<br>+ * all copies or substantial portions of the Sof=
tware.<br>+ *<br>+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WA=
RRANTY OF ANY KIND, EXPRESS OR<br>+ * IMPLIED, INCLUDING BUT NOT LIMITED TO=
 THE WARRANTIES OF MERCHANTABILITY,<br>+ * FITNESS FOR A PARTICULAR PURPOSE=
 AND NONINFRINGEMENT. IN NO EVENT SHALL THE<br>+ * AUTHORS OR COPYRIGHT HOL=
DERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER<br>+ * LIABILITY, WHETHER IN=
 AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING<br>+ * FROM, OUT OF OR I=
N CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER<br>+ * DEALINGS IN THE S=
OFTWARE.<br>+ */<br>+<br>+#include &quot;qemu/osdep.h&quot;<br>+#include &q=
uot;qemu/units.h&quot;<br>+#include &quot;hw/pci/pci.h&quot;<br>+#include &=
quot;hw/hw.h&quot;<br>+#include &quot;hw/pci/msi.h&quot;<br>+#include &quot=
;qemu/timer.h&quot;<br>+#include &quot;hw/qdev-properties.h&quot;<br>+#incl=
ude &quot;hw/qdev-properties-system.h&quot;<br>+#include &quot;qom/object.h=
&quot;<br>+#include &quot;qemu/main-loop.h&quot; /* iothread mutex */<br>+#=
include &quot;qemu/module.h&quot;<br>+#include &quot;qapi/visitor.h&quot;<b=
r>+<br>+#define TYPE_PCILEECH_DEVICE &quot;pcileech&quot;<br>+<br>+struct L=
eechRequestHeader {<br>+ =C2=A0 =C2=A0uint8_t endianness; /* 0 - Little, 1 =
- Big */<br>+ =C2=A0 =C2=A0uint8_t command; =C2=A0 =C2=A0/* 0 - Read, 1 - W=
rite */<br>+ =C2=A0 =C2=A0uint8_t reserved[6];<br>+=C2=A0 =C2=A0 /* Variabl=
e Endianness */<br>+ =C2=A0 =C2=A0uint64_t address;<br>+ =C2=A0 =C2=A0uint6=
4_t length;<br>+};<br>+<br>+struct LeechResponseHeader {<br>+ =C2=A0 =C2=A0=
uint8_t endianness; /* 0 - Little, 1 - Big */<br>+ =C2=A0 =C2=A0uint8_t res=
erved[3];<br>+ =C2=A0 =C2=A0MemTxResult result;<br>+ =C2=A0 =C2=A0uint64_t =
length; =C2=A0 =C2=A0/* Indicates length of data followed by header */<br>+=
};<br>+<br>+static_assert(sizeof(struct LeechRequestHeader) =3D=3D 24);<br>=
+static_assert(sizeof(struct LeechResponseHeader) =3D=3D 16);<br>+<br>+stru=
ct PciLeechState {<br>+ =C2=A0 =C2=A0/* Internal State */<br>+ =C2=A0 =C2=
=A0PCIDevice device;<br>+ =C2=A0 =C2=A0QemuThread thread;<br>+ =C2=A0 =C2=
=A0QemuMutex mutex;<br>+ =C2=A0 =C2=A0bool endianness;<br>+ =C2=A0 =C2=A0bo=
ol stopping;<br>+ =C2=A0 =C2=A0/* Communication */<br>+ =C2=A0 =C2=A0char *=
host;<br>+ =C2=A0 =C2=A0uint16_t port;<br>+ =C2=A0 =C2=A0int sockfd;<br>+};=
<br>+<br>+typedef struct LeechRequestHeader LeechRequestHeader;<br>+typedef=
 struct PciLeechState PciLeechState;<br>+<br>+DECLARE_INSTANCE_CHECKER(PciL=
eechState, PCILEECH, TYPE_PCILEECH_DEVICE)<br>+<br>+static void pci_leech_p=
rocess_write_request(PciLeechState *state,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LeechRequestHeader *req=
uest,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int incoming)<br>+{<br>+ =C2=A0 =C2=A0char buff[1024];<br>=
+ =C2=A0 =C2=A0for (uint64_t i =3D 0; i &lt; request-&gt;length; i +=3D siz=
eof(buff)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0struct LeechResponseHeader res=
ponse =3D { 0 };<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0char* response_buffer =3D =
(char *)&amp;response;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0const uint64_t write=
len =3D (request-&gt;length - i) &lt;=3D sizeof(buff) ?<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (request-&gt;length - =
i) : sizeof(buff);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t recvlen =3D 0, s=
endlen =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0while (recvlen &lt; writelen)=
 {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0recvlen +=3D recv(incoming=
, &amp;buff[recvlen], writelen - recvlen, 0);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0response.endianness =3D state-&gt;endi=
anness;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0response.result =3D pci_dma_write(&=
amp;state-&gt;device, request-&gt;address + i,<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buff, writelen);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0printf(&quot;PCILeech: Write MemTxResult: 0x%X\n&quot;, re=
sponse.result);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0response.length =3D 0;<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (sendlen &lt; sizeof(struct LeechResponse=
Header)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sendlen +=3D send(=
incoming, &amp;response_buffer[sendlen],<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof=
(struct LeechResponseHeader) - sendlen, 0);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>+ =C2=A0 =C2=A0}<br>+}<br>+<br>+static void pci_leech_process_read_=
request(PciLeechState *state,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LeechRequestHeader *request,<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0int incoming)<br>+{<br>+ =C2=A0 =C2=A0char buff[1024];<br>+ =C2=A0 =
=C2=A0for (uint64_t i =3D 0; i &lt; request-&gt;length; i +=3D sizeof(buff)=
) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0struct LeechResponseHeader response =3D=
 { 0 };<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0char* response_buffer =3D (char *)&=
amp;response;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0const uint64_t readlen =3D (r=
equest-&gt;length - i) &lt;=3D sizeof(buff) ?<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(request-&gt;length - i) : sizeof(buff);<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t sendlen =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0response.endianness =3D state-&gt;endianness;<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0response.result =3D pci_dma_read(&amp;state-&gt;device, request-&=
gt;address + i,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0buff, readlen);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;PCIL=
eech: Read MemTxResult: 0x%X\n&quot;, response.result);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0response.length =3D (request-&gt;endianness !=3D state-&gt;end=
ianness) ?<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0bswap64(readlen) : readlen;<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0while (sendlen &lt; sizeof(struct LeechResponseHeader)) {<br>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sendlen +=3D send(incoming, &amp;respons=
e_buffer[sendlen],<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(struct LeechResponse=
Header) - sendlen, 0);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0sendlen =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0while (sendlen=
 &lt; readlen) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sendlen +=3D=
 send(incoming, &amp;buff[sendlen], readlen - sendlen, 0);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0}<br>+}<br>+<br>+static void *pci_leec=
h_worker_thread(void *opaque)<br>+{<br>+ =C2=A0 =C2=A0PciLeechState *state =
=3D PCILEECH(opaque);<br>+ =C2=A0 =C2=A0while (1) {<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0LeechRequestHeader request;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0char =
*request_buffer =3D (char *)&amp;request;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
size_t received =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0int incoming;<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sockaddr address;<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0socklen_t addrlen;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Check if we=
 are stopping. */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_lock(&amp;stat=
e-&gt;mutex);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (state-&gt;stopping) {<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock(&amp;state-&gt=
;mutex);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock(&am=
p;state-&gt;mutex);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Accept PCILeech requ=
ests. */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0incoming =3D accept(state-&gt;sock=
fd, &amp;address, &amp;addrlen);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (incomi=
ng &lt; 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0puts(&quot;WARNI=
NG: Failed to accept socket for PCILeech! Skipping &quot;<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Request...\n&quot;);<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get PCILeech requests. */=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0while (received &lt; sizeof(LeechRequestHe=
ader)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0received +=3D recv(i=
ncoming, &amp;request_buffer[received],<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof=
(LeechRequestHeader) - received, 0);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Swap endianness */<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (request.endianness !=3D state-&gt;endianness) {<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0request.address =3D bswap64(request.address)=
;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0request.length =3D bswap64(=
request.length);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Process PCILeech requests. */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
qemu_mutex_lock(&amp;state-&gt;mutex);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
request.command) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_leech_=
process_write_request(state, &amp;request, incoming);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0} else {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_lee=
ch_process_read_request(state, &amp;request, incoming);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock(&amp;state=
-&gt;mutex);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0close(incoming);<br>+ =C2=A0 =
=C2=A0}<br>+ =C2=A0 =C2=A0return NULL;<br>+}<br>+<br>+static void pci_leech=
_realize(PCIDevice *pdev, Error **errp)<br>+{<br>+ =C2=A0 =C2=A0PciLeechSta=
te *state =3D PCILEECH(pdev);<br>+ =C2=A0 =C2=A0struct sockaddr_in sock_add=
r;<br>+ =C2=A0 =C2=A0char host_ip[16];<br>+ =C2=A0 =C2=A0struct hostent *he=
 =3D gethostbyname(state-&gt;host);<br>+ =C2=A0 =C2=A0if (he =3D=3D NULL) {=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0puts(&quot;gethostbyname failed!&quot;);<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(EXIT_FAILURE);<br>+ =C2=A0 =C2=A0}<br>+=
 =C2=A0 =C2=A0/* Initialize the socket for PCILeech.*/<br>+ =C2=A0 =C2=A0st=
ate-&gt;sockfd =3D socket(AF_INET, SOCK_STREAM, 0);<br>+ =C2=A0 =C2=A0if (s=
tate-&gt;sockfd &lt; 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0puts(&quot;Failed=
 to initialize socket for PCILeech!&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0exit(EXIT_FAILURE);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0sock_addr.sin_=
family =3D AF_INET;<br>+ =C2=A0 =C2=A0sock_addr.sin_addr =3D *(struct in_ad=
dr *)he-&gt;h_addr;<br>+ =C2=A0 =C2=A0sock_addr.sin_port =3D htons(state-&g=
t;port);<br>+ =C2=A0 =C2=A0inet_ntop(AF_INET, &amp;sock_addr.sin_addr, host=
_ip, sizeof(host_ip));<br>+ =C2=A0 =C2=A0if (bind(state-&gt;sockfd, (struct=
 sockaddr *)&amp;sock_addr, sizeof(sock_addr))<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt; 0=
) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0puts(&quot;Failed to bind socket for PC=
ILeech!&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0close(state-&gt;sockfd);<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(EXIT_FAILURE);<br>+ =C2=A0 =C2=A0}<br>+ =
=C2=A0 =C2=A0if (listen(state-&gt;sockfd, 10) &lt; 0) {<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0puts(&quot;Failed to listen to socket for PCILeech!&quot;);<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0close(state-&gt;sockfd);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0exit(EXIT_FAILURE);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0prin=
tf(&quot;INFO: PCILeech is listening on %s:%u...\n&quot;, host_ip, state-&g=
t;port);<br>+ =C2=A0 =C2=A0/* Initialize the thread for PCILeech. */<br>+ =
=C2=A0 =C2=A0qemu_mutex_init(&amp;state-&gt;mutex);<br>+ =C2=A0 =C2=A0qemu_=
thread_create(&amp;state-&gt;thread, &quot;pcileech&quot;, pci_leech_worker=
_thread,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0state, QEMU_THREAD_JOINABLE);<br>+}<br>+<br>+static voi=
d pci_leech_finalize(PCIDevice *pdev)<br>+{<br>+ =C2=A0 =C2=A0PciLeechState=
 *state =3D PCILEECH(pdev);<br>+ =C2=A0 =C2=A0puts(&quot;Stopping PCILeech =
Worker...&quot;);<br>+ =C2=A0 =C2=A0qemu_mutex_lock(&amp;state-&gt;mutex);<=
br>+ =C2=A0 =C2=A0state-&gt;stopping =3D true;<br>+ =C2=A0 =C2=A0qemu_mutex=
_unlock(&amp;state-&gt;mutex);<br>+ =C2=A0 =C2=A0close(state-&gt;sockfd);<b=
r>+ =C2=A0 =C2=A0qemu_thread_join(&amp;state-&gt;thread);<br>+ =C2=A0 =C2=
=A0qemu_mutex_destroy(&amp;state-&gt;mutex);<br>+}<br>+<br>+char pci_leech_=
default_host[] =3D &quot;0.0.0.0&quot;;<br>+<br>+static void pci_leech_inst=
ance_init(Object *obj)<br>+{<br>+ =C2=A0 =C2=A0int x =3D 1;<br>+ =C2=A0 =C2=
=A0char* y =3D (char *)&amp;x;<br>+ =C2=A0 =C2=A0PciLeechState *state =3D P=
CILEECH(obj);<br>+ =C2=A0 =C2=A0/* QEMU&#39;s String-Property can&#39;t spe=
cify default value. */<br>+ =C2=A0 =C2=A0/* So we have to set the default o=
n our own. */<br>+ =C2=A0 =C2=A0if (state-&gt;host =3D=3D NULL) {<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0state-&gt;host =3D pci_leech_default_host;<br>+ =C2=
=A0 =C2=A0}<br>+ =C2=A0 =C2=A0/* Save Endianness */<br>+ =C2=A0 =C2=A0state=
-&gt;endianness =3D (*y =3D=3D 0);<br>+}<br>+<br>+static Property leech_pro=
perties[] =3D {<br>+ =C2=A0 =C2=A0DEFINE_PROP_UINT16(&quot;port&quot;, PciL=
eechState, port, 6789),<br>+ =C2=A0 =C2=A0DEFINE_PROP_STRING(&quot;host&quo=
t;, PciLeechState, host),<br>+ =C2=A0 =C2=A0DEFINE_PROP_END_OF_LIST(),<br>+=
};<br>+<br>+static void pci_leech_class_init(ObjectClass *class, void *data=
)<br>+{<br>+ =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(class);<br>+ =C2=
=A0 =C2=A0PCIDeviceClass *k =3D PCI_DEVICE_CLASS(class);<br>+ =C2=A0 =C2=A0=
k-&gt;realize =3D pci_leech_realize;<br>+ =C2=A0 =C2=A0k-&gt;exit =3D pci_l=
eech_finalize;<br>+ =C2=A0 =C2=A0/* Change the Vendor/Device ID to your fav=
or. */<br>+ =C2=A0 =C2=A0/* These are the default values from PCILeech-FPGA=
. */<br>+ =C2=A0 =C2=A0k-&gt;vendor_id =3D PCI_VENDOR_ID_XILINX;<br>+ =C2=
=A0 =C2=A0k-&gt;device_id =3D 0x0666;<br>+ =C2=A0 =C2=A0k-&gt;revision =3D =
0;<br>+ =C2=A0 =C2=A0k-&gt;class_id =3D PCI_CLASS_NETWORK_ETHERNET;<br>+ =
=C2=A0 =C2=A0device_class_set_props(dc, leech_properties);<br>+ =C2=A0 =C2=
=A0set_bit(DEVICE_CATEGORY_MISC, dc-&gt;categories);<br>+}<br>+<br>+static =
void pci_leech_register_types(void)<br>+{<br>+ =C2=A0 =C2=A0static Interfac=
eInfo interfaces[] =3D {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{INTERFACE_CONVENT=
IONAL_PCI_DEVICE},<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{},<br>+ =C2=A0 =C2=A0};=
<br>+ =C2=A0 =C2=A0static const TypeInfo leech_info =3D {<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0.name =3D TYPE_PCILEECH_DEVICE,<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0.parent =3D TYPE_PCI_DEVICE,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.instanc=
e_size =3D sizeof(PciLeechState),<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.instance=
_init =3D pci_leech_instance_init,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.class_i=
nit =3D pci_leech_class_init,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.interfaces =
=3D interfaces,<br>+ =C2=A0 =C2=A0};<br>+ =C2=A0 =C2=A0type_register_static=
(&amp;leech_info);<br>+}<br>+<br>+type_init(pci_leech_register_types)</font=
><br></div></div>

--000000000000e2f8ff061ece439e--

