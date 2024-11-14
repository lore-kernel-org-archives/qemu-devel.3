Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC42D68B07
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 13:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBZcB-0005EP-6Q; Thu, 14 Nov 2024 08:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tBZc9-0005D6-EW
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:10:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tBZc7-0004iR-Q5
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731589822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TNeP4PoI1dPOAUqG+AaLv0MX9k+dBpNJf5ieMxtsMQc=;
 b=JX3S9wgwrnmSj03MVD316rLRJjtjT+JOuv0xhSkUgvDCo6ePNp75oii5a8EyzK7uB88uEY
 oLp1l3B3ZQQP3Y+PnQHLpWA891flkRnfJJ4qKGzkFDQyJvQTXpkHwqDv/hGTM/j4tDZMoi
 /T7Xr005hDwMfyZG3no/M91nGnF1LzU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-4VvnvrjmM3ijiaPSWShiJA-1; Thu, 14 Nov 2024 08:10:18 -0500
X-MC-Unique: 4VvnvrjmM3ijiaPSWShiJA-1
X-Mimecast-MFC-AGG-ID: 4VvnvrjmM3ijiaPSWShiJA
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d35062e1fcso7430316d6.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 05:10:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731589818; x=1732194618;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TNeP4PoI1dPOAUqG+AaLv0MX9k+dBpNJf5ieMxtsMQc=;
 b=CkpbyBzNuzwFd47SWDUsPL+ElOgqS91W/nWulwaR9W6kAPv8pL74uRuRUk0fiAF+fv
 hOrK3YHmbojQ4zye5/+jnAMYuhemV9RweQB2YMqQMPgtDD/fRNNiuzQQMOTju9JgPjwz
 qQYjn04rYCAA0InI30mqSSROY62HnimeNec64q7v+vHjsLIe+1FIhNu8WPns6tA01VK5
 Szw/EZQ1GIYEc380NMD1l6FoonxFJAkZW+ES4/011zgNt+P+HtX16ndjgL3RzL6vBnwh
 5H2kO2+aao/6pWC8wDKd8i4epoG/N6um5Z9uxKBBAWrPA7wzf9n2DVHjv23VpfGX90Xc
 8fiA==
X-Gm-Message-State: AOJu0YwvD+/sftZLkm3JZVZ9aTnUPxwDKimV5yHbuZd3mBVoKf2UXmJn
 /JG69bvWY6b9a43HMzARxjEQn14tQi2d+dLPjX3s8+7EfhX0xqssqHpJt4SM+vZag9O4Bov1cqx
 Paf1Qj2axc/RgrLZixlNPiSDqMoR2KXB/6/OJEioA03A+alFJGtMF
X-Received: by 2002:a05:6214:4607:b0:6cb:d4ed:aa59 with SMTP id
 6a1803df08f44-6d3edd389eamr22096226d6.4.1731589818247; 
 Thu, 14 Nov 2024 05:10:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNcvZJuVHd/ftba2MpfkJvhehcdiN6f4UBY/570MH85ojraa0idT3RLDoZpeO7q9lDgDn4aA==
X-Received: by 2002:a05:6214:4607:b0:6cb:d4ed:aa59 with SMTP id
 6a1803df08f44-6d3edd389eamr22095976d6.4.1731589817838; 
 Thu, 14 Nov 2024 05:10:17 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-129.retail.telecomitalia.it.
 [79.46.200.129]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d3ee8c4274sm5166346d6.75.2024.11.14.05.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 05:10:17 -0800 (PST)
Date: Thu, 14 Nov 2024 14:10:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Zuo,Boqun" <zuoboqun@baidu.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 "Gao,Shiyuan" <gaoshiyuan@baidu.com>
Subject: Re: [PATCH] vhost_net: fix assertion triggered by batch of host
 notifiers processing
Message-ID: <kvbv7hbsloklwcb5zooqgveb2253sf7mil7ykkotgfhcqbtn6c@cnspmyskyeey>
References: <6e6f624c7a2a489b88dba0a44e6013d1@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6e6f624c7a2a489b88dba0a44e6013d1@baidu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
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

On Thu, Nov 14, 2024 at 11:08:35AM +0000, Zuo,Boqun wrote:
>On Thursday, November 14, 2024 6:54 PM, Stefano Garzarella wrote:
>> >
>> >When the backend of vhost_net restarts during the vm is running,
>> >vhost_net is stopped and started. The virtio_device_grab_ioeventfd()
>> >fucntion in
>> >vhost_net_enable_notifiers() will result in a call to
>> >virtio_bus_set_host_notifier()(assign=false).
>> >
>> >And now virtio_device_grab_ioeventfd() is batched in a single
>> >transaction with virtio_bus_set_host_notifier()(assign=true).
>> >
>> >This triggers the following assertion:
>> >
>> >kvm_mem_ioeventfd_del: error deleting ioeventfd: Bad file descriptor
>> >
>> >This patch moves virtio_device_grab_ioeventfd() out of the batch to fix
>> >this problem.
>> >
>> >Fixes: 6166799f6 ("vhost_net: configure all host notifiers in a single
>> >MR transaction")
>> >Reported-by: Gao Shiyuan <gaoshiyuan@baidu.com>
>> >Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
>> >---
>> > hw/net/vhost_net.c | 31 ++++++++++++++++++++-----------
>> > 1 file changed, 20 insertions(+), 11 deletions(-)
>> >
>> >diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c index
>> >997aab0557..eb3e92ca0d 100644
>> >--- a/hw/net/vhost_net.c
>> >+++ b/hw/net/vhost_net.c
>> >@@ -229,9 +229,24 @@ static int vhost_net_enable_notifiers(VirtIODevice
>> *dev,
>> >     int nvhosts = data_queue_pairs + cvq;
>> >     struct vhost_net *net;
>> >     struct vhost_dev *hdev;
>> >-    int r, i, j;
>> >+    int r, i, j, k;
>> >     NetClientState *peer;
>> >
>> >+    /*
>> >+     * We will pass the notifiers to the kernel, make sure that QEMU
>> >+     * doesn't interfere.
>> >+     */
>> >+    for (i = 0; i < nvhosts; i++) {
>> >+        r = virtio_device_grab_ioeventfd(dev);
>> >+        if (r < 0) {
>> >+            error_report("vhost %d binding does not support host 
>> >notifiers", i);
>> >+            for (k = 0; k < i; k++) {
>> >+                virtio_device_release_ioeventfd(dev);
>> >+            }
>> >+            return r;
>> >+        }
>> >+    }
>> >+
>> >     /*
>> >      * Batch all the host notifiers in a single transaction to avoid
>> >      * quadratic time complexity in address_space_update_ioeventfds().
>> >@@ -247,16 +262,6 @@ static int vhost_net_enable_notifiers(VirtIODevice
>> >*dev,
>> >
>> >         net = get_vhost_net(peer);
>> >         hdev = &net->dev;
>> >-        /*
>> >-         * We will pass the notifiers to the kernel, make sure that QEMU
>> >-         * doesn't interfere.
>> >-         */
>> >-        r = virtio_device_grab_ioeventfd(dev);
>> >-        if (r < 0) {
>> >-            error_report("binding does not support host notifiers");
>> >-            memory_region_transaction_commit();
>> >-            goto fail_nvhosts;
>> >-        }
>> >
>> >         for (j = 0; j < hdev->nvqs; j++) {
>> >             r = virtio_bus_set_host_notifier(VIRTIO_BUS(qbus),
>> >@@ -277,6 +282,10 @@ static int vhost_net_enable_notifiers(VirtIODevice
>> *dev,
>> >     return 0;
>> > fail_nvhosts:
>> >     vhost_net_disable_notifiers_nvhosts(dev, ncs, data_queue_pairs,
>> >i);
>>
>> IIUC this call is disabling notifiers from 0 to `i - 1` ...
>>
>> >+    for (k = i + 1; k < nvhosts; k++) {
>>
>> ... so, should we start from `i`, instead of `i + 1`?
>>
>> Thanks,
>> Stefano
>
>The notifier `i` has been released when vhost_net_enable_notifiers() call vhost_dev_disable_notifiers_nvqs():
>
>        for (j = 0; j < hdev->nvqs; j++) {
>            r = virtio_bus_set_host_notifier(VIRTIO_BUS(qbus),
>                                             hdev->vq_index + j,
>                                             true);
>            if (r < 0) {
>                error_report("vhost %d VQ %d notifier binding failed: %d",
>                              i, j, -r);
>                memory_region_transaction_commit();
>=>            vhost_dev_disable_notifiers_nvqs(hdev, dev, j);
>                goto fail_nvhosts;
>            }
>        }
>
>So we should start from `i+1`...

Ok, I see now.
That is really hidden, so please describe it in the commit message and 
also add a comment in the code.

Thanks,
Stefano

>
>>
>> >+        virtio_device_release_ioeventfd(dev);
>> >+    }
>> >+
>> >     return r;
>> > }
>> >
>> >--
>> >2.42.0.windows.2
>> >
>


