Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC307CD3431
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2026 05:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJPqz-000162-T8; Sun, 03 May 2026 01:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wJM68-0004v6-H2
 for qemu-devel@nongnu.org; Sat, 02 May 2026 21:58:20 -0400
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wJM66-0000Ss-FD
 for qemu-devel@nongnu.org; Sat, 02 May 2026 21:58:20 -0400
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-2d868d014a5so3106392eec.1
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 18:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777773497; x=1778378297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOwNqYRk9+UvfOEov+BJRCxT8ZvnhEczC7nF4l7D9sI=;
 b=AW0f4Bw5AkN32VsdvEiq5B34X9VppDUiLjqamRLSYkIvsY0cKjDFngWj/007kxc0eO
 boIBC8aYIrW79Ywb2vzlJJRFYaUBvaTlRXT5ZOZituSifVNhEKTnMA2dCeWllcmov1la
 PmXWs7FSDuJbSnwia7cgmFRpgedrvOk/OKtkrwc+lQt+IVPZFiOF850V4VDyz5dK1/Tx
 z60JykAzgXgyl6ovWKvMsucET2rbRrFGrXCs5HkMevkkqOrzLGz/l4a2iSDmWEi6pLxi
 KI6J3WINEzWyp4+v9+ZuNIeupglDOz+unC9VPzKATh5v+uzFF1FM4cyEw0TPnBxE7Ldj
 tAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777773497; x=1778378297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kOwNqYRk9+UvfOEov+BJRCxT8ZvnhEczC7nF4l7D9sI=;
 b=hFSF4mBLUe1PThE8EdmdMQmtdNVdJgaj558XCbozV8wKb8TEOJAQskGtfWBAptl54Q
 /oTVULvHVjP9ywfGw3swiyTUbPUAA0kuvZOVbcm0UyhiYku2j73Rf8CGRxvPjjfo9MjM
 OmrDas9MfItKFonR6ji5D0MT1xr7zu6hVE6T2rC0hKNi8+nlWXKwwhciGKqmEmAFRYaK
 Tfo7LXIAOkhatXcw/1kkEF0vtFa091iB59oN23NUGKdVBS8iAgVXyT7x4VpX4kXnkYwO
 WJPoKHhlMRSbNEavjxfRUir9/8HLJsy0QjdStVg6n//Fy1VdtUDmD2dmWQqZ054dEjWT
 1FWw==
X-Gm-Message-State: AOJu0YyujGyDXWH+dlPfZ6DSEX5cwc/nDo9KUXViRTEgOwx9jXRftvv+
 X8paCJuQQ3RImXkHu5FUa9o8knkktLKUi0BM6BBe9Qdd2SJXqD639VfTeUnbTg==
X-Gm-Gg: AeBDietIzhtUvufNVOUNKgEbxJ3cT+jGgt8CgpeiivcXAk2Rbnk3GL59boNSykZcFV6
 G4psy8xUOIOQgRMkN5zSY8yh4t7Pr80DS8aSfxD09Bp2vmOMXmfA9SvfpWBQU2HGfN3P0zVyeYf
 2JnHHZpLmYLsg3BZxvIanLZFaYm3nN72DIhyniIgfQxzLmaSrGrsScxOOATJqQ7sEp81kreETtB
 EItcNC7cGQW3xxsyJRP9diXPDFoGlu7ode8gNCSIW+mY65hYwekYmXyw9UguHmrJjvEAf0Dv8jd
 56XxxKkvdZE74SUGb3FhKbt3FBpPJoE6rvmRAxD7WlK81Us6zaPiEoajSeZ2YF5i+rFR7QeooM1
 y869MfUlwmbx9vIvM97H6VLM6+l9DgAC6Atx2r1Bk+xEEBHS7F8YxRL1YsMedoFxmO33hawSY2z
 ZatXnCkTaK/yqYXAQWMr9cOpuHanY3sZP5rBF+Pk6rvhLe106bPw==
X-Received: by 2002:a05:7301:e8f:b0:2ee:d76a:3754 with SMTP id
 5a478bee46e88-2efb5024ee0mr2155263eec.0.1777773496681; 
 Sat, 02 May 2026 18:58:16 -0700 (PDT)
Received: from newsled.lan ([76.133.142.170]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee38d79eb9sm14361735eec.8.2026.05.02.18.58.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 02 May 2026 18:58:16 -0700 (PDT)
From: 54weasels <54weasels@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	thuth@redhat.com,
	54weasels <54weasels@gmail.com>
Subject: [PATCH 2/7] hw/net/lance: Add Sun-3 Native DMA byte-swapping support
Date: Sat,  2 May 2026 18:57:51 -0700
Message-ID: <20260503015756.99176-3-54weasels@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260503015756.99176-1-54weasels@gmail.com>
References: <20260503015756.99176-1-54weasels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132a;
 envelope-from=54weasels@gmail.com; helo=mail-dy1-x132a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 03 May 2026 01:58:52 -0400
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

The Sun-3 hardware physically byte-swaps the D0-D7 and D8-D15 DMA lanes between the Little-Endian LANCE controller and the Big-Endian Sun-3 memory. This commit intercepts the LANCE DMA reads/writes by injecting a phys_mem override in pcnet.c specifically for the Sun-3 instance, dynamically neutralizing the hardcoded internal initblk swap and properly mapping the payload payloads.

Signed-off-by: 54weasels <54weasels@gmail.com>
---
 hw/net/lance.c         | 111 ++++++++++++++++++++++++++++++++++++++---
 hw/net/meson.build     |   3 +-
 include/hw/net/lance.h |   3 ++
 3 files changed, 109 insertions(+), 8 deletions(-)

diff --git a/hw/net/lance.c b/hw/net/lance.c
index 5d5bf9b961..93944fb35d 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * QEMU AMD PC-Net II (Am79C970A) emulation
  *
@@ -22,7 +23,8 @@
  * THE SOFTWARE.
  */
 
-/* This software was written to be compatible with the specification:
+/*
+ * This software was written to be compatible with the specification:
  * AMD Am79C970A PCnet-PCI II Ethernet Controller Data-Sheet
  * AMD Publication# 19436  Rev:E  Amendment/0  Issue Date: June 2000
  */
@@ -44,8 +46,73 @@
 #include "hw/core/qdev-properties.h"
 #include "trace.h"
 #include "system/system.h"
+#include "system/address-spaces.h"
+#include "system/dma.h"
+
+/*
+ * LANCE Native DMA Read Hook
+ *
+ * Sun-3 Hardware intrinsically byte-swaps the D0-D7 and D8-D15 DMA lanes
+ * between the Little-Endian LANCE controller and the Big-Endian Sun-3 memory.
+ * We MUST model this manually. pcnet.c passes CSR_BSWP(s) for payloads
+ * (correctly bypassing the swap if LANCE internally neutralizes it).
+ * However, pcnet.c hardcodes do_bswap=1 for the `initblk` structure
+ * (len 24/28).
+ * We dynamically intercept the `initblk` fetch by cross-referencing CSR_IADR to
+ * enforce the hardware swap reliably. Because this branch is only taken when
+ * `dma_mr` is explicitly provided by the machine, this quirk is safely isolated
+ * to the Sun-3 and does not impact SPARC (which uses `ledma`).
+ */
+static void lance_dma_read(void *dma_opaque, hwaddr addr,
+                           uint8_t *buf, int len, int do_bswap)
+{
+    SysBusPCNetState *d = SYSBUS_PCNET(dma_opaque);
+    PCNetState *s = &d->state;
+
+    dma_memory_read(&d->dma_as, addr, buf, len, MEMTXATTRS_UNSPECIFIED);
+
+    uint32_t bcr_ssize32 = (s->bcr[20] & 0x0100);
+    hwaddr iadr = (s->csr[1] | ((uint32_t)s->csr[2] << 16));
+    if (!bcr_ssize32) {
+        iadr |= ((0xff00 & (uint32_t)s->csr[2]) << 16);
+    }
 
+    int internal_bswap = do_bswap;
+    if (addr == iadr && (len == 24 || len == 28)) {
+        internal_bswap = 0; /* Force hardware swap natively for initblk */
+    }
 
+    if (!internal_bswap) {
+        for (int i = 0; i < (len & ~1); i += 2) {
+            uint8_t tmp = buf[i];
+            buf[i] = buf[i + 1];
+            buf[i + 1] = tmp;
+        }
+    }
+}
+
+/* LANCE Native DMA Write Hook */
+static void lance_dma_write(void *dma_opaque, hwaddr addr,
+                            uint8_t *buf, int len, int do_bswap)
+{
+    SysBusPCNetState *s = SYSBUS_PCNET(dma_opaque);
+
+    if (!do_bswap) {
+        uint8_t *swapped_buf = g_malloc(len);
+        for (int i = 0; i < (len & ~1); i += 2) {
+            swapped_buf[i] = buf[i + 1];
+            swapped_buf[i + 1] = buf[i];
+        }
+        if (len & 1) {
+            swapped_buf[len - 1] = buf[len - 1];
+        }
+        dma_memory_write(&s->dma_as, addr, swapped_buf, len,
+                         MEMTXATTRS_UNSPECIFIED);
+        g_free(swapped_buf);
+    } else {
+        dma_memory_write(&s->dma_as, addr, buf, len, MEMTXATTRS_UNSPECIFIED);
+    }
+}
 static void parent_lance_reset(void *opaque, int irq, int level)
 {
     SysBusPCNetState *d = opaque;
@@ -59,7 +126,15 @@ static void lance_mem_write(void *opaque, hwaddr addr,
     SysBusPCNetState *d = opaque;
 
     trace_lance_mem_writew(addr, val & 0xffff);
-    pcnet_ioport_writew(&d->state, addr, val & 0xffff);
+    if (size == 1) {
+        uint16_t orig = pcnet_ioport_readw(&d->state, addr & ~1);
+        if (addr & 1) { /* LSB in Big Endian */
+            val = (orig & 0xff00) | (val & 0xff);
+        } else { /* MSB in Big Endian */
+            val = (orig & 0x00ff) | ((val & 0xff) << 8);
+        }
+    }
+    pcnet_ioport_writew(&d->state, addr & ~1, val & 0xffff);
 }
 
 static uint64_t lance_mem_read(void *opaque, hwaddr addr,
@@ -68,18 +143,28 @@ static uint64_t lance_mem_read(void *opaque, hwaddr addr,
     SysBusPCNetState *d = opaque;
     uint32_t val;
 
-    val = pcnet_ioport_readw(&d->state, addr);
-    trace_lance_mem_readw(addr, val & 0xffff);
+    val = pcnet_ioport_readw(&d->state, addr & ~1);
+    if (size == 1) {
+        if (addr & 1) {
+            val = val & 0xff;
+        } else {
+            val = (val >> 8) & 0xff;
+        }
+    }
     return val & 0xffff;
 }
 
 static const MemoryRegionOps lance_mem_ops = {
     .read = lance_mem_read,
     .write = lance_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
-        .min_access_size = 2,
-        .max_access_size = 2,
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 4,
     },
 };
 
@@ -115,8 +200,18 @@ static void lance_realize(DeviceState *dev, Error **errp)
 
     sysbus_init_irq(sbd, &s->irq);
 
+    if (d->dma_mr) {
+        address_space_init(&d->dma_as, d->dma_mr, "lance-dma");
+        s->phys_mem_read = lance_dma_read;
+        s->phys_mem_write = lance_dma_write;
+        s->dma_opaque = DEVICE(d);
+    } else {
+#if defined(TARGET_SPARC)
     s->phys_mem_read = ledma_memory_read;
     s->phys_mem_write = ledma_memory_write;
+#endif
+    }
+
     pcnet_common_init(dev, s, &net_lance_info);
 }
 
@@ -140,6 +235,8 @@ static void lance_instance_init(Object *obj)
 static const Property lance_properties[] = {
     DEFINE_PROP_LINK("dma", SysBusPCNetState, state.dma_opaque,
                      TYPE_DEVICE, DeviceState *),
+    DEFINE_PROP_LINK("dma_mr", SysBusPCNetState, dma_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_NIC_PROPERTIES(SysBusPCNetState, state.conf),
 };
 
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 3102587469..e653a9bc73 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -31,7 +31,8 @@ system_ss.add(when: 'CONFIG_MARVELL_88W8618', if_true: files('mv88w8618_eth.c'))
 
 system_ss.add(when: 'CONFIG_CADENCE', if_true: files('cadence_gem.c'))
 system_ss.add(when: 'CONFIG_STELLARIS_ENET', if_true: files('stellaris_enet.c'))
-system_ss.add(when: 'CONFIG_LANCE', if_true: files('lance.c'))
+# LANCE uses target-specific memory types (e.g., target_ulong) and must be compiled per-target.
+specific_ss.add(when: 'CONFIG_LANCE', if_true: files('lance.c'))
 system_ss.add(when: 'CONFIG_LASI_82596', if_true: files('lasi_i82596.c'))
 system_ss.add(when: 'CONFIG_I82596_COMMON', if_true: files('i82596.c'))
 system_ss.add(when: 'CONFIG_SUNHME', if_true: files('sunhme.c'))
diff --git a/include/hw/net/lance.h b/include/hw/net/lance.h
index be473e2eed..706160d7eb 100644
--- a/include/hw/net/lance.h
+++ b/include/hw/net/lance.h
@@ -31,6 +31,7 @@
 
 #include "net/net.h"
 #include "hw/net/pcnet.h"
+#include "system/memory.h"
 #include "hw/core/sysbus.h"
 #include "qom/object.h"
 
@@ -43,6 +44,8 @@ struct SysBusPCNetState {
     SysBusDevice parent_obj;
 
     PCNetState state;
+    MemoryRegion *dma_mr;
+    AddressSpace dma_as;
 };
 
 #endif
-- 
2.50.1 (Apple Git-155)


