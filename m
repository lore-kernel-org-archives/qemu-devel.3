Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0322EECD99C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 19:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5VJ-0006i2-5d; Thu, 05 Feb 2026 14:59:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VH-0006eV-Cl
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:03 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VF-00035x-Ip
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:03 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4362507f396so846559f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321539; x=1770926339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=df/wFs+q0Kaqn119+4MxF9ugWU2c1oPewnTOVYoyE5k=;
 b=DZAr8CVi8yZrUN7thYQlMAnwtgba8g+M/Ei8He6yI33I/wc7RAwmxFOVAH7iUMw9cb
 pl2KihRiyiOQtz/m4u4HnuTgQ+USrWUDZDgYsgsxYWTowxca6/Ii6/lKQIWuVUAyNE8Y
 ko6shiwvUkmXcD2BdQgTkrdNIcRXXXOGWytoZMhYitkoqye37b3IVskjOryZ0jrRTI99
 crxz/mqPcWvVSHERvM6a7J3QYPHS3TVO5kQY8nOewS+QOmagWpcQdJeGZCUVHTzxv/F1
 nzzSK5R7q6FJciXJJ3iWYoPMO8EVbZVVf+HXcPMn7wjWITBLAEQ+o7qWTCMG+EavFe7l
 3sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321539; x=1770926339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=df/wFs+q0Kaqn119+4MxF9ugWU2c1oPewnTOVYoyE5k=;
 b=EBWw8idFfYq+qDRAOih23Lsxsvfd4EJYBcAqzQ9FvEtXaCmOI1Hq4AxZY5azfaUGIK
 3GifAm42VweL8zLgO7xWZQo6iGCEJ8qnsYjbYXmwT6cJ/8LYmrKJpFmyMzFuOuBYZTPM
 nuDnxrk/fV4oMqzZDJ1/Mf7jJw2rFqGnTJH38yimg/JnPGUQ0RjbRbrzI1IyTlKUjFO5
 FB41nooPeSGaM2uaf04US7WjQG2/wUEOJMCAKV1TMnU3GXNFjedTE2dY8VcA5fwFfYJw
 fyY8CE8QhNPh4ZoY/YLz5Ov4XbZxsDY2jZIyaZK8GURpesuNa9tSurOyibHslZxMb6E/
 j9LA==
X-Gm-Message-State: AOJu0Ywv0tBSRG28mLlP0f+PvS1MbGiV/e0uHvpM2AvSiVHtzvWrLdxb
 BnPVlxQe5O+O3sq4Swvb28q4SFNhBzPLCzu7177M+0K9vQaxtP9UvpaCDGyO0vKKRB8=
X-Gm-Gg: AZuq6aIMX2+wg2joNehqU2IF2NdAdKGCPXCrTCE+GU/hOrDGqufpTn4Ne/StcpwjHUr
 E8HrriUCTWdtxSc4DLmow1GNNyo6jtcp+SSyPdImozzK3aB9mKUz/788zDLfJU4DHv5m7J4FPlA
 E9PdnJUyfcNUpXVzXMSiej/jmJdqmMi2kl0B6mK+dKTStEfzirHtMmwnnUupZCl4K2dnWE2Y3tQ
 Pp5q/7PlWUc9JKBLd/0sUf6pjOSwk5yd9Np63s9Oz+zvdFxwbBbP0bt5dqesNdmIa3LmcOsTjeN
 eV1oWymhuAzgiY+iKbIPVMd86tEY4hymeaedlz0xiiYIAuxzkFQOX69o3jbKYW4E1ORzf4iWM6I
 YdNNd83PAY9VG2KBsPsGf3m3MklWVDcLWGG22a1/7NKqE9Nc85ubDQrgfFtH7tql7JAmZN5B3ls
 Mo9DQu5LWCyWVlLbFtcyQ=
X-Received: by 2002:a5d:584c:0:b0:435:db9b:5883 with SMTP id
 ffacd0b85a97d-4362933a9b5mr679016f8f.2.1770321539186; 
 Thu, 05 Feb 2026 11:58:59 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:58:58 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH 11/29] hw/core: Implement Remote Port response handling
Date: Thu,  5 Feb 2026 20:58:06 +0100
Message-ID: <20260205195824.2610192-12-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add infrastructure to handle transaction responses from
remote peers.

This patch enables QEMU to wait for replies when it initiates
a memory access (Read/Write). It implements a mechanism to track
outstanding transaction IDs and block the execution thread until
the patching response is received.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port.c         | 136 +++++++++++++++++++++++++++++++++-
 include/hw/core/remote-port.h |  29 ++++++++
 2 files changed, 163 insertions(+), 2 deletions(-)

diff --git a/hw/core/remote-port.c b/hw/core/remote-port.c
index e44d9249c3..00c9529348 100644
--- a/hw/core/remote-port.c
+++ b/hw/core/remote-port.c
@@ -59,6 +59,16 @@ static void rp_pkt_dump(const char *prefix, const char *buf, size_t len)
     qemu_hexdump(stdout, prefix, buf, len);
 }
 
+void rp_rsp_mutex_lock(RemotePort *s)
+{
+    qemu_mutex_lock(&s->rsp_mutex);
+}
+
+void rp_rsp_mutex_unlock(RemotePort *s)
+{
+    qemu_mutex_unlock(&s->rsp_mutex);
+}
+
 static void rp_fatal_error(RemotePort *s, const char *reason)
 {
     error_report("%s: %s", s->prefix, reason);
@@ -104,6 +114,80 @@ static unsigned int rp_has_work(RemotePort *s)
     return work;
 }
 
+/* Response handling.  */
+RemotePortRespSlot *rp_dev_timed_wait_resp(RemotePort *s, uint32_t dev,
+                                            uint32_t id, int timems)
+{
+    int i;
+
+    assert(s->devs[dev]);
+
+    /* Find a free slot.  */
+    for (i = 0; i < ARRAY_SIZE(s->dev_state[dev].rsp_queue); i++) {
+        if (s->dev_state[dev].rsp_queue[i].used == false) {
+            break;
+        }
+    }
+
+    if (i == ARRAY_SIZE(s->dev_state[dev].rsp_queue) ||
+        s->dev_state[dev].rsp_queue[i].used == true) {
+        error_report("Number of outstanding transactions exceeded! %d",
+                      RP_MAX_OUTSTANDING_TRANSACTIONS);
+        rp_fatal_error(s, "Internal error");
+    }
+
+    /* Got a slot, fill it in.  */
+    s->dev_state[dev].rsp_queue[i].id = id;
+    s->dev_state[dev].rsp_queue[i].valid = false;
+    s->dev_state[dev].rsp_queue[i].used = true;
+
+    while (!s->dev_state[dev].rsp_queue[i].valid) {
+        rp_rsp_mutex_unlock(s);
+        rp_event_read(s);
+        rp_rsp_mutex_lock(s);
+        if (s->dev_state[dev].rsp_queue[i].valid) {
+            break;
+        }
+        if (!rp_has_work(s)) {
+            if (timems) {
+                if (!qemu_cond_timedwait(&s->progress_cond, &s->rsp_mutex,
+                                       timems)) {
+                    /*
+                     * TimeOut!
+                     */
+                    break;
+                }
+            } else {
+                qemu_cond_wait(&s->progress_cond, &s->rsp_mutex);
+            }
+        }
+    }
+    return &s->dev_state[dev].rsp_queue[i];
+}
+
+RemotePortRespSlot *rp_dev_wait_resp(RemotePort *s, uint32_t dev, uint32_t id)
+{
+    return rp_dev_timed_wait_resp(s, dev, id, 0);
+}
+
+RemotePortDynPkt rp_wait_resp(RemotePort *s)
+{
+    while (!rp_dpkt_is_valid(&s->rspqueue)) {
+        rp_rsp_mutex_unlock(s);
+        rp_event_read(s);
+        rp_rsp_mutex_lock(s);
+        /* Need to recheck the condition with the rsp lock taken.  */
+        if (rp_dpkt_is_valid(&s->rspqueue)) {
+            break;
+        }
+        D(qemu_log("%s: wait for progress\n", __func__));
+        if (!rp_has_work(s)) {
+            qemu_cond_wait(&s->progress_cond, &s->rsp_mutex);
+        }
+    }
+    return s->rspqueue;
+}
+
 static void rp_cmd_hello(RemotePort *s, struct rp_pkt *pkt)
 {
     s->peer.version = pkt->hello.version;
@@ -328,14 +412,52 @@ static bool rp_pt_process_pkt(RemotePort *s, RemotePortDynPkt *dpkt)
 {
     struct rp_pkt *pkt = dpkt->pkt;
 
-    D(qemu_log("%s: cmd=%x id=%d dev=%d\n", __func__, pkt->hdr.cmd,
-             pkt->hdr.id, pkt->hdr.dev));
+    D(qemu_log("%s: cmd=%x id=%d dev=%d rsp=%d\n", __func__, pkt->hdr.cmd,
+             pkt->hdr.id, pkt->hdr.dev,
+             pkt->hdr.flags & RP_PKT_FLAGS_response));
 
     if (pkt->hdr.dev >= ARRAY_SIZE(s->devs)) {
         /* FIXME: Respond with an error.  */
         return true;
     }
 
+    if (pkt->hdr.flags & RP_PKT_FLAGS_response) {
+        uint32_t dev = pkt->hdr.dev;
+        uint32_t id = pkt->hdr.id;
+        int i;
+
+        if (pkt->hdr.flags & RP_PKT_FLAGS_posted) {
+            printf("Drop response for posted packets\n");
+            return true;
+        }
+
+        qemu_mutex_lock(&s->rsp_mutex);
+
+        /* Try to find a per-device slot first.  */
+        for (i = 0; i < ARRAY_SIZE(s->dev_state[dev].rsp_queue); i++) {
+            if (s->devs[dev] && s->dev_state[dev].rsp_queue[i].used == true
+                && s->dev_state[dev].rsp_queue[i].id == id) {
+                break;
+            }
+        }
+
+        if (i < ARRAY_SIZE(s->dev_state[dev].rsp_queue)) {
+            /* Found a per device one.  */
+            assert(s->dev_state[dev].rsp_queue[i].valid == false);
+
+            rp_dpkt_swap(&s->dev_state[dev].rsp_queue[i].rsp, dpkt);
+            s->dev_state[dev].rsp_queue[i].valid = true;
+
+            qemu_cond_signal(&s->progress_cond);
+        } else {
+            rp_dpkt_swap(&s->rspqueue, dpkt);
+            qemu_cond_signal(&s->progress_cond);
+        }
+
+        qemu_mutex_unlock(&s->rsp_mutex);
+        return true;
+    }
+
     switch (pkt->hdr.cmd) {
     case RP_CMD_hello:
         rp_cmd_hello(s, pkt);
@@ -389,6 +511,7 @@ static void *rp_protocol_thread(void *arg)
 
     /* Make sure we have a decent bufsize to start with.  */
     rp_dpkt_alloc(&s->rsp, sizeof s->rsp.pkt->busaccess + 1024);
+    rp_dpkt_alloc(&s->rspqueue, sizeof s->rspqueue.pkt->busaccess + 1024);
     for (i = 0; i < ARRAY_SIZE(s->rx_queue.pkt); i++) {
         rp_dpkt_alloc(&s->rx_queue.pkt[i],
                       sizeof s->rx_queue.pkt[i].pkt->busaccess + 1024);
@@ -614,6 +737,7 @@ static void rp_prop_allow_set_link(const Object *obj, const char *name,
 static void rp_init(Object *obj)
 {
     RemotePort *s = REMOTE_PORT(obj);
+    int t;
     int i;
 
     for (i = 0; i < REMOTE_PORT_MAX_DEVS; ++i) {
@@ -623,6 +747,14 @@ static void rp_init(Object *obj)
                              rp_prop_allow_set_link,
                              OBJ_PROP_LINK_STRONG);
         g_free(name);
+
+
+        for (t = 0; t < RP_MAX_OUTSTANDING_TRANSACTIONS; t++) {
+            s->dev_state[i].rsp_queue[t].used = false;
+            s->dev_state[i].rsp_queue[t].valid = false;
+            rp_dpkt_alloc(&s->dev_state[i].rsp_queue[t].rsp,
+               sizeof s->dev_state[i].rsp_queue[t].rsp.pkt->busaccess + 1024);
+        }
     }
 }
 
diff --git a/include/hw/core/remote-port.h b/include/hw/core/remote-port.h
index 21dfbe89cd..c1b21eb573 100644
--- a/include/hw/core/remote-port.h
+++ b/include/hw/core/remote-port.h
@@ -53,6 +53,13 @@ typedef struct RemotePortDeviceClass {
 #define TYPE_REMOTE_PORT "remote-port"
 #define REMOTE_PORT(obj) OBJECT_CHECK(RemotePort, (obj), TYPE_REMOTE_PORT)
 
+typedef struct RemotePortRespSlot {
+            RemotePortDynPkt rsp;
+            uint32_t id;
+            bool used;
+            bool valid;
+} RemotePortRespSlot;
+
 struct RemotePort {
     DeviceState parent;
 
@@ -93,6 +100,13 @@ struct RemotePort {
      */
     RemotePortDynPkt rsp;
 
+    /*
+     * rspqueue holds received responses from the remote side.
+     * Only one for the moment but it might grow.
+     * Used by the master.
+     */
+    RemotePortDynPkt rspqueue;
+
     const char *prefix;
     const char *remote_prefix;
 
@@ -100,9 +114,24 @@ struct RemotePort {
     bool reset_done;
 
 #define REMOTE_PORT_MAX_DEVS 1024
+#define RP_MAX_OUTSTANDING_TRANSACTIONS 32
+    struct {
+        RemotePortRespSlot rsp_queue[RP_MAX_OUTSTANDING_TRANSACTIONS];
+    } dev_state[REMOTE_PORT_MAX_DEVS];
+
     RemotePortDevice *devs[REMOTE_PORT_MAX_DEVS];
 };
 
+
+void rp_rsp_mutex_lock(RemotePort *s);
+void rp_rsp_mutex_unlock(RemotePort *s);
+
+RemotePortDynPkt rp_wait_resp(RemotePort *s);
+
+RemotePortRespSlot *rp_dev_wait_resp(RemotePort *s, uint32_t dev, uint32_t id);
+RemotePortRespSlot *rp_dev_timed_wait_resp(RemotePort *s, uint32_t dev,
+                                           uint32_t id, int timems);
+
 void rp_process(RemotePort *s);
 
 ssize_t rp_write(RemotePort *s, const void *buf, size_t count);
-- 
2.43.0


