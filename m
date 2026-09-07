Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBC3C79FA3
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3T05-00061m-RU; Mon, 07 Sep 2026 02:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3T04-00061e-5L
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:38:40 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3T02-0006Ag-H6
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:38:39 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2d942c7cc2fso25000115ad.3
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 23:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788763117; x=1789367917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=80gGLHUNp9a2qS0zepvCgbYVB3aORrvxr/A17drJBkg=;
 b=gUBEFDji1yI/HvOx/vIsKOPcRuoWRsf0uj7mH/q9vtq4BlOlc5CCbZMPTPtbJeWxvq
 GD0ckgvodgAU/xm2mpF6Zlah5Dzs5i/NKK8V/H237th588O7oHbSPiX3H4IpTGJMS7ur
 i32AGxOnlhdrJjFOeUgWyF+eOCfHg89tTxbzIbUCbGRngieLLL2xI+OFrD34IGQbATmi
 x4J590cNfdLKk/8dWRN9p8N/D1j+YgT4iF9kPOKzNKI6LYcCB97Ryheo89ksAu3dB3bg
 iloqRqokYLTCICGGBGHGrpNfMnYpWTWTV8O9/+2sR1G5Mij1gQBOsey/IDi4bHjpkNAD
 tDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788763117; x=1789367917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=80gGLHUNp9a2qS0zepvCgbYVB3aORrvxr/A17drJBkg=;
 b=bBZMw3SSXezrqjTn6fG266U0uMtemmOyhAV61NRfkVjn54JM1NTlqcDX19Z0y9Li/j
 k2Yo2PIC4Vgyb5Eo8yGHWLoBhVhCfjl8uXqmvIxcZfOSxw4zhVQEtWWCImKcJnCH+gqn
 rxyYLarKs7FxtbwUnP7H4slolSAE2hc+9HnTeq5pU19ZATLKajuYhbHn3EgZq/pf2Czz
 R9rehDr9UabrGHr2vXaRsvmvbW4fZrWw49ix/IZtu+MwmAZyAwEpMf4dtOdXDwNH09ZP
 8ePAskFg6VszTGTP65bptZVdlwIRr1cVsX/3qKeWKwoYnab3wDqRQ0/E6iB2L0VrwOvO
 fN4w==
X-Gm-Message-State: AFuF++kOSbCu87Bf1h4Bj2B3ykwhGdB9xuKvwe9tIMQmF2vzkuH9+TQk
 RdrEzWnltea5nKcAVlNZ+22QMpbLt6Rt7NCjcM/Osz0kqXpfwphYqsttMWvMAvhcXKCAcQ==
X-Gm-Gg: AYBFou2RnTSMnfQvB1EL6SvX5dr6PVn6V4kYZr+186CieIUaMEQ1WzzcrYjrg+GOR/g
 j0awogMOTfO/yQqk5CLHpvcJi7+RrZvEPITGgCW9jNJALm1NtJFDP7x0tH2CuXGHVhGVTl19Y7h
 FVMG80OKPlaVrT+qABtHo5j/5JDT5tW94n3jlz9h8aKawmQJX+MoGMXO4tV9tkZ7hLBMn/CXLJy
 3Ar8c+qWmLPLxIriaRSDIH4kjUKNfjX85pnRMVgB27/K1WfflSarOAvIBkPbOR/iTsOpkzZwBgq
 SSYcXqGLXkLiNVSuXiRkvqpBTJeCB4tSj2NhIvdMdfLqBZd45IDHgRvHz8YN8voGcM9JzOP37u+
 Vcq6YgX2bRxOJc37a1VwilM3C7lYYNBki9uuGsqT35G9ugGSjvP88CP9I4apEIr4HhZRQ7FXtJw
 yYUlwClnP3xNjuenlP1WOWpM0DJrdkPmoL5JEQRCgqYL+CgAM+sBAbJCAS7idIkjmXKSJyTWBFW
 q9V2JXf6ebIYX5G
X-Received: by 2002:a17:902:ed8b:b0:2c8:2808:3ec9 with SMTP id
 d9443c01a7336-2db126d8fc2mr198500665ad.12.1788763116472; 
 Sun, 06 Sep 2026 23:38:36 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499f06fsm38502555ad.54.2026.09.06.23.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:38:36 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V15 13/14] iothread: make legacy AioContext getter explicitly
 unsafe
Date: Mon,  7 Sep 2026 14:37:24 +0800
Message-ID: <20260907063725.626685-14-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907063725.626685-1-zhangckid@gmail.com>
References: <20260907063725.626685-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x630.google.com
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
update qmp_x_blockdev_set_iothread(). This avoids adding a duplicate
accessor only to remove the old one later.

The block graph retains only the AioContext, while detachment happens
outside qmp_x_blockdev_set_iothread(), so this call site cannot provide
a matching holder lifecycle. The new name makes its existing lifetime
assumption explicit.

New code should use iothread_ref_and_get_aio_context().

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 blockdev.c                |  7 ++++++-
 include/system/iothread.h | 11 ++++++++++-
 iothread.c                |  2 +-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 6e86c6262f..97d161079a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3683,7 +3683,12 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
             goto out;
         }
 
-        new_context = iothread_get_aio_context(obj);
+        /*
+         * The block graph retains only the AioContext, not the IOThread.
+         * Context detachment happens outside this command, so there is no
+         * point here where a matching IOThread holder can be released.
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
index 58dace351c..ae9290c733 100644
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


