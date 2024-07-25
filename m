Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3759FC3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Kh-0000lr-IW; Thu, 25 Jul 2024 19:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8KZ-0000Jj-5t; Thu, 25 Jul 2024 19:57:10 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8KW-0001Iw-TE; Thu, 25 Jul 2024 19:57:06 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fd66cddd07so893755ad.2; 
 Thu, 25 Jul 2024 16:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951822; x=1722556622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tIZkv4JWnwd45wio/vjzrEFJS5V3/8wEJXSPkeVls8w=;
 b=bmSgxX0Py5IoQB6m+opvQeFohIgY/tGJZzxEMU6wr0QVLgT7zslpIKeDVSoSBG2C2Z
 Fa0jGz3NxTZBwdKJwYQ+w6uc2vkQvs/jyX7isj06eY3+HOs8XIePmLf7S0mTRKATuDVw
 4vOCxsSu1ebx4zfvEr44PzQPAhf22bSVhSTQomSPB9Tmc3z/f0caQNTf/6BvymKcJjBQ
 Ueb8owsA2Hfrt5weU7EiYUAqtBw7Evh2ixIh7mRDOUfOQVhCP63hT9xz7GxjFTyCwWJh
 +GmO5htTMnNK/xN7ymnbCBoTyzwE85eNtpOdGSBdFkxWOSISEHLEt+0Gl2wh8nNLkuR6
 Snew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951822; x=1722556622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tIZkv4JWnwd45wio/vjzrEFJS5V3/8wEJXSPkeVls8w=;
 b=pOcwZ8pV2sjlJcZXzp16V0TvS4toIuyDniepjAi7zYdLSv1pZmFK403y0jYS8Pa8P2
 TNqotbCNAl2/23fuVCNCY1zVVNA7coJkpiLNNzOf085LXen/UeQlbgTtO5jM3HG+ghR6
 7wIQsL//6gC2RmGNDlP+0srJeXOHfT7GP+dRtV9/cSY9EfmwtKT6GD6LirAjmkFCpw7b
 U0SPlB7GoBbShr1M5okM4boxKRcy/4qX+8ejlh6OcxD2Xtcf8JvmPsXjySA1/rLdNvOU
 OXV+J2PLLDmmtB/m5FInXyEB2r9wv8cSArawaFH5VbpzInUM72TxySv5H8UCsn56ef8z
 UDaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0oOv8DJ5+NtyzeSo7gjJ1N42c5Iso46OtDT0KP9aj35+4P+Xkj9oBehkL//Ws7ezUBxg04bnPgx7RjluoHoUCuckc
X-Gm-Message-State: AOJu0Ywpvwpmx+FJewc1JM5Av+Zd9lXwigclSFUIdoX1JuoG2QVty3in
 WDrvdYTyM5NMt2ZktcZUurLDYVwOHgRUu6HKJK+IPRwTzxsYqvW+sLu6pA==
X-Google-Smtp-Source: AGHT+IFrDky/wdyhLNrKd+ftvsLXhLvD7/Jsd2Fs6Vcu7H3v9DPd+ayCYV4WgU4hV1oHjnSzZGk8dg==
X-Received: by 2002:a17:90a:ee86:b0:2c9:6401:4d1d with SMTP id
 98e67ed59e1d1-2cf23926b1cmr5105731a91.34.1721951822010; 
 Thu, 25 Jul 2024 16:57:02 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:57:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 44/96] pnv/xive: Support cache flush and queue sync inject with
 notifications
Date: Fri, 26 Jul 2024 09:53:17 +1000
Message-ID: <20240725235410.451624-45-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

Adds support for writing a completion notification byte in memory
whenever a cache flush or queue sync inject operation is requested by
software.  QEMU does not cache any of the XIVE data that is in memory and
therefore it simply writes the completion notification byte at the time
that the operation is requested.

Co-authored-by: Glenn Miles <milesg@linux.vnet.ibm.com>

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/pnv_xive2.c       | 154 +++++++++++++++++++++++++++++++++++++-
 hw/intc/pnv_xive2_regs.h  |  16 ++++
 include/hw/ppc/pnv_chip.h |   1 +
 3 files changed, 169 insertions(+), 2 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 08b6da78fb..3dbbfddacb 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -25,6 +25,7 @@
 #include "hw/ppc/ppc.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/reset.h"
+#include "sysemu/qtest.h"
 
 #include <libfdt.h>
 
@@ -32,6 +33,16 @@
 
 #undef XIVE2_DEBUG
 
+/* XIVE Sync or Flush Notification Block */
+typedef struct XiveSfnBlock {
+    uint8_t bytes[32];
+} XiveSfnBlock;
+
+/* XIVE Thread Sync or Flush Notification Area */
+typedef struct XiveThreadNA {
+    XiveSfnBlock topo[16];
+} XiveThreadNA;
+
 /*
  * Virtual structures table (VST)
  */
@@ -54,7 +65,7 @@ static const XiveVstInfo vst_infos[] = {
     [VST_NVC]  = { "NVCT", sizeof(Xive2Nvgc),    16 },
 
     [VST_IC]  =  { "IC",   1, /* ? */            16 }, /* Topology # */
-    [VST_SYNC] = { "SYNC", 1, /* ? */            16 }, /* Topology # */
+    [VST_SYNC] = { "SYNC", sizeof(XiveThreadNA), 16 }, /* Topology # */
 
     /*
      * This table contains the backing store pages for the interrupt
@@ -329,6 +340,73 @@ static int pnv_xive2_write_end(Xive2Router *xrtr, uint8_t blk, uint32_t idx,
                               word_number);
 }
 
+static inline int pnv_xive2_get_current_pir(PnvXive2 *xive)
+{
+    if (!qtest_enabled()) {
+        PowerPCCPU *cpu = POWERPC_CPU(current_cpu);
+        return ppc_cpu_pir(cpu);
+    }
+    return 0;
+}
+
+/*
+ * After SW injects a Queue Sync or Cache Flush operation, HW will notify
+ * SW of the completion of the operation by writing a byte of all 1's (0xff)
+ * to a specific memory location.  The memory location is calculated by first
+ * looking up a base address in the SYNC VSD using the Topology ID of the
+ * originating thread as the "block" number.  This points to a
+ * 64k block of memory that is further divided into 128 512 byte chunks of
+ * memory, which is indexed by the thread id of the requesting thread.
+ * Finally, this 512 byte chunk of memory is divided into 16 32 byte
+ * chunks which are indexed by the topology id of the targeted IC's chip.
+ * The values below are the offsets into that 32 byte chunk of memory for
+ * each type of cache flush or queue sync operation.
+ */
+#define PNV_XIVE2_QUEUE_IPI              0x00
+#define PNV_XIVE2_QUEUE_HW               0x01
+#define PNV_XIVE2_QUEUE_NXC              0x02
+#define PNV_XIVE2_QUEUE_INT              0x03
+#define PNV_XIVE2_QUEUE_OS               0x04
+#define PNV_XIVE2_QUEUE_POOL             0x05
+#define PNV_XIVE2_QUEUE_HARD             0x06
+#define PNV_XIVE2_CACHE_ENDC             0x08
+#define PNV_XIVE2_CACHE_ESBC             0x09
+#define PNV_XIVE2_CACHE_EASC             0x0a
+#define PNV_XIVE2_QUEUE_NXC_LD_LCL_NCO   0x10
+#define PNV_XIVE2_QUEUE_NXC_LD_LCL_CO    0x11
+#define PNV_XIVE2_QUEUE_NXC_ST_LCL_NCI   0x12
+#define PNV_XIVE2_QUEUE_NXC_ST_LCL_CI    0x13
+#define PNV_XIVE2_QUEUE_NXC_ST_RMT_NCI   0x14
+#define PNV_XIVE2_QUEUE_NXC_ST_RMT_CI    0x15
+#define PNV_XIVE2_CACHE_NXC              0x18
+
+static int pnv_xive2_inject_notify(PnvXive2 *xive, int type)
+{
+    uint64_t addr;
+    int pir = pnv_xive2_get_current_pir(xive);
+    int thread_nr = PNV10_PIR2THREAD(pir);
+    int thread_topo_id = PNV10_PIR2CHIP(pir);
+    int ic_topo_id = xive->chip->chip_id;
+    uint64_t offset = ic_topo_id * sizeof(XiveSfnBlock);
+    uint8_t byte = 0xff;
+    MemTxResult result;
+
+    /* Retrieve the address of requesting thread's notification area */
+    addr = pnv_xive2_vst_addr(xive, VST_SYNC, thread_topo_id, thread_nr);
+
+    if (!addr) {
+        xive2_error(xive, "VST: no SYNC entry %x/%x !?",
+                    thread_topo_id, thread_nr);
+        return -1;
+    }
+
+    address_space_stb(&address_space_memory, addr + offset + type, byte,
+                      MEMTXATTRS_UNSPECIFIED, &result);
+    assert(result == MEMTX_OK);
+
+    return 0;
+}
+
 static int pnv_xive2_end_update(PnvXive2 *xive, uint8_t watch_engine)
 {
     uint8_t  blk;
@@ -1178,6 +1256,10 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
         /* ESB update */
         break;
 
+    case VC_ESBC_FLUSH_INJECT:
+        pnv_xive2_inject_notify(xive, PNV_XIVE2_CACHE_ESBC);
+        break;
+
     case VC_ESBC_CFG:
         break;
 
@@ -1190,6 +1272,10 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
         /* EAS update */
         break;
 
+    case VC_EASC_FLUSH_INJECT:
+        pnv_xive2_inject_notify(xive, PNV_XIVE2_CACHE_EASC);
+        break;
+
     case VC_ENDC_CFG:
         break;
 
@@ -1224,6 +1310,10 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
         xive->vc_regs[VC_ENDC_FLUSH_CTRL >> 3] |= VC_ENDC_FLUSH_CTRL_POLL_VALID;
         break;
 
+    case VC_ENDC_FLUSH_INJECT:
+        pnv_xive2_inject_notify(xive, PNV_XIVE2_CACHE_ENDC);
+        break;
+
     /*
      * Indirect invalidation
      */
@@ -1424,6 +1514,10 @@ static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
         xive->pc_regs[PC_NXC_FLUSH_CTRL >> 3] |= PC_NXC_FLUSH_CTRL_POLL_VALID;
         break;
 
+    case PC_NXC_FLUSH_INJECT:
+        pnv_xive2_inject_notify(xive, PNV_XIVE2_CACHE_NXC);
+        break;
+
     /*
      * Indirect invalidation
      */
@@ -1727,6 +1821,12 @@ static const MemoryRegionOps pnv_xive2_ic_lsi_ops = {
 #define PNV_XIVE2_SYNC_OS_ESC           0x200
 #define PNV_XIVE2_SYNC_POOL_ESC         0x280
 #define PNV_XIVE2_SYNC_HARD_ESC         0x300
+#define PNV_XIVE2_SYNC_NXC_LD_LCL_NCO   0x800
+#define PNV_XIVE2_SYNC_NXC_LD_LCL_CO    0x880
+#define PNV_XIVE2_SYNC_NXC_ST_LCL_NCI   0x900
+#define PNV_XIVE2_SYNC_NXC_ST_LCL_CI    0x980
+#define PNV_XIVE2_SYNC_NXC_ST_RMT_NCI   0xA00
+#define PNV_XIVE2_SYNC_NXC_ST_RMT_CI    0xA80
 
 static uint64_t pnv_xive2_ic_sync_read(void *opaque, hwaddr offset,
                                        unsigned size)
@@ -1738,22 +1838,72 @@ static uint64_t pnv_xive2_ic_sync_read(void *opaque, hwaddr offset,
     return -1;
 }
 
+/*
+ * The sync MMIO space spans two pages.  The lower page is use for
+ * queue sync "poll" requests while the upper page is used for queue
+ * sync "inject" requests.  Inject requests require the HW to write
+ * a byte of all 1's to a predetermined location in memory in order
+ * to signal completion of the request.  Both pages have the same
+ * layout, so it is easiest to handle both with a single function.
+ */
 static void pnv_xive2_ic_sync_write(void *opaque, hwaddr offset,
                                     uint64_t val, unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    int inject_type;
+    hwaddr pg_offset_mask = (1ull << xive->ic_shift) - 1;
 
-    switch (offset) {
+    /* adjust offset for inject page */
+    hwaddr adj_offset = offset & pg_offset_mask;
+
+    switch (adj_offset) {
     case PNV_XIVE2_SYNC_IPI:
+        inject_type = PNV_XIVE2_QUEUE_IPI;
+        break;
     case PNV_XIVE2_SYNC_HW:
+        inject_type = PNV_XIVE2_QUEUE_HW;
+        break;
     case PNV_XIVE2_SYNC_NxC:
+        inject_type = PNV_XIVE2_QUEUE_NXC;
+        break;
     case PNV_XIVE2_SYNC_INT:
+        inject_type = PNV_XIVE2_QUEUE_INT;
+        break;
     case PNV_XIVE2_SYNC_OS_ESC:
+        inject_type = PNV_XIVE2_QUEUE_OS;
+        break;
     case PNV_XIVE2_SYNC_POOL_ESC:
+        inject_type = PNV_XIVE2_QUEUE_POOL;
+        break;
     case PNV_XIVE2_SYNC_HARD_ESC:
+        inject_type = PNV_XIVE2_QUEUE_HARD;
+        break;
+    case PNV_XIVE2_SYNC_NXC_LD_LCL_NCO:
+        inject_type = PNV_XIVE2_QUEUE_NXC_LD_LCL_NCO;
+        break;
+    case PNV_XIVE2_SYNC_NXC_LD_LCL_CO:
+        inject_type = PNV_XIVE2_QUEUE_NXC_LD_LCL_CO;
+        break;
+    case PNV_XIVE2_SYNC_NXC_ST_LCL_NCI:
+        inject_type = PNV_XIVE2_QUEUE_NXC_ST_LCL_NCI;
+        break;
+    case PNV_XIVE2_SYNC_NXC_ST_LCL_CI:
+        inject_type = PNV_XIVE2_QUEUE_NXC_ST_LCL_CI;
+        break;
+    case PNV_XIVE2_SYNC_NXC_ST_RMT_NCI:
+        inject_type = PNV_XIVE2_QUEUE_NXC_ST_RMT_NCI;
+        break;
+    case PNV_XIVE2_SYNC_NXC_ST_RMT_CI:
+        inject_type = PNV_XIVE2_QUEUE_NXC_ST_RMT_CI;
         break;
     default:
         xive2_error(xive, "SYNC: invalid write @%"HWADDR_PRIx, offset);
+        return;
+    }
+
+    /* Write Queue Sync notification byte if writing to sync inject page */
+    if ((offset & ~pg_offset_mask) != 0) {
+        pnv_xive2_inject_notify(xive, inject_type);
     }
 }
 
diff --git a/hw/intc/pnv_xive2_regs.h b/hw/intc/pnv_xive2_regs.h
index f8e4a677c6..ca05255d20 100644
--- a/hw/intc/pnv_xive2_regs.h
+++ b/hw/intc/pnv_xive2_regs.h
@@ -232,6 +232,10 @@
 #define  VC_ESBC_FLUSH_POLL_BLOCK_ID_MASK       PPC_BITMASK(32, 35)
 #define  VC_ESBC_FLUSH_POLL_OFFSET_MASK         PPC_BITMASK(36, 63) /* 28-bit */
 
+/* ESBC cache flush inject register */
+#define X_VC_ESBC_FLUSH_INJECT                  0x142
+#define VC_ESBC_FLUSH_INJECT                    0x210
+
 /* ESBC configuration */
 #define X_VC_ESBC_CFG                           0x148
 #define VC_ESBC_CFG                             0x240
@@ -250,6 +254,10 @@
 #define  VC_EASC_FLUSH_POLL_BLOCK_ID_MASK       PPC_BITMASK(32, 35)
 #define  VC_EASC_FLUSH_POLL_OFFSET_MASK         PPC_BITMASK(36, 63) /* 28-bit */
 
+/* EASC flush inject register */
+#define X_VC_EASC_FLUSH_INJECT                  0x162
+#define VC_EASC_FLUSH_INJECT                    0x310
+
 /*
  * VC2
  */
@@ -270,6 +278,10 @@
 #define  VC_ENDC_FLUSH_POLL_BLOCK_ID_MASK       PPC_BITMASK(36, 39)
 #define  VC_ENDC_FLUSH_POLL_OFFSET_MASK         PPC_BITMASK(40, 63) /* 24-bit */
 
+/* ENDC flush inject register */
+#define X_VC_ENDC_FLUSH_INJECT                  0x182
+#define VC_ENDC_FLUSH_INJECT                    0x410
+
 /* ENDC Sync done */
 #define X_VC_ENDC_SYNC_DONE                     0x184
 #define VC_ENDC_SYNC_DONE                       0x420
@@ -403,6 +415,10 @@
 #define  PC_NXC_FLUSH_POLL_BLOCK_ID_MASK        PPC_BITMASK(36, 39)
 #define  PC_NXC_FLUSH_POLL_OFFSET_MASK          PPC_BITMASK(40, 63) /* 24-bit */
 
+/* NxC Cache flush inject */
+#define X_PC_NXC_FLUSH_INJECT                   0x282
+#define PC_NXC_FLUSH_INJECT                     0x410
+
 /* NxC Cache watch assign */
 #define X_PC_NXC_WATCH_ASSIGN                   0x286
 #define PC_NXC_WATCH_ASSIGN                     0x430
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index de34cbdc96..24ce37a9c8 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -139,6 +139,7 @@ struct Pnv10Chip {
 
 #define PNV10_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
 #define PNV10_PIR2CHIP(pir)      (((pir) >> 8) & 0x7f)
+#define PNV10_PIR2THREAD(pir)    (((pir) & 0x7f))
 
 struct PnvChipClass {
     /*< private >*/
-- 
2.45.2


