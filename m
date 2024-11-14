Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2F0D65C6C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 10:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBXUk-0000LA-Uw; Thu, 14 Nov 2024 05:54:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tBXUi-0000Kj-35
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 05:54:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tBXUe-00064N-LR
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 05:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731581667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DL7LaOC6a6Mn+StPTpIuGi7s+EexOGQKkGLZYX5F8As=;
 b=U2IL3tkZid10gnaQXNqUnYIhTUJGzDqdUBL9jo+X4BYzKvkoOBhBAfxWKKBKgLRJnH3JRm
 Yu5V16+m2zsyvisbz6NkNNDeWHbvEvNUJnjCUVm5LYrm9Y0Io1WEr91SS38dGGa0eyy6/3
 TbmI58A0gdmA7PTZ0AIXAcNUcgKvcQc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-okUoTuslNBmPKNDa799DgQ-1; Thu, 14 Nov 2024 05:54:25 -0500
X-MC-Unique: okUoTuslNBmPKNDa799DgQ-1
X-Mimecast-MFC-AGG-ID: okUoTuslNBmPKNDa799DgQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d4d51b4efso288246f8f.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 02:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731581664; x=1732186464;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DL7LaOC6a6Mn+StPTpIuGi7s+EexOGQKkGLZYX5F8As=;
 b=flZZwQK1NcdDStK575s9uYx3pBzHCXG4pvn6CDYmS2w8feGhll93dX2aglnBM/aFS+
 wa/8iCB53UHehq8vGNn1IWinjvDqOLFnucR0TSovUC91cklUbr5JM6zaIIMJuRxceK13
 Wu3gNOW7OGLG8pcDLnf6GYGQzf8Lf9ciXvblWDA+C1mP08GTuV8+yJILoQQGbv1M92l8
 CgTOGdBqrjqS2poMGFgC0UOv0OFU28mBqara/eVFLF0HqbjtwNDrZBqdcAyr8U816kZp
 XnqNWCHby+cpueHZXnLKUl7oMQx30fWDuRjxkDpsSOLHQnkrUjKW8xTM+xRIIOUrZKhr
 HxVg==
X-Gm-Message-State: AOJu0Yygcy5Va1QmD/DGmDl75pSJU7y4EhL9vyjZ9xhlCrwqXdHUyNk3
 EsdKdI2lvPiyGFY08H/XSR67/XutZPJ7jDhjt06LRCCgCVdF3aO0UNnVjfhfR6X14vK43/HIPVE
 MJnjiFac3+vF+ZD4cz8XLEvsJjxPnE3XHg2h/mwOQcUN4ErdT0uDx
X-Received: by 2002:a5d:6d8a:0:b0:37d:49d1:1e89 with SMTP id
 ffacd0b85a97d-381f18726eamr17642845f8f.27.1731581664240; 
 Thu, 14 Nov 2024 02:54:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnWjx3Eoj3jcjMked1ZocUJG7rQHDnkgb6rjwolYgoS/0nZRLFuZ1MmchwYkSmDarB7mcdxw==
X-Received: by 2002:a5d:6d8a:0:b0:37d:49d1:1e89 with SMTP id
 ffacd0b85a97d-381f18726eamr17642817f8f.27.1731581663551; 
 Thu, 14 Nov 2024 02:54:23 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-129.retail.telecomitalia.it.
 [79.46.200.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821adad945sm1124169f8f.29.2024.11.14.02.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 02:54:23 -0800 (PST)
Date: Thu, 14 Nov 2024 11:54:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zuo boqun <zuoboqun@baidu.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Gao Shiyuan <gaoshiyuan@baidu.com>
Subject: Re: [PATCH] vhost_net: fix assertion triggered by batch of host
 notifiers processing
Message-ID: <ji6awwfwo5l5oojncnaztar2rvkbximplcf6whvo7ebsva3wsr@b6emenu2ltf3>
References: <20241111085725.2924-1-zuoboqun@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241111085725.2924-1-zuoboqun@baidu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Nov 11, 2024 at 04:57:25PM +0800, Zuo boqun wrote:
>From: zuoboqun <zuoboqun@baidu.com>
>
>When the backend of vhost_net restarts during the vm is running, vhost_net
>is stopped and started. The virtio_device_grab_ioeventfd() fucntion in
>vhost_net_enable_notifiers() will result in a call to
>virtio_bus_set_host_notifier()(assign=false).
>
>And now virtio_device_grab_ioeventfd() is batched in a single transaction
>with virtio_bus_set_host_notifier()(assign=true).
>
>This triggers the following assertion:
>
>kvm_mem_ioeventfd_del: error deleting ioeventfd: Bad file descriptor
>
>This patch moves virtio_device_grab_ioeventfd() out of the batch to fix
>this problem.
>
>Fixes: 6166799f6 ("vhost_net: configure all host notifiers in a single MR transaction")
>Reported-by: Gao Shiyuan <gaoshiyuan@baidu.com>
>Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
>---
> hw/net/vhost_net.c | 31 ++++++++++++++++++++-----------
> 1 file changed, 20 insertions(+), 11 deletions(-)
>
>diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>index 997aab0557..eb3e92ca0d 100644
>--- a/hw/net/vhost_net.c
>+++ b/hw/net/vhost_net.c
>@@ -229,9 +229,24 @@ static int vhost_net_enable_notifiers(VirtIODevice *dev,
>     int nvhosts = data_queue_pairs + cvq;
>     struct vhost_net *net;
>     struct vhost_dev *hdev;
>-    int r, i, j;
>+    int r, i, j, k;
>     NetClientState *peer;
>
>+    /*
>+     * We will pass the notifiers to the kernel, make sure that QEMU
>+     * doesn't interfere.
>+     */
>+    for (i = 0; i < nvhosts; i++) {
>+        r = virtio_device_grab_ioeventfd(dev);
>+        if (r < 0) {
>+            error_report("vhost %d binding does not support host notifiers", i);
>+            for (k = 0; k < i; k++) {
>+                virtio_device_release_ioeventfd(dev);
>+            }
>+            return r;
>+        }
>+    }
>+
>     /*
>      * Batch all the host notifiers in a single transaction to avoid
>      * quadratic time complexity in address_space_update_ioeventfds().
>@@ -247,16 +262,6 @@ static int vhost_net_enable_notifiers(VirtIODevice *dev,
>
>         net = get_vhost_net(peer);
>         hdev = &net->dev;
>-        /*
>-         * We will pass the notifiers to the kernel, make sure that QEMU
>-         * doesn't interfere.
>-         */
>-        r = virtio_device_grab_ioeventfd(dev);
>-        if (r < 0) {
>-            error_report("binding does not support host notifiers");
>-            memory_region_transaction_commit();
>-            goto fail_nvhosts;
>-        }
>
>         for (j = 0; j < hdev->nvqs; j++) {
>             r = virtio_bus_set_host_notifier(VIRTIO_BUS(qbus),
>@@ -277,6 +282,10 @@ static int vhost_net_enable_notifiers(VirtIODevice *dev,
>     return 0;
> fail_nvhosts:
>     vhost_net_disable_notifiers_nvhosts(dev, ncs, data_queue_pairs, i);

IIUC this call is disabling notifiers from 0 to `i - 1` ...

>+    for (k = i + 1; k < nvhosts; k++) {

... so, should we start from `i`, instead of `i + 1`?

Thanks,
Stefano

>+        virtio_device_release_ioeventfd(dev);
>+    }
>+
>     return r;
> }
>
>-- 
>2.42.0.windows.2
>


