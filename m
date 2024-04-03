Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0599ACD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 10:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrxiW-0005Dz-IN; Wed, 03 Apr 2024 06:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rrxiS-00059R-70
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 06:19:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rrxiQ-00070m-88
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 06:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712139573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iMLbgUGtw/LVyRlI2BcEZJWtW3QAwcebOn57SCM4cv8=;
 b=A8KeVvrMgRiyAP754WSEDl7zhvk4/5kp6gSxi/bHSCRP6uCvvO/be56sPgmyKc+wSHbeVC
 HqYGytEKtp979eq6UgFdRq4PErugPWh51mZq9qNmS27A8uztr8Kv93qENA8sMsqRj9SHe+
 sP7d/D4UyWMjC4j6jp/ec1NmatOhhu8=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-wNSOfmFmM0GbzNNpn3txHQ-1; Wed, 03 Apr 2024 06:19:31 -0400
X-MC-Unique: wNSOfmFmM0GbzNNpn3txHQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-ddaf2f115f2so8385378276.3
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 03:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712139571; x=1712744371;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iMLbgUGtw/LVyRlI2BcEZJWtW3QAwcebOn57SCM4cv8=;
 b=MiKyzc8jkQFpVXCqoF9Hq5E3HRehn8YcmObSYVxWDiUX+OjPGj0gAb16cZqwoxTK+F
 t3qusa9RosmeLA9zO5el4HD7cQEp5JZK4jyeV5D5/CMV3QrD7CaMvvXOmjqPe+MaZrqv
 UGRtUuxCnn5YTXE3TdatSJPvtT3Ck1vuwRxycU18w3sBFPQSwp7MUSPCsBlOc5WANCZ5
 wJI3FzFSZ1uJTutRCdqskZTyR9WNjpyXA0ggeEu/eOktcEQJkSlWFEHn1jGurjcJBAx9
 TuRWz4DryusHCmGzz1nkzOKI3C7X4otJlmuKyumw4R6J5MV3EDWnSpaFAylGMvYt5bL0
 g4TA==
X-Gm-Message-State: AOJu0YwyVpFdtzL9RdpXYO5V1i6+CJe0ksUmXEoC1XqeL2Ra7/N75Jqb
 DoRYLGDNzlY9KCScUQnijK2FdkW2eyY7v6ihB767dQPRc0l7jBVQnJMLRMrAwcyV1ysyw4wzRt1
 jR0ukG1cVcvfXl+kUAwYZtleae7PGoLxlC42lmRwT4EP0yRmQOetAICWGROpsKGDsLTb4xwtxgp
 ZaE4be8Ml2KcwImnmCdp18pC+DEbQ=
X-Received: by 2002:a25:bcca:0:b0:dcc:3020:e68 with SMTP id
 l10-20020a25bcca000000b00dcc30200e68mr11442884ybm.64.1712139570897; 
 Wed, 03 Apr 2024 03:19:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1pbpDKhYXQOe3zZv/yIiBMp0aLzykqZY7QDBxwg2EqhK34VOkEOCvEtBzx2zePFFuXoiqJpiXO677UQJcE+A=
X-Received: by 2002:a25:bcca:0:b0:dcc:3020:e68 with SMTP id
 l10-20020a25bcca000000b00dcc30200e68mr11442870ybm.64.1712139570604; Wed, 03
 Apr 2024 03:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240328162203.3775114-1-jonah.palmer@oracle.com>
 <20240328162203.3775114-2-jonah.palmer@oracle.com>
In-Reply-To: <20240328162203.3775114-2-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Apr 2024 12:18:54 +0200
Message-ID: <CAJaqyWdyZdu48+cZ2umafLRi9NTz3YHxSxmyq6SD9d4noTR2jQ@mail.gmail.com>
Subject: Re: [RFC v2 1/5] virtio: Initialize sequence variables
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, 
 fam@euphon.net, stefanha@redhat.com, qemu-block@nongnu.org, 
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Mar 28, 2024 at 5:22=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> Initialize sequence variables for VirtQueue and VirtQueueElement
> structures. A VirtQueue's sequence variables are initialized when a
> VirtQueue is being created or reset. A VirtQueueElement's sequence
> variable is initialized when a VirtQueueElement is being initialized.
> These variables will be used to support the VIRTIO_F_IN_ORDER feature.
>
> A VirtQueue's used_seq_idx represents the next expected index in a
> sequence of VirtQueueElements to be processed (put on the used ring).
> The next VirtQueueElement added to the used ring must match this
> sequence number before additional elements can be safely added to the
> used ring. It's also particularly useful for helping find the number of
> new elements added to the used ring.
>
> A VirtQueue's current_seq_idx represents the current sequence index.
> This value is essentially a counter where the value is assigned to a new
> VirtQueueElement and then incremented. Given its uint16_t type, this
> sequence number can be between 0 and 65,535.
>
> A VirtQueueElement's seq_idx represents the sequence number assigned to
> the VirtQueueElement when it was created. This value must match with the
> VirtQueue's used_seq_idx before the element can be put on the used ring
> by the device.
>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/virtio/virtio.c         | 18 ++++++++++++++++++
>  include/hw/virtio/virtio.h |  1 +
>  2 files changed, 19 insertions(+)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index fb6b4ccd83..069d96df99 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -132,6 +132,10 @@ struct VirtQueue
>      uint16_t used_idx;
>      bool used_wrap_counter;
>
> +    /* In-Order sequence indices */
> +    uint16_t used_seq_idx;
> +    uint16_t current_seq_idx;
> +

I'm having a hard time understanding the difference between these and
last_avail_idx and used_idx. It seems to me if we replace them
everything will work? What am I missing?

>      /* Last used index value we have signalled on */
>      uint16_t signalled_used;
>
> @@ -1621,6 +1625,11 @@ static void *virtqueue_split_pop(VirtQueue *vq, si=
ze_t sz)
>          elem->in_sg[i] =3D iov[out_num + i];
>      }
>
> +    /* Assign sequence index for in-order processing */
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
> +        elem->seq_idx =3D vq->current_seq_idx++;
> +    }
> +
>      vq->inuse++;
>
>      trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
> @@ -1760,6 +1769,11 @@ static void *virtqueue_packed_pop(VirtQueue *vq, s=
ize_t sz)
>      vq->shadow_avail_idx =3D vq->last_avail_idx;
>      vq->shadow_avail_wrap_counter =3D vq->last_avail_wrap_counter;
>
> +    /* Assign sequence index for in-order processing */
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
> +        elem->seq_idx =3D vq->current_seq_idx++;
> +    }
> +
>      trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
>  done:
>      address_space_cache_destroy(&indirect_desc_cache);
> @@ -2087,6 +2101,8 @@ static void __virtio_queue_reset(VirtIODevice *vdev=
, uint32_t i)
>      vdev->vq[i].notification =3D true;
>      vdev->vq[i].vring.num =3D vdev->vq[i].vring.num_default;
>      vdev->vq[i].inuse =3D 0;
> +    vdev->vq[i].used_seq_idx =3D 0;
> +    vdev->vq[i].current_seq_idx =3D 0;
>      virtio_virtqueue_reset_region_cache(&vdev->vq[i]);
>  }
>
> @@ -2334,6 +2350,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int=
 queue_size,
>      vdev->vq[i].vring.align =3D VIRTIO_PCI_VRING_ALIGN;
>      vdev->vq[i].handle_output =3D handle_output;
>      vdev->vq[i].used_elems =3D g_new0(VirtQueueElement, queue_size);
> +    vdev->vq[i].used_seq_idx =3D 0;
> +    vdev->vq[i].current_seq_idx =3D 0;
>
>      return &vdev->vq[i];
>  }
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index b3c74a1bca..910b2a3427 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -75,6 +75,7 @@ typedef struct VirtQueueElement
>      hwaddr *out_addr;
>      struct iovec *in_sg;
>      struct iovec *out_sg;
> +    uint16_t seq_idx;
>  } VirtQueueElement;
>
>  #define VIRTIO_QUEUE_MAX 1024
> --
> 2.39.3
>


