Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0526AEE4987
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 09:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soK1D-0003Re-9Z; Wed, 11 Sep 2024 05:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soK1C-0003R8-2J
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:52:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soK1A-0007VN-HG
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726048328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SKQQaVxt0SGGSUH21Q34eNn4zC46mfiQWVGtEMQk0u0=;
 b=WIww77ZpE6IHC9tcI5LUY2lmSvgOdckapqWuVcLI+yLibdyOIM4q5veBZiEd5BDckm/a3a
 gnEuPezpi59ZJ9y6IHnWCatfTZl81Or1yYrz6RolKg7hfu5T76ZMGLEX2Zbq6yj5VK7gNe
 mmFN1lK4R3dwWm8Kt4YGpu3eTMxg/DI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-fF0T8dSKMl2yMwm_HTatBQ-1; Wed, 11 Sep 2024 05:52:07 -0400
X-MC-Unique: fF0T8dSKMl2yMwm_HTatBQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5c384fc1c65so1119471a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 02:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726048321; x=1726653121;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SKQQaVxt0SGGSUH21Q34eNn4zC46mfiQWVGtEMQk0u0=;
 b=WNiV4hGcWDvzO9Ex/3bwh2McAkHD2OS+oq1te3klnZTq3hqF2jWPaECnQhhV7sD0ls
 APdxVdhtXMiRMb/B+12E6ch/Q8v4e+z0t2whiqZmyMleVUibNzqqmKVRs1pK6kb8s6qo
 2NFdiZgeOqvUyqy2XKymRQ6e364bp5fMl6XWQ0zvKCpbOyiBIcSDvbjGh+tdO+FHmSeO
 g6d9VsyvjeWlZRv6bZUZccPpO5+pVk1hive2IVGdGLjpIwm6PDrrGreIZxk22nv0tnRk
 EMqJio1bqJragEildozkxcLXiIOCBnAz0gDaq5u0MZ8h3OI7z9Pmh7EfhPHxqr0wcTJy
 84OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN1BHjI3X0VUQFHZIVXbtceCVhvgbfa9wW/Qq022xU7i5mBDwf8s1ovEAioRwVbiCIrntqRQlHyFjT@nongnu.org
X-Gm-Message-State: AOJu0YzmRECrgW4w0/ZpWhWYkUrOE11w4ACcrln0+JakcbCp3xyix8XY
 M0ZMTepySKb8KNXI7KDIPvhSn5HroHb8LCQFim8uGcMVh+DEOTnDeYqBgOkF1pyXZIo7vZ8Lq8d
 epUbXc2uzl4iRllhrBcxePcaasJSKFedr11EE9HCN6PypEopJAf+1
X-Received: by 2002:a05:6402:5d2:b0:5c2:7699:92ef with SMTP id
 4fb4d7f45d1cf-5c4015ef7ddmr7667410a12.16.1726048320749; 
 Wed, 11 Sep 2024 02:52:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHx9kwm0Cn5goNs3raDCEY7DftUPh9sNzvAmDJfYZZ10jdHCLjFMPMwGLCqtueqPMYRThGFw==
X-Received: by 2002:a05:6402:5d2:b0:5c2:7699:92ef with SMTP id
 4fb4d7f45d1cf-5c4015ef7ddmr7667340a12.16.1726048319613; 
 Wed, 11 Sep 2024 02:51:59 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:a3d1:80b4:b3a2:70bf:9d18])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd5212asm5261914a12.57.2024.09.11.02.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 02:51:58 -0700 (PDT)
Date: Wed, 11 Sep 2024 05:51:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, raphael@enfabrica.net, qemu-devel@nongnu.org,
 armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 berrange@redhat.com, pbonzini@redhat.com, hreitz@redhat.com,
 kwolf@redhat.com, yc-core@yandex-team.ru
Subject: Re: [PATCH v5 0/3] vhost-user-blk: live resize additional APIs
Message-ID: <20240911055131-mutt-send-email-mst@kernel.org>
References: <20240625121843.120035-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625121843.120035-1-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 25, 2024 at 03:18:40PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> v5:
> 03: drop extra check on is is runstate running

Causes build failures when generating qdoc.

https://gitlab.com/mstredhat/qemu/-/jobs/7792086965


> 
> Vladimir Sementsov-Ogievskiy (3):
>   qdev-monitor: add option to report GenericError from find_device_state
>   vhost-user-blk: split vhost_user_blk_sync_config()
>   qapi: introduce device-sync-config
> 
>  hw/block/vhost-user-blk.c | 27 ++++++++++++++------
>  hw/virtio/virtio-pci.c    |  9 +++++++
>  include/hw/qdev-core.h    |  3 +++
>  qapi/qdev.json            | 24 ++++++++++++++++++
>  system/qdev-monitor.c     | 53 ++++++++++++++++++++++++++++++++++++---
>  5 files changed, 105 insertions(+), 11 deletions(-)
> 
> -- 
> 2.34.1


