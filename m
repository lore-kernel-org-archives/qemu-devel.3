Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AB3CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc6Bx-0003Et-NZ; Tue, 23 Jun 2026 14:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wc6Ay-00038b-D4
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:48:51 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wc6Ap-0001t0-Py
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:48:43 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-45eea68dd6fso129374f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782240518; x=1782845318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TlwU3yNvRfhfM3gVnf8a/61Hz1mssQyPMkUvuS98sU=;
 b=b7JagjK6y9NpK7DuDqOMWuF9joy6mD9bebZIp6sw/xttFyxUvOFY6K5WN55O05JIPZ
 Zd2HwftA9LXpdqjBT9gIZJKiVAPIkWmT7fzuVqkUYMLsiq72eQqqoc5JXpIkuWoqxZBp
 KpHF7wzvGbpyhqr+0TQOtXSRF7SMHb9bWO6tuqINHZEX47IT+M6UAo5X63PgZ+g75Rrc
 ZAVDnW0KlaNvbhqwgBKriB/ZT/ZUlfR6kQuM8P5bACRLouhWIlTvGV6aYs+PQGz/rGrf
 U1hzbjFmB+vN4wQp+0RtuaPDczb+PmE/oBvnfoJ6Wm1aDMIt5yxa798oDAEGrjQCHR/q
 yTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782240518; x=1782845318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4TlwU3yNvRfhfM3gVnf8a/61Hz1mssQyPMkUvuS98sU=;
 b=PUI5iqXzmanLthJiNmJdXOR4mRtHk0/cIsEM4ydqzkv7tHyQobn7GhpmXbDzybTM31
 Lt5JR/QQa3OmeOxTWC4foO9uL+bGTKJnUfghfYm+Molu0ZEJJ0v2c06RnyohF8mvcAMk
 E9sUInM+56CvZOyM4sFuiGfgXCUIHgsSMWb36TCLSsb6+xSWneOW83pcTcfb9at5Noa6
 1DeRyeI7IWERfJfOE2ybU8w9a93jevJpe80fyTaSob0nn4eNAGhVS3qyJOmlhFxBXM8e
 g6J3BRCuaT3BJo499EAxUTRjUbwEMD7i9PmanqhTLdEbWR+SvKEMPzwekDhXPiUhY/2n
 l2pA==
X-Gm-Message-State: AOJu0YzfVNQ9G1aK68Oaq36y/Nm5gnkhyiqQ71Hz+Cpj7OKd/gwHgmpn
 ZgfUlBUNrdSR3mJ87+WxOFi0yBxxgzjBdD2NE9OdU8xTNV9UVFemaDE7gHwh7g==
X-Gm-Gg: AfdE7ckchME3QhKYnMNixxnaWqwJd178tBNhiFoHpKu0QADZl+H2OUyzjPqiaaJbFrF
 ikRwFks8rNVMCOunPtyQEj9r65wK0cFMX8eeSUHFNZrxxXhqMhQK2Jyeo3gOJKyNAPisrFlWZcT
 QMi26ChVi1XN49oZJO+8mOSeJmBfHM1BK0m07b1KsApZgy4yRuLd8EAyguDAt8xsWo8p65DtkDl
 0AfFsdlXXhZpnoVtQunFnYG8tQiFIYgougbWjNvI0gCrGJal4AFaSzoovW4hIwekyHGNrW4+lgU
 o/iS7BkyUltwodCG7/qyz/JIPBtPGQei+W5aintvpc16Hz+m3RJ518n9HP9NQtR1HxYAXLasPWp
 X8m7jo+9mafyjE3CTxfZz+ECmGOXrAAkwQr7qHt2MYWgyaa+WV8CjvaDZ+td80kezJvq77w26NX
 6Is2AtUOb4HELgkjJufvOHasmETUutcwtAvHWQd+8UbsUUYA==
X-Received: by 2002:a5d:5f8e:0:b0:45e:e9ac:42e8 with SMTP id
 ffacd0b85a97d-46ad95c3780mr6360690f8f.18.1782240518245; 
 Tue, 23 Jun 2026 11:48:38 -0700 (PDT)
Received: from dobby ([2a02:8109:a394:4800:75bc:d765:f335:35fc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f563dsm34644603f8f.3.2026.06.23.11.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 11:48:37 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, cassel@kernel.org, dlemoal@kernel.org,
 qemu-block@nongnu.org, dmitry.fomichev@wdc.com,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v12 3/5] virtio-blk: do not merge writes across a zone boundary
Date: Tue, 23 Jun 2026 20:48:28 +0200
Message-ID: <20260623184830.373232-4-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623184830.373232-1-faithilikerun@gmail.com>
References: <20260623184830.373232-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=faithilikerun@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

virtio_blk_submit_multireq() fuses adjacent in-zone writes into a
single request. On a zoned backend, a merged zone append request
that straddles a zone boundary is rejected by the device because
each write must stay within a single zone.

Add a bail condition to the merge coalescer: if combining the
candidate request into the current batch would cross a zone
boundary, flush the current batch and start a new one.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/block-backend.c             | 11 +++++++++++
 hw/block/virtio-blk.c             | 22 +++++++++++++++++++++-
 include/system/block-backend-io.h |  1 +
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 37ba7e9fc4..049e70ddcb 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2326,6 +2326,17 @@ uint32_t blk_get_request_alignment(BlockBackend *blk)
     return bs ? bs->bl.request_alignment : BDRV_SECTOR_SIZE;
 }
 
+/*
+ * Returns the zone size in bytes for a zoned backend, or 0 if @blk does
+ * not present zoned geometry.
+ */
+uint64_t blk_get_zone_size(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    IO_CODE();
+    return bs ? bs->bl.zone_size : 0;
+}
+
 /* Returns the optimal write zeroes alignment, in bytes; guaranteed nonzero */
 uint32_t blk_get_pwrite_zeroes_alignment(BlockBackend *blk)
 {
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 6b92066aff..39750fa1c0 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -294,6 +294,9 @@ static void virtio_blk_submit_multireq(VirtIOBlock *s, MultiReqBuffer *mrb)
     int i = 0, start = 0, num_reqs = 0, niov = 0, nb_sectors = 0;
     uint32_t max_transfer;
     int64_t sector_num = 0;
+    uint64_t zone_size = blk_get_zone_size(s->blk);
+    bool zone_cross;
+    int64_t zone_sector, end_sector;
 
     if (mrb->num_reqs == 1) {
         submit_requests(s, mrb, 0, 1, -1);
@@ -309,17 +312,34 @@ static void virtio_blk_submit_multireq(VirtIOBlock *s, MultiReqBuffer *mrb)
     for (i = 0; i < mrb->num_reqs; i++) {
         VirtIOBlockReq *req = mrb->reqs[i];
         if (num_reqs > 0) {
+            zone_cross = false;
+
+            /*
+             * On zoned backends, a single backend write must not span a zone
+             * boundary. Bail out of merging if combining req into the current
+             * batch would straddle a zone.
+             */
+            if (zone_size > 0) {
+                zone_sector = zone_size / BDRV_SECTOR_SIZE;
+                end_sector = req->sector_num
+                                + req->qiov.size / BDRV_SECTOR_SIZE - 1;
+                zone_cross = (sector_num / zone_sector) !=
+                             (end_sector / zone_sector);
+            }
+
             /*
              * NOTE: We cannot merge the requests in below situations:
              * 1. requests are not sequential
              * 2. merge would exceed maximum number of IOVs
              * 3. merge would exceed maximum transfer length of backend device
+             * 4. merge would cross a zone boundary on a zoned backend
              */
             if (sector_num + nb_sectors != req->sector_num ||
                 niov > blk_get_max_iov(s->blk) - req->qiov.niov ||
                 req->qiov.size > max_transfer ||
                 nb_sectors > (max_transfer -
-                              req->qiov.size) / BDRV_SECTOR_SIZE) {
+                              req->qiov.size) / BDRV_SECTOR_SIZE ||
+                zone_cross) {
                 submit_requests(s, mrb, start, num_reqs, niov);
                 num_reqs = 0;
             }
diff --git a/include/system/block-backend-io.h b/include/system/block-backend-io.h
index fd84723d9d..78d410b8df 100644
--- a/include/system/block-backend-io.h
+++ b/include/system/block-backend-io.h
@@ -121,6 +121,7 @@ uint32_t blk_get_request_alignment(BlockBackend *blk);
 uint32_t blk_get_pwrite_zeroes_alignment(BlockBackend *blk);
 uint32_t blk_get_max_transfer(BlockBackend *blk);
 uint64_t blk_get_max_hw_transfer(BlockBackend *blk);
+uint64_t blk_get_zone_size(BlockBackend *blk);
 
 int coroutine_fn blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
                                    BlockBackend *blk_out, int64_t off_out,
-- 
2.53.0


