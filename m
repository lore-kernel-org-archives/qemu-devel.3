Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B672C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUrw-0003rd-4M; Mon, 24 Aug 2026 09:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyUrt-0003ox-Lo
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:37:41 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyUrq-0002bK-HB
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:37:41 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a1542cdb53so4243599a12.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787578657; x=1788183457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u+3tMmW+CbA3lTRhol/qEtVSa2RFqO8eSTJOauSbEqc=;
 b=UE3pxQ+dQqNcmJEfq4Gyv3r5LghGAU0w0Mns/BuSIQLHNB9A7mq4aShHq9dVVrdbPB
 JrDjsjCO+zXGhZlblsYYOlKNBP35e6ssF8/aoFIdUH3+4e1qn09mTEnM0eHCucvqDCno
 NUn1MCKlUgXsFSgaxbECK4byPURGdOon4MfzmgfuCqUrcCvsi2K13GIsZyJ5pD/hIb9N
 gyQ1000+p80WDoFiDzv7kfMeU6MbvY1Pbk1Pgz+R2UzswPl7O56WM4G9xVVVXk/Zn6AJ
 kXZukANeCKO8lbFFPq+LzHJjQ1ZHnB5XLFO4O60LrlDTSDo3d4reRO3/GTLlf8OLNtD4
 yHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787578657; x=1788183457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u+3tMmW+CbA3lTRhol/qEtVSa2RFqO8eSTJOauSbEqc=;
 b=I7YvdDglMng7suSEV6OmDmkbvNGNiKVPv2QYboJJev4gHrXg8nOI+sxKFlfnIrEJJc
 P4RdePPOdjA6QK0Ihw5xuPUdn6RauXehAMXSRYdq02sVIt/PZbMqnf+QG5J04pUJwvWd
 KwqF7r0Q9nAMvX5ge0QaMn0HM4pnyRNCNeoH3Bpbuz1k154y99z6fpgNjOU2uhvjM4Ie
 QUNsJZe4nNGF+LMjYd/1gC7cDC+3kNZVDraA3sSogmylubjAWED83MgFdtvm/bNl0X36
 efjokw02IGsoSlHIfLbjYA0EfOXLaaMy17fqfqYmWbUvDJRKPn8/u0ylBR6Mg0E8He/D
 fG+A==
X-Gm-Message-State: AFuF++kQ0dbKEl4/Xi35/qmQEc4DseVqEy4dm6BGkcb/BS51cqa2srW4
 OMMMibI6kQp/dMuvi93eAcFQIRSLkcreyFoLndoRAMlK4HgctfjqYlaE2x9rv3oA9nHgaWMFisB
 ki0yK
X-Gm-Gg: AR+sD10s2Df+N66XlyjVwCyZ4CLFI2uPnAtznsLHqS6B11b7F0AF7PaCRAyeqrZKx9M
 uHLu2FIpzpwRgmFieFLCt9jX5saJueU53Z9q5YdSXMZ2W7xFwOeq01a9hn3SIPGXm2ufzy4Pnrf
 YvW7OeSBImIpJsO6I9P+yKdyVSmko+EtP3YIl0RKJcP1QQECIqJ5rFYCih4Uii/5UFnbHj3Yata
 l0bQuIcmw6bVMDmEWKPRRIklXu2rdTq5fGkFyeb+moZeiAzgfhXeZmintIgnHrM9Qx1Rpnl+YR7
 yB7aVTmj0L6jUtOCueWzJihei4nz6jqCxjelFXpF+Itc3ZObvVeuRjIj6zozcsTQxdbLkhk0/nD
 MTFbvXC2ClxMu+RuJJU3v2s+1EszOhS6+oZHU51leT0kMTp9L0WFyXhoAQncfkp48jBNKBaoXcG
 HJNv8rsZblc5BzQUqJyxcYckLX8/MRhYnOTfo5FNx8bRm9h7rpZAOdfRJMbCXns2AH/Eq+v8C47
 w==
X-Received: by 2002:a17:907:948a:b0:c1f:922d:34c3 with SMTP id
 a640c23a62f3a-c24926a1c3dmr1823989966b.14.1787578656987; 
 Mon, 24 Aug 2026 06:37:36 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9048:7bf0:d3e2:2b9e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f58dfsm1236658166b.38.2026.08.24.06.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:37:36 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v4 4/5] block: remember the flags a reopen starts from
Date: Mon, 24 Aug 2026 15:37:28 +0200
Message-ID: <20260824133729.1141990-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824133729.1141990-1-den@openvz.org>
References: <20260824133729.1141990-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=den@openvz.org; helo=mail-ed1-x52f.google.com
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

bdrv_reopen_commit() updates bs->open_flags, so by the time
.bdrv_reopen_commit_post() runs a driver can no longer tell whether
the node has just become writable or was writable all along. Only the
transition is worth reacting to.

Record the flags while the queue is built, next to the other pre-reopen
state BDRVReopenState already keeps, and let a driver ask about them the
way it asks about the node itself. The predicate which
bdrv_is_writable_after_reopen() spells out gets a name for that, and
stays private to block.c.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-stable@nongnu.org
---
 block.c                          | 17 ++++++++++++++---
 include/block/block-common.h     |  1 +
 include/block/block_int-common.h |  2 ++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index b29202c8d5..6280a13610 100644
--- a/block.c
+++ b/block.c
@@ -2193,14 +2193,18 @@ static int bdrv_reopen_get_flags(BlockReopenQueue *q, BlockDriverState *bs)
     return bs->open_flags;
 }
 
+/* An inactive node may not be written to, even though it is not read-only */
+static bool bdrv_flags_writable(int flags)
+{
+    return (flags & (BDRV_O_RDWR | BDRV_O_INACTIVE)) == BDRV_O_RDWR;
+}
+
 /* Returns whether the image file can be written to after the reopen queue @q
  * has been successfully applied, or right now if @q is NULL. */
 static bool bdrv_is_writable_after_reopen(BlockDriverState *bs,
                                           BlockReopenQueue *q)
 {
-    int flags = bdrv_reopen_get_flags(q, bs);
-
-    return (flags & (BDRV_O_RDWR | BDRV_O_INACTIVE)) == BDRV_O_RDWR;
+    return bdrv_flags_writable(bdrv_reopen_get_flags(q, bs));
 }
 
 /*
@@ -2214,6 +2218,12 @@ bool bdrv_is_writable(BlockDriverState *bs)
     return bdrv_is_writable_after_reopen(bs, NULL);
 }
 
+bool bdrv_reopen_was_writable(const BDRVReopenState *state)
+{
+    GLOBAL_STATE_CODE();
+    return bdrv_flags_writable(state->old_flags);
+}
+
 static char *bdrv_child_user_desc(BdrvChild *c)
 {
     GLOBAL_STATE_CODE();
@@ -4473,6 +4483,7 @@ bdrv_reopen_queue_child(BlockReopenQueue *bs_queue, BlockDriverState *bs,
     bs_entry->state.options = options;
     bs_entry->state.explicit_options = explicit_options;
     bs_entry->state.flags = flags;
+    bs_entry->state.old_flags = bs->open_flags;
 
     /*
      * If keep_old_opts is false then it means that unspecified
diff --git a/include/block/block-common.h b/include/block/block-common.h
index 895ea17541..eb2dd8aff1 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -358,6 +358,7 @@ typedef QTAILQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
 typedef struct BDRVReopenState {
     BlockDriverState *bs;
     int flags;
+    int old_flags; /* bs->open_flags is updated on commit */
     BlockdevDetectZeroesOptions detect_zeroes;
     bool backing_missing;
     BlockDriverState *old_backing_bs; /* keep pointer for permissions update */
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 035e54d434..4ea1a78494 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -1346,6 +1346,8 @@ char *create_tmp_file(Error **errp);
 void bdrv_parse_filename_strip_prefix(const char *filename, const char *prefix,
                                       QDict *options);
 
+bool bdrv_reopen_was_writable(const BDRVReopenState *state);
+
 
 int bdrv_check_qiov_request(int64_t offset, int64_t bytes,
                             QEMUIOVector *qiov, size_t qiov_offset,
-- 
2.53.0


