Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413EDCD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 14:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs1Ys-0007Xt-KZ; Wed, 03 Apr 2024 10:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1rs0wR-0006vJ-B0
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 09:46:17 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1rs0wJ-0002aK-Gr
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 09:46:14 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-430a65e973bso37888911cf.3
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 06:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1712151965; x=1712756765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=20QQlL3+PET96PGctDqYoYFELi+/62H5wLKk70CL090=;
 b=YVNxn/cKuPBSqxiMLwJ6WuN1U8giLgMMpawimuxLZFA8WZfxe+3fll1pMG+PoATHYd
 5lr94VTBEWWgzI0CEC+d4+v4F/wT5TWUVMzm0pUOjo6XlaUhOkMXFKoi0ePo4J7NCwcH
 tUuc8nEViRzenS6soamtqVUfcYSG0rKx7pA2GQtdEyfbVJ0rnEYoxJRzreBQv2jbjy5S
 vaI70p6V859MQ4ifN7eIhOd7b5YYAzqyLhJKmta/d+iQMoFr9OSObHslfSN9Z0Ky/Q1+
 BfRLRG+O3MvzJ7s5fhThyrdLHVe5Imj2UT7ElFn22ERDUVwMOdT1kGhn9O4A2w1Vm4Cs
 6HkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712151965; x=1712756765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=20QQlL3+PET96PGctDqYoYFELi+/62H5wLKk70CL090=;
 b=DO/CWR7vm0Nh0qeysGcVmjR4mLY3bbHuEg8WSNYnyQbTv1hAnAmLaua3f2IJ1wCNSU
 wSdjypAUornGfUbQyfrpdizdEYB+C9lliFJWeM/pzgGFEXq9GvkChlXdrnPqPF6rsD3W
 CVmiMoed0IjiJEVQkGMldQN9a/iB+12mxk6ZFm4Eu1bAfLoXm/7ccGTAvHzAoFh37LFm
 uVZLncnNYRQ7YVJoFdWdM6GjpCYJ4lc93Jr4H+1fRpp2sMJVT3dNjK3JUnBhMBuaEp8i
 J0eJYRFLCln6iVA34sOAI81+ceZFn5kFmnVubmNQdDedXy1gW54vuJiox2WMCMxeURgU
 vApQ==
X-Gm-Message-State: AOJu0YxkKUr++4PEMecigP8tRwvaAGuyYtK6cl/2v9kiK3OJEZXzZmxz
 2X8zRyrXycZPLebLKvvF/Icuwb21V1EGk5yyrhtZL+5G/QFLTBXvU472I9iXhGhtItBjQV0viq0
 /G/in/9nbtS4aa6kxXGhyiwzVzjE/18lkTpYIIoVm5fQ+qlpUvmus4iQZ907ckaePWuiTqhCSyx
 2CF/NVF7mtstRNv1uxrwDSaVDO9opX
X-Google-Smtp-Source: AGHT+IHT2eROvi+IHTkBt2g87ozs1bcK6K/b9cwsctdQtsu4OMdzzHG2keLVdWIw7yT2GZldlM/IuQ==
X-Received: by 2002:a05:622a:209:b0:431:2fa6:f22e with SMTP id
 b9-20020a05622a020900b004312fa6f22emr18344768qtx.3.1712151964919; 
 Wed, 03 Apr 2024 06:46:04 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 fc20-20020a05622a489400b00430c76f0c86sm6587168qtb.80.2024.04.03.06.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 06:46:04 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: jasonwang@redhat.com, richard.henderson@linaro.org,
 Austin Clements <aclements@csail.mit.edu>,
 Geoffrey Thomas <geofft@ldpreload.com>, Don Porter <porter@cs.unc.edu>
Subject: [PATCH v2] e1000: Convert debug macros into tracepoints.
Date: Wed,  3 Apr 2024 09:45:45 -0400
Message-Id: <20240403134546.1361812-1-porter@cs.unc.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7e66f00d-cc69-458d-be56-266689757f68@linaro.org>
References: <7e66f00d-cc69-458d-be56-266689757f68@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=porter@cs.unc.edu; helo=mail-qt1-x834.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 03 Apr 2024 10:25:56 -0400
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

From: Austin Clements <aclements@csail.mit.edu>

The E1000 debug messages are very useful for developing drivers.
Make these available to users without recompiling QEMU.

Signed-off-by: Austin Clements <aclements@csail.mit.edu>
[geofft@ldpreload.com: Rebased on top of 2.9.0]
Signed-off-by: Geoffrey Thomas <geofft@ldpreload.com>
Signed-off-by: Don Porter <porter@cs.unc.edu>
---
 hw/net/e1000.c      | 90 +++++++++++++++------------------------------
 hw/net/trace-events | 25 ++++++++++++-
 2 files changed, 54 insertions(+), 61 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 43f3a4a701..24475636a3 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -44,26 +44,6 @@
 #include "trace.h"
 #include "qom/object.h"
 
-/* #define E1000_DEBUG */
-
-#ifdef E1000_DEBUG
-enum {
-    DEBUG_GENERAL,      DEBUG_IO,       DEBUG_MMIO,     DEBUG_INTERRUPT,
-    DEBUG_RX,           DEBUG_TX,       DEBUG_MDIC,     DEBUG_EEPROM,
-    DEBUG_UNKNOWN,      DEBUG_TXSUM,    DEBUG_TXERR,    DEBUG_RXERR,
-    DEBUG_RXFILTER,     DEBUG_PHY,      DEBUG_NOTYET,
-};
-#define DBGBIT(x)    (1<<DEBUG_##x)
-static int debugflags = DBGBIT(TXERR) | DBGBIT(GENERAL);
-
-#define DBGOUT(what, fmt, ...) do { \
-    if (debugflags & DBGBIT(what)) \
-        fprintf(stderr, "e1000: " fmt, ## __VA_ARGS__); \
-    } while (0)
-#else
-#define DBGOUT(what, fmt, ...) do {} while (0)
-#endif
-
 #define IOPORT_SIZE       0x40
 #define PNPMMIO_SIZE      0x20000
 
@@ -351,8 +331,7 @@ e1000_mit_timer(void *opaque)
 static void
 set_ics(E1000State *s, int index, uint32_t val)
 {
-    DBGOUT(INTERRUPT, "set_ics %x, ICR %x, IMR %x\n", val, s->mac_reg[ICR],
-        s->mac_reg[IMS]);
+    trace_e1000_set_ics(val, s->mac_reg[ICR], s->mac_reg[IMS]);
     set_interrupt_cause(s, 0, val | s->mac_reg[ICR]);
 }
 
@@ -425,8 +404,7 @@ set_rx_control(E1000State *s, int index, uint32_t val)
     s->mac_reg[RCTL] = val;
     s->rxbuf_size = e1000x_rxbufsize(val);
     s->rxbuf_min_shift = ((val / E1000_RCTL_RDMTS_QUAT) & 3) + 1;
-    DBGOUT(RX, "RCTL: %d, mac_reg[RCTL] = 0x%x\n", s->mac_reg[RDT],
-           s->mac_reg[RCTL]);
+    trace_e1000_set_rx_control(s->mac_reg[RDT], s->mac_reg[RCTL]);
     timer_mod(s->flush_queue_timer,
               qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
 }
@@ -440,16 +418,16 @@ set_mdic(E1000State *s, int index, uint32_t val)
     if ((val & E1000_MDIC_PHY_MASK) >> E1000_MDIC_PHY_SHIFT != 1) // phy #
         val = s->mac_reg[MDIC] | E1000_MDIC_ERROR;
     else if (val & E1000_MDIC_OP_READ) {
-        DBGOUT(MDIC, "MDIC read reg 0x%x\n", addr);
+        trace_e1000_mdic_read_register(addr);
         if (!(phy_regcap[addr] & PHY_R)) {
-            DBGOUT(MDIC, "MDIC read reg %x unhandled\n", addr);
+            trace_e1000_mdic_read_register_unhandled(addr);
             val |= E1000_MDIC_ERROR;
         } else
             val = (val ^ data) | s->phy_reg[addr];
     } else if (val & E1000_MDIC_OP_WRITE) {
-        DBGOUT(MDIC, "MDIC write reg 0x%x, value 0x%x\n", addr, data);
+        trace_e1000_mdic_write_register(addr, data);
         if (!(phy_regcap[addr] & PHY_W)) {
-            DBGOUT(MDIC, "MDIC write reg %x unhandled\n", addr);
+            trace_e1000_mdic_write_register_unhandled(addr);
             val |= E1000_MDIC_ERROR;
         } else {
             if (addr < NPHYWRITEOPS && phyreg_writeops[addr]) {
@@ -471,8 +449,8 @@ get_eecd(E1000State *s, int index)
 {
     uint32_t ret = E1000_EECD_PRES|E1000_EECD_GNT | s->eecd_state.old_eecd;
 
-    DBGOUT(EEPROM, "reading eeprom bit %d (reading %d)\n",
-           s->eecd_state.bitnum_out, s->eecd_state.reading);
+    trace_e1000_get_eecd(s->eecd_state.bitnum_out, s->eecd_state.reading);
+
     if (!s->eecd_state.reading ||
         ((s->eeprom_data[(s->eecd_state.bitnum_out >> 4) & 0x3f] >>
           ((s->eecd_state.bitnum_out & 0xf) ^ 0xf))) & 1)
@@ -511,9 +489,8 @@ set_eecd(E1000State *s, int index, uint32_t val)
         s->eecd_state.reading = (((s->eecd_state.val_in >> 6) & 7) ==
             EEPROM_READ_OPCODE_MICROWIRE);
     }
-    DBGOUT(EEPROM, "eeprom bitnum in %d out %d, reading %d\n",
-           s->eecd_state.bitnum_in, s->eecd_state.bitnum_out,
-           s->eecd_state.reading);
+    trace_e1000_set_eecd(s->eecd_state.bitnum_in, s->eecd_state.bitnum_out,
+                         s->eecd_state.reading);
 }
 
 static uint32_t
@@ -580,8 +557,7 @@ xmit_seg(E1000State *s)
 
     if (tp->cptse) {
         css = props->ipcss;
-        DBGOUT(TXSUM, "frames %d size %d ipcss %d\n",
-               frames, tp->size, css);
+        trace_e1000_xmit_seg1(frames, tp->size, css);
         if (props->ip) {    /* IPv4 */
             stw_be_p(tp->data+css+2, tp->size - css);
             stw_be_p(tp->data+css+4,
@@ -591,7 +567,7 @@ xmit_seg(E1000State *s)
         }
         css = props->tucss;
         len = tp->size - css;
-        DBGOUT(TXSUM, "tcp %d tucss %d len %d\n", props->tcp, css, len);
+        trace_e1000_xmit_seg2(props->tcp, css, len);
         if (props->tcp) {
             sofar = frames * props->mss;
             stl_be_p(tp->data+css+4, ldl_be_p(tp->data+css+4)+sofar); /* seq */
@@ -759,7 +735,7 @@ start_xmit(E1000State *s)
     uint32_t tdh_start = s->mac_reg[TDH], cause = E1000_ICS_TXQE;
 
     if (!(s->mac_reg[TCTL] & E1000_TCTL_EN)) {
-        DBGOUT(TX, "tx disabled\n");
+        trace_e1000_start_xmit_fail1();
         return;
     }
 
@@ -773,9 +749,9 @@ start_xmit(E1000State *s)
                sizeof(struct e1000_tx_desc) * s->mac_reg[TDH];
         pci_dma_read(d, base, &desc, sizeof(desc));
 
-        DBGOUT(TX, "index %d: %p : %x %x\n", s->mac_reg[TDH],
-               (void *)(intptr_t)desc.buffer_addr, desc.lower.data,
-               desc.upper.data);
+        trace_e1000_transmit(s->mac_reg[TDH],
+                             (void *)(intptr_t)desc.buffer_addr,
+                             desc.lower.data, desc.upper.data);
 
         process_tx_desc(s, &desc);
         cause |= txdesc_writeback(s, base, &desc);
@@ -789,8 +765,8 @@ start_xmit(E1000State *s)
          */
         if (s->mac_reg[TDH] == tdh_start ||
             tdh_start >= s->mac_reg[TDLEN] / sizeof(desc)) {
-            DBGOUT(TXERR, "TDH wraparound @%x, TDT %x, TDLEN %x\n",
-                   tdh_start, s->mac_reg[TDT], s->mac_reg[TDLEN]);
+            trace_e1000_start_xmit_fail2(tdh_start, s->mac_reg[TDT],
+                                         s->mac_reg[TDLEN]);
             break;
         }
     }
@@ -978,7 +954,7 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
                 desc.status &= ~E1000_RXD_STAT_EOP;
             }
         } else { // as per intel docs; skip descriptors with null buf addr
-            DBGOUT(RX, "Null RX descriptor!!\n");
+            trace_e1000_null_rx();
         }
         pci_dma_write(d, base, &desc, sizeof(desc));
         desc.status |= (vlan_status | E1000_RXD_STAT_DD);
@@ -990,8 +966,8 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
         /* see comment in start_xmit; same here */
         if (s->mac_reg[RDH] == rdh_start ||
             rdh_start >= s->mac_reg[RDLEN] / sizeof(desc)) {
-            DBGOUT(RXERR, "RDH wraparound @%x, RDT %x, RDLEN %x\n",
-                   rdh_start, s->mac_reg[RDT], s->mac_reg[RDLEN]);
+            trace_e1000_rdh_wraparound(rdh_start, s->mac_reg[RDT],
+                                       s->mac_reg[RDLEN]);
             e1000_receiver_overrun(s, total_size);
             return -1;
         }
@@ -1033,7 +1009,7 @@ mac_icr_read(E1000State *s, int index)
 {
     uint32_t ret = s->mac_reg[ICR];
 
-    DBGOUT(INTERRUPT, "ICR read: %x\n", ret);
+    trace_e1000_mac_icr_read(ret);
     set_interrupt_cause(s, 0, 0);
     return ret;
 }
@@ -1109,7 +1085,7 @@ set_tctl(E1000State *s, int index, uint32_t val)
 static void
 set_icr(E1000State *s, int index, uint32_t val)
 {
-    DBGOUT(INTERRUPT, "set_icr %x\n", val);
+    trace_e1000_set_icr(val);
     set_interrupt_cause(s, 0, s->mac_reg[ICR] & ~val);
 }
 
@@ -1271,20 +1247,16 @@ e1000_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         if (!(mac_reg_access[index] & MAC_ACCESS_FLAG_NEEDED)
             || (s->compat_flags & (mac_reg_access[index] >> 2))) {
             if (mac_reg_access[index] & MAC_ACCESS_PARTIAL) {
-                DBGOUT(GENERAL, "Writing to register at offset: 0x%08x. "
-                       "It is not fully implemented.\n", index<<2);
+                trace_e1000_mmio_write_fail1(index << 2);
             }
             macreg_writeops[index](s, index, val);
         } else {    /* "flag needed" bit is set, but the flag is not active */
-            DBGOUT(MMIO, "MMIO write attempt to disabled reg. addr=0x%08x\n",
-                   index<<2);
+            trace_e1000_mmio_write_fail2(index << 2);
         }
     } else if (index < NREADOPS && macreg_readops[index]) {
-        DBGOUT(MMIO, "e1000_mmio_writel RO %x: 0x%04"PRIx64"\n",
-               index<<2, val);
+        trace_e1000_mmio_write_fail3(index << 2, val);
     } else {
-        DBGOUT(UNKNOWN, "MMIO unknown write addr=0x%08x,val=0x%08"PRIx64"\n",
-               index<<2, val);
+        trace_e1000_mmio_write_fail4(index << 2, val);
     }
 }
 
@@ -1298,16 +1270,14 @@ e1000_mmio_read(void *opaque, hwaddr addr, unsigned size)
         if (!(mac_reg_access[index] & MAC_ACCESS_FLAG_NEEDED)
             || (s->compat_flags & (mac_reg_access[index] >> 2))) {
             if (mac_reg_access[index] & MAC_ACCESS_PARTIAL) {
-                DBGOUT(GENERAL, "Reading register at offset: 0x%08x. "
-                       "It is not fully implemented.\n", index<<2);
+                trace_e1000_mmio_read_fail1(index << 2);
             }
             return macreg_readops[index](s, index);
         } else {    /* "flag needed" bit is set, but the flag is not active */
-            DBGOUT(MMIO, "MMIO read attempt of disabled reg. addr=0x%08x\n",
-                   index<<2);
+            trace_e1000_mmio_read_fail2(index << 2);
         }
     } else {
-        DBGOUT(UNKNOWN, "MMIO unknown read addr=0x%08x\n", index<<2);
+        trace_e1000_mmio_read_fail3(index << 2);
     }
     return 0;
 }
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 78efa2ec2c..f426f79a0c 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -101,7 +101,31 @@ net_rx_pkt_rss_hash(size_t rss_length, uint32_t rss_hash) "RSS hash for %zu byte
 net_rx_pkt_rss_add_chunk(void* ptr, size_t size, size_t input_offset) "Add RSS chunk %p, %zu bytes, RSS input offset %zu bytes"
 
 # e1000.c
+e1000_set_ics(uint32_t val, uint32_t ICR, uint32_t IMR) "set_ics 0x%x, ICR 0x%x, IMR 0x%x"
+e1000_set_rx_control(uint32_t RDT, uint32_t RCTL) "RCTL: %d, mac_reg[RCTL] = 0x%x"
+e1000_mdic_read_register(uint32_t addr) "MDIC read reg 0x%x"
+e1000_mdic_read_register_unhandled(uint32_t addr) "MDIC read reg 0x%x unhandled"
+e1000_mdic_write_register(uint32_t addr, uint32_t val) "MDIC write reg 0x%x, value 0x%x"
+e1000_mdic_write_register_unhandled(uint32_t addr) "MDIC write reg 0x%x unhandled"
+e1000_transmit(uint32_t tdh, void *addr, uint32_t data_low, uint32_t data_high) "index %d: %p : 0x%x 0x%x"
+e1000_get_eecd(uint16_t bitnum_out, uint16_t reading) "reading eeprom bit %d (reading %d)"
+e1000_set_eecd(uint16_t bitnum_in, uint16_t bitnum_out, uint16_t reading) "eeprom bitnum in %d out %d, reading %d"
+e1000_xmit_seg1(unsigned int frames, uint16_t size, unsigned int css) "frames %d size %d ipcss %d"
+e1000_xmit_seg2(int8_t tcp, uint16_t css, unsigned int len) "tcp %d tucss %d len %d"
+e1000_start_xmit_fail1(void) "tx disabled"
+e1000_start_xmit_fail2(uint32_t tdh_start, uint32_t TDT, uint32_t TDLEN) "TDH wraparound @0x%x, TDT 0x%x, TDLEN 0x%x"
 e1000_receiver_overrun(size_t s, uint32_t rdh, uint32_t rdt) "Receiver overrun: dropped packet of %zu bytes, RDH=%u, RDT=%u"
+e1000_null_rx(void) "Null RX descriptor!!"
+e1000_rdh_wraparound(uint32_t rdh_start, uint32_t RDT, uint32_t RDLEN) "RDH wraparound @0x%x, RDT 0x%x, RDLEN 0x%x"
+e1000_mac_icr_read(uint32_t ret) "ICR read: 0x%x"
+e1000_set_icr(uint32_t val) "set_icr 0x%x"
+e1000_mmio_write_fail1(unsigned int index) "Writing to register at offset: 0x%08x. It is not fully implemented."
+e1000_mmio_write_fail2(unsigned int index) "MMIO write attempt to disabled reg. addr=0x%08x"
+e1000_mmio_write_fail3(unsigned int index, uint64_t val) "e1000_mmio_writel RO 0x%x: 0x%04"PRIx64""
+e1000_mmio_write_fail4(unsigned int index, uint64_t val) "MMIO unknown write addr=0x%08x,val=0x%08"PRIx64""
+e1000_mmio_read_fail1(unsigned int index) "Reading register at offset: 0x%08x. It is not fully implemented."
+e1000_mmio_read_fail2(unsigned int index) "MMIO read attempt of disabled reg. addr=0x%08x"
+e1000_mmio_read_fail3(unsigned int index) "MMIO unknown read addr=0x%08x"
 
 # e1000x_common.c
 e1000x_rx_can_recv_disabled(bool link_up, bool rx_enabled, bool pci_master) "link_up: %d, rx_enabled %d, pci_master %d"
@@ -146,7 +170,6 @@ e1000e_wrn_no_snap_support(void) "WARNING: Guest requested TX SNAP header update
 e1000e_wrn_iscsi_filtering_not_supported(void) "WARNING: Guest requested iSCSI filtering  which is not supported"
 e1000e_wrn_nfsw_filtering_not_supported(void) "WARNING: Guest requested NFS write filtering  which is not supported"
 e1000e_wrn_nfsr_filtering_not_supported(void) "WARNING: Guest requested NFS read filtering  which is not supported"
-
 e1000e_tx_disabled(void) "TX Disabled"
 e1000e_tx_descr(void *addr, uint32_t lower, uint32_t upper) "%p : %x %x"
 
-- 
2.25.1


