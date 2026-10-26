Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F508606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=TRTXmUj4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLOid-0004ut-AD; Mon, 26 Oct 2026 13:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xLOiO-0004fD-AT
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:42:33 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xLOiJ-0001Y8-VY
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:42:31 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so1722728f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 10:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793036546; x=1793641346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZFHh1KrwXYFyl60EMkKojcslQKXq/Q6X7Dy91KFQf6E=;
 b=TRTXmUj4vacKuzdz5QJRWdBMHsTrSGpaX0iW9IFToIhTkytA4ZW0OXSCPBYvvYGe/u
 R2xin6F1MEORalZp2WvuTL/dD3uQHFWaFRO30QPe9usCOIFpkQYiKnWzCD5DAk2S25u+
 hJKPfiWTPXhvnlwVXmGlmQm5sAd23AsEpOZY/5XCuZtnbRmARA+OYOyGOLu34wG77Eyo
 RbrVeCQsWm2MydU2wqJj1g5NixWCzg5dk77ViXWxwAQ47ARJlUmpS8wkm1fTKj4HDT9q
 ly2Ss07gaphZTBdO48FT8vF1ZJtDQg27aJ/EScuODAUM9PIaTMbulAjxdshBMaP6JR2/
 OxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793036546; x=1793641346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZFHh1KrwXYFyl60EMkKojcslQKXq/Q6X7Dy91KFQf6E=;
 b=mMno7bpScc2XsTGihAxaQfYqZT/BQTgSg+dk3ON0ELju9VNnyDpdH/IwzHgwfzE5Hq
 6YSNYXJ5EOwQkMGivXVfSGYr1GmwHkTgjQG5d5KZXNanv4I0/LPHFxE4KwJSOFF7crG7
 e6H8cYhc4RkX/Ko8IaGyOa4a+iDk31h04Et49UtbJNgB0RXALF88dUqcodgNkMWvxQJE
 kU41bnde/VpakQq0o6wURS7ZwythrCAMdtoyLkN6KFrt3undSVEZj3NksTfuOxQ+THwu
 UF65Zsa9IZkQdydj6CzST+fg8739+fhNiRvm3IgQtTUorKpVfhbuYjesb7lJ+nHmxmV9
 AA+w==
X-Gm-Message-State: AFq9FYLzbX3UFHCxGcQz2ZQ1nEwkj6+8LrCfm8ljEZJBefYay8Rs9vpr
 NzvdBZPZ1VH/kDW/NuCQdfqdRJTHHyFzOhAJZt1bS1+PTPZOI4hKzO5YAVkQWOWtrD+vhn3Zv8l
 3U6mJ
X-Gm-Gg: AYBFou00Ua942Pr+4lx9RrCniGBgCDLc4PU5UoF+IhV8oMZGJiN9O69gj4DE2Lte0eD
 frQSZAry0f+8EW7oLfwCVb2MR2VUiWQsrYFqBY7YzofRKjXBualABDgXSTn1Sa8SDP8KnQTgQB1
 l4nzRmm14GKnJR/1s+0OFTmUH9M0gQTE55NtvY5rkJ3P2OrNeN12v5D0jO234MnPrzkq7Hpduxk
 hlOnwI08lP1COfk2JIBFiRNMZO3ByftWc3+A/GP8aqsFxHCaTGCcrhbvZb9lbvuu2bguLp2gAKH
 TlEJ4ulc1kXxPM/aGo9Hn+zTi8ZEx9j+pW8iGV9+C9hPF5B2VIJupyK7T/1GZxmoVDHxLN62PQt
 dwYpX8899BlDXMn3ehyrORtnNG/zlurk3bm+iNeEurlOZRJ0XPvVi1Ai5Dd5qklQFjGhdzR2LIP
 rjZOq04AmL/d9/tSw+FA3DcrDHsQa1siZrO5CEWDCL20LVSskg7XxbO5t8wIqoFp4gCf3xsxkES
 BRZ/TEdqJn+LYWxJhgiNMqKQKC3InzNEP+5xgUPARySS4WASTA=
X-Received: by 2002:a05:6000:2404:b0:48e:314:f9f2 with SMTP id
 ffacd0b85a97d-48e3eb2bdcdmr13182088f8f.8.1793036546318; 
 Mon, 26 Oct 2026 10:42:26 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:1a6:7f7f:f573:ba9e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb90dsm16169111f8f.22.2026.10.26.10.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 10:42:25 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 2/5] scsi-disk: fix UNMAP racing with inactivation of block
 nodes
Date: Mon, 26 Oct 2026 18:42:16 +0100
Message-ID: <20261026174220.674460-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026174220.674460-1-den@openvz.org>
References: <20261026174220.674460-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=den@openvz.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Denis V. Lunev <den@openvz.org>

scsi-disk turns a multi-descriptor UNMAP into one discard per
descriptor and submits the next one from the completion callback of
the previous. Nothing holds the BlockBackend in-flight counter between
two descriptors, so a drain only waits for the discard currently in
flight. When that discard completes inside drained_begin, the callback
submits the next one, blk_wait_while_drained() queues it, and the drain
returns with the UNMAP half done.

bdrv_inactivate_all() drains, inactivates the nodes and ends the drain,
which resumes the queued discard on an inactive node:

  bdrv_co_write_req_prepare: Assertion
  `!(bs->open_flags & BDRV_O_INACTIVE)' failed.

A guest that issues UNMAP at the end of a live migration, or around
blockdev-set-active, takes QEMU down this way.

Handle UNMAP the way commit 095c08a7ba handles IDE TRIM: process the
descriptors in a coroutine between blk_co_start_request() and
blk_end_request() and submit them with BDRV_REQ_NO_QUEUE. A drain now
waits for the whole command instead of a single descriptor, the same
trade-off IDE makes. The coroutine is wrapped in an AIOCB that stays in
r->req.aiocb, so cancellation keeps working as before.

A failed descriptor ends the loop, and the completion applies the
rerror/werror policy as before. werror=ignore is handled inside the
loop, so the remaining descriptors are still discarded as the callback
chain did.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: qemu-stable@nongnu.org
---
 hw/scsi/scsi-disk.c | 159 +++++++++++++++++++++++++++++++-------------
 1 file changed, 112 insertions(+), 47 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 73c1ecba0b..dbf8829fb1 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1752,61 +1752,134 @@ static inline bool check_lba_range(SCSIDiskState *s,
             sector_num + nb_sectors <= s->qdev.max_lba + 1);
 }
 
-typedef struct UnmapCBData {
+typedef struct SCSIDiskCoAIOCB SCSIDiskCoAIOCB;
+
+typedef int coroutine_fn SCSIDiskCoFunc(SCSIDiskCoAIOCB *iocb);
+
+struct SCSIDiskCoAIOCB {
+    BlockAIOCB common;
     SCSIDiskReq *r;
-    uint8_t *inbuf;
-    int count;
-} UnmapCBData;
+    SCSIDiskCoFunc *fn;
+    int ret;
+    bool canceled;
+};
+
+static void scsi_disk_co_aio_cancel(BlockAIOCB *acb)
+{
+    SCSIDiskCoAIOCB *iocb = container_of(acb, SCSIDiskCoAIOCB, common);
+
+    iocb->canceled = true;
+}
 
-static void scsi_unmap_complete(void *opaque, int ret);
+static const AIOCBInfo scsi_disk_co_aiocb_info = {
+    .aiocb_size         = sizeof(SCSIDiskCoAIOCB),
+    .cancel_async       = scsi_disk_co_aio_cancel,
+};
 
-static void scsi_unmap_complete_noio(UnmapCBData *data, int ret)
+static void scsi_disk_co_aio_bh(void *opaque)
 {
-    SCSIDiskReq *r = data->r;
-    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+    SCSIDiskCoAIOCB *iocb = opaque;
+    BlockBackend *blk = iocb->r->req.dev->conf.blk;
 
-    assert(r->req.aiocb == NULL);
+    iocb->common.cb(iocb->common.opaque, iocb->ret);
+    qemu_aio_unref(iocb);
 
-    if (data->count > 0) {
-        uint64_t sector_num = ldq_be_p(&data->inbuf[0]);
-        uint32_t nb_sectors = ldl_be_p(&data->inbuf[8]) & 0xffffffffULL;
-        r->sector = sector_num * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
-        r->sector_count = nb_sectors * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
+    /* Paired with blk_co_start_request in scsi_disk_co_aio_entry() */
+    blk_end_request(blk);
+}
 
-        block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
-                         r->sector_count * BDRV_SECTOR_SIZE,
-                         BLOCK_ACCT_UNMAP);
+static void coroutine_fn scsi_disk_co_aio_entry(void *opaque)
+{
+    SCSIDiskCoAIOCB *iocb = opaque;
 
-        r->req.aiocb = blk_aio_pdiscard(s->qdev.conf.blk,
-                                        r->sector * BDRV_SECTOR_SIZE,
-                                        r->sector_count * BDRV_SECTOR_SIZE,
-                                        scsi_unmap_complete, data);
-        data->count--;
-        data->inbuf += 16;
-        return;
-    }
+    /* Paired with blk_end_request in scsi_disk_co_aio_bh() */
+    blk_co_start_request(iocb->r->req.dev->conf.blk);
+    iocb->ret = iocb->fn(iocb);
+    aio_bh_schedule_oneshot(qemu_get_current_aio_context(),
+                            scsi_disk_co_aio_bh, iocb);
+}
 
-    scsi_req_complete(&r->req, GOOD);
+static void scsi_disk_co_aio_complete(void *opaque, int ret)
+{
+    SCSIDiskReq *r = opaque;
+
+    assert(r->req.ctx == qemu_get_current_aio_context());
+    assert(r->req.aiocb != NULL);
+    r->req.aiocb = NULL;
+
+    if (!scsi_disk_req_check_error(r, ret, true)) {
+        scsi_req_complete(&r->req, GOOD);
+    }
     scsi_req_unref(&r->req);
-    g_free(data);
 }
 
-static void scsi_unmap_complete(void *opaque, int ret)
+/* fn must submit with BDRV_REQ_NO_QUEUE and stop once iocb->canceled */
+static void scsi_disk_co_aio_start(SCSIDiskReq *r, SCSIDiskCoFunc *fn)
 {
-    UnmapCBData *data = opaque;
-    SCSIDiskReq *r = data->r;
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+    SCSIDiskCoAIOCB *iocb;
 
-    assert(r->req.aiocb != NULL);
-    r->req.aiocb = NULL;
+    iocb = blk_aio_get(&scsi_disk_co_aiocb_info, s->qdev.conf.blk,
+                       scsi_disk_co_aio_complete, r);
+    iocb->r = r;
+    iocb->fn = fn;
+    iocb->ret = 0;
+    iocb->canceled = false;
 
-    if (scsi_disk_req_check_error(r, ret, true)) {
-        scsi_req_unref(&r->req);
-        g_free(data);
-    } else {
-        block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
-        scsi_unmap_complete_noio(data, ret);
+    /* The matching unref is in scsi_disk_co_aio_complete */
+    scsi_req_ref(&r->req);
+    r->req.aiocb = &iocb->common;
+    aio_co_enter(qemu_get_current_aio_context(),
+                 qemu_coroutine_create(scsi_disk_co_aio_entry, iocb));
+}
+
+/* Report like scsi_handle_rw_error(), but let werror=ignore go on */
+static bool scsi_disk_ignore_error(SCSIDiskReq *r, int ret)
+{
+    BlockBackend *blk = r->req.dev->conf.blk;
+    BlockErrorAction action = blk_get_error_action(blk, false, -ret);
+
+    if (action != BLOCK_ERROR_ACTION_IGNORE) {
+        return false;
+    }
+    blk_error_action(blk, action, false, -ret);
+    return true;
+}
+
+static int coroutine_fn scsi_unmap_co(SCSIDiskCoAIOCB *iocb)
+{
+    SCSIDiskReq *r = iocb->r;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+    BlockBackend *blk = s->qdev.conf.blk;
+    uint8_t *p = r->iov.iov_base;
+    int count = lduw_be_p(&p[2]) >> 4;
+    int i, ret;
+
+    for (i = 0; i < count; i++) {
+        uint64_t sector_num = ldq_be_p(&p[8 + i * 16]);
+        uint32_t nb_sectors = ldl_be_p(&p[8 + i * 16 + 8]);
+
+        if (iocb->canceled) {
+            return -ECANCELED;
+        }
+
+        r->sector = sector_num * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
+        r->sector_count = nb_sectors * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
+
+        block_acct_start(blk_get_stats(blk), &r->acct,
+                         r->sector_count * BDRV_SECTOR_SIZE,
+                         BLOCK_ACCT_UNMAP);
+
+        ret = blk_co_pdiscard(blk, r->sector * BDRV_SECTOR_SIZE,
+                              r->sector_count * BDRV_SECTOR_SIZE,
+                              BDRV_REQ_NO_QUEUE);
+        if (ret < 0 && !scsi_disk_ignore_error(r, ret)) {
+            return ret;
+        }
+        block_acct_done(blk_get_stats(blk), &r->acct);
     }
+
+    return 0;
 }
 
 static void scsi_disk_emulate_unmap(SCSIDiskReq *r, uint8_t *inbuf)
@@ -1814,7 +1887,6 @@ static void scsi_disk_emulate_unmap(SCSIDiskReq *r, uint8_t *inbuf)
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
     uint8_t *p = inbuf;
     int len = r->req.cmd.xfer;
-    UnmapCBData *data;
     int count;
     int i;
 
@@ -1853,14 +1925,7 @@ static void scsi_disk_emulate_unmap(SCSIDiskReq *r, uint8_t *inbuf)
         }
     }
 
-    data = g_new0(UnmapCBData, 1);
-    data->r = r;
-    data->inbuf = &p[8];
-    data->count = count;
-
-    /* The matching unref is in scsi_unmap_complete, before data is freed.  */
-    scsi_req_ref(&r->req);
-    scsi_unmap_complete_noio(data, 0);
+    scsi_disk_co_aio_start(r, scsi_unmap_co);
     return;
 
 invalid_param_len:
-- 
2.53.0


