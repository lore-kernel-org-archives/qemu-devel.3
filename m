Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADC5C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIcG-0000R1-FX; Mon, 01 Jul 2024 11:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOIc6-0000Og-P9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOIc2-00035l-Pn
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719846398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zzM/pWDIJnEKQKE6+aKCyxIjgZcaxRnC2H+/ij66Kd0=;
 b=abgP7O8CuJfwI7oTJ9BHKWP88kZqNhucGLOj/0KDCi3squQGgc+sqXdWKMIB63eBcoxG/D
 dJpJpmi7J2OJ2dE0uLQElmf9huqYC5j/RVymOgd8hYW2FBys8UvVr4kCR68ulWTxopJVpr
 a23aZSO0PEBsdm2CKZdwoicm6LASB6g=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-kpvlPIT8N3ePC31VIv8P1A-1; Mon, 01 Jul 2024 11:06:36 -0400
X-MC-Unique: kpvlPIT8N3ePC31VIv8P1A-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ee4573c9b5so30466701fa.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 08:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719846394; x=1720451194;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zzM/pWDIJnEKQKE6+aKCyxIjgZcaxRnC2H+/ij66Kd0=;
 b=ixrvnDJ2IaCbCB+0fge1hPEXh3AnrdOEGxJ/WogEHw9QsyImJ1juong7a/B2GV9NV2
 sepvg9cVtprsvZnk0YlN3XkdU6xhwexQHd4ELmGk4i67kFUmnblSjEDjQ2FG1G4IJPEg
 S0vAiEn3gceMMDfUmKFJs7zZ4bNUKkBWUBxGJgEasZdyCaSolUHgqDy9x5uPtGMj4+/9
 24Ij0HdoSUFNtPUL2mR9OYIXsqAw7h5iNtN7BX6IW5PMxkg2jhrYmLS9MmuURgL5gqcf
 6cXEGPLprNSD2vC/WPht95NJerx5+wzBhKHwP1/bVLtii3LCe6KrYXWTcTvm6wCh2ktl
 Xr0w==
X-Gm-Message-State: AOJu0Yxj6BHAWkTY5CPtzo6oKlySEAdfksCaSZ/1lCSwhTEegOnR9HpV
 vDWXrlbEC8WEpiXRBjEop6TgUNRBh8dKUsMOzzLGoj5OERfbLkW38VpXX3Uj+u+RwbvYGFpD9eC
 5Ca0cobIIGe7xSVOfgFpsI0KZzcgn0TJ+QEkUs9YA6pDOMvkt6sCf
X-Received: by 2002:a2e:300c:0:b0:2ec:4f01:2c0f with SMTP id
 38308e7fff4ca-2ee5e3bf062mr46984681fa.26.1719846394634; 
 Mon, 01 Jul 2024 08:06:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRrCQmF2zFWBgWgu9IxImrSqHfhspzhHcMyE8qRMz2o57WDYYq4s1Xnp/W1vP697MPW3b+Lg==
X-Received: by 2002:a2e:300c:0:b0:2ec:4f01:2c0f with SMTP id
 38308e7fff4ca-2ee5e3bf062mr46984401fa.26.1719846393948; 
 Mon, 01 Jul 2024 08:06:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:614d:9fb:6fdd:72a4:f3d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af389b3sm159886285e9.1.2024.07.01.08.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 08:06:33 -0700 (PDT)
Date: Mon, 1 Jul 2024 11:06:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] hw/virtio: Fix the de-initialization of vhost-user devices
Message-ID: <20240701110607-mutt-send-email-mst@kernel.org>
References: <20240618121958.88673-1-thuth@redhat.com>
 <3f96e237-d367-4f8e-b96d-f51d4ba33ab1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f96e237-d367-4f8e-b96d-f51d4ba33ab1@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 01, 2024 at 04:07:56PM +0200, Thomas Huth wrote:
> On 18/06/2024 14.19, Thomas Huth wrote:
> > The unrealize functions of the various vhost-user devices are
> > calling the corresponding vhost_*_set_status() functions with a
> > status of 0 to shut down the device correctly.
> > 
> > Now these vhost_*_set_status() functions all follow this scheme:
> > 
> >      bool should_start = virtio_device_should_start(vdev, status);
> > 
> >      if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
> >          return;
> >      }
> > 
> >      if (should_start) {
> >          /* ... do the initialization stuff ... */
> >      } else {
> >          /* ... do the cleanup stuff ... */
> >      }
> > 
> > The problem here is virtio_device_should_start(vdev, 0) currently
> > always returns "true" since it internally only looks at vdev->started
> > instead of looking at the "status" parameter. Thus once the device
> > got started once, virtio_device_should_start() always returns true
> > and thus the vhost_*_set_status() functions return early, without
> > ever doing any clean-up when being called with status == 0. This
> > causes e.g. problems when trying to hot-plug and hot-unplug a vhost
> > user devices multiple times since the de-initialization step is
> > completely skipped during the unplug operation.
> > 
> > This bug has been introduced in commit 9f6bcfd99f ("hw/virtio: move
> > vm_running check to virtio_device_started") which replaced
> > 
> >   should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;
> > 
> > with
> > 
> >   should_start = virtio_device_started(vdev, status);
> > 
> > which later got replaced by virtio_device_should_start(). This blocked
> > the possibility to set should_start to false in case the status flag
> > VIRTIO_CONFIG_S_DRIVER_OK was not set.
> > 
> > Fix it by adjusting the virtio_device_should_start() function to
> > only consider the status flag instead of vdev->started. Since this
> > function is only used in the various vhost_*_set_status() functions
> > for exactly the same purpose, it should be fine to fix it in this
> > central place there without any risk to change the behavior of other
> > code.
> > 
> > Fixes: 9f6bcfd99f ("hw/virtio: move vm_running check to virtio_device_started")
> > Buglink: https://issues.redhat.com/browse/RHEL-40708
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   include/hw/virtio/virtio.h | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index 7d5ffdc145..2eafad17b8 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -470,9 +470,9 @@ static inline bool virtio_device_started(VirtIODevice *vdev, uint8_t status)
> >    * @vdev - the VirtIO device
> >    * @status - the devices status bits
> >    *
> > - * This is similar to virtio_device_started() but also encapsulates a
> > - * check on the VM status which would prevent a device starting
> > - * anyway.
> > + * This is similar to virtio_device_started() but ignores vdev->started
> > + * and also encapsulates a check on the VM status which would prevent a
> > + * device from starting anyway.
> >    */
> >   static inline bool virtio_device_should_start(VirtIODevice *vdev, uint8_t status)
> >   {
> > @@ -480,7 +480,7 @@ static inline bool virtio_device_should_start(VirtIODevice *vdev, uint8_t status
> >           return false;
> >       }
> > -    return virtio_device_started(vdev, status);
> > +    return status & VIRTIO_CONFIG_S_DRIVER_OK;
> >   }
> 
> Michael, any concerns or comments about this patch?
> 
> If not, I could also take it via my s390x tree since this fixes vhost-ccw
> devices on s390x.
> 
>  Thomas

I'm working on a pull request with this today.
I can drop it if you prefer ...


