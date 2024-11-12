Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA54D597C6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 02:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB2gp-0001jR-Pr; Tue, 12 Nov 2024 21:01:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <takeshibaconsuzuki@gmail.com>)
 id 1tB0OP-0001Df-1n; Tue, 12 Nov 2024 18:33:53 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <takeshibaconsuzuki@gmail.com>)
 id 1tB0ON-0008ST-Dz; Tue, 12 Nov 2024 18:33:52 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-720be27db27so5278124b3a.2; 
 Tue, 12 Nov 2024 15:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731454429; x=1732059229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ZKQm9QTjhjenwlOdsFZFETQY1lUeJmGy2cUTCKP0i4=;
 b=KkFond4etmfKhy2TB7gjrWuAO5EyRT6BpXZ21ii8XQ/tByTPRaAW24PTk1HOjwIssr
 H2QrxWfY9tNiAk5ddMgSRUabzukwTLknLaEi+qzB2EdfWc+S+aonKt2eKSjdwqlUDvit
 ct1x8unuf9d9GCBA2s+5wwUrjgxmXcg1IgKya1NR9ubTqKfeHyxBqNicQrgf/yag/Au7
 lCoIyseTxoCkVcEbFw1anRlAvatXhHqflfW97w16m60in4Su9zY2twovk+IPbzxcni4c
 m5+au2hqgEApVATMrR+Gt6mR+PFZ8kQUh0UwfCGwTavr8uCkqyxsz5iN9hXHZ7UI7QLX
 TPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731454429; x=1732059229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ZKQm9QTjhjenwlOdsFZFETQY1lUeJmGy2cUTCKP0i4=;
 b=Ui1nhcb6rZh2a6BkJqMj8vY5ATa+U58ddaYnsY+TKidPAU+Ai6T0dEWrSSPv28PaBj
 bip9ZsYiqniQ3u9qYQnCCh+zZOwlkTm6QoyoeODKX1pmC6nD8U3wqil5+ebRzhA8OOvj
 3flhSuytTOAxrHMHqpZJBpQ9LNjUd+yckP81Nja5Bg9Ski0T/dnB0jJ+lSnUAKWdi0zJ
 8FOmDUFXAub92aPnrbUHudhZ+OlfBAg6KR/2cyhARSX6/vl6mhBfCW0rTTC68LTUjPlc
 7rciUGceyOKm65bGg7vSNhSPu5xIWuaC5AB+AHJYTQCN0DM3y8RHoK2yBHrBYt5YQZT7
 dydA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpFQplmsII61kY+1ebjLcO9dRm66Upfv/2Ii+VNP24C6bKrpyBD1/irrw8xFIiKXC0IcWH7Ge6hF+X@nongnu.org
X-Gm-Message-State: AOJu0YzyBadCV3yaLXDLEx24GtEL6tHZOc5mGo8oy4Efnn5Gp5qko/mw
 Jr5ZY7XTuiZ2Rx/owI/jHIk/dj+MLGOww0NEWFI+/9h5+76UgZr8xxNM3GLUr5Q=
X-Google-Smtp-Source: AGHT+IHtUOYYO4q6H/+jATIALOHzE7kJqlLHKzIO0bJldg6akibAKoVu6DW/i+w2QgxatOlvBdUJ6g==
X-Received: by 2002:a05:6a00:2441:b0:71e:6bf1:158f with SMTP id
 d2e1a72fcca58-7244a5d3ad6mr6002093b3a.21.1731454428911; 
 Tue, 12 Nov 2024 15:33:48 -0800 (PST)
Received: from localhost.colo.rubrik.com ([104.171.196.13])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078bfccfsm11963033b3a.82.2024.11.12.15.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 15:33:48 -0800 (PST)
From: Takeshi Suzuki <takeshibaconsuzuki@gmail.com>
To: qemu-devel@nongnu.org
Cc: codyprime@gmail.com, kwolf@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org, Takeshi Suzuki <takeshibaconsuzuki@gmail.com>
Subject: [PATCH 1/2] Add RW support for 4k sector size vhdx
Date: Tue, 12 Nov 2024 23:33:03 +0000
Message-Id: <20241112233304.3300-2-takeshibaconsuzuki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112233304.3300-1-takeshibaconsuzuki@gmail.com>
References: <20241112233304.3300-1-takeshibaconsuzuki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=takeshibaconsuzuki@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Nov 2024 21:01:02 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Takeshi Suzuki <takeshibaconsuzuki@gmail.com>
---
 block/vhdx.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 70 insertions(+), 6 deletions(-)

diff --git a/block/vhdx.c b/block/vhdx.c
index 5aa1a13506..495ddc2815 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -824,8 +824,8 @@ vhdx_parse_metadata(BlockDriverState *bs, BDRVVHDXState *s)
         goto exit;
     }
 
-    /* Currently we only support 512 */
-    if (s->logical_sector_size != 512) {
+    /* Currently we only support 512 and 4096 */
+    if (s->logical_sector_size != 512 && s->logical_sector_size != 4096) {
         ret = -ENOTSUP;
         goto exit;
     }
@@ -1060,7 +1060,7 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
 
     /* the VHDX spec dictates that virtual_disk_size is always a multiple of
      * logical_sector_size */
-    bs->total_sectors = s->virtual_disk_size >> s->logical_sector_size_bits;
+    bs->total_sectors = s->virtual_disk_size >> BDRV_SECTOR_BITS;
 
     vhdx_calc_bat_entries(s);
 
@@ -1178,11 +1178,52 @@ vhdx_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 }
 
 
+/*
+ * Converts bdrv sectors to sectors of s->logical_sector_size.
+ */
+static void bdrv_sectors_to_sectors(const int64_t bdrv_sector_num,
+                                    const int bdrv_nb_sectors,
+                                    const BDRVVHDXState *const s,
+                                    int64_t * const out_sector_num,
+                                    int * const out_nb_sectors,
+                                    /* in bytes */
+                                    int * const out_begin_skip,
+                                    /* in bytes */
+                                    int * const out_end_skip) {
+    if (bdrv_nb_sectors == 0) {
+        *out_nb_sectors = 0;
+        return;
+    }
+    const int64_t begin_off = bdrv_sector_num * BDRV_SECTOR_SIZE;
+    const int64_t sector_num = begin_off >> s->logical_sector_size_bits;
+    const int begin_skip = begin_off - sector_num * s->logical_sector_size;
+    const int64_t end_off = (bdrv_sector_num + bdrv_nb_sectors) *
+                            BDRV_SECTOR_SIZE;
+    const int64_t end_sector_num = (end_off + s->logical_sector_size - 1) >>
+                                   s->logical_sector_size_bits;
+    const int end_skip = end_sector_num * s->logical_sector_size - end_off;
+    const int nb_sectors = end_sector_num - sector_num;
+    *out_sector_num = sector_num;
+    *out_nb_sectors = nb_sectors;
+    *out_begin_skip = begin_skip;
+    *out_end_skip = end_skip;
+}
+
+
 static int coroutine_fn GRAPH_RDLOCK
 vhdx_co_readv(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
               QEMUIOVector *qiov)
 {
     BDRVVHDXState *s = bs->opaque;
+    int begin_skip, end_skip;
+    bdrv_sectors_to_sectors(sector_num,
+                            nb_sectors,
+                            s,
+                            &sector_num,
+                            &nb_sectors,
+                            &begin_skip,
+                            &end_skip);
+
     int ret = 0;
     VHDXSectorInfo sinfo;
     uint64_t bytes_done = 0;
@@ -1216,9 +1257,16 @@ vhdx_co_readv(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
                 qemu_iovec_memset(&hd_qiov, 0, 0, sinfo.bytes_avail);
                 break;
             case PAYLOAD_BLOCK_FULLY_PRESENT:
+                if (bytes_done == 0) {
+                    sinfo.file_offset += begin_skip;
+                    sinfo.bytes_avail -= begin_skip;
+                }
+                if (nb_sectors - sinfo.sectors_avail <= 0) {
+                    sinfo.bytes_avail -= end_skip;
+                }
                 qemu_co_mutex_unlock(&s->lock);
                 ret = bdrv_co_preadv(bs->file, sinfo.file_offset,
-                                     sinfo.sectors_avail * BDRV_SECTOR_SIZE,
+                                     sinfo.bytes_avail,
                                      &hd_qiov, 0);
                 qemu_co_mutex_lock(&s->lock);
                 if (ret < 0) {
@@ -1336,8 +1384,17 @@ static int coroutine_fn GRAPH_RDLOCK
 vhdx_co_writev(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
                QEMUIOVector *qiov, int flags)
 {
-    int ret = -ENOTSUP;
     BDRVVHDXState *s = bs->opaque;
+    int begin_skip, end_skip;
+    bdrv_sectors_to_sectors(sector_num,
+                            nb_sectors,
+                            s,
+                            &sector_num,
+                            &nb_sectors,
+                            &begin_skip,
+                            &end_skip);
+
+    int ret = -ENOTSUP;
     VHDXSectorInfo sinfo;
     uint64_t bytes_done = 0;
     uint64_t bat_entry = 0;
@@ -1451,9 +1508,16 @@ vhdx_co_writev(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
                                       sinfo.bytes_avail);
                 }
                 /* block exists, so we can just overwrite it */
+                if (bytes_done == 0) {
+                    sinfo.file_offset += begin_skip;
+                    sinfo.bytes_avail -= begin_skip;
+                }
+                if (nb_sectors - sinfo.sectors_avail <= 0) {
+                    sinfo.bytes_avail -= end_skip;
+                }
                 qemu_co_mutex_unlock(&s->lock);
                 ret = bdrv_co_pwritev(bs->file, sinfo.file_offset,
-                                      sectors_to_write * BDRV_SECTOR_SIZE,
+                                      sinfo.bytes_avail,
                                       &hd_qiov, 0);
                 qemu_co_mutex_lock(&s->lock);
                 if (ret < 0) {
-- 
2.34.1


