Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F49CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBTSg-0005zi-PN; Tue, 29 Sep 2026 04:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTSa-0005sU-DY
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:45:12 -0400
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTSY-00041C-4h
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:45:11 -0400
Received: by mail-pj2-x0e.google.com with SMTP id
 98e67ed59e1d1-398cb5615deso3167912a91.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 01:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790671509; x=1791276309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tSwqmMZQEjC0Trxhzu56bKX57rueCWfNPzUcXcWo2UQ=;
 b=dBu0uPbHWVv/tQ0nvM+00kebRaUbFTxmmip88Mm8ZL0z+X61jnqZ5PHOjZX9nzB2dj
 e5vH3ScUDOIoT8yRJm31MHyuaw71qaccckY3MDptloCWHFt/mUx+ij/rpx0pnDR1xlV2
 sHbksm4/XI+rrBIUnn5FKu3v2rm6C8Dd0hs59tBYb/LNi+Xm24lTQaTc4ONb7XPTN+OH
 GZgb4WndCFKBYWFK35F7BDoxS7e+QK0azMiPSnv9EuACFcNkwRWZzF9euTDcMg/JY4HF
 nz6zPoP3eIK8YpUnKQNT5YpXziqe3Vxkx1CwQzrkHForJ5OWRB+6QzEf22fHbM2oyktb
 zM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790671509; x=1791276309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tSwqmMZQEjC0Trxhzu56bKX57rueCWfNPzUcXcWo2UQ=;
 b=Zq6yN+kIaWu2ED0WwBEQ4D6JycRw0s2RwAN58t/M7/fVo1sl3zy7x51a2wYcCn4T/R
 dY6XwDkVY1jD57FXfCWzGrNUcRqPmR4X3F83kNNUkLzMr47p+s3QuOsn/vkgnMUYPUCc
 KDuyyoEefX6f1aTJUiBw7+oPpb9b8OZtlHyZH7FSLeTbzKHUlmUCZZCwRBGWUAAl+kr4
 vD8cG79yKAhHFFBerYL9Na/aPe2mFKWNFHg02RlCwoyeGsxrhKqBo6RoJ5RoDDWzK/5e
 rUDpX6BSLM011iL7GGmIlxVag0MF6qmiVxc8T88t2+VnKb142KLKIFX9dsviT4KR2itc
 aL4Q==
X-Gm-Message-State: AFq9FYJ2dYjHDEYo74JFFkAmxCynIRqyZ0ZoUWPDWi/uhnGL+IASRlsA
 r1jvM7ECrKJH5ljd4eywkkDQpe9TR4iW6lHOyqqD9tzLM4pHbomgyLgf3SppjzWA
X-Gm-Gg: AYBFou1pWMFXLIXojPkmLJHLIgn/3UYV/mUNURTGJFFRn//AfnEzjN0jCjotUReidoZ
 wNAI0oGha3F9VAB+EyV8iZIJl2yjvqVS2x/125QEepH+YUGkuxE+rhfnJwK7eTBvPyUz4bE//aa
 Kc5diO6CWpemxpFXEUvxmGCUqwmoRvCgffJwgxsyJ90Ag601n6mvEhAk7IOZHjSkEtgJtZuE5zm
 L8ZJr79ObBEZYluuaCuRDIsqomLP3hnd96T0FhChZKQgunSEMSieXUl0qy+VyWZ47uwWDEl3tKP
 ts6dyYsAssLIgfIT96Pc8U0uT0NbJD8ryxjFEr/VnYuqHQAPwbnqmF+TG9ycgZIMVUWjFCTkWhj
 VuurodGMv5mAY7Lh4BabqCQO9VovxYOK13K6aKH3Ft5Fjm7nZ8Q6yBw8BRbPRdd5xeZ3ZCjDt1d
 whZRnbZtZCumtDh43ezVSwJJHNvjVwr4K0mr9Zebb6W/RmDhBFIy99PLHAMZexoF+QAEhuFzH/9
 /IGQxqRTls2gJfquvKpAjU/xCOu
X-Received: by 2002:a17:90b:1f8a:b0:39e:6a82:afda with SMTP id
 98e67ed59e1d1-3a098fe651cmr11916679a91.44.1790671508643; 
 Tue, 29 Sep 2026 01:45:08 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a497e942eesm5163120a91.4.2026.09.29.01.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 01:45:08 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V18 12/13] iothread: make legacy AioContext getter explicitly
 unsafe
Date: Tue, 29 Sep 2026 16:44:15 +0800
Message-ID: <20260929084416.1600199-13-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929084416.1600199-1-zhangckid@gmail.com>
References: <20260929084416.1600199-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::e;
 envelope-from=zhangckid@gmail.com; helo=mail-pj2-x0e.google.com
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

Now that holder-aware callers have been converted, rename
iothread_get_aio_context() to iothread_unsafe_get_aio_context() and
update qmp_x_blockdev_set_iothread().

The only remaining user is qmp_x_blockdev_set_iothread().  It cannot
use iothread_ref_and_get_aio_context() as is, because it ties the
AioContext to the block node, and iothread_unref_and_put_aio_context()
would have to be called when that tie is broken.

New code should use iothread_ref_and_get_aio_context().

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 blockdev.c                |  9 ++++++++-
 include/system/iothread.h | 11 ++++++++++-
 iothread.c                |  2 +-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 6e86c6262f..3bd32feb39 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3683,7 +3683,14 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
             goto out;
         }
 
-        new_context = iothread_get_aio_context(obj);
+        /*
+         * We cannot use iothread_ref_and_get_aio_context() /
+         * iothread_unref_and_put_aio_context() here. The block graph stores
+         * the AioContext but not the IOThread, and continues using the
+         * context after this command returns. A matching put would need
+         * to be tied to the block graph's context lifecycle.
+         */
+        new_context = iothread_unsafe_get_aio_context(obj);
     } else {
         new_context = qemu_get_aio_context();
     }
diff --git a/include/system/iothread.h b/include/system/iothread.h
index f6c5f95dd9..9850cdb3dc 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -66,7 +66,16 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
-AioContext *iothread_get_aio_context(IOThread *iothread);
+
+/*
+ * Return @iothread's AioContext without registering a holder or taking a
+ * reference on @iothread.  The caller must ensure that the IOThread remains
+ * alive for as long as the returned AioContext is used.
+ *
+ * This API exists for legacy callers without a clear ref/unref lifecycle.  Do
+ * not use it in new code; use iothread_ref_and_get_aio_context() instead.
+ */
+AioContext *iothread_unsafe_get_aio_context(IOThread *iothread);
 
 /*
  * Register @holder and return @iothread's AioContext.  The holder is copied,
diff --git a/iothread.c b/iothread.c
index 5a4291a2f0..28460afb3f 100644
--- a/iothread.c
+++ b/iothread.c
@@ -422,7 +422,7 @@ char *iothread_get_id(IOThread *iothread)
     return g_strdup(object_get_canonical_path_component(OBJECT(iothread)));
 }
 
-AioContext *iothread_get_aio_context(IOThread *iothread)
+AioContext *iothread_unsafe_get_aio_context(IOThread *iothread)
 {
     return iothread->ctx;
 }
-- 
2.43.0


