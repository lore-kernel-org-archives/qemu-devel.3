Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2702CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT4qE-0003JY-Td; Fri, 29 May 2026 17:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4qD-0003JK-Uj
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:34:05 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4qC-0002p2-6Q
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:34:05 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8422c327755so5506b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780090443; x=1780695243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tDeHKlljfDpSkFWWN2SnpQW0cIV42Ft5R4hhaWwRewI=;
 b=QvsLB6he1OB/yWjdkb2DfYhkKeGGsM/eqYxphU/GKFag3VtGFn4P3sSk6OpFdlOXrQ
 3hxT+S1Rx/5Y0lmfcuOYDA1u3mpt/1ePmIwGO3ZUDI+VQG8G9NAoAX4uFh9sG/6VwUrZ
 Rs1LmQ/daL/+nTJlIwzTvC5K8dSjKYZErEMf6pS3u16O9y9kPX3/hGRFlX1EJSH9Wn0I
 GaBa6xWWZxKepEhcVvxPLnEksXLi1/PdfAig4zrr640kJZ3NfUbWvFdFYHdCVopsbeFT
 qteMFJwtpSOCJPgpCxy0b+TWjZwmeSSt9RrFabz0c9EFvw2enD4d1HhWe/uRThULXXe5
 HZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780090443; x=1780695243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tDeHKlljfDpSkFWWN2SnpQW0cIV42Ft5R4hhaWwRewI=;
 b=SyZmUHwTBrQaR0/9DxT2h4qxzzBLVntfREhkl8raCKwkiq5gAALQYu30vt3wmeZSJ0
 OaDBxpHVvJh9dX9KeHRFIlybR0cfc3Tiq4YeISaVp2D9MACT+iZ+0wpHzSa+H4JPEfBM
 ObpuwECweK2AmBYmHp7eRtCwV9KAlGy/LjoFEyLqWZdrwzASVFqLct8tBM0xe7ukHk0Y
 fhYSBcKpmfRhaOjHEdvDtgnsmwUsZAy4XdXwXsd4xxYceHJnWlfguS8zwCY5XTVfwRHo
 brgHO9AlV9E7ElyBgWEbclymcXBN0fqhkR3ssaOcZV5xSPCKtTrimp0XBs/snsIrSgGa
 CJvA==
X-Gm-Message-State: AOJu0Yw/xgAzh/BiIMA2uaZiThMjlNOnPaj0o4NlOGtHndcraFEzXEz1
 dN0hqBkzMjkr+2P1Jw4bCdIMSwb5EPlLv3OszuG5CVCTcZ7RIriqECI/AIeuMPxvJUs=
X-Gm-Gg: Acq92OGhMmyzUzPjd/MIbtTr8cBXgUe7X9mKI9TA/F6NOVKUt14z0Gj3BDaOlq0ymgy
 allLCgDDwLp3+OGBn3ALDImpwlWuLVSl7wxdcKK+m/vKqgWhrR7+vcKWa2AW9RChktjs8PP19LA
 kQK4cxC2xho8DBRBCqNwzfm2tcPIqMem8hBbQJgDaOlU9HQWekV6v23AugV9EEPNwpzvo4EDTiG
 ZgNW7rUvtASMbDuBM/zk7mll0F95d7wFaGwogBGjPSj5pAOva+lLgAoA9w+wT/PHKe+TUXzvqbC
 OuGgo3b9VeQM/K9bHjHQrnf0LhpUOeEoEynpRjggnxbI0dCYE4Hz4xP8bSUSuKy3E6JXAeqddqX
 qC0DLMYAOsAZ0CytoD5EaaEUS9Edg7BALIXdHXQ+pkeNPMtq+tnhpsx++FDoGXJuxFxysov3yWJ
 7cjrW7lI8eyLXB4wJ1YDVPQSQbYz5W4dnLffZwRKkZwIYG1pMpdreEmKt8DvtaIcZzLFbezpHqo
 w==
X-Received: by 2002:a05:6a00:8c5:b0:83e:eeab:aff8 with SMTP id
 d2e1a72fcca58-8422543c27cmr1143929b3a.25.1780090442962; 
 Fri, 29 May 2026 14:34:02 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214affe29sm2779564b3a.3.2026.05.29.14.33.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 14:34:01 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V8 04/15] iothread: introduce iothread_unsafe_get_aio_context()
Date: Sat, 30 May 2026 05:33:10 +0800
Message-ID: <20260529213321.96271-5-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260529213321.96271-1-zhangckid@gmail.com>
References: <20260529213321.96271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x432.google.com
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

The iothread_unsafe_get_aio_context() is a low-level unsafe way of getting
the AioContext, recommend migrating to the new API with IOThreadHolder
as much as possible.

The blockdev is the first user:
Every BlockDriverState would need to get/put the IOThread AioContext in
bdrv_change_aio_context() or related functions.
However, the QEMU block layer has been moving away from having a
per-BlockDriverState AioContext. It is possible to use a
BlockDriverState from any AioContext (including multiple AioContexts at
the same time). I'm in favor of not associating BlockDriverStates with
IOThreads and instead relying on their device owners (e.g. emulated
storage controllers) to be the IOThread holders.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 blockdev.c                | 2 +-
 include/system/iothread.h | 6 ++++++
 iothread.c                | 6 ++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

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
index b483bbfab3..064c05e78d 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -71,6 +71,12 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
 AioContext *iothread_get_aio_context(IOThread *iothread);
+/*
+ * The iothread_unsafe_get_aio_context() is a low-level unsafe way of getting
+ * the AioContext, recommend migrating to the new API with IOThreadHolder
+ * as much as possible.
+ */
+AioContext *iothread_unsafe_get_aio_context(IOThread *iothread);
 AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
                                              const IOThreadHolder *holder);
 void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder);
diff --git a/iothread.c b/iothread.c
index 528002c34a..a85e960e45 100644
--- a/iothread.c
+++ b/iothread.c
@@ -468,6 +468,12 @@ void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder)
     iothread_unref(iothread, holder);
 }
 
+/* Recommend migrating to the new API with IOThreadHolder as much as possible */
+AioContext *iothread_unsafe_get_aio_context(IOThread *iothread)
+{
+    return iothread->ctx;
+}
+
 static int query_one_iothread(Object *object, void *opaque)
 {
     IOThreadInfoList ***tail = opaque;
-- 
2.49.0


