Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C871EC88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6VbJ-0007li-C8; Tue, 15 Sep 2026 12:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6VbG-0007in-C0
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:38 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6VbD-0003Pz-Vg
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:38 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f9f7dbeso81515766b.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789488084; x=1790092884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s87rPVbRxcHD+WW42I4Y9cf1mEIYsz0a2YMHIlkLiHI=;
 b=dy/UH7RSrqITRhsgLuL03A2zLuaLg0yVOBWTKgxiz85VX2TqeDkiBvJNepWKQAFeUn
 /yvFV/0Z1q6ZzS8FGE6m0DlTZNHFi4VpIWU5ft8TB72ZcTrMNdJIrS1clBEyIc3Mh2Lj
 ZdHGngZ8YmxQbXFdhjm5ZUBK96gCP3w60m+Lu0/6oor8c0HhQ4j3QEML9YvFnnGsYv+z
 rgYMItygPS5gBpJRnQVZ1whiSIfcDs4I9ZZAigYS+UU0wSohf+PuN9TLIDHc/Oe5/6GM
 Nb2sKBIL8J3xT2LVilP0CRjByOfNxNQRd6nRWvSWQvvkoA+VlCn/vsY/UKYzYRiSXAVs
 CO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789488084; x=1790092884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s87rPVbRxcHD+WW42I4Y9cf1mEIYsz0a2YMHIlkLiHI=;
 b=ZOoeV2skB063wOGMEa/QBf/kBl4dOvvXFWaZeY1MJKBvJmQ34hL+kAeFe6f2Mj285i
 kf7lQQUBlGuZW0TIX0ti76nK6CZnmdF89Chsd/ezS3B6/omi5vlfygEGZR28+ymt3rVp
 Mvg2hOT554AFW+NlLQ7OiK24Qwy2KXF9l1WaZtbqVOp6ZunBS3VqqMu++NYPFYR8yrsA
 smbqp8p2v9Q68Xtx8mX4PWORjejJwDAMZ3NrMfInKKr4yHB6+vktTe7uQGa2OkqVvtmk
 120hSmC2W24YqyKLES+Bes2/uFEtFcg+tO8oyreoMJe+Q7V0O3wqt3Mgft8VRMEcq4Yp
 HSEQ==
X-Gm-Message-State: AFuF++nOB85ppT7RyjyqIMjd6VAbfZFX/qsq3Sjkvheh3NYd13h2EYZU
 L+UdHYyK8NMywDeJhzCAFt8n5b43RXU3+V3d3D4KF6qHmmk7vZrGq0BvF46prQ==
X-Gm-Gg: AYBFou3WCL8bDwoF1DjPI/tiGUqpGwNWY5iBjpGIyJg4fnFwH+/4M/DnKQFF2zq9HYX
 uWMhxPRurvrlZCf8/Pf9HTmwuSr4hYmirw9DCN9y7iHiViFwT18G+AJT4ZwcRYpf2oPjq9oQF83
 BxClEIckVJLO2aPooHsZC0bLrMpYtUIqifxCqUVqX+3O58r1jgPswpts57LW0b16O94ux3e66mz
 D8x1xHxxseyAmkvYYwnDVYLZfB1gykgV2hDGoTNnFKSR3Pasdwth8Wc/67cYF0ZXYLAyFozKzKN
 cZKhUs08+taRt+LD/vT7UbYvXs1fFX7AcUu+p/iv/e85SOjsy2r+FA6+8i2lz59Er1w8zy/OlVY
 enI5Q2OeYWjjsvsGJVSko3tCITWFTjYFbIUk8U0/cco6rvNcb6nfZEqlTdvPSfHBKEbtKLHwrBE
 //QwSVQKN6OSCuSBpHaWsbfVCsxAW855bnOak5nJ4xtaqncwyewNWOAHn+M8cPxhBlwvPn+vZ/7
 mCRGYH6X/Mzz4AlhG2xUJuJ/IlSx2ZaAtrZaRwVT38Uuw==
X-Received: by 2002:a17:907:724a:b0:c15:f26a:3438 with SMTP id
 a640c23a62f3a-c29d78ec66bmr133940666b.24.1789488084070; 
 Tue, 15 Sep 2026 09:01:24 -0700 (PDT)
Received: from thinkpad-t470s.. (83-131-196-251.adsl.net.t-com.hr.
 [83.131.196.251]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-c29ddd86344sm3235866b.0.2026.09.15.09.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:01:23 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com,
 edgar.iglesias@gmail.com, berrange@redhat.com, eugene@nuvacore.ai,
 Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v2 07/20] hw/core: Add Remote Port protocol thread and
 handshake
Date: Tue, 15 Sep 2026 18:00:31 +0200
Message-ID: <20260915160044.345788-8-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915160044.345788-1-ruslichenko.r@gmail.com>
References: <20260915160044.345788-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:34::10;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej2-x10.google.com
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Introduce main execution loop for the Remote Port protocol.
Creates a dedicated thread to manage the communication lifecycle.
This includes logic to read packets and manage RX queue.

Patch also implements handshake logic to verify protocol
versions and negotiate capabilities with remote peer.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port.c         | 307 +++++++++++++++++++++++++++++++++-
 hw/core/trace-events          |   5 +
 include/hw/core/remote-port.h |  29 ++++
 3 files changed, 340 insertions(+), 1 deletion(-)

diff --git a/hw/core/remote-port.c b/hw/core/remote-port.c
index 6b40dca52d..89f799493c 100644
--- a/hw/core/remote-port.c
+++ b/hw/core/remote-port.c
@@ -25,6 +25,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "qemu/cutils.h"
+#include "trace.h"
 
 #include "hw/core/remote-port-proto.h"
 #include "hw/core/remote-port.h"
@@ -32,6 +33,286 @@
 #define REMOTE_PORT_CLASS(klass)    \
      OBJECT_CLASS_CHECK(RemotePortClass, (klass), TYPE_REMOTE_PORT)
 
+static void rp_event_read_and_process(RemotePort *s);
+
+static void rp_fatal_error(RemotePort *s, const char *reason)
+{
+    error_report("%s: %s", s->prefix, reason);
+    exit(EXIT_FAILURE);
+}
+
+static ssize_t rp_recv(RemotePort *s, void *buf, size_t count)
+{
+    ssize_t r;
+
+    r = qemu_chr_fe_read_all(&s->chr, buf, count);
+    if (r <= 0) {
+        return r;
+    }
+    if (r != count) {
+        error_report("%s: Bad read, expected %zd but got %zd",
+                     s->prefix, count, r);
+        rp_fatal_error(s, "Bad read");
+    }
+
+    return r;
+}
+
+ssize_t rp_write(RemotePort *s, const void *buf, size_t count)
+{
+    ssize_t r;
+
+    qemu_mutex_lock(&s->write_mutex);
+    r = qemu_chr_fe_write_all(&s->chr, buf, count);
+    qemu_mutex_unlock(&s->write_mutex);
+    assert(r == count);
+    if (r <= 0) {
+        error_report("%s: Disconnected r=%zd buf=%p count=%zd",
+                     s->prefix, r, buf, count);
+        rp_fatal_error(s, "Bad write");
+    }
+    return r;
+}
+
+static unsigned int rp_has_work(RemotePort *s)
+{
+    unsigned int work = s->rx_queue.wpos - s->rx_queue.rpos;
+    return work;
+}
+
+static void rp_cmd_hello(RemotePort *s, struct rp_pkt *pkt)
+{
+    s->peer.version = pkt->hello.version;
+    if (pkt->hello.version.major != RP_VERSION_MAJOR) {
+        error_report("remote-port version missmatch remote=%d.%d local=%d.%d",
+                      pkt->hello.version.major, pkt->hello.version.minor,
+                      RP_VERSION_MAJOR, RP_VERSION_MINOR);
+        rp_fatal_error(s, "Bad version");
+    }
+
+    if (pkt->hello.caps.len) {
+        void *caps = (char *) pkt + pkt->hello.caps.offset;
+
+        rp_process_caps(&s->peer, caps, pkt->hello.caps.len);
+    }
+}
+
+static void rp_say_hello(RemotePort *s)
+{
+    struct rp_pkt_hello pkt;
+    uint32_t caps[] = {
+        CAP_BUSACCESS_EXT_BASE,
+        CAP_BUSACCESS_EXT_BYTE_EN,
+        CAP_WIRE_POSTED_UPDATES,
+        CAP_ATS,
+    };
+    size_t len;
+
+    len = rp_encode_hello_caps(s->current_id++, 0, &pkt, RP_VERSION_MAJOR,
+                               RP_VERSION_MINOR,
+                               caps, caps, sizeof caps / sizeof caps[0]);
+    rp_write(s, (void *) &pkt, len);
+
+    if (sizeof caps) {
+        rp_write(s, caps, sizeof caps);
+    }
+}
+
+void rp_process(RemotePort *s)
+{
+    while (true) {
+        struct rp_pkt *pkt;
+        unsigned int rpos;
+        bool actioned = false;
+        RemotePortDevice *dev;
+        RemotePortDeviceClass *rpdc;
+
+        qemu_mutex_lock(&s->rsp_mutex);
+        if (!rp_has_work(s)) {
+            qemu_mutex_unlock(&s->rsp_mutex);
+            break;
+        }
+        rpos = s->rx_queue.rpos;
+
+        pkt = s->rx_queue.pkt[rpos].pkt;
+        trace_rp_process(s->prefix, s->rx_queue.rpos, s->rx_queue.wpos,
+                         pkt->hdr.cmd, pkt->hdr.dev);
+
+        /*
+         * To handle recursiveness, we need to advance the index
+         * index before processing the packet.
+         */
+        s->rx_queue.rpos++;
+        s->rx_queue.rpos %= ARRAY_SIZE(s->rx_queue.pkt);
+        qemu_mutex_unlock(&s->rsp_mutex);
+
+        dev = s->devs[pkt->hdr.dev];
+        if (dev) {
+            rpdc = REMOTE_PORT_DEVICE_GET_CLASS(dev);
+            if (rpdc->ops[pkt->hdr.cmd]) {
+                rpdc->ops[pkt->hdr.cmd](dev, pkt);
+                actioned = true;
+            }
+        }
+
+        switch (pkt->hdr.cmd) {
+        /* TBD */
+        default:
+            assert(actioned);
+        }
+
+        s->rx_queue.inuse[rpos] = false;
+        qemu_sem_post(&s->rx_queue.sem);
+    }
+}
+
+static void rp_event_read_and_process(RemotePort *s)
+{
+    event_notifier_test_and_clear(&s->event_notifier);
+
+    rp_process(s);
+}
+
+static void rp_event_read_cb(EventNotifier *n)
+{
+    RemotePort *s = container_of(n, RemotePort, event_notifier);
+
+    rp_event_read_and_process(s);
+}
+
+static void rp_event_notify(RemotePort *s)
+{
+    event_notifier_set(&s->event_notifier);
+}
+
+/* Handover a pkt to CPU or IO-thread context.  */
+static void rp_pt_handover_pkt(RemotePort *s, RemotePortDynPkt *dpkt)
+{
+    bool full;
+
+    /*
+     * Take the rsp lock around the wpos update, otherwise
+     * rp_wait_resp will race with us.
+     */
+    qemu_mutex_lock(&s->rsp_mutex);
+    s->rx_queue.wpos++;
+    s->rx_queue.wpos %= ARRAY_SIZE(s->rx_queue.pkt);
+    /*
+     * Ensure rx_queue index update is visible to consumer
+     * before signaling event, to prevent lost wakeup
+     */
+    smp_mb();
+    rp_event_notify(s);
+    qemu_cond_signal(&s->progress_cond);
+    qemu_mutex_unlock(&s->rsp_mutex);
+
+    do {
+        full = s->rx_queue.inuse[s->rx_queue.wpos];
+        if (full) {
+            trace_rp_pt_rx_queue_full(s->prefix, s->rx_queue.rpos,
+                                      s->rx_queue.wpos);
+            qemu_sem_timedwait(&s->rx_queue.sem, 2 * 1000);
+        }
+    } while (full);
+}
+
+static bool rp_pt_process_pkt(RemotePort *s, RemotePortDynPkt *dpkt)
+{
+    struct rp_pkt *pkt = dpkt->pkt;
+
+    trace_rp_pt_process_pkt(s->prefix, pkt->hdr.cmd, pkt->hdr.id, pkt->hdr.dev);
+
+    if (pkt->hdr.dev >= ARRAY_SIZE(s->devs)) {
+        /* FIXME: Respond with an error.  */
+        return true;
+    }
+
+    switch (pkt->hdr.cmd) {
+    case RP_CMD_hello:
+        rp_cmd_hello(s, pkt);
+        break;
+    case RP_CMD_read:
+    case RP_CMD_write:
+    case RP_CMD_interrupt:
+    case RP_CMD_ats_req:
+    case RP_CMD_ats_inv:
+        rp_pt_handover_pkt(s, dpkt);
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+    return false;
+}
+
+static int rp_read_pkt(RemotePort *s, RemotePortDynPkt *dpkt)
+{
+    struct rp_pkt *pkt = dpkt->pkt;
+    int used;
+    int r;
+
+    r = rp_recv(s, pkt, sizeof pkt->hdr);
+    if (r <= 0) {
+        return r;
+    }
+    used = rp_decode_hdr((void *) &pkt->hdr);
+    assert(used == sizeof pkt->hdr);
+
+    if (pkt->hdr.len) {
+        rp_dpkt_alloc(dpkt, sizeof pkt->hdr + pkt->hdr.len);
+        /* pkt may move due to realloc.  */
+        pkt = dpkt->pkt;
+        r = rp_recv(s, &pkt->hdr + 1, pkt->hdr.len);
+        if (r <= 0) {
+            return r;
+        }
+        rp_decode_payload(pkt);
+    }
+
+    return used + r;
+}
+
+static void *rp_protocol_thread(void *arg)
+{
+    RemotePort *s = REMOTE_PORT(arg);
+    unsigned int i;
+    int r;
+
+    /* Make sure we have a decent bufsize to start with.  */
+    rp_dpkt_alloc(&s->rsp, sizeof s->rsp.pkt->busaccess + 1024);
+    for (i = 0; i < ARRAY_SIZE(s->rx_queue.pkt); i++) {
+        rp_dpkt_alloc(&s->rx_queue.pkt[i],
+                      sizeof s->rx_queue.pkt[i].pkt->busaccess + 1024);
+        s->rx_queue.inuse[i] = false;
+    }
+
+    rp_say_hello(s);
+
+    while (1) {
+        RemotePortDynPkt *dpkt;
+        unsigned int wpos = s->rx_queue.wpos;
+        bool handled;
+
+        dpkt = &s->rx_queue.pkt[wpos];
+        s->rx_queue.inuse[wpos] = true;
+
+        r = rp_read_pkt(s, dpkt);
+        if (r <= 0) {
+            /* Disconnected.  */
+            break;
+        }
+        handled = rp_pt_process_pkt(s, dpkt);
+        if (handled) {
+            s->rx_queue.inuse[wpos] = false;
+        }
+    }
+
+    if (!s->finalizing) {
+        rp_fatal_error(s, "Disconnected");
+    }
+    return NULL;
+}
+
 static void rp_reset(DeviceState *dev)
 {
     RemotePort *s = REMOTE_PORT(dev);
@@ -40,6 +321,9 @@ static void rp_reset(DeviceState *dev)
         return;
     }
 
+    qemu_thread_create(&s->thread, "remote-port", rp_protocol_thread, s,
+                       QEMU_THREAD_JOINABLE);
+
     s->reset_done = true;
 }
 
@@ -48,6 +332,10 @@ static void rp_realize(DeviceState *dev, Error **errp)
     RemotePort *s = REMOTE_PORT(dev);
     Chardev *chr = NULL;
 
+    qemu_mutex_init(&s->write_mutex);
+    qemu_mutex_init(&s->rsp_mutex);
+    qemu_cond_init(&s->progress_cond);
+
     s->prefix = object_get_canonical_path(OBJECT(dev));
 
     if (s->chrdev_id) {
@@ -65,7 +353,18 @@ static void rp_realize(DeviceState *dev, Error **errp)
 
     s->chrdev = chr;
 
+    if (event_notifier_init(&s->event_notifier, 0) < 0) {
+        error_setg(errp,
+                   "Unable to initialize event notifier for remote port");
+        return;
+    }
 
+    aio_set_event_notifier(qemu_get_aio_context(), &s->event_notifier,
+                           rp_event_read_cb,
+                           NULL, NULL);
+
+
+    qemu_sem_init(&s->rx_queue.sem, ARRAY_SIZE(s->rx_queue.pkt) - 1);
 }
 
 static void rp_unrealize(DeviceState *dev)
@@ -74,11 +373,17 @@ static void rp_unrealize(DeviceState *dev)
 
     s->finalizing = true;
 
+    aio_set_event_notifier(qemu_get_aio_context(), &s->event_notifier,
+                            NULL, NULL, NULL);
+
     info_report("%s: Wait for remote-port to disconnect", s->prefix);
     qemu_chr_fe_disconnect(&s->chr);
+    if (s->reset_done) {
+        qemu_thread_join(&s->thread);
+    }
     qemu_chr_fe_deinit(&s->chr, false);
 
-    object_unparent(OBJECT(s->chrdev));
+    event_notifier_cleanup(&s->event_notifier);
 }
 
 static const VMStateDescription vmstate_rp = {
diff --git a/hw/core/trace-events b/hw/core/trace-events
index 2cf085ac66..612d5730b9 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -32,3 +32,8 @@ clock_set_mul_div(const char *clk, uint32_t oldmul, uint32_t mul, uint32_t olddi
 
 # cpu-common.c
 cpu_reset(int cpu_index) "%d"
+
+# remote-port.c
+rp_pt_process_pkt(const char *rp, uint32_t cmd, uint32_t id, uint32_t dev) "%s: cmd=0x%"PRIx32" id=0x%"PRIx32" dev=0x%"PRIx32
+rp_process(const char *rp, unsigned int rpos, unsigned int wpos, uint32_t cmd, uint32_t dev) "%s: io-thread rpos=%u wpos=%u cmd=0x%"PRIx32" dev=0x%"PRIx32
+rp_pt_rx_queue_full(const char *rp, unsigned int rpos, unsigned int wpos) "%s: rpos=%u wpos=%u"
diff --git a/include/hw/core/remote-port.h b/include/hw/core/remote-port.h
index dde54a40d9..2d8a191bce 100644
--- a/include/hw/core/remote-port.h
+++ b/include/hw/core/remote-port.h
@@ -16,6 +16,7 @@
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
 #include "qobject/qdict.h"
+#include "qemu/event_notifier.h"
 
 #define TYPE_REMOTE_PORT_DEVICE "remote-port-device"
 
@@ -57,11 +58,35 @@ typedef struct RemotePortDeviceClass {
 struct RemotePort {
     DeviceState parent;
 
+    QemuThread thread;
+    EventNotifier event_notifier;
     Chardev *chrdev;
     CharFrontend chr;
     bool finalizing;
+    /* To serialize writes to fd.  */
+    QemuMutex write_mutex;
 
     char *chrdev_id;
+    struct rp_peer_state peer;
+
+    QemuMutex rsp_mutex;
+    QemuCond progress_cond;
+
+#define RX_QUEUE_SIZE 1024
+    struct {
+        /* This array must be sized minimum 2 and always a power of 2.  */
+        RemotePortDynPkt pkt[RX_QUEUE_SIZE];
+        bool inuse[RX_QUEUE_SIZE];
+        QemuSemaphore sem;
+        unsigned int wpos;
+        unsigned int rpos;
+    } rx_queue;
+
+    /*
+     * rsp holds responses for the remote side.
+     * Used by the slave.
+     */
+    RemotePortDynPkt rsp;
 
     const char *prefix;
     const char *remote_prefix;
@@ -73,4 +98,8 @@ struct RemotePort {
     RemotePortDevice *devs[REMOTE_PORT_MAX_DEVS];
 };
 
+void rp_process(RemotePort *s);
+
+ssize_t rp_write(RemotePort *s, const void *buf, size_t count);
+
 #endif
-- 
2.43.0


