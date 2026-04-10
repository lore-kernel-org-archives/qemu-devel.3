Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FACF459EE
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBDQe-0007Hw-56; Fri, 10 Apr 2026 11:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQc-0007DM-RG
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:50 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQb-0002YQ-D0
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:50 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-35d932cc948so1558922a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 08:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775833547; x=1776438347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23F2qkNukByaUJQk9pbl2bbnzE/ZXLLhOxWd32Zs67g=;
 b=W6Jjm37tW5CCR7sEIjp8ea+Kof/SrYYfjWlDOnsSoxN7aSbjObtemRxW87MMYBqJXH
 VfcVmqXTboESP0wU8TxFn5qGaON8cD8PRh3ZZs8/f9YgbvSLEflRrRqAf57NayEwhNWm
 ps5SnWGouMqH67Jz9bu6BP8hBqgid9OHaREBvZUYmkmsX+oOpSi3ru0pLit5o4k5foZR
 aNQToUO8ll/Y7E7v/1est8PwpEIXhLV8OEv//7uxzTpa/C730wHZQhiJxeBThil6uY3F
 xRbiM7xzPCQodnRVVMfbVMIDsGqcoIihHPWdmLa/tGKh/fIGpyCdIDiZAp5qft35M0ax
 OEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775833547; x=1776438347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=23F2qkNukByaUJQk9pbl2bbnzE/ZXLLhOxWd32Zs67g=;
 b=fTGFtiTZ62dv0CiXzpCSYIAGf7rT5GM+XS1c8UV5fgNBKbEZlWhdVMSVs26WXEeQMr
 TD8n7SBunfXspmbzVdSwZfk4r2B1V4eJSytw2LLPbttGviVXSdsa4/vP/2rlhBP1uNHO
 sSvBTOnCoox1+md3SqV1B2xRPYpwVVFL4YvKGFdEV8ss7aRoVHCCl49ms2wjnv1BNWut
 syF+x63A+BftBxj3GU3cjVwYFTUdPsUsRAjdPPOMh08Oyl01936h8ER8hpHHmLMcKwBV
 l86qlUvzU+SugkiIXpckgd6JFgj+YDmVvq9XnCzr/r4uBgciD/X5Pew7uc5tmfCg1xUl
 l6Xw==
X-Gm-Message-State: AOJu0Yw/6WUBomRPIy0HszHp3Nd9LviC4S214Kd4JzR0j6Qdt1m8Zm2G
 p906zitKdWoGOl2gmAXGR7XSKNGmvDrA6+gfWMI1qc7ED5OhD4ymtmhNWLBUlVPS
X-Gm-Gg: AeBDieucZOCjejLro0cKIfEDx6Q0TqfpctHHH7J7rM+wXqiuvMuFw7Q99JPHsV07Bhd
 J8/b/G7vYmAh9H9Qhrszk4qyThTMe4uioszGKcPNhfHDrPoOwxL+stFAkkiYHK2Nr7sQum17lr4
 WxyUOH+tjUPF5U/ypqtZACglgZGTJgChDNCWCiwIYTBL051/8udJJlA4SkDqQywwDyHOAjTgC7y
 cvEgTpOnI2+pCDwF6P9iQuf/A2oJ2aZewMhJkBamgrgmOvjmRlYwbFchz/olZsUR9bzaI5cg1nx
 3rl35u0XN6EH+hK+GAKXTMaYyKsm9gibEnKprQv116EasFYPbFAzswrPFrfw3yeRHw3m5mfDq2v
 28pOy9rqLzUcW3CYB9O9PVhGKjr//XB8AswlM4xAXWurTxZzUnP1KcQJgmOJKKCJ+lQ1uYkoQYw
 /uRC0hrBVc1/6tMmiJTsrp7GbEH2svskqbp0Cq2v28RsCezJy0RrVDs3Y9OPHt9uI=
X-Received: by 2002:a17:90b:48cf:b0:35b:91e1:e110 with SMTP id
 98e67ed59e1d1-35e4285b82cmr3225326a91.20.1775833547281; 
 Fri, 10 Apr 2026 08:05:47 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4131cfacsm3565785a91.10.2026.04.10.08.05.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 08:05:46 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V6 10/14] virtio-balloon: Update tracking iothread users with
 holder name
Date: Fri, 10 Apr 2026 23:04:53 +0800
Message-ID: <20260410150457.85190-11-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260410150457.85190-1-zhangckid@gmail.com>
References: <20260410150457.85190-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1035.google.com
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

Replace raw object_ref/unref calls with iothread_get/put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/virtio/virtio-balloon.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 4c5f486ba2..8a4494905a 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -892,14 +892,16 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
     s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
 
     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+
         s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
                                            virtio_balloon_handle_free_page_vq);
         precopy_add_notifier(&s->free_page_hint_notify);
 
-        object_ref(OBJECT(s->iothread));
-        s->free_page_bh = aio_bh_new_guarded(iothread_get_aio_context(s->iothread),
-                                             virtio_ballloon_get_free_page_hints, s,
-                                             &dev->mem_reentrancy_guard);
+        s->free_page_bh = aio_bh_new_guarded(
+                            iothread_ref_and_get_aio_context(s->iothread, path),
+                            virtio_ballloon_get_free_page_hints, s,
+                            &dev->mem_reentrancy_guard);
     }
 
     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)) {
@@ -919,9 +921,11 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
 
     qemu_unregister_resettable(OBJECT(dev));
     if (s->free_page_bh) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+
         qemu_bh_delete(s->free_page_bh);
-        object_unref(OBJECT(s->iothread));
         virtio_balloon_free_page_stop(s);
+        iothread_put_aio_context(s->iothread, path);
         precopy_remove_notifier(&s->free_page_hint_notify);
     }
     balloon_stats_destroy_timer(s);
-- 
2.49.0


