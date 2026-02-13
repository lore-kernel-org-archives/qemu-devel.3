Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C4EEEA84E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 17:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqwmn-0007bi-8v; Fri, 13 Feb 2026 12:16:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vqwmm-0007bX-Bt
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:16:56 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vqwmk-0006xa-Un
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:16:56 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2aaf43014d0so7894395ad.2
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 09:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771003013; x=1771607813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AQp38uncl2mXYNc9QQa5vUrymuUT0oK0UGeDzm2QtNY=;
 b=NfcI22/j10uBOEWIv6ePKyA9dF/WN/Y3JhyAR7wDA0cSVUUD8uJd38xJca/IIlAKDp
 UijKVFFg5b82zjYANO/YvCPvgB48OkWad+otXW6vazlhsMkShxbBCBQZrk0pwJ82BiFg
 8qf94HzrpY3Mc1DNcjcN25Y6B6SaRbk01NoUWRvdDeClhAeEdOzHUOBW1k2KLNTVtNKB
 X+R+LXVaDLAVLedBz/R0VLqVyHvkADrnXEutbGR7tfUKzt6Po8wArt1jYysXAb/R1vcX
 DfKyNyVzPV7CHoaOLbvoA2k1EJCp/ULesHJ6oqelj3ghFqOB9dyhfZA6HkBPF2F7naN9
 ogTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771003013; x=1771607813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AQp38uncl2mXYNc9QQa5vUrymuUT0oK0UGeDzm2QtNY=;
 b=wyCGlYoApnUEG03dt1m/miMZBtdPyv0uGeajiFcASCDwlrY0CedPn4O1sJYu4lMzpk
 X1m/HEuU5r/rQK1yLHVhVQsUZU++2F7V+ewwKi64h8KgzKeVhYTlx/P+s6xbscr6Qkr/
 8Dgk/n+c2fU21qCA47aU8twRoadMEh9zRtfocbrPU9IfjTv4stNL4sNUDvMvWd0BivgO
 mfWbmHtZqicA1xspSWXfQcssPwEyhxSEIK92zYRH0lnOxxTv+bmJvJKETAI3EZJ4zdu/
 dUEGcjQSVpxEZTYDMbb8j5GxsmOipq7XHyHxtayYMdcwq7BzGfy9Ds0bb+JCGjSXV+nt
 Ty2w==
X-Gm-Message-State: AOJu0YxbnSkPHmKOdioociraYprttFieF/DHVmoig+1gZra4/OoViDqw
 oBhxKKVt2kcwDVlzvzlGMOafqkGup/6zZf4Zd9BZIITHxiaCxJKDQFneu0j6KKkL
X-Gm-Gg: AZuq6aLKjEB/J1VB/SLAquB+UC2AgR0BRVrGZlPQoSOljMPFJPlXi6myu1IU+Dyx/6l
 81M2VUbW4371SfPq0P6qhidbynK/ZQq64IMtJeDD8v915voD4hqwrro0bC5NNRKeTPm6yA3eceQ
 nk7Po2XLrC5Sr4BV1Ms2DH53YEAJxwVIvR01p30cKn78w2xuBhQJFIYfMgSkkbS1rHn7JS1DS/j
 gLrmhoL1wC1sEZgtPxHFk1c61ngNr4Ssj1KCxPHiMsZQVDvGzPX7g2BeR8TOu3nAdJBTSXiQyFj
 MRkvVMfF86ygk9J2+CPS8LVshdRWsYiwlFsN5T/n5Uc8TmVPURuoIr3iUJMwMYjguBYsOqBAfPX
 mYqDgDZD/QaobedNZ3Y8dE82JWuyFQzOnvXmzImvxR2AZ9hDNorJK6GTX74clN6fWDZPQ063Vyi
 H/OB6fOf6G+2fmF0UyIVAdVhB9tIb+FwHbd/vVFf+Qq70cdQ==
X-Received: by 2002:a17:902:fc85:b0:295:745a:8016 with SMTP id
 d9443c01a7336-2ab4cf4f475mr39447505ad.11.1771003013231; 
 Fri, 13 Feb 2026 09:16:53 -0800 (PST)
Received: from localhost.localdomain ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab29998c45sm87095575ad.88.2026.02.13.09.16.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 09:16:52 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V4 3/4] iothread: track virtio-blk devices using IOThread
 reference counting
Date: Sat, 14 Feb 2026 01:16:21 +0800
Message-ID: <20260213171622.55629-3-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260213171622.55629-1-zhangckid@gmail.com>
References: <20260213171622.55629-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x635.google.com
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

Add reference counting and device path tracking to IOThread to monitor
which devices are currently attached. This is implemented by adding
iothread_ref() and iothread_unref() calls during the virtio-blk
AioContext initialization and cleanup paths.

The IOThread now maintains:
 - attached_cnt: A counter of devices using the iothread.
 - attached_dev: A list of QOM paths for the attached devices.

This tracking is essential for management tools to understand the
relationship between IOThreads and devices, especially during hotplug
and unplug operations.

Future work will extend this ref/unref mechanism to other iothread-capable
devices (e.g. virtio-scsi).

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/block/virtio-blk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index ddf0e9ee53..247d6d41f3 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1462,6 +1462,9 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
             return false;
         }
     } else if (conf->iothread) {
+        char *path = object_get_canonical_path(OBJECT(s));
+
+        iothread_ref(conf->iothread, path);
         AioContext *ctx = iothread_get_aio_context(conf->iothread);
         for (unsigned i = 0; i < conf->num_queues; i++) {
             s->vq_aio_context[i] = ctx;
@@ -1491,7 +1494,12 @@ static void virtio_blk_vq_aio_context_cleanup(VirtIOBlock *s)
     }
 
     if (conf->iothread) {
+        char *path = object_get_canonical_path(OBJECT(s));
+
+        iothread_unref(conf->iothread, path);
         object_unref(OBJECT(conf->iothread));
+
+        g_free(path);
     }
 
     g_free(s->vq_aio_context);
-- 
2.49.0


