Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9481F606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BF27tY4H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUBcn-0001li-90; Thu, 19 Nov 2026 18:33:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xUBce-0001kH-K6
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:32:58 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xUBcZ-0008Mt-NK
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:32:55 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A7AA620B6;
 Thu, 19 Nov 2026 23:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497631F000C6;
 Thu, 19 Nov 2026 23:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795131170;
 bh=cgc0eRYLlJZeKGXB/aCbcraImam7J3WRjp0YaBbvvJQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BF27tY4HEYQF3JwL2IwborhyEqTYAdUxMhXi0D3FVRODONAMD2n3C3Q6cBmGbt1Kj
 X5pT4CQrmjuOB5FP4E5BVTrYZPz3ZwzIMSoxbSm2CEVNh8HwpID8M/HunVxTFWXThG
 gZM4YK/zMff3EZPWeZoG6eK1GYF5hMCdMW0DgrHLpn8W2+fiSNpqR0Pcp6QmWj7DYC
 yqO3fApNh/Mlo38ttN8ikVPa0tJbsZbaGgsRyZMopsjWi7q+rKjUYrf9eFlcT0wjlY
 XX/Rbw8GTMP+BaRTcQvVCOHh8JGH9G7EtECcp1pW+vi4aJDYwmwpeIJ0z43zwRoVE0
 VG+UESPnKuAWA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Fam Zheng <fam@euphon.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Keith Monahan <keith@techtravels.org>
Subject: [PATCH v3 6/6] hw/scsi/ncr53c710: Comment cleanup, reduce verbosity,
 repetition
Date: Fri, 20 Nov 2026 00:32:35 +0100
Message-ID: <20261119233235.32808-7-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261119233235.32808-1-deller@kernel.org>
References: <20261119233235.32808-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Monahan <keith@techtravels.org>

Various comment cleanups.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/lasi_ncr710.c |  20 ++-
 hw/scsi/ncr53c710.c   | 306 +++++++++++-------------------------------
 hw/scsi/ncr53c710.h   |  38 ++----
 3 files changed, 101 insertions(+), 263 deletions(-)

diff --git a/hw/scsi/lasi_ncr710.c b/hw/scsi/lasi_ncr710.c
index 5e0294e7a7..c6d8632942 100644
--- a/hw/scsi/lasi_ncr710.c
+++ b/hw/scsi/lasi_ncr710.c
@@ -5,8 +5,8 @@
  * Developed during Google Summer of Code 2025, mentored by
  * Helge Deller <deller@gmx.de>.
  *
- * LASI module glue around the 53C710 core in ncr53c710.c: it embeds one
- * NCR710State by value and maps it onto the HP 715 (-M 715) LASI bus.
+ * LASI module glue mapping the 53C710 core in ncr53c710.c onto the HP 715
+ * (-M 715) LASI bus.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
@@ -45,12 +45,7 @@ static uint64_t lasi_ncr710_reg_read(void *opaque, hwaddr addr,
         return val;
     }
 
-    /*
-     * 0x100..0x1ff goes to the chip core as before.  The rest of the
-     * module page reads as 0: HP-UX reads a board strap at 0xd85
-     * (bit 0x20: differential bus, 25 MHz clock); 0 is single ended,
-     * 50 MHz.
-     */
+    /* 0x100..0x1ff goes to the chip core. */
     if (addr >= 0x100 && addr + size <= 0x200) {
         hwaddr ncr_addr = addr - 0x100;
         if (size == 1) {
@@ -74,6 +69,11 @@ static uint64_t lasi_ncr710_reg_read(void *opaque, hwaddr addr,
 
         trace_lasi_ncr710_reg_forward_read(addr, val);
     } else {
+        /*
+         * The rest of the module page reads as 0.  HP-UX reads a board strap
+         * at 0xd85 (bit 0x20: differential bus, 25 MHz clock); 0 is single
+         * ended, 50 MHz.
+         */
         val = 0;
         trace_lasi_ncr710_reg_read(addr, val, size);
     }
@@ -90,9 +90,7 @@ static void lasi_ncr710_reg_write(void *opaque, hwaddr addr,
     /*
      * 0x00..0x0f is the read only LASI module header (ID/SVERSION/HVERSION);
      * 0x10..0xff and 0x200..0xfff are unmapped module space.  Writes to all
-     * of them are ignored.  The SCSI bus reset is driven through the chip's
-     * SCNTL1.RST at forwarded offset 0x101 (see ncr53c710.c), not through
-     * this window.
+     * of them are ignored.
      */
     if (addr <= 0x0f) {
         return;
diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 231e9ffc18..3ff7f4e120 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -4,23 +4,14 @@
  * Copyright (c) 2026 Keith Monahan <keith@techtravels.org>
  * Copyright (c) 2006 CodeSourcery (lsi53c895a.c, written by Paul Brook)
  *
- * A rewrite of the QEMU NCR 53C710 model.  The 53C710 is an early member of
- * the NCR/LSI SCRIPTS processor family, so the SCRIPTS engine here is derived
- * from QEMU's LSI53C895A model and adapted to the 53C710's register map,
- * single byte interrupt model, big endian SCRIPTS fetch (PA-RISC) and 24 bit
- * DMA, per the NCR 53C710 Data Manual (Jun 1992) and Programmer's Guide
- * (Oct 1990).
- *
- * Derived from hw/scsi/lsi53c895a.c (Copyright (c) 2006 CodeSourcery, written
- * by Paul Brook).
+ * The SCRIPTS engine is derived from QEMU's LSI53C895A model and adapted to
+ * the 53C710's register map, single byte interrupt model, big endian SCRIPTS
+ * fetch and 24 bit DMA, per the NCR 53C710 Data Manual and Programmer's Guide.
  *
  * Replaces the 53C710 model written for Google Summer of Code 2025 by
  * Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>, itself based on
  * earlier NCR 53C710 work by Helge Deller and by Toni Wilen (for UAE).
  *
- * The only instantiated device is the LASI wrapper (lasi_ncr710.c), which
- * embeds one NCR710State by value and drives it through this file.
- *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
@@ -35,7 +26,6 @@
 
 /* SCNTL0 (0x00) */
 #define LSI_SCNTL0_EPG       0x04
-/* ARB1|ARB0 = 0xc0 (full arbitration) at reset */
 
 /* SCNTL1 (0x01) */
 #define LSI_SCNTL1_ESR       0x20
@@ -64,10 +54,8 @@
 #define LSI_BUF_SIZE     4096
 
 /*
- * Safety bound on the synchronous completion drain loop in ncr710_reg_write().
- * A real transfer needs only a handful of iterations; this cap prevents an
- * unbounded spin if a drain ever fails to progress (it then falls back to
- * asynchronous completion).
+ * Safety bound on the synchronous completion drain loop in ncr710_reg_write();
+ * it then falls back to asynchronous completion.
  */
 #define LSI_DRAIN_MAX_ITERS  100000
 
@@ -88,7 +76,6 @@ static const char *lsi_reg_name(int offset)
     return (offset >= 0 && offset < 64) ? lsi_reg_names[offset] : "???";
 }
 
-/* Forward declarations. */
 static uint8_t lsi_reg_readb(NCR710State *s, int offset);
 static void lsi_reg_writeb(NCR710State *s, int offset, uint8_t val);
 static void lsi_execute_script(NCR710State *s);
@@ -96,9 +83,8 @@ static void lsi_issue_bh(void *opaque);
 static void lsi_set_phase(NCR710State *s, int phase);
 
 /*
- * On the 53C700 family (including the 53C710), the Select/Reselect destination
- * ID and the SDID register are a one hot BITMASK (one bit per SCSI ID), unlike
- * the 53C8xx which use a binary encoded target number.  Convert to a number.
+ * On the 53C700 family the Select/Reselect destination ID and SDID are a one
+ * hot bitmask, unlike the 53C8xx's binary target number.
  */
 static int lsi_id_from_bits(unsigned bits)
 {
@@ -122,17 +108,8 @@ void ncr710_soft_reset(NCR710State *s)
     trace_ncr710_reset();
 
     /*
-     * A guest ISTAT.RST soft reset can land with commands still in flight: the
-     * connected request in s->current and disconnected tagged requests on
-     * s->queue.  Cancel them so their SCSIRequests are released and no stale
-     * pointer survives the reset.  Otherwise s->current dangles into the next
-     * lsi_do_command (tripping its assert(s->current == NULL)) and the
-     * queued requests leak.  scsi_req_cancel drives each through
-     * ncr710_request_cancelled -> lsi_request_orphan, which clears
-     * s->current and empties s->queue, mirroring the SCNTL1.RST bus-reset
-     * teardown via bus_cold_reset.  At device init or machine reset both are
-     * already empty, so this is a no-op (the queue is QTAILQ_INIT'd before the
-     * first reset).
+     * A guest ISTAT.RST soft reset can land with commands still in flight.
+     * Cancel them so no stale pointer survives the reset.
      */
     if (s->current && s->current->req) {
         scsi_req_cancel(s->current->req);
@@ -153,11 +130,9 @@ void ncr710_soft_reset(NCR710State *s)
     s->script_running = false;
     s->sigp_pending_resume = false;
     /*
-     * Do not reset reentrancy_level here.  A SCRIPTS driven soft reset (a guest
-     * write of ISTAT.RST from a register move) can run while execute_script
-     * frames are still on the stack; those frames decrement the counter as they
-     * unwind, so zeroing it would underflow negative and defeat the reentrancy
-     * guard.  It is zero at device init and balances itself to zero.
+     * Do not reset reentrancy_level here.  A SCRIPTS driven soft reset can run
+     * while lsi_execute_script frames are still on the stack; those frames
+     * decrement the counter as they unwind.
      */
 
     s->scntl0 = 0xc0;       /* full arbitration */
@@ -215,10 +190,7 @@ static inline void lsi_mem_write(NCR710State *s, uint32_t addr,
     address_space_write(s->as, addr, MEMTXATTRS_UNSPECIFIED, buf, len);
 }
 
-/*
- * SCRIPTS and the table indirect data structures are built by the big endian
- * PA-RISC CPU and fetched as longwords, so they are interpreted big endian.
- */
+/* SCRIPTS and table indirect structures are built by the big endian CPU. */
 static inline uint32_t lsi_read_dword(NCR710State *s, uint32_t addr)
 {
     uint32_t buf;
@@ -308,14 +280,9 @@ static void lsi_resume_script(NCR710State *s)
     if (s->reentrancy_level > 0) {
         /*
          * A completion fired synchronously while the SCRIPTS interpreter is
-         * already on the stack, e.g. inline GOOD status for a no data
-         * command (TEST UNIT READY, START STOP UNIT, ...) completing inside
-         * scsi_req_enqueue().  Reentering lsi_execute_script() here would
-         * advance s->dsp underneath the outer interpreter frame and can
-         * double execute SCRIPTS (the reentrancy class behind CVE-2023-0330
-         * in lsi53c895a).  Do not recurse: release the wait so the outer
+         * already on the stack.  Do not recurse: release the wait so the outer
          * loop continues to the next instruction, which the completion has
-         * already armed (PHASE_ST, via ncr710_command_complete()).
+         * already armed.
          */
         s->waiting = LSI_NOWAIT;
         return;
@@ -344,10 +311,9 @@ static void lsi_bad_selection(NCR710State *s, uint32_t id)
 }
 
 /*
- * Deferred half of lsi_do_dma()'s SCSI continue: runs on a clean stack so a
- * cached backend's completion arrives asynchronously (reentrancy_level 0)
- * instead of reentrantly inside the SCRIPTS interpreter.  Guarded against an
- * orphaned/cancelled request like lsi_reselect_bh.
+ * Deferred half of lsi_do_dma()'s SCSI continue.  It runs on a clean stack,
+ * so a cached backend's completion cannot arrive reentrantly inside the
+ * SCRIPTS interpreter.
  */
 static void lsi_issue_bh(void *opaque)
 {
@@ -406,26 +372,17 @@ static void lsi_do_dma(NCR710State *s, int out)
     if (p->dma_len == 0) {
         p->dma_buf = NULL;
         /*
-         * Defer the completing continue (Block Move satisfied, dbc == 0) of a
-         * tagged disconnect/reselect transfer to a bottom half: its
-         * scsi_req_continue can trigger a cached backend (CD-ROM) completion
-         * reentrantly inside execute_script, collapsing the disconnect and
-         * completion INT into the guest MMIO write driving the engine.  That
-         * lets the HP-UX c720 driver's next-command SIGP kick race ahead of its
-         * completion ISR and wedge the install.  Deferring makes completion an
-         * autonomous async event, like the disk-backed path;
-         * the engine parks at DMA_IN_PROGRESS (set by the caller) meanwhile.
+         * Defer the completing continue (dbc == 0) of a tagged transfer to a
+         * bottom half; the engine parks at DMA_IN_PROGRESS (set by the caller)
+         * meanwhile.
          */
         if ((p->tag & LSI_TAG_VALID) && s->dbc == 0) {
             s->issue_pending = true;
             aio_bh_schedule_oneshot(qemu_get_aio_context(), lsi_issue_bh, s);
         } else {
             /*
-             * Complete inline for untagged transfers (the connected, polled
-             * early-boot and PDC path: SeaBIOS, ISL, pre-driver probe) and
-             * mid-transfer continues (dbc > 0) that fetch more data without
-             * completing the command (deferring every chunk would stall large
-             * multi-chunk reads).
+             * Complete inline for untagged transfers and mid-transfer
+             * continues (dbc > 0).
              */
             scsi_req_continue(req);
         }
@@ -445,12 +402,9 @@ static void lsi_add_msg_byte(NCR710State *s, uint8_t data)
 }
 
 /*
- * Reselection-interrupt mode on the 53C700 family is enabled by the SCSI
- * interrupt enable for (re)selection (SIEN.SEL).  Linux's 53c700 driver sets it
- * and expects a (re)selection interrupt when a disconnected command reselects;
- * HP-UX leaves it clear and instead parks the SCRIPTS engine on a Wait Reselect
- * instruction (handled in lsi_wait_reselect()).  Unlike the 53C8xx, the 710
- * gates reselection response on SIEN.SEL alone, with no separate SCID.RRE bit.
+ * Reselection-interrupt mode on the 53C700 family is enabled by SIEN.SEL alone,
+ * with no separate SCID.RRE bit.  With it clear, the driver instead parks the
+ * SCRIPTS engine on a Wait Reselect instruction.
  */
 static inline int lsi_irq_on_rsl(NCR710State *s)
 {
@@ -484,7 +438,7 @@ static void lsi_queue_command(NCR710State *s)
     p->out = (s->sstat2 & PHASE_MASK) == PHASE_DO;
 }
 
-/* Reselect a disconnected command to resume (continue) its data transfer. */
+/* Reselect a disconnected command to resume its data transfer. */
 static void lsi_reselect(NCR710State *s, lsi_request *p)
 {
     int id;
@@ -536,9 +490,8 @@ static int lsi_queue_req(NCR710State *s, SCSIRequest *req, uint32_t len)
 
 /*
  * Deferred half of lsi_wait_reselect(): reconnect a disconnected command
- * whose data is ready and resume the engine, on a clean (bottom half) stack.
- * Guarded so it does nothing if a guest SIGP wake or an inline transfer_data
- * reselection moved the engine on while this was pending.
+ * whose data is ready and resume the engine.  Does nothing if the engine moved
+ * on while this was pending.
  */
 static void lsi_reselect_bh(void *opaque)
 {
@@ -564,17 +517,10 @@ static void lsi_wait_reselect(NCR710State *s)
         return;
     }
     /*
-     * A disconnected command whose data is ready must reconnect to resume its
-     * transfer.  Reselecting synchronously here, inside the guest register
-     * write that drove the engine to this Wait Reselect, would deliver the
-     * command's completion interrupt reentrantly in the middle of driver flow,
-     * racing the HP-UX 10.20 c720 driver's completion bookkeeping and dropping
-     * a biodone/wakeup (the install then sleeps forever; the model idles
-     * with the queue empty).  Defer the reconnect to a bottom half so it
-     * lands on a clean stack after the register write returns, as a real target
-     * initiated reselection would arrive.  The engine parks meanwhile; if more
-     * data arrives first, transfer_data's own reselection (or a SIGP wake)
-     * handles it and the bottom half does nothing.
+     * Reselecting synchronously here, inside the guest register write that
+     * drove the engine to this Wait Reselect, would deliver the command's
+     * completion interrupt reentrantly.  Defer the reconnect to a bottom half;
+     * the engine parks meanwhile.
      */
     s->waiting = LSI_WAIT_RESELECT;
     if (lsi_get_pending_req(s)) {
@@ -636,10 +582,8 @@ void ncr710_transfer_data(SCSIRequest *req, uint32_t len)
     assert(!p->orphan);
 
     /*
-     * A disconnected (queued) command, or one whose data arrives while the
-     * engine is parked at Wait Reselect, must reselect before its data can be
-     * moved.  lsi_queue_req() reselects if it can, else defers the transfer
-     * until the engine next parks at Wait Reselect.
+     * A disconnected command, or one whose data arrives while the engine is
+     * parked at Wait Reselect, must reselect before its data can be moved.
      */
     if (s->waiting == LSI_WAIT_RESELECT || p != s->current ||
         (lsi_irq_on_rsl(s) && !(s->scntl1 & LSI_SCNTL1_CON))) {
@@ -707,22 +651,11 @@ static void lsi_do_command(NCR710State *s)
             if ((s->current->tag & LSI_TAG_VALID) &&
                 !lsi_irq_on_rsl(s)) {
                 /*
-                 * Tagged command whose data is not yet ready (typically a read
-                 * whose media access has not completed), issued by a driver
-                 * that recovers a disconnected command by parking the SCRIPTS
-                 * engine on a Wait Reselect instruction (SIEN.SEL clear, e.g.
-                 * HP-UX). Disconnect and queue it so the bus is free for
-                 * further tagged commands; lsi_wait_reselect() reselects it
-                 * once its data is ready.
-                 *
-                 * Do not disconnect for:
-                 *   - untagged transfers (SeaBIOS/PDC firmware, simple
-                 *     drivers), which have no Wait Reselect handler; and
-                 *   - reselection-interrupt drivers (SIEN.SEL set, e.g. Linux's
-                 *     53c700), which expect a target-reselect interrupt with
-                 *     the 700-family reselection handshake rather than a script
-                 *     park.
-                 * Both keep the connected behaviour and complete inline.
+                 * Tagged command whose data is not yet ready, issued by a
+                 * driver that parks the SCRIPTS engine on a Wait Reselect
+                 * instruction (SIEN.SEL clear).  Disconnect and queue it so the
+                 * bus is free for further tagged commands.  Untagged transfers
+                 * and reselection-interrupt drivers stay connected.
                  */
                 lsi_add_msg_byte(s, 2);   /* SAVE DATA POINTER */
                 lsi_add_msg_byte(s, 4);   /* DISCONNECT */
@@ -730,18 +663,10 @@ static void lsi_do_command(NCR710State *s)
                 s->msg_action = LSI_MSG_ACTION_DISCONNECT;
                 lsi_queue_command(s);
             }
-            /*
-             * Otherwise stay connected and let the block move wait for
-             * transfer_data; no disconnect is fabricated (see policy above).
-             */
         } else {
             /*
-             * Async no data command (e.g. SYNCHRONIZE CACHE from Linux
-             * 53c700, completing via a block layer bottom half).  Park with
-             * dbc = 0 so the engine stops in COMMAND instead of fabricating
-             * a data phase; ncr710_command_complete() later asserts STATUS
-             * and resumes on a quiescent stack.  dbc = 0 also keeps that
-             * completion on its clean PHASE_ST path.
+             * Async no data command.  Park with dbc = 0 so the engine stops in
+             * COMMAND without a data phase.
              */
             s->dbc = 0;
             s->waiting = LSI_DMA_IN_PROGRESS;
@@ -777,10 +702,7 @@ static void lsi_do_msgin(NCR710State *s)
         /*
          * MOVE WHEN MSG IN with no message queued: transfer nothing (SFBR
          * keeps its last byte).  After a declined negotiation MESSAGE REJECT
-         * (msg_action COMMAND) the Linux 53c700 driver loops on MSG IN and
-         * needs the target driven switch to COMMAND, so advance the phase
-         * here or it spins.  (HP-UX issues its CDB directly and never
-         * reenters here.)
+         * (msg_action COMMAND) the target switches to COMMAND.
          */
         if (s->msg_action == LSI_MSG_ACTION_COMMAND) {
             lsi_set_phase(s, PHASE_CMD);
@@ -807,22 +729,11 @@ static void lsi_do_msgin(NCR710State *s)
     if (!s->msg_len) {
         switch (s->msg_action) {
         case LSI_MSG_ACTION_COMMAND:
-            /*
-             * A MESSAGE REJECT declining negotiation was just consumed.
-             * The HP-UX install template reads it with ATN deasserted and
-             * requires a trailing SAVE DATA POINTERS (0x02); a conformant
-             * initiator (NetBSD, Linux) reads it with ATN still asserted and
-             * wants no second byte.  See lsi_do_msgout for the
-             * discriminator.
-             */
+            /* A MESSAGE REJECT declining negotiation was just consumed. */
             if (s->sfbr == 7 && !(s->socl & LSI_SOCL_ATN)) {
                 lsi_add_msg_byte(s, 2);   /* SAVE DATA POINTERS (HP-UX) */
             }
-            /*
-             * Stay in MSG IN: SSTAT2 latches the last REQ phase, so the driver
-             * samples MSG IN at the script interrupt and the lazy MSG IN ->
-             * COMMAND switch happens when its next block move requests COMMAND.
-             */
+            /* Stay in MSG IN until the next block move requests COMMAND. */
             break;
         case LSI_MSG_ACTION_DISCONNECT:
             lsi_disconnect(s);
@@ -918,15 +829,10 @@ static void lsi_do_msgout(NCR710State *s)
     return;
 reject:
     /*
-     * Decline SDTR/WDTR/PPR negotiation with a single MESSAGE REJECT.  NetBSD
-     * osiop and Linux 53c700 accept a lone reject and move on; the HP-UX 10.20
-     * install template instead requires a trailing SAVE DATA POINTERS (0x02) or
-     * it spins in MSG IN until the I/O times out, while NetBSD osiop rejects a
-     * 0x02 there and resets the bus.  The two are told apart by ATN as the
-     * reject is read (HP-UX has deasserted it, conformant initiators have not),
-     * so queue only the reject here and append the 0x02 tail in lsi_do_msgin
-     * when ATN is deasserted.  Phase stays latched at MSG IN until the CDB
-     * block move requests COMMAND.
+     * Decline SDTR/WDTR/PPR negotiation with a single MESSAGE REJECT.  HP-UX
+     * requires a trailing SAVE DATA POINTERS (0x02), which other initiators
+     * reject.  HP-UX reads the reject with ATN deasserted, so lsi_do_msgin
+     * appends the 0x02 only then.
      */
     lsi_set_phase(s, PHASE_MI);
     lsi_add_msg_byte(s, 7);           /* MESSAGE REJECT */
@@ -985,9 +891,8 @@ static void lsi_execute_script(NCR710State *s)
     s->script_running = true;
 again:
     /*
-     * Yield to the CPU after LSI_MAX_INSN instructions (so guests that spin
-     * waiting on a memory change make progress), and guard against a script
-     * that retriggers itself (CVE-2023-0330) via the reentrancy counter.
+     * Yield to the CPU after LSI_MAX_INSN instructions, and guard against a
+     * script that retriggers itself (CVE-2023-0330).
      */
     if (++insn_processed > LSI_MAX_INSN || s->reentrancy_level > 8) {
         trace_ncr710_script_yield(insn_processed);
@@ -1030,13 +935,9 @@ again:
         }
         if ((s->sstat2 & PHASE_MASK) != ((insn >> 24) & 7)) {
             /*
-             * The target controls the phase; SSTAT2 latches the last REQ
-             * phase.  The one legitimate lazy transition is MSG IN -> COMMAND
-             * after a declined negotiation MESSAGE REJECT (msg_action
-             * COMMAND); applying it here rather than in do_msgin keeps the
-             * phase the driver samples at the script interrupt in sync.  Any
-             * other requested phase is a real mismatch and interrupts with
-             * M/A.
+             * The target controls the phase.  The one legitimate lazy
+             * transition is MSG IN -> COMMAND after a declined negotiation
+             * MESSAGE REJECT.  Any other requested phase is a mismatch.
              */
             if ((s->sstat2 & PHASE_MASK) == PHASE_MI && s->msg_len == 0 &&
                 s->msg_action == LSI_MSG_ACTION_COMMAND &&
@@ -1119,11 +1020,7 @@ again:
                 s->scntl1 |= LSI_SCNTL1_CON;
                 s->sbcl |= LSI_SBCL_BSY;
                 if (insn & (1 << 24)) {
-                    /*
-                     * Select with ATN/: the initiator drives a message
-                     * first, so the target's first phase is MESSAGE OUT
-                     * (IDENTIFY).
-                     */
+                    /* Select with ATN/: the first phase is MESSAGE OUT. */
                     s->socl |= LSI_SOCL_ATN;
                     s->sbcl |= LSI_SBCL_ATN;
                     lsi_set_phase(s, PHASE_MO);
@@ -1139,20 +1036,17 @@ again:
                 break;
             case 2: /* Wait Reselect */
                 /*
-                 * Two things release a Wait Reselect: the driver's SIGP "start
-                 * next command" kick (jump to the dispatch address latched in
-                 * DNAD), or a disconnected tagged command becoming ready to
-                 * reselect.  A SIGP that arrived while the engine was halted at
-                 * a completion INT is held in sigp_pending_resume and consumed
-                 * here.  Otherwise reconnect a ready queued command, or park.
+                 * Two things release a Wait Reselect: SIGP (jump to the
+                 * dispatch address latched in DNAD), or a disconnected command
+                 * becoming ready to reselect.  A SIGP that arrived while the
+                 * engine was halted is held in sigp_pending_resume.
                  */
                 if ((s->istat & LSI_ISTAT0_SIGP) || s->sigp_pending_resume) {
                     /*
-                     * The SIGP divert is a one-shot: clear the latch as it is
-                     * consumed so a subsequent Wait Reselect does not re-fire
-                     * on a stale SIGP, and so SIGP is never left set across a
-                     * real reselection (Jun92 p.53: an active SIGP at
-                     * reselection disables target-mode auto-switching).
+                     * The SIGP divert is a one-shot: clear the latch so a
+                     * later Wait Reselect does not re-fire on a stale SIGP.
+                     * An active SIGP at reselection also disables target-mode
+                     * auto-switching.
                      */
                     s->istat &= ~LSI_ISTAT0_SIGP;
                     s->sigp_pending_resume = false;
@@ -1183,9 +1077,7 @@ again:
                     s->sbcl &= ~LSI_SBCL_ACK;
                     /*
                      * Releasing ACK on the last byte of a declined negotiation
-                     * MESSAGE REJECT lets the target move on to COMMAND.  HP-UX
-                     * 9 tests the phase with JUMP WHEN COMMAND after CLEAR ACK
-                     * instead of issuing the CDB block move directly.
+                     * MESSAGE REJECT lets the target move on to COMMAND.
                      */
                     if ((s->sstat2 & PHASE_MASK) == PHASE_MI && s->msg_len == 0 &&
                         s->msg_action == LSI_MSG_ACTION_COMMAND) {
@@ -1200,8 +1092,7 @@ again:
         } else {
             /*
              * Read/Write register.  The 895a ALU operator encoding is a
-             * backward compatible superset of the 710's (move/OR/AND/ADD plus
-             * carry enable map onto operators 0/2/4/6/7), so this decode is
+             * backward compatible superset of the 710's, so this decode is
              * shared with lsi53c895a.
              */
             uint8_t op0 = 0;
@@ -1626,19 +1517,10 @@ static void lsi_reg_writeb(NCR710State *s, int offset, uint8_t val)
         }
         if (s->waiting == LSI_WAIT_RESELECT && (val & LSI_ISTAT0_SIGP)) {
             /*
-             * SIGP "start next command" wake of a parked Wait Reselect.  Run
-             * the engine synchronously: the Wait Reselect opcode, on SIGP,
-             * jumps to the DNAD dispatch and SELECTs the next command (Jun92
-             * p.69 step 3).  This SELECT must take priority over any
-             * disconnected command pending reselection: on real silicon the
-             * SIGP jump wins and the pending target reselects later, when the
-             * engine is next parked.  Deferring this to a bottom half let
-             * lsi_reselect_bh win the race and reconnect a pending command
-             * instead of selecting the new one, stranding the driver's
-             * start-next kick (it polls, sees no progress, and resets the bus).
-             * qemu_set_irq only raises the IRQ line here; the guest takes it at
-             * the next instruction boundary, after this store returns, so this
-             * is not a reentrant interrupt delivery.
+             * SIGP wake of a parked Wait Reselect.  Run the engine
+             * synchronously: this SELECT must take priority over any
+             * disconnected command pending reselection.  The guest takes any
+             * IRQ raised here after this store returns.
              */
             trace_ncr710_awoken();
             s->waiting = LSI_NOWAIT;
@@ -1647,25 +1529,11 @@ static void lsi_reg_writeb(NCR710State *s, int offset, uint8_t val)
         } else if ((val & LSI_ISTAT0_SIGP) && !s->script_running &&
                    s->waiting == LSI_NOWAIT) {
             /*
-             * The driver's "start next command" SIGP kick raced ahead of the
-             * prior command's completion ISR: the engine is halted (script
-             * stopped, not parked at Wait Reselect) on a just completed
-             * command, either at its completion INT or in the brief window
-             * after the ISR has read cleared DSTAT but before it restarts the
-             * engine.  The wake above is skipped, so the kick only latches
-             * SIGP.  On real silicon the completion ISR runs before this lower
-             * priority kick, so the kick always lands on a parked Wait
-             * Reselect; under TCG it can land in the completion window.  The
-             * driver then polls the engine, sees no progress (SIGP still
-             * latched, DCMD/bus unchanged) and resets the SCSI bus, destroying
-             * the in flight command and hanging the install.
-             *
-             * Present "kick consumed" to that poll without disturbing any
-             * pending completion: clear the SIGP latch, exactly as a real Wait
-             * Reselect consumption would.  DSTAT/DSPS/DIP and the asserted IRQ
-             * are untouched, so the real completion ISR still services the
-             * command. Remember the kick so the next command is selected once
-             * the engine parks again at Wait Reselect (execute_script, case 2).
+             * SIGP while the engine is halted on a just completed command,
+             * not parked at Wait Reselect.  Clear the SIGP latch, as a Wait
+             * Reselect consumption would, without disturbing the pending
+             * completion.  Remember the kick so the next command is selected
+             * once the engine parks again at Wait Reselect.
              */
             s->istat &= ~LSI_ISTAT0_SIGP;
             s->sigp_pending_resume = true;
@@ -1748,18 +1616,8 @@ void ncr710_reg_write(NCR710State *s, hwaddr addr, uint64_t val, unsigned size)
     /*
      * Drive any asynchronous SCSI transfer the register write kicked off to
      * completion before returning to the guest, so its completion interrupt is
-     * raised first.  The HP-UX 10.20 c720 driver issues its "start next
-     * command" SIGP kick with CPU interrupts masked and then spins; a still
-     * pending asynchronous completion (its bottom half has not run) would land
-     * in that masked window unserviced, and the driver's watchdog would reset
-     * the bus.  Real hardware takes the higher priority completion interrupt
-     * before that poll.
-     *
-     * A deferred continue (lsi_issue_bh, for a tagged reselect transfer) has
-     * not issued its backing I/O yet, so pump it inline first; otherwise
-     * blk_drain the backend.  The loop is bounded by LSI_DRAIN_MAX_ITERS and
-     * falls back to asynchronous completion (trace_ncr710_drain_exhausted) if it
-     * cannot make progress.
+     * raised first.  A deferred continue (lsi_issue_bh) has not issued its
+     * backing I/O yet, so pump it inline; otherwise blk_drain the backend.
      */
     while (s->waiting == LSI_DMA_IN_PROGRESS && s->current != NULL &&
            s->current->req != NULL) {
@@ -1814,10 +1672,8 @@ static int lsi_post_load(void *opaque, int version_id)
 const VMStateDescription vmstate_ncr710 = {
     .name = "ncr710",
     /*
-     * Version 2: the field layout was incompatibly reworked from the model this
-     * rewrite replaces (which also declared version 1).  minimum_version_id is
-     * raised in lockstep so a legacy stream is rejected rather than parsed
-     * positionally into the new layout.
+     * Version 2: minimum_version_id rejects version 1 streams from the
+     * earlier 53C710 model, whose field layout is incompatible.
      */
     .version_id = 3,
     .minimum_version_id = 2,
@@ -1835,10 +1691,8 @@ const VMStateDescription vmstate_ncr710 = {
         VMSTATE_INT32(command_complete, NCR710State),
         VMSTATE_BOOL(script_running, NCR710State),
         /*
-         * A deferred "start next command" SIGP kick (version 3+).  Unlike
-         * reentrancy_level it can be live across a migration point (set while
-         * the engine is halted at a completion INT awaiting its ISR), so it is
-         * migrated; absent from a v2 stream it defaults to false.
+         * Version 3+.  A deferred SIGP kick can be live across a migration
+         * point.
          */
         VMSTATE_BOOL_V(sigp_pending_resume, NCR710State, 3),
 
diff --git a/hw/scsi/ncr53c710.h b/hw/scsi/ncr53c710.h
index f96c6e5565..14003d9a60 100644
--- a/hw/scsi/ncr53c710.h
+++ b/hw/scsi/ncr53c710.h
@@ -3,12 +3,9 @@
  *
  * Copyright (c) 2026 Keith Monahan <keith@techtravels.org>
  *
- * Interface to the 53C710 model (ncr53c710.c), a rewrite whose SCRIPTS engine
- * is derived from QEMU's LSI53C895A model and adapted to the 53C710 per its
- * Data Manual (Jun 1992).  The only instantiated device is the LASI wrapper in
- * lasi_ncr710.c, which embeds one NCR710State by value and drives it through
- * the functions declared here.  This file is a function library, not a QOM
- * type.
+ * Interface to the 53C710 model (ncr53c710.c).  The only instantiated device is
+ * the LASI wrapper in lasi_ncr710.c, which embeds one NCR710State by value and
+ * drives it through the functions declared here.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
@@ -75,9 +72,8 @@ typedef struct NCR710State {
     AddressSpace *as;
     qemu_irq irq;
     /*
-     * SCRIPTS yield/resume timer: instruction budget backoff and post load
-     * restart, mirroring lsi53c895a's scripts_timer.  The wrapper creates it
-     * and points it at ncr710_scripts_timer_callback().
+     * SCRIPTS yield/resume timer, mirroring lsi53c895a's scripts_timer.  The
+     * wrapper creates it.
      */
     QEMUTimer *scripts_timer;
 
@@ -93,30 +89,20 @@ typedef struct NCR710State {
     int command_complete;
     bool script_running;
     /*
-     * The driver's "start next command" SIGP kick landed while the engine was
-     * halted at a completion INT (waiting==NOWAIT) instead of parked at Wait
-     * Reselect, so the normal SIGP wake is skipped.  The ISTAT write clears the
-     * SIGP latch (presenting the kick as "consumed" to the driver's poll) and
-     * sets this flag instead; the Wait Reselect handler (execute_script case 2)
-     * consumes it when the engine next parks, selecting the next command.
+     * A SIGP arrived while the engine was halted instead of parked at Wait
+     * Reselect; the Wait Reselect handler consumes it when the engine next
+     * parks.
      */
     bool sigp_pending_resume;
-    /*
-     * A cached-backend SCSI continue was deferred to lsi_issue_bh so its
-     * completion arrives asynchronously, not reentrantly inside the engine.
-     */
+    /* A SCSI continue was deferred to lsi_issue_bh. */
     bool issue_pending;
     /*
-     * SCRIPTS interpreter on-stack recursion depth; transient (always 0
-     * outside execute_script), so it is not migrated in vmstate.
+     * SCRIPTS interpreter recursion depth; always 0 outside
+     * lsi_execute_script, so it is not migrated.
      */
     int reentrancy_level;
     lsi_request *current;
-    /*
-     * Disconnected tagged commands awaiting target-initiated reselection
-     * (lsi53c895a-style).  Untagged 53C700-family transfers never disconnect,
-     * so for them this stays empty and the engine runs connected as before.
-     */
+    /* Disconnected tagged commands awaiting reselection. */
     QTAILQ_HEAD(, lsi_request) queue;
 
     /*
-- 
2.54.0


