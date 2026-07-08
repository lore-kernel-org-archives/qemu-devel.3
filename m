Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998A5C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 22:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whaZJ-0008Ki-T4; Wed, 08 Jul 2026 18:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1whaZI-0008J1-5f
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 18:16:36 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1whaZE-0004H4-9F
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 18:16:35 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f95so410687a12.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783548991; x=1784153791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rf0dRaa81KrSy0wpPsNeErRiWruk8QrKs+wx142BAg8=;
 b=A4YQPRZ7WTLVEA8CiTqJVSzwlNCQV0uSDm2Sn1DSYeOGIkJa3yca8yYOwqy8LJmWdv
 wqjZZ3JQ7FDEVx+jTTMuU5WvB1BrZUfqiQfiqpdpl5pvnDUVUS5TRtRCncXuCUQRoOM0
 TSCnyPAVXnatoV7OEaN+XDidVd51WM/3AicSjVTedZzraOHcgTYR8D3OJP8fdyL/6LMy
 WTnTp+jdtDqBdWk4pKoQ5WUjxMM0X30SH4jB3vIXIqhUeXK8EhmJhA/rr6LlyzuxSSdF
 Vm72KI9eZIWCytT9yZjpbdOaN7kKtAfF3OD7gsda8/wJl/AWzJ914r8SSV+NT0zaE0Iy
 x8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783548991; x=1784153791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rf0dRaa81KrSy0wpPsNeErRiWruk8QrKs+wx142BAg8=;
 b=EUnr2Z0hqoFQSP7SJhi+QEfwz89obBzhdokC5BetWQ5X/IzRjaVVL97jRhbiQopibJ
 0Be5d3X9tDA+Z3q2Ugptq189OuSi1hlLuXEXqMdMygGihLvDUT6XMz1ahrH2s0Sn4ogh
 Wtbkr8Xh/0+TD0b6U3K+/OC9SuwbXpYF4Wf8h+XVt6yimABf3NyT2nkBHURHB0p3OLDI
 Gfelyd1jlBvU3TfIddSyGD/xRoD81x/AZ7BS7ZQBNGJKM2yVcOmCoohTtVhN5TuXPlCh
 5sTlLt3tW0bx0rO7ajIIHHxn4jehWnGIT3h1exfkFlPOtduu05R84AcsUJttVzQfaSdL
 /Sxg==
X-Gm-Message-State: AOJu0Yw4rxLJ2k0UzFWqxRQo7cKglMkK30Z4HULtGIP1rI6Evvp+4XUT
 jSM14pfk6c0c3zM6NDy9szurU4t7HeROTLkosQFm0xxEfC9N+4CclIcdfSELk/9K/3M=
X-Gm-Gg: AfdE7ckrnM2Je8BpkBTAUjlZy2Fyl7kf4dGem/zbNbeNvFfA23AifjxxwB2K8jA9nM2
 vjWmS/tzo7NTLCjRQQSHk97SNmU7pcdejVHP1awKH2kkEZg88x2sE4ZvK0fInwqptKbleE1H27T
 5Qy3wBN2G0b+fCPUdOA/8CY/tDRq/hP4hMU1WG3yG+UjKcyQM17yfJVjW95FtgziHULRX+GWfVY
 E3Xjx01tyGkyFgPRsl5bn4Y1Do3mrwqRmo5g/CFiEGS9IWMWCkez7b/cPrDRprRKLTOmJ+F1M7a
 iUiExsuk048kwmf3d0P0J0XBnZfTZUrsxtxfR0zxKSVnuyuOsQXDrMAE2tln8xCOtV/WnrudxM4
 1Dqj76MD+OYXkijKEIwVAdZIdeUelj8kBGU9LnqjP7s8184vg1hpjjW68ehNf0h8djMXnZJq2hU
 wlUEmR2zbLrFSfwrf02JsLozmkiwREtEUFLT8fAbycG0Qbaw==
X-Received: by 2002:a05:6402:2345:b0:698:1504:e3d9 with SMTP id
 4fb4d7f45d1cf-69ab44a23f9mr2196012a12.29.1783548990464; 
 Wed, 08 Jul 2026 15:16:30 -0700 (PDT)
Received: from dobby ([2a02:8109:a394:4800:2200:181c:eef9:4c12])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19d786e7sm9059237a12.16.2026.07.08.15.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 15:16:30 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: dlemoal@kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 cassel@kernel.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v14 4/6] virtio-blk: do not merge writes across a zone boundary
Date: Thu,  9 Jul 2026 00:16:13 +0200
Message-ID: <20260708221615.346155-5-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708221615.346155-1-faithilikerun@gmail.com>
References: <20260708221615.346155-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x52a.google.com
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

virtio_blk_submit_multireq() fuses adjacent in-zone requests into a
single request. On a zoned backend, a merged zone append request
that straddles a zone boundary is rejected by the device because
each write must stay within a single zone.

Add a bail condition to the merge coalescer: if combining the
candidate request into the current batch would cross a zone
boundary, flush the current batch and start a new one.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
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
index 6b92066aff..f74cc3dbd0 100644
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
+             * On zoned backends, a single backend write/read must not span
+             * a zone boundary. Bail out of merging if combining req into
+             * the current batch would straddle a zone.
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


