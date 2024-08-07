Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBF3C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 16:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbjRE-0001pv-SD; Wed, 07 Aug 2024 12:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sbjR9-0001pK-Ps
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 12:22:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sbjR7-0003Ds-CB
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 12:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723047769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AaygM5Uoxj13X85xyiQDAoqmMShfp4qb1jwUQHKH8Wg=;
 b=bKtzSooKq/rxpLvy3raIoVTTgGV7pEpURrxkBD4asfT8HZ6OssdCfNFlNw1Mc5VQ/hWvdJ
 BGQ5rm5ijxXSckm8lYT12bq4EjtAaH+ms2Kua7/aRx3ecJXgHoNFnrh0U6BfGEwcxQslPS
 IV1SrPI96EEZgPaX6tjjgofHTUWfeZ4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-ZO8QN9eGPMujGeedDu37nw-1; Wed, 07 Aug 2024 12:22:47 -0400
X-MC-Unique: ZO8QN9eGPMujGeedDu37nw-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7094845f368so2385436a34.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 09:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723047766; x=1723652566;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AaygM5Uoxj13X85xyiQDAoqmMShfp4qb1jwUQHKH8Wg=;
 b=L+F7VwpmGo5oGX4rzjpPbK+Mqyuj65A/jNn0o8JdbQc3b1CvhZzdMOZZt882yrpiqJ
 OfFd0TIfbVGGgGLYrEXLhTWMUOmb/Z4hZhf1LeAy+3iSdbtJvUJ09WF4kdO/9xiWs9p0
 aylPTNyt/7VrUn/BDA95I3IueJE908QWnvY3pZnEOxHxwTY5YHstwVvrmmsHUagu4Bwm
 ng2tzJiqDvCmywIn0D5HYRv9IPUt7utHmKhIw234004lQPnBEsSPp2M/trO0RnCHO59p
 NJGCACamUwHhD2Mt4D3m+RjW9sb2R9td63iplBtuTUBf5Do5TMg53C+dq3rgSutrGH9a
 Nvbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvjsl354b/YfTPgJMl7IlvyIpSSUYpnSiHsdOrZSlI1cUHXqOyow9XG3inA+vhgpvRQV93O/9O/k/pH2yytvnC4GX0Jrc=
X-Gm-Message-State: AOJu0Ywy6lrU2S/Es1Xvx0V4cwHCMQjqBvwiLvVvpKIe72qRU1CM/pLR
 OxWhmkCpTqSaIViaEATxhHgcspx8cJXvpkwuZKu17NyTqtdwQaRe3qCh2I/bYnmMeWVU1zKv1tx
 qV8OoaOy0G8G69UvggDon7L5+XsL9OQ8o1chVfnSIc9f/sCNy5J06K/Qc7cvf2T7OGCdD5UjWqE
 j0sCsAT/yU1Ge8P+/yokWZE7tTYMI=
X-Received: by 2002:a05:6830:730d:b0:709:4c0d:9e78 with SMTP id
 46e09a7af769-709b996562bmr24216947a34.21.1723047766490; 
 Wed, 07 Aug 2024 09:22:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZjMzkgAUT4K+bUwT11o0B8dYPvP55E0QVzk2Hx6ifCWyR70wnHDHEOWz67k61/klqyxf/AXvWstR9uR7kyDA=
X-Received: by 2002:a05:6830:730d:b0:709:4c0d:9e78 with SMTP id
 46e09a7af769-709b996562bmr24216918a34.21.1723047766125; Wed, 07 Aug 2024
 09:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <20240802112138.46831-4-sahilcdq@proton.me>
In-Reply-To: <20240802112138.46831-4-sahilcdq@proton.me>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 7 Aug 2024 18:22:10 +0200
Message-ID: <CAJaqyWcrcEJimGqF3_K7YWCobPw00Yx+rcYQH1JXGcKesb5M2w@mail.gmail.com>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 2, 2024 at 1:22=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.com>=
 wrote:
>
> Allocate memory for the packed vq format and support
> packed vq in the SVQ "start" and "stop" operations.
>
> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> ---
> Changes v2 -> v3:
> * vhost-shadow-virtqueue.c
>   (vhost_svq_memory_packed): New function
>   (vhost_svq_start):
>   - Remove common variables out of if-else branch.
>   (vhost_svq_stop):
>   - Add support for packed vq.
>   (vhost_svq_get_vring_addr): Revert changes
>   (vhost_svq_get_vring_addr_packed): Likwise.
> * vhost-shadow-virtqueue.h
>   - Revert changes made to "vhost_svq_get_vring_addr*"
>     functions.
> * vhost-vdpa.c: Revert changes.
>
>  hw/virtio/vhost-shadow-virtqueue.c | 56 +++++++++++++++++++++++-------
>  hw/virtio/vhost-shadow-virtqueue.h |  4 +++
>  2 files changed, 47 insertions(+), 13 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index 4c308ee53d..f4285db2b4 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -645,6 +645,8 @@ void vhost_svq_set_svq_call_fd(VhostShadowVirtqueue *=
svq, int call_fd)
>
>  /**
>   * Get the shadow vq vring address.
> + * This is used irrespective of whether the
> + * split or packed vq format is used.
>   * @svq: Shadow virtqueue
>   * @addr: Destination to store address
>   */
> @@ -672,6 +674,16 @@ size_t vhost_svq_device_area_size(const VhostShadowV=
irtqueue *svq)
>      return ROUND_UP(used_size, qemu_real_host_page_size());
>  }
>
> +size_t vhost_svq_memory_packed(const VhostShadowVirtqueue *svq)
> +{
> +    size_t desc_size =3D sizeof(struct vring_packed_desc) * svq->num_fre=
e;
> +    size_t driver_event_suppression =3D sizeof(struct vring_packed_desc_=
event);
> +    size_t device_event_suppression =3D sizeof(struct vring_packed_desc_=
event);
> +
> +    return ROUND_UP(desc_size + driver_event_suppression + device_event_=
suppression,
> +                    qemu_real_host_page_size());
> +}
> +
>  /**
>   * Set a new file descriptor for the guest to kick the SVQ and notify fo=
r avail
>   *
> @@ -726,17 +738,30 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, Vir=
tIODevice *vdev,
>
>      svq->vring.num =3D virtio_queue_get_num(vdev, virtio_get_queue_index=
(vq));
>      svq->num_free =3D svq->vring.num;
> -    svq->vring.desc =3D mmap(NULL, vhost_svq_driver_area_size(svq),
> -                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANON=
YMOUS,
> -                           -1, 0);
> -    desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> -    svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc_size);
> -    svq->vring.used =3D mmap(NULL, vhost_svq_device_area_size(svq),
> -                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANON=
YMOUS,
> -                           -1, 0);
> -    svq->desc_state =3D g_new0(SVQDescState, svq->vring.num);
> -    svq->desc_next =3D g_new0(uint16_t, svq->vring.num);
> -    for (unsigned i =3D 0; i < svq->vring.num - 1; i++) {
> +    svq->is_packed =3D virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_=
PACKED);
> +
> +    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)) {
> +        svq->vring_packed.vring.desc =3D mmap(NULL, vhost_svq_memory_pac=
ked(svq),
> +                                            PROT_READ | PROT_WRITE, MAP_=
SHARED | MAP_ANONYMOUS,
> +                                            -1, 0);
> +        desc_size =3D sizeof(struct vring_packed_desc) * svq->vring.num;
> +        svq->vring_packed.vring.driver =3D (void *)((char *)svq->vring_p=
acked.vring.desc + desc_size);
> +        svq->vring_packed.vring.device =3D (void *)((char *)svq->vring_p=
acked.vring.driver +
> +                                                  sizeof(struct vring_pa=
cked_desc_event));

This is a great start but it will be problematic when you start
mapping the areas to the vdpa device. The driver area should be read
only for the device, but it is placed in the same page as a RW one.

More on this later.

> +    } else {
> +        svq->vring.desc =3D mmap(NULL, vhost_svq_driver_area_size(svq),
> +                               PROT_READ | PROT_WRITE, MAP_SHARED | MAP_=
ANONYMOUS,
> +                               -1, 0);
> +        desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> +        svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc_siz=
e);
> +        svq->vring.used =3D mmap(NULL, vhost_svq_device_area_size(svq),
> +                               PROT_READ | PROT_WRITE, MAP_SHARED | MAP_=
ANONYMOUS,
> +                               -1, 0);
> +    }

I think it will be beneficial to avoid "if (packed)" conditionals on
the exposed functions that give information about the memory maps.
These need to be replicated at
hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_map_rings.

However, the current one depends on the driver area to live in the
same page as the descriptor area, so it is not suitable for this.

So what about this action plan:
1) Make the avail ring (or driver area) independent of the descriptor ring.
2) Return the mapping permissions of the descriptor area (not needed
here, but needed for hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_map_rings

> +
> +    svq->desc_state =3D g_new0(SVQDescState, svq->num_free);
> +    svq->desc_next =3D g_new0(uint16_t, svq->num_free);
> +    for (unsigned i =3D 0; i < svq->num_free - 1; i++) {
>          svq->desc_next[i] =3D cpu_to_le16(i + 1);
>      }
>  }
> @@ -776,8 +801,13 @@ void vhost_svq_stop(VhostShadowVirtqueue *svq)
>      svq->vq =3D NULL;
>      g_free(svq->desc_next);
>      g_free(svq->desc_state);
> -    munmap(svq->vring.desc, vhost_svq_driver_area_size(svq));
> -    munmap(svq->vring.used, vhost_svq_device_area_size(svq));
> +
> +    if (svq->is_packed) {
> +        munmap(svq->vring_packed.vring.desc, vhost_svq_memory_packed(svq=
));
> +    } else {
> +        munmap(svq->vring.desc, vhost_svq_driver_area_size(svq));
> +        munmap(svq->vring.used, vhost_svq_device_area_size(svq));
> +    }
>      event_notifier_set_handler(&svq->hdev_call, NULL);
>  }
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-=
virtqueue.h
> index ee1a87f523..03b722a186 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.h
> +++ b/hw/virtio/vhost-shadow-virtqueue.h
> @@ -67,6 +67,9 @@ struct vring_packed {
>
>  /* Shadow virtqueue to relay notifications */
>  typedef struct VhostShadowVirtqueue {
> +    /* True if packed virtqueue */
> +    bool is_packed;
> +
>      /* Virtio queue shadowing */
>      VirtQueue *vq;
>
> @@ -150,6 +153,7 @@ void vhost_svq_get_vring_addr(const VhostShadowVirtqu=
eue *svq,
>                                struct vhost_vring_addr *addr);
>  size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq);
>  size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq);
> +size_t vhost_svq_memory_packed(const VhostShadowVirtqueue *svq);
>
>  void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
>                       VirtQueue *vq, VhostIOVATree *iova_tree);
> --
> 2.45.2
>


