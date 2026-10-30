Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9B1606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=jWklFvcW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMb52-0002MU-MK; Thu, 29 Oct 2026 21:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb4h-0002Cj-OE
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:35 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb4e-0006Ee-Fz
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:30 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso79323f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 18:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793322386; x=1793927186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CoR8CLrpuVAT0u8yvV1K/ZhWofQiYj1zPlWlm27XYIA=;
 b=jWklFvcWXWxi3r3XNMIKWQrSHdR6jlW9gSRKpsUSoJoDsI04FgNeOM7ZY4IXGODf3l
 TRYQwLExqgYnVqvjVsh/3OIwVx89VDd0pyZIXu8gxt9odMqinMJT4BR6lK03CgopCfLN
 sdKBBUSn2z+9qMz2NCd/x8I2BEjG0cIE5xF/CmxsR53h9ox1aoJpXE38f4F81wi0w+3v
 h0m6iPCyRsvL2J421mbPrgcK6e2/Piv9Uokwr6Pu/ZZXcSxIgzxSaFD//ADT/1Z6OOsC
 tPfDRe6CHRXZK3QuaBhJTo9yvvoTAL1b6YoLrOs37U7cDKv30tfJSxNPgQvnDWNzJf39
 IsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793322386; x=1793927186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CoR8CLrpuVAT0u8yvV1K/ZhWofQiYj1zPlWlm27XYIA=;
 b=GmOQGD5LeauuCqDMY96+Png/eDqkGDZpDTwd6Q7/++YGeyRsHAXOEq/BnqIyJ0d3YU
 A5jnR/eGu15it+shpcDwILmZrgKiK6+CPY+qScCXgCSfmw3eA2MLH0QMVspOo7KqrVsk
 HYGwZvsVXQxK1YBSechNj5nB92hvNnhHlEVAA53uhwc6qXHW4SYlY1pTvtVVxH+/8I50
 9ffGaXTXGKe4TEFd+sLHhs0fpUM+GLNtv+kqB4f4euGLzDgp4++YyiUcZ1zwJeXGvIAn
 GeovG25tYTY5YACUizgZuXFoskhY37+M5hqUMZtOZP6qy83aKQNNFfZC1/LPkhzU116U
 0alA==
X-Gm-Message-State: AFq9FYIh/r2iqledclkNJUaPHsY7YbhKZQ+tlinJDkl5ulOiDzxB62ua
 V2bd6ZK5nN5nXTqbpbENzao6xuKsdTxOxwRVJgsip2gjfFZYPL1NhM6pT/SiJ+FNnPIRUKjNA2w
 fK326
X-Gm-Gg: AYBFou3i91TGmOyHO17JkXWJDKr48rl71xZOrwr0iHMPKcZ1kNQyoiSKCSLgzyrJnku
 r3NOlk76GQY5mnSUesf6DUIjhl04Gai2KD7brpyztQl3iIin8NkOCGeEHsIsgOlt4jmHpWZo8UY
 t6dudWTcAMdon8miItQA2wF+SM4roqvGYiY6D77+v9Vr/hVP2qKTx6rUls8uXvW65ZVk4MDXll5
 lB3Gvwo6Sc9+aphXWbnNS7yGAP8cVDfHl11FPgDQv9duWf/UnSwwB/YCdm887azH59Tc1pRAumY
 2ciF79qPEm3/b/P0ADPpzL91KLCFxzwxtWEmPgWquRTQDfWLFvAdJA2FpnJFA/Sj3S+y6ETloc7
 AxO4KDR65mw/HNuXxUwGrDRfRkx/WX5m2AMtXPg+ydbuxhOpLg0h3IECdonsy2I5E5GxY/vLNzO
 pcLuCbBLX9iUjS2p+2LlWiwl+E6Rrq8vWTL32zhRNKpm32BneE9TRX71nt7TtMxZzWZZ4H6gDQO
 0yGRhyrZ114ZmD32L8O4CoKErUkdWoxAvu8Zhn9P5BJZ3uS04g9A8ZPwXeQO4a/OOUX+w1aqoUq
 d6eoiYsfMxMlYsTCvg==
X-Received: by 2002:a5d:5d13:0:b0:48e:103e:846f with SMTP id
 ffacd0b85a97d-48e6e2f91b5mr2229959f8f.9.1793322386194; 
 Thu, 29 Oct 2026 18:06:26 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f4be:f111:4ee0:40d3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80333sm210023f8f.32.2026.10.29.18.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 18:06:25 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v4 03/12] block/commit: batch block-status queries
Date: Fri, 30 Oct 2026 02:06:03 +0100
Message-ID: <20261030010613.1612771-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030010613.1612771-1-den@openvz.org>
References: <20261030010613.1612771-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=den@openvz.org; helo=mail-wr1-x435.google.com
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

commit_iteration() asks for block status COMMIT_BUFFER_SIZE (512K) at a
time, so a long run above base pays one query per 512K for an answer
the whole run shares.

Query the remainder of the image instead and keep the answer in a
CommitStatus owned by commit_run(). No device or export writes top
above base_overlay while the job runs: they ask for
BLK_PERM_CONSISTENT_READ along with BLK_PERM_WRITE, and the job
withholds CONSISTENT_READ there, having to share WRITE or it would
block its own writes to base through the backing chain. A job target
asks for WRITE alone and is refused by the op blocker instead. From
filtered_base downwards CONSISTENT_READ is shared again, and there only
the job writes.

Copying is still bounded by the read buffer. Zeroes need no buffer, so
COMMIT_ZERO_CHUNK bounds them, keeping a cancel from waiting on a huge
write-zeroes, and an unallocated span is crossed in one step.

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/commit.c | 58 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 4e0b0f9029..e8ddd46053 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -31,8 +31,23 @@ enum {
      * contiguous regions of the image is efficient.
      */
     COMMIT_BUFFER_SIZE = 512 * 1024, /* in bytes */
+
+    /*
+     * Zeroes need no buffer, so they are bounded by this instead. It stays
+     * well under BDRV_REQUEST_MAX_BYTES and keeps a cancel from waiting on
+     * a multi-gigabyte write.
+     */
+    COMMIT_ZERO_CHUNK = 256 * 1024 * 1024, /* in bytes */
 };
 
+/* Last block-status answer, covering [offset, end). Empty when equal. */
+typedef struct CommitStatus {
+    int64_t len;
+    int64_t offset;
+    int64_t end;
+    int ret;
+} CommitStatus;
+
 typedef struct CommitBlockJob {
     BlockJob common;
     BlockDriverState *commit_top_bs;
@@ -130,26 +145,45 @@ static void commit_clean(Job *job)
 
 static int coroutine_fn
 commit_iteration(CommitBlockJob *s, int64_t offset,
-                 int64_t *requested_bytes, void *buf)
+                 int64_t *requested_bytes, void *buf, CommitStatus *st)
 {
     BlockErrorAction action;
-    int64_t bytes = *requested_bytes;
+    int64_t bytes;
     int ret = 0;
     bool error_in_source = true;
 
-    /* Copy if allocated above the base */
-    WITH_GRAPH_RDLOCK_GUARD() {
-        ret = bdrv_co_common_block_status_above(blk_bs(s->top),
-            s->base_overlay, true, BDRV_WANT_PRECISE, offset,
-            COMMIT_BUFFER_SIZE, &bytes, NULL, NULL, NULL);
+    assert(offset >= st->offset);
+
+    if (offset >= st->end) {
+        /* Copy if allocated above the base */
+        WITH_GRAPH_RDLOCK_GUARD() {
+            ret = bdrv_co_common_block_status_above(blk_bs(s->top),
+                s->base_overlay, true, BDRV_WANT_PRECISE, offset,
+                st->len - offset, &bytes, NULL, NULL, NULL);
+        }
+
+        if (ret < 0) {
+            trace_commit_one_iteration(s, offset, 0, ret);
+            goto fail;
+        }
+
+        st->offset = offset;
+        st->end = offset + bytes;
+        st->ret = ret;
     }
 
-    trace_commit_one_iteration(s, offset, bytes, ret);
+    ret = st->ret;
+    bytes = st->end - offset;
 
-    if (ret < 0) {
-        goto fail;
+    /* An unallocated span costs no I/O, so it is crossed in one step. */
+    if (ret & BDRV_BLOCK_ZERO) {
+        bytes = MIN(bytes, COMMIT_ZERO_CHUNK);
+    } else if (ret & BDRV_BLOCK_ALLOCATED) {
+        bytes = MIN(bytes, COMMIT_BUFFER_SIZE);
     }
 
+    trace_commit_one_iteration(s, offset, bytes, ret);
+
     if (ret & BDRV_BLOCK_ALLOCATED) {
         if (ret & BDRV_BLOCK_ZERO) {
             /*
@@ -215,6 +249,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
     int64_t n = 0; /* bytes */
     QEMU_AUTO_VFREE void *buf = NULL;
     int64_t len, base_len;
+    CommitStatus st = { 0 };
 
     len = blk_co_getlength(s->top);
     if (len < 0) {
@@ -235,6 +270,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
     }
 
     buf = blk_blockalign(s->top, COMMIT_BUFFER_SIZE);
+    st.len = len;
 
     for (offset = 0; offset < len; offset += n) {
         /* Note that even when no rate limit is applied we need to yield
@@ -245,7 +281,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
             break;
         }
 
-        ret = commit_iteration(s, offset, &n, buf);
+        ret = commit_iteration(s, offset, &n, buf, &st);
 
         if (ret < 0) {
             return ret;
-- 
2.53.0


