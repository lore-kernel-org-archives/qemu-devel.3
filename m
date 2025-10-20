Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF0FCCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzRm-0005aX-HH; Mon, 20 Oct 2025 19:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzRj-0005a4-JE
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:37:48 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzRh-0001B8-Sf
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:37:47 -0400
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-93ba2eb817aso465104439f.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761003464; x=1761608264; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EMO0MrFbKexo46fhlROjPVzTaWoxtVfAFFn9D/Anass=;
 b=Pe3AtA9d44pmAIeD++lxFtTxu9WddzQO7lRcUJrrp57y5yHoRzuiml/GZIdHmALdn/
 JD4RTwSZGFeIrTs+O51CbV6Fb9497qKQ9Eh2mUYcXZW1jASt5TP5NxpSpgClrUJM6B60
 is8V1zB76/D9zB1K4AfB9vt9Na93papikYaj1sViVSKPJp0rRwDHFbEWBOncWKPAnB5U
 Fhy6CSnnuT0Tu6e7FVCkXsjYEHAemfM81627alaR+vn1XVMEaDVvMcVMdvmBBLdHrjiq
 urLR6HpEtyos9qTl8/Ia0esdW0fk7okWrJ4PNZK5jpNa792/RmdNWqtR21GIYGm5KI1i
 vtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761003464; x=1761608264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EMO0MrFbKexo46fhlROjPVzTaWoxtVfAFFn9D/Anass=;
 b=m1EXJ/ng8ErXRzKaaueH1GAmNP0l5gz45kAeY6ZHEmAVSBzfdx9qv/8IGvV0MpJHPf
 SGevCoja//6ckPXDsx9t1Aq2LsKVA7ww9HWWXKeS6rRvNQB2pazgsjVwpJrGICR1wHbp
 crIiJKrCzkdA7tLSShNcSHgPZUknKWS4V6pDbZnLryArl10N0RcqdsvciM3KGJUVU26b
 ZWaGlDp85Aw9Y6aBVR8GR0iXig3tY/ThVUWPAr8RinJEoqHqgrDBHiT3Pf4sCk0/5wB/
 3FycMyzn0hmyjNVqNhBa4uccRm+7zH+mTg1wnRYkCcesJgOh0A7ATlFWwTHQZ43wTXXE
 HMKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzvZKVMFEZQjqCIVlLyki09xt6DK7CUSi+Efrs7WpvQAGsC/j81AsJwVd8HPMGTD6l2/W+yFx0URF4@nongnu.org
X-Gm-Message-State: AOJu0YxWrf88ysN6eoFnRMMYIOqPA8D4HQTE77DW3XqwgDWg9QFdq5Bx
 J0eB9kebBOxnGuMdq5uS8+3tsgxu08dav8n9u9uxqWN8Qov42ATUBH803jH4WWsaCi+cNtKPFhi
 ia3ZM23lpn5QckQGd3EnyGos0PouvxPY=
X-Gm-Gg: ASbGncv5ghz3tMXL+974gwdZd9LzKafD+dUEzRiI3DwrhthWVd8tYapxisdxOopiR9T
 Wad4dUtmCI/0FJHjlbsiW3WCJthglOR4hR5iNOESJClNZFhV70hPw4fseFO8YSZRvCsToSz1KxG
 CYuGHdMweitaMz9JCErU3f3Nt1QouG86EtsnrgEDpNWh44IWgxMUIQsNX6bmV5d3xGUYsgGYwL0
 +SZYSXXl2f+eBgxI1VxuU/EKJ9uxEZJXeaUwYZfqm+aLgigrLmEuVZowBWT
X-Google-Smtp-Source: AGHT+IF3q8l57Y1gZ2RrUJGKreTBZ6HgpsP0tygKVG9HBfH4iQg+qcq01nSD4iIaAQLsi5/hIJkjXVw5Xb4tVkXdm7Q=
X-Received: by 2002:a92:c24f:0:b0:427:6e7f:89f8 with SMTP id
 e9e14a558f8ab-430c5263cfdmr239305445ab.10.1761003464341; Mon, 20 Oct 2025
 16:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-15-vsementsov@yandex-team.ru>
In-Reply-To: <20251016114104.1384675-15-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 20 Oct 2025 19:37:33 -0400
X-Gm-Features: AS18NWCDRzg4iLvdZbedBX22_yzrIV5vMo7g5eqAi6kenu-rWaN33-rDQNKG4jU
Message-ID: <CAFubqFv-sxLUMLuWtGig+GLW5S=A+0VfhLtxmTLbMH5FGcyNww@mail.gmail.com>
Subject: Re: [PATCH v2 14/25] virtio: introduce .skip_vhost_migration_log()
 handler
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de, 
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>


On Thu, Oct 16, 2025 at 7:49=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> For vhost user backend migration we'll need to disable memory
> logging on the device. Let's prepare a corresponding handler for
> the device.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c          | 10 ++++++++++
>  include/hw/virtio/virtio.h |  2 ++
>  2 files changed, 12 insertions(+)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 09d00e4d98..3e5192ec23 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1138,6 +1138,16 @@ static int vhost_migration_log(MemoryListener *lis=
tener, bool enable)
>      struct vhost_dev *dev =3D container_of(listener, struct vhost_dev,
>                                           memory_listener);
>      int r;
> +
> +    if (dev->vdev) {
> +        VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(dev->vdev);
> +
> +        if (vdc->skip_vhost_migration_log &&
> +            vdc->skip_vhost_migration_log(dev->vdev)) {
> +            return 0;
> +        }
> +    }
> +
>      if (enable =3D=3D dev->log_enabled) {
>          return 0;
>      }
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 7db8046766..620ee4e389 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -238,6 +238,8 @@ struct VirtioDeviceClass {
>      /* May be called even when vdev->vhost_started is false */
>      struct vhost_dev *(*get_vhost)(VirtIODevice *vdev);
>      void (*toggle_device_iotlb)(VirtIODevice *vdev);
> +
> +    bool (*skip_vhost_migration_log)(VirtIODevice *vdev);
>  };
>
>  void virtio_instance_init_common(Object *proxy_obj, void *data,
> --
> 2.48.1
>
>

