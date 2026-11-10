Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CAA606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=hRR2Idcx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnOS-0003aE-FS; Tue, 10 Nov 2026 10:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnO0-00036j-NS
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:03:51 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnNy-0008UC-Ut
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:03:48 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so1449921f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1794323025; x=1794927825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wz5J7BtRm96GQteyQTuXbDxbX79LxGun+611Yug+ddc=;
 b=hRR2Idcxf9rNrobv/G18Sy8ohyelje/7Za2S15JJVhEFACRpj0tFP4n+yBaCh4hYJS
 J7ydibeyL4wYxzYi3WwAlnwx/3EktHT/1V1SLs4fFUUkDF/cnbRok1B7XnIca1eR+Xes
 sI8k8M/ScNIs8XOGI1BrA5fv+z0G7znRdf6bXwMmZwKzjozt4yGxt+JByqtEdGM+Vi/B
 HclU+sNTcesZflQt/Mw14YCxsORSuNmD8PiQ1KuDXUbqkUgx17XsquTTOelvzk8p73r8
 JZYOJ/EXBhYHJ8WKaK3sG11NoJcujzbJ0VZjkevBMCQGspdPzblX+IE4nVwxn9VxECsz
 ORyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794323025; x=1794927825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wz5J7BtRm96GQteyQTuXbDxbX79LxGun+611Yug+ddc=;
 b=gDJB4Yj2kjIBel/dW1vBtCxeBcUA6PvKQiJKYeaFEAzPSWMrBFiIWEbNx8HfAILgiO
 u9PzaJkgekjxHG8DfA57cJsdK0YSlH63EoNdFItb/TRx2ZFfAnxDfdz7LJgCjS2T0zo2
 43DAX5iO2IenoFotP+i95p8HLSxrfk+l9WffJyLjW/PO1WUL3rBTbdcNZsWJvGHhhWp+
 KmUe9uhTL6ZI4HHG/YjpfeS9BKTZHLOgAfhqQaZGb0j1e7ZnJ2MpeHOU+48V04CffLAi
 ubnzyeYmss4R1qFF5xdgSGCuifG/SNa0thoHqk85YlG4SF8rtLruy29RxpQ1sFORXv+i
 pyYQ==
X-Gm-Message-State: APuU4Z8cbvz0hakdW6dOf74GjRXMpczaf2qJFolZPBY134YeykpzGVHL
 70Akiki/hbYVhHMIG2d011WS17iwHJ3ScGjH6D0g1zGh9rVI93ZoK/pzqudWBbGC1gjgxnu/1DW
 QGOk57Pw=
X-Gm-Gg: AYBFou0wt5KR01qeEo7Rx930J3pSWWWTl8rYCBoZAz3G6nsFlfvmMsEEBIvxSP8X3j+
 7rD5gQp3VjRmnnPVr4CU+4dH0AwqH8CZOQgLMwlM/fHdypuyV4HY/otAIelHTxJU69FPGIjPZEE
 HH0ex44cMOShjlwe0MFX8vA4aq4dCSu7PMLVJTcHSwq7eYhJEf0Wcose58tRR0jOK8MTp4TIc57
 6JgWZAedITwZsqRVzb+MFxqfuzpyz4a9MIVXcC+pnWFN9kZLnOXQXfBUn0GVWIRIEa6t/xq4rWa
 C/F0x1uDEKjQcUiVpHYqjDzWbONb5lueZeVbO8rwXaRy9Pi0Xlv8ZtvLOJD59PFN8KQEXVozWKN
 TVyjGNs5qOaN3BWZjGmqgt2XxDVB6Abl+M14SBWdbYwWiSHpM7ym96XGH0e01APl7/SRcZnLni0
 5eHcy+y1GXP+Tx6w6XAnJJLzZJKgX2I0dlAW/ngS3HlSQfyDWxUzvs7qKcpYfqA2j+BuXnWac7n
 1oBFrbPR/QIMMoSZnL01wqipApYTGfIhH8yTE0Tz2kkN5yWsuv/AAeGsigVJP0WdxxD/RcvBaAO
 F4BhpQSLdvrVwb7TwduHLWbmPZdKV1TkICFIja5Ot+qdiYiFdUHOS+KYS0vk5hqkgULAZW+d
X-Received: by 2002:a05:6000:288f:b0:48e:5cd4:aa60 with SMTP id
 ffacd0b85a97d-49830206f10mr5873027f8f.42.1794323025027; 
 Tue, 10 Nov 2026 07:03:45 -0800 (PST)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c4e07sm5116931f8f.49.2026.11.10.07.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 07:03:44 -0800 (PST)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 jinpu.wang@cloud.ionos.com, yanfei.xu@bytedance.com,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH RESEND 03/13] migration/rdma: Add send-ring lifecycle (no
 consumer thread yet)
Date: Tue, 10 Nov 2026 16:02:37 +0100
Message-ID: <20261110150247.193208-4-dmitrii.omelchenko@cloud.ionos.com>
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

Introduce the producer side of the SPSC send ring: rdma_consumer_start
allocates the ring at registration setup, rdma_consumer_stop frees it at
cleanup, plus ring_push/ring_wake_consumer.  No thread runs yet and the
existing send path is unchanged.

Signed-off-by: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
---
 migration/rdma.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index e4ede950de..2d4807c6b8 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1214,6 +1214,9 @@ static void rdma_nbsent_inc(RDMAContext *rdma, uint64_t nb_sent);
 static void rdma_nbsent_full(RDMAContext *rdma);
 static void rdma_nbsent_zero(RDMAContext *rdma);
 
+static void rdma_consumer_start(RDMAContext *rdma);
+static void rdma_consumer_stop(RDMAContext *rdma);
+
 /*
  * Consult the connection manager to see a work request
  * (of any kind) has completed.
@@ -2108,6 +2111,9 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
 {
     Error *err = NULL;
 
+    /* Free the send ring before touching the QP. */
+    rdma_consumer_stop(rdma);
+
     if (rdma->cm_id && rdma->connected) {
         if ((rdma->errored ||
              migrate_get_current()->state == MIGRATION_STATUS_CANCELLING) &&
@@ -2753,6 +2759,91 @@ struct RDMASendRing {
     uint64_t idle_max_ns;        /* longest consumer wait on an empty ring */
 };
 
+static bool ring_full(RDMASendRing *r)
+{
+    return (r->head - qatomic_load_acquire(&r->tail)) >= RDMA_SEND_RING_SIZE;
+}
+
+/* Producer -> wake the consumer if it is idle on an empty ring. */
+static void ring_wake_consumer(RDMASendRing *r)
+{
+    smp_mb();   /* order the *_waiting load below vs the sleeper's store */
+    if (qatomic_read(&r->consumer_waiting)) {
+        qemu_mutex_lock(&r->wait_lock);
+        qemu_cond_signal(&r->not_empty);
+        qemu_mutex_unlock(&r->wait_lock);
+    }
+}
+
+static int ring_push(RDMAContext *rdma, const RDMACmd *cmd)
+{
+    RDMASendRing *r = rdma->send_ring;
+
+    assert(r);
+
+    if (ring_full(r)) {
+        qemu_mutex_lock(&r->wait_lock);
+        r->producer_waiting = true;
+        smp_mb();                       /* pair with ring_wake_producer() */
+        while (ring_full(r) && !r->abort) {
+            qemu_cond_wait(&r->not_full, &r->wait_lock);
+        }
+        r->producer_waiting = false;
+        qemu_mutex_unlock(&r->wait_lock);
+    }
+    if (qatomic_read(&r->abort)) {
+        return -1;
+    }
+    r->ring[r->head & RDMA_SEND_RING_MASK] = *cmd;
+    qatomic_store_release(&r->head, r->head + 1);   /* publish payload+slot */
+    ring_wake_consumer(r);
+    return 0;
+}
+
+/*
+ * Producer: allocate the send ring once (idempotent).  The consumer
+ * thread that drains it is created in a later change.
+ */
+static void rdma_consumer_start(RDMAContext *rdma)
+{
+    RDMASendRing *r;
+
+    if (rdma->consumer_started) {
+        return;
+    }
+    r = g_new0(RDMASendRing, 1);
+    qemu_mutex_init(&r->wait_lock);
+    qemu_cond_init(&r->not_full);
+    qemu_cond_init(&r->not_empty);
+    qemu_cond_init(&r->barrier_cv);
+    rdma->send_ring = r;
+    rdma->pend_block = -1;        /* no pending WRITE span yet */
+    /* Producer-only flag (migration thread + cleanup, never concurrent). */
+    rdma->consumer_started = true;
+}
+
+/* Producer: tear down the send ring. */
+static void rdma_consumer_stop(RDMAContext *rdma)
+{
+    RDMASendRing *r = rdma->send_ring;
+    RDMACmd cmd = { .type = RDMA_CMD_FINISH };
+
+    if (!rdma->consumer_started) {
+        return;
+    }
+    /* Ask the consumer to drain and exit; if it already aborted, just join. */
+    if (!qatomic_read(&r->abort)) {
+        ring_push(rdma, &cmd);
+    }
+    qemu_mutex_destroy(&r->wait_lock);
+    qemu_cond_destroy(&r->not_full);
+    qemu_cond_destroy(&r->not_empty);
+    qemu_cond_destroy(&r->barrier_cv);
+    g_free(r);
+    rdma->send_ring = NULL;
+    rdma->consumer_started = false;
+}
+
 static int qio_channel_rdma_set_blocking(QIOChannel *ioc,
                                          bool blocking,
                                          Error **errp)
@@ -3810,6 +3901,11 @@ int rdma_registration_stop(QEMUFile *f, uint64_t flags)
         goto err;
     }
 
+    if (flags == RAM_CONTROL_SETUP) {
+        /* Setup complete: allocate the send ring (consumer added later). */
+        rdma_consumer_start(rdma);
+    }
+
     return 0;
 err:
     rdma->errored = true;
-- 
2.39.5


