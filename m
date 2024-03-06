Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A59C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 17:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhv4N-0007iw-HU; Wed, 06 Mar 2024 12:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rhv4K-0007gi-P2
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:28:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rhv4J-0004yQ-78
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709746117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wVm8nopxhdTnNxV+C/CxgiL7Ajx4dWRfRy27MeCc6HQ=;
 b=Q1R5DViiI3qTwp+rrHnCCSb1wrrLG3wLQ4VeI9dHkHnmlpHMW3IyUtW5NAo2mO6cfNfo1l
 /V06NIroDK3QJDp10ssasmH3w8bUf+A9mXD60iguSr+kVGmYh9IRjHX00HnSwkOxuw8U0K
 AAmL4gW7hr5dmKdtb5qi9pN79jdbwLw=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-s0L7WuszMX2voAGcnjfqRQ-1; Wed, 06 Mar 2024 12:28:36 -0500
X-MC-Unique: s0L7WuszMX2voAGcnjfqRQ-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-dc693399655so13164584276.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 09:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709746116; x=1710350916;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVm8nopxhdTnNxV+C/CxgiL7Ajx4dWRfRy27MeCc6HQ=;
 b=blijCa4Edn2/FcqZ1vJAhFo8NcJKclttdkXKslYksBWAfFtedsFphovj6wRhRPCmAW
 cciMj4Pf7aW6ikk3fD8aM+CanfEcg9uv2VYJ/u2DEoS5vToHLveE5bqvV1xMGfTsm8sW
 s/cNd4YEKaBccyEEhS0ByIYcadcvg5CqiMLOaKRPhQb9dejjqwOp+2aQoskGmPtVT6lV
 gXenAxUI6n1/eaHY7GUgfI5udHbviHn9vUT5n1Ptl6OREYBKHS4Z0AECFcW8X4sRLmBT
 SoQr03ZN3DNeuigLfQKF6USjlazydQ2dqfBdpAogEdGO7TCBeifffC0ZEpblazpwDbOd
 tPPw==
X-Gm-Message-State: AOJu0YwHbb5HcsRjryZ6oTSNJXMhxJrU06sXvnQ9doaPbGuP5txWF94K
 AIjWCtXXN1FqP+PYHIaGGNuDCJkMnkA/0jbVdIvriwPcQE49sZZJZEM2Q1GQAPR8/A325CUhhdZ
 imoFf++weiQFSuOFpckCrlQ5yg2UouKCZNcQZXK1xglOuiQwKE5z8BWrzbDNWsx6QsZ/Q+taGud
 p84v3XDzKL+vaUiHW0vDAmOd2N56A=
X-Received: by 2002:a25:c546:0:b0:dc6:ff66:87a8 with SMTP id
 v67-20020a25c546000000b00dc6ff6687a8mr12041330ybe.51.1709746116113; 
 Wed, 06 Mar 2024 09:28:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYuMtoaDSNe4eC4y86ctGMazVJdja/luVm7OBljWJX901XH0rGCP62zwMGS6fIiO/887UWwYJZ96dZ93OyEDE=
X-Received: by 2002:a25:c546:0:b0:dc6:ff66:87a8 with SMTP id
 v67-20020a25c546000000b00dc6ff6687a8mr12041305ybe.51.1709746115780; Wed, 06
 Mar 2024 09:28:35 -0800 (PST)
MIME-Version: 1.0
References: <1707911419-11758-1-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1707911419-11758-1-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 6 Mar 2024 18:27:59 +0100
Message-ID: <CAJaqyWcrSFszNH6kG2m8qBg-CzKeQfshVCAC9=9s6+3MSiFR7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vhost: dirty log should be per backend type
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com, 
 joao.m.martins@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Feb 14, 2024 at 2:01=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> There could be a mix of both vhost-user and vhost-kernel clients
> in the same QEMU process, where separate vhost loggers for the
> specific vhost type have to be used. Make the vhost logger per
> backend type, and have them properly reference counted.
>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

It seems to me you missed the cover letter and sent 01/02 as the first mess=
age?

> ---
>  hw/virtio/vhost.c | 49 +++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 12 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 2c9ac79..ef6d9b5 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -43,8 +43,8 @@
>      do { } while (0)
>  #endif
>
> -static struct vhost_log *vhost_log;
> -static struct vhost_log *vhost_log_shm;
> +static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
> +static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
>
>  /* Memslots used by backends that support private memslots (without an f=
d). */
>  static unsigned int used_memslots;
> @@ -287,6 +287,8 @@ static int vhost_set_backend_type(struct vhost_dev *d=
ev,
>          r =3D -1;
>      }
>
> +    assert(dev->vhost_ops->backend_type =3D=3D backend_type || r < 0);

Is this a debug leftover (at least the r<0)? This should never be
reached effectively, but then it does not make sense to leave the
default switch branch.

> +
>      return r;
>  }
>
> @@ -319,16 +321,23 @@ static struct vhost_log *vhost_log_alloc(uint64_t s=
ize, bool share)
>      return log;
>  }
>
> -static struct vhost_log *vhost_log_get(uint64_t size, bool share)
> +static struct vhost_log *vhost_log_get(VhostBackendType backend_type,
> +                                       uint64_t size, bool share)
>  {
> -    struct vhost_log *log =3D share ? vhost_log_shm : vhost_log;
> +    struct vhost_log *log;
> +
> +    if (backend_type =3D=3D VHOST_BACKEND_TYPE_NONE ||
> +        backend_type >=3D VHOST_BACKEND_TYPE_MAX)
> +        return NULL;

The callers (vhost_log_resize, etc) don't expect vhost_log_get to
return NULL. I think all of these should be an assertion, if any.

The rest looks good to me.

> +
> +    log =3D share ? vhost_log_shm[backend_type] : vhost_log[backend_type=
];
>
>      if (!log || log->size !=3D size) {
>          log =3D vhost_log_alloc(size, share);
>          if (share) {
> -            vhost_log_shm =3D log;
> +            vhost_log_shm[backend_type] =3D log;
>          } else {
> -            vhost_log =3D log;
> +            vhost_log[backend_type] =3D log;
>          }
>      } else {
>          ++log->refcnt;
> @@ -340,11 +349,20 @@ static struct vhost_log *vhost_log_get(uint64_t siz=
e, bool share)
>  static void vhost_log_put(struct vhost_dev *dev, bool sync)
>  {
>      struct vhost_log *log =3D dev->log;
> +    VhostBackendType backend_type;
>
>      if (!log) {
>          return;
>      }
>
> +    assert(dev->vhost_ops);
> +    backend_type =3D dev->vhost_ops->backend_type;
> +
> +    if (backend_type =3D=3D VHOST_BACKEND_TYPE_NONE ||
> +        backend_type >=3D VHOST_BACKEND_TYPE_MAX) {
> +        return;
> +    }
> +
>      --log->refcnt;
>      if (log->refcnt =3D=3D 0) {
>          /* Sync only the range covered by the old log */
> @@ -352,13 +370,13 @@ static void vhost_log_put(struct vhost_dev *dev, bo=
ol sync)
>              vhost_log_sync_range(dev, 0, dev->log_size * VHOST_LOG_CHUNK=
 - 1);
>          }
>
> -        if (vhost_log =3D=3D log) {
> +        if (vhost_log[backend_type] =3D=3D log) {
>              g_free(log->log);
> -            vhost_log =3D NULL;
> -        } else if (vhost_log_shm =3D=3D log) {
> +            vhost_log[backend_type] =3D NULL;
> +        } else if (vhost_log_shm[backend_type] =3D=3D log) {
>              qemu_memfd_free(log->log, log->size * sizeof(*(log->log)),
>                              log->fd);
> -            vhost_log_shm =3D NULL;
> +            vhost_log_shm[backend_type] =3D NULL;
>          }
>
>          g_free(log);
> @@ -376,7 +394,8 @@ static bool vhost_dev_log_is_shared(struct vhost_dev =
*dev)
>
>  static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t =
size)
>  {
> -    struct vhost_log *log =3D vhost_log_get(size, vhost_dev_log_is_share=
d(dev));
> +    struct vhost_log *log =3D vhost_log_get(dev->vhost_ops->backend_type=
,
> +                                          size, vhost_dev_log_is_shared(=
dev));
>      uint64_t log_base =3D (uintptr_t)log->log;
>      int r;
>
> @@ -2037,8 +2056,14 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIO=
Device *vdev, bool vrings)
>          uint64_t log_base;
>
>          hdev->log_size =3D vhost_get_log_size(hdev);
> -        hdev->log =3D vhost_log_get(hdev->log_size,
> +        hdev->log =3D vhost_log_get(hdev->vhost_ops->backend_type,
> +                                  hdev->log_size,
>                                    vhost_dev_log_is_shared(hdev));
> +        if (!hdev->log) {
> +            VHOST_OPS_DEBUG(r, "vhost_log_get failed");
> +            goto fail_vq;
> +        }
> +
>          log_base =3D (uintptr_t)hdev->log->log;
>          r =3D hdev->vhost_ops->vhost_set_log_base(hdev,
>                                                  hdev->log_size ? log_bas=
e : 0,
> --
> 1.8.3.1
>
>


