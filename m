Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047A1C982FC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lsA-0006h1-S8; Mon, 21 Sep 2026 17:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8ls7-0006bW-M0
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:23 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8ls5-0000RF-KV
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:23 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6350f88so2166988f8f.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027300; x=1790632100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ePB1DF2TUK9i9t5dQ26XLD0b62VXCKx3HzGc+187TiQ=;
 b=dourfVzG4oUyoHutr6CR3AOJR4jK9s4GU+zFA5dnCy1m5sy2af6vv9rJL1QaijMqtx
 +0nmyz5RdCUZsVv2s2XNcXsNX4zKADoXgKJS7xnF2KvPq6omUBCj8nkfBNgt4X7pOGhG
 QItZ7Yp8PCWsFI7qEzYiCpB259MNE1pTJ4vxsyubLrbFOW0MdDLJR18wZatwY8qbnrQB
 P2Qzg0Tu0te3zniEpn1XcrzpWyE59gmDzqo+pPegZHE6QRQTSaVw95R5s8369Dv+xpE8
 1ac2oSCiGz8lNgmZFPufxWsKbIEKjW3mdDT2AjwR1TTSzlomWQLPrpQFvGnL4Hpr78Hd
 HMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027300; x=1790632100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ePB1DF2TUK9i9t5dQ26XLD0b62VXCKx3HzGc+187TiQ=;
 b=bRSm7oZqFDqGT2uJ9Vzfobg6oPHqDMOHqYf4GPnUq72TuuSW1bvGR+Q51KX9sK2Axl
 RzA8gaccxJV4dY6LbcHUO9qFCu1zcI6Gcv9N2CSB4KYfJGxz+pB2Ghh58MmMX9lDpuYN
 mMSLP61mCVvXf2Rpop99RmU/EXzn+MIumOcrZ5YH882BvaLLExfwRarYjuO53I79ri2D
 7Sw3IW02zbdT47egG+gVfa+PwJSojuPzLUtq3CgzlamQczKy1PLskCPsztcJ7Fh+Eu5e
 bwMn8JPl0rcHS5Z06nan9AEPvdhlvqfabVK1557GyP7FnPSGtf+IrQztNhUneZGtM6AA
 zsWg==
X-Gm-Message-State: AFuF++nm4ttGVp/xm/LqPUWgVHkAWN9EImIg0OBkMDKTm3HimkFeeyqx
 6rRGi0hXN2tO0arjdGa6lR/eDDH2iSt3OaxwskRUVmqdzs+w0NhNgH03TCKy6A==
X-Gm-Gg: AYBFou3NtXWSzvfJNxht7hm8KCIVy2Rc1bi1MMK/SZIODQ3hkM7mq1qg2l5lAVBjnMy
 mysGMtJW9x3QQwMU+kbwJEeupJ5fPUCpAkRu2Bfo1uocaLcuXcwNevTWZYzkNZJOatpzM8kYWPo
 BQtA+W3YO1yu2H2e1TZKE6VEYm0MhOLlH+/O2K3YaM4QXC5bY1hJmrhIO8EbKWGj2R+PSdBj0CO
 vJLV5NubPf+TnZ3qQd76lWwwwjOkLKsYfXfFO5jF6HoFNNyrQSrNuzEvqEYws7ua5CEmJMbVjCI
 Jv+GNrf+vS4oo0T1w3gCkowqqrjzJ+LPtmD6evhTHh7uDcdqeaGCdkxhSCNf4qfw7Wf9oKRaaVh
 j2iZYkhEuv9xyQHr2ljQ/4m9E7LLVf6/TLzeYuLk5+fS3r27ElQI759XilCZtsN2LsgNoftX1G4
 YnYwt5B0uYUdCUhL8gkLMrc/7dB0TKwZ0jqmZX/yYmA2kXPFL9q4GQlbapngWtUwlwrw3tvADgv
 98G3YzgLHSLTmmgCIkJcl9DnYpJ9LxKG5P7pNPojDRgziedD0prtDtaXFVXXIZIQGevabigMagg
 X1Y=
X-Received: by 2002:a05:600c:354e:b0:49b:8f18:714a with SMTP id
 5b1f17b1804b1-49fc57226c9mr162987355e9.12.1790027300098; 
 Mon, 21 Sep 2026 14:48:20 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:48:19 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 40/42] hw/net/imx_fec: Trace with QOM path where easily
 possible
Date: Mon, 21 Sep 2026 23:47:08 +0200
Message-ID: <20260921214710.29422-41-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Some i.MX SoCs have multiple i.MX network IP blocks. Allow to
distinguish them via their QOM path when tracing.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/net/imx_fec.c    | 28 +++++++++++++++-------------
 hw/net/trace-events | 24 ++++++++++++------------
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index c177b7ff2b..fb8bcd52d2 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -248,7 +248,7 @@ static uint32_t imx_phy_read(IMXFECState *s, int reg)
         if (s->phy_consumer && phy == s->phy_consumer->phy_num) {
             s = s->phy_consumer;
         } else {
-            trace_imx_phy_read_num(phy, s->phy_num);
+            trace_imx_phy_read_num(DEVICE(s)->canonical_path, phy, s->phy_num);
             return 0xffff;
         }
     }
@@ -270,7 +270,7 @@ static void imx_phy_write(IMXFECState *s, int reg, uint32_t val)
         if (s->phy_consumer && phy == s->phy_consumer->phy_num) {
             s = s->phy_consumer;
         } else {
-            trace_imx_phy_write_num(phy, s->phy_num);
+            trace_imx_phy_write_num(DEVICE(s)->canonical_path, phy, s->phy_num);
             return;
         }
     }
@@ -364,7 +364,7 @@ static void imx_fec_do_tx(IMXFECState *s)
         if ((bd.flags & ENET_BD_R) == 0) {
 
             /* Run out of descriptors to transmit.  */
-            trace_imx_eth_tx_bd_busy();
+            trace_imx_eth_tx_bd_busy(DEVICE(s)->canonical_path);
 
             break;
         }
@@ -446,7 +446,7 @@ static void imx_enet_do_tx(IMXFECState *s, uint32_t index)
         if ((bd.flags & ENET_BD_R) == 0) {
             /* Run out of descriptors to transmit.  */
 
-            trace_imx_eth_tx_bd_busy();
+            trace_imx_eth_tx_bd_busy(DEVICE(s)->canonical_path);
 
             break;
         }
@@ -521,7 +521,7 @@ static void imx_eth_enable_rx(IMXFECState *s, bool flush)
     s->regs[ENET_RDAR] = (bd.flags & ENET_BD_E) ? ENET_RDAR_RDAR : 0;
 
     if (!s->regs[ENET_RDAR]) {
-        trace_imx_eth_rx_bd_full();
+        trace_imx_eth_rx_bd_full(DEVICE(s)->canonical_path);
     } else if (flush) {
         qemu_flush_queued_packets(qemu_get_queue(s->nic));
     }
@@ -659,7 +659,8 @@ static uint64_t imx_eth_read(void *opaque, hwaddr offset, unsigned size)
         break;
     }
 
-    trace_imx_eth_read(index, imx_eth_reg_name(s, index), value);
+    trace_imx_eth_read(DEVICE(s)->canonical_path, index,
+                       imx_eth_reg_name(s, index), value);
 
     return value;
 }
@@ -767,7 +768,8 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
     const bool single_tx_ring = !imx_eth_is_multi_tx_ring(s);
     uint32_t index = offset >> 2;
 
-    trace_imx_eth_write(index, imx_eth_reg_name(s, index), value);
+    trace_imx_eth_write(DEVICE(s)->canonical_path, index,
+                        imx_eth_reg_name(s, index), value);
 
     switch (index) {
     case ENET_EIR:
@@ -951,7 +953,7 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
     unsigned int buf_len;
     size_t size = len;
 
-    trace_imx_fec_receive(size);
+    trace_imx_fec_receive(DEVICE(s)->canonical_path, size);
 
     if (!s->regs[ENET_RDAR]) {
         qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Unexpected packet\n",
@@ -993,7 +995,7 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
         bd.length = buf_len;
         size -= buf_len;
 
-        trace_imx_fec_receive_len(addr, bd.length);
+        trace_imx_fec_receive_len(DEVICE(s)->canonical_path, addr, bd.length);
 
         /* The last 4 bytes are the CRC.  */
         if (size < 4) {
@@ -1013,7 +1015,7 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
             /* Last buffer in frame.  */
             bd.flags |= flags | ENET_BD_L;
 
-            trace_imx_fec_receive_last(bd.flags);
+            trace_imx_fec_receive_last(DEVICE(s)->canonical_path, bd.flags);
 
             s->regs[ENET_EIR] |= ENET_INT_RXF;
         } else {
@@ -1047,7 +1049,7 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
     size_t size = len;
     bool shift16 = s->regs[ENET_RACC] & ENET_RACC_SHIFT16;
 
-    trace_imx_enet_receive(size);
+    trace_imx_enet_receive(DEVICE(s)->canonical_path, size);
 
     if (!s->regs[ENET_RDAR]) {
         qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Unexpected packet\n",
@@ -1093,7 +1095,7 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
         bd.length = buf_len;
         size -= buf_len;
 
-        trace_imx_enet_receive_len(addr, bd.length);
+        trace_imx_enet_receive_len(DEVICE(s)->canonical_path, addr, bd.length);
 
         /* The last 4 bytes are the CRC.  */
         if (size < 4) {
@@ -1131,7 +1133,7 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
             /* Last buffer in frame.  */
             bd.flags |= flags | ENET_BD_L;
 
-            trace_imx_enet_receive_last(bd.flags);
+            trace_imx_enet_receive_last(DEVICE(s)->canonical_path, bd.flags);
 
             /* Indicate that we've updated the last buffer descriptor. */
             bd.last_buffer = ENET_BD_BDU;
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 001a20b0e2..81af808044 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -444,20 +444,20 @@ i82596_ca_init(uint32_t scb, uint8_t mode, uint32_t base) "CA: Init - SCB=0x%08x
 i82596_ioport_write(uint32_t addr, uint32_t val) "IO write addr=0x%08x val=0x%08x"
 
 # imx_fec.c
-imx_phy_read_num(int phy, int configured) "read request from unconfigured phy %d (configured %d)"
-imx_phy_write_num(int phy, int configured) "write request to unconfigured phy %d (configured %d)"
+imx_phy_read_num(const char *path, int phy, int configured) "%s: read request from unconfigured phy %d (configured %d)"
+imx_phy_write_num(const char *path, int phy, int configured) "%s: write request to unconfigured phy %d (configured %d)"
 imx_fec_read_bd(uint64_t addr, int flags, int len, int data) "tx_bd 0x%"PRIx64" flags 0x%04x len %d data 0x%08x"
 imx_enet_read_bd(uint64_t addr, int flags, int len, int data, int options, int status) "tx_bd 0x%"PRIx64" flags 0x%04x len %d data 0x%08x option 0x%04x status 0x%04x"
-imx_eth_tx_bd_busy(void) "tx_bd ran out of descriptors to transmit"
-imx_eth_rx_bd_full(void) "RX buffer is full"
-imx_eth_read(int reg, const char *reg_name, uint32_t value) "reg[%d:%s] => 0x%08"PRIx32
-imx_eth_write(int reg, const char *reg_name, uint64_t value) "reg[%d:%s] <= 0x%08"PRIx64
-imx_fec_receive(size_t size) "len %zu"
-imx_fec_receive_len(uint64_t addr, int len) "rx_bd 0x%"PRIx64" length %d"
-imx_fec_receive_last(int last) "rx frame flags 0x%04x"
-imx_enet_receive(size_t size) "len %zu"
-imx_enet_receive_len(uint64_t addr, int len) "rx_bd 0x%"PRIx64" length %d"
-imx_enet_receive_last(int last) "rx frame flags 0x%04x"
+imx_eth_tx_bd_busy(const char *path) "%s: tx_bd ran out of descriptors to transmit"
+imx_eth_rx_bd_full(const char *path) "%s: RX buffer is full"
+imx_eth_read(const char *path, int reg, const char *reg_name, uint32_t value) "%s: reg[%d:%s] => 0x%08"PRIx32
+imx_eth_write(const char *path, int reg, const char *reg_name, uint64_t value) "%s: reg[%d:%s] <= 0x%08"PRIx64
+imx_fec_receive(const char *path, size_t size) "%s: len %zu"
+imx_fec_receive_len(const char *path, uint64_t addr, int len) "%s: rx_bd 0x%"PRIx64" length %d"
+imx_fec_receive_last(const char *path, int last) "%s: rx frame flags 0x%04x"
+imx_enet_receive(const char *path, size_t size) "%s: len %zu"
+imx_enet_receive_len(const char *path, uint64_t addr, int len) "%s, rx_bd 0x%"PRIx64" length %d"
+imx_enet_receive_last(const char *path, int last) "%s: rx frame flags 0x%04x"
 
 # npcm7xx_emc.c
 npcm7xx_emc_reset(int emc_num) "Resetting emc%d"
-- 
2.55.0


