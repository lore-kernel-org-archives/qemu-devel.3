Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F2CC5472D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 01:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1silA1-0006tf-QD; Mon, 26 Aug 2024 21:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1silA0-0006sW-1B
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 21:38:16 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1sil9x-00008h-Uw
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 21:38:15 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6b747f2e2b7so46677417b3.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 18:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724722692; x=1725327492; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGk6kZfPln2wYPOemFman7XR12dZ07gdxuqIUtmDwA0=;
 b=HbeK6GtjW96W6bzqO35AnxBZcNeF0ItVL5BwhuTjYUR9hyuC8pdNEJZCHLlQkeT5Em
 GPG7CNyBUA+ZXq4K52hfjSj600cN9OAIHKh6frFTvrKNj28zI6OpPucnXuqDtX5dFRT3
 pWzddyYsGngYAA2D9+SZFDAvjT1A4c4dmyOf/D3aAn4cd79bwp04QKYYGB9U1qwmQj/W
 D1S44Lu14K+j9SBIKburVNTHEF7uz6ftRxd2Fk1YdIGHuD/gQTBjvMD6F2az0hAv53CX
 msWbagKHE2Io4KKlrlJnMVK/hc7tky9wPmpIa/MIqYKtkJWHPK//BvfNNNo9KMczQ06f
 RPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724722692; x=1725327492;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GGk6kZfPln2wYPOemFman7XR12dZ07gdxuqIUtmDwA0=;
 b=A1WWU8g0UqQEvdrhnOaA12eJyI/NIg4PEFXJQxgz/H2ctwjwNDar0Gt95USNCJYmDE
 TUV7PzwCuCvrMkQfA+KvkBgGtElMkPzglPT1lM1/eRUgzTLfvHJIiQQFEBIcs69U6csd
 q1HMNekconJRZ3EV1Y6MopwK+c2ZH1aKL7S+FS/WSvZ8hOLVP1Bn2WM967Sxy7jS1iMM
 I27Vyd/jvC6UX7eCOIBhxLeIuxHw/r+UiEGgMfP0eLNFqqCthE4ymsloWVlN521eHhuy
 ykiXMlinxQ2Kv6LiMSfK+aaKX1V3YSK16M+nYS5qzxpHFKazj+413v4VN13WbsjKvzsj
 AVIw==
X-Gm-Message-State: AOJu0YwYhUJJfib9U9RRVsqsbL17D4MHFrss2F3XehKT6+SJuaOM/46H
 lMmbwP4GvuerXJZYMfBn5EX3ZXZh9PFKusFfY35X2m4FJFZsqdkeUiQlOKpGkof9w3PnXzNUyTS
 I1aGiBVDH/LPm+lN6mJnmYJ7fkDqksQ==
X-Google-Smtp-Source: AGHT+IEk4zC7NoGx2Mdz1kN9gG1Rh2pvx9n23ts8K5fEpzyzdT1uVLwNTPyH+z0RFzdvyypSTZX78AKasqHvf79waUY=
X-Received: by 2002:a05:690c:3391:b0:6b9:ae40:4266 with SMTP id
 00721157ae682-6c625f1eac5mr153150987b3.24.1724722692369; Mon, 26 Aug 2024
 18:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240807095508.54750-1-yaozhenguo@jd.com>
In-Reply-To: <20240807095508.54750-1-yaozhenguo@jd.com>
From: Zhenguo Yao <yaozhenguo1@gmail.com>
Date: Tue, 27 Aug 2024 09:37:58 +0800
Message-ID: <CA+WzAR=rUVLifA6hJUUf+W+qMC7m=WH3Vsnd9tz51QHUpEOCqg@mail.gmail.com>
Subject: Re: [PATCH] virtio/vhost-user: fix qemu crash when hotunplug
 vhost-user-net device
To: alex.bennee@linaro.org, mst@redhat.com, sgarzare@redhat.com
Cc: qemu-devel@nongnu.org, yaozhenguo@jd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=yaozhenguo1@gmail.com; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Alex=EF=BC=9A
     Any update=EF=BC=9F

yaozhenguo <yaozhenguo1@gmail.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=887=E6=97=
=A5=E5=91=A8=E4=B8=89 17:55=E5=86=99=E9=81=93=EF=BC=9A
>
> When hotplug and hotunplug vhost-user-net device quickly.
> qemu will crash. BT is as below:
>
> 0  __pthread_kill_implementation () at /usr/lib64/libc.so.6
> 1  raise () at /usr/lib64/libc.so.6
> 2  abort () at /usr/lib64/libc.so.6
> 3  try_dequeue () at ../util/rcu.c:235
> 4  call_rcu_thread (opaque=3Dopaque@entry=3D0x0) at ../util/rcu.c:288
> 5  qemu_thread_start (args=3D0x55b10d9ceaa0) at ../util/qemu-thread-posix=
.c:541
> 6  start_thread () at /usr/lib64/libc.so.6
> 7  clone3 () at /usr/lib64/libc.so.6
>
> 1. device_del qmp process
>
> virtio_set_status
>   vhost_dev_stop
>     vhost_user_get_vring_base
>       vhost_user_host_notifier_remove
>
> vhost_user_slave_handle_vring_host_notifier maybe called asynchronous aft=
er
> vhost_user_host_notifier_remove. vhost_user_host_notifier_remove will not
> all call_rcu because of notifier->addr is NULL at this time.
>
> 2. netdev_del qmp process
>
> vhost_user_cleanup
>        vhost_user_host_notifier_remove
>        g_free_rcu
>
> vhost_user_host_notifier_remove and g_free_rcu will sumbit same rcu_head
> to rcu node list. rcu_call_count add twice but only one node is added.
> rcu thread will abort when calling try_dequeue with node list is empty.
> Fix this by moving g_free(n) to vhost_user_host_notifier_free.
>
> Fixes: 503e355465 ("virtio/vhost-user: dynamically assign VhostUserHostNo=
tifiers")
> Signed-off-by: yaozhenguo <yaozhenguo@jd.com>
> ---
>  hw/virtio/vhost-user.c         | 23 +++++++++++------------
>  include/hw/virtio/vhost-user.h |  1 +
>  2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 00561daa06..7ab37c0da2 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1188,6 +1188,12 @@ static void vhost_user_host_notifier_free(VhostUse=
rHostNotifier *n)
>      assert(n && n->unmap_addr);
>      munmap(n->unmap_addr, qemu_real_host_page_size());
>      n->unmap_addr =3D NULL;
> +    if (n->need_free) {
> +        memory_region_transaction_begin();
> +        object_unparent(OBJECT(&n->mr));
> +        memory_region_transaction_commit();
> +        g_free(n);
> +    }
>  }
>
>  /*
> @@ -1195,7 +1201,7 @@ static void vhost_user_host_notifier_free(VhostUser=
HostNotifier *n)
>   * under rcu.
>   */
>  static void vhost_user_host_notifier_remove(VhostUserHostNotifier *n,
> -                                            VirtIODevice *vdev)
> +                                            VirtIODevice *vdev, bool fre=
e)
>  {
>      if (n->addr) {
>          if (vdev) {
> @@ -1204,6 +1210,7 @@ static void vhost_user_host_notifier_remove(VhostUs=
erHostNotifier *n,
>          assert(!n->unmap_addr);
>          n->unmap_addr =3D n->addr;
>          n->addr =3D NULL;
> +        n->need_free =3D free;
>          call_rcu(n, vhost_user_host_notifier_free, rcu);
>      }
>  }
> @@ -1280,7 +1287,7 @@ static int vhost_user_get_vring_base(struct vhost_d=
ev *dev,
>
>      VhostUserHostNotifier *n =3D fetch_notifier(u->user, ring->index);
>      if (n) {
> -        vhost_user_host_notifier_remove(n, dev->vdev);
> +        vhost_user_host_notifier_remove(n, dev->vdev, false);
>      }
>
>      ret =3D vhost_user_write(dev, &msg, NULL, 0);
> @@ -1562,7 +1569,7 @@ static int vhost_user_backend_handle_vring_host_not=
ifier(struct vhost_dev *dev,
>       * new mapped address.
>       */
>      n =3D fetch_or_create_notifier(user, queue_idx);
> -    vhost_user_host_notifier_remove(n, vdev);
> +    vhost_user_host_notifier_remove(n, vdev, false);
>
>      if (area->u64 & VHOST_USER_VRING_NOFD_MASK) {
>          return 0;
> @@ -2737,13 +2744,7 @@ static void vhost_user_state_destroy(gpointer data=
)
>  {
>      VhostUserHostNotifier *n =3D (VhostUserHostNotifier *) data;
>      if (n) {
> -        vhost_user_host_notifier_remove(n, NULL);
> -        object_unparent(OBJECT(&n->mr));
> -        /*
> -         * We can't free until vhost_user_host_notifier_remove has
> -         * done it's thing so schedule the free with RCU.
> -         */
> -        g_free_rcu(n, rcu);
> +        vhost_user_host_notifier_remove(n, NULL, true);
>      }
>  }
>
> @@ -2765,9 +2766,7 @@ void vhost_user_cleanup(VhostUserState *user)
>      if (!user->chr) {
>          return;
>      }
> -    memory_region_transaction_begin();
>      user->notifiers =3D (GPtrArray *) g_ptr_array_free(user->notifiers, =
true);
> -    memory_region_transaction_commit();
>      user->chr =3D NULL;
>  }
>
> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-use=
r.h
> index 324cd8663a..a171f29e0b 100644
> --- a/include/hw/virtio/vhost-user.h
> +++ b/include/hw/virtio/vhost-user.h
> @@ -54,6 +54,7 @@ typedef struct VhostUserHostNotifier {
>      void *addr;
>      void *unmap_addr;
>      int idx;
> +    bool need_free;
>  } VhostUserHostNotifier;
>
>  /**
> --
> 2.43.0
>

