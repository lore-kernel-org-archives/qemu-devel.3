Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20F0C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 18:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEAyk-0001zQ-5N; Sun, 11 May 2025 14:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEAyi-0001yd-CF
 for qemu-devel@nongnu.org; Sun, 11 May 2025 14:00:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEAyg-00019d-Fp
 for qemu-devel@nongnu.org; Sun, 11 May 2025 14:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746986441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ALE2KMQWCGBqmIePCS8sG6Vuvf8zpyoGRV/yfZwMSQc=;
 b=WzSHaw7mz5SlkJp1+PNxOfGsqcQJBVG9etZOh1QCmSKoC8cVQS3AGorSHdh4uCmq7Ka9vf
 +CICwc7GH9vUVi1VtS8VSWKZpjz0Z2rXC9JY1XOq5WuoGQ7dxe6z+ONm/TjBbHCwRYsLMk
 +cvQtviFiu+9Zgshk0wlWlZJIJ481dU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-v5c-u7nWMwmCqcwDo-QgUA-1; Sun, 11 May 2025 14:00:39 -0400
X-MC-Unique: v5c-u7nWMwmCqcwDo-QgUA-1
X-Mimecast-MFC-AGG-ID: v5c-u7nWMwmCqcwDo-QgUA_1746986438
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a0b5c28f05so1918812f8f.2
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 11:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746986438; x=1747591238;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALE2KMQWCGBqmIePCS8sG6Vuvf8zpyoGRV/yfZwMSQc=;
 b=ucmPk1wChwW72FEOH6XVRlLh/PKsbK71pMwphiaO1rimQBgV/+j2tF3+4bB0797YZN
 5qO8G8bMdsYLieaQbsuAG+J9xIpwCbuY3NXl4wRHEXS6TUccOlPc9kCKmsNk/QLeKyYa
 UShaLU/vaHyymQdEG5XSOhR4I6TyVJeRmEqSkjteJOOqyH/HESNgvW8nUYNhHrE9L5Ox
 fP13XCaSQ5KHSSWTUU1IiUx2ugmUzpPh89dsdD6Zbu5Mk9tQ858POohUofF4A1Is+AGp
 fU2FC0GYkGPoleOJpTdivhVfd895HOVqWYPwgAzu4m1ovhqcYf8qWmre5oDVtcku7SLx
 cTMQ==
X-Gm-Message-State: AOJu0Yyl2dwmlPu0EgJoXtl/BFH9ZyYLTBRFa/at7XWWL8G0oad010Gu
 XQgbZgkgSIjFUzTGule4wlfAHoC7TGt7iD28Y4R9vSvt4u+Te6X0u8x9198G4ESTyw14z7mjTnJ
 btMKXV1Sb6GG0NmvJJPxUWioncX+QzmMcN4S0xOaahaS8C7IMUtPq
X-Gm-Gg: ASbGncs9zRHblUvwiLVLzq9eJnVBibxerlR4wqhpeefK3I8MFu1TqyMoCUa5vly7OdI
 PIin4/Zv7B5Jr7gds1HWZ4e6Q9dnD0MH5T6x+UeyZCUmrn6yu+mkzBOpDeaL5gHJ76f78w/UCKP
 yXqWuM7i0TYJTvs/V6vRlzNtBJ4dDYC/eZ3ibnT4A8LeJ64DXUhhigXvVQpDAOmV3gU4TxXKBvq
 OtIZx3QiUawjYYVxOJraxTBd7H6LGYefafzYyRSCxiclqdmPaj0dPbEQoYA97aHx4SNyVsDPTsh
 p0qRdA==
X-Received: by 2002:a5d:64ec:0:b0:3a0:ba27:646c with SMTP id
 ffacd0b85a97d-3a1f64b5845mr7656925f8f.44.1746986438277; 
 Sun, 11 May 2025 11:00:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP6QZpAGTJUBarwm/jThMZVY0U+88W4RO0pCjydS8n777dkK7eO9KK2cxTY7i/hxvART9r/A==
X-Received: by 2002:a5d:64ec:0:b0:3a0:ba27:646c with SMTP id
 ffacd0b85a97d-3a1f64b5845mr7656893f8f.44.1746986437805; 
 Sun, 11 May 2025 11:00:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4cc39sm9761816f8f.100.2025.05.11.11.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 11:00:36 -0700 (PDT)
Date: Sun, 11 May 2025 14:00:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Haoqian He <haoqian.he@smartx.com>
Cc: qemu-devel@nongnu.org, sgarzare@redhat.com, raphael@enfabrica.net,
 fengli@smartx.com, yuhua@smartx.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>, Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "reviewer:vhost-user-scmi" <mzamazal@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eric Auger <eric.auger@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:virtiofs" <virtio-fs@lists.linux.dev>
Subject: Re: [PATCH v5 0/3] vhost: fix the IO error after live migration
Message-ID: <20250511135931-mutt-send-email-mst@kernel.org>
References: <20250401151819.1526461-1-haoqian.he@smartx.com>
 <20250416024729.3289157-1-haoqian.he@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416024729.3289157-1-haoqian.he@smartx.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Apr 15, 2025 at 10:47:25PM -0400, Haoqian He wrote:
> At the end of the VM live migration, the vhost device will be stopped.
> Currently, if the vhost-user backend crashes, vhost device's set_status()
> would not return failure, live migration won't perceive the disconnection
> with the backend. After the live migration is successful, the stale inflight
> IO will be submitted to the migration target host, which may be leading to
> the IO error.
> 
> The following patch series fixes the issue by making the live migration
> aware of the loss of connection with the vhost-user backend and aborting
> the live migration.

tagged, thanks a lot!


yet something to improve:

in the future pls post a new thread, not part of old thread.

also in the future, pls do not quote a huge mail just to add two lines
at the end, snip.



> ---
>   v1 ... v2
>     1. Fix some grammar issues in commit message.
>     2. Remove assert in vhost_scsi_common_stop and return error upwards.
> 
>   v2 ... v3
>     1. Added more detailed comments and commit message.
>     2. Change the newly added type name and parameter name.
>     3. Remove set_status_ext, change the return type of set_status to int.
> 
>   v3 ... v4
>     1. Call set_status() only if the function pointer is not NULL in the
>        3rd patch.
>     2. Add the more detailed commit messages for the 3rd patch.
> 
>   v4 ... v5
>     1. Fix code style issues in patch v4.
>     2. Rebased on master.
> 
> Haoqian He (3):
>   system/runstate: add VM state change cb with return value
>   vhost: return failure if stop virtqueue failed in vhost_dev_stop
>   vhost-user: return failure if backend crash when live migration
> 
>  backends/vhost-user.c                  | 20 +++++++--------
>  hw/block/vhost-user-blk.c              | 27 +++++++++++---------
>  hw/block/virtio-blk.c                  |  7 +++---
>  hw/char/virtio-serial-bus.c            |  3 ++-
>  hw/core/vm-change-state-handler.c      | 18 ++++++++-----
>  hw/display/vhost-user-gpu.c            | 12 ++++++---
>  hw/input/virtio-input.c                |  3 ++-
>  hw/net/virtio-net.c                    |  3 ++-
>  hw/scsi/scsi-bus.c                     |  2 +-
>  hw/scsi/vhost-scsi-common.c            | 13 +++++-----
>  hw/scsi/vhost-scsi.c                   |  5 ++--
>  hw/scsi/vhost-user-scsi.c              | 18 +++++++------
>  hw/vfio/migration.c                    |  2 +-
>  hw/virtio/vdpa-dev.c                   |  5 ++--
>  hw/virtio/vhost-user-base.c            | 23 ++++++++++-------
>  hw/virtio/vhost-user-fs.c              | 23 ++++++++++-------
>  hw/virtio/vhost-user-scmi.c            | 27 ++++++++++++--------
>  hw/virtio/vhost-user-vsock.c           | 15 +++++++----
>  hw/virtio/vhost-vsock-common.c         | 12 ++++-----
>  hw/virtio/vhost-vsock.c                | 11 ++++----
>  hw/virtio/vhost.c                      | 23 +++++++++--------
>  hw/virtio/virtio-balloon.c             |  3 ++-
>  hw/virtio/virtio-crypto.c              |  3 ++-
>  hw/virtio/virtio-iommu.c               |  3 ++-
>  hw/virtio/virtio-rng.c                 |  5 ++--
>  hw/virtio/virtio.c                     | 22 ++++++++++------
>  include/hw/virtio/vhost-scsi-common.h  |  2 +-
>  include/hw/virtio/vhost-vsock-common.h |  2 +-
>  include/hw/virtio/vhost.h              |  8 +++---
>  include/hw/virtio/virtio.h             |  2 +-
>  include/system/runstate.h              | 13 +++++++---
>  include/system/vhost-user-backend.h    |  2 +-
>  system/cpus.c                          |  8 ++++--
>  system/runstate.c                      | 35 ++++++++++++++++++++++----
>  34 files changed, 239 insertions(+), 141 deletions(-)
> 
> -- 
> 2.44.0


