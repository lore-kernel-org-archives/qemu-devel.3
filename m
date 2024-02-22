Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34A8C47DD9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 22:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdHUR-0002al-Rp; Thu, 22 Feb 2024 17:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rdHUP-0002Zm-NY
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 17:24:25 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rdHUM-0003A9-Kq
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 17:24:25 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d71cb97937so3301255ad.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 14:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708640661; x=1709245461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/xMTkt4H9928R+Sycr3uemIyeVCofAaI2nXM9aL6oM=;
 b=SWiQRL+MH7LpXQvovLfXbcNVvSegRk3NaEUChjuIBq1VvDZtYWKfNjmUSqcfF02ziO
 NEd+Ay2d1mj7BfbpBGl4evgbk2wTfvyuxwA/32W/N9w81MeLUShTMf738QRwfJtu7NTO
 1TImSDK0CSWDf6KrqwBqn34QgUIdGnS2hI16AtQaYJwSMY0pQQ8k0wvyU4vlPAh+5DCS
 VqGv152z8j69sBHY8KYysg8bP71NOOfPvC70oj4sKg6vYcPjuA/4BgRQ2EUQCaPYF3+R
 cjKJWVT5b40j51Zb+53+5wMoQBRH5buJDZMNBi3TVniCeikr/oRTxvGsy+6A+QgZ5uU2
 0JRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708640661; x=1709245461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2/xMTkt4H9928R+Sycr3uemIyeVCofAaI2nXM9aL6oM=;
 b=YccS8axVVXx716P4orXVjtAyuiUx4hOSdQbd4JViFJDhDHEDE8te0rYVAMw/D4EDO7
 27qhyG4b9P+ydwuwLmqn5o2LL3ojeQM3rmamqtfdGCDuWy656abbrNx1vqusD3QLnLHa
 Og/gWrSYzbD8esxnE+JRT3PGdIM5LUPkhd/5g/1B7wCoBXhsOf4IbTnyAOJSsO53+Dla
 4cQwbiEyQFO1n0UUgSGE/CTcW3bijs55Ca8qv16bIdq/mY9IJDe92tlBd6GQskJ4gUL3
 xl/5lO2lEmYTSXsAZXfUguPYhBoODsD3K6LBizXQopZH2V+psX+85m7cRR1Z04s1t5TJ
 KucA==
X-Gm-Message-State: AOJu0YxHNqgksBpOl8YIpnuiKpvP7BAF9CkdvE+3O8izz5aC3rYpE6PG
 Q14tav+lC78oN4gES4J0MsMQQUGYaqO67NvGWnTTFbeHEpq5xyGg3Gqq5Usf5SwDq2qUBN23xT+
 CBuU=
X-Google-Smtp-Source: AGHT+IGICRFtXzu0M9+XjVHV/bVU4oPPSePsWmRHPUtswF6mw7hyTCwangKSmfHxA2ZI+GAd+hJsdw==
X-Received: by 2002:a17:902:c402:b0:1db:f941:c9a with SMTP id
 k2-20020a170902c40200b001dbf9410c9amr234719plk.45.1708640660462; 
 Thu, 22 Feb 2024 14:24:20 -0800 (PST)
Received: from amd.. ([2804:7f0:b400:285a:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 ji7-20020a170903324700b001d7057c2fbasm10457210plb.100.2024.02.22.14.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 14:24:19 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	philmd@linaro.org
Cc: thuth@redhat.com, lvivier@redhat.com, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, pbonzini@redhat.com, anton.kochkov@proton.me,
 richard.henderson@linaro.org, peter.maydell@linaro.org,
 gustavo.romero@linaro.org
Subject: [PATCH 1/6] hw/misc/ivshmem: Add ivshmem-flat device
Date: Thu, 22 Feb 2024 22:22:13 +0000
Message-Id: <20240222222218.2261956-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222222218.2261956-1-gustavo.romero@linaro.org>
References: <20240222222218.2261956-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Add a new device, ivshmem-flat, which is similar to the ivshmem PCI but
does not require a PCI bus. It's meant to be used on machines like those
with Cortex-M MCUs, which usually lack a PCI/PCIe bus, e.g. lm3s6965evb
and mps2-an385.

The device currently only supports the sysbus bus.

The new device, just like the ivshmem PCI device, supports both peer
notification via hardware interrupts and shared memory.

The device shared memory size can be set using the 'shmem-size' option
and it defaults to 4 MiB, which is the default size of shmem allocated
by the ivshmem server.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1134
Message-ID: <20231127052024.435743-2-gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 docs/system/devices/ivshmem-flat.rst |  33 ++
 hw/misc/Kconfig                      |   5 +
 hw/misc/ivshmem-flat.c               | 463 +++++++++++++++++++++++++++
 hw/misc/meson.build                  |   2 +
 hw/misc/trace-events                 |  17 +
 include/hw/misc/ivshmem-flat.h       |  85 +++++
 6 files changed, 605 insertions(+)
 create mode 100644 docs/system/devices/ivshmem-flat.rst
 create mode 100644 hw/misc/ivshmem-flat.c
 create mode 100644 include/hw/misc/ivshmem-flat.h

diff --git a/docs/system/devices/ivshmem-flat.rst b/docs/system/devices/ivshmem-flat.rst
new file mode 100644
index 0000000000..1f97052804
--- /dev/null
+++ b/docs/system/devices/ivshmem-flat.rst
@@ -0,0 +1,33 @@
+Inter-VM Shared Memory Flat Device
+----------------------------------
+
+The ivshmem-flat device is meant to be used on machines that lack a PCI bus,
+making them unsuitable for the use of the traditional ivshmem device modeled as
+a PCI device. Machines like those with a Cortex-M MCU are good candidates to use
+the ivshmem-flat device. Also, since the flat version maps the control and
+status registers directly to the memory, it requires a quite tiny "device
+driver" to interact with other VMs, which is useful in some RTOSes, like
+Zephyr, which usually run on constrained resource targets.
+
+Similar to the ivshmem device, the ivshmem-flat device supports both peer
+notification via HW interrupts and Inter-VM shared memory. This allows the
+device to be used together with the traditional ivshmem, enabling communication
+between, for instance, an aarch64 VM  (using the traditional ivshmem device and
+running Linux), and an arm VM (using the ivshmem-flat device and running Zephyr
+instead).
+
+The ivshmem-flat device does not support the use of a ``memdev`` option (see
+ivshmem.rst for more details). It relies on the ivshmem server to create and
+distribute the proper shared memory file descriptor and the eventfd(s) to notify
+(interrupt) the peers. Therefore, to use this device, it is always necessary to
+have an ivshmem server up and running for proper device creation.
+
+Although the ivshmem-flat supports both peer notification (interrupts) and
+shared memory, the interrupt mechanism is optional. If no input IRQ is
+specified for the device it is disabled, preventing the VM from notifying or
+being notified by other VMs (a warning will be displayed to the user to inform
+the IRQ mechanism is disabled). The shared memory region is always present.
+
+The MMRs (INTRMASK, INTRSTATUS, IVPOSITION, and DOORBELL registers) offsets at
+the MMR region, and their functions, follow the ivshmem spec, so they work
+exactly as in the ivshmem PCI device (see ./specs/ivshmem-spec.txt).
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 4fc6b29b43..a643cfac3a 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -68,6 +68,11 @@ config IVSHMEM_DEVICE
     default y if PCI_DEVICES
     depends on PCI && LINUX && IVSHMEM && MSI_NONBROKEN
 
+config IVSHMEM_FLAT_DEVICE
+    bool
+    default y
+    depends on LINUX && IVSHMEM
+
 config ECCMEMCTL
     bool
     select ECC
diff --git a/hw/misc/ivshmem-flat.c b/hw/misc/ivshmem-flat.c
new file mode 100644
index 0000000000..833ee2fefb
--- /dev/null
+++ b/hw/misc/ivshmem-flat.c
@@ -0,0 +1,463 @@
+/*
+ * Inter-VM Shared Memory Flat Device
+ *
+ * SPDX-FileCopyrightText: 2023 Linaro Ltd.
+ * SPDX-FileContributor: Gustavo Romero <gustavo.romero@linaro.org>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/error-report.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties-system.h"
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+#include "exec/address-spaces.h"
+#include "trace.h"
+
+#include "hw/misc/ivshmem-flat.h"
+
+static int64_t ivshmem_flat_recv_msg(IvshmemFTState *s, int *pfd)
+{
+    int64_t msg;
+    int n, ret;
+
+    n = 0;
+    do {
+        ret = qemu_chr_fe_read_all(&s->server_chr, (uint8_t *)&msg + n,
+                                   sizeof(msg) - n);
+        if (ret < 0) {
+            if (ret == -EINTR) {
+                continue;
+            }
+            exit(1);
+        }
+        n += ret;
+    } while (n < sizeof(msg));
+
+    if (pfd) {
+        *pfd = qemu_chr_fe_get_msgfd(&s->server_chr);
+    }
+    return le64_to_cpu(msg);
+}
+
+static void ivshmem_flat_irq_handler(void *opaque)
+{
+    VectorInfo *vi = opaque;
+    EventNotifier *e = &vi->event_notifier;
+    uint16_t vector_id;
+    const VectorInfo (*v)[64];
+
+    assert(e->initialized);
+
+    vector_id = vi->id;
+
+    /*
+     * The vector info struct is passed to the handler via the 'opaque' pointer.
+     * This struct pointer allows the retrieval of the vector ID and its
+     * associated event notifier. However, for triggering an interrupt using
+     * qemu_set_irq, it's necessary to also have a pointer to the device state,
+     * i.e., a pointer to the IvshmemFTState struct. Since the vector info
+     * struct is contained within the IvshmemFTState struct, its pointer can be
+     * used to obtain the pointer to IvshmemFTState through simple pointer math.
+     */
+    v = (void *)(vi - vector_id); /* v =  &IvshmemPeer->vector[0] */
+    IvshmemPeer *own_peer = container_of(v, IvshmemPeer, vector);
+    IvshmemFTState *s = container_of(own_peer, IvshmemFTState, own);
+
+    /* Clear event  */
+    if (!event_notifier_test_and_clear(e)) {
+        return;
+    }
+
+    trace_ivshmem_flat_irq_handler(vector_id);
+
+    /*
+     * Toggle device's output line, which is connected to interrupt controller,
+     * generating an interrupt request to the CPU.
+     */
+    qemu_irq_pulse(s->irq);
+}
+
+static IvshmemPeer *ivshmem_flat_find_peer(IvshmemFTState *s, uint16_t peer_id)
+{
+    IvshmemPeer *peer;
+
+    /* Own ID */
+    if (s->own.id == peer_id) {
+        return &s->own;
+    }
+
+    /* Peer ID */
+    QTAILQ_FOREACH(peer, &s->peer, next) {
+        if (peer->id == peer_id) {
+            return peer;
+        }
+    }
+
+    return NULL;
+}
+
+static IvshmemPeer *ivshmem_flat_add_peer(IvshmemFTState *s, uint16_t peer_id)
+{
+    IvshmemPeer *new_peer;
+
+    new_peer = g_malloc0(sizeof(*new_peer));
+    new_peer->id = peer_id;
+    new_peer->vector_counter = 0;
+
+    QTAILQ_INSERT_TAIL(&s->peer, new_peer, next);
+
+    trace_ivshmem_flat_new_peer(peer_id);
+
+    return new_peer;
+}
+
+static void ivshmem_flat_remove_peer(IvshmemFTState *s, uint16_t peer_id)
+{
+    IvshmemPeer *peer;
+
+    peer = ivshmem_flat_find_peer(s, peer_id);
+    assert(peer);
+
+    QTAILQ_REMOVE(&s->peer, peer, next);
+    for (int n = 0; n < peer->vector_counter; n++) {
+        int efd;
+        efd = event_notifier_get_fd(&(peer->vector[n].event_notifier));
+        close(efd);
+    }
+
+    g_free(peer);
+}
+
+static void ivshmem_flat_add_vector(IvshmemFTState *s, IvshmemPeer *peer,
+                                    int vector_fd)
+{
+    if (peer->vector_counter >= IVSHMEM_MAX_VECTOR_NUM) {
+        trace_ivshmem_flat_add_vector_failure(peer->vector_counter,
+                                              vector_fd, peer->id);
+        close(vector_fd);
+
+        return;
+    }
+
+    trace_ivshmem_flat_add_vector_success(peer->vector_counter,
+                                          vector_fd, peer->id);
+
+    /*
+     * Set vector ID and its associated eventfd notifier and add them to the
+     * peer.
+     */
+    peer->vector[peer->vector_counter].id = peer->vector_counter;
+    g_unix_set_fd_nonblocking(vector_fd, true, NULL);
+    event_notifier_init_fd(&peer->vector[peer->vector_counter].event_notifier,
+                           vector_fd);
+
+    /*
+     * If it's the device's own ID, register also the handler for the eventfd
+     * so the device can be notified by the other peers.
+     */
+    if (peer == &s->own) {
+        qemu_set_fd_handler(vector_fd, ivshmem_flat_irq_handler, NULL,
+                            &peer->vector);
+    }
+
+    peer->vector_counter++;
+}
+
+static void ivshmem_flat_process_msg(IvshmemFTState *s, uint64_t msg, int fd)
+{
+    uint16_t peer_id;
+    IvshmemPeer *peer;
+
+    peer_id = msg & 0xFFFF;
+    peer = ivshmem_flat_find_peer(s, peer_id);
+
+    if (!peer) {
+        peer = ivshmem_flat_add_peer(s, peer_id);
+    }
+
+    if (fd >= 0) {
+        ivshmem_flat_add_vector(s, peer, fd);
+    } else { /* fd == -1, which is received when peers disconnect. */
+        ivshmem_flat_remove_peer(s, peer_id);
+    }
+}
+
+static int ivshmem_flat_can_receive_data(void *opaque)
+{
+    IvshmemFTState *s = opaque;
+
+    assert(s->msg_buffered_bytes < sizeof(s->msg_buf));
+    return sizeof(s->msg_buf) - s->msg_buffered_bytes;
+}
+
+static void ivshmem_flat_read_msg(void *opaque, const uint8_t *buf, int size)
+{
+    IvshmemFTState *s = opaque;
+    int fd;
+    int64_t msg;
+
+    assert(size >= 0 && s->msg_buffered_bytes + size <= sizeof(s->msg_buf));
+    memcpy((unsigned char *)&s->msg_buf + s->msg_buffered_bytes, buf, size);
+    s->msg_buffered_bytes += size;
+    if (s->msg_buffered_bytes < sizeof(s->msg_buf)) {
+        return;
+    }
+    msg = le64_to_cpu(s->msg_buf);
+    s->msg_buffered_bytes = 0;
+
+    fd = qemu_chr_fe_get_msgfd(&s->server_chr);
+
+    ivshmem_flat_process_msg(s, msg, fd);
+}
+
+static uint64_t ivshmem_flat_iomem_read(void *opaque,
+                                        hwaddr offset, unsigned size)
+{
+    IvshmemFTState *s = opaque;
+    uint32_t ret;
+
+    trace_ivshmem_flat_read_mmr(offset);
+
+    switch (offset) {
+    case INTMASK:
+        ret = 0; /* Ignore read since all bits are reserved in rev 1. */
+        break;
+    case INTSTATUS:
+        ret = 0; /* Ignore read since all bits are reserved in rev 1. */
+        break;
+    case IVPOSITION:
+        ret = s->own.id;
+        break;
+    case DOORBELL:
+        trace_ivshmem_flat_read_mmr_doorbell(); /* DOORBELL is write-only */
+        ret = 0;
+        break;
+    default:
+        /* Should never reach out here due to iomem map range being exact */
+        trace_ivshmem_flat_read_write_mmr_invalid(offset);
+        ret = 0;
+    }
+
+    return ret;
+}
+
+static int ivshmem_flat_interrupt_peer(IvshmemFTState *s,
+                                       uint16_t peer_id, uint16_t vector_id)
+{
+    IvshmemPeer *peer;
+
+    peer = ivshmem_flat_find_peer(s, peer_id);
+    if (!peer) {
+        trace_ivshmem_flat_interrupt_invalid_peer(peer_id);
+        return 1;
+    }
+
+    event_notifier_set(&(peer->vector[vector_id].event_notifier));
+
+    return 0;
+}
+
+static void ivshmem_flat_iomem_write(void *opaque, hwaddr offset,
+                                     uint64_t value, unsigned size)
+{
+    IvshmemFTState *s = opaque;
+    uint16_t peer_id = (value >> 16) & 0xFFFF;
+    uint16_t vector_id = value & 0xFFFF;
+
+    trace_ivshmem_flat_write_mmr(offset);
+
+    switch (offset) {
+    case INTMASK:
+        break;
+    case INTSTATUS:
+        break;
+    case IVPOSITION:
+        break;
+    case DOORBELL:
+        trace_ivshmem_flat_interrupt_peer(peer_id, vector_id);
+        ivshmem_flat_interrupt_peer(s, peer_id, vector_id);
+        break;
+    default:
+        /* Should never reach out here due to iomem map range being exact. */
+        trace_ivshmem_flat_read_write_mmr_invalid(offset);
+        break;
+    }
+
+    return;
+}
+
+static const MemoryRegionOps ivshmem_flat_ops = {
+    .read = ivshmem_flat_iomem_read,
+    .write = ivshmem_flat_iomem_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = { /* Read/write aligned at 32 bits. */
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void ivshmem_flat_instance_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    IvshmemFTState *s = IVSHMEM_FLAT(obj);
+
+    /*
+     * Init mem region for 4 MMRs (ivshmem_registers),
+     * 32 bits each => 16 bytes (0x10).
+     */
+    memory_region_init_io(&s->iomem, obj, &ivshmem_flat_ops, s,
+                          "ivshmem-mmio", 0x10);
+    sysbus_init_mmio(sbd, &s->iomem);
+
+    /*
+     * Create one output IRQ that will be connect to the
+     * machine's interrupt controller.
+     */
+    sysbus_init_irq(sbd, &s->irq);
+
+    QTAILQ_INIT(&s->peer);
+}
+
+static bool ivshmem_flat_connect_server(DeviceState *dev, Error **errp)
+{
+    IvshmemFTState *s = IVSHMEM_FLAT(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    int64_t protocol_version, msg;
+    int shmem_fd;
+    uint16_t peer_id;
+    struct stat fdstat;
+
+    /* Check ivshmem server connection. */
+    if (!qemu_chr_fe_backend_connected(&s->server_chr)) {
+        error_setg(errp, "ivshmem server socket not specified or incorret."
+                         " Can't create device.");
+        return false;
+    }
+
+    /*
+     * Message sequence from server on new connection:
+     *  _____________________________________
+     * |STEP| uint64_t msg  | int fd         |
+     *  -------------------------------------
+     *
+     *  0    PROTOCOL        -1              \
+     *  1    OWN PEER ID     -1               |-- Header/Greeting
+     *  2    -1              shmem fd        /
+     *
+     *  3    PEER IDx        Other peer's Vector 0 eventfd
+     *  4    PEER IDx        Other peer's Vector 1 eventfd
+     *  .                    .
+     *  .                    .
+     *  .                    .
+     *  N    PEER IDy        Other peer's Vector 0 eventfd
+     *  N+1  PEER IDy        Other peer's Vector 1 eventfd
+     *  .                    .
+     *  .                    .
+     *  .                    .
+     *
+     *  ivshmem_flat_recv_msg() calls return 'msg' and 'fd'.
+     *
+     *  See ./docs/specs/ivshmem-spec.txt for details on the protocol.
+     */
+
+    /* Step 0 */
+    protocol_version = ivshmem_flat_recv_msg(s, NULL);
+
+    /* Step 1 */
+    msg = ivshmem_flat_recv_msg(s, NULL);
+    peer_id = 0xFFFF & msg;
+    s->own.id = peer_id;
+    s->own.vector_counter = 0;
+
+    trace_ivshmem_flat_proto_ver_own_id(protocol_version, s->own.id);
+
+    /* Step 2 */
+    msg = ivshmem_flat_recv_msg(s, &shmem_fd);
+    /* Map shmem fd and MMRs into memory regions. */
+    if (msg != -1 || shmem_fd < 0) {
+        error_setg(errp, "Could not receive valid shmem fd."
+                         " Can't create device!");
+        return false;
+    }
+
+    if (fstat(shmem_fd, &fdstat) != 0) {
+        error_setg(errp, "Could not determine shmem fd size."
+                         " Can't create device!");
+        return false;
+    }
+    trace_ivshmem_flat_shmem_size(shmem_fd, fdstat.st_size);
+
+    /*
+     * Shmem size provided by the ivshmem server must be equal to
+     * device's shmem size.
+     */
+    if (fdstat.st_size != s->shmem_size) {
+        error_setg(errp, "Can't map shmem fd: shmem size different"
+                         " from device size!");
+        return false;
+    }
+
+    /*
+     * Beyond step 2 ivshmem_process_msg, called by ivshmem_flat_read_msg
+     * handler -- when data is available on the server socket -- will handle
+     * the additional messages that will be generated by the server as peers
+     * connect or disconnect.
+     */
+    qemu_chr_fe_set_handlers(&s->server_chr, ivshmem_flat_can_receive_data,
+                             ivshmem_flat_read_msg, NULL, NULL, s, NULL, true);
+
+    memory_region_init_ram_from_fd(&s->shmem, OBJECT(s),
+                                   "ivshmem-shmem", s->shmem_size,
+                                   RAM_SHARED, shmem_fd, 0, NULL);
+    sysbus_init_mmio(sbd, &s->shmem);
+
+    return true;
+}
+
+static void ivshmem_flat_realize(DeviceState *dev, Error **errp)
+{
+    if (!ivshmem_flat_connect_server(dev, errp)) {
+        return;
+    }
+}
+
+static Property ivshmem_flat_props[] = {
+    DEFINE_PROP_CHR("chardev", IvshmemFTState, server_chr),
+    DEFINE_PROP_UINT32("shmem-size", IvshmemFTState, shmem_size, 4 * MiB),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void ivshmem_flat_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->hotpluggable = true;
+    dc->realize = ivshmem_flat_realize;
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    device_class_set_props(dc, ivshmem_flat_props);
+
+    /* Reason: Must be wired up in code (sysbus MRs and IRQ) */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo ivshmem_flat_info = {
+    .name = TYPE_IVSHMEM_FLAT,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(IvshmemFTState),
+    .instance_init = ivshmem_flat_instance_init,
+    .class_init = ivshmem_flat_class_init,
+};
+
+static void ivshmem_flat_register_types(void)
+{
+    type_register_static(&ivshmem_flat_info);
+}
+
+type_init(ivshmem_flat_register_types);
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index e4ef1da5a5..84dff09f5d 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -38,7 +38,9 @@ system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
 
 subdir('macio')
 
+# ivshmem devices
 system_ss.add(when: 'CONFIG_IVSHMEM_DEVICE', if_true: files('ivshmem.c'))
+system_ss.add(when: 'CONFIG_IVSHMEM_FLAT_DEVICE', if_true: files('ivshmem-flat.c'))
 
 system_ss.add(when: 'CONFIG_ALLWINNER_SRAMC', if_true: files('allwinner-sramc.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_A10_CCM', if_true: files('allwinner-a10-ccm.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 5f5bc92222..cba03743dd 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -341,3 +341,20 @@ djmemc_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRI
 # iosb.c
 iosb_read(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
 iosb_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
+
+# ivshmem-flat.c
+ivshmem_flat_irq_handler(uint16_t vector_id) "Caught interrupt request: vector %d"
+ivshmem_flat_new_peer(uint16_t peer_id) "New peer ID: %d"
+ivshmem_flat_add_vector_failure(uint16_t vector_id, uint32_t vector_fd, uint16_t peer_id) "Failed to add vector %u (fd = %u) to peer ID %u, maximum number of vectors reached"
+ivshmem_flat_add_vector_success(uint16_t vector_id, uint32_t vector_fd, uint16_t peer_id) "Successful addition of vector %u (fd = %u) to peer ID %u"
+ivshmem_flat_irq_resolved(const char *irq_qompath) "IRQ QOM path '%s' correctly resolved"
+ivshmem_flat_proto_ver_own_id(uint64_t proto_ver, uint16_t peer_id) "Protocol Version = 0x%"PRIx64", Own Peer ID = %u"
+ivshmem_flat_shmem_size(int fd, uint64_t size) "Shmem fd (%d) total size is %"PRIu64" byte(s)"
+ivshmem_flat_shmem_map(uint64_t addr) "Mapping shmem @ 0x%"PRIx64
+ivshmem_flat_mmio_map(uint64_t addr) "Mapping MMRs @ 0x%"PRIx64
+ivshmem_flat_read_mmr(uint64_t addr_offset) "Read access at offset %"PRIu64
+ivshmem_flat_read_mmr_doorbell(void) "DOORBELL register is write-only!"
+ivshmem_flat_read_write_mmr_invalid(uint64_t addr_offset) "No ivshmem register mapped at offset %"PRIu64
+ivshmem_flat_interrupt_invalid_peer(uint16_t peer_id) "Can't interrupt non-existing peer %u"
+ivshmem_flat_write_mmr(uint64_t addr_offset) "Write access at offset %"PRIu64
+ivshmem_flat_interrupt_peer(uint16_t peer_id, uint16_t vector_id) "Interrupting peer ID %u, vector %u..."
diff --git a/include/hw/misc/ivshmem-flat.h b/include/hw/misc/ivshmem-flat.h
new file mode 100644
index 0000000000..97ca0ddce6
--- /dev/null
+++ b/include/hw/misc/ivshmem-flat.h
@@ -0,0 +1,85 @@
+/*
+ * Inter-VM Shared Memory Flat Device
+ *
+ * SPDX-FileCopyrightText: 2023 Linaro Ltd.
+ * SPDX-FileContributor: Gustavo Romero <gustavo.romero@linaro.org>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef IVSHMEM_FLAT_H
+#define IVSHMEM_FLAT_H
+
+#include "qemu/queue.h"
+#include "qemu/event_notifier.h"
+#include "chardev/char-fe.h"
+#include "exec/memory.h"
+#include "qom/object.h"
+#include "hw/sysbus.h"
+
+#define IVSHMEM_MAX_VECTOR_NUM 64
+
+/*
+ * QEMU interface:
+ *  + QOM property "chardev" is the character device id of the ivshmem server
+ *    socket
+ *  + QOM property "shmem-size" sets the size of the RAM region shared between
+ *    the device and the ivshmem server
+ *  + sysbus MMIO region 0: device I/O mapped registers
+ *  + sysbus MMIO region 1: shared memory with ivshmem server
+ *  + sysbus IRQ 0: single output interrupt
+ */
+
+#define TYPE_IVSHMEM_FLAT "ivshmem-flat"
+typedef struct IvshmemFTState IvshmemFTState;
+
+DECLARE_INSTANCE_CHECKER(IvshmemFTState, IVSHMEM_FLAT, TYPE_IVSHMEM_FLAT)
+
+/* Ivshmem registers. See ./docs/specs/ivshmem-spec.txt for details. */
+enum ivshmem_registers {
+    INTMASK = 0,
+    INTSTATUS = 4,
+    IVPOSITION = 8,
+    DOORBELL = 12,
+};
+
+typedef struct VectorInfo {
+    EventNotifier event_notifier;
+    uint16_t id;
+} VectorInfo;
+
+typedef struct IvshmemPeer {
+    QTAILQ_ENTRY(IvshmemPeer) next;
+    VectorInfo vector[IVSHMEM_MAX_VECTOR_NUM];
+    int vector_counter;
+    uint16_t id;
+} IvshmemPeer;
+
+struct IvshmemFTState {
+    SysBusDevice parent_obj;
+
+    uint64_t msg_buf;
+    int msg_buffered_bytes;
+
+    QTAILQ_HEAD(, IvshmemPeer) peer;
+    IvshmemPeer own;
+
+    CharBackend server_chr;
+
+    /* IRQ */
+    qemu_irq irq;
+
+    /* I/O registers */
+    MemoryRegion iomem;
+    uint32_t intmask;
+    uint32_t intstatus;
+    uint32_t ivposition;
+    uint32_t doorbell;
+
+    /* Shared memory */
+    MemoryRegion shmem;
+    int shmem_fd;
+    uint32_t shmem_size;
+};
+
+#endif /* IVSHMEM_FLAT_H */
-- 
2.34.1


