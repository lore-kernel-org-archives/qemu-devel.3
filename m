Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F657606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z9AXJJaW;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=p2M6ymtv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIrzL-0006hf-RQ; Mon, 19 Oct 2026 14:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIrys-0006Vl-0R
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:21:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIryo-0005rL-Sz
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792434062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BaKjM2lbdTuf+noosjvno29uVBbNRTtkTIiuAPgJ+AU=;
 b=Z9AXJJaWk9MrC5cM/wuHW5nxywy4pYALvBgydZNGpwX7+WuDGKs59n9KJXfUXow+7rjnaJ
 U7ukn8JjcIF+KjIbK8T06/RMMeBOPqIMg5umnhE18qf3YCg5vRx1DpcTFXP9rFXt9mpLUO
 bBMobNPb0yojVhko3As22+ISTrnLqXo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-EddtMTW8NyWykqGmZ1GnVg-1; Mon, 19 Oct 2026 18:21:00 +0000
X-MC-Unique: EddtMTW8NyWykqGmZ1GnVg-1
X-Mimecast-MFC-AGG-ID: EddtMTW8NyWykqGmZ1GnVg_1792434059
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48dff112136so1676013f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 11:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792434059; x=1793038859; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BaKjM2lbdTuf+noosjvno29uVBbNRTtkTIiuAPgJ+AU=;
 b=p2M6ymtv5HvIFxJIpRs2d6o87K6h8q73GjB8cCVltJcO0X1WYA9xcx6ztLviHhpdOg
 kotPFfkONROkghB19QDq+z+gGjObOROJeWK4LDpAwqOuoIvmJ3kFeB5VwLAwzMcaHGMA
 LJ/lCQAxK2azoTgnIJcmeSAsyWjWq65B6QkScp93TIB1DRXYPaAL6UrcDIryWzOE7yFx
 9SL1AKchc0PjozyLKSfb8j4BP1kR3cHzl2uZavWQO9nP+hOZJq8nkcfHWWw0gTfgT0VA
 1wG7dtxqOB/SobIVV5+hTh1i1B3S3bBOtNWbl9Xe7fuYNnz9HeqNYJYZvqAQfFPkyzYj
 Gr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792434059; x=1793038859;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BaKjM2lbdTuf+noosjvno29uVBbNRTtkTIiuAPgJ+AU=;
 b=sd/oL/bU72A/4Tgeeqj7w0q893FTqBMGSXCa4POCQwcQbseDVS5IKpD7KJDMe156iO
 ktwvT6v6glS3Bk6Ow7Wch5U86Fvdz6Xl+krTTXMjpms/sRDErKXETyoLwDzbLhNeYw2Q
 kLRugSNDjDI35xpkXOH0ZrYas+bbQK69KJ+oAmzq9o7ajzdQy4ftcY1GW5LaJLQqB2f/
 jyhlNeY/bWkX3ugpTrhO4oxhTsUHmtg6sO0127N9/Qhx36TstxggdQZOrwpQqQtkTgeD
 fGNsmNhns++MztOxAFx+dxlErpn3fGri68Zdv19uTrkD+ekSbYSOAF5nQmuxlrx+oyp8
 gwJA==
X-Gm-Message-State: AFq9FYJbmrQ7xofbuvgRx+q6KJ7oZ//qFnr1D4uFyFuzNNXFdMCxVo6F
 bedhcAD7DEv6fvUWE3rMedPuvkxkW+hYh7i+Y+ER5Y3YCYBNWrq+CotjDcgELLtXnwPALx2PBBt
 uWmo7q4EJW7nVj3ZabakcRgIODu6/m5syLSSIOecp9MtX4G7ZpjwEj8Dwkw0INbHd
X-Gm-Gg: AYBFou0uLmHxO0Sx0OXyVnJqFJBRkLb5k2uX2NEN7VzXLwGqMGruxlrROemiQsYxWWQ
 CPPCB+jgoIL3y3pjybOJNhReiQ9zbF2yOtaPToFewBrC9f3EwSPkib8qevysgSBLqBJ+itl2+xX
 O2mctzmUjCKK9k2xi11u3PbU3S9cEx5+Ql1HFvd3GqecNdFt1RIojNbWn4vX58GparjCWJGXIvY
 0uAW1XeFeLF+uqMlodiUs0LXxtSRmYIelG2Vg8Ji1wZNkf/eDpWTJNP9WesCx90sgfXkqqJAhS7
 oq69vqvJ+8riyPJdpF4VyACCSrYoWUJ/619S4Pl/6dmQXUsNIejncMlmrfsUGqAW6gEh/ZLU3RL
 HvWyPbI59IIlRdjN7kj2J9XspJyPu24rnlaDHOUtQVmUqyKLZatL8XW5e
X-Received: by 2002:a05:600c:8709:b0:49f:ff73:9971 with SMTP id
 5b1f17b1804b1-4a1d75f8f28mr170571015e9.18.1792434058738; 
 Mon, 19 Oct 2026 11:20:58 -0700 (PDT)
X-Received: by 2002:a05:600c:8709:b0:49f:ff73:9971 with SMTP id
 5b1f17b1804b1-4a1d75f8f28mr170570345e9.18.1792434058178; 
 Mon, 19 Oct 2026 11:20:58 -0700 (PDT)
Received: from localhost
 (p200300cfd705ccf50633a9a8543b8b67.dip0.t-ipconnect.de.
 [2003:cf:d705:ccf5:633:a9a8:543b:8b67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2d85a9bsm9643485e9.15.2026.10.19.11.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 11:20:57 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 10/12] block: Per-request delay tracker
Date: Mon, 19 Oct 2026 20:20:26 +0200
Message-ID: <20261019182028.45305-11-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019182028.45305-1-hreitz@redhat.com>
References: <20261019182028.45305-1-hreitz@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Register I/O requests to BlockBackends with a per-BB timer running in
the background (in the main context) that goes through the list of
requests to find any that surpass a user-defined[1] threshold and then
emit a QMP event calling this out, or stopping the VM altogether so the
guest can be shielded of absolutely excessive delay.

One example for where stopping may be useful: Windows will cancel
requests after a set timeout, but virtio-blk does not support cancelling
requests (by design, I understand).  So it will cancel again, and again,
and then reset the whole driver (which however won’t cancel the request
either), and eventually declare the driver faulty and show a BSOD.  The
only ways around this would be to implement request cancellation (which
I think is not generally possible), or, well, pause the VM in case of
absolutely excessive I/O request delay, and resume it when the request
is done (BLOCK_IO_DONE event), so that Windows will not see that massive
delay.

[1] Not yet user-defined in this commit, but a future commit will allow
    users to specify the threshold when to take action, on the guest
    device.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 include/block/block-backend-delay.h         | 112 +++++++
 include/system/block-backend-global-state.h |  11 +
 block/block-backend-delay.c                 | 326 ++++++++++++++++++++
 block/block-backend.c                       |  44 ++-
 block/meson.build                           |   1 +
 5 files changed, 492 insertions(+), 2 deletions(-)
 create mode 100644 include/block/block-backend-delay.h
 create mode 100644 block/block-backend-delay.c

diff --git a/include/block/block-backend-delay.h b/include/block/block-backend-delay.h
new file mode 100644
index 00000000000..9af2e6de925
--- /dev/null
+++ b/include/block/block-backend-delay.h
@@ -0,0 +1,112 @@
+/*
+ * Copyright (c) 2026 Hanna Czenczek <hreitz@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef BLOCK_BACKEND_DELAY_H
+#define BLOCK_BACKEND_DELAY_H
+
+#include "qemu/thread.h"
+#include "qemu/timer.h"
+#include "qapi/qapi-types-block.h"
+
+/* Enumeration of I/O delay threshold types */
+enum BlockDelayThreshold {
+    /* Latency threshold at which to report a delay */
+    BLOCK_DELAY_REPORT,
+    /* Latency threshold at which to auto-stop the VM */
+    BLOCK_DELAY_STOP,
+
+    /* Number of different thresholds */
+    BLOCK_DELAY__MAX,
+};
+
+typedef struct BlockDelayTracker {
+    /* Timer to regularly check requests for delay */
+    QEMUTimer *timer;
+
+    /* Which clock to use */
+    QEMUClockType clock_type;
+
+    /*
+     * Protects access to all subsequent fields in this struct. Do not take any
+     * other lock while this lock is taken.
+     */
+    QemuMutex lock;
+
+    /* Thresholds for generating delay report events or stopping the VM */
+    uint64_t threshold_ns[BLOCK_DELAY__MAX];
+
+    /* List of active requests; new requests appended at the end */
+    QTAILQ_HEAD(, BlockDelayTrackerRequest) requests;
+} BlockDelayTracker;
+
+typedef struct BlockDelayTrackerRequest {
+    /* offset < 0 means no valid offset */
+    int64_t offset;
+    /* Request length, or 0 if no valid length */
+    uint64_t bytes;
+    /* When the request was started */
+    uint64_t start_time_ns;
+    /* Operation type */
+    IoAccountingOperation op_type;
+    /*
+     * Whether any delay threshold has been exceeded.
+     * If so, we need to emit BLOCK_IO_DONE when the request is done.
+     */
+    bool threshold_exceeded[BLOCK_DELAY__MAX];
+    /*
+     * Set the first time any threshold is exceeded, to cache the device name
+     * for BLOCK_IO_DONE.
+     */
+    char *device_path;
+
+    /* Entry in the list of all running requests for this BB */
+    QTAILQ_ENTRY(BlockDelayTrackerRequest) list;
+} BlockDelayTrackerRequest;
+
+/**
+ * Set up the request latency delay tracker for this BlockBackend.
+ *
+ * The caller must allocate blk->delay_tracker beforehand (because
+ * block-backend-delay.c cannot access BlockBackend fields directly).
+ */
+void blk_delay_tracker_init(BlockBackend *blk);
+
+/**
+ * Stop and destroy the request latency delay tracker for this BlockBackend.
+ */
+void blk_delay_tracker_destroy(BlockDelayTracker *bdt);
+
+/**
+ * Return the latency delay tracker object for the given BlockBackend.
+ *
+ * (Implemented in block-backend.c, where the BlockBackend definition resides.)
+ */
+BlockDelayTracker *blk_delay_tracker(BlockBackend *blk);
+
+/**
+ * Begin tracking an I/O request on @blk of type @op_type over @bytes starting
+ * from @offset.
+ *
+ * @request is initialized by this function.
+ *
+ * Use offset=-1 for operations that have no valid offset (e.g. flush).
+ */
+void blk_track_delay_begin(BlockBackend *blk,
+                           BlockDelayTrackerRequest *request,
+                           int64_t offset,
+                           uint64_t bytes,
+                           IoAccountingOperation op_type);
+/**
+ * Finalize I/O request tracking.
+ *
+ * @ret indicates the operation's status, with 0 for success and -errno for
+ * errors.
+ */
+void blk_track_delay_end(BlockBackend *blk,
+                         BlockDelayTrackerRequest *request,
+                         int ret);
+
+#endif
diff --git a/include/system/block-backend-global-state.h b/include/system/block-backend-global-state.h
index c3849640df9..c04fcff81a7 100644
--- a/include/system/block-backend-global-state.h
+++ b/include/system/block-backend-global-state.h
@@ -102,6 +102,17 @@ void blk_update_root_state(BlockBackend *blk);
 bool blk_get_detect_zeroes_from_root_state(BlockBackend *blk);
 int blk_get_open_flags_from_root_state(BlockBackend *blk);
 
+/**
+ * Set the nanosecond threshold for per-request latency, when to consider it
+ * sufficient of a delay to report via BLOCK_IO_DELAY QMP event.
+ */
+void blk_set_delay_report_threshold(BlockBackend *blk, uint64_t ns);
+/**
+ * Set the nanosecond threshold for per-request latency, when to consider it
+ * sufficient of a delay to stop the VM.
+ */
+void blk_set_delay_stop_threshold(BlockBackend *blk, uint64_t ns);
+
 int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
                      int64_t pos, int size);
 int blk_load_vmstate(BlockBackend *blk, uint8_t *buf, int64_t pos, int size);
diff --git a/block/block-backend-delay.c b/block/block-backend-delay.c
new file mode 100644
index 00000000000..07891573861
--- /dev/null
+++ b/block/block-backend-delay.c
@@ -0,0 +1,326 @@
+/*
+ * Keep track of ongoing BlockBackend requests, notify about excessive
+ * latency (i.e. delays), and potentially even pause the VM until such a
+ * request is done.
+ *
+ * Copyright (c) 2026 Hanna Czenczek <hreitz@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "block/block-backend-delay.h"
+#include "qapi/qapi-events-block.h"
+#include "system/block-backend.h"
+#include "system/qtest.h"
+#include "system/runstate.h"
+
+/**
+ * Information for BLOCK_IO_DELAY/DONE events so that:
+ * - delay_track_timer() can collect all of the events to emit in a list and
+ *   emit them outside of the BlockDelayTracker lock.
+ * - blk_track_delay_end() can move the event emission to the main loop for
+ *   ordering
+ */
+typedef struct DelayEvent DelayEvent;
+struct DelayEvent {
+    char *device_path;
+    IoAccountingOperation op_type;
+    uint64_t duration_ns;
+    union {
+        BlockErrorAction action; /* for BLOCK_IO_DELAY */
+        int ret;                 /* for BLOCK_IO_DONE */
+    };
+    bool has_offset;
+    uint64_t offset;
+    uint64_t bytes;
+    QTAILQ_ENTRY(DelayEvent) next;
+};
+
+static void delay_track_timer(void *opaque);
+static void send_done_event(void *opaque);
+
+void blk_delay_tracker_init(BlockBackend *blk)
+{
+    BlockDelayTracker *bdt = blk_delay_tracker(blk);
+
+    assert(bdt != NULL);
+
+    bdt->clock_type = qtest_enabled() ? QEMU_CLOCK_VIRTUAL
+                                      : QEMU_CLOCK_REALTIME;
+
+    qemu_mutex_init(&bdt->lock);
+    QTAILQ_INIT(&bdt->requests);
+
+    bdt->timer = aio_timer_new(qemu_get_aio_context(), bdt->clock_type,
+                               SCALE_NS, delay_track_timer, blk);
+}
+
+void blk_delay_tracker_destroy(BlockDelayTracker *bdt)
+{
+    timer_free(bdt->timer);
+    qemu_mutex_destroy(&bdt->lock);
+    assert(QTAILQ_EMPTY(&bdt->requests));
+    g_free(bdt);
+}
+
+void blk_set_delay_report_threshold(BlockBackend *blk, uint64_t ns)
+{
+    BlockDelayTracker *bdt = blk_delay_tracker(blk);
+
+    WITH_QEMU_LOCK_GUARD(&bdt->lock) {
+        bdt->threshold_ns[BLOCK_DELAY_REPORT] = ns;
+    }
+
+    /* Wake the timer immediately to adjust to the new threshold */
+    timer_mod(bdt->timer, 0);
+}
+
+void blk_set_delay_stop_threshold(BlockBackend *blk, uint64_t ns)
+{
+    BlockDelayTracker *bdt = blk_delay_tracker(blk);
+
+    WITH_QEMU_LOCK_GUARD(&bdt->lock) {
+        bdt->threshold_ns[BLOCK_DELAY_STOP] = ns;
+    }
+
+    /* Wake the timer immediately to adjust to the new threshold */
+    timer_mod(bdt->timer, 0);
+}
+
+void blk_track_delay_begin(BlockBackend *blk,
+                           BlockDelayTrackerRequest *request,
+                           int64_t offset,
+                           uint64_t bytes,
+                           IoAccountingOperation op_type)
+{
+    BlockDelayTracker *bdt = blk_delay_tracker(blk);
+
+    *request = (BlockDelayTrackerRequest) {
+        .offset = offset,
+        .bytes = bytes,
+        .op_type = op_type,
+    };
+
+    WITH_QEMU_LOCK_GUARD(&bdt->lock) {
+        if (!bdt->threshold_ns[BLOCK_DELAY_REPORT] &&
+            !bdt->threshold_ns[BLOCK_DELAY_STOP]) {
+            /* Must be so by 0-initialization of .list */
+            assert(!QTAILQ_IN_USE(request, list));
+            return;
+        }
+
+        /* Set this under the lock so `bdt->requests` is correctly ordered */
+        request->start_time_ns = qemu_clock_get_ns(bdt->clock_type);
+        QTAILQ_INSERT_TAIL(&bdt->requests, request, list);
+    }
+
+}
+
+void blk_track_delay_end(BlockBackend *blk,
+                         BlockDelayTrackerRequest *request,
+                         int ret)
+{
+    BlockDelayTracker *bdt = blk_delay_tracker(blk);
+    bool need_done_event = false;
+
+    if (!QTAILQ_IN_USE(request, list)) {
+        return;
+    }
+
+    WITH_QEMU_LOCK_GUARD(&bdt->lock) {
+        for (int i = 0; i < BLOCK_DELAY__MAX; i++) {
+            need_done_event |= request->threshold_exceeded[i];
+        }
+        QTAILQ_REMOVE(&bdt->requests, request, list);
+    }
+
+    /* `device_path` is set if and only if any `threshold_exceeded` are set */
+    assert(!!request->device_path == need_done_event);
+
+    if (need_done_event) {
+        DelayEvent *event = g_new(DelayEvent, 1);
+        uint64_t now = qemu_clock_get_ns(bdt->clock_type);
+
+        *event = (DelayEvent) {
+            .device_path = request->device_path,
+            .op_type = request->op_type,
+            .duration_ns = usub64_saturate(now, request->start_time_ns),
+            .ret = ret,
+            .has_offset = request->offset >= 0,
+            .offset = request->offset,
+            .bytes = request->bytes,
+        };
+
+        /*
+         * Emit the event in the main loop, where the timer runs, too, so we
+         * always emit BLOCK_IO_DONE after all corresponding BLOCK_IO_DELAY
+         * events.
+         */
+        aio_bh_schedule_oneshot(qemu_get_aio_context(), send_done_event, event);
+    }
+}
+
+/**
+ * Send a BLOCK_IO_DONE event from the `DelayEvent` given via `opaque`.
+ *
+ * This event, and the `device_path` in it, are freed via `g_free()`.
+ */
+static void send_done_event(void *opaque)
+{
+    DelayEvent *event = opaque;
+
+    qapi_event_send_block_io_done(event->device_path,
+                                  event->op_type,
+                                  event->duration_ns,
+                                  event->has_offset, event->offset,
+                                  event->bytes,
+                                  event->ret < 0);
+    g_free(event->device_path);
+    g_free(event);
+}
+
+/**
+ * Track and periodically check for stalled requests.
+ *
+ * @opaque is the `BlockBackend`.
+ *
+ * Emits events when requests take longer than the BLOCK_DELAY_REPORT
+ * threshold, and stops the VM if one takes longer than the BLOCK_DELAY_STOP
+ * threshold.
+ *
+ * Handles spurious wakes.
+ */
+static void delay_track_timer(void *opaque)
+{
+    BlockBackend *blk = opaque;
+    BlockDelayTracker *bdt = blk_delay_tracker(blk);
+    g_autofree char *dev_path = NULL;
+    bool stop_vm = false;
+    uint64_t now;
+    /* When to wake up next */
+    uint64_t timer_time = INT64_MAX;
+    /* List of events to emit */
+    QTAILQ_HEAD(, DelayEvent) delay_events =
+        QTAILQ_HEAD_INITIALIZER(delay_events);
+
+    WITH_QEMU_LOCK_GUARD(&bdt->lock) {
+        now = qemu_clock_get_ns(bdt->clock_type);
+
+        for (int i = 0; i < BLOCK_DELAY__MAX; i++) {
+            BlockDelayTrackerRequest *request;
+            uint64_t threshold_ns = bdt->threshold_ns[i];
+
+            if (!threshold_ns) {
+                continue;
+            }
+
+            /*
+             * Sleep at most for the duration of this threshold, so that we
+             * will regularly check new requests as they come in.
+             */
+            timer_time = MIN(timer_time, uadd64_saturate(now, threshold_ns));
+
+            QTAILQ_FOREACH(request, &bdt->requests, list) {
+                DelayEvent *evt;
+                char *req_dev_path;
+                uint64_t duration_ns;
+
+                /*
+                 * New requests are entered at the end of the list, so it
+                 * is always sorted by start_time_ns (ascending).  We can
+                 * stop iterating on the first request that is not yet older
+                 * than the delay threshold.
+                 */
+                duration_ns = usub64_saturate(now, request->start_time_ns);
+                if (duration_ns < threshold_ns) {
+                    /*
+                     * Ensure waking when we need to emit a delay event for
+                     * this request, the one closest to the delay threshold.
+                     */
+                    timer_time = MIN(timer_time,
+                                     uadd64_saturate(request->start_time_ns,
+                                                     threshold_ns));
+                    break;
+                }
+
+                /* Only emit a delay event once */
+                if (request->threshold_exceeded[i]) {
+                    continue;
+                }
+
+                /*
+                 * Always use the same device path for a single request, so use
+                 * the cached path if it exists already.  Otherwise, use the
+                 * current device path.
+                 */
+                req_dev_path = request->device_path ?: dev_path;
+                if (!req_dev_path) {
+                    assert(!request->device_path && !dev_path);
+
+                    /*
+                     * Fine to call under `BlockDelayTracker.lock` because this
+                     * will not take a lock itself.
+                     * The alternative would be to either call it before the
+                     * lock (not yet knowing if there will be delayed requests),
+                     * or call it after, at which point `request` may no longer
+                     * be alive, which would disallow putting the result into
+                     * `request`. We want to put it into `request`, though, so
+                     * the `BLOCK_IO_DONE` event will always emit the same path
+                     * as the `BLOCK_IO_DELAY` event(s) before.
+                     * So, in order to call `blk_get_attached_dev_path()` only
+                     * when needed and to make `request->device_path` work as a
+                     * per-request cache, we have to call it under the lock.
+                     */
+                    req_dev_path = dev_path = blk_get_attached_dev_path(blk);
+                }
+
+                evt = g_new(DelayEvent, 1);
+                *evt = (DelayEvent) {
+                    .device_path = g_strdup(req_dev_path),
+                    .op_type = request->op_type,
+                    .duration_ns = duration_ns,
+                    .action = i == BLOCK_DELAY_REPORT
+                        ? BLOCK_ERROR_ACTION_REPORT
+                        : BLOCK_ERROR_ACTION_STOP,
+                    .has_offset = request->offset >= 0,
+                    .offset = request->offset,
+                    .bytes = request->bytes,
+                };
+                QTAILQ_INSERT_TAIL(&delay_events, evt, next);
+
+                /* For BLOCK_IO_DONE */
+                if (!request->device_path) {
+                    request->device_path = g_strdup(req_dev_path);
+                }
+                request->threshold_exceeded[i] = true;
+
+                if (i == BLOCK_DELAY_STOP) {
+                    stop_vm = true;
+                }
+            }
+        }
+    }
+
+    if (stop_vm) {
+        qemu_system_vmstop_request_prepare();
+    }
+    while (!QTAILQ_EMPTY(&delay_events)) {
+        DelayEvent *evt = QTAILQ_FIRST(&delay_events);
+        QTAILQ_REMOVE(&delay_events, evt, next);
+
+        qapi_event_send_block_io_delay(evt->device_path, evt->op_type,
+                                       evt->duration_ns, evt->action,
+                                       evt->has_offset, evt->offset,
+                                       evt->bytes);
+        g_free(evt->device_path);
+        g_free(evt);
+    }
+    if (stop_vm) {
+        qemu_system_vmstop_request(RUN_STATE_IO_HANG);
+    }
+
+    if (timer_time < INT64_MAX) {
+        timer_mod_ns(bdt->timer, timer_time);
+    }
+}
diff --git a/block/block-backend.c b/block/block-backend.c
index 78678986466..badc3986f9e 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "system/block-backend.h"
+#include "block/block-backend-delay.h"
 #include "block/block_int.h"
 #include "block/blockjob.h"
 #include "block/coroutines.h"
@@ -93,6 +94,8 @@ struct BlockBackend {
      * Accessed with atomic ops.
      */
     unsigned int in_flight;
+
+    BlockDelayTracker *delay_tracker;
 };
 
 typedef struct BlockBackendAIOCB {
@@ -377,6 +380,9 @@ BlockBackend *blk_new(AioContext *ctx, uint64_t perm, uint64_t shared_perm)
     notifier_list_init(&blk->insert_bs_notifiers);
     QLIST_INIT(&blk->aio_notifiers);
 
+    blk->delay_tracker = g_new0(BlockDelayTracker, 1);
+    blk_delay_tracker_init(blk);
+
     QTAILQ_INSERT_TAIL(&block_backends, blk, link);
     return blk;
 }
@@ -481,6 +487,9 @@ static void blk_delete(BlockBackend *blk)
     assert(!blk->refcnt);
     assert(!blk->name);
     assert(!blk->dev);
+
+    blk_delay_tracker_destroy(blk->delay_tracker);
+
     if (blk->public.throttle_group_member.throttle_state) {
         blk_io_limits_disable(blk);
     }
@@ -764,6 +773,12 @@ BlockDriverState *blk_bs(BlockBackend *blk)
     return blk->root ? blk->root->bs : NULL;
 }
 
+BlockDelayTracker *blk_delay_tracker(BlockBackend *blk)
+{
+    IO_OR_GS_CODE();
+    return blk->delay_tracker;
+}
+
 static BlockBackend * GRAPH_RDLOCK bdrv_first_blk(BlockDriverState *bs)
 {
     BdrvChild *child;
@@ -1338,6 +1353,7 @@ blk_co_do_preadv_part(BlockBackend *blk, int64_t offset, int64_t bytes,
     ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
     int ret;
     BlockDriverState *bs;
+    BlockDelayTrackerRequest request;
     IO_CODE();
 
     blk_wait_while_drained(blk, flags);
@@ -1353,6 +1369,8 @@ blk_co_do_preadv_part(BlockBackend *blk, int64_t offset, int64_t bytes,
     }
 
     bdrv_inc_in_flight(bs);
+    blk_track_delay_begin(blk, &request, offset, bytes,
+                          IO_ACCOUNTING_OPERATION_READ);
 
     /* throttling disk I/O */
     if (qatomic_load_acquire(&tgm->throttle_state)) {
@@ -1361,6 +1379,7 @@ blk_co_do_preadv_part(BlockBackend *blk, int64_t offset, int64_t bytes,
 
     ret = bdrv_co_preadv_part(blk->root, offset, bytes, qiov, qiov_offset,
                               flags);
+    blk_track_delay_end(blk, &request, ret);
     bdrv_dec_in_flight(bs);
     return ret;
 }
@@ -1413,6 +1432,7 @@ blk_co_do_pwritev_part(BlockBackend *blk, int64_t offset, int64_t bytes,
     ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
     int ret;
     BlockDriverState *bs;
+    BlockDelayTrackerRequest request;
     IO_CODE();
 
     blk_wait_while_drained(blk, flags);
@@ -1428,6 +1448,8 @@ blk_co_do_pwritev_part(BlockBackend *blk, int64_t offset, int64_t bytes,
     }
 
     bdrv_inc_in_flight(bs);
+    blk_track_delay_begin(blk, &request, offset, bytes,
+                          IO_ACCOUNTING_OPERATION_WRITE);
     /* throttling disk I/O */
     if (qatomic_load_acquire(&tgm->throttle_state)) {
         throttle_group_co_io_limits_intercept(tgm, bytes, THROTTLE_WRITE);
@@ -1439,6 +1461,7 @@ blk_co_do_pwritev_part(BlockBackend *blk, int64_t offset, int64_t bytes,
 
     ret = bdrv_co_pwritev_part(blk->root, offset, bytes, qiov, qiov_offset,
                                flags);
+    blk_track_delay_end(blk, &request, ret);
     bdrv_dec_in_flight(bs);
     return ret;
 }
@@ -1803,6 +1826,7 @@ static int coroutine_fn
 blk_co_do_pdiscard(BlockBackend *blk, int64_t offset, int64_t bytes,
                    BdrvRequestFlags flags)
 {
+    BlockDelayTrackerRequest request;
     int ret;
     IO_CODE();
 
@@ -1814,7 +1838,12 @@ blk_co_do_pdiscard(BlockBackend *blk, int64_t offset, int64_t bytes,
         return ret;
     }
 
-    return bdrv_co_pdiscard(blk->root, offset, bytes);
+    blk_track_delay_begin(blk, &request, offset, bytes,
+                          IO_ACCOUNTING_OPERATION_UNMAP);
+    ret = bdrv_co_pdiscard(blk->root, offset, bytes);
+    blk_track_delay_end(blk, &request, ret);
+
+    return ret;
 }
 
 static void coroutine_fn blk_aio_pdiscard_entry(void *opaque)
@@ -1851,6 +1880,8 @@ int coroutine_fn blk_co_pdiscard(BlockBackend *blk, int64_t offset,
 /* To be called between exactly one pair of blk_inc/dec_in_flight() */
 static int coroutine_fn blk_co_do_flush(BlockBackend *blk)
 {
+    BlockDelayTrackerRequest request;
+    int ret;
     IO_CODE();
     blk_wait_while_drained(blk, 0);
     GRAPH_RDLOCK_GUARD();
@@ -1859,7 +1890,12 @@ static int coroutine_fn blk_co_do_flush(BlockBackend *blk)
         return -ENOMEDIUM;
     }
 
-    return bdrv_co_flush(blk_bs(blk));
+    blk_track_delay_begin(blk, &request, -1, 0,
+                          IO_ACCOUNTING_OPERATION_FLUSH);
+    ret = bdrv_co_flush(blk_bs(blk));
+    blk_track_delay_end(blk, &request, ret);
+
+    return ret;
 }
 
 static void coroutine_fn blk_aio_flush_entry(void *opaque)
@@ -2072,6 +2108,7 @@ int coroutine_fn blk_co_zone_mgmt(BlockBackend *blk, BlockZoneOp op,
 int coroutine_fn blk_co_zone_append(BlockBackend *blk, int64_t *offset,
         QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
+    BlockDelayTrackerRequest request;
     int ret;
     IO_CODE();
 
@@ -2083,7 +2120,10 @@ int coroutine_fn blk_co_zone_append(BlockBackend *blk, int64_t *offset,
         return -ENOMEDIUM;
     }
 
+    blk_track_delay_begin(blk, &request, *offset, qiov->size,
+                          IO_ACCOUNTING_OPERATION_ZONE_APPEND);
     ret = bdrv_co_zone_append(blk_bs(blk), offset, qiov, flags);
+    blk_track_delay_end(blk, &request, ret);
     blk_dec_in_flight(blk);
     return ret;
 }
diff --git a/block/meson.build b/block/meson.build
index bc419aebf08..f758c82f3c9 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -8,6 +8,7 @@ block_ss.add(files(
   'blklogwrites.c',
   'blkverify.c',
   'block-backend.c',
+  'block-backend-delay.c',
   'block-copy.c',
   'commit.c',
   'copy-before-write.c',
-- 
2.55.0


