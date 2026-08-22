Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1218C5B572
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 21:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxtM7-0003eh-0B; Sat, 22 Aug 2026 17:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtM5-0003eT-Mo
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:21 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtM4-0000g1-7p
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:21 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso1334417a12.2
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 14:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787434459; x=1788039259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pezo7fi75ZfIl47wCCjUatKsRrnsz18bI2OMJSruO40=;
 b=ecfPtH5kKPOCLbJO8EVjuDWxMdf7eWT7qBldhWZ6Rc3VPJYWrwpTvCngGnXbUJ4DK7
 04KQPeIGsrasu8o4lHLLOFL3lFqKLnqkE7qQGWJqq7t+6BBub4+Nc7SQ6oyMXeeuh13p
 cBjJtVSba7+GJtnp2PLhaRYxxuUG2uXm7nBRcXtzxbtdpcYANV95yrk8Qcjo5YsuYVgJ
 M9UJi0Vr1y4zyWb8QsVl2hbMmmubok/R45IE6lrYRnczZbXGxveVR6EuGt+6Y5cEBsp9
 5O0r0q4xvv3wJ4F8tRAugOWflQnXevzajwF90kuA1txmmpDdscpHEepwl3nvFwUdrZn1
 ghwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787434459; x=1788039259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pezo7fi75ZfIl47wCCjUatKsRrnsz18bI2OMJSruO40=;
 b=Us+3NzzsGOK1JraoSJfhneRdGZQTVnYby5BiHs7D7mR9v+cIHe9LYvvxlOqiVnoOZX
 j4A0rgIrN/P0/Sb+FjGMpcdTtZJyvKBhv2C63vXmDur5xMYn864EZULntHZ5x3RPMhai
 HM1uNRBfJrimoUzT3fL80hEtYd3K5GXxc4buCjjWfLnWcS/+3FaeuZSOzKUX8N3cz75o
 UuAcuo2VT11XnWcQgD/rjiH6AS1UWmSfvxdZSeOwwiEYxuzsOl+rOHnbPHIbV8PSNdTJ
 dXDwRail6W+jDcnS2RXzHVO7MX8gVMnzSz+WAc67CpP0ODhXuX5wtLrDy0d0iFP2fBid
 Q0Rw==
X-Gm-Message-State: AFuF++k1TCFSvP+PJ4OZrGvj38GaCP5zT9rFmunxckc+2dOhOJf3wAnD
 NXPZnEXAJPoMi4xO3aidK7nlfTIjAAsyKHM+bnG/BuekeLDIPlZr5k5K8b2KoPsEchRjJPYZ
X-Gm-Gg: AR+sD10Z54ExZ1LAAv4wdIAiiwWJXeeQDh9MinZx7/e4ifwy9wt+l8SoNmJ/xr47UJ3
 25iT80HUc+y7Cf/78rN+Um/GXSRUNq32V/yZ9kVjtEhdvHjRnkCyTcZh0Y3GJYNumejg+/4WZvF
 pKNAPiJ3ynajAE15d/ElTIznpytkoJjQ+2/waYyqaaR/hOhgkP9TX1TERZ3u9vvB8znAU4faIGX
 1CZmB35I3q/QuloL4G4Jgvw05qANygF9RkC3JrUp7XYafi4p+yfYVoDzOwWE2QrkuSCdqa7CSJd
 2CNTkBWmJaKrJeESfzbwDe3zOuymtXVARaKr5hDlCBlgIwu++8f143Z6OK0LlIn5o+wImvy/k/N
 TbBFeY4lHgihwWRzbtFEiVToZlDCT4uOd8qmhXSkvRN220BcOHilyD/DHt+DvAzOKXdq/tEUGfO
 7dOWqz/rC7QVGQxUIk58zRfh0M5Pj5SuagdoGr3Q4z06SK5IwSERPx1SbJguvcnUKM0vGT4H9EO
 qt/MU5gi2t0O713Znc=
X-Received: by 2002:a05:6a20:c705:b0:3bf:63af:85d with SMTP id
 adf61e73a8af0-3cd30178908mr33305095637.18.1787434458857; 
 Sat, 22 Aug 2026 14:34:18 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f909c6c9sm11633181eec.6.2026.08.22.14.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 14:34:17 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V13 04/15] iothread: introduce
 iothread_unsafe_get_aio_context()
Date: Sun, 23 Aug 2026 05:33:27 +0800
Message-ID: <20260822213343.661939-5-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822213343.661939-1-zhangckid@gmail.com>
References: <20260822213343.661939-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add an explicitly unsafe accessor for legacy callers that cannot
provide a matching holder lifecycle, and convert blockdev.c to use it.

Keep iothread_get_aio_context() temporarily so that later caller
conversions remain independently buildable. It will be removed after
all production callers have migrated.

New code should use iothread_ref_and_get_aio_context().

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 blockdev.c                |  2 +-
 include/system/iothread.h | 10 ++++++++++
 iothread.c                |  5 +++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 6e86c6262f..baeab3a3e1 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3683,7 +3683,7 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
             goto out;
         }
 
-        new_context = iothread_get_aio_context(obj);
+        new_context = iothread_unsafe_get_aio_context(obj);
     } else {
         new_context = qemu_get_aio_context();
     }
diff --git a/include/system/iothread.h b/include/system/iothread.h
index f6c5f95dd9..2ef8c1a1bb 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -68,6 +68,16 @@ char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
 AioContext *iothread_get_aio_context(IOThread *iothread);
 
+/*
+ * Return @iothread's AioContext without registering a holder or taking a
+ * reference on @iothread.  The caller must ensure that the IOThread remains
+ * alive for as long as the returned AioContext is used.
+ *
+ * This API exists for legacy callers without a clear ref/unref lifecycle.  Do
+ * not use it in new code; use iothread_ref_and_get_aio_context() instead.
+ */
+AioContext *iothread_unsafe_get_aio_context(IOThread *iothread);
+
 /*
  * Register @holder and return @iothread's AioContext.  The holder is copied,
  * and a reference is taken on @iothread so that both the IOThread and its
diff --git a/iothread.c b/iothread.c
index 58dace351c..803d6ce3c3 100644
--- a/iothread.c
+++ b/iothread.c
@@ -443,6 +443,11 @@ void iothread_unref_and_put_aio_context(IOThread *iothread,
     iothread_unref(iothread, holder);
 }
 
+AioContext *iothread_unsafe_get_aio_context(IOThread *iothread)
+{
+    return iothread->ctx;
+}
+
 static int query_one_iothread(Object *object, void *opaque)
 {
     IOThreadInfoList ***tail = opaque;
-- 
2.55.0


