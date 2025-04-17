Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D4DC369BD
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 01:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5EOq-0002Kh-4g; Wed, 16 Apr 2025 21:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1u5EOn-0002Ju-Fx
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 21:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1u5EOl-0006k3-Fi
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 21:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744854633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eoXW3euL7P1b5uSmPIoxAMaBPZOcNV1ldqEm0tWPLn8=;
 b=RpMb/UF0P0ViBCcGiqxsauPEb755+YJqrf8pwGQFxdBEfC5Q4rvpriwTHvpxwXTXOj0JXw
 4N+JhI7feJV+08uMIHHcyXeTlWjiwVyaL7NzeijC+ovSTFv61aMtrlptcF7ttvTVCDZOBR
 DZXvV+EnXCC0qJTvYPW8DOIhnbLEA/U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-klpRVbskMJOoL-9FYqmdlQ-1; Wed, 16 Apr 2025 21:49:20 -0400
X-MC-Unique: klpRVbskMJOoL-9FYqmdlQ-1
X-Mimecast-MFC-AGG-ID: klpRVbskMJOoL-9FYqmdlQ_1744854559
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5f4c30f881fso215404a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 18:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744854559; x=1745459359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eoXW3euL7P1b5uSmPIoxAMaBPZOcNV1ldqEm0tWPLn8=;
 b=i9VrSsZWfRWVeSrT2I983/rgG59cd/CrOuzVWmX/W8I3JPbUTyk8S3thtfKiUhCzMZ
 Sw8GD/GpzLtvFblMez+6oMaE2D9CJ6iE21bn8WbBC5eVz5BsTUFEdkkwsAaZjosG/cP9
 KdDK807oMpDtPbC7auYX2ZGfZCwUcUCjpaw0bR8mqsY/nwGz1bZC00vvxD7KXl2xtKdf
 1kK1DjjQRJM/K0MyzqmkxYklhsVgBEvZCzCxDadqjCYyqIVsi2NCweCrqQ20cAnThyi9
 UUJzjwnZyPjpzBwlcHEuvvY2UhlDUIc52EIpqSGpovB8DXhfANDurxJVKXk2gMu+kZ2h
 egZg==
X-Gm-Message-State: AOJu0Yyz9bQSZb8ym2/MQsFeFshSpFjDMyeSwOwS9gHZIupbaqZROFuU
 JzSJhHdojc31ZL5E7Fow8pxqEbick/0oAQk+LQUrrxGCfe2Ktf8x4HxDbSyp6au96Wx4m8bSdjY
 GemzPbEgPZb8o5MunOWKikG1r0vvwqEOO40xx5fhXhANnSrIPotwVXlLIFLv1SUSq4cHwL7S5g+
 XoSxTqh1QtVCOPMWkqN/QXqb7QCa8=
X-Gm-Gg: ASbGncvQKZGmIwTU0+3wBMvd+Q8Zs5JcE+7t4Mg7LvZDod+S2fBa+90+587sPOTRIpS
 mj4sS52yt9tVEMKD/0OnsgF+QLwQ1OhRDNOg+EFzRlQ6EYbmDD127wmlWbPnb5WSaWokLeQ==
X-Received: by 2002:a05:6402:3486:b0:5ed:837:e3db with SMTP id
 4fb4d7f45d1cf-5f4b770ba1fmr3913787a12.32.1744854558905; 
 Wed, 16 Apr 2025 18:49:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz9s8GC12Am+90eLD0JT2AHn+T88kVZVNYDHzSNx3KUp/zbpO0N2dDHR9WOl/NTV7ff3nUxoqD/2eq7jKlDRI=
X-Received: by 2002:a05:6402:3486:b0:5ed:837:e3db with SMTP id
 4fb4d7f45d1cf-5f4b770ba1fmr3913756a12.32.1744854558548; Wed, 16 Apr 2025
 18:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250401151819.1526461-1-haoqian.he@smartx.com>
 <20250416024729.3289157-1-haoqian.he@smartx.com>
In-Reply-To: <20250416024729.3289157-1-haoqian.he@smartx.com>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 17 Apr 2025 09:48:41 +0800
X-Gm-Features: ATxdqUEbOeZjib-VfImPIPAM7Okl7Yivuy_D-UczmwsEQAmJL3TYtZQX7sFBhL0
Message-ID: <CAPpAL=zN_Opj2nyutaDeZvcKDn0z_LYqJR77n=7Yz=AnhPx-xA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] vhost: fix the IO error after live migration
To: Haoqian He <haoqian.he@smartx.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, sgarzare@redhat.com, 
 raphael@enfabrica.net, fengli@smartx.com, yuhua@smartx.com, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "reviewer:vhost-user-scmi" <mzamazal@redhat.com>,
 David Hildenbrand <david@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Eric Auger <eric.auger@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:virtiofs" <virtio-fs@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

I tested this series of patches v5 with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Apr 16, 2025 at 10:49=E2=80=AFAM Haoqian He <haoqian.he@smartx.com>=
 wrote:
>
> At the end of the VM live migration, the vhost device will be stopped.
> Currently, if the vhost-user backend crashes, vhost device's set_status()
> would not return failure, live migration won't perceive the disconnection
> with the backend. After the live migration is successful, the stale infli=
ght
> IO will be submitted to the migration target host, which may be leading t=
o
> the IO error.
>
> The following patch series fixes the issue by making the live migration
> aware of the loss of connection with the vhost-user backend and aborting
> the live migration.
>
> ---
>   v1 ... v2
>     1. Fix some grammar issues in commit message.
>     2. Remove assert in vhost_scsi_common_stop and return error upwards.
>
>   v2 ... v3
>     1. Added more detailed comments and commit message.
>     2. Change the newly added type name and parameter name.
>     3. Remove set_status_ext, change the return type of set_status to int=
.
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
>
>


