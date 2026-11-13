Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE2F606A8A4
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R/wpPAjL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRnYy-00010g-HT; Fri, 13 Nov 2026 04:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYw-0000v2-1m
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:27:14 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYu-00062I-Bj
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:27:13 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2e98798cbddso5948775ad.0
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 01:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794562031; x=1795166831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DXHsNxPWfAhBshyZgLvXP5fCtDHZuiJhPfU8c6CLgmY=;
 b=R/wpPAjL0DqDer4OznLj8+90u+fcCJgNNG4FWSafVfWoJVMBWC6g1ie8a6pPtnNxLn
 r2vluT5YyZtdwJA1POTaYWelGd02g/hctcuMd1Osghs+0ckyfL2zwO5mmIIvP34OKyKw
 aTT//O21nd8kM2RVGttNWF1yL6RDDpz0yhSmb5oIbBYGkcieW+0Eas7lHc04Shu2P204
 j299PdggKqZFSP5lALszadXG61WGZJ1tSB4pKGCtZU9XIEkbV4xPao7Vhl0wmVnJ7Y6u
 rLQ+B00VCKZ2PIQgP+0MLXF22OC6ReEHLncgEAbsD737dbawZPOZvtXTdwU7vFJJnkQA
 BYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794562031; x=1795166831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DXHsNxPWfAhBshyZgLvXP5fCtDHZuiJhPfU8c6CLgmY=;
 b=pD3je9HXkfl199Yr2cmnISDRKDQ1mxnoj2tBSqux5UW7BEQY15CDxUqg/8hCDwegRx
 Faj9a36isonZTICtXpVT25bzTsVOP0YhmMhrByBhH3vBFCOMU/nTT5hC9MElYua9C1XD
 +ZGYKNjuWPiSA5CxB32VQCHTBZDTN98AoXK5RdV5AA++SS0b1zU+gw5UEbZ8nDvLhXLt
 zV19na/UZ7AzBmDCBV6dlHLAz3eVf27DRgZ3Un1J8eQX8bZfz/bQKDIDP526e65YONit
 T5Vn5d14pzUXF7PxYzxp6U7zIrIHVu2ElzX+sGs9D1BKN+0i8g4sBxaxxyLRNynDz2Pt
 JHAg==
X-Gm-Message-State: APuU4Z9jacz38pvTUPrx3Mi+dUbKSZUln3ebzs9q1nc0tOpGfe5M9ed1
 v5a58XETD4I5Hn3IXWGL28evRQkcdNw3dHCDWeyV0WllvwKBlmT5YDgjjk9T/iGA
X-Gm-Gg: AYBFou1rqEDgGWIYmsF1NLLlF6kUp45Yd+rct3wVJX/xlnCKD7/u2CzY4nRoQ6mSHop
 1uBjBh78sMGHr5ry55EZos1HhZIJ7JChCktQ8hR3IwYSfQ5crqTrFVgvacl3EitgCCb0BfJHRzq
 omPr/wzgFjjFU5I4TFjzu/7DrIwjyG7hnLymMygQGcJd3d9kLx8HMdeR1dw9FF1zqrqrEgqQsPy
 5u0My/Hi5zEu+x22rzTHyCAwaMAv5AYCIjVFf9AGSnSTFOALia0z8T/7w/tWhrbAKHOObb43m9z
 xsOm1U3rV8MnoTrTqs85L5cjIWBVbEt5DCluWUy10HUD91PthEjyl7dYPBpIKV0WMmw1X6IgLW+
 YeguGR9Vz9taQYAJ5VkAlVD060v80YCwd8eQcDrhPEgMsZHfueawyTx6V8Q9L1T4yZ6xNvI+Ma1
 PJ487UFZ/VBFLqc2SS/CiGtbxWLDdkysrtn6GTdQWnno3e7Lucy3FjlXeG9nxe7T5Kr+rSpBdqc
 np5kNNwdyQFWoCJPABAB9Bpxf8fAD90NvwcAXoe+mgRLy6OF9Vu4kTWpo3ldTVvAcoklOX5rkz5
 0jHsDUflbRHgaSwMPuMdo0ato28evzFF/6Cciaku4qHg0mPH5v8jvJNb8dw=
X-Received: by 2002:a17:903:1a44:b0:2ea:9012:649 with SMTP id
 d9443c01a7336-2ee0e0e8b2bmr19558095ad.57.1794562030880; 
 Fri, 13 Nov 2026 01:27:10 -0800 (PST)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f7d0887sm7428605ad.32.2026.11.13.01.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 01:27:09 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V20 12/14] iothread: make legacy AioContext getter explicitly
 unsafe
Date: Fri, 13 Nov 2026 17:26:03 +0800
Message-ID: <20261113092605.942292-13-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113092605.942292-1-zhangckid@gmail.com>
References: <20261113092605.942292-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62a.google.com
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
index 0f70973326..753bb89088 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3697,7 +3697,14 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
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
index d4328fc214..10d40103fb 100644
--- a/iothread.c
+++ b/iothread.c
@@ -436,7 +436,7 @@ char *iothread_get_id(IOThread *iothread)
     return g_strdup(object_get_canonical_path_component(OBJECT(iothread)));
 }
 
-AioContext *iothread_get_aio_context(IOThread *iothread)
+AioContext *iothread_unsafe_get_aio_context(IOThread *iothread)
 {
     return iothread->ctx;
 }
-- 
2.53.0


