Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2D9C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6Pm-0008Cf-On; Fri, 26 Jun 2026 09:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wd6Pi-0008Bl-BA
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:16:10 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wd6Pf-0000zz-DH
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:16:08 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49222fb062bso10049495e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 06:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782479766; x=1783084566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FtXZ27SLy65lCTtPsnWgrQRf4nL5oIDYBfojUKHflv4=;
 b=kJXTuUb2cBbgPe9ubDI/j/npr3z41/KyZIoNTia159DsnVd77zptCB0YO2w8mwCcer
 MnexDPdhlx/Zi0HES16MERHSasfG//qF3wYjVU2aoUWgsMdNRKQlvfccAtGDvGyPOq6Q
 OG7/idzfN2p7xxqCP3bwCowMKsFAZGfezU0xeAhZ+pHhtuJn9/joN6v5Slmrbm21UgQt
 ELRsVbPVGSZie5v3pFxAc92JcbccOErddjLEqWG9jAl1wD6IDLgZcIBwEkJ4/eFlOPTq
 sZumB7TD0J/+y26UP9M2/nK7E8j3gkkiq6DWDvcPBDWe8ucimeMGdhIcZHukB4vHhUGs
 uZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782479766; x=1783084566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FtXZ27SLy65lCTtPsnWgrQRf4nL5oIDYBfojUKHflv4=;
 b=srakWCIrQquWg7zXDpNC6kElLwwh/P8XPFkwqjEumSvGBtGT/oSWKC9oF7YanaSJPu
 R7vf9yhdGmT3Z0MFKJI6H3df8RKy/NYZA1HhB/etauo9XnPi/vK+qhiKnmKVsvklqCxH
 /8ydUTVMEpjXiZ0M+XhgsAMDW0tpdElChHpx4X4z4GipjsPANtDv1ElrGBDEIhnkfEYG
 zuTJVSJGfaX9Fi6urV2CJV3KK5J5kHgHS9nGiO8cGzU3PC284FRB5N5pnSojtFB/jWbE
 bqior/Nfe3bBW8h7WSSPcwtG2XxAwkLimPLKm9NylBXgLkj5UtQKt8+jnwIZrIsNQXxb
 H8+Q==
X-Gm-Message-State: AOJu0YxnOJwd03bjQobGHRDDPE1PBVBxyWteCiL9gl0MRfpnynm5fPJC
 NYuA8imyN0xELHmdGO3VB8GtyeeCuPDQ0iD+PEuU2U48bW2iiyBotXg4jk1wPQ==
X-Gm-Gg: AfdE7ckzAboN8DbqwEpp1qRL0AJyJetzybdh6O+tcViswPsRhicgAIF/Q2hqdwwRIAL
 GRpa6ts0bNHCkVO+M1A7sD+Tb6UMmZq83NrFsgMcahhxizY98huY4BA34AOYFe0JcE9M/xGwbwb
 7cFksM7dbAEeI97F68dUUfTXvFKsaiDj+9hX2uSAf49w9uLJu6G04rtEojbrZErfWUni/qT9bA0
 OrpjTn0EFuklXw95QCKcW6Eg0BUUNGoKyLhXfBTe4ioUarsXZKWsQyi66MeCx8IGp3VxzOBce3t
 +d9bmCfZTGHoihbObYpr+vOBxteNRoMF+cz4XgHo8MrD3ZkjZMrewcsjY5RZgTvX+Fg7BSAc9Nz
 G21Ci6qaUq4BwtvcwkT9N7yyIfJGgsqr0gE3lCoTIvqmayn0AlPlh5/3XXUwNGGod7OcfUmGOyZ
 tFHwu4FvPaewwFg0/hXXaMuDX+5cefsNOoo+LcXpbjo3jjzVQthAejkGum
X-Received: by 2002:a05:600c:1d18:b0:492:2100:aba2 with SMTP id
 5b1f17b1804b1-49266855475mr99599345e9.4.1782479765859; 
 Fri, 26 Jun 2026 06:16:05 -0700 (PDT)
Received: from dobby ([2a02:8109:a394:4800:b369:c9c1:81a0:4afc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c2279b83fsm26093756f8f.29.2026.06.26.06.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 06:16:05 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 cassel@kernel.org, dlemoal@kernel.org, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v13 4/6] virtio-blk: do not merge writes across a zone boundary
Date: Fri, 26 Jun 2026 15:15:53 +0200
Message-ID: <20260626131555.459792-5-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626131555.459792-1-faithilikerun@gmail.com>
References: <20260626131555.459792-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=faithilikerun@gmail.com; helo=mail-wm1-x32e.google.com
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


