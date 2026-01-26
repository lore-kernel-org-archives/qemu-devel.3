Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDECCF65CB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 09:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkJ9I-0001pN-2X; Mon, 26 Jan 2026 04:44:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vkJ9F-0001lQ-En
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:44:41 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vkJ9D-000152-Px
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:44:40 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c3e921afad1so1488567a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 01:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769420678; x=1770025478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+a3OwfwQBO2otyKeHBN1LrQH4TMfKPwgsXvF1+xAS4A=;
 b=lNvnhVA/NQlQDR4wps7g7ScPrjQwDbnnXJkROWIEbCvSqGIVA1n61N35jQlumEn0tp
 YgV8SE8VSn2DFyUqco2prXf6j/9A0lck/AVVgMT+v12AuZBxSggnYQYgzK3q9+/Z/Zer
 El1WLMMw6gOZvgX2wk++ojhI2XsW5V6XCkcSmlhLbOg0UJ7/TNXeUSTxKuF6EUp52tPt
 mPTQKuvU7uV85gGafjLjcQQFLwXMY1BtVJ4gzzLUmQi+rJMqoYGSHxwCK9Td1NTm3DkW
 wfyOOMfKd5YBDtX33BEyzsDkzGvQ+yPxcU2NRQpyif9yZZU7eTSQJZJMy12lA6YLfdp/
 904Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769420678; x=1770025478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+a3OwfwQBO2otyKeHBN1LrQH4TMfKPwgsXvF1+xAS4A=;
 b=RegERLry+ISjBLMHUpxZkCpzVnB3Awc6I3Vlk3vIvNqfk1FhdRM+LXKVO3ZGuiqoAw
 prSqwqneABTfWOMS8zmYcP53u6rQP90eVru0nMWwrpwzogBR50kK0ONplef2a1xXqRpD
 LJN9nN4fROUzWmgG35H+WZBih2oLdmxCDyR6RI9rQgE1u3r+HABNUqBC04/lMsFpgaOL
 L6OGYme/CY+1dGl3Lv7AjASPLENfamZnc7ozZmda5aUuZxb3qK0v84ihYkdSXOs5hnTu
 2JFbG6fB66EI7aTXHhrDRlCQmB4e4t/zM5Q/vu07SgQGbgu3dcLSNy0eh7chLP0b1z1d
 6y2w==
X-Gm-Message-State: AOJu0Yz18UIIi2ortzVTsx2kaP9/MY6nlPBjvt83lYlqKdvmqL57WDuC
 vBlMIeb6eS1rYWawvT+il7F2hH8iFWAyHyKsWGWrRqXmIQWG6Mai0MIq1SDT9CnY
X-Gm-Gg: AZuq6aJLlO1G0ImlGHji1m8TQ9rkS11Q9IWXTJTUgpp5hQUOnrik8OhyiORoL9LCkb0
 Z8n+x+Z/onf6cy2cR4JAMOXg0x/DAz9JK72gnN5lKen7uwDFvVNcbE06+HY7SwqIsB7GpFaT6K6
 8ZseqofW8dnlKAUffGcGVd7KgKtC9SXlfxyFAZmkhJ1dj0y8X+wgXIaNI+9hPV1YqbNKcSDvxNI
 ZIejBWvE/7mCtx7drroXjPq/owIjzgr3JZnCst7VDg9dfkuSZFpG5D0XN/yTEdWnuxlVY/a3Kwx
 GCh9qm349mqSYfMpYzkkV2NGmdg8vnyvqKyhGAwB3TnErhX7H6MH1Tn2O06zjnsevpVMOa70fhB
 ciLjrAoeO2CCd7e0oX/QfajlGvXOjzhg6/7eosTEJrFSw7vz9aWC/g6+NcGPwJ4yDWNtld3FRZD
 2/g/vrBQ8KMGAixSw=
X-Received: by 2002:a17:903:1a4d:b0:2a1:5f23:7ddf with SMTP id
 d9443c01a7336-2a8451f8876mr37342235ad.6.1769420677907; 
 Mon, 26 Jan 2026 01:44:37 -0800 (PST)
Received: from localhost.localdomain ([180.87.170.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802f978d2sm85605585ad.52.2026.01.26.01.44.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Jan 2026 01:44:37 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [RESEND PATCH V3 2/3] iothread: Introduce a new flag to show
 iothreads attached status
Date: Mon, 26 Jan 2026 17:44:21 +0800
Message-ID: <20260126094422.23116-2-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260126094422.23116-1-zhangckid@gmail.com>
References: <20260126094422.23116-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x52b.google.com
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


