Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B3DC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzxqQ-0002l5-I3; Fri, 28 Aug 2026 10:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzxqP-0002kd-2E
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 10:46:13 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzxqN-0000iQ-BP
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 10:46:12 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so10155935e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 07:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787928370; x=1788533170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fkEN44L0ZdFVpa/GxkjZduejqvJWgpOrsGopU0sTJpY=;
 b=n028BXODmqCWbmkkQ06TTfF0vzL1uYwcKCCKA8afQYOLZgNeTFt8XCYwtSj7zJiapm
 zfz8YnxKnIE+9ohgRjv3ZwJoGe1wILmFPxXR8MhmNW0xm7FQtpDlU3aTKskfxXha5ldT
 1NJ9JUdyaOueVhiNQy7ESpl7xMs9Sff2ZPyA7TrztnxTHhxdQxPmJ3je96BgOj5lUz4j
 GQVvdvaj9szXFWpfsTQ0OMiBy5d3b0fbG8efhNwWbwgcf1CP8X9+DFGdeZ7PvMrtfbtk
 5HuG4XwOt6kq0wWq212r3323Y8w1DltgDxZk2SoSxvkhMPazPWXte1c9vFnoN5uX63Tn
 MQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787928370; x=1788533170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fkEN44L0ZdFVpa/GxkjZduejqvJWgpOrsGopU0sTJpY=;
 b=n6PzrcOh7VvpQEB6Kf8AMEXlTe0vYU2cx+wLy0jUFJFaHdkh0Syha5AQORzVfqvdI+
 XRkukz7bYxDyhAScJxtxxmfi3OuZtmj/ccYV/Prcq7txiTpz2zgeRliYJ8xzYoVJj9cc
 Jba3yM91W5CrOVsk3QyYMzJeBJyCcIDimsGGwv1XgkCTwVQSZtn6T3JX7c0SX6P9fBP/
 9vctmlNUb3D8jg9xbkcp1o9Ek5dINjSIDoic2mJgYlEwvsf0oJ72pnOx2KA36QRng6Fm
 0dDESyWpLrpSkIgM1s5UDkzX/vq7+OvnEXkEs+tGR3j5dn85Nm7k0zCOHizmmZQmtT1X
 tO+g==
X-Gm-Message-State: AFuF++lOZiUWcMbOwqLdar26EHyLxJRCyt7FNn3wXa7j2nhUG5iC8Zq9
 +3px1kCAtvjGhdMdPNBzY+BQ0qAgN3jQowjcoGyN0aku5EpRM3R0QWNFJBmWg2K8sHdvfGcA9G6
 1tmCS
X-Gm-Gg: AR+sD12T5QnmpWOXpdk9nlZdhB/h9c8i0sESJ2UpUkoDfbGSJn8s+aVCS5TmqTV2C2A
 rDexMjpIN3asylT0AT0vHQPAW4h29dZJhFKhf4orck0gsJwUUEq4Do63iwwmoctk7g3qWC0eejV
 IDqKvrhjKhso5SuX784K3MCEgsvZEsLrJz2lK2V6Lhqer3mjC+DYQ24TW3TmzUL1ORJ0Ss9sbH5
 qE1Mj8X/1ah5/+1aZT55yScewhzkeYACB1iz6YSZtMTA9ZP1ScxSGa5FO5UN22nCeme3+DxzBTB
 +xFD1t5reMHRqKxTBF69hEklgr63FeKuxO8H138hcJplkSquNvFmGfbgqGbDikPOpBdNrhrYdIf
 xfNZFw61Wz1qHxWriPbOI2QKsgM44Pv4XhxtLZH5X/yJbcSXtUlFOj0dUnkKsERrh3hSgDEmHgr
 8ab0VpJbXxtv3KFXgGvFqo51bALpjuDVltIMfiYiV6nzMiy3JAYAWyIngmCMHSjh40+vMi
X-Received: by 2002:a05:600c:6388:b0:499:d95a:414 with SMTP id
 5b1f17b1804b1-49b91c26a17mr128752355e9.6.1787928369725; 
 Fri, 28 Aug 2026 07:46:09 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9458:da19:ab04:373a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b94dcaf61sm53730925e9.4.2026.08.28.07.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:46:09 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 9/9] block/block-copy: coalesce write-zeroes tasks
Date: Fri, 28 Aug 2026 16:45:54 +0200
Message-ID: <20260828144554.1741910-10-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828144554.1741910-1-den@openvz.org>
References: <20260828144554.1741910-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=den@openvz.org; helo=mail-wm1-x330.google.com
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

Task size was capped to block_copy_chunk_size() regardless of method,
which sizes a task by the copy buffer. A write-zeroes task carries no
buffer, so that cap only splits one long known-zero run into a crowd of
small COPY_WRITE_ZEROES tasks, each with its own request against the
target.

block_copy_task_create() already decides from zero_bitmap how far a task
may run, so add block_copy_widen_zero_area() to that decision: for a
write-zeroes task, re-search the dirty area under
BLOCK_COPY_MAX_ZERO_CHUNK instead of the buffer chunk size, and let the
existing clamp cut it back to where the zero run ends. Widening is safe:
an overlapping caller waits on the task's BlockReq via
reqlist_wait_one() rather than observing it mid-flight.

The 256M cap stays well under BDRV_REQUEST_MAX_BYTES, where
block_copy_do_copy() would trip assert(nbytes < INT_MAX), keeps the rate
limiter usable, leaves enough tasks to fill BLOCK_COPY_MAX_WORKERS and
bounds how long a cancel waits on one request. It is aligned at the use
site rather than in the constant, since nothing bounds cluster_size.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/block-copy.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/block/block-copy.c b/block/block-copy.c
index c0a3359938..16b76484cb 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -37,6 +37,8 @@
 #define BLOCK_COPY_MAX_WORKERS 64
 #define BLOCK_COPY_SLICE_TIME 100000000ULL /* ns */
 #define BLOCK_COPY_CLUSTER_SIZE_DEFAULT (1 << 16)
+/* Bounded by BDRV_REQUEST_MAX_BYTES, rate limiting and cancel latency. */
+#define BLOCK_COPY_MAX_ZERO_CHUNK (256 * MiB)
 
 typedef enum {
     COPY_READ_WRITE_CLUSTER,
@@ -187,6 +189,34 @@ static int64_t block_copy_chunk_size(BlockCopyState *s)
     }
 }
 
+/*
+ * A write-zeroes task carries no buffer, so it may cover far more than
+ * block_copy_chunk_size(). Return how far it may run; the caller clamps it
+ * to where the zero run ends.
+ */
+static int64_t block_copy_widen_zero_area(BlockCopyState *s,
+                                          BlockCopyCallState *call_state,
+                                          int64_t offset, int64_t search_end,
+                                          int64_t bytes)
+{
+    int64_t aligned = QEMU_ALIGN_DOWN(BLOCK_COPY_MAX_ZERO_CHUNK,
+                                      s->cluster_size);
+    int64_t zero_chunk = MIN_NON_ZERO(MAX(aligned, s->cluster_size),
+                                      call_state->max_chunk);
+    int64_t wide_offset, wide_bytes;
+
+    if (!bdrv_dirty_bitmap_next_dirty_area(s->copy_bitmap, offset, search_end,
+                                           zero_chunk, &wide_offset,
+                                           &wide_bytes)) {
+        return bytes;
+    }
+
+    /* @offset is dirty, so the search cannot have moved past it. */
+    assert(wide_offset == offset);
+
+    return wide_bytes;
+}
+
 /*
  * Search for the first dirty area in offset/bytes range and create task at
  * the beginning of it.
@@ -198,6 +228,7 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
     BlockCopyTask *task;
     BlockCopyMethod method;
     int64_t max_chunk;
+    int64_t search_end = offset + bytes;
 
     QEMU_LOCK_GUARD(&s->lock);
     max_chunk = MIN_NON_ZERO(block_copy_chunk_size(s), call_state->max_chunk);
@@ -219,6 +250,8 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
 
         if (hbitmap_get(s->zero_bitmap, offset)) {
             method = COPY_WRITE_ZEROES;
+            bytes = block_copy_widen_zero_area(s, call_state, offset,
+                                               search_end, bytes);
             boundary = hbitmap_next_zero(s->zero_bitmap, offset, bytes);
         } else {
             boundary = hbitmap_next_dirty(s->zero_bitmap, offset, bytes);
-- 
2.53.0


