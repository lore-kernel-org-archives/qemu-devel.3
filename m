Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E00C36017
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 06:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tz8n8-00019Q-Vh; Mon, 31 Mar 2025 02:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tz8mt-0000yo-I4
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 02:38:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tz8mr-0002MY-GM
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 02:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743403100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gVEYp2KPkhkVTUdFzdP7nTbmE1NDjUYm5VB1hsaY2Z8=;
 b=JrBm2NLObV7tSgxFXKcIk5qio1pyZLFBPWQoAXieDmAaVHa4FNH00duXuWzauryJUeW2o5
 8rDpiXPY9trrIK7YY/XLtBvcMg+sgMnyV+migPhyU4zamNJw9EI8Xn85eWqdkIkJgKRPQp
 CP2Jvb/qEwNnYB8CWwqmMozRqP+ylHY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-Be6MY6nrPjWon_LX0GQCGA-1; Mon, 31 Mar 2025 02:38:16 -0400
X-MC-Unique: Be6MY6nrPjWon_LX0GQCGA-1
X-Mimecast-MFC-AGG-ID: Be6MY6nrPjWon_LX0GQCGA_1743403095
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5e6a64bd1ecso3054817a12.2
 for <qemu-devel@nongnu.org>; Sun, 30 Mar 2025 23:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743403095; x=1744007895;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gVEYp2KPkhkVTUdFzdP7nTbmE1NDjUYm5VB1hsaY2Z8=;
 b=cflZM+rX6tL1JWfwfsI6xXq6GjOa+QuhmSVsVxS2buZenCCmL4EylDv20jfQtJYBHq
 BKR8MkjGHEFROyEcQwfGVgU0lt9fi706Y+1cWgScOhGOiF4Z3HekWlAUqkTD5IC8syhV
 1MIUyinRuBio+qA8EGWBql6tq1i8YHoI4KdRhm/6wZ1joU43ul9RvelxyPMngaQetIIr
 czfoAJHrxID1l9g/5x57At5z5cc8uRZmyvr7+6JoFuu2rNfZBAkfe0NLJGIxn69UoWFu
 r1CqvQDuXFUB7FuXpjZnKB52ePOUv4bUJfRd96R15NApwuTNGqVA6VWlmPbiUF30Ydcu
 5J8w==
X-Gm-Message-State: AOJu0YxaVS1z60zuQydV2WwSLnlUaycnYOlIW2Y5RP6NRM5ucDalMf2i
 4g3l6g28w/LR0G9UXiHYNblBhJDGDzCfUe+osqJMoM30+qdGZzV0Dy4wDl2yezri9BotQsNNthe
 Kf891wpeax5WKMuRdT0nAxcJp086a4W7Ylv/yYhvDg97YAbxyG7t40ApuX1m/NSSuPUE20Qtax8
 0vqgzZWNkFeWdrdDi1jP4dVng1EgM=
X-Gm-Gg: ASbGncs4NN2JGqenXF2JX+7ooPRNnyxObc1w8cg/FthTk+o42M2tdA0NDCP9ZTxG0aZ
 fHd3Lg24We2ffFWEMkkeO4I+GNiFHaBXNZEaW9WodU2024VanSk+tXn+6JqW3BgMj244Qo6p/Og
 ==
X-Received: by 2002:a05:6402:13cb:b0:5db:f5bc:f696 with SMTP id
 4fb4d7f45d1cf-5edfcbe9380mr5887615a12.5.1743403095523; 
 Sun, 30 Mar 2025 23:38:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh4uO81pZec8IoyICf8FTxAkV2EZzXXZDSDh1sADZBPeizZnw4um/LHz5yOrKEdmtcV67AFtSTyBbIf9kO6Hg=
X-Received: by 2002:a05:6402:13cb:b0:5db:f5bc:f696 with SMTP id
 4fb4d7f45d1cf-5edfcbe9380mr5887595a12.5.1743403095171; Sun, 30 Mar 2025
 23:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250314101535.1059308-1-haoqian.he@smartx.com>
 <20250327064348.3595732-1-haoqian.he@smartx.com>
In-Reply-To: <20250327064348.3595732-1-haoqian.he@smartx.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 31 Mar 2025 14:37:37 +0800
X-Gm-Features: AQ5f1Jq8hZ1oJEhTI71BHJTxQSv30T24lHNgCBSenyaVxR05Y5AVTG3AKKKvW9c
Message-ID: <CAPpAL=yYvdBuepyLV2xKKiUoSot8mrkd6W5QM=asSZTKVVn4cQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] vhost: fix the IO error after live migration
To: Haoqian He <haoqian.he@smartx.com>
Cc: qemu-devel@nongnu.org, sgarzare@redhat.com, mst@redhat.com, 
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
Content-Type: multipart/alternative; boundary="0000000000003038e206319daae1"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000003038e206319daae1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series v3 with virtio-net regression tests, everything works
fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Mar 27, 2025 at 2:46=E2=80=AFPM Haoqian He <haoqian.he@smartx.com> =
wrote:

> At the end of the VM live migration, the vhost device will be stopped.
> Currently, if the vhost-user backend crashes, vhost device's set_status()
> would not return failure, live migration won't perceive the disconnection
> with the backend. After the live migration is successful, the stale
> inflight
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
>  hw/virtio/virtio.c                     | 23 +++++++++++------
>  include/hw/virtio/vhost-scsi-common.h  |  2 +-
>  include/hw/virtio/vhost-vsock-common.h |  2 +-
>  include/hw/virtio/vhost.h              |  8 +++---
>  include/hw/virtio/virtio.h             |  2 +-
>  include/system/runstate.h              | 13 +++++++---
>  include/system/vhost-user-backend.h    |  2 +-
>  system/cpus.c                          |  8 ++++--
>  system/runstate.c                      | 35 ++++++++++++++++++++++----
>  34 files changed, 239 insertions(+), 142 deletions(-)
>
> --
> 2.44.0
>
>
>

--0000000000003038e206319daae1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">QE tested this series v3 with virtio-net regression tests,=
 everything=C2=A0works fine.<div><br></div><div>Tested-by: Lei Yang &lt;<a =
href=3D"mailto:leiyang@redhat.com">leiyang@redhat.com</a>&gt;</div></div><b=
r><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Mar 27, 2025 at 2:46=E2=80=AFPM Haoqian He &lt;<a h=
ref=3D"mailto:haoqian.he@smartx.com">haoqian.he@smartx.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">At the end of the=
 VM live migration, the vhost device will be stopped.<br>
Currently, if the vhost-user backend crashes, vhost device&#39;s set_status=
()<br>
would not return failure, live migration won&#39;t perceive the disconnecti=
on<br>
with the backend. After the live migration is successful, the stale infligh=
t<br>
IO will be submitted to the migration target host, which may be leading to<=
br>
the IO error.<br>
<br>
The following patch series fixes the issue by making the live migration<br>
aware of the loss of connection with the vhost-user backend and aborting<br=
>
the live migration.<br>
<br>
---<br>
=C2=A0 v1 ... v2<br>
=C2=A0 =C2=A0 1. Fix some grammar issues in commit message.<br>
=C2=A0 =C2=A0 2. Remove assert in vhost_scsi_common_stop and return error u=
pwards.<br>
<br>
=C2=A0 v2 ... v3<br>
=C2=A0 =C2=A0 1. Added more detailed comments and commit message.<br>
=C2=A0 =C2=A0 2. Change the newly added type name and parameter name.<br>
=C2=A0 =C2=A0 3. Remove set_status_ext, change the return type of set_statu=
s to int.<br>
<br>
Haoqian He (3):<br>
=C2=A0 system/runstate: add VM state change cb with return value<br>
=C2=A0 vhost: return failure if stop virtqueue failed in vhost_dev_stop<br>
=C2=A0 vhost-user: return failure if backend crash when live migration<br>
<br>
=C2=A0backends/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | 20 +++++++--------<br>
=C2=A0hw/block/vhost-user-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 27 +++++++++++---------<br>
=C2=A0hw/block/virtio-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 7 +++---<br>
=C2=A0hw/char/virtio-serial-bus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 3 ++-<br>
=C2=A0hw/core/vm-change-state-handler.c=C2=A0 =C2=A0 =C2=A0 | 18 ++++++++--=
---<br>
=C2=A0hw/display/vhost-user-gpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| 12 ++++++---<br>
=C2=A0hw/input/virtio-input.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 3 ++-<br>
=C2=A0hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++-<br>
=C2=A0hw/scsi/scsi-bus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0hw/scsi/vhost-scsi-common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| 13 +++++-----<br>
=C2=A0hw/scsi/vhost-scsi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 5 ++--<br>
=C2=A0hw/scsi/vhost-user-scsi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 18 +++++++------<br>
=C2=A0hw/vfio/migration.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0hw/virtio/vdpa-dev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 5 ++--<br>
=C2=A0hw/virtio/vhost-user-base.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| 23 ++++++++++-------<br>
=C2=A0hw/virtio/vhost-user-fs.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 23 ++++++++++-------<br>
=C2=A0hw/virtio/vhost-user-scmi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| 27 ++++++++++++--------<br>
=C2=A0hw/virtio/vhost-user-vsock.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| 15 +++++++----<br>
=C2=A0hw/virtio/vhost-vsock-common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 =
++++-----<br>
=C2=A0hw/virtio/vhost-vsock.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 11 ++++----<br>
=C2=A0hw/virtio/vhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 23 +++++++++--------<br>
=C2=A0hw/virtio/virtio-balloon.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 3 ++-<br>
=C2=A0hw/virtio/virtio-crypto.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 3 ++-<br>
=C2=A0hw/virtio/virtio-iommu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 3 ++-<br>
=C2=A0hw/virtio/virtio-rng.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 5 ++--<br>
=C2=A0hw/virtio/virtio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 23 +++++++++++------<br>
=C2=A0include/hw/virtio/vhost-scsi-common.h=C2=A0 |=C2=A0 2 +-<br>
=C2=A0include/hw/virtio/vhost-vsock-common.h |=C2=A0 2 +-<br>
=C2=A0include/hw/virtio/vhost.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 8 +++---<br>
=C2=A0include/hw/virtio/virtio.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 2 +-<br>
=C2=A0include/system/runstate.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 13 +++++++---<br>
=C2=A0include/system/vhost-user-backend.h=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0system/cpus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 ++++--<br>
=C2=A0system/runstate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 35 ++++++++++++++++++++++----<br>
=C2=A034 files changed, 239 insertions(+), 142 deletions(-)<br>
<br>
-- <br>
2.44.0<br>
<br>
<br>
</blockquote></div>

--0000000000003038e206319daae1--


