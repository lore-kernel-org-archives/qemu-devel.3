Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B73CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 18:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFziW-0000Mt-Aj; Mon, 03 Nov 2025 13:55:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vFziT-0000MO-W6
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 13:55:46 -0500
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vFziM-0004rL-5F
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 13:55:45 -0500
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-9459db1337cso423710739f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 10:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762196133; x=1762800933; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/2Yc5g++72PvHYSlGzWW6LFCnQRHPVrJgugKuvbl2c=;
 b=bhUwtYcOn2IPeEk04wthMDPmmiT6sOo68T9qn9f6B4qxhPittURi1EjZT8NxmnmmVY
 DuSGbRlHJxE8cw3c9DBEpxUuILjF+4ux2M/LiaLHwjgWLo7R8LDHgAPkJdIKY6+d/aJO
 AHIst1n386R8e+sqkhitgBGGpV9Z/afvCa0k866k/C8nFQhjRGzHPhT5ExokKkK+pnfo
 Zp5jeTQAX553K5z9fnKlI7vj51Wt65fCePrCYtkDIhFjc8KLb/mPH87GNtVn2HzrE8uh
 L/0SGlG8dVaxOie+1upsmdForIdImy2fL63KxMqqVb1HqRN8ZPpqvkCajenGcfsjziDT
 zAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762196133; x=1762800933;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N/2Yc5g++72PvHYSlGzWW6LFCnQRHPVrJgugKuvbl2c=;
 b=uO3kaeelVk7ZdA8rGlG+tq6dtYEWPNiUbaR1XRG8pMuGMTMReb3S/4nz7BolSZZDP5
 OqvTJw2IOh3mbW1LuwykngACOEhX97MJT7Q4sWMUjPuIa064YB1bwreq+jjZnoPFo+iz
 5XjHHuc8+yEgDgIWz6qQ6wx6UDSBLIyeSJCtIqRurftKuGAJyawhBtZv0c9Nt+BXSGJj
 tvbosP2cGvkdehyXTg4ZTfmNx7ARe1BzVKAFJh1HH/zszsUhFxPQi15LG0AWL3SdXYBT
 dUBOaU4pUP2CpWR8h/7d+4D6PGhgDjKqEaUMXYPB/6BX7S8uTno9ohbpWlcS1qi47WFC
 4zPQ==
X-Gm-Message-State: AOJu0Yx1LBBgO6IvHe22KIEcpdp692MSdOtljtroyqQInAODUa2otXg4
 RT52raXxP9Wwdhj2Az+kZEd572ZVET8xXI25y9CZTTx0knvP4fIfdWZDNHOvlQYvWzuiNlT8VkA
 Llzh55YKXjf9Gzc465B4t5BiQ5b6FuqU=
X-Gm-Gg: ASbGncsH8uBdu/QOm0x7vOx3EVxWAE7IlpAchTTKb+dJLfdULDxzbQeuGjUwSapUFX5
 IHIkuUJWRA9lg3e8U/9C6INUUc7R1DJw/yRRIqf15cJ3nQVLZNFxqA9b0KsKas1LXfvci466VL6
 RmQOHfwuSvrzXc/MHYnvQzHw7J545yQovOOd0srWrEEW9n5kzHXvWpynjPIJ0Zk8x0aPbMW1b08
 FikEvUkaUsyX7Fe+sZUQ37QdNvxlt4mFqfNKNVYtQEF4EZfnMazD9ZIbcEBBDT/oErhfVAWnil+
 T2GislMArlBX0QyhGTAdULQ1JCI=
X-Google-Smtp-Source: AGHT+IFRvp9muUVCrjVZr84zjceZjqq7G80AcVu+lOTojEEaj09a40qFCoVyuMQdE2UdzyU5r6BQ++FwLg/jnjrysNM=
X-Received: by 2002:a05:6602:1545:b0:940:dbee:4a67 with SMTP id
 ca18e2360f4ac-94822802ca1mr2035574139f.0.1762196133492; Mon, 03 Nov 2025
 10:55:33 -0800 (PST)
MIME-Version: 1.0
References: <20251029093939.3251188-1-dtalexundeer@yandex-team.ru>
 <20251029093939.3251188-4-dtalexundeer@yandex-team.ru>
In-Reply-To: <20251029093939.3251188-4-dtalexundeer@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 3 Nov 2025 13:55:22 -0500
X-Gm-Features: AWmQ_blYDrA44NcEm2cK6ssqMXmosJWDnJ4uwQbdP0ppF1aUVKEECezQN4AlV14
Message-ID: <CAFubqFtaQ__QDdnH=3b5yVo=J6Do_JwUYOf8ZiDJNRdeOkeNzg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] vhost-user-blk: support inter-host inflight
 migration
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Raphael Norwitz <raphael@enfabrica.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d31;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

A couple of comments but overall looks good to me.

On Wed, Oct 29, 2025 at 5:43=E2=80=AFAM Alexandr Moshkov
<dtalexundeer@yandex-team.ru> wrote:
>
> During inter-host migration, waiting for disk requests to be drained
> in the vhost-user backend can incur significant downtime.
>
> This can be avoided if QEMU migrates the inflight region in
> vhost-user-blk.
> Thus, during the qemu migration, the vhost-user backend can cancel all
> inflight requests and
> then, after migration, they will be executed on another host.
>
> In vhost_user_blk_stop() on incoming inter-host migration make force_stop=
 =3D true,
> so GET_VRING_BASE will not be executed.
>
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>  hw/block/vhost-user-blk.c          | 30 ++++++++++++++++++++++++++++++
>  include/hw/virtio/vhost-user-blk.h |  1 +
>  2 files changed, 31 insertions(+)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index a8fd90480a..29d4505d24 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -242,6 +242,12 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
>      force_stop =3D s->skip_get_vring_base_on_force_shutdown &&
>                   qemu_force_shutdown_requested();
>

Why not move the vhost_user_blk_inflight_needed() helper up here
instead and rather do:

if (vhost_user_blk_inflight_needed(s) &&
    runstate_check(RUN_STATE_FINISH_MIGRATE))

As is it looks like vhost_user_blk_inflight_needed() is unused.

> +    if (s->enable_inflight_region_migration &&
> +        !migrate_local_vhost_user_blk() &&
> +        runstate_check(RUN_STATE_FINISH_MIGRATE)) {
> +        force_stop =3D true;
> +    }
> +
>      s->dev.backend_transfer =3D s->dev.backend_transfer ||
>          (runstate_check(RUN_STATE_FINISH_MIGRATE) &&
>           migrate_local_vhost_user_blk());
> @@ -656,6 +662,24 @@ static struct vhost_dev *vhost_user_blk_get_vhost(Vi=
rtIODevice *vdev)
>      return &s->dev;
>  }
>
> +static bool vhost_user_blk_inflight_needed(void *opaque)
> +{
> +    struct VHostUserBlk *s =3D opaque;
> +
> +    return s->enable_inflight_region_migration &&
> +           !migrate_local_vhost_user_blk();
> +}
> +
> +static const VMStateDescription vmstate_vhost_user_blk_inflight =3D {
> +    .name =3D "vhost-user-blk/inflight",
> +    .version_id =3D 1,
> +    .needed =3D vhost_user_blk_inflight_needed,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_VHOST_INFLIGHT_REGION(inflight, VHostUserBlk),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static bool vhost_user_blk_pre_incoming(void *opaque, Error **errp)
>  {
>      VHostUserBlk *s =3D VHOST_USER_BLK(opaque);
> @@ -678,6 +702,10 @@ static const VMStateDescription vmstate_vhost_user_b=
lk =3D {
>          VMSTATE_VIRTIO_DEVICE,
>          VMSTATE_END_OF_LIST()
>      },
> +    .subsections =3D (const VMStateDescription * const []) {
> +        &vmstate_vhost_user_blk_inflight,
> +        NULL
> +    }
>  };
>
>  static bool vhost_user_needed(void *opaque)
> @@ -751,6 +779,8 @@ static const Property vhost_user_blk_properties[] =3D=
 {
>                        VIRTIO_BLK_F_WRITE_ZEROES, true),
>      DEFINE_PROP_BOOL("skip-get-vring-base-on-force-shutdown", VHostUserB=
lk,
>                       skip_get_vring_base_on_force_shutdown, false),

I would prefer the name indicating that the goal of the parameter was
to skip the GET_VRING_BASE like
"skip-get-vring-base-on-force-shutdown".

Maybe rename it something like
"skip-get-vring-base-inflight-migration"/skip_get_viring_base_migrate_infli=
ght?

> +    DEFINE_PROP_BOOL("enable-inflight-migration", VHostUserBlk,
> +                     enable_inflight_region_migration, false),
>  };
>
>  static void vhost_user_blk_class_init(ObjectClass *klass, const void *da=
ta)
> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost=
-user-blk.h
> index b06f55fd6f..1556714296 100644
> --- a/include/hw/virtio/vhost-user-blk.h
> +++ b/include/hw/virtio/vhost-user-blk.h
> @@ -52,6 +52,7 @@ struct VHostUserBlk {
>      bool started_vu;
>
>      bool skip_get_vring_base_on_force_shutdown;
> +    bool enable_inflight_region_migration;
>
>      bool incoming_backend;
>  };
> --
> 2.34.1
>
>

