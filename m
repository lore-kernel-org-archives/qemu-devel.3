Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB6ECD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 10:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtm0O-0002ma-E6; Mon, 08 Apr 2024 06:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rtm0J-0002m0-9J
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rtm0H-0001Lw-RH
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712571208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4iE3H5A4di9y+xNKlKn1R4IgnUXKHyFuDJBIcrRdoAc=;
 b=LO6t/M92eJiGyR6XH10GfSam9OgwOAxCfR8nl4WeSvtiQ9hSsr8wfFzzM0a5shhkG1qMyg
 v1B1wOoi/NWAX/BjPsKVBc0oBoce/uPzFlXPewMBHu3cyP8QLwM3Yr3km7DcnKZNK3yi9H
 8oP9o0APsEjjRdqY2xN1g+48PTjfVIE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-Nz6eQlNSOaSbAmof7quD1Q-1; Mon, 08 Apr 2024 06:13:25 -0400
X-MC-Unique: Nz6eQlNSOaSbAmof7quD1Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4147de378b9so21571555e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 03:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712571204; x=1713176004;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4iE3H5A4di9y+xNKlKn1R4IgnUXKHyFuDJBIcrRdoAc=;
 b=mzWboQiNRs5GkK8Y/dXOzIRUBWkBV+mpC/rg6lREHDwN45NLrkeGm4Z5v6JQXzet8J
 K5Ktb66p5VTmTD9eHg9bTyBFBwkZQrF6cBsXi8JU93o1hJPHaAVRes9S5Jc0yfuamm6H
 XoyWFXCT70PziqijVZ6Iff0KbSHqE3MTwCmyZnf3Lep4rv6W8PS6pYbuF6rNlFgHP9BH
 jL60C+nlPNGZwcoahl6VVzCucLWVE5JPEr2GiNJrpIO7ije87qVLSrCzlyyJyBV+jres
 0JuRc8xvNevGTHNo72zIFn6eWCP1m3OYOm0HdpIa3mlnl6hNQePIj2EJF5wWArLYaszW
 rfgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTAtXSVpGE44gcdyXlM5QJLOLlvMIm9fiPkoRRdrL91qp9kp6qTQidJlk6vDoP0KDk7ytUZ9I4bEIYaMQ+VDvVI+SxS+M=
X-Gm-Message-State: AOJu0Yx5dMkFozhKaLy3cTrvelfU0VARfv56PJdaS0GTy4e7ChHzrULc
 zx7Ya68F3KFdiVB0b+d63/9+eNEQyW6E4HSyJSyn6m5ZyEWYyCtduXGJ0SNj/ZOVwGGYVQPkqUq
 lb050Ks1MgkI96X9f3mm5PqPKDuVbK8B1Jy5JxlOyUhrvsUVB0HhC
X-Received: by 2002:a05:600c:1384:b0:415:43f2:332b with SMTP id
 u4-20020a05600c138400b0041543f2332bmr7292339wmf.2.1712571204034; 
 Mon, 08 Apr 2024 03:13:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJH+eDzpm15041yRChMBa7AmTCwihBrAnj6MWOjwtEY8uSm9Ft9hJsE4K9f/5sY3u6OiJgaQ==
X-Received: by 2002:a05:600c:1384:b0:415:43f2:332b with SMTP id
 u4-20020a05600c138400b0041543f2332bmr7292316wmf.2.1712571203483; 
 Mon, 08 Apr 2024 03:13:23 -0700 (PDT)
Received: from redhat.com ([2.52.152.188]) by smtp.gmail.com with ESMTPSA id
 c11-20020adffb4b000000b00345bcb4fdb9sm1922451wrs.16.2024.04.08.03.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 03:13:22 -0700 (PDT)
Date: Mon, 8 Apr 2024 06:13:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] virtio-net: Fix vhost virtqueue notifiers for RSS
Message-ID: <20240408061306-mutt-send-email-mst@kernel.org>
References: <20240326-vhost-v1-0-09bd85b1ba2c@daynix.com>
 <20240326-vhost-v1-1-09bd85b1ba2c@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-vhost-v1-1-09bd85b1ba2c@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Mar 26, 2024 at 07:06:29PM +0900, Akihiko Odaki wrote:
> virtio_net_guest_notifier_pending() and virtio_net_guest_notifier_mask()
> checked VIRTIO_NET_F_MQ to know there are multiple queues, but
> VIRTIO_NET_F_RSS also enables multiple queues. Refer to n->multiqueue,
> which is set to true either of VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS is
> enabled.
> 
> Fixes: 68b0a6395f36 ("virtio-net: align ctrl_vq index for non-mq guest for vhost_vdpa")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Jason, are you merging this?

> ---
>  hw/net/virtio-net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 9959f1932b1b..a6ff000cd9d3 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3426,7 +3426,7 @@ static bool virtio_net_guest_notifier_pending(VirtIODevice *vdev, int idx)
>      VirtIONet *n = VIRTIO_NET(vdev);
>      NetClientState *nc;
>      assert(n->vhost_started);
> -    if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_MQ) && idx == 2) {
> +    if (!n->multiqueue && idx == 2) {
>          /* Must guard against invalid features and bogus queue index
>           * from being set by malicious guest, or penetrated through
>           * buggy migration stream.
> @@ -3458,7 +3458,7 @@ static void virtio_net_guest_notifier_mask(VirtIODevice *vdev, int idx,
>      VirtIONet *n = VIRTIO_NET(vdev);
>      NetClientState *nc;
>      assert(n->vhost_started);
> -    if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_MQ) && idx == 2) {
> +    if (!n->multiqueue && idx == 2) {
>          /* Must guard against invalid features and bogus queue index
>           * from being set by malicious guest, or penetrated through
>           * buggy migration stream.
> 
> -- 
> 2.44.0


