Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECE3C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 15:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtocg-0007wo-FG; Tue, 11 Aug 2026 11:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtocf-0007vQ-1u
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:42:37 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtocO-00049R-JJ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:42:36 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a17f91so5025817a12.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786462939; x=1787067739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XszDXri9oioBWSiRYQNcTPMrJR0fmQwMZNwkcF35QUY=;
 b=XwLo2PwHrNvU+Qz0ZNU5gDiBrRKaTKSiBkHbvRR0+H2SRztRlK1rtmu5DN1DMWODvg
 uMq2HQbyGAq6Hca1dIRXxWQIoF4s753LZA1YbYwqJoFnAwIqzVng5COodoFrcFitW9ME
 Ppdjv+HYYkEmF5OMu+bcHVQl0dqGRHngpXcKiUEb1z87Jb5lmrJA2U9KdccS8XkvifGw
 76MWD1UzpoZKeHlPZo8YJpg347PLnKOZvmE5vJmrNR89uQOnuzvlErJZIxot33AShz3k
 hWuIdQAMHnSdsyGWuECGNA0YkESMtNiyifG+naOTeJTM5hm3zGbdGYQjc7LbRE8vN4RC
 CXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786462939; x=1787067739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XszDXri9oioBWSiRYQNcTPMrJR0fmQwMZNwkcF35QUY=;
 b=J2iUWTgiorzQ5fz4Sql2OtEDe0w76ApX94ryue+ew9hlY1wXuJ9pcVvF9uD+NgRZ58
 45FVfluTQmhMYMQjjH3Qy697JDruG52U32JkpcGT0WXfItwjKkJ9T9Lfa5jQkpt+0HZb
 AU2hSEgpWkpCbbr2M1/oC9vD1KgJEj/6bjKNQCwNUDj0uUG/3S5JXLhJuvi/e1MMNiCg
 6DpzRXUiY3Gd8JKhIdsXQT0glvOw22j+R0yrGDiEW4YfIs9j1bYnjzGdORTtIR/frxn4
 sL9VWR5YGpUQpk6HAPgzC8mLHndGznLtlOUZXALDQTg9e/srJB6nVXpqAJAghHxhzjAH
 l/Ig==
X-Gm-Message-State: AOJu0YwXUKEkJRUF9ISH4p1Fc7yhK5FQKfr9M8n2fw/JPNDfSSQBM44O
 5tVHil8O+XpL2AkTEmUoKD8/h/XRvZ9wE8klkE8qH3bctCpmGzv7iiyW/3LZiGNyJPhnnCc6lRG
 +whmn
X-Gm-Gg: AR+sD13kxQs9TBVzxH7Zf8HUHADsvGDODriqiTWHrtFfB3qLeHiX4bCyrKYxtb+Wpx6
 3GFvRXHGq9Ayer4dMqtPcFl3i+z2+dCOznVNLLDQI98cldYuDuUJNJxRZkMC7au8aPypENo6zn/
 Rl99EdXWIfaEfEGf6C3YNT+ihDvaSUc6UU4UJe1dBEJUbvtD0v3OdyUYHwr/g1wrGSsTzUB2g3V
 weN0K985gPzd2BBjORRZybfn3u5BiQOcy0LL1lQ4bW3QrUPyswoVjTJ4yScoZmO76rIlJ0ptnW7
 EYzXmWdtiIirnRJ7fFXNWAS0IWqccvfLggGG7UyiMojuM9fPQb9kxGd2wG6NpexlYyKaI4Kio16
 L/lSgwQn5toX57TSzEJdpAYBqiMAZjYUF+Hh9s1cdyS5oEeAG/L/fPXIW7qj35ITY793nsc6YKK
 LI3l0b2nrg04cejxi0BpJtEFgm3nLPPF4Z19l4JKvPXXBCRjpIjAytuRF0
X-Received: by 2002:a05:6402:24c4:b0:698:8847:e2f8 with SMTP id
 4fb4d7f45d1cf-6a36450c2a0mr1888445a12.15.1786462938798; 
 Tue, 11 Aug 2026 08:42:18 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c43:d230:7bbc:68d4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a362e34d4bsm841128a12.12.2026.08.11.08.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 08:42:18 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 2/4] block: let bdrv_reopen_commit_post() report a failure
Date: Tue, 11 Aug 2026 17:42:11 +0200
Message-ID: <20260811154213.184947-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811154213.184947-1-den@openvz.org>
References: <20260811154213.184947-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=den@openvz.org; helo=mail-ed1-x530.google.com
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

The callback runs after bdrv_reopen_multiple() has committed the
transaction, so it cannot reject the reopen. It can still find that
the node it has just made writable is unusable, and has no way to say
so: bdrv_reopen() returns success and the caller carries on.

Give it a return value and an Error argument. The reopen stays
committed, the error only reports that the node is gone. Every queued
node still gets its callback, the first error is the one reported.
qcow2 is the only implementation and does not fail yet.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-stable@nongnu.org
---
 block.c                          | 18 +++++++++++++++---
 block/qcow2.c                    |  4 +++-
 include/block/block_int-common.h |  5 +++--
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index f0a6042e61..99ed06f8ca 100644
--- a/block.c
+++ b/block.c
@@ -4653,15 +4653,27 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
     tran_commit(tran);
     bdrv_graph_wrunlock();
 
+    ret = 0;
     QTAILQ_FOREACH_REVERSE(bs_entry, bs_queue, entry) {
         BlockDriverState *bs = bs_entry->state.bs;
+        Error *local_err = NULL;
+        int commit_ret;
 
-        if (bs->drv->bdrv_reopen_commit_post) {
-            bs->drv->bdrv_reopen_commit_post(&bs_entry->state);
+        if (!bs->drv->bdrv_reopen_commit_post) {
+            continue;
+        }
+
+        commit_ret = bs->drv->bdrv_reopen_commit_post(&bs_entry->state,
+                                                      &local_err);
+        if (commit_ret < 0 && ret == 0) {
+            /* Committed already, so report the first failure and go on */
+            error_propagate(errp, local_err);
+            ret = commit_ret;
+        } else {
+            error_free(local_err);
         }
     }
 
-    ret = 0;
     goto cleanup;
 
 abort:
diff --git a/block/qcow2.c b/block/qcow2.c
index 1543255eba..553a94d003 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2145,7 +2145,7 @@ static void qcow2_reopen_commit(BDRVReopenState *state)
     g_free(state->opaque);
 }
 
-static void qcow2_reopen_commit_post(BDRVReopenState *state)
+static int qcow2_reopen_commit_post(BDRVReopenState *state, Error **errp)
 {
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
@@ -2163,6 +2163,8 @@ static void qcow2_reopen_commit_post(BDRVReopenState *state)
                               bdrv_get_node_name(state->bs));
         }
     }
+
+    return 0;
 }
 
 static void qcow2_reopen_abort(BDRVReopenState *state)
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 147c08155f..61e6621c93 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -239,8 +239,9 @@ struct BlockDriver {
         BDRVReopenState *reopen_state, BlockReopenQueue *queue, Error **errp);
     void GRAPH_UNLOCKED_PTR (*bdrv_reopen_commit)(
         BDRVReopenState *reopen_state);
-    void GRAPH_UNLOCKED_PTR (*bdrv_reopen_commit_post)(
-        BDRVReopenState *reopen_state);
+    /* Cannot fail the reopen, an error only reports an unusable node */
+    int GRAPH_UNLOCKED_PTR (*bdrv_reopen_commit_post)(
+        BDRVReopenState *reopen_state, Error **errp);
     void GRAPH_UNLOCKED_PTR (*bdrv_reopen_abort)(
         BDRVReopenState *reopen_state);
     void (*bdrv_join_options)(QDict *options, QDict *old_options);
-- 
2.53.0


