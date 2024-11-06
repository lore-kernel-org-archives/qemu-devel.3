Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CDBD29FB8
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 08:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8blA-0002tH-Le; Wed, 06 Nov 2024 03:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t8bl3-0002sn-V4
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 03:51:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t8bl1-0000u9-6G
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 03:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730883077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zmCVtkqnKZ9iejApJRsva49FK5IJvx3oSfkMQfqfXmU=;
 b=do5sz6c48oHqYNR4BHxju4UurUaTRNA3CVdBGwZVdOWDMRZj5kIY+h+esAPk7ieZnCNFG2
 5N2AAS50+k4G2Y9EKtpIQJHAseh+c0YBqMtDpSRRK20KeZBRi0cw0xU1QpcqJCkxyk8QC5
 KduQh+EnZgC4+nm9vBrvAdEWSHJ/s3w=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-07hpw3mCOGSblHnlIszrKA-1; Wed, 06 Nov 2024 03:51:16 -0500
X-MC-Unique: 07hpw3mCOGSblHnlIszrKA-1
X-Mimecast-MFC-AGG-ID: 07hpw3mCOGSblHnlIszrKA
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b15659b098so865931585a.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 00:51:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730883075; x=1731487875;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zmCVtkqnKZ9iejApJRsva49FK5IJvx3oSfkMQfqfXmU=;
 b=H5Hd8hRzxWuboDfxn4N8OYwBqygf6dwb5iasR/mcul8P5GRXsJHGiY0oogFn+jNyoE
 QByh8e7aoYkSzHFEo2o3E2LP3L6LJHAgvr222RzzYAQuucKIhkw8/1KNXC3yHSaLAHlZ
 NwFl3+nKa9rl9yzkaqcB0xfdp/jkSTuiTzlnXHjdnm2n8WKXSHNYosDcq5OMWlny/shs
 KH1XJpcAywKNhn0pY1DZlOEYQf+B7Y3YyGJyd5D1OS/Kgb9kSq7T58TOqLT59tkkZdbk
 ddmdOzntQ8KXOO4WEr8Se23rW2b4t+TCeVNI1sehh/gcHs5vDO6ZTMMblZ+LlTvaTluZ
 5YhA==
X-Gm-Message-State: AOJu0YznJf6TtvXnIbhPXflJ0YWGODavYlRxc+rKOGUwbtInl9grcF0b
 YaL5Ezq4agYxLRHbTxpW8JlzTGus8cfWXoLCYZatqsqyo+UBgDCPKNRjuJ08OVcQr0elkc5P/F9
 RVuAVi/AxgJCOcdZeDDsyf7Mi3h55j610MV9SdnVk9pcD+Oap+d1p
X-Received: by 2002:a05:620a:4084:b0:7b1:559f:eee with SMTP id
 af79cd13be357-7b2f2551229mr3243905585a.53.1730883075709; 
 Wed, 06 Nov 2024 00:51:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6GFQ+jUuu6McpY1YGh53io7z1of5oEz5lozFkNzD+Vr8rwwf1wwb1LPqW9l/gVgqneZ5c5g==
X-Received: by 2002:a05:620a:4084:b0:7b1:559f:eee with SMTP id
 af79cd13be357-7b2f2551229mr3243903885a.53.1730883075341; 
 Wed, 06 Nov 2024 00:51:15 -0800 (PST)
Received: from sgarzare-redhat ([5.77.86.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a0c199sm606838285a.64.2024.11.06.00.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 00:51:14 -0800 (PST)
Date: Wed, 6 Nov 2024 09:51:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH] vhost: fail device start if iotlb update fails
Message-ID: <kxiffscfbs4njd6cfuebstpm5yrp7jdkgulcwbsmsyyxfowixw@yrhyrmhaj7da>
References: <20241105060053.61973-1-ppandit@redhat.com>
 <a664pk3wefui7tyvs6rjln2tm2fxwir6yvshffwkjypksechjj@3amhddyqxwiz>
 <CAE8KmOxHTx=ZxTWype-YVizogDEVVXVg=jRdYU8eRtHP7ngr9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAE8KmOxHTx=ZxTWype-YVizogDEVVXVg=jRdYU8eRtHP7ngr9w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Wed, Nov 06, 2024 at 01:20:31PM +0530, Prasad Pandit wrote:
>On Tue, 5 Nov 2024 at 16:19, Stefano Garzarella <sgarzare@redhat.com> wrote:
>> VHOST_OPS_DEBUG() is usually used in the error path when calling a
>> `dev->vhost_ops` callback. In addition vhost_device_iotlb_miss() is
>> already reporting error through error_report() in the error path, so I
>> think we can remove this line.
>
>* Okay.
>
>> Should we add a new label in the error path and call
>> `hdev->vhost_ops->vhost_dev_start` with `false`?
>>
>> Maybe we need to call also `hdev->vhost_ops->vhost_set_iotlb_callback`
>> with `false`.
>===
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index a70b7422b5..089eff438e 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -2137,15 +2137,18 @@ int vhost_dev_start(struct vhost_dev *hdev,
>VirtIODevice *vdev, bool vrings)
>             goto fail_log;
>         }
>     }
>+
>+    bool start = true;
>+dev_restart:
>     if (hdev->vhost_ops->vhost_dev_start) {
>-        r = hdev->vhost_ops->vhost_dev_start(hdev, true);
>+        r = hdev->vhost_ops->vhost_dev_start(hdev, start);
>         if (r) {
>             goto fail_start;
>         }
>     }
>     if (vhost_dev_has_iommu(hdev) &&
>         hdev->vhost_ops->vhost_set_iotlb_callback) {
>-            hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);
>+            hdev->vhost_ops->vhost_set_iotlb_callback(hdev, start);
>
>         /* Update used ring information for IOTLB to work correctly,
>          * vhost-kernel code requires for this.*/
>@@ -2154,7 +2157,8 @@ int vhost_dev_start(struct vhost_dev *hdev,
>VirtIODevice *vdev, bool vrings)
>             r = vhost_device_iotlb_miss(hdev, vq->used_phys, true);
>             if (r) {
>                 VHOST_OPS_DEBUG(r, "vhost_device_iotlb_miss failed");
>-                goto fail_start;
>+                start = false;
>+                goto dev_restart;
>             }
>         }
>     }
>===
>
>* Something like above?

mmm, I would avoid goto to go backwards, since we could generate 
infinite loops, plus I think we should call that functions in the 
reverse order, so just add them in the error path, as we already do for 
other calls.

Another option is somehow call vhost_dev_stop() and just do the steps we 
need to, but that seems more complicated to me.

Thanks,
Stefano

>
>===
>static int vhost_user_dev_start(struct vhost_dev *dev, bool started)
>{
>    ...
>    if (started) {
>        return vhost_user_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
>                                          VIRTIO_CONFIG_S_DRIVER |
>                                          VIRTIO_CONFIG_S_DRIVER_OK);
>    } else {
>        return 0;
>    }
>}
>
>static void vhost_user_set_iotlb_callback(struct vhost_dev *dev, int enabled)
>{
>    /* No-op as the receive channel is not dedicated to IOTLB messages. */
>}
>===
>
>* Calling vhost_user_dev_start() and vhost_user_set_iotlb_callback()
>with 'false' does not seem to do much. Not sure how'll that help. If
>we 'goto fail_start;', libvirtd(8) might restart the guest and thus
>start the vhost device again.
>
>...wdyt?
>
>Thank you.
>---
>  - Prasad
>


