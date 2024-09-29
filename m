Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AF3CF6495
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 16:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suwP1-00009k-I5; Sun, 29 Sep 2024 12:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1suwP0-0008VY-14; Sun, 29 Sep 2024 12:04:06 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1suwOy-00057i-BW; Sun, 29 Sep 2024 12:04:05 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c40aea5c40so6513937a12.0; 
 Sun, 29 Sep 2024 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727625841; x=1728230641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lMzdzxwmN9M0KYd61XXSbXjg6SJn18G3c36++7kZssg=;
 b=N4Fk/YcK+W43FGSf6gQ3E52/yMvtK6Kdnl+CX9ly4/VaRGySXdwH8q/0rN/q0LLTFv
 tpBmoverFqiy6HDbMi/zz+Ymt+Kpy+kn+2l2qggj7+9oaRXetXIk8i8GDo6vhqqX3Cra
 ON7jGNAyQQyzYOwc3QZBQ6/GpgOq6tk15+jvM9wzNKRkkFE2rXqaFp5rTN/Tw55d70/4
 LptCJ1rkeomi19rTPa6SUP1GsBzzK2bQPy1mJfBa3SBKw2UkY1VJdYnEVziLgzECcQzH
 uTHsdIlTYFYLIAJjwnKkdIsqqfyRJVRTMUtUQjU0mHd8udS1xtFZn9g5B8dv/CqELm8S
 2PKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727625841; x=1728230641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lMzdzxwmN9M0KYd61XXSbXjg6SJn18G3c36++7kZssg=;
 b=jHkwvBKrqK0CAuMS232GN7igJxU2fCx934WfHTQBWXDPtBvwH2FrkCs07LdFSW1twF
 9A2gL6XeEnVr1Y29pJhq1T9MckA837RRLs2GGfySB3HpV/vchkAn1aUdVl4It9gyjqPw
 72DBHAgr7j2Ik1Ca890cJ5ud0V6ZyNid3ULPc1F1CC41QfJ7Cn2O2NkP8a299wahCHB+
 p46+8vz6YDxX6YrGQPtwn0GDn8b0KhOrgIJb6TD0hKJAtb1xKDbe2bexdatryBtFdvCC
 Q0QNCJb94pRxnTrmDPpOiAB2tYbUX5IDkUzRXkSzCA5uu3NaYfqioqMig6NnDHv4MSvu
 83lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyFg8GmOdwBCsUlh8nhgkdpp9uMNLEhkQBt2K2VEPha5BwqUCvNMs1TFZA+odCtdMDm/nHrRh3wjv8@nongnu.org
X-Gm-Message-State: AOJu0Yx+kR9ExF4W3frA+JgxiCPT7UPZjfRaCdwQQgSYEXSI507IkkPH
 /eZdFkIbEZcKKSwBcQrve80ei0Fj7bDA05oDbfIsn8QQJnOuamQDRPRsSt2t
X-Google-Smtp-Source: AGHT+IHTjuBf9D0NVk/62yMdRfWG67UhfFltyyBT8C4oJ90RfswVM9MNMAgVfbLUEi3f/UaDIkEWbw==
X-Received: by 2002:a05:6402:2424:b0:5c4:1c89:6e36 with SMTP id
 4fb4d7f45d1cf-5c8777f3231mr14828881a12.19.1727625841171; 
 Sun, 29 Sep 2024 09:04:01 -0700 (PDT)
Received: from groves.fkb.profitbricks.net
 (ip5f5af605.dynamic.kabel-deutschland.de. [95.90.246.5])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c88245eb15sm3325666a12.49.2024.09.29.09.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 09:04:00 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 dmitry.fomichev@wdc.com, dlemoal@kernel.org,
 Hanna Reitz <hreitz@redhat.com>, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH] block/file-posix: optimize append write
Date: Sun, 29 Sep 2024 18:03:59 +0200
Message-Id: <20240929160359.581141-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 block/file-posix.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index ff928b5e85..64a57fadb1 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2489,11 +2489,19 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr,
 #if defined(CONFIG_BLKZONED)
     if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) &&
         bs->bl.zoned != BLK_Z_NONE) {
-        qemu_co_mutex_lock(&bs->wps->colock);
+        BlockZoneWps *wps = bs->wps;
+        int index = offset / bs->bl.zone_size;
+        qemu_co_mutex_lock(&wps->colock);
+        uint64_t *wp = &wps->wp[index];
         if (type & QEMU_AIO_ZONE_APPEND) {
-            int index = offset / bs->bl.zone_size;
-            offset = bs->wps->wp[index];
+            offset = *wp;
+            *offset_ptr = offset;
+        }
+        /* Advance the wp if needed */
+        if (offset + bytes > *wp) {
+            *wp = offset + bytes;
         }
+        qemu_co_mutex_unlock(&bs->wps->colock);
     }
 #endif
 
@@ -2540,28 +2548,19 @@ out:
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


