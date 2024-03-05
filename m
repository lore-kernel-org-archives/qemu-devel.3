Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913DBC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 08:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPod-0007pr-IX; Tue, 05 Mar 2024 03:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rhPoK-0007kA-82
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:06:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rhPoI-00030T-0k
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709625959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WqG4t5jEKWuqlYHjQa0n5u6ujhVRAoNrr7gCNFvqV8E=;
 b=NA2TQeJddalDBGYTqnbH4Cf2c7Q/H7IisQqEv6jdbQcrOXTVTuXT3Wu/8ca4I+b1tl/+43
 Iqq3Qu3Y4PE9hRlTQDyjjYqjorK7NwucDAEyaNvOx31kIiGzsLfblf2nWNiVKp1Zu82IsL
 fr3RRLN5TOmugQ7etmqF0B3htMN69gA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-ltNJFSGBPYq-0tuSBDVx8g-1; Tue, 05 Mar 2024 03:05:55 -0500
X-MC-Unique: ltNJFSGBPYq-0tuSBDVx8g-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-609a1063919so9263237b3.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 00:05:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709625955; x=1710230755;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WqG4t5jEKWuqlYHjQa0n5u6ujhVRAoNrr7gCNFvqV8E=;
 b=t5CP2MvSJqBF9RZ8T7Sgvrd5fxlNdICn42p5ANqkzHlBouu0/HY21Hszi/LBsFRrxS
 1yig4uWKE4APtxYvCa0FfxvtgxuabbPJhFMydqPhl3J2Im68kfHjsAUyD/+irz+9QcM7
 g92ck/U4E41yvm+U9HQqbePymnK/t/Sti2KUN0a8DOhkxMlOfiSR7K0zWlnCfgMfCKkG
 tzLadOKsNttr1tkJdxrDKZ8Ea+9D6ZTz9mYv5gYsm1t6aQcfRAqE4bigq3nPtood08Ub
 bnTMU8Mg2x3BpUfpZq79z5ZlZarNLA/R2oGnUYWq84jkC7daLjtVDgM+v+vKJ/ziFIjM
 Ny4Q==
X-Gm-Message-State: AOJu0YzrtMQVjWboQV5OtgydoBL/AA3sqMy5NNEgPqyzv851CrhAtFi1
 oLvETsEUCeyrgSqtCLYp31/SgDVjlR5N8skCpebmgu0YwQ02LyIID7rfh/2wcjsUs6brX6EVRhE
 jLZJ3w9CPZ41+2Lw22rCRqLLE5tPFg8Alig1KejH5NOSyZMNVGCV58H4aHdqV2wcY3pOJ/av/4W
 eyKHHc0JiyL9QOm6/3i+u8T5Y6qxs=
X-Received: by 2002:a81:4f58:0:b0:609:96e0:b191 with SMTP id
 d85-20020a814f58000000b0060996e0b191mr7210488ywb.17.1709625955288; 
 Tue, 05 Mar 2024 00:05:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsoFYaCvZ1T1aCReurs8/n2Kt66niavd9yP1e0ww8HRM62uCWfAFc8mvHF4fb4zbBadCq163C5R69yn7j2LgE=
X-Received: by 2002:a81:4f58:0:b0:609:96e0:b191 with SMTP id
 d85-20020a814f58000000b0060996e0b191mr7210463ywb.17.1709625955020; Tue, 05
 Mar 2024 00:05:55 -0800 (PST)
MIME-Version: 1.0
References: <20240304194612.611660-1-jonah.palmer@oracle.com>
 <20240304194612.611660-4-jonah.palmer@oracle.com>
In-Reply-To: <20240304194612.611660-4-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 5 Mar 2024 09:05:19 +0100
Message-ID: <CAJaqyWfRNP1eDfFwNwRmv4tvJeY=7dt8Om+Lv_rpmMy4XPEsaQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] virtio-mmio: Handle extra notification data
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, pasic@linux.ibm.com, 
 borntraeger@linux.ibm.com, farman@linux.ibm.com, thuth@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com, 
 cohuck@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com, 
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, virtio-fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Mar 4, 2024 at 8:46=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> Add support to virtio-mmio devices for handling the extra data sent from
> the driver to the device when the VIRTIO_F_NOTIFICATION_DATA transport
> feature has been negotiated.
>
> The extra data that's passed to the virtio-mmio device when this feature
> is enabled varies depending on the device's virtqueue layout.
>
> The data passed to the virtio-mmio device is in the same format as the
> data passed to virtio-pci devices.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/virtio/virtio-mmio.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index 22f9fbcf5a..f99d5851a2 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -248,6 +248,7 @@ static void virtio_mmio_write(void *opaque, hwaddr of=
fset, uint64_t value,
>  {
>      VirtIOMMIOProxy *proxy =3D (VirtIOMMIOProxy *)opaque;
>      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> +    uint16_t vq_idx;
>
>      trace_virtio_mmio_write_offset(offset, value);
>
> @@ -407,8 +408,12 @@ static void virtio_mmio_write(void *opaque, hwaddr o=
ffset, uint64_t value,
>          }
>          break;
>      case VIRTIO_MMIO_QUEUE_NOTIFY:
> -        if (value < VIRTIO_QUEUE_MAX) {
> -            virtio_queue_notify(vdev, value);
> +        vq_idx =3D value;
> +        if (vq_idx < VIRTIO_QUEUE_MAX) {
> +            if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA=
)) {
> +                virtio_queue_set_shadow_avail_data(vdev, value);
> +            }
> +            virtio_queue_notify(vdev, vq_idx);
>          }
>          break;
>      case VIRTIO_MMIO_INTERRUPT_ACK:
> --
> 2.39.3
>


