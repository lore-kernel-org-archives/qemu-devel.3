Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B00606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=KRtDFd1r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLOig-00051m-5c; Mon, 26 Oct 2026 13:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xLOiP-0004gw-J5
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:42:34 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xLOiL-0001YR-S2
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:42:33 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so21023205e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 10:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793036548; x=1793641348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q8sDLIOEQXmcxGYUBBmtxWI0/4UuEh9OphnjFBPGIyI=;
 b=KRtDFd1rtthAM4ww4dc6SDdlf5U/RWJZpoMYBAStj9f7EMNIReUS7lq1fHW88MgX5N
 VCfktTGHpZNDTi1UNYrxXfkljJVCpF0JmwksZTsUvSxh+pbe7bh87o+L2pCa+m0Q8FSA
 EMJkYFxqP9tqbkioQupZwFQdwmHaxrJ/rJ0ITmfIm2K81DJxK7RDsv/ZfnudzJvy9PJT
 enokZPqyV0gzPy3hfyuIlZuYFJ2W3JFY2QoWr597ZKx85gci3oH8ZAN8E0MbwCH1Fu7k
 17yyeTPLM+NOAQOgORkbOvAAOhst+ADncSyqe26qjFs3vlNlk2zc8h9CXiuPoQoMZbPc
 g1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793036548; x=1793641348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q8sDLIOEQXmcxGYUBBmtxWI0/4UuEh9OphnjFBPGIyI=;
 b=kK0JAVky4ZkDn+wgNM9J8ChOCZ4ukyDsD/dU/HTfIaIHXn9dOcqc0DDa7jppEaCD+p
 BU7Fx8y7MJv9YhsEqj5FwJ7uOMOmQDwlbXtlPSpC4WRCBWl/oK1LqB84kJoYEnTEGaUG
 PA8NIV+hJCgHS1HZtXbEqGeqoYYXR78/NEDQhyB+IoMEunAL/ikiFuzs9OFBgztaIP1T
 qJrluPpznyexicIidoyuuiYURFz0N2pjCb4i9GKRsu4KVbTlONWTJFi3n1r1Hfb5I4yV
 Yx5CdieDGISum5h7Wda+9I0dyYKolQ6O9vl60lPyd2bC+sWHLtBGf9w9bo9RQk+3hCPi
 bPZw==
X-Gm-Message-State: AFq9FYIcy8P5xdBRDr36nQ7ipx/ZrMwenFr7isHqlivqZw7uX9N0jn9A
 GyogxAjVE5F+ujyxjeQ3x5FIYMrVONDEQQ3GtC/TSejQHWcbeOmZLyPDaYU1Vr8sskekYqgCh1q
 vl7qR
X-Gm-Gg: AYBFou3PPi4ZZ1qUxwEpTYcZFxhIlDArumkKJFvTGj7ppwOCHjTxTi+fTfw+3obtddb
 ke5eyfcLS1TIzvfLucCXlws3IP1WQQ/GTtDtggxipZ5Ut+IOZd+u90Ij2wgdWw0YWyUIw296oxo
 qZQbtt4snREaH/E6kZRnW0fgxBF3DpW/R042LdUDpGbBQ634TZbotXU41rC+tYHXxs0rjpAVAP3
 k2lVQaxHQQ6vlqjnhu8qwsJEsuGiKY2iNODUmCxu4EkmBJiWrR0BLkc9b7xzj7bAaPpL8Sfa50o
 wg12Rg04KvBWVOilt8JsnIZe3sfTEBY3ICuGLSWiI3m/Cj6zCxgwiVaFdE7etcG2Nlw+5ZS4NMd
 kD5kQZK1WIQlFM/yU8N89zjzhmp9BsmIUz+Ahd03TMsbKDJgfWT2eNSW3GfAEVt9AkkyG7tRs/E
 LHD2KLrzq3XHThT6HJO9YeMlLcuZKnT/kECSbqRBGuHPCH5wkxzZ2KJ021kKs1Xfm8Y7EMvw2J4
 rCyrY4B+X6zY2kwM89i4yZAueV6t6m8aNdCcctGck0p+FxyNX4=
X-Received: by 2002:a05:600c:83c7:b0:4a1:83f0:7c91 with SMTP id
 5b1f17b1804b1-4a35aca186amr136837005e9.18.1793036547525; 
 Mon, 26 Oct 2026 10:42:27 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:1a6:7f7f:f573:ba9e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb90dsm16169111f8f.22.2026.10.26.10.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 10:42:27 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 3/5] scsi-disk: fix WRITE SAME racing with inactivation of
 block nodes
Date: Mon, 26 Oct 2026 18:42:17 +0100
Message-ID: <20261026174220.674460-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026174220.674460-1-den@openvz.org>
References: <20261026174220.674460-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=den@openvz.org; helo=mail-wm1-x331.google.com
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

WRITE SAME with a non-zero pattern is written in SCSI_WRITE_SAME_MAX
chunks, and each chunk is submitted from the completion callback of the
previous one. As with UNMAP, a drain only waits for the chunk in
flight, the next one is queued by blk_wait_while_drained(), and
bdrv_inactivate_all() resumes it on an inactive node:

  bdrv_co_write_req_prepare: Assertion
  `!(bs->open_flags & BDRV_O_INACTIVE)' failed.

Write the chunks from scsi_disk_co_aio_start() with BDRV_REQ_NO_QUEUE,
so a drain waits for the whole command. werror=ignore still goes on
with the next chunk.

The sector count becomes int64_t on the way: the old int overflowed for
a WRITE SAME(16) of 2^31 or more 512-byte sectors.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: qemu-stable@nongnu.org
---
 hw/scsi/scsi-disk.c | 102 +++++++++++++++++---------------------------
 1 file changed, 39 insertions(+), 63 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index dbf8829fb1..952d7cf917 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1938,52 +1938,52 @@ invalid_field:
     scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
 }
 
-typedef struct WriteSameCBData {
-    SCSIDiskReq *r;
-    int64_t sector;
-    int nb_sectors;
-    QEMUIOVector qiov;
-    struct iovec iov;
-} WriteSameCBData;
-
-static void scsi_write_same_complete(void *opaque, int ret)
+static int coroutine_fn scsi_write_same_co(SCSIDiskCoAIOCB *iocb)
 {
-    WriteSameCBData *data = opaque;
-    SCSIDiskReq *r = data->r;
+    SCSIDiskReq *r = iocb->r;
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+    BlockBackend *blk = s->qdev.conf.blk;
+    uint8_t *inbuf = r->iov.iov_base;
+    uint32_t buflen = MIN(s->qdev.blocksize, r->buflen);
+    int64_t sector = r->req.cmd.lba * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
+    int64_t nb_sectors = (int64_t)scsi_data_cdb_xfer(r->req.cmd.buf) *
+                         (s->qdev.blocksize / BDRV_SECTOR_SIZE);
+    size_t size = MIN(nb_sectors * BDRV_SECTOR_SIZE, SCSI_WRITE_SAME_MAX);
+    uint8_t *buf = blk_blockalign(blk, size);
+    int ret = 0;
+    size_t i, l;
+
+    for (i = 0; i < size; i += l) {
+        l = MIN(buflen, size - i);
+        memcpy(&buf[i], inbuf, l);
+    }
 
-    assert(r->req.aiocb != NULL);
-    r->req.aiocb = NULL;
+    while (nb_sectors > 0) {
+        size_t chunk = MIN(nb_sectors * BDRV_SECTOR_SIZE, size);
 
-    if (scsi_disk_req_check_error(r, ret, true)) {
-        goto done;
-    }
+        if (iocb->canceled) {
+            ret = -ECANCELED;
+            break;
+        }
 
-    block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
+        block_acct_start(blk_get_stats(blk), &r->acct, chunk,
+                         BLOCK_ACCT_WRITE);
+        ret = blk_co_pwrite(blk, sector << BDRV_SECTOR_BITS, chunk, buf,
+                            BDRV_REQ_NO_QUEUE);
+        if (ret < 0) {
+            if (!scsi_disk_ignore_error(r, ret)) {
+                break;
+            }
+            ret = 0;
+        }
+        block_acct_done(blk_get_stats(blk), &r->acct);
 
-    data->nb_sectors -= data->iov.iov_len / BDRV_SECTOR_SIZE;
-    data->sector += data->iov.iov_len / BDRV_SECTOR_SIZE;
-    data->iov.iov_len = MIN(data->nb_sectors * BDRV_SECTOR_SIZE,
-                            data->iov.iov_len);
-    if (data->iov.iov_len) {
-        block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
-                         data->iov.iov_len, BLOCK_ACCT_WRITE);
-        /* Reinitialize qiov, to handle unaligned WRITE SAME request
-         * where final qiov may need smaller size */
-        qemu_iovec_init_external(&data->qiov, &data->iov, 1);
-        r->req.aiocb = blk_aio_pwritev(s->qdev.conf.blk,
-                                       data->sector << BDRV_SECTOR_BITS,
-                                       &data->qiov, 0,
-                                       scsi_write_same_complete, data);
-        return;
+        sector += chunk / BDRV_SECTOR_SIZE;
+        nb_sectors -= chunk / BDRV_SECTOR_SIZE;
     }
 
-    scsi_req_complete(&r->req, GOOD);
-
-done:
-    scsi_req_unref(&r->req);
-    qemu_vfree(data->iov.iov_base);
-    g_free(data);
+    qemu_vfree(buf);
+    return ret;
 }
 
 static void scsi_disk_emulate_write_same(SCSIDiskReq *r, uint8_t *inbuf)
@@ -1992,9 +1992,6 @@ static void scsi_disk_emulate_write_same(SCSIDiskReq *r, uint8_t *inbuf)
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
     uint32_t nb_sectors = scsi_data_cdb_xfer(r->req.cmd.buf);
     uint32_t buflen = MIN(s->qdev.blocksize, r->buflen);
-    WriteSameCBData *data;
-    uint8_t *buf;
-    int i, l;
 
     /* Fail if PBDATA=1 or LBDATA=1 or ANCHOR=1.  */
     if (nb_sectors == 0 || (req->cmd.buf[1] & 0x16)) {
@@ -2026,28 +2023,7 @@ static void scsi_disk_emulate_write_same(SCSIDiskReq *r, uint8_t *inbuf)
         return;
     }
 
-    data = g_new0(WriteSameCBData, 1);
-    data->r = r;
-    data->sector = r->req.cmd.lba * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
-    data->nb_sectors = nb_sectors * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
-    data->iov.iov_len = MIN(data->nb_sectors * BDRV_SECTOR_SIZE,
-                            SCSI_WRITE_SAME_MAX);
-    data->iov.iov_base = buf = blk_blockalign(s->qdev.conf.blk,
-                                              data->iov.iov_len);
-    qemu_iovec_init_external(&data->qiov, &data->iov, 1);
-
-    for (i = 0; i < data->iov.iov_len; i += l) {
-        l = MIN(buflen, data->iov.iov_len - i);
-        memcpy(&buf[i], inbuf, l);
-    }
-
-    scsi_req_ref(&r->req);
-    block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
-                     data->iov.iov_len, BLOCK_ACCT_WRITE);
-    r->req.aiocb = blk_aio_pwritev(s->qdev.conf.blk,
-                                   data->sector << BDRV_SECTOR_BITS,
-                                   &data->qiov, 0,
-                                   scsi_write_same_complete, data);
+    scsi_disk_co_aio_start(r, scsi_write_same_co);
 }
 
 static void scsi_disk_emulate_write_data(SCSIRequest *req)
-- 
2.53.0


