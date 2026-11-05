Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D90E606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JH4/AJvc;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=r6AvRwXm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP0Ei-0003j8-Gg; Thu, 05 Nov 2026 11:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xP0Eg-0003iy-M4
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:22:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xP0Ee-000091-W2
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793895762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yp4b6kyGEJPqZint46r2vh9Z9N2SkjAHusHEqtZNfKo=;
 b=JH4/AJvc/mR+S5X44wHz5LbleJlgMed4Iwl4yd0RXWBsQ4FmX/2nAqfJFxJHt4MreFoyG9
 NWtB22WjZKY5A6bZvwlB6Xe+f2C+VP6KwC6daP+qAtJs5OuXWmVtMOSLsUMf6LbRLdLc61
 x8H6j7HddMkp+/4JtZ2jWtzuTQacgwg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-2KvdnaIkPtiFKZvLadCBIw-1; Thu, 05 Nov 2026 11:22:40 -0500
X-MC-Unique: 2KvdnaIkPtiFKZvLadCBIw-1
X-Mimecast-MFC-AGG-ID: 2KvdnaIkPtiFKZvLadCBIw_1793895759
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a80bd45e1cso11677995e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 08:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793895759; x=1794500559; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yp4b6kyGEJPqZint46r2vh9Z9N2SkjAHusHEqtZNfKo=;
 b=r6AvRwXmkH729xA2+tEN0KzM6xQPe+fxx5LRHRtkbUZBKVfsyKaRZU2TKa3PFa1N2A
 nv9zHe4eQvNY88PvIMf3PNezVKJzgbyklaxjBMP7Vh+IE8I8axUsiwIVKZ3f6zrCYy/r
 t5l9pf53j+JR13Qjx7+2VYFd/xvq3fI9Dq5/aUQULWAX5Cwh67sXbdtOVswO4Td7d1y2
 vV5sN0SeW44zG3SKDDHG8qZhNpFjeoQweHsMCNI1HgxZcp6/dYZo3FU2ghMwmlqxRnAa
 ld31n/htu/NhGF0CncodddhGJBh2GewCHMk8FFg9HdrACGGAUJafFrHkctoN9ANoe8rf
 34Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793895759; x=1794500559;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yp4b6kyGEJPqZint46r2vh9Z9N2SkjAHusHEqtZNfKo=;
 b=c9GenTlN4IBvZwvJ3rbIioUogieyv7PyNoaF/4Q/I3V1RvRouVmR8RuPt6nOv+6REp
 t5gyDVrX3gQeh+fEhJXEnNZP+JPa3+i8IAQTMkgsUzBpirfSays6SF493YHQG7tOTkb1
 /6/tKwxxRB55QINOgsmbk0TDWJDUyyMXQTDijTMIV++kVl0kgegV085e6OJtXRn0qxVR
 t6UIZhwP6tOujeyUtWiQ2rrmMxBaPSrwbnxYNQxXZ+0+1hGnyLsPjkY4p1VZ/d9HStZU
 Ei1L13aRmVcAKj94ilckRhvwCQl7wrR7Npk5bxzYyc8xtKgk4XUIKATFmJYyoJyJ/3Ie
 WWPQ==
X-Gm-Message-State: APuU4Z/jd/0X9ERnfniX/GGpCB0IBdnk2Rp9XVhFcIrbuWtRdZip+tfl
 eSuU5g4othQEWv83tHcSPvXZp+FKvLfDCebuS4ewZqd8DRO3AGtWTS23ek4e+W9wFRxlQ0oulof
 vRFNaxzHIV5U2t59rp8DJgyBxCL849tf6ieML0cJPOCmXuUbk3TNHhDY8
X-Gm-Gg: AYBFou0x8iJ2ad12J4ohFhNGRUSb1kR6j9L7DR7zw+pAwRp/e3d6Q2H2RQKzC3jjCCC
 KsA2RoRaLNxsM+zfKfjq9wd7vo3nWO2472SwDKj3m4o7Z2j7DOAk+0D6bAM3e4pIP3/3MMwLEQ/
 T4bCMWWS9lCIZxQdMOgwxU/FmeR7eMydbTVs8DC2BbpU2CYoRiA58oEODnRcCS1nVQvpU0INLfZ
 /YJXWm7GTCIfHV1ZGVaFM5Y/jl+jPPRSzN46cNTgeE0e1FcxpdxtusvfNllHCvAv9VPwyjvsVru
 15IhitaqwxKFzkrlEOE6RQYwW8e4bqC8aUV+AhL1Q2TiJG2o0Gl0Iz7UU/VOcBV+YIgaQnvyvty
 +X163Jh/JD0GIJBPaDpcn7MORCrjYG9/jmEgJUqrYSI5AkGnOYA==
X-Received: by 2002:a05:600c:37cc:b0:4a2:1cc:6551 with SMTP id
 5b1f17b1804b1-4ac1980143dmr389437585e9.35.1793895759223; 
 Thu, 05 Nov 2026 08:22:39 -0800 (PST)
X-Received: by 2002:a05:600c:37cc:b0:4a2:1cc:6551 with SMTP id
 5b1f17b1804b1-4ac1980143dmr389437015e9.35.1793895758684; 
 Thu, 05 Nov 2026 08:22:38 -0800 (PST)
Received: from sgarzare-redhat ([5.77.70.210])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed08343dsm10816165f8f.30.2026.11.05.08.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 08:22:38 -0800 (PST)
Date: Thu, 5 Nov 2026 17:22:35 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, virtio-fs@lists.linux.dev
Subject: Re: [PATCH] vhost-user-fs: fix virtqueue array leak on realize failure
Message-ID: <CAGxU2F78TcwwEhudRsgDP15JszMEr3CY50omS+13qmh-jqASgA@mail.gmail.com>
References: <20261104080939.439160-1-dtalexundeer@yandex-team.ru>
 <auyR97ogGdws_udv@sgarzare-redhat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auyR97ogGdws_udv@sgarzare-redhat>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 at 15:29, Stefano Garzarella <sgarzare@redhat.com> 
wrote:
>
> On Wed, Nov 04, 2026 at 01:09:39PM +0500, Alexandr Moshkov wrote:
> >On failure, vhost_dev_init() clears vhost_dev, so the error path frees
> >NULL instead of the virtqueue array. Save the pointer locally and use
> >it to free the array on failure.
> >
> >Fixes: 98fc1ada4cf7 ("virtio: add vhost-user-fs base device")
> >Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> >---
> > hw/virtio/vhost-user-fs.c | 6 ++++--
> > 1 file changed, 4 insertions(+), 2 deletions(-)
> >
> >diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
> >index 0d8842817a..9b33fe13bb 100644
> >--- a/hw/virtio/vhost-user-fs.c
> >+++ b/hw/virtio/vhost-user-fs.c
> >@@ -198,6 +198,7 @@ static void vuf_device_realize(DeviceState *dev, Error **errp)
> > {
> >     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> >     VHostUserFS *fs = VHOST_USER_FS(dev);
> >+    struct vhost_virtqueue *vhost_vqs;
> >     unsigned int i;
> >     size_t len;
> >     int ret;
> >@@ -255,7 +256,8 @@ static void vuf_device_realize(DeviceState *dev, Error **errp)
> >
> >     /* 1 high prio queue, plus the number configured */
> >     fs->vhost_dev.nvqs = 1 + fs->conf.num_request_queues;
> >-    fs->vhost_dev.vqs = g_new0(struct vhost_virtqueue, fs->vhost_dev.nvqs);
> >+    vhost_vqs = g_new0(struct vhost_virtqueue, fs->vhost_dev.nvqs);
>
> While checking if others users of vhost_dev_init() have the same issues,

FYI backends/vhost-user.c has the same issue. I'll send a patch to fix 
it.

Thanks,
Stefano

> I discovered that most of them store it in the parent structure (the
> equivalent of VHostUserFS). Then looking at VHostUserFS I discovered
> that we already have the vhost_vqs field there since the beginning, but
> we never used it, so what about using that one here and in
> vuf_device_unrealize() ?
>
> Thanks,
> Stefano
>
> >+    fs->vhost_dev.vqs = vhost_vqs;
> >     ret = vhost_dev_init(&fs->vhost_dev, &fs->vhost_user,
> >                          VHOST_BACKEND_TYPE_USER, 0, errp);
> >     if (ret < 0) {
> >@@ -272,7 +274,7 @@ err_virtio:
> >     }
> >     g_free(fs->req_vqs);
> >     virtio_cleanup(vdev);
> >-    g_free(fs->vhost_dev.vqs);
> >+    g_free(vhost_vqs);
> > }
> >
> > static void vuf_device_unrealize(DeviceState *dev)
> >--
> >2.34.1
> >


