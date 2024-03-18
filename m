Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D2CC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 04:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm4nG-0004kA-Jv; Mon, 18 Mar 2024 00:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rm4f3-0002sd-Q2
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 00:31:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rm4f0-0002RN-7K
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 00:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710736300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MJ6rnTuF7cy4Nf8EfQsh/hvL0SBtN+7It4/7veD6eZ8=;
 b=WWv3FPvQVnhLy+8/Areu7bMeKuLTsbMH1fG5Sv2pkIHgAKu3DxN8kRRdNBacSf2dqjKr4R
 B2SzXZNXf1Jlwpo+MDOf/IEYh59x9RNIiG5M4SASp+xhczJiLba1aZOf4lVrUVFCm1xIMf
 zMv+xkGOpDtEoAmDD/4PyAhku0ihv3U=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-o59JAoZHOMyMkLLPv_SCiw-1; Mon, 18 Mar 2024 00:31:38 -0400
X-MC-Unique: o59JAoZHOMyMkLLPv_SCiw-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-29bad31f920so3486876a91.0
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 21:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710736297; x=1711341097;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MJ6rnTuF7cy4Nf8EfQsh/hvL0SBtN+7It4/7veD6eZ8=;
 b=jLgE7xzkj+uDn/j6nkVpx5MDf1JX4Jj82Xc0VuNb25LSHMzN3T1YXb/VhWXCfRwfgs
 9l3gqBGzBACR/bRRSguQWrsfEG1ajtuO7S5TIJatigCjTIeDoZ7DfcZIvnmeIjWeM+RK
 6YJhRfTikEAob65nLNxWAhJ5bZw0aAwet66zg0SmlRQjWgJK0I/UfL7oqplsIrKdLyCA
 viNKxIEpPU9yXVIEA5tHdRsierTOoNa/VkhnWTbtHn4TAllR6qqmUAwIT3uHgrrNoTbD
 FcIgAlmz7x3IPCsAFf6WSKF6A54Ko38J1ZiK+95rboanYogRFgwn3Uh99x2BaaNC/ncP
 jvEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZCNS+vtx6LQYks2cpSWIJCph9w0l9iF5NwIgnHdIqJIlgUe9IRqxirhiqsuMqTgBeBnBGzL843KhJR3HakAwCLwTBJGk=
X-Gm-Message-State: AOJu0YwiF/xORxo1u4AmsmxvECOOlwgk5lbTfGf0Oazq0PqxJDQ0o1Pb
 r/6yU2jss7crV3ThzOvj0cnT0VvL5aiH30sp116FzbEXGfCtXfOYyFNsxqbc86ySnsVUJOpU5pg
 Hq6X7EwTU+YhGHNrNmRI5jTiZqagKV1RaG2RY3S0YlvgZ3yOk5+eciIBtQiIgLpRkLqSY7zmstX
 nogC8GJdOk1lg6n7Qm1YV08ODB1sE=
X-Received: by 2002:a17:90b:387:b0:29b:b736:71b8 with SMTP id
 ga7-20020a17090b038700b0029bb73671b8mr6581987pjb.28.1710736297791; 
 Sun, 17 Mar 2024 21:31:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRmRkICco+yLD8VITY+XCJg+zA9jGMEJAmrO3q/rwp/tjg+6zpPKiffUOSY0N4M9NdmKcivlXZob6mtec1GEM=
X-Received: by 2002:a17:90b:387:b0:29b:b736:71b8 with SMTP id
 ga7-20020a17090b038700b0029bb73671b8mr6581973pjb.28.1710736297460; Sun, 17
 Mar 2024 21:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240315155949.86066-1-kwolf@redhat.com>
In-Reply-To: <20240315155949.86066-1-kwolf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Mar 2024 12:31:26 +0800
Message-ID: <CACGkMEvuu4rkgZr7sBFwXztZLHdamBKML++6cvA+GDKyGDGibA@mail.gmail.com>
Subject: Re: [PATCH for-9.0 v3] vdpa-dev: Fix initialisation order to restore
 VDUSE compatibility
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mst@redhat.com, sgarzare@redhat.com, 
 eperezma@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Mar 15, 2024 at 11:59=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrot=
e:
>
> VDUSE requires that virtqueues are first enabled before the DRIVER_OK
> status flag is set; with the current API of the kernel module, it is
> impossible to enable the opposite order in our block export code because
> userspace is not notified when a virtqueue is enabled.
>
> This requirement also mathces the normal initialisation order as done by
> the generic vhost code in QEMU. However, commit 6c482547 accidentally
> changed the order for vdpa-dev and broke access to VDUSE devices with
> this.
>
> This changes vdpa-dev to use the normal order again and use the standard
> vhost callback .vhost_set_vring_enable for this. VDUSE devices can be
> used with vdpa-dev again after this fix.
>
> vhost_net intentionally avoided enabling the vrings for vdpa and does
> this manually later while it does enable them for other vhost backends.
> Reflect this in the vhost_net code and return early for vdpa, so that
> the behaviour doesn't change for this device.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 6c4825476a4351530bcac17abab72295b75ffe98
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
> v2:
> - Actually make use of the @enable parameter
> - Change vhost_net to preserve the current behaviour
>
> v3:
> - Updated trace point [Stefano]
> - Fixed typo in comment [Stefano]
>
>  hw/net/vhost_net.c     | 10 ++++++++++
>  hw/virtio/vdpa-dev.c   |  5 +----
>  hw/virtio/vhost-vdpa.c | 29 ++++++++++++++++++++++++++---
>  hw/virtio/vhost.c      |  8 +++++++-
>  hw/virtio/trace-events |  2 +-
>  5 files changed, 45 insertions(+), 9 deletions(-)
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index e8e1661646..fd1a93701a 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -541,6 +541,16 @@ int vhost_set_vring_enable(NetClientState *nc, int e=
nable)
>      VHostNetState *net =3D get_vhost_net(nc);
>      const VhostOps *vhost_ops =3D net->dev.vhost_ops;
>
> +    /*
> +     * vhost-vdpa network devices need to enable dataplane virtqueues af=
ter
> +     * DRIVER_OK, so they can recover device state before starting datap=
lane.
> +     * Because of that, we don't enable virtqueues here and leave it to
> +     * net/vhost-vdpa.c.
> +     */
> +    if (nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA) {
> +        return 0;
> +    }

I think we need some inputs from Eugenio, this is only needed for
shadow virtqueue during live migration but not other cases.

Thanks


