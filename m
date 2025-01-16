Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53D6C02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 19:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYVYr-0005Ha-NA; Thu, 16 Jan 2025 14:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tYVYp-0005HJ-DF
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 14:29:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tYVYn-0002Jw-I3
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 14:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737055783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F8mBfKthH3AZIn+e56d1JjpZaBs4s4E4omi0wk+4mcg=;
 b=V/RrG+Fr5XbcBjbo0dUtSqNkQx05rC9cDp3GC4JfJi/pxZ5aEdyY6UJre3SKQT0kBwwuKZ
 NchLwYzSQssuzgBIA8PPu4zbO6JGoHW6NSz1UrqIiJNesfJFEPLPxYT+7/kOOoSbiApeTv
 0MLhFuYKEyfThki3cK5DBGzUWubts+o=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-lF2ZKZcoMmKNkPoLWhPaPQ-1; Thu, 16 Jan 2025 14:29:42 -0500
X-MC-Unique: lF2ZKZcoMmKNkPoLWhPaPQ-1
X-Mimecast-MFC-AGG-ID: lF2ZKZcoMmKNkPoLWhPaPQ
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e5799401f12so3025512276.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 11:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737055782; x=1737660582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F8mBfKthH3AZIn+e56d1JjpZaBs4s4E4omi0wk+4mcg=;
 b=tM4BdbiEeOs+/GRp5bYj6p44Y2OJos1e+XEUh35bYDJaHk4e7zhB9u34sJ/BSJTQo0
 XeysIGXdQlgdZ07NTDm50uF+mesHtdVGLMNBQy8RtMkzJi6q6XU9le0KWIJVHb9O5z8n
 lX5+6xuwXnK6/EFCAGa1+VbStYieuEc+8q6mgrWGL9otJjy3ZJtsWTJuHaNpKFxR14zk
 8F3i6vt3DztPxoT3dKp07YbA7teb8JJPMZEDN7yQwLbAWsAItRFs79XHqAARzdTnyf8V
 u60V97ivN5/Q8WIafuusgkVm+IafFRlL309kHM+WCu4YA6nZ5IibvA7Q1edxcjlJhxBg
 3irQ==
X-Gm-Message-State: AOJu0YwTEx4u6NssdO9YSkAXb6+bOCt2llvoBOqDFIc3gb0pDFLYxwwQ
 0VTxWoFISX5aJTz2tmFylFdQhG79ghu0V5VaTClQdcclhA2WZrG4fXtSUiYdNYUQpH7IkdnpPVE
 Y/ajQN0pwJebKVMVnx/jpJhLMQzMaLBSTRNvvZeHZuwHte6xadIyhb9+sXn2RENP7kG86qMW0/W
 94my1UNQT4ehQi+wZiRHFHmq3Wb5M=
X-Gm-Gg: ASbGnctRg2+8/kWBVtElhivt+BICS4uUmhKsdy1PgVtQtRdJ0TfsyBkL4BT62iWCxRr
 OEJ/zFj+NSvcmqIqQEkJEnn/T6RzXrLFJ0fx/pQ==
X-Received: by 2002:a05:690c:6b13:b0:6ef:641a:2a73 with SMTP id
 00721157ae682-6f5312252dfmr284995147b3.9.1737055781880; 
 Thu, 16 Jan 2025 11:29:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjHmb3bodXO0W004kIgi1LwzAG/B3GAKDu2etoa+AF3T6q7Cav73CIFL88p2YBOaCijnGgoDyUaGQBdfT2KfE=
X-Received: by 2002:a05:690c:6b13:b0:6ef:641a:2a73 with SMTP id
 00721157ae682-6f5312252dfmr284994917b3.9.1737055781581; Thu, 16 Jan 2025
 11:29:41 -0800 (PST)
MIME-Version: 1.0
References: <20250110170837.2747532-1-jonah.palmer@oracle.com>
 <20250110170837.2747532-6-jonah.palmer@oracle.com>
In-Reply-To: <20250110170837.2747532-6-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 16 Jan 2025 20:29:05 +0100
X-Gm-Features: AbW1kvZ6UA0bEyD2qvwMJYyoWYsmz0YkX_t-3GlYsD9TrSoarME7BQorwCDFmro
Message-ID: <CAJaqyWdxTQ22z17Niw=1dPCL4JX551EMXVkNSbyDO7edeHZm+A@mail.gmail.com>
Subject: Re: [RFC v3 5/5] svq: Support translations via GPAs in
 vhost_svq_translate_addr
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com, 
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Jan 10, 2025 at 6:09=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> Propagates the GPAs (in_xlat_addr/out_xlat_addr) of a VirtQueueElement
> to vhost_svq_translate_addr() to translate to IOVAs via GPA->IOVA tree
> when descriptors are backed by guest memory.
>
> For descriptors backed by guest memory, the translation is performed
> using GPAs via the GPA->IOVA tree. GPAs are unique in the guest's
> address space, so this ensures unambiguous IOVA translations.
>
> For descriptors not backed by guest memory, the existing IOVA->HVA tree
> is used.
>
> This avoids the issue where different GPAs map to the same HVA, causing
> the HVA->IOVA translation to potentially return an IOVA associated with
> the wrong intended GPA.
>

If SVQ is the only one needing xlat_addrs we can create a new
SVQElement, following the code of VirtIOBlockReq or VirtIOSCSIReq for
example.

But why do we need it? As long as svq->desc_state[qemu_head].elem !=3D
NULL the GPA is elem->in_addr or elem->out_addr, and we can use that
to look into the GPA tree, isn't it? If we don't have any elem, then
we need to go with "old" HVA -> IOVA lookup.

> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/virtio/vhost-shadow-virtqueue.c | 49 ++++++++++++++++++++++--------
>  1 file changed, 37 insertions(+), 12 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index 37aca8b431..be0db94ab7 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -78,24 +78,37 @@ uint16_t vhost_svq_available_slots(const VhostShadowV=
irtqueue *svq)
>   * @vaddr: Translated IOVA addresses
>   * @iovec: Source qemu's VA addresses
>   * @num: Length of iovec and minimum length of vaddr
> + * @gpas: Descriptors' GPAs, if backed by guest memory
>   */
>  static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
>                                       hwaddr *addrs, const struct iovec *=
iovec,
> -                                     size_t num)
> +                                     size_t num, const hwaddr *gpas)
>  {
>      if (num =3D=3D 0) {
>          return true;
>      }
>
>      for (size_t i =3D 0; i < num; ++i) {
> -        DMAMap needle =3D {
> -            .translated_addr =3D (hwaddr)(uintptr_t)iovec[i].iov_base,
> -            .size =3D iovec[i].iov_len,
> -        };
> +        const DMAMap *map;
> +        DMAMap needle;
>          Int128 needle_last, map_last;
>          size_t off;
>
> -        const DMAMap *map =3D vhost_iova_tree_find_iova(svq->iova_tree, =
&needle);
> +        if (gpas) {
> +            /* Search the GPA->IOVA tree */
> +            needle =3D (DMAMap) {
> +                .translated_addr =3D gpas[i],
> +                .size =3D iovec[i].iov_len,
> +            };
> +            map =3D vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
> +        } else {
> +            /* Searh the IOVA->HVA tree */
> +            needle =3D (DMAMap) {
> +                .translated_addr =3D (hwaddr)(uintptr_t)iovec[i].iov_bas=
e,
> +                .size =3D iovec[i].iov_len,
> +            };
> +            map =3D vhost_iova_tree_find_iova(svq->iova_tree, &needle);
> +        }
>          /*
>           * Map cannot be NULL since iova map contains all guest space an=
d
>           * qemu already has a physical address mapped
> @@ -132,12 +145,14 @@ static bool vhost_svq_translate_addr(const VhostSha=
dowVirtqueue *svq,
>   * @num: iovec length
>   * @more_descs: True if more descriptors come in the chain
>   * @write: True if they are writeable descriptors
> + * @gpas: Descriptors' GPAs, if backed by guest memory
>   *
>   * Return true if success, false otherwise and print error.
>   */
>  static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwadd=
r *sg,
>                                          const struct iovec *iovec, size_=
t num,
> -                                        bool more_descs, bool write)
> +                                        bool more_descs, bool write,
> +                                        const hwaddr *gpas)
>  {
>      uint16_t i =3D svq->free_head, last =3D svq->free_head;
>      unsigned n;
> @@ -149,7 +164,7 @@ static bool vhost_svq_vring_write_descs(VhostShadowVi=
rtqueue *svq, hwaddr *sg,
>          return true;
>      }
>
> -    ok =3D vhost_svq_translate_addr(svq, sg, iovec, num);
> +    ok =3D vhost_svq_translate_addr(svq, sg, iovec, num, gpas);
>      if (unlikely(!ok)) {
>          return false;
>      }
> @@ -175,7 +190,8 @@ static bool vhost_svq_vring_write_descs(VhostShadowVi=
rtqueue *svq, hwaddr *sg,
>  static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
>                                  const struct iovec *out_sg, size_t out_n=
um,
>                                  const struct iovec *in_sg, size_t in_num=
,
> -                                unsigned *head)
> +                                unsigned *head, const hwaddr *in_gpas,
> +                                const hwaddr *out_gpas)
>  {
>      unsigned avail_idx;
>      vring_avail_t *avail =3D svq->vring.avail;
> @@ -192,12 +208,13 @@ static bool vhost_svq_add_split(VhostShadowVirtqueu=
e *svq,
>      }
>
>      ok =3D vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, in_num=
 > 0,
> -                                     false);
> +                                     false, out_gpas);
>      if (unlikely(!ok)) {
>          return false;
>      }
>
> -    ok =3D vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, false, t=
rue);
> +    ok =3D vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, false, t=
rue,
> +                                     in_gpas);
>      if (unlikely(!ok)) {
>          return false;
>      }
> @@ -253,12 +270,20 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const =
struct iovec *out_sg,
>      unsigned qemu_head;
>      unsigned ndescs =3D in_num + out_num;
>      bool ok;
> +    hwaddr *in_gpas =3D NULL;
> +    hwaddr *out_gpas =3D NULL;
>
>      if (unlikely(ndescs > vhost_svq_available_slots(svq))) {
>          return -ENOSPC;
>      }
>
> -    ok =3D vhost_svq_add_split(svq, out_sg, out_num, in_sg, in_num, &qem=
u_head);
> +    if (elem) {
> +        in_gpas =3D elem->in_xlat_addr;
> +        out_gpas =3D elem->out_xlat_addr;
> +    }
> +
> +    ok =3D vhost_svq_add_split(svq, out_sg, out_num, in_sg, in_num, &qem=
u_head,
> +                             in_gpas, out_gpas);
>      if (unlikely(!ok)) {
>          return -EINVAL;
>      }
> --
> 2.43.5
>


