Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21ACEC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6QF6-0003R2-Qe; Tue, 15 Sep 2026 06:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6QF5-0003Qq-7d
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:18:23 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6QEd-0003Dr-Vn
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:18:22 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4bdf8acd6so2228852a12.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 03:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789467474; x=1790072274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RrbAuQeObwoe3B44WXO+dXDkeSkoTkk1yzxeYZ2Gj5k=;
 b=DxTrobxiXxyzvGz3E2W59sMes0SrmV7J3H1p7ABclT1QGQhVX4RPnlsgaAXN8JY/Qf
 2aheK6RaD2bL9aVxfwANpN2tQAGfLoXgSmhC8cw5/Ftc0ciN1cv6oq1qUOR9cXvONHLD
 Hz7rrMYYoT5w6756u0chEX5MVKzOqxeabmqH4TIE89vhwMA5tv1PO3vM67PDdG/b/XDL
 UYrwKOpWUu4+y0Rm4SxLZYENMOyPuZMtt4Wn5+nsqCFQ0SkdHW7DvgWnRawnwySQk+XA
 /7Op4l+8oaHPOCxp0OOdjUK7X9eTK79hLgLg8dvMNB5M0kX2J8rrsSsgbzpohXCL8Guk
 90EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789467474; x=1790072274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RrbAuQeObwoe3B44WXO+dXDkeSkoTkk1yzxeYZ2Gj5k=;
 b=V+5uhDb+Tav6qUqeFRLkb6Y4zCEzAJihryE4agZZXPf4OZWAU4lT3IGJlqPHCOO2C0
 TmXfA2px7u1bIKPQRFjmC7yNJD+8gILdL4JfjwQOYBfdlhW7kfIK/ha8efr/NHco7bRr
 mSFW6kV4zD2637npZDlYapckppnIbEOZnE1OKxq0hSB6XnZ5mB02E3Qym81S+UjKWLdB
 uCYtSlb1KqTcnXFsddgejBcJ5k4Gbu03J8qbEKhVOyp3nKK0LwiJtTTTT3M7DZMm8eLm
 N6QdhzKCGU0OsqrDe2yovLlIQbqutWB/C9PteW4HSh6eT2iFUS8fBTyimZvihsQAwDwf
 SKlA==
X-Gm-Message-State: AFuF++n4CIeplHQj2qM7S7CFSITCdF+i2wY+fhMu2weq475CKcFaWhWr
 8jUfanzSvaoJIVSyQ99CkNSa1iJDaijOgOc7nuwSy5xxAkfFqcq+yBGohsoy2w==
X-Gm-Gg: AYBFou2pdMjVNDxkWxPgxXxLOys7/Bd9eEWA+Alhu2sKPXsWQQ1pEBZNRaFB39kz2rX
 0QzaDFef19hEUYB4fkfkHW7fCkVPUMfQH+Nd93vaLQdXjVY/0NEW17tZcjVnYFr5FtH8FBNuiIU
 Y0VZit3h+ldNRHH4B2u2MSNKJwg1tFLfA+JAkrjmlwIdMftaueL3NxLNbXbCigHsACtegOYkiJN
 dzfaSgsFd6Z+NprGsnuBAQpbux2wq4rokwNmOcE7WBbWKibbNuNdooX84vzGmueau6NivU2thgO
 k0mJNY6196fc62gD7Zu0UBmTICe3lJApMsyNp+jDjrwcAv8xgWVZcBRmz0ab2EcTklXOwAUVaWf
 X4nsXSXCTQNZO7apFm+18YI9cRSa2M50t3r4xoSiCOUvuVVi6dqlpmEKc4AX19mZzYTO87JjhXd
 iVKBvO94Ipkd2SKoMIkFfNX80JDxeRquGU07TP4O42G+xoJSMCgljrkKGXkIfJzAymiRG92y5eD
 0d26CyeTGD4HFadAboIV1d9BIE=
X-Received: by 2002:a17:90b:1c81:b0:39d:f66e:1720 with SMTP id
 98e67ed59e1d1-39df66e17d0mr10792199a91.13.1789467474536; 
 Tue, 15 Sep 2026 03:17:54 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdacba6bsm4416868a91.14.2026.09.15.03.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 03:17:54 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V17 12/13] iothread: make legacy AioContext getter explicitly
 unsafe
Date: Tue, 15 Sep 2026 18:16:54 +0800
Message-ID: <20260915101655.3216101-13-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915101655.3216101-1-zhangckid@gmail.com>
References: <20260915101655.3216101-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=zhangckid@gmail.com; helo=mail-pz2-x10.google.com
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

The block graph retains only the AioContext, while detachment happens
outside qmp_x_blockdev_set_iothread(), so this call site cannot provide
a matching holder lifecycle. The new name makes its existing lifetime
assumption explicit.

New code should use iothread_ref_and_get_aio_context().

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
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


