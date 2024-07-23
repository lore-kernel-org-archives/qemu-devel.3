Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22DEC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWGIu-0003tF-Mg; Tue, 23 Jul 2024 10:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGIp-0003ZF-UH
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:15:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGIn-00076c-J9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721744140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bBmdKai45m+KPRGpnPmMNJlmmK+aMNov4HIpoz9yWEc=;
 b=K2zwHlYfgsjpeklKkqK4ADoXkjeZqLNEMwsbisL5SaCSs8XvtUcT5EP6vhGLKixxnLC96E
 XeS7cgOdK04iy2iba/9hWvKo6hOEt3sHCuPYJ1mxoGfA0RYv271T4XEJDvBzKfWDg3cHl4
 8LD4uAiYX1EHdT7ZglYgMFPTWXZuuO4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-t2-ZsSfwNtOO94jifnHmVg-1; Tue, 23 Jul 2024 10:15:38 -0400
X-MC-Unique: t2-ZsSfwNtOO94jifnHmVg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4266d0183feso44819465e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 07:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721744137; x=1722348937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bBmdKai45m+KPRGpnPmMNJlmmK+aMNov4HIpoz9yWEc=;
 b=mYWI9MjKKtEi6Kux0oB1URBI5NGBbKjIIz6XBQPiM0rrIOBUXJXiRLfaufPBM7TM8R
 gBn7ObCeZQZpig7BFsnE9LPFKwkfBeLhwwDajZFMO3jh7bU+UFL2FaiuyS/B8/4seM/w
 AS0/tgRUhJSxZph6aeUSJLNXnmstHZAc25Rttgmn5f9mzBx7Ysx2BIfZkhjEXI7RVSpm
 9BhdciUBqnBLYSRGl3tYPjynsEs/98QKGu4Sq0zmYXPiIeJ7ACloyXKVOqAN5ENMzUuA
 HogETTZbOAbXl0i3P7Bub0ai9Ch9506SfVOEY0l6FctFm2uh5T70dXR73F9ZauEuZtVK
 WYTA==
X-Gm-Message-State: AOJu0YyEJcuXYcPm8ebEMdKJgITgOuQR6VO29VLlvlB9OQPIDCoAfgFW
 7QEPW/RzTNPH8LxeT8m/lJAfIoAg6HpMEvm0Mw+MT674z1uTYGcib60GYLPFjuhOsLFvNhvuJbR
 Qt6JZEprMOjhuCnmpF/xVUB4uogAhOpbE5o+EUp4KHu3X7jk49sOL7CbQbut+3Lkdy0WbVFmV4m
 lcJc4xbcpZFdOrc7+nHpfVMp/qsD1VpiOLH86B
X-Received: by 2002:a05:600c:3c9d:b0:426:6099:6eaa with SMTP id
 5b1f17b1804b1-427daa61cddmr74485865e9.26.1721744136932; 
 Tue, 23 Jul 2024 07:15:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1WmZOVIPFr3SV8Utd6M7VXVHkmQhO8fASyQ0E1GUBvBQ5eNnRgJfZIovOMxeABpGol8Q58g==
X-Received: by 2002:a05:600c:3c9d:b0:426:6099:6eaa with SMTP id
 5b1f17b1804b1-427daa61cddmr74485685e9.26.1721744136519; 
 Tue, 23 Jul 2024 07:15:36 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a5c3d4sm202265145e9.17.2024.07.23.07.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 07:15:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Anthony Harivel <aharivel@redhat.com>
Subject: [PULL 02/11] qio: add support for SO_PEERCRED for socket channel
Date: Tue, 23 Jul 2024 16:15:20 +0200
Message-ID: <20240723141529.551737-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723141529.551737-1-pbonzini@redhat.com>
References: <20240723141529.551737-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Anthony Harivel <aharivel@redhat.com>

The function qio_channel_get_peercred() returns a pointer to the
credentials of the peer process connected to this socket.

This credentials structure is defined in <sys/socket.h> as follows:

struct ucred {
	pid_t pid;    /* Process ID of the sending process */
	uid_t uid;    /* User ID of the sending process */
	gid_t gid;    /* Group ID of the sending process */
};

The use of this function is possible only for connected AF_UNIX stream
sockets and for AF_UNIX stream and datagram socket pairs.

On platform other than Linux, the function return 0.

Signed-off-by: Anthony Harivel <aharivel@redhat.com>
Link: https://lore.kernel.org/r/20240522153453.1230389-2-aharivel@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/io/channel.h | 21 +++++++++++++++++++++
 io/channel-socket.c  | 28 ++++++++++++++++++++++++++++
 io/channel.c         | 13 +++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index 7986c49c713..bdf0bca92ae 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -160,6 +160,9 @@ struct QIOChannelClass {
                                   void *opaque);
     int (*io_flush)(QIOChannel *ioc,
                     Error **errp);
+    int (*io_peerpid)(QIOChannel *ioc,
+                       unsigned int *pid,
+                       Error **errp);
 };
 
 /* General I/O handling functions */
@@ -981,4 +984,22 @@ int coroutine_mixed_fn qio_channel_writev_full_all(QIOChannel *ioc,
 int qio_channel_flush(QIOChannel *ioc,
                       Error **errp);
 
+/**
+ * qio_channel_get_peercred:
+ * @ioc: the channel object
+ * @pid: pointer to pid
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Returns the pid of the peer process connected to this socket.
+ *
+ * The use of this function is possible only for connected
+ * AF_UNIX stream sockets and for AF_UNIX stream and datagram
+ * socket pairs on Linux.
+ * Return -1 on error with pid -1 for the non-Linux OS.
+ *
+ */
+int qio_channel_get_peerpid(QIOChannel *ioc,
+                             unsigned int *pid,
+                             Error **errp);
+
 #endif /* QIO_CHANNEL_H */
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 3a899b06085..608bcf066ec 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -841,6 +841,33 @@ qio_channel_socket_set_cork(QIOChannel *ioc,
     socket_set_cork(sioc->fd, v);
 }
 
+static int
+qio_channel_socket_get_peerpid(QIOChannel *ioc,
+                               unsigned int *pid,
+                               Error **errp)
+{
+#ifdef CONFIG_LINUX
+    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
+    Error *err = NULL;
+    socklen_t len = sizeof(struct ucred);
+
+    struct ucred cred;
+    if (getsockopt(sioc->fd,
+               SOL_SOCKET, SO_PEERCRED,
+               &cred, &len) == -1) {
+        error_setg_errno(&err, errno, "Unable to get peer credentials");
+        error_propagate(errp, err);
+        *pid = -1;
+        return -1;
+    }
+    *pid = (unsigned int)cred.pid;
+    return 0;
+#else
+    error_setg(errp, "Unsupported feature");
+    *pid = -1;
+    return -1;
+#endif
+}
 
 static int
 qio_channel_socket_close(QIOChannel *ioc,
@@ -938,6 +965,7 @@ static void qio_channel_socket_class_init(ObjectClass *klass,
 #ifdef QEMU_MSG_ZEROCOPY
     ioc_klass->io_flush = qio_channel_socket_flush;
 #endif
+    ioc_klass->io_peerpid = qio_channel_socket_get_peerpid;
 }
 
 static const TypeInfo qio_channel_socket_info = {
diff --git a/io/channel.c b/io/channel.c
index a1f12f8e909..e3f17c24a00 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -548,6 +548,19 @@ void qio_channel_set_cork(QIOChannel *ioc,
     }
 }
 
+int qio_channel_get_peerpid(QIOChannel *ioc,
+                             unsigned int *pid,
+                             Error **errp)
+{
+    QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
+
+    if (!klass->io_peerpid) {
+        error_setg(errp, "Channel does not support peer pid");
+        return -1;
+    }
+    klass->io_peerpid(ioc, pid, errp);
+    return 0;
+}
 
 off_t qio_channel_io_seek(QIOChannel *ioc,
                           off_t offset,
-- 
2.45.2


