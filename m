Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05509606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=eqsUR1DD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnOS-0003aN-F7; Tue, 10 Nov 2026 10:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnNu-00031P-0v
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:03:44 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnNs-0008Th-5V
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:03:41 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so1434088f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1794323018; x=1794927818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7n7KffiX4lyWn2IhC/FC8rsBQpZk+UUSYGJmdl23KQo=;
 b=eqsUR1DD+u9DUVLTK7yJXlLpEiTFj1TH/iGPhqTNr2RSC7OtiXhxg8kvybKN1naqyL
 n3FKTUeACX9q28YuGgPaDQgtshLchFcSFbhaha/7qROOEK33CY/vdRMYhBtUmUbYHHd6
 wAXtVh+hFZ2vw/VCHbRvMV14xvNTGjPUGrZwewoXhXrbqf/dAJ7AxOJnbIE9j2ry0lbt
 PrHsGBqWsBZjP6Yl+Pf/OFqoSrIPCUc21n4rCPOYNJ6kYQpvnu0A1FEMOmu7oOdmA1C4
 3txy/aDusqU9aEMrNJJ/vDlPgF5GB+Ca3JldvS6Elz1JG9YImdZeFbaEi+SkCMqar8Nd
 0QeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794323018; x=1794927818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7n7KffiX4lyWn2IhC/FC8rsBQpZk+UUSYGJmdl23KQo=;
 b=WVltpT5xEUSwM2lS1+r2GJQvKJTDfnHSApjTrfKZSe7yOe8oIh6UZOn4cAOZ7hFk0d
 1GnigG9zOAG7iqShKQfU4fmky0TmSGjmLF9LSetNjeGyknivxjG8pSHbddUfYEZwBYWx
 RY7gURdkWstC5OPcNYnsD+lvGbn2sxyPM3WjvtWlD4D0PwWAbr312P6Zm12CmhcN8Mxo
 jwuDyA+G1laC7qJgkONzVK/kknlUVKJQYUl3GLceKPB9pzyW3ow0Ex3BhJ/2Vo/FlJzg
 FQu8njek4O+ZmtvI16jPGyB+xLUVRyT5kOBxHXYP5IP14f/qltBkzxKQSJdx06XlzObN
 jFqQ==
X-Gm-Message-State: APuU4Z+SPs7fGE6YyrRxuJAPb94Dw6wbMDf7rrOKdo5fILXZVERXFTa3
 1B4chv1202E+77u42NwixXC8xVUs925xIjrK5T5GMgWEpL4RFJZEcpdXrOTgeirMp4nq92DrI63
 np+vktvE=
X-Gm-Gg: AYBFou2wRn4C8j8zTaJAWLQiuU7HHLojGt7LZHpnGJWghxozBOGPj0XH14asmquYJ19
 jvb/1cYL6sm25qS7wsqzcn0ppedDZTt5wiXAHZEIdrYOlVm8WWYB2JGbDqWR1kbRplt3Ogfu0pj
 Ncy1mMtMcytdw9h7EMS9YCLuRsxbyK7+47Go1TP80sahiqzer/H8Pv+6JMdEUOcNJzab+HNy4Bv
 viYZslkCeNebiNDidy3KOOhHGdT1DxmcoN7lEgtrWQkhpJBqNdxplCQav007UB0srICvFB5rgY0
 SOQTYTP7Sk++4S5Gk3U6Wlx5qRG5lEh8XC9vch8ETk+o8m6LswfYojJ4luzDToKCJpk3AMhkjN9
 JH7inrBsXPSRyNQFw+aFmwt/wRZoAboaoey0YOooqF9FmoMDsMGqLtkpAYl2myNbGQLyDKjYH1O
 qWaq+MPj7Op8DpCC156OqANcTIzMP/eXkaZm7siTEq6HR4ReW3WdrXUqtaouejK9MAkeTuBAYHk
 Rr24SbW7K9qniQu3RObFzGFAGMwAjALYqEnI5bdvQuq10UBO79nWsDAJZDD27idzvvBuM/bHjpS
 A99tjiB6YeeiKnIGif+zRr50YuYuW9fymp0rfpI0NN7hsgQd+nyeRvVuQfEwDDGaxfptZO2105W
 TnEsRw/7B4yjx0dP7Nw==
X-Received: by 2002:a05:6000:1a8a:b0:492:9630:6a71 with SMTP id
 ffacd0b85a97d-4982c79917amr6854583f8f.1.1794323018625; 
 Tue, 10 Nov 2026 07:03:38 -0800 (PST)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c4e07sm5116931f8f.49.2026.11.10.07.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 07:03:37 -0800 (PST)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 jinpu.wang@cloud.ionos.com, yanfei.xu@bytedance.com,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH RESEND 01/13] migration/rdma: Add nb_sent send-queue-depth
 stats
Date: Tue, 10 Nov 2026 16:02:35 +0100
Message-ID: <20261110150247.193208-2-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110150247.193208-1-dmitrii.omelchenko@cloud.ionos.com>
References: <20261110150247.193208-1-dmitrii.omelchenko@cloud.ionos.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:20::42f;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wr1-x42f.google.com
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

Track whole-migration counters for the RDMA send queue: peak nb_sent
(max outstanding writes), the number of posts, how many posts hit a
full send queue, and how many times the queue drained to zero.  Reset
at RAM_CONTROL_SETUP and dumped at RAM_CONTROL_FINISH; migration-thread
only, no locking.

Signed-off-by: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
---
 migration/rdma.c       | 60 ++++++++++++++++++++++++++++++++++++++++++
 migration/trace-events |  1 +
 2 files changed, 61 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index 444123cbca..50f5d7b839 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -302,6 +302,12 @@ typedef struct RDMAContext {
     /* number of outstanding writes */
     int nb_sent;
 
+    /* nb_sent statistics */
+    uint64_t nbsent_max;            /* peak outstanding writes */
+    uint64_t nbsent_posts;          /* posts (nb_sent++) */
+    uint64_t nbsent_full_hits;      /* posts that hit a full SQ */
+    uint64_t nbsent_zero_hits;      /* drains to zero */
+
     /* store info about current buffer so that we can
        merge it with future sends */
     uint64_t current_addr;
@@ -1164,6 +1170,11 @@ static uint64_t qemu_rdma_make_wrid(uint64_t wr_id, uint64_t index,
     return result;
 }
 
+/* nb_sent statistics counters */
+static void rdma_nbsent_inc(RDMAContext *rdma, uint64_t nb_sent);
+static void rdma_nbsent_full(RDMAContext *rdma);
+static void rdma_nbsent_zero(RDMAContext *rdma);
+
 /*
  * Consult the connection manager to see a work request
  * (of any kind) has completed.
@@ -1213,6 +1224,9 @@ static int qemu_rdma_poll(RDMAContext *rdma, struct ibv_cq *cq,
 
         if (rdma->nb_sent > 0) {
             rdma->nb_sent--;
+            if (rdma->nb_sent == 0) {
+                rdma_nbsent_zero(rdma);
+            }
         }
     } else {
         trace_rdma_poll_other(wr_id, rdma->nb_sent);
@@ -1438,6 +1452,7 @@ static bool qemu_rdma_post_send(RDMAContext *rdma,
     ret = ibv_post_send(rdma->qp, send_wr, &bad_wr);
     if (ret == ENOMEM && rdma->nb_sent) {
         trace_rdma_post_send_queue_full(send_wr->wr_id, rdma->nb_sent);
+        rdma_nbsent_full(rdma);
         ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
         if (ret < 0) {
             error_setg(errp, "rdma migration: failed to make room for %s",
@@ -1953,6 +1968,7 @@ static int qemu_rdma_write_flush(RDMAContext *rdma, Error **errp)
     if (ret == 0) {
         rdma->nb_sent++;
         trace_rdma_write_flush(rdma->nb_sent);
+        rdma_nbsent_inc(rdma, rdma->nb_sent);
     }
 
     rdma->current_length = 0;
@@ -2998,6 +3014,41 @@ err:
     return -1;
 }
 
+static void rdma_nbsent_inc(RDMAContext *rdma, uint64_t nb_sent)
+{
+    rdma->nbsent_posts++;
+    if (nb_sent > rdma->nbsent_max) {
+        rdma->nbsent_max = nb_sent;
+    }
+}
+
+static void rdma_nbsent_full(RDMAContext *rdma)
+{
+    rdma->nbsent_full_hits++;
+}
+
+static void rdma_nbsent_zero(RDMAContext *rdma)
+{
+    rdma->nbsent_zero_hits++;
+}
+
+static void rdma_stats_reset(RDMAContext *rdma)
+{
+    rdma->nbsent_max = 0;
+    rdma->nbsent_posts = 0;
+    rdma->nbsent_full_hits = 0;
+    rdma->nbsent_zero_hits = 0;
+}
+
+static void rdma_nbsent_stats_dump(RDMAContext *rdma)
+{
+    if (rdma->nbsent_posts == 0) {
+        return;
+    }
+    trace_rdma_nbsent_stats(rdma->nbsent_max, rdma->nbsent_posts,
+                            rdma->nbsent_full_hits, rdma->nbsent_zero_hits);
+}
+
 int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                            ram_addr_t offset, size_t size)
 {
@@ -3547,6 +3598,10 @@ int rdma_registration_start(QEMUFile *f, uint64_t flags)
         return -1;
     }
 
+    if (flags == RAM_CONTROL_SETUP) {
+        rdma_stats_reset(rdma);
+    }
+
     trace_rdma_registration_start(flags);
     qemu_put_be64(f, RAM_SAVE_FLAG_HOOK);
     return qemu_fflush(f);
@@ -3581,6 +3636,11 @@ int rdma_registration_stop(QEMUFile *f, uint64_t flags)
     }
 
     qemu_fflush(f);
+
+    if (flags == RAM_CONTROL_FINISH) {
+        rdma_nbsent_stats_dump(rdma);
+    }
+
     ret = qemu_rdma_write_flush(rdma, &err);
 
     if (ret < 0) {
diff --git a/migration/trace-events b/migration/trace-events
index a6e11451f1..2fdd684115 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -249,6 +249,7 @@ rdma_resolve_host_trying(const char *host, const char *ip) "Trying %s => %s"
 rdma_write_flush(int sent) "sent total: %d"
 rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRIu32
 rdma_post_send_queue_full(uint64_t wr_id, int sent) "send queue full, wr_id=%" PRIu64 ", outstanding writes=%d"
+rdma_nbsent_stats(uint64_t max, uint64_t posts, uint64_t full_hits, uint64_t zero_hits) "nb_sent max %" PRIu64 " posts %" PRIu64 " full-queue hits %" PRIu64 " drains to zero %" PRIu64
 rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Received registration result: my key: 0x%x their key 0x%x, chunk %" PRIu64
 rdma_write_one_sendreg(uint64_t chunk, int len, int index, int64_t offset) "Sending registration request chunk %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
 rdma_write_one_top(uint64_t chunks, uint64_t size) "Writing %" PRIu64 " chunks, (%" PRIu64 " MB)"
-- 
2.39.5


