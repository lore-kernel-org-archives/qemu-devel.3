Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9253C3ABC5
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 05:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF4Jt-0003lC-HD; Wed, 14 May 2025 01:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uF4Jr-0003g6-SP
 for qemu-devel@nongnu.org; Wed, 14 May 2025 01:06:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uF4Jq-0007Dm-8R
 for qemu-devel@nongnu.org; Wed, 14 May 2025 01:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747199172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qIq2vTZ/lFGWxb1y9RYqkYNealT0sSrdwaDrnzrSjBI=;
 b=Nc8A1Md0FQ6ILd8m3BLqVfuLUn1JlbOqXK1chGuM/ylCjR2esVrlptDB3E5EaoiPMdPNDd
 o7vGthNWY/U6JiIMKE+C4KFOEyk41IPbUNji6GBcev3Jvtonn2ZzBF0Z3C8mxuFVcXtU+N
 OX2hYQV2MPVIDn0X+D4NS1rA3WHZpP0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-nPAnmKvlOcGrVc3tG6JZ7g-1; Wed, 14 May 2025 01:06:11 -0400
X-MC-Unique: nPAnmKvlOcGrVc3tG6JZ7g-1
X-Mimecast-MFC-AGG-ID: nPAnmKvlOcGrVc3tG6JZ7g_1747199170
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-30a29af28d1so5536945a91.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 22:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747199170; x=1747803970;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qIq2vTZ/lFGWxb1y9RYqkYNealT0sSrdwaDrnzrSjBI=;
 b=pZ3Z+SRnzEa2/4Iw8mEYGfCvns0cXoIs4h6EI5WuPsv3CggidPSLXcl9tqytBGGOZl
 TZP6iLX+AgPGb7AWQlxGedqH1iKqECtI0JNcUYquDnJIrzVyXaygW24zkpHefTWf5JV0
 6AkYmcSmdlYYhLoYH4CCNyCxU3/TS/A4W67lAxapLGeKrUQoZPuC/bCutlKWmmCNR1wP
 k4sa0kMpzDLeRn1Bs32JEuecAR0kBmCkGz8bd1pXwvXdUYRq/o3PotqruGjltmInZJaY
 33I4xyagYVD0j9dvMi6PkkM9wFChvH1tTM8GkNZM//vXIKJBnlxjEa2I8XXR1mTZpVJz
 adXA==
X-Gm-Message-State: AOJu0Ywime8ZTGfoo00j3ef+c8JPXji13TkI+y8072/VZ/6Eb/NHvxft
 vPGEV9TjVvJC9uvG+KkNroBTK0ldGk5ZM9wV8vmqfDATF10IaKmbUkbk80ERJ/dDC7BiEVFD6/Q
 pYiNPNAgcJhOR1kbmzIHOlJWqT8qvcLi7UwtVqb/qcNlClE0YoRjlI0UVWGxFE6E8uQep/+tACf
 57sBevZMAd2l6XmMpuGqwv6+ebwnM=
X-Gm-Gg: ASbGncs/MLb+pFb6ehW5wD8siMflVaZJmfwHBHB8eVSeJw6lzlXYUDTx8pyHhUnttA5
 kZpQWXLb087sX0cUYDu7dsM+2gR/aEia5/SIHKl1/r1mBBukOdEB4dbyyNpMrKhLV9yUp
X-Received: by 2002:a17:90b:6c6:b0:30c:540b:9ba with SMTP id
 98e67ed59e1d1-30e2e5b947emr3530441a91.10.1747199169966; 
 Tue, 13 May 2025 22:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/zQjz2dSgnpDBY9onIxez7dUd+JJoSKed4nBIMcpIzzypJaIoUDp7Hjbr+g5Jnsie3hJmx4ucd37tO7gbA8Q=
X-Received: by 2002:a17:90b:6c6:b0:30c:540b:9ba with SMTP id
 98e67ed59e1d1-30e2e5b947emr3530401a91.10.1747199169509; Tue, 13 May 2025
 22:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250510-n-v1-1-19ee26ac3ca6@daynix.com>
In-Reply-To: <20250510-n-v1-1-19ee26ac3ca6@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 14 May 2025 13:05:58 +0800
X-Gm-Features: AX0GCFuq8jQlq26IJa6Kbl37pUgLHON74m03g32riiDNXa32BFQzQPjZr-rowBs
Message-ID: <CACGkMEt7xoX-HvV1mOo=zqpyV0se2ELBMvNV-uGpKUZPQ-PB2A@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: Add queues for RSS during migration
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, May 10, 2025 at 3:24=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> virtio_net_pre_load_queues() inspects vdev->guest_features to tell if
> VIRTIO_NET_F_RSS or VIRTIO_NET_F_MQ is enabled to infer the required
> number of queues. This works for VIRTIO_NET_F_MQ but it doesn't for
> VIRTIO_NET_F_RSS because only the lowest 32 bits of vdev->guest_features
> is set at the point and VIRTIO_NET_F_RSS uses bit 60 while
> VIRTIO_NET_F_MQ uses bit 22.
>
> Instead of inferring the required number of queues from
> vdev->guest_features, use the number loaded from the vm state.
>
> Fixes: 8c49756825da ("virtio-net: Add only one queue pair when realizing"=
)
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/hw/virtio/virtio.h |  2 +-
>  hw/net/virtio-net.c        | 11 ++++-------
>  hw/virtio/virtio.c         | 14 +++++++-------
>  3 files changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 638691028050..af52580c1e63 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -211,7 +211,7 @@ struct VirtioDeviceClass {
>      int (*start_ioeventfd)(VirtIODevice *vdev);
>      void (*stop_ioeventfd)(VirtIODevice *vdev);
>      /* Called before loading queues. Useful to add queues before loading=
. */
> -    int (*pre_load_queues)(VirtIODevice *vdev);
> +    int (*pre_load_queues)(VirtIODevice *vdev, uint32_t n);

This turns out to be tricky as it has a lot of assumptions as
described in the changelog (e.g only lower 32bit of guest_features is
correct etc when calling this function).

Looking at the commit that introduces this which is 9379ea9db3c that says:

"""
Otherwise the loaded queues will not have handlers and elements
in them will not be processed.
"""

I fail to remember what it means or what happens if we don't do 9379ea9db3c=
.

Thanks


