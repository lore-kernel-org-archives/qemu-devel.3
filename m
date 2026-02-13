Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3438BEEA84E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 17:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqwmh-0007b9-Rj; Fri, 13 Feb 2026 12:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vqwmg-0007aP-TZ
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:16:50 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vqwmf-0006xF-B5
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:16:50 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c6e2355739dso422378a12.2
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 09:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771003007; x=1771607807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sZmqtt/8+oeOxNbDkz0krc0Bz9lQjPbmA6qcD9QBIYk=;
 b=SPEpB4GJk+7YKZWuJf88REqdGtqbht2xjads1RSbCNLM/xl/xYBdHYAeL2ZypCR+0f
 OnRvKpej6ot0ZFiNdjLHlOmxIiB3hln32DwRPUvSQ8Yb+Y2lGyF0c/VuWVUvg8v99mih
 RSdKPKPbDjfXDCylvoBKh4Cvko4KCXr+K0SU2nYsEEfXeqLq2vzkkedqSGLHuz/LhyVh
 //O8rKtGaHmxA67kFMyUQVQUo+B41yrUfpgKAN37+DGRHs6GpQ5KmGABCYSWpOEhSvFV
 N93MeJBRwJbkq50R3DnSulvbEoSmCXtaRW1rTj4DXwP05Be7jP5muZ+mWBj45QFVEPqT
 1hPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771003007; x=1771607807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sZmqtt/8+oeOxNbDkz0krc0Bz9lQjPbmA6qcD9QBIYk=;
 b=OkvvDxjunyYqfXF7YHA2SMgwZiXUswkpoTTtzsxcuZEUy0jiph9s3fG5mX7QPn677i
 ugt5yBDA7oAAQF44wko1ghM4P/U2+o/kDUYlu40itKrgCkjsdo/VEudEdyNXqaBEah9R
 rHyi50zMf5Yb7wnab5E7YWa+d3jifyt/McxMbHgzr82qxUSUsesKmVA2t3ZgpcSgVb3H
 Tftzbf7kHc4eMN+che9xCY4fvMTC1y2So8+oMNN4xqvWG/XbjPQCnct+z5BybU5AxnSd
 KJmbfHJl6VY5iCXf/6Pvds9AXMRD0hU2npsmdAO+HRiiXIChyOQajXIiWRe4++8nwQj1
 43yw==
X-Gm-Message-State: AOJu0Yz1+BgPEJDMmptVZ1kf5vj91ZGaQHlh5uB78JZ74Ej78giXqRmU
 gFpOofPRmXihPZUzudkf6O9RFKcds674MqL2GKFIPfMrTH9AdF/Ec4GTIHyrPld4
X-Gm-Gg: AZuq6aKBc8sqpkpQGJLvg2LMkqY2bfQ2XB/xxosWFvQi6BuK0PrLXtOI7UpNVUG03Bh
 yLbwBY+1oOeDp+0bJPhWz9w+9/mnbPSC2h+QT70tNMZtpBY/h5hgSCP3w1afwCdDYMxf8bOOgri
 1QoQquntkp50j7RFF2t2i0VxjjDHU/+r5/SwLJUtNJ1M+TxdPxli1wXLk3e7hebB9XalZ2lqTEE
 F9m1lgG3SjQUACH4XcDSVAkXQYscH2BEx113YXMkCwaiajlsQSEV7RnYlyJHlZ8rOv8HwASD9q4
 MxxYjUwvjV0e7VzPMCRP6XOYIoD0bIbCqcoT8AmwKrWzhjmlIled6VeSn/dq/tw6p/scXkZbeWl
 nH3JC7ynXXwmR64HKA/RVrPIEz93hmVtmQe758WhPTHUGo5L68EN0Afiq5bhL2ObhaZVY9FxDIS
 tXfjl1+vx/zsWwCe8rPJ0sAwOmlFElkGjJiPw=
X-Received: by 2002:a17:902:da89:b0:2aa:d316:f30e with SMTP id
 d9443c01a7336-2ab50586bf7mr25872835ad.28.1771003007296; 
 Fri, 13 Feb 2026 09:16:47 -0800 (PST)
Received: from localhost.localdomain ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab29998c45sm87095575ad.88.2026.02.13.09.16.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 09:16:46 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V4 2/4] iothread: introduce iothread_ref/unref to track
 attached devices
Date: Sat, 14 Feb 2026 01:16:20 +0800
Message-ID: <20260213171622.55629-2-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260213171622.55629-1-zhangckid@gmail.com>
References: <20260213171622.55629-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x52a.google.com
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

Currently, IOThreads do not maintain a record of which devices are
associated with them. This makes it difficult to monitor the
workload distribution of IOThreads, especially in complex
hotplug scenarios involving multiple virtio-blk or virtio-scsi devices.

This patch introduces a reference counting and tracking mechanism
within the IOThread object:

- iothread_ref(): Increments the attachment counter and prepends the
  device's QOM path to a list. Note: The IOThread takes ownership of
  the passed 'holder' string.
- iothread_unref(): Searches for the device path using a custom
  string comparison (g_strcmp0), decrements the counter, and
  releases the associated memory upon a successful match.
- attached_cnt: Tracks the number of active device attachments.
- attached_dev: A GList storing the QOM paths of attached devices
  for runtime introspection.

This infrastructure allows management tools and QMP commands to
query the attachment status of IOThreads.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/system/iothread.h |  4 ++++
 iothread.c                | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index e26d13c6c7..4a2ffdb9bd 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -33,6 +33,8 @@ struct IOThread {
     bool stopping;              /* has iothread_stop() been called? */
     bool running;               /* should iothread_run() continue? */
     int thread_id;
+    int attached_cnt;
+    GList *attached_dev;
 
     /* AioContext poll parameters */
     int64_t poll_max_ns;
@@ -48,6 +50,8 @@ char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
 AioContext *iothread_get_aio_context(IOThread *iothread);
 GMainContext *iothread_get_g_main_context(IOThread *iothread);
+void iothread_ref(IOThread *iothread, const char* holder);
+void iothread_unref(IOThread *iothread, const char* holder);
 
 /*
  * Helpers used to allocate iothreads for internal use.  These
diff --git a/iothread.c b/iothread.c
index caf68e0764..b869637497 100644
--- a/iothread.c
+++ b/iothread.c
@@ -36,6 +36,41 @@
 #define IOTHREAD_POLL_MAX_NS_DEFAULT 0ULL
 #endif
 
+/*
+ * Increment iothread's reference count,
+ * and add holder device path to the list.
+ */
+void iothread_ref(IOThread *iothread, const char *holder)
+{
+    iothread->attached_cnt++;
+    iothread->attached_dev = g_list_prepend(iothread->attached_dev,
+                                           (gpointer)holder);
+}
+
+/*
+ * Decrement iothread's reference count,
+ * and delete holder device path from the list.
+ */
+void iothread_unref(IOThread *iothread, const char *holder)
+{
+    if (iothread->attached_cnt > 0) {
+        GList *link = g_list_find_custom(iothread->attached_dev,
+                                         holder, (GCompareFunc)g_strcmp0);
+
+        if (link) {
+            g_free(link->data);
+            iothread->attached_dev = g_list_delete_link(iothread->attached_dev,
+                                                        link);
+            iothread->attached_cnt--;
+        } else {
+            error_report("iohtread_unref can't find device. attached_dev=%s",
+                        holder);
+        }
+    } else {
+        error_report("iohtread_unref counter error. attached_dev=%s", holder);
+    }
+}
+
 static void *iothread_run(void *opaque)
 {
     IOThread *iothread = opaque;
-- 
2.49.0


