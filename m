Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417AAD74EFD
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 09:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkIuP-0001OM-Ef; Mon, 26 Jan 2026 04:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vkIuH-0001Mv-10
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:29:13 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vkIuF-0006rN-Jb
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:29:12 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a09d981507so28720295ad.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 01:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769419750; x=1770024550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+a3OwfwQBO2otyKeHBN1LrQH4TMfKPwgsXvF1+xAS4A=;
 b=iHOSOHnwSmLpsfFtjc3WgZG42WsZS8JM9CM1g+Vke8qg1V/IuQ/IjU3otIosExOIs/
 lkQmalMnqaaMQWqJYsbLxy9xOgMv84F/BP1dm7qCowt/La1EGp6rCkNdOiFvNnsVUffV
 PK5vloPN3FffG67dbRAFZgzLgl0+Ta5Zv+CGnZlhwZLcmEh1oSxZYbjOXpAUVPOyDfJc
 J386AIHQa6o324xupvGmb87pvErNdTQKqwGGGKde9bEHKclvQwYzGgCzUBmaOU1eZk9Q
 NCnFEfRTPuqYIWT4/PYuooBhsrgOV/IJvgBOWPNtfsok+0uiY3myVFcaSops+AXD16rc
 5twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769419750; x=1770024550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+a3OwfwQBO2otyKeHBN1LrQH4TMfKPwgsXvF1+xAS4A=;
 b=WIOXEjUefnhpUk1nBgXbwisQ0IsAfTyU21z/HSHjQwpO6Tr6gTn/SEa57HqXaGqltG
 ACSyi40/LZPjvoDj8supR9Fk6UI2BUX/vScmeDUexlHLspwAqVIgQQi1Yxq4DW2VBy2d
 fV2NbHbsNeA5uK8kvQTA/X2Q+mvJGgC3H0MviuKGipoeGLUkEP+J2q7Py+5YiZfMZiJk
 eEhfXWhOMEtxdw6XR30czOMbifWPMCp5Kn+aCbeakHR/lbz2feIQB4pTfwKA/zO1raID
 zgV1E4/Zp2iVQEpr+5cpUFR1ZnnUiRkL9VBXpNUrCUCf7DjytZcuIEkXskA5AUJJ20pE
 Z8fA==
X-Gm-Message-State: AOJu0Ywy3zha2XZEXVQJY6JSdazWYGZpBF+rL+jZtZgcXLIkZJP3hw2J
 oY11C8RjdAKMKM+cX4erPGqID9r3RJpjeI1lmyyb/qsYzNs3WnEHpggQ4FzFKSjw
X-Gm-Gg: AZuq6aJ3PXbcgAh18ldoYqUIAVP1C4nR6Y4T+dL9tBFIy0ZU8KCBIhEYs1bCL2v24HN
 qNidOjw9YfSn9wNOM017RP/11FsYyv34TcdT6bN/ZyEwjFbvQW51g1boV/jFHVpC8u1z3DS47XL
 /y81e8s3TxQRoQO9PG7UInpQSdOc0wGM+i6K9DyKYblP3+0BAg8/ICxpU43Rb2OUj9fTQWsuSxD
 Q7WI6BF8PlF23Bgwaj53bh0tOD6qakb3dywsw9FVTeYDoW81AURtDx2fZw88EFzHcZXxnKZ+JEA
 CyMy0E7ENLWSbnqBoqJ1bkR89z4j05NcMmOVmZ0MRuuzldD1qwB+gTm8fLP4g9vtklDbkQA5Oyx
 tVMBlGIC3QSkbJi7+X/+ZENKl/thUdCuYhujjEmZH6cbphsz5Tx6QTCyoFLogTbATKmg7oYYb7z
 UjiW44FOANzn+LDc8=
X-Received: by 2002:a17:903:3ba5:b0:2a0:7f8b:c0cb with SMTP id
 d9443c01a7336-2a8454bb247mr39884195ad.4.1769419749583; 
 Mon, 26 Jan 2026 01:29:09 -0800 (PST)
Received: from localhost.localdomain ([129.227.88.46])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802f97a8csm85568265ad.53.2026.01.26.01.29.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Jan 2026 01:29:09 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V3 2/3] iothread: Introduce a new flag to show iothreads
 attached status
Date: Mon, 26 Jan 2026 17:28:53 +0800
Message-ID: <20260126092854.20343-2-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260126092854.20343-1-zhangckid@gmail.com>
References: <20260126092854.20343-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62b.google.com
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

QEMU Need a flag to show current iothread attached status
when hotplug multi iothreads. For example virtio-blk.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/system/iothread.h | 1 +
 iothread.c                | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index e26d13c6c7..3d00474523 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -32,6 +32,7 @@ struct IOThread {
     QemuSemaphore init_done_sem; /* is thread init done? */
     bool stopping;              /* has iothread_stop() been called? */
     bool running;               /* should iothread_run() continue? */
+    bool attached;              /* Whether or not attached to device */
     int thread_id;
 
     /* AioContext poll parameters */
diff --git a/iothread.c b/iothread.c
index caf68e0764..38e38fb44d 100644
--- a/iothread.c
+++ b/iothread.c
@@ -94,6 +94,7 @@ void iothread_stop(IOThread *iothread)
         return;
     }
     iothread->stopping = true;
+    iothread->attached = false;
     aio_bh_schedule_oneshot(iothread->ctx, iothread_stop_bh, iothread);
     qemu_thread_join(&iothread->thread);
 }
@@ -199,6 +200,9 @@ static void iothread_init(EventLoopBase *base, Error **errp)
      */
     iothread_init_gcontext(iothread, thread_name);
 
+    /* Clear iothread attached flag for init gcontext */
+    iothread->attached = false;
+
     iothread_set_aio_context_params(base, &local_error);
     if (local_error) {
         error_propagate(errp, local_error);
@@ -336,6 +340,7 @@ char *iothread_get_id(IOThread *iothread)
 
 AioContext *iothread_get_aio_context(IOThread *iothread)
 {
+    iothread->attached = true;
     return iothread->ctx;
 }
 
-- 
2.49.0


