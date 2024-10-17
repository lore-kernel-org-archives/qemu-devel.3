Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13100D2F7FB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 07:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1L5n-0001wm-3Z; Thu, 17 Oct 2024 03:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t1L5l-0001wA-Oz
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 03:38:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t1L5h-0000Jd-Jz
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 03:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729150716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9X7nDuMoSS5pjKY8f6BHUJyJcxz+/sepad7YcTY3Ovk=;
 b=fTTbFsxk/HS36Gry5Y7EGvH/x3OsAWF3MhkQwt4A3KtPBPL6ghGvTe81ordHJULNGJ5REu
 j0jHqCRiGQ9GC5zQTSHSADF1bXFcba+H6UiwUec6jtJoCaBP0JMRD2o1sacROPDYoNjtYO
 H4RPvQvxRSP0yFFkQPLqHmXs45RiwAg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-rrsJtB03OBaccoylhqiqzg-1; Thu, 17 Oct 2024 03:38:34 -0400
X-MC-Unique: rrsJtB03OBaccoylhqiqzg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-46057904e03so14708271cf.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 00:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729150714; x=1729755514;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9X7nDuMoSS5pjKY8f6BHUJyJcxz+/sepad7YcTY3Ovk=;
 b=rvDPdRF1xXTc+MGTcZM7BUAAynJzUbKYMKnhXcIyphcgtrQfeMxvyOshr/JGzi+ef9
 4jrk7hTfRkRe+1zUGLNoGgop1S1U1oYHWFxKMOHNg9DHB3VXzgZQpb7rGb5pZxf4i9gz
 mA4qb5rSUMrOuGa/nOnWmZMibOhSynr/PHT5Hi0g2QL7PNAUyWppsEjP4aWP3A3IOThL
 E8lEUNuVDaQVPcVt+1i3Xgww8HHYO2Fxf9/0Ctlw6NLx4YVHQ+kd1i9Ocv061yofVnk9
 HyywTtmMLjX31mp034tKZGHdNc5GI1hRDQTajYsAjozub7xOlL3sDz/gSiWnjHEkyij5
 553A==
X-Gm-Message-State: AOJu0Yw/vYyJzDDxy/eLt27QE4vONFfX/RNqL1M3zbAcbV4hfOGwj/9I
 ycc8x8erCa+IHjmcedNAKCO1Mn11+2tWxVMyeUWuLTJbWhTd5Ww8PciHVNRG5B1fWC/RAE2Whlo
 Cpzz2wujVZtkex742xqqDr0+5DXJy6TN2hMMAsVQedRV4tDkIoCtp
X-Received: by 2002:a05:622a:4c83:b0:45b:5e8e:3440 with SMTP id
 d75a77b69052e-4608a52b548mr89434121cf.60.1729150714122; 
 Thu, 17 Oct 2024 00:38:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdBYJJWeUlao4YQHGrcpFGu+fG5N+f0bVPHRANLeqg4xI/6upI/Yf2HyecsfPj+OV9ww130Q==
X-Received: by 2002:a05:622a:4c83:b0:45b:5e8e:3440 with SMTP id
 d75a77b69052e-4608a52b548mr89433891cf.60.1729150713549; 
 Thu, 17 Oct 2024 00:38:33 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it.
 [79.46.200.231]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4609bc1f0b4sm6071021cf.50.2024.10.17.00.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 00:38:32 -0700 (PDT)
Date: Thu, 17 Oct 2024 09:38:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, dbassey@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost-user: fix shared object return values
Message-ID: <vmtm4zz6pkfcxr64wixa2wdjb7ujn2vaiapmziaqciiytcwe5v@7fh6zlfyf67l>
References: <20241016090606.2358056-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241016090606.2358056-1-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
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

On Wed, Oct 16, 2024 at 11:06:06AM +0200, Albert Esteve wrote:
>VHOST_USER_BACKEND_SHARED_OBJECT_ADD and
>VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE state
>in the spec that they return 0 for successful
>operations, non-zero otherwise. However,
>implementation relies on the return types
>of the virtio-dmabuf library, with opposite
>semantics (true if everything is correct,
>false otherwise). Therefore, current implementaion

s/implementaion/implementation

I hadn't seen it ;-P found with:
./scripts/checkpatch.pl --strict --branch master..HEAD --codespell

>violates the specification.
>
>Revert the logic so that the implementation
>of the vhost-user handling methods matches
>the specification.
>
>Fixes: 043e127a126bb3ceb5fc753deee27d261fd0c5ce

This is in from 9.0 ...

>Fixes: 160947666276c5b7f6bca4d746bcac2966635d79

... and this from 8.2, so should we consider stable branches?

I think it depends if the backends are checking that return value.

>Signed-off-by: Albert Esteve <aesteve@redhat.com>
>---
> hw/virtio/vhost-user.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

Thanks for the fix!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>index 00561daa06..90917352a4 100644
>--- a/hw/virtio/vhost-user.c
>+++ b/hw/virtio/vhost-user.c
>@@ -1607,7 +1607,7 @@ vhost_user_backend_handle_shared_object_add(struct vhost_dev *dev,
>     QemuUUID uuid;
>
>     memcpy(uuid.data, object->uuid, sizeof(object->uuid));
>-    return virtio_add_vhost_device(&uuid, dev);
>+    return !virtio_add_vhost_device(&uuid, dev);
> }
>
> static int
>@@ -1623,16 +1623,16 @@ vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
>         struct vhost_dev *owner = virtio_lookup_vhost_device(&uuid);
>         if (dev != owner) {
>             /* Not allowed to remove non-owned entries */
>-            return 0;
>+            return -EPERM;
>         }
>         break;
>     }
>     default:
>         /* Not allowed to remove non-owned entries */
>-        return 0;
>+        return -EPERM;
>     }
>
>-    return virtio_remove_resource(&uuid);
>+    return !virtio_remove_resource(&uuid);
> }
>
> static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
>-- 
>2.46.1
>


