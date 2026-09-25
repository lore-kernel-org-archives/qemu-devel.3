Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26834C98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8QJ-0005Ze-GQ; Fri, 25 Sep 2026 12:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8DT-0007pv-Jm
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:03 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8DP-0005wS-UM
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:03 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd4ba9f68so11798225e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1790351518; x=1790956318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aSftoR6E6Ri0aJ0ChW9kw3c0X9HiQbgax0Jl26xDQyY=;
 b=Y5LCLpApQmewYhw93KGmvZwgei7JmIKqVjqual3Z7qeM82PPDRpt5qv4Mlp3UHCrGu
 aZAh5dSyqZRDYkQb2uQ3wtENDYUvOQM9vinsBFZz61GYtbl46PcMZZqU39OT4pbd/Q3o
 KPcUND/t8l5AJjSi18c949muRw3PF+T4oWds3b6auNilhLo21JvqoROzY2MxmsaQk3lF
 D6ktY/KFTY4lnzLTCEUdlISpN4ciHsNcYDlgK7ExGJfD1oN/NCMqFKI/d5F41y3iKqoL
 Mp3iaczJ7YCWymIBzwl1eiuEyCEzEezN4Z6LjbhFftT7WOzC7ETMQmzTSJJBdpCb+oER
 c+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351518; x=1790956318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aSftoR6E6Ri0aJ0ChW9kw3c0X9HiQbgax0Jl26xDQyY=;
 b=jMHz17qHotjWrVyhY4lU4ZvIPt3GhjnQFnOqpJ/4PmGWFkpBJFdPhJQ8eltjpnQ7x4
 7mmPolZz7EI4Ik/T4AJ+vtcwfzZPXyFAJH8xtfamGoBQoATtAwKjV0S26ngL5cLww4GQ
 JEH1tW0/6b09+1ZGgcTVMo0JLIaPFzNMpATn7o/p08ZN6IKej79o5XIavhZT1NmES4OW
 3vRycEpF5E7OytOKl/0w0lyR9XQ7dFB4N/tHhcMlRYalyoR40aoz18M1B/+UHlR8npqx
 aA2WUBhAxMhDADDaapYLzYfSSVgpoQfzie0ZuYTw6LHCAHcdTC4J3l4DoGDo9xjw9QHi
 fVqg==
X-Gm-Message-State: AFuF++mx1F97MBHZ8uCUjEIAt2MoPGitVi2ag745olbhAHeX1HyFPMgm
 6if7dInFZl/X15q8LnkeIwCS1sVV9aG15kwoYiam8vBhHZBiIdh+nuUew82dTYYV6CwsdMGjOmZ
 Yc1Fptl+NWA==
X-Gm-Gg: AYBFou1NbHnhTBar0rnPWFr+e+cY2krqeDmM3KoNGuFljfRaMgjxouqubXbGU4qbZNQ
 wfpzIpGkytPbZ47H/+dDWMKOr3HrSeHGhfe/Wifac0WlgyROMnrPz0gfzzOCTv2EajD8gdOTl8U
 nwpYXl/Uot98oivG+sDApmYTcY5OrjRqS9Nn5YlsAzBkXTVMfOw92/aWi1y1ghVe83SX+ezFWcj
 C87gux3kplIl/E+KjaNV1D/+auqXlcy0q5HR8c7zesaW4bxZfgp2zygamj680hSR4G/xLdLwkiR
 /0QCmt0kOfiIq5XVJPpnwb4LNIHk74Ewj8DwmBSpu+WKiXWIf9X1TMJCraBEzvEtud624p5AQuU
 P43Kbn4o1tFFgtPrB072fKVEYRrVv8k1QfEoL5bQ5nacdbHPr7FYXQo6wnnd+TpNVcompEAz7em
 1e5ZfLHRO7UxToealZgxZlKVyzEXHxAjh/w/uFHln5uYblxqE/ztkrtkjt9fLGb7rFHf56JHvNm
 iS6H17VVi+C74TWD3T0ikUXehRY2awHOA8RcqF5vw==
X-Received: by 2002:a05:600c:4e53:b0:49f:d58f:1f8b with SMTP id
 5b1f17b1804b1-49fe66d807bmr105364325e9.18.1790351518569; 
 Fri, 25 Sep 2026 08:51:58 -0700 (PDT)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff0f1f2e3sm112435875e9.0.2026.09.25.08.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:51:58 -0700 (PDT)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>, Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH 02/13] migration/rdma: Add producer/consumer send-ring
 types
Date: Fri, 25 Sep 2026 17:51:37 +0200
Message-ID: <20260925155149.843870-3-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
References: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:31::10;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wm2-x10.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Sep 2026 12:04:43 -0400
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

Define the SPSC send-ring descriptor (RDMACmd), the ring itself
(RDMASendRing) and the producer/consumer fields in RDMAContext.  No
functional change.

Signed-off-by: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
---
 migration/rdma.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index 50f5d7b839..e4ede950de 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -29,6 +29,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/rcu.h"
+#include "qemu/thread.h"
 #include "qemu/sockets.h"
 #include "qemu/coroutine.h"
 #include "system/memory.h"
@@ -278,6 +279,33 @@ typedef struct RDMALocalBlocks {
     RDMALocalBlock *block;
 } RDMALocalBlocks;
 
+/*
+ * Producer/consumer split (source side): the migration thread (producer)
+ * scans dirty pages and enqueues chunk-write and barrier commands into an
+ * SPSC ring; a dedicated consumer thread owns the QP/CQ and does all RDMA.
+ */
+typedef enum {
+    RDMA_CMD_WRITE,     /* write one dirty span: block/chunk + offset/length */
+    RDMA_CMD_FLUSH,     /* drain nb_sent -> 0 (round boundary) */
+    RDMA_CMD_REG_STOP,  /* send REGISTER_FINISHED; flags = RAM_CONTROL_* */
+    RDMA_CMD_FILE,      /* QEMUFile control bytes: iov/niov */
+    RDMA_CMD_FINISH,    /* drain then stop the consumer */
+} RDMACmdType;
+
+typedef struct RDMACmd {
+    RDMACmdType type;
+    uint32_t block_index;
+    uint32_t chunk_index;
+    uint64_t offset;              /* WRITE: dirty span start, block-relative */
+    uint32_t length;             /* WRITE: dirty span length (within a chunk) */
+    uint64_t flags;               /* REG_STOP */
+    const struct iovec *iov;      /* FILE (producer blocks -> stays valid) */
+    size_t niov;                  /* FILE */
+    unsigned seq;                 /* barrier completion sequence (0 = none) */
+} RDMACmd;
+
+typedef struct RDMASendRing RDMASendRing;
+
 /*
  * Main data structure for RDMA state.
  * While there is only one copy of this structure being allocated right now,
@@ -317,6 +345,17 @@ typedef struct RDMAContext {
     /* index of the chunk in the current ram block */
     int current_chunk;
 
+    /* producer/consumer split (source side) */
+    RDMASendRing *send_ring;      /* SPSC ring; allocated at consumer start */
+    QemuThread consumer_thread;
+    bool consumer_started;        /* producer-only: route via ring once set */
+
+    /* producer-only: pending contiguous WRITE span, not yet enqueued */
+    int pend_block;               /* block index, -1 = none */
+    uint32_t pend_chunk;          /* chunk index of the span */
+    uint64_t pend_offset;         /* span start, block-relative bytes */
+    uint64_t pend_length;         /* span length in bytes (within one chunk) */
+
     bool pin_all;
 
     /*
@@ -2671,6 +2710,49 @@ static NotifierWithReturn rdma_ram_round_notifier = {
     .notify = rdma_ram_round_notify,
 };
 
+/*
+ * ---------------------------------------------------------------------------
+ * Producer/consumer send ring (source side).
+ *
+ * Lock-free SPSC ring: the producer (migration thread) owns head, the
+ * consumer (RDMA thread) owns tail.  A mutex+condvars are used only to
+ * sleep/wake at the empty/full/abort/barrier edges (guarded by the *_waiting
+ * flags so the steady state stays lock-free).  Barriers ride the ring as
+ * ordered descriptors and publish completion via barrier_done_seq.
+ *
+ * head/tail are free-running unsigned counters, never reset.  Wrap is
+ * implicit: occupancy is the modular difference head - tail (always in
+ * [0, N] since the producer stops at full), and the slot index is
+ * counter & MASK.  Because N is a power of two and 2^32 is an exact multiple
+ * of N, masking stays continuous across the 2^32 counter wrap.  Barrier seqs
+ * use the same modular scheme with signed distance; seq 0 is reserved as the
+ * "no barrier" sentinel and skipped on wrap.
+ * ---------------------------------------------------------------------------
+ */
+#define RDMA_SEND_RING_SIZE 2048            /* power of two; > SQ depth (512) */
+#define RDMA_SEND_RING_MASK (RDMA_SEND_RING_SIZE - 1)
+
+struct RDMASendRing {
+    RDMACmd  ring[RDMA_SEND_RING_SIZE];
+    unsigned head;                          /* producer owns */
+    unsigned tail;                          /* consumer owns */
+    unsigned barrier_done_seq;              /* consumer owns; producer reads */
+    unsigned barrier_next_seq;              /* producer owns */
+    bool     abort;                         /* sticky */
+    QemuMutex wait_lock;
+    QemuCond  not_full;                     /* producer sleeps */
+    QemuCond  not_empty;                    /* consumer sleeps */
+    QemuCond  barrier_cv;                   /* producer sleeps for ack */
+    bool     producer_waiting;
+    bool     consumer_waiting;
+
+    /* statistics, dumped at FINISH */
+    uint64_t pushwait_max_ns;    /* longest producer wait on a full ring */
+    uint64_t pushwait_total_ns;  /* total producer wait on a full ring */
+    uint64_t occupancy_max;      /* peak queued commands */
+    uint64_t idle_max_ns;        /* longest consumer wait on an empty ring */
+};
+
 static int qio_channel_rdma_set_blocking(QIOChannel *ioc,
                                          bool blocking,
                                          Error **errp)
-- 
2.39.5


