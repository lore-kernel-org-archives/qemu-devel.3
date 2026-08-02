Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45730C55171
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 18:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqb8d-0002Rh-PN; Sun, 02 Aug 2026 14:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wqb8c-0002RX-8c
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 14:42:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wqb8a-0002Qb-BO
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 14:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785696134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9W6ovvu0HP8mcTCRHgHeMIDHxtW31Oahb5+cTIJm7S8=;
 b=BrePxEECVRZFkizgrtyi76jz85ro1ATEM/hl1tXGfZbDrILniLgwxtUfQjR6IOp4F3h0Oi
 hA2K3iLBP2Cq8UALHngb5ctCvpLKo6UcUMim5vcocG3dr/3q6VZ3MNcsW4IL7Q97oT5lhD
 hCtQr/hSpVAqLHXlsVkePZBuPcO+kQ0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-sk44f8y8OmGRUR1Bc3NmgA-1; Sun, 02 Aug 2026 14:42:13 -0400
X-MC-Unique: sk44f8y8OmGRUR1Bc3NmgA-1
X-Mimecast-MFC-AGG-ID: sk44f8y8OmGRUR1Bc3NmgA_1785696132
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4954dcd6131so15401245e9.3
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 11:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785696132; x=1786300932; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9W6ovvu0HP8mcTCRHgHeMIDHxtW31Oahb5+cTIJm7S8=;
 b=oG0+8A86BdHO3O4X0ahM0oi0PBi2Zm8a7zvsx7iwTUt9C2oe/pvTNUnTahYnAZB5bM
 6CcHk+lBespeethvNZalcHK9NYvRJyvcHDMKdH6QkFjRZ17j2mPmMx0DbBuesaAmag4H
 OfZ2MH+TuN89gavU3Xhce1wps//CkELE6gVDaHig/DhCZOpvk8m+yitq6Ue2Zry8XaxI
 zRAJDYXqK8UtpL1wsCOduf6JvtWD8Jme27lgqBoVoD0QS+3kZq7EHzX3jwsn8N+5s6cc
 4P+Ok5WGvAYGPE28GYwmMs8CdudHpHjix49E5NGX9D2/SY7Luzgr9DNhYdu3QD+/pse8
 EZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785696132; x=1786300932;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9W6ovvu0HP8mcTCRHgHeMIDHxtW31Oahb5+cTIJm7S8=;
 b=CYx38Yi6k9CAXn+CnM1LJSQ55Zoc0Yu+BOpU4qbeqp5eY/6/1Onfg494Di1ClVL8Hz
 ICDT528bzuQMrt//s/w/WtOKF4LYS6wYjPvOzjmT7Fv+5gshU5UvXezO5EQlEwSLOVF2
 FGi5JH6TlJ1EhCXiF4ZAdfXnIFRGuDGCJj3sMsuDbU0pET4noo9lllZkNnolLX3i/tbj
 yvBsOoL0Z9BJB0UrxsxTYyHlCSsDxYc9MB7C7gKEevj1rhITYRj8xMEJkoCMJ88HqMXl
 des7jLeqix6Mq3yDYm4DIclzks/iR0U32Vv5BoaZU6JATs/ZvJ9Jr3cLc51EHzpTgmac
 MCbg==
X-Gm-Message-State: AOJu0YxWm8h+AEgF4Cbcc0yFQ3Gmu4LhDwxgF/4YrkirkfD/ITsyNvv3
 Jy0VX7p4gOcBI3cc7AorShpsVj7wovVRpUdqwzowhSY+RAnsQSJUBMgvC0x8AG2RzdnHr5wMjT1
 3fWVx1XyvW4u46e83cM8RixkUwqLX7VGcRcw4e2ZU59FTsCZwAKXaULM1lfJWHOXu
X-Gm-Gg: AR+sD13mK6XWk8jliadiMJpN/+C0g4Kf55mDQCyg8S5NwLEmHPHJKK0wRxPZ38g0cHS
 2+neFkVo5tXNteqVx8TXSBJnOQqVxf87JbeDqn3wBI/G7obHPFbn9i46Ao2u682nDXpBb57oIRZ
 aD76nOR8Glc6Wnt9flXDW/sotAM/esStL/uactbcmEsBlcFAq1vfrP21o3CFN2TFrZuTfVbPcBP
 7C3hwFmHa+00ZeIqhq5XCMtRXtgze/k9GpQC82UQHIeT+N4RmrL45Ekku/akQRssdqYaz9Xp537
 Ym3TGkoQpYykMPMgDTxm8mZQvMDjwkBFgkQ+1sZQZhZo2B1kFDN+ENZyTFX36ocZRU5MHsalZDh
 jFaLNM0PZ2ojcZY1ninh16A==
X-Received: by 2002:a05:600c:1393:b0:493:bb0:3b43 with SMTP id
 5b1f17b1804b1-4980c66c7cemr152199785e9.2.1785696131997; 
 Sun, 02 Aug 2026 11:42:11 -0700 (PDT)
X-Received: by 2002:a05:600c:1393:b0:493:bb0:3b43 with SMTP id
 5b1f17b1804b1-4980c66c7cemr152199425e9.2.1785696131570; 
 Sun, 02 Aug 2026 11:42:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b6745csm166752665e9.7.2026.08.02.11.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:42:10 -0700 (PDT)
Date: Sun, 2 Aug 2026 14:42:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/virtio: propagate vhost_virtqueue_mask() errors
 from start path
Message-ID: <20260802143439-mutt-send-email-mst@kernel.org>
References: <20260716033303.95963-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716033303.95963-1-guobin@linux.alibaba.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 16, 2026 at 11:33:03AM +0800, Bin Guo wrote:
> vhost_virtqueue_start() unmasks the call notifier by calling
> vhost_virtqueue_mask(), whose vhost_set_vring_call ioctl can fail
> (closed vhost-user socket, kernel ENOMEM, revoked guest_notifier fd)
> but whose void signature throws the error away. vhost_dev_start()
> then reports success while the backend has no valid call eventfd for
> that vq, leaving the guest with a working kick path but no virtqueue
> interrupts -- a half-up state harder to diagnose than a clean failure.

Is there a real problem though?
So what if socket closed one second after we sent the fd,
does it matter?
And what does it mean for a guest_notifier fd to be revoked?
Is qemu likely to survive long after we started getting ENOMEM
for allocations of a hundred of bytes from the kernel?

I do not object to the patch on principle but let's get
it clear how it was tested, what is being fixed and why?

> Make vhost_virtqueue_mask() return int and handle the error in the
> start path via the existing fail unwind. Other callers reach the
> function through VirtioDeviceClass.guest_notifier_mask, whose void
> signature offers no upward error channel; they invoke it as a
> statement and remain unchanged.
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  hw/virtio/vhost.c         | 9 ++++++---
>  include/hw/virtio/vhost.h | 2 +-
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index af41841b52..ad22c37c33 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1470,8 +1470,10 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>       * will do it later.
>       */
>      if (!vdev->use_guest_notifier_mask) {
> -        /* TODO: check and handle errors. */
> -        vhost_virtqueue_mask(dev, vdev, idx, false);
> +        r = vhost_virtqueue_mask(dev, vdev, idx, false);
> +        if (r < 0) {
> +            goto fail;
> +        }
>      }
>  
>      if (k->query_guest_notifiers &&
> @@ -1918,7 +1920,7 @@ bool vhost_virtqueue_pending(struct vhost_dev *hdev, int n)
>  }
>  
>  /* Mask/unmask events from this vq. */
> -void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
> +int vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
>                           bool mask)
>  {
>      struct VirtQueue *vvq = virtio_get_queue(vdev, n);
> @@ -1940,6 +1942,7 @@ void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
>      if (r < 0) {
>          error_report("vhost_set_vring_call failed %d", -r);
>      }
> +    return r;
>  }
>  
>  bool vhost_config_pending(struct vhost_dev *hdev)
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 684bafcaad..1f62332d60 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -312,7 +312,7 @@ bool vhost_virtqueue_pending(struct vhost_dev *hdev, int n);
>  
>  /* Mask/unmask events from this vq.
>   */
> -void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
> +int vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
>                            bool mask);
>  
>  /**
> -- 
> 2.50.1 (Apple Git-155)


