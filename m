Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEE8CFA763
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 10:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swfkd-0000t7-OT; Fri, 04 Oct 2024 06:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1swfkZ-0000s4-V0; Fri, 04 Oct 2024 06:41:33 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1swfkX-0000rK-C4; Fri, 04 Oct 2024 06:41:31 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5399041167cso3338063e87.0; 
 Fri, 04 Oct 2024 03:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728038486; x=1728643286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EzmNniEEaXfyrXtu1QTNsGBYtqLnFuu4u/DabLdzTuM=;
 b=MeLoSV81QCS3SCkwbVR2WfkHsgQ10YlZ3VYj4MigbFAAAUBVe9jZq3X4tnQkWdmSEW
 UJDb8Uus95ATcKgU9bXswD3q4csD6PU/zBd6ooIMpPp7UuWr6rbd5CfW0OijTDb1TNH+
 Ilma5oKPn6XgBTGlYmm8sIapx05g+s3poPL29AmpzsehB2gVXpBXoVUYBjH6OtT+PzrH
 AzmiqpcLASz0ie5KzMgAmQf470gS8nSzztvCVHKV35ghHpnBkUNXHXJW9UnbBfl1qT4g
 4LBdMudE9nBiKaiv3bfp2cd/HFrhPKXyohfTHKN6KmwjOA+CX0haX+TAf9rwUZQFFu1K
 QiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728038486; x=1728643286;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EzmNniEEaXfyrXtu1QTNsGBYtqLnFuu4u/DabLdzTuM=;
 b=F/dHxTQ6XAAQMOwuQPjqznnKfWe3lrgMq+SrZ7QsbuIDvGX2XIlWPvoFLAsnWyMkni
 6F6KJ/Lkj2kSnquETUu6+BL6gPgN9zGZRQMF60gsqdmOhv/Vh3MWowCpbj3WLs1Sf1X6
 NG32aWvmknstTf7r6eRannsWSvrVwC6EbvJie1SHl+DDc283l6S6fx5rqpMRh2x/TQDe
 UtUg6vYmmFwg4Fh/yGNoPRdgEDGZG55xB94FmMOhoVBycGJ4UhB1+5LWU1hy7QSIX/jI
 Ip3WN4agBxp9HwkH2hLPsgTS08Ue/lBfmf00UD/wCiu+GtMEf+i8A7moo76xP+dsHYsD
 jjgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTyMm7ByhrDBOGyylZhR+qN7dz/1rlHNhuEWd0lIOTDkMRyQJET8GtqsAFpPwr0a2rtH/k26vHZTtc@nongnu.org
X-Gm-Message-State: AOJu0Yy/O/bqokWmCJswxdSf9zQBjr3qVTzobHN6wzf5Cl14SUFOdHEp
 AUNQ0uBJ9rsIgT5kTh+4R9aeuPZ278xzDU8hkxytSGZSRUR1Bty4eQ6Tjy8t
X-Google-Smtp-Source: AGHT+IHDTCjdb0xmKaF0m/kxstEVtL57fNph0S0Xxw/DSzNPi0pqV3NB34A72J+U2phsNQKtdiTM2A==
X-Received: by 2002:a05:6512:e93:b0:539:947e:18a6 with SMTP id
 2adb3069b0e04-539ab9cf223mr2117742e87.47.1728038485462; 
 Fri, 04 Oct 2024 03:41:25 -0700 (PDT)
Received: from groves.fkb.profitbricks.net ([95.90.246.5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99104762b6sm207098866b.159.2024.10.04.03.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 03:41:25 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, stefanha@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com,
 qemu-block@nongnu.org, dlemoal@kernel.org, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v2] block/file-posix: optimize append write
Date: Fri,  4 Oct 2024 12:41:23 +0200
Message-Id: <20241004104123.236457-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=faithilikerun@gmail.com; helo=mail-lf1-x135.google.com
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

When the file-posix driver emulates append write, it holds the lock
whenever accessing wp, which limits the IO queue depth to one.

The write IO flow can be optimized to allow concurrent writes. The lock
is held in two cases:
1. Assumed that the write IO succeeds, update the wp before issuing the
write.
2. If the write IO fails, report that zone and use the reported value
as the current wp.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/file-posix.c | 57 ++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 90fa54352c..a65a23cb2c 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2482,18 +2482,46 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr,
     BDRVRawState *s = bs->opaque;
     RawPosixAIOData acb;
     int ret;
-    uint64_t offset = *offset_ptr;
+    uint64_t end_offset, end_zone, offset = *offset_ptr;
+    uint64_t *wp;
 
     if (fd_open(bs) < 0)
         return -EIO;
 #if defined(CONFIG_BLKZONED)
     if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) &&
         bs->bl.zoned != BLK_Z_NONE) {
-        qemu_co_mutex_lock(&bs->wps->colock);
-        if (type & QEMU_AIO_ZONE_APPEND) {
-            int index = offset / bs->bl.zone_size;
-            offset = bs->wps->wp[index];
+        BlockZoneWps *wps = bs->wps;
+        int index = offset / bs->bl.zone_size;
+
+        qemu_co_mutex_lock(&wps->colock);
+        wp = &wps->wp[index];
+        if (!BDRV_ZT_IS_CONV(*wp)) {
+            if (type & QEMU_AIO_WRITE && offset != *wp) {
+                error_report("write offset 0x%" PRIx64 " is not equal to the wp"
+                             " of zone[%d] 0x%" PRIx64 "", offset, index, *wp);
+                qemu_co_mutex_unlock(&wps->colock);
+                return -EINVAL;
+            }
+
+            if (type & QEMU_AIO_ZONE_APPEND) {
+                offset = *wp;
+                *offset_ptr = offset;
+            }
+
+            end_offset = offset + bytes;
+            end_zone = (index + 1) * bs->bl.zone_size;
+            if (end_offset > end_zone) {
+                error_report("write exceeds zone boundary with end_offset "
+                             "%" PRIu64 ", end_zone %" PRIu64 "",
+                             end_offset, end_zone);
+                qemu_co_mutex_unlock(&wps->colock);
+                return -EINVAL;
+            }
+
+            /* Advance the wp */
+            *wp = end_offset;
         }
+        qemu_co_mutex_unlock(&bs->wps->colock);
     }
 #endif
 
@@ -2540,28 +2568,19 @@ out:
 #if defined(CONFIG_BLKZONED)
     if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) &&
         bs->bl.zoned != BLK_Z_NONE) {
-        BlockZoneWps *wps = bs->wps;
         if (ret == 0) {
-            uint64_t *wp = &wps->wp[offset / bs->bl.zone_size];
-            if (!BDRV_ZT_IS_CONV(*wp)) {
-                if (type & QEMU_AIO_ZONE_APPEND) {
-                    *offset_ptr = *wp;
-                    trace_zbd_zone_append_complete(bs, *offset_ptr
-                        >> BDRV_SECTOR_BITS);
-                }
-                /* Advance the wp if needed */
-                if (offset + bytes > *wp) {
-                    *wp = offset + bytes;
-                }
+            if (type & QEMU_AIO_ZONE_APPEND) {
+                trace_zbd_zone_append_complete(bs, *offset_ptr
+                    >> BDRV_SECTOR_BITS);
             }
         } else {
+            qemu_co_mutex_lock(&bs->wps->colock);
             /*
              * write and append write are not allowed to cross zone boundaries
              */
             update_zones_wp(bs, s->fd, offset, 1);
+            qemu_co_mutex_unlock(&bs->wps->colock);
         }
-
-        qemu_co_mutex_unlock(&wps->colock);
     }
 #endif
     return ret;
-- 
2.34.1


