Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CB2C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 10:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwfdc-0008SA-RV; Tue, 16 Apr 2024 06:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwfdS-0008KN-9K
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 06:01:55 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwfdP-0006vZ-LE
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 06:01:53 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56e56ee8d5cso5388474a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 03:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713261708; x=1713866508; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p9jJyc/K8buPW/8td9T3xkqrOfd+jk9vWaohElDiKdQ=;
 b=WH0GVmJyBO8NT7Z2wBYhkAme+kqwH5uWo0h22kk6d58PkIgjLQm2j6VbGr/NXMXl/B
 taTufOI0hc3MZqMr8b//WAQrnwBdg2JhVToDd8ywoWFh9Hg0gexjMenHYe8onbNkiW/W
 NBpIhXe2Z7xIWobzhfpvEU0zRY8AcGrt8zL1j4EI5bfXIbAsN3QkU1tDE140KqW1wAax
 Sf8Lkh24gEQHreTic5BuejH7wQnAaz4PZKA5eYLmoXB2fddldXZKYwdN7mkyYhqUHoX6
 1r3exg7ux1HP3DjCxFdzbVUHCEMmKDJzKDLLqnh0j0p9JO4oV0YCugJ27VCyaHI3vAhI
 qcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713261708; x=1713866508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p9jJyc/K8buPW/8td9T3xkqrOfd+jk9vWaohElDiKdQ=;
 b=uGdcdnRSPMVgCWvGRRbWFGKeo7ZsQ6AfoRiZyxf3hQ68UpYbivU/nC0gA9YUD+sKRa
 sW6uWCWXPPgUHuzfU6M2wOC6K65we/BO4E/Tka+5+b88VeCUGjU7+jn4LWJDgTMPGrB8
 PnXZkU1tHV7TALawKNBpp+1onYptq5gxveMHV18zVekKHpIOI/PFEG8H+jzpuirQGuau
 dewJ7c+CCaUF4jICbn+jUe3sRJO1mlkjeer+kcS/0xvJCQw/QP7hs8txPj/cHhW/cpQG
 EEatsPuaQL0EpGrUoFi+GMNgJ6yDJwUlLpsx74cCdqo8dlH7GE6RmdQDMfEMYwnVd96A
 wo8Q==
X-Gm-Message-State: AOJu0Ywj8zI7pZbc0Tg8VzwLxt+bEZ4LnvAl3+Un/4jmUIZjhMCnKpZH
 j7VSdD+9ylwczfBBMNA5bbNcaDePWkPCEUzmZG1YXzWpERETgS6Pvcw9OtDq12nLWvtpyZFvYn5
 IxMcEZfYIN8AcV7vz6yVt66oxODgdIg3HfK4V1g==
X-Google-Smtp-Source: AGHT+IGNfulkCc3pyS7dJNSaCexDXpoMFYe0hZBVRaXeWe3/VJ7BdKk1NiH7ZUbwk3YYZT+ICnhgXR+p6tke8nKQMJ4=
X-Received: by 2002:a50:875d:0:b0:56e:2bfa:c7e0 with SMTP id
 29-20020a50875d000000b0056e2bfac7e0mr8706742edv.13.1713261708149; Tue, 16 Apr
 2024 03:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1713178348.git.mst@redhat.com>
 <2ce6cff94df2650c460f809e5ad263f1d22507c0.1713178348.git.mst@redhat.com>
In-Reply-To: <2ce6cff94df2650c460f809e5ad263f1d22507c0.1713178348.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2024 11:01:36 +0100
Message-ID: <CAFEAcA9Hs+05ux3SkJqZQ5RyAkwbgmDGMm5gn+GYZL76CJCYkQ@mail.gmail.com>
Subject: Re: [PULL 1/1] virtio-pci: fix use of a released vector
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Cindy Lu <lulu@redhat.com>, qemu-stable@nongnu.org, 
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 15 Apr 2024 at 11:52, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Cindy Lu <lulu@redhat.com>
>
> During the booting process of the non-standard image, the behavior of the
> called function in qemu is as follows:
>
> 1. vhost_net_stop() was triggered by guest image. This will call the func=
tion
> virtio_pci_set_guest_notifiers() with assgin=3D false,
> virtio_pci_set_guest_notifiers(=EF=BC=89 will release the irqfd for vecto=
r 0
>
> 2. virtio_reset() was triggered, this will set configure vector to VIRTIO=
_NO_VECTOR
>
> 3.vhost_net_start() was called (at this time, the configure vector is
> still VIRTIO_NO_VECTOR) and then call virtio_pci_set_guest_notifiers() wi=
th
> assgin=3Dtrue, so the irqfd for vector 0 is still not "init" during this =
process
>
> 4. The system continues to boot and sets the vector back to 0. After that
> msix_fire_vector_notifier() was triggered to unmask the vector 0 and  mee=
t the crash
>
> To fix the issue, we need to support changing the vector after VIRTIO_CON=
FIG_S_DRIVER_OK is set.
>

Hi; Coverity points out what it thinks is a problem in this commit
(CID 1543938):

> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index cb6940fc0e..cb159fd078 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1424,6 +1424,38 @@ static int virtio_pci_add_mem_cap(VirtIOPCIProxy *=
proxy,
>      return offset;
>  }
>
> +static void virtio_pci_set_vector(VirtIODevice *vdev,
> +                                  VirtIOPCIProxy *proxy,
> +                                  int queue_no, uint16_t old_vector,
> +                                  uint16_t new_vector)
> +{
> +    bool kvm_irqfd =3D (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +        msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabled();
> +
> +    if (new_vector =3D=3D old_vector) {
> +        return;
> +    }
> +
> +    /*
> +     * If the device uses irqfd and the vector changes after DRIVER_OK i=
s
> +     * set, we need to release the old vector and set up the new one.
> +     * Otherwise just need to set the new vector on the device.
> +     */
> +    if (kvm_irqfd && old_vector !=3D VIRTIO_NO_VECTOR) {
> +        kvm_virtio_pci_vector_release_one(proxy, queue_no);
> +    }
> +    /* Set the new vector on the device. */
> +    if (queue_no =3D=3D VIRTIO_CONFIG_IRQ_IDX) {
> +        vdev->config_vector =3D new_vector;
> +    } else {
> +        virtio_queue_set_vector(vdev, queue_no, new_vector);
> +    }

Here queue_no can be VIRTIO_CONFIG_IRQ_IDX, which is -1.

> +    /* If the new vector changed need to set it up. */
> +    if (kvm_irqfd && new_vector !=3D VIRTIO_NO_VECTOR) {
> +        kvm_virtio_pci_vector_use_one(proxy, queue_no);

Here we pass that through to kvm_virtio_pci_vector_use_one().
In kvm_virtio_pci_vector_use_one()'s error-exit path ("undo")
it does
    vector =3D virtio_queue_vector(vdev, queue_no);
and in virtio_queue_vector() it does:

    return n < VIRTIO_QUEUE_MAX ? vdev->vq[n].vector :
        VIRTIO_NO_VECTOR;

where 'n' is an int, so if we can get here with queue_no being
VIRTIO_CONFIG_IRQ_IDX then we'll index off the front of the
vdev->vq[] array.

Maybe this is a "can't happen" case, but it does seem odd that
virtio_queue_vector() only bounds-checks the "too big" case
for its argument and not the "too small" case and/or it
doesn't have a special case for VIRTIO_CONFIG_IRQ_IDX.

> +    }
> +}
> +

thanks
-- PMM

