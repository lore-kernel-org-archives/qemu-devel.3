Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53498CCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 21:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEweB-0006Yu-FJ; Fri, 31 Oct 2025 17:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vEwTF-0000IA-PI
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:15:41 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vEwTA-0001xY-Co
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:15:41 -0400
Received: by mail-pg1-x544.google.com with SMTP id
 41be03b00d2f7-b6ce806af3eso2649755a12.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 14:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761945334; x=1762550134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fAM4FZoxb0MBH5ZAtKRWKw7Q0rXwyIxHIyxwj872NFQ=;
 b=JJXURV2A3uGpjPdXVHtTwSo2HTjVDve+XkbREAH9ygfeQivzhOCu7lpDdPrR6StVUC
 tVR3EG6yZi/dQHCBWXdLuYghdQw9nNg0HxVBmWVJPd5KMbmZTDDQmzbH5mCuEA7vPlut
 JqccvI+afdmK5MIwAw6tqQCgjEr7J/WsKaLyixRVdVlom0bHXROixySGXX2DwwaIzlzu
 9xUPp79dlx4u5CJ5+5wSOQrtRz39SmdmBxMhIA6fSt5z10FJht+x+fh7xm0QNXevYQbA
 45TejaRIsGTdV4PIVTLNVGNOorOcQc6A5RI2JJtedXuS8K2hUTLnMU/L1hEteUuhTber
 saPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761945334; x=1762550134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fAM4FZoxb0MBH5ZAtKRWKw7Q0rXwyIxHIyxwj872NFQ=;
 b=GP9jil7dgS0h0XeKdoGqpUEtfAUlklSBF9VRr0JR/FDigctLYVvD3xaooft9W0/hn3
 9pIaYB2ksNh9+iXf2I4GGNvN1INmKGT4h6AG0ZyPeWCrwc2w+D58stQCfVh8AlkZO9u6
 JyVXCgwkcTkvhQcia+jvh41oY8S30HXJzfbUYmrmbFiVWgE565H3wj4iR7zDd1wANPzF
 o6xe8jL5cAYuQkT/jHig2IrBPuM69+zUrGdpwdEM/sjKvNqEg83MmNvclWeTOTI1Uuxd
 YpgsH3nOjTqq4KKjyfDQThiEjdbYGbDSpjRmQbV2EFCOrpf1RamvMaT+RZRbYLF+3DNi
 Tjtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyF37LSwPKsaloq7+PHL65yUVna3hk7RpnNnpL38ASNBaGMfxIHGfmzq44qzDUNnplQws9QzKKA2rX@nongnu.org
X-Gm-Message-State: AOJu0Ywx1x5Zee7y4TAyRxmaorH7h3JOqqLTE66vW2/wWOUpHhWM+MhO
 JJhnHaD44T3GWvsZnXRU+sQdkm6YiWeqZHA5wIi3lJcGtRZy1se3Vd8Q
X-Gm-Gg: ASbGnctWWdna82v9cHzkLJYHlbR/XPZfgiyyhMDAXkZ/X2D/RzLcfOIDRP/cbqg/33m
 TKmfrm7iu4g32td7xdYddcUYLlcfWhHzP0hOxmCwcFcZUFQ/iGVz73NNXauwCmYPjYN8ZXcC6lS
 /iWS7GoSU8IfRO4lpktSOTiLl8NCKRIy1aJywFtKpTc8sTZOMdbVx+lAaZiFirkyB8ZlmdSVss3
 GQQOgqbfS/Ot5OU2htLduEgUwz/JWX98mvX2rVqHGALgJlQYUQqZL1xnzaWgLa1LCe5+Qd/HV9S
 JmUdEyTh0oRfFLJCophaLoC3bUa6Uk/yAbB4qc9fBcig7j/xIdx7vnReuZfkqdebfbhK2faxoC7
 SsamWXn6Psl2ZRSxjhZXtsEt8PkhPwXXIP470MdETqMZo0aJ4P2jzSXAKXedKlIKTEUuwdMre0H
 bQNXSiIUTZn0+bS1ekZs2uDAC/t7W2of+BglGjrud5lrC6wX/SGw==
X-Google-Smtp-Source: AGHT+IG1ytLpUPhlitUTGeeDBPoXofMiZynUXPgp0YkdMTUKnxFwmmsxNBSWE6G84aVYOLBHwXV0tg==
X-Received: by 2002:a17:902:c401:b0:24b:182b:7144 with SMTP id
 d9443c01a7336-2951a38fdf9mr55212845ad.7.1761945333096; 
 Fri, 31 Oct 2025 14:15:33 -0700 (PDT)
Received: from fedora.. ([103.2.232.250]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b93b8aa3ff1sm3023320a12.14.2025.10.31.14.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 14:15:32 -0700 (PDT)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: deller@gmx.de,
	qemu-devel@nongnu.org
Cc: sarkarsoumyajyoti23@gmail.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 RemZapCypher <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 3/3] i82596: Implement enhanced TX/RX with packet queuing and
 filtering
Date: Sat,  1 Nov 2025 02:45:16 +0530
Message-ID: <20251031211516.208488-4-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251031211516.208488-1-soumyajyotisarkar23@gmail.com>
References: <20251031211516.208488-1-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pg1-x544.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 31 Oct 2025 17:26:56 -0400
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

From: RemZapCypher <soumyajyotisarkar23@gmail.com>

In this patch I have done the following:
- Rewrote transmit path with CSMA/CD collision handling and retry logic
- Implemented flexible TX buffer descriptor (TBD) chain processing
- Rewrote receive path with packet filtering and monitor mode support
- Added RX packet queue for handling resource exhaustion
- Implemented queue flush timer
- Added RX state machine with proper state transitions
- Implemented packet filtering
- Added SCB RU_START enhancement to find a usable RFDs
- Implemented dump & diagnostics functionality 
- Added bus throttle timer
- Enhanced signal_ca with a proper initialization sequence
- And finally, adding self-test functionality

Note:
With this patch, and the previous ones in the patch series, we would be
able to achive proper 82596 NIC emulation.

---
 hw/net/i82596.c     | 2003 ++++++++++++++++++++++++++++++++-----------
 hw/net/trace-events |    8 +-
 2 files changed, 1512 insertions(+), 499 deletions(-)

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index 859cc88b2e..f6ee28e7c7 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -51,7 +51,7 @@
 
 #define ENABLE_DEBUG 0
 
-#if defined(ENABLE_DEBUG)
+#if ENABLE_DEBUG
 #define DBG(x)          x
 #else
 #define DBG(x)          do { } while (0)
@@ -274,6 +274,10 @@ struct qemu_ether_header {
 };
 
 #define PRINT_PKTHDR(txt, BUF) do {                  \
+    struct qemu_ether_header *hdr = (void *)(BUF); \
+    printf(txt ": packet dhost=" MAC_FMT ", shost=" MAC_FMT ", type=0x%04x\n",\
+           MAC_ARG(hdr->ether_dhost), MAC_ARG(hdr->ether_shost),        \
+           be16_to_cpu(hdr->ether_type));       \
 } while (0)
 
 static void i82596_cleanup(I82596State *s)
@@ -324,104 +328,1022 @@ static void i82596_s_reset(I82596State *s)
     s->last_tx_len = 0;
 
     s->last_good_rfa = 0;
-    s->current_rx_desc = 0;
-    s->current_tx_desc = 0;
-    s->tx_retry_addr = 0;
-    s->tx_retry_count = 0;
+    s->queue_head = 0;
+    s->queue_tail = 0;
+    s->queue_count = 0;
 
-    s->rnr_signaled = false;
-    s->flushing_queue = false;
+    s->t_on = 0xFFFF;
+    s->t_off = 0;
+    s->throttle_state = true;
+
+    if (!s->throttle_timer) {
+        s->throttle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                       i82596_bus_throttle_timer, s);
+    } else {
+        timer_del(s->throttle_timer);
+    }
+
+    if (!I596_FULL_DUPLEX && s->t_on != 0xFFFF) {
+        timer_mod(s->throttle_timer,
+                 qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                 s->t_on * NANOSECONDS_PER_MICROSECOND);
+    }
+}
+
+void i82596_h_reset(void *opaque)
+{
+    I82596State *s = opaque;
+
+    i82596_s_reset(s);
+}
+
+/*
+ * Mode Transition of address functionality.
+ * Note: As of now the 82596 is tested only for Linear Mode as it is most
+ * widely used by Linux and HPUX systems. This function is here for
+ * futureproofing our 82596 device model.
+ * According to the documentation the translation of addresses based on mode
+ * are done for the following cases: ISCP, SCB, CBP, RFD, TFD,
+ * RBD, TBD, Rx Buffers, Tx Buffers
+ * Please refer to the documentation for more details.
+ */
+static inline uint32_t i82596_translate_address(I82596State *s,
+                                                 uint32_t addr,
+                                                 bool is_data_buffer)
+{
+    if (addr == I596_NULL || addr == 0) {
+        return addr;
+    }
+    switch (s->mode) {
+    case I82586_MODE:
+        if (is_data_buffer) {
+            return addr & 0x00FFFFFF;
+        } else {
+            if (s->scb_base) {
+                return (s->scb_base & 0x00FFFFFF) + (addr & 0xFFFF);
+            } else {
+                return addr & 0x00FFFFFF;
+            }
+        }
+        break;
+    case I82596_MODE_SEGMENTED:
+        if (is_data_buffer) {
+            return addr;
+        } else {
+            if (s->scb_base) {
+                return s->scb_base + (addr & 0xFFFF);
+            } else {
+                return addr;
+            }
+        }
+        break;
+    case I82596_MODE_LINEAR:
+    default:
+        return addr;
+    }
+}
+
+/* (TFD) Transmit Frame Descriptor  */
+struct i82596_tx_descriptor {
+    uint16_t status_bits;
+    uint16_t command;
+    uint32_t link_addr;
+    uint32_t tbd_addr;
+    uint16_t tcb_count;
+    uint8_t  dest_addr[6];
+    uint16_t length_field;
+};
+
+/* (TBD) Transmit Buffer Descriptor */
+struct i82596_tx_buffer_desc {
+    uint16_t size;
+    uint32_t link;
+    uint32_t buffer;
+};
+
+/* (RFD) Receive Frame Descriptor  */
+struct i82596_rx_descriptor {
+    uint16_t status_bits;
+    uint16_t command;
+    uint32_t link;
+    uint32_t rbd_addr;
+    uint16_t actual_count;
+    uint16_t size;
+    uint8_t  dest_addr[6];
+    uint8_t  src_addr[6];
+    uint16_t length_field;
+};
+
+/* (RBD) Receive Buffer Descriptor */
+struct i82596_rx_buffer_desc {
+    uint16_t actual_count;
+    uint32_t next_rbd_addr;
+    uint32_t buffer_addr;
+    uint16_t size;
+};
+
+static void i82596_tx_tfd_read(I82596State *s, hwaddr addr,
+                                struct i82596_tx_descriptor *desc)
+{
+    desc->status_bits = get_uint16(addr + 0);
+    desc->command = get_uint16(addr + 2);
+    desc->link_addr = get_uint32(addr + 4);
+    desc->tbd_addr = get_uint32(addr + 8);
+    desc->tcb_count = get_uint16(addr + 12);
+    address_space_read(&address_space_memory, addr + 14,
+                      MEMTXATTRS_UNSPECIFIED, desc->dest_addr, 6);
+    desc->length_field = get_uint16(addr + 20);
+}
+
+static void i82596_tx_tfd_write(I82596State *s, hwaddr addr,
+                                 struct i82596_tx_descriptor *desc)
+{
+    set_uint16(addr + 0, desc->status_bits);
+    set_uint16(addr + 2, desc->command);
+    set_uint32(addr + 4, desc->link_addr);
+    set_uint32(addr + 8, desc->tbd_addr);
+    set_uint16(addr + 12, desc->tcb_count);
+    address_space_write(&address_space_memory, addr + 14,
+                       MEMTXATTRS_UNSPECIFIED, desc->dest_addr, 6);
+    set_uint16(addr + 20, desc->length_field);
+}
+
+static void i82596_tbd_read(I82596State *s, hwaddr addr,
+                            struct i82596_tx_buffer_desc *tbd)
+{
+    tbd->size = get_uint16(addr + 0);
+    tbd->link = get_uint32(addr + 4);
+    tbd->buffer = get_uint32(addr + 8);
+}
+
+#if ENABLE_DEBUG
+static void i82596_tx_tfd_dump(I82596State *s, hwaddr addr,
+                                      struct i82596_tx_descriptor *desc)
+{
+    DBG(printf("TFD @0x%08lx:\n", (unsigned long)addr));
+    DBG(printf("  Status=0x%04x Cmd=0x%04x Link=0x%08x TBD=0x%08x\n",
+               desc->status_bits, desc->command, desc->link_addr,
+               desc->tbd_addr));
+    DBG(printf("  Count=%d (0x%04x)\n",
+               desc->tcb_count & SIZE_MASK, desc->tcb_count));
+    DBG(printf("  Dest MAC=" MAC_FMT "\n", MAC_ARG(desc->dest_addr)));
+    DBG(printf("  Length/Type=0x%04x\n", desc->length_field));
+}
+#endif
+
+#if ENABLE_DEBUG
+static void i82596_tbd_dump(I82596State *s, hwaddr addr,
+                            struct i82596_tx_buffer_desc *tbd)
+{
+    DBG(printf("  TBD @0x%08lx: size=%d EOF=%d EL=%d buf=0x%08x\n",
+               (unsigned long)addr,
+               tbd->size & 0x3FFF,
+               !!(tbd->size & I596_EOF),
+               !!(tbd->size & CMD_EOL),
+               tbd->buffer));
+}
+#endif
+
+static void i82596_rx_rfd_read(I82596State *s, hwaddr addr,
+                                struct i82596_rx_descriptor *desc)
+{
+    desc->status_bits = get_uint16(addr + 0x0);
+    desc->command = get_uint16(addr + 0x2);
+    desc->link = get_uint32(addr + 0x4);
+    desc->rbd_addr = get_uint32(addr + 0x8);
+    desc->actual_count = get_uint16(addr + 0xC);
+    desc->size = get_uint16(addr + 0xE);
+
+    address_space_read(&address_space_memory, addr + 0x10,
+                      MEMTXATTRS_UNSPECIFIED, desc->dest_addr, 6);
+    address_space_read(&address_space_memory, addr + 0x16,
+                      MEMTXATTRS_UNSPECIFIED, desc->src_addr, 6);
+    desc->length_field = get_uint16(addr + 28);
+}
+
+static void i82596_rx_desc_write(I82596State *s, hwaddr addr,
+                                  struct i82596_rx_descriptor *desc,
+                                  bool write_full)
+{
+    set_uint16(addr + 0x0, desc->status_bits);
+    set_uint16(addr + 0xC, desc->actual_count);
+
+    if (write_full) {
+        set_uint16(addr + 0x2, desc->command);
+        set_uint32(addr + 0x4, desc->link);
+        set_uint32(addr + 0x8, desc->rbd_addr);
+        set_uint16(addr + 0xE, desc->size);
+
+        address_space_write(&address_space_memory, addr + 0x10,
+                          MEMTXATTRS_UNSPECIFIED, desc->dest_addr, 6);
+        address_space_write(&address_space_memory, addr + 0x16,
+                          MEMTXATTRS_UNSPECIFIED, desc->src_addr, 6);
+        set_uint16(addr + 0x1C, desc->length_field);
+    }
+}
+
+static void i82596_rbd_read(I82596State *s, hwaddr addr,
+                            struct i82596_rx_buffer_desc *rbd)
+{
+    rbd->actual_count = get_uint16(addr + 0x0);
+    rbd->next_rbd_addr = get_uint32(addr + 0x4);
+    rbd->buffer_addr = get_uint32(addr + 0x8);
+    rbd->size = get_uint16(addr + 0xC);
+}
+
+static void i82596_rbd_write(I82596State *s, hwaddr addr,
+                             struct i82596_rx_buffer_desc *rbd)
+{
+    set_uint16(addr + 0x0, rbd->actual_count);
+    set_uint32(addr + 0x4, rbd->next_rbd_addr);
+    set_uint32(addr + 0x8, rbd->buffer_addr);
+    set_uint16(addr + 0xC, rbd->size);
+}
+
+#if ENABLE_DEBUG
+static void i82596_rx_rfd_dump(I82596State *s, hwaddr addr,
+                                      struct i82596_rx_descriptor *desc)
+{
+    DBG(printf("RFD @0x%08lx:\n", (unsigned long)addr));
+    DBG(printf("  Status=0x%04x Cmd=0x%04x Link=0x%08x RBD=0x%08x\n",
+               desc->status_bits, desc->command, desc->link, desc->rbd_addr));
+    DBG(printf("  Count=%d Size=%d EOF=%d F=%d\n",
+               desc->actual_count & 0x3FFF,
+               desc->size & 0x3FFF,
+               !!(desc->actual_count & I596_EOF),
+               !!(desc->actual_count & 0x4000)));
+    DBG(printf("  Dest=" MAC_FMT " Src=" MAC_FMT " Len=0x%04x\n",
+               MAC_ARG(desc->dest_addr), MAC_ARG(desc->src_addr),
+               desc->length_field));
+}
+
+static void i82596_rbd_dump(I82596State *s, hwaddr addr,
+                            struct i82596_rx_buffer_desc *rbd)
+{
+    DBG(printf("  RBD @0x%08lx: count=%d EOF=%d F=%d buf=0x%08x size=%d "
+               "EL=%d P=%d\n", (unsigned long)addr,
+               rbd->actual_count & 0x3FFF,
+               !!(rbd->actual_count & I596_EOF),
+               !!(rbd->actual_count & 0x4000),
+               rbd->buffer_addr,
+               rbd->size & 0x3FFF,
+               !!(rbd->size & CMD_EOL),
+               !!(rbd->size & 0x4000)));
+}
+#endif
+
+static int i82596_tx_copy_buffers(I82596State *s, hwaddr tfd_addr,
+                                  struct i82596_tx_descriptor *desc)
+{
+    bool simplified_mode = !(desc->command & CMD_FLEX);
+    uint32_t total_len = 0;
+    uint32_t tbd_addr;
+    struct i82596_tx_buffer_desc tbd;
+
+    s->tx_frame_len = 0;
+
+    if (simplified_mode) {
+        uint16_t frame_len = desc->tcb_count & SIZE_MASK;
+        if (frame_len == 0 || frame_len > sizeof(s->tx_buffer)) {
+            return -1;
+        }
+        address_space_read(&address_space_memory, tfd_addr + 16,
+                          MEMTXATTRS_UNSPECIFIED, s->tx_buffer, frame_len);
+        total_len = frame_len;
+
+    } else {
+        tbd_addr = desc->tbd_addr;
+        while (tbd_addr != I596_NULL && tbd_addr != 0) {
+            uint16_t buf_size;
+            uint32_t buf_addr;
+            tbd_addr = i82596_translate_address(s, tbd_addr, false);
+            if (tbd_addr == 0 || tbd_addr == I596_NULL) {
+                return -1;
+            }
+            i82596_tbd_read(s, tbd_addr, &tbd);
+#if ENABLE_DEBUG
+            DBG(i82596_tbd_dump(s, tbd_addr, &tbd));
+#endif
+            buf_size = tbd.size & SIZE_MASK;
+            buf_addr = i82596_translate_address(s, tbd.buffer, true);
+
+            if (total_len + buf_size > sizeof(s->tx_buffer)) {
+                return -1;
+            }
+
+            if (buf_size > 0 && buf_addr != 0 && buf_addr != I596_NULL) {
+                address_space_read(&address_space_memory, buf_addr,
+                                  MEMTXATTRS_UNSPECIFIED,
+                                  s->tx_buffer + total_len, buf_size);
+                total_len += buf_size;
+            }
+            if (tbd.size & I596_EOF) {
+                break;
+            }
+            tbd_addr = tbd.link;
+        }
+    }
+
+    s->tx_frame_len = total_len;
+    return total_len;
+}
+
+static int i82596_tx_process_frame(I82596State *s, bool insert_crc)
+{
+    uint32_t total_len = s->tx_frame_len;
+
+    if (total_len == 0) {
+        return 0;
+    }
+
+    if (I596_NO_SRC_ADD_IN == 0 && total_len >= ETH_ALEN * 2) {
+        memcpy(&s->tx_buffer[ETH_ALEN], s->conf.macaddr.a, ETH_ALEN);
+    }
+
+    if (I596_PADDING && total_len < I596_MIN_FRAME_LEN) {
+        size_t pad_len = I596_MIN_FRAME_LEN - total_len;
+        memset(s->tx_buffer + total_len, 0, pad_len);
+        total_len = I596_MIN_FRAME_LEN;
+    }
+
+    if (insert_crc) {
+        total_len = i82596_append_crc(s, s->tx_buffer, total_len);
+    }
+
+    s->tx_frame_len = total_len;
+    return total_len;
+}
+
+static void i82596_tx_update_status(I82596State *s, hwaddr tfd_addr,
+                                    struct i82596_tx_descriptor *desc,
+                                    uint16_t tx_status,
+                                    uint16_t collision_count,
+                                    bool success)
+{
+    desc->status_bits = STAT_C;
+
+    if (success) {
+        desc->status_bits |= STAT_OK;
+    } else {
+        desc->status_bits |= STAT_A;
+    }
+
+    if (collision_count > 0) {
+        desc->status_bits |= (collision_count & 0x0F);
+    }
+
+    i82596_tx_tfd_write(s, tfd_addr, desc);
+}
+
+static int i82596_tx_csma_cd(I82596State *s, uint16_t *tx_status)
+{
+    int retry_count = 0;
+    bool medium_available;
+
+    if (I596_FULL_DUPLEX || I596_LOOPBACK) {
+        return 0;
+    }
+
+    while (retry_count < CSMA_MAX_RETRIES) {
+        medium_available = i82596_check_medium_status(s);
+
+        if (medium_available) {
+            break;
+        }
+        i82596_csma_backoff(s, retry_count);
+        retry_count++;
+        s->total_collisions++;
+    }
+    if (retry_count >= CSMA_MAX_RETRIES) {
+        *tx_status |= TX_ABORTED_ERRORS;
+        return -1;
+    }
+    if (retry_count > 0) {
+        *tx_status |= TX_COLLISIONS;
+        s->collision_events++;
+    }
+
+    return retry_count;
+}
+
+static void i82596_transmit(I82596State *s, uint32_t addr)
+{
+    struct i82596_tx_descriptor tfd;
+    hwaddr tfd_addr = addr;
+    uint16_t tx_status = 0;
+    int collision_count = 0;
+    int frame_len;
+    bool success = true;
+    bool insert_crc;
+
+    i82596_tx_tfd_read(s, tfd_addr, &tfd);
+
+#if ENABLE_DEBUG
+    DBG(i82596_tx_tfd_dump(s, tfd_addr, &tfd));
+#endif
+
+    s->current_tx_desc = tfd_addr;
+    insert_crc = (I596_NOCRC_INS == 0) && ((tfd.command & 0x10) == 0) &&
+                 !I596_LOOPBACK;
+    collision_count = i82596_tx_csma_cd(s, &tx_status);
+    if (collision_count < 0) {
+        success = false;
+        goto tx_complete;
+    }
+    frame_len = i82596_tx_copy_buffers(s, tfd_addr, &tfd);
+    if (frame_len < 0) {
+        tx_status |= TX_ABORTED_ERRORS;
+        success = false;
+        goto tx_complete;
+    }
+    frame_len = i82596_tx_process_frame(s, insert_crc);
+    if (frame_len <= 0) {
+        tx_status |= TX_ABORTED_ERRORS;
+        success = false;
+        goto tx_complete;
+    }
+    s->last_tx_len = frame_len;
+    trace_i82596_transmit(frame_len, addr);
+
+    if (I596_LOOPBACK) {
+        i82596_receive(qemu_get_queue(s->nic), s->tx_buffer, frame_len);
+    } else {
+        if (s->nic) {
+            qemu_send_packet_raw(qemu_get_queue(s->nic), s->tx_buffer,
+                                 frame_len);
+        }
+    }
+
+tx_complete:
+    i82596_tx_update_status(s, tfd_addr, &tfd, tx_status, collision_count,
+                            success);
+    i82596_update_statistics(s, true, tx_status, collision_count);
+    if (tfd.command & CMD_INTR) {
+        i82596_update_cu_status(s, tfd.status_bits, true);
+    }
+}
+
+bool i82596_can_receive(NetClientState *nc)
+{
+    I82596State *s = qemu_get_nic_opaque(nc);
+
+    if (I596_LOOPBACK || !s->lnkst) {
+        return false;
+    }
+
+    if (s->rx_status == RX_SUSPENDED || s->rx_status == RX_IDLE ||
+        s->rx_status == RX_NO_RESOURCES) {
+        return true;
+    }
+
+    if (!s->throttle_state && !I596_FULL_DUPLEX) {
+        return (s->queue_count < PACKET_QUEUE_SIZE);
+    }
+
+    return true;
+}
+
+static int i82596_validate_receive_state(I82596State *s, size_t *sz,
+                                          bool from_queue)
+{
+    if (*sz < 14 || *sz > PKT_BUF_SZ - 4) {
+        trace_i82596_receive_analysis(">>> Packet size invalid");
+        return -1;
+    }
+
+    if (!from_queue && s->rx_status == RX_SUSPENDED) {
+        trace_i82596_receive_analysis(">>> Receiving is suspended");
+        return -1;
+    }
+
+    if (s->rx_status != RX_READY && s->rx_status != RX_SUSPENDED) {
+        trace_i82596_receive_analysis(">>> RU not ready");
+        return -1;
+    }
+
+    if (!s->lnkst) {
+        trace_i82596_receive_analysis(">>> Link is down");
+        return -1;
+    }
+
+    return 1;
+}
+
+static bool i82596_check_packet_filter(I82596State *s, const uint8_t *buf,
+                                        uint16_t *is_broadcast)
+{
+    static const uint8_t broadcast_macaddr[6] = {
+        0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+
+    if (I596_PROMISC || I596_LOOPBACK) {
+        trace_i82596_receive_analysis(
+            ">>> packet received in promiscuous mode");
+        return true;
+    } else {
+        if (!memcmp(buf, broadcast_macaddr, 6)) {
+            /* broadcast address */
+            if (I596_BC_DISABLE) {
+                trace_i82596_receive_analysis(">>> broadcast packet rejected");
+                return false;
+            }
+            trace_i82596_receive_analysis(">>> broadcast packet received");
+            *is_broadcast = 1;
+            return true;
+        } else if (buf[0] & 0x01) {
+            /* multicast */
+            if (!I596_MC_ALL) {
+                trace_i82596_receive_analysis(">>> multicast packet rejected");
+                return false;
+            }
+
+            int mcast_idx = (net_crc32(buf, ETH_ALEN) & BITS(7, 2)) >> 2;
+            assert(mcast_idx < 8 * sizeof(s->mult));
+
+            if (!(s->mult[mcast_idx >> 3] & (1 << (mcast_idx & 7)))) {
+                trace_i82596_receive_analysis(">>> multicast address mismatch");
+                return false;
+            }
+
+            trace_i82596_receive_analysis(">>> multicast packet received");
+            *is_broadcast = 1;
+            return true;
+        } else if (!memcmp(s->conf.macaddr.a, buf, 6)) {
+            /* match */
+            trace_i82596_receive_analysis(
+                ">>> physical address matching packet received");
+            return true;
+        } else {
+            trace_i82596_receive_analysis(">>> unknown packet");
+            return false;
+        }
+    }
+}
+
+/* MONITOR MODE */
+static bool i82596_monitor(I82596State *s, const uint8_t *buf, size_t sz,
+                           bool packet_passes_filter)
+{
+    if (I596_MONITOR_MODE == MONITOR_DISABLED) {
+        return true;
+    }
+    if (sz < I596_MIN_FRAME_LEN) {
+        s->short_fr_error++;
+    }
+    if ((sz % 2) != 0) {
+        s->align_err++;
+    }
+
+    switch (I596_MONITOR_MODE) {
+    case MONITOR_NORMAL: /* No monitor, just add to total frames */
+        if (packet_passes_filter) {
+            s->total_good_frames++;
+            return true;
+        } else {
+            return false;
+        }
+        break;
+    case MONITOR_FILTERED: /* Monitor only filtered packets */
+        s->total_frames++;
+        if (packet_passes_filter) {
+            s->total_good_frames++;
+        }
+        return false;
+    case MONITOR_ALL: /* Monitor all packets */
+        s->total_frames++;
+        if (packet_passes_filter) {
+            s->total_good_frames++;
+        }
+        return false;
+
+    default:
+        return true;
+    }
+}
+
+static void i82596_update_rx_state(I82596State *s, int new_state)
+{
+    if (s->rx_status != new_state) {
+        trace_i82596_rx_state_change(s->rx_status, new_state);
+    }
+
+    s->rx_status = new_state;
+
+    switch (new_state) {
+    case RX_NO_RESOURCES:
+        if (!s->rnr_signaled) {
+            s->scb_status |= SCB_STATUS_RNR;
+            s->rnr_signaled = true;
+        }
+        break;
+    case RX_SUSPENDED:
+        if (!s->rnr_signaled) {
+            s->scb_status |= SCB_STATUS_RNR;
+            s->rnr_signaled = true;
+        }
+
+        if (s->queue_count > 0 && !s->flushing_queue) {
+            i82596_flush_packet_queue(s);
+            if (s->queue_count > 0) {
+                timer_mod(s->flush_queue_timer,
+                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 50000);
+            }
+        }
+        break;
+    case RX_READY:
+        /* When RU becomes ready, flush buffered packets */
+        if (s->queue_count > 0) {
+            i82596_flush_packet_queue(s);
+        }
+        break;
+    default:
+        break;
+    }
+}
+
+static void i82596_rx_store_frame_header(I82596State *s,
+                                         struct i82596_rx_descriptor *rfd,
+                                         const uint8_t *buf, size_t size)
+{
+    memcpy(rfd->dest_addr, buf, 6);
+    if (size >= 12) {
+        memcpy(rfd->src_addr, buf + 6, 6);
+    }
+    if (size >= 14) {
+        rfd->length_field = (buf[12] << 8) | buf[13];
+    }
+}
+
+static size_t i82596_rx_copy_to_rfd(I82596State *s, hwaddr rfd_addr,
+                                    const uint8_t *buf, size_t size,
+                                    size_t rfd_size)
+{
+    size_t to_copy = MIN(size, rfd_size);
+    size_t data_offset = 0x1E; /* Bypassing the header */
+
+    if (to_copy > 0) {
+        address_space_write(&address_space_memory, rfd_addr + data_offset,
+                           MEMTXATTRS_UNSPECIFIED, buf, to_copy);
+    }
+    return to_copy;
+}
+
+static size_t i82596_rx_copy_to_rbds(I82596State *s, hwaddr rbd_addr,
+                                     const uint8_t *buf, size_t size,
+                                     bool *out_of_resources,
+                                     hwaddr *remaining_rbd)
+{
+    size_t bytes_copied = 0;
+    hwaddr current_rbd = rbd_addr;
+    *out_of_resources = false;
+    *remaining_rbd = I596_NULL;
+
+    while (bytes_copied < size && current_rbd != I596_NULL &&
+           current_rbd != 0) {
+        struct i82596_rx_buffer_desc rbd;
+        i82596_rbd_read(s, current_rbd, &rbd);
+        if (rbd.size & 0x4000) {  /* P bit set */
+            break;
+        }
+
+        uint16_t buf_size = rbd.size & 0x3FFF;
+
+        if (buf_size == 0) {
+            current_rbd = i82596_translate_address(s, rbd.next_rbd_addr, false);
+            continue;
+        }
+
+        hwaddr buf_addr = i82596_translate_address(s, rbd.buffer_addr, true);
+#if ENABLE_DEBUG
+        i82596_rbd_dump(s, current_rbd, &rbd);
+#endif
+        if (buf_addr == 0 || buf_addr == I596_NULL) {
+            *out_of_resources = true;
+            break;
+        }
+        size_t remaining = size - bytes_copied;
+        size_t to_copy = MIN(remaining, buf_size);
+        if (to_copy > 0) {
+            address_space_write(&address_space_memory, buf_addr,
+                               MEMTXATTRS_UNSPECIFIED,
+                               buf + bytes_copied, to_copy);
+            bytes_copied += to_copy;
+        }
+        rbd.actual_count = to_copy | 0x4000;  /* Set F (filled) bit */
+        if (bytes_copied >= size) {
+            rbd.actual_count |= 0x8000;  /* Set EOF bit (bit 15) */
+        }
+        i82596_rbd_write(s, current_rbd, &rbd);
+        if (rbd.size & CMD_EOL) {  /* EL bit */
+            if (bytes_copied < size) {
+                *out_of_resources = true;
+            }
+            current_rbd = I596_NULL;
+            break;
+        }
+        current_rbd = i82596_translate_address(s, rbd.next_rbd_addr, false);
+    }
 
-    memset(s->tx_buffer, 0, sizeof(s->tx_buffer));
-    memset(s->rx_buffer, 0, sizeof(s->rx_buffer));
-    s->tx_frame_len = 0;
-    s->rx_frame_len = 0;
+    *remaining_rbd = current_rbd;
+    return bytes_copied;
 }
 
-void i82596_h_reset(void *opaque)
+static inline size_t i82596_get_crc_size(I82596State *s)
 {
-    I82596State *s = opaque;
-
-    i82596_s_reset(s);
+    return I596_CRC16_32 ? 4 : 2;
 }
 
-/*
- * Address Translation Implementation
- * Handles segmented and linear memory modes for i82596.
- * Returns physical address for DMA operations.
- * Returns I596_NULL (0xffffffff) on invalid addresses.
- */
-static inline uint32_t i82596_translate_address(I82596State *s,
-                                                 uint32_t logical_addr,
-                                                 bool is_data_buffer)
+static ssize_t i82596_receive_packet(I82596State *s, const uint8_t *buf,
+                                      size_t size, bool from_queue)
 {
-    if (logical_addr == I596_NULL || logical_addr == 0) {
-        return logical_addr;
+    struct i82596_rx_descriptor rfd;
+    uint32_t rfd_addr, rbd_addr;
+    uint16_t rx_status = 0;
+    uint16_t is_broadcast = 0;
+    bool packet_completed = true;
+    bool simplified_mode = false;
+    size_t frame_size = size;
+    size_t payload_size = 0;
+    size_t bytes_copied = 0;
+    const uint8_t *packet_data = buf;
+    bool crc_valid = true;
+    bool out_of_resources = false;
+    size_t crc_size = i82596_get_crc_size(s);
+
+    DBG(PRINT_PKTHDR("[RX]", buf));
+
+    if (i82596_validate_receive_state(s, &size, from_queue) < 0) {
+        return -1;
     }
 
-    switch (s->mode) {
-    case I82596_MODE_LINEAR:
-        return logical_addr;
+    bool passes_filter = i82596_check_packet_filter(s, buf, &is_broadcast);
 
-    case I82596_MODE_SEGMENTED: {
-        uint32_t base = (logical_addr >> 16) & 0xFFFF;
-        uint32_t offset = logical_addr & 0xFFFF;
+    if (!i82596_monitor(s, buf, size, passes_filter) && (!passes_filter)) {
+        return size;
+    }
+
+
+    rfd_addr = get_uint32(s->scb + 8);
+
+    if (rfd_addr == 0 || rfd_addr == I596_NULL) {
+        i82596_update_rx_state(s, RX_NO_RESOURCES);
+        s->resource_err++;
+        set_uint16(s->scb, get_uint16(s->scb) | SCB_STATUS_RNR);
+        i82596_update_scb_irq(s, true);
+        return -1;
+    }
+
+    i82596_rx_rfd_read(s, rfd_addr, &rfd);
+#if ENABLE_DEBUG
+    i82596_rx_rfd_dump(s, rfd_addr, &rfd);
+#endif
+
+    s->current_rx_desc = rfd_addr;
+
+    if (rfd.status_bits & STAT_C) {
+        return -1;
+    }
+
+    DBG(printf("RX: Using RFD=0x%08lx\n", (unsigned long)rfd_addr));
+
+    /* 0: Simplified Mode 1: Flexible Mode */
+    simplified_mode = !(rfd.command & CMD_FLEX);
+
+    set_uint16(rfd_addr, STAT_B);
+
+    if (frame_size < 14) {
+        DBG(printf("RX: Frame too short (%zu bytes)\n", frame_size));
+        rx_status |= RX_LENGTH_ERRORS;
+        i82596_record_error(s, RX_LENGTH_ERRORS, false);
+        s->short_fr_error++;
+        packet_completed = false;
+        goto rx_complete;
+    }
+
+    payload_size = frame_size;
+    do {
+        if (simplified_mode && I596_LOOPBACK) {
+            uint16_t rfd_size = rfd.size & 0x3FFF;
+
+            if (rfd_size % 2 != 0) {
+                rx_status |= RX_LENGTH_ERRORS;
+                i82596_record_error(s, RX_LENGTH_ERRORS, false);
+                s->align_err++;
+                packet_completed = false;
+                goto rx_complete;
+            }
+
+            if (payload_size > rfd_size) {
+                rx_status |= RFD_STATUS_TRUNC;
+                payload_size = rfd_size;
+                packet_completed = !SAVE_BAD_FRAMES ? false : true;
+            }
+
+            if (payload_size > 0) {
+                bytes_copied = i82596_rx_copy_to_rfd(s, rfd_addr, packet_data,
+                                                      payload_size, rfd_size);
+            }
+
+            i82596_rx_store_frame_header(s, &rfd, packet_data, frame_size);
 
-        if (is_data_buffer) {
-            return (base << 4) + offset;
         } else {
-            if (base == 0xFFFF && offset == 0xFFFF) {
-                return I596_NULL;
+            uint16_t rfd_size = rfd.size & 0x3FFF; /* SIZE_MASK */
+            size_t rfd_frame_size = 0;
+            size_t remaining_to_copy = payload_size - bytes_copied;
+            if (rfd_size > 0 && remaining_to_copy > 0) {
+                size_t data_offset = 0x10;
+
+                rfd_frame_size = MIN(remaining_to_copy, rfd_size);
+                address_space_write(&address_space_memory,
+                                    rfd_addr + data_offset,
+                                    MEMTXATTRS_UNSPECIFIED,
+                                    packet_data + bytes_copied,
+                                    rfd_frame_size);
+                bytes_copied += rfd_frame_size;
+            }
+
+            if (bytes_copied < payload_size) {
+                size_t remaining = payload_size - bytes_copied;
+                rbd_addr = i82596_translate_address(s, rfd.rbd_addr, false);
+
+                if (rbd_addr == I596_NULL || rbd_addr == 0) {
+                    rx_status |= RFD_STATUS_TRUNC | RFD_STATUS_NOBUFS;
+                    i82596_record_error(s, RFD_STATUS_NOBUFS, false);
+                    packet_completed = true;
+                } else {
+                    hwaddr remaining_rbd = I596_NULL;
+                    size_t rbd_bytes = i82596_rx_copy_to_rbds(
+                                            s, rbd_addr,
+                                            packet_data + bytes_copied,
+                                            remaining,
+                                            &out_of_resources,
+                                            &remaining_rbd);
+                    bytes_copied += rbd_bytes;
+
+                    uint32_t next_rfd = i82596_translate_address(s, rfd.link,
+                                                                  false);
+                    if (next_rfd != I596_NULL && next_rfd != 0) {
+                        if (remaining_rbd != I596_NULL && remaining_rbd != 0) {
+                            DBG(printf("RX: Updating next RFD 0x%08x to point "
+                                   "to remaining RBD 0x%08lx\n",
+                                   next_rfd, (unsigned long)remaining_rbd));
+                            set_uint32(next_rfd + 8, remaining_rbd);
+                        } else {
+                            DBG(printf("RX: Next RFD 0x%08x has no RBDs left, "
+                                   "set NULL\n", next_rfd));
+                            set_uint32(next_rfd + 8, I596_NULL);
+                        }
+                    }
+
+                    if (out_of_resources) {
+                        DBG(printf("RX: Out of RBDs mid-frame\n"));
+                        i82596_record_error(s, RFD_STATUS_NOBUFS, false);
+                        rx_status |= RFD_STATUS_TRUNC | RFD_STATUS_NOBUFS;
+                        packet_completed = true;
+                    }
+
+                    if (bytes_copied < payload_size) {
+                        DBG(printf("RX: Incomplete copy (%zu/%zu bytes)\n",
+                               bytes_copied, payload_size));
+                        rx_status |= RFD_STATUS_TRUNC;
+                        packet_completed = true;
+                    }
+                }
             }
-            return s->scb_base + ((base << 4) + offset);
         }
-    }
+        break;
 
-    case I82586_MODE:
-    default:
-        if (is_data_buffer) {
-            return logical_addr;
+    } while (bytes_copied < payload_size);
+
+rx_complete:
+    if (I596_CRCINM && !I596_LOOPBACK && packet_completed) {
+        uint8_t crc_data[4];
+        size_t crc_len = crc_size;
+
+        if (I596_CRC16_32) {
+            uint32_t crc = crc32(~0, packet_data, frame_size);
+            crc = cpu_to_be32(crc);
+            memcpy(crc_data, &crc, 4);
         } else {
-            if ((logical_addr & 0xFFFF0000) == 0xFFFF0000) {
-                return I596_NULL;
-            }
-            return s->scb_base + logical_addr;
+            uint16_t crc = i82596_calculate_crc16(packet_data, frame_size);
+            crc = cpu_to_be16(crc);
+            memcpy(crc_data, &crc, 2);
+        }
+
+        if (simplified_mode) {
+            address_space_write(&address_space_memory,
+                                rfd_addr + 0x1E + bytes_copied,
+                                MEMTXATTRS_UNSPECIFIED, crc_data, crc_len);
         }
     }
-}
 
-static void i82596_transmit(I82596State *s, uint32_t addr)
-{
-    uint32_t tdb_p; /* Transmit Buffer Descriptor */
+    if (packet_completed && crc_valid) {
+        rx_status |= STAT_C | STAT_OK;
+        if (is_broadcast) {
+            rx_status |= 0x0001;
+        }
+    } else if (packet_completed) {
+        rx_status |= STAT_C;
+        if (!crc_valid) {
+            rx_status |= RX_CRC_ERRORS;
+        }
+    } else {
+        rx_status |= STAT_B;
+    }
+
+    rfd.status_bits = rx_status & ~STAT_B;
+    rfd.actual_count = (bytes_copied & 0x3FFF) | 0x4000;
+    if (packet_completed) {
+        rfd.actual_count |= I596_EOF;
+    }
 
-    /* TODO: Check flexible mode */
-    tdb_p = get_uint32(addr + 8);
-    while (tdb_p != I596_NULL) {
-        uint16_t size, len;
-        uint32_t tba;
+    i82596_rx_desc_write(s, rfd_addr, &rfd, (simplified_mode || I596_LOOPBACK));
 
-        size = get_uint16(tdb_p);
-        len = size & SIZE_MASK;
-        tba = get_uint32(tdb_p + 8);
-        trace_i82596_transmit(len, tba);
+    if (rfd.command & CMD_SUSP) {
+        i82596_update_rx_state(s, RX_SUSPENDED);
+        return size;
+    }
+
+    if (rfd.command & CMD_EOL) {
+        i82596_update_rx_state(s, RX_SUSPENDED);
+        return size;
+    }
 
-        if (s->nic && len) {
-            assert(len <= sizeof(s->tx_buffer));
-            address_space_read(&address_space_memory, tba,
-                               MEMTXATTRS_UNSPECIFIED, s->tx_buffer, len);
-            DBG(PRINT_PKTHDR("Send", &s->tx_buffer));
-            DBG(printf("Sending %d bytes\n", len));
-            qemu_send_packet(qemu_get_queue(s->nic), s->tx_buffer, len);
+    if (packet_completed && crc_valid && s->rx_status == RX_READY) {
+        uint32_t next_rfd_addr = i82596_translate_address(s, rfd.link, false);
+        if (next_rfd_addr != 0 && next_rfd_addr != I596_NULL) {
+            set_uint32(s->scb + 8, next_rfd_addr);
         }
 
-        /* was this the last package? */
-        if (size & I596_EOF) {
-            break;
+        s->scb_status |= SCB_STATUS_FR;
+        i82596_update_scb_irq(s, true);
+    }
+    DBG(printf("=== RX: Complete (errors: CRC=%d align=%d res=%d) ===\n\n",
+               s->crc_err, s->align_err, s->resource_err));
+    return size;
+}
+
+ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t size)
+{
+    I82596State *s = qemu_get_nic_opaque(nc);
+
+    if (!I596_FULL_DUPLEX && !s->throttle_state) {
+        if (s->queue_count < PACKET_QUEUE_SIZE) {
+            goto queue_packet;
+        }
+        trace_i82596_receive_suspended();
+        return size;
+    }
+
+    if (s->rx_status != RX_READY) {
+        if (s->queue_count >= PACKET_QUEUE_SIZE) {
+            trace_i82596_receive_queue_full();
+            s->over_err++;
+            set_uint32(s->scb + 22, s->over_err);
+            i82596_record_error(s, RX_OVER_ERRORS, false);
+            return size;
+        }
+queue_packet:
+        if (size <= PKT_BUF_SZ) {
+            memcpy(s->packet_queue[s->queue_head], buf, size);
+            s->packet_queue_len[s->queue_head] = size;
+            s->queue_head = (s->queue_head + 1) % PACKET_QUEUE_SIZE;
+            s->queue_count++;
         }
+        return size;
+    }
+
+    return i82596_receive_packet(s, buf, size, false);
+}
 
-        /* get next buffer pointer */
-        tdb_p = get_uint32(tdb_p + 4);
+ssize_t i82596_receive_iov(NetClientState *nc, const struct iovec *iov,
+                            int iovcnt)
+{
+    size_t sz = 0;
+    uint8_t *buf;
+    int i;
+    for (i = 0; i < iovcnt; i++) {
+        sz += iov[i].iov_len;
+    }
+    if (sz == 0) {
+        return -1;
+    }
+    buf = g_malloc(sz);
+    if (!buf) {
+        return -1;
+    }
+    size_t offset = 0;
+    for (i = 0; i < iovcnt; i++) {
+        if (iov[i].iov_base == NULL) {
+            g_free(buf);
+            return -1;
+        }
+        memcpy(buf + offset, iov[i].iov_base, iov[i].iov_len);
+        offset += iov[i].iov_len;
     }
+    DBG(PRINT_PKTHDR("Receive IOV:", buf));
+    i82596_receive(nc, buf, sz);
+    g_free(buf);
+    return sz;
 }
 
 static void set_individual_address(I82596State *s, uint32_t addr)
@@ -437,26 +1359,6 @@ static void set_individual_address(I82596State *s, uint32_t addr)
     trace_i82596_new_mac(nc->info_str);
 }
 
-static void i82596_configure(I82596State *s, uint32_t addr)
-{
-    uint8_t byte_cnt;
-    byte_cnt = get_byte(addr + 8) & 0x0f;
-
-    byte_cnt = MAX(byte_cnt, 4);
-    byte_cnt = MIN(byte_cnt, sizeof(s->config));
-    /* copy byte_cnt max. */
-    address_space_read(&address_space_memory, addr + 8,
-                       MEMTXATTRS_UNSPECIFIED, s->config, byte_cnt);
-    /* config byte according to page 35ff */
-    s->config[2] &= 0x82; /* mask valid bits */
-    s->config[2] |= 0x40;
-    s->config[7]  &= 0xf7; /* clear zero bit */
-    assert(I596_NOCRC_INS == 0); /* do CRC insertion */
-    s->config[10] = MAX(s->config[10], 5); /* min frame length */
-    s->config[12] &= 0x40; /* only full duplex field valid */
-    s->config[13] |= 0x3f; /* set ones in byte 13 */
-}
-
 static void set_multicast_list(I82596State *s, uint32_t addr)
 {
     uint16_t mc_count, i;
@@ -471,8 +1373,6 @@ static void set_multicast_list(I82596State *s, uint32_t addr)
         uint8_t multicast_addr[ETH_ALEN];
         address_space_read(&address_space_memory, addr + i * ETH_ALEN,
                            MEMTXATTRS_UNSPECIFIED, multicast_addr, ETH_ALEN);
-        DBG(printf("Add multicast entry " MAC_FMT "\n",
-                    MAC_ARG(multicast_addr)));
         unsigned mcast_idx = (net_crc32(multicast_addr, ETH_ALEN) &
                               BITS(7, 2)) >> 2;
         assert(mcast_idx < 8 * sizeof(s->mult));
@@ -494,7 +1394,7 @@ void i82596_set_link_status(NetClientState *nc)
     }
 }
 
-static bool G_GNUC_UNUSED i82596_check_medium_status(I82596State *s)
+static bool i82596_check_medium_status(I82596State *s)
 {
     if (I596_FULL_DUPLEX) {
         return true;
@@ -512,7 +1412,7 @@ static bool G_GNUC_UNUSED i82596_check_medium_status(I82596State *s)
     return true;
 }
 
-static int G_GNUC_UNUSED i82596_csma_backoff(I82596State *s, int retry_count)
+static int i82596_csma_backoff(I82596State *s, int retry_count)
 {
     int backoff_factor, slot_count, backoff_time;
 
@@ -541,7 +1441,7 @@ static uint16_t i82596_calculate_crc16(const uint8_t *data, size_t len)
     return crc;
 }
 
-static size_t G_GNUC_UNUSED i82596_append_crc(I82596State *s, uint8_t *buffer, size_t len)
+static size_t i82596_append_crc(I82596State *s, uint8_t *buffer, size_t len)
 {
     if (len + 4 > PKT_BUF_SZ) {
         return len;
@@ -560,7 +1460,7 @@ static size_t G_GNUC_UNUSED i82596_append_crc(I82596State *s, uint8_t *buffer, s
     }
 }
 
-static void G_GNUC_UNUSED i82596_update_statistics(I82596State *s, bool is_tx,
+static void i82596_update_statistics(I82596State *s, bool is_tx,
                                       uint16_t error_flags,
                                       uint16_t collision_count)
 {
@@ -591,7 +1491,7 @@ static void G_GNUC_UNUSED i82596_update_statistics(I82596State *s, bool is_tx,
 }
 
 /* Bus Throttle Functionality */
-static void G_GNUC_UNUSED i82596_bus_throttle_timer(void *opaque)
+static void i82596_bus_throttle_timer(void *opaque)
 {
     I82596State *s = opaque;
 
@@ -600,42 +1500,210 @@ static void G_GNUC_UNUSED i82596_bus_throttle_timer(void *opaque)
         if (s->t_off > 0) {
             timer_mod(s->throttle_timer,
                       qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-                      (s->t_off * NANOSECONDS_PER_MICROSECOND));
+                      s->t_off * NANOSECONDS_PER_MICROSECOND);
+        } else {
+            s->throttle_state = true;
         }
     } else {
         s->throttle_state = true;
-        if (s->t_on > 0) {
+        if (s->t_on > 0 && s->t_on != 0xFFFF) {
+            timer_mod(s->throttle_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                      s->t_on * NANOSECONDS_PER_MICROSECOND);
+        }
+    }
+}
+
+static void i82596_load_throttle_timers(I82596State *s, bool start_now)
+{
+    uint16_t previous_t_on = s->t_on;
+    uint16_t previous_t_off = s->t_off;
+    s->t_on = get_uint16(s->scb + 36);
+    s->t_off = get_uint16(s->scb + 38);
+
+    bool values_changed = (s->t_on != previous_t_on ||
+                           s->t_off != previous_t_off);
+    if (start_now || (values_changed && s->throttle_timer)) {
+        timer_del(s->throttle_timer);
+        s->throttle_state = true;
+        if (s->t_on > 0 && s->t_on != 0xFFFF && !I596_FULL_DUPLEX) {
             timer_mod(s->throttle_timer,
                       qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-                      (s->t_on * NANOSECONDS_PER_MICROSECOND));
+                      s->t_on * NANOSECONDS_PER_MICROSECOND);
         }
+    }
+}
+
+static void i82596_init_dump_area(I82596State *s, uint8_t *buffer)
+{
+    memset(buffer, 0, DUMP_BUF_SZ);
+
+    printf("This is the dump area function for i82596 QEMU side\n"
+            "If you are seeing this message, please contact:\n"
+            "Soumyajyotii Sarkar <soumyajyotisarkar23@gmail.com>\n"
+            "With the process in which you encountered this issue:\n"
+            "This still needs developement so,\n"
+            "I will be more than delighted to help you out!\n"
+        );
+
+    auto void write_uint16(int offset, uint16_t value)
+    {
+        buffer[offset] = value >> 8;
+        buffer[offset + 1] = value & 0xFF;
+    }
+    auto void write_uint32(int offset, uint32_t value)
+    {
+        write_uint16(offset, value >> 16);
+        write_uint16(offset + 2, value & 0xFFFF);
+    }
+
+    write_uint16(0x00, (s->config[5] << 8) | s->config[4]);
+    write_uint16(0x02, (s->config[3] << 8) | s->config[2]);
+    write_uint16(0x04, (s->config[9] << 8) | s->config[8]);
+    write_uint16(0x06, (s->config[7] << 8) | s->config[6]);
+    write_uint16(0x08, (s->config[13] << 8) | s->config[12]);
+    write_uint16(0x0A, (s->config[11] << 8) | s->config[10]);
+
+    buffer[0x0C] = s->conf.macaddr.a[0];
+    buffer[0x0D] = s->conf.macaddr.a[1];
+    buffer[0x10] = s->conf.macaddr.a[2];
+    buffer[0x11] = s->conf.macaddr.a[3];
+    buffer[0x12] = s->conf.macaddr.a[4];
+    buffer[0x13] = s->conf.macaddr.a[5];
+
+    if (s->last_tx_len > 0) {
+        uint32_t tx_crc = crc32(~0, s->tx_buffer, s->last_tx_len);
+        write_uint16(0x14, tx_crc & 0xFFFF);
+        write_uint16(0x16, tx_crc >> 16);
+    }
+
+    memcpy(&buffer[0x24], s->mult, sizeof(s->mult));
+
+    buffer[0xB0] = s->cu_status;
+    buffer[0xB1] = s->rx_status;
+
+    write_uint32(0xB4, s->crc_err);
+    write_uint32(0xB8, s->align_err);
+    write_uint32(0xBC, s->resource_err);
+    write_uint32(0xC0, s->over_err);
+
+    write_uint32(0xC4, s->short_fr_error);
+    write_uint32(0xC8, s->total_frames);
+    write_uint32(0xCC, s->total_good_frames);
 
-        if (s->cu_status == CU_ACTIVE || s->rx_status == RX_READY) {
-            examine_scb(s);
+    buffer[0xD0] = I596_PROMISC ? 1 : 0;
+    buffer[0xD1] = I596_BC_DISABLE ? 1 : 0;
+    buffer[0xD2] = I596_FULL_DUPLEX ? 1 : 0;
+    buffer[0xD3] = I596_LOOPBACK;
+
+    uint8_t mc_count = 0;
+    for (int i = 0; i < sizeof(s->mult); i++) {
+        uint8_t byte = s->mult[i];
+        while (byte) {
+            if (byte & 0x01) {
+                mc_count++;
+            }
+            byte >>= 1;
         }
     }
+    buffer[0xD4] = mc_count;
+    buffer[0xD5] = I596_NOCRC_INS ? 1 : 0;
+    buffer[0xD6] = I596_CRC16_32 ? 1 : 0;
+
+    write_uint16(0xD8, s->lnkst);
+    buffer[0xDA] = I596_MONITOR_MODE;
+    write_uint32(0xDC, s->collision_events);
+
+    write_uint16(0x110, s->t_on);
+    write_uint16(0x112, s->t_off);
+    write_uint16(0x114, s->throttle_state ? 0x0001 : 0x0000);
+    write_uint16(0x120, s->sysbus);
+    write_uint16(0x128, s->scb_status);
+    write_uint32(0, 0xFFFF0000);
+}
+
+static void i82596_port_dump(I82596State *s, uint32_t dump_addr)
+{
+    uint8_t dump_buffer[DUMP_BUF_SZ];
+
+    i82596_init_dump_area(s, dump_buffer);
+
+    address_space_write(&address_space_memory, dump_addr,
+                      MEMTXATTRS_UNSPECIFIED, dump_buffer, sizeof(dump_buffer));
+
+    set_uint32(dump_addr, 0xFFFF0000);
+    s->scb_status |= SCB_STATUS_CX;
+    s->send_irq = 1;
 }
 
-static int G_GNUC_UNUSED i82596_flush_packet_queue(I82596State *s)
+static void i82596_command_dump(I82596State *s, uint32_t cmd_addr)
 {
-    /* Stub for now - will be implemented in Patch 2 */
-    return 0;
+    uint32_t dump_addr;
+    uint8_t dump_buffer[DUMP_BUF_SZ];
+    uint16_t cmd = get_uint16(cmd_addr + 2);
+    uint16_t status;
+
+    dump_addr = get_uint32(cmd_addr + 8);
+
+    i82596_init_dump_area(s, dump_buffer);
+    address_space_write(&address_space_memory, dump_addr,
+                      MEMTXATTRS_UNSPECIFIED, dump_buffer, sizeof(dump_buffer));
+    status = STAT_C | STAT_OK;
+    set_uint16(cmd_addr, status);
+    if (cmd & CMD_INTR) {
+        s->scb_status |= SCB_STATUS_CX;
+        s->send_irq = 1;
+    }
+    if (cmd & CMD_SUSP) {
+        s->cu_status = CU_SUSPENDED;
+        s->scb_status |= SCB_STATUS_CNA;
+    }
 }
 
-static void G_GNUC_UNUSED i82596_flush_queue_timer(void *opaque)
+static void i82596_configure(I82596State *s, uint32_t addr)
 {
-    /* Stub for now - will be implemented in Patch 2 */
+    uint8_t byte_cnt;
+    byte_cnt = get_byte(addr + 8) & 0x0f;
+    byte_cnt = MAX(byte_cnt, 4);
+    byte_cnt = MIN(byte_cnt, sizeof(s->config));
+    s->config[2] &= 0x82; /* mask valid bits */
+    s->config[2] |= 0x40;
+    s->config[7]  &= 0xf7; /* clear zero bit */
+
+    address_space_read(&address_space_memory, addr + 8,
+                       MEMTXATTRS_UNSPECIFIED, s->config, byte_cnt);
+
+    if (byte_cnt > 12) {
+        s->config[12] &= 0x40;
+
+        if (byte_cnt > 11) {
+            uint8_t monitor_mode = I596_MONITOR_MODE;
+            s->config[11] &= ~0xC0; /* Clear bits 6-7 */
+            s->config[11] |= (monitor_mode << 6); /* Set monitor mode */
+        }
+    }
+
+    if (s->rx_status == RX_READY) {
+        timer_mod(s->flush_queue_timer,
+            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 100000000);
+    }
+
+    s->scb_status |= SCB_STATUS_CNA;
+    s->config[13] |= 0x3f;
+    qemu_set_irq(s->irq, 1);
 }
 
 static void i82596_update_scb_irq(I82596State *s, bool trigger)
 {
+    update_scb_status(s);
+
     if (trigger) {
         s->send_irq = 1;
         qemu_set_irq(s->irq, 1);
     }
 }
 
-static void G_GNUC_UNUSED i82596_update_cu_status(I82596State *s, uint16_t cmd_status,
+static void i82596_update_cu_status(I82596State *s, uint16_t cmd_status,
                                      bool generate_interrupt)
 {
     if (cmd_status & STAT_C) {
@@ -658,6 +1726,11 @@ static void G_GNUC_UNUSED i82596_update_cu_status(I82596State *s, uint16_t cmd_s
     update_scb_status(s);
 }
 
+/**
+ * Update SCB Status
+ * Synchronizes device state with SCB status word and statistics counters.
+ * This function is called frequently to keep the kernel driver updated.
+ */
 static void update_scb_status(I82596State *s)
 {
     s->scb_status = (s->scb_status & 0xf000)
@@ -678,21 +1751,26 @@ static void update_scb_status(I82596State *s)
 
 static void command_loop(I82596State *s)
 {
-    uint16_t cmd;
-    uint16_t status;
-
-    DBG(printf("STARTING COMMAND LOOP cmd_p=%08x\n", s->cmd_p));
-
-    while (s->cmd_p != I596_NULL) {
-        /* set status */
-        status = STAT_B;
-        set_uint16(s->cmd_p, status);
-        status = STAT_C | STAT_OK; /* update, but write later */
-
-        cmd = get_uint16(s->cmd_p + 2);
-        DBG(printf("Running command %04x at %08x\n", cmd, s->cmd_p));
-
-        switch (cmd & 0x07) {
+    while (s->cu_status == CU_ACTIVE && s->cmd_p != I596_NULL &&
+           s->cmd_p != 0) {
+        uint16_t status = get_uint16(s->cmd_p);
+        if (status & (STAT_C | STAT_B)) {
+            uint32_t next = get_uint32(s->cmd_p + 4);
+            if (next == 0 || next == s->cmd_p) {
+                s->cmd_p = I596_NULL;
+                s->cu_status = CU_IDLE;
+                s->scb_status |= SCB_STATUS_CNA;
+                break;
+            }
+            s->cmd_p = i82596_translate_address(s, next, false);
+            continue;
+        }
+        set_uint16(s->cmd_p, STAT_B);
+        uint16_t cmd = get_uint16(s->cmd_p + 2);
+        uint32_t next_addr = get_uint32(s->cmd_p + 4);
+        next_addr = (next_addr == 0) ? I596_NULL :
+                    i82596_translate_address(s, next_addr, false);
+        switch (cmd & CMD_MASK) {
         case CmdNOp:
             break;
         case CmdSASetup:
@@ -702,454 +1780,334 @@ static void command_loop(I82596State *s)
             i82596_configure(s, s->cmd_p);
             break;
         case CmdTDR:
-            /* get signal LINK */
             set_uint32(s->cmd_p + 8, s->lnkst);
             break;
         case CmdTx:
             i82596_transmit(s, s->cmd_p);
-            break;
+            goto skip_status_update;
         case CmdMulticastList:
             set_multicast_list(s, s->cmd_p);
             break;
         case CmdDump:
+            i82596_command_dump(s, s->cmd_p);
+            break;
         case CmdDiagnose:
-            printf("FIXME Command %d !!\n", cmd & 7);
-            g_assert_not_reached();
-        }
-
-        /* update status */
-        set_uint16(s->cmd_p, status);
-
-        s->cmd_p = get_uint32(s->cmd_p + 4); /* get link address */
-        DBG(printf("NEXT addr would be %08x\n", s->cmd_p));
-        if (s->cmd_p == 0) {
-            s->cmd_p = I596_NULL;
-        }
-
-        /* Stop when last command of the list. */
-        if (cmd & CMD_EOL) {
-            s->cmd_p = I596_NULL;
-        }
-        /* Suspend after doing cmd? */
-        if (cmd & CMD_SUSP) {
-            s->cu_status = CU_SUSPENDED;
-            printf("FIXME SUSPEND !!\n");
-        }
-        /* Interrupt after doing cmd? */
-        if (cmd & CMD_INTR) {
-            s->scb_status |= SCB_STATUS_CX;
-        } else {
-            s->scb_status &= ~SCB_STATUS_CX;
-        }
-        update_scb_status(s);
-
-        /* Interrupt after doing cmd? */
-        if (cmd & CMD_INTR) {
-            s->send_irq = 1;
-        }
-
-        if (s->cu_status != CU_ACTIVE) {
+            break;
+        default:
+            printf("CMD_LOOP: Unknown command %d\n", cmd & CMD_MASK);
             break;
         }
-    }
-    DBG(printf("FINISHED COMMAND LOOP\n"));
-    qemu_flush_queued_packets(qemu_get_queue(s->nic));
-}
-
-static void examine_scb(I82596State *s)
-{
-    uint16_t command, cuc, ruc;
-
-    /* get the scb command word */
-    command = get_uint16(s->scb + 2);
-    cuc = (command >> 8) & 0x7;
-    ruc = (command >> 4) & 0x7;
-    DBG(printf("MAIN COMMAND %04x  cuc %02x ruc %02x\n", command, cuc, ruc));
-    /* and clear the scb command word */
-    set_uint16(s->scb + 2, 0);
-
-    s->scb_status &= ~(command & SCB_ACK_MASK);
-
-    switch (cuc) {
-    case 0:     /* no change */
-        break;
-    case 1:     /* CUC_START */
-        s->cu_status = CU_ACTIVE;
-        break;
-    case 4:     /* CUC_ABORT */
-        s->cu_status = CU_SUSPENDED;
-        s->scb_status |= SCB_STATUS_CNA; /* CU left active state */
-        break;
-    default:
-        printf("WARNING: Unknown CUC %d!\n", cuc);
-    }
-
-    switch (ruc) {
-    case 0:     /* no change */
-        break;
-    case 1:     /* RX_START */
-    case 2:     /* RX_RESUME */
-        s->rx_status = RX_IDLE;
-        if (USE_TIMER) {
-            timer_mod(s->flush_queue_timer, qemu_clock_get_ms(
-                                QEMU_CLOCK_VIRTUAL) + 1000);
-        }
-        break;
-    case 3:     /* RX_SUSPEND */
-    case 4:     /* RX_ABORT */
-        s->rx_status = RX_SUSPENDED;
-        s->scb_status |= SCB_STATUS_RNR; /* RU left active state */
-        break;
-    default:
-        printf("WARNING: Unknown RUC %d!\n", ruc);
-    }
-
-    if (command & 0x80) { /* reset bit set? */
-        i82596_s_reset(s);
-    }
 
-    /* execute commands from SCBL */
-    if (s->cu_status != CU_SUSPENDED) {
-        if (s->cmd_p == I596_NULL) {
-            s->cmd_p = get_uint32(s->scb + 4);
+        status = get_uint16(s->cmd_p);
+        if (!(status & STAT_C)) {
+            set_uint16(s->cmd_p, STAT_C | STAT_OK);
         }
-    }
 
-    /* update scb status */
-    update_scb_status(s);
+skip_status_update:
+        if (cmd & CMD_INTR) {
+            s->scb_status |= SCB_STATUS_CX;
+            s->send_irq = 1;
+        }
 
-    command_loop(s);
-}
+        bool stop = false;
 
-static void signal_ca(I82596State *s)
-{
-    uint32_t iscp = 0;
+        if (cmd & CMD_SUSP) {
+            s->cu_status = CU_SUSPENDED;
+            s->scb_status |= SCB_STATUS_CNA;
+            stop = true;
+        }
 
-    /* trace_i82596_channel_attention(s); */
-    if (s->scp) {
-        /* CA after reset -> do init with new scp. */
-        s->sysbus = get_byte(s->scp + 3); /* big endian */
-        DBG(printf("SYSBUS = %08x\n", s->sysbus));
-        if (((s->sysbus >> 1) & 0x03) != 2) {
-            printf("WARNING: NO LINEAR MODE !!\n");
-        }
-        if ((s->sysbus >> 7)) {
-            printf("WARNING: 32BIT LINMODE IN B-STEPPING NOT SUPPORTED !!\n");
-        }
-        iscp = get_uint32(s->scp + 8);
-        s->scb = get_uint32(iscp + 4);
-        set_byte(iscp + 1, 0); /* clear BUSY flag in iscp */
-        s->scp = 0;
-    }
+        if (cmd & CMD_EOL) {
+            s->cmd_p = I596_NULL;
+            s->cu_status = CU_IDLE;
+            s->scb_status |= SCB_STATUS_CNA;
+            stop = true;
+        } else if (!stop) {
+            if (next_addr == 0 || next_addr == I596_NULL ||
+                next_addr == s->cmd_p) {
+                s->cmd_p = I596_NULL;
+                s->cu_status = CU_IDLE;
+                s->scb_status |= SCB_STATUS_CNA;
+                stop = true;
+            } else {
+                s->cmd_p = next_addr;
+            }
+        }
+
+        update_scb_status(s);
 
-    s->ca++;    /* count ca() */
-    if (!s->ca_active) {
-        s->ca_active = 1;
-        while (s->ca)   {
-            examine_scb(s);
-            s->ca--;
+        if (stop || s->cu_status != CU_ACTIVE) {
+            break;
         }
-        s->ca_active = 0;
     }
 
-    if (s->send_irq) {
-        s->send_irq = 0;
-        qemu_set_irq(s->irq, 1);
-    }
-}
+    update_scb_status(s);
 
-void i82596_ioport_writew(void *opaque, uint32_t addr, uint32_t val)
-{
-    I82596State *s = opaque;
-    /* printf("i82596_ioport_writew addr=0x%08x val=0x%04x\n", addr, val); */
-    switch (addr) {
-    case PORT_RESET: /* Reset */
-        i82596_s_reset(s);
-        break;
-    case PORT_ALTSCP:
-        s->scp = val;
-        break;
-    case PORT_CA:
-        signal_ca(s);
-        break;
+    if (s->rx_status == RX_READY && s->nic) {
+        qemu_flush_queued_packets(qemu_get_queue(s->nic));
     }
-}
 
-uint32_t i82596_ioport_readw(void *opaque, uint32_t addr)
-{
-    return -1;
 }
 
-bool i82596_can_receive(NetClientState *nc)
+static void examine_scb(I82596State *s)
 {
-    I82596State *s = qemu_get_nic_opaque(nc);
+    uint16_t command = get_uint16(s->scb + 2);
+    uint8_t cuc = (command >> 8) & 0x7;
+    uint8_t ruc = (command >> 4) & 0x7;
 
-    if (s->rx_status == RX_SUSPENDED) {
-        return false;
-    }
+    trace_i82596_scb_command(cuc, ruc);
 
-    if (!s->lnkst) {
-        return false;
-    }
+    set_uint16(s->scb + 2, 0);
+    s->scb_status &= ~(command & SCB_ACK_MASK);
 
-    if (USE_TIMER && !timer_pending(s->flush_queue_timer)) {
-        return true;
+    if (command & SCB_STATUS_RNR) {
+        s->rnr_signaled = false;
     }
 
-    return true;
-}
+    /* Process Command Unit (CU) commands */
+    switch (cuc) {
+    case SCB_CUC_NOP:
+        break;
 
-ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t sz)
-{
-    I82596State *s = qemu_get_nic_opaque(nc);
-    uint32_t rfd_p;
-    uint32_t rbd;
-    uint16_t is_broadcast = 0;
-    size_t len = sz; /* length of data for guest (including CRC) */
-    size_t bufsz = sz; /* length of data in buf */
-    uint32_t crc;
-    uint8_t *crc_ptr;
-    static const uint8_t broadcast_macaddr[6] = {
-                0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+    case SCB_CUC_START: {
+        uint32_t cmd_ptr = get_uint32(s->scb + 4);
+        s->cmd_p = i82596_translate_address(s, cmd_ptr, false);
+        s->cu_status = CU_ACTIVE;
+        break;
+    }
 
-    DBG(printf("i82596_receive() start\n"));
+    case SCB_CUC_RESUME:
+        if (s->cu_status == CU_SUSPENDED) {
+            s->cu_status = CU_ACTIVE;
+        }
+        break;
 
-    if (USE_TIMER && timer_pending(s->flush_queue_timer)) {
-        return 0;
-    }
+    case SCB_CUC_SUSPEND:
+        s->cu_status = CU_SUSPENDED;
+        s->scb_status |= SCB_STATUS_CNA;
+        break;
 
-    /* first check if receiver is enabled */
-    if (s->rx_status == RX_SUSPENDED) {
-        trace_i82596_receive_analysis(">>> Receiving suspended");
-        return -1;
-    }
+    case SCB_CUC_ABORT:
+        s->cu_status = CU_IDLE;
+        s->scb_status |= SCB_STATUS_CNA;
+        break;
 
-    if (!s->lnkst) {
-        trace_i82596_receive_analysis(">>> Link down");
-        return -1;
+    case SCB_CUC_LOAD_THROTTLE: {
+        bool external_trigger = (s->sysbus & I82586_MODE);
+        i82596_load_throttle_timers(s, !external_trigger);
+        break;
     }
 
-    /* Received frame smaller than configured "min frame len"? */
-    if (sz < s->config[10]) {
-        printf("Received frame too small, %zu vs. %u bytes\n",
-               sz, s->config[10]);
-        return -1;
+    case SCB_CUC_LOAD_START:
+        i82596_load_throttle_timers(s, true);
+        break;
     }
 
-    DBG(printf("Received %lu bytes\n", sz));
-
-    if (I596_PROMISC) {
-
-        /* promiscuous: receive all */
-        trace_i82596_receive_analysis(
-                ">>> packet received in promiscuous mode");
+    /* Process Receive Unit (RU) commands */
+    switch (ruc) {
+    case SCB_RUC_NOP:
+        break;
 
-    } else {
+    case SCB_RUC_START: {
+        uint32_t rfd_log = get_uint32(s->scb + 8);
+        hwaddr rfd = i82596_translate_address(s, rfd_log, false);
 
-        if (!memcmp(buf,  broadcast_macaddr, 6)) {
-            /* broadcast address */
-            if (I596_BC_DISABLE) {
-                trace_i82596_receive_analysis(">>> broadcast packet rejected");
+        if (rfd == 0 || rfd == I596_NULL) {
+            s->rx_status = RX_NO_RESOURCES;
+            s->scb_status |= SCB_STATUS_RNR;
+            break;
+        }
 
-                return len;
+        /* Find first usable RFD with valid RBD */
+        struct i82596_rx_descriptor test_rfd;
+        hwaddr test_rfd_addr = rfd;
+        uint32_t test_rfd_log = rfd_log;
+        hwaddr first_usable_rfd = 0;
+        uint32_t first_usable_rfd_log = 0;
+        bool found = false;
+
+        for (int i = 0; i < 10 && test_rfd_addr != 0 &&
+             test_rfd_addr != I596_NULL; i++) {
+            i82596_rx_rfd_read(s, test_rfd_addr, &test_rfd);
+
+            if (test_rfd.command & CMD_FLEX) {
+                hwaddr rbd = i82596_translate_address(s, test_rfd.rbd_addr,
+                                                      false);
+                if (rbd != I596_NULL && rbd != 0) {
+                    first_usable_rfd = test_rfd_addr;
+                    first_usable_rfd_log = test_rfd_log;
+                    found = true;
+                    break;
+                }
             }
 
-            trace_i82596_receive_analysis(">>> broadcast packet received");
-            is_broadcast = 1;
+            test_rfd_log = test_rfd.link;
+            test_rfd_addr = i82596_translate_address(s, test_rfd.link, false);
+        }
 
-        } else if (buf[0] & 0x01) {
-            /* multicast */
-            if (!I596_MC_ALL) {
-                trace_i82596_receive_analysis(">>> multicast packet rejected");
+        if (found) {
+            s->current_rx_desc = first_usable_rfd;
+            s->last_good_rfa = first_usable_rfd_log;
+            i82596_update_rx_state(s, RX_READY);
 
-                return len;
+            if (first_usable_rfd != rfd) {
+                set_uint32(s->scb + 8, first_usable_rfd_log);
             }
 
-            int mcast_idx = (net_crc32(buf, ETH_ALEN) & BITS(7, 2)) >> 2;
-            assert(mcast_idx < 8 * sizeof(s->mult));
-
-            if (!(s->mult[mcast_idx >> 3] & (1 << (mcast_idx & 7)))) {
-                trace_i82596_receive_analysis(">>> multicast address mismatch");
-
-                return len;
+            if (s->queue_count > 0) {
+                trace_i82596_flush_queue(s->queue_count);
+                i82596_flush_packet_queue(s);
             }
 
-            trace_i82596_receive_analysis(">>> multicast packet received");
-            is_broadcast = 1;
-
-        } else if (!memcmp(s->conf.macaddr.a, buf, 6)) {
-
-            /* match */
-            trace_i82596_receive_analysis(
-                    ">>> physical address matching packet received");
-
+            qemu_flush_queued_packets(qemu_get_queue(s->nic));
         } else {
-
-            trace_i82596_receive_analysis(">>> unknown packet");
-
-            return len;
+            s->rx_status = RX_NO_RESOURCES;
+            s->scb_status |= SCB_STATUS_RNR;
         }
+        break;
     }
 
-    /* Calculate the ethernet checksum (4 bytes) */
-    len += 4;
-    crc = cpu_to_be32(crc32(~0, buf, sz));
-    crc_ptr = (uint8_t *) &crc;
-
-    rfd_p = get_uint32(s->scb + 8); /* get Receive Frame Descriptor */
-    assert(rfd_p && rfd_p != I596_NULL);
-
-    /* get first Receive Buffer Descriptor Address */
-    rbd = get_uint32(rfd_p + 8);
-    assert(rbd && rbd != I596_NULL);
-
-    /* PRINT_PKTHDR("Receive", buf); */
-
-    while (len) {
-        uint16_t command, status;
-        uint32_t next_rfd;
-
-        command = get_uint16(rfd_p + 2);
-        assert(command & CMD_FLEX); /* assert Flex Mode */
-        /* get first Receive Buffer Descriptor Address */
-        rbd = get_uint32(rfd_p + 8);
-        assert(get_uint16(rfd_p + 14) == 0);
-
-        /* printf("Receive: rfd is %08x\n", rfd_p); */
-
-        while (len) {
-            uint16_t buffer_size, num;
-            uint32_t rba;
-            size_t bufcount, crccount;
-
-            /* printf("Receive: rbd is %08x\n", rbd); */
-            buffer_size = get_uint16(rbd + 12);
-            /* printf("buffer_size is 0x%x\n", buffer_size); */
-            assert(buffer_size != 0);
-
-            num = buffer_size & SIZE_MASK;
-            if (num > len) {
-                num = len;
-            }
-            rba = get_uint32(rbd + 8);
-            /* printf("rba is 0x%x\n", rba); */
-            /*
-             * Calculate how many bytes we want from buf[] and how many
-             * from the CRC.
-             */
-            if ((len - num) >= 4) {
-                /* The whole guest buffer, we haven't hit the CRC yet */
-                bufcount = num;
-            } else {
-                /* All that's left of buf[] */
-                bufcount = len - 4;
-            }
-            crccount = num - bufcount;
-
-            if (bufcount > 0) {
-                /* Still some of the actual data buffer to transfer */
-                assert(bufsz >= bufcount);
-                bufsz -= bufcount;
-                address_space_write(&address_space_memory, rba,
-                                    MEMTXATTRS_UNSPECIFIED, buf, bufcount);
-                rba += bufcount;
-                buf += bufcount;
-                len -= bufcount;
-            }
-
-            /* Write as much of the CRC as fits */
-            if (crccount > 0) {
-                address_space_write(&address_space_memory, rba,
-                                    MEMTXATTRS_UNSPECIFIED, crc_ptr, crccount);
-                rba += crccount;
-                crc_ptr += crccount;
-                len -= crccount;
+    case SCB_RUC_RESUME:
+        if (s->rx_status == RX_SUSPENDED) {
+            i82596_update_rx_state(s, RX_READY);
+            if (s->queue_count > 0) {
+                trace_i82596_flush_queue(s->queue_count);
+                i82596_flush_packet_queue(s);
             }
+            qemu_flush_queued_packets(qemu_get_queue(s->nic));
+        }
+        break;
 
-            num |= 0x4000; /* set F BIT */
-            if (len == 0) {
-                num |= I596_EOF; /* set EOF BIT */
-            }
-            set_uint16(rbd + 0, num); /* write actual count with flags */
+    case SCB_RUC_SUSPEND:
+        s->rx_status = RX_SUSPENDED;
+        s->scb_status |= SCB_STATUS_RNR;
+        break;
 
-            /* get next rbd */
-            rbd = get_uint32(rbd + 4);
-            /* printf("Next Receive: rbd is %08x\n", rbd); */
+    case SCB_RUC_ABORT:
+        s->rx_status = RX_IDLE;
+        s->scb_status |= SCB_STATUS_RNR;
+        break;
+    }
 
-            if (buffer_size & I596_EOF) /* last entry */
-                break;
+    if (command & 0x80) {
+        i82596_s_reset(s);
+        return;
+    }
+    if (s->cu_status == CU_ACTIVE) {
+        if (s->cmd_p == I596_NULL) {
+            s->cmd_p = get_uint32(s->scb + 4);
         }
+        update_scb_status(s);
+        command_loop(s);
+    } else {
+        update_scb_status(s);
+    }
+}
+
+static void signal_ca(I82596State *s)
+{
+    if (s->scp) {
+        /* CA after reset -> initialize with new SCP */
+        s->sysbus = get_byte(s->scp + 3);
+        s->mode = (s->sysbus >> 1) & 0x03;  /* Extract mode bits (m0, m1) */
+        s->iscp = get_uint32(s->scp + 8);
+
+        s->scb = get_uint32(s->iscp + 4);
+
+        s->scb_base = (s->mode == I82596_MODE_LINEAR) ? 0 :
+                      get_uint32(s->iscp + 8);
+        s->scb = i82596_translate_address(s, s->scb, false);
+        DBG(printf("CA: Initialization - SCB=0x%08x, mode=%d, base=0x%08x\n",
+                   s->scb, s->mode, s->scb_base));
+
+        /*
+         * Complete initialization sequence:
+         * - Clear BUSY flag in ISCP
+         * - Set CX and CNA in SCB status
+         * - Clear SCB command word
+         * - Signal interrupt
+         */
+        set_byte(s->iscp + 1, 0);
+        s->scb_status |= SCB_STATUS_CX | SCB_STATUS_CNA;
+        update_scb_status(s);
+        set_uint16(s->scb + 2, 0);
+        s->scp = 0;
+        qemu_set_irq(s->irq, 1);
+        return;
+    }
 
-        /* Housekeeping, see pg. 18 */
-        next_rfd = get_uint32(rfd_p + 4);
-        set_uint32(next_rfd + 8, rbd);
+    if (s->ca_active) {
+        s->ca++;
+        return;
+    }
+    s->ca_active = 1;
+    s->ca++;
 
-        status = STAT_C | STAT_OK | is_broadcast;
-        set_uint16(rfd_p, status);
+    while (s->ca > 0) {
+        s->ca--;
+        examine_scb(s);
+    }
 
-        if (command & CMD_SUSP) {  /* suspend after command? */
-            s->rx_status = RX_SUSPENDED;
-            s->scb_status |= SCB_STATUS_RNR; /* RU left active state */
-            break;
-        }
-        if (command & CMD_EOL) /* was it last Frame Descriptor? */
-            break;
+    s->ca_active = 0;
 
-        assert(len == 0);
+    if (s->send_irq) {
+        s->send_irq = 0;
+        qemu_set_irq(s->irq, 1);
     }
+}
 
-    assert(len == 0);
+static void i82596_self_test(I82596State *s, uint32_t val)
+{
+    /*
+     * The documentation for the self test is a bit unclear,
+     * we are currently doing this and it seems to work.
+     */
+    set_uint32(val, 0xFFC00000);
+    set_uint32(val + 4, 0);
 
-    s->scb_status |= SCB_STATUS_FR; /* set "RU finished receiving frame" bit. */
-    update_scb_status(s);
+    s->scb_status &= ~SCB_STATUS_CNA;
+    s->scb_status |= SCB_STATUS_CNA;
 
-    /* send IRQ that we received data */
     qemu_set_irq(s->irq, 1);
-    /* s->send_irq = 1; */
+    update_scb_status(s);
+}
 
-    if (0) {
-        DBG(printf("Checking:\n"));
-        rfd_p = get_uint32(s->scb + 8); /* get Receive Frame Descriptor */
-        DBG(printf("Next Receive: rfd is %08x\n", rfd_p));
-        rfd_p = get_uint32(rfd_p + 4); /* get Next Receive Frame Descriptor */
-        DBG(printf("Next Receive: rfd is %08x\n", rfd_p));
-        /* get first Receive Buffer Descriptor Address */
-        rbd = get_uint32(rfd_p + 8);
-        DBG(printf("Next Receive: rbd is %08x\n", rbd));
-    }
+/*
+ * LASI specific interfaces
+ */
+static uint32_t bit_align_16(uint32_t val)
+{
+    return val & ~0x0f;
+}
 
-    return sz;
+uint32_t i82596_ioport_readw(void *opaque, uint32_t addr)
+{
+    return -1;
 }
 
-ssize_t i82596_receive_iov(NetClientState *nc, const struct iovec *iov,
-                            int iovcnt)
+void i82596_ioport_writew(void *opaque, uint32_t addr, uint32_t val)
 {
-    size_t sz = 0;
-    uint8_t *buf;
-    int i;
-    for (i = 0; i < iovcnt; i++) {
-        sz += iov[i].iov_len;
-    }
-    if (sz == 0) {
-        return -1;
-    }
-    buf = g_malloc(sz);
-    if (!buf) {
-        return -1;
-    }
-    size_t offset = 0;
-    for (i = 0; i < iovcnt; i++) {
-        if (iov[i].iov_base == NULL) {
-            g_free(buf);
-            return -1;
-        }
-        memcpy(buf + offset, iov[i].iov_base, iov[i].iov_len);
-        offset += iov[i].iov_len;
+    I82596State *s = opaque;
+    DBG(printf("i82596_ioport_writew addr=0x%08x val=0x%04x\n", addr, val));
+    switch (addr) {
+    case PORT_RESET:
+        i82596_s_reset(s);
+        break;
+    case PORT_SELFTEST:
+        val = bit_align_16(val);
+        i82596_self_test(s, val);
+        break;
+    case PORT_ALTSCP:
+        s->scp = bit_align_16(val);
+        break;
+    case PORT_ALTDUMP:
+        trace_i82596_dump(val);
+        i82596_port_dump(s, bit_align_16(val));
+        break;
+    case PORT_CA:
+        signal_ca(s);
+        break;
     }
-    DBG(PRINT_PKTHDR("Receive IOV:", buf));
-    i82596_receive(nc, buf, sz);
-    g_free(buf);
-    return sz;
 }
 
 void i82596_poll(NetClientState *nc, bool enable)
@@ -1166,7 +2124,7 @@ void i82596_poll(NetClientState *nc, bool enable)
 
     if (s->rx_status == RX_NO_RESOURCES) {
         if (s->cmd_p != I596_NULL) {
-            s->rx_status = RX_READY;
+            i82596_update_rx_state(s, RX_READY);
             update_scb_status(s);
         }
     }
@@ -1232,6 +2190,57 @@ const VMStateDescription vmstate_i82596 = {
     }
 };
 
+static int i82596_flush_packet_queue(I82596State *s)
+{
+    if (s->flushing_queue) {
+        return 0;
+    }
+
+    s->flushing_queue = true;
+    int processed = 0;
+
+    while (s->queue_count > 0) {
+        int tail = s->queue_tail;
+        size_t len = s->packet_queue_len[tail];
+
+        ssize_t ret = i82596_receive_packet(s, s->packet_queue[tail], len,
+                                             true);
+
+        if (ret < 0) {
+            break;
+        }
+
+        s->queue_tail = (s->queue_tail + 1) % PACKET_QUEUE_SIZE;
+        s->queue_count--;
+        processed++;
+    }
+
+    s->flushing_queue = false;
+    trace_i82596_flush_queue(processed);
+
+    return processed;
+}
+
+static void i82596_flush_queue_timer(void *opaque)
+{
+    I82596State *s = opaque;
+
+    if (s->queue_count == 0) {
+        return;
+    }
+
+    int processed = i82596_flush_packet_queue(s);
+
+    if (processed > 0 && s->rx_status == RX_READY) {
+        qemu_flush_queued_packets(qemu_get_queue(s->nic));
+    }
+
+    if (s->queue_count > 0 && s->rx_status != RX_READY) {
+        timer_mod(s->flush_queue_timer,
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 50000);
+    }
+}
+
 void i82596_common_init(DeviceState *dev, I82596State *s, NetClientInfo *info)
 {
     if (s->conf.macaddr.a[0] == 0) {
diff --git a/hw/net/trace-events b/hw/net/trace-events
index e82d7490c3..495528e814 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -421,10 +421,14 @@ lasi_82596_mem_writew(uint64_t addr, uint32_t val) "addr=0x%"PRIx64" val=0x%04x"
 i82596_s_reset(void *s) "%p Reset chip"
 i82596_transmit(uint32_t size, uint32_t addr) "size %u from addr 0x%04x"
 i82596_receive_analysis(const char *s) "%s"
-i82596_receive_packet(size_t sz) "len=%zu"
+i82596_receive_queue_full(void) "Packet queue full, dropping packet"
+i82596_receive_suspended(void) "RX unit suspended, queueing packet"
+i82596_rx_state_change(uint8_t old_state, uint8_t new_state) "RX state changed from %d to %d"
 i82596_new_mac(const char *id_with_mac) "New MAC for: %s"
 i82596_set_multicast(uint16_t count) "Added %d multicast entries"
-i82596_channel_attention(void *s) "%p: Received CHANNEL ATTENTION"
+i82596_scb_command(uint8_t cuc, uint8_t ruc) "SCB command CUC=0x%02x RUC=0x%02x"
+i82596_dump(uint32_t addr) "Dump command to addr 0x%08x"
+i82596_flush_queue(int count) "Flushing %d packets from queue"
 
 # imx_fec.c
 imx_phy_read_num(int phy, int configured) "read request from unconfigured phy %d (configured %d)"
-- 
2.49.0


