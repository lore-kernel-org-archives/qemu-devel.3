Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4921C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 08:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2ms2-0006pf-Q9; Thu, 10 Apr 2025 04:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u2mrz-0006hT-V3
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 04:02:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u2mry-00079R-1l
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 04:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744272161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vfRH+zObEUYIcHIaSrpXjvWDAvHr7h54ZfjMU7XKwcM=;
 b=Ryma4UJGcUQR4J3aN2eJBBSVQtzPKlTbro10bUEG1//3HeKYUlN7r2IAu6eg76EOcJcmZt
 To52a6Vuka0BKziNUFKgBQ+cRSZ5VY+xCLORtnYqqbx0QkvuCld8y1Ysgq4iDKxDAF21fD
 seiX8Dfdc3lITEiq+QeCKa40IwMdEN0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-iaHzDJ28Oqmms_bYfRrtaA-1; Thu, 10 Apr 2025 04:02:38 -0400
X-MC-Unique: iaHzDJ28Oqmms_bYfRrtaA-1
X-Mimecast-MFC-AGG-ID: iaHzDJ28Oqmms_bYfRrtaA_1744272158
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43eea5a5d80so2919425e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 01:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744272157; x=1744876957;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfRH+zObEUYIcHIaSrpXjvWDAvHr7h54ZfjMU7XKwcM=;
 b=GoXSpQAQnkM6kfkuXdEmCnccuf/7zoXuEmF0avYhFo8CNKFLxKVgIfV7dxdvGwJTJo
 R9zJB4boKH8OJdmUmPZJUrrdCUMoZtH0t6IgGmWc5TCQrBm1ROTvSGbweiYx1cO1o9WE
 3UE7Q+Ien4rWjs7n8jBEo+2TeqB7Mwr+UGJfjXNpBXoaYBSR6GvDyHFduCCMpS+xFADO
 d+afb/zx23Scx91can97LXsFd9rHbnCqfyJsWJXVM1Lmjs+5XbODq9JQ1MARs8EIsrta
 fRMdhkmTz9auRXtuxAiyioGXiHfaay6mGl4f60JtkhuLaVfoWUAjP+aCkJiEPZBvy6PV
 /b8w==
X-Gm-Message-State: AOJu0YxNCOuJUKARhHf55VD/E9bFaLWRYSe6OEn4m91VFY84O9uYvxOj
 5NAyqBR/2iTyavoCG+knG6svNuWN80djBQNfZCaD5qIa+Aw4Y2Oz7y3ureGUsYldz5UWXSlJdWO
 Oh1iKDuv0RGun8wsPOVgGNFkpkgKYw3hu4Kw8eLXRgfIieuQMHNvx
X-Gm-Gg: ASbGncutaQjq3m/vVuS3IWwsh38H2IPCDKHSu0bWyY23M5j4Gz8tvBUiAQHsnxrORQ6
 c90/B+vw4slUPt23I5t7weYreIeiVac4gd6t0GW5eBfAmV16l9ZREn0oFCVefGvVR8I3WuDScg+
 w9id9R+bl03ADkXK67zjRZgnINsFLeb1zoxH/PlQo5zUs128adVLN8CqkbBExE7Cay9fk251XAP
 sWsw2CWeXw93agXP3hcww2KidC7GCVuVKyLnjaT20++PDhNra7S5SL6qDLvq48ec5mXQHVq57jh
 SSdFVQ==
X-Received: by 2002:a05:600c:a012:b0:43d:46de:b0eb with SMTP id
 5b1f17b1804b1-43f2d7bbfd3mr18706965e9.12.1744272157421; 
 Thu, 10 Apr 2025 01:02:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6VOi9jhNQq9p+qMloWxGNWY4L6GX8uQYPxpcsZQkIXVCs8EXzZZwxEyXeasU8kBcgAbu3SA==
X-Received: by 2002:a05:600c:a012:b0:43d:46de:b0eb with SMTP id
 5b1f17b1804b1-43f2d7bbfd3mr18706545e9.12.1744272156955; 
 Thu, 10 Apr 2025 01:02:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f205eccd8sm46022795e9.5.2025.04.10.01.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 01:02:36 -0700 (PDT)
Date: Thu, 10 Apr 2025 04:02:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, qemu-stable@nongnu.org
Subject: Re: [PATCH] virtio: Call set_features during reset
Message-ID: <20250410035935-mutt-send-email-mst@kernel.org>
References: <20250410-reset-v1-1-751cd0064395@daynix.com>
 <20250410034550-mutt-send-email-mst@kernel.org>
 <ece28e1e-ea85-4247-b2b1-54fbd8d2ce37@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ece28e1e-ea85-4247-b2b1-54fbd8d2ce37@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 10, 2025 at 04:54:41PM +0900, Akihiko Odaki wrote:
> On 2025/04/10 16:48, 'Michael S. Tsirkin' via devel wrote:
> > On Thu, Apr 10, 2025 at 04:42:06PM +0900, Akihiko Odaki wrote:
> > > virtio-net expects set_features() will be called when the feature set
> > > used by the guest changes to update the number of virtqueues. Call it
> > > during reset as reset clears all features and the queues added for
> > > VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS will need to be removed.
> > > 
> > > Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the guest doesn't support multiqueue")
> > > Buglink: https://issues.redhat.com/browse/RHEL-73842
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > 
> > The issue seems specific to virtio net: rset is reset,
> > it is distict from set features.
> > Why not just call the necessary functionality from virtio_net_reset?
> 
> set_features is currently implemented only in virtio-net; virtio-gpu-base
> also have a function set but it only has code to trace. If another device
> implements the function in the future, I think the device will also want to
> have it called during reset for the same reason with virtio-net.
> 
> virtio_reset() also calls set_status to update the status field so calling
> set_features() is more aligned with the handling of the status field.

That came to be because writing 0 to status resets the virtio device.
For a while, this was the only way to reset vhost-user so we just
went along with it.


> > 
> > 
> > > ---
> > >   hw/virtio/virtio.c | 86 +++++++++++++++++++++++++++---------------------------
> > >   1 file changed, 43 insertions(+), 43 deletions(-)
> > > 
> > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > index 85110bce3744..033e87cdd3b9 100644
> > > --- a/hw/virtio/virtio.c
> > > +++ b/hw/virtio/virtio.c
> > > @@ -2316,49 +2316,6 @@ void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index)
> > >       }
> > >   }
> > > -void virtio_reset(void *opaque)
> > > -{
> > > -    VirtIODevice *vdev = opaque;
> > > -    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
> > > -    int i;
> > > -
> > > -    virtio_set_status(vdev, 0);
> > > -    if (current_cpu) {
> > > -        /* Guest initiated reset */
> > > -        vdev->device_endian = virtio_current_cpu_endian();
> > > -    } else {
> > > -        /* System reset */
> > > -        vdev->device_endian = virtio_default_endian();
> > > -    }
> > > -
> > > -    if (k->get_vhost) {
> > > -        struct vhost_dev *hdev = k->get_vhost(vdev);
> > > -        /* Only reset when vhost back-end is connected */
> > > -        if (hdev && hdev->vhost_ops) {
> > > -            vhost_reset_device(hdev);
> > > -        }
> > > -    }
> > > -
> > > -    if (k->reset) {
> > > -        k->reset(vdev);
> > > -    }
> > > -
> > > -    vdev->start_on_kick = false;
> > > -    vdev->started = false;
> > > -    vdev->broken = false;
> > > -    vdev->guest_features = 0;
> > > -    vdev->queue_sel = 0;
> > > -    vdev->status = 0;
> > > -    vdev->disabled = false;
> > > -    qatomic_set(&vdev->isr, 0);
> > > -    vdev->config_vector = VIRTIO_NO_VECTOR;
> > > -    virtio_notify_vector(vdev, vdev->config_vector);
> > > -
> > > -    for(i = 0; i < VIRTIO_QUEUE_MAX; i++) {
> > > -        __virtio_queue_reset(vdev, i);
> > > -    }
> > > -}
> > > -
> > >   void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr)
> > >   {
> > >       if (!vdev->vq[n].vring.num) {
> > > @@ -3169,6 +3126,49 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
> > >       return ret;
> > >   }
> > > +void virtio_reset(void *opaque)
> > > +{
> > > +    VirtIODevice *vdev = opaque;
> > > +    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
> > > +    int i;
> > > +
> > > +    virtio_set_status(vdev, 0);
> > > +    if (current_cpu) {
> > > +        /* Guest initiated reset */
> > > +        vdev->device_endian = virtio_current_cpu_endian();
> > > +    } else {
> > > +        /* System reset */
> > > +        vdev->device_endian = virtio_default_endian();
> > > +    }
> > > +
> > > +    if (k->get_vhost) {
> > > +        struct vhost_dev *hdev = k->get_vhost(vdev);
> > > +        /* Only reset when vhost back-end is connected */
> > > +        if (hdev && hdev->vhost_ops) {
> > > +            vhost_reset_device(hdev);
> > > +        }
> > > +    }
> > > +
> > > +    if (k->reset) {
> > > +        k->reset(vdev);
> > > +    }
> > > +
> > > +    vdev->start_on_kick = false;
> > > +    vdev->started = false;
> > > +    vdev->broken = false;
> > > +    virtio_set_features_nocheck(vdev, 0);
> > > +    vdev->queue_sel = 0;
> > > +    vdev->status = 0;
> > > +    vdev->disabled = false;
> > > +    qatomic_set(&vdev->isr, 0);
> > > +    vdev->config_vector = VIRTIO_NO_VECTOR;
> > > +    virtio_notify_vector(vdev, vdev->config_vector);
> > > +
> > > +    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
> > > +        __virtio_queue_reset(vdev, i);
> > > +    }
> > > +}
> > > +
> > >   static void virtio_device_check_notification_compatibility(VirtIODevice *vdev,
> > >                                                              Error **errp)
> > >   {
> > > 
> > > ---
> > > base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
> > > change-id: 20250406-reset-5ed5248ee3c1
> > > 
> > > Best regards,
> > > -- 
> > > Akihiko Odaki <akihiko.odaki@daynix.com>
> > 


