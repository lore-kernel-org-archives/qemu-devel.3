Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B28CD6E60
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 21:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUAQm-0002Ye-9H; Mon, 01 Jun 2026 17:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wUAQl-0002Xh-40
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:44:19 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wUAQi-0001nq-0b
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:44:18 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-45fd461e4a5so1700669f8f.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 14:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780350254; x=1780955054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkGmmtRQ4zWE64vzPoxrlG6z73EWWdlclKzKztcMn94=;
 b=kvOPLJra5RRpL19dCIjf/6dhm6/wF9IU+zobszNlbEWraBc02e6DqWdNMP5MB2sPdB
 PYNTbyPcImisBDz3ktuaotG2emR1dX7z85BcJaFqJYTAmOooTAIvJdxOdvPE6FLpu5Os
 RkeGt9LmvGDKx64R8P/UrqoythWCyCO5ydfsNlAibfkGnj76jDhwcskhyjm+MWJhx+u9
 OwbdHbACCP69bdO3AU7Pso1N5S8RH+jJk2loXgObdlR2etHKYRBzxqyT2URK4GsXrp68
 ja7qJnRbMbrcM5yot4czxEZu1oU1cQkycmZCzWjWhT5hSZ96NG0rxiACuRoa1qkEp5XV
 yUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780350254; x=1780955054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HkGmmtRQ4zWE64vzPoxrlG6z73EWWdlclKzKztcMn94=;
 b=Fy2uUbmtG3DlEE5Bfk7+YSEL7JNeHjxyfxvIQ8z+9BIATDMYCwVgheYVXCaZYjRY9+
 JGk0F/jZB9tgKJMPnXrchANt+YJzNqPgKG49MTD2nMZFhHwHRlR7zatg8PxYe59bFjpW
 YO6AFxx8Hnd3xGNH9R2/+cySzUYt/b5MZ4PxSy7ms/3YDbGVCoX5irTo43qcnHE5Ov5H
 TQlzjYymwFDqhMrTy0GAkNJ9PQJbSknbrlok0R9Mg7FLWMpEcjLsz3lGI724dZNQceZI
 splcZN18EElXHQBxWE1VBHsGzfUskB4i20gu7atgetrwAH4pWXzlLfcyD/w+C03Vi+XS
 NhuA==
X-Gm-Message-State: AOJu0Yxtfg/++tiAIIUrtpuDg1PANYbJNP9Pa7/Cei9eDHO5lnz+UdU8
 Ob6cQl3MI25SSKRQexsD0OGhQDS+yW99AwRHVqWAjnT2UdqOFYzXvsxKwRIiGuQScJA=
X-Gm-Gg: Acq92OGnM76raPgrLHrLbKakEMgCar4Tx1lG4IcPXJYTbjHgnnHGB17Ats73B6zbXpd
 sXB5p37rRwRHUBLS9sWCfSUc7pAZLZuPhFnRs2wrTJtyYJvYTE9eyf34R9M9WlL+VToNfBdCQJs
 jJ8iYo4KDMFGg4t1d/LXbjy6TZHVwGrAHIToDrH5Js8gzOiJxp30yMblSZzntUf/kU5YjMO7tzb
 FEGax7Dg5acjf80hhl+HXfnPo/oSXVCVUBdiXLL9i+S29b/2NbyfPbcrockp/z5PAF5ZXcTVOrF
 4Q3sqk1CSjo8YVuTJk8LXwq1EAO3fRQvP0TIaKxiS+f2GOT6WLUB3n0XPDPA4fW/GLge3nor8yw
 ZXX+aUiO0dUgLUgcT+/rsFKHT6pnRfckP/tdCcoL1MEsK3xU1HdFmQczZAp+p1hxoUcbP+YO1Hz
 quKYHjUl1nHYYtfEB5F/bgHIJX0M0JeUaau45MxklqG5SPlgXSY1tWlBmn5AYM/oxxQw==
X-Received: by 2002:a5d:648b:0:b0:45e:ec18:f20a with SMTP id
 ffacd0b85a97d-45ef6b8cefdmr18373265f8f.32.1780350254205; 
 Mon, 01 Jun 2026 14:44:14 -0700 (PDT)
Received: from dobby ([2a02:8109:a394:4800:595:8cac:dffc:932f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef356b129sm35423496f8f.32.2026.06.01.14.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 14:44:13 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 dmitry.fomichev@wdc.com, Hanna Reitz <hreitz@redhat.com>, hare@suse.de,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 cassel@kernel.org, dlemoal@kernel.org, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v11 3/5] virtio-blk: do not merge writes across a zone boundary
Date: Mon,  1 Jun 2026 23:44:03 +0200
Message-ID: <20260601214405.252818-4-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601214405.252818-1-faithilikerun@gmail.com>
References: <20260601214405.252818-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=faithilikerun@gmail.com; helo=mail-wr1-x430.google.com
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
 hw/block/virtio-blk.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9cb9f1fb2b..285db19ac7 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -288,6 +288,9 @@ static void virtio_blk_submit_multireq(VirtIOBlock *s, MultiReqBuffer *mrb)
     int i = 0, start = 0, num_reqs = 0, niov = 0, nb_sectors = 0;
     uint32_t max_transfer;
     int64_t sector_num = 0;
+    BlockDriverState *bs = blk_bs(s->blk);
+    bool zone_cross;
+    int64_t zone_sector, end_sector;
 
     if (mrb->num_reqs == 1) {
         submit_requests(s, mrb, 0, 1, -1);
@@ -303,17 +306,34 @@ static void virtio_blk_submit_multireq(VirtIOBlock *s, MultiReqBuffer *mrb)
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
+            if (bs && bs->bl.zone_size > 0) {
+                zone_sector = bs->bl.zone_size / BDRV_SECTOR_SIZE;
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
-- 
2.53.0


