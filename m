Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1E3E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 08:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKw18-00046X-LD; Tue, 10 Dec 2024 03:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tKw11-00043K-Ei
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 03:54:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tKw0y-0004Mb-Jl
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 03:54:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733820882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Na0n1pyXMzM8vkEJwHPB0ApzjRCc8YWIk+mqsy2ku6Y=;
 b=Qc5n2OcZaCXYa0FwA5/dcJ4mvtWsRGeASDccV8c/h9VT22h7Yty9gOUL7W/nW2hkYtM2rc
 eiMNxG4lls0zvM36zUD0NJaiH/EVcju/qi1v7bODy5f+0E6rQrJjom6DOF+U+a1HC841np
 x3vpd/y6xQGKOdKGgvML8jWufe+NYSA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-W6ZsYBLjMreFTpB1pzX55A-1; Tue, 10 Dec 2024 03:54:40 -0500
X-MC-Unique: W6ZsYBLjMreFTpB1pzX55A-1
X-Mimecast-MFC-AGG-ID: W6ZsYBLjMreFTpB1pzX55A
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6efe45a2405so55524137b3.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 00:54:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733820879; x=1734425679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Na0n1pyXMzM8vkEJwHPB0ApzjRCc8YWIk+mqsy2ku6Y=;
 b=wLQVK246sIROPNSLeHQReKAQp7b57aewRfXLZCko/m80PlCjIj0Enj/aei1TkLYiA6
 TtwcDBbWbyaTiiZOhxGQGJM4nO93JttKvjq6S44b9V01lrq8bpEVU63/bwsWxhvIr7Mr
 XWK73bh1h5ep4vOdl0mMCYl2NenupL9ohldR/wCETg6NDfcmZBw9Najvh1PvJa3aF3cE
 IGYsTYvHUrWpN3aEnV2DHH0yhq3eXyn0iOycB7pjHOY5v156hqKECB5LKGExRllUX5PU
 RAWAf4q4hgzUOy15s/YoVATIIBYdTY4CZr/dpFBi5wzaGKpuNUrCNDktNa3R0dVfIzQZ
 5g9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtcw59+Y0O8dpmFITCUYK4sDq2IgMqec+zLeC6mlQlCeP7yUvVXZ5yb9mmy6S/bZe12s/10Fw8C4PF@nongnu.org
X-Gm-Message-State: AOJu0YzmYK0mwIkFav7DyOGYeKlKRaYdHqHMsR6SAJAedsBQ/BBpHnBC
 XhOMl7ej7HZofXyWdSGZlVpYoyDwKYwn5EbGScb4G+7q4PJq7DCj5TrCVo84CUrCGksAcOf+QE/
 rvUksjxQ0d/0NtvEjY/4/WZAx7ajGUgC2c/1XFazJsgfSoi2sDOOPJ9MmhG4Zz+SGQsCprpNcGo
 qq1BmNbVm8yY5Mt5xye6pJP9tOpt4=
X-Gm-Gg: ASbGncvmHw6Y9UN6RG89qVCJUTY2taYIqncA5LCcXAdMldFXYh/huMChknLv5vtF05R
 htsajeSZKduGk6LBZjVI2aE9sTDQHJKXVdq8=
X-Received: by 2002:a05:690c:700e:b0:6ef:7dde:bdef with SMTP id
 00721157ae682-6f022ed35a0mr36190127b3.23.1733820879523; 
 Tue, 10 Dec 2024 00:54:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwsL55Za5G/AibX9klkSCA45XI87mFjZzHSQP193vK70GIBEI3VLsRSruTDzNPcwYLRZPM3p4PtW0zFpgSYwA=
X-Received: by 2002:a05:690c:700e:b0:6ef:7dde:bdef with SMTP id
 00721157ae682-6f022ed35a0mr36190067b3.23.1733820879249; Tue, 10 Dec 2024
 00:54:39 -0800 (PST)
MIME-Version: 1.0
References: <20241205203430.76251-1-sahilcdq@proton.me>
 <20241205203430.76251-3-sahilcdq@proton.me>
In-Reply-To: <20241205203430.76251-3-sahilcdq@proton.me>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 10 Dec 2024 09:54:03 +0100
Message-ID: <CAJaqyWchuA__QeFVCgozSJGQdLfhGD97x6vm3zRiuM=8q+tm-w@mail.gmail.com>
Subject: Re: [RFC v4 2/5] vhost: Write descriptors to packed svq
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Dec 5, 2024 at 9:35=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.com>=
 wrote:
>
> This commit is the first in a series to add support for packed
> virtqueues in vhost_shadow_virtqueue.
>
> This patch implements the insertion of available buffers in the
> descriptor area. It takes into account descriptor chains, but does
> not consider indirect descriptors.
>
> Also validate svq-specific features that vdpa supports.
>
> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> ---
> Changes v3 -> v4:
> - Split commit #1 in v3 into 2 commits.
> - vhost-shadow-virtqueue.c
>   (vhost_svq_valid_features): Add enums.
>
>  hw/virtio/vhost-shadow-virtqueue.c | 83 +++++++++++++++++++++++++++++-
>  1 file changed, 81 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index bb7cf6d5db..6eee01ab3c 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -33,6 +33,9 @@ bool vhost_svq_valid_features(uint64_t features, Error =
**errp)
>           ++b) {
>          switch (b) {
>          case VIRTIO_F_ANY_LAYOUT:
> +        case VIRTIO_F_RING_PACKED:
> +        case VIRTIO_F_RING_RESET:
> +        case VIRTIO_RING_F_INDIRECT_DESC:
>          case VIRTIO_RING_F_EVENT_IDX:

This is good, but it should be added in the last commit. Otherwise
we're enabling packed vq without the code to handle it.

The rest looks good to me.

>              continue;
>
> @@ -178,7 +181,78 @@ static void vhost_svq_add_split(VhostShadowVirtqueue=
 *svq,
>      /* Update the avail index after write the descriptor */
>      smp_wmb();
>      avail->idx =3D cpu_to_le16(svq->shadow_avail_idx);
> +}
>
> +/**
> + * Write descriptors to SVQ packed vring
> + *
> + * @svq: The shadow virtqueue
> + * @out_sg: The iovec to the guest
> + * @out_num: Outgoing iovec length
> + * @in_sg: The iovec from the guest
> + * @in_num: Incoming iovec length
> + * @sgs: Cache for hwaddr
> + * @head: Saves current free_head
> + */
> +static void vhost_svq_add_packed(VhostShadowVirtqueue *svq,
> +                                const struct iovec *out_sg, size_t out_n=
um,
> +                                const struct iovec *in_sg, size_t in_num=
,
> +                                hwaddr *sgs, unsigned *head)
> +{
> +    uint16_t id, curr, i, head_flags =3D 0;
> +    size_t num =3D out_num + in_num;
> +    unsigned n;
> +
> +    struct vring_packed_desc *descs =3D svq->vring_packed.vring.desc;
> +
> +    *head =3D svq->vring_packed.next_avail_idx;
> +    i =3D *head;
> +    id =3D svq->free_head;
> +    curr =3D id;
> +
> +    /* Write descriptors to SVQ packed vring */
> +    for (n =3D 0; n < num; n++) {
> +        uint16_t flags =3D cpu_to_le16(svq->vring_packed.avail_used_flag=
s |
> +                                     (n < out_num ? 0 : VRING_DESC_F_WRI=
TE) |
> +                                     (n + 1 =3D=3D num ? 0 : VRING_DESC_=
F_NEXT));
> +        if (i =3D=3D *head) {
> +            head_flags =3D flags;
> +        } else {
> +            descs[i].flags =3D flags;
> +        }
> +
> +        descs[i].addr =3D cpu_to_le64(sgs[n]);
> +        descs[i].id =3D id;
> +        if (n < out_num) {
> +            descs[i].len =3D cpu_to_le32(out_sg[n].iov_len);
> +        } else {
> +            descs[i].len =3D cpu_to_le32(in_sg[n - out_num].iov_len);
> +        }
> +
> +        curr =3D cpu_to_le16(svq->desc_next[curr]);
> +
> +        if (++i >=3D svq->vring_packed.vring.num) {
> +            i =3D 0;
> +            svq->vring_packed.avail_used_flags ^=3D
> +                    1 << VRING_PACKED_DESC_F_AVAIL |
> +                    1 << VRING_PACKED_DESC_F_USED;
> +        }
> +    }
> +
> +    if (i <=3D *head) {
> +        svq->vring_packed.avail_wrap_counter ^=3D 1;
> +    }
> +
> +    svq->vring_packed.next_avail_idx =3D i;
> +    svq->free_head =3D curr;
> +
> +    /*
> +     * A driver MUST NOT make the first descriptor in the list
> +     * available before all subsequent descriptors comprising
> +     * the list are made available.
> +     */
> +    smp_wmb();
> +    svq->vring_packed.vring.desc[*head].flags =3D head_flags;
>  }
>
>  static void vhost_svq_kick(VhostShadowVirtqueue *svq)
> @@ -240,8 +314,13 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const s=
truct iovec *out_sg,
>          return -EINVAL;
>      }
>
> -    vhost_svq_add_split(svq, out_sg, out_num, in_sg,
> -                        in_num, sgs, &qemu_head);
> +    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)) {
> +        vhost_svq_add_packed(svq, out_sg, out_num, in_sg,
> +                             in_num, sgs, &qemu_head);
> +    } else {
> +        vhost_svq_add_split(svq, out_sg, out_num, in_sg,
> +                            in_num, sgs, &qemu_head);
> +    }
>
>      svq->num_free -=3D ndescs;
>      svq->desc_state[qemu_head].elem =3D elem;
> --
> 2.47.0
>


