Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5C7C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 19:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuauk-0008OU-PL; Thu, 13 Aug 2026 15:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wuaui-0008M2-QZ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 15:16:28 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wuaue-0002wk-RQ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 15:16:28 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f92e3c14bso161039f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 12:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786648583; x=1787253383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iHABCY2WRGHEqCmZ//QpBhKBeLGz8HBNkdXy9XOa0vU=;
 b=eTlAPaaIXzHZrucIa7X46FkrXWRtD4nhQcHBL6oTcuE/LQsB13MCg7fXsqHcRUJ3gF
 tKkZ+KNqO+GdLclnRvZikiIOAB6aQI7jSBdQN+c6j1ALbWQrewEe9UFZHUle7AvWKWux
 dWlmq7CQ5FvQjjuOVhhAjMZTFH2kkaSrWoZ6xrUVKADzBZXQNAFtZXGNIcj/3dttL4hA
 3+YpyEsmcwcgb9uTHb40FCbSJrK9rjhHNabrKcwZE4IhPVYuqCW0RZqedqVtD2HrLbz0
 q/ipISnFYkoG2vyTMtGG0eQBei9ks85BM+5Yf+W7295JR2o1ls0k/y63RaOf45sDAIDk
 MWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786648583; x=1787253383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iHABCY2WRGHEqCmZ//QpBhKBeLGz8HBNkdXy9XOa0vU=;
 b=mWSWOFftch0BUz5kSEv2rFm8SmihmJ/ex2vaLRJetkjYsVmf8psd2LF19wAQvwvE46
 yEac0jZUUjISrzIgljN2Ul24d7I4TBOEB8ZmleccO6vMvQhYa2mkzRRtVngEin3BQOjv
 Zsq5apepkK57wT4X12r9qCSffz23P77Jh9ZfIKucamrMDtFLn9M4CAmRcdbj+gt2BXMu
 5LT5D7j8r3UY8x25LyMzyoNCh1sOvEDeNE4dWBj11qo/WR7TZJ19zJocQOwYiNxcghhe
 STinBxYrmWU8ejJ48vKp4WcuEOnYmGJM2cWKlzjz94VzTAH8urxTiSO448dvtOMQt61J
 lXyg==
X-Gm-Message-State: AOJu0YxwqAJS1FKVD4DVFdnWqUI3XYTa2cWq6ryGCqua8PvVa2BOA+7H
 abnzPxmoh84KRWwh+DkPPkUe6dTXMO1BYr589dfTlL342OxHvhy+mdo0NeCNoq+zW4G7hH0nohX
 LM2/G
X-Gm-Gg: AR+sD11yNVL3dmy7K0iny9SxhJ/gis9InVQxbud+MTBgdDMIZtKyUxNCppLMuvGdXHt
 pYnJLo6CZell9AISC5nPH66YgcFilhN8mKevqx4CSLEkrS5Kbb6GQO8uBckE7i9rosdcB09oXXP
 ZwpS5RPuVurK03GSZddNVn/I1MCJDSQCr/ZJF2u9YC2/wSxycROzckH3V3be0j/OLLiVH5f/qS3
 aD+80UZ5I1TeNQeBrztckOrqniwsbiYNcBBl3rd5TvnZVnBNByuNEs7OC0ZaHPvqCustehPkC9E
 Z95JyTf1rRVCoOUBTyY0wH6IBA3aphk1KqDrWX+IZf+j129B3BHafGod0KOg7xcA1JQGzo0lx/N
 9cm3z/xP4Nb1tiSiC8AslXjvHkuHvmHeU2JMmu6skB78C6uMK3mjpXjfEQ8iWeGxiAzkJaxwTu5
 hk8V/QYhtaD1Oe5BOVIqFbfov0XFff9porNi41taXOgEIZlYkEN96Z3k9vndbLBA==
X-Received: by 2002:a05:6000:2612:b0:47f:c648:e265 with SMTP id
 ffacd0b85a97d-48160758afcmr597476f8f.17.1786648583014; 
 Thu, 13 Aug 2026 12:16:23 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:859:6d78:3324:fe2c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1f90sm1312493f8f.18.2026.08.13.12.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:16:22 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 philmd@oss.qualcomm.com, den@openvz.org
Subject: [PULL v3 6/7] hw/ide/atapi: read the whole elementary transfer
 asynchronously
Date: Thu, 13 Aug 2026 21:16:11 +0200
Message-ID: <20260813191613.2323728-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813191613.2323728-1-den@openvz.org>
References: <20260813191613.2323728-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=den@openvz.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Denis V. Lunev <den@openvz.org>

An ATAPI PIO read whose byte-count limit spans more than one CD sector
must fetch the later sectors of a DRQ burst from inside the completion
of the first, asynchronous read. cd_read_sector_sync() did this with a
synchronous blk_pread(), which runs blk_wait_while_drained() before
issuing the request.

If a drain is in progress when that completion runs -- as happens when
a guest reset reaches virtio_blk_stop_ioeventfd() ->
bdrv_drain_all_begin() while an ATAPI read is in flight on the same
QEMU -- the nested read is queued until the drained section ends while
the outer completion still holds blk->in_flight. bdrv_drain_all_begin()
then waits forever for that in_flight count to drop: the main loop is
wedged in the drain with the BQL held, and every other QMP/monitor
operation blocks behind it.

Read the whole elementary transfer in a single asynchronous request up
front instead, so no read is ever issued in the middle of a burst.
cd_read_sector() now reads all the sectors a burst spans (the raw
2352-byte case is unpacked in place on completion) and
cd_read_sector_sync() is removed. The DMA path already batched its
reads and is unchanged.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/atapi.c | 180 +++++++++++++++++++++++--------------------------
 1 file changed, 84 insertions(+), 96 deletions(-)

diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index a42b748521..0ea149ad8c 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -88,46 +88,14 @@ static void cd_data_to_raw(uint8_t *buf, int lba)
     memset(buf, 0, 288);
 }
 
-static int
-cd_read_sector_sync(IDEState *s)
-{
-    int ret;
-    block_acct_start(blk_get_stats(s->blk), &s->acct,
-                     ATAPI_SECTOR_SIZE, BLOCK_ACCT_READ);
-
-    trace_cd_read_sector_sync(s->lba);
-
-    switch (s->cd_sector_size) {
-    case 2048:
-        ret = blk_pread(s->blk, (int64_t)s->lba << ATAPI_SECTOR_BITS,
-                        ATAPI_SECTOR_SIZE, s->io_buffer, 0);
-        break;
-    case 2352:
-        ret = blk_pread(s->blk, (int64_t)s->lba << ATAPI_SECTOR_BITS,
-                        ATAPI_SECTOR_SIZE, s->io_buffer + 16, 0);
-        if (ret >= 0) {
-            cd_data_to_raw(s->io_buffer, s->lba);
-        }
-        break;
-    default:
-        block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);
-        return -EIO;
-    }
-
-    if (ret < 0) {
-        block_acct_failed(blk_get_stats(s->blk), &s->acct);
-    } else {
-        block_acct_done(blk_get_stats(s->blk), &s->acct);
-        s->lba++;
-        s->io_buffer_index = 0;
-    }
-
-    return ret;
-}
-
 static void cd_read_sector_cb(void *opaque, int ret)
 {
     IDEState *s = opaque;
+    int et = s->elementary_transfer_size;
+    int skip = s->io_buffer_index;
+    int nsec = DIV_ROUND_UP(skip + et, s->cd_sector_size);
+    uint8_t *buf;
+    int i;
 
     trace_cd_read_sector_cb(s->lba, ret);
 
@@ -140,34 +108,64 @@ static void cd_read_sector_cb(void *opaque, int ret)
     block_acct_done(blk_get_stats(s->blk), &s->acct);
 
     if (s->cd_sector_size == 2352) {
-        cd_data_to_raw(s->io_buffer, s->lba);
+        /* unpack back-to-front so a sector never clobbers an unmoved one */
+        for (i = nsec - 1; i >= 0; i--) {
+            memmove(s->io_buffer + i * 2352 + 16, s->io_buffer + i * 2048,
+                    ATAPI_SECTOR_SIZE);
+            cd_data_to_raw(s->io_buffer + i * 2352, s->lba + i);
+        }
     }
 
-    s->lba++;
-    s->io_buffer_index = 0;
     s->status &= ~BUSY_STAT;
 
-    ide_atapi_cmd_reply_end(s);
+    s->nsector = (s->nsector & ~7) | ATAPI_INT_REASON_IO;
+    s->lcyl = et & 0xff;
+    s->hcyl = (et >> 8) & 0xff;
+    ide_bus_set_irq(s->bus);
+
+    /* a boundary sector shared with the next burst is re-read there */
+    buf = s->io_buffer + skip;
+    s->packet_transfer_size -= et;
+    s->lba += (skip + et) / s->cd_sector_size;
+    s->io_buffer_index = (skip + et) % s->cd_sector_size;
+    s->elementary_transfer_size = 0;
+
+    if (ide_transfer_start_norecurse(s, buf, et, ide_atapi_cmd_reply_end)) {
+        ide_atapi_cmd_reply_end(s);
+    }
 }
 
+/*
+ * Read the whole elementary transfer (one DRQ burst) in a single async
+ * request. No read is issued mid-burst, so unlike the old synchronous
+ * rebuffer it cannot deadlock against a concurrent drain.
+ */
 static int cd_read_sector(IDEState *s)
 {
-    void *buf;
+    int et = s->elementary_transfer_size;
+    int skip = s->io_buffer_index;
+    int nsec = DIV_ROUND_UP(skip + et, s->cd_sector_size);
 
     if (s->cd_sector_size != 2048 && s->cd_sector_size != 2352) {
         block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);
         return -EINVAL;
     }
 
-    buf = (s->cd_sector_size == 2352) ? s->io_buffer + 16 : s->io_buffer;
-    qemu_iovec_init_buf(&s->qiov, buf, ATAPI_SECTOR_SIZE);
+    /* a burst is bounded by the byte count limit, so it fits io_buffer */
+    assert(nsec * s->cd_sector_size <= s->io_buffer_total_len);
+
+    /*
+     * Read the payload packed at the front of io_buffer; the 2352 raw case is
+     * unpacked into place on completion.
+     */
+    qemu_iovec_init_buf(&s->qiov, s->io_buffer, nsec * ATAPI_SECTOR_SIZE);
 
     trace_cd_read_sector(s->lba);
 
     block_acct_start(blk_get_stats(s->blk), &s->acct,
-                     ATAPI_SECTOR_SIZE, BLOCK_ACCT_READ);
+                     nsec * ATAPI_SECTOR_SIZE, BLOCK_ACCT_READ);
 
-    ide_buffered_readv(s, (int64_t)s->lba << 2, &s->qiov, 4,
+    ide_buffered_readv(s, (int64_t)s->lba << 2, &s->qiov, nsec * 4,
                        cd_read_sector_cb, s);
 
     s->status |= BUSY_STAT;
@@ -222,59 +220,49 @@ static uint16_t atapi_byte_count_limit(IDEState *s)
 void ide_atapi_cmd_reply_end(IDEState *s)
 {
     int byte_count_limit, size, ret;
-    while (s->packet_transfer_size > 0) {
-        trace_ide_atapi_cmd_reply_end(s, s->packet_transfer_size,
-                                      s->elementary_transfer_size,
-                                      s->io_buffer_index);
-
-        /* see if a new sector must be read */
-        if (s->lba != -1 && s->io_buffer_index >= s->cd_sector_size) {
-            if (!s->elementary_transfer_size) {
-                ret = cd_read_sector(s);
-                if (ret < 0) {
-                    ide_atapi_io_error(s, ret);
-                }
-                return;
-            } else {
-                /* rebuffering within an elementary transfer is
-                 * only possible with a sync request because we
-                 * end up with a race condition otherwise */
-                ret = cd_read_sector_sync(s);
-                if (ret < 0) {
-                    ide_atapi_io_error(s, ret);
-                    return;
-                }
+
+    trace_ide_atapi_cmd_reply_end(s, s->packet_transfer_size,
+                                  s->elementary_transfer_size,
+                                  s->io_buffer_index);
+
+    if (s->lba != -1 && s->packet_transfer_size > 0) {
+        byte_count_limit = atapi_byte_count_limit(s);
+        trace_ide_atapi_cmd_reply_end_bcl(s, byte_count_limit);
+        size = s->packet_transfer_size;
+        if (size > byte_count_limit) {
+            /* byte count limit must be even if this case */
+            if (byte_count_limit & 1) {
+                byte_count_limit--;
             }
+            size = byte_count_limit;
         }
-        if (s->elementary_transfer_size > 0) {
-            /* there are some data left to transmit in this elementary
-               transfer */
-            size = s->cd_sector_size - s->io_buffer_index;
-            if (size > s->elementary_transfer_size)
-                size = s->elementary_transfer_size;
-        } else {
-            /* a new transfer is needed */
-            s->nsector = (s->nsector & ~7) | ATAPI_INT_REASON_IO;
-            ide_bus_set_irq(s->bus);
-            byte_count_limit = atapi_byte_count_limit(s);
-            trace_ide_atapi_cmd_reply_end_bcl(s, byte_count_limit);
-            size = s->packet_transfer_size;
-            if (size > byte_count_limit) {
-                /* byte count limit must be even if this case */
-                if (byte_count_limit & 1)
-                    byte_count_limit--;
-                size = byte_count_limit;
-            }
-            s->lcyl = size & 0xff;
-            s->hcyl = size >> 8;
-            s->elementary_transfer_size = size;
-            /* we cannot transmit more than one sector at a time */
-            if (s->lba != -1) {
-                if (size > (s->cd_sector_size - s->io_buffer_index))
-                    size = (s->cd_sector_size - s->io_buffer_index);
+        s->elementary_transfer_size = size;
+        ret = cd_read_sector(s);
+        if (ret < 0) {
+            ide_atapi_io_error(s, ret);
+        }
+        return;
+    }
+
+    while (s->packet_transfer_size > 0) {
+        /* a new transfer is needed */
+        s->nsector = (s->nsector & ~7) | ATAPI_INT_REASON_IO;
+        ide_bus_set_irq(s->bus);
+        byte_count_limit = atapi_byte_count_limit(s);
+        trace_ide_atapi_cmd_reply_end_bcl(s, byte_count_limit);
+        size = s->packet_transfer_size;
+        if (size > byte_count_limit) {
+            /* byte count limit must be even if this case */
+            if (byte_count_limit & 1) {
+                byte_count_limit--;
             }
-            trace_ide_atapi_cmd_reply_end_new(s, s->status);
+            size = byte_count_limit;
         }
+        s->lcyl = size & 0xff;
+        s->hcyl = size >> 8;
+        s->elementary_transfer_size = size;
+        trace_ide_atapi_cmd_reply_end_new(s, s->status);
+
         s->packet_transfer_size -= size;
         s->elementary_transfer_size -= size;
         s->io_buffer_index += size;
@@ -329,7 +317,7 @@ static void ide_atapi_cmd_read_pio(IDEState *s, int lba, int nb_sectors,
     s->lba = lba;
     s->packet_transfer_size = nb_sectors * sector_size;
     s->elementary_transfer_size = 0;
-    s->io_buffer_index = sector_size;
+    s->io_buffer_index = 0;
     s->cd_sector_size = sector_size;
 
     ide_atapi_cmd_reply_end(s);
-- 
2.53.0


