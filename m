Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B3B606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OOFvvspn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLzwD-0007Wl-Jy; Wed, 28 Oct 2026 05:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzwB-0007Uo-SD
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:27:15 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzwA-0006j1-5p
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:27:15 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2e8f2c3ad6bso4228895ad.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 02:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793179633; x=1793784433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iabqbCKSqp1YNDA2MncmA1e5Jv4boGZeCS0JYhOjvkU=;
 b=OOFvvspnofBpmxT8aJUVZ5xXApBzCWVKPV9x01qh6UAu9hz92YyEnQNHnzc4ouZXeZ
 6KqhIdrTxzHkmO9eWR26/8gDKVaUiSlzxHQELUu3UM1YGr4pSdItWDkWAwvZ3nPGpie5
 WtFTXVMLp0RhJxwdu1s15TCldI5f1FkBzjyq6ZspkuDbCAl6dUOwN78ZOxj1TcsuyITR
 BZQQWLD7JfQj3qb+MlGaPYCj9lFuywecO87Sl6AQQrX+8wZK9HjfnHf+lOQ1ocsszRxK
 q5pmhDzz3/BOiwp6ybmyrVnljPidP1DZwHjQSAEqjJMNddKYSPItFYgx8fzH2pKjiOkm
 RgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793179633; x=1793784433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iabqbCKSqp1YNDA2MncmA1e5Jv4boGZeCS0JYhOjvkU=;
 b=zCzh8+rRNFo8nKKJjU5W4Jd5Y2yEeGJtHUgtDbqtToz9NjxXXo8lI4CO7nJIgfbGs9
 OAdQRJYeULixJZI6daEbDoS4U+rxNH3ny9ZRHr6elR5ctCneiXzQ7vMm0A54tkEUAUZZ
 FrDp0V9BuF3UgRyKNHczPKVGgjQf54eX/zCZa9ykPP0ytlVRbKTFWOlic9t8xedfHk/w
 QZgMYvRB41+T5phcAtSSWoKSRNFg/Xy0vKcnjxfq/SeBE/ZmZZuRMatM6CEMjPCztSau
 EhllopKclcHUv7q/Xt0fOIX0/ouDLNDysgiGJ/Jj2hGfx+8zcnt0iM5b3cdc3R1nDlKh
 IXfQ==
X-Gm-Message-State: AFq9FYIOpdOU7C2lSWShl5xcUpD42pMC469qmX8NwH92yEemfp6ueV8v
 rJerziCYVn6Y4xLwxFlp3t3sqOuPl0ccujEyse+mE4QGZcRhThbFH9qkEby0YgYa
X-Gm-Gg: AYBFou3+WUQWseR+VzqLvCeBoXY4Ep0pKV3zCT2fODpie1Ups3Ee9BPgVVO8zY+z3G9
 pVoFhxHT4UY9lrtOOrXZYsjIjyAuuHnO+vK87YdHaaaVjOUy5nJlI9WmckB2o3XZ9eaTlPTNTs1
 0W6kt9LYLpl6k1yxtrLRBEn9toMqtRyJQANSA0asjVQ5RoJruJtpu+TxhbLpPMfZvuvoyZdl/ms
 S4qTLB87+fGF+56VLXIM6pPDXGA0FU9C7NYN4dTlS4E6ETHIhctbpGwjclOZ5XGs5HftIhwfTf1
 L6+t8EUWBZ2JXCcgUG/g/M5sJSjGsaTTuddzzTkODrajxRKNYoOlGMN55tz0znujlzSMEJlwKUM
 nySA8GD4g3OesUEMocL8kkx5n/uc+fhh5SAwSfaNqDNl0CHVRZ+cjOU0NqtnN/NS3ivpR7iv+hM
 JJ2eKtgmUtl8AEnKFWLWFrpMhHYNETWbVOfN+KfZ9S23dKprUqoNVdnrf0IoJGSUIMjAXOM4rlr
 TMMK1LgPe0oXKTn8WUSC52d2IB3xuy1FYtjlx4k/IzuRnOkw3QcmGFZ8E1CNXpY290u0XkwoWB0
 cdKQ1vEyzIWuOQZjo1wpdSB7J01+WNnthQaPunD7lW84vC1UeP6t/fKazPg=
X-Received: by 2002:a17:902:d48f:b0:2e6:7c6:8d40 with SMTP id
 d9443c01a7336-2eb0036c529mr18379735ad.27.1793179632700; 
 Wed, 28 Oct 2026 02:27:12 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6b7a691sm19481635ad.26.2026.10.28.02.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 02:27:11 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V19 12/14] iothread: make legacy AioContext getter explicitly
 unsafe
Date: Wed, 28 Oct 2026 17:26:17 +0800
Message-ID: <20261028092619.1654474-13-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028092619.1654474-1-zhangckid@gmail.com>
References: <20261028092619.1654474-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x632.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 5694e91bf7..36a2aadd53 100644
--- a/iothread.c
+++ b/iothread.c
@@ -435,7 +435,7 @@ char *iothread_get_id(IOThread *iothread)
     return g_strdup(object_get_canonical_path_component(OBJECT(iothread)));
 }
 
-AioContext *iothread_get_aio_context(IOThread *iothread)
+AioContext *iothread_unsafe_get_aio_context(IOThread *iothread)
 {
     return iothread->ctx;
 }
-- 
2.53.0


