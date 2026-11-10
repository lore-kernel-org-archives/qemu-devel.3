Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EBF606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=CZJM/DHP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnOV-0003nM-Ar; Tue, 10 Nov 2026 10:04:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnNy-000357-RG
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:03:47 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnNw-0008U0-Kx
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:03:46 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so1697228f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1794323023; x=1794927823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aSftoR6E6Ri0aJ0ChW9kw3c0X9HiQbgax0Jl26xDQyY=;
 b=CZJM/DHPuXeRcpyt0Pgr+Lbt1fNAT2pcROfXnHaAzhkVzs31X2hpfJMV5OwEwRWmV1
 sENAg6+iX9geBzCRfCt2J1OXlG9XBGPCWmbvYPFZa+vTwn9gWOi5waoXuFgpFGelkVHy
 T+3tkDIwJirQ9F9+eDY6mvH6OFytPyy/330Jp4hqxwXa4xCvsfOfeJQBPtcup8+E77Zn
 5sojneEkOD4wZbI8iEytMd4skXbvFw4mVoFaYPkbqqCeIBJHbQKV7YbZszTGsJLy7TEH
 A8DPpZzbTxOXczKbFEBGfApUekvH2376VRGbt4cxTjYBNG9tKkrvyw782V+x+aVOKGxO
 R0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794323023; x=1794927823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aSftoR6E6Ri0aJ0ChW9kw3c0X9HiQbgax0Jl26xDQyY=;
 b=V7hTv5DBkiq69aF69WS5LC5WB+zsn7qBBvVtG7DzSdum4fQDOXWxMozynOmplP9K1q
 PVyJtOoR8HN78XdYMOjAFtT0JqrmEdTmWvE3seh5oqojvlnDmnc9WoKcFhWWs64219YJ
 OzlctG3F/pIIYTDUAunxYo2w1jDnj7EgNe+bE59zysBlotFsQcPc7wQv/KAg+TCLhKIX
 pXfGUKyiycGdKuxA1ZujPY1PV5QRu1B/gNv1KgLPCXEEzF9mYk76FyK0xPJKCN6+hI19
 a/iJAGaLY4T61XxTMx4ockcOBumbLNa2gia26z7Sp9WQeAeq7vvG4DxlSm1p4HG9lomk
 cGPg==
X-Gm-Message-State: APuU4Z+cH8O0FMzFi4SEzFEPAN91zwitToWchoPoqZqxGJqHuHLxkC5A
 BCK4Y+aefy3xmSl8HkirSM2IrgwQOQIDygWNUhJHWEx924oabLAvdULD9erZdFPIUPGD+LN8Bm4
 fO+7GZag=
X-Gm-Gg: AYBFou2EA1JtmfBd6aHjTG2HwLdhKc38nORJcO14TeX8KqZNH+b0Q1RjJHSSyPcrctV
 TOdG7cWJUjJWgJHS4CulPap1F13ZgotbSrkym/q1RHoYsk1qJANj/0/JLiLS7QHBEVkUseUc1tH
 3okhVLUhCO7DZIwiF8F1jIVgCAP8fEHqDPRw72haTRGrBE0DaAxqMzLZ49FFKFd0cKqYLvjiZwD
 cbLSrBbqNm8IfI4ON+RjKn56yHm6gL3btgY0GPwbQZFQKSMYUaUPq3I2vgd8uG5QjDezjhc2uY5
 JfPURq9s7R7AIgMk2hjX3wK86UScpGBox423w6iYTgjlGxwk3Ga7eT3NcZ32eGSHXS9TPL/gGiL
 wUWkiMol5DKnEkjNctViF/WLOaPePvc1xWMPhAI6OG/d2VaQjzNt6KeOxcdiXkhHLSzANGh+BZx
 gnUoGcs9bwsqWul8GhrogbRHZrTf9OXe0LGkJ7Fij3TPxs+GkbdDxrRN99Ot3+4IZeCMwFHA0Fk
 GY2bJnS9BdsBU4rtJRJVK0QCfNCVNGfT78df5nNm4gAC3CKNv77GYGPNdQTRQixdhcDrrrdqVkE
 i5Km2P1nNHgF5k/8I0duxnHf+uuMNUwsCfoscrMQWHkta5nNxmDsDkAatZ4mZwDDj1q3Cf5JGg=
 =
X-Received: by 2002:a05:6000:24c4:b0:492:b1c5:6db6 with SMTP id
 ffacd0b85a97d-49835e20e10mr6533424f8f.6.1794323022825; 
 Tue, 10 Nov 2026 07:03:42 -0800 (PST)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c4e07sm5116931f8f.49.2026.11.10.07.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 07:03:42 -0800 (PST)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 jinpu.wang@cloud.ionos.com, yanfei.xu@bytedance.com,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH RESEND 02/13] migration/rdma: Add producer/consumer
 send-ring types
Date: Tue, 10 Nov 2026 16:02:36 +0100
Message-ID: <20261110150247.193208-3-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110150247.193208-1-dmitrii.omelchenko@cloud.ionos.com>
References: <20261110150247.193208-1-dmitrii.omelchenko@cloud.ionos.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:20::42d;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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


