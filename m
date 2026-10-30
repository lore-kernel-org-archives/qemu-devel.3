Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CACA606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=k0XHg3cW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMb4w-0002I2-Sf; Thu, 29 Oct 2026 21:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb4l-0002DK-HA
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:35 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb4h-0006FC-BQ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:32 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso160921f8f.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 18:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793322389; x=1793927189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fJ9DARarrY1aTYCtlvGS85iKEp5hs4edfrbJfuPj5Sg=;
 b=k0XHg3cW6lOZbNOaWhrBkG7iMg6VddxC5sYdUfx8gdhZJ4XU8Oww7GP11YF0YojmxU
 uDIkchiJNcelIy6I5iTahltxrnjRnDuaIX/euXnOt/w1W/8dE7O36+GckEcNmfs6nVaJ
 jJWBmB1Bn1BfQMYMKx6cOOwIPXYdVr6tofLChpZChLhtooo1Lt7n+5gmA8mY4QBHpcMe
 92vuan/TDCspG6XqlC/QH4zD9ZM+urcmXJAIx+a7M9wJUvCFihpxG7zR1jxQuDHdIMZs
 XgemZ4O1H/3yTUs04CvW9u/v9lgXNRrCdf0u1ZIKfIANPp+92i9oYKBSz/vwS66zUB++
 lI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793322389; x=1793927189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fJ9DARarrY1aTYCtlvGS85iKEp5hs4edfrbJfuPj5Sg=;
 b=uglTXnoFryBOFMUAMi73PtcTFTX0Ks5sB8YM883e8FRr8f9YYKoZklyTahlxYjDG5y
 gGSVyihiNzfWOR/tpZU4MOnIBNnLS1PiVi7Yv5OvS5VNSK8uNokAC/1CyC9Saeh/690j
 peZIJ5Bqbv6qdu7LzwvcTDQO+pLrSCnzFpZPN9E+pNav7amKngjF/QxZDJ4H+MRnYfub
 aEIltQRbz6qPTv1TWo+hvIbDSn7bodOw04oTbGm6LOoM00M44Tht8mxiuVQ//Prst0Yo
 UCS0ai200FKw3NhPTWIsdU8vKA4Bke83YItE7amw+M3+B4qc0nODp6cxvk60XYYC059E
 sinA==
X-Gm-Message-State: AFq9FYJrGs6PNqnIkdvwGBu41OHM1xJmDOG8zYzaZRU0rSoYL95+4yoh
 J/TjCwkqk7tSDs2pm57arkiCXqtKNrAsHojYEdil90B+918ix0pa5UL/WIQfI70VB/fRw5g2ceI
 /hPSZ
X-Gm-Gg: AYBFou2nt+MrS/MNWf5ApGcPLuNBirr5Q+YsifTmvH47QeTE0axvdZI71et6Cond/CR
 lHx52yaq/w4Q6aK2/vAxBpE6v07cqhql6N13afpyT5JOWArNYOxJFbuPNePLqNUw0sqLEzTFMc7
 mGZIDVgBb19Ve95BjydmDbORJRGgeCICBiJ/HIMtbKs5WcgDDEZsD1QyA03j03yYM59C/WjVW1x
 M15gSs/Qz4m3NK0K5vuT4RAEGV7toLh9RVyzcu8WBg0y26yCN9sas589gCQLON2NNOIWsFgfWx+
 98RXPyHNNKfd7Q34I2psFb4L+avFWQ0lLkpdsMVt5yMePawaDbGie1zZQbaAcP8B9PRF6+TTxid
 fPRYYs/8+E9iq1aQEQa7D2opVNm6jciobe4J8/seYYYn3hcIzf4eHm9yRWCQFreEfE/r/Eph1fU
 oPgvTJm95PfRIk+CeiW947KmozxqZfLwirVrIstcDSCU/JG4vxvhIkT/VnD9TSOo/0aDAj3S1e3
 gH2u6MzMblDY25nHQBG0C8q79NZxk3Loi+4LpShqqX1Wk+BBBcqexTcv7IR3RgdzVqfydzfL1Ci
 r62ARL2cb/o9zW3KGFhwa7y05YmneaSi4mOwbGI=
X-Received: by 2002:a5d:4391:0:b0:487:219e:5e20 with SMTP id
 ffacd0b85a97d-48e6e529631mr1474478f8f.51.1793322388584; 
 Thu, 29 Oct 2026 18:06:28 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f4be:f111:4ee0:40d3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80333sm210023f8f.32.2026.10.29.18.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 18:06:28 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v4 05/12] block/block-copy: extract
 block_copy_set_task_method()
Date: Fri, 30 Oct 2026 02:06:05 +0100
Message-ID: <20261030010613.1612771-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030010613.1612771-1-den@openvz.org>
References: <20261030010613.1612771-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=den@openvz.org; helo=mail-wr1-x430.google.com
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

Move the per-task block-status query and its skip_unallocated and
BDRV_BLOCK_ZERO handling out of block_copy_dirty_clusters() into
block_copy_set_task_method(). No behavior change. The next patch
changes that decision, and having it in one place keeps that change to
just the new logic.

The block-status result no longer lands in the caller's @ret, so drop
the note saying @ret may be positive at the out: label.

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/block-copy.c | 46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 1826c2e1c7..33c43cdf92 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -736,6 +736,35 @@ int64_t coroutine_fn block_copy_reset_unallocated(BlockCopyState *s,
     return ret;
 }
 
+/*
+ * Decide how @task is copied: COPY_WRITE_ZEROES if it reads as zero. May
+ * shrink @task. Returns false if @task is to be skipped (already ended,
+ * not freed).
+ */
+static bool coroutine_fn GRAPH_RDLOCK
+block_copy_set_task_method(BlockCopyState *s, BlockCopyTask *task)
+{
+    int ret;
+    int64_t status_bytes;
+
+    ret = block_copy_block_status(s, task->req.offset, task->req.bytes,
+                                  &status_bytes);
+    assert(ret >= 0); /* never fail */
+    if (status_bytes < task->req.bytes) {
+        block_copy_task_shrink(task, status_bytes);
+    }
+    if (qatomic_read(&s->skip_unallocated) && !(ret & BDRV_BLOCK_ALLOCATED)) {
+        block_copy_task_end(task, 0);
+        trace_block_copy_skip_range(s, task->req.offset, task->req.bytes);
+        return false;
+    }
+    if (ret & BDRV_BLOCK_ZERO) {
+        task->method = COPY_WRITE_ZEROES;
+    }
+
+    return true;
+}
+
 /*
  * block_copy_dirty_clusters
  *
@@ -768,7 +797,6 @@ block_copy_dirty_clusters(BlockCopyCallState *call_state)
     while (bytes && aio_task_pool_status(aio) == 0 &&
            !qatomic_read(&call_state->cancelled)) {
         BlockCopyTask *task;
-        int64_t status_bytes;
 
         task = block_copy_task_create(s, call_state, offset, bytes);
         if (!task) {
@@ -782,24 +810,12 @@ block_copy_dirty_clusters(BlockCopyCallState *call_state)
 
         found_dirty = true;
 
-        ret = block_copy_block_status(s, task->req.offset, task->req.bytes,
-                                      &status_bytes);
-        assert(ret >= 0); /* never fail */
-        if (status_bytes < task->req.bytes) {
-            block_copy_task_shrink(task, status_bytes);
-        }
-        if (qatomic_read(&s->skip_unallocated) &&
-            !(ret & BDRV_BLOCK_ALLOCATED)) {
-            block_copy_task_end(task, 0);
-            trace_block_copy_skip_range(s, task->req.offset, task->req.bytes);
+        if (!block_copy_set_task_method(s, task)) {
             offset = task_end(task);
             bytes = end - offset;
             g_free(task);
             continue;
         }
-        if (ret & BDRV_BLOCK_ZERO) {
-            task->method = COPY_WRITE_ZEROES;
-        }
 
         if (!call_state->ignore_ratelimit) {
             uint64_t ns = ratelimit_calculate_delay(&s->rate_limit, 0);
@@ -840,8 +856,6 @@ out:
          * block_copy_task_run. If it fails, it means some task already failed
          * for real reason, let's return first failure.
          * Still, assert that we don't rewrite failure by success.
-         *
-         * Note: ret may be positive here because of block-status result.
          */
         assert(ret >= 0 || aio_task_pool_status(aio) < 0);
         ret = aio_task_pool_status(aio);
-- 
2.53.0


