Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B2606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YVZpLrb/;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mmPcCeEm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOyTW-0000NU-1n; Thu, 05 Nov 2026 09:29:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xOyTR-0000Mg-Aa
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 09:29:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xOyTO-0001nU-Ap
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 09:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793888986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pjtj63fo+s61GN+f9LF+Yf7YLV6I3/P5rwrY4Pl9Izk=;
 b=YVZpLrb/+O6/zI42namBWUFvTX3b+4kUSUNXcjur7BubjWooFANBKxqB3/QI5EJJQPqpDT
 3zfDBzVPbVxSJphkW6w1vtgHqYvTzxwDhDFxiKGEhQZvgPO3lN9AFrb8HoZQXdvT2rmO0Q
 XRACltEzJQvJ2FD1iMJrUl8eJyQqd4M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-xYqGeb-jNgisAYPNwRrQBA-1; Thu, 05 Nov 2026 09:29:44 -0500
X-MC-Unique: xYqGeb-jNgisAYPNwRrQBA-1
X-Mimecast-MFC-AGG-ID: xYqGeb-jNgisAYPNwRrQBA_1793888983
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a359c7f47bso19836865e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 06:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793888983; x=1794493783; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pjtj63fo+s61GN+f9LF+Yf7YLV6I3/P5rwrY4Pl9Izk=;
 b=mmPcCeEmYNMIsSHUOOJemGSojDg0Vd2lsx86UXeDArP1bshaCbrw+EXxFXDFP1MC25
 KXwa6xZb2hEHjsga6qyBh+WiXjBGFuoYKqwn7whzY//G+95O7d6MCELs/Uzvg5nDaygz
 xGAm75TNT11vlLkfFLQDLqGnmYfeC5AQ60ZyKZFXdSjujn0j9wEIv0S03hPS43ch75cl
 LYdWFlX/Bvn+JoAbUDK0Xad77D2fpToZB6Yh0qDZnZe2QDOnavboX3omBkWGgEZcJzgv
 W9XmLw2I6aPJx/6+JsKbo8Zb9glTenkIOGPN1Vsv5vjtM6EpGt78JqtnoXR6Xo6o9Dk+
 gQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793888983; x=1794493783;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pjtj63fo+s61GN+f9LF+Yf7YLV6I3/P5rwrY4Pl9Izk=;
 b=qYAqcKMOAC5o44EGRM/o4EolfsaK29tXbD2rMlpFS+A2QTtqDmjxgoY7ensllNQ4ZO
 9X88jRZTx8DbO4W6nsRRZNSfNhtrgZNK70WDJzKtNmNxJWAZuJd5xhKEPtULKAETuivS
 OcA6mZuUrsThX97ejYsBWV+MIkawuIJ5NVKgwm3yQBKF8QMeoIkVTpd+nahG3HvPG4JC
 amgzGPegV9qrJMPwu7AjW1DfYSpIjkYONU61RA0zeJwR82df86n7GNGblHVoFErBzSEj
 YiqbO834Yr+zLRWm0MmVsrKPYcv3qlhoSbRuPpHLUC1VOalfhn1OLW05CZB1UcrPZbcZ
 kWYw==
X-Gm-Message-State: APuU4Z+mowGzpkxD15nBrvtmpwlE7NDd1NkBrI9zwQTmk/hlzl8Tdn7d
 DsFufSLe398wV/sp3c2nBxI4DcALCd3b5cAgdWWul9Ibe8Wd4RCUKe/ficjxzRBzmGY+HlJFTUM
 x1VGwRGfddTG193R0xxW48qSmjIBIB3D8lV/prYaajApUb3L/nLVOkQwo
X-Gm-Gg: AYBFou2nxnSwM54hrguk3qaGahZhYBm71fo9TBJxVwU6c8sFHU1b6r7kNnnqRQywTya
 8JyMHpAs7A62YmUITA3XbjAuLVS77OD8DfL8jWBYG77HpIvMk4Iu1JGAUe43Q+kCkeEjf10bg0i
 YXSLNaTXI5tGk6fGZHozPM6wcubiu9Tyh9AQcD9xIbTP9fOA+vxQLVzaGB+j/QI+4L3YwVe5G2l
 PJ5rLHuM7vngIQVBuqbh7kHPkmQfaWgJVvYpyYK9YG4Klpr7akTJ2mk8tNaYXdOWlpzvg/hJ/5F
 DAFjqypA6lfW2xvRgd9cj8MuqZ+lWi0b2NfZJaUV11dDA3cMnZBSyCCrGScQKVcTB2M+SOkQEfc
 pQ44BRmPDySqi98qFNeArdGtVkx56njzjNVnE4gP4kDdhBKH/
X-Received: by 2002:a05:600c:4454:b0:4a3:5a7b:6002 with SMTP id
 5b1f17b1804b1-4ac17d19777mr413960925e9.28.1793888982794; 
 Thu, 05 Nov 2026 06:29:42 -0800 (PST)
X-Received: by 2002:a05:600c:4454:b0:4a3:5a7b:6002 with SMTP id
 5b1f17b1804b1-4ac17d19777mr413960505e9.28.1793888982262; 
 Thu, 05 Nov 2026 06:29:42 -0800 (PST)
Received: from sgarzare-redhat ([94.32.51.69])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e2ae72dsm118795875e9.3.2026.11.05.06.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 06:29:41 -0800 (PST)
Date: Thu, 5 Nov 2026 15:29:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, virtio-fs@lists.linux.dev
Subject: Re: [PATCH] vhost-user-fs: fix virtqueue array leak on realize failure
Message-ID: <auyR97ogGdws_udv@sgarzare-redhat>
References: <20261104080939.439160-1-dtalexundeer@yandex-team.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261104080939.439160-1-dtalexundeer@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 04, 2026 at 01:09:39PM +0500, Alexandr Moshkov wrote:
>On failure, vhost_dev_init() clears vhost_dev, so the error path frees
>NULL instead of the virtqueue array. Save the pointer locally and use
>it to free the array on failure.
>
>Fixes: 98fc1ada4cf7 ("virtio: add vhost-user-fs base device")
>Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>---
> hw/virtio/vhost-user-fs.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
>index 0d8842817a..9b33fe13bb 100644
>--- a/hw/virtio/vhost-user-fs.c
>+++ b/hw/virtio/vhost-user-fs.c
>@@ -198,6 +198,7 @@ static void vuf_device_realize(DeviceState *dev, Error **errp)
> {
>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>     VHostUserFS *fs = VHOST_USER_FS(dev);
>+    struct vhost_virtqueue *vhost_vqs;
>     unsigned int i;
>     size_t len;
>     int ret;
>@@ -255,7 +256,8 @@ static void vuf_device_realize(DeviceState *dev, Error **errp)
>
>     /* 1 high prio queue, plus the number configured */
>     fs->vhost_dev.nvqs = 1 + fs->conf.num_request_queues;
>-    fs->vhost_dev.vqs = g_new0(struct vhost_virtqueue, fs->vhost_dev.nvqs);
>+    vhost_vqs = g_new0(struct vhost_virtqueue, fs->vhost_dev.nvqs);

While checking if others users of vhost_dev_init() have the same issues, 
I discovered that most of them store it in the parent structure (the 
equivalent of VHostUserFS). Then looking at VHostUserFS I discovered 
that we already have the vhost_vqs field there since the beginning, but 
we never used it, so what about using that one here and in 
vuf_device_unrealize() ?

Thanks,
Stefano

>+    fs->vhost_dev.vqs = vhost_vqs;
>     ret = vhost_dev_init(&fs->vhost_dev, &fs->vhost_user,
>                          VHOST_BACKEND_TYPE_USER, 0, errp);
>     if (ret < 0) {
>@@ -272,7 +274,7 @@ err_virtio:
>     }
>     g_free(fs->req_vqs);
>     virtio_cleanup(vdev);
>-    g_free(fs->vhost_dev.vqs);
>+    g_free(vhost_vqs);
> }
>
> static void vuf_device_unrealize(DeviceState *dev)
>-- 
>2.34.1
>


