Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689F3CEACCB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdvL-0003Kv-7s; Tue, 01 Oct 2024 10:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1svduB-00020q-P2
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:31:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1svdu9-0000hT-OL
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727793068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4NNzv58JsALzSqMsD+lcQKPY0bUNJ5HaoIAyx9nv3Mw=;
 b=g4JzIZmjapLLv25LzcX1yxpsR+JrKMogyOFJw5CwsVw7R4xFKeuVpZTG5AJ6C49Ra1OxsC
 9oQHWgNMuifDQS7LldcGAYYWPMHGQJ9CAi7sGB01YVgoERC5KLi9QCnD7wuVVQWe1E5e+/
 3VhuIK1NqqQUlmMeSGlEBHSAMfcBxz8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-50ufbRhaPBuAwSbn5_SNkg-1; Tue, 01 Oct 2024 08:22:02 -0400
X-MC-Unique: 50ufbRhaPBuAwSbn5_SNkg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-45b6057797cso89982281cf.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 05:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727785322; x=1728390122;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4NNzv58JsALzSqMsD+lcQKPY0bUNJ5HaoIAyx9nv3Mw=;
 b=K7o5JNJkoK+x2yyGosEgHQ/4/nSmlK5Gtkq/gjnV06JSRnoA8NFh7oRYGXc05ml2HU
 jxrr0oIeNJglEOijGA2mt0/8DSVDJGbmmYukdjKPifRsXe8Q4I8y7gUK6zpsJ1G3RZZe
 KFgSaA+2OJEmHDxJxut0yp4qAeNMMQgPAp5KGclJFo82ZIL966KFLeT/GFP527KA4wE5
 etktgKOGFIS3h+9laznFuxfEXDv0ohOxZawaY4fym7z33zgsBEh5MHTV4LsOZgn5wNj2
 TeTOcR4yxJ1RmCVvCaA4VzPTeRwSMWnmHOf9AJZkhInWuVPK7at9M0ccJtEeVpS2QO0C
 BEgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMF/L5A/lnk10ngig+09LAgR2FWAbcVtgVP+qb+y7kaKLaqW96FYVKb9rVEyNxZBfhty036KBX68Y4@nongnu.org
X-Gm-Message-State: AOJu0YzdS1LgK479lvbfNZhKANTSU518+N5649RO2rHI0wswvUYAan1R
 IFF0qcCgVQDken5WmhjrhKmAMaTbOA9Z47DCYbZD4y59wz9M6crynHG7Rkk4fBSr+cU5w8NNh6L
 7lIPqWOahI+/xave1FLyWJQL++pVh8P1nClNa7qEJqE8UHJgC8e/YURmSR1G9Z0I=
X-Received: by 2002:a05:622a:1a87:b0:447:db4f:9f00 with SMTP id
 d75a77b69052e-45c9f224fe4mr233173181cf.32.1727785322145; 
 Tue, 01 Oct 2024 05:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEto9e2bj0OqlD39XBbA6rML/CaZgUSn6Rq2IgTgJv3oMY0rq7IM5gDhcqgIm/bUw8PXvhe1A==
X-Received: by 2002:a05:622a:1a87:b0:447:db4f:9f00 with SMTP id
 d75a77b69052e-45c9f224fe4mr233172711cf.32.1727785321649; 
 Tue, 01 Oct 2024 05:22:01 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it.
 [79.46.200.231]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f28e481sm44914141cf.16.2024.10.01.05.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 05:22:01 -0700 (PDT)
Date: Tue, 1 Oct 2024 14:21:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: yaozhenguo <yaozhenguo1@gmail.com>
Cc: alex.bennee@linaro.org, mst@redhat.com, qemu-devel@nongnu.org, 
 yaozhenguo@jd.com
Subject: Re: [PATCH V2] virtio/vhost-user: fix qemu abort when hotunplug
 vhost-user-net device
Message-ID: <akeix6af5fnabwotvaxdvr6ag3xyeuopgsurs3yqtyetwnli2s@cutfouykwadf>
References: <20240919072944.21262-1-yaozhenguo@jd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240919072944.21262-1-yaozhenguo@jd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Sep 19, 2024 at 03:29:44PM GMT, yaozhenguo wrote:
>During the process of hot-unplug in vhost-user-net NIC, vhost_user_cleanup
>may add same rcu node to rcu list. Function calls are as follows:
>
>vhost_user_cleanup
>    ->vhost_user_host_notifier_remove
>        ->call_rcu(n, vhost_user_host_notifier_free, rcu);
>    ->g_free_rcu(n, rcu);
>
>When this happens, QEMU will abort in try_dequeue:
>
>if (head == &dummy && qatomic_mb_read(&tail) == &dummy.next) {
>    abort();
>}
>
>Backtrace is as follows:
>0  __pthread_kill_implementation () at /usr/lib64/libc.so.6
>1  raise () at /usr/lib64/libc.so.6
>2  abort () at /usr/lib64/libc.so.6
>3  try_dequeue () at ../util/rcu.c:235
>4  call_rcu_thread (0) at ../util/rcu.c:288
>5  qemu_thread_start (0) at ../util/qemu-thread-posix.c:541
>6  start_thread () at /usr/lib64/libc.so.6
>7  clone3 () at /usr/lib64/libc.so.6
>
>Reason for the abort is that adding two identical nodes to the rcu list will
>cause it becomes a ring. After dummy node is added to the tail of the list in
>try_dequeue, the ring is opened. But lead to a situation that only one node is
>added to list and rcu_call_count is added twice. This will cause try_dequeue
>abort.
>
>This issue happens when n->addr != 0 in vhost_user_host_notifier_remove. It can
>happens in a hotplug stress test with a 32queue vhost-user-net type NIC.
>Because n->addr is set in VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG function.
>during device hotplug process and it is cleared in vhost_dev_stop during device
>hot-unplug. Since VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG is a message sent
>by DPDK to qemu, it is asynchronous. So, there is no guaranteed order between
>the two processes of setting n->addr and clearing n->addr. If setting n->addr
>in hotplug occurs after clearing n->addr in hotunplug, the issue will occur.
>So, it is necessary to merge g_free_rcu and vhost_user_host_notifier_free into
>one rcu node.
>
>Fixes: 503e355465 ("virtio/vhost-user: dynamically assign VhostUserHostNotifiers")
>
>Signed-off-by: yaozhenguo <yaozhenguo@jd.com>
>---
>
>V1->V2:
>    add n->addr check in vhost_user_get_vring_base and vhost_user_backend_handle_vring_host_notifier
>    to prevent submit same node to rcu list.
>
>---
> hw/virtio/vhost-user.c         | 39 +++++++++++++++++++++------------------
> include/hw/virtio/vhost-user.h |  1 +
> 2 files changed, 22 insertions(+), 18 deletions(-)
>
>diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>index 00561da..ba4c09c 100644
>--- a/hw/virtio/vhost-user.c
>+++ b/hw/virtio/vhost-user.c
>@@ -51,7 +51,6 @@
> #else
> #define VHOST_USER_MAX_RAM_SLOTS 512
> #endif
>-
> /*
>  * Maximum size of virtio device config space
>  */
>@@ -1185,9 +1184,16 @@ static int vhost_user_set_vring_num(struct vhost_dev *dev,
>
> static void vhost_user_host_notifier_free(VhostUserHostNotifier *n)
> {
>-    assert(n && n->unmap_addr);
>-    munmap(n->unmap_addr, qemu_real_host_page_size());
>-    n->unmap_addr = NULL;
>+    if (n->unmap_addr) {
>+        munmap(n->unmap_addr, qemu_real_host_page_size());
>+        n->unmap_addr = NULL;
>+    }
>+    if (n->need_free) {
>+        memory_region_transaction_begin();
>+        object_unparent(OBJECT(&n->mr));
>+        memory_region_transaction_commit();
>+        g_free(n);
>+    }
> }
>
> /*
>@@ -1195,17 +1201,20 @@ static void vhost_user_host_notifier_free(VhostUserHostNotifier *n)
>  * under rcu.
>  */
> static void vhost_user_host_notifier_remove(VhostUserHostNotifier *n,
>-                                            VirtIODevice *vdev)
>+                                            VirtIODevice *vdev, bool free)

What about `destroy` instead of `free`?

In that way is more clear that it should be true when called by
`vhost_user_state_destroy()`.

> {
>     if (n->addr) {
>         if (vdev) {
>+            memory_region_transaction_begin();
>             virtio_queue_set_host_notifier_mr(vdev, n->idx, &n->mr, false);
>+            memory_region_transaction_commit();
>         }
>         assert(!n->unmap_addr);
>         n->unmap_addr = n->addr;
>         n->addr = NULL;
>-        call_rcu(n, vhost_user_host_notifier_free, rcu);
>     }

Instead of checking n->addr in the caller, I suggest to move the check
here:

       if (destroy || n->unmap_addr) {
           s->destroy = destroy;
           call_rcu(n, vhost_user_host_notifier_free, rcu);
       }

Thanks,
Stefano

>+    n->need_free = free;
>+    call_rcu(n, vhost_user_host_notifier_free, rcu);
> }
>
> static int vhost_user_set_vring_base(struct vhost_dev *dev,
>@@ -1279,8 +1288,8 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
>     struct vhost_user *u = dev->opaque;
>
>     VhostUserHostNotifier *n = fetch_notifier(u->user, ring->index);
>-    if (n) {
>-        vhost_user_host_notifier_remove(n, dev->vdev);
>+    if (n && n->addr) {
>+        vhost_user_host_notifier_remove(n, dev->vdev, false);
>     }
>
>     ret = vhost_user_write(dev, &msg, NULL, 0);
>@@ -1562,7 +1571,9 @@ static int vhost_user_backend_handle_vring_host_notifier(struct vhost_dev *dev,
>      * new mapped address.
>      */
>     n = fetch_or_create_notifier(user, queue_idx);
>-    vhost_user_host_notifier_remove(n, vdev);
>+    if (n && n->addr) {
>+        vhost_user_host_notifier_remove(n, vdev, false);
>+    }
>
>     if (area->u64 & VHOST_USER_VRING_NOFD_MASK) {
>         return 0;
>@@ -2737,13 +2748,7 @@ static void vhost_user_state_destroy(gpointer data)
> {
>     VhostUserHostNotifier *n = (VhostUserHostNotifier *) data;
>     if (n) {
>-        vhost_user_host_notifier_remove(n, NULL);
>-        object_unparent(OBJECT(&n->mr));
>-        /*
>-         * We can't free until vhost_user_host_notifier_remove has
>-         * done it's thing so schedule the free with RCU.
>-         */
>-        g_free_rcu(n, rcu);
>+        vhost_user_host_notifier_remove(n, NULL, true);
>     }
> }
>
>@@ -2765,9 +2770,7 @@ void vhost_user_cleanup(VhostUserState *user)
>     if (!user->chr) {
>         return;
>     }
>-    memory_region_transaction_begin();
>     user->notifiers = (GPtrArray *) g_ptr_array_free(user->notifiers, true);
>-    memory_region_transaction_commit();
>     user->chr = NULL;
> }
>
>diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
>index 324cd86..a171f29 100644
>--- a/include/hw/virtio/vhost-user.h
>+++ b/include/hw/virtio/vhost-user.h
>@@ -54,6 +54,7 @@ typedef struct VhostUserHostNotifier {
>     void *addr;
>     void *unmap_addr;
>     int idx;
>+    bool need_free;
> } VhostUserHostNotifier;
>
> /**
>-- 
>1.8.3.1
>


