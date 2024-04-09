Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86E4C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 09:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru7qM-0004M0-Ij; Tue, 09 Apr 2024 05:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru7qK-0004K2-UX
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 05:32:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru7qI-0005Wb-Hw
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 05:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712655157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MfiktwCOWWAUZw/wdhupen/7N1dQmFotSqqQXIY8qew=;
 b=AZVb8p3UeUDJbzlbGMl97hud1FeWK2BK9pMg5Z6oOvQfOBTsYCSY5nwKh9FphikK0yk0H7
 IfOGUZHyD8qnGm9BTVV60cv4Tu5tx9+OnWXg+e+MyB2oVC2PIk4vH/XIW2VsmTF2FWR80F
 H4cowXMxlJKd+IiHsn+dwG5xoMrQ/tE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-i1AOarZ-NiaQlYFDOlILpA-1; Tue, 09 Apr 2024 05:32:36 -0400
X-MC-Unique: i1AOarZ-NiaQlYFDOlILpA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4155db7b58cso27696835e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 02:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712655154; x=1713259954;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MfiktwCOWWAUZw/wdhupen/7N1dQmFotSqqQXIY8qew=;
 b=IKZOosMSD4MV5ISmpKWVdi9OhfiN/XT7GUBaIt7ZEKZymlW0bag8LWF7VUcnM/Zbw4
 qovXkmPrJ+tMYDuXuh7nkoVd4tU0Xb7n5WkxjlhQ75racnuAxiQzTI53hVdnCjU+MeWT
 yqDrFP8Mrt4nZeZvPAcNdOG2Rohghp41zV+lqLkHY4HorqlI2eRbUlxsb6jIMhuiSz4/
 VQa53GJOigk7REGwwSIzrnPyEIcL9M2mqau2pSlfWGPCemLwzBtCHPQy09ESrAScDh3+
 nzW9Q+Xr18ACF5+f8jrGUC7y5rO8Aq1KKti+5kkUt+mX7+BoTcWbM2NOD+29D+GOi78j
 tQmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM8uNigqnUqcuB4y5thLOceLxfFxi507A2/+B0HAzPtUhi4P4KVCdZzw/w/2AXKM7YgRka58vA+fj4UFxn7XOkJkhJVPs=
X-Gm-Message-State: AOJu0YwJHY0WO/TNsZ6e/h/gSQsfipf4igPX0SuncDqiy3AbWgeTEhbq
 ZaoojDCpgWfKE3srP1KHvPOpc8DEcuyWBOnsNfRY3JL4NVFfVtA9clrPdyBFD/MRCru76my6ZqR
 lVn+dMeCG1TOtfuu4k57Ct9f1s9CwgQ/pl4W/182STRs0fHm42WLVR++SwHgQ
X-Received: by 2002:a05:600c:3483:b0:416:b0dd:1fcc with SMTP id
 a3-20020a05600c348300b00416b0dd1fccmr604204wmq.29.1712655154382; 
 Tue, 09 Apr 2024 02:32:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEleHWRtUYt9ab+zlVA/XEwL1npKoyYJ8fI1Y+YxuFAlv/eN3Z94inHoirSmsgCeXENQFHIfA==
X-Received: by 2002:a05:600c:3483:b0:416:b0dd:1fcc with SMTP id
 a3-20020a05600c348300b00416b0dd1fccmr604178wmq.29.1712655153877; 
 Tue, 09 Apr 2024 02:32:33 -0700 (PDT)
Received: from redhat.com ([2.52.134.26]) by smtp.gmail.com with ESMTPSA id
 dr20-20020a5d5f94000000b0033ea499c645sm11187563wrb.4.2024.04.09.02.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 02:32:33 -0700 (PDT)
Date: Tue, 9 Apr 2024 05:32:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: lyx634449800 <yuxue.liu@jaguarmicro.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH v2] vhost: don't set vring call if guest notifiers is not
 enabled
Message-ID: <20240409053143-mutt-send-email-mst@kernel.org>
References: <CACGkMEsrT4xxW-KzLm=rTqXf0P+u2=0fy03z3EsHZFEqQePjJg@mail.gmail.com>
 <20240408073311.2049-1-yuxue.liu@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408073311.2049-1-yuxue.liu@jaguarmicro.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Apr 08, 2024 at 03:33:11PM +0800, lyx634449800 wrote:
> When conducting performance testing using testpmd in the guest os,
> it was observed that the performance was lower compared to the
> scenario of direct vfio-pci usage.
> 
> In the commit 96a3d98d2cdbd897ff5ab33427aa4cfb94077665, the author
> provided a good solution. However, because the guest OS's
> driver(e.g., virtio-net pmd) may not enable the msix capability, the
> function k->query_guest_notifiers(qbus->parent) may return false,
> resulting in the expected effect not being achieved. To address this
> issue, modify the conditional statement.
> 
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>


I tested v1 and it fails. Sent as reply on that patch.
Since all you did is tweak description and title the
problem is probably still there in v2.

> ---
> V2: Update commit description and title
> 
>  hw/virtio/vhost.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index f50180e60e..b972c84e67 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1266,13 +1266,15 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>          vhost_virtqueue_mask(dev, vdev, idx, false);
>      }
>  
> -    if (k->query_guest_notifiers &&
> -        k->query_guest_notifiers(qbus->parent) &&
> -        virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR) {
> -        file.fd = -1;
> -        r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
> -        if (r) {
> -            goto fail_vector;
> +    if (k->query_guest_notifiers) {
> +        if (!k->query_guest_notifiers(qbus->parent) ||
> +            (k->query_guest_notifiers(qbus->parent) &&
> +            virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR)) {
> +            file.fd = -1;
> +            r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
> +            if (r) {
> +                goto fail_vector;
> +            }
>          }
>      }
>  
> -- 
> 2.43.0


