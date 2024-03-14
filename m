Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735B1C54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 15:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkmyP-0003RM-L9; Thu, 14 Mar 2024 11:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rkmyL-0003BG-Mt
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:26:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rkmyK-0004Os-29
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710429979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fRE1P/M3jWl/htBNlcJP1L9luoTOn5Ka/72mLB9XNsQ=;
 b=VKIN1KowZBuJuL8QTqRo4sRKalL0YQzMrcZdL40jSQ7/+7wrYBQfWpyirjqfUVBDqBwBfP
 rGLkuq2Cn3Nt5SrJV6nsOXO0k1NwJhxUpWt1XabMexwjadj1wJo514tlMxAT+cOJzzqqfK
 2Pr3HmXDyIB7johrCFieAD0y4tRGRNU=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-8n_lGdekMyWbvmV7PCnUoA-1; Thu, 14 Mar 2024 11:26:17 -0400
X-MC-Unique: 8n_lGdekMyWbvmV7PCnUoA-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dc64e0fc7c8so1386726276.2
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 08:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710429977; x=1711034777;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fRE1P/M3jWl/htBNlcJP1L9luoTOn5Ka/72mLB9XNsQ=;
 b=USxnMiETbKaLVcyRbLkuwOSv9SmsSQoJoqZ7o4QKCvR8JOWopWxsht42BI2JVkp9ZZ
 f/2HPQ3buO3HWa6uMhg8sy0oXnlSyEEVLXLI546TTbEDPqqU+0DTpfuI7gM4SCFDxfBN
 1uPZicCUXGAylN4bqPBzk2uVcWtXp04iVqvTXW+jhNJcXmcO2jpweZV5TWaXax8bycki
 N7O93zvXOOnB115lYpweZpcwfWvM0g8OGTAcYQH6BQGjUkRy8qRUEzTXXFrhNRijgC1K
 vjasBMY1yPnoPcFpyxZE28VsdtMBCIFmhVXh+J88J50Rt/NYzwY2geZIBxt8PHI7pE15
 eN2g==
X-Gm-Message-State: AOJu0YzuwSgozTxpqD5SLfh6l/UNe6FmioiELkCeyN24S5oii3Gc7Hph
 cdTtUu9fXqRuCGXKFRDmz0qHzPgc93hhK7Gv5/LRYRCqDNc3llpqnC0lsbsn1RXknA8Mc8+BuZC
 J0fKX2GroqdXBaZjU3Rdm5VH//haBiHUzd4GLpt7VM3ZcoNfcroGJ0p+kB4ifrTLU6oDDwUEfTu
 X3cbeQ5zoyPbHBqdK10wjQt3MiYkg=
X-Received: by 2002:a5b:ed2:0:b0:dcc:4cdc:e98f with SMTP id
 a18-20020a5b0ed2000000b00dcc4cdce98fmr1915911ybs.34.1710429976007; 
 Thu, 14 Mar 2024 08:26:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiSjXfopJcVb7KszWzfT6Lc4Mg8jQM9/i5tubzgq5R/5bpJNZx6XdERH7G7l9j8J8y+eWE8FSuwMshBGK0O/w=
X-Received: by 2002:a5b:ed2:0:b0:dcc:4cdc:e98f with SMTP id
 a18-20020a5b0ed2000000b00dcc4cdce98fmr1915862ybs.34.1710429974225; Thu, 14
 Mar 2024 08:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <1710401215-25490-1-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1710401215-25490-1-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 14 Mar 2024 16:25:38 +0100
Message-ID: <CAJaqyWfq7tSo-o4oqh=VMD26MKneGtOGsC6CMtaYe4C4Tc2CoA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] vhost: dirty log should be per backend type
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com, 
 joao.m.martins@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Mar 14, 2024 at 9:38=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> There could be a mix of both vhost-user and vhost-kernel clients
> in the same QEMU process, where separate vhost loggers for the
> specific vhost type have to be used. Make the vhost logger per
> backend type, and have them properly reference counted.
>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
> v2->v3:
>   - remove non-effective assertion that never be reached
>   - do not return NULL from vhost_log_get()
>   - add neccessary assertions to vhost_log_get()
>
> ---
>  hw/virtio/vhost.c | 50 ++++++++++++++++++++++++++++++++++++++-----------=
-
>  1 file changed, 38 insertions(+), 12 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 2c9ac79..efe2f74 100644
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
> @@ -287,6 +287,10 @@ static int vhost_set_backend_type(struct vhost_dev *=
dev,
>          r =3D -1;
>      }
>
> +    if (r =3D=3D 0) {
> +        assert(dev->vhost_ops->backend_type =3D=3D backend_type);
> +    }
> +
>      return r;
>  }
>
> @@ -319,16 +323,22 @@ static struct vhost_log *vhost_log_alloc(uint64_t s=
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
> +    assert(backend_type > VHOST_BACKEND_TYPE_NONE);
> +    assert(backend_type < VHOST_BACKEND_TYPE_MAX);
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
> @@ -340,11 +350,20 @@ static struct vhost_log *vhost_log_get(uint64_t siz=
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
> @@ -352,13 +371,13 @@ static void vhost_log_put(struct vhost_dev *dev, bo=
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
> @@ -376,7 +395,8 @@ static bool vhost_dev_log_is_shared(struct vhost_dev =
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
> @@ -2037,8 +2057,14 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIO=
Device *vdev, bool vrings)
>          uint64_t log_base;
>
>          hdev->log_size =3D vhost_get_log_size(hdev);
> -        hdev->log =3D vhost_log_get(hdev->log_size,
> +        hdev->log =3D vhost_log_get(hdev->vhost_ops->backend_type,
> +                                  hdev->log_size,
>                                    vhost_dev_log_is_shared(hdev));
> +        if (!hdev->log) {

I thought vhost_log_get couldn't return NULL :).

Other than that,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

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


